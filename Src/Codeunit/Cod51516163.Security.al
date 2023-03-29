#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 51516163 "Security_"
{

    trigger OnRun()
    begin
        //UpdateValues();
        //UpdateLoans();
        //UpdateFOSA();
        //UpdateMember();
        //GenerateSchedules();
        //UpdateGuarantors();
        //UPDMember();

        GenerateSchedules();
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
        Vendor: Record Vendor;
        SFactory: Codeunit "SURESTEP Factory";
        LoanProductsSetup: Record "Loan Products Setup";

    local procedure UpdateValues()
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        // GenJournalLine.RESET;
        // GenJournalLine.SETFILTER("Migration ID",'<>%1',0);
        // IF GenJournalLine.FIND('-') THEN BEGIN
        //   REPEAT
        //   MemberRegister.RESET;
        //   MemberRegister.SETFILTER("Unique Id",FORMAT(GenJournalLine."Migration ID"));
        //   IF MemberRegister.FIND('-') THEN BEGIN
        //     GenJournalLine."Account No.":=MemberRegister."No.";
        //     GenJournalLine.MODIFY(TRUE);
        //   END;
        //   UNTIL GenJournalLine.NEXT=0
        // END;
        //
        // MemberRegister.RESET;
        // MemberRegister.SETFILTER("No.",'<>%1','');
        // IF MemberRegister.FIND('-') THEN BEGIN
        //  REPEAT
        //    IF MemberRegister."Global Dimension 2 Code"='' THEN BEGIN
        //    MemberRegister."Global Dimension 2 Code":='LTK';
        //    MemberRegister.MODIFY(TRUE);
        //    END;
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
        LoansTemp.Reset;
        LoansTemp.SetFilter("Member ID", '<>%1', 0);
        if LoansTemp.Find('-') then begin
            ProgressWindow.Open('Inserting record #1#######');
            Ct := 0;
            repeat
                Ct := Ct + 1;
                ProgressWindow.Update(1, Ct);
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

            // LoansRegister.INIT;
            // LoansRegister."Loan  No.":=LoansTemp."Loan No";
            // LoansRegister."Client Code":=GetMemberNo(LoansTemp."Member ID");
            // LoansRegister."Application Date":=LoansTemp."Application Date";
            // LoansRegister."Loan Product Type":=LoansTemp."Loan Product Type";
            // LoansRegister.Installments:=LoansTemp.Installments;
            // LoansRegister."Requested Amount":=LoansTemp."Requested amount";
            // LoansRegister."Approved Amount":=LoansTemp."Approved Amount";
            // LoansRegister."Issued Date":=LoansTemp."Issued Date";
            // LoansRegister."Amount Disbursed":=LoansTemp."Amount Disbursed";
            //
            // IF LoansTemp."Loans Category"='Performing' THEN
            // LoansRegister."Loans Category":= LoansRegister."Loans Category"::Perfoming;
            //
            // IF LoansTemp."Loans Category"='' THEN
            // LoansRegister."Loans Category":= LoansRegister."Loans Category"::Perfoming;
            //
            // IF LoansTemp."Loans Category"='Substandard' THEN
            // LoansRegister."Loans Category":= LoansRegister."Loans Category"::Substandard;
            //
            // IF LoansTemp."Loans Category"='Doubtful' THEN
            // LoansRegister."Loans Category":= LoansRegister."Loans Category"::Doubtful;
            //
            // IF LoansTemp."Loans Category"='Loss' THEN
            // LoansRegister."Loans Category":= LoansRegister."Loans Category"::Loss;
            //
            // LoansRegister.Interest:=GetInterest(LoansTemp."Loan Product Type");
            // LoansRegister.INSERT;


            //  LoansRegister.RESET;
            //  LoansRegister.SETFILTER("Client Code",LoansTemp."Member No");
            //  IF LoansRegister.FIND('-') THEN BEGIN
            //  REPEAT
            //    EVALUATE(LoansRegister.Source,'BOSA');
            //    LoansRegister."Loan Status":=LoansRegister."Loan Status"::Issued;
            //    LoansRegister.Posted:=TRUE;
            //    LoansRegister.MODIFY(TRUE);
            //  UNTIL LoansRegister.NEXT=0;
            //  END;
            //LoansTemp."Member No":=GetMemberNo(LoansTemp."Member ID");
            //LoansTemp.MODIFY(TRUE);
            until LoansTemp.Next = 0;
            ProgressWindow.Close;
        end;



        // LoansRegister.RESET;
        // LoansRegister.SETFILTER("Loan  No.",'<>%1','');
        // IF LoansRegister.FIND('-') THEN BEGIN
        // REPEAT
        // EVALUATE(LoansRegister.Source,'BOSA');
        // UNTIL LoansRegister.NEXT=0;
        // END;
        Message('Done');
    end;

    local procedure GetMemberNo(MemberID: Integer) memberNo: Code[30]
    var
        MemberRegister: Record "Member Register";
    begin
        MemberRegister.Reset;
        MemberRegister.SetRange("Unique Id", MemberID);
        if MemberRegister.Find('-') then begin
            memberNo := MemberRegister."No.";
        end;

        exit(memberNo);
    end;

    local procedure GetInterest(LoanProd: Code[30]) intr: Decimal
    var
        LoanProductsSetup: Record "Loan Products Setup";
    begin
        LoanProductsSetup.Reset;
        LoanProductsSetup.SetRange(Code, LoanProd);
        if LoanProductsSetup.Find('-') then begin
            intr := LoanProductsSetup."Interest rate";
        end;
        exit(intr);
    end;

    local procedure UpdateFOSA()
    var
        TempFosa: Record "Temp Fosa";
        Accounts: Record Vendor;
    begin
        TempFosa.Reset;
        TempFosa.SetFilter("Old No", '<>%1', '');
        if TempFosa.Find('-') then begin
            repeat

                //    MemberRegister.RESET;
                //    MemberRegister.SETRANGE("Unique Id",TempFosa."Member Id");
                //    IF MemberRegister.FIND('-') THEN BEGIN
                //     // TempFosa."BOSA No":=MemberRegister."No.";
                //      //TempFosa."FOSA Account":=MemberRegister."Global Dimension 2 Code"+'01'+MemberRegister."No.";
                //      //TempFosa."Account Name":=MemberRegister.Name;
                //      TempFosa."Branch Code":=MemberRegister."Global Dimension 2 Code";
                //      TempFosa.MODIFY(TRUE);
                //    END;
                Accounts.Init;
                Accounts."No." := TempFosa."FOSA Account";
                Accounts.Name := TempFosa."Account Name";
                Accounts."Creditor Type" := Accounts."creditor type"::"Savings Account";
                Accounts.Status := Accounts.Status::Active;
                Accounts."Account Type" := 'ORDINARY';
                Accounts."BOSA Account No" := TempFosa."BOSA No";
                Accounts."Vendor Posting Group" := 'ORDINARY ACCOUNT';
                Accounts."Global Dimension 1 Code" := 'FOSA';
                Accounts."Global Dimension 2 Code" := TempFosa."Branch Code";
                Accounts.Insert;
            //TempFosa.CALCFIELDS(Su);
            until TempFosa.Next = 0;
        end;
        // Accounts.RESET;
        // Accounts.SETFILTER("No.",'<>%1','');
        // IF Accounts.FIND('-') THEN BEGIN
        //  REPEAT
        //   Accounts.DELETE;
        //  UNTIL Accounts.NEXT=0;
        // END;
    end;

    local procedure UpdateMember()
    var
        TempIdUpdate: Record "Temp Id Update";
    begin
        // TempIdUpdate.RESET;
        // TempIdUpdate.SETFILTER("Member Id",'<>%1',0);
        // IF TempIdUpdate.FIND('-') THEN BEGIN
        //  REPEAT
        //  MemberRegister.RESET;
        //  MemberRegister.SETRANGE("Unique Id",TempIdUpdate."Member Id");
        //  IF MemberRegister.FIND('-') THEN BEGIN
        //    MemberRegister."ID No.":=TempIdUpdate.ID;
        //    MemberRegister."Mobile Phone No":=TempIdUpdate.Phone;
        //    MemberRegister.MODIFY(TRUE);
        //  END;
        //  UNTIL TempIdUpdate.NEXT=0;
        // END;
        Vendor.Reset;
        Vendor.SetFilter("No.", '<>%1');
        if Vendor.Find('-') then begin
            repeat
                MemberRegister.Reset;
                MemberRegister.SetRange("No.", Vendor."BOSA Account No");
                if MemberRegister.Find('-') then begin
                    //     MemberRegister."ID No.":=TempIdUpdate.ID;
                    //     Vendor."Mobile Phone No":=TempIdUpdate.Phone;
                    //     Vendor.MODIFY(TRUE);
                    Vendor."ID No." := MemberRegister."ID No.";
                    Vendor.Modify(true);
                end;
            until Vendor.Next = 0;
        end;
    end;

    local procedure GenerateSchedules()
    var
        LoansRegister: Record "Loans Register";
    begin
        LoansRegister.Reset;
        //LoansRegister.SETFILTER(Interest,'<>%1',0);
        LoansRegister.SetRange("Loan  No.", '4843');
        if LoansRegister.Find('-') then begin
            ProgressWindow.Open('Inserting record #1#######');
            Ct := 0;
            repeat
                Ct := Ct + 1;
                ProgressWindow.Update(1, Ct);

                //Get Loan product Type
                //    LoanProductsSetup.RESET;
                //    LoanProductsSetup.SETRANGE(Code,LoansRegister."Loan Product Type");
                //    IF LoanProductsSetup.FIND('-') THEN BEGIN
                //       LoansRegister."Repayment Method":=LoanProductsSetup."Repayment Method";
                //       LoansRegister.MODIFY(TRUE);
                //    END;
                //IF LoansRegister."Loan Disbursement Date"<>0D THEN
                //LoansRegister."Repayment Start Date":=CALCDATE('<1M>',LoansRegister."Loan Disbursement Date");
                //LoansRegister."Loan Disbursement Date":=LoansRegister."Issued Date";
                //LoansRegister.MODIFY(TRUE);
                SFactory.FnGenerateRepaymentSchedule(LoansRegister."Loan  No.");
            until LoansRegister.Next = 0;
            ProgressWindow.Close;
        end;
    end;

    local procedure UpdateGuarantors()
    var
        GuarantorsTemp: Record "Guarantors Temp";
        LoansGuaranteeDetails: Record "Loans Guarantee Details";
    begin
        // GuarantorsTemp.RESET;
        // GuarantorsTemp.SETFILTER(ID,'<>%1',0);
        // IF GuarantorsTemp.FIND('-') THEN BEGIN
        //  REPEAT
        // //    MemberRegister.RESET;
        // //    MemberRegister.SETRANGE("Unique Id",GuarantorsTemp."Member Id");
        // //    IF MemberRegister.FIND('-') THEN BEGIN
        // //       GuarantorsTemp."Member No":=MemberRegister."No.";
        // //      GuarantorsTemp.MODIFY(TRUE);
        // //    END;
        //
        //   LoansGuaranteeDetails.INIT;
        //   LoansGuaranteeDetails."Loan No":=GuarantorsTemp."Loan No";
        //   LoansGuaranteeDetails."Member No":=GuarantorsTemp."Member No";
        //   LoansGuaranteeDetails."Amont Guaranteed":=GuarantorsTemp."Amount Guaranteed";
        //   LoansGuaranteeDetails.INSERT;
        //
        //  UNTIL GuarantorsTemp.NEXT=0;
        // END;

        GuarantorsTemp.Reset;
        GuarantorsTemp.SetFilter(ID, '<>%1', 0);
        if GuarantorsTemp.Find('-') then begin
            repeat
                MemberRegister.Reset;
                MemberRegister.SetRange("Unique Id", GuarantorsTemp."Member Id");
                if MemberRegister.Find('-') then begin
                    GuarantorsTemp."Member No" := MemberRegister."No.";
                    GuarantorsTemp.Modify(true);
                end;

            // LoansGuaranteeDetails.RESET;
            // LoansGuaranteeDetails.SETRANGE(N);

            //   LoansGuaranteeDetails.INIT;
            //   LoansGuaranteeDetails."Loan No":=GuarantorsTemp."Loan No";
            //   LoansGuaranteeDetails."Member No":=GuarantorsTemp."Member No";
            //   LoansGuaranteeDetails."Amont Guaranteed":=GuarantorsTemp."Amount Guaranteed";
            //   LoansGuaranteeDetails.INSERT;

            until GuarantorsTemp.Next = 0;
        end;
    end;

    local procedure UpdateAccounts(Mno: Text[30])
    var
        Cst: Record Vendor;
        NewNumber: Text;
        FindPos: Integer;
        OldStr: Text[30];
    begin
        Vendor.Reset;
        Vendor.SetFilter("BOSA Account No", Mno);
        if Vendor.Find('-') then begin

            if StrPos(Vendor."No.", 'LTK') > 0 then begin
                NewMembNo := '';
                NewMembNo := ReplaceString(Vendor."No.");
                if NewMembNo <> Vendor."No." then begin
                    Vendor.Rename(NewMembNo);
                end;
            end;

        end;
    end;

    local procedure ReplaceString(OldStr: Text[30]) NewStr: Text[30]
    var
        FindPos: Integer;
    begin
        FindPos := StrPos(OldStr, 'LTK');
        while FindPos > 0 do begin
            NewStr += DelStr(OldStr, FindPos) + '1';
            OldStr := CopyStr(OldStr, FindPos + StrLen('LTK'));
            FindPos := StrPos(OldStr, 'LTK');
        end;
        NewStr += OldStr;
        exit(NewStr);
    end;

    local procedure ReplaceStringKM(OldStr: Text[30]) NewStr: Text[30]
    var
        FindPos: Integer;
    begin
        FindPos := StrPos(OldStr, '101I');
        while FindPos > 0 do begin
            NewStr += DelStr(OldStr, FindPos) + '201I';
            OldStr := CopyStr(OldStr, FindPos + StrLen('101I'));
            FindPos := StrPos(OldStr, '101I');
        end;
        NewStr += OldStr;
        exit(NewStr);
    end;

    local procedure UPD()
    var
        ACCC: Record Vendor;
        a: Integer;
    begin
        ACCC.Reset;
        ACCC.SetRange("Global Dimension 2 Code", 'LTK');
        if ACCC.Find('-') then begin
            a := 0;
            repeat
                a := a + 1;
                UpdateAccounts(ACCC."BOSA Account No");
            until ACCC.Next = 0;
            Message(Format(a));
        end;
    end;

    local procedure ReplaceStringMember(OldStr: Text[30]) NewStr: Text[30]
    var
        FindPos: Integer;
    begin
        FindPos := StrPos(OldStr, 'ILK');
        while FindPos > 0 do begin
            NewStr += DelStr(OldStr, FindPos) + '';
            OldStr := CopyStr(OldStr, FindPos + StrLen('ILK'));
            FindPos := StrPos(OldStr, 'ILK');
        end;
        NewStr += OldStr;
        exit(NewStr);
    end;

    local procedure UPDMember()
    var
        ACCC: Record Vendor;
    begin
        ACCC.Reset;
        ACCC.SetFilter("No.", '<>%1', '');
        if ACCC.Find('-') then begin
            ProgressWindow.Open('Inserting record #1#######');
            Ct := 0;
            repeat
                Ct := Ct + 1;
                ProgressWindow.Update(1, Ct);
                UpdateAccountsMember(ACCC."No.");
            until ACCC.Next = 0;
            ProgressWindow.Close;
        end;
    end;

    local procedure UpdateAccountsMember(Mno: Text[30])
    var
        Cst: Record Vendor;
        NewNumber: Text;
        FindPos: Integer;
        OldStr: Text[30];
    begin
        Cst.Reset;
        Cst.SetFilter("No.", Mno);
        if Cst.Find('-') then begin
            if StrPos(Cst."No.", 'ILK') > 0 then begin
                NewMembNo := '';
                NewMembNo := ReplaceStringMember(Cst."No.");
                if NewMembNo <> Cst."No." then begin
                    Cst.Rename(NewMembNo);
                end;
            end;
        end;
    end;

    local procedure UpdateTenants()
    var
        Customer: Record Customer;
    begin
        Customer.Reset;
        Customer.SetRange("Customer Posting Group", 'TENANT');
        if Customer.Find('-') then begin
            ProgressWindow.Open('Inserting record #1#######');
            Ct := 0;
            repeat
                Ct := Ct + 1;
                ProgressWindow.Update(1, Ct);

                Customer.CalcFields("Landlord No");

                Vendor.Init;
                Vendor."No." := 'TEN' + Customer."No.";
                Vendor.Name := Customer.Name;
                Vendor.Address := Customer.Address;
                Vendor."Phone No." := Customer."Phone No.";
                Vendor."Vendor Posting Group" := 'TENANT';
                Vendor."ID No." := Customer."ID Number";
                Vendor.Gender := Customer.Gender;
                Vendor."House Allocated" := Customer."House Allocated";
                Vendor."Allocation Status" := Customer."Allocation Status";
                Vendor.Rental := Customer.Rental;
                Vendor."Rental Name" := Customer."Rental Name";
                Vendor."Rent Account" := Customer."Rent Account";
                Vendor."Landlord No" := Customer."Landlord No";
                Vendor.Insert;

            until Customer.Next = 0;
            ProgressWindow.Close;
        end;
    end;
}

