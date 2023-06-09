#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516931 "Member Ledger Entries"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Member Ledger Entries.rdlc';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Member Ledger Entry";"Member Ledger Entry")
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(Amount_MemberLedgerEntry;"Member Ledger Entry".Amount)
            {
            }
            column(UserID_MemberLedgerEntry;"Member Ledger Entry"."User ID")
            {
            }
            column(TransactionType_MemberLedgerEntry;"Member Ledger Entry"."Transaction Type")
            {
            }
            column(LoanNo_MemberLedgerEntry;"Member Ledger Entry"."Loan No")
            {
            }
            column(EntryNo_MemberLedgerEntry;"Member Ledger Entry"."Entry No.")
            {
            }
            column(CustomerNo_MemberLedgerEntry;"Member Ledger Entry"."Customer No.")
            {
            }
            column(PostingDate_MemberLedgerEntry;"Member Ledger Entry"."Posting Date")
            {
            }
            column(DocumentType_MemberLedgerEntry;"Member Ledger Entry"."Document Type")
            {
            }
            column(DocumentNo_MemberLedgerEntry;"Member Ledger Entry"."Document No.")
            {
            }
            column(Description_MemberLedgerEntry;"Member Ledger Entry".Description)
            {
            }
            column(Reversed_MemberLedgerEntry;"Member Ledger Entry".Reversed)
            {
            }
            column(DebitAmount_MemberLedgerEntry;"Member Ledger Entry"."Debit Amount")
            {
            }
            column(CreditAmount_MemberLedgerEntry;"Member Ledger Entry"."Credit Amount")
            {
            }
            column(Company_Name;Company.Name)
            {
            }
            column(Company_Address;Company.Address)
            {
            }
            column(Company_Address_2;Company."Address 2")
            {
            }
            column(Company_Phone_No;Company."Phone No.")
            {
            }
            column(Company_Fax_No;Company."Fax No.")
            {
            }
            column(Company_Picture;Company.Picture)
            {
            }
            column(Company_Email;Company."E-Mail")
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

    var
        MeetingsMessage: label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">Meeting Notification</p><p style="font-family:Verdana,Arial;font-size:9pt">This is to confirm that you have a scheduled meeting with %2  on  %3  at %4,</p><p style="font-family:Verdana,Arial;font-size:9pt"> </b></p><br>Regards<p>%5</p><p><b>KINGDOM SACCO LTD</b></p>';
        Memb: Record "Membership Applications";
        SMTPMail: Codeunit "SMTP Mail";
        SMTPSetup: Record "SMTP Mail Setup";
        FileName: Text[100];
        Attachment: Text[250];
        CompanyInfo: Record "Company Information";
        ObjMeetings: Record "Meetings Schedule";
        VarNoticeDate: Date;
        ObjHouseGroups: Record "Member House Groups";
        VarGroupName: Code[80];
        Company: Record "Company Information";
}

