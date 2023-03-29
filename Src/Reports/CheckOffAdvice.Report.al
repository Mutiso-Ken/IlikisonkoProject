#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516475 "CheckOff Advice"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/CheckOff Advice.rdlc';

    dataset
    {
        dataitem("Member Register";"Member Register")
        {
            column(ReportForNavId_1000000000; 1000000000)
            {
            }

            trigger OnAfterGetRecord()
            begin
                  LoansRec.Reset;
                  LoansRec.SetRange(LoansRec."Client Code","Member Register"."No.");
                  LoansRec.SetRange(LoansRec."Loan Product Type",'NORMAL');
                  if LoansRec.Find('-') then begin
                    if LoansRec."Outstanding Balance">0 then begin
                      NormPr:=LoansRec."Loan Principle Repayment";
                      NormInt:=LoansRec."Loan Interest Repayment";
                     end;
                    end;

                  LoansRec.Reset;
                  LoansRec.SetRange(LoansRec."Client Code","Member Register"."No.");
                  LoansRec.SetRange(LoansRec."Loan Product Type",'EMERGENCY');
                  if LoansRec.Find('-') then begin
                    if LoansRec."Outstanding Balance">0 then begin
                      EmerPr:=LoansRec."Loan Principle Repayment";
                      EmerInt:=LoansRec."Loan Interest Repayment";
                     end;
                    end;

                  LoansRec.Reset;
                  LoansRec.SetRange(LoansRec."Client Code","Member Register"."No.");
                  LoansRec.SetRange(LoansRec."Loan Product Type",'COLLEGE');
                  if LoansRec.Find('-') then begin
                    if LoansRec."Outstanding Balance">0 then begin
                      CollegePr:=LoansRec."Loan Principle Repayment";
                      CollegeInt:=LoansRec."Loan Interest Repayment";
                     end;
                    end;

                  LoansRec.Reset;
                  LoansRec.SetRange(LoansRec."Client Code","Member Register"."No.");
                  LoansRec.SetRange(LoansRec."Loan Product Type",'TOP - UP');
                  if LoansRec.Find('-') then begin
                    if LoansRec."Outstanding Balance">0 then begin
                      TopupPr:=LoansRec."Loan Principle Repayment";
                      Topupint:=LoansRec."Loan Interest Repayment";
                     end;
                    end;

                  LoansRec.Reset;
                  LoansRec.SetRange(LoansRec."Client Code","Member Register"."No.");
                  LoansRec.SetRange(LoansRec."Loan Product Type",'School');
                  if LoansRec.Find('-') then begin
                    if LoansRec."Outstanding Balance">0 then begin
                      SchoolPr:=LoansRec."Loan Principle Repayment";
                      SchoolInt:=LoansRec."Loan Interest Repayment";
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
        LoansRec: Record "Loans Register";
        NormPr: Decimal;
        NormInt: Decimal;
        EmerPr: Decimal;
        EmerInt: Decimal;
        SchoolPr: Decimal;
        SchoolInt: Decimal;
        TopupPr: Decimal;
        Topupint: Decimal;
        CollegePr: Decimal;
        CollegeInt: Decimal;
        DefaulterPr: Decimal;
        DefaulterInt: Decimal;
}

