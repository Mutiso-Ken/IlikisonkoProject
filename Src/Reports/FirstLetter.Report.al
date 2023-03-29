#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516925 "First Letter"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/First Letter.rdlc';

    dataset
    {
        dataitem(LoansREC; "Loans Register")
        {
            RequestFilterFields = "Loan  No.", "Last Pay Date", "Client Code";
            column(ReportForNavId_1102755000; 1102755000)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(CompanyName; CompanyInformation.Name)
            {
            }
            column(CompanyAddress; CompanyInformation.Address)
            {
            }
            column(Address2; CompanyInformation."Address 2")
            {
            }
            column(PostCode; CompanyInformation."Post Code")
            {
            }
            column(City; CompanyInformation.City)
            {
            }
            column(Country; CompanyInformation."Country/Region Code")
            {
            }
            column(CompanyPhoneNo; CompanyInformation."Phone No.")
            {
            }
            column(CompanyFaxNo; CompanyInformation."Fax No.")
            {
            }
            column(E_mail; CompanyInformation."E-Mail")
            {
            }
            column(CPic; CompanyInformation.Picture)
            {
            }
            column(Staff_No; Customer."Personal No")
            {
            }
            column(MNo; Customer."No.")
            {
            }
            column(Name; Customer.Name)
            {
            }
            column(Address; Customer.Address)
            {
            }
            column(CustCity; Customer.City)
            {
            }
            column(LoanDisbursementDate_LoansREC; Format(LoansREC."Loan Disbursement Date"))
            {
            }
            column(LoanProductType_LoansREC; LoansREC."Loan Product Type")
            {
            }
            column(ApprovedAmount_LoansREC; LoansREC."Approved Amount")
            {
            }
            column(ExpectedDateofCompletion_LoansREC; Format(LoansREC."Expected Date of Completion"))
            {
            }
            column(Interest_LoansREC; LoansREC.Interest)
            {
            }
            column(Loan_Type; LoansR."Loan Product Type")
            {
            }
            column(LBalance1; LBalance1)
            {
            }
            column(Loan_No; LoansREC."Loan  No.")
            {
            }
            column(Loan_Product_type; LoansREC."Loan Product Type")
            {
            }
            column(Outstanding_Bal; Lbal)
            {
            }
            column(Interest_Due; INTBAL)
            {
            }
            column(Penalty; COMM)
            {
            }
            column(LastPDate; LastPayDate)
            {
            }
            column(Total_Amount; Lbal + INTBAL + COMM)
            {
            }
            column(VarSecurityUsed; VarSecurityUsed)
            {
            }
            column(VarAmountinArrears; VarAmountinArrears)
            {
            }
            column(LoanProductTypeName_LoansREC; LoansREC."Loan Product Type Name")
            {
            }
            column(VarPenaltyPercentage; VarPenaltyPercentage)
            {
            }
            column(Installments_LoansREC; LoansREC.Installments)
            {
            }
            column(recoverNoticedate; recoverNoticedate)
            {
            }
            column(RemainingPeriod; RemainingPeriod)
            {
            }
            dataitem(Customer; "Member Register")
            {
                DataItemLink = "No." = field("Client Code");
                RequestFilterFields = "No.";
                column(ReportForNavId_1102755005; 1102755005)
                {
                }
                column(DearM; DearM)
                {
                }

                trigger OnAfterGetRecord()
                var
                    workString: Text[50];
                begin
                    workString := ConvertStr(Customer.Name, ' ', ',');
                    DearM := SelectStr(1, workString);
                    LastPDate := 0D;
                    Balance := 0;
                    SharesB := 0;

                    if SendSMS = true then begin
                        //SMS MESSAGE
                        SMSMessage.Reset;
                        if SMSMessage.Find('+') then begin
                            iEntryNo := SMSMessage."Entry No";
                            iEntryNo := iEntryNo + 1;
                        end
                        else begin
                            iEntryNo := 1;
                        end;

                        SMSMessage.Reset;
                        SMSMessage.Init;
                        SMSMessage."Entry No" := iEntryNo;
                        SMSMessage."Account No" := Loans."Client Code";
                        SMSMessage."Date Entered" := Today;
                        SMSMessage."Time Entered" := Time;
                        SMSMessage.Source := 'LOAN DEF1';
                        SMSMessage."Entered By" := UserId;
                        SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
                        SMSMessage."SMS Message" := 'We note with concern that we have not received your two month installments. Ensure payment today or tomorrow to avoid embarrassments. Thanks.';
                        Cust.Reset;
                        if Cust.Get(Loans."Client Code") then
                            SMSMessage."Telephone No" := Cust."Phone No.";
                        SMSMessage.Insert;

                    end;

                    /*
                    SharesAlllocated:=(LBalance/(Customer."Oustanding Balance"+Customer."Reason for Withdrawal"))*("Current Shares"*-1);
                    ABFAllocated:=(LBalance/(Customer."Oustanding Balance"+Customer."Reason for Withdrawal"))*(Customer."Insurance Fund"*-0.5);
                    
                    SharesB:=SharesAlllocated+ABFAllocated;
                    
                    TotalRec:=ROUND(LBalance-SharesB,1,'>');
                    
                    IF TotalRec < 0 THEN
                    TotalRec:=0;
                    AmountT:=ROUND((TotalRec/NoGuarantors),0.05,'>');
                    
                    LoansR.RESET;
                    LoansR.SETRANGE(LoansR."Client Code",Customer."No.");
                    LoansR.SETRANGE(LoansR.Posted,TRUE);
                    IF LoansR.FIND('-') THEN BEGIN
                    REPEAT
                    IF LoansR."Last Pay Date" = 0D THEN BEGIN
                    IF LastPDate < LoansR."Issued Date" THEN
                    LastPDate:=LoansR."Issued Date"
                    END ELSE BEGIN
                    IF LastPDate < LoansR."Last Pay Date" THEN
                    LastPDate:=LoansR."Last Pay Date";
                    END;
                    
                    UNTIL LoansR.NEXT = 0;
                    END;
                    */

                end;
            }
            dataitem(Loans; "Loans Register")
            {
                DataItemLink = "Loan  No." = field("Loan  No.");
                DataItemTableView = where("Outstanding Balance" = filter(> 0));
                column(ReportForNavId_1000000008; 1000000008)
                {
                }
            }
            dataitem("Loan Guarantors"; "Loans Guarantee Details")
            {
                DataItemLink = "Loan No" = field("Loan  No.");
                DataItemTableView = where(Substituted = filter(false));
                column(ReportForNavId_1000000003; 1000000003)
                {
                }
                column(Member_No; LoanGuar."Member No")
                {
                }
                column(NameG; LoanGuar.Name)
                {
                }
                column(Name_LoanGuarantors; "Loan Guarantors".Name)
                {
                }
                column(Personal_No; LoanGuar."Staff/Payroll No.")
                {
                }
                column(intcount; intcount)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    PersonalNo := '';
                    GAddress := '';

                    if Cust.Get("Loan Guarantors"."Member No") then begin
                        PersonalNo := Cust."Personal No";
                        GAddress := Cust.Address + ' ' + Cust."Address 2" + ' ' + Cust.City;


                        if SendSMS = true then begin
                            //SMS MESSAGE
                            SMSMessage.Reset;
                            if SMSMessage.Find('+') then begin
                                iEntryNo := SMSMessage."Entry No";
                                iEntryNo := iEntryNo + 1;
                            end
                            else begin
                                iEntryNo := 1;
                            end;

                            SMSMessage.Reset;
                            SMSMessage.Init;
                            SMSMessage."Entry No" := iEntryNo;
                            SMSMessage."Account No" := "Loan Guarantors"."Member No";
                            SMSMessage."Date Entered" := Today;
                            SMSMessage."Time Entered" := Time;
                            SMSMessage.Source := 'LOAN DEF1';
                            SMSMessage."Entered By" := UserId;
                            SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
                            SMSMessage."SMS Message" := 'Please note that the loan you guaranteed Mr. '
                            + LoansREC."Client Name" + ' has been defaulted. If this continues, it will be costly on you. We therefore request that you cause the arrears to be paid to avoid any inconveniences/loss on your part. Thanks.';
                            Cust1.Reset;
                            if Cust1.Get("Loan Guarantors"."Member No") then
                                SMSMessage."Telephone No" := Cust1."Phone No.";
                            SMSMessage.Insert;
                        end;
                    end;




                    LoanGuar.Reset;
                    LoanGuar.SetRange(LoanGuar."Loan No", Loans."Loan  No.");
                    if LoanGuar.Find('-') then begin
                        LoanGuar.Reset;
                        LoanGuar.SetRange(LoanGuar."Loan No", Loans."Loan  No.");

                        repeat
                            TGrAmount := TGrAmount + GrAmount;
                            GrAmount := LoanGuar."Amont Guaranteed";
                            //LoanGuar."Amount Guarnted";
                            FGrAmount := TGrAmount + LoanGuar."Amont Guaranteed";
                        //Amount2:=(GrAmount/FGrAmount)*(Lbal+INTBAL+COMM);

                        until LoanGuar.Next = 0;
                    end;
                    //Defaulter loan clear
                    Loans.CalcFields(Loans."Outstanding Balance", Loans."Interest Due");
                    Lbal := ROUND(Loans."Outstanding Balance", 0.5, '=');
                    INTBAL := Loans."Interest Due";
                    COMM := Loans."Interest Due" * 0.5;
                    //MESSAGE('BALANCE %1',Lbal);

                    //commisision


                    LoanGuar.Reset;
                    LoanGuar.SetRange(LoanGuar."Loan No", Loans."Loan  No.");
                    if LoanGuar.Find('-') then begin
                        LoanGuar.Reset;
                        LoanGuar.SetRange(LoanGuar."Loan No", Loans."Loan  No.");
                        //DLN:='DLN';

                        repeat
                            GenSetUp.Get();
                            GenSetUp."Defaulter LN" := GenSetUp."Defaulter LN" + 10;
                            GenSetUp.Modify;
                            //DLN:='DLN'+FORMAT(GenSetUp."Defaulter LN");

                            //GrAmount:=LoanGuar."Amount Guarnted";

                            //FGrAmount:=FGrAmount+LoanGuar."Amount Guarnted";
                            //LoanGuar."Amount Guarnted";
                            //TGrAmount:=TGrAmount+GrAmount;
                            //Amount2:=(GrAmount/FGrAmount)*(Lbal+INTBAL+COMM);
                            //MESSAGE('guarnteed Amount %1',FGrAmount);

                            //REPEAT
                            ////Insert jnl lines

                            Cust.Reset;
                            Cust.SetRange(Cust."No.", LoanGuar."Member No");
                            if Cust.Find('-') then begin
                                Loans."Client Name" := Cust.Name;
                            end;


                        until LoanGuar.Next = 0;



                    end;
                end;

                trigger OnPreDataItem()
                begin
                    intcount := intcount + 1;

                    TGrAmount := 0;
                    GrAmount := 0;
                    FGrAmount := 0;
                    Amount2 := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                RemainingPeriod := LoansREC.Installments - ObjSurestepFactory.KnGetCurrentPeriodForLoan(LoansREC."Loan  No.");
                recoverNoticedate := CalcDate('1M', Today);
                MemberLedgerEntry.Reset;
                MemberLedgerEntry.SetRange("Loan No", LoansREC."Loan  No.");
                if MemberLedgerEntry.FindLast() then begin
                    if (MemberLedgerEntry."Transaction Type" = MemberLedgerEntry."transaction type"::"Loan Repayment") or
                      (MemberLedgerEntry."Transaction Type" = MemberLedgerEntry."transaction type"::"Interest Paid") then
                        LastPayDate := MemberLedgerEntry."Posting Date";
                end;
                if LastPayDate = 0D then
                    LastPayDate := LoansREC."Issued Date";
                LoansREC.CalcFields(LoansREC."Outstanding Balance", LoansREC."Oustanding Interest", LoansREC."No. Of Guarantors");
                NoGuarantors := LoansREC."No. Of Guarantors";
                if NoGuarantors = 0 then
                    NoGuarantors := 1;
                LBalance := LoansREC."Outstanding Balance" + LoansREC."Oustanding Interest";
                LBalance1 := LoansREC."Outstanding Balance";
                Notified := true;
                //LoansREC."Notified date":=TODAY;
                Modify;




                Balance := Balance - (LoansREC."Outstanding Balance" + LoansREC."Oustanding Interest");



                SharesB := SharesB - (LoansREC."Outstanding Balance" + LoansREC."Oustanding Interest");


                if SharesB < 0 then
                    BalanceType := 'Debit Balance'
                else
                    BalanceType := 'Credit Balance';


                LoanGuar.Reset;
                LoanGuar.SetRange(LoanGuar."Loan No", LoansREC."Loan  No.");
                if LoanGuar.Find('-') then begin
                    LoanGuar.Reset;
                    LoanGuar.SetRange(LoanGuar."Loan No", LoansREC."Loan  No.");

                    repeat
                        TGrAmount := TGrAmount + GrAmount;
                        GrAmount := LoanGuar."Amont Guaranteed";
                        //LoanGuar."Amount Guarnted";
                        FGrAmount := TGrAmount + LoanGuar."Amont Guaranteed";
                    until LoanGuar.Next = 0;
                end;
                //Defaulter loan clear
                LoansREC.CalcFields(LoansREC."Outstanding Balance", LoansREC."Interest Due", LoansREC."Oustanding Interest");
                Lbal := ROUND(LoansREC."Outstanding Balance", 0.5, '=');
                INTBAL := LoansREC."Oustanding Interest";
                COMM := LoansREC."Oustanding Interest" * 0.5;
                //MESSAGE('BALANCE %1',Lbal);

                //commisision

                /*
                LoanGuar.RESET;
                LoanGuar.SETRANGE(LoanGuar."Loan No",Loans."Loan  No.");
                IF LoanGuar.FIND('-') THEN BEGIN
                LoanGuar.RESET;
                LoanGuar.SETRANGE(LoanGuar."Loan No",Loans."Loan  No.");
                
                //DLN:='DLN';
                
                REPEAT
                GenSetUp.GET();
                GenSetUp."Defaulter LN":=GenSetUp."Defaulter LN"+10;
                GenSetUp.MODIFY;
                //DLN:='DLN'+FORMAT(GenSetUp."Defaulter LN");
                
                
                
                GrAmount:=LoanGuar."Amount Guarnted";
                //LoanGuar."Amount Guarnted";
                TGrAmount:=TGrAmount+GrAmount;
                //Amount2:=(GrAmount/TGrAmount)*(Lbal+INTBAL+COMM);
                MESSAGE('guarnteed Amount %1',FGrAmount);
                
                //REPEAT
                ////Insert jnl lines
                
                Cust.RESET;
                Cust.SETRANGE(Cust."No.",LoanGuar."Member No");
                IF Cust.FIND('-') THEN BEGIN
                Loans."Client Name":=Cust.Name;
                END;
                
                
                UNTIL LoanGuar.NEXT=0;
                
                
                
                END;*/

                VarGuarantorSecurity := false;

                ObjGuarantor.Reset;
                ObjGuarantor.SetRange(ObjGuarantor."Loan No", "Loan  No.");
                ObjGuarantor.SetFilter(ObjGuarantor.Name, '<>%1', '');
                if ObjGuarantor.FindSet then begin
                    VarGuarantorSecurity := true;
                end;

                ObjCollateral.Reset;
                ObjCollateral.SetRange(ObjCollateral."Loan No", "Loan  No.");
                ObjCollateral.SetFilter(ObjCollateral."Security Details", '<>%1', '');
                if ObjCollateral.FindSet then begin
                    VarCollateralSecurity := ObjCollateral."Security Details";
                end;



                if (VarGuarantorSecurity = false) and (VarCollateralSecurity <> '') then begin
                    VarSecurityUsed := VarCollateralSecurity
                end else
                    if (VarGuarantorSecurity = false) and (VarCollateralSecurity <> '') then begin
                        VarSecurityUsed := 'GUARANTORS';
                    end;
                //=================Get Amount in Arrears=====================================
                VarAmountinArrears := ObjSurestepFactory.FnGetLoanAmountinArrears("Loan  No.");
                //=================End Get Amount in Arrears=====================================

                //==============Get Penalty Percentage===========================================
                if ObjLoanType.Get("Loan Product Type") then begin
                    VarPenaltyPercentage := ObjLoanType."Penalty Percentage";
                end;
                //==============End Get Penalty Percentage=======================================

            end;

            trigger OnPreDataItem()
            begin
                //SenderName:='KANISA';

                CompanyInformation.Get();
                CompanyInformation.CalcFields(CompanyInformation.Picture);
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
        intcount: Integer;
        Balance: Decimal;
        SenderName: Text[150];
        DearM: Text[60];
        BalanceType: Text[100];
        SharesB: Decimal;
        LastPDate: Date;
        Notified: Boolean;
        LoansR: Record "Loans Register";
        SharesAlllocated: Decimal;
        ABFAllocated: Decimal;
        LBalance: Decimal;
        PersonalNo: Code[50];
        GAddress: Text[250];
        Cust: Record "Member Register";
        TotalRec: Decimal;
        NoGuarantors: Integer;
        AmountT: Decimal;
        LoanGuar: Record "Loans Guarantee Details";
        TGrAmount: Decimal;
        GrAmount: Decimal;
        FGrAmount: Decimal;
        Lbal: Decimal;
        INTBAL: Decimal;
        COMM: Decimal;
        GenSetUp: Record "Sacco General Set-Up";
        Amount2: Decimal;
        LBalance1: Decimal;
        SendSMS: Boolean;
        SMSMessage: Record "SMS Messages";
        iEntryNo: Integer;
        Cust1: Record "Member Register";
        CompanyInformation: Record "Company Information";
        ObjCollateral: Record "Loan Collateral Details";
        ObjGuarantor: Record "Loans Guarantee Details";
        VarGuarantorSecurity: Boolean;
        VarCollateralSecurity: Code[50];
        VarSecurityUsed: Code[50];
        VarAmountinArrears: Decimal;
        ObjSurestepFactory: Codeunit "SURESTEP Factory";
        ObjLoanType: Record "Loan Products Setup";
        VarPenaltyPercentage: Decimal;
        MemberLedgerEntry: Record "Member Ledger Entry";
        LastPayDate: Date;
        RemainingPeriod: Integer;
        recoverNoticedate: Date;
}

