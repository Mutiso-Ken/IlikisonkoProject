#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516186 "HR Training Applications List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/HR Training Applications List.rdlc';

    dataset
    {
        dataitem("HR Training Applications";"HR Training Applications")
        {
            RequestFilterFields = "Application No";
            column(ReportForNavId_6373; 6373)
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
            column(HR_Training_Applications__Application_No_;"Application No")
            {
            }
            column(HR_Training_Applications__Application_Date_;"Application Date")
            {
            }
            column(HR_Training_Applications__Employee_No__;"Employee No.")
            {
            }
            column(HR_Training_Applications__Employee_Name_;"Employee Name")
            {
            }
            column(HR_Training_Applications__Employee_Department_;"Employee Department")
            {
            }
            column(HR_Training_Applications__Course_Title_;"Course Title")
            {
            }
            column(HR_Training_Applications__Purpose_of_Training_;"Purpose of Training")
            {
            }
            column(HR_Training_ApplicationsCaption;HR_Training_ApplicationsCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption;CurrReport_PAGENOCaptionLbl)
            {
            }
            column(P_O__BoxCaption;P_O__BoxCaptionLbl)
            {
            }
            column(Training_Applications_ListCaption;Training_Applications_ListCaptionLbl)
            {
            }
            column(HR_Training_Applications__Application_No_Caption;FieldCaption("Application No"))
            {
            }
            column(HR_Training_Applications__Application_Date_Caption;FieldCaption("Application Date"))
            {
            }
            column(HR_Training_Applications__Employee_No__Caption;FieldCaption("Employee No."))
            {
            }
            column(HR_Training_Applications__Employee_Name_Caption;FieldCaption("Employee Name"))
            {
            }
            column(HR_Training_Applications__Employee_Department_Caption;FieldCaption("Employee Department"))
            {
            }
            column(HR_Training_Applications__Course_Title_Caption;FieldCaption("Course Title"))
            {
            }
            column(HR_Training_Applications__Purpose_of_Training_Caption;FieldCaption("Purpose of Training"))
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
        CI: Record "Company Information";
        HR_Training_ApplicationsCaptionLbl: label 'HR Training Applications';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        P_O__BoxCaptionLbl: label 'P.O. Box';
        Training_Applications_ListCaptionLbl: label 'Training Applications List';
}

