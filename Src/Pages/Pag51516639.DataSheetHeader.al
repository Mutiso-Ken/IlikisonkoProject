#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516639 "Data Sheet Header"
{
    PageType = Card;
    SourceTable = "Data Sheet Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Code)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Cut Off Date"; "Cut Off Date")
                {
                    ApplicationArea = Basic;
                }
                field("Advice Period"; "Advice Period")
                {
                    ApplicationArea = Basic;
                }
                field("Period Code"; "Period Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("User ID"; "User ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Total Schedule Amount P"; "Total Schedule Amount P")
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Schedule Principal';
                    Editable = false;
                    Visible = false;
                }
                field("Total Schedule Amount I"; "Total Schedule Amount I")
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Scheduled Interest';
                    Editable = false;
                    Visible = false;
                }
                field("Total Schedule Amount D"; "Total Schedule Amount D")
                {
                    ApplicationArea = Basic;
                    Caption = 'Total Schedule Deposits';
                    Editable = false;
                    Visible = false;
                }
                field("Total Members"; "Total Members")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(Closed; Closed)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Employer Code"; "Employer Code")
                {
                    ApplicationArea = Basic;
                }
                field("Total Schedule Amount"; "Total Schedule Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = Attention;
                    StyleExpr = true;
                    Visible = false;
                }
            }
            group(Control14)
            {
            }
            part(Control13; "Data Sheet Lines")
            {
                SubPageLink = "Data Sheet Header" = field(Code);
            }
            part(Control22; "Accrued Interest Lines")
            {
                SubPageLink = "Employer Code" = field("Employer Code");
            }
        }
        area(factboxes)
        {
            part(Control25; "Data Sheet FactBox")
            {
                SubPageLink = Code = field(Code);
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
                Image = ClearLog;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    if Confirm('This Action will clear all the Lines for the current Data Main Sheet. Do you want to Continue') = false then
                        exit;
                    ObjDataSheet.Reset;
                    ObjDataSheet.SetRange(ObjDataSheet."Data Sheet Header", Code);
                    ObjDataSheet.DeleteAll;
                end;
            }
            action("Accrue Interest")
            {
                ApplicationArea = Basic;
                Image = "Report";
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    TestField("Advice Period");
                    TestField("Cut Off Date");
                    DataSheetHeader.Reset;
                    DataSheetHeader.SetRange(DataSheetHeader.Code, Code);
                    if DataSheetHeader.Find('-') then begin
                        Report.Run(51516492);
                    end;
                end;
            }
            action("Post Interest")
            {
                ApplicationArea = Basic;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'General');
                    GenJournalLine.SetRange("Journal Batch Name", 'INT DUE');
                    if GenJournalLine.Find('-') then begin
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                        Message('Interest batch Posted Successfully!');
                    end;
                end;
            }
            action("Loan Lines")
            {
                ApplicationArea = Basic;
                Caption = 'Loan Lines(F10)';
                Image = Line;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ShortCutKey = 'F10';

                trigger OnAction()
                begin
                    TestField("Employer Code");
                    TestField("Advice Period");
                    TestField("Cut Off Date");

                    ObjDataSheet.Reset;
                    ObjDataSheet.SetRange("Data Sheet Header", Code);
                    if ObjDataSheet.Find('-') then
                        ObjDataSheet.DeleteAll;

                    CheckoffCalender.Reset;
                    CheckoffCalender.SetRange("Date Opened", "Advice Period");
                    if CheckoffCalender.Find('-') then begin
                        TranDescription := 'Interest Due ' + CheckoffCalender."Period Name";
                    end;

                    //  CustLedger.RESET;
                    //  CustLedger.SETRANGE(Reversed,FALSE);
                    //  CustLedger.SETRANGE(Description,TranDescription);
                    //  CustLedger.SETRANGE("Transaction Type",CustLedger."Transaction Type"::"Interest Due");
                    //  IF CustLedger.FINDFIRST THEN BEGIN
                    //    FnLoadMembers();END;
                    //  END ELSE
                    //  ERROR('Please ensure monthly interest is processed!');
                    FnLoadMembers();
                end;
            }
            action("Export Data")
            {
                ApplicationArea = Basic;
                Image = Excel;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = XMLport "Export Data Sheet";
            }
            action("Advice Report")
            {
                ApplicationArea = Basic;
                Image = "Report";
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    ObjDataSheet.Reset;
                    ObjDataSheet.SetRange(ObjDataSheet."Data Sheet Header", Code);
                    ObjDataSheet.SetRange(ObjDataSheet.Employer, "Employer Code");
                    if ObjDataSheet.Find('-') then begin
                        Report.Run(51516940, true, false, ObjDataSheet)
                    end;
                end;
            }
        }
    }

    var
        ObjDataSheet: Record "Data Sheet Lines";
        ObjMembers: Record "Member Register";
        SFactory: Codeunit "SURESTEP Factory";
        Window: Dialog;
        TotalCount: Integer;
        Counter: Integer;
        Percentage: Integer;
        GenJournalLine: Record "Gen. Journal Line";
        GenSetup: Record "Sacco General Set-Up";
        DataSheetHeader: Record "Data Sheet Header";
        TranDescription: Text[100];
        CheckoffCalender: Record "Checkoff Calender.";
        CustLedger: Record "Member Ledger Entry";

    local procedure FnClearLines()
    begin
    end;

    local procedure FnLoadMembers()
    var
        LnReg: Record "Loans Register";
        TotalAmt: Decimal;
    begin
        TotalCount := 0;
        ObjMembers.Reset;
        ObjMembers.SetRange("Employer Code", "Employer Code");
        ObjMembers.SetFilter("Date Filter", '..' + Format("Cut Off Date"));
        ObjMembers.SetFilter(Status, '%1', ObjMembers.Status::Active);
        if ObjMembers.Find('-') then begin
            Window.Open('@1@');
            TotalCount := ObjMembers.Count;
            repeat
                FnUpdateProgressBar();
                ObjMembers.CalcFields("Outstanding Balance", "Outstanding Interest", "Current Shares");
                ObjDataSheet.Reset;
                ObjDataSheet.SetRange("Member No", ObjMembers."No.");
                ObjDataSheet.SetRange("Data Sheet Header", Code);
                if not ObjDataSheet.Find('-') then begin
                    TotalAmt := 0;
                    //Loans
                    LnReg.Reset;
                    LnReg.SetRange(LnReg."Client Code", ObjMembers."No.");
                    if LnReg.Find('-') then begin
                        repeat
                            ObjDataSheet.Init;
                            ObjDataSheet."Data Sheet Header" := Code;
                            ObjDataSheet."Data Sheet Line" := ObjDataSheet.Count + 1;
                            ObjDataSheet."Payroll No" := ObjMembers."Personal No";
                            ObjDataSheet."Member No" := ObjMembers."No.";
                            ObjDataSheet.Name := ObjMembers.Name;
                            ObjDataSheet."Checkoff Period" := "Advice Period";
                            LnReg.CalcFields("Oustanding Interest", "Outstanding Balance");
                            if LnReg."Oustanding Interest" > 0 then
                                ObjDataSheet."Outstanding Interest" := LnReg."Oustanding Interest";
                            if LnReg."Outstanding Balance" > 1 then
                                ObjDataSheet."Outstanding Balance" := LnReg."Outstanding Balance";
                            ObjDataSheet."Expected Principal Balance" := FnCalculateExpectedBalance(LnReg."Loan  No.");
                            ObjDataSheet."Principal Amount" := FnCalculatePrincipalRepayment(LnReg."Loan  No.");
                            ObjDataSheet."Loan Type" := LnReg."Loan Product Type Name";
                            ObjDataSheet."Loan No" := LnReg."Loan  No.";
                            ObjDataSheet.Repayment := ObjDataSheet."Principal Amount" + ObjDataSheet."Outstanding Interest";
                            ObjDataSheet.Employer := ObjMembers."Employer Code";
                            TotalAmt := TotalAmt + ObjDataSheet.Repayment;
                            if ObjDataSheet.Repayment > 0 then
                                ObjDataSheet.Insert;
                        until LnReg.Next = 0;
                    end;


                    //IF ObjMembers."Monthly Contribution" >0 THEN
                    // BEGIN--1--
                    ObjDataSheet.Init;
                    ObjDataSheet."Data Sheet Header" := Code;
                    ObjDataSheet."Data Sheet Line" := ObjDataSheet.Count + 1;
                    ObjDataSheet."Payroll No" := ObjMembers."Personal No";
                    ObjDataSheet."Member No" := ObjMembers."No.";
                    ObjDataSheet.Name := ObjMembers.Name;
                    ObjDataSheet."Checkoff Period" := "Advice Period";
                    ObjDataSheet."Deposit Contribution" := ObjMembers."Monthly Contribution";
                    ObjDataSheet."Kanisa Savings" := ObjMembers."Savings Monthly Contribution";
                    if ObjMembers."Registration Fee Paid" < 0 then
                        ObjDataSheet."Entrance Fees" := ObjMembers."Registration Fee Paid";
                    ObjDataSheet."Share Capital" := FnCalculateShareCapital(ObjMembers."No.");
                    ObjDataSheet.Amount := TotalAmt + ROUND((ObjDataSheet."Deposit Contribution" + ObjDataSheet."Kanisa Savings" + ObjDataSheet."Entrance Fees" + ObjDataSheet."Share Capital"), 1, '=');
                    ObjDataSheet.Employer := ObjMembers."Employer Code";
                    ObjDataSheet.Insert;
                    //END;--1--


                end;
            until ObjMembers.Next = 0;
        end;
        Window.Close;
        Message('Checkoff Advice successfully Generated');
    end;

    local procedure FnCalculateTotalRepayments(MemberNo: Code[100]): Decimal
    var
        ObjLoansRegister: Record "Loans Register";
        TotalLoanRepaymentAmount: Decimal;
        AmountToAdd: Decimal;
        ExpectedBalanceAmount: Decimal;
    begin
        TotalLoanRepaymentAmount := 0;
        ExpectedBalanceAmount := 0;
        ObjLoansRegister.Reset;
        ObjLoansRegister.SetRange("Client Code", MemberNo);
        //ObjLoansRegister.SETRANGE("Recovery Mode",ObjLoansRegister."Recovery Mode"::Checkoff);
        ObjLoansRegister.SetFilter("Repayment Start Date", '<=%1', "Cut Off Date");
        ObjLoansRegister.SetFilter("Date filter", '..' + Format("Cut Off Date"));
        if ObjLoansRegister.Find('-') then begin
            repeat
                ObjLoansRegister.CalcFields("Outstanding Balance");
                if ObjLoansRegister."Outstanding Balance" > 0 then begin
                    ExpectedBalanceAmount := SFactory.FnGetScheduledExpectedBalance(ObjLoansRegister."Loan  No.", CalcDate('<CM>', "Cut Off Date"));
                    AmountToAdd := FnAmountToAdd(ObjLoansRegister."Outstanding Balance", ExpectedBalanceAmount, ObjLoansRegister."Loan Principle Repayment", ObjLoansRegister."Client Code");
                    TotalLoanRepaymentAmount := TotalLoanRepaymentAmount + AmountToAdd;
                end;
            until ObjLoansRegister.Next = 0;
        end;
        exit(TotalLoanRepaymentAmount);
    end;

    local procedure FnAmountToAdd(OutstandingAmount: Decimal; ExpectedBalAmount: Decimal; PrincipalRepAmount: Decimal; MNO: Code[100]): Decimal
    var
        AmountToReturn: Decimal;
    begin
        AmountToReturn := PrincipalRepAmount;
        if OutstandingAmount < AmountToReturn then
            AmountToReturn := OutstandingAmount;

        if ((OutstandingAmount > PrincipalRepAmount) and (OutstandingAmount > 0)) then begin
            //AmountToReturn:=PrincipalRepAmount;
            if ((ExpectedBalAmount < (OutstandingAmount - PrincipalRepAmount)) and (ExpectedBalAmount >= 0)) then
                AmountToReturn := OutstandingAmount - ExpectedBalAmount;


        end;
        exit(AmountToReturn);
    end;

    local procedure FnUpdateProgressBar()
    begin
        Percentage := (ROUND(Counter / TotalCount * 10000, 1));
        Counter := Counter + 1;
        Window.Update(1, Percentage);
    end;

    local procedure FnCalculateTotalExpectedBalance(MemberNo: Code[100]): Decimal
    var
        ObjLoansRegister: Record "Loans Register";
        TotalLoanRepaymentAmount: Decimal;
        AmountToAdd: Decimal;
        ExpectedBalanceAmount: Decimal;
    begin
        TotalLoanRepaymentAmount := 0;
        ExpectedBalanceAmount := 0;
        ObjLoansRegister.Reset;
        ObjLoansRegister.SetRange("Client Code", MemberNo);
        ObjLoansRegister.SetFilter("Date filter", '..' + Format("Cut Off Date"));
        if ObjLoansRegister.Find('-') then begin
            repeat
                ObjLoansRegister.CalcFields("Outstanding Balance");
                if ObjLoansRegister."Outstanding Balance" > 0 then begin
                    ExpectedBalanceAmount := SFactory.FnGetScheduledExpectedBalance(ObjLoansRegister."Loan  No.", CalcDate('<CM>', "Cut Off Date"));
                    TotalLoanRepaymentAmount := TotalLoanRepaymentAmount + ExpectedBalanceAmount;
                end;
            until ObjLoansRegister.Next = 0;
        end;
        exit(TotalLoanRepaymentAmount);
    end;

    local procedure FnCalculateShareCapital(MemberNo_: Code[20]): Decimal
    var
        ObjMember: Record "Member Register";
        SharesCap: Decimal;
        UnPaidShareCapital: Decimal;
        RefDate: Date;
    begin
        UnPaidShareCapital := 0;
        GenSetup.Get();
        ObjMember.Reset;
        ObjMember.SetRange(ObjMember."No.", MemberNo_);
        if ObjMember.Find('-') then begin
            ObjMember.CalcFields(ObjMember."Shares Retained");
            if ObjMember."Shares Retained" < GenSetup."Retained Shares" then begin
                RefDate := CalcDate('<+' + GenSetup."Share Capital Period" + '>', ObjMember."Registration Date");
                if RefDate < Today then begin//Comment for testing
                    SharesCap := GenSetup."Retained Shares";
                    UnPaidShareCapital := SharesCap - ObjMember."Shares Retained";
                end;
            end;
        end;
        exit(UnPaidShareCapital);
    end;

    local procedure FnCalculatePrincipalRepayment(LoanNO: Code[100]): Decimal
    var
        ObjLoansRegister: Record "Loans Register";
        TotalLoanRepaymentAmount: Decimal;
        AmountToAdd: Decimal;
        ExpectedBalanceAmount: Decimal;
    begin
        TotalLoanRepaymentAmount := 0;
        ExpectedBalanceAmount := 0;
        ObjLoansRegister.Reset;
        ObjLoansRegister.SetRange("Loan  No.", LoanNO);
        ObjLoansRegister.SetFilter("Repayment Start Date", '<=%1', "Cut Off Date");
        ObjLoansRegister.SetFilter("Date filter", '..' + Format("Cut Off Date"));
        if ObjLoansRegister.Find('-') then begin
            ObjLoansRegister.CalcFields("Outstanding Balance");
            if ObjLoansRegister."Outstanding Balance" > 0 then begin
                ExpectedBalanceAmount := SFactory.FnGetScheduledExpectedBalance(ObjLoansRegister."Loan  No.", CalcDate('<CM>', "Cut Off Date"));
                AmountToAdd := FnAmountToAdd(ObjLoansRegister."Outstanding Balance", ExpectedBalanceAmount, ObjLoansRegister."Loan Principle Repayment", ObjLoansRegister."Client Code");
                TotalLoanRepaymentAmount := TotalLoanRepaymentAmount + AmountToAdd;
            end;
        end;
        exit(TotalLoanRepaymentAmount);
    end;

    local procedure FnCalculateExpectedBalance(LoanNO: Code[100]): Decimal
    var
        ObjLoansRegister: Record "Loans Register";
        TotalLoanRepaymentAmount: Decimal;
        AmountToAdd: Decimal;
        ExpectedBalanceAmount: Decimal;
    begin
        TotalLoanRepaymentAmount := 0;
        ExpectedBalanceAmount := 0;
        ObjLoansRegister.Reset;
        ObjLoansRegister.SetRange("Loan  No.", LoanNO);
        ObjLoansRegister.SetFilter("Date filter", '..' + Format("Cut Off Date"));
        if ObjLoansRegister.Find('-') then begin
            ObjLoansRegister.CalcFields("Outstanding Balance");
            if ObjLoansRegister."Outstanding Balance" > 0 then begin
                ExpectedBalanceAmount := SFactory.FnGetScheduledExpectedBalance(ObjLoansRegister."Loan  No.", CalcDate('<CM>', "Cut Off Date"));
                TotalLoanRepaymentAmount := TotalLoanRepaymentAmount + ExpectedBalanceAmount;
            end;
        end;
        exit(TotalLoanRepaymentAmount);
    end;

    local procedure FnCalculateInterestRepayment(LoanNO: Code[100]): Decimal
    var
        ObjLoansRegister: Record "Loans Register";
        TotalLoanRepaymentAmount: Decimal;
        AmountToAdd: Decimal;
        ExpectedBalanceAmount: Decimal;
    begin
        TotalLoanRepaymentAmount := 0;
        ExpectedBalanceAmount := 0;
        ObjLoansRegister.Reset;
        ObjLoansRegister.SetRange("Loan  No.", LoanNO);
        ObjLoansRegister.SetFilter("Repayment Start Date", '<=%1', "Cut Off Date");
        ObjLoansRegister.SetFilter("Date filter", '..' + Format("Cut Off Date"));
        if ObjLoansRegister.Find('-') then begin
            ObjLoansRegister.CalcFields("Oustanding Interest");
            if ObjLoansRegister."Oustanding Interest" > 0 then
                TotalLoanRepaymentAmount := ObjLoansRegister."Oustanding Interest";
        end;
        exit(TotalLoanRepaymentAmount);
    end;
}

