#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516464 "Post Monthly Interest"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Post Monthly Interest.rdlc';

    dataset
    {
        dataitem("Loans Register";"Loans Register")
        {
            DataItemTableView = where(Posted=const(true),"Loan Product Type"=filter(<>'INTARR'),Source=const(" "));
            PrintOnlyIfDetail = false;
            RequestFilterFields = "Loan  No.","Issued Date";
            column(ReportForNavId_4645; 4645)
            {
            }
            column(FORMAT_TODAY_0_4_;Format(Today,0,4))
            {
            }
            column(COMPANYNAME;COMPANYNAME)
            {
            }
            column(Company_Address;Company.Address)
            {
            }
            column(Company_Address2;Company."Address 2")
            {
            }
            column(Company_PhoneNo;Company."Phone No.")
            {
            }
            column(Company_Email;Company."E-Mail")
            {
            }
            column(Company_Picture;Company.Picture)
            {
            }
            column(CurrReport_PAGENO;CurrReport.PageNo)
            {
            }
            column(USERID;UserId)
            {
            }

            trigger OnAfterGetRecord()
            begin
                
                
                
                
                if ("Loans Register"."Loan Product Type"<>'ADVANCE') or ("Loans Register"."Loan Product Type"<>'SPA') or ("Loans Register"."Loan Product Type"<>'OVERDRAFT') or
                ("Loans Register"."Loan Product Type"<>'UTILITY')or ("Loans Register"."Loan Product Type"<>'defaulted')then begin
                // AND (cusld."Posting Date"= 20101303D)
                
                
                
                Cust.Reset;
                Cust.SetRange(Cust."No.","Client Code");
                //Cust.SETRANGE(Cust.Status,Cust.Status::Active);
                if Cust.Find('-') then begin
                if (Cust."Employer Code"<>'13') or (Cust."Employer Code"<>'10') or  (Cust."Employer Code"<>'11')
                or (Cust."Employer Code"<>'12') then begin
                //IntRate:=Loans.Interest;
                AccruedInt:=0;
                MidMonthFactor:=1;
                MinBal:=false;
                RIntDays:=IntDays;
                AsAt:=StartDate;
                LoanType.Get("Loans Register"."Loan Product Type");
                
                IntRate:=LoanType."Interest rate";
                //MESSAGE('interest rate %1',IntRate);
                
                //MESSAGE('member no %1',"Client Code");
                
                
                if (LoanType.Source=LoanType.Source::" ") and ("Loans Register"."Loan Product Type"<>'DEFAULTER1')
                 or ("Loans Register"."Loan Product Type"<>'staff')then begin
                
                
                "Loans Register".CalcFields("Loans Register"."Outstanding Balance");
                if "Loans Register"."Outstanding Balance" > 0 then begin
                //IF Cust.GET(Loans."Client Code") THEN BEGIN
                //IF Cust.Status <> Cust.Status::"Re-instated" THEN BEGIN
                
                
                BaldateTXT:='01/01/10..'+Format(Baldate);
                
                
                
                
                
                //Loop thru days of the month
                
                LoansB.Reset;
                LoansB.SetRange(LoansB."Loan  No.","Loans Register"."Loan  No.");
                LoansB.SetFilter(LoansB."Date filter",BaldateTXT);
                //MESSAGE('the baldate is %1',FORMAT(BaldateTXT));
                if LoansB.Find('-') then begin
                
                "PrepaidRem.".Reset;
                "PrepaidRem.".SetRange("PrepaidRem."."Loan No.",LoansB."Loan  No.");
                if "PrepaidRem.".Find('-') then begin
                PrepBal:="PrepaidRem.".Amount;
                //MESSAGE('the prepaid bal %1',PrepBal);
                LoansB.CalcFields(LoansB."Outstanding Balance");
                LoansB.CalcFields(LoansB."Interest Due");
                Bal:=LoansB."Outstanding Balance";
                
                IntD:=LoansB."Interest Due";
                CBalance:=Bal;//-PrepBal;
                
                end else if not "PrepaidRem.".Find('-') then begin
                LoansB.CalcFields(LoansB."Outstanding Balance");
                Bal:=LoansB."Outstanding Balance";
                CBalance:=Bal; //-PrepBal;
                end;
                
                
                
                if LoansB."Loan Product Type"<>'SUPER' then begin
                LoansB.CalcFields(LoansB."Interest Due",LoansB."Outstanding Balance");
                CBalance:=LoansB."Outstanding Balance";
                end;
                //IF CBalance<>0 THEN
                AccruedInt:=ROUND(((IntRate/1200)*CBalance),0.05,'>');
                //MESSAGE('interest %1',AccruedInt);
                
                
                
                
                
                
                //END;
                //MESSAGE('THE INT IS %1',AccruedInt);
                AsAt:=CalcDate('1D',AsAt);
                
                
                
                if AccruedInt > 0 then begin
                
                    LineNo:=LineNo+10000;
                
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name":='GENERAL';
                    GenJournalLine."Journal Batch Name":='INTCALC';
                    GenJournalLine."Line No.":=LineNo;
                    GenJournalLine."Account Type":=GenJournalLine."account type"::Customer;
                    GenJournalLine."Account No.":="Client Code";
                    GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Deposit Contribution";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No.":=DocNo;
                    GenJournalLine."Posting Date":=PDate;
                    GenJournalLine.Description:='Interest Due';
                    GenJournalLine.Amount:=AccruedInt;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"G/L Account";
                   // IF LoanType.GET(Loans."Loan Product Type") THEN
                    GenJournalLine."Bal. Account No.":='20870';
                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                    GenJournalLine."Loan No":="Loans Register"."Loan  No.";
                    GenJournalLine."Shortcut Dimension 1 Code":='bosa';
                    GenJournalLine."Loan Product Type":="Loans Register"."Loan Product Type";
                    if GenJournalLine.Amount<>0 then
                    GenJournalLine.Insert;
                
                
                end;
                end;
                end;
                end;
                end;
                end;
                
                end;
                //END;
                
                
                
                /*
                
                
                 // ACCRUE INTEREST FOR LOANS ISSUED DURING THE MONTH
                LoansB.RESET;
                LoansB.SETRANGE(LoansB."Loan  No.",Loans."Loan  No.");
                //LoansB.SETFILTER(LoansB."Date filter",BaldateTXT);
                //MESSAGE('the baldate is %1',FORMAT(BaldateTXT));
                
                IF LoansB.FIND('-') THEN BEGIN
                IF (LoansB."Issued Date">Baldate) AND  (LoansB."Issued Date"<=CUTOFFDATE) THEN BEGIN
                LoansB.CALCFIELDS(LoansB."Outstanding Balance");
                LoansB.CALCFIELDS(LoansB."Interest Due");
                Bal:=LoansB."Outstanding Balance";
                
                IF LoansB."Loan Product Type"<>'SUPER' THEN BEGIN
                LoansB.CALCFIELDS(LoansB."Interest Due");
                CBalance:=LoansB."Outstanding Balance";
                END;
                
                AccruedInt:=ROUND(((IntRate/1200)*CBalance),0.05,'>');
                
                END;
                //MESSAGE('THE INT IS %1',AccruedInt);
                AsAt:=CALCDATE('1D',AsAt);
                
                
                
                IF AccruedInt > 0 THEN BEGIN
                
                    LineNo:=LineNo+10000;
                
                    GenJournalLine.INIT;
                    GenJournalLine."Journal Template Name":='PURCHASES';
                    GenJournalLine."Journal Batch Name":='INTCALC';
                    GenJournalLine."Line No.":=LineNo;
                    GenJournalLine."Account Type":=GenJournalLine."Account Type"::Customer;
                    GenJournalLine."Account No.":=Loans."Client Code";
                    GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::"Interest Due";
                    GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                    GenJournalLine."Document No.":=DocNo;
                    GenJournalLine."Posting Date":=PDate;
                    GenJournalLine.Description:='Interest Due';
                    GenJournalLine.Amount:=AccruedInt;
                    GenJournalLine.VALIDATE(GenJournalLine.Amount);
                    GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
                    IF LoanType.GET(Loans."Loan Product Type") THEN
                    GenJournalLine."Bal. Account No.":=LoanType."Loan Interest Account";//LoanType."Receivable Interest Account";
                    GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
                    GenJournalLine."Loan No":=Loans."Loan  No.";
                    GenJournalLine."Shortcut Dimension 1 Code":='BOSA';
                    GenJournalLine."Loan Product Type":=Loans."Loan Product Type";
                    IF GenJournalLine.Amount<>0 THEN
                    GenJournalLine.INSERT;
                END;
                END;
                */

            end;

            trigger OnPreDataItem()
            begin

                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name",'GENERAL');
                GenJournalLine.SetRange("Journal Batch Name",'INTCALC');
                GenJournalLine.DeleteAll;



                if AsAtPDate = 0D then
                AsAtPDate := Today;

                DocNo := 'INT DUE';
                PDate := AsAtPDate;


                InterestBuffer.Reset;
                if InterestBuffer.Find('+') then
                IntBufferNo:=InterestBuffer.No;


                StartDate:=CalcDate('-1M',CalcDate('1D',AsAtPDate));
                IntDays:=(AsAtPDate-StartDate)+1;

                if Baldate=0D then
                Error('PLEASE INSERT THE END DATE OF THE PREVIOUS MONTH');

                if CUTOFFDATE=0D then
                Error('PLEASE INSERT THE CUT OFF DATE');
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
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
                Company.Get();
                Company.CalcFields(Company.Picture);
    end;

    var
        Company: Record "Company Information";
        GenBatches: Record "Gen. Journal Batch";
        LoanType: Record "Loan Products Setup";
        Cust: Record "Member Register";
        GenJournalLine: Record "Gen. Journal Line";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        Account: Record Vendor;
        AccountType: Record "Account Types-Saving Products";
        LineNo: Integer;
        ChequeType: Record "Cheque Types";
        FDInterestCalc: Record "FD Interest Calculation Crite";
        InterestBuffer: Record "Interest Buffer";
        IntRate: Decimal;
        DocNo: Code[10];
        PDate: Date;
        IntBufferNo: Integer;
        MidMonthFactor: Decimal;
        DaysInMonth: Integer;
        StartDate: Date;
        IntDays: Integer;
        AsAt: Date;
        MinBal: Boolean;
        AccruedInt: Decimal;
        RIntDays: Integer;
        Bal: Decimal;
        DFilter: Text[50];
        PostDate: Date;
        LoansB: Record "Loans Register";
        AsAtPDate: Date;
        "PrepaidRem.": Record "Prepaid Remitance";
        PrepBal: Decimal;
        CBalance: Decimal;
        cusld: Record "Detailed Cust. Ledg. Entry";
        IntD: Decimal;
        Baldate: Date;
        BaldateTXT: Text[30];
        CUTOFFDATE: Date;
}

