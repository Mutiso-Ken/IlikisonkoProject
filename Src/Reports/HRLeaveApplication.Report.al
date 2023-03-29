#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516610 "HR Leave Application"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/HR Leave Application.rdlc';

    dataset
    {
        dataitem("HR Leave Application";"HR Leave Application")
        {
            CalcFields = "Outstanding Leave Balance";
            RequestFilterFields = "Application Code";
            RequestFilterHeading = 'Document Number';
            column(ReportForNavId_1000000000; 1000000000)
            {
            }
            column(CI_Picture;CI.Picture)
            {
            }
            column(CI_Address;CI.Address)
            {
            }
            column(CI__Address_2______CI__Post_Code_;CI."Address 2"+' '+CI."Post Code")
            {
            }
            column(CI_City;CI.City)
            {
            }
            column(CI_PhoneNo;CI."Phone No.")
            {
            }
            column(COMPANYNAME;COMPANYNAME)
            {
            }
            column(EmployeeNo_HRLeaveApplication;"Employee No")
            {
                IncludeCaption = true;
            }
            column(Empname;EmpName)
            {
            }
            column(DaysApplied_HRLeaveApplication;"Days Applied")
            {
                IncludeCaption = true;
            }
            column(ApplicationCode_HRLeaveApplication;"Application Code")
            {
                IncludeCaption = true;
            }
            column(RequestLeaveAllowance_HRLeaveApplication;"Request Leave Allowance")
            {
                IncludeCaption = true;
            }
            column(LeaveAllowanceAmount_HRLeaveApplication;"Leave Allowance Amount")
            {
                IncludeCaption = true;
            }
            column(NumberofPreviousAttempts_HRLeaveApplication;"Number of Previous Attempts")
            {
                IncludeCaption = true;
            }
            column(DetailsofExamination_HRLeaveApplication;"Details of Examination")
            {
                IncludeCaption = true;
            }
            column(DateofExam_HRLeavseApplication;"Date of Exam")
            {
                IncludeCaption = true;
            }
            column(Reliever_HRLeaveApplication;Reliever)
            {
                IncludeCaption = true;
            }
            column(RelieverName_HRLeaveApplication;"Reliever Name")
            {
                IncludeCaption = true;
            }
            column(StartDate_HRLeaveApplication;"Start Date")
            {
                IncludeCaption = true;
            }
            column(ReturnDate_HRLeaveApplication;"Return Date")
            {
                IncludeCaption = true;
            }
            column(LeaveType_HRLeaveApplication;"Leave Type")
            {
                IncludeCaption = true;
            }
            column(JobTittle_HRLeaveApplication;"Job Tittle")
            {
                IncludeCaption = true;
            }
            column(ApplicationDate_HRLeaveApplication;"Application Date")
            {
                IncludeCaption = true;
            }
            column(EmailAddress_HRLeaveApplication;"E-mail Address")
            {
                IncludeCaption = true;
            }
            column(CellPhoneNumber_HRLeaveApplication;"Cell Phone Number")
            {
                IncludeCaption = true;
            }
            column(Approveddays_HRLeaveApplication;"Approved days")
            {
            }
            column(dLeftBeforeLeave;dLeftBeforeLeave)
            {
            }
            column(dleft;dLeft)
            {
            }
            dataitem("Approval Comment Line";"Approval Comment Line")
            {
                DataItemLink = "Document No."=field("Application Code");
                DataItemTableView = sorting("Entry No.") order(ascending);
                column(ReportForNavId_1000000007; 1000000007)
                {
                }
            }
            dataitem("Approval Entry";"Approval Entry")
            {
                DataItemLink = "Document No."=field("Application Code");
                DataItemTableView = sorting("Table ID","Document Type","Document No.","Sequence No.") order(ascending);
                column(ReportForNavId_1000000008; 1000000008)
                {
                }
                dataitem("User Setup";"User Setup")
                {
                    DataItemLink = "User ID"=field("Approver ID");
                    DataItemTableView = sorting("User ID") order(ascending);
                    column(ReportForNavId_1000000009; 1000000009)
                    {
                    }
                    column(ApproverID_UserSetup;"User Setup"."Approver ID")
                    {
                    }
                    column(UserID_UserSetup;"User Setup"."User ID")
                    {
                    }
                }
            }

            trigger OnAfterGetRecord()
            begin
                HREmp.Reset;
                HREmp.SetRange(HREmp."No.","HR Leave Application"."Employee No");
                if HREmp.Find('-') then begin
                EmpName:=HREmp."First Name"+' '+HREmp."Middle Name"+' '+HREmp."Last Name";
                  end;
                HRLeaveApp.Reset;
                HRLeaveApp.SetRange(HRLeaveApp."Application Code","Application Code");
                HRLeaveApp.SetFilter("Date Filter",Format(20180101D)+'..'+Format(CalcDate('-1D',"HR Leave Application"."Start Date")));
                if HRLeaveApp.Find('-') then
                  begin
                    HRLeaveApp.CalcFields("Outstanding Leave Balance");
                    dLeftBeforeLeave:=HRLeaveApp."Outstanding Leave Balance";
                  end;

                HRLeaveApp.Reset;
                HRLeaveApp.SetRange(HRLeaveApp."Application Code","Application Code");
                HRLeaveApp.SetFilter("Date Filter",Format(20180101D)+'..'+Format("HR Leave Application"."Start Date"));
                if HRLeaveApp.Find('-') then
                  begin
                    HRLeaveApp.CalcFields("Outstanding Leave Balance");
                    dLeft:=HRLeaveApp."Outstanding Leave Balance";
                  end
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
        CI.Get;
        CI.CalcFields(CI.Picture);
    end;

    var
        CI: Record "Company Information";
        EmpName: Text;
        HREmp: Record "HR Employees";
        HRLeaveApp: Record "HR Leave Application";
        dLeft: Decimal;
        dLeftBeforeLeave: Decimal;
}

