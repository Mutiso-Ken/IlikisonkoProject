#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50017 "Update User Setup"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Update User Setup.rdlc';

    dataset
    {
        dataitem("User Setup";"User Setup")
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(UserID_UserSetup;"User Setup"."User ID")
            {
            }
            column(AllowPostingFrom_UserSetup;"User Setup"."Allow Posting From")
            {
            }
            column(AllowPostingTo_UserSetup;"User Setup"."Allow Posting To")
            {
            }

            trigger OnAfterGetRecord()
            begin
                if "User Setup"."Update Automatically" then
                begin
                "User Setup"."Allow Posting From":=20180930D;
                "User Setup"."Allow Posting To":=WorkDate;
                "User Setup".Modify;
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
}

