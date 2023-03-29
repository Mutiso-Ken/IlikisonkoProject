#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516559 generate
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/generate.rdlc';

    dataset
    {
        dataitem(Cust;"Member Register")
        {
            column(ReportForNavId_1120054000; 1120054000)
            {
            }

            trigger OnAfterGetRecord()
            begin
                 /* IF "Member Register"."Last Payment Date"<>0D THEN BEGIN
                    DormancyDate:=CALCDATE('+3M',"Member Register"."Last Payment Date");
                    Days:=ROUND(AsAt-DormancyDate,1,'>');
                    IF DormancyDate> AsAt THEN BEGIN
                      "Member Register".Status:="Member Register".Status::Active;
                      "Member Register".MODIFY
                    END ELSE BEGIN
                      "Member Register".Status:="Member Register".Status::Dormant;
                      "Member Register".MODIFY;;
                    END;
                    "Member Register"."No Of Days":=Days;
                    "Member Register".MODIFY;
                  END;
                  */
                //***************************************************************************
                /*
                GenSetup.GET();
                Cust.RESET;
                Cust.SETRANGE(Cust."No.","Member Register"."No.");
                IF Cust.FIND('-') THEN BEGIN
                //Cust.CALCFIELDS(Cust."Last Deposit Cont. date");
                Cust.CALCFIELDS(Cust."Last Payment Date");
                IF Cust."Last Payment Date"<>0D THEN BEGIN
                DormancyDate:=CALCDATE(GenSetup."Max. Non Contribution Periods",Cust."Last Payment Date");
                IF DormancyDate> AsAt THEN BEGIN
                  "Member Register".Status:="Member Register".Status::Active;
                  "Member Register".MODIFY;
                 END;
                IF DormancyDate<AsAt THEN BEGIN
                   "Member Register".Status:="Member Register".Status::Dormant;
                   "Member Register".MODIFY;
                 END;
                END;
                END;
                */
                //*****************************************************************************
                /*
                "Member Register".RESET;
                "Member Register".SETRANGE("Member Register"."No.",Cust."No.");
                IF "Member Register".FIND('-') THEN BEGIN
                REPEAT*/
                ledger.Reset;
                ledger.SetRange(ledger."Customer No.","Member Register"."No.");
                ledger.SetFilter(ledger."Transaction Type",'%1',ledger."transaction type"::"Deposit Contribution");
                if ledger.Find('+') then begin
                if ledger."Posting Date"<>0D then begin
                    DormancyDate:=CalcDate('+3M',ledger."Posting Date");
                    Days:=ROUND(AsAt-DormancyDate,1,'>');
                    ActualDormancyDays:=AsAt-ledger."Posting Date";
                    if DormancyDate> AsAt then begin
                      "Member Register".Status:="Member Register".Status::Active;
                      "Member Register".Modify
                    end else begin
                      "Member Register".Status:="Member Register".Status::Dormant;
                      "Member Register".Modify;
                    end;
                   // "Member Register"."No Of Days":=Days;
                    //"Member Register".MODIFY;
                 end;
                 //MESSAGE('Member %1 Status is updated and Days Dormant is %2',Cust."No.",ActualDormancyDays);
                //END;
                //UNTIL "Member Register".NEXT=0;
                end;

            end;

            trigger OnPreDataItem()
            begin
                   if AsAt = 0D then
                      AsAt:=Today;
                      DateFilter:='..'+Format(AsAt);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(AsAt;AsAt)
                {
                    ApplicationArea = Basic;
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
        SN: Integer;
        Company: Record "Company Information";
        GenSetup: Record "Sacco General Set-Up";
        Customer: Record "Member Register";
        AsAt: Date;
        DateFilter: Text[30];
        DormancyDate: Date;
        Days: Integer;
        ledger: Record "Member Ledger Entry";
        ActualDormancyDays: Integer;
        "Member Register": Record "Member Register";
}

