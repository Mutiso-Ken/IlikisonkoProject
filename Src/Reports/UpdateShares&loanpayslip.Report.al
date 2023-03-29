#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516591 "Update Shares & loan payslip"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Update Shares & loan payslip.rdlc';

    dataset
    {
        dataitem("prPeriod Transactions.";"prPeriod Transactions.")
        {
            RequestFilterFields = "Employee Code";
            column(ReportForNavId_1000000000; 1000000000)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //Update shares on Payslips manu
                if "prPeriod Transactions."."Transaction Code"='D025' then begin
                memb.SetRange(memb."Customer No.", "prPeriod Transactions."."Employee Code");
                memb.SetRange(memb."Transaction Type",memb."transaction type"::Loan);
                if memb.Find('-') then begin
                Totalshares:=0;
                 repeat
                 Totalshares:=Totalshares+memb.Amount;
                 until memb.Next=0;
                 Totalshares:=Totalshares*-1;
                 end;

                "prPeriod Transactions.".Balance:=Totalshares;
                "prPeriod Transactions.".Modify;
                end;
                //end of shares update

                 //Getting Loan OutStanding Balance Manu
                 if ("prPeriod Transactions."."Loan Number"<>'') and ("prPeriod Transactions."."coop parameters"="prPeriod Transactions."."coop parameters"::loan) then begin
                 LoanR.SetRange(LoanR."Loan  No.","Loan Number");;
                 if LoanR.Find('-') then begin
                  LNPric:=0;
                  LoanR.CalcFields(LoanR."Outstanding Balance");
                  LNPric:=LoanR."Outstanding Balance";
                 end;
                 //End of getting loan

                 //updating Payroll Employee transactions
                "prPeriod Transactions.".Balance:=(LNPric);
                "prPeriod Transactions.".Modify;
                end;

                if ("prPeriod Transactions."."Loan Number"<>'') and ("prPeriod Transactions."."coop parameters"="prPeriod Transactions."."coop parameters"::"loan Interest")then begin
                 LoanR.SetRange(LoanR."Loan  No.","Loan Number");
                 if LoanR.Find('-') then begin
                  LNPric:=0;
                  LoanR.CalcFields(LoanR."Interest Due");
                  LNPric:=LoanR."Interest Due";
                 end;
                 //End of getting loan

                 //updating Payroll Employee transactions
                "prPeriod Transactions.".Balance:=(LNPric);
                "prPeriod Transactions.".Modify;
                end;
                //end of Loan D005 update
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
        Totalshares: Decimal;
        memb: Record "Member Ledger Entry";
        LoanR: Record "Loans Register";
        membRep: Record "Member Ledger Entry";
        LastAmount: Decimal;
        LNRepay: Decimal;
        LNPric: Decimal;
}

