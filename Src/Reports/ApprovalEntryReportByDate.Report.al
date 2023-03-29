#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516458 "Approval Entry Report By Date"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Approval Entry Report By Date.rdlc';

    dataset
    {
        dataitem("Approval Entry";"Approval Entry")
        {
            RequestFilterFields = "Date-Time Sent for Approval","Document Type";
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
            column(ApprovalCode_ApprovalEntry;"Approval Entry"."Approval Code")
            {
            }
            column(SenderID_ApprovalEntry;"Approval Entry"."Sender ID")
            {
            }
            column(SalespersPurchCode_ApprovalEntry;"Approval Entry"."Salespers./Purch. Code")
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
            column(LastModifiedByUserID_ApprovalEntry;"Approval Entry"."Last Modified By User ID")
            {
            }
            column(Comment_ApprovalEntry;"Approval Entry".Comment)
            {
            }
            column(DueDate_ApprovalEntry;"Approval Entry"."Due Date")
            {
            }
            column(Amount_ApprovalEntry;"Approval Entry".Amount)
            {
            }
            column(AmountLCY_ApprovalEntry;"Approval Entry"."Amount (LCY)")
            {
            }
            column(CurrencyCode_ApprovalEntry;"Approval Entry"."Currency Code")
            {
            }
            column(ApprovalType_ApprovalEntry;"Approval Entry"."Approval Type")
            {
            }
            column(LimitType_ApprovalEntry;"Approval Entry"."Limit Type")
            {
            }
            column(AvailableCreditLimitLCY_ApprovalEntry;"Approval Entry"."Available Credit Limit (LCY)")
            {
            }
            column(PendingApprovals_ApprovalEntry;"Approval Entry"."Pending Approvals")
            {
            }
            column(DelegationDateFormula_ApprovalEntry;"Approval Entry"."Delegation Date Formula")
            {
            }
            column(NumberofApprovedRequests_ApprovalEntry;"Approval Entry"."Number of Approved Requests")
            {
            }
            column(NumberofRejectedRequests_ApprovalEntry;"Approval Entry"."Number of Rejected Requests")
            {
            }
            column(EntryNo_ApprovalEntry;"Approval Entry"."Entry No.")
            {
            }
            column(WorkflowStepInstanceID_ApprovalEntry;"Approval Entry"."Workflow Step Instance ID")
            {
            }
            column(RelatedtoChange_ApprovalEntry;"Approval Entry"."Related to Change")
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

