#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516706 "Group Savings"
{
    CardPageID = "Group Savings Account Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Vendor;
    SourceTableView = where("Vendor Posting Group"=filter('GROUP'));

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
                field("Account Type";"Account Type")
                {
                    ApplicationArea = Basic;
                }
                field(Balance;Balance)
                {
                    ApplicationArea = Basic;
                    StyleExpr = CoveragePercentStyle;
                }
                field("Personal No.";"Personal No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Payroll No.';
                }
                field("ATM No.""";"ATM No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'ATM No.';
                }
                field("BOSA Account No";"BOSA Account No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member No.';
                }
                field("ID No.";"ID No.")
                {
                    ApplicationArea = Basic;
                }
                field("Employer Code";"Employer Code")
                {
                    ApplicationArea = Basic;
                }
                field("Mobile Phone No";"Mobile Phone No")
                {
                    ApplicationArea = Basic;
                }
                field("Pension No";"Pension No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Pension No';
                }
                field("Global Dimension 1 Code";"Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
            }
        }
        area(factboxes)
        {
            part(Control1000000001;"FOSA Statistics FactBox")
            {
                Caption = 'GROUP Statistics Factbox';
                Editable = false;
                Enabled = false;
                SubPageLink = "No."=field("No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Account)
            {
                Caption = 'Account';
                action("Ledger E&ntries")
                {
                    ApplicationArea = Basic;
                    Caption = 'Ledger E&ntries';
                    Image = VendorLedger;
                    RunObject = Page "Vendor Ledger Entries";
                    RunPageLink = "Vendor No."=field("No.");
                    RunPageView = sorting("Vendor No.");
                    ShortCutKey = 'Ctrl+F7';
                }
                separator(Action1102755228)
                {
                }
                separator(Action1102755226)
                {
                }
                separator(Action1102755225)
                {
                }
                separator(Action1102755222)
                {
                }
            }
            group(ActionGroup1102755220)
            {
                separator(Action1102755217)
                {
                }
                action("Page Vendor Statement")
                {
                    ApplicationArea = Basic;
                    Caption = 'Statement';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin

                        Vend.Reset;
                        Vend.SetRange(Vend."No.","No.");
                        if Vend.Find('-') then
                        Report.Run(51516890,true,false,Vend)
                    end;
                }
                action("Page Vendor Statistics")
                {
                    ApplicationArea = Basic;
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Page "Vendor Statistics";
                    RunPageLink = "No."=field("No."),
                                  "Global Dimension 1 Filter"=field("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter"=field("Global Dimension 2 Filter");
                    ShortCutKey = 'F7';
                }
                action("Loan Statement")
                {
                    ApplicationArea = Basic;
                    Caption = 'Group Loan Statement';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.","No.");
                        if Cust.Find('-') then
                        Report.Run(51516973,true,false,Cust);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetStyles;
    end;

    trigger OnOpenPage()
    begin
        //SETRANGE("Global Dimension 1 Code",'MICRO');
    end;

    var
        Cust: Record "Member Register";
        Vend: Record Vendor;
        CoveragePercentStyle: Text;
        MinimumBalance: Decimal;

    local procedure SetStyles()
    begin
        MinimumBalance:=1000;
        if Balance =0 then
          CoveragePercentStyle := 'Strong'
        else
          if Balance < MinimumBalance then
            CoveragePercentStyle := 'Unfavorable'
          else
            CoveragePercentStyle := 'Favorable';
    end;
}

