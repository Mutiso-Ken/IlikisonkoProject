#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516483 "Members Balances Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Members Balances Report.rdlc';

    dataset
    {
        dataitem("Member Register";"Member Register")
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(No_MemberRegister;"Member Register"."No.")
            {
            }
            column(Name_MemberRegister;"Member Register".Name)
            {
            }
            column(CurrentShares_MemberRegister;"Member Register"."Current Shares")
            {
            }
            dataitem("Loans Register";"Loans Register")
            {
                DataItemLink = "Client Code"=field("No.");
                column(ReportForNavId_3; 3)
                {
                }
                column(OutstandingBalance_LoansRegister;"Loans Register"."Outstanding Balance")
                {
                }
                column(LoanNo_LoansRegister;"Loans Register"."Loan  No.")
                {
                }
                column(LoanProductType_LoansRegister;"Loans Register"."Loan Product Type")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    "Loans Register".CalcFields("Outstanding Balance")
                end;
            }

            trigger OnAfterGetRecord()
            begin
                "Member Register".CalcFields("Current Shares");
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
}

