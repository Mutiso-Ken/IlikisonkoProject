#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516952 Stopinterest
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Stopinterest.rdlc';

    dataset
    {
        dataitem("Loans Register";"Loans Register")
        {
            DataItemTableView = where(Posted=const(true));
            RequestFilterFields = "Loan  No.";
            column(ReportForNavId_1; 1)
            {
            }
            column(LoanNo_LoansRegister;"Loans Register"."Loan  No.")
            {
            }
            column(LoanProductType_LoansRegister;"Loans Register"."Loan Product Type")
            {
            }
            column(ClientCode_LoansRegister;"Loans Register"."Client Code")
            {
            }
            column(RequestedAmount_LoansRegister;"Loans Register"."Requested Amount")
            {
            }
            column(ApprovedAmount_LoansRegister;"Loans Register"."Approved Amount")
            {
            }
            column(Interest_LoansRegister;"Loans Register".Interest)
            {
            }
            column(ClientName_LoansRegister;"Loans Register"."Client Name")
            {
            }
            column(LoanStatus_LoansRegister;"Loans Register"."Loan Status")
            {
            }
            column(IssuedDate_LoansRegister;"Loans Register"."Issued Date")
            {
            }
            column(LoanProductTypeName_LoansRegister;"Loans Register"."Loan Product Type Name")
            {
            }
            column(Posted_LoansRegister;"Loans Register".Posted)
            {
            }
            column(AmountDisbursed_LoansRegister;"Loans Register"."Amount Disbursed")
            {
            }
            column(NewInterestRate_LoansRegister;"Loans Register"."New Interest Rate")
            {
            }
            column(InterestDue_LoansRegister;"Loans Register"."Interest Due")
            {
            }
            column(InterestPaid_LoansRegister;"Loans Register"."Interest Paid")
            {
            }
            column(StaffNo_LoansRegister;"Loans Register"."Staff No")
            {
            }
            column(TotalInterest_LoansRegister;"Loans Register"."Total Interest")
            {
            }
            column(StopInterestAccrual_LoansRegister;"Loans Register"."Stop Interest Accrual")
            {
            }
            column(ExemptFromInterest_LoansRegister;"Loans Register"."Exempt From Interest")
            {
            }

            trigger OnAfterGetRecord()
            var
                cnfm: label 'You are about to %1 the loan interest for loan %2? Do you want to proceed?';
                stop_start: Text;
            begin

                stop_start := 'Stop';
                if "Loans Register"."Stop Interest Accrual" then
                   stop_start := 'Start';

                if Confirm(cnfm,false,stop_start,"Loans Register"."Loan  No."+ ' '+"Loans Register"."Client Name") then
                  begin


                   "Loans Register"."Stop Interest Accrual":=not "Loans Register"."Stop Interest Accrual";
                    "Loans Register".Modify;

                  end;
            end;

            trigger OnPreDataItem()
            begin
                if "Loans Register".Count <> 1 then
                   Error('You can only run one loan at a time!');
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

    trigger OnInitReport()
    begin
        if Usersetup.Get(UserId) then
        begin
        if Usersetup."Stop Interest"=false then Error ('You do not have permissions for stopping interest, Contact your system administrator! ')
        end;
    end;

    trigger OnPreReport()
    begin
        //MESSAGE('Enter one loan no of member need to stop interest');
    end;

    var
        LoanNo: Code[10];
        Usersetup: Record "User Setup";
}

