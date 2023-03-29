#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516486 "BOSA Receipt Slipx"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/BOSA Receipt Slipx.rdlc';

    dataset
    {
        dataitem("Receipts & Payments";"Receipts & Payments")
        {
            RequestFilterFields = "Transaction No.","Account No.",Amount,"Cheque No.","Employer No.";
            column(ReportForNavId_1102755000; 1102755000)
            {
            }
            column(TransactionNo_ReceiptsPayments;"Receipts & Payments"."Transaction No.")
            {
            }
            column(NumberText_1_;NumberText[1])
            {
            }
            column(AccountNo_ReceiptsPayments;"Receipts & Payments"."Account No.")
            {
            }
            column(Name_ReceiptsPayments;"Receipts & Payments".Name)
            {
            }
            column(Amount_ReceiptsPayments;"Receipts & Payments".Amount)
            {
            }
            column(ChequeNo_ReceiptsPayments;"Receipts & Payments"."Cheque No.")
            {
            }
            column(ChequeDate_ReceiptsPayments;"Receipts & Payments"."Cheque Date")
            {
            }
            column(Posted_ReceiptsPayments;"Receipts & Payments".Posted)
            {
            }
            column(BankNo_ReceiptsPayments;"Receipts & Payments"."Employer No.")
            {
            }
            column(UserID_ReceiptsPayments;"Receipts & Payments"."User ID")
            {
            }
            column(AllocatedAmount_ReceiptsPayments;"Receipts & Payments"."Allocated Amount")
            {
            }
            column(TransactionDate_ReceiptsPayments;Format("Receipts & Payments"."Transaction Date"))
            {
            }
            column(TransactionTime_ReceiptsPayments;"Receipts & Payments"."Transaction Time")
            {
            }
            column(BankName_ReceiptsPayments;"Receipts & Payments"."Bank Name")
            {
            }
            column(NoSeries_ReceiptsPayments;"Receipts & Payments"."No. Series")
            {
            }
            column(AccountType_ReceiptsPayments;"Receipts & Payments"."Account Type")
            {
            }
            column(TransactionSlipType_ReceiptsPayments;"Receipts & Payments"."Transaction Slip Type")
            {
            }
            column(Insuarance_ReceiptsPayments;"Receipts & Payments".Insuarance)
            {
            }
            column(UnallocatedAmount_ReceiptsPayments;"Receipts & Payments"."Un allocated Amount")
            {
            }
            column(Remarks_ReceiptsPayments;"Receipts & Payments".Remarks)
            {
            }
            column(CompanyName;companyInfo.Name)
            {
            }
            column(CompanyAddress;companyInfo.Address)
            {
            }
            column(CompanyCity;companyInfo.City)
            {
            }
            column(CompanyPhoneNo;companyInfo."Phone No.")
            {
            }
            column(StaffNo;StaffNo)
            {
            }
            column(CompanyPicture;companyInfo.Picture)
            {
            }
            dataitem("Receipt Allocation";"Receipt Allocation")
            {
                DataItemLink = "Document No"=field("Transaction No.");
                column(ReportForNavId_1102755001; 1102755001)
                {
                }
                column(DocumentNo_ReceiptAllocation;"Receipt Allocation"."Document No")
                {
                }
                column(MemberNo_ReceiptAllocation;"Receipt Allocation"."Member No")
                {
                }
                column(TransactionType_ReceiptAllocation;"Receipt Allocation"."Transaction Type")
                {
                }
                column(LoanNo_ReceiptAllocation;"Receipt Allocation"."Loan No.")
                {
                }
                column(Amount_ReceiptAllocation;"Receipt Allocation".Amount)
                {
                }
                column(InterestAmount_ReceiptAllocation;"Receipt Allocation"."Interest Amount")
                {
                }
                column(TotalAmount_ReceiptAllocation;"Receipt Allocation"."Total Amount")
                {
                }
                column(AmountBalance_ReceiptAllocation;"Receipt Allocation"."Amount Balance")
                {
                }
                column(InterestBalance_ReceiptAllocation;"Receipt Allocation"."Interest Balance")
                {
                }
                column(LoanID_ReceiptAllocation;"Receipt Allocation"."Loan ID")
                {
                }
                column(PrepaymentDate_ReceiptAllocation;"Receipt Allocation"."Prepayment Date")
                {
                }
                column(LoanInsurance_ReceiptAllocation;"Receipt Allocation"."Loan Insurance")
                {
                }
                column(AppliedAmount_ReceiptAllocation;"Receipt Allocation"."Applied Amount")
                {
                }
                column(Insurance_ReceiptAllocation;"Receipt Allocation".Insurance)
                {
                }
                column(UnAllocatedAmount_ReceiptAllocation;"Receipt Allocation"."Un Allocated Amount")
                {
                }
                column(GlobalDimension1Code_ReceiptAllocation;"Receipt Allocation"."Global Dimension 1 Code")
                {
                }
                column(GlobalDimension2Code_ReceiptAllocation;"Receipt Allocation"."Global Dimension 2 Code")
                {
                }
                column(LoanProductName_ReceiptAllocation;"Receipt Allocation"."Loan Product Name")
                {
                }
                column(LoanDesc;LoanDesc)
                {
                }

                trigger OnAfterGetRecord()
                begin
                       // IF "Transaction Type"="Transaction Type"::"Benevolent Fund" THEN
                       // "Receipt Allocation"."Loan ID":= '';
                       LoanDesc:='';
                       if "Receipt Allocation"."Loan No."<>'' then begin
                       "Receipt Allocation".CalcFields("Receipt Allocation"."Loan Product Name");
                        LoanDesc:="Receipt Allocation"."Loan Product Name"+' Loan';
                        end;
                end;
            }

            trigger OnAfterGetRecord()
            begin

                if Cust.Get("Receipts & Payments"."Account No.") then begin
                Comms:=0;
                  StaffNo:=Cust."Personal No";
                end;
                //IF CashPayType.GET("Receipts & Payments"."Cash Window Pay Type") THEN
                //Comms:=CashPayType.Description;

                CheckReport.InitTextVariable();
                CheckReport.FormatNoText(NumberText,Amount,' ');
            end;

            trigger OnPreDataItem()
            begin

                companyInfo.Get();
                companyInfo.CalcFields(companyInfo.Picture);
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

    var
        Cust: Record "Member Register";
        Comms: Decimal;
        CashPayType: Record "HR Leave Family Employees";
        companyInfo: Record "Company Information";
        NumberText: array [2] of Text[80];
        LastFieldNo: Integer;
        CheckReport: Report Check;
        StaffNo: Code[30];
        LoanDesc: Text[60];


    procedure CalAvailableBal()
    begin
    end;
}

