#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516584 "Daily Requidity Report - 2B"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Daily Requidity Report - 2B.rdlc';

    dataset
    {
        dataitem("Company Information";"Company Information")
        {
            column(ReportForNavId_1120054000; 1120054000)
            {
            }
            column(Name_CompanyInformation;"Company Information".Name)
            {
            }
            column(Asat;Asat)
            {
            }
            column(OpeningBankBalances;OpeningBankBalances)
            {
            }
            column(OpeningTreasuryBalances;OpeningTreasuryBalances)
            {
            }
            column(OpeningTillBalances;OpeningTillBalances)
            {
            }
            column(OpeningMobile;OpeningMobile)
            {
            }
            column(OpeningFdrs;OpeningFdrs)
            {
            }
            column(DayDeposits;DayDeposits)
            {
            }
            column(Loanreceipts;Loanreceipts)
            {
            }
            column(OtherDeposits;OtherDeposits)
            {
            }
            column(Daywithdrawals;Daywithdrawals)
            {
            }
            column(Cashpayments;Cashpayments)
            {
            }
            column(ClosingBankBalances;ClosingBankBalances)
            {
            }
            column(ClosingTreasuryBalances;ClosingTreasuryBalances)
            {
            }
            column(ClosingTillBalances;ClosingTillBalances)
            {
            }
            column(ClosingMobile;ClosingMobile)
            {
            }
            column(ClosingFdrs;ClosingFdrs)
            {
            }
            column(BOSADeposits;BOSADeposits)
            {
            }
            column(FOSADeposits;FOSADeposits)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //Normal Banks opening balance
                OpeningBankBalances:=0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."No.",'%1..%2','16501','16505');
                GLAccount.SetFilter(GLAccount."Date Filter",'..%1',CalcDate('-1D',Asat));
                if GLAccount.FindSet then begin
                  repeat
                    GLAccount.CalcFields(GLAccount."Balance at Date");
                    OpeningBankBalances:=OpeningBankBalances+GLAccount."Balance at Date";
                    until GLAccount.Next=0;
                  end;
                
                //treasury opening balance
                OpeningTreasuryBalances:=0;
                BankAccount.Reset;
                BankAccount.SetRange(BankAccount."Account Type",BankAccount."account type"::Treasury);
                BankAccount.SetFilter(BankAccount."Date Filter",'..%1',CalcDate('-1D',Asat));
                if BankAccount.FindSet then begin
                  repeat
                    BankAccount.CalcFields(BankAccount."Balance at Date");
                    OpeningTreasuryBalances:=OpeningTreasuryBalances+BankAccount."Balance at Date";
                  until BankAccount.Next=0;
                  end;
                //teller tills opening balance
                OpeningTillBalances:=0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."No.",'%1..%2','16527','16530');
                GLAccount.SetFilter(GLAccount."Date Filter",'..%1',CalcDate('-1D',Asat));
                if GLAccount.FindSet then begin
                  repeat
                    GLAccount.CalcFields(GLAccount."Balance at Date");
                    OpeningTillBalances:=OpeningTillBalances+GLAccount."Balance at Date";
                    until GLAccount.Next=0;
                  end;
                //treasu
                //mobile banking float opening balance
                OpeningMobile:=0;
                GLAccount.Reset;
                GLAccount.SetRange(GLAccount."Form 2B",GLAccount."form 2b"::Mobile);
                GLAccount.SetFilter(GLAccount."Date Filter",'..%1',CalcDate('-1D',Asat));
                if GLAccount.FindSet then begin
                  repeat
                    GLAccount.CalcFields(GLAccount."Balance at Date");
                    OpeningMobile:=OpeningMobile+GLAccount."Balance at Date";
                    until GLAccount.Next=0;
                  end;
                //Placement with Banks (FDRs, Near Liquid Assets) opening balance
                OpeningFdrs:=0;
                GLAccount.Reset;
                GLAccount.SetRange(GLAccount."Form 2B",GLAccount."form 2b"::Expenses);
                GLAccount.SetFilter(GLAccount."Date Filter",'..%1',Asat);
                if GLAccount.FindSet then begin
                  repeat
                    GLAccount.CalcFields(GLAccount."Balance at Date");
                    OpeningFdrs:=OpeningFdrs+GLAccount."Balance at Date";
                    until GLAccount.Next=0;
                  end;
                //Deposits from members
                DayDeposits:=0;
                //Bosa deposits
                MemberLedgerEntry.Reset;
                MemberLedgerEntry.SetRange(MemberLedgerEntry."Posting Date",Asat);
                MemberLedgerEntry.SetFilter(MemberLedgerEntry."Transaction Type",'%1|%2',MemberLedgerEntry."transaction type"::"Loan Repayment",MemberLedgerEntry."transaction type"::"Interest Paid");
                MemberLedgerEntry.SetFilter(MemberLedgerEntry.Amount,'<%1',0);
                if MemberLedgerEntry.FindSet then begin
                repeat
                DayDeposits:=DayDeposits+Abs(MemberLedgerEntry.Amount);
                until MemberLedgerEntry.Next=0;
                end;
                //Add FOSA Deposits
                VendorLedgerEntry.Reset;
                VendorLedgerEntry.SetRange(VendorLedgerEntry."Posting Date",Asat);
                VendorLedgerEntry.SetFilter(VendorLedgerEntry."Credit Amount",'<>%1',0);
                if VendorLedgerEntry.FindSet then begin
                  Vendor.Get(VendorLedgerEntry."Vendor No.");
                  if Vendor."BOSA Account No"<>'' then begin
                    VendorLedgerEntry.CalcSums(VendorLedgerEntry."Credit Amount");
                    DayDeposits:=DayDeposits+VendorLedgerEntry."Credit Amount";
                    end;
                  end;
                
                //other day receipts
                OtherDeposits:=0;
                DetailedCustLedgEntry.Reset;
                DetailedCustLedgEntry.SetRange(DetailedCustLedgEntry."Posting Date",Asat);
                DetailedCustLedgEntry.SetFilter(DetailedCustLedgEntry."Credit Amount",'<>%1',0);
                if DetailedCustLedgEntry.FindSet then begin
                  DetailedCustLedgEntry.CalcSums(DetailedCustLedgEntry."Credit Amount");
                   OtherDeposits:=OtherDeposits+DetailedCustLedgEntry."Credit Amount";
                  end;
                
                //All loan receipts
                Loanreceipts:=0;
                MemberLedgerEntry.Reset;
                MemberLedgerEntry.SetRange(MemberLedgerEntry."Posting Date",Asat);
                MemberLedgerEntry.SetFilter(MemberLedgerEntry."Transaction Type",'<>%1|<>%2',MemberLedgerEntry."transaction type"::"Loan Repayment",MemberLedgerEntry."transaction type"::"Interest Paid");
                if MemberLedgerEntry.FindSet then begin
                //REPEAT
                  MemberLedgerEntry.CalcSums(MemberLedgerEntry.Amount);
                Loanreceipts:=Loanreceipts+Abs(MemberLedgerEntry.Amount);
                //UNTIL MemberLedgerEntry.NEXT=0;
                end;
                
                
                //member day withdrawals
                Daywithdrawals:=0;
                VendorLedgerEntry.Reset;
                VendorLedgerEntry.SetRange(VendorLedgerEntry."Posting Date",Asat);
                VendorLedgerEntry.SetFilter(VendorLedgerEntry."Debit Amount",'<>%1',0);
                if VendorLedgerEntry.FindSet then begin
                  Vendor.Get(VendorLedgerEntry."Vendor No.");
                  if Vendor."BOSA Account No"<>'' then begin
                    VendorLedgerEntry.CalcSums(VendorLedgerEntry."Debit Amount");
                    Daywithdrawals:=Daywithdrawals+VendorLedgerEntry."Debit Amount";
                    end;
                  end;
                
                //no-member withdrawals
                Cashpayments:=0;
                /*VendorLedgerEntry.RESET;
                VendorLedgerEntry.SETRANGE(VendorLedgerEntry."Posting Date",Asat);
                VendorLedgerEntry.SETFILTER(VendorLedgerEntry."Debit Amount",'<>%1',0);
                IF VendorLedgerEntry.FINDSET THEN BEGIN
                  Vendor.GET(VendorLedgerEntry."Vendor No.");
                  IF Vendor."BOSA Account No"='' THEN BEGIN
                    VendorLedgerEntry.CALCSUMS(VendorLedgerEntry."Debit Amount");
                    Cashpayments:=Cashpayments+VendorLedgerEntry."Debit Amount";
                    END;
                    END;*/
                
                Banks.Reset;
                Banks.SetFilter(Banks."No.",Banks."No.");
                Banks.SetRange(Banks."Document Date",Asat);
                //Banks.SETFILTER(Banks."Credit Amount",'<>%1',0);
                Banks.SetRange(Banks."Document Type",Banks."document type"::Payment);
                Banks.SetRange(Banks.Status,Banks.Status::Posted);
                if Banks.FindSet then begin
                repeat
                 //Vendor.GET(Banks."Bal. Account No.");
                    Banks.CalcFields(Banks.Amount);
                  //IF Vendor."BOSA Account No"='' THEN BEGIN
                    Cashpayments:=Cashpayments+Banks.Amount;
                    until Banks.Next=0;
                  end;
                
                  //END;
                
                //member day withdrawals
                
                
                
                //Normal Banks closing balance
                ClosingBankBalances:=0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."No.",'%1..%2','16501','16505');
                GLAccount.SetFilter(GLAccount."Date Filter",'..%1',Asat);
                if GLAccount.FindSet then begin
                  repeat
                    GLAccount.CalcFields(GLAccount."Balance at Date");
                    ClosingBankBalances:=ClosingBankBalances+GLAccount."Balance at Date";
                    until GLAccount.Next=0;
                  end;
                //treasury closing balance
                ClosingTreasuryBalances:=0;
                BankAccount.Reset;
                BankAccount.SetRange(BankAccount."Account Type",BankAccount."account type"::Treasury);
                BankAccount.SetFilter(BankAccount."Date Filter",'..%1',Asat);
                if BankAccount.FindSet then begin
                  repeat
                    BankAccount.CalcFields(BankAccount."Balance at Date");
                    ClosingTreasuryBalances:=ClosingTreasuryBalances+BankAccount."Balance at Date";
                  until BankAccount.Next=0;
                  end;
                //teller tills closing balance
                ClosingTillBalances:=0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."No.",'%1..%2','16527','16530');
                GLAccount.SetFilter(GLAccount."Date Filter",'..%1',Asat);
                if GLAccount.FindSet then begin
                  repeat
                    GLAccount.CalcFields(GLAccount."Balance at Date");
                    ClosingTillBalances:=ClosingTillBalances+GLAccount."Balance at Date";
                    until GLAccount.Next=0;
                  end;
                //mobile banking float closing balance
                ClosingMobile:=0;
                GLAccount.Reset;
                GLAccount.SetRange(GLAccount."Form 2B",GLAccount."form 2b"::Mobile);
                GLAccount.SetFilter(GLAccount."Date Filter",'..%1',Asat);
                if GLAccount.FindSet then begin
                  repeat
                    GLAccount.CalcFields(GLAccount."Balance at Date");
                    ClosingMobile:=ClosingMobile+GLAccount."Balance at Date";
                    until GLAccount.Next=0;
                  end;
                //Placement with Banks (FDRs, Near Liquid Assets) closing balance
                ClosingFdrs:=0;
                GLAccount.Reset;
                GLAccount.SetRange(GLAccount."Form 2B",GLAccount."form 2b"::Expenses);
                GLAccount.SetFilter(GLAccount."Date Filter",'..%1',Asat);
                if GLAccount.FindSet then begin
                  repeat
                    GLAccount.CalcFields(GLAccount."Balance at Date");
                    ClosingFdrs:=ClosingFdrs+GLAccount."Balance at Date";
                    until GLAccount.Next=0;
                  end;
                
                
                //bosa deposits
                BOSADeposits:=0;
                GLAccount.Reset;
                GLAccount.SetRange(GLAccount."No.",'20206');
                GLAccount.SetFilter(GLAccount."Date Filter",'..%1',Asat);
                if GLAccount.FindSet then begin
                  repeat
                    GLAccount.CalcFields(GLAccount."Balance at Date");
                    BOSADeposits:=BOSADeposits+(-1*GLAccount."Balance at Date");
                    until GLAccount.Next=0;
                  end;
                
                //fosa deposits
                FOSADeposits:=0;
                GLAccount.Reset;
                GLAccount.SetFilter(GLAccount."No.",'%1..%2','20201','20205');
                GLAccount.SetFilter(GLAccount."Date Filter",'..%1',Asat);
                if GLAccount.FindSet then begin
                  repeat
                    GLAccount.CalcFields(GLAccount."Balance at Date");
                    FOSADeposits:=FOSADeposits+(-1*GLAccount."Balance at Date");
                    until GLAccount.Next=0;
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
                group(Options)
                {
                    Caption = 'Options';
                    field(Asat;Asat)
                    {
                        ApplicationArea = Basic;
                        Caption = 'As At';
                    }
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

    var
        Asat: Date;
        BankAccount: Record "Bank Account";
        OpeningBankBalances: Decimal;
        OpeningTreasuryBalances: Decimal;
        OpeningTillBalances: Decimal;
        OpeningMobile: Decimal;
        GLAccount: Record "G/L Account";
        OpeningFdrs: Decimal;
        MemberLedgerEntry: Record "Member Ledger Entry";
        Loanreceipts: Decimal;
        DayDeposits: Decimal;
        Vendor: Record Vendor;
        VendorLedgerEntry: Record "Detailed Vendor Ledg. Entry";
        OtherDeposits: Decimal;
        DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        Daywithdrawals: Decimal;
        Cashpayments: Decimal;
        ClosingBankBalances: Decimal;
        ClosingTreasuryBalances: Decimal;
        ClosingTillBalances: Decimal;
        ClosingMobile: Decimal;
        ClosingFdrs: Decimal;
        BOSADeposits: Decimal;
        FOSADeposits: Decimal;
        Banks: Record "Payment Header.";
}

