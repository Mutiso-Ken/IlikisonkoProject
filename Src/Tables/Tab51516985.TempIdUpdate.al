#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516985 "Temp Id Update"
{

    fields
    {
        field(1;"Member Id";Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2;ID;Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3;Phone;Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Member Id")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

