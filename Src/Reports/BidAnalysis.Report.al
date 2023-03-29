#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516122 "Bid Analysis"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Bid Analysis.rdlc';

    dataset
    {
        dataitem("Bid Analysis";"Bid Analysis")
        {
            RequestFilterFields = "RFQ No.";
            column(ReportForNavId_1102755000; 1102755000)
            {
            }
            column(RFQNo_BidAnalysis;"RFQ No.")
            {
            }
            column(QuoteNo_BidAnalysis;"Quote No.")
            {
            }
            column(VendorNo_BidAnalysis;"Vendor No.")
            {
            }
            column(ItemNo_BidAnalysis;"Item No.")
            {
            }
            column(Description_BidAnalysis;Description)
            {
            }
            column(Quantity_BidAnalysis;Quantity)
            {
            }
            column(UnitOfMeasure_BidAnalysis;"Unit Of Measure")
            {
            }
            column(Amount_BidAnalysis;Amount)
            {
            }
            column(LineAmount_BidAnalysis;"Line Amount")
            {
            }
            column(RFQLineNo_BidAnalysis;"RFQ Line No.")
            {
            }
            column(CompanyInfoName;CompanyInfo.Name)
            {
            }
            column(CompanyInfoAddress;CompanyInfo.Address)
            {
            }
            column(CompanyInfoPicture;CompanyInfo.Picture)
            {
            }
            column(LastDirectCost_BidAnalysis;"Last Direct Cost")
            {
            }
            column(Total_BidAnalysis;Total)
            {
            }
            column(Name_Vendor;VendorName)
            {
            }
            column(SelectedVendor;SelectedVendor)
            {
            }
            column(SelectedPrice;SelectedPrice)
            {
            }
            column(TotalPrice;TotalPrice)
            {
            }
            column(SelectedRemarks;SelectedRemarks)
            {
            }

            trigger OnAfterGetRecord()
            begin

                if Vendor.Get("Bid Analysis"."Vendor No.") then
                VendorName:=Vendor.Name;
                BidAnalysis.Reset;
                BidAnalysis.SetRange("RFQ No.","RFQ No.");
                BidAnalysis.SetRange("RFQ Line No.","RFQ Line No.");
                BidAnalysis.SetCurrentkey(BidAnalysis."RFQ No.",BidAnalysis."RFQ Line No.",BidAnalysis.Amount);
                if BidAnalysis.FindFirst then
                begin
                  Vendor.Get(BidAnalysis."Vendor No.");
                  SelectedVendor:=Vendor.Name;
                  SelectedPrice:=BidAnalysis.Amount;
                  TotalPrice:=BidAnalysis.Amount*BidAnalysis.Quantity;
                  SelectedRemarks:= BidAnalysis.Remarks;
                end
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
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        Vendor: Record Vendor;
        BidAnalysis: Record "Bid Analysis";
        SelectedVendor: Text;
        SelectedPrice: Decimal;
        TotalPrice: Decimal;
        VendorName: Text;
        SelectedRemarks: Text;
}

