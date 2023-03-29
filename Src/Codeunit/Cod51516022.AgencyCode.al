#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 51516022 "AgencyCode"
{

    trigger OnRun()
    begin
        Message(Format(PostBranchAgentTransaction('760104371813586')));
        //MESSAGE(FORMAT(GetAccountBalance('BANK_120124')));
        //MESSAGE(GetAccounts('28448819'));
        //MESSAGE(GetAccountInfo('030-330-00072'));
        //MESSAGE(GetAgentAccount('NAC00001'));
        //MESSAGE(GetAccountExist('287','MEMBER'));
        //MESSAGE(AgencyRegistration());
    end;

    var
        Vendor: Record Vendor;
        SavingsProdAccTypes: Record "Account Types-Saving Products";
        AgentApps: Record "Agent Applications";
        AgentTransactions: Record "Agent Transactions";
        LoansRegister: Record "Loans Register";
        accBalance: Decimal;
        VendorLedgEntry: Record "Vendor Ledger Entry";
        amount: Decimal;
        minimunCount: Integer;
        AccountTypes: Record "Account Types-Saving Products";
        miniBalance: Decimal;
        Loans: Integer;
        LoanProductsSetup: Record "Loan Products Setup";
        Members: Record "Member Register";
        dateExpression: Text[20];
        DetailedVendorLedgerEntry: Record "Detailed Vendor Ledg. Entry";
        dashboardDataFilter: Date;
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        MemberLedgerEntry: Record "Member Ledger Entry";
        GenJournalLine: Record "Gen. Journal Line";
        GenBatches: Record "Gen. Journal Batch";
        LineNo: Integer;
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        GenLedgerSetup: Record "General Ledger Setup";
        TariffHeader: Record "Agency Tariff Header";
        TariffDetails: Record "Agent Tariff Details";
        commAgent: Decimal;
        commVendor: Decimal;
        commSacco: Decimal;
        TotalCommission: Decimal;
        CloudPESACommACC: Text[20];
        AgentChargesAcc: Text[20];
        GLAccount: Record "G/L Account";
        WithdrawalLimit: Record "Agent Withdrawal Limits";
        SMSMessages: Record "SMS Messages";
        iEntryNo: Integer;
        ExxcDuty: label '20042';
        ExcDuty: Decimal;
        BlockedStatus: Boolean;
        BankAccount: Record "Bank Account Ledger Entry";
        objRegMember: Record "Membership Applications";
        registrationup: Boolean;
        objNewAccount: Record "FOSA Account Applicat. Details";
        Dates: Codeunit "Dates Calculation";


    procedure GetAccountType(accountNo: Text[100]) accountType: Text[100]
    begin
        begin
          Vendor.Reset;
          Vendor.SetRange(Vendor."No.",accountNo);
          if Vendor.Find('-') then begin
          accountType:=Vendor."Account Type";
          end
          else
          begin
          accountType:='';
          end
        end;
    end;


    procedure GetMinimumBal(accountType: Text[100]) minBalance: Decimal
    begin
        begin
          SavingsProdAccTypes.Reset;
          SavingsProdAccTypes.SetRange(SavingsProdAccTypes.Code,accountType);
          if SavingsProdAccTypes.Find('-') then begin
          minBalance:=SavingsProdAccTypes."Minimum Balance";
          end
          else
          begin
          minBalance:=0.0;
          end
        end;
    end;


    procedure GetAgentAccount("code": Code[20]) account: Text[100]
    begin
        begin
          AgentApps.Reset;
          AgentApps.SetRange(AgentApps."Agent Code",code);
          AgentApps.SetRange(AgentApps.Status,AgentApps.Status::Approved);
          if AgentApps.Find('-') then begin
          account:=AgentApps.Account+':::'+Format(AgentApps.Branch)+':::'+Format(Abs(GetAccountBalance(AgentApps.Account)));
          end
          else
          begin
          account:='';
          end
        end;
    end;


    procedure GetAccounts(idNumber: Text[50]) accounts: Text[1000]
    begin
        begin
          Vendor.Reset;
          Vendor.SetRange(Vendor."ID No.",idNumber);
          Vendor.SetRange(Vendor.Blocked,0);
          Vendor.SetFilter(Vendor.Status, '%1|%2',0,4);
          if Vendor.Find('-') then begin
          accounts:='';
          repeat
            AccountTypes.Reset;
        AccountTypes.SetRange(AccountTypes.Code,Vendor."Account Type")  ;
        if AccountTypes.Find('-') then
            begin
              miniBalance:=AccountTypes."Minimum Balance";
              end;
            Vendor.CalcFields(Vendor."Balance (LCY)");
            Vendor.CalcFields(Vendor."ATM Transactions");
            Vendor.CalcFields(Vendor."Uncleared Cheques");
            Vendor.CalcFields(Vendor."EFT Transactions");
            accBalance:=Vendor."Balance (LCY)"-(Vendor."ATM Transactions"+Vendor."Uncleared Cheques"+Vendor."EFT Transactions"+miniBalance);
          accounts:=accounts+'-:-'+Vendor."No."+':::'+Vendor.Name+':::'+Vendor."Account Type"+':::'+Vendor."Phone No."+':::'+
          Format(accBalance);
          until Vendor.Next =0;
          end
          else
          begin
          accounts:='none';
          end
        end;
    end;


    procedure InsertAgencyTransaction(docNo: Code[20];transDate: Date;accNo: Code[50];description: Text[220];amount: Decimal;posted: Boolean;transTime: DateTime;balAccNo: Code[30];docDate: Date;datePosted: Date;timePosted: Time;accStatus: Text[30];messages: Text[400];needsChange: Boolean;changeTransNo: Code[20];oldAccNo: Code[50];changed: Boolean;dateChanged: Date;timeChanged: Time;changedBy: Code[10];approvedBy: Code[10];originalAccNo: Code[50];accBal: Decimal;branchCode: Code[10];activityCode: Code[30];globalDim1Filter: Code[20];globalDim2Filter: Code[20];accNo2: Text[20];ccode: Code[20];transLocation: Text[30];transBy: Text[30];agentCode: Code[20];loanNo: Code[20];accName: Text[30];telephone: Text[20];idNo: Code[20];branch: Text[30];memberNo: Code[20];transType: Integer;dob: Date;address: Code[100];physicalAddress: Code[100];postalCode: Code[50];residence: Code[100]) result: Text[20]
    begin
        AgentTransactions.SetRange(AgentTransactions."Document No.",docNo);
        //AgentTransactions.SETRANGE(AgentTransactions.Description,description);
        //AgentTransactions.SETRANGE(AgentTransactions."Transaction Date",transDate);
        if AgentTransactions.Find('-') then begin
        result:= 'exists';
        end
        else
              begin

             AgentApps.Reset;
             AgentApps.SetRange(AgentApps."Agent Code",agentCode);
             if AgentApps.Find('-') then begin
              AgentTransactions.Init;
              AgentTransactions."Document No.":=docNo;
              AgentTransactions."Transaction Date":=transDate;
              AgentTransactions."Account No.":=accNo;
              if transType=14 then begin
              AgentTransactions."Transaction Type":=transType;
             // AgentTransactions.Description:='Xmas Contribution';
              end else begin
                AgentTransactions."Transaction Type":=transType;
              AgentTransactions.Description:=description;
              end;
              if transType=24 then
              AgentTransactions."Transaction Type":=AgentTransactions."transaction type"::MemberRegistration;
              AgentTransactions.Amount:=amount;
              AgentTransactions.Posted:=posted;
              AgentTransactions."Transaction Time":=transTime;
              AgentTransactions."Bal. Account No.":=balAccNo;
              AgentTransactions."Document Date":=docDate;
              AgentTransactions."Date Posted":=datePosted;
              AgentTransactions."Time Posted":=timePosted;
              AgentTransactions."Account Status":=accStatus;
              AgentTransactions.Messages:=messages;
              AgentTransactions."Needs Change":=needsChange;
              AgentTransactions."Old Account No":=oldAccNo;
              AgentTransactions.Changed:=changed;
              AgentTransactions."Date Changed":=dateChanged;
              AgentTransactions."Time Changed":=timeChanged;
              AgentTransactions."Changed By":=changedBy;
              AgentTransactions."Approved By":=approvedBy;
              AgentTransactions."Original Account No":=originalAccNo;
              AgentTransactions."Branch Code":=branchCode;
              AgentTransactions."Activity Code":=activityCode;
              AgentTransactions."Global Dimension 1 Filter":=globalDim1Filter;
              AgentTransactions."Global Dimension 2 Filter":=globalDim2Filter;
              AgentTransactions."Account No 2":=accNo2;
              AgentTransactions.CCODE:=ccode;
              AgentTransactions."Transaction Location":=AgentApps."Place of Business";
              AgentTransactions."Transaction By":=AgentApps."Name of the Proposed Agent";
              AgentTransactions."Agent Code":=agentCode;
              AgentTransactions."Loan No":=loanNo;
              AgentTransactions."Account Name":=accName;
              AgentTransactions.Telephone:=telephone;
              AgentTransactions."Id No":=idNo;
              AgentTransactions.Branch:=branch;
              AgentTransactions."Date of Birth":=dob;
              AgentTransactions.Address:=address;
              AgentTransactions."Physical Address":=physicalAddress;
              AgentTransactions."Postal Code":=postalCode;
              AgentTransactions."Place of Residence":=residence;
              AgentTransactions."Member No":='';
              AgentTransactions.Insert;

              //AgentTransactions.RESET;
              //AgentTransactions.SETRANGE(AgentTransactions."Document No.",docNo);
              //IF AgentTransactions.FIND('-') THEN BEGIN
               // AgentTransactions.Description:=AgentTransactions."Transaction Type"
               // AgentTransactions.MODIFY;
                 result:='completed';
                 end;
             // END;



              end
    end;


    procedure GetAccountInfo(accountNo: Code[20]) reslt: Text[200]
    begin
        begin
          Vendor.Reset;
          Vendor.SetRange(Vendor."No.",accountNo);
          Vendor.SetRange(Vendor.Blocked,0);
          Vendor.SetFilter(Vendor.Status, '%1|%2',0,4);
          if Vendor.Find('-') then begin
          reslt:=Vendor."No."+':::'+Vendor.Name+':::'+Vendor."Account Type"+':::'+Vendor."Phone No.";
          end
          else
          begin
          reslt:='none';
          end
        end;
    end;


    procedure GetLoans(idNumber: Code[20]) loans: Text[1000]
    begin
        begin
          Vendor.Reset;
          Vendor.SetRange(Vendor."ID No.",idNumber);
              if Vendor.Find('-') then begin
                LoansRegister.Reset;
                LoansRegister.SetRange(LoansRegister."Client Code",Vendor."BOSA Account No");
                if LoansRegister.Find('-') then begin
                repeat
                  LoansRegister.CalcFields(LoansRegister."Outstanding Balance",LoansRegister."Interest Due",LoansRegister."Oustanding Interest",LoansRegister."Interest Paid");
                  if (LoansRegister."Outstanding Balance">0)or(LoansRegister."Oustanding Interest">0) then
                  loans:= loans + '-:-' + LoansRegister."Loan  No."+':::' + LoansRegister."Loan Product Type"+':::'+LoansRegister."Loan Product Type"+':::'+Format(LoansRegister.Source)+
                  ':::'+Format(LoansRegister."Outstanding Balance"+LoansRegister."Oustanding Interest") ;;
                until LoansRegister.Next = 0;
                end;
          end
        end;
    end;


    procedure GetMiniStatement(account: Code[20]) Statement: Text[500]
    begin
          begin
            VendorLedgEntry.Reset;
            VendorLedgEntry.SetCurrentkey(VendorLedgEntry."Entry No.");
            VendorLedgEntry.Ascending(false);
            VendorLedgEntry.SetRange(VendorLedgEntry."Vendor No.",account);
            VendorLedgEntry.SetRange(VendorLedgEntry.Reversed,VendorLedgEntry.Reversed::"0");
              if VendorLedgEntry.Find('-') then begin
                Statement:='';
                repeat
                  VendorLedgEntry.CalcFields(VendorLedgEntry.Amount);
                  amount:=VendorLedgEntry.Amount;
                  if amount<1 then
                  amount:= amount*-1;
                  Statement :=Statement + Format(VendorLedgEntry."Posting Date") +'-'+ VendorLedgEntry.Description +'-KSH ' +
                  Format(amount)+':::';
                  minimunCount:= minimunCount +1;
                  if   minimunCount>4 then
                  exit
                until VendorLedgEntry.Next =0
              end
          end;
    end;


    procedure PostAgentTransaction(transID: Code[30]) res: Boolean
    begin
        AgentTransactions.Reset;
        AgentTransactions.SetRange(AgentTransactions."Document No.",transID);
        AgentTransactions.SetRange(AgentTransactions.Posted,false);

        if AgentTransactions.Find('-') then begin
          BlockedStatus:=Blocked(AgentTransactions."Account No.");
           if (BlockedStatus=false) or (AgentTransactions."Transaction Type"=AgentTransactions."transaction type"::Deposit) then begin
            TariffHeader.Reset();
            TariffHeader.SetRange(TariffHeader."Trans Type",AgentTransactions."Transaction Type");
            if TariffHeader.FindFirst then
               begin
                TariffDetails.Reset();
                TariffDetails.SetRange(TariffDetails.Code,TariffHeader.Code);
                if TariffDetails.FindFirst then
                begin
                    commAgent := TariffDetails."Agent Comm";
                    commVendor := TariffDetails."Vendor Comm";
                    commSacco := TariffDetails."Sacco Comm" ;
                    TotalCommission:=commAgent+commVendor+commSacco;
                  end;//Tariff Details
               end;//Tariff Header

                 ExcDuty:=10/100*TotalCommission;

                if (AgentTransactions."Transaction Type" = AgentTransactions."transaction type"::Deposit) then
                  begin
                    AgentTransactions.Amount :=AgentTransactions.Amount*-1;
                  end;

                AgentApps.Reset;
                AgentApps.SetRange(AgentApps."Agent Code", AgentTransactions."Agent Code");
                if AgentApps.Find('-')
                  then begin
                        GenLedgerSetup.Reset;
                        GenLedgerSetup.Get;
                        GenLedgerSetup.TestField(GenLedgerSetup."Mobile Charge");
                        CloudPESACommACC:=  GenLedgerSetup."CloudPESA Comm Acc";
                        AgentChargesAcc:= GenLedgerSetup."Agent Charges Account";

                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name",'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name",'Agency');
                        GenJournalLine.DeleteAll;
                        //end of deletion

                        GenBatches.Reset;
                        GenBatches.SetRange(GenBatches."Journal Template Name",'GENERAL');
                        GenBatches.SetRange(GenBatches.Name,'Agency');

                        if GenBatches.Find('-') = false then begin
                            GenBatches.Init;
                            GenBatches."Journal Template Name":='GENERAL';
                            GenBatches.Name:='Agency';
                            GenBatches.Description:='Agency Transactions';
                            GenBatches.Validate(GenBatches."Journal Template Name");
                            GenBatches.Validate(GenBatches.Name);
                            GenBatches.Insert;
                        end;//General Jnr Batches
                        case AgentTransactions."Transaction Type" of
                        AgentTransactions."transaction type"::Withdrawal,
                        AgentTransactions."transaction type"::Deposit,
                        AgentTransactions."transaction type"::Transfer:
                          begin
                          Vendor.Reset;
                          Vendor.SetRange(Vendor."No.", AgentTransactions."Account No.");
                          if Vendor.Find('-') then begin

                        if (AgentTransactions."Transaction Type"=AgentTransactions."transaction type"::Transfer) then begin

                          //Debit Member Account 1
                            LineNo:=LineNo+10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name":='GENERAL';
                            GenJournalLine."Journal Batch Name":='Agency';
                            GenJournalLine."Line No.":=LineNo;
                            GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                            GenJournalLine."Account No.":=AgentTransactions."Account No.";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No.":=AgentTransactions."Document No.";
                            GenJournalLine."External Document No.":=AgentApps."Agent Code";
                            GenJournalLine."Posting Date":=AgentTransactions."Transaction Date";
                            GenJournalLine.Description:=AgentTransactions.Description;
                            GenJournalLine.Amount:=AgentTransactions.Amount;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Shortcut Dimension 1 Code":=Vendor."Global Dimension 1 Code";
                            GenJournalLine."Shortcut Dimension 2 Code":=Vendor."Global Dimension 2 Code";
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount<>0 then
                            GenJournalLine.Insert;

                           //Debit/Credit account 2

                            LineNo:=LineNo+10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name":='GENERAL';
                            GenJournalLine."Journal Batch Name":='Agency';
                            GenJournalLine."Line No.":=LineNo;
                            GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                            GenJournalLine."Account No.":=AgentTransactions."Account No 2";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No.":=AgentTransactions."Document No.";
                            GenJournalLine."External Document No.":=AgentApps."Agent Code";
                            GenJournalLine."Posting Date":=AgentTransactions."Transaction Date";
                            GenJournalLine.Description:=AgentTransactions.Description;
                            GenJournalLine.Amount:=AgentTransactions.Amount *-1;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Shortcut Dimension 1 Code":=Vendor."Global Dimension 1 Code";
                            GenJournalLine."Shortcut Dimension 2 Code":=Vendor."Global Dimension 2 Code";
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount<>0 then
                            GenJournalLine.Insert;//End of Transfer
                            end
                            else begin
                            //Debit Member Account 1
                            LineNo:=LineNo+10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name":='GENERAL';
                            GenJournalLine."Journal Batch Name":='Agency';
                            GenJournalLine."Line No.":=LineNo;
                            GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                            GenJournalLine."Account No.":=AgentTransactions."Account No.";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No.":=AgentTransactions."Document No.";
                            GenJournalLine."External Document No.":=AgentApps."Agent Code";
                            GenJournalLine."Posting Date":=AgentTransactions."Transaction Date";
                            GenJournalLine.Description:=AgentTransactions.Description;
                            GenJournalLine.Amount:=AgentTransactions.Amount;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Shortcut Dimension 1 Code":=Vendor."Global Dimension 1 Code";
                            GenJournalLine."Shortcut Dimension 2 Code":=Vendor."Global Dimension 2 Code";
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount<>0 then
                            GenJournalLine.Insert;

        //Debit/CreditAgent

                            LineNo:=LineNo+10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name":='GENERAL';
                            GenJournalLine."Journal Batch Name":='Agency';
                            GenJournalLine."Line No.":=LineNo;
                            GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                            GenJournalLine."Account No.":=AgentApps.Account;
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No.":=AgentTransactions."Document No.";
                            GenJournalLine."External Document No.":=AgentApps."Agent Code";
                            GenJournalLine."Posting Date":=AgentTransactions."Transaction Date";
                            GenJournalLine.Description:=AgentTransactions.Description;
                            GenJournalLine.Amount:=AgentTransactions.Amount *-1;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Shortcut Dimension 1 Code":=Vendor."Global Dimension 1 Code";
                            GenJournalLine."Shortcut Dimension 2 Code":=Vendor."Global Dimension 2 Code";
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount<>0 then
                            GenJournalLine.Insert;
                            end;



                       // IF (AgentTransactions."Transaction Type"<>AgentTransactions."Transaction Type"::Deposit) THEN BEGIN
                            //Cr Vendor-Surestep
                           LineNo:=LineNo+10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name":='GENERAL';
                            GenJournalLine."Journal Batch Name":='Agency';
                            GenJournalLine."Line No.":=LineNo;
                            GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                            GenJournalLine."Account No.":=CloudPESACommACC;
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No.":=AgentTransactions."Document No.";
                            GenJournalLine."External Document No.":=AgentApps."Agent Code";
                            GenJournalLine."Posting Date":=AgentTransactions."Transaction Date";
                            GenJournalLine.Description:='Agency Banking Charges';
                            GenJournalLine.Amount:=-1*commVendor;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Shortcut Dimension 1 Code":=Vendor."Global Dimension 1 Code";
                            GenJournalLine."Shortcut Dimension 2 Code":=Vendor."Global Dimension 2 Code";
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount<>0 then
                            GenJournalLine.Insert;
                            //CALCDATE(-1M,TODAY);
          //Cr Sacco
                           LineNo:=LineNo+10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name":='GENERAL';
                            GenJournalLine."Journal Batch Name":='Agency';
                            GenJournalLine."Line No.":=LineNo;
                            GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                            GenJournalLine."Account No.":=AgentChargesAcc;
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No.":=AgentTransactions."Document No.";
                            GenJournalLine."External Document No.":=AgentApps."Agent Code";
                            GenJournalLine."Posting Date":=AgentTransactions."Transaction Date";
                            GenJournalLine.Description:='Agency Banking Charges';
                            GenJournalLine.Amount:=-1*commSacco;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Shortcut Dimension 1 Code":=Vendor."Global Dimension 1 Code";
                            GenJournalLine."Shortcut Dimension 2 Code":=Vendor."Global Dimension 2 Code";
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount<>0 then
                            GenJournalLine.Insert;

                            //Cr Agent Commision Acc
                            LineNo:=LineNo+10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name":='GENERAL';
                            GenJournalLine."Journal Batch Name":='Agency';
                            GenJournalLine."Line No.":=LineNo;
                            GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                            GenJournalLine."Account No.":=AgentApps."Comm Account";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No.":=AgentTransactions."Document No.";
                            GenJournalLine."External Document No.":=AgentApps."Agent Code";
                            GenJournalLine."Posting Date":=AgentTransactions."Transaction Date";
                            GenJournalLine.Description:='Agency Banking Charges';
                            GenJournalLine.Amount:=-1*commAgent;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Shortcut Dimension 1 Code":=Vendor."Global Dimension 1 Code";
                            GenJournalLine."Shortcut Dimension 2 Code":=Vendor."Global Dimension 2 Code";
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount<>0 then
                            GenJournalLine.Insert;

                            //Cr Excise Duty
                            LineNo:=LineNo+10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name":='GENERAL';
                            GenJournalLine."Journal Batch Name":='Agency';
                            GenJournalLine."Line No.":=LineNo;
                            GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                            GenJournalLine."Account No.":=ExxcDuty;
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No.":=AgentTransactions."Document No.";
                            GenJournalLine."External Document No.":=AgentApps."Agent Code";
                            GenJournalLine."Posting Date":=AgentTransactions."Transaction Date";
                            GenJournalLine.Description:='Excise Duty-Agency Charges';
                            GenJournalLine.Amount:=-1*ExcDuty;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Shortcut Dimension 1 Code":=Vendor."Global Dimension 1 Code";
                            GenJournalLine."Shortcut Dimension 2 Code":=Vendor."Global Dimension 2 Code";
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount<>0 then
                            GenJournalLine.Insert;

                            //Dr Customer
                            LineNo:=LineNo+10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name":='GENERAL';
                            GenJournalLine."Journal Batch Name":='Agency';
                            GenJournalLine."Line No.":=LineNo;
                            GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                            GenJournalLine."Account No.":=AgentTransactions."Account No.";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No.":=AgentTransactions."Document No.";
                            GenJournalLine."External Document No.":=AgentApps."Agent Code";
                            GenJournalLine."Posting Date":=AgentTransactions."Transaction Date";
                            GenJournalLine.Description:='Agency Banking Charges';
                            GenJournalLine.Amount:=TotalCommission+ExcDuty;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Shortcut Dimension 1 Code":=Vendor."Global Dimension 1 Code";
                            GenJournalLine."Shortcut Dimension 2 Code":=Vendor."Global Dimension 2 Code";
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount<>0 then
                            GenJournalLine.Insert;
                            //END;//Check for Deposits/Share Deposits
                            end;//Vendor
                            end;//CASE Deposits, Withdrawal Transfer

                            AgentTransactions."transaction type"::Balance,
                            AgentTransactions."transaction type"::Ministatment:
                            if Vendor.Find('-') then begin
                            begin
                            //Cr Vendor
                            Vendor.Reset;
                            Vendor.SetRange(Vendor."No.", AgentTransactions."Account No.");
                                //Dr Customer
                                LineNo:=LineNo+10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name":='GENERAL';
                                GenJournalLine."Journal Batch Name":='Agency';
                                GenJournalLine."Line No.":=LineNo;
                                GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No.":=AgentTransactions."Account No.";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Document No.":=AgentTransactions."Document No.";
                                GenJournalLine."External Document No.":=AgentApps."Agent Code";
                                GenJournalLine."Posting Date":=AgentTransactions."Transaction Date";
                                GenJournalLine.Description:='Agency Banking Charges';
                                GenJournalLine.Amount:=TotalCommission+ExcDuty;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Shortcut Dimension 1 Code":=Vendor."Global Dimension 1 Code";
                                GenJournalLine."Shortcut Dimension 2 Code":=Vendor."Global Dimension 2 Code";
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount<>0 then
                                GenJournalLine.Insert;

                                //Cr Excise Duty
                                LineNo:=LineNo+10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name":='GENERAL';
                                GenJournalLine."Journal Batch Name":='Agency';
                                GenJournalLine."Line No.":=LineNo;
                                GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                                GenJournalLine."Account No.":=ExxcDuty;
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Document No.":=AgentTransactions."Document No.";
                                GenJournalLine."External Document No.":=AgentApps."Agent Code";
                                GenJournalLine."Posting Date":=AgentTransactions."Transaction Date";
                                GenJournalLine.Description:='Excise Duty-Agency Charges';
                                GenJournalLine.Amount:=-1*ExcDuty;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Shortcut Dimension 1 Code":=Vendor."Global Dimension 1 Code";
                                GenJournalLine."Shortcut Dimension 2 Code":=Vendor."Global Dimension 2 Code";
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount<>0 then
                                GenJournalLine.Insert;

                                LineNo:=LineNo+10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name":='GENERAL';
                                GenJournalLine."Journal Batch Name":='Agency';
                                GenJournalLine."Line No.":=LineNo;
                                GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                                GenJournalLine."Account No.":=CloudPESACommACC;
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Document No.":=AgentTransactions."Document No.";
                                GenJournalLine."External Document No.":=AgentApps."Agent Code";
                                GenJournalLine."Posting Date":=AgentTransactions."Transaction Date";
                                GenJournalLine.Description:='Agency Banking Charges';
                                GenJournalLine.Amount:=-1*commVendor;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Shortcut Dimension 1 Code":=Vendor."Global Dimension 1 Code";
                                GenJournalLine."Shortcut Dimension 2 Code":=Vendor."Global Dimension 2 Code";
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount<>0 then
                                GenJournalLine.Insert;

                                //Cr Sacco
                                LineNo:=LineNo+10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name":='GENERAL';
                                GenJournalLine."Journal Batch Name":='Agency';
                                GenJournalLine."Line No.":=LineNo;
                                GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                                GenJournalLine."Account No.":=AgentChargesAcc;
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Document No.":=AgentTransactions."Document No.";
                                GenJournalLine."External Document No.":=AgentApps."Agent Code";
                                GenJournalLine."Posting Date":=AgentTransactions."Transaction Date";
                                GenJournalLine.Description:='Agency Banking Charges';
                                GenJournalLine.Amount:=-1*commSacco;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Shortcut Dimension 1 Code":=Vendor."Global Dimension 1 Code";
                                GenJournalLine."Shortcut Dimension 2 Code":=Vendor."Global Dimension 2 Code";
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount<>0 then
                                GenJournalLine.Insert;

                                  //Cr Agent Commision Acc
                                  LineNo:=LineNo+10000;
                                  GenJournalLine.Init;
                                  GenJournalLine."Journal Template Name":='GENERAL';
                                  GenJournalLine."Journal Batch Name":='Agency';
                                  GenJournalLine."Line No.":=LineNo;
                                  GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                                  GenJournalLine."Account No.":=AgentApps."Comm Account";
                                  GenJournalLine.Validate(GenJournalLine."Account No.");
                                  GenJournalLine."Document No.":=AgentTransactions."Document No.";
                                  GenJournalLine."External Document No.":=AgentApps."Agent Code";
                                  GenJournalLine."Posting Date":=AgentTransactions."Transaction Date";
                                  GenJournalLine.Description:='Agency Banking Charges';
                                  GenJournalLine.Amount:=-1*commAgent;
                                  GenJournalLine.Validate(GenJournalLine.Amount);
                                  GenJournalLine."Shortcut Dimension 1 Code":=Vendor."Global Dimension 1 Code";
                                  GenJournalLine."Shortcut Dimension 2 Code":=Vendor."Global Dimension 2 Code";
                                  GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                  GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                  if GenJournalLine.Amount<>0 then
                                  GenJournalLine.Insert;
                                 res:=true;
                                end;//Vendor
                              end;//CASE mini Statement, Balance
                          AgentTransactions."transaction type"::Sharedeposit,
                          AgentTransactions."transaction type"::Registration,
                          AgentTransactions."transaction type"::Deposit:
                            begin

                            Members.Reset;
                            Members.SetRange(Members."FOSA Account No.", AgentTransactions."Account No.");
                            if Members.Find('-') then begin
                            Vendor.Reset;
                            Vendor.SetRange(Vendor."ID No.", AgentTransactions."Id No");
                           // Vendor.SETRANGE(Vendor."Account Type", 'ORDINARY');
                             if Vendor.FindFirst then begin
                               AgentTransactions.Amount :=AgentTransactions.Amount*-1;
                              //Cr Customer
                              if (AgentTransactions."Transaction Type"=AgentTransactions."transaction type"::Sharedeposit) then begin
                                LineNo:=LineNo+10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name":='GENERAL';
                                GenJournalLine."Journal Batch Name":='Agency';
                                GenJournalLine."Line No.":=LineNo;
                                GenJournalLine."Account Type":=GenJournalLine."account type"::Member;
                                GenJournalLine."Account No.":=AgentTransactions."Account No.";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                GenJournalLine."Document No.":=AgentTransactions."Document No.";
                                GenJournalLine."External Document No.":=AgentApps."Agent Code";
                                GenJournalLine."Posting Date":=AgentTransactions."Transaction Date";
                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Share Capital";
                                GenJournalLine."Shortcut Dimension 1 Code":='BOSA';
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Description:=AgentTransactions.Description;
                                GenJournalLine.Amount:=AgentTransactions.Amount;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount<>0 then
                                GenJournalLine.Insert;
                              end;
                              if (AgentTransactions."Transaction Type"=AgentTransactions."transaction type"::Deposit) then begin
                                LineNo:=LineNo+10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name":='GENERAL';
                                GenJournalLine."Journal Batch Name":='Agency';
                                GenJournalLine."Line No.":=LineNo;
                                GenJournalLine."Account Type":=GenJournalLine."account type"::Member;
                                GenJournalLine."Account No.":=AgentTransactions."Account No.";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                GenJournalLine."Document No.":=AgentTransactions."Document No.";
                                GenJournalLine."External Document No.":=AgentApps."Agent Code";
                                GenJournalLine."Posting Date":=AgentTransactions."Transaction Date";
                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Deposit Contribution";
                                GenJournalLine."Shortcut Dimension 1 Code":='BOSA';
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Description:=AgentTransactions.Description;
                                GenJournalLine.Amount:=AgentTransactions.Amount;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount<>0 then
                                GenJournalLine.Insert;
                              end;
                              if (AgentTransactions."Transaction Type"=AgentTransactions."transaction type"::Registration) then begin
                                LineNo:=LineNo+10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name":='GENERAL';
                                GenJournalLine."Journal Batch Name":='Agency';
                                GenJournalLine."Line No.":=LineNo;
                                GenJournalLine."Account Type":=GenJournalLine."account type"::Member;
                                GenJournalLine."Account No.":=AgentTransactions."Account No.";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                GenJournalLine."Document No.":=AgentTransactions."Document No.";
                                GenJournalLine."External Document No.":=AgentApps."Agent Code";
                                GenJournalLine."Posting Date":=AgentTransactions."Transaction Date";
                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Registration Fee";
                                GenJournalLine."Shortcut Dimension 1 Code":='BOSA';
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Description:=AgentTransactions.Description;
                                GenJournalLine.Amount:=AgentTransactions.Amount;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount<>0 then
                                GenJournalLine.Insert;
                              end;

            //Debit/Credit agent

                                LineNo:=LineNo+10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name":='GENERAL';
                                GenJournalLine."Journal Batch Name":='Agency';
                                GenJournalLine."Line No.":=LineNo;
                                GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No.":=AgentApps.Account;
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Document No.":=AgentTransactions."Document No.";
                                GenJournalLine."External Document No.":=AgentApps."Agent Code";
                                GenJournalLine."Posting Date":=AgentTransactions."Transaction Date";
                                GenJournalLine.Description:=AgentTransactions.Description;
                                GenJournalLine.Amount:=AgentTransactions.Amount *-1;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Shortcut Dimension 1 Code":=Vendor."Global Dimension 1 Code";
                                GenJournalLine."Shortcut Dimension 2 Code":=Vendor."Global Dimension 2 Code";
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount<>0 then
                                GenJournalLine.Insert;
         //Dr Customer
                                LineNo:=LineNo+10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name":='GENERAL';
                                GenJournalLine."Journal Batch Name":='Agency';
                                GenJournalLine."Line No.":=LineNo;
                                GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No.":=AgentTransactions."Account No.";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Document No.":=AgentTransactions."Document No.";
                                GenJournalLine."External Document No.":=AgentApps."Agent Code";
                                GenJournalLine."Posting Date":=AgentTransactions."Transaction Date";
                                GenJournalLine.Description:='Agency Banking Charges';
                                GenJournalLine.Amount:=TotalCommission+ExcDuty;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Shortcut Dimension 1 Code":=Vendor."Global Dimension 1 Code";
                                GenJournalLine."Shortcut Dimension 2 Code":=Vendor."Global Dimension 2 Code";
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount<>0 then
                                GenJournalLine.Insert;

                                //Cr Excise Duty
                                LineNo:=LineNo+10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name":='GENERAL';
                                GenJournalLine."Journal Batch Name":='Agency';
                                GenJournalLine."Line No.":=LineNo;
                                GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                                GenJournalLine."Account No.":=ExxcDuty;
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Document No.":=AgentTransactions."Document No.";
                                GenJournalLine."External Document No.":=AgentApps."Agent Code";
                                GenJournalLine."Posting Date":=AgentTransactions."Transaction Date";
                                GenJournalLine.Description:='Excise Duty-Agency Charges';
                                GenJournalLine.Amount:=-1*ExcDuty;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Shortcut Dimension 1 Code":=Vendor."Global Dimension 1 Code";
                                GenJournalLine."Shortcut Dimension 2 Code":=Vendor."Global Dimension 2 Code";
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount<>0 then
                                GenJournalLine.Insert;

                                LineNo:=LineNo+10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name":='GENERAL';
                                GenJournalLine."Journal Batch Name":='Agency';
                                GenJournalLine."Line No.":=LineNo;
                                GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                                GenJournalLine."Account No.":=CloudPESACommACC;
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Document No.":=AgentTransactions."Document No.";
                                GenJournalLine."External Document No.":=AgentApps."Agent Code";
                                GenJournalLine."Posting Date":=AgentTransactions."Transaction Date";
                                GenJournalLine.Description:='Agency Banking Charges';
                                GenJournalLine.Amount:=-1*commVendor;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Shortcut Dimension 1 Code":=Vendor."Global Dimension 1 Code";
                                GenJournalLine."Shortcut Dimension 2 Code":=Vendor."Global Dimension 2 Code";
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount<>0 then
                                GenJournalLine.Insert;

                                //Cr Sacco
                                LineNo:=LineNo+10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name":='GENERAL';
                                GenJournalLine."Journal Batch Name":='Agency';
                                GenJournalLine."Line No.":=LineNo;
                                GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                                GenJournalLine."Account No.":=AgentChargesAcc;
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Document No.":=AgentTransactions."Document No.";
                                GenJournalLine."External Document No.":=AgentApps."Agent Code";
                                GenJournalLine."Posting Date":=AgentTransactions."Transaction Date";
                                GenJournalLine.Description:='Agency Banking Charges';
                                GenJournalLine.Amount:=-1*commSacco;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Shortcut Dimension 1 Code":=Vendor."Global Dimension 1 Code";
                                GenJournalLine."Shortcut Dimension 2 Code":=Vendor."Global Dimension 2 Code";
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount<>0 then
                                GenJournalLine.Insert;

                                //Cr Agent Commision Acc
                                LineNo:=LineNo+10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name":='GENERAL';
                                GenJournalLine."Journal Batch Name":='Agency';
                                GenJournalLine."Line No.":=LineNo;
                                GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No.":=AgentApps."Comm Account";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Document No.":=AgentTransactions."Document No.";
                                GenJournalLine."External Document No.":=AgentApps."Agent Code";
                                GenJournalLine."Posting Date":=AgentTransactions."Transaction Date";
                                GenJournalLine.Description:='Agency Banking Charges';
                                GenJournalLine.Amount:=-1*commAgent;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Shortcut Dimension 1 Code":=Vendor."Global Dimension 1 Code";
                                GenJournalLine."Shortcut Dimension 2 Code":=Vendor."Global Dimension 2 Code";
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount<>0 then
                                GenJournalLine.Insert;
                                end;//Vendor
                                end;//Member
                              end;//CASE Shares Deposit,benevolent, reg fee,deposit con

                             AgentTransactions."transaction type"::LoanRepayment:
                              begin

                              Members.Reset;
                              Members.SetRange(Members."FOSA Account No.", AgentTransactions."Account No.");
                              if Members.Find('-') then begin
                              Vendor.Reset;
                              Vendor.SetRange(Vendor."ID No.", AgentTransactions."Id No");
                             // Vendor.SETRANGE(Vendor."Account Type", 'ORDINARY');
                               if Vendor.FindFirst then begin
                                    //Cr Customer
                                    LoansRegister.Reset;
                                    LoansRegister.SetRange(LoansRegister."Loan  No.",AgentTransactions."Loan No");
                                    LoansRegister.SetRange(LoansRegister."Client Code",Members."No.");

                                    if LoansRegister.Find('+') then begin
                                    LoansRegister.CalcFields(LoansRegister."Outstanding Balance",LoansRegister."Oustanding Interest");
                                    if LoansRegister."Outstanding Balance" > 0 then begin

                                    LineNo:=LineNo+10000;

                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name":='GENERAL';
                                    GenJournalLine."Journal Batch Name":='Agency';
                                    GenJournalLine."Line No.":=LineNo;

                                    GenJournalLine."Account Type":=GenJournalLine."account type"::Member;
                                    GenJournalLine.Validate(GenJournalLine."Account Type");
                                    GenJournalLine."Account No.":=LoansRegister."Client Code";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");

                                    GenJournalLine."Document No.":=AgentTransactions."Document No.";
                                    GenJournalLine."External Document No.":='';
                                    GenJournalLine."Posting Date":=Today;
                                    GenJournalLine.Description:='Loan Interest Payment';
                                    end;

                                    if AgentTransactions.Amount > LoansRegister."Oustanding Interest" then
                                    GenJournalLine.Amount:=-LoansRegister."Oustanding Interest"
                                    else
                                    GenJournalLine.Amount:=-AgentTransactions.Amount;
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Interest Paid";
                                    GenJournalLine.Validate(GenJournalLine."Transaction Type");

                                    if GenJournalLine."Shortcut Dimension 1 Code" = '' then begin
                                    GenJournalLine."Shortcut Dimension 1 Code":=Members."Global Dimension 1 Code";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    end;
                                    GenJournalLine."Loan No":=LoansRegister."Loan  No.";
                                    if GenJournalLine.Amount<>0 then
                                    GenJournalLine.Insert;

                                    AgentTransactions.Amount:=AgentTransactions.Amount+GenJournalLine.Amount;

                                    if AgentTransactions.Amount>0 then begin

                                    LineNo:=LineNo+10000;

                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name":='GENERAL';
                                    GenJournalLine."Journal Batch Name":='Agency';
                                    GenJournalLine."Line No.":=LineNo;

                                    GenJournalLine."Account Type":=GenJournalLine."account type"::Member;
                                    GenJournalLine.Validate(GenJournalLine."Account Type");
                                    GenJournalLine."Account No.":=LoansRegister."Client Code";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Document No.":=AgentTransactions."Document No.";
                                    GenJournalLine."External Document No.":='';
                                    GenJournalLine."Posting Date":=Today;
                                    GenJournalLine.Description:='Loan repayment';
                                    GenJournalLine.Amount:=-AgentTransactions.Amount;
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Loan Repayment";
                                    if GenJournalLine."Shortcut Dimension 1 Code" = '' then begin
                                    GenJournalLine."Shortcut Dimension 1 Code":=Members."Global Dimension 1 Code";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    end;
                                    GenJournalLine."Loan No":=LoansRegister."Loan  No.";
                                    if GenJournalLine.Amount<>0 then
                                    GenJournalLine.Insert;

                //Debit/Credit account 2

                                    LineNo:=LineNo+10000;
                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name":='GENERAL';
                                    GenJournalLine."Journal Batch Name":='Agency';
                                    GenJournalLine."Line No.":=LineNo;
                                    GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                                    GenJournalLine."Account No.":=AgentApps.Account;
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Document No.":=AgentTransactions."Document No.";
                                    GenJournalLine."External Document No.":=AgentApps."Agent Code";
                                    GenJournalLine."Posting Date":=AgentTransactions."Transaction Date";
                                    GenJournalLine.Description:=AgentTransactions.Description;
                                    GenJournalLine.Amount:=AgentTransactions.Amount;
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Shortcut Dimension 1 Code":=Vendor."Global Dimension 1 Code";
                                    GenJournalLine."Shortcut Dimension 2 Code":=Vendor."Global Dimension 2 Code";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount<>0 then
                                    GenJournalLine.Insert;
             //Dr Customer
                                    LineNo:=LineNo+10000;
                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name":='GENERAL';
                                    GenJournalLine."Journal Batch Name":='Agency';
                                    GenJournalLine."Line No.":=LineNo;
                                    GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                                    GenJournalLine."Account No.":=AgentTransactions."Account No.";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Document No.":=AgentTransactions."Document No.";
                                    GenJournalLine."External Document No.":=AgentApps."Agent Code";
                                    GenJournalLine."Posting Date":=AgentTransactions."Transaction Date";
                                    GenJournalLine.Description:='Agency Banking Charges';
                                    GenJournalLine.Amount:=TotalCommission+ExcDuty;
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Shortcut Dimension 1 Code":=Vendor."Global Dimension 1 Code";
                                    GenJournalLine."Shortcut Dimension 2 Code":=Vendor."Global Dimension 2 Code";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    if GenJournalLine.Amount<>0 then
                                    GenJournalLine.Insert;

                                //Cr Excise Duty
                                LineNo:=LineNo+10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name":='GENERAL';
                                GenJournalLine."Journal Batch Name":='Agency';
                                GenJournalLine."Line No.":=LineNo;
                                GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                                GenJournalLine."Account No.":=ExxcDuty;
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Document No.":=AgentTransactions."Document No.";
                                GenJournalLine."External Document No.":=AgentApps."Agent Code";
                                GenJournalLine."Posting Date":=AgentTransactions."Transaction Date";
                                GenJournalLine.Description:='Excise Duty-Agency Charges';
                                GenJournalLine.Amount:=-1*ExcDuty;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Shortcut Dimension 1 Code":=Vendor."Global Dimension 1 Code";
                                GenJournalLine."Shortcut Dimension 2 Code":=Vendor."Global Dimension 2 Code";
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount<>0 then
                                GenJournalLine.Insert;

                                LineNo:=LineNo+10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name":='GENERAL';
                                GenJournalLine."Journal Batch Name":='Agency';
                                GenJournalLine."Line No.":=LineNo;
                                GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                                GenJournalLine."Account No.":=CloudPESACommACC;
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Document No.":=AgentTransactions."Document No.";
                                GenJournalLine."External Document No.":=AgentApps."Agent Code";
                                GenJournalLine."Posting Date":=AgentTransactions."Transaction Date";
                                GenJournalLine.Description:='Agency Banking Charges';
                                GenJournalLine.Amount:=-1*commVendor;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Shortcut Dimension 1 Code":=Vendor."Global Dimension 1 Code";
                                GenJournalLine."Shortcut Dimension 2 Code":=Vendor."Global Dimension 2 Code";
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount<>0 then
                                GenJournalLine.Insert;

                                //Cr Sacco
                                LineNo:=LineNo+10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name":='GENERAL';
                                GenJournalLine."Journal Batch Name":='Agency';
                                GenJournalLine."Line No.":=LineNo;
                                GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                                GenJournalLine."Account No.":=AgentChargesAcc;
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Document No.":=AgentTransactions."Document No.";
                                GenJournalLine."External Document No.":=AgentApps."Agent Code";
                                GenJournalLine."Posting Date":=AgentTransactions."Transaction Date";
                                GenJournalLine.Description:='Agency Banking Charges';
                                GenJournalLine.Amount:=-1*commSacco;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Shortcut Dimension 1 Code":=Vendor."Global Dimension 1 Code";
                                GenJournalLine."Shortcut Dimension 2 Code":=Vendor."Global Dimension 2 Code";
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount<>0 then
                                GenJournalLine.Insert;

                                  //Cr Agent Commision Acc
                                  LineNo:=LineNo+10000;
                                  GenJournalLine.Init;
                                  GenJournalLine."Journal Template Name":='GENERAL';
                                  GenJournalLine."Journal Batch Name":='Agency';
                                  GenJournalLine."Line No.":=LineNo;
                                  GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                                  GenJournalLine."Account No.":=AgentApps."Comm Account";
                                  GenJournalLine.Validate(GenJournalLine."Account No.");
                                  GenJournalLine."Document No.":=AgentTransactions."Document No.";
                                  GenJournalLine."External Document No.":=AgentApps."Agent Code";
                                  GenJournalLine."Posting Date":=AgentTransactions."Transaction Date";
                                  GenJournalLine.Description:='Agency Banking Charges';
                                  GenJournalLine.Amount:=-1*commAgent;
                                  GenJournalLine.Validate(GenJournalLine.Amount);
                                  GenJournalLine."Shortcut Dimension 1 Code":=Vendor."Global Dimension 1 Code";
                                  GenJournalLine."Shortcut Dimension 2 Code":=Vendor."Global Dimension 2 Code";
                                  GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                  GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                  if GenJournalLine.Amount<>0 then
                                  GenJournalLine.Insert;
                                    end;
                                    end;//LoansRegister
                                    end;//Vendor
                                    end;//Member
                                  end;//CASE Loan Repayment
                               AgentTransactions."transaction type"::Schoolfeespayment,AgentTransactions."transaction type"::Schoolfeespayment:
                                 begin
                                AgentTransactions.Amount :=AgentTransactions.Amount*-1;
                               if (AgentTransactions."Transaction Type"=AgentTransactions."transaction type"::Schoolfeespayment) then begin
                                LineNo:=LineNo+10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name":='GENERAL';
                                GenJournalLine."Journal Batch Name":='Agency';
                                GenJournalLine."Line No.":=LineNo;
                                GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                                GenJournalLine."Account No.":='401110';
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                GenJournalLine."Document No.":=AgentTransactions."Document No.";
                                GenJournalLine."External Document No.":=AgentApps."Agent Code";
                                GenJournalLine."Posting Date":=AgentTransactions."Transaction Date";
                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Share Capital";
                                GenJournalLine."Shortcut Dimension 1 Code":='BOSA';
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Description:=AgentTransactions.Description;
                                GenJournalLine.Amount:=AgentTransactions.Amount;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount<>0 then
                                GenJournalLine.Insert;
                              end;
                               if (AgentTransactions."Transaction Type"=AgentTransactions."transaction type"::Schoolfeespayment) then begin
                                LineNo:=LineNo+10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name":='GENERAL';
                                GenJournalLine."Journal Batch Name":='Agency';
                                GenJournalLine."Line No.":=LineNo;
                                GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                                GenJournalLine."Account No.":='401270';
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                GenJournalLine."Document No.":=AgentTransactions."Document No.";
                                GenJournalLine."External Document No.":=AgentApps."Agent Code";
                                GenJournalLine."Posting Date":=AgentTransactions."Transaction Date";
                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Registration Fee";
                                GenJournalLine."Shortcut Dimension 1 Code":='BOSA';
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Description:=AgentTransactions.Description;
                                GenJournalLine.Amount:=AgentTransactions.Amount;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount<>0 then
                                GenJournalLine.Insert;
                                end;

        //Debit/Credit agent

                                LineNo:=LineNo+10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name":='GENERAL';
                                GenJournalLine."Journal Batch Name":='Agency';
                                GenJournalLine."Line No.":=LineNo;
                                GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No.":=AgentApps.Account;
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Document No.":=AgentTransactions."Document No.";
                                GenJournalLine."External Document No.":=AgentApps."Agent Code";
                                GenJournalLine."Posting Date":=AgentTransactions."Transaction Date";
                                GenJournalLine.Description:=AgentTransactions.Description;
                                GenJournalLine.Amount:=AgentTransactions.Amount *-1;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Shortcut Dimension 1 Code":=Vendor."Global Dimension 1 Code";
                                GenJournalLine."Shortcut Dimension 2 Code":=Vendor."Global Dimension 2 Code";
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount<>0 then
                                GenJournalLine.Insert;

                                  end;//pay fines
                                end;
                                  //Post
                                  GenJournalLine.Reset;
                                  GenJournalLine.SetRange("Journal Template Name",'GENERAL');
                                  GenJournalLine.SetRange("Journal Batch Name",'Agency');
                                  if GenJournalLine.Find('-') then begin
                                      repeat
                                      GLPosting.Run(GenJournalLine);
                                      until GenJournalLine.Next = 0;
                                  AgentTransactions.Posted:=true;
                                  AgentTransactions."Date Posted":=Today;
                                  AgentTransactions.Messages:='Completed';
                                  AgentTransactions."Time Posted":=Time;
                                  AgentTransactions.Modify;
                                  res:=true;
                                  end
                                  else begin
                                  AgentTransactions.Posted:=false;
                                  AgentTransactions."Date Posted":=Today;
                                  AgentTransactions.Messages:='Failed';
                                  AgentTransactions."Time Posted":=Time;
                                  AgentTransactions.Modify;
                              end;
                   end;//Agent Apps
                   end
                   else begin//Check deposit
                     res:=false;
                  end
        end;//Agent Transactions
    end;


    procedure GetAccountBalance(account: Code[30]) bal: Decimal
    begin
        begin
        Vendor.Reset;
        Vendor.SetRange(Vendor."No.",account);
        if Vendor.Find('-') then begin
        AccountTypes.Reset;
        AccountTypes.SetRange(AccountTypes.Code,Vendor."Account Type")  ;
        if AccountTypes.Find('-') then
            begin
              miniBalance:=AccountTypes."Minimum Balance";
              Vendor.CalcFields(Vendor."Balance (LCY)");
              Vendor.CalcFields(Vendor."ATM Transactions");
              Vendor.CalcFields(Vendor."Uncleared Cheques");
              Vendor.CalcFields(Vendor."EFT Transactions");
              bal:=Vendor."Balance (LCY)"-(Vendor."ATM Transactions"+Vendor."Uncleared Cheques"+Vendor."EFT Transactions"+miniBalance);
            end;
          end
          else begin
        //    AgentApps.RESET;
        //    AgentApps.SETRANGE(AgentApps."Agent Code",account);
        //    IF AgentApps.FIND('-') THEN BEGIN
            BankAccount.Reset;
            BankAccount.SetRange(BankAccount."Bank Account No.",account);
            if (BankAccount.Find('-'))then begin
            repeat
              bal:=bal+BankAccount.Amount;

            until BankAccount.Next=0;
              end;
        //END;
              end;

        end;
    end;


    procedure GetMember(idNumber: Text[50]) accounts: Text[1000]
    begin
        begin
          Members.Reset;
          Members.SetRange(Members."ID No.",idNumber);
          Members.SetRange(Members.Blocked,0);
          Members.SetFilter(Members.Status, '%1|%2',0,4);
          if Members.Find('-') then begin
          accounts:='';
          repeat
          accounts:=accounts+'-:-'+Members."No."+':::'+Members.Name+':::'+Members."Mobile Phone No";
          until Members.Next =0;
          end
          else
          begin
          accounts:='none';
          end
        end;
    end;


    procedure GetTransactionMinAmount() limits: Decimal
    begin
        WithdrawalLimit.Reset;
        WithdrawalLimit.SetRange(WithdrawalLimit.Code,'NORMAL');
        if WithdrawalLimit.Find('-') then begin
          limits:=WithdrawalLimit."Trans Min Amount";
        end;
    end;


    procedure GetTransactionMaxAmount() limits: Decimal
    begin
        WithdrawalLimit.Reset;
        WithdrawalLimit.SetRange(WithdrawalLimit.Code,'NORMAL');
        if WithdrawalLimit.Find('-') then begin
          limits:=WithdrawalLimit."Trans Max Amount";
        end;
    end;


    procedure GetTransactionCharges() limits: Decimal
    begin
        WithdrawalLimit.Reset;
        WithdrawalLimit.SetRange(WithdrawalLimit.Code,'NORMAL');
        if WithdrawalLimit.Find('-') then begin
          limits:=WithdrawalLimit."Trans Max Amount";
        end;
    end;


    procedure GetWithdrawalCharges(type: Text[20];amount: Decimal) charges: Decimal
    begin
        TariffDetails.Reset;
        TariffDetails.SetRange(TariffDetails.Code,type);
        TariffDetails.SetFilter(TariffDetails."Agent Comm",'<=%1',amount);
        TariffDetails.SetFilter(TariffDetails."Sacco Comm",'>=%1',amount);
        if TariffDetails.Find('-') then begin
          charges:=TariffDetails.Charge;
        end;
    end;


    procedure GetCharges(type: Text[20]) charge: Decimal
    begin
        TariffDetails.Reset;
        TariffDetails.SetRange(TariffDetails.Code,type);
        if TariffDetails.Find('-') then begin
          charge:=TariffDetails.Charge;
        end;
    end;


    procedure GetTariffCode(type: Text[30]) "code": Text[10]
    begin
        TariffHeader.Reset;
        TariffHeader.SetFilter(TariffHeader."Trans Type",type);
        if TariffHeader.Find('-') then begin
          code:=TariffHeader.Code;
        end;
    end;


    procedure InsertMessages(documentNo: Text[30];phone: Text[20];message: Text[400]) res: Boolean
    begin
          begin
            SMSMessages.Reset;
            if SMSMessages.Find('+') then begin
            iEntryNo:=SMSMessages."Entry No";
            iEntryNo:=iEntryNo+1;
            end
            else begin
            iEntryNo:=1;
            end;
            SMSMessages.Init;
            SMSMessages."Entry No":=iEntryNo;
            SMSMessages."Batch No":=documentNo;
            SMSMessages."Document No":=documentNo;
            SMSMessages."Account No":='';
            SMSMessages."Date Entered":=Today;
            SMSMessages."Time Entered":=Time;
            SMSMessages.Source:='AGENCY';
            SMSMessages."Entered By":=UserId;
            SMSMessages."Sent To Server":=SMSMessages."sent to server"::No;
            SMSMessages."SMS Message":=message;
            SMSMessages."Telephone No":=phone;
            if SMSMessages."Telephone No"<>'' then
            SMSMessages.Insert;
            res:=true;
            end;
    end;


    procedure AgencyRegistration() memberdetails: Text[500]
    begin
        begin
          begin
            AgentApps.Reset;
            AgentApps.SetRange(AgentApps."Sent To Server", AgentApps."sent to server"::No);
            AgentApps.SetRange(AgentApps.Status, AgentApps.Status::Approved);
            if AgentApps.Find('-') then
              begin
                    memberdetails:=AgentApps."Agent Code"+':::'+AgentApps."Mobile No"+':::'+AgentApps.Name+':::'+Format(AgentApps.Branch);
              end
            else
            begin
                memberdetails:='';
            end
            end;
            end;
    end;


    procedure UpdateAgencyRegistration(agentCode: Code[20]) result: Text[30]
    begin
        begin
          begin
            AgentApps.Reset;
            AgentApps.SetRange(AgentApps."Sent To Server", AgentApps."sent to server"::No);
            AgentApps.SetRange(AgentApps."Agent Code", agentCode);
            if AgentApps.Find('-') then
              begin
                    AgentApps."Sent To Server":=AgentApps."sent to server"::Yes;
                    AgentApps.Modify;
                    result:='Modified';
              end
            else
            begin
                result:='Failed';
            end
           end;
        end;
    end;


    procedure PostBranchAgentTransaction(transID: Code[30]) res: Boolean
    begin
        AgentTransactions.Reset;
        AgentTransactions.SetRange(AgentTransactions."Document No.",transID);
        AgentTransactions.SetRange(AgentTransactions.Posted,false);

        if AgentTransactions.Find('-') then begin
         BlockedStatus:=Blocked(AgentTransactions."Account No.");
           if (BlockedStatus=false) or (AgentTransactions."Transaction Type"=AgentTransactions."transaction type"::Deposit)
             or (AgentTransactions."Transaction Type"=AgentTransactions."transaction type"::LoanRepayment)
              then begin
            TariffHeader.Reset();
            TariffHeader.SetRange(TariffHeader."Trans Type",AgentTransactions."Transaction Type");
            if TariffHeader.FindFirst then
               begin
                TariffDetails.Reset();
                TariffDetails.SetRange(TariffDetails.Code,TariffHeader.Code);
                if TariffDetails.FindFirst then
                begin
                    commAgent := TariffDetails."Agent Comm";
                    commVendor := TariffDetails."Vendor Comm";
                    commSacco := TariffDetails."Sacco Comm" ;
                    TotalCommission:=commVendor+commSacco;
                    //TotalCommission:=commAgent+commVendor+commSacco;
                  end;//Tariff Details
               end;//Tariff Header

                 ExcDuty:=20/100*TotalCommission;

                if (AgentTransactions."Transaction Type" = AgentTransactions."transaction type"::Deposit) then
                  begin
                    AgentTransactions.Amount :=-AgentTransactions.Amount;
                  end;

                AgentApps.Reset;
                AgentApps.SetRange(AgentApps."Agent Code", AgentTransactions."Agent Code");
                if AgentApps.Find('-')
                  then begin
                        GenLedgerSetup.Reset;
                        GenLedgerSetup.Get;
                        GenLedgerSetup.TestField(GenLedgerSetup."Mobile Charge");
                        CloudPESACommACC:=  GenLedgerSetup."CloudPESA Comm Acc";
                        AgentChargesAcc:= GenLedgerSetup."Agent Charges Account";

                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name",'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name",'Agency');
                        GenJournalLine.DeleteAll;
                        //end of deletion

                        GenBatches.Reset;
                        GenBatches.SetRange(GenBatches."Journal Template Name",'GENERAL');
                        GenBatches.SetRange(GenBatches.Name,'Agency');

                        if GenBatches.Find('-') = false then begin
                            GenBatches.Init;
                            GenBatches."Journal Template Name":='GENERAL';
                            GenBatches.Name:='Agency';
                            GenBatches.Description:='Agency Transactions';
                            GenBatches.Validate(GenBatches."Journal Template Name");
                            GenBatches.Validate(GenBatches.Name);
                            GenBatches.Insert;
                        end;//General Jnr Batches
                        case AgentTransactions."Transaction Type" of

                          AgentTransactions."transaction type"::MemberRegistration:
                               begin
                                 registrationup:=true;
                          objRegMember.Reset;
                          objRegMember.SetRange("ID No.",AgentTransactions."Id No");
                          if objRegMember.Find('-') then begin
                            AgentTransactions.Posted:=false;
                                  AgentTransactions."Date Posted":=Today;
                                  AgentTransactions.Messages:='Failed';
                                  AgentTransactions."Time Posted":=Time;
                                  AgentTransactions.Modify;
                            exit(false);
                          end
                            else  begin
                            objRegMember.Init;
                            objRegMember.Name:= UpperCase(AgentTransactions."Account Name");
                            objRegMember."Mobile Phone No":=AgentTransactions.Telephone;
                            objRegMember."Phone No.":=AgentTransactions.Telephone;
                            objRegMember."Date of Birth":= AgentTransactions."Date of Birth";
                            objRegMember.Age:=Dates.DetermineAge(AgentTransactions."Date of Birth",Today);
                            objRegMember."ID No.":=AgentTransactions."Id No";
                            objRegMember."Created By":=AgentApps."Agent Code";
                            objRegMember."Captured By":=AgentApps."Agent Code";
                            objRegMember."Date of Registration":=Today;
                            objRegMember.Status:=objRegMember.Status::Open;
                            objRegMember."Customer Posting Group":='MEMBER';
                            objRegMember."Global Dimension 1 Code":='BOSA';
                            objRegMember."Customer Type":=objRegMember."customer type"::Member;
                            objRegMember."Member's Residence":=AgentTransactions."Place of Residence";
                            objRegMember.Address:=AgentTransactions.Address;
                            objRegMember."Address 2":=AgentTransactions."Physical Address";
                            objRegMember."Postal Code":=AgentTransactions."Postal Code";
                            objRegMember.Insert(true);
                            AgentTransactions.Posted:=true;
                            AgentTransactions."Date Posted":=Today;
                            AgentTransactions.Messages:='Completed';
                            AgentTransactions."Time Posted":=Time;
                            AgentTransactions.Modify;

                               end;
                               exit(true);
                                end;

                           AgentTransactions."transaction type"::Memberactivation:
                               begin
                                 registrationup:=true;
                          objNewAccount.Init;
                          objNewAccount."Account Category":=objNewAccount."account category"::Single;
                          objNewAccount.Validate(objNewAccount."No.");
                          objNewAccount."BOSA Account No":=AgentTransactions."Account No.";
                          objNewAccount.Insert(true);
                          objNewAccount.Reset;
                          objNewAccount.SetRange("No.",objNewAccount."No.");
                          if objNewAccount.Find('-') then begin
                          objNewAccount.Validate("BOSA Account No");
                          objNewAccount."Account Type":='ORDINARY';
                          objNewAccount.Validate(objNewAccount."Account Type");
                          objNewAccount.Modify;
                           AgentTransactions.Posted:=true;
                           AgentTransactions."Date Posted":=Today;
                           AgentTransactions.Messages:='Completed';
                           AgentTransactions."Time Posted":=Time;
                           AgentTransactions.Modify;
                          exit(true);
                          end;
                          end;
                       AgentTransactions."transaction type"::Withdrawal,
                        AgentTransactions."transaction type"::Deposit,
                        AgentTransactions."transaction type"::Transfer:
                          begin
                          Vendor.Reset;
                          Vendor.SetRange(Vendor."No.", AgentTransactions."Account No.");
                          if Vendor.Find('-') then begin

                        if (AgentTransactions."Transaction Type"=AgentTransactions."transaction type"::Transfer) then begin

                          //Debit Member Account 1
                            LineNo:=LineNo+10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name":='GENERAL';
                            GenJournalLine."Journal Batch Name":='Agency';
                            GenJournalLine."Line No.":=LineNo;
                            GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                            GenJournalLine."Account No.":=AgentTransactions."Account No.";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No.":=AgentTransactions."Document No.";
                            GenJournalLine."External Document No.":=AgentApps."Agent Code";
                            GenJournalLine."Posting Date":=AgentTransactions."Transaction Date";
                            GenJournalLine.Description:=AgentTransactions.Description;
                            GenJournalLine.Amount:=AgentTransactions.Amount;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Shortcut Dimension 1 Code":=Vendor."Global Dimension 1 Code";
                            GenJournalLine."Shortcut Dimension 2 Code":=Vendor."Global Dimension 2 Code";
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount<>0 then
                            GenJournalLine.Insert;

                           //Debit/Credit account 2

                            LineNo:=LineNo+10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name":='GENERAL';
                            GenJournalLine."Journal Batch Name":='Agency';
                            GenJournalLine."Line No.":=LineNo;
                            GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                            GenJournalLine."Account No.":=AgentTransactions."Account No 2";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No.":=AgentTransactions."Document No.";
                            GenJournalLine."External Document No.":=AgentApps."Agent Code";
                            GenJournalLine."Posting Date":=AgentTransactions."Transaction Date";
                            GenJournalLine.Description:=AgentTransactions.Description;
                            GenJournalLine.Amount:=AgentTransactions.Amount *-1;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Shortcut Dimension 1 Code":=Vendor."Global Dimension 1 Code";
                            GenJournalLine."Shortcut Dimension 2 Code":=Vendor."Global Dimension 2 Code";
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount<>0 then
                            GenJournalLine.Insert;//End of Transfer
                            end
                            else begin
                            //Debit Member Account 1
                            LineNo:=LineNo+10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name":='GENERAL';
                            GenJournalLine."Journal Batch Name":='Agency';
                            GenJournalLine."Line No.":=LineNo;
                            GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                            GenJournalLine."Account No.":=AgentTransactions."Account No.";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"Bank Account";
                            GenJournalLine."Bal. Account No.":=AgentApps.Account;
                            GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                            GenJournalLine."Document No.":=AgentTransactions."Document No.";
                            GenJournalLine."External Document No.":=AgentApps."Agent Code";
                            GenJournalLine."Posting Date":=AgentTransactions."Transaction Date";
                            GenJournalLine.Description:=AgentTransactions.Description+'-'+AgentTransactions."Account Name";
                            GenJournalLine.Amount:=AgentTransactions.Amount;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Shortcut Dimension 1 Code":=Vendor."Global Dimension 1 Code";
                            GenJournalLine."Shortcut Dimension 2 Code":=Vendor."Global Dimension 2 Code";
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount<>0 then
                            GenJournalLine.Insert;
                            end;

                       // IF (AgentTransactions."Transaction Type"<>AgentTransactions."Transaction Type"::Deposit) THEN BEGIN
                            //Cr Vendor-Surestep
                           LineNo:=LineNo+10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name":='GENERAL';
                            GenJournalLine."Journal Batch Name":='Agency';
                            GenJournalLine."Line No.":=LineNo;
                            GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                            GenJournalLine."Account No.":=CloudPESACommACC;
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No.":=AgentTransactions."Document No.";
                            GenJournalLine."External Document No.":=AgentApps."Agent Code";
                            GenJournalLine."Posting Date":=AgentTransactions."Transaction Date";
                            GenJournalLine.Description:='Agency Banking Charges';
                            GenJournalLine.Amount:=-1*commVendor;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Shortcut Dimension 1 Code":=Vendor."Global Dimension 1 Code";
                            GenJournalLine."Shortcut Dimension 2 Code":=Vendor."Global Dimension 2 Code";
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount<>0 then
                            GenJournalLine.Insert;

          //Cr Sacco
                           LineNo:=LineNo+10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name":='GENERAL';
                            GenJournalLine."Journal Batch Name":='Agency';
                            GenJournalLine."Line No.":=LineNo;
                            GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                            GenJournalLine."Account No.":=AgentChargesAcc;
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No.":=AgentTransactions."Document No.";
                            GenJournalLine."External Document No.":=AgentApps."Agent Code";
                            GenJournalLine."Posting Date":=AgentTransactions."Transaction Date";
                            GenJournalLine.Description:='Agency Banking Charges';
                            GenJournalLine.Amount:=-1*commSacco;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Shortcut Dimension 1 Code":=Vendor."Global Dimension 1 Code";
                            GenJournalLine."Shortcut Dimension 2 Code":=Vendor."Global Dimension 2 Code";
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount<>0 then
                            GenJournalLine.Insert;

                            //Cr Excise Duty
                            LineNo:=LineNo+10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name":='GENERAL';
                            GenJournalLine."Journal Batch Name":='Agency';
                            GenJournalLine."Line No.":=LineNo;
                            GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                            GenJournalLine."Account No.":=ExxcDuty;
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No.":=AgentTransactions."Document No.";
                            GenJournalLine."External Document No.":=AgentApps."Agent Code";
                            GenJournalLine."Posting Date":=AgentTransactions."Transaction Date";
                            GenJournalLine.Description:='Excise Duty-Agency Charges';
                            GenJournalLine.Amount:=-1*ExcDuty;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Shortcut Dimension 1 Code":=Vendor."Global Dimension 1 Code";
                            GenJournalLine."Shortcut Dimension 2 Code":=Vendor."Global Dimension 2 Code";
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount<>0 then
                            GenJournalLine.Insert;

                            //Dr Customer
                            LineNo:=LineNo+10000;
                            GenJournalLine.Init;
                            GenJournalLine."Journal Template Name":='GENERAL';
                            GenJournalLine."Journal Batch Name":='Agency';
                            GenJournalLine."Line No.":=LineNo;
                            GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                            GenJournalLine."Account No.":=AgentTransactions."Account No.";
                            GenJournalLine.Validate(GenJournalLine."Account No.");
                            GenJournalLine."Document No.":=AgentTransactions."Document No.";
                            GenJournalLine."External Document No.":=AgentApps."Agent Code";
                            GenJournalLine."Posting Date":=AgentTransactions."Transaction Date";
                            GenJournalLine.Description:='Agency Banking Charges';
                            GenJournalLine.Amount:=TotalCommission+ExcDuty;
                            GenJournalLine.Validate(GenJournalLine.Amount);
                            GenJournalLine."Shortcut Dimension 1 Code":=Vendor."Global Dimension 1 Code";
                            GenJournalLine."Shortcut Dimension 2 Code":=Vendor."Global Dimension 2 Code";
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                            GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                            if GenJournalLine.Amount<>0 then
                            GenJournalLine.Insert;
                            //END;//Check for Deposits/Share Deposits
                            end;//Vendor
                            end;//CASE Deposits, Withdrawal Transfer

                           AgentTransactions."transaction type"::Balance,
                            AgentTransactions."transaction type"::Ministatment:
                            if Vendor.Find('-') then begin
                            begin
                            //Cr Vendor
                            Vendor.Reset;
                            Vendor.SetRange(Vendor."No.", AgentTransactions."Account No.");
                                //Dr Customer
                                LineNo:=LineNo+10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name":='GENERAL';
                                GenJournalLine."Journal Batch Name":='Agency';
                                GenJournalLine."Line No.":=LineNo;
                                GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No.":=AgentTransactions."Account No.";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Document No.":=AgentTransactions."Document No.";
                                GenJournalLine."External Document No.":=AgentApps."Agent Code";
                                GenJournalLine."Posting Date":=AgentTransactions."Transaction Date";
                                GenJournalLine.Description:='Agency Banking Charges';
                                GenJournalLine.Amount:=TotalCommission+ExcDuty;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Shortcut Dimension 1 Code":=Vendor."Global Dimension 1 Code";
                                GenJournalLine."Shortcut Dimension 2 Code":=Vendor."Global Dimension 2 Code";
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount<>0 then
                                GenJournalLine.Insert;

                                //Cr Excise Duty
                                LineNo:=LineNo+10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name":='GENERAL';
                                GenJournalLine."Journal Batch Name":='Agency';
                                GenJournalLine."Line No.":=LineNo;
                                GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                                GenJournalLine."Account No.":=ExxcDuty;
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Document No.":=AgentTransactions."Document No.";
                                GenJournalLine."External Document No.":=AgentApps."Agent Code";
                                GenJournalLine."Posting Date":=AgentTransactions."Transaction Date";
                                GenJournalLine.Description:='Excise Duty-Agency Charges';
                                GenJournalLine.Amount:=-1*ExcDuty;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Shortcut Dimension 1 Code":=Vendor."Global Dimension 1 Code";
                                GenJournalLine."Shortcut Dimension 2 Code":=Vendor."Global Dimension 2 Code";
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount<>0 then
                                GenJournalLine.Insert;

                                LineNo:=LineNo+10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name":='GENERAL';
                                GenJournalLine."Journal Batch Name":='Agency';
                                GenJournalLine."Line No.":=LineNo;
                                GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                                GenJournalLine."Account No.":=CloudPESACommACC;
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Document No.":=AgentTransactions."Document No.";
                                GenJournalLine."External Document No.":=AgentApps."Agent Code";
                                GenJournalLine."Posting Date":=AgentTransactions."Transaction Date";
                                GenJournalLine.Description:='Agency Banking Charges';
                                GenJournalLine.Amount:=-1*commVendor;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Shortcut Dimension 1 Code":=Vendor."Global Dimension 1 Code";
                                GenJournalLine."Shortcut Dimension 2 Code":=Vendor."Global Dimension 2 Code";
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount<>0 then
                                GenJournalLine.Insert;

                                //Cr Sacco
                                LineNo:=LineNo+10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name":='GENERAL';
                                GenJournalLine."Journal Batch Name":='Agency';
                                GenJournalLine."Line No.":=LineNo;
                                GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                                GenJournalLine."Account No.":=AgentChargesAcc;
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Document No.":=AgentTransactions."Document No.";
                                GenJournalLine."External Document No.":=AgentApps."Agent Code";
                                GenJournalLine."Posting Date":=AgentTransactions."Transaction Date";
                                GenJournalLine.Description:='Agency Banking Charges';
                                GenJournalLine.Amount:=-1*commSacco;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Shortcut Dimension 1 Code":=Vendor."Global Dimension 1 Code";
                                GenJournalLine."Shortcut Dimension 2 Code":=Vendor."Global Dimension 2 Code";
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount<>0 then
                                GenJournalLine.Insert;
                                 res:=true;
                                end;//Vendor
                              end;//CASE mini Statement, Balance
                          AgentTransactions."transaction type"::Sharedeposit,
                          AgentTransactions."transaction type"::Registration,
                          AgentTransactions."transaction type"::Deposit:
                            begin

                            Members.Reset;
                            Members.SetRange(Members."No.", AgentTransactions."Account No.");
                            if Members.Find('-') then begin
                            Vendor.Reset;
                            Vendor.SetRange(Vendor."ID No.", AgentTransactions."Id No");
                           // Vendor.SETRANGE(Vendor."Account Type", 'ORDINARY');
                             if Vendor.FindFirst then begin
                               AgentTransactions.Amount :=-AgentTransactions.Amount;
                              //Cr Customer

                             if AgentTransactions."Transaction Type"=AgentTransactions."transaction type"::Deposit then begin
                                LineNo:=LineNo+10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name":='GENERAL';
                                GenJournalLine."Journal Batch Name":='Agency';
                                GenJournalLine."Line No.":=LineNo;
                                GenJournalLine."Account Type":=GenJournalLine."account type"::Member;
                                GenJournalLine."Account No.":=AgentTransactions."Account No.";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"Bank Account";
                                GenJournalLine.Validate(GenJournalLine."Bal. Account Type");
                                GenJournalLine."Bal. Account No.":=AgentApps.Account;
                                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                GenJournalLine."Document No.":=AgentTransactions."Document No.";
                                GenJournalLine."External Document No.":=AgentApps."Agent Code";
                                GenJournalLine."Posting Date":=AgentTransactions."Transaction Date";
                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Deposit Contribution";
                                GenJournalLine."Shortcut Dimension 1 Code":='BOSA';
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Description:=AgentTransactions.Description+'-'+AgentTransactions."Account Name";
                                GenJournalLine.Amount:=AgentTransactions.Amount;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount<>0 then
                                GenJournalLine.Insert;
                              end;
                              if AgentTransactions."Transaction Type"=AgentTransactions."transaction type"::Sharedeposit then begin
                                LineNo:=LineNo+10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name":='GENERAL';
                                GenJournalLine."Journal Batch Name":='Agency';
                                GenJournalLine."Line No.":=LineNo;
                                GenJournalLine."Account Type":=GenJournalLine."account type"::Member;
                                GenJournalLine."Account No.":=AgentTransactions."Account No.";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"Bank Account";
                                GenJournalLine.Validate(GenJournalLine."Bal. Account Type");
                                GenJournalLine."Bal. Account No.":=AgentApps.Account;
                                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                GenJournalLine."Document No.":=AgentTransactions."Document No.";
                                GenJournalLine."External Document No.":=AgentApps."Agent Code";
                                GenJournalLine."Posting Date":=AgentTransactions."Transaction Date";
                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Share Capital";
                                GenJournalLine."Shortcut Dimension 1 Code":='BOSA';
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Description:=AgentTransactions.Description+'-'+AgentTransactions."Account Name";
                                GenJournalLine.Amount:=AgentTransactions.Amount;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount<>0 then
                                GenJournalLine.Insert;
                              end;
                              if AgentTransactions."Transaction Type"=AgentTransactions."transaction type"::Registration then begin
                                LineNo:=LineNo+10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name":='GENERAL';
                                GenJournalLine."Journal Batch Name":='Agency';
                                GenJournalLine."Line No.":=LineNo;
                                GenJournalLine."Account Type":=GenJournalLine."account type"::Member;
                                GenJournalLine."Account No.":=AgentTransactions."Account No.";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"Bank Account";
                                GenJournalLine.Validate(GenJournalLine."Bal. Account Type");
                                GenJournalLine."Bal. Account No.":=AgentApps.Account;
                                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                GenJournalLine."Document No.":=AgentTransactions."Document No.";
                                GenJournalLine."External Document No.":=AgentApps."Agent Code";
                                GenJournalLine."Posting Date":=AgentTransactions."Transaction Date";
                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Registration Fee";
                                GenJournalLine."Shortcut Dimension 1 Code":='BOSA';
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Description:=AgentTransactions.Description+'-'+AgentTransactions."Account Name";
                                GenJournalLine.Amount:=AgentTransactions.Amount;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount<>0 then
                                GenJournalLine.Insert;
                              end;

         //Dr Customer charges
                                LineNo:=LineNo+10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name":='GENERAL';
                                GenJournalLine."Journal Batch Name":='Agency';
                                GenJournalLine."Line No.":=LineNo;
                                GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No.":=Vendor."No.";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Document No.":=AgentTransactions."Document No.";
                                GenJournalLine."External Document No.":=AgentApps."Agent Code";
                                GenJournalLine."Posting Date":=AgentTransactions."Transaction Date";
                                GenJournalLine.Description:='Agency Banking Charges';
                                GenJournalLine.Amount:=TotalCommission+ExcDuty;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Shortcut Dimension 1 Code":=Vendor."Global Dimension 1 Code";
                                GenJournalLine."Shortcut Dimension 2 Code":=Vendor."Global Dimension 2 Code";
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount<>0 then
                                GenJournalLine.Insert;

                                //Cr Excise Duty
                                LineNo:=LineNo+10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name":='GENERAL';
                                GenJournalLine."Journal Batch Name":='Agency';
                                GenJournalLine."Line No.":=LineNo;
                                GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                                GenJournalLine."Account No.":=ExxcDuty;
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Document No.":=AgentTransactions."Document No.";
                                GenJournalLine."External Document No.":=AgentApps."Agent Code";
                                GenJournalLine."Posting Date":=AgentTransactions."Transaction Date";
                                GenJournalLine.Description:='Excise Duty-Agency Charges';
                                GenJournalLine.Amount:=-1*ExcDuty;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Shortcut Dimension 1 Code":=Vendor."Global Dimension 1 Code";
                                GenJournalLine."Shortcut Dimension 2 Code":=Vendor."Global Dimension 2 Code";
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount<>0 then
                                GenJournalLine.Insert;

                                LineNo:=LineNo+10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name":='GENERAL';
                                GenJournalLine."Journal Batch Name":='Agency';
                                GenJournalLine."Line No.":=LineNo;
                                GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                                GenJournalLine."Account No.":=CloudPESACommACC;
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Document No.":=AgentTransactions."Document No.";
                                GenJournalLine."External Document No.":=AgentApps."Agent Code";
                                GenJournalLine."Posting Date":=AgentTransactions."Transaction Date";
                                GenJournalLine.Description:='Agency Banking Charges';
                                GenJournalLine.Amount:=-1*commVendor;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Shortcut Dimension 1 Code":=Vendor."Global Dimension 1 Code";
                                GenJournalLine."Shortcut Dimension 2 Code":=Vendor."Global Dimension 2 Code";
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount<>0 then
                                GenJournalLine.Insert;

                                //Cr Sacco
                                LineNo:=LineNo+10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name":='GENERAL';
                                GenJournalLine."Journal Batch Name":='Agency';
                                GenJournalLine."Line No.":=LineNo;
                                GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                                GenJournalLine."Account No.":=AgentChargesAcc;
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Document No.":=AgentTransactions."Document No.";
                                GenJournalLine."External Document No.":=AgentApps."Agent Code";
                                GenJournalLine."Posting Date":=AgentTransactions."Transaction Date";
                                GenJournalLine.Description:='Agency Banking Charges';
                                GenJournalLine.Amount:=-1*commSacco;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Shortcut Dimension 1 Code":=Vendor."Global Dimension 1 Code";
                                GenJournalLine."Shortcut Dimension 2 Code":=Vendor."Global Dimension 2 Code";
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount<>0 then
                                GenJournalLine.Insert;
                                end;//Vendor
                                end;//Member
                              end;//CASE Shares Deposit

                             AgentTransactions."transaction type"::LoanRepayment:
                              begin
                               //  AgentTransactions.Amount :=-AgentTransactions.Amount;
                              Members.Reset;
                              Members.SetRange(Members."No.", AgentTransactions."Account No.");
                              if Members.Find('-') then begin
                              Vendor.Reset;
                              Vendor.SetRange(Vendor."No.", AgentTransactions."Account No.");
                             // Vendor.SETRANGE(Vendor."Account Type", 'ORDINARY');
                               if Vendor.Find('-') then begin

                                    //Cr Customer
                                    LoansRegister.Reset;
                                    LoansRegister.SetRange(LoansRegister."Loan  No.",AgentTransactions."Loan No");
                                    LoansRegister.SetRange(LoansRegister."Client Code",Members."No.");

                                    if LoansRegister.Find('+') then begin
                                    LoansRegister.CalcFields(LoansRegister."Outstanding Balance",LoansRegister."Oustanding Interest");
                                    if LoansRegister."Outstanding Balance" > 0 then begin

                                    LineNo:=LineNo+10000;

                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name":='GENERAL';
                                    GenJournalLine."Journal Batch Name":='Agency';
                                    GenJournalLine."Line No.":=LineNo;

                                    GenJournalLine."Account Type":=GenJournalLine."account type"::Member;
                                    GenJournalLine.Validate(GenJournalLine."Account Type");
                                    GenJournalLine."Account No.":=LoansRegister."Client Code";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");

                                    GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"Bank Account";
                                    GenJournalLine.Validate(GenJournalLine."Bal. Account Type");
                                    GenJournalLine."Bal. Account No.":=AgentApps.Account;
                                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");

                                    GenJournalLine."Document No.":=AgentTransactions."Document No.";
                                    GenJournalLine."External Document No.":='';
                                    GenJournalLine."Posting Date":=Today;
                                    GenJournalLine.Description:='Loan Interest Payment -'+AgentTransactions."Account Name";

                                    if AgentTransactions.Amount > LoansRegister."Oustanding Interest" then
                                    GenJournalLine.Amount:=-LoansRegister."Oustanding Interest"
                                    else
                                    GenJournalLine.Amount:=-AgentTransactions.Amount;
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Interest Paid";
                                    GenJournalLine.Validate(GenJournalLine."Transaction Type");

                                    if GenJournalLine."Shortcut Dimension 1 Code" = '' then begin
                                    GenJournalLine."Shortcut Dimension 1 Code":=Members."Global Dimension 1 Code";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    end;
                                    GenJournalLine."Loan No":=LoansRegister."Loan  No.";
                                    if GenJournalLine.Amount<>0 then
                                    GenJournalLine.Insert;
                                     end;

                                    AgentTransactions.Amount:=AgentTransactions.Amount+GenJournalLine.Amount;

                                    if AgentTransactions.Amount>0 then begin

                                    LineNo:=LineNo+10000;

                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name":='GENERAL';
                                    GenJournalLine."Journal Batch Name":='Agency';
                                    GenJournalLine."Line No.":=LineNo;

                                    GenJournalLine."Account Type":=GenJournalLine."account type"::Member;
                                    GenJournalLine.Validate(GenJournalLine."Account Type");
                                    GenJournalLine."Account No.":=LoansRegister."Client Code";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");

                                    GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"Bank Account";
                                    GenJournalLine.Validate(GenJournalLine."Bal. Account Type");
                                    GenJournalLine."Bal. Account No.":=AgentApps.Account;
                                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");

                                    GenJournalLine."Document No.":=AgentTransactions."Document No.";
                                    GenJournalLine."External Document No.":='';
                                    GenJournalLine."Posting Date":=Today;
                                    GenJournalLine.Description:='Loan repayment -'+AgentTransactions."Account Name";
                                    GenJournalLine.Amount:=-AgentTransactions.Amount;
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Loan Repayment";
                                    if GenJournalLine."Shortcut Dimension 1 Code" = '' then begin
                                    GenJournalLine."Shortcut Dimension 1 Code":=Members."Global Dimension 1 Code";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    end;
                                    GenJournalLine."Loan No":=LoansRegister."Loan  No.";
                                    if GenJournalLine.Amount<>0 then
                                    GenJournalLine.Insert;

         //Dr Customer
                                LineNo:=LineNo+10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name":='GENERAL';
                                GenJournalLine."Journal Batch Name":='Agency';
                                GenJournalLine."Line No.":=LineNo;
                                GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                                GenJournalLine."Account No.":=Vendor."No.";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Document No.":=AgentTransactions."Document No.";
                                GenJournalLine."External Document No.":=AgentApps."Agent Code";
                                GenJournalLine."Posting Date":=AgentTransactions."Transaction Date";
                                GenJournalLine.Description:='Agency Banking Charges';
                                GenJournalLine.Amount:=TotalCommission+ExcDuty;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Shortcut Dimension 1 Code":=Vendor."Global Dimension 1 Code";
                                GenJournalLine."Shortcut Dimension 2 Code":=Vendor."Global Dimension 2 Code";
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount<>0 then
                                GenJournalLine.Insert;

                                //Cr Excise Duty
                                LineNo:=LineNo+10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name":='GENERAL';
                                GenJournalLine."Journal Batch Name":='Agency';
                                GenJournalLine."Line No.":=LineNo;
                                GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                                GenJournalLine."Account No.":=ExxcDuty;
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Document No.":=AgentTransactions."Document No.";
                                GenJournalLine."External Document No.":=AgentApps."Agent Code";
                                GenJournalLine."Posting Date":=AgentTransactions."Transaction Date";
                                GenJournalLine.Description:='Excise Duty-Agency Charges';
                                GenJournalLine.Amount:=-1*ExcDuty;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Shortcut Dimension 1 Code":=Vendor."Global Dimension 1 Code";
                                GenJournalLine."Shortcut Dimension 2 Code":=Vendor."Global Dimension 2 Code";
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount<>0 then
                                GenJournalLine.Insert;

                                LineNo:=LineNo+10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name":='GENERAL';
                                GenJournalLine."Journal Batch Name":='Agency';
                                GenJournalLine."Line No.":=LineNo;
                                GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                                GenJournalLine."Account No.":=CloudPESACommACC;
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Document No.":=AgentTransactions."Document No.";
                                GenJournalLine."External Document No.":=AgentApps."Agent Code";
                                GenJournalLine."Posting Date":=AgentTransactions."Transaction Date";
                                GenJournalLine.Description:='Agency Banking Charges';
                                GenJournalLine.Amount:=-1*commVendor;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Shortcut Dimension 1 Code":=Vendor."Global Dimension 1 Code";
                                GenJournalLine."Shortcut Dimension 2 Code":=Vendor."Global Dimension 2 Code";
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount<>0 then
                                GenJournalLine.Insert;

                                //Cr Sacco
                                LineNo:=LineNo+10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name":='GENERAL';
                                GenJournalLine."Journal Batch Name":='Agency';
                                GenJournalLine."Line No.":=LineNo;
                                GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                                GenJournalLine."Account No.":=AgentChargesAcc;
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."Document No.":=AgentTransactions."Document No.";
                                GenJournalLine."External Document No.":=AgentApps."Agent Code";
                                GenJournalLine."Posting Date":=AgentTransactions."Transaction Date";
                                GenJournalLine.Description:='Agency Banking Charges';
                                GenJournalLine.Amount:=-1*commSacco;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Shortcut Dimension 1 Code":=Vendor."Global Dimension 1 Code";
                                GenJournalLine."Shortcut Dimension 2 Code":=Vendor."Global Dimension 2 Code";
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount<>0 then
                                GenJournalLine.Insert;
                                    end;
                                    end;//LoansRegister
                                    end;//Vendor
                                    end;//Member
                                  end;//CASE Loan Repayment



                             AgentTransactions."transaction type"::Schoolfeespayment,AgentTransactions."transaction type"::Schoolfeespayment,AgentTransactions."transaction type"::Schoolfeespayment,
                             AgentTransactions."transaction type"::Schoolfeespayment,AgentTransactions."transaction type"::Schoolfeespayment:
                                 begin
                                AgentTransactions.Amount :=AgentTransactions.Amount*-1;
                               if (AgentTransactions."Transaction Type"=AgentTransactions."transaction type"::Schoolfeespayment) then begin
                                LineNo:=LineNo+10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name":='GENERAL';
                                GenJournalLine."Journal Batch Name":='Agency';
                                GenJournalLine."Line No.":=LineNo;
                                GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                                GenJournalLine."Account No.":='401130';
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                GenJournalLine."Document No.":=AgentTransactions."Document No.";
                                GenJournalLine."External Document No.":=AgentApps."Agent Code";
                                GenJournalLine."Posting Date":=AgentTransactions."Transaction Date";
                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Share Capital";
                                GenJournalLine."Shortcut Dimension 1 Code":='BOSA';
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Description:=AgentTransactions.Description;
                                GenJournalLine.Amount:=AgentTransactions.Amount;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount<>0 then
                                GenJournalLine.Insert;
                              end;
                               if (AgentTransactions."Transaction Type"=AgentTransactions."transaction type"::Schoolfeespayment) then begin
                                LineNo:=LineNo+10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name":='GENERAL';
                                GenJournalLine."Journal Batch Name":='Agency';
                                GenJournalLine."Line No.":=LineNo;
                                GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                                GenJournalLine."Account No.":='401270';
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                GenJournalLine."Document No.":=AgentTransactions."Document No.";
                                GenJournalLine."External Document No.":=AgentApps."Agent Code";
                                GenJournalLine."Posting Date":=AgentTransactions."Transaction Date";
                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Share Capital";
                                GenJournalLine."Shortcut Dimension 1 Code":='BOSA';
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Description:=AgentTransactions.Description;
                                GenJournalLine.Amount:=AgentTransactions.Amount;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount<>0 then
                                GenJournalLine.Insert;

                               end;//pay fine
                               if (AgentTransactions."Transaction Type"=AgentTransactions."transaction type"::Schoolfeespayment) then begin
                                LineNo:=LineNo+10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name":='GENERAL';
                                GenJournalLine."Journal Batch Name":='Agency';
                                GenJournalLine."Line No.":=LineNo;
                                GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                                GenJournalLine."Account No.":='401220';
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                GenJournalLine."Document No.":=AgentTransactions."Document No.";
                                GenJournalLine."External Document No.":=AgentApps."Agent Code";
                                GenJournalLine."Posting Date":=AgentTransactions."Transaction Date";
                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Share Capital";
                                GenJournalLine."Shortcut Dimension 1 Code":='BOSA';
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Description:=AgentTransactions.Description;
                                GenJournalLine.Amount:=AgentTransactions.Amount;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount<>0 then
                                GenJournalLine.Insert;
                               end;
                               if (AgentTransactions."Transaction Type"=AgentTransactions."transaction type"::Schoolfeespayment) then begin
                                LineNo:=LineNo+10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name":='GENERAL';
                                GenJournalLine."Journal Batch Name":='Agency';
                                GenJournalLine."Line No.":=LineNo;
                                GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                                GenJournalLine."Account No.":='401120';
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                GenJournalLine."Document No.":=AgentTransactions."Document No.";
                                GenJournalLine."External Document No.":=AgentApps."Agent Code";
                                GenJournalLine."Posting Date":=AgentTransactions."Transaction Date";
                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::Loan;
                                GenJournalLine."Shortcut Dimension 1 Code":='BOSA';
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Description:=AgentTransactions.Description;
                                GenJournalLine.Amount:=AgentTransactions.Amount;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount<>0 then
                                GenJournalLine.Insert;
                               end;
                               if (AgentTransactions."Transaction Type"=AgentTransactions."transaction type"::Schoolfeespayment) then begin
                                LineNo:=LineNo+10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name":='GENERAL';
                                GenJournalLine."Journal Batch Name":='Agency';
                                GenJournalLine."Line No.":=LineNo;
                                GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                                GenJournalLine."Account No.":='401110';
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                GenJournalLine."Document No.":=AgentTransactions."Document No.";
                                GenJournalLine."External Document No.":=AgentApps."Agent Code";
                                GenJournalLine."Posting Date":=AgentTransactions."Transaction Date";
                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Share Capital";
                                GenJournalLine."Shortcut Dimension 1 Code":='BOSA';
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Description:=AgentTransactions.Description;
                                GenJournalLine.Amount:=AgentTransactions.Amount;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                if GenJournalLine.Amount<>0 then
                                GenJournalLine.Insert;

                               end;

        //Debit/Credit agent

                                LineNo:=LineNo+10000;
                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name":='GENERAL';
                                GenJournalLine."Journal Batch Name":='Agency';
                                GenJournalLine."Line No.":=LineNo;
                                GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"Bank Account";
                                GenJournalLine.Validate(GenJournalLine."Bal. Account Type");
                                GenJournalLine."Bal. Account No.":=AgentApps.Account;
                                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                                GenJournalLine."Document No.":=AgentTransactions."Document No.";
                                GenJournalLine."External Document No.":=AgentApps."Agent Code";
                                GenJournalLine."Posting Date":=AgentTransactions."Transaction Date";
                                GenJournalLine.Description:=AgentTransactions.Description  +'-'+AgentTransactions."Account Name";
                                GenJournalLine.Amount:=AgentTransactions.Amount;
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Shortcut Dimension 1 Code":=Vendor."Global Dimension 1 Code";
                                GenJournalLine."Shortcut Dimension 2 Code":=Vendor."Global Dimension 2 Code";
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount<>0 then
                                GenJournalLine.Insert;
                              end;
                                //END;

                          end;

                                if registrationup=true then begin
                                   res:=true;
                                  end else begin
                                  //Post
                                  GenJournalLine.Reset;
                                  GenJournalLine.SetRange("Journal Template Name",'GENERAL');
                                  GenJournalLine.SetRange("Journal Batch Name",'Agency');
                                  if GenJournalLine.Find('-') then begin
                                      repeat
                                     GLPosting.Run(GenJournalLine);
                                      until GenJournalLine.Next = 0;
                                  AgentTransactions.Posted:=true;
                                  AgentTransactions."Date Posted":=Today;
                                  AgentTransactions.Messages:='Completed';
                                  AgentTransactions."Time Posted":=Time;
                                  AgentTransactions.Modify;
                                  res:=true;
                                  end
                                  else begin
                                  AgentTransactions.Posted:=false;
                                  AgentTransactions."Date Posted":=Today;
                                  AgentTransactions.Messages:='Failed';
                                  AgentTransactions."Time Posted":=Time;
                                  AgentTransactions.Modify;
                                  end;
                              end;
                   end;//Agent Apps
               end
               else begin//Check deposit
                     res:=false;
                  end
        end;//Agent Transactions
    end;

    local procedure Blocked(Account: Code[30]) status: Boolean
    begin
          Vendor.Reset;
          Vendor.SetRange(Vendor."No.",Account);
          if Vendor.Find('-') then begin
            if Vendor.Blocked=Vendor.Blocked::All then begin
            status:=true;
            end
            else if Vendor.Blocked=Vendor.Blocked::Payment then begin
            status:=true;
            end
            else begin
            status:=false;
            end
          end
    end;


    procedure GetAgentSummary(AgentCode: Code[50];var AgentTran: BigText) result: Text
    var
        TotalWithdran: Decimal;
        TotalDeposit: Decimal;
    begin
        TotalDeposit:=0;
        TotalWithdran:=0;
        AgentTransactions.Reset;
        AgentTransactions.SetRange(AgentTransactions."Agent Code",AgentCode);
        AgentTransactions.SetRange(AgentTransactions."Transaction Date",Today);
        if AgentTransactions.Find('-') then begin
          repeat
          if AgentTransactions."Transaction Type"=AgentTransactions."transaction type"::Transfer then begin

            end else begin
              if AgentTransactions.Amount<0 then begin
                  TotalDeposit:=TotalDeposit+AgentTransactions.Amount;
                end else begin
                  TotalWithdran:=TotalWithdran+AgentTransactions.Amount;
                  end;

            end;
          AgentTran.AddText( Format(AgentTransactions."Transaction Time") +':::'+AgentTransactions.Description+':::' + Format(AgentTransactions.Amount*-1)+':::' + Format(AgentTransactions."Document No.")+'::::');
            until AgentTransactions.Next=0;

             AgentApps.Reset;
             AgentApps.SetRange(AgentApps."Agent Code",AgentCode);
             if AgentApps.Find('-') then begin
             end;

          AgentTran.AddText( '1' +'::: Total Deposits:::' + Format(TotalDeposit*-1)+':::1::::');
          AgentTran.AddText( '2' +'::: Total Withdrawal:::' + Format(TotalWithdran)+':::2::::');



        end;
         AgentTran.AddText(Format(CurrentDatetime)+':::Agent Float :::'+Format(GetAccountBalance(AgentApps.Account))+':::3');
    end;


    procedure GetFosaStatement(account: Code[20];var VarFosaTran: BigText) Statement: Text[500]
    begin
          begin
          Vendor.Reset;
          Vendor.SetRange("No.",account);
          if Vendor.Find('-') then begin

            VendorLedgEntry.Reset;
            VendorLedgEntry.SetCurrentkey(VendorLedgEntry."Entry No.");
            VendorLedgEntry.Ascending(false);
            VendorLedgEntry.SetRange(VendorLedgEntry."Vendor No.",Vendor."No.");
            VendorLedgEntry.SetRange(VendorLedgEntry.Reversed,VendorLedgEntry.Reversed::"0");
              if VendorLedgEntry.Find('-') then begin

                repeat
                   VendorLedgEntry.CalcFields(VendorLedgEntry.Amount);
                   VarFosaTran.AddText( Format(VendorLedgEntry."Posting Date") +':::'+VendorLedgEntry.Description+':::' + Format(Abs(VendorLedgEntry.Amount))+':::' + Format(VendorLedgEntry."Document No.")+'::::');
                  minimunCount:= minimunCount +1;
                  if   minimunCount>20 then
                  exit
                until VendorLedgEntry.Next =0
              end
              end;
          end;
    end;


    procedure GetLoanStatement(account: Code[20];Loanno: Code[50];var VarLoanTran: BigText) Statement: Text[500]
    begin

            MemberLedgerEntry.Reset;
            MemberLedgerEntry.SetCurrentkey(MemberLedgerEntry."Entry No.");
            MemberLedgerEntry.Ascending(false);
            MemberLedgerEntry.SetRange(MemberLedgerEntry."Loan No",Loanno);
            MemberLedgerEntry.SetRange(MemberLedgerEntry.Reversed,MemberLedgerEntry.Reversed::"0");
              if MemberLedgerEntry.Find('-') then begin
                Statement:='';
                repeat
                   VarLoanTran.AddText( Format(MemberLedgerEntry."Posting Date") +':::'+MemberLedgerEntry.Description+':::' + Format(Abs(MemberLedgerEntry.Amount))+':::' + Format(MemberLedgerEntry."Document No.")+'::::');
                  minimunCount:= minimunCount +1;
                  if   minimunCount>20 then
                  exit
                until MemberLedgerEntry.Next =0
              end
              //END;
         // END;
    end;

    local procedure GetAccount(Account: Code[100]) accountNo: Code[50]
    begin
        Members.Reset;
        Members.SetRange(Members."No.",Account);
        if Members.Find('-') then begin
          accountNo:=Members."No.";
          exit(accountNo);
          end else begin
            Members.Reset;
            Members.SetRange(Members."ID No.",Account);
            if Members.Find('-') then begin
               accountNo:=Members."No.";
                exit(accountNo);
              end else begin
                Vendor.Reset;
                Vendor.SetRange(Vendor."ID No.",Account);
                if Vendor.Find('-') then begin
                   accountNo:=Vendor."BOSA Account No";
                   exit(accountNo);
                  end else begin
                     exit(Account);
                    end;

        end;
        end;
    end;


    procedure GetAccountTypes() accountTypeList: Text[1000]
    begin
        begin
        AccountTypes.Reset;
        AccountTypes.SetRange(AccountTypes."Default Account",false);
          if AccountTypes.Find('-') then begin
          accountTypeList:='';
          repeat
          accountTypeList:=accountTypeList+'-:-'+AccountTypes.Code+':::'+AccountTypes.Description;
          until AccountTypes.Next =0;
          end
          else
          begin
          accountTypeList:='none';
          end
        end;
    end;


    procedure GetAccountExist(Account: Code[50];"CODE": Code[50]) res: Text
    begin

        if CODE='FOSA' then begin
          objNewAccount.Reset;
          objNewAccount.SetRange(objNewAccount."BOSA Account No", Account);
          objNewAccount.SetRange(objNewAccount."Account Type", 'ORDINARY');
          objNewAccount.SetRange(Status, objNewAccount.Status::Open);
          if objNewAccount.Find('-') then begin
          exit('Account Type already registered');
           end else  begin
           Vendor.Reset;
           Vendor.SetRange(Vendor."BOSA Account No",Account);
            Vendor.SetRange(Vendor."Account Type", 'ORDINARY');
            if Vendor.Find('-') then begin
               exit('Account Type already created');
            end;
            exit('None');

        end;
        end else if CODE='MEMBER' then begin
          objRegMember.Reset;
          objRegMember.SetRange("ID No.",Account);
          if objRegMember.Find('-') then begin
             exit('Account Type already registered waiting for approval');
          end else begin
            Members.Reset;
            Members.SetRange("ID No.",Account);
            if Members.Find('-') then begin
             exit('Account Type  ORDINARY already registered');
              end;
              exit('None');

            end;
        end;
    end;
}

