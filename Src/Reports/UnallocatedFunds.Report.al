#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516541 "Unallocated Funds"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Unallocated Funds.rdlc';

    dataset
    {
        dataitem("Member Register";"Member Register")
        {
            DataItemTableView = where("Un-allocated Funds"=filter(<>0));
            RequestFilterFields = "FOSA Account No.","Loan Product Filter","Outstanding Balance","Date Filter";
            column(ReportForNavId_1102755000; 1102755000)
            {
            }
            column(USERID;UserId)
            {
            }
            column(PayrollStaffNo_Members;"Member Register"."Personal No")
            {
            }
            column(No_Members;"Member Register"."No.")
            {
            }
            column(Name_Members;"Member Register".Name)
            {
            }
            column(EmployerCode_Members;"Member Register"."Employer Code")
            {
            }
            column(EmployerName;EmployerName)
            {
            }
            column(PageNo_Members;CurrReport.PageNo)
            {
            }
            column(Shares_Retained;"Member Register"."Shares Retained")
            {
            }
            column(ShareCapBF;ShareCapBF)
            {
            }
            column(IDNo_Members;"Member Register"."ID No.")
            {
            }
            column(GlobalDimension2Code_Members;"Member Register"."Global Dimension 2 Code")
            {
            }
            column(Company_Name;Company.Name)
            {
            }
            column(Company_Address;Company.Address)
            {
            }
            column(Company_Address_2;Company."Address 2")
            {
            }
            column(Company_Phone_No;Company."Phone No.")
            {
            }
            column(Company_Fax_No;Company."Fax No.")
            {
            }
            column(Company_Picture;Company.Picture)
            {
            }
            column(Company_Email;Company."E-Mail")
            {
            }
            dataitem(UnallocatedFunds;"Member Ledger Entry")
            {
                DataItemLink = "Customer No."=field("No."),"Posting Date"=field("Date Filter");
                DataItemTableView = sorting("Posting Date") order(ascending) where("Transaction Type"=filter("Recovery Account"));
                column(ReportForNavId_1102755031; 1102755031)
                {
                }
                column(PostingDate_UnallocatedFunds;UnallocatedFunds."Posting Date")
                {
                }
                column(DocumentNo_UnallocatedFunds;UnallocatedFunds."Document No.")
                {
                }
                column(Description_UnallocatedFunds;UnallocatedFunds.Description)
                {
                }
                column(DebitAmount_UnallocatedFunds;UnallocatedFunds."Debit Amount")
                {
                }
                column(CreditAmount_UnallocatedFunds;UnallocatedFunds."Credit Amount")
                {
                }
                column(Amount_UnallocatedFunds;UnallocatedFunds.Amount)
                {
                }
                column(openBalance_UnallocatedFunds;OpenBalance)
                {
                }
                column(CLosingBalance_UnallocatedFunds;CLosingBalance)
                {
                }
                column(TransactionType_UnallocatedFunds;UnallocatedFunds."Transaction Type")
                {
                }
                column(LoanNo;UnallocatedFunds."Loan No")
                {
                }
                column(PrincipleBF_UnallocatedFunds;PrincipleBF)
                {
                }
                column(UnallocatedFunds_Description;UnallocatedFunds.Description)
                {
                }
                column(User7;UnallocatedFunds."User ID")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    /*{CLosingBalance:=CLosingBalance+loan.Amount;
                    ClosingBalInt:=ClosingBalInt+loan.Amount;
                    
                    //interest
                    ClosingBal:=ClosingBal+LoanInterest.Amount;
                    OpeningBal:=ClosingBal-LoanInterest.Amount;
                    }
                    CLosingBalance:=CLosingBalance+loan.Amount;
                    IF Loans."Loan  No."='' THEN BEGIN
                    END;
                    
                    IF loan."Transaction Type"=loan."Transaction Type"::"Interest Paid" THEN BEGIN
                    InterestPaid:=loan."Credit Amount";
                    SumInterestPaid:=InterestPaid+SumInterestPaid;
                    END;
                    IF loan."Transaction Type"=loan."Transaction Type"::Repayment THEN BEGIN
                     loan."Credit Amount":=loan."Credit Amount"//+InterestPaid;
                     END;
                     */

                end;

                trigger OnPreDataItem()
                begin
                    CLosingBalance:=PrincipleBF;
                    OpeningBal:=PrincipleBF;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                SaccoEmp.Reset;
                SaccoEmp.SetRange(SaccoEmp.Code,"Member Register"."Employer Code");
                if SaccoEmp.Find ('-') then
                EmployerName:=SaccoEmp.Description;

                SharesBF:=0;
                InsuranceBF:=0;
                ShareCapBF:=0;
                RiskBF:=0;
                HseBF:=0;
                Dep1BF:=0;
                Dep2BF:=0;
                if DateFilterBF <> '' then begin
                Cust.Reset;
                Cust.SetRange(Cust."No.","No.");
                Cust.SetFilter(Cust."Date Filter",DateFilterBF);
                if Cust.Find('-') then begin
                Cust.CalcFields(Cust."Shares Retained",Cust."Current Shares",Cust."Insurance Fund");
                SharesBF:=Cust."Current Shares";
                ShareCapBF:=Cust."Shares Retained";
                RiskBF:=Cust."Insurance Fund";

                //*********************gray



                //XmasBF:=Cust."Holiday Savings";
                //HseBF:=Cust."Household Item Deposit";
                //Dep1BF:=Cust."Dependant 1";
                //Dep2BF:=Cust."Dependant 2";
                end;
                end;
            end;

            trigger OnPreDataItem()
            begin

                if "Member Register".GetFilter("Member Register"."Date Filter") <> '' then
                DateFilterBF:='..'+ Format(CalcDate('-1D',"Member Register".GetRangeMin("Member Register"."Date Filter")));
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
         Company.Get();
         Company.CalcFields(Company.Picture);
    end;

    var
        OpenBalance: Decimal;
        CLosingBalance: Decimal;
        OpenBalanceXmas: Decimal;
        CLosingBalanceXmas: Decimal;
        Cust: Record "Member Register";
        OpeningBal: Decimal;
        ClosingBal: Decimal;
        FirstRec: Boolean;
        PrevBal: Integer;
        BalBF: Decimal;
        LoansR: Record "Loans Register";
        DateFilterBF: Text[150];
        SharesBF: Decimal;
        InsuranceBF: Decimal;
        LoanBF: Decimal;
        PrincipleBF: Decimal;
        InterestBF: Decimal;
        ShowZeroBal: Boolean;
        ClosingBalSHCAP: Decimal;
        ShareCapBF: Decimal;
        RiskBF: Decimal;
        DividendBF: Decimal;
        Company: Record "Company Information";
        OpenBalanceHse: Decimal;
        CLosingBalanceHse: Decimal;
        OpenBalanceDep1: Decimal;
        CLosingBalanceDep1: Decimal;
        OpenBalanceDep2: Decimal;
        CLosingBalanceDep2: Decimal;
        HseBF: Decimal;
        Dep1BF: Decimal;
        Dep2BF: Decimal;
        OpeningBalInt: Decimal;
        ClosingBalInt: Decimal;
        InterestPaid: Decimal;
        SumInterestPaid: Decimal;
        OpenBalanceRisk: Decimal;
        CLosingBalanceRisk: Decimal;
        OpenBalanceDividend: Decimal;
        ClosingBalanceDividend: Decimal;
        OpenBalanceHoliday: Decimal;
        ClosingBalanceHoliday: Decimal;
        LoanSetup: Record "Loan Products Setup";
        LoanName: Text[50];
        SaccoEmp: Record "Sacco Employers";
        EmployerName: Text[100];
}

