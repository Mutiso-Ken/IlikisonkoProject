#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 51516165 "Reminder Sms"
{

    trigger OnRun()
    var
        OutBalance: Decimal;
    begin

        //Date Calculations

        CurrentDate := CalcDate('2D', Today);//2


        //SendSms();
        LoanRepaymentSchedule.Reset;
        LoanRepaymentSchedule.SetRange("Repayment Date", CurrentDate);
        // LoanRepaymentSchedule.SETFILTER(LoanRepaymentSchedule."Member No.",'01597');
        if LoanRepaymentSchedule.Find('-') then begin
            if LoanApp1.Get(LoanRepaymentSchedule."Loan No.") then
                LoanApp1.CalcFields(LoanApp1."Outstanding Balance");
            Balance1 := LoanApp1."Outstanding Balance";
            if Balance1 > 0 then
                //      duedate:=LoanRepaymentSchedule."Repayment Date";
                //Duedate1:=FORMAT(LoanRepaymentSchedule."Repayment Date");
                Duedate1 := Format(LoanRepaymentSchedule."Repayment Date", 0, '<Day,2>/<Month,2>/<Year4>');

            //MESSAGE('DATE IS %1',Balance1);
            //END

            repeat
                Cust.Reset;
                Cust.SetRange(Cust."No.", LoanRepaymentSchedule."Member No.");
                //Cust.SETFILTER(Cust."Outstanding Balance",'>%1',0);
                if Cust.Find('-') then //BEGIN
                    MobileNo := Cust."Mobile Phone No";

                // END;
                ObjGenSetUp.Get;
                ObjCompInfo.Get;

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
                SMSMessage."Batch No" := LoanRepaymentSchedule."Loan No.";
                SMSMessage."Document No" := '';
                SMSMessage."Account No" := Cust."No.";
                SMSMessage."Date Entered" := Today;
                SMSMessage."Time Entered" := Time;
                SMSMessage.Source := 'COMFIRM TODAY';
                SMSMessage."Entered By" := UserId;
                SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
                SMSMessage."SMS Message" := 'Mwanachama, kumbuka kulipa mkopo wako kesho kutwa ' + Duedate1 + '. Unaweza kutuma na Pay bill 323730 Loitokitok au 323731 Kimana. Account ni membership yako.';
                SMSMessage."Telephone No" := Cust."Mobile Phone No";
                if Cust."Mobile Phone No" <> '' then
                    SMSMessage.Insert;
            until LoanRepaymentSchedule.Next = 0;
        end
    end;

    var
        CustLedger: Record "Member Ledger Entry";
        Balance1: Decimal;
        dUE1: Text;
        LoanApp1: Record "Loans Register";
        Duedate1: Text;
        LoanApps: Record "Loans Register";
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
        CurrentDate: Date;
        AniversaryDate: Date;
        LastDayOfMonth: Date;
        FirstDayOfMonth: Date;
        TotalDays: Integer;
        LoanBalasAt: Decimal;
        DailyInterestAccrual: Record "Daily Interest Accrual";
        OutBalance: Decimal;
        LoanRepaymentSchedule: Record "Loan Repayment Schedule";
        TestDay: Date;
        DUE: Date;
        ObjGenSetUp: Record "Sacco General Set-Up";
        ObjCompInfo: Record "Company Information";
        SMSMessage: Record "SMS Messages";
        iEntryNo: Integer;
        Cust: Record "Member Register";
        MobileNo: Code[30];
        duedate: Date;


    procedure SendSms()
    var
        ObjGenSetUp: Record "Sacco General Set-Up";
        ObjCompInfo: Record "Company Information";
        SMSMessage: Record "SMS Messages";
        iEntryNo: Integer;
        Cust: Record "Member Register";
        DUE: Date;
    begin


        LoanRepaymentSchedule.Reset;
        LoanRepaymentSchedule.SetRange("Repayment Date", CurrentDate);
        LoanRepaymentSchedule.SetFilter(LoanRepaymentSchedule."Loan No.", 'BLN00138');
        if LoanRepaymentSchedule.Find('-') then begin

            DUE := LoanRepaymentSchedule."Repayment Date";
            Message('CurrentDate %1', DUE);
            //   REPEAT
            //   LoanApps.RESET();
            //   LoanApps.SETRANGE(Posted,TRUE);
            //  // LoanApps.SETRANGE("Stop Interest Accrual",FALSE);
            //   LoanApps.SETRANGE("Loan  No.",LoanRepaymentSchedule."Loan No.");
            //   IF LoanApps.FIND('-') THEN BEGIN
            //      LoanApps.CALCFIELDS("Outstanding Balance");
            //
            //      OutBalance:=0;
            //
            //     IF LoanApps."Outstanding Balance">0 THEN
            //      OutBalance:=LoanApps."Outstanding Balance";
            //
            //      CustLedger.RESET;
            //      CustLedger.SETRANGE("Customer No.",LoanApps."Client Code");
            //      CustLedger.SETRANGE(Reversed,FALSE);
            //      CustLedger.SETRANGE(Description,TranDescription);
            //      CustLedger.SETRANGE("Transaction Type",CustLedger."Transaction Type"::"Loan Repayment");
            //      CustLedger.SETRANGE(Reversed,FALSE);
            //      CustLedger.SETRANGE("Loan No",LoanApps."Loan  No.");
            //      IF CustLedger.FINDFIRST THEN BEGIN
            //      END ELSE BEGIN


            ObjGenSetUp.Get;
            ObjCompInfo.Get;

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
            SMSMessage."Batch No" := 'Reminder';
            SMSMessage."Document No" := '';
            SMSMessage."Account No" := Cust."No.";
            SMSMessage."Date Entered" := Today;
            SMSMessage."Time Entered" := Time;
            SMSMessage.Source := 'Reminder';
            SMSMessage."Entered By" := UserId;
            SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
            SMSMessage."SMS Message" := 'Mwanachama, kumbuka kulipa mkopo wako kesho kutwa. Unaweza kutuma na Pay bill 323730 Loitokitok au 323731 Kimana. Account ni membership yako.';
            SMSMessage."Telephone No" := Cust."Mobile Phone No";
            if Cust."Mobile Phone No" <> '' then
                SMSMessage.Insert;

            //END;

            //END;
            // UNTIL LoanRepaymentSchedule.NEXT=0;
        end;
    end;
}

