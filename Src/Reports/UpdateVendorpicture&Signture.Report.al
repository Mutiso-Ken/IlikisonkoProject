#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516524 "Update Vendor picture&Signture"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Update Vendor picture&Signture.rdlc';

    dataset
    {
        dataitem(Vendor;Vendor)
        {
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Cust.Reset;
                Cust.SetRange(Cust."No.",Vendor."BOSA Account No");
                if Cust.Find('-') then begin
                 HasValuePic:=Cust.Picture.MediaId;
                  if IsNullGuid(HasValuePic) then
                    Vendor.Picture:=Cust.Picture;

                 HasValueSig:=Cust.Signature.MediaId;
                  if IsNullGuid(HasValueSig) then
                    Vendor.Signature:=Cust.Signature;
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
        Cust: Record "Member Register";
        HasValuePic: Guid;
        HasValueSig: Guid;
}

