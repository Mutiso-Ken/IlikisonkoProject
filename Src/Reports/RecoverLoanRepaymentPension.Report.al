#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516857 "Recover Loan Repayment Pension"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Recover Loan Repayment Pension.rdlc';

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



                //All Loan Penalties
                if RunBal >0 then begin
                Loans.Reset;
                Loans.SetCurrentkey(Loans.Source,Loans."Client Code");
                //Loans.SETRANGE(Loans."Client Code","Client Code");
                Loans.SetRange(Loans."Account No","Account No");
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
                GeneralJnl."Document No.":="Loan  No.";
                GeneralJnl."Line No.":=LineNo;
                GeneralJnl."Account No.":="Client Code";
                GeneralJnl."Account Type":=GeneralJnl."account type"::Member;
                GeneralJnl."Transaction Type":=GeneralJnl."transaction type"::"Auctioneer Paid";
                GeneralJnl."Loan No":=Loans."Loan  No.";
                if RunBal > Loans."Penalty Charged" then
                GeneralJnl.Amount:=(Loans."Penalty Charged"*-1)
                else
                GeneralJnl.Amount:=RunBal*-1;
                GeneralJnl."Shortcut Dimension 1 Code":='BOSA';
                GeneralJnl."Bal. Account Type":=GeneralJnl."bal. account type"::Vendor;
                GeneralJnl."Bal. Account No.":="Account No";
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
                Loans.SetRange(Loans."Account No","Account No");
                Loans.SetRange(Loans."Recovery Mode",Loans."recovery mode"::"Cash Deposit");
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
                RunBal:=RunBal-GeneralJnl.Amount;
                end;

                until Loans.Next = 0;
                end;
                end;

                //Loan Repayments

                if RunBal >0 then begin

                Loans.Reset;
                Loans.SetCurrentkey(Loans.Source,Loans."Client Code");
                //Loans.SETRANGE(Loans."Client Code","Client Code");
                Loans.SetRange(Loans."Account No","Account No");
                Loans.SetRange(Loans."Recovery Mode",Loans."recovery mode"::"Cash Deposit");
                if Loans.Find('-') then begin
                repeat
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
                if RunBal > Loans."Loan Principle Repayment" then
                GeneralJnl.Amount:=(Loans."Loan Principle Repayment"*-1)
                else
                GeneralJnl.Amount:=RunBal*-1;
                GeneralJnl."Shortcut Dimension 1 Code":='BOSA';
                GeneralJnl."Bal. Account Type":=GeneralJnl."bal. account type"::Vendor;
                GeneralJnl."Bal. Account No.":="Account No";
                //GeneralJnl."Shortcut Dimension 2 Code":=SURESETPFactory.FnGetUserBranch();
                GeneralJnl.Insert;
                RunBal:=RunBal-GeneralJnl.Amount;
                end;

                until Loans.Next = 0;
                end;
                end;
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

