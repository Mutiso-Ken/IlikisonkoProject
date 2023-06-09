#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516923 "Volume Transactions Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Volume Transactions Report.rdlc';

    dataset
    {
        dataitem("Vendor Ledger Entry";"Vendor Ledger Entry")
        {
            PrintOnlyIfDetail = false;
            RequestFilterFields = "Posting Date";
            column(ReportForNavId_4645; 4645)
            {
            }
            column(FORMAT_TODAY_0_4_;Format(Today,0,4))
            {
            }
            column(COMPANYNAME;COMPANYNAME)
            {
            }
            column(Company_Name;Company.Name)
            {
            }
            column(Company_Address;Company.Address)
            {
            }
            column(Company_Address_2;Company."Address 2")
            {
            }
            column(Company_Phone_No;Company."Phone No.")
            {
            }
            column(Company_Fax_No;Company."Fax No.")
            {
            }
            column(Company_Picture;Company.Picture)
            {
            }
            column(Company_Email;Company."E-Mail")
            {
            }
            column(CurrReport_PAGENO;CurrReport.PageNo)
            {
            }
            column(USERID;UserId)
            {
            }
            column(VendorNo_VendorLedgerEntry;"Vendor Ledger Entry"."Vendor No.")
            {
            }
            column(PostingDate_VendorLedgerEntry;"Vendor Ledger Entry"."Posting Date")
            {
            }
            column(DocumentNo_VendorLedgerEntry;"Vendor Ledger Entry"."Document No.")
            {
            }
            column(Description_VendorLedgerEntry;"Vendor Ledger Entry".Description)
            {
            }
            column(Amount_VendorLedgerEntry;"Vendor Ledger Entry".Amount)
            {
            }
            column(UserID_VendorLedgerEntry;"Vendor Ledger Entry"."User ID")
            {
            }
            column(DebitAmount_VendorLedgerEntry;"Vendor Ledger Entry"."Debit Amount")
            {
            }
            column(CreditAmount_VendorLedgerEntry;"Vendor Ledger Entry"."Credit Amount")
            {
            }
            column(VarDepositLimit;VarDepositLimit)
            {
            }
            column(VarWithdrawalLimit;VarWithdrawalLimit)
            {
            }
            column(VarCurrAccountBal;VarCurrAccountBal)
            {
            }
            column(VarAccountName;VarAccountName)
            {
            }
            column(VarAccountType;VarAccountType)
            {
            }
            column(VarDepositCriteriaTrue;VarDepositCriteriaTrue)
            {
            }
            column(VarWithdrawalCriteriaTrue;VarWithdrawalCriteriaTrue)
            {
            }
            column(VarDepCount;VarDepCount+1)
            {
            }
            column(VarWithCount;VarWithCount+1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                  if (VarDepositLimit=0) or (VarWithdrawalLimit=0) then begin
                    Error('Ensure you specify the Deposit and Withdrawal Limit');
                    end;



                  ObjVendor.Reset;
                  ObjVendor.SetRange(ObjVendor."No.","Vendor No.");
                  if ObjVendor.FindSet then begin
                    ObjVendor.CalcFields(ObjVendor.Balance);
                    VarAccountName:=ObjVendor.Name;
                    VarAccountType:=ObjVendor."Account Type";
                    VarCurrAccountBal:=ObjVendor.Balance;
                    //VarDepCount:=VarDepCount+1;
                  end;

                  VarDepositCriteriaTrue:=false;
                  VarWithCount:=0;
                  ObjVendorLedg.Reset;
                  ObjVendorLedg.SetRange(ObjVendorLedg."Entry No.","Entry No.");
                  ObjVendorLedg.SetFilter(ObjVendorLedg."Credit Amount",'>=%1',VarDepositLimit);
                  if ObjVendorLedg.FindSet then begin
                     VarDepositCriteriaTrue:=true;
                     //VarWithCount:=VarWithCount+1;
                    end;

                  VarWithdrawalCriteriaTrue:=false;

                  ObjVendorLedg.Reset;
                  ObjVendorLedg.SetRange(ObjVendorLedg."Entry No.","Entry No.");
                  ObjVendorLedg.SetFilter(ObjVendorLedg."Debit Amount",'>=%1',VarWithdrawalLimit);
                  if ObjVendorLedg.FindSet then begin
                     VarWithdrawalCriteriaTrue:=true;
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
                field("Deposit Limit";VarDepositLimit)
                {
                    ApplicationArea = Basic;
                }
                field("Withdrawal Limit";VarWithdrawalLimit)
                {
                    ApplicationArea = Basic;
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
                Company.Get();
                Company.CalcFields(Company.Picture);
    end;

    var
        Company: Record "Company Information";
        ClosingBalPreviousDay: Decimal;
        TotalDeposits: Decimal;
        TotalWithdrawals: Decimal;
        ClosingBalToday: Decimal;
        GLAccountNo: Code[20];
        VendorPostingGroups: Record "Vendor Posting Group";
        StartDate: Date;
        PreviousDay: Date;
        CurrDate: Date;
        GLAccounts: Record "G/L Account";
        CurrDateFilter: Text;
        PrevDateFilter: Text;
        GLEntry: Record "G/L Entry";
        ASAT: Date;
        TransactedAccounts: Integer;
        GLEntries: Record "G/L Entry";
        VarDepositLimit: Decimal;
        VarWithdrawalLimit: Decimal;
        VarCurrAccountBal: Decimal;
        VarAccountName: Code[50];
        VarAccountType: Code[20];
        ObjVendor: Record Vendor;
        VarDepositCriteriaTrue: Boolean;
        VarWithdrawalCriteriaTrue: Boolean;
        ObjVendorLedg: Record "Vendor Ledger Entry";
        VarDepCount: Integer;
        VarWithCount: Integer;
}

