#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516560 "Account Statement"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Account Statement.rdlc';

    dataset
    {
        dataitem(Transactions;Transactions)
        {
            RequestFilterFields = "Transaction Type","Tenant No","Tenant Name";
            column(ReportForNavId_4645; 4645)
            {
            }
            column(Description_Transactions;Transactions.Description)
            {
            }
            column(TenantNo_Transactions;Transactions."Tenant No")
            {
            }
            column(TenantTransactions_Transactions;Transactions."Tenant Transactions")
            {
            }
            column(TenantName_Transactions;Transactions."Tenant Name")
            {
            }
            column(No_Transactions;Transactions.No)
            {
            }
            column(AccountNo_Transactions;Transactions."Account No")
            {
            }
            column(AccountName_Transactions;Transactions."Account Name")
            {
            }
            column(TransactionType_Transactions;Transactions."Transaction Type")
            {
            }
            column(Amount_Transactions;Transactions.Amount)
            {
            }
            column(Cashier_Transactions;Transactions.Cashier)
            {
            }
            column(TransactionDate_Transactions;Transactions."Transaction Date")
            {
            }
            column(TransactionTime_Transactions;Transactions."Transaction Time")
            {
            }
            column(Posted_Transactions;Transactions.Posted)
            {
            }
            column(NoSeries_Transactions;Transactions."No. Series")
            {
            }
            column(AccountType_Transactions;Transactions."Account Type")
            {
            }

            trigger OnAfterGetRecord()
            begin
                
                /*
                
                BaldateTXT:='01/01/10..'+FORMAT(Baldate);
                
                "Members Register".RESET;
                "Members Register".SETRANGE("Members Register"."No.","No.");
                "Members Register".SETFILTER("Members Register"."Date Filter",BaldateTXT);
                IF "Members Register".FIND('-') THEN BEGIN
                "Members Register".CALCFIELDS("Members Register"."Current Shares","Members Register"."Shares Retained","Members Register"."Insurance Fund");
                  END;
                //DivBal:= "Dividend Amount" *-1;
                Balance6:=Balance6 + "Dividend Amount";
                
                RNo:=RNo+1;
                MODIFY;
                */
                /*
                Loan.RESET;
                Loan.SETRANGE(Loan."Client Code","No.");
                IF Loan.FIND('-') THEN BEGIN
                    REPEAT
                        Loan."Company Code":="Company Code";
                        Loan.MODIFY;
                
                    UNTIL Loan.NEXT=0;
                END;
                
                Loan.RESET;
                Loan.SETRANGE(Loan."BOSA No","No.");
                IF Loan.FIND('-') THEN BEGIN
                    REPEAT
                        Loan."Company Code":="Company Code";
                        Loan.MODIFY;
                    UNTIL Loan.NEXT=0;
                END;
                */

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

    trigger OnPreReport()
    begin
               /* IF "COMPY INFOR".GET THEN
                BEGIN
        "COMPY INFOR".CALCFIELDS("COMPY INFOR".Picture);
                NAME:="COMPY INFOR".Name;
                END;*/

    end;

    var
        RNo: Integer;
        BaldateTXT: Text[30];
        DivBal: Decimal;
        Loan: Record "Loans Register";
        Balance6: Decimal;
        Company: Record "Company Information";
        Baldate: Date;
}

