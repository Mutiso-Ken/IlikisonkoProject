#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516942 "Update FOSA Account Types"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Update FOSA Account Types.rdlc';

    dataset
    {
        dataitem(Vendor;Vendor)
        {
            DataItemTableView = where("Vendor Posting Group"=filter(<>'CREDITOR'));
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Vendor."Creditor Type":=Vendor."creditor type"::"Savings Account";
                Vendor.Modify;
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

