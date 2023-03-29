#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516602 "Loan Recovery Report-2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Loan Recovery Report-2.rdlc';

    dataset
    {
        dataitem("Member Ledger Entry";"Member Ledger Entry")
        {
            DataItemTableView = where("Transaction Type"=filter("Loan Repayment"|"Interest Paid"),Amount=filter(<>0),Reversed=const(false));
            RequestFilterFields = "Posting Date","Loan No","Loan Type","Transaction Type";
            column(ReportForNavId_1000000006; 1000000006)
            {
            }
            column(Amount_MemberLedgerEntry;"Member Ledger Entry".Amount)
            {
            }
            column(TransactionType_MemberLedgerEntry;"Member Ledger Entry"."Transaction Type")
            {
            }
            column(PostingDate_MemberLedgerEntry;"Member Ledger Entry"."Posting Date")
            {
            }
            column(Loan_No;LoanNo)
            {
            }
            column(Client_Code;LoanAccount)
            {
            }
            column(Client_Name;Loanname)
            {
            }
            column(LoanType_MemberLedgerEntry;"Member Ledger Entry"."Loan Type")
            {
            }
            column(Loan_Bal;LoanBal)
            {
            }
            column(DocumentNo_MemberLedgerEntry;"Member Ledger Entry"."Document No.")
            {
            }
            column(Description_MemberLedgerEntry;"Member Ledger Entry".Description)
            {
            }
            column(GlobalDimension2Code_MemberLedgerEntry;"Member Ledger Entry"."Global Dimension 2 Code")
            {
            }
            column(BranchCode;BranchCode)
            {
            }
            dataitem("Member Register";"Member Register")
            {
                DataItemLink = "No."=field("Customer No.");
                column(ReportForNavId_1; 1)
                {
                }
                column(No_MemberRegister;"Member Register"."No.")
                {
                }
                column(Name_MemberRegister;"Member Register".Name)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                if BranchFilter <> '' then
                  begin
                    Cust.Get("Member Ledger Entry"."Customer No.");
                    if Cust."Global Dimension 2 Code" <> BranchCode then
                      CurrReport.Skip;
                    BranchCode := BranchFilter
                  end else
                  begin
                    BranchCode := '';
                    if Cust.Get("Member Ledger Entry"."Customer No.") then begin
                      BranchCode := Cust."Global Dimension 2 Code";
                      end;
                  end;

                if loanApp.Get("Member Ledger Entry"."Loan No") then begin
                  //loanApp.SETRANGE(loanApp."Date filter","Member Ledger Entry"."Posting Date");
                  loanApp.CalcFields(loanApp."Outstanding Balance");

                  LoanNo:=loanApp."Loan  No.";
                  LoanAccount:=loanApp."Account No";
                  Loanname:=loanApp."Client Name";
                  LoanBal:=loanApp."Outstanding Balance";
                  end;

                // IF Cust.GET("Member Ledger Entry"."Customer No.") THEN BEGIN
                //   BranchCode := Cust."Global Dimension 2 Code";
                //   END;
            end;

            trigger OnPreDataItem()
            begin
                LoanNo:='';
                Loanname:='';
                LoanBal:=0;

                if BranchCode <> '' then
                  BranchFilter := BranchCode
                else
                  BranchFilter := '';
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(BranchCode;BranchCode)
                {
                    ApplicationArea = Basic;
                    Caption = 'Branch Code';
                    TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(2));
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
        loanApp: Record "Loans Register";
        LoanNo: Code[10];
        LoanAccount: Code[50];
        Loanname: Code[50];
        LoanBal: Decimal;
        BranchCode: Code[50];
        Cust: Record "Member Register";
        CustLedger: Record "Member Ledger Entry";
        BranchFilter: Code[50];
}

