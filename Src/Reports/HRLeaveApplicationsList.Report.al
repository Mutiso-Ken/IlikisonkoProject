#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516187 "HR Leave Applications List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/HR Leave Applications List.rdlc';

    dataset
    {
        dataitem("HR Leave Application";"HR Leave Application")
        {
            RequestFilterFields = "Application Code";
            column(ReportForNavId_3725; 3725)
            {
            }
            column(FORMAT_TODAY_0_4_;Format(Today,0,4))
            {
            }
            column(COMPANYNAME;COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO;CurrReport.PageNo)
            {
            }
            column(USERID;UserId)
            {
            }
            column(HR_Leave_Application__Application_Code_;"Application Code")
            {
            }
            column(HR_Leave_Application__Application_Date_;"Application Date")
            {
            }
            column(HR_Leave_Application__Employee_No_;"Employee No")
            {
            }
            column(HR_Leave_Application__Job_Tittle_;"Job Tittle")
            {
            }
            column(HR_Leave_Application_Supervisor;Supervisor)
            {
            }
            column(HR_Leave_Application__Leave_Type_;"Leave Type")
            {
            }
            column(HR_Leave_Application__Days_Applied_;"Days Applied")
            {
            }
            column(HR_Leave_Application__Start_Date_;"Start Date")
            {
            }
            column(HR_Leave_Application__Return_Date_;"Return Date")
            {
            }
            column(HR_Leave_Application_Reliever;Reliever)
            {
            }
            column(HR_Leave_Application__Reliever_Name_;"Reliever Name")
            {
            }
            column(HR_Leave_ApplicationCaption;HR_Leave_ApplicationCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption;CurrReport_PAGENOCaptionLbl)
            {
            }
            column(HR_Leave_Application__Application_Code_Caption;FieldCaption("Application Code"))
            {
            }
            column(HR_Leave_Application__Application_Date_Caption;FieldCaption("Application Date"))
            {
            }
            column(HR_Leave_Application__Employee_No_Caption;FieldCaption("Employee No"))
            {
            }
            column(HR_Leave_Application__Job_Tittle_Caption;FieldCaption("Job Tittle"))
            {
            }
            column(HR_Leave_Application_SupervisorCaption;FieldCaption(Supervisor))
            {
            }
            column(HR_Leave_Application__Leave_Type_Caption;FieldCaption("Leave Type"))
            {
            }
            column(HR_Leave_Application__Days_Applied_Caption;FieldCaption("Days Applied"))
            {
            }
            column(HR_Leave_Application__Start_Date_Caption;FieldCaption("Start Date"))
            {
            }
            column(HR_Leave_Application__Return_Date_Caption;FieldCaption("Return Date"))
            {
            }
            column(HR_Leave_Application_RelieverCaption;FieldCaption(Reliever))
            {
            }
            column(HR_Leave_Application__Reliever_Name_Caption;FieldCaption("Reliever Name"))
            {
            }
            column(Picture;CI.Picture)
            {
            }
            column(TotalTaken_HRLeaveApplication;"HR Leave Application"."Total Taken")
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

    trigger OnPreReport()
    begin
        CI.Reset;
        CI.Get;
        CI.CalcFields(CI.Picture);
    end;

    var
        HR_Leave_ApplicationCaptionLbl: label 'HR Leave Application';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        CI: Record "Company Information";
}

