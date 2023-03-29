#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516549 "Denied Dividend Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Denied Dividend Report.rdlc';

    dataset
    {
        dataitem(Customer; "Member Register")
        {
            DataItemTableView = sorting("No.") where("Member class" = filter("Class A"), Lstus = const('DENY'));
            RequestFilterFields = "No.";
            column(ReportForNavId_6836; 6836)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(USERID; UserId)
            {
            }
            column(Customer__No__; "No.")
            {
            }
            column(Customer_Name; Name)
            {
            }
            column(Customer_PhoneNo; "Phone No.")
            {
            }
            column(CustomerCaption; CustomerCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Customer__No__Caption; FieldCaption("No."))
            {
            }
            column(Customer_NameCaption; FieldCaption(Name))
            {
            }
            column(Customer__Current_Shares_Caption; FieldCaption("Current Shares"))
            {
            }
            column(SharesRetained_Customer; Customer."Shares Retained")
            {
            }
            column(CurrentShares_Customer; Customer."Current Shares")
            {
            }
            column(FOSAShares_Customer; Customer."FOSA Shares")
            {
            }
            column(Gross_Dividends; GrossDividends)
            {
            }
            column(WT_on_Dividends; WTonDividends)
            {
            }
            column(Intereston_FOSA_Shares; InterestonFOSAShares)
            {
            }
            column(Interest_on_Deposits; InterestonDeposits)
            {
            }
            column(Dividend_on_ShareCapital; DividendonShareCapital)
            {
            }
            column(Net_Dividends; NetDividends)
            {
            }

            trigger OnAfterGetRecord()
            begin
                /*EVALUATE(BDate,'01/01/05');
                FromDate:=BDate;
                 EVALUATE(ToDate,'12/31/21');
                EVALUATE(FromDateS,FORMAT(FromDate));
                EVALUATE(ToDateS,FORMAT(ToDate));

                DateFilter:=FromDateS+'..'+ToDateS;
                //DateFilter:='..'+ToDateS;
                Cust.RESET;
                Cust.SETCURRENTKEY("No.");
                Cust.SETRANGE(Cust."No.",Customer."No.");
                Cust.SETFILTER(Cust."Date Filter",DateFilter);
                Cust.SETFILTER(Cust."Member class",'Class A');

                IF Cust.FIND('-') THEN BEGIN

                  Cust.CALCFIELDS(Cust."Current Shares",Cust."Shares Retained",Cust."FOSA Shares");

                END;*/

                /*NetDividends:= ROUND(NetDividends, 1.0, '='); */

            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FieldNo("No.");

                Cust.Reset;
                //Cust.SETFILTER(Cust.update,'%1',FALSE);
                Cust.ModifyAll(Cust."Dividend Amount", 0);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
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

        BATCH_TEMPLATE := 'PAYMENTS';
        BATCH_NAME := 'DIVIDEND';
        DOCUMENT_NO := 'DIV_' + Format(PostingDate);
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
        GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
        GenJournalLine.DeleteAll;
    end;

    var
        CustomerCaptionLbl: label 'Customer';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        Cust: Record "Member Register";
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
        CInterest: Decimal;
        BDate: Date;
        CustR: Record "Member Register";
        IntRebTotal: Decimal;
        CIntReb: Decimal;
        LineNo: Integer;
        Gnjlline: Record "Gen. Journal Line";
        PostingDate: Date;
        "W/Tax": Decimal;
        CommDiv: Decimal;
        GenJournalLine: Record "Gen. Journal Line";
        SFactory: Codeunit "SURESTEP Factory";
        BATCH_NAME: Code[50];
        BATCH_TEMPLATE: Code[50];
        DOCUMENT_NO: Code[50];
        ObjGensetup: Record "Sacco General Set-Up";
        fshares: Decimal;
        qfosa: Integer;
        Objloans: Record "Loan App Witness";
        capt: Decimal;
        scaps: Decimal;
        npay: Decimal;
        divcapt: Decimal;
        GrossDividends: Decimal;
        WitholdingTax: Decimal;
        NetDividends: Decimal;
        MemberDeposits: Decimal;
        QualifyingDeposits: Decimal;
        InterestonDeposits: Decimal;
        WTOnDepositInterest: Decimal;
        ShareCapital: Decimal;
        QualifyingShareCapital: Decimal;
        DividendonShareCapital: Decimal;
        WTonDividends: Decimal;
        FosaShares: Decimal;
        QualifyingFOSAShares: Decimal;
        InterestonFOSAShares: Decimal;
        WTonInterestonFOSAShares: Decimal;
}

