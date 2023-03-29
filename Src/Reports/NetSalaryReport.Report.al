#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50051 "Net Salary Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Net Salary Report.rdlc';

    dataset
    {
        dataitem("Salary Processing Headerr";"Salary Processing Headerr")
        {
            RequestFilterFields = No,"Document No","Employer Code";
            column(ReportForNavId_1000000010; 1000000010)
            {
            }
            column(EmployerCode_SalaryProcessingHeaderr;"Salary Processing Headerr"."Employer Code")
            {
            }
            column(No_SalaryProcessingHeaderr;"Salary Processing Headerr".No)
            {
            }
            dataitem("Salary Processing Lines";"Salary Processing Lines")
            {
                DataItemLink = "Salary Header No."=field(No);
                column(ReportForNavId_1000000000; 1000000000)
                {
                }
                column(BOSANo_SalaryProcessingLines;"Salary Processing Lines"."BOSA No")
                {
                }
                column(No_SalaryProcessingLines;"Salary Processing Lines"."No.")
                {
                }
                column(AccountNo_SalaryProcessingLines;"Salary Processing Lines"."Account No.")
                {
                }
                column(StaffNo_SalaryProcessingLines;"Salary Processing Lines"."Staff No.")
                {
                }
                column(DocumentNo_SalaryProcessingLines;"Salary Processing Lines"."Document No.")
                {
                }
                column(AccountName_SalaryProcessingLines;"Salary Processing Lines"."Account Name")
                {
                }
                column(Name_SalaryProcessingLines;"Salary Processing Lines".Name)
                {
                }
                column(DocumentNo;DocumentNo)
                {
                }
                column(Amount_SalaryProcessingLines;"Salary Processing Lines".Amount)
                {
                }
                column(LoanRepayments;LoanRepayments)
                {
                }
                column(InterestPaid;InterestPaid)
                {
                }
                column(OtherDeductions;OtherDeductions)
                {
                }
                column(STORecovered;STORecovered)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    ObjSalaries.Reset;
                    ObjSalaries.SetRange(No,"Salary Processing Lines"."Salary Header No.");
                    if ObjSalaries.Find('-') then
                      begin
                        DocumentNo:=ObjSalaries."Document No";
                        LoanRepayments:=FnGetLoanRepayments(ObjSalaries."Document No","Salary Processing Lines"."BOSA No")+FnGetLoanRepayments(ObjSalaries."Document No","Salary Processing Lines"."Account No.");
                        InterestPaid:=FnGetLoanInterest(ObjSalaries."Document No","Salary Processing Lines"."BOSA No")+FnGetLoanInterest(ObjSalaries."Document No","Salary Processing Lines"."Account No.");
                        STORecovered:=FnGetSalarySTO(ObjSalaries."Document No","Salary Processing Lines"."Account No.")+FnGetSalarySTOBOSATransactions(ObjSalaries."Document No","Salary Processing Lines"."BOSA No","Salary Processing Lines"."Account No.");
                        OtherDeductions:=150+30+15;
                      end;
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
        ObjSalaries: Record "Salary Processing Headerr";
        DocumentNo: Code[100];
        LoanRepayments: Decimal;
        InterestPaid: Decimal;
        OtherDeductions: Decimal;
        STORecovered: Decimal;

    local procedure FnGetLoanRepayments(DocumentNo: Code[100];MemberNumber: Code[100]): Decimal
    var
        TotalRepayment: Decimal;
        ObjMemberLedgerEntry: Record "Member Ledger Entry";
    begin
        ObjMemberLedgerEntry.Reset;
        ObjMemberLedgerEntry.SetRange("Document No.",DocumentNo);
        ObjMemberLedgerEntry.SetRange("Customer No.",MemberNumber);
        ObjMemberLedgerEntry.SetRange("Transaction Type",ObjMemberLedgerEntry."transaction type"::"Loan Repayment");
        if ObjMemberLedgerEntry.Find('-') then begin
            repeat
            TotalRepayment:=ObjMemberLedgerEntry.Amount+TotalRepayment;
              until ObjMemberLedgerEntry.Next=0;
          end;
        exit(TotalRepayment);
    end;

    local procedure FnGetLoanInterest(DocumentNo: Code[100];MemberNumber: Code[100]): Decimal
    var
        TotalRepayment: Decimal;
        ObjMemberLedgerEntry: Record "Member Ledger Entry";
    begin
        ObjMemberLedgerEntry.Reset;
        ObjMemberLedgerEntry.SetRange("Document No.",DocumentNo);
        ObjMemberLedgerEntry.SetRange("Customer No.",MemberNumber);
        ObjMemberLedgerEntry.SetRange("Transaction Type",ObjMemberLedgerEntry."transaction type"::"Interest Paid");
        if ObjMemberLedgerEntry.Find('-') then begin
          repeat
            TotalRepayment:=ObjMemberLedgerEntry.Amount+TotalRepayment;
            until ObjMemberLedgerEntry.Next=0;
          end;
        exit(TotalRepayment);
    end;

    local procedure FnGetSalarySTO(DocumentNo: Code[100];MemberNumber: Code[100]): Decimal
    var
        TotalRepayment: Decimal;
        ObjVendorLedgerEntry: Record "Vendor Ledger Entry";
        ObjSTOs: Record "Standing Orders";
    begin
        ObjSTOs.Reset;
        ObjSTOs.SetRange("Source Account No.",MemberNumber);
        ObjSTOs.SetRange("Destination Account Type",ObjSTOs."destination account type"::Internal);
        if ObjSTOs.Find('-') then
        begin
          repeat
          ObjVendorLedgerEntry.Reset;
          ObjVendorLedgerEntry.SetRange("Document No.",DocumentNo);
          ObjVendorLedgerEntry.SetRange("Vendor No.",MemberNumber);
          ObjVendorLedgerEntry.SetRange("External Document No.",ObjSTOs."No.");
          if ObjVendorLedgerEntry.Find('-') then
            begin
              ObjVendorLedgerEntry.CalcFields(Amount);
              TotalRepayment:=ObjVendorLedgerEntry.Amount+TotalRepayment;
            end;
        until ObjSTOs.Next=0;
         exit(TotalRepayment);
        end;
    end;

    local procedure FnGetSalarySTOBOSATransactions(DocumentNo: Code[100];MemberNumber: Code[100];FosaAccountNo: Code[100]): Decimal
    var
        TotalRepayment: Decimal;
        ObjMemberLedgerEntry: Record "Member Ledger Entry";
        ObjSTOs: Record "Standing Orders";
    begin
        ObjSTOs.Reset;
        ObjSTOs.SetRange("Source Account No.",FosaAccountNo);
        ObjSTOs.SetRange("Destination Account Type",ObjSTOs."destination account type"::Loans);
        if ObjSTOs.Find('-') then
        begin
          repeat
          ObjMemberLedgerEntry.Reset;
          ObjMemberLedgerEntry.SetRange("Document No.",DocumentNo);
          ObjMemberLedgerEntry.SetRange("Customer No.",MemberNumber);
          ObjMemberLedgerEntry.SetRange("External Document No.",ObjSTOs."No.");
          ObjMemberLedgerEntry.SetFilter("Transaction Type",'%1|%2|%3',ObjMemberLedgerEntry."transaction type"::"Deposit Contribution",ObjMemberLedgerEntry."transaction type"::"Benevolent Fund",
          ObjMemberLedgerEntry."transaction type"::"Insurance Contribution");
          if ObjMemberLedgerEntry.Find('-') then
            begin
              //ObjMemberLedgerEntry.CALCFIELDS(Amount);
              TotalRepayment:=ObjMemberLedgerEntry.Amount+TotalRepayment;
            end;
        until ObjSTOs.Next=0;
         exit(TotalRepayment);
        end;
    end;
}

