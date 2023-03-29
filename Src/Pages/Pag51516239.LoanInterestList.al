#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516239 "Loan Interest List"
{
    PageType = List;
    SourceTable = "Loans Interest";
    SourceTableView = where(Posted=const(false),
                            Transferred=const(false));

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
                field("Account No";"Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Account Type";"Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Interest Date";"Interest Date")
                {
                    ApplicationArea = Basic;
                }
                field("Interest Amount";"Interest Amount")
                {
                    ApplicationArea = Basic;
                }
                field("User ID";"User ID")
                {
                    ApplicationArea = Basic;
                }
                field(Transferred;Transferred)
                {
                    ApplicationArea = Basic;
                }
                field(Posted;Posted)
                {
                    ApplicationArea = Basic;
                }
                field("Loan No.";"Loan No.")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Product type";"Loan Product type")
                {
                    ApplicationArea = Basic;
                }
                field("Bal. Account Type";"Bal. Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Bal. Account No.";"Bal. Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                }
                field("Issued Date";"Issued Date")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Interest";"Outstanding Interest")
                {
                    ApplicationArea = Basic;
                }
                field(Reversed;Reversed)
                {
                    ApplicationArea = Basic;
                }
                field("Interest Rate";"Interest Rate")
                {
                    ApplicationArea = Basic;
                }
                field("Bosa No";"Bosa No")
                {
                    ApplicationArea = Basic;
                }
                field("stop interest";"stop interest")
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
            action("Generate Monthly Interest")
            {
                ApplicationArea = Basic;
                Image = GetEntries;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report "Generate Monthly Interest";

                trigger OnAction()
                begin
                    if Usersetup.Get(UserId) then
                    begin
                    if Usersetup."Post Interest"=false then Error ('You do not have permissions for Post interest, Contact your system administrator! ')
                    end;
                end;
            }
            action("Option ")
            {
                ApplicationArea = Basic;
            }
            action("Post Loan Interest")
            {
                ApplicationArea = Basic;
                Image = Post;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = Report "Post Loans Interest";
            }
        }
    }

    trigger OnInit()
    begin
        if Usersetup.Get(UserId) then
        begin
        if Usersetup."Post Interest"=false then Error ('You do not have permissions for Post interest, Contact your system administrator! ')
        end;
    end;

    var
        Option: Option "Generate Only","Generate & Post";
        Usersetup: Record "User Setup";
}

