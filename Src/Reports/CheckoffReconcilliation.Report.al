#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516874 "Checkoff Reconcilliation"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Checkoff Reconcilliation.rdlc';

    dataset
    {
        dataitem("Checkoff Lines-Distributed";"Checkoff Lines-Distributed")
        {
            DataItemTableView = sorting("Receipt Header No","Entry No");
            RequestFilterFields = "Staff/Payroll No","Receipt Header No";
            column(ReportForNavId_1; 1)
            {
            }
            column(StaffPayrollNo_CheckoffLinesDistributed;"Checkoff Lines-Distributed"."Staff/Payroll No")
            {
            }
            column(Amount_CheckoffLinesDistributed;"Checkoff Lines-Distributed".Amount)
            {
            }
            column(NoRepayment_CheckoffLinesDistributed;"Checkoff Lines-Distributed"."No Repayment")
            {
            }
            column(StaffNotFound_CheckoffLinesDistributed;"Checkoff Lines-Distributed"."Staff Not Found")
            {
            }
            column(DateFilter_CheckoffLinesDistributed;"Checkoff Lines-Distributed"."Date Filter")
            {
            }
            column(TransactionDate_CheckoffLinesDistributed;"Checkoff Lines-Distributed"."Transaction Date")
            {
            }
            column(EntryNo_CheckoffLinesDistributed;"Checkoff Lines-Distributed"."Entry No")
            {
            }
            column(Generated_CheckoffLinesDistributed;"Checkoff Lines-Distributed".Generated)
            {
            }
            column(PaymentNo_CheckoffLinesDistributed;"Checkoff Lines-Distributed"."Payment No")
            {
            }
            column(Posted_CheckoffLinesDistributed;"Checkoff Lines-Distributed".Posted)
            {
            }
            column(MultipleReceipts_CheckoffLinesDistributed;"Checkoff Lines-Distributed"."Multiple Receipts")
            {
            }
            column(Name_CheckoffLinesDistributed;"Checkoff Lines-Distributed".Name)
            {
            }
            column(EarlyRemitances_CheckoffLinesDistributed;"Checkoff Lines-Distributed"."Early Remitances")
            {
            }
            column(EarlyRemitanceAmount_CheckoffLinesDistributed;"Checkoff Lines-Distributed"."Early Remitance Amount")
            {
            }
            column(LoanNo_CheckoffLinesDistributed;"Checkoff Lines-Distributed"."Loan No.")
            {
            }
            column(MemberNo_CheckoffLinesDistributed;"Checkoff Lines-Distributed"."Member No.")
            {
            }
            column(Interest_CheckoffLinesDistributed;"Checkoff Lines-Distributed".Interest)
            {
            }
            column(LoanType_CheckoffLinesDistributed;"Checkoff Lines-Distributed"."Loan Type")
            {
            }
            column(DEPT_CheckoffLinesDistributed;"Checkoff Lines-Distributed".DEPT)
            {
            }
            column(ExpectedAmount_CheckoffLinesDistributed;"Checkoff Lines-Distributed"."Expected Amount")
            {
            }
            column(FOSAAccount_CheckoffLinesDistributed;"Checkoff Lines-Distributed"."FOSA Account")
            {
            }
            column(TransType_CheckoffLinesDistributed;"Checkoff Lines-Distributed"."Utility Type")
            {
            }
            column(TransactionType_CheckoffLinesDistributed;"Checkoff Lines-Distributed"."Transaction Type")
            {
            }
            column(SpecialCode_CheckoffLinesDistributed;"Checkoff Lines-Distributed".Reference)
            {
            }
            column(Accounttype_CheckoffLinesDistributed;"Checkoff Lines-Distributed"."Account type")
            {
            }
            column(Variance_CheckoffLinesDistributed;"Checkoff Lines-Distributed".Variance)
            {
            }
            column(EmployerCode_CheckoffLinesDistributed;"Checkoff Lines-Distributed"."Employer Code")
            {
            }
            column(GPersonalNo_CheckoffLinesDistributed;"Checkoff Lines-Distributed".GPersonalNo)
            {
            }
            column(Gnames_CheckoffLinesDistributed;"Checkoff Lines-Distributed".Gnames)
            {
            }
            column(Gnumber_CheckoffLinesDistributed;"Checkoff Lines-Distributed".Gnumber)
            {
            }
            column(Userid1_CheckoffLinesDistributed;"Checkoff Lines-Distributed".Userid1)
            {
            }
            column(LoansNotfound_CheckoffLinesDistributed;"Checkoff Lines-Distributed"."Loans Not found")
            {
            }
            column(ReceiptHeaderNo_CheckoffLinesDistributed;"Checkoff Lines-Distributed"."Receipt Header No")
            {
            }
            column(Source_CheckoffLinesDistributed;"Checkoff Lines-Distributed"."Unallocated Fund")
            {
            }
            column(AdvisedAmount;AdvisedAmount)
            {
            }

            trigger OnAfterGetRecord()
            begin
                // DataSheetLinesDist.RESET;
                // DataSheetLinesDist.SETRANGE(DataSheetLinesDist."Payroll No","Checkoff Lines-Distributed"."Staff/Payroll No");
                // IF DataSheetLinesDist.FIND('-') THEN BEGIN
                //  AdvisedAmount:=DataSheetLinesDist.Amount;
                //  END;
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
        DataSheetLinesDist: Record "Data Sheet Lines-Dist";
        AdvisedAmount: Decimal;
}

