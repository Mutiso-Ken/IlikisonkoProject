#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 51516001 "COA/Banks"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("G/L Account";"G/L Account")
            {
                AutoUpdate = true;
                XmlName = 'Paybill';
                fieldelement(b;"G/L Account"."No.")
                {
                }
                fieldelement(a;"G/L Account".Name)
                {
                }
                fieldelement(r;"G/L Account"."Income/Balance")
                {
                }
                fieldelement(t;"G/L Account"."Account Type")
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

