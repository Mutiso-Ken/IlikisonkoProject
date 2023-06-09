#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516850 "Micro Finance Schedule"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Micro Finance Schedule.rdlc';

    dataset
    {
        dataitem(Micro_Fin_Transactions;Micro_Fin_Transactions)
        {
            column(ReportForNavId_1000000005; 1000000005)
            {
            }
            column(GroupName_MicroFinTransactions;Micro_Fin_Transactions."Group Name")
            {
            }
            column(GroupCode_MicroFinTransactions;Micro_Fin_Transactions."Group Code")
            {
            }
            column(MicroOfficer_MicroFinTransactions;Micro_Fin_Transactions."Micro Officer")
            {
            }
            column(GroupMeetingDay_MicroFinTransactions;Micro_Fin_Transactions."Group Meeting Day")
            {
            }
            dataitem(Micro_Fin_Schedule;Micro_Fin_Schedule)
            {
                DataItemLink = "No."=field("No.");
                column(ReportForNavId_1102755000; 1102755000)
                {
                }
                column(Account_No;Micro_Fin_Schedule."Account Number")
                {
                }
                column(Account_Name;Micro_Fin_Schedule."Account Name")
                {
                }
                column(Loan_No;Micro_Fin_Schedule."Loan No.")
                {
                }
                column(Expected_Principle;Micro_Fin_Schedule."Expected Principle Amount")
                {
                }
                column(Expected_Interest;Micro_Fin_Schedule."Expected Interest")
                {
                }
                column(Savings;Micro_Fin_Schedule.Savings)
                {
                }
                column(Loan_Balance;ToustLoan)
                {
                }
                column(Group_Name;GrpName)
                {
                }
                column(Group_Code;Micro_Fin_Schedule."Group Code")
                {
                }
                column(Company_Name;CompanyInfo.Name)
                {
                }
                column(Company_Picture;CompanyInfo.Picture)
                {
                }
                column(Company_Address;CompanyInfo.Address)
                {
                }
                column(Company_phone;CompanyInfo."Phone No.")
                {
                }
                column(FORMAT_TODAY_0_4_;Format(Today,0,4))
                {
                }
                column(CurrReport_PAGENO;CurrReport.PageNo)
                {
                }
                column(USERID;UserId)
                {
                }
                column(CEEPOfficer;CEEPOfficer)
                {
                }
                column(MeetingDate;MeetingDate)
                {
                }
                column(ReceiptNo;ReceiptNo)
                {
                }
                column(DepositsContribution_MicroFinSchedule;Micro_Fin_Schedule."Deposits Contribution")
                {
                }
                column(AmountReceived_MicroFinSchedule;Micro_Fin_Schedule."Amount Received")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    
                    
                     GroupMembers.Reset;
                     GroupMembers.SetRange(GroupMembers."Group Code","Group Code");
                     if GroupMembers.Find('-') then begin
                    
                     GroupMembers.CalcFields(GroupMembers."Balance (LCY)");
                    SAVINGS2:=GroupMembers."Balance (LCY)";
                    
                     end;
                    
                    
                    "Outstanding Loan" :=0;
                    ToustLoan :=0;
                    
                    vend.Reset;
                    vend.SetRange(vend."No.",Micro_Fin_Schedule."Account Number");
                    if vend.Find('-') then begin
                    
                    if vend.Blocked=vend.Blocked::All then begin
                    CurrReport.Skip;
                    end;
                    
                    vend.CalcFields(vend."Balance (LCY)");
                    //Saving:=vend."Balance (LCY)";
                    //Tsavings:=Tsavings+Saving;
                    end;
                    
                    
                    LoanApplic.Reset;
                    LoanApplic.SetRange(LoanApplic."Client Code",Micro_Fin_Schedule."Account Number");
                    LoanApplic.SetRange(LoanApplic.Source,LoanApplic.Source::MICRO);
                    if LoanApplic.Find('-') then begin
                    repeat
                    LoanApplic.CalcFields(LoanApplic."Outstanding Balance",LoanApplic."Oustanding Interest");
                    if LoanApplic."Outstanding Balance"<> 0 then begin
                    "Outstanding Loan":=LoanApplic."Outstanding Balance";//+LoanApplic."Oustanding Interest";
                    ToustLoan:=ToustLoan+"Outstanding Loan";
                    end;
                    until LoanApplic.Next =0;
                    end;
                    Tsaving:=Tsaving+Saving;
                    
                    
                    
                    //Get group name
                    Grps.Reset;
                    if Grps.Get(Micro_Fin_Schedule."Group Code") then
                    GrpName:=Grps."Business Loan Officer";
                    CEEPOfficer:=Grps."BOSA Account No.";
                    
                    //get meeting date
                    /*Transactions.RESET;
                    IF Transactions.GET(Micro_Fin_Schedule."Group Code") THEN
                      MeetingDate:=Transactions."Group Meeting Day";
                      ReceiptNo:=Transactions."No.";*/
                    
                    Transactions.Reset;
                    Transactions.SetRange(Transactions."No.",Micro_Fin_Schedule."No.");
                    if Transactions.Find('-')then begin
                    MeetingDate:=Transactions."Group Meeting Day";
                      ReceiptNo:=Transactions."No.";
                    
                    end;

                end;

                trigger OnPreDataItem()
                begin
                     LastFieldNo := FieldNo("No.");

                     CompanyInfo.Get();
                     CompanyInfo.CalcFields(CompanyInfo.Picture);
                end;
            }
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
        "Outstanding Loan": Decimal;
        Saving: Decimal;
        LoanApplic: Record "Loans Register";
        vend: Record Vendor;
        Tsaving: Decimal;
        ToustLoan: Decimal;
        Tsavings: Decimal;
        GrpName: Text[100];
        Grps: Record "Member Register";
        Loans: Record "Loans Register";
        Outbal: Decimal;
        OutInt: Decimal;
        MicroSubform: Record Micro_Fin_Schedule;
        GroupMembers: Record Vendor;
        SAVINGS2: Decimal;
        CompanyInfo: Record "Company Information";
        CEEPOfficer: Text;
        CEEPOfficerDetails: Record "Loan Officers Details";
        MeetingDate: Date;
        Transactions: Record Micro_Fin_Transactions;
        ReceiptNo: Code[30];
}

