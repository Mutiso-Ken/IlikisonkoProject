#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516978 "Daily Collection N"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Daily Collection N.rdlc';

    dataset
    {
        dataitem("Loan Repayment Schedule"; "Loan Repayment Schedule")
        {
            column(ReportForNavId_18; 18)
            {
            }
            column(LoanBalance_LoanRepaymentSchedule; "Loan Repayment Schedule"."Loan Balance")
            {
            }
            column(MemberNo_LoanRepaymentSchedule; "Loan Repayment Schedule"."Member No.")
            {
            }
            column(LoanNo_LoanRepaymentSchedule; "Loan Repayment Schedule"."Loan No.")
            {
            }
            column(LoanCategory_LoanRepaymentSchedule; "Loan Repayment Schedule"."Loan Category")
            {
            }
            dataitem("Loans Register"; "Loans Register")
            {
                DataItemLink = "Loan  No." = field("Loan No.");
                DataItemTableView = where(Posted = filter(true), "Outstanding Balance" = filter(> 0));
                RequestFilterFields = "Loan  No.";
                column(ReportForNavId_1; 1)
                {
                }
                column(ClientName_LoansRegister; "Loans Register"."Client Name")
                {
                }
                column(ApprovedAmount_LoansRegister; "Loans Register"."Approved Amount")
                {
                }
                column(IssuedDate_LoansRegister; "Loans Register"."Issued Date")
                {
                }
                column(OutstandingBalance_LoansRegister; "Loans Register"."Outstanding Balance")
                {
                }
                column(OustandingInterest_LoansRegister; "Loans Register"."Oustanding Interest")
                {
                }
                column(ExpectedDateofCompletion_LoansRegister; "Loans Register"."Expected Date of Completion")
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
                column(ScheduleBalance; ScheduleBalance)
                {
                }
                column(OutBal; OutBal)
                {
                }
                column(LoanType; LoanType)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    ScheduleBalance := 0;
                    Arrears := 0;
                    if AsAt = 0D then
                        AsAt := Today;
                    if Date2dmy(AsAt, 1) <> Date2dmy("Loans Register"."Issued Date", 1) then
                        CurrReport.Skip;

                    DueDate := 0D;
                    Phone := '';
                    Region := '';
                    PrincipalArrears := 0;
                    InterestArrears := 0;
                    OutBal := 0;
                    LoanType := '';
                    arrearloan := 0;

                    ObjRepaySch.Reset;
                    ObjRepaySch.SetRange(ObjRepaySch."Loan No.", "Loans Register"."Loan  No.");
                    ObjRepaySch.SetRange("Repayment Date", AsAt);
                    if ObjRepaySch.Find('-') then begin
                        ScheduleBalance := ObjRepaySch."Loan Balance";
                        ScheduleBalance := SFactory.FnGetScheduledExpectedBalance(ObjRepaySch."Loan No.", AsAt);
                        if ScheduleBalance > 0 then begin
                            "Loans Register".CalcFields("Loans Register"."Outstanding Balance", "Loans Register"."Oustanding Interest");
                            DueDate := CalcDate(Format("Loans Register".Installments) + 'M', "Loans Register"."Issued Date");
                            OutBal := "Loans Register"."Outstanding Balance";
                        end;
                        Arrears := OutBal - ScheduleBalance;
                    end;

                    MemberRegister.Reset;
                    MemberRegister.SetRange("No.", "Loans Register"."Client Code");
                    if MemberRegister.Find('-') then begin
                        Phone := MemberRegister."Mobile Phone No";
                        Region := MemberRegister.Region;
                    end;

                    arrearloan := "Loans Register"."Outstanding Balance" + "Loans Register"."Oustanding Interest" - ScheduleBalance;
                    if arrearloan < 0 then
                        arrearloan := 0;
                end;

                trigger OnPreDataItem()
                begin
                    /*AsAt:='..'+FORMAT(TODAY);*/

                end;
            }
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("As At"; AsAt)
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
        OutBal: Decimal;
        LoanType: Text;
        LDat: Integer;
        LoanDate: Integer;
        SFactory: Codeunit "SURESTEP Factory";
        arrearloan: Decimal;
}

