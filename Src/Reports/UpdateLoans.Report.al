#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50023 "Update Loans"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Update Loans.rdlc';

    dataset
    {
        dataitem("Loans Register";"Loans Register")
        {
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                /*
                IF ObjProducts.GET("Loans Register"."Loan Product Type") THEN
                  BEGIN
                    "Loans Register".VALIDATE("Loans Register"."Loan Product Type");
                    "Loans Register".VALIDATE("Loans Register"."Client Code");
                    "Loans Register".Source:=ObjProducts.Source;
                   IF ObjProducts."Recovery Mode"=ObjProducts."Recovery Mode"::Checkoff THEN
                  "Loans Register"."Recovery Mode":="Loans Register"."Recovery Mode"::Checkoff;
                    IF ObjProducts."Recovery Mode"=ObjProducts."Recovery Mode"::Salary THEN
                   "Loans Register"."Recovery Mode":="Loans Register"."Recovery Mode"::Salary;
                    "Loans Register".MODIFY;
                  END
                  */
                  "Loans Register"."Disburesment Type":="Loans Register"."disburesment type"::"Full/Single disbursement";
                
                  if (("Loans Register"."Amount Disbursed" < "Loans Register"."Approved Amount") and ("Loans Register".Posted)) then
                  begin
                  "Loans Register"."Disburesment Type":="Loans Register"."disburesment type"::"Tranche/Multiple Disbursement";
                  end;
                  "Loans Register".Modify;

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
        ObjProducts: Record "Loan Products Setup";
}

