#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516359 "PM Issue Tracker"
{
    PageType = List;
    SourceTable = "Loans reg";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Module Code";"Module Code")
                {
                    ApplicationArea = Basic;
                }
                field("UAT Level";"UAT Level")
                {
                    ApplicationArea = Basic;
                }
                field("UAT Item";"UAT Item")
                {
                    ApplicationArea = Basic;
                    StyleExpr = CoveragePercentStyle;
                }
                field("USER ID";"USER ID")
                {
                    ApplicationArea = Basic;
                }
                field("Assigned to";"Assigned to")
                {
                    ApplicationArea = Basic;
                }
                field("surestep status";"surestep status")
                {
                    ApplicationArea = Basic;
                }
                field("Date Resolved SS";"Date Resolved SS")
                {
                    ApplicationArea = Basic;
                }
                field("Surestep Comments";"Surestep Comments")
                {
                    ApplicationArea = Basic;
                }
                field("Customer Status";"Customer Status")
                {
                    ApplicationArea = Basic;
                }
                field("User Comments";"User Comments")
                {
                    ApplicationArea = Basic;
                }
                field("Date Raised";"Date Raised")
                {
                    ApplicationArea = Basic;
                }
                field("Date Resolved";"Date Resolved")
                {
                    ApplicationArea = Basic;
                }
                field("Entry No";"Entry No")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        CoveragePercentStyle:='None';
        SetStyles;
    end;

    trigger OnOpenPage()
    begin
        if not((UserId='ERP\ADMINISTRATOR')  or (UserId='JMUTUKU')  or (UserId='TEST')) then
          Error('Access denied');
    end;

    var
        CoveragePercentStyle: Text;

    local procedure SetStyles()
    begin
        CoveragePercentStyle:='None';
        if "Customer Status"="customer status"::WIP then
          CoveragePercentStyle := 'Unfavorable';
        if "Customer Status"="customer status"::Rejected then
            CoveragePercentStyle := 'Unfavorable';
        if "Customer Status"="customer status"::Resolved then
            CoveragePercentStyle := 'favorable';
    end;
}

