#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 50010 "Sacco Transfer Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Sacco Transfers";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(No; Rec.No)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = Basic;
                    Editable = TransactionDateEditable;
                }
                field("Member No"; "Member No")
                {
                    ApplicationArea = Basic;
                    Editable = VarMemberNoEditable;
                }
                field("Member Name"; "Member Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Remarks; Remarks)
                {
                    ApplicationArea = Basic;
                    Editable = RemarkEditable;
                }
                field("Source Account Type"; "Source Account Type")
                {
                    ApplicationArea = Basic;
                    Editable = SourceAccountTypeEditable;
                }
                field("Source Account"; "Source Account")
                {
                    ApplicationArea = Basic;
                }
                field("Source Transaction Type"; "Source Transaction Type")
                {
                    ApplicationArea = Basic;
                    Editable = SourceAccountTypeEditable;

                    trigger OnValidate()
                    begin
                        DepositDebitTypeVisible := false;
                        if "Source Transaction Type" = "source transaction type"::"Deposit Contribution" then begin
                            DepositDebitTypeVisible := true;
                        end;
                    end;
                }
                field(Refund; Refund)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                    Style = Strong;
                    StyleExpr = true;
                    Visible = false;
                }
                group(DepositDebitType)
                {
                    Caption = 'Deposit Debit Type';
                    Editable = false;
                    Enabled = false;
                    Visible = false;
                    field("Deposit Debit Options"; "Deposit Debit Options")
                    {
                        ApplicationArea = Basic;
                        Editable = false;
                        Enabled = false;
                        Visible = false;
                    }
                }
                field("Source Loan No"; "Source Loan No")
                {
                    ApplicationArea = Basic;
                    Caption = 'FALSE';
                    Editable = false;
                    Enabled = false;
                    Visible = false;
                }
                field("Header Amount"; "Header Amount")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Schedule Total"; "Schedule Total")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Posted; Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(Approved; Approved)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Created By"; "Created By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Approved By"; "Approved By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
            }
            part(Control1102760014; "Sacco Transfer Schedule")
            {
                SubPageLink = "No." = field(No);
            }
        }
        area(factboxes)
        {
            part(Control2; "FOSA Statistics FactBox")
            {
                SubPageLink = "BOSA Account No" = field("Member No");
            }
            part(Control1; "Member Statistics FactBox")
            {
                Caption = 'BOSA Statistics FactBox';
                SubPageLink = "No." = field("Member No");
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Posting)
            {
                Caption = 'Posting';
                action("Send A&pproval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Enabled = (not OpenApprovalEntriesExist) and EnabledApprovalWorkflowExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        Text001: label 'This Batch is already pending approval';
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        TestField(Remarks);
                        // IF (("Schedule Total" > "Header Amount") AND (Refund)) THEN
                        //  ERROR('Scheduled Amount must be less or equal to Header Amount!');
                        //
                        // IF (("Schedule Total" > "Header Amount") AND
                        //  (NOT(("Source Transaction Type"="Source Transaction Type"::"Loan Repayment")
                        //  OR ("Source Transaction Type"="Source Transaction Type"::"Interest Paid") OR ("Source Transaction Type"="Source Transaction Type"::"Benevolent Fund")))) THEN
                        //  ERROR('Scheduled Amount must be less or equal to Header Amount!');
                        // IF  FnLimitNumberOfTransactions() THEN
                        //  ERROR(Txt0001);

                        if ApprovalsMgmt.CheckSaccoTransferApprovalsWorkflowEnabled(Rec) then
                            ApprovalsMgmt.OnSendSaccoTransferForApproval(Rec);
                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Enabled = CanCancelApprovalFOrRecord;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        if ApprovalsMgmt.CheckSaccoTransferApprovalsWorkflowEnabled(Rec) then
                            ApprovalsMgmt.OnCancelSaccoTransferApprovalRequest(Rec);
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        DocumentType := Documenttype::SaccoTransfers;
                        ApprovalEntries.Setfilters(Database::"Sacco Transfers", DocumentType, No);
                        ApprovalEntries.Run;
                    end;
                }
                action(Post)
                {
                    ApplicationArea = Basic;
                    Caption = 'Post';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin

                        if not (Status = Status::Approved) then begin
                            Error('The Transfer Schedule Must be approved');
                        end;

                        if BSched."Destination Loan" <> '' then
                            if BSched."Destination Type" = BSched."destination type"::"Loan Repayment" then
                                //MESSAGE('%1',BSched."Destination Loan");
                                LoansRegister.Reset;
                        LoansRegister.SetRange(LoansRegister."Loan  No.", BSched."Destination Loan");
                        if LoansRegister.Find('-') then begin
                            LoansRegister.CalcFields("Outstanding Balance", "Oustanding Interest");

                            if (LoansRegister."Outstanding Balance" <= 0) then begin
                                Error('the loan & interest has already been completed ');
                            end;


                            if BSched."Destination Type" = BSched."destination type"::"Interest Paid" then
                                if (LoansRegister."Oustanding Interest" <= 0) then
                                    Error('the loan & interest has already been completed ');
                        end;

                        // IF (("Schedule Total" > "Header Amount") AND (Refund)) THEN
                        //  ERROR('Scheduled Amount must be less or equal to Header Amount!');

                        // IF (("Schedule Total" > "Header Amount") AND
                        //  (NOT(("Source Transaction Type"="Source Transaction Type"::"Loan Repayment")
                        //  OR ("Source Transaction Type"="Source Transaction Type"::"Interest Paid") OR ("Source Transaction Type"="Source Transaction Type"::"Benevolent Fund")))) THEN
                        //  ERROR('Scheduled Amount must be less or equal to Header Amount!');

                        Jtemplate := 'GENERAL';
                        Jbatch := 'FTRANS';

                        if Posted = true then
                            Error('This Shedule is already posted');
                        TestField(Remarks);

                        if Confirm('Are you sure you want to transfer this schedule?', false) = true then begin

                            //      ObjVendors.RESET;
                            //    ObjVendors.SETRANGE(ObjVendors."No.","Source Account");
                            //    IF ObjVendors.FIND('-') THEN BEGIN
                            //    ObjVendors.CALCFIELDS(ObjVendors.Balance,ObjVendors."Uncleared Cheques");
                            //    //AvailableBal:=(ObjVendors.Balance-ObjVendors."Uncleared Cheques");
                            //    MESSAGE('sOURCE  balance'+FORMAT(ObjVendors.Balance));
                            //    MESSAGE('uncleared cheque'+FORMAT(ObjVendors."Uncleared Cheques"));
                            //    END;

                            // DELETE ANY LINE ITEM THAT MAY BE PRESENT
                            GenJournalLine.Reset;
                            GenJournalLine.SetRange(GenJournalLine."Journal Template Name", Jtemplate);
                            GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", Jbatch);
                            GenJournalLine.DeleteAll;

                            //Check Account Balance FOSA=============================================================================================
                            if "Source Account Type" = "source account type"::FOSA then begin
                                ObjVendors.Reset;
                                ObjVendors.SetRange(ObjVendors."No.", "Source Account");
                                if ObjVendors.Find('-') then begin
                                    ObjVendors.CalcFields(ObjVendors.Balance, ObjVendors."Uncleared Cheques");
                                    AvailableBal := (ObjVendors.Balance - ObjVendors."Uncleared Cheques");
                                    //    MESSAGE('sOURCE  balance'+FORMAT(ObjVendors.Balance));
                                    //    MESSAGE('uncleared cheque'+FORMAT(ObjVendors."Uncleared Cheques"));
                                    ObjAccTypes.Reset;
                                    ObjAccTypes.SetRange(ObjAccTypes.Code, ObjVendors."Account Type");
                                    if ObjAccTypes.Find('-') then
                                        AvailableBal := AvailableBal - ObjAccTypes."Minimum Balance";
                                end;

                                CalcFields("Schedule Total");
                                if AvailableBal < "Schedule Total" then begin
                                    // //            MESSAGE('sOURCE  balance'+FORMAT(ObjVendors.Balance));
                                    // //    MESSAGE('uncleared cheque'+FORMAT(ObjVendors."Uncleared Cheques"));
                                    Error('The Member FOSA Account has Less than the Schedule Total,Account balance is %1', AvailableBal);
                                end;
                            end;
                            //End Check Account Balance FOSA=============================================================================================

                            //Check Account Balance BOSA=============================================================================================
                            if "Source Account Type" = "source account type"::MEMBER then begin
                                ObjLoans.Reset;
                                ObjLoans.SetRange("Loan  No.", "Source Loan No");
                                if ObjLoans.Find('-') then begin
                                    ObjLoans.CalcFields("Outstanding Balance", "Oustanding Interest");
                                    if "Source Transaction Type" = "source transaction type"::"Loan Repayment" then
                                        AvailableBal := ObjLoans."Outstanding Balance";
                                    if "Source Transaction Type" = "source transaction type"::"Interest Paid" then
                                        AvailableBal := ObjLoans."Oustanding Interest";
                                    // MESSAGE('Outstanding Interest is=%1',ObjLoans."Oustanding Interest");
                                end;

                                ObjMember.Reset;
                                ObjMember.SetRange(ObjMember."No.", "Source Account");
                                if ObjMember.Find('-') then begin
                                    ObjMember.CalcFields(ObjMember."Current Shares", ObjMember."FOSA Shares", ObjMember."Shares Retained", ObjMember."Benevolent Fund", ObjMember."Dividend Amount", ObjMember."Un-allocated Funds");
                                    if "Source Transaction Type" = "source transaction type"::"Deposit Contribution" then begin
                                        AvailableBal := ObjMember."Current Shares"
                                    end else
                                        if "Source Transaction Type" = "source transaction type"::"Share Capital" then begin
                                            AvailableBal := ObjMember."Shares Retained"
                                        end else
                                            if "Source Transaction Type" = "source transaction type"::"Benevolent Fund" then begin
                                                AvailableBal := ObjMember."Benevolent Fund"
                                            end else
                                                if "Source Transaction Type" = "source transaction type"::Dividend then begin
                                                    AvailableBal := ObjMember."Dividend Amount";
                                                end
                                                else
                                                    if "Source Transaction Type" = "source transaction type"::"Unallocated Funds" then begin
                                                        AvailableBal := ObjMember."Un-allocated Funds";
                                                    end;
                                    if "Source Transaction Type" = "source transaction type"::"FOSA Shares" then begin
                                        AvailableBal := ObjMember."FOSA Shares";
                                        //ERROR(FORMAT(AvailableBal));
                                    end;


                                    CalcFields("Schedule Total");
                                    if AvailableBal < "Schedule Total" then begin
                                        Error('The Member %1 Account has Less than the Schedule Total,Account balance is %2', "Source Transaction Type", AvailableBal);
                                    end;
                                end;
                            end;
                            if ("Source Transaction Type" = "source transaction type"::"Loan Repayment") then begin
                                if AvailableBal <= 0 then
                                    Error('this loan has been completed being paid.');
                            end;
                            if ("Source Transaction Type" = "source transaction type"::"Interest Paid") then begin
                                if AvailableBal <= 0 then
                                    Error('this loan interest has been completed being paid.');
                            end;
                            //End Check Account Balance BOSA=============================================================================================



                            //POSTING MAIN TRANSACTION

                            //window.OPEN('Posting:,#1######################');

                            //--------------------------------(Debit Member Deposit Account)---------------------------------------------

                            //Partial Refund Fee=======================================================================================
                            if "Deposit Debit Options" = "deposit debit options"::"Partial Refund" then begin
                                ObjGensetup.Get();
                                BATCH_TEMPLATE := Jtemplate;
                                BATCH_NAME := Jbatch;
                                DOCUMENT_NO := No;

                                GenJournalLine.Reset;
                                GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                                GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                                GenJournalLine.DeleteAll;

                                VarExciseDuty := (ObjGensetup."Excise Duty(%)" / 100) * ObjGensetup."Partial Deposit Refund Fee";
                                VarExciseDutyAccount := ObjGensetup."Excise Duty Account";

                                //------------------------------------1. DEBIT MEMBER DEPOSITS A/C---------------------------------------------------------------------------------------------
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                                GenJournalLine."account type"::Member, "Source Account", Today, ObjGensetup."Partial Deposit Refund Fee", 'BOSA', '',
                                Remarks + ' ' + "Source Account", '');
                                //--------------------------------(Debit Member Deposit Account)---------------------------------------------

                                //------------------------------------1.1. CREDIT FEE  GL A/C---------------------------------------------------------------------------------------------
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                GenJournalLine."account type"::"G/L Account", ObjGensetup."Partial Deposit Refund Fee A/C", Today, ObjGensetup."Partial Deposit Refund Fee" * -1, 'BOSA', '',
                                Remarks + ' ' + "Source Account", '');
                                //----------------------------------(Credit Fee GL Account)------------------------------------------------

                                //------------------------------------2. DEBIT MEMBER DEPOSITS A/C EXCISE ON FEE---------------------------------------------------------------------------------------------
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                                GenJournalLine."account type"::Member, "Source Account", Today, VarExciseDuty, 'BOSA', '',
                                Remarks + ' ' + "Source Account", '');
                                //--------------------------------(Debit Member Deposit Account Excise Duty)---------------------------------------------

                                //------------------------------------2.1. CREDIT EXCISE  GL A/C---------------------------------------------------------------------------------------------
                                LineNo := LineNo + 10000;
                                SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                                GenJournalLine."account type"::"G/L Account", VarExciseDutyAccount, Today, VarExciseDuty * -1, 'BOSA', '',
                                Remarks + ' ' + "Source Account", '');
                                //----------------------------------(Credit Excise GL Account)------------------------------------------------
                            end;

                            // UPDATE Source Account
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := Jtemplate;
                            GenJournalLine."Journal Batch Name" := Jbatch;
                            GenJournalLine."Document No." := No;
                            GenJournalLine."Line No." := GenJournalLine."Line No." + 10000;
                            if "Source Account Type" = "source account type"::Customer then begin
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Customer;
                                GenJournalLine."Transaction Type" := "Source Transaction Type";
                                GenJournalLine."Account No." := "Source Account";
                                GenJournalLine."Loan No" := "Source Loan No";
                            end else
                                if "Source Account Type" = "source account type"::MEMBER then begin
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                                    GenJournalLine."Transaction Type" := "Source Transaction Type";
                                    GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                    GenJournalLine."Shortcut Dimension 2 Code" := BTRANS."Global Dimension 2 Code";
                                    GenJournalLine."Account No." := "Source Account";
                                    GenJournalLine."Loan No" := "Source Loan No";
                                end else

                                    if "Source Account Type" = "source account type"::FOSA then begin
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                        GenJournalLine."Transaction Type" := "Source Transaction Type";
                                        GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                                        GenJournalLine."Shortcut Dimension 2 Code" := BTRANS."Global Dimension 2 Code";
                                        GenJournalLine."Account No." := "Source Account";
                                    end else
                                        if "Source Account Type" = "source account type"::"G/L ACCOUNT" then begin
                                            GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                                            GenJournalLine."Transaction Type" := "Source Transaction Type";
                                            GenJournalLine."Shortcut Dimension 2 Code" := SFactory.FnGetUserBranch();
                                            GenJournalLine."Account No." := "Source Account";
                                            if "Source Transaction Type" = "source transaction type"::"Benevolent Fund" then
                                                GenJournalLine."Account No." := '16419';
                                        end else
                                            if "Source Account Type" = "source account type"::Bank then begin
                                                GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                                                GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                                GenJournalLine."Shortcut Dimension 2 Code" := BTRANS."Global Dimension 2 Code";
                                                GenJournalLine."Account No." := "Source Account";
                                            end;
                            GenJournalLine."Posting Date" := "Transaction Date";
                            GenJournalLine.Description := Remarks;
                            if "Source Transaction Type" = "source transaction type"::"Benevolent Fund" then
                                GenJournalLine.Description := "Member No";
                            CalcFields("Schedule Total");
                            GenJournalLine.Amount := "Schedule Total";
                            if (("Source Transaction Type" = "source transaction type"::"Loan Repayment") or ("Source Transaction Type" = "source transaction type"::"Interest Paid")) then begin
                                //------------------------------------1. CREDIT LOAN---------------------------------------------------------------------------------------------
                                GenJournalLine.Amount := "Schedule Total" * -1;
                                if Refund then
                                    GenJournalLine.Amount := "Schedule Total";
                            end;
                            GenJournalLine.Insert;



                            BSched.Reset;
                            BSched.SetRange(BSched."No.", No);
                            if BSched.Find('-') then begin

                                repeat
                                    BSched.TestField(BSched."Transaction Description");
                                    GenJournalLine.Init;

                                    GenJournalLine."Journal Template Name" := Jtemplate;
                                    GenJournalLine."Journal Batch Name" := Jbatch;
                                    GenJournalLine."Document No." := No;
                                    GenJournalLine."Line No." := GenJournalLine."Line No." + 10000;

                                    if BSched."Destination Account Type" = BSched."destination account type"::MEMBER then begin
                                        GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                                        GenJournalLine."Account No." := BSched."Destination Account No.";
                                        GenJournalLine."Shortcut Dimension 2 Code" := BSched."Global Dimension 2 Code";
                                    end else

                                        if BSched."Destination Account Type" = BSched."destination account type"::VENDOR then begin
                                            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                            //GenJournalLine."Transaction Type":=BSched."Destination Type";
                                            GenJournalLine."Account No." := BSched."Destination Account No.";
                                            GenJournalLine."Shortcut Dimension 2 Code" := BSched."Global Dimension 2 Code";
                                        end else
                                            if BSched."Destination Account Type" = BSched."destination account type"::"G/L ACCOUNT" then begin
                                                GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                                                GenJournalLine."Account No." := BSched."Destination Account No.";
                                                GenJournalLine."Shortcut Dimension 2 Code" := SFactory.FnGetUserBranch();

                                            end else
                                                if BSched."Destination Account Type" = BSched."destination account type"::BANK then begin
                                                    GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                                                    GenJournalLine."Account No." := BSched."Destination Account No.";
                                                    GenJournalLine."Shortcut Dimension 2 Code" := BSched."Global Dimension 2 Code";
                                                end;

                                    GenJournalLine."Transaction Type" := BSched."Destination Type";
                                    GenJournalLine."Loan No" := BSched."Destination Loan";
                                    GenJournalLine.Validate(GenJournalLine."Loan No");
                                    GenJournalLine."Posting Date" := "Transaction Date";
                                    GenJournalLine.Description := Remarks + '-' + "Source Loan No";
                                    GenJournalLine.Amount := -BSched.Amount;


                                    if BSched."Destination Type" = BSched."destination type"::Loan then
                                        GenJournalLine.Amount := BSched.Amount;
                                    GenJournalLine.Insert;
                                until BSched.Next = 0;
                            end;
                            //CU posting
                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", Jtemplate);
                            GenJournalLine.SetRange("Journal Batch Name", Jbatch);
                            if GenJournalLine.Find('-') then
                                Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);

                            //Post
                            Posted := true;
                            Modify;
                        end;
                        CurrPage.Close;
                        //END;
                        //END;
                    end;
                }
                action(Print)
                {
                    ApplicationArea = Basic;
                    Caption = 'Print';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        BTRANS.Reset;
                        BTRANS.SetRange(BTRANS.No, No);
                        if BTRANS.Find('-') then begin
                            Report.Run(51516902, true, true, BTRANS);
                        end;
                    end;
                }
            }
            action("Members Statistics")
            {
                ApplicationArea = Basic;
                Caption = 'Member Details';
                Image = Statistics;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = Page "Members Statistics";
                RunPageLink = "No." = field(Field11);
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        AddRecordRestriction();

        EnablePost := false;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
        CanCancelApprovalFOrRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);
        EnabledApprovalWorkflowExist := true;
        if Rec.Status = Status::Approved then begin
            OpenApprovalEntriesExist := false;
            CanCancelApprovalFOrRecord := false;
            EnabledApprovalWorkflowExist := false;
        end;
        if Rec.Status = Status::Approved then
            EnablePost := true;

        DepositDebitTypeVisible := false;
        if "Source Transaction Type" = "source transaction type"::"Deposit Contribution" then begin
            DepositDebitTypeVisible := true;
        end;
        "Transaction Date" := Today;
        Modify;
    end;

    trigger OnAfterGetRecord()
    begin
        AddRecordRestriction();

        DepositDebitTypeVisible := false;
        if "Source Transaction Type" = "source transaction type"::"Deposit Contribution" then begin
            DepositDebitTypeVisible := true;
        end;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        Error('Not Allowed!');
    end;

    trigger OnOpenPage()
    begin
        AddRecordRestriction();

        DepositDebitTypeVisible := false;
        if "Source Transaction Type" = "source transaction type"::"Deposit Contribution" then begin
            DepositDebitTypeVisible := true;
        end;
    end;

    var
        users: Record User;
        GenJournalLine: Record "Gen. Journal Line";
        LoansRegister: Record "Loans Register";
        DefaultBatch: Record "Gen. Journal Batch";
        BSched: Record "Sacco Transfers Schedule";
        BTRANS: Record "Sacco Transfers";
        DActivity: Code[20];
        DBranch: Code[20];
        UsersID: Record User;
        FundsUSer: Record "Funds User Setup";
        Jtemplate: Code[10];
        Jbatch: Code[10];
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers;
        SourceAccountNoEditbale: Boolean;
        SourceAccountNameEditable: Boolean;
        SourceAccountTypeEditable: Boolean;
        SourceTransactionType: Boolean;
        SourceLoanNoEditable: Boolean;
        RemarkEditable: Boolean;
        TransactionDateEditable: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ObjSaccoTransfers: Record "Sacco Transfers";
        OpenApprovalEntriesExist: Boolean;
        EnabledApprovalWorkflowExist: Boolean;
        CanCancelApprovalFOrRecord: Boolean;
        EnablePost: Boolean;
        Txt0001: label 'You cannot transfer another amount before three months elapse. ';
        DepositDebitTypeVisible: Boolean;
        ObjGensetup: Record "Sacco General Set-Up";
        BATCH_TEMPLATE: Code[50];
        BATCH_NAME: Code[50];
        DOCUMENT_NO: Code[50];
        LineNo: Integer;
        SFactory: Codeunit "SURESTEP Factory";
        VarExciseDuty: Decimal;
        VarExciseDutyAccount: Code[30];
        VarDepositDebitTypeEditable: Boolean;
        ObjVendors: Record Vendor;
        AvailableBal: Decimal;
        ObjAccTypes: Record "Account Types-Saving Products";
        ObjMember: Record "Member Register";
        VarMemberNoEditable: Boolean;
        ObjLoans: Record "Loans Register";

    local procedure AddRecordRestriction()
    begin
        if Status = Status::Open then begin
            SourceAccountNoEditbale := true;
            SourceAccountNameEditable := true;
            SourceAccountTypeEditable := true;
            SourceLoanNoEditable := true;
            SourceTransactionType := true;
            TransactionDateEditable := true;
            VarDepositDebitTypeEditable := true;
            VarMemberNoEditable := true;
            RemarkEditable := true
        end else
            if Status = Status::"Pending Approval" then begin
                SourceAccountNoEditbale := false;
                SourceAccountNameEditable := false;
                SourceAccountTypeEditable := false;
                SourceLoanNoEditable := false;
                SourceTransactionType := false;
                TransactionDateEditable := false;
                VarDepositDebitTypeEditable := false;
                VarMemberNoEditable := false;
                RemarkEditable := false
            end else
                if Status = Status::Approved then begin
                    SourceAccountNoEditbale := false;
                    SourceAccountNameEditable := false;
                    SourceAccountTypeEditable := false;
                    SourceLoanNoEditable := false;
                    SourceTransactionType := false;
                    TransactionDateEditable := false;
                    VarDepositDebitTypeEditable := false;
                    VarMemberNoEditable := false;
                    RemarkEditable := false;
                end;
    end;

    local procedure FnLimitNumberOfTransactions(): Boolean
    begin
        // k
    end;
}

