#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516585 "Generate Monthly Interest-New"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Loans Register";"Loans Register")
        {
            CalcFields = "Outstanding Balance","Oustanding Interest";
            DataItemTableView = where("Issued Date"=filter(<>''),Posted=const(true),"Stop Interest Accrual"=const(false));
            RequestFilterFields = "Loan  No.","Loan Product Type","Client Code","Loan Disbursement Date";
            column(ReportForNavId_4645; 4645)
            {
            }

            trigger OnAfterGetRecord()
            var
                PayDateEndOfMonth: Integer;
                BillDateEndOfMonth: Integer;
            begin
                
                NoOfRecords:="Loans Register".Count;
                dWindow.Update(2,NoOfRecords);
                
                dWindow.Update(1,"Loans Register"."Client Name");
                CurrentRecordNo += 1;
                Exception:=false;
                
                /*Loans.RESET;
                Loans.SETRANGE("Loan  No.","Loans Register"."Loan  No.");
                Loans.SETFILTER("Outstanding Balance",'>0');
                IF Loans.FINDFIRST THEN BEGIN
                   Loans.CALCFIELDS(Loans."Interest Due Date");
                       //IF Loans."Interest Due Date"< CALCDATE('-CM',TODAY) THEN BEGIN
                
                        PayDate:=DATE2DMY(Loans."Issued Date",1);
                        PayDateEndOfMonth:=DATE2DMY(CALCDATE('CM',Loans."Issued Date"),1);
                        //PayDate:=DATE2DMY(Loans."Loan Disbursement Date",1);
                        IntDate:=DATE2DMY(BillDate,1);
                        BillDateEndOfMonth:=DATE2DMY(CALCDATE('CM',BillDate),1);
                
                        IF (PayDateEndOfMonth = PayDate) AND (BillDateEndOfMonth=IntDate) THEN
                        BEGIN
                            PayDate:=IntDate;
                        END; */
                
                
                if ProdFact.Get("Loans Register"."Loan Product Type") then begin
                  if "Loans Register".Interest<> ProdFact."Interest rate" then begin
                        "Loans Register".Interest := ProdFact."Interest rate";
                        "Loans Register".Modify;
                
                
                
                
                
                
                        //END;
                    //END;
                    if ProdFact."Repayment Method" = ProdFact."repayment method"::"Straight Line" then begin
                         if "Loans Register"."Interest Calculation Method" <> "Loans Register"."interest calculation method"::"Flat Rate" then begin
                                "Loans Register"."Interest Calculation Method" := "Loans Register"."interest calculation method"::"Flat Rate";
                               "Loans Register".Modify;
                                //COMMIT;
                            //END;
                        end
                        else begin
                
                            if "Loans Register"."Interest Calculation Method" <> "Loans Register"."interest calculation method"::"Reducing Balances" then begin
                               "Loans Register"."Interest Calculation Method" := "Loans Register"."interest calculation method"::"Reducing Balances";
                               "Loans Register".Modify;
                            end;
                        //END;
                    end;
                
                end;
                    // IF PayDate=IntDate THEN BEGIN
                       // MESSAGE(' PayDate01 %1|IntDate01 %2 ', PayDate,IntDate);
                            Periodic."GenerateLoanMonthlyInterest-New"("Loans Register"."Loan  No.",BillDate);
                
                
                     end;
                  end;
                //END;
                dWindow.Update(3,CurrentRecordNo);
                dWindow.Update(4,ROUND(CurrentRecordNo /  NoOfRecords * 10000,1));

            end;

            trigger OnPostDataItem()
            begin
                //dWindow.CLOSE;
                if Options = Options::"Generate & Post" then begin
                    InterestHeader.Reset;
                    InterestHeader.SetRange("No.",'INTEREST');
                    if InterestHeader.FindFirst then begin
                       Periodic.PostLoanInterest(InterestHeader);
                    end;
                end;
            end;

            trigger OnPreDataItem()
            begin


                dWindow.Open('Generating Interest:                #1#########\'
                                    +'Total Loans:                #2#########\'
                                    +'Counter:                    #3#########\'
                                    +'Progress:                   @4@@@@@@@@@\'
                                    +'Press Esc to abort');


                if BillDate=0D then
                   BillDate:=Today;

                CurrentDate:=CalcDate('-0D', BillDate);
                BillDate:=CalcDate('-CM',BillDate);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Billing Date";BillDate)
                {
                    ApplicationArea = Basic;
                }
                field(Options;Options)
                {
                    ApplicationArea = Basic;
                    Caption = 'Options';
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
        //Options:=Options::"Generate & Post
    end;

    var
        LoanType: Record "Loan Products Setup";
        Gnljnline: Record "Gen. Journal Line";
        LineNo: Integer;
        DocNo: Code[20];
        PDate: Date;
        LoansCaptionLbl: label 'Loans';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        VarienceCaptionLbl: label 'Varience';
        "Document No.": Code[20];
        RecBuffer: Record "Interest Header";
        RecBuffLines: Record "Loans Interest";
        LoanAmount: Decimal;
        CustMember: Record Vendor;
        Text001: label 'Document No. Must be equal to No.';
        CurrDate: Date;
        FirstMonthDate: Date;
        CurrMonth: Date;
        MidDate: Date;
        EndDate: Date;
        LastMonthDate: Date;
        FirstDay: Date;
        FirstDate: Date;
        RecBuffers: Record "Interest Header";
        LoansInterest: Record "Loans Interest";
        IntCharged: Decimal;
        Principle: Decimal;
        SuspendedInterestAccounts: Record "Suspended Interest Accounts";
        MonthDays: Integer;
        InterestDuePeriod: Record "Interest Due Period";
        dWindow: Dialog;
        CurrentRecordNo: Integer;
        NoOfRecords: Integer;
        Periodic: Codeunit "Periodic Activities";
        BillDate: Date;
        Exception: Boolean;
        ProdFact: Record "Loan Products Setup";
        Options: Option "Generate Only","Generate & Post";
        Loans: Record "Loans Register";
        PayDate: Integer;
        IntDate: Integer;
        InterestHeader: Record "Interest Header";
        CutOffDate: Date;
        LoanRepaymentSchedule: Record "Loan Repayment Schedule";
        CurrentDate: Date;
        LoanApps: Record "Loans Register";
        OutBalance: Decimal;
        CustLedger: Record "Member Ledger Entry";
        TranDescription: Text[100];
}

