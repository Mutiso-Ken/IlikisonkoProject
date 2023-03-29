#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516967 "Next of Kin Change Card2"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Next Of Kin Change";
    SourceTableView = where(Status=filter(Approved));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Document No";"Document No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member No";"Member No")
                {
                    ApplicationArea = Basic;
                    Editable = MemberNoEditable;
                }
                field("Member Name";"Member Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account Type";"Account Type")
                {
                    ApplicationArea = Basic;
                    Editable = AccountTypeEditable;
                    Visible = false;
                }
                field("Account No";"Account No")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Change Type";"Change Type")
                {
                    ApplicationArea = Basic;
                    Editable = ChangeTypeEditable;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        FnGetListShow();
                    end;
                }
                field("Captured By";"Captured By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Captured On";"Captured On")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Change Effected";"Change Effected")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            part("BOSA Next of Kin";"Members Nominee Details List")
            {
                SubPageLink = "Account No"=field("Member No");
            }
            part("FOSA Next Of Kin";"FOSA Account  NOK Details")
            {
                SubPageLink = "Account No"=field("Account No");
                Visible = VarFOSANOKVisible;
            }
            part("Account Agent";"Agent Account Signatory list")
            {
                SubPageLink = "Account No"=field("Account No");
                Visible = VarAccountAgentVisible;
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Effect Change")
            {
                ApplicationArea = Basic;
                Enabled = EnableCreateMember;
                Image = Customer;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = false;

                trigger OnAction()
                begin
                    /*IF CONFIRM('Are you sure you want to effect this change?',FALSE)=TRUE THEN BEGIN
                      IF ObjCust.GET("Member No") THEN BEGIN
                        ObjCust."Member Cell Group":="Destination Cell";
                        ObjCust."Member Cell Group Name":="Destination Cell Group";
                        ObjCust."House Group Status":=ObjCust."House Group Status"::Active;
                        "Date Group Changed":=TODAY;
                        "Changed By":=USERID;
                        "Change Effected":=TRUE;
                        ObjCust.MODIFY;
                        END;
                    END;*/

                end;
            }
            action("Send Approval Request")
            {
                ApplicationArea = Basic;
                Caption = 'Send Approval Request';
                Enabled = (not OpenApprovalEntriesExist) and EnabledApprovalWorkflowsExist;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;
                Visible = false;

                trigger OnAction()
                var
                    Text001: label 'This request is already pending approval';
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin

                    if ApprovalsMgmt.CheckMemberAgentNOKChangeApprovalsWorkflowEnabled(Rec) then
                            ApprovalsMgmt.OnSendMemberAgentNOKChangeForApproval(Rec);
                end;
            }
            action("Cancel Approval Request")
            {
                ApplicationArea = Basic;
                Caption = 'Cancel Approval Request';
                Enabled = CanCancelApprovalForRecord;
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;
                Visible = false;

                trigger OnAction()
                var
                    Approvalmgt: Codeunit "Approvals Mgmt.";
                begin
                    if Confirm('Are you sure you want to cancel this approval request',false)=true then
                     ApprovalsMgmt.OnCancelMemberAgentNOKChangeApprovalRequest(Rec);
                      Status:=Status::Open;
                      Modify;
                end;
            }
            action(Approval)
            {
                ApplicationArea = Basic;
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;
                Visible = false;

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                begin
                    DocumentType:=Documenttype::MemberAgentNOKChange;
                    ApprovalEntries.Setfilters(Database::"Next Of Kin Change",DocumentType,"Document No");
                    ApprovalEntries.Run;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        FnGetListShow();

        EnableCreateMember:=false;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);
        EnabledApprovalWorkflowsExist :=true;

        if ((Rec.Status=Status::Approved) ) then
            EnableCreateMember:=true;
    end;

    trigger OnAfterGetRecord()
    begin
        if Status=Status::Open then
          begin
          MemberNoEditable:=true;
          AccountTypeEditable:=true;
          AccountNoEditable:=true;
          ChangeTypeEditable:=true
          end else
            if Status=Status::"Pending Approval" then
              begin
              MemberNoEditable:=false;
              AccountTypeEditable:=false;
              AccountNoEditable:=false;
              ChangeTypeEditable:=false
              end else
              if Status=Status::Approved then
                begin
                  MemberNoEditable:=false;
                  AccountTypeEditable:=false;
                  AccountNoEditable:=false;
                  ChangeTypeEditable:=false;
                  end;

        EnableCreateMember:=false;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);
        EnabledApprovalWorkflowsExist :=true;

        if ((Rec.Status=Status::Approved) ) then
            EnableCreateMember:=true;
    end;

    trigger OnOpenPage()
    begin
        FnGetListShow();

        if Status=Status::Open then
          begin
          MemberNoEditable:=true;
          AccountTypeEditable:=true;
          AccountNoEditable:=true;
          ChangeTypeEditable:=true
          end else
            if Status=Status::"Pending Approval" then
              begin
              MemberNoEditable:=false;
              AccountTypeEditable:=false;
              AccountNoEditable:=false;
              ChangeTypeEditable:=false
              end else
              if Status=Status::Approved then
                begin
                  MemberNoEditable:=false;
                  AccountTypeEditable:=false;
                  AccountNoEditable:=false;
                  ChangeTypeEditable:=false;
                  end;
    end;

    var
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication,BulkWithdrawal,PackageLodging,PackageRetrieval,HouseChange,CRMTraining,PettyCash,StaffClaims,MemberAgentNOKChange;
        EnableCreateMember: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        EnabledApprovalWorkflowsExist: Boolean;
        ObjCust: Record "Member Register";
        MemberNoEditable: Boolean;
        AccountNoEditable: Boolean;
        ChangeTypeEditable: Boolean;
        AccountTypeEditable: Boolean;
        VarBOSANOKVisible: Boolean;
        VarFOSANOKVisible: Boolean;
        VarAccountAgentVisible: Boolean;
        MembersNominee: Record "Members Nominee";
        MembersNomineeTemp: Record "Members Nominee Temp";

    local procedure FnGetListShow()
    begin
        VarAccountAgentVisible:=false;
        VarFOSANOKVisible:=false;
        VarBOSANOKVisible:=false;


        if ("Change Type"="change type"::"Account Next Of Kin Change") and ("Account Type"="account type"::BOSA) then
          begin
            VarAccountAgentVisible:=false;
            VarFOSANOKVisible:=false;
            VarBOSANOKVisible:=true;
            end else
            if ("Change Type"="change type"::"Account Next Of Kin Change") and ("Account Type"="account type"::FOSA) then
              begin
                VarAccountAgentVisible:=false;
                VarFOSANOKVisible:=true;
                VarBOSANOKVisible:=false;
                if ("Change Type"="change type"::"Account Agent Change") and ("Account Type"="account type"::FOSA) then
                  begin
                    VarAccountAgentVisible:=true;
                    VarFOSANOKVisible:=false;
                    VarBOSANOKVisible:=false;
                    end;

        end;
    end;
}

