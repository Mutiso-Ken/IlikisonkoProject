#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516110 "Inventory Draft"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Inventory Draft.rdlc';

    dataset
    {
        dataitem("Item Journal Line";"Item Journal Line")
        {
            RequestFilterFields = "Location Code";
            column(ReportForNavId_1; 1)
            {
            }
            column(No;"Item Journal Line"."Item No.")
            {
            }
            column(Desc;"Item Journal Line".Description)
            {
            }
            column(QtyCalc;"Item Journal Line"."Qty. (Calculated)")
            {
            }
            column(QtyPhy;"Item Journal Line"."Qty. (Phys. Inventory)")
            {
            }
            column(Quantiy;"Item Journal Line".Quantity)
            {
            }
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

