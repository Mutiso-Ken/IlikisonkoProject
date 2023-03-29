#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516492 "Process Loan Monthly Interest"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Process Loan Monthly Interest.rdlc';

    dataset
    {
        dataitem(Loans; "Loans Register")
        {
            CalcFields = "Outstanding Balance";
            DataItemTableView = where("Outstanding Balance" = filter(> 0));
            RequestFilterFields = "Date filter", Source, "Repayment Start Date", "Loan  No.", "Client Code", "Account No", "Loan Product Type";
            column(ReportForNavId_4645; 4645)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(USERID; UserId)
            {
            }
            column(LoanNo; "Loan  No.")
            {
            }
            column(ProductType; "Loan Product Type")
            {
            }
            column(ApprovedAmount; Loans."Approved Amount")
            {
            }
            column(LoansApplicationDate; "Application Date")
            {
            }
            column(IssuedDate; Loans."Issued Date")
            {
            }
            column(RepaymentStartDate; Loans."Repayment Start Date")
            {
            }
            column(ClientCode; "Client Code")
            {
            }
            column(ClientName; "Client Name")
            {
            }
            column(OutstandingBalance; "Outstanding Balance")
            {
            }
            column(InterestDue; InterestDue)
            {
            }

            trigger OnAfterGetRecord()
            begin
                LoanBalasAt := 0;
                CustLedger.Reset;
                CustLedger.SetRange(CustLedger."Customer No.", Loans."Client Code");
                CustLedger.SetRange(CustLedger."Loan No", Loans."Loan  No.");
                CustLedger.SetFilter(CustLedger."Posting Date", '<=%1', FirstDay);
                if CustLedger.Find('-') then begin
                    repeat
                        if (CustLedger."Transaction Type" = CustLedger."transaction type"::"Loan Repayment") or
                           (CustLedger."Transaction Type" = CustLedger."transaction type"::Loan) then begin
                            LoanBalasAt := LoanBalasAt + CustLedger.Amount;
                        end;
                    until CustLedger.Next = 0;
                end;

                if (Loans."Loan Product Type" = 'INSTANT') or (Loans."Loan Product Type" = 'KARIBU') or (Loans."Loan Product Type" = 'SUKUMA') then begin
                    CurrReport.Skip;
                end else begin
                    if SURESTEPFactory.knCheckIfMemberIsWithdrawn(Loans."Client Code") then
                        CurrReport.Skip;
                    if SURESTEPFactory.KnCheckIfMemberHasWithdrawalNotice(Loans."Client Code") then
                        CurrReport.Skip;

                    if Loans."Loan Disbursement Date" <= Date15 then begin
                        CustLedger.Reset;
                        CustLedger.SetRange("Customer No.", Loans."Client Code");
                        CustLedger.SetRange(Reversed, false);
                        CustLedger.SetRange(Description, TranDescription);
                        CustLedger.SetRange("Transaction Type", CustLedger."transaction type"::"Interest Due");
                        CustLedger.SetRange(Reversed, false);
                        CustLedger.SetRange("Loan No", Loans."Loan  No.");
                        if CustLedger.FindFirst then
                            CurrReport.Skip;

                        LineNo := LineNo + 10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name" := 'General';
                        GenJournalLine."Journal Batch Name" := 'INT DUE';
                        GenJournalLine."Line No." := LineNo;
                        GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                        GenJournalLine."Account No." := Loans."Client Code";
                        GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Additional Shares";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No." := DocNo;
                        GenJournalLine."External Document No." := Loans."Staff No";
                        GenJournalLine."Posting Date" := PostDate;
                        GenJournalLine.Description := TranDescription;
                        if LoanBalasAt = 0 then LoanBalasAt := Loans."Outstanding Balance";
                        InterestDue := ROUND(LoanBalasAt * (Loans.Interest / 1200), 1, '>');
                        //InterestDue:=ROUND(Loans."Outstanding Balance"*(Loans.Interest/1200),1,'>');
                        if loanapp."Repayment Method" = Loans."repayment method"::"Straight Line" then
                            InterestDue := ROUND(Loans."Approved Amount" * (Loans.Interest / 1200), 1, '>');
                        GenJournalLine.Amount := InterestDue;
                        GenJournalLine.Validate(GenJournalLine.Amount);

                        if LoanType.Get(Loans."Loan Product Type") then begin
                            GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                            GenJournalLine."Bal. Account No." := LoanType."Loan Interest Account";
                            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                        end;
                        GenJournalLine."Shortcut Dimension 1 Code" := Format(Loans.Source);
                        GenJournalLine."Shortcut Dimension 2 Code" := Loans."Branch Code";
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        GenJournalLine."Loan No" := Loans."Loan  No.";
                        if GenJournalLine.Amount <> 0 then
                            GenJournalLine.Insert;

                        ObjInterestDue.Init;
                        ObjInterestDue."Document No" := DocNo;
                        ObjInterestDue."Transaction Date" := PostDate;
                        ObjInterestDue."Member No" := Loans."Client Code";
                        ObjInterestDue."Member Name" := Loans."Client Name";
                        ObjInterestDue."Employer Code" := Loans."Employer Code";
                        ObjInterestDue."Loan Product" := Loans."Loan Product Type";
                        ObjInterestDue."Loan No" := Loans."Loan  No.";
                        ObjInterestDue."Approved Amount" := Loans."Approved Amount";
                        ObjInterestDue."Outstanding Balance" := Loans."Outstanding Balance";
                        ObjInterestDue."Interest Rate" := Loans.Interest / 12;
                        ObjInterestDue."Interest Accrued" := InterestDue;
                        ObjInterestDue."User ID" := UserId;
                        ObjInterestDue.Insert;
                    end else
                        CurrReport.Skip;
                end;
            end;

            trigger OnPreDataItem()
            begin

                if InterestPeriod = 0D then
                    Error('Please select Interest period');
                PostDate := FirstDay;
                if DocNo = '' then
                    Error('You must specify the Document No.');

                CheckoffCalender.Reset;
                CheckoffCalender.SetRange("Date Opened", InterestPeriod);
                if CheckoffCalender.Find('-') then begin
                    TranDescription := 'Interest Due ' + CheckoffCalender."Period Name";
                end;

                //delete journal line
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", 'General');
                GenJournalLine.SetRange("Journal Batch Name", 'INT DUE');
                GenJournalLine.DeleteAll;
                //end of deletion

                GenBatches.Reset;
                GenBatches.SetRange(GenBatches."Journal Template Name", 'General');
                GenBatches.SetRange(GenBatches.Name, 'INT DUE');
                if GenBatches.Find('-') = false then begin
                    GenBatches.Init;
                    GenBatches."Journal Template Name" := 'General';
                    GenBatches.Name := 'INT DUE';
                    GenBatches.Description := 'Interest Due';
                    GenBatches.Insert;
                end;
                ObjInterestDue.Reset;
                ObjInterestDue.SetRange("Document No", DocNo);
                ObjInterestDue.SetRange(Posted, false);
                ObjInterestDue.DeleteAll;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Interest Period"; InterestPeriod)
                {
                    ApplicationArea = Basic;
                    Caption = 'Interest Period';
                    TableRelation = "Checkoff Calender."."Date Opened";
                }
                field(DocNo; DocNo)
                {
                    ApplicationArea = Basic;
                    Caption = 'Document No.';
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        FirstDay := CalcDate('<-CM>', InterestPeriod);
        TranDescription := 'Interest Due ' + Format(InterestPeriod, 0, '<Month Text>') + Format(Date2dmy(InterestPeriod, 3));
    end;

    var
        GenBatches: Record "Gen. Journal Batch";
        PDate: Date;
        LoanType: Record "Loan Products Setup";
        PostDate: Date;
        Cust: Record "Member Register";
        LineNo: Integer;
        DocNo: Code[20];
        GenJournalLine: Record "Gen. Journal Line";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        EndDate: Date;
        DontCharge: Boolean;
        Temp: Record "Funds General Setup";
        JBatch: Code[10];
        Jtemplate: Code[10];
        CustLedger: Record "Member Ledger Entry";
        AccountingPeriod: Record "Interest Due Period";
        FiscalYearStartDate: Date;
        "ExtDocNo.": Text[30];
        Loan_Application_FormCaptionLbl: label 'Loan Application Form';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        loanapp: Record "Loans Register";
        SDATE: Text[30];
        InterestDue: Decimal;
        ObjInterestDue: Record "Monthly Interest Acrual";
        Date15: Date;
        SaccoGeneralSetUp: Record "Sacco General Set-Up";
        SURESTEPFactory: Codeunit "SURESTEP Factory";
        EmployerCode: Code[30];
        SaccoEmployers: Record "Sacco Employers";
        InterestPeriod: Date;
        TranDescription: Text[100];
        CheckoffCalender: Record "Checkoff Calender.";
        FirstDay: Date;
        DFilter: Text;
        LoanBalasAt: Decimal;
        ReferenceDate: Decimal;

    local procedure FnStaffnumber(MemberNumber: Code[100]): Code[100]
    var
        ObjMembers: Record "Member Register";
    begin
        ObjMembers.Reset;
        ObjMembers.SetRange("No.", MemberNumber);
        if ObjMembers.Find('-') then begin
            exit(ObjMembers."Personal No");
        end;
    end;
}

