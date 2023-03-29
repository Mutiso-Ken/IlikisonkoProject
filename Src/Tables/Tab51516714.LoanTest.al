#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516714 "LoanTest"
{

    fields
    {
        field(1;"Loan No";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2;Amount;Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Loan No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

