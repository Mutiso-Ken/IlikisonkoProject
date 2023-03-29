#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516357 "Dividends Register"
{

    fields
    {
        field(1;"Member No";Code[50])
        {
            TableRelation = "Member Register"."No.";
        }
        field(2;"Dividend year";Code[50])
        {
        }
        field(4;"Member Name";Code[250])
        {
        }
        field(8;"Gross Dividend";Decimal)
        {
        }
        field(9;"Withholding Tax";Decimal)
        {
        }
        field(10;"Net Dividend Payable";Decimal)
        {
        }
        field(11;"Qualifying Share Capital";Decimal)
        {
        }
        field(12;"Qualifying Deposits";Decimal)
        {
        }
        field(13;"Interest on Shares Capital";Decimal)
        {
        }
        field(14;"Interest on Deposits";Decimal)
        {
        }
        field(15;Capitalize;Boolean)
        {
        }
        field(16;Posted;Boolean)
        {
        }
        field(17;"Posting Date";Date)
        {
        }
        field(18;"Qualifying Holiday Savings";Decimal)
        {
        }
        field(19;"Interest on Holiday Savings";Decimal)
        {
        }
        field(20;"Outstanding Dividend Loan";Decimal)
        {
        }
        field(21;"Outstanding Dividend  Interest";Decimal)
        {
        }
        field(22;"Mode Of Disbursment";Option)
        {
            DataClassification = ToBeClassified;
            Editable = true;
            OptionCaption = 'Transfer to Cash Office,Tranfer to Deposits,EFT,Transfer to Withdrawable Savings,Transfer to Shares,Clear Loan';
            OptionMembers = "Transfer to Cash Office","Tranfer to Deposits",EFT,"Transfer to Withdrawable Savings","Transfer to Shares","Clear Loan";
        }
        field(23;"Document No";Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(24;"Banke Details";Code[20])
        {
            FieldClass = Normal;
        }
        field(25;"Withdrawable acc";Code[20])
        {
            CalcFormula = lookup(Vendor."No." where ("BOSA Account No"=field("Member No"),
                                                     "Vendor Posting Group"=const('WITHDRAWABLE')));
            FieldClass = FlowField;
        }
        field(26;"Savings Account";Code[20])
        {
            CalcFormula = lookup(Vendor."No." where ("BOSA Account No"=field("Member No"),
                                                     "Vendor Posting Group"=const('CURRENT')));
            FieldClass = FlowField;
        }
        field(27;"Div Sim";Decimal)
        {
            CalcFormula = sum("Member Ledger Entry"."Debit Amount" where ("Customer No."=field("Member No"),
                                                                          "Transaction Type"=const(Dividend),
                                                                          Reversed=const(false),
                                                                          "Document No."=const('DIV2018'),
                                                                          Description=filter('Dividend Pay*')));
            FieldClass = FlowField;
        }
        field(28;Grossfosa;Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(29;"Qualifying Fosa";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(30;capitalized;Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Member No","Dividend year")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnModify()
    begin
        if UserId <> 'AMOS'then begin
        Error('You cannot modify this');
        end
    end;
}

