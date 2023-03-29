#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516506 "Member Dependants Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Member Dependants Report.rdlc';

    dataset
    {
        dataitem("Company Information";"Company Information")
        {
            column(ReportForNavId_7; 7)
            {
            }
            column(Name_CompanyInformation;"Company Information".Name)
            {
            }
            column(Picture_CompanyInformation;"Company Information".Picture)
            {
            }
        }
        dataitem("Members Nominee";"Members Nominee")
        {
            RequestFilterFields = "Account No";
            column(ReportForNavId_1; 1)
            {
            }
            column(Name_MembersNominee;"Members Nominee".Name)
            {
            }
            column(AccountNo_MembersNominee;"Members Nominee"."Account No")
            {
            }
            column(Relationship_MembersNominee;"Members Nominee".Relationship)
            {
            }
            column(Beneficiary_MembersNominee;"Members Nominee".Beneficiary)
            {
            }
            column(DateofBirth_MembersNominee;"Members Nominee"."Date of Birth")
            {
            }
            column(Address_MembersNominee;"Members Nominee".Address)
            {
            }
            column(IDNo_MembersNominee;"Members Nominee"."ID No.")
            {
            }
            column(Allocation_MembersNominee;"Members Nominee"."%Allocation")
            {
            }
            column(TotalAllocation_MembersNominee;"Members Nominee"."Total Allocation")
            {
            }
            column(EntryNo_MembersNominee;"Members Nominee"."Entry No")
            {
            }
            column(Description_MembersNominee;"Members Nominee".Description)
            {
            }
            column(NextOfKinType_MembersNominee;"Members Nominee"."Next Of Kin Type")
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

