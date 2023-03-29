#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50016 "Update Member Colleges"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Update Member Colleges.rdlc';

    dataset
    {
        dataitem("Member Colleges";"Member Colleges")
        {
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                ObjMembers.Reset;
                ObjMembers.SetRange("No.","Member Colleges".mno);
                if ObjMembers.Find('-') then
                  begin
                    ObjMembers.colleges:="Member Colleges".code;
                    ObjMembers.Modify;
                  end
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
        ObjMembers: Record "Member Register";
}

