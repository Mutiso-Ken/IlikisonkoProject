#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516481 "Process Checkoff Distributed"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Process Checkoff Distributed.rdlc';

    dataset
    {
        dataitem("Checkoff Lines-Distributed";"Checkoff Lines-Distributed")
        {
            column(ReportForNavId_1000000000; 1000000000)
            {
            }

            trigger OnAfterGetRecord()
            begin
                /*RcptLine.RESET;
                RcptLine.SETRANGE(RcptLine."Receipt Header No",RcptHeader.No);
                IF RcptLine.FIND('-') THEN BEGIN
                REPEAT*/
                /*Employees.RESET;
                Employees.SETRANGE(Employees.Userid1,USERID);
                IF Employees.FIND('-') THEN BEGIN
                SETRANGE(Userid1,USERID);*/
                
                if RcptHeader.Get("Receipt Header No") then begin
                
                GenBatches.Reset;
                GenBatches.SetRange(GenBatches."Journal Template Name",'GENERAL');
                GenBatches.SetRange(GenBatches.Name,RcptHeader.No);
                if GenBatches.Find('-') = false then begin
                GenBatches.Init;
                GenBatches."Journal Template Name":='GENERAL';
                GenBatches.Name:=RcptHeader.No;
                GenBatches.Description:='CHECKOFF PROCESSING';
                GenBatches.Validate(GenBatches."Journal Template Name");
                GenBatches.Validate(GenBatches.Name);
                GenBatches.Insert;
                
                end;
                
                
                
                
                Cust.Reset;
                Cust.SetRange(Cust."No.","Checkoff Lines-Distributed"."Member No.");
                //Cust.SETRANGE(Cust."Company Code","Checkoff Lines-Distributed".DEPT);
                if Cust.Find('-') then begin
                if "Checkoff Lines-Distributed"."Loan No."<>'' then begin
                if ("Checkoff Lines-Distributed"."Special Code"='SINTEREST') or
                ("Checkoff Lines-Distributed"."Special Code"='INTEREST PAID')then begin
                
                    LineN:=LineN+10000;
                    Gnljnline.Init;
                    Gnljnline."Journal Template Name":='GENERAL';
                    Gnljnline."Journal Batch Name":=RcptHeader.No;
                    Gnljnline."Line No.":=LineN;
                    Gnljnline."Account Type":=Gnljnline."account type"::Employee;
                    Gnljnline."Account No.":=Cust."No.";
                    Gnljnline.Validate(Gnljnline."Account No.");
                    Gnljnline."Document No.":=RcptHeader."Document No";
                    Gnljnline."Posting Date":=RcptHeader."Posting date";
                    Gnljnline.Description:="Checkoff Lines-Distributed"."Special Code";
                    Gnljnline.Amount:=-1*"Checkoff Lines-Distributed".Amount;
                    Gnljnline.Validate(Gnljnline.Amount);
                    Gnljnline."Loan No":="Checkoff Lines-Distributed"."Loan No.";
                    Gnljnline."Transaction Type":=Gnljnline."transaction type"::"Insurance Contribution";
                    Gnljnline."Bal. Account Type":=Gnljnline."bal. account type"::"G/L Account";
                    //Gnljnline."Bal. Account No.":='20820';
                    //Gnljnline.VALIDATE(Gnljnline."Bal. Account No.");                      LOANS.RESET;
                    LOANS.SetCurrentkey(LOANS."Loan Product Type");
                    LOANS.SetRange(LOANS."Client Code","Checkoff Lines-Distributed"."Member No.");
                    LOANS.SetRange(LOANS."Loan Product Type","Checkoff Lines-Distributed"."Loan Type");
                    if LOANS.Find('-') then begin
                    repeat
                    LOANS.CalcFields( LOANS."Outstanding Balance");
                    if LOANS."Outstanding Balance">0 then begin
                     "Checkoff Lines-Distributed"."Loan No." :=LOANS."Loan  No.";
                     Gnljnline."Loan No":="Checkoff Lines-Distributed"."Loan No.";
                      "Checkoff Lines-Distributed".Modify;
                    end;
                    until LOANS.Next=0;
                     end;
                    Gnljnline."Shortcut Dimension 1 Code":='BOSA';
                    //Gnljnline."Shortcut Dimension 2 Code":='HAZINA';
                    //Gnljnline."Loan No":=LoanAppInt."Loan  No.";
                    if Gnljnline.Amount<>0 then
                    Gnljnline.Insert;
                end;
                end;
                
                if "Checkoff Lines-Distributed"."Loan No."<>'' then begin
                if ("Checkoff Lines-Distributed"."Special Code"='SLOAN')or ("Checkoff Lines-Distributed"."Special Code"='REPAYMENT') then begin
                
                 LineN:=LineN+10000;
                 Gnljnline.Init;
                 Gnljnline."Journal Template Name":='GENERAL';
                 Gnljnline."Journal Batch Name":=RcptHeader.No;
                 Gnljnline."Line No.":=LineN;
                 Gnljnline."Account Type":=Gnljnline."account type"::Employee;
                 Gnljnline."Account No.":=Cust."No.";
                 Gnljnline.Validate(Gnljnline."Account No.");
                 Gnljnline."Document No.":=RcptHeader."Document No";
                 Gnljnline."Posting Date":=RcptHeader."Posting date";
                 Gnljnline.Description:="Checkoff Lines-Distributed"."Special Code";;
                 Gnljnline.Amount:="Checkoff Lines-Distributed".Amount*-1;
                 Gnljnline.Validate(Gnljnline.Amount);
                 Gnljnline."Transaction Type":=Gnljnline."transaction type"::"Interest Paid";
                 Gnljnline."Shortcut Dimension 1 Code":='BOSA';
                 Gnljnline."Loan No":="Checkoff Lines-Distributed"."Loan No.";
                 Gnljnline."Bal. Account Type":=Gnljnline."bal. account type"::"G/L Account";
                 //Gnljnline."Bal. Account No.":='20820';
                 //Gnljnline.VALIDATE(Gnljnline."Bal. Account No.");
                 LOANS.Reset;
                 LOANS.SetCurrentkey(LOANS."Loan Product Type");
                 LOANS.SetRange(LOANS."Client Code","Checkoff Lines-Distributed"."Member No.");
                 LOANS.SetRange(LOANS."Loan Product Type","Loan Type");
                 if LOANS.Find('-') then begin
                 repeat
                 LOANS.CalcFields( LOANS."Outstanding Balance");
                 if LOANS."Outstanding Balance">0 then begin
                 "Checkoff Lines-Distributed"."Loan No." :=LOANS."Loan  No.";
                 Gnljnline."Loan No":="Checkoff Lines-Distributed"."Loan No.";
                 "Checkoff Lines-Distributed".Modify;
                 end;
                 until LOANS.Next=0;
                 end;
                 if Gnljnline.Amount<>0 then
                 Gnljnline.Insert;
                end;
                 end;
                
                if ("Checkoff Lines-Distributed"."Special Code"='SSHARE') or
                   ("Checkoff Lines-Distributed"."Special Code"='DEPOSITS CONTRIBUTION')then begin
                LineN:=LineN+10000;
                Gnljnline.Init;
                Gnljnline."Journal Template Name":='GENERAL';
                Gnljnline."Journal Batch Name":=RcptHeader.No;
                Gnljnline."Line No.":=LineN;
                Gnljnline."Account Type":=Gnljnline."account type"::Employee;
                Gnljnline."Account No.":=Cust."No.";
                Gnljnline.Validate(Gnljnline."Account No.");
                Gnljnline."Document No.":=RcptHeader."Document No";
                Gnljnline."Posting Date":=RcptHeader."Posting date";
                Gnljnline.Description:="Checkoff Lines-Distributed"."Special Code";;
                Gnljnline.Amount:="Checkoff Lines-Distributed".Amount*-1;
                Gnljnline.Validate(Gnljnline.Amount);
                Gnljnline."Bal. Account Type":=Gnljnline."bal. account type"::"G/L Account";
                //Gnljnline."Bal. Account No.":='20845';
                Gnljnline."Transaction Type":=Gnljnline."transaction type"::Loan;
                Gnljnline."Shortcut Dimension 1 Code":='BOSA';
                //Gnljnline."Shortcut Dimension 2 Code":='';
                //Gnljnline.VALIDATE(Gnljnline."Bal. Account No.");
                if Gnljnline.Amount<>0 then
                Gnljnline.Insert;
                end;
                
                if ("Checkoff Lines-Distributed"."Special Code"='WCONT')  or("Checkoff Lines-Distributed"."Special Code"='Insurance Contribution') then begin
                LineN:=LineN+10000;
                Gnljnline.Init;
                Gnljnline."Journal Template Name":='GENERAL';
                Gnljnline."Journal Batch Name":=RcptHeader.No;
                Gnljnline."Line No.":=LineN;
                Gnljnline."Account Type":=Gnljnline."account type"::Employee;
                Gnljnline."Account No.":=Cust."No.";
                Gnljnline.Validate(Gnljnline."Account No.");
                Gnljnline."Document No.":=RcptHeader."Document No";
                Gnljnline."Posting Date":=RcptHeader."Posting date";
                Gnljnline.Description:="Checkoff Lines-Distributed"."Special Code";;
                Gnljnline.Amount:="Checkoff Lines-Distributed".Amount*-1;
                Gnljnline.Validate(Gnljnline.Amount);
                //Gnljnline."Bal. Account Type":=Gnljnline."Bal. Account Type"::"G/L Account";
                //Gnljnline."Bal. Account No.":='20850';
                //Gnljnline.VALIDATE(Gnljnline."Bal. Account No.");
                Gnljnline."Transaction Type":=Gnljnline."transaction type"::"Benevolent Fund";
                Gnljnline."Shortcut Dimension 1 Code":='BOSA';
                //Gnljnline."Shortcut Dimension 2 Code":='';
                if Gnljnline.Amount<>0 then
                Gnljnline.Insert;
                end;
                
                if ("Checkoff Lines-Distributed"."Special Code"='SRISK') then begin
                LineN:=LineN+10000;
                Gnljnline.Init;
                Gnljnline."Journal Template Name":='GENERAL';
                Gnljnline."Journal Batch Name":=RcptHeader.No;
                Gnljnline."Line No.":=LineN;
                Gnljnline."Account Type":=Gnljnline."account type"::Employee;
                Gnljnline."Account No.":=Cust."No.";
                Gnljnline.Validate(Gnljnline."Account No.");
                Gnljnline."Document No.":=RcptHeader."Document No";
                Gnljnline."Posting Date":=RcptHeader."Posting date";
                Gnljnline.Description:="Checkoff Lines-Distributed"."Special Code";;
                Gnljnline.Amount:="Checkoff Lines-Distributed".Amount*-1;
                Gnljnline.Validate(Gnljnline.Amount);
                Gnljnline."Bal. Account Type":=Gnljnline."bal. account type"::"G/L Account";
                //Gnljnline."Bal. Account No.":='20880';
                //Gnljnline.VALIDATE(Gnljnline."Bal. Account No.");
                Gnljnline."Transaction Type":=Gnljnline."transaction type"::"45";
                Gnljnline."Shortcut Dimension 1 Code":='BOSA';
                //Gnljnline."Shortcut Dimension 2 Code":='';
                if Gnljnline.Amount<>0 then
                Gnljnline.Insert;
                //END;
                end;
                
                //******************************Posting To current account
                if ("Checkoff Lines-Distributed"."Special Code"='CURRENT') then begin
                LineN:=LineN+10000;
                Gnljnline.Init;
                Gnljnline."Journal Template Name":='GENERAL';
                Gnljnline."Journal Batch Name":=RcptHeader.No;
                Gnljnline."Line No.":=LineN;
                Gnljnline."Account Type":=Gnljnline."account type"::Vendor;
                Gnljnline."Account No.":="Checkoff Lines-Distributed"."FOSA Account";
                Gnljnline.Validate(Gnljnline."Account No.");
                Gnljnline."Document No.":=RcptHeader."Document No";
                Gnljnline."Posting Date":=RcptHeader."Posting date";
                Gnljnline.Description:="Checkoff Lines-Distributed"."Special Code";;
                Gnljnline.Amount:="Checkoff Lines-Distributed".Amount*-1;
                Gnljnline.Validate(Gnljnline.Amount);
                Gnljnline."Bal. Account Type":=Gnljnline."bal. account type"::"G/L Account";
                //Gnljnline."Bal. Account No.":='20880';
                //Gnljnline.VALIDATE(Gnljnline."Bal. Account No.");
                //Gnljnline."Transaction Type":=Gnljnline."Transaction Type"::"Risk Fund Paid";
                Gnljnline."Shortcut Dimension 1 Code":='FOSA';
                //Gnljnline."Shortcut Dimension 2 Code":='';
                if Gnljnline.Amount<>0 then
                Gnljnline.Insert;
                //END;
                end;
                
                //******************************Posting To current account
                if ("Checkoff Lines-Distributed"."Special Code"='NONE') then begin
                LineN:=LineN+10000;
                Gnljnline.Init;
                Gnljnline."Journal Template Name":='GENERAL';
                Gnljnline."Journal Batch Name":=RcptHeader.No;
                Gnljnline."Line No.":=LineN;
                Gnljnline."Account Type":=Gnljnline."account type"::"G/L Account";
                Gnljnline."Account No.":='100215';
                Gnljnline.Validate(Gnljnline."Account No.");
                Gnljnline."Document No.":=RcptHeader."Document No";
                Gnljnline."Posting Date":=RcptHeader."Posting date";
                Gnljnline.Description:="Checkoff Lines-Distributed"."Special Code";;
                Gnljnline.Amount:="Checkoff Lines-Distributed".Amount*-1;
                Gnljnline.Validate(Gnljnline.Amount);
                Gnljnline."Bal. Account Type":=Gnljnline."bal. account type"::"G/L Account";
                //Gnljnline."Bal. Account No.":='20880';
                //Gnljnline.VALIDATE(Gnljnline."Bal. Account No.");
                //Gnljnline."Transaction Type":=Gnljnline."Transaction Type"::"Risk Fund Paid";
                Gnljnline."Shortcut Dimension 1 Code":='FOSA';
                //Gnljnline."Shortcut Dimension 2 Code":='';
                if Gnljnline.Amount<>0 then
                Gnljnline.Insert;
                //END;
                end;
                
                /*IF  ("Checkoff Lines-Distributed"."Account type"='2') THEN BEGIN
                LineN:=LineN+10000;
                Gnljnline.INIT;
                Gnljnline."Journal Template Name":='GENERAL';
                Gnljnline."Journal Batch Name":=RcptHeader.No;
                Gnljnline."Line No.":=LineN;
                Gnljnline."Account Type":=Gnljnline."Account Type"::Member;
                Gnljnline."Account No.":=Cust."No.";
                Gnljnline.VALIDATE(Gnljnline."Account No.");
                Gnljnline."Document No.":=RcptHeader."Document No";
                Gnljnline."Posting Date":=RcptHeader."Posting date";
                Gnljnline.Description:="Checkoff Lines-Distributed".Reference;;
                Gnljnline.Amount:="Checkoff Lines-Distributed".Amount*-1;
                Gnljnline.VALIDATE(Gnljnline.Amount);
                Gnljnline."Bal. Account Type":=Gnljnline."Bal. Account Type"::"G/L Account";
                //Gnljnline."Bal. Account No.":='20915';
                ////Gnljnline.VALIDATE(Gnljnline."Bal. Account No.");
                Gnljnline."Transaction Type":=Gnljnline."Transaction Type"::"Deposit Contribution";
                Gnljnline."Shortcut Dimension 1 Code":='BOSA';
                //Gnljnline."Shortcut Dimension 2 Code":='';
                IF Gnljnline.Amount<>0 THEN
                Gnljnline.INSERT;
                END;*/
                
                
                if  ("Checkoff Lines-Distributed"."Account type"='20') then begin
                LineN:=LineN+10000;
                Gnljnline.Init;
                Gnljnline."Journal Template Name":='GENERAL';
                Gnljnline."Journal Batch Name":='DIVIDEND';
                Gnljnline."Line No.":=LineN;
                Gnljnline."Account Type":=Gnljnline."account type"::Employee;
                Gnljnline."Account No.":=Cust."No.";
                Gnljnline.Validate(Gnljnline."Account No.");
                Gnljnline."Document No.":=RcptHeader."Document No";
                Gnljnline."Posting Date":=RcptHeader."Posting date";
                Gnljnline.Description:="Checkoff Lines-Distributed"."Special Code";;
                Gnljnline.Amount:="Checkoff Lines-Distributed".Amount;
                Gnljnline.Validate(Gnljnline.Amount);
                Gnljnline."Bal. Account Type":=Gnljnline."bal. account type"::"G/L Account";
                Gnljnline."Bal. Account No.":='20320';
                Gnljnline.Validate(Gnljnline."Bal. Account No.");
                Gnljnline."Transaction Type":=Gnljnline."transaction type"::"Additional Shares";
                Gnljnline."Shortcut Dimension 1 Code":='BOSA';
                if Gnljnline.Amount<>0 then
                Gnljnline.Insert;
                end;
                
                
                
                //Clear from Unallocated Account
                if  ("Checkoff Lines-Distributed"."Account type"='UNALLOCATED') then begin
                LineN:=LineN+10000;
                Gnljnline.Init;
                Gnljnline."Journal Template Name":='GENERAL';
                Gnljnline."Journal Batch Name":=RcptHeader.No;
                Gnljnline."Line No.":=LineN;
                Gnljnline."Account Type":=Gnljnline."account type"::Employee;
                Gnljnline."Account No.":=Cust."No.";
                Gnljnline.Validate(Gnljnline."Account No.");
                Gnljnline."Document No.":=RcptHeader."Document No";
                Gnljnline."Posting Date":=RcptHeader."Posting date";
                Gnljnline.Description:="Checkoff Lines-Distributed"."Special Code";;
                Gnljnline.Amount:=-"Checkoff Lines-Distributed".Amount;
                Gnljnline.Validate(Gnljnline.Amount);
                Gnljnline."Bal. Account Type":=Gnljnline."bal. account type"::"G/L Account";
                //Gnljnline."Bal. Account No.":='20320';
                //Gnljnline.VALIDATE(Gnljnline."Bal. Account No.");
                Gnljnline."Transaction Type":=Gnljnline."transaction type"::"Loan Insurance Paid";
                Gnljnline."Shortcut Dimension 1 Code":='BOSA';
                if Gnljnline.Amount<>0 then
                Gnljnline.Insert;
                end;
                
                //End Clear from unallocated Account
                //EXCESS POSTING  LOANS it excludes othe trasactions other that loan and interest
                if "Checkoff Lines-Distributed"."Loan No."='' then begin
                if ("Checkoff Lines-Distributed"."Special Code"='SLOAN')or ("Checkoff Lines-Distributed"."Special Code"='REPAYMENT') or ("Checkoff Lines-Distributed"."Special Code"='SINTEREST')
                or ("Checkoff Lines-Distributed"."Special Code"='INTEREST PAID') then begin
                LineN:=LineN+10000;
                Gnljnline.Init;
                Gnljnline."Journal Template Name":='GENERAL';
                Gnljnline."Journal Batch Name":=RcptHeader.No;
                Gnljnline."Line No.":=LineN;
                Gnljnline."Account Type":=Gnljnline."account type"::Employee;
                Gnljnline."Account No.":="Checkoff Lines-Distributed"."Member No.";
                Gnljnline.Validate(Gnljnline."Account No.");
                Gnljnline."Document No.":=RcptHeader."Document No";
                Gnljnline."Posting Date":=RcptHeader."Posting date";
                Gnljnline.Description:="Checkoff Lines-Distributed"."Special Code";;
                Gnljnline.Amount:="Checkoff Lines-Distributed".Amount*-1;
                Gnljnline.Validate(Gnljnline.Amount);
                Gnljnline."Transaction Type":=Gnljnline."transaction type"::"Loan Insurance Paid";
                Gnljnline."Shortcut Dimension 1 Code":='BOSA';
                if Gnljnline.Amount<>0 then
                Gnljnline.Insert;
                "Checkoff Lines-Distributed".Source:=true;
                "Checkoff Lines-Distributed".Modify;
                end;
                end;
                
                end else begin
                
                 "Checkoff Lines-Distributed"."Staff Not Found":=true;
                 "Checkoff Lines-Distributed".Modify;
                end;
                
                end;
                
                /*UNTIL RcptLine.NEXT=0;
                END;*/

            end;

            trigger OnPostDataItem()
            begin
                //Balance With Employer Debtor
                RcptHeader.CalcFields(RcptHeader."Interest Amount");
                LineN:=LineN+10000;
                Gnljnline.Init;
                Gnljnline."Journal Template Name":='GENERAL';
                Gnljnline."Journal Batch Name":=RcptHeader.No;
                Gnljnline."Line No.":=LineN;
                Gnljnline."Account Type":=RcptHeader."Account Type";
                Gnljnline."Account No.":=RcptHeader."Account No";
                Gnljnline.Validate(Gnljnline."Account No.");
                Gnljnline."Document No.":=RcptHeader."Document No";
                Gnljnline."External Document No.":=RcptHeader."Document No";
                Gnljnline."Posting Date":=RcptHeader."Posting date";
                Gnljnline.Description:=RcptHeader.Remarks;
                Gnljnline.Amount:=RcptHeader.Amount;
                Gnljnline.Validate(Gnljnline.Amount);
                Gnljnline."Shortcut Dimension 1 Code":='BOSA';
                if Gnljnline.Amount<>0 then
                Gnljnline.Insert;
            end;

            trigger OnPreDataItem()
            begin
                
                //delete journal line
                Gnljnline.Reset;
                Gnljnline.SetRange("Journal Template Name",'GENERAL');
                Gnljnline.SetRange("Journal Batch Name",RcptHeader.No);
                Gnljnline.DeleteAll;
                //end of deletion
                
                RunBal:=0;
                
                "Checkoff Lines-Distributed".ModifyAll("Checkoff Lines-Distributed"."Staff Not Found",false);
                /*
                IF RcptHeader."Document No" = '' THEN
                ERROR('Please specify the document No.');
                
                IF RcptHeader."Posting date" =0D THEN
                ERROR('Please specify the Posting date');
                */
                GenSetUp.Get(0);
                Userid1:=UserId;

            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Gnljnline: Record "Gen. Journal Line";
        Cust: Record "Member Register";
        LoanApp: Record "Loans Register";
        LoanType: Record "Loan Products Setup";
        RunBal: Decimal;
        PDate: Date;
        DocNo: Code[20];
        InvCont: Decimal;
        InvMonthCont: Decimal;
        FDate: Date;
        LineN: Integer;
        Repayment: Decimal;
        Interest: Decimal;
        LoanRBal: Decimal;
        LCount: Integer;
        LRepayment: Decimal;
        LType: Text[30];
        RegFee: Decimal;
        SharesBal: Decimal;
        LoanAppInt: Record "Loans Register";
        datefilter1: Text[30];
        MaxDate: Date;
        LoanInt2: Record "Loans Register";
        PeriodInterest: Decimal;
        ShRec: Decimal;
        TotalRepay: Decimal;
        PType: Option " ","SARF & Super SARF","Less IPO";
        GenSetUp: Record "Sacco General Set-Up";
        MinShares: Decimal;
        LoanP: Record "Loan Products Setup";
        UnderpaidLoan: Decimal;
        Trans: Record Transactions;
        IntDateFilter: Text[150];
        LoanIntR: Record "Loans Register";
        IntRev: Decimal;
        AccNo: Code[20];
        PrepaidRemi: Record "Prepaid Remitance";
        "HFCKcontrib.": Decimal;
        LOANS: Record "Loans Register";
        Employees: Record "Checkoff Lines-Distributed";
        Vend: Record Vendor;
        RcptBufID: Code[20];
        VendFound: Boolean;
        RcptHeader: Record "Checkoff Header-Distributed";
        RcptLine: Record "Checkoff Lines-Distributed";
        GenBatches: Record "Gen. Journal Batch";
}

