#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516112 "Cost Center  (Product Group)"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Cost Center  (Product Group).rdlc';

    dataset
    {
        dataitem("Store Requistion Lines";"Store Requistion Lines")
        {
            DataItemTableView = where("Request Status"=filter(Closed));
            RequestFilterFields = "Product Group","Issuing Store","No.","Shortcut Dimension 1 Code","Posting Date";
            column(ReportForNavId_1; 1)
            {
            }
            column(No;"Store Requistion Lines"."No.")
            {
            }
            column(Description;"Store Requistion Lines".Description)
            {
            }
            column(Quantity;"Store Requistion Lines".Quantity)
            {
            }
            column(UOM;"Store Requistion Lines"."Unit of Measure")
            {
            }
            column(Unit_cost;"Store Requistion Lines"."Unit Cost")
            {
                DecimalPlaces = 2:2;
            }
            column(Amount;"Store Requistion Lines"."Line Amount")
            {
                DecimalPlaces = 2:2;
            }
            column(Branch;Branch)
            {
            }
            column(Cost_center;CostCenter)
            {
            }
            column(Item_Category;"Store Requistion Lines"."Product Group")
            {
            }
            column(Start_Date;StartDate)
            {
            }
            column(End_Date;EndDate)
            {
            }
            column(Product_Group;ProdGroup)
            {
            }
            column(Location;Location)
            {
            }
            column(Company_Name;UpperCase(CompInfo.Name))
            {
            }
            column(MR_No;"Store Requistion Lines"."Requistion No")
            {
            }
            column(posting_date;"Store Requistion Lines"."Posting Date")
            {
            }
            column(IssStore;"Store Requistion Lines"."Issuing Store")
            {
            }
            column(CostC;"Store Requistion Lines"."Shortcut Dimension 2 Code")
            {
            }
            column(C_Code;"Store Requistion Lines"."Category Code")
            {
            }
            column(Item_Group;"Store Requistion Lines"."Item Group")
            {
            }
            column(Item_Prod_Group;"Store Requistion Lines"."Item Product Group")
            {
            }

            trigger OnAfterGetRecord()
            begin
                if( "Store Requistion Lines".Quantity =0 ) or
                ("Store Requistion Lines"."Request Status"="Store Requistion Lines"."request status"::Pending)
                then CurrReport.Skip;
                "Store Requistion Lines".CalcFields("Store Requistion Lines"."Product Group");


                //RESET;
                //IF StartDate<>0D THEN
                //SETRANGE("Store Requistion Lines"."Posting Date",StartDate,EndDate);
                //SETRANGE("Store Requistion Lines"."Category Code",Product);

                 DimValue.Reset;
                 DimValue.SetRange(DimValue.Code,"Store Requistion Lines"."Shortcut Dimension 1 Code");
                 if DimValue.Find ('-') then
                 Branch:=DimValue.Name;

                 DimValue.Reset;
                 DimValue.SetRange(DimValue.Code,"Store Requistion Lines"."Shortcut Dimension 2 Code");
                 if DimValue.Find ('-') then
                CostCenter:=DimValue.Name;
            end;

            trigger OnPreDataItem()
            begin
                "Store Requistion Lines".CalcFields("Store Requistion Lines"."Product Group");
                if CompInfo.Get then
                CompName:=CompInfo.Name;
                Clear("Store Requistion Lines"."Issuing Store");
                //if EndDate=0d then EndDate:=workdate;
            end;
        }
    }

    requestpage
    {

        layout
        {
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
        //IF StartDate=0D THEN ERROR('Please Enter the start date!');
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
        Dept: Code[10];
}

