#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516580 "Post Loans Interest"
{
    ProcessingOnly = true;

    dataset
    {
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

    trigger OnPreReport()
    begin
        InterestHeader.Reset;
        InterestHeader.SetRange("No.",'INTEREST');
        if InterestHeader.FindFirst then begin
            PeriodicActivities.PostLoanInterest(InterestHeader);
        end;
    end;

    var
        InterestHeader: Record "Interest Header";
        PeriodicActivities: Codeunit "Periodic Activities";
}

