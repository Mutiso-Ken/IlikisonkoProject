#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516453 "Active Accounts"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Active Accounts.rdlc';

    dataset
    {
        dataitem(Customer;"Member Register")
        {
            DataItemTableView = sorting("No.") where("Customer Type"=const(Member),Status=filter(Active),"Current Shares"=filter(>0));
            RequestFilterFields = "No.";
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
            column(No;Customer."No.")
            {
            }
            column(Name;Customer.Name)
            {
            }
            column(Current_Shares;Customer."Current Shares")
            {
            }
            column(LastPaymentDate_Customer;Customer."Last Payment Date")
            {
            }
            column(runningno;runningno)
            {
            }

            trigger OnAfterGetRecord()
            begin
                runningno:=runningno+1;
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
        Company.Get;
        Company.CalcFields(Picture);
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
        GenSetup: Record "Sacco General Set-Up";
        Cust: Record "Member Register";
        AsAt: Date;
        DateFilter: Text[30];
        DormancyDate: Date;
        runningno: Integer;
}

