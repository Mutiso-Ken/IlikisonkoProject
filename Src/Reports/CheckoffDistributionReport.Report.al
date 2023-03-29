#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516972 "Checkoff Distribution Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Checkoff Distribution Report.rdlc';

    dataset
    {
        dataitem("Checkoff Header-Distributed2";"Checkoff Header-Distributed2")
        {
            column(ReportForNavId_33; 33)
            {
            }
            column(CompanyName;CompanyInfo.Name)
            {
            }
            column(CompanyPicture;CompanyInfo.Picture)
            {
            }
            column(PeriodName;PeriodName)
            {
            }
            column(Postingdate_CheckoffHeaderDistributed;"Checkoff Header-Distributed2"."Posting date")
            {
            }
            column(AccountNo_CheckoffHeaderDistributed;"Checkoff Header-Distributed2"."Account No")
            {
            }
            column(DocumentNo_CheckoffHeaderDistributed;"Checkoff Header-Distributed2"."Document No")
            {
            }
            column(Amount_CheckoffHeaderDistributed;"Checkoff Header-Distributed2".Amount)
            {
            }
            column(AccountName_CheckoffHeaderDistributed;"Checkoff Header-Distributed2"."Account Name")
            {
            }
            column(EmployerCode_CheckoffHeaderDistributed;"Checkoff Header-Distributed2"."Employer Code")
            {
            }
            column(EmployerName_CheckoffHeaderDistributed;"Checkoff Header-Distributed2"."Employer Name")
            {
            }
            column(CheckOffPeriod_CheckoffHeaderDistributed;"Checkoff Header-Distributed2"."CheckOff Period")
            {
            }
            column(EnteredBy_CheckoffHeaderDistributed;"Checkoff Header-Distributed2"."Entered By")
            {
            }
            column(PostedBy_CheckoffHeaderDistributed;"Checkoff Header-Distributed2"."Posted By")
            {
            }
            column(TotalScheduled_CheckoffHeaderDistributed;"Checkoff Header-Distributed2"."Total Scheduled")
            {
            }
            column(TotalLines;TotalLines)
            {
            }
            column(TotalAmount;TotalAmount)
            {
            }
            column(UserId_;UserId_)
            {
            }
            column(No_CheckoffHeaderDistributed;"Checkoff Header-Distributed2".No)
            {
            }
            column(EmployerName;EmployerName)
            {
            }
            dataitem("Checkoff Lines-Distributed2";"Checkoff Lines-Distributed2")
            {
                DataItemLink = "Receipt Header No"=field(No);
                RequestFilterFields = "Employer Code";
                column(ReportForNavId_1; 1)
                {
                }
                column(ShareCapital;ShareCapital)
                {
                }
                column(UnallocatedFunds;UnallocatedFunds)
                {
                }
                column(RegFees;RegFees)
                {
                }
                column(PrincipalLoan;PrincipalLoan)
                {
                }
                column(PrincipalLoanInt;PrincipalLoanInt)
                {
                }
                column(EmergencyLoan;EmergencyLoan)
                {
                }
                column(EmergencyLoanInt;EmergencyLoanInt)
                {
                }
                column(InstantLoan;InstantLoan)
                {
                }
                column(InstantLoanInt;InstantLoanInt)
                {
                }
                column(ElimuLoan;ElimuLoan)
                {
                }
                column(ElimuLoanInt;ElimuLoanInt)
                {
                }
                column(TrusteeLoan;TrusteeLoan)
                {
                }
                column(TrusteeLoanInt;TrusteeLoanInt)
                {
                }
                column(KHLLoan;KHLLoan)
                {
                }
                column(KHLLoanInt;KHLLoanInt)
                {
                }
                column(VisionLoan;VisionLoan)
                {
                }
                column(VisionLoanInt;VisionLoanInt)
                {
                }
                column(CarLoan;CarLoan)
                {
                }
                column(CarLoanInt;CarLoanInt)
                {
                }
                column(SukumaLoan;SukumaLoan)
                {
                }
                column(SukumaLoanInt;SukumaLoanInt)
                {
                }
                column(KaribuLoan;KaribuLoan)
                {
                }
                column(KaribuLoanInt;KaribuLoanInt)
                {
                }
                column(DiasporaLoan;DiasporaLoan)
                {
                }
                column(DiasporaLoanInt;DiasporaLoanInt)
                {
                }
                column(IDLLOan;IDLLOan)
                {
                }
                column(IDLLoanInt;IDLLoanInt)
                {
                }
                column(MaliMaliLoan;MaliMaliLoan)
                {
                }
                column(MaliMaliLoanInt;MaliMaliLoanInt)
                {
                }
                column(DepositContribution;DepositContribution)
                {
                }
                column(KanisaSavings;KanisaSavings)
                {
                }
                column(MjengoLoan;MjengoLoan)
                {
                }
                column(MjengoLoanInt;MjengoLoanInt)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                PeriodName:=FnGetPeriodDescription("Checkoff Header-Distributed2"."CheckOff Period");
                //DepositContribution:=0;
                UserId_:=UserId;

                Employer.Reset;
                Employer.SetRange(Employer.Code,"Checkoff Header-Distributed2"."Employer Code");
                if Employer.Find('-') then
                  EmployerName:=Employer.Description;
                      ShareCapital:=0;
                      UnallocatedFunds:=0;
                      RegFees:=0;

                ObjCheckoffLines.Reset;
                ObjCheckoffLines.SetRange(ObjCheckoffLines."Receipt Header No",No);
                if ObjCheckoffLines.FindSet then
                  begin
                    //REPEAT

                      DepositContribution:=KnGetValue("Checkoff Header-Distributed2".No,Globaltranstype::"Deposit Contribution",'',ObjCheckoffLines."Member No.");
                      KanisaSavings:=KnGetValue("Checkoff Header-Distributed2".No,Globaltranstype::"Kanisa Savings",'',ObjCheckoffLines."Member No.");
                      ShareCapital:=KnGetValue("Checkoff Header-Distributed2".No,Globaltranstype::"Share Capital",'',ObjCheckoffLines."Member No.");

                      PrincipalLoan:=KnGetValue("Checkoff Header-Distributed2".No,Globaltranstype::"Loan Repayment",'PRINCIPAL',ObjCheckoffLines."Member No.");
                      PrincipalLoanInt:=KnGetValue("Checkoff Header-Distributed2".No,Globaltranstype::"Interest Paid",'PRINCIPAL',ObjCheckoffLines."Member No.");
                      EmergencyLoan:=KnGetValue("Checkoff Header-Distributed2".No,Globaltranstype::"Loan Repayment",'EMERGENCY',ObjCheckoffLines."Member No.");
                      EmergencyLoanInt:=KnGetValue("Checkoff Header-Distributed2".No,Globaltranstype::"Interest Paid",'EMERGENCY',ObjCheckoffLines."Member No.");
                      InstantLoan:=KnGetValue("Checkoff Header-Distributed2".No,Globaltranstype::"Loan Repayment",'INSTANT',ObjCheckoffLines."Member No.");
                      InstantLoanInt:=KnGetValue("Checkoff Header-Distributed2".No,Globaltranstype::"Interest Paid",'INSTANT',ObjCheckoffLines."Member No.");
                      MjengoLoan:=KnGetValue("Checkoff Header-Distributed2".No,Globaltranstype::"Loan Repayment",'MJENGO',ObjCheckoffLines."Member No.");
                      MjengoLoanInt:=KnGetValue("Checkoff Header-Distributed2".No,Globaltranstype::"Interest Paid",'MJENGO',ObjCheckoffLines."Member No.");
                      ElimuLoan:=KnGetValue("Checkoff Header-Distributed2".No,Globaltranstype::"Loan Repayment",'ELIMU',ObjCheckoffLines."Member No.");
                      ElimuLoanInt:=KnGetValue("Checkoff Header-Distributed2".No,Globaltranstype::"Interest Paid",'ELIMU',ObjCheckoffLines."Member No.");
                      TrusteeLoan:=KnGetValue("Checkoff Header-Distributed2".No,Globaltranstype::"Loan Repayment",'TRUSTEE',ObjCheckoffLines."Member No.");
                      TrusteeLoanInt:=KnGetValue("Checkoff Header-Distributed2".No,Globaltranstype::"Interest Paid",'TRUSTEE',ObjCheckoffLines."Member No.");
                      KHLLoan:=KnGetValue("Checkoff Header-Distributed2".No,Globaltranstype::"Loan Repayment",'KHL',ObjCheckoffLines."Member No.");
                      KHLLoanInt:=KnGetValue("Checkoff Header-Distributed2".No,Globaltranstype::"Interest Paid",'KHL',ObjCheckoffLines."Member No.");
                      IDLLOan:=KnGetValue("Checkoff Header-Distributed2".No,Globaltranstype::"Loan Repayment",'IDL',ObjCheckoffLines."Member No.");
                      IDLLoanInt:=KnGetValue("Checkoff Header-Distributed2".No,Globaltranstype::"Interest Paid",'IDL',ObjCheckoffLines."Member No.");
                      CarLoan:=KnGetValue("Checkoff Header-Distributed2".No,Globaltranstype::"Loan Repayment",'CAR',ObjCheckoffLines."Member No.");
                      CarLoanInt:=KnGetValue("Checkoff Header-Distributed2".No,Globaltranstype::"Interest Paid",'CAR',ObjCheckoffLines."Member No.");
                      SukumaLoan:=KnGetValue("Checkoff Header-Distributed2".No,Globaltranstype::"Loan Repayment",'SUKUMA',ObjCheckoffLines."Member No.");
                      SukumaLoanInt:=KnGetValue("Checkoff Header-Distributed2".No,Globaltranstype::"Interest Paid",'SUKUMA',ObjCheckoffLines."Member No.");
                      KaribuLoan:=KnGetValue("Checkoff Header-Distributed2".No,Globaltranstype::"Loan Repayment",'KARIBU',ObjCheckoffLines."Member No.");
                      KaribuLoanInt:=KnGetValue("Checkoff Header-Distributed2".No,Globaltranstype::"Interest Paid",'KARIBU',ObjCheckoffLines."Member No.");
                      VisionLoan:=KnGetValue("Checkoff Header-Distributed2".No,Globaltranstype::"Loan Repayment",'VISION',ObjCheckoffLines."Member No.");
                      VisionLoanInt:=KnGetValue("Checkoff Header-Distributed2".No,Globaltranstype::"Interest Paid",'VISION',ObjCheckoffLines."Member No.");
                      DiasporaLoan:=KnGetValue("Checkoff Header-Distributed2".No,Globaltranstype::"Loan Repayment",'DIASPORA',ObjCheckoffLines."Member No.");
                      DiasporaLoanInt:=KnGetValue("Checkoff Header-Distributed2".No,Globaltranstype::"Interest Paid",'DIASPORA',ObjCheckoffLines."Member No.");
                      MaliMaliLoan:=KnGetValue("Checkoff Header-Distributed2".No,Globaltranstype::"Loan Repayment",'MALIMALI',ObjCheckoffLines."Member No.");
                      MaliMaliLoanInt:=KnGetValue("Checkoff Header-Distributed2".No,Globaltranstype::"Interest Paid",'MALIMALI',ObjCheckoffLines."Member No.");

                      RegFees:=KnGetValue("Checkoff Header-Distributed2".No,Globaltranstype::"Registration Fee",'',ObjCheckoffLines."Member No.");
                      UnallocatedFunds:=KnGetValue("Checkoff Header-Distributed2".No,Globaltranstype::"Unallocated Funds",'',ObjCheckoffLines."Member No.");


                //     TotalLines:=ByLaws+RegFees+DepositContribution+ShareCapital+DeamndSavings+Stock+Insurance+NormalLoan+NormalLoanInt+PremiumLoan+PremiumLoanInt+
                //     InstantLoan+InstantLoanInt+EmergencyLoan+EmergencyLoanInt+SchoolFees+SchoolFeesInt+GuarantorLoan+GuarantorLoanInt+SuperSchool+SuperSchoolInt+
                //     SalaryAdvance+SalaryAdvanceInt+HomeAppliance+HomeApplianceInt+HousingLoan+HousingLoanInt+BankBailOut+BankBailOutInt;
                    end;
            end;

            trigger OnPreDataItem()
            begin

                CompanyInfo.Get;
                CompanyInfo.CalcFields(Picture);

                //Period:="Checkoff Header-Distributed2"."CheckOff Period";

                //IF Period=0D THEN
                  //ERROR('You must specify the checkoff period');
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

        //Period:="Checkoff Header-Distributed2"."CheckOff Period";
    end;

    var
        Period: Date;
        CompanyInfo: Record "Company Information";
        PeriodName: Text;
        ObjCheckoffLines: Record "Checkoff Lines-Distributed2";
        TotalAmount: Decimal;
        TotalLines: Decimal;
        UserId_: Text[30];
        Employer: Record "Sacco Employers";
        EmployerName: Text[50];
        GlobalTransType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account","Loan Insurance Charged","Loan Insurance Paid","Recovery Account","FOSA Shares","Additional Shares","Interest Due","Capital Reserve","Kanisa Savings";
        PrincipalLoan: Decimal;
        PrincipalLoanInt: Decimal;
        EmergencyLoan: Decimal;
        EmergencyLoanInt: Decimal;
        InstantLoan: Decimal;
        InstantLoanInt: Decimal;
        ElimuLoan: Decimal;
        ElimuLoanInt: Decimal;
        TrusteeLoan: Decimal;
        TrusteeLoanInt: Decimal;
        KHLLoan: Decimal;
        KHLLoanInt: Decimal;
        VisionLoan: Decimal;
        VisionLoanInt: Decimal;
        CarLoan: Decimal;
        CarLoanInt: Decimal;
        SukumaLoan: Decimal;
        SukumaLoanInt: Decimal;
        KaribuLoan: Decimal;
        KaribuLoanInt: Decimal;
        DiasporaLoan: Decimal;
        DiasporaLoanInt: Decimal;
        IDLLOan: Decimal;
        IDLLoanInt: Decimal;
        MaliMaliLoan: Decimal;
        MaliMaliLoanInt: Decimal;
        DepositContribution: Decimal;
        ShareCapital: Decimal;
        UnallocatedFunds: Decimal;
        KanisaSavings: Decimal;
        RegFees: Decimal;
        MjengoLoan: Decimal;
        MjengoLoanInt: Decimal;

    local procedure KnCalculateTotalDeposits(): Decimal
    var
        ObjCheckoffVarianceBuffer: Record "Safe Custody Agents Register";
        Amount: Decimal;
    begin
        ObjCheckoffLines.Reset;
        ObjCheckoffLines.SetRange(ObjCheckoffLines."Receipt Header No","Checkoff Header-Distributed2".No);
        if ObjCheckoffLines.Find('-') then
          begin
            repeat
              Amount:=Amount+ObjCheckoffLines."Deposit contribution";
            until ObjCheckoffLines.Next=0;
          end;
        exit(Amount);
    end;

    local procedure KnCalculateTotalShareCapital(): Decimal
    var
        ObjCheckoffVarianceBuffer: Record "Safe Custody Agents Register";
        Amount: Decimal;
    begin
        ObjCheckoffLines.Reset;
        ObjCheckoffLines.SetRange(ObjCheckoffLines."Receipt Header No","Checkoff Header-Distributed2".No);
        if ObjCheckoffLines.Find('-') then
          begin
            repeat
              Amount:=Amount+ObjCheckoffLines."Share Capital";
            until ObjCheckoffLines.Next=0;
          end;
        exit(Amount);
    end;

    local procedure KnCalculateTotalLoan(LoanType: Code[30]): Decimal
    var
        ObjCheckoffVarianceBuffer: Record "Safe Custody Agents Register";
        Amount: Decimal;
    begin

        ObjCheckoffLines.Reset;
        ObjCheckoffLines.SetRange(ObjCheckoffLines."Receipt Header No","Checkoff Header-Distributed2".No);
        if ObjCheckoffLines.Find('-') then
          begin

           case LoanType of
            'PRINCIPAL':
                begin
                  repeat
                    Amount:=Amount+ObjCheckoffLines."Principal Loan";
                  until ObjCheckoffLines.Next=0;
                end;
            'EMERGENCY':
                begin
                  repeat
                    Amount:=Amount+ObjCheckoffLines."Emergency 1 Loan";
                  until ObjCheckoffLines.Next=0;
                end;
            'INSTANT':
                begin
                  repeat
                    Amount:=Amount+ObjCheckoffLines."Instant Loan";
                  until ObjCheckoffLines.Next=0;
                end;
            'MJENGO':
                begin
                  repeat
                    Amount:=Amount+ObjCheckoffLines."Mjengo Loan";
                  until ObjCheckoffLines.Next=0;
                end;
            'VISION':
                begin
                  repeat
                    Amount:=Amount+ObjCheckoffLines."Vision Loan";
                  until ObjCheckoffLines.Next=0;
                end;
            'SUKUMA':
                begin
                  repeat
                    Amount:=Amount+ObjCheckoffLines."Sukuma Mwezi Loan";
                  until ObjCheckoffLines.Next=0;
                end;
            'KHL':
                begin
                  repeat
                    Amount:=Amount+ObjCheckoffLines."KHL Loan";
                  until ObjCheckoffLines.Next=0;
                end;
            'CAR':
                begin
                  repeat
                    Amount:=Amount+ObjCheckoffLines."Car Loan";
                  until ObjCheckoffLines.Next=0;
                end;
            'TRUSTEE':
                begin
                  repeat
                    Amount:=Amount+ObjCheckoffLines."Trustee Loan";
                  until ObjCheckoffLines.Next=0;
                end;
            'ELIMU':
                begin
                  repeat
                    Amount:=Amount+ObjCheckoffLines."Elimu Loan";
                  until ObjCheckoffLines.Next=0;
                end;
            'DIASPORA':
                begin
                  repeat
                    Amount:=Amount+ObjCheckoffLines."Dispora Loan";
                  until ObjCheckoffLines.Next=0;
                end;
            'MALIMALI':
                begin
                  repeat
                    Amount:=Amount+ObjCheckoffLines."Mali Mali Loan";
                  until ObjCheckoffLines.Next=0;
                end;
            'IDL':
                begin
                  repeat
                    Amount:=Amount+ObjCheckoffLines."IDL Loan";
                  until ObjCheckoffLines.Next=0;
                end;
          end;
        end;
        exit(Amount);
    end;

    local procedure KnCalculateTotalLoanInterest(LoanType: Code[20]): Decimal
    var
        ObjCheckoffVarianceBuffer: Record "Safe Custody Agents Register";
        Amount: Decimal;
    begin

        ObjCheckoffLines.Reset;
        ObjCheckoffLines.SetRange(ObjCheckoffLines."Receipt Header No","Checkoff Header-Distributed2".No);
        if ObjCheckoffLines.Find('-') then
          begin

           case LoanType of
            'PRINCIPAL':
                begin
                  repeat
                    Amount:=Amount+ObjCheckoffLines."Principal Interest";
                  until ObjCheckoffLines.Next=0;
                end;
            'EMERGENCY':
                begin
                  repeat
                    Amount:=Amount+ObjCheckoffLines."Emergency 1 Interest";
                  until ObjCheckoffLines.Next=0;
                end;
            'INSTANT':
                begin
                  repeat
                    Amount:=Amount+ObjCheckoffLines."Instant Loan Interest";
                  until ObjCheckoffLines.Next=0;
                end;
            'MJENGO':
                begin
                  repeat
                    Amount:=Amount+ObjCheckoffLines."Mjengo Loan Interest";
                  until ObjCheckoffLines.Next=0;
                end;
            'VISION':
                begin
                  repeat
                    Amount:=Amount+ObjCheckoffLines."Vision Loan Interest";
                  until ObjCheckoffLines.Next=0;
                end;
            'SUKUMA':
                begin
                  repeat
                    Amount:=Amount+ObjCheckoffLines."Sukuma Mwezi Loan Interest";
                  until ObjCheckoffLines.Next=0;
                end;
            'KHL':
                begin
                  repeat
                    Amount:=Amount+ObjCheckoffLines."KHL Loan Interest";
                  until ObjCheckoffLines.Next=0;
                end;
            'CAR':
                begin
                  repeat
                    Amount:=Amount+ObjCheckoffLines."Car Loan Interest";
                  until ObjCheckoffLines.Next=0;
                end;
            'TRUSTEE':
                begin
                  repeat
                    Amount:=Amount+ObjCheckoffLines."Truste Loan Interest";
                  until ObjCheckoffLines.Next=0;
                end;
            'ELIMU':
                begin
                  repeat
                    Amount:=Amount+ObjCheckoffLines."Elimu Loan Interest";
                  until ObjCheckoffLines.Next=0;
                end;
            'DIASPORA':
                begin
                  repeat
                    Amount:=Amount+ObjCheckoffLines."Diaspora Loan Interest";
                  until ObjCheckoffLines.Next=0;
                end;
            'MALIMALI':
                begin
                  repeat
                    Amount:=Amount+ObjCheckoffLines."Mali Mali Loan Interest";
                  until ObjCheckoffLines.Next=0;
                end;
            'IDL':
                begin
                  repeat
                    Amount:=Amount+ObjCheckoffLines."IDL Loan Interest";
                  until ObjCheckoffLines.Next=0;
                end;
          end;
        end;
        exit(Amount);
    end;

    local procedure KnCalculateTotalKanisaSavings(): Decimal
    var
        ObjCheckoffVarianceBuffer: Record "Safe Custody Agents Register";
        Amount: Decimal;
    begin
        ObjCheckoffLines.Reset;
        ObjCheckoffLines.SetRange(ObjCheckoffLines."Receipt Header No","Checkoff Header-Distributed2".No);
        if ObjCheckoffLines.Find('-') then
          begin
            repeat
              Amount:=Amount+ObjCheckoffLines."Jiokoe Savings";
            until ObjCheckoffLines.Next=0;
          end;
        exit(Amount);
    end;

    local procedure KnCalculateTotalInsurance(): Decimal
    var
        ObjCheckoffVarianceBuffer: Record "Safe Custody Agents Register";
        Amount: Decimal;
    begin
        ObjCheckoffLines.Reset;
        ObjCheckoffLines.SetRange(ObjCheckoffLines."Receipt Header No","Checkoff Header-Distributed2".No);
        if ObjCheckoffLines.Find('-') then
          begin
            repeat
              Amount:=Amount+ObjCheckoffLines."Insurance Contribution";
            until ObjCheckoffLines.Next=0;
          end;
        exit(Amount);
    end;

    local procedure FnGetPeriodDescription(period: Date): Text
    var
        ObjCheckOffCalender: Record "Checkoff Calender.";
        Description: Text;
    begin
        ObjCheckOffCalender.Reset;
        ObjCheckOffCalender.SetRange(ObjCheckOffCalender."Date Opened",period);
        if ObjCheckOffCalender.Find('-') then
          begin
            Description:=ObjCheckOffCalender."Period Name"
          end;

        exit(Description);
    end;

    local procedure KnGetValue(CheckofNo: Code[20];TransType: Option " ","Registration Fee","Share Capital","Interest Paid","Loan Repayment","Deposit Contribution","Insurance Contribution","Benevolent Fund",Loan,"Unallocated Funds",Dividend,"FOSA Account","Loan Insurance Charged","Loan Insurance Paid","Recovery Account","FOSA Shares","Additional Shares","Interest Due","Capital Reserve","Kanisa Savings";LoanType: Code[20];CustNo: Code[20]): Decimal
    var
        Val: Decimal;
        MemberLedgEntry: Record "Member Ledger Entry";
    begin

        if LoanType='' then begin
        MemberLedgEntry.Reset;
        MemberLedgEntry.SetRange(MemberLedgEntry."Document No.",CheckofNo);
        MemberLedgEntry.SetRange(MemberLedgEntry."Transaction Type",TransType);
        MemberLedgEntry.SetRange(MemberLedgEntry.Reversed,false);
        if MemberLedgEntry.Find('-') then
          begin
            MemberLedgEntry.CalcSums(MemberLedgEntry.Amount);
            Val:=MemberLedgEntry.Amount*-1;
          end;
        end else begin
        MemberLedgEntry.Reset;
        MemberLedgEntry.SetRange(MemberLedgEntry."Document No.",CheckofNo);
        MemberLedgEntry.SetRange(MemberLedgEntry."Transaction Type",TransType);
        MemberLedgEntry.SetRange(MemberLedgEntry."Loan Type",LoanType);
        MemberLedgEntry.SetRange(MemberLedgEntry.Reversed,false);
        if MemberLedgEntry.Find('-') then
          begin
            MemberLedgEntry.CalcSums(MemberLedgEntry.Amount);
            Val:=MemberLedgEntry.Amount*-1;
          end;

        end;
        exit(Val);
    end;
}

