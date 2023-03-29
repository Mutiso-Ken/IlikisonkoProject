#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516393 "Dividends Progression"
{

    fields
    {
        field(1;"Member No";Code[20])
        {
        }
        field(2;Date;Date)
        {
        }
        field(3;"Gross Dividends";Decimal)
        {
        }
        field(4;"Witholding Tax";Decimal)
        {
        }
        field(5;"Net Dividends";Decimal)
        {
        }
        field(6;"Member Deposits";Decimal)
        {
        }
        field(7;"Qualifying Deposits";Decimal)
        {
        }
        field(8;"Interest on Deposits";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9;"W/T On Deposit Interest";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(51516150;"Share Capital";Decimal)
        {
        }
        field(51516151;"Qualifying Share Capital";Decimal)
        {
        }
        field(51516152;"Dividend on Share Capital";Decimal)
        {
        }
        field(51516153;source;Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'BOSA,FOSA';
            OptionMembers = BOSA,FOSA;
        }
        field(51516154;"Fosa Shares";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(51516155;"Qualifying FOSA Shares";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(51516156;"Interest on FOSA Shares";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(51516157;"W/T on Interest on FOSA Shares";Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(51516158;"W/T on Dividends";Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Member No",Date)
        {
            Clustered = true;
            SumIndexFields = "Gross Dividends","Net Dividends","Qualifying Deposits","Member Deposits","Witholding Tax";
        }
        key(Key2;Date)
        {
        }
    }

    fieldgroups
    {
    }
}

