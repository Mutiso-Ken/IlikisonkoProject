#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 51516055 "Loan Purpose"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Main Sector";"Main Sector")
            {
                XmlName = 'table';
                fieldelement(A;"Main Sector".Code)
                {
                }
                fieldelement(B;"Main Sector".Description)
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

