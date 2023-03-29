#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516479 "Validate Mermbers"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Validate Mermbers.rdlc';

    dataset
    {
        dataitem("Gen. Journal Line";"Gen. Journal Line")
        {
            DataItemTableView = where("Journal Template Name"=filter('GENERAL'),"Journal Batch Name"=filter('LINT'));
            column(ReportForNavId_1000000000; 1000000000)
            {
            }

            trigger OnAfterGetRecord()
            begin
                LoansRec.Reset;
                LoansRec.SetRange(LoansRec."Loan  No.","Loan No");
                if LoansRec.Find('-') then begin
                "Loan Product Type":=LoansRec."Loan Product Type";
                Modify;
                end;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        PDate: Date;
        Interest: Decimal;
        GenSetUp: Record "Sacco General Set-Up";
        TextDateFormula2: Text[30];
        TextDateFormula1: Text[30];
        DateFormula2: DateFormula;
        DateFormula1: DateFormula;
        Vend: Record Vendor;
        LoanGuar: Record "Loans Guarantee Details";
        Lbal: Decimal;
        cust: Record Customer;
        GenJournalLine: Record "Gen. Journal Line";
        GenLedgerSetup: Record "General Ledger Setup";
        Hesabu: Integer;
        Loanapp: Record "Loans Register";
        "Loan&int": Decimal;
        TotDed: Decimal;
        LoanType: Record "Loan Products Setup";
        Available: Decimal;
        Distributed: Decimal;
        WINDOW: Dialog;
        PostingCode: Codeunit "Gen. Jnl.-Post Line";
        SHARES: Decimal;
        TOTALLOANS: Decimal;
        Gnljnline: Record "Gen. Journal Line";
        LineN: Integer;
        instlnclr: Decimal;
        appotbal: Decimal;
        LOANAMOUNT: Decimal;
        PRODATA: Decimal;
        LOANAMOUNT2: Decimal;
        TOTALLOANSB: Decimal;
        NETSHARES: Decimal;
        Tinst: Decimal;
        Finst: Decimal;
        Floans: Decimal;
        GrAmount: Decimal;
        TGrAmount: Decimal;
        FGrAmount: Decimal;
        LOANBAL: Decimal;
        Serie: Integer;
        DLN: Code[10];
        "LN Doc": Code[20];
        INTBAL: Decimal;
        COMM: Decimal;
        loanTypes: Record "Loan Products Setup";
        ImportC: Record "Loans Import Control";
        LoansRec: Record "Loans Register";
}

