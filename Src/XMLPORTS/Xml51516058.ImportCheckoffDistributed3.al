#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 51516058 "Import Checkoff Distributed3"
{
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement(Integer;Integer)
            {
                AutoReplace = false;
                AutoSave = false;
                XmlName = 'CheckoffHeader';
                SourceTableView = sorting(Number) where(Number=const(1));
                textelement(Receipt_HeaderTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        Receipt_HeaderTitle := "Checkoff Lines-Distributed2".FieldCaption("Receipt Header No");
                    end;
                }
                textelement(Entry_NoTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        Member_NoTitle:= "Checkoff Lines-Distributed2".FieldCaption("Entry No");
                    end;
                }
                textelement(Member_NoTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        Entry_NoTitle := "Checkoff Lines-Distributed2".FieldCaption("Member No.");
                    end;
                }
                textelement(Total_AmountTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        Total_AmountTitle := "Checkoff Lines-Distributed2".FieldCaption("Total Amount");
                    end;
                }
                textelement(Share_capitalTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        Share_capitalTitle := "Checkoff Lines-Distributed2".FieldCaption("Share Capital");
                    end;
                }
                textelement(Entrance_FeeTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        Entrance_FeeTitle := "Checkoff Lines-Distributed2".FieldCaption("Entrance Fees");
                    end;
                }
                textelement(Deposit_contributionTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        Deposit_contributionTitle := "Checkoff Lines-Distributed2".FieldCaption("Deposit contribution");
                    end;
                }
                textelement(Kanisa_SavingsTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        Kanisa_SavingsTitle := "Checkoff Lines-Distributed2".FieldCaption("Jiokoe Savings");
                    end;
                }
                textelement(Principal_LoanTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        Principal_LoanTitle := "Checkoff Lines-Distributed2".FieldCaption("Principal Loan");
                    end;
                }
                textelement(Principal_Loan_InsuranceTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        Principal_Loan_InsuranceTitle := "Checkoff Lines-Distributed2".FieldCaption("Principal Insurance");
                    end;
                }
                textelement(Emergency_Loan_1Title)
                {

                    trigger OnBeforePassVariable()
                    begin
                        Emergency_Loan_1Title := "Checkoff Lines-Distributed2".FieldCaption("Emergency 1 Loan");
                    end;
                }
                textelement(Emergency_Loan_1_InsuranceTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        Emergency_Loan_1_InsuranceTitle := "Checkoff Lines-Distributed2".FieldCaption("Emergency 1 Insurance");
                    end;
                }
                textelement(Emergency_Loan_2Title)
                {

                    trigger OnBeforePassVariable()
                    begin
                        Emergency_Loan_2Title := "Checkoff Lines-Distributed2".FieldCaption("Emergency 2 Loan");
                    end;
                }
                textelement(Emergency_Loan_2_InsuranceTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        Emergency_Loan_2_InsuranceTitle:= "Checkoff Lines-Distributed2".FieldCaption("Emergency 2 Insurance");
                    end;
                }
                textelement(Vision_LoanTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        Vision_LoanTitle := "Checkoff Lines-Distributed2".FieldCaption("Vision Loan");
                    end;
                }
                textelement(Vision_Loan_InsuranceTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        Vision_Loan_InsuranceTitle := "Checkoff Lines-Distributed2".FieldCaption("Vision Loan Insurance");
                    end;
                }
                textelement(Mjengo_LoanTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        Mjengo_LoanTitle := "Checkoff Lines-Distributed2".FieldCaption("Mjengo Loan");
                    end;
                }
                textelement(Mjengo_Loan_InsuranceTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        Mjengo_Loan_InsuranceTitle := "Checkoff Lines-Distributed2".FieldCaption("Mjengo Loan Insurance");
                    end;
                }
                textelement(Elimu_LoanTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        Elimu_LoanTitle := "Checkoff Lines-Distributed2".FieldCaption("Elimu Loan");
                    end;
                }
                textelement(Elimu_Loan_InsuranceTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        Elimu_Loan_InsuranceTitle := "Checkoff Lines-Distributed2".FieldCaption("Elimu Loan Insurance");
                    end;
                }
                textelement(KHL_LoanTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        KHL_LoanTitle := "Checkoff Lines-Distributed2".FieldCaption("KHL Loan");
                    end;
                }
                textelement(KHL_Loan_InsuranceTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        KHL_Loan_InsuranceTitle := "Checkoff Lines-Distributed2".FieldCaption("KHL Loan Insurance");
                    end;
                }
                textelement(Mali_Mali_LoanTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        Mali_Mali_LoanTitle := "Checkoff Lines-Distributed2".FieldCaption("Mali Mali Loan");
                    end;
                }
                textelement(Mali_Mali_Loan_InsuranceTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        Mali_Mali_Loan_InsuranceTitle := 'Mali Mali Insurance';
                    end;
                }
                textelement(Car_LoanTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        Car_LoanTitle := "Checkoff Lines-Distributed2".FieldCaption("Car Loan");
                    end;
                }
                textelement(Car_Loan_InsuranceTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        Car_Loan_InsuranceTitle := "Checkoff Lines-Distributed2".FieldCaption("Car Loan Insurance");
                    end;
                }
                textelement(Instant_LoanTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        Instant_LoanTitle := "Checkoff Lines-Distributed2".FieldCaption("Instant Loan");
                    end;
                }
                textelement(Instant_Loan_2Title)
                {

                    trigger OnBeforePassVariable()
                    begin
                        Instant_Loan_2Title := "Checkoff Lines-Distributed2".FieldCaption("Instant2 Loan");
                    end;
                }
                textelement(Sukuma_Mwezi_LoanTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        Sukuma_Mwezi_LoanTitle:= "Checkoff Lines-Distributed2".FieldCaption("Sukuma Mwezi Loan");
                    end;
                }
                textelement(Karibu_LoanTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        Karibu_LoanTitle := "Checkoff Lines-Distributed2".FieldCaption("Karibu Loan");
                    end;
                }
                textelement(Motor_Vehicle_InsuranceTitle)
                {

                    trigger OnBeforePassVariable()
                    begin
                        Motor_Vehicle_InsuranceTitle := "Checkoff Lines-Distributed2".FieldCaption("Motor Vehicle Insurance");
                    end;
                }
            }
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

