#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516477 "Teller Till List"
{
    CardPageID = "Teller Till Card";
    Editable = false;
    PageType = List;
    SourceTable = "Bank Account";
    SourceTableView = where("Account Type"=filter(Cashier));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No.";"No.")
                {
                    ApplicationArea = Basic;
                }
                field(Name;Name)
                {
                    ApplicationArea = Basic;
                }
                field(CashierID;CashierID)
                {
                    ApplicationArea = Basic;
                }
                field("Balance (LCY)";"Balance (LCY)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Running Balance';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Cashier Activity Report")
            {
                ApplicationArea = Basic;
                Caption = 'Activity Report(detailed)';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    TillNo.Reset;
                    TillNo.SetRange(TillNo."No.","No.");
                    if TillNo.Find('-') then
                    Report.Run(51516029,true,false,TillNo)
                end;
            }
            action("Cashier Activity Report 2")
            {
                ApplicationArea = Basic;
                Caption = 'Activity Report';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    TillNo.Reset;
                    TillNo.SetRange(TillNo."No.","No.");
                    if TillNo.Find('-') then
                    Report.Run(51516029,true,false,TillNo)
                end;
            }
        }
    }

    trigger OnInit()
    begin
        if Usersetup.Get(UserId) then
          begin
          if Usersetup."Create Vote"=false then Error ('You dont have permissions for Teller/Treasury Operations, Contact your system administrator! ')
          end;
    end;

    var
        TillNo: Record "Bank Account";
        Usersetup: Record "User Setup";
}

