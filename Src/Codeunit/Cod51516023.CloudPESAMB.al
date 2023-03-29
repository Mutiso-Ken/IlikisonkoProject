#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 51516023 "CloudPESAMB"
{

    trigger OnRun()
    begin
        //MESSAGE(AccountBalance('10101382','990456146523'));
        //MESSAGE(InsertTransaction('InsertTransaction','101','10102307','SHADRACK NZUMA MUSYOKI','0703430879',1,224646,'323730'));
        Message(PaybillSwitch());
        //MESSAGE(PaybillSwitchFailed());
        // LoanGuarantors('FLN_00246') <> '' THEN BEGIN
          //ERROR('tEST ONE AccountBalanceDec('001-002388-001',10)));
        //MESSAGE(AccountBalanceNew('000011','145477'));
        //MESSAGE(AccountBalanceNew('000011','983788l5088'));
        //MESSAGE(MiniStatement('0703430879','26112344111561324'));
        //MESSAGE(LoanBfsuresalances('+254720394863'));
        //MESSAGE(UPDATEContactsToserver('+254720394863'));
        //MESSAGE(UpdateSurePESARegistration('000011'));
        //MESSAGE(MemberAccounts('0703430879'));
        //MESSAGE(MemberAccountNumbers('0703430879'));
        //MESSAGE(WSSAccount('0703430879'));
        //SMSMessage('45306373709','002037','0703430879','Test sms mutinda');
        //MESSAGE(PostMPESATrans('NB77OTGAXZn','101002645',500,TODAY));
        //MESSAGE(OutstandingLoans('0703430879'));
        //MESSAGE(LoanGuarantors('BLN0033'));
        //MESSAGE(LoansGuaranteed('0727492650'));
        //MESSAGE(OutstandingLoansUSSD('0703430879'));
        //MESSAGE(FORMAT(AdvanceEligibility('101000546')));
        //MESSAGE(LoanRepayment('10102307','4975','781135546372',1000));
        //MESSAGE(SurePESARegistration());
        //MESSAGE(PostAdvance('556711234567','101002645',200,3));
        //MESSAGE(FORMAT(AdvanceEligibility('101001039')));
        //MESSAGE(LoanBalances('0703430879'));
        //MESSAGE(RegisteredMemberDetails('0703430879'));
        //MESSAGE(FundsTransferFOSA('10102307','10102308','234156229621',20000));
        //MESSAGE(FundsTransferOTHER('10101382','10102307','9875666229621',50000));
        //MESSAGE(FundsTransferBOSA('10102307','Deposit Contribution','5224638265378',200));
        //MESSAGE(SharesUSSD('0703430879','4567890987'));
        //fnProcessNotification();
        //MESSAGE(Loancalculator());
    end;

    var
        Vendor: Record Vendor;
        AccountTypes: Record "Account Types-Saving Products";
        miniBalance: Decimal;
        accBalance: Decimal;
        minimunCount: Integer;
        VendorLedgEntry: Record "Vendor Ledger Entry";
        amount_G: Decimal;
        Loans: Integer;
        LoansRegister: Record "Loans Register";
        LoanProductsSetup: Record "Loan Products Setup";
        Members: Record "Member Register";
        dateExpression: Text[20];
        DetailedVendorLedgerEntry: Record "Detailed Vendor Ledg. Entry";
        dashboardDataFilter: Date;
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        MemberLedgerEntry: Record "Member Ledger Entry";
        CloudPESAApplications: Record "CloudPESA Applications";
        GenJournalLine: Record "Gen. Journal Line";
        GenBatches: Record "Gen. Journal Batch";
        LineNo: Integer;
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        CloudPESATrans: Record "CloudPESA Transactions";
        GenLedgerSetup: Record "General Ledger Setup";
        Charges: Record Charges;
        MobileCharges: Decimal;
        MobileChargesACC: Text[20];
        CloudPESACommACC: Code[20];
        CloudPESACharge: Decimal;
        ExcDuty: Decimal;
        TempBalance: Decimal;
        SMSMessages: Record "SMS Messages";
        iEntryNo: Integer;
        msg: Text[1024];
        accountName1: Text[40];
        accountName2: Text[40];
        fosaAcc: Text[30];
        LoanGuaranteeDetails: Record "Loans Guarantee Details";
        bosaNo: Text[20];
        MPESARecon: Text[20];
        TariffDetails: Record "Tariff Details";
        MPESACharge: Decimal;
        TotalCharges: Decimal;
        ExxcDuty: label '20042';
        PaybillTrans: Record "CloudPESA MPESA Trans";
        PaybillRecon: Code[30];
        fosaConst: label '101';
        ChargeAmount: Decimal;
        glamount: Decimal;
        FreeShares: Decimal;
        LoanGuard: Record "Loans Guarantee Details";
        GenSetup: Record "Sacco General Set-Up";
        GLEntries: Record "G/L Entry";
        airtimeAcc: Code[50];
        debitAmount: Decimal;
        mobilephone: Code[50];
        MpesaDisbus: Record "Mobile Loans";
        MpesaAccount: Code[50];
        SFactory: Codeunit "SURESTEP Factory";
        datFirstDayOfMonth: Date;
        datlastDayOfMonth: Date;
        datefilternow: Text;
        RSchedule: Record "Loan Repayment Schedule";
        I: Integer;
        RentCollectionCommACC: Code[20];
        RentCollectionCharge: Decimal;


    procedure AccountBalance(Acc: Code[30];DocNumber: Code[20]) Bal: Text[500]
    var
        amount: Decimal;
    begin

        CloudPESATrans.Reset;
        CloudPESATrans.SetRange(CloudPESATrans."Document No", DocNumber);
        if CloudPESATrans.Find('-') then begin
          Bal:='REFEXISTS';
        end else begin
          Bal:='';
          GenLedgerSetup.Reset;
          GenLedgerSetup.Get;
          GenLedgerSetup.TestField(GenLedgerSetup."Mobile Charge");
          GenLedgerSetup.TestField(GenLedgerSetup."CloudPESA Comm Acc");
          GenLedgerSetup.TestField(GenLedgerSetup."CloudPESA Charge");

          Charges.Reset;
          Charges.SetRange(Charges.Code,GenLedgerSetup."Mobile Charge");
          if Charges.Find('-') then begin
            Charges.TestField(Charges."GL Account");
            MobileCharges:= Charges."Charge Amount";
            MobileChargesACC:=Charges."GL Account";
          end;

            CloudPESACommACC:=  GenLedgerSetup."CloudPESA Comm Acc";
            CloudPESACharge:=GenLedgerSetup."CloudPESA Charge";

            ExcDuty:=(20/100)*(MobileCharges+CloudPESACharge);

            TotalCharges:=ExcDuty+(MobileCharges+CloudPESACharge);

            Vendor.Reset;
            Vendor.SetRange(Vendor."No.",Acc);
            if Vendor.Find('-') then begin
              AccountTypes.Reset;
              AccountTypes.SetRange(AccountTypes.Code,Vendor."Account Type")  ;
              //AccountTypes.SETRANGE(AccountTypes."Last Account No Used(HQ)",FALSE);
              if AccountTypes.Find('-') then begin
                miniBalance:=AccountTypes."Minimum Balance";
              end;

              Vendor.CalcFields(Vendor."Balance (LCY)");
              TempBalance:=Vendor."Balance (LCY)"-(Vendor."ATM Transactions"+Vendor."Uncleared Cheques"+Vendor."EFT Transactions"+miniBalance);

              if Vendor."Account Type"='ORDINARY' then begin
                if (TempBalance>MobileCharges+CloudPESACharge) then begin
                  GenJournalLine.Reset;
                  GenJournalLine.SetRange("Journal Template Name",'GENERAL');
                  GenJournalLine.SetRange("Journal Batch Name",'MOBILETRAN');
                  GenJournalLine.DeleteAll;
                  //end of deletion

                  GenBatches.Reset;
                  GenBatches.SetRange(GenBatches."Journal Template Name",'GENERAL');
                  GenBatches.SetRange(GenBatches.Name,'MOBILETRAN');

                  if GenBatches.Find('-') = false then begin
                  GenBatches.Init;
                  GenBatches."Journal Template Name":='GENERAL';
                  GenBatches.Name:='MOBILETRAN';
                  GenBatches.Description:='Balance Enquiry';
                  GenBatches.Validate(GenBatches."Journal Template Name");
                  GenBatches.Validate(GenBatches.Name);
                  GenBatches.Insert;
                  end;

                //Dr Mobile Transfer Charges
                  LineNo:=LineNo+10000;
                  GenJournalLine.Init;
                  GenJournalLine."Journal Template Name":='GENERAL';
                  GenJournalLine."Journal Batch Name":='MOBILETRAN';
                  GenJournalLine."Line No.":=LineNo;
                  GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                  GenJournalLine."Account No.":=Acc;
                  GenJournalLine.Validate(GenJournalLine."Account No.");
                  GenJournalLine."Document No.":=DocNumber;
                  GenJournalLine."External Document No.":=Acc;
                  GenJournalLine."Posting Date":=Today;
                  GenJournalLine.Description:='Balance Enquiry';
                  GenJournalLine.Amount:=(MobileCharges+CloudPESACharge);
                  GenJournalLine.Validate(GenJournalLine.Amount);
                  if GenJournalLine.Amount<>0 then
                  GenJournalLine.Insert;

                //DR Excise Duty
                        LineNo:=LineNo+10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='GENERAL';
                        GenJournalLine."Journal Batch Name":='MOBILETRAN';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No.":=Acc;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No.":=DocNumber;
                        GenJournalLine."External Document No.":=Acc;
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine.Description:='Excise duty-Balance Enquiry';
                        GenJournalLine.Amount:=ExcDuty;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;

                        //CR Ex. Duty
                        LineNo:=LineNo+10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='GENERAL';
                        GenJournalLine."Journal Batch Name":='MOBILETRAN';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Account No.":=ExxcDuty;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No.":=DocNumber;
                        GenJournalLine."External Document No.":=MobileChargesACC;
                        GenJournalLine."Source No.":=Vendor."No.";
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine.Description:='Excise duty-Balance Enquiry';
                        GenJournalLine.Amount:=ExcDuty*-1;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;

                //CR Commission
                        LineNo:=LineNo+10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='GENERAL';
                        GenJournalLine."Journal Batch Name":='MOBILETRAN';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Account No.":=CloudPESACommACC;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No.":=DocNumber;
                        GenJournalLine."External Document No.":=MobileChargesACC;
                         GenJournalLine."Source No.":=Vendor."No.";
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine.Description:='Balance Enquiry Charges';
                        GenJournalLine.Amount:=-CloudPESACharge;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;

                //CR Mobile Transactions Acc
                        LineNo:=LineNo+10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='GENERAL';
                        GenJournalLine."Journal Batch Name":='MOBILETRAN';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Account No.":=MobileChargesACC;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No.":=DocNumber;
                        GenJournalLine."External Document No.":=MobileChargesACC;
                        GenJournalLine."Posting Date":=Today;
                         GenJournalLine."Source No.":=Vendor."No.";
                        GenJournalLine.Description:='Balance Enquiry Charges';
                        GenJournalLine.Amount:=MobileCharges*-1;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;

                        //Post
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name",'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name",'MOBILETRAN');
                        if GenJournalLine.Find('-') then begin
                        repeat
                        GLPosting.Run(GenJournalLine);
                        until GenJournalLine.Next = 0;
                        end;
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name",'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name",'MOBILETRAN');
                        GenJournalLine.DeleteAll;

                        CloudPESATrans.Init;
                        CloudPESATrans."Document No":=DocNumber;
                        CloudPESATrans.Description:='Balance Enquiry';
                        CloudPESATrans."Document Date":=Today;
                        CloudPESATrans."Account No" :=Vendor."No.";
                        CloudPESATrans.Charge:=TotalCharges;
                         CloudPESATrans."Account Name":=Vendor.Name;
                         //CloudPESATrans."Payroll Number":=Vendor."Payroll/Staff No2";
                          //CloudPESATrans."Payroll Number":=Vendor."Account Special Instructions";
                          CloudPESATrans."Telephone Number":=Vendor."Mobile Phone No";
                        CloudPESATrans."Account No2" :='';
                        CloudPESATrans.Amount:=amount;
                        CloudPESATrans.Posted:=true;
                        CloudPESATrans."Posting Date":=Today;
                        CloudPESATrans.Status:=CloudPESATrans.Status::Completed;
                        CloudPESATrans.Comments:='Success';
                        CloudPESATrans.Client:=Vendor."BOSA Account No";
                        CloudPESATrans."Transaction Type":=CloudPESATrans."transaction type"::Balance;
                        CloudPESATrans."Transaction Time":=Time;
                        CloudPESATrans.Insert;
                        AccountTypes.Reset;
                        AccountTypes.SetRange(AccountTypes.Code,Vendor."Account Type")  ;
                      //  AccountTypes.SETFILTER(AccountTypes."Last Account No Used(HQ)",'=%1',FALSE);    //Restrict account types
                        if AccountTypes.Find('-') then begin
                          miniBalance:=AccountTypes."Minimum Balance";
                        end;
                        Vendor.CalcFields(Vendor."Balance (LCY)");
                        Vendor.CalcFields(Vendor."ATM Transactions");
                        Vendor.CalcFields(Vendor."Uncleared Cheques");
                        Vendor.CalcFields(Vendor."EFT Transactions");
                        accBalance:=Vendor."Balance (LCY)"-(Vendor."ATM Transactions"+Vendor."Uncleared Cheques"+Vendor."EFT Transactions"+miniBalance);
                        Bal:=Format(accBalance);
                        end
                       else begin
                         Bal:='INSUFFICIENT';
                       end;
                       end
                       else begin
                          AccountTypes.Reset;
                          AccountTypes.SetRange(AccountTypes.Code,Vendor."Account Type");
                         // AccountTypes.SETFILTER(AccountTypes."Last Account No Used(HQ)",'=%1',FALSE);  //Restrict account types
                          if AccountTypes.Find('-') then
                          begin
                            miniBalance:=AccountTypes."Minimum Balance";
                          end;
                          Vendor.CalcFields(Vendor."Balance (LCY)");
                          Vendor.CalcFields(Vendor."ATM Transactions");
                          Vendor.CalcFields(Vendor."Uncleared Cheques");
                          Vendor.CalcFields(Vendor."EFT Transactions");
                          accBalance:=Vendor."Balance (LCY)"-(Vendor."ATM Transactions"+Vendor."Uncleared Cheques"+Vendor."EFT Transactions"+miniBalance);
                          Bal:=Format(accBalance);
                       end;
                end
                else begin
                  Bal:='ACCNOTFOUND';
                end;
              end;
          //END;
    end;


    procedure MiniStatement(Phone: Text[20];DocNumber: Text[20]) MiniStmt: Text[250]
    var
        amount: Decimal;
    begin
        begin
        CloudPESATrans.Reset;
        CloudPESATrans.SetRange(CloudPESATrans."Document No", DocNumber);
        if CloudPESATrans.Find('-') then begin
          MiniStmt:='REFEXISTS';
        end
        else begin
          MiniStmt :='';
          GenLedgerSetup.Reset;
          GenLedgerSetup.Get;
          GenLedgerSetup.TestField(GenLedgerSetup."Mobile Charge");
          GenLedgerSetup.TestField(GenLedgerSetup."CloudPESA Comm Acc");
          GenLedgerSetup.TestField(GenLedgerSetup."CloudPESA Charge");
         // GenLedgerSetup.TESTFIELD(GenLedgerSetup.MinistatementCharge);

          Charges.Reset;
          Charges.SetRange(Charges.Code,GenLedgerSetup."Mobile Charge");
          if Charges.Find('-') then begin
            Charges.TestField(Charges."GL Account");
            MobileChargesACC:=Charges."GL Account";
             MobileCharges:=0; //Charges."Charge Amount";
          end;

            CloudPESACommACC:=  GenLedgerSetup."CloudPESA Comm Acc";
             CloudPESACharge:=GenLedgerSetup."CloudPESA Charge";
            //MobileCharges:=0; //GenLedgerSetup.MinistatementCharge;

             ExcDuty:=(20/100)*(MobileCharges+CloudPESACharge);
            TotalCharges:=ExcDuty+(MobileCharges+CloudPESACharge);

            Vendor.Reset;
            Vendor.SetRange(Vendor."No." ,Phone);
            if Vendor.Find('-') then begin
              AccountTypes.Reset;
                AccountTypes.SetRange(AccountTypes.Code,Vendor."Account Type")  ;
                //AccountTypes.SETRANGE(AccountTypes."Last Account No Used(HQ)",FALSE);
                if AccountTypes.Find('-') then
                begin
                  miniBalance:=AccountTypes."Minimum Balance";
                end;

             Vendor.CalcFields(Vendor."Balance (LCY)");
             TempBalance:=Vendor."Balance (LCY)"-(Vendor."ATM Transactions"+Vendor."Uncleared Cheques"+Vendor."EFT Transactions"+miniBalance);
             fosaAcc:=Vendor."No.";

                  if (TempBalance>CloudPESACharge) then begin
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name",'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name",'MOBILETRAN');
                        GenJournalLine.DeleteAll;
                        //end of deletion

                        GenBatches.Reset;
                        GenBatches.SetRange(GenBatches."Journal Template Name",'GENERAL');
                        GenBatches.SetRange(GenBatches.Name,'MOBILETRAN');

                        if GenBatches.Find('-') = false then begin
                        GenBatches.Init;
                        GenBatches."Journal Template Name":='GENERAL';
                        GenBatches.Name:='MOBILETRAN';
                        GenBatches.Description:='Mini Statement';
                        GenBatches.Validate(GenBatches."Journal Template Name");
                        GenBatches.Validate(GenBatches.Name);
                        GenBatches.Insert;
                        end;

                //Dr Mobile Transfer Charges
                        LineNo:=LineNo+10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='GENERAL';
                        GenJournalLine."Journal Batch Name":='MOBILETRAN';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No.":=Vendor."No.";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No.":=DocNumber;
                        GenJournalLine."External Document No.":=Vendor."No.";
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine.Description:='Ministatement Charges';
                        GenJournalLine.Amount:=(CloudPESACharge+MobileCharges) ;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;

                //CR Commission
                        LineNo:=LineNo+10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='GENERAL';
                        GenJournalLine."Journal Batch Name":='MOBILETRAN';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Account No.":=MobileChargesACC;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No.":=DocNumber;
                         GenJournalLine."Source No.":=Vendor."No.";
                        GenJournalLine."External Document No.":=MobileChargesACC;
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine.Description:='Mini Statement Charges';
                        GenJournalLine.Amount:=-MobileCharges;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;

                        //DR Excise Duty
                        LineNo:=LineNo+10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='GENERAL';
                        GenJournalLine."Journal Batch Name":='MOBILETRAN';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No.":=Vendor."No.";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No.":=DocNumber;
                        GenJournalLine."External Document No.":=Vendor."No.";
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine.Description:='Excise duty-Balance Enquiry';
                        GenJournalLine.Amount:=ExcDuty;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;

                        //CR Ex. Duty
                        LineNo:=LineNo+10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='GENERAL';
                        GenJournalLine."Journal Batch Name":='MOBILETRAN';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Account No.":=ExxcDuty;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No.":=DocNumber;
                        GenJournalLine."External Document No.":=MobileChargesACC;
                        GenJournalLine."Source No.":=Vendor."No.";
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine.Description:='Excise duty-Balance Enquiry';
                        GenJournalLine.Amount:=ExcDuty*-1;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;

                        //Post
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name",'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name",'MOBILETRAN');
                        if GenJournalLine.Find('-') then begin
                        repeat
                        GLPosting.Run(GenJournalLine);
                        until GenJournalLine.Next = 0;
                        end;
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name",'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name",'MOBILETRAN');
                        GenJournalLine.DeleteAll;

                        CloudPESATrans.Init;
                        CloudPESATrans."Document No":=DocNumber;
                        CloudPESATrans.Description:='Mini Statement';
                        CloudPESATrans."Document Date":=Today;
                        CloudPESATrans."Account No" :=Vendor."No.";
                        TotalCharges:=ExcDuty+MobileCharges+CloudPESACharge;
                          CloudPESATrans.Charge:=TotalCharges;
                         CloudPESATrans."Account Name":=Vendor.Name;
                            CloudPESATrans."Telephone Number":=Vendor."Mobile Phone No";
                        CloudPESATrans."Account No2" :='';
                        CloudPESATrans.Amount:=amount;
                        CloudPESATrans.Posted:=true;
                        CloudPESATrans."Posting Date":=Today;
                        CloudPESATrans.Status:=CloudPESATrans.Status::Completed;
                        CloudPESATrans.Comments:='Success';
                        CloudPESATrans.Client:=Vendor."BOSA Account No";
                        CloudPESATrans."Transaction Type":=CloudPESATrans."transaction type"::Ministatement;
                        CloudPESATrans."Transaction Time":=Time;
                        CloudPESATrans.Insert;

                        minimunCount:=1;
                        Vendor.CalcFields(Vendor.Balance);
                        VendorLedgEntry.Reset;
                        VendorLedgEntry.SetCurrentkey(VendorLedgEntry."Entry No.");
                        VendorLedgEntry.Ascending(false);
                        VendorLedgEntry.SetFilter(VendorLedgEntry.Description,'<>%1','*Charges*');
                        VendorLedgEntry.SetRange(VendorLedgEntry."Vendor No.",Vendor."No.");
                        //VendorLedgEntry.SETFILTER(VendorLedgEntry.Description,'<>*Excise duty*');
                        VendorLedgEntry.SetRange(VendorLedgEntry.Reversed,VendorLedgEntry.Reversed::"0");
                      if VendorLedgEntry.FindSet then begin
                          MiniStmt:='';
                          repeat
                            VendorLedgEntry.CalcFields(VendorLedgEntry.Amount);
                            amount:=VendorLedgEntry.Amount;
                            if amount<1 then
                                amount:= amount*-1;
                                MiniStmt :=MiniStmt + Format(VendorLedgEntry."Posting Date") +':::'+ CopyStr(VendorLedgEntry.Description,1,25) +':::' +
                                Format(amount)+'::::';
                                minimunCount:= minimunCount +1;
                                if minimunCount>10 then
                                exit
                            until VendorLedgEntry.Next =0;
                       end;
                       end
                       else begin
                         MiniStmt:='INSUFFICIENT';
                       end;
                end
                else begin
                  MiniStmt:='ACCNOTFOUND';
                end;
              end;
          end;
    end;


    procedure LoanProducts() LoanTypes: Text[1000]
    begin
        begin
        LoanProductsSetup.Reset;
        LoanProductsSetup.SetRange(LoanProductsSetup.Source, LoanProductsSetup.Source::FOSA);
          if LoanProductsSetup.Find('-') then begin
            repeat
              LoanTypes:=LoanTypes +':::'+LoanProductsSetup."Product Description";
            until LoanProductsSetup.Next =0;
          end
        end
    end;


    procedure BOSAAccount(Phone: Text[20]) bosaAcc: Text[20]
    begin
        Vendor.Reset;
        Vendor.SetRange(Vendor."Mobile Phone No",Phone);
        if Vendor.Find('-') then begin
          Members.Reset;
          Members.SetRange(Members."No.",Vendor."BOSA Account No");
          if Members.Find('-') then begin
            bosaAcc:=Members."No.";
          end;
        end;
    end;


    procedure MemberAccountNumbers(phone: Text[20]) accounts: Text[250]
    begin
        begin
          Vendor.Reset;
          Vendor.SetRange(Vendor."Mobile Phone No",phone);
          Vendor.SetRange(Vendor.Status, Vendor.Status::Active);
          if Vendor.Find('-') then
            begin
               accounts:='';
               repeat
                 accounts:=accounts+'::::'+Vendor."No.";
               until Vendor.Next =0;
            end
          else
          begin
             accounts:='';
          end
          end;
    end;


    procedure RegisteredMemberBranchcode(Phone: Text[20]) reginfo: Text[250]
    begin
          begin
          Vendor.Reset;
          Vendor.SetRange(Vendor."Mobile Phone No", Phone);
          if Vendor.Find('-') then
           begin
              Members.Reset;
              Members.SetRange(Members."No.",Vendor."BOSA Account No");
              if Members.Find('-') then
              begin
              reginfo:=Members."No."+':::'+Members."Global Dimension 2 Code";
              end;
          end
          else
          begin
          reginfo:='';
          end
          end;
    end;


    procedure RegisteredMemberDetails(Phone: Text[20]) reginfo: Text[250]
    begin
          begin
          Vendor.Reset;
          Vendor.SetRange(Vendor."Mobile Phone No", Phone);
          if Vendor.Find('-') then
           begin
              Members.Reset;
              Members.SetRange(Members."No.",Vendor."BOSA Account No");
              if Members.Find('-') then
              begin
              reginfo:=Members."No."+':::'+Members.Name+':::'+Format(Members."ID No.")+':::'+Members."Personal No"+':::'+ Members."E-Mail";
              end;
          end
          else
          begin
          reginfo:='';
          end
          end;
    end;


    procedure DetailedStatement(Phone: Text[20];lastEntry: Integer) detailedstatement: Text[1023]
    begin
        begin
            dateExpression:= '<CD-1M>'; // Current date less 3 months
            dashboardDataFilter := CalcDate(dateExpression, Today);

              Vendor.Reset;
              Vendor.SetRange(Vendor."Mobile Phone No",Phone);
                detailedstatement:='';
              if Vendor.FindSet then repeat
                minimunCount:=1;
                  AccountTypes.Reset;
                  AccountTypes.SetRange(AccountTypes.Code,Vendor."Account Type");

              if AccountTypes.FindSet then repeat

                    DetailedVendorLedgerEntry.Reset;
                    DetailedVendorLedgerEntry.SetRange(DetailedVendorLedgerEntry."Vendor No.",Vendor."No.");
                    //DetailedVendorLedgerEntry.SETFILTER(DetailedVendorLedgerEntry."Entry No.",'>%1',lastEntry);
                    DetailedVendorLedgerEntry.SetFilter(DetailedVendorLedgerEntry."Posting Date",'>%1',dashboardDataFilter);

              if DetailedVendorLedgerEntry.FindSet then repeat

              VendorLedgerEntry.Reset;
              VendorLedgerEntry.SetRange(VendorLedgerEntry."Entry No.",DetailedVendorLedgerEntry."Vendor Ledger Entry No.");

                if VendorLedgerEntry.FindSet then begin
                if detailedstatement=''
                then begin
                detailedstatement:=Format(DetailedVendorLedgerEntry."Entry No.") +':::'+
                Format(AccountTypes.Description)+':::'+
                Format(DetailedVendorLedgerEntry."Posting Date")+':::'+

                Format((DetailedVendorLedgerEntry."Credit Amount"),0,'<Precision,2:2><Integer><Decimals>')+':::'+
                Format((DetailedVendorLedgerEntry."Debit Amount"),0,'<Precision,2:2><Integer><Decimals>')+':::'+
                Format((DetailedVendorLedgerEntry.Amount),0,'<Precision,2:2><Integer><Decimals>')+':::'+
                Format(DetailedVendorLedgerEntry."Journal Batch Name")+':::'+
                Format(DetailedVendorLedgerEntry."Initial Entry Global Dim. 1")+':::'+
                Format(VendorLedgerEntry.Description);
                end
                else
                repeat
                detailedstatement:=detailedstatement+'::::'+
                Format(DetailedVendorLedgerEntry."Entry No.") +':::'+
                Format(AccountTypes.Description)+':::'+
                Format(DetailedVendorLedgerEntry."Posting Date")+':::'+

                Format((DetailedVendorLedgerEntry."Credit Amount"),0,'<Precision,2:2><Integer><Decimals>')+':::'+
                Format((DetailedVendorLedgerEntry."Debit Amount"),0,'<Precision,2:2><Integer><Decimals>')+':::'+
                Format((DetailedVendorLedgerEntry.Amount),0,'<Precision,2:2><Integer><Decimals>')+':::'+
                Format(DetailedVendorLedgerEntry."Journal Batch Name")+':::'+
                Format(DetailedVendorLedgerEntry."Initial Entry Global Dim. 1")+':::'+
                Format(VendorLedgerEntry.Description);

                if minimunCount>20 then
                exit
                until VendorLedgerEntry.Next =0;
                end;
                until DetailedVendorLedgerEntry.Next =0;
                until AccountTypes.Next =0;
              until Vendor.Next =0;
        end;
    end;


    procedure MemberAccountNames(phone: Text[20]) accounts: Text[250]
    begin
        begin
          Vendor.Reset;
          Vendor.SetRange(Vendor."Mobile Phone No",phone);
          Vendor.SetRange(Vendor.Status, Vendor.Status::Active);
          if Vendor.Find('-') then
            begin
               accounts:='';
               repeat
                 accounts:=accounts+'::::'+AccountDescription(Vendor."Account Type");
               until Vendor.Next =0;
            end
          else
          begin
             accounts:='';
          end
          end;
    end;


    procedure SharesRetained(phone: Text[20]) shares: Text[1000]
    var
        amount: Decimal;
    begin
        begin
          Vendor.Reset;
          Vendor.SetRange(Vendor."Mobile Phone No",phone);
          if Vendor.Find('-') then begin
              MemberLedgerEntry.Reset;
              MemberLedgerEntry.SetRange(MemberLedgerEntry."Customer No.",Vendor."BOSA Account No");
              MemberLedgerEntry.SetRange(MemberLedgerEntry."Transaction Type",MemberLedgerEntry."transaction type"::"Share Capital");
              if MemberLedgerEntry.Find('-') then
                repeat
                    amount:=amount+MemberLedgerEntry.Amount;
                    shares:= Format(amount,0,'<Precision,2:2><Integer><Decimals>');
                    until MemberLedgerEntry.Next =0;
                end;
            end;
    end;


    procedure LoanBalances(phone: Text[20]) loanbalances: Text[250]
    begin
        begin
        Vendor.Reset;
              Vendor.SetRange(Vendor."Mobile Phone No",phone)   ;
              if Vendor.Find('-') then begin
                  LoansRegister.Reset;
                  LoansRegister.SetRange(LoansRegister."Client Code",Vendor."BOSA Account No");
                  if LoansRegister.Find('-') then begin
                  repeat
                    LoansRegister.CalcFields(LoansRegister."Outstanding Balance",LoansRegister."Oustanding Interest",LoansRegister."Interest Due",LoansRegister."Interest Paid");
                    if (LoansRegister."Outstanding Balance">0) or (LoansRegister."Oustanding Interest">0)then
                    loanbalances:= loanbalances + '::::' +LoansRegister."Loan  No." + ':::'+ LoansRegister."Loan Product Type" + ':::'+Format(LoansRegister."Outstanding Balance"+LoansRegister."Oustanding Interest");
                  until LoansRegister.Next = 0;
                  end;
                 /* LoansRegister.RESET;
                   LoansRegister.SETRANGE(LoansRegister."Account No",Vendor."No.");
                  IF LoansRegister.FIND('-') THEN BEGIN
                  REPEAT
                    LoansRegister.CALCFIELDS(LoansRegister."Outstanding Balance",LoansRegister."Oustanding Interest",LoansRegister."Interest Due",LoansRegister."Interest Paid");
                    IF (LoansRegister."Outstanding Balance">0)OR(LoansRegister."Oustanding Interest"*-1>0) THEN
                    loanbalances:= loanbalances + '::::' +LoansRegister."Loan  No." + ':::'+ LoansRegister."Loan Product Type Name" + ':::'+
                     FORMAT(LoansRegister."Outstanding Balance"+LoansRegister."Oustanding Interest"*-1) ;
                  UNTIL LoansRegister.NEXT = 0;
                  END;*/
              end;
         end;

    end;


    procedure MemberAccounts(phone: Text[20]) accounts: Text[700]
    begin
        begin
         // bosaNo:=BOSAAccount(phone);
          Vendor.Reset;
          Vendor.SetRange(Vendor."Mobile Phone No",phone);
          Vendor.SetRange(Vendor.Status, Vendor.Status::Active);
          //Vendor.SETRANGE(Vendor.Blocked, Vendor.Blocked::" ");
          if Vendor.Find('-') then
            begin

               repeat
                  AccountTypes.Reset;
                AccountTypes.SetRange(AccountTypes.Code,Vendor."Account Type")  ;
                //AccountTypes.SETRANGE(AccountTypes."Last Account No Used(HQ)",FALSE);
                if AccountTypes.Find('-') then
                begin
                 accounts:=accounts+'::::'+Vendor."No."+':::'+AccountDescription(Vendor."Account Type");
                  end;
               until Vendor.Next =0;

            end
          else
          begin
             accounts:='';
          end
          end;
    end;


    procedure SurePESARegistration() memberdetails: Text[1000]
    begin
        begin
          CloudPESAApplications.Reset;
        CloudPESATrans.Ascending(true);
          CloudPESAApplications.SetRange(CloudPESAApplications.SentToServer, false);
        //SCloudPESATrans.ASCENDING(FALSE);
          if CloudPESAApplications.FindFirst() then
            begin
                 memberdetails:=CloudPESAApplications."Account No"+':::'+CloudPESAApplications.Telephone+':::'+CloudPESAApplications."ID No";
            end
          else
          begin
             memberdetails:='';
          end
          end;
    end;


    procedure UpdateSurePESARegistration(accountNo: Text[30]) result: Text[10]
    begin
        begin
          CloudPESAApplications.Reset;
          CloudPESAApplications.SetRange(CloudPESAApplications.SentToServer, false);
          CloudPESAApplications.SetRange(CloudPESAApplications."Account No", accountNo);
          if CloudPESAApplications.Find('-') then
            begin
                 CloudPESAApplications.SentToServer:=true;
                 CloudPESAApplications.Modify;
                 result:='Modified';
            end
          else
          begin
             result:='Failed';
          end
          end;
    end;


    procedure CurrentShares(phone: Text[20]) shares: Text[1000]
    var
        amount: Decimal;
    begin
        begin
          Vendor.Reset;
          Vendor.SetRange(Vendor."Mobile Phone No",phone);
          if Vendor.Find('-') then begin
              MemberLedgerEntry.Reset;
              MemberLedgerEntry.SetRange(MemberLedgerEntry."Customer No.",Vendor."BOSA Account No");
              MemberLedgerEntry.SetRange(MemberLedgerEntry."Transaction Type",MemberLedgerEntry."transaction type"::"Deposit Contribution");
              if MemberLedgerEntry.Find('-') then
                repeat
                    amount:=amount+MemberLedgerEntry.Amount;
                    shares:= Format(amount,0,'<Precision,2:2><Integer><Decimals>');
                    until MemberLedgerEntry.Next =0;
                end;
            end;
    end;


    procedure BenevolentFund(phone: Text[20]) shares: Text[50]
    var
        amount: Decimal;
    begin
        begin
          Vendor.Reset;
          Vendor.SetRange(Vendor."Mobile Phone No",phone);
          if Vendor.Find('-') then begin
              MemberLedgerEntry.Reset;
              MemberLedgerEntry.SetRange(MemberLedgerEntry."Customer No.",Vendor."BOSA Account No");
              MemberLedgerEntry.SetRange(MemberLedgerEntry."Transaction Type",MemberLedgerEntry."transaction type"::"Benevolent Fund");
              if MemberLedgerEntry.Find('-') then
                repeat
                    amount:=amount+MemberLedgerEntry.Amount;
                    shares:= Format(amount,0,'<Precision,2:2><Integer><Decimals>');
                    until MemberLedgerEntry.Next =0;
                end;
            end;
    end;


    procedure FundsTransferFOSA(accFrom: Text[20];accTo: Text[20];DocNumber: Text[30];amount: Decimal) result: Text[30]
    begin
        CloudPESATrans.Reset;
        CloudPESATrans.SetRange(CloudPESATrans."Document No", DocNumber);
        if CloudPESATrans.Find('-') then begin
          result:='REFEXISTS';
        end
        else begin
          GenLedgerSetup.Reset;
          GenLedgerSetup.Get;
          GenLedgerSetup.TestField(GenLedgerSetup."Mobile Charge");
          GenLedgerSetup.TestField(GenLedgerSetup."CloudPESA Comm Acc");
          GenLedgerSetup.TestField(GenLedgerSetup."CloudPESA Charge");

          Charges.Reset;
          Charges.SetRange(Charges.Code,GenLedgerSetup."Mobile Charge");
          if Charges.Find('-') then begin
            Charges.TestField(Charges."GL Account");
            MobileCharges:=0; //Charges."Charge Amount";
            MobileChargesACC:=Charges."GL Account";
          end;

            CloudPESACommACC:=  GenLedgerSetup."CloudPESA Comm Acc";
             CloudPESACharge:=GenLedgerSetup."CloudPESA Charge";

            ExcDuty:=(20/100)*(MobileCharges+CloudPESACharge);

           //Members.RESET;
           //Members.SETRANGE(Members."No.",accFrom);


            Vendor.Reset;
            Vendor.SetRange(Vendor."No.",accFrom);
            if Vendor.Find('-') then begin
              AccountTypes.Reset;
                AccountTypes.SetRange(AccountTypes.Code,Vendor."Account Type")  ;
                //AccountTypes.SETRANGE(AccountTypes."Last Account No Used(HQ)",FALSE);
                if AccountTypes.Find('-') then
                begin
                  miniBalance:=AccountTypes."Minimum Balance";
                end;
               accountName1:=Vendor."Account Type";
              mobilephone:=Vendor."Mobile Phone No";
             Vendor.CalcFields(Vendor."Balance (LCY)");
             TempBalance:=Vendor."Balance (LCY)"-(Vendor."ATM Transactions"+Vendor."Uncleared Cheques"+Vendor."EFT Transactions"+miniBalance);

            if Vendor.Get(accTo) then begin

                  if (TempBalance>amount+MobileCharges+CloudPESACharge) then begin
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name",'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name",'MOBILETRAN');
                        GenJournalLine.DeleteAll;
                        //end of deletion

                        GenBatches.Reset;
                        GenBatches.SetRange(GenBatches."Journal Template Name",'GENERAL');
                        GenBatches.SetRange(GenBatches.Name,'MOBILETRAN');

                        if GenBatches.Find('-') = false then begin
                        GenBatches.Init;
                        GenBatches."Journal Template Name":='GENERAL';
                        GenBatches.Name:='MOBILETRAN';
                        GenBatches.Description:='SUREPESA Tranfers';
                        GenBatches.Validate(GenBatches."Journal Template Name");
                        GenBatches.Validate(GenBatches.Name);
                        GenBatches.Insert;
                        end;

                //DR ACC 1
                        LineNo:=LineNo+10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='GENERAL';
                        GenJournalLine."Journal Batch Name":='MOBILETRAN';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No.":=accFrom;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No.":=DocNumber;
                        GenJournalLine."External Document No.":=accFrom;
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine.Description:='Mobile Transfer';
                        GenJournalLine.Amount:=amount;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;

                //Dr Transfer Charges
                        LineNo:=LineNo+10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='GENERAL';
                        GenJournalLine."Journal Batch Name":='MOBILETRAN';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No.":=accFrom;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No.":=DocNumber;
                        GenJournalLine."External Document No.":=accFrom;
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine.Description:='Mobile Transfer Charges';
                        GenJournalLine.Amount:=MobileCharges + CloudPESACharge ;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;


                //DR Excise Duty
                        LineNo:=LineNo+10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='GENERAL';
                        GenJournalLine."Journal Batch Name":='MOBILETRAN';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No.":=accFrom;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No.":=DocNumber;
                        GenJournalLine."External Document No.":=accFrom;
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine.Description:='Excise duty-Mobile Transfer';
                        GenJournalLine.Amount:=ExcDuty;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;

                        LineNo:=LineNo+10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='GENERAL';
                        GenJournalLine."Journal Batch Name":='MOBILETRAN';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Account No.":=ExxcDuty;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No.":=DocNumber;
                         GenJournalLine."Source No.":=Vendor."No.";
                        GenJournalLine."External Document No.":=MobileChargesACC;
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine.Description:='Excise duty-Mobile Transfer';
                        GenJournalLine.Amount:=ExcDuty*-1;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;

                //CR Mobile Transactions Acc
                        LineNo:=LineNo+10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='GENERAL';
                        GenJournalLine."Journal Batch Name":='MOBILETRAN';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Account No.":=MobileChargesACC;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No.":=DocNumber;
                         GenJournalLine."Source No.":=Vendor."No.";
                        GenJournalLine."External Document No.":=MobileChargesACC;
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine.Description:='Mobile Transfer Charges';
                        GenJournalLine.Amount:=MobileCharges*-1;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;

                //CR Commission
                        LineNo:=LineNo+10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='GENERAL';
                        GenJournalLine."Journal Batch Name":='MOBILETRAN';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Account No.":=CloudPESACommACC;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No.":=DocNumber;
                         GenJournalLine."Source No.":=Vendor."No.";
                        GenJournalLine."External Document No.":=MobileChargesACC;
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine.Description:='Mobile Transfer Charges';
                        GenJournalLine.Amount:=-CloudPESACharge;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;

                //CR ACC2
                        LineNo:=LineNo+10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='GENERAL';
                        GenJournalLine."Journal Batch Name":='MOBILETRAN';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No.":=accTo;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No.":=DocNumber;
                        GenJournalLine."External Document No.":=accTo;
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine.Description:='Mobile Transfer from '+accFrom;
                        GenJournalLine.Amount:=-amount;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;

                        //Post
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name",'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name",'MOBILETRAN');
                        if GenJournalLine.Find('-') then begin
                        repeat
                        GLPosting.Run(GenJournalLine);
                        until GenJournalLine.Next = 0;
                        end;
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name",'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name",'MOBILETRAN');
                        GenJournalLine.DeleteAll;

                        CloudPESATrans.Init;
                        CloudPESATrans."Document No":=DocNumber;
                        CloudPESATrans.Description:='Mobile Transfer';
                        CloudPESATrans."Document Date":=Today;
                        CloudPESATrans."Account No" :=accFrom;
                        CloudPESATrans."Account No2" :=accTo;
                        CloudPESATrans.Amount:=amount;
                        CloudPESATrans.Posted:=true;
                        CloudPESATrans."Posting Date":=Today;
                         TotalCharges:=ExcDuty+MobileCharges+CloudPESACharge;
                          CloudPESATrans.Charge:=TotalCharges;
                         CloudPESATrans."Account Name":=Vendor.Name;
                            CloudPESATrans."Telephone Number":=Vendor."Mobile Phone No";
                             CloudPESATrans.Status:=CloudPESATrans.Status::Completed;
                        CloudPESATrans.Comments:='Success';
                        CloudPESATrans.Client:=Vendor."BOSA Account No";
                        CloudPESATrans."Transaction Type":=CloudPESATrans."transaction type"::"Transfer to Fosa";
                        CloudPESATrans."Transaction Time":=Time;
                        CloudPESATrans.Insert;
                        result:='TRUE';

                        Vendor.Reset();
                        Vendor.SetRange(Vendor."No.",accTo);
                        if Vendor.Find('-') then begin
                          accountName2:=Vendor."Account Type";

                        end;
                           msg:='You have transfered KES '+Format(amount)+' from Account '+accountName1+' to '+accountName2+
                            ' .Thank you for using ILKISONKO  Sacco Mobile.';
                            SMSMessage(DocNumber,accFrom,mobilephone,msg);

                              msg:='You have received KES '+Format(amount)+' from Account '+accountName1+' -'+accFrom+
                            ' .Thank you for using ILKISONKO  Sacco Mobile.';
                            SMSMessage(DocNumber,accFrom,Vendor."Mobile Phone No",msg);
                     end
                     else begin
                     result:='INSUFFICIENT';
                             msg:='You have insufficient funds in your savings Account to use this service.'+
                            ' .Thank you for using ILKISONKO  Sacco Mobile.';
                            SMSMessage(DocNumber,accFrom,mobilephone,msg);
                     end;
                end
                else begin
                  result:='ACC2INEXISTENT';
                             msg:='Your request has failed because the recipent account does not exist.'+
                            ' .Thank you for using ILKISONKO  Sacco Mobile.';
                            SMSMessage(DocNumber,accFrom,mobilephone,msg);
                end;
            end
            else begin
              result:='ACCINEXISTENT';
                          result:='INSUFFICIENT';
                          msg:='Your request has failed because the recipent account does not exist.'+
                          ' .Thank you for using ILKISONKO  Sacco Mobile.';
                          SMSMessage(DocNumber,accFrom,mobilephone,msg);
            end;
          end;
    end;


    procedure FundsTransferBOSA(accFrom: Text[20];accTo: Text[20];DocNumber: Text[30];amount: Decimal) result: Text[30]
    begin

          CloudPESATrans.Reset;
          CloudPESATrans.SetRange(CloudPESATrans."Document No", DocNumber);
          if CloudPESATrans.Find('-') then begin
            result:='REFEXISTS';
          end else begin

            Vendor.Reset;
            Vendor.SetRange(Vendor."No.",accFrom);
            if Members.Find('-') then begin

              GenLedgerSetup.Reset;
              GenLedgerSetup.Get;
              GenLedgerSetup.TestField(GenLedgerSetup."Mobile Charge");
              GenLedgerSetup.TestField(GenLedgerSetup."CloudPESA Comm Acc");
              GenLedgerSetup.TestField(GenLedgerSetup."CloudPESA Charge");

              Charges.Reset;
              Charges.SetRange(Charges.Code,GenLedgerSetup."Mobile Charge");
              if Charges.Find('-') then begin
                Charges.TestField(Charges."GL Account");
                MobileCharges:=0; //Charges."Charge Amount";
                MobileChargesACC:=Charges."GL Account";
              end;

              CloudPESACommACC:=  GenLedgerSetup."CloudPESA Comm Acc";
              CloudPESACharge:=GenLedgerSetup."CloudPESA Charge";

              ExcDuty:=(20/100)*(MobileCharges+CloudPESACharge);

              Vendor.Reset;
              Vendor.SetRange(Vendor."No.",accFrom);
              if Vendor.Find('-') then begin
                AccountTypes.Reset;
                AccountTypes.SetRange(AccountTypes.Code,Vendor."Account Type")  ;
                //AccountTypes.SETRANGE(AccountTypes."Last Account No Used(HQ)",FALSE);
                if AccountTypes.Find('-') then begin
                  miniBalance:=AccountTypes."Minimum Balance";
                end;
                Vendor.CalcFields(Vendor."Balance (LCY)");
                TempBalance:=Vendor."Balance (LCY)"-(Vendor."ATM Transactions"+Vendor."Uncleared Cheques"+Vendor."EFT Transactions"+miniBalance);

                //MESSAGE(FORMAT(TempBalance));
                if (accTo='Share Capital')
                  or(accTo='Deposit Contribution')
                  or(accTo='Benevolent Fund')
                  then begin

                  if (TempBalance>amount+MobileCharges+CloudPESACharge) then begin
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name",'GENERAL');
                    GenJournalLine.SetRange("Journal Batch Name",'MOBILETRAN');
                    GenJournalLine.DeleteAll;
                    //end of deletion

                    GenBatches.Reset;
                    GenBatches.SetRange(GenBatches."Journal Template Name",'GENERAL');
                    GenBatches.SetRange(GenBatches.Name,'MOBILETRAN');

                    if GenBatches.Find('-') = false then begin
                      GenBatches.Init;
                      GenBatches."Journal Template Name":='GENERAL';
                      GenBatches.Name:='MOBILETRAN';
                      GenBatches.Description:='CloudPESA Tranfers';
                      GenBatches.Validate(GenBatches."Journal Template Name");
                      GenBatches.Validate(GenBatches.Name);
                      GenBatches.Insert;
                    end;

                    //DR ACC 1
                    LineNo:=LineNo+10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name":='GENERAL';
                    GenJournalLine."Journal Batch Name":='MOBILETRAN';
                    GenJournalLine."Line No.":=LineNo;
                    GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                    GenJournalLine."Account No.":=accFrom;
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No.":=DocNumber;
                    GenJournalLine."External Document No.":=accFrom;
                    GenJournalLine."Posting Date":=Today;
                    GenJournalLine.Description:='Mobile Transfer -'+accTo;
                    GenJournalLine.Amount:=amount;
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if GenJournalLine.Amount<>0 then
                    GenJournalLine.Insert;

                //Dr Transfer Charges
                        LineNo:=LineNo+10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='GENERAL';
                        GenJournalLine."Journal Batch Name":='MOBILETRAN';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No.":=accFrom;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No.":=DocNumber;
                        GenJournalLine."External Document No.":=accFrom;
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine.Description:='Mobile Transfer Charges';
                        GenJournalLine.Amount:=MobileCharges + CloudPESACharge ;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;


                //DR Excise Duty
                        LineNo:=LineNo+10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='GENERAL';
                        GenJournalLine."Journal Batch Name":='MOBILETRAN';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No.":=accFrom;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No.":=DocNumber;
                        GenJournalLine."External Document No.":=accFrom;
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine.Description:='Excise duty-Mobile Transfer';
                        GenJournalLine.Amount:=ExcDuty;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;

                        LineNo:=LineNo+10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='GENERAL';
                        GenJournalLine."Journal Batch Name":='MOBILETRAN';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Account No.":=ExxcDuty;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No.":=DocNumber;
                         GenJournalLine."Source No.":=Vendor."No.";
                        GenJournalLine."External Document No.":=MobileChargesACC;
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine.Description:='Excise duty-Mobile Transfer';
                        GenJournalLine.Amount:=ExcDuty*-1;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;

                //CR Mobile Transactions Acc
                        LineNo:=LineNo+10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='GENERAL';
                        GenJournalLine."Journal Batch Name":='MOBILETRAN';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Account No.":=MobileChargesACC;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No.":=DocNumber;
                         GenJournalLine."Source No.":=Vendor."No.";
                        GenJournalLine."External Document No.":=MobileChargesACC;
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine.Description:='Mobile Transfer Charges';
                        GenJournalLine.Amount:=MobileCharges*-1;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;

                //CR Commission
                        LineNo:=LineNo+10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='GENERAL';
                        GenJournalLine."Journal Batch Name":='MOBILETRAN';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Account No.":=CloudPESACommACC;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No.":=DocNumber;
                        GenJournalLine."External Document No.":=MobileChargesACC;
                        GenJournalLine."Posting Date":=Today;
                         GenJournalLine."Source No.":=Vendor."No.";
                        GenJournalLine.Description:='Mobile Transfer Charges';
                        GenJournalLine.Amount:=-CloudPESACharge;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;

                //CR ACC2
                        LineNo:=LineNo+10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='GENERAL';
                        GenJournalLine."Journal Batch Name":='MOBILETRAN';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Account Type":=GenJournalLine."account type"::Member;
                        GenJournalLine."Account No.":=Vendor."BOSA Account No";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No.":=DocNumber;
                        GenJournalLine."External Document No.":='SUREPESA';
                        GenJournalLine."Posting Date":=Today;

                        if accTo='Deposit Contribution' then begin
                        GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Deposit Contribution";
                           GenJournalLine.Description:='Mobile Transfer from '+accFrom;
                        end;
                        if accTo='Share Capital' then begin
                        GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Share Capital";
                           GenJournalLine.Description:='Mobile Transfer from '+accFrom;
                        end;
                        if accTo='Benevolent Fund' then begin
                        GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Benevolent Fund";

                        GenJournalLine.Description:='Mobile Transfer from '+accFrom;
                        end;
                        GenJournalLine."Shortcut Dimension 1 Code":='BOSA';
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        if GenJournalLine."Shortcut Dimension 2 Code" = '' then begin
                                    GenJournalLine."Shortcut Dimension 2 Code":=Members."Global Dimension 2 Code";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    end;
                        //GenJournalLine.Description:=
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine.Amount:=-amount;
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;

                        //Post
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name",'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name",'MOBILETRAN');
                        if GenJournalLine.Find('-') then begin
                        repeat
                       GLPosting.Run(GenJournalLine);
                        until GenJournalLine.Next = 0;
                        end;
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name",'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name",'MOBILETRAN');
                        GenJournalLine.DeleteAll;

                        CloudPESATrans.Init;
                        CloudPESATrans."Document No":=DocNumber;
                        CloudPESATrans.Description:='Mobile Transfer';
                        CloudPESATrans."Document Date":=Today;
                        CloudPESATrans."Account No" :=accFrom;
                        CloudPESATrans."Account No2" :=accTo;
                         TotalCharges:=ExcDuty+MobileCharges+CloudPESACharge;
                          CloudPESATrans.Charge:=TotalCharges;
                         CloudPESATrans."Account Name":=Vendor.Name;
                            CloudPESATrans."Telephone Number":=Vendor."Mobile Phone No";
                        CloudPESATrans.Amount:=amount;
                        CloudPESATrans.Posted:=true;
                        CloudPESATrans.Status:=CloudPESATrans.Status::Completed;
                        CloudPESATrans."Posting Date":=Today;
                        CloudPESATrans.Comments:='Success';
                        CloudPESATrans.Client:=Vendor."BOSA Account No";
                        CloudPESATrans."Transaction Type":=CloudPESATrans."transaction type"::"Transfer to Bosa";
                        CloudPESATrans."Transaction Time":=Time;
                        CloudPESATrans.Insert;
                        result:='TRUE';

                           msg:='You have transfered KES '+Format(amount)+' from Account '+Vendor.Name+' to '+accTo+
                            ' .Thank you for using ILKISONKO  Sacco Mobile.';
                            SMSMessage(DocNumber,accFrom,Vendor."Mobile Phone No",msg);
                     end
                     else begin
                     result:='INSUFFICIENT';
                             msg:='You have insufficient funds in your savings Account to use this service.'+
                            '. Thank you for using ILKISONKO  Sacco Mobile.';
                            SMSMessage(DocNumber,accFrom,Vendor."Mobile Phone No",msg);
                     end;
                end
                else begin
                  result:='ACC2INEXISTENT';
                             msg:='Your request has failed because the recipent account does not exist.'+
                            '. Thank you for using ILKISONKO  Sacco Mobile.';
                            SMSMessage(DocNumber,accFrom,Vendor."Mobile Phone No",msg);
                end;
            end
            else begin
              result:='ACCINEXISTENT';
                          result:='INSUFFICIENT';
                          msg:='Your request has failed because the recipent account does not exist.'+
                          '. Thank you for using ILKISONKO  Sacco Mobile.';
                          SMSMessage(DocNumber,accFrom,Vendor."Mobile Phone No",msg);
            end;
          end
          else begin
              result:='MEMBERINEXISTENT';
                        msg:='Your request has failed because the recipent account does not exist.'+
                        '. Thank you for using ILKISONKO  Sacco Mobile.';
                        SMSMessage(DocNumber,accFrom,Vendor."Mobile Phone No",msg);
          end;
          end;
    end;


    procedure WSSAccount(phone: Text[20]) accounts: Text[250]
    begin

          Vendor.Reset;
          Vendor.SetRange(Vendor."Mobile Phone No",phone);
          Vendor.SetRange(Vendor.Status, Vendor.Status::Active);
          Vendor.SetRange(Vendor."Account Type", 'ORDINARY');
          Vendor.SetRange(Vendor.Blocked, Vendor.Blocked::" ");
          if Vendor.Find('-') then begin
            AccountTypes.Reset;
            AccountTypes.SetRange(AccountTypes.Code,Vendor."Account Type");
            if AccountTypes.Find('-') then begin
              accounts:= Vendor."No."+':::'+AccountDescription(Vendor."Account Type");
            end;
          end else begin
            accounts:='';
          end;
    end;


    procedure SMSMessage(documentNo: Text[30];accfrom: Text[30];phone: Text[20];message: Text[250])
    begin

          SMSMessages.Reset;
          if SMSMessages.Find('+') then begin
          iEntryNo:=SMSMessages."Entry No";
          iEntryNo:=iEntryNo+1;
          end else begin
          iEntryNo:=1;
          end;
          SMSMessages.Init;
          SMSMessages."Entry No":=iEntryNo;
          SMSMessages."Batch No":=documentNo;
          SMSMessages."Document No":=documentNo;
          SMSMessages."Account No":=accfrom;
          SMSMessages."Date Entered":=Today;
          SMSMessages."Time Entered":=Time;
          SMSMessages.Source:='MOBILETRAN';
          SMSMessages."Entered By":=UserId;
          SMSMessages."Sent To Server":=SMSMessages."sent to server"::No;
          SMSMessages."SMS Message":=message;
          SMSMessages."Telephone No":=phone;
          if SMSMessages."Telephone No"<>'' then
          SMSMessages.Insert;
    end;


    procedure LoanRepayment(accFrom: Text[20];loanNo: Text[20];DocNumber: Text[30];amount: Decimal) result: Text[30]
    begin

        CloudPESATrans.Reset;
        CloudPESATrans.SetRange(CloudPESATrans."Document No", DocNumber);
        if CloudPESATrans.Find('-') then begin
          result:='REFEXISTS';
        end
        else begin

          Vendor.Reset;
          Vendor.SetRange(Vendor."No.",accFrom);
          if Vendor.Find('-') then begin

              GenLedgerSetup.Reset;
              GenLedgerSetup.Get;
              GenLedgerSetup.TestField(GenLedgerSetup."Mobile Charge");
              GenLedgerSetup.TestField(GenLedgerSetup."CloudPESA Comm Acc");
              GenLedgerSetup.TestField(GenLedgerSetup."CloudPESA Charge");

              Charges.Reset;
              Charges.SetRange(Charges.Code,GenLedgerSetup."Mobile Charge");
              if Charges.Find('-') then begin
                Charges.TestField(Charges."GL Account");
                MobileCharges:=0; //Charges."Charge Amount";
                MobileChargesACC:=Charges."GL Account";
              end;

                CloudPESACommACC:=  GenLedgerSetup."CloudPESA Comm Acc";
                 CloudPESACharge:=GenLedgerSetup."CloudPESA Charge";

                ExcDuty:=(20/100)*(MobileCharges+CloudPESACharge);

                Vendor.Reset;
                Vendor.SetRange(Vendor."No.",accFrom);
                if Vendor.Find('-') then begin
                  AccountTypes.Reset;
                AccountTypes.SetRange(AccountTypes.Code,Vendor."Account Type")  ;
                //AccountTypes.SETRANGE(AccountTypes."Last Account No Used(HQ)",FALSE);
                if AccountTypes.Find('-') then
                begin
                  miniBalance:=AccountTypes."Minimum Balance";
                end;

                     Vendor.CalcFields(Vendor."Balance (LCY)");
                     TempBalance:=Vendor."Balance (LCY)"-(Vendor."ATM Transactions"+Vendor."Uncleared Cheques"+Vendor."EFT Transactions"+miniBalance);

                          LoansRegister.Reset;
                          LoansRegister.SetRange(LoansRegister."Loan  No.",loanNo);
                        //  LoansRegister.SETRANGE(LoansRegister."Client Code",Vendor."BOSA Account No");

                       if LoansRegister.Find('-') then begin

                          LoansRegister.CalcFields(LoansRegister."Outstanding Balance",LoansRegister."Oustanding Interest");
                          if (TempBalance>amount+MobileCharges+CloudPESACharge) then begin
                           if LoansRegister."Outstanding Balance" > 0 then begin
                                    GenJournalLine.Reset;
                                    GenJournalLine.SetRange("Journal Template Name",'GENERAL');
                                    GenJournalLine.SetRange("Journal Batch Name",'MOBILETRAN');
                                    GenJournalLine.DeleteAll;
                                    //end of deletion

                                    GenBatches.Reset;
                                    GenBatches.SetRange(GenBatches."Journal Template Name",'GENERAL');
                                    GenBatches.SetRange(GenBatches.Name,'MOBILETRAN');

                                    if GenBatches.Find('-') = false then begin
                                    GenBatches.Init;
                                    GenBatches."Journal Template Name":='GENERAL';
                                    GenBatches.Name:='MOBILETRAN';
                                    GenBatches.Description:='Mobile Loan Repayment';
                                    GenBatches.Validate(GenBatches."Journal Template Name");
                                    GenBatches.Validate(GenBatches.Name);
                                    GenBatches.Insert;
                                    end;

                            //DR ACC 1
                                    LineNo:=LineNo+10000;
                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name":='GENERAL';
                                    GenJournalLine."Journal Batch Name":='MOBILETRAN';
                                    GenJournalLine."Line No.":=LineNo;
                                    GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                                    GenJournalLine."Account No.":=accFrom;
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Document No.":=DocNumber;
                                    GenJournalLine."External Document No.":=accFrom;
                                    GenJournalLine."Posting Date":=Today;
                                    GenJournalLine.Description:='Mobile Loan Repayment';
                                    GenJournalLine.Amount:=amount;
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    if GenJournalLine.Amount<>0 then
                                    GenJournalLine.Insert;

                            //Dr Transfer Charges
                                    LineNo:=LineNo+10000;
                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name":='GENERAL';
                                    GenJournalLine."Journal Batch Name":='MOBILETRAN';
                                    GenJournalLine."Line No.":=LineNo;
                                    GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                                    GenJournalLine."Account No.":=accFrom;
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Document No.":=DocNumber;
                                    GenJournalLine."External Document No.":=accFrom;
                                    GenJournalLine."Posting Date":=Today;
                                    GenJournalLine.Description:='Mobile Transfer Charges';
                                    GenJournalLine.Amount:=MobileCharges + CloudPESACharge ;
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    if GenJournalLine.Amount<>0 then
                                    GenJournalLine.Insert;


                            //DR Excise Duty
                                    LineNo:=LineNo+10000;
                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name":='GENERAL';
                                    GenJournalLine."Journal Batch Name":='MOBILETRAN';
                                    GenJournalLine."Line No.":=LineNo;
                                    GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                                    GenJournalLine."Account No.":=accFrom;
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Document No.":=DocNumber;
                                    GenJournalLine."External Document No.":=accFrom;
                                    GenJournalLine."Posting Date":=Today;
                                    GenJournalLine.Description:='Excise duty-Mobile Transfer Charges';
                                    GenJournalLine.Amount:=ExcDuty;
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    if GenJournalLine.Amount<>0 then
                                    GenJournalLine.Insert;

                                    LineNo:=LineNo+10000;
                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name":='GENERAL';
                                    GenJournalLine."Journal Batch Name":='MOBILETRAN';
                                    GenJournalLine."Line No.":=LineNo;
                                    GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                                    GenJournalLine."Account No.":=ExxcDuty;
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Document No.":=DocNumber;
                                     GenJournalLine."Source No.":=Vendor."No.";
                                    GenJournalLine."External Document No.":=MobileChargesACC;
                                    GenJournalLine."Posting Date":=Today;
                                    GenJournalLine.Description:='Excise duty-Mobile Transfer Charges';
                                    GenJournalLine.Amount:=ExcDuty*-1;
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    if GenJournalLine.Amount<>0 then
                                    GenJournalLine.Insert;

                            //CR Mobile Transactions Acc
                                    LineNo:=LineNo+10000;
                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name":='GENERAL';
                                    GenJournalLine."Journal Batch Name":='MOBILETRAN';
                                    GenJournalLine."Line No.":=LineNo;
                                    GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                                    GenJournalLine."Account No.":=MobileChargesACC;
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Document No.":=DocNumber;
                                     GenJournalLine."Source No.":=Vendor."No.";
                                    GenJournalLine."External Document No.":=MobileChargesACC;
                                    GenJournalLine."Posting Date":=Today;
                                    GenJournalLine.Description:='Mobile Transfer Charges';
                                    GenJournalLine.Amount:=MobileCharges*-1;
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    if GenJournalLine.Amount<>0 then
                                    GenJournalLine.Insert;

                            //CR Commission
                                    LineNo:=LineNo+10000;
                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name":='GENERAL';
                                    GenJournalLine."Journal Batch Name":='MOBILETRAN';
                                    GenJournalLine."Line No.":=LineNo;
                                    GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                                    GenJournalLine."Account No.":=CloudPESACommACC;
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Document No.":=DocNumber;
                                     GenJournalLine."Source No.":=Vendor."No.";
                                    GenJournalLine."External Document No.":=MobileChargesACC;
                                    GenJournalLine."Posting Date":=Today;
                                    GenJournalLine.Description:='Mobile Transfer Charges';
                                    GenJournalLine.Amount:=-CloudPESACharge;
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    if GenJournalLine.Amount<>0 then
                                    GenJournalLine.Insert;

                                    if LoansRegister."Oustanding Interest">0 then begin
                                    LineNo:=LineNo+10000;

                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name":='GENERAL';
                                    GenJournalLine."Journal Batch Name":='MOBILETRAN';
                                    GenJournalLine."Line No.":=LineNo;
                                    GenJournalLine."Account Type":=GenJournalLine."account type"::Member;
                                    GenJournalLine."Account No.":=LoansRegister."Client Code";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Document No.":=DocNumber;
                                    GenJournalLine."External Document No.":='';
                                    GenJournalLine."Posting Date":=Today;
                                    GenJournalLine.Description:='Loan Interest Payment';


                                    if amount > LoansRegister."Oustanding Interest" then
                                    GenJournalLine.Amount:=-LoansRegister."Oustanding Interest"
                                    else
                                    GenJournalLine.Amount:=-amount;
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Interest Paid";

                                    if GenJournalLine."Shortcut Dimension 1 Code" = '' then begin
                                    GenJournalLine."Shortcut Dimension 1 Code":=Members."Global Dimension 1 Code";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    end;
                                    if GenJournalLine."Shortcut Dimension 2 Code" = '' then begin
                                    GenJournalLine."Shortcut Dimension 2 Code":=Members."Global Dimension 2 Code";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    end;
                                    GenJournalLine."Loan No":=LoansRegister."Loan  No.";
                                    if GenJournalLine.Amount<>0 then
                                    GenJournalLine.Insert;

                                    amount:=amount+GenJournalLine.Amount;
                                    end;
                                    if amount>0 then begin
                                    LineNo:=LineNo+10000;

                                    GenJournalLine.Init;
                                    GenJournalLine."Journal Template Name":='GENERAL';
                                    GenJournalLine."Journal Batch Name":='MOBILETRAN';
                                    GenJournalLine."Line No.":=LineNo;
                                    GenJournalLine."Account Type":=GenJournalLine."account type"::Member;
                                    GenJournalLine."Account No.":=LoansRegister."Client Code";
                                    GenJournalLine.Validate(GenJournalLine."Account No.");
                                    GenJournalLine."Document No.":=DocNumber;
                                    GenJournalLine."External Document No.":='';
                                    GenJournalLine."Posting Date":=Today;
                                    GenJournalLine.Description:='Loan repayment';
                                    GenJournalLine.Amount:=-amount;
                                    GenJournalLine.Validate(GenJournalLine.Amount);
                                    GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Loan Repayment";
                                    if GenJournalLine."Shortcut Dimension 1 Code" = '' then begin
                                    GenJournalLine."Shortcut Dimension 1 Code":=Members."Global Dimension 1 Code";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                    end;
                                     if GenJournalLine."Shortcut Dimension 2 Code" = '' then begin
                                    GenJournalLine."Shortcut Dimension 2 Code":=Members."Global Dimension 2 Code";
                                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                    end;
                                    GenJournalLine."Loan No":=LoansRegister."Loan  No.";
                                    if GenJournalLine.Amount<>0 then
                                    GenJournalLine.Insert;
                                    end;


                                    //Post
                                    GenJournalLine.Reset;
                                    GenJournalLine.SetRange("Journal Template Name",'GENERAL');
                                    GenJournalLine.SetRange("Journal Batch Name",'MOBILETRAN');
                                    if GenJournalLine.Find('-') then begin
                                    repeat
                                    GLPosting.Run(GenJournalLine);
                                    until GenJournalLine.Next = 0;
                                    end;
                                    GenJournalLine.Reset;
                                    GenJournalLine.SetRange("Journal Template Name",'GENERAL');
                                    GenJournalLine.SetRange("Journal Batch Name",'MOBILETRAN');
                                    GenJournalLine.DeleteAll;


                                    CloudPESATrans.Init;
                                    CloudPESATrans."Document No":=DocNumber;
                                    CloudPESATrans.Description:='Mobile Transfer';
                                    CloudPESATrans."Document Date":=Today;
                                    CloudPESATrans."Account No" :=accFrom;
                                    CloudPESATrans."Account No2" :=loanNo;
                                    CloudPESATrans."SMS Message":=msg;
                                     TotalCharges:=ExcDuty+MobileCharges+CloudPESACharge;
                                      CloudPESATrans.Charge:=TotalCharges;
                                       CloudPESATrans."Account Name":=Vendor.Name;
                                    CloudPESATrans."Telephone Number":=Vendor."Mobile Phone No";
                                    CloudPESATrans.Amount:=amount;
                                    CloudPESATrans.Posted:=true;
                                    CloudPESATrans."Posting Date":=Today;
                                    CloudPESATrans.Status:=CloudPESATrans.Status::Completed;
                                    CloudPESATrans.Comments:='Success';
                                    CloudPESATrans.Client:=Vendor."BOSA Account No";
                                    CloudPESATrans."Transaction Type":=CloudPESATrans."transaction type"::"Transfer to Fosa";
                                    CloudPESATrans."Transaction Time":=Time;
                                    CloudPESATrans.Insert;
                                    result:='TRUE';

                                  msg:='You have transfered KES '+Format(amount)+' from Account '+accFrom+' to '+LoansRegister."Loan Product Type Name"+
                                        '. Thank you for using ILKISONKO  Sacco Mobile.';

                                    SMSMessage(DocNumber,accFrom,Vendor."Mobile Phone No",msg);

                                  end;
                                 end
                                 else begin
                                 result:='INSUFFICIENT';
                                         msg:='You have insufficient funds in your savings Account to use this service.'+
                                        '. Thank you for using ILKISONKO  Sacco Mobile.';
                                        SMSMessage(DocNumber,accFrom,Vendor."Mobile Phone No",msg);
                                 end;
                        end
                        else begin
                          result:='ACC2INEXISTENT';
                                     msg:='Your request has failed because you do not have any outstanding balance.'+
                                    '. Thank you for using ILKISONKO  Sacco Mobile.';
                                    SMSMessage(DocNumber,accFrom,Vendor."Mobile Phone No",msg);
                        end;
                  end
                  else begin
                    result:='ACCINEXISTENT';
                                msg:='Your request has failed.Please make sure you are registered for mobile banking.'+
                                '. Thank you for using ILKISONKO  Sacco Mobile.';
                                SMSMessage(DocNumber,accFrom,Vendor."Mobile Phone No",msg);
                  end;
              end
              else begin
                  result:='MEMBERINEXISTENT';
                            msg:='Your request has failed because the recipent account does not exist.'+
                            '. Thank you for using ILKISONKO  Sacco Mobile.';
                            SMSMessage(DocNumber,accFrom,Vendor."Mobile Phone No",msg);
              end;
          end
    end;


    procedure OutstandingLoans(phone: Text[20]) loannos: Text[200]
    begin
        begin
          Vendor.Reset;
          Vendor.SetRange(Vendor."Mobile Phone No",phone);
              if Vendor.Find('-') then begin
                LoansRegister.Reset;
                LoansRegister.SetRange(LoansRegister."Client Code",Vendor."BOSA Account No");
                if LoansRegister.Find('-') then begin
                repeat
                  LoansRegister.CalcFields(LoansRegister."Outstanding Balance",LoansRegister."Interest Due",LoansRegister."Interest to be paid",LoansRegister."Oustanding Interest");
                  if (LoansRegister."Outstanding Balance">0) then
                  loannos:= loannos + ':::' + LoansRegister."Loan  No.";
                until LoansRegister.Next = 0;
                end;
          end
        end;
    end;


    procedure LoanGuarantors(loanNo: Text[20]) guarantors: Text[1000]
    begin
        begin
          LoanGuaranteeDetails.Reset;
          LoanGuaranteeDetails.SetRange(LoanGuaranteeDetails."Loan No",loanNo);
          if LoanGuaranteeDetails.Find('-') then begin
            repeat
              if LoanGuaranteeDetails."Amont Guaranteed">0 then
                guarantors:=guarantors + '::::'+ LoanGuaranteeDetails.Name+':::'+Format(LoanGuaranteeDetails."Amont Guaranteed");
            until LoanGuaranteeDetails.Next =0;
          end;
        end;
    end;


    procedure LoansGuaranteed(phone: Text[20]) guarantors: Text[1000]
    begin
        begin
        //guarantors:='';
        Members.Reset;
          Members.SetRange(Members."Phone No.",phone);
          if Members.Find('-') then begin
            //bosaNo:=Vendor."BOSA Account No";
            //END;

            LoanGuaranteeDetails.Reset;
            LoanGuaranteeDetails.SetRange(LoanGuaranteeDetails."Member No",Members."No.");
            if LoanGuaranteeDetails.Find('-') then begin
              repeat
                 guarantors:=guarantors + ':::' + LoanGuaranteeDetails."Loan No"+':'+Format(LoanGuaranteeDetails."Guarantor Outstanding");
              until LoanGuaranteeDetails.Next =0;
            end;
            end;
           //IF guarantors='' THEN BEGIN
           //  guarantors:= guarantors + ':::' +'no';
           //  END;
        end;
    end;


    procedure ClientCodes(loanNo: Text[20]) codes: Text[20]
    begin
        begin
          LoansRegister.Reset;
          LoansRegister.SetRange(LoansRegister."Loan  No.",loanNo);
          if LoansRegister.Find('-') then begin
            codes:=LoansRegister."Client Code";
            end;
        end
    end;


    procedure ClientNames(ccode: Text[20]) names: Text[100]
    begin
        begin
          LoansRegister.Reset;
          LoansRegister.SetRange(LoansRegister."Client Code",ccode);
          if LoansRegister.Find('-') then begin
              Vendor.Reset;
              Vendor.SetRange(Vendor."BOSA Account No",ccode);
              if Vendor.Find('-') then begin
                names:=Vendor.Name;
              end;
            end;
        end
    end;


    procedure ChargesGuarantorInfo(Phone: Text[20];DocNumber: Text[20]) result: Text[250]
    var
        amount: Decimal;
    begin
        begin
        CloudPESATrans.Reset;
        CloudPESATrans.SetRange(CloudPESATrans."Document No", DocNumber);
        if CloudPESATrans.Find('-') then begin
          result:='REFEXISTS';
        end
        else begin
          result :='';
          GenLedgerSetup.Reset;
          GenLedgerSetup.Get;
          GenLedgerSetup.TestField(GenLedgerSetup."Mobile Charge");
          GenLedgerSetup.TestField(GenLedgerSetup."CloudPESA Comm Acc");
          GenLedgerSetup.TestField(GenLedgerSetup."CloudPESA Charge");

          Charges.Reset;
          Charges.SetRange(Charges.Code,GenLedgerSetup."Mobile Charge");
          if Charges.Find('-') then begin
            Charges.TestField(Charges."GL Account");
            MobileChargesACC:=Charges."GL Account";
          end;

            CloudPESACommACC:=  GenLedgerSetup."CloudPESA Comm Acc";
            CloudPESACharge:=0;

            Vendor.Reset;
            Vendor.SetRange(Vendor."Mobile Phone No",Phone);
            if Vendor.Find('-') then begin
              AccountTypes.Reset;
                AccountTypes.SetRange(AccountTypes.Code,Vendor."Account Type")  ;
                //AccountTypes.SETRANGE(AccountTypes."Last Account No Used(HQ)",FALSE);
                if AccountTypes.Find('-') then
                begin
                  miniBalance:=AccountTypes."Minimum Balance";
                end;

             Vendor.CalcFields(Vendor."Balance (LCY)");
             TempBalance:=Vendor."Balance (LCY)"-(Vendor."ATM Transactions"+Vendor."Uncleared Cheques"+Vendor."EFT Transactions"+miniBalance);
             fosaAcc:=Vendor."No.";

                  if (TempBalance>CloudPESACharge) then begin
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name",'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name",'MOBILETRAN');
                        GenJournalLine.DeleteAll;
                        //end of deletion

                        GenBatches.Reset;
                        GenBatches.SetRange(GenBatches."Journal Template Name",'GENERAL');
                        GenBatches.SetRange(GenBatches.Name,'MOBILETRAN');

                        if GenBatches.Find('-') = false then begin
                        GenBatches.Init;
                        GenBatches."Journal Template Name":='GENERAL';
                        GenBatches.Name:='MOBILETRAN';
                        GenBatches.Description:='Loan Guarantors Info';
                        GenBatches.Validate(GenBatches."Journal Template Name");
                        GenBatches.Validate(GenBatches.Name);
                        GenBatches.Insert;
                        end;

                //Dr Mobile Transfer Charges
                        LineNo:=LineNo+10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='GENERAL';
                        GenJournalLine."Journal Batch Name":='MOBILETRAN';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No.":=fosaAcc;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No.":=DocNumber;
                        GenJournalLine."External Document No.":=fosaAcc;
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine.Description:='Loan Guarantors Info Charges';
                        GenJournalLine.Amount:=CloudPESACharge ;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;

                //CR Commission
                        LineNo:=LineNo+10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='GENERAL';
                        GenJournalLine."Journal Batch Name":='MOBILETRAN';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Account No.":=CloudPESACommACC;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No.":=DocNumber;
                        GenJournalLine."External Document No.":=MobileChargesACC;
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine.Description:='Loan Guarantors Info Charges';
                        GenJournalLine.Amount:=-CloudPESACharge;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;

                        //Post
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name",'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name",'MOBILETRAN');
                        if GenJournalLine.Find('-') then begin
                        repeat
                        GLPosting.Run(GenJournalLine);
                        until GenJournalLine.Next = 0;
                        end;
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name",'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name",'MOBILETRAN');
                        GenJournalLine.DeleteAll;

                        CloudPESATrans.Init;
                        CloudPESATrans."Document No":=DocNumber;
                        CloudPESATrans.Description:='Loan Guarantors Info';
                        CloudPESATrans."Document Date":=Today;
                        CloudPESATrans."Account No" :=Vendor."No.";
                         TotalCharges:=ExcDuty+MobileCharges+CloudPESACharge;
                          CloudPESATrans.Charge:=TotalCharges;
                         CloudPESATrans."Account Name":=Vendor.Name;
                          CloudPESATrans."Telephone Number":=Vendor."Mobile Phone No";
                        CloudPESATrans."Account No2" :='';
                        CloudPESATrans.Amount:=amount;
                        CloudPESATrans.Posted:=true;
                        CloudPESATrans."Posting Date":=Today;
                        CloudPESATrans.Status:=CloudPESATrans.Status::Completed;
                        CloudPESATrans.Comments:='Success';
                        CloudPESATrans.Client:=Vendor."BOSA Account No";
                        CloudPESATrans."Transaction Type":=CloudPESATrans."transaction type"::Ministatement;
                        CloudPESATrans."Transaction Time":=Time;
                        CloudPESATrans.Insert;
                        result:='TRUE';
                       end
                       else begin
                         result:='INSUFFICIENT';
                       end;
                end
                else begin
                  result:='ACCNOTFOUND';
                end;
              end;
          end;
    end;


    procedure AccountBalanceNew(Acc: Code[30];DocNumber: Code[20]) Bal: Text[50]
    var
        amount: Decimal;
    begin
        begin
        CloudPESATrans.Reset;
        CloudPESATrans.SetRange(CloudPESATrans."Document No", DocNumber);
        if CloudPESATrans.Find('-') then begin
          Bal:='REFEXISTS';
        end
        else begin
          Bal:='';
          GenLedgerSetup.Reset;
          GenLedgerSetup.Get;
          GenLedgerSetup.TestField(GenLedgerSetup."Mobile Charge");
          GenLedgerSetup.TestField(GenLedgerSetup."CloudPESA Comm Acc");
          GenLedgerSetup.TestField(GenLedgerSetup."CloudPESA Charge");

          Charges.Reset;
          Charges.SetRange(Charges.Code,GenLedgerSetup."Mobile Charge");
          if Charges.Find('-') then begin
            Charges.TestField(Charges."GL Account");
            MobileCharges:=0; //Charges."Charge Amount";
            MobileChargesACC:=Charges."GL Account";
          end;

            CloudPESACommACC:=  GenLedgerSetup."CloudPESA Comm Acc";
             CloudPESACharge:=GenLedgerSetup."CloudPESA Charge";

            ExcDuty:=(20/100)*(MobileCharges+CloudPESACharge);

            Vendor.Reset;
            Vendor.SetRange(Vendor."No.",Acc);
            if Vendor.Find('-') then begin
              AccountTypes.Reset;
                AccountTypes.SetRange(AccountTypes.Code,Vendor."Account Type")  ;
                //AccountTypes.SETRANGE(AccountTypes."Last Account No Used(HQ)",FALSE);
                if AccountTypes.Find('-') then
                begin
                  miniBalance:=AccountTypes."Minimum Balance";
                end;
             Vendor.CalcFields(Vendor."Balance (LCY)");
             TempBalance:=Vendor."Balance (LCY)"-(Vendor."ATM Transactions"+Vendor."Uncleared Cheques"+Vendor."EFT Transactions"+miniBalance);

                  if (Vendor."Account Type"='ORDINARY') or (Vendor."Account Type"='SALARY')or (Vendor."Account Type"='FIXED')then
                  begin
                  if (TempBalance>MobileCharges+CloudPESACharge) then begin
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name",'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name",'MOBILETRAN');
                        GenJournalLine.DeleteAll;
                        //end of deletion

                        GenBatches.Reset;
                        GenBatches.SetRange(GenBatches."Journal Template Name",'GENERAL');
                        GenBatches.SetRange(GenBatches.Name,'MOBILETRAN');

                        if GenBatches.Find('-') = false then begin
                        GenBatches.Init;
                        GenBatches."Journal Template Name":='GENERAL';
                        GenBatches.Name:='MOBILETRAN';
                        GenBatches.Description:='Balance Enquiry';
                        GenBatches.Validate(GenBatches."Journal Template Name");
                        GenBatches.Validate(GenBatches.Name);
                        GenBatches.Insert;
                        end;

                //Dr Mobile Transfer Charges
                        LineNo:=LineNo+10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='GENERAL';
                        GenJournalLine."Journal Batch Name":='MOBILETRAN';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No.":=Acc;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No.":=DocNumber;
                        GenJournalLine."External Document No.":=Acc;
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine.Description:='Balance Enquiry';
                        GenJournalLine.Amount:=MobileCharges + CloudPESACharge ;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;

                //DR Excise Duty
                        LineNo:=LineNo+10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='GENERAL';
                        GenJournalLine."Journal Batch Name":='MOBILETRAN';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No.":=Acc;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No.":=DocNumber;
                        GenJournalLine."External Document No.":=Acc;
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine.Description:='Excise duty-Balance Enquiry';
                        GenJournalLine.Amount:=ExcDuty;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;

                        LineNo:=LineNo+10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='GENERAL';
                        GenJournalLine."Journal Batch Name":='MOBILETRAN';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Account No.":=ExxcDuty;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No.":=DocNumber;
                        GenJournalLine."External Document No.":=MobileChargesACC;
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine.Description:='Excise duty-Balance Enquiry';
                        GenJournalLine.Amount:=ExcDuty*-1;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;

                //CR Commission
                        LineNo:=LineNo+10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='GENERAL';
                        GenJournalLine."Journal Batch Name":='MOBILETRAN';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Account No.":=CloudPESACommACC;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No.":=DocNumber;
                        GenJournalLine."External Document No.":=MobileChargesACC;
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine.Description:='Balance Enquiry Charges';
                        GenJournalLine.Amount:=-CloudPESACharge;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;

                //CR Mobile Transactions Acc
                        LineNo:=LineNo+10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='GENERAL';
                        GenJournalLine."Journal Batch Name":='MOBILETRAN';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Account No.":=MobileChargesACC;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No.":=DocNumber;
                        GenJournalLine."External Document No.":=MobileChargesACC;
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine.Description:='Balance Enquiry Charges';
                        GenJournalLine.Amount:=MobileCharges*-1;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;

                        //Post
                        GenJournalLine.Reset;

                        GenJournalLine.SetRange("Journal Template Name",'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name",'MOBILETRAN');
                        if GenJournalLine.Find('-') then begin
                        repeat
                        GLPosting.Run(GenJournalLine);
                        until GenJournalLine.Next = 0;
                        end;
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name",'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name",'MOBILETRAN');
                        GenJournalLine.DeleteAll;

                        CloudPESATrans.Init;
                        CloudPESATrans."Document No":=DocNumber;
                        CloudPESATrans.Description:='Balance Enquiry';
                        CloudPESATrans."Document Date":=Today;
                        CloudPESATrans."Account No" :=Vendor."No.";
                         TotalCharges:=ExcDuty+MobileCharges+CloudPESACharge;
                          CloudPESATrans.Charge:=TotalCharges;
                         CloudPESATrans."Account Name":=Vendor.Name;
                          CloudPESATrans."Telephone Number":=Vendor."Mobile Phone No";
                        CloudPESATrans."Account No2" :='';
                        CloudPESATrans.Amount:=amount;
                        CloudPESATrans.Posted:=true;
                        CloudPESATrans."Posting Date":=Today;
                        CloudPESATrans.Status:=CloudPESATrans.Status::Completed;
                        CloudPESATrans.Comments:='Success';
                        CloudPESATrans.Client:=Vendor."BOSA Account No";
                        CloudPESATrans."Transaction Type":=CloudPESATrans."transaction type"::Balance;
                        CloudPESATrans."Transaction Time":=Time;
                        CloudPESATrans.Insert;
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
                             msg:='Account Name: '+Vendor.Name+', '+'BALANCE: '+Format(accBalance)+'. '
                            +'Thank you for using ILKISONKO  Sacco Mobile';
                            SMSMessage(DocNumber,Vendor."No.",Vendor."Mobile Phone No",msg);
                          Bal:='TRUE';
                        end
                       else begin
                         Bal:='INSUFFICIENT';
                       end;
                       end
                       else begin
                          AccountTypes.Reset;
                          AccountTypes.SetRange(AccountTypes.Code,Vendor."Account Type")  ;
                          if AccountTypes.Find('-') then
                          begin
                            miniBalance:=AccountTypes."Minimum Balance";
                          end;
                       end;
                end
                else begin
                  Bal:='ACCNOTFOUND';
                end;
              end;
          end;
    end;


    procedure AccountBalanceDec(Acc: Code[30];amt: Decimal) Bal: Decimal
    begin
          begin
          Vendor.Reset;
          Vendor.SetRange(Vendor."No.", Acc);
          if Vendor.Find('-') then
           begin
                AccountTypes.Reset;
                AccountTypes.SetRange(AccountTypes.Code,Vendor."Account Type")  ;
                //AccountTypes.SETRANGE(AccountTypes."Last Account No Used(HQ)",FALSE);
                if AccountTypes.Find('-') then
                begin
                  miniBalance:=AccountTypes."Minimum Balance";
                end;
                Vendor.CalcFields(Vendor."Balance (LCY)");
                Vendor.CalcFields(Vendor."ATM Transactions");
                Vendor.CalcFields(Vendor."Uncleared Cheques");
                Vendor.CalcFields(Vendor."EFT Transactions");
                Bal:=Vendor."Balance (LCY)"-(Vendor."ATM Transactions"+Vendor."Uncleared Cheques"+Vendor."EFT Transactions"+miniBalance);

                GenLedgerSetup.Reset;
                GenLedgerSetup.Get;
                GenLedgerSetup.TestField(GenLedgerSetup."Mobile Charge");
                //GenLedgerSetup.TESTFIELD(GenLedgerSetup."MPESA Reconciliation acc");
                GenLedgerSetup.TestField(GenLedgerSetup."CloudPESA Comm Acc");
                GenLedgerSetup.TestField(GenLedgerSetup."CloudPESA Charge");

                Charges.Reset;
                Charges.SetRange(Charges.Code,GenLedgerSetup."Mobile Charge");
                if Charges.Find('-') then begin
                  Charges.TestField(Charges."GL Account");

                  MPESACharge:=GetCharge(amt,'MPESA');
                  CloudPESACharge:=GetCharge(amt,'VENDWD');
                  MobileCharges:=GetCharge(amt,'SACCOWD');

                  ExcDuty:=(20/100)*(MobileCharges+CloudPESACharge);
                  TotalCharges:=CloudPESACharge+MobileCharges+ExcDuty+MPESACharge;
                  end;
                  Bal:=Bal-TotalCharges;
           end
          end;
    end;

    local procedure GetCharge(amount: Decimal;"code": Text[20]) charge: Decimal
    begin
        TariffDetails.Reset;
        TariffDetails.SetRange(TariffDetails.Code,code);
        TariffDetails.SetFilter(TariffDetails."Lower Limit",'<=%1',amount);
        TariffDetails.SetFilter(TariffDetails."Upper Limit",'>=%1',amount);
        if TariffDetails.Find('-') then begin
          charge:=TariffDetails."Charge Amount";
        end
    end;


    procedure PostMPESATrans(docNo: Text[20];telephoneNo: Text[20];amount: Decimal;transactionDate: Date) result: Text[30]
    begin
        
        CloudPESATrans.Reset;
        CloudPESATrans.SetRange(CloudPESATrans."Document No", docNo);
        if CloudPESATrans.Find('-') then begin
          result:='REFEXISTS';
        end
        else begin
        
          GenLedgerSetup.Reset;
          GenLedgerSetup.Get;
          GenLedgerSetup.TestField(GenLedgerSetup."Mobile Charge");
          GenLedgerSetup.TestField(GenLedgerSetup."MPESA Settl Acc");
          GenLedgerSetup.TestField(GenLedgerSetup."CloudPESA Comm Acc");
         // GenLedgerSetup.TESTFIELD(GenLedgerSetup."CloudPESA Charge");
        
          Charges.Reset;
          Charges.SetRange(Charges.Code,GenLedgerSetup."Mobile Charge");
          if Charges.Find('-') then begin
            Charges.TestField(Charges."GL Account");
        
            MPESACharge:=GetCharge(amount,'MPESA');
            CloudPESACharge:=GetCharge(amount,'VENDWD');
            MobileCharges:=GetCharge(amount,'SACCOWD');
        
            CloudPESACommACC:=  GenLedgerSetup."CloudPESA Comm Acc";
            MPESARecon:=GenLedgerSetup."MPESA Settl Acc";
            MobileChargesACC:=Charges."GL Account";
        
            ExcDuty:=(20/100)*(MobileCharges);
            TotalCharges:=CloudPESACharge+MobileCharges+ExcDuty+MPESACharge;
          end;
        
            Vendor.Reset;
            Vendor.SetRange(Vendor."No.", telephoneNo);
           // Vendor.SETFILTER(Vendor."Account Type",'<>%1', 'SALARY');
            if Vendor.Find('-') then begin
             Vendor.CalcFields(Vendor."Balance (LCY)");
             TempBalance:=Vendor."Balance (LCY)"-(Vendor."ATM Transactions"+Vendor."Uncleared Cheques"+Vendor."EFT Transactions");
        
                 if (TempBalance>amount+TotalCharges) then begin
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name",'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name",'MPESAWITHD');
                        GenJournalLine.DeleteAll;
                        //end of deletion
        
                        GenBatches.Reset;
                        GenBatches.SetRange(GenBatches."Journal Template Name",'GENERAL');
                        GenBatches.SetRange(GenBatches.Name,'MPESAWITHD');
        
                        if GenBatches.Find('-') = false then begin
                        GenBatches.Init;
                        GenBatches."Journal Template Name":='GENERAL';
                        GenBatches.Name:='MPESAWITHD';
                        GenBatches.Description:='MPESA Withdrawal';
                        GenBatches.Validate(GenBatches."Journal Template Name");
                        GenBatches.Validate(GenBatches.Name);
                        GenBatches.Insert;
                        end;
        
                //DR Customer Acc
                        LineNo:=LineNo+10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='GENERAL';
                        GenJournalLine."Journal Batch Name":='MPESAWITHD';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No.":=Vendor."No.";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No.":=docNo;
                        GenJournalLine."External Document No.":=Vendor."No.";
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine.Description:='MPESA Withdrawal';
                        GenJournalLine.Amount:=amount;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;
        
        //Cr Bank a/c
                        LineNo:=LineNo+10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='GENERAL';
                        GenJournalLine."Journal Batch Name":='MPESAWITHD';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Account Type":=GenJournalLine."account type"::"Bank Account";
                        GenJournalLine."Account No.":=MPESARecon;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No.":=docNo;
                        GenJournalLine."External Document No.":=Vendor."No.";
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine.Description:='MPESA Withdrawal';
                        GenJournalLine.Amount:=(amount+MPESACharge)*-1;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;
        
                //Dr Withdrawal Charges
                        LineNo:=LineNo+10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='GENERAL';
                        GenJournalLine."Journal Batch Name":='MPESAWITHD';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No.":=Vendor."No.";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No.":=docNo;
                        GenJournalLine."External Document No.":=Vendor."No.";
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine.Description:='Mobile Withdrawal Charges';
                        GenJournalLine.Amount:=TotalCharges;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;
        
                //CR Mobile Transactions Acc
                        LineNo:=LineNo+10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='GENERAL';
                        GenJournalLine."Journal Batch Name":='MPESAWITHD';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Account No.":=MobileChargesACC;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No.":=docNo;
                        GenJournalLine."External Document No.":=MobileChargesACC;
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine.Description:='Mobile Withdrawal Charges';
                        GenJournalLine.Amount:=MobileCharges*-1;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;
        
                //CR Surestep Acc
                        LineNo:=LineNo+10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='GENERAL';
                        GenJournalLine."Journal Batch Name":='MPESAWITHD';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Account No.":=CloudPESACommACC;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No.":=docNo;
                        GenJournalLine."External Document No.":=MobileChargesACC;
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine.Description:='Mobile Withdrawal Charges';
                        GenJournalLine.Amount:=-CloudPESACharge;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;
        
                       //CR Excise Duty
                              LineNo:=LineNo+10000;
                              GenJournalLine.Init;
                              GenJournalLine."Journal Template Name":='GENERAL';
                              GenJournalLine."Journal Batch Name":='MPESAWITHD';
                              GenJournalLine."Line No.":=LineNo;
                              GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                              GenJournalLine."Account No.":=Format(ExxcDuty);
                              GenJournalLine.Validate(GenJournalLine."Account No.");
                              GenJournalLine."Document No.":=docNo;
                              GenJournalLine."External Document No.":=docNo;
                              GenJournalLine."Posting Date":=Today;
                              GenJournalLine.Description:='Excise duty';
                              GenJournalLine.Amount:=ExcDuty*-1;
                              GenJournalLine.Validate(GenJournalLine.Amount);
                              if GenJournalLine.Amount<>0 then
                              GenJournalLine.Insert;
        
                        //Post
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name",'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name",'MPESAWITHD');
                        if GenJournalLine.Find('-') then begin
                        repeat
                        GLPosting.Run(GenJournalLine);
                        until GenJournalLine.Next = 0;
                        end;
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name",'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name",'MPESAWITHD');
                        GenJournalLine.DeleteAll;
                          msg:='You have withdrawn KES '+Format(amount)+' from Account '+Vendor.Name+
                        ' .Thank you for using ILKISONKO Sacco Mobile.';
        
                        CloudPESATrans.Init;
                        CloudPESATrans."Document No":=docNo;
                        CloudPESATrans.Description:='MPESA Withdrawal';
                        CloudPESATrans."Document Date":=Today;
                        CloudPESATrans."Account No" :=Vendor."No.";
                        CloudPESATrans."Account No2" :=MPESARecon;
                         TotalCharges:=ExcDuty+MobileCharges+CloudPESACharge;
                          CloudPESATrans.Charge:=TotalCharges;
                         CloudPESATrans."Account Name":=Vendor.Name;
                          CloudPESATrans."Telephone Number":=Vendor."Mobile Phone No";
                          CloudPESATrans."SMS Message":=msg;
                        CloudPESATrans.Amount:=amount;
                        CloudPESATrans.Status:=CloudPESATrans.Status::Completed;
                        CloudPESATrans.Posted:=true;
                        CloudPESATrans."Posting Date":=Today;
                        CloudPESATrans.Comments:='Success';
                        CloudPESATrans.Client:=Vendor."BOSA Account No";
                        CloudPESATrans."Transaction Type":=CloudPESATrans."transaction type"::Withdrawal;
                        CloudPESATrans."Transaction Time":=Time;
                        CloudPESATrans.Insert;
                        result:='TRUE';
        
                        SMSMessage(docNo,Vendor."No.",Vendor."Mobile Phone No",msg);
                     end
                     else begin
                     result:='INSUFFICIENT';
                            /* msg:='You have insufficient funds in your savings Account to use this service.'+
                            ' .Thank you for using ILKISONKO Sacco Mobile.';
                            SMSMessage(docNo,Vendor."No.",Vendor."Mobile Phone No",msg);*/
                              CloudPESATrans.Init;
                              CloudPESATrans."Document No":=docNo;
                              CloudPESATrans.Description:='MPESA Withdrawal';
                              CloudPESATrans."Document Date":=Today;
                              CloudPESATrans."Account No" :=Vendor."No.";
                              CloudPESATrans."Account No2" :=MPESARecon;
                               TotalCharges:=ExcDuty+MobileCharges+CloudPESACharge;
                              CloudPESATrans.Charge:=TotalCharges;
                              CloudPESATrans."Account Name":=Vendor.Name;
                              CloudPESATrans."Telephone Number":=Vendor."Mobile Phone No";
                              CloudPESATrans.Amount:=amount;
                              CloudPESATrans.Status:=CloudPESATrans.Status::Failed;
                              CloudPESATrans.Posted:=false;
                              CloudPESATrans."Posting Date":=Today;
                              CloudPESATrans.Comments:='Failed,Insufficient Funds';
                              CloudPESATrans.Client:=Vendor."BOSA Account No";
                              CloudPESATrans."Transaction Type":=CloudPESATrans."transaction type"::Withdrawal;
                              CloudPESATrans."Transaction Time":=Time;
                              CloudPESATrans.Insert;
                     end;
               end
                else begin
                  result:='ACCINEXISTENT';
                             /* msg:='Your request has failed because account does not exist.'+
                              ' .Thank you for using ILKISONKO Sacco Mobile.';
                              SMSMessage(docNo,Vendor."No.",Vendor."Mobile Phone No",msg);*/
                              CloudPESATrans.Init;
                              CloudPESATrans."Document No":=docNo;
                              CloudPESATrans.Description:='MPESA Withdrawal';
                              CloudPESATrans."Document Date":=Today;
                              CloudPESATrans."Account No" :='';
                              CloudPESATrans."Account No2" :=MPESARecon;
                              CloudPESATrans.Amount:=amount;
                              CloudPESATrans.Posted:=false;
                              CloudPESATrans."Posting Date":=Today;
                              CloudPESATrans.Comments:='Failed,Invalid Account';
                              CloudPESATrans.Client:='';
                              CloudPESATrans."Transaction Type":=CloudPESATrans."transaction type"::Withdrawal;
                              CloudPESATrans."Transaction Time":=Time;
                              CloudPESATrans.Insert;
                end;
          end;

    end;


    procedure AccountDescription("code": Text[20]) description: Text[100]
    begin

          AccountTypes.Reset;
          AccountTypes.SetRange(AccountTypes.Code,code);
          if AccountTypes.Find('-') then begin
            description:=AccountTypes.Description;
          end else begin
            description:='';
          end;
    end;


    procedure InsertTransaction("Document No": Code[30];Keyword: Code[30];"Account No": Code[30];"Account Name": Text[100];Telephone: Code[20];Amount: Decimal;"Sacco Bal": Decimal;paybillno: Code[30]) Result: Code[20]
    begin
          PaybillTrans.Reset;
          PaybillTrans.SetRange(PaybillTrans."Document No","Document No");
          if PaybillTrans.Find('-') then begin
            if PaybillTrans.Posted=false then begin
              PaybillSwitch();
            end;
          end else begin
            PaybillTrans.Init;
            PaybillTrans."Document No":="Document No";
            PaybillTrans."Key Word":=Keyword;
            PaybillTrans."Account No":="Account No";
            PaybillTrans."Account Name":="Account Name";
            PaybillTrans."Transaction Date":=CurrentDatetime;
            PaybillTrans.Description:='PayBill Deposit';
            PaybillTrans.Telephone:=Telephone;
            PaybillTrans.Amount:=Amount;
            PaybillTrans."Transaction Time":=Time;
            PaybillTrans."Paybill Acc Balance":="Sacco Bal";
            PaybillTrans."PayBill No":=paybillno;
            PaybillTrans.Posted:=false;
            PaybillTrans.Insert;
            Commit();
            Result:=PaybillSwitch();
            Result:='SUCCESS';
          end;
    end;


    procedure PaybillSwitch() Result: Code[50]
    var
        RecCount: Integer;
    begin
          RecCount :=0;
          PaybillTrans.Reset;
          //PaybillTrans.ASCENDING(false);
          PaybillTrans.SetRange(PaybillTrans.Posted,false);
          PaybillTrans.SetRange(PaybillTrans."Needs Manual Posting",false);
          PaybillTrans.SetFilter(PaybillTrans.Amount,'>%1',0);

          //PaybillTrans.SETFILTER(PaybillTrans.Description,'%1','PayBill Deposit');
          //PaybillTrans.SETRANGE(PaybillTrans."Document No",'QHA3Z9QWER');
          if PaybillTrans.Find('-') then begin
            repeat

              if (FnCheckDoublePosting(PaybillTrans."Document No")='POSTED') then begin

                // ** already posted, mark as posted
                PaybillTrans."Date Posted":=Today;
                PaybillTrans."Needs Manual Posting":=false;
                PaybillTrans.Posted:=true;
                PaybillTrans.Modify;

              end else begin

                if PaybillTrans."Account No"='' then begin
                  PaybillTrans."Date Posted":=Today;
                  PaybillTrans."Needs Manual Posting":=true;
                  PaybillTrans.Modify;
                end else begin


                  // -- check if account length is within limits
                  if (StrLen( PaybillTrans."Account No")>20) then begin
                    PaybillTrans."Date Posted":=Today;
                    PaybillTrans."Needs Manual Posting":=true;
                    PaybillTrans.Modify;
                  end else begin

                   // MESSAGE('>> '+ PaybillTrans."Document No");
                    if (CopyStr(PaybillTrans."Account No",1,3)='TEN') then begin

                      Vendor.Reset;
                      Vendor.SetRange("No.",CopyStr(PaybillTrans."Account No",1,20));
                      if Vendor.Find('-') then begin
                        Result:=PayBillToAccRent('PAYBILL',PaybillTrans."Document No",PaybillTrans."Account No",PaybillTrans."Account No",PaybillTrans.Amount,'RENT',PaybillTrans."PayBill No");
                      end else begin
                        //MESSAGE('failed TEN '+ PaybillTrans."Account No");
                      end;

                    end else if (CopyStr(PaybillTrans."Account No",1,3)='FOS') then begin

                      Vendor.Reset;
                      Vendor.SetRange("No.",CopyStr(PaybillTrans."Account No",1,20));
                      if Vendor.Find('-') then begin
                        Result:=PayBillToAcc('PAYBILL',PaybillTrans."Document No",PaybillTrans."Account No",PaybillTrans."Account No",PaybillTrans.Amount,'',PaybillTrans."PayBill No");
                      end else begin
                        //MESSAGE('failed FOS '+ PaybillTrans."Account No");
                      end;

                    end else begin
                      //MESSAGE('checking if fosa '+ PaybillTrans."Account No");
                      Vendor.Reset;
                      Vendor.SetRange("No.",PaybillTrans."Account No");
                      if Vendor.Find('-') then begin
                        //MESSAGE('is fosa '+ PaybillTrans."Account No");
                         Result:=PayBillToAcc('PAYBILL',PaybillTrans."Document No",PaybillTrans."Account No",PaybillTrans."Account No",PaybillTrans.Amount,'',PaybillTrans."PayBill No");
                      end else begin
                        //MESSAGE('checking if loan'+ PaybillTrans."Account No");
                        LoansRegister.Reset;
                        LoansRegister.SetRange("Loan  No.", PaybillTrans."Account No");
                        if LoansRegister.Find('-') then begin
                          Result:=PayBillToLoan('PAYBILL',PaybillTrans."Document No",PaybillTrans."Account No",PaybillTrans."Account No",PaybillTrans.Amount,'',PaybillTrans."PayBill No");
                        end else begin
                          //MESSAGE('not loan, checking if member '+ PaybillTrans."Account No");
                          Members.Reset;
                          Members.SetRange("No.",fngetmemberNo(PaybillTrans."Account No"));
                          if Members.Find('-') then begin
                            //MESSAGE('is member '+Members."No."+'   '+ PaybillTrans."Account No");
                            Result:=PayBillToBOSA('PAYBILL',PaybillTrans."Document No",Members."No.",Members."No.",PaybillTrans.Amount,PaybillTrans."Key Word",'',PaybillTrans."PayBill No");
                          end else begin
                           // MESSAGE('failed all checks '+ PaybillTrans."Account No");
                          end;

                        end;

                      end;

                    end;

                  end;

                  if Result='' then begin
                    PaybillTrans."Date Posted":=Today;
                    PaybillTrans."Needs Manual Posting":=true;
                    //PaybillTrans.Description:='Failed';
                    PaybillTrans.Modify;

                    msg:='Dear ' +PaybillTrans."Account Name"+' Deposit of Ksh.'+ Format(PaybillTrans.Amount) +'will be credited to account: '+PaybillTrans."Account No"+'.';
                    //Note that Short Codes have been updated, Please contact us.';

                   // SMSMessage('PAYBILLTRANS',PaybillTrans."Account No",PaybillTrans.Telephone,msg);

                  end;
                end;
              end;
              RecCount +=1;

            until (RecCount =5) or (PaybillTrans.Next=0);

          end;

          Result:='Not Found';
    end;

    local procedure PayBillToAccRent(batch: Code[50];docNo: Code[50];accNo: Code[50];memberNo: Code[50];Amount: Decimal;accountType: Code[30];paybillno: Code[30]) res: Code[10]
    begin

          GenLedgerSetup.Reset;
          GenLedgerSetup.Get;
          //Gensetup.RESET;
          //Gensetup.GET;
          GenLedgerSetup.TestField(GenLedgerSetup."CloudPESA Comm Acc");
          GenLedgerSetup.TestField(GenLedgerSetup."PayBill Settl Acc");
          GenLedgerSetup.TestField(GenLedgerSetup."PayBill Settl Acc 2");
          GenLedgerSetup.TestField(GenLedgerSetup."Rent Collection Commission acc");
          // Gensetup.TESTFIELD(Gensetup);

          if paybillno ='323730' then begin
            PaybillRecon:=GenLedgerSetup."PayBill Settl Acc";
          end else begin
            PaybillRecon:=GenLedgerSetup."PayBill Settl Acc 2";
          end;

          RentCollectionCharge:=(6*PaybillTrans.Amount)/100;  //GetCharge(Amount,'PAYBILL');
          RentCollectionCommACC:=GenLedgerSetup."Rent Collection Commission acc";


          GenJournalLine.Reset;
          GenJournalLine.SetRange("Journal Template Name",'GENERAL');
          GenJournalLine.SetRange("Journal Batch Name",batch);
          GenJournalLine.DeleteAll;
          //end of deletion

          GenBatches.Reset;
          GenBatches.SetRange(GenBatches."Journal Template Name",'GENERAL');
          GenBatches.SetRange(GenBatches.Name,batch);


          if GenBatches.Find('-') = false then begin
            GenBatches.Init;
            GenBatches."Journal Template Name":='GENERAL';
            GenBatches.Name:=batch;
            GenBatches.Description:='Paybill Deposit';
            GenBatches.Validate(GenBatches."Journal Template Name");
            GenBatches.Validate(GenBatches.Name);
            GenBatches.Insert;
          end;//General Jnr Batches


          Vendor.Reset;
          Vendor.SetRange(Vendor."No.", accNo);
          //   Vendor.SETRANGE(Vendor."Account Type", accountType);
          if Vendor.Find('-') then begin
            Vendor.CalcFields("Rent Account");
            //Dr MPESA PAybill ACC
            LineNo:=LineNo+10000;
            GenJournalLine.Init;
            GenJournalLine."Journal Template Name":='GENERAL';
            GenJournalLine."Journal Batch Name":=batch;
            GenJournalLine."Line No.":=LineNo;
            GenJournalLine."Account Type":=GenJournalLine."account type"::"Bank Account";
            GenJournalLine."Account No.":=PaybillRecon;
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Source No.":=Vendor."No.";
            GenJournalLine."Document No.":=docNo;
            GenJournalLine."External Document No.":=docNo;
            GenJournalLine."Posting Date":=Today;
            GenJournalLine.Description:='Rent from ' + PaybillTrans.Telephone+ '-' + PaybillTrans."Account Name";;
            GenJournalLine.Amount:=Amount;
            GenJournalLine.Validate(GenJournalLine.Amount);
            if GenJournalLine.Amount<>0 then
            GenJournalLine.Insert;

            //Cr Customer
            LineNo:=LineNo+10000;
            GenJournalLine.Init;
            GenJournalLine."Journal Template Name":='GENERAL';
            GenJournalLine."Journal Batch Name":=batch;
            GenJournalLine."Line No.":=LineNo;
            GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
            GenJournalLine."Account No.":=Vendor."Rent Account";
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Document No.":=docNo;
            GenJournalLine."External Document No.":=docNo;
            GenJournalLine."Posting Date":=Today;
            GenJournalLine.Description:=' Rent from ' + PaybillTrans."Account No"+ '-' + PaybillTrans."Account Name";
            GenJournalLine.Amount:=-1*Amount;
            GenJournalLine.Validate(GenJournalLine.Amount);
            if GenJournalLine.Amount<>0 then
            GenJournalLine.Insert;

            //Dr Customer Rent collection charge Charge amount
            LineNo:=LineNo+10000;
            GenJournalLine.Init;
            GenJournalLine."Journal Template Name":='GENERAL';
            GenJournalLine."Journal Batch Name":=batch;
            GenJournalLine."Line No.":=LineNo;
            GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
            GenJournalLine."Account No.":=Vendor."Rent Account";
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Document No.":=docNo;
            GenJournalLine."External Document No.":=docNo;
            GenJournalLine."Posting Date":=Today;
            GenJournalLine.Description:='Rent Collection Commission';
            GenJournalLine.Amount:=(RentCollectionCharge);
            GenJournalLine.Validate(GenJournalLine.Amount);
            if GenJournalLine.Amount<>0 then
            GenJournalLine.Insert;

            //CR Rent collection commission a/c
            LineNo:=LineNo+10000;
            GenJournalLine.Init;
            GenJournalLine."Journal Template Name":='GENERAL';
            GenJournalLine."Journal Batch Name":=batch;
            GenJournalLine."Line No.":=LineNo;
            GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
            GenJournalLine."Account No.":=RentCollectionCommACC;
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Document No.":=docNo;
            GenJournalLine."Source No.":=Vendor."No.";
            GenJournalLine."External Document No.":=docNo;
            GenJournalLine."Posting Date":=Today;
            GenJournalLine.Description:='Rent Collection Commission';
            GenJournalLine.Amount:=-RentCollectionCharge;
            GenJournalLine.Validate(GenJournalLine.Amount);
            if GenJournalLine.Amount<>0 then
            GenJournalLine.Insert;

            //cr excise duty
            LineNo:=LineNo+10000;
            GenJournalLine.Init;
            GenJournalLine."Journal Template Name":='GENERAL';
            GenJournalLine."Journal Batch Name":=batch;
            GenJournalLine."Line No.":=LineNo;
            GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
            GenJournalLine."Account No.":=Vendor."Rent Account";
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Document No.":=docNo;
            GenJournalLine."External Document No.":=docNo;
            GenJournalLine."Posting Date":=Today;
            GenJournalLine.Description:='Excise duty';
            GenJournalLine.Amount:=ExcDuty;
            GenJournalLine.Validate(GenJournalLine.Amount);
            if GenJournalLine.Amount<>0 then
            GenJournalLine.Insert;

            LineNo:=LineNo+10000;
            GenJournalLine.Init;
            GenJournalLine."Journal Template Name":='GENERAL';
            GenJournalLine."Journal Batch Name":=batch;
            GenJournalLine."Line No.":=LineNo;
            GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
            GenJournalLine."Account No.":=Format(ExxcDuty);
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Document No.":=docNo;
            GenJournalLine."External Document No.":=docNo;
            GenJournalLine."Posting Date":=Today;
            GenJournalLine.Description:='Excise duty';
            GenJournalLine.Amount:=ExcDuty*-1;
            GenJournalLine.Validate(GenJournalLine.Amount);
            if GenJournalLine.Amount<>0 then
            GenJournalLine.Insert;

          end;//Vendor
          //  END;//Member

          //Post
          GenJournalLine.Reset;
          GenJournalLine.SetRange("Journal Template Name",'GENERAL');
          GenJournalLine.SetRange("Journal Batch Name",batch);
          if GenJournalLine.Find('-') then begin
            repeat
              GLPosting.Run(GenJournalLine);
            until GenJournalLine.Next = 0;

            PaybillTrans.Posted:=true;
            PaybillTrans."Needs Manual Posting":=false;
            PaybillTrans."Date Posted":=Today;
            PaybillTrans."Time Posted":=Time;
            //PaybillTrans.Description:='Posted';
            PaybillTrans.Modify;
            res:='TRUE';

            msg:='Dear ' +Vendor.Name+' your acc: '+Vendor."No."+' has been credited with Ksh. '+ Format(Amount) +' Thank you for using Ilkisonko Sacco M-banking';
            SMSMessage('PAYBILLTRANS',Vendor."No.",Vendor."Mobile Phone No",msg);

          end else begin

            PaybillTrans."Date Posted":=Today;
            PaybillTrans."Needs Manual Posting":=true;
            //PaybillTrans.Description:='Failed';
            PaybillTrans.Modify;
            res:='FALSE';

            msg:='Dear ' +Vendor.Name+' your deposit of Ksh. '+ Format(Amount) +' has been received but not credited to your account';
            SMSMessage('PAYBILLTRANS',Vendor."No.",Vendor."Mobile Phone No",msg);

          end;

    end;

    local procedure PayBillToAcc(batch: Code[50];docNo: Code[50];accNo: Code[50];memberNo: Code[50];Amount: Decimal;accountType: Code[30];paybillno: Code[20]) res: Code[10]
    begin

          GenLedgerSetup.Reset;
          GenLedgerSetup.Get;
          //Gensetup.RESET;
          //Gensetup.GET;
          GenLedgerSetup.TestField(GenLedgerSetup."CloudPESA Comm Acc");
          GenLedgerSetup.TestField(GenLedgerSetup."PayBill Settl Acc");
          GenLedgerSetup.TestField(GenLedgerSetup."CloudPESA Charge");
          // Gensetup.TESTFIELD(Gensetup);

          if paybillno ='323730' then begin
            PaybillRecon:=GenLedgerSetup."PayBill Settl Acc";
          end else begin
            PaybillRecon:=GenLedgerSetup."PayBill Settl Acc 2";
          end;

          CloudPESACharge:=0;  //GetCharge(Amount,'PAYBILL');
          CloudPESACommACC:=GenLedgerSetup."CloudPESA Comm Acc";


          GenJournalLine.Reset;
          GenJournalLine.SetRange("Journal Template Name",'GENERAL');
          GenJournalLine.SetRange("Journal Batch Name",batch);
          GenJournalLine.DeleteAll;
          //end of deletion

          GenBatches.Reset;
          GenBatches.SetRange(GenBatches."Journal Template Name",'GENERAL');
          GenBatches.SetRange(GenBatches.Name,batch);


          if GenBatches.Find('-') = false then begin
            GenBatches.Init;
            GenBatches."Journal Template Name":='GENERAL';
            GenBatches.Name:=batch;
            GenBatches.Description:='Paybill Deposit';
            GenBatches.Validate(GenBatches."Journal Template Name");
            GenBatches.Validate(GenBatches.Name);
            GenBatches.Insert;
          end;//General Jnr Batches


          Vendor.Reset;
          Vendor.SetRange(Vendor."No.", accNo);
          //   Vendor.SETRANGE(Vendor."Account Type", accountType);
          if Vendor.Find('-') then begin

            //Dr MPESA PAybill ACC
            LineNo:=LineNo+10000;
            GenJournalLine.Init;
            GenJournalLine."Journal Template Name":='GENERAL';
            GenJournalLine."Journal Batch Name":=batch;
            GenJournalLine."Line No.":=LineNo;
            GenJournalLine."Account Type":=GenJournalLine."account type"::"Bank Account";
            GenJournalLine."Account No.":=PaybillRecon;
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Source No.":=Vendor."No.";
            GenJournalLine."Document No.":=docNo;
            GenJournalLine."External Document No.":=docNo;
            GenJournalLine."Posting Date":=Today;
            GenJournalLine.Description:='Paybill from ' + PaybillTrans.Telephone+ '-' + PaybillTrans."Account Name";;
            GenJournalLine.Amount:=Amount;
            GenJournalLine.Validate(GenJournalLine.Amount);
            if GenJournalLine.Amount<>0 then
            GenJournalLine.Insert;

            //Cr Customer
            LineNo:=LineNo+10000;
            GenJournalLine.Init;
            GenJournalLine."Journal Template Name":='GENERAL';
            GenJournalLine."Journal Batch Name":=batch;
            GenJournalLine."Line No.":=LineNo;
            GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
            GenJournalLine."Account No.":=Vendor."No.";
            GenJournalLine.Validate(GenJournalLine."Account No.");
            GenJournalLine."Document No.":=docNo;
            GenJournalLine."External Document No.":=docNo;
            GenJournalLine."Posting Date":=Today;
            GenJournalLine.Description:='Paybill from ' + PaybillTrans.Telephone+ '-' + PaybillTrans."Account Name";
            GenJournalLine.Amount:=-1*Amount;
            GenJournalLine.Validate(GenJournalLine.Amount);
            if GenJournalLine.Amount<>0 then
            GenJournalLine.Insert;

          end;//Vendor
          //  END;//Member

          //Post
          GenJournalLine.Reset;
          GenJournalLine.SetRange("Journal Template Name",'GENERAL');
          GenJournalLine.SetRange("Journal Batch Name",batch);
          if GenJournalLine.Find('-') then begin
            repeat
              GLPosting.Run(GenJournalLine);
            until GenJournalLine.Next = 0;
            PaybillTrans.Posted:=true;
            PaybillTrans."Date Posted":=Today;
            PaybillTrans."Time Posted":=Time;
            //PaybillTrans.Description:='Posted';
            PaybillTrans.Modify;
            res:='TRUE';

            msg:='Dear ' +Vendor.Name+' your acc: '+Vendor."No."+' has been credited with Ksh. '+ Format(Amount) +' Thank you for using Ilkisonko Sacco M-banking';
            SMSMessage('PAYBILLTRANS',Vendor."No.",Vendor."Mobile Phone No",msg);

          end else begin
            PaybillTrans."Date Posted":=Today;
            PaybillTrans."Needs Manual Posting":=true;
            //PaybillTrans.Description:='Failed';
            PaybillTrans.Modify;
            res:='FALSE';

            msg:='Dear ' +Vendor.Name+' your deposit of Ksh. '+ Format(Amount) +' has been received but not credited to your account';
            SMSMessage('PAYBILLTRANS',Vendor."No.",Vendor."Mobile Phone No",msg);

          end;

    end;

    local procedure PayBillToBOSA(batch: Code[50];docNo: Code[50];accNo: Code[50];memberNo: Code[50];amount: Decimal;type: Code[30];descr: Text[100];paybillno: Code[20]) res: Code[10]
    begin

          if PaybillTrans."Key Word" in ['DEP','SHA','FOS','REG'] then begin

            GenLedgerSetup.Reset;
            GenLedgerSetup.Get;

            //Gensetup.RESET;
            //Gensetup.GET;
            GenLedgerSetup.TestField(GenLedgerSetup."CloudPESA Comm Acc");
            GenLedgerSetup.TestField(GenLedgerSetup."PayBill Settl Acc");
            GenLedgerSetup.TestField(GenLedgerSetup."CloudPESA Charge");
            // Gensetup.TESTFIELD(Gensetup);

            if paybillno ='323730' then begin
              PaybillRecon:=GenLedgerSetup."PayBill Settl Acc";
            end else begin
              PaybillRecon:=GenLedgerSetup."PayBill Settl Acc 2";
            end;

            CloudPESACharge:=0; //GetCharge(amount,'PAYBILL');
            CloudPESACommACC:=GenLedgerSetup."CloudPESA Comm Acc";
            ChargeAmount:=0;


            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name",'GENERAL');
            GenJournalLine.SetRange("Journal Batch Name",batch);
            GenJournalLine.DeleteAll;
            //end of deletion

            GenBatches.Reset;
            GenBatches.SetRange(GenBatches."Journal Template Name",'GENERAL');
            GenBatches.SetRange(GenBatches.Name,batch);
            if GenBatches.Find('-') = false then begin
              GenBatches.Init;
              GenBatches."Journal Template Name":='GENERAL';
              GenBatches.Name:=batch;
              GenBatches.Description:='Paybill Deposit';
              GenBatches.Validate(GenBatches."Journal Template Name");
              GenBatches.Validate(GenBatches.Name);
              GenBatches.Insert;
            end;//General Jnr Batches

            Members.Reset;
            Members.SetRange(Members."No.",fngetmemberNo(PaybillTrans."Account No"));
            if Members.Find('-') then begin
            // Vendor.RESET;
            // Vendor.SETRANGE(Vendor."BOSA Account No", accNo);
            // Vendor.SETRANGE(Vendor."Account Type", fosaConst);
            //   IF Vendor.FINDFIRST THEN BEGIN

              //Dr MPESA PAybill ACC
              LineNo:=LineNo+10000;
              GenJournalLine.Init;
              GenJournalLine."Journal Template Name":='GENERAL';
              GenJournalLine."Journal Batch Name":=batch;
              GenJournalLine."Line No.":=LineNo;
              GenJournalLine."Account Type":=GenJournalLine."account type"::"Bank Account";
              GenJournalLine."Account No.":=PaybillRecon;
              GenJournalLine.Validate(GenJournalLine."Account No.");
              GenJournalLine."Document No.":=docNo;
              GenJournalLine."External Document No.":=docNo;
              GenJournalLine."Source No.":=Members."No.";
              GenJournalLine."Posting Date":=Today;
              GenJournalLine.Description:='Paybill from ' + PaybillTrans.Telephone+ '-' + PaybillTrans."Account Name";;
              GenJournalLine.Amount:=amount;
              GenJournalLine.Validate(GenJournalLine.Amount);
              if GenJournalLine.Amount<>0 then
              GenJournalLine.Insert;

              //Cr Customer
              LineNo:=LineNo+10000;
              GenJournalLine.Init;
              GenJournalLine."Journal Template Name":='GENERAL';
              GenJournalLine."Journal Batch Name":=batch;
              GenJournalLine."Line No.":=LineNo;
              GenJournalLine."Account Type":=GenJournalLine."account type"::Member;
              GenJournalLine."Account No.":=Members."No.";
              GenJournalLine.Validate(GenJournalLine."Account No.");
              GenJournalLine."Document No.":=docNo;
              GenJournalLine."External Document No.":=docNo;
              GenJournalLine."Posting Date":=Today;
              case PaybillTrans."Key Word" of
                'DEP': GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Deposit Contribution";// memberaccount:= "Normal Shares";
                'SHA': GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Share Capital";       // bosaNo:="FosaShares";
                'REG': GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Registration Fee";    // bosaNo:='Unllocated Funds';
                'FOS': GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Loan Insurance Paid"; // bosaNo:='Unllocated Funds';
              end;
              GenJournalLine."Shortcut Dimension 1 Code":='BOSA';
              GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
              GenJournalLine.Description:='Paybill from ' + PaybillTrans.Telephone+ '-' + PaybillTrans."Account Name";;
              GenJournalLine.Amount:=(amount)*-1;
              GenJournalLine.Validate(GenJournalLine.Amount);
              if GenJournalLine.Amount<>0 then
              GenJournalLine.Insert;

            //  END;//Vendor
            end;//Member


            //Post
            GenJournalLine.Reset;
            GenJournalLine.SetRange("Journal Template Name",'GENERAL');
            GenJournalLine.SetRange("Journal Batch Name",batch);
            if GenJournalLine.Find('-') then begin
              repeat
                GLPosting.Run(GenJournalLine);
              until GenJournalLine.Next = 0;

              PaybillTrans.Posted:=true;
              PaybillTrans."Time Posted":=Time;
              PaybillTrans."Date Posted":=Today;
              //paybilltrans.description:='posted';
              PaybillTrans.Modify;
              res:='true';

              msg:='dear ' +Members.Name+', your acc: '+PaybillTrans."Account No"+' has been credited with ksh '+ Format(amount) +' thank you for using ilkisonko sacco m-banking';
              SMSMessage('PAYBILLTRANS',Vendor."No.",Members."Phone No.",msg);

            end else begin

              msg:='Dear ' +Members.Name+', we have received Ksh. '+ Format(amount) +'but has not been credited to your account, Thank you fo using Ilkisonko Sacco M-banking';
              SMSMessage('PAYBILLTRANS',Vendor."No.",Members."Phone No.",msg);

              PaybillTrans."Date Posted":=Today;
              PaybillTrans."Needs Manual Posting":=true;
              //PaybillTrans.Description:='Failed';
              PaybillTrans.Modify;
              res:='FALSE';

            end;
          end;
        //END;
    end;

    local procedure PayBillToLoan(batch: Code[50];docNo: Code[50];accNo: Code[50];memberNo: Code[50];amount: Decimal;type: Code[30];paybillno: Code[20]) res: Code[10]
    begin
          GenLedgerSetup.Reset;
          GenLedgerSetup.Get;
          GenLedgerSetup.TestField(GenLedgerSetup."CloudPESA Comm Acc");
          GenLedgerSetup.TestField(GenLedgerSetup."PayBill Settl Acc");
          GenLedgerSetup.TestField(GenLedgerSetup."CloudPESA Charge");

          CloudPESACommACC:=  GenLedgerSetup."CloudPESA Comm Acc";
          CloudPESACharge:=0; //GetCharge(amount,'PAYBILL');

           if paybillno ='323730' then begin
                      PaybillRecon:=GenLedgerSetup."PayBill Settl Acc";
                end else begin
                     PaybillRecon:=GenLedgerSetup."PayBill Settl Acc 2";
               end;

          ExcDuty:=(20/100)*CloudPESACharge;

          GenJournalLine.Reset;
          GenJournalLine.SetRange("Journal Template Name",'GENERAL');
          GenJournalLine.SetRange("Journal Batch Name",batch);
          GenJournalLine.DeleteAll;
          //end of deletion

          GenBatches.Reset;
          GenBatches.SetRange(GenBatches."Journal Template Name",'GENERAL');
          GenBatches.SetRange(GenBatches.Name,batch);

          if GenBatches.Find('-') = false then begin
            GenBatches.Init;
            GenBatches."Journal Template Name":='GENERAL';
            GenBatches.Name:=batch;
            GenBatches.Description:='Paybill Loan Repayment';
            GenBatches.Validate(GenBatches."Journal Template Name");
            GenBatches.Validate(GenBatches.Name);
            GenBatches.Insert;
          end;//General Jnr Batches

           // Members.RESET;
            //Members.SETRANGE(Members."No.", accNo);
            //IF Members.FIND('-') THEN BEGIN
            //Vendor.RESET;
            //Vendor.SETRANGE(Vendor."BOSA Account No", accNo);
          //  Vendor.SETRANGE(Vendor."Account Type", fosaConst);
             // IF Vendor.FINDFIRST THEN BEGIN

                LoansRegister.Reset;
                //LoansRegister.SETRANGE(LoansRegister."Loan Product Type",type);
               // LoansRegister.SETRANGE(LoansRegister."Client Code",memberNo);

              LoansRegister.SetRange(LoansRegister."Loan  No.",accNo);

                if LoansRegister.Find('+') then begin
                LoansRegister.CalcFields(LoansRegister."Outstanding Balance",LoansRegister."Oustanding Interest");
               if LoansRegister."Outstanding Balance" >0 then begin

              //Dr MPESA PAybill ACC
                LineNo:=LineNo+10000;
                GenJournalLine.Init;
                GenJournalLine."Journal Template Name":='GENERAL';
                GenJournalLine."Journal Batch Name":=batch;
                GenJournalLine."Line No.":=LineNo;
                GenJournalLine."Account Type":=GenJournalLine."account type"::"Bank Account";
                GenJournalLine."Account No.":=PaybillRecon;
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Document No.":=docNo;
                GenJournalLine."External Document No.":=docNo;

                 GenJournalLine."Source No.":=Vendor."No.";
                GenJournalLine."Posting Date":=Today;
                //GenJournalLine.Description:='Paybill Loan Repayment';
                GenJournalLine.Description:='Paybill Loan Repayment' + PaybillTrans.Telephone+ '-' + PaybillTrans."Account Name";;
                GenJournalLine.Amount:=amount;
                GenJournalLine.Validate(GenJournalLine.Amount);
                if GenJournalLine.Amount<>0 then
                GenJournalLine.Insert;

                if LoansRegister."Oustanding Interest">0 then begin
                LineNo:=LineNo+10000;

                GenJournalLine.Init;
                GenJournalLine."Journal Template Name":='GENERAL';
                GenJournalLine."Journal Batch Name":=batch;
                GenJournalLine."Line No.":=LineNo;
                GenJournalLine."Account Type":=GenJournalLine."account type"::Member;
                GenJournalLine."Account No.":=LoansRegister."Client Code";
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Document No.":=docNo;
                GenJournalLine."External Document No.":=docNo;
                GenJournalLine."Posting Date":=Today;
                GenJournalLine.Description:='Loan Interest Payment';


                if amount > LoansRegister."Oustanding Interest" then
                GenJournalLine.Amount:=-LoansRegister."Oustanding Interest"
                else
                GenJournalLine.Amount:=-amount;
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Interest Paid";

                if GenJournalLine."Shortcut Dimension 1 Code" = '' then begin
                GenJournalLine."Shortcut Dimension 1 Code":=Members."Global Dimension 1 Code";
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                end;
                GenJournalLine."Loan No":=LoansRegister."Loan  No.";
                if GenJournalLine.Amount<>0 then
                GenJournalLine.Insert;

                amount:=amount+GenJournalLine.Amount;
                end;

                if amount>0 then begin
                LineNo:=LineNo+10000;

                GenJournalLine.Init;
                GenJournalLine."Journal Template Name":='GENERAL';
                GenJournalLine."Journal Batch Name":=batch;
                GenJournalLine."Line No.":=LineNo;
                GenJournalLine."Account Type":=GenJournalLine."account type"::Member;
                GenJournalLine."Account No.":=LoansRegister."Client Code";
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Document No.":=docNo;
                GenJournalLine."External Document No.":='';
                GenJournalLine."Posting Date":=Today;
                GenJournalLine.Description:='Paybill Loan Repayment';
                GenJournalLine.Amount:=-amount;
                GenJournalLine.Validate(GenJournalLine.Amount);
                GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Loan Repayment";
                if GenJournalLine."Shortcut Dimension 1 Code" = '' then begin
                GenJournalLine."Shortcut Dimension 1 Code":=Members."Global Dimension 1 Code";
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                end;
                GenJournalLine."Loan No":=LoansRegister."Loan  No.";
                if GenJournalLine.Amount<>0 then
                GenJournalLine.Insert;
                end;

                //DR Cust Acc
                LineNo:=LineNo+10000;
                GenJournalLine.Init;
                GenJournalLine."Journal Template Name":='GENERAL';
                GenJournalLine."Journal Batch Name":=batch;
                GenJournalLine."Line No.":=LineNo;
                GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                GenJournalLine."Account No.":=Vendor."No.";
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Document No.":=docNo;
                GenJournalLine."External Document No.":=docNo;
                GenJournalLine."Posting Date":=Today;
                GenJournalLine.Description:='Paybill Loan Repayment Charges';
                GenJournalLine.Amount:=CloudPESACharge+ExcDuty;
                GenJournalLine.Validate(GenJournalLine.Amount);
                if GenJournalLine.Amount<>0 then
                GenJournalLine.Insert;

                //CR Excise Duty
                LineNo:=LineNo+10000;
                GenJournalLine.Init;
                GenJournalLine."Journal Template Name":='GENERAL';
                GenJournalLine."Journal Batch Name":=batch;
                GenJournalLine."Line No.":=LineNo;
                GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                GenJournalLine."Account No.":=Format(ExxcDuty);
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Document No.":=docNo;
                GenJournalLine."External Document No.":=docNo;
                GenJournalLine."Posting Date":=Today;
                GenJournalLine.Description:='Excise duty-'+'Paybill Loan Repayment';
                GenJournalLine.Amount:=ExcDuty*-1;
                GenJournalLine.Validate(GenJournalLine.Amount);
                if GenJournalLine.Amount<>0 then
                GenJournalLine.Insert;

                //CR Surestep Acc
                LineNo:=LineNo+10000;
                GenJournalLine.Init;
                GenJournalLine."Journal Template Name":='GENERAL';
                GenJournalLine."Journal Batch Name":=batch;
                GenJournalLine."Line No.":=LineNo;
                GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                GenJournalLine."Account No.":=CloudPESACommACC;
                GenJournalLine.Validate(GenJournalLine."Account No.");
                GenJournalLine."Document No.":=docNo;
                GenJournalLine."External Document No.":=docNo;
                GenJournalLine."Posting Date":=Today;
                GenJournalLine.Description:='Paybill Loan Repayment'+' Charges';
                GenJournalLine.Amount:=-CloudPESACharge;
                GenJournalLine.Validate(GenJournalLine.Amount);
                if GenJournalLine.Amount<>0 then
                GenJournalLine.Insert;
                    end//Outstanding Balance
                   end;//Loan Register
                // END;//Vendor
               // END;//Member

                //Post
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name",'GENERAL');
                GenJournalLine.SetRange("Journal Batch Name",batch);
                if GenJournalLine.Find('-') then begin
                repeat
                  GLPosting.Run(GenJournalLine);
                until GenJournalLine.Next = 0;
                msg:='Dear ' +Members.Name+' your acc: '+Members."No."+' has been credited with Ksh '+ Format(amount) +' Thank you for using ILKISONKO Sacco Mobile';
                    SMSMessage('PAYBILLTRANS',Vendor."No.",Members."Phone No.",msg);

                  PaybillTrans.Posted:=true;
                  PaybillTrans."Date Posted":=Today;
        //          PaybillTrans.Description:='Posted';
                   PaybillTrans."Time Posted":=Time;
                  PaybillTrans.Modify;
                  res:='TRUE';
                end
                else begin
                  PaybillTrans."Date Posted":=Today;
                  PaybillTrans."Needs Manual Posting":=true;
        //          PaybillTrans.Description:='Failed';
                  PaybillTrans.Modify;
                  res:='FALSE';
                end;
    end;


    procedure LoanRepaymentSchedule(Productname: Text[50]) Schedule: Text[1024]
    var
        loanschedule: Text[250];
    begin
    end;


    procedure Guaranteefreeshares(phone: Text[500]) shares: Text[500]
    begin
        begin
        GenSetup.Get();
        FreeShares:=0;
        glamount:=0;
          Members.Reset;
          Members.SetRange(Members."Phone No.",phone);
          if Members.Find('-') then begin
            Members.CalcFields("Current Shares");
            LoanGuard.Reset;
            LoanGuard.SetRange(LoanGuard."Member No",Members."No.");
           // LoanGuard.SETRANGE(LoanGuard.Substituted,FALSE);
              if LoanGuard.Find('-') then begin
                repeat
                    glamount:=glamount+LoanGuard."Amont Guaranteed";
                   Message('Member No %1 Account no %2',Members."No.",glamount);
                    until LoanGuard.Next =0;
              end;
              FreeShares:=(Members."Current Shares"*GenSetup."Guarantors Multiplier")-glamount;
              shares:= Format(FreeShares,0,'<Precision,2:2><Integer><Decimals>');
          end;
          end;
    end;


    procedure Loancalculator(var calDetails: BigText;calcSetup: Text) calcdetails: Code[1024]
    var
        varLoan: Text[1024];
        LoanProducttype: Record "Loan Products Setup";
    begin
        begin

        LoanProducttype.Reset;
            //LoanProducttype.GET();
        //LoanProducttype.SETRANGE(LoanProducttype.Source,1);
             if LoanProducttype.Find('-') then begin
                //  LoanProducttype.CALCFIELDS(LoanProducttype."Interest rate",LoanProducttype."Max. Loan Amount",LoanProducttype."Min. Loan Amount");

                  repeat

           calcSetup := calcSetup + '::::'+Format( LoanProducttype."Product Description") +':::' +Format(LoanProducttype."Interest rate") +':::' + Format(LoanProducttype."No of Installment")+':::' + Format(LoanProducttype."Max. Loan Amount");

                  until LoanProducttype.Next = 0;
                  //MESSAGE('Loan Balance %1',loanbalances);
                  calDetails.AddText(calcSetup);

              end;
         end;
    end;


    procedure OutstandingLoansUSSD(phone: Code[20]) loanbalances: Text[1024]
    begin
        begin
        loanbalances:='';
        Vendor.Reset;
              Vendor.SetRange(Vendor."Mobile Phone No",phone)   ;
              if Vendor.Find('-') then begin

                   LoansRegister.Reset;
                   LoansRegister.SetRange(LoansRegister."Client Code",Vendor."BOSA Account No");
                  if LoansRegister.Find('-') then begin
                  repeat
                    LoansRegister.CalcFields(LoansRegister."Outstanding Balance",LoansRegister."Oustanding Interest",LoansRegister."Interest to be paid",LoansRegister."Interest Paid");

                    if (LoansRegister."Outstanding Balance">0) then
                    loanbalances:= loanbalances + '::::' +LoansRegister."Loan  No." + ':::'+ LoansRegister."Loan Product Type" + ':::'+
                     Format(LoansRegister."Outstanding Balance")+':::'+ Format(LoansRegister."Oustanding Interest") ;
                  until LoansRegister.Next = 0;
                  end;
              end;
              if loanbalances='' then begin
                loanbalances:= loanbalances + '::::' +'no';
                end;

         end;
    end;


    procedure getMembernames(memberno: Code[30]) name: Text[1024]
    begin
        Members.Reset;
        Members.SetRange(Members."No.",memberno);//use member number and not account number
        if Members.Find('-') then begin

          name:=Members.Name+':::'+Members."FOSA Account No.";
          end;
    end;


    procedure AccountbalalanceREF(Acc: Code[30]) Bal: Text[1024]
    begin
        Vendor.Reset;
            Vendor.SetRange(Vendor."No.",Acc);
            if Vendor.Find('-') then begin
         AccountTypes.Reset;
                          AccountTypes.SetRange(AccountTypes.Code,Vendor."Account Type")  ;
                         // AccountTypes.SETFILTER(AccountTypes."Last Account No Used(HQ)",'=%1',FALSE); //Restrict withdrawal
                          if AccountTypes.Find('-') then
                          begin
                            miniBalance:=AccountTypes."Minimum Balance";
                          end;
                          Vendor.CalcFields(Vendor."Balance (LCY)");
                          Vendor.CalcFields(Vendor."ATM Transactions");
                          Vendor.CalcFields(Vendor."Uncleared Cheques");
                          Vendor.CalcFields(Vendor."EFT Transactions");
                          accBalance:=Vendor."Balance (LCY)"-(Vendor."ATM Transactions"+Vendor."Uncleared Cheques"+Vendor."EFT Transactions");
                          Bal:=Format(accBalance);
                          end;
    end;


    procedure CommisionEarned() AccBal: Text[1024]
    var
        amount: Decimal;
    begin
        GLEntries.Reset;
        GLEntries.SetRange("G/L Account No.",'20106');
        debitAmount:=0;
        amount:=0;
        if GLEntries.Find('-') then begin
        repeat
        amount:=amount+GLEntries."Credit Amount";
          debitAmount:=debitAmount+GLEntries."Debit Amount";
        until GLEntries.Next=0;

        AccBal:='::::'+Format(amount-debitAmount)+':::';
        end;
    end;


    procedure FundsTransferOTHER(accFrom: Text[20];accTo: Text[20];DocNumber: Text[30];amount: Decimal) result: Text[30]
    begin
        CloudPESATrans.Reset;
        CloudPESATrans.SetRange(CloudPESATrans."Document No", DocNumber);
        if CloudPESATrans.Find('-') then begin
          result:='REFEXISTS';
        end
        else begin
          GenLedgerSetup.Reset;
          GenLedgerSetup.Get;
          GenLedgerSetup.TestField(GenLedgerSetup."Mobile Charge");
          GenLedgerSetup.TestField(GenLedgerSetup."CloudPESA Comm Acc");
          GenLedgerSetup.TestField(GenLedgerSetup."CloudPESA Charge");

          Charges.Reset;
          Charges.SetRange(Charges.Code,GenLedgerSetup."Mobile Charge");
          if Charges.Find('-') then begin
            Charges.TestField(Charges."GL Account");
            MobileCharges:=0; //Charges."Charge Amount";
            MobileChargesACC:=Charges."GL Account";
          end;

            CloudPESACommACC:=  GenLedgerSetup."CloudPESA Comm Acc";
            CloudPESACharge:=GenLedgerSetup."CloudPESA Charge";

            ExcDuty:=(20/100)*(MobileCharges+CloudPESACharge);

          if amount>=100 then begin

            Vendor.Reset;
            Vendor.SetRange(Vendor."No.",accFrom);
            if Vendor.Find('-') then begin
              AccountTypes.Reset;
               // AccountTypes.SETRANGE(AccountTypes.Code,Vendor."Account Type")  ;
                //AccountTypes.SETRANGE(AccountTypes."Last Account No Used(HQ)",FALSE);
                if AccountTypes.Find('-') then
                begin
                  miniBalance:=AccountTypes."Minimum Balance";
                end;
                   Vendor.CalcFields(Vendor."Balance (LCY)");
                 TempBalance:=Vendor."Balance (LCY)"-(Vendor."ATM Transactions"+Vendor."Uncleared Cheques"+Vendor."EFT Transactions"+miniBalance);
                  accountName1:=Vendor.Name;

                 Vendor.Reset;
                 Vendor.SetRange(Vendor."No.",accTo);

            if Vendor.Find('-') then begin

                  if (TempBalance>amount+MobileCharges+CloudPESACharge) then begin
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name",'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name",'MOBILETRAN');
                        GenJournalLine.DeleteAll;
                        //end of deletion

                        GenBatches.Reset;
                        GenBatches.SetRange(GenBatches."Journal Template Name",'GENERAL');
                        GenBatches.SetRange(GenBatches.Name,'MOBILETRAN');

                        if GenBatches.Find('-') = false then begin
                        GenBatches.Init;
                        GenBatches."Journal Template Name":='GENERAL';
                        GenBatches.Name:='MOBILETRAN';
                        GenBatches.Description:='SUREPESA Tranfers';
                        GenBatches.Validate(GenBatches."Journal Template Name");
                        GenBatches.Validate(GenBatches.Name);
                        GenBatches.Insert;
                        end;

                //DR ACC 1
                        LineNo:=LineNo+10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='GENERAL';
                        GenJournalLine."Journal Batch Name":='MOBILETRAN';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No.":=accFrom;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No.":=DocNumber;
                        GenJournalLine."External Document No.":=accFrom;
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine.Description:='Mobile Transfer';
                        GenJournalLine.Amount:=amount;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;

                //Dr Transfer Charges
                        LineNo:=LineNo+10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='GENERAL';
                        GenJournalLine."Journal Batch Name":='MOBILETRAN';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No.":=accFrom;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No.":=DocNumber;
                        GenJournalLine."External Document No.":=accFrom;
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine.Description:='Mobile Transfer Charges';
                        GenJournalLine.Amount:=MobileCharges + CloudPESACharge ;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;


                //DR Excise Duty
                        LineNo:=LineNo+10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='GENERAL';
                        GenJournalLine."Journal Batch Name":='MOBILETRAN';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No.":=accFrom;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No.":=DocNumber;
                        GenJournalLine."External Document No.":=accFrom;
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine.Description:='Excise duty-Mobile Transfer';
                        GenJournalLine.Amount:=ExcDuty;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;

                        LineNo:=LineNo+10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='GENERAL';
                        GenJournalLine."Journal Batch Name":='MOBILETRAN';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Account No.":=ExxcDuty;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No.":=DocNumber;
                         GenJournalLine."Source No.":=accFrom;
                        GenJournalLine."External Document No.":=accFrom;
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine.Description:='Excise duty-Mobile Transfer';
                        GenJournalLine.Amount:=ExcDuty*-1;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;

                //CR Mobile Transactions Acc
                        LineNo:=LineNo+10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='GENERAL';
                        GenJournalLine."Journal Batch Name":='MOBILETRAN';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Account No.":=MobileChargesACC;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No.":=DocNumber;
                         GenJournalLine."Source No.":=accFrom;
                        GenJournalLine."External Document No.":=accFrom;
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine.Description:='Mobile Transfer Charges';
                        GenJournalLine.Amount:=MobileCharges*-1;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;

                //CR Commission
                        LineNo:=LineNo+10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='GENERAL';
                        GenJournalLine."Journal Batch Name":='MOBILETRAN';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Account No.":=CloudPESACommACC;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No.":=DocNumber;
                         GenJournalLine."Source No.":=accFrom;
                        GenJournalLine."External Document No.":=MobileChargesACC;
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine.Description:='Mobile Transfer Charges';
                        GenJournalLine.Amount:=-CloudPESACharge;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;

                //CR ACC2
                        LineNo:=LineNo+10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='GENERAL';
                        GenJournalLine."Journal Batch Name":='MOBILETRAN';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No.":=Vendor."No.";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No.":=DocNumber;
                        GenJournalLine."External Document No.":=Vendor."No.";
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine.Description:='Mobile Transfer from '+accFrom;
                        GenJournalLine.Amount:=-amount;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;

                        //Post
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name",'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name",'MOBILETRAN');
                        if GenJournalLine.Find('-') then begin
                        repeat
                        GLPosting.Run(GenJournalLine);
                        until GenJournalLine.Next = 0;
                        end;
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name",'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name",'MOBILETRAN');
                        GenJournalLine.DeleteAll;
                          msg:='You have transfered KES '+Format(amount)+' from Account '+accountName1+' to '+accountName2+
                            ' .Thank you for using ILKISONKO Sacco Mobile.';

                        CloudPESATrans.Init;
                        CloudPESATrans."Document No":=DocNumber;
                        CloudPESATrans.Description:='Mobile Transfer';
                        CloudPESATrans."Document Date":=Today;
                        CloudPESATrans."Account No" :=accFrom;
                        CloudPESATrans."Account No2" :=accTo;
                         CloudPESATrans.Charge:=TotalCharges;
                         CloudPESATrans."Account Name":=Vendor.Name;
                          CloudPESATrans."Telephone Number":=Vendor."Mobile Phone No";
                          CloudPESATrans."SMS Message":=msg;
                        CloudPESATrans.Amount:=amount;
                        CloudPESATrans.Posted:=true;
                         CloudPESATrans.Status:= CloudPESATrans.Status::Completed;
                        CloudPESATrans."Posting Date":=Today;
                         CloudPESATrans.Status:=CloudPESATrans.Status::Completed;
                        CloudPESATrans.Comments:='Success';
                        CloudPESATrans.Client:=Vendor."BOSA Account No";
                        CloudPESATrans."Transaction Type":=CloudPESATrans."transaction type"::"Transfer to Fosa";
                        CloudPESATrans."Transaction Time":=Time;
                        CloudPESATrans.Insert;
                        result:='TRUE';
                        accountName2:=Vendor.Name;



                            SMSMessage(DocNumber,accFrom,Vendor."Mobile Phone No",msg);
                     end
                     else begin
                     result:='INSUFFICIENT';
                             msg:='You have insufficient funds in your savings Account to use this service.'+
                            ' .Thank you for using ILKISONKO  Sacco Mobile.';
                            SMSMessage(DocNumber,accFrom,Vendor."Mobile Phone No",msg);
                     end;
                end
                else begin
                  result:='ACC2INEXISTENT';
                             msg:='Your request has failed because the recipent account does not exist.'+
                            ' .Thank you for using ILKISONKO  Sacco Mobile.';
                            SMSMessage(DocNumber,accFrom,Vendor."Mobile Phone No",msg);
                end;
            end
            else begin
              result:='ACCINEXISTENT';
                          result:='INSUFFICIENT';
                          msg:='Your request has failed because the recipent account does not exist.'+
                          ' .Thank you for using ILKISONKO  Sacco Mobile.';
                          SMSMessage(DocNumber,accFrom,Vendor."Mobile Phone No",msg);
            end;
            end
          else begin
            result:='LIMIT';

                          msg:='Your request has failed because the amount is below the limit required which is above 100'+
                          ' .Thank you for using ILKISONKO  Sacco Mobile.';
                          SMSMessage(DocNumber,accFrom,Vendor."Mobile Phone No",msg);
          end;
            end;
    end;


    procedure SharesUSSD(phone: Text[20];DocNo: Text[50]) shares: Text[1000]
    var
        sharecapital: Text[50];
        normalshares: Text[50];
        fosashares: Text[50];
        amount: Decimal;
    begin
        begin
                Vendor.Reset;
                Vendor.SetRange(Vendor."Mobile Phone No",phone);
                if Vendor.Find('-') then begin
                    MemberLedgerEntry.Reset;
                    MemberLedgerEntry.SetRange(MemberLedgerEntry."Customer No.",Vendor."BOSA Account No");
                    MemberLedgerEntry.SetRange(MemberLedgerEntry."Transaction Type",MemberLedgerEntry."transaction type"::"Share Capital");
                    if MemberLedgerEntry.Find('-') then begin
                      repeat
                          amount:=amount+MemberLedgerEntry.Amount;
                          sharecapital:= Format(amount,0,'<Precision,2:2><Integer><Decimals>');
                          until MemberLedgerEntry.Next =0;
                      end;

                    MemberLedgerEntry.Reset;
                    MemberLedgerEntry.SetRange(MemberLedgerEntry."Customer No.",Vendor."BOSA Account No");
                    MemberLedgerEntry.SetRange(MemberLedgerEntry."Transaction Type",MemberLedgerEntry."transaction type"::"Deposit Contribution");

                    if MemberLedgerEntry.Find('-') then begin
                      amount:=0;
                      repeat
                          amount:=amount+MemberLedgerEntry.Amount;
                          normalshares:= Format(amount,0,'<Precision,2:2><Integer><Decimals>');
                          until MemberLedgerEntry.Next =0;
                    end;

                    msg:='Share Capital - KSH '+sharecapital+' , Member Deposits - KSH '+normalshares;
                    SMSMessage('MOBILETRAN',Vendor."No.",Vendor."Mobile Phone No",msg);
                    shares:='TRUE';
                   //GenericCharges(phone,DocNo,'Shares Balance Request');
                  end;
            end;
    end;


    procedure postAirtime("Doc No": Code[100];Phone: Code[50];amount: Decimal) result: Code[50]
    begin
        CloudPESATrans.Reset;
        CloudPESATrans.SetRange(CloudPESATrans."Document No", "Doc No");
        if CloudPESATrans.Find('-') then begin
          result:='REFEXISTS';
        end
        else begin
        
          GenLedgerSetup.Reset;
          GenLedgerSetup.Get;
          GenLedgerSetup.TestField(GenLedgerSetup.AirTimeSettlAcc);
          airtimeAcc:=  GenLedgerSetup.AirTimeSettlAcc;
          end;
        
            Vendor.Reset;
            Vendor.SetRange(Vendor."No.", Phone);
           // Vendor.SETRANGE(Vendor."Account Type", 'SUPER');
            if Vendor.Find('-') then begin
             Vendor.CalcFields(Vendor."Balance (LCY)");
             Vendor.CalcFields(Vendor."ATM Transactions");
             Vendor.CalcFields(Vendor."Uncleared Cheques");
             Vendor.CalcFields(Vendor."EFT Transactions");
             Vendor.CalcFields(Vendor."Mobile Transactions");
             TempBalance:=Vendor."Balance (LCY)"-(Vendor."ATM Transactions"+Vendor."Uncleared Cheques"+Vendor."EFT Transactions"+Vendor."Mobile Transactions");
        
                 if (TempBalance>amount) then begin
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name",'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name",'AIRTIME');
                        GenJournalLine.DeleteAll;
                        //end of deletion
                        GenBatches.Reset;
                        GenBatches.SetRange(GenBatches."Journal Template Name",'GENERAL');
                        GenBatches.SetRange(GenBatches.Name,'AIRTIME');
        
                        if GenBatches.Find('-') = false then begin
                        GenBatches.Init;
                        GenBatches."Journal Template Name":='GENERAL';
                        GenBatches.Name:='AIRTIME';
                        GenBatches.Description:='AIRTIME Purchase';
                        GenBatches.Validate(GenBatches."Journal Template Name");
                        GenBatches.Validate(GenBatches.Name);
                        GenBatches.Insert;
                        end;
        
                //DR Customer Acc
                        LineNo:=LineNo+10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='GENERAL';
                        GenJournalLine."Journal Batch Name":='AIRTIME';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                        GenJournalLine."Bal. Account Type":=GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Account No.":=Vendor."No.";
                        GenJournalLine."Bal. Account No.":=airtimeAcc;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                        GenJournalLine."Document No.":="Doc No";
                        GenJournalLine."External Document No.":=Vendor."No.";
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine.Description:='AIRTIME Purchase';
                        GenJournalLine.Amount:=amount;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;
        
        
        
                        //Post
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name",'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name",'AIRTIME');
                        if GenJournalLine.Find('-') then begin
                        repeat
                        GLPosting.Run(GenJournalLine);
                        until GenJournalLine.Next = 0;
                        end;
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name",'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name",'AIRTIME');
                        GenJournalLine.DeleteAll;
                         msg:='You have purchased airtime worth KES '+Format(amount)+' from Account '+Vendor.Name+
                      ' thank you for using ILKISONKO Sacco Mobile.';
        
                        CloudPESATrans.Init;
                        CloudPESATrans."Document No":="Doc No";
                        CloudPESATrans.Description:='AIRTIME Purchase';
                        CloudPESATrans."Document Date":=Today;
                        CloudPESATrans."Account No" :=Vendor."No.";
                        CloudPESATrans."Account No2" :=Phone;
                         CloudPESATrans.Charge:=TotalCharges;
                         CloudPESATrans."Account Name":=Vendor.Name;
                          CloudPESATrans."Telephone Number":=Vendor."Mobile Phone No";
                          CloudPESATrans."SMS Message":=msg;
                        CloudPESATrans.Amount:=amount;
                        CloudPESATrans.Status:=CloudPESATrans.Status::Completed;
                        CloudPESATrans.Posted:=true;
                        CloudPESATrans."Posting Date":=Today;
                        CloudPESATrans.Comments:='Success';
                        CloudPESATrans.Client:=Vendor."BOSA Account No";
                        CloudPESATrans."Transaction Type":=CloudPESATrans."transaction type"::Airtime;
                        CloudPESATrans."Transaction Time":=Time;
                        CloudPESATrans.Insert;
                        result:='TRUE';
        
                        SMSMessage("Doc No",Vendor."No.",Vendor."Mobile Phone No",msg);
                     end
                     else begin
                     result:='INSUFFICIENT';
                            /* msg:='You have insufficient funds in your savings Account to use this service.'+
                            ' .Thank you for using ILKISONKO Sacco Mobile.';
                            SMSMessage(docNo,Vendor."No.",Vendor."Mobile Phone No",msg);*/
                              CloudPESATrans.Init;
                              CloudPESATrans."Document No":="Doc No";
                              CloudPESATrans.Description:='AIRTIME Purchase';
                              CloudPESATrans."Document Date":=Today;
                              CloudPESATrans."Account No" :=Vendor."No.";
                              CloudPESATrans."Account No2" :=Phone;
                                 CloudPESATrans.Charge:=TotalCharges;
                         CloudPESATrans."Account Name":=Vendor.Name;
                          CloudPESATrans."Telephone Number":=Vendor."Mobile Phone No";
                              CloudPESATrans.Amount:=amount;
                              CloudPESATrans.Status:=CloudPESATrans.Status::Failed;
                              CloudPESATrans.Posted:=false;
                              CloudPESATrans."Posting Date":=Today;
                              CloudPESATrans.Comments:='Failed,Insufficient Funds';
                              CloudPESATrans.Client:=Vendor."BOSA Account No";
                              CloudPESATrans."Transaction Type":=CloudPESATrans."transaction type"::Airtime;
                              CloudPESATrans."Transaction Time":=Time;
                              CloudPESATrans.Insert;
                     end;
               end
                else begin
                  result:='ACCINEXISTENT';
                              CloudPESATrans.Init;
                              CloudPESATrans."Document No":="Doc No";
                              CloudPESATrans.Description:='AIRTIME Purchase';
                              CloudPESATrans."Document Date":=Today;
                              CloudPESATrans."Account No" :='';
                              CloudPESATrans."Account No2" :=Phone;
                                 CloudPESATrans.Charge:=TotalCharges;
                         CloudPESATrans."Account Name":=Vendor.Name;
                          CloudPESATrans."Telephone Number":=Vendor."Mobile Phone No";
                              CloudPESATrans.Amount:=amount;
                              CloudPESATrans.Posted:=false;
                              CloudPESATrans."Posting Date":=Today;
                              CloudPESATrans.Comments:='Failed,Invalid Account';
                              CloudPESATrans.Client:='';
                              CloudPESATrans."Transaction Type":=CloudPESATrans."transaction type"::Airtime;
                              CloudPESATrans."Transaction Time":=Time;
                              CloudPESATrans.Insert;
                end;

    end;


    procedure AccountBalanceAirtime(Acc: Code[30];amt: Decimal) Bal: Decimal
    begin
          begin
          Vendor.Reset;
          Vendor.SetRange(Vendor."No.", Acc);
          if Vendor.Find('-') then
           begin
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
                Bal:=Vendor."Balance (LCY)"-(Vendor."ATM Transactions"+Vendor."Uncleared Cheques"+Vendor."EFT Transactions"+miniBalance);

                GenLedgerSetup.Reset;
                GenLedgerSetup.Get;
                GenLedgerSetup.TestField(GenLedgerSetup."Mobile Charge");
                //GenLedgerSetup.TESTFIELD(GenLedgerSetup."MPESA Reconciliation acc");
                GenLedgerSetup.TestField(GenLedgerSetup."CloudPESA Comm Acc");
                GenLedgerSetup.TestField(GenLedgerSetup."CloudPESA Charge");

                Charges.Reset;
                Charges.SetRange(Charges.Code,GenLedgerSetup."equity bank acc");
                if Charges.Find('-') then begin
                  Charges.TestField(Charges."GL Account");

                  MPESACharge:=GetCharge(amt,'MPESA');
                  CloudPESACharge:=GetCharge(amt,'VENDWD');
                  MobileCharges:=GetCharge(amt,'SACCOWD');

                 // ExcDuty:=(10/100)*(MobileCharges+CloudPESACharge);
                  TotalCharges:=0;//CloudPESACharge+MobileCharges+ExcDuty+MPESACharge;
                  end;
                  Bal:=Bal-TotalCharges;
           end
          end;
    end;


    procedure PollPendingSMS() MessageDetails: Text[1024]
    begin
         SMSMessages.Reset;
          SMSMessages.SetRange(SMSMessages."Sent To Server", SMSMessages."sent to server"::No);
          if SMSMessages.Find('-') then
            begin

              if (SMSMessages."Telephone No"='')or(SMSMessages."Telephone No"='+')or (SMSMessages."SMS Message"='') then
                begin

                  SMSMessages."Sent To Server":=SMSMessages."sent to server"::Failed;
                  SMSMessages."Entry No.":='FAILED';
                  SMSMessages.Modify;
                end

              else
              begin
                  MessageDetails:=SMSMessages."Telephone No"+':::'+SMSMessages."SMS Message"+':::'+Format(SMSMessages."Entry No");
              end;
         end;
    end;


    procedure ConfirmSent(TelephoneNo: Text[1024];Status: Integer) result: Text[1024]
    begin

          SMSMessages.Reset;
          SMSMessages.SetRange(SMSMessages."Sent To Server", SMSMessages."sent to server"::No);
          SMSMessages.SetRange(SMSMessages."Entry No", Status);
          if SMSMessages.Find('-') then begin

            if TelephoneNo='0' then begin
            SMSMessages."Sent To Server":=SMSMessages."sent to server"::Failed;
                 SMSMessages."Entry No.":='FAILED';
                 //SMSMessages."Bulk SMS Balance":=EVALUATE(SMSMessages."Bulk SMS Balance",TelephoneNo);
                 SMSMessages.Modify;
                 result:='TRUE';
            end
            else begin
            SMSMessages."Sent To Server":=SMSMessages."sent to server"::Yes;
                 SMSMessages."Entry No.":='SUCCESS';
                 SMSMessages.Modify;
                 result:='TRUE';
            end

            end
    end;


    procedure AdvanceEligibility1(account: Text[50]) amount: Decimal
    var
        StoDedAmount: Decimal;
        STO: Record "Standing Orders";
        FOSALoanRepayAmount: Decimal;
        CumulativeNet: Decimal;
        AdvSalaryBuffer: Record Vendor;
        LastSalaryDate: Date;
        FirstSalaryDate: Date;
        AvarageNetPay: Decimal;
        AdvQualificationAmount: Decimal;
        CumulativeNet2: Decimal;
        finalAmount: Decimal;
        interestAMT: Decimal;
        TCount: Decimal;
        Sal1: Decimal;
        Sal2: Decimal;
        RCount: Decimal;
        Vendor: Record Vendor;
        Salarybal: Decimal;
        interestRate: Decimal;
    begin
            Vendor.Reset;
            Vendor.SetRange(Vendor."No.",account);
            if Vendor.Find('-') then begin
        
            //*****Check  if Salary is processed through Sacco*******//
            if (Vendor."Salary Processing"=false) then begin
            amount:=1;
            end
            else begin
              //*****Get Member Default Status-BOSA*****//
            LoansRegister.Reset;
            LoansRegister.SetRange(LoansRegister."Account No",Vendor."No.");
            LoansRegister.SetRange(LoansRegister.Posted,true);
            if LoansRegister.Find('-') then begin
            repeat
              LoansRegister.CalcFields(LoansRegister."Outstanding Balance");
            if (LoansRegister."Outstanding Balance">0) then begin
        
            //Check if member has an outstanding Loan Advance
            if (LoansRegister."Loan Product Type" = 'MOBIADV') then
              amount:=2;
        
            //Check if member has defaulted Loans
              /*LoanArrearsBuffer.RESET;
              LoanArrearsBuffer.SETRANGE(LoanArrearsBuffer."Account No",Vendor."No.");
              IF LoanArrearsBuffer.FIND('-') THEN BEGIN
                amount:=3;
              END;
              */
        
              /*IF (LoansRegister."Loans Category"<>LoansRegister."Loans Category"::Perfoming) THEN
                IF (LoansRegister."Loans Category"<>LoansRegister."Loans Category"::Watch)  THEN BEGIN
                  amount:=3;
                END;*/
                end;
            until LoansRegister.Next=0;
            end;
            if amount<>2 then begin
              if amount<>3 then begin
            //IF Members."Current Shares"<10000 THEN
              //ERROR('20');
        
            //******Get Salary Deductable Amount
            //******Get Standing Order Amount
            StoDedAmount:=0;
        
            STO.Reset;
            STO.SetRange(STO."Source Account No.",Vendor."No.");
            STO.SetRange(STO."None Salary",false);
            if STO.Find('-') then begin
            repeat
            StoDedAmount:=StoDedAmount+STO.Amount;
            until STO.Next=0;
            end;
        
          //***Get FOSA Loan Deductions****//
            FOSALoanRepayAmount:=0;
            LoansRegister.Reset;
            LoansRegister.SetRange(LoansRegister."Account No",Vendor."No.");
            LoansRegister.SetRange(LoansRegister.Source,LoansRegister.Source::FOSA);
            LoansRegister.SetRange(LoansRegister.Posted,true);
           // LoansRegister.SETFILTER(LoansRegister."Loan Product Type",'<>%1','DIV ADV');
            if LoansRegister.Find('-')  then begin
            repeat
            LoansRegister.CalcFields(LoansRegister."Outstanding Balance");
            if LoansRegister."Outstanding Balance">0 then begin
            FOSALoanRepayAmount:=FOSALoanRepayAmount+(LoansRegister."Loan Principle Repayment"+LoansRegister."Loan Interest Repayment");
            end;
            until LoansRegister.Next=0;
            end;
        
        
                VendorLedgEntry.Reset;
                VendorLedgEntry.SetRange(VendorLedgEntry."Vendor No.",account);
                VendorLedgEntry.SetFilter(VendorLedgEntry.Reversed,'<>%1',true);
                VendorLedgEntry.SetRange(VendorLedgEntry.Description,'Salary Processing');
        
        
                 if (VendorLedgEntry.Find('-')) then begin
                    RCount:=VendorLedgEntry.Count;
                    TCount:=0;
                    Sal1:=0;
                    Sal2:=0;
                    if RCount> 1 then begin
                        repeat
                            VendorLedgEntry.CalcFields(VendorLedgEntry."Amount (LCY)");
        
                            TCount+=1;
                            if TCount = RCount-1 then
                                Sal1:=VendorLedgEntry."Amount (LCY)" *-1
                            else if TCount = RCount then
                                Sal2:=VendorLedgEntry."Amount (LCY)" *-1;
        
                        //MESSAGE(FORMAT(TCount)+'-' +FORMAT(RCount)+'\'+FORMAT(Vledger."Amount (LCY)")+'\Sal 1: %1\Sal 2: %2',Sal1,Sal2);
                        until VendorLedgEntry.Next=0;
        
                        if Sal1 < Sal2 then
                            Salarybal:=Sal1
                        else
                          Salarybal:=Sal2;
        
                        //ERROR(Vledger."Vendor No."+'\Sal 1: %1\Sal 2: %2',Sal1,Sal2);
                    end
                    else if RCount=1 then begin
                        VendorLedgEntry.CalcFields(VendorLedgEntry."Amount (LCY)");
                        Salarybal:=VendorLedgEntry."Amount (LCY)"*-1;
                        //ERROR(Vledger."Vendor No."+'\Salarybal %1',Salarybal);
                    end
                    else begin
                        Salarybal:=0;
                    end;
        
        
        
                 end;
        
                //***Get Avarege Net Pay
               /* CumulativeNet:=0;
                AdvSalaryBuffer.RESET;
                AdvSalaryBuffer.SETCURRENTKEY(AdvSalaryBuffer."Salary Processing Date");
                AdvSalaryBuffer.SETRANGE(AdvSalaryBuffer."Account No",Vendor."No.");
                IF AdvSalaryBuffer.FINDLAST THEN BEGIN
                LastSalaryDate:=AdvSalaryBuffer."Salary Processing Date";
                FirstSalaryDate:=CALCDATE('-61D',AdvSalaryBuffer."Salary Processing Date");
                IF AdvSalaryBuffer.FIND('-') THEN BEGIN
                REPEAT
                IF (AdvSalaryBuffer."Salary Processing Date">=FirstSalaryDate) AND (AdvSalaryBuffer."Salary Processing Date"<=LastSalaryDate) THEN BEGIN
                IF CumulativeNet=0 THEN BEGIN
                   CumulativeNet:=AdvSalaryBuffer.Amount;
                END
                ELSE BEGIN
                CumulativeNet2:=AdvSalaryBuffer.Amount;
                END
                END;
                UNTIL AdvSalaryBuffer.NEXT=0;
                 IF CumulativeNet<CumulativeNet2 THEN BEGIN
                          AvarageNetPay:=CumulativeNet;
                        END
                        ELSE BEGIN
                          AvarageNetPay:=CumulativeNet2;
                        END;
                    END;
                    END;
                    */
              LoanProductsSetup.Reset;
              LoanProductsSetup.SetRange(LoanProductsSetup.Code,'MOBIADV');
              if LoanProductsSetup.FindFirst() then begin
                interestRate:=LoanProductsSetup."Interest rate";
                //InterestAcc:=LoanProductsSetup."Loan Interest Account";
              end;
        
            AdvQualificationAmount:=Salarybal;
            amount:=AdvQualificationAmount-(FOSALoanRepayAmount+StoDedAmount);
            interestAMT:=(interestRate/100)*amount;
            amount:=amount-interestAMT;
        
         if amount<0 then begin
                amount:=4;
              end;
        
                if (amount>1000) and (amount<=40000)  then begin
                amount:=amount;
              end else begin
              amount:=4;
              end;
        
        //    IF  Members.GET(Vendor."BOSA Account No") THEN BEGIN
        //    Members.CALCFIELDS(Members."Current Shares");
        //      IF amount>Members."Current Shares" THEN BEGIN
        //        amount:=Members."Current Shares";
        //      END;
        //      IF amount<0 THEN BEGIN
        //        amount:=4;
        //      END;
        //
        //        IF amount>0000 THEN BEGIN
        //        amount:=30000;
        //      END;
        //    END;
            end;//End of Loan Default Check
            end;//End of Existing Adavance Loan Check
            end;//End of Salary Processing Check
          end;//End Vendor

    end;


    procedure PostAdvance1(docNo: Code[20];telephoneNo: Code[20];amount: Decimal;period: Decimal) result: Code[30]
    var
        LoanAcc: Code[30];
        InterestAcc: Code[30];
        InterestAmount: Decimal;
        AmountToCredit: Decimal;
        loanNo: Text[20];
        advSMS: Decimal;
        advFee: Decimal;
        advApp: Decimal;
        advSMSAcc: Code[20];
        advFEEAcc: Code[20];
        advAppAcc: Code[20];
        advSMSDesc: Text[100];
        advFeeDesc: Text[100];
        advAppDesc: Text[100];
        SurePESATrans: Record "CloudPESA Transactions";
        LoanProdCharges: Record "Loan Product Charges";
        SurePESACharge: Decimal;
        SurePESACommACC: Code[100];
        SaccoNoSeries: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        LoanRepSchedule: Record "Loan Repayment Schedule";
    begin
        SurePESATrans.Reset;
        SurePESATrans.SetRange(SurePESATrans."Document No", docNo);
        if SurePESATrans.Find('-') then begin
          result:='REFEXISTS';
        end
        else begin

          GenLedgerSetup.Reset;
          GenLedgerSetup.Get;
          GenLedgerSetup.TestField(GenLedgerSetup."CloudPESA Comm Acc");
          GenLedgerSetup.TestField(GenLedgerSetup."CloudPESA Charge");

          LoanProductsSetup.Reset;
          LoanProductsSetup.SetRange(LoanProductsSetup.Code,'MOBIADV');
          if LoanProductsSetup.FindFirst() then begin
            LoanAcc:=LoanProductsSetup."Loan Account";
            InterestAcc:=LoanProductsSetup."Loan Interest Account";
          end;

          LoanProdCharges.Reset;
          LoanProdCharges.SetRange(LoanProdCharges."Product Code",'MOBIADV');
          LoanProdCharges.SetRange(LoanProdCharges.Code,'LAPPLICATION');
          if LoanProdCharges.FindFirst() then begin
            advApp:=LoanProdCharges.Amount;
            advAppAcc:=LoanProdCharges."G/L Account";
            advAppDesc:=LoanProdCharges.Description;
          end;

          LoanProdCharges.Reset;
          LoanProdCharges.SetRange(LoanProdCharges."Product Code",'MOBIADV');
          LoanProdCharges.SetRange(LoanProdCharges.Code,'LOAN DISB SMS');
          if LoanProdCharges.FindFirst() then begin
            advSMS:=LoanProdCharges.Amount;
            advSMSAcc:=LoanProdCharges."G/L Account";
            advSMSDesc:=LoanProdCharges.Description;
          end;

          LoanProdCharges.Reset;
          LoanProdCharges.SetRange(LoanProdCharges."Product Code",'MOBIADV');
          LoanProdCharges.SetRange(LoanProdCharges.Code,'LAPPRAISAL');
          if LoanProdCharges.FindFirst() then begin
            advFee:=LoanProdCharges.Amount;
            advFEEAcc:=LoanProdCharges."G/L Account";
            advFeeDesc:=LoanProdCharges.Description;
          end;

            SurePESACharge:=GenLedgerSetup."CloudPESA Charge";
            SurePESACommACC:= GenLedgerSetup."CloudPESA Comm Acc";
            InterestAmount:=(20/100)*amount;
            AmountToCredit:=amount-(SurePESACharge+advApp+advFee+advSMS+InterestAmount);
            //ExcDuty:=(10/100)*(MobileCharges+SurePESACharge);

            Vendor.Reset;
            Vendor.SetRange(Vendor."Mobile Phone No" ,telephoneNo);
            Vendor.SetRange(Vendor."Account Type", 'ORDINARY');
            if Vendor.Find('-') then begin

             Members.Reset;
              Members.SetRange(Members."No.", Vendor."BOSA Account No");
              if Members.Find('-') then begin

              //*******Create Loan *********//
                  SaccoNoSeries.Get;
                  SaccoNoSeries.TestField(SaccoNoSeries."FOSA Loans Nos");
                  loanNo:=NoSeriesMgt.GetNextNo(SaccoNoSeries."FOSA Loans Nos",0D,true);

                    //END;
                  LoansRegister.Init;
                  LoansRegister."Approved Amount":=amount;
                  LoansRegister.Interest:=LoanProductsSetup."Interest rate";
                  LoansRegister."Instalment Period":=LoanProductsSetup."Instalment Period";
                  LoansRegister.Repayment:=amount+InterestAmount;
                  LoansRegister."Expected Date of Completion":=CalcDate('1M',Today);
                  LoansRegister.Posted:=true;
                 // LoansRegister."Shares Balance":=
                  Members.CalcFields(Members."Current Shares",Members."Outstanding Balance",
                  Members."Current Loan");
                  LoansRegister."Shares Balance":=Members."Current Shares";
                  LoansRegister."Net Payment to FOSA":=AmountToCredit;
                  LoansRegister.Savings:=Members."Current Shares";
                  LoansRegister."Interest Paid":=InterestAmount;
                  LoansRegister."Issued Date":=Today;
                  LoansRegister."Repayment Start Date":=Today;
                  LoansRegister.Source:=LoansRegister.Source::FOSA;
                  LoansRegister."Loan Disbursed Amount":=AmountToCredit;
                  LoansRegister."Current Interest Paid":=InterestAmount;
                  LoansRegister."Loan Disbursement Date":=Today;
                  LoansRegister."Client Code":=Members."No.";
                  LoansRegister."Client Name":=Members.Name;
                  LoansRegister."Outstanding Balance to Date":=amount;
                  LoansRegister."Existing Loan":=Members."Outstanding Balance";
                  //LoansRegister."Staff No":=Members."Payroll/Staff No";
                  LoansRegister.Gender:=Members.Gender;
                  LoansRegister."BOSA No":=Vendor."BOSA Account No";
                  LoansRegister."Branch Code":=Vendor."Global Dimension 2 Code";
                  LoansRegister."Requested Amount":=amount;
                  LoansRegister."ID NO":=Vendor."ID No.";
                  if LoansRegister."Branch Code" = '' then
                  LoansRegister."Branch Code":=Members."Global Dimension 2 Code";
                  LoansRegister."Loan  No.":=loanNo;
                  LoansRegister."No. Series":=SaccoNoSeries."FOSA Loans Nos";
                  LoansRegister."Doc No Used":=docNo;
                  LoansRegister."BOSA No":=Vendor."BOSA Account No";
                  LoansRegister."Loan Interest Repayment":=InterestAmount;
                  LoansRegister."Loan Principle Repayment":=amount;
                  LoansRegister."Loan Repayment":=amount+InterestAmount;
                  LoansRegister."ID NO":=Vendor."ID No.";
                  LoansRegister."Employer Code":=Vendor."Employer P/F";
                  //LoansRegister."Appraised By":=USERID;
                  //LoansRegister."Posted By":=USERID;
                  //LoansRegister."Discount Amount":=0;
                  LoansRegister."Interest Upfront Amount":=InterestAmount;
                  LoansRegister."Approval Status":=LoansRegister."approval status"::Approved;
                  LoansRegister."Account No":=Vendor."No.";
                  LoansRegister."Application Date":=Today;
                  LoansRegister."Loan Product Type":=LoanProductsSetup.Code;
                  LoansRegister."Loan Product Type Name":=LoanProductsSetup."Product Description";
                  LoansRegister.Installments:=1;
                  LoansRegister."Loan Amount":=amount;
                  LoansRegister.Posted:=true;
                  LoansRegister."Issued Date":=Today;
                  LoansRegister."Outstanding Balance":=0;//Update
                  LoansRegister."Repayment Frequency":=LoansRegister."repayment frequency"::Monthly;
                  LoansRegister."Recovery Mode":=LoansRegister."recovery mode"::MPESA;
                  LoansRegister."Mode of Disbursement":= LoansRegister."mode of disbursement"::"Bank Transfer";
                  LoansRegister.Insert(true);



             //**********Process Loan*******************//
             Vendor.CalcFields(Vendor."Balance (LCY)");
                  GenJournalLine.Reset;
                  GenJournalLine.SetRange("Journal Template Name",'GENERAL');
                  GenJournalLine.SetRange("Journal Batch Name",'MOBILELOAN');
                  GenJournalLine.DeleteAll;
                  //end of deletion

                  GenBatches.Reset;
                  GenBatches.SetRange(GenBatches."Journal Template Name",'GENERAL');
                  GenBatches.SetRange(GenBatches.Name,'MOBILELOAN');

                  if GenBatches.Find('-') = false then begin
                  GenBatches.Init;
                  GenBatches."Journal Template Name":='GENERAL';
                  GenBatches.Name:='MOBILELOAN';
                  GenBatches.Description:='Mobile Loan';
                  GenBatches.Validate(GenBatches."Journal Template Name");
                  GenBatches.Validate(GenBatches.Name);
                  GenBatches.Insert;
                  end;

                  //Post Loan
                  LoansRegister.Reset;
                  LoansRegister.SetRange(LoansRegister."Doc No Used",docNo);
                  if LoansRegister.Find('-') then begin

          //Dr Loan Acc
                  LineNo:=LineNo+10000;
                  GenJournalLine.Init;
                  GenJournalLine."Journal Template Name":='GENERAL';
                  GenJournalLine."Journal Batch Name":='MOBILELOAN';
                  GenJournalLine."Line No.":=LineNo;
                  GenJournalLine."Account Type":=GenJournalLine."account type"::Employee;
                  GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::Loan;
                  GenJournalLine."Loan No":=LoansRegister."Loan  No.";
                  GenJournalLine."Account No.":=Members."No.";
                  GenJournalLine.Validate(GenJournalLine."Account No.");
                  GenJournalLine."Document No.":=LoansRegister."Loan  No.";
                  GenJournalLine."Posting Date":=Today;
                  GenJournalLine.Description:='Mobile Loan Disbursment';
                  GenJournalLine.Amount:=amount;
                  GenJournalLine.Validate(GenJournalLine.Amount);
                  if GenJournalLine.Amount<>0 then
                  GenJournalLine.Insert;

          //Cr Fosa Acc
                  LineNo:=LineNo+10000;
                  GenJournalLine.Init;
                  GenJournalLine."Journal Template Name":='GENERAL';
                  GenJournalLine."Journal Batch Name":='MOBILELOAN';
                  GenJournalLine."Line No.":=LineNo;
                  GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                  GenJournalLine."Loan No":=LoansRegister."Loan  No.";
                  GenJournalLine."Account No.":=Vendor."No.";
                  GenJournalLine.Validate(GenJournalLine."Account No.");
                  GenJournalLine."Document No.":=LoansRegister."Loan  No.";
                  GenJournalLine."Posting Date":=Today;
                  GenJournalLine.Description:='Mobile Loan Disbursment';
                  GenJournalLine.Amount:=-amount;
                  GenJournalLine.Validate(GenJournalLine.Amount);
                  if GenJournalLine.Amount<>0 then
                  GenJournalLine.Insert;

         //Dr Fosa Acc with charges
                  LineNo:=LineNo+10000;
                  GenJournalLine.Init;
                  GenJournalLine."Journal Template Name":='GENERAL';
                  GenJournalLine."Journal Batch Name":='MOBILELOAN';
                  GenJournalLine."Line No.":=LineNo;
                  GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                  GenJournalLine."Loan No":=LoansRegister."Loan  No.";
                  GenJournalLine."Account No.":=Vendor."No.";
                  GenJournalLine.Validate(GenJournalLine."Account No.");
                  GenJournalLine."Document No.":=LoansRegister."Loan  No.";
                  GenJournalLine."Posting Date":=Today;
                  GenJournalLine.Description:='Mobile Loan Charge';
                  GenJournalLine.Amount:=TotalCharges;
                  GenJournalLine.Validate(GenJournalLine.Amount);
                  if GenJournalLine.Amount<>0 then
                  GenJournalLine.Insert;



                  //Interest charge
                  LineNo:=LineNo+10000;
                  GenJournalLine.Init;
                  GenJournalLine."Journal Template Name":='GENERAL';
                  GenJournalLine."Journal Batch Name":='MOBILELOAN';
                  GenJournalLine."Line No.":=LineNo;
                  GenJournalLine."Account Type":=GenJournalLine."account type"::Employee;
                  GenJournalLine."Account No.":=LoansRegister."Client Code";
                  GenJournalLine.Validate(GenJournalLine."Account No.");

                  GenJournalLine."Document No.":=LoansRegister."Loan  No.";;
                  GenJournalLine."External Document No.":='';
                  GenJournalLine."Posting Date":=Today;
                  GenJournalLine."Loan No":=LoansRegister."Loan  No.";
                  GenJournalLine.Description:='Loan ' +Format(GenJournalLine."transaction type"::"FOSA Account");
                  GenJournalLine.Amount:=InterestAmount;
                  GenJournalLine.Validate(GenJournalLine.Amount);
                  GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"FOSA Account";
                  if GenJournalLine."Shortcut Dimension 1 Code" = '' then begin
                  GenJournalLine."Shortcut Dimension 1 Code":=Members."Global Dimension 1 Code";
                  GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                  end;
                  GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"G/L Account";
                  GenJournalLine."Bal. Account No.":=InterestAcc;
                  GenJournalLine."Loan No":=LoansRegister."Loan  No.";
                  if GenJournalLine.Amount<>0 then
                  GenJournalLine.Insert;




                  //Post
                  GenJournalLine.Reset;
                  GenJournalLine.SetRange("Journal Template Name",'GENERAL');
                  GenJournalLine.SetRange("Journal Batch Name",'MOBILELOAN');
                  if GenJournalLine.Find('-') then begin
                  repeat
                  GLPosting.Run(GenJournalLine);
                  until GenJournalLine.Next = 0;
                  end;


                   msg:='Dear '+Vendor.Name+' your loan of KES '+Format(amount)+' has been processed. KES '+Format(amount)+' has been credited to ACC '+Vendor."Account Type"+
                 '. Your monthly repayment of KES '+Format(amount+InterestAmount)+' is due on '+Format(CalcDate('+1M',Today));

                  //***************Update Loan Status************//
                  LoansRegister."Loan Status":=LoansRegister."loan status"::Issued;
                  LoansRegister."Amount Disbursed":=amount;
                  LoansRegister.Posted:=true;
                 // LoansRegister."Discount Amount":=amount;
                  LoansRegister."Outstanding Balance":=amount;
                  LoansRegister.Modify;

            //Insert to Schedule***********//
            //LoanRepSchedule
                  LoanRepSchedule.Init;
                  LoanRepSchedule."Loan No.":=loanNo;
                  LoanRepSchedule."Member No.":=Vendor."BOSA Account No";
                  LoanRepSchedule."Loan Category":='MOBIADV';
                  LoanRepSchedule."Loan Amount":=AmountToCredit;
                  LoanRepSchedule."Monthly Repayment":=AmountToCredit;
                  LoanRepSchedule."Monthly Interest":=0;
                  LoanRepSchedule."Repayment Date":=Today;
                  LoanRepSchedule."Principal Repayment":=amount;
                  LoanRepSchedule."Instalment No":=1;
                  LoanRepSchedule."Loan Balance":=AmountToCredit;
                  LoanRepSchedule.Insert();

                  SurePESATrans.Init;
                  SurePESATrans."Document No":=docNo;
                  SurePESATrans.Description:='Mobile Advance';
                  SurePESATrans."Document Date":=Today;
                  SurePESATrans."Account No" :=Vendor."No.";
                  SurePESATrans."SMS Message":=msg;
           SurePESATrans.Charge:=TotalCharges;
                         SurePESATrans."Account Name":=Vendor.Name;
                          SurePESATrans."Telephone Number":=Vendor."Mobile Phone No";

                  SurePESATrans."Account No2" :='';
                  SurePESATrans.Amount:=amount;
                  SurePESATrans.Status:=SurePESATrans.Status::Completed;
                  SurePESATrans.Posted:=true;
                  SurePESATrans."Posting Date":=Today;
                  SurePESATrans.Comments:='Success';
                  SurePESATrans.Client:=Vendor."BOSA Account No";
                  SurePESATrans."Transaction Type":=SurePESATrans."transaction type"::"Loan Application";
                  SurePESATrans."Transaction Time":=Time;
                  SurePESATrans.Insert;
                  result:='TRUE';

                  SMSMessage(docNo,Vendor."No.",Vendor."Mobile Phone No",msg);
                  end;//Loans Register
                end
                end
          else begin
            result:='ACCINEXISTENT';
                  SurePESATrans.Init;
                  SurePESATrans."Document No":=docNo;
                  SurePESATrans.Description:='Mobile Advance';
                  SurePESATrans."Document Date":=Today;
                  SurePESATrans."Account No" :=Vendor."No.";
                  SurePESATrans."Account No2" :='';
                  SurePESATrans.Amount:=amount;
                  SurePESATrans.Status:=SurePESATrans.Status::Completed;
                  SurePESATrans.Posted:=true;
                  SurePESATrans."Posting Date":=Today;
                  SurePESATrans.Comments:='Failed.Invalid Account';
                  SurePESATrans.Client:=Vendor."BOSA Account No";
                  SurePESATrans."Transaction Type":=SurePESATrans."transaction type"::"Loan Application";
                  SurePESATrans."Transaction Time":=Time;
                  SurePESATrans.Insert;
          end;
          end;
    end;


    procedure MiniStatementAPP(Phone: Text[20];DocNumber: Text[20];var ministmtarr: BigText;ministmt: Text)
    var
        amount: Decimal;
    begin
        begin
        Clear(ministmtarr);
        CloudPESATrans.Reset;
        CloudPESATrans.SetRange(CloudPESATrans."Document No", DocNumber);
        if CloudPESATrans.Find('-') then begin
          ministmt:='REFEXISTS';
        end
        else begin
          ministmt :='';
          GenLedgerSetup.Reset;
          GenLedgerSetup.Get;
          GenLedgerSetup.TestField(GenLedgerSetup."Mobile Charge");
          GenLedgerSetup.TestField(GenLedgerSetup."CloudPESA Comm Acc");
          GenLedgerSetup.TestField(GenLedgerSetup."CloudPESA Charge");

           Charges.Reset;
          Charges.SetRange(Charges.Code,GenLedgerSetup."Mobile Charge");
          if Charges.Find('-') then begin
            Charges.TestField(Charges."GL Account");
            MobileChargesACC:=Charges."GL Account";
             MobileCharges:=0; //Charges."Charge Amount";
          end;

            CloudPESACommACC:=  GenLedgerSetup."CloudPESA Comm Acc";
             CloudPESACharge:=GenLedgerSetup."CloudPESA Charge";
            //MobileCharges:=0; //GenLedgerSetup.MinistatementCharge;

             ExcDuty:=(20/100)*(MobileCharges+CloudPESACharge);
            TotalCharges:=ExcDuty+(MobileCharges+CloudPESACharge);

            Vendor.Reset;
            Vendor.SetRange(Vendor."Mobile Phone No",Phone);
            if Vendor.Find('-') then begin
              AccountTypes.Reset;
                AccountTypes.SetRange(AccountTypes.Code,Vendor."Account Type")  ;
                //AccountTypes.SETRANGE(AccountTypes."Last Account No Used(HQ)",FALSE);
                if AccountTypes.Find('-') then
                begin
                  miniBalance:=AccountTypes."Minimum Balance";
                end;
             Vendor.CalcFields(Vendor."Balance (LCY)");
             TempBalance:=Vendor."Balance (LCY)"-(Vendor."ATM Transactions"+Vendor."Uncleared Cheques"+Vendor."EFT Transactions"+miniBalance);
             fosaAcc:=Vendor."No.";

                  if (TempBalance>CloudPESACharge) then begin
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name",'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name",'MOBILETRAN');
                        GenJournalLine.DeleteAll;
                        //end of deletion

                        GenBatches.Reset;
                        GenBatches.SetRange(GenBatches."Journal Template Name",'GENERAL');
                        GenBatches.SetRange(GenBatches.Name,'MOBILETRAN');

                        if GenBatches.Find('-') = false then begin
                        GenBatches.Init;
                        GenBatches."Journal Template Name":='GENERAL';
                        GenBatches.Name:='MOBILETRAN';
                        GenBatches.Description:='Mini Statement';
                        GenBatches.Validate(GenBatches."Journal Template Name");
                        GenBatches.Validate(GenBatches.Name);
                        GenBatches.Insert;
                        end;

                //Dr Mobile Transfer Charges
                        LineNo:=LineNo+10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='GENERAL';
                        GenJournalLine."Journal Batch Name":='MOBILETRAN';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No.":=Vendor."No.";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No.":=DocNumber;
                        GenJournalLine."External Document No.":=Vendor."No.";
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine.Description:='Ministatement Charges';
                        GenJournalLine.Amount:=CloudPESACharge ;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;

                //CR Commission
                        LineNo:=LineNo+10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='GENERAL';
                        GenJournalLine."Journal Batch Name":='MOBILETRAN';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Account No.":=CloudPESACommACC;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No.":=DocNumber;
                         GenJournalLine."Source No.":=Vendor."No.";
                        GenJournalLine."External Document No.":=MobileChargesACC;
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine.Description:='Mini Statement Charges';
                        GenJournalLine.Amount:=-CloudPESACharge;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;

                         //DR Excise Duty
                        LineNo:=LineNo+10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='GENERAL';
                        GenJournalLine."Journal Batch Name":='MOBILETRAN';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No.":=Vendor."No.";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No.":=DocNumber;
                        GenJournalLine."External Document No.":=Vendor."No.";
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine.Description:='Excise duty-Balance Enquiry';
                        GenJournalLine.Amount:=ExcDuty;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;

                        //CR Ex. Duty
                        LineNo:=LineNo+10000;
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='GENERAL';
                        GenJournalLine."Journal Batch Name":='MOBILETRAN';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Account No.":=ExxcDuty;
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Document No.":=DocNumber;
                        GenJournalLine."External Document No.":=MobileChargesACC;
                        GenJournalLine."Source No.":=Vendor."No.";
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine.Description:='Excise duty-Balance Enquiry';
                        GenJournalLine.Amount:=ExcDuty*-1;
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;

                        //Post
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name",'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name",'MOBILETRAN');
                        if GenJournalLine.Find('-') then begin
                        repeat
                        GLPosting.Run(GenJournalLine);
                        until GenJournalLine.Next = 0;
                        end;
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange("Journal Template Name",'GENERAL');
                        GenJournalLine.SetRange("Journal Batch Name",'MOBILETRAN');
                        GenJournalLine.DeleteAll;

                        CloudPESATrans.Init;
                        CloudPESATrans."Document No":=DocNumber;
                        CloudPESATrans.Description:='Mini Statement';
                        CloudPESATrans."Document Date":=Today;
                        CloudPESATrans."Account No" :=Vendor."No.";
                        TotalCharges:=ExcDuty+MobileCharges+CloudPESACharge;
                          CloudPESATrans.Charge:=TotalCharges;
                         CloudPESATrans."Account Name":=Vendor.Name;
                            CloudPESATrans."Telephone Number":=Vendor."Mobile Phone No";
                        CloudPESATrans."Account No2" :='';
                        CloudPESATrans.Amount:=amount;
                        CloudPESATrans.Posted:=true;
                        CloudPESATrans."Posting Date":=Today;
                        CloudPESATrans.Status:=CloudPESATrans.Status::Completed;
                        CloudPESATrans.Comments:='Success';
                        CloudPESATrans.Client:=Vendor."BOSA Account No";
                        CloudPESATrans."Transaction Type":=CloudPESATrans."transaction type"::Ministatement;
                        CloudPESATrans."Transaction Time":=Time;
                        CloudPESATrans.Insert;

                        minimunCount:=1;
                        Vendor.CalcFields(Vendor.Balance);
                        VendorLedgEntry.Reset;
                        VendorLedgEntry.SetCurrentkey(VendorLedgEntry."Entry No.");
                        VendorLedgEntry.Ascending(false);
                        VendorLedgEntry.SetFilter(VendorLedgEntry.Description,'<>%1','*Charges*');
                        VendorLedgEntry.SetRange(VendorLedgEntry."Vendor No.",Vendor."No.");
                        //VendorLedgEntry.SETFILTER(VendorLedgEntry.Description,'<>*Excise duty*');
                        VendorLedgEntry.SetRange(VendorLedgEntry.Reversed,VendorLedgEntry.Reversed::"0");
                      if VendorLedgEntry.FindSet then begin
                          ministmt:='';
                          repeat
                            VendorLedgEntry.CalcFields(VendorLedgEntry.Amount);
                            amount:=VendorLedgEntry.Amount;
                            if amount<1 then
                                amount:= amount*-1;
                                ministmt :=ministmt + Format(VendorLedgEntry."Posting Date") +':::'+ CopyStr(VendorLedgEntry.Description,1,25) +':::' +
                                Format(amount)+'::::';
                                ministmtarr.AddText(ministmt);
                                minimunCount:= minimunCount +1;
                                if minimunCount>10 then
                                exit
                            until VendorLedgEntry.Next =0;

                       end;
                       end
                       else begin
                         ministmt:='INSUFFICIENT';
                          ministmtarr.AddText(ministmt);
                       end;
                end
                else begin
                  ministmt:='ACCNOTFOUND';
                end;
              end;
              ministmtarr.AddText(ministmt);
          end;
    end;


    procedure AdvanceEligibility(account: Text[50]) amount: Decimal
    var
        StoDedAmount: Decimal;
        STO: Record "Standing Orders";
        FOSALoanRepayAmount: Decimal;
        CumulativeNet: Decimal;
        LastSalaryDate: Date;
        FirstSalaryDate: Date;
        AvarageNetPay: Decimal;
        AdvQualificationAmount: Decimal;
        CumulativeNet2: Decimal;
        finalAmount: Decimal;
        interestAMT: Decimal;
        MaxLoanAmt: Decimal;
        LastPaydate: Date;
        MPayDate: Decimal;
        MToday: Decimal;
        DateRegistered: Date;
        MtodayYear: Decimal;
        RegYear: Decimal;
        MtodayDiff: Decimal;
        MRegdate: Decimal;
        ComittedShares: Decimal;
        LoanGuarantors: Record "Loans Guarantee Details";
        FreeShares: Decimal;
        TotalAmount: Decimal;
        TransactionLoanAmt: Decimal;
        TransactionLoanDiff: Decimal;
        RepayedLoanAmt: Decimal;
        LoanRepaymentS: Record "Loan Repayment Schedule";
        Fulldate: Date;
        LastRepayDate: Date;
        PrincipalAmount: Decimal;
        Totalshares: Decimal;
        loanBal: Decimal;
        defaulterStatus: Code[20];
        countTrans: Integer;
        employeeCode: Code[20];
        MemberLedgerEntry2: Record "Member Ledger Entry";
    begin

        Vendor.Reset;
        Vendor.SetRange("No.",account);
        if Vendor.Find('-') then begin
        //=================================================must be member for 6 months
        Members.Reset;
        Members.SetRange(Members."No.",Vendor."BOSA Account No");
        Members.SetRange(Members.Status, Members.Status::Active);
        if Members.Find('-') then begin
          DateRegistered:=Members."Registration Date";
          end;

        if DateRegistered <> 0D then begin
        MtodayYear:=Date2dmy(Today, 3);
        RegYear:=Date2dmy(DateRegistered, 3);
        MRegdate:=Date2dmy(DateRegistered, 2);
          //MToday:=(DATE2DMY(TODAY, 2)+MRegdate)/3;

        if (CalcDate('6M',DateRegistered) >Today)  then
          amount:=1;
        end else begin
          amount:=1;
        end;


        if amount<>1 then begin
            LoansRegister.Reset;
            LoansRegister.SetRange(LoansRegister."Client Code",Members."No.");
            LoansRegister.SetRange(LoansRegister.Posted,true);
            if LoansRegister.Find('-') then begin
            repeat
            LoansRegister.CalcFields(LoansRegister."Outstanding Balance");
            if (LoansRegister."Outstanding Balance">0) then begin

        // =================================== Check if member has an outstanding ELOAN

           if (LoansRegister."Loan Product Type" = '552') or (LoansRegister."Loan Product Type" = '551')  then
              amount:=2;

            end;

            until LoansRegister.Next=0;
            end;

          // ============================================Get Loan Defaulter status
              defaulterStatus:='';
              Members.Reset;
              Members.SetRange(Members."No.", Vendor."BOSA Account No");
              Members.SetRange(Members."Loans Defaulter Status", Members."loans defaulter status"::Perfoming);
              if Members.Find('-') then begin
                LoansRegister.Reset;
                LoansRegister.SetRange(LoansRegister."Client Code", Vendor."BOSA Account No");
              // LoansRegister.SETRANGE(LoansRegister."Loans Category-SASRA",'<>%1', LoansRegister."Loans Category-SASRA"::Perfoming);
                if LoansRegister.Find('-') then begin
                    repeat
                      if (LoansRegister."Loans Category-SASRA"=LoansRegister."loans category-sasra"::Substandard) or (LoansRegister."Loans Category-SASRA"=LoansRegister."loans category-sasra"::Loss)
                         or (LoansRegister."Loans Category-SASRA"=LoansRegister."loans category-sasra"::Doubtful) or (LoansRegister."Loans Category-SASRA"=LoansRegister."loans category-sasra"::Watch) then
                          amount:=3;
                      //defaulterStatus:='TRUE';
                      //END ELSE BEGIN
                       // defaulterStatus:='FALSE';
              //END;

              until LoansRegister.Next=0;
              end;
              end;


        //=============================================Get penalty

              MpesaDisbus.Reset;
              MpesaDisbus.SetCurrentkey(MpesaDisbus."Entry No");
              MpesaDisbus.Ascending(false);
              MpesaDisbus.SetRange(MpesaDisbus."Member No",account);
              if  MpesaDisbus.Find('-') then begin

                if MpesaDisbus."Penalty Date"<>0D then begin

                  if (Today<= CalcDate('6M', MpesaDisbus."Penalty Date")) then
                    amount:=4;

                  end;
              end;
           //END;

           //=========================================== last 6 months deposit contribution

        Members.Reset;
        Members.SetRange(Members."No.", Vendor."BOSA Account No");
        if Members.Find('-') then begin
          employeeCode:=Members."Employer Code";
          end;
         // MESSAGE(employeeCode);
          if employeeCode = '002' then begin
              countTrans:=1;
              MemberLedgerEntry.Reset;
              MemberLedgerEntry.SetRange(MemberLedgerEntry."Customer No.", Vendor."BOSA Account No");
              MemberLedgerEntry.SetRange(MemberLedgerEntry."Transaction Type",MemberLedgerEntry."transaction type"::"Deposit Contribution");
              //MemberLedgerEntry.SETRANGE(MemberLedgerEntry.Description, COPYSTR(MemberLedgerEntry.Description,1,19));  // 'Deposit Contribution');
              if MemberLedgerEntry.Find('-') then begin

                repeat
                  countTrans:=countTrans+1;
                  until MemberLedgerEntry.Next=0;
                  end;

                   if countTrans <>0 then begin

                  if countTrans<=6 then
                    amount:=6;
                  end else begin
                    amount:=6;
                    end;
                    end else begin
                      countTrans:=1;
                     MemberLedgerEntry.Reset;
                     MemberLedgerEntry.SetRange(MemberLedgerEntry."Customer No.", Vendor."BOSA Account No");
                     MemberLedgerEntry.SetRange(MemberLedgerEntry."Transaction Type",MemberLedgerEntry."transaction type"::"Deposit Contribution");
                     MemberLedgerEntry.SetFilter(MemberLedgerEntry."Posting Date", Format(CalcDate('CM+1D-6M', Today))+'..'+Format(CalcDate('CM',Today)));
                     MemberLedgerEntry.SetFilter(MemberLedgerEntry.Description,'<>%1','Opening Balance');
                     MemberLedgerEntry.SetFilter(MemberLedgerEntry."Credit Amount",'>%1',0);
                      if MemberLedgerEntry.Find('-') then begin

                        repeat
                    //  IF ABS(MemberLedgerEntry."Credit Amount")>0 THEN BEGIN

                          MemberLedgerEntry2.Reset;
                          MemberLedgerEntry2.SetRange(MemberLedgerEntry2."Customer No.",MemberLedgerEntry."Customer No.");
                          MemberLedgerEntry2.SetRange(MemberLedgerEntry2."Transaction Type",MemberLedgerEntry."transaction type"::"Deposit Contribution");
                          MemberLedgerEntry2.SetRange(MemberLedgerEntry2."Posting Date",MemberLedgerEntry."Posting Date");
                          MemberLedgerEntry2.SetFilter(MemberLedgerEntry2.Description,'<>%1','Opening Balance');
                          MemberLedgerEntry2.SetFilter(MemberLedgerEntry2."Credit Amount",'>%1',0);
                          if MemberLedgerEntry2.FindLast then begin
                             countTrans:=countTrans+1;
                            end;

                         //   END;

                          until MemberLedgerEntry.Next=0;

                          end;

                           Message(Format(countTrans));
                           if countTrans <>0 then begin
                          if countTrans<6 then
                            amount:=6;
                          end else begin
                            amount:=6;

                              end;
                              end;
                              // END;

          if amount<>2 then begin
                    if amount<>3 then begin
                      if amount<>4 then begin
                        if amount<>6 then begin
        // =========================================================Get Free Shares
            ComittedShares:=0;
            loanBal:=0;

             Members.CalcFields(Members."Current Shares");
              Members.CalcFields(Members."Outstanding Balance");
               Members.CalcFields(Members."Outstanding Interest");
               loanBal:=Members."Outstanding Balance"+Members."Outstanding Interest";

             Totalshares:=Members."Current Shares";

             FreeShares:=Totalshares-(loanBal/3);
            // MESSAGE(FORMAT(loanBal));
        //MESSAGE(FORMAT(FreeShares));
              amount:=0.75*FreeShares;
              //MESSAGE(FORMAT(amount));

        //==================================================Get maximum loan amount
             LoanProductsSetup.Reset;
             LoanProductsSetup.SetRange(LoanProductsSetup.Code,'552');
             if LoanProductsSetup.Find('-') then begin
               interestAMT:=LoanProductsSetup."Interest rate";
               MaxLoanAmt:=LoanProductsSetup."Max. Loan Amount";
              end;

              if amount<100 then
              amount:=0;
            //END;

            if amount>MaxLoanAmt then
              amount:=MaxLoanAmt;
            end;
            end;
            end;
           end;//amount<2>
           end;//amount<>1
        end;//vendor
    end;


    procedure PostAdvance(docNo: Code[20];AccountNo: Code[50];amount: Decimal;period: Decimal) result: Code[30]
    var
        LoanAcc: Code[30];
        InterestAcc: Code[30];
        InterestAmount: Decimal;
        AmountToCredit: Decimal;
        loanNo: Text[20];
        advSMS: Decimal;
        advFee: Decimal;
        advApp: Decimal;
        advSMSAcc: Code[20];
        advFEEAcc: Code[20];
        advAppAcc: Code[20];
        advSMSDesc: Text[100];
        advFeeDesc: Text[100];
        advAppDesc: Text[100];
        LoanProdCharges: Record "Loan Product Charges";
        SaccoNoSeries: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        LoanRepSchedule: Record "Loan Repayment Schedule";
        loanType: Code[50];
        InsuranceAcc: Code[10];
        ObjLoanPurpose: Record "Loans Purpose";
        SaccoNo: Record "No. Series";
        AmountDispursed: Decimal;
        SurePESATrans: Record "CloudPESA Transactions";
        VarLoanAmt: Decimal;
        loanamt: Decimal;
    begin
        /*
        //loanType:='322';
        SurePESATrans.RESET;
        SurePESATrans.SETRANGE(SurePESATrans."Document No", docNo);
        IF SurePESATrans.FIND('-') THEN BEGIN
          result:='REFEXISTS';
          EXIT(result);
        END
        ELSE BEGIN
          //GenSetup.RESET;
          //GenSetup.GET();
          GenLedgerSetup.RESET;
          GenLedgerSetup.GET;
          loanamt:=amount;
        
          LoanProductsSetup.RESET;
          LoanProductsSetup.SETRANGE(LoanProductsSetup.Code,'552');
          IF LoanProductsSetup.FINDFIRST() THEN BEGIN
            LoanAcc:=LoanProductsSetup."Loan Account";
            InterestAcc:=LoanProductsSetup."Loan Interest Account";
            InsuranceAcc:=LoanProductsSetup."Loan Insurance Accounts";
          END;
        
          //loan charges
          LoanProdCharges.RESET;
          LoanProdCharges.SETRANGE(LoanProdCharges."Product Code",'552');
          LoanProdCharges.SETRANGE(LoanProdCharges.Code,loanType);
          IF LoanProdCharges.FINDFIRST() THEN BEGIN
            advApp:=LoanProdCharges.Amount;
            advAppAcc:=LoanProdCharges."G/L Account";
            advAppDesc:=LoanProdCharges.Description;
          END;
          //sms charge
          LoanProdCharges.RESET;
          LoanProdCharges.SETRANGE(LoanProdCharges."Product Code",'552');
          LoanProdCharges.SETRANGE(LoanProdCharges.Code,'001');
          IF LoanProdCharges.FINDFIRST() THEN BEGIN
            advSMS:=(LoanProdCharges.Amount);
            advSMSAcc:=LoanProdCharges."G/L Account";
            advSMSDesc:=LoanProdCharges.Description;
          END;
        
        //Eloan Processing fee
          LoanProdCharges.RESET;
          LoanProdCharges.SETRANGE(LoanProdCharges."Product Code",'552');
          LoanProdCharges.SETRANGE(LoanProdCharges.Code,'552');
          IF LoanProdCharges.FINDFIRST() THEN BEGIN
            advSMS:=LoanProdCharges.Amount;
            advSMSAcc:=LoanProdCharges."G/L Account";
            advSMSDesc:=LoanProdCharges.Description;
          END;
          //loan proccessing fee
          LoanProdCharges.RESET;
          LoanProdCharges.SETRANGE(LoanProdCharges."Product Code",'552');
          LoanProdCharges.SETRANGE(LoanProdCharges.Code,'552');
          IF LoanProdCharges.FINDFIRST() THEN BEGIN
            advFee:=(LoanProdCharges.Amount/100)*amount;
            advFEEAcc:=LoanProdCharges."G/L Account";
            advFeeDesc:=LoanProdCharges.Description;
          END;
        
          VarLoanAmt:=amount;
        
          GenLedgerSetup.RESET;
          GenLedgerSetup.GET;
          GenLedgerSetup.TESTFIELD(GenLedgerSetup."MPESA Settl Acc");
           MpesaAccount:=  GenLedgerSetup."MPESA Settl Acc";
             MPESACharge:=GetCharge(amount,'MPESA');
        
            CloudPESACharge:=0;//GenLedgerSetup."CloudPESA Charge";
            CloudPESACommACC:='';// GenLedgerSetup."CloudPESA Comm Acc";
            InterestAmount:=(LoanProductsSetup."Interest rate"/100)*amount*period;
            AmountToCredit:=amount+InterestAmount+MPESACharge+advSMS;
            //ExcDuty:=(10/100)*(MobileCharges+SurePESACharge);
            AmountDispursed:=amount+MPESACharge+advSMS;
            Vendor.RESET;
            Vendor.SETRANGE(Vendor."No.",AccountNo);
            IF Vendor.FIND('-') THEN BEGIN
              END;
             Members.RESET;
              Members.SETRANGE(Members."No.", Vendor."BOSA Account No");
              IF Members.FIND('-') THEN BEGIN
        
              //*******Create Loan *********//
                  SaccoNoSeries.Reset;
                  SaccoNoSeries.Get;
                  SaccoNoSeries.TestField(SaccoNoSeries."BOSA Loans Nos");
                  NoSeriesMgt.InitSeries(SaccoNoSeries."BOSA Loans Nos",LoansRegister."No. Series",0D,LoansRegister."Loan  No.",LoansRegister."No. Series");
                  loanNo:=LoansRegister."Loan  No.";
        
                  LoansRegister.Init;
                  LoansRegister."Approved Amount":=amount;
                  LoansRegister.Interest:=LoanProductsSetup."Interest rate";
                  LoansRegister."Instalment Period":=LoanProductsSetup."Instalment Period";
                  LoansRegister.Repayment:=AmountDispursed;
                  LoansRegister."Expected Date of Completion":=CalcDate(Format(period)+'M',Today);
                  LoansRegister.Posted:=true;
                  Members.CalcFields(Members."Current Shares",Members."Outstanding Balance",Members."Current Loan");
                  LoansRegister."Shares Balance":=Members."Current Shares";
                  LoansRegister."Amount Disbursed":=amount;
                  LoansRegister.Savings:=Members."Current Shares";
                  LoansRegister."Interest Paid":=0;
                  LoansRegister."Issued Date":=Today;
                  LoansRegister.Source:=LoanProductsSetup.Source;
                  LoansRegister."Loan Disbursed Amount":=amount;
                  LoansRegister."Scheduled Principal to Date":=AmountDispursed;
                  LoansRegister."Current Interest Paid":=0;
                  LoansRegister."Loan Disbursement Date":=Today;
                  LoansRegister."Client Code":=Members."No.";
                  LoansRegister."Client Name":=Members.Name;
                  LoansRegister."Outstanding Balance to Date":=AmountDispursed;
                  LoansRegister."Existing Loan":=Members."Outstanding Balance";
                  //LoansRegister."Staff No":=Members."Payroll/Staff No";
                  LoansRegister.Gender:=Members.Gender;
                  LoansRegister."BOSA No":=Members."No.";
                 // LoansRegister."Branch Code":=Vendor."Global Dimension 2 Code";
                  LoansRegister."Requested Amount":=amount;
                  LoansRegister."ID NO":=Members."ID No.";
                  if LoansRegister."Branch Code" = '' then
                  LoansRegister."Branch Code":=Members."Global Dimension 2 Code";
                  LoansRegister."Loan  No.":=loanNo;
                  LoansRegister."No. Series":=SaccoNoSeries."BOSA Loans Nos";
                  LoansRegister."Doc No Used":=docNo;
                  LoansRegister."Loan Interest Repayment":=InterestAmount;
                  LoansRegister."Loan Principle Repayment":=AmountDispursed;
                  LoansRegister."Loan Repayment":=AmountDispursed+InterestAmount;
                  LoansRegister."Employer Code":=Members."Employer Code";
                  LoansRegister."Approval Status":=LoansRegister."approval status"::Approved;
                  LoansRegister."Account No":=Members."No.";
                  LoansRegister."Application Date":=Today;
                  LoansRegister."Loan Product Type":=LoanProductsSetup.Code;
                  LoansRegister."Loan Product Type Name":=LoanProductsSetup."Product Description";
                  LoansRegister."Loan Disbursement Date":=Today;
                  LoansRegister."Repayment Start Date":=Today;
                  LoansRegister."Recovery Mode":=LoansRegister."recovery mode"::Checkoff;
                  LoansRegister."Disburesment Type":=LoansRegister."disburesment type"::"Full/Single disbursement";
                  LoansRegister."Requested Amount":=amount;
                  LoansRegister."Approved Amount":=AmountDispursed;
                  LoansRegister.Installments:=period;
                  LoansRegister."Loan Amount":=AmountDispursed;
                  LoansRegister."Issued Date":=Today;
                  LoansRegister."Outstanding Balance":=0;//Update
                  LoansRegister."Repayment Frequency":=LoansRegister."repayment frequency"::Monthly;
                  LoansRegister."Mode of Disbursement":= LoansRegister."mode of disbursement"::"Bank Transfer";
                  LoansRegister.Insert(true);
        
             // InterestAmount:=0;
        
             //**********Process Loan*******************//
        
                  GenJournalLine.Reset;
                  GenJournalLine.SetRange("Journal Template Name",'GENERAL');
                  GenJournalLine.SetRange("Journal Batch Name",'MOBILELOAN');
                  GenJournalLine.DeleteAll;
                  //end of deletion
        
                  GenBatches.Reset;
                  GenBatches.SetRange(GenBatches."Journal Template Name",'GENERAL');
                  GenBatches.SetRange(GenBatches.Name,'MOBILELOAN');
        
                  if GenBatches.Find('-') = false then begin
                  GenBatches.Init;
                  GenBatches."Journal Template Name":='GENERAL';
                  GenBatches.Name:='MOBILELOAN';
                  GenBatches.Description:='E-Loan';
                  GenBatches.Validate(GenBatches."Journal Template Name");
                  GenBatches.Validate(GenBatches.Name);
                  GenBatches.Insert;
                  end;
        
        
        
                  //Post Loan
                  LoansRegister.Reset;
                  LoansRegister.SetRange(LoansRegister."Loan  No.",loanNo);
                  if LoansRegister.Find('-') then begin
        
          //Dr loan Acc
                  LineNo:=LineNo+10000;
                  GenJournalLine.Init;
                  GenJournalLine."Journal Template Name":='GENERAL';
                  GenJournalLine."Journal Batch Name":='MOBILELOAN';
                  GenJournalLine."Line No.":=LineNo;
                  GenJournalLine."Account Type":=GenJournalLine."account type"::Member;
                  GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::Loan;
                  GenJournalLine."Loan No":=LoansRegister."Loan  No.";
                  GenJournalLine."Account No.":=Members."No.";
                  GenJournalLine.Validate(GenJournalLine."Account No.");
                  GenJournalLine."Document No.":=docNo;
                  GenJournalLine."External Document No.":=Members."No.";
                  GenJournalLine."Posting Date":=Today;
                  GenJournalLine.Description:='MBanking Loan Disbursment -'+LoansRegister."Loan  No.";
                  GenJournalLine.Amount:=AmountDispursed;
                  GenJournalLine.Validate(GenJournalLine.Amount);
                  if GenJournalLine.Amount<>0 then
                  GenJournalLine.Insert;
        
        
        
        //Cr Interest Eloan
                    LineNo:=LineNo+10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name":='GENERAL';
                    GenJournalLine."Journal Batch Name":='MOBILELOAN';
                    GenJournalLine."Line No.":=LineNo;
                    GenJournalLine."Account Type":=GenJournalLine."account type"::Member;
                    GenJournalLine."Account No.":= Members."No.";
                    GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Interest Due";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No.":=docNo;
                    GenJournalLine."Posting Date":=Today;
                    GenJournalLine.Description:=docNo+' '+'Interest charged';
                    GenJournalLine.Amount:=ROUND(InterestAmount,1,'>');
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if LoanProductsSetup.Get(LoansRegister."Loan Product Type") then begin
                    GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"G/L Account";
                    GenJournalLine."Bal. Account No.":=LoanProductsSetup."Loan Interest Account";
                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                    end;
                    if  LoansRegister.Source= LoansRegister.Source::BOSA then begin
                    GenJournalLine."Shortcut Dimension 1 Code":=Members."Global Dimension 1 Code";
                    GenJournalLine."Shortcut Dimension 2 Code":=Members."Global Dimension 2 Code";
                    end;
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    GenJournalLine."Loan No":= LoansRegister."Loan  No.";
                    if GenJournalLine.Amount<>0 then
                    GenJournalLine.Insert;
        
                 //Cr proceesing Charges
                  LineNo:=LineNo+10000;
                  GenJournalLine.Init;
                  GenJournalLine."Journal Template Name":='GENERAL';
                  GenJournalLine."Journal Batch Name":='MOBILELOAN';
                  GenJournalLine."Line No.":=LineNo;
                  GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                  GenJournalLine."Account No.":=advSMSAcc;
                  GenJournalLine.Validate(GenJournalLine."Account No.");
                  GenJournalLine."Document No.":=docNo;
                  GenJournalLine."External Document No.":=docNo;
                  GenJournalLine."Posting Date":=Today;
                  GenJournalLine.Description:=advSMSDesc+' '+LoansRegister."Loan  No.";
                  GenJournalLine.Amount:=advSMS*-1;
                  GenJournalLine.Validate(GenJournalLine.Amount);
                  if GenJournalLine.Amount<>0 then
                  GenJournalLine.Insert;
        
          //Cr bank Charges
                  LineNo:=LineNo+10000;
                  GenJournalLine.Init;
                  GenJournalLine."Journal Template Name":='GENERAL';
                  GenJournalLine."Journal Batch Name":='MOBILELOAN';
                  GenJournalLine."Line No.":=LineNo;
                  GenJournalLine."Account Type":=GenJournalLine."account type"::"Bank Account";
                  GenJournalLine."Account No.":=MpesaAccount;
                  GenJournalLine.Validate(GenJournalLine."Account No.");
                  GenJournalLine."Document No.":=docNo;
                  GenJournalLine."External Document No.":=docNo;
                  GenJournalLine."Posting Date":=Today;
                  GenJournalLine.Description:='MBanking Loan Disbursment - Charges -'+LoansRegister."Loan  No.";
                  GenJournalLine.Amount:=MPESACharge*-1;
                  GenJournalLine.Validate(GenJournalLine.Amount);
                  if GenJournalLine.Amount<>0 then
                  GenJournalLine.Insert;
        
        //Cr bank
                  LineNo:=LineNo+10000;
                  GenJournalLine.Init;
                  GenJournalLine."Journal Template Name":='GENERAL';
                  GenJournalLine."Journal Batch Name":='MOBILELOAN';
                  GenJournalLine."Line No.":=LineNo;
                  GenJournalLine."Account Type":=GenJournalLine."account type"::"Bank Account";
                  GenJournalLine."Account No.":=MpesaAccount;
                  GenJournalLine.Validate(GenJournalLine."Account No.");
                  GenJournalLine."Document No.":=docNo;
                  GenJournalLine."External Document No.":=docNo;
                  GenJournalLine."Posting Date":=Today;
                  GenJournalLine.Description:='MBanking Loan Disbursment -'+LoansRegister."Loan  No.";
                  GenJournalLine.Amount:=(loanamt)*-1;
                  GenJournalLine.Validate(GenJournalLine.Amount);
                  if GenJournalLine.Amount<>0 then
                  GenJournalLine.Insert;
        
        
        
                  //Post
                  GenJournalLine.Reset;
                  GenJournalLine.SetRange("Journal Template Name",'GENERAL');
                  GenJournalLine.SetRange("Journal Batch Name",'MOBILELOAN');
                  if GenJournalLine.Find('-') then begin
                  repeat
                  GLPosting.Run(GenJournalLine);
                  until GenJournalLine.Next = 0;
        
        //***************Update Loan Status************//
                  LoansRegister."Loan Status":=LoansRegister."loan status"::Issued;
                  LoansRegister."Amount Disbursed":=AmountToCredit;
                  LoansRegister.Posted:=true;
                  LoansRegister."Interest Upfront Amount":=InterestAmount;
                  LoansRegister."Outstanding Balance":=AmountDispursed;
                  LoansRegister.Modify;
        
        
        //======================Generate schedule
        I:=1;
        while I<=period do begin
         LoansRegister.CalcFields(LoansRegister."Oustanding Interest",LoansRegister."Outstanding Balance");
                  RSchedule.Init;
                  RSchedule."Repayment Code":=Format(I);
                  RSchedule."Loan No.":=LoansRegister."Loan  No.";
                  RSchedule."Loan Amount":=LoansRegister."Loan Amount";
                  RSchedule."Instalment No":=I;
                  RSchedule."Repayment Date":=CalcDate(Format(I)+'M',LoansRegister."Issued Date");
                  RSchedule."Member No.":=LoansRegister."Client Code";
                  RSchedule."Loan Category":=LoansRegister."Loan Product Type";
                  RSchedule."Monthly Repayment":=(LoansRegister."Loan Principle Repayment"+LoansRegister."Loan Interest Repayment")/I;
                  RSchedule."Monthly Interest":=(LoansRegister."Oustanding Interest")/I;
                  RSchedule."Principal Repayment":=(LoansRegister."Loan Principle Repayment")/I;
                  RSchedule."Loan Balance":=LoansRegister."Oustanding Interest"+LoansRegister."Outstanding Balance";
                  RSchedule.Insert;
        
        I:=I+1;
                  end;
        
        
        //=====================insert to Mpesa mobile disbursment
                 MpesaDisbus.Reset;
                  MpesaDisbus.SetRange(MpesaDisbus."Document No",docNo);
                  if MpesaDisbus.Find('-')=false then begin
        
                  MpesaDisbus."Account No":=Members."No.";
                  MpesaDisbus."Document Date":=Today;
                  MpesaDisbus."Loan Amount":=loanamt;
                  MpesaDisbus."Document No":=docNo;
                  MpesaDisbus."Batch No":='MOBILE';
                  MpesaDisbus."Date Entered":=Today;
                  MpesaDisbus."Time Entered":=Time;
                  MpesaDisbus."Entered By":=UserId;
                  MpesaDisbus."Member No":=Members."No.";
                  MpesaDisbus."Telephone No":=Members."Phone No.";
                  MpesaDisbus."Corporate No":='568915';
                  MpesaDisbus."Delivery Center":='MPESA';
                  MpesaDisbus."Customer Name":=Members.Name;
                  MpesaDisbus.Status:=MpesaDisbus.Status::Pending;
                  MpesaDisbus.Purpose:='Emergency';
                  MpesaDisbus."Repayment Period":=period;
                  MpesaDisbus.Insert;
        
                  end;
        
        
                    result:='TRUE';
                  msg:='Dear '+SplitString(Members.Name,' ')+', Your Eloan No '+loanNo+' of Ksh '+Format((loanamt))+' has been approved and disbursed to your Mpesa No.'+
                 Members."Phone No."+ '. The total payable amount is KShs '+Format(AmountToCredit)+ ' payable on or before '+ Format(LoansRegister."Expected Date of Completion"); //FORMAT(CALCDATE((period) +'M',TODAY));
                     SMSMessage(docNo,Members."No.",Members."Phone No.",msg);
        
                  SurePESATrans.Init;
                  SurePESATrans."Document No":=docNo;
                  SurePESATrans.Description:='Mobile Loan';
                  SurePESATrans."Document Date":=Today;
                  SurePESATrans."Account No" :=AccountNo;
                  SurePESATrans."Account No2" :='';
                  SurePESATrans."Account Name":=Members.Name;
                  SurePESATrans."Telephone Number":=Members."Phone No.";
                  SurePESATrans.Amount:=amount;
                  SurePESATrans.Status:=SurePESATrans.Status::Completed;
                  SurePESATrans.Posted:=true;
                  SurePESATrans."Posting Date":=Today;
                  SurePESATrans.Comments:='Success';
                  SurePESATrans.Client:=Members."No.";
                  SurePESATrans."Transaction Type":=SurePESATrans."transaction type"::"Loan Application";
                  SurePESATrans."Transaction Time":=Time;
                  SurePESATrans.Insert;
        
        
                  end;//
                end;//Loans Register
                "END"
          else begin
            "result":='ACCINEXISTENT';
                   SurePESATrans.Init;
                  SurePESATrans."Document No":=docNo;
                  SurePESATrans.Description:='Mobile Loan';
                  SurePESATrans."Document Date":=Today;
                  SurePESATrans."Account No" :=AccountNo;
                  SurePESATrans."Account No2" :='';
                  SurePESATrans.Amount:=amount;
                  SurePESATrans.Status:=SurePESATrans.Status::Failed;
                  SurePESATrans.Posted:=true;
                  SurePESATrans."Posting Date":=Today;
                  SurePESATrans.Comments:='Failed';
                  SurePESATrans.Client:=Members."No.";
                  SurePESATrans."Transaction Type":=SurePESATrans."transaction type"::"Loan Application";
                  SurePESATrans."Transaction Time":=Time;
                  SurePESATrans.Insert;
        
        
          end;
          end;
        */

    end;


    procedure GetMpesaDisbursment() result: Text
    begin
        MpesaDisbus.Reset;
        MpesaDisbus.SetRange(MpesaDisbus."Sent To Server",MpesaDisbus."sent to server"::No);
        MpesaDisbus.SetRange(MpesaDisbus.Status,MpesaDisbus.Status::Pending);
        if MpesaDisbus.Find('-') then begin
           result:=MpesaDisbus."Document No"+':::'+MpesaDisbus."Telephone No"+':::'+Format(MpesaDisbus."Loan Amount")+':::'+MpesaDisbus."Account No"+':::'+MpesaDisbus."Customer Name";
        end;
    end;


    procedure UpdateMpesaDisbursment(ImprestNo: Code[30];MpesaNo: Code[30];Phone: Code[30];ResultCode: Code[10];Comments: Text) result: Code[10]
    var
        BankLedger: Record "Bank Account Ledger Entry";
    begin
        MpesaDisbus.Reset;
        MpesaDisbus.SetRange(MpesaDisbus."Document No",ImprestNo);
        //Mkahawa.SETRANGE(Mkahawa."Telephone No",Phone);
        if MpesaDisbus.Find('-') then begin
          if ResultCode='0' then begin
            MpesaDisbus."Sent To Server":=MpesaDisbus."sent to server"::Yes;
            MpesaDisbus.Status:=MpesaDisbus.Status::Completed;
             BankLedger.Reset;
             BankLedger.SetRange(BankLedger."External Document No.",ImprestNo);
            // BankLedger.SETRANGE(
             if BankLedger.Find('-') then
               begin
                 BankLedger."External Document No.":=MpesaNo;
                 BankLedger.Modify;
                end;
          end else begin
           MpesaDisbus."Sent To Server":=MpesaDisbus."sent to server"::Yes;
           MpesaDisbus.Status:=MpesaDisbus.Status::Failed;
          end;
          MpesaDisbus.Comments:=Comments;
          MpesaDisbus."Date Sent To Server":=Today;
          MpesaDisbus."Time Sent To Server":=Time;
          MpesaDisbus."MPESA Doc No.":=MpesaNo;
          MpesaDisbus.Modify;
          result:='TRUE';
          end;
    end;


    procedure UpdateMpesaPending(Doc: Code[50])
    begin
        MpesaDisbus.Reset;
        MpesaDisbus.SetRange(MpesaDisbus."Document No",Doc);
        MpesaDisbus.SetRange(MpesaDisbus."Sent To Server",MpesaDisbus."sent to server"::No);
        MpesaDisbus.SetRange(MpesaDisbus.Status,MpesaDisbus.Status::Pending);
        if MpesaDisbus.Find('-') then begin
          MpesaDisbus.Status:=MpesaDisbus.Status::Waiting;
          MpesaDisbus.Modify;
          end;
    end;

    local procedure SplitString(sText: Text;separator: Text) Token: Text
    var
        Pos: Integer;
        Tokenq: Text;
    begin
        Pos := StrPos(sText,separator);
        if Pos > 0 then begin
          Token := CopyStr(sText,1,Pos-1);
          if Pos+1 <= StrLen(sText) then
            sText := CopyStr(sText,Pos+1)
          else
            sText := '';
        end else begin
          Token := sText;
          sText := '';
        end;
    end;


    procedure fnProcessNotification()
    var
        VarIssuedDate: Date;
        VarExpectedCompletion: Date;
        batch: Code[50];
        SaccoNoSeries: Record "Sacco No. Series";
        docNo: Code[50];
        VarReceivableAccount: Code[50];
        redemptionFeeAcc: Code[20];
        recoveredAmount: Decimal;
    begin
        LoansRegister.Reset;
        LoansRegister.SetRange(LoansRegister."Client Code",'001872');
        LoansRegister.SetRange(LoansRegister."Loan Product Type",'552');
        LoansRegister.SetRange(LoansRegister.Posted, true);
        if LoansRegister.Find('-') then begin
           //............
          GenSetup.Reset;
          GenSetup.Get;
          LoanProductsSetup.Reset;
          LoanProductsSetup.SetRange(LoanProductsSetup.Code,'552');
          if LoanProductsSetup.FindFirst() then begin
            redemptionFeeAcc:=LoanProductsSetup."Penalty Paid Account";

          end;
          repeat
            LoansRegister.CalcFields("Outstanding Balance", "Oustanding Interest");

           if LoansRegister."Outstanding Balance">0 then begin

             VarIssuedDate:=LoansRegister."Issued Date";
             VarExpectedCompletion:=LoansRegister."Expected Date of Completion";

             Members.Reset;
             Members.SetRange(Members."No.",LoansRegister."Client Code");
             if Members.Find('-') then begin

                 if Today = CalcDate('-1W',VarExpectedCompletion) then begin //SEND SMS 1 WEEK TO DUE DATE

                   MpesaDisbus.Reset;
                   MpesaDisbus.SetRange(MpesaDisbus."Member No",Members."No.");
                   MpesaDisbus.SetRange(MpesaDisbus."Ist Notification",false);
                   if MpesaDisbus.Find('-') then begin
                   msg:='Dear '+SplitString(Members.Name,' ')+', we remind you to pay your '+LoansRegister."Loan Product Type Name"+' which is due on '
                     + Format(LoansRegister."Expected Date of Completion") +' with amount of Ksh. '+Format(LoansRegister."Outstanding Balance"+LoansRegister."Oustanding Interest");

                  SMSMessage(LoansRegister."Doc No Used",LoansRegister."Client Code",Members."Phone No.",msg);
                  MpesaDisbus."Ist Notification":=true;
                  MpesaDisbus.Modify;
                    end;
                   end;

                 //MESSAGE('%1',TODAY);//CALCDATE('4W',20181009D));
                 if Today = CalcDate('0D', LoansRegister."Expected Date of Completion") then begin //SEND SMS DUE DATE

                   MpesaDisbus.Reset;
                   MpesaDisbus.SetRange(MpesaDisbus."Member No",Members."No.");
                   MpesaDisbus.SetRange(MpesaDisbus."2nd Notification",false);
                   if MpesaDisbus.Find('-') then begin

                   msg:='Dear '+SplitString(Members.Name,' ')+', Your '+LoansRegister."Loan Product Type Name"+' of amount Ksh. '+Format(LoansRegister."Outstanding Balance"+LoansRegister."Oustanding Interest")
                   +' is due today please pay to avoid penalty and other charges.';

                  SMSMessage(LoansRegister."Doc No Used",LoansRegister."Client Code",Members."Phone No.",msg);
                  MpesaDisbus."2nd Notification":=true;
                  MpesaDisbus.Modify;
                    end;
                 end;

                  if Today = CalcDate('2D', LoansRegister."Expected Date of Completion") then begin //SEND SMS 2 DAYS AFTER DUE DATE

                   MpesaDisbus.Reset;
                   MpesaDisbus.SetRange(MpesaDisbus."Member No",Members."No.");
                   MpesaDisbus.SetRange(MpesaDisbus."3rd Notification",false);
                   if MpesaDisbus.Find('-') then begin

                   msg:='Dear '+SplitString(Members.Name,' ')+', we note with regret that you have failed to pay your '+LoansRegister."Loan Product Type Name"+' of amount Ksh. '+
                   Format(LoansRegister."Outstanding Balance"+LoansRegister."Oustanding Interest")+' that was due on '+Format(VarExpectedCompletion)+', please pay the amount to avoid penalty charges';

                  SMSMessage(LoansRegister."Doc No Used",LoansRegister."Client Code",Members."Phone No.",msg);
                  MpesaDisbus."3rd Notification":=true;
                  MpesaDisbus.Modify;
                    end;
                 end;


                 //IF TODAY = CALCDATE('20D',VarExpectedCompletion)  THEN BEGIN // recover from deposit
                    if Today = CalcDate('0D',VarIssuedDate) then begin

                    docNo:='RECOVER -'+LoansRegister."Loan  No.";

                  batch:='MOBILELOAN';
                  GenJournalLine.Reset;
                  GenJournalLine.SetRange("Journal Template Name",'GENERAL');
                  GenJournalLine.SetRange("Journal Batch Name",batch);
                  GenJournalLine.DeleteAll;
                  //end of deletion

                  GenBatches.Reset;
                  GenBatches.SetRange(GenBatches."Journal Template Name",'GENERAL');
                  GenBatches.SetRange(GenBatches.Name,batch);

                  if GenBatches.Find('-') = false then begin
                    GenBatches.Init;
                    GenBatches."Journal Template Name":='GENERAL';
                    GenBatches.Name:=batch;
                    GenBatches.Description:='mobile loan recovery';
                    GenBatches.Validate(GenBatches."Journal Template Name");
                    GenBatches.Validate(GenBatches.Name);
                    GenBatches.Insert;
                  end;

                  //General Jnr Batches

        //DR Deposits-loan
                      LineNo:=LineNo+10000;
                      GenJournalLine.Init;
                      GenJournalLine."Journal Template Name":='GENERAL';
                      GenJournalLine."Journal Batch Name":=batch;
                      GenJournalLine."Line No.":=LineNo;
                      GenJournalLine."Account Type":=GenJournalLine."account type"::Member;
                      GenJournalLine."Account No.":=Members."No.";
                      GenJournalLine.Validate(GenJournalLine."Account No.");
                      GenJournalLine."Document No.":=docNo;
                      GenJournalLine."External Document No.":=docNo;
                      GenJournalLine."Posting Date":=Today;
                      GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Deposit Contribution";
                      GenJournalLine."Shortcut Dimension 1 Code":='BOSA';
                      GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                      GenJournalLine.Description:=Format(GenJournalLine."transaction type"::"Deposit Contribution")+' - eLoan Principle Recovery';
                      GenJournalLine.Amount:=LoansRegister."Outstanding Balance"; //+(0.1* LoansRegister."Outstanding Balance"));
                      GenJournalLine.Validate(GenJournalLine.Amount);
                      if GenJournalLine.Amount<>0 then
                      GenJournalLine.Insert;

        //DR Deposits-interest
                      LineNo:=LineNo+10000;
                      GenJournalLine.Init;
                      GenJournalLine."Journal Template Name":='GENERAL';
                      GenJournalLine."Journal Batch Name":=batch;
                      GenJournalLine."Line No.":=LineNo;
                      GenJournalLine."Account Type":=GenJournalLine."account type"::Member;
                      GenJournalLine."Account No.":=Members."No.";
                      GenJournalLine.Validate(GenJournalLine."Account No.");
                      GenJournalLine."Document No.":=docNo;
                      GenJournalLine."External Document No.":=docNo;
                      GenJournalLine."Posting Date":=Today;
                      GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Deposit Contribution";
                      GenJournalLine."Shortcut Dimension 1 Code":='BOSA';
                      GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                      GenJournalLine.Description:=Format(GenJournalLine."transaction type"::"Deposit Contribution")+' - eLoan Interest Recovery';
                      GenJournalLine.Amount:=LoansRegister."Oustanding Interest"; //+(0.1* LoansRegister."Outstanding Balance"));
                      GenJournalLine.Validate(GenJournalLine.Amount);
                      if GenJournalLine.Amount<>0 then
                      GenJournalLine.Insert;

         //DR Deposits-penalty
                       LineNo:=LineNo+10000;
                      GenJournalLine.Init;
                      GenJournalLine."Journal Template Name":='GENERAL';
                      GenJournalLine."Journal Batch Name":=batch;
                      GenJournalLine."Line No.":=LineNo;
                      GenJournalLine."Account Type":=GenJournalLine."account type"::Member;
                      GenJournalLine."Account No.":=Members."No.";
                      GenJournalLine.Validate(GenJournalLine."Account No.");
                      GenJournalLine."Document No.":=docNo;
                      GenJournalLine."External Document No.":=docNo;
                      GenJournalLine."Posting Date":=Today;
                      GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Deposit Contribution";
                      GenJournalLine."Shortcut Dimension 1 Code":='BOSA';
                      GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                      GenJournalLine.Description:=Format(GenJournalLine."transaction type"::"Deposit Contribution")+' -eLoan Recovery Penalty';
                      GenJournalLine.Amount:=(0.1* LoansRegister."Outstanding Balance");
                      GenJournalLine.Validate(GenJournalLine.Amount);
                      if GenJournalLine.Amount<>0 then
                      GenJournalLine.Insert;

         //CR Interest
                    LineNo:=LineNo+10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name":='GENERAL';
                    GenJournalLine."Journal Batch Name":=batch;
                    GenJournalLine."Line No.":=LineNo;
                    GenJournalLine."Account Type":=GenJournalLine."account type"::Member;
                    GenJournalLine."Account No.":=LoansRegister."Client Code";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No.":=docNo;
                    GenJournalLine."External Document No.":=docNo;
                    GenJournalLine."Posting Date":=Today;
                    GenJournalLine.Description:='Loan Interest Payment';
                    GenJournalLine.Amount:=-LoansRegister."Oustanding Interest";
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Interest Paid";
                    if GenJournalLine."Shortcut Dimension 1 Code" = '' then begin
                    GenJournalLine."Shortcut Dimension 1 Code":=Members."Global Dimension 1 Code";
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    end;
                    GenJournalLine."Loan No":=LoansRegister."Loan  No.";
                    if GenJournalLine.Amount<>0 then
                    GenJournalLine.Insert;
                    GenSetup.Reset;
                    GenSetup.Get;
                    LoanProductsSetup.Reset;


           //CR Loan acc
                    LineNo:=LineNo+10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name":='GENERAL';
                    GenJournalLine."Journal Batch Name":=batch;
                    GenJournalLine."Line No.":=LineNo;
                    GenJournalLine."Account Type":=GenJournalLine."account type"::Member;
                    GenJournalLine."Account No.":=LoansRegister."Client Code";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No.":=docNo;
                    GenJournalLine."External Document No.":=docNo;
                    GenJournalLine."Posting Date":=Today;
                    GenJournalLine.Description:='Loan Repayment';
                    GenJournalLine.Amount:=-LoansRegister."Outstanding Balance";
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Loan Repayment";
                    if GenJournalLine."Shortcut Dimension 1 Code" = '' then begin
                    GenJournalLine."Shortcut Dimension 1 Code":=Members."Global Dimension 1 Code";
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    end;
                    GenJournalLine."Loan No":=LoansRegister."Loan  No.";
                    if GenJournalLine.Amount<>0 then
                    GenJournalLine.Insert;


         //CR Loan Redemption fee
                    LineNo:=LineNo+10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name":='GENERAL';
                    GenJournalLine."Journal Batch Name":=batch;
                    GenJournalLine."Line No.":=LineNo;
                    GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                     GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Loan Insurance Charged";
                   GenJournalLine."Account No.":=redemptionFeeAcc;
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No.":=docNo;
                    GenJournalLine."External Document No.":=docNo;
                    GenJournalLine."Posting Date":=Today;
                    GenJournalLine.Description:='Loan recovery penalty';
                    GenJournalLine.Amount:=-(0.1* LoansRegister."Outstanding Balance");
                    GenJournalLine.Validate(GenJournalLine.Amount);

                    if GenJournalLine."Shortcut Dimension 1 Code" = '' then begin
                    GenJournalLine."Shortcut Dimension 1 Code":=Members."Global Dimension 1 Code";
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    end;
                    GenJournalLine."Loan No":=LoansRegister."Loan  No.";
                    if GenJournalLine.Amount<>0 then
                    GenJournalLine.Insert;


                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name",'GENERAL');
                    GenJournalLine.SetRange("Journal Batch Name",batch);
                    if GenJournalLine.Find('-') then begin
                    repeat
                     GLPosting.Run(GenJournalLine);
                    until GenJournalLine.Next = 0;



                   recoveredAmount:=(LoansRegister."Outstanding Balance"+LoansRegister."Oustanding Interest"+(0.1* LoansRegister."Outstanding Balance"));
                   MpesaDisbus.Reset;
                   MpesaDisbus.SetRange(MpesaDisbus."Member No",Members."No.");
                   MpesaDisbus.SetRange(MpesaDisbus."Document No",LoansRegister."Doc No Used");
                   if MpesaDisbus.Find('-') then begin
                     MpesaDisbus."Penalty Date":=Today;
                     MpesaDisbus.Modify;
                     end;

                   msg:='Dear '+SplitString(Members.Name,' ')+', we regret that you have refused/neglected to regularize your '+LoansRegister."Loan Product Type Name"+' despite previous reminders. We have recovered Ksh.'
                   +Format(recoveredAmount)+' from your deposits which includes a penalty of 10%.';
                       SMSMessage(LoansRegister."Doc No Used",LoansRegister."Client Code",Members."Phone No.",msg);
                      end;

                    end;
             end;

            end;

          until LoansRegister.Next=0;
        end;
    end;


    procedure paybillVerification(mpesaDocNo: Code[50]) result: Text
    begin
        PaybillTrans.Reset;
        PaybillTrans.SetRange(PaybillTrans."Document No", mpesaDocNo);
        PaybillTrans.SetRange(PaybillTrans.Posted, false);
        PaybillTrans.SetRange(PaybillTrans.Verified, false);
        if PaybillTrans.Find('-') then begin
          PaybillTrans.Verified:=true;
          PaybillTrans.Modify;
          result:='Modified';
          end else begin
             result:='Modified';
            end;
    end;


    procedure paybillsToVerify() paybilldetails: Text[1000]
    begin
        begin

          PaybillTrans.Reset;
          PaybillTrans.Ascending(true);
          PaybillTrans.SetRange(PaybillTrans.Posted, false);
          PaybillTrans.SetRange(PaybillTrans.Verified, false);
          if PaybillTrans.FindFirst() then
            begin
                 paybilldetails:=PaybillTrans."Document No"+':::'+PaybillTrans.Telephone+':::'+PaybillTrans."Account No";
            end
          else
          begin
             paybilldetails:='';
          end
          end;
    end;


    procedure Loancalculator1() calcdetails: Code[1024]
    var
        varLoan: Text[1024];
        LoanProducttype: Record "Loan Products Setup";
    begin
        begin

        LoanProducttype.Reset;
            //LoanProducttype.GET();
        //LoanProducttype.SETRANGE(LoanProducttype.Source,1);
             if LoanProducttype.Find('-') then begin
                //  LoanProducttype.CALCFIELDS(LoanProducttype."Interest rate",LoanProducttype."Max. Loan Amount",LoanProducttype."Min. Loan Amount");

                  repeat

           varLoan := varLoan + '::::'+Format( LoanProducttype."Product Description") +':::' +Format(LoanProducttype."Interest rate") +':::' + Format(LoanProducttype."No of Installment")+':::' + Format(LoanProducttype."Max. Loan Amount");

                  until LoanProducttype.Next = 0;
                  //MESSAGE('Loan Balance %1',loanbalances);
                  calcdetails:=varLoan;

              end;
         end;
    end;

    local procedure fngetmemberNo(phoneNo: Code[100]) Acount: Code[50]
    begin

              Members.Reset;
              Members.SetRange(Members."No.",CopyStr(phoneNo,4,15));
              if Members.Find('-') then begin
               Acount:=Members."No.";
                exit;
              end;
               Members.Reset;
              Members.SetRange(Members."Mobile Phone No",phoneNo);
              if Members.Find('-') then begin
               Acount:=Members."No.";
                exit;
              end;
              Members.Reset;
              Members.SetRange(Members."Mobile Phone No",'0'+CopyStr(phoneNo,4,15));
              if Members.Find('-') then begin
               Acount:=Members."No.";
                exit;
              end;
              Members.Reset;
              Members.SetRange(Members."Phone No.",'0'+CopyStr(phoneNo,4,15));
              if Members.Find('-') then begin
               Acount:=Members."No.";
                exit;
              end;
    end;


    procedure PaybillSwitchFailed(DocNo: Code[20]) Result: Code[20]
    begin
        begin
        PaybillTrans.Reset;
        //PaybillTrans.ASCENDING(FALSE);
        PaybillTrans.SetRange(PaybillTrans.Posted,false);
        PaybillTrans.SetRange(PaybillTrans."Document No", DocNo);
        //PaybillTrans.SETRANGE(PaybillTrans."Needs Manual Posting",FALSE);
        //PaybillTrans.SETFILTER("Transaction Date",'>=%1',20210512D);
          if PaybillTrans.Find('-') then begin
            Message(Format(PaybillTrans.Count));
            repeat
            if (CopyStr(PaybillTrans."Account No",1,3)='TEN') then begin
              Vendor.Reset;
              Vendor.SetRange("No.",CopyStr(PaybillTrans."Account No",1,20));
              if Vendor.Find('-') then
                Result:=PayBillToAccRent('PAYBILL',PaybillTrans."Document No",PaybillTrans."Account No",PaybillTrans."Account No",PaybillTrans.Amount,'RENT',PaybillTrans."PayBill No");
              end else begin
              Vendor.Reset;
              Vendor.SetRange("No.",PaybillTrans."Account No");
              if Vendor.Find('-') then begin
                Result:=PayBillToAcc('PAYBILL',PaybillTrans."Document No",PaybillTrans."Account No",PaybillTrans."Account No",PaybillTrans.Amount,'',PaybillTrans."PayBill No");
              end else begin
              LoansRegister.Reset;
              LoansRegister.SetRange("Loan  No.", PaybillTrans."Account No");
              if LoansRegister.Find('-') then begin
              Result:=PayBillToLoan('PAYBILL',PaybillTrans."Document No",PaybillTrans."Account No",PaybillTrans."Account No",PaybillTrans.Amount,'',PaybillTrans."PayBill No");
              end else  begin
              Members.Reset;
              Members.SetRange("No.",fngetmemberNo(PaybillTrans."Account No"));
              if Members.Find('-') then begin
              Result:=PayBillToBOSA('PAYBILL',PaybillTrans."Document No",Members."No.",Members."No.",PaybillTrans.Amount,PaybillTrans."Key Word",'',PaybillTrans."PayBill No");
              end;
              end;
              end


              end;
              if Result='' then begin
              PaybillTrans."Date Posted":=Today;
              PaybillTrans."Needs Manual Posting":=true;
              PaybillTrans.Description:='Failed';
              PaybillTrans.Modify;
              msg:='Dear ' +PaybillTrans."Account Name"+' Deposit of Ksh.'+ Format(PaybillTrans.Amount) +'will be credited to account: '+PaybillTrans."Account No"+'.';
              //Note that Short Codes have been updated, Please contact us.';

              SMSMessage('PAYBILLTRANS',PaybillTrans."Account No",PaybillTrans.Telephone,msg);

              end;
              until PaybillTrans.Next=0;
            end;
          end;
    end;


    procedure FnValidateTransaction(DOC_NO: Code[20];DESCRIPTION: Text[30])
    var
        CustLedg: Record "Member Ledger Entry";
        PTrans: Record "CloudPESA MPESA Trans";
    begin
        CustLedg.Reset;
        CustLedg.SetRange("Document No.",DOC_NO);
        CustLedg.SetRange(Description,DESCRIPTION);
        if CustLedg.FindFirst then begin
           Error('Transaction already posted!');
          end;
    end;


    procedure FnCheckDoublePosting(DOC_NO: Code[20]) resp: Text[10]
    var
        CustLedg: Record "Member Ledger Entry";
        PTrans: Record "CloudPESA MPESA Trans";
    begin
        resp:='POSTED'; // ** DEFENSIVE

        CustLedg.Reset;
        CustLedg.SetRange("Document No.",DOC_NO);
        if CustLedg.FindFirst then begin
          resp:='POSTED';
        end else begin
          resp:='NOTPOSTED';
        end;
    end;
}

