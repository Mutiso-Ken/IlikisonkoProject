#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516659 "Checkoff Processing Header-D2"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Checkoff Header-Distributed2";
    SourceTableView = where(Posted = const(false));

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; No)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Entered By"; "Entered By")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Date Entered"; "Date Entered")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Posting date"; "Posting date")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Loan CutOff Date"; "Loan CutOff Date")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Remarks; Remarks)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Posted By"; "Posted By")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Account Type"; "Account Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account No"; "Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Employer Code"; "Employer Code")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        if "Employer Code" <> '' then begin
                            BufferTable.Reset;
                            BufferTable.SetRange(BufferTable.UserId, UserId);
                            if BufferTable.Find('-') then begin
                                BufferTable.DeleteAll;
                            end;
                            BufferTable.Init;
                            BufferTable.UserId := UserId;
                            BufferTable.EmployerCode := "Employer Code";
                            BufferTable.Insert;
                        end;
                    end;
                }
                field("Employer Name"; "Employer Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Document No"; "Document No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Document No./ Cheque No.';
                    ShowMandatory = true;
                }
                field("CheckOff Period"; "CheckOff Period")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field(Posted; Posted)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Total Scheduled"; "Total Scheduled")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                    Importance = Promoted;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Total Count"; "Total Count")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                    Importance = Promoted;
                    Style = Favorable;
                    StyleExpr = true;
                }
            }
            part("Checkoff Lines-Distributed"; "Checkoff Processing Lines-D2")
            {
                Caption = 'Checkoff Lines-Distributed';
                SubPageLink = "Receipt Header No" = field(No);
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Clear Lines")
            {
                ApplicationArea = Basic;
                Enabled = ActionEnabled;
                Image = CheckList;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                var
                    ReceiptLine: Record "Checkoff Lines-Distributed2";
                begin
                    if Confirm('This Action will clear all the Lines for the current Check off. Do you want to Continue') = false then
                        exit;
                    ReceiptLine.Reset;
                    ReceiptLine.SetRange(ReceiptLine."Receipt Header No", No);
                    ReceiptLine.DeleteAll;

                    BATCH_TEMPLATE := 'GENERAL';
                    BATCH_NAME := 'CHECKOFF';
                    DOCUMENT_NO := Remarks;
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                    GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                    GenJournalLine.DeleteAll;
                end;
            }
            action("Checkoff Template")
            {
                ApplicationArea = Basic;
                Caption = 'Checkof Template';
                Enabled = ActionEnabled;
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = XMLport "Import Checkoff Distributed3";

                trigger OnAction()
                begin
                    // ReceiptLine.RESET;
                    // ReceiptLine.SETRANGE(ReceiptLine."Receipt Header No",No);
                    // IF FINDSET THEN
                    //  ReceiptLine.DELETEALL;
                end;
            }
            action("Import Checkoff Distributed")
            {
                ApplicationArea = Basic;
                Caption = 'Import Checkoff';
                Enabled = ActionEnabled;
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = XMLport "Import Checkoff Distributed2";

                trigger OnAction()
                var
                    ReceiptLine: Record "Checkoff Lines-Distributed2";
                begin
                    ReceiptLine.Reset;
                    ReceiptLine.SetRange(ReceiptLine."Receipt Header No", No);
                    if FindSet then
                        ReceiptLine.DeleteAll;
                end;
            }
            group(ActionGroup1102755021)
            {
            }
            action("Validate Checkoff")
            {
                ApplicationArea = Basic;
                Caption = 'Validate Checkoff';
                Enabled = ActionEnabled;
                Image = ViewCheck;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                var
                    PrincipalLoan: Decimal;
                    EmergencyLoan1: Decimal;
                    EmergencyLoan2: Decimal;
                    InstantLoan: Decimal;
                    ElimuLoan: Decimal;
                    MjengoLoan: Decimal;
                    VisionLoan: Decimal;
                    KHLLoan: Decimal;
                    KaribuLoan: Decimal;
                    KanisaSavings: Decimal;
                    DepositContribution: Decimal;
                    ShareCapital: Decimal;
                    EntranceFees: Decimal;
                    CarLoan: Decimal;
                    SukumaMwezi: Decimal;
                    TrusteeLoan: Decimal;
                    IDLLoan: Decimal;
                    CompanyInfo: Record "Company Information";
                    PeriodName: Text;
                    ObjCheckoffLines: Record "Checkoff Lines-Distributed2";
                    TotalAmount: Decimal;
                    TotalLines: Decimal;
                    MaliMaliLoan: Decimal;
                    DiasporaLoan: Decimal;
                    ReceiptLine: Record "Checkoff Lines-Distributed2";
                begin
                    BATCH_TEMPLATE := 'GENERAL';
                    BATCH_NAME := 'CHECKOFF';
                    DOCUMENT_NO := Remarks;

                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                    GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                    GenJournalLine.DeleteAll;

                    MembLedg.Reset;
                    MembLedg.SetRange(MembLedg."Document No.", "Document No");
                    if MembLedg.Find('-') = true then
                        Error('Sorry,You have already posted this Document. Validation not Allowed.');


                    ReceiptLine.Reset;
                    ReceiptLine.SetRange(ReceiptLine."Receipt Header No", No);
                    if ReceiptLine.FindSet(true, true) then begin//--1--
                        Window.Open('@1@');
                        TotalCount := ReceiptLine.Count;
                        repeat
                            FnUpdateProgressBar();
                            ReceiptLine.Validate(ReceiptLine."Member No.");
                        until ReceiptLine.Next = 0;
                        Window.Close;
                        Message('Validation was successfully completed.');
                    end;//--1--

                    //Variables
                    MemberTotal := 0;

                    //Validate Amounts
                    ObjCheckoffLines.Reset;
                    ObjCheckoffLines.SetRange(ObjCheckoffLines."Receipt Header No", No);
                    if ObjCheckoffLines.Find('-') then begin//--2--
                        repeat
                            MemberTotal := ObjCheckoffLines."Share Capital" + ObjCheckoffLines."Deposit contribution" + ObjCheckoffLines."Entrance Fees"
                            + ObjCheckoffLines."Principal Loan" + ObjCheckoffLines."Emergency 1 Loan" + ObjCheckoffLines."Emergency 2 Loan"
                            + ObjCheckoffLines."Instant Loan" + ObjCheckoffLines."Elimu Loan" + ObjCheckoffLines."Mjengo Loan" + ObjCheckoffLines."Vision Loan" +
                            ObjCheckoffLines."KHL Loan" + ObjCheckoffLines."Car Loan" + ObjCheckoffLines."Sukuma Mwezi Loan" + ObjCheckoffLines."Trustee Loan" +
                            ObjCheckoffLines."IDL Loan" + ObjCheckoffLines."Karibu Loan" + ObjCheckoffLines."Mali Mali Loan" + ObjCheckoffLines."Dispora Loan" +
                            ObjCheckoffLines."Jiokoe Savings";

                        //IF MemberTotal<>ObjCheckoffLines.Amount THEN
                        // ERROR('Amount for Staff/Payroll No '+ObjCheckoffLines."Staff/Payroll No"+' and the total breakdown must be the the same');
                        until ObjCheckoffLines.Next = 0;
                    end;//--2--

                    ObjCheckoffLines.Reset;
                    ObjCheckoffLines.SetRange(ObjCheckoffLines."Receipt Header No", No);
                    if ObjCheckoffLines.FindSet then begin
                        ObjCheckoffLines.CalcSums(ObjCheckoffLines."Share Capital", ObjCheckoffLines."Deposit contribution", ObjCheckoffLines."Entrance Fees",
                        ObjCheckoffLines."Principal Loan", ObjCheckoffLines."Emergency 1 Loan", ObjCheckoffLines."Emergency 2 Loan", ObjCheckoffLines."Instant Loan",
                        ObjCheckoffLines."Elimu Loan", ObjCheckoffLines."Mjengo Loan", ObjCheckoffLines."Vision Loan", ObjCheckoffLines."KHL Loan",
                        ObjCheckoffLines."Car Loan", ObjCheckoffLines."Sukuma Mwezi Loan", ObjCheckoffLines."Trustee Loan", ObjCheckoffLines."IDL Loan",
                        ObjCheckoffLines."Karibu Loan", ObjCheckoffLines."Mali Mali Loan", ObjCheckoffLines."Dispora Loan", ObjCheckoffLines."Jiokoe Savings");


                        DepositContribution := ObjCheckoffLines."Deposit contribution";
                        ShareCapital := ObjCheckoffLines."Share Capital";
                        EntranceFees := ObjCheckoffLines."Entrance Fees";
                        PrincipalLoan := ObjCheckoffLines."Principal Loan";
                        EmergencyLoan1 := ObjCheckoffLines."Emergency 1 Loan";
                        EmergencyLoan2 := ObjCheckoffLines."Emergency 2 Loan";
                        InstantLoan := ObjCheckoffLines."Instant Loan";
                        VisionLoan := ObjCheckoffLines."Vision Loan";
                        MjengoLoan := ObjCheckoffLines."Mjengo Loan";
                        KHLLoan := ObjCheckoffLines."KHL Loan";
                        IDLLoan := ObjCheckoffLines."IDL Loan";
                        KaribuLoan := ObjCheckoffLines."Karibu Loan";
                        SukumaMwezi := ObjCheckoffLines."Sukuma Mwezi Loan";
                        TrusteeLoan := ObjCheckoffLines."Trustee Loan";
                        CarLoan := ObjCheckoffLines."Car Loan";
                        VisionLoan := ObjCheckoffLines."Vision Loan";
                        MaliMaliLoan := ObjCheckoffLines."Mali Mali Loan";
                        DiasporaLoan := ObjCheckoffLines."Dispora Loan";
                        KanisaSavings := ObjCheckoffLines."Jiokoe Savings";

                        ObjCheckoffLines.CalcSums(ObjCheckoffLines.Amount);
                        TotalAmount := ObjCheckoffLines.Amount;
                        TotalLines := DepositContribution + ShareCapital + EntranceFees + PrincipalLoan + EmergencyLoan1 + EmergencyLoan2 + InstantLoan + VisionLoan +
                        MjengoLoan + KHLLoan + IDLLoan + KaribuLoan + SukumaMwezi + TrusteeLoan + CarLoan + VisionLoan + MaliMaliLoan + DiasporaLoan + KanisaSavings;
                    end;
                end;
            }
            group(ActionGroup1102755019)
            {
            }
            action("Process Checkoff Distributed")
            {
                ApplicationArea = Basic;
                Caption = 'Process Checkoff';
                Enabled = ActionEnabled;
                Image = Apply;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                var
                    LoanT: Record "Loans Register";
                    LoanProdType: Code[30];
                    ObjCheckoffLines: Record "Checkoff Lines-Distributed2";
                    ObjMember: Record "Member Register";
                    RegFees: Decimal;
                    ReceiptLine: Record "Checkoff Lines-Distributed2";
                begin
                    if "Posting date" = 0D then
                        Error('Posting Date cannot be blank');
                    ObjCheckoffLines.Reset;
                    ObjCheckoffLines.SetRange(ObjCheckoffLines."Receipt Header No", No);
                    if ObjCheckoffLines.FindSet then begin
                        ObjCheckoffLines.CalcSums(ObjCheckoffLines.Amount);
                        Amount := ObjCheckoffLines.Amount;
                    end;
                    CalcFields("Total Scheduled");
                    if "Total Scheduled" <> Amount then
                        if Confirm('Total schedule is not equal to cheque amount, do you wish to continue?') = false then
                            exit;
                    if Confirm('Are you sure you want to Transfer this Checkoff to Journals ?') = true then begin
                        TestField("Document No");

                        Temp.Get(UserId);
                        Jtemplate := Temp."Checkoff Journal Template";
                        JBatch := Temp."Checkoff Jouranl Batch";

                        if Jtemplate = '' then begin
                            Error('Ensure the Checkoff Template is set up in Cash Office Setup');
                        end;

                        if JBatch = '' then begin
                            Error('Ensure the Checkoff Batch is set up in the Cash Office Setup')
                        end;


                        Datefilter := '..' + Format("Loan CutOff Date");

                        MembLedg.Reset;
                        MembLedg.SetRange(MembLedg."Document No.", Remarks);
                        MembLedg.SetRange(MembLedg.Reversed, false);
                        if MembLedg.Find('-') = true then
                            //ERROR('Sorry,You have already posted this Document. Validation not Allowed.');

                            BATCH_TEMPLATE := 'GENERAL';
                        BATCH_NAME := 'CHECKOFF';
                        DOCUMENT_NO := Remarks;
                        Counter := 0;
                        Percentage := 0;
                        TotalCount := 0;
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name", Jtemplate);
                        GenJournalLine.SetRange("Journal Batch Name", JBatch);
                        GenJournalLine.DeleteAll;

                        //LineNo:=0;

                        ReceiptLine.Reset;
                        ReceiptLine.SetRange("Receipt Header No", No);
                        //ReceiptLine.SETRANGE("Member No.",'KS00560');
                        if ReceiptLine.Find('-') then begin//1
                            Window.Open('@1@');
                            TotalCount := ReceiptLine.Count;
                            repeat
                                FnUpdateProgressBar();
                                UnallocatedFunds := 0;
                                //Deposits
                                LineNo := LineNo + 10000;
                                SURESTEPFactory.FnCreateGnlJournalLine(Jtemplate, JBatch, No, LineNo, GenJournalLine."transaction type"::"Deposit Contribution", GenJournalLine."account type"::Member,
                                                                     ReceiptLine."Member No.", "Posting date", -ReceiptLine."Deposit contribution", 'BOSA', '', 'Deposit contribution Checkoff for ' +
                                                                     KnGetPeriodDescription("CheckOff Period"), '');
                                //share capital
                                LineNo := LineNo + 10000;
                                SURESTEPFactory.FnCreateGnlJournalLine(Jtemplate, JBatch, No, LineNo, GenJournalLine."transaction type"::"Share Capital", GenJournalLine."account type"::Member,
                                                                     ReceiptLine."Member No.", "Posting date", -ReceiptLine."Share Capital", 'BOSA', '', 'Shares capital checkoff for ' + KnGetPeriodDescription("CheckOff Period"), '');

                                //E/fess
                                RegFees := 0;
                                if ObjMember.Get(ReceiptLine."Member No.") then begin
                                    ObjMember.CalcFields(ObjMember."Registration Fee Paid");
                                    if ReceiptLine."Entrance Fees" > 0 then begin
                                        if ObjMember."Registration Fee Paid" < 0 then begin
                                            RegFees := ObjMember."Registration Fee Paid";
                                            UnallocatedFunds := ReceiptLine."Entrance Fees" + RegFees;
                                        end else
                                            UnallocatedFunds := ReceiptLine."Entrance Fees";
                                    end;
                                end;
                                LineNo := LineNo + 10000;
                                SURESTEPFactory.FnCreateGnlJournalLine(Jtemplate, JBatch, No, LineNo, GenJournalLine."transaction type"::"Registration Fee", GenJournalLine."account type"::Member,
                                                                     ReceiptLine."Member No.", "Posting date", RegFees, 'BOSA', '', 'Entrance fees checkoff for' + KnGetPeriodDescription("CheckOff Period"), '');

                                //Jiokoe Savings
                                LineNo := LineNo + 10000;
                                SURESTEPFactory.FnCreateGnlJournalLine(Jtemplate, JBatch, No, LineNo, GenJournalLine."transaction type"::"CRB Fees", GenJournalLine."account type"::Member,
                                                                     ReceiptLine."Member No.", "Posting date", -ReceiptLine."Jiokoe Savings", 'BOSA', '', 'Jiokoe Savings checkoff for' + KnGetPeriodDescription("CheckOff Period"), '');


                                LoanProductsSetup.Reset;
                                LoanProductsSetup.SetFilter(LoanProductsSetup.Code, '<>%1', '');
                                if LoanProductsSetup.Find('-') then begin

                                    repeat
                                        UnallocatedPerLoanProd := 0;
                                        InsurancePerProduct := 0;
                                        InstantAmoun1 := 0;
                                        InstantAmount2 := 0;
                                        EmergencyAmount1 := 0;
                                        EmergencyAmount2 := 0;
                                        InsuranceInstant1 := 0;
                                        InsuranceInstant2 := 0;
                                        CountInstant := 0;
                                        CountEmergency := 0;
                                        case LoanProductsSetup.Code of

                                            'PRINCIPAL':
                                                begin
                                                    UnallocatedPerLoanProd := ReceiptLine."Principal Loan";
                                                    InsurancePerProduct := ReceiptLine."Principal Insurance";
                                                    LoanProdType := LoanProductsSetup.Code;
                                                end;
                                            'EMERGENCY':
                                                begin
                                                    LoanProdType := LoanProductsSetup.Code;
                                                    UnallocatedFunds := UnallocatedFunds + FnEmergencyLoan(ReceiptLine, 'EMERGENCY');
                                                end;
                                            'INSTANT':
                                                begin
                                                    LoanProdType := LoanProductsSetup.Code;
                                                    UnallocatedFunds := UnallocatedFunds + FnInstantLoan(ReceiptLine, 'INSTANT');
                                                end;
                                            'MJENGO':
                                                begin
                                                    UnallocatedPerLoanProd := ReceiptLine."Mjengo Loan";
                                                    InsurancePerProduct := ReceiptLine."Mjengo Loan Insurance";
                                                    LoanProdType := LoanProductsSetup.Code;
                                                end;
                                            'VISION':
                                                begin
                                                    UnallocatedPerLoanProd := ReceiptLine."Vision Loan";
                                                    InsurancePerProduct := ReceiptLine."Vision Loan Insurance";
                                                    LoanProdType := LoanProductsSetup.Code;
                                                end;
                                            'SUKUMA':
                                                begin
                                                    UnallocatedPerLoanProd := ReceiptLine."Sukuma Mwezi Loan";
                                                    LoanProdType := LoanProductsSetup.Code;
                                                end;
                                            'KHL':
                                                begin
                                                    UnallocatedPerLoanProd := ReceiptLine."KHL Loan";
                                                    InsurancePerProduct := ReceiptLine."KHL Loan Insurance";
                                                    LoanProdType := LoanProductsSetup.Code;
                                                end;
                                            'CAR':
                                                begin
                                                    UnallocatedPerLoanProd := ReceiptLine."Car Loan";
                                                    InsurancePerProduct := ReceiptLine."Car Loan Insurance";
                                                    LoanProdType := LoanProductsSetup.Code;
                                                end;
                                            'ELIMU':
                                                begin
                                                    UnallocatedPerLoanProd := ReceiptLine."Elimu Loan";
                                                    InsurancePerProduct := ReceiptLine."Elimu Loan Insurance";
                                                    LoanProdType := LoanProductsSetup.Code;
                                                end;
                                            'MALIMALI':
                                                begin
                                                    UnallocatedPerLoanProd := ReceiptLine."Mali Mali Loan";
                                                    InsurancePerProduct := ReceiptLine."Mali Mali Loan Insurance";
                                                    LoanProdType := LoanProductsSetup.Code;
                                                end;
                                            'MOTOR':
                                                begin
                                                    UnallocatedPerLoanProd := ReceiptLine."Motor Vehicle Insurance";
                                                    LoanProdType := LoanProductsSetup.Code;
                                                end;
                                        end;
                                        if (LoanProdType <> 'EMERGENCY') and (LoanProdType <> 'INSTANT') then begin
                                            if (UnallocatedPerLoanProd >= 0) then begin
                                                //Begin Loan Product
                                                LoanT.Reset;
                                                LoanT.SetRange(LoanT."Client Code", ReceiptLine."Member No.");
                                                LoanT.SetRange(LoanT."Loan Product Type", LoanProdType);
                                                if LoanT.Find('-') then begin
                                                    repeat
                                                        LoanT.CalcFields(LoanT."Outstanding Balance");
                                                        if LoanT."Outstanding Balance" > 0 then begin
                                                            // intC:=LoanT.COUNT;

                                                            if InsurancePerProduct > 0 then begin

                                                                //Loan Insurance
                                                                LineNo := LineNo + 10000;
                                                                SURESTEPFactory.FnCreateGnlJournalLine(Jtemplate, JBatch, No, LineNo, GenJournalLine."transaction type"::"Loan Insurance Charged", GenJournalLine."account type"::Member,
                                                                                                     ReceiptLine."Member No.", "Posting date", -InsurancePerProduct, 'BOSA', '', 'Loan Insurance checkoff for ' + KnGetPeriodDescription("CheckOff Period"), LoanT."Loan  No.");

                                                            end;

                                                            if UnallocatedPerLoanProd > 0 then begin
                                                                AmountToPay := 0;
                                                                InterestTopay := 0;
                                                                InterestTopay := KNFactory.KnGetInterestBalanceOneLoan(LoanT."Loan  No.");
                                                                if InterestTopay < 0 then InterestTopay := 0;
                                                                if InterestTopay > UnallocatedPerLoanProd then begin
                                                                    InterestTopay := UnallocatedPerLoanProd
                                                                end else begin
                                                                    AmountToPay := UnallocatedPerLoanProd - InterestTopay;
                                                                end;

                                                                if InterestTopay < 0 then
                                                                    InterestTopay := 0;
                                                                LineNo := LineNo + 10000;
                                                                AmountToPay := FnGetLoanAmountToPay(AmountToPay, LoanT."Loan  No.");
                                                                if AmountToPay < 0 then AmountToPay := 0;

                                                                //Loan Principal
                                                                SURESTEPFactory.FnCreateGnlJournalLine(Jtemplate, JBatch, No, LineNo, GenJournalLine."transaction type"::"Loan Repayment", GenJournalLine."account type"::Member,
                                                                                                     ReceiptLine."Member No.", "Posting date", -AmountToPay, 'BOSA', '', 'loan repayment checkoff for ' + KnGetPeriodDescription("CheckOff Period"), LoanT."Loan  No.");
                                                                //Loan Interest
                                                                LineNo := LineNo + 10000;
                                                                SURESTEPFactory.FnCreateGnlJournalLine(Jtemplate, JBatch, No, LineNo, GenJournalLine."transaction type"::"Interest Paid", GenJournalLine."account type"::Member,
                                                                                                     ReceiptLine."Member No.", "Posting date", -InterestTopay, 'BOSA', '', 'Interest payment checkoff for ' + KnGetPeriodDescription("CheckOff Period"), LoanT."Loan  No.");

                                                                UnallocatedPerLoanProd := UnallocatedPerLoanProd - AmountToPay - InterestTopay;
                                                            end;// IF UnallocatedPerLoanProd>0
                                                        end;//IF LoanT."Outstanding Balance">0
                                                    until LoanT.Next = 0;
                                                    if UnallocatedPerLoanProd > 0 then begin
                                                        UnallocatedFunds := UnallocatedFunds + UnallocatedPerLoanProd;
                                                        UnallocatedPerLoanProd := 0;
                                                    end;
                                                end;//LoanT
                                            end;//Outer UnallocatedPerLoanProd>0
                                            if UnallocatedPerLoanProd > 0 then
                                                UnallocatedFunds := UnallocatedFunds + UnallocatedPerLoanProd + InsurancePerProduct;
                                        end;//end of not equal to emergency and instant loans
                                    until LoanProductsSetup.Next = 0;
                                end;//END LoanProductsSetup


                                //Unallocated Funds
                                LineNo := LineNo + 10000;
                                SURESTEPFactory.FnCreateGnlJournalLine(Jtemplate, JBatch, No, LineNo, GenJournalLine."transaction type"::"Unallocated Funds", GenJournalLine."account type"::Member,
                                                                     ReceiptLine."Member No.", "Posting date", -UnallocatedFunds, 'BOSA', '', 'Unallocated Funds checkoff for ' + KnGetPeriodDescription("CheckOff Period"), '');

                            until ReceiptLine.Next = 0;
                        end;//1

                        //Balance
                        LineNo := LineNo + 10000;
                        SURESTEPFactory.FnCreateGnlJournalLine(Jtemplate, JBatch, No, LineNo, GenJournalLine."transaction type"::" ", GenJournalLine."account type"::Customer,
                                                               "Account No", "Posting date", "Total Scheduled", 'BOSA', '', 'Checkoff balancing off for ' + KnGetPeriodDescription("CheckOff Period"), '');

                        Window.Close;

                        //  Gnljnline.RESET;
                        //  Gnljnline.SETRANGE("Journal Template Name",Jtemplate);
                        //  Gnljnline.SETRANGE("Journal Batch Name",JBatch);
                        //  IF Gnljnline.FIND('-') THEN BEGIN
                        //   CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch",Gnljnline);
                        //  END;
                        //  Posted:=TRUE;
                        //  MODIFY;
                        //  COMMIT;
                        Message('Checkoff successfully Generated.Jouranls ready for posting');

                    end;
                    //    ReptProcHeader.RESET;
                    //    ReptProcHeader.SETRANGE(ReptProcHeader.No,No);
                    //    IF ReptProcHeader.FIND('-') THEN
                    //    REPORT.RUN(51516972,TRUE,FALSE,ReptProcHeader);
                end;
            }
            action("Mark as Posted")
            {
                ApplicationArea = Basic;
                Image = PostBatch;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to mark this Checkoff as Posted ?', false) = true then begin
                        MembLedg.Reset;
                        MembLedg.SetRange(MembLedg."Document No.", No);
                        if MembLedg.Find('-') = false then
                            Error('Sorry,you can only execute this action when the checkoff has already been posted.');
                        Posted := true;
                        "Posted By" := UserId;
                        "Posting date" := "Posting date";
                        Modify;
                    end;
                end;
            }
            action(Journals)
            {
                ApplicationArea = Basic;
                Caption = 'Transfer To Journal';
                Image = Journals;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedOnly = true;
                RunObject = Page "General Journal";
            }
            action("Print Preview")
            {
                ApplicationArea = Basic;
                Caption = 'Print Preview';
                Image = PrintReport;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Confirm('kindly confirm if allocation have been correctly done before posting') = false then
                        exit;

                    ReptProcHeader.Reset;
                    ReptProcHeader.SetRange(ReptProcHeader.No, No);
                    if ReptProcHeader.Find('-') then
                        Report.Run(51516972, true, false, ReptProcHeader)
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        ActionEnabled := true;
        MembLedg.Reset;
        MembLedg.SetRange(MembLedg."Document No.", Remarks);
        MembLedg.SetRange(MembLedg."External Document No.", "Cheque No.");
        if MembLedg.Find('-') then begin
            //ActionEnabled:=FALSE;
        end;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        "Posting date" := Today;
        "Date Entered" := Today;
        if "Employer Code" <> '' then begin
            BufferTable.Reset;
            BufferTable.SetRange(BufferTable.UserId, UserId);
            if BufferTable.Find('-') then begin
                BufferTable.DeleteAll;
            end;
            BufferTable.Init;
            BufferTable.UserId := UserId;
            BufferTable.EmployerCode := "Employer Code";
            BufferTable.Insert;
        end;
    end;

    trigger OnOpenPage()
    begin
        if "Employer Code" <> '' then begin
            BufferTable.Reset;
            BufferTable.SetRange(BufferTable.UserId, UserId);
            if BufferTable.Find('-') then begin
                BufferTable.DeleteAll;
            end;
            BufferTable.Init;
            BufferTable.UserId := UserId;
            BufferTable.EmployerCode := "Employer Code";
            BufferTable.Insert;
        end;
    end;

    var
        Gnljnline: Record "Gen. Journal Line";
        PDate: Date;
        DocNo: Code[20];
        RunBal: Decimal;
        LineNo: Integer;
        LBatches: Record "Loan Disburesment-Batching";
        Jtemplate: Code[30];
        JBatch: Code[30];
        "Cheque No.": Code[20];
        DActivityBOSA: Code[20];
        DBranchBOSA: Code[20];
        ReptProcHeader: Record "Checkoff Header-Distributed2";
        Cust: Record "Member Register";
        MembPostGroup: Record "Customer Posting Group";
        Loantable: Record "Loans Register";
        LRepayment: Decimal;
        LoanType: Record "Loan Products Setup";
        LoanApp: Record "Loans Register";
        Interest: Decimal;
        LineN: Integer;
        TotalRepay: Decimal;
        MultipleLoan: Integer;
        LType: Text;
        MonthlyAmount: Decimal;
        ShRec: Decimal;
        SHARESCAP: Decimal;
        DIFF: Decimal;
        DIFFPAID: Decimal;
        genstup: Record "Sacco General Set-Up";
        Memb: Record "Member Register";
        INSURANCE: Decimal;
        GenBatches: Record "Gen. Journal Batch";
        Datefilter: Text[50];
        MembLedg: Record "Member Ledger Entry";
        SFactory: Codeunit "SURESTEP Factory";
        BATCH_NAME: Code[50];
        BATCH_TEMPLATE: Code[50];
        DOCUMENT_NO: Code[40];
        GenJournalLine: Record "Gen. Journal Line";
        ActionEnabled: Boolean;
        XMLCheckOff: XmlPort "Import Checkoff Distributed2";
        Window: Dialog;
        TotalCount: Integer;
        Counter: Integer;
        Percentage: Integer;
        ObjCust: Record "Member Register";
        ObjSaccoGenSetUp: Record "Sacco General Set-Up";
        MemberNumber: Code[20];
        SURESTEPFactory: Codeunit "SURESTEP Factory";
        Temp: Record "Funds User Setup";
        DefaulterPaymentType: Option;
        KNFactory: Codeunit "SURESTEP Factory";
        BufferTable: Record "Checkoff Code Buffer";
        LoanOutstandingBalance: Decimal;
        LoanOutstandingInterest: Decimal;
        AmountToPay: Decimal;
        InterestTopay: Decimal;
        MemberTotal: Decimal;
        LoanProductsSetup: Record "Loan Products Setup";
        EmergencyAmount1: Decimal;
        EmergencyAmount2: Decimal;
        InstantAmoun1: Decimal;
        InstantAmount2: Decimal;
        CountEmergency: Integer;
        CountInstant: Integer;
        InsurancePerProduct: Decimal;
        InsuranceEmergency: Decimal;
        InsuranceEmergency2: Decimal;
        InsuranceInstant1: Decimal;
        InsuranceInstant2: Decimal;
        intC: Integer;
        UnallocatedFunds: Decimal;
        UnallocatedPerLoanProd: Decimal;

    local procedure FnInitiateProgressBar()
    begin
    end;

    local procedure FnUpdateProgressBar()
    begin
        Percentage := (ROUND(Counter / TotalCount * 10000, 1));
        Counter := Counter + 1;
        Window.Update(1, Percentage);
    end;

    local procedure FnGetLoanNo(MemberNo: Code[20]; LoanType: Code[20]) LoanNo: Code[20]
    var
        ObjLoansRegister: Record "Loans Register";
    begin
        ObjLoansRegister.Reset;
        ObjLoansRegister.SetRange(ObjLoansRegister."Client Code", MemberNo);
        ObjLoansRegister.SetRange(ObjLoansRegister."Loan Product Type", LoanType);
        ObjLoansRegister.SetFilter(ObjLoansRegister."Outstanding Balance", '>%1', 0);
        if ObjLoansRegister.FindFirst then begin
            LoanNo := ObjLoansRegister."Loan  No.";
        end;
        exit(LoanNo);
    end;

    local procedure FnGetMemberNo(PayrollNo: Code[30]; EmployerCode: Code[30]) MemberNo: Code[20]
    var
        ObjMembersReg: Record "Member Register";
    begin
        ObjMembersReg.Reset;
        ObjMembersReg.SetRange(ObjMembersReg."Personal No", PayrollNo);
        ObjMembersReg.SetRange(ObjMembersReg."Employer Code", EmployerCode);
        if ObjMembersReg.Find('-') then begin
            MemberNo := ObjMembersReg."No.";
        end;
        exit(MemberNo);
    end;

    local procedure KnGetPeriodDescription(Period: Date): Text
    var
        ObjCheckOffPeriods: Record "Checkoff Calender.";
        Description: Text;
    begin
        ObjCheckOffPeriods.Reset;
        ObjCheckOffPeriods.SetRange(ObjCheckOffPeriods."Date Opened", Period);
        if ObjCheckOffPeriods.Find('-') then begin
            Description := ObjCheckOffPeriods."Period Name";
        end;

        exit(Description);
    end;

    local procedure FnGetLoanAmountToPay(LoanAmount: Decimal; LoanNo_: Code[30]) AmountToPay_: Decimal
    begin
        //___________________________Loan_______________________
        AmountToPay := 0;
        LoanOutstandingBalance := KNFactory.KnGetLoanBalanceOneLoan(LoanNo_);

        //LoanOutstandingBalance:=KNFactory.KnGetLoanBalanceOneLoan(LoanNo_);
        if (LoanOutstandingBalance > 0) and (LoanOutstandingBalance < LoanAmount) then begin
            UnallocatedPerLoanProd := LoanAmount - LoanOutstandingBalance;
            AmountToPay_ := LoanOutstandingBalance;
        end else
            if LoanOutstandingBalance <= 0 then begin
                AmountToPay_ := 0;
                UnallocatedPerLoanProd := UnallocatedPerLoanProd + LoanAmount;
            end else begin
                AmountToPay_ := LoanAmount;
            end;
        exit(AmountToPay_);
    end;

    local procedure FnGetLoanInterestToPay(InterestAmount: Decimal; LoanNo_: Code[30]) InterestToPay_: Decimal
    begin
        //__________________________Interest___________________
        AmountToPay := 0;
        LoanOutstandingInterest := KNFactory.KnGetInterestBalanceOneLoan(LoanNo_);
        if (LoanOutstandingInterest > 0) and (LoanOutstandingInterest < InterestAmount) then begin
            UnallocatedPerLoanProd := InterestAmount - LoanOutstandingInterest;
            InterestToPay_ := LoanOutstandingInterest;
        end else
            if LoanOutstandingInterest <= 0 then begin
                InterestToPay_ := 0;
                UnallocatedPerLoanProd := InterestAmount;
            end else begin
                InterestToPay_ := InterestAmount;
            end;
        exit(InterestToPay_);
    end;

    local procedure FnEmergencyLoan(ParamRctLines: Record "Checkoff Lines-Distributed2"; loanT: Code[30]) returnunallocatedSpecialLns: Decimal
    var
        LoanRec: Record "Loans Register";
        LoanCount: Integer;
        LoanAmount1: Decimal;
        LoanAmount2: Decimal;
        UnallocatedSpecialLoans: Decimal;
        LoanNo1: Code[10];
        LoanNo2: Code[10];
        IssueDate11: Date;
        IssueDate2: Date;
        UnallocatedInsurance1: Decimal;
        UnallocatedInsurance2: Decimal;
        amountfor1Loan: Decimal;
    begin
        //Begin Loan Product

        LoanRec.Reset;
        LoanRec.SetRange(LoanRec."Client Code", ParamRctLines."Member No.");
        LoanRec.SetRange(LoanRec."Loan Product Type", loanT);
        LoanRec.SetCurrentkey("Loan  No.");
        LoanRec.SetAscending("Loan  No.", true);
        if LoanRec.FindFirst() then begin
            LoanNo1 := LoanRec."Loan  No.";
            UnallocatedInsurance1 := ParamRctLines."Emergency 1 Insurance";
        end else begin
            UnallocatedSpecialLoans := ParamRctLines."Emergency 1 Insurance" + ParamRctLines."Emergency 2 Insurance";
        end;

        LoanRec.Reset;
        LoanRec.SetRange(LoanRec."Client Code", ParamRctLines."Member No.");
        LoanRec.SetRange(LoanRec."Loan Product Type", loanT);
        LoanRec.SetCurrentkey("Loan  No.");
        LoanRec.SetAscending("Loan  No.", false);
        if LoanRec.FindFirst() then begin
            //IF LoanRec.COUNT>1 THEN
            //LoanCount:=LoanRec.COUNT;
            LoanNo2 := LoanRec."Loan  No.";
            UnallocatedInsurance2 := ParamRctLines."Emergency 2 Insurance";
        end;

        UnallocatedSpecialLoans := ParamRctLines."Emergency 1 Loan" + ParamRctLines."Emergency 2 Loan";

        if LoanNo1 = LoanNo2 then begin
            if (ParamRctLines."Emergency 1 Loan" = 0) or (ParamRctLines."Emergency 2 Loan" = 0) then
                amountfor1Loan := UnallocatedSpecialLoans
            else
                amountfor1Loan := ParamRctLines."Emergency 1 Loan";

            LoanRec.Reset;
            LoanRec.SetRange(LoanRec."Client Code", ParamRctLines."Member No.");
            LoanRec.SetRange(LoanRec."Loan  No.", LoanNo1);
            if LoanRec.Find('-') then begin
                if UnallocatedInsurance1 > 0 then begin
                    LineNo := LineNo + 10000;
                    SURESTEPFactory.FnCreateGnlJournalLine(Jtemplate, JBatch, No, LineNo, GenJournalLine."transaction type"::"Loan Insurance Charged", GenJournalLine."account type"::Member,
                                                          ParamRctLines."Member No.", "Posting date", -UnallocatedInsurance1 - UnallocatedInsurance2, 'BOSA', '', 'Loan Insurance checkoff for ' + KnGetPeriodDescription("CheckOff Period"), LoanRec."Loan  No.");
                end;

                if amountfor1Loan > 0 then begin
                    AmountToPay := 0;
                    InterestTopay := 0;
                    InterestTopay := KNFactory.KnGetInterestBalanceOneLoan(LoanRec."Loan  No.");
                    if InterestTopay < 0 then InterestTopay := 0;
                    if InterestTopay > amountfor1Loan then begin
                        InterestTopay := amountfor1Loan
                    end else begin
                        AmountToPay := amountfor1Loan - InterestTopay;
                    end;

                    if InterestTopay < 0 then
                        InterestTopay := 0;
                    LineNo := LineNo + 10000;
                    AmountToPay := FnGetLoanAmountToPaySpecial(AmountToPay, LoanRec."Loan  No.");
                    if AmountToPay < 0 then AmountToPay := 0;

                    //Loan Principal
                    SURESTEPFactory.FnCreateGnlJournalLine(Jtemplate, JBatch, No, LineNo, GenJournalLine."transaction type"::"Loan Repayment", GenJournalLine."account type"::Member,
                                                          ParamRctLines."Member No.", "Posting date", -AmountToPay, 'BOSA', '', 'loan repayment checkoff for ' + KnGetPeriodDescription("CheckOff Period"), LoanRec."Loan  No.");
                    //Loan Interest
                    LineNo := LineNo + 10000;
                    SURESTEPFactory.FnCreateGnlJournalLine(Jtemplate, JBatch, No, LineNo, GenJournalLine."transaction type"::"Interest Paid", GenJournalLine."account type"::Member,
                                                          ParamRctLines."Member No.", "Posting date", -InterestTopay, 'BOSA', '', 'Interest payment checkoff for ' + KnGetPeriodDescription("CheckOff Period"), LoanRec."Loan  No.");

                    UnallocatedSpecialLoans := UnallocatedSpecialLoans - AmountToPay - InterestTopay;
                end;// IF UnallocatedPerLoanProd>0
                    // END;//IF LoanT."Outstanding Balance">0
            end;//LoanRec
        end
        else begin
            //Loan 1
            LoanRec.Reset;
            LoanRec.SetRange(LoanRec."Client Code", ParamRctLines."Member No.");
            LoanRec.SetRange(LoanRec."Loan  No.", LoanNo1);
            if LoanRec.Find('-') then begin
                if UnallocatedInsurance1 > 0 then begin
                    LineNo := LineNo + 10000;
                    SURESTEPFactory.FnCreateGnlJournalLine(Jtemplate, JBatch, No, LineNo, GenJournalLine."transaction type"::"Loan Insurance Charged", GenJournalLine."account type"::Member,
                                                          ParamRctLines."Member No.", "Posting date", -UnallocatedInsurance1, 'BOSA', '', 'Loan Insurance checkoff for ' + KnGetPeriodDescription("CheckOff Period"), LoanRec."Loan  No.");
                end;

                if ParamRctLines."Emergency 1 Loan" > 0 then begin
                    AmountToPay := 0;
                    InterestTopay := 0;
                    InterestTopay := KNFactory.KnGetInterestBalanceOneLoan(LoanRec."Loan  No.");
                    if InterestTopay < 0 then InterestTopay := 0;
                    if InterestTopay > ParamRctLines."Emergency 1 Loan" then begin
                        InterestTopay := ParamRctLines."Emergency 1 Loan"
                    end else begin
                        AmountToPay := ParamRctLines."Emergency 1 Loan" - InterestTopay;
                    end;

                    if InterestTopay < 0 then
                        InterestTopay := 0;
                    LineNo := LineNo + 10000;
                    AmountToPay := FnGetLoanAmountToPaySpecial(AmountToPay, LoanRec."Loan  No.");
                    if AmountToPay < 0 then AmountToPay := 0;

                    //Loan Principal
                    SURESTEPFactory.FnCreateGnlJournalLine(Jtemplate, JBatch, No, LineNo, GenJournalLine."transaction type"::"Loan Repayment", GenJournalLine."account type"::Member,
                                                          ParamRctLines."Member No.", "Posting date", -AmountToPay, 'BOSA', '', 'loan repayment checkoff for ' + KnGetPeriodDescription("CheckOff Period"), LoanRec."Loan  No.");
                    //Loan Interest
                    LineNo := LineNo + 10000;
                    SURESTEPFactory.FnCreateGnlJournalLine(Jtemplate, JBatch, No, LineNo, GenJournalLine."transaction type"::"Interest Paid", GenJournalLine."account type"::Member,
                                                          ParamRctLines."Member No.", "Posting date", -InterestTopay, 'BOSA', '', 'Interest payment checkoff for ' + KnGetPeriodDescription("CheckOff Period"), LoanRec."Loan  No.");

                    UnallocatedSpecialLoans := UnallocatedSpecialLoans - AmountToPay - InterestTopay;
                end;// IF UnallocatedPerLoanProd>0
                    // END;//IF LoanT."Outstanding Balance">0
            end;//LoanRec


            //Loan2
            LoanRec.Reset;
            LoanRec.SetRange(LoanRec."Client Code", ParamRctLines."Member No.");
            LoanRec.SetRange(LoanRec."Loan  No.", LoanNo2);
            if LoanRec.Find('-') then begin
                if UnallocatedInsurance2 > 0 then begin
                    LineNo := LineNo + 10000;
                    SURESTEPFactory.FnCreateGnlJournalLine(Jtemplate, JBatch, No, LineNo, GenJournalLine."transaction type"::"Loan Insurance Charged", GenJournalLine."account type"::Member,
                                                          ParamRctLines."Member No.", "Posting date", -UnallocatedInsurance2, 'BOSA', '', 'Loan Insurance checkoff for ' + KnGetPeriodDescription("CheckOff Period"), LoanRec."Loan  No.");
                end;

                if ParamRctLines."Emergency 2 Loan" > 0 then begin
                    AmountToPay := 0;
                    InterestTopay := 0;
                    InterestTopay := KNFactory.KnGetInterestBalanceOneLoan(LoanRec."Loan  No.");
                    if InterestTopay < 0 then InterestTopay := 0;
                    if InterestTopay > ParamRctLines."Emergency 2 Loan" then begin
                        InterestTopay := ParamRctLines."Emergency 2 Loan"
                    end else begin
                        AmountToPay := ParamRctLines."Emergency 2 Loan" - InterestTopay;
                    end;

                    if InterestTopay < 0 then
                        InterestTopay := 0;
                    LineNo := LineNo + 10000;
                    AmountToPay := FnGetLoanAmountToPaySpecial(AmountToPay, LoanRec."Loan  No.");
                    if AmountToPay < 0 then AmountToPay := 0;

                    //Loan Principal
                    SURESTEPFactory.FnCreateGnlJournalLine(Jtemplate, JBatch, No, LineNo, GenJournalLine."transaction type"::"Loan Repayment", GenJournalLine."account type"::Member,
                                                          ParamRctLines."Member No.", "Posting date", -AmountToPay, 'BOSA', '', 'loan repayment checkoff for ' + KnGetPeriodDescription("CheckOff Period"), LoanRec."Loan  No.");
                    //Loan Interest
                    LineNo := LineNo + 10000;
                    SURESTEPFactory.FnCreateGnlJournalLine(Jtemplate, JBatch, No, LineNo, GenJournalLine."transaction type"::"Interest Paid", GenJournalLine."account type"::Member,
                                                          ParamRctLines."Member No.", "Posting date", -InterestTopay, 'BOSA', '', 'Interest payment checkoff for ' + KnGetPeriodDescription("CheckOff Period"), LoanRec."Loan  No.");

                    UnallocatedSpecialLoans := UnallocatedSpecialLoans - AmountToPay - InterestTopay;
                end;// IF UnallocatedPerLoanProd>0
                    // END;//IF LoanT."Outstanding Balance">0
            end;//LoanRec
        end;//Of ELSE Statement
        returnunallocatedSpecialLns := UnallocatedSpecialLoans;
    end;

    local procedure FnInstantLoan(ParamRctLines: Record "Checkoff Lines-Distributed2"; loanT: Code[30]) returnunallocatedSpecialLns: Decimal
    var
        LoanRec: Record "Loans Register";
        LoanCount: Integer;
        LoanAmount1: Decimal;
        LoanAmount2: Decimal;
        UnallocatedSpecialLoans: Decimal;
        LoanNo1: Code[10];
        LoanNo2: Code[10];
        IssueDate11: Date;
        IssueDate2: Date;
        UnallocatedInsurance1: Decimal;
        UnallocatedInsurance2: Decimal;
        amountfor1Loan: Decimal;
    begin
        //Begin Loan Product

        LoanRec.Reset;
        LoanRec.SetRange(LoanRec."Client Code", ParamRctLines."Member No.");
        LoanRec.SetRange(LoanRec."Loan Product Type", loanT);
        LoanRec.SetCurrentkey("Loan  No.");
        LoanRec.SetAscending("Loan  No.", true);
        if LoanRec.FindFirst() then begin
            LoanNo1 := LoanRec."Loan  No.";
            UnallocatedInsurance1 := ParamRctLines."Instant Loan Insurance";
        end else begin
            UnallocatedSpecialLoans := ParamRctLines."Instant Loan Insurance" + ParamRctLines."Instant2 Loan Insurance";//Verify
        end;

        LoanRec.Reset;
        LoanRec.SetRange(LoanRec."Client Code", ParamRctLines."Member No.");
        LoanRec.SetRange(LoanRec."Loan Product Type", loanT);
        LoanRec.SetCurrentkey("Loan  No.");
        LoanRec.SetAscending("Loan  No.", false);
        if LoanRec.FindFirst() then begin
            //IF LoanRec.COUNT>1 THEN
            //LoanCount:=LoanRec.COUNT;
            LoanNo2 := LoanRec."Loan  No.";
            UnallocatedInsurance2 := ParamRctLines."Instant2 Loan Insurance";
        end;

        UnallocatedSpecialLoans := ParamRctLines."Instant Loan" + ParamRctLines."Instant2 Loan";

        if LoanNo1 = LoanNo2 then begin
            if (ParamRctLines."Instant Loan" = 0) or (ParamRctLines."Instant2 Loan" = 0) then
                amountfor1Loan := UnallocatedSpecialLoans
            else
                amountfor1Loan := ParamRctLines."Instant Loan";

            LoanRec.Reset;
            LoanRec.SetRange(LoanRec."Client Code", ParamRctLines."Member No.");
            LoanRec.SetRange(LoanRec."Loan  No.", LoanNo1);
            if LoanRec.Find('-') then begin
                if UnallocatedInsurance1 > 0 then begin
                    LineNo := LineNo + 10000;
                    SURESTEPFactory.FnCreateGnlJournalLine(Jtemplate, JBatch, No, LineNo, GenJournalLine."transaction type"::"Loan Insurance Charged", GenJournalLine."account type"::Member,
                                                          ParamRctLines."Member No.", "Posting date", -UnallocatedInsurance1 - UnallocatedInsurance2, 'BOSA', '', 'Loan Insurance checkoff for ' + KnGetPeriodDescription("CheckOff Period"), LoanRec."Loan  No.");
                end;

                if amountfor1Loan > 0 then begin
                    AmountToPay := 0;
                    InterestTopay := 0;
                    InterestTopay := KNFactory.KnGetInterestBalanceOneLoan(LoanRec."Loan  No.");
                    if InterestTopay < 0 then InterestTopay := 0;
                    if InterestTopay > amountfor1Loan then begin
                        InterestTopay := amountfor1Loan
                    end else begin
                        AmountToPay := amountfor1Loan - InterestTopay;
                    end;

                    if InterestTopay < 0 then
                        InterestTopay := 0;
                    LineNo := LineNo + 10000;
                    AmountToPay := FnGetLoanAmountToPaySpecial(AmountToPay, LoanRec."Loan  No.");
                    if AmountToPay < 0 then AmountToPay := 0;

                    //Loan Principal
                    SURESTEPFactory.FnCreateGnlJournalLine(Jtemplate, JBatch, No, LineNo, GenJournalLine."transaction type"::"Loan Repayment", GenJournalLine."account type"::Member,
                                                          ParamRctLines."Member No.", "Posting date", -AmountToPay, 'BOSA', '', 'loan repayment checkoff for ' + KnGetPeriodDescription("CheckOff Period"), LoanRec."Loan  No.");
                    //Loan Interest
                    LineNo := LineNo + 10000;
                    SURESTEPFactory.FnCreateGnlJournalLine(Jtemplate, JBatch, No, LineNo, GenJournalLine."transaction type"::"Interest Paid", GenJournalLine."account type"::Member,
                                                          ParamRctLines."Member No.", "Posting date", -InterestTopay, 'BOSA', '', 'Interest payment checkoff for ' + KnGetPeriodDescription("CheckOff Period"), LoanRec."Loan  No.");

                    UnallocatedSpecialLoans := UnallocatedSpecialLoans - AmountToPay - InterestTopay;
                end;// IF UnallocatedPerLoanProd>0
                    // END;//IF LoanT."Outstanding Balance">0
            end;//LoanRec
        end
        else begin
            //Loan 1
            LoanRec.Reset;
            LoanRec.SetRange(LoanRec."Client Code", ParamRctLines."Member No.");
            LoanRec.SetRange(LoanRec."Loan  No.", LoanNo1);
            if LoanRec.Find('-') then begin
                if UnallocatedInsurance1 > 0 then begin
                    LineNo := LineNo + 10000;
                    SURESTEPFactory.FnCreateGnlJournalLine(Jtemplate, JBatch, No, LineNo, GenJournalLine."transaction type"::"Loan Insurance Charged", GenJournalLine."account type"::Member,
                                                          ParamRctLines."Member No.", "Posting date", -UnallocatedInsurance1 - UnallocatedInsurance2, 'BOSA', '', 'Loan Insurance checkoff for ' + KnGetPeriodDescription("CheckOff Period"), LoanRec."Loan  No.");
                end;

                if amountfor1Loan > 0 then begin
                    AmountToPay := 0;
                    InterestTopay := 0;
                    InterestTopay := KNFactory.KnGetInterestBalanceOneLoan(LoanRec."Loan  No.");
                    if InterestTopay < 0 then InterestTopay := 0;
                    if InterestTopay > amountfor1Loan then begin
                        InterestTopay := amountfor1Loan
                    end else begin
                        AmountToPay := amountfor1Loan - InterestTopay;
                    end;

                    if InterestTopay < 0 then
                        InterestTopay := 0;
                    LineNo := LineNo + 10000;
                    AmountToPay := FnGetLoanAmountToPaySpecial(AmountToPay, LoanRec."Loan  No.");
                    if AmountToPay < 0 then AmountToPay := 0;

                    //Loan Principal
                    SURESTEPFactory.FnCreateGnlJournalLine(Jtemplate, JBatch, No, LineNo, GenJournalLine."transaction type"::"Loan Repayment", GenJournalLine."account type"::Member,
                                                          ParamRctLines."Member No.", "Posting date", -AmountToPay, 'BOSA', '', 'loan repayment checkoff for ' + KnGetPeriodDescription("CheckOff Period"), LoanRec."Loan  No.");
                    //Loan Interest
                    LineNo := LineNo + 10000;
                    SURESTEPFactory.FnCreateGnlJournalLine(Jtemplate, JBatch, No, LineNo, GenJournalLine."transaction type"::"Interest Paid", GenJournalLine."account type"::Member,
                                                          ParamRctLines."Member No.", "Posting date", -InterestTopay, 'BOSA', '', 'Interest payment checkoff for ' + KnGetPeriodDescription("CheckOff Period"), LoanRec."Loan  No.");

                    UnallocatedSpecialLoans := UnallocatedSpecialLoans - AmountToPay - InterestTopay;
                end;// IF UnallocatedPerLoanProd>0
                    // END;//IF LoanT."Outstanding Balance">0
            end;//LoanRec


            //Loan2
            LoanRec.Reset;
            LoanRec.SetRange(LoanRec."Client Code", ParamRctLines."Member No.");
            LoanRec.SetRange(LoanRec."Loan  No.", LoanNo2);
            if LoanRec.Find('-') then begin
                if UnallocatedInsurance2 > 0 then begin
                    LineNo := LineNo + 10000;
                    SURESTEPFactory.FnCreateGnlJournalLine(Jtemplate, JBatch, No, LineNo, GenJournalLine."transaction type"::"Loan Insurance Charged", GenJournalLine."account type"::Member,
                                                          ParamRctLines."Member No.", "Posting date", -UnallocatedInsurance2, 'BOSA', '', 'Loan Insurance checkoff for ' + KnGetPeriodDescription("CheckOff Period"), LoanRec."Loan  No.");
                end;

                if ParamRctLines."Instant2 Loan" > 0 then begin
                    AmountToPay := 0;
                    InterestTopay := 0;
                    InterestTopay := KNFactory.KnGetInterestBalanceOneLoan(LoanRec."Loan  No.");
                    if InterestTopay < 0 then InterestTopay := 0;
                    if InterestTopay > ParamRctLines."Instant2 Loan" then begin
                        InterestTopay := ParamRctLines."Instant2 Loan"
                    end else begin
                        AmountToPay := ParamRctLines."Instant2 Loan" - InterestTopay;
                    end;

                    if InterestTopay < 0 then
                        InterestTopay := 0;
                    LineNo := LineNo + 10000;
                    AmountToPay := FnGetLoanAmountToPaySpecial(AmountToPay, LoanRec."Loan  No.");
                    if AmountToPay < 0 then AmountToPay := 0;

                    //Loan Principal
                    SURESTEPFactory.FnCreateGnlJournalLine(Jtemplate, JBatch, No, LineNo, GenJournalLine."transaction type"::"Loan Repayment", GenJournalLine."account type"::Member,
                                                          ParamRctLines."Member No.", "Posting date", -AmountToPay, 'BOSA', '', 'loan repayment checkoff for ' + KnGetPeriodDescription("CheckOff Period"), LoanRec."Loan  No.");
                    //Loan Interest
                    LineNo := LineNo + 10000;
                    SURESTEPFactory.FnCreateGnlJournalLine(Jtemplate, JBatch, No, LineNo, GenJournalLine."transaction type"::"Interest Paid", GenJournalLine."account type"::Member,
                                                          ParamRctLines."Member No.", "Posting date", -InterestTopay, 'BOSA', '', 'Interest payment checkoff for ' + KnGetPeriodDescription("CheckOff Period"), LoanRec."Loan  No.");

                    UnallocatedSpecialLoans := UnallocatedSpecialLoans - AmountToPay - InterestTopay;
                end;// IF UnallocatedPerLoanProd>0
                    // END;//IF LoanT."Outstanding Balance">0
            end;//LoanRec
        end;//Of ELSE Statement
        returnunallocatedSpecialLns := UnallocatedSpecialLoans;
    end;

    local procedure FnGetLoanAmountToPaySpecial(LoanAmount: Decimal; LoanNo_: Code[30]) AmountToPay_: Decimal
    begin
        //___________________________Loan_______________________
        AmountToPay := 0;
        LoanOutstandingBalance := KNFactory.KnGetLoanBalanceOneLoan(LoanNo_);

        //LoanOutstandingBalance:=KNFactory.KnGetLoanBalanceOneLoan(LoanNo_);
        if (LoanOutstandingBalance > 0) and (LoanOutstandingBalance < LoanAmount) then begin
            AmountToPay_ := LoanOutstandingBalance;
        end else
            if LoanOutstandingBalance <= 0 then begin
                AmountToPay_ := 0;
            end else begin
                AmountToPay_ := LoanAmount;
            end;
        exit(AmountToPay_);
    end;

    local procedure FnGetLoanInterestToPaySpecial(InterestAmount: Decimal; LoanNo_: Code[30]) InterestToPay_: Decimal
    begin
        //__________________________Interest___________________
        AmountToPay := 0;
        LoanOutstandingInterest := KNFactory.KnGetInterestBalanceOneLoan(LoanNo_);
        if (LoanOutstandingInterest > 0) and (LoanOutstandingInterest < InterestAmount) then begin
            InterestToPay_ := LoanOutstandingInterest;
        end else
            if LoanOutstandingInterest <= 0 then begin
                InterestToPay_ := 0;
            end else begin
                InterestToPay_ := InterestAmount;
            end;
        exit(InterestToPay_);
    end;
}

