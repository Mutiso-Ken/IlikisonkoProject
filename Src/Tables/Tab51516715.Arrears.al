#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516715 "Arrears"
{

    fields
    {
        field(1;LoanNo;Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2;Balance;Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(3;Schedule;Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4;Arrears;Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5;Repayment;Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6;Months;Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7;Category;Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Perfoming,Watch,Substandard,Doubtful,Loss';
            OptionMembers = Perfoming,Watch,Substandard,Doubtful,Loss;
        }
        field(8;"Member No";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(9;"Member Name";Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(10;"Repayment Start Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(11;"Due Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(12;Instalments;Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(13;"Months In Arrears";Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;LoanNo)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

