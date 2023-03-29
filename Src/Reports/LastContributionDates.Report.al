#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516929 "Last Contribution Dates"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Last Contribution Dates.rdlc';

    dataset
    {
        dataitem("Member Register";"Member Register")
        {
            RequestFilterFields = "No.","Member House Group","Member House Group Name";
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
            column(LastContributionAmount_MembersRegister;"Member Register"."Last Contribution Entry No")
            {
            }
            column(LastDepositContributionDate_MembersRegister;Format("Member Register"."Last Deposit Contribution Date"))
            {
            }
            column(MemberCellGroup_MembersRegister;"Member Register"."Member House Group")
            {
            }
            column(MemberCellGroupName_MembersRegister;"Member Register"."Member House Group Name")
            {
            }
            column(IDNo_MembersRegister;"Member Register"."ID No.")
            {
            }
            column(MobilePhoneNo_MembersRegister;"Member Register"."Mobile Phone No")
            {
            }
            column(No_MembersRegister;"Member Register"."No.")
            {
            }
            column(Name_MembersRegister;"Member Register".Name)
            {
            }
            column(VarCount;VarCount)
            {
            }
            column(VarLastContributionAmount;VarLastContributionAmount)
            {
            }
            column(VarLastTransDate;Format(VarLastTransDate))
            {
            }
            column(CurrentShares_MembersRegister;"Member Register"."Current Shares")
            {
            }

            trigger OnAfterGetRecord()
            begin
                VarCount:=VarCount+1;
                CalcFields("Last Contribution Entry No");

                ObjMemberLedger.Reset;
                ObjMemberLedger.SetRange(ObjMemberLedger."Entry No.","Last Contribution Entry No");
                if ObjMemberLedger.FindSet then begin
                  VarLastContributionAmount:=ObjMemberLedger."Credit Amount";
                  VarLastTransDate:=ObjMemberLedger."Posting Date";
                  end;
            end;

            trigger OnPreDataItem()
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
        Loans_Aging_Analysis__SASRA_CaptionLbl: label 'Loans Aging Analysis (SASRA)';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Loan_TypeCaptionLbl: label 'Loan Type';
        Staff_No_CaptionLbl: label 'Staff No.';
        Oustanding_BalanceCaptionLbl: label 'Oustanding Balance';
        PerformingCaptionLbl: label 'Performing';
        V1___30_Days_CaptionLbl: label '(1 - 30 Days)';
        V0_Days_CaptionLbl: label '(0 Days)';
        WatchCaptionLbl: label 'Watch';
        V31___180_Days_CaptionLbl: label '(31 - 180 Days)';
        SubstandardCaptionLbl: label 'Substandard';
        V181___360_Days_CaptionLbl: label '(181 - 360 Days)';
        DoubtfulCaptionLbl: label 'Doubtful';
        Over_360_DaysCaptionLbl: label 'Over 360 Days';
        LossCaptionLbl: label 'Loss';
        TotalsCaptionLbl: label 'Totals';
        CountCaptionLbl: label 'Count';
        Grand_TotalCaptionLbl: label 'Grand Total';
        Company: Record "Company Information";
        ObjMemberLedger: Record "Member Ledger Entry";
        VarCount: Integer;
        VarLastContributionAmount: Decimal;
        VarLastTransDate: Date;
}

