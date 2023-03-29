#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516804 "Loans Test2"
{
    PageType = List;
    SourceTable = "Loans Register";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan  No.";"Loan  No.")
                {
                    ApplicationArea = Basic;
                }
                field(Posted;Posted)
                {
                    ApplicationArea = Basic;
                }
                field("Loan Status";"Loan Status")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Balance";"Outstanding Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Loans Category";"Loans Category")
                {
                    ApplicationArea = Basic;
                }
                field("Updated-SASRA";"Updated-SASRA")
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

