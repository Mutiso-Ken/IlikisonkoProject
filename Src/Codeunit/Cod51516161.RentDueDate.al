#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Codeunit 51516161 "RentDueDate"
{

    trigger OnRun()
    begin
    end;

    var
        Property: Record Property;
        House: Record House;
        Customer: Record Customer;

    local procedure RentDue()
    begin

        House.Reset;
    end;
}

