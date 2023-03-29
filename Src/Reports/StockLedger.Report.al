#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516117 "Stock Ledger"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Stock Ledger.rdlc';

    dataset
    {
        dataitem(Item;Item)
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(No;Item."No.")
            {
            }
            column(Description;Item.Description)
            {
            }
            column(Quantity;Item.Inventory)
            {
            }
            column(UOM;Item."Base Unit of Measure")
            {
            }
            column(Unit_cost;Item."Unit Cost")
            {
            }
            column(Item_Group;Item."Location Code")
            {
            }
            column(Company_Name;UpperCase(CompInfo.Name))
            {
            }
            column(Amount;TAmout)
            {
            }
            column(LIssueDate;LIssueDate)
            {
            }
            column(LRecptDate;LRecptDate)
            {
            }
            column(pic;CompInfo.Picture)
            {
            }
            column(TDate;TDate)
            {
            }
            column(OpenQty;OpenQty)
            {
            }
            column(RctQty;RctQty)
            {
            }
            column(IssQty;IssQty)
            {
            }
            column(ClosQty;ClosQty)
            {
            }

            trigger OnAfterGetRecord()
            begin
                /*"Store Requistion Lines".CALCFIELDS("Store Requistion Lines"."Product Group");
                //CALCFIELDS (Product);
                RESET;
                IF Location<>'' THEN
                SETRANGE("Store Requistion Lines"."Issuing Store",Location);
                IF Product<>'' THEN
                SETRANGE("Store Requistion Lines"."Product Group",Product);
                //IF StartDate<> 0D THEN
                //SETRANGE("Store Requistion Lines"."Posting Date",StartDate);
                //IF EndDate<> 0D THEN
                //SETRANGE("Store Requistion Lines"."Posting Date",EndDate);
                
                 DimValue.RESET;
                 DimValue.SETRANGE(DimValue.Code,"Store Requistion Lines"."Shortcut Dimension 1 Code");
                 IF DimValue.FIND ('-') THEN
                 Branch:=DimValue.Name;
                
                 DimValue.RESET;
                 DimValue.SETRANGE(DimValue.Code,"Store Requistion Lines"."Shortcut Dimension 2 Code");
                 IF DimValue.FIND ('-') THEN
                CostCenter:=DimValue.Name;
                */
                Items.Reset;
                Items.SetRange(Items."No.",Item."No.");
                if Items.Find('-') then
                begin
                Items.CalcFields(Items.Inventory);
                TAmout:=Items.Inventory*Items."Unit Cost";
                end;

            end;

            trigger OnPreDataItem()
            begin


                if CompInfo.Get then CompInfo.CalcFields(CompInfo.Picture);
                CompName:=CompInfo.Name;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(TDate;TDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Enter Date';
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
        TAmout: Decimal;
        Items: Record Item;
        LIssueDate: Date;
        LRecptDate: Date;
        TDate: Date;
        OpenQty: Integer;
        RctQty: Integer;
        IssQty: Integer;
        ClosQty: Integer;
}

