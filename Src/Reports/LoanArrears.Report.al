#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516974 "Loan Arrears"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Loan Arrears.rdlc';

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
            column(TotalArrears;TotalArrears)
            {
            }
            dataitem(Loans;"Loans Register")
            {
                DataItemLink = "Client Code"=field("No."),"Date filter"=field("Date Filter"),"Loan Product Type"=field("Loan Product Filter"),"Loan  No."=field("Loan No. Filter");
                DataItemTableView = sorting("Loan  No.") where(Posted=const(true));
                column(ReportForNavId_1102755024; 1102755024)
                {
                }
                column(PrincipleBF;PrincipleBF)
                {
                }
                column(LoanNo_Loans;Loans."Loan  No.")
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
                column(OustandingPenalty_Loans;Loans."Oustanding Penalty")
                {
                }
                column(LoanArrears;LoanArrears)
                {
                }
                column(LoansCategorySASRA_Loans;Loans."Loans Category-SASRA")
                {
                }
                column(ScheduleBalance;ScheduleBalance)
                {
                }
                column(IssuedDate_Loans;Loans."Issued Date")
                {
                }
                column(DueDate;DueDate)
                {
                }
                column(LoansCategory_Loans;Loans."Loans Category")
                {
                }
                column(AuctioneerBalance_Loans;Loans."Auctioneer Balance")
                {
                }

                trigger OnAfterGetRecord()
                begin


                    if LoanSetup.Get(Loans."Loan Product Type") then
                    LoanName:=LoanSetup."Product Description";
                    if DateFilterBF <> '' then begin
                    LoansR.Reset;
                    LoansR.SetRange(LoansR."Loan  No.","Loan  No.");
                    LoansR.SetFilter(LoansR."Date filter",DateFilterBF);
                    //LoansR.SETRANGE(LoansR."Loan Product Type","Loan Product Type");
                    if LoansR.Find('-') then begin
                    LoansR.CalcFields(LoansR."Outstanding Balance",LoansR."Oustanding Interest");
                    PrincipleBF:=LoansR."Outstanding Balance";
                    InterestBF:=LoansR."Oustanding Interest";
                    end;
                    end;
                    Loans.CalcFields("Outstanding Balance","Oustanding Interest","Oustanding Penalty");
                    DueDate:=CalcDate(Format(Loans.Installments)+'M',Loans."Issued Date");
                    if (Loans."Outstanding Balance"+Loans."Oustanding Interest")<=0 then
                      CurrReport.Skip;

                    LoanRepaymentSchedule.Reset;
                    LoanRepaymentSchedule.SetRange("Loan No.",Loans."Loan  No.");
                    LoanRepaymentSchedule.SetFilter("Repayment Date",'<=%1',Today);
                    if LoanRepaymentSchedule.FindLast() then begin
                      ScheduleBalance:=LoanRepaymentSchedule."Loan Balance";
                      LoanArrears:=Loans."Outstanding Balance"+Loans."Oustanding Interest"+Loans."Oustanding Penalty"-ScheduleBalance;
                      if LoanArrears<0 then
                        LoanArrears:=0;
                      TotalArrears:=TotalArrears+LoanArrears;
                    end;
                end;

                trigger OnPreDataItem()
                begin
                    Loans.SetFilter(Loans."Date filter","Member Register".GetFilter("Member Register"."Date Filter"));
                    LoanArrears:=0;
                    ScheduleBalance:=0;
                    DueDate:=0D;
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
                TotalArrears:=0;
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
        LoanArrears: Decimal;
        LoanRepaymentSchedule: Record "Loan Repayment Schedule";
        TotalArrears: Decimal;
        ScheduleBalance: Decimal;
        DueDate: Date;
}

