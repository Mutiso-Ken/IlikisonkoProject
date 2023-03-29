#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 51516004 "Import Checkoff Lines(Block)"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Checkoff Processing Lin(Block)";"Checkoff Processing Lin(Block)")
            {
                XmlName = 'Paybill';
                fieldelement(CHECKOFF_NO;"Checkoff Processing Lin(Block)"."Receipt Header No")
                {
                }
                fieldelement(PAYROLL_NO;"Checkoff Processing Lin(Block)"."Staff/Payroll No")
                {
                }
                fieldelement(AMOUNT;"Checkoff Processing Lin(Block)".Amount)
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

