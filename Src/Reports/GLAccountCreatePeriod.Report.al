#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516871 "G/L Account Create/Period"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/GL Account CreatePeriod.rdlc';

    dataset
    {
        dataitem("G/L Account";"G/L Account")
        {
            RequestFilterFields = "Date Created","Created By",Balance;
            column(ReportForNavId_1000000000; 1000000000)
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
            column(DateCreated_GLAccount;Format("G/L Account"."Date Created"))
            {
            }
            column(CreatedBy_GLAccount;"G/L Account"."Created By")
            {
            }
            column(Balance_GLAccount;"G/L Account".Balance)
            {
            }
            column(IncomeBalance_GLAccount;"G/L Account"."Income/Balance")
            {
            }
            column(AccountType_GLAccount;"G/L Account"."Account Type")
            {
            }
            column(No_GLAccount;"G/L Account"."No.")
            {
            }
            column(Name_GLAccount;"G/L Account".Name)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Company.Get();
                Company.CalcFields(Company.Picture);
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

    var
        Company: Record "Company Information";
}

