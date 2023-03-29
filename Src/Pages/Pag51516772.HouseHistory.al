#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516772 "House History"
{
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "House Occupation History";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("House Code";"House Code")
                {
                    ApplicationArea = Basic;
                }
                field("Property Code";"Property Code")
                {
                    ApplicationArea = Basic;
                }
                field("Property Name";"Property Name")
                {
                    ApplicationArea = Basic;
                }
                field("House Name";"House Name")
                {
                    ApplicationArea = Basic;
                }
                field("Tentant No";"Tentant No")
                {
                    ApplicationArea = Basic;
                }
                field("Tenant Name";"Tenant Name")
                {
                    ApplicationArea = Basic;
                }
                field("Tenant ID No";"Tenant ID No")
                {
                    ApplicationArea = Basic;
                }
                field("Tenant Phone No";"Tenant Phone No")
                {
                    ApplicationArea = Basic;
                }
                field("Date Allocated";"Date Allocated")
                {
                    ApplicationArea = Basic;
                }
                field("Date Vacated";"Date Vacated")
                {
                    ApplicationArea = Basic;
                }
                field("Entry Type";"Entry Type")
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

