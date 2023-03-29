#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516946 "Tenant   defaulters report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ Tenant   defaulters report.rdlc';

    dataset
    {
        dataitem(House;House)
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(HouseCode_House;House."House Code")
            {
            }
            column(Status_House;House.Status)
            {
            }
            column(HouseRent_House;House."House Rent")
            {
            }
            column(NoticePeriod_House;House."Notice Period")
            {
            }
            column(TenantName_House;House."Tenant Name")
            {
            }
            column(PropertyName_House;House."Property Name")
            {
            }
            column(HouseType_House;House."House Type")
            {
            }

            trigger OnAfterGetRecord()
            begin
                //duedate:=(10d),(1m);
                
                //IF duedate>TODAY THEN TENANTID := Defaulter;
                //MESSAGE('Defaulter %1',Defaulter);
                //House.CALCFIELDS(House.L)
                
                /*LoanApp.CALCFIELDS(LoanApp."Last Pay Date",LoanApp."Outstanding Balance");
                LastDueDate:="Last Pay Date";
                
                IF LastDueDate = 0D THEN BEGIN
                  IF LoanApp."Issued Date" <> 0D THEN BEGIN
                        FirstMonthDate:=DMY2DATE(1,DATE2DMY(LoanApp."Issued Date",2),DATE2DMY(LoanApp."Issued Date",3));
                        EndMonthDate:=CALCDATE('-1D',CALCDATE('1D',FirstMonthDate));
                        IF DATE2DMY(LoanApp."Issued Date",1) >= 20 THEN
                          LastDueDate:=CALCDATE('1D',EndMonthDate)
                        ELSE
                          LastDueDate:=EndMonthDate;
                
                END;
                END;
                
                //END;
                
                IF Source=Source::" " THEN BEGIN
                
                
                    IF LastDueDate > CALCDATE('-2D',AsAt)  THEN BEGIN
                      cust.RESET;
                      cust.SETRANGE(cust."No.",LoanApp."Client Code");
                      IF cust.FIND('-') THEN BEGIN
                          cust.Defaulter:=FALSE;
                          cust.MODIFY;
                      END;
                      CurrReport.SKIP;
                    END
                    ELSE BEGIN
                      cust.RESET;
                      cust.SETRANGE(cust."No.",LoanApp."Client Code");
                      IF cust.FIND('-') THEN   BEGIN
                          cust.Defaulter:=TRUE;
                          cust.MODIFY;
                      END;
                
                    END;
                
                END
                ELSE IF Source=Source::BOSA THEN BEGIN
                
                    IF LastDueDate > CALCDATE('-1D',AsAt)  THEN BEGIN
                      Vend.RESET;
                      Vend.SETRANGE(Vend."No.",LoanApp."Account No");
                      IF Vend.FIND('-') THEN BEGIN
                          //Vend.Defaulter:=FALSE;
                          Vend.MODIFY;
                      END;
                      CurrReport.SKIP;
                    END
                    ELSE BEGIN
                      Vend.RESET;
                      Vend.SETRANGE(Vend."No.",LoanApp."Account No");
                      IF Vend.FIND('-') THEN BEGIN
                         // Vend.Defaulter:=TRUE;
                          Vend.MODIFY;
                      END;
                
                
                    END;
                
                END;*/

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
        duedate: Date;
        Defaulter: Text;
}

