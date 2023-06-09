#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516928 "Loan Auctioneer Notice"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Loan Auctioneer Notice.rdlc';

    dataset
    {
        dataitem("Default Notices Register"; "Default Notices Register")
        {
            column(ReportForNavId_1102755000; 1102755000)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(CompanyName; CompanyInformation.Name)
            {
            }
            column(CompanyAddress; CompanyInformation.Address)
            {
            }
            column(Address2; CompanyInformation."Address 2")
            {
            }
            column(PostCode; CompanyInformation."Post Code")
            {
            }
            column(City; CompanyInformation.City)
            {
            }
            column(Country; CompanyInformation."Country/Region Code")
            {
            }
            column(CompanyPhoneNo; CompanyInformation."Phone No.")
            {
            }
            column(CompanyFaxNo; CompanyInformation."Fax No.")
            {
            }
            column(E_mail; CompanyInformation."E-Mail")
            {
            }
            column(CPic; CompanyInformation.Picture)
            {
            }
            column(DocumentNo_DefaultNoticesRegister; "Default Notices Register"."Document No")
            {
            }
            column(MemberNo_DefaultNoticesRegister; "Default Notices Register"."Member No")
            {
            }
            column(MemberName_DefaultNoticesRegister; "Default Notices Register"."Member Name")
            {
            }
            column(LoanInDefault_DefaultNoticesRegister; "Default Notices Register"."Loan In Default")
            {
            }
            column(LoanProduct_DefaultNoticesRegister; "Default Notices Register"."Loan Product")
            {
            }
            column(LoanInstalments_DefaultNoticesRegister; "Default Notices Register"."Loan Instalments")
            {
            }
            column(LoanDisbursementDate_DefaultNoticesRegister; Format("Default Notices Register"."Loan Disbursement Date"))
            {
            }
            column(ExpectedCompletionDate_DefaultNoticesRegister; "Default Notices Register"."Expected Completion Date")
            {
            }
            column(AmountInArrears_DefaultNoticesRegister; "Default Notices Register"."Amount In Arrears")
            {
            }
            column(LoanOutstandingBalance_DefaultNoticesRegister; "Default Notices Register"."Loan Outstanding Balance")
            {
            }
            column(NoticeType_DefaultNoticesRegister; "Default Notices Register"."Notice Type")
            {
            }
            column(DemandNoticeDate_DefaultNoticesRegister; "Default Notices Register"."Demand Notice Date")
            {
            }
            column(UserID_DefaultNoticesRegister; "Default Notices Register"."User ID")
            {
            }
            column(NoSeries_DefaultNoticesRegister; "Default Notices Register"."No. Series")
            {
            }
            column(EmailSent_DefaultNoticesRegister; "Default Notices Register"."Email Sent")
            {
            }
            column(SMSSent_DefaultNoticesRegister; "Default Notices Register"."SMS Sent")
            {
            }
            column(AuctioneerNo_DefaultNoticesRegister; "Default Notices Register"."Auctioneer No")
            {
            }
            column(AuctioneerName_DefaultNoticesRegister; "Default Notices Register"."Auctioneer  Name")
            {
            }
            column(AuctioneerAddress_DefaultNoticesRegister; "Default Notices Register"."Auctioneer Address")
            {
            }
            column(AuctioneerMobileNo_DefaultNoticesRegister; "Default Notices Register"."Auctioneer Mobile No")
            {
            }
            column(MemberIDNo_DefaultNoticesRegister; "Default Notices Register"."Member ID No")
            {
            }
            column(MemberMobilePhoneNo_DefaultNoticesRegister; "Default Notices Register"."Member Mobile Phone No")
            {
            }
            column(LoanIssued_DefaultNoticesRegister; "Default Notices Register"."Loan Issued")
            {
            }
            column(VarProductName; VarProductName)
            {
            }

            trigger OnAfterGetRecord()
            begin

                if ObjLoanType.Get("Loan Product") then begin
                    VarProductName := ObjLoanType."Product Description";
                end;


                VarGuarantorSecurity := false;

                ObjGuarantor.Reset;
                ObjGuarantor.SetRange(ObjGuarantor."Loan No", "Loan In Default");
                ObjGuarantor.SetFilter(ObjGuarantor.Name, '<>%1', '');
                if ObjGuarantor.FindSet then begin
                    VarGuarantorSecurity := true;
                end;

                ObjCollateral.Reset;
                ObjCollateral.SetRange(ObjCollateral."Loan No", "Loan In Default");
                ObjCollateral.SetFilter(ObjCollateral."Security Details", '<>%1', '');
                if ObjCollateral.FindSet then begin
                    VarCollateralSecurity := ObjCollateral."Security Details";
                end;



                if (VarGuarantorSecurity = false) and (VarCollateralSecurity <> '') then begin
                    VarSecurityUsed := VarCollateralSecurity
                end else
                    if (VarGuarantorSecurity = false) and (VarCollateralSecurity <> '') then begin
                        VarSecurityUsed := 'GUARANTORS';
                    end;
                //=================Get Amount in Arrears=====================================
                VarAmountinArrears := ObjSurestepFactory.FnGetLoanAmountinArrears("Loan In Default");
                //=================End Get Amount in Arrears=====================================

                //==============Get Penalty Percentage===========================================
                if ObjLoanType.Get("Loan Product") then begin
                    VarPenaltyPercentage := ObjLoanType."Penalty Percentage";
                end;
                //==============End Get Penalty Percentage=======================================
            end;

            trigger OnPreDataItem()
            begin
                SenderName := 'Mrs E. MIUNDO';

                CompanyInformation.Get();
                CompanyInformation.CalcFields(CompanyInformation.Picture);
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
        intcount: Integer;
        Balance: Decimal;
        SenderName: Text[150];
        DearM: Text[60];
        BalanceType: Text[100];
        SharesB: Decimal;
        LastPDate: Date;
        Notified: Boolean;
        LoansR: Record "Loans Register";
        SharesAlllocated: Decimal;
        ABFAllocated: Decimal;
        LBalance: Decimal;
        PersonalNo: Code[50];
        GAddress: Text[250];
        Cust: Record "Member Register";
        TotalRec: Decimal;
        NoGuarantors: Integer;
        AmountT: Decimal;
        LoanGuar: Record "Loans Guarantee Details";
        TGrAmount: Decimal;
        GrAmount: Decimal;
        FGrAmount: Decimal;
        Lbal: Decimal;
        INTBAL: Decimal;
        COMM: Decimal;
        GenSetUp: Record "Sacco General Set-Up";
        Amount2: Decimal;
        LBalance1: Decimal;
        SendSMS: Boolean;
        SMSMessage: Record "SMS Messages";
        iEntryNo: Integer;
        Cust1: Record "Member Register";
        CompanyInformation: Record "Company Information";
        ObjCollateral: Record "Loan Collateral Details";
        ObjGuarantor: Record "Loans Guarantee Details";
        VarGuarantorSecurity: Boolean;
        VarCollateralSecurity: Code[50];
        VarSecurityUsed: Code[50];
        VarAmountinArrears: Decimal;
        ObjSurestepFactory: Codeunit "SURESTEP Factory";
        ObjLoanType: Record "Loan Products Setup";
        VarPenaltyPercentage: Decimal;
        VarProductName: Text[50];
}

