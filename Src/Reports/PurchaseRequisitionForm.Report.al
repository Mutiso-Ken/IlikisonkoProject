#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516114 "Purchase Requisition Form"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Purchase Requisition Form.rdlc';

    dataset
    {
        dataitem("Purchase Header";"Purchase Header")
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(PRN_No;"Purchase Header"."No.")
            {
            }
            column(Department;"Purchase Header"."Shortcut Dimension 2 Code")
            {
            }
            column(Date;"Purchase Header"."Document Date")
            {
            }
            dataitem("Purchase Line";"Purchase Line")
            {
                DataItemLink = "Document No."=field("No.");
                column(ReportForNavId_5; 5)
                {
                }
                column(ItemNo;"Purchase Line"."No.")
                {
                }
                column(Description;"Purchase Line".Description)
                {
                }
                column(UnitofMeasure;"Purchase Line"."Unit of Measure")
                {
                }
                column(Quantity;"Purchase Line".Quantity)
                {
                }
                column(EstimatedUnitCost;"Purchase Line"."Unit Cost")
                {
                }
                column(EstimatedTotalCost;"Purchase Line"."Amt. Rcd. Not Invoiced")
                {
                }
                column(ActualCost;"Purchase Line"."Direct Unit Cost")
                {
                }
                column(TenderQuotationRef;"Purchase Line"."No.")
                {
                }
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

