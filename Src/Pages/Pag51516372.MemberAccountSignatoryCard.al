#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516372 "Member Account Signatory Card"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Member Account Signatories";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Account No";"Account No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Names;Names)
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Date Of Birth";"Date Of Birth")
                {
                    ApplicationArea = Basic;
                }
                field("Staff/Payroll";"Staff/Payroll")
                {
                    ApplicationArea = Basic;
                }
                field("ID No.";"ID No.")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field(Designation;Designation)
                {
                    ApplicationArea = Basic;
                }
                field(Signatory;Signatory)
                {
                    ApplicationArea = Basic;
                }
                field("Must Sign";"Must Sign")
                {
                    ApplicationArea = Basic;
                }
                field("Must be Present";"Must be Present")
                {
                    ApplicationArea = Basic;
                }
                field(Picture;Picture)
                {
                    ApplicationArea = Basic;
                }
                field(Signature;Signature)
                {
                    ApplicationArea = Basic;
                }
                field("Expiry Date";"Expiry Date")
                {
                    ApplicationArea = Basic;
                }
                field("BOSA No.";"BOSA No.")
                {
                    ApplicationArea = Basic;
                }
                field("Email Address";"Email Address")
                {
                    ApplicationArea = Basic;
                }
            }
        }
        area(factboxes)
        {
            part(Control2;"Signatory Picture")
            {
                SubPageLink = "Account No"=field("Account No"),
                              Names=field(Names);
            }
            part(Control1;"Signatory Signature")
            {
                SubPageLink = "Account No"=field("Account No"),
                              Names=field(Names);
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
          //CurrPage.EDITABLE:=FALSE;
    end;
}

