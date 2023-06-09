#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516470 "Loans Monthly Expectation"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Loans Monthly Expectation.rdlc';

    dataset
    {
        dataitem("Loans Register";"Loans Register")
        {
            DataItemTableView = where("Outstanding Balance"=filter(<>0));
            PrintOnlyIfDetail = false;
            RequestFilterFields = Source,Posted,"Last Pay Date","Issued Date";
            column(ReportForNavId_4645; 4645)
            {
            }
            column(FORMAT_TODAY_0_4_;Format(Today,0,4))
            {
            }
            column(COMPANYNAME;COMPANYNAME)
            {
            }
            column(Company_Address;Company.Address)
            {
            }
            column(Company_Address2;Company."Address 2")
            {
            }
            column(Company_PhoneNo;Company."Phone No.")
            {
            }
            column(Company_Email;Company."E-Mail")
            {
            }
            column(Company_Picture;Company.Picture)
            {
            }
            column(CurrReport_PAGENO;CurrReport.PageNo)
            {
            }
            column(USERID;UserId)
            {
            }
            column(Begin_Date;BEGINDATE)
            {
            }
            column(End_Date;ENDATE)
            {
            }
            column(Loan_No;"Loans Register"."Loan  No.")
            {
            }
            column(Loan_Type;"Loans Register"."Loan Product Type")
            {
            }
            column(Staff_No;"Loans Register"."Staff No")
            {
            }
            column(Client_Name;"Loans Register"."Client Name")
            {
            }
            column(Issued_Date;"Loans Register"."Issued Date")
            {
            }
            column(Installments;"Loans Register".Installments)
            {
            }
            column(Monthly_Repayment;"Loans Register".Repayment)
            {
            }
            column(Approved_Amount;"Loans Register"."Approved Amount")
            {
            }
            column(Outstanding_Balance;"Loans Register"."Outstanding Balance")
            {
            }
            column(Expected_Repayment;exrepay)
            {
            }
            column(Expected_Interest;expectedInterest)
            {
            }

            trigger OnAfterGetRecord()
            begin

                "1Month":=0;
                "2Month":=0;
                "3Month":=0;
                Over3Month:=0;
                currInstal:=0;
                //exrepay:=0;
                expectedRepay:=0;
                expectedInterest:=0;

                Variance:=0;
                //Filter:=Loans."Issued Date";
                //IF Loans.Installments>0 THEN
                if BEGINDATE=0D then
                Error('You Must Specify the Begin date for the report');
                if ENDATE=0D then
                Error('You Must Specify the End date for the report');

                INST:="Loans Register".Installments;
                Oustanding:="Loans Register"."Outstanding Balance";
                Interest:="Loans Register".Interest;
                "Loans Register".CalcFields("Loans Register"."Last Pay Date","Loans Register"."Outstanding Balance","Loans Register".Repayment);


                if "Loans Register"."Issued Date"<> 0D then begin
                if "Loans Register".Posted=true then
                currInstal:=Today-"Loans Register"."Issued Date";
                currInstal2:=ROUND(currInstal/30,1);
                expectedInterest:= ROUND(((Interest/1200)*Oustanding),0.05,'>');
                //expectedInterest:=Oustanding * (Interest/100);
                //MESSAGE('THE OUTSTANDING BAL IS %1',Oustanding);
                //MESSAGE('THE INTEREST RATE IS %1',Interest);
                exrepay:="Loans Register".Repayment;
                //MESSAGE('The expectedInterest is %1',expectedInterest);
                //exrepay:= Loans."Loan Principle Repayment";
                //expectedRepay:=exrepay*currInstal2;

                Variance:=expectedRepay-("Loans Register".Repayment*-1);
                 end;
                TexpectedInterest:=TexpectedInterest+expectedInterest;
            end;

            trigger OnPreDataItem()
            begin

                CurrReport.CreateTotals("1Month","2Month","3Month",Over3Month,Variance,exrepay,expectedRepay);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(BEGIN_DATE;BEGINDATE)
                {
                    ApplicationArea = Basic;
                }
                field(END_DATE;ENDATE)
                {
                    ApplicationArea = Basic;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
                Company.Get();
                Company.CalcFields(Company.Picture);
    end;

    var
        Company: Record "Company Information";
        "1Month": Decimal;
        "2Month": Decimal;
        "3Month": Decimal;
        Over3Month: Decimal;
        ShowLoan: Boolean;
        Defaultedamount: Decimal;
        INST: Decimal;
        currInstal: Integer;
        currInstal2: Decimal;
        exrepay: Decimal;
        expectedRepay: Decimal;
        Variance: Decimal;
        expectedInterest: Decimal;
        Oustanding: Decimal;
        Interest: Decimal;
        TexpectedInterest: Decimal;
        BEGINDATE: Date;
        ENDATE: Date;
}

