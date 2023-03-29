#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516115 "Material Received Note"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Material Received Note.rdlc';

    dataset
    {
        dataitem("Purch. Rcpt. Line";"Purch. Rcpt. Line")
        {
            RequestFilterFields = "No.","Document No.";
            column(ReportForNavId_1; 1)
            {
            }
            column(No;"Purch. Rcpt. Line"."No.")
            {
            }
            column(Desc;"Purch. Rcpt. Line".Description)
            {
            }
            column(Supplier;"Purch. Rcpt. Line"."Buy-from Vendor No.")
            {
            }
            column(Quantity;"Purch. Rcpt. Line".Quantity)
            {
            }
            column(UOM;"Purch. Rcpt. Line"."Unit of Measure")
            {
            }
            column(Unit_Price;"Purch. Rcpt. Line"."Unit Cost (LCY)")
            {
            }
            column(Total;"Purch. Rcpt. Line"."VAT Base Amount")
            {
            }
            column(Pic;iNFO.Picture)
            {
            }
            column(VAT_Amount;AmtVat)
            {
            }
            column(TodayFormatted;Format(Today,0,4))
            {
            }
            column(VAT;VAT)
            {
            }
            column(TAmt;TAmt)
            {
            }
            column(OrdNo;OrdNo)
            {
            }
            column(DocNo;DocNo)
            {
            }
            column(userid;UserId)
            {
            }

            trigger OnAfterGetRecord()
            begin
                DocNo:="Purch. Rcpt. Line"."Document No.";
                OrdNo:="Purch. Rcpt. Line"."Order No.";



                if "Purch. Rcpt. Line".Quantity=0 then CurrReport.Skip;
                Clear(AmtVat);
                Clear(  VAT);
                Clear( TAmt);
                PurchLine.Reset;
                 PurchLine.SetRange(PurchLine."Document No.","Purch. Rcpt. Line"."Document No.");
                  PurchLine.SetRange(PurchLine."Line No.","Purch. Rcpt. Line"."Line No.");
                  if PurchLine.Find ('-')  then
                  begin
                  TAmt:=PurchLine.Quantity*"Purch. Rcpt. Line"."Unit Cost (LCY)";
                  AmtVat:=((PurchLine."VAT %"/100)*TAmt )+TAmt;

                  VAT:=  AmtVat-TAmt;
                  end;
            end;

            trigger OnPreDataItem()
            begin
                 if iNFO.Get then  iNFO.CalcFields(iNFO.Picture);
                // CLEAR(AmtVat)
                Clear(DocNo);
                Clear(OrdNo);
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
        iNFO: Record "Company Information";
        PurchLine: Record "Purch. Rcpt. Line";
        AmtVat: Decimal;
        VAT: Decimal;
        TAmt: Decimal;
        OrdNo: Code[20];
        DocNo: Code[20];
}

