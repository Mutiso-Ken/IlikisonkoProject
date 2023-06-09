#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516107 "Supplierwise Item Rct Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Supplierwise Item Rct Summary.rdlc';

    dataset
    {
        dataitem("Purch. Rcpt. Line";"Purch. Rcpt. Line")
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(Vend_No;"Purch. Rcpt. Line"."Buy-from Vendor No.")
            {
            }
            column(Item_No;"Purch. Rcpt. Line"."No.")
            {
            }
            column(Quantity;"Purch. Rcpt. Line".Quantity)
            {
            }
            column(UOM;"Purch. Rcpt. Line"."Unit of Measure")
            {
            }
            column(Unit_cost;"Purch. Rcpt. Line"."Direct Unit Cost")
            {
            }
            column(Amount;"Purch. Rcpt. Line"."VAT Base Amount")
            {
            }
            column(Item_Description;"Purch. Rcpt. Line".Description)
            {
            }
            column(Location;"Purch. Rcpt. Line"."Location Code")
            {
            }
            column(Company_Name;CompName)
            {
            }
            column(Vendor_Name;VendName)
            {
            }
            column(EndDate;EndDate)
            {
            }
            column(StartDate;StartDate)
            {
            }
            column(P_Date;"Purch. Rcpt. Line"."Posting Date")
            {
            }
            column(Category;"Purch. Rcpt. Line"."Item Category Code")
            {
            }
            column(Product_Group;"Purch. Rcpt. Line"."Product Group Code")
            {
            }

            trigger OnAfterGetRecord()
            begin
                if "Purch. Rcpt. Line".Quantity=0 then
                CurrReport.Skip;
                Reset;
                SetRange("Purch. Rcpt. Line"."Posting Date",StartDate,EndDate);


                Vend.Reset;
                Vend.SetRange(Vend."No.","Purch. Rcpt. Line"."Buy-from Vendor No.");
                if Vend.Find ('-') then
                VendName:=Vend.Name;
            end;

            trigger OnPreDataItem()
            begin
                 /*DimValue.RESET;
                 DimValue.SETRANGE(DimValue.Code,"Store Requistion Lines"."Shortcut Dimension 1 Code");
                 IF DimValue.FIND ('-') THEN
                 Branch:=DimValue.Name;
                
                 DimValue.RESET;
                 DimValue.SETRANGE(DimValue.Code,"Store Requistion Lines"."Shortcut Dimension 2 Code");
                 IF DimValue.FIND ('-') THEN
                  CostCenter:=DimValue.Name;
                 */
                if CompInfo.Get then
                CompName:=CompInfo.Name;
                //if Vend.get("Purchase Line"."Buy-from Vendor No.") then
                //VendName:=Vend.Name;
                /*IF EndDate=0D THEN
                EndDate:=WORKDATE;
                IF StartDate=0D THEN
                StartDate:=00000101D;
                */

            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(StartDate;StartDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Starting From';
                }
                field(EndDate;EndDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Ending On';
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        if StartDate=0D then Error('You must enter start date!');
    end;

    var
        Location: Code[20];
        Product: Code[20];
        StartDate: Date;
        EndDate: Date;
        ProdGroup: Code[20];
        Value: Decimal;
        PostDate: Date;
        DimValue: Record "Dimension Value";
        CostCenter: Text[100];
        Branch: Text[100];
        CompInfo: Record "Company Information";
        CompName: Text[100];
        Vend: Record Vendor;
        VendName: Text[100];
}

