#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 51516358 "Dividends Header"
{

    fields
    {
        field(1;"No.";Code[10])
        {
            Editable = false;

            trigger OnValidate()
            begin
                //*
                if "No." <> xRec."No." then begin
                  SeriesSetup.Get;
                  NoSeriesMgt.TestManual(SeriesSetup."Dividend Rate No.");
                  "No. Series" := '';
                end;
            end;
        }
        field(2;"Start Date";Date)
        {

            trigger OnValidate()
            begin
                 if xRec."Start Date"<>0D then
                   if Confirm(ConfirmChange,false) then
                      ClearDividendLines("No.")
                     else
                       Error(ExitProcessErr);
            end;
        }
        field(3;"End Date";Date)
        {

            trigger OnValidate()
            begin
                if xRec."End Date"<>0D then
                   if Confirm(ConfirmChange,false) then
                      ClearDividendLines("No.")
                     else
                       Error(ExitProcessErr);
            end;
        }
        field(4;Deposits;Decimal)
        {
            CalcFormula = sum("Dividend Simulation Lines".Amount where ("Document No."=field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(5;"Weighted Amount";Decimal)
        {
            CalcFormula = sum("Dividend Simulation Lines"."Weighted Amount" where ("Document No."=field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(6;"Total Payout";Decimal)
        {
            Editable = false;

            trigger OnValidate()
            begin
                /* CALCFIELDS(Deposits,"Weighted Amount");
                 IF (Deposits<>0) AND ("Weighted Amount"<>0) AND ("Total Payout"<> 0)  THEN
                    Rate:= ("Total Payout"/"Weighted Amount")*100;
                 */

            end;
        }
        field(7;Rate;Decimal)
        {

            trigger OnLookup()
            begin
                 /*CALCFIELDS(Deposits,"Weighted Amount");
                 IF (Deposits<>0) AND ("Weighted Amount"<>0) AND ("Total Payout"<> 0)  THEN
                    Rate:= ("Total Payout"/"Weighted Amount")*100;*/

            end;

            trigger OnValidate()
            begin
                TestField("All Products",false);

                DividendCalculationBuffer.Reset;
                DividendCalculationBuffer.SetRange(DividendCalculationBuffer."Document No.","No.");
                if DividendCalculationBuffer.FindSet then
                DividendCalculationBuffer.DeleteAll;
            end;
        }
        field(8;Status;Option)
        {
            Editable = false;
            OptionCaption = 'Open,Pending,Rejected,Approved,Transferred';
            OptionMembers = Open,Pending,Rejected,Approved,Transferred;
        }
        field(9;"Product Type";Code[10])
        {

            trigger OnValidate()
            var
                CustomerPostingGroup: Record "Customer Posting Group";
            begin
                /*IF ProductFactory.GET("Product Type") THEN BEGIN
                 "Product Name":= ProductFactory."Product Description";
                 IF CustomerPostingGroup.GET(ProductFactory."Product Posting Group") THEN
                 "G/L Account":=CustomerPostingGroup."Receivables Account";
                END;*/

            end;
        }
        field(10;"Product Name";Text[80])
        {
            Editable = false;
        }
        field(11;"Dividend Payable Account";Code[20])
        {
            Editable = true;
            TableRelation = "G/L Account";
        }
        field(12;"No. Series";Code[10])
        {
        }
        field(13;"Created By";Code[50])
        {
        }
        field(14;"All Products";Boolean)
        {
            TableRelation = "Account Types-Saving Products";

            trigger OnValidate()
            begin
                /*
                IF "All Products" THEN
                  Rate:=0;
                */

            end;
        }
        field(15;"Total Pay";Decimal)
        {
            CalcFormula = sum("Dividends Register"."Gross Dividend" where ("Document No"=field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(16;"Total W/Tax";Decimal)
        {
            CalcFormula = sum("Dividends Register"."Withholding Tax" where ("Document No"=field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(17;"Total Net";Decimal)
        {
            CalcFormula = sum("Dividends Register"."Net Dividend Payable" where ("Document No"=field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(18;"Total Loans";Decimal)
        {
            CalcFormula = sum("Dividends Register"."Outstanding Dividend Loan" where ("Document No"=field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(19;"Posting Date";Date)
        {
            DataClassification = ToBeClassified;
        }
        field(20;"Paying Bank (EFT)";Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account"."No.";
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
        //*
        if "No." = '' then begin
          SeriesSetup.Get;
          SeriesSetup.TestField(SeriesSetup."Dividend Rate No.");
          NoSeriesMgt.InitSeries(SeriesSetup."Dividend Rate No.",xRec."No. Series",0D,"No.","No. Series");
        end;

        "Created By":=UserId;
    end;

    var
        ExitProcessErr: label 'You have selected to abort process date Change will be rolled back';
        ConfirmChange: label 'The Change you want to will  affect any processed data do you wish to continue?';
        SeriesSetup: Record "Sacco No. Series";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        DividendCalculationBuffer: Record UnknownRecord51516642;

    local procedure ClearDividendLines(No: Code[20])
    var
        DividendSimulationLines: Record UnknownRecord51516642;
    begin
        DividendSimulationLines.Reset;
        DividendSimulationLines.SetRange(DividendSimulationLines."No.",No);
        if DividendSimulationLines.Find('-') then
            DividendSimulationLines.DeleteAll;
    end;
}

