#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516940 "Checkoff Advice Workflow"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Checkoff Advice Workflow.rdlc';

    dataset
    {
        dataitem("Data Sheet Lines"; "Data Sheet Lines")
        {
            RequestFilterFields = "Member No", Employer;
            column(ReportForNavId_1; 1)
            {
            }
            column(MemberNo_CheckoffAdviceLines; "Data Sheet Lines"."Member No")
            {
            }
            column(EmployerCode_CheckoffAdviceLines; "Data Sheet Lines".Employer)
            {
            }
            column(EmployerName_CheckoffAdviceLines; "Data Sheet Lines".Employer)
            {
            }
            column(PayrollNo_CheckoffAdviceLines; "Data Sheet Lines"."Payroll No")
            {
            }
            column(DepositContribution_CheckoffAdviceLines; "Data Sheet Lines"."Deposit Contribution")
            {
            }
            column(Repayment_CheckoffAdviceLines; "Data Sheet Lines".Repayment)
            {
            }
            column(InterestAmount_CheckoffAdviceLines; "Data Sheet Lines"."Interest Amount")
            {
            }
            column(TotalRepayment_CheckoffAdviceLines; "Data Sheet Lines".Repayment)
            {
            }
            column(CompanyName; CompanyInformation.Name)
            {
            }
            column(CompanyAddress; CompanyInformation.Address)
            {
            }
            column(CompanyPhoneNo; CompanyInformation."Phone No.")
            {
            }
            column(CompanyLogo; CompanyInformation.Picture)
            {
            }
            column(LoanProductType_CheckoffAdviceLines; "Data Sheet Lines"."Loan Type")
            {
            }
            column(CompanyMail; CompanyInformation."E-Mail")
            {
            }
            column(CompanyPostCode; CompanyInformation."Post Code")
            {
            }
            column(InsuranceContribution_CheckoffAdviceLines; "Data Sheet Lines"."Deposit Contribution")
            {
            }
            column(DemandSavings_CheckoffAdviceLines; "Data Sheet Lines"."Kanisa Savings")
            {
            }
            column(ShareCapital_CheckoffAdviceLines; "Data Sheet Lines"."Share Capital")
            {
            }
            column(CompanyCity; CompanyInformation.City)
            {
            }
            column(CompanyRegionCountry; CompanyInformation."Country/Region Code")
            {
            }
            column(Approver; Approver)
            {
            }
            column(Period_CheckoffAdviceLines; "Data Sheet Lines".Period)
            {
            }
            column(ApprovedAmount_CheckoffAdviceLines; "Data Sheet Lines"."Approved Amount")
            {
            }
            column(LoanBalance_CheckoffAdviceLines; "Data Sheet Lines"."Outstanding Balance")
            {
            }
            column(PrincipalRepayment_CheckoffAdviceLines; "Data Sheet Lines"."Principal Amount")
            {
            }
            column(MemberName_CheckoffAdviceLines; "Data Sheet Lines".Name)
            {
            }
            column(TotalInterest_CheckoffAdviceLines; "Data Sheet Lines"."Outstanding Interest")
            {
            }
            column(TotalAmount; TotalAmount)
            {
            }
            column(RegistrationFee_CheckoffAdviceLines; "Data Sheet Lines"."Entrance Fees")
            {
            }
            column(ByLaws_CheckoffAdviceLines; "Data Sheet Lines"."Entrance Fees")
            {
            }
            column(RejoiningFee_CheckoffAdviceLines; "Data Sheet Lines"."Entrance Fees")
            {
            }
            column(OutstandingInterest_DataSheetLines; "Data Sheet Lines"."Outstanding Interest")
            {
            }
            column(PrincipalAmount_DataSheetLines; "Data Sheet Lines"."Principal Amount")
            {
            }
            column(KanisaSavings_DataSheetLines; "Data Sheet Lines"."Kanisa Savings")
            {
            }
            column(Repayment_DataSheetLines; "Data Sheet Lines".Repayment)
            {
            }
            column(Stocks_CheckoffAdviceLines; "Data Sheet Lines"."Entrance Fees")
            {
            }
            dataitem("Data Sheet Header"; "Data Sheet Header")
            {
                DataItemLink = Code = field("Data Sheet Header");
                column(ReportForNavId_35; 35)
                {
                }
                column(GrandTotal; GrandTotal)
                {
                }
                column(EmployerName_CheckoffAdvice; "Data Sheet Header"."Employer Code")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                ObjCheckOffHeader.Reset;
                ObjCheckOffHeader.SetRange(ObjCheckOffHeader.Code, "Data Sheet Lines"."Data Sheet Header");
                if ObjCheckOffHeader.Find('-') then begin
                    if ObjCheckOffHeader."Approved By" <> '' then
                        Approver := ObjCheckOffHeader."Approved By"
                    else
                        Approver := '';
                end;
                TotalInterest := 0;
                RemainingPeriods := 0;
                TotalRepayment := 0;
                RemainingPeriods := 0;
                TotalAmount := 0;

                TotalAmount := FnGetTotalContribution("Data Sheet Lines"."Member No", "Data Sheet Lines"."Checkoff Period", "Data Sheet Lines"."Data Sheet Header");//+
                //fnGetTotalLoan("Data Sheet Lines"."Member No","Data Sheet Lines"."Checkoff Period","Data Sheet Lines"."Data Sheet Header");

                fnGetTotalAll("Data Sheet Lines"."Checkoff Period", "Data Sheet Lines"."Data Sheet Header");
                //PaidPeriods:=KNFactory.KnGetCurrentPeriodForLoan("Data Sheet Lines".loan);
                //TotalInterest:=KNFactory.KnGetCummulativeInterest("Loans Register"."Loan  No.");
                //RemainingPeriods:="Loans Register".Installments-PaidPeriods;
                //TotalRepayment:="Loans Register"."Loan Principle Repayment"+"Loans Register"."Loan Interest Repayment";
                //GrandTotal:=GrandTotal+TotalAmount;
            end;

            trigger OnPreDataItem()
            begin
                CompanyInformation.Get;
                CompanyInformation.CalcFields(Picture);
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

    trigger OnPreReport()
    begin
        GrandTotal := 0;
    end;

    var
        CompanyInformation: Record "Company Information";
        KNFactory: Codeunit "SURESTEP Factory";
        TotalInterest: Decimal;
        PaidPeriods: Integer;
        RemainingPeriods: Integer;
        PreviousMonth: Date;
        TotalRepayment: Decimal;
        ObjCheckOffHeader: Record "Data Sheet Header";
        Approver: Text;
        TotalAmount: Decimal;
        TotalLoan: Decimal;
        GrandTotal: Decimal;

    local procedure fnGetTotalLoan(MemberNo: Code[10]; Period: Date; DocNo: Code[30]) Amount: Decimal
    var
        CheckoffAdviceLines: Record "Data Sheet Lines";
    begin
        CheckoffAdviceLines.Reset;
        CheckoffAdviceLines.SetRange(CheckoffAdviceLines."Data Sheet Header", DocNo);
        CheckoffAdviceLines.SetRange(CheckoffAdviceLines."Member No", MemberNo);
        CheckoffAdviceLines.SetRange(CheckoffAdviceLines."Checkoff Period", Period);
        //CheckoffAdviceLines.SETRANGE(CheckoffAdviceLines.enumerat,Enumer);
        if CheckoffAdviceLines.Find('-') then begin
            repeat
                Amount := Amount + CheckoffAdviceLines.Repayment;
            until CheckoffAdviceLines.Next = 0;
        end;
    end;

    local procedure FnGetTotalContribution(MemberNo: Code[20]; Period: Date; DocNo: Code[20]) Amount: Decimal
    var
        CheckoffAdviceLines: Record "Data Sheet Lines";
    begin
        CheckoffAdviceLines.Reset;
        CheckoffAdviceLines.SetRange(CheckoffAdviceLines."Data Sheet Header", DocNo);
        CheckoffAdviceLines.SetRange(CheckoffAdviceLines."Member No", MemberNo);
        CheckoffAdviceLines.SetRange(CheckoffAdviceLines."Checkoff Period", Period);
        if CheckoffAdviceLines.Find('-') then begin
            CheckoffAdviceLines.CalcSums(CheckoffAdviceLines.Amount);
            Amount := CheckoffAdviceLines.Amount;
        end;
    end;

    local procedure fnGetTotalAll(Period: Date; DocNo: Code[30]) Amount: Decimal
    var
        CheckoffAdviceLines: Record "Data Sheet Lines";
        LoansVal: Decimal;
        ContrVal: Decimal;
    begin
        CheckoffAdviceLines.Reset;
        CheckoffAdviceLines.SetRange(CheckoffAdviceLines."Data Sheet Header", DocNo);
        CheckoffAdviceLines.SetRange(CheckoffAdviceLines."Checkoff Period", Period);
        if CheckoffAdviceLines.Find('-') then begin
            CheckoffAdviceLines.CalcSums(CheckoffAdviceLines.Amount);
            GrandTotal := CheckoffAdviceLines.Amount;
        end;
    end;
}

