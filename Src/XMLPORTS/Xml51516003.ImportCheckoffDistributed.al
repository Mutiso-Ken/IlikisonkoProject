#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
XmlPort 51516003 "Import Checkoff Distributed"
{
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement("Checkoff Lines-Distributed";"Checkoff Lines-Distributed")
            {
                AutoReplace = false;
                XmlName = 'Paybill';
                fieldelement(Receipt_Header;"Checkoff Lines-Distributed"."Receipt Header No")
                {
                }
                fieldelement(Entry_No;"Checkoff Lines-Distributed"."Entry No")
                {
                }
                fieldelement(Payroll_Number;"Checkoff Lines-Distributed"."Staff/Payroll No")
                {
                }
                fieldelement(Member_Name;"Checkoff Lines-Distributed"."Member Name")
                {
                }
                fieldelement(Total_Amount;"Checkoff Lines-Distributed".Amount)
                {
                }
                fieldelement(Deposit_contribution;"Checkoff Lines-Distributed"."Deposit contribution")
                {
                }
                fieldelement(Share_capital;"Checkoff Lines-Distributed"."Share Capital")
                {
                }
                fieldelement(By_Laws;"Checkoff Lines-Distributed"."By Laws")
                {
                }
                fieldelement(Insurance;"Checkoff Lines-Distributed"."Insurance Contribution")
                {
                }
                fieldelement(Entrance_Fee;"Checkoff Lines-Distributed"."Entrance Fees")
                {
                }
                fieldelement(Stocks;"Checkoff Lines-Distributed".Stocks)
                {
                }
                fieldelement(Demand;"Checkoff Lines-Distributed".Demand)
                {
                }
                fieldelement(N_Loan;"Checkoff Lines-Distributed"."Normal Loan")
                {
                }
                fieldelement(Int_NLoan;"Checkoff Lines-Distributed"."Int normal loan")
                {
                }
                fieldelement(E_Loan;"Checkoff Lines-Distributed"."Emergency Loan")
                {
                }
                fieldelement(Int_ELoan;"Checkoff Lines-Distributed"."Int Emergency Loan")
                {
                }
                fieldelement(S_Loan;"Checkoff Lines-Distributed"."School Fees Loan")
                {
                }
                fieldelement(Int_SLoan;"Checkoff Lines-Distributed"."Int SFees Loan")
                {
                }
                fieldelement(P_Loan;"Checkoff Lines-Distributed"."Premium Loan")
                {
                }
                fieldelement(Int_Ploan;"Checkoff Lines-Distributed"."Int Premium Loan")
                {
                }
                fieldelement(H_Loan;"Checkoff Lines-Distributed"."House Loan")
                {
                }
                fieldelement(Int_HLoan;"Checkoff Lines-Distributed"."Int House Loan")
                {
                }
                fieldelement(I_Loan;"Checkoff Lines-Distributed"."Instant Loan")
                {
                }
                fieldelement(Int_ILoan;"Checkoff Lines-Distributed"."Int Instant Loan")
                {
                }
                fieldelement(SS_Loan;"Checkoff Lines-Distributed"."SS Loan")
                {
                }
                fieldelement(Int_SSLoan;"Checkoff Lines-Distributed"."Int SS Loan")
                {
                }
                fieldelement(SA_Loan;"Checkoff Lines-Distributed".SALoan)
                {
                }
                fieldelement(Int_SA_Loan;"Checkoff Lines-Distributed"."Int SA Loan")
                {
                }
                fieldelement(HA_Loan;"Checkoff Lines-Distributed"."H/A Loan")
                {
                }
                fieldelement(Int_HALoan;"Checkoff Lines-Distributed"."Int H/A Loan")
                {
                }
                fieldelement(RF_Loan;"Checkoff Lines-Distributed"."Refinance Loan")
                {
                }
                fieldelement(Int_RFLoan;"Checkoff Lines-Distributed"."Int Refinance Loan")
                {
                }
                fieldelement(Guar_Loan;"Checkoff Lines-Distributed"."Guarantor Loan")
                {
                }
                fieldelement(Int_GuarLoan;"Checkoff Lines-Distributed"."Int Guarantor Loan")
                {
                }
                fieldelement(BB_Loan;"Checkoff Lines-Distributed"."BB Loan")
                {
                }
                fieldelement(Int_BBLoan;"Checkoff Lines-Distributed"."Int BB Loan")
                {
                }
                fieldelement(NSE_Loan;"Checkoff Lines-Distributed"."Nse Loan")
                {
                }
                fieldelement(Int_NSELoan;"Checkoff Lines-Distributed"."Int Nse Loan")
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

    trigger OnInitXmlPort()
    begin
        //RequestOptionsPage.
    end;

    trigger OnPreXmlPort()
    var
        BufferTable: Record "Checkoff Code Buffer";
    begin
        /*NewStr:= DELCHR(currXMLport.FILENAME,'=','\');
        IF STRLEN(NewStr)>7 THEN BEGIN
          strEmployerCode:=COPYSTR(NewStr,STRLEN(NewStr) - 6,7);
        
          BufferTable.SETRANGE(BufferTable.UserId,USERID);
          IF BufferTable.FIND('-') THEN BEGIN
            IF strEmployerCode='ted.txt' THEN
            strEmployerCode:=BufferTable.EmployerCode+'.csv';
            IF strEmployerCode<>BufferTable.EmployerCode+'.csv' THEN
            ERROR('csv File Name should be the same as the employer code, kindly rename file to '+BufferTable.EmployerCode+'.csv');
          END;
        END ELSE
        ERROR('Document Name is invalid');*/

    end;

    var
        NewStr: Text[220];
        strEmployerCode: Text[20];
}

