#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516981 "House CheckList"
{

    fields
    {
        field(1;"Entry No";Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2;Item;Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "House Inventory".Code;

            trigger OnValidate()
            var
                HouseInventory: Record "House Inventory";
            begin
                HouseInventory.Reset;
                HouseInventory.SetRange(Code,Item);
                 if HouseInventory.FindFirst then
                 "Item Name":=HouseInventory."Item Name";
            end;
        }
        field(3;"Item Name";Text[100])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                HouseInventory: Record "House Inventory";
            begin
            end;
        }
        field(4;"Property Code";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Property.No;
        }
        field(5;"House Code";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = House."House Code" where ("Property Code"=field("Property Code"));
        }
        field(6;"Tenant No";Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7;Condition;Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Good,Out of Order';
            OptionMembers = " ",Good,"Out of Order";
        }
    }

    keys
    {
        key(Key1;"Entry No","Tenant No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

