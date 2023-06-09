#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516934 "Reduce Loan From FOSA"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Reduce Loan From FOSA.rdlc';

    dataset
    {
        dataitem("Loan Offset Details"; "Loan Offset Details")
        {
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                ObjLoanOffset.Reset;
                ObjLoanOffset.SetRange(ObjLoanOffset."Loan Top Up", "Loan Top Up");
                if ObjLoanOffset.Find('-') then begin
                    FOSAAccount := ObjLoanOffset."FOSA Account";
                    if ObjLoanOffset."Loan Offset From FOSA" = true then begin
                        Error('This Transaction has been processed');
                    end;

                    ObjVendors.Reset;
                    ObjVendors.SetRange(ObjVendors."No.", ObjLoanOffset."FOSA Account");
                    if ObjVendors.Find('-') then begin
                        ObjVendors.CalcFields(ObjVendors.Balance, ObjVendors."Uncleared Cheques");
                        AvailableBal := (ObjVendors.Balance - ObjVendors."Uncleared Cheques");

                        ObjAccTypes.Reset;
                        ObjAccTypes.SetRange(ObjAccTypes.Code, ObjVendors."Account Type");
                        if ObjAccTypes.Find('-') then
                            AvailableBal := AvailableBal - ObjAccTypes."Minimum Balance";
                    end;


                    //FOSABalance:=FnGetAvailableBalance("Account No");
                    if AvailableBal < Amount then begin
                        Error('The FOSA Account has Less than the amount specified,Account balance is %1', AvailableBal);
                    end;






                    BATCH_TEMPLATE := 'GENERAL';
                    BATCH_NAME := 'DEFAULT';
                    DOCUMENT_NO := ObjLoanOffset."Loan Top Up";
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", BATCH_TEMPLATE);
                    GenJournalLine.SetRange("Journal Batch Name", BATCH_NAME);
                    GenJournalLine.DeleteAll;




                    //------------------------------------1. CREDIT MEMBER LOAN A/C---------------------------------------------------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::"Loan Repayment",
                    GenJournalLine."account type"::Investor, ObjLoanOffset."Client Code", Today, Amount * -1, 'BOSA', ObjLoanOffset."Loan Top Up",
                    'Loan Bridging Offset- ' + '-' + ObjLoanOffset."Loan Top Up", ObjLoanOffset."Loan Top Up");
                    //--------------------------------(Credit Member Loan Account)---------------------------------------------

                    //------------------------------------2. DEBIT MEMBER FOSA A/C---------------------------------------------------------------------------------------------
                    LineNo := LineNo + 10000;
                    SFactory.FnCreateGnlJournalLine(BATCH_TEMPLATE, BATCH_NAME, DOCUMENT_NO, LineNo, GenJournalLine."transaction type"::" ",
                    GenJournalLine."account type"::Vendor, ObjLoanOffset."FOSA Account", Today, Amount, 'BOSA', ObjLoanOffset."Loan Top Up",
                    'Loan Bridging Offset- ' + ObjLoanOffset."Loan Top Up", ObjLoanOffset."Loan Top Up");
                    //----------------------------------(Debit Member Fosa Account)------------------------------------------------
                    GenJournalLine.Reset;
                    GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                    GenJournalLine.SetRange("Journal Batch Name", 'DEFAULT');
                    if GenJournalLine.Find('-') then
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post", GenJournalLine);


                    ObjLoanOffset."Loan Offset From FOSA" := true;
                    ObjLoanOffset."Loan Offset From FOSA By" := UserId;
                    ObjLoanOffset."Loan Offset From FOSA Date" := Today;
                    ObjLoanOffset.Validate(ObjLoanOffset."Loan Top Up");
                    ObjLoanOffset.Modify;


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
                field(Amount; Amount)
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

    var
        FOSAAccount: Code[30];
        Amount: Decimal;
        VarClientCode: Code[30];
        ObjLoanOffset: Record "Loan Offset Details";
        SFactory: Codeunit "SURESTEP Factory";
        GenJournalLine: Record "Gen. Journal Line";
        BATCH_TEMPLATE: Code[50];
        BATCH_NAME: Code[50];
        DOCUMENT_NO: Code[50];
        LineNo: Integer;
        ObjVendors: Record Vendor;
        AvailableBal: Decimal;
        ObjAccTypes: Record "Account Types-Saving Products";
}

