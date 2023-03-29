#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516767 "House Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = House;

    layout
    {
        area(content)
        {
            group(General)
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
                field("Tenant Name";"Tenant Name")
                {
                    ApplicationArea = Basic;
                }
                field("House Rent";"House Rent")
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

                    trigger OnValidate()
                    begin
                        "Due Date":= CalcDate('1M'+'10D',(Today));
                    end;
                }
                field(No;No)
                {
                    ApplicationArea = Basic;
                }
                field("ID No";"ID No")
                {
                    ApplicationArea = Basic;
                }
                field("House Status";"House Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
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
        area(creation)
        {
            group("Request Approval")
            {
                Caption = 'Request Approval';
                Image = SendApprovalRequest;
                action("Occupancy History")
                {
                    ApplicationArea = Basic;
                    Image = History;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "House History";
                    RunPageLink = "Property Code"=field("Property Code"),
                                  "House Code"=field("House Code");
                }
                action(Tenant)
                {
                    ApplicationArea = Basic;
                    Image = User;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "Tenant List";
                    RunPageLink = "No."=field("Tenant No");
                }
            }
        }
    }
}

