#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516980 "Generate Monthly Interest."
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Generate Monthly Interest..rdlc';
    EnableExternalImages = true;
    ProcessingOnly = false;
    UseSystemPrinter = true;

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            CalcFields = "Outstanding Balance", "Oustanding Interest";
            DataItemTableView = where("Issued Date" = filter(<> ''), Posted = const(true));
            RequestFilterFields = "Loan  No.", "Loan Product Type", "Client Code", "Loan Disbursement Date";
            column(ReportForNavId_4645; 4645)
            {
            }
            column(LoanNo_LoansRegister; "Loans Register"."Loan  No.")
            {
            }

            trigger OnAfterGetRecord()
            var
                PayDateEndOfMonth: Integer;
                BillDateEndOfMonth: Integer;
            begin
                GenJournalLine.Reset;
                // GenJournalLine.SETRANGE("Journal Template Name",'General');
                // GenJournalLine.SETRANGE("Journal Batch Name",'INT DUE');
                // GenJournalLine.SETRANGE("Loan No","Loans Register"."Loan  No.");
                // IF GenJournalLine.FIND('-') = TRUE THEN BEGIN
                // CurrReport.SKIP;
                //   END ELSE BEGIN
                TranDescription := 'Interest Due ' + Format(CurrentDate, 0, '<Month Text>') + ' ' + Format(Date2dmy(CurrentDate, 3));

                //Charge Interest //Delete journal line
                /*GenJournalLine.RESET;
                GenJournalLine.SETRANGE("Journal Template Name",'General');
                GenJournalLine.SETRANGE("Journal Batch Name",'INT DUE');
                GenJournalLine.DELETEALL;
                //end of deletion
                */



                // LoanRepaymentSchedule.RESET;
                // LoanRepaymentSchedule.SETRANGE("Repayment Date",CurrentDate);
                // IF LoanRepaymentSchedule.FIND('-') THEN BEGIN
                //  // MESSAGE('CurrentDate %1',CurrentDate);
                //   REPEAT


                LoanApps.Reset();
                LoanApps.SetRange(Posted, true);
                LoanApps.SetRange("Stop Interest Accrual", false);
                LoanApps.SetRange(LoanApps."Loan  No.", "Loans Register"."Loan  No.");
                //LoanApps.SETFILTER(LoanApps."Expected Date of Completion",'>%1',TODAY);
                LoanApps.SetFilter(LoanApps."Issued Date", '<>%1', Today);
                //LoanApps.SETRANGE(LoanApps."Loan  No.",'3836');
                // LoanApps.SETFILTER("Outstanding Balance",'>%1',0);

                if LoanApps.Find('-') then begin
                    DueDate := CalcDate(Format(LoanApps.Installments) + 'M', LoanApps."Issued Date");
                    if DueDate >= Today then begin
                        if LoanApps."Issued Date" = CalcDate('CM', LoanApps."Issued Date") then begin
                            Endmonth31 := CalcDate('CM', CurrentDate);
                        end;
                        if ((Date2dmy(LoanApps."Issued Date", 1)) <> (Date2dmy(CurrentDate, 1))) or (Endmonth31 = 0D) then
                            CurrReport.Skip;

                        //ERROR('End %1',Endmonth31);
                        if ((Date2dmy(LoanApps."Issued Date", 1)) = (Date2dmy(CurrentDate, 1))) or ((Date2dmy(Endmonth31, 1)) = (Date2dmy(CurrentDate, 1))) then begin
                            LoanApps.CalcFields("Outstanding Balance");

                            OutBalance := 0;

                            if LoanApps."Outstanding Balance" > 0 then
                                OutBalance := LoanApps."Outstanding Balance";

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
                            InterestDue := ROUND(OutBalance * (LoanApps.Interest / 1200), 1, '>');
                            if LoanApps."Loan Product Type" = 'DIRECT CO-OP' then
                                InterestDue := ROUND(LoanApps."Approved Amount" * (LoanApps.Interest / 1200), 1, '>');
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
                    end else
                        CurrReport.Skip;
                end;

                //END;
                // UNTIL LoanRepaymentSchedule.NEXT=0;
                //END;
                //END;
                //handlele may 31 interest
                //
                //  LoanApps.RESET();
                //   LoanApps.SETRANGE(Posted,TRUE);
                //   LoanApps.SETRANGE("Stop Interest Accrual",FALSE);
                //    LoanApps.SETRANGE(LoanApps."Loan  No.","Loans Register"."Loan  No.");
                //    //LoanApps.SETFILTER(LoanApps."Expected Date of Completion",'>%1',TODAY);
                //    LoanApps.SETFILTER(LoanApps."Issued Date",'<>%1',TODAY);
                //   //LoanApps.SETRANGE(LoanApps."Loan  No.",'3836');
                //  // LoanApps.SETFILTER("Outstanding Balance",'>%1',0);
                //
                //   IF LoanApps.FIND('-') THEN BEGIN
                //      LoanApps.CALCFIELDS("Outstanding Balance");
                //
                //      OutBalance:=0;
                //
                //     IF LoanApps."Outstanding Balance">0 THEN
                //      OutBalance:=LoanApps."Outstanding Balance";
                //
                //      LineNo:=LineNo+10000;
                //      GenJournalLine.INIT;
                //      GenJournalLine."Journal Template Name":='General';
                //      GenJournalLine."Journal Batch Name":='INT DUE';
                //      GenJournalLine."Line No.":=LineNo;
                //      GenJournalLine."Account Type":=GenJournalLine."Account Type"::Member;
                //      GenJournalLine."Account No.":= LoanApps."Client Code";
                //      GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::"Additional Shares";
                //      GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                //      GenJournalLine."Document No.":='P'+FORMAT(CurrentDate,0,'<Month Text>')+FORMAT(DATE2DMY(CurrentDate,3));//Change
                //      GenJournalLine."External Document No.":=LoanApps."Staff No";
                //      GenJournalLine."Posting Date":=CurrentDate;//Change
                //      GenJournalLine.Description:=TranDescription;
                //      InterestDue:=ROUND(OutBalance*(LoanApps.Interest/1200),1,'>');
                //      IF LoanApps."Loan Product Type"='DIRECT CO-OP' THEN
                //      InterestDue:=ROUND(LoanApps."Approved Amount"*(LoanApps.Interest/1200),1,'>');
                //      //repayment method for the Loan
                //      GenJournalLine.Amount:=InterestDue;
                //      GenJournalLine.VALIDATE(GenJournalLine.Amount);
                //
                //      IF LoanType.GET(LoanApps."Loan Product Type") THEN BEGIN
                //      GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
                //      GenJournalLine."Bal. Account No.":=LoanType."Loan Interest Account";
                //      END;
                //      GenJournalLine."Shortcut Dimension 1 Code":='BOSA';
                //      GenJournalLine."Shortcut Dimension 2 Code":=SFactory.FnGetUserBranch();
                //      GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
                //      GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
                //      GenJournalLine."Loan No":= LoanApps."Loan  No.";
                //      IF GenJournalLine.Amount<>0 THEN BEGIN
                //      GenJournalLine.INSERT;
                //
                //      LoanApps."Last Interest Due Date":=CurrentDate;
                //      LoanApps.MODIFY(TRUE);
                //      END;
                //      END;
                //     }

            end;

            trigger OnPostDataItem()
            begin
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", 'General');
                GenJournalLine.SetRange("Journal Batch Name", 'INT DUE');
                if GenJournalLine.Find('-') then begin
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                end;


                // MESSAGE('Interest has been transfered to journals successfully');
            end;

            trigger OnPreDataItem()
            begin
                if CurrentDate = 0D then
                    CurrentDate := Today
                else
                    CurrentDate := CurrentDate;
                CurrentDate := CalcDate('-0D', CurrentDate);//2
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name", 'General');
                GenJournalLine.SetRange("Journal Batch Name", 'INT DUE');
                GenJournalLine.DeleteAll;

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
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Current Date"; CurrentDate)
                {
                    ApplicationArea = Basic;
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

    trigger OnInitReport()
    begin
        //Options:=Options::"Generate Only";
    end;

    var
        Gnljnline: Record "Gen. Journal Line";
        PDate: Date;
        LoansCaptionLbl: label 'Loans';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        VarienceCaptionLbl: label 'Varience';
        "Document No.": Code[20];
        RecBuffer: Record "Interest Header";
        RecBuffLines: Record "Loans Interest";
        DueDate: Date;
        LoanAmount: Decimal;
        CustMember: Record Vendor;
        Text001: label 'Document No. Must be equal to No.';
        CurrDate: Date;
        FirstMonthDate: Date;
        CurrMonth: Date;
        MidDate: Date;
        EndDate: Date;
        LastMonthDate: Date;
        FirstDay: Date;
        FirstDate: Date;
        RecBuffers: Record "Interest Header";
        LoansInterest: Record "Loans Interest";
        IntCharged: Decimal;
        Principle: Decimal;
        SuspendedInterestAccounts: Record "Suspended Interest Accounts";
        MonthDays: Integer;
        InterestDuePeriod: Record "Interest Due Period";
        dWindow: Dialog;
        CurrentRecordNo: Integer;
        NoOfRecords: Integer;
        Periodic: Codeunit "Periodic Activities";
        BillDate: Date;
        Exception: Boolean;
        ProdFact: Record "Loan Products Setup";
        Options: Option "Generate Only","Generate & Post";
        Loans: Record "Loans Register";
        PayDate: Integer;
        IntDate: Integer;
        InterestHeader: Record "Interest Header";
        CutOffDate: Date;
        LoanRepaymentSchedule: Record "Loan Repayment Schedule";
        CurrentDate: Date;
        LoanApps: Record "Loans Register";
        OutBalance: Decimal;
        CustLedger: Record "Member Ledger Entry";
        TranDescription: Text[100];
        GenBatches: Record "Gen. Journal Batch";
        LineNo: Integer;
        DocNo: Code[20];
        GenJournalLine: Record "Gen. Journal Line";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        InterestDue: Decimal;
        LoanType: Record "Loan Products Setup";
        SFactory: Codeunit "SURESTEP Factory";
        ProgressWindow: Dialog;
        Ct: Integer;
        LoanProductsSetup: Record "Loan Products Setup";
        AniversaryDate: Date;
        LastDayOfMonth: Date;
        FirstDayOfMonth: Date;
        TotalDays: Integer;
        LoanBalasAt: Decimal;
        DailyInterestAccrual: Record "Daily Interest Accrual";
        TestDay: Date;
        IssueDay: Integer;
        Daytoday: Integer;
        Endmonth31: Date;
}

