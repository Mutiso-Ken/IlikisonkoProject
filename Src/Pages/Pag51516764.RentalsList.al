#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516764 "Rentals List"
{
    CardPageID = "Rental Card";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = Property;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No;No)
                {
                    ApplicationArea = Basic;
                }
                field(Description;Description)
                {
                    ApplicationArea = Basic;
                }
                field(Location;Location)
                {
                    ApplicationArea = Basic;
                }
                field("Member Name";"Member Name")
                {
                    ApplicationArea = Basic;
                }
                field("Owner No";"Owner No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member No';
                }
                field("Total Houses";"Total Houses")
                {
                    ApplicationArea = Basic;
                }
                field("Monthly Rent";"Monthly Rent")
                {
                    ApplicationArea = Basic;
                }
                field("Total Vacant";"Total Vacant")
                {
                    ApplicationArea = Basic;
                }
                field("Total Occupied";"Total Occupied")
                {
                    ApplicationArea = Basic;
                }
                field("Total Reserved";"Total Reserved")
                {
                    ApplicationArea = Basic;
                }
                field("Type of Structure";"Type of Structure")
                {
                    ApplicationArea = Basic;
                }
                field(Vacant;Vacant)
                {
                    ApplicationArea = Basic;
                }
                field("Fully Occupied";"Fully Occupied")
                {
                    ApplicationArea = Basic;
                }
                field("Partially Occupied";"Partially Occupied")
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

