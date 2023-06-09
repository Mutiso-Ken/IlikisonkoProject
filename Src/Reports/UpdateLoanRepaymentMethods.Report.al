#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516859 "Update Loan Repayment Methods"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Update Loan Repayment Methods.rdlc';

    dataset
    {
        dataitem("Loans Register";"Loans Register")
        {
            RequestFilterFields = "Loan Product Type",Source,"Loan  No.";
            column(ReportForNavId_1000000000; 1000000000)
            {
            }
            column(LoanNo_LoansRegister;"Loans Register"."Loan  No.")
            {
            }
            column(ApplicationDate_LoansRegister;"Loans Register"."Application Date")
            {
            }
            column(LoanProductType_LoansRegister;"Loans Register"."Loan Product Type")
            {
            }
            column(ClientCode_LoansRegister;"Loans Register"."Client Code")
            {
            }
            column(GroupCode_LoansRegister;"Loans Register"."Group Code")
            {
            }
            column(Savings_LoansRegister;"Loans Register".Savings)
            {
            }
            column(ExistingLoan_LoansRegister;"Loans Register"."Existing Loan")
            {
            }
            column(RequestedAmount_LoansRegister;"Loans Register"."Requested Amount")
            {
            }
            column(ApprovedAmount_LoansRegister;"Loans Register"."Approved Amount")
            {
            }
            column(Interest_LoansRegister;"Loans Register".Interest)
            {
            }
            column(Insurance_LoansRegister;"Loans Register".Insurance)
            {
            }
            column(SourceofFunds_LoansRegister;"Loans Register"."Source of Funds")
            {
            }
            column(ClientCycle_LoansRegister;"Loans Register"."Client Cycle")
            {
            }
            column(ClientName_LoansRegister;"Loans Register"."Client Name")
            {
            }
            column(LoanStatus_LoansRegister;"Loans Register"."Loan Status")
            {
            }
            column(IssuedDate_LoansRegister;"Loans Register"."Issued Date")
            {
            }
            column(Installments_LoansRegister;"Loans Register".Installments)
            {
            }
            column(LoanDisbursementDate_LoansRegister;"Loans Register"."Loan Disbursement Date")
            {
            }
            column(ModeofDisbursement_LoansRegister;"Loans Register"."Mode of Disbursement")
            {
            }
            column(AffidavitItem1Details_LoansRegister;"Loans Register"."Affidavit - Item 1 Details")
            {
            }
            column(AffidavitEstimatedValue1_LoansRegister;"Loans Register"."Affidavit - Estimated Value 1")
            {
            }
            column(AffidavitItem2Details_LoansRegister;"Loans Register"."Affidavit - Item 2 Details")
            {
            }
            column(AffidavitEstimatedValue2_LoansRegister;"Loans Register"."Affidavit - Estimated Value 2")
            {
            }
            column(AffidavitItem3Details_LoansRegister;"Loans Register"."Affidavit - Item 3 Details")
            {
            }
            column(AffidavitEstimatedValue3_LoansRegister;"Loans Register"."Affidavit - Estimated Value 3")
            {
            }
            column(AffidavitItem4Details_LoansRegister;"Loans Register"."Board Approval Comment")
            {
            }
            column(AffidavitEstimatedValue4_LoansRegister;"Loans Register"."Affidavit - Estimated Value 4")
            {
            }
            column(AffidavitItem5Details_LoansRegister;"Loans Register"."Affidavit - Item 5 Details")
            {
            }
            column(AffidavitEstimatedValue5_LoansRegister;"Loans Register"."Affidavit - Estimated Value 5")
            {
            }
            column(MagistrateName_LoansRegister;"Loans Register"."Magistrate Name")
            {
            }
            column(DateforAffidavit_LoansRegister;"Loans Register"."Date for Affidavit")
            {
            }
            column(NameofChiefAssistant_LoansRegister;"Loans Register"."Board Approved By")
            {
            }
            column(AffidavitSigned_LoansRegister;"Loans Register"."Affidavit Signed?")
            {
            }
            column(DateApproved_LoansRegister;"Loans Register"."Date Approved")
            {
            }
            column(GracePeriod_LoansRegister;"Loans Register"."Grace Period")
            {
            }
            column(InstalmentPeriod_LoansRegister;"Loans Register"."Instalment Period")
            {
            }
            column(Repayment_LoansRegister;"Loans Register".Repayment)
            {
            }
            column(PaysInterestDuringGP_LoansRegister;"Loans Register"."Pays Interest During GP")
            {
            }
            column(PercentRepayments_LoansRegister;"Loans Register"."Percent Repayments")
            {
            }
            column(PayingBankAccountNo_LoansRegister;"Loans Register"."Paying Bank Account No")
            {
            }
            column(NoSeries_LoansRegister;"Loans Register"."No. Series")
            {
            }
            column(LoanProductTypeName_LoansRegister;"Loans Register"."Loan Product Type Name")
            {
            }
            column(ChequeNumber_LoansRegister;"Loans Register"."Cheque Number")
            {
            }
            column(BankNo_LoansRegister;"Loans Register"."Bank No")
            {
            }
            column(SlipNumber_LoansRegister;"Loans Register"."Slip Number")
            {
            }
            column(TotalPaid_LoansRegister;"Loans Register"."Total Paid")
            {
            }
            column(ScheduleRepayments_LoansRegister;"Loans Register"."Schedule Repayments")
            {
            }
            column(DocNoUsed_LoansRegister;"Loans Register"."Doc No Used")
            {
            }
            column(PostingDate_LoansRegister;"Loans Register"."Posting Date")
            {
            }
            column(BatchNo_LoansRegister;"Loans Register"."Batch No.")
            {
            }
            column(EditInterestRate_LoansRegister;"Loans Register"."Edit Interest Rate")
            {
            }
            column(Posted_LoansRegister;"Loans Register".Posted)
            {
            }
            column(ProductCode_LoansRegister;"Loans Register"."Product Code")
            {
            }
            column(DocumentNo2Filter_LoansRegister;"Loans Register"."Document No 2 Filter")
            {
            }
            column(FieldOffice_LoansRegister;"Loans Register"."Field Office")
            {
            }
            column(Dimension_LoansRegister;"Loans Register".Dimension)
            {
            }
            column(AmountDisbursed_LoansRegister;"Loans Register"."Amount Disbursed")
            {
            }
            column(FullyDisbursed_LoansRegister;"Loans Register"."Fully Disbursed")
            {
            }
            column(NewInterestRate_LoansRegister;"Loans Register"."New Interest Rate")
            {
            }
            column(NewNoofInstalment_LoansRegister;"Loans Register"."New No. of Instalment")
            {
            }
            column(NewGracePeriod_LoansRegister;"Loans Register"."New Grace Period")
            {
            }
            column(NewRegularInstalment_LoansRegister;"Loans Register"."New Regular Instalment")
            {
            }
            column(LoanBalanceatRescheduling_LoansRegister;"Loans Register"."Loan Balance at Rescheduling")
            {
            }
            column(LoanReschedule_LoansRegister;"Loans Register"."Loan Reschedule")
            {
            }
            column(DateRescheduled_LoansRegister;"Loans Register"."Date Rescheduled")
            {
            }
            column(Rescheduleby_LoansRegister;"Loans Register"."Reschedule by")
            {
            }
            column(FlatRatePrincipal_LoansRegister;"Loans Register"."Flat Rate Principal")
            {
            }
            column(FlatrateInterest_LoansRegister;"Loans Register"."Flat rate Interest")
            {
            }
            column(TotalRepayment_LoansRegister;"Loans Register"."Total Repayment")
            {
            }
            column(InterestCalculationMethod_LoansRegister;"Loans Register"."Interest Calculation Method")
            {
            }
            column(EditInterestCalculationMeth_LoansRegister;"Loans Register"."Edit Interest Calculation Meth")
            {
            }
            column(BalanceBF_LoansRegister;"Loans Register"."Balance BF")
            {
            }
            column(Interesttobepaid_LoansRegister;"Loans Register"."Interest to be paid")
            {
            }
            column(Datefilter_LoansRegister;"Loans Register"."Date filter")
            {
            }
            column(ChequeDate_LoansRegister;"Loans Register"."Cheque Date")
            {
            }
            column(OutstandingBalance_LoansRegister;"Loans Register"."Outstanding Balance")
            {
            }
            column(LoantoShareRatio_LoansRegister;"Loans Register"."Loan to Share Ratio")
            {
            }
            column(SharesBalance_LoansRegister;"Loans Register"."Shares Balance")
            {
            }
            column(MaxInstallments_LoansRegister;"Loans Register"."Max. Installments")
            {
            }
            column(MaxLoanAmount_LoansRegister;"Loans Register"."Max. Loan Amount")
            {
            }
            column(LoanCycle_LoansRegister;"Loans Register"."Loan Cycle")
            {
            }
            column(PenaltyCharged_LoansRegister;"Loans Register"."Penalty Charged")
            {
            }
            column(LoanAmount_LoansRegister;"Loans Register"."Loan Amount")
            {
            }
            column(CurrentShares_LoansRegister;"Loans Register"."Current Shares")
            {
            }
            column(LoanRepayment_LoansRegister;"Loans Register"."Loan Repayment")
            {
            }
            column(RepaymentMethod_LoansRegister;"Loans Register"."Repayment Method")
            {
            }
            column(GracePeriodPrincipleM_LoansRegister;"Loans Register"."Grace Period - Principle (M)")
            {
            }
            column(GracePeriodInterestM_LoansRegister;"Loans Register"."Grace Period - Interest (M)")
            {
            }
            column(Adjustment_LoansRegister;"Loans Register".Adjustment)
            {
            }
            column(PaymentDueDate_LoansRegister;"Loans Register"."Payment Due Date")
            {
            }
            column(TrancheNumber_LoansRegister;"Loans Register"."Tranche Number")
            {
            }
            column(AmountOfTranche_LoansRegister;"Loans Register"."Amount Of Tranche")
            {
            }
            column(TotalDisbursmenttoDate_LoansRegister;"Loans Register"."Total Disbursment to Date")
            {
            }
            column(CopyofID_LoansRegister;"Loans Register"."Copy of ID")
            {
            }
            column(Contract_LoansRegister;"Loans Register".Contract)
            {
            }
            column(Payslip_LoansRegister;"Loans Register".Payslip)
            {
            }
            column(ContractualShares_LoansRegister;"Loans Register"."Contractual Shares")
            {
            }
            column(LastPayDate_LoansRegister;"Loans Register"."Last Pay Date")
            {
            }
            column(InterestDue_LoansRegister;"Loans Register"."Interest Due")
            {
            }
            column(AppraisalStatus_LoansRegister;"Loans Register"."Appraisal Status")
            {
            }
            column(InterestPaid_LoansRegister;"Loans Register"."Interest Paid")
            {
            }
            column(PenaltyPaid_LoansRegister;"Loans Register"."Penalty Paid")
            {
            }
            column(ApplicationFeePaid_LoansRegister;"Loans Register"."Application Fee Paid")
            {
            }
            column(AppraisalFeePaid_LoansRegister;"Loans Register"."Appraisal Fee Paid")
            {
            }
            column(GlobalDimension1Code_LoansRegister;"Loans Register"."Global Dimension 1 Code")
            {
            }
            column(RepaymentStartDate_LoansRegister;"Loans Register"."Repayment Start Date")
            {
            }
            column(InstallmentIncludingGrace_LoansRegister;"Loans Register"."Installment Including Grace")
            {
            }
            column(ScheduleRepayment_LoansRegister;"Loans Register"."Schedule Repayment")
            {
            }
            column(ScheduleInterest_LoansRegister;"Loans Register"."Schedule Interest")
            {
            }
            column(InterestDebit_LoansRegister;"Loans Register"."Interest Debit")
            {
            }
            column(ScheduleInteresttoDate_LoansRegister;"Loans Register"."Schedule Interest to Date")
            {
            }
            column(RepaymentsBF_LoansRegister;"Loans Register"."Repayments BF")
            {
            }
            column(AccountNo_LoansRegister;"Loans Register"."Account No")
            {
            }
            column(BOSANo_LoansRegister;"Loans Register"."BOSA No")
            {
            }
            column(StaffNo_LoansRegister;"Loans Register"."Staff No")
            {
            }
            column(BOSALoanAmount_LoansRegister;"Loans Register"."BOSA Loan Amount")
            {
            }
            column(TopUpAmount_LoansRegister;"Loans Register"."Top Up Amount")
            {
            }
            column(LoanReceived_LoansRegister;"Loans Register"."Loan Received")
            {
            }
            column(PeriodDateFilter_LoansRegister;"Loans Register"."Period Date Filter")
            {
            }
            column(CurrentRepayment_LoansRegister;"Loans Register"."Current Repayment")
            {
            }
            column(OustandingInterest_LoansRegister;"Loans Register"."Oustanding Interest")
            {
            }
            column(OustandingInteresttoDate_LoansRegister;"Loans Register"."Oustanding Interest to Date")
            {
            }
            column(CurrentInterestPaid_LoansRegister;"Loans Register"."Current Interest Paid")
            {
            }
            column(DocumentNoFilter_LoansRegister;"Loans Register"."Document No. Filter")
            {
            }
            column(ChequeNo_LoansRegister;"Loans Register"."Cheque No.")
            {
            }
            column(PersonalLoanOffset_LoansRegister;"Loans Register"."Personal Loan Off-set")
            {
            }
            column(OldAccountNo_LoansRegister;"Loans Register"."Old Account No.")
            {
            }
            column(LoanPrincipleRepayment_LoansRegister;"Loans Register"."Loan Principle Repayment")
            {
            }
            column(LoanInterestRepayment_LoansRegister;"Loans Register"."Loan Interest Repayment")
            {
            }
            column(ContraAccount_LoansRegister;"Loans Register"."Contra Account")
            {
            }
            column(TransactingBranch_LoansRegister;"Loans Register"."Transacting Branch")
            {
            }
            column(Source_LoansRegister;"Loans Register".Source)
            {
            }
            column(NetIncome_LoansRegister;"Loans Register"."Net Income")
            {
            }
            column(NoOfGuarantors_LoansRegister;"Loans Register"."No. Of Guarantors")
            {
            }
            column(TotalLoanGuaranted_LoansRegister;"Loans Register"."Total Loan Guaranted")
            {
            }
            column(SharesBoosted_LoansRegister;"Loans Register"."Shares Boosted")
            {
            }
            column(BasicPay_LoansRegister;"Loans Register"."Basic Pay")
            {
            }
            column(HouseAllowance_LoansRegister;"Loans Register"."House Allowance")
            {
            }
            column(OtherAllowance_LoansRegister;"Loans Register"."Other Allowance")
            {
            }
            column(TotalDeductions_LoansRegister;"Loans Register"."Total Deductions")
            {
            }
            column(ClearedEffects_LoansRegister;"Loans Register"."Cleared Effects")
            {
            }
            column(Remarks_LoansRegister;"Loans Register".Remarks)
            {
            }
            column(Advice_LoansRegister;"Loans Register".Advice)
            {
            }
            column(SpecialLoanAmount_LoansRegister;"Loans Register"."Special Loan Amount")
            {
            }
            column(BridgingLoanPosted_LoansRegister;"Loans Register"."Bridging Loan Posted")
            {
            }
            column(BOSALoanNo_LoansRegister;"Loans Register"."BOSA Loan No.")
            {
            }
            column(PreviousRepayment_LoansRegister;"Loans Register"."Previous Repayment")
            {
            }
            column(NoLoaninMB_LoansRegister;"Loans Register"."No Loan in MB")
            {
            }
            column(RecoveredBalance_LoansRegister;"Loans Register"."Recovered Balance")
            {
            }
            column(ReconIssue_LoansRegister;"Loans Register"."Recon Issue")
            {
            }
            column(LoanPurpose_LoansRegister;"Loans Register"."Loan Purpose")
            {
            }
            column(Reconciled_LoansRegister;"Loans Register".Reconciled)
            {
            }
            column(AppealAmount_LoansRegister;"Loans Register"."Appeal Amount")
            {
            }
            column(AppealPosted_LoansRegister;"Loans Register"."Appeal Posted")
            {
            }
            column(ProjectAmount_LoansRegister;"Loans Register"."Project Amount")
            {
            }
            column(ProjectAccountNo_LoansRegister;"Loans Register"."Project Account No")
            {
            }
            column(LocationFilter_LoansRegister;"Loans Register"."Location Filter")
            {
            }
            column(OtherCommitmentsClearance_LoansRegister;"Loans Register"."Other Commitments Clearance")
            {
            }
            column(DiscountedAmount_LoansRegister;"Loans Register"."Discounted Amount")
            {
            }
            column(TransportAllowance_LoansRegister;"Loans Register"."Transport Allowance")
            {
            }
            column(MileageAllowance_LoansRegister;"Loans Register"."Mileage Allowance")
            {
            }
            column(SystemCreated_LoansRegister;"Loans Register"."System Created")
            {
            }
            column(BoostingCommision_LoansRegister;"Loans Register"."Boosting Commision")
            {
            }
            column(VoluntaryDeductions_LoansRegister;"Loans Register"."Voluntary Deductions")
            {
            }
            column(V4Bridging_LoansRegister;"Loans Register"."4 % Bridging")
            {
            }
            column(NoOfGuarantorsFOSA_LoansRegister;"Loans Register"."No. Of Guarantors-FOSA")
            {
            }
            column(Defaulted_LoansRegister;"Loans Register".Defaulted)
            {
            }
            column(BridgingPostingDate_LoansRegister;"Loans Register"."Bridging Posting Date")
            {
            }
            column(CommitementsOffset_LoansRegister;"Loans Register"."Commitements Offset")
            {
            }
            column(Gender_LoansRegister;"Loans Register".Gender)
            {
            }
            column(CapturedBy_LoansRegister;"Loans Register"."Captured By")
            {
            }
            column(BranchCode_LoansRegister;"Loans Register"."Branch Code")
            {
            }
            column(RecoveredFromGuarantor_LoansRegister;"Loans Register"."Recovered From Guarantor")
            {
            }
            column(GuarantorAmount_LoansRegister;"Loans Register"."Guarantor Amount")
            {
            }
            column(ExternalEFT_LoansRegister;"Loans Register"."External EFT")
            {
            }
            column(DefaulterOverideReasons_LoansRegister;"Loans Register"."Defaulter Overide Reasons")
            {
            }
            column(DefaulterOveride_LoansRegister;"Loans Register"."Defaulter Overide")
            {
            }
            column(LastInterestPayDate_LoansRegister;"Loans Register"."Last Interest Pay Date")
            {
            }
            column(OtherBenefits_LoansRegister;"Loans Register"."Other Benefits")
            {
            }
            column(RecoveredLoan_LoansRegister;"Loans Register"."Recovered Loan")
            {
            }
            column(V1stNotice_LoansRegister;"Loans Register"."1st Notice")
            {
            }
            column(V2ndNotice_LoansRegister;"Loans Register"."2nd Notice")
            {
            }
            column(FinalNotice_LoansRegister;"Loans Register"."Final Notice")
            {
            }
            column(OutstandingBalancetoDate_LoansRegister;"Loans Register"."Outstanding Balance to Date")
            {
            }
            column(LastAdviceDate_LoansRegister;"Loans Register"."Last Advice Date")
            {
            }
            column(AdviceType_LoansRegister;"Loans Register"."Advice Type")
            {
            }
            column(CurrentLocation_LoansRegister;"Loans Register"."Current Location")
            {
            }
            column(CompoundBalance_LoansRegister;"Loans Register"."Compound Balance")
            {
            }
            column(RepaymentRate_LoansRegister;"Loans Register"."Repayment Rate")
            {
            }
            column(ExpRepay_LoansRegister;"Loans Register"."Exp Repay")
            {
            }
            column(IDNO_LoansRegister;"Loans Register"."ID NO")
            {
            }
            column(RAmount_LoansRegister;"Loans Register".RAmount)
            {
            }
            column(EmployerCode_LoansRegister;"Loans Register"."Employer Code")
            {
            }
            column(LastLoanIssueDate_LoansRegister;"Loans Register"."Last Loan Issue Date")
            {
            }
            column(LstLN1_LoansRegister;"Loans Register"."Lst LN1")
            {
            }
            column(LstLN2_LoansRegister;"Loans Register"."Lst LN2")
            {
            }
            column(Lastloan_LoansRegister;"Loans Register"."Last loan")
            {
            }
            column(LoansCategory_LoansRegister;"Loans Register"."Loans Category")
            {
            }
            column(LoansCategorySASRA_LoansRegister;"Loans Register"."Loans Category-SASRA")
            {
            }
            column(BelaBranch_LoansRegister;"Loans Register"."Bela Branch")
            {
            }
            column(NetAmount_LoansRegister;"Loans Register"."Net Amount")
            {
            }
            column(Bankcode_LoansRegister;"Loans Register"."Bank code")
            {
            }
            column(BankName_LoansRegister;"Loans Register"."Bank Name")
            {
            }
            column(BankBranch_LoansRegister;"Loans Register"."Bank Branch")
            {
            }
            column(OutstandingLoan_LoansRegister;"Loans Register"."Outstanding Loan")
            {
            }
            column(LoanCount_LoansRegister;"Loans Register"."Loan Count")
            {
            }
            column(RepayCount_LoansRegister;"Loans Register"."Repay Count")
            {
            }
            column(OutstandingLoan2_LoansRegister;"Loans Register"."Outstanding Loan2")
            {
            }
            column(TopupLoanNo_LoansRegister;"Loans Register"."Topup Loan No")
            {
            }
            column(Defaulter_LoansRegister;"Loans Register".Defaulter)
            {
            }
            column(DefaulterInfo_LoansRegister;"Loans Register".DefaulterInfo)
            {
            }
            column(TotalEarningsSalary_LoansRegister;"Loans Register"."Total Earnings(Salary)")
            {
            }
            column(TotalDeductionsSalary_LoansRegister;"Loans Register"."Total Deductions(Salary)")
            {
            }
            column(SharePurchase_LoansRegister;"Loans Register"."Share Purchase")
            {
            }
            column(ProductCurrencyCode_LoansRegister;"Loans Register"."Product Currency Code")
            {
            }
            column(CurrencyFilter_LoansRegister;"Loans Register"."Currency Filter")
            {
            }
            column(AmountDisburse_LoansRegister;"Loans Register"."Amount Disburse")
            {
            }
            column(Prepayments_LoansRegister;"Loans Register".Prepayments)
            {
            }
            column(ApplnbetweenCurrencies_LoansRegister;"Loans Register"."Appln. between Currencies")
            {
            }
            column(ExpectedDateofCompletion_LoansRegister;"Loans Register"."Expected Date of Completion")
            {
            }
            column(TotalScheduleRepayment_LoansRegister;"Loans Register"."Total Schedule Repayment")
            {
            }
            column(RecoveryMode_LoansRegister;"Loans Register"."Recovery Mode")
            {
            }
            column(RepaymentFrequency_LoansRegister;"Loans Register"."Repayment Frequency")
            {
            }
            column(ApprovalStatus_LoansRegister;"Loans Register"."Approval Status")
            {
            }
            column(OldVendorNo_LoansRegister;"Loans Register"."Old Vendor No")
            {
            }
            column(Insurance025_LoansRegister;"Loans Register"."Insurance 0.25")
            {
            }
            column(TotalTopUpCommission_LoansRegister;"Loans Register"."Total TopUp Commission")
            {
            }
            column(TotalloanOutstanding_LoansRegister;"Loans Register"."Total loan Outstanding")
            {
            }
            column(MonthlySharesCont_LoansRegister;"Loans Register"."Monthly Shares Cont")
            {
            }
            column(InsuranceOnShares_LoansRegister;"Loans Register"."Insurance On Shares")
            {
            }
            column(TotalLoanRepayment_LoansRegister;"Loans Register"."Total Loan Repayment")
            {
            }
            column(TotalLoanInterest_LoansRegister;"Loans Register"."Total Loan Interest")
            {
            }
            column(NetPaymenttoFOSA_LoansRegister;"Loans Register"."Net Payment to FOSA")
            {
            }
            column(ProcessedPayment_LoansRegister;"Loans Register"."Processed Payment")
            {
            }
            column(DatepaymentProcessed_LoansRegister;"Loans Register"."Date payment Processed")
            {
            }
            column(AttachedAmount_LoansRegister;"Loans Register"."Attached Amount")
            {
            }
            column(PenaltyAttached_LoansRegister;"Loans Register".PenaltyAttached)
            {
            }
            column(InDueAttached_LoansRegister;"Loans Register".InDueAttached)
            {
            }
            column(Attached_LoansRegister;"Loans Register".Attached)
            {
            }
            column(AdviceDate_LoansRegister;"Loans Register"."Advice Date")
            {
            }
            column(AttachementDate_LoansRegister;"Loans Register"."Attachement Date")
            {
            }
            column(TotalLoansOutstanding_LoansRegister;"Loans Register"."Total Loans Outstanding")
            {
            }
            column(JazaDeposits_LoansRegister;"Loans Register"."Jaza Deposits")
            {
            }
            column(MemberDeposits_LoansRegister;"Loans Register"."Member Deposits")
            {
            }
            column(LevyOnJazaDeposits_LoansRegister;"Loans Register"."Levy On Jaza Deposits")
            {
            }
            column(MinDepositAsPerTier_LoansRegister;"Loans Register"."Min Deposit As Per Tier")
            {
            }
            column(TotalRepayments_LoansRegister;"Loans Register"."Total Repayments")
            {
            }
            column(TotalInterest_LoansRegister;"Loans Register"."Total Interest")
            {
            }
            column(Bridged_LoansRegister;"Loans Register".Bridged)
            {
            }
            column(DepositReinstatement_LoansRegister;"Loans Register"."Deposit Reinstatement")
            {
            }
            column(MemberFound_LoansRegister;"Loans Register"."Member Found")
            {
            }
            column(RecommendedAmount_LoansRegister;"Loans Register"."Recommended Amount")
            {
            }
            column(PreviousYearsDividend_LoansRegister;"Loans Register"."Previous Years Dividend")
            {
            }
            column(partiallyBridged_LoansRegister;"Loans Register"."partially Bridged")
            {
            }
            column(loanInterest_LoansRegister;"Loans Register"."loan  Interest")
            {
            }
            column(BOSADeposits_LoansRegister;"Loans Register"."BOSA Deposits")
            {
            }
            column(TopupCommission_LoansRegister;"Loans Register"."Topup Commission")
            {
            }
            column(TopupiNTEREST_LoansRegister;"Loans Register"."Topup iNTEREST")
            {
            }
            column(NoofGurantorsFOSA_LoansRegister;"Loans Register"."No of Gurantors FOSA")
            {
            }
            column(LoanNoFound_LoansRegister;"Loans Register"."Loan No Found")
            {
            }
            column(CheckedBy_LoansRegister;"Loans Register"."Checked By")
            {
            }
            column(ApprovedBy_LoansRegister;"Loans Register"."Approved By")
            {
            }
            column(NewRepaymentPeriod_LoansRegister;"Loans Register"."New Repayment Period")
            {
            }
            column(RejectedBy_LoansRegister;"Loans Register"."Rejected By")
            {
            }
            column(LoansInsurance_LoansRegister;"Loans Register"."Loans Insurance")
            {
            }
            column(LastIntDate_LoansRegister;"Loans Register"."Last Int Date")
            {
            }
            column(Approvalremarks_LoansRegister;"Loans Register"."Approval remarks")
            {
            }
            column(LoanDisbursedAmount_LoansRegister;"Loans Register"."Loan Disbursed Amount")
            {
            }
            column(BankBridgeAmount_LoansRegister;"Loans Register"."Bank Bridge Amount")
            {
            }
            column(ApprovedRepayment_LoansRegister;"Loans Register"."Approved Repayment")
            {
            }
            column(RejectionRemark_LoansRegister;"Loans Register"."Rejection  Remark")
            {
            }
            column(OriginalApprovedAmount_LoansRegister;"Loans Register"."Original Approved Amount")
            {
            }
            column(OriginalApprovedUpdated_LoansRegister;"Loans Register"."Original Approved Updated")
            {
            }
            column(EmployerName_LoansRegister;"Loans Register"."Employer Name")
            {
            }
            column(TotalsLoanOutstanding_LoansRegister;"Loans Register"."Totals Loan Outstanding")
            {
            }
            column(InterestUpfrontAmount_LoansRegister;"Loans Register"."Interest Upfront Amount")
            {
            }
            column(LoanProcessingFee_LoansRegister;"Loans Register"."Loan Processing Fee")
            {
            }
            column(LoanAppraisalFee_LoansRegister;"Loans Register"."Loan Appraisal Fee")
            {
            }
            column(LoanInsurance_LoansRegister;"Loans Register"."Loan Insurance")
            {
            }
            column(ReceivedCopyOfID_LoansRegister;"Loans Register"."Received Copy Of ID")
            {
            }
            column(ReceivedPayslipBankStatemen_LoansRegister;"Loans Register"."Received Payslip/Bank Statemen")
            {
            }
            column(V1stTimeLoanee_LoansRegister;"Loans Register"."1st Time Loanee")
            {
            }
            column(AdjtedRepayment_LoansRegister;"Loans Register"."Adjted Repayment")
            {
            }
            column(MemberCategory_LoansRegister;"Loans Register"."Member Category")
            {
            }
            column(SharestoBoost_LoansRegister;"Loans Register"."Shares to Boost")
            {
            }
            column(HisaAllocation_LoansRegister;"Loans Register"."Hisa Allocation")
            {
            }
            column(HisaCommission_LoansRegister;"Loans Register"."Hisa Commission")
            {
            }
            column(HisaBoostingCommission_LoansRegister;"Loans Register"."Hisa Boosting Commission")
            {
            }
            column(ShareCapitalDue_LoansRegister;"Loans Register"."Share Capital Due")
            {
            }
            column(IntersetInArreas_LoansRegister;"Loans Register".IntersetInArreas)
            {
            }
            column(Upfronts_LoansRegister;"Loans Register".Upfronts)
            {
            }
            column(LoanCalcOffsetLoan_LoansRegister;"Loans Register"."Loan Calc. Offset Loan")
            {
            }
            column(LoanTransferFee_LoansRegister;"Loans Register"."Loan Transfer Fee")
            {
            }
            column(LoanSMSFee_LoansRegister;"Loans Register"."Loan SMS Fee")
            {
            }
            column(ScheduledPrincipaltoDate_LoansRegister;"Loans Register"."Scheduled Principal to Date")
            {
            }
            column(Penalty_LoansRegister;"Loans Register".Penalty)
            {
            }
            column(BasicPayH_LoansRegister;"Loans Register"."Basic Pay H")
            {
            }
            column(MedicalAllowanceH_LoansRegister;"Loans Register"."Medical AllowanceH")
            {
            }
            column(HouseAllowanceH_LoansRegister;"Loans Register"."House AllowanceH")
            {
            }
            column(StaffAssement_LoansRegister;"Loans Register"."Staff Assement")
            {
            }
            column(Pension_LoansRegister;"Loans Register".Pension)
            {
            }
            column(MedicalInsurance_LoansRegister;"Loans Register"."Medical Insurance")
            {
            }
            column(LifeInsurance_LoansRegister;"Loans Register"."Life Insurance")
            {
            }
            column(OtherLiabilities_LoansRegister;"Loans Register"."Other Liabilities")
            {
            }
            column(TransportBusFare_LoansRegister;"Loans Register"."Transport/Bus Fare")
            {
            }
            column(OtherIncome_LoansRegister;"Loans Register"."Other Income")
            {
            }
            column(PensionScheme_LoansRegister;"Loans Register"."Pension Scheme")
            {
            }
            column(OtherNonTaxable_LoansRegister;"Loans Register"."Other Non-Taxable")
            {
            }
            column(MonthlyContribution_LoansRegister;"Loans Register"."Monthly Contribution")
            {
            }
            column(SaccoDeductions_LoansRegister;"Loans Register"."Sacco Deductions")
            {
            }
            column(OtherTaxRelief_LoansRegister;"Loans Register"."Other Tax Relief")
            {
            }
            column(NHIF_LoansRegister;"Loans Register".NHIF)
            {
            }
            column(NSSF_LoansRegister;"Loans Register".NSSF)
            {
            }
            column(PAYE_LoansRegister;"Loans Register".PAYE)
            {
            }
            column(RiskMGT_LoansRegister;"Loans Register"."Risk MGT")
            {
            }
            column(OtherLoansRepayments_LoansRegister;"Loans Register"."Other Loans Repayments")
            {
            }
            column(BridgeAmountRelease_LoansRegister;"Loans Register"."Bridge Amount Release")
            {
            }
            column(Staff_LoansRegister;"Loans Register".Staff)
            {
            }
            column(Disabled_LoansRegister;"Loans Register".Disabled)
            {
            }
            column(StaffUnionContribution_LoansRegister;"Loans Register"."Staff Union Contribution")
            {
            }
            column(NonPayrollPayments_LoansRegister;"Loans Register"."Non Payroll Payments")
            {
            }
            column(GrossPay_LoansRegister;"Loans Register"."Gross Pay")
            {
            }
            column(TotalDeductionsH_LoansRegister;"Loans Register"."Total DeductionsH")
            {
            }
            column(UtilizableAmount_LoansRegister;"Loans Register"."Utilizable Amount")
            {
            }
            column(NetUtilizableAmount_LoansRegister;"Loans Register"."Net Utilizable Amount")
            {
            }
            column(NettakeHome_LoansRegister;"Loans Register"."Net take Home")
            {
            }
            column(Signature_LoansRegister;"Loans Register".Signature)
            {
            }
            column(WitnessedBy_LoansRegister;"Loans Register"."Witnessed By")
            {
            }
            column(WitnessName_LoansRegister;"Loans Register"."Witness Name")
            {
            }
            column(ReceivedCopiesofPayslip_LoansRegister;"Loans Register"."Received Copies of Payslip")
            {
            }
            column(InterestInArrears_LoansRegister;"Loans Register"."Interest In Arrears")
            {
            }
            column(PrivateMember_LoansRegister;"Loans Register"."Private Member")
            {
            }
            column(LoanProcessing_LoansRegister;"Loans Register"."Loan Processing")
            {
            }
            column(TotalTopupAmount_LoansRegister;"Loans Register"."Total Topup Amount")
            {
            }
            column(LoanCashCleared_LoansRegister;"Loans Register"."Loan  Cash Cleared")
            {
            }
            column(LoanCashClearancefee_LoansRegister;"Loans Register"."Loan Cash Clearance fee")
            {
            }
            column(LoanDue_LoansRegister;"Loans Register"."Loan Due")
            {
            }
            column(PartialDisbursedAmountDue_LoansRegister;"Loans Register"."Partial Disbursed(Amount Due)")
            {
            }
            column(LoanLastPaydate2009Nav_LoansRegister;"Loans Register"."Loan Last Pay date 2009Nav")
            {
            }
            column(LoansReferee1_LoansRegister;"Loans Register"."Loans Referee 1")
            {
            }
            column(LoansReferee1Name_LoansRegister;"Loans Register"."Loans Referee 1 Name")
            {
            }
            column(LoansReferee2_LoansRegister;"Loans Register"."Loans Referee 2")
            {
            }
            column(LoansReferee2Name_LoansRegister;"Loans Register"."Loans Referee 2 Name")
            {
            }
            column(LoansReferee1Relationship_LoansRegister;"Loans Register"."Loans Referee 1 Relationship")
            {
            }
            column(LoansReferee2Relationship_LoansRegister;"Loans Register"."Loans Referee 2 Relationship")
            {
            }
            column(LoansReferee1MobileNo_LoansRegister;"Loans Register"."Loans Referee 1 Mobile No.")
            {
            }
            column(LoansReferee2MobileNo_LoansRegister;"Loans Register"."Loans Referee 2 Mobile No.")
            {
            }
            column(LoansReferee1Address_LoansRegister;"Loans Register"."Loans Referee 1 Address")
            {
            }
            column(LoansReferee2Address_LoansRegister;"Loans Register"."Loans Referee 2 Address")
            {
            }
            column(LoansReferee1PhysicalAddre_LoansRegister;"Loans Register"."Loans Referee 1 Physical Addre")
            {
            }
            column(LoansReferee2PhysicalAddre_LoansRegister;"Loans Register"."Loans Referee 2 Physical Addre")
            {
            }
            column(LoantoAppeal_LoansRegister;"Loans Register"."Loan to Appeal")
            {
            }
            column(LoantoAppealApprovedAmount_LoansRegister;"Loans Register"."Loan to Appeal Approved Amount")
            {
            }
            column(LoantoAppealissuedDate_LoansRegister;"Loans Register"."Loan to Appeal issued Date")
            {
            }
            column(LoanAppeal_LoansRegister;"Loans Register"."Loan Appeal")
            {
            }
            column(DisbursedBy_LoansRegister;"Loans Register"."Disbursed By")
            {
            }
            column(MemberAccountCategory_LoansRegister;"Loans Register"."Member Account Category")
            {
            }
            column(MemberNotFound_LoansRegister;"Loans Register"."Member Not Found")
            {
            }
            column(LoantoReschedule_LoansRegister;"Loans Register"."Loan to Reschedule")
            {
            }
            column(Rescheduled_LoansRegister;"Loans Register".Rescheduled)
            {
            }
            column(LoanRescheduledDate_LoansRegister;"Loans Register"."Loan Rescheduled Date")
            {
            }
            column(LoanRescheduledBy_LoansRegister;"Loans Register"."Loan Rescheduled By")
            {
            }
            column(ReasonForLoanReschedule_LoansRegister;"Loans Register"."Reason For Loan Reschedule")
            {
            }
            column(LoanUnderDebtCollection_LoansRegister;"Loans Register"."Loan Under Debt Collection")
            {
            }
            column(LoanDebtCollector_LoansRegister;"Loans Register"."Loan Debt Collector")
            {
            }
            column(LoanDebtCollectorInterest_LoansRegister;"Loans Register"."Loan Debt Collector Interest %")
            {
            }
            column(DebtCollectiondateAssigned_LoansRegister;"Loans Register"."Debt Collection date Assigned")
            {
            }
            column(DebtCollectorName_LoansRegister;"Loans Register"."Debt Collector Name")
            {
            }
            column(GlobalDimension2Code_LoansRegister;"Loans Register"."Global Dimension 2 Code")
            {
            }
            column(Discard_LoansRegister;"Loans Register".Discard)
            {
            }
            column(Upraised_LoansRegister;"Loans Register".Upraised)
            {
            }
            column(PensionNo_LoansRegister;"Loans Register"."Pension No")
            {
            }
            column(LoanSeriesCount_LoansRegister;"Loans Register"."Loan Series Count")
            {
            }
            column(LoanAccountNo_LoansRegister;"Loans Register"."Loan Account No")
            {
            }
            column(Deductible_LoansRegister;"Loans Register".Deductible)
            {
            }
            column(OutstandingBalanceCapitalize_LoansRegister;"Loans Register"."Outstanding Balance-Capitalize")
            {
            }
            column(LastInterestDueDate_LoansRegister;"Loans Register"."Last Interest Due Date")
            {
            }
            column(AmountPayedOff_LoansRegister;"Loans Register"."Amount Payed Off")
            {
            }

            trigger OnAfterGetRecord()
            var
                LoanCode: Option Amortised,"Reducing Balance","Straight Line",Constants;
                Repayment: Decimal;
            begin
                   LoanRegister.Reset;
                   LoanRegister.SetRange(LoanRegister."Loan  No.","Loan  No.");
                   LoanRegister.SetRange(LoanRegister.Source,LoanRegister.Source::FOSA);
                   LoanRegister.SetRange(LoanRegister."Repayment Method",LoanRegister."repayment method"::"Straight Line");
                   LoanRegister.SetFilter(LoanRegister."Outstanding Balance",'>%1',0);
                  if LoanRegister.Find('-') then begin
                    repeat
                    /*
                      //UPDATING REPAYMENT TYPE
                      LoanProductList.RESET;
                    LoanProductList.SETRANGE(LoanProductList.Code,LoanRegister."Loan Product Type");
                    IF LoanProductList.FIND('-') THEN BEGIN
                        LoanCode:=LoanProductList."Repayment Method";
                        END;
                        LoanRegister."Repayment Method":=LoanCode;
                        */
                        Repayment:=ROUND(LoanRegister."Approved Amount"/LoanRegister.Installments,0.05,'>')+ROUND((LoanRegister.Interest/1200)*LoanRegister."Approved Amount",0.05,'>');
                        LoanRegister."Loan Principle Repayment":=ROUND(LoanRegister."Approved Amount"/LoanRegister.Installments,1,'>');
                        LoanRegister."Loan Interest Repayment":=ROUND((LoanRegister.Interest/1200)*LoanRegister."Approved Amount",1,'>');
                        //ERROR('Old repayment is %1 and New is %2 For Loan No %3 for Approved Amount of %4 for a Period of %5',LoanRegister.Repayment,Repayment,LoanRegister."Loan  No.",LoanRegister."Approved Amount",LoanRegister.Installments);
                        LoanRegister.Repayment:=Repayment;
                        LoanRegister.Modify;
                    until LoanRegister.Next=0;
                    end

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
        LoanProductList: Record "Loan Products Setup";
        LoanRegister: Record "Loans Register";
}

