#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516452 "Loan Appraisal MICRO Nafa"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Loan Appraisal MICRO Nafa.rdlc';

    dataset
    {
        dataitem(Loans;"Loans Register")
        {
            RequestFilterFields = "Loan  No.";
            column(ReportForNavId_1000000000; 1000000000)
            {
            }
            column(GroupCode_Loans;Loans."Group Code")
            {
            }
            column(IDNO_Loans;Loans."ID NO")
            {
            }
            column(ClientName_Loans;Loans."Client Name")
            {
            }
            column(LoanNo_Loans;Loans."Loan  No.")
            {
            }
            column(ApplicationDate_Loans;Loans."Application Date")
            {
            }
            column(LoanProductType_Loans;Loans."Loan Product Type")
            {
            }
            column(ClientCode_Loans;Loans."Client Code")
            {
            }
            column(GroupCode;Loans."Group Code")
            {
            }
            column(Savings_Loans;Loans.Savings)
            {
            }
            column(ExistingLoan_Loans;Loans."Existing Loan")
            {
            }
            column(RequestedAmount_Loans;Loans."Requested Amount")
            {
            }
            column(ApprovedAmount_Loans;Loans."Approved Amount")
            {
            }
            column(LoanType;Loans."Loan Product Type")
            {
            }
            column(BranchCode;Loans."Branch Code")
            {
            }
            column(Installments;Loans.Installments)
            {
            }
            column(OutstandingBalance_Loans;Loans."Outstanding Balance")
            {
            }
            column(IssuedDate_Loans;Loans."Issued Date")
            {
            }
            column(Repayment;Loans.Repayment)
            {
            }
            column(GrossProfit;GrossProfit)
            {
            }
            column(NetCome;NetCome)
            {
            }
            column(FamilyExpenses;FamilyExpenses)
            {
            }
            column(AvailableBal;AvailableBal)
            {
            }
            column(ApplicantBal;ApplicantBal)
            {
            }
            column(LnNo;"LnNo.")
            {
            }
            column(LoanBal;LoanBal)
            {
            }
            column(FOSALoanBal;FOSALoanBal)
            {
            }
            column(FOSALnNo;"FOSALnNo.")
            {
            }
            column(CompanyPicture;CompanyInfo.Picture)
            {
            }
            column(TotalSal;TotalSal)
            {
            }
            column(TotalSalCat;TotalSalCat)
            {
            }
            column(CompanyName;CompanyInfo.Name)
            {
            }
            column(TotalSales;TotalSales)
            {
            }
            dataitem("Appraisal Salary Details";"Loan Appraisal Salary Details")
            {
                DataItemLink = "Client Code"=field("Client Code"),"Loan No"=field("Loan  No.");
                column(ReportForNavId_1000000018; 1000000018)
                {
                }
                column(AppraisalClientCode;"Appraisal Salary Details"."Client Code")
                {
                }
                column(AppraisalCode;"Appraisal Salary Details".Code)
                {
                }
                column(AppraisalDescription;"Appraisal Salary Details".Description)
                {
                }
                column(AppraisalTypes;"Appraisal Salary Details".Type)
                {
                }
                column(AppraisalAmount;"Appraisal Salary Details".Amount)
                {
                }
                column(AppraisalLoanNo;"Appraisal Salary Details"."Loan No")
                {
                }
            }
            dataitem(AppraisalSalaryDetails2;"Loan Appraisal Salary Details")
            {
                DataItemLink = "Client Code"=field("Client Code"),"Loan No"=field("Loan  No.");
                column(ReportForNavId_1000000057; 1000000057)
                {
                }
                column(ClientCode_AppraisalSalaryDetails2;AppraisalSalaryDetails2."Client Code")
                {
                }
                column(Code_AppraisalSalaryDetails2;AppraisalSalaryDetails2.Code)
                {
                }
                column(Description_AppraisalSalaryDetails2;AppraisalSalaryDetails2.Description)
                {
                }
                column(Type_AppraisalSalaryDetails2;AppraisalSalaryDetails2.Type)
                {
                }
                column(Amount_AppraisalSalaryDetails2;AppraisalSalaryDetails2.Amount)
                {
                }
                column(LoanNo_AppraisalSalaryDetails2;AppraisalSalaryDetails2."Loan No")
                {
                }
                column(SNo; SNo)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    SNo += 1;
                end;

                trigger OnPreDataItem()
                begin
                    // SETFILTER("Appraisal Type",'%1|%2|%3',AppraisalSalaryDetails2."Appraisal Type"::"4",
                    // AppraisalSalaryDetails2."Appraisal Type"::"2",AppraisalSalaryDetails2."Appraisal Type"::"3");
                end;
            }
            dataitem("Micro Profitability Analysis";"Micro Profitability Analysis")
            {
                DataItemLink = "Loan No."=field("Loan  No."),"Client Code"=field("Client Code");
                column(ReportForNavId_1000000027; 1000000027)
                {
                }
                column(MicroAverageMonthlySales_MicroProfitabilityAnalysis;"Micro Profitability Analysis"."Average Monthly Sales")
                {
                }
                column(MicroAverageMonthlyPurchase_MicroProfitabilityAnalysis;"Micro Profitability Analysis"."Average Monthly Purchase")
                {
                }
                column(MicroGrossProfit_MicroProfitabilityAnalysis;"Micro Profitability Analysis"."Gross Profit")
                {
                }
                column(MicroAmount_MicroProfitabilityAnalysis;"Micro Profitability Analysis".Amount)
                {
                }
                column(ProfDescription;"Micro Profitability Analysis".Description)
                {
                }
                column(CodeType;"Micro Profitability Analysis"."Code Type")
                {
                }
                column(MicroCode;"Micro Profitability Analysis".Code)
                {
                }
            }
            dataitem("Appraisal Expenses-Micro";"Appraisal Expenses-Micro")
            {
                DataItemLink = "Client Code"=field("Client Code"),Loan=field("Loan  No.");
                column(ReportForNavId_1000000033; 1000000033)
                {
                }
                column(ExpenseCode_AppraisalExpensesMicro;"Appraisal Expenses-Micro".Code)
                {
                }
                column(ExpenseDescription_AppraisalExpensesMicro;"Appraisal Expenses-Micro".Description)
                {
                }
                column(ExpenseType_AppraisalExpensesMicro;"Appraisal Expenses-Micro".Type)
                {
                }
                column(ExpenseAmount_AppraisalExpensesMicro;"Appraisal Expenses-Micro".Amount)
                {
                }
            }
            dataitem(LoanApp;"Member Ledger Entry")
            {
                DataItemLink = "Customer No."=field("BOSA No");
                DataItemTableView = where("Transaction Type"=filter("Share Capital"|"Interest Paid"));
                column(ReportForNavId_1000000047; 1000000047)
                {
                }
                column(LedAmount_LoanApp;LoanApp.Amount)
                {
                }
                column(LedLoanNo_LoanApp;LoanApp."Loan No")
                {
                }
            }
            dataitem("Loans Guarantee Details";"Loans Guarantee Details")
            {
                DataItemLink = "Loan No"=field("Loan  No."),"Defaulter Loan Installments"=field("Group Code");
                column(ReportForNavId_1000000013; 1000000013)
                {
                }
                column(LoanNo_LoansGuaranteeDetails;"Loans Guarantee Details"."Loan No")
                {
                }
                column(Name_LoansGuaranteeDetails;"Loans Guarantee Details".Name)
                {
                }
                column(Shares_LoansGuaranteeDetails;"Loans Guarantee Details".Shares)
                {
                }
                column(AmontGuaranteed_LoansGuaranteeDetails;"Loans Guarantee Details"."Amont Guaranteed")
                {
                }
                column(FreeShares_LoansGuaranteeDetails;"Loans Guarantee Details"."Free Shares")
                {
                }
                column(MemberNo_LoansGuaranteeDetails;"Loans Guarantee Details"."Member No")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //TotalAmountGuaranteed:=0;
                    //MESSAGE('g is %1 loan ap %2',"Loans Guarantee Details"."Loan No",Loans."Loan  No.");
                end;
            }
            dataitem("Loan Collateral Details";"Loan Collateral Details")
            {
                DataItemLink = "Loan No"=field("Loan  No.");
                column(ReportForNavId_1000000072; 1000000072)
                {
                }
                column(LoanNo_LoanCollateralDetails;"Loan Collateral Details"."Loan No")
                {
                }
                column(Type_LoanCollateralDetails;"Loan Collateral Details".Type)
                {
                }
                column(Value_LoanCollateralDetails;"Loan Collateral Details".Value)
                {
                }
                column(GuaranteeValue_LoanCollateralDetails;"Loan Collateral Details"."Guarantee Value")
                {
                }
                column(TitleDeedNo_LoanCollateralDetails;"Loan Collateral Details"."Title Deed No.")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                
                
                if Cust.Get(Loans."Client Code") then begin
                Cust.CalcFields(Cust."Current Shares");
                Cshares:=Cust."Current Shares";
                if LoanType.Get(Loans."Loan Product Type") then   //BEGIN
                
                //QUALIFICATION AS PER DEPOSITS
                
                //IF "Loan Product Type"='J/L' THEN BEGIN
                //DEpMultiplier:=LoanType."Shares Multiplier"*(Cshares+"Jaza Deposits"+"Deposit Reinstatement");
                
                //END ELSE BEGIN
                TotalGuaranteed:=0;
                 DEpMultiplier:=LoanType."Shares Multiplier"*Cshares;   //+"Deposit Reinstatement");
                //END;
                end;
                /*MESSAGE('recommended amount is %1',DEpMultiplier);
                IF Loans."Recommended Amount"<=Loans."Requested Amount" THEN BEGIN
                  Loans."Recommended Amount":=Loans."Requested Amount";
                  END;
                Loans."Recommended Amount":=DEpMultiplier;
                MODIFY;*/
                TotalGuaranteed:=FnGuarantorTotalAmount(Loans."Loan  No.")+FnCollateralTotalAmount(Loans."Loan  No.");
                MaximumEligible:=FnGP(Loans."Loan  No.")+FnIncomeDetails(Loans."Loan  No.")-FnAppraisalExpenses(Loans."Loan  No.");
                Message('%1 %2 %3 %4',MaximumEligible,FnGP(Loans."Loan  No."),FnIncomeDetails(Loans."Loan  No."),FnAppraisalExpenses(Loans."Loan  No."));
                //PrincipalAmountGlobal:=Installments*MaximumEligible/(((Interest/100)*Installments/12)+1);
                PrincipalAmountGlobal:=(FnGP(Loans."Loan  No.") + FnIncomeDetails(Loans."Loan  No.") - FnAppraisalExpenses(Loans."Loan  No."))*0.7  ;
                if Loans."Repayment Method"=Loans."repayment method"::Amortised then
                PrincipalAmountGlobal:=MaximumEligible*((Power((1+Loans.Interest/1200),Installments)-1)/((Loans.Interest/1200)*(Power((1+Loans.Interest/1200),Installments))));
                Message('%1',PrincipalAmountGlobal);
                DEpMultiplier:=(DEpMultiplier);//-(LBalance-FinalInst);
                
                Message('#Requested Amount=%1, #Total Shares=%2 #Guarantorsip Amount=%3 #Qualification by Income=%4 ..***Recommened Amount=%5***',Loans."Requested Amount",DEpMultiplier,TotalGuaranteed,PrincipalAmountGlobal,
                FnReccommendAmount(Loans."Requested Amount",DEpMultiplier,TotalGuaranteed,PrincipalAmountGlobal));
                Recomm:=FnReccommendAmount(Loans."Requested Amount",DEpMultiplier,TotalGuaranteed,PrincipalAmountGlobal); //Introduced on 28th sep 2017;
                
                "Recommended Amount":=ROUND(Recomm,100,'<');
                "Approved Amount":=ROUND(Recomm,100,'<');
                if Loans.Posted=false then
                Loans.Modify;
                
                //NetCome:=0;
                //TotalSal:=0;
                //TotalSales:=0;
                //GrossProfit:=0;
                AppraisalSals.Reset;
                AppraisalSals.SetRange(AppraisalSals."Client Code","Client Code");
                if AppraisalSals.FindFirst then begin
                repeat
                TotalSal:=TotalSal+AppraisalSals.Amount;
                until AppraisalSals.Next=0;
                end;
                
                AppraisalSalDet.Reset;
                AppraisalSalDet.SetRange(AppraisalSalDet."Client Code","Client Code");
                //AppraisalSalDet.SETRANGE(AppraisalSalDet."Appraisal Type",AppraisalSalDet."Appraisal Type"::"3",AppraisalSalDet."Appraisal Type"::"4");
                if AppraisalSalDet.FindFirst then begin
                repeat
                TotalSalCat:=TotalSalCat+AppraisalSalDet.Amount;
                until AppraisalSalDet.Next=0;
                end;
                
                
                MicroProftAnalysis.Reset;
                MicroProftAnalysis.SetRange(MicroProftAnalysis."Loan No.","Loan  No.");
                MicroProftAnalysis.SetRange(MicroProftAnalysis."Client Code","Client Code");
                MicroProftAnalysis.SetRange(MicroProftAnalysis.Code,'SALES');
                if MicroProftAnalysis.Find('-') then begin
                TotalSales:=MicroProftAnalysis.Amount;
                end;
                
                MicroProfitAnalysis.Reset;
                MicroProfitAnalysis.SetRange(MicroProfitAnalysis."Loan No.","Loan  No.");
                MicroProfitAnalysis.SetRange(MicroProfitAnalysis."Client Code","Client Code");
                MicroProfitAnalysis.SetRange(MicroProfitAnalysis.Code,'PURCHASES');
                if MicroProfitAnalysis.Find('-') then begin
                TotalPurchase:=MicroProfitAnalysis.Amount;
                end;
                
                GrossProfit:=TotalSales-TotalPurchase;
                
                BussExpenses.Reset;
                BussExpenses.SetRange(BussExpenses.Loan,"Loan  No.");
                BussExpenses.SetRange(BussExpenses."Client Code","Client Code");
                BussExpenses.SetRange(BussExpenses.Type,BussExpenses.Type::"Business Expenses");
                if BussExpenses.Find('-') then begin
                repeat
                TotalBusExpenses:=TotalBusExpenses+BussExpenses.Amount;
                until BussExpenses.Next=0;
                end;
                
                FamExpenses.Reset;
                FamExpenses.SetRange(FamExpenses.Loan,"Loan  No.");
                FamExpenses.SetRange(FamExpenses."Client Code","Client Code");
                FamExpenses.SetRange(FamExpenses.Type,FamExpenses.Type::"Family Expenses");
                if FamExpenses.Find('-') then begin
                repeat
                TotalFamExpenses:=TotalFamExpenses+FamExpenses.Amount;
                until FamExpenses.Next=0;
                end;
                
                NetCome:=GrossProfit-TotalBusExpenses;
                FamilyExpenses:=TotalFamExpenses;
                AvailableBal:=NetCome+TotalSalCat;
                ApplicantBal:=AvailableBal-Repayment;
                
                LoanApps.Reset;
                LoanApps.SetRange(LoanApps."ID NO","ID NO");
                LoanApps.SetRange(LoanApps.Posted,true);
                LoanApps.SetRange(LoanApps.Source,LoanApps.Source::" ");
                if LoanApps.Find('-') then begin
                LoanApps.CalcFields(LoanApps."Outstanding Balance");
                "LnNo.":=LoanApps."Loan  No.";
                LoanBal:=LoanApps."Outstanding Balance";
                end;
                
                LnApps.Reset;
                LnApps.SetRange(LnApps."ID NO","ID NO");
                LnApps.SetRange(LnApps.Posted,true);
                LnApps.SetRange(LnApps.Source,LnApps.Source::BOSA);
                if LnApps.Find('-') then begin
                
                LnApps.CalcFields(LnApps."Outstanding Balance");
                if LnApps."Outstanding Balance" > 0 then begin
                "FOSALnNo.":=LnApps."Loan  No.";
                FOSALoanBal:=LnApps."Outstanding Balance";
                end;
                end;
                Modify;

            end;

            trigger OnPreDataItem()
            begin

                CompanyInfo.Get;
                CompanyInfo.CalcFields(CompanyInfo.Picture);
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
        GrossProfit: Decimal;
        MicroProftAnalysis: Record "Micro Profitability Analysis";
        TotalPurchase: Decimal;
        TotalSales: Decimal;
        MicroProfitAnalysis: Record "Micro Profitability Analysis";
        BussExpenses: Record "Appraisal Expenses-Micro";
        TotalBusExpenses: Decimal;
        TotalFamExpenses: Decimal;
        FamExpenses: Record "Appraisal Expenses-Micro";
        TotalBussFamExpenses: Decimal;
        NetCome: Decimal;
        FamilyExpenses: Decimal;
        AvailableBal: Decimal;
        ApplicantBal: Decimal;
        LoanApps: Record "Loans Register";
        "LnNo.": Code[20];
        LoanBal: Decimal;
        LnApps: Record "Loans Register";
        FOSALoanBal: Decimal;
        "FOSALnNo.": Code[20];
        CompanyInfo: Record "Company Information";
        AppraisalSals: Record "Loan Appraisal Salary Details";
        TotalSal: Decimal;
        AppraisalSalDet: Record "Loan Appraisal Salary Details";
        TotalSalCat: Decimal;
        SNo: Integer;
        Cust: Record "Member Register";
        Cshares: Decimal;
        LoanType: Record "Loan Products Setup";
        DEpMultiplier: Decimal;
        PrincipalAmountGlobal: Decimal;
        MaximumEligible: Decimal;
        TotalGuaranteed: Decimal;
        Recomm: Decimal;
        TotalAmountGuaranteed: Decimal;

    local procedure FnReccommendAmount(RequestedAmount: Decimal;QShares: Decimal;QGuarantors: Decimal;QIncome: Decimal) RecommendedAmount: Decimal
    begin
        RecommendedAmount:=RequestedAmount;
        if RecommendedAmount > QIncome then
          RecommendedAmount:=QIncome;

        if RecommendedAmount > QShares then
          RecommendedAmount:=QShares;

        if RecommendedAmount > QGuarantors then
          RecommendedAmount:=QGuarantors;

        exit(RecommendedAmount);
    end;

    local procedure FnIncomeDetails(LoanNumber: Code[50]) AvailableIncome: Decimal
    var
        ObjAppraisalDetails: Record "Loan Appraisal Salary Details";
    begin
        AvailableIncome:=0;
        ObjAppraisalDetails.Reset;
        ObjAppraisalDetails.SetRange(ObjAppraisalDetails."Loan No",LoanNumber);
        //ObjAppraisalDetails.SETFILTER(ObjAppraisalDetails."Appraisal Type",'%1|%2|%3',ObjAppraisalDetails."Appraisal Type"::"2",ObjAppraisalDetails."Appraisal Type"::"3",ObjAppraisalDetails."Appraisal Type"::"4");
        if ObjAppraisalDetails.FindSet then begin
            repeat
              AvailableIncome:=AvailableIncome+ObjAppraisalDetails.Amount;
            until ObjAppraisalDetails.Next=0;
          end;
          exit(AvailableIncome);
    end;

    local procedure FnGP(LoanNumber: Code[40]) AvailableIncome: Decimal
    var
        ObjGP: Record "Micro Profitability Analysis";
    begin
        AvailableIncome:=0;
        ObjGP.Reset;
        ObjGP.SetRange(ObjGP."Loan No.",LoanNumber);
        if ObjGP.FindSet then begin
          repeat
            if ObjGP.Code='SALES' then
              AvailableIncome:=AvailableIncome+ObjGP.Amount
              else
              AvailableIncome:=AvailableIncome-ObjGP.Amount;
          until ObjGP.Next=0;
          end;
        exit(AvailableIncome);
    end;

    local procedure FnAppraisalExpenses(LoanNumber: Code[40]) AvailableIncome: Decimal
    var
        ObjAppraisal: Record "Appraisal Expenses-Micro";
    begin
        AvailableIncome:=0;
        ObjAppraisal.Reset;
        ObjAppraisal.SetRange(ObjAppraisal.Loan,LoanNumber);
        if ObjAppraisal.FindSet then begin
          repeat
            AvailableIncome:=AvailableIncome+ObjAppraisal.Amount;
          until ObjAppraisal.Next=0;
          end;
        exit(AvailableIncome);
    end;

    local procedure FnGuarantorTotalAmount(LoanNumber: Code[40]) AvailableIncome: Decimal
    var
        ObjGuarantorDetails: Record "Loans Guarantee Details";
    begin
        AvailableIncome:=0;

        ObjGuarantorDetails.Reset;
        ObjGuarantorDetails.SetRange(ObjGuarantorDetails."Loan No",LoanNumber);
        if ObjGuarantorDetails.FindSet then begin
          repeat
            AvailableIncome:=AvailableIncome+ObjGuarantorDetails."Amont Guaranteed";
          until ObjGuarantorDetails.Next=0;
          end;
        exit(AvailableIncome);
    end;

    local procedure FnCollateralTotalAmount(LoanNumber: Code[40]) AvailableIncome: Decimal
    var
        ObjCollateral: Record "Loan Collateral Details";
    begin
        AvailableIncome:=0;
        ObjCollateral.Reset;
        ObjCollateral.SetRange(ObjCollateral."Loan No",LoanNumber);
        if ObjCollateral.FindSet then begin
          repeat
            AvailableIncome:=AvailableIncome+ObjCollateral."Guarantee Value";
          until ObjCollateral.Next=0;
          end;
        exit(AvailableIncome);
    end;
}

