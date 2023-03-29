#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 50012 "CapitalizeName"
{

    trigger OnRun()
    begin
    end;


    procedure CapitalizeName(Cust: Record Customer)
    begin
        Cust.Name := UpperCase(Cust.Name);
        Cust.Modify(true);
    end;
}

