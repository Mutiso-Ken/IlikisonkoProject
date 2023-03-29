#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516159 "Interest Header Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Interest Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = PageEditable;
                field("No.";"No.")
                {
                    ApplicationArea = Basic;
                }
                field("Posting Date";"Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field("Interest Due Date";"Interest Due Date")
                {
                    ApplicationArea = Basic;
                }
                field("End Date";"End Date")
                {
                    ApplicationArea = Basic;
                }
                field("Document No.";"Document No.")
                {
                    ApplicationArea = Basic;
                }
                field("Distributed Amount";"Distributed Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Loan Count";"Loan Count")
                {
                    ApplicationArea = Basic;
                }
                field("Posted Loans";"Posted Loans")
                {
                    ApplicationArea = Basic;
                }
                field(Posted;Posted)
                {
                    ApplicationArea = Basic;
                }
                field(Cashier;Cashier)
                {
                    ApplicationArea = Basic;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                }
                field(Description;Description)
                {
                    ApplicationArea = Basic;
                }
                field("Responsibility Center";"Responsibility Center")
                {
                    ApplicationArea = Basic;
                }
                field("Bill Loan";"Bill Loan")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Charge Interest";"Charge Interest")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Interest Total";"Interest Total")
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control1000000008;"Loan Interest List")
            {
                Editable = PageEditable;
                SubPageLink = No=field("No.");
            }
        }
    }

    actions
    {
        area(creation)
        {
            group(ActionGroup1000000010)
            {
                action("Generate Entries")
                {
                    ApplicationArea = Basic;
                    Caption = 'Generate Entries';
                    Image = GetEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        SelectOpttionsErr: label 'Select Options';
                    begin
                        /*
                        IF Status<>Status::Open THEN
                          ERROR('You canot generate entries since the document is already %1',Status);
                        
                        IF NOT Posted THEN BEGIN
                            //Delete existing entries
                            LoansInterest.RESET;
                            LoansInterest.SETRANGE(LoansInterest.No,"No.");
                            IF LoansInterest.FIND('-') THEN
                              LoansInterest.DELETEALL;
                        
                            //PeriodicActivities.GenerateMonthlyInterestandBills(Rec);
                            PeriodicActivities.GenerateLoanMonthlyInterest(LoansInterest);
                        
                        END
                        ELSE
                            ERROR('These Entries have already been posted.');
                        */

                    end;
                }
                action("Post Entries")
                {
                    ApplicationArea = Basic;
                    Image = PostDocument;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        /*
                        IF Status<>Status::Approved THEN
                           MESSAGE(ErrNotApproved);
                        
                        CALCFIELDS("Distributed Amount");
                        IF "Distributed Amount"=0 THEN
                          ERROR(ErrNoEntries);
                        
                        IF NOT CONFIRM ('Do you want to post these entries?') THEN
                          EXIT
                        ELSE
                        PeriodicActivities.PostEntries(Rec);
                        */

                    end;
                }
                action("Generate Entries Selectively")
                {
                    ApplicationArea = Basic;
                    Image = PostDocument;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report UnknownReport39004414;
                    Visible = false;
                }
                separator(Action1000000020)
                {
                }
            }
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(RecordId);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = Basic;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(RecordId);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(RecordId);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = Basic;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "Approval Comments";
                    Visible = OpenApprovalEntriesExistForCurrUser;
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Enabled = not OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        /*TESTFIELD("Posting Date");
                        TESTFIELD("Document No.");
                        TESTFIELD(Description);
                        TESTFIELD("Interest Due Date");
                        VarVariant := Rec;
                        IF CustomApprovals.CheckApprovalsWorkflowEnabled(VarVariant) THEN
                          CustomApprovals.OnSendDocForApproval(VarVariant);
                        */

                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        /*VarVariant := Rec;
                        CustomApprovals.OnCancelDocApprovalRequest(VarVariant);
                        */

                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        approvalsMgmt: Codeunit "Approvals Mgmt.";
                    begin

                        approvalsMgmt.OpenApprovalEntriesPage(RecordId);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        UpdateControls;
        SetControlAppearance;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UpdateControls;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        if Status<>Status::Open then Error('You cannot modify this record');
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UpdateControls;
    end;

    trigger OnOpenPage()
    begin
        UpdateControls;
    end;

    var
        RecBuffer: Record "Loans Interest";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Closure","Account Opening",Batch,"Payment Voucher","Petty Cash",Requisition,Loan,Interbank,Imprest,Checkoff,"FOSA Account Opening",StandingOrder,HRJob,HRLeave,HRTraining,"HREmp Requsition",MicroTrans,"Account Reactivation",Overdraft,BLA,"Benevolent Fund","Staff Claim",TransportRequisition,FuelRequisition,DailyWorkTicket,StaffLoan,HRBatch,Overtime,FTransfer,"Edit Member","Loan Officer",HREmp,FuelCard,Appraisal,HRNeed,HRExit,TreasuryTransactions,BSC,"Risk Claim",Delegate,Maint,TellerTransactions,ATMM,GeneralRepair,Saccotransffers,ImprestSurrender,"BL Opening","Risk Closure","Defaulter Recovery","Guarantors Subsitute",MPESAApp,MPESAChange;
        PeriodicActivities: Codeunit "Periodic Activities";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        VarVariant: Variant;
        ErrNotApproved: label 'This document has not been approved';
        ErrNoEntries: label 'This Document has no Lines to post';
        BankingUserTemplate: Record "Funds User Setup";
        GenJournalLine: Record "Gen. Journal Line";
        LineNo: Integer;
        JTemp: Code[20];
        JBatch: Code[20];
        LoansInterest: Record "Loans Interest";
        RecBuffLines: Record "Loans Interest";
        PageEditable: Boolean;


    procedure UpdateControls()
    begin
        if (Posted=true) or (Status<>Status::Open) then
          begin
          PageEditable:=false;
          end else
          PageEditable:=true;
    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
    end;
}

