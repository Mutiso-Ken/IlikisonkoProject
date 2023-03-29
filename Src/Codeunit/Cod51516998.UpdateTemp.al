#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 51516998 "UpdateTemp"
{

    trigger OnRun()
    begin
        UpdateValues();
        //UpdateLoans();
    end;

    var
        GenJournalLine: Record "Gen. Journal Line";
        MemberRegister: Record "Member Register";
        TempMembers: Record "Temp Members";
        SaccoGeneralSetUp: Record "Sacco No. Series";
        NewMembNo: Text[30];
        User: Record User;
        BCode: Code[20];
        ProgressWindow: Dialog;
        Ct: Integer;
        LoansTemp: Record "Loans Temp";
        LoansRegister: Record "Loans Register";

    local procedure UpdateValues()
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
         GenJournalLine.Reset;
         GenJournalLine.SetFilter("Migration ID",'<>%1',0);
         if GenJournalLine.Find('-') then begin
           repeat
           MemberRegister.Reset;
           MemberRegister.SetFilter("Unique Id",Format(GenJournalLine."Migration ID"));
           if MemberRegister.Find('-') then begin
             GenJournalLine."Account No.":=MemberRegister."No.";
             GenJournalLine.Modify(true);
           end;
           until GenJournalLine.Next=0
         end;
         Message('Test');
        //
        // MemberRegister.RESET;
        // MemberRegister.SETFILTER("No.",'<>%1','');
        // IF MemberRegister.FIND('-') THEN BEGIN
        //  REPEAT
        //   MemberRegister.DELETE;
        //  UNTIL MemberRegister.NEXT=0;
        // END;
        // TempMembers.RESET;
        // TempMembers.SETFILTER(ID,'<>%1',0);
        // IF TempMembers.FIND('-') THEN BEGIN
        //  ProgressWindow.OPEN('Processing account number #1#######');
        //  Ct:=0;
        //  REPEAT
        //    Ct:=Ct+1;
        //ProgressWindow.UPDATE(1,Ct);
        //     NewMembNo:='';
        //     SaccoGeneralSetUp.GET();
        //     NewMembNo:='ILK'+SaccoGeneralSetUp.BosaNumber;
        //
        //     MemberRegister.INIT;
        //     MemberRegister."No.":=NewMembNo;
        //     MemberRegister."Old Account No.":=TempMembers."Old No";
        //     MemberRegister.Name:=TempMembers.Name;
        //     MemberRegister.Address:=TempMembers.Address;
        //     MemberRegister.City:=TempMembers.City;
        //    // MemberRegister."Mobile Phone No":=TempMembers.Phone;
        //     MemberRegister."Global Dimension 2 Code":=TempMembers.Branch;
        //     MemberRegister."Customer Posting Group":=TempMembers."Posting Group";
        //     MemberRegister.County:=TempMembers.county;
        //     MemberRegister."E-Mail (Personal)":=TempMembers.Email;
        //     MemberRegister."Registration Date":=TempMembers."Reg date";
        //     MemberRegister.Status:=TempMembers.Status;
        //     MemberRegister."Employer Code":=TempMembers."employer code";
        //     MemberRegister."Date of Birth":=TempMembers.DOB;
        //     IF TempMembers."Marital Status"=TempMembers."Marital Status"::Widowed THEN
        //     MemberRegister."Marital Status":=TempMembers."Marital Status"::Widowed
        //     ELSE
        //     MemberRegister."Marital Status":=TempMembers."Marital Status";
        //     MemberRegister.Gender:=TempMembers.Gender;
        //     MemberRegister.Region:=TempMembers.Region;
        //     MemberRegister.INSERT(TRUE);
        //     SaccoGeneralSetUp.BosaNumber:=INCSTR(SaccoGeneralSetUp.BosaNumber);
        //     SaccoGeneralSetUp.MODIFY;
        //  UNTIL TempMembers.NEXT=0;
        //  ProgressWindow.CLOSE;
        // END;
    end;

    local procedure UpdateLoans()
    begin
        /*LoansTemp.RESET;
        LoansTemp.SETFILTER("Member ID",'<>%1',0);
        IF LoansTemp.FIND('-') THEN BEGIN
          ProgressWindow.OPEN('Inserting record #1#######');
         Ct:=0;
        REPEAT
          Ct:=Ct+1;
          ProgressWindow.UPDATE(1,Ct);
        //  IF LoansTemp."Loan Product Type"='NORMAL LOAN' THEN
        //    LoansTemp."Loan Product Type":='DEVELOPMENT';
        //
        //  IF LoansTemp."Loan Product Type"='EMERGENCY LOAN' THEN
        //    LoansTemp."Loan Product Type":='EMERGENCY';
        //
        //  IF LoansTemp."Loan Product Type"='GROUP LOAN' THEN
        //    LoansTemp."Loan Product Type":='DIRECT CO-OP';
        //
        //  IF LoansTemp."Loan Product Type"='INSTITUTIONAL LOAN' THEN
        //    LoansTemp."Loan Product Type":='DIRECT CO-OP';
        //
        //  IF LoansTemp."Loan Product Type"='RENTAL LOAN' THEN
        //    LoansTemp."Loan Product Type":='RENTAL';
        //
        //  IF LoansTemp."Loan Product Type"='SCHOOL FEES' THEN
        //    LoansTemp."Loan Product Type":='SCHFEES';
        //
        //  LoansTemp.MODIFY();
        
        LoansRegister.INIT;
        LoansRegister."Loan  No.":=LoansTemp."Loan No";
        LoansRegister."Client Code":=GetMemberNo(LoansTemp."Member ID");
        LoansRegister."Application Date":=LoansTemp."Application Date";
        LoansRegister."Loan Product Type":=LoansTemp."Loan Product Type";
        LoansRegister.Installments:=LoansTemp.Installments;
        LoansRegister."Requested Amount":=LoansTemp."Requested amount";
        LoansRegister."Approved Amount":=LoansTemp."Approved Amount";
        LoansRegister."Issued Date":=LoansTemp."Issued Date";
        LoansRegister."Amount Disbursed":=LoansTemp."Amount Disbursed";
        
        IF LoansTemp."Loans Category"='Performing' THEN
         LoansRegister."Loans Category":= LoansRegister."Loans Category"::Perfoming;
        
        IF LoansTemp."Loans Category"='' THEN
         LoansRegister."Loans Category":= LoansRegister."Loans Category"::Perfoming;
        
        IF LoansTemp."Loans Category"='Substandard' THEN
         LoansRegister."Loans Category":= LoansRegister."Loans Category"::Substandard;
        
        IF LoansTemp."Loans Category"='Doubtful' THEN
         LoansRegister."Loans Category":= LoansRegister."Loans Category"::Doubtful;
        
        IF LoansTemp."Loans Category"='Loss' THEN
         LoansRegister."Loans Category":= LoansRegister."Loans Category"::Loss;
        
        LoansRegister.Interest:=GetInterest(LoansTemp."Loan Product Type");
        LoansRegister.INSERT;
        
        UNTIL LoansTemp.NEXT=0;
         ProgressWindow.CLOSE;
        END;
        */

    end;

    local procedure GetMemberNo(MemberID: Integer) memberNo: Code[30]
    var
        MemberRegister: Record "Member Register";
    begin
        MemberRegister.Reset;
        MemberRegister.SetRange("Unique Id",MemberID);
        if MemberRegister.Find('-') then begin
          memberNo:=MemberRegister."No.";
        end;

        exit(memberNo);
    end;

    local procedure GetInterest(LoanProd: Code[30]) intr: Decimal
    var
        LoanProductsSetup: Record "Loan Products Setup";
    begin
        LoanProductsSetup.Reset;
        LoanProductsSetup.SetRange(Code,LoanProd);
        if LoanProductsSetup.Find('-') then begin
          intr:=LoanProductsSetup."Interest rate";
        end;
        exit(intr);
    end;
}

