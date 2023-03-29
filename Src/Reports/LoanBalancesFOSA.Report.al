#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516451 "Loan Balances FOSA"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Loan Balances FOSA.rdlc';

    dataset
    {
        dataitem("Loans Register";"Loans Register")
        {
            DataItemTableView = sorting("Loan  No.") where(Source=const(BOSA),"Outstanding Balance"=filter(>0));
            RequestFilterFields = "Loan Product Type","Application Date","Appraisal Status","Loan Status","Issued Date","Outstanding Balance","Current Shares","Date filter";
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
            column(S_No;SN)
            {
            }
            column(Loan_No;"Loans Register"."Loan  No.")
            {
            }
            column(Client_Code;"Loans Register"."Client Code")
            {
            }
            column(Client_Name;"Loans Register"."Client Name")
            {
            }
            column(Agencyr_Name;"Loans Register"."Employer Name")
            {
            }
            column(Loan_Product_Type;"Loans Register"."Loan Product Type Name")
            {
            }
            column(Approved_Amount;"Loans Register"."Approved Amount")
            {
            }
            column(Installments;"Loans Register".Installments)
            {
            }
            column(Remaining_Instl;RInst)
            {
            }
            column(Interest_Due;"Loans Register"."Interest Due")
            {
            }
            column(Outstanding_Bal;"Loans Register"."Outstanding Balance")
            {
            }

            trigger OnAfterGetRecord()
            begin

                IntAmount:=0;
                RInst:=0;
                if (Loans."Outstanding Balance" > 0) and (Loans.Interest > 0) then
                IntAmount:=ROUND((Loans."Outstanding Balance")*(Loans.Interest/1200),0.05,'>');

                if (Loans."Outstanding Balance" > 0) and (Loans.Repayment > 0) then
                //RInst:=ROUND(Loans."Outstanding Balance"/(Loans.Repayment-IntAmount),1,'>');

                 "Net Repayment":=Repayment-IntAmount;
            end;

            trigger OnPreDataItem()
            begin
                CurrReport.CreateTotals("Net Repayment");
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

    trigger OnInitReport()
    begin
                Company.Get();
                Company.CalcFields(Company.Picture);
    end;

    var
        Loans_RegisterCaptionLbl: label 'Approved Loans Report';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Loan_TypeCaptionLbl: label 'Loan Type';
        Client_No_CaptionLbl: label 'Client No.';
        Outstanding_LoanCaptionLbl: label 'Outstanding Loan';
        PeriodCaptionLbl: label 'Period';
        Approved_DateCaptionLbl: label 'Approved Date';
        Loan_TypeCaption_Control1102760043Lbl: label 'Loan Type';
        Verified_By__________________________________________________CaptionLbl: label 'Verified By..................................................';
        Confirmed_By__________________________________________________CaptionLbl: label 'Confirmed By..................................................';
        Sign________________________CaptionLbl: label 'Sign........................';
        Sign________________________Caption_Control1102755003Lbl: label 'Sign........................';
        Date________________________CaptionLbl: label 'Date........................';
        Date________________________Caption_Control1102755005Lbl: label 'Date........................';
        NameCreditOff: label 'Name......................................';
        NameCreditDate: label 'Date........................................';
        NameCreditSign: label 'Signature..................................';
        NameCreditMNG: label 'Name......................................';
        NameCreditMNGDate: label 'Date.....................................';
        NameCreditMNGSign: label 'Signature..................................';
        NameCEO: label 'Name........................................';
        NameCEOSign: label 'Signature...................................';
        NameCEODate: label 'Date.....................................';
        CreditCom1: label 'Name........................................';
        CreditCom1Sign: label 'Signature...................................';
        CreditCom1Date: label 'Date.........................................';
        CreditCom2: label 'Name........................................';
        CreditCom2Sign: label 'Signature....................................';
        CreditCom2Date: label 'Date..........................................';
        CreditCom3: label 'Name.........................................';
        CreditComDate3: label 'Date..........................................';
        CreditComSign3: label 'Signature..................................';
        Comment: label '....................';
        SN: Integer;
        Company: Record "Company Information";
        IntAmount: Decimal;
        RInst: Integer;
        "Net Repayment": Decimal;
        Loans: Record "Loans Register";
}

