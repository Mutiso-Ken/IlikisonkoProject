#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516546 "Process Loan Monthly Penalty"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Process Loan Monthly Penalty.rdlc';

    dataset
    {
        dataitem("Loans Register";"Loans Register")
        {
            CalcFields = "Outstanding Balance";
            DataItemTableView = where("Loan Product Type"=filter(<>'HISTORICAL'));
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
            column(CapturedBy_LoansRegister;"Loans Register"."Captured By")
            {
            }

            trigger OnAfterGetRecord()
            var
                BalanceAsPerSchedule: Decimal;
            begin
                if FnCheckIfMemberIsblocked("Loans Register"."Client Code") then
                  CurrReport.Skip;
                  if "Loans Register".Source<>"Loans Register".Source::FOSA then begin

                  PDate:="Loans Register".GetRangemax("Loans Register"."Date filter");
                  //IF PDate<TODAY THEN
                    PDate:=Today;
                  SDATE:='..'+Format(PDate);
                 loanapp.Reset;
                 loanapp.SetRange(loanapp."Loan  No.","Loan  No.");
                 loanapp.SetRange(loanapp."Exempt From Interest",false);
                 //loanapp.SETFILTER(loanapp."Oustanding Interest",'>%1',0);
                 loanapp.SetFilter(loanapp.Arears,'>%1',0);
                 //loanapp.SETFILTER(loanapp."Loan Product Type",'<>%1|%2|%3','FUNDS','ADVANCE','SHORTTERM');
                 loanapp.SetFilter(loanapp."Date filter",SDATE);
                 if loanapp.Find('-') then begin

                 //MESSAGE('dfcgvbn%1',loanapp."Loan  No.");
                 loanapp.CalcFields(loanapp."Outstanding Balance");
                 loanapp.CalcFields(loanapp."Oustanding Interest");
                 loanapp.CalcFields(loanapp."Schedule Interest to Date");
                 loanapp.CalcFields(loanapp."Scheduled Principal to Date");
                 loanapp.CalcFields(loanapp."Schedule Repayments");
                 loanapp.CalcFields(loanapp."Total Schedule Repayment");
                 loanapp.CalcFields(loanapp."Penalty Charged");
                 //loanapp.CALCFIELDS(loanapp.Penalty);
                 Balance:=0;
                 //Balance:=loanapp.Arears+loanapp."Oustanding Interest"+loanapp."Penalty Charged";//loanapp.Penalty;
                 Balance:=loanapp.Arears+loanapp."Oustanding Interest";
                 //MESSAGE('arr %1| intre %2| Pen %3',loanapp.Arears,loanapp."Oustanding Interest",loanapp."Penalty Charged");
                // IF loanapp."Loan  No."='LN0004808' THEN  ERROR('%1 %2',FnGetLoanArrears(loanapp."Loan  No.",SDATE),Balance);;//ERROR('%1 %2',Balance,loanapp.Penalty);

                 //BalanceAsPerSchedule:=loanapp."Total Schedule Repayment"-(loanapp."Schedule Interest to Date"+loanapp."Scheduled Principal to Date");
                 //IF loanapp."Repayment Method"=loanapp."Repayment Method"::"Straight Line" THEN
                 //Balance:=loanapp."Approved Amount";
                 if (Balance > 0) and (FnGetLoanArrears(loanapp."Loan  No.",SDATE) < 0) then begin
                   if (FnLoanInterestExempted(loanapp."Loan  No.")=false) then begin

                    LineNo:=LineNo+10000;
                    GenJournalLine.Init;
                    GenJournalLine."Journal Template Name":='General';
                    GenJournalLine."Journal Batch Name":='PENALTYDUE';
                    GenJournalLine."Line No.":=LineNo;
                    GenJournalLine."Account Type":=GenJournalLine."account type"::Member;
                    GenJournalLine."Account No.":= loanapp."Client Code";
                    GenJournalLine."Transaction Type":=GenJournalLine."transaction type"::"Penalty Charged";
                    GenJournalLine."Source Type" := GenJournalLine."source type"::Member;
                    GenJournalLine.Validate(GenJournalLine."Account No.");
                    GenJournalLine."Document No.":=DocNo;
                    GenJournalLine."Posting Date":=PostDate;
                    GenJournalLine.Description:=DocNo+' '+'Penalty charged';
                    GenJournalLine.Amount:=ROUND(Balance*(FnProductInterestRate(loanapp."Loan Product Type")/100),0.05);
                    //MESSAGE('loanapp."Repayment Method" is %1',loanapp."Repayment Method");
                    if loanapp."Loan Product Type"='151' then    GenJournalLine.Amount:=ROUND(Balance*(FnProductInterestRate(loanapp."Loan Product Type")/1200),0.05,'>');
                    GenJournalLine.Validate(GenJournalLine.Amount);
                    if LoanType.Get(loanapp."Loan Product Type") then begin
                    GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"G/L Account";
                    GenJournalLine."Bal. Account No.":=LoanType."Penalty Paid Account";
                    end;
                     GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                    GenJournalLine."Shortcut Dimension 2 Code":=loanapp."Branch Code";
                    GenJournalLine."Shortcut Dimension 1 Code":=FnProductSource(loanapp."Loan Product Type");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                    GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                    GenJournalLine."Loan No":= loanapp."Loan  No.";
                    if GenJournalLine.Amount<>0 then
                    GenJournalLine.Insert;


                 end;
                 end;
                 end;
                 end;
            end;

            trigger OnPreDataItem()
            begin
                if PostDate = 0D then
                   PostDate:=Today;
                //ERROR('Please create Interest period');

                if DocNo = '' then
                   DocNo:=Text00;
                //ERROR('You must specify the Document No.');


                //delete journal line
                GenJournalLine.Reset;
                GenJournalLine.SetRange("Journal Template Name",'General');
                GenJournalLine.SetRange("Journal Batch Name",'PENALTYDUE');
                GenJournalLine.DeleteAll;
                //end of deletion

                GenBatches.Reset;
                GenBatches.SetRange(GenBatches."Journal Template Name",'General');
                GenBatches.SetRange(GenBatches.Name,'PENALTYDUE');
                if GenBatches.Find('-') = false then begin
                GenBatches.Init;
                GenBatches."Journal Template Name":='General';
                GenBatches.Name:='PENALTYDUE';
                GenBatches.Description:='Penalty Due';
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
        Balance: Decimal;
        Loans: Record "Loans Register";
        Text00: label 'Penalty Charged';

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
            Source:='MICRO';
          end;
          exit(Source);
    end;

    local procedure FnLoanInterestExempted(LoanNo: Code[50]) Found: Boolean
    var
        ObjExemptedLoans: Record "Loan Repay Schedule-Calc";
    begin
        /*ObjExemptedLoans.RESET;
        ObjExemptedLoans.SETRANGE(ObjExemptedLoans."Loan No.",LoanNo);
        IF ObjExemptedLoans.FIND('-') THEN BEGIN
          Found:=TRUE;
          END;
          EXIT(Found);*/

    end;

    local procedure FnProductInterestRate(Product: Code[50]) InterestRate: Decimal
    var
        ObjProducts: Record "Loan Products Setup";
    begin
        ObjProducts.Reset;
        ObjProducts.SetRange(ObjProducts.Code,Product);
        if ObjProducts.Find('-') then begin
          InterestRate:=ObjProducts."Penalty Percentage";
          end;
          exit(InterestRate);
    end;

    local procedure FnGetLoanArrears(varLoanNo: Code[20];varSdate: Text) Arrears: Decimal
    var
        RepaymentPeriod: Date;
        LastMonth: Date;
        LSchedule: Record "Loan Repayment Schedule";
        ScheduledLoanBal: Decimal;
        LBal: Decimal;
    begin
        RepaymentPeriod:=PDate;


        Loans.Reset;
        Loans.SetRange(Loans."Loan  No.",varLoanNo);
        if Loans.Find('-') then begin

        Loans.CalcFields(Loans."Outstanding Balance",Loans."Oustanding Interest",Loans."Penalty Charged");
        varLoanNo:=Loans."Loan  No.";

        //Get Last Day of the previous month
        if Loans."Repayment Frequency"=Loans."repayment frequency"::Monthly then begin
          if RepaymentPeriod=CalcDate('CM',RepaymentPeriod) then begin
                LastMonth:=RepaymentPeriod;
              end else begin
                LastMonth:=CalcDate('0M',RepaymentPeriod);
              end;
            LastMonth:=CalcDate('CM',LastMonth);
         end;
        //End Get Last Day of the previous month

        //Get Scheduled Balance
          LSchedule.Reset;
          LSchedule.SetRange(LSchedule."Loan No.",Loans."Loan  No.");
          LSchedule.SetRange(LSchedule."Repayment Date",LastMonth);
            if LSchedule.FindFirst then begin
              //MESSAGE('loan %1',Loans."Loan  No.");
              ScheduledLoanBal:=LSchedule."Loan Balance";
              //MESSAGE('Balance %1',ScheduledLoanBal);
            end;
        //End Get Scheduled Balance


        //Get Loan Bal as per the date filter
          //DateFilter:=varSdate;//'..'+FORMAT(LastMonth);
          Loans.SetFilter(Loans."Date filter",varSdate);
              Loans.CalcFields(Loans."Outstanding Balance");
              LBal:=Loans."Outstanding Balance";
        //End Get Loan Bal as per the date filter
         LBal:=Loans."Outstanding Balance";
         //MESSAGE('newbal %1',LBal);


          //Amount in Arrears
          Arrears:=ScheduledLoanBal-LBal;
          //MESSAGE('arrer %1',Arrears);
          if (Arrears>0) or (Arrears=0) then begin
            //IF Arrears>0 THEN BEGIN
          Arrears:=0
          end else
          Arrears:=Arrears;
          //End Amount in Arrears
          exit(Arrears);
        end;
        //Loans.MODIFY;
    end;

    local procedure FnCheckIfMemberIsblocked("Client Code": Code[20]): Boolean
    var
        Memb: Record "Member Register";
    begin
        if Memb.Get("Client Code") then begin
          if Memb.Blocked=Memb.Blocked::All then
            exit(true)
            else
            exit(false)
          end;
    end;
}

