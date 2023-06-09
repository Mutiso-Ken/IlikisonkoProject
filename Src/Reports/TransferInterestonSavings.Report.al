#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516867 "Transfer Interest on Savings"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Transfer Interest on Savings.rdlc';

    dataset
    {
        dataitem(Vendor;Vendor)
        {
            DataItemTableView = sorting("No.") where("Account Type"=filter(<>FD201));
            PrintOnlyIfDetail = false;
            RequestFilterFields = "Account Type","Date Filter","No.";
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
                
                Transfer:=false;
                
                Vendor.CalcFields(Vendor."Untransfered interest Savings");
                //IF Vendor."FD Maturity Date"<=TODAY THEN BEGIN
                if Vendor."Untransfered interest Savings" > 0 then begin
                //IF Vendor."Interest Earned">0 THEN BEGIN
                if AccountType.Get(Vendor."Account Type") then begin
                if AccountType."Fixed Deposit" = true then begin
                //IF Vendor."FD Maturity Date" <= PDate THEN BEGIN
                Vendor."FD Marked for Closure":=true;
                Transfer:=true;
                //Send E-Mail
                /*
                SMTPMAIL.NewMessage(Gensetup."Sender Address",'DIMKES SACCO - Fixed Deposit Maturity');
                SMTPMAIL.SetWorkMode();
                SMTPMAIL.ClearAttachments();
                SMTPMAIL.ClearAllRecipients();
                SMTPMAIL.SetDebugMode();
                SMTPMAIL.SetFromAdress(Gensetup."Sender Address");
                SMTPMAIL.SetHost(Gensetup."Outgoing Mail Server");
                SMTPMAIL.SetUserID(Gensetup."Sender User ID");
                SMTPMAIL.AddLine('Your fixed deposit has matured and the interested earned transfered to your savings account.');
                SMTPMAIL.AddLine('');
                SMTPMAIL.AddLine('GM - UN SACCO');
                SMTPMAIL.SetToAdress(Vendor."E-Mail");
                SMTPMAIL.Send;
                */
                //Send E-Mail
                
                end else
                Transfer:=false;
                end else
                Transfer:=true;
                end;
                
                if Transfer=false then begin
                
                LineNo:=LineNo+10000;
                
                GenJournalLine.Init;
                GenJournalLine."Journal Template Name":='PURCHASES';
                GenJournalLine."Line No.":=LineNo;
                GenJournalLine."Journal Batch Name":='INTCALC-F';
                GenJournalLine."Document No.":=DocNo;
                GenJournalLine."External Document No.":=Vendor."No.";
                GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                if AccountType.Get(Vendor."Account Type") then begin
                //IF AccountType."Fixed Deposit" = TRUE THEN
                //GenJournalLine."Account No.":=Vendor."Savings Account No."
                //ELSE
                GenJournalLine."Account No.":=Vendor."No.";
                //END ELSE
                GenJournalLine."Account No.":=Vendor."No.";
                GenJournalLine.Validate(GenJournalLine."Account No.");
                if Vendor."FD Maturity Date"<Today then begin
                GenJournalLine."Posting Date":=Vendor."FD Maturity Date"
                end else
                GenJournalLine."Posting Date":=PDate;
                GenJournalLine.Description:='Interest Earned';
                GenJournalLine.Validate(GenJournalLine."Currency Code");
                GenJournalLine.Amount:=-Vendor."Untransfered interest Savings";
                //GenJournalLine.Amount:=-Vendor."Interest Earned";
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"G/L Account";
                GenJournalLine."Bal. Account No.":=AccountType."Interest Payable Account";
                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                if GenJournalLine.Amount<>0 then
                GenJournalLine.Insert;
                
                
                //POST WITHHOLDING TAX
                Gensetup.Get();
                LineNo:=LineNo+10000;
                Gensetup.Get();
                GenJournalLine.Init;
                GenJournalLine."Journal Template Name":='PURCHASES';
                GenJournalLine."Line No.":=LineNo;
                GenJournalLine."Journal Batch Name":='INTCALC-F';
                GenJournalLine."Document No.":=DocNo;
                GenJournalLine."External Document No.":=Vendor."No.";
                GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                GenJournalLine."Account No.":=Gensetup."WithHolding Tax Account";
                GenJournalLine.Validate(GenJournalLine."Account No.");
                if Vendor."FD Maturity Date"<Today then begin
                GenJournalLine."Posting Date":=Vendor."FD Maturity Date"
                end else
                GenJournalLine."Posting Date":=PDate;
                GenJournalLine.Description:='Witholding Tax on Int';
                GenJournalLine.Validate(GenJournalLine."Currency Code");
                //IF AccountType."Fixed Deposit" = TRUE THEN
                GenJournalLine.Amount:=-Vendor."Untransfered interest Savings"*(Gensetup."Withholding Tax (%)"/100);
                //ELSE
                //GenJournalLine.Amount:=ROUND(((IntRate/1200)*Vendor."Balance (LCY)")*MidMonthFactor*0.15,0.05,'>');
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::Vendor;
                GenJournalLine."Bal. Account No.":=Vendor."No.";
                //GenJournalLine."Bal. Account No.":=AccountType."Interest Payable Account";
                GenJournalLine."Shortcut Dimension 1 Code":=Vendor."Global Dimension 1 Code";
                GenJournalLine."Shortcut Dimension 2 Code":=Vendor."Global Dimension 2 Code";
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                //IF GenJournalLine.Amount<>0 THEN
                GenJournalLine.Insert;
                
                
                /*Vendor.CALCFIELDS(Vendor."Interest Earned");
                Vendor.CALCFIELDS(Vendor."Balance (LCY)");
                Vendor."Transfer Amount to Savings":=((Vendor."Balance (LCY)")+Vendor."Interest Earned")-(Vendor."Interest Earned"*0.15);
                IF (Vendor."Balance (LCY)") < Vendor."Transfer Amount to Savings" THEN
                //ERROR('Fixed Deposit account does not have enough money to facilate the requested trasfer.');
                
                LineNo:=LineNo+10000;
                
                GenJournalLine.INIT;
                GenJournalLine."Journal Template Name":='PURCHASES';
                GenJournalLine."Line No.":=LineNo;
                GenJournalLine."Journal Batch Name":='INTCALC-F';
                GenJournalLine."Document No.":="No.";
                GenJournalLine."External Document No.":="No.";
                GenJournalLine."Account Type":=GenJournalLine."Account Type"::Vendor;
                GenJournalLine."Account No.":=Vendor."No.";
                GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                GenJournalLine."Posting Date":=TODAY;
                GenJournalLine.Description:='Term Balance Tranfers';
                GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
                GenJournalLine.Amount:=Vendor."Transfer Amount to Savings";
                GenJournalLine.VALIDATE(GenJournalLine.Amount);
                //IF GenJournalLine.Amount<>0 THEN
                GenJournalLine.INSERT;
                
                LineNo:=LineNo+10000;
                
                GenJournalLine.INIT;
                GenJournalLine."Journal Template Name":='PURCHASES';
                GenJournalLine."Line No.":=LineNo;
                GenJournalLine."Journal Batch Name":='INTCALC-F';
                GenJournalLine."Document No.":="No.";
                GenJournalLine."External Document No.":="No.";
                GenJournalLine."Account Type":=GenJournalLine."Account Type"::Vendor;
                GenJournalLine."Account No.":=Vendor."Savings Account No.";
                GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                GenJournalLine."Posting Date":=TODAY;
                GenJournalLine.Description:='Term Balance Tranfers';
                GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
                GenJournalLine.Amount:=-Vendor."Transfer Amount to Savings";
                GenJournalLine.VALIDATE(GenJournalLine.Amount);
                //IF GenJournalLine.Amount<>0 THEN
                GenJournalLine.INSERT;
                */
                
                
                
                InterestBuffer.Reset;
                InterestBuffer.SetRange(InterestBuffer."Account No",Vendor."No.");
                if InterestBuffer.Find('-') then
                InterestBuffer.ModifyAll(InterestBuffer.Transferred,true);
                
                end;
                end;
                //END;
                //END;
                Vendor."Fixed Deposit Status":=Vendor."fixed deposit status"::Matured;
                Vendor.Modify;

            end;

            trigger OnPostDataItem()
            begin
                /*
                GenJournalLine.RESET;
                GenJournalLine.SETRANGE("Journal Template Name",'PURCHASES');
                GenJournalLine.SETRANGE("Journal Batch Name",'INTCALC-F');
                IF GenJournalLine.FIND('-') THEN BEGIN
                REPEAT
                //GLPosting.RUN(GenJournalLine);
                CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Sacco",GenJournalLine);
                UNTIL GenJournalLine.NEXT = 0;
                END;
                
                
                GenJournalLine.RESET;
                GenJournalLine.SETRANGE("Journal Template Name",'PURCHASES');
                GenJournalLine.SETRANGE("Journal Batch Name",'INTCALC-F');
                GenJournalLine.DELETEALL;
                */

            end;

            trigger OnPreDataItem()
            begin

                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name",'PURCHASES');
                GenJournalLine.SetRange("Journal Batch Name",'INTCALC-F');
                GenJournalLine.DeleteAll;

                DocNo := 'INT EARNED';
                PDate := Today;

                Gensetup.Get(0);
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
        InterestBuffer: Record "Interest Buffer Savings";
        IntRate: Decimal;
        DocNo: Code[10];
        PDate: Date;
        IntBufferNo: Integer;
        MidMonthFactor: Decimal;
        DaysInMonth: Integer;
        Transfer: Boolean;
        Gensetup: Record "Sacco General Set-Up";
}

