#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516474 "Account Closure Slip"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Account Closure Slip.rdlc';

    dataset
    {
        dataitem("Member Register";"Member Register")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";
            column(ReportForNavId_7301; 7301)
            {
            }
            column(FORMAT_TODAY_0_4_;Format(Today,0,4))
            {
            }
            column(CurrReport_PAGENO;CurrReport.PageNo)
            {
            }
            column(USERID;UserId)
            {
            }
            column(EarlyWIthdrawalCharge;TenSaccoIncome)
            {
            }
            column(COMPANYNAME;COMPANYNAME)
            {
            }
            column(Members__No__;"No.")
            {
            }
            column(Members_Name;Name)
            {
            }
            column(Members__ID_No__;"ID No.")
            {
            }
            column(RiskFund;RiskFund)
            {
            }
            column(TotalAdds;TotalAdds)
            {
            }
            column(UnpaidDividendsNew;UnpaidDividendsNew)
            {
            }
            column(TotalLoanBOSA;TotalLoanBOSA)
            {
            }
            column(TotalIntDueBOSA;TotalIntDueBOSA)
            {
            }
            column(TotalLoanFOSA;TotalLoanFOSA)
            {
            }
            column(TotalIntDueFOSA;TotalIntDueFOSA)
            {
            }
            column(Totallesses;Totallesses)
            {
            }
            column(RiskFundBeneficiary;RiskFundBeneficiary)
            {
            }
            column(RiskRefund;RiskRefund)
            {
            }
            column(Members__Payroll_Staff_No_;"Personal No")
            {
            }
            column(Members__Outstanding_Balance_;"Outstanding Balance")
            {
            }
            column(ExciseDuty;ExciseDuty)
            {
            }
            column(TranferFee;TranferFee)
            {
            }
            column(CompanyinfoPicture;Companyinfo.Picture)
            {
            }
            column(Current_Shares___1;"Current Shares")
            {
            }
            column(SharesRetained_MembersRegister;"Member Register"."Shares Retained"-2000)
            {
            }
            column(Insurance_Fund___1;"Insurance Fund")
            {
            }
            column(RiskFund_MembersRegister;"Member Register"."Risk Fund")
            {
            }
            column(Members__Accrued_Interest_;"Accrued Interest")
            {
            }
            column(OutstandingInterest_Members;"Member Register"."Outstanding Interest")
            {
            }
            column(Members__Current_Shares_;"Current Shares")
            {
            }
            column(UnpaidDividends;UnpaidDividends)
            {
            }
            column(Members__Insurance_Fund_;"Insurance Fund")
            {
            }
            column(NetPayable;NetPayable)
            {
            }
            column(Members__Current_Investment_Total_;"Current Investment Total")
            {
            }
            column(Members__Dividend_Amount_;"Dividend Amount")
            {
            }
            column(FWithdrawal;FWithdrawal)
            {
            }
            column(Members_Members__Batch_No__;"Member Register"."Batch No.")
            {
            }
            column(Members_Members_Status;"Member Register".Status)
            {
            }
            column(FOSAInterest;FOSAInterest)
            {
            }
            column(Members__FOSA_Outstanding_Balance_;"FOSA Outstanding Balance")
            {
            }
            column(Members_Members__Shares_Retained_;"Member Register"."Shares Retained")
            {
            }
            column(FExpenses;FExpenses)
            {
            }
            column(InsFund__1;InsFund*-1)
            {
            }
            column(CICLoan;CICLoan)
            {
            }
            column(CICLoan___Current_Shares___1__UnpaidDividends___Insurance_Fund___1__FExpenses;CICLoan+("Current Shares")+UnpaidDividends+FExpenses)
            {
            }
            column(Outstanding_Balance___Accrued_Interest___FOSA_Outstanding_Balance__FOSAInterest_FWithdrawal__InsFund__1_;"Outstanding Balance"+"Accrued Interest"+"FOSA Outstanding Balance"+FOSAInterest+FWithdrawal+(InsFund*-1))
            {
            }
            column(CurrReport_PAGENOCaption;CurrReport_PAGENOCaptionLbl)
            {
            }
            column(ACCOUNT_CLOSURE_SLIPCaption;ACCOUNT_CLOSURE_SLIPCaptionLbl)
            {
            }
            column(P_O_BOX_75629___00200__NAIROBICaption;P_O_BOX_75629___00200__NAIROBICaptionLbl)
            {
            }
            column(Member_No_Caption;Member_No_CaptionLbl)
            {
            }
            column(Members_NameCaption;FieldCaption(Name))
            {
            }
            column(Members__ID_No__Caption;FieldCaption("ID No."))
            {
            }
            column(Members__Payroll_Staff_No_Caption;FieldCaption("Personal No"))
            {
            }
            column(Current_Oustanding_LoanCaption;Current_Oustanding_LoanCaptionLbl)
            {
            }
            column(Deposit_ContributionCaption;Deposit_ContributionCaptionLbl)
            {
            }
            column(Other_DeductionsCaption;Other_DeductionsCaptionLbl)
            {
            }
            column(Insurance_Fund_Caption;Insurance_Fund_CaptionLbl)
            {
            }
            column(Members__Accrued_Interest_Caption;FieldCaption("Accrued Interest"))
            {
            }
            column(ADD__Unpaid_DividendsCaption;ADD__Unpaid_DividendsCaptionLbl)
            {
            }
            column(LESS_Caption;LESS_CaptionLbl)
            {
            }
            column(ADD_Caption;ADD_CaptionLbl)
            {
            }
            column(Net_RefundCaption;Net_RefundCaptionLbl)
            {
            }
            column(Withdrawal_FeesCaption;Withdrawal_FeesCaptionLbl)
            {
            }
            column(Batch_No_Caption;Batch_No_CaptionLbl)
            {
            }
            column(DataItem1000000004;Prepared_By__________________________________________________________________________________________________________________Lbl)
            {
            }
            column(DataItem1000000005;Certified_By_________________________________________________________________________________________________________________Lbl)
            {
            }
            column(DataItem1000000007;Signature_Date_______________________________________________________________________________________________________________Lbl)
            {
            }
            column(DataItem1000000008;Signature_Date____________________________________________________________________________________________________________000Lbl)
            {
            }
            column(Member_StatusCaption;Member_StatusCaptionLbl)
            {
            }
            column(FOSA_Accrued_InterestCaption;FOSA_Accrued_InterestCaptionLbl)
            {
            }
            column(CurrentShares_MemberRegister;"Member Register"."Current Shares")
            {
            }
            column(FOSA_Current_Oustanding_LoanCaption;FOSA_Current_Oustanding_LoanCaptionLbl)
            {
            }
            column(Funeral_ExpensesCaption;Funeral_ExpensesCaptionLbl)
            {
            }
            column(Under_Excess_InsuranceCaption;Under_Excess_InsuranceCaptionLbl)
            {
            }
            column(Insurance__CIC_Caption;Insurance__CIC_CaptionLbl)
            {
            }
            column(TotalCaption;TotalCaptionLbl)
            {
            }
            column(TotalCaption_Control1102760055;TotalCaption_Control1102760055Lbl)
            {
            }
            column(RefundableShareCapital;RefundableShareCapital)
            {
            }
            column(ClosureNo;ClosureNo)
            {
            }
            column(RetainedDeposits;RetainedDeposits)
            {
            }
            column(UnpaidCoreCapital;UnpaidCoreCapital)
            {
            }

            trigger OnAfterGetRecord()
            begin
                WithdrawalFee:=0;
                NetPayable:=0;
                FWithdrawal:=0;
                FExpenses:=0;
                CICLoan:=0;
                InsFund:=0;
                UnpaidDividends:=0;
                TenSaccoIncome:=0;
                LoanOverpayment:=0;
                UnpaidCoreCapital:=0;
                
                if Cust.Get('RB-'+Cust."Personal No") then begin
                Cust.CalcFields(Cust."Balance (LCY)");
                UnpaidDividends:=Cust."Balance (LCY)";
                
                end;
                /*
                Memb.RESET;
                Memb.SETRANGE("No.","Member Register"."No.");
                IF Memb.FIND('-')THEN BEGIN
                IF Memb."Outstanding Balance"<0 THEN
                LoanOverpayment:=Memb."Outstanding Balance";
                MESSAGE('checki%1',LoanOverpayment);
                END ELSE LoanOverpayment:=0;
                MESSAGE('test2%1',LoanOverpayment);
                */
                Closure.Reset;
                Closure.SetRange(Closure."Member No.","No.");
                if Closure.Find('-') then begin
                
                ClosureNo:=Closure."No.";
                RiskFund:=Closure."Risk Fund";
                RiskFundBeneficiary:=Closure."Risk Beneficiary";
                RiskRefund:=Closure."Risk Refundable";
                RefundableShareCapital:=Closure."Refundable Share Capital";
                RetainedDeposits:=Closure."Member Guarantorship Liability";
                TotalAdds:=Closure."Total Adds";
                
                UnpaidDividendsNew:=Closure."Unpaid Dividends";
                TotalLoanBOSA:=Closure."Total Loan";
                TotalIntDueBOSA:=Closure."Total Interest";
                UnpaidCoreCapital:=Closure."Unpaid Share Capital";
                Totallesses:=Closure."Total Lesses";
                end;
                
                NetLiability:=TotalAdds-Totallesses;
                
                TranferFee:=0;
                Generalsetup.Get();
                Closure.Reset;
                Closure.SetRange(Closure."Member No.","No.");
                if Closure.Find('-') then begin
                  if Closure."Sell Share Capital"=true then begin
                  TranferFee:=Generalsetup."Share Capital Transfer Fee";
                    end;
                  end;
                //IF (Closure."Posting Date"<Closure."Expected Posting Date") THEN
                //BEGIN
                //FWithdrawal:=Generalsetup."Withdrawal Fee"/100*NetLiability;
                //Graduated Charges
                
                
                //End Graduated Charges
                //END;
                //FWithdrawal:=FWithdrawal+500;
                
                if (Closure."Closure Type"=Closure."closure type"::"Withdrawal - Death") then begin
                NetPayable:=NetLiability
                end else
                if (Closure."Closure Type"=Closure."closure type"::"Withdrawal - Normal") then begin
                
                NetPayable:=NetLiability-FWithdrawal-ExciseDuty-TenSaccoIncome;
                
                Closure."Risk Fund Arrears":=NetPayable;
                Closure.Modify;
                end;
                
                //Graduated Charges
                MWithdrawalGraduatedCharges.Reset;
                MWithdrawalGraduatedCharges.SetRange(MWithdrawalGraduatedCharges."Notice Status",MWithdrawalGraduatedCharges."notice status"::Notified);
                if MWithdrawalGraduatedCharges.Find('-') then begin
                repeat
                if (NetLiability>=MWithdrawalGraduatedCharges."Minimum Amount") and (NetLiability<=MWithdrawalGraduatedCharges."Maximum Amount") then begin
                if MWithdrawalGraduatedCharges."Use Percentage"=true  then begin
                FWithdrawal:=NetLiability*(MWithdrawalGraduatedCharges."Percentage of Amount"/100)
                end else
                FWithdrawal:=MWithdrawalGraduatedCharges.Amount;
                end;
                until MWithdrawalGraduatedCharges.Next=0;
                end;
                if Today < Closure."Expected Posting Date" then
                begin
                //TenSaccoIncome:=NetLiability*0.1;
                //ExciseDuty:=TenSaccoIncome*Generalsetup."Excise Duty(%)"/100;
                end;
                
                if (Closure."Closure Type"=Closure."closure type"::"Withdrawal - Death") then begin
                NetPayable:=NetLiability
                end else
                if (Closure."Closure Type"=Closure."closure type"::"Withdrawal - Normal") then begin
                NetPayable:=NetLiability-FWithdrawal-ExciseDuty-UnpaidCoreCapital;
                Closure."Risk Fund Arrears":=NetPayable;
                Closure."Ten WIthdrawal":=TenSaccoIncome;
                Closure.Modify;
                end;
                
                //Graduated Charge
                /*IF "Members Register".GET(Withdrawal."Member No.") THEN BEGIN
                Withdrawal."Net Payable to FOSA":=NetPayable;
                  Withdrawal.MODIFY;
                END;*/
                // Closure."Net Pay":=NetPayable;
                // Closure."Net Payable to the Member":=NetPayable;
                // Closure."Net Pay":=NetPayable;
                // Closure.MODIFY;

            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FieldNo("No.");
                Companyinfo.Get();
                Companyinfo.CalcFields(Companyinfo.Picture);
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
        WithdrawalFee: Decimal;
        NetRefund: Decimal;
        FWithdrawal: Decimal;
        NetPayable: Decimal;
        FOSAInterest: Decimal;
        FExpenses: Decimal;
        CICLoan: Decimal;
        InsFund: Decimal;
        UnpaidDividends: Decimal;
        Cust: Record "Member Register";
        CurrReport_PAGENOCaptionLbl: label 'Page';
        ACCOUNT_CLOSURE_SLIPCaptionLbl: label 'ACCOUNT CLOSURE SLIP';
        P_O_BOX_75629___00200__NAIROBICaptionLbl: label 'P.O BOX 75629 - 00200, NAIROBI';
        Member_No_CaptionLbl: label 'Member No.';
        Current_Oustanding_LoanCaptionLbl: label 'Current Oustanding Loan';
        Deposit_ContributionCaptionLbl: label 'Deposit Contribution';
        Other_DeductionsCaptionLbl: label 'Other Deductions';
        Insurance_Fund_CaptionLbl: label 'Insurance Fund ';
        ADD__Unpaid_DividendsCaptionLbl: label 'ADD: Unpaid Dividends';
        LESS_CaptionLbl: label 'LESS:';
        ADD_CaptionLbl: label 'ADD:';
        Net_RefundCaptionLbl: label 'Net Refund';
        Withdrawal_FeesCaptionLbl: label 'Withdrawal Fees';
        Batch_No_CaptionLbl: label 'Batch No.';
        Prepared_By__________________________________________________________________________________________________________________Lbl: label 'Prepared By: ....................................................................................................................................................................';
        Certified_By_________________________________________________________________________________________________________________Lbl: label 'Certified By: ....................................................................................................................................................................';
        Signature_Date_______________________________________________________________________________________________________________Lbl: label 'Signature/Date: ....................................................................................................................................................................';
        Signature_Date____________________________________________________________________________________________________________000Lbl: label 'Signature/Date: ....................................................................................................................................................................';
        Member_StatusCaptionLbl: label 'Member Status';
        FOSA_Accrued_InterestCaptionLbl: label 'FOSA Accrued Interest';
        FOSA_Current_Oustanding_LoanCaptionLbl: label 'FOSA Current Oustanding Loan';
        Funeral_ExpensesCaptionLbl: label 'Funeral Expenses';
        Under_Excess_InsuranceCaptionLbl: label 'Under/Excess Insurance';
        Insurance__CIC_CaptionLbl: label 'Insurance (CIC)';
        TotalCaptionLbl: label 'Total';
        TotalCaption_Control1102760055Lbl: label 'Total';
        LastFieldNo: Integer;
        Companyinfo: Record "Company Information";
        TranferFee: Decimal;
        Closure: Record "Membership Exit";
        Generalsetup: Record "Sacco General Set-Up";
        RiskFund: Decimal;
        RiskFundBeneficiary: Boolean;
        RiskRefund: Decimal;
        TotalAdds: Decimal;
        UnpaidDividendsNew: Decimal;
        TotalLoanBOSA: Decimal;
        TotalIntDueBOSA: Decimal;
        TotalLoanFOSA: Decimal;
        TotalIntDueFOSA: Decimal;
        NetLiability: Decimal;
        Totallesses: Decimal;
        Withdrawal: Record "Membership Exit";
        RefundableShareCapital: Decimal;
        ExciseDuty: Decimal;
        ClosureNo: Code[20];
        MWithdrawalGraduatedCharges: Record "MWithdrawal Graduated Charges";
        TenSaccoIncome: Decimal;
        LoanOverpayment: Decimal;
        Memb: Record "Member Register";
        RetainedDeposits: Decimal;
        UnpaidCoreCapital: Decimal;
}

