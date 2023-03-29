#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516480 "Validate Checkoff-Distributed"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Validate Checkoff-Distributed.rdlc';

    dataset
    {
        dataitem("Checkoff Lines-Distributed";"Checkoff Lines-Distributed")
        {
            column(ReportForNavId_1000000000; 1000000000)
            {
            }

            trigger OnAfterGetRecord()
            begin
                   //MESSAGE('loantype is %1');
                   Cust.Reset;
                    Cust.SetRange(Cust."Personal No","Staff/Payroll No");
                    if Cust.Find('-') then begin
                     repeat
                      Cust.CalcFields(Cust."Current Shares");
                      "Member No.":=Cust."No.";
                      Name:=Cust.Name;
                      "Expected Amount":=Cust."Monthly Contribution";
                      Variance:=Amount-"Expected Amount";
                      "FOSA Account":=Cust."FOSA Account No.";
                      Modify;
                     until Cust.Next=0;
                    end;



                    LoanType.Reset;
                    LoanType.SetRange(LoanType."Special Code Principle","Checkoff Lines-Distributed".Reference);
                      if LoanType.Find('-') then begin
                        "Loan Type":=LoanType.Code;
                         Modify;
                // IF LoanType."Product Description"<>'SALARY ADVANCE' THEN BEGIN
                    Loans.Reset;
                   Loans.SetRange(Loans."Staff No","Checkoff Lines-Distributed"."Staff/Payroll No");
                   ///Loans.SETRANGE(Loans."Client Code","Checkoff Lines-Distributed"."Member No." );
                    Loans.SetRange(Loans."Loan Product Type","Loan Type");
                      if Loans.Find('-') then begin
                      repeat
                        Loans.CalcFields(Loans."Outstanding Balance");
                        if Loans."Outstanding Balance">0 then begin
                        "Loan No.":=Loans."Loan  No.";
                        "Checkoff Lines-Distributed"."Expected Amount":=Loans."Loan Principle Repayment";
                        "Checkoff Lines-Distributed"."Transaction Type":="Checkoff Lines-Distributed"."transaction type"::"4";
                        "Checkoff Lines-Distributed"."Utility Type":='REPAYMENT';
                        "Checkoff Lines-Distributed"."Unallocated Fund":=Loans.Source;
                         Modify;
                        end;
                      until Loans.Next=0;
                      end;
                      end;

                    LoanType.Reset;
                    LoanType.SetRange(LoanType."Special Code Interest","Checkoff Lines-Distributed".Reference);
                      if LoanType.Find('-') then begin
                        "Loan Type":=LoanType.Code;
                         Modify;
                       // MESSAGE('loantype is %1',"Loan Type");
                    Loans.Reset;
                    Loans.SetRange(Loans."Staff No","Checkoff Lines-Distributed"."Staff/Payroll No");
                   // Loans.SETRANGE(Loans."Client Code","Checkoff Lines-Distributed"."Member No.");
                    Loans.SetRange(Loans."Loan Product Type","Loan Type");
                      if Loans.Find('-') then begin
                      repeat
                        Loans.CalcFields(Loans."Outstanding Balance");
                        if Loans."Outstanding Balance">0 then begin
                        "Loan No.":=Loans."Loan  No.";
                         // MESSAGE('loantype is %1',"Loan Type");
                        "Checkoff Lines-Distributed"."Expected Amount":=Loans."Loan Interest Repayment";
                        "Checkoff Lines-Distributed"."Transaction Type":="Checkoff Lines-Distributed"."transaction type"::"3";
                        "Checkoff Lines-Distributed"."Utility Type":='INTEREST';
                        "Checkoff Lines-Distributed"."Unallocated Fund":=Loans.Source;
                         Modify;
                        end;
                      until Loans.Next=0;
                      end;
                      end;




                    LoanType.Reset;
                    LoanType.SetRange(LoanType."Special Code Principle","Checkoff Lines-Distributed".Reference);
                      if LoanType.Find('-') then begin
                        "Loan Type":=LoanType.Code;
                         Modify;
                       end;

                Loans.Reset;
                Loans.SetRange(Loans."Staff No","Checkoff Lines-Distributed"."Staff/Payroll No");
                //Loans.SETRANGE(Loans."Client Code","Checkoff Lines-Distributed"."Member No.");
                Loans.SetRange(Loans."Loan Product Type","Loan Type");
                // Loans.SETFILTER(Loans."Outstanding Balance",'>%1',0);
                if Loans.FindLast then begin
                repeat
                Loans.CalcFields(Loans."Outstanding Balance");
                if Loans."Outstanding Balance"<=0 then begin
                "Checkoff Lines-Distributed"."Transaction Type":="Checkoff Lines-Distributed"."transaction type"::"9";
                "Checkoff Lines-Distributed"."Utility Type":='UNALLOCATED';
                "Checkoff Lines-Distributed".Modify;
                end;
                until Loans.Next =0;

                end;
                // END;






                LoanType.Reset;
                LoanType.SetRange(LoanType."Special Code Interest","Checkoff Lines-Distributed".Reference);
                  if LoanType.Find('-') then begin
                    "Loan Type":=LoanType.Code;
                      Modify;
                      end;

                Loans.Reset;
                Loans.SetRange(Loans."Staff No","Checkoff Lines-Distributed"."Staff/Payroll No");
                //Loans.SETRANGE(Loans."Client Code","Checkoff Lines-Distributed"."Member No.");
                Loans.SetRange(Loans."Loan Product Type","Loan Type");
                // Loans.SETFILTER(Loans."Outstanding Balance",'>%1',0);
                if Loans.FindLast then begin
                repeat
                Loans.CalcFields(Loans."Outstanding Balance");
                if Loans."Outstanding Balance"<=0 then begin
                "Checkoff Lines-Distributed"."Transaction Type":="Checkoff Lines-Distributed"."transaction type"::"9";
                "Checkoff Lines-Distributed"."Utility Type":='UNALLOCATED';
                "Checkoff Lines-Distributed".Modify;
                end;
                until Loans.Next =0;

                end;
                // END;


                 if "Checkoff Lines-Distributed"."Loan No."='' then begin
                      "Checkoff Lines-Distributed"."Loans Not found":=true;
                      Modify;
                end;

                if "Checkoff Lines-Distributed".Reference='165' then
                 "Checkoff Lines-Distributed"."Transaction Type":="Checkoff Lines-Distributed"."transaction type"::"5"
                else  if "Checkoff Lines-Distributed".Reference='140' then
                 "Checkoff Lines-Distributed"."Transaction Type":="Checkoff Lines-Distributed"."transaction type"::"7"
                else if "Checkoff Lines-Distributed".Reference='229' then
                "Checkoff Lines-Distributed"."Transaction Type":="Checkoff Lines-Distributed"."transaction type"::"2"
                else if "Checkoff Lines-Distributed".Reference='337' then
                "Checkoff Lines-Distributed"."Transaction Type":="Checkoff Lines-Distributed"."transaction type"::"18";
                "Checkoff Lines-Distributed".Modify;


                if "Checkoff Lines-Distributed".Reference='165' then
                 "Checkoff Lines-Distributed"."Utility Type":='DEPOSITS'
                else if "Checkoff Lines-Distributed".Reference='140' then
                 "Checkoff Lines-Distributed"."Utility Type":='BENEVOLENT'
                else if "Checkoff Lines-Distributed".Reference='229' then
                "Checkoff Lines-Distributed"."Utility Type":='SHARES'
                else if "Checkoff Lines-Distributed".Reference='337' then
                "Checkoff Lines-Distributed"."Utility Type":='RESERVE'
                else if "Checkoff Lines-Distributed".Reference='110' then
                "Checkoff Lines-Distributed"."Utility Type":='FOSA';
                "Checkoff Lines-Distributed".Modify;


                 if "Checkoff Lines-Distributed"."Utility Type"='' then
                 "Checkoff Lines-Distributed"."Utility Type":='UNALLOCATED'
                 else
                "Checkoff Lines-Distributed"."Transaction Type":="Checkoff Lines-Distributed"."Transaction Type";
                "Checkoff Lines-Distributed".Modify;
                //END;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(ASATDATE;ASATDATE)
                {
                    ApplicationArea = Basic;
                    Caption = 'As At';
                }
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
        Rcpt: Record "Checkoff Lines-Distributed";
        PNo: Integer;
        Cust: Record "Member Register";
        Dept: Code[10];
        Loans: Record "Loans Register";
        LoanType: Record "Loan Products Setup";
        Pdate: Date;
        Variance: Decimal;
        ASATDATE: Date;
        BaldateTXT: Text[30];
        Baldate: Date;
        Employees: Record "Checkoff Lines-Distributed";
        RcptHeader: Record "Checkoff Header-Distributed";
}

