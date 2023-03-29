#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516582 "Update Upproval Status"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Update Upproval Status.rdlc';

    dataset
    {
        dataitem("Loans Register";"Loans Register")
        {
            RequestFilterFields = "Loan  No.";
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Loans.Reset;
                Loans.SetRange("Loan  No.","Loans Register"."Loan  No.");
                Loans.SetRange(Posted,true);
                //Loans.SETRANGE("Loan Status","Loan Status"::);
                if Loans.Find('-') then begin
                   if Loans."Loan Status"=Loans."loan status"::Issued then
                   repeat
                   if Loans."Approval Status"<> Loans."approval status"::Approved then
                      Loans."Approval Status":=Loans."approval status"::Approved
                      until Loans.Next=0;
                      Loans.Modify;
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
        Loans: Record "Loans Register";
}

