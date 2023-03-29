#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516456 "Checkoff Distribution Slip"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Checkoff Distribution Slip.rdlc';

    dataset
    {
        dataitem("Company Information";"Company Information")
        {
            CalcFields = Picture;
            column(ReportForNavId_15; 15)
            {
            }
            column(Name_CompanyInformation;"Company Information".Name)
            {
            }
            column(Name2_CompanyInformation;"Company Information"."Name 2")
            {
            }
            column(Address_CompanyInformation;"Company Information".Address)
            {
            }
            column(City_CompanyInformation;"Company Information".City)
            {
            }
            column(PhoneNo_CompanyInformation;"Company Information"."Phone No.")
            {
            }
            column(Picture_CompanyInformation;"Company Information".Picture)
            {
            }
            dataitem("Member Register";"Member Register")
            {
                RequestFilterFields = "No.";
                column(ReportForNavId_1; 1)
                {
                }
                column(No_MembersRegister;"Member Register"."No.")
                {
                }
                column(Name_MembersRegister;"Member Register".Name)
                {
                }
                dataitem("Checkoff Processing Details(B)";"Checkoff Processing Details(B)")
                {
                    DataItemLink = "Member No"=field("No.");
                    RequestFilterFields = "Check Off No";
                    column(ReportForNavId_4; 4)
                    {
                    }
                    column(CheckOffNo_CheckoffProcessingDetailsB;"Checkoff Processing Details(B)"."Check Off No")
                    {
                    }
                    column(CheckOffAdviceNo_CheckoffProcessingDetailsB;"Checkoff Processing Details(B)"."Check Off Advice No")
                    {
                    }
                    column(CheckOffDate_CheckoffProcessingDetailsB;"Checkoff Processing Details(B)"."Check Off Date")
                    {
                    }
                    column(MemberNo_CheckoffProcessingDetailsB;"Checkoff Processing Details(B)"."Member No")
                    {
                    }
                    column(TransactionType_CheckoffProcessingDetailsB;"Checkoff Processing Details(B)"."Transaction Type")
                    {
                    }
                    column(LoanProduct_CheckoffProcessingDetailsB;"Checkoff Processing Details(B)"."Loan Product")
                    {
                    }
                    column(LoanNo_CheckoffProcessingDetailsB;"Checkoff Processing Details(B)"."Loan No")
                    {
                    }
                    column(Amount_CheckoffProcessingDetailsB;"Checkoff Processing Details(B)".Amount)
                    {
                    }
                    column(OutstandingBalance_CheckoffProcessingDetailsB;"Checkoff Processing Details(B)"."Outstanding Balance")
                    {
                    }
                    column(OutstandingInterest_CheckoffProcessingDetailsB;"Checkoff Processing Details(B)"."Outstanding Interest")
                    {
                    }
                }
            }
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
}

