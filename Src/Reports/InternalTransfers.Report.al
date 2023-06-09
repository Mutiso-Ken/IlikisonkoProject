#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516902 "Internal Transfers"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Internal Transfers.rdlc';

    dataset
    {
        dataitem("Sacco Transfers";"Sacco Transfers")
        {
            column(ReportForNavId_1000000000; 1000000000)
            {
            }
            column(CI_Name;CI.Name)
            {
                IncludeCaption = true;
            }
            column(CI_Address;CI.Address)
            {
                IncludeCaption = true;
            }
            column(CI_Address2;CI."Address 2" )
            {
                IncludeCaption = true;
            }
            column(CI_PhoneNo;CI."Phone No.")
            {
                IncludeCaption = true;
            }
            column(CI_Picture;CI.Picture)
            {
                IncludeCaption = true;
            }
            column(CI_City;CI.City)
            {
                IncludeCaption = true;
            }
            column(DOCNAME;DOCNAME)
            {
            }
            column(No_SaccoTransfers;"Sacco Transfers".No)
            {
            }
            column(TransactionDate_SaccoTransfers;Format("Sacco Transfers"."Transaction Date"))
            {
            }
            column(ScheduleTotal_SaccoTransfers;"Sacco Transfers"."Schedule Total")
            {
            }
            column(Approved_SaccoTransfers;"Sacco Transfers".Approved)
            {
            }
            column(ApprovedBy_SaccoTransfers;"Sacco Transfers"."Approved By")
            {
            }
            column(Posted_SaccoTransfers;"Sacco Transfers".Posted)
            {
            }
            column(SourceAccount_SaccoTransfers;"Sacco Transfers"."Source Account")
            {
            }
            column(NoSeries_SaccoTransfers;"Sacco Transfers"."No. Series")
            {
            }
            column(MemberName_SaccoTransfers;"Sacco Transfers"."Member Name")
            {
            }
            column(ResponsibilityCenter_SaccoTransfers;"Sacco Transfers"."Responsibility Center")
            {
            }
            column(Remarks_SaccoTransfers;"Sacco Transfers".Remarks)
            {
            }
            column(SourceAccountType_SaccoTransfers;"Sacco Transfers"."Source Account Type")
            {
            }
            column(SourceTransactionType_SaccoTransfers;"Sacco Transfers"."Source Transaction Type")
            {
            }
            column(SourceAccountName_SaccoTransfers;"Sacco Transfers"."Source Account Name")
            {
            }
            column(SourceLoanNo_SaccoTransfers;"Sacco Transfers"."Source Loan No")
            {
            }
            column(CreatedBy_SaccoTransfers;"Sacco Transfers"."Created By")
            {
            }
            column(Debit_SaccoTransfers;"Sacco Transfers".Debit)
            {
            }
            column(Refund_SaccoTransfers;"Sacco Transfers".Refund)
            {
            }
            column(GuarantorRecovery_SaccoTransfers;"Sacco Transfers"."Guarantor Recovery")
            {
            }
            column(PayrolNo_SaccoTransfers;"Sacco Transfers"."Payrol No.")
            {
            }
            column(GlobalDimension1Code_SaccoTransfers;"Sacco Transfers"."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_SaccoTransfers;"Sacco Transfers"."Global Dimension 2 Code")
            {
            }
            column(BosaNumber_SaccoTransfers;"Sacco Transfers"."Bosa Number")
            {
            }
            column(Status_SaccoTransfers;"Sacco Transfers".Status)
            {
            }
            column(NumberText_1_;NumberText[1])
            {
            }
            dataitem("Sacco Transfers Schedule";"Sacco Transfers Schedule")
            {
                DataItemLink = "No."=field(No);
                column(ReportForNavId_1000000001; 1000000001)
                {
                }
                column(No_SaccoTransfersSchedule;"Sacco Transfers Schedule"."No.")
                {
                }
                column(DestinationAccountNo_SaccoTransfersSchedule;"Sacco Transfers Schedule"."Destination Account No.")
                {
                }
                column(DestinationAccountName_SaccoTransfersSchedule;"Sacco Transfers Schedule"."Destination Account Name")
                {
                }
                column(DestinationAccountType_SaccoTransfersSchedule;"Sacco Transfers Schedule"."Destination Account Type")
                {
                }
                column(DestinationType_SaccoTransfersSchedule;"Sacco Transfers Schedule"."Destination Type")
                {
                }
                column(DestinationLoan_SaccoTransfersSchedule;"Sacco Transfers Schedule"."Destination Loan")
                {
                }
                column(Amount_SaccoTransfersSchedule;"Sacco Transfers Schedule".Amount)
                {
                }
                column(Description_SaccoTransfersSchedule;"Sacco Transfers Schedule"."Transaction Description")
                {
                }
                column(CreatedBy_SaccoTransfersSchedule;"Sacco Transfers Schedule"."Created By")
                {
                }
                column(CummulativeTotalPaymentLoan_SaccoTransfersSchedule;"Sacco Transfers Schedule"."Cummulative Total Payment Loan")
                {
                }
                column(Credit_SaccoTransfersSchedule;"Sacco Transfers Schedule".Credit)
                {
                }
                column(GlobalDimension1Code_SaccoTransfersSchedule;"Sacco Transfers Schedule"."Global Dimension 1 Code")
                {
                }
                column(GlobalDimension2Code_SaccoTransfersSchedule;"Sacco Transfers Schedule"."Global Dimension 2 Code")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if "Destination Account Type" = "destination account type"::VENDOR then begin
                    Vend.Reset;
                    if Vend.Get("Destination Account No.") then

                    "Destination Type":="destination type"::"Ordinary Savings";
                    end;
                end;
            }
            dataitem("Approval Entry";"Approval Entry")
            {
                DataItemLink = "Document No."=field(No);
                column(ReportForNavId_1; 1)
                {
                }
                column(TableID_ApprovalEntry;"Approval Entry"."Table ID")
                {
                }
                column(DocumentType_ApprovalEntry;"Approval Entry"."Document Type")
                {
                }
                column(DocumentNo_ApprovalEntry;"Approval Entry"."Document No.")
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
                column(Status_ApprovalEntry;"Approval Entry".Status)
                {
                }
                column(DateTimeSentforApproval_ApprovalEntry;"Approval Entry"."Date-Time Sent for Approval")
                {
                }
                column(LastDateTimeModified_ApprovalEntry;"Approval Entry"."Last Date-Time Modified")
                {
                }
                column(Comment_ApprovalEntry;"Approval Entry".Comment)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                "Sacco Transfers".CalcFields("Sacco Transfers"."Schedule Total");
                CheckReport.InitTextVariable();
                CheckReport.FormatNoText(NumberText,"Sacco Transfers"."Schedule Total",' ');
            end;

            trigger OnPreDataItem()
            begin
                CI.Get();
                CI.CalcFields(CI.Picture);
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
        CI.Get();
        CI.CalcFields(CI.Picture);
    end;

    var
        StrCopyText: Text[30];
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        DimVal: Record "Dimension Value";
        DimValName: Text[30];
        TTotal: Decimal;
        CheckReport: Report Check;
        NumberText: array [2] of Text[80];
        STotal: Decimal;
        InvoiceCurrCode: Code[10];
        CurrCode: Code[10];
        GLSetup: Record "General Ledger Setup";
        DOCNAME: Text[30];
        VATCaptionLbl: label 'VAT';
        PAYMENT_DETAILSCaptionLbl: label 'PAYMENT DETAILS';
        AMOUNTCaptionLbl: label 'AMOUNT';
        NET_AMOUNTCaptionLbl: label 'AMOUNT';
        W_TAXCaptionLbl: label 'W/TAX';
        Document_No___CaptionLbl: label 'Document No. :';
        Currency_CaptionLbl: label 'Currency:';
        Payment_To_CaptionLbl: label 'Payment To:';
        Document_Date_CaptionLbl: label 'Document Date:';
        Cheque_No__CaptionLbl: label 'Cheque No.:';
        R_CENTERCaptionLbl: label 'R.CENTER CODE';
        PROJECTCaptionLbl: label 'PROJECT CODE';
        TotalCaptionLbl: label 'Total';
        Printed_By_CaptionLbl: label 'Printed By:';
        Amount_in_wordsCaptionLbl: label 'Amount in words';
        EmptyStringCaptionLbl: label '================================================================================================================================================================================================';
        EmptyStringCaption_Control1102755013Lbl: label '================================================================================================================================================================================================';
        Amount_in_wordsCaption_Control1102755021Lbl: label 'Amount in words';
        Printed_By_Caption_Control1102755026Lbl: label 'Printed By:';
        TotalCaption_Control1102755033Lbl: label 'Total';
        Signature_CaptionLbl: label 'Signature:';
        Date_CaptionLbl: label 'Date:';
        Name_CaptionLbl: label 'Name:';
        RecipientCaptionLbl: label 'Recipient';
        CompanyInfo: Record "Company Information";
        BudgetLbl: label 'Budget';
        CreationDoc: Boolean;
        DtldVendEntry: Record "Detailed Vendor Ledg. Entry";
        InvNo: Code[20];
        InvAmt: Decimal;
        ApplyEnt: Record "Vendor Ledger Entry";
        VendEnrty: Record "Vendor Ledger Entry";
        CI: Record "Company Information";
        Vend: Record Vendor;
}

