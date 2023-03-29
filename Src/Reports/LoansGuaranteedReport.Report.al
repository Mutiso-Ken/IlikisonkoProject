#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516503 "Loans Guaranteed Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Loans Guaranteed Report.rdlc';

    dataset
    {
        dataitem("Member Register";"Member Register")
        {
            RequestFilterFields = "No.",Name;
            column(ReportForNavId_1000000000; 1000000000)
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
            column(No_Members;"Member Register"."No.")
            {
            }
            column(RNo;RNo)
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
            dataitem("Loans Guarantee Details";"Loans Guarantee Details")
            {
                DataItemLink = "Member No"=field("No.");
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
                column(LoanProduct_BOSALoansGuarantors;"Loans Guarantee Details"."Loan Product")
                {
                }
                column(No;no)
                {
                }
                column(OutstandingBalance_LoanGuarantors;"Loans Guarantee Details"."Outstanding Balance")
                {
                }
                column(OutstandingBAlSt;OutstandingBAlSt)
                {
                }
                column(OutStandingBal;OutStandingBal)
                {
                }
                column(TotalOutstandingBal;TotalOutstandingBal)
                {
                }
                column(FNo;FNo)
                {
                }
                column(AmountGuar;AmountGuar)
                {
                }
                column(LoaneesName_LoanGuarantors;"Loans Guarantee Details"."Loanees  Name")
                {
                }
                column(LoaneesNo_LoanGuarantors;"Loans Guarantee Details"."Loanees  No")
                {
                }
                column(SubNo;"Loans Guarantee Details"."Substituted Guarantor")
                {
                }
                column(OriginalAmount_LoansGuaranteeDetails;"Loans Guarantee Details"."Original Amount")
                {
                }
                column(SubName;"Loans Guarantee Details"."Share capital")
                {
                }
                dataitem("Loans Register";"Loans Register")
                {
                    DataItemLink = "Loan  No."=field("Loan No");
                    DataItemTableView = sorting("Loan  No.") order(ascending) where(Posted=const(true));
                    column(ReportForNavId_1000000017; 1000000017)
                    {
                    }
                    column(Client_Code;"Client Code")
                    {
                    }
                    column(Client_Name;"Client Name")
                    {
                    }
                    column(EmployerCode_Loans; "Loans Register"."Employer Code")
                    {
                    }
                    column(OutstandingBalance_Loans; "Loans Register"."Outstanding Balance")
                    {
                    }
                    column(ApprovedAmount_LoansRegister;"Loans Register"."Approved Amount")
                    {
                    }

                    trigger OnPreDataItem()
                    begin
                        OutStandingBal:=0;
                        TotalOutstandingBal:=0;
                        OutStandingBal:=OutStandingBal;
                        TotalOutstandingBal:=TotalOutstandingBal;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    //Loan.GET();
                    OutstandingBAlSt:=0;
                    Loansr.Reset;
                    Loansr.SetRange(Loansr."Loan  No.","Loan No");
                    if  "Loans Register".Find('-') then //BEGIN
                    Loansr.CalcFields(Loansr."Outstanding Balance");
                    MemberNo:=Loansr."Client Code";
                    MemberName:=Loansr."Client Name";
                    EmployerCode:=Loansr."Employer Code";
                    OutstandingBAlSt:=Loansr."Outstanding Balance";
                    FNo:=FNo+1;
                    //END;
                    AmountGuar:=AmountGuar+"Amont Guaranteed";
                end;
            }

            trigger OnAfterGetRecord()
            begin
                RNo:=1;
                //RNo:=INCSTR(FORMAT(RNo));
                //Members.CALCFIELDS(Members."Outstanding Balance",Members."Current Shares",Members."Loans Guaranteed");
                //AvailableSH:=Members."Current Shares"-Members."Loans Guaranteed";
                /*Cust.RESET;
                Cust.SETRANGE(Cust."No.","No.");
                IF Cust.FIND('-') THEN BEGIN
                REPEAT
                
                UNTIL Cust.NEXT=0;
                END;
                */

            end;

            trigger OnPreDataItem()
            begin
                  LastFieldNo := FieldNo("No.");
                  RNo:=RNo+1;
                  Company.Get();
                  Company.CalcFields(Company.Picture);
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
        AmountGuar: Decimal;
        OutstandingBAlSt: Decimal;
        RNo: Integer;
        Cust: Record "Member Register";
        Company: Record "Company Information";
}

