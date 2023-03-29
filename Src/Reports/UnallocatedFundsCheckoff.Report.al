#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516542 "Unallocated Funds Checkoff"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Unallocated Funds Checkoff.rdlc';

    dataset
    {
        dataitem("Checkoff Header-Distributed";"Checkoff Header-Distributed")
        {
            column(ReportForNavId_1102755000; 1102755000)
            {
            }
            column(USERID;UserId)
            {
            }
            column(Company_Name;Company.Name)
            {
            }
            column(Company_Address;Company.Address)
            {
            }
            column(Company_Address_2;Company."Address 2")
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
            column(Amount_CheckoffHeaderDistributed;"Checkoff Header-Distributed".Amount)
            {
            }
            column(No_CheckoffHeaderDistributed;"Checkoff Header-Distributed".No)
            {
            }
            column(Remarks_CheckoffHeaderDistributed;"Checkoff Header-Distributed".Remarks)
            {
            }
            column(Postingdate_CheckoffHeaderDistributed;"Checkoff Header-Distributed"."Posting date")
            {
            }
            column(DocumentNo_CheckoffHeaderDistributed;"Checkoff Header-Distributed"."Document No")
            {
            }
            dataitem(ChecKoffLines;"Checkoff Lines-Distributed")
            {
                DataItemLink = "Receipt Header No"=field(No);
                DataItemTableView = sorting("Receipt Header No","Entry No") where(Reference=filter('SLOAN'|'SINTEREST'),"Loan No."=filter(''));
                column(ReportForNavId_1102755031; 1102755031)
                {
                }
                column(MemberNo_ChecKoffLines;ChecKoffLines."Member No.")
                {
                }
                column(Reference_ChecKoffLines;ChecKoffLines.Reference)
                {
                }
                column(LoanType_ChecKoffLines;ChecKoffLines."Loan Type")
                {
                }
                column(LoanNo_ChecKoffLines;ChecKoffLines."Loan No.")
                {
                }
                column(StaffPayrollNo_ChecKoffLines;ChecKoffLines."Staff/Payroll No")
                {
                }
                column(Name_ChecKoffLines;ChecKoffLines.Name)
                {
                }
                column(Amount_ChecKoffLines;ChecKoffLines.Amount)
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
         Company.Get();
         Company.CalcFields(Company.Picture);
    end;

    var
        OpenBalance: Decimal;
        CLosingBalance: Decimal;
        OpenBalanceXmas: Decimal;
        CLosingBalanceXmas: Decimal;
        Cust: Record "Member Register";
        OpeningBal: Decimal;
        ClosingBal: Decimal;
        FirstRec: Boolean;
        PrevBal: Integer;
        BalBF: Decimal;
        LoansR: Record "Loans Register";
        DateFilterBF: Text[150];
        SharesBF: Decimal;
        InsuranceBF: Decimal;
        LoanBF: Decimal;
        PrincipleBF: Decimal;
        InterestBF: Decimal;
        ShowZeroBal: Boolean;
        ClosingBalSHCAP: Decimal;
        ShareCapBF: Decimal;
        RiskBF: Decimal;
        DividendBF: Decimal;
        Company: Record "Company Information";
        OpenBalanceHse: Decimal;
        CLosingBalanceHse: Decimal;
        OpenBalanceDep1: Decimal;
        CLosingBalanceDep1: Decimal;
        OpenBalanceDep2: Decimal;
        CLosingBalanceDep2: Decimal;
        HseBF: Decimal;
        Dep1BF: Decimal;
        Dep2BF: Decimal;
        OpeningBalInt: Decimal;
        ClosingBalInt: Decimal;
        InterestPaid: Decimal;
        SumInterestPaid: Decimal;
        OpenBalanceRisk: Decimal;
        CLosingBalanceRisk: Decimal;
        OpenBalanceDividend: Decimal;
        ClosingBalanceDividend: Decimal;
        OpenBalanceHoliday: Decimal;
        ClosingBalanceHoliday: Decimal;
        LoanSetup: Record "Loan Products Setup";
        LoanName: Text[50];
        SaccoEmp: Record "Sacco Employers";
        EmployerName: Text[100];
}

