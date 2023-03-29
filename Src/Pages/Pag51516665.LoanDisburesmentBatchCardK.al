#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516665 "Loan Disburesment Batch Card-K"
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
                Visible = false;
            }
            field("Description/Remarks"; "Description/Remarks")
            {
                ApplicationArea = Basic;
                Editable = DescriptionEditable;
            }
            field(Status; Status)
            {
                ApplicationArea = Basic;
                Editable = true;
            }
            field("Total Loan Amount"; "Total Loan Amount")
            {
                ApplicationArea = Basic;
            }
            field("No of Loans"; "No of Loans")
            {
                ApplicationArea = Basic;
            }
            field("Mode Of Disbursement"; "Mode Of Disbursement")
            {
                ApplicationArea = Basic;
                Visible = false;

                trigger OnValidate()
                begin
                    /*IF "Mode Of Disbursement"="Mode Of Disbursement"::EFT THEN
                    "Cheque No.":="Batch No.";
                    MODIFY;  */

                    if "Mode Of Disbursement" = "mode of disbursement"::Cheque then
                        ChequeNoVisible := true
                    else
                        ChequeNoEditable := false;

                end;
            }
            field("Document No."; "Document No.")
            {
                ApplicationArea = Basic;

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
            }
            field("BOSA Bank Account"; "BOSA Bank Account")
            {
                ApplicationArea = Basic;
                Caption = 'Paying Bank';
                Visible = false;
            }
            field("EFT Fee"; "EFT Fee")
            {
                ApplicationArea = Basic;
                Visible = false;
            }
            field("Amount to bank"; "Amount to bank")
            {
                ApplicationArea = Basic;
                Visible = false;
            }
            group(Control5)
            {
                Visible = ChequeNoVisible;
                field("Cheque No."; "Cheque No.")
                {
                    ApplicationArea = Basic;
                }
            }
            part(LoansSubForm; "Loans Sub-Page List")
            {
                SubPageLink = "Batch No." = field("Batch No."),
                              "System Created" = const(false);
            }
            part(Control2; "Loan Batch Lines")
            {
                SubPageLink = "Batch No." = field("Batch No.");
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
                action("Payment Voucher")
                {
                    ApplicationArea = Basic;
                    Caption = 'Payment Voucher';
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
                            LoansBatch.CalcFields(LoansBatch."No of Loans");
                            if LoansBatch."No of Loans" > 1 then
                                Report.Run(51516144, true, false, LoansBatch)
                            else
                                Report.Run(51516143, true, false, LoansBatch);
                        end;
                        "Payment Voucher Printed" := true;
                        Modify
                    end;
                }
                separator(Action1102760034)
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
                        DocumentType := Documenttype::LoanDisbursement;
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




                        //ApprovalMgt.SendBatchApprRequest(LBatches);
                    end;
                }
                action("Canel Approval Request")
                {
                    ApplicationArea = Basic;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        //IF ApprovalsMgmt.CheckLoanDisbursementApprovalsWorkflowEnabled(Rec) THEN
                        // ApprovalsMgmt.OnCancelLoanDisbursementApprovalRequest(Rec);
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
                        if Status <> Status::Approved then
                            Error(Format(Text001));
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
                            "mode of disbursement"::"2":
                                FnDisburseToCurrentAccount();
                            "mode of disbursement"::Cheque:
                                FnDisburseThroughCheque();
                        end;

                        //Post New
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
                        GenJournalLine.SetRange("Journal Batch Name", 'LOANS');
                        if GenJournalLine.Find('-') then begin
                            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                        end;
                        LoanApps.Posted := true;
                        LoanApps."Disbursed By" := UserId;
                        LoanApps.Modify;
                        Posted := true;
                        Modify;

                        Message('Batch posted successfully.');
                    end;
                }
                action("Re-Open Batch")
                {
                    ApplicationArea = Basic;
                    Image = ReopenPeriod;
                    Promoted = true;

                    trigger OnAction()
                    begin
                        if Confirm('Do you really want to re-open the batch?', true) = false then exit;
                        if UserSetup.Get(UserId) then begin
                            if UserSetup."Re-Open Batch" = false then
                                Error('You do not have permissions to re-open batch!');
                            Status := Status::Open;
                            Modify;

                            //END ELSE BEGIN
                            // ERROR('You have not been setup in the user setup table!');
                        end;
                        Message('Successfully opened');
                    end;
                }
                action("Close Batch")
                {
                    ApplicationArea = Basic;
                    Image = Close;
                    Promoted = true;

                    trigger OnAction()
                    begin
                        if Confirm('Do you really want to close the batch?', true) = false then exit;
                        if UserSetup.Get(UserId) then begin
                            if UserSetup."Re-Open Batch" = false then
                                Error('You do not have permissions to close batch!');
                            Status := Status::Approved;
                            Modify;

                        end else begin
                            Error('You have not been setup in the user setup table!');
                        end;
                        Message('Successfully  closed');
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateControl();
    end;

    trigger OnAfterGetRecord()
    begin
        if "Mode Of Disbursement" = "mode of disbursement"::Cheque then
            ChequeNoVisible := true
        else
            ChequeNoEditable := false;
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin

        if "Mode Of Disbursement" = "mode of disbursement"::Cheque then
            ChequeNoVisible := true
        else
            ChequeNoEditable := false;
    end;

    trigger OnOpenPage()
    begin
        ChequeNoVisible := false;
        if "Mode Of Disbursement" = "mode of disbursement"::Cheque then
            ChequeNoVisible := true
        else
            ChequeNoEditable := false;
    end;

    var
        Text001: label 'Status must be open';
        MovementTracker: Record "File Movement Tracker";
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
        TestAmt: Decimal;
        CustRec: Record "Member Register";
        CustPostingGroup: Record "Customer Posting Group";
        GenSetUp: Record "Sacco General Set-Up";
        PCharges: Record "Loan Product Charges";
        TCharges: Decimal;
        LAppCharges: Record "Loan Applicaton Charges";
        Loans: Record "Loans Register";
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
        SMSMessage: Record "SMS Messages";
        iEntryNo: Integer;
        Temp: Record Customer;
        Jtemplate: Code[30];
        JBatch: Code[30];
        LBatches: Record "Loan Disburesment-Batching";
        ApprovalMgt: Codeunit "Approvals Mgmt.";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal;
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
        Doc_Type: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal;
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
        UserSetup: Record "User Setup";
        LoanProcessingFee: Decimal;
        LoanProcessingFeeAcc: Code[20];
        InterestUpfrontSavers: Decimal;
        SaccoInterest: Decimal;
        SaccoInterestAccount: Code[20];
        SaccoIntRelief: Decimal;
        ArmotizationFactor: Decimal;
        compinfo: Record "Company Information";
        DisburesmentMessage: label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">Welcome to Biblia Sacco</p><p style="font-family:Verdana,Arial;font-size:9pt">This is to confirm that your Loan Application has been Approved and Posted to your Bank Account</p><p style="font-family:Verdana,Arial;font-size:9pt">Loan Product Type <b>%2</b></p><br>Regards<p>%3</p><p><b>BIBLIA SACCO LTD</b></p>';
        AccruedIntAcc: Code[20];
        AccruedInt: Decimal;
        TSCInterest: Decimal;
        TSCInterestAc: Code[20];
        IntCapitalized: Decimal;
        IntCapitalizedAcc: Code[20];
        LApplicationFee: Decimal;
        LApplicationFeeAcc: Code[20];
        IntCapitalizationFactor: Integer;
        OBJLinesJNL: Record "Mobile Loans";
        KNFactory: Codeunit "SURESTEP Factory";
        ObjLoanProductCharges: Record "Loan Product Charges";
        TotalProductCharges: Decimal;
        AmountToDisburse: Decimal;
        ProductChargesAmount: Decimal;
        ObjLoanBatching: Record "Loan Disburesment-Batching";
        ChequeNoVisible: Boolean;
        EFTFee: Decimal;
        DisbAmt: Decimal;
        LoanGuar: Record "Loans Guarantee Details";
        SFactory: Codeunit "SURESTEP Factory";
        FundsUserSetup: Record "Funds User Setup";
        WhichDay: Integer;
        SendEmail: Boolean;
        Filename: Text[100];
        SMTPSetup: Record "SMTP Mail Setup";
        SMTPMail: Codeunit UnknownCodeunit400;
        MembersReg: Record "Member Register";
        Attachment: Text[250];
        LnPP: Record "Loans Register";
        LoanDisBatchLines: Record "Loan Dis Batch Lines";
        PenaltyAccount: Code[30];
        SMSMessages: Record "SMS Messages";


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
            PostingDateEditable := true;
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
        SMSMessage."Batch No" := "Batch No.";
        SMSMessage."Document No" := LoanNo;
        SMSMessage."Account No" := AccountNo;
        SMSMessage."Date Entered" := Today;
        SMSMessage."Time Entered" := Time;
        SMSMessage.Source := 'BATCH';
        SMSMessage."Entered By" := UserId;
        SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
        SMSMessage."SMS Message" := 'Dear Member,Your Loan has been Approved and posted to your Bank Account,'
        + compinfo.Name + ' ' + GenSetUp."Customer Care No";
        Cust.Reset;
        Cust.SetRange(Cust."No.", AccountNo);
        if Cust.Find('-') then begin
            SMSMessage."Telephone No" := Cust."Mobile Phone No";
        end;
        if Cust."Mobile Phone No" <> '' then
            SMSMessage.Insert;
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
        SMTPSetup.Get();

        LoanRec.Reset;
        LoanRec.SetRange(LoanRec."Loan  No.", LoanNo);
        if LoanRec.Find('-') then begin
            if Cust.Get(LoanRec."Client Code") then begin
                Email := Cust."E-Mail (Personal)";
            end;
            if Email = '' then begin
                Error('Email Address Missing for Loan Application number' + '-' + LoanRec."Loan  No.");
            end;
            if Email <> '' then
                SMTPMail.CreateMessage(SMTPSetup."Email Sender Name", SMTPSetup."Email Sender Address", Email, 'Loan Disburesment', '', true);
            SMTPMail.AppendBody(StrSubstNo(DisburesmentMessage, LoanRec."Client Name", LoanRec."Loan Product Type Name", UserId));
            SMTPMail.AppendBody(SMTPSetup."Email Sender Name");
            SMTPMail.AppendBody('<br><br>');
            SMTPMail.AddAttachment(FileName, Attachment);
            SMTPMail.Send;
        end;
    end;

    local procedure FnCreateLines()
    begin

        Message('Lines Created successfully.');
    end;

    local procedure FnGenerateSchedule(LoanNo: Code[20])
    var
        NLInterest: Decimal;
        InterestVarianceOnlyNafaka: Decimal;
        LoansReg: Record "Loans Register";
        ScheduleBal: Decimal;
        LoansR: Record "Loans Register";
        LNBalance: Decimal;
    begin
        LoansReg.Get(LoanNo);
        if LoansReg."Repayment Frequency" = LoansReg."repayment frequency"::Daily then
            Evaluate(InPeriod, '1D')
        else
            if LoansReg."Repayment Frequency" = LoansReg."repayment frequency"::Weekly then
                Evaluate(InPeriod, '1W')
            else
                if LoansReg."Repayment Frequency" = LoansReg."repayment frequency"::Monthly then
                    Evaluate(InPeriod, '1M')
                else
                    if LoansReg."Repayment Frequency" = LoansReg."repayment frequency"::Quaterly then
                        Evaluate(InPeriod, '1Q');


        QCounter := 0;
        QCounter := 3;
        ScheduleBal := 0;
        GrPrinciple := LoansReg."Grace Period - Principle (M)";
        GrInterest := LoansReg."Grace Period - Interest (M)";
        InitialGraceInt := LoansReg."Grace Period - Interest (M)";

        LoansR.Reset;
        LoansR.SetRange(LoansR."Loan  No.", LoanNo);
        if LoansR.Find('-') then begin

            LoansR.TestField("Loan Disbursement Date");
            LoansR.TestField("Repayment Start Date");

            RSchedule.Reset;
            RSchedule.SetRange(RSchedule."Loan No.", LoanNo);
            RSchedule.DeleteAll;

            LoanAmount := LoansR."Approved Amount" + LoansR."Capitalized Charges";
            InterestRate := LoansR.Interest;
            RepayPeriod := LoansR.Installments;
            InitialInstal := LoansR.Installments + LoansR."Grace Period - Principle (M)";
            LBalance := LoansR."Approved Amount" + LoansR."Capitalized Charges";
            LNBalance := LoansR."Outstanding Balance";
            RunDate := LoansR."Repayment Start Date";

            InstalNo := 0;
            Evaluate(RepayInterval, '1W');

            //"Loan Repayment" Frequency
            if LoansR."Repayment Frequency" = LoansR."repayment frequency"::Daily then
                RunDate := CalcDate('-1D', RunDate)
            else
                if LoansR."Repayment Frequency" = LoansR."repayment frequency"::Weekly then
                    RunDate := CalcDate('-1W', RunDate)
                else
                    if LoansR."Repayment Frequency" = LoansR."repayment frequency"::Monthly then
                        RunDate := CalcDate('-1M', RunDate)
                    else
                        if LoansR."Repayment Frequency" = LoansR."repayment frequency"::Quaterly then
                            RunDate := CalcDate('-1Q', RunDate);
            //"Loan Repayment" Frequency


            repeat
                InstalNo := InstalNo + 1;
                ScheduleBal := LBalance;

                //*************"Loan Repayment" Frequency***********************//
                if LoansR."Repayment Frequency" = LoansR."repayment frequency"::Daily then
                    RunDate := CalcDate('1D', RunDate)
                else
                    if LoansR."Repayment Frequency" = LoansR."repayment frequency"::Weekly then
                        RunDate := CalcDate('1W', RunDate)
                    else
                        if LoansR."Repayment Frequency" = LoansR."repayment frequency"::Monthly then
                            RunDate := CalcDate('1M', RunDate)
                        else
                            if LoansR."Repayment Frequency" = LoansR."repayment frequency"::Quaterly then
                                RunDate := CalcDate('1Q', RunDate);






                //*******************If Amortised****************************//
                if LoansR."Repayment Method" = LoansR."repayment method"::Amortised then begin
                    LoansR.TestField(Installments);
                    LoansR.TestField(Interest);
                    LoansR.TestField(Installments);
                    TotalMRepay := ROUND((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -RepayPeriod)) * LoanAmount, 1, '=');
                    TotalMRepay := (InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -RepayPeriod)) * LoanAmount;
                    LInterest := ROUND(LBalance / 100 / 12 * InterestRate);

                    LPrincipal := TotalMRepay - LInterest;
                end;



                if LoansR."Repayment Method" = LoansR."repayment method"::"Straight Line" then begin
                    LoansR.TestField(Installments);
                    LPrincipal := ROUND(LoanAmount / RepayPeriod, 1, '=');
                    if (LoansR."Loan Product Type" = 'INST') or (LoansR."Loan Product Type" = 'MAZAO') then begin
                        LInterest := 0;
                    end else begin
                        LInterest := ROUND((InterestRate / 1200) * LoanAmount, 1, '=');
                    end;

                    LoansR."Loan Repayment" := LPrincipal + LInterest;
                    LoansR."Loan Principle Repayment" := LPrincipal;
                    LoansR."Loan Interest Repayment" := LInterest;
                end;


                if LoansR."Repayment Method" = LoansR."repayment method"::"Reducing Balance" then begin
                    LoansR.TestField(Interest);
                    LoansR.TestField(Installments);
                    LPrincipal := ROUND(LoanAmount / RepayPeriod, 1, '=');
                    LInterest := ROUND((InterestRate / 12 / 100) * LBalance, 1, '=');
                end;

                if LoansR."Repayment Method" = LoansR."repayment method"::Constants then begin
                    LoansR.TestField("Loan Repayment");
                    if LBalance < LoansR."Loan Repayment" then
                        LPrincipal := LBalance
                    else
                        LPrincipal := LoansR."Loan Repayment";
                    LInterest := LoansR.Interest;
                end;


                //Grace Period
                if GrPrinciple > 0 then begin
                    LPrincipal := 0
                end else begin
                    if LoansR."Instalment Period" <> InPeriod then
                        LBalance := LBalance - LPrincipal;
                    ScheduleBal := ScheduleBal - LPrincipal;
                end;

                if GrInterest > 0 then
                    LInterest := 0;

                GrPrinciple := GrPrinciple - 1;
                GrInterest := GrInterest - 1;

                NLInterest := ROUND(LoansR."Approved Amount" * LoansR.Interest / 12 * (RepayPeriod + 1) / (200 * RepayPeriod), 1, '='); //For Nafaka Only
                InterestVarianceOnlyNafaka := LInterest - NLInterest;

                RSchedule.Init;
                RSchedule."Repayment Code" := RepayCode;
                RSchedule."Loan No." := LoansR."Loan  No.";
                RSchedule."Loan Amount" := LoanAmount;
                RSchedule."Instalment No" := InstalNo;
                RSchedule."Repayment Date" := CalcDate('CM', RunDate);
                RSchedule."Member No." := LoansR."Client Code";
                RSchedule."Loan Category" := LoansR."Loan Product Type";
                RSchedule."Monthly Repayment" := NLInterest + LPrincipal;
                RSchedule."Monthly Interest" := NLInterest;
                //RSchedule."Monthly Interest Reducing":=ROUND(LInterest,1,'=');
                //RSchedule."Interest Variance":=InterestVarianceOnlyNafaka;
                RSchedule."Principal Repayment" := LPrincipal;
                RSchedule."Loan Balance" := ScheduleBal;
                RSchedule.Insert;
                WhichDay := Date2dwy(RSchedule."Repayment Date", 1);


            until LBalance < 1

        end;
        Commit;
    end;

    procedure FnValidateAmount(batchNo: Code[20]) disAmount: Decimal
    var
        InsuranceAMt: Decimal;
    begin
        LoanApps.Reset;
        LoanApps.SetRange("Batch No.", batchNo);
        if LoanApps.FindFirst() then begin
            LoanApps.CalcFields(LoanApps."Top Up Amount", LoanApps."Topup iNTEREST");
            if LoanApps."Top Up Amount" > 0 then begin
                TotalProductCharges := TotalProductCharges * -1;
                EFTFee := EFTFee * -1;
                if LoanApps.Refinancing then
                    DisbAmt := LoanApps."Approved Amount" * -1 + InsuranceAMt + EFTFee + LoanApps."Boosted Amount" + LoanApps."Boosting Commision"
                else
                    DisbAmt := -1 * (LoanApps."Approved Amount" - LoanApps."Top Up Amount" - ROUND(InsuranceAMt, 1, '=') - ROUND(LoanApps."Total TopUp Commission", 1, '=') - LoanApps."Boosted Amount" - LoanApps."Boosting Commision");
            end else begin
                DisbAmt := LoanApps."Approved Amount" * -1 + (ROUND(EFTFee, 1, '=') + ROUND(ProductChargesAmount, 1, '=') + upfronts
                  + ROUND(InsuranceAMt, 1, '=') + ROUND(TopUpComm, 1, '=') + LoanApps."Boosted Amount" + LoanApps."Boosting Commision");
            end;
            disAmount := DisbAmt;
        end;
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

                            //Levy On TopUp-------------------------------------------------------
                            if LoanType.Get(LoanApps."Loan Product Type") then begin
                                GenJournalLine.Init;
                                LineNo := LineNo + 10000;
                                if LoanType."Top Up Commision" > 0 then begin
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
                                    GenJournalLine."Bal. Account No." := LoanType."Top Up Commision Account";
                                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
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
                        GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                        GenJournalLine."Shortcut Dimension 2 Code" := SFactory.FnGetUserBranch();
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;
                    until ProductCharges.Next = 0;
                end;

                LoanProcessingFee := 0;
                //ExciseDuty:=0;

                //  //Excise
                //      GenSetUp.GET();
                //      ExciseDuty:=LoanApps."Loan Processing Fee"*(GenSetUp."Excise Duty(%)"/100);
                //      LineNo:=LineNo+10000;
                //      GenJournalLine.INIT;
                //      GenJournalLine."Journal Template Name":='PAYMENTS';
                //      GenJournalLine."Journal Batch Name":='LOANS';
                //      GenJournalLine."Line No.":=LineNo;
                //      GenJournalLine."Document No.":="Document No.";
                //      GenJournalLine."Posting Date":="Posting Date";
                //      GenJournalLine."External Document No.":=LoanApps."Loan  No.";
                //      GenJournalLine."Account Type":=GenJournalLine."Account Type"::"G/L Account";
                //      GenJournalLine."Account No.":=GenSetUp."Excise Duty Account";
                //      GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                //      GenJournalLine.Description:='Excise - ' + LoanApps."Loan  No.";
                //      GenJournalLine.Amount:=-ExciseDuty;
                //      GenJournalLine.VALIDATE(GenJournalLine.Amount);
                //      GenJournalLine."Loan No":=LoanApps."Loan  No.";
                //      GenJournalLine."Shortcut Dimension 1 Code":=DActivity;
                //      GenJournalLine."Shortcut Dimension 2 Code":=DBranch;
                //      IF GenJournalLine.Amount<>0 THEN
                //      GenJournalLine.INSERT;


                if "Mode Of Disbursement" = "mode of disbursement"::"2" then begin
                    LoanApps."Net Payment to FOSA" := LoanApps."Approved Amount";
                    LoanApps."Processed Payment" := false;
                    Modify
                end;
                LoanApps."Issued Date" := Today;
                LoanApps.Modify;

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
                SMSMessages."SMS Message" := 'Your loan of KSHs.' + Format(LoanApps."Approved Amount") +
                                          ' has been disbursed to your account.' + Format(LoanApps."Account No") + 'Ilkisonko Ltd.';
                Cust.Reset;
                if Cust.Get(LoanApps."Client Code") then
                    SMSMessages."Telephone No" := Cust."Mobile Phone No"
                else
                    SMSMessages."Telephone No" := Cust."Phone No.";

                SMSMessages.Insert;

                //END;
                //Loan Bridged and Comissions----------------------------------------------------
                //Generate Data Sheet Advice
                PTEN := '';

                if StrLen(LoanApps."Staff No") = 10 then begin
                    PTEN := CopyStr(LoanApps."Staff No", 10);
                end else
                    if StrLen(LoanApps."Staff No") = 9 then begin
                        PTEN := CopyStr(Loans."Staff No", 9);
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
                LoanApps.Modify;

            until LoanApps.Next = 0;
        end;
    end;
}

