#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516861 "Reversal Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Reversal Report.rdlc';

    dataset
    {
        dataitem("Member Ledger Entry";"Member Ledger Entry")
        {
            DataItemTableView = where(Reversed=const(true));
            RequestFilterFields = "Posting Date","User ID";
            column(ReportForNavId_1120054000; 1120054000)
            {
            }
            column(EntryNo;"Member Ledger Entry"."Entry No.")
            {
            }
            column(CustomerNo;"Member Ledger Entry"."Customer No.")
            {
            }
            column(PostingDate;"Member Ledger Entry"."Posting Date")
            {
            }
            column(DocumentType;"Member Ledger Entry"."Document Type")
            {
            }
            column(Description;"Member Ledger Entry".Description)
            {
            }
            column(Amount;"Member Ledger Entry".Amount)
            {
            }
            column(RemainingAmount;"Member Ledger Entry"."Remaining Amount")
            {
            }
            column(UserID;"Member Ledger Entry"."User ID")
            {
            }
            column(ReversedbyEntryNo;"Member Ledger Entry"."Reversed by Entry No.")
            {
            }
            column(ReversedEntryNo;"Member Ledger Entry"."Reversed Entry No.")
            {
            }
            column(Reversed;"Member Ledger Entry".Reversed)
            {
            }
            column(TransactionType;"Member Ledger Entry"."Transaction Type")
            {
            }
            column(LoanNo;"Member Ledger Entry"."Loan No")
            {
            }
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
}

