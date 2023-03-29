#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516605 "Variance Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Variance Report.rdlc';

    dataset
    {
        dataitem(Checkoff;"Checkoff Lines-Distributed")
        {
            RequestFilterFields = "Member No.";
            column(ReportForNavId_5; 5)
            {
            }
            column(SpecialCode_Checkoff;Checkoff.Reference)
            {
            }
            column(TransactionType_Checkoff;Checkoff."Transaction Type")
            {
            }
            column(EmployerCode_Checkoff;Checkoff."Employer Code")
            {
            }
            column(Variance;Variance)
            {
            }
            column(StaffPayrollNo_Checkoff;Checkoff."Staff/Payroll No")
            {
            }
            column(Name_Checkoff;Checkoff.Name)
            {
            }
            column(Amount_Checkoff;Checkoff.Amount)
            {
            }
            column(MemberNo_Checkoff;Checkoff."Member No.")
            {
            }
            column(CompName;Company.Name)
            {
            }
            column(CompAddress;Company.Address)
            {
            }
            column(CompCity;Company.City)
            {
            }
            column(CompPicture;Company.Picture)
            {
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

    var
        Company: Record "Company Information";
        Variance: Decimal;
        AdvicedAmount: Decimal;
        Sheet: Record "Data Sheet Lines-Dist";
}

