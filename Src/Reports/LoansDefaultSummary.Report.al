#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516976 "Loans Default Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Loans Default Summary.rdlc';

    dataset
    {
        dataitem("Loans Register";"Loans Register")
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(LoanProductType_LoansRegister;"Loans Register"."Loan Product Type")
            {
            }
            column(OustandingInterest_LoansRegister;"Loans Register"."Oustanding Interest")
            {
            }
            column(OutstandingBalance_LoansRegister;"Loans Register"."Outstanding Balance")
            {
            }
            column(LoanRep;LoanRep)
            {
            }
            column(IntrestRep;IntrestRep)
            {
            }
            column(Biasharabal;Biasharabal)
            {
            }
            column(Boreshabal;Boreshabal)
            {
            }
            column(Staffadvancebal;Staffadvancebal)
            {
            }
            column(Developmentbal;Developmentbal)
            {
            }
            column(Directcopbal;Directcopbal)
            {
            }
            column(Inukabal;Inukabal)
            {
            }
            column(Livestockbal;Livestockbal)
            {
            }
            column(Motorbal;Motorbal)
            {
            }
            column(Motorcyclebal;Motorcyclebal)
            {
            }
            column(Mshaharabal;Mshaharabal)
            {
            }
            column(Okoabal;Okoabal)
            {
            }
            column(Rentalsbal;Rentalsbal)
            {
            }
            column(Schoolfeesbal;Schoolfeesbal)
            {
            }
            column(Selfguaranteebal;Selfguaranteebal)
            {
            }
            column(Shorttermbal;Shorttermbal)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Boreshabal:=0;
                Developmentbal:=0;
                Directcopbal:=0;
                Inukabal:=0;
                Livestockbal:=0;
                Motorbal:=0;
                Motorcyclebal:=0;
                Mshaharabal:=0;
                Okoabal:=0;
                Rentalsbal:=0;
                Schoolfeesbal:=0;
                Selfguaranteebal:=0;
                Shorttermbal:=0;
                Staffadvancebal:=0;


                Loans.Reset;
                Loans.SetRange(Loans."Loan  No.","Loans Register"."Loan  No.");
                Loans.SetFilter(Loans."Outstanding Balance",'>%1',0);
                if Loans.FindSet then
                begin
                Loans.CalcFields(Loans."Outstanding Balance");
                Loans.CalcSums(Loans."Outstanding Balance");
                if Loans."Loan Product Type"='BORESHA' then
                Boreshabal:=Loans."Outstanding Balance"
                else if Loans."Loan Product Type"='DEVELOPMENT' then
                Developmentbal:=Loans."Outstanding Balance"
                else if Loans."Loan Product Type"='DIRECT CO-OP' then
                Directcopbal:=Loans."Outstanding Balance"
                else if Loans."Loan Product Type"='INUKA' then
                Inukabal:=Loans."Outstanding Balance"
                else if Loans."Loan Product Type"='LIVESTOCK' then
                Livestockbal:=Loans."Outstanding Balance"
                else if Loans."Loan Product Type"='MOTOR' then
                Motorbal:=Loans."Outstanding Balance"
                else if Loans."Loan Product Type"='MOTORCYCLE' then
                Motorcyclebal:=Loans."Outstanding Balance"
                else if Loans."Loan Product Type"='MSHAHARA' then
                Mshaharabal:=Loans."Outstanding Balance"
                else if Loans."Loan Product Type"='OKOA' then
                Okoabal:=Loans."Outstanding Balance"
                else if Loans."Loan Product Type"='RENTAL' then
                Rentalsbal:=Loans."Outstanding Balance"
                else if Loans."Loan Product Type"='SCHFEES' then
                Schoolfeesbal:=Loans."Outstanding Balance"
                else if Loans."Loan Product Type"='SELFGUARANTEE' then
                Selfguaranteebal:=Loans."Outstanding Balance"
                else if Loans."Loan Product Type"='SHORT TERM' then
                Shorttermbal:=Loans."Outstanding Balance"
                else if Loans."Loan Product Type"='STAFF ADVANCE' then
                Staffadvancebal:=Loans."Outstanding Balance";
                end;
            end;

            trigger OnPreDataItem()
            begin
                
                MemberLE.Reset;
                MemberLE.SetRange(MemberLE."Loan No","Loans Register"."Loan  No.");
                MemberLE.SetFilter(MemberLE."Transaction Type",'%1',MemberLE."transaction type"::"Loan Repayment");
                MemberLE.SetRange(MemberLE.Reversed,false);
                if MemberLE.Find('-') then begin
                  repeat
                  //MemberLE.CALCFIELDS(MemberLE."Credit Amount");
                  LoanRep:=LoanRep+MemberLE."Credit Amount";
                  until MemberLE.Next=0;
                end;
                
                MemberLE.Reset;
                MemberLE.SetRange(MemberLE."Loan No","Loans Register"."Loan  No.");
                MemberLE.SetFilter(MemberLE."Transaction Type",'%1',MemberLE."transaction type"::"Interest Paid");
                MemberLE.SetRange(MemberLE.Reversed,false);
                if MemberLE.Find('-') then begin
                  repeat
                  //MemberLE.CALCFIELDS(MemberLE."Credit Amount");
                  IntrestRep:=IntrestRep+MemberLE."Credit Amount";
                  until MemberLE.Next=0;
                end;
                
                
                
                
                
                
                
                
                
                
                
                /*Loans.RESET;
                Loans.SETRANGE(Loans."Loan  No.","Loans Register"."Loan  No.");
                Loans.SETFILTER(Loans."Outstanding Balance",'>%1',0);
                Loans.SETRANGE(Loans."Loan Product Type",'BIASHARA');
                IF Loans.FINDSET THEN
                 BEGIN
                  Loans.CALCFIELDS(Loans."Outstanding Balance");
                   Loans.CALCSUMS(Loans."Outstanding Balance");
                
                   Biasharabal:=0;
                   Biasharabal:=Loans."Outstanding Balance";
                   MESSAGE('%1',Biasharabal);
                  END;*/

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
        MemberLE: Record "Member Ledger Entry";
        LoanRep: Decimal;
        IntrestRep: Decimal;
        Loans: Record "Loans Register";
        Biasharabal: Decimal;
        Boreshabal: Decimal;
        Developmentbal: Decimal;
        Directcopbal: Decimal;
        Inukabal: Decimal;
        Livestockbal: Decimal;
        Motorbal: Decimal;
        Motorcyclebal: Decimal;
        Mshaharabal: Decimal;
        Okoabal: Decimal;
        Rentalsbal: Decimal;
        Schoolfeesbal: Decimal;
        Selfguaranteebal: Decimal;
        Shorttermbal: Decimal;
        Staffadvancebal: Decimal;
}

