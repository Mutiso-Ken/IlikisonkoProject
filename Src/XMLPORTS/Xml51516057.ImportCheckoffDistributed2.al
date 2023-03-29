#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 51516057 "Import Checkoff Distributed2"
{
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Checkoff Lines-Distributed2";"Checkoff Lines-Distributed2")
            {
                AutoReplace = false;
                XmlName = 'Checkoff';
                fieldelement(Receipt_Header;"Checkoff Lines-Distributed2"."Receipt Header No")
                {
                }
                fieldelement(Entry_No;"Checkoff Lines-Distributed2"."Entry No")
                {
                }
                fieldelement(Member_No;"Checkoff Lines-Distributed2"."Member No.")
                {
                }
                fieldelement(Total_Amount;"Checkoff Lines-Distributed2".Amount)
                {
                }
                fieldelement(Share_capital;"Checkoff Lines-Distributed2"."Share Capital")
                {
                }
                fieldelement(Entrance_Fee;"Checkoff Lines-Distributed2"."Entrance Fees")
                {
                }
                fieldelement(Deposit_contribution;"Checkoff Lines-Distributed2"."Deposit contribution")
                {
                }
                fieldelement(Jiokoe_Savings;"Checkoff Lines-Distributed2"."Jiokoe Savings")
                {
                }
                fieldelement(Principal_Loan;"Checkoff Lines-Distributed2"."Principal Loan")
                {
                }
                fieldelement(Principal_Loan_Insurance;"Checkoff Lines-Distributed2"."Principal Insurance")
                {
                }
                fieldelement(Emergency_Loan_1;"Checkoff Lines-Distributed2"."Emergency 1 Loan")
                {
                }
                fieldelement(Emergency_Loan_1_Insurance;"Checkoff Lines-Distributed2"."Emergency 1 Insurance")
                {
                }
                fieldelement(Emergency_Loan_2;"Checkoff Lines-Distributed2"."Emergency 2 Loan")
                {
                }
                fieldelement(Emergency_Loan_2_Insurance;"Checkoff Lines-Distributed2"."Emergency 2 Insurance")
                {
                }
                fieldelement(Vision_Loan;"Checkoff Lines-Distributed2"."Vision Loan")
                {
                }
                fieldelement(Vision_Loan_Insurance;"Checkoff Lines-Distributed2"."Vision Loan Insurance")
                {
                }
                fieldelement(Mjengo_Loan;"Checkoff Lines-Distributed2"."Mjengo Loan")
                {
                }
                fieldelement(Mjengo_Loan_Insurance;"Checkoff Lines-Distributed2"."Mjengo Loan Insurance")
                {
                }
                fieldelement(Elimu_Loan;"Checkoff Lines-Distributed2"."Elimu Loan")
                {
                }
                fieldelement(Elimu_Loan_Insurance;"Checkoff Lines-Distributed2"."Elimu Loan Insurance")
                {
                }
                fieldelement(KHL_Loan;"Checkoff Lines-Distributed2"."KHL Loan")
                {
                }
                fieldelement(KHL_Loan_Insurance;"Checkoff Lines-Distributed2"."KHL Loan Insurance")
                {
                }
                fieldelement(Mali_Mali_Loan;"Checkoff Lines-Distributed2"."Mali Mali Loan")
                {
                }
                fieldelement(Mali_Mali_Loan_Insurance;"Checkoff Lines-Distributed2"."Mali Mali Loan Insurance")
                {
                }
                fieldelement(Car_Loan;"Checkoff Lines-Distributed2"."Car Loan")
                {
                }
                fieldelement(Car_Loan_Insurance;"Checkoff Lines-Distributed2"."Car Loan Insurance")
                {
                }
                fieldelement(Instant_Loan;"Checkoff Lines-Distributed2"."Instant Loan")
                {
                }
                fieldelement(Instant_Loan_2;"Checkoff Lines-Distributed2"."Instant2 Loan")
                {
                }
                fieldelement(Sukuma_Mwezi_Loan;"Checkoff Lines-Distributed2"."Sukuma Mwezi Loan")
                {
                }
                fieldelement(Karibu_Loan;"Checkoff Lines-Distributed2"."Karibu Loan")
                {
                }
                fieldelement(Motor_Vehicle_Insurance;"Checkoff Lines-Distributed2"."Motor Vehicle Insurance")
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

    trigger OnPreXmlPort()
    var
        BufferTable: Record "Checkoff Code Buffer";
    begin
    end;

    var
        NewStr: Text[220];
        strEmployerCode: Text[20];
}

