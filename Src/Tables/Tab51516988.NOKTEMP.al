#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516988 "NOK-TEMP"
{

    fields
    {
        field(1;entry;Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2;"ID NO";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3;Name;Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4;Address;Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5;Phone;Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6;Relationship;Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(7;percentage;Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8;"Memeber ID";Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;entry)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

