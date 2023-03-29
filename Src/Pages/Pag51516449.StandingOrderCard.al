#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516449 "Standing Order Card"
{
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Standing Orders";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No.";"No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Source Account No.";"Source Account No.")
                {
                    ApplicationArea = Basic;
                    AssistEdit = false;
                    Editable = true;
                }
                field("Account Name";"Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Amount;Amount)
                {
                    ApplicationArea = Basic;
                    Editable = AmountEditable;
                }
                field("Destination Account Type";"Destination Account Type")
                {
                    ApplicationArea = Basic;
                    OptionCaption = 'Internal,BOSA,Loans';

                    trigger OnValidate()
                    begin
                        if "Destination Account Type"="destination account type"::Loans then
                          begin
                           DestinationAccountsVisible:=true;
                             end;
                    end;
                }
                field("Destination Account No.";"Destination Account No.")
                {
                    ApplicationArea = Basic;
                }
                group(DestinationDetails)
                {
                    Caption = 'DestinationDetails';
                    Visible = DestinationAccountsVisible;
                    field("Destination Loan No";"Destination Loan No")
                    {
                        ApplicationArea = Basic;
                    }
                }
                field("Destination Account Name";"Destination Account Name")
                {
                    ApplicationArea = Basic;
                }
                group(BankDetails)
                {
                    Caption = 'BankDetails';
                    Visible = BankDetailsVisible;
                }
                field("Allocated Amount";"Allocated Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Effective/Start Date";"Effective/Start Date")
                {
                    ApplicationArea = Basic;
                    Editable = EffectiveDateEditable;
                }
                field(Duration;Duration)
                {
                    ApplicationArea = Basic;
                    Editable = DurationEditable;
                }
                field("End Date";"End Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field(Frequency;Frequency)
                {
                    ApplicationArea = Basic;
                    Editable = FrequencyEditable;
                }
                field("Don't Allow Partial Deduction";"Don't Allow Partial Deduction")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Standing Order Description";"Standing Order Description")
                {
                    ApplicationArea = Basic;
                    Caption = 'Standing Order Description';
                }
                field(Unsuccessfull;Unsuccessfull)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("Next Run Date";"Next Run Date")
                {
                    ApplicationArea = Basic;
                }
                field("No of Tolerance Days";"No of Tolerance Days")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("End of Tolerance Date";"End of Tolerance Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Last Next Run Date attempt';
                    Editable = false;
                    ToolTip = 'This is the last date the system will attempt to run the standing order after the tolerance period';
                }
                field(Balance;Balance)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field(Effected;Effected)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("Auto Process";"Auto Process")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("Standing Order Type";"Standing Order Type")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("None Salary";"None Salary")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Date Reset";"Date Reset")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Importance = Additional;
                }
                field("Posted By";"Posted By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
            }
            part("Receipt Allocation";"Receipt Allocation-BOSA")
            {
                SubPageLink = "Document No"=field("No.");
                Visible = ReceiptAllVisible;
            }
        }
        area(factboxes)
        {
            part(Control25;"FOSA Statistics FactBox")
            {
                SubPageLink = "No."=field("Source Account No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Reset)
            {
                ApplicationArea = Basic;
                Caption = 'Reset';
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to reset the standing order?') = true then begin

                    Effected:=false;
                    Balance:=0;
                    Unsuccessfull:=false;
                    "Auto Process":=false;
                    "Date Reset":=Today;
                    Modify;

                    RAllocations.Reset;
                    RAllocations.SetRange(RAllocations."Document No","No.");
                    if RAllocations.Find('-') then begin
                    repeat
                    RAllocations."Amount Balance":=0;
                    RAllocations."Interest Balance":=0;
                    RAllocations.Modify;
                    until RAllocations.Next = 0;
                    end;

                    end;
                end;
            }
            action(Approve)
            {
                ApplicationArea = Basic;
                Caption = 'Approve';
                Enabled = true;
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    TestField("Source Account No.");
                    if "Destination Account Type" <> "destination account type"::Loans then
                    TestField("Destination Account No.");
                    TestField("Effective/Start Date");
                    TestField(Frequency);
                    TestField("Next Run Date");


                    StatusPermissions.Reset;
                    StatusPermissions.SetRange(StatusPermissions."User ID",UserId);
                    StatusPermissions.SetRange(StatusPermissions."Function",StatusPermissions."function"::"Standing Order");
                    if StatusPermissions.Find('-') = false then
                    Error('You do not have permissions to change the standing order status.');
                end;
            }
            action(Reject)
            {
                ApplicationArea = Basic;
                Caption = 'Reject';
                Image = Reject;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    StatusPermissions.Reset;
                    StatusPermissions.SetRange(StatusPermissions."User ID",UserId);
                    StatusPermissions.SetRange(StatusPermissions."Function",StatusPermissions."function"::"Standing Order");
                    if StatusPermissions.Find('-') = false then
                    Error('You do not have permissions to change the standing status.');
                end;
            }
            action(Stop)
            {
                ApplicationArea = Basic;
                Caption = 'Stop';
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    StatusPermissions.Reset;
                    StatusPermissions.SetRange(StatusPermissions."User ID",UserId);
                    StatusPermissions.SetRange(StatusPermissions."Function",StatusPermissions."function"::"Standing Order");
                    if StatusPermissions.Find('-') = false then
                    Error('You do not have permissions to stop the standing order.');

                    if Confirm('Are you sure you want to stop the standing order?',false) = true then begin
                    //Status:=Status::"2";
                    //MODIFY;
                    end;
                end;
            }
            group(Approvals)
            {
                action(Approval)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approval;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        DocumentType:=Documenttype::StandingOrder;

                        ApprovalEntries.Setfilters(Database::"Standing Orders",DocumentType,"No.");
                        ApprovalEntries.Run;
                    end;
                }
                action("Send Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Approval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        Text001: label 'This request is already pending approval';
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        TestField("Source Account No.");
                        TestField("Standing Order Description");
                        if "Destination Account Type" <> "destination account type"::Loans then
                        TestField("Destination Account No.");

                        TestField("Effective/Start Date");
                        TestField(Frequency);
                        TestField("Next Run Date");

                        if "Destination Account Type" = "destination account type"::Loans then begin
                        CalcFields("Allocated Amount");
                        if Amount<>"Allocated Amount" then
                        Error('Allocated amount must be equal to amount');
                        end;

                        if Status<>Status::Open then
                        Error(Text001);
                        Message('Sent for Approval');

                        if ApprovalsMgmt.CheckStandingOrderApprovalsWorkflowEnabled(Rec) then
                          ApprovalsMgmt.OnSendStandingOrderForApproval(Rec);
                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Request';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        Approvalmgt: Codeunit "Approvals Mgmt.";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if ApprovalsMgmt.CheckStandingOrderApprovalsWorkflowEnabled(Rec) then
                           ApprovalsMgmt.OnCancelStandingOrderApprovalRequest(Rec);
                    end;
                }
            }
        }
        area(creation)
        {
            action(Create_STO)
            {
                ApplicationArea = Basic;
                Caption = 'Create_STO';
                Enabled = true;
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    TestField("Source Account No.");
                    if "Destination Account Type" <> "destination account type"::Loans then
                    TestField("Destination Account No.");
                    TestField("Effective/Start Date");
                    TestField(Frequency);
                    TestField("Next Run Date");

                    //IF Status<>Status::"2" THEN
                    //ERROR('Standing order status must be approved for you to create it');

                    StatusPermissions.Reset;
                    StatusPermissions.SetRange(StatusPermissions."User ID",UserId);
                    StatusPermissions.SetRange(StatusPermissions."Function",StatusPermissions."function"::"Standing Order");
                    if StatusPermissions.Find('-') = false then
                    Error('You do not have permissions to change the standing order status.');
                end;
            }
            action(Stop_STO)
            {
                ApplicationArea = Basic;
                Caption = 'Stop_STO';
                Image = Stop;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    StatusPermissions.Reset;
                    StatusPermissions.SetRange(StatusPermissions."User ID",UserId);
                    StatusPermissions.SetRange(StatusPermissions."Function",StatusPermissions."function"::"Standing Order");
                    if StatusPermissions.Find('-') = false then
                    Error('You do not have permissions to stop the standing order.');

                    if Confirm('Are you sure you want to stop the standing order?',false) = true then begin
                    Status:=Status::Open;
                    Modify;
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        BankName:='';
        if Banks.Get("Bank Code") then
        BankName:=Banks."Bank Name";

        ReceiptAllVisible:=false;
        DestinationAccountsVisible:=false;
        if "Destination Account Type"="destination account type"::Loans then
          begin
            ReceiptAllVisible:=true;
            DestinationAccountsVisible:=false;
            end;

        if "Destination Account Type"="destination account type"::Internal then
          begin
            ReceiptAllVisible:=false;
            DestinationAccountsVisible:=false;
            end;


        BankDetailsVisible:=false;
        if "Destination Account Type"="destination account type"::BOSA then
          begin
            BankDetailsVisible:=true;
            DestinationAccountsVisible:=false;
            ReceiptAllVisible:=true;
            end;

        if "Destination Account Type"="destination account type"::"4" then
          begin
           DestinationAccountsVisible:=true;
             end;


        if Status=Status::Open then
          begin
            AmountEditable:=true;
            DestinationAccountNoEditable:=true;
            DestinationAccountNameEditable:=true;
            FrequencyEditable:=true;
            DurationEditable:=true;
            EffectiveDateEditable:=true;
            DestinationAccountTypeEditable:=true
             end else
              if Status=Status::Pending then
                begin
                  AmountEditable:=false;
                  DestinationAccountNoEditable:=false;
                  DestinationAccountNameEditable:=false;
                  FrequencyEditable:=false;
                  DurationEditable:=false;
                  EffectiveDateEditable:=false;
                  DestinationAccountTypeEditable:=false
                  end else
                      begin
                        AmountEditable:=false;
                        DestinationAccountNoEditable:=false;
                        DestinationAccountNameEditable:=false;
                        FrequencyEditable:=false;
                        DurationEditable:=false;
                        EffectiveDateEditable:=false;
                        DestinationAccountTypeEditable:=false;
            end;
    end;

    trigger OnOpenPage()
    begin
         if Status=Status::Approved then
         CurrPage.Editable:=false;

        ReceiptAllVisible:=false;
        if "Destination Account Type"="destination account type"::Loans then
          begin
            ReceiptAllVisible:=true;
            end;

        BankDetailsVisible:=false;
        if "Destination Account Type"="destination account type"::BOSA then
          begin
            BankDetailsVisible:=true;
            ReceiptAllVisible:=true;
            end;





        if Status=Status::Open then
          begin
            AmountEditable:=true;
            DestinationAccountNoEditable:=true;
            DestinationAccountNameEditable:=true;
            FrequencyEditable:=true;
            DurationEditable:=true;
            EffectiveDateEditable:=true;
            DestinationAccountTypeEditable:=true
             end else
              if Status=Status::Pending then
                begin
                  AmountEditable:=false;
                  DestinationAccountNoEditable:=false;
                  DestinationAccountNameEditable:=false;
                  FrequencyEditable:=false;
                  DurationEditable:=false;
                  EffectiveDateEditable:=false;
                  DestinationAccountTypeEditable:=false
                  end else
                      begin
                        AmountEditable:=false;
                        DestinationAccountNoEditable:=false;
                        DestinationAccountNameEditable:=false;
                        FrequencyEditable:=false;
                        DurationEditable:=false;
                        EffectiveDateEditable:=false;
                        DestinationAccountTypeEditable:=false;
            end;
    end;

    var
        StatusPermissions: Record "Status Change Permision";
        BankName: Text[20];
        Banks: Record Banks;
        UsersID: Record User;
        RAllocations: Record "Receipt Allocation";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery;
        ReceiptAllVisible: Boolean;
        ObjAccount: Record Vendor;
        BankDetailsVisible: Boolean;
        AmountEditable: Boolean;
        DestinationAccountTypeEditable: Boolean;
        DestinationAccountNoEditable: Boolean;
        EffectiveDateEditable: Boolean;
        FrequencyEditable: Boolean;
        DescriptionEditable: Boolean;
        DestinationAccountNameEditable: Boolean;
        DurationEditable: Boolean;
        DestinationAccountsVisible: Boolean;

    local procedure AllocatedAmountOnDeactivate()
    begin
        CurrPage.Update:=true;
    end;
}

