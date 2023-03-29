#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516460 "Generate Dormant A|C Fosa"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Generate Dormant AC Fosa.rdlc';

    dataset
    {
        dataitem(Vendor;Vendor)
        {
            DataItemTableView = where("Creditor Type"=const("Savings Account"),Status=const(Dormant));
            RequestFilterFields = "Account Type";
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
            column(No;Vendor."No.")
            {
            }
            column(Name;Vendor.Name)
            {
            }
            column(Account_Type;Vendor."Account Type")
            {
            }
            column(Status;Vendor.Status)
            {
            }
            column(Last_Transaction_Date;Vendor."Last Transaction Date")
            {
            }

            trigger OnAfterGetRecord()
            begin

                if AccountType.Get(Vendor."Account Type") then begin
                 Vendor.CalcFields(Vendor."Last Transaction Date");
                if Vendor."Last Transaction Date" <> 0D then begin
                if CalcDate(AccountType."Dormancy Period (M)",Vendor."Last Transaction Date") < Today then begin
                Vendor.Status:=Vendor.Status::Dormant;
                Vendor.Blocked:=Vendor.Blocked::All;
                Vendor.Modify;
                end
                else begin
                Vendor.Status:=Vendor.Status::Active;
                Vendor.Blocked:=Vendor.Blocked::" "  ;
                Vendor.Modify;

                end;
                end;

                end;
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

        SN:=SN+1;
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
        AccountType: Record "Account Types-Saving Products";
}

