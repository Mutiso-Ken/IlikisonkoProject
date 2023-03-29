#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516536 "Deductible loans"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Deductible loans.rdlc';

    dataset
    {
        dataitem("Loans Register";"Loans Register")
        {
            column(ReportForNavId_1000000000; 1000000000)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Setup.Reset;
                Setup.SetRange(Setup.Code,"Loan Product Type");
                if Setup.Find('-') then begin
                  Deductible:=Setup.Deductible;
                  Modify;

                end;
                  //MESSAGE('Success');
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
        Setup: Record "Loan Products Setup";
}

