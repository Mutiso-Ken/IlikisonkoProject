#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516975 "Property"
{

    fields
    {
        field(1;No;Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if No <> xRec.No then begin
                  SalesSetup.Get;
                  NoSeriesMgt.TestManual(SalesSetup."Rental Nos");
                  "No. Series" := '';
                end;
            end;
        }
        field(2;Description;Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3;"Total Houses";Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(4;"Monthly Rent";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5;Location;Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Regions;
        }
        field(6;"Unit Prefix";Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(7;"Total Vacant";Integer)
        {
            CalcFormula = count(House where ("Property Code"=field(No),
                                             Status=filter(Vacant)));
            FieldClass = FlowField;
        }
        field(8;"Total Occupied";Integer)
        {
            CalcFormula = count(House where ("Property Code"=field(No),
                                             Status=filter(Occupied)));
            FieldClass = FlowField;
        }
        field(9;"Total Out of Order";Integer)
        {
            CalcFormula = count(House where ("Property Code"=field(No),
                                             Status=filter("Out of Order")));
            FieldClass = FlowField;
        }
        field(10;"Type of Structure";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Permanent,Temporary';
            OptionMembers = " ",Permanent,"Temporary";
        }
        field(11;"Owner No";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Member Register"."No.";

            trigger OnValidate()
            begin
                Vendor.Reset;
                Vendor.SetRange("No.","Owner No");
                if Vendor.Find('-') then begin
                  "Member Name":=Vendor.Name;
                end;
            end;
        }
        field(12;Vacant;Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(13;"Fully Occupied";Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(14;"Partially Occupied";Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(15;"Starting No";Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(16;"No. Series";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(17;"Rent Due Date";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = '1,2,3,4,5,6,7,8,9,10,11,12,13,14,15';
            OptionMembers = "1","2","3","4","5","6","7","8","9","10","11","12","13","14","15";
        }
        field(18;"Actively Managed";Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(19;"Effective Management Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(20;Type;Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Commercial,Residential,Commercial/Residential';
            OptionMembers = " ",Commercial,Residential,"Commercial/Residential";
        }
        field(21;"Rental Value";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(22;"Notice Period";Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(23;"Member Name";Text[100])
        {
            CalcFormula = lookup("Member Register".Name where ("No."=field("Owner No")));
            FieldClass = FlowField;
        }
        field(24;Contact;Code[30])
        {
            CalcFormula = lookup(Vendor."Phone No." where ("No."=field("Owner No")));
            FieldClass = FlowField;
        }
        field(25;"Rent Collection Account";Code[20])
        {
            CalcFormula = lookup(Vendor."No." where ("Vendor Posting Group"=const('RENT'),
                                                     "BOSA Account No"=field("Owner No")));
            FieldClass = FlowField;
        }
        field(26;"Total Reserved";Integer)
        {
            CalcFormula = count(House where ("Property Code"=field(No),
                                             Status=filter(Reserved)));
            FieldClass = FlowField;
        }
        field(27;"Expiry Date";Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Vendor.Reset;
                Vendor.SetRange("No.","Rent Collection Account");
                if Vendor.Find('-') then begin
                   Vendor."Rent Agreement Expiry Date":="Expiry Date";
                   Vendor.Modify();
                end;
            end;
        }
    }

    keys
    {
        key(Key1;No)
        {
            Clustered = true;
        }
        key(Key2;Description)
        {
        }
        key(Key3;"Monthly Rent")
        {
        }
        key(Key4;Location)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if No = '' then begin
          SalesSetup.Get;
          SalesSetup.TestField(SalesSetup."Rental Nos");
          NoSeriesMgt.InitSeries(SalesSetup."Rental Nos",xRec."No. Series",0D,No,"No. Series");
        end;
    end;

    var
        SalesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Vendor: Record Vendor;
}

