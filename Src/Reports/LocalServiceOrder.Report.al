#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516119 "Local Service Order"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Local Service Order.rdlc';

    dataset
    {
        dataitem("Service Header";"Service Header")
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(LSO_NO;"Service Header"."No.")
            {
            }
            column(ContractNo;"Service Header"."Contract No.")
            {
            }
            column(ResponseDate;"Service Header"."Response Date")
            {
            }
            column(Date;"Service Header"."Document Date")
            {
            }
            column("To";"Service Header"."Bill-to Name")
            {
            }
            dataitem("Service Item Line";"Service Item Line")
            {
                DataItemLink = "Document No."=field("No.");
                column(ReportForNavId_6; 6)
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

