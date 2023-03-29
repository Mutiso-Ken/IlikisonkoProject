#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516510 "update member register"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/update member register.rdlc';

    dataset
    {
        dataitem("member update";"member update")
        {
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                memberreg.Reset;
                memberreg.SetRange(memberreg."No.","member update"."Member No");
                if memberreg.Find ('-') then begin

                 memberreg.update:=true;

                  memberreg.Modify;
                  end;
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
        memberreg: Record "Member Register";
}

