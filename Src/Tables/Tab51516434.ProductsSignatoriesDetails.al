#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516434 "Products Signatories Details"
{

    fields
    {
        field(1;"Account No";Code[20])
        {
            NotBlank = true;
            TableRelation = Vendor."No.";
            ValidateTableRelation = false;
        }
        field(2;Names;Text[50])
        {
            NotBlank = true;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(3;"Date Of Birth";Date)
        {
        }
        field(4;"Staff/Payroll";Code[20])
        {
        }
        field(5;"ID No.";Code[50])
        {

            trigger OnValidate()
            begin
                CUST.Reset;
                CUST.SetRange(CUST."ID No.","ID No.");
                if CUST.Find('-')  then begin
                "BOSA No.":=CUST."No.";
                Modify;
                end;
            end;
        }
        field(6;Signatory;Boolean)
        {
        }
        field(7;"Must Sign";Boolean)
        {
        }
        field(8;"Must be Present";Boolean)
        {
        }
        field(9;Picture;MediaSet)
        {
            Caption = 'Picture';
        }
        field(10;Signature;MediaSet)
        {
            Caption = 'Signature';
        }
        field(11;"Expiry Date";Date)
        {
        }
        field(12;"Sections Code";Code[20])
        {
            TableRelation = Table51516159.Field1;
        }
        field(13;"Company Code";Code[20])
        {
            TableRelation = "HR Asset Transfer Header"."No.";
        }
        field(14;"BOSA No.";Code[30])
        {
            TableRelation = "Member Register"."No.";
        }
        field(15;"Email Address";Text[50])
        {
        }
    }

    keys
    {
        key(Key1;"Account No",Names)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        CUST: Record "Member Register";
}

