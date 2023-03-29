#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 51516014 "Periodic Activities"
{

    trigger OnRun()
    var
        DailyLoansInterestBuffer: Record "File Types SetUp";
    begin
        //GenerateDailyInterest(DailyLoansInterestBuffer);
    end;

    var
        LoanNo: Code[20];
        BDate: Date;
        BalDate: Date;
        ProdFact: Record "Loan Products Setup";
        InterestAmount: Decimal;
        iEntryNo: Integer;
        Temp: Record "Funds User Setup";
        CreditAccounts: Record "Member Register";
        CutOffDate: Date;
        LoanRepaymentSchedule: Record "Loan Repayment Schedule";
        LoanApps: Record "Loans Register";
        OutBalance: Decimal;
        CustLedger: Record "Member Ledger Entry";
        TranDescription: Text[100];


    procedure GenerateLoanMonthlyInterest(var LoanNo: Code[20];BDate: Date)
    var
        Loans: Record "Loans Register";
        LoanType: Record "Loan Products Setup";
        Gnljnline: Record "Gen. Journal Line";
        LineNo: Integer;
        DocNo: Code[20];
        PDate: Date;
        "Document No.": Code[20];
        InterestHeader: Record "Interest Header";
        LoansInterest: Record "Loans Interest";
        LoanAmount: Decimal;
        CustMember: Record Vendor;
        CurrDate: Date;
        FirstMonthDate: Date;
        CurrMonth: Date;
        MidDate: Date;
        EndDate: Date;
        LastMonthDate: Date;
        FirstDay: Date;
        FirstDate: Date;
        IntCharged: Decimal;
        Principle: Decimal;
        GeneralSetUp: Record "Sacco General Set-Up";
        Memb: Record "Member Register";
        BalDate: Date;
        SuspendedInterestAccounts: Record "Suspended Interest Accounts";
    begin
        ///***************************************************************************///
        if not InterestHeader.Get('INTEREST') then begin
            InterestHeader.Init;
            InterestHeader."No.":='INTEREST';
            InterestHeader.Status:=InterestHeader.Status::Approved;
            InterestHeader.Insert;
        end;
        
        
        BalDate:=CalcDate('CM',BDate);
        //MESSAGE('fgyug %1',BalDate);
        if Loans."Stop Interest Accrual"=false then begin
        Loans.Reset;
        Loans.SetRange("Loan  No.",LoanNo);
        Loans.SetFilter("Interest Calculation Method",'<>%1',Loans."interest calculation method"::"Flat Rate");
        //Loans.SETFILTER("Date filter",'..%1',BalDate);
        Loans.SetFilter("Outstanding Balance",'>0');
        if Loans.Find('-') then begin
           Loans.CalcFields("Outstanding Balance","Oustanding Interest");
          //MESSAGE('007 %1 | Prod %2',Loans."Loan  No.",Loans."Loan Product Type");
        
            repeat
                InterestAmount:=ROUND(GetInterestAmount(Loans."Loan  No.",BDate,false),0.01,'>');
                LoansInterest.Reset;
                LoansInterest.SetRange(No,'INTEREST');
                LoansInterest.SetRange("Loan No.",Loans."Loan  No.");
                LoansInterest.SetRange("Interest Date",BDate);
                LoansInterest.SetRange(Reversed,false);
                if LoansInterest.FindFirst then begin
                    if LoansInterest.Posted then
                      InterestAmount:=0
                    else
                      LoansInterest.Delete;
                end;
        
        
        
                if InterestAmount > 0 then begin
                    Loans.CalcFields(Loans."Outstanding Balance",Loans."Oustanding Interest");
                    //MESSAGE('InterestAmount %1',InterestAmount);
                    LoansInterest.Init;
                    LoansInterest.No:='INTEREST';
                    LoansInterest."Auto Interest":=true;
                    LoansInterest."Loan No.":=Loans."Loan  No.";
                    LoansInterest."Account Type":=LoansInterest."account type"::Credit;
                    LoansInterest."Account No":=Loans."Client Code";
                    LoansInterest."Issued Date":=Loans."Issued Date";
        
                    //LoansInterest."Interest Date":=CALCDATE('-cm',TODAY);
                    LoansInterest."Interest Date":=BDate;
                   // MESSAGE('date %1',LoansInterest."Interest Date");
                    LoansInterest."Repayment Amount":=Loans.Repayment;
                    LoansInterest."Repayment Bill":=0;
                    LoansInterest."Interest Amount":=InterestAmount;
                    LoansInterest."Interest Bill":=InterestAmount;
                    LoansInterest.Description:='Interest Due'+' '+CopyStr(Format(BDate,0,'<Month Text>'),1,3) +' '+ Format(Date2dmy(BDate,3));
                    LoansInterest."Shortcut Dimension 1 Code":=Loans."Global Dimension 1 Code";
                    LoansInterest."Shortcut Dimension 2 Code":=Loans."Branch Code";
                    LoansInterest."Monthly Repayment":=Loans.Repayment;
                    LoansInterest."Loan Product type":=Loans."Loan Product Type";
                   //
        
        
                    //Loans.CALCFIELDS("Loans Category-SASRA");
                    if LoanType.Get(Loans."Loan Product Type") then begin
                       LoanType.TestField(LoanType."Loan Interest Account");
                       LoansInterest."Bal. Account No.":=LoanType."Loan Interest Account";
        
                        //IF (Loans."Loans Category"<>Loans."Loans Category"::Loss) THEN BEGIN
                        /*IF Loans."Outstanding Balance">Loans."Oustanding Interest" THEN BEGIN
        
                            LoanType.TESTFIELD(LoanType."Loan Interest Account");
                            LoansInterest."Bal. Account No.":=LoanType."Loan Interest Account";
                            //LoansInterest."Bill Account":= LoansInterest."Bal. Account No.";
                        END;*/
        
                        /*ELSE BEGIN
        
                            SuspendedInterestAccounts.RESET;
                            SuspendedInterestAccounts.SETRANGE("Loan No.",Loans."Loan  No.");
                            SuspendedInterestAccounts.SETRANGE("Interest Date",BDate);
                            IF SuspendedInterestAccounts.FINDFIRST THEN
                              SuspendedInterestAccounts.DELETE;
        
        
                            //LoanType.TESTFIELD(LoanType."Suspend Interest Account [G/L]");
                            LoansInterest."Bal. Account No.":=LoanType."Suspend Interest Account [G/L]";
                            LoansInterest."Bill Account":= LoansInterest."Bal. Account No.";
                            //Insert Entries to buffer
                            iEntryNo:=SuspendedInterestAccounts.COUNT;
                            iEntryNo:=iEntryNo+1;
                            SuspendedInterestAccounts.INIT;
                            SuspendedInterestAccounts."Entry No.":=iEntryNo;
                            SuspendedInterestAccounts."Loan No.":=Loans."Loan  No.";
                            SuspendedInterestAccounts."Loan Product type":=LoanType.Code;
                            SuspendedInterestAccounts."Loans Category-SASRA":=Loans."Loans Category-SASRA";
                            SuspendedInterestAccounts."Interest Amount":=InterestAmount;
                            SuspendedInterestAccounts."Interest Date":=BDate;
                            SuspendedInterestAccounts."Issued Date":=Loans."Loan Disbursement Date";
                            SuspendedInterestAccounts.INSERT(TRUE);
        
        
                        END;*/
                    end;
        
                    if CustMember.Get(Loans."Client Code") then begin
                        LoansInterest.Status:=CustMember.Status;
                        LoansInterest.Blocked:=CustMember.Blocked;
                    end;
        
                    LoansInterest."Outstanding Balance":=Loans."Outstanding Balance";
                    LoansInterest."Outstanding Interest":=Loans."Oustanding Interest";
                    LoansInterest.Insert;
        
                end;
            until Loans.Next=0;
        
        end;
        end;

    end;


    procedure GetInterestAmount(LoanNo: Code[20];IntDate: Date;CheckExistingBill: Boolean): Decimal
    var
        LoanRec: Record "Loans Register";
        CLedger: Record "Member Ledger Entry";
        RSchedule: Record "Loan Repayment Schedule";
        LastDate: Date;
        IntAmount: Decimal;
        LoanBalance: Decimal;
        BalDate: Date;
    begin
        //BalDate:=CALCDATE('-1M+CM',TODAY);
        LoanRec.Get(LoanNo);
        if ProdFact.Get(LoanRec."Loan Product Type") then
        LoanRec.Reset;
        LoanRec.SetRange("Loan  No.",LoanNo);
        //LoanRec.SETFILTER("Date filter",'..%1',BalDate);
        LoanRec.SetFilter("Outstanding Balance",'<=0');
        if LoanRec.FindFirst then
            exit(0);
        
        if CheckExistingBill then begin
            CLedger.Reset;
            CLedger.SetRange("Loan No",LoanNo);
            CLedger.SetRange("Transaction Type",CLedger."transaction type"::"Interest Due");
            CLedger.SetFilter("Posting Date",'%1..%2',CalcDate('-CM',IntDate),CalcDate('CM',IntDate));
            //CLedger.SETFILTER("Posting Date",'%1..%2',20180608D,CALCDATE('CM',IntDate));
            CLedger.SetFilter(Amount,'>0');
            CLedger.SetRange(Reversed,false);
            if CLedger.FindFirst then
                exit(0);
        end;
        
        /*
        RSchedule.RESET;
        RSchedule.SETRANGE("Loan No.",LoanRec."Loan  No.");
        RSchedule.SETFILTER("Principal Repayment",'>0');
        IF NOT RSchedule.FINDFIRST THEN*/
          //LoansProcess.GenerateRepaymentSchedule(LoanRec);
        
        
        RSchedule.Reset;
        RSchedule.SetRange("Loan No.",LoanRec."Loan  No.");
        RSchedule.SetFilter("Principal Repayment",'>0');
        if not RSchedule.FindFirst then
        
        LoanBalance:=0;
        IntAmount:=0;
        
        LoanRec.Reset;
        LoanRec.SetRange("Loan  No.",LoanNo);
        //LoanRec.SETFILTER("Date filter",'..%1',BalDate);
        if LoanRec.FindFirst then begin
        //MESSAGE('stella %1',LoanRec."Loan  No.");
            LoanRec.CalcFields("Outstanding Balance","Oustanding Interest");
            LoanBalance:=LoanRec."Outstanding Balance";
        
            if LoanBalance<0 then
              LoanBalance:=0;
            /*EVALUATE(CutOffDate,'01/01/19');
            IF LoanRec."Loan Disbursement Date"<CutOffDate THEN BEGIN
               //MESSAGE('Disbursement Date %1',LoanRec."Loan Disbursement Date");
              IntAmount := ROUND(LoanBalance*LoanRec.Interest/1200,1,'>');
            //MESSAGE('Interest %1 LoanBalance %2',LoanBalance,LoanRec.Interest);
            END ELSE BEGIN*/
            ProdFact.Get(LoanRec."Loan Product Type");
            case LoanRec."Repayment Method" of
                 LoanRec."repayment method"::Amortised:
                      IntAmount:=ROUND((LoanBalance/1200)*ProdFact."Interest rate",1,'>');
                 LoanRec."repayment method"::"Straight Line":
                       IntAmount:=LoanRec."Schedule Interest";
                      //IntAmount:={ROUND((ProdFact."Interest rate"/1200)*LoanRec."Approved Amount",1,'>')};
                 LoanRec."repayment method"::"Reducing Balance":
                      IntAmount:=ROUND((ProdFact."Interest rate"/12/100)*LoanBalance,1,'>');
                 LoanRec."repayment method"::Constants:
                      IntAmount:=ProdFact."Interest rate";
              end;
        
           // IntAmount :=ROUND(LoanBalance*ProdFact."Interest rate"/1200,1,'>');
            //MESSAGE('IntAmount %1',IntAmount);
        
        end;
            //MESSAGE('IntAmount %1',IntAmount);
        //END;
        
        if IntAmount < 0 then
          IntAmount:=0;
        
        
        
        exit(IntAmount);

    end;


    procedure PostLoanInterest(InterestBufferBillAndAccrue: Record "Interest Header")
    var
        PeriodicActivities: Codeunit "Periodic Activities";
        members: Record "Member Register";
        GenBatches: Record "Gen. Journal Batch";
        PDate: Date;
        LoanType: Record "Loan Products Setup";
        PostDate: Date;
        LineNo: Integer;
        DocNo: Code[20];
        GenJournalLine: Record "Gen. Journal Line";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        EndDate: Date;
        DontCharge: Boolean;
        JBatch: Code[10];
        Jtemplate: Code[10];
        CustLedger: Record "Interest Due Period";
        AccountingPeriod: Record "Interest Due Period";
        FiscalYearStartDate: Date;
        "ExtDocNo.": Text[30];
        InterestDue: Decimal;
        LoansInterest: Record "Loans Interest";
    begin
        with InterestBufferBillAndAccrue do begin

            if "No."<>'INTEREST' then
                Error('Invalid Interest Posting');


            Temp.Get(UserId);
            //MESSAGE('user %1',USERID);

            Jtemplate:=Temp."FundsTransfer Template Name";
            //MESSAGE('template %1',Jtemplate);
            JBatch:=Temp."FundsTransfer Batch Name";
            //MESSAGE('batch %1',JBatch);

            if Jtemplate='' then
                Error('Interest Template not Setup');

            if JBatch='' then
                Error('Interest Batch not Setup');

            LoansInterest.Reset;
            LoansInterest.SetRange(LoansInterest.No,"No.");
            LoansInterest.SetRange(Posted,false);
            LoansInterest.SetFilter("Interest Amount",'>0');
            if LoansInterest.Find('-') then begin
               //IF LoansInterest."Bal. Account No."='' THEN

               //MESSAGE('int %1',LoansInterest.No);
                repeat

                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name",Jtemplate);
                    GenJournalLine.SetRange("Journal Batch Name",JBatch);
                    if GenJournalLine.FindFirst then
                    GenJournalLine.DeleteAll;

                    "Document No.":='INTEREST';

                    if CreditAccounts.Get(LoansInterest."Account No") then begin

                        if LoansInterest."Interest Amount"> 0 then begin
                           //MESSAGE('mmh');
                            LineNo:=LineNo+1000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name":=Jtemplate;
                            GenJournalLine."Journal Batch Name":=JBatch;
                            GenJournalLine."Line No.":=LineNo;
                            GenJournalLine."Posting Date":=LoansInterest."Interest Date";
                            //MESSAGE('daTE %1',LoansInterest."Interest Date");
                            GenJournalLine."Account Type":=GenJournalLine."account type"::Member;
                            //GenJournalLine."Account Type":=LoansInterest."Account Type";
                            GenJournalLine."Account No.":=LoansInterest."Account No";
                            GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Additional Shares";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No.":=LoansInterest."Loan No.";
                            GenJournalLine."Shortcut Dimension 2 Code":=CreditAccounts."Global Dimension 2 Code";
                            //MESSAGE('doc %1',LoansInterest."Loan No.");
                            //LoansInterest.CALCFIELDS(LoansInterest."Total Repayment");
                            GenJournalLine."Shortcut Dimension 1 Code":=LoansInterest."Shortcut Dimension 1 Code";
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine."Shortcut Dimension 2 Code":=LoansInterest."Shortcut Dimension 2 Code";
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            GenJournalLine.Amount:=LoansInterest."Interest Amount";
                            //GenJournalLine.Amount:=LoansInterest."Interest Bill";
                            //MESSAGE('int amount %1',LoansInterest."Interest Bill");
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine.Description:=LoansInterest.Description;
                            GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"G/L Account";
                            GenJournalLine."Bal. Account No.":=LoansInterest."Bal. Account No.";
                            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                            GenJournalLine."Loan No":=LoansInterest."Loan No.";
                            if GenJournalLine.Amount<>0 then
                                GenJournalLine.Insert;

                        end;


                        //Post New
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name",Jtemplate);
                        GenJournalLine.SetRange("Journal Batch Name",JBatch);
                        if GenJournalLine.Find('-') then begin
                           Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco",GenJournalLine);
                           //CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post New",GenJournalLine);
                          //(CODEUNIT::"Gen. Jnl.-Post",Rec)
                        end;
                        //Post New

                        LoansInterest.Transferred:=true;
                        LoansInterest.Posted:=true;
                        LoansInterest.Modify;
                        Commit;


                    end;
                until LoansInterest.Next=0;
            end;


            Posted:=true;
            "Posted By":=UserId;
            "Posting Date":=Today;
            Modify;

            Message('Posted Successfully');
        end;
    end;

    local procedure GenerateLoansSchedule()
    begin
    end;


    procedure InsertAcc()
    begin
    end;


    procedure "GenerateLoanMonthlyInterest-New"(var LoanNo: Code[20];BDate: Date)
    var
        Loans: Record "Loans Register";
        LoanType: Record "Loan Products Setup";
        Gnljnline: Record "Gen. Journal Line";
        LineNo: Integer;
        DocNo: Code[20];
        PDate: Date;
        "Document No.": Code[20];
        InterestHeader: Record "Interest Header";
        LoansInterest: Record "Loans Interest";
        LoanAmount: Decimal;
        CustMember: Record Vendor;
        CurrDate: Date;
        FirstMonthDate: Date;
        CurrMonth: Date;
        MidDate: Date;
        EndDate: Date;
        LastMonthDate: Date;
        FirstDay: Date;
        FirstDate: Date;
        IntCharged: Decimal;
        Principle: Decimal;
        GeneralSetUp: Record "Sacco General Set-Up";
        Memb: Record "Member Register";
        BalDate: Date;
        SuspendedInterestAccounts: Record "Suspended Interest Accounts";
    begin
        ///***************************************************************************///
        if not InterestHeader.Get('INTEREST') then begin
            InterestHeader.Init;
            InterestHeader."No.":='INTEREST';
            InterestHeader.Status:=InterestHeader.Status::Approved;
            InterestHeader.Insert;
        end;
        
        
        BalDate:=CalcDate('CM',BDate);
        
        TranDescription:='Interest Due '+Format(BalDate,0,'<Month Text>')+' '+Format(Date2dmy(BalDate,3));
        //MESSAGE('fgyug %1',BalDate);
        if Loans."Stop Interest Accrual"=false then begin
        Loans.Reset;
        Loans.SetRange("Loan  No.",LoanNo);
        Loans.SetFilter("Interest Calculation Method",'<>%1',Loans."interest calculation method"::"Flat Rate");
        //Loans.SETFILTER("Date filter",'..%1',BalDate);
        Loans.SetFilter("Outstanding Balance",'>0');
        if Loans.Find('-') then begin
           Loans.CalcFields("Outstanding Balance","Oustanding Interest");
          //MESSAGE('007 %1 | Prod %2',Loans."Loan  No.",Loans."Loan Product Type");
        
            repeat
                //InterestAmount:=ROUND(GetInterestAmount(Loans."Loan  No.",BDate,FALSE),0.01,'>');
                LoansInterest.Reset;
                LoansInterest.SetRange(No,'INTEREST');
                LoansInterest.SetRange("Loan No.",Loans."Loan  No.");
                LoansInterest.SetRange("Interest Date",BDate);
                LoansInterest.SetRange(Reversed,false);
                if LoansInterest.FindFirst then begin
                    if LoansInterest.Posted then
                      InterestAmount:=0
                    else
                      LoansInterest.Delete;
                end;
        
        
        
        //interestAmount calculation
        LoanRepaymentSchedule.Reset;
        LoanRepaymentSchedule.SetRange("Repayment Date",BalDate);
        if LoanRepaymentSchedule.Find('-') then begin
          // MESSAGE('CurrentDate %1',CurrentDate);
        
           LoanApps.Reset();
           LoanApps.SetRange(Posted,true);
           LoanApps.SetRange("Stop Interest Accrual",false);
           LoanApps.SetRange("Loan  No.",LoanRepaymentSchedule."Loan No.");
           //LoanApps.SETRANGE(LoanApps."Loan  No.",'3836');
          // LoanApps.SETFILTER("Outstanding Balance",'>%1',0);
           if LoanApps.Find('-') then begin
              LoanApps.CalcFields("Outstanding Balance");
        
              OutBalance:=0;
        
             if LoanApps."Outstanding Balance">0 then
              OutBalance:=LoanApps."Outstanding Balance";
        
              CustLedger.Reset;
              CustLedger.SetRange("Customer No.",LoanApps."Client Code");
              CustLedger.SetRange(Reversed,false);
              CustLedger.SetRange(Description,TranDescription);
              CustLedger.SetRange("Transaction Type",CustLedger."transaction type"::"Interest Due");
              CustLedger.SetRange(Reversed,false);
              CustLedger.SetRange("Loan No",LoanApps."Loan  No.");
              if CustLedger.FindFirst then begin
              end else begin
        
        
             InterestAmount:=ROUND(OutBalance*(LoanRepaymentSchedule."Interest Rate"/1200),1,'>');
              if LoanApps."Loan Product Type"='DIRECT CO-OP' then
              InterestAmount:=ROUND(LoanApps."Approved Amount"*(LoanRepaymentSchedule."Interest Rate"/1200),1,'>');
        
        
        
          end ;
          end ;
          end ;
        //end interest amount calculation
        
        
        
        
                if InterestAmount > 0 then begin
                    Loans.CalcFields(Loans."Outstanding Balance",Loans."Oustanding Interest");
                    //MESSAGE('InterestAmount %1',InterestAmount);
                    LoansInterest.Init;
                    LoansInterest.No:='INTEREST';
                    LoansInterest."Auto Interest":=true;
                    LoansInterest."Loan No.":=Loans."Loan  No.";
                    LoansInterest."Account Type":=LoansInterest."account type"::Credit;
                    LoansInterest."Account No":=Loans."Client Code";
                    LoansInterest."Issued Date":=Loans."Issued Date";
        
                    //LoansInterest."Interest Date":=CALCDATE('-cm',TODAY);
                    LoansInterest."Interest Date":=BDate;
                   // MESSAGE('date %1',LoansInterest."Interest Date");
                    LoansInterest."Repayment Amount":=Loans.Repayment;
                    LoansInterest."Repayment Bill":=0;
                    LoansInterest."Interest Amount":=InterestAmount;
                    LoansInterest."Interest Bill":=InterestAmount;
                    LoansInterest.Description:='Interest Due'+' '+CopyStr(Format(BDate,0,'<Month Text>'),1,3) +' '+ Format(Date2dmy(BDate,3));
                    LoansInterest."Shortcut Dimension 1 Code":=Loans."Global Dimension 1 Code";
                    LoansInterest."Shortcut Dimension 2 Code":=Loans."Branch Code";
                    LoansInterest."Monthly Repayment":=Loans.Repayment;
                    LoansInterest."Loan Product type":=Loans."Loan Product Type";
                   //
        
        
                    //Loans.CALCFIELDS("Loans Category-SASRA");
                    if LoanType.Get(Loans."Loan Product Type") then begin
                       LoanType.TestField(LoanType."Loan Interest Account");
                       LoansInterest."Bal. Account No.":=LoanType."Loan Interest Account";
        
                        //IF (Loans."Loans Category"<>Loans."Loans Category"::Loss) THEN BEGIN
                        /*IF Loans."Outstanding Balance">Loans."Oustanding Interest" THEN BEGIN
        
                            LoanType.TESTFIELD(LoanType."Loan Interest Account");
                            LoansInterest."Bal. Account No.":=LoanType."Loan Interest Account";
                            //LoansInterest."Bill Account":= LoansInterest."Bal. Account No.";
                        END;*/
        
                        /*ELSE BEGIN
        
                            SuspendedInterestAccounts.RESET;
                            SuspendedInterestAccounts.SETRANGE("Loan No.",Loans."Loan  No.");
                            SuspendedInterestAccounts.SETRANGE("Interest Date",BDate);
                            IF SuspendedInterestAccounts.FINDFIRST THEN
                              SuspendedInterestAccounts.DELETE;
        
        
                            //LoanType.TESTFIELD(LoanType."Suspend Interest Account [G/L]");
                            LoansInterest."Bal. Account No.":=LoanType."Suspend Interest Account [G/L]";
                            LoansInterest."Bill Account":= LoansInterest."Bal. Account No.";
                            //Insert Entries to buffer
                            iEntryNo:=SuspendedInterestAccounts.COUNT;
                            iEntryNo:=iEntryNo+1;
                            SuspendedInterestAccounts.INIT;
                            SuspendedInterestAccounts."Entry No.":=iEntryNo;
                            SuspendedInterestAccounts."Loan No.":=Loans."Loan  No.";
                            SuspendedInterestAccounts."Loan Product type":=LoanType.Code;
                            SuspendedInterestAccounts."Loans Category-SASRA":=Loans."Loans Category-SASRA";
                            SuspendedInterestAccounts."Interest Amount":=InterestAmount;
                            SuspendedInterestAccounts."Interest Date":=BDate;
                            SuspendedInterestAccounts."Issued Date":=Loans."Loan Disbursement Date";
                            SuspendedInterestAccounts.INSERT(TRUE);
        
        
                        END;*/
                    end;
        
                    if CustMember.Get(Loans."Client Code") then begin
                        LoansInterest.Status:=CustMember.Status;
                        LoansInterest.Blocked:=CustMember.Blocked;
                    end;
        
                    LoansInterest."Outstanding Balance":=Loans."Outstanding Balance";
                    LoansInterest."Outstanding Interest":=Loans."Oustanding Interest";
                    LoansInterest.Insert;
        
                end;
            until Loans.Next=0;
        
        end;
        end;

    end;
}

