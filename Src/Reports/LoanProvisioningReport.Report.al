#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516459 "Loan Provisioning Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Loan Provisioning Report.rdlc';

    dataset
    {
        dataitem(loans;"Loans Register")
        {
            DataItemTableView = sorting("Loan  No.") where("Outstanding Balance"=filter(>0),Posted=const(true));
            RequestFilterFields = Source,"Loan Product Type","Outstanding Balance","Date filter","Employer Code";
            column(ReportForNavId_4645; 4645)
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
            column(Loans__Loan__No__;"Loan  No.")
            {
            }
            column(Loans__Loan_Product_Type_;"Loan Product Type")
            {
            }
            column(Loans_Loans__Staff_No_;loans."Staff No")
            {
            }
            column(Loans__Client_Name_;"Client Name")
            {
            }
            column(ClientCode_loans;loans."Client Code")
            {
            }
            column(Loans_Loans__Outstanding_Balance_;loans."Outstanding Balance")
            {
            }
            column(V2Month_;"2Month")
            {
            }
            column(V3Month_;"3Month")
            {
            }
            column(Over3Month;Over3Month)
            {
            }
            column(V1Month_;"1Month")
            {
            }
            column(V0Month_;"0Month")
            {
            }
            column(Loans_Loans__Outstanding_Balance__Control1000000016;loans."Outstanding Balance")
            {
            }
            column(Loans__Approved_Amount_;"Approved Amount")
            {
            }
            column(Loans_Loans__Interest_Due_;loans."Interest Due")
            {
            }
            column(V1MonthC_;"1MonthC")
            {
            }
            column(V2MonthC_;"2MonthC")
            {
            }
            column(V3MonthC_;"3MonthC")
            {
            }
            column(Over3MonthC;Over3MonthC)
            {
            }
            column(NoLoans;NoLoans)
            {
            }
            column(GrandTotal;GrandTotal)
            {
            }
            column(V0Month__Control1102760031;"0Month")
            {
            }
            column(V1Month__Control1102760032;"1Month")
            {
            }
            column(V2Month__Control1102760033;"2Month")
            {
            }
            column(V3Month__Control1102760034;"3Month")
            {
            }
            column(Over3Month_Control1102760035;Over3Month)
            {
            }
            column(V0MonthC_;"0MonthC")
            {
            }
            column(Loans_Aging_Analysis__SASRA_Caption;Loans_Aging_Analysis__SASRA_CaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption;CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Loans__Loan__No__Caption;FieldCaption("Loan  No."))
            {
            }
            column(Loan_TypeCaption;Loan_TypeCaptionLbl)
            {
            }
            column(Staff_No_Caption;Staff_No_CaptionLbl)
            {
            }
            column(Loans__Client_Name_Caption;FieldCaption("Client Name"))
            {
            }
            column(Oustanding_BalanceCaption;Oustanding_BalanceCaptionLbl)
            {
            }
            column(PerformingCaption;PerformingCaptionLbl)
            {
            }
            column(V1___30_Days_Caption;V1___30_Days_CaptionLbl)
            {
            }
            column(V0_Days_Caption;V0_Days_CaptionLbl)
            {
            }
            column(WatchCaption;WatchCaptionLbl)
            {
            }
            column(V31___180_Days_Caption;V31___180_Days_CaptionLbl)
            {
            }
            column(SubstandardCaption;SubstandardCaptionLbl)
            {
            }
            column(V181___360_Days_Caption;V181___360_Days_CaptionLbl)
            {
            }
            column(DoubtfulCaption;DoubtfulCaptionLbl)
            {
            }
            column(Over_360_DaysCaption;Over_360_DaysCaptionLbl)
            {
            }
            column(LossCaption;LossCaptionLbl)
            {
            }
            column(TotalsCaption;TotalsCaptionLbl)
            {
            }
            column(CountCaption;CountCaptionLbl)
            {
            }
            column(Grand_TotalCaption;Grand_TotalCaptionLbl)
            {
            }
            column(Arrears_Amount;DifinOutBal)
            {
            }

            trigger OnAfterGetRecord()
            begin


                loans.SetFilter(loans."Date filter",'..'+Format(AsAt));

                Evaluate(DFormula,'1Q');

                Cust.Reset;
                if loans.Source = loans.Source::FOSA then
                Cust.SetRange(Cust."No.",loans."BOSA No")
                else
                Cust.SetRange(Cust."No.",loans."Client Code");
                if Cust.Find('-') then begin
                Cust.CalcFields(Cust."Current Shares");
                PhoneNo := Cust."Phone No.";
                "StaffNo." := Cust."Personal No";
                Deposits := Cust."Current Shares";
                end;

                "0Month":=0;
                "1Month":=0;
                "2Month":=0;
                "3Month":=0;
                Over3Month:=0;
                DaysinArrears:=0;
                DurationInArrears:=0;
                RepaymentAmount:=0;
                loans.CalcFields(loans."Outstanding Balance",loans."Oustanding Interest",loans."Last Pay Date");

                //DaysinArrears:=AsAt-loans."Last Pay Date";

                DurationInArrears:=ROUND(DaysinArrears/30,1,'=');
                if (DurationInArrears >=0) and (DurationInArrears <1)   then begin
                "0Month":=loans."Outstanding Balance";
                "0MonthC":="0MonthC"+1;
                 Count1:=Count1+1;
                 "Loans Category":="loans category"::Perfoming;
                end else if (DurationInArrears >=1) and (DurationInArrears <2)  then begin
                "1Month":=loans."Outstanding Balance";
                "1MonthC":="1MonthC"+1;
                Count2:=Count2+1;
                 "Loans Category":="loans category"::Watch;
                end else if (DurationInArrears >=2) and (DurationInArrears <=6) then begin
                "2Month":=loans."Outstanding Balance";
                "2MonthC":="2MonthC"+1;
                Count3:=Count3+1;
                 "Loans Category":="loans category"::Substandard;
                end else if (DurationInArrears >6) and (DurationInArrears <=12) then begin
                "3Month":=loans."Outstanding Balance";
                "3MonthC":="3MonthC"+1;
                Count4:=Count4+1;
                 "Loans Category":="loans category"::Doubtful;
                end else if (DurationInArrears >12)  then begin
                Over3Month:=loans."Outstanding Balance";
                Over3MonthC:=Over3MonthC+1;
                Count5:=Count5+1;
                 "Loans Category":="loans category"::Loss;
                end;

                //    IF (NoofMonthsinArrears=0)  THEN BEGIN
                //    "0Month":="Loans Register"."Outstanding Balance";
                //    "0MonthC":="0MonthC"+1;
                //    END ELSE IF (NoofMonthsinArrears>0) AND (NoofMonthsinArrears<=1)THEN BEGIN
                //    "1Month":="Loans Register"."Outstanding Balance";
                //    "1MonthC":="1MonthC"+1;
                //    END ELSE  IF (NoofMonthsinArrears>1) AND (NoofMonthsinArrears<=6) THEN BEGIN
                //    "2Month":="Loans Register"."Outstanding Balance";
                //    "2MonthC":="2MonthC"+1;
                //    END ELSE  IF (NoofMonthsinArrears>6) AND (NoofMonthsinArrears<=12)THEN BEGIN
                //    "3Month":="Loans Register"."Outstanding Balance";
                //    "3MonthC":="3MonthC"+1;
                //    END ELSE IF (NoofMonthsinArrears>12) THEN BEGIN
                //    Over3Month:="Loans Register"."Outstanding Balance";
                //    Over3MonthC:=Over3MonthC+1;
                //    END;

                //loans.MODIFY;
                //DifinOutBal:=(loans.Frequency-loans."Amount In Arrears")*-1;
            end;

            trigger OnPreDataItem()
            begin
                CurrReport.CreateTotals("0Month","1Month","2Month","3Month",Over3Month);
                GrandTotal:=0;


                if AsAt = 0D then
                AsAt:=Today;
                DifinOutBal:=0;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(AsAt;AsAt)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cutoffdate';
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

    var
        "1Month": Decimal;
        "2Month": Decimal;
        "3Month": Decimal;
        Over3Month: Decimal;
        ShowLoan: Boolean;
        AsAt: Date;
        LastDueDate: Date;
        DFormula: DateFormula;
        "0MonthC": Integer;
        "1MonthC": Integer;
        "2MonthC": Integer;
        "3MonthC": Integer;
        Over3MonthC: Integer;
        NoLoans: Integer;
        PhoneNo: Text[50];
        Cust: Record "Member Register";
        "StaffNo.": Text[50];
        Deposits: Decimal;
        GrandTotal: Decimal;
        "0Month": Decimal;
        LoanProduct: Record "Loan Products Setup";
        FirstMonthDate: Date;
        EndMonthDate: Date;
        Loans_Aging_Analysis__SASRA_CaptionLbl: label 'Loans Aging Analysis (SASRA)';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Loan_TypeCaptionLbl: label 'Loan Type';
        Staff_No_CaptionLbl: label 'Staff No.';
        Oustanding_BalanceCaptionLbl: label 'Oustanding Balance';
        PerformingCaptionLbl: label 'Performing';
        V1___30_Days_CaptionLbl: label '(1 - 30 Days)';
        V0_Days_CaptionLbl: label '(0 Days)';
        WatchCaptionLbl: label 'Watch';
        V31___180_Days_CaptionLbl: label '(31 - 180 Days)';
        SubstandardCaptionLbl: label 'Substandard';
        V181___360_Days_CaptionLbl: label '(181 - 360 Days)';
        DoubtfulCaptionLbl: label 'Doubtful';
        Over_360_DaysCaptionLbl: label 'Over 360 Days';
        LossCaptionLbl: label 'Loss';
        TotalsCaptionLbl: label 'Totals';
        CountCaptionLbl: label 'Count';
        Grand_TotalCaptionLbl: label 'Grand Total';
        Usersetup: Record "User Setup";
        Count1: Integer;
        Count2: Integer;
        Count3: Integer;
        Count4: Integer;
        Count5: Integer;
        DurationInArrears: Integer;
        RepaymentAmount: Decimal;
        DifinOutBal: Decimal;
        DaysinArrears: Decimal;
}

