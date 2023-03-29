#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516862 "Loans Status"
{
    PageType = List;
    SourceTable = Arrears;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Member No";"Member No")
                {
                    ApplicationArea = Basic;
                }
                field("Member Name";"Member Name")
                {
                    ApplicationArea = Basic;
                }
                field(LoanNo;LoanNo)
                {
                    ApplicationArea = Basic;
                }
                field("Repayment Start Date";"Repayment Start Date")
                {
                    ApplicationArea = Basic;
                }
                field("Due Date";"Due Date")
                {
                    ApplicationArea = Basic;
                }
                field(Balance;Balance)
                {
                    ApplicationArea = Basic;
                }
                field(Schedule;Schedule)
                {
                    ApplicationArea = Basic;
                }
                field(Arrears;Arrears)
                {
                    ApplicationArea = Basic;
                }
                field(Instalments;Instalments)
                {
                    ApplicationArea = Basic;
                }
                field(Repayment;Repayment)
                {
                    ApplicationArea = Basic;
                }
                field(Months;Months)
                {
                    ApplicationArea = Basic;
                    Caption = 'Months In Arrears';
                }
                field(Category;Category)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

