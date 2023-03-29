#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516544 "Update Employee Transactions"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Update Employee Transactions.rdlc';

    dataset
    {
        dataitem("Payroll Employee Transactions.";"Payroll Employee Transactions.")
        {
            column(ReportForNavId_1000000000; 1000000000)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Transction.Reset;
                if Transction.Get("Payroll Employee Transactions."."Transaction Code") then
                  "Payroll Employee Transactions."."Transaction Type":=Transction."Transaction Type";
                  "Payroll Employee Transactions.".Modify;
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
        Transction: Record "Payroll Transaction Code.";
}

