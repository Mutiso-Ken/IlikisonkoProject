#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516446 "Teller & Treasury Trans List"
{
    CardPageID = "Teller & Treasury Trans Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    SourceTable = "Treasury Transactions";
    SourceTableView = where(Posted=filter(false),
                            "Hide Card"=filter(false));

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
                field("From Account User";"From Account User")
                {
                    ApplicationArea = Basic;
                    Caption = 'From';
                }
                field("To Account";"To Account")
                {
                    ApplicationArea = Basic;
                }
                field("To Account User";"To Account User")
                {
                    ApplicationArea = Basic;
                    Caption = 'To';
                }
                field(Amount;Amount)
                {
                    ApplicationArea = Basic;
                }
                field(Posted;Posted)
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

    trigger OnInit()
    begin
        if Usersetup.Get(UserId) then
          begin
          if Usersetup."Create Vote"=false then Error ('You dont have permissions for Teller/Treasury Operations, Contact your system administrator! ')
          end;
    end;

    var
        Usersetup: Record "User Setup";
}

