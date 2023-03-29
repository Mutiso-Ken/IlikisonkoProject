#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516604 "Arrears VS Paid"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Arrears VS Paid.rdlc';

    dataset
    {
        dataitem(Loans;"Loans Register")
        {
            DataItemTableView = where("Outstanding Balance"=filter(>0));
            column(ReportForNavId_1; 1)
            {
            }
            column(LoanNo_Loans;Loans."Loan  No.")
            {
            }
            column(ClientCode_Loans;Loans."Client Code")
            {
            }
            column(GroupCode_Loans;Loans."Group Code")
            {
            }
            column(ApprovedAmount_Loans;Loans."Approved Amount")
            {
            }
            column(ClientName_Loans;Loans."Client Name")
            {
            }
            column(IssuedDate_Loans;Loans."Issued Date")
            {
            }
            column(Installments_Loans;Loans.Installments)
            {
            }
            column(ScheduledAmount;ScheduledAmount)
            {
            }
            column(PrinciplePaid;PrinciplePaid)
            {
            }
            column(PrincipleArrears;PrinciplArrears)
            {
            }
            column(InterestArrears;InterestArrears)
            {
            }
            column(TotalArrears;TotalArrears)
            {
            }
            column(PrincipleAmount;PrincipleAmount)
            {
            }
            column(CompName;Company.Name)
            {
            }
            column(CompAddress;Company.Address)
            {
            }
            column(CompCity;Company.City)
            {
            }
            column(CompPicture;Company.Picture)
            {
            }
            column(InterestPaid;InterestPaid)
            {
            }
            column(LoanProductType_Loans;Loans."Loan Product Type")
            {
            }

            trigger OnAfterGetRecord()
            begin
                ScheduledAmount:=0;
                PrinciplePaid:=0;
                PrinciplArrears:=0;
                InterestArrears:=0;
                TotalArrears:=0;

                LSchedule.Reset;
                LSchedule.SetRange(LSchedule."Loan No.",Loans."Loan  No.");
                LSchedule.SetRange(LSchedule."Member No.",Loans."Client Code");
                LSchedule.SetFilter(LSchedule."Repayment Date",'<=%1',AsAt);
                if LSchedule.FindSet then
                begin
                LSchedule.CalcSums(LSchedule."Principal Repayment");
                ScheduledAmount:=LSchedule."Principal Repayment";
                end;

                Loans.CalcFields(Loans."Outstanding Balance",Loans."Oustanding Interest");
                PrinciplePaid:=Loans."Approved Amount"-Loans."Outstanding Balance";

                PrinciplArrears:=ScheduledAmount-PrinciplePaid;
                InterestArrears:=Loans."Oustanding Interest";
                TotalArrears:=InterestArrears+PrinciplArrears;


                PrincipleAmount:=0;


                MembL.Reset;
                MembL.SetRange(MembL."Customer No.",Loans."Client Code" );
                MembL.SetRange(MembL."Loan No",Loans."Loan  No.");
                MembL.SetFilter(MembL."Transaction Type",'%1',MembL."transaction type"::"Loan Repayment");
                MembL.SetFilter(MembL.Reversed,'%1',false);
                if MembL.FindSet then
                begin
                PostingDate:=Date2dmy(MembL."Posting Date",1);
                PostingMonth:=Date2dmy(MembL."Posting Date",2);
                PostingYear:=Date2dmy(MembL."Posting Date",3);

                CurrDay:=Date2dmy(AsAt,1);
                CurrMonth:=Date2dmy(AsAt,2);
                CurrYear:=Date2dmy(AsAt,3);

                if (PostingMonth=CurrMonth) and (PostingYear=CurrYear) then
                MembL.CalcSums(MembL.Amount);
                PrincipleAmount:=MembL.Amount;
                if PrincipleAmount<0 then
                PrincipleAmount:=PrincipleAmount*-1
                else
                PrincipleAmount:=0;
                end;

                InterestPaid:=0;
                MembLedge.Reset;
                MembLedge.SetRange(MembLedge."Customer No.",Loans."Client Code" );
                MembLedge.SetRange(MembLedge."Loan No",Loans."Loan  No.");
                MembLedge.SetFilter(MembLedge."Transaction Type",'%1',MembLedge."transaction type"::"Interest Paid");
                MembLedge.SetFilter(MembLedge.Reversed,'%1',false);
                if MembLedge.FindSet then
                begin
                PostingDate:=Date2dmy(MembLedge."Posting Date",1);
                PostingMonth:=Date2dmy(MembLedge."Posting Date",2);
                PostingYear:=Date2dmy(MembLedge."Posting Date",3);

                CurrDay:=Date2dmy(AsAt,1);
                CurrMonth:=Date2dmy(AsAt,2);
                CurrYear:=Date2dmy(AsAt,3);

                if (PostingMonth=CurrMonth) and (PostingYear=CurrYear) then
                MembLedge.CalcSums(MembLedge.Amount);
                InterestPaid:=MembLedge.Amount;
                if InterestPaid<0 then
                InterestPaid:=InterestPaid*-1
                else
                InterestPaid:=0;
                end;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(AsAt;AsAt)
                {
                    ApplicationArea = Basic;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        Company.Get;
        Company.CalcFields(Picture);
    end;

    var
        LSchedule: Record "Loan Repayment Schedule";
        ScheduledAmount: Decimal;
        PrinciplePaid: Decimal;
        PrinciplArrears: Decimal;
        InterestArrears: Decimal;
        TotalArrears: Decimal;
        AsAt: Date;
        MembL: Record "Member Ledger Entry";
        PrincipleAmount: Decimal;
        PostingDate: Integer;
        PostingMonth: Integer;
        PostingYear: Integer;
        CurrDay: Integer;
        CurrMonth: Integer;
        CurrYear: Integer;
        PaymentPeriod: DateFormula;
        Company: Record "Company Information";
        InterestPaid: Decimal;
        MembLedge: Record "Member Ledger Entry";
}

