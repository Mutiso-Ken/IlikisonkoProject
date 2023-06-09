#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516914 "Checkoff Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Checkoff Report.rdlc';

    dataset
    {
        dataitem("Checkoff Header-Distributed";"Checkoff Header-Distributed")
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
            column(Amount_CheckoffHeaderDistributed;"Checkoff Header-Distributed".Amount)
            {
            }
            column(AccountType_CheckoffHeaderDistributed;"Checkoff Header-Distributed"."Account Type")
            {
            }
            column(AccountNo_CheckoffHeaderDistributed;"Checkoff Header-Distributed"."Account No")
            {
            }
            column(No_CheckoffHeaderDistributed;"Checkoff Header-Distributed".No)
            {
            }
            column(DocumentNo_CheckoffHeaderDistributed;"Checkoff Header-Distributed"."Document No")
            {
            }
            column(Remarks_CheckoffHeaderDistributed;"Checkoff Header-Distributed".Remarks)
            {
            }
            column(DateEntered_CheckoffHeaderDistributed;Format("Checkoff Header-Distributed"."Date Entered"))
            {
            }
            column(NumberText_1_;NumberText[1])
            {
            }
            dataitem("Checkoff Lines-Distributed";"Checkoff Lines-Distributed")
            {
                DataItemLink = "Receipt Header No"=field(No);
                column(ReportForNavId_1000000001; 1000000001)
                {
                }
                column(StaffPayrollNo_CheckoffLinesDistributed;"Checkoff Lines-Distributed"."Staff/Payroll No")
                {
                }
                column(Amount_CheckoffLinesDistributed;"Checkoff Lines-Distributed".Amount)
                {
                }
                column(NoRepayment_CheckoffLinesDistributed;"Checkoff Lines-Distributed"."No Repayment")
                {
                }
                column(StaffNotFound_CheckoffLinesDistributed;"Checkoff Lines-Distributed"."Staff Not Found")
                {
                }
                column(DateFilter_CheckoffLinesDistributed;"Checkoff Lines-Distributed"."Date Filter")
                {
                }
                column(TransactionDate_CheckoffLinesDistributed;"Checkoff Lines-Distributed"."Transaction Date")
                {
                }
                column(EntryNo_CheckoffLinesDistributed;"Checkoff Lines-Distributed"."Entry No")
                {
                }
                column(Generated_CheckoffLinesDistributed;"Checkoff Lines-Distributed".Generated)
                {
                }
                column(PaymentNo_CheckoffLinesDistributed;"Checkoff Lines-Distributed"."Payment No")
                {
                }
                column(Posted_CheckoffLinesDistributed;"Checkoff Lines-Distributed".Posted)
                {
                }
                column(MultipleReceipts_CheckoffLinesDistributed;"Checkoff Lines-Distributed"."Multiple Receipts")
                {
                }
                column(Name_CheckoffLinesDistributed;"Checkoff Lines-Distributed".Name)
                {
                }
                column(EarlyRemitances_CheckoffLinesDistributed;"Checkoff Lines-Distributed"."Early Remitances")
                {
                }
                column(EarlyRemitanceAmount_CheckoffLinesDistributed;"Checkoff Lines-Distributed"."Early Remitance Amount")
                {
                }
                column(LoanNo_CheckoffLinesDistributed;"Checkoff Lines-Distributed"."Loan No.")
                {
                }
                column(MemberNo_CheckoffLinesDistributed;"Checkoff Lines-Distributed"."Member No.")
                {
                }
                column(Interest_CheckoffLinesDistributed;"Checkoff Lines-Distributed".Interest)
                {
                }
                column(LoanType_CheckoffLinesDistributed;"Checkoff Lines-Distributed"."Loan Type")
                {
                }
                column(DEPT_CheckoffLinesDistributed;"Checkoff Lines-Distributed".DEPT)
                {
                }
                column(ExpectedAmount_CheckoffLinesDistributed;"Checkoff Lines-Distributed"."Expected Amount")
                {
                }
                column(FOSAAccount_CheckoffLinesDistributed;"Checkoff Lines-Distributed"."FOSA Account")
                {
                }
                column(UtilityType_CheckoffLinesDistributed;"Checkoff Lines-Distributed"."Trans Type")
                {
                }
                column(TransactionType_CheckoffLinesDistributed;"Checkoff Lines-Distributed"."Transaction Type")
                {
                }
                column(Reference_CheckoffLinesDistributed;"Checkoff Lines-Distributed"."Special Code")
                {
                }
                column(Accounttype_CheckoffLinesDistributed;"Checkoff Lines-Distributed"."Account type")
                {
                }
                column(Variance_CheckoffLinesDistributed;"Checkoff Lines-Distributed".Variance)
                {
                }
                column(EmployerCode_CheckoffLinesDistributed;"Checkoff Lines-Distributed"."Employer Code")
                {
                }
                column(GPersonalNo_CheckoffLinesDistributed;"Checkoff Lines-Distributed".GPersonalNo)
                {
                }
                column(Gnames_CheckoffLinesDistributed;"Checkoff Lines-Distributed".Gnames)
                {
                }
                column(Gnumber_CheckoffLinesDistributed;"Checkoff Lines-Distributed".Gnumber)
                {
                }
                column(Userid1_CheckoffLinesDistributed;"Checkoff Lines-Distributed".Userid1)
                {
                }
                column(LoansNotfound_CheckoffLinesDistributed;"Checkoff Lines-Distributed"."Loans Not found")
                {
                }
                column(ReceiptHeaderNo_CheckoffLinesDistributed;"Checkoff Lines-Distributed"."Receipt Header No")
                {
                }
                column(UnallocatedFund_CheckoffLinesDistributed;"Checkoff Lines-Distributed".Source)
                {
                }
                column(PostingDate_CheckoffLinesDistributed;"Checkoff Lines-Distributed"."Advice Number")
                {
                }
                column(DocumentNo_CheckoffLinesDistributed;"Checkoff Lines-Distributed"."Document No")
                {
                }
                column(LedgerFound_CheckoffLinesDistributed;"Checkoff Lines-Distributed"."Ledger Found")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                //"Checkoff Header-Distributed".CALCFIELDS("Checkoff Header-Distributed".Amount);
                CheckReport.InitTextVariable();
                CheckReport.FormatNoText(NumberText,"Checkoff Header-Distributed".Amount,' ');
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
}

