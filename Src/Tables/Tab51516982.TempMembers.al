#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516982 "Temp Members"
{

    fields
    {
        field(1;ID;Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2;"Old No";Code[30])
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
        field(5;City;Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6;Phone;Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(7;Branch;Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(8;"Posting Group";Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(9;county;Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(10;Email;Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(11;"Reg date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(12;Status;Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Active,Death,Resigned';
            OptionMembers = " ",Active,Death,Resigned;
        }
        field(13;"employer code";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(14;DOB;Date)
        {
            DataClassification = ToBeClassified;
        }
        field(15;"Marital Status";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Single,Divorced,Married,Separated,Widowed';
            OptionMembers = " ",Single,Divorced,Married,Separated,Widowed;
        }
        field(16;Gender;Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
        field(17;Region;Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(18;"Member Class";Text[50])
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

