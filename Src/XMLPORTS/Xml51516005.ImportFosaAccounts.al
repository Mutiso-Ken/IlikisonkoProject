#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 51516005 "Import Fosa Accounts"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("FOSA Accounts Import Buffer";"FOSA Accounts Import Buffer")
            {
                AutoReplace = true;
                XmlName = 'Paybill';
                fieldelement(A;"FOSA Accounts Import Buffer"."FOSA Account No")
                {
                }
                fieldelement(B;"FOSA Accounts Import Buffer"."Member No")
                {
                }
                fieldelement(c;"FOSA Accounts Import Buffer".Name)
                {
                }
                fieldelement(D;"FOSA Accounts Import Buffer"."Account Type")
                {
                }
                fieldelement(E;"FOSA Accounts Import Buffer".Status)
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

