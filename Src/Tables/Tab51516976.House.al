#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516976 "House"
{

    fields
    {
        field(1;"Property Code";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2;"House Code";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3;Status;Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Vacant,Occupied,Reserved,Out of Order';
            OptionMembers = Vacant,Occupied,Reserved,"Out of Order";
        }
        field(4;"House Rent";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5;"Reservation Remarks";Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6;"Reservation UserID";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7;"Reservation Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8;"Tenant No";Code[30])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Tenant.Reset;
                Tenant.SetRange(Tenant."No.","Tenant No");
                if Tenant.Find('-') then begin
                  "Phone No":=Tenant."Phone No.";
                  Modify;
                  end;
            end;
        }
        field(9;"Receipt No";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(10;"Notice Period";Integer)
        {
            CalcFormula = lookup(Property."Notice Period" where (No=field("Property Code")));
            FieldClass = FlowField;
        }
        field(11;"Date allocated";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(12;"Date Vacated";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(13;"Tenant Name";Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(14;"Entry No";Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(15;"Property Name";Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(16;"House Type";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Single,Bedsitter,Self Contained,Shop,Double';
            OptionMembers = Single,Bedsitter,"Self Contained",Shop,Double;
        }
        field(17;"Account No";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(18;"Due Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(19;No;Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(20;"ID No";Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(21;"House Status";Option)
        {
            DataClassification = ToBeClassified;
            Editable = true;
            OptionCaption = ' Active,Defaulted';
            OptionMembers = " Active",Defaulted;
        }
        field(22;"Phone No";Code[10])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Property Code","Entry No","House Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        hsLedger.Reset;
        hsLedger.SetRange(hsLedger."Rental No","Property Code");
        if hsLedger.Find('-') then begin
          Error('You cannot delete this house as it is still under occupied.Kindly clear the all the houses first.');
        end;

        hse.Reset;
        hse.SetRange(hse."Property Code","Property Code");
        if hse.Find('-') then begin
        hse.DeleteAll;
        end;

        hsLedger.Reset;
        hsLedger.SetRange(hsLedger."Rental No","Property Code");
        if hsLedger.Find('-') then begin
          hsLedger.DeleteAll;
        end;
    end;

    var
        hsLedger: Record "House Ledger Entries";
        hse: Record House;
        Tenant: Record Vendor;
}

