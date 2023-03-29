#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 51516002 "Import Checkoff Block"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("ReceiptsProcessing_L-Checkoff";"Checkoff Processing Lin(Block)")
            {
                XmlName = 'Checkoff';
                fieldelement(Header_No;"ReceiptsProcessing_L-Checkoff"."Receipt Header No")
                {
                }
                fieldelement(Entry_No;"ReceiptsProcessing_L-Checkoff"."Receipt Line No")
                {
                }
                fieldelement(Member_No;"ReceiptsProcessing_L-Checkoff"."Member No")
                {
                }
                fieldelement(Amount;"ReceiptsProcessing_L-Checkoff".Amount)
                {
                }
            }
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
}

