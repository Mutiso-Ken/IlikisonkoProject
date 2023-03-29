#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516984 "Temp Fosa"
{

    fields
    {
        field(1;"Member Id";Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2;"Old No";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3;"BOSA No";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(4;Balance;Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5;"FOSA Account";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(6;"Account Name";Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(7;"Branch Code";Code[30])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Old No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

