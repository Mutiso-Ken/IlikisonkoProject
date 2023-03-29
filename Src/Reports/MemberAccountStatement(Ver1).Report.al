#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516886 "Member Account Statement(Ver1)"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Member Account Statement(Ver1).rdlc';

    dataset
    {
        dataitem("Member Register";"Member Register")
        {
            RequestFilterFields = "No.","Loan Product Filter","Outstanding Balance","Date Filter";
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
            column(SumUnallocated;SumUnallocated)
            {
            }
            column(SumDividend;SumDividend)
            {
            }
            column(SumJiokoe;SumJiokoe)
            {
            }
            column(SumInterest;SumInterest)
            {
            }
            column(Sumloans;Sumloans)
            {
            }
            column(SumBenevolent;SumBenevolent)
            {
            }
            column(SumInsurance;SumInsurance)
            {
            }
            column(SumDepositContribution;SumDepositContribution)
            {
            }
            column(SumFOSAShares;SumFOSAShares)
            {
            }
            column(SumShareCapital;SumShareCapital)
            {
            }
            dataitem(ShareCapital;"Member Ledger Entry")
            {
                DataItemLink = "Customer No."=field("No."),"Posting Date"=field("Date Filter");
                DataItemTableView = sorting("Posting Date") where("Transaction Type"=filter("Share Capital"),Reversed=filter(false));
                column(ReportForNavId_1000000009; 1000000009)
                {
                }
                column(PostingDate_ShareCapital;ShareCapital."Posting Date")
                {
                }
                column(DocumentNo_ShareCapital;ShareCapital."Document No.")
                {
                }
                column(Description_ShareCapital;ShareCapital.Description)
                {
                }
                column(DebitAmount_ShareCapital;ShareCapital."Debit Amount")
                {
                }
                column(CreditAmount_ShareCapital;ShareCapital."Credit Amount")
                {
                }
                column(Amount_ShareCapital;ShareCapital.Amount)
                {
                }
                column(TransactionType_ShareCapital;ShareCapital."Transaction Type")
                {
                }
                column(UserID_ShareCapital;ShareCapital."User ID")
                {
                }
                column(OpenBalanceShareCap;OpenBalanceShareCap)
                {
                }
                column(ClosingBalanceShareCap;ClosingBalanceShareCap)
                {
                }
                column(ShareCapBF;ShareCapBF)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    ClosingBalanceShareCap:=ClosingBalanceShareCap+(ShareCapital.Amount*-1);
                end;

                trigger OnPreDataItem()
                begin
                    ClosingBalanceShareCap:=ShareCapBF;
                    OpenBalanceShareCap:=ShareCapBF;
                end;
            }
            dataitem(Deposits;"Member Ledger Entry")
            {
                DataItemLink = "Customer No."=field("No."),"Posting Date"=field("Date Filter");
                DataItemTableView = sorting("Posting Date") where("Transaction Type"=filter("Deposit Contribution"),Reversed=const(false));
                column(ReportForNavId_1000000036; 1000000036)
                {
                }
                column(PostingDate_Deposits;Deposits."Posting Date")
                {
                }
                column(DocumentNo_Deposits;Deposits."Document No.")
                {
                }
                column(Description_Deposits;Deposits.Description)
                {
                }
                column(Amount_Deposits;Deposits.Amount)
                {
                }
                column(DebitAmount_Deposits;Deposits."Debit Amount")
                {
                }
                column(CreditAmount_Deposits;Deposits."Credit Amount")
                {
                }
                column(TransactionType_Deposits;Deposits."Transaction Type")
                {
                }
                column(UserID_Deposits;Deposits."User ID")
                {
                }
                column(OpenBalanceDeposits;OpenBalanceDeposits)
                {
                }
                column(ClosingBalanceDeposits;ClosingBalanceDeposits)
                {
                }
                column(SharesBF;SharesBF)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    ClosingBalanceDeposits:=ClosingBalanceDeposits+(Deposits.Amount*-1);
                end;

                trigger OnPreDataItem()
                begin
                    ClosingBalanceDeposits:=SharesBF;
                    OpenBalanceDeposits:=SharesBF;
                end;
            }
            dataitem(Dividend;"Member Ledger Entry")
            {
                DataItemLink = "Customer No."=field("No."),"Posting Date"=field("Date Filter");
                DataItemTableView = sorting("Posting Date") where("Transaction Type"=filter(Dividend),Reversed=filter(false));
                column(ReportForNavId_1000000059; 1000000059)
                {
                }
                column(PostingDate_Dividend;Dividend."Posting Date")
                {
                }
                column(DocumentNo_Dividend;Dividend."Document No.")
                {
                }
                column(Description_Dividend;Dividend.Description)
                {
                }
                column(Amount_Dividend;Dividend.Amount)
                {
                }
                column(UserID_Dividend;Dividend."User ID")
                {
                }
                column(TransactionType_Dividend;Dividend."Transaction Type")
                {
                }
                column(DebitAmount_Dividend;Dividend."Debit Amount")
                {
                }
                column(CreditAmount_Dividend;Dividend."Credit Amount")
                {
                }
                column(OpenBalanceDividend;OpenBalanceDividend)
                {
                }
                column(ClosingBalanceDividend;ClosingBalanceDividend)
                {
                }
                column(DividendBF;DividendBF)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    ClosingBalanceDividend:=ClosingBalanceDividend+(Dividend.Amount*-1);
                end;

                trigger OnPreDataItem()
                begin
                    ClosingBalanceDividend:=DividendBF;
                    OpenBalanceDividend:=DividendBF;
                end;
            }
            dataitem(LoanInsurance;"Member Ledger Entry")
            {
                DataItemLink = "Customer No."=field("No."),"Posting Date"=field("Date Filter");
                DataItemTableView = sorting("Posting Date") where("Transaction Type"=filter("Loan Insurance Paid"|"Recovery Account"),Reversed=filter(false));
                column(ReportForNavId_1000000071; 1000000071)
                {
                }
                column(PostingDate_LoanInsurance;LoanInsurance."Posting Date")
                {
                }
                column(DocumentNo_LoanInsurance;LoanInsurance."Document No.")
                {
                }
                column(Description_LoanInsurance;LoanInsurance.Description)
                {
                }
                column(Amount_LoanInsurance;LoanInsurance.Amount)
                {
                }
                column(UserID_LoanInsurance;LoanInsurance."User ID")
                {
                }
                column(DebitAmount_LoanInsurance;LoanInsurance."Debit Amount")
                {
                }
                column(CreditAmount_LoanInsurance;LoanInsurance."Credit Amount")
                {
                }
                column(TransactionType_LoanInsurance;LoanInsurance."Transaction Type")
                {
                }
                column(OpenBalanceLoanInsurance;OpenBalanceLoanInsurance)
                {
                }
                column(ClosingBalanceLoanInsurance;ClosingBalanceLoanInsurance)
                {
                }
                column(LoanInsuranceBF;LoanInsuranceBF)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    ClosingBalanceLoanInsurance:=ClosingBalanceLoanInsurance+(LoanInsurance.Amount);
                end;

                trigger OnPreDataItem()
                begin
                    ClosingBalanceLoanInsurance:=LoanInsuranceBF;
                    OpenBalanceLoanInsurance:=LoanInsuranceBF;
                end;
            }
            dataitem(FOSAShares;"Member Ledger Entry")
            {
                DataItemLink = "Customer No."=field("No."),"Posting Date"=field("Date Filter");
                DataItemTableView = sorting("Posting Date") where("Transaction Type"=filter("FOSA Shares"),Reversed=const(false));
                column(ReportForNavId_15; 15)
                {
                }
                column(PostingDate_FOSAShares;FOSAShares."Posting Date")
                {
                }
                column(DocumentNo_FOSAShares;FOSAShares."Document No.")
                {
                }
                column(Description_FOSAShares;FOSAShares.Description)
                {
                }
                column(Amount_FOSAShares;FOSAShares.Amount)
                {
                }
                column(UserID_FOSAShares;FOSAShares."User ID")
                {
                }
                column(DebitAmount_FOSAShares;FOSAShares."Debit Amount")
                {
                }
                column(CreditAmount_FOSAShares;FOSAShares."Credit Amount")
                {
                }
                column(TransactionType_FOSAShares;FOSAShares."Transaction Type")
                {
                }
                column(OpenBalanceFOSAShares;OpenBalanceFOSAShares)
                {
                }
                column(ClosingBalanceFOSAShares;ClosingBalanceFOSAShares)
                {
                }
                column(FOSASharesBF;FOSASharesBF)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    ClosingBalanceFOSAShares:=ClosingBalanceFOSAShares+(FOSAShares.Amount*-1);
                end;

                trigger OnPreDataItem()
                begin
                    ClosingBalanceFOSAShares:=FOSASharesBF;
                    OpenBalanceFOSAShares:=FOSASharesBF;
                end;
            }
            dataitem(AdditionalShares;"Member Ledger Entry")
            {
                DataItemLink = "Customer No."=field("No."),"Posting Date"=field("Date Filter");
                DataItemTableView = sorting("Posting Date") where("Transaction Type"=filter("Interest Due"));
                column(ReportForNavId_27; 27)
                {
                }
                column(PostingDate_AdditionalShares;AdditionalShares."Posting Date")
                {
                }
                column(DocumentNo_AdditionalShares;AdditionalShares."Document No.")
                {
                }
                column(Description_AdditionalShares;AdditionalShares.Description)
                {
                }
                column(Amount_AdditionalShares;AdditionalShares.Amount)
                {
                }
                column(UserID_AdditionalShares;AdditionalShares."User ID")
                {
                }
                column(DebitAmount_AdditionalShares;AdditionalShares."Debit Amount")
                {
                }
                column(CreditAmount_AdditionalShares;AdditionalShares."Credit Amount")
                {
                }
                column(TransactionType_AdditionalShares;AdditionalShares."Transaction Type")
                {
                }
                column(OpenBalanceAdditionalShares;OpenBalanceAdditionalShares)
                {
                }
                column(ClosingBalanceAdditionalShares;ClosingBalanceAdditionalShares)
                {
                }
                column(AdditionalSharesBF;AdditionalSharesBF)
                {
                }

                trigger OnPreDataItem()
                begin
                    ClosingBalanceAdditionalShares:=AdditionalSharesBF;
                    OpenBalanceAdditionalShares:=AdditionalSharesBF;
                end;
            }
            dataitem(Loans;"Loans Register")
            {
                DataItemLink = "Client Code"=field("No."),"Date filter"=field("Date Filter"),"Loan Product Type"=field("Loan Product Filter");
                DataItemTableView = sorting("Loan  No.") where(Posted=const(true));
                column(ReportForNavId_1102755024; 1102755024)
                {
                }
                column(PrincipleBF;PrincipleBF)
                {
                }
                column(LoanNumber;Loans."Loan  No.")
                {
                }
                column(ProductType;LoanName)
                {
                }
                column(RequestedAmount;Loans."Requested Amount")
                {
                }
                column(Interest;Loans.Interest)
                {
                }
                column(Installments;Loans.Installments)
                {
                }
                column(LoanPrincipleRepayment;Loans."Loan Principle Repayment")
                {
                }
                column(ApprovedAmount_Loans;Loans."Approved Amount")
                {
                }
                column(LoanProductTypeName_Loans;Loans."Loan Product Type Name")
                {
                }
                column(Repayment_Loans;Loans.Repayment)
                {
                }
                column(ModeofDisbursement_Loans;Loans."Mode of Disbursement")
                {
                }
                column(OutstandingBalance_Loans;Loans."Outstanding Balance")
                {
                }
                column(OustandingInterest_Loans;Loans."Oustanding Interest")
                {
                }
                column(AuctioneerBalance_Loans;Loans."Auctioneer Balance")
                {
                }
                column(OustandingPenalty_Loans;Loans."Oustanding Penalty")
                {
                }
                dataitem(loan;"Member Ledger Entry")
                {
                    DataItemLink = "Customer No."=field("Client Code"),"Loan No"=field("Loan  No."),"Posting Date"=field("Date filter");
                    DataItemTableView = sorting("Posting Date") where("Transaction Type"=filter(Loan|"Loan Repayment"|"Interest Paid"|"Interest Due"|"Penalty Charged"|"Penalty Paid"|"Auctioneer Paid"|"Auctioneer charged"),Reversed=const(false));
                    column(ReportForNavId_1102755031; 1102755031)
                    {
                    }
                    column(PostingDate_loan;loan."Posting Date")
                    {
                    }
                    column(DocumentNo_loan;loan."Document No.")
                    {
                    }
                    column(Description_loan;loan.Description)
                    {
                    }
                    column(DebitAmount_Loan;loan."Debit Amount")
                    {
                    }
                    column(CreditAmount_Loan;loan."Credit Amount")
                    {
                    }
                    column(Amount_Loan;loan.Amount)
                    {
                    }
                    column(openBalance_loan;OpenBalance)
                    {
                    }
                    column(CLosingBalance_loan;CLosingBalance)
                    {
                    }
                    column(TransactionType_loan;loan."Transaction Type")
                    {
                    }
                    column(InterestBF;InterestBF)
                    {
                    }
                    column(ClosingBalInt;ClosingBalInt)
                    {
                    }
                    column(PenaltyBF;PenaltyBF)
                    {
                    }
                    column(ClosingBalPenalty;ClosingBalancePen)
                    {
                    }
                    column(LoanNo;loan."Loan No")
                    {
                    }
                    column(ClosingAuctioneer;ClosingAuctioneer)
                    {
                    }
                    column(PrincipleBF_loans;PrincipleBF)
                    {
                    }
                    column(Loan_Description;loan.Description)
                    {
                    }
                    column(User7;loan."User ID")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        if ((loan."Transaction Type"=loan."transaction type"::Loan) or (loan."Transaction Type"=loan."transaction type"::"Loan Repayment")) then
                        CLosingBalance:=CLosingBalance+loan.Amount;
                         //MESSAGE('%1',CLosingBalance);
                        // EXIT;
                         if ((loan."Transaction Type"=loan."transaction type"::"Interest Due") or (loan."Transaction Type"=loan."transaction type"::"Interest Paid")) then
                        ClosingBalInt:=ClosingBalInt+loan.Amount;
                         //MESSAGE('%1',ClosingBalInt);
                        if ((loan."Transaction Type"=loan."transaction type"::"Penalty Charged") or (loan."Transaction Type"=loan."transaction type"::"Penalty Paid")) then
                        ClosingBalancePen:=ClosingBalancePen+loan.Amount;
                        if ((loan."Transaction Type"=loan."transaction type"::"Auctioneer charged") or (loan."Transaction Type"=loan."transaction type"::"Auctioneer Paid")) then
                        ClosingAuctioneer:=ClosingAuctioneer+loan.Amount;
                        //MESSAGE('%1',ClosingAuctioneer);
                        if Loans."Loan  No."='' then begin
                        end;
                    end;

                    trigger OnPreDataItem()
                    begin
                        CLosingBalance:=PrincipleBF;
                        OpeningBal:=PrincipleBF;
                        OpeningBalInt:=InterestBF;
                        ClosingBalInt:=InterestBF;
                        ClosingBalancePen:=PenaltyBF;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    if LoanSetup.Get(Loans."Loan Product Type") then
                    LoanName:=LoanSetup."Product Description";
                    if DateFilterBF <> '' then begin
                    LoansR.Reset;
                    LoansR.SetRange(LoansR."Loan  No.","Loan  No.");
                    LoansR.SetFilter(LoansR."Date filter",DateFilterBF);
                    if LoansR.Find('-') then begin
                    LoansR.CalcFields(LoansR."Outstanding Balance",LoansR."Oustanding Interest",LoansR."Oustanding Penalty");
                    PrincipleBF:=LoansR."Outstanding Balance";
                    InterestBF:=LoansR."Oustanding Interest";
                    PenaltyBF:=LoansR."Oustanding Penalty";
                    end;
                    end;
                end;

                trigger OnPreDataItem()
                begin
                    Loans.SetFilter(Loans."Date filter","Member Register".GetFilter("Member Register"."Date Filter"));
                end;
            }
            dataitem("Loans Guarantee Details";"Loans Guarantee Details")
            {
                DataItemLink = "Member No"=field("No.");
                column(ReportForNavId_1000000042; 1000000042)
                {
                }
                column(LoanNumb;"Loans Guarantee Details"."Loan No")
                {
                }
                column(MembersNo;"Loans Guarantee Details"."Member No")
                {
                }
                column(Name;"Loans Guarantee Details".Name)
                {
                }
                column(LBalance;"Loans Guarantee Details"."Loan Balance")
                {
                }
                column(Shares;"Loans Guarantee Details".Shares)
                {
                }
                column(LoansGuaranteed;"Loans Guarantee Details"."No Of Loans Guaranteed")
                {
                }
                column(Substituted;"Loans Guarantee Details".Substituted)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                "Member Register".CalcFields("Shares Retained","Current Shares","Insurance Fund","Dividend Amount","Benevolent Fund","FOSA Shares","Additional Shares","Member Register"."Ordinary Savings",
                "Member Register"."Outstanding Balance","Member Register"."Outstanding Interest","Member Register"."Un-allocated Funds");
                SumShareCapital:="Member Register"."Shares Retained";
                SumDepositContribution:="Member Register"."Current Shares";
                SumBenevolent:="Member Register"."Benevolent Fund";
                SumDividend:="Member Register"."Dividend Amount";
                SumInsurance:="Member Register"."Insurance Fund";
                SumInterest:="Member Register"."Outstanding Interest";
                Sumloans:="Member Register"."Outstanding Balance";
                //SumJiokoe:="Member Register"."Ordinary Savings";
                SumUnallocated:="Member Register"."Un-allocated Funds";
                SumFOSAShares:="Member Register"."FOSA Shares";



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
                Cust.CalcFields(Cust."Shares Retained",Cust."Current Shares",Cust."Insurance Fund",Cust."Dividend Amount",Cust."Benevolent Fund",Cust."Ordinary Savings",Cust."Additional Shares",Cust."FOSA Shares");
                SharesBF:=(Cust."Current Shares"*-1);
                ShareCapBF:=(Cust."Shares Retained"*-1);
                RiskBF:=Cust."Insurance Fund";
                DividendBF:=Cust."Dividend Amount";
                BenfundBF:=Cust."Benevolent Fund";
                LoanInsuranceBF:=Cust."Insurance Fund";
                FOSASharesBF:=Cust."FOSA Shares";
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
        ClosingAuctioneer: Decimal;
        Cust: Record "Member Register";
        OpeningBal: Decimal;
        ClosingBal: Decimal;
        FirstRec: Boolean;
        PrevBal: Integer;
        BalBF: Decimal;
        LoansR: Record "Loans Register";
        PenaltyBF: Decimal;
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
        BenfundBF: Decimal;
        FOSASharesBF: Decimal;
        AdditionalSharesBF: Decimal;
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
        OpenBalanceHoliday: Decimal;
        ClosingBalanceHoliday: Decimal;
        LoanSetup: Record "Loan Products Setup";
        LoanName: Text[50];
        SaccoEmp: Record "Sacco Employers";
        EmployerName: Text[100];
        OpenBalancePen: Decimal;
        ClosingBalancePen: Decimal;
        OpenBalanceShareCap: Decimal;
        ClosingBalanceShareCap: Decimal;
        OpenBalanceDeposits: Decimal;
        ClosingBalanceDeposits: Decimal;
        OpenBalanceDividend: Decimal;
        ClosingBalanceDividend: Decimal;
        OpenBalanceBenfund: Decimal;
        ClosingBalanceBenfund: Decimal;
        OpenBalanceFOSAShares: Decimal;
        ClosingBalanceFOSAShares: Decimal;
        OpenBalanceAdditionalShares: Decimal;
        ClosingBalanceAdditionalShares: Decimal;
        SumShareCapital: Decimal;
        SumDepositContribution: Decimal;
        SumInsurance: Decimal;
        SumBenevolent: Decimal;
        Sumloans: Decimal;
        SumInterest: Decimal;
        SumJiokoe: Decimal;
        SumDividend: Decimal;
        SumUnallocated: Decimal;
        LoanInsuranceBF: Decimal;
        OpenBalanceLoanInsurance: Decimal;
        ClosingBalanceLoanInsurance: Decimal;
        SumFOSAShares: Decimal;
}

