#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516938 "Process Loan Monthly Insurance"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Process Loan Monthly Insurance.rdlc';

    dataset
    {
        dataitem("Loans Register";"Loans Register")
        {
            CalcFields = "Outstanding Balance";
            DataItemTableView = where("Loan Product Type"=filter(<>'FL354'),"Loan Product Type"=filter(<>'FL358'),"Loan Product Type"=filter(<>'FL353'),"Loan Product Type"=filter(<>'FL364'));
            RequestFilterFields = "Issued Date","Date filter",Source,"Loan  No.","Client Code","Account No","Loan Product Type","Oustanding Interest","Interest Due","Interest Paid","Repayment Start Date";
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
            column(Loans__Loan__No__;"Loan  No.")
            {
            }
            column(Loans__Application_Date_;"Application Date")
            {
            }
            column(Loans__Loan_Product_Type_;"Loan Product Type")
            {
            }
            column(Loans__Client_Code_;"Client Code")
            {
            }
            column(Loans__Client_Name_;"Client Name")
            {
            }
            column(Loans__Outstanding_Balance_;"Outstanding Balance")
            {
            }
            column(Loan_Application_FormCaption;Loan_Application_FormCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption;CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Loans__Loan__No__Caption;FieldCaption("Loan  No."))
            {
            }
            column(Loans__Application_Date_Caption;FieldCaption("Application Date"))
            {
            }
            column(Loans__Loan_Product_Type_Caption;FieldCaption("Loan Product Type"))
            {
            }
            column(Loans__Client_Code_Caption;FieldCaption("Client Code"))
            {
            }
            column(Loans__Client_Name_Caption;FieldCaption("Client Name"))
            {
            }
            column(Loans__Outstanding_Balance_Caption;FieldCaption("Outstanding Balance"))
            {
            }

            trigger OnAfterGetRecord()
            begin
                  PDate:="Loans Register".GetRangemax("Loans Register"."Date filter");
                  SDATE:='..'+Format(PDate);
                 loanapp.Reset;
                 loanapp.SetRange(loanapp."Loan  No.","Loan  No.");
                 loanapp.SetFilter(loanapp."Outstanding Balance",'>%1',0);
                 loanapp.SetFilter(loanapp."Date filter",SDATE);
                // loanapp.SETFILTER(loanapp."Loan Product Type",'%1&<>%2&<>%3&<>%4','FL353','FL354','FL358','FL364');
                 if loanapp.Find('-') then begin
                 loanapp.CalcFields(loanapp."Outstanding Balance");
                 if loanapp."Outstanding Balance" > 0 then begin
                   if (loanapp."Loan Product Type"<>'FL353') and (loanapp."Loan Product Type"<>'FL354') and (loanapp."Loan Product Type"<>'FL358') and (loanapp."Loan Product Type"<>'FL364') then begin
                
                 LineNo:=LineNo+10000;
                
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name":='General';
                    GenJournalLine."Journal Batch Name":='INSURANCEDUE';
                    GenJournalLine."Line No.":=LineNo;
                    GenJournalLine."Account Type":=GenJournalLine."account type"::Investor;
                    GenJournalLine."Account No.":= loanapp."Client Code";
                    GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Loan Insurance Paid";
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No.":=DocNo;
                    GenJournalLine."Posting Date":=PostDate;
                    GenJournalLine.Description:=DocNo+' '+'Insurance charged';
                    GenJournalLine.Amount:=ROUND( loanapp."Outstanding Balance"*( loanapp.Insurance/1200),1,'>');
                    if loanapp."Repayment Method"=loanapp."repayment method"::"Straight Line" then
                     GenJournalLine.Amount:=ROUND(loanapp."Approved Amount"*( loanapp.Insurance/1200),1,'>');
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if LoanType.Get(loanapp."Loan Product Type") then begin
                    GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"G/L Account";
                    GenJournalLine."Bal. Account No.":=LoanType."Loan Insurance Accounts";
                    GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                    end;
                    if  loanapp.Source= loanapp.Source::" " then begin
                   // GenJournalLine."Shortcut Dimension 1 Code":=FnProductSource(Product : Code[50]);'BOSA' ;
                    GenJournalLine."Shortcut Dimension 2 Code":= loanapp."Branch Code";
                    end;
                    if  loanapp.Source= loanapp.Source::BOSA then begin
                   // GenJournalLine."Shortcut Dimension 1 Code":='FOSA' ;
                    GenJournalLine."Shortcut Dimension 2 Code":=loanapp."Branch Code";
                    end;
                    GenJournalLine."Shortcut Dimension 1 Code":=FnProductSource(loanapp."Loan Product Type");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    GenJournalLine."Loan No":= loanapp."Loan  No.";
                    if GenJournalLine.Amount<>0 then
                    GenJournalLine.Insert;
                
                
                 end;
                 end;
                 end;
                
                
                /*
                //Post New
                GenJournalLine.RESET;
                GenJournalLine.SETRANGE("Journal Template Name",'General');
                GenJournalLine.SETRANGE("Journal Batch Name",'INT DUE');
                IF GenJournalLine.FIND('-') THEN BEGIN
                CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post B",GenJournalLine);
                END; */
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
                GenJournalLine.SetRange("Journal Batch Name",'INSURANCEDUE');
                GenJournalLine.DeleteAll;
                //end of deletion

                GenBatches.Reset;
                GenBatches.SetRange(GenBatches."Journal Template Name",'General');
                GenBatches.SetRange(GenBatches.Name,'INSURANCEDUE');
                if GenBatches.Find('-') = false then begin
                GenBatches.Init;
                GenBatches."Journal Template Name":='General';
                GenBatches.Name:='INSURANCEDUE';
                GenBatches.Description:='Loan Insurance';
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
        AccountingPeriod.SetRange(AccountingPeriod.Closed,false);
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

    local procedure FnProductSource(Product: Code[50]) Source: Code[50]
    var
        ObjProducts: Record "Loan Products Setup";
    begin
        ObjProducts.Reset;
        ObjProducts.SetRange(ObjProducts.Code,Product);
        if ObjProducts.Find('-') then begin
          if ObjProducts.Source=ObjProducts.Source::BOSA then
            Source:='BOSA'
          else
            Source:='FOSA';
          end;
          exit(Source);
    end;
}

