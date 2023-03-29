#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516575 "Mobile PIN Reset"
{
    PageType = List;
    SourceTable = "CloudPESA Applications";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Account No";"Account No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                }
                field("Account Name";"Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Telephone;Telephone)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(SentToServer;SentToServer)
                {
                    ApplicationArea = Basic;
                    Caption = 'Reset PIN';
                    Editable = true;
                }
            }
        }
    }

    actions
    {
    }
}

