#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 51516159 "UpdateData"
{

    trigger OnRun()
    begin
        DELETERecords();
    end;

    var
        GuarantorInfoUpdateTemp: Record "Guarantor Info Update Temp";
        AllLoansGuaranteedInfo: Record "All Loans Guaranteed Info";
        LoansGuaranteeDetails: Record "Loans Guarantee Details";
        Amt: Decimal;
        SURESTEPFactory: Codeunit "SURESTEP Factory";
        DELETEMemberLedgerEntry: Record "Member Ledger Entry";
        DELETECustLedgerEntry: Record "Cust. Ledger Entry";
        DELETEVendorLedgerEntry: Record "Vendor Ledger Entry";
        DELETEGLEntry: Record "G/L Entry";
        DELETELoansGuaranteeDetails: Record "Loans Guarantee Details";
        DELETEDetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        DELETEDetailedVendorLedgEntry: Record "Detailed Vendor Ledg. Entry";
        DELETELoansRegister: Record "Loans Register";
        DELETEMemberRegister: Record "Member Register";
        DELETEMembershipApplications: Record "Membership Applications";
        DELETEChangeRequest: Record "Change Request";

    local procedure UpdateGuarantors()
    var
        AmtPaid: Decimal;
    begin

        LoansGuaranteeDetails.SetFilter("Loan No", '<>%1', '');
        if LoansGuaranteeDetails.Find('-') then begin
            repeat
                Amt := 0;
                AmtPaid := 0;
                AmtPaid := SURESTEPFactory.FnGetLoanAmountPaid(LoansGuaranteeDetails."Loan No");
                LoansGuaranteeDetails.CalcFields("Total Loans Guaranteed", "Outstanding Balance");
                if LoansGuaranteeDetails."Total Loans Guaranteed" > 0 then begin
                    Amt := (LoansGuaranteeDetails."Original Amount" / LoansGuaranteeDetails."Total Loans Guaranteed") * (LoansGuaranteeDetails."Total Loans Guaranteed" - AmtPaid);
                    if Amt < 0 then Amt := 0;
                    LoansGuaranteeDetails."Amont Guaranteed" := Amt;
                    LoansGuaranteeDetails.Modify;
                end;
            until LoansGuaranteeDetails.Next = 0;
        end;

        Message('Done');
    end;

    local procedure DELETERecords()
    var
        ProgressWindow: Dialog;
        Ct: Integer;
    begin

        //Delete Member Applications
        DELETEMembershipApplications.Reset;
        DELETEMembershipApplications.SetFilter("No.", '<>%1', '');
        if DELETEMembershipApplications.Find('-') then begin
            ProgressWindow.Open('Deleting entry No. #1#######');
            Ct := 0;
            repeat
                Ct := Ct + 1;
                ProgressWindow.Update(1, Ct);
                DELETEMembershipApplications.Delete;
            until DELETEMembershipApplications.Next = 0;
            ProgressWindow.Close;
        end;

        Message('Completed');
    end;
}

