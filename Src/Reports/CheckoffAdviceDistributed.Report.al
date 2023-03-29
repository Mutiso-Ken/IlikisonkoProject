#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516620 "Checkoff Advice Distributed"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Checkoff Advice Distributed.rdlc';

    dataset
    {
        dataitem("Data Sheet Lines-Dist";"Data Sheet Lines-Dist")
        {
            DataItemTableView = sorting("Loan Product Type","Transaction Type") order(ascending);
            RequestFilterFields = "Data Sheet Header","Member No";
            column(ReportForNavId_1; 1)
            {
            }
            column(PayrollNo_DataSheetLinesDist;"Data Sheet Lines-Dist"."Payroll No")
            {
            }
            column(MemberNo_DataSheetLinesDist;"Data Sheet Lines-Dist"."Member No")
            {
            }
            column(Name_DataSheetLinesDist;"Data Sheet Lines-Dist".Name)
            {
            }
            column(IDNumber_DataSheetLinesDist;"Data Sheet Lines-Dist"."ID Number")
            {
            }
            column(Amount_DataSheetLinesDist;"Data Sheet Lines-Dist".Amount)
            {
            }
            column(Employer_DataSheetLinesDist;"Data Sheet Lines-Dist".Employer)
            {
            }
            column(OutstandingBalance_DataSheetLinesDist;"Data Sheet Lines-Dist"."Outstanding Balance")
            {
            }
            column(OutstandingInterest_DataSheetLinesDist;"Data Sheet Lines-Dist"."Outstanding Interest")
            {
            }
            column(TransactionType_DataSheetLinesDist;"Data Sheet Lines-Dist"."Transaction Type")
            {
            }
            column(LoanProductType_DataSheetLinesDist;"Data Sheet Lines-Dist"."Loan Product Type")
            {
            }
            column(SpecialCode_DataSheetLinesDist;"Data Sheet Lines-Dist"."Special Code")
            {
            }
            column(Installments_DataSheetLinesDist;"Data Sheet Lines-Dist".Installments)
            {
            }
            column(Deductiontype_DataSheetLinesDist;"Data Sheet Lines-Dist"."Deduction type")
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
}

