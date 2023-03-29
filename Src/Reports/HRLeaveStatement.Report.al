#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516182 "HR Leave Statement"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/HR Leave Statement.rdlc';

    dataset
    {
        dataitem("HR Employees";"HR Employees")
        {
            RequestFilterFields = "No.",Field2038;
            column(ReportForNavId_6075; 6075)
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
            column(USERID;"Employee UserID")
            {
            }
            column(CI_Picture;CI.Picture)
            {
            }
            column(CI_City;CI.City)
            {
            }
            column(CI__Address_2______CI__Post_Code_;CI."Address 2"+' '+CI."Post Code")
            {
            }
            column(CI_Address;CI.Address)
            {
            }
            column(HR_Employees__No__;"No.")
            {
            }
            column(HR_Employees__FullName;"First Name"+' '+"Middle Name")
            {
            }
            column(HR_Employees__HR_Employees___Leave_Balance_;"Leave Balance")
            {
            }
            column(EmployeeCaption;EmployeeCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption;CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Employee_Leave_StatementCaption;Employee_Leave_StatementCaptionLbl)
            {
            }
            column(P_O__BoxCaption;P_O__BoxCaptionLbl)
            {
            }
            column(HR_Employees__No__Caption;FieldCaption("No."))
            {
            }
            column(NameCaption;NameCaptionLbl)
            {
            }
            column(Leave_BalanceCaption;Leave_BalanceCaptionLbl)
            {
            }
            column(Day_s_Caption;Day_s_CaptionLbl)
            {
            }
            column(No;No)
            {
            }
            dataitem("HR Leave Ledger Entries";"HR Leave Ledger Entries")
            {
                DataItemLink = "Staff No."=field("No.");
                DataItemTableView = sorting("Entry No.");
                column(ReportForNavId_4961; 4961)
                {
                }
                column(HR_Leave_Ledger_Entries__Leave_Period_;"Leave Period")
                {
                }
                column(HR_Leave_Ledger_Entries__Leave_Entry_Type_;"Leave Entry Type")
                {
                }
                column(HR_Leave_Ledger_Entries__Leave_Type_;"Leave Type")
                {
                }
                column(HR_Leave_Ledger_Entries__No__of_days_;"No. of days")
                {
                }
                column(HR_Leave_Ledger_Entries__Leave_Posting_Description_;"Leave Posting Description")
                {
                }
                column(HR_Leave_Ledger_Entries__Posting_Date_;"Posting Date")
                {
                }
                column(HR_Leave_Ledger_Entries__Leave_Entry_Type_Caption;FieldCaption("Leave Entry Type"))
                {
                }
                column(HR_Leave_Ledger_Entries__Leave_Type_Caption;FieldCaption("Leave Type"))
                {
                }
                column(HR_Leave_Ledger_Entries__No__of_days_Caption;FieldCaption("No. of days"))
                {
                }
                column(HR_Leave_Ledger_Entries__Leave_Posting_Description_Caption;FieldCaption("Leave Posting Description"))
                {
                }
                column(HR_Leave_Ledger_Entries__Posting_Date_Caption;FieldCaption("Posting Date"))
                {
                }
                column(HR_Leave_Ledger_Entries__Leave_Period_Caption;FieldCaption("Leave Period"))
                {
                }
                column(HR_Leave_Ledger_Entries_Entry_No_;"Entry No.")
                {
                }
                column(HR_Leave_Ledger_Entries_Staff_No_;"Staff No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    No:=No+1;
                end;

                trigger OnPreDataItem()
                begin
                    //"HR Leave Ledger Entries".SETFILTER("HR Leave Ledger Entries"."Leave Type",
                    //"HR-Employee".GETFILTER("HR-Employee"."Leave Type Filter"));
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //"HR Employees".VALIDATE("HR Employees"."Allocated Leave Days");
                //LeaveBalance:="HR Employees"."Leave Balance";
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
                          CI.Get();
                          CI.CalcFields(CI.Picture);
    end;

    var
        CI: Record "Company Information";
        LeaveBalance: Decimal;
        EmployeeCaptionLbl: label 'Employee';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        Employee_Leave_StatementCaptionLbl: label 'Employee Leave Statement';
        P_O__BoxCaptionLbl: label 'P.O. Box';
        NameCaptionLbl: label 'Name';
        Leave_BalanceCaptionLbl: label 'Leave Balance';
        Day_s_CaptionLbl: label 'Day(s)';
        No: Decimal;
}

