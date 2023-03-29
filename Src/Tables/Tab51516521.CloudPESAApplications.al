#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516521 "CloudPESA Applications"
{

    fields
    {
        field(1;"No.";Code[50])
        {
            Editable = false;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                  SaccoNoSeries.Get;
                  NoSeriesMgt.TestManual(SaccoNoSeries."Cloudpesa Reg No.");
                  "No. Series" := '';
                end;
            end;
        }
        field(2;"Account No";Code[30])
        {
            Editable = true;
            TableRelation = Vendor."No.";

            trigger OnValidate()
            begin
                if Accounts.Get("Account No") then begin
                "Account Name":=Accounts.Name;
                "ID No":=Accounts."ID No.";
                Telephone:=Accounts."Mobile Phone No"


                end;
            end;
        }
        field(3;"Account Name";Text[50])
        {
            Editable = false;
            Enabled = true;
        }
        field(4;Telephone;Code[20])
        {
            Editable = false;
            Enabled = true;
        }
        field(5;"ID No";Code[20])
        {
            Editable = false;
            Enabled = true;
        }
        field(6;Status;Option)
        {
            Editable = false;
            Enabled = true;
            OptionCaption = 'Application, Pending Approval,Approved,Rejected';
            OptionMembers = Application," Pending Approval",Approved,Rejected;
        }
        field(7;"Date Applied";Date)
        {
            Editable = false;
            Enabled = true;
        }
        field(8;"Time Applied";Time)
        {
            Editable = false;
            Enabled = true;
        }
        field(9;"Created By";Code[50])
        {
            Editable = false;
        }
        field(10;Sent;Boolean)
        {
            Editable = false;
        }
        field(11;"No. Series";Code[50])
        {
            Editable = false;
            TableRelation = "No. Series";
        }
        field(12;SentToServer;Boolean)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1;"No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        if "No." = '' then begin
          SaccoNoSeries.Get;
          SaccoNoSeries.TestField(SaccoNoSeries."Cloudpesa Reg No.");
          NoSeriesMgt.InitSeries(SaccoNoSeries."Cloudpesa Reg No.",xRec."No. Series",0D,"No.","No. Series");
        end;


        "Time Applied":= Time;
        "Created By":= UserId;
        "Date Applied":=Today;
    end;

    var
        SaccoNoSeries: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Accounts: Record Vendor;
}

