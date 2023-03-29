#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516851 "Vacant Houses Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Vacant Houses Report.rdlc';

    dataset
    {
        dataitem(House;House)
        {
            DataItemTableView = where(Status=filter(Vacant),"House Rent"=filter(>0));
            column(ReportForNavId_1102755000; 1102755000)
            {
            }
            column(PropertyCode_House;House."Property Code")
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
            column(ReservationRemarks_House;House."Reservation Remarks")
            {
            }
            column(ReservationUserID_House;House."Reservation UserID")
            {
            }
            column(ReservationDate_House;House."Reservation Date")
            {
            }
            column(TenantNo_House;House."Tenant No")
            {
            }
            column(ReceiptNo_House;House."Receipt No")
            {
            }
            column(NoticePeriod_House;House."Notice Period")
            {
            }
            column(Dateallocated_House;House."Date allocated")
            {
            }
            column(DateVacated_House;House."Date Vacated")
            {
            }
            column(TenantName_House;House."Tenant Name")
            {
            }
            column(EntryNo_House;House."Entry No")
            {
            }
            column(PropertyName_House;House."Property Name")
            {
            }
            column(HouseType_House;House."House Type")
            {
            }
            column(AccountNo_House;House."Account No")
            {
            }

            trigger OnAfterGetRecord()
            begin


                 GroupMembers.Reset;
                 //GroupMembers.SETRANGE(GroupMembers."Group Code","Group Code");
                 if GroupMembers.Find('-') then begin

                 GroupMembers.CalcFields(GroupMembers."Balance (LCY)");
                SAVINGS2:=GroupMembers."Balance (LCY)";

                 end;


                "Outstanding Loan" :=0;
                ToustLoan :=0;

                vend.Reset;
                //vend.SETRANGE(vend."No.",Micro_Fin_Schedule."Account Number");
                if vend.Find('-') then begin

                if vend.Blocked=vend.Blocked::All then begin
                CurrReport.Skip;
                end;

                vend.CalcFields(vend."Balance (LCY)");
                Saving:=vend."Balance (LCY)";
                Tsavings:=Tsavings+Saving;
                end;


                LoanApplic.Reset;
                //LoanApplic.SETRANGE(LoanApplic."Client Code",Micro_Fin_Schedule."Account Number");
                LoanApplic.SetRange(LoanApplic.Source,LoanApplic.Source::FOSA);
                if LoanApplic.Find('-') then begin
                repeat
                LoanApplic.CalcFields(LoanApplic."Outstanding Balance",LoanApplic."Oustanding Interest");
                if LoanApplic."Outstanding Balance"<> 0 then begin
                "Outstanding Loan":=LoanApplic."Outstanding Balance";//+LoanApplic."Oustanding Interest";
                ToustLoan:=ToustLoan+"Outstanding Loan";
                end;
                until LoanApplic.Next =0;
                end;
                Tsaving:=Tsaving+Saving;



                //Get group name
                Grps.Reset;
                //IF Grps.GET(Micro_Fin_Schedule."Group Code") THEN
                GrpName:=Grps.Name;
            end;

            trigger OnPreDataItem()
            begin
                // LastFieldNo := FIELDNO("No.");

                 CompanyInfo.Get();
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
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        "Outstanding Loan": Decimal;
        Saving: Decimal;
        LoanApplic: Record "Loans Register";
        vend: Record Vendor;
        Tsaving: Decimal;
        ToustLoan: Decimal;
        Tsavings: Decimal;
        GrpName: Text[100];
        Grps: Record Vendor;
        Loans: Record "Loans Register";
        Outbal: Decimal;
        OutInt: Decimal;
        MicroSubform: Record Micro_Fin_Schedule;
        GroupMembers: Record Vendor;
        SAVINGS2: Decimal;
        CompanyInfo: Record "Company Information";
}

