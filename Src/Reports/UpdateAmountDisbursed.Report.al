#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516583 "Update Amount Disbursed"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Update Amount Disbursed.rdlc';

    dataset
    {
        dataitem("Loans Register";"Loans Register")
        {
            DataItemTableView = where(Posted=const(true));
            RequestFilterFields = "Loan  No.";
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //IF "Loans Register"."Amount Disbursed"=0 THEN
                 // "Loans Register"."Amount Disbursed":="Loans Register"."Approved Amount";
                  /*IF "Loans Register"."Approved Amount"=0 THEN
                  "Loans Register"."Approved Amount":="Loans Register"."Requested Amount";*/
                //"Loans Register".MODIFY;

            end;

            trigger OnPostDataItem()
            begin
                Message('Update Complete');
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

