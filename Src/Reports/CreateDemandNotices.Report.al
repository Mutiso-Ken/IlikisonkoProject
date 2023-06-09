#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516927 "Create Demand Notices"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Create Demand Notices.rdlc';

    dataset
    {
        dataitem("Loans Register"; "Loans Register")
        {
            DataItemTableView = where("Loan  No." = filter(<> 'FLN*'));
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                ObjLSchedule.Reset;
                ObjLSchedule.SetRange(ObjLSchedule."Loan No.", "Loan  No.");
                //ObjLSchedule.SETFILTER(ObjLSchedule."Repayment Date",'>=%1',TODAY);
                if ObjLSchedule.FindSet then begin

                    VarAmountInArrears := ObjSurestep.FnGetLoanAmountinArrears("Loan  No.");
                    if VarAmountInArrears > 0 then begin

                        //=============Create 1st Demand Notice======================================================
                        ObjDemands.Reset;
                        ObjDemands.SetRange(ObjDemands."Loan In Default", "Loan  No.");
                        if ObjDemands.Find('-') = false then begin
                            if ObjSaccoNoSeries.Get then begin
                                ObjSaccoNoSeries.TestField(ObjSaccoNoSeries."Demand Notice Nos");
                                VarDocumentNo := ObjNoSeriesMgt.GetNextNo(ObjSaccoNoSeries."Demand Notice Nos", 0D, true);

                                ObjDemands.Init;
                                ObjDemands."Document No" := VarDocumentNo;
                                ObjDemands."Member No" := "Client Code";
                                ObjDemands."Member Name" := "Client Name";
                                ObjDemands."Loan In Default" := "Loan  No.";
                                ObjDemands."Notice Type" := ObjDemands."notice type"::"1st Demand Notice";
                                ObjDemands."Demand Notice Date" := Today;
                                ObjDemands.Insert;
                                ObjDemands.Validate(ObjDemands."Loan In Default");
                                ObjDemands.Modify;
                            end;
                        end;
                        //=============End Create 1st Demand Notice======================================================

                        //=============Create 2nd Demand Notice======================================================
                        ObjDemands.Reset;
                        ObjDemands.SetRange(ObjDemands."Loan In Default", "Loan  No.");
                        ObjDemands.SetFilter(ObjDemands."Notice Type", '<>%1|%2', ObjDemands."notice type"::"3rd Notice", ObjDemands."notice type"::"CRB Notice");
                        if ObjDemands.FindSet then begin
                            if ObjDemands.Count > 1 then begin
                                if ObjSaccoNoSeries.Get then begin
                                    ObjSaccoNoSeries.TestField(ObjSaccoNoSeries."Demand Notice Nos");
                                    VarDocumentNo := ObjNoSeriesMgt.GetNextNo(ObjSaccoNoSeries."Demand Notice Nos", 0D, true);

                                    ObjDemands.Init;
                                    ObjDemands."Document No" := VarDocumentNo;
                                    ObjDemands."Member No" := "Client Code";
                                    ObjDemands."Member Name" := "Client Name";
                                    ObjDemands."Loan In Default" := "Loan  No.";
                                    ObjDemands."Notice Type" := ObjDemands."notice type"::"2nd Demand Notice";
                                    ObjDemands."Demand Notice Date" := Today;
                                    ObjDemands.Insert;
                                    ObjDemands.Validate(ObjDemands."Loan In Default");
                                    ObjDemands.Modify;
                                end;
                            end;
                        end;
                        //=============End Create 2nd Demand Notice======================================================

                        //=============Create CRB Demand Notice======================================================
                        ObjDemands.Reset;
                        ObjDemands.SetRange(ObjDemands."Loan In Default", "Loan  No.");
                        ObjDemands.SetFilter(ObjDemands."Notice Type", '<>%1|%2', ObjDemands."notice type"::"3rd Notice", ObjDemands."notice type"::"CRB Notice");
                        if ObjDemands.FindSet then begin
                            if ObjDemands.Count > 2 then begin
                                if ObjSaccoNoSeries.Get then begin
                                    ObjSaccoNoSeries.TestField(ObjSaccoNoSeries."Demand Notice Nos");
                                    VarDocumentNo := ObjNoSeriesMgt.GetNextNo(ObjSaccoNoSeries."Demand Notice Nos", 0D, true);

                                    ObjDemands.Init;
                                    ObjDemands."Document No" := VarDocumentNo;
                                    ObjDemands."Member No" := "Client Code";
                                    ObjDemands."Member Name" := "Client Name";
                                    ObjDemands."Loan In Default" := "Loan  No.";
                                    ObjDemands."Notice Type" := ObjDemands."notice type"::"CRB Notice";
                                    ObjDemands."Demand Notice Date" := Today;
                                    ObjDemands.Insert;
                                    ObjDemands.Validate(ObjDemands."Loan In Default");
                                    ObjDemands.Modify;
                                end;
                            end;
                        end;
                        //=============End Create CRB Demand Notice======================================================
                    end;
                end;
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
        VarAmountInArrears: Decimal;
        ObjSurestep: Codeunit "SURESTEP Factory";
        ObjDemands: Record "Default Notices Register";
        ObjSaccoNoSeries: Record "Sacco No. Series";
        VarDocumentNo: Code[20];
        ObjNoSeriesMgt: Codeunit NoSeriesManagement;
        ObjLSchedule: Record "Loan Repayment Schedule";
        VarScheduleDate: Date;
}

