#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516981 "loan aging"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/loan aging.rdlc';

    dataset
    {
        dataitem("Loans Register";"Loans Register")
        {
            DataItemTableView = sorting("Loan  No.") where("Outstanding Balance"=filter(>0),Posted=filter(true));
            RequestFilterFields = "Loan  No.","Loan Product Type","Outstanding Balance","Date filter";
            column(ReportForNavId_4645; 4645)
            {
            }
            column(FORMAT_TODAY_0_4_;Format(Today,0,4))
            {
            }
            column(COMPANYNAME;COMPANYNAME)
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
            column(CurrReport_PAGENO;CurrReport.PageNo)
            {
            }
            column(USERID;UserId)
            {
            }
            column(Loans__Loan__No__;"Loan  No.")
            {
            }
            column(Arrears;Arrears)
            {
            }
            column(Loans__Loan_Product_Type_;"Loan Product Type")
            {
            }
            column(Loans_Loans__Staff_No_;"Loans Register"."Staff No")
            {
            }
            column(Loans__Client_Name_;"Client Name")
            {
            }
            column(ClientCode_LoansRegister;"Loans Register"."Client Code")
            {
            }
            column(Loans_Loans__Outstanding_Balance_;"Loans Register"."Outstanding Balance")
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
            column(AmountinArrears_LoansRegister;"Loans Register"."Amount in Arrears")
            {
            }
            column(NoofMonthsinArrears_LoansRegister;"Loans Register"."No of Months in Arrears")
            {
            }
            column(Loans_Loans__Outstanding_Balance__Control1000000016;"Loans Register"."Outstanding Balance")
            {
            }
            column(InterestDue_LoansRegister;"Loans Register"."Interest Due")
            {
            }
            column(Loans__Approved_Amount_;"Approved Amount")
            {
            }
            column(Loans_Loans__Interest_Due_;"Loans Register"."Interest Due")
            {
            }
            column(TotalBalance;"Loans Register"."Outstanding Balance"+"Loans Register"."Interest Due")
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
            column(LoansCategory_LoansRegister;"Loans Register"."Loans Category")
            {
            }
            column(Sorting;Sorting)
            {
            }
            column(LoanProductType_LoansRegister;"Loans Register"."Loan Product Type")
            {
            }
            column(ApprovedAmount_LoansRegister;"Loans Register"."Approved Amount")
            {
            }
            column(IssuedDate_LoansRegister;"Loans Register"."Issued Date")
            {
            }
            column(Installments_LoansRegister;"Loans Register".Installments)
            {
            }
            column(LoanDisbursementDate_LoansRegister;"Loans Register"."Loan Disbursement Date")
            {
            }
            column(TotalPaid_LoansRegister;"Loans Register"."Total Paid")
            {
            }
            column(LoanBalanceatRescheduling_LoansRegister;"Loans Register"."Loan Balance at Rescheduling")
            {
            }
            column(LastPayDate_LoansRegister;"Loans Register"."Last Pay Date")
            {
            }
            column(RepaymentStartDate_LoansRegister;"Loans Register"."Repayment Start Date")
            {
            }
            column(CurrentRepayment_LoansRegister;"Loans Register"."Current Repayment")
            {
            }
            column(ExpectedDateofCompletion_LoansRegister;"Loans Register"."Expected Date of Completion")
            {
            }
            column(lastbalance;LBal)
            {
            }

            trigger OnAfterGetRecord()
            begin




                NoofMonthsinArrears:=0;
                ApprovedAmount:=0;
                DateDiff:=0;
                MonthlyRepayment:=0;
                ScheduledLoanBal:=0;
                LBal:=0;
                Arrears:=0;
                OutstandBal:=0;
                ExpectedDateofCompletion:=0D;
                RepaymentPeriod:=AsAt;


                //.................................................................................................................outsanding bal
                Loans.Reset;
                Loans.SetRange(Loans."Loan  No.","Loan  No.");
                if Loans.Find('-') then begin
                 /// IF Loans."Issued Date" <= AsAt THEN BEGIN
                      Loans.CalcFields("Outstanding Balance");
                      ApprovedAmount:=Loans."Outstanding Balance";
                      //MESSAGE(FORMAT(ApprovedAmount));
                //.............................................................................................Get Last Day of the previous month
                if Loans."Repayment Frequency"=Loans."repayment frequency"::Monthly then begin

                     LastMonth:=RepaymentPeriod;
                     Last2Months:=CalcDate('-1M',LastMonth);
                 end;
                 //.................................................................................................expected date of completion
                 ExpectedDateofCompletion:=CalcDate(Format(Loans.Installments)+'M',Loans."Issued Date");
                 //MESSAGE(FORMAT(ExpectedDateofCompletion));

                //...........................................................................................................Get Scheduled Balance

                  LSchedule.Reset;
                  LSchedule.SetRange(LSchedule."Loan No.","Loan  No.");
                  LSchedule.SetRange(LSchedule."Repayment Date",Last2Months,LastMonth);
                    if LSchedule.FindFirst then begin
                      ScheduledLoanBal:=ROUND(LSchedule."Loan Balance",1,'=');
                    end;
                   /// MESSAGE('ScheduledLoanBal IS sceh reg %1',ScheduledLoanBal);



                  LSchedule.Reset;
                  LSchedule.SetRange(LSchedule."Loan No.","Loan  No.");
                  LSchedule.SetRange(LSchedule."Instalment No",1);

                    if LSchedule.FindFirst then begin

                      MonthlyRepayment:=LSchedule."Principal Repayment";//Monthly Repayment
                     if (ScheduledLoanBal=0) and (LSchedule."Repayment Date">LastMonth) then
                       ScheduledLoanBal:=ApprovedAmount;
                    end else begin
                      ScheduledLoanBal:=0;
                    end;
                   //// MESSAGE('ScheduledLoanBal IS sceh reg %1',ScheduledLoanBal);

                //........................................................................................................Loans."Outstanding Balance
                  DateFilter:='..'+Format(LastMonth);
                  Loans.Reset;
                  Loans.SetRange(Loans."Loan  No.","Loan  No.");
                  Loans.SetFilter(Loans."Date filter",DateFilter);
                    if Loans.Find('-') then begin
                      Loans.CalcFields(Loans."Outstanding Balance",Loans."Oustanding Interest");

                      LBal:=Loans."Outstanding Balance";
                  ///   MESSAGE('LBal is %1',LBal);
                    end;



                 //..................................................................................................................end
                   //.........................................................................................issued date
                        issueddate:=CalcDate('1M',Loans."Issued Date");
                       if issueddate > AsAt then begin
                         Arrears:=0;
                         end else begin

                ////MESSAGE ('issueddate Is %1',issueddate);
                //......................................................................................................................arrear

                Arrears:=LBal-ScheduledLoanBal;
                end;
                 /// MESSAGE('Arrears ISouts on arrear %1 ',Arrears);
                  if (Arrears < 0) or (Arrears=0) then begin
                  Arrears:=0

                  end else
                  Arrears:=Arrears;
                  "Amount in Arrears":= Arrears;
                  Modify;
                 /// MESSAGE ('Arrears IS %1' ,Arrears);

                  //.........................................................................................................End Amount in Arrears
                  if Arrears<> 0 then begin
                      if MonthlyRepayment=0 then begin
                        NoofMonthsinArrears:=13;//12+
                         end else begin
                       // IF AsAt > CALCDATE+'M',Loans."Issued Date ca

                        DateDiff:=(LastMonth-ExpectedDateofCompletion)/30;
                        if DateDiff>=2 then begin
                          NoofMonthsinArrears:=13//13+;
                          end else begin
                          NoofMonthsinArrears:=ROUND((Arrears/MonthlyRepayment));
                        end;
                      end;
                  end;
                ///  MESSAGE ('NoofMonthsinArrears IS %1' ,NoofMonthsinArrears);
                  Cat:='';
                  //...........................................................................................................loan category
                  if (Arrears=0)  then begin
                    "Loans Register"."Loans Category":=Loans."loans category"::Perfoming;
                    Sorting:=1;
                    Cat:=Format(Loans."loans category"::Perfoming);
                  end else
                  if (NoofMonthsinArrears>=0) and (NoofMonthsinArrears<=2) then begin
                    "Loans Register"."Loans Category":=Loans."loans category"::Perfoming;
                    Sorting:=1;
                    Cat:=Format(Loans."loans category"::Perfoming);
                  end else
                  if (NoofMonthsinArrears>2) and (NoofMonthsinArrears<=3) then begin
                    "Loans Register"."Loans Category":=Loans."loans category"::Watch;
                    Sorting:=2;
                    Cat:=Format(Loans."loans category"::Watch);
                  end else
                  if (NoofMonthsinArrears>3) and (NoofMonthsinArrears<=6)then begin
                    "Loans Register"."Loans Category":=Loans."loans category"::Substandard;
                    Sorting:=3;
                    Cat:=Format(Loans."loans category"::Substandard);
                  end else
                  if (NoofMonthsinArrears>6) and (NoofMonthsinArrears<=12)then begin
                    "Loans Register"."Loans Category":=Loans."loans category"::Doubtful;
                    Sorting:=4;
                    Cat:=Format(Loans."loans category"::Doubtful);
                  end else
                  if (NoofMonthsinArrears>12) then begin
                    "Loans Register"."Loans Category":=Loans."loans category"::Loss;
                    Sorting:=5;
                    Cat:=Format(Loans."loans category"::Loss);
                  end;
                  //"No of Months in Arrears":=ROUND(NoofMonthsinArrears,1,'=');
                  //MODIFY(TRUE);
                  "Loans Register"."No of Months in Arrears":=ROUND(NoofMonthsinArrears,1,'=');
                  //"Loans Register"."Updated-SASRA":=TRUE;
                  "Loans Register".Modify(true);


                // //
                // //   TABLEArrears.INIT;
                // //   TABLEArrears.LoanNo:="Loans Register"."Loan  No.";
                // //   TABLEArrears.Balance:="Loans Register"."Outstanding Balance";
                // //   TABLEArrears.Schedule:=ScheduledLoanBal;
                // //   TABLEArrears.Arrears:=Arrears;
                // //   TABLEArrears.Repayment:=MonthlyRepayment;
                // //   TABLEArrears.Months:=NoofMonthsinArrears;
                // //   TABLEArrears."Member No":="Loans Register"."Client Code";
                // //   TABLEArrears."Member Name":="Loans Register"."Client Name";
                // //   TABLEArrears."Due Date":=ExpectedDateofCompletion;
                // //   TABLEArrears.Instalments:="Loans Register".Installments;
                // //   TABLEArrears."Repayment Start Date":="Loans Register"."Repayment Start Date";
                // //   TABLEArrears."Months In Arrears":=DateDiff;
                // //   TABLEArrears.Category:=Cat;
                // //   TABLEArrears.INSERT(TRUE);



                //    IF (Arrears=0)  THEN BEGIN
                //    "0Month":="Loans Register"."Outstanding Balance";
                //    "0MonthC":="0MonthC"+1;
                //    END ELSE
                    if (NoofMonthsinArrears>=0) and (NoofMonthsinArrears<=2)then begin
                    "0Month":=LBal;

                    "0MonthC":="0MonthC"+1;
                    end
                    else if (NoofMonthsinArrears>2) and (NoofMonthsinArrears<=3)then begin
                    "1Month":=LBal;
                    "1MonthC":="1MonthC"+1;
                    end else  if (NoofMonthsinArrears>3) and (NoofMonthsinArrears<=6) then begin
                    "2Month":=LBal;
                    "2MonthC":="2MonthC"+1;
                    end else  if (NoofMonthsinArrears>6) and (NoofMonthsinArrears<=12)then begin
                    "3Month":=LBal;
                    "3MonthC":="3MonthC"+1;
                    end else if (NoofMonthsinArrears>12) then begin
                    Over3Month:=LBal;
                    Over3MonthC:=Over3MonthC+1;
                    end;

                    GrandTotal:=GrandTotal+"Loans Register"."Outstanding Balance";

                    if ("0Month"+"1Month"+"2Month"+"3Month"+Over3Month) > 0 then
                    NoLoans:=NoLoans+1;

                end;
                ///END;
            end;

            trigger OnPreDataItem()
            begin
                CurrReport.CreateTotals("0Month","1Month","2Month","3Month",Over3Month);
                //CurrReport.CREATETOTALS("0Day","1Day","2Day","3Day",Over3Day);
                GrandTotal:=0;
                Company.Get();
                Company.CalcFields(Company.Picture);
                if AsAt = 0D then
                   // AsAt:=TODAY;


                DFilter:='..'+Format(AsAt);
                // IF AsAt = 0D THEN
                //  AsAt:=TODAY;
                "Loans Register".SetFilter("Loans Register"."Date filter",DFilter);
                //MemberLegEntry.SETFILTER(MemberLegEntry."Date Filter",DFilter);
                "Loans Register".SetFilter("Loans Register"."Issued Date",'<=%1',AsAt);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("As At";AsAt)
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

    trigger OnPreReport()
    begin
        // //   TABLEArrears.RESET;
        // //   TABLEArrears.SETFILTER(LoanNo,'<>%1','');
        // //   IF TABLEArrears.FIND('-') THEN BEGIN
        // //     REPEAT
        // //       TABLEArrears.DELETE;
        // //     UNTIL TABLEArrears.NEXT=0;
        // //   END;
    end;

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
        PhoneNo: Text[30];
        Cust: Record "Member Register";
        "StaffNo.": Text[30];
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
        "0Day": Decimal;
        "1Day": Decimal;
        "2Day": Decimal;
        "3Day": Decimal;
        Over3Day: Decimal;
        LSchedule: Record "Loan Repayment Schedule";
        RepaymentPeriod: Date;
        Loans: Record "Loans Register";
        LastMonth: Date;
        ScheduledLoanBal: Decimal;
        DateFilter: Text;
        LBal: Decimal;
        Arrears: Decimal;
        NoofMonthsinArrears: Decimal;
        Company: Record "Company Information";
        MonthlyRepayment: Decimal;
        Last2Months: Date;
        Sorting: Integer;
        ApprovedAmount: Decimal;
        ExpectedDateofCompletion: Date;
        DateDiff: Decimal;
        DFilter: Text;
        Cat: Text[30];
        MemberLegEntry: Record "Member Ledger Entry";
        OutstandBal: Decimal;
        issueddate: Date;
}

