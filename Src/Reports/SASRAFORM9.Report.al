#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516523 "SASRA FORM 9"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/SASRA FORM 9.rdlc';

    dataset
    {
        dataitem("Main Sector";"Main Sector")
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(Code_MainSector;"Main Sector".Code)
            {
            }
            column(Description_MainSector;"Main Sector".Description)
            {
            }
            dataitem("Sub-Sector";"Sub-Sector")
            {
                DataItemLink = No=field(Code);
                column(ReportForNavId_4; 4)
                {
                }
                column(Code_SubSector;"Sub-Sector".Code)
                {
                }
                column(Description_SubSector;"Sub-Sector".Description)
                {
                }
                dataitem("Specific-Sector";"Specific-Sector")
                {
                    DataItemLink = No=field(Code);
                    column(ReportForNavId_7; 7)
                    {
                    }
                    column(Code_SpecificSector;"Specific-Sector".Code)
                    {
                    }
                    column(Description_SpecificSector;"Specific-Sector".Description)
                    {
                    }
                    column(AMount;AMount)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        AMount:=0;

                        LoansR.Reset;
                        LoansR.SetRange("Specific Sector","Specific-Sector".Code);
                        LoansR.SetFilter("Issued Date",Datefilter);
                        if LoansR.FindFirst then begin
                          repeat
                            LoansR.CalcFields("Outstanding Balance");
                            AMount:=AMount+LoansR."Approved Amount";

                            until LoansR.Next=0;
                          end;

                        // AMount:=0;
                        // LoansR.RESET;
                        // LoansR.SETRANGE("Specific Sector","Specific-Sector".Code);
                        // IF LoansR.FINDFIRST THEN BEGIN
                        //  REPEAT
                        //    LoansR.CALCFIELDS("Outstanding Balance");
                        //    AMount:=AMount+LoansR."Outstanding Balance";
                        //    UNTIL LoansR.NEXT=0;
                        //  END;
                    end;
                }
            }
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(StartDate;StartDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Starting Date';
                }
                field(EndDate;EndDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Ending Date';
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

    trigger OnPreReport()
    begin
        Datefilter:=Format(StartDate)+'..'+Format(EndDate);
    end;

    var
        LoansR: Record "Loans Register";
        AMount: Decimal;
        StartDate: Date;
        EndDate: Date;
        Datefilter: Text;
}

