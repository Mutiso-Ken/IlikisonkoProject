#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516601 "Generate Dividend-Prorata FOSA"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Generate Dividend-Prorata FOSA.rdlc';

    dataset
    {
        dataitem(Customer;Vendor)
        {
            DataItemTableView = sorting("No.") where("Account Type"=filter(<>5),"Vendor Posting Group"=filter(<>'VENDORS'));
            RequestFilterFields = Status,"No.","Date Filter","BOSA Account No";
            column(ReportForNavId_6836; 6836)
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
            column(CurrReport_PAGENOCaption;CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Customer__No__Caption;FieldCaption("No."))
            {
            }
            column(Customer_NameCaption;FieldCaption(Name))
            {
            }
            column(Customer__Current_Shares_Caption;FieldCaption("Current Shares"))
            {
            }

            trigger OnAfterGetRecord()
            begin
                
                /*Memb.RESET;
                Memb.SETRANGE(Memb."No.","No.");
                IF Memb.FIND('-') THEN BEGIN
                */
                //Customer."Div Amount":=0;
                
                
                
                
                if StartDate = 0D then
                Error('You must specify start Date.');
                
                DivTotal:=0;
                GenSetUp.Get(0);
                /*
                //1
                EVALUATE(BDate,'01/01/05');
                FromDate:=BDate;//StartDate;
                ToDate:=CALCDATE('-1D',CALCDATE('1M',StartDate));
                EVALUATE(FromDateS,FORMAT(FromDate));
                EVALUATE(ToDateS,FORMAT(ToDate));
                
                DateFilter:='..'+ToDateS;
                
                Cust.RESET;
                Cust.SETRANGE(Cust."No.",Customer."No.");
                Cust.SETFILTER(Cust."Date Filter",DateFilter);
                IF Cust.FIND('-') THEN BEGIN
                Cust.CALCFIELDS(Cust."Current Shares",Cust."Shares Retained");
                //IF Cust."Current Shares" <> 0 THEN BEGIN
                //CDiv:=((GenSetUp."Dividend (%)"/100)*((Cust."Current Shares"+Cust."Shares Retained")))*(12/12);
                
                CDiv:=(((GenSetUp."Share Dividend Value")*(Cust."Number of Shares")*12/12))+
                      (((GenSetUp."Interest on Deposits (%)"/100)*((Cust."Shares Retained")))*(12/12));
                
                
                InterestOnDeposits:=(((GenSetUp."Interest on Deposits (%)"/100)*((Cust."Current Shares")))*(12/12));
                DividendOnSharecap:=(GenSetUp."Dividend (%)"/100)*((Cust."Shares Retained"))*(12/12);
                //MESSAGE('Share capital %1',DateFilter);
                DivTotal:=CDiv;
                IF CDiv > 0 THEN BEGIN
                DivProg.INIT;
                DivProg."Member No":=Customer."No.";
                DivProg.Date:=ToDate;
                DivProg."Gross Dividends":=CDiv;
                DivProg."Gross Interest On Deposit":=InterestOnDeposits;
                DivProg."Dividend on Share Capital":=DividendOnSharecap;
                DivProg."Witholding Tax":=CDiv*(0/100);
                DivProg."Net Dividends":=DivProg."Gross Dividends"-DivProg."Witholding Tax";
                //DivProg."Qualifying Shares":=((Cust."Current Shares"+Cust."Shares Retained"))*(12/12);
                //DivProg.Shares:=((Cust."Current Shares"+Cust."Shares Retained"));
                DivProg."Qualifying Deposits":=(Cust."Shares Retained");
                DivProg.Shares:=(Cust."Current Shares");
                
                DivProg.INSERT;
                
                END;
                //END ELSE
                //DivTotal:=0;
                END;
                
                  {
                //Check if withdrawn
                Cust.RESET;
                Cust.SETRANGE(Cust."No.",Customer."No.");
                Cust.SETFILTER(Cust."Date Filter",'..'+ToDateS);
                IF Cust.FIND('-') THEN BEGIN
                Cust.CALCFIELDS(Cust."Current Shares");
                IF Cust."Current Shares" > -1 THEN BEGIN
                DivTotal:=0;
                
                DivProg.RESET;
                DivProg.SETRANGE(DivProg."Member No",Customer."No.");
                IF DivProg.FIND('-') THEN
                DivProg.DELETEALL;
                
                END;
                END;
                //Check if withdrawn
                
                
                            }
                
                //2
                FromDate:=CALCDATE('1M',StartDate);
                ToDate:=CALCDATE('-1D',CALCDATE('2M',StartDate));
                EVALUATE(FromDateS,FORMAT(FromDate));
                EVALUATE(ToDateS,FORMAT(ToDate));
                
                DateFilter:=FromDateS+'..'+ToDateS;
                //MESSAGE('Date Filter %1',DateFilter);
                Cust.RESET;
                Cust.SETRANGE(Cust."No.",Customer."No.");
                Cust.SETFILTER(Cust."Date Filter",DateFilter);
                IF Cust.FIND('-') THEN BEGIN
                Cust.CALCFIELDS(Cust."Current Shares",Cust."Shares Retained");
                //IF Cust."Current Shares" <> 0 THEN BEGIN
                //CDiv:=((GenSetUp."Dividend (%)"/100)*((Cust."Current Shares"+Cust."Shares Retained")))*(11/12);
                CDiv:=(((GenSetUp."Dividend (%)"/100)*((Cust."Current Shares")))*(11/12)) +
                      (((GenSetUp."Interest on Deposits (%)"/100)*((Cust."Shares Retained")))*(11/12));
                
                InterestOnDeposits:=(((GenSetUp."Interest on Deposits (%)"/100)*((Cust."Current Shares")))*(11/12));
                DividendOnSharecap:=(GenSetUp."Dividend (%)"/100)*((Cust."Shares Retained"))*(11/12);
                
                
                
                DivTotal:=DivTotal+CDiv;
                IF CDiv > 0 THEN BEGIN
                DivProg.INIT;
                DivProg."Member No":=Customer."No.";
                DivProg.Date:=ToDate;
                DivProg."Gross Dividends":=CDiv;
                DivProg."Dividend on Share Capital":= DividendOnSharecap;
                DivProg."Gross Interest On Deposit":=InterestOnDeposits;
                DivProg."Witholding Tax":=CDiv*(0/100);
                DivProg."Net Dividends":=DivProg."Gross Dividends"-DivProg."Witholding Tax";
                //DivProg."Qualifying Shares":=((Cust."Current Shares"+Cust."Shares Retained"))*(11/12);
                //DivProg.Shares:=((Cust."Current Shares"+Cust."Shares Retained"));
                DivProg."Qualifying Deposits":=(Cust."Shares Retained");
                DivProg.Shares:=(Cust."Current Shares");
                
                DivProg.INSERT;
                
                END;
                END;
                  {
                //Check if withdrawn
                Cust.RESET;
                Cust.SETRANGE(Cust."No.",Customer."No.");
                Cust.SETFILTER(Cust."Date Filter",'..'+ToDateS);
                IF Cust.FIND('-') THEN BEGIN
                Cust.CALCFIELDS(Cust."Current Shares");
                IF Cust."Current Shares" > -1 THEN BEGIN
                DivTotal:=0;
                
                DivProg.RESET;
                DivProg.SETRANGE(DivProg."Member No",Customer."No.");
                IF DivProg.FIND('-') THEN
                DivProg.DELETEALL;
                
                END;
                END;
                //Check if withdrawn
                
                   }
                
                //3
                FromDate:=CALCDATE('2M',StartDate);
                ToDate:=CALCDATE('-1D',CALCDATE('3M',StartDate));
                EVALUATE(FromDateS,FORMAT(FromDate));
                EVALUATE(ToDateS,FORMAT(ToDate));
                
                DateFilter:=FromDateS+'..'+ToDateS;
                //MESSAGE('Date Filter %1',DateFilter);
                Cust.RESET;
                Cust.SETRANGE(Cust."No.",Customer."No.");
                Cust.SETFILTER(Cust."Date Filter",DateFilter);
                IF Cust.FIND('-') THEN BEGIN
                Cust.CALCFIELDS(Cust."Current Shares",Cust."Shares Retained");
                //IF Cust."Current Shares" <> 0 THEN BEGIN
                //DivTotal:=DivTotal+((GenSetUp."Dividend (%)"/100)*((Cust."Current Shares"+Cust."Shares Retained")))*(10/12)
                //CDiv:=((GenSetUp."Dividend (%)"/100)*((Cust."Current Shares"+Cust."Shares Retained")))*(10/12);
                CDiv:=(((GenSetUp."Dividend (%)"/100)*((Cust."Current Shares")))*(10/12)) +
                      (((GenSetUp."Interest on Deposits (%)"/100)*((Cust."Shares Retained")))*(10/12));
                
                
                InterestOnDeposits:=(((GenSetUp."Interest on Deposits (%)"/100)*((Cust."Current Shares")))*(10/12));
                DividendOnSharecap:=(GenSetUp."Dividend (%)"/100)*((Cust."Shares Retained"))*(10/12);
                
                
                DivTotal:=DivTotal+CDiv;
                IF CDiv > 0 THEN BEGIN
                DivProg.INIT;
                DivProg."Member No":=Customer."No.";
                DivProg.Date:=ToDate;
                DivProg."Gross Dividends":=CDiv;
                DivProg."Gross Interest On Deposit":=InterestOnDeposits;
                DivProg."Dividend on Share Capital" :=DividendOnSharecap;
                DivProg."Witholding Tax":=CDiv*(0/100);
                DivProg."Net Dividends":=DivProg."Gross Dividends"-DivProg."Witholding Tax";
                //DivProg."Qualifying Shares":=((Cust."Current Shares"+Cust."Shares Retained"))*(10/12);
                //DivProg.Shares:=((Cust."Current Shares"+Cust."Shares Retained"));
                DivProg."Qualifying Deposits":=(Cust."Shares Retained");
                DivProg.Shares:=(Cust."Current Shares");
                
                DivProg.INSERT;
                
                END;
                END;
                    {
                //Check if withdrawn
                Cust.RESET;
                Cust.SETRANGE(Cust."No.",Customer."No.");
                Cust.SETFILTER(Cust."Date Filter",'..'+ToDateS);
                IF Cust.FIND('-') THEN BEGIN
                Cust.CALCFIELDS(Cust."Current Shares");
                IF Cust."Current Shares" > -1 THEN BEGIN
                DivTotal:=0;
                
                DivProg.RESET;
                DivProg.SETRANGE(DivProg."Member No",Customer."No.");
                IF DivProg.FIND('-') THEN
                DivProg.DELETEALL;
                
                END;
                END;
                //Check if withdrawn
                     }
                
                //4
                FromDate:=CALCDATE('3M',StartDate);
                ToDate:=CALCDATE('-1D',CALCDATE('4M',StartDate));
                EVALUATE(FromDateS,FORMAT(FromDate));
                EVALUATE(ToDateS,FORMAT(ToDate));
                
                DateFilter:=FromDateS+'..'+ToDateS;
                //MESSAGE('Date Filter %1',DateFilter);
                Cust.RESET;
                Cust.SETRANGE(Cust."No.",Customer."No.");
                Cust.SETFILTER(Cust."Date Filter",DateFilter);
                IF Cust.FIND('-') THEN BEGIN
                Cust.CALCFIELDS(Cust."Current Shares",Cust."Shares Retained");
                //IF Cust."Current Shares" <> 0 THEN BEGIN
                //DivTotal:=DivTotal+((GenSetUp."Dividend (%)"/100)*((Cust."Current Shares"+Cust."Shares Retained")))*(9/12)
                //CDiv:=((GenSetUp."Dividend (%)"/100)*((Cust."Current Shares"+Cust."Shares Retained")))*(9/12);
                CDiv:=(((GenSetUp."Dividend (%)"/100)*((Cust."Current Shares")))*(9/12)) +
                      (((GenSetUp."Interest on Deposits (%)"/100)*((Cust."Shares Retained")))*(9/12));
                
                
                InterestOnDeposits:=(((GenSetUp."Interest on Deposits (%)"/100)*((Cust."Current Shares")))*(9/12));
                DividendOnSharecap:=(GenSetUp."Dividend (%)"/100)*((Cust."Shares Retained"))*(9/12);
                
                
                DivTotal:=DivTotal+CDiv;
                IF CDiv > 0 THEN BEGIN
                DivProg.INIT;
                DivProg."Member No":=Customer."No.";
                DivProg.Date:=ToDate;
                DivProg."Gross Interest On Deposit":=InterestOnDeposits;
                DivProg."Dividend on Share Capital" :=DividendOnSharecap;
                DivProg."Gross Dividends":=CDiv;
                DivProg."Witholding Tax":=CDiv*(0/100);
                DivProg."Net Dividends":=DivProg."Gross Dividends"-DivProg."Witholding Tax";
                //DivProg."Qualifying Shares":=((Cust."Current Shares"+Cust."Shares Retained"))*(9/12);
                //DivProg.Shares:=((Cust."Current Shares"+Cust."Shares Retained"));
                DivProg."Qualifying Deposits":=(Cust."Shares Retained");
                DivProg.Shares:=(Cust."Current Shares");
                
                DivProg.INSERT;
                
                END;
                END;
                      {
                //Check if withdrawn
                Cust.RESET;
                Cust.SETRANGE(Cust."No.",Customer."No.");
                Cust.SETFILTER(Cust."Date Filter",'..'+ToDateS);
                IF Cust.FIND('-') THEN BEGIN
                Cust.CALCFIELDS(Cust."Current Shares");
                IF Cust."Current Shares" > -1 THEN BEGIN
                DivTotal:=0;
                
                DivProg.RESET;
                DivProg.SETRANGE(DivProg."Member No",Customer."No.");
                IF DivProg.FIND('-') THEN
                DivProg.DELETEALL;
                
                END;
                END;
                //Check if withdrawn
                       }
                
                //5
                FromDate:=CALCDATE('4M',StartDate);
                ToDate:=CALCDATE('-1D',CALCDATE('5M',StartDate));
                EVALUATE(FromDateS,FORMAT(FromDate));
                EVALUATE(ToDateS,FORMAT(ToDate));
                
                DateFilter:=FromDateS+'..'+ToDateS;
                Cust.RESET;
                Cust.SETRANGE(Cust."No.",Customer."No.");
                Cust.SETFILTER(Cust."Date Filter",DateFilter);
                IF Cust.FIND('-') THEN BEGIN
                Cust.CALCFIELDS(Cust."Current Shares",Cust."Shares Retained");
                //IF Cust."Current Shares" <> 0 THEN BEGIN
                //DivTotal:=DivTotal+((GenSetUp."Dividend (%)"/100)*((Cust."Current Shares"+Cust."Shares Retained")))*(8/12)
                //CDiv:=((GenSetUp."Dividend (%)"/100)*((Cust."Current Shares"+Cust."Shares Retained")))*(8/12);
                CDiv:=(((GenSetUp."Dividend (%)"/100)*((Cust."Current Shares")))*(8/12)) +
                      (((GenSetUp."Interest on Deposits (%)"/100)*((Cust."Shares Retained")))*(8/12));
                
                
                
                InterestOnDeposits:=(((GenSetUp."Interest on Deposits (%)"/100)*((Cust."Current Shares")))*(8/12));
                DividendOnSharecap:=(GenSetUp."Dividend (%)"/100)*((Cust."Shares Retained"))*(8/12);
                
                
                
                DivTotal:=DivTotal+CDiv;
                IF CDiv > 0 THEN BEGIN
                DivProg.INIT;
                DivProg."Member No":=Customer."No.";
                DivProg.Date:=ToDate;
                DivProg."Gross Dividends":=CDiv;
                DivProg."Gross Interest On Deposit":=InterestOnDeposits;
                DivProg."Dividend on Share Capital" :=DividendOnSharecap;
                DivProg."Witholding Tax":=CDiv*(0/100);
                DivProg."Net Dividends":=DivProg."Gross Dividends"-DivProg."Witholding Tax";
                //DivProg."Qualifying Shares":=((Cust."Current Shares"+Cust."Shares Retained"))*(8/12);
                //DivProg.Shares:=((Cust."Current Shares"+Cust."Shares Retained"));
                DivProg."Qualifying Deposits":=(Cust."Shares Retained");
                DivProg.Shares:=(Cust."Current Shares");
                
                DivProg.INSERT;
                
                END;
                END;
                        {
                //Check if withdrawn
                Cust.RESET;
                Cust.SETRANGE(Cust."No.",Customer."No.");
                Cust.SETFILTER(Cust."Date Filter",'..'+ToDateS);
                IF Cust.FIND('-') THEN BEGIN
                Cust.CALCFIELDS(Cust."Current Shares");
                IF Cust."Current Shares" > -1 THEN BEGIN
                DivTotal:=0;
                
                DivProg.RESET;
                DivProg.SETRANGE(DivProg."Member No",Customer."No.");
                IF DivProg.FIND('-') THEN
                DivProg.DELETEALL;
                
                END;
                END;
                //Check if withdrawn
                         }
                
                //6
                FromDate:=CALCDATE('5M',StartDate);
                ToDate:=CALCDATE('-1D',CALCDATE('6M',StartDate));
                EVALUATE(FromDateS,FORMAT(FromDate));
                EVALUATE(ToDateS,FORMAT(ToDate));
                
                DateFilter:=FromDateS+'..'+ToDateS;
                //MESSAGE('Date Filter month 6 %1',DateFilter);
                Cust.RESET;
                Cust.SETRANGE(Cust."No.",Customer."No.");
                Cust.SETFILTER(Cust."Date Filter",DateFilter);
                IF Cust.FIND('-') THEN BEGIN
                Cust.CALCFIELDS(Cust."Current Shares",Cust."Shares Retained");
                //IF Cust."Current Shares" <> 0 THEN BEGIN
                //DivTotal:=DivTotal+((GenSetUp."Dividend (%)"/100)*((Cust."Current Shares"+Cust."Shares Retained")))*(7/12)
                //CDiv:=((GenSetUp."Dividend (%)"/100)*((Cust."Current Shares"+Cust."Shares Retained")))*(7/12);
                CDiv:=(((GenSetUp."Dividend (%)"/100)*((Cust."Current Shares")))*(7/12)) +
                      (((GenSetUp."Interest on Deposits (%)"/100)*((Cust."Shares Retained")))*(7/12));
                
                
                
                InterestOnDeposits:=(((GenSetUp."Interest on Deposits (%)"/100)*((Cust."Current Shares")))*(7/12));
                DividendOnSharecap:=(GenSetUp."Dividend (%)"/100)*((Cust."Shares Retained"))*(7/12);
                
                
                
                DivTotal:=DivTotal+CDiv;
                IF CDiv > 0 THEN BEGIN
                DivProg.INIT;
                DivProg."Member No":=Customer."No.";
                DivProg.Date:=ToDate;
                DivProg."Gross Dividends":=CDiv;
                DivProg."Gross Interest On Deposit":=InterestOnDeposits;
                DivProg."Dividend on Share Capital" :=DividendOnSharecap;
                DivProg."Witholding Tax":=CDiv*(0/100);
                DivProg."Net Dividends":=DivProg."Gross Dividends"-DivProg."Witholding Tax";
                //DivProg."Qualifying Shares":=((Cust."Current Shares"+Cust."Shares Retained"))*(7/12);
                //DivProg.Shares:=((Cust."Current Shares"+Cust."Shares Retained"));
                DivProg."Qualifying Deposits":=(Cust."Shares Retained");
                DivProg.Shares:=(Cust."Current Shares");
                
                DivProg.INSERT;
                
                END;
                END;
                          {
                //Check if withdrawn
                Cust.RESET;
                Cust.SETRANGE(Cust."No.",Customer."No.");
                Cust.SETFILTER(Cust."Date Filter",'..'+ToDateS);
                IF Cust.FIND('-') THEN BEGIN
                Cust.CALCFIELDS(Cust."Current Shares");
                IF Cust."Current Shares" > -1 THEN BEGIN
                DivTotal:=0;
                
                DivProg.RESET;
                DivProg.SETRANGE(DivProg."Member No",Customer."No.");
                IF DivProg.FIND('-') THEN
                DivProg.DELETEALL;
                
                END;
                END;
                //Check if withdrawn
                           }
                
                //7
                FromDate:=CALCDATE('6M',StartDate);
                ToDate:=CALCDATE('-1D',CALCDATE('7M',StartDate));
                EVALUATE(FromDateS,FORMAT(FromDate));
                EVALUATE(ToDateS,FORMAT(ToDate));
                
                DateFilter:=FromDateS+'..'+ToDateS;
                Cust.RESET;
                Cust.SETRANGE(Cust."No.",Customer."No.");
                Cust.SETFILTER(Cust."Date Filter",DateFilter);
                IF Cust.FIND('-') THEN BEGIN
                Cust.CALCFIELDS(Cust."Current Shares",Cust."Shares Retained",Cust."Number of Shares");
                //IF Cust."Current Shares" <> 0 THEN BEGIN
                {
                DetailedLedger.RESET;
                DetailedLedger.SETRANGE(DetailedLedger."Customer No.",Customer."No.");
                DetailedLedger.SETRANGE(DetailedLedger."Transaction Type",DetailedLedger."Transaction Type"::"Deposit Contribution");
                DetailedLedger.SETFILTER(DetailedLedger."Posting Date",DateFilter);
                DetailedLedger.SETFILTER(DetailedLedger.Description,'%1|%2|%3|%4','Excess Deposits - Interest Paid',
                'Excess Deposits - Loan Repaymens','Excess Deposits - Deposits Contribution','Excess Deposits - Ins. Contribution');
                IF DetailedLedger.FIND('-') THEN BEGIN
                REPEAT
                DetailedLedger.CALCFIELDS(DetailedLedger.Amount);
                Excess:=Excess+DetailedLedger.Amount;
                UNTIL DetailedLedger.NEXT=0;
                END;
                MESSAGE('%1',Excess);
                 }
                
                
                //DivTotal:=DivTotal+((GenSetUp."Dividend (%)"/100)*((Cust."Current Shares"+Cust."Shares Retained")))*(6/12)
                //CDiv:=((GenSetUp."Dividend (%)"/100)*((Cust."Current Shares"+Cust."Shares Retained")))*(6/12);
                CDiv:=(((GenSetUp."Share Dividend Value")*(Cust."Number of Shares")*6/12)) +
                      (((GenSetUp."Interest on Deposits (%)"/100)*((Cust."Shares Retained")))*(6/12));
                
                
                
                InterestOnDeposits:=(((GenSetUp."Interest on Deposits (%)"/100)*((Cust."Current Shares")))*(6/12));
                DividendOnSharecap:=((GenSetUp."Share Dividend Value")*(Cust."Number of Shares")*6/12);
                
                
                DivTotal:=DivTotal+CDiv;
                IF CDiv > 0 THEN BEGIN
                DivProg.INIT;
                DivProg."Member No":=Customer."No.";
                DivProg.Date:=ToDate;
                DivProg."Gross Dividends":=CDiv;
                DivProg."Gross Interest On Deposit":=InterestOnDeposits;
                DivProg."Dividend on Share Capital" :=DividendOnSharecap;
                DivProg."Witholding Tax":=CDiv*(0/100);
                DivProg."Net Dividends":=DivProg."Gross Dividends"-DivProg."Witholding Tax";
                //DivProg."Qualifying Shares":=((Cust."Current Shares"+Cust."Shares Retained"))*(6/12);
                //DivProg.Shares:=((Cust."Current Shares"+Cust."Shares Retained"));
                DivProg."Qualifying Deposits":=(Cust."Shares Retained");
                DivProg.Shares:=(Cust."Current Shares");
                DivProg."No of Shares":=Cust."Number of Shares";
                DivProg.INSERT;
                
                END;
                END;
                            {
                //Check if withdrawn
                Cust.RESET;
                Cust.SETRANGE(Cust."No.",Customer."No.");
                Cust.SETFILTER(Cust."Date Filter",'..'+ToDateS);
                IF Cust.FIND('-') THEN BEGIN
                Cust.CALCFIELDS(Cust."Current Shares");
                IF Cust."Current Shares" > -1 THEN BEGIN
                DivTotal:=0;
                
                DivProg.RESET;
                DivProg.SETRANGE(DivProg."Member No",Customer."No.");
                IF DivProg.FIND('-') THEN
                DivProg.DELETEALL;
                
                END;
                END;
                //Check if withdrawn
                             }
                *////uncomnt after 2018
                
                //8
                FromDate:=CalcDate('7M',StartDate);
                FromDate:=20180908D;
                ToDate:=CalcDate('-1D',CalcDate('8M',StartDate));
                Evaluate(FromDateS,Format(FromDate));
                Evaluate(ToDateS,Format(ToDate));
                CDiv:=0;
                DateFilter:=FromDateS+'..'+ToDateS;
                Cust.Reset;
                Cust.SetRange(Cust."No.",Customer."No.");
                Cust.SetFilter(Cust."Date Filter",DateFilter);
                if Cust.Find('-') then begin
                Cust.CalcFields(Cust.Balance);
                if ProdSetup.Get(Cust."Account Type") then
                InterestOnDeposits:=(((ProdSetup."Interest Rate"/100)*((Cust.Balance)))*(5/12));
                //MESSAGE('here InterestOnDeposits %1  Account type %2 interest rate %3  date filter %4',InterestOnDeposits,Cust."Account Type",ProdSetup."Interest Rate",DateFilter);
                CDiv:=InterestOnDeposits;
                //MESSAGE('here %1',Cust.Balance);
                DivTotal:=DivTotal+CDiv;
                if CDiv > 0 then begin
                DivProg.Init;
                DivProg.source:=DivProg.Source::FOSA;
                //DivProg."Account Type":=Cust."Account Type";
                DivProg."Member No":=Cust."BOSA Account No";
                DivProg."Member No":=Customer."No.";
                DivProg.Date:=ToDate;
                DivProg."Gross Dividends":=CDiv;
                DivProg."Dividend on Share Capital":=InterestOnDeposits;
                //DivProg."Dividend on Share Capital" :=DividendOnSharecap;
                DivProg."Witholding Tax":=CDiv*(GenSetUp."Withholding Tax (%)"/100);;
                DivProg."Net Dividends":=DivProg."Gross Dividends"-DivProg."Witholding Tax";
                //DivProg."Qualifying Shares":=((Cust."Current Shares"+Cust."Shares Retained"))*(5/12);
                //DivProg."Qualifying Deposits":=(Cust.Balance);
                
                //DivProg."Qualifying Share Capital":=(Cust."Shares Retained");
                //DivProg."No of Shares":=Cust."Number of Shares";
                DivProg.Insert;
                
                end;
                end;
                              /*
                //Check if withdrawn
                Cust.RESET;
                Cust.SETRANGE(Cust."No.",Customer."No.");
                Cust.SETFILTER(Cust."Date Filter",'..'+ToDateS);
                IF Cust.FIND('-') THEN BEGIN
                Cust.CALCFIELDS(Cust."Current Shares");
                IF Cust."Current Shares" > -1 THEN BEGIN
                DivTotal:=0;
                
                DivProg.RESET;
                DivProg.SETRANGE(DivProg."Member No",Customer."No.");
                IF DivProg.FIND('-') THEN
                DivProg.DELETEALL;
                
                END;
                END;
                //Check if withdrawn
                */
                //Month9
                
                //9
                FromDate:=CalcDate('8M',StartDate);
                //FromDate:=20180908D;
                ToDate:=CalcDate('-1D',CalcDate('9M',StartDate));
                Evaluate(FromDateS,Format(FromDate));
                Evaluate(ToDateS,Format(ToDate));
                CDiv:=0;
                DateFilter:=FromDateS+'..'+ToDateS;
                Cust.Reset;
                Cust.SetRange(Cust."No.",Customer."No.");
                Cust.SetFilter(Cust."Date Filter",DateFilter);
                if Cust.Find('-') then begin
                Cust.CalcFields(Cust.Balance);
                if ProdSetup.Get(Cust."Account Type") then
                InterestOnDeposits:=(((ProdSetup."Interest Rate"/100)*((Cust.Balance)))*(4/12));
                
                CDiv:=InterestOnDeposits;
                
                DivTotal:=DivTotal+CDiv;
                if CDiv > 0 then begin
                DivProg.Init;
                DivProg.source:=DivProg.Source::FOSA;
                //DivProg."Account Type":=Cust."Account Type";
                DivProg."Member No":=Cust."BOSA Account No";
                DivProg."Member No":=Customer."No.";
                DivProg.Date:=ToDate;
                DivProg."Gross Dividends":=CDiv;
                DivProg."Dividend on Share Capital":=InterestOnDeposits;
                //DivProg."Dividend on Share Capital" :=DividendOnSharecap;
                DivProg."Witholding Tax":=CDiv*(GenSetUp."Withholding Tax (%)"/100);;
                DivProg."Net Dividends":=DivProg."Gross Dividends"-DivProg."Witholding Tax";
                //DivProg."Qualifying Shares":=((Cust."Current Shares"+Cust."Shares Retained"))*(5/12);
                //DivProg."Qualifying Deposits":=(Cust.Balance);
                //DivProg."Qualifying Share Capital":=(Cust."Shares Retained");
                //DivProg."No of Shares":=Cust."Number of Shares";
                DivProg.Insert;
                
                end;
                end;
                //end month 9
                
                
                //month 10
                
                //10
                FromDate:=CalcDate('9M',StartDate);
                //FromDate:=20180908D;
                ToDate:=CalcDate('-1D',CalcDate('10M',StartDate));
                Evaluate(FromDateS,Format(FromDate));
                Evaluate(ToDateS,Format(ToDate));
                CDiv:=0;
                DateFilter:=FromDateS+'..'+ToDateS;
                Cust.Reset;
                Cust.SetRange(Cust."No.",Customer."No.");
                Cust.SetFilter(Cust."Date Filter",DateFilter);
                if Cust.Find('-') then begin
                Cust.CalcFields(Cust.Balance);
                if ProdSetup.Get(Cust."Account Type") then
                InterestOnDeposits:=(((ProdSetup."Interest Rate"/100)*((Cust.Balance)))*(3/12));
                
                CDiv:=InterestOnDeposits;
                
                DivTotal:=DivTotal+CDiv;
                if CDiv > 0 then begin
                DivProg.Init;
                DivProg.source:=DivProg.Source::FOSA;
                //DivProg."Account Type":=Cust."Account Type";
                DivProg."Member No":=Cust."BOSA Account No";
                DivProg."Member No":=Customer."No.";
                DivProg.Date:=ToDate;
                DivProg."Gross Dividends":=CDiv;
                DivProg."Dividend on Share Capital":=InterestOnDeposits;
                //DivProg."Dividend on Share Capital" :=DividendOnSharecap;
                DivProg."Witholding Tax":=CDiv*(GenSetUp."Withholding Tax (%)"/100);;
                DivProg."Net Dividends":=DivProg."Gross Dividends"-DivProg."Witholding Tax";
                //DivProg."Qualifying Shares":=((Cust."Current Shares"+Cust."Shares Retained"))*(5/12);
                //DivProg."Qualifying Deposits":=(Cust.Balance);
                //DivProg."Qualifying Share Capital":=(Cust."Shares Retained");
                //DivProg."No of Shares":=Cust."Number of Shares";
                DivProg.Insert;
                
                end;
                end;
                //end month 10
                
                //Month 11
                //11
                FromDate:=CalcDate('10M',StartDate);
                //FromDate:=20180908D;
                ToDate:=CalcDate('-1D',CalcDate('11M',StartDate));
                Evaluate(FromDateS,Format(FromDate));
                Evaluate(ToDateS,Format(ToDate));
                CDiv:=0;
                DateFilter:=FromDateS+'..'+ToDateS;
                Cust.Reset;
                Cust.SetRange(Cust."No.",Customer."No.");
                Cust.SetFilter(Cust."Date Filter",DateFilter);
                if Cust.Find('-') then begin
                Cust.CalcFields(Cust.Balance);
                if ProdSetup.Get(Cust."Account Type") then
                InterestOnDeposits:=(((ProdSetup."Interest Rate"/100)*((Cust.Balance)))*(2/12));
                
                CDiv:=InterestOnDeposits;
                
                DivTotal:=DivTotal+CDiv;
                if CDiv > 0 then begin
                DivProg.Init;
                DivProg.source:=DivProg.Source::FOSA;
                //DivProg."Account Type":=Cust."Account Type";
                DivProg."Member No":=Cust."BOSA Account No";
                DivProg."Member No":=Customer."No.";
                DivProg.Date:=ToDate;
                DivProg."Gross Dividends":=CDiv;
                DivProg."Dividend on Share Capital":=InterestOnDeposits;
                //DivProg."Dividend on Share Capital" :=DividendOnSharecap;
                DivProg."Witholding Tax":=CDiv*(GenSetUp."Withholding Tax (%)"/100);;
                DivProg."Net Dividends":=DivProg."Gross Dividends"-DivProg."Witholding Tax";
                //DivProg."Qualifying Shares":=((Cust."Current Shares"+Cust."Shares Retained"))*(5/12);
                //DivProg."Qualifying Deposits":=(Cust.Balance);
                //DivProg."Qualifying Share Capital":=(Cust."Shares Retained");
                //DivProg."No of Shares":=Cust."Number of Shares";
                DivProg.Insert;
                
                end;
                end;
                //End Month 11
                
                
                
                //Month 12
                //10
                FromDate:=CalcDate('11M',StartDate);
                //FromDate:=20180908D;
                ToDate:=CalcDate('-1D',CalcDate('12M',StartDate));
                Evaluate(FromDateS,Format(FromDate));
                Evaluate(ToDateS,Format(ToDate));
                CDiv:=0;
                DateFilter:=FromDateS+'..'+ToDateS;
                Cust.Reset;
                Cust.SetRange(Cust."No.",Customer."No.");
                Cust.SetFilter(Cust."Date Filter",DateFilter);
                if Cust.Find('-') then begin
                Cust.CalcFields(Cust.Balance);
                if ProdSetup.Get(Cust."Account Type") then
                InterestOnDeposits:=(((ProdSetup."Interest Rate"/100)*((Cust.Balance)))*(1/12));
                
                CDiv:=InterestOnDeposits;
                
                DivTotal:=DivTotal+CDiv;
                if CDiv > 0 then begin
                DivProg.Init;
                DivProg.source:=DivProg.Source::FOSA;
                //DivProg."Account Type":=Cust."Account Type";
                DivProg."Member No":=Cust."BOSA Account No";
                DivProg."Member No":=Customer."No.";
                DivProg.Date:=ToDate;
                DivProg."Gross Dividends":=CDiv;
                DivProg."Dividend on Share Capital":=InterestOnDeposits;
                //DivProg."Dividend on Share Capital" :=DividendOnSharecap;
                DivProg."Witholding Tax":=CDiv*(GenSetUp."Withholding Tax (%)"/100);;
                DivProg."Net Dividends":=DivProg."Gross Dividends"-DivProg."Witholding Tax";
                //DivProg."Qualifying Shares":=((Cust."Current Shares"+Cust."Shares Retained"))*(5/12);
                //DivProg."Qualifying Deposits":=(Cust.Balance);
                //DivProg."Qualifying Share Capital":=(Cust."Shares Retained");
                //DivProg."No of Shares":=Cust."Number of Shares";
                DivProg.Insert;
                
                end;
                end;
                //End Month 12
                
                //Customer."Div Amount":=DivTotal;
                //Customer.MODIFY;
                //END
                
                ToDate:=CalcDate('-1D',CalcDate('12M',StartDate));
                DateFilter:='..'+ToDateS;
                /*
                //remove all members with zero share capital at the end of the year
                Cust.RESET;
                Cust.SETRANGE(Cust."No.","No.");
                Cust.SETFILTER(Cust."Date Filter",DateFilter);
                IF Cust.FIND('-') THEN BEGIN
                Cust.CALCFIELDS(Cust."Shares Retained");
                IF (Cust."Shares Retained" < 1 )THEN BEGIN
                //MESSAGE('To Delete details %1',Cust."No.");
                //MESSAGE('Member %1 Share capital was %3 at the end of the year  %2 and hence removed from schedule',Cust.Name ,Cust."No.",Cust."Shares Retained");
                DivProg.RESET;
                DivProg.SETRANGE(DivProg."Member No",Cust."No.");
                IF DivProg.FINDSET(TRUE) THEN BEGIN
                REPEAT
                DivProg.DELETE;
                UNTIL DivProg.NEXT = 0;
                END;
                END;
                END;
                */
                /*
                Cust.RESET;
                Cust.SETRANGE(Cust."No.","No.");
                Cust.SETFILTER(Cust."Date Filter",DateFilter);
                IF Cust.FIND('-') THEN BEGIN
                Cust.CALCFIELDS(Cust."Current Shares");
                IF Cust."Current Shares" < 1 THEN BEGIN
                DivProg.RESET;
                DivProg.SETRANGE(DivProg."Member No",Cust."No.");
                IF DivProg.FINDSET(TRUE) THEN BEGIN
                REPEAT
                DivProg."Gross Interest On Deposit":= 0 ;
                DivProg."Gross Dividends":=DivProg."Dividend on Share Capital";
                DivProg."Net Dividends":=DivProg."Dividend on Share Capital";
                DivProg.Shares:=0;
                DivProg.MODIFY;
                UNTIL DivProg.NEXT = 0;
                END;
                END;
                END;
                */

            end;

            trigger OnPreDataItem()
            begin

                LastFieldNo := FieldNo("No.");

                //Cust.RESET;
                //Cust.MODIFYALL(Cust."Div Amount",0);


                DivProg.Reset;
                DivProg.SetRange(DivProg.source,DivProg.Source::FOSA);
                if DivProg.Find('-') then
                DivProg.DeleteAll;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(StartDate;StartDate)
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

    var
        CustomerCaptionLbl: label 'Customer';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        Cust: Record Vendor;
        StartDate: Date;
        DateFilter: Text[100];
        FromDate: Date;
        ToDate: Date;
        FromDateS: Text[100];
        ToDateS: Text[100];
        DivTotal: Decimal;
        GenSetUp: Record "Sacco General Set-Up";
        CDeposits: Decimal;
        CustDiv: Record "Member Register";
        DivProg: Record "Dividends Progression";
        CDiv: Decimal;
        BDate: Date;
        CustR: Record "Member Register";
        IntRebTotal: Decimal;
        CIntReb: Decimal;
        LineNo: Integer;
        Gnjlline: Record "Gen. Journal Line";
        PostingDate: Date;
        "W/Tax": Decimal;
        CommDiv: Decimal;
        InterestOnDeposits: Decimal;
        DividendOnSharecap: Decimal;
        Memb: Record "Member Register";
        ProdSetup: Record "Account Types-Saving Products";
}

