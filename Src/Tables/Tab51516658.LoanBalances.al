#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516658 "Loan Balances"
{

    fields
    {
        field(1;LoanOne;Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                loansReg.CalcFields("Loan Product Type");
            end;
        }
        field(2;gvgtf;Decimal)
        {
            CalcFormula = sum("Loans Register"."Outstanding Balance" where ("Loan Product Type"=const('SHORT TEARM')));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1;LoanOne)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        loansReg: Record "Loans Register";
}

