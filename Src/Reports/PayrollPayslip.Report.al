#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516310 "Payroll Payslip."
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Payroll Payslip..rdlc';

    dataset
    {
        dataitem("Payroll Employee.";"Payroll Employee.")
        {
            RequestFilterFields = "No.";
            column(ReportForNavId_1; 1)
            {
            }
            column(No;"No.")
            {
            }
            column(Surname;Surname)
            {
            }
            column(FirstName;Firstname)
            {
            }
            column(Lastname;Lastname)
            {
            }
            column(CName;CompanyInfo.Name)
            {
            }
            column(CAddress;CompanyInfo.Address)
            {
            }
            column(CPic;CompanyInfo.Picture)
            {
            }
            column(PeriodName;PeriodName)
            {
            }
            column(DEP;"Payroll Employee.".Department)
            {
            }
            column(PINNo;"PIN No")
            {
            }
            column(NSSFNo;"NSSF No")
            {
            }
            column(NHIFNo;"NHIF No")
            {
            }
            column(BankName;"Bank Name")
            {
            }
            column(BranchName;"Branch Name")
            {
            }
            column(BankAccNo;"Bank Account No")
            {
            }
            dataitem("prPeriod Transactions.";"prPeriod Transactions.")
            {
                DataItemLink = "Employee Code"=field("No."),"Payroll Period"=field("Current Month Filter");
                RequestFilterFields = "Payroll Period";
                column(ReportForNavId_6; 6)
                {
                }
                column(TCode;"Transaction Code")
                {
                }
                column(TName;"Transaction Name")
                {
                }
                column(Amount;Amount)
                {
                }
                column(Grouping;"prPeriod Transactions."."Group Order")
                {
                }
            }
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

    trigger OnPreReport()
    begin
         CompanyInfo.Get;
         CompanyInfo.CalcFields(CompanyInfo.Picture);

          PayrollCalender.Reset;
          PayrollCalender.SetRange(PayrollCalender.Closed,false);
          if PayrollCalender.FindFirst then begin
            //"Payroll Period":=PayrollCalender."Date Opened";
            PayrollCalender.Copyfilter(PayrollCalender."Date Opened","prPeriod Transactions."."Payroll Period");
            PeriodName:=PayrollCalender."Period Name";
          end;
        if UserSetup.Get(UserId) then
        begin
        if UserSetup."View Payroll"=false then Error ('You dont have permissions for payroll, Contact your system administrator! ')
        end;
    end;

    var
        CompanyInfo: Record "Company Information";
        PayrollCalender: Record "Payroll Calender.";
        "Payroll Period": Date;
        PeriodName: Text;
        PayrollEmp: Record "Payroll Employee.";
        UserSetup: Record "User Setup";
}

