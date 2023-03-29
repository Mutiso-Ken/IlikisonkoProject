#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50029 "Modify rec report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Modify rec report.rdlc';

    dataset
    {
        dataitem(Vendor;Vendor)
        {
            RequestFilterFields = "No.";
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                vend.SetRange(vend."No.",Vendor."No.");
                if vend.Find('-') then begin
                  repeat
                    if vend."Pay-to Vendor No."='0017' then begin
                    vend."Pay-to Vendor No.":=vend."No.";
                    //MESSAGE(FORMAT(vend."Pay-to Vendor No."));
                    end
                    else
                    if vend."Pay-to Vendor No."<>'0017' then begin

                    end;
                    vend.Modify;
                  until
                  vend.Next=0;
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
        vend: Record Vendor;
}

