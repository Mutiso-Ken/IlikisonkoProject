#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516951 "Individual Advice"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Individual Advice.rdlc';

    dataset
    {
        dataitem("Loans Register";"Loans Register")
        {
            RequestFilterFields = "Loan  No.";
            column(ReportForNavId_1; 1)
            {
            }
            column(CompanyName;CompanyInformation.Name)
            {
            }
            column(CompanyAddress;CompanyInformation.Address)
            {
            }
            column(CompanyPhoneNo;CompanyInformation."Phone No.")
            {
            }
            column(CompanyLogo;CompanyInformation.Picture)
            {
            }
            column(CompanyMail;CompanyInformation."E-Mail")
            {
            }
            column(CompanyPostCode;CompanyInformation."Post Code")
            {
            }
            column(CompanyCity;CompanyInformation.City)
            {
            }
            column(CompanyRegionCountry;CompanyInformation."Country/Region Code")
            {
            }
            column(LoanNo_LoansRegister;"Loans Register"."Loan  No.")
            {
            }
            column(ClientCode_LoansRegister;"Loans Register"."Client Code")
            {
            }
            column(MemberName_LoansRegister;"Loans Register"."Client Name")
            {
            }
            column(ApprovedAmount_LoansRegister;"Loans Register"."Approved Amount")
            {
            }
            column(EmployerCode_LoansRegister;"Loans Register"."Employer Code")
            {
            }
            column(EmployerName_LoansRegister;"Loans Register"."Employer Name")
            {
            }
            column(Repayment_LoansRegister;"Loans Register".Repayment)
            {
            }
            column(DepositCOntribution;DepositContribution)
            {
            }
            column(RepaymentStartDate_LoansRegister;"Loans Register"."Repayment Start Date")
            {
            }
            column(ExpectedDateofCompletion_LoansRegister;"Loans Register"."Expected Date of Completion")
            {
            }
            column(Installments_LoansRegister;"Loans Register".Installments)
            {
            }
            column(MinDepositAsPerTier_LoansRegister;"Loans Register"."Min Deposit As Per Tier")
            {
            }
            column(ApprovedRepayment_LoansRegister;"Loans Register"."Approved Repayment")
            {
            }
            column(LoanInterestRepayment_LoansRegister;"Loans Register"."Loan Interest Repayment")
            {
            }
            column(LoanProductTypeName_LoansRegister;"Loans Register"."Loan Product Type Name")
            {
            }
            column(StaffNo_LoansRegister;"Loans Register"."Staff No")
            {
            }
            column(LastPaymentdate;LastPaymentdate)
            {
            }
            column(MonthlyContribution_LoansRegister;"Loans Register"."Monthly Contribution")
            {
            }
            column(RepaymentAmt;RepaymentAmt)
            {
            }

            trigger OnAfterGetRecord()
            begin
                MonthlyRepayment:=fngetFirstTotalMonthlyRepayment("Loans Register"."Loan  No.");
                LastPaymentdate:=fngetLatRepaymentDate("Loans Register"."Loan  No.");
                "Loans Register".CalcFields("Loans Register"."Top Up Amount");
                RepaymentAmt:="Loans Register"."Approved Amount"+"Loans Register"."Top Up Amount";
            end;

            trigger OnPreDataItem()
            begin
                CompanyInformation.Get;
                CompanyInformation.CalcFields(Picture);
                RepaymentAmt:=0;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        CompanyInformation: Record "Company Information";
        DepositContribution: Decimal;
        MonthlyRepayment: Decimal;
        LastPaymentdate: Date;
        SendEmail: Boolean;
        Filename: Text[100];
        SMTPSetup: Record "SMTP Mail Setup";
        SMTPMail: Codeunit "SMTP Mail";
        MembersReg: Record "Member Register";
        Attachment: Text[250];
        RepaymentAmt: Decimal;

    local procedure fngetFirstTotalMonthlyRepayment(LoanNo: Code[10]) Amount: Decimal
    var
        LoanRepaymentSchedule: Record "Loan Repayment Schedule";
    begin
        LoanRepaymentSchedule.Reset;
        LoanRepaymentSchedule.SetRange(LoanRepaymentSchedule."Loan No.",LoanNo);
        if LoanRepaymentSchedule.FindFirst then
          begin
            Amount:=LoanRepaymentSchedule."Monthly Repayment";
          end else
            Message('Loan schedule for this loan has not been generated');

        exit(Amount);
    end;

    local procedure fngetLatRepaymentDate(LoanNo: Code[10]) DateLast: Date
    var
        LoanRepaymentSchedule: Record "Loan Repayment Schedule";
    begin
        LoanRepaymentSchedule.Reset;
        LoanRepaymentSchedule.SetRange(LoanRepaymentSchedule."Loan No.",LoanNo);
        if LoanRepaymentSchedule.FindLast then
          begin
            DateLast:=LoanRepaymentSchedule."Repayment Date";
          end else
            Message('Loan schedule for this loan has not been generated');

        exit(DateLast);
    end;
}

