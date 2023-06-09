#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516466 "Post Monthly Interest2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Post Monthly Interest2.rdlc';

    dataset
    {
        dataitem("Loans Register";"Loans Register")
        {
            DataItemTableView = where(Posted=const(true),"Loan Product Type"=filter('ADVANCE'|'COMM 1'|'COMM 2'|'STL'));
            PrintOnlyIfDetail = false;
            RequestFilterFields = "Transacting Branch","Loan Product Type","Issued Date","Loan Status";
            column(ReportForNavId_4645; 4645)
            {
            }
            column(FORMAT_TODAY_0_4_;Format(Today,0,4))
            {
            }
            column(COMPANYNAME;COMPANYNAME)
            {
            }
            column(Company_Address;Company.Address)
            {
            }
            column(Company_Address2;Company."Address 2")
            {
            }
            column(Company_PhoneNo;Company."Phone No.")
            {
            }
            column(Company_Email;Company."E-Mail")
            {
            }
            column(Company_Picture;Company.Picture)
            {
            }
            column(CurrReport_PAGENO;CurrReport.PageNo)
            {
            }
            column(USERID;UserId)
            {
            }

            trigger OnAfterGetRecord()
            begin
                "Loans Register".CalcFields("Loans Register"."Outstanding Balance");
                LoanType.Get("Loans Register"."Loan Product Type");

                if "Loans Register"."Outstanding Balance" > 0 then begin
                    LineNo:=LineNo+10000;

                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name":='GENERAL';
                    GenJournalLine."Journal Batch Name":='INT DUE';
                    GenJournalLine."Line No.":=LineNo;
                    GenJournalLine."Account Type":=GenJournalLine."account type"::Customer;
                    GenJournalLine."Account No.":="Loans Register"."Client Code";
                    GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Deposit Contribution";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No.":=DocNo;
                    GenJournalLine."Posting Date":=PostDate;
                    GenJournalLine.Description:='Interest Due';
                    GenJournalLine.Amount:="Loans Register"."Loan Interest Repayment";
                    //GenJournalLine.Amount:=ROUND(Loans."Outstanding Balance"*(Loans.Interest/1200),0.05,'>');
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"G/L Account";
                    if LoanType.Get("Loans Register"."Loan Product Type") then
                    GenJournalLine."Bal. Account No.":=LoanType."Receivable Interest Account";
                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                    GenJournalLine."Loan No":="Loans Register"."Loan  No.";
                    if GenJournalLine.Amount<>0 then
                    GenJournalLine.Insert;

                end;
            end;

            trigger OnPostDataItem()
            begin
                //Post New
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name",'GENERAL');
                GenJournalLine.SetRange("Journal Batch Name",'INT DUE');
                if GenJournalLine.Find('-') then begin
                Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco",GenJournalLine);
                end;
                //Post New
            end;

            trigger OnPreDataItem()
            begin


                //delete journal line
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name",'GENERAL');
                GenJournalLine.SetRange("Journal Batch Name",'INT DUE');
                GenJournalLine.DeleteAll;
                //end of deletion

                GenBatches.Reset;
                GenBatches.SetRange(GenBatches."Journal Template Name",'GENERAL');
                GenBatches.SetRange(GenBatches.Name,'INT DUE');
                if GenBatches.Find('-') = false then begin
                GenBatches.Init;
                GenBatches."Journal Template Name":='GENERAL';
                GenBatches.Name:='INT DUE';
                GenBatches.Description:='Interest Due';
                GenBatches.Validate(GenBatches."Journal Template Name");
                GenBatches.Validate(GenBatches.Name);
                GenBatches.Insert;
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
                Company.CalcFields(Company.Picture);
    end;

    var
        Company: Record "Company Information";
        GenBatches: Record "Gen. Journal Batch";
        PDate: Date;
        LoanType: Record "Loan Products Setup";
        PostDate: Date;
        Cust: Record "Member Register";
        LineNo: Integer;
        DocNo: Code[20];
        GenJournalLine: Record "Gen. Journal Line";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
}

