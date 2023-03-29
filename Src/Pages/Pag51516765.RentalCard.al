#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516765 "Rental Card"
{
    DeleteAllowed = false;
    SourceTable = Property;

    layout
    {
        area(content)
        {
            group(Control19)
            {
                field(No;No)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Description;Description)
                {
                    ApplicationArea = Basic;
                    Caption = 'Property Name';
                }
                field(Location;Location)
                {
                    ApplicationArea = Basic;
                }
                field("Owner No";"Owner No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member No';
                }
                field("Member Name";"Member Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Unit Prefix";"Unit Prefix")
                {
                    ApplicationArea = Basic;
                    Caption = 'Unit Prefix';
                }
                field(Type;Type)
                {
                    ApplicationArea = Basic;
                    Caption = 'Property Type';
                }
                field("Type of Structure";"Type of Structure")
                {
                    ApplicationArea = Basic;
                }
                field("Rental Value";"Rental Value")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Total Houses";"Total Houses")
                {
                    ApplicationArea = Basic;
                }
                field("Starting No";"Starting No")
                {
                    ApplicationArea = Basic;
                }
                field("Total Occupied";"Total Occupied")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Total Reserved";"Total Reserved")
                {
                    ApplicationArea = Basic;
                }
                field("Total Vacant";"Total Vacant")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Monthly Rent";"Monthly Rent")
                {
                    ApplicationArea = Basic;
                }
                field("Actively Managed";"Actively Managed")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Effective Management Date";"Effective Management Date")
                {
                    ApplicationArea = Basic;
                }
                field("Fully Occupied";"Fully Occupied")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Partially Occupied";"Partially Occupied")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Rent Due Date";"Rent Due Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Rent Due Date (nth day of the Month)';
                }
                field("Notice Period";"Notice Period")
                {
                    ApplicationArea = Basic;
                    Caption = 'Notice Period (Days)';
                    ShowMandatory = true;
                }
                field("Rent Collection Account";"Rent Collection Account")
                {
                    ApplicationArea = Basic;
                }
                field("Expiry Date";"Expiry Date")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(ActionGroup25)
            {
                action("Generate Units")
                {
                    ApplicationArea = Basic;
                    Image = AddToHome;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        TestField("Notice Period");
                        TestField("Total Houses");
                        TestField("Starting No");
                        TestField("Rent Due Date");
                        TestField("Type of Structure");
                        TestField(Type);
                        TestField("Unit Prefix");
                        TestField("Monthly Rent");
                        GenerateHouses();
                    end;
                }
                action(Houses)
                {
                    ApplicationArea = Basic;
                    Image = Users;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "Houses List";
                    RunPageLink = "Property Code"=field(No);
                }
                action(Attachments)
                {
                    ApplicationArea = Basic;
                    Image = Agreement;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        DocumentAttachmentDetails: Page "Document Attachment Details";
                        RecRef: RecordRef;
                    begin
                          RecRef.GetTable(Rec);
                          DocumentAttachmentDetails.OpenForRecRef(RecRef);
                          DocumentAttachmentDetails.RunModal;
                    end;
                }
                action("Create Rent Collection Account")
                {
                    ApplicationArea = Basic;
                    Image = Add;
                    Promoted = true;

                    trigger OnAction()
                    var
                        Vendor: Record Vendor;
                        MemberRegister: Record "Member Register";
                    begin
                        TestField("Owner No");
                        TestField("Expiry Date");

                        Vendor.Reset;
                        Vendor.SetRange("BOSA Account No","Owner No");
                        Vendor.SetRange("Vendor Posting Group",'RENT');
                        if Vendor.Find('-') then begin
                          Message('Rent Collection account already created, account no is '+Vendor."No.");
                        end else begin
                          //Check if Loan Collection agreement is attached
                           DocumentAttachment.Reset;
                           DocumentAttachment.SetRange("No.",Rec.No);
                           DocumentAttachment.SetRange("Document Type",DocumentAttachment."document type"::"Rent Collection Agreement");
                           if not DocumentAttachment.FindFirst then
                             Message('Please attach Rent Collection Agreement to proceed');

                          //Check if copy of ID is attached
                           DocumentAttachment.Reset;
                           DocumentAttachment.SetRange("No.",Rec.No);
                           DocumentAttachment.SetRange("Document Type",DocumentAttachment."document type"::"Copy of ID");
                           if not DocumentAttachment.FindFirst then
                             Message('Please attach copy of ID');

                          //Check if passport photo is attached
                           DocumentAttachment.Reset;
                           DocumentAttachment.SetRange("No.",Rec.No);
                           DocumentAttachment.SetRange("Document Type",DocumentAttachment."document type"::"User Photo");
                           if not DocumentAttachment.FindFirst then
                             Message('Please attach photo');

                          Regions.Reset;
                          Regions.SetRange("Sacco has Branch?",true);
                          if Regions.Find('-') then begin
                            propertyCount:=0;
                            repeat
                             Property.Reset;
                             Property.SetRange(Location,Regions.Code);
                             Property.SetRange(Property.No,Rec.No);
                             if Property.Find('-') then begin
                                propertyCount:=propertyCount+1;
                             end;
                            until Regions.Next=0;
                          if propertyCount<1 then
                            Message('Member must own property within the sacco area of operation');
                          end;
                          MemberRegister.Reset;
                          MemberRegister.SetRange("No.","Owner No");
                          if MemberRegister.Find('-') then begin
                            MemberRegister.TestField("Global Dimension 2 Code");

                            if MemberRegister."Global Dimension 2 Code"='LTK' then
                              branch:='1';
                            if MemberRegister."Global Dimension 2 Code"='KMN' then
                              branch:='2';
                              AcctNo:=branch+'02'+MemberRegister."No.";

                            Vendor.Init;
                            Vendor."No.":=AcctNo;
                            CalcFields("Member Name");
                            //Vendor.Name:=Property.Description;
                            Vendor.Name:=Property."Member Name";
                            Vendor."Phone No.":=MemberRegister."Phone No.";
                            Vendor."Post Code":=MemberRegister."Post Code";
                            Vendor."BOSA Account No":=MemberRegister."No.";
                            Vendor."Rent Agreement Expiry Date":="Expiry Date";
                            Vendor.Address:=Location;
                            Vendor."Date Created":=Today;
                            Vendor.City:=Location;
                            Vendor."Country/Region Code":='254';
                            Vendor."Global Dimension 1 Code":='FOSA';
                            Vendor."Global Dimension 2 Code":=MemberRegister."Global Dimension 2 Code";
                            Vendor."Property Code":=No;
                            Vendor."Mobile Phone No":=MemberRegister."Mobile Phone No";
                            Vendor."Search Name":=Property.Description;
                            Vendor."Account Type":='RENT COLLECTION';
                            Vendor."Creditor Type":=Vendor."creditor type"::"Savings Account";
                            Vendor."Vendor Posting Group":='RENT';
                            Vendor.Insert;
                          end;

                          Vendor.Reset;
                          Vendor.SetRange("BOSA Account No","Owner No");
                          Vendor.SetRange("Property Code",No);
                          if Vendor.Find('-') then begin
                            Message('Rent Collection account created, account no is '+Vendor."No.");
                          end;
                        end;
                    end;
                }
            }
        }
    }

    var
        Counter: Integer;
        House: Record House;
        Existing: Integer;
        TotalCount: Integer;
        Regions: Record Regions;
        Property: Record Property;
        propertyCount: Integer;
        NoSeriesManagement: Codeunit NoSeriesManagement;
        DocumentAttachment: Record "Document Attachment";
        AcctNo: Text[20];
        branch: Text[10];

    local procedure GenerateHouses()
    begin
        // Creates Units For The Rental
        if Confirm ('Warning! This action will clear all the previously created and create new housing units, continue?',true) =false then exit;
        Counter:=1;
        TestField("Unit Prefix");
          House.Reset;
          House.SetRange(House."Property Code",No);
          House.SetRange(House.Status,House.Status::Occupied,House.Status::Reserved);
          if House.FindFirst then
            Error('Cannot delete houses, some are occupied, please vacate all');

          House.Reset;
          House.SetRange(House."Property Code",No);
          Existing:=House.Count;
          House.Reset;
          if Existing=0 then
            Existing:=1;
            TotalCount:=0;

          if "Unit Prefix"='' then
          Error('Unit Prefix cannot be blank!');
          House.Reset;
          House.SetRange(House."Property Code",No);
          if House.Find('-') then House.DeleteAll;
          for Counter:="Starting No" to "Total Houses" do
          begin
         // Create Houses
            House.Init();
            House."House Code":="Unit Prefix" +' '+ Format(Counter);
            House."Property Code":=No;
            House."Entry No":=0;
            House."Property Name":=Description;
            House.Status:=House.Status::Vacant;
            House."House Rent":="Monthly Rent";
            if "Starting No"<>0 then
            House.Insert(true);
        end;
        Message(Format(Counter)+' Housing Units created successfully');
    end;


    procedure ClearFromRental()
    var
        Houses: Record House;
        houseLedger: Record "House Ledger Entries";
        RentalHouses: Record House;
    begin
    end;
}

