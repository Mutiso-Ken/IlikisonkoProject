#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516455 "Loan Defaulter Ageing Customis"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Loan Defaulter Ageing Customis.rdlc';

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            DataItemTableView = where(Posted = filter(true), "Outstanding Balance" = filter(<> 0));
            column(ReportForNavId_1000000000; 1000000000)
            {
            }
            column(CompanyName; ObjCompany.Name)
            {
            }
            column(CompanyPicture; ObjCompany.Picture)
            {
            }
            column(CompanyEmail; ObjCompany."E-Mail")
            {
            }
            column(CompanyWebsite; ObjCompany."Home Page")
            {
            }
            column(CompanyAddress; ObjCompany.Address)
            {
            }
            column(CompanyPhoneNumber; ObjCompany."Phone No.")
            {
            }
            column(LoanNo_LoansRegister; "Loans Register"."Loan  No.")
            {
            }
            column(ClientCode_LoansRegister; "Loans Register"."Client Code")
            {
            }
            column(ClientName_LoansRegister; "Loans Register"."Client Name")
            {
            }
            column(IssuedDate_LoansRegister; "Loans Register"."Issued Date")
            {
            }
            column(Installments_LoansRegister; "Loans Register".Installments)
            {
            }
            column(LoanProductType_LoansRegister; "Loans Register"."Loan Product Type")
            {
            }
            column(AsAt; AsAt)
            {
            }
            column(PrevMonthDate; PrevMonthDate)
            {
            }
            column(ScheduledBalance; ScheduledBalance)
            {
            }
            column(LoanBalance; LoanBalance)
            {
            }
            column(LoanArrears; LoanArrears)
            {
            }
            column(PeriodArrears; PeriodArrears)
            {
            }
            column(Class; Class)
            {
            }
            column(Performing; Performing)
            {
            }
            column(Watch; Watch)
            {
            }
            column(Substandard; Substandard)
            {
            }
            column(doubtful; doubtful)
            {
            }
            column(Loss; Loss)
            {
            }

            trigger OnAfterGetRecord()
            begin
                PrevMonthDate := CUSurefactory.FnGetPreviousMonthLastDate("Loans Register"."Loan  No.", AsAt);
                ScheduledBalance := CUSurefactory.FnGetScheduledExpectedBalance("Loans Register"."Loan  No.", PrevMonthDate);
                LoanBalance := CUSurefactory.FnGetLoanBalance("Loans Register"."Loan  No.", PrevMonthDate);
                LoanArrears := CUSurefactory.FnCalculateLoanArrears(ScheduledBalance, LoanBalance, AsAt, "Loans Register"."Expected Date of Completion");
                PeriodArrears := CUSurefactory.FnCalculatePeriodInArrears(LoanArrears, "Loans Register".Repayment, AsAt, "Loans Register"."Expected Date of Completion");
                Class := CUSurefactory.FnClassifyLoans("Loans Register"."Loan  No.", PeriodArrears, LoanArrears);

                Performing := 0;
                Watch := 0;
                Substandard := 0;
                doubtful := 0;
                Loss := 0;

                case Class of
                    Class::"1":
                        Performing := LoanBalance;
                    Class::"2":
                        Watch := LoanBalance;
                    Class::"3":
                        Substandard := LoanBalance;
                    Class::"4":
                        doubtful := LoanBalance;
                    Class::"5":
                        Loss := LoanBalance;
                end;

                if (Performing = 0) and (Watch = 0) and (Substandard = 0) and (doubtful = 0) and (Loss = 0) then
                    CurrReport.Skip;
            end;
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

    trigger OnInitReport()
    begin
        ObjCompany.Get;
        ObjCompany.CalcFields(ObjCompany.Picture);
    end;

    var
        CUSurefactory: Codeunit "SURESTEP Factory";
        AsAt: Date;
        PrevMonthDate: Date;
        ScheduledBalance: Decimal;
        LoanBalance: Decimal;
        LoanArrears: Decimal;
        PeriodArrears: Decimal;
        Class: Integer;
        Category: Code[15];
        Performing: Decimal;
        Watch: Decimal;
        Substandard: Decimal;
        doubtful: Decimal;
        Loss: Decimal;
        ObjCompany: Record "Company Information";
}

