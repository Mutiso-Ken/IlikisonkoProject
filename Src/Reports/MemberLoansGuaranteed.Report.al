#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516484 "Member Loans Guaranteed"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Member Loans Guaranteed.rdlc';

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
            column(COMPANYNAME;COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO;CurrReport.PageNo)
            {
            }
            column(USERID;UserId)
            {
            }
            column(Members__No__;"No.")
            {
            }
            column(Members_Name;Name)
            {
            }
            column(Members__Payroll_Staff_No_;"Personal No")
            {
            }
            column(Members__Current_Shares_;"Current Shares")
            {
            }
            column(Loan_GuaranteedCaption;Loan_GuaranteedCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption;CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Members__No__Caption;FieldCaption("No."))
            {
            }
            column(Members_NameCaption;FieldCaption(Name))
            {
            }
            column(Personal_No_Caption;Personal_No_CaptionLbl)
            {
            }
            column(Loan_Guarantors__Loan_No_Caption;"Loans Guarantee Details".FieldCaption("Loan No"))
            {
            }
            column(NameCaption;NameCaptionLbl)
            {
            }
            column(Loan_Guarantors_SubstitutedCaption;"Loans Guarantee Details".FieldCaption(Substituted))
            {
            }
            column(Oustanding_BalanceCaption;Oustanding_BalanceCaptionLbl)
            {
            }
            column(Loan_AmountCaption;Loan_AmountCaptionLbl)
            {
            }
            column(Current_SharesCaption;Current_SharesCaptionLbl)
            {
            }
            column(Staff_No_Caption;Staff_No_CaptionLbl)
            {
            }
            column(Loan_TypeCaption;Loan_TypeCaptionLbl)
            {
            }
            column(Loan_Guarantors__Amont_Guaranteed_Caption;"Loans Guarantee Details".FieldCaption("Amont Guaranteed"))
            {
            }
            column(Total_DepositsCaption;Total_DepositsCaptionLbl)
            {
            }
            column(MNo_Caption;MNo_CaptionLbl)
            {
            }
            column(Members_FOSA_Account;"FOSA Account No.")
            {
            }
            dataitem("Loans Guarantee Details";"Loans Guarantee Details")
            {
                DataItemLink = "Member No"=field("No.");
                DataItemTableView = where("Loan Balance"=filter(<>0));
                RequestFilterFields = Substituted,"Amont Guaranteed";
                column(ReportForNavId_5140; 5140)
                {
                }
                column(Loan_Guarantors__Loan_No_;"Loan No")
                {
                }
                column(Loans__Client_Name_;Loans."Client Name")
                {
                }
                column(Loans__Approved_Amount_;Loans."Approved Amount")
                {
                }
                column(Shares__1;Shares*-1)
                {
                }
                column(Loans__Staff_No_;Loans."Staff No")
                {
                }
                column(Loans__Loan_Product_Type_;Loans."Loan Product Type")
                {
                }
                column(Loan_Guarantors__Amont_Guaranteed_;"Amont Guaranteed")
                {
                }
                column(Loan_Guarantors__Member_No_;"Member No")
                {
                }
                column(Loans__Outstanding_Balance_;Loans."Outstanding Balance")
                {
                }
                column(Loan_Guarantors_Substituted;Substituted)
                {
                }
                column(Loans__Outstanding_Balance__Control1102755004;Loans."Outstanding Balance")
                {
                }
                column(Loan_Guarantors_Staff_Payroll_No_;"Staff/Payroll No.")
                {
                }
                dataitem("Loans Register";"Loans Register")
                {
                    DataItemLink = "Loan  No."=field("Loan No");
                    DataItemTableView = where("Outstanding Balance"=filter(>200));
                    column(ReportForNavId_5894; 5894)
                    {
                    }
                    column(Loan_Guarantors_FOSA_Substituted;"Approved Amount")
                    {
                    }
                    column(Loans__Outstanding_Balance__Control1102760023;Loans."Outstanding Balance")
                    {
                    }
                    column(Loans__Approved_Amount__Control1102760024;Loans."Approved Amount")
                    {
                    }
                    column(Shares__1_Control1102760025;Shares*-1)
                    {
                    }
                    column(Loans__Client_Name__Control1102760026;Loans."Client Name")
                    {
                    }
                    column(Loan_Guarantors_FOSA__Loan_No_;"Loan  No.")
                    {
                    }
                    column(Loans__Staff_No__Control1102760029;Loans."Staff No")
                    {
                    }
                    column(Loans__Loan_Product_Type__Control1102760031;Loans."Loan Product Type")
                    {
                    }
                    column(Account_No_;"Account No")
                    {
                    }
                    column(Loan_Guarantors_FOSA_Staff_Payroll_No_;"Requested Amount")
                    {
                    }
                    column(Loan_Guarantors_FOSA_Account_No_;"Application Date")
                    {
                    }
                    column(Loan_Guarantors_FOSA_Signed;"Client Code")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        Shares:=0;
                        if Loans.Get("Loan  No.") then begin
                        Loans.CalcFields(Loans."Outstanding Balance");
                        if Cust.Get("Member Register"."No.") then begin
                        Cust.CalcFields(Cust."Current Shares");
                        Shares:=Cust."Current Shares";
                        end;
                        end;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    Shares:=0;
                    if Loans.Get("Loan No") then begin
                    Loans.CalcFields(Loans."Outstanding Balance");
                    if Cust.Get("Member Register"."No.") then begin
                    Cust.CalcFields(Cust."Current Shares");
                    Shares:=Cust."Current Shares";
                    end;
                    end;
                end;
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
        Loans: Record "Loans Register";
        Cust: Record "Member Register";
        Shares: Decimal;
        Cust2: Record "Member Register";
        LoanGaurantors: Record "Loans Guarantee Details";
        LCount: Integer;
        A: Decimal;
        T: Decimal;
        LoanApps: Record "Loans Register";
        Lamount: Decimal;
        LGBalance: Decimal;
        "Account No": Code[10];
        Loan_GuaranteedCaptionLbl: label 'Loan Guaranteed';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Personal_No_CaptionLbl: label 'Personal No.';
        NameCaptionLbl: label 'Name';
        Oustanding_BalanceCaptionLbl: label 'Oustanding Balance';
        Loan_AmountCaptionLbl: label 'Loan Amount';
        Current_SharesCaptionLbl: label 'Current Shares';
        Staff_No_CaptionLbl: label 'Staff No.';
        Loan_TypeCaptionLbl: label 'Loan Type';
        Total_DepositsCaptionLbl: label 'Total Deposits';
        MNo_CaptionLbl: label 'MNo.';
}

