#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516898 "Change Request Report(Mobile)"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Change Request Report(Mobile).rdlc';

    dataset
    {
        dataitem("Change Request";"Change Request")
        {
            DataItemTableView = where(Type=filter("Mobile Change"));
            PrintOnlyIfDetail = false;
            RequestFilterFields = No,Type,"Account No";
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
            column(EntryNo;EntryNo)
            {
            }
            column(No_ChangeRequest;"Change Request".No)
            {
            }
            column(Type_ChangeRequest;"Change Request".Type)
            {
            }
            column(AccountNo_ChangeRequest;"Change Request"."Account No")
            {
            }
            column(MobileNo_ChangeRequest;"Change Request"."Mobile No")
            {
            }
            column(PrevousMobileNo;PrevousMobileNo)
            {
            }
            column(Name_ChangeRequest;"Change Request".Name)
            {
            }
            column(NoSeries_ChangeRequest;"Change Request"."No. Series")
            {
            }
            column(Address_ChangeRequest;"Change Request".Address)
            {
            }
            column(Branch_ChangeRequest;"Change Request".Branch)
            {
            }
            column(City_ChangeRequest;"Change Request".City)
            {
            }
            column(Email_ChangeRequest;"Change Request"."E-mail")
            {
            }
            column(PersonalNo_ChangeRequest;"Change Request"."Personal No")
            {
            }
            column(IDNo_ChangeRequest;"Change Request"."ID No")
            {
            }
            column(MaritalStatus_ChangeRequest;"Change Request"."Marital Status")
            {
            }
            column(PassportNo_ChangeRequest;"Change Request"."Passport No.")
            {
            }
            column(Status_ChangeRequest;"Change Request".Status)
            {
            }
            column(AccountType_ChangeRequest;"Change Request"."Account Type")
            {
            }
            column(AccountCategory_ChangeRequest;"Change Request"."Account Category")
            {
            }
            column(Section_ChangeRequest;"Change Request".Section)
            {
            }
            column(CardNo_ChangeRequest;"Change Request"."Card No")
            {
            }
            column(HomeAddress_ChangeRequest;"Change Request"."Home Address")
            {
            }
            column(Loaction_ChangeRequest;"Change Request".Loaction)
            {
            }
            column(SubLocation_ChangeRequest;"Change Request"."Sub-Location")
            {
            }
            column(District_ChangeRequest;"Change Request".District)
            {
            }
            column(Reasonforchange_ChangeRequest;"Change Request"."Reason for change")
            {
            }
            column(SigningInstructions_ChangeRequest;"Change Request"."Signing Instructions")
            {
            }
            column(SMobileNo_ChangeRequest;"Change Request"."S-Mobile No")
            {
            }
            column(ATMApprove_ChangeRequest;"Change Request"."ATM Approve")
            {
            }
            column(CardExpiryDate_ChangeRequest;"Change Request"."Card Expiry Date")
            {
            }
            column(CardValidFrom_ChangeRequest;"Change Request"."Card Valid From")
            {
            }
            column(CardValidTo_ChangeRequest;"Change Request"."Card Valid To")
            {
            }
            column(DateATMLinked_ChangeRequest;"Change Request"."Date ATM Linked")
            {
            }
            column(ATMNo_ChangeRequest;"Change Request"."ATM No.")
            {
            }
            column(ATMIssued_ChangeRequest;"Change Request"."ATM Issued")
            {
            }
            column(ATMSelfPicked_ChangeRequest;"Change Request"."ATM Self Picked")
            {
            }
            column(ATMCollectorName_ChangeRequest;"Change Request"."ATM Collector Name")
            {
            }
            column(ATMCollectorsID_ChangeRequest;"Change Request"."ATM Collectors ID")
            {
            }
            column(AtmCollectorsMoile_ChangeRequest;"Change Request"."Atm Collectors Moile")
            {
            }
            column(MemberType_ChangeRequest;"Change Request"."Member Type")
            {
            }
            column(MonthlyContributions_ChangeRequest;"Change Request"."Monthly Contributions")
            {
            }
            column(Capturedby_ChangeRequest;"Change Request"."Captured by")
            {
            }
            column(CaptureDate_ChangeRequest;Format("Change Request"."Capture Date"))
            {
            }
            column(Approvedby_ChangeRequest;Format("Change Request"."Approved by"))
            {
            }
            column(ApprovalDate_ChangeRequest;"Change Request"."Approval Date")
            {
            }
            column(Changed_ChangeRequest;"Change Request".Changed)
            {
            }
            column(ResponsibilityCenters_ChangeRequest;"Change Request"."Responsibility Centers")
            {
            }
            column(MemberCellGroup_ChangeRequest;"Change Request"."Member Cell Group")
            {
            }
            column(MemberCellName_ChangeRequest;"Change Request"."Member Cell Name")
            {
            }
            column(GroupAccountNo_ChangeRequest;"Change Request"."Group Account No")
            {
            }
            column(GroupAccountName_ChangeRequest;"Change Request"."Group Account Name")
            {
            }
            column(MemberAccountStatus_ChangeRequest;"Change Request"."Member Account Status")
            {
            }
            column(MobileNoNewValue_ChangeRequest;"Change Request"."Mobile No(New Value)")
            {
            }
            column(NameNewValue_ChangeRequest;"Change Request"."Name(New Value)")
            {
            }
            column(NoSeriesNewValue_ChangeRequest;"Change Request"."No. Series(New Value)")
            {
            }
            column(AddressNewValue_ChangeRequest;"Change Request"."Address(New Value)")
            {
            }
            column(BranchNewValue_ChangeRequest;"Change Request"."Branch(New Value)")
            {
            }
            column(PictureNewValue_ChangeRequest;"Change Request"."Picture(New Value)")
            {
            }
            column(signinatureNewValue_ChangeRequest;"Change Request"."signinature(New Value)")
            {
            }
            column(CityNewValue_ChangeRequest;"Change Request"."City(New Value)")
            {
            }
            column(EmailNewValue_ChangeRequest;"Change Request"."E-mail(New Value)")
            {
            }
            column(PersonalNoNewValue_ChangeRequest;"Change Request"."Personal No(New Value)")
            {
            }
            column(IDNoNewValue_ChangeRequest;"Change Request"."ID No(New Value)")
            {
            }
            column(MaritalStatusNewValue_ChangeRequest;"Change Request"."Marital Status(New Value)")
            {
            }
            column(PassportNoNewValue_ChangeRequest;"Change Request"."Passport No.(New Value)")
            {
            }
            column(StatusNewValue_ChangeRequest;"Change Request"."Status(New Value)")
            {
            }
            column(AccountTypeNewValue_ChangeRequest;"Change Request"."Account Type(New Value)")
            {
            }
            column(AccountCategoryNewValue_ChangeRequest;"Change Request"."Account Category(New Value)")
            {
            }
            column(SectionNewValue_ChangeRequest;"Change Request"."Section(New Value)")
            {
            }
            column(CardNoNewValue_ChangeRequest;"Change Request"."Card No(New Value)")
            {
            }
            column(HomeAddressNewValue_ChangeRequest;"Change Request"."Home Address(New Value)")
            {
            }
            column(LoactionNewValue_ChangeRequest;"Change Request"."Loaction(New Value)")
            {
            }
            column(SubLocationNewValue_ChangeRequest;"Change Request"."Sub-Location(New Value)")
            {
            }
            column(DistrictNewValue_ChangeRequest;"Change Request"."District(New Value)")
            {
            }
            column(SigningInstructionsNewValue_ChangeRequest;"Change Request"."Signing Instructions(NewValue)")
            {
            }
            column(SMobileNoNewValue_ChangeRequest;"Change Request"."S-Mobile No(New Value)")
            {
            }
            column(ATMNoNewValue_ChangeRequest;"Change Request"."ATM No.(New Value)")
            {
            }
            column(MonthlyContributionsNewValu_ChangeRequest;"Change Request"."Monthly Contributions(NewValu)")
            {
            }
            column(MemberAccountStatusNewValu_ChangeRequest;"Change Request"."Member Account Status(NewValu)")
            {
            }

            trigger OnAfterGetRecord()
            begin
                EntryNo:=EntryNo+1;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
            }
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

    trigger OnPreReport()
    begin
                if "COMPY INFOR".Get then
                begin
        "COMPY INFOR".CalcFields("COMPY INFOR".Picture);
                Name:="COMPY INFOR".Name;
                end;
    end;

    var
        RPeriod: Decimal;
        BatchL: Code[100];
        Batches: Record "Loan Disburesment-Batching";
        ApprovalSetup: Record "Table Permission Buffer";
        LocationFilter: Code[20];
        TotalApproved: Decimal;
        cust: Record "Member Register";
        BOSABal: Decimal;
        SuperBal: Decimal;
        LAppl: Record "Loans Register";
        Deposits: Decimal;
        CompanyCode: Code[20];
        LoanType: Text[50];
        LoanProdType: Record "Loan Products Setup";
        LCount: Integer;
        RFilters: Text[250];
        DValue: Record "Dimension Value";
        VALREPAY: Record "Member Ledger Entry";
        Loans_RegisterCaptionLbl: label 'Approved Loans Report';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Loan_TypeCaptionLbl: label 'Loan Type';
        Client_No_CaptionLbl: label 'Client No.';
        Outstanding_LoanCaptionLbl: label 'Outstanding Loan';
        PeriodCaptionLbl: label 'Period';
        Approved_DateCaptionLbl: label 'Approved Date';
        Loan_TypeCaption_Control1102760043Lbl: label 'Loan Type';
        Verified_By__________________________________________________CaptionLbl: label 'Verified By..................';
        Confirmed_By__________________________________________________CaptionLbl: label 'Confirmed By..................';
        Sign________________________CaptionLbl: label 'Sign...............';
        Sign________________________Caption_Control1102755003Lbl: label 'Sign...............';
        Date________________________CaptionLbl: label 'Date..............';
        Date________________________Caption_Control1102755005Lbl: label 'Date..............';
        GenSetUp: Record "Sacco General Set-Up";
        LoanApp: Record "Loans Register";
        CustRec: Record "Member Register";
        CustRecord: Record "Member Register";
        TShares: Decimal;
        TLoans: Decimal;
        LoanShareRatio: Decimal;
        Eligibility: Decimal;
        TotalSec: Decimal;
        saccded: Decimal;
        saccded2: Decimal;
        grosspay: Decimal;
        Tdeduct: Decimal;
        Cshares: Decimal;
        "Cshares*3": Decimal;
        "Cshares*4": Decimal;
        QUALIFY_SHARES: Decimal;
        salary: Decimal;
        LoanG: Record "Loans Guarantee Details";
        GShares: Decimal;
        Recomm: Decimal;
        GShares1: Decimal;
        NETTAKEHOME: Decimal;
        Msalary: Decimal;
        RecPeriod: Integer;
        FOSARecomm: Decimal;
        FOSARecoPRD: Integer;
        "Asset Value": Decimal;
        InterestRate: Decimal;
        RepayPeriod: Decimal;
        LBalance: Decimal;
        TotalMRepay: Decimal;
        LInterest: Decimal;
        LPrincipal: Decimal;
        SecuredSal: Decimal;
        Linterest1: Integer;
        LOANBALANCE: Decimal;
        BRIDGEDLOANS: Record "Loan Offset Details";
        BRIDGEBAL: Decimal;
        LOANBALANCEFOSASEC: Decimal;
        TotalTopUp: Decimal;
        TotalIntPayable: Decimal;
        GTotals: Decimal;
        TempVal: Decimal;
        TempVal2: Decimal;
        "TempCshares*4": Decimal;
        "TempCshares*3": Decimal;
        InstallP: Decimal;
        RecomRemark: Text[150];
        InstallRecom: Decimal;
        TopUpComm: Decimal;
        TotalTopupComm: Decimal;
        LoanTopUp: Record "Loan Offset Details";
        "Interest Payable": Decimal;
        "general set-up": Record "Sacco General Set-Up";
        Days: Integer;
        EndMonthInt: Decimal;
        BRIDGEBAL2: Decimal;
        DefaultInfo: Text[80];
        TOTALBRIDGED: Decimal;
        DEpMultiplier: Decimal;
        MAXAvailable: Decimal;
        SalDetails: Record "Loan Appraisal Salary Details";
        Earnings: Decimal;
        Deductions: Decimal;
        BrTopUpCom: Decimal;
        LoanAmount: Decimal;
        Company: Record "Company Information";
        CompanyAddress: Code[20];
        CompanyEmail: Text[30];
        CompanyTel: Code[20];
        CurrentAsset: Decimal;
        CurrentLiability: Decimal;
        FixedAsset: Decimal;
        Equity: Decimal;
        Sales: Decimal;
        SalesOnCredit: Decimal;
        AppraiseDeposits: Boolean;
        AppraiseShares: Boolean;
        AppraiseSalary: Boolean;
        AppraiseGuarantors: Boolean;
        AppraiseBusiness: Boolean;
        TLoan: Decimal;
        LoanBal: Decimal;
        GuaranteedAmount: Decimal;
        RunBal: Decimal;
        TGuaranteedAmount: Decimal;
        GuarantorQualification: Boolean;
        TotalLoanBalance: Decimal;
        TGAmount: Decimal;
        NetSalary: Decimal;
        Riskamount: Decimal;
        WarnBridged: Text;
        WarnSalary: Text;
        WarnDeposits: Text;
        WarnGuarantor: Text;
        WarnShare: Text;
        RiskGshares: Decimal;
        RiskDeposits: Decimal;
        BasicEarnings: Decimal;
        DepX: Decimal;
        LoanPrincipal: Decimal;
        loanInterest: Decimal;
        AmountGuaranteed: Decimal;
        StatDeductions: Decimal;
        GuarOutstanding: Decimal;
        TwoThirds: Decimal;
        Bridged_AmountCaption: Integer;
        LNumber: Code[20];
        TotalLoanDeductions: Decimal;
        TotalRepayments: Decimal;
        Totalinterest: Decimal;
        Band: Decimal;
        TotalOutstanding: Decimal;
        BANDING: Record "Deposit Tier Setup";
        NtTakeHome: Decimal;
        ATHIRD: Decimal;
        Psalary: Decimal;
        LoanApss: Record "Loans Register";
        TotalLoanBal: Decimal;
        TotalBand: Decimal;
        LoanAp: Record "Loans Register";
        TotalRepay: Decimal;
        TotalInt: Decimal;
        LastFieldNo: Integer;
        TotLoans: Decimal;
        JazaLevy: Decimal;
        BridgeLevy: Decimal;
        Upfronts: Decimal;
        Netdisbursed: Decimal;
        TotalLRepayments: Decimal;
        BridgedRepayment: Decimal;
        OutstandingLrepay: Decimal;
        Loantop: Record "Loan Offset Details";
        BRIGEDAMOUNT: Decimal;
        TOTALBRIGEDAMOUNT: Decimal;
        FinalInst: Decimal;
        NonRec: Decimal;
        TotalUpfronts: Decimal;
        TotalNetPay: Decimal;
        NameCreditOff: label 'Name.......................';
        NameCreditDate: label 'Date........................';
        NameCreditSign: label 'Signature..................';
        NameCreditMNG: label 'Name.......................';
        NameCreditMNGDate: label 'Date........................';
        NameCreditMNGSign: label 'Signature..................';
        NameCEO: label 'Name......................';
        NameCEOSign: label 'Signature.................';
        NameCEODate: label 'Date.......................';
        CreditCom1: label 'Name......................';
        CreditCom1Sign: label 'Signature.................';
        CreditCom1Date: label 'Date.......................';
        CreditCom2: label 'Name......................';
        CreditCom2Sign: label 'Signature.................';
        CreditCom2Date: label 'Date......................';
        CreditCom3: label 'Name.....................';
        CreditComDate3: label 'Date......................';
        CreditComSign3: label 'Signature.................';
        Comment: label '....................';
        "COMPY INFOR": Record "Company Information";
        Name: Text;
        PICTURE: Text;
        EntryNo: Integer;
        PrevousMobileNo: Code[20];
}

