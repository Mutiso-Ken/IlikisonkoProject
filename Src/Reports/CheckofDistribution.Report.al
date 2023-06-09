#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516881 "Check of Distribution"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Check of Distribution.rdlc';
    Caption = 'General Journal - Test';

    dataset
    {
        dataitem("Gen. Journal Batch";"Gen. Journal Batch")
        {
            DataItemTableView = sorting("Journal Template Name",Name);
            column(ReportForNavId_3502; 3502)
            {
            }
            column(JnlTmplName_GenJnlBatch;"Journal Template Name")
            {
            }
            column(Name_GenJnlBatch;Name)
            {
            }
            column(CompanyName;CompanyInformation.Name)
            {
            }
            column(GeneralJnlTestCaption;GeneralJnlTestCap)
            {
            }
            dataitem("Integer";"Integer")
            {
                DataItemTableView = sorting(Number) where(Number=const(1));
                PrintOnlyIfDetail = true;
                column(ReportForNavId_5444; 5444)
                {
                }
                column(JnlTemplateName_GenJnlBatch;"Gen. Journal Batch"."Journal Template Name")
                {
                }
                column(JnlName_GenJnlBatch;"Gen. Journal Batch".Name)
                {
                }
                column(GenJnlLineFilter;GenJnlLineFilter)
                {
                }
                column(GenJnlTemplForceDocBal;GenJnlTemplate."Force Doc. Balance")
                {
                }
                column(GenJnlLineFilterTableCaption;"Gen. Journal Line".TableCaption + ': ' + GenJnlLineFilter)
                {
                }
                column(USText001;USText001)
                {
                }
                column(ShowDim;ShowDim)
                {
                }
                column(PageNoCaption;PageNoCap)
                {
                }
                column(JnlTmplNameCaption_GenJnlBatch;"Gen. Journal Batch".FieldCaption("Journal Template Name"))
                {
                }
                column(JournalBatchCaption;JnlBatchNameCap)
                {
                }
                column(PostingDateCaption;PostingDateCap)
                {
                }
                column(DocumentTypeCaption;DocumentTypeCap)
                {
                }
                column(DocNoCaption_GenJnlLine;"Gen. Journal Line".FieldCaption("Document No."))
                {
                }
                column(AccountTypeCaption;AccountTypeCap)
                {
                }
                column(AccNoCaption_GenJnlLine;"Gen. Journal Line".FieldCaption("Account No."))
                {
                }
                column(AccNameCaption;AccNameCap)
                {
                }
                column(DescCaption_GenJnlLine;"Gen. Journal Line".FieldCaption(Description))
                {
                }
                column(PostingTypeCaption;GenPostingTypeCap)
                {
                }
                column(GenBusPostGroupCaption;GenBusPostingGroupCap)
                {
                }
                column(GenProdPostGroupCaption;GenProdPostingGroupCap)
                {
                }
                column(AmountCaption_GenJnlLine;"Gen. Journal Line".FieldCaption(Amount))
                {
                }
                column(BalAccNoCaption_GenJnlLine;"Gen. Journal Line".FieldCaption("Bal. Account No."))
                {
                }
                column(BalLCYCaption_GenJnlLine;"Gen. Journal Line".FieldCaption("Balance (LCY)"))
                {
                }
                dataitem("Gen. Journal Line";"Gen. Journal Line")
                {
                    DataItemLink = "Journal Template Name"=field("Journal Template Name"),"Journal Batch Name"=field(Name);
                    DataItemLinkReference = "Gen. Journal Batch";
                    DataItemTableView = sorting("Journal Template Name","Journal Batch Name","Line No.");
                    RequestFilterFields = "Posting Date";
                    column(ReportForNavId_7024; 7024)
                    {
                    }
                    column(PostingDate_GenJnlLine;Format("Posting Date"))
                    {
                    }
                    column(DocType_GenJnlLine;"Document Type")
                    {
                    }
                    column(DocNo_GenJnlLine;"Document No.")
                    {
                    }
                    column(AccountType_GenJnlLine;"Account Type")
                    {
                    }
                    column(AccountNo_GenJnlLine;"Account No.")
                    {
                    }
                    column(AccName;AccName)
                    {
                    }
                    column(Description_GenJnlLine;Description)
                    {
                    }
                    column(GenPostType_GenJnlLine;"Gen. Posting Type")
                    {
                    }
                    column(GenBusPosGroup_GenJnlLine;"Gen. Bus. Posting Group")
                    {
                    }
                    column(GenProdPostGroup_GenJnlLine;"Gen. Prod. Posting Group")
                    {
                    }
                    column(Amount_GenJnlLine;Amount)
                    {
                    }
                    column(CurrencyCode_GenJnlLine;"Currency Code")
                    {
                    }
                    column(BalAccNo_GenJnlLine;"Bal. Account No.")
                    {
                    }
                    column(BalanceLCY_GenJnlLine;"Balance (LCY)")
                    {
                    }
                    column(AmountLCY;AmountLCY)
                    {
                    }
                    column(BalanceLCY;BalanceLCY)
                    {
                    }
                    column(AmountLCY_GenJnlLine;"Amount (LCY)")
                    {
                    }
                    column(JnlTmplName_GenJnlLine;"Journal Template Name")
                    {
                    }
                    column(JnlBatchName_GenJnlLine;"Journal Batch Name")
                    {
                    }
                    column(LineNo_GenJnlLine;"Line No.")
                    {
                    }
                    column(GenJnlLineAmountLCYCaption;CaptionClassTranslate('101,0,Total (%1)'))
                    {
                    }
                    column(TransactionType_GenJournalLine;"Gen. Journal Line"."Transaction Type")
                    {
                    }
                    column(LoanNo_GenJournalLine;"Gen. Journal Line"."Loan No")
                    {
                    }
                    column(LoanProductType_GenJournalLine;"Gen. Journal Line"."Loan Product Type")
                    {
                    }
                    column(Loantype;LoanType)
                    {
                    }
                    dataitem(DimensionLoop;"Integer")
                    {
                        DataItemTableView = sorting(Number) where(Number=filter(1..));
                        column(ReportForNavId_9775; 9775)
                        {
                        }
                        column(DimText;DimText)
                        {
                        }
                        column(Number_DimensionLoop;Number)
                        {
                        }
                        column(DimensionsCaption;DimensionsCap)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            if Number = 1 then begin
                              if not DimSetEntry.FindFirst then
                                CurrReport.Break;
                            end else
                              if not Continue then
                                CurrReport.Break;

                            DimText := GetDimensionText(DimSetEntry);
                        end;

                        trigger OnPreDataItem()
                        begin
                            if not ShowDim then
                              CurrReport.Break;
                            DimSetEntry.Reset;
                            DimSetEntry.SetRange("Dimension Set ID","Gen. Journal Line"."Dimension Set ID")
                        end;
                    }
                    dataitem("Gen. Jnl. Allocation";"Gen. Jnl. Allocation")
                    {
                        DataItemLink = "Journal Template Name"=field("Journal Template Name"),"Journal Batch Name"=field("Journal Batch Name"),"Journal Line No."=field("Line No.");
                        DataItemTableView = sorting("Journal Template Name","Journal Batch Name","Journal Line No.","Line No.");
                        column(ReportForNavId_100; 100)
                        {
                        }
                        column(AccountNo_GenJnlAllocation;"Account No.")
                        {
                        }
                        column(AccountName_GenJnlAllocation;"Account Name")
                        {
                        }
                        column(AllocationQuantity_GenJnlAllocation;"Allocation Quantity")
                        {
                        }
                        column(AllocationPct_GenJnlAllocation;"Allocation %")
                        {
                        }
                        column(Amount_GenJnlAllocation;Amount)
                        {
                        }
                        column(JournalLineNo_GenJnlAllocation;"Journal Line No.")
                        {
                        }
                        column(LineNo_GenJnlAllocation;"Line No.")
                        {
                        }
                        column(JournalBatchName_GenJnlAllocation;"Journal Batch Name")
                        {
                        }
                        column(AccountNoCaption_GenJnlAllocation;FieldCaption("Account No."))
                        {
                        }
                        column(AccountNameCaption_GenJnlAllocation;FieldCaption("Account Name"))
                        {
                        }
                        column(AllocationQuantityCaption_GenJnlAllocation;FieldCaption("Allocation Quantity"))
                        {
                        }
                        column(AllocationPctCaption_GenJnlAllocation;FieldCaption("Allocation %"))
                        {
                        }
                        column(AmountCaption_GenJnlAllocation;FieldCaption(Amount))
                        {
                        }
                        column(Recurring_GenJnlTemplate;GenJnlTemplate.Recurring)
                        {
                        }
                        dataitem(DimensionLoopAllocations;"Integer")
                        {
                            DataItemTableView = sorting(Number) where(Number=filter(1..));
                            column(ReportForNavId_114; 114)
                            {
                            }
                            column(AllocationDimText;AllocationDimText)
                            {
                            }
                            column(Number_DimensionLoopAllocations;Number)
                            {
                            }
                            column(DimensionAllocationsCaption;DimensionAllocationsCap)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                if Number = 1 then begin
                                  if not DimSetEntry.FindFirst then
                                    CurrReport.Break;
                                end else
                                  if not Continue then
                                    CurrReport.Break;

                                AllocationDimText := GetDimensionText(DimSetEntry);
                            end;

                            trigger OnPreDataItem()
                            begin
                                if not ShowDim then
                                  CurrReport.Break;
                                DimSetEntry.Reset;
                                DimSetEntry.SetRange("Dimension Set ID","Gen. Jnl. Allocation"."Dimension Set ID")
                            end;
                        }
                    }
                    dataitem(ErrorLoop;"Integer")
                    {
                        DataItemTableView = sorting(Number);
                        column(ReportForNavId_1162; 1162)
                        {
                        }
                        column(ErrorTextNumber;ErrorText[Number])
                        {
                        }
                        column(WarningCaption;WarningCap)
                        {
                        }

                        trigger OnPostDataItem()
                        begin
                            ErrorCounter := 0;
                        end;

                        trigger OnPreDataItem()
                        begin
                            SetRange(Number,1,ErrorCounter);
                        end;
                    }

                    trigger OnAfterGetRecord()
                    var
                        PaymentTerms: Record "Payment Terms";
                        DimMgt: Codeunit DimensionManagement;
                        TableID: array [10] of Integer;
                        No: array [10] of Code[20];
                    begin
                        if "Currency Code" = '' then
                          "Amount (LCY)" := Amount;

                        UpdateLineBalance;

                        AccName := '';
                        BalAccName := '';

                        if not EmptyLine then begin
                          MakeRecurringTexts("Gen. Journal Line");

                          AmountError := false;

                          if ("Account No." = '') and ("Bal. Account No." = '') then
                            AddError(StrSubstNo(Text001,FieldCaption("Account No."),FieldCaption("Bal. Account No.")))
                          else
                            if ("Account Type" <> "account type"::"Fixed Asset") and
                               ("Bal. Account Type" <> "bal. account type"::"Fixed Asset")
                            then
                              TestFixedAssetFields("Gen. Journal Line");
                          CheckICDocument;
                          if "Account No." <> '' then
                            case "Account Type" of
                              "account type"::"G/L Account":
                                begin
                                  if ("Gen. Bus. Posting Group" <> '') or ("Gen. Prod. Posting Group" <> '') or
                                     ("VAT Bus. Posting Group" <> '') or ("VAT Prod. Posting Group" <> '')
                                  then begin
                                    if "Gen. Posting Type" = 0 then
                                      AddError(StrSubstNo(Text002,FieldCaption("Gen. Posting Type")));
                                  end;
                                  if ("Gen. Posting Type" <> "gen. posting type"::" ") and
                                     ("VAT Posting" = "vat posting"::"Automatic VAT Entry")
                                  then begin
                                    if "VAT Amount" + "VAT Base Amount" <> Amount then
                                      AddError(
                                        StrSubstNo(
                                          Text003,FieldCaption("VAT Amount"),FieldCaption("VAT Base Amount"),
                                          FieldCaption(Amount)));
                                    if "Currency Code" <> '' then
                                      if "VAT Amount (LCY)" + "VAT Base Amount (LCY)" <> "Amount (LCY)" then
                                        AddError(
                                          StrSubstNo(
                                            Text003,FieldCaption("VAT Amount (LCY)"),
                                            FieldCaption("VAT Base Amount (LCY)"),FieldCaption("Amount (LCY)")));
                                  end;
                                  TestJobFields("Gen. Journal Line");
                                end;
                              "account type"::Customer,"account type"::Vendor:
                                begin
                                  if "Gen. Posting Type" <> 0 then
                                    AddError(
                                      StrSubstNo(
                                        Text004,
                                        FieldCaption("Gen. Posting Type"),FieldCaption("Account Type"),"Account Type"));
                                  if ("Gen. Bus. Posting Group" <> '') or ("Gen. Prod. Posting Group" <> '') or
                                     ("VAT Bus. Posting Group" <> '') or ("VAT Prod. Posting Group" <> '')
                                  then
                                    AddError(
                                      StrSubstNo(
                                        Text005,
                                        FieldCaption("Gen. Bus. Posting Group"),FieldCaption("Gen. Prod. Posting Group"),
                                        FieldCaption("VAT Bus. Posting Group"),FieldCaption("VAT Prod. Posting Group"),
                                        FieldCaption("Account Type"),"Account Type"));

                                  if "Document Type" <> 0 then begin
                                    if "Account Type" = "account type"::Customer then
                                      case "Document Type" of
                                        "document type"::"Credit Memo":
                                          WarningIfPositiveAmt("Gen. Journal Line");
                                        "document type"::Payment:
                                          if ("Applies-to Doc. Type" = "applies-to doc. type"::"Credit Memo") and
                                             ("Applies-to Doc. No." <> '')
                                          then
                                            WarningIfNegativeAmt("Gen. Journal Line")
                                          else
                                            WarningIfPositiveAmt("Gen. Journal Line");
                                        "document type"::Refund:
                                          WarningIfNegativeAmt("Gen. Journal Line");
                                        else
                                          WarningIfNegativeAmt("Gen. Journal Line");
                                      end
                                    else
                                      case "Document Type" of
                                        "document type"::"Credit Memo":
                                          WarningIfNegativeAmt("Gen. Journal Line");
                                        "document type"::Payment:
                                          if ("Applies-to Doc. Type" = "applies-to doc. type"::"Credit Memo") and
                                             ("Applies-to Doc. No." <> '')
                                          then
                                            WarningIfPositiveAmt("Gen. Journal Line")
                                          else
                                            WarningIfNegativeAmt("Gen. Journal Line");
                                        "document type"::Refund:
                                          WarningIfPositiveAmt("Gen. Journal Line");
                                        else
                                          WarningIfPositiveAmt("Gen. Journal Line");
                                      end
                                  end;

                                  if Amount * "Sales/Purch. (LCY)" < 0 then
                                    AddError(
                                      StrSubstNo(
                                        Text008,
                                        FieldCaption("Sales/Purch. (LCY)"),FieldCaption(Amount)));
                                  if "Job No." <> '' then
                                    AddError(StrSubstNo(Text009,FieldCaption("Job No.")));
                                end;
                              "account type"::"Bank Account":
                                begin
                                  if "Gen. Posting Type" <> 0 then
                                    AddError(
                                      StrSubstNo(
                                        Text004,
                                        FieldCaption("Gen. Posting Type"),FieldCaption("Account Type"),"Account Type"));
                                  if ("Gen. Bus. Posting Group" <> '') or ("Gen. Prod. Posting Group" <> '') or
                                     ("VAT Bus. Posting Group" <> '') or ("VAT Prod. Posting Group" <> '')
                                  then
                                    AddError(
                                      StrSubstNo(
                                        Text005,
                                        FieldCaption("Gen. Bus. Posting Group"),FieldCaption("Gen. Prod. Posting Group"),
                                        FieldCaption("VAT Bus. Posting Group"),FieldCaption("VAT Prod. Posting Group"),
                                        FieldCaption("Account Type"),"Account Type"));

                                  if "Job No." <> '' then
                                    AddError(StrSubstNo(Text009,FieldCaption("Job No.")));
                                  if (Amount < 0) and ("Bank Payment Type" = "bank payment type"::"Computer Check") then
                                    if not "Check Printed" then
                                      AddError(StrSubstNo(Text010,FieldCaption("Check Printed")));
                                end;
                              "account type"::"Fixed Asset":
                                TestFixedAsset("Gen. Journal Line");
                            end;

                          if "Bal. Account No." <> '' then
                            case "Bal. Account Type" of
                              "bal. account type"::"G/L Account":
                                begin
                                  if ("Bal. Gen. Bus. Posting Group" <> '') or ("Bal. Gen. Prod. Posting Group" <> '') or
                                     ("Bal. VAT Bus. Posting Group" <> '') or ("Bal. VAT Prod. Posting Group" <> '')
                                  then begin
                                    if "Bal. Gen. Posting Type" = 0 then
                                      AddError(StrSubstNo(Text002,FieldCaption("Bal. Gen. Posting Type")));
                                  end;
                                  if ("Bal. Gen. Posting Type" <> "bal. gen. posting type"::" ") and
                                     ("VAT Posting" = "vat posting"::"Automatic VAT Entry")
                                  then begin
                                    if "Bal. VAT Amount" + "Bal. VAT Base Amount" <> -Amount then
                                      AddError(
                                        StrSubstNo(
                                          Text011,FieldCaption("Bal. VAT Amount"),FieldCaption("Bal. VAT Base Amount"),
                                          FieldCaption(Amount)));
                                    if "Currency Code" <> '' then
                                      if "Bal. VAT Amount (LCY)" + "Bal. VAT Base Amount (LCY)" <> -"Amount (LCY)" then
                                        AddError(
                                          StrSubstNo(
                                            Text011,FieldCaption("Bal. VAT Amount (LCY)"),
                                            FieldCaption("Bal. VAT Base Amount (LCY)"),FieldCaption("Amount (LCY)")));
                                  end;
                                end;
                              "bal. account type"::Customer,"bal. account type"::Vendor:
                                begin
                                  if "Bal. Gen. Posting Type" <> 0 then
                                    AddError(
                                      StrSubstNo(
                                        Text004,
                                        FieldCaption("Bal. Gen. Posting Type"),FieldCaption("Bal. Account Type"),"Bal. Account Type"));
                                  if ("Bal. Gen. Bus. Posting Group" <> '') or ("Bal. Gen. Prod. Posting Group" <> '') or
                                     ("Bal. VAT Bus. Posting Group" <> '') or ("Bal. VAT Prod. Posting Group" <> '')
                                  then
                                    AddError(
                                      StrSubstNo(
                                        Text005,
                                        FieldCaption("Bal. Gen. Bus. Posting Group"),FieldCaption("Bal. Gen. Prod. Posting Group"),
                                        FieldCaption("Bal. VAT Bus. Posting Group"),FieldCaption("Bal. VAT Prod. Posting Group"),
                                        FieldCaption("Bal. Account Type"),"Bal. Account Type"));

                                  if "Document Type" <> 0 then begin
                                    if ("Bal. Account Type" = "bal. account type"::Customer) =
                                       ("Document Type" in ["document type"::Payment,"document type"::"Credit Memo"])
                                    then
                                      WarningIfNegativeAmt("Gen. Journal Line")
                                    else
                                      WarningIfPositiveAmt("Gen. Journal Line")
                                  end;
                                  if Amount * "Sales/Purch. (LCY)" > 0 then
                                    AddError(
                                      StrSubstNo(
                                        Text012,
                                        FieldCaption("Sales/Purch. (LCY)"),FieldCaption(Amount)));
                                  if "Job No." <> '' then
                                    AddError(StrSubstNo(Text009,FieldCaption("Job No.")));
                                end;
                              "bal. account type"::"Bank Account":
                                begin
                                  if "Bal. Gen. Posting Type" <> 0 then
                                    AddError(
                                      StrSubstNo(
                                        Text004,
                                        FieldCaption("Bal. Gen. Posting Type"),FieldCaption("Bal. Account Type"),"Bal. Account Type"));
                                  if ("Bal. Gen. Bus. Posting Group" <> '') or ("Bal. Gen. Prod. Posting Group" <> '') or
                                     ("Bal. VAT Bus. Posting Group" <> '') or ("Bal. VAT Prod. Posting Group" <> '')
                                  then
                                    AddError(
                                      StrSubstNo(
                                        Text005,
                                        FieldCaption("Bal. Gen. Bus. Posting Group"),FieldCaption("Bal. Gen. Prod. Posting Group"),
                                        FieldCaption("Bal. VAT Bus. Posting Group"),FieldCaption("Bal. VAT Prod. Posting Group"),
                                        FieldCaption("Bal. Account Type"),"Bal. Account Type"));

                                  if "Job No." <> '' then
                                    AddError(StrSubstNo(Text009,FieldCaption("Job No.")));
                                  if (Amount > 0) and ("Bank Payment Type" = "bank payment type"::"Computer Check") then
                                    if not "Check Printed" then
                                      AddError(StrSubstNo(Text010,FieldCaption("Check Printed")));
                                end;
                              "bal. account type"::"Fixed Asset":
                                TestFixedAsset("Gen. Journal Line");
                            end;

                          if ("Account No." <> '') and
                             not "System-Created Entry" and
                             (Amount = 0) and
                             not GenJnlTemplate.Recurring and
                             not "Allow Zero-Amount Posting" and
                             ("Account Type" <> "account type"::"Fixed Asset")
                          then
                            WarningIfZeroAmt("Gen. Journal Line");

                          CheckRecurringLine("Gen. Journal Line");
                          CheckAllocations("Gen. Journal Line");

                          if "Posting Date" = 0D then
                            AddError(StrSubstNo(Text002,FieldCaption("Posting Date")))
                          else begin
                            if "Posting Date" <> NormalDate("Posting Date") then
                              if ("Account Type" <> "account type"::"G/L Account") or
                                 ("Bal. Account Type" <> "bal. account type"::"G/L Account")
                              then
                                AddError(
                                  StrSubstNo(
                                    Text013,FieldCaption("Posting Date")));

                            if (AllowPostingFrom = 0D) and (AllowPostingTo = 0D) then begin
                              if UserId <> '' then
                                if UserSetup.Get(UserId) then begin
                                  AllowPostingFrom := UserSetup."Allow Posting From";
                                  AllowPostingTo := UserSetup."Allow Posting To";
                                end;
                              if (AllowPostingFrom = 0D) and (AllowPostingTo = 0D) then begin
                                AllowPostingFrom := GLSetup."Allow Posting From";
                                AllowPostingTo := GLSetup."Allow Posting To";
                              end;
                              if AllowPostingTo = 0D then
                                AllowPostingTo := Dmy2date(31,12,9999);
                            end;
                            if ("Posting Date" < AllowPostingFrom) or ("Posting Date" > AllowPostingTo) then
                              AddError(
                                StrSubstNo(
                                  Text014,Format("Posting Date")));

                            if "Gen. Journal Batch"."No. Series" <> '' then begin
                              if NoSeries."Date Order" and ("Posting Date" < LastEntrdDate) then
                                AddError(Text015);
                              LastEntrdDate := "Posting Date";
                            end;
                          end;

                          if "Document Date" <> 0D then
                            if ("Document Date" <> NormalDate("Document Date")) and
                               (("Account Type" <> "account type"::"G/L Account") or
                                ("Bal. Account Type" <> "bal. account type"::"G/L Account"))
                            then
                              AddError(
                                StrSubstNo(
                                  Text013,FieldCaption("Document Date")));

                          if "Document No." = '' then
                            AddError(StrSubstNo(Text002,FieldCaption("Document No.")))
                          else
                            if "Gen. Journal Batch"."No. Series" <> '' then begin
                              if (LastEntrdDocNo <> '') and
                                 ("Document No." <> LastEntrdDocNo) and
                                 ("Document No." <> IncStr(LastEntrdDocNo))
                              then
                                AddError(Text016);
                              LastEntrdDocNo := "Document No.";
                            end;

                          if ("Account Type" in ["account type"::Customer,"account type"::Vendor,"account type"::"Fixed Asset"]) and
                             ("Bal. Account Type" in ["bal. account type"::Customer,"bal. account type"::Vendor,"bal. account type"::"Fixed Asset"])
                          then
                            AddError(
                              StrSubstNo(
                                Text017,
                                FieldCaption("Account Type"),FieldCaption("Bal. Account Type")));

                          if Amount * "Amount (LCY)" < 0 then
                            AddError(
                              StrSubstNo(
                                Text008,FieldCaption("Amount (LCY)"),FieldCaption(Amount)));

                          if ("Account Type" = "account type"::"G/L Account") and
                             ("Bal. Account Type" = "bal. account type"::"G/L Account")
                          then
                            if "Applies-to Doc. No." <> '' then
                              AddError(StrSubstNo(Text009,FieldCaption("Applies-to Doc. No.")));

                          if (("Account Type" = "account type"::"G/L Account") and
                              ("Bal. Account Type" = "bal. account type"::"G/L Account")) or
                             ("Document Type" <> "document type"::Invoice)
                          then
                            if PaymentTerms.Get("Payment Terms Code") then begin
                              if ("Document Type" = "document type"::"Credit Memo") and
                                 (not PaymentTerms."Calc. Pmt. Disc. on Cr. Memos")
                              then begin
                                if "Pmt. Discount Date" <> 0D then
                                  AddError(StrSubstNo(Text009,FieldCaption("Pmt. Discount Date")));
                                if "Payment Discount %" <> 0 then
                                  AddError(StrSubstNo(Text018,FieldCaption("Payment Discount %")));
                              end;
                            end else begin
                              if "Pmt. Discount Date" <> 0D then
                                AddError(StrSubstNo(Text009,FieldCaption("Pmt. Discount Date")));
                              if "Payment Discount %" <> 0 then
                                AddError(StrSubstNo(Text018,FieldCaption("Payment Discount %")));
                            end;

                          if (("Account Type" = "account type"::"G/L Account") and
                              ("Bal. Account Type" = "bal. account type"::"G/L Account")) or
                             ("Applies-to Doc. No." <> '')
                          then
                            if "Applies-to ID" <> '' then
                              AddError(StrSubstNo(Text009,FieldCaption("Applies-to ID")));

                          if ("Account Type" <> "account type"::"Bank Account") and
                             ("Bal. Account Type" <> "bal. account type"::"Bank Account")
                          then
                            if GenJnlLine2."Bank Payment Type" > 0 then
                              AddError(StrSubstNo(Text009,FieldCaption("Bank Payment Type")));

                          if ("Account No." <> '') and ("Bal. Account No." <> '') then begin
                            PurchPostingType := false;
                            SalesPostingType := false;
                          end;
                          if "Account No." <> '' then
                            case "Account Type" of
                              "account type"::"G/L Account":
                                CheckGLAcc("Gen. Journal Line",AccName);
                              "account type"::Customer:
                                CheckCust("Gen. Journal Line",AccName);
                              "account type"::Member:
                                CheckMember("Gen. Journal Line",AccName);
                              "account type"::Vendor:
                                CheckVend("Gen. Journal Line",AccName);
                              "account type"::"Bank Account":
                                CheckBankAcc("Gen. Journal Line",AccName);
                              "account type"::"Fixed Asset":
                                CheckFixedAsset("Gen. Journal Line",AccName);
                              "account type"::Employee:
                                CheckICPartner("Gen. Journal Line",AccName);
                            end;
                          if "Bal. Account No." <> '' then begin
                            Codeunit.Run(Codeunit::"Exchange Acc. G/L Journal Line","Gen. Journal Line");
                            case "Account Type" of
                              "account type"::"G/L Account":
                                CheckGLAcc("Gen. Journal Line",BalAccName);
                              "account type"::Customer:
                                CheckCust("Gen. Journal Line",BalAccName);
                              "account type"::Vendor:
                                CheckVend("Gen. Journal Line",BalAccName);
                              "account type"::"Bank Account":
                                CheckBankAcc("Gen. Journal Line",BalAccName);
                              "account type"::"Fixed Asset":
                                CheckFixedAsset("Gen. Journal Line",BalAccName);
                              "account type"::Employee:
                                CheckICPartner("Gen. Journal Line",AccName);
                            end;
                            Codeunit.Run(Codeunit::"Exchange Acc. G/L Journal Line","Gen. Journal Line");
                          end;

                          if not DimMgt.CheckDimIDComb("Gen. Journal Line"."Dimension Set ID") then
                            AddError(DimMgt.GetDimCombErr);

                          TableID[1] := DimMgt.TypeToTableID1("Account Type");
                          No[1] := "Account No.";
                          TableID[2] := DimMgt.TypeToTableID1("Bal. Account Type");
                          No[2] := "Bal. Account No.";
                          TableID[3] := Database::Job;
                          No[3] := "Job No.";
                          TableID[4] := Database::"Salesperson/Purchaser";
                          No[4] := "Salespers./Purch. Code";
                          TableID[5] := Database::Campaign;
                          No[5] := "Campaign No.";
                          if not DimMgt.CheckDimValuePosting(TableID,No,"Gen. Journal Line"."Dimension Set ID") then
                            AddError(DimMgt.GetDimValuePostingErr);
                        end;

                        CheckBalance;
                        AmountLCY := AmountLCY + "Gen. Journal Line"."Amount (LCY)";
                        BalanceLCY := BalanceLCY + "Gen. Journal Line"."Balance (LCY)";
                    end;

                    trigger OnPreDataItem()
                    begin
                        Copyfilter("Journal Batch Name","Gen. Journal Batch".Name);
                        GenJnlLineFilter := GetFilters;

                        GenJnlTemplate.Get("Gen. Journal Batch"."Journal Template Name");
                        if GenJnlTemplate.Recurring then begin
                          if GetFilter("Posting Date") <> '' then
                            AddError(
                              StrSubstNo(
                                Text000,
                                FieldCaption("Posting Date")));
                          SetRange("Posting Date",0D,WorkDate);
                          if GetFilter("Expiration Date") <> '' then
                            AddError(
                              StrSubstNo(
                                Text000,
                                FieldCaption("Expiration Date")));
                          SetFilter("Expiration Date",'%1 | %2..',0D,WorkDate);
                        end;

                        if "Gen. Journal Batch"."No. Series" <> '' then begin
                          NoSeries.Get("Gen. Journal Batch"."No. Series");
                          LastEntrdDocNo := '';
                          LastEntrdDate := 0D;
                        end;

                        CurrentCustomerVendors := 0;
                        VATEntryCreated := false;

                        GenJnlLine2.Reset;
                        GenJnlLine2.CopyFilters("Gen. Journal Line");

                        GLAccNetChange.DeleteAll;
                        CurrReport.CreateTotals("Amount (LCY)","Balance (LCY)");
                        AmountLCY := 0;
                        BalanceLCY := 0;
                    end;
                }
                dataitem(ReconcileLoop;"Integer")
                {
                    DataItemTableView = sorting(Number);
                    column(ReportForNavId_5127; 5127)
                    {
                    }
                    column(GLAccNetChangeNo;GLAccNetChange."No.")
                    {
                    }
                    column(GLAccNetChangeName;GLAccNetChange.Name)
                    {
                    }
                    column(GLAccNetChangeNetChangeJnl;GLAccNetChange."Net Change in Jnl.")
                    {
                    }
                    column(GLAccNetChangeBalafterPost;GLAccNetChange."Balance after Posting")
                    {
                    }
                    column(ReconciliationCaption;ReconciliationCap)
                    {
                    }
                    column(NoCaption;NoCap)
                    {
                    }
                    column(NameCaption;NameCap)
                    {
                    }
                    column(NetChangeinJnlCaption;NetChangeinJnlCap)
                    {
                    }
                    column(BalafterPostingCaption;BalafterPostingCap)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        if Number = 1 then
                          GLAccNetChange.Find('-')
                        else
                          GLAccNetChange.Next;
                    end;

                    trigger OnPostDataItem()
                    begin
                        GLAccNetChange.DeleteAll;
                    end;

                    trigger OnPreDataItem()
                    begin
                        SetRange(Number,1,GLAccNetChange.Count);
                    end;
                }
            }

            trigger OnAfterGetRecord()
            begin
                "Journal Template Name":='GENERAL';
                CurrReport.PageNo := 1;
                GenJnlTemplate.Get("Gen. Journal Batch"."Journal Template Name");
            end;

            trigger OnPreDataItem()
            begin
                GLSetup.Get;
                SalesSetup.Get;
                PurchSetup.Get;
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
                    field(ShowDim;ShowDim)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Show Dimensions';
                    }
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
        CompanyInformation.Get;
    end;

    var
        Text000: label '%1 cannot be filtered when you post recurring journals.';
        Text001: label '%1 or %2 must be specified.';
        Text002: label '%1 must be specified.';
        Text003: label '%1 + %2 must be %3.';
        Text004: label '%1 must be " " when %2 is %3.';
        Text005: label '%1, %2, %3 or %4 must not be completed when %5 is %6.';
        Text006: label '%1 must be negative.';
        Text007: label '%1 must be positive.';
        Text008: label '%1 must have the same sign as %2.';
        Text009: label '%1 cannot be specified.';
        Text010: label '%1 must be Yes.';
        Text011: label '%1 + %2 must be -%3.';
        Text012: label '%1 must have a different sign than %2.';
        Text013: label '%1 must only be a closing date for G/L entries.';
        Text014: label '%1 is not within your allowed range of posting dates.';
        Text015: label 'The lines are not listed according to Posting Date because they were not entered in that order.';
        Text016: label 'There is a gap in the number series.';
        Text017: label '%1 or %2 must be G/L Account or Bank Account.';
        Text018: label '%1 must be 0.';
        Text019: label '%1 cannot be specified when using recurring journals.';
        Text020: label '%1 must not be %2 when %3 = %4.';
        Text021: label 'Allocations can only be used with recurring journals.';
        Text022: label 'Specify %1 in the %2 allocation lines.';
        Text023: label '<Month Text>';
        Text024: label '%1 %2 posted on %3, must be separated by an empty line.', Comment='%1 - document type, %2 - document number, %3 - posting date';
        Text025: label '%1 %2 is out of balance by %3.';
        Text026: label 'The reversing entries for %1 %2 are out of balance by %3.';
        Text027: label 'As of %1, the lines are out of balance by %2.';
        Text028: label 'As of %1, the reversing entries are out of balance by %2.';
        Text029: label 'The total of the lines is out of balance by %1.';
        Text030: label 'The total of the reversing entries is out of balance by %1.';
        Text031: label '%1 %2 does not exist.';
        Text032: label '%1 must be %2 for %3 %4.';
        Text036: label '%1 %2 %3 does not exist.';
        Text037: label '%1 must be %2.';
        Text038: label 'The currency %1 cannot be found. Check the currency table.';
        Text039: label 'Sales %1 %2 already exists.';
        Text040: label 'Purchase %1 %2 already exists.';
        Text041: label '%1 must be entered.';
        Text042: label '%1 must not be filled when %2 is different in %3 and %4.';
        Text043: label '%1 %2 must not have %3 = %4.';
        Text044: label '%1 must not be specified in fixed asset journal lines.';
        Text045: label '%1 must be specified in fixed asset journal lines.';
        Text046: label '%1 must be different than %2.';
        Text047: label '%1 and %2 must not both be %3.';
        Text049: label '%1 must not be specified when %2 = %3.';
        Text050: label 'must not be specified together with %1 = %2.';
        Text051: label '%1 must be identical to %2.';
        Text052: label '%1 cannot be a closing date.';
        Text053: label '%1 is not within your range of allowed posting dates.';
        Text054: label 'Insurance integration is not activated for %1 %2.';
        Text055: label 'must not be specified when %1 is specified.';
        Text056: label 'When G/L integration is not activated, %1 must not be posted in the general journal.';
        Text057: label 'When G/L integration is not activated, %1 must not be specified in the general journal.';
        Text058: label '%1 must not be specified.';
        Text059: label 'The combination of Customer and Gen. Posting Type Purchase is not allowed.';
        Text060: label 'The combination of Vendor and Gen. Posting Type Sales is not allowed.';
        Text061: label 'The Balance and Reversing Balance recurring methods can be used only with Allocations.';
        Text062: label '%1 must not be 0.';
        GLSetup: Record "General Ledger Setup";
        SalesSetup: Record "Sales & Receivables Setup";
        PurchSetup: Record "Purchases & Payables Setup";
        UserSetup: Record "User Setup";
        AccountingPeriod: Record "Accounting Period";
        GLAcc: Record "G/L Account";
        Currency: Record Currency;
        Cust: Record Customer;
        Memb: Record "Member Register";
        Vend: Record Vendor;
        BankAccPostingGr: Record "Bank Account Posting Group";
        BankAcc: Record "Bank Account";
        GenJnlTemplate: Record "Gen. Journal Template";
        GenJnlLine2: Record "Gen. Journal Line";
        TempGenJnlLine: Record "Gen. Journal Line" temporary;
        GenJnlAlloc: Record "Gen. Jnl. Allocation";
        OldCustLedgEntry: Record "Cust. Ledger Entry";
        OldVendLedgEntry: Record "Vendor Ledger Entry";
        VATPostingSetup: Record "VAT Posting Setup";
        NoSeries: Record "No. Series";
        FA: Record "Fixed Asset";
        ICPartner: Record "IC Partner";
        DeprBook: Record "Depreciation Book";
        FADeprBook: Record "FA Depreciation Book";
        FASetup: Record "FA Setup";
        GLAccNetChange: Record "G/L Account Net Change" temporary;
        DimSetEntry: Record "Dimension Set Entry";
        CompanyInformation: Record "Company Information";
        GenJnlLineFilter: Text;
        AllowPostingFrom: Date;
        AllowPostingTo: Date;
        AllowFAPostingFrom: Date;
        AllowFAPostingTo: Date;
        LastDate: Date;
        LastDocType: Option Document,Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder;
        LastDocNo: Code[20];
        LastEntrdDocNo: Code[20];
        LastEntrdDate: Date;
        BalanceLCY: Decimal;
        AmountLCY: Decimal;
        DocBalance: Decimal;
        DocBalanceReverse: Decimal;
        DateBalance: Decimal;
        DateBalanceReverse: Decimal;
        TotalBalance: Decimal;
        TotalBalanceReverse: Decimal;
        AccName: Text[50];
        LastLineNo: Integer;
        Day: Integer;
        Week: Integer;
        Month: Integer;
        MonthText: Text[30];
        AmountError: Boolean;
        ErrorCounter: Integer;
        ErrorText: array [50] of Text[250];
        TempErrorText: Text[250];
        BalAccName: Text[50];
        CurrentCustomerVendors: Integer;
        VATEntryCreated: Boolean;
        CustPosting: Boolean;
        VendPosting: Boolean;
        SalesPostingType: Boolean;
        PurchPostingType: Boolean;
        DimText: Text[75];
        AllocationDimText: Text[75];
        ShowDim: Boolean;
        Continue: Boolean;
        Text063: label 'Document,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
        Text064: label '%1 %2 is already used in line %3 (%4 %5).';
        Text065: label '%1 must not be blocked with type %2 when %3 is %4.';
        CurrentICPartner: Code[20];
        Text066: label 'You cannot enter G/L Account or Bank Account in both %1 and %2.';
        Text067: label '%1 %2 is linked to %3 %4.';
        Text069: label '%1 must not be specified when %2 is %3.';
        Text070: label '%1 must not be specified when the document is not an intercompany transaction.';
        Text071: label '%1 %2 does not exist.';
        Text072: label '%1 must not be %2 for %3 %4.';
        Text073: label '%1 %2 already exists.';
        USText001: label 'Warning:  Checks cannot be financially voided when Force Doc. Balance is set to No in the Journal Template.';
        GeneralJnlTestCap: label 'General Journal - Test';
        PageNoCap: label 'Page';
        JnlBatchNameCap: label 'Journal Batch';
        PostingDateCap: label 'Posting Date';
        DocumentTypeCap: label 'Document Type';
        AccountTypeCap: label 'Account Type';
        AccNameCap: label 'Name';
        GenPostingTypeCap: label 'Gen. Posting Type';
        GenBusPostingGroupCap: label 'Gen. Bus. Posting Group';
        GenProdPostingGroupCap: label 'Gen. Prod. Posting Group';
        DimensionsCap: label 'Dimensions';
        WarningCap: label 'Warning!';
        ReconciliationCap: label 'Reconciliation';
        NoCap: label 'No.';
        NameCap: label 'Name';
        NetChangeinJnlCap: label 'Net Change in Jnl.';
        BalafterPostingCap: label 'Balance after Posting';
        DimensionAllocationsCap: label 'Allocation Dimensions';
        LoansRec: Record "Loans Register";
        LoanType: Code[20];

    local procedure CheckRecurringLine(GenJnlLine2: Record "Gen. Journal Line")
    begin
        with GenJnlLine2 do
          if GenJnlTemplate.Recurring then begin
            if "Recurring Method" = 0 then
              AddError(StrSubstNo(Text002,FieldCaption("Recurring Method")));
            if Format("Recurring Frequency") = '' then
              AddError(StrSubstNo(Text002,FieldCaption("Recurring Frequency")));
            if "Bal. Account No." <> '' then
              AddError(
                StrSubstNo(
                  Text019,
                  FieldCaption("Bal. Account No.")));
            case "Recurring Method" of
              "recurring method"::"V  Variable","recurring method"::"RV Reversing Variable",
              "recurring method"::"F  Fixed","recurring method"::"RF Reversing Fixed":
                WarningIfZeroAmt("Gen. Journal Line");
              "recurring method"::"B  Balance","recurring method"::"RB Reversing Balance":
                WarningIfNonZeroAmt("Gen. Journal Line");
            end;
            if "Recurring Method" > "recurring method"::"V  Variable" then begin
              if "Account Type" = "account type"::"Fixed Asset" then
                AddError(
                  StrSubstNo(
                    Text020,
                    FieldCaption("Recurring Method"),"Recurring Method",
                    FieldCaption("Account Type"),"Account Type"));
              if "Bal. Account Type" = "bal. account type"::"Fixed Asset" then
                AddError(
                  StrSubstNo(
                    Text020,
                    FieldCaption("Recurring Method"),"Recurring Method",
                    FieldCaption("Bal. Account Type"),"Bal. Account Type"));
            end;
          end else begin
            if "Recurring Method" <> 0 then
              AddError(StrSubstNo(Text009,FieldCaption("Recurring Method")));
            if Format("Recurring Frequency") <> '' then
              AddError(StrSubstNo(Text009,FieldCaption("Recurring Frequency")));
          end;
    end;

    local procedure CheckAllocations(GenJnlLine2: Record "Gen. Journal Line")
    begin
        with GenJnlLine2 do begin
          if "Recurring Method" in
             ["recurring method"::"B  Balance",
              "recurring method"::"RB Reversing Balance"]
          then begin
            GenJnlAlloc.Reset;
            GenJnlAlloc.SetRange("Journal Template Name","Journal Template Name");
            GenJnlAlloc.SetRange("Journal Batch Name","Journal Batch Name");
            GenJnlAlloc.SetRange("Journal Line No.","Line No.");
            if not GenJnlAlloc.FindFirst then
              AddError(Text061);
          end;

          GenJnlAlloc.Reset;
          GenJnlAlloc.SetRange("Journal Template Name","Journal Template Name");
          GenJnlAlloc.SetRange("Journal Batch Name","Journal Batch Name");
          GenJnlAlloc.SetRange("Journal Line No.","Line No.");
          GenJnlAlloc.SetFilter(Amount,'<>0');
          if GenJnlAlloc.FindFirst then
            if not GenJnlTemplate.Recurring then
              AddError(Text021)
            else begin
              GenJnlAlloc.SetRange("Account No.",'');
              if GenJnlAlloc.FindFirst then
                AddError(
                  StrSubstNo(
                    Text022,
                    GenJnlAlloc.FieldCaption("Account No."),GenJnlAlloc.Count));
            end;
        end;
    end;

    local procedure MakeRecurringTexts(var GenJnlLine2: Record "Gen. Journal Line")
    begin
        with GenJnlLine2 do
          if ("Posting Date" <> 0D) and ("Account No." <> '') and ("Recurring Method" <> 0) then begin
            Day := Date2dmy("Posting Date",1);
            Week := Date2dwy("Posting Date",2);
            Month := Date2dmy("Posting Date",2);
            MonthText := Format("Posting Date",0,Text023);
            AccountingPeriod.SetRange("Starting Date",0D,"Posting Date");
            if not AccountingPeriod.FindLast then
              AccountingPeriod.Name := '';
            "Document No." :=
              DelChr(
                PadStr(
                  StrSubstNo("Document No.",Day,Week,Month,MonthText,AccountingPeriod.Name),
                  MaxStrLen("Document No.")),
                '>');
            Description :=
              DelChr(
                PadStr(
                  StrSubstNo(Description,Day,Week,Month,MonthText,AccountingPeriod.Name),
                  MaxStrLen(Description)),
                '>');
          end;
    end;

    local procedure CheckBalance()
    var
        GenJnlLine: Record "Gen. Journal Line";
        NextGenJnlLine: Record "Gen. Journal Line";
    begin
        GenJnlLine := "Gen. Journal Line";
        LastLineNo := "Gen. Journal Line"."Line No.";
        NextGenJnlLine := "Gen. Journal Line";
        if NextGenJnlLine.Next = 0 then;
        MakeRecurringTexts(NextGenJnlLine);
        with GenJnlLine do
          if not EmptyLine then begin
            DocBalance := DocBalance + "Balance (LCY)";
            DateBalance := DateBalance + "Balance (LCY)";
            TotalBalance := TotalBalance + "Balance (LCY)";
            if "Recurring Method" >= "recurring method"::"RF Reversing Fixed" then begin
              DocBalanceReverse := DocBalanceReverse + "Balance (LCY)";
              DateBalanceReverse := DateBalanceReverse + "Balance (LCY)";
              TotalBalanceReverse := TotalBalanceReverse + "Balance (LCY)";
            end;
            LastDocType := "Document Type";
            LastDocNo := "Document No.";
            LastDate := "Posting Date";
            if TotalBalance = 0 then begin
              CurrentCustomerVendors := 0;
              VATEntryCreated := false;
            end;
            if GenJnlTemplate."Force Doc. Balance" then begin
              VATEntryCreated :=
                VATEntryCreated or
                (("Account Type" = "account type"::"G/L Account") and ("Account No." <> '') and
                 ("Gen. Posting Type" in ["gen. posting type"::Purchase,"gen. posting type"::Sale])) or
                (("Bal. Account Type" = "bal. account type"::"G/L Account") and ("Bal. Account No." <> '') and
                 ("Bal. Gen. Posting Type" in ["bal. gen. posting type"::Purchase,"bal. gen. posting type"::Sale]));
              if (("Account Type" in ["account type"::Customer,"account type"::Vendor]) and
                  ("Account No." <> '')) or
                 (("Bal. Account Type" in ["bal. account type"::Customer,"bal. account type"::Vendor]) and
                  ("Bal. Account No." <> ''))
              then
                CurrentCustomerVendors := CurrentCustomerVendors + 1;
              if (CurrentCustomerVendors > 1) and VATEntryCreated then
                AddError(
                  StrSubstNo(
                    Text024,
                    "Document Type","Document No.","Posting Date"));
            end;
          end;

        with NextGenJnlLine do begin
          if (LastDate <> 0D) and (LastDocNo <> '') and
             (("Posting Date" <> LastDate) or
              ("Document Type" <> LastDocType) or
              ("Document No." <> LastDocNo) or
              ("Line No." = LastLineNo))
          then begin
            if GenJnlTemplate."Force Doc. Balance" then begin
              case true of
                DocBalance <> 0:
                  AddError(
                    StrSubstNo(
                      Text025,
                      SelectStr(LastDocType + 1,Text063),LastDocNo,DocBalance));
                DocBalanceReverse <> 0:
                  AddError(
                    StrSubstNo(
                      Text026,
                      SelectStr(LastDocType + 1,Text063),LastDocNo,DocBalanceReverse));
              end;
              DocBalance := 0;
              DocBalanceReverse := 0;
            end;
            if ("Posting Date" <> LastDate) or
               ("Document Type" <> LastDocType) or ("Document No." <> LastDocNo)
            then begin
              CurrentCustomerVendors := 0;
              VATEntryCreated := false;
              CustPosting := false;
              VendPosting := false;
              SalesPostingType := false;
              PurchPostingType := false;
            end;
          end;

          if (LastDate <> 0D) and (("Posting Date" <> LastDate) or ("Line No." = LastLineNo)) then begin
            case true of
              DateBalance <> 0:
                AddError(
                  StrSubstNo(
                    Text027,
                    LastDate,DateBalance));
              DateBalanceReverse <> 0:
                AddError(
                  StrSubstNo(
                    Text028,
                    LastDate,DateBalanceReverse));
            end;
            DocBalance := 0;
            DocBalanceReverse := 0;
            DateBalance := 0;
            DateBalanceReverse := 0;
          end;

          if "Line No." = LastLineNo then begin
            case true of
              TotalBalance <> 0:
                AddError(
                  StrSubstNo(
                    Text029,
                    TotalBalance));
              TotalBalanceReverse <> 0:
                AddError(
                  StrSubstNo(
                    Text030,
                    TotalBalanceReverse));
            end;
            DocBalance := 0;
            DocBalanceReverse := 0;
            DateBalance := 0;
            DateBalanceReverse := 0;
            TotalBalance := 0;
            TotalBalanceReverse := 0;
            LastDate := 0D;
            LastDocType := 0;
            LastDocNo := '';
          end;
        end;
    end;

    local procedure AddError(Text: Text[250])
    begin
        ErrorCounter := ErrorCounter + 1;
        ErrorText[ErrorCounter] := Text;
    end;

    local procedure ReconcileGLAccNo(GLAccNo: Code[20];ReconcileAmount: Decimal)
    begin
        if not GLAccNetChange.Get(GLAccNo) then begin
          GLAcc.Get(GLAccNo);
          GLAcc.CalcFields("Balance at Date");
          GLAccNetChange.Init;
          GLAccNetChange."No." := GLAcc."No.";
          GLAccNetChange.Name := GLAcc.Name;
          GLAccNetChange."Balance after Posting" := GLAcc."Balance at Date";
          GLAccNetChange.Insert;
        end;
        GLAccNetChange."Net Change in Jnl." := GLAccNetChange."Net Change in Jnl." + ReconcileAmount;
        GLAccNetChange."Balance after Posting" := GLAccNetChange."Balance after Posting" + ReconcileAmount;
        GLAccNetChange.Modify;
    end;

    local procedure CheckGLAcc(var GenJnlLine: Record "Gen. Journal Line";var AccName: Text[50])
    begin
        with GenJnlLine do
          if not GLAcc.Get("Account No.") then
            AddError(
              StrSubstNo(
                Text031,
                GLAcc.TableCaption,"Account No."))
          else begin
            AccName := GLAcc.Name;

            if GLAcc.Blocked then
              AddError(
                StrSubstNo(
                  Text032,
                  GLAcc.FieldCaption(Blocked),false,GLAcc.TableCaption,"Account No."));
            if GLAcc."Account Type" <> GLAcc."account type"::Posting then begin
              GLAcc."Account Type" := GLAcc."account type"::Posting;
              AddError(
                StrSubstNo(
                  Text032,
                  GLAcc.FieldCaption("Account Type"),GLAcc."Account Type",GLAcc.TableCaption,"Account No."));
            end;
            if not "System-Created Entry" then
              if "Posting Date" = NormalDate("Posting Date") then
                if not GLAcc."Direct Posting" then
                  AddError(
                    StrSubstNo(
                      Text032,
                      GLAcc.FieldCaption("Direct Posting"),true,GLAcc.TableCaption,"Account No."));

            if "Gen. Posting Type" > 0 then begin
              case "Gen. Posting Type" of
                "gen. posting type"::Sale:
                  SalesPostingType := true;
                "gen. posting type"::Purchase:
                  PurchPostingType := true;
              end;
              TestPostingType;

              if not VATPostingSetup.Get("VAT Bus. Posting Group","VAT Prod. Posting Group") then
                AddError(
                  StrSubstNo(
                    Text036,
                    VATPostingSetup.TableCaption,"VAT Bus. Posting Group","VAT Prod. Posting Group"))
              else
                if "VAT Calculation Type" <> VATPostingSetup."VAT Calculation Type" then
                  AddError(
                    StrSubstNo(
                      Text037,
                      FieldCaption("VAT Calculation Type"),VATPostingSetup."VAT Calculation Type"))
            end;

            if GLAcc."Reconciliation Account" then
              ReconcileGLAccNo("Account No.",ROUND("Amount (LCY)" / (1 + "VAT %" / 100)));
          end;
    end;

    local procedure CheckCust(var GenJnlLine: Record "Gen. Journal Line";var AccName: Text[50])
    begin
        with GenJnlLine do
          if not Cust.Get("Account No.") then
            AddError(
              StrSubstNo(
                Text031,
                Cust.TableCaption,"Account No."))
          else begin
            AccName := Cust.Name;
            if ((Cust.Blocked = Cust.Blocked::All) or
                ((Cust.Blocked = Cust.Blocked::Invoice) and
                 ("Document Type" in ["document type"::Invoice,"document type"::" "]))
                )
            then
              AddError(
                StrSubstNo(
                  Text065,
                  "Account Type",Cust.Blocked,FieldCaption("Document Type"),"Document Type"));
            if "Currency Code" <> '' then
              if not Currency.Get("Currency Code") then
                AddError(
                  StrSubstNo(
                    Text038,
                    "Currency Code"));
            if (Cust."IC Partner Code" <> '') and (GenJnlTemplate.Type = GenJnlTemplate.Type::Intercompany) then
              if ICPartner.Get(Cust."IC Partner Code") then begin
                if ICPartner.Blocked then
                  AddError(
                    StrSubstNo(
                      '%1 %2',
                      StrSubstNo(
                        Text067,
                        Cust.TableCaption,"Account No.",ICPartner.TableCaption,"IC Partner Code"),
                      StrSubstNo(
                        Text032,
                        ICPartner.FieldCaption(Blocked),false,ICPartner.TableCaption,Cust."IC Partner Code")));
              end else
                AddError(
                  StrSubstNo(
                    '%1 %2',
                    StrSubstNo(
                      Text067,
                      Cust.TableCaption,"Account No.",ICPartner.TableCaption,Cust."IC Partner Code"),
                    StrSubstNo(
                      Text031,
                      ICPartner.TableCaption,Cust."IC Partner Code")));
            CustPosting := true;
            TestPostingType;

            if "Recurring Method" = 0 then
              if "Document Type" in
                 ["document type"::Invoice,"document type"::"Credit Memo",
                  "document type"::"Finance Charge Memo","document type"::Reminder]
              then begin
                OldCustLedgEntry.Reset;
                OldCustLedgEntry.SetCurrentkey("Document No.");
                OldCustLedgEntry.SetRange("Document Type","Document Type");
                OldCustLedgEntry.SetRange("Document No.","Document No.");
                if OldCustLedgEntry.FindFirst then
                  AddError(
                    StrSubstNo(
                      Text039,"Document Type","Document No."));

                if SalesSetup."Ext. Doc. No. Mandatory" or
                   ("External Document No." <> '')
                then begin
                  if "External Document No." = '' then
                    AddError(
                      StrSubstNo(
                        Text041,FieldCaption("External Document No.")));

                  OldCustLedgEntry.Reset;
                  OldCustLedgEntry.SetCurrentkey("External Document No.");
                  OldCustLedgEntry.SetRange("Document Type","Document Type");
                  OldCustLedgEntry.SetRange("Customer No.","Account No.");
                  OldCustLedgEntry.SetRange("External Document No.","External Document No.");
                  if OldCustLedgEntry.FindFirst then
                    AddError(
                      StrSubstNo(
                        Text039,
                        "Document Type","External Document No."));
                  CheckAgainstPrevLines("Gen. Journal Line");
                end;
              end;
          end;
    end;

    local procedure CheckMember(var GenJnlLine: Record "Gen. Journal Line";var AccName: Text[50])
    begin
        with GenJnlLine do
          if not Memb.Get("Account No.") then
            AddError(
              StrSubstNo(
                Text031,
                Memb.TableCaption,"Account No."))
          else begin
            AccName := Memb.Name;
            if ((Memb.Blocked = Memb.Blocked::All) or
                ((Memb.Blocked = Memb.Blocked::Invoice) and
                 ("Document Type" in ["document type"::Invoice,"document type"::" "]))
                )
            then
              AddError(
                StrSubstNo(
                  Text065,
                  "Account Type",Cust.Blocked,FieldCaption("Document Type"),"Document Type"));
            if "Currency Code" <> '' then
              if not Currency.Get("Currency Code") then
                AddError(
                  StrSubstNo(
                    Text038,
                    "Currency Code"));
            if (Memb."IC Partner Code" <> '') and (GenJnlTemplate.Type = GenJnlTemplate.Type::Intercompany) then
              if ICPartner.Get(Memb."IC Partner Code") then begin
                if ICPartner.Blocked then
                  AddError(
                    StrSubstNo(
                      '%1 %2',
                      StrSubstNo(
                        Text067,
                        Memb.TableCaption,"Account No.",ICPartner.TableCaption,"IC Partner Code"),
                      StrSubstNo(
                        Text032,
                        ICPartner.FieldCaption(Blocked),false,ICPartner.TableCaption,Memb."IC Partner Code")));
              end else
                AddError(
                  StrSubstNo(
                    '%1 %2',
                    StrSubstNo(
                      Text067,
                      Memb.TableCaption,"Account No.",ICPartner.TableCaption,Memb."IC Partner Code"),
                    StrSubstNo(
                      Text031,
                      ICPartner.TableCaption,Memb."IC Partner Code")));
            CustPosting := true;
            TestPostingType;

            if LoansRec.Get("Loan No") then begin
              LoanType:=LoansRec."Loan Product Type";
              end;

            if "Recurring Method" = 0 then
              if "Document Type" in
                 ["document type"::Invoice,"document type"::"Credit Memo",
                  "document type"::"Finance Charge Memo","document type"::Reminder]
              then begin
                OldCustLedgEntry.Reset;
                OldCustLedgEntry.SetCurrentkey("Document No.");
                OldCustLedgEntry.SetRange("Document Type","Document Type");
                OldCustLedgEntry.SetRange("Document No.","Document No.");
                if OldCustLedgEntry.FindFirst then
                  AddError(
                    StrSubstNo(
                      Text039,"Document Type","Document No."));

                if SalesSetup."Ext. Doc. No. Mandatory" or
                   ("External Document No." <> '')
                then begin
                  if "External Document No." = '' then
                    AddError(
                      StrSubstNo(
                        Text041,FieldCaption("External Document No.")));

                  OldCustLedgEntry.Reset;
                  OldCustLedgEntry.SetCurrentkey("External Document No.");
                  OldCustLedgEntry.SetRange("Document Type","Document Type");
                  OldCustLedgEntry.SetRange("Customer No.","Account No.");
                  OldCustLedgEntry.SetRange("External Document No.","External Document No.");
                  if OldCustLedgEntry.FindFirst then
                    AddError(
                      StrSubstNo(
                        Text039,
                        "Document Type","External Document No."));
                  CheckAgainstPrevLines("Gen. Journal Line");
                end;
              end;
          end;
    end;

    local procedure CheckVend(var GenJnlLine: Record "Gen. Journal Line";var AccName: Text[50])
    begin
        with GenJnlLine do
          if not Vend.Get("Account No.") then
            AddError(
              StrSubstNo(
                Text031,
                Vend.TableCaption,"Account No."))
          else begin
            AccName := Vend.Name;

            if ((Vend.Blocked = Vend.Blocked::All) or
                ((Vend.Blocked = Vend.Blocked::Payment) and ("Document Type" = "document type"::Payment))
                )
            then
              AddError(
                StrSubstNo(
                  Text065,
                  "Account Type",Vend.Blocked,FieldCaption("Document Type"),"Document Type"));
            if "Currency Code" <> '' then
              if not Currency.Get("Currency Code") then
                AddError(
                  StrSubstNo(
                    Text038,
                    "Currency Code"));

            if (Vend."IC Partner Code" <> '') and (GenJnlTemplate.Type = GenJnlTemplate.Type::Intercompany) then
              if ICPartner.Get(Vend."IC Partner Code") then begin
                if ICPartner.Blocked then
                  AddError(
                    StrSubstNo(
                      '%1 %2',
                      StrSubstNo(
                        Text067,
                        Vend.TableCaption,"Account No.",ICPartner.TableCaption,Vend."IC Partner Code"),
                      StrSubstNo(
                        Text032,
                        ICPartner.FieldCaption(Blocked),false,ICPartner.TableCaption,Vend."IC Partner Code")));
              end else
                AddError(
                  StrSubstNo(
                    '%1 %2',
                    StrSubstNo(
                      Text067,
                      Vend.TableCaption,"Account No.",ICPartner.TableCaption,"IC Partner Code"),
                    StrSubstNo(
                      Text031,
                      ICPartner.TableCaption,Vend."IC Partner Code")));
            VendPosting := true;
            TestPostingType;

            if "Recurring Method" = 0 then
              if "Document Type" in
                 ["document type"::Invoice,"document type"::"Credit Memo",
                  "document type"::"Finance Charge Memo","document type"::Reminder]
              then begin
                OldVendLedgEntry.Reset;
                OldVendLedgEntry.SetCurrentkey("Document No.");
                OldVendLedgEntry.SetRange("Document Type","Document Type");
                OldVendLedgEntry.SetRange("Document No.","Document No.");
                if OldVendLedgEntry.FindFirst then
                  AddError(
                    StrSubstNo(
                      Text040,
                      "Document Type","Document No."));

                if PurchSetup."Ext. Doc. No. Mandatory" or
                   ("External Document No." <> '')
                then begin
                  if "External Document No." = '' then
                    AddError(
                      StrSubstNo(
                        Text041,FieldCaption("External Document No.")));

                  OldVendLedgEntry.Reset;
                  OldVendLedgEntry.SetCurrentkey("External Document No.");
                  OldVendLedgEntry.SetRange("Document Type","Document Type");
                  OldVendLedgEntry.SetRange("Vendor No.","Account No.");
                  OldVendLedgEntry.SetRange("External Document No.","External Document No.");
                  if OldVendLedgEntry.FindFirst then
                    AddError(
                      StrSubstNo(
                        Text040,
                        "Document Type","External Document No."));
                  CheckAgainstPrevLines("Gen. Journal Line");
                end;
              end;
          end;
    end;

    local procedure CheckBankAcc(var GenJnlLine: Record "Gen. Journal Line";var AccName: Text[50])
    begin
        with GenJnlLine do
          if not BankAcc.Get("Account No.") then
            AddError(
              StrSubstNo(
                Text031,
                BankAcc.TableCaption,"Account No."))
          else begin
            AccName := BankAcc.Name;

            if BankAcc.Blocked then
              AddError(
                StrSubstNo(
                  Text032,
                  BankAcc.FieldCaption(Blocked),false,BankAcc.TableCaption,"Account No."));
            if ("Currency Code" <> BankAcc."Currency Code") and (BankAcc."Currency Code" <> '') then
              AddError(
                StrSubstNo(
                  Text037,
                  FieldCaption("Currency Code"),BankAcc."Currency Code"));

            if "Currency Code" <> '' then
              if not Currency.Get("Currency Code") then
                AddError(
                  StrSubstNo(
                    Text038,
                    "Currency Code"));

            if "Bank Payment Type" <> 0 then
              if ("Bank Payment Type" = "bank payment type"::"Computer Check") and (Amount < 0) then
                if BankAcc."Currency Code" <> "Currency Code" then
                  AddError(
                    StrSubstNo(
                      Text042,
                      FieldCaption("Bank Payment Type"),FieldCaption("Currency Code"),
                      TableCaption,BankAcc.TableCaption));

            if BankAccPostingGr.Get(BankAcc."Bank Acc. Posting Group") then
              if BankAccPostingGr."G/L Bank Account No." <> '' then
                ReconcileGLAccNo(
                  BankAccPostingGr."G/L Bank Account No.",
                  ROUND("Amount (LCY)" / (1 + "VAT %" / 100)));
          end;
    end;

    local procedure CheckFixedAsset(var GenJnlLine: Record "Gen. Journal Line";var AccName: Text[50])
    begin
        with GenJnlLine do
          if not FA.Get("Account No.") then
            AddError(
              StrSubstNo(
                Text031,
                FA.TableCaption,"Account No."))
          else begin
            AccName := FA.Description;
            if FA.Blocked then
              AddError(
                StrSubstNo(
                  Text032,
                  FA.FieldCaption(Blocked),false,FA.TableCaption,"Account No."));
            if FA.Inactive then
              AddError(
                StrSubstNo(
                  Text032,
                  FA.FieldCaption(Inactive),false,FA.TableCaption,"Account No."));
            if FA."Budgeted Asset" then
              AddError(
                StrSubstNo(
                  Text043,
                  FA.TableCaption,"Account No.",FA.FieldCaption("Budgeted Asset"),true));
            if DeprBook.Get("Depreciation Book Code") then
              CheckFAIntegration(GenJnlLine)
            else
              AddError(
                StrSubstNo(
                  Text031,
                  DeprBook.TableCaption,"Depreciation Book Code"));
            if not FADeprBook.Get(FA."No.","Depreciation Book Code") then
              AddError(
                StrSubstNo(
                  Text036,
                  FADeprBook.TableCaption,FA."No.","Depreciation Book Code"));
          end;
    end;

    local procedure CheckICPartner(var GenJnlLine: Record "Gen. Journal Line";var AccName: Text[50])
    begin
        with GenJnlLine do
          if not ICPartner.Get("Account No.") then
            AddError(
              StrSubstNo(
                Text031,
                ICPartner.TableCaption,"Account No."))
          else begin
            AccName := ICPartner.Name;
            if ICPartner.Blocked then
              AddError(
                StrSubstNo(
                  Text032,
                  ICPartner.FieldCaption(Blocked),false,ICPartner.TableCaption,"Account No."));
          end;
    end;

    local procedure TestFixedAsset(var GenJnlLine: Record "Gen. Journal Line")
    begin
        with GenJnlLine do begin
          if "Job No." <> '' then
            AddError(
              StrSubstNo(
                Text044,FieldCaption("Job No.")));
          if "FA Posting Type" = "fa posting type"::" " then
            AddError(
              StrSubstNo(
                Text045,FieldCaption("FA Posting Type")));
          if "Depreciation Book Code" = '' then
            AddError(
              StrSubstNo(
                Text045,FieldCaption("Depreciation Book Code")));
          if "Depreciation Book Code" = "Duplicate in Depreciation Book" then
            AddError(
              StrSubstNo(
                Text046,
                FieldCaption("Depreciation Book Code"),FieldCaption("Duplicate in Depreciation Book")));
          CheckFADocNo(GenJnlLine);
          if "Account Type" = "Bal. Account Type" then
            AddError(
              StrSubstNo(
                Text047,
                FieldCaption("Account Type"),FieldCaption("Bal. Account Type"),"Account Type"));
          if "Account Type" = "account type"::"Fixed Asset" then
            if "FA Posting Type" in
               ["fa posting type"::"Acquisition Cost","fa posting type"::Disposal,"fa posting type"::Maintenance]
            then begin
              if ("Gen. Bus. Posting Group" <> '') or ("Gen. Prod. Posting Group" <> '') then
                if "Gen. Posting Type" = "gen. posting type"::" " then
                  AddError(StrSubstNo(Text002,FieldCaption("Gen. Posting Type")));
            end else begin
              if "Gen. Posting Type" <> "gen. posting type"::" " then
                AddError(
                  StrSubstNo(
                    Text049,
                    FieldCaption("Gen. Posting Type"),FieldCaption("FA Posting Type"),"FA Posting Type"));
              if "Gen. Bus. Posting Group" <> '' then
                AddError(
                  StrSubstNo(
                    Text049,
                    FieldCaption("Gen. Bus. Posting Group"),FieldCaption("FA Posting Type"),"FA Posting Type"));
              if "Gen. Prod. Posting Group" <> '' then
                AddError(
                  StrSubstNo(
                    Text049,
                    FieldCaption("Gen. Prod. Posting Group"),FieldCaption("FA Posting Type"),"FA Posting Type"));
            end;
          if "Bal. Account Type" = "bal. account type"::"Fixed Asset" then
            if "FA Posting Type" in
               ["fa posting type"::"Acquisition Cost","fa posting type"::Disposal,"fa posting type"::Maintenance]
            then begin
              if ("Bal. Gen. Bus. Posting Group" <> '') or ("Bal. Gen. Prod. Posting Group" <> '') then
                if "Bal. Gen. Posting Type" = "bal. gen. posting type"::" " then
                  AddError(StrSubstNo(Text002,FieldCaption("Bal. Gen. Posting Type")));
            end else begin
              if "Bal. Gen. Posting Type" <> "bal. gen. posting type"::" " then
                AddError(
                  StrSubstNo(
                    Text049,
                    FieldCaption("Bal. Gen. Posting Type"),FieldCaption("FA Posting Type"),"FA Posting Type"));
              if "Bal. Gen. Bus. Posting Group" <> '' then
                AddError(
                  StrSubstNo(
                    Text049,
                    FieldCaption("Bal. Gen. Bus. Posting Group"),FieldCaption("FA Posting Type"),"FA Posting Type"));
              if "Bal. Gen. Prod. Posting Group" <> '' then
                AddError(
                  StrSubstNo(
                    Text049,
                    FieldCaption("Bal. Gen. Prod. Posting Group"),FieldCaption("FA Posting Type"),"FA Posting Type"));
            end;
          TempErrorText :=
            '%1 ' +
            StrSubstNo(
              Text050,
              FieldCaption("FA Posting Type"),"FA Posting Type");
          if "FA Posting Type" <> "fa posting type"::"Acquisition Cost" then begin
            if "Depr. Acquisition Cost" then
              AddError(StrSubstNo(TempErrorText,FieldCaption("Depr. Acquisition Cost")));
            if "Salvage Value" <> 0 then
              AddError(StrSubstNo(TempErrorText,FieldCaption("Salvage Value")));
            if "FA Posting Type" <> "fa posting type"::Maintenance then
              if Quantity <> 0 then
                AddError(StrSubstNo(TempErrorText,FieldCaption(Quantity)));
            if "Insurance No." <> '' then
              AddError(StrSubstNo(TempErrorText,FieldCaption("Insurance No.")));
          end;
          if ("FA Posting Type" = "fa posting type"::Maintenance) and "Depr. until FA Posting Date" then
            AddError(StrSubstNo(TempErrorText,FieldCaption("Depr. until FA Posting Date")));
          if ("FA Posting Type" <> "fa posting type"::Maintenance) and ("Maintenance Code" <> '') then
            AddError(StrSubstNo(TempErrorText,FieldCaption("Maintenance Code")));

          if ("FA Posting Type" <> "fa posting type"::Depreciation) and
             ("FA Posting Type" <> "fa posting type"::"Custom 1") and
             ("No. of Depreciation Days" <> 0)
          then
            AddError(StrSubstNo(TempErrorText,FieldCaption("No. of Depreciation Days")));

          if ("FA Posting Type" = "fa posting type"::Disposal) and "FA Reclassification Entry" then
            AddError(StrSubstNo(TempErrorText,FieldCaption("FA Reclassification Entry")));

          if ("FA Posting Type" = "fa posting type"::Disposal) and ("Budgeted FA No." <> '') then
            AddError(StrSubstNo(TempErrorText,FieldCaption("Budgeted FA No.")));

          if "FA Posting Date" = 0D then
            "FA Posting Date" := "Posting Date";
          if DeprBook.Get("Depreciation Book Code") then
            if DeprBook."Use Same FA+G/L Posting Dates" and ("Posting Date" <> "FA Posting Date") then
              AddError(
                StrSubstNo(
                  Text051,
                  FieldCaption("Posting Date"),FieldCaption("FA Posting Date")));
          if "FA Posting Date" <> 0D then begin
            if "FA Posting Date" <> NormalDate("FA Posting Date") then
              AddError(
                StrSubstNo(
                  Text052,
                  FieldCaption("FA Posting Date")));
            if not ("FA Posting Date" in [Dmy2date(1,1,2)..Dmy2date(31,12,9998)]) then
              AddError(
                StrSubstNo(
                  Text053,
                  FieldCaption("FA Posting Date")));
            if (AllowFAPostingFrom = 0D) and (AllowFAPostingTo = 0D) then begin
              if UserId <> '' then
                if UserSetup.Get(UserId) then begin
                  AllowFAPostingFrom := UserSetup."Allow FA Posting From";
                  AllowFAPostingTo := UserSetup."Allow FA Posting To";
                end;
              if (AllowFAPostingFrom = 0D) and (AllowFAPostingTo = 0D) then begin
                FASetup.Get;
                AllowFAPostingFrom := FASetup."Allow FA Posting From";
                AllowFAPostingTo := FASetup."Allow FA Posting To";
              end;
              if AllowFAPostingTo = 0D then
                AllowFAPostingTo := Dmy2date(31,12,9998);
            end;
            if ("FA Posting Date" < AllowFAPostingFrom) or
               ("FA Posting Date" > AllowFAPostingTo)
            then
              AddError(
                StrSubstNo(
                  Text053,
                  FieldCaption("FA Posting Date")));
          end;
          FASetup.Get;
          if ("FA Posting Type" = "fa posting type"::"Acquisition Cost") and
             ("Insurance No." <> '') and ("Depreciation Book Code" <> FASetup."Insurance Depr. Book")
          then
            AddError(
              StrSubstNo(
                Text054,
                FieldCaption("Depreciation Book Code"),"Depreciation Book Code"));

          if "FA Error Entry No." > 0 then begin
            TempErrorText :=
              '%1 ' +
              StrSubstNo(
                Text055,
                FieldCaption("FA Error Entry No."));
            if "Depr. until FA Posting Date" then
              AddError(StrSubstNo(TempErrorText,FieldCaption("Depr. until FA Posting Date")));
            if "Depr. Acquisition Cost" then
              AddError(StrSubstNo(TempErrorText,FieldCaption("Depr. Acquisition Cost")));
            if "Duplicate in Depreciation Book" <> '' then
              AddError(StrSubstNo(TempErrorText,FieldCaption("Duplicate in Depreciation Book")));
            if "Use Duplication List" then
              AddError(StrSubstNo(TempErrorText,FieldCaption("Use Duplication List")));
            if "Salvage Value" <> 0 then
              AddError(StrSubstNo(TempErrorText,FieldCaption("Salvage Value")));
            if "Insurance No." <> '' then
              AddError(StrSubstNo(TempErrorText,FieldCaption("Insurance No.")));
            if "Budgeted FA No." <> '' then
              AddError(StrSubstNo(TempErrorText,FieldCaption("Budgeted FA No.")));
            if "Recurring Method" > 0 then
              AddError(StrSubstNo(TempErrorText,FieldCaption("Recurring Method")));
            if "FA Posting Type" = "fa posting type"::Maintenance then
              AddError(StrSubstNo(TempErrorText,"FA Posting Type"));
          end;
        end;
    end;

    local procedure CheckFAIntegration(var GenJnlLine: Record "Gen. Journal Line")
    var
        GLIntegration: Boolean;
    begin
        with GenJnlLine do begin
          if "FA Posting Type" = "fa posting type"::" " then
            exit;
          case "FA Posting Type" of
            "fa posting type"::"Acquisition Cost":
              GLIntegration := DeprBook."G/L Integration - Acq. Cost";
            "fa posting type"::Depreciation:
              GLIntegration := DeprBook."G/L Integration - Depreciation";
            "fa posting type"::"Write-Down":
              GLIntegration := DeprBook."G/L Integration - Write-Down";
            "fa posting type"::Appreciation:
              GLIntegration := DeprBook."G/L Integration - Appreciation";
            "fa posting type"::"Custom 1":
              GLIntegration := DeprBook."G/L Integration - Custom 1";
            "fa posting type"::"Custom 2":
              GLIntegration := DeprBook."G/L Integration - Custom 2";
            "fa posting type"::Disposal:
              GLIntegration := DeprBook."G/L Integration - Disposal";
            "fa posting type"::Maintenance:
              GLIntegration := DeprBook."G/L Integration - Maintenance";
          end;
          if not GLIntegration then
            AddError(
              StrSubstNo(
                Text056,
                "FA Posting Type"));

          if not DeprBook."G/L Integration - Depreciation" then begin
            if "Depr. until FA Posting Date" then
              AddError(
                StrSubstNo(
                  Text057,
                  FieldCaption("Depr. until FA Posting Date")));
            if "Depr. Acquisition Cost" then
              AddError(
                StrSubstNo(
                  Text057,
                  FieldCaption("Depr. Acquisition Cost")));
          end;
        end;
    end;

    local procedure TestFixedAssetFields(var GenJnlLine: Record "Gen. Journal Line")
    begin
        with GenJnlLine do begin
          if "FA Posting Type" <> "fa posting type"::" " then
            AddError(StrSubstNo(Text058,FieldCaption("FA Posting Type")));
          if "Depreciation Book Code" <> '' then
            AddError(StrSubstNo(Text058,FieldCaption("Depreciation Book Code")));
        end;
    end;


    procedure TestPostingType()
    begin
        case true of
          CustPosting and PurchPostingType:
            AddError(Text059);
          VendPosting and SalesPostingType:
            AddError(Text060);
        end;
    end;

    local procedure WarningIfNegativeAmt(GenJnlLine: Record "Gen. Journal Line")
    begin
        if (GenJnlLine.Amount < 0) and not AmountError then begin
          AmountError := true;
          AddError(StrSubstNo(Text007,GenJnlLine.FieldCaption(Amount)));
        end;
    end;

    local procedure WarningIfPositiveAmt(GenJnlLine: Record "Gen. Journal Line")
    begin
        if (GenJnlLine.Amount > 0) and not AmountError then begin
          AmountError := true;
          AddError(StrSubstNo(Text006,GenJnlLine.FieldCaption(Amount)));
        end;
    end;

    local procedure WarningIfZeroAmt(GenJnlLine: Record "Gen. Journal Line")
    begin
        if (GenJnlLine.Amount = 0) and not AmountError then begin
          AmountError := true;
          AddError(StrSubstNo(Text002,GenJnlLine.FieldCaption(Amount)));
        end;
    end;

    local procedure WarningIfNonZeroAmt(GenJnlLine: Record "Gen. Journal Line")
    begin
        if (GenJnlLine.Amount <> 0) and not AmountError then begin
          AmountError := true;
          AddError(StrSubstNo(Text062,GenJnlLine.FieldCaption(Amount)));
        end;
    end;

    local procedure CheckAgainstPrevLines(GenJnlLine: Record "Gen. Journal Line")
    var
        i: Integer;
        AccType: Integer;
        AccNo: Code[20];
        ErrorFound: Boolean;
    begin
        if (GenJnlLine."External Document No." = '') or
           not (GenJnlLine."Account Type" in
                [GenJnlLine."account type"::Customer,GenJnlLine."account type"::Vendor]) and
           not (GenJnlLine."Bal. Account Type" in
                [GenJnlLine."bal. account type"::Customer,GenJnlLine."bal. account type"::Vendor])
        then
          exit;

        if GenJnlLine."Account Type" in [GenJnlLine."account type"::Customer,GenJnlLine."account type"::Vendor] then begin
          AccType := GenJnlLine."Account Type";
          AccNo := GenJnlLine."Account No.";
        end else begin
          AccType := GenJnlLine."Bal. Account Type";
          AccNo := GenJnlLine."Bal. Account No.";
        end;

        TempGenJnlLine.Reset;
        TempGenJnlLine.SetRange("External Document No.",GenJnlLine."External Document No.");

        while (i < 2) and not ErrorFound do begin
          i := i + 1;
          if i = 1 then begin
            TempGenJnlLine.SetRange("Account Type",AccType);
            TempGenJnlLine.SetRange("Account No.",AccNo);
            TempGenJnlLine.SetRange("Bal. Account Type");
            TempGenJnlLine.SetRange("Bal. Account No.");
          end else begin
            TempGenJnlLine.SetRange("Account Type");
            TempGenJnlLine.SetRange("Account No.");
            TempGenJnlLine.SetRange("Bal. Account Type",AccType);
            TempGenJnlLine.SetRange("Bal. Account No.",AccNo);
          end;
          if TempGenJnlLine.FindFirst then begin
            ErrorFound := true;
            AddError(
              StrSubstNo(
                Text064,GenJnlLine.FieldCaption("External Document No."),GenJnlLine."External Document No.",
                TempGenJnlLine."Line No.",GenJnlLine.FieldCaption("Document No."),TempGenJnlLine."Document No."));
          end;
        end;

        TempGenJnlLine.Reset;
        TempGenJnlLine := GenJnlLine;
        TempGenJnlLine.Insert;
    end;

    local procedure CheckICDocument()
    var
        GenJnlLine4: Record "Gen. Journal Line";
        ICGLAccount: Record "IC G/L Account";
    begin
        with "Gen. Journal Line" do
          if GenJnlTemplate.Type = GenJnlTemplate.Type::Intercompany then begin
            if ("Posting Date" <> LastDate) or ("Document Type" <> LastDocType) or ("Document No." <> LastDocNo) then begin
              GenJnlLine4.SetCurrentkey("Journal Template Name","Journal Batch Name","Posting Date","Document No.");
              GenJnlLine4.SetRange("Journal Template Name","Journal Template Name");
              GenJnlLine4.SetRange("Journal Batch Name","Journal Batch Name");
              GenJnlLine4.SetRange("Posting Date","Posting Date");
              GenJnlLine4.SetRange("Document No.","Document No.");
              GenJnlLine4.SetFilter("IC Partner Code",'<>%1','');
              if GenJnlLine4.FindFirst then
                CurrentICPartner := GenJnlLine4."IC Partner Code"
              else
                CurrentICPartner := '';
            end;
            if (CurrentICPartner <> '') and ("IC Direction" = "ic direction"::Outgoing) then begin
              if ("Account Type" in ["account type"::"G/L Account","account type"::"Bank Account"]) and
                 ("Bal. Account Type" in ["bal. account type"::"G/L Account","account type"::"Bank Account"]) and
                 ("Account No." <> '') and
                 ("Bal. Account No." <> '')
              then begin
                AddError(
                  StrSubstNo(
                    Text066,FieldCaption("Account No."),FieldCaption("Bal. Account No.")));
              end else begin
                if (("Account Type" in ["account type"::"G/L Account","account type"::"Bank Account"]) and ("Account No." <> '')) xor
                   (("Bal. Account Type" in ["bal. account type"::"G/L Account","account type"::"Bank Account"]) and
                    ("Bal. Account No." <> ''))
                then begin
                  if "IC Partner G/L Acc. No." = '' then
                    AddError(
                      StrSubstNo(
                        Text002,FieldCaption("IC Partner G/L Acc. No.")))
                  else begin
                    if ICGLAccount.Get("IC Partner G/L Acc. No.") then
                      if ICGLAccount.Blocked then
                        AddError(
                          StrSubstNo(
                            Text032,
                            ICGLAccount.FieldCaption(Blocked),false,FieldCaption("IC Partner G/L Acc. No."),
                            "IC Partner G/L Acc. No."
                            ));
                  end;
                end else
                  if "IC Partner G/L Acc. No." <> '' then
                    AddError(
                      StrSubstNo(
                        Text009,FieldCaption("IC Partner G/L Acc. No.")));
              end;
            end else
              if "IC Partner G/L Acc. No." <> '' then begin
                if "IC Direction" = "ic direction"::Incoming then
                  AddError(
                    StrSubstNo(
                      Text069,FieldCaption("IC Partner G/L Acc. No."),FieldCaption("IC Direction"),Format("IC Direction")));
                if CurrentICPartner = '' then
                  AddError(
                    StrSubstNo(
                      Text070,FieldCaption("IC Partner G/L Acc. No.")));
              end;
          end;
    end;

    local procedure TestJobFields(var GenJnlLine: Record "Gen. Journal Line")
    var
        Job: Record Job;
        JT: Record "Job Task";
    begin
        with GenJnlLine do begin
          if ("Job No." = '') or ("Account Type" <> "account type"::"G/L Account") then
            exit;
          if not Job.Get("Job No.") then
            AddError(StrSubstNo(Text071,Job.TableCaption,"Job No."))
          else
            if Job.Blocked > Job.Blocked::" " then
              AddError(
                StrSubstNo(
                  Text072,Job.FieldCaption(Blocked),Job.Blocked,Job.TableCaption,"Job No."));

          if "Job Task No." = '' then
            AddError(StrSubstNo(Text002,FieldCaption("Job Task No.")))
          else
            if not JT.Get("Job No.","Job Task No.") then
              AddError(StrSubstNo(Text071,JT.TableCaption,"Job Task No."))
        end;
    end;

    local procedure CheckFADocNo(GenJnlLine: Record "Gen. Journal Line")
    var
        DeprBook: Record "Depreciation Book";
        FAJnlLine: Record "FA Journal Line";
        OldFALedgEntry: Record "FA Ledger Entry";
        OldMaintenanceLedgEntry: Record "Maintenance Ledger Entry";
        FANo: Code[20];
    begin
        with GenJnlLine do begin
          if "Account Type" = "account type"::"Fixed Asset" then
            FANo := "Account No.";
          if "Bal. Account Type" = "bal. account type"::"Fixed Asset" then
            FANo := "Bal. Account No.";
          if (FANo = '') or
             ("FA Posting Type" = "fa posting type"::" ") or
             ("Depreciation Book Code" = '') or
             ("Document No." = '')
          then
            exit;
          if not DeprBook.Get("Depreciation Book Code") then
            exit;
          if DeprBook."Allow Identical Document No." then
            exit;

          FAJnlLine."FA Posting Type" := "FA Posting Type" - 1;
          if "FA Posting Type" <> "fa posting type"::Maintenance then begin
            OldFALedgEntry.SetCurrentkey(
              "FA No.","Depreciation Book Code","FA Posting Category","FA Posting Type","Document No.");
            OldFALedgEntry.SetRange("FA No.",FANo);
            OldFALedgEntry.SetRange("Depreciation Book Code","Depreciation Book Code");
            OldFALedgEntry.SetRange("FA Posting Category",OldFALedgEntry."fa posting category"::" ");
            OldFALedgEntry.SetRange("FA Posting Type",FAJnlLine.ConvertToLedgEntry(FAJnlLine));
            OldFALedgEntry.SetRange("Document No.","Document No.");
            if OldFALedgEntry.FindFirst then
              AddError(
                StrSubstNo(
                  Text073,
                  FieldCaption("Document No."),"Document No."));
          end else begin
            OldMaintenanceLedgEntry.SetCurrentkey(
              "FA No.","Depreciation Book Code","Document No.");
            OldMaintenanceLedgEntry.SetRange("FA No.",FANo);
            OldMaintenanceLedgEntry.SetRange("Depreciation Book Code","Depreciation Book Code");
            OldMaintenanceLedgEntry.SetRange("Document No.","Document No.");
            if OldMaintenanceLedgEntry.FindFirst then
              AddError(
                StrSubstNo(
                  Text073,
                  FieldCaption("Document No."),"Document No."));
          end;
        end;
    end;


    procedure InitializeRequest(NewShowDim: Boolean)
    begin
        ShowDim := NewShowDim;
    end;

    local procedure GetDimensionText(var DimensionSetEntry: Record "Dimension Set Entry"): Text[75]
    var
        DimensionText: Text[75];
        Separator: Code[10];
        DimValue: Text[45];
    begin
        Separator := '';
        DimValue := '';
        Continue := false;

        repeat
          DimValue := StrSubstNo('%1 - %2',DimensionSetEntry."Dimension Code",DimensionSetEntry."Dimension Value Code");
          if MaxStrLen(DimensionText) < StrLen(DimensionText + Separator + DimValue) then begin
            Continue := true;
            exit(DimensionText);
          end;
          DimensionText := DimensionText + Separator + DimValue;
          Separator := '; ';
        until DimSetEntry.Next = 0;
        exit(DimensionText);
    end;
}

