#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516933 "Loan Arrears Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Loan Arrears Report.rdlc';

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            PrintOnlyIfDetail = false;
            RequestFilterFields = "Loan  No.", "Loan Product Type", "Client Code", "Loan Disbursement Date";
            column(ReportForNavId_4645; 4645)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(Company_Name; Company.Name)
            {
            }
            column(Company_Address; Company.Address)
            {
            }
            column(Company_Address_2; Company."Address 2")
            {
            }
            column(Company_Phone_No; Company."Phone No.")
            {
            }
            column(Company_Fax_No; Company."Fax No.")
            {
            }
            column(Company_Picture; Company.Picture)
            {
            }
            column(Company_Email; Company."E-Mail")
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(USERID; UserId)
            {
            }
            column(VarCount; VarCount)
            {
            }
            column(VarAmountinArrears; VarAmountinArrears)
            {
            }
            column(RepaymentStartDate_LoansRegister; "Loans Register"."Repayment Start Date")
            {
            }
            column(OutstandingBalance_LoansRegister; "Loans Register"."Outstanding Balance")
            {
            }
            column(LoanNo_LoansRegister; "Loans Register"."Loan  No.")
            {
            }
            column(ApplicationDate_LoansRegister; "Loans Register"."Application Date")
            {
            }
            column(LoanProductType_LoansRegister; "Loans Register"."Loan Product Type")
            {
            }
            column(ClientCode_LoansRegister; "Loans Register"."Client Code")
            {
            }
            column(RequestedAmount_LoansRegister; "Loans Register"."Requested Amount")
            {
            }
            column(ApprovedAmount_LoansRegister; "Loans Register"."Approved Amount")
            {
            }
            column(ClientName_LoansRegister; "Loans Register"."Client Name")
            {
            }
            column(IssuedDate_LoansRegister; Format("Loans Register"."Issued Date"))
            {
            }
            column(Installments_LoansRegister; "Loans Register".Installments)
            {
            }
            column(LoanDisbursementDate_LoansRegister; "Loans Register"."Loan Disbursement Date")
            {
            }

            trigger OnAfterGetRecord()
            begin
                VarAmountinArrears := 0;
                VarCount := VarCount + 1;

                //Get Arrears
                ObjRepaymentSchedule.Reset;
                ObjRepaymentSchedule.SetRange(ObjRepaymentSchedule."Loan No.", "Loan  No.");
                if ObjRepaymentSchedule.FindSet = true then begin
                    if ("Outstanding Balance" > 0) and (Repayment <> 0) then begin
                        VarAmountinArrears := SFactory.FnGetLoanAmountinArrears("Loan  No.");
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

    trigger OnInitReport()
    begin
        Company.Get();
        Company.CalcFields(Company.Picture);
    end;

    var
        Company: Record "Company Information";
        SFactory: Codeunit "SURESTEP Factory";
        VarAmountinArrears: Decimal;
        ObjRepaymentSchedule: Record "Loan Repayment Schedule";
        VarCount: Integer;
}

