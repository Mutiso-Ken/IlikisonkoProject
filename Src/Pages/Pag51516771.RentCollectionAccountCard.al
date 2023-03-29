#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516771 "Rent Collection Account Card"
{
    DelayedInsert = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    SourceTable = Vendor;
    SourceTableView = where("Vendor Posting Group"=const('RENT'));

    layout
    {
        area(content)
        {
            group(Group)
            {
                field("No.";"No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("BOSA Account No";"BOSA Account No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member No';

                    trigger OnValidate()
                    var
                        MemberRegister: Record "Member Register";
                        Vendor: Record Vendor;
                        propertyCount: Integer;
                    begin


                        Vendor.Reset;
                        Vendor.SetRange("Vendor Posting Group",'RENT');
                        Vendor.SetRange("BOSA Account No","BOSA Account No");
                        if Vendor.Find('-') then
                          Error('Account already exists');

                        MemberRegister.Reset;
                        MemberRegister.SetRange("No.","BOSA Account No");
                        if MemberRegister.Find('-') then begin
                          if MemberRegister."Member class"=MemberRegister."member class"::"Class B" then
                            Error('Only class A members can have rent collection accounts');
                          "ID No.":=MemberRegister."ID No.";
                          "Phone No.":=MemberRegister."Mobile Phone No";
                          Name:=MemberRegister.Name;
                          Address:=MemberRegister.Address;
                          "Country/Region Code":=MemberRegister."Country/Region Code";
                          City:=Address;
                          CurrPage.Update;
                        end;
                        Regions.Reset;
                        Regions.SetRange("Sacco has Branch?",true);
                        if Regions.Find('-') then begin
                          propertyCount:=0;
                          repeat
                           Property.Reset;
                           Property.SetRange(Location,Regions.Code);
                           if Property.Find('-') then begin
                              propertyCount:=propertyCount+1;
                           end;
                        until Regions.Next=0;
                        if propertyCount<1 then
                          Error('Member must own property within the sacco area of operation');
                        end;
                    end;
                }
                field(Name;Name)
                {
                    ApplicationArea = Basic;
                }
                field("ID No.";"ID No.")
                {
                    ApplicationArea = Basic;
                }
                field(Address;Address)
                {
                    ApplicationArea = Basic;
                }
                field(City;City)
                {
                    ApplicationArea = Basic;
                }
                field("Phone No.";"Phone No.")
                {
                    ApplicationArea = Basic;
                }
                field("Country/Region Code";"Country/Region Code")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            group(ActionGroup11)
            {
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        "Vendor Posting Group":='RENT';
        "Country/Region Code":='254';
    end;

    var
        Regions: Record Regions;
        Property: Record Property;
}

