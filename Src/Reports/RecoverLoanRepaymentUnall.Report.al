#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516865 "Recover Loan Repayment Unall"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Recover Loan Repayment Unall.rdlc';

    dataset
    {
        dataitem("Loans Register";"Loans Register")
        {
            RequestFilterFields = "Loan  No.","Client Code","Account No","Repayment Start Date","Date filter";
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
                
                
                
                //Interest Due
                if RunBal >0 then begin
                Loans.Reset;
                Loans.SetCurrentkey(Loans.Source,Loans."Client Code");
                Loans.SetRange(Loans."Loan  No.","Loan  No.");
                Loans.SetRange(Loans."Client Code","Client Code");
                //Loans.SETRANGE(Loans."Recovery Mode",Loans."Recovery Mode"::Pension);
                if Loans.Find('-') then begin
                    ObjMember.Reset;
                    ObjMember.SetRange(ObjMember."No.","Client Code");
                    if ObjMember.Find('-') then begin
                    ObjMember.CalcFields(ObjMember."Un-allocated Funds");
                    AvailableBal:=(ObjMember."Un-allocated Funds");
                    end;
                    //FOSABalance:=FnGetAvailableBalance("Account No");
                    FOSABalance:=AvailableBal;
                    BosaSetUp.Get();
                    RunBal:=FOSABalance;
                
                repeat
                Loans.CalcFields(Loans."Outstanding Balance",Loans."Interest Due",Loans."Loans Insurance",Loans."Oustanding Interest",Loans."Penalty Charged"); RunBal:=FOSABalance;
                RunBal:=FOSABalance;
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
                GeneralJnl."Transaction Type":=GeneralJnl."transaction type"::"Insurance Contribution";
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
                end;
                RunBal:=RunBal-GeneralJnl.Amount;
                Message('RunBal is %1',RunBal);
                until Loans.Next = 0;
                end;
                end;
                //END;
                /*
                //Loan Repayments
                MESSAGE('RunBal is %1',RunBal);
                IF RunBal >0 THEN BEGIN
                Loans.RESET;
                Loans.SETCURRENTKEY(Loans.Source,Loans."Client Code");
                Loans.SETRANGE(Loans."Loan  No.","Loan  No.");
                Loans.SETRANGE(Loans."Client Code",ObjMember."No.");
                //Loans.SETRANGE(Loans."Account No","Account No");
                //Loans.SETRANGE(Loans."Recovery Mode",Loans."Recovery Mode"::Pension);
                IF Loans.FIND('-') THEN BEGIN
                REPEAT
                
                //Get Last Day of the previous month
                IF Loans."Repayment Frequency"=Loans."Repayment Frequency"::Monthly THEN BEGIN
                  IF RepaymentPeriod=CALCDATE('CM',RepaymentPeriod) THEN BEGIN
                        LastMonth:=RepaymentPeriod;
                      END ELSE BEGIN
                        LastMonth:=CALCDATE('-1M',RepaymentPeriod);
                      END;
                    LastMonth:=CALCDATE('CM',LastMonth);
                 END;
                //End Get Last Day of the previous month
                
                //Get Scheduled Balance
                  LSchedule.RESET;
                  LSchedule.SETRANGE(LSchedule."Loan No.","Loan  No.");
                  LSchedule.SETRANGE(LSchedule."Repayment Date",LastMonth);
                    IF LSchedule.FINDFIRST THEN BEGIN
                      ScheduledLoanBal:=LSchedule."Loan Amount";
                    END;
                //End Get Scheduled Balance
                
                //Get Loan Bal as per the date filter
                  DateFilter:='..'+FORMAT(LastMonth);
                  Loans.RESET;
                  Loans.SETRANGE(Loans."Loan  No.","Loan  No.");
                  Loans.SETFILTER(Loans."Date filter",DateFilter);
                    IF Loans.FIND('-') THEN BEGIN
                      Loans.CALCFIELDS(Loans."Outstanding Balance");
                      LBal:=Loans."Outstanding Balance";
                    END;
                //End Get Loan Bal as per the date filter
                
                  //Amount in Arrears
                  Arrears:=ScheduledLoanBal-LBal;
                  IF (Arrears>0) OR (Arrears=0) THEN BEGIN
                  Arrears:=0
                  END ELSE
                  Arrears:=Arrears;
                  //End Amount in Arrears
                
                
                Loans.CALCFIELDS(Loans."Outstanding Balance",Loans."Interest Due",Loans."Loans Insurance",Loans."Oustanding Interest",Loans."Penalty Charged");
                IF (Loans."Outstanding Balance" > 0 ) AND (RunBal>0)THEN BEGIN
                LineNo:=LineNo+10000;
                GeneralJnl.INIT;
                GeneralJnl."Journal Template Name":='GENERAL';
                GeneralJnl."Journal Batch Name":='RECOVERY';
                GeneralJnl."Posting Date":=TODAY;
                GeneralJnl.Description:='Principal Repayment';
                GeneralJnl."Document No.":="Loan  No.";
                GeneralJnl."Line No.":=LineNo;
                GeneralJnl."Account No.":="Client Code";
                GeneralJnl."Account Type":=GeneralJnl."Account Type"::Member;
                GeneralJnl."Transaction Type":=GeneralJnl."Transaction Type"::Repayment;
                GeneralJnl."Loan No":=Loans."Loan  No.";
                GeneralJnl.Amount:=Loans."Loan Principle Repayment"*-1;
                IF RunBal > (Arrears*-1) THEN
                GeneralJnl.Amount:=(Arrears)
                ELSE
                GeneralJnl.Amount:=RunBal*-1;
                GeneralJnl."Shortcut Dimension 1 Code":='BOSA';
                GeneralJnl."Bal. Account Type":=GeneralJnl."Bal. Account Type"::Vendor;
                GeneralJnl."Bal. Account No.":="Account No";
                //GeneralJnl."Shortcut Dimension 2 Code":=SURESETPFactory.FnGetUserBranch();
                GeneralJnl.INSERT;
                RunBal:=RunBal-GeneralJnl.Amount;
                END;
                
                UNTIL Loans.NEXT = 0;
                END;
                END;*/
                //END;

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
        IntCharged: Decimal;
        PrincipleCharged: Decimal;
}

