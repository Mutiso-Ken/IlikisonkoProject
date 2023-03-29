#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516766 "Houses List"
{
    CardPageID = "House Card";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = House;
    SourceTableView = sorting("Entry No")
                      order(ascending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Property Code";"Property Code")
                {
                    ApplicationArea = Basic;
                }
                field("Property Name";"Property Name")
                {
                    ApplicationArea = Basic;
                }
                field("House Code";"House Code")
                {
                    ApplicationArea = Basic;
                }
                field("House Type";"House Type")
                {
                    ApplicationArea = Basic;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                }
                field("Tenant No";"Tenant No")
                {
                    ApplicationArea = Basic;
                }
                field("Tenant Name";"Tenant Name")
                {
                    ApplicationArea = Basic;
                }
                field("House Rent";"House Rent")
                {
                    ApplicationArea = Basic;
                }
                field("Reservation Date";"Reservation Date")
                {
                    ApplicationArea = Basic;
                }
                field("Date allocated";"Date allocated")
                {
                    ApplicationArea = Basic;
                }
                field("Date Vacated";"Date Vacated")
                {
                    ApplicationArea = Basic;
                }
                field("Account No";"Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Due Date";"Due Date")
                {
                    ApplicationArea = Basic;
                }
                field("Phone No";"Phone No")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    var
        Tenant: Record Vendor;
}

