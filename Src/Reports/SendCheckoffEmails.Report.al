#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516457 "Send Check off Emails"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Send Check off Emails.rdlc';

    dataset
    {
        dataitem("Member Register";"Member Register")
        {
            column(ReportForNavId_1; 1)
            {
            }
            column(No_MembersRegister;"Member Register"."No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                AmountToDeduct:=0;
                AmountToDeduct:=FnExistsInCheckOff("Member Register"."No.");
                if AmountToDeduct > 0 then
                begin
                //MESSAGE('Total is %1',FnExistsInCheckOff("Members Register"."No."));
                FnGenerateCheckoffSlips("Member Register"."No.","Member Register"."No."+'_'+CheckoffNo+'.pdf');
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
                field(CheckoffNo;CheckoffNo)
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

    trigger OnPreReport()
    begin
        if CheckoffNo='' then
          Error('Check off Number Must have a Value');
    end;

    var
        CheckoffNo: Code[100];
        FILESPATH: label 'C:\CheckOff Reports\';
        AmountToDeduct: Decimal;


    procedure FnGenerateCheckoffSlips("member no": Code[50];path: Text[100])
    var
        filename: Text[100];
        ObjMember: Record "Member Register";
    begin
        filename := FILESPATH+path;
        if Exists(filename) then
          Erase(filename);
        ObjMember.Reset;
        ObjMember.SetRange("No.", "member no");
        if ObjMember.Find('-') then begin
          Report.SaveAsPdf(51516456,filename,ObjMember);
        end;
    end;

    local procedure FnExistsInCheckOff(MemberNo: Code[100]): Decimal
    var
        ObjCheckoffDetails: Record "Checkoff Processing Details(B)";
        TotalAmount: Decimal;
    begin
        TotalAmount:=0;
        ObjCheckoffDetails.Reset;
        ObjCheckoffDetails.SetRange("Member No",MemberNo);
        if ObjCheckoffDetails.Find('-') then
        begin
          repeat
          TotalAmount:=TotalAmount+ObjCheckoffDetails.Amount;
          until ObjCheckoffDetails.Next=0;
        end;
        exit(TotalAmount);
    end;
}

