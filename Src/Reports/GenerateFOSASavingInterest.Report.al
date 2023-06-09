#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516463 "Generate FOSA Saving Interest"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Generate FOSA Saving Interest.rdlc';

    dataset
    {
        dataitem(Vendor;Vendor)
        {
            DataItemTableView = sorting("No.") where("Creditor Type"=const("Savings Account"),"Account Type"=filter(<>FD201),"No."=filter('01151006188'));
            PrintOnlyIfDetail = false;
            RequestFilterHeading = 'Account';
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
                
                IntRate:=0;
                AccruedInt:=0;
                MidMonthFactor:=1;
                MinBal:=false;
                RIntDays:=IntDays;
                AsAt:=StartDate;
                Account."Not Qualify for Interest":=false;
                
                if AccountType.Get(Vendor."Account Type") then begin
                if AccountType."Earns Interest" = true then begin
                //Loop thru days of the month
                repeat
                RIntDays:=RIntDays-1;
                
                
                DFilter:='01/01/06..'+Format(AsAt);
                
                Account.Reset;
                Account.SetRange(Account."No.",Vendor."No.");
                Account.SetFilter(Account."Date Filter",DFilter);
                //Account.SETFILTER(Account."Date Filter",Dfilter3);
                if Account.Find('-') then begin
                
                
                Account.CalcFields(Account."Balance (LCY)");
                Bal:=Account."Balance (LCY)";
                
                if  Account."Balance (LCY)" <= AccountType."Interest Calc Min Balance" then begin
                Account."Not Qualify for Interest":=true;
                Account.Modify
                end else if (Account."Balance (LCY)" >= AccountType."Interest Calc Min Balance") and
                (Account."Not Qualify for Interest"<>true) then begin
                if AccountType."Fixed Deposit" = true then begin
                FDInterestCalc.Reset;
                FDInterestCalc.SetRange(FDInterestCalc.Code,Vendor."Fixed Deposit Type");
                if FDInterestCalc.Find('-') then begin
                repeat
                if (FDInterestCalc."Minimum Amount" <= Account."Balance (LCY)") and
                (Account."Balance (LCY)" <= FDInterestCalc."Maximum Amount") then
                IntRate:=FDInterestCalc."Interest Rate";
                until FDInterestCalc.Next = 0;
                end;
                
                
                end else begin
                AccountType.TestField(AccountType."Interest Rate");
                IntRate:=AccountType."Interest Rate";
                end;
                
                
                /*
                IF Vendor."Registration Date" <> 0D THEN BEGIN
                IF CALCDATE('1M',Vendor."Registration Date") > PDate THEN
                MidMonthFactor:=(30-DATE2DMY(Vendor."Registration Date",1))/30;
                END;
                */
                
                
                
                Vendor.CalcFields(Vendor."Balance (LCY)");
                
                if AccountType."Fixed Deposit" = true then begin
                //FixedDtype.SETRANGE(FixedDtype.Code,Account."Fixed Deposit Type");
                //IF FixedDtype.FIND('-') THEN BEGIN
                
                end else if AccountType."Fixed Deposit" = false then
                 if (Account."Balance (LCY)" >= AccountType."Interest Calc Min Balance") and
                (Account."Not Qualify for Interest"<>true) then begin
                
                
                //AccruedInt:=AccruedInt+((IntRate/1200/IntDays)*Vendor."Balance (LCY)");
                AccruedInt:=ROUND(AccruedInt+((IntRate/1200/IntDays)*Vendor."Balance (LCY)"),0.05,'>');
                
                end;
                end;
                
                
                
                
                end else begin
                MinBal:=true;
                end;
                //END;
                
                
                AsAt:=CalcDate('1D',AsAt);
                until RIntDays = 0;
                
                if MinBal = true then
                AccruedInt:=0;
                
                if AccruedInt > 0 then begin
                
                LineNo:=LineNo+10000;
                
                GenJournalLine.Init;
                GenJournalLine."Journal Template Name":='PURCHASES';
                GenJournalLine."Line No.":=LineNo;
                GenJournalLine."Journal Batch Name":='INTCALC';
                GenJournalLine."Document No.":=DocNo;
                GenJournalLine."External Document No.":=Vendor."No.";
                GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                GenJournalLine."Account No.":=AccountType."Interest Expense Account";
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Posting Date":=PDate;
                GenJournalLine.Description:=Vendor.Name;
                GenJournalLine.Validate(GenJournalLine."Currency Code");
                GenJournalLine.Amount:=ROUND(((IntRate/1200)*Vendor."Balance (LCY)")*MidMonthFactor,0.05,'>');
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"G/L Account";
                GenJournalLine."Bal. Account No.":=AccountType."Interest Payable Account";
                GenJournalLine."Shortcut Dimension 1 Code":=Vendor."Global Dimension 1 Code";
                GenJournalLine."Shortcut Dimension 2 Code":=Vendor."Global Dimension 2 Code";
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                if GenJournalLine.Amount<>0 then
                GenJournalLine.Insert;
                
                LineNo:=LineNo+10000;
                
                GenJournalLine.Init;
                GenJournalLine."Journal Template Name":='PURCHASES';
                GenJournalLine."Line No.":=LineNo;
                GenJournalLine."Journal Batch Name":='INTCALC';
                GenJournalLine."Document No.":=DocNo;
                GenJournalLine."External Document No.":=Vendor."No.";
                GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                GenJournalLine."Account No.":=AccountType."Interest Expense Account";
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Posting Date":=PDate;
                GenJournalLine.Description:='Witholding Tax on Int';
                GenJournalLine.Validate(GenJournalLine."Currency Code");
                GenJournalLine.Amount:=ROUND(((IntRate/1200)*Vendor."Balance (LCY)")*MidMonthFactor*0.015,0.05,'>');
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"G/L Account";
                GenJournalLine."Bal. Account No.":='100509';
                //GenJournalLine."Bal. Account No.":=AccountType."Interest Payable Account";
                GenJournalLine."Shortcut Dimension 1 Code":=Vendor."Global Dimension 1 Code";
                GenJournalLine."Shortcut Dimension 2 Code":=Vendor."Global Dimension 2 Code";
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                //IF GenJournalLine.Amount<>0 THEN
                GenJournalLine.Insert;
                
                
                
                IntBufferNo:=IntBufferNo+1;
                
                InterestBuffer.Init;
                InterestBuffer.No:=IntBufferNo;
                InterestBuffer."Account No":=Vendor."No.";
                InterestBuffer."Account Type":=Vendor."Account Type";
                InterestBuffer."Interest Date":=PDate;
                InterestBuffer."Interest Amount":=ROUND(((IntRate/1200)*Vendor."Balance (LCY)")*MidMonthFactor,0.05,'>');
                InterestBuffer."User ID":=UserId;
                if InterestBuffer."Interest Amount" <> 0 then
                InterestBuffer.Insert(true);
                
                
                end;
                end;
                end;

            end;

            trigger OnPostDataItem()
            begin
                /*
                GenJournalLine.RESET;
                GenJournalLine.SETRANGE("Journal Template Name",'PURCHASES');
                GenJournalLine.SETRANGE("Journal Batch Name",'INTCALC');
                IF GenJournalLine.FIND('-') THEN BEGIN
                REPEAT
                GLPosting.RUN(GenJournalLine);
                UNTIL GenJournalLine.NEXT = 0;
                END;
                
                {
                GenJournalLine.RESET;
                GenJournalLine.SETRANGE("Journal Template Name",'PURCHASES');
                GenJournalLine.SETRANGE("Journal Batch Name",'INTCALC');
                GenJournalLine.DELETEALL;
                }
                */

            end;

            trigger OnPreDataItem()
            begin

                SN:=SN+1;

                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name",'PURCHASES');
                GenJournalLine.SetRange("Journal Batch Name",'INTCALC');
                GenJournalLine.DeleteAll;

                //IF DocNo = '' THEN
                //ERROR('Please specify the Document No.');

                //IF PDate = 0D THEN
                //ERROR('Please specify the Posting Date.');

                DocNo := 'INT EARNED';
                if PDate = 0D then
                PDate :=AsAt;

                InterestBuffer.Reset;
                if InterestBuffer.Find('+') then
                IntBufferNo:=InterestBuffer.No;

                StartDate:=CalcDate('-1M',CalcDate('1D',Today));
                //MESSAGE('start date %1',StartDate);
                IntDays:=(Today-StartDate)+1;
                //MESSAGE('start date %1',IntDays);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(As_At;AsAt)
                {
                    ApplicationArea = Basic;
                    Caption = 'As_At';
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
                Company.Get();
                Company.CalcFields(Company.Picture);
    end;

    var
        Company: Record "Company Information";
        SN: Integer;
        GenJournalLine: Record "Gen. Journal Line";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        Account: Record Vendor;
        AccountType: Record "Account Types-Saving Products";
        LineNo: Integer;
        ChequeType: Record "Cheque Types";
        FDInterestCalc: Record "FD Interest Calculation Crite";
        InterestBuffer: Record "Interest Buffer Savings";
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
        FixedDtype: Record "Fixed Deposit Type";
        DURATION: Integer;
        Dfilter2: Date;
        Dfilter3: Text[30];
}

