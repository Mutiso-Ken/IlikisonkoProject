#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516177 "HR Jobs Factbox"
{
    PageType = ListPart;
    SourceTable = "HR Jobss";

    layout
    {
        area(content)
        {
            field("Job ID";"Job ID")
            {
                ApplicationArea = Basic;
            }
            field("Job Description";"Job Description")
            {
                ApplicationArea = Basic;
            }
            field("No of Posts";"No of Posts")
            {
                ApplicationArea = Basic;
            }
            field("Position Reporting to";"Position Reporting to")
            {
                ApplicationArea = Basic;
            }
            field("Occupied Positions";"Occupied Positions")
            {
                ApplicationArea = Basic;
            }
            field("Vacant Positions";"Vacant Positions")
            {
                ApplicationArea = Basic;
            }
            field(Category;Category)
            {
                ApplicationArea = Basic;
            }
            field(Grade;Grade)
            {
                ApplicationArea = Basic;
            }
            field("Employee Requisitions";"Employee Requisitions")
            {
                ApplicationArea = Basic;
            }
            field("Supervisor Name";"Supervisor Name")
            {
                ApplicationArea = Basic;
            }
            field(Status;Status)
            {
                ApplicationArea = Basic;
            }
            field("Responsibility Center";"Responsibility Center")
            {
                ApplicationArea = Basic;
            }
            field("Date Created";"Date Created")
            {
                ApplicationArea = Basic;
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
                         Validate("Vacant Positions");
    end;
}

