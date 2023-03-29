#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516863 "Block Blocked Accounts Pension"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Block Blocked Accounts Pension.rdlc';

    dataset
    {
        dataitem("Pension Processing Lines";"Pension Processing Lines")
        {
            RequestFilterFields = "Salary Header No.","Account No.";
            column(ReportForNavId_1000000000; 1000000000)
            {
            }

            trigger OnAfterGetRecord()
            begin


                    Vendor.Reset;
                    Vendor.SetRange(Vendor."No.","Account No."); //"Account No."
                    Vendor.SetRange(Vendor."Prevous Blocked Status",Vendor."prevous blocked status"::All);
                      if Vendor.Find('-') then begin
                        Vendor.Blocked:=Vendor."Prevous Blocked Status";
                        Vendor."Prevous Blocked Status":=Vendor."prevous blocked status"::" ";
                        Vendor.Modify;
                      end;
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
        Vendor: Record Vendor;
        Cust: Record "Member Register";
}

