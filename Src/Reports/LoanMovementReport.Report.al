#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516909 "Loan Movement Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Loan Movement Report.rdlc';

    dataset
    {
        dataitem("Loan Products Setup";"Loan Products Setup")
        {
            PrintOnlyIfDetail = false;
            column(ReportForNavId_4645; 4645)
            {
            }
            column(FORMAT_TODAY_0_4_;Format(Today,0,4))
            {
            }
            column(COMPANYNAME;COMPANYNAME)
            {
            }
            column(Company_Name;Company.Name)
            {
            }
            column(Company_Address;Company.Address)
            {
            }
            column(Company_Address_2;Company."Address 2")
            {
            }
            column(Company_Phone_No;Company."Phone No.")
            {
            }
            column(Company_Fax_No;Company."Fax No.")
            {
            }
            column(CompanyLetter_Head;Company.Letter_Head)
            {
            }
            column(Company_Picture;Company.Picture)
            {
            }
            column(Company_Email;Company."E-Mail")
            {
            }
            column(CurrReport_PAGENO;CurrReport.PageNo)
            {
            }
            column(USERID;UserId)
            {
            }
            column(Code_LoanProductsSetup;"Loan Products Setup".Code)
            {
            }
            column(ProductDescription_LoanProductsSetup;"Loan Products Setup"."Product Description")
            {
            }
            column(GLAccountNo;GLAccountNo)
            {
            }
            column(CurrDate;Format(CurrDate))
            {
            }
            column(ClosingBalPreviousDay;ClosingBalPreviousDay)
            {
            }
            column(ClosingBalToday;ClosingBalToday)
            {
            }
            column(PreviousDay;Format(PreviousDay))
            {
            }
            column(TotalDeposits;TotalDeposits)
            {
            }
            column(TotalWithdrawals;TotalWithdrawals)
            {
            }
            column(TransactedAccounts;TransactedAccounts)
            {
            }
            column(NoofLoanAccounts_LoanProductsSetup;"Loan Products Setup"."No of Loan Accounts")
            {
            }

            trigger OnAfterGetRecord()
            begin
                CurrDate:=ASAT;
                PreviousDay:=ASAT-1;
                StartDate:=20170101D;
                TotalDeposits:=0;
                TotalWithdrawals:=0;
                CurrDateFilter:=Format(StartDate)+'..'+Format(CurrDate);
                PrevDateFilter:=Format(StartDate)+'..'+Format(PreviousDay);


                LoanType.Reset;
                LoanType.SetRange(LoanType.Code,Code);
                if LoanType.FindSet then begin
                  GLAccountNo:=LoanType."Loan Account";

                    GLAccounts.Reset;
                    GLAccounts.SetRange(GLAccounts."No.",GLAccountNo);
                    GLAccounts.SetFilter(GLAccounts."Date Filter",CurrDateFilter);
                    if GLAccounts.FindSet then begin
                      GLAccounts.CalcFields(GLAccounts.Balance);
                      ClosingBalToday:=GLAccounts.Balance;
                      end;

                    GLAccounts.Reset;
                    GLAccounts.SetRange(GLAccounts."No.",GLAccountNo);
                    GLAccounts.SetFilter(GLAccounts."Date Filter",PrevDateFilter);
                    if GLAccounts.FindSet then begin
                      GLAccounts.CalcFields(GLAccounts.Balance);
                      ClosingBalPreviousDay:=GLAccounts.Balance;
                      end;

                    GLEntry.Reset;
                    GLEntry.SetRange(GLEntry."G/L Account No.",GLAccountNo);
                    GLEntry.SetRange(GLEntry."Posting Date",ASAT);
                    if GLEntry.FindSet then begin
                      if GLEntry.Amount<0 then begin
                        TotalDeposits:=TotalDeposits+GLEntry.Amount;
                        end else
                        TotalWithdrawals:=TotalWithdrawals+GLEntry.Amount;
                          if GLEntry."Source No."<>GLEntries."Source No." then begin
                            TransactedAccounts:=GLEntry.Count;
                            end;

                      end;

                  end;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("As At";ASAT)
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
                Company.Get();
                Company.CalcFields(Company.Picture,Letter_Head);
    end;

    var
        Company: Record "Company Information";
        ClosingBalPreviousDay: Decimal;
        TotalDeposits: Decimal;
        TotalWithdrawals: Decimal;
        ClosingBalToday: Decimal;
        GLAccountNo: Code[20];
        VendorPostingGroups: Record "Vendor Posting Group";
        StartDate: Date;
        PreviousDay: Date;
        CurrDate: Date;
        GLAccounts: Record "G/L Account";
        CurrDateFilter: Text;
        PrevDateFilter: Text;
        GLEntry: Record "G/L Entry";
        ASAT: Date;
        TransactedAccounts: Integer;
        GLEntries: Record "G/L Entry";
        LoanType: Record "Loan Products Setup";
}

