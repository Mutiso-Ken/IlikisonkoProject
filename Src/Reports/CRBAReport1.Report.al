#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516950 "CRBA Report 1"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/CRBA Report 1.rdlc';

    dataset
    {
        dataitem("Loans Register";"Loans Register")
        {
            column(ReportForNavId_1000000000; 1000000000)
            {
            }

            trigger OnAfterGetRecord()
            begin
                                NoDays:=0;
                                           "Loans Register".CalcFields("Loans Register"."Outstanding Balance","Loans Register"."Last Pay Date");
                
                                           if "Loans Register"."Outstanding Balance" >0 then begin
                                           Cust.Reset;
                                           Cust.SetRange(Cust."No.","Loans Register"."Client Code");
                                           if Cust.Find('-') then begin
                
                                           NoLine:=NoLine+1;
                
                                           CRBA.Init;
                                           CRBA.No:=NoLine;
                
                                           TempString:='';
                
                                          // MyString := 'ABC/11-12/001;ABC/11-12/002;ABCDE/11-12/0001';
                                           MyString:=Cust.Name;
                                          // MyString := 'ABC-111-124';
                
                                         // "Pos" is a local integer variable
                                           //Token(VAR Text : Text[1024];Separator : Text[1]) Token : Text[1024]
                                          TempString := ConvertStr(MyString,' ',',');
                
                                          /*
                
                                           String1 := Token(MyString,' ');  // Returns 'ABC' and changes string to '111-124'
                                           String2 := Token(MyString,' ');  // Returns '111' and changes string to '124'
                                           String3 := Token(MyString,' ');
                                           String4 := Token(MyString,' ');
                                           String5 := Token(MyString,' ');  */
                
                
                
                                           TempString := ConvertStr(MyString,' ',',');
                                         //  MESSAGE('%1',TempString);
                                         //  String1 := SELECTSTR(1,TempString);
                                         // MESSAGE('%1 plus %2',String1,MyString);
                                         // String2 := SELECTSTR(2,TempString);
                                         // MESSAGE('%1 plus %2',String2,MyString);
                                         //  String3 := SELECTSTR(3,TempString);
                                         //  MESSAGE('%1 plus %2',String3,MyString);
                                          // String4 := SELECTSTR(4,TempString);
                                          // String5 := SELECTSTR(5,TempString);
                                           //String6 := SELECTSTR(6,TempString);
                
                                           if TempString<>'' then
                                           String1 := SelectStr(1,TempString);
                
                                          // IF TempString<>''  THEN
                                           // String2 := SELECTSTR(2,TempString);
                                          // IF TempString<>'' THEN
                                          // String3:= SELECTSTR(3,TempString);
                
                                           //IF TempString<>'' THEN
                                         //  String4 := SELECTSTR(4,TempString);
                                         //  IF TempString<>'' THEN
                                          // String5 := SELECTSTR(5,TempString);
                                          // IF TempString<>'' THEN
                                          // String5 := SELECTSTR(6,TempString);
                
                
                
                                          // CRBA.Surname:=String3;
                                          CRBA.Surname:= String1;
                                           CRBA."Name 2":=String1;
                                           CRBA."Name 3":=String2;
                
                
                                           if Cust."Date of Birth"<>0D then begin
                
                                           Day:=Date2dmy(Cust."Date of Birth",1);
                                           Month:=Date2dmy(Cust."Date of Birth",2);
                                           Year:=Date2dmy(Cust."Date of Birth",3);
                                           DateFor:=Format(Year)+''+Format(Month)+''+Format(Day);
                                           end
                                           else
                                           DateFor:='0';
                
                                           CRBA."Date of Birth":=DateFor;
                                          // CRBA.Surname:=Cust.Name;
                                           CRBA."Client Code":=Cust."No.";
                                           CRBA."Account Number":="Loans Register"."Loan  No.";
                                           CRBA.Gender:=Cust.Gender;
                                           CRBA.Nationality:='KE';
                                           CRBA."Marital Status":=Cust."Marital Status";
                                           CRBA."Primary Identification 1":=Cust."ID No.";
                                           CRBA."Primary Identification code":='001';
                                           CRBA."Secondary Identification code":='002';
                                           CRBA."Primary Identification 2":=Cust."Passport No.";
                                           CRBA."Mobile No":=Cust."Phone No.";
                                           CRBA."Work Telephone":=Cust."Office Telephone No.";
                                           CRBA."Postal Address 1":=Cust.Address;
                                           CRBA."Postal Address 2":=Cust."Address 2";
                                           CRBA."Postal Location Town":=Cust.City;
                                           CRBA."Postal Location Country":='KE';
                                           CRBA."Post Code":=Cust."Post Code";
                                           CRBA."Physical Address 1":=Cust."Address 2";
                                           CRBA."Physical Address 2":=Cust."Home Address";
                                           CRBA."Location Town":=Cust.Location;
                                           //CRBA."Location Country":=Cust."Country/Region Code";
                                           CRBA."Location Country":='KE';
                                           CRBA."Date of Physical Address":=0D;
                                           CRBA."Customer Work Email":=Cust."E-Mail";
                                           CRBA."Employer Name":=Cust."Employer Code";
                                           CRBA."Employment Type":=Cust."Type Of Organisation";
                                           CRBA."Account Type":='S';
                                           "Loans Register".CalcFields("Loans Register"."Schedule Repayments","Loans Register"."Current Repayment","Loans Register"."Last Pay Date");
                
                
                                           LoanSche.Reset;
                                           LoanSche.SetRange(LoanSche."Loan No.","Loans Register"."Loan  No.");
                                           LoanSche.SetRange(LoanSche."Repayment Date",0D,Today);
                                           if LoanSche.Find('-') then begin
                                           LoanSche.CalcSums(LoanSche."Monthly Repayment");
                                           CRBA."Installment Due Date":=CalcDate('1M',LoanSche."Repayment Date");
                                           CRBA."No of Days in Arreas":=LoanSche."Repayment Date"-"Loans Register"."Last Pay Date";
                                           CRBA."No of Installment In":=LoanSche."Repayment Date"-"Loans Register"."Last Pay Date";
                
                                           end;
                                           CRBA."Overdue Balance":="Loans Register"."Schedule Repayments"-"Loans Register"."Current Repayment";
                
                
                
                                           if ("Loans Register"."Loan Product Type"='NORM') or ("Loans Register"."Loan Product Type"='EXP') or ("Loans Register"."Loan Product Type"='FINB') or
                                           ("Loans Register"."Loan Product Type"='EMER') or ("Loans Register"."Loan Product Type"='BOOSTER') or ("Loans Register"."Loan Product Type"='SCHOOL') then begin
                                           CRBA."Account Product Type":='H';
                                           end else if ("Loans Register"."Loan Product Type"='PLOT') or ("Loans Register"."Loan Product Type"='SMER') then begin
                                           CRBA."Account Product Type":='F';
                                           end else if ("Loans Register"."Loan Product Type"='HOME') or ("Loans Register"."Loan Product Type"='PREMIUM') then
                                           CRBA."Account Product Type":='E';
                
                
                                           if "Loans Register"."Issued Date"<>0D then begin
                
                                           Day:=Date2dmy("Loans Register"."Issued Date",1);
                                           Month:=Date2dmy("Loans Register"."Issued Date",2);
                                           Year:=Date2dmy("Loans Register"."Issued Date",3);
                                           DateFor:=Format(Year)+''+Format(Month)+''+Format(Day);
                                           end
                                           else
                                           DateFor:='0';
                                           CRBA."Date Account Opened":=DateFor;
                                           //CRBA."Installment Due Date":="Loans Register"."Payment Due Date";
                                           CRBA."Original Amount":=Format(ROUND("Loans Register"."Approved Amount",1,'='));
                                           CRBA."Currency of Facility":='KES';
                                           CRBA."Amonut in Kenya shillings":=Format(ROUND("Loans Register"."Approved Amount",1,'='));
                                           CRBA."Current Balance":=Format(ROUND("Loans Register"."Outstanding Balance",1,'='));
                                           /*//IF ("Loans Register"."Last Pay Date"<>0D) OR (AsatDate<>0D) THEN BEGIN
                                           NoDays:=AsatDate-"Loans Register"."Last Pay Date";
                                           IF NoDays>30 THEN BEGIN
                                           CRBA."No of Days in Arreas":=NoDays
                                           END ELSE BEGIN
                                           CRBA."No of Days in Arreas":=0;
                                           END;
                
                                           IF ROUND((NoDays/31),1,'=')>1 THEN BEGIN
                                           CRBA."No of Installment In":=ROUND((NoDays/31),1,'=')
                                           END ELSE BEGIN
                                           CRBA."No of Installment In":=0
                                           END;
                
                                           END ELSE BEGIN
                                           CRBA."No of Days in Arreas":=0;
                                           CRBA."No of Installment In":=0
                                           END;*/
                                           CRBA."Lenders Registered Name":='Mafanikio Sacco Ltd';
                                           CRBA."Lenders Trading Name":='Mafanikio Sacco Ltd';
                                           CRBA."Lenders Branch Name":='Mafanikio Sacco Ltd';
                                           CRBA."Lenders Branch Code":=Cust."Global Dimension 2 Code";
                                           //CRBA."Overdue Balance":=(ROUND((NoDays/31),1,'=')*"Loans Register".Repayment);
                                           if "Loans Register".Defaulted=false then
                                           CRBA."Performing / NPL Indicator":='A'
                                           else
                                           CRBA."Performing / NPL Indicator":='B';
                                           CRBA."Account Status":='F';
                
                                           if "Loans Register"."Payroll CodeB"="Loans Register"."payroll codeb"::"0" then
                                           CRBA."Account Status":='A';
                                           if "Loans Register"."Payroll CodeB"="Loans Register"."payroll codeb"::"1" then
                                           CRBA."Account Status":='B';
                                           if "Loans Register"."Payroll CodeB"="Loans Register"."payroll codeb"::"2" then
                                           CRBA."Account Status":='C';
                                           if "Loans Register"."Payroll CodeB"="Loans Register"."payroll codeb"::"3" then
                                           CRBA."Account Status":='D';
                                           if "Loans Register"."Payroll CodeB"="Loans Register"."payroll codeb"::"4" then
                                           CRBA."Account Status":='E';
                                           if "Loans Register"."Payroll CodeB"="Loans Register"."payroll codeb"::"5" then
                                           CRBA."Account Status":='F';
                                           if "Loans Register"."Payroll CodeB"="Loans Register"."payroll codeb"::"6" then
                                           CRBA."Account Status":='G';
                                           if "Loans Register"."Payroll CodeB"="Loans Register"."payroll codeb"::"7" then
                                           CRBA."Account Status":='H';
                                           if "Loans Register"."Payroll CodeB"="Loans Register"."payroll codeb"::"8" then
                                           CRBA."Account Status":='I';
                                           if "Loans Register"."Payroll CodeB"="Loans Register"."payroll codeb"::"9" then
                                           CRBA."Account Status":='J';
                                           if "Loans Register"."Payroll CodeB"="Loans Register"."payroll codeb"::"10" then
                                           CRBA."Account Status":='K';
                                           if "Loans Register"."Payroll CodeB"="Loans Register"."payroll codeb"::"11" then
                                           CRBA."Account Status":='L';
                                           if "Loans Register"."Payroll CodeB"="Loans Register"."payroll codeb"::"12" then
                                           CRBA."Account Status":='M';
                                           if "Loans Register"."Payroll CodeB"="Loans Register"."payroll codeb"::"13" then
                                           CRBA."Account Status":='N';
                
                
                                           CRBA."Account Status Date":='0';
                                           CRBA."Repayment Period":="Loans Register".Installments;
                                           CRBA."Payment Frequency":='M';
                
                                           if "Loans Register"."Loan Disbursement Date"<>0D then begin
                
                                           Day:=Date2dmy("Loans Register"."Loan Disbursement Date",1);
                                           Month:=Date2dmy("Loans Register"."Loan Disbursement Date",2);
                                           Year:=Date2dmy("Loans Register"."Loan Disbursement Date",3);
                                           DateFor:=Format(Year)+''+Format(Month)+''+Format(Day);
                                           end
                                           else
                                           DateFor:='0';
                
                
                                            //CRBA."Disbursement Date":=DateFor;
                                           CRBA."Disbursement Date":="Loans Register"."Issued Date";
                                           CRBA."Insallment Amount":=ROUND("Loans Register".Repayment,1,'=');
                
                                           if "Loans Register"."Last Pay Date"<>0D then begin
                                           Day:=Date2dmy("Loans Register"."Last Pay Date",1);
                                           Month:=Date2dmy("Loans Register"."Last Pay Date",2);
                                           Year:=Date2dmy("Loans Register"."Last Pay Date",3);
                                           DateFor:=Format(Year)+''+Format(Month)+''+Format(Day);
                                           end
                                           else
                                           DateFor:='0';
                
                
                                           CRBA."Date of Latest Payment":=DateFor;
                                           CRBA."Last Payment Amount":=ROUND("Loans Register"."Current Repayment",1,'=');
                                           CRBA."Type of Security":='U';
                
                                           CRBA.Insert;
                                           end;
                                           end;
                                         //END;

            end;

            trigger OnPreDataItem()
            begin
                        CRBA.DeleteAll;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Cust: Record "Member Register";
        CRBA: Record "CRBA Datas";
        MyString: Text;
        String1: Text;
        String2: Text;
        String3: Text;
        String5: Text;
        String4: Text;
        NoDays: Integer;
        Day: Integer;
        Month: Integer;
        Year: Integer;
        DateFor: Text;
        AsatDate: Date;
        NoLine: Integer;
        TxtKeep: Text;
        DateInput: Date;
        TempString: Text;
        LoanSche: Record "Loan Repayment Schedule";


    procedure Token(Pos: Integer)
    begin
    end;
}

