#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516495 "Update Disbursed Amount"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Update Disbursed Amount.rdlc';

    dataset
    {
        dataitem("Loans Register";"Loans Register")
        {
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                begin
                 if "Loans Register"."Amount Disbursed"=0 then begin
                     if "Loans Register"."Approved Amount"<>0 then
                        "Loans Register"."Amount Disbursed":="Loans Register"."Approved Amount";
                        "Loans Register".Modify;
                 end;
                end;
                //END;
            end;

            trigger OnPostDataItem()
            begin
                Message('Update Complete!');
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

