#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516505 "Accrue Risk Fund"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Accrue Risk Fund.rdlc';

    dataset
    {
        dataitem("Member Register";"Member Register")
        {
            column(ReportForNavId_4645; 4645)
            {
            }
            column(FORMAT_TODAY_0_4_;Format(Today,0,4))
            {
            }
            column(COMPANYNAME;COMPANYNAME)
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

                 LineNo:=LineNo+10000;
                 GenSetup.Get();
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name":='General';
                    GenJournalLine."Journal Batch Name":='RiskDue';
                    GenJournalLine."Line No.":=LineNo;
                    GenJournalLine."Account Type":=GenJournalLine."account type"::Member;
                    GenJournalLine."Account No.":= "Member Register"."No.";
                    GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"44";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No.":=DocNo;
                    GenJournalLine."Posting Date":=PostDate;
                    GenJournalLine.Description:=DocNo+' '+'Risk Fund charged';
                    GenJournalLine.Amount:=GenSetup."Risk Fund Amount";
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if MemberPostingG.Get("Member Register"."Customer Posting Group") then begin
                    GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"G/L Account";
                    GenJournalLine."Bal. Account No.":=MemberPostingG."Risk Fund Charged Account";
                    end;
                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                    GenJournalLine."Shortcut Dimension 1 Code":='BOSA' ;
                    GenJournalLine."Shortcut Dimension 2 Code":= "Member Register"."Global Dimension 2 Code";
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    GenJournalLine."Loan No":= loanapp."Loan  No.";
                    if GenJournalLine.Amount<>0 then
                    GenJournalLine.Insert;






                //Post New
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name",'General');
                GenJournalLine.SetRange("Journal Batch Name",'RiskDue');
                if GenJournalLine.Find('-') then begin
                Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco",GenJournalLine);
                end;
                //Post New
            end;

            trigger OnPostDataItem()
            begin
                /*//Post New
                GenJournalLine.RESET;
                GenJournalLine.SETRANGE("Journal Template Name",Jtemplate);
                GenJournalLine.SETRANGE("Journal Batch Name",JBatch);
                IF GenJournalLine.FIND('-') THEN BEGIN
                CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post B",GenJournalLine);
                END;
                //Post New */

            end;

            trigger OnPreDataItem()
            begin
                if PostDate = 0D then
                Error('Please create Interest period');

                if DocNo = '' then
                Error('You must specify the Document No.');


                //delete journal line
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name",'General');
                GenJournalLine.SetRange("Journal Batch Name",'RiskDue');
                GenJournalLine.DeleteAll;
                //end of deletion

                GenBatches.Reset;
                GenBatches.SetRange(GenBatches."Journal Template Name",'General');
                GenBatches.SetRange(GenBatches.Name,'RiskDue');
                if GenBatches.Find('-') = false then begin
                GenBatches.Init;
                GenBatches."Journal Template Name":='General';
                GenBatches.Name:='RiskDue';
                GenBatches.Description:='Interest Due';
                //GenBatches.VALIDATE(GenBatches."Journal Template Name");
                //GenBatches.VALIDATE(GenBatches.Name);
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
                field(PostDate;PostDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Posting Date';
                }
                field(DocNo;DocNo)
                {
                    ApplicationArea = Basic;
                    Caption = 'Document No.';
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
        //Accounting periods
        //AccountingPeriod.SETRANGE(AccountingPeriod.Closed,FALSE);
        if AccountingPeriod.Find('-') then begin
          FiscalYearStartDate:= AccountingPeriod."Interest Calcuation Date";
          PostDate:=(FiscalYearStartDate);
          DocNo:= AccountingPeriod.Name+'  '+ Format(PostDate);
        end;
        //Accounting periods
    end;

    var
        GenBatches: Record "Gen. Journal Batch";
        PDate: Date;
        LoanType: Record "Loan Products Setup";
        PostDate: Date;
        Cust: Record "Member Register";
        LineNo: Integer;
        DocNo: Code[20];
        GenJournalLine: Record "Gen. Journal Line";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        EndDate: Date;
        DontCharge: Boolean;
        Temp: Record "Funds General Setup";
        JBatch: Code[10];
        Jtemplate: Code[10];
        CustLedger: Record "Member Ledger Entry";
        AccountingPeriod: Record "Interest Due Period";
        FiscalYearStartDate: Date;
        "ExtDocNo.": Text[30];
        Loan_Application_FormCaptionLbl: label 'Loan Application Form';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        loanapp: Record "Loans Register";
        SDATE: Text[30];
        GenSetup: Record "Sacco General Set-Up";
        MemberPostingG: Record "Customer Posting Group";
}

