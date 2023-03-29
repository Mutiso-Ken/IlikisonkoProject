#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516977 "House Ledger Entries"
{

    fields
    {
        field(1;No;Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2;"House No";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3;Status;Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Vacant,Occupied,Reserved,Out of Order';
            OptionMembers = Vacant,Occupied,Reserved,"Out of Order";
        }
        field(4;"Monthly Rent";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5;"Tenant No";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6;"Receipt No";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7;Gender;Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
        field(8;"Reservation UserID";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(9;"Reservation Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(10;"User ID";Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(11;"Rental No";Code[30])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;No,"House No","Rental No")
        {
            Clustered = true;
        }
        key(Key2;"Rental No")
        {
        }
        key(Key3;"Tenant No")
        {
        }
        key(Key4;"House No")
        {
        }
        key(Key5;Status)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
         Clear(counts);
         LedgerHistory.Reset;
         if LedgerHistory.Find('-') then begin
          counts:=LedgerHistory.Count;
         end;

         House.Reset;
         House.SetRange(House."Property Code","Rental No");
         House.SetRange(House."House Code","House No");
         if House.Find('-') then begin
         House.Status:=House.Status::Vacant;
         House."Tenant No":='';
         House."Receipt No":='';
         House.Modify;

         LedgerHistory.Init;
         LedgerHistory."House No":="House No";
         LedgerHistory."Rental No":="Rental No";
         LedgerHistory.No:=counts+1;
         LedgerHistory.Status:=LedgerHistory.Status::Occupied;
         LedgerHistory."Monthly Rent":="Monthly Rent";
         LedgerHistory."Tenant No":="Tenant No";
         LedgerHistory."Receipt No":="Receipt No";
         LedgerHistory."Reservation UserID":="Reservation UserID";
         LedgerHistory."Reservation Date":="Reservation Date";
         LedgerHistory.Gender:=Gender;
         LedgerHistory.Insert;
         end;
    end;

    var
        LedgerHistory: Record "House Ledger Entries";
        counts: Integer;
        House: Record House;
}

