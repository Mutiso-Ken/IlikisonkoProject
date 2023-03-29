#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516932 "CRM Cases Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/CRM Cases Report.rdlc';

    dataset
    {
        dataitem("Cases Management";"Cases Management")
        {
            PrintOnlyIfDetail = false;
            RequestFilterFields = "Case Number","Date of Complaint","Type of cases","Caller Reffered To",Status;
            column(ReportForNavId_4645; 4645)
            {
            }
            column(FORMAT_TODAY_0_4_;Format(Today,0,4))
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
            column(CurrReport_PAGENO;CurrReport.PageNo)
            {
            }
            column(USERID;UserId)
            {
            }
            column(VarCount;VarCount)
            {
            }
            column(CallerRefferedTo_CasesManagement;"Cases Management"."Caller Reffered To")
            {
            }
            column(CaseNumber_CasesManagement;"Cases Management"."Case Number")
            {
            }
            column(DateofComplaint_CasesManagement;Format("Cases Management"."Date of Complaint"))
            {
            }
            column(Typeofcases_CasesManagement;"Cases Management"."Type of cases")
            {
            }
            column(RecommendedAction_CasesManagement;"Cases Management"."Recommended Action")
            {
            }
            column(CaseDescription_CasesManagement;"Cases Management"."Case Description")
            {
            }
            column(Status_CasesManagement;"Cases Management".Status)
            {
            }
            column(ModeofLodgingtheComplaint_CasesManagement;"Cases Management"."Mode of Lodging the Complaint")
            {
            }
            column(MemberNo_CasesManagement;"Cases Management"."Member No")
            {
            }
            column(MemberName_CasesManagement;"Cases Management"."Member Name")
            {
            }
            column(Description_CasesManagement;"Cases Management".Description)
            {
            }
            column(IDNo_CasesManagement;"Cases Management"."ID No")
            {
            }
            column(Gender_CasesManagement;"Cases Management".Gender)
            {
            }
            column(DateResolved_CasesManagement;Format("Cases Management"."Date Resolved"))
            {
            }
            column(DateofEscalation_CasesManagement;"Cases Management"."Date of Escalation")
            {
            }

            trigger OnAfterGetRecord()
            begin
                VarCount:=VarCount+1;
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
        ClosingBalPreviousDay: Decimal;
        TotalDeposits: Decimal;
        TotalWithdrawals: Decimal;
        ClosingBalToday: Decimal;
        GLAccountNo: Code[20];
        VendorPostingGroups: Record "Vendor Posting Group";
        StartDate: Date;
        PreviousDay: Date;
        CurrDate: Date;
        GLAccounts: Record "G/L Account";
        CurrDateFilter: Text;
        PrevDateFilter: Text;
        GLEntry: Record "G/L Entry";
        ASAT: Date;
        TransactedAccounts: Integer;
        GLEntries: Record "G/L Entry";
        VarDepositLimit: Decimal;
        VarWithdrawalLimit: Decimal;
        VarCurrAccountBal: Decimal;
        VarAccountName: Code[50];
        VarAccountType: Code[20];
        ObjVendor: Record Vendor;
        VarDepositCriteriaTrue: Boolean;
        VarWithdrawalCriteriaTrue: Boolean;
        ObjVendorLedg: Record "Vendor Ledger Entry";
        VarDepCount: Integer;
        VarWithCount: Integer;
        VarCount: Integer;
}

