#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516930 "Scheduled Meeting Notification"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Scheduled Meeting Notification.rdlc';

    dataset
    {
        dataitem("Meetings Schedule"; "Meetings Schedule")
        {
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                SMTPSetup.Get();
                VarNoticeDate := CalcDate('2D', Today);
                if ObjHouseGroups.Get("Lead No") then begin
                    VarGroupName := ObjHouseGroups."Cell Group Name";
                end;

                //Notify Staff===================================================================
                ObjMeetings.Reset;
                ObjMeetings.SetRange(ObjMeetings."Lead No", "Lead No");
                ObjMeetings.SetRange(ObjMeetings."Meeting Date", VarNoticeDate);
                ObjMeetings.SetFilter(ObjMeetings."User Email", '<>%1', '');
                if ObjMeetings.FindSet then begin
                    if ObjMeetings."User Email" = '' then begin
                        Error('Email Address Missing for User' + '-' + ObjMeetings."User to Notify");
                    end;
                    if ObjMeetings."User Email" <> '' then
                        SMTPMail.CreateMessage(SMTPSetup."Email Sender Name", SMTPSetup."Email Sender Address", ObjMeetings."User Email", 'Meeting Notification', '', true);
                    SMTPMail.AppendBody(StrSubstNo(MeetingsMessage, ObjMeetings."User to Notify", VarGroupName, ObjMeetings."Meeting Date", ObjMeetings."Meeting Place", UserId));
                    SMTPMail.AppendBody(SMTPSetup."Email Sender Name");
                    SMTPMail.AppendBody('<br><br>');
                    SMTPMail.AddAttachment(FileName, Attachment);
                    SMTPMail.Send;
                end;
                //End Notify Staff===================================================================

                //Notify Customer====================================================================
                ObjMeetings.Reset;
                ObjMeetings.SetRange(ObjMeetings."Lead No", "Lead No");
                ObjMeetings.SetRange(ObjMeetings."Meeting Date", VarNoticeDate);
                if ObjMeetings.FindSet then begin
                    if ObjLeads.Get(ObjMeetings."Lead No") then begin
                        VarCustEmail := ObjLeads."E-Mail";
                    end;
                    if VarCustEmail = '' then begin
                        exit;
                    end;
                    if VarCustEmail <> '' then
                        SMTPMail.CreateMessage(SMTPSetup."Email Sender Name", SMTPSetup."Email Sender Address", VarCustEmail, 'Meeting Notification', '', true);
                    SMTPMail.AppendBody(StrSubstNo(MeetingsMessage, VarCustName, ObjMeetings."User to Notify", ObjMeetings."Meeting Date", ObjMeetings."Meeting Place", UserId));
                    SMTPMail.AppendBody(SMTPSetup."Email Sender Name");
                    SMTPMail.AppendBody('<br><br>');
                    SMTPMail.AddAttachment(FileName, Attachment);
                    SMTPMail.Send;
                end;

                //End Notify Customer================================================================

                SMTPSetup.Get();
                VarNoticeDate := CalcDate('2D', Today);
                //Send Sms Notification to Customer==================================================

                if ObjMeetings."Meeting Date" = VarNoticeDate then begin
                    if ObjLeads.Get(ObjMeetings."Lead No") then begin
                        if ObjLeads."Phone No." <> '' then
                            VarSmsBody := 'Dear ' + ' ' + ObjLeads."First Name" + ',' + 'you have a scheduled meeting with' + ' ' + ObjMeetings."User to Notify" + ' ' + 'on' + ' '
                            + Format(ObjMeetings."Meeting Date") + ' ' + 'at' + ' ' + ObjMeetings."Meeting Place" + '.Contact Kingdom Sacco for clarification.';
                        SurestpFactory.FnSendSMS('MeetingNotification', VarSmsBody, ObjLeads."No.", ObjLeads."Phone No.");
                    end;
                end;

                //End Send SMS Notification to Customer==============================================
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
        ObjLeads: Record "Lead Management";
        VarCustEmail: Text[30];
        VarCustName: Code[50];
        SurestpFactory: Codeunit "SURESTEP Factory";
        VarSmsBody: Text;
}

