#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516866 "Recover Loan Repayment Unalloc"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Recover Loan Repayment Unalloc.rdlc';

    dataset
    {
        dataitem("Member Register";"Member Register")
        {
            DataItemTableView = where("Un-allocated Funds"=filter(>0));
            column(ReportForNavId_1000000000; 1000000000)
            {
            }

            trigger OnAfterGetRecord()
            var
                FOSABalance: Decimal;
            begin
                //CALCFIELDS("Outstanding Balance","Interest Due","Oustanding Interest");
                FOSABalance:=0;
                RepaymentPeriod:=WorkDate;
                //RepaymentPeriod:=20170216D;

                ObjMember.Reset;
                ObjMember.SetRange(ObjMember."No.","No.");
                if ObjMember.Find('-') then begin
                ObjMember.CalcFields(ObjMember."Un-allocated Funds");
                AvailableBal:=(ObjMember."Un-allocated Funds");
                end;


                //FOSABalance:=FnGetAvailableBalance("Account No");
                FOSABalance:=AvailableBal;


                BosaSetUp.Get();
                RunBal:=FOSABalance;

                InterestAmount:=0;
                PrincipleAmount:=0;

                //All Loan Penalties
                if RunBal >0 then begin
                Loans.Reset;
                Loans.SetCurrentkey(Loans.Source,Loans."Client Code");
                //Loans.SETRANGE(Loans."Client Code","Client Code");
                Loans.SetRange(Loans."Client Code","No.");
                Loans.SetRange(Loans."Recovery Mode",Loans."recovery mode"::"Cash Deposit");
                if Loans.Find('-') then begin
                repeat
                Loans.CalcFields(Loans."Outstanding Balance",Loans."Interest Due",Loans."Loans Insurance",Loans."Oustanding Interest",Loans."Penalty Charged");

                if (Loans."Penalty Charged" > 0) and (RunBal >0) then begin
                LOustanding:=0;
                LineNo:=LineNo+10000;
                GeneralJnl.Init;
                GeneralJnl."Journal Template Name":='GENERAL';
                GeneralJnl."Journal Batch Name":='RECOVERY';
                GeneralJnl."Posting Date":=Today;
                GeneralJnl.Description:='Loan Penalty';
                GeneralJnl."Document No.":=Loans."Loan  No.";
                GeneralJnl."Line No.":=LineNo;
                GeneralJnl."Account No.":="No.";
                GeneralJnl."Account Type":=GeneralJnl."account type"::Member;
                GeneralJnl."Transaction Type":=GeneralJnl."transaction type"::"Auctioneer Paid";
                GeneralJnl."Loan No":=Loans."Loan  No.";
                if RunBal > Loans."Penalty Charged" then
                GeneralJnl.Amount:=(Loans."Penalty Charged"*-1)
                else
                GeneralJnl.Amount:=RunBal*-1;
                GeneralJnl."Shortcut Dimension 1 Code":='BOSA';
                //GeneralJnl."Bal. Account Type":=GeneralJnl."Bal. Account Type"::Vendor;
                //GeneralJnl."Bal. Account No.":="Account No";
                //GeneralJnl."Shortcut Dimension 2 Code":=SURESETPFactory.FnGetUserBranch();
                GeneralJnl.Insert;
                RunBal:=RunBal-GeneralJnl.Amount;
                end;
                until Loans.Next = 0;
                end;
                end;



                //Interest Due
                if RunBal >0 then begin
                Loans.Reset;
                Loans.SetCurrentkey(Loans.Source,Loans."Client Code");
                //Loans.SETRANGE(Loans."Client Code","Client Code");
                Loans.SetRange(Loans."Client Code","No.");
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
                GeneralJnl.Description:='AutoRec-Interest Paid';
                GeneralJnl."Document No.":='AutoR'+Format(Today);
                GeneralJnl."Line No.":=LineNo;
                GeneralJnl."Account Type":=GeneralJnl."account type"::Member;
                GeneralJnl."Account No.":="Member Register"."No.";
                GeneralJnl."Transaction Type":=GeneralJnl."transaction type"::"Insurance Contribution";
                GeneralJnl."Loan No":=Loans."Loan  No.";

                if RunBal > Loans."Oustanding Interest" then
                GeneralJnl.Amount:=(Loans."Oustanding Interest"*-1)
                else
                GeneralJnl.Amount:=RunBal*-1;
                InterestAmount:=GeneralJnl.Amount;
                GeneralJnl."Shortcut Dimension 1 Code":='BOSA';
                //GeneralJnl."Bal. Account Type":=GeneralJnl."Bal. Account Type"::Vendor;
                //GeneralJnl."Bal. Account No.":="Account No";
                //GeneralJnl."Shortcut Dimension 2 Code":=SURESETPFactory.FnGetUserBranch();
                if GeneralJnl.Amount<>0 then
                GeneralJnl.Insert;
                if GeneralJnl.Amount<0 then //BEGIN
                RunBal:=RunBal+GeneralJnl.Amount;
                //END;

                LineNo:=LineNo+10000;
                GeneralJnl.Init;
                GeneralJnl."Journal Template Name":='GENERAL';
                GeneralJnl."Journal Batch Name":='RECOVERY';
                GeneralJnl."Posting Date":=Today;
                GeneralJnl.Description:='AutoRec-Interest Paid';
                GeneralJnl."Document No.":='AutoR'+Format(Today);
                GeneralJnl."Line No.":=LineNo;
                GeneralJnl."Account Type":=GeneralJnl."account type"::Member;
                GeneralJnl."Account No.":="Member Register"."No.";
                GeneralJnl."Transaction Type":=GeneralJnl."transaction type"::"Loan Insurance Charged";
                GeneralJnl."Loan No":=Loans."Loan  No.";
                GeneralJnl.Amount:=InterestAmount*-1;
                GeneralJnl."Shortcut Dimension 1 Code":='BOSA';
                //GeneralJnl."Bal. Account Type":=GeneralJnl."Bal. Account Type"::Vendor;
                //GeneralJnl."Bal. Account No.":="Account No";
                //GeneralJnl."Shortcut Dimension 2 Code":=SURESETPFactory.FnGetUserBranch();
                if GeneralJnl.Amount<>0 then
                GeneralJnl.Insert;
                //GeneralJnl.Amount:=0;
                end;

                until Loans.Next = 0;
                end;
                end;

                //Loan Repayments

                if RunBal >0 then begin
                Loans.Reset;
                //Loans.SETCURRENTKEY(Loans.Source,Loans."Client Code");
                Loans.SetRange(Loans."Client Code","No.");
                if Loans.Find('-') then begin
                repeat
                Loans.CalcFields(Loans."Outstanding Balance",Loans."Interest Due",Loans."Loans Insurance",Loans."Oustanding Interest",Loans."Penalty Charged");
                LoanNo:=Loans."Loan  No.";

                //IF (Loans."Outstanding Balance" > 0) AND (RunBal >0) THEN BEGIN
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
                //MESSAGE('LastMonth is %1',LastMonth);
                //Get Scheduled Balance
                  LSchedule.Reset;
                  LSchedule.SetRange(LSchedule."Loan No.",Loans."Loan  No.");
                  //LSchedule.SETRANGE(LSchedule."Member No.","No.");
                  LSchedule.SetRange(LSchedule."Repayment Date",LastMonth);
                    if LSchedule.FindFirst then begin
                      ScheduledLoanBal:=LSchedule."Loan Amount";
                    end;
                //End Get Scheduled Balance
                //MESSAGE('ScheduledLoanBal is %1',ScheduledLoanBal);
                //Get Loan Bal as per the date filter
                  DateFilter:='..'+Format(LastMonth);
                  Loans.SetFilter(Loans."Date filter",DateFilter);
                      Loans.CalcFields(Loans."Outstanding Balance");
                      LBal:=Loans."Outstanding Balance";
                //End Get Loan Bal as per the date filter
                 LBal:=Loans."Outstanding Balance";
                //MESSAGE('LBal is %1',LBal);
                  //Amount in Arrears
                  Arrears:=ScheduledLoanBal-LBal;
                  if (Arrears>0) or (Arrears=0) then begin
                  Arrears:=0
                  end else
                  Arrears:=Arrears;
                  //End Amount in Arrears
                //MESSAGE('Arrears is %1',Arrears);

                Loans.CalcFields(Loans."Outstanding Balance",Loans."Interest Due",Loans."Loans Insurance",Loans."Oustanding Interest",Loans."Penalty Charged");
                if (Loans."Outstanding Balance" > 0 ) and (RunBal>0)then begin
                LineNo:=LineNo+10000;
                GeneralJnl.Init;
                GeneralJnl."Journal Template Name":='GENERAL';
                GeneralJnl."Journal Batch Name":='RECOVERY';
                GeneralJnl."Posting Date":=Today;
                GeneralJnl.Description:='AutoRec-Principal Repayment';
                GeneralJnl."Document No.":='Auto'+Format(Today);
                GeneralJnl."Line No.":=LineNo;
                GeneralJnl."Account No.":="No.";
                GeneralJnl."Account Type":=GeneralJnl."account type"::Member;
                GeneralJnl."Transaction Type":=GeneralJnl."transaction type"::"Interest Paid";
                GeneralJnl."Loan No":=Loans."Loan  No.";
                GeneralJnl.Amount:=Loans."Loan Principle Repayment"*-1;
                if RunBal > (Arrears*-1) then
                GeneralJnl.Amount:=(Arrears)
                else
                GeneralJnl.Amount:=RunBal*-1;
                PrincipleAmount:=GeneralJnl.Amount;
                GeneralJnl."Shortcut Dimension 1 Code":='BOSA';
                //GeneralJnl."Bal. Account Type":=GeneralJnl."Bal. Account Type"::Vendor;
                //GeneralJnl."Bal. Account No.":="Account No";
                //GeneralJnl."Shortcut Dimension 2 Code":=SURESETPFactory.FnGetUserBranch();
                if GeneralJnl.Amount<>0 then
                GeneralJnl.Insert;
                //IF GeneralJnl.Amount<0 THEN BEGIN
                RunBal:=RunBal+GeneralJnl.Amount;
                //END;


                LineNo:=LineNo+10000;
                GeneralJnl.Init;
                GeneralJnl."Journal Template Name":='GENERAL';
                GeneralJnl."Journal Batch Name":='RECOVERY';
                GeneralJnl."Posting Date":=Today;
                GeneralJnl.Description:='AutoRec-Principal Repayment';
                GeneralJnl."Document No.":='AutoR'+Format(Today);
                GeneralJnl."Line No.":=LineNo;
                GeneralJnl."Account No.":="No.";
                GeneralJnl."Account Type":=GeneralJnl."account type"::Member;
                GeneralJnl."Transaction Type":=GeneralJnl."transaction type"::"Loan Insurance Charged";
                GeneralJnl."Loan No":=Loans."Loan  No.";
                GeneralJnl.Amount:=PrincipleAmount*-1;
                GeneralJnl."Shortcut Dimension 1 Code":='BOSA';
                //GeneralJnl."Bal. Account Type":=GeneralJnl."Bal. Account Type"::Vendor;
                //GeneralJnl."Bal. Account No.":="Account No";
                //GeneralJnl."Shortcut Dimension 2 Code":=SURESETPFactory.FnGetUserBranch();
                if GeneralJnl.Amount<>0 then
                GeneralJnl.Insert;
                //GeneralJnl.Amount:=0;
                end;

                //END;
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
                END;*/

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
        ObjMember: Record "Member Register";
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
        LoansRec: Record "Loans Register";
        LoanNo: Code[20];
        LoanSchedule: Record "Loan Repayment Schedule";
        InterestAmount: Decimal;
        PrincipleAmount: Decimal;
}

