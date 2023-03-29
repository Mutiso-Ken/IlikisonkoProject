#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516396 "Loan Disburesment Batch Card"
{
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Loan Disburesment-Batching";
    SourceTableView = where(Posted = const(false));

    layout
    {
        area(content)
        {
            field("Batch No."; "Batch No.")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field(Source; Source)
            {
                ApplicationArea = Basic;
                Editable = SourceEditable;
            }
            field("Batch Type"; "Batch Type")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field("Description/Remarks"; "Description/Remarks")
            {
                ApplicationArea = Basic;
                Editable = DescriptionEditable;
            }
            field(Status; Status)
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field("Total Loan Amount"; "Total Loan Amount")
            {
                ApplicationArea = Basic;
            }
            field("Mode Of Disbursement"; "Mode Of Disbursement")
            {
                ApplicationArea = Basic;
            }
            field("No of Loans"; "No of Loans")
            {
                ApplicationArea = Basic;
            }
            field("Document No."; "Document No.")
            {
                ApplicationArea = Basic;
                Editable = DocumentNoEditable;

                trigger OnValidate()
                begin
                    /*IF STRLEN("Document No.") > 6 THEN
                      ERROR('Document No. cannot contain More than 6 Characters.');
                      */

                end;
            }
            field("Posting Date"; "Posting Date")
            {
                ApplicationArea = Basic;
                Editable = PostingDateEditable;
            }
            field("BOSA Bank Account"; "BOSA Bank Account")
            {
                ApplicationArea = Basic;
                Caption = 'Paying Bank';
                Editable = PayingAccountEditable;
                Visible = false;
            }
            field("Cheque No."; LoansBatch."Cheque No.")
            {
                ApplicationArea = Basic;
                Editable = ChequeNoEditable;
            }
            part(LoansSubForm; "Loans Sub-Page List")
            {
                SubPageLink = "Batch No." = field("Batch No."),
                              "System Created" = const(false);
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(LoansB)
            {
                Caption = 'Batch';
                action("Loans Schedule")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loans Schedule';
                    Image = SuggestPayment;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin

                        if Posted = true then
                            Error('Batch already posted.');


                        LoansBatch.Reset;
                        LoansBatch.SetRange(LoansBatch."Batch No.", "Batch No.");
                        if LoansBatch.Find('-') then begin
                            if LoansBatch."Batch Type" = LoansBatch."batch type"::"Personal Loans" then
                                Report.Run(51516485, true, false, LoansBatch)
                            else
                                if LoansBatch."Batch Type" = LoansBatch."batch type"::"Branch Loans" then
                                    Report.Run(51516485, true, false, LoansBatch)
                                else
                                    if LoansBatch."Batch Type" = LoansBatch."batch type"::"Appeal Loans" then
                                        Report.Run(51516485, true, false, LoansBatch)
                                    else
                                        Report.Run(51516485, true, false, LoansBatch);
                        end;
                    end;
                }
                separator(Action1102760034)
                {
                }
                action("Member Card")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Card';
                    Image = Customer;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;

                    trigger OnAction()
                    begin

                        /*LoanApp.RESET;
                        LoanApp.SETRANGE(LoanApp."Loan  No.",CurrPage.LoansSubForm);
                        IF LoanApp.FIND('-') THEN BEGIN*/

                        /*Cust.RESET;
                        Cust.SETRANGE(Cust."No.",LoanApp."Client Code");
                        IF Cust.FIND('-') THEN
                        PAGE.RUNMODAL(,Cust);*/
                        //END;

                    end;
                }
                action("Loan Application")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Application Card';
                    Image = Loaners;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        /*
                        LoanApp.RESET;
                        //LoanApp.SETRANGE(LoanApp."Loan  No.",CurrPage.LoansSubForm.PAGE.GetLoanNo);
                        IF LoanApp.FIND('-') THEN
                        PAGE.RUNMODAL(,LoanApp);
                        */

                    end;
                }
                action("Loan Appraisal")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Appraisal';
                    Image = Statistics;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        /*
                        LoanApp.RESET;
                        //LoanApp.SETRANGE(LoanApp."Loan  No.",CurrPage.LoansSubForm.PAGE.GetLoanNo);
                        IF LoanApp.FIND('-') THEN BEGIN
                        IF COPYSTR(LoanApp."Loan Product Type",1,2) = 'PL' THEN
                        REPORT.RUN(,TRUE,FALSE,LoanApp)
                        ELSE
                        REPORT.RUN(,TRUE,FALSE,LoanApp);
                        END;
                        */

                    end;
                }
                separator(Action1102760045)
                {
                }
                action(Approvals)
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
                        DocumentType := Documenttype::"Loan Batches";
                        ApprovalEntries.Setfilters(Database::"Loan Disburesment-Batching", DocumentType, "Batch No.");
                        ApprovalEntries.Run;
                    end;
                }
                action("Send A&pproval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        Text001: label 'This Batch is already pending approval';
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        LoanApps.Reset;
                        LoanApps.SetRange(LoanApps."Batch No.", "Batch No.");
                        if LoanApps.Find('-') = false then
                            Error('You cannot send an empty batch for approval');
                        TestField("Description/Remarks");
                        if Status <> Status::Open then
                            Error(Text001);

                        //End allocate batch number
                        Doc_Type := Doc_type::LoanDisbursement;
                        Table_id := Database::"Loan Disburesment-Batching";
                        //IF ApprovalMgt.SendApproval(Table_id,"Batch No.",Doc_Type,Status)THEN;

                        if ApprovalsMgmt.CheckLoanDisbursementApprovalsWorkflowEnabled(Rec) then
                            ApprovalsMgmt.OnSendLoanDisbursementForApproval(Rec);


                        //TESTFIELD("Document No.");
                        //TESTFIELD("Posting Date");
                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        //  ApprovalMgt.OnCancelMWithdrawalApprovalRequest(Rec);
                    end;
                }
                action("Cancel Cheque")
                {
                    ApplicationArea = Basic;

                    trigger OnAction()
                    begin
                        Status := Status::Open;
                    end;
                }
                action(Post)
                {
                    ApplicationArea = Basic;
                    Caption = 'Post';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        Text001: label 'The Batch need to be approved.';
                    begin
                        if Posted = true then
                            Error('Batch already posted.');
                        // IF Status<>Status::Approved THEN
                        // ERROR(FORMAT(Text001));
                        CalcFields(Location);
                        if Confirm('Are you sure you want to post this batch?', true) = false then
                            exit;
                        TestField("Description/Remarks");
                        TestField("Posting Date");
                        TestField("Document No.");
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
                        GenJournalLine.SetRange("Journal Batch Name", 'LOANS');
                        GenJournalLine.DeleteAll;
                        GenSetUp.Get();

                        //*******************************Disbursement Loan through various Methods********************

                        case "Mode Of Disbursement" of
                            "mode of disbursement"::"Transfer to FOSA":
                                FnDisburseToCurrentAccount();
                            "mode of disbursement"::Cheque:
                                FnDisburseThroughCheque();
                        end;



                        // //Post New
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
                        GenJournalLine.SetRange("Journal Batch Name", 'LOANS');
                        if GenJournalLine.Find('-') then begin
                            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                        end;

                        /*//Post Interest
                        GenJournalLine.RESET;
                        GenJournalLine.SETRANGE("Journal Template Name",'General');
                        GenJournalLine.SETRANGE("Journal Batch Name",'INT DUE');
                        IF GenJournalLine.FIND('-') THEN BEGIN
                        CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Sacco",GenJournalLine);
                        END;
                        */
                        //SteveM
                        LoanApps.Posted := true;
                        LoanApps."Disbursed By" := UserId;
                        LoanApps.Modify;
                        Posted := true;
                        Modify;

                        Message('Batch posted successfully.');

                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControl();
    end;

    trigger OnInit()
    begin
        "Mode Of Disbursement" := "mode of disbursement"::"Transfer to FOSA";
    end;

    trigger OnOpenPage()
    begin
        "Mode Of Disbursement" := "mode of disbursement"::"Transfer to FOSA";
    end;

    var
        Text001: label 'Status must be open';
        MovementTracker: Record "File Movement Tracker";
        Member: Text;
        LoanApp1: Record "Loans Register";
        LoanG1: Record "Loans Guarantee Details";
        FileMovementTracker: Record "File Movement Tracker";
        NextStage: Integer;
        EntryNo: Integer;
        NextLocation: Text[100];
        LoansBatch: Record "Loan Disburesment-Batching";
        i: Integer;
        LoanType: Record "Loan Products Setup";
        PeriodDueDate: Date;
        ScheduleRep: Record "Loan Repayment Schedule";
        RunningDate: Date;
        G: Integer;
        IssuedDate: Date;
        GracePeiodEndDate: Date;
        InstalmentEnddate: Date;
        GracePerodDays: Integer;
        InstalmentDays: Integer;
        NoOfGracePeriod: Integer;
        NewSchedule: Record "Loan Repayment Schedule";
        RSchedule: Record "Loan Repayment Schedule";
        GP: Text[30];
        ScheduleCode: Code[20];
        PreviewShedule: Record "Loan Repayment Schedule";
        PeriodInterval: Code[10];
        CustomerRecord: Record "Member Register";
        Gnljnline: Record "Gen. Journal Line";
        Jnlinepost: Codeunit "Gen. Jnl.-Post Line";
        CumInterest: Decimal;
        NewPrincipal: Decimal;
        PeriodPrRepayment: Decimal;
        GenBatch: Record "Gen. Journal Batch";
        LineNo: Integer;
        GnljnlineCopy: Record "Gen. Journal Line";
        NewLNApplicNo: Code[10];
        Cust: Record "Member Register";
        LoanApp: Record "Loans Register";
        TestAmt: Decimal;
        CustRec: Record "Member Register";
        CustPostingGroup: Record "Customer Posting Group";
        GenSetUp: Record "Sacco General Set-Up";
        PCharges: Record "Loan Product Charges";
        TCharges: Decimal;
        LAppCharges: Record "Loan Applicaton Charges";
        LoanAmount: Decimal;
        InterestRate: Decimal;
        RepayPeriod: Integer;
        LBalance: Decimal;
        RunDate: Date;
        InstalNo: Decimal;
        RepayInterval: DateFormula;
        TotalMRepay: Decimal;
        LInterest: Decimal;
        LPrincipal: Decimal;
        RepayCode: Code[40];
        GrPrinciple: Integer;
        GrInterest: Integer;
        QPrinciple: Decimal;
        QCounter: Integer;
        InPeriod: DateFormula;
        InitialInstal: Integer;
        InitialGraceInt: Integer;
        GenJournalLine: Record "Gen. Journal Line";
        FOSAComm: Decimal;
        BOSAComm: Decimal;
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        LoanTopUp: Record "Loan Offset Details";
        Vend: Record Vendor;
        BOSAInt: Decimal;
        TopUpComm: Decimal;
        DActivity: Code[20];
        DBranch: Code[20];
        UsersID: Record User;
        TotalTopupComm: Decimal;
        Notification2: Codeunit Mail;
        CustE: Record "Member Register";
        DocN: Text[50];
        DocM: Text[100];
        DNar: Text[250];
        DocF: Text[50];
        MailBody: Text[250];
        ccEmail: Text[250];
        LoanG: Record "Loans Guarantee Details";
        SpecialComm: Decimal;
        LoanApps: Record "Loans Register";
        Banks: Record "Bank Account";
        BatchTopUpAmount: Decimal;
        BatchTopUpComm: Decimal;
        TotalSpecialLoan: Decimal;
        SpecialLoanCl: Record "Loan Special Clearance";
        Loans2: Record "Loans Register";
        DActivityBOSA: Code[20];
        DBranchBOSA: Code[20];
        Refunds: Record "Loan Products Setup";
        TotalRefunds: Decimal;
        WithdrawalFee: Decimal;
        NetPayable: Decimal;
        NetRefund: Decimal;
        FWithdrawal: Decimal;
        OutstandingInt: Decimal;
        TSC: Decimal;
        LoanDisbAmount: Decimal;
        NegFee: Decimal;
        DValue: Record "Dimension Value";
        ChBank: Code[20];
        Trans: Record Transactions;
        TransactionCharges: Record "Transaction Charges";
        BChequeRegister: Record "Banker Cheque Register";
        OtherCommitments: Record "Other Commitements Clearance";
        BoostingComm: Decimal;
        BoostingCommTotal: Decimal;
        BridgedLoans: Record "Loan Special Clearance";
        InterestDue: Decimal;
        ContractualShares: Decimal;
        BridgingChanged: Boolean;
        BankersChqNo: Code[20];
        LastPayee: Text[100];
        RunningAmount: Decimal;
        BankersChqNo2: Code[20];
        BankersChqNo3: Code[20];
        EndMonth: Date;
        RemainingDays: Integer;
        PrincipalRepay: Decimal;
        InterestRepay: Decimal;
        TMonthDays: Integer;
        SMSMessage: Record "Loan Appraisal Salary Details";
        iEntryNo: Integer;
        Temp: Record Customer;
        Jtemplate: Code[30];
        JBatch: Code[30];
        LBatches: Record "Loan Disburesment-Batching";
        ApprovalMgt: Codeunit "Approvals Mgmt.";
        DocumentType: Option " ",Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Withdrawal","Membership Reg","Loan Batches","Payment Voucher","Petty Cash",Loan,Interbank,Checkoff,"Savings Product Opening","Standing Order",ChangeRequest,Custodial;
        DescriptionEditable: Boolean;
        ModeofDisburementEditable: Boolean;
        DocumentNoEditable: Boolean;
        PostingDateEditable: Boolean;
        SourceEditable: Boolean;
        PayingAccountEditable: Boolean;
        ChequeNoEditable: Boolean;
        ChequeNameEditable: Boolean;
        upfronts: Decimal;
        EmergencyInt: Decimal;
        Table_id: Integer;
        Doc_No: Code[20];
        Doc_Type: Option " ",Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None",JV,"Member Withdrawal","Membership Reg","Loan Batches","Payment Voucher","Petty Cash",Loan,Interbank,Checkoff,"Savings Product Opening","Standing Order",LoanDisbursement;
        Deductions: Decimal;
        BatchBoostingCom: Decimal;
        HisaRepayment: Decimal;
        HisaLoan: Record "Loans Register";
        BatchHisaRepayment: Decimal;
        BatchFosaHisaComm: Decimal;
        BatchHisaShareBoostComm: Decimal;
        BatchShareCap: Decimal;
        BatchIntinArr: Decimal;
        Loaninsurance: Decimal;
        TLoaninsurance: Decimal;
        ProductCharges: Record "Loan Product Charges";
        InsuranceAcc: Code[20];
        PTEN: Code[20];
        LoanTypes: Record "Loan Products Setup";
        Customer: Record "Member Register";
        DataSheet: Record "Data Sheet Main";
        SMSAcc: Code[10];
        SMSFee: Decimal;
        LoanProcessingFee: Decimal;
        LoanProcessingFeeAcc: Code[20];
        ExciseDuty: Decimal;
        UserSetup: Record User;
        SURESTEPFactory: Date;
        LoanCharge: Decimal;
        LoanChargeAcc: Code[20];
        SMSMessages: Record "SMS Messages";
        ExtLoanCharges: Decimal;
        ExternalAmounts: Decimal;
        compinfo: Record "Company Information";
        SFactory: Codeunit "SURESTEP Factory";
        GenBatches: Record "Gen. Journal Batch";
        TranDescription: Text[120];


    procedure UpdateControl()
    begin
        if Status = Status::Open then begin
            DescriptionEditable := true;
            ModeofDisburementEditable := false;
            DocumentNoEditable := false;
            PostingDateEditable := false;
            SourceEditable := true;
            PayingAccountEditable := true;
            ChequeNoEditable := false;
            ChequeNameEditable := false;
        end;

        if Status = Status::"Pending Approval" then begin
            DescriptionEditable := false;
            ModeofDisburementEditable := false;
            DocumentNoEditable := false;
            PostingDateEditable := false;
            SourceEditable := false;
            PayingAccountEditable := false;
            ChequeNoEditable := false;
            ChequeNameEditable := false;

        end;

        if Status = Status::Rejected then begin
            DescriptionEditable := false;
            ModeofDisburementEditable := false;
            DocumentNoEditable := false;
            PostingDateEditable := false;
            SourceEditable := false;
            PayingAccountEditable := false;
            ChequeNoEditable := false;
            ChequeNameEditable := false;
        end;

        if Status = Status::Approved then begin
            DescriptionEditable := false;
            ModeofDisburementEditable := true;
            DocumentNoEditable := true;
            SourceEditable := false;
            PostingDateEditable := false;
            PayingAccountEditable := true;//FALSE;
            ChequeNoEditable := true;
            ChequeNameEditable := true;

        end;
    end;


    procedure FnSendDisburesmentSMS(LoanNo: Code[20]; AccountNo: Code[20])
    begin

        GenSetUp.Get;
        compinfo.Get;



        //SMS MESSAGE
        SMSMessages.Reset;
        if SMSMessages.Find('+') then begin
            iEntryNo := SMSMessages."Entry No";
            iEntryNo := iEntryNo + 1;
        end
        else begin
            iEntryNo := 1;
        end;


        SMSMessages.Init;
        SMSMessages."Entry No" := iEntryNo;
        SMSMessages."Batch No" := "Batch No.";
        SMSMessages."Document No" := LoanNo;
        SMSMessages."Account No" := AccountNo;
        SMSMessages."Date Entered" := Today;
        SMSMessages."Time Entered" := Time;
        SMSMessages.Source := 'BATCH';
        SMSMessages."Entered By" := UserId;
        SMSMessages."Sent To Server" := SMSMessages."sent to server"::No;
        SMSMessages."SMS Message" := 'Dear Mr./Mrs./M/s ' + Cust.Name + ',Your Loan has been Approved. Visit the office to sign loan agreement to process it. Thanks.'
        + compinfo.Name + ' ' + GenSetUp."Customer Care No";
        Cust.Reset;
        Cust.SetRange(Cust."No.", AccountNo);
        if Cust.Find('-') then begin
            SMSMessages."Telephone No" := Cust."Mobile Phone No";
        end;
        if Cust."Mobile Phone No" <> '' then
            SMSMessages.Insert;
    end;

    local procedure FnSendDisburesmentEmail(LoanNo: Code[20])
    var
        LoanRec: Record "Loans Register";
        SMTPMail: Codeunit UnknownCodeunit400;
        SMTPSetup: Record "SMTP Mail Setup";
        FileName: Text[100];
        Attachment: Text[250];
        CompanyInfo: Record "Company Information";
        Email: Text[30];
    begin
        // SMTPSetup.GET();
        //
        //  LoanRec.RESET;
        //   LoanRec.SETRANGE(LoanRec."Loan  No.",LoanNo);
        //    IF LoanRec.FIND('-') THEN
        //      BEGIN
        //        IF Cust.GET(LoanRec."Client Code") THEN BEGIN
        //          Email:=Cust."E-Mail (Personal)";
        //          END;
        //        IF Email='' THEN
        //          BEGIN
        //            ERROR ('Email Address Missing for Loan Application number' +'-'+ LoanRec."Loan  No.");
        //          END;
        //        IF Email<>'' THEN
        //          SMTPMail.CreateMessage(SMTPSetup."Email Sender Name",SMTPSetup."Email Sender Address",Email,'Loan Disburesment','',TRUE);
        //          SMTPMail.AppendBody(STRSUBSTNO(DisburesmentMessage,LoanRec."Client Name",LoanRec."Loan Product Type Name",USERID));
        //          SMTPMail.AppendBody(SMTPSetup."Email Sender Name");
        //          SMTPMail.AppendBody('<br><br>');
        //          SMTPMail.AddAttachment(FileName,Attachment);
        //          SMTPMail.Send;
        //      END;
    end;

    local procedure FnDisburseToCurrentAccount()
    var
        LoanCharge: Decimal;
        LoanChargeAcc: Code[30];
        ExciseDuty: Decimal;
    begin
        LoanApps.Reset;
        LoanApps.SetRange(LoanApps."Batch No.", "Batch No.");
        LoanApps.SetRange(LoanApps."System Created", false);
        if LoanApps.Find('-') then begin
            repeat
                if (LoanApps."Approved Amount" <= 0) then
                    Error('Loan No %1 should have an Approved Amount value', LoanApps."Loan  No.");

                LoanApps."Issued Date" := Today;
                LoanApps.Posted := true;
                LoanApps."Loan Status" := LoanApps."loan status"::Issued;
                LoanApps.Modify;
                LoanApps.CalcFields(LoanApps."Top Up Amount", LoanApps."Topup iNTEREST");
                TCharges := 0;
                TopUpComm := 0;
                TotalTopupComm := 0;

                Vend.Reset;
                Vend.SetRange(Vend."No.", LoanApps."Account No");

                if LoanApps."Top Up Amount" > 0 then begin
                    LoanTopUp.Reset;
                    LoanTopUp.SetRange(LoanTopUp."Loan No.", LoanApps."Loan  No.");
                    if LoanTopUp.Find('-') then begin
                        repeat

                            //Principle

                            GenJournalLine.Init;
                            LineNo := LineNo + 10000;
                            GenJournalLine."Journal Template Name" := 'PAYMENTS';
                            GenJournalLine."Journal Batch Name" := 'LOANS';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Document No." := "Document No.";
                            GenJournalLine."Posting Date" := "Posting Date";
                            GenJournalLine."External Document No." := LoanApps."Loan  No.";
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                            GenJournalLine."Account No." := LoanApps."Account No";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine.Description := 'Off Set By - ' + LoanApps."Loan  No.";
                            GenJournalLine.Amount := LoanTopUp."Principle Top Up";
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Loan No" := LoanTopUp."Loan Top Up";
                            GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                            GenJournalLine."Shortcut Dimension 2 Code" := SFactory.FnGetUserBranch();
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;

                            GenJournalLine.Init;
                            LineNo := LineNo + 10000;
                            GenJournalLine."Journal Template Name" := 'PAYMENTS';
                            GenJournalLine."Journal Batch Name" := 'LOANS';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Document No." := "Document No.";
                            GenJournalLine."Posting Date" := "Posting Date";
                            GenJournalLine."External Document No." := LoanApps."Loan  No.";
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                            GenJournalLine."Account No." := LoanApps."Client Code";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine.Description := 'Off Set By - ' + LoanApps."Loan  No.";
                            GenJournalLine.Amount := LoanTopUp."Principle Top Up" * -1;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Loan Repayment";
                            GenJournalLine."Loan No" := LoanTopUp."Loan Top Up";
                            GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                            GenJournalLine."Shortcut Dimension 2 Code" := SFactory.FnGetUserBranch();
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;

                            //Pay Outstanding Interest on TopUp----------------------------------
                            GenJournalLine.Init;
                            LineNo := LineNo + 10000;
                            if LoanType.Get(LoanApps."Loan Product Type") then begin
                                GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                GenJournalLine."Journal Batch Name" := 'LOANS';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No." := LoanApps."Account No";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Document No." := "Document No.";
                                GenJournalLine."Posting Date" := "Posting Date";
                                GenJournalLine.Description := 'Interest Due Paid on top up ' + LoanApps."Loan Product Type Name";
                                GenJournalLine.Amount := LoanTopUp."Interest Top Up";
                                GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Loan No" := LoanTopUp."Loan Top Up";
                                GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                                GenJournalLine."Shortcut Dimension 2 Code" := SFactory.FnGetUserBranch();
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;
                            end;

                            GenJournalLine.Init;
                            LineNo := LineNo + 10000;
                            if LoanType.Get(LoanApps."Loan Product Type") then begin
                                GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                GenJournalLine."Journal Batch Name" := 'LOANS';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                                GenJournalLine."Account No." := LoanApps."Client Code";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Document No." := "Document No.";
                                GenJournalLine."Posting Date" := "Posting Date";
                                GenJournalLine.Description := 'Interest Due Paid on top up ' + LoanApps."Loan Product Type Name";
                                GenJournalLine.Amount := -LoanTopUp."Interest Top Up";
                                GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                                GenJournalLine."Loan No" := LoanTopUp."Loan Top Up";
                                GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                GenJournalLine."Shortcut Dimension 2 Code" := SFactory.FnGetUserBranch();
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;
                            end;
                            //End Pay Outstanding Interest on TopUp----------------------------------

                            //Comission On TopUp-------------------------------------------------------
                            if LoanType.Get(LoanApps."Loan Product Type") then begin
                                GenJournalLine.Init;
                                LineNo := LineNo + 10000;
                                if LoanTopUp.Commision > 0 then begin
                                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                    GenJournalLine."Journal Batch Name" := 'LOANS';
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                                    GenJournalLine."Account No." := LoanApps."Account No";
                                    GenJournalLine."Document No." := "Document No.";
                                    GenJournalLine."Posting Date" := "Posting Date";
                                    GenJournalLine.Description := 'Interest on TopUp';
                                    TopUpComm := LoanTopUp.Commision;
                                    TotalTopupComm := TotalTopupComm + TopUpComm;
                                    GenJournalLine.Amount := TopUpComm;
                                    GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                    GenJournalLine."Bal. Account No." := LoanType."Loan Interest Account";
                                    //GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
                                    GenJournalLine."Shortcut Dimension 2 Code" := SFactory.FnGetUserBranch();
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;
                                end;
                            end;
                        //End topup commission-------------------------------------------------------
                        until LoanTopUp.Next = 0;
                    end;
                end;

                //Post Loan(Debit Member Loan Account)---------------------------------------------
                GenJournalLine.Init;
                LineNo := LineNo + 10000;
                GenJournalLine."Journal Template Name" := 'PAYMENTS';
                GenJournalLine."Journal Batch Name" := 'LOANS';
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                GenJournalLine."Account No." := LoanApps."Client Code";
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Loan;
                GenJournalLine."Loan No" := LoanApps."Loan  No.";
                GenJournalLine."Document No." := "Document No.";
                GenJournalLine."Posting Date" := "Posting Date";
                GenJournalLine.Description := 'Loan Principle';
                GenJournalLine.Amount := LoanApps."Approved Amount";
                GenJournalLine."External Document No." := LoanApps."Loan  No.";
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                GenJournalLine."Shortcut Dimension 2 Code" := SFactory.FnGetUserBranch();
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;
                //End Post Loan(Debit Member Loan Account)---------------------------------------------

                //Post Loan(Credit Member Fosa Account)------------------------------------------------
                GenJournalLine.Init;
                LineNo := LineNo + 10000;
                GenJournalLine."Journal Template Name" := 'PAYMENTS';
                GenJournalLine."Journal Batch Name" := 'LOANS';
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Document No." := "Document No.";
                GenJournalLine."Posting Date" := "Posting Date";
                GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                GenJournalLine."Account No." := LoanApps."Account No";
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine.Description := 'Loan Issued-' + LoanApps."Loan Product Type Name";
                GenJournalLine.Amount := (LoanApps."Approved Amount") * -1;
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                GenJournalLine."Shortcut Dimension 2 Code" := SFactory.FnGetUserBranch();
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;
                //End Post Loan(Credit Member Fosa Account)------------------------------------------------


                //Product Charges--------------------------------
                ProductCharges.Reset;
                ProductCharges.SetRange(ProductCharges."Product Code", LoanApps."Loan Product Type");
                //ProductCharges.SETRANGE(ProductCharges."Member Account",FALSE);
                if ProductCharges.Find('-') then begin
                    repeat

                        //  IF ProductCharges."Use Perc"=TRUE THEN BEGIN
                        //  LoanCharge:=LoanApps."Approved Amount" *(ProductCharges.Percentage/100);
                        //  LoanChargeAcc:=ProductCharges."G/L Account";
                        //  END ELSE
                        //  LoanCharge:=ProductCharges.Amount;

                        GenSetUp.Get();

                        LoanChargeAcc := ProductCharges."G/L Account";
                        if ProductCharges.Code = 'LIF' then
                            LoanCharge := LoanApps.Insurance;
                        if ProductCharges.Code = 'LAF' then
                            LoanCharge := LoanApps."Loan Appraisal Fee";
                        if ProductCharges.Code = 'LPF' then
                            LoanCharge := LoanApps."Loan Processing Fee";

                        LineNo := LineNo + 10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'PAYMENTS';
                        GenJournalLine."Journal Batch Name" := 'LOANS';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Document No." := "Document No.";
                        ;
                        GenJournalLine."Posting Date" := "Posting Date";
                        GenJournalLine."External Document No." := LoanApps."Loan  No.";
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No." := LoanApps."Account No";
                        GenJournalLine."Bal. Account Type" := GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Bal. Account No." := LoanChargeAcc;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine.Description := ProductCharges.Description + '-' + LoanApps."Loan  No.";
                        GenJournalLine.Amount := LoanCharge;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Loan No" := LoanApps."Loan  No.";
                        GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                        GenJournalLine."Shortcut Dimension 2 Code" := SFactory.FnGetUserBranch();
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;
                    until ProductCharges.Next = 0;
                end;

                LoanProcessingFee := 0;
                //ExciseDuty:=0;
                //steveM

                if "Mode Of Disbursement" = "mode of disbursement"::"Transfer to FOSA" then begin
                    LoanApps."Net Payment to FOSA" := LoanApps."Approved Amount";
                    LoanApps."Last Interest Due Date" := "Posting Date";
                    LoanApps."Processed Payment" := false;
                    Modify
                end;
                LoanApps."Issued Date" := Today;
                LoanApps.Modify;

                //Send Message
                Cust.Reset;
                Cust.SetRange(Cust."No.", LoanApps."Client Code");
                if Cust.Find('-') then

                    //MESSAGE(FORMAT(Cust.Name));
                    SMSMessages.Reset;
                if SMSMessages.Find('+') then begin
                    iEntryNo := SMSMessages."Entry No";
                    iEntryNo := iEntryNo + 1;
                end
                else begin
                    iEntryNo := 1;
                end;

                SMSMessages.Reset;
                SMSMessages.Init;
                SMSMessages."Entry No" := iEntryNo;
                SMSMessages."Account No" := LoanApps."Client Code";
                SMSMessages."Date Entered" := Today;
                SMSMessages."Time Entered" := Time;
                SMSMessages.Source := 'LOAN POSTED';
                SMSMessages."Entered By" := UserId;
                SMSMessages."Sent To Server" := SMSMessages."sent to server"::No;
                SMSMessages."SMS Message" := 'Dear Mr. /Mrs. /M/s  ' + Format(Cust.Name) +
                                          ' your loan application has been approved. Visit the office to sign loan agreement to process it. Thanks';


                Cust.Reset;
                if Cust.Get(LoanApps."Client Code") then
                    SMSMessages."Telephone No" := Cust."Mobile Phone No"
                else
                    SMSMessages."Telephone No" := Cust."Phone No.";

                SMSMessages.Insert;

                //**************************loan guarantee sms******************
                /*
                LoanG1.RESET;
                LoanG1.SETRANGE(LoanG1."Loan No",LoanApps."Loan  No.");
                IF LoanG1.FIND('-') THEN BEGIN
                  LoanG1.CALCFIELDS(LoanG1."Loanees  Name");

                   Member:=LoanG1."Loanees  Name";

                  REPEAT

                    Cust.RESET;
                    Cust.SETRANGE(Cust."No.",LoanG1."Member No");

                    IF Cust.FIND('-') THEN
                      LoanG1.CALCFIELDS(LoanG1."Loanees  Name");
                //       MESSAGE('african soil');
                //       MESSAGE(FORMAT(LoanG1."Loanees  Name"));
                      //Send Message
                      SMSMessages.RESET;
                      IF SMSMessages.FIND('+') THEN BEGIN
                      iEntryNo:=SMSMessages."Entry No";
                      iEntryNo:=iEntryNo+1;
                      END
                      ELSE BEGIN
                      iEntryNo:=1;
                      END;

                      SMSMessages.RESET;
                      SMSMessages.INIT;
                      SMSMessages."Entry No":=iEntryNo;
                      SMSMessages."Account No":=LoanApps."Client Code";
                      SMSMessages."Date Entered":=TODAY;
                      SMSMessages."Time Entered":=TIME;
                      SMSMessages.Source:='LOAN POSTED';
                      SMSMessages."Entered By":=USERID;
                      SMSMessages."Sent To Server":=SMSMessages."Sent To Server"::No;
                //      SMSMessages."SMS Message":='Your loan of KSHs.'+FORMAT(LoanApps."Approved Amount")+
                //                                ' has been disbursed to your account.' +FORMAT(LoanApps."Account No")+ 'Ilkisonko Ltd.';
                      SMSMessages."SMS Message":='The loan you guaranteed for Mr/Mrs/M/s '+FORMAT( LoanG1."Loanees  Name")+
                                                ' has been approved. Keep an eye on its repayment to avoid inconveniences as a result. Thanks.';

                //The loan you guaranteed for Mr/Mrs/M/s have been approved. Keep an eye on its repayment to avoid inconveniences as a result. Thanks.

                      Cust.RESET;
                      IF Cust.GET(LoanG1."Member No") THEN
                      SMSMessages."Telephone No":=Cust."Mobile Phone No"
                      ELSE
                      SMSMessages."Telephone No":=Cust."Phone No.";

                      SMSMessages.INSERT;
                    UNTIL LoanG1.NEXT = 0;
                  END;*/
                //END;
                //Loan Bridged and Comissions----------------------------------------------------
                //Generate Data Sheet Advice
                PTEN := '';

                if StrLen(LoanApps."Staff No") = 10 then begin
                    PTEN := CopyStr(LoanApps."Staff No", 10);
                end else
                    if StrLen(LoanApps."Staff No") = 9 then begin
                        PTEN := CopyStr(LoanApps."Staff No", 9);
                    end else
                        if StrLen(LoanApps."Staff No") = 8 then begin
                            PTEN := CopyStr(LoanApps."Staff No", 8);
                        end else
                            if StrLen(LoanApps."Staff No") = 7 then begin
                                PTEN := CopyStr(LoanApps."Staff No", 7);
                            end else
                                if StrLen(LoanApps."Staff No") = 6 then begin
                                    PTEN := CopyStr(LoanApps."Staff No", 6);
                                end else
                                    if StrLen(LoanApps."Staff No") = 5 then begin
                                        PTEN := CopyStr(LoanApps."Staff No", 5);
                                    end else
                                        if StrLen(LoanApps."Staff No") = 4 then begin
                                            PTEN := CopyStr(LoanApps."Staff No", 4);
                                        end else
                                            if StrLen(LoanApps."Staff No") = 3 then begin
                                                PTEN := CopyStr(LoanApps."Staff No", 3);
                                            end else
                                                if StrLen(LoanApps."Staff No") = 2 then begin
                                                    PTEN := CopyStr(LoanApps."Staff No", 2);
                                                end else
                                                    if StrLen(LoanApps."Staff No") = 1 then begin
                                                        PTEN := CopyStr(LoanApps."Staff No", 1);
                                                    end;


                if LoanTypes.Get(LoanApps."Loan Product Type") then begin
                    if Customer.Get(LoanApps."Client Code") then begin

                        DataSheet.Reset;
                        DataSheet.SetRange(DataSheet."Remark/LoanNO", LoanApps."Loan  No.");
                        if not DataSheet.Find('-') then begin
                            DataSheet.Init;
                            DataSheet."PF/Staff No" := LoanApps."Staff No";
                            DataSheet."Type of Deduction" := LoanApps."Loan Product Type";
                            DataSheet."Remark/LoanNO" := LoanApps."Loan  No.";
                            DataSheet.Name := LoanApps."Client Name";
                            DataSheet."ID NO." := LoanApps."ID NO";
                            DataSheet."Principal Amount" := LoanApps."Loan Principle Repayment";
                            DataSheet."Interest Amount" := LoanApps."Loan Interest Repayment";
                            DataSheet."Amount ON" := ROUND(LoanApps.Repayment, 5, '>');
                            //    IF Customer."Member class"=Customer."Member class"::"Class B" THEN
                            //      DataSheet."REF.":=LoanTypes."Casuals Special Code"
                            //    ELSE
                            //DataSheet."REF.":=LoanTypes."Special Code";
                            DataSheet."Batch No." := "Batch No.";
                            DataSheet."New Balance" := LoanApps."Approved Amount";
                            DataSheet."Repayment Method" := LoanApps."Repayment Method";
                            DataSheet.Date := LoanApps."Issued Date";
                            if Customer.Get(LoanApps."Client Code") then begin
                                DataSheet.Employer := Customer."Employer Code";
                            end;
                            DataSheet."Sort Code" := PTEN;
                            DataSheet.Insert;
                        end;
                    end;
                end;
                //***************************************
                LoanApps."Amount Disbursed" := LoanApps."Approved Amount";
                LoanApps.Modify;
            //***************************************
            until LoanApps.Next = 0;
        end;

    end;

    local procedure FnDisburseThroughCheque()
    var
        LoanChargeAcc: Code[30];
        LoanCharge: Decimal;
    begin
        LoanApps.Reset;
        LoanApps.SetRange(LoanApps."Batch No.", "Batch No.");
        LoanApps.SetFilter(LoanApps."Loan Status", '<>Rejected');
        if LoanApps.Find('-') then begin
            repeat
                LoanApps."Issued Date" := Today;
                LoanApps.Modify;
                LoanApps.CalcFields(LoanApps."Top Up Amount", LoanApps."Topup iNTEREST");
                TCharges := 0;
                TopUpComm := 0;
                TotalTopupComm := 0;
                if LoanApps."Top Up Amount" > 0 then begin
                    LoanTopUp.Reset;
                    LoanTopUp.SetRange(LoanTopUp."Loan No.", LoanApps."Loan  No.");
                    if LoanTopUp.Find('-') then begin
                        repeat
                            GenJournalLine.Init;
                            LineNo := LineNo + 10000;
                            //Principle
                            GenJournalLine."Journal Template Name" := 'PAYMENTS';
                            GenJournalLine."Journal Batch Name" := 'LOANS';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Document No." := "Document No.";
                            GenJournalLine."Posting Date" := "Posting Date";
                            GenJournalLine."External Document No." := LoanApps."Loan  No.";
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                            GenJournalLine."Account No." := LoanApps."Client Code";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine.Description := 'Off Set By - ' + LoanApps."Loan  No.";
                            GenJournalLine.Amount := LoanTopUp."Principle Top Up" * -1;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Loan Repayment";
                            GenJournalLine."Loan No" := LoanTopUp."Loan Top Up";
                            GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                            GenJournalLine."Shortcut Dimension 2 Code" := SFactory.FnGetUserBranch();
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;


                            //Interest Due Paid-----------------------------------------------
                            GenJournalLine.Init;
                            LineNo := LineNo + 10000;
                            if LoanType.Get(LoanApps."Loan Product Type") then begin
                                GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                GenJournalLine."Journal Batch Name" := 'LOANS';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."bal. account type"::Member;
                                GenJournalLine."Account No." := LoanApps."Client Code";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Document No." := "Document No.";
                                GenJournalLine."Posting Date" := "Posting Date";
                                GenJournalLine.Description := 'Interest Due Paid on top up ' + LoanApps."Loan Product Type Name";
                                GenJournalLine.Amount := -LoanTopUp."Interest Top Up";
                                GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                                GenJournalLine."Loan No" := LoanTopUp."Loan Top Up";
                                GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                GenJournalLine."Shortcut Dimension 2 Code" := SFactory.FnGetUserBranch();
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;
                            end;
                            //End Interest Due Paid-----------------------------------------------

                            //Levy On TopUp-----------------------------------------------------
                            if LoanType.Get(LoanApps."Loan Product Type") then begin
                                GenJournalLine.Init;
                                LineNo := LineNo + 10000;
                                if LoanType."Top Up Commision" > 0 then begin
                                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                    GenJournalLine."Journal Batch Name" := 'LOANS';
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                    GenJournalLine."Account No." := LoanType."Top Up Commision Account";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Document No." := "Document No.";
                                    GenJournalLine."Posting Date" := "Posting Date";
                                    GenJournalLine.Description := 'Interest on Topup';
                                    TopUpComm := LoanTopUp.Commision;
                                    TotalTopupComm := TotalTopupComm + TopUpComm;
                                    GenJournalLine.Amount := TopUpComm * -1;
                                    GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                    GenJournalLine."Shortcut Dimension 2 Code" := SFactory.FnGetUserBranch();
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;
                                end;
                            end;
                            //End Levy On TopUp-----------------------------------------------------

                            //Generate Data Sheet Advice-Put Off top-ups
                            PTEN := '';

                            if StrLen(LoanTopUp."Staff No") = 10 then begin
                                PTEN := CopyStr(LoanTopUp."Staff No", 10);
                            end else
                                if StrLen(LoanTopUp."Staff No") = 9 then begin
                                    PTEN := CopyStr(LoanTopUp."Staff No", 9);
                                end else
                                    if StrLen(LoanTopUp."Staff No") = 8 then begin
                                        PTEN := CopyStr(LoanTopUp."Staff No", 8);
                                    end else
                                        if StrLen(LoanTopUp."Staff No") = 7 then begin
                                            PTEN := CopyStr(LoanTopUp."Staff No", 7);
                                        end else
                                            if StrLen(LoanTopUp."Staff No") = 6 then begin
                                                PTEN := CopyStr(LoanTopUp."Staff No", 6);
                                            end else
                                                if StrLen(LoanTopUp."Staff No") = 5 then begin
                                                    PTEN := CopyStr(LoanTopUp."Staff No", 5);
                                                end else
                                                    if StrLen(LoanTopUp."Staff No") = 4 then begin
                                                        PTEN := CopyStr(LoanTopUp."Staff No", 4);
                                                    end else
                                                        if StrLen(LoanTopUp."Staff No") = 3 then begin
                                                            PTEN := CopyStr(LoanTopUp."Staff No", 3);
                                                        end else
                                                            if StrLen(LoanTopUp."Staff No") = 2 then begin
                                                                PTEN := CopyStr(LoanTopUp."Staff No", 2);
                                                            end else
                                                                if StrLen(LoanTopUp."Staff No") = 1 then begin
                                                                    PTEN := CopyStr(LoanTopUp."Staff No", 1);
                                                                end;


                            if LoanTypes.Get(LoanTopUp."Loan Type") then begin
                                if Customer.Get(LoanTopUp."Client Code") then begin
                                    DataSheet.Init;
                                    DataSheet."PF/Staff No" := LoanTopUp."Staff No";
                                    DataSheet."Type of Deduction" := LoanTypes."Product Description";
                                    DataSheet."Remark/LoanNO" := LoanTopUp."Loan Top Up";
                                    DataSheet.Name := LoanApps."Client Name";
                                    DataSheet."ID NO." := LoanApps."ID NO";
                                    DataSheet."Amount ON" := 0;
                                    DataSheet."Amount OFF" := LoanTopUp."Monthly Repayment";
                                    //    IF Customer."Member class"=Customer."Member class"::Diamond THEN
                                    //      DataSheet."REF.":=LoanTypes."Casuals Special Code"
                                    //    ELSE
                                    //      DataSheet."REF.":=LoanTypes."Special Code";
                                    DataSheet."New Balance" := 0;
                                    DataSheet.Date := Today;
                                    DataSheet.Employer := Customer."Employer Code";
                                    DataSheet."Repayment Method" := Customer."Repayment Method";
                                    DataSheet."Transaction Type" := DataSheet."transaction type"::ADJUSTMENT;
                                    DataSheet."Sort Code" := PTEN;
                                    DataSheet.Insert;
                                end;
                            end;

                            BatchTopUpAmount := 0;
                            BatchTopUpComm := 0;
                            BatchTopUpAmount := BatchTopUpAmount + LoanApps."Top Up Amount" + LoanTopUp."Interest Top Up";
                            BatchTopUpComm := BatchTopUpComm + TotalTopupComm;
                        until LoanTopUp.Next = 0;
                    end;
                end;

                //Comission on Disburesment Via Cheque----------------------------------------------
                //  GenJournalLine.INIT;
                //  LineNo:=LineNo+10000;
                //  GenJournalLine."Journal Template Name":='PAYMENTS';
                //  GenJournalLine."Journal Batch Name":='LOANS';
                //  GenJournalLine."Line No.":=LineNo;
                //  GenJournalLine."Account Type":=GenJournalLine."Account Type"::"G/L Account";
                //  GenJournalLine."Account No.":=GenSetUp."Loan Trasfer Fee A/C-Cheque";
                //  GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                //  GenJournalLine."Document No.":="Document No.";
                //  GenJournalLine."Posting Date":="Posting Date";
                //  GenJournalLine.Description:='CHQ COMM';
                //  GenJournalLine.Amount:=GenSetUp."Loan Trasfer Fee-Cheque"*-1/100*LoanApps."Approved Amount";
                //  GenJournalLine."External Document No.":=LoanApps."Loan  No.";
                //  GenJournalLine.VALIDATE(GenJournalLine.Amount);
                //  GenJournalLine."Shortcut Dimension 1 Code":='BOSA';
                //  GenJournalLine."Shortcut Dimension 2 Code":=SFactory.FnGetUserBranch();
                //  GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                //  GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                //  IF GenJournalLine.Amount<>0 THEN
                //  GenJournalLine.INSERT;
                //End Comission on Disburesment Via Cheque----------------------------------------------

                //Disburesment Via Cheque(Debit Members Account)-------------------------
                GenJournalLine.Init;
                LineNo := LineNo + 10000;
                GenJournalLine."Journal Template Name" := 'PAYMENTS';
                GenJournalLine."Journal Batch Name" := 'LOANS';
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Document No." := "Document No.";
                GenJournalLine."Posting Date" := "Posting Date";
                GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                GenJournalLine."Account No." := LoanApps."Client Code";
                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Loan;
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine.Description := 'loans' + LoanApps."Client Name" + '-' + LoanApps."Client Code";
                GenJournalLine.Amount := LoanApps."Approved Amount";
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                GenJournalLine."Shortcut Dimension 2 Code" := SFactory.FnGetUserBranch();
                GenJournalLine."Loan No" := LoanApps."Loan  No.";
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;
                //End Disburesment Via Cheque(Debit Members Account)-------------------------

                //Product Charges--------------------------------
                ProductCharges.Reset;
                ProductCharges.SetRange(ProductCharges."Product Code", LoanApps."Loan Product Type");
                //ProductCharges.SETRANGE(ProductCharges."Member Account",FALSE);
                if ProductCharges.Find('-') then begin
                    repeat

                        //  IF ProductCharges."Use Perc"=TRUE THEN BEGIN
                        //  LoanCharge:=LoanApps."Approved Amount" *(ProductCharges.Percentage/100);
                        //  LoanChargeAcc:=ProductCharges."G/L Account";
                        //  END ELSE
                        //  LoanCharge:=ProductCharges.Amount;

                        LoanChargeAcc := ProductCharges."G/L Account";
                        if ProductCharges.Code = 'LIF' then
                            LoanCharge := LoanApps.Insurance;
                        if ProductCharges.Code = 'LAP' then
                            LoanCharge := LoanApps."Loan Appraisal Fee";
                        if ProductCharges.Code = 'LPF' then
                            LoanCharge := LoanApps."Loan Processing Fee";

                        LineNo := LineNo + 10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'PAYMENTS';
                        GenJournalLine."Journal Batch Name" := 'LOANS';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Document No." := "Document No.";
                        ;
                        GenJournalLine."Posting Date" := "Posting Date";
                        GenJournalLine."External Document No." := LoanApps."Loan  No.";
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No." := LoanApps."Account No";
                        GenJournalLine."Bal. Account Type" := GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Bal. Account No." := LoanChargeAcc;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine.Description := ProductCharges.Description + '-' + LoanApps."Loan  No.";
                        GenJournalLine.Amount := LoanCharge;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Loan No" := LoanApps."Loan  No.";
                        GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                        GenJournalLine."Shortcut Dimension 2 Code" := SFactory.FnGetUserBranch();
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;
                    until ProductCharges.Next = 0;
                end;

                //Disbursement Via Cheque(Credit Bank)-----------------------------------------------------
                GenJournalLine.Init;
                LineNo := LineNo + 10000;
                GenJournalLine."Journal Template Name" := 'PAYMENTS';
                GenJournalLine."Journal Batch Name" := 'LOANS';
                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Document No." := "Document No.";
                GenJournalLine."Posting Date" := "Posting Date";
                GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                GenJournalLine."Account No." := "BOSA Bank Account";
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine.Description := 'loans' + LoanApps."Client Name" + '-' + LoanApps."Client Code";
                LoanApps.CalcFields("Top Up Amount", "Topup Commission");
                if LoanApps."Top Up Amount" > 0 then begin
                    GenJournalLine.Amount := LoanApps."Approved Amount" * -1 + (LoanApps.Insurance + LoanApps."Loan Appraisal Fee" + LoanApps."Loan Processing Fee" + LoanApps."Top Up Amount" + LoanApps."Topup Commission");
                end else begin
                    GenJournalLine.Amount := LoanApps."Approved Amount" * -1 + (LoanApps.Insurance + LoanApps."Loan Appraisal Fee" + LoanApps."Loan Processing Fee");
                end;
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                GenJournalLine."Shortcut Dimension 2 Code" := SFactory.FnGetUserBranch();
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                if GenJournalLine.Amount <> 0 then
                    GenJournalLine.Insert;
                LoanApps."Issued Date" := Today;
                LoanApps."Last Interest Due Date" := "Posting Date";
                LoanApps.Modify;


                //***************************************
                LoanApps."Amount Disbursed" := LoanApps."Approved Amount";
                LoanApps.Modify;
                //***************************************

                //Send Message
                SMSMessages.Reset;
                if SMSMessages.Find('+') then begin
                    iEntryNo := SMSMessages."Entry No";
                    iEntryNo := iEntryNo + 1;
                end
                else begin
                    iEntryNo := 1;
                end;

                SMSMessages.Reset;
                SMSMessages.Init;
                SMSMessages."Entry No" := iEntryNo;
                SMSMessages."Account No" := LoanApps."Client Code";
                SMSMessages."Date Entered" := Today;
                SMSMessages."Time Entered" := Time;
                SMSMessages.Source := 'LOAN POSTED';
                SMSMessages."Entered By" := UserId;
                SMSMessages."Sent To Server" := SMSMessages."sent to server"::No;
                //      SMSMessages."SMS Message":='Your loan of KSHs.'+FORMAT(LoanApps."Approved Amount")+
                //                                ' has been disbursed to your account.' +FORMAT(LoanApps."Account No")+ 'Ilkisonko Ltd.';
                SMSMessages."SMS Message" := 'Dear Mr. /Mrs. /M/s' + Format(LoanApps."Client Name") +
                                          ' your loan application has been approved. Vist the office to sign loan agreement to process it. Thanks';


                Cust.Reset;
                if Cust.Get(LoanApps."Client Code") then
                    SMSMessages."Telephone No" := Cust."Mobile Phone No"
                else
                    SMSMessages."Telephone No" := Cust."Phone No.";

                SMSMessages.Insert;


                LoanG1.Reset;
                LoanG1.SetRange(LoanG1."Loan No", LoanApps."Loan  No.");
                if LoanG1.Find('-') then begin
                    Member := Format(LoanApps."Client Name");
                    repeat

                        Cust.Reset;
                        Cust.SetRange(Cust."No.", LoanG1."Member No");
                        if Cust.Find('-') then
                            //Send Message
                            SMSMessages.Reset;
                        if SMSMessages.Find('+') then begin
                            iEntryNo := SMSMessages."Entry No";
                            iEntryNo := iEntryNo + 1;
                        end
                        else begin
                            iEntryNo := 1;
                        end;

                        SMSMessages.Reset;
                        SMSMessages.Init;
                        SMSMessages."Entry No" := iEntryNo;
                        SMSMessages."Account No" := LoanApps."Client Code";
                        SMSMessages."Date Entered" := Today;
                        SMSMessages."Time Entered" := Time;
                        SMSMessages.Source := 'LOAN POSTED';
                        SMSMessages."Entered By" := UserId;
                        SMSMessages."Sent To Server" := SMSMessages."sent to server"::No;
                        //      SMSMessages."SMS Message":='Your loan of KSHs.'+FORMAT(LoanApps."Approved Amount")+
                        //                                ' has been disbursed to your account.' +FORMAT(LoanApps."Account No")+ 'Ilkisonko Ltd.';
                        SMSMessages."SMS Message" := 'The loan you guaranteed for Mr/Mrs/M/s ' + Member +
                                                  ' have been approved. Keep an eye on its repayment to avoid inconveniences as a result. Thanks.';

                        //The loan you guaranteed for Mr/Mrs/M/s have been approved. Keep an eye on its repayment to avoid inconveniences as a result. Thanks.

                        Cust.Reset;
                        if Cust.Get(LoanG1."Member No") then
                            SMSMessages."Telephone No" := Cust."Mobile Phone No"
                        else
                            SMSMessages."Telephone No" := Cust."Phone No.";

                        SMSMessages.Insert;
                    until LoanG1.Next = 0;
                end;
            //END;
            until LoanApps.Next = 0;
        end;
    end;
}

