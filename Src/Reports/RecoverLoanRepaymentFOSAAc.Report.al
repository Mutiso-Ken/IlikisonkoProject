#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516856 "Recover Loan Repayment FOSA Ac"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Recover Loan Repayment FOSA Ac.rdlc';

    dataset
    {
        dataitem("Loans Register";"Loans Register")
        {
            RequestFilterFields = "Loan  No.","Client Code","Account No","Repayment Start Date","Date filter","Loan Product Type";
            column(ReportForNavId_1000000000; 1000000000)
            {
            }
            column(LoanNo_LoansRegister;"Loans Register"."Loan  No.")
            {
            }
            column(ApprovedAmount_LoansRegister;"Loans Register"."Approved Amount")
            {
            }
            column(Interest_LoansRegister;"Loans Register".Interest)
            {
            }

            trigger OnAfterGetRecord()
            var
                FOSABalance: Decimal;
            begin
                CalcFields("Outstanding Balance","Interest Due","Oustanding Interest");
                FOSABalance:=0;
                RepaymentPeriod:=WorkDate;
                //RepaymentPeriod:=20170216D;

                ObjVendors.Reset;
                ObjVendors.SetRange(ObjVendors."No.","Account No");
                if ObjVendors.Find('-') then begin
                ObjVendors.CalcFields(ObjVendors.Balance,ObjVendors."Uncleared Cheques");
                AvailableBal:=(ObjVendors.Balance-ObjVendors."Uncleared Cheques");

                ObjAccTypes.Reset;
                ObjAccTypes.SetRange(ObjAccTypes.Code,ObjVendors."Account Type");
                if ObjAccTypes.Find('-') then
                AvailableBal:=AvailableBal-ObjAccTypes."Minimum Balance";
                end;


                //FOSABalance:=FnGetAvailableBalance("Account No");
                FOSABalance:=AvailableBal;



                BosaSetUp.Get();
                RunBal:=FOSABalance;



                // //All Loan Penalties
                // IF RunBal >0 THEN BEGIN
                // Loans.RESET;
                // Loans.SETCURRENTKEY(Loans.Source,Loans."Client Code");
                // //Loans.SETRANGE(Loans."Client Code","Client Code");
                // Loans.SETRANGE(Loans."Account No","Account No");
                // Loans.SETRANGE(Loans."Recovery Mode",Loans."Recovery Mode"::"Cash Deposit");
                // IF Loans.FIND('-') THEN BEGIN
                // REPEAT
                // Loans.CALCFIELDS(Loans."Outstanding Balance",Loans."Interest Due",Loans."Loans Insurance",Loans."Oustanding Interest",Loans."Penalty Charged");
                //
                // IF (Loans."Penalty Charged" > 0) AND (RunBal >0) THEN BEGIN
                // LOustanding:=0;
                // LineNo:=LineNo+10000;
                // GeneralJnl.INIT;
                // GeneralJnl."Journal Template Name":='GENERAL';
                // GeneralJnl."Journal Batch Name":='RECOVERY';
                // GeneralJnl."Posting Date":=TODAY;
                // GeneralJnl.Description:='Loan Penalty';
                // GeneralJnl."Document No.":="Loan  No.";
                // GeneralJnl."Line No.":=LineNo;
                // GeneralJnl."Account No.":="Client Code";
                // GeneralJnl."Account Type":=GeneralJnl."Account Type"::Member;
                // GeneralJnl."Transaction Type":=GeneralJnl."Transaction Type"::"23";
                // GeneralJnl."Loan No":=Loans."Loan  No.";
                // IF RunBal > Loans."Penalty Charged" THEN
                // GeneralJnl.Amount:=(Loans."Penalty Charged"*-1)
                // ELSE
                // GeneralJnl.Amount:=RunBal*-1;
                // GeneralJnl."Shortcut Dimension 1 Code":='BOSA';
                // GeneralJnl."Bal. Account Type":=GeneralJnl."Bal. Account Type"::Vendor;
                // GeneralJnl."Bal. Account No.":="Account No";
                // //GeneralJnl."Shortcut Dimension 2 Code":=SURESETPFactory.FnGetUserBranch();
                // GeneralJnl.INSERT;
                // RunBal:=RunBal-GeneralJnl.Amount;
                // END;
                // UNTIL Loans.NEXT = 0;
                // END;
                // END;



                //Interest Due
                if RunBal >0 then begin
                Loans.Reset;
                Loans.SetCurrentkey(Loans.Source,Loans."Client Code");
                Loans.SetRange(Loans."Loan  No.","Loan  No.");
                Loans.SetRange(Loans."Account No","Account No");
                //Loans.SETRANGE(Loans."Recovery Mode",Loans."Recovery Mode"::Pension);
                if Loans.Find('-') then begin
                repeat
                Loans.CalcFields(Loans."Outstanding Balance",Loans."Interest Due",Loans."Loans Insurance",Loans."Oustanding Interest",Loans."Penalty Charged");

                if (Loans."Oustanding Interest" > 0) and (RunBal >0) then begin
                LOustanding:=0;
                LineNo:=LineNo+10000;
                GeneralJnl.Init;
                GeneralJnl."Journal Template Name":='GENERAL';
                GeneralJnl."Journal Batch Name":='RECOVERY';
                GeneralJnl."Posting Date":=Today;
                GeneralJnl.Description:='Interest Due';
                GeneralJnl."Document No.":="Loan  No.";
                GeneralJnl."Line No.":=LineNo;
                GeneralJnl."Account Type":=GeneralJnl."account type"::Member;
                GeneralJnl."Account No.":="Client Code";
                GeneralJnl."Transaction Type":=GeneralJnl."transaction type"::"Interest Paid";
                GeneralJnl."Loan No":=Loans."Loan  No.";

                if RunBal > Loans."Oustanding Interest" then
                GeneralJnl.Amount:=(Loans."Oustanding Interest"*-1)
                else
                GeneralJnl.Amount:=RunBal*-1;
                GeneralJnl."Shortcut Dimension 1 Code":='BOSA';
                GeneralJnl."Bal. Account Type":=GeneralJnl."bal. account type"::Vendor;
                GeneralJnl."Bal. Account No.":="Account No";
                //GeneralJnl."Shortcut Dimension 2 Code":=SURESETPFactory.FnGetUserBranch();
                GeneralJnl.Insert;
                RunBal:=RunBal+GeneralJnl.Amount;
                end;

                until Loans.Next = 0;
                end;
                end;

                //Loan Repayments


                if RunBal >0 then begin

                Loans.Reset;
                Loans.SetCurrentkey(Loans.Source,Loans."Client Code");
                Loans.SetRange(Loans."Loan  No.","Loan  No.");
                Loans.SetRange(Loans."Account No","Account No");
                if Loans.Find('-') then begin
                repeat
                Loans.CalcFields(Loans."Outstanding Balance");
                if (Loans."Outstanding Balance" > 0 ) then begin
                //Get Last Day of the previous month
                if Loans."Repayment Frequency"=Loans."repayment frequency"::Monthly then begin
                  if RepaymentPeriod=CalcDate('CM',RepaymentPeriod) then begin
                        LastMonth:=RepaymentPeriod;
                      end else begin
                        LastMonth:=CalcDate('-1M',RepaymentPeriod);
                      end;
                    LastMonth:=CalcDate('CM',LastMonth);
                 end;

                //End Get Last Day of the previous month

                //Get Scheduled Balance
                  LSchedule.Reset;
                  LSchedule.SetRange(LSchedule."Loan No.","Loan  No.");
                  LSchedule.SetRange(LSchedule."Repayment Date",LastMonth);
                    if LSchedule.FindFirst then begin
                      ScheduledLoanBal:=LSchedule."Loan Amount";
                    end;
                //End Get Scheduled Balance

                //Get Loan Bal as per the date filter
                  DateFilter:='..'+Format(LastMonth);
                  Loans.Reset;
                  Loans.SetRange(Loans."Loan  No.","Loan  No.");
                  Loans.SetFilter(Loans."Date filter",DateFilter);
                    if Loans.Find('-') then begin
                      Loans.CalcFields(Loans."Outstanding Balance");
                      LBal:=Loans."Outstanding Balance";
                    end;
                //End Get Loan Bal as per the date filter

                  //Amount in Arrears
                  Arrears:=ScheduledLoanBal-LBal;
                  if (Arrears>0) or (Arrears=0) then begin
                  Arrears:=0
                  end else
                  Arrears:=Arrears;
                  //End Amount in Arrears


                Loans.CalcFields(Loans."Outstanding Balance",Loans."Interest Due",Loans."Loans Insurance",Loans."Oustanding Interest",Loans."Penalty Charged");
                if (Loans."Outstanding Balance" > 0 ) and (RunBal>0)then begin
                LineNo:=LineNo+10000;
                GeneralJnl.Init;
                GeneralJnl."Journal Template Name":='GENERAL';
                GeneralJnl."Journal Batch Name":='RECOVERY';
                GeneralJnl."Posting Date":=Today;
                GeneralJnl.Description:='Principal Repayment';
                GeneralJnl."Document No.":="Loan  No.";
                GeneralJnl."Line No.":=LineNo;
                GeneralJnl."Account No.":="Client Code";
                GeneralJnl."Account Type":=GeneralJnl."account type"::Member;
                GeneralJnl."Transaction Type":=GeneralJnl."transaction type"::"Interest Paid";
                GeneralJnl."Loan No":=Loans."Loan  No.";
                GeneralJnl.Amount:=Loans."Loan Principle Repayment"*-1;
                if RunBal > (Arrears*-1) then
                GeneralJnl.Amount:=(Arrears)
                else
                GeneralJnl.Amount:=RunBal*-1;
                GeneralJnl."Shortcut Dimension 1 Code":='BOSA';
                GeneralJnl."Bal. Account Type":=GeneralJnl."bal. account type"::Vendor;
                GeneralJnl."Bal. Account No.":="Account No";
                //GeneralJnl."Shortcut Dimension 2 Code":=SURESETPFactory.FnGetUserBranch();
                GeneralJnl.Insert;
                RunBal:=RunBal-GeneralJnl.Amount;
                end;
                end;
                until Loans.Next = 0;
                end;
                end;
            end;

            trigger OnPostDataItem()
            begin
                /*GeneralJnl.RESET;
                GeneralJnl.SETRANGE(GeneralJnl."Journal Template Name",'GENERAL');
                GeneralJnl.SETRANGE(GeneralJnl."Journal Batch Name",'RECOVERY');
                IF GeneralJnl.FIND('-') THEN BEGIN
                CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Sacco",GeneralJnl);
                END;
                */

            end;

            trigger OnPreDataItem()
            begin
                GeneralJnl.Reset;
                GeneralJnl.SetRange(GeneralJnl."Journal Template Name",'GENERAL');
                GeneralJnl.SetRange(GeneralJnl."Journal Batch Name",'RECOVERY');
                if GeneralJnl.Find('-') then
                GeneralJnl.DeleteAll;
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
        Loans: Record "Loans Register";
        ReceiptAllocations: Record "Receipt Allocation";
        ObjVendors: Record Vendor;
        ObjAccTypes: Record "Account Types-Saving Products";
        AvailableBal: Decimal;
        NoSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        InterestDueAmt: Decimal;
        PrincipleRepaymentAmt: Decimal;
        GeneralJnl: Record "Gen. Journal Line";
        BosaSetUp: Record "Sacco General Set-Up";
        RunBal: Decimal;
        Cust: Record "Member Register";
        LOustanding: Decimal;
        LineNo: Integer;
        RepaymentPeriod: Date;
        LastMonth: Date;
        LSchedule: Record "Loan Repayment Schedule";
        ScheduledLoanBal: Decimal;
        DateFilter: Text[100];
        LBal: Decimal;
        Arrears: Decimal;

    local procedure FnGetAvailableBalance(AccountNo: Code[50]) AvBalance: Decimal
    begin
        ObjVendors.Reset;
        ObjVendors.SetRange(ObjVendors."No.",AccountNo);
        if ObjVendors.Find('-') then begin
        ObjVendors.CalcFields(ObjVendors.Balance,ObjVendors."Uncleared Cheques");
        AvailableBal:=(ObjVendors.Balance-ObjVendors."Uncleared Cheques");

        ObjAccTypes.Reset;
        ObjAccTypes.SetRange(ObjAccTypes.Code,ObjVendors."Account Type");
        if ObjAccTypes.Find('-') then
        AvailableBal:=AvailableBal-ObjAccTypes."Minimum Balance";
        end;
        AvBalance:=AvailableBal;
        exit(AvBalance);
    end;
}

