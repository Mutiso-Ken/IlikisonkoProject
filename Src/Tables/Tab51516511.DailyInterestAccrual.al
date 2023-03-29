#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516511 "Daily Interest Accrual"
{

    fields
    {
        field(1;Entry;Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2;"Loan No";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3;"Date Entered";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4;"OutStanding Balance";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5;"Interest Charged";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6;"Cumulative Interest";Decimal)
        {
            CalcFormula = sum("Daily Interest Accrual"."Interest Charged" where ("Loan No"=field("Loan No"),
                                                                                 Posted=const(false)));
            FieldClass = FlowField;
        }
        field(7;Posted;Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(8;"Date Posted";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9;"Loan Type";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(10;"Client Code";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(11;"Interest Rate";Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;Entry)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

