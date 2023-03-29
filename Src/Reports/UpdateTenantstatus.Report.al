#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516947 "Update Tenant status"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Update Tenant status.rdlc';

    dataset
    {
        dataitem(Vendor;Vendor)
        {
            column(ReportForNavId_2; 2)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Vend.Reset;
                Vend.SetRange(Vend."No.",Vendor."No.");
                Vend.SetFilter(Vend."Account Type",'%1','RENT COLLECTION');
                if Vend.Find('-') then begin
                  repeat
                  TransactionsN.Reset;
                  TransactionsN.SetRange(TransactionsN."Account No",Vend."No.");
                  TransactionsN.SetFilter(TransactionsN."Transaction Type",'%1','RENT');
                  TransactionsN.SetRange(TransactionsN.Posted,true);
                  //TransactionsN.SETFILTER(Transactions."Transaction Date",'<=%1','>=%2',TenthDay,FirstDay);
                  if TransactionsN.Find ('-') then begin
                    repeat
                    Vend2.Reset;
                    Vend2.SetRange(Vend2."Rent Account",TransactionsN."Account No");
                    Vend2.SetFilter(Vend2."Vendor Posting Group",'%1','TENANT');
                    Vend2.SetFilter(Vend2.Balance,'>%1',0);
                    if Vend2.Find ('-') then begin
                      repeat
                        HouseT.Reset;
                        HouseT.SetRange(HouseT."House Code",Vend2."House Allocated");
                        if HouseT.Find ('-') then begin
                          //MESSAGE('House No =%1 and tenant name =%1',Vend2."House Allocated",Vend2.Name);
                         // HouseT."House Status":=HouseT."House Status"::Defaulted;
                         // HouseT.MODIFY;
                        end;
                      until Vend2.Next=0;
                    end;
                    until TransactionsN.Next=0;
                  end;
                  until Vend.Next=0;
                end;
            end;

            trigger OnPostDataItem()
            begin
                Message('Update completed successfuly');
            end;

            trigger OnPreDataItem()
            begin
                FirstDay:=CalcDate('-CM',Today);
                TenthDay:=CalcDate('9D',FirstDay);
                DateFilter:=Format(FirstDay)+'..'+Format(CalcDate('CM',Today));
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
        FirstDay: Date;
        TenthDay: Date;
        HouseT: Record House;
        Vend: Record Vendor;
        TransactionsN: Record Transactions;
        Vend2: Record Vendor;
        DateFilter: Text;
        Transactions: Record Transactions;
}

