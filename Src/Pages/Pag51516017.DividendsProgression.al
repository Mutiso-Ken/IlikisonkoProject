#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516017 "Dividends Progression"
{
    PageType = List;
    SourceTable = "Dividends Progression";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Member No";"Member No")
                {
                    ApplicationArea = Basic;
                }
                field(Date;Date)
                {
                    ApplicationArea = Basic;
                }
                field("Gross Dividends";"Gross Dividends")
                {
                    ApplicationArea = Basic;
                }
                field("Witholding Tax";"Witholding Tax")
                {
                    ApplicationArea = Basic;
                }
                field("Net Dividends";"Net Dividends")
                {
                    ApplicationArea = Basic;
                }
                field("Member Deposits";"Member Deposits")
                {
                    ApplicationArea = Basic;
                }
                field("Qualifying Deposits";"Qualifying Deposits")
                {
                    ApplicationArea = Basic;
                }
                field("Interest on Deposits";"Interest on Deposits")
                {
                    ApplicationArea = Basic;
                }
                field("Share Capital";"Share Capital")
                {
                    ApplicationArea = Basic;
                }
                field("Qualifying Share Capital";"Qualifying Share Capital")
                {
                    ApplicationArea = Basic;
                }
                field("Dividend on Share Capital";"Dividend on Share Capital")
                {
                    ApplicationArea = Basic;
                }
                field("Fosa Shares";"Fosa Shares")
                {
                    ApplicationArea = Basic;
                }
                field("Qualifying FOSA Shares";"Qualifying FOSA Shares")
                {
                    ApplicationArea = Basic;
                }
                field("Interest on FOSA Shares";"Interest on FOSA Shares")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

