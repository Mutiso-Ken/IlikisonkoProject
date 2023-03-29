#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516581 "Update Bal Acc"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Update Bal Acc.rdlc';

    dataset
    {
        dataitem("Loans Interest";"Loans Interest")
        {
            RequestFilterFields = "Loan Product type";
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                // LoanProduct.RESET;
                // LoanProduct.SETRANGE(LoanProduct.Code,"Loans Interest"."Loan Product type");
                // IF LoanProduct.FINDSET THEN BEGIN
                //   //MESSAGE('"Loans Interest"."Loan Product type" %1',"Loans Interest"."Loan Product type");
                //    IF "Loans Interest"."Bal. Account No."='' THEN
                //     REPEAT
                //      "Loans Interest"."Bal. Account No.":=LoanProduct."Loan Interest Account";
                //       UNTIL "Loans Interest".NEXT=0;
                //      "Loans Interest".MODIFY;
                // END;
                // //LoanProduct.MODIFY;

                LoansInterest.Reset;
                LoansInterest.SetRange("Loan No.","Loans Interest"."Loan No.");
                LoansInterest.SetRange("Loan Product type","Loans Interest"."Loan Product type");
                if LoansInterest.Find('-') then begin
                    if LoansInterest."Bal. Account No."= '' then
                       LoanProduct.Reset;
                       LoanProduct.SetRange(Code,LoansInterest."Loan Product type");
                       if LoanProduct.Find('-') then begin
                         repeat
                          LoansInterest."Bal. Account No.":=LoanProduct."Loan Interest Account";
                           until LoansInterest.Next=0;
                            LoansInterest.Modify;
                       end;

                end;
            end;

            trigger OnPostDataItem()
            begin
                Message('*****Done******');
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
        LoanProduct: Record "Loan Products Setup";
        LoansInterest: Record "Loans Interest";
}

