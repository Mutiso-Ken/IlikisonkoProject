#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516545 "ANNEX 1 - Outstanding Loans"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ANNEX 1 - Outstanding Loans.rdlc';

    dataset
    {
        dataitem(LRegister;"Loans Register")
        {
            CalcFields = "Outstanding Balance","Schedule Repayments","Principal Paid";
            DataItemTableView = where(Posted=const(true),"Outstanding Balance"=filter(<>0));
            RequestFilterFields = "Date filter";
            column(ReportForNavId_1000000000; 1000000000)
            {
            }
            column(LoanNo;LRegister."Loan  No.")
            {
            }
            column(ClientCode;LRegister."Client Code")
            {
            }
            column(LoanProductType;LRegister."Loan Product Type")
            {
            }
            column(ClientName;LRegister."Client Name")
            {
            }
            column(RepaymentMethod;LRegister."Repayment Method")
            {
            }
            column(Installments;LRegister.Installments)
            {
            }
            column(Interest;LRegister.Interest)
            {
            }
            column(RepaymentRate;LRegister."Repayment Frequency")
            {
            }
            column(IssuedDate;LRegister."Issued Date")
            {
            }
            column(ApprovedAmount;LRegister."Approved Amount")
            {
            }
            column(ExpectedDateofCompletion;LRegister."Expected Date of Completion")
            {
            }
            column(RepaymentStartDate;LRegister."Repayment Start Date")
            {
            }
            column(LastLoanRepaymentDate;LRegister."Last Pay Date")
            {
            }
            column(OutstandingBalance;LRegister."Outstanding Balance")
            {
            }
            column(LastpaidPrincipal;LRegister."Income Type")
            {
            }
            column(ScheduleRepayments;LRegister."Schedule Repayments")
            {
            }
            column(PrincipalPaid;LRegister."Principal Paid")
            {
            }
            column(DaysInArrears;LRegister."Loan Insurance Paid")
            {
            }
            column(LoanClassification;LoanClassification)
            {
            }
            column(LoansCategory_LRegister;LRegister."Loans Category")
            {
            }
            column(EmployerCode_LRegister;LRegister."Employer Name")
            {
            }
            column(EmployerCode_LRegister2;LRegister."Employer Code")
            {
            }
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
        "Last Paid Principal": Decimal;
        ObjLoans: Record "Loans Register";
        ObjLoanRegister: Record "Loans Register";
        DaysInArrears: Integer;
        LoanClassification: Text;
        TotalDays: Decimal;
        ClassCategories: Option Perfoming,Watch,Substandard,Doubtful,Loss;
}

