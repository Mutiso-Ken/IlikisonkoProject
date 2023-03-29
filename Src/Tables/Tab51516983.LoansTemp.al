#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516983 "Loans Temp"
{

    fields
    {
        field(1;"Loan No";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(2;"Member ID";Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3;"Application Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4;"Loan Product Type";Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5;Installments;Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(6;"Requested amount";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7;"Approved Amount";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8;"Issued Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9;"Amount Disbursed";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10;"Loans Category";Text[60])
        {
            DataClassification = ToBeClassified;
        }
        field(11;"Member No";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(12;"Outstanding Balance";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13;"Outstanding Interest";Decimal)
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

