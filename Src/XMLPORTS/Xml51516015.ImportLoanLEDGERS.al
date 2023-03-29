#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 51516015 "Import Loan LEDGERS"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Member Ledger Entry";"Member Ledger Entry")
            {
                XmlName = 'Paybill';
                fieldelement(A;"Member Ledger Entry"."Entry No.")
                {
                }
                fieldelement(B;"Member Ledger Entry"."Customer No.")
                {
                }
                fieldelement(C;"Member Ledger Entry"."Posting Date")
                {
                }
                fieldelement(D;"Member Ledger Entry"."Document No.")
                {
                }
                fieldelement(E;"Member Ledger Entry".Amount)
                {
                }
                fieldelement(EE;"Member Ledger Entry"."Customer Posting Group")
                {
                }
                fieldelement(F;"Member Ledger Entry"."Global Dimension 1 Code")
                {
                }
                fieldelement(FF;"Member Ledger Entry"."Global Dimension 2 Code")
                {
                }
                fieldelement(G;"Member Ledger Entry"."User ID")
                {
                }
                fieldelement(GG;"Member Ledger Entry"."Journal Batch Name")
                {
                }
                fieldelement(H;"Member Ledger Entry"."Bal. Account Type")
                {
                }
                fieldelement(HH;"Member Ledger Entry"."Bal. Account No.")
                {
                }
                fieldelement(I;"Member Ledger Entry"."Transaction Type")
                {
                }
                fieldelement(II;"Member Ledger Entry"."Loan No")
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

