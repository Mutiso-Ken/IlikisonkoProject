#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516363 "Member App Signatories"
{
    DrillDownPageID = "Membership App Signatories";
    LookupPageID = "Membership App Signatories";

    fields
    {
        field(1;"Account No";Code[20])
        {
            NotBlank = true;
        }
        field(2;Names;Text[50])
        {
            NotBlank = true;
        }
        field(3;"Date Of Birth";Date)
        {
        }
        field(4;"Staff/Payroll";Code[20])
        {
        }
        field(5;"ID No.";Code[50])
        {
            NotBlank = true;
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
        field(12;"BOSA No.";Code[30])
        {
            TableRelation = "Member Register"."No.";

            trigger OnValidate()
            begin
                if Cust.Get("BOSA No.") then begin
                  Names:=Cust.Name;
                  "ID No.":=Cust."ID No.";
                  "Email Address":=Cust."E-Mail (Personal)";
                  Picture:=Cust.Picture;
                  Signature:=Cust.Signature;
                  "Date Of Birth":=Cust."Date of Birth";
                  "Mobile No.":=Cust."Mobile Phone No";
                end;
            end;
        }
        field(13;"Email Address";Text[50])
        {
        }
        field(14;Designation;Code[20])
        {
            NotBlank = true;
        }
        field(15;"Mobile No.";Code[20])
        {
            NotBlank = true;
        }
        field(16;"Maximum Withdrawal";Decimal)
        {
        }
        field(17;"Signing Mandate Mandatory";Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Account No",Names,"BOSA No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Cust: Record "Member Register";
}

