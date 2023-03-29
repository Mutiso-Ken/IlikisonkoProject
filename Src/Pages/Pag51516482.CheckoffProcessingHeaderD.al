#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516482 "Checkoff Processing Header-D"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Checkoff Header-Distributed";
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
                }
                field("Account No"; "Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Employer Name"; "Employer Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Employer Code"; "Employer Code")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        // s
                    end;
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
                    Visible = false;
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
            part("Checkoff Lines-Distributed"; "Checkoff Processing Lines-D")
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
            action("Import Checkoff Distributed")
            {
                ApplicationArea = Basic;
                Caption = 'Import Checkoff';
                Enabled = ActionEnabled;
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = XMLport "Import Checkoff Distributed";

                trigger OnAction()
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
                    NormalLoan: Decimal;
                    NormalLoanInt: Decimal;
                    PremiumLoan: Decimal;
                    PremiumLoanInt: Decimal;
                    InstantLoan: Decimal;
                    EmergencyLoan: Decimal;
                    SchoolFees: Decimal;
                    GuarantorLoan: Decimal;
                    SuperSchool: Decimal;
                    SalaryAdvance: Decimal;
                    HousingLoan: Decimal;
                    HomeAppliance: Decimal;
                    Refinanced: Decimal;
                    BankBailOut: Decimal;
                    InstantLoanInt: Decimal;
                    EmergencyLoanInt: Decimal;
                    SchoolFeesInt: Decimal;
                    GuarantorLoanInt: Decimal;
                    SuperSchoolInt: Decimal;
                    SalaryAdvanceInt: Decimal;
                    HousingLoanInt: Decimal;
                    HomeApplianceInt: Decimal;
                    RefinancedInt: Decimal;
                    BankBailOutInt: Decimal;
                    DepositContribution: Decimal;
                    ShareCapital: Decimal;
                    Stock: Decimal;
                    DemandSav: Decimal;
                    Insurance: Decimal;
                    CompanyInfo: Record "Company Information";
                    PeriodName: Text;
                    ObjCheckoffLines: Record "Checkoff Lines-Distributed";
                    DeamndSavings: Decimal;
                    TotalAmount: Decimal;
                    TotalLines: Decimal;
                begin
                    // TESTFIELD("Document No");
                    // TESTFIELD(Amount);


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
                    //ReceiptLine.SETRANGE("Member No.",'001525');
                    if ReceiptLine.FindSet(true, true) then begin//1
                        Window.Open('@1@');
                        TotalCount := ReceiptLine.Count;
                        repeat
                            FnUpdateProgressBar();
                            MemberNumber := FnGetMemberNo(ReceiptLine."Staff/Payroll No", "Employer Code");
                            //Validate Staff vs Employer code.
                            ReceiptLine."Member No." := MemberNumber;
                            ReceiptLine."NLoan No" := FnGetLoanNo(MemberNumber, 'D301');
                            ReceiptLine."ELoan No." := FnGetLoanNo(MemberNumber, 'D304');
                            ReceiptLine.SLoanNo := FnGetLoanNo(MemberNumber, 'D305');
                            ReceiptLine."PLoan No" := FnGetLoanNo(MemberNumber, 'D302');
                            ReceiptLine."HLoan No" := FnGetLoanNo(MemberNumber, 'D309');
                            ReceiptLine."ILoan No" := FnGetLoanNo(MemberNumber, 'D303');
                            ReceiptLine."SSLoan No" := FnGetLoanNo(MemberNumber, 'D307');
                            ReceiptLine."SA Loan No" := FnGetLoanNo(MemberNumber, 'D308');
                            ReceiptLine."H/A Loan No" := FnGetLoanNo(MemberNumber, 'D311');
                            ReceiptLine."Refinance Loan No" := FnGetLoanNo(MemberNumber, 'D312');
                            ReceiptLine."Guarantor Loan No" := FnGetLoanNo(MemberNumber, 'D306');
                            ReceiptLine."BB Loan No" := FnGetLoanNo(MemberNumber, 'D313');
                            ReceiptLine."NSe Loan No" := FnGetLoanNo(MemberNumber, '');
                            ReceiptLine.Modify(true);
                        until ReceiptLine.Next = 0;
                        Window.Close;
                        Message('Validation was successfully completed.');
                    end;//1
                    MemberTotal := 0;
                    //Validate Amounts
                    ObjCheckoffLines.Reset;
                    ObjCheckoffLines.SetRange(ObjCheckoffLines."Receipt Header No", No);
                    if ObjCheckoffLines.Find('-') then begin
                        repeat
                            MemberTotal := ObjCheckoffLines."By Laws" + ObjCheckoffLines."Int SFees Loan" + ObjCheckoffLines."Guarantor Loan" + ObjCheckoffLines."Int Guarantor Loan" +
                            ObjCheckoffLines."SS Loan" + ObjCheckoffLines."Int SS Loan" + ObjCheckoffLines.SALoan +
                            ObjCheckoffLines."Int SA Loan" + ObjCheckoffLines."H/A Loan" + ObjCheckoffLines."Int H/A Loan" +
                            ObjCheckoffLines."House Loan" + ObjCheckoffLines."Int House Loan" + ObjCheckoffLines."BB Loan" + ObjCheckoffLines."Int BB Loan" +
                            ObjCheckoffLines."Refinance Loan" + ObjCheckoffLines."Int Refinance Loan";
                        //IF MemberTotal<>ObjCheckoffLines.Amount THEN
                        // ERROR('Amount for Staff/Payroll No '+ObjCheckoffLines."Staff/Payroll No"+' and the total breakdown must be the the same');
                        until ObjCheckoffLines.Next = 0;
                    end;
                    ObjCheckoffLines.Reset;
                    ObjCheckoffLines.SetRange(ObjCheckoffLines."Receipt Header No", No);
                    if ObjCheckoffLines.FindSet then begin
                        ObjCheckoffLines.CalcSums(ObjCheckoffLines."Deposit contribution", ObjCheckoffLines.Demand,
                        ObjCheckoffLines."Share Capital", ObjCheckoffLines."Insurance Contribution", ObjCheckoffLines.Stocks,
                        ObjCheckoffLines."Share Capital", ObjCheckoffLines."Insurance Contribution", ObjCheckoffLines.Stocks,
                        ObjCheckoffLines."Normal Loan", ObjCheckoffLines."Int normal loan", ObjCheckoffLines."Premium Loan",
                        ObjCheckoffLines."Int Premium Loan", ObjCheckoffLines."Instant Loan", ObjCheckoffLines."Int Instant Loan",
                        ObjCheckoffLines."Emergency Loan", ObjCheckoffLines."Int Emergency Loan", ObjCheckoffLines."School Fees Loan",
                        ObjCheckoffLines."Refinance Loan", ObjCheckoffLines."Int Refinance Loan");

                        ObjCheckoffLines.CalcSums(ObjCheckoffLines."By Laws", ObjCheckoffLines."Int SFees Loan",
                        ObjCheckoffLines."Guarantor Loan", ObjCheckoffLines."Int Guarantor Loan",
                        ObjCheckoffLines."SS Loan", ObjCheckoffLines."Int SS Loan", ObjCheckoffLines.SALoan,
                        ObjCheckoffLines."Int SA Loan", ObjCheckoffLines."H/A Loan", ObjCheckoffLines."Int H/A Loan",
                        ObjCheckoffLines."House Loan", ObjCheckoffLines."Int House Loan", ObjCheckoffLines."BB Loan", ObjCheckoffLines."Int BB Loan");

                        DepositContribution := ObjCheckoffLines."Deposit contribution";
                        Stock := ObjCheckoffLines.Stocks;
                        //By
                        DeamndSavings := ObjCheckoffLines.Demand;
                        ShareCapital := ObjCheckoffLines."Share Capital";
                        Insurance := ObjCheckoffLines."Insurance Contribution";
                        NormalLoan := ObjCheckoffLines."Normal Loan";
                        NormalLoanInt := ObjCheckoffLines."Int normal loan";
                        PremiumLoan := ObjCheckoffLines."Premium Loan";
                        PremiumLoanInt := ObjCheckoffLines."Int Premium Loan";
                        InstantLoan := ObjCheckoffLines."Instant Loan";
                        InstantLoanInt := ObjCheckoffLines."Int Instant Loan";
                        EmergencyLoan := ObjCheckoffLines."Emergency Loan";
                        EmergencyLoanInt := ObjCheckoffLines."Int Emergency Loan";
                        SchoolFees := ObjCheckoffLines."School Fees Loan";
                        SchoolFeesInt := ObjCheckoffLines."Int SFees Loan";
                        GuarantorLoan := ObjCheckoffLines."Guarantor Loan";
                        GuarantorLoanInt := ObjCheckoffLines."Int Guarantor Loan";
                        SuperSchool := ObjCheckoffLines."SS Loan";
                        SuperSchoolInt := ObjCheckoffLines."Int SS Loan";
                        SalaryAdvance := ObjCheckoffLines.SALoan;
                        SalaryAdvanceInt := ObjCheckoffLines."Int SA Loan";
                        HomeAppliance := ObjCheckoffLines."H/A Loan";
                        HomeApplianceInt := ObjCheckoffLines."Int H/A Loan";
                        HousingLoan := ObjCheckoffLines."House Loan";
                        HousingLoanInt := ObjCheckoffLines."Int House Loan";
                        Refinanced := ObjCheckoffLines."Refinance Loan";
                        RefinancedInt := ObjCheckoffLines."Int Refinance Loan";
                        BankBailOut := ObjCheckoffLines."BB Loan";
                        BankBailOutInt := ObjCheckoffLines."Int BB Loan";

                        ObjCheckoffLines.CalcSums(ObjCheckoffLines.Amount);
                        TotalAmount := ObjCheckoffLines.Amount;
                        TotalLines := DepositContribution + ShareCapital + DeamndSavings + Stock + Insurance + NormalLoan + NormalLoanInt + PremiumLoan + PremiumLoanInt +
                        InstantLoan + InstantLoanInt + EmergencyLoan + EmergencyLoanInt + SchoolFees + SchoolFeesInt + GuarantorLoan + GuarantorLoanInt + SuperSchool + SuperSchoolInt +
                        SalaryAdvance + SalaryAdvanceInt + HomeAppliance + HomeApplianceInt + HousingLoan + HousingLoanInt + BankBailOut + BankBailOutInt + Refinanced + RefinancedInt;
                    end;
                end;
            }
            action("Unallocated Funds")
            {
                ApplicationArea = Basic;
                Promoted = true;
                PromotedCategory = "Report";
                Visible = false;

                trigger OnAction()
                begin
                    ReptProcHeader.Reset;
                    ReptProcHeader.SetRange(ReptProcHeader.No, No);
                    if ReptProcHeader.Find('-') then
                        Report.Run(51516542, true, false, ReptProcHeader);
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
                begin
                    if "Posting date" = 0D then
                        Error('Posting Date cannot be blank');

                    CalcFields("Total Scheduled");
                    if "Total Scheduled" <> Amount then
                        if Confirm('Total schedule is not equal to cheque amount, do you wish to continue?') = false then
                            exit;
                    if Confirm('Are you sure you want to Transfer this Checkoff to Journals ?') = true then begin
                        TestField("Document No");
                        //TESTFIELD(Amount);
                        // IF Amount<>"Total Scheduled" THEN
                        //  ERROR('Scheduled Amount must be equal to the Cheque Amount');

                        Temp.Get(UserId);
                        Jtemplate := Temp."Checkoff Journal Template";
                        JBatch := Temp."Checkoff Jouranl Batch";

                        if Jtemplate = '' then begin
                            Error('Ensure the Imprest Template is set up in Cash Office Setup');
                        end;

                        if JBatch = '' then begin
                            Error('Ensure the Imprest Batch is set up in the Cash Office Setup')
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
                                                                     ReceiptLine."Member No.", "Posting date", -ReceiptLine."Share Capital", 'BOSA', '', 'Shares cpaital checkofffor ' + KnGetPeriodDescription("CheckOff Period"), '');

                                //        //bylaws
                                //        LineNo:=LineNo+10000;
                                //        SURESTEPFactory.FnCreateGnlJournalLine(Jtemplate,JBatch,No,LineNo,GenJournalLine."Transaction Type"::ByLaws,GenJournalLine."Account Type"::Member,
                                //                                             ReceiptLine."Member No.","Posting date",-ReceiptLine."By Laws",'BOSA','','By laws checkofffor '+KnGetPeriodDescription("CheckOff Period"),'');

                                //insurance
                                LineNo := LineNo + 10000;
                                SURESTEPFactory.FnCreateGnlJournalLine(Jtemplate, JBatch, No, LineNo, GenJournalLine."transaction type"::"Insurance Contribution", GenJournalLine."account type"::Member,
                                                                     ReceiptLine."Member No.", "Posting date", -ReceiptLine."Insurance Contribution", 'BOSA', '', 'Insurance contribution checkoff for' + KnGetPeriodDescription("CheckOff Period"), '');

                                //E/fess
                                LineNo := LineNo + 10000;
                                SURESTEPFactory.FnCreateGnlJournalLine(Jtemplate, JBatch, No, LineNo, GenJournalLine."transaction type"::"Registration Fee", GenJournalLine."account type"::Member,
                                                                     ReceiptLine."Member No.", "Posting date", -ReceiptLine."Entrance Fees", 'BOSA', '', 'Entrance fees checkoff for' + KnGetPeriodDescription("CheckOff Period"), '');

                                //stocks
                                LineNo := LineNo + 10000;
                                SURESTEPFactory.FnCreateGnlJournalLine(Jtemplate, JBatch, No, LineNo, GenJournalLine."transaction type"::" ", GenJournalLine."account type"::Customer,
                                                                     ReceiptLine."Member No.", "Posting date", -ReceiptLine.Stocks, 'BOSA', '', 'Stocks payment checkoff for' + KnGetPeriodDescription("CheckOff Period"), '');

                                //         //demand
                                //        LineNo:=LineNo+10000;
                                //        SURESTEPFactory.FnCreateGnlJournalLine(Jtemplate,JBatch,No,LineNo,GenJournalLine."Transaction Type"::"Demand Savings",GenJournalLine."Account Type"::Member,
                                //                                             ReceiptLine."Member No.","Posting date",-ReceiptLine.Demand,'BOSA','','Demand savings checkoff for'+KnGetPeriodDescription("CheckOff Period"),'');

                                LoanProductsSetup.Reset;
                                LoanProductsSetup.SetFilter(LoanProductsSetup.Code, '<>%1', '');
                                if LoanProductsSetup.Find('-') then begin
                                    repeat
                                        UnallocatedPerLoanProd := 0;
                                        case LoanProductsSetup.Code of
                                            'D301':
                                                begin
                                                    UnallocatedPerLoanProd := ReceiptLine."Normal Loan";
                                                    LoanProdType := LoanProductsSetup.Code;
                                                end;
                                            'D302':
                                                begin
                                                    UnallocatedPerLoanProd := ReceiptLine."Premium Loan";
                                                    LoanProdType := LoanProductsSetup.Code;
                                                end;
                                            'D303':
                                                begin
                                                    UnallocatedPerLoanProd := ReceiptLine."Instant Loan";
                                                    LoanProdType := LoanProductsSetup.Code;
                                                end;
                                            'D304':
                                                begin
                                                    UnallocatedPerLoanProd := ReceiptLine."Emergency Loan";
                                                    LoanProdType := LoanProductsSetup.Code;
                                                end;
                                            'D305':
                                                begin
                                                    UnallocatedPerLoanProd := ReceiptLine."School Fees Loan";
                                                    LoanProdType := LoanProductsSetup.Code;
                                                end;
                                            'D306':
                                                begin
                                                    UnallocatedPerLoanProd := ReceiptLine."Guarantor Loan";
                                                    LoanProdType := LoanProductsSetup.Code;
                                                end;
                                            'D307':
                                                begin
                                                    UnallocatedPerLoanProd := ReceiptLine."SS Loan";
                                                    LoanProdType := LoanProductsSetup.Code;
                                                end;
                                            'D308':
                                                begin
                                                    UnallocatedPerLoanProd := ReceiptLine.SALoan;
                                                    LoanProdType := LoanProductsSetup.Code;
                                                end;
                                            'D309':
                                                begin
                                                    UnallocatedPerLoanProd := ReceiptLine."House Loan";
                                                    LoanProdType := LoanProductsSetup.Code;
                                                end;
                                            'D311':
                                                begin
                                                    UnallocatedPerLoanProd := ReceiptLine."H/A Loan";
                                                    LoanProdType := LoanProductsSetup.Code;
                                                end;
                                            'D312':
                                                begin
                                                    UnallocatedPerLoanProd := ReceiptLine."Refinance Loan";
                                                    LoanProdType := LoanProductsSetup.Code;
                                                end;
                                            'D313':
                                                begin
                                                    UnallocatedPerLoanProd := ReceiptLine."BB Loan";
                                                    LoanProdType := LoanProductsSetup.Code;
                                                end;
                                        end;

                                        if UnallocatedPerLoanProd > 0 then begin
                                            //Begin Loan Product
                                            LoanT.Reset;
                                            LoanT.SetRange(LoanT."Client Code", ReceiptLine."Member No.");
                                            LoanT.SetRange(LoanT."Loan Product Type", LoanProdType);
                                            if LoanT.Find('-') then begin
                                                repeat
                                                    LoanT.CalcFields(LoanT."Outstanding Balance");
                                                    if LoanT."Outstanding Balance" > 0 then begin
                                                        if UnallocatedPerLoanProd > 0 then begin
                                                            AmountToPay := 0;
                                                            InterestTopay := 0;
                                                            //Normal Loan
                                                            InterestTopay := KNFactory.KnGetInterestBalanceOneLoan(LoanT."Loan  No.");
                                                            if InterestTopay > UnallocatedPerLoanProd then begin
                                                                InterestTopay := UnallocatedPerLoanProd
                                                            end else begin
                                                                AmountToPay := UnallocatedPerLoanProd - InterestTopay;
                                                            end;

                                                            if InterestTopay < 0 then
                                                                InterestTopay := 0;
                                                            LineNo := LineNo + 10000;
                                                            AmountToPay := FnGetLoanAmountToPay(AmountToPay, LoanT."Loan  No.");


                                                            SURESTEPFactory.FnCreateGnlJournalLine(Jtemplate, JBatch, No, LineNo, GenJournalLine."transaction type"::"Loan Repayment", GenJournalLine."account type"::Member,
                                                                                                 ReceiptLine."Member No.", "Posting date", -AmountToPay, 'BOSA', '', 'loan repayment checkoff for ' + KnGetPeriodDescription("CheckOff Period"), LoanT."Loan  No.");
                                                            //Int normal loan
                                                            LineNo := LineNo + 10000;
                                                            //AmountToPay:=FnGetLoanInterestToPay(ReceiptLine."Int normal loan",ReceiptLine."NLoan No");
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
                                            UnallocatedFunds := UnallocatedFunds + UnallocatedPerLoanProd;
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

                        /*Gnljnline.RESET;
                        Gnljnline.SETRANGE("Journal Template Name",Jtemplate);
                        Gnljnline.SETRANGE("Journal Batch Name",JBatch);
                        IF Gnljnline.FIND('-') THEN BEGIN
                         CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch",Gnljnline);
                        END;
                        Posted:=TRUE;
                        MODIFY;
                        COMMIT;*/
                        Message('Checkoff successfully Generated.Jouranls ready for posting');

                    end;
                    /*ReptProcHeader.RESET;
                    ReptProcHeader.SETRANGE(ReptProcHeader.No,No);
                    IF ReptProcHeader.FIND('-') THEN
                    REPORT.RUN(51516972,TRUE,FALSE,ReptProcHeader);*/

                end;
            }
            action("Process Checkoff Unallocated")
            {
                ApplicationArea = Basic;
                Visible = false;

                trigger OnAction()
                begin
                    MembLedg.Reset;
                    MembLedg.SetRange(MembLedg."Document No.", Remarks);
                    if MembLedg.Find('-') = false then begin
                        Error('You Can Only do this process on Already Posted Checkoffs')
                    end;
                    ReceiptLine.Reset;
                end;
            }
            action("Process Annual Charge")
            {
                ApplicationArea = Basic;
                Image = AuthorizeCreditCard;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    TestField("Document No");
                    TestField(Amount);
                    ReceiptLine.Reset;
                end;
            }
            action("Mark as Posted")
            {
                ApplicationArea = Basic;
                Enabled = not ActionEnabled;
                Image = PostBatch;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to mark this Checkoff as Posted ?', false) = true then begin
                        MembLedg.Reset;
                        MembLedg.SetRange(MembLedg."Document No.", Remarks);
                        if MembLedg.Find('-') = false then
                            Error('Sorry,You can only do this process on already posted Checkoffs');
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
                Caption = 'General Journal';
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
        ReceiptsProcessingLines: Record "Checkoff Lines-Distributed";
        LineNo: Integer;
        LBatches: Record "Loan Disburesment-Batching";
        Jtemplate: Code[30];
        JBatch: Code[30];
        "Cheque No.": Code[20];
        DActivityBOSA: Code[20];
        DBranchBOSA: Code[20];
        ReptProcHeader: Record "Checkoff Header-Distributed";
        Cust: Record "Member Register";
        MembPostGroup: Record "Customer Posting Group";
        Loantable: Record "Loans Register";
        LRepayment: Decimal;
        RcptBufLines: Record "Checkoff Lines-Distributed";
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
        ReceiptLine: Record "Checkoff Lines-Distributed";
        MembLedg: Record "Member Ledger Entry";
        SFactory: Codeunit "SURESTEP Factory";
        BATCH_NAME: Code[50];
        BATCH_TEMPLATE: Code[50];
        DOCUMENT_NO: Code[40];
        GenJournalLine: Record "Gen. Journal Line";
        ActionEnabled: Boolean;
        XMLCheckOff: XmlPort "Import Checkoff Distributed";
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
        UnallocatedFunds: Decimal;
        LoanOutstandingBalance: Decimal;
        LoanOutstandingInterest: Decimal;
        AmountToPay: Decimal;
        InterestTopay: Decimal;
        MemberTotal: Decimal;
        UnallocatedPerLoanProd: Decimal;
        LoanProductsSetup: Record "Loan Products Setup";

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
        ObjCheckOffPeriods: Record "Discounting Ledger Entry";
        Description: Text;
    begin
        // ObjCheckOffPeriods.RESET;
        // ObjCheckOffPeriods.SETRANGE(ObjCheckOffPeriods."Date Opened",Period);
        // IF ObjCheckOffPeriods.FIND('-') THEN BEGIN
        //  Description:=ObjCheckOffPeriods."Period Name";
        // END;
        //
        // EXIT(Description);
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
}

