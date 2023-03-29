#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516986 "Guarantors Temp"
{

    fields
    {
        field(1;ID;Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2;"Loan No";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3;"Member Id";Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(4;"Amount Guaranteed";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5;"Member No";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(6;Name;Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;ID)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

