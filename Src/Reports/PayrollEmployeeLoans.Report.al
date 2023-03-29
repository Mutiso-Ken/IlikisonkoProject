#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516535 "Payroll Employee Loans"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Payroll Employee Loans.rdlc';

    dataset
    {
        dataitem("Payroll Employee Transactions.";"Payroll Employee Transactions.")
        {
            column(ReportForNavId_1000000000; 1000000000)
            {
            }

            trigger OnAfterGetRecord()
            begin
                 Loans.Reset;
                 Loans.SetRange(Loans."Client Code","Payroll Employee Transactions."."No.");
                 if Loans.Find('-') then begin
                 repeat
                  //IF Loans.Deductible=TRUE THEN  BEGIN
                   Loans.CalcFields(Loans."Outstanding Balance");
                   if Loans."Outstanding Balance">0 then begin
                   LoanType:=Loans."Loan Product Type";


                   // IF "Payroll Employee Transactions."."Loan Number"<>Loans."Loan  No." THEN
                    Transaction.Reset;
                     Transaction.SetRange(Transaction."Transaction Type",Transaction."transaction type"::Deduction);
                     Transaction.SetRange(Transaction."Leave Reimbursement",LoanType);
                     if Transaction.Find('-') then begin
                      TCode:=Transaction."Transaction Code";
                      Tname:=Transaction."Transaction Name";
                      TType:=Transaction."Transaction Type";
                   "Payroll Employee Transactions.".Init;
                   "Payroll Employee Transactions."."No.":=Loans."Client Code";
                   "Payroll Employee Transactions."."Sacco Membership No.":=Loans."Client Code";
                   "Payroll Employee Transactions."."Transaction Code":=TCode;
                   "Payroll Employee Transactions."."Transaction Name":=Tname;
                   "Payroll Employee Transactions."."Transaction Type":=TType;
                   "Payroll Employee Transactions."."Loan Number":=Loans."Loan  No.";
                   "Payroll Employee Transactions."."Period Month":=10;
                   "Payroll Employee Transactions."."Period Year":=2016;
                   "Payroll Employee Transactions.".Insert;
                   end;
                   end;
                until Loans.Next=0;
                //END;

                end;
                //ELSE
                //CurrReport.SKIP;
            end;

            trigger OnPreDataItem()
            begin
                //LoanType:='';
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
        Loans: Record "Loans Register";
        Transaction: Record "Payroll Transaction Code.";
        LoanType: Code[30];
        TCode: Code[30];
        Tname: Text;
        TType: Option Income,Deduction;
        LoanSetup: Record "Loan Products Setup";
        Deductable: Boolean;
}

