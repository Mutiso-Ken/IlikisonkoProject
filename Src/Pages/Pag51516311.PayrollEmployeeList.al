#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516311 "Payroll Employee List."
{
    CardPageID = "Payroll Employee Card.";
    DeleteAllowed = true;
    InsertAllowed = true;
    PageType = List;
    SourceTable = "Payroll Employee.";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No.";"No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Staff  No.';
                }
                field("Payroll No";"Payroll No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Sacco Membership No.';
                }
                field(Surname;Surname)
                {
                    ApplicationArea = Basic;
                }
                field(Firstname;Firstname)
                {
                    ApplicationArea = Basic;
                }
                field(Lastname;Lastname)
                {
                    ApplicationArea = Basic;
                }
                field("Basic Pay";"Basic Pay")
                {
                    ApplicationArea = Basic;
                }
                field("Joining Date";"Joining Date")
                {
                    ApplicationArea = Basic;
                }
                field("Job Group";"Job Group")
                {
                    ApplicationArea = Basic;
                }
                field(Category;Category)
                {
                    ApplicationArea = Basic;
                }
                field("Posting Group";"Posting Group")
                {
                    ApplicationArea = Basic;
                }
                field("Pays PAYE";"Pays PAYE")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Account No";"Bank Account No")
                {
                    ApplicationArea = Basic;
                }
                field("Employee Email";"Employee Email")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control9;Outlook)
            {
            }
            systempart(Control10;Notes)
            {
            }
            systempart(Control11;MyNotes)
            {
            }
            systempart(Control12;Links)
            {
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Update Employee Deductions")
            {
                ApplicationArea = Basic;
                Image = UpdateDescription;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    PayrollPeriod:=knFindLastOpenPeriod();
                    HrEmployee.Reset;
                    if HrEmployee.Find('-') then
                      begin
                        ProgressWindow.Open('Updating transactions for for Employee No. #1#######');
                        repeat
                          Sleep(100);
                          KnGetNewLoanDeductions(HrEmployee."Sacco Membership No.",'D301',HrEmployee."No.",PayrollPeriod);
                          KnGetNewLoanDeductions(HrEmployee."Sacco Membership No.",'D302',HrEmployee."No.",PayrollPeriod);
                          KnGetNewLoanDeductions(HrEmployee."Sacco Membership No.",'D303',HrEmployee."No.",PayrollPeriod);
                          KnGetNewLoanDeductions(HrEmployee."Sacco Membership No.",'D304',HrEmployee."No.",PayrollPeriod);
                          KnGetNewLoanDeductions(HrEmployee."Sacco Membership No.",'D305',HrEmployee."No.",PayrollPeriod);
                          KnGetNewLoanDeductions(HrEmployee."Sacco Membership No.",'D306',HrEmployee."No.",PayrollPeriod);
                          KnGetNewLoanDeductions(HrEmployee."Sacco Membership No.",'D307',HrEmployee."No.",PayrollPeriod);
                          KnGetNewLoanDeductions(HrEmployee."Sacco Membership No.",'D308',HrEmployee."No.",PayrollPeriod);
                          KnGetNewLoanDeductions(HrEmployee."Sacco Membership No.",'D309',HrEmployee."No.",PayrollPeriod);
                          KnGetNewLoanDeductions(HrEmployee."Sacco Membership No.",'D310',HrEmployee."No.",PayrollPeriod);
                          KnGetNewLoanDeductions(HrEmployee."Sacco Membership No.",'D311',HrEmployee."No.",PayrollPeriod);
                          KnGetNewLoanDeductions(HrEmployee."Sacco Membership No.",'D312',HrEmployee."No.",PayrollPeriod);
                          KnGetNewLoanDeductions(HrEmployee."Sacco Membership No.",'D313',HrEmployee."No.",PayrollPeriod);
                          KnUpdateDemandSavingsContributions(HrEmployee."Sacco Membership No.",'D04',HrEmployee."No.",PayrollPeriod);
                          KnUpdateDepositContributions(HrEmployee."Sacco Membership No.",'D01',HrEmployee."No.",PayrollPeriod);
                          KnUpdateShareCapitalContributions(HrEmployee."Sacco Membership No.",'D02',HrEmployee."No.",PayrollPeriod);
                        until HrEmployee.Next=0;
                        ProgressWindow.Close();
                        Message('Successfully completed');
                      end;
                end;
            }
            action("Select Period")
            {
                ApplicationArea = Basic;
                Image = PaymentPeriod;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = false;
                PromotedOnly = false;
                RunObject = Page UnknownPage51516788;
            }
        }
    }

    trigger OnInit()
    begin
        //TODO
        if Usersetup.Get(UserId) then
        begin
        if Usersetup."View Payroll"=false then Error ('You dont have permissions for Payroll, Contact your system administrator! ')
        end;
    end;

    var
        Usersetup: Record "User Setup";
        PayrollEmp: Record "Payroll Employee.";
        PayrollManager: Codeunit "Payroll Management";
        "Payroll Period": Date;
        PayrollCalender: Record "Payroll Calender.";
        PayrollMonthlyTrans: Record "Payroll Monthly Transactions.";
        PayrollEmployeeDed: Record "Payroll Employee Deductions.";
        PayrollEmployerDed: Record "Payroll Employer Deductions.";
        objEmp: Record "Salary Processing Header";
        SalCard: Record "Payroll Employee.";
        objPeriod: Record "Payroll Calender.";
        SelectedPeriod: Date;
        PeriodName: Text[30];
        PeriodMonth: Integer;
        PeriodYear: Integer;
        ProcessPayroll: Codeunit "Payroll Processing";
        HrEmployee: Record "Payroll Employee.";
        ProgressWindow: Dialog;
        prPeriodTransactions: Record "prPeriod Transactions.";
        prEmployerDeductions: Record "Payroll Employer Deductions.";
        PayrollType: Record "Payroll Type.";
        Selection: Integer;
        PayrollDefined: Text[30];
        PayrollCode: Code[10];
        NoofRecords: Integer;
        i: Integer;
        ContrInfo: Record "Control-Information.";
        ObjPayrollTransactions: Record "prPeriod Transactions.";
        varPeriodMonth: Integer;
        GenSetUp: Record "Sacco General Set-Up";
        PayrollPeriod: Date;

    local procedure KnGetNewLoanDeductions(MemberNo: Code[10];TransCode: Code[20];EmployeeNo: Code[20];Period: Date)
    var
        ObjEmployeeTrans: Record "Payroll Employee Transactions.";
        ObjLoansReg: Record "Loans Register";
    begin
        if not KnCheckIfLoanProductExist(MemberNo,TransCode,EmployeeNo,Period) then
          begin
            ObjLoansReg.Reset;
            ObjLoansReg.SetRange(ObjLoansReg."Loan Product Type",TransCode);
            ObjLoansReg.SetRange(ObjLoansReg."Client Code",MemberNo);
            ObjLoansReg.SetFilter(ObjLoansReg."Outstanding Balance",'>%1',0);
            if ObjLoansReg.Find('-') then
              begin
                repeat
                  ObjLoansReg.CalcFields("Outstanding Balance");
                  ObjEmployeeTrans.Init;
                  ObjEmployeeTrans."Sacco Membership No.":=MemberNo;
                  ObjEmployeeTrans."Member No":=MemberNo;
                  ObjEmployeeTrans.Membership:=MemberNo;
                  ObjEmployeeTrans."Payroll Period":=Period;
                  ObjEmployeeTrans."Transaction Code":=ObjLoansReg."Loan Product Type";
                  ObjEmployeeTrans.Validate(ObjEmployeeTrans."Transaction Code");
                  ObjEmployeeTrans."No.":=EmployeeNo;
                  ObjEmployeeTrans."Loan Number":=ObjLoansReg."Loan  No.";
                  ObjEmployeeTrans.Insert(true);
                until ObjLoansReg.Next=0;
              end;
          end;
          KnUpdateExistingLoans(MemberNo,TransCode,EmployeeNo,Period);
    end;

    local procedure KnUpdateExistingLoans(MemberNo: Code[10];TransCode: Code[20];EmployeeNo: Code[20];Period: Date)
    var
        ObjEmployeeTrans: Record "Payroll Employee Transactions.";
        ObjMembersReg: Record "Member Register";
    begin
        ObjEmployeeTrans.Reset;
        ObjEmployeeTrans.SetRange(ObjEmployeeTrans."Sacco Membership No.",MemberNo);
        ObjEmployeeTrans.SetRange(ObjEmployeeTrans."Transaction Code",TransCode);
        ObjEmployeeTrans.SetRange(ObjEmployeeTrans."No.",EmployeeNo);
        ObjEmployeeTrans.SetRange(ObjEmployeeTrans."Payroll Period",Period);
        if ObjEmployeeTrans.Find('-') then
          begin
            repeat
              ObjEmployeeTrans.Validate(ObjEmployeeTrans."Loan Number");
              ObjEmployeeTrans.Modify(true);
            until ObjEmployeeTrans.Next=0;
          end;
    end;

    local procedure KnUpdateInsuranceContributions(MemberNo: Code[10];TransCode: Code[20];EmployeeNo: Code[20];Period: Date)
    var
        ObjEmployeeTrans: Record "Payroll Employee Transactions.";
        ObjMembersReg: Record "Member Register";
        Amount: Decimal;
    begin
        ObjEmployeeTrans.Reset;
        ObjEmployeeTrans.SetRange(ObjEmployeeTrans."Sacco Membership No.",MemberNo);
        ObjEmployeeTrans.SetRange(ObjEmployeeTrans."Transaction Code",TransCode);
        ObjEmployeeTrans.SetRange(ObjEmployeeTrans."No.",EmployeeNo);
        ObjEmployeeTrans.SetRange(ObjEmployeeTrans."Payroll Period",Period);
        if ObjEmployeeTrans.Find('-') then
          begin
        //    IF ObjMembersReg.GET(ObjEmployeeTrans."Sacco Membership No.") THEN
        //      Amount:=ObjMembersReg."Monthly Insurance";
            if Amount=0 then
              Amount:=GenSetUp."Welfare Contribution";

            if Amount=ObjEmployeeTrans.Amount then
              ObjEmployeeTrans.Amount:=ObjEmployeeTrans.Amount
            else
              ObjEmployeeTrans.Amount:=Amount;

            ObjEmployeeTrans.Modify(true);
          end else
            begin
        //      IF ObjMembersReg.GET(MemberNo) THEN
        //        Amount:=ObjMembersReg."Monthly Insurance";
              if Amount=0 then
                Amount:=GenSetUp."Welfare Contribution";
              ObjEmployeeTrans.Init;
              ObjEmployeeTrans."Transaction Code":=TransCode;
              ObjEmployeeTrans.Validate("Transaction Code");
              ObjEmployeeTrans."Sacco Membership No.":=MemberNo;
              ObjEmployeeTrans."Member No":=MemberNo;
              ObjEmployeeTrans.Membership:=MemberNo;
              ObjEmployeeTrans."Payroll Period":=Period;
              ObjEmployeeTrans."No.":=EmployeeNo;
              ObjEmployeeTrans.Amount:=Amount;
              if Amount<>0 then
              ObjEmployeeTrans.Insert(true);
            end;
    end;

    local procedure KnUpdateDepositContributions(MemberNo: Code[10];TransCode: Code[20];EmployeeNo: Code[20];Period: Date)
    var
        ObjEmployeeTrans: Record "Payroll Employee Transactions.";
        ObjMembersReg: Record "Member Register";
        Amount: Decimal;
    begin
        GenSetUp.Get;
        ObjEmployeeTrans.Reset;
        ObjEmployeeTrans.SetRange(ObjEmployeeTrans."Sacco Membership No.",MemberNo);
        ObjEmployeeTrans.SetRange(ObjEmployeeTrans."Transaction Code",TransCode);
        ObjEmployeeTrans.SetRange(ObjEmployeeTrans."No.",EmployeeNo);
        ObjEmployeeTrans.SetRange(ObjEmployeeTrans."Payroll Period",Period);
        if ObjEmployeeTrans.Find('-') then
          begin
            if ObjMembersReg.Get(ObjEmployeeTrans."Sacco Membership No.") then
              Amount:=ObjMembersReg."Monthly Contribution";
            if Amount=0 then
              Amount:=GenSetUp."Min. Contribution";

            if Amount=ObjEmployeeTrans.Amount then
              ObjEmployeeTrans.Amount:=ObjEmployeeTrans.Amount
            else
              ObjEmployeeTrans.Amount:=Amount;

            ObjEmployeeTrans.Modify(true);
          end else
            begin
              if ObjMembersReg.Get(MemberNo) then
                Amount:=ObjMembersReg."Monthly Contribution";
              if Amount=0 then
                Amount:=GenSetUp."Min. Contribution";
              ObjEmployeeTrans.Init;
              ObjEmployeeTrans."Transaction Code":=TransCode;
              ObjEmployeeTrans.Validate("Transaction Code");
              ObjEmployeeTrans."Sacco Membership No.":=MemberNo;
              ObjEmployeeTrans."Member No":=MemberNo;
              ObjEmployeeTrans.Membership:=MemberNo;
              ObjEmployeeTrans."Payroll Period":=Period;
              ObjEmployeeTrans."No.":=EmployeeNo;
              ObjEmployeeTrans.Amount:=Amount;
              if Amount<>0 then
              ObjEmployeeTrans.Insert(true);
            end;
    end;

    local procedure KnUpdateShareCapitalContributions(MemberNo: Code[10];TransCode: Code[20];EmployeeNo: Code[20];Period: Date)
    var
        ObjEmployeeTrans: Record "Payroll Employee Transactions.";
        ObjMembersReg: Record "Member Register";
        Amount: Decimal;
    begin
        ObjEmployeeTrans.Reset;
        ObjEmployeeTrans.SetRange(ObjEmployeeTrans."Sacco Membership No.",MemberNo);
        ObjEmployeeTrans.SetRange(ObjEmployeeTrans."Transaction Code",TransCode);
        ObjEmployeeTrans.SetRange(ObjEmployeeTrans."No.",EmployeeNo);
        ObjEmployeeTrans.SetRange(ObjEmployeeTrans."Payroll Period",Period);
        if ObjEmployeeTrans.Find('-') then
          begin
        //    IF ObjMembersReg.GET(ObjEmployeeTrans."Sacco Membership No.") THEN
        //      Amount:=ObjMembersReg."Monthly Insurance";
            if Amount=0 then
              Amount:=GenSetUp."Welfare Contribution";

            if Amount=ObjEmployeeTrans.Amount then
              ObjEmployeeTrans.Amount:=ObjEmployeeTrans.Amount
            else
              ObjEmployeeTrans.Amount:=Amount;

            ObjEmployeeTrans.Modify(true);
          end else
            begin
        //      IF ObjMembersReg.GET(MemberNo) THEN
        //        Amount:=ObjMembersReg."Monthly Share Cap";
              if Amount=0 then
                Amount:=GenSetUp."Shares Contribution";
              ObjEmployeeTrans.Init;
              ObjEmployeeTrans."Transaction Code":=TransCode;
              ObjEmployeeTrans.Validate("Transaction Code");
              ObjEmployeeTrans."No.":=EmployeeNo;
              ObjEmployeeTrans."Sacco Membership No.":=MemberNo;
              ObjEmployeeTrans."Member No":=MemberNo;
              ObjEmployeeTrans.Membership:=MemberNo;
              ObjEmployeeTrans."Payroll Period":=Period;
              ObjEmployeeTrans.Amount:=Amount;
              if Amount<>0 then
              ObjEmployeeTrans.Insert(true);
            end;
    end;

    local procedure KnUpdateDemandSavingsContributions(MemberNo: Code[10];TransCode: Code[20];EmployeeNo: Code[20];Period: Date)
    var
        ObjEmployeeTrans: Record "Payroll Employee Transactions.";
        ObjMembersReg: Record "Member Register";
        Amount: Decimal;
    begin
        ObjEmployeeTrans.Reset;
        ObjEmployeeTrans.SetRange(ObjEmployeeTrans."Sacco Membership No.",MemberNo);
        ObjEmployeeTrans.SetRange(ObjEmployeeTrans."Transaction Code",TransCode);
        ObjEmployeeTrans.SetRange(ObjEmployeeTrans."No.",EmployeeNo);
        ObjEmployeeTrans.SetRange(ObjEmployeeTrans."Payroll Period",Period);
        if ObjEmployeeTrans.Find('-') then
          begin
        //    IF ObjMembersReg.GET(ObjEmployeeTrans."Sacco Membership No.") THEN
        //      Amount:=ObjMembersReg."Jiokoe Savings";
            //IF Amount=0 THEN
              //Amount:=GenSetUp."Min. Contribution";

            if Amount=ObjEmployeeTrans.Amount then
              ObjEmployeeTrans.Amount:=ObjEmployeeTrans.Amount
            else
              ObjEmployeeTrans.Amount:=Amount;
            ObjEmployeeTrans.Modify(true);
          end else
           begin
        //      IF ObjMembersReg.GET(MemberNo) THEN
        //      Amount:=ObjMembersReg."Demand Savings Monthly Cont.";
        //    IF Amount=0 THEN
        //      Amount:=GenSetUp."Min. Contribution";
        //    IF (ObjMembersReg."Demand Savings Status"=ObjMembersReg."Demand Savings Status"::Active) THEN BEGIN
        //    ObjEmployeeTrans.INIT;
        //    ObjEmployeeTrans."Transaction Code":=TransCode;
        //    ObjEmployeeTrans.VALIDATE("Transaction Code");
        //    ObjEmployeeTrans."No.":=EmployeeNo;
        //    ObjEmployeeTrans."Sacco Membership No.":=MemberNo;
        //    ObjEmployeeTrans."Member No":=MemberNo;
        //    ObjEmployeeTrans.Membership:=MemberNo;
        //    ObjEmployeeTrans."Payroll Period":=Period;
        //    ObjEmployeeTrans.Amount:=Amount;
        //    IF Amount<>0 THEN
        //    ObjEmployeeTrans.INSERT(TRUE);
        //    END
            end;
    end;

    local procedure KnCheckIfLoanProductExist(MemberNo: Code[10];TransCode: Code[20];EmployeeNo: Code[20];Period: Date): Boolean
    var
        ObjEmployeeTrans: Record "Payroll Employee Transactions.";
        ObjLoansReg: Record "Loans Register";
    begin
        ObjEmployeeTrans.Reset;
        ObjEmployeeTrans.SetRange(ObjEmployeeTrans."Transaction Code",TransCode);
        ObjEmployeeTrans.SetRange(ObjEmployeeTrans."No.",EmployeeNo);
        ObjEmployeeTrans.SetRange(ObjEmployeeTrans."Payroll Period",Period);
        ObjEmployeeTrans.SetRange(ObjEmployeeTrans."Sacco Membership No.",MemberNo);
        if ObjEmployeeTrans.Find('-') then
          exit(true)
        else
          exit(false);
    end;

    local procedure knFindLastOpenPeriod(): Date
    var
        ObjPayrollCallender: Record "Payroll Calender.";
    begin
        ObjPayrollCallender.Reset;
        ObjPayrollCallender.SetRange(ObjPayrollCallender.Closed,false);
        if ObjPayrollCallender.FindLast then
          exit(ObjPayrollCallender."Date Opened");
    end;
}

