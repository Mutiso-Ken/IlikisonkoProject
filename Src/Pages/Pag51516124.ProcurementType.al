#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516124 "Procurement Type"
{
    PageType = List;
    SourceTable = "Treasury Transactions";

    layout
    {
        area(content)
        {
            repeater(Control1102756000)
            {
                field(No;No)
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Date";"Transaction Date")
                {
                    ApplicationArea = Basic;
                }
                field("Transaction Type";"Transaction Type")
                {
                    ApplicationArea = Basic;
                }
                field("From Account";"From Account")
                {
                    ApplicationArea = Basic;
                }
                field("To Account";"To Account")
                {
                    ApplicationArea = Basic;
                }
                field(Description;Description)
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

