#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516979 "Loan Collateral Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Loan Collateral Report.rdlc';

    dataset
    {
        dataitem("Member Register";"Member Register")
        {
            RequestFilterFields = "No.";
            column(ReportForNavId_23; 23)
            {
            }
            column(No_MemberRegister;"Member Register"."No.")
            {
            }
            column(Name_MemberRegister;"Member Register".Name)
            {
            }
            column(COMPANYNAME;COMPANYNAME)
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
            dataitem("Loan Collateral Details";"Loan Collateral Details")
            {
                DataItemLink = "Member No"=field("No.");
                column(ReportForNavId_1; 1)
                {
                }
                column(LoanNo_LoanCollateralDetails;"Loan Collateral Details"."Loan No")
                {
                }
                column(Type_LoanCollateralDetails;"Loan Collateral Details".Type)
                {
                }
                column(SecurityDetails_LoanCollateralDetails;"Loan Collateral Details"."Security Details")
                {
                }
                column(Remarks_LoanCollateralDetails;"Loan Collateral Details".Remarks)
                {
                }
                column(LoanType_LoanCollateralDetails;"Loan Collateral Details"."Loan Type")
                {
                }
                column(Value_LoanCollateralDetails;"Loan Collateral Details".Value)
                {
                }
                column(GuaranteeValue_LoanCollateralDetails;"Loan Collateral Details"."Guarantee Value")
                {
                }
                column(Code_LoanCollateralDetails;"Loan Collateral Details".Code)
                {
                }
                column(Category_LoanCollateralDetails;"Loan Collateral Details".Category)
                {
                }
                column(CollateralMultiplier_LoanCollateralDetails;"Loan Collateral Details"."Collateral Multiplier")
                {
                }
                column(ViewDocument_LoanCollateralDetails;"Loan Collateral Details"."View Document")
                {
                }
                column(AssesmentDone_LoanCollateralDetails;"Loan Collateral Details"."Assesment Done")
                {
                }
                column(AccountNo_LoanCollateralDetails;"Loan Collateral Details"."Account No")
                {
                }
                column(MotorVehicleRegistrationNo_LoanCollateralDetails;"Loan Collateral Details"."Motor Vehicle Registration No")
                {
                }
                column(TitleDeedNo_LoanCollateralDetails;"Loan Collateral Details"."Title Deed No.")
                {
                }
                column(ComittedCollateralValue_LoanCollateralDetails;"Loan Collateral Details"."Comitted Collateral Value")
                {
                }
                column(CollateralRegisteDoc_LoanCollateralDetails;"Loan Collateral Details"."Collateral Registe Doc")
                {
                }
                column(DocumentNo_LoanCollateralDetails;"Loan Collateral Details"."Document No")
                {
                }
                column(RegisteredOwner_LoanCollateralDetails;"Loan Collateral Details"."Registered Owner")
                {
                }
                column(ReferenceNo_LoanCollateralDetails;"Loan Collateral Details"."Reference No")
                {
                }
                column(MemberNo_LoanCollateralDetails;"Loan Collateral Details"."Member No")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                Company.Get();
                Company.CalcFields(Company.Picture);
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
        Company: Record "Company Information";
}

