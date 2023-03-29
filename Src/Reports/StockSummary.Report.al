#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516109 "Stock Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Stock Summary.rdlc';

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
            column(LIssueDate;LIssueD)
            {
            }
            column(LRecptDate;LRcptD)
            {
            }
            column(pic;CompInfo.Picture)
            {
            }
            column(TDate;TDate)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if Inventory=0 then
                CurrReport.Skip;

                //CLEAR(LIssueD);
                //CLEAR(LRcptD);
                Sreq.Reset;
                Sreq.SetRange(Sreq."No.",Items."No.");
                Sreq.SetRange(Sreq."Request Status",Sreq."request status"::Closed);
                if Sreq.Find('+') then
                LIssueD:=Sreq."Posting Date";

                ItemEnt.Reset;
                ItemEnt.SetRange (ItemEnt."Item No.",Item."No.");
                ItemEnt.SetRange (ItemEnt."Entry Type",ItemEnt."entry type"::"Positive Adjmt.");
                ItemEnt.SetRange (ItemEnt."Document Type",ItemEnt."document type"::"Purchase Receipt");
                if ItemEnt.Find ('+') then
                LRcptD:=ItemEnt."Posting Date";

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
        Sreq: Record "Store Requistion Lines";
        LIssueD: Date;
        LRcptD: Date;
        ItemEnt: Record "Item Ledger Entry";
}

