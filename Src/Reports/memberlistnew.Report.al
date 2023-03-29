#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516511 "member list new"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/member list new.rdlc';

    dataset
    {
        dataitem("Member Register";"Member Register")
        {
            DataItemTableView = where(update=filter(true));
            column(ReportForNavId_1; 1)
            {
            }
            column(No_MemberRegister;"Member Register"."No.")
            {
            }
            column(Name_MemberRegister;"Member Register".Name)
            {
            }
            column(update_MemberRegister;"Member Register".update)
            {
            }
            column(CurrentShares_MemberRegister;"Member Register"."Current Shares")
            {
            }
            column(OutstandingBalance_MemberRegister;"Member Register"."Outstanding Balance")
            {
            }
            column(no;run)
            {
            }

            trigger OnAfterGetRecord()
            begin
                run:=run+1;
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
        run: Integer;
}

