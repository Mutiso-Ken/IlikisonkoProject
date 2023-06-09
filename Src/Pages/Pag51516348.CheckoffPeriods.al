#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516348 "Checkoff  Periods."
{
    DeleteAllowed = false;
    Editable = false;
    PageType = Card;
    SourceTable = "Checkoff Calender.";

    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field("Period Month";"Period Month")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Period Year";"Period Year")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Period Name";"Period Name")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Date Opened";"Date Opened")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field("Date Closed";"Date Closed")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(Closed;Closed)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Close Period")
            {
                ApplicationArea = Basic;
                Caption = 'Close Period';
                Image = ClosePeriod;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    /*
                    Warn user about the consequence of closure - operation is not reversible.
                    Ask if he is sure about the closure.
                    */
                    
                    fnGetOpenPeriod;
                    
                    Question := 'Once a period has been closed it can NOT be opened.\It is assumed that you have Posted all remmitance.\'
                    + 'Do still want to close ['+ strPeriodName +']';
                    
                    
                    Answer := Dialog.Confirm(Question, false);
                    if Answer=true then
                    begin
                      fnClosePayrollPeriod(dtOpenPeriod,PayrollCode);
                      Message ('Process Complete');
                    end else begin
                       Message('You have selected NOT to Close the period');
                    end

                end;
            }
            action("Reopen Period")
            {
                ApplicationArea = Basic;

                trigger OnAction()
                begin
                    if usersetup.Get (UserId) then
                    begin
                        if usersetup."Approval Status Change"=false then begin
                          Error ('You dont have permissions Approval Status Change, Contact your system administrator! ')
                          end else
                          begin
                            if Confirm('Are you sure you want to Reopen this application for Correction? ',false)=true then begin
                              Closed:=true;
                              Closed:=false;
                              period.Closed:=true;
                              period.Closed:=false;


                              Modify;
                              Message('Period has been opened');

                          end;
                          end;
                          end;
                end;
            }
        }
    }

    var
        PayPeriod: Record "Checkoff Calender.";
        strPeriodName: Text[30];
        Text000: label '''Leave without saving changes?''';
        Text001: label '''You selected %1.''';
        Question: Text[250];
        Answer: Boolean;
        objOcx: Codeunit "Payroll Processing";
        dtOpenPeriod: Date;
        PayrollType: Record "Payroll Type.";
        Selection: Integer;
        PayrollDefined: Text[30];
        PayrollCode: Code[10];
        NoofRecords: Integer;
        i: Integer;
        ContrInfo: Record "Control-Information.";
        usersetup: Record "User Setup";
        period: Record "Checkoff Calender.";


    procedure fnGetOpenPeriod()
    begin

        //Get the open/current period
        PayPeriod.SetRange(PayPeriod.Closed,false);
        if PayPeriod.Find('-') then begin
           strPeriodName:=PayPeriod."Period Name";
           dtOpenPeriod:=PayPeriod."Date Opened";
        end;
    end;


    procedure fnClosePayrollPeriod(dtOpenPeriod: Date;PayrollCode: Code[20]) Closed: Boolean
    var
        dtNewPeriod: Date;
        intNewMonth: Integer;
        intNewYear: Integer;
        intMonth: Integer;
        intYear: Integer;
        curTransAmount: Decimal;
        curTransBalance: Decimal;
        prPayrollPeriods: Record "Checkoff Calender.";
        prNewPayrollPeriods: Record "Checkoff Calender.";
        CreateTrans: Boolean;
        ControlInfo: Record "Control-Information.";
    begin
        //ControlInfo.GET();
        dtNewPeriod := CalcDate('1M', dtOpenPeriod);
        dtNewPeriod:=CalcDate('CM',dtNewPeriod);
        intNewMonth := Date2dmy(dtNewPeriod,2);
        intNewYear := Date2dmy(dtNewPeriod,3);


        intMonth := Date2dmy(dtOpenPeriod,2);
        intYear := Date2dmy(dtOpenPeriod,3);

        prPayrollPeriods.Reset;
        prPayrollPeriods.SetRange(prPayrollPeriods."Period Month",intMonth);
        prPayrollPeriods.SetRange(prPayrollPeriods."Period Year",intYear);
        prPayrollPeriods.SetRange(prPayrollPeriods.Closed,false);
        //prPayrollPeriods.SETRANGE(prPayrollPeriods."Payroll Code",PayrollCode);
        if prPayrollPeriods.FindLast then begin
           prPayrollPeriods.Closed:=true;
           prPayrollPeriods."Date Closed":=Today;
           prPayrollPeriods.Modify;
        end;

        //Enter a New Period
        with prNewPayrollPeriods do begin
          Init;
            "Period Month":=intNewMonth;
            "Period Year":= intNewYear;
            "Period Name":= Format(dtNewPeriod,0,'<Month Text>')+''+Format(intNewYear);
            "Date Opened":= dtNewPeriod;
             Closed :=false;
             "Payroll Code":=PayrollCode;
            Insert;
        end;
    end;
}

