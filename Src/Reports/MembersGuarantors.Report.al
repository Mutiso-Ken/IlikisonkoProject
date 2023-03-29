#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516482 "Members Guarantors"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Members Guarantors.rdlc';

    dataset
    {
        dataitem("Member Register";"Member Register")
        {
            RequestFilterFields = "No.",Name;
            column(ReportForNavId_1000000000; 1000000000)
            {
            }
            column(No_Members;"Member Register"."No.")
            {
            }
            column(Name_Members;"Member Register".Name)
            {
            }
            column(PhoneNo_Members;"Member Register"."Phone No.")
            {
            }
            column(OutstandingBalance_Members;"Member Register"."Outstanding Balance")
            {
            }
            column(CompanyLetter_Head;Company.Letter_Head)
            {
            }
            column(FNo;FNo)
            {
            }
            dataitem("Loans Guarantee Details";"Loans Guarantee Details")
            {
                DataItemLink = "Loanees  No"=field("No.");
                DataItemTableView = where("Outstanding Balance"=filter(<>0),Substituted=filter(false));
                RequestFilterFields = "Member No","Loan No";
                column(ReportForNavId_1000000001; 1000000001)
                {
                }
                column(AmontGuaranteed_LoanGuarantors;"Loans Guarantee Details"."Amont Guaranteed")
                {
                }
                column(NoOfLoansGuaranteed_LoanGuarantors;"Loans Guarantee Details"."No Of Loans Guaranteed")
                {
                }
                column(Name_LoanGuarantors;"Loans Guarantee Details".Name)
                {
                }
                column(MemberNo_LoanGuarantors;"Loans Guarantee Details"."Member No")
                {
                }
                column(LoanNo_LoanGuarantors;"Loans Guarantee Details"."Loan No")
                {
                }
                column(No;no)
                {
                }
                column(OutStandingBal;"Loans Guarantee Details"."Outstanding Balance")
                {
                }
                column(TotalOutstandingBal;TotalOutstandingBal)
                {
                }
                column(EmployerCode;EmployerCode)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //Loan.GET();

                    Loansr.Reset;
                    Loansr.SetRange(Loansr."Loan  No.","Loan No");
                    if  Loansr.Find('-') then //BEGIN
                    MemberNo:=Loansr."Client Code";
                    MemberName:=Loansr."Client Name";
                    EmployerCode:=Loansr."Employer Code"


                    //END;
                end;
            }

            trigger OnAfterGetRecord()
            begin

                //Members.CALCFIELDS(Members."Outstanding Balance",Members."Current Shares",Members."Loans Guaranteed");
                //AvailableSH:=Members."Current Shares"-Members."Loans Guaranteed";

                FNo:=FNo+1;
            end;

            trigger OnPreDataItem()
            begin
                  LastFieldNo := FieldNo("No.");
            end;
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

    labels
    {
    }

    trigger OnInitReport()
    begin
          Company.Get();
          Company.CalcFields(Company.Picture,Letter_Head);
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        AvailableSH: Decimal;
        MemberNo: Text;
        MemberName: Text;
        EmployerCode: Text;
        Loansr: Record "Loans Register";
        no: Integer;
        TotalOutstandingBal: Decimal;
        OutStandingBal: Decimal;
        FNo: Integer;
        Company: Record "Company Information";
}

