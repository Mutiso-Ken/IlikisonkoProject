#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516516 "BOSA Receipt Slip XX"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/BOSA Receipt Slip XX.rdlc';

    dataset
    {
        dataitem(Transactions;Transactions)
        {
            column(ReportForNavId_1102755000; 1102755000)
            {
            }
            column(No_Transactions;Transactions.No)
            {
            }
            column(NumberText_1_;NumberText[1])
            {
            }
            column(MemberNo_Transactions;Transactions."Member No")
            {
            }
            column(MemberName_Transactions;Transactions."Member Name")
            {
            }
            column(Amount_Transactions;Transactions.Amount)
            {
            }
            column(AllocatedAmount_Transactions;Transactions."Allocated Amount")
            {
            }
            column(Posted_Transactions;Transactions.Posted)
            {
            }
            column(Cashier_Transactions;Transactions.Cashier)
            {
            }
            column(Remarks_Transactions;Transactions.Remarks)
            {
            }
            column(TransactionDate_Transactions;Format(Transactions."Transaction Date"))
            {
            }
            column(TransactionTime_Transactions;Transactions."Transaction Time")
            {
            }
            column(DocumentDate_Transactions;Transactions."Document Date")
            {
            }
            column(id_no;Cust."ID No.")
            {
            }
            column(emp_no;Cust."Personal No")
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
            column(CompanyPicture;companyInfo.Picture)
            {
            }
            dataitem("Receipt Allocation";"Receipt Allocation")
            {
                DataItemLink = "Document No"=field(No);
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
                column(LN;"Receipt Allocation"."Loan No.")
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

                trigger OnAfterGetRecord()
                begin
                       // IF "Transaction Type"="Transaction Type"::"Benevolent Fund" THEN
                       // "Receipt Allocation"."Loan ID":= '';
                end;
            }

            trigger OnAfterGetRecord()
            begin

                if Cust.Get(Transactions."Member No") then
                Comms:=0;
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


    procedure CalAvailableBal()
    begin
    end;
}

