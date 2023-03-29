#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516945 "Update Posting Date"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Update Posting Date.rdlc';

    dataset
    {
        dataitem("Gen. Journal Line";"Gen. Journal Line")
        {
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //"Gen. Journal Line"."Posting Date":=20192302D;
                "Gen. Journal Line"."Bal. Account No.":='90547';
                "Gen. Journal Line".Modify;
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

