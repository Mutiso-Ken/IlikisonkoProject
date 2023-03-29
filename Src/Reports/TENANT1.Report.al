#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50052 TENANT1
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/TENANT1.rdlc';

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
                Vendor.Reset;
                Vendor.SetRange(Vendor."No.","No.");
                if Vendor.Find('-') then begin
                  Message('%1',"No.");
                  Vendor."No. Series":='TENANT';
                  Vendor.Modify;
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
        MNO: Text;
}

