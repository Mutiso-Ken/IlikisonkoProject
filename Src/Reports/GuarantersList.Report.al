#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516497 "Guaranters List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Guaranters List.rdlc';

    dataset
    {
        dataitem(loansG;"Loans Guarantee Details")
        {
            RequestFilterFields = "Loan No","Loan Balance","Self Guarantee","Loanees  No","Guarantor Outstanding","Employer Code";
            column(ReportForNavId_1000000000; 1000000000)
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
            column(CompanyLetter_Head;Company.Letter_Head)
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
            column(Loan_No;loansG."Loan No")
            {
            }
            column(Staff_No;loansG."Staff/Payroll No.")
            {
            }
            column(Member_No;loansG."Member No")
            {
            }
            column(Name;loansG.Name)
            {
                AutoCalcField = true;
            }
            column(Shares;loansG.Shares)
            {
            }
            column(Amount_Guaranteed;loansG."Amont Guaranteed")
            {
            }
            column(Account_No;loansG."Account No.")
            {
            }
            column(Self_Guaranteed;loansG."Self Guarantee")
            {
            }
            column(Total_LoanGuaranteed;loansG."Total Loans Guaranteed")
            {
            }
            column(No_Of_Loan_Guaranteed;loansG."No Of Loans Guaranteed")
            {
            }
            column(Loans_Outstanding;loansG."Loans Outstanding")
            {
            }
            column(Guarantor_Outstanding;loansG."Guarantor Outstanding")
            {
            }

            trigger OnPreDataItem()
            begin
                Company.Get();
                Company.CalcFields(Company.Picture,Letter_Head);
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

