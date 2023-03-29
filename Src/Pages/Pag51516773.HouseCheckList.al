#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516773 "House CheckList"
{
    PageType = ListPart;
    SourceTable = "House CheckList";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Item;Item)
                {
                    ApplicationArea = Basic;
                }
                field("Property Code";"Property Code")
                {
                    ApplicationArea = Basic;
                }
                field("House Code";"House Code")
                {
                    ApplicationArea = Basic;
                }
                field("Item Name";"Item Name")
                {
                    ApplicationArea = Basic;
                }
                field(Condition;Condition)
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

