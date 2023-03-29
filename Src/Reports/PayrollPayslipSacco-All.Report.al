#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50018 "Payroll Payslip Sacco- All"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Payroll Payslip Sacco- All.rdlc';

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
            column(FullName;"Full Name")
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
            column(Department;"Payroll Employee.".Department)
            {
            }
            column(UserId;UserId)
            {
            }
            column(BankAccNo;"Bank Account No")
            {
            }
            dataitem("prPeriod Transactions.";"prPeriod Transactions.")
            {
                DataItemLink = "Employee Code"=field("No.");
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
                column(Gtext;"Group Text")
                {
                }
                column(Grouping;"Group Order")
                {
                }
                column(TBalances;Balance)
                {
                }
                column(SubGroupOrder;"prPeriod Transactions."."Sub Group Order")
                {
                }
                column(Amount;Amount)
                {
                }
                column(PeriodMonth_prPeriodTransactions;"Period Month")
                {
                }
                column(PeriodYear_prPeriodTransactions;"Period Year")
                {
                }
                column(PeriodFilter_prPeriodTransactions;"prPeriod Transactions."."Period Filter")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    PayrollCalender.Reset;
                        PayrollCalender.SetRange(PayrollCalender."Date Opened","Payroll Period");
                        if PayrollCalender.FindLast then begin
                          PeriodName:=PayrollCalender."Period Name"+'-'+ Format(PayrollCalender."Period Year");
                        end;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                    /*PayrollCalender.RESET;
                    PayrollCalender.SETRANGE(PayrollCalender."Date Opened","Date Filter");
                    IF PayrollCalender.FINDLAST THEN BEGIN
                      PeriodName:=PayrollCalender."Period Name";
                    END;*/
                
                
                /*
                    memb.RESET;
                    memb.SETRANGE(memb."No.","Payroll Employee."."Sacco Membership No.");
                    IF memb.FINDFIRST THEN BEGIN
                    "prPeriod Transactions.".RESET;
                    "prPeriod Transactions.".SETRANGE("prPeriod Transactions."."Employee Code","Payroll Employee."."No.");
                    "prPeriod Transactions.".SETRANGE("prPeriod Transactions."."Transaction Code",'D01');
                    IF "prPeriod Transactions.".FINDFIRST THEN BEGIN
                    REPEAT
                    "prPeriod Transactions.".Balance:=memb."Current Savings"+"prPeriod Transactions.".Amount;
                    UNTIL "prPeriod Transactions.".NEXT=0;
                    "prPeriod Transactions.".MODIFY;
                    END;
                    END;*/

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
         if UserSetup.Get(UserId) then begin
          if not UserSetup."View Payroll" then
            Error(PemissionDenied);
         end else begin
          Error(UserNotFound,UserId);
         end;
    end;

    trigger OnPreReport()
    begin
         CompanyInfo.Get;
         CompanyInfo.CalcFields(CompanyInfo.Picture);
        
         /*PayrollEmp.RESET;
         PayrollEmp.SETRANGE(PayrollEmp.Status,PayrollEmp.Status::Active);
         IF PayrollEmp.FINDFIRST THEN BEGIN
           PayrollCalender.RESET;
           PayrollCalender.SETRANGE(PayrollCalender."Date Opened",PayrollEmp."Date Filter");
           IF PayrollCalender.FINDLAST THEN BEGIN
                PeriodName:=PayrollCalender."Period Name";
           END;
         END;*/

    end;

    var
        CompanyInfo: Record "Company Information";
        PayrollCalender: Record "Payroll Calender.";
        "Payroll Period": Date;
        PeriodName: Text;
        PayrollEmp: Record "Payroll Employee.";
        UserNotFound: label 'User Setup %1 not found.';
        PemissionDenied: label 'User Account is not Setup for Payroll Use. Contact System Administrator.';
        UserSetup: Record "User Setup";
        memb: Record "Member Register";
}

