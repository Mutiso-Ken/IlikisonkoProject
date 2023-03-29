#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516979 "House Occupation History"
{

    fields
    {
        field(1;"Entry No";Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2;"Property Code";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3;"House Code";Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(4;"Property Name";Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5;"House Name";Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6;"Tentant No";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7;"Tenant Name";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(8;"Tenant ID No";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9;"Tenant Phone No";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(10;"Date Reserved";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(11;"Date Allocated";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(12;"Date Vacated";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(13;"Entry Type";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Reservation,Occupation,Vacation';
            OptionMembers = " ",Reservation,Occupation,Vacation;
        }
        field(14;"Last Modified By";Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

