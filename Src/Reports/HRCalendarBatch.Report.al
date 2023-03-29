#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516181 "HR Calendar Batch"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/HR Calendar Batch.rdlc';
    ProcessingOnly = false;

    dataset
    {
        dataitem("HR Calendar List";"HR Calendar List")
        {
            RequestFilterFields = "Code","Non Working";
            column(ReportForNavId_2215; 2215)
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
            column(HR_Calendar_List_Day;Day)
            {
            }
            column(HR_Calendar_List_Date;Date)
            {
            }
            column(HR_Calendar_List__Non_Working_;"Non Working")
            {
            }
            column(HR_Calendar_List_Reason;Reason)
            {
            }
            column(HR_Calendar_ListCaption;HR_Calendar_ListCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption;CurrReport_PAGENOCaptionLbl)
            {
            }
            column(HR_Calendar_List_DayCaption;FieldCaption(Day))
            {
            }
            column(HR_Calendar_List_DateCaption;FieldCaption(Date))
            {
            }
            column(HR_Calendar_List__Non_Working_Caption;FieldCaption("Non Working"))
            {
            }
            column(HR_Calendar_List_ReasonCaption;FieldCaption(Reason))
            {
            }
            column(HR_Calendar_List_Code;Code)
            {
            }

            trigger OnAfterGetRecord()
            begin
                                 HRCalendar.SetRange(HRCalendar.Current,true);
                                 if HRCalendar.Find('-') then

                                 Code:=HRCalendar.Year;
                                 Modify;
                                 Holidays.FindFirst;
                                 repeat

                                      if Day=Holidays."Non Working Days" then
                                      "Non Working":=true;
                                      Modify;

                                      if Date=Holidays."Non Working Dates" then
                                      "Non Working":=true;
                                      Modify;

                                 until Holidays.Next=0;
            end;

            trigger OnPostDataItem()
            begin
                                     Message('Calendar has been updated Successfully');
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
        Holidays: Record "HR Non Working Days & Dates";
        HRCalendar: Record "HR Calendar";
        CurrentDate: Date;
        HR_Calendar_ListCaptionLbl: label 'HR Calendar List';
        CurrReport_PAGENOCaptionLbl: label 'Page';
}

