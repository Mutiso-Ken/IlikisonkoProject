#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 50007 "Sacco Transfers"
{

    fields
    {
        field(1;No;Code[20])
        {

            trigger OnValidate()
            begin
                if No <> xRec.No then begin
                  NoSetup.Get(0);
                  NoSeriesMgt.TestManual(No);
                  "No. Series" := '';
                end;
            end;
        }
        field(2;"Transaction Date";Date)
        {
        }
        field(3;"Schedule Total";Decimal)
        {
            CalcFormula = sum("Sacco Transfers Schedule".Amount where ("No."=field(No)));
            FieldClass = FlowField;
        }
        field(4;Approved;Boolean)
        {
        }
        field(5;"Approved By";Code[10])
        {
        }
        field(6;Posted;Boolean)
        {
        }
        field(7;"No. Series";Code[20])
        {
        }
        field(8;"Responsibility Center";Code[10])
        {
        }
        field(9;Remarks;Code[30])
        {
        }
        field(10;"Source Account Type";Option)
        {
            OptionCaption = 'Customer,FOSA,Bank,G/L ACCOUNT,MEMBER';
            OptionMembers = Customer,FOSA,Bank,"G/L ACCOUNT",MEMBER;

            trigger OnValidate()
            begin
                if "Source Account"<>'' then
                  "Source Account":='';
                if "Source Account Type"="source account type"::MEMBER then
                  "Source Account":="Member No";
            end;
        }
        field(12;"Source Transaction Type";Option)
        {
            OptionCaption = ' ,Registration Fee,Share Capital,Interest Paid,Loan Repayment,Deposit Contribution,Insurance Contribution,Benevolent Fund,Loan,Unallocated Funds,Dividend,FOSA Account,Loan Insurance Paid,Loan Insurance Charged,FOSA Shares,Recovery Account,Additional Shares,Interest Due,CRB Fees,Ordinary Savings,Penalty Charged,Penalty Paid';
            OptionMembers = " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account","Loan Insurance Paid","Loan Insurance Charged","FOSA Shares","Recovery Account","Additional Shares","Interest Due","CRB Fees","Ordinary Savings","Penalty Charged","Penalty Paid";
        }
        field(13;"Source Account Name";Text[50])
        {
        }
        field(14;"Source Loan No";Code[20])
        {
            TableRelation = if ("Source Account Type"=filter(FOSA)) "Loans Register"."Loan  No." where ("Client Code"=field("Source Account"))
                            else if ("Source Account Type"=filter(MEMBER)) "Loans Register"."Loan  No." where ("Client Code"=field("Source Account"));
        }
        field(15;"Created By";Code[30])
        {
        }
        field(16;Debit;Text[30])
        {
            Editable = false;
        }
        field(17;Refund;Boolean)
        {
        }
        field(18;"Guarantor Recovery";Boolean)
        {
        }
        field(19;"Payrol No.";Code[30])
        {
        }
        field(20;"Global Dimension 1 Code";Code[10])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(1),
                                                          "Dimension Value Type"=const(Standard));
        }
        field(21;"Global Dimension 2 Code";Code[10])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(2),
                                                          "Dimension Value Type"=const(Standard));
        }
        field(22;"Bosa Number";Code[30])
        {
            Editable = false;
        }
        field(51516061;Status;Option)
        {
            OptionCaption = 'Open,Pending Approval,Approved,Rejected';
            OptionMembers = Open,"Pending Approval",Approved,Rejected;
        }
        field(51516062;"Savings Account Type";Code[30])
        {
            TableRelation = "Account Types-Saving Products".Code;
        }
        field(51516063;"Deposit Debit Options";Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Partial Refund,Loan Recovery,Posting Adjustment';
            OptionMembers = " ","Partial Refund","Loan Recovery","Posting Adjustment";
        }
        field(51516064;"Member No";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Member Register"."No.";

            trigger OnValidate()
            var
                ObjCust: Record "Member Register";
            begin
                if ObjCust.Get("Member No") then
                  begin
                    "Member Name":=ObjCust.Name;
                    end;
            end;
        }
        field(51516065;"Member Name";Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(51516066;"Header Amount";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(51516067;"Source Account";Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = if ("Source Account Type"=const(Customer)) Customer."No."
                            else if ("Source Account Type"=const(FOSA)) Vendor."No."
                            else if ("Source Account Type"=const(Bank)) "Bank Account"."No."
                            else if ("Source Account Type"=const("G/L ACCOUNT")) "G/L Account"."No."
                            else if ("Source Account Type"=const(MEMBER)) "Member Register"."No.";
        }
        field(51516068;Archived;Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if Approved or Posted then
           Error('Cannot delete posted or approved batch');
    end;

    trigger OnInsert()
    begin
         if No = '' then begin
          NoSetup.Get;
          NoSetup.TestField(NoSetup."BOSA Transfer Nos");
          NoSeriesMgt.InitSeries(NoSetup."BOSA Transfer Nos",xRec."No. Series",0D,No,"No. Series");
          end;
         "Transaction Date":=Today;
         "Created By":=UserId;
         Debit:='Credit';
    end;

    trigger OnModify()
    begin
        if Posted then
        Error('Cannot modify a posted batch');
    end;

    trigger OnRename()
    begin
        if Posted then
        Error('Cannot rename a posted batch');
    end;

    var
        NoSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Cust: Record Customer;
        Bank: Record "Bank Account";
        memb: Record "Member Register";
        "G/L": Record "G/L Account";
}

