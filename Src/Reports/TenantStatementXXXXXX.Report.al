#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516561 "Tenant Statement XXXXXX"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Tenant Statement XXXXXX.rdlc';

    dataset
    {
        dataitem(Vendor;Vendor)
        {
            RequestFilterFields = "No.";
            column(ReportForNavId_97; 97)
            {
            }
            column(No_Vendor;Vendor."No.")
            {
            }
            column(Name_Vendor;Vendor.Name)
            {
            }
            column(SearchName_Vendor;Vendor."Search Name")
            {
            }
            column(Name2_Vendor;Vendor."Name 2")
            {
            }
            column(Address_Vendor;Vendor.Address)
            {
            }
            column(Address2_Vendor;Vendor."Address 2")
            {
            }
            column(City_Vendor;Vendor.City)
            {
            }
            column(Contact_Vendor;Vendor.Contact)
            {
            }
            column(PhoneNo_Vendor;Vendor."Phone No.")
            {
            }
            column(HideMpesa;HideMpesa)
            {
            }
            column(RentalName_Vendor;Vendor."Rental Name")
            {
            }
            dataitem(Transactions;Transactions)
            {
                DataItemLink = "Tenant No"=field("No.");
                RequestFilterFields = "Transaction Type","Tenant No";
                column(ReportForNavId_4645; 4645)
                {
                }
                column(EntryNo;EntryNo)
                {
                }
                column(AccountNo_Transactions;Transactions."Account No")
                {
                }
                column(AccountName_Transactions;Transactions."Account Name")
                {
                }
                column(TransactionType_Transactions;Transactions."Transaction Type")
                {
                }
                column(Amount_Transactions;Transactions.Amount)
                {
                }
                column(Cashier_Transactions;Transactions.Cashier)
                {
                }
                column(TransactionDate_Transactions;Transactions."Transaction Date")
                {
                }
                column(TransactionTime_Transactions;Transactions."Transaction Time")
                {
                }
                column(Posted_Transactions;Transactions.Posted)
                {
                }
                column(NoSeries_Transactions;Transactions."No. Series")
                {
                }
                column(AccountType_Transactions;Transactions."Account Type")
                {
                }
                column(AccountDescription_Transactions;Transactions."Account Description")
                {
                }
                column(DenominationTotal_Transactions;Transactions."Denomination Total")
                {
                }
                column(ChequeType_Transactions;Transactions."Cheque Type")
                {
                }
                column(ChequeNo_Transactions;Transactions."Cheque No")
                {
                }
                column(ChequeDate_Transactions;Transactions."Cheque Date")
                {
                }
                column(Payee_Transactions;Transactions.Payee)
                {
                }
                column(BankNo_Transactions;Transactions."Bank No")
                {
                }
                column(BranchNo_Transactions;Transactions."Branch No")
                {
                }
                column(ClearingCharges_Transactions;Transactions."Clearing Charges")
                {
                }
                column(ClearingDays_Transactions;Transactions."Clearing Days")
                {
                }
                column(Description_Transactions;Transactions.Description)
                {
                }
                column(BankName_Transactions;Transactions."Bank Name")
                {
                }
                column(BranchName_Transactions;Transactions."Branch Name")
                {
                }
                column(TransactionMode_Transactions;Transactions."Transaction Mode")
                {
                }
                column(Type_Transactions;Transactions.Type)
                {
                }
                column(TransactionDescription_Transactions;Transactions."Transaction Description")
                {
                }
                column(MinimumAccountBalance_Transactions;Transactions."Minimum Account Balance")
                {
                }
                column(FeeBelowMinimumBalance_Transactions;Transactions."Fee Below Minimum Balance")
                {
                }
                column(NormalWithdrawalCharge_Transactions;Transactions."Normal Withdrawal Charge")
                {
                }
                column(Authorised_Transactions;Transactions.Authorised)
                {
                }
                column(CheckedBy_Transactions;Transactions."Checked By")
                {
                }
                column(FeeonWithdrawalInterval_Transactions;Transactions."Fee on Withdrawal Interval")
                {
                }
                column(Remarks_Transactions;Transactions.Remarks)
                {
                }
                column(Status_Transactions;Transactions.Status)
                {
                }
                column(DatePosted_Transactions;Transactions."Date Posted")
                {
                }
                column(TimePosted_Transactions;Transactions."Time Posted")
                {
                }
                column(PostedBy_Transactions;Transactions."Posted By")
                {
                }
                column(ExpectedMaturityDate_Transactions;Transactions."Expected Maturity Date")
                {
                }
                column(Picture_Transactions;Transactions.Picture)
                {
                }
                column(CurrencyCode_Transactions;Transactions."Currency Code")
                {
                }
                column(TransactionCategory_Transactions;Transactions."Transaction Category")
                {
                }
                column(Deposited_Transactions;Transactions.Deposited)
                {
                }
                column(DateDeposited_Transactions;Transactions."Date Deposited")
                {
                }
                column(TimeDeposited_Transactions;Transactions."Time Deposited")
                {
                }
                column(DepositedBy_Transactions;Transactions."Deposited By")
                {
                }
                column(PostDated_Transactions;Transactions."Post Dated")
                {
                }
                column(Select_Transactions;Transactions.Select)
                {
                }
                column(StatusDate_Transactions;Transactions."Status Date")
                {
                }
                column(StatusTime_Transactions;Transactions."Status Time")
                {
                }
                column(SupervisorChecked_Transactions;Transactions."Supervisor Checked")
                {
                }
                column(BookBalance_Transactions;Transactions."Book Balance")
                {
                }
                column(NoticeNo_Transactions;Transactions."Notice No")
                {
                }
                column(NoticeCleared_Transactions;Transactions."Notice Cleared")
                {
                }
                column(ScheduleAmount_Transactions;Transactions."Schedule Amount")
                {
                }
                column(HasSchedule_Transactions;Transactions."Has Schedule")
                {
                }
                column(Requested_Transactions;Transactions.Requested)
                {
                }
                column(DateRequested_Transactions;Transactions."Date Requested")
                {
                }
                column(TimeRequested_Transactions;Transactions."Time Requested")
                {
                }
                column(RequestedBy_Transactions;Transactions."Requested By")
                {
                }
                column(Overdraft_Transactions;Transactions.Overdraft)
                {
                }
                column(ChequeProcessed_Transactions;Transactions."Cheque Processed")
                {
                }
                column(StaffPayrollNo_Transactions;Transactions."Staff/Payroll No")
                {
                }
                column(ChequeTransferred_Transactions;Transactions."Cheque Transferred")
                {
                }
                column(ExpectedAmount_Transactions;Transactions."Expected Amount")
                {
                }
                column(LineTotals_Transactions;Transactions."Line Totals")
                {
                }
                column(TransferDate_Transactions;Transactions."Transfer Date")
                {
                }
                column(BIHNo_Transactions;Transactions."BIH No")
                {
                }
                column(TransferNo_Transactions;Transactions."Transfer No")
                {
                }
                column(Attached_Transactions;Transactions.Attached)
                {
                }
                column(BOSAAccountNo_Transactions;Transactions."BOSA Account No")
                {
                }
                column(SalaryProcessing_Transactions;Transactions."Salary Processing")
                {
                }
                column(ExpenseAccount_Transactions;Transactions."Expense Account")
                {
                }
                column(ExpenseDescription_Transactions;Transactions."Expense Description")
                {
                }
                column(CompanyCode_Transactions;Transactions."Company Code")
                {
                }
                column(ScheduleType_Transactions;Transactions."Schedule Type")
                {
                }
                column(BankedBy_Transactions;Transactions."Banked By")
                {
                }
                column(DateBanked_Transactions;Transactions."Date Banked")
                {
                }
                column(TimeBanked_Transactions;Transactions."Time Banked")
                {
                }
                column(BankingPosted_Transactions;Transactions."Banking Posted")
                {
                }
                column(ClearedBy_Transactions;Transactions."Cleared By")
                {
                }
                column(DateCleared_Transactions;Transactions."Date Cleared")
                {
                }
                column(TimeCleared_Transactions;Transactions."Time Cleared")
                {
                }
                column(ClearingPosted_Transactions;Transactions."Clearing Posted")
                {
                }
                column(NeedsApproval_Transactions;Transactions."Needs Approval")
                {
                }
                column(IDType_Transactions;Transactions."ID Type")
                {
                }
                column(IDNo_Transactions;Transactions."ID No")
                {
                }
                column(ReferenceNo_Transactions;Transactions."Reference No")
                {
                }
                column(RefundCheque_Transactions;Transactions."Refund Cheque")
                {
                }
                column(Imported_Transactions;Transactions.Imported)
                {
                }
                column(ExternalAccountNo_Transactions;Transactions."External Account No")
                {
                }
                column(BOSATransactions_Transactions;Transactions."BOSA Transactions")
                {
                }
                column(BankAccount_Transactions;Transactions."Bank Account")
                {
                }
                column(SaversTotal_Transactions;Transactions."Savers Total")
                {
                }
                column(MustaafuTotal_Transactions;Transactions."Mustaafu Total")
                {
                }
                column(JuniorStarTotal_Transactions;Transactions."Junior Star Total")
                {
                }
                column(Printed_Transactions;Transactions.Printed)
                {
                }
                column(WithdrawalFrequencyAuthorised_Transactions;Transactions."Withdrawal FrequencyAuthorised")
                {
                }
                column(FrequencyNeedsApproval_Transactions;Transactions."Frequency Needs Approval")
                {
                }
                column(SpecialAdvanceNo_Transactions;Transactions."Special Advance No")
                {
                }
                column(BankersChequeType_Transactions;Transactions."Bankers Cheque Type")
                {
                }
                column(SuspendedAmount_Transactions;Transactions."Suspended Amount")
                {
                }
                column(TransferredByEFT_Transactions;Transactions."Transferred By EFT")
                {
                }
                column(BankingUser_Transactions;Transactions."Banking User")
                {
                }
                column(CompanyTextName_Transactions;Transactions."Company Text Name")
                {
                }
                column(DateFilter_Transactions;Transactions."Date Filter")
                {
                }
                column(TotalSalaries_Transactions;Transactions."Total Salaries")
                {
                }
                column(EFTTransferred_Transactions;Transactions."EFT Transferred")
                {
                }
                column(ATMTransactionsTotal_Transactions;Transactions."ATM Transactions Total")
                {
                }
                column(BankCode_Transactions;Transactions."Bank Code")
                {
                }
                column(ExternalAccountName_Transactions;Transactions."External Account Name")
                {
                }
                column(OverdraftLimit_Transactions;Transactions."Overdraft Limit")
                {
                }
                column(OverdraftAllowed_Transactions;Transactions."Overdraft Allowed")
                {
                }
                column(AvailableBalance_Transactions;Transactions."Available Balance")
                {
                }
                column(AuthorisationRequirement_Transactions;Transactions."Authorisation Requirement")
                {
                }
                column(BankersChequeNo_Transactions;Transactions."Bankers Cheque No")
                {
                }
                column(TransactionSpan_Transactions;Transactions."Transaction Span")
                {
                }
                column(UnclearedCheques_Transactions;Transactions."Uncleared Cheques")
                {
                }
                column(TransactionAvailableBalance_Transactions;Transactions."Transaction Available Balance")
                {
                }
                column(BranchAccount_Transactions;Transactions."Branch Account")
                {
                }
                column(BranchTransaction_Transactions;Transactions."Branch Transaction")
                {
                }
                column(FOSABranchName_Transactions;Transactions."FOSA Branch Name")
                {
                }
                column(BranchRefference_Transactions;Transactions."Branch Refference")
                {
                }
                column(BranchAccountNo_Transactions;Transactions."Branch Account No")
                {
                }
                column(BranchTransactionDate_Transactions;Transactions."Branch Transaction Date")
                {
                }
                column(PostAttempted_Transactions;Transactions."Post Attempted")
                {
                }
                column(TransactingBranch_Transactions;Transactions."Transacting Branch")
                {
                }
                column(Signature_Transactions;Transactions.Signature)
                {
                }
                column(AllocatedAmount_Transactions;Transactions."Allocated Amount")
                {
                }
                column(AmountDiscounted_Transactions;Transactions."Amount Discounted")
                {
                }
                column(DontClear_Transactions;Transactions."Dont Clear")
                {
                }
                column(OtherBankersNo_Transactions;Transactions."Other Bankers No.")
                {
                }
                column(Discard_Transactions;Transactions.Discard)
                {
                }
                column(NAHBalance_Transactions;Transactions."N.A.H Balance")
                {
                }
                column(ChequeDepositRemarks_Transactions;Transactions."Cheque Deposit Remarks")
                {
                }
                column(BalancingAccount_Transactions;Transactions."Balancing Account")
                {
                }
                column(BalancingAccountName_Transactions;Transactions."Balancing Account Name")
                {
                }
                column(BankersChequePayee_Transactions;Transactions."Bankers Cheque Payee")
                {
                }
                column(MemberNo_Transactions;Transactions."Member No")
                {
                }
                column(MemberName_Transactions;Transactions."Member Name")
                {
                }
                column(SavingsProduct_Transactions;Transactions."Savings Product")
                {
                }
                column(TransactionChrages_Transactions;Transactions."Transaction Chrages")
                {
                }
                column(CashierBank_Transactions;Transactions."Cashier Bank")
                {
                }
                column(DrawersAccountNo_Transactions;Transactions."Drawer's Account No")
                {
                }
                column(DrawersName_Transactions;Transactions."Drawer's Name")
                {
                }
                column(DrawersChequeNo_Transactions;Transactions."Drawers Cheque No.")
                {
                }
                column(TransactionModeNew_Transactions;Transactions."Transaction Mode New")
                {
                }
                column(ChequeClearingBankCode_Transactions;Transactions."Cheque Clearing Bank Code")
                {
                }
                column(ChequeClearingBank_Transactions;Transactions."Cheque Clearing Bank")
                {
                }
                column(DrawersMemberNo_Transactions;Transactions."Drawers Member No")
                {
                }
                column(StaffAccount_Transactions;Transactions."Staff Account")
                {
                }
                column(DocumentDate_Transactions;Transactions."Document Date")
                {
                }
                column(OverdraftTransaction_Transactions;Transactions."Overdraft Transaction")
                {
                }
                column(ReasonForFreezingAccount_Transactions;Transactions."Reason For Freezing Account")
                {
                }
                column(OverDraftType_Transactions;Transactions."Over Draft Type")
                {
                }
                column(LWDLoanNo_Transactions;Transactions."LWD Loan No")
                {
                }
                column(LWDLoanProduct_Transactions;Transactions."LWD Loan Product")
                {
                }
                column(ExcemptCharge_Transactions;Transactions."Excempt Charge")
                {
                }
                column(ABCTransactionType_Transactions;Transactions."ABC Transaction Type")
                {
                }
                column(ABCDepositer_Transactions;Transactions."ABC Depositer")
                {
                }
                column(ABCDepositerID_Transactions;Transactions."ABC Depositer ID")
                {
                }
                column(HasSpecialMandate_Transactions;Transactions."Has Special Mandate")
                {
                }
                column(TransactingAgent_Transactions;Transactions."Transacting Agent")
                {
                }
                column(Reversed_Transactions;Transactions.Reversed)
                {
                }
                column(UseGraduatedCharges_Transactions;Transactions."Use Graduated Charges")
                {
                }
                column(AgentName_Transactions;Transactions."Agent Name")
                {
                }
                column(ChequeDiscountedAmount_Transactions;Transactions."Cheque Discounted Amount")
                {
                }
                column(ExcessTransactionType_Transactions;Transactions."Excess Transaction Type")
                {
                }
                column(BulkWithdrawalApplDone_Transactions;Transactions."Bulk Withdrawal Appl Done")
                {
                }
                column(BulkWithdrawalApplDate_Transactions;Transactions."Bulk Withdrawal Appl Date")
                {
                }
                column(BulkWithdrawalApplAmount_Transactions;Transactions."Bulk Withdrawal Appl Amount")
                {
                }
                column(BulkWithdrawalFee_Transactions;Transactions."Bulk Withdrawal Fee")
                {
                }
                column(BulkWithdrawalAppDoneBy_Transactions;Transactions."Bulk Withdrawal App Done By")
                {
                }
                column(SigningInstructions_Transactions;Transactions."Signing Instructions")
                {
                }
                column(HasSignatories_Transactions;Transactions."Has Signatories")
                {
                }
                column(ClearCheque_Transactions;Transactions."Clear Cheque")
                {
                }
                column(BounceCheque_Transactions;Transactions."Bounce Cheque")
                {
                }
                column(BulkWithdrawalDate_Transactions;Transactions."Bulk Withdrawal Date")
                {
                }
                column(IDNumber_Transactions;Transactions."ID Number")
                {
                }
                column(SelectToClear_Transactions;Transactions."Select To Clear")
                {
                }
                column(OutstandingDiscountedAmount_Transactions;Transactions."Outstanding Discounted Amount")
                {
                }
                column(OutstandingDiscountedCheque_Transactions;Transactions."Outstanding Discounted Cheque")
                {
                }
                column(TenantNo_Transactions;Transactions."Tenant No")
                {
                }
                column(TenantTransactions_Transactions;Transactions."Tenant Transactions")
                {
                }
                column(TenantName_Transactions;Transactions."Tenant Name")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    EntryNo:=EntryNo+1;
                end;
            }
            dataitem("CloudPESA MPESA Trans";"CloudPESA MPESA Trans")
            {
                DataItemLink = "Account No"=field("No.");
                DataItemTableView = where(Posted=const(true));
                column(ReportForNavId_195; 195)
                {
                }
                column(TransactionDate_CloudPESAMPESATrans;"CloudPESA MPESA Trans"."Transaction Date")
                {
                }
                column(Description_CloudPESAMPESATrans;"CloudPESA MPESA Trans".Description)
                {
                }
                column(TransactionType_CloudPESAMPESATrans;"CloudPESA MPESA Trans"."Transaction Type")
                {
                }
                column(Amount_CloudPESAMPESATrans;"CloudPESA MPESA Trans".Amount)
                {
                }
                column(DocumentNo_CloudPESAMPESATrans;"CloudPESA MPESA Trans"."Document No")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    HideMpesa := false;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                HideMpesa := true;
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
        HideMpesa: Boolean;
}

