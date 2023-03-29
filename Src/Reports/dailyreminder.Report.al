#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516982 "daily reminder"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/daily reminder.rdlc';

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            DataItemTableView = where(Posted = filter(true), "Outstanding Balance" = filter(> 0));
            RequestFilterFields = "Loan  No.";
            column(ReportForNavId_1; 1)
            {
            }
            column(ClientCode_LoansRegister; "Loans Register"."Client Code")
            {
            }
            column(ClientName_LoansRegister; "Loans Register"."Client Name")
            {
            }
            column(ApprovedAmount_LoansRegister; "Loans Register"."Approved Amount")
            {
            }
            column(LoanNo_LoansRegister; "Loans Register"."Loan  No.")
            {
            }
            column(LoanProductType_LoansRegister; "Loans Register"."Loan Product Type")
            {
            }
            column(IssuedDate_LoansRegister; "Loans Register"."Issued Date")
            {
            }
            column(OutstandingBalance_LoansRegister; "Loans Register"."Outstanding Balance")
            {
            }
            column(Region; Region)
            {
            }
            column(Arrears; Arrears)
            {
            }
            column(Phone; Phone)
            {
            }
            column(DueDate; DueDate)
            {
            }
            column(arrearloan; arrearloan)
            {
            }
            column(AsAt; AsAt)
            {
            }
            column(OustandingInterest_LoansRegister; "Loans Register"."Oustanding Interest")
            {
            }
            column(OustandingPenalty_LoansRegister; "Loans Register"."Oustanding Penalty")
            {
            }
            column(ScheduleBalance; ScheduleBalance)
            {
            }
            column(OutBal; OutBal)
            {
            }
            column(LoanType; LoanType)
            {
            }
            column(AmountinArrears_LoansRegister; "Loans Register"."Amount in Arrears")
            {
            }
            column(ExpectedDateofCompletion_LoansRegister; "Loans Register"."Expected Date of Completion")
            {
            }
            dataitem("Loan Repayment Schedule"; "Loan Repayment Schedule")
            {
                DataItemLink = "Loan No." = field("Loan  No.");
                column(ReportForNavId_18; 18)
                {
                }
                column(LoanBalance_LoanRepaymentSchedule; "Loan Repayment Schedule"."Loan Balance")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin

                ScheduleBalance := 0;
                Arrears := 0;
                if AsAt = 0D then
                    AsAt := CurrentDate;
                DateFormat := Format(AsAt, 0, '<Day,2>/<Month,2>/<Year4>');
                if Date2dmy(AsAt, 1) <> Date2dmy("Loans Register"."Issued Date", 1) then
                    CurrReport.Skip;

                DueDate := 0D;
                Phone := '';
                Region := '';
                PrincipalArrears := 0;
                InterestArrears := 0;
                OutBal := 0;
                OutInt := 0;
                OutPen := 0;
                LoanType := '';
                arrearloan := 0;

                ObjRepaySch.Reset;
                ObjRepaySch.SetRange(ObjRepaySch."Loan No.", "Loans Register"."Loan  No.");
                ObjRepaySch.SetRange("Repayment Date", AsAt);
                if ObjRepaySch.Find('-') then begin
                    //ScheduleBalance:=ObjRepaySch."Loan Balance";
                    ScheduleBalance := SFactory.FnGetScheduledExpectedBalance(ObjRepaySch."Loan No.", AsAt);
                    if ScheduleBalance > 0 then begin
                        DueDate := CalcDate(Format("Loans Register".Installments) + 'M', "Loans Register"."Issued Date");
                    end;
                end;

                "Loans Register".CalcFields("Loans Register"."Outstanding Balance", "Loans Register"."Oustanding Interest", "Loans Register"."Oustanding Penalty");
                OutBal := "Loans Register"."Outstanding Balance";
                OutInt := "Loans Register"."Oustanding Interest";
                OutPen := "Loans Register"."Oustanding Penalty";

                Arrears := (OutBal + OutInt + OutPen) - ScheduleBalance;
                if Arrears < 0 then
                    Arrears := 0;

                MemberRegister.Reset;
                MemberRegister.SetRange("No.", "Loans Register"."Client Code");
                if MemberRegister.Find('-') then begin
                    Phone := MemberRegister."Mobile Phone No";
                    Region := MemberRegister.Region;
                end;

                Cust.Reset;
                Cust.SetRange(Cust."No.", "Loans Register"."Client Code");
                //Cust.SETFILTER(Cust."Outstanding Balance",'>%1',0);
                if Cust.Find('-') then //BEGIN
                    repeat
                        MobileNo := Cust."Mobile Phone No";

                        // END;
                        ObjGenSetUp.Get;
                        ObjCompInfo.Get;

                        SMSMessage.Reset;
                        if SMSMessage.Find('+') then begin
                            iEntryNo := SMSMessage."Entry No";
                            iEntryNo := iEntryNo + 1;
                        end
                        else begin
                            iEntryNo := 1;
                        end;


                        SMSMessage.Init;
                        SMSMessage."Entry No" := iEntryNo;
                        SMSMessage."Batch No" := "Loans Register"."Loan  No.";
                        SMSMessage."Document No" := '';
                        SMSMessage."Account No" := Cust."No.";
                        SMSMessage."Date Entered" := Today;
                        SMSMessage."Time Entered" := Time;
                        SMSMessage.Source := 'Reminder';
                        SMSMessage."Entered By" := UserId;
                        SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
                        SMSMessage."SMS Message" := 'Mwanachama, kumbuka kulipa mkopo wako kesho kutwa ' + Format(DateFormat) + '. Unaweza kutuma kwa Pay bill 323730 Loitokitok au 323731 Kimana. Account ni Loan number yako.';
                        SMSMessage."Telephone No" := Cust."Mobile Phone No";
                        if Cust."Mobile Phone No" <> '' then
                            // ERROR('Inserted');//Hebu nipigie
                            SMSMessage.Insert;
                    until Cust.Next = 0;
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

    trigger OnPreReport()
    begin
        CurrentDate := CalcDate('2D', Today);
    end;

    var
        Region: Code[30];
        Phone: Code[20];
        DueDate: Date;
        Arrears: Decimal;
        ObjRepaySch: Record "Loan Repayment Schedule";
        ScheduleBalance: Decimal;
        AsAt: Date;
        MemberRegister: Record "Member Register";
        PrincipalArrears: Decimal;
        InterestArrears: Decimal;
        OutPen: Decimal;
        OutBal: Decimal;
        LoanType: Text;
        LDat: Integer;
        LoanDate: Integer;
        SFactory: Codeunit "SURESTEP Factory";
        arrearloan: Decimal;
        OutInt: Decimal;
        SMSMessage: Record "SMS Messages";
        iEntryNo: Integer;
        ObjCompInfo: Record "Company Information";
        ObjGenSetUp: Record "Sacco General Set-Up";
        Cust: Record "Member Register";
        LoanRepaymentSchedule: Record "Loan Repayment Schedule";
        MobileNo: Code[20];
        CurrentDate: Date;
        LoanApp: Record "Loans Register";
        DateFormat: Text;
}

