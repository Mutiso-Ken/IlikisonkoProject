#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 51516164 "Updates090919"
{

    trigger OnRun()
    begin
        //UpdateLoans();
        //GetImages();
        //UpdateLedgerDesc();
        //UpdateRentColl();
        //CheckDifference();
        //CorrectInterest();
        UpdateNOK();
    end;

    var
        LoansRegister: Record "Loans Register";
        LoanRepaymentSchedule: Record "Loan Repayment Schedule";
        SaccoGeneralSetUp: Record "Sacco No. Series";
        ProgressWindow: Dialog;
        Ct: Integer;
        SFactory: Codeunit "SURESTEP Factory";
        RefDate: Date;
        objMembers: Record "Member Register";
        Vendor: Record Vendor;
        LoansGuaranteeDetails: Record "Loans Guarantee Details";
        Transactions: Record Transactions;
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        Customer: Record Customer;

    local procedure UpdateLoans()
    begin
        LoansRegister.Reset;
        //LoansRegister.SETFILTER("Loan  No.",'<>%1','');
        LoansRegister.SetRange("Loan  No.", 'BLN00055');
        if LoansRegister.Find('-') then begin
            ProgressWindow.Open('Updating record #1#######');
            Ct := 0;
            repeat
                Ct := Ct + 1;
                ProgressWindow.Update(1, Ct);
                // Task 1 - Update Repayment Frequency
                //LoansRegister."Repayment Frequency":=LoansRegister."Repayment Frequency"::Monthly;
                // Task 2 -Update Repayment Start Date
                //IF LoansRegister."Loan Disbursement Date"<>0D THEN
                //LoansRegister."Repayment Start Date":=CALCDATE('<+1M>',LoansRegister."Loan Disbursement Date");
                //IF (LoansRegister."Approved Amount"<>0) AND (LoansRegister."Amount Disbursed"=0) THEN
                // LoansRegister."Amount Disbursed":=LoansRegister."Approved Amount";
                //LoansRegister.MODIFY(TRUE);

                // Task 3 - Generate Schedule
                if LoansRegister.Interest <> 0 then
                    SFactory.FnGenerateRepaymentSchedule(LoansRegister."Loan  No.");


            until LoansRegister.Next = 0;
            ProgressWindow.Close;
        end;
    end;


    procedure GetImages()
    var
        filename: Text[100];
    begin
        objMembers.Reset;
        if objMembers.FindSet(true, false) then begin
            ProgressWindow.Open('Importing Images record #1#######');
            Ct := 0;
            repeat
                //IF objMembers."Unique Id"=1680 THEN BEGIN
                Ct := Ct + 1;
                ProgressWindow.Update(1, Ct);

                //    filename:='C:\Users\mobile\Desktop\Photos\'+FORMAT(objMembers."Unique Id")+'signature.jpeg';
                //    IF FILE.EXISTS(filename) THEN BEGIN
                //    objMembers.Signature.IMPORTFILE(filename,objMembers."No."+'signature');
                //    objMembers.MODIFY(TRUE);

                //END;
                //END;

                //      Vendor.RESET;
                //      Vendor.SETRANGE("BOSA Account No",objMembers."No.");
                //      IF Vendor.FIND('-') THEN BEGIN
                //        Vendor.Picture:=objMembers.Picture;
                //        Vendor.Signature:=objMembers.Signature;
                //        Vendor.MODIFY(TRUE);
                //      END;

                if objMembers."Marital Status" = objMembers."marital status"::Divorced then begin
                    objMembers."Marital Status" := objMembers."marital status"::" ";
                    objMembers.Modify(true);
                end;

            until objMembers.Next = 0;
            ProgressWindow.Close;
            Message('Imported successfully');
        end;
    end;

    local procedure UpdateGuarantors()
    begin
        LoansGuaranteeDetails.Reset;
        LoansGuaranteeDetails.SetFilter("Loan No", '<>%1', '');
        if LoansGuaranteeDetails.Find('-') then begin
            objMembers.Reset;
            objMembers.SetRange("No.", LoansGuaranteeDetails."Loanees  No");
            if objMembers.FindFirst() then begin

            end;

        end;
    end;

    local procedure UpdateLedgerDesc()
    begin
        Transactions.Reset;
        Transactions.SetRange(Posted, true);
        Transactions.SetRange("Transaction Type", 'DEPOSIT');
        if Transactions.Find('-') then begin
            repeat
                //    IF Transactions."Transaction Description"='Deposit'+Transactions.Description THEN BEGIN
                //      Transactions."Transaction Description":='Deposit-'+Transactions.Description;
                //      Transactions.MODIFY(TRUE);
                //    END;
                //Update Tenant Name
                //    Customer.RESET;
                //    Customer.SETRANGE("No.",Transactions."Tenant No");
                //    IF Customer.FIND('-') THEN BEGIN
                //      Transactions."Tenant Name":=Customer.Name;
                //      Transactions.MODIFY(TRUE);
                //    END;

                VendorLedgerEntry.Reset;
                VendorLedgerEntry.SetRange("Document No.", Transactions.No);
                //VendorLedgerEntry.SETFILTER(Amount,'<%1',0);
                if VendorLedgerEntry.Find('-') then begin
                    VendorLedgerEntry.Description := Transactions."Transaction Description";
                    VendorLedgerEntry.Modify(true);
                end;

            until Transactions.Next = 0;
        end;
    end;

    local procedure UpdateRentColl()
    var
        AccNo: Text[15];
        branch: Text[15];
    begin
        Vendor.Reset;
        Vendor.SetRange("Vendor Posting Group", 'RENT');
        if Vendor.Find('-') then begin
            AccNo := '';
            repeat
                //   IF Vendor."Global Dimension 2 Code"='LTK' THEN
                //      branch:='1';
                //    IF Vendor."Global Dimension 2 Code"='KMN' THEN
                //      branch:='2';
                //
                //      AccNo:=branch+'02'+Vendor."BOSA Account No";
                //
                //   Vendor.RENAME(AccNo);
                //   Vendor.MODIFY(TRUE);


                objMembers.Reset;
                objMembers.SetRange("No.", Vendor."BOSA Account No");
                if objMembers.FindFirst() then begin
                    if Vendor.Name = '' then
                        Vendor.Name := objMembers.Name;
                    Vendor.Modify(true);
                end;
            until Vendor.Next = 0;
        end;
    end;

    local procedure CheckDifference()
    var
        AgeingLoan: Record "Ageing-Loan";
        LoanTest: Record LoanTest;
    begin
        AgeingLoan.Reset;
        AgeingLoan.SetFilter("Loan No", '<>%1', '');
        if AgeingLoan.Find('-') then begin
            repeat

                LoanTest.Reset;
                LoanTest.SetRange("Loan No", AgeingLoan."Loan No");
                if not LoanTest.Find('-') then begin
                    AgeingLoan.Available := true;
                    AgeingLoan.Modify(true);
                end;

            until AgeingLoan.Next = 0;
        end;
    end;

    local procedure CorrectInterest()
    var
        LoanInterestPosted: Record "Loan Interest Posted";
        LoanProductsSetup: Record "Loan Products Setup";
        LoansRegister: Record "Loans Register";
        MemberLedgerEntry: Record "Member Ledger Entry";
        GLEntry: Record "G/L Entry";
    begin
        MemberLedgerEntry.Reset;
        MemberLedgerEntry.SetRange("Transaction Type", MemberLedgerEntry."transaction type"::"Interest Paid");
        MemberLedgerEntry.SetRange(Reversed, false);
        if MemberLedgerEntry.Find('-') then begin
            LoanInterestPosted.Reset;
            LoanInterestPosted.SetFilter("Loan No", '<>%1', '');
            if LoanInterestPosted.Find('-') then begin
                repeat
                    LoanInterestPosted.Delete(true);
                until LoanInterestPosted.Next = 0;
            end;

            repeat
                GLEntry.Reset;
                GLEntry.SetRange("Entry No.", MemberLedgerEntry."Entry No.");
                if GLEntry.Find('-') then begin

                    LoansRegister.Reset;
                    LoansRegister.SetRange("Loan  No.", MemberLedgerEntry."Loan No");
                    if LoansRegister.Find('-') then begin

                        LoanProductsSetup.Reset;
                        LoanProductsSetup.SetRange(Code, LoansRegister."Loan Product Type");
                        if LoanProductsSetup.Find('-') then begin

                            LoanInterestPosted.Init;
                            LoanInterestPosted."Entry No" := MemberLedgerEntry."Entry No.";
                            LoanInterestPosted.Amount := -1 * (MemberLedgerEntry.Amount);
                            LoanInterestPosted.DocNo := MemberLedgerEntry."Document No.";
                            LoanInterestPosted."Receivable Account" := LoanProductsSetup."Receivable Interest Account";
                            LoanInterestPosted."Income Account" := LoanProductsSetup."Loan Interest Account";
                            LoanInterestPosted."Balance Account" := GLEntry."G/L Account No.";
                            LoanInterestPosted."Loan No" := LoansRegister."Loan  No.";
                            if LoanProductsSetup."Receivable Interest Account" <> GLEntry."G/L Account No." then
                                LoanInterestPosted.Wrong := true;
                            LoanInterestPosted.Insert(true);
                        end;
                    end;
                end;

            until MemberLedgerEntry.Next = 0;
        end;
    end;

    local procedure UpdateNOK()
    var
        NOKTEMP: Record "NOK-TEMP";
        MembersNominee: Record "Members Nominee";
        MemberRegister: Record "Member Register";
    begin
        NOKTEMP.Reset;
        NOKTEMP.SetFilter(entry, '<>%1', 0);
        if NOKTEMP.Find('-') then begin
            repeat
                MemberRegister.Reset;
                MemberRegister.SetRange("Unique Id", NOKTEMP."Memeber ID");
                if MemberRegister.Find('-') then begin
                    MembersNominee.Init;
                    MembersNominee."Account No" := MemberRegister."No.";
                    MembersNominee."ID No." := NOKTEMP."ID NO";
                    MembersNominee.Name := NOKTEMP.Name;
                    MembersNominee.Address := NOKTEMP.Address;
                    MembersNominee.Relationship := NOKTEMP.Relationship;
                    MembersNominee."%Allocation" := NOKTEMP.percentage;
                    MembersNominee.Telephone := NOKTEMP.Phone;
                    MembersNominee.Insert(true);
                end;
            until NOKTEMP.Next = 0;
        end;
    end;
}

