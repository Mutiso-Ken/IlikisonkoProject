#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516922 "Loans Repay Schedule_Calc"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Loans Repay Schedule_Calc.rdlc';
    PaperSourceDefaultPage = Upper;
    PaperSourceFirstPage = Upper;

    dataset
    {
        dataitem("Loan Calculator";"Loan Calculator")
        {
            PrintOnlyIfDetail = false;
            column(ReportForNavId_4645; 4645)
            {
            }
            column(LoanProductType_LoanCalculator;"Loan Calculator"."Loan Product Type")
            {
            }
            column(Installments_LoanCalculator;"Loan Calculator".Installments)
            {
            }
            column(TotalMonthlyRepayment_LoanCalculator;"Loan Calculator"."Total Monthly Repayment")
            {
            }
            column(ProductDescription_LoanCalculator;"Loan Calculator"."Product Description")
            {
            }
            column(RepaymentMethod_LoanCalculator;"Loan Calculator"."Repayment Method")
            {
            }
            column(RequestedAmount_LoanCalculator;"Loan Calculator"."Requested Amount")
            {
            }
            column(CompanyInfo_Name;CompanyInfo.Name)
            {
            }
            column(CompanyInfo_Address;CompanyInfo.Address)
            {
            }
            column(CompanyInfo__Phone_No__;CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfo__E_Mail_;CompanyInfo."E-Mail")
            {
            }
            column(CompanyInfo_City;CompanyInfo.City)
            {
            }
            column(CompanyInfo_Picture;CompanyInfo.Picture)
            {
            }
            dataitem("Loan Repay Schedule-Calc";"Loan Repay Schedule-Calc")
            {
                DataItemTableView = sorting("Loan No.","Member No.","Repayment Date");
                PrintOnlyIfDetail = false;
                RequestFilterFields = "Member No.","Loan Category";
                column(ReportForNavId_9169; 9169)
                {
                }
                column(ROUND__Monthly_Repayment__10_____;ROUND("Loan Repay Schedule-Calc"."Monthly Repayment",1,'>'))
                {
                }
                column(FORMAT__Repayment_Date__0_4_;Format("Loan Repay Schedule-Calc"."Repayment Date",0,4))
                {
                }
                column(ROUND__Principal_Repayment__10_____;ROUND("Loan Repay Schedule-Calc"."Principal Repayment",1,'>'))
                {
                }
                column(ROUND__Monthly_Interest__10_____;ROUND("Loan Repay Schedule-Calc"."Monthly Interest",1,'>'))
                {
                }
                column(LoanBalance;LoanBalance)
                {
                }
                column(Loan_Repayment_Schedule__Repayment_Code_;"Repayment Code")
                {
                }
                column(ROUND__Monthly_Repayment__10______Control1000000043;"Loan Repay Schedule-Calc"."Monthly Repayment")
                {
                }
                column(ROUND__Principal_Repayment__10______Control1000000014;"Loan Repay Schedule-Calc"."Principal Repayment")
                {
                }
                column(ROUND__Monthly_Interest__10______Control1000000015;"Loan Repay Schedule-Calc"."Monthly Interest")
                {
                }
                column(Monthly_RepaymentCaption;Monthly_RepaymentCaptionLbl)
                {
                }
                column(InterestCaption;InterestCaptionLbl)
                {
                }
                column(Principal_RepaymentCaption;Principal_RepaymentCaptionLbl)
                {
                }
                column(Due_DateCaption;Due_DateCaptionLbl)
                {
                }
                column(Loan_BalanceCaption;Loan_BalanceCaptionLbl)
                {
                }
                column(Loan_RepaymentCaption;Loan_RepaymentCaptionLbl)
                {
                }
                column(TotalCaption;TotalCaptionLbl)
                {
                }
                column(Loan_Repayment_Schedule_Loan_No_;"Loan No.")
                {
                }
                column(Loan_Repayment_Schedule_Member_No_;"Member No.")
                {
                }
                column(Loan_Repayment_Schedule_Repayment_Date;"Repayment Date")
                {
                }
                column(RepaymentCode;"Loan Repay Schedule-Calc"."Instalment No")
                {
                }
                column(MonthlyInsurance_LoanRepaymentSchedule;"Loan Repay Schedule-Calc"."Monthly Insurance")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    /*Cust.RESET;
                    //Cust.SETRANGE(Cust."No.","Loans Register Credit"."Client Code");
                    Cust.SETRANGE(Cust."No.","Loans Register"."Employer Code");
                    IF Cust.FIND('-') THEN BEGIN
                    EmployerName:=Cust.Name;
                    
                    END;
                    
                    i:=i+1;
                    
                    TotalPrincipalRepayment:=(TotalPrincipalRepayment+"Principal Repayment");
                    
                    IF i=1 THEN
                     LoanBalance:=("Loan Amount")
                    ELSE BEGIN
                     LoanBalance:=("Loan Amount"-TotalPrincipalRepayment+"Principal Repayment");
                    END;
                    
                    CumInterest:=(CumInterest+"Monthly Interest");
                    CumMonthlyRepayment:=(CumMonthlyRepayment+"Monthly Repayment");
                    CumPrincipalRepayment:=(CumPrincipalRepayment+"Principal Repayment");
                    */

                end;

                trigger OnPreDataItem()
                begin
                    LastFieldNo := FieldNo("Member No.");
                    i:=0;
                    j:=0;
                end;
            }

            trigger OnPreDataItem()
            begin
                CompanyInfo.Get();
                CompanyInfo.CalcFields(CompanyInfo.Picture);
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
        TotalFor: label 'Total for ';
        Duration: Integer;
        MemberLoan: Record Customer;
        IssuedDate: Date;
        LoanCategory: Record "Loan Products Setup";
        i: Integer;
        LoanBalance: Decimal;
        CumInterest: Decimal;
        CumMonthlyRepayment: Decimal;
        CumPrincipalRepayment: Decimal;
        j: Integer;
        LoanApp: Record "Loans Register";
        GroupName: Text[70];
        TotalPrincipalRepayment: Decimal;
        Rate: Decimal;
        BankDetails: Text[250];
        Cust: Record Customer;
        Intallments__Months_CaptionLbl: label 'Intallments (Months)';
        Disbursment_DateCaptionLbl: label 'Disbursment Date';
        Current_InterestCaptionLbl: label 'Current Interest';
        Loan_AmountCaptionLbl: label 'Loan Amount';
        Loan_ProductCaptionLbl: label 'Loan Product';
        Loan_No_CaptionLbl: label 'Loan No.';
        Account_No_CaptionLbl: label 'Account No.';
        Monthly_RepaymentCaptionLbl: label 'Monthly Repayment';
        InterestCaptionLbl: label 'Interest';
        Principal_RepaymentCaptionLbl: label 'Principal Repayment';
        Due_DateCaptionLbl: label 'Due Date';
        Loan_BalanceCaptionLbl: label 'Loan Balance';
        Loan_RepaymentCaptionLbl: label 'Loan Repayment';
        TotalCaptionLbl: label 'Total';
        EmployerName: Text;
        INST: Integer;
        CompanyInfo: Record "Company Information";
}

