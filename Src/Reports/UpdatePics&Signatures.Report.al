#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50019 "Update Pics & Signatures"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Update Pics & Signatures.rdlc';

    dataset
    {
        dataitem("Member Register";"Member Register")
        {
            RequestFilterFields = "No.";
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Vend.Reset;
                Vend.SetRange(Vend."BOSA Account No","Member Register"."No.");
                if Vend.Find('-') then begin
                  if "Member Register".Picture.Count>0 then
                    Vend.Picture:="Member Register".Picture;
                  if "Member Register".Signature.Count>0 then
                    Vend.Signature:="Member Register".Signature;
                  Vend.Modify;

                  if (Vend.Picture.Count>0) and ("Member Register".Picture.Count<=0) then
                  "Member Register".Picture:=Vend.Picture;
                  if (Vend.Signature.Count>0) and ("Member Register".Signature.Count<=0) then
                  "Member Register".Signature:=Vend.Signature;
                  "Member Register".Modify;
                end;
            end;

            trigger OnPostDataItem()
            begin
                Message('Update Complete');
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
        Vend: Record Vendor;
}

