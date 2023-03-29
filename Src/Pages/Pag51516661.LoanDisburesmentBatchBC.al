#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516661 "Loan Disburesment Batch-BC"
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
                Editable = false;
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
            }
            field("EFT Fee"; "EFT Fee")
            {
                ApplicationArea = Basic;
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
                            if LoansBatch."Batch Type" = LoansBatch."batch type"::"Personal Loans" then
                                Report.Run(51516143, true, false, LoansBatch)
                            else
                                if LoansBatch."Batch Type" = LoansBatch."batch type"::"Branch Loans" then
                                    Report.Run(51516143, true, false, LoansBatch)
                                else
                                    if LoansBatch."Batch Type" = LoansBatch."batch type"::"Appeal Loans" then
                                        Report.Run(51516143, true, false, LoansBatch)
                                    else
                                        Report.Run(51516143, true, false, LoansBatch);
                        end;




                        //51516485
                    end;
                }
                action("EFT Schedule")
                {
                    ApplicationArea = Basic;
                    Caption = 'EFT Schedule';
                    Image = SuggestVendorPayments;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    begin

                        if Posted = true then
                            Error('Batch already posted.');


                        LoansBatch.Reset;
                        LoansBatch.SetRange(LoansBatch."Batch No.", "Batch No.");
                        if LoansBatch.Find('-') then begin
                            if LoansBatch."Batch Type" = LoansBatch."batch type"::"Personal Loans" then
                                Report.Run(51516143, true, false, LoansBatch)
                            else
                                if LoansBatch."Batch Type" = LoansBatch."batch type"::"Branch Loans" then
                                    Report.Run(51516143, true, false, LoansBatch)
                                else
                                    if LoansBatch."Batch Type" = LoansBatch."batch type"::"Appeal Loans" then
                                        Report.Run(51516143, true, false, LoansBatch)
                                    else
                                        Report.Run(51516143, true, false, LoansBatch);
                        end;




                        //51516485
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
                        /*LoanApps.RESET;
                        LoanApps.SETRANGE(LoanApps."Batch No.","Batch No.");
                        IF LoanApps.FIND('-')=FALSE THEN
                        ERROR('You cannot send an empty batch for approval');
                        TESTFIELD("Description/Remarks");
                        IF Status<>Status::Open THEN
                        ERROR(Text001);
                        
                        //End allocate batch number
                        Doc_Type:=Doc_Type::LoanDisbursement;
                        Table_id:=DATABASE::"Loan Disburesment-Batching";
                        //IF ApprovalMgt.SendApproval(Table_id,"Batch No.",Doc_Type,Status)THEN;
                        
                        IF ApprovalsMgmt.CheckLoanDisbursementApprovalsWorkflowEnabled(Rec) THEN
                          ApprovalsMgmt.OnSendLoanDisbursementForApproval(Rec);*/


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
                action("Cancel Cheque")
                {
                    ApplicationArea = Basic;

                    trigger OnAction()
                    begin
                        //Status:=Status::Open;
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
                        /*IF Status<>Status::Approved THEN
                          ERROR('Loan Batch is not Fully Approved');*/
                        LoanApps.Reset;
                        LoanApps.SetRange(LoanApps."Batch No.", "Batch No.");
                        LoanApps.SetRange(LoanApps."System Created", false);
                        if LoanApps.Find('-') then begin
                            repeat
                                if LoanApps."Loan Product Type" <> 'IMPORTED' then begin
                                    RSchedule.Reset;
                                    RSchedule.SetRange(RSchedule."Loan No.", LoanApps."Loan  No.");
                                    if not RSchedule.Find('-') then begin
                                        KNFactory.FnGenerateRepaymentSchedule(LoanApps."Loan  No.");
                                    end;
                                    FnPostLoan()
                                end //ELSE
                                    //FnPostImported();
                            until LoanApps.Next = 0;
                        end;
                        //TESTFIELD(Posted,TRUE);

                        // LoanApps .RESET;
                        // LoanApps.SETRANGE(LoanApps."Loan  No.");
                        // IF LoanApps.FINDFIRST THEN
                        //   REPORT.RUN(51516477,TRUE,TRUE,LoanApps);

                        //REPORT.RUN(51516142);

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
                action("Create Posting  Lines")
                {
                    ApplicationArea = Basic;
                    Caption = 'Create Posting  Lines';
                    Image = PostedVoucherGroup;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    var
                        Text001: label 'The Batch need to be approved.';
                    begin
                        //IF Status<>Status::Approved THEN
                        //  ERROR('Loan Batch is not Fully Approved');


                        LoanApps.Reset;
                        LoanApps.SetRange(LoanApps."Batch No.", "Batch No.");
                        LoanApps.SetRange(LoanApps."System Created", false);
                        if LoanApps.Find('-') then begin
                            repeat
                                if LoanApps."Loan Product Type" <> 'IMPORTED' then begin
                                    FnCreateLines()
                                end else
                                    FnCreateLines();
                            until LoanApps.Next = 0;
                        end;


                        //REPORT.RUN(51516142);
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

    local procedure FnPostLoan()
    var
        DisbAmtTemp: Decimal;
        InsuranceIncomeAcc: Code[20];
        InsuranceAmount: Decimal;
    begin
        if Posted = true then
            Error('Batch already posted.');
        //IF Status<>Status::Approved THEN
        //ERROR(FORMAT(Text001));
        CalcFields(Location);
        if Confirm('Are you sure you want to post this batch?', true) = false then
            exit;


        FundsUserSetup.Get(UserId);
        Jtemplate := FundsUserSetup."Payment Journal Template";
        JBatch := FundsUserSetup."Payment Journal Batch";

        if Jtemplate = '' then begin
            Error('Ensure the Imprest Template is set up in Cash Office Setup');
        end;

        if JBatch = '' then begin
            Error('Ensure the Imprest Batch is set up in the Cash Office Setup')
        end;


        TestField("Description/Remarks");
        TestField("Posting Date");
        TestField("Document No.");
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", Jtemplate);
        GenJournalLine.SetRange("Journal Batch Name", JBatch);
        GenJournalLine.DeleteAll;

        GenSetUp.Get();

        //Disburesment Via Cheque**************************************************************
        if ("Mode Of Disbursement" = "mode of disbursement"::Cheque) or ("Mode Of Disbursement" = "mode of disbursement"::"4") then begin

            LoanApps.Reset;
            LoanApps.SetRange(LoanApps."Batch No.", "Batch No.");
            LoanApps.SetRange(LoanApps."System Created", false);
            LoanApps.SetFilter(LoanApps."Loan Status", '<>Rejected');
            if LoanApps.Find('-') then begin
                repeat
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
                                GenJournalLine."Journal Template Name" := Jtemplate;
                                GenJournalLine."Journal Batch Name" := JBatch;
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Document No." := "Document No.";
                                GenJournalLine."Posting Date" := "Posting Date";
                                GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                                GenJournalLine."Account No." := LoanApps."Client Code";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                if LoanApps.Bridging then
                                    GenJournalLine.Description := 'Bridged by - ' + LoanApps."Loan  No." + ' ' + LoanApps."Client Code";
                                if LoanApps.Refinancing then
                                    GenJournalLine.Description := 'Refinanced by - ' + LoanApps."Loan  No." + ' ' + LoanApps."Client Code";
                                if LoanApps.Consolidation then
                                    GenJournalLine.Description := 'Consolidated by - ' + LoanApps."Loan  No." + ' ' + LoanApps."Client Code";
                                //GenJournalLine.Amount:=ROUND(LoanTopUp."Top Up Amount",0.01,'=')* -1;
                                GenJournalLine.Amount := LoanTopUp."Outstanding Balance" * -1;//Joel
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Loan Repayment";
                                GenJournalLine."Loan No" := LoanTopUp."Loan Top Up";
                                GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Cashier Branch";
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;


                                //Interest Due Paid-----------------------------------------------
                                GenJournalLine.Init;
                                LineNo := LineNo + 10000;
                                if LoanType.Get(LoanApps."Loan Product Type") then begin
                                    GenJournalLine."Journal Template Name" := Jtemplate;
                                    GenJournalLine."Journal Batch Name" := JBatch;
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                                    GenJournalLine."Account No." := LoanApps."Client Code";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Document No." := "Document No.";
                                    GenJournalLine."Posting Date" := "Posting Date";
                                    if LoanApps.Bridging then
                                        GenJournalLine.Description := 'Interest Due Paid on Bridging ' + ' ' + LoanApps."Loan  No." + ' ' + LoanApps."Client Code";
                                    if LoanApps.Refinancing then
                                        GenJournalLine.Description := 'Interest Due Paid on Refinancing ' + ' ' + LoanApps."Loan  No." + ' ' + LoanApps."Client Code";
                                    if LoanApps.Consolidation then
                                        GenJournalLine.Description := 'Interest Due Paid on consolidation ' + LoanApps."Loan  No." + ' ' + LoanApps."Client Code";
                                    GenJournalLine.Amount := -ROUND(LoanTopUp."Interest Top Up", 0.01, '=');
                                    GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                                    GenJournalLine."Loan No" := LoanTopUp."Loan Top Up";
                                    GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                    GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Cashier Branch";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;
                                end;
                                //End Interest Due Paid-----------------------------------------------

                                //Penalty Paid On Defaulted Loan-----------------------------------------------------
                                //    GenJournalLine.INIT;
                                //    LineNo:=LineNo+10000;
                                //   IF LoanType.GET(LoanApps."Loan Product Type") THEN BEGIN
                                //    GenJournalLine."Journal Template Name":=Jtemplate;
                                //    GenJournalLine."Journal Batch Name":=JBatch;
                                //    GenJournalLine."Line No.":=LineNo;
                                //    GenJournalLine."Account Type":=GenJournalLine."Bal. Account Type"::Member;
                                //    GenJournalLine."Account No.":=LoanApps."Client Code";
                                //    GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                                //    GenJournalLine."Document No.":="Document No.";
                                //    GenJournalLine."Posting Date":="Posting Date";
                                //    GenJournalLine.Description:='Penalty Paid on Loan Defaulted ' + LoanApps."Loan  No."+' '+LoanApps."Client Code"+' '+LoanApps."Employer Code";
                                //    GenJournalLine.Amount:=-ROUND(LoanTopUp."Penalty Charged",0.01,'=');
                                //    GenJournalLine."External Document No.":=LoanApps."Loan  No.";
                                //    GenJournalLine.VALIDATE(GenJournalLine.Amount);
                                //    GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
                                //    GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::"STO Charges";
                                //    GenJournalLine."Loan No":=LoanTopUp."Loan Top Up";
                                //    GenJournalLine."Shortcut Dimension 1 Code":='BOSA';
                                //    GenJournalLine."Shortcut Dimension 2 Code":=LoanApps."Cashier Branch";
                                //    GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                                //    GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                                //    IF GenJournalLine.Amount<>0 THEN
                                //    GenJournalLine.INSERT;
                                //    END;
                                //End Penalty Paid On Defaulted Loan-----------------------------------------------------
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
                                        //Loans."Staff No":=customer."Payroll/Staff No";
                                        DataSheet.Reset;
                                        DataSheet.SetRange(DataSheet."PF/Staff No", LoanApps."Staff No");
                                        DataSheet.SetRange(DataSheet."ID NO.", LoanApps."ID NO");
                                        DataSheet.SetRange(DataSheet.Date, LoanApps."Issued Date");
                                        DataSheet.SetRange(DataSheet."Remark/LoanNO", LoanTopUp."Loan Top Up");
                                        if DataSheet.Find('-') then begin
                                            DataSheet.Delete
                                        end;
                                        DataSheet.Reset;
                                        DataSheet.SetRange(DataSheet."PF/Staff No", LoanApps."Staff No");
                                        DataSheet.SetRange(DataSheet."ID NO.", LoanApps."ID NO");
                                        DataSheet.SetRange(DataSheet.Date, LoanApps."Issued Date");
                                        DataSheet.SetRange(DataSheet."Remark/LoanNO", LoanTopUp."Loan Top Up");
                                        if DataSheet.Find('-') then begin
                                            DataSheet.Init;
                                            DataSheet."PF/Staff No" := LoanTopUp."Staff No";
                                            DataSheet."Type of Deduction" := LoanTypes."Product Description";
                                            DataSheet."Remark/LoanNO" := LoanTopUp."Loan Top Up";
                                            DataSheet.Name := LoanApps."Client Code";
                                            DataSheet."ID NO." := LoanApps."ID NO";
                                            DataSheet."Amount ON" := 0;
                                            DataSheet."Amount OFF" := LoanTopUp."Total Top Up";
                                            DataSheet."REF." := '2026';
                                            DataSheet."New Balance" := 0;
                                            DataSheet.Date := Loans."Issued Date";
                                            DataSheet.Employer := Customer."Employer Code";
                                            DataSheet."Repayment Method" := Customer."Repayment Method";
                                            DataSheet."Transaction Type" := DataSheet."transaction type"::ADJUSTMENT;
                                            DataSheet."Sort Code" := PTEN;
                                            DataSheet.Insert;
                                        end;
                                    end;
                                end;

                                BatchTopUpAmount := 0;
                                BatchTopUpComm := 0;
                                BatchTopUpAmount := BatchTopUpAmount + LoanApps."Top Up Amount" + ROUND(LoanTopUp."Interest Top Up", 0.01, '=');
                                BatchTopUpComm := BatchTopUpComm + TotalTopupComm;
                            until LoanTopUp.Next = 0;
                            //Levy On Bridging-------------------------------------------------------
                            if LoanApps.Bridging or LoanApps.Consolidation then begin
                                if LoanType.Get(LoanApps."Loan Product Type") then begin
                                    GenSetUp.Get;
                                    GenJournalLine.Init;
                                    LineNo := LineNo + 10000;
                                    //IF LoanTopUp.Commision > 0 THEN BEGIN
                                    GenJournalLine."Journal Template Name" := Jtemplate;
                                    GenJournalLine."Journal Batch Name" := JBatch;
                                    GenJournalLine."Line No." := LineNo;
                                    GenJournalLine."Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                    GenJournalLine."Account No." := GenSetUp."Loan Top Up Commision";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Document No." := "Document No.";
                                    GenJournalLine."Posting Date" := "Posting Date";
                                    if LoanApps.Bridging then
                                        GenJournalLine.Description := 'Commission on Factoring -' + ' ' + LoanApps."Client Code" + ' ' + LoanApps."Loan  No.";
                                    if LoanApps.Consolidation then
                                        GenJournalLine.Description := 'Commission on Consolidation- ' + ' ' + LoanApps."Client Code" + ' ' + LoanApps."Loan  No.";
                                    TopUpComm := LoanApps."Total TopUp Commission";
                                    GenJournalLine.Amount := ROUND(TopUpComm, 0.01, '=') * -1;
                                    GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                    GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Global Dimension 2 Code";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;
                                    //END;
                                end;
                            end;
                        end;
                    end;

                    ProductChargesAmount := 0;
                    ObjLoanProductCharges.Reset;
                    ObjLoanProductCharges.SetRange(ObjLoanProductCharges."Product Code", LoanApps."Loan Product Type");
                    if ObjLoanProductCharges.Find('-') then begin
                        repeat
                            LineNo := LineNo + 10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := Jtemplate;
                            GenJournalLine."Journal Batch Name" := JBatch;
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Document No." := "Document No.";
                            ;
                            GenJournalLine."Posting Date" := "Posting Date";
                            GenJournalLine."External Document No." := LoanApps."Loan  No.";
                            GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                            GenJournalLine."Account No." := ObjLoanProductCharges."G/L Account";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine.Description := Format(ObjLoanProductCharges.Description + ' ' + LoanApps."Loan  No." + ' ' + LoanApps."Client Code");
                            if ObjLoanProductCharges."Use Perc" then begin
                                ProductChargesAmount := ProductChargesAmount + ((ObjLoanProductCharges.Percentage * LoanApps."Recommended Amount") / 100);
                                GenJournalLine.Amount := ROUND(ProductChargesAmount, 0.01, '=') * -1;
                            end
                            else begin
                                ProductChargesAmount := ProductChargesAmount + ObjLoanProductCharges.Amount;
                                GenJournalLine.Amount := ROUND(ProductChargesAmount, 0.01, '=') * -1;
                            end;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            //Deductions+=GenJournalLine.Amount;
                            //GenJournalLine."Loan No":=LoanApps."Loan  No.";
                            GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                            GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Cashier Branch";
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;
                        until ObjLoanProductCharges.Next = 0;
                    end;

                    // ObjLoanProductCharges.RESET;
                    // ObjLoanProductCharges.SETRANGE(ObjLoanProductCharges."Product Code",LoanApps."Loan Product Type");
                    // IF ObjLoanProductCharges.FIND('-') THEN
                    //  BEGIN
                    //    REPEAT
                    //      IF ObjLoanProductCharges."Use Perc" THEN BEGIN
                    //        TotalProductCharges:=TotalProductCharges+((ObjLoanProductCharges.Percentage*LoanApps."Approved Amount")/100)
                    //       END ELSE BEGIN
                    //        TotalProductCharges:=TotalProductCharges+ObjLoanProductCharges.Amount;
                    //      END;
                    //    UNTIL ObjLoanProductCharges.NEXT=0;
                    //  END;

                    Loaninsurance := 0;

                    if LoanApps."Approved Amount" > 0 then begin
                        //LOAN INSURANCE--------------------------------
                        ProductCharges.Reset;
                        ProductCharges.SetRange(ProductCharges."Product Code", LoanApps."Loan Product Type");
                        ProductCharges.SetRange(ProductCharges.Code, 'LINSURANCE');
                        if ProductCharges.Find('-') then begin
                            if ProductCharges."Use Perc" = true then begin
                                Loaninsurance := LoanApps."Approved Amount" * (ProductCharges.Percentage / 100);
                                InsuranceAcc := ProductCharges."G/L Account";

                            end else
                                Loaninsurance := ProductCharges.Amount;
                            InsuranceAcc := ProductCharges."G/L Account";
                        end;
                        InsuranceAcc := '20038';
                        InsuranceIncomeAcc := '30312';

                        //END LOAN INSURANCE------------------------------------
                        //Loaninsurance:=Loaninsurance;
                        LineNo := LineNo + 10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := Jtemplate;
                        GenJournalLine."Journal Batch Name" := JBatch;
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Document No." := "Document No.";
                        ;
                        GenJournalLine."Posting Date" := "Posting Date";
                        GenJournalLine."External Document No." := LoanApps."Loan  No.";
                        if LoanApps."Loan Product Type" = 'INSTANT' then begin
                            GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                            GenJournalLine."Account No." := InsuranceIncomeAcc;
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                        end else begin
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Loan Insurance Paid";
                            GenJournalLine."Account No." := LoanApps."Client Code";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                        end;
                        GenJournalLine.Description := 'Loan Insurance - ' + LoanApps."Loan  No." + ' ' + LoanApps."Client Code" + ' ' + LoanApps."Employer Code";
                        //GenJournalLine.Amount:=ROUND(LoanApps."Loan Insurance",0.01,'=')*-1;
                        if LoanApps."Loan Product Type" <> 'INSTANT' then begin
                            GenJournalLine.Description := 'Loan Insurance charged- ' + LoanApps."Loan  No." + ' ' + LoanApps."Client Code";
                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                            GenJournalLine."Bal. Account No." := InsuranceAcc;
                            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                        end;
                        GenJournalLine.Amount := ROUND(LoanApps.Insurance, 0.01, '=') * -1;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        //Deductions+=GenJournalLine.Amount;
                        GenJournalLine."Loan No" := LoanApps."Loan  No.";
                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                        GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Cashier Branch";
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;
                    end;

                    TLoaninsurance := TLoaninsurance + GenJournalLine.Amount * -1;


                    //eft fee
                    if "EFT Fee" then begin
                        GenSetUp.Get();
                        LineNo := LineNo + 10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := Jtemplate;
                        GenJournalLine."Journal Batch Name" := JBatch;
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Document No." := "Document No.";
                        ;
                        GenJournalLine."Posting Date" := "Posting Date";
                        GenJournalLine."External Document No." := LoanApps."Loan  No.";
                        GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Account No." := GenSetUp."EFT Fee Account";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine.Description := 'EFT Fee of ' + LoanApps."Loan  No." + ' ' + LoanApps."Client Code" + ' ' + LoanApps."Employer Code";
                        EFTFee := GenSetUp."EFT Fee";
                        GenJournalLine.Amount := ROUND(EFTFee, 0.01, '=') * -1;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        //Deductions+=GenJournalLine.Amount;
                        GenJournalLine."Loan No" := LoanApps."Loan  No.";
                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                        GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Cashier Branch";
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;
                        if EFTFee <> 0 then
                            LoanApps."Bank Charges" := EFTFee
                    end;
                    //end eft fee


                    //Disburesment Via Cheque(Debit Members Account)-------------------------
                    GenJournalLine.Init;
                    LineNo := LineNo + 10000;
                    GenJournalLine."Journal Template Name" := Jtemplate;
                    GenJournalLine."Journal Batch Name" := JBatch;
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Document No." := "Document No.";
                    GenJournalLine."Posting Date" := "Posting Date";
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                    GenJournalLine."Account No." := LoanApps."Client Code";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine.Description := LoanApps."Loan  No." + ' ' + LoanApps."Client Code" + ' ' + LoanApps."Employer Code";
                    GenJournalLine.Amount := LoanApps."Approved Amount";
                    LoanApps.CalcFields(LoanApps."Top Up Amount", LoanApps."Topup iNTEREST");
                    if LoanApps.Refinancing then
                        GenJournalLine.Amount := LoanApps."Approved Amount" + LoanApps."Top Up Amount";
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                    GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Cashier Branch";
                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Loan;
                    GenJournalLine."Loan No" := LoanApps."Loan  No.";
                    GenJournalLine."External Document No." := LoanApps."Loan  No.";
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;
                    //End Disburesment Via Cheque(Debit Members Account)-------------------------
                    if LoanApps."Loan Product Type" <> 'INSTANT' then
                        InsuranceAmount := 0
                    else
                        InsuranceAmount := LoanApps.Insurance;
                    //Disburesment Via Cheque(Credit Bank)-----------------------------------------------------
                    GenJournalLine.Init;
                    LineNo := LineNo + 10000;
                    GenJournalLine."Journal Template Name" := Jtemplate;
                    GenJournalLine."Journal Batch Name" := JBatch;
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Document No." := "Document No.";
                    GenJournalLine."Posting Date" := "Posting Date";
                    GenJournalLine."Account Type" := GenJournalLine."account type"::"Bank Account";
                    GenJournalLine."Account No." := "BOSA Bank Account";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine.Description := 'loan For :-' + LoanApps."Client Code" + '-' + "Cheque No." + ' ' + LoanApps."Client Code" + ' ' + LoanApps."Employer Code" + ' ' + LoanApps."Loan  No.";
                    LoanApps.CalcFields(LoanApps."Top Up Amount", LoanApps."Topup iNTEREST");

                    if LoanApps."Top Up Amount" > 0 then begin
                        TotalProductCharges := TotalProductCharges * -1;
                        EFTFee := EFTFee * -1;
                        if LoanApps.Refinancing then
                            DisbAmt := LoanApps."Approved Amount" * -1 + InsuranceAmount + EFTFee
                        else
                            DisbAmt := -1 * (LoanApps."Approved Amount" - LoanApps."Top Up Amount" - ROUND(InsuranceAmount, 0.01, '=') - ROUND(LoanApps."Total TopUp Commission", 0.01, '='));
                    end else begin
                        DisbAmt := LoanApps."Approved Amount" * -1 + (ROUND(EFTFee, 0.01, '=') + ROUND(ProductChargesAmount, 0.01, '=') + upfronts
                          + ROUND(InsuranceAmount, 0.01, '=') + ROUND(TopUpComm, 0.01, '='));
                        //DisbAmt:=LoanApps."Approved Amount"-LoanApps."Top Up Amount"-ROUND(LoanApps."Loan Insurance",0.01,'=')-ROUND(LoanApps."Total TopUp Commission",0.01,'=');
                    end;
                    GenJournalLine.Amount := DisbAmt;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."External Document No." := LoanApps."Loan  No.";
                    GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                    GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Cashier Branch";
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;


                    if ("Mode Of Disbursement" = "mode of disbursement"::Cheque) or ("Mode Of Disbursement" = "mode of disbursement"::"4") then begin
                        //LoanApps."Net Payment to FOSA":=LoanApps."Approved Amount";
                        LoanApps."Processed Payment" := false;
                        Modify
                    end;

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
                    //Generate Schedule
                    KNFactory.FnGenerateRepaymentSchedule(LoanApps."Loan  No.");

                    //ChequePosting
                    LoanApps."Loan Status" := LoanApps."loan status"::Issued;
                    LoanApps."Issued Date" := Today;
                    LoanApps."Disbursed By" := UserId;
                    LoanApps."Mode of Disbursement" := "Mode Of Disbursement";
                    LoanApps."Amount Disbursed" := DisbAmt * -1;
                    LoanApps.Posted := true;
                    LoanApps."Posting Date" := Today;
                    LoanApps.Modify;
                    LoanGuar.Reset;
                    LoanGuar.SetRange(LoanGuar."Loan No", LoanApps."Loan  No.");
                    if LoanGuar.Find('-') then begin
                        repeat
                            Cust.Reset;
                            Cust.SetRange(Cust."No.", LoanGuar."Member No");
                            if Cust.Find('-') then begin
                                SFactory.FnSendSMS('LOAN GUARANTORS', 'You have guaranteed ' + LoanApps."Client Code" + ' a ' + LoanApps."Loan Product Type Name" + ' of ' + Format(LoanApps."Approved Amount")
                               + '. Contact us if in dispute', '', Cust."Mobile Phone No");
                            end;
                        until LoanGuar.Next = 0;
                    end;

                    KNFactory.FnSendSMS('LOANS', 'Dear ' + Format(LoanApps."Client Code") + 'we have disbursed ksh ' + Format(DisbAmt) + ' of your ' + Format(LoanApps."Loan Product Type Name") + ' KENTOURS SACCO SOCIETY',
                                        LoanApps."Client Code", KNFactory.KnGetMemberPhoneNo(LoanApps."Client Code"));
                    Commit;
                    LnPP.Reset;
                    LnPP.SetRange(LnPP."Batch No.", LoanApps."Batch No.");
                    LnPP.SetRange(LnPP."Loan  No.", LoanApps."Loan  No.");
                    if LnPP.Find('-') then begin
                        Report.Run(51516412, true, false, LnPP);
                        Report.Run(51516951, true, false, LnPP);
                    end;
                until LoanApps.Next = 0;
            end;
            Commit;
            ObjLoanBatching.Reset;
            ObjLoanBatching.SetRange(ObjLoanBatching."Batch No.", "Batch No.");
            if ObjLoanBatching.Find('-') then begin
                Report.Run(51516143, true, false, ObjLoanBatching);
            end;
        end;

        //End of Disburesment Via Cheque**************************************************************
        //Post New
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", Jtemplate);
        GenJournalLine.SetRange("Journal Batch Name", JBatch);
        if GenJournalLine.Find('-') then begin
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
        end;
        LoanApps."Issued Date" := Today;
        LoanApps."Loan Status" := LoanApps."loan status"::Issued;
        LoanApps."Amount Disbursed" := DisbAmt * -1;
        LoanApps.Posted := true;
        LoanApps.Modify;

        GenSetUp.Get();
        //Send Loan Disburesment SMS*********************************************
        if GenSetUp."Send Loan Disbursement SMS" = true then begin
            FnSendDisburesmentSMS(LoanApps."Loan  No.", LoanApps."Client Code");
        end;
        //Send Loan Disburesment Email*******************************************
        /*IF GenSetUp."Send Loan Disbursement Email"=TRUE THEN BEGIN
         FnSendDisburesmentEmail(LoanApps."Loan  No.");
          END;*/
        Posted := true;
        Modify;


        Message('Batch posted successfully.');

    end;

    local procedure FnPostImported()
    begin
        if Posted = true then
            Error('Batch already posted.');
        //IF Status<>Status::Approved THEN
        //ERROR(FORMAT(Text001));
        CalcFields(Location);
        if Confirm('Are you sure you want to post this batch?', true) = false then
            exit;
        TestField("Description/Remarks");
        TestField("Posting Date");
        TestField("Document No.");
        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'PaymentS');
        GenJournalLine.SetRange("Journal Batch Name", 'LOANS');
        GenJournalLine.DeleteAll;

        GenSetUp.Get();

        //Disburesment To FOSA Account************************************************
        if "Mode Of Disbursement" = "mode of disbursement"::"2" then begin
            LoanApps.Reset;
            LoanApps.SetRange(LoanApps."Batch No.", "Batch No.");
            LoanApps.SetRange(LoanApps."System Created", false);
            if LoanApps.Find('-') then begin
                repeat


                    LoanApps.CalcFields(LoanApps."Top Up Amount", LoanApps."Topup iNTEREST");
                    TCharges := 0;
                    TopUpComm := 0;
                    TotalTopupComm := 0;
                    Vend.Reset;
                    Vend.SetRange(Vend."No.", LoanApps."Client Code");
                    if Vend.Find('-') then begin
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
                    GenJournalLine.Description := 'Loan principle' + LoanApps."Product Code" + ' ' + LoanApps."Client Code" + ' ' + LoanApps."Employer Code";
                    GenJournalLine.Amount := LoanApps."Approved Amount";
                    GenJournalLine."External Document No." := LoanApps."Loan  No.";
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                    GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Cashier Branch"; //"Global Dimension 2 Code";
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;
                    //End Post Loan(Debit Member Loan Account)---------------------------------------------

                    LoanApps.CalcFields(LoanApps."Top Up Amount", LoanApps."Topup iNTEREST");
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
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                                GenJournalLine."Account No." := LoanApps."Client Code";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine.Description := 'Off Set By - ' + ' ' + LoanApps."Loan  No." + ' ' + LoanApps."Client Code" + ' ' + LoanApps."Employer Code";
                                GenJournalLine.Amount := (LoanTopUp."Outstanding Balance") * -1;
                                //GenJournalLine.Amount:=LoanTopUp."Top Up Amount"* -1;//Joel
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Loan Repayment";
                                GenJournalLine."Loan No" := LoanTopUp."Loan Top Up";
                                //GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::Vendor;
                                // GenJournalLine."Bal. Account No.":=LoanApps."Account No";
                                //GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
                                GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Cashier Branch";
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
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                                    GenJournalLine."Account No." := LoanApps."Client Code";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Document No." := "Document No.";
                                    GenJournalLine."Posting Date" := "Posting Date";
                                    GenJournalLine.Description := 'Interest Due Paid on top up ' + LoanApps."Loan Product Type Name" + ' ' + LoanApps."Loan  No." + ' ' + LoanApps."Client Code" + ' ' + LoanApps."Employer Code";
                                    GenJournalLine.Amount := -ROUND(LoanTopUp."Interest Top Up", 0.01, '=');
                                    GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    //GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
                                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                                    GenJournalLine."Loan No" := LoanTopUp."Loan Top Up";
                                    //GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::Vendor;
                                    // GenJournalLine."Bal. Account No.":=LoanApps."Account No";
                                    //GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
                                    GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                    GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Cashier Branch";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount <> 0 then
                                        GenJournalLine.Insert;
                                end;
                                //End Pay Outstanding Interest on TopUp----------------------------------

                                //Levy On Bridging-------------------------------------------------------
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
                                        GenJournalLine.Description := 'Levy on Bridging' + ' ' + LoanApps."Loan  No." + ' ' + LoanApps."Client Code" + ' ' + LoanApps."Employer Code";
                                        TopUpComm := LoanTopUp.Commision;
                                        TotalTopupComm := TotalTopupComm + TopUpComm;
                                        GenJournalLine.Amount := TopUpComm * -1;
                                        GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                        GenJournalLine.Validate(GenJournalLine.Amount);
                                        // GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::Vendor;
                                        //GenJournalLine."Bal. Account No.":=LoanApps."Account No";
                                        //GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
                                        GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                        GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Cashier Branch";
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                        if GenJournalLine.Amount <> 0 then
                                            GenJournalLine.Insert;
                                    end;
                                end;
                            //End Levy On Bridging-------------------------------------------------------
                            until LoanTopUp.Next = 0;
                        end;
                    end;




                    //Boosting Shares Commision
                    GenSetUp.Get();
                    if LoanApps."Boosting Commision" > 0 then begin
                        LineNo := LineNo + 10000;

                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'PAYMENTS';
                        GenJournalLine."Journal Batch Name" := 'LOANS';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Account No." := GenSetUp."Boosting Fees Account";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No." := "Document No.";
                        GenJournalLine."External Document No." := LoanApps."Loan  No.";
                        GenJournalLine."Posting Date" := "Posting Date";
                        GenJournalLine.Description := 'Boosting Commision' + LoanApps."Loan  No." + ' ' + LoanApps."Client Code" + ' ' + LoanApps."Employer Code";
                        GenJournalLine.Amount := ROUND(LoanApps."Boosting Commision", 0.01, '=') * -1;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        Deductions += GenJournalLine.Amount;
                        GenJournalLine."Loan No" := LoanApps."Loan  No.";
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::Vendor;
                        GenJournalLine."Bal. Account No." := LoanApps."Client Code";
                        GenJournalLine."Bal. Account No." := LoanApps."Client Code";
                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                        GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Cashier Branch";
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;
                        BatchBoostingCom += GenJournalLine.Amount;
                        if Cust.Get(LoanApps."Client Code") then begin
                            Cust.BoostedAmount := 0;
                            Cust.Modify;
                        end;

                    end;








                    //Loan TOP Up Interest Accrual for the Month
                    if (LoanApps."Loan Product Type" = 'TOPUPADV') or (LoanApps."Loan Product Type" = 'ORDINARYADV') then begin
                        if LoanType.Get(LoanApps."Loan Product Type") then begin
                            LineNo := LineNo + 10000;

                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'PAYMENTS';
                            GenJournalLine."Journal Batch Name" := 'LOANS';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                            GenJournalLine."Account No." := LoanApps."Client Code";
                            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Loan No" := LoanApps."Loan  No.";
                            GenJournalLine."Document No." := "Document No.";
                            GenJournalLine."Posting Date" := "Posting Date";
                            GenJournalLine.Description := 'Interest Due' + ' ' + LoanApps."Loan  No." + ' ' + LoanApps."Client Code" + ' ' + LoanApps."Employer Code";
                            GenJournalLine.Amount := (LoanType."Interest rate" / 1200) * LoanApps."Approved Amount";
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            Deductions += GenJournalLine.Amount;
                            GenJournalLine."Shortcut Dimension 1 Code" := 'FOSA';
                            GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Cashier Branch";
                            //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                            //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                            GenJournalLine."Bal. Account No." := LoanType."Loan Interest Account";
                            //GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;


                            //Processing Fee Okoa
                            LineNo := LineNo + 10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'PAYMENTS';
                            GenJournalLine."Journal Batch Name" := 'LOANS';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                            GenJournalLine."Account No." := LoanApps."Client Code";
                            GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Loan;
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Loan No" := LoanApps."Loan  No.";
                            GenJournalLine."Document No." := "Document No.";
                            GenJournalLine."Posting Date" := "Posting Date";
                            GenJournalLine.Description := 'Processing Fee Okoa' + LoanApps."Loan  No." + ' ' + LoanApps."Client Code" + ' ' + LoanApps."Employer Code";
                            GenJournalLine.Amount := 100;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            Deductions += GenJournalLine.Amount;
                            GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                            GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Cashier Branch";
                            //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                            //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                            GenJournalLine."Bal. Account No." := LoanType."Loan Interest Account";
                            //GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;
                        end;
                    end;



                    //7.
                    if LoanApps."Interest In Arrears" <> 0 then begin
                        if LoanType.Get(LoanApps."Loan Product Type") then begin
                            LineNo := LineNo + 10000;

                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name" := 'PAYMENTS';
                            GenJournalLine."Journal Batch Name" := 'LOANS';
                            GenJournalLine."Line No." := LineNo;
                            GenJournalLine."Account Type" := GenJournalLine."account type"::"G/L Account";
                            GenJournalLine."Account No." := LoanType."Interest In Arrears Account";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No." := "Document No.";
                            GenJournalLine."Posting Date" := "Posting Date";
                            GenJournalLine.Description := 'InterestInArreas' + ' ' + LoanApps."Loan  No." + ' ' + LoanApps."Client Code" + ' ' + LoanApps."Employer Code";
                            GenJournalLine.Amount := ROUND(LoanApps."Interest In Arrears" * -1, 0.05, '>');
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            Deductions += GenJournalLine.Amount;
                            GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                            GenJournalLine."Shortcut Dimension 2 Code" := DBranch;
                            //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                            //GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::Vendor;
                            GenJournalLine."Bal. Account No." := LoanApps."Client Code";
                            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                            if GenJournalLine.Amount <> 0 then
                                GenJournalLine.Insert;
                            BatchIntinArr += GenJournalLine.Amount;
                        end;
                    end;


                    Loaninsurance := 0;

                    if LoanApps."Approved Amount" > 0 then begin
                        //LOAN INSURANCE--------------------------------
                        ProductCharges.Reset;
                        ProductCharges.SetRange(ProductCharges."Product Code", LoanApps."Loan Product Type");
                        ProductCharges.SetRange(ProductCharges.Code, 'LINSURANCE');
                        if ProductCharges.Find('-') then begin
                            if ProductCharges."Use Perc" = true then begin
                                Loaninsurance := LoanApps."Approved Amount" * (ProductCharges.Percentage / 100);
                                InsuranceAcc := ProductCharges."G/L Account";

                            end else
                                Loaninsurance := ProductCharges.Amount;
                            InsuranceAcc := ProductCharges."G/L Account";
                        end;

                        //END LOAN INSURANCE------------------------------------

                        //Loaninsurance:=Loaninsurance;
                        LineNo := LineNo + 10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'PAYMENTS';
                        GenJournalLine."Journal Batch Name" := 'LOANS';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Document No." := "Document No.";
                        ;
                        GenJournalLine."Posting Date" := "Posting Date";
                        GenJournalLine."External Document No." := LoanApps."Loan  No.";
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                        GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Loan;
                        GenJournalLine."Account No." := LoanApps."Client Code";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine.Description := 'Loan Insurance - ' + LoanApps."Loan  No." + ' ' + LoanApps."Client Code" + ' ' + LoanApps."Employer Code";
                        GenJournalLine.Amount := ROUND(Loaninsurance, 0.01, '=');
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        //Deductions+=GenJournalLine.Amount;
                        GenJournalLine."Loan No" := LoanApps."Loan  No.";
                        GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                        GenJournalLine."Bal. Account No." := InsuranceAcc;
                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                        GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                        GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Cashier Branch";
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;
                    end;

                    TLoaninsurance := TLoaninsurance + GenJournalLine.Amount * -1;

                    //Loan processing fee (LPF).....
                    ProductCharges.Reset;
                    ProductCharges.SetRange(ProductCharges."Product Code", LoanApps."Loan Product Type");
                    ProductCharges.SetRange(ProductCharges.Code, 'PROCESSSINGFEE');
                    if ProductCharges.Find('-') then begin
                        if ProductCharges."Use Perc" = true then begin
                            LoanProcessingFee := LoanApps."Approved Amount" * (ProductCharges.Percentage / 100);
                            if LoanProcessingFee < ProductCharges."Minimum Amount" then begin
                                LoanProcessingFee := ProductCharges."Minimum Amount"
                            end else
                                LoanProcessingFee := LoanProcessingFee;
                            LoanProcessingFeeAcc := ProductCharges."G/L Account";
                        end else
                            LoanProcessingFee := ProductCharges.Amount;
                        LoanProcessingFeeAcc := ProductCharges."G/L Account";
                    end;

                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                    GenJournalLine."Journal Batch Name" := 'LOANS';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Document No." := "Document No.";
                    ;
                    GenJournalLine."Posting Date" := "Posting Date";
                    GenJournalLine."External Document No." := LoanApps."Loan  No.";
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                    GenJournalLine."Account No." := LoanApps."Client Code";
                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Loan;
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine.Description := 'Loan Processing Fee - ' + LoanApps."Loan  No." + ' ' + LoanApps."Client Code" + ' ' + LoanApps."Employer Code";
                    GenJournalLine.Amount := LoanProcessingFee;    //ROUND(LoanApps."Loan SMS Fee"*-1,0.01,'=');
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    //Deductions+=GenJournalLine.Amount;
                    GenJournalLine."Loan No" := LoanApps."Loan  No.";
                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                    GenJournalLine."Bal. Account No." := LoanProcessingFeeAcc;
                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                    GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Cashier Branch";
                    // IF GenJournalLine.Amount<200 THEN
                    //SMSFee:=200;
                    // MODIFY;
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                    //Loan Appraisal fee (Loan Appraisal).....
                    ProductCharges.Reset;
                    ProductCharges.SetRange(ProductCharges."Product Code", LoanApps."Loan Product Type");
                    ProductCharges.SetRange(ProductCharges.Code, 'LAPPRAISAL');
                    if ProductCharges.Find('-') then begin
                        if ProductCharges."Use Perc" = true then begin
                            LoanProcessingFee := LoanApps."Approved Amount" * (ProductCharges.Percentage / 100);
                            if LoanProcessingFee < ProductCharges."Minimum Amount" then begin
                                LoanProcessingFee := ProductCharges."Minimum Amount"
                            end else
                                LoanProcessingFee := LoanProcessingFee;
                            LoanProcessingFeeAcc := ProductCharges."G/L Account";
                        end else
                            LoanProcessingFee := ProductCharges.Amount;
                        LoanProcessingFeeAcc := ProductCharges."G/L Account";
                    end;

                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                    GenJournalLine."Journal Batch Name" := 'LOANS';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Document No." := "Document No.";
                    ;
                    GenJournalLine."Posting Date" := "Posting Date";
                    GenJournalLine."External Document No." := LoanApps."Loan  No.";
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                    GenJournalLine."Account No." := LoanApps."Client Code";
                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Loan;
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine.Description := 'Loan Appraisal Fee - ' + LoanApps."Loan  No." + ' ' + LoanApps."Client Code" + ' ' + LoanApps."Employer Code";
                    GenJournalLine.Amount := LoanProcessingFee;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    //Deductions+=GenJournalLine.Amount;
                    GenJournalLine."Loan No" := LoanApps."Loan  No.";
                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                    GenJournalLine."Bal. Account No." := LoanProcessingFeeAcc;
                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                    GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Cashier Branch";
                    // IF GenJournalLine.Amount<200 THEN
                    //SMSFee:=200;
                    // MODIFY;
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                    //Sacco Interest (SaccoInt).....

                    if LoanApps."Sacco Interest" > 0 then begin
                        ProductCharges.Reset;
                        ProductCharges.SetRange(ProductCharges."Product Code", LoanApps."Loan Product Type");
                        ProductCharges.SetRange(ProductCharges.Code, 'SACCOINT');
                        if ProductCharges.Find('-') then begin
                            if ProductCharges."Use Perc" = true then begin
                                LoanProcessingFee := LoanApps."Approved Amount" * (ProductCharges.Percentage / 100);
                                if SaccoInterest < ProductCharges."Minimum Amount" then begin
                                    SaccoInterest := ProductCharges."Minimum Amount"
                                end else
                                    SaccoInterest := SaccoInterest;
                                SaccoInterestAccount := ProductCharges."G/L Account";

                                LineNo := LineNo + 10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'PAYMENTS';
                                GenJournalLine."Journal Batch Name" := 'LOANS';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Document No." := "Document No.";
                                ;
                                GenJournalLine."Posting Date" := "Posting Date";
                                GenJournalLine."External Document No." := LoanApps."Loan  No.";
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                                GenJournalLine."Account No." := LoanApps."Client Code";
                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Loan;
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine.Description := 'Sacco Interest - ' + LoanApps."Loan  No." + ' ' + LoanApps."Client Code" + ' ' + LoanApps."Employer Code";
                                GenJournalLine.Amount := LoanApps."Sacco Interest";
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Loan No" := LoanApps."Loan  No.";
                                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                GenJournalLine."Bal. Account No." := SaccoInterestAccount;
                                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                                GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Cashier Branch";
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;
                            end;
                        end;
                    end;

                    //TSC Interest (TSCINT).....
                    ProductCharges.Reset;
                    ProductCharges.SetRange(ProductCharges."Product Code", LoanApps."Loan Product Type");
                    ProductCharges.SetRange(ProductCharges.Code, 'TSCINT');
                    if ProductCharges.Find('-') then begin
                        if ProductCharges."Use Perc" = true then begin
                            TSCInterest := LoanApps."Approved Amount" * (ProductCharges.Percentage / 200) * (LoanApps.Installments + 1);
                            if TSCInterest < ProductCharges."Minimum Amount" then begin
                                TSCInterest := ProductCharges."Minimum Amount"
                            end else
                                TSCInterest := LoanProcessingFee;
                            TSCInterestAc := ProductCharges."G/L Account";
                        end else
                            TSCInterest := ProductCharges.Amount;
                        TSCInterestAc := ProductCharges."G/L Account";
                    end;

                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                    GenJournalLine."Journal Batch Name" := 'LOANS';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Document No." := "Document No.";
                    ;
                    GenJournalLine."Posting Date" := "Posting Date";
                    GenJournalLine."External Document No." := LoanApps."Loan  No.";
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                    GenJournalLine."Account No." := LoanApps."Client Code";
                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Loan;
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine.Description := 'TSC Interest - ' + ' ' + LoanApps."Loan  No." + ' ' + LoanApps."Client Code" + ' ' + LoanApps."Employer Code";
                    GenJournalLine.Amount := TSCInterest;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    //Deductions+=GenJournalLine.Amount;
                    GenJournalLine."Loan No" := LoanApps."Loan  No.";
                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                    GenJournalLine."Bal. Account No." := TSCInterestAc;
                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                    GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Cashier Branch";
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;


                    //Loan Form Fee (FORMFEE).....
                    ProductCharges.Reset;
                    ProductCharges.SetRange(ProductCharges."Product Code", LoanApps."Loan Product Type");
                    ProductCharges.SetRange(ProductCharges.Code, 'FORMFEE');
                    if ProductCharges.Find('-') then begin
                        if ProductCharges."Use Perc" = true then begin
                            LoanProcessingFee := LoanApps."Approved Amount" * (ProductCharges.Percentage / 100);
                            if LoanProcessingFee < ProductCharges."Minimum Amount" then begin
                                LoanProcessingFee := ProductCharges."Minimum Amount"
                            end else
                                LoanProcessingFee := LoanProcessingFee;
                            LoanProcessingFeeAcc := ProductCharges."G/L Account";
                        end else
                            LoanProcessingFee := ProductCharges.Amount;
                        LoanProcessingFeeAcc := ProductCharges."G/L Account";
                    end;

                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                    GenJournalLine."Journal Batch Name" := 'LOANS';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Document No." := "Document No.";
                    ;
                    GenJournalLine."Posting Date" := "Posting Date";
                    GenJournalLine."External Document No." := LoanApps."Loan  No.";
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                    GenJournalLine."Account No." := LoanApps."Client Code";
                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Loan;
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine.Description := 'Loan Form Fee - ' + LoanApps."Loan  No." + ' ' + LoanApps."Client Code" + ' ' + LoanApps."Employer Code";
                    GenJournalLine.Amount := LoanProcessingFee;    //ROUND(LoanApps."Loan SMS Fee"*-1,0.01,'=');
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    //Deductions+=GenJournalLine.Amount;
                    GenJournalLine."Loan No" := LoanApps."Loan  No.";
                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                    GenJournalLine."Bal. Account No." := LoanProcessingFeeAcc;
                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                    GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Cashier Branch";
                    // IF GenJournalLine.Amount<200 THEN
                    //SMSFee:=200;
                    // MODIFY;
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;


                    //Loan Application Fee (LAPPLICATION).....
                    ProductCharges.Reset;
                    ProductCharges.SetRange(ProductCharges."Product Code", LoanApps."Loan Product Type");
                    ProductCharges.SetRange(ProductCharges.Code, 'LAPPLICATION');
                    if ProductCharges.Find('-') then begin
                        if ProductCharges."Use Perc" = true then begin
                            LApplicationFee := LoanApps."Approved Amount" * (ProductCharges.Percentage / 100);
                            if LApplicationFee < ProductCharges."Minimum Amount" then begin
                                LApplicationFee := ProductCharges."Minimum Amount"
                            end else
                                LApplicationFee := LApplicationFee;
                            LApplicationFeeAcc := ProductCharges."G/L Account";
                        end else
                            LoanProcessingFee := ProductCharges.Amount;
                        LoanProcessingFeeAcc := ProductCharges."G/L Account";
                    end;

                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                    GenJournalLine."Journal Batch Name" := 'LOANS';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Document No." := "Document No.";
                    ;
                    GenJournalLine."Posting Date" := "Posting Date";
                    GenJournalLine."External Document No." := LoanApps."Loan  No.";
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                    GenJournalLine."Account No." := LoanApps."Client Code";
                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Loan;
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine.Description := 'Loan Application Fee - ' + ' ' + LoanApps."Loan  No." + ' ' + LoanApps."Employer Code" + ' ' + LoanApps."Client Code";
                    GenJournalLine.Amount := LApplicationFee;    //ROUND(LoanApps."Loan SMS Fee"*-1,0.01,'=');
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    //Deductions+=GenJournalLine.Amount;
                    GenJournalLine."Loan No" := LoanApps."Loan  No.";
                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                    GenJournalLine."Bal. Account No." := LApplicationFeeAcc;
                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                    GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Cashier Branch";
                    // IF GenJournalLine.Amount<200 THEN
                    //SMSFee:=200;
                    // MODIFY;
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;

                    //Accrued Interest (ACCRUEDINT).....
                    ProductCharges.Reset;
                    ProductCharges.SetRange(ProductCharges."Product Code", LoanApps."Loan Product Type");
                    ProductCharges.SetRange(ProductCharges.Code, 'ACCRUEDINT');
                    if ProductCharges.Find('-') then begin
                        if ProductCharges."Use Perc" = true then begin
                            AccruedInt := LoanApps."Approved Amount" * (ProductCharges.Percentage / 100);// *(LoanApps.Installments+1);
                            if AccruedInt < ProductCharges."Minimum Amount" then begin
                                AccruedInt := ProductCharges."Minimum Amount"
                            end else
                                AccruedInt := AccruedInt;
                            AccruedIntAcc := ProductCharges."G/L Account";
                        end else
                            AccruedInt := ProductCharges.Amount;
                        AccruedIntAcc := ProductCharges."G/L Account";
                    end;

                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                    GenJournalLine."Journal Batch Name" := 'LOANS';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Document No." := "Document No.";
                    ;
                    GenJournalLine."Posting Date" := "Posting Date";
                    GenJournalLine."External Document No." := LoanApps."Loan  No.";
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                    GenJournalLine."Account No." := LoanApps."Client Code";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine.Description := 'Accrued Interest - ' + ' ' + LoanApps."Loan  No." + ' ' + LoanApps."Client Code" + ' ' + LoanApps."Employer Code";
                    GenJournalLine.Amount := AccruedInt;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    //Deductions+=GenJournalLine.Amount;
                    GenJournalLine."Loan No" := LoanApps."Loan  No.";
                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                    GenJournalLine."Bal. Account No." := AccruedIntAcc;
                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                    GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Cashier Branch";
                    // IF GenJournalLine.Amount<200 THEN
                    //SMSFee:=200;
                    // MODIFY;
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;


                    //Interest Capitalized  (INTUPFRONT).....
                    if (LoanApps.Installments <= 12) then begin
                        IntCapitalizationFactor := 1
                    end else
                        IntCapitalizationFactor := 2;


                    ProductCharges.Reset;
                    ProductCharges.SetRange(ProductCharges."Product Code", LoanApps."Loan Product Type");
                    ProductCharges.SetRange(ProductCharges.Code, 'INTUPFRONT');
                    if ProductCharges.Find('-') then begin
                        if ProductCharges."Use Perc" = true then begin
                            IntCapitalized := (LoanApps."Approved Amount" * (ProductCharges.Percentage / 100)) * IntCapitalizationFactor;// *(LoanApps.Installments+1);
                            if IntCapitalized < ProductCharges."Minimum Amount" then begin
                                IntCapitalized := ProductCharges."Minimum Amount"
                            end else
                                IntCapitalized := IntCapitalized;
                            IntCapitalizedAcc := ProductCharges."G/L Account";
                        end else
                            IntCapitalized := ProductCharges.Amount;
                        IntCapitalizedAcc := ProductCharges."G/L Account";
                    end;

                    LineNo := LineNo + 10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name" := 'PAYMENTS';
                    GenJournalLine."Journal Batch Name" := 'LOANS';
                    GenJournalLine."Line No." := LineNo;
                    GenJournalLine."Document No." := "Document No.";
                    ;
                    GenJournalLine."Posting Date" := "Posting Date";
                    GenJournalLine."External Document No." := LoanApps."Loan  No.";
                    GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                    GenJournalLine."Account No." := LoanApps."Client Code";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine.Description := 'Interest Capitalized - ' + ' ' + LoanApps."Loan  No." + ' ' + LoanApps."Client Code" + ' ' + LoanApps."Employer Code";
                    GenJournalLine.Amount := IntCapitalized;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    //Deductions+=GenJournalLine.Amount;
                    GenJournalLine."Loan No" := LoanApps."Loan  No.";
                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                    GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Interest Paid";
                    GenJournalLine."Bal. Account No." := IntCapitalizedAcc;
                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                    GenJournalLine."Shortcut Dimension 1 Code" := DActivity;
                    GenJournalLine."Shortcut Dimension 2 Code" := LoanApps."Cashier Branch";
                    // IF GenJournalLine.Amount<200 THEN
                    //SMSFee:=200;
                    // MODIFY;
                    if GenJournalLine.Amount <> 0 then
                        GenJournalLine.Insert;



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
                        if Cust.Get(LoanTopUp."Client Code") then begin

                            //Loans."Staff No":=customer."Payroll/Staff No";

                            DataSheet.Init;
                            DataSheet."PF/Staff No" := LoanTopUp."Staff No";
                            DataSheet."Type of Deduction" := LoanTypes."Product Description";
                            DataSheet."Remark/LoanNO" := LoanTopUp."Loan Top Up";
                            DataSheet.Name := LoanApps."Client Code";
                            DataSheet."ID NO." := LoanApps."ID NO";
                            DataSheet."Amount ON" := 0;
                            DataSheet."Amount OFF" := LoanTopUp."Total Top Up";
                            DataSheet."REF." := '2026';
                            DataSheet."New Balance" := 0;
                            DataSheet.Date := Loans."Issued Date";
                            DataSheet.Employer := Customer."Employer Code";
                            DataSheet."Repayment Method" := Customer."Repayment Method";
                            DataSheet."Transaction Type" := DataSheet."transaction type"::ADJUSTMENT;
                            DataSheet."Sort Code" := PTEN;
                            DataSheet.Insert;
                        end;
                    end;

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



                    Loans."Staff No" := Customer."Personal No";
                    DataSheet.Init;
                    DataSheet."PF/Staff No" := LoanApps."Staff No";
                    DataSheet."Type of Deduction" := LoanApps."Loan Product Type";
                    DataSheet."Remark/LoanNO" := LoanApps."Loan  No.";
                    DataSheet.Name := LoanApps."Client Code";
                    DataSheet."ID NO." := LoanApps."ID NO";
                    DataSheet."Principal Amount" := LoanApps."Loan Principle Repayment";
                    DataSheet."Interest Amount" := LoanApps."Loan Interest Repayment";
                    DataSheet."Amount ON" := ROUND(LoanApps."Loan Repayment", 5, '>');
                    //ROUND(LBalance / 100 / 12 * InterestRate,0.05,'>');
                    DataSheet."REF." := '2026';
                    DataSheet."Batch No." := "Batch No.";
                    DataSheet."New Balance" := LoanApps."Approved Amount";
                    DataSheet."Repayment Method" := Customer."Repayment Method";
                    DataSheet.Date := LoanApps."Issued Date";
                    if Customer.Get(LoanApps."Client Code") then begin
                        DataSheet.Employer := Customer."Employer Code";
                    end;
                    DataSheet."Sort Code" := PTEN;
                    DataSheet.Insert;
                    //END;
                    //END;

                    LoanApps."Issued Date" := Today;
                    LoanApps."Loan Status" := LoanApps."loan status"::Issued;
                    LoanApps.Posted := true;
                    LoanApps.Modify;
                //Generate Data Sheet Advice
                until LoanApps.Next = 0;
            end;
        end;


        //End of Disburesment to FOSA******************************************************



        //Post New

        GenJournalLine.Reset;
        GenJournalLine.SetRange("Journal Template Name", 'PAYMENTS');
        GenJournalLine.SetRange("Journal Batch Name", 'LOANS');
        if GenJournalLine.Find('-') then begin
            //CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Sacco",GenJournalLine);
        end;
        LoanApps."Issued Date" := Today;
        LoanApps."Loan Status" := LoanApps."loan status"::Issued;
        LoanApps.Posted := true;
        LoanApps.Modify;

        GenSetUp.Get();
        //Send Loan Disburesment SMS*********************************************
        if GenSetUp."Send Loan Disbursement SMS" = true then begin
            FnSendDisburesmentSMS(LoanApps."Loan  No.", LoanApps."Client Code");
        end;
        //Send Loan Disburesment Email*******************************************
        if GenSetUp."Send Loan Disbursement Email" = true then begin
            FnSendDisburesmentEmail(LoanApps."Loan  No.");
        end;
        Posted := true;
        Modify;

        Message('Batch posted successfully.');
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
                    TotalMRepay := ROUND((InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -RepayPeriod)) * LoanAmount, 1, '>');
                    TotalMRepay := (InterestRate / 12 / 100) / (1 - Power((1 + (InterestRate / 12 / 100)), -RepayPeriod)) * LoanAmount;
                    LInterest := ROUND(LBalance / 100 / 12 * InterestRate);

                    LPrincipal := TotalMRepay - LInterest;
                end;



                if LoansR."Repayment Method" = LoansR."repayment method"::"Straight Line" then begin
                    LoansR.TestField(Installments);
                    LPrincipal := ROUND(LoanAmount / RepayPeriod, 1, '>');
                    if (LoansR."Loan Product Type" = 'INST') or (LoansR."Loan Product Type" = 'MAZAO') then begin
                        LInterest := 0;
                    end else begin
                        LInterest := ROUND((InterestRate / 1200) * LoanAmount, 1, '>');
                    end;

                    LoansR."Loan Repayment" := LPrincipal + LInterest;
                    LoansR."Loan Principle Repayment" := LPrincipal;
                    LoansR."Loan Interest Repayment" := LInterest;
                end;


                if LoansR."Repayment Method" = LoansR."repayment method"::"Reducing Balance" then begin
                    LoansR.TestField(Interest);
                    LoansR.TestField(Installments);
                    LPrincipal := ROUND(LoanAmount / RepayPeriod, 1, '>');
                    LInterest := ROUND((InterestRate / 12 / 100) * LBalance, 1, '>');
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

                NLInterest := ROUND(LoansR."Approved Amount" * LoansR.Interest / 12 * (RepayPeriod + 1) / (200 * RepayPeriod), 1, '>'); //For Nafaka Only
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
                //RSchedule."Monthly Interest Reducing":=ROUND(LInterest,1,'>');
                //RSchedule."Interest Variance":=InterestVarianceOnlyNafaka;
                RSchedule."Principal Repayment" := LPrincipal;
                RSchedule."Loan Balance" := ScheduleBal;
                RSchedule.Insert;
                WhichDay := Date2dwy(RSchedule."Repayment Date", 1);


            until LBalance < 1

        end;
        Commit;
    end;
}

