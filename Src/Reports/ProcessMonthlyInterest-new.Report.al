#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516508 "Process Monthly Interest-new"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Process Monthly Interest-new.rdlc';

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
                CurrentDate := CalcDate('-0D', Today);
                TranDescription := 'Interest Due ' + Format(CurrentDate, 0, '<Month Text>') + ' ' + Format(Date2dmy(CurrentDate, 3));

                LoanRepaymentSchedule.Reset;
                LoanRepaymentSchedule.SetRange("Repayment Date", CurrentDate);
                if LoanRepaymentSchedule.Find('-') then begin
                    // MESSAGE('CurrentDate %1',CurrentDate);
                    repeat
                        LoanApps.Reset();
                        LoanApps.SetRange(Posted, true);
                        LoanApps.SetRange("Stop Interest Accrual", false);
                        LoanApps.SetRange("Loan  No.", LoanRepaymentSchedule."Loan No.");
                        //LoanApps.SETRANGE(LoanApps."Loan  No.",'3836');
                        // LoanApps.SETFILTER("Outstanding Balance",'>%1',0);
                        if LoanApps.Find('-') then begin
                            LoanApps.CalcFields("Outstanding Balance");

                            OutBalance := 0;

                            if LoanApps."Outstanding Balance" > 0 then
                                OutBalance := LoanApps."Outstanding Balance";

                            CustLedger.Reset;
                            CustLedger.SetRange("Customer No.", LoanApps."Client Code");
                            CustLedger.SetRange(Reversed, false);
                            CustLedger.SetRange(Description, TranDescription);
                            CustLedger.SetRange("Transaction Type", CustLedger."transaction type"::"Interest Due");
                            CustLedger.SetRange(Reversed, false);
                            CustLedger.SetRange("Loan No", LoanApps."Loan  No.");
                            if CustLedger.FindFirst then begin
                            end else begin

                                LineNo := LineNo + 10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'General';
                                GenJournalLine."Journal Batch Name" := 'INT DUE';
                                GenJournalLine."Line No." := LineNo;
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                                GenJournalLine."Account No." := LoanApps."Client Code";
                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Additional Shares";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Document No." := Format(CurrentDate, 0, '<Month Text>') + Format(Date2dmy(CurrentDate, 3));//Change
                                GenJournalLine."External Document No." := LoanApps."Staff No";
                                GenJournalLine."Posting Date" := CurrentDate;//Change
                                GenJournalLine.Description := TranDescription;
                                InterestDue := ROUND(OutBalance * (LoanRepaymentSchedule."Interest Rate" / 1200), 1, '>');
                                if LoanApps."Loan Product Type" = 'DIRECT CO-OP' then
                                    InterestDue := ROUND(LoanApps."Approved Amount" * (LoanRepaymentSchedule."Interest Rate" / 1200), 1, '>');
                                //repayment method for the Loan
                                GenJournalLine.Amount := InterestDue;
                                GenJournalLine.Validate(GenJournalLine.Amount);

                                if LoanType.Get(LoanApps."Loan Product Type") then begin
                                    GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                    GenJournalLine."Bal. Account No." := LoanType."Loan Interest Account";
                                end;
                                GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                GenJournalLine."Shortcut Dimension 2 Code" := SFactory.FnGetUserBranch();
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                GenJournalLine."Loan No" := LoanApps."Loan  No.";
                                if GenJournalLine.Amount <> 0 then begin
                                    GenJournalLine.Insert;

                                    LoanApps."Last Interest Due Date" := CurrentDate;
                                    LoanApps.Modify(true);
                                end;
                            end;
                        end;

                    until LoanRepaymentSchedule.Next = 0;

                    //Post Interest
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'General');
                    GenJournalLine.SetRange("Journal Batch Name", 'INT DUE');
                    if GenJournalLine.Find('-') then begin
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                    end;

                end;
            end;

            trigger OnPreDataItem()
            begin


                if Usersetup.Get(UserId) then begin
                    if Usersetup."Post Interest" = false then Error('You do not have permissions for Post interest, Contact your system administrator! ')
                end;

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
                CurrentDate := CalcDate('-0D', Today);
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

        CurrentDate := CalcDate('-0D', Today);
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
        LoanRepaymentSchedule: Record "Loan Repayment Schedule";
        CurrentDate: Date;
        LoanApps: Record "Loans Register";
        OutBalance: Decimal;
        SFactory: Codeunit "SURESTEP Factory";
        Usersetup: Record "User Setup";

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

