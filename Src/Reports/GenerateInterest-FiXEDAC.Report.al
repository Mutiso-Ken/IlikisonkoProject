#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516468 "Generate Interest -FiXED A|C"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Generate Interest -FiXED AC.rdlc';

    dataset
    {
        dataitem(Vendor;Vendor)
        {
            DataItemTableView = sorting("No.") where("Creditor Type"=const("Savings Account"));
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
                AsAt:=PostStart;
                //Account."Not Qualify for Interest":=FALSE;
                //Account.MODIFY;
                if Vendor."FD Maturity Date"=Today then begin
                
                
                
                if  AccountType.Get(Vendor."Account Type") then begin
                FXDCODE:=AccountType.Code;
                //MESSAGE('THE FXD CODE IS %1',AccountType.Code);
                if AccountType."Earns Interest" = true then begin
                Account.Reset;
                Account.SetRange(Account."No.",Vendor."No.");
                Account.SetFilter(Account."Date Filter",DFilter);
                if Account.Find('-') then begin
                if Account."Account Type"='502' then begin
                Account.CalcFields(Account."Balance (LCY)");
                Bal:=Account."Balance (LCY)";
                DBALANCE:=ROUND(((3/1200)*Bal)*1,0.05,'=');
                //MESSAGE('THE DBALANCE IS %1',DBALANCE);
                end;
                
                
                
                FixedDtype.Reset;
                FixedDtype.SetRange(FixedDtype.Code,Vendor."Fixed Deposit Type");
                if FixedDtype.Find('-') then begin
                 repeat
                FXDCODE:=FixedDtype.Code;
                //MESSAGE('THE FXD CODE IS %1',FixedDtype.Code);
                
                FDInterestCalc.Reset;
                FDInterestCalc.SetRange(FDInterestCalc.Code,Vendor."Fixed Deposit Type");
                if FDInterestCalc.Find('-') then begin
                repeat
                
                //IF (Bal>=FDInterestCalc."Minimum Amount") AND (Bal<=FDInterestCalc."Maximum Amount") THEN BEGIN
                Rate:=FDInterestCalc."Interest Rate";
                //MESSAGE('the rate is %1',Rate);
                
                //***********************************kelvin comment on Duration++++++++++++++++++++++++++++++++++++++**********************
                 /*DURATION:=Vendor."Fixed Duration";*/
                //FXDINterest:=Bal*POWER((1+(Rate/1200)),DURATION);
                //FXDINterest:=ROUND(FXDINterest-Bal,2);
                
                FXDINterest:=ROUND(((Bal*Rate/100)/12)*DURATION,1);
                //MESSAGE('THE BALANCE IS %1',Bal);
                //MESSAGE('THE RATE IS %1',Rate);
                //MESSAGE('THE DURATION IS %1',DURATION);
                //FXDINterest:=ROUND(FXDINterest-Bal,2);
                
                
                //MESSAGE('the comp interest is %1',FXDINterest);
                //END;
                
                
                until FDInterestCalc.Next=0;
                
                
                end;
                until FixedDtype.Next=0;
                end;
                
                
                
                
                
                
                
                AccruedInt:=FXDINterest;
                if (AccruedInt>0)  then begin
                
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
                //IF AccountType."Fixed Deposit" = TRUE THEN
                //GenJournalLine.Amount:=AccruedInt
                //ELSE
                
                //AccruedInt:=AccruedInt+ROUND(((IntRate/1200)*Bal)*MidMonthFactor,0.05,'>');
                GenJournalLine.Amount:=AccruedInt;
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
                
                //POST WITHHOLDING TAX
                
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
                //IF AccountType."Fixed Deposit" = TRUE THEN
                GenJournalLine.Amount:=AccruedInt*0.05;
                //ELSE
                //GenJournalLine.Amount:=ROUND(((IntRate/1200)*Vendor."Balance (LCY)")*MidMonthFactor*0.15,0.05,'>');
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"G/L Account";
                GenJournalLine."Bal. Account No.":='20351';
                //GenJournalLine."Bal. Account No.":=AccountType."Interest Payable Account";
                GenJournalLine."Shortcut Dimension 1 Code":=Vendor."Global Dimension 1 Code";
                GenJournalLine."Shortcut Dimension 2 Code":=Vendor."Global Dimension 2 Code";
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                //IF GenJournalLine.Amount<>0 THEN
                GenJournalLine.Insert;
                
                
                
                //POST FXD TO ACCOUNT
                
                LineNo:=LineNo+10000;
                
                GenJournalLine.Init;
                GenJournalLine."Journal Template Name":='PURCHASES';
                GenJournalLine."Line No.":=LineNo;
                GenJournalLine."Journal Batch Name":='INTCALC';
                GenJournalLine."Document No.":=DocNo;
                GenJournalLine."External Document No.":=Vendor."No.";
                GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                GenJournalLine."Account No.":=Vendor."No.";
                GenJournalLine."Account No.":=Vendor."No.";
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Posting Date":=PDate;
                GenJournalLine.Description:='FXD Interest';
                GenJournalLine.Validate(GenJournalLine."Currency Code");
                GenJournalLine.Amount:=-(AccruedInt-(AccruedInt*0.05));
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"G/L Account";
                GenJournalLine."Bal. Account No.":=AccountType."Interest Payable Account";
                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                if GenJournalLine.Amount<>0 then
                GenJournalLine.Insert;
                
                
                 //INTEREST BUFFER
                
                
                //Post
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name",'PURCHASES');
                GenJournalLine.SetRange("Journal Batch Name",'INTCALC');
                if GenJournalLine.Find('-') then begin
                repeat
                GLPosting.Run(GenJournalLine);
                until GenJournalLine.Next = 0;
                end;
                
                
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name",'PURCHASES');
                GenJournalLine.SetRange("Journal Batch Name",'INTCALC');
                GenJournalLine.DeleteAll;
                //Post
                
                 //INTEREST BUFFER
                
                IntBufferNo:=IntBufferNo+1;
                
                InterestBuffer.Init;
                InterestBuffer.No:=IntBufferNo;
                InterestBuffer."Account No":=Vendor."No.";
                InterestBuffer."Account Type":=Vendor."Account Type";
                InterestBuffer."Interest Date":=PostEnd;
                //IF AccountType."Fixed Deposit" = TRUE THEN
                InterestBuffer."Interest Amount":=AccruedInt;
                //ELSE
                //InterestBuffer."Interest Amount":=ROUND(((IntRate/1200)*Vendor."Balance (LCY)")*MidMonthFactor,0.05,'>');
                InterestBuffer."User ID":=UserId;
                if InterestBuffer."Interest Amount" <> 0 then
                InterestBuffer.Insert(true);
                
                end;
                
                end;
                end;
                end;
                end;

            end;

            trigger OnPostDataItem()
            begin
                
                /*GenJournalLine.RESET;
                GenJournalLine.SETRANGE("Journal Template Name",'PURCHASES');
                GenJournalLine.SETRANGE("Journal Batch Name",'INTCALC');
                IF GenJournalLine.FIND('-') THEN BEGIN
                REPEAT
                GLPosting.RUN(GenJournalLine);
                UNTIL GenJournalLine.NEXT = 0;
                END;
                
                
                GenJournalLine.RESET;
                GenJournalLine.SETRANGE("Journal Template Name",'PURCHASES');
                GenJournalLine.SETRANGE("Journal Batch Name",'INTCALC');
                GenJournalLine.DELETEALL; */

            end;

            trigger OnPreDataItem()
            begin

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
                PDate := Today;

                InterestBuffer.Reset;
                if InterestBuffer.Find('+') then
                IntBufferNo:=InterestBuffer.No;

                //StartDate:=CALCDATE('-1M',CALCDATE('1D',TODAY));
                //MESSAGE('start date %1',StartDate);
                //IntDays:=(TODAY-StartDate)+1;
                //IntDays:=(PostEnd-PostStart)+1;
                //MESSAGE('the number of days %1',IntDays);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(Document_No;DocNo)
                {
                    ApplicationArea = Basic;
                    Caption = 'Document_No';
                }
                field(Posting_Date;PDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Posting_Date';
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
        FixedDtype: Record "Fixed Deposit Type";
        DURATION: Integer;
        Dfilter2: Date;
        Dfilter3: Text[30];
        PostStart: Date;
        PostEnd: Date;
        DBALANCE: Decimal;
        FXDCODE: Code[10];
        Rate: Decimal;
        FXDINterest: Decimal;
}

