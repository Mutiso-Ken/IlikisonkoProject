#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516537 "Insert to Emp Transactions"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Insert to Emp Transactions.rdlc';

    dataset
    {
        dataitem("Loans Register";"Loans Register")
        {
            column(ReportForNavId_1000000000; 1000000000)
            {
            }
            column(LoanNo;"Loans Register"."Loan  No.")
            {
            }
            column(ProductType;"Loans Register"."Loan Product Type")
            {
            }

            trigger OnAfterGetRecord()
            begin
                "Loans Register".Reset;
                if "Loans Register".Deductible=true then begin


                Transaction.Reset;
                Transaction.SetRange(Transaction."Leave Reimbursement","Loans Register"."Loan Product Type");
                if Transaction.Find('-') then
                  TCode:=Transaction."Transaction Code";
                  Tname:=Transaction."Transaction Name";
                  TType:=Transaction."Transaction Type";
                  //EmpTrans.SETRANGE(EmpTrans."No.",Employees."No.");
                Employees.Reset;
                if not Employees.Get("Loans Register"."Client Code") then CurrReport.Skip;

                repeat
                EmpTrans.Init;
                EmpTrans."Transaction Code":=TCode;
                EmpTrans."No.":="Loans Register"."Client Code";
                EmpTrans.Insert;
                until EmpTrans.Next=0;

                EmpTrans.Reset;
                EmpTrans.SetRange(EmpTrans."No.","Loans Register"."Client Code");
                if EmpTrans.Find('-') then begin
                EmpTrans."Loan Number":="Loans Register"."Loan  No.";
                EmpTrans.Modify;
                end;
                end;
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
        EmpTrans: Record "Payroll Employee Transactions.";
        Employees: Record "Payroll Employee.";
}

