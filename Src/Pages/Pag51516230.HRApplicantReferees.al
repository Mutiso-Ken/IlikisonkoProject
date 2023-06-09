#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516230 "HR Applicant Referees"
{
    PageType = List;
    SourceTable = "HR Applicant Referees";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(Names;Names)
                {
                    ApplicationArea = Basic;
                }
                field(Designation;Designation)
                {
                    ApplicationArea = Basic;
                }
                field(Institution;Institution)
                {
                    ApplicationArea = Basic;
                }
                field(Address;Address)
                {
                    ApplicationArea = Basic;
                }
                field("Telephone No";"Telephone No")
                {
                    ApplicationArea = Basic;
                }
                field("E-Mail";"E-Mail")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

