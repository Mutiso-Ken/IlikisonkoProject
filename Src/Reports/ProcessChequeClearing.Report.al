#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516462 "Process Cheque Clearing"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Process Cheque Clearing.rdlc';

    dataset
    {
        dataitem(Transactions;Transactions)
        {
            DataItemTableView = sorting(No) where(Type=const('Cheque Deposit'),Posted=const(true),"Cheque Processed"=const(false));
            PrintOnlyIfDetail = false;
            RequestFilterFields = "Expected Maturity Date","Account No","Cheque No";
            column(ReportForNavId_4645; 4645)
            {
            }
            column(FORMAT_TODAY_0_4_;Format(Today,0,4))
            {
            }
            column(COMPANYNAME;COMPANYNAME)
            {
            }
            column(Company_Name;Company.Name)
            {
            }
            column(Company_Address;Company.Address)
            {
            }
            column(Company_Address2;Company."Address 2")
            {
            }
            column(Company_Phone_No;Company."Phone No.")
            {
            }
            column(Company_Fax_No;Company."Fax No.")
            {
            }
            column(Company_Picture;Company.Picture)
            {
            }
            column(Company_Email;Company."E-Mail")
            {
            }
            column(CurrReport_PAGENO;CurrReport.PageNo)
            {
            }
            column(USERID;UserId)
            {
            }
            column(No;Transactions.No)
            {
            }
            column(Account_No;Transactions."Account No")
            {
            }
            column(Account_Name;Transactions."Account Name")
            {
            }
            column(Maturity_Date;Format(Transactions."Expected Maturity Date"))
            {
            }
            column(Cheque_No;Transactions."Cheque No")
            {
            }
            column(Cheque_Date;Format(Transactions."Cheque Date"))
            {
            }
            column(BIH_No;Transactions."BIH No")
            {
            }
            column(Amount;Transactions.Amount)
            {
            }
            column(S_No;SN)
            {
            }

            trigger OnAfterGetRecord()
            begin

                ChargeAmount:=0;

                if (Transactions.Status = Transactions.Status::Pending) or (Transactions.Status = Transactions.Status::Honoured) then begin
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name",'PURCHASES');
                GenJournalLine.SetRange("Journal Batch Name",'FTRANS');
                GenJournalLine.DeleteAll;

                //Charges
                ChequeType.Reset;
                ChequeType.SetRange(ChequeType.Code,Transactions."Cheque Type");
                if ChequeType.Find('-') then begin
                DimensionV.Reset;
                DimensionV.SetRange(DimensionV."Dimension Code",'BRANCH');
                DimensionV.SetRange(DimensionV.Code,Transactions."Transacting Branch");
                if DimensionV.Find('-') then begin

                if ChequeType.Type = ChequeType.Type::Upcountry then
                ChargeAmount:=ChequeType."Clearing Charges"
                else if ChequeType.Type = ChequeType.Type::"Local" then
                ChargeAmount:=ChequeType."Clearing Charges";

                GenJournalLine.Init;
                GenJournalLine."Journal Template Name":='PURCHASES';
                GenJournalLine."Journal Batch Name":='FTRANS';
                GenJournalLine."Document No.":=No;
                GenJournalLine."External Document No.":="Cheque No";
                GenJournalLine."Line No.":=LineNo;
                GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                GenJournalLine."Account No.":="Account No";
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Posting Date":=Today;
                GenJournalLine.Description:='Cheque Clearing Charges';
                GenJournalLine.Validate(GenJournalLine."Currency Code");
                GenJournalLine.Amount:=ChargeAmount;
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"G/L Account";
                GenJournalLine."Bal. Account No.":=ChequeType."Clearing Charges GL Account";
                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                GenJournalLine."Shortcut Dimension 1 Code":='FOSA';
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                GenJournalLine."Shortcut Dimension 2 Code":=Transactions."Transacting Branch";
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                if GenJournalLine.Amount<>0 then
                GenJournalLine.Insert;

                end;
                end;

                //Charges

                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name",'PURCHASES');
                GenJournalLine.SetRange("Journal Batch Name",'FTRANS');
                if GenJournalLine.Find('-') then begin
                repeat
                GLPosting.Run(GenJournalLine);
                until GenJournalLine.Next = 0;
                end;


                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name",'PURCHASES');
                GenJournalLine.SetRange("Journal Batch Name",'FTRANS');
                GenJournalLine.DeleteAll;



                Transactions."Cheque Processed":=true;
                Transactions."Date Cleared":=Today;
                Transactions.Modify;
                end;
            end;

            trigger OnPreDataItem()
            begin
                //Transactions.SETRANGE(Transactions."Expected Maturity Date",0D,TODAY);
                SN:=SN+1;
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
        GenJournalLine: Record "Gen. Journal Line";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        Account: Record Vendor;
        AccountType: Record "Account Types-Saving Products";
        LineNo: Integer;
        ChequeType: Record "Cheque Types";
        DimensionV: Record "Dimension Value";
        ChargeAmount: Decimal;
        SN: Integer;
}

