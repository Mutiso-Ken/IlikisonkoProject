#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516121 "Purchase Order End"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Purchase Order End.rdlc';
    Caption = 'Order';

    dataset
    {
        dataitem("Purchase Header";"Purchase Header")
        {
            DataItemTableView = sorting("Document Type","No.") where("Document Type"=const(Order));
            RequestFilterFields = "No.","Buy-from Vendor No.","No. Printed";
            RequestFilterHeading = 'Purchase Order';
            column(ReportForNavId_4458; 4458)
            {
            }
            column(DocType_PurchHeader;"Document Type")
            {
            }
            column(No_PurchHeader;"No.")
            {
            }
            column(AmountCaption;AmountCaptionLbl)
            {
            }
            column(PurchLineInvDiscAmtCaption;PurchLineInvDiscAmtCaptionLbl)
            {
            }
            column(SubtotalCaption;SubtotalCaptionLbl)
            {
            }
            column(VATAmtLineVATCaption;VATAmtLineVATCaptionLbl)
            {
            }
            column(VATAmtLineVATAmtCaption;VATAmtLineVATAmtCaptionLbl)
            {
            }
            column(VATAmtSpecCaption;VATAmtSpecCaptionLbl)
            {
            }
            column(VATIdentifierCaption;VATIdentifierCaptionLbl)
            {
            }
            column(VATAmtLineInvDiscBaseAmtCaption;VATAmtLineInvDiscBaseAmtCaptionLbl)
            {
            }
            column(VATAmtLineLineAmtCaption;VATAmtLineLineAmtCaptionLbl)
            {
            }
            column(VALVATBaseLCYCaption;VALVATBaseLCYCaptionLbl)
            {
            }
            column(TotalCaption;TotalCaptionLbl)
            {
            }
            column(PaymentTermsDescCaption;PaymentTermsDescCaptionLbl)
            {
            }
            column(ShipmentMethodDescCaption;ShipmentMethodDescCaptionLbl)
            {
            }
            column(PrepymtTermsDescCaption;PrepymtTermsDescCaptionLbl)
            {
            }
            column(HomePageCaption;HomePageCaptionLbl)
            {
            }
            column(EmailIDCaption;EmailIDCaptionLbl)
            {
            }
            column(AllowInvoiceDiscCaption;AllowInvoiceDiscCaptionLbl)
            {
            }
            column(ExpectedReceiptDate_PurchaseHeader;"Purchase Header"."Expected Receipt Date")
            {
            }
            column(PostingDate_PurchaseHeader;"Purchase Header"."Posting Date")
            {
            }
            column(No_PurchaseHeader;"Purchase Header"."No.")
            {
            }
            column(CopyText;CopyText)
            {
            }
            column(PaymentTermsCode_PurchaseHeader;"Purchase Header"."Payment Terms Code")
            {
            }
            column(CurrencyCode_PurchaseHeader;"Purchase Header"."Currency Code")
            {
            }
            column(ExpiryDate_PurchaseHeader;"Purchase Header"."Expiry Date")
            {
                IncludeCaption = true;
            }
            column(Amount_PurchaseHeader;"Purchase Header".Amount)
            {
            }
            column(AmountIncludingVAT_PurchaseHeader;"Purchase Header"."Amount Including VAT")
            {
            }
            column(TotalDiscountAmount;PurchLines."Line Discount Amount")
            {
            }
            column(SpecialRemark_PurchaseHeader;"Purchase Header"."Special Remark")
            {
            }
            column(NumberText;NumberText[1])
            {
            }
            column(NoPrinted;"Purchase Header"."No. Printed")
            {
            }
            column(PaytoVendorNo_PurchaseHeader;"Purchase Header"."Pay-to Vendor No.")
            {
            }
            column(PaytoName_PurchaseHeader;"Purchase Header"."Pay-to Name")
            {
            }
            column(PaytoName2_PurchaseHeader;"Purchase Header"."Pay-to Name 2")
            {
            }
            column(PaytoAddress_PurchaseHeader;"Purchase Header"."Pay-to Address")
            {
            }
            column(PaytoAddress2_PurchaseHeader;"Purchase Header"."Pay-to Address 2")
            {
            }
            column(PaytoCity_PurchaseHeader;"Purchase Header"."Pay-to City")
            {
            }
            column(ShiptoCode_PurchaseHeader;"Purchase Header"."Ship-to Code")
            {
            }
            column(ShiptoName_PurchaseHeader;"Purchase Header"."Ship-to Name")
            {
            }
            column(ShiptoName2_PurchaseHeader;"Purchase Header"."Ship-to Name 2")
            {
            }
            column(ShiptoAddress_PurchaseHeader;"Purchase Header"."Ship-to Address")
            {
            }
            column(ShiptoAddress2_PurchaseHeader;"Purchase Header"."Ship-to Address 2")
            {
            }
            column(CurrencyText;CurrencyText)
            {
            }
            column(Pterms2017;"Purchase Header"."Payment Terms")
            {
            }
            dataitem(CopyLoop;"Integer")
            {
                DataItemTableView = sorting(Number);
                column(ReportForNavId_5701; 5701)
                {
                }
                dataitem(PageLoop;"Integer")
                {
                    DataItemTableView = sorting(Number) where(Number=const(1));
                    column(ReportForNavId_6455; 6455)
                    {
                    }
                    column(ReportTitleCopyText;StrSubstNo(Text004,CopyText))
                    {
                    }
                    column(CurrRepPageNo;StrSubstNo(Text005,Format(CurrReport.PageNo)))
                    {
                    }
                    column(CompanyAddr1;CompanyAddr[1])
                    {
                    }
                    column(CompanyAddr2;CompanyAddr[2])
                    {
                    }
                    column(CompanyAddr3;CompanyAddr[3])
                    {
                    }
                    column(CompanyAddr4;CompanyAddr[4])
                    {
                    }
                    column(CompanyInfoPhoneNo;CompanyInfo."Phone No.")
                    {
                    }
                    column(CompanyInfoFaxNo;CompanyInfo."Fax No.")
                    {
                    }
                    column(CompanyInfoVATRegNo;CompanyInfo."VAT Registration No.")
                    {
                    }
                    column(CompanyInfoGiroNo;CompanyInfo."Giro No.")
                    {
                    }
                    column(CompanyInfoBankName;CompanyInfo."Bank Name")
                    {
                    }
                    column(CompanyInfoBankAccNo;CompanyInfo."Bank Account No.")
                    {
                    }
                    column(DocDate_PurchHeader;Format("Purchase Header"."Document Date",0,4))
                    {
                    }
                    column(CompanyInfoPicture;CompanyInfo.Picture)
                    {
                    }
                    column(CompNames;CompanyInfo.Name)
                    {
                    }
                    column(VATNoText;VATNoText)
                    {
                    }
                    column(VATRegNo_PurchHeader;"Purchase Header"."VAT Registration No.")
                    {
                    }
                    column(PurchaserText;PurchaserText)
                    {
                    }
                    column(SalesPurchPersonName;SalesPurchPerson.Name)
                    {
                    }
                    column(ReferenceText;ReferenceText)
                    {
                    }
                    column(YourRef_PurchHeader;"Purchase Header"."Your Reference")
                    {
                    }
                    column(CompanyAddr5;CompanyAddr[5])
                    {
                    }
                    column(CompanyAddr6;CompanyAddr[6])
                    {
                    }
                    column(BuyFrmVendNo_PurchHeader;"Purchase Header"."Buy-from Vendor No.")
                    {
                    }
                    column(BuyFromAddr1;BuyFromAddr[1])
                    {
                    }
                    column(BuyFromAddr2;BuyFromAddr[2])
                    {
                    }
                    column(BuyFromAddr3;BuyFromAddr[3])
                    {
                    }
                    column(BuyFromAddr4;BuyFromAddr[4])
                    {
                    }
                    column(BuyFromAddr5;BuyFromAddr[5])
                    {
                    }
                    column(BuyFromAddr6;BuyFromAddr[6])
                    {
                    }
                    column(BuyFromAddr7;BuyFromAddr[7])
                    {
                    }
                    column(BuyFromAddr8;BuyFromAddr[8])
                    {
                    }
                    column(PricesInclVAT_PurchHeader;"Purchase Header"."Prices Including VAT")
                    {
                    }
                    column(OutputNo;OutputNo)
                    {
                    }
                    column(VATBaseDisc_PurchHeader;"Purchase Header"."VAT Base Discount %")
                    {
                    }
                    column(PricesInclVATtxt;PricesInclVATtxt)
                    {
                    }
                    column(PaymentTermsDesc;PaymentTerms.Description)
                    {
                    }
                    column(ShipmentMethodDesc;ShipmentMethod.Description)
                    {
                    }
                    column(PrepmtPaymentTermsDesc;PrepmtPaymentTerms.Description)
                    {
                    }
                    column(ShowInternalInfo;ShowInternalInfo)
                    {
                    }
                    column(TotalText;TotalText)
                    {
                    }
                    column(DimText;DimText)
                    {
                    }
                    column(CompanyInfoPhoneNoCaption;CompanyInfoPhoneNoCaptionLbl)
                    {
                    }
                    column(CompanyInfoVATRegNoCaption;CompanyInfoVATRegNoCaptionLbl)
                    {
                    }
                    column(CompanyInfoGiroNoCaption;CompanyInfoGiroNoCaptionLbl)
                    {
                    }
                    column(CompanyInfoBankNameCaption;CompanyInfoBankNameCaptionLbl)
                    {
                    }
                    column(CompanyInfoBankAccNoCaption;CompanyInfoBankAccNoCaptionLbl)
                    {
                    }
                    column(OrderNoCaption;OrderNoCaptionLbl)
                    {
                    }
                    column(PageCaption;PageCaptionLbl)
                    {
                    }
                    column(DocumentDateCaption;DocumentDateCaptionLbl)
                    {
                    }
                    column(BuyFrmVendNo_PurchHeaderCaption;"Purchase Header".FieldCaption("Buy-from Vendor No."))
                    {
                    }
                    column(PricesInclVAT_PurchHeaderCaption;"Purchase Header".FieldCaption("Prices Including VAT"))
                    {
                    }
                    column(LPOText;LPOText)
                    {
                    }
                    dataitem(DimensionLoop1;"Integer")
                    {
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = sorting(Number) where(Number=filter(1..));
                        column(ReportForNavId_7574; 7574)
                        {
                        }
                        column(HdrDimCaption;HdrDimCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            if Number = 1 then begin
                              if not DimSetEntry1.FindSet then
                                CurrReport.Break;
                            end else
                              if not Continue then
                                CurrReport.Break;

                            Clear(DimText);
                            Continue := false;
                            repeat
                              OldDimText := DimText;
                              if DimText = '' then
                                DimText := StrSubstNo('%1 %2',DimSetEntry1."Dimension Code",DimSetEntry1."Dimension Value Code")
                              else
                                DimText :=
                                  StrSubstNo(
                                    '%1, %2 %3',DimText,
                                    DimSetEntry1."Dimension Code",DimSetEntry1."Dimension Value Code");
                              if StrLen(DimText) > MaxStrLen(OldDimText) then begin
                                DimText := OldDimText;
                                Continue := true;
                                exit;
                              end;
                            until DimSetEntry1.Next = 0;
                        end;

                        trigger OnPreDataItem()
                        begin
                            if not ShowInternalInfo then
                              CurrReport.Break;
                        end;
                    }
                    dataitem("Purchase Line";"Purchase Line")
                    {
                        DataItemLink = "Document Type"=field("Document Type"),"Document No."=field("No.");
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = sorting("Document Type","Document No.","Line No.");
                        column(ReportForNavId_6547; 6547)
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            CurrReport.Break;
                        end;
                    }
                    dataitem(RoundLoop;"Integer")
                    {
                        DataItemTableView = sorting(Number);
                        column(ReportForNavId_7551; 7551)
                        {
                        }
                        column(LineAmt_PurchLine;PurchLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Line"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(LineNo_PurchLine;"Purchase Line"."Line No.")
                        {
                        }
                        column(AllowInvDisctxt;AllowInvDisctxt)
                        {
                        }
                        column(Type_PurchLine;Format("Purchase Line".Type,0,2))
                        {
                        }
                        column(No_PurchLine;"Purchase Line"."No.")
                        {
                        }
                        column(Desc_PurchLine;"Purchase Line".Description)
                        {
                        }
                        column(Qty_PurchLine;"Purchase Line".Quantity)
                        {
                        }
                        column(UOM_PurchLine;"Purchase Line"."Unit of Measure")
                        {
                        }
                        column(DirUnitCost_PurchLine;"Purchase Line"."Direct Unit Cost")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(LineDisc_PurchLine;"Purchase Line"."Line Discount %")
                        {
                        }
                        column(LineAmt2_PurchLine;"Purchase Line"."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(AllowInvDisc_PurchLine;"Purchase Line"."Allow Invoice Disc.")
                        {
                        }
                        column(HomePage;CompanyInfo."Home Page")
                        {
                        }
                        column(EMail;CompanyInfo."E-Mail")
                        {
                        }
                        column(VATIdentifier_PurchLine;"Purchase Line"."VAT Identifier")
                        {
                        }
                        column(InvDiscAmt_PurchLine;-PurchLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Line"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInclVAT;PurchLine."Line Amount" - PurchLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInclVATText;TotalInclVATText)
                        {
                        }
                        column(VATAmountText;VATAmountLine.VATAmountText)
                        {
                        }
                        column(VATAmount;VATAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalExclVATText;TotalExclVATText)
                        {
                        }
                        column(VATDiscountAmount;-VATDiscountAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATBaseAmount;VATBaseAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmountInclVAT;TotalAmountInclVAT)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalSubTotal;TotalSubTotal)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInvoiceDiscountAmount;TotalInvoiceDiscountAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmount;TotalAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(DirectUniCostCaption;DirectUniCostCaptionLbl)
                        {
                        }
                        column(PurchLineLineDiscCaption;PurchLineLineDiscCaptionLbl)
                        {
                        }
                        column(VATDiscountAmountCaption;VATDiscountAmountCaptionLbl)
                        {
                        }
                        column(No_PurchLineCaption;"Purchase Line".FieldCaption("No."))
                        {
                        }
                        column(Desc_PurchLineCaption;"Purchase Line".FieldCaption(Description))
                        {
                        }
                        column(Qty_PurchLineCaption;"Purchase Line".FieldCaption(Quantity))
                        {
                        }
                        column(UOM_PurchLineCaption;"Purchase Line".FieldCaption("Unit of Measure"))
                        {
                        }
                        column(VATIdentifier_PurchLineCaption;"Purchase Line".FieldCaption("VAT Identifier"))
                        {
                        }
                        column(LineDiscountAmount_PurchLine;PurchLine."Line Discount Amount")
                        {
                        }
                        dataitem(DimensionLoop2;"Integer")
                        {
                            DataItemTableView = sorting(Number) where(Number=filter(1..));
                            column(ReportForNavId_3591; 3591)
                            {
                            }
                            column(LineDimCaption;LineDimCaptionLbl)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                if Number = 1 then begin
                                  if not DimSetEntry2.FindSet then
                                    CurrReport.Break;
                                end else
                                  if not Continue then
                                    CurrReport.Break;

                                Clear(DimText);
                                Continue := false;
                                repeat
                                  OldDimText := DimText;
                                  if DimText = '' then
                                    DimText := StrSubstNo('%1 %2',DimSetEntry2."Dimension Code",DimSetEntry2."Dimension Value Code")
                                  else
                                    DimText :=
                                      StrSubstNo(
                                        '%1, %2 %3',DimText,
                                        DimSetEntry2."Dimension Code",DimSetEntry2."Dimension Value Code");
                                  if StrLen(DimText) > MaxStrLen(OldDimText) then begin
                                    DimText := OldDimText;
                                    Continue := true;
                                    exit;
                                  end;
                                until DimSetEntry2.Next = 0;
                            end;

                            trigger OnPreDataItem()
                            begin
                                if not ShowInternalInfo then
                                  CurrReport.Break;

                                DimSetEntry2.SetRange("Dimension Set ID","Purchase Line"."Dimension Set ID");
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            if Number = 1 then
                              PurchLine.Find('-')
                            else
                              PurchLine.Next;
                            "Purchase Line" := PurchLine;


                            RecordSeQ:=RecordSeQ+1;

                            if RecordSeQ>=PurchLine.Count then
                               Start:=true;

                            if Start=true then  begin
                               RecordSeQ:=0;
                               PurchLine.Init;
                               PurchLine."Line No."+=1;
                            end;


                            if not "Purchase Header"."Prices Including VAT" and
                               (PurchLine."VAT Calculation Type" = PurchLine."vat calculation type"::"Full VAT")
                            then
                              PurchLine."Line Amount" := 0;

                            if (PurchLine.Type = PurchLine.Type::"G/L Account") and (not ShowInternalInfo) then
                              "Purchase Line"."No." := '';
                            AllowInvDisctxt := Format("Purchase Line"."Allow Invoice Disc.");
                            TotalSubTotal += "Purchase Line"."Line Amount";
                            TotalInvoiceDiscountAmount -= "Purchase Line"."Inv. Discount Amount";
                            TotalAmount += "Purchase Line".Amount;
                        end;

                        trigger OnPostDataItem()
                        begin
                            PurchLine.DeleteAll;
                        end;

                        trigger OnPreDataItem()
                        begin
                            MoreLines := PurchLine.Find('+');
                            while MoreLines and (PurchLine.Description = '') and (PurchLine."Description 2" = '') and
                                  (PurchLine."No." = '') and (PurchLine.Quantity = 0) and
                                  (PurchLine.Amount = 0)
                            do
                              MoreLines := PurchLine.Next(-1) <> 0;
                            if not MoreLines then
                              CurrReport.Break;
                            PurchLine.SetRange("Line No.",0,PurchLine."Line No.");

                            //Take Care of Growing Empty Lines
                            if PurchLine.Count<=20 then
                             SetRange(Number,1,20)
                            else
                            SetRange(Number,1,PurchLine.Count);


                            Start:=false;

                            CurrReport.CreateTotals(PurchLine."Line Amount",PurchLine."Inv. Discount Amount");
                        end;
                    }
                    dataitem(VATCounter;"Integer")
                    {
                        DataItemTableView = sorting(Number);
                        column(ReportForNavId_6558; 6558)
                        {
                        }
                        column(VATAmtLineVATBase;VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmt;VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineLineAmt;VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscBaseAmt;VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscAmt;VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVAT;VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0:5;
                        }
                        column(VATAmtLineVATIdentifier;VATAmountLine."VAT Identifier")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem()
                        begin
                            if VATAmount = 0 then
                              CurrReport.Break;
                            SetRange(Number,1,VATAmountLine.Count);
                            CurrReport.CreateTotals(
                              VATAmountLine."Line Amount",VATAmountLine."Inv. Disc. Base Amount",
                              VATAmountLine."Invoice Discount Amount",VATAmountLine."VAT Base",VATAmountLine."VAT Amount");
                        end;
                    }
                    dataitem(VATCounterLCY;"Integer")
                    {
                        DataItemTableView = sorting(Number);
                        column(ReportForNavId_2038; 2038)
                        {
                        }
                        column(VALExchRate;VALExchRate)
                        {
                        }
                        column(VALSpecLCYHeader;VALSpecLCYHeader)
                        {
                        }
                        column(VALVATAmountLCY;VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATBaseLCY;VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);
                            VALVATBaseLCY :=
                              VATAmountLine.GetBaseLCY(
                                "Purchase Header"."Posting Date","Purchase Header"."Currency Code","Purchase Header"."Currency Factor");
                            VALVATAmountLCY :=
                              VATAmountLine.GetAmountLCY(
                                "Purchase Header"."Posting Date","Purchase Header"."Currency Code","Purchase Header"."Currency Factor");
                        end;

                        trigger OnPreDataItem()
                        begin
                            if (not GLSetup."Print VAT specification in LCY") or
                               ("Purchase Header"."Currency Code" = '') or
                               (VATAmountLine.GetTotalVATAmount = 0)
                            then
                              CurrReport.Break;

                            SetRange(Number,1,VATAmountLine.Count);
                            CurrReport.CreateTotals(VALVATBaseLCY,VALVATAmountLCY);

                            if GLSetup."LCY Code" = '' then
                              VALSpecLCYHeader := Text007 + Text008
                            else
                              VALSpecLCYHeader := Text007 + Format(GLSetup."LCY Code");

                            CurrExchRate.FindCurrency("Purchase Header"."Posting Date","Purchase Header"."Currency Code",1);
                            VALExchRate := StrSubstNo(Text009,CurrExchRate."Relational Exch. Rate Amount",CurrExchRate."Exchange Rate Amount");
                        end;
                    }
                    dataitem(Total2;"Integer")
                    {
                        DataItemTableView = sorting(Number) where(Number=const(1));
                        column(ReportForNavId_3363; 3363)
                        {
                        }
                        column(PayToVendNo_PurchHeader;"Purchase Header"."Pay-to Vendor No.")
                        {
                        }
                        column(VendAddr8;VendAddr[8])
                        {
                        }
                        column(VendAddr7;VendAddr[7])
                        {
                        }
                        column(VendAddr6;VendAddr[6])
                        {
                        }
                        column(VendAddr5;VendAddr[5])
                        {
                        }
                        column(VendAddr4;VendAddr[4])
                        {
                        }
                        column(VendAddr3;VendAddr[3])
                        {
                        }
                        column(VendAddr2;VendAddr[2])
                        {
                        }
                        column(VendAddr1;VendAddr[1])
                        {
                        }
                        column(PaymentDetailsCaption;PaymentDetailsCaptionLbl)
                        {
                        }
                        column(VendNoCaption;VendNoCaptionLbl)
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            if "Purchase Header"."Buy-from Vendor No." = "Purchase Header"."Pay-to Vendor No." then
                              CurrReport.Break;
                        end;
                    }
                    dataitem(Total3;"Integer")
                    {
                        DataItemTableView = sorting(Number) where(Number=const(1));
                        column(ReportForNavId_8272; 8272)
                        {
                        }
                        column(SellToCustNo_PurchHeader;"Purchase Header"."Sell-to Customer No.")
                        {
                        }
                        column(ShipToAddr1;ShipToAddr[1])
                        {
                        }
                        column(ShipToAddr2;ShipToAddr[2])
                        {
                        }
                        column(ShipToAddr3;ShipToAddr[3])
                        {
                        }
                        column(ShipToAddr4;ShipToAddr[4])
                        {
                        }
                        column(ShipToAddr5;ShipToAddr[5])
                        {
                        }
                        column(ShipToAddr6;ShipToAddr[6])
                        {
                        }
                        column(ShipToAddr7;ShipToAddr[7])
                        {
                        }
                        column(ShipToAddr8;ShipToAddr[8])
                        {
                        }
                        column(ShiptoAddressCaption;ShiptoAddressCaptionLbl)
                        {
                        }
                        column(SellToCustNo_PurchHeaderCaption;"Purchase Header".FieldCaption("Sell-to Customer No."))
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            if ("Purchase Header"."Sell-to Customer No." = '') and (ShipToAddr[1] = '') then
                              CurrReport.Break;
                        end;
                    }
                    dataitem(PrepmtLoop;"Integer")
                    {
                        DataItemTableView = sorting(Number) where(Number=filter(1..));
                        column(ReportForNavId_1849; 1849)
                        {
                        }
                        column(PrepmtLineAmount;PrepmtLineAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtInvBufGLAccNo;PrepmtInvBuf."G/L Account No.")
                        {
                        }
                        column(PrepmtInvBufDesc;PrepmtInvBuf.Description)
                        {
                        }
                        column(TotalInclVATText2;TotalInclVATText)
                        {
                        }
                        column(TotalExclVATText2;TotalExclVATText)
                        {
                        }
                        column(PrepmtInvBufAmt;PrepmtInvBuf.Amount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmountText;PrepmtVATAmountLine.VATAmountText)
                        {
                        }
                        column(PrepmtVATAmount;PrepmtVATAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtTotalAmountInclVAT;PrepmtTotalAmountInclVAT)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATBaseAmount;PrepmtVATBaseAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtInvBuDescCaption;PrepmtInvBuDescCaptionLbl)
                        {
                        }
                        column(PrepmtInvBufGLAccNoCaption;PrepmtInvBufGLAccNoCaptionLbl)
                        {
                        }
                        column(PrepaymentSpecCaption;PrepaymentSpecCaptionLbl)
                        {
                        }
                        dataitem(PrepmtDimLoop;"Integer")
                        {
                            DataItemTableView = sorting(Number) where(Number=filter(1..));
                            column(ReportForNavId_6278; 6278)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                if Number = 1 then begin
                                  if not PrepmtDimSetEntry.FindSet then
                                    CurrReport.Break;
                                end else
                                  if not Continue then
                                    CurrReport.Break;

                                Clear(DimText);
                                Continue := false;
                                repeat
                                  OldDimText := DimText;
                                  if DimText = '' then
                                    DimText := StrSubstNo('%1 %2',PrepmtDimSetEntry."Dimension Code",PrepmtDimSetEntry."Dimension Value Code")
                                  else
                                    DimText :=
                                      StrSubstNo(
                                        '%1, %2 %3',DimText,
                                        PrepmtDimSetEntry."Dimension Code",PrepmtDimSetEntry."Dimension Value Code");
                                  if StrLen(DimText) > MaxStrLen(OldDimText) then begin
                                    DimText := OldDimText;
                                    Continue := true;
                                    exit;
                                  end;
                                until PrepmtDimSetEntry.Next = 0;
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            if Number = 1 then begin
                              if not PrepmtInvBuf.Find('-') then
                                CurrReport.Break;
                            end else
                              if PrepmtInvBuf.Next = 0 then
                                CurrReport.Break;

                            if ShowInternalInfo then
                              PrepmtDimSetEntry.SetRange("Dimension Set ID",PrepmtInvBuf."Dimension Set ID");

                            if "Purchase Header"."Prices Including VAT" then
                              PrepmtLineAmount := PrepmtInvBuf."Amount Incl. VAT"
                            else
                              PrepmtLineAmount := PrepmtInvBuf.Amount;
                        end;

                        trigger OnPreDataItem()
                        begin
                            CurrReport.CreateTotals(
                              PrepmtInvBuf.Amount,PrepmtInvBuf."Amount Incl. VAT",
                              PrepmtVATAmountLine."Line Amount",PrepmtVATAmountLine."VAT Base",
                              PrepmtVATAmountLine."VAT Amount",
                              PrepmtLineAmount);
                        end;
                    }
                    dataitem(PrepmtVATCounter;"Integer")
                    {
                        DataItemTableView = sorting(Number);
                        column(ReportForNavId_3388; 3388)
                        {
                        }
                        column(PrepmtVATAmtLineVATAmt;PrepmtVATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmtLineVATBase;PrepmtVATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmtLineLineAmt;PrepmtVATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmtLineVAT;PrepmtVATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0:5;
                        }
                        column(PrepmtVATAmtLineVATId;PrepmtVATAmountLine."VAT Identifier")
                        {
                        }
                        column(PrepymtVATAmtSpecCaption;PrepymtVATAmtSpecCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            PrepmtVATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem()
                        begin
                            SetRange(Number,1,PrepmtVATAmountLine.Count);
                        end;
                    }
                    dataitem("Approval Entry";"Approval Entry")
                    {
                        DataItemLink = "Document No."=field("No.");
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = where("Document Type"=const(Order),Status=const(Approved));
                        column(ReportForNavId_1000000001; 1000000001)
                        {
                        }
                        column(SequenceNo_ApprovalEntry;"Approval Entry"."Sequence No.")
                        {
                        }
                        column(SenderID_ApprovalEntry;"Approval Entry"."Sender ID")
                        {
                        }
                        column(ApproverID_ApprovalEntry;"Approval Entry"."Approver ID")
                        {
                        }
                        column(DateTimeSentforApproval_ApprovalEntry;"Approval Entry"."Date-Time Sent for Approval")
                        {
                        }
                        column(LastDateTimeModified_ApprovalEntry;"Approval Entry"."Last Date-Time Modified")
                        {
                        }
                    }
                }

                trigger OnAfterGetRecord()
                var
                    PrepmtPurchLine: Record "Purchase Line" temporary;
                    TempPurchLine: Record "Purchase Line" temporary;
                begin
                    Clear(PurchLine);
                    Clear(PurchPost);
                    PurchLine.DeleteAll;
                    VATAmountLine.DeleteAll;
                    PurchPost.GetPurchLines("Purchase Header",PurchLine,0);
                    PurchLine.CalcVATAmountLines(0,"Purchase Header",PurchLine,VATAmountLine);
                    PurchLine.UpdateVATOnLines(0,"Purchase Header",PurchLine,VATAmountLine);
                    VATAmount := VATAmountLine.GetTotalVATAmount;
                    VATBaseAmount := VATAmountLine.GetTotalVATBase;
                    VATDiscountAmount :=
                      VATAmountLine.GetTotalVATDiscount("Purchase Header"."Currency Code","Purchase Header"."Prices Including VAT");
                    TotalAmountInclVAT := VATAmountLine.GetTotalAmountInclVAT;
                    
                    PrepmtInvBuf.DeleteAll;
                    PurchPostPrepmt.GetPurchLines("Purchase Header",0,PrepmtPurchLine);
                    if not PrepmtPurchLine.IsEmpty then begin
                      PurchPostPrepmt.GetPurchLinesToDeduct("Purchase Header",TempPurchLine);
                      if not TempPurchLine.IsEmpty then
                        PurchPostPrepmt.CalcVATAmountLines("Purchase Header",TempPurchLine,PrePmtVATAmountLineDeduct,1);
                    end;
                    PurchPostPrepmt.CalcVATAmountLines("Purchase Header",PrepmtPurchLine,PrepmtVATAmountLine,0);
                    if PrepmtVATAmountLine.FindSet then
                      repeat
                        PrePmtVATAmountLineDeduct := PrepmtVATAmountLine;
                        if PrePmtVATAmountLineDeduct.Find then begin
                          PrepmtVATAmountLine."VAT Base" := PrepmtVATAmountLine."VAT Base" - PrePmtVATAmountLineDeduct."VAT Base";
                          PrepmtVATAmountLine."VAT Amount" := PrepmtVATAmountLine."VAT Amount" - PrePmtVATAmountLineDeduct."VAT Amount";
                          PrepmtVATAmountLine."Amount Including VAT" := PrepmtVATAmountLine."Amount Including VAT" -
                            PrePmtVATAmountLineDeduct."Amount Including VAT";
                          PrepmtVATAmountLine."Line Amount" := PrepmtVATAmountLine."Line Amount" - PrePmtVATAmountLineDeduct."Line Amount";
                          PrepmtVATAmountLine."Inv. Disc. Base Amount" := PrepmtVATAmountLine."Inv. Disc. Base Amount" -
                            PrePmtVATAmountLineDeduct."Inv. Disc. Base Amount";
                          PrepmtVATAmountLine."Invoice Discount Amount" := PrepmtVATAmountLine."Invoice Discount Amount" -
                            PrePmtVATAmountLineDeduct."Invoice Discount Amount";
                          PrepmtVATAmountLine."Calculated VAT Amount" := PrepmtVATAmountLine."Calculated VAT Amount" -
                            PrePmtVATAmountLineDeduct."Calculated VAT Amount";
                          PrepmtVATAmountLine.Modify;
                        end;
                      until PrepmtVATAmountLine.Next = 0;
                    PurchPostPrepmt.UpdateVATOnLines("Purchase Header",PrepmtPurchLine,PrepmtVATAmountLine,0);
                    PurchPostPrepmt.BuildInvLineBuffer2("Purchase Header",PrepmtPurchLine,0,PrepmtInvBuf);
                    PrepmtVATAmount := PrepmtVATAmountLine.GetTotalVATAmount;
                    PrepmtVATBaseAmount := PrepmtVATAmountLine.GetTotalVATBase;
                    PrepmtTotalAmountInclVAT := PrepmtVATAmountLine.GetTotalAmountInclVAT;
                    
                    if Number > 1 then
                      CopyText := Text003;
                    CurrReport.PageNo := 1;
                    OutputNo := OutputNo + 1;
                    
                    /*
                      IF Number = 1 THEN LPOText:= 'Suppliers copy'
                      ELSE IF Number = 2 THEN LPOText:= 'Accounts copy'
                      ELSE IF Number = 3 THEN LPOText:= 'Stores copy'
                      ELSE IF Number = 4 THEN LPOText:= 'File copy';
                    for number := 1 to PurchSetup."No. Of Order Copies"+1 do
                     begin
                      LPOText:= COPYSTR(PurchSetup."Copies Print Text",1,STRPOS(PurchSetup."Copies Print Text",';')-1);
                      PurchSetup."Copies Print Text":=DELSTR(PurchSetup."Copies Print Text",1,STRPOS(PurchSetup."Copies Print Text",';'))
                     end;
                    */
                    //First add; to the prints, then get the respective lpo text to add a new copy just add a number = x code
                    PurchSetup."Copies Print Text":=InsStr(PurchSetup."Copies Print Text",';',StrLen(PurchSetup."Copies Print Text")+1);
                    if Number = 1 then
                     begin
                      LPOText:= CopyStr(PurchSetup."Copies Print Text",1,StrPos(PurchSetup."Copies Print Text",';')-1);
                      PurchSetup."Copies Print Text":=DelStr(PurchSetup."Copies Print Text",1,StrPos(PurchSetup."Copies Print Text",';'))
                     end;
                    if Number =2 then
                     begin
                      LPOText:= CopyStr(PurchSetup."Copies Print Text",1,StrPos(PurchSetup."Copies Print Text",';')-1);
                      PurchSetup."Copies Print Text":=DelStr(PurchSetup."Copies Print Text",1,StrPos(PurchSetup."Copies Print Text",';'))
                     end;
                    if Number =3 then
                     begin
                      LPOText:= CopyStr(PurchSetup."Copies Print Text",1,StrPos(PurchSetup."Copies Print Text",';')-1);
                      PurchSetup."Copies Print Text":=DelStr(PurchSetup."Copies Print Text",1,StrPos(PurchSetup."Copies Print Text",';'))
                     end;
                    if Number =4 then
                     begin
                      LPOText:= CopyStr(PurchSetup."Copies Print Text",1,StrPos(PurchSetup."Copies Print Text",';')-1);
                      PurchSetup."Copies Print Text":=DelStr(PurchSetup."Copies Print Text",1,StrPos(PurchSetup."Copies Print Text",';'))
                     end;
                    
                    
                    TotalSubTotal := 0;
                    TotalAmount := 0;

                end;

                trigger OnPostDataItem()
                begin
                    if not CurrReport.Preview then
                      PurchCountPrinted.Run("Purchase Header");
                end;

                trigger OnPreDataItem()
                begin
                    //NoOfLoops := ABS(NoOfCopies) + 1;
                    NoOfLoops := Abs(PurchSetup."No. Of Order Copies") + 1;//**changes
                    CopyText := '';
                    SetRange(Number,1,NoOfLoops);
                    OutputNo := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CurrReport.Language := Language.GetLanguageID("Language Code");

                CompanyInfo.Get;
                CompanyInfo.CalcFields(Picture);
                if RespCenter.Get("Responsibility Center") then begin
                  FormatAddr.RespCenter(CompanyAddr,RespCenter);
                  CompanyInfo."Phone No." := RespCenter."Phone No.";
                  CompanyInfo."Fax No." := RespCenter."Fax No.";
                end else
                  FormatAddr.Company(CompanyAddr,CompanyInfo);

                //Amount into words
                //CheckReport.InitTextVariable;
                CalcFields("Amount Including VAT");
                CheckReport.FormatNoText(NumberText,"Amount Including VAT","Currency Code");

                TotalInclVATText := StrSubstNo(Text002,GLSetup."LCY Code");
                DimSetEntry1.SetRange("Dimension Set ID","Dimension Set ID");

                if "Purchaser Code" = '' then begin
                  SalesPurchPerson.Init;
                  PurchaserText := '';
                end else begin
                  SalesPurchPerson.Get("Purchaser Code");
                  PurchaserText := Text000
                end;
                if "Your Reference" = '' then
                  ReferenceText := ''
                else
                  ReferenceText := FieldCaption("Your Reference");
                if "VAT Registration No." = '' then
                  VATNoText := ''
                else
                  VATNoText := FieldCaption("VAT Registration No.");
                if "Currency Code" = '' then begin
                  GLSetup.TestField("LCY Code");
                  TotalText := StrSubstNo(Text001,GLSetup."LCY Code");
                  TotalInclVATText := StrSubstNo(Text002,GLSetup."LCY Code");
                  TotalExclVATText := StrSubstNo(Text006,GLSetup."LCY Code");
                  CurrencyText := GLSetup."LCY Code";
                end else begin
                  TotalText := StrSubstNo(Text001,"Currency Code");
                  TotalInclVATText := StrSubstNo(Text002,"Currency Code");
                  TotalExclVATText := StrSubstNo(Text006,"Currency Code");
                  CurrencyText := "Currency Code"
                end;

                FormatAddr.PurchHeaderBuyFrom(BuyFromAddr,"Purchase Header");
                if "Buy-from Vendor No." <> "Pay-to Vendor No." then
                  FormatAddr.PurchHeaderPayTo(VendAddr,"Purchase Header");
                if "Payment Terms Code" = '' then
                  PaymentTerms.Init
                else begin
                  PaymentTerms.Get("Payment Terms Code");
                  PaymentTerms.TranslateDescription(PaymentTerms,"Language Code");
                end;
                if "Prepmt. Payment Terms Code" = '' then
                  PrepmtPaymentTerms.Init
                else begin
                  PrepmtPaymentTerms.Get("Prepmt. Payment Terms Code");
                  PrepmtPaymentTerms.TranslateDescription(PrepmtPaymentTerms,"Language Code");
                end;
                if "Shipment Method Code" = '' then
                  ShipmentMethod.Init
                else begin
                  ShipmentMethod.Get("Shipment Method Code");
                  ShipmentMethod.TranslateDescription(ShipmentMethod,"Language Code");
                end;

                FormatAddr.PurchHeaderShipTo(ShipToAddr,"Purchase Header");

                if not CurrReport.Preview then begin
                  if ArchiveDocument then
                    ArchiveManagement.StorePurchDocument("Purchase Header",LogInteraction);

                  if LogInteraction then begin
                    CalcFields("No. of Archived Versions");
                    SegManagement.LogDocument(
                      13,"No.","Doc. No. Occurrence","No. of Archived Versions",Database::Vendor,"Buy-from Vendor No.",
                      "Purchaser Code",'',"Posting Description",'');
                  end;
                end;
                PricesInclVATtxt := Format("Prices Including VAT");
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(NoofCopies;NoOfCopies)
                    {
                        ApplicationArea = Basic;
                        Caption = 'No. of Copies';
                        Visible = false;
                    }
                    field(ShowInternalInformation;ShowInternalInfo)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Show Internal Information';
                    }
                    field(ArchiveDocument;ArchiveDocument)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Archive Document';

                        trigger OnValidate()
                        begin
                            if not ArchiveDocument then
                              LogInteraction := false;
                        end;
                    }
                    field(LogInteraction;LogInteraction)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;

                        trigger OnValidate()
                        begin
                            if LogInteraction then
                              ArchiveDocument := ArchiveDocumentEnable;
                        end;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            LogInteractionEnable := true;
        end;

        trigger OnOpenPage()
        begin
            ArchiveDocument := PurchSetup."Archive Quotes and Orders";
            LogInteraction := SegManagement.FindInteractTmplCode(13) <> '';

            LogInteractionEnable := LogInteraction;
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        GLSetup.Get;
        PurchSetup.Get;
    end;

    var
        Text000: label 'Purchaser';
        Text001: label 'Total %1';
        Text002: label 'Total %1 Incl. VAT';
        Text003: label 'REPRINT COPY';
        Text004: label 'Order%1';
        Text005: label 'Page %1';
        Text006: label 'Total %1 Excl. VAT';
        GLSetup: Record "General Ledger Setup";
        CompanyInfo: Record "Company Information";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        PrepmtPaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        VATAmountLine: Record "VAT Amount Line" temporary;
        PrepmtVATAmountLine: Record "VAT Amount Line" temporary;
        PrePmtVATAmountLineDeduct: Record "VAT Amount Line" temporary;
        PurchLine: Record "Purchase Line" temporary;
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        PrepmtDimSetEntry: Record "Dimension Set Entry";
        PrepmtInvBuf: Record "Prepayment Inv. Line Buffer" temporary;
        RespCenter: Record "Responsibility Center";
        Language: Record Language;
        CurrExchRate: Record "Currency Exchange Rate";
        PurchSetup: Record "Purchases & Payables Setup";
        PurchCountPrinted: Codeunit "Purch.Header-Printed";
        FormatAddr: Codeunit "Format Address";
        PurchPost: Codeunit "Purch.-Post";
        ArchiveManagement: Codeunit ArchiveManagement;
        SegManagement: Codeunit SegManagement;
        PurchPostPrepmt: Codeunit "Purchase-Post Prepayments";
        VendAddr: array [8] of Text[50];
        ShipToAddr: array [8] of Text[50];
        CompanyAddr: array [8] of Text[50];
        BuyFromAddr: array [8] of Text[50];
        PurchaserText: Text[30];
        VATNoText: Text[80];
        ReferenceText: Text[80];
        TotalText: Text[50];
        TotalInclVATText: Text[50];
        TotalExclVATText: Text[50];
        MoreLines: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        OutputNo: Integer;
        DimText: Text[120];
        OldDimText: Text[75];
        ShowInternalInfo: Boolean;
        Continue: Boolean;
        ArchiveDocument: Boolean;
        LogInteraction: Boolean;
        VATAmount: Decimal;
        VATBaseAmount: Decimal;
        VATDiscountAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        VALVATBaseLCY: Decimal;
        VALVATAmountLCY: Decimal;
        VALSpecLCYHeader: Text[80];
        VALExchRate: Text[50];
        Text007: label 'VAT Amount Specification in ';
        Text008: label 'Local Currency';
        Text009: label 'Exchange rate: %1/%2';
        PrepmtVATAmount: Decimal;
        PrepmtVATBaseAmount: Decimal;
        PrepmtTotalAmountInclVAT: Decimal;
        PrepmtLineAmount: Decimal;
        PricesInclVATtxt: Text[30];
        AllowInvDisctxt: Text[30];
        [InDataSet]
        ArchiveDocumentEnable: Boolean;
        [InDataSet]
        LogInteractionEnable: Boolean;
        TotalSubTotal: Decimal;
        TotalAmount: Decimal;
        TotalInvoiceDiscountAmount: Decimal;
        CompanyInfoPhoneNoCaptionLbl: label 'Phone No.';
        CompanyInfoVATRegNoCaptionLbl: label 'VAT Registration No.';
        CompanyInfoGiroNoCaptionLbl: label 'Giro No.';
        CompanyInfoBankNameCaptionLbl: label 'Bank';
        CompanyInfoBankAccNoCaptionLbl: label 'Account No.';
        OrderNoCaptionLbl: label 'Order No.';
        PageCaptionLbl: label 'Page';
        DocumentDateCaptionLbl: label 'Document Date';
        HdrDimCaptionLbl: label 'Header Dimensions';
        DirectUniCostCaptionLbl: label 'Direct Unit Cost';
        PurchLineLineDiscCaptionLbl: label 'Discount %';
        VATDiscountAmountCaptionLbl: label 'Payment Discount on VAT';
        LineDimCaptionLbl: label 'Line Dimensions';
        PaymentDetailsCaptionLbl: label 'Payment Details';
        VendNoCaptionLbl: label 'Vendor No.';
        ShiptoAddressCaptionLbl: label 'Ship-to Address';
        PrepmtInvBuDescCaptionLbl: label 'Description';
        PrepmtInvBufGLAccNoCaptionLbl: label 'G/L Account No.';
        PrepaymentSpecCaptionLbl: label 'Prepayment Specification';
        PrepymtVATAmtSpecCaptionLbl: label 'Prepayment VAT Amount Specification';
        AmountCaptionLbl: label 'Amount';
        PurchLineInvDiscAmtCaptionLbl: label 'Invoice Discount Amount';
        SubtotalCaptionLbl: label 'Subtotal';
        VATAmtLineVATCaptionLbl: label 'VAT %';
        VATAmtLineVATAmtCaptionLbl: label 'VAT Amount';
        VATAmtSpecCaptionLbl: label 'VAT Amount Specification';
        VATIdentifierCaptionLbl: label 'VAT Identifier';
        VATAmtLineInvDiscBaseAmtCaptionLbl: label 'Invoice Discount Base Amount';
        VATAmtLineLineAmtCaptionLbl: label 'Line Amount';
        VALVATBaseLCYCaptionLbl: label 'VAT Base';
        TotalCaptionLbl: label 'Total';
        PaymentTermsDescCaptionLbl: label 'Payment Terms';
        ShipmentMethodDescCaptionLbl: label 'Shipment Method';
        PrepymtTermsDescCaptionLbl: label 'Prepmt. Payment Terms';
        HomePageCaptionLbl: label 'Home Page';
        EmailIDCaptionLbl: label 'E-Mail';
        AllowInvoiceDiscCaptionLbl: label 'Allow Invoice Discount';
        PurchLines: Record "Purchase Line";
        NumberText: array [2] of Text[120];
        CheckReport: Report Check;
        LPOText: Text;
        Start: Boolean;
        RecordSeQ: Integer;
        CurrencyText: Code[10];


    procedure InitializeRequest(NewNoOfCopies: Integer;NewShowInternalInfo: Boolean;NewArchiveDocument: Boolean;NewLogInteraction: Boolean)
    begin
        NoOfCopies := NewNoOfCopies;
        ShowInternalInfo := NewShowInternalInfo;
        ArchiveDocument := NewArchiveDocument;
        LogInteraction := NewLogInteraction;
    end;
}

