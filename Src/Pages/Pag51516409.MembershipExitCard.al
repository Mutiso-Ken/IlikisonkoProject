#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516409 "Membership Exit Card"
{
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption';
    SourceTable = "Membership Exit";
    SourceTableView = where(Posted = filter(false));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member No."; "Member No.")
                {
                    ApplicationArea = Basic;
                    Editable = MNoEditable;
                }
                field("Member Name"; "Member Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Closure Type"; "Closure Type")
                {
                    ApplicationArea = Basic;
                    Editable = ClosureTypeEditable;
                }
                field("Closing Date"; "Closing Date")
                {
                    ApplicationArea = Basic;
                    Editable = ClosingDateEditable;
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Payment Date';
                }
                field("Application Date"; "Application Date")
                {
                    ApplicationArea = Basic;
                }
                field("Expected Posting Date"; "Expected Posting Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Expected Payment Date';
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Sell Share Capital"; "Sell Share Capital")
                {
                    ApplicationArea = Basic;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        ShareCapitalTransferVisible := false;
                        ShareCapSellPageVisible := false;
                        if "Sell Share Capital" = true then begin
                            ShareCapitalTransferVisible := true;
                            ShareCapSellPageVisible := true;
                        end;
                    end;
                }
                field("Total Loan"; "Total Loan")
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Loan BOSA';
                    Editable = false;
                }
                field("Total Interest"; "Total Interest")
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Interest Due BOSA';
                    Editable = false;
                }
                field("Member Deposits"; "Member Deposits")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Share Capital"; "Share Capital")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Unpaid Share Capital"; "Unpaid Share Capital")
                {
                    ApplicationArea = Basic;
                }
                field("Refundable Share Capital"; "Refundable Share Capital")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Share Capital to Sell"; "Share Capital to Sell")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Risk Fund"; "Risk Fund")
                {
                    ApplicationArea = Basic;
                    Caption = 'Net Refund';
                    Editable = false;
                    Visible = false;
                }
                field("Net Payable to the Member"; "Net Payable to the Member")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Risk Beneficiary"; "Risk Beneficiary")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Mode Of Disbursement"; "Mode Of Disbursement")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Paying Bank"; "Paying Bank")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("FOSA Account No."; "FOSA Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Cheque No."; "Cheque No.")
                {
                    ApplicationArea = Basic;
                }
                field(Payee; Payee)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("User ID"; "User ID")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
            }
            group("Share Capital Transfer Details")
            {
                Caption = 'Share Capital Transfer Details';
                Visible = ShareCapitalTransferVisible;
                field("Share Capital Transfer Fee"; "Share Capital Transfer Fee")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            part("Share Capital Sell"; "M_Withdrawal Share Cap Sell")
            {
                SubPageLink = "Document No" = field("No."),
                              "Selling Member No" = field("Member No."),
                              "Selling Member Name" = field("Member Name");
                Visible = ShareCapSellPageVisible;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Function")
            {
                Caption = 'Function';
                action(Post)
                {
                    ApplicationArea = Basic;
                    Caption = 'Post';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        TestField(Posted, false);
                        TestField(Status, Status::Approved);
                        if Confirm('Are you absolutely sure you want to recover the loans from member deposit') = false then
                            exit;
                        WithdrawalFee := 0;
                        TransferFee := 0;
                        RunningBal := 0;


                        if cust.Get("Member No.") then begin
                            if "Net Payable to the Member" < 0 then
                                Error('The Member Does have enough Deposits to Clear Loans');

                            //-----------------------------------------Assign Standard variables-------------------------------------------------------------
                            DActivity := cust."Global Dimension 1 Code";
                            DBranch := cust."Global Dimension 2 Code";
                            TemplateName := 'GENERAL';
                            BatchName := 'CLOSURE';
                            Doc_No := "No.";

                            Generalsetup.Get();

                            //------------------------------------------Delete Journal Lines----------------------------------------------------------------------
                            Gnljnline.Reset;
                            Gnljnline.SetRange("Journal Template Name", TemplateName);
                            Gnljnline.SetRange("Journal Batch Name", BatchName);
                            Gnljnline.DeleteAll;
                            //------------------------------------------Post Transaction---------------------------------------------------------------------------
                            if ("Closure Type" = "closure type"::"Withdrawal - Normal") then begin
                                RefundableDeposits := "Member Deposits" - "Member Guarantorship Liability";
                                //FnDebitMemberDepositsAndShareCapital(RefundableDeposits,"Refundable Share Capital");
                                RunningBal := RefundableDeposits + "Refundable Share Capital";
                                RunningBal := FnRecoverBOSAInterest(RunningBal);
                                RunningBal := FnRecoverBOSALoanPrinciple(RunningBal);
                                FnDebitMemberDepositsAndShareCapital(RunningBal, "Refundable Share Capital");
                                FnTransferToBank(RunningBal);
                                //----------------------------------------Post Transaction----------------------------------------------------------------------------
                            end else
                                if ("Closure Type" = "closure type"::"Withdrawal - Death") then begin
                                    RunningBal := "Member Deposits" + "Refundable Share Capital";
                                    FnDebitMemberDepositsAndShareCapital("Member Deposits", "Refundable Share Capital");

                                    FnTransferToBank(RunningBal);
                                end;
                        end;


                        //FNPostShareCapTransfer();

                        if cust.Get("Member No.") then begin
                            cust.Blocked := cust.Blocked::" ";
                            cust.Modify;
                        end;

                        //
                        // //Post New
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name", 'CLOSURE');
                        if GenJournalLine.Find('-') then begin
                            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Batch", GenJournalLine);
                        end;


                        "Closing Date" := Today;
                        Posted := true;
                        Message('Closure posted successfully.');


                        // //CHANGE ACCOUNT STATUS

                        if ("Closure Type" = "closure type"::"Withdrawal - Death") or ("Closure Type" = "closure type"::"2") then begin
                            cust.Reset;
                            cust.SetRange(cust."No.", "Member No.");
                            if cust.Find('-') then begin
                                cust.Status := cust.Status::Deceased;
                                cust.Blocked := cust.Blocked::All;
                                cust.Modify;
                            end;
                        end else
                            cust.Reset;
                        cust.SetRange(cust."No.", "Member No.");
                        if cust.Find('-') then begin
                            cust.Status := cust.Status::Withdrawal;
                            cust."Closing Date" := Today;
                            // cust.Blocked:=cust.Blocked::All;
                            cust.Modify;
                        end;


                        CurrPage.Close();
                    end;
                }
                action("Send Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Enabled = (not OpenApprovalEntriesExist) and EnabledApprovalWorkflowsExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        text001: label 'This batch is already pending approval';
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if Status <> Status::Open then
                            Error(text001);

                        if ApprovalsMgmt.CheckMWithdrawalApprovalsWorkflowEnabled(Rec) then
                            ApprovalsMgmt.OnSendMWithdrawalForApproval(Rec);

                        //Change Status To Awaiting Withdrawing
                        MemberRegister.Reset;
                        MemberRegister.SetRange(MemberRegister."No.", "Member No.");
                        if MemberRegister.Find('-') then begin
                            MemberRegister.Status := MemberRegister.Status::"Awaiting Withdrawal";
                            MemberRegister.Modify;
                        end;

                        GenSetUp.Get();

                        if Generalsetup."Send Membership Withdrawal SMS" = true then begin
                            FnSendWithdrawalApplicationSMS();
                        end;
                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel A&pproval Request';
                    Enabled = CanCancelApprovalForRecord;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        text001: label 'This batch is already pending approval';
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        if ApprovalsMgmt.CheckMWithdrawalApprovalsWorkflowEnabled(Rec) then
                            ApprovalMgt.OnCancelMWithdrawalApprovalRequest(Rec);
                    end;
                }
                action(Approvals)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        ApprovalsMgmt.OpenApprovalEntriesPage(RecordId);
                    end;
                }
                action("Account closure Slip")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        cust.Reset;
                        cust.SetRange(cust."No.", "Member No.");
                        if cust.Find('-') then
                            Report.Run(51516474, true, false, cust);
                    end;
                }
                action("Print Cheque")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    begin
                        /*
                        ClosureR.RESET;
                        ClosureR.SETRANGE(ClosureR."Member No.","Member No.");
                        IF ClosureR.FIND('-') THEN
                        REPORT.RUN(,TRUE,FALSE,ClosureR);
                        */

                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControl();
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);
        EnabledApprovalWorkflowsExist := true;
        if Rec.Status = Status::Approved then begin
            OpenApprovalEntriesExist := false;
            CanCancelApprovalForRecord := false;
            EnabledApprovalWorkflowsExist := false;
        end;
    end;

    trigger OnAfterGetRecord()
    begin
        ShareCapitalTransferVisible := false;
        ShareCapSellPageVisible := false;
        if "Sell Share Capital" = true then begin
            ShareCapitalTransferVisible := true;
            ShareCapSellPageVisible := true;
        end;
        "Mode Of Disbursement" := "mode of disbursement"::Vendor;
        Modify;
        UpdateControl();
    end;

    trigger OnOpenPage()
    begin
        ShareCapitalTransferVisible := false;
        ShareCapSellPageVisible := false;
        PostingDateEditable := false;
        if "Sell Share Capital" = true then begin
            ShareCapitalTransferVisible := true;
            ShareCapSellPageVisible := true;
        end;
        "Mode Of Disbursement" := "mode of disbursement"::Vendor;
        UpdateControl();
    end;

    var
        Closure: Integer;
        Text001: label 'Not Approved';
        cust: Record "Member Register";
        UBFRefund: Decimal;
        Generalsetup: Record "Sacco General Set-Up";
        Totalavailable: Decimal;
        UnpaidDividends: Decimal;
        TotalOustanding: Decimal;
        Vend: Record Vendor;
        value2: Decimal;
        Gnljnline: Record "Gen. Journal Line";
        Totalrecovered: Decimal;
        Advice: Boolean;
        TotalDefaulterR: Decimal;
        AvailableShares: Decimal;
        Loans: Record "Loans Register";
        Value1: Decimal;
        Interest: Decimal;
        LineN: Integer;
        LRepayment: Decimal;
        Vendno: Code[20];
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication,BulkWithdrawal,PackageLodging,PackageRetrieval;
        MNoEditable: Boolean;
        ClosingDateEditable: Boolean;
        ClosureTypeEditable: Boolean;
        PostingDateEditable: Boolean;
        TotalFOSALoan: Decimal;
        TotalInsuarance: Decimal;
        DActivity: Code[30];
        DBranch: Code[30];
        LineNo: Integer;
        GenJournalLine: Record "Gen. Journal Line";
        "Remaining Amount": Decimal;
        LoansR: Record "Loans Register";
        "AMOUNTTO BE RECOVERED": Decimal;
        PrincipInt: Decimal;
        TotalLoansOut: Decimal;
        ClosureR: Record "Membership Exit";
        Table_id: Integer;
        Doc_No: Code[20];
        Doc_Type: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery,ChangeRequest,TreasuryTransactions,FundsTransfer,SaccoTransfers,ChequeDiscounting,ImprestRequisition,ImprestSurrender,LeaveApplication,BulkWithdrawal,PackageLodging,PackageRetrieval;
        PTEN: Text;
        DataSheet: Record "Data Sheet Main";
        Customer: Record "Member Register";
        GenSetUp: Record "Sacco General Set-Up";
        compinfo: Record "Company Information";
        SMSMessage: Record "SMS Messages";
        iEntryNo: Integer;
        ShareCapitalTransferVisible: Boolean;
        ShareCapSellPageVisible: Boolean;
        ObjShareCapSell: Record "M_Withdrawal Share Cap Sell";
        SurestepFactory: Codeunit "SURESTEP Factory";
        JVTransactionType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account","Loan Insurance Charged","Loan Insurance Paid","Recovery Account","FOSA Shares","Additional Shares";
        JVAccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee,Member,Investor;
        TemplateName: Code[20];
        BatchName: Code[20];
        JVBalAccounttype: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee;
        JVBalAccountNo: Code[20];
        TransferFee: Decimal;
        WithdrawalFee: Decimal;
        TransferGL: Code[20];
        WithFeeGL: Code[20];
        ExciseGL: Code[20];
        RunningBal: Decimal;
        EnabledApprovalWorkflowsExist: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        CanCancelApprovalForRecord: Boolean;
        EventFilter: Text;
        OpenApprovalEntriesExist: Boolean;
        MWithdrawalGraduatedCharges: Record "MWithdrawal Graduated Charges";
        MemberRegister: Record "Member Register";
        RefundableDeposits: Decimal;


    procedure UpdateControl()
    begin
        if Status = Status::Open then begin
            MNoEditable := true;
            ClosingDateEditable := false;
            ClosureTypeEditable := true;
            PostingDateEditable := false;
        end;

        if Status = Status::Pending then begin
            MNoEditable := false;
            ClosingDateEditable := false;
            ClosureTypeEditable := false;
            PostingDateEditable := false;
        end;

        if Status = Status::Rejected then begin
            MNoEditable := false;
            ClosingDateEditable := false;
            ClosureTypeEditable := false;
            PostingDateEditable := false;
        end;

        if Status = Status::Approved then begin
            MNoEditable := false;
            ClosingDateEditable := true;
            ClosureTypeEditable := false;
            PostingDateEditable := true;
        end;
    end;


    procedure FnSendWithdrawalApplicationSMS()
    begin

        GenSetUp.Get;
        compinfo.Get;



        //SMS MESSAGE
        SMSMessage.Reset;
        if SMSMessage.Find('+') then begin
            iEntryNo := SMSMessage."Entry No";
            iEntryNo := iEntryNo + 1;
        end
        else begin
            iEntryNo := 1;
        end;


        SMSMessage.Init;
        SMSMessage."Entry No" := iEntryNo;
        SMSMessage."Batch No" := "No.";
        SMSMessage."Document No" := "No.";
        SMSMessage."Account No" := "Member No.";
        SMSMessage."Date Entered" := Today;
        SMSMessage."Time Entered" := Time;
        SMSMessage.Source := 'MEMBERSHIPWITH';
        SMSMessage."Entered By" := UserId;
        SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
        SMSMessage."SMS Message" := 'Dear Member,Your Membership Withdrawal Application has been received and is being Processed '
        + compinfo.Name + ' ' + GenSetUp."Customer Care No";
        cust.Reset;
        cust.SetRange(cust."No.", "Member No.");
        if cust.Find('-') then begin
            SMSMessage."Telephone No" := cust."Mobile Phone No";
        end;
        if cust."Mobile Phone No" <> '' then
            SMSMessage.Insert;
    end;

    local procedure FnRecoverBOSAInterest(Bal: Decimal): Decimal
    var
        ObjLoans: Record "Loans Register";
        AmountToDeduct: Decimal;
    begin
        if Bal > 0 then begin
            ObjLoans.Reset;
            ObjLoans.SetRange(ObjLoans."Client Code", "Member No.");
            ObjLoans.SetRange(ObjLoans.Source, ObjLoans.Source::BOSA);
            if ObjLoans.Find('-') then begin
                repeat
                    ObjLoans.CalcFields(ObjLoans."Outstanding Balance", ObjLoans."Oustanding Interest");
                    if ObjLoans."Oustanding Interest" > 0 then begin
                        AmountToDeduct := ObjLoans."Oustanding Interest";
                        if AmountToDeduct > Bal then
                            AmountToDeduct := Bal
                        else
                            AmountToDeduct := AmountToDeduct;
                        //------------------------------Debit Member Deposits------------------------------
                        LineNo := LineNo + 10000;
                        SurestepFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                                                  GenJournalLine."account type"::Member, "Member No.", "Posting Date", AmountToDeduct, DActivity,
                                                  ObjLoans."Loan  No.", 'Repay Interest(With): ' + "No." + '-' + ObjLoans."Loan  No.", ObjLoans."Loan  No.");
                        //--------------------------------End------------------------------------
                        //-------------------------------Credit Loan Interest-----------------------------
                        LineNo := LineNo + 10000;
                        SurestepFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."transaction type"::"Interest Paid",
                                                  GenJournalLine."account type"::Member, ObjLoans."Client Code", "Posting Date", AmountToDeduct * -1, DActivity,
                                                  ObjLoans."Loan  No.", 'Interest Recovered(With): ' + "No." + '-' + ObjLoans."Loan  No.", ObjLoans."Loan  No.");
                        //--------------------------------End------------------------------------
                        Bal := Bal - AmountToDeduct;
                    end;

                until ObjLoans.Next = 0;
            end;
        end;

        exit(Bal);
    end;

    local procedure FnRecoverBOSALoanPrinciple(Bal: Decimal): Decimal
    var
        ObjLoans: Record "Loans Register";
        AmountToDeduct: Decimal;
    begin
        if Bal > 0 then begin
            ObjLoans.Reset;
            ObjLoans.SetRange(ObjLoans."Client Code", "Member No.");
            ObjLoans.SetRange(ObjLoans.Source, ObjLoans.Source::BOSA);
            if ObjLoans.Find('-') then begin
                repeat
                    ObjLoans.CalcFields(ObjLoans."Outstanding Balance");
                    if ObjLoans."Outstanding Balance" > 0 then begin
                        AmountToDeduct := ObjLoans."Outstanding Balance";
                        if AmountToDeduct > Bal then
                            AmountToDeduct := Bal
                        else
                            AmountToDeduct := AmountToDeduct;
                        //-----------------------------------------Debit Member Deposits-----------------------------------------------------------------------------
                        LineNo := LineNo + 10000;
                        SurestepFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                                                  GenJournalLine."account type"::Member, "Member No.", "Posting Date", AmountToDeduct, DActivity,
                                                  ObjLoans."Loan  No.", 'Repay Loan(With): ' + "No." + '-' + ObjLoans."Loan  No.", ObjLoans."Loan  No.");
                        //----------------------------------------------End---------------------------------------------------------------------------------
                        //-----------------------------------------Credit Loans-----------------------------------------------------------------------------
                        LineNo := LineNo + 10000;
                        SurestepFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                                                  GenJournalLine."account type"::Member, ObjLoans."Client Code", "Posting Date", AmountToDeduct * -1, DActivity,
                                                  ObjLoans."Loan  No.", 'Offset by Transferred(With): ' + "No." + '-' + ObjLoans."Loan  No.", ObjLoans."Loan  No.");
                        //------------------------------------------End--------------------------------------------------------------------------------------
                        Bal := Bal - AmountToDeduct;
                        //FnUpdateDatasheetMain(ObjLoans."Loan  No.");
                    end;
                until ObjLoans.Next = 0;
            end;
        end;

        exit(Bal);
    end;

    local procedure FnDebitMemberDepositsAndShareCapital(DepositContributions: Decimal; RefundableShareCapital: Decimal)
    var
        AmountToTransfer: Decimal;
        AccountNo: Code[20];
    begin
        LineNo := LineNo + 10000;
        SurestepFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."transaction type"::"Deposit Contribution",
                   GenJournalLine."account type"::Member, "Member No.", "Posting Date", DepositContributions, DActivity, "No.", 'Account Closure(With): ' + "No.", '');
        LineNo := LineNo + 10000;
        SurestepFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."transaction type"::"Share Capital",
                   GenJournalLine."account type"::Member, "Member No.", "Posting Date", RefundableShareCapital, DActivity, "No.", 'Account Closure(With): ' + "No.", '');
    end;

    local procedure FnUpdateDatasheetMain(LoanNum: Code[20])
    var
        ObjLoans: Record "Loans Register";
    begin
        ObjLoans.Reset;
        ObjLoans.SetRange(ObjLoans."Loan  No.", LoanNum);
        if ObjLoans.Find('-') then begin
            PTEN := '';

            if StrLen(ObjLoans."Staff No") = 10 then begin
                PTEN := CopyStr(ObjLoans."Staff No", 10);
            end else
                if StrLen(ObjLoans."Staff No") = 9 then begin
                    PTEN := CopyStr(ObjLoans."Staff No", 9);
                end else
                    if StrLen(ObjLoans."Staff No") = 8 then begin
                        PTEN := CopyStr(ObjLoans."Staff No", 8);
                    end else
                        if StrLen(ObjLoans."Staff No") = 7 then begin
                            PTEN := CopyStr(ObjLoans."Staff No", 7);
                        end else
                            if StrLen(ObjLoans."Staff No") = 6 then begin
                                PTEN := CopyStr(ObjLoans."Staff No", 6);
                            end else
                                if StrLen(ObjLoans."Staff No") = 5 then begin
                                    PTEN := CopyStr(ObjLoans."Staff No", 5);
                                end else
                                    if StrLen(ObjLoans."Staff No") = 4 then begin
                                        PTEN := CopyStr(ObjLoans."Staff No", 4);
                                    end else
                                        if StrLen(ObjLoans."Staff No") = 3 then begin
                                            PTEN := CopyStr(ObjLoans."Staff No", 3);
                                        end else
                                            if StrLen(ObjLoans."Staff No") = 2 then begin
                                                PTEN := CopyStr(ObjLoans."Staff No", 2);
                                            end else
                                                if StrLen(ObjLoans."Staff No") = 1 then begin
                                                    PTEN := CopyStr(ObjLoans."Staff No", 1);
                                                end;

            //IF LoanTypes.GET(ObjLoans."Loan Product Type") THEN BEGIN
            //IF Customer.GET(ObjLoans."Client Code") THEN BEGIN
            //Loans."Staff No":=customer."Payroll/Staff No";
            DataSheet.Init;
            DataSheet."PF/Staff No" := ObjLoans."Staff No";
            DataSheet."Type of Deduction" := ObjLoans."Loan Product Type";
            DataSheet."Remark/LoanNO" := ObjLoans."Loan  No.";
            DataSheet.Name := ObjLoans."Client Name";
            DataSheet."ID NO." := ObjLoans."ID NO";
            DataSheet."Principal Amount" := ObjLoans."Loan Principle Repayment";
            DataSheet."Interest Amount" := ObjLoans."Loan Interest Repayment";
            DataSheet."Amount OFF" := ROUND(ObjLoans.Repayment, 5, '>');
            DataSheet."REF." := '2026';
            DataSheet."Batch No." := "No.";
            DataSheet."New Balance" := 0;
            DataSheet."Repayment Method" := ObjLoans."Repayment Method";
            DataSheet."Transaction Type" := DataSheet."transaction type"::ADJUSTMENT;
            DataSheet.Date := "Closing Date";
            if Customer.Get(ObjLoans."Client Code") then begin
                DataSheet.Employer := Customer."Employer Code";
            end;
            DataSheet."Sort Code" := PTEN;
            DataSheet.Insert;
        end;
    end;

    local procedure FnTransferToBank(TotalTransferredAmount: Decimal)
    begin
        LineNo := LineNo + 10000;
        SurestepFactory.FnCreateGnlJournalLine(TemplateName, BatchName, Doc_No, LineNo, GenJournalLine."transaction type"::" ",
                   GenJournalLine."account type"::Vendor, "FOSA Account No.", "Posting Date", TotalTransferredAmount * -1, DActivity, "No.", 'Account Closure(With): ' + "No.", '');

    end;
}

