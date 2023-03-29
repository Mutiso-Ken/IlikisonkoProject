#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 50015 "Generate Checkoff"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Generate Checkoff.rdlc';

    dataset
    {
        dataitem(Member;"Member Register")
        {
            CalcFields = "Outstanding Interest","Outstanding Balance";
            DataItemTableView = where("Personal No"=filter(<>'""'));
            RequestFilterFields = "Employer Code","Date Filter";
            column(ReportForNavId_1; 1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                ObjDataSheet.Reset;
                ObjDataSheet.SetRange("Payroll No",Member."Personal No");
                if not ObjDataSheet.Find('-') then
                begin
                  ObjDataSheet.Init;
                  ObjDataSheet."Payroll No":=Member."Personal No";
                  ObjDataSheet."Member No":=Member."No.";
                  ObjDataSheet.Name:=Member.Name;
                  ObjDataSheet."Outstanding Balance":=Member."Outstanding Balance";
                  ObjDataSheet."Outstanding Interest":=Member."Outstanding Interest";
                  ObjDataSheet.Employer:=Member."Employer Code";
                  ObjDataSheet.Insert;
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

    trigger OnPreReport()
    begin
        ObjDataSheet.Reset;
        if ObjDataSheet.Find('-') then
          ObjDataSheet.DeleteAll;
    end;

    var
        ObjDataSheet: Record "Data Sheet Lines";
}

