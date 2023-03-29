#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516802 "Loans Test"
{
    PageType = List;
    SourceTable = "Loans Register";
    SourceTableView = where(Posted=const(true),
                            "Outstanding Balance"=filter(>0));

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
                field("Application Date";"Application Date")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Product Type";"Loan Product Type")
                {
                    ApplicationArea = Basic;
                }
                field("Client Code";"Client Code")
                {
                    ApplicationArea = Basic;
                }
                field("Approved Amount";"Approved Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Outstanding Balance";"Outstanding Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Oustanding Interest";"Oustanding Interest")
                {
                    ApplicationArea = Basic;
                }
                field("Schedule Repayments";"Schedule Repayments")
                {
                    ApplicationArea = Basic;
                }
                field("Schedule Repayment";"Schedule Repayment")
                {
                    ApplicationArea = Basic;
                }
                field("Schedule Interest";"Schedule Interest")
                {
                    ApplicationArea = Basic;
                }
                field("Scheduled Principal to Date";"Scheduled Principal to Date")
                {
                    ApplicationArea = Basic;
                }
                field(Interest;Interest)
                {
                    ApplicationArea = Basic;
                }
                field("Loan Status";"Loan Status")
                {
                    ApplicationArea = Basic;
                }
                field("Issued Date";"Issued Date")
                {
                    ApplicationArea = Basic;
                }
                field(Installments;Installments)
                {
                    ApplicationArea = Basic;
                }
                field("Loan Disbursement Date";"Loan Disbursement Date")
                {
                    ApplicationArea = Basic;
                }
                field("Grace Period";"Grace Period")
                {
                    ApplicationArea = Basic;
                }
                field("Posting Date";"Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field(Posted;Posted)
                {
                    ApplicationArea = Basic;
                }
                field("Amount Disbursed";"Amount Disbursed")
                {
                    ApplicationArea = Basic;
                }
                field("Interest Calculation Method";"Interest Calculation Method")
                {
                    ApplicationArea = Basic;
                }
                field("Repayment Start Date";"Repayment Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("Repayment Frequency";"Repayment Frequency")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Loan)
            {
                Caption = 'Loan';
                Image = AnalysisView;
                action("View Schedule")
                {
                    ApplicationArea = Basic;
                    Caption = 'View Schedule';
                    Image = "Table";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;
                    ShortCutKey = 'Ctrl+F7';

                    trigger OnAction()
                    begin
                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan  No.","Loan  No.");
                        if LoanApp.Find('-') then
                        Report.Run(51516477,true,false,LoanApp);
                    end;
                }
            }
        }
    }

    var
        LoanApp: Record "Loans Register";
}

