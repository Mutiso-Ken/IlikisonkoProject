#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516562 "Post Interest Manually"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Post Interest Manually.rdlc';

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(CurrentDate; CurrentDate)
            {
            }

            trigger OnAfterGetRecord()
            begin
                TranDescription := 'Interest Due ' + Format(CurrentDate, 0, '<Month Text>') + ' ' + Format(Date2dmy(CurrentDate, 3));

                //Charge Interest //Delete journal line
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


                LoanRepaymentSchedule.Reset;
                LoanRepaymentSchedule.SetRange("Repayment Date", CurrentDate);
                if LoanRepaymentSchedule.Find('-') then begin
                    repeat
                        LoanApps.Reset();
                        LoanApps.SetRange(Posted, true);
                        LoanApps.SetRange("Stop Interest Accrual", false);
                        LoanApps.SetRange("Loan  No.", LoanRepaymentSchedule."Loan No.");
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
                        //CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Sacco",GenJournalLine);
                    end;

                end;

                //MESSAGE('Interest successfully posted');
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(CurrentDate; CurrentDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Date';
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
        if CurrentDate = 0D then
            CurrentDate := CalcDate('-0D', Today)
    end;

    var
        CurrentDate: Date;
        TranDescription: Text;
        GenBatches: Record "Gen. Journal Batch";
        GenJournalLine: Record "Gen. Journal Line";
        LoanRepaymentSchedule: Record "Loan Repayment Schedule";
        LoanApps: Record "Loans Register";
        OutBalance: Decimal;
        CustLedger: Record "Member Ledger Entry";
        LineNo: Integer;
        LoanType: Record "Loan Products Setup";
        SFactory: Codeunit "SURESTEP Factory";
        InterestDue: Decimal;
}

