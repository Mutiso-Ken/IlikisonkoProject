#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516469 "Post Monthly Interest -FOSA"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Post Monthly Interest -FOSA.rdlc';

    dataset
    {
        dataitem("Loans Register";"Loans Register")
        {
            DataItemTableView = where(Posted=const(true),Source=const(BOSA),"Loan Product Type"=filter(<>'DEFAULTER'),"Issued Date"=filter(>13;
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
                
                Cust.Reset;
                Cust.SetRange(Cust."No.","Client Code");
                if Cust.Find('-') then begin
                if (Cust."Employer Code"<>'13') or (Cust."Employer Code"<>'10') or  (Cust."Employer Code"<>'11')
                or (Cust."Employer Code"<>'12') then begin
                IntRate:="Loans Register".Interest;
                AccruedInt:=0;
                MidMonthFactor:=1;
                MinBal:=false;
                RIntDays:=IntDays;
                AsAt:=StartDate;
                LoanType.Get("Loans Register"."Loan Product Type");
                
                /*IF (LoanType.Source=LoanType.Source::FOSA) AND (Loans."Application Date">20101303D) AND
                 (Loans."Loan Product Type"<>'DEFAULTER') THEN BEGIN*/
                
                
                "Loans Register".CalcFields("Loans Register"."Outstanding Balance");
                if "Loans Register"."Outstanding Balance" > 0 then begin
                if Cust.Get("Loans Register"."Client Code") then begin
                if Cust.Status <> Cust.Status::"Re-instated" then begin
                /*IF (Cust."Company Code"<>'10') OR (Cust."Company Code"<>'11') OR (Cust."Company Code"<>'12') OR (Cust."Company Code"<>'13')
                THEN BEGIN
                MESSAGE('Member No is %1',Cust."Company Code");*/
                //Loop thru days of the month
                
                LoansB.Reset;
                LoansB.SetRange(LoansB."Loan  No.","Loans Register"."Loan  No.");
                LoansB.SetFilter(LoansB."Date filter",DFilter);
                if LoansB.Find('-') then begin
                "PrepaidRem.".Reset;
                "PrepaidRem.".SetRange("PrepaidRem."."Loan No.",LoansB."Loan  No.");
                if "PrepaidRem.".Find('-') then begin
                PrepBal:="PrepaidRem.".Amount;
                //MESSAGE('the prepaid bal %1',PrepBal);
                LoansB.CalcFields(LoansB."Outstanding Balance");
                Bal:=LoansB."Outstanding Balance";
                CBalance:=Bal-PrepBal;
                
                end else if not "PrepaidRem.".Find('-') then begin
                LoansB.CalcFields(LoansB."Outstanding Balance");
                Bal:=LoansB."Outstanding Balance";
                CBalance:=Bal-PrepBal;
                end;
                AccruedInt:=ROUND(((IntRate/1200)*CBalance),0.005,'<');
                /*
                cusld.RESET;
                cusld.SETRANGE(cusld."Loan No","Loan  No.");
                IF cusld.FIND('-') THEN BEGIN
                REPEAT
                IF (Loans."Loan Product Type"='ADVANCE') OR (Loans."Loan Product Type"='SPA') OR (Loans."Loan Product Type"='OVERDRAFT') OR
                (Loans."Loan Product Type"='UTILITY') AND (cusld."Posting Date"= 20101303D)THEN BEGIN
                
                AccruedInt:=0;
                MESSAGE('LOAN TYPE IS %1',Loans."Loan Product Type")
                END ELSE
                AccruedInt:=ROUND(((IntRate/1200)*CBalance),0.005,'<');
                UNTIL cusld.NEXT=0;
                END;*/
                end;
                AsAt:=CalcDate('1D',AsAt);
                if AccruedInt > 0 then begin
                
                    LineNo:=LineNo+10000;
                
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name":='PURCHASES';
                    GenJournalLine."Journal Batch Name":='INTCALC';
                    GenJournalLine."Line No.":=LineNo;
                    GenJournalLine."Account Type":=GenJournalLine."account type"::Customer;
                    GenJournalLine."Account No.":="Loans Register"."Client Code";
                    GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Deposit Contribution";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No.":=DocNo;
                    GenJournalLine."Posting Date":=PDate;
                    GenJournalLine.Description:='Interest Due';
                    GenJournalLine.Amount:=AccruedInt;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"G/L Account";
                    if LoanType.Get("Loans Register"."Loan Product Type") then
                    GenJournalLine."Bal. Account No.":=LoanType."Loan Interest Account";//LoanType."Receivable Interest Account";
                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                    GenJournalLine."Loan No":="Loans Register"."Loan  No.";
                    if GenJournalLine.Amount<>0 then
                    GenJournalLine.Insert;
                end;
                end;
                end;
                end;
                end;
                //END;
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
                
                
                GenJournalLine.RESET;
                GenJournalLine.SETRANGE("Journal Template Name",'PURCHASES');
                GenJournalLine.SETRANGE("Journal Batch Name",'INTCALC');
                GenJournalLine.DELETEALL;
                */

            end;

            trigger OnPreDataItem()
            begin

                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name",'PURCHASES');
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
}

