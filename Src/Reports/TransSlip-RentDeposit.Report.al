#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516517 "Trans Slip - Rent Deposit"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Trans Slip - Rent Deposit.rdlc';

    dataset
    {
        dataitem(Transactions; Transactions)
        {
            DataItemTableView = sorting(No);
            RequestFilterFields = No;
            column(ReportForNavId_5806; 5806)
            {
            }
            column(No_Transactions; Transactions.No)
            {
            }
            column(AccountNo_Transactions; Transactions."Account No")
            {
            }
            column(NumberText_1_; NumberText[1])
            {
            }
            column(AccountName_Transactions; Transactions."Account Name")
            {
            }
            column(TransactionType_Transactions; Transactions."Transaction Type")
            {
            }
            column(Amount_Transactions; Transactions.Amount)
            {
            }
            column(Cashier_Transactions; Transactions.Cashier)
            {
            }
            column(TransactionDate_Transactions; Transactions."Transaction Date")
            {
            }
            column(TransactionTime_Transactions; Transactions."Time Posted")
            {
            }
            column(Posted_Transactions; Transactions.Posted)
            {
            }
            column(NoSeries_Transactions; Transactions."No. Series")
            {
            }
            column(AccountType_Transactions; Transactions."Account Type")
            {
            }
            column(AccountDescription_Transactions; Transactions."Account Description")
            {
            }
            column(DenominationTotal_Transactions; Transactions."Denomination Total")
            {
            }
            column(ChequeType_Transactions; Transactions."Cheque Type")
            {
            }
            column(ChequeNo_Transactions; Transactions."Cheque No")
            {
            }
            column(ChequeDate_Transactions; Transactions."Cheque Date")
            {
            }
            column(Payee_Transactions; Transactions.Payee)
            {
            }
            column(BankNo_Transactions; Transactions."Bank No")
            {
            }
            column(BranchNo_Transactions; Transactions."Branch No")
            {
            }
            column(ClearingCharges_Transactions; Transactions."Clearing Charges")
            {
            }
            column(ClearingDays_Transactions; Transactions."Clearing Days")
            {
            }
            column(Description_Transactions; Transactions.Description)
            {
            }
            column(BankName_Transactions; Transactions."Bank Name")
            {
            }
            column(BranchName_Transactions; Transactions."Branch Name")
            {
            }
            column(TransactionMode_Transactions; Transactions."Transaction Mode")
            {
            }
            column(Type_Transactions; Transactions.Type)
            {
            }
            column(TransactionDescription_Transactions; Transactions."Transaction Description")
            {
            }
            column(MinimumAccountBalance_Transactions; Transactions."Minimum Account Balance")
            {
            }
            column(FeeBelowMinimumBalance_Transactions; Transactions."Fee Below Minimum Balance")
            {
            }
            column(NormalWithdrawalCharge_Transactions; Transactions."Normal Withdrawal Charge")
            {
            }
            column(Authorised_Transactions; Transactions.Authorised)
            {
            }
            column(CheckedBy_Transactions; Transactions."Checked By")
            {
            }
            column(FeeonWithdrawalInterval_Transactions; Transactions."Fee on Withdrawal Interval")
            {
            }
            column(Remarks_Transactions; Transactions.Remarks)
            {
            }
            column(Status_Transactions; Transactions.Status)
            {
            }
            column(DatePosted_Transactions; Transactions."Date Posted")
            {
            }
            column(TimePosted_Transactions; Transactions."Time Posted")
            {
            }
            column(PostedBy_Transactions; Transactions."Posted By")
            {
            }
            column(ExpectedMaturityDate_Transactions; Transactions."Expected Maturity Date")
            {
            }
            column(Picture_Transactions; Transactions.Picture)
            {
            }
            column(CurrencyCode_Transactions; Transactions."Currency Code")
            {
            }
            column(TransactionCategory_Transactions; Transactions."Transaction Category")
            {
            }
            column(Deposited_Transactions; Transactions.Deposited)
            {
            }
            column(DateDeposited_Transactions; Transactions."Date Deposited")
            {
            }
            column(TimeDeposited_Transactions; Transactions."Time Deposited")
            {
            }
            column(DepositedBy_Transactions; Transactions."Deposited By")
            {
            }
            column(PostDated_Transactions; Transactions."Post Dated")
            {
            }
            column(Select_Transactions; Transactions.Select)
            {
            }
            column(StatusDate_Transactions; Transactions."Status Date")
            {
            }
            column(StatusTime_Transactions; Transactions."Status Time")
            {
            }
            column(SupervisorChecked_Transactions; Transactions."Supervisor Checked")
            {
            }
            column(BookBalance_Transactions; Transactions."Book Balance")
            {
            }
            column(NoticeNo_Transactions; Transactions."Notice No")
            {
            }
            column(NoticeCleared_Transactions; Transactions."Notice Cleared")
            {
            }
            column(ScheduleAmount_Transactions; Transactions."Schedule Amount")
            {
            }
            column(HasSchedule_Transactions; Transactions."Has Schedule")
            {
            }
            column(Requested_Transactions; Transactions.Requested)
            {
            }
            column(DateRequested_Transactions; Transactions."Date Requested")
            {
            }
            column(TimeRequested_Transactions; Transactions."Time Requested")
            {
            }
            column(RequestedBy_Transactions; Transactions."Requested By")
            {
            }
            column(Overdraft_Transactions; Transactions.Overdraft)
            {
            }
            column(ChequeProcessed_Transactions; Transactions."Cheque Processed")
            {
            }
            column(StaffPayrollNo_Transactions; Transactions."Staff/Payroll No")
            {
            }
            column(ChequeTransferred_Transactions; Transactions."Cheque Transferred")
            {
            }
            column(ExpectedAmount_Transactions; Transactions."Expected Amount")
            {
            }
            column(LineTotals_Transactions; Transactions."Line Totals")
            {
            }
            column(TransferDate_Transactions; Transactions."Transfer Date")
            {
            }
            column(BIHNo_Transactions; Transactions."BIH No")
            {
            }
            column(TransferNo_Transactions; Transactions."Transfer No")
            {
            }
            column(Attached_Transactions; Transactions.Attached)
            {
            }
            column(BOSAAccountNo_Transactions; Transactions."BOSA Account No")
            {
            }
            column(SalaryProcessing_Transactions; Transactions."Salary Processing")
            {
            }
            column(ExpenseAccount_Transactions; Transactions."Expense Account")
            {
            }
            column(ExpenseDescription_Transactions; Transactions."Expense Description")
            {
            }
            column(CompanyCode_Transactions; Transactions."Company Code")
            {
            }
            column(ScheduleType_Transactions; Transactions."Schedule Type")
            {
            }
            column(BankedBy_Transactions; Transactions."Banked By")
            {
            }
            column(DateBanked_Transactions; Transactions."Date Banked")
            {
            }
            column(TimeBanked_Transactions; Transactions."Time Banked")
            {
            }
            column(BankingPosted_Transactions; Transactions."Banking Posted")
            {
            }
            column(ClearedBy_Transactions; Transactions."Cleared By")
            {
            }
            column(DateCleared_Transactions; Transactions."Date Cleared")
            {
            }
            column(TimeCleared_Transactions; Transactions."Time Cleared")
            {
            }
            column(ClearingPosted_Transactions; Transactions."Clearing Posted")
            {
            }
            column(NeedsApproval_Transactions; Transactions."Needs Approval")
            {
            }
            column(IDType_Transactions; Transactions."ID Type")
            {
            }
            column(IDNo_Transactions; Transactions."ID No")
            {
            }
            column(ReferenceNo_Transactions; Transactions."Reference No")
            {
            }
            column(RefundCheque_Transactions; Transactions."Refund Cheque")
            {
            }
            column(Imported_Transactions; Transactions.Imported)
            {
            }
            column(ExternalAccountNo_Transactions; Transactions."External Account No")
            {
            }
            column(BOSATransactions_Transactions; Transactions."BOSA Transactions")
            {
            }
            column(BankAccount_Transactions; Transactions."Bank Account")
            {
            }
            column(SaversTotal_Transactions; Transactions."Savers Total")
            {
            }
            column(MustaafuTotal_Transactions; Transactions."Mustaafu Total")
            {
            }
            column(JuniorStarTotal_Transactions; Transactions."Junior Star Total")
            {
            }
            column(Printed_Transactions; Transactions.Printed)
            {
            }
            column(WithdrawalFrequencyAuthorised_Transactions; Transactions."Withdrawal FrequencyAuthorised")
            {
            }
            column(FrequencyNeedsApproval_Transactions; Transactions."Frequency Needs Approval")
            {
            }
            column(SpecialAdvanceNo_Transactions; Transactions."Special Advance No")
            {
            }
            column(BankersChequeType_Transactions; Transactions."Bankers Cheque Type")
            {
            }
            column(SuspendedAmount_Transactions; Transactions."Suspended Amount")
            {
            }
            column(TransferredByEFT_Transactions; Transactions."Transferred By EFT")
            {
            }
            column(BankingUser_Transactions; Transactions."Banking User")
            {
            }
            column(CompanyTextName_Transactions; Transactions."Company Text Name")
            {
            }
            column(DateFilter_Transactions; Transactions."Date Filter")
            {
            }
            column(TotalSalaries_Transactions; Transactions."Total Salaries")
            {
            }
            column(EFTTransferred_Transactions; Transactions."EFT Transferred")
            {
            }
            column(ATMTransactionsTotal_Transactions; Transactions."ATM Transactions Total")
            {
            }
            column(BankCode_Transactions; Transactions."Bank Code")
            {
            }
            column(ExternalAccountName_Transactions; Transactions."External Account Name")
            {
            }
            column(OverdraftLimit_Transactions; Transactions."Overdraft Limit")
            {
            }
            column(OverdraftAllowed_Transactions; Transactions."Overdraft Allowed")
            {
            }
            column(AvailableBalance_Transactions; Transactions."Available Balance")
            {
            }
            column(AuthorisationRequirement_Transactions; Transactions."Authorisation Requirement")
            {
            }
            column(BankersChequeNo_Transactions; Transactions."Bankers Cheque No")
            {
            }
            column(TransactionSpan_Transactions; Transactions."Transaction Span")
            {
            }
            column(UnclearedCheques_Transactions; Transactions."Uncleared Cheques")
            {
            }
            column(TransactionAvailableBalance_Transactions; Transactions."Transaction Available Balance")
            {
            }
            column(BranchAccount_Transactions; Transactions."Branch Account")
            {
            }
            column(BranchTransaction_Transactions; Transactions."Branch Transaction")
            {
            }
            column(FOSABranchName_Transactions; Transactions."FOSA Branch Name")
            {
            }
            column(BranchRefference_Transactions; Transactions."Branch Refference")
            {
            }
            column(BranchAccountNo_Transactions; Transactions."Branch Account No")
            {
            }
            column(BranchTransactionDate_Transactions; Transactions."Branch Transaction Date")
            {
            }
            column(PostAttempted_Transactions; Transactions."Post Attempted")
            {
            }
            column(TransactingBranch_Transactions; Transactions."Transacting Branch")
            {
            }
            column(Signature_Transactions; Transactions.Signature)
            {
            }
            column(AllocatedAmount_Transactions; Transactions."Allocated Amount")
            {
            }
            column(AmountDiscounted_Transactions; Transactions."Amount Discounted")
            {
            }
            column(DontClear_Transactions; Transactions."Dont Clear")
            {
            }
            column(OtherBankersNo_Transactions; Transactions."Other Bankers No.")
            {
            }
            column(NAHBalance_Transactions; Transactions."N.A.H Balance")
            {
            }
            column(ChequeDepositRemarks_Transactions; Transactions."Cheque Deposit Remarks")
            {
            }
            column(BalancingAccount_Transactions; Transactions."Balancing Account")
            {
            }
            column(BalancingAccountName_Transactions; Transactions."Balancing Account Name")
            {
            }
            column(BankersChequePayee_Transactions; Transactions."Bankers Cheque Payee")
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(CompanyInfo_Address; CompanyInfo.Address)
            {
            }
            dataitem("Transaction Charges"; "Transaction Charges")
            {
                DataItemLink = "Transaction Type" = field("Transaction Type");
                column(ReportForNavId_8541; 8541)
                {
                }
                column(Transaction_Charges_Description; Description)
                {
                }
                column(Transaction_Charges__Charge_Amount_; "Charge Amount")
                {
                }
                column(Transaction_Charges_Transaction_Type; "Transaction Type")
                {
                }
                column(Transaction_Charges_Charge_Code; "Charge Code")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin

                ATMBalance := 0;

                //"Transactions 1".CALCFIELDS("Transactions 1"."Book Balance");

                LoanGuaranteed := 0;
                UnClearedBalance := 0;
                TotalGuaranted := 0;

                TransactionCharges.Reset;
                TransactionCharges.SetRange(TransactionCharges."Transaction Type", "Transaction Type");

                TCharges := 0;
                AvailableBalance := 0;
                MinAccBal := 0;

                //CALCFIELDS("Book Balance");

                AccountTypes.Reset;
                AccountTypes.SetRange(AccountTypes.Code, "Account Type");

                if AccountTypes.Find('-') then begin
                    MinAccBal := AccountTypes."Minimum Balance";
                    FeeBelowMinBal := AccountTypes."Fee Below Minimum Balance";
                end;

                if Posted = false then begin

                    if TransactionCharges.Find('-') then
                        repeat

                            ////////
                            if TransactionCharges."Use Percentage" = true then begin
                                if TransactionCharges."Percentage of Amount" = 0 then
                                    Error('Percentage of amount cannot be zero.');
                                //USE BOOK BALANCE FOR ESTIMATING PERCENTAGE OF AMOUNT
                                TCharges := TCharges + (TransactionCharges."Percentage of Amount" / 100) * "Book Balance";
                                //TCharges:=TCharges+(TransactionCharges."Percentage of Amount"/100)*Amount;
                            end
                            else begin
                                TCharges := TCharges + TransactionCharges."Charge Amount";
                            end;
                        /////////

                        //TCharges:=TCharges+TransactionCharges."Charge Amount";

                        until TransactionCharges.Next = 0;

                    TransactionCharges.Reset;

                    ///// CHECK LAST WITHDRAWAL DATE AND FIND IF CHARGE IS APPLICABLE AND CHARGE
                    IntervalPenalty := 0;
                    Members.Reset;
                    if Members.Get("Account No") then begin

                        if Members.Status <> Members.Status::New then begin

                            if Type = 'Withdrawal' then begin

                                AccountTypes.Reset;
                                AccountTypes.SetRange(AccountTypes.Code, "Account Type");

                                if AccountTypes.Find('-') then begin

                                    if CalcDate(AccountTypes."Withdrawal Interval", Members."Last Withdrawal Date") > Today then begin
                                        IntervalPenalty := AccountTypes."Withdrawal Penalty";
                                    end;
                                end;
                            end;
                        end;
                    end;

                    //////////////



                    /////////////
                    //FIXED DEPOSIT

                    ChargesOnFD := 0;

                    Members.Reset;
                    if Members.Get("Account No") then begin

                        AccountTypes.Reset;
                        if AccountTypes.Get(Members."Account Type") then begin
                            if AccountTypes."Fixed Deposit" = true then begin

                                if Members."Expected Maturity Date" > Today then begin
                                    ChargesOnFD := AccountTypes."Charge Closure Before Maturity";
                                end;

                            end;
                        end;


                    end;

                    Members.Reset;

                    ///////////

                end;


                //UNCLEARED CHEQUES
                chqtransactions.Reset;
                chqtransactions.SetRange(chqtransactions."Account No", "Account No");
                chqtransactions.SetRange(chqtransactions.Deposited, true);
                chqtransactions.SetRange(chqtransactions."Cheque Processed", false);

                if chqtransactions.Find('-') then begin

                    repeat

                        TotalUnprocessed := TotalUnprocessed + chqtransactions.Amount;

                    until chqtransactions.Next = 0;

                end;


                //ATM BALANCE
                AccountHolders.Reset;
                AccountHolders.SetRange(AccountHolders."No.", "Account No");
                if AccountHolders.Find('-') then begin
                    //AccountHolders.CALCFIELDS(AccountHolders."ATM Transactions");
                    ATMBalance := AccountHolders."ATM Transactions";
                end;

                if LoanGuaranteed < 0 then
                    LoanGuaranteed := 0;

                if UnClearedBalance < 0 then
                    UnClearedBalance := 0;

                AccountTypes.Reset;
                if AccountTypes.Get("Account Type") then begin
                    if AccountTypes."Fixed Deposit" = false then begin
                        if "Book Balance" < MinAccBal then
                            AvailableBalance := "Book Balance" - FeeBelowMinBal - TCharges - IntervalPenalty - MinAccBal - TotalUnprocessed - ATMBalance
                        else
                            AvailableBalance := "Book Balance" - TCharges - IntervalPenalty - MinAccBal - TotalUnprocessed - ATMBalance;

                    end else
                        AvailableBalance := "Book Balance" - TCharges - ChargesOnFD;
                end;

                //AvailableBalance:=AvailableBalance-Transactions.Amount;

                if Account.Get(Transactions."Account No") then begin
                    Account.CalcFields(Account."Balance (LCY)");
                    AvailableBalance := Account."Balance (LCY)" - 1000;

                end;


                vatTotalHolder := Transactions.Amount;

                TillNo := '';
                TellerTill.Reset;
                TellerTill.SetRange(TellerTill."Cashier ID", Transactions.Cashier);
                if TellerTill.Find('-') then begin
                    TillNo := TellerTill."No.";
                end;
                CheckReport.InitTextVariable();
                CheckReport.FormatNoText(NumberText, Amount, ' ');
            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.Get();
                CompanyInfo.CalcFields(CompanyInfo.Picture);
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
        Account: Record Vendor;
        LoanBalance: Decimal;
        AvailableBalance: Decimal;
        UnClearedBalance: Decimal;
        LoanSecurity: Decimal;
        LoanGuaranteed: Decimal;
        GenJournalLine: Record "Gen. Journal Line";
        DefaultBatch: Record "Gen. Journal Batch";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        window: Dialog;
        Members: Record Vendor;
        TransactionTypes: Record "Transaction Type";
        TransactionCharges: Record "Transaction Charges";
        TCharges: Decimal;
        LineNo: Integer;
        AccountTypes: Record "Account Types-Saving Products";
        GenLedgerSetup: Record "General Ledger Setup";
        MinAccBal: Decimal;
        FeeBelowMinBal: Decimal;
        AccountNo: Code[30];
        NewAccount: Boolean;
        CurrentTellerAmount: Decimal;
        TellerTill: Record "Bank Account";
        IntervalPenalty: Decimal;
        StandingOrders: Record "Standing Orders";
        AccountAmount: Decimal;
        STODeduction: Decimal;
        Charges: Record Charges;
        "Total Deductions": Decimal;
        STODeductedAmount: Decimal;
        NoticeAmount: Decimal;
        AccountNotices: Record "Account Notices";
        Cust: Record Customer;
        AccountHolders: Record Vendor;
        ChargesOnFD: Decimal;
        TotalGuaranted: Decimal;
        VarAmtHolder: Decimal;
        vatTotalHolder: Decimal;
        chqtransactions: Record Transactions;
        TotalUnprocessed: Decimal;
        ATMBalance: Decimal;
        TillNo: Code[20];
        CompanyInfo: Record "Company Information";
        DUPLICATECaptionLbl: label 'DUPLICATE';
        Amount_received__CaptionLbl: label 'Amount received :';
        Account_Name_CaptionLbl: label 'Account Name:';
        Account_No_CaptionLbl: label 'Account No:';
        Member_No_CaptionLbl: label 'Member No:';
        Time_CaptionLbl: label 'Time:';
        Date_CaptionLbl: label 'Date:';
        Transaction_No_CaptionLbl: label 'Transaction No.';
        Deposited_By_______________________________________CaptionLbl: label 'Deposited By :.....................................';
        You_were_served_by__CaptionLbl: label 'You were served by :';
        THANK_YOUCaptionLbl: label 'THANK YOU';
        Better_life_for_our_members_globallyCaptionLbl: label 'Better life for our members globally';
        NumberText: array[2] of Text[80];
        LastFieldNo: Integer;
        CheckReport: Report Check;
        GenSetUp: Record "Sacco General Set-Up";
        SFactory: Codeunit "SURESTEP Factory";


    procedure CalAvailableBal()
    begin

        ATMBalance := 0;

        TCharges := 0;
        AvailableBalance := 0;
        MinAccBal := 0;
        TotalUnprocessed := 0;
        IntervalPenalty := 0;


        if Account.Get(Transactions."Account No") then begin
            Account.CalcFields(Account.Balance);

            AccountTypes.Reset;
            AccountTypes.SetRange(AccountTypes.Code, Transactions."Account Type");
            if AccountTypes.Find('-') then begin
                MinAccBal := AccountTypes."Minimum Balance";
                FeeBelowMinBal := AccountTypes."Fee Below Minimum Balance";


                //Check Withdrawal Interval
                if Account.Status <> Account.Status::New then begin
                    if Transactions.Type = 'Withdrawal' then begin
                        AccountTypes.Reset;
                        AccountTypes.SetRange(AccountTypes.Code, Transactions."Account Type");
                        if Account."Last Withdrawal Date" <> 0D then begin
                            if CalcDate(AccountTypes."Withdrawal Interval", Account."Last Withdrawal Date") > Today then
                                IntervalPenalty := AccountTypes."Withdrawal Penalty";
                        end;
                    end;
                    //Check Withdrawal Interval

                    //Fixed Deposit
                    ChargesOnFD := 0;
                    if AccountTypes."Fixed Deposit" = true then begin
                        if Account."Expected Maturity Date" > Today then
                            ChargesOnFD := AccountTypes."Charge Closure Before Maturity";
                    end;
                    //Fixed Deposit

                    //Current Charges
                    TransactionCharges.Reset;
                    TransactionCharges.SetRange(TransactionCharges."Transaction Type", Transactions."Transaction Type");
                    if TransactionCharges.Find('-') then begin
                        repeat
                            if TransactionCharges."Use Percentage" = true then begin
                                TransactionCharges.TestField("Percentage of Amount");
                                TCharges := TCharges + (TransactionCharges."Percentage of Amount" / 100) * Transactions."Book Balance";
                            end else begin
                                TCharges := TCharges + TransactionCharges."Charge Amount";
                            end;
                        until TransactionCharges.Next = 0;
                    end;


                    TotalUnprocessed := Account."Uncleared Cheques";
                    ATMBalance := Account."ATM Transactions";

                    //FD
                    if AccountTypes."Fixed Deposit" = false then begin
                        if Account.Balance < MinAccBal then
                            AvailableBalance := Account.Balance - FeeBelowMinBal - TCharges - IntervalPenalty - MinAccBal - TotalUnprocessed - ATMBalance
                        else
                            AvailableBalance := Account.Balance - TCharges - IntervalPenalty - MinAccBal - TotalUnprocessed - ATMBalance;
                    end else begin
                        AvailableBalance := Account.Balance - TCharges - ChargesOnFD;
                    end;
                end;
                //FD

            end;
        end;
    end;
}

