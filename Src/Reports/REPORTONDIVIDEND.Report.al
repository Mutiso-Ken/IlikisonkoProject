#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516550 "REPORT ON DIVIDEND"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/REPORT ON DIVIDEND.rdlc';

    dataset
    {
        dataitem("Dividends Progression";"Dividends Progression")
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(MemberNo_DividendsProgression;"Dividends Progression"."Member No")
            {
            }
            column(GrossDividends_DividendsProgression;"Dividends Progression"."Gross Dividends")
            {
            }
            column(Shares_DividendsProgression;"Dividends Progression"."Qualifying Deposits")
            {
            }
            column(ShareCapital_DividendsProgression;"Dividends Progression"."Share Capital")
            {
            }
            column(FosaShares_DividendsProgression;"Dividends Progression"."Fosa Shares")
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

