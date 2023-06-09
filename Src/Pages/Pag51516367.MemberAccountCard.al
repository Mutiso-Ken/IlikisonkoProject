#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516367 "Member Account Card"
{
    Caption = 'Member Card';
    DeleteAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    RefreshOnActivate = true;
    SourceTable = "Member Register";
    SourceTableView = sorting("Employer Code")
                      where("Customer Type" = const(Member));

    layout
    {
        area(content)
        {
            group("General Info")
            {
                Caption = 'General Info';
                Editable = true;
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member No.';
                    Editable = false;
                }
                field("Account Category"; "Account Category")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Joint Account Name"; "Joint Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                    Visible = false;
                }
                field(Name; Name)
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Name';
                    Editable = false;
                }
                field("Application No."; "Application No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Personal No"; "Personal No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Payroll No.';
                    Editable = false;
                }
                field("FOSA Account No."; "FOSA Account No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Current Account';
                    Editable = false;

                    trigger OnValidate()
                    begin
                        FosaName := '';

                        if "FOSA Account No." <> '' then begin
                            if Vend.Get("FOSA Account No.") then begin
                                FosaName := Vend.Name;
                            end;
                        end;
                    end;
                }
                field(FosaName; FosaName)
                {
                    ApplicationArea = Basic;
                    Caption = 'Current Account Name';
                    Editable = false;
                    Visible = false;
                }
                field(Address; Address)
                {
                    ApplicationArea = Basic;
                    Caption = 'Regions';
                    Editable = false;
                }
                field("Post Code"; "Post Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Post Code/City';
                    Editable = false;
                }
                field(City; City)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Country/Region Code"; "Country/Region Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Mobile Phone No"; "Mobile Phone No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Phone No."; "Phone No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Pension No"; "Pension No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member Category"; "Member Category")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Identification Document"; "Identification Document")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ID No."; "ID No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'ID Number';
                    Editable = true;
                }
                field("Passport No."; "Passport No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Gender; Gender)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Staff; Staff)
                {
                    ApplicationArea = Basic;
                    Caption = 'Staff';
                }
                field(Board; Board)
                {
                    ApplicationArea = Basic;
                    Caption = 'Board';
                }
                field(Pin; Pin)
                {
                    ApplicationArea = Basic;
                    Caption = 'KRA Pn';
                    Editable = false;
                    ShowMandatory = true;
                }
                field(txtMarital; "Marital Status")
                {
                    ApplicationArea = Basic;
                    Caption = 'Marital Status';
                    Editable = false;
                    Visible = txtMaritalVisible;
                }
                field("Date of Birth"; "Date of Birth")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Disabled; Disabled)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Application Date"; "Application Date")
                {
                    ApplicationArea = Basic;
                    Enabled = false;
                }
                field("Registration Date"; "Registration Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(rejoined; rejoined)
                {
                    ApplicationArea = Basic;
                    Caption = 'Reactivated';
                    Editable = false;
                }
                field("Rejoining Date"; "Rejoining Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Reactivation Date';
                    Editable = false;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        StatusPermissions.Reset;
                        StatusPermissions.SetRange(StatusPermissions."User ID", UserId);
                        StatusPermissions.SetRange(StatusPermissions."Function", StatusPermissions."function"::"Overide Defaulters");
                        if StatusPermissions.Find('-') = false then
                            Error('You do not have permissions to change the account status.');
                    end;
                }
                field(Picture; Picture)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Signature; Signature)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Customer Posting Group"; "Customer Posting Group")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Blocked; Blocked)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Last Date Modified"; "Last Date Modified")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Last Payment Date"; "Last Payment Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Member House Group"; "Member House Group")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Housel Group';
                    Editable = false;
                    Visible = false;
                }
                field("Member House Group Name"; "Member House Group Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member House Group Name';
                    Editable = false;
                    Visible = false;
                }
                field("Member Needs House Group"; "Member Needs House Group")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("No of House Group Changes"; "No of House Group Changes")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("House Group Status"; "House Group Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Created By"; "Created By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            group("Employment Info")
            {
                Caption = 'Employment Info';
                field(Control1000000128; "Employment Info")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ShowMandatory = false;

                    trigger OnValidate()
                    begin
                        /*IF "Employment Info"="Employment Info"::Employed THEN BEGIN
                          EmployerCodeEditable:=TRUE;
                          DepartmentEditable:=TRUE;
                          TermsofEmploymentEditable:=TRUE;
                          ContractingEditable:=FALSE;
                          EmployedEditable:=FALSE;
                          OccupationEditable:=FALSE;
                          PositionHeldEditable:=TRUE;
                          EmploymentDateEditable:=TRUE;
                          EmployerAddressEditable:=TRUE;
                          NatureofBussEditable:=FALSE;
                          IndustryEditable:=FALSE;
                          BusinessNameEditable:=FALSE;
                          PhysicalBussLocationEditable:=FALSE;
                          YearOfCommenceEditable:=FALSE;
                        
                        
                        
                          END ELSE
                          IF "Employment Info"="Employment Info"::Contracting THEN BEGIN
                          ContractingEditable:=TRUE;
                          EmployerCodeEditable:=FALSE;
                          DepartmentEditable:=FALSE;
                          TermsofEmploymentEditable:=FALSE;
                          OccupationEditable:=FALSE;
                          PositionHeldEditable:=FALSE;
                          EmploymentDateEditable:=FALSE;
                          EmployerAddressEditable:=FALSE;
                          NatureofBussEditable:=FALSE;
                          IndustryEditable:=FALSE;
                          BusinessNameEditable:=FALSE;
                          PhysicalBussLocationEditable:=FALSE;
                          YearOfCommenceEditable:=FALSE;
                          END ELSE
                          IF "Employment Info"="Employment Info"::Others THEN BEGIN
                          OthersEditable:=TRUE;
                          ContractingEditable:=FALSE;
                          EmployerCodeEditable:=FALSE;
                          DepartmentEditable:=FALSE;
                          TermsofEmploymentEditable:=FALSE;
                          OccupationEditable:=FALSE;
                          PositionHeldEditable:=FALSE;
                          EmploymentDateEditable:=FALSE;
                          EmployerAddressEditable:=FALSE
                          END ELSE
                          IF "Employment Info"="Employment Info"::"Self-Employed" THEN BEGIN
                          OccupationEditable:=TRUE;
                          EmployerCodeEditable:=FALSE;
                          DepartmentEditable:=FALSE;
                          TermsofEmploymentEditable:=FALSE;
                          ContractingEditable:=FALSE;
                          EmployedEditable:=FALSE;
                          NatureofBussEditable:=TRUE;
                          IndustryEditable:=TRUE;
                          BusinessNameEditable:=TRUE;
                          PhysicalBussLocationEditable:=TRUE;
                          YearOfCommenceEditable:=TRUE;
                          PositionHeldEditable:=FALSE;
                          EmploymentDateEditable:=FALSE;
                          EmployerAddressEditable:=FALSE
                        
                        END;
                        
                        
                        
                        
                        IF "Identification Document"="Identification Document"::"ID Card" THEN BEGIN
                          PassportEditable:=FALSE;
                          IDNoEditable:=TRUE
                          END ELSE
                          IF "Identification Document"="Identification Document"::Passport THEN BEGIN
                          PassportEditable:=TRUE;
                          IDNoEditable:=FALSE
                          END ELSE
                          IF "Identification Document"="Identification Document"::Both THEN BEGIN
                          PassportEditable:=TRUE;
                          IDNoEditable:=TRUE;
                        END;
                        */

                    end;
                }
                field("Employer Code"; "Employer Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Employer Name"; "Employer Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ShowMandatory = false;
                }
                field("Station/Department"; "Station/Department")
                {
                    ApplicationArea = Basic;
                }
                field("Employer Address"; "Employer Address")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Department; Department)
                {
                    ApplicationArea = Basic;
                    Caption = 'WorkStation / Depot';
                    Editable = false;
                }
                field("Terms Of Employment"; "Terms Of Employment")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Date of Employment"; "Date of Employment")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Position Held"; "Position Held")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Expected Monthly Income"; "Expected Monthly Income")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Nature Of Business"; "Nature Of Business")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(Industry; Industry)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Business Name"; "Business Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Physical Business Location"; "Physical Business Location")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field("Year of Commence"; "Year of Commence")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Visible = false;
                }
                field(Occupation; Occupation)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Others Details"; "Others Details")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            group("Referee Details")
            {
                Visible = false;
                field("Referee Member No"; "Referee Member No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Referee Name"; "Referee Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Referee ID No"; "Referee ID No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Referee Mobile Phone No"; "Referee Mobile Phone No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            group("Member Risk Rating")
            {
                Editable = false;
                Visible = false;
                group("Member Risk Rate")
                {
                    field("Individual Category"; "Individual Category")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Member Residency Status"; "Member Residency Status")
                    {
                        ApplicationArea = Basic;
                    }
                    field(Entities; Entities)
                    {
                        ApplicationArea = Basic;
                    }
                    field("Industry Type"; "Industry Type")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Lenght Of Relationship"; "Lenght Of Relationship")
                    {
                        ApplicationArea = Basic;
                    }
                    field("International Trade"; "International Trade")
                    {
                        ApplicationArea = Basic;
                    }
                }
                group("Product Risk Rating")
                {
                    field("Electronic Payment"; "Electronic Payment")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Accounts Type Taken"; "Accounts Type Taken")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Cards Type Taken"; "Cards Type Taken")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Others(Channels)"; "Others(Channels)")
                    {
                        ApplicationArea = Basic;
                    }
                }
            }
            group(Joint2Details)
            {
                Caption = 'Joint2Details';
                Visible = Joint2DetailsVisible;
                field("Name 2"; "Name 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Name';
                    Editable = false;
                }
                field(Address3; Address3)
                {
                    ApplicationArea = Basic;
                    Caption = 'Address';
                    Editable = false;
                }
                field("Postal Code 2"; "Postal Code 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Postal Code';
                    Editable = false;
                }
                field("Town 2"; "Town 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Town';
                    Editable = false;
                }
                field("Mobile No. Three"; "Mobile No. Three")
                {
                    ApplicationArea = Basic;
                    Caption = 'Mobile No.';
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Date of Birth2"; "Date of Birth2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date of Birth';
                    Editable = false;
                }
                field("ID No.2"; "ID No.2")
                {
                    ApplicationArea = Basic;
                    Caption = 'ID No.';
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Passport 2"; "Passport 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Passport No.';
                    Editable = false;
                }
                field("Member Parish 2"; "Member Parish 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Parish';
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Member Parish Name 2"; "Member Parish Name 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Parish Name';
                    Editable = false;
                }
                field(Gender2; Gender2)
                {
                    ApplicationArea = Basic;
                    Caption = 'Gender';
                    Editable = false;
                }
                field("Marital Status2"; "Marital Status2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Marital Status';
                    Editable = false;
                }
                field("Home Postal Code2"; "Home Postal Code2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Home Postal Code';
                    Editable = false;
                }
                field("Home Town2"; "Home Town2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Home Town';
                    Editable = false;
                }
                field("Employer Code2"; "Employer Code2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employer Code';
                    Editable = false;
                }
                field("Employer Name2"; "Employer Name2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employer Name';
                    Editable = false;
                }
                field("E-Mail (Personal3)"; "E-Mail (Personal3)")
                {
                    ApplicationArea = Basic;
                    Caption = 'E-Mail (Personal)';
                    Editable = false;
                }
                field("Picture 2"; "Picture 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Picture';
                    Editable = false;
                }
                field("Signature  2"; "Signature  2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Signature';
                    Editable = false;
                }
            }
            group(Joint3Details)
            {
                Visible = Joint3DetailsVisible;
                field("Name 3"; "Name 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Name';
                    Editable = false;
                }
                field(Address4; Address4)
                {
                    ApplicationArea = Basic;
                    Caption = 'Regions';
                    Editable = false;
                }
                field("Postal Code 3"; "Postal Code 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Postal Code';
                    Editable = false;
                }
                field("Town 3"; "Town 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Town';
                    Editable = false;
                }
                field("Mobile No. 4"; "Mobile No. 4")
                {
                    ApplicationArea = Basic;
                    Caption = 'Mobile No.';
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Date of Birth3"; "Date of Birth3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date of Birth';
                    Editable = false;
                    ShowMandatory = true;
                }
                field("ID No.3"; "ID No.3")
                {
                    ApplicationArea = Basic;
                    Caption = 'ID No.';
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Passport 3"; "Passport 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Passport No.';
                    Editable = false;
                }
                field("Member Parish 3"; "Member Parish 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Parish';
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Member Parish Name 3"; "Member Parish Name 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Parish Name';
                    Editable = false;
                }
                field(Gender3; Gender3)
                {
                    ApplicationArea = Basic;
                    Caption = 'Gender';
                    Editable = false;
                }
                field("Marital Status3"; "Marital Status3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Marital Status';
                    Editable = false;
                }
                field("Home Postal Code3"; "Home Postal Code3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Home Postal Code';
                    Editable = false;
                }
                field("Home Town3"; "Home Town3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Home Town';
                    Editable = false;
                }
                field("Employer Code3"; "Employer Code3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employer Code';
                    Editable = false;
                }
                field("Employer Name3"; "Employer Name3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employer Name';
                    Editable = false;
                }
                field("E-Mail (Personal2)"; "E-Mail (Personal2)")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Picture 3"; "Picture 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Picture';
                    Editable = false;
                }
                field("Signature  3"; "Signature  3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Signature';
                    Editable = false;
                }
                field("Retirement Date"; "Retirement Date")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Contact Info")
            {
                Caption = 'Contact Info';
                Editable = true;
                field("E-Mail"; "E-Mail")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Email Indemnified"; "Email Indemnified")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Send E-Statements"; "Send E-Statements")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Home Page"; "Home Page")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Fax No."; "Fax No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Home Address"; "Home Address")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Home Postal Code"; "Home Postal Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(District; District)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Location; Location)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Sub-Location"; "Sub-Location")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Village/Residence"; "Village/Residence")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Contact Person"; "Contact Person")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Contact Person Phone"; "Contact Person Phone")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            group("Withdrawal Details")
            {
                Caption = 'Withdrawal Details';
                field("Withdrawal Application Date"; "Withdrawal Application Date")
                {
                    ApplicationArea = Basic;
                }
                field("Reason For Membership Withdraw"; "Reason For Membership Withdraw")
                {
                    ApplicationArea = Basic;
                    Caption = 'Reason For Withdrawal';
                }
                field("Withdrawal Date"; "Withdrawal Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Withdrawal Fee"; "Withdrawal Fee")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Status - Withdrawal App."; "Status - Withdrawal App.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Withdrawal Status';
                    Editable = false;
                }
            }
        }
        area(factboxes)
        {
            part(Control1000000052; "Member Statistics FactBox")
            {
                Caption = 'Member Statistics FactBox';
                SubPageLink = "No." = field("No.");
            }
            part(Control40; "Member Picture-Uploaded")
            {
                Editable = false;
                Enabled = false;
                SubPageLink = "No." = field("No.");
            }
            part(Control39; "Member Signature-Uploaded")
            {
                Editable = false;
                Enabled = false;
                SubPageLink = "No." = field("No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Member")
            {
                Caption = '&Member';
                action("Member Ledger Entries")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Ledger Entries';
                    Image = CustomerLedger;
                    Promoted = true;
                    PromotedOnly = true;
                    RunObject = Page "Member Ledger Entries";
                    RunPageLink = "Customer No." = field("No.");
                    RunPageView = sorting("Customer No.");
                }
                action(Dimensions)
                {
                    ApplicationArea = Basic;
                    Image = Dimensions;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "No." = field("No.");
                    Visible = false;
                }
                action("Bank Account")
                {
                    ApplicationArea = Basic;
                    Image = Card;
                    RunObject = Page "Customer Bank Account Card";
                    RunPageLink = "Customer No." = field("No.");
                    Visible = false;
                }
                action(Contacts)
                {
                    ApplicationArea = Basic;
                    Image = ContactPerson;
                    Visible = false;

                    trigger OnAction()
                    begin
                        ShowContact;
                    end;
                }
            }
            group(ActionGroup1102755023)
            {
                action("Members Kin Details List")
                {
                    ApplicationArea = Basic;
                    Caption = 'Members Kin Details List';
                    Image = Relationship;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "Members Nominee Details List";
                    RunPageLink = "Account No" = field("No.");
                }
                action("Account Signatories")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Signatories';
                    Image = CustomerContact;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "Member Account Signatory list";
                    RunPageLink = "Account No" = field("No.");
                }
                action("Account Agent Details")
                {
                    ApplicationArea = Basic;
                    Image = Group;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Member Agent Account list";
                    RunPageLink = "Account No" = field("No.");
                    Visible = false;
                }
                action("Member card")
                {
                    ApplicationArea = Basic;
                    Image = Account;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", "No.");
                        if Cust.FindFirst then begin
                            Report.Run(Report::Report51516279, true, false, Cust);
                        end;
                    end;
                }
                action("Members Statistics")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Details';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "Members Statistics";
                    RunPageLink = "No." = field("No.");
                }
                action("Member is  a Guarantor")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loans Guaranteed';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin

                        Cust.Reset;
                        Cust.SetRange(Cust."No.", "No.");
                        if Cust.Find('-') then
                            Report.Run(51516503, true, false, Cust);
                    end;
                }
                action("Member is  Guaranteed")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member is  Guaranteed';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", "No.");
                        if Cust.Find('-') then
                            Report.Run(51516504, true, false, Cust);
                        //51516482
                    end;
                }
                action("Create Withdrawal Application")
                {
                    ApplicationArea = Basic;
                    Image = Document;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to create a Withdrawal Application for this Member', false) = true then begin
                            SurestepFactory.FnCreateMembershipWithdrawalApplication("No.", "Withdrawal Application Date", "Reason For Membership Withdraw", "Withdrawal Date");
                        end;
                    end;
                }
                action("Account Statement Transactions ")
                {
                    ApplicationArea = Basic;
                    Image = Form;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Loan Appraisal Statement Buffe";
                    RunPageLink = "Loan No" = field("No.");
                    Visible = false;
                }
                action("FOSA Accounts")
                {
                    ApplicationArea = Basic;
                    Image = Users;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "FOSA Accounts Details Master";
                    RunPageLink = "BOSA Account No" = field("No.");
                }
                action("Member Deposit Saving History")
                {
                    ApplicationArea = Basic;
                    Image = Form;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Member Deposit Saving History";
                    RunPageLink = "Loan No" = field("No.");
                    Visible = false;
                }
                action("Load Account Statement Details")
                {
                    ApplicationArea = Basic;
                    Image = InsertAccount;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    var
                        ObjAccountLedger: Record "Detailed Vendor Ledg. Entry";
                        ObjStatementB: Record "Loan Appraisal Statement Buffe";
                        StatementStartDate: Date;
                        StatementDateFilter: Date;
                        StatementEndDate: Date;
                        VerStatementAvCredits: Decimal;
                        VerStatementsAvDebits: Decimal;
                        VerMonth1Date: Integer;
                        VerMonth1Month: Integer;
                        VerMonth1Year: Integer;
                        VerMonth1StartDate: Date;
                        VerMonth1EndDate: Date;
                        VerMonth1DebitAmount: Decimal;
                        VerMonth1CreditAmount: Decimal;
                        VerMonth2Date: Integer;
                        VerMonth2Month: Integer;
                        VerMonth2Year: Integer;
                        VerMonth2StartDate: Date;
                        VerMonth2EndDate: Date;
                        VerMonth2DebitAmount: Decimal;
                        VerMonth2CreditAmount: Decimal;
                        VerMonth3Date: Integer;
                        VerMonth3Month: Integer;
                        VerMonth3Year: Integer;
                        VerMonth3StartDate: Date;
                        VerMonth3EndDate: Date;
                        VerMonth3DebitAmount: Decimal;
                        VerMonth3CreditAmount: Decimal;
                        VerMonth4Date: Integer;
                        VerMonth4Month: Integer;
                        VerMonth4Year: Integer;
                        VerMonth4StartDate: Date;
                        VerMonth4EndDate: Date;
                        VerMonth4DebitAmount: Decimal;
                        VerMonth4CreditAmount: Decimal;
                        VerMonth5Date: Integer;
                        VerMonth5Month: Integer;
                        VerMonth5Year: Integer;
                        VerMonth5StartDate: Date;
                        VerMonth5EndDate: Date;
                        VerMonth5DebitAmount: Decimal;
                        VerMonth5CreditAmount: Decimal;
                        VerMonth6Date: Integer;
                        VerMonth6Month: Integer;
                        VerMonth6Year: Integer;
                        VerMonth6StartDate: Date;
                        VerMonth6EndDate: Date;
                        VerMonth6DebitAmount: Decimal;
                        VerMonth6CreditAmount: Decimal;
                        VarMonth1Datefilter: Text;
                        VarMonth2Datefilter: Text;
                        VarMonth3Datefilter: Text;
                        VarMonth4Datefilter: Text;
                        VarMonth5Datefilter: Text;
                        VarMonth6Datefilter: Text;
                        ObjMemberCellG: Record "Member House Groups";
                        TrunchDetailsVisible: Boolean;
                        ObjTranch: Record "Tranch Disburesment Details";
                        GenSetUp: Record "Sacco General Set-Up";
                    begin
                        //Clear Buffer
                        ObjStatementB.Reset;
                        ObjStatementB.SetRange(ObjStatementB."Loan No", "No.");
                        if ObjStatementB.FindSet then begin
                            ObjStatementB.DeleteAll;
                        end;



                        //Initialize Variables
                        VerMonth1CreditAmount := 0;
                        VerMonth1DebitAmount := 0;


                        VerMonth4CreditAmount := 0;
                        VerMonth4DebitAmount := 0;
                        VerMonth5CreditAmount := 0;
                        VerMonth5DebitAmount := 0;
                        VerMonth6CreditAmount := 0;
                        VerMonth6DebitAmount := 0;
                        GenSetUp.Get();

                        //Month 1
                        StatementStartDate := CalcDate(GenSetUp."Bank Statement Period", Today);
                        VerMonth1Date := Date2dmy(StatementStartDate, 1);
                        VerMonth1Month := Date2dmy(StatementStartDate, 2);
                        VerMonth1Year := Date2dmy(StatementStartDate, 3);


                        VerMonth1StartDate := Dmy2date(1, VerMonth1Month, VerMonth1Year);
                        VerMonth1EndDate := CalcDate('CM', VerMonth1StartDate);

                        VarMonth1Datefilter := Format(VerMonth1StartDate) + '..' + Format(VerMonth1EndDate);
                        VerMonth1CreditAmount := 0;
                        VerMonth1DebitAmount := 0;
                        ObjAccountLedger.Reset;
                        ObjAccountLedger.SetRange(ObjAccountLedger."Vendor No.", "FOSA Account No.");
                        ObjAccountLedger.SetFilter(ObjAccountLedger."Posting Date", VarMonth1Datefilter);
                        if ObjAccountLedger.FindSet then begin
                            repeat
                                if ObjAccountLedger.Amount > 0 then begin
                                    VerMonth1DebitAmount := VerMonth1DebitAmount + ObjAccountLedger.Amount
                                end else
                                    VerMonth1CreditAmount := VerMonth1CreditAmount + ObjAccountLedger.Amount;
                            until ObjAccountLedger.Next = 0;

                            ObjStatementB.Init;
                            ObjStatementB."Loan No" := "No.";
                            ObjStatementB."Transaction Date" := VerMonth1EndDate;
                            ObjStatementB."Transaction Description" := 'Month 1 Transactions';
                            ObjStatementB."Amount Out" := VerMonth1DebitAmount;
                            ObjStatementB."Amount In" := VerMonth1CreditAmount * -1;
                            ObjStatementB.Insert;

                        end;


                        //Month 2
                        StatementStartDate := CalcDate(GenSetUp."Bank Statement Period", Today);
                        VerMonth2Date := Date2dmy(StatementStartDate, 1);
                        VerMonth2Month := (VerMonth1Month + 1);
                        VerMonth2Year := Date2dmy(StatementStartDate, 3);

                        if VerMonth2Month > 12 then begin
                            VerMonth2Month := VerMonth2Month - 12;
                            VerMonth2Year := VerMonth2Year + 1;
                        end;

                        VerMonth2StartDate := Dmy2date(1, VerMonth2Month, VerMonth1Year);
                        VerMonth2EndDate := CalcDate('CM', VerMonth2StartDate);
                        VarMonth2Datefilter := Format(VerMonth2StartDate) + '..' + Format(VerMonth2EndDate);
                        VerMonth2CreditAmount := 0;
                        VerMonth2DebitAmount := 0;
                        ObjAccountLedger.Reset;
                        ObjAccountLedger.SetRange(ObjAccountLedger."Vendor No.", "FOSA Account No.");
                        ObjAccountLedger.SetFilter(ObjAccountLedger."Posting Date", VarMonth2Datefilter);
                        if ObjAccountLedger.FindSet then begin
                            repeat
                                if ObjAccountLedger.Amount > 0 then begin
                                    VerMonth2DebitAmount := VerMonth2DebitAmount + ObjAccountLedger.Amount
                                end else
                                    VerMonth2CreditAmount := VerMonth2CreditAmount + ObjAccountLedger.Amount;
                            until ObjAccountLedger.Next = 0;

                            ObjStatementB.Init;
                            ObjStatementB."Loan No" := "No.";
                            ObjStatementB."Transaction Date" := VerMonth2EndDate;
                            ObjStatementB."Transaction Description" := 'Month 2 Transactions';
                            ObjStatementB."Amount Out" := VerMonth2DebitAmount;
                            ObjStatementB."Amount In" := VerMonth2CreditAmount * -1;
                            ObjStatementB.Insert;

                        end;

                        VerMonth3CreditAmount := 0;
                        VerMonth3DebitAmount := 0;
                        //Month 3
                        StatementStartDate := CalcDate(GenSetUp."Bank Statement Period", Today);
                        VerMonth3Date := Date2dmy(StatementStartDate, 1);
                        VerMonth3Month := (VerMonth1Month + 2);
                        VerMonth3Year := Date2dmy(StatementStartDate, 3);

                        if VerMonth3Month > 12 then begin
                            VerMonth3Month := VerMonth3Month - 12;
                            VerMonth3Year := VerMonth3Year + 1;
                        end;

                        VerMonth3StartDate := Dmy2date(1, VerMonth3Month, VerMonth3Year);
                        VerMonth3EndDate := CalcDate('CM', VerMonth3StartDate);
                        VarMonth3Datefilter := Format(VerMonth3StartDate) + '..' + Format(VerMonth3EndDate);
                        VerMonth3CreditAmount := 0;
                        VerMonth3DebitAmount := 0;
                        ObjAccountLedger.Reset;
                        ObjAccountLedger.SetRange(ObjAccountLedger."Vendor No.", "FOSA Account No.");
                        ObjAccountLedger.SetFilter(ObjAccountLedger."Posting Date", VarMonth3Datefilter);
                        if ObjAccountLedger.FindSet then begin
                            repeat
                                if ObjAccountLedger.Amount > 0 then begin
                                    VerMonth3DebitAmount := VerMonth3DebitAmount + ObjAccountLedger.Amount
                                end else
                                    VerMonth3CreditAmount := VerMonth3CreditAmount + ObjAccountLedger.Amount;
                            until ObjAccountLedger.Next = 0;

                            ObjStatementB.Init;
                            ObjStatementB."Loan No" := "No.";
                            ObjStatementB."Transaction Date" := VerMonth3EndDate;
                            ObjStatementB."Transaction Description" := 'Month 3 Transactions';
                            ObjStatementB."Amount Out" := VerMonth3DebitAmount;
                            ObjStatementB."Amount In" := VerMonth3CreditAmount * -1;
                            ObjStatementB.Insert;
                        end;


                        //Month 4
                        StatementStartDate := CalcDate(GenSetUp."Bank Statement Period", Today);
                        VerMonth4Date := Date2dmy(StatementStartDate, 1);
                        VerMonth4Month := (VerMonth1Month + 3);
                        VerMonth4Year := Date2dmy(StatementStartDate, 3);

                        if VerMonth4Month > 12 then begin
                            VerMonth4Month := VerMonth4Month - 12;
                            VerMonth4Year := VerMonth4Year + 1;
                        end;

                        VerMonth4StartDate := Dmy2date(1, VerMonth4Month, VerMonth4Year);
                        VerMonth4EndDate := CalcDate('CM', VerMonth4StartDate);
                        VarMonth4Datefilter := Format(VerMonth4StartDate) + '..' + Format(VerMonth4EndDate);

                        VerMonth4CreditAmount := 0;
                        VerMonth4DebitAmount := 0;
                        ObjAccountLedger.Reset;
                        ObjAccountLedger.SetRange(ObjAccountLedger."Vendor No.", "FOSA Account No.");
                        ObjAccountLedger.SetFilter(ObjAccountLedger."Posting Date", VarMonth4Datefilter);
                        if ObjAccountLedger.FindSet then begin
                            repeat
                                if ObjAccountLedger.Amount > 0 then begin
                                    VerMonth4DebitAmount := VerMonth4DebitAmount + ObjAccountLedger.Amount
                                end else
                                    VerMonth4CreditAmount := VerMonth4CreditAmount + ObjAccountLedger.Amount;
                            until ObjAccountLedger.Next = 0;

                            ObjStatementB.Init;
                            ObjStatementB."Loan No" := "No.";
                            ObjStatementB."Transaction Date" := VerMonth4EndDate;
                            ObjStatementB."Transaction Description" := 'Month 4 Transactions';
                            ObjStatementB."Amount Out" := VerMonth4DebitAmount;
                            ObjStatementB."Amount In" := VerMonth4CreditAmount * -1;
                            ObjStatementB.Insert;
                        end;


                        //Month 5
                        StatementStartDate := CalcDate(GenSetUp."Bank Statement Period", Today);
                        VerMonth5Date := Date2dmy(StatementStartDate, 1);
                        VerMonth5Month := (VerMonth1Month + 4);
                        VerMonth5Year := Date2dmy(StatementStartDate, 3);

                        if VerMonth5Month > 12 then begin
                            VerMonth5Month := VerMonth5Month - 12;
                            VerMonth5Year := VerMonth5Year + 1;
                        end;

                        VerMonth5StartDate := Dmy2date(1, VerMonth5Month, VerMonth5Year);
                        VerMonth5EndDate := CalcDate('CM', VerMonth5StartDate);
                        VarMonth5Datefilter := Format(VerMonth5StartDate) + '..' + Format(VerMonth5EndDate);

                        VerMonth5CreditAmount := 0;
                        VerMonth5DebitAmount := 0;
                        ObjAccountLedger.Reset;
                        ObjAccountLedger.SetRange(ObjAccountLedger."Vendor No.", "FOSA Account No.");
                        ObjAccountLedger.SetFilter(ObjAccountLedger."Posting Date", VarMonth5Datefilter);
                        if ObjAccountLedger.FindSet then begin
                            repeat
                                if ObjAccountLedger.Amount > 0 then begin
                                    VerMonth5DebitAmount := VerMonth5DebitAmount + ObjAccountLedger.Amount
                                end else
                                    VerMonth5CreditAmount := VerMonth5CreditAmount + ObjAccountLedger.Amount;
                            until ObjAccountLedger.Next = 0;

                            ObjStatementB.Init;
                            ObjStatementB."Loan No" := "No.";
                            ObjStatementB."Transaction Date" := VerMonth5EndDate;
                            ObjStatementB."Transaction Description" := 'Month 5 Transactions';
                            ObjStatementB."Amount Out" := VerMonth5DebitAmount;
                            ObjStatementB."Amount In" := VerMonth5CreditAmount * -1;
                            ObjStatementB.Insert;
                        end;


                        //Month 6
                        StatementStartDate := CalcDate(GenSetUp."Bank Statement Period", Today);
                        VerMonth6Date := Date2dmy(StatementStartDate, 1);
                        VerMonth6Month := (VerMonth1Month + 5);
                        VerMonth6Year := Date2dmy(StatementStartDate, 3);

                        if VerMonth6Month > 12 then begin
                            VerMonth6Month := VerMonth6Month - 12;
                            VerMonth6Year := VerMonth6Year + 1;
                        end;

                        VerMonth6StartDate := Dmy2date(1, VerMonth6Month, VerMonth6Year);
                        VerMonth6EndDate := CalcDate('CM', VerMonth6StartDate);
                        VarMonth6Datefilter := Format(VerMonth6StartDate) + '..' + Format(VerMonth6EndDate);

                        VerMonth6CreditAmount := 0;
                        VerMonth6DebitAmount := 0;
                        ObjAccountLedger.Reset;
                        ObjAccountLedger.SetRange(ObjAccountLedger."Vendor No.", "FOSA Account No.");
                        ObjAccountLedger.SetFilter(ObjAccountLedger."Posting Date", VarMonth6Datefilter);
                        if ObjAccountLedger.FindSet then begin
                            repeat

                                if ObjAccountLedger.Amount > 0 then begin
                                    VerMonth6DebitAmount := VerMonth6DebitAmount + ObjAccountLedger.Amount
                                end else
                                    VerMonth6CreditAmount := VerMonth6CreditAmount + ObjAccountLedger.Amount;
                            until ObjAccountLedger.Next = 0;

                            ObjStatementB.Init;
                            ObjStatementB."Loan No" := "No.";
                            ObjStatementB."Transaction Date" := VerMonth6EndDate;
                            ObjStatementB."Transaction Description" := 'Month 6 Transactions';
                            ObjStatementB."Amount Out" := VerMonth6DebitAmount;
                            ObjStatementB."Amount In" := VerMonth6CreditAmount * -1;
                            ObjStatementB.Insert;
                        end;


                        //Get Statement Avarage Credits
                        ObjStatementB.Reset;
                        ObjStatementB.SetRange(ObjStatementB."Loan No", "No.");
                        //ObjStatementB.SETFILTER(ObjStatementB.Amount,'<%1',0);
                        if ObjStatementB.FindSet then begin
                            repeat
                                VerStatementAvCredits := VerStatementAvCredits + ObjStatementB."Amount In";
                            //"Bank Statement Avarage Credits":=VerStatementAvCredits/6;
                            //MODIFY/
                            until ObjStatementB.Next = 0;
                        end;

                        //Get Statement Avarage Debits
                        ObjStatementB.Reset;
                        ObjStatementB.SetRange(ObjStatementB."Loan No", "No.");
                        //ObjStatementB.SETFILTER(ObjStatementB.Amount,'>%1',0);
                        if ObjStatementB.FindSet then begin
                            repeat
                                VerStatementsAvDebits := VerStatementsAvDebits + ObjStatementB."Amount Out";
                            //"Bank Statement Avarage Debits":=VerStatementsAvDebits/6;
                            //MODIFY;
                            until ObjStatementB.Next = 0;
                        end;

                        //"Bank Statement Net Income":="Bank Statement Avarage Credits"-"Bank Statement Avarage Debits";
                        //MODIFY;
                    end;
                }
                action("Loan Other Securities")
                {
                    ApplicationArea = Basic;
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", "No.");
                        if Cust.Find('-') then
                            Report.Run(51516979, true, false, Cust);
                    end;
                }
                group(Reports)
                {
                    Caption = 'Reports';
                }
                action("Detailed Statement")
                {
                    ApplicationArea = Basic;
                    Caption = 'Detailed Statement';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        if ("Assigned System ID" <> '') then begin //AND ("Assigned System ID"<>USERID)
                            if UserSetup.Get(UserId) then begin
                                if UserSetup."View Special Accounts" = false then Error('You do not have permission to view this account Details, Contact your system administrator! ')
                            end;
                        end;

                        Cust.Reset;
                        Cust.SetRange(Cust."No.", "No.");
                        if Cust.Find('-') then
                            Report.Run(51516886, true, false, Cust);
                    end;
                }
                action("Loan Arrears")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", "No.");
                        if Cust.Find('-') then
                            Report.Run(51516974, true, false, Cust);
                    end;
                }
                action("Loan Statement BOSA")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;

                    trigger OnAction()
                    begin

                        Cust.Reset;
                        Cust.SetRange(Cust."No.", "No.");
                        if Cust.Find('-') then
                            Report.Run(51516531, true, false, Cust);
                    end;
                }
                action("Member Deposit Statement")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", "No.");
                        if Cust.Find('-') then
                            Report.Run(51516354, true, false, Cust);
                    end;
                }
                action("Detailed Interest Statement")
                {
                    ApplicationArea = Basic;
                    Caption = 'Detailed Interest Statement';
                    Image = "Report";
                    Visible = false;

                    trigger OnAction()
                    begin
                        /*Cust.RESET;
                        Cust.SETRANGE(Cust."No.","No.");
                        IF Cust.FIND('-') THEN
                        REPORT.RUN(,TRUE,FALSE,Cust);
                        */

                    end;
                }
                action("Loan Statement FOSA")
                {
                    ApplicationArea = Basic;
                    Caption = 'Loan Statement FOSA';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", "No.");
                        if Cust.Find('-') then
                            Report.Run(51516533, true, false, Cust);

                        /*
                        Cust.RESET;
                        Cust.SETRANGE(Cust."No.","No.");
                        IF Cust.FIND('-') THEN
                        REPORT.RUN(51516474,TRUE,FALSE,Cust);
                        */

                    end;
                }
                action("FOSA Statement")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Vend.Reset;
                        Vend.SetRange(Vend."No.", "FOSA Account No.");
                        if Vend.Find('-') then begin
                            Report.Run(51516890, true, false, Vend);
                        end;


                        /*Cust.RESET;
                        Cust.SETRANGE(Cust."FOSA Account No.","FOSA Account No.");
                        IF Cust.FIND('-') THEN
                        REPORT.RUN(51516890,TRUE,FALSE,Cust);
                        */

                    end;
                }
                action("Check Off Slip")
                {
                    ApplicationArea = Basic;
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", "No.");
                        if Cust.Find('-') then
                            Report.Run(51516456, true, false, Cust);
                    end;
                }
                group("Issued Documents")
                {
                    Caption = 'Issued Documents';
                    Visible = false;
                }
                action("Account Closure Slip")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account Closure Slip';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedOnly = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Cust.Reset;
                        Cust.SetRange(Cust."No.", "No.");
                        if Cust.Find('-') then
                            Report.Run(51516474, true, false, Cust);
                    end;
                }
                action("Create Board Portal Login")
                {
                    ApplicationArea = Basic;
                    Image = Alerts;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        CustMembr := Rec;
                        UserSetup.Get('JMUTUKU');
                        if UserSetup."Portal Creator" = true then begin
                            AdminPortal.FnCreateUser(CustMembr."No.", CustMembr."ID No.", CustMembr."ID No.");
                            Message('Board Member Password generated successfully')
                        end else
                            Message('Contact Administrator,You do not have Rights to Perform this Action')
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        FosaName := '';

        if "FOSA Account No." <> '' then begin
            if Vend.Get("FOSA Account No.") then begin
                FosaName := Vend.Name;
            end;
        end;

        lblIDVisible := true;
        lblDOBVisible := true;
        lblRegNoVisible := false;
        lblRegDateVisible := false;
        lblGenderVisible := true;
        txtGenderVisible := true;
        lblMaritalVisible := true;
        txtMaritalVisible := true;

        if "Account Category" <> "account category"::Single then begin
            lblIDVisible := false;
            lblDOBVisible := false;
            lblRegNoVisible := true;
            lblRegDateVisible := true;
            lblGenderVisible := false;
            txtGenderVisible := false;
            lblMaritalVisible := false;
            txtMaritalVisible := false;

        end;
        OnAfterGetCurrRecord;

        Statuschange.Reset;
        Statuschange.SetRange(Statuschange."User ID", UserId);
        Statuschange.SetRange(Statuschange."Function", Statuschange."function"::"Account Status");
        if not Statuschange.Find('-') then
            CurrPage.Editable := false
        else
            CurrPage.Editable := true;

        Joint2DetailsVisible := false;
        Joint3DetailsVisible := false;
        if "Account Category" <> "account category"::Joint then begin
            Joint2DetailsVisible := false;
        end else
            Joint2DetailsVisible := true;

        if "Account Category" <> "account category"::Joint then begin
            Joint3DetailsVisible := false;
        end else
            Joint3DetailsVisible := true;
    end;

    trigger OnFindRecord(Which: Text): Boolean
    var
        RecordFound: Boolean;
    begin
        RecordFound := Find(Which);
        CurrPage.Editable := RecordFound or (GetFilter("No.") = '');
        exit(RecordFound);
    end;

    trigger OnInit()
    begin
        txtMaritalVisible := true;
        lblMaritalVisible := true;
        txtGenderVisible := true;
        lblGenderVisible := true;
        lblRegDateVisible := true;
        lblRegNoVisible := true;
        lblDOBVisible := true;
        lblIDVisible := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Customer Type" := "customer type"::Member;
        Status := Status::Active;
        "Customer Posting Group" := 'BOSA';
        "Registration Date" := Today;
        Advice := true;
        "Advice Type" := "advice type"::"New Member";
        if GeneralSetup.Get(0) then begin
            "Welfare Contribution" := GeneralSetup."Welfare Contribution";
            "Registration Fee" := GeneralSetup."Registration Fee";

        end;
    end;

    trigger OnOpenPage()
    var
        MapMgt: Codeunit "Online Map Management";
    begin
        ActivateFields;
        /*
        IF NOT MapMgt.TestSetup THEN
          CurrForm.MapPoint.VISIBLE(FALSE);
        */

        Joint2DetailsVisible := false;
        Joint3DetailsVisible := false;

        if "Account Category" <> "account category"::Joint then begin
            Joint2DetailsVisible := false;
        end else
            Joint2DetailsVisible := true;

        if "Account Category" <> "account category"::Joint then begin
            Joint3DetailsVisible := false;
        end else
            Joint3DetailsVisible := true;


        if ("Assigned System ID" <> '') and ("Assigned System ID" <> UserId) then begin
            Error('You do not have permission to view account');
        end;

    end;

    var
        CustomizedCalEntry: Record "Customized Calendar Entry";
        Text001: label 'Do you want to allow payment tolerance for entries that are currently open?';
        CustomizedCalendar: Record "Customized Calendar Change";
        Text002: label 'Do you want to remove payment tolerance from entries that are currently open?';
        CalendarMgmt: Codeunit "Calendar Management";
        PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
        PictureExists: Boolean;
        GenJournalLine: Record "Gen. Journal Line";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        StatusPermissions: Record "Status Change Permision";
        Charges: Record Charges;
        Vend: Record Vendor;
        Cust: Record "Member Register";
        LineNo: Integer;
        UsersID: Record User;
        GeneralSetup: Record "Sacco General Set-Up";
        Loans: Record "Loans Register";
        AvailableShares: Decimal;
        Gnljnline: Record "Gen. Journal Line";
        Interest: Decimal;
        LineN: Integer;
        LRepayment: Decimal;
        TotalRecovered: Decimal;
        LoanAllocation: Decimal;
        LGurantors: Record "Loans Guarantee Details";
        LoansR: Record "Loans Register";
        DActivity: Code[20];
        DBranch: Code[20];
        Accounts: Record Vendor;
        FosaName: Text[50];
        [InDataSet]
        lblIDVisible: Boolean;
        [InDataSet]
        lblDOBVisible: Boolean;
        [InDataSet]
        lblRegNoVisible: Boolean;
        [InDataSet]
        lblRegDateVisible: Boolean;
        [InDataSet]
        lblGenderVisible: Boolean;
        [InDataSet]
        txtGenderVisible: Boolean;
        [InDataSet]
        lblMaritalVisible: Boolean;
        [InDataSet]
        txtMaritalVisible: Boolean;
        AccNo: Code[20];
        Vendor: Record Vendor;
        TotalAvailable: Decimal;
        TotalFOSALoan: Decimal;
        TotalOustanding: Decimal;
        TotalDefaulterR: Decimal;
        value2: Decimal;
        Value1: Decimal;
        RoundingDiff: Decimal;
        Statuschange: Record "Status Change Permision";
        "WITHDRAWAL FEE": Decimal;
        "AMOUNTTO BE RECOVERED": Decimal;
        "Remaining Amount": Decimal;
        TotalInsuarance: Decimal;
        PrincipInt: Decimal;
        TotalLoansOut: Decimal;
        FileMovementTracker: Record "File Movement Tracker";
        EntryNo: Integer;
        ApprovalsSetup: Record "Approvals Set Up";
        MovementTracker: Record "Movement Tracker";
        ApprovalUsers: Record "Approvals Users Set Up";
        "Change Log": Integer;
        openf: File;
        FMTRACK: Record "File Movement Tracker";
        CurrLocation: Code[30];
        "Number of days": Integer;
        Approvals: Record "Approvals Set Up";
        Description: Text[30];
        Section: Code[10];
        station: Code[10];
        MoveStatus: Record "File Movement Status";
        Joint2DetailsVisible: Boolean;
        Joint3DetailsVisible: Boolean;
        GuarantorAllocationAmount: Decimal;
        CummulativeGuaranteeAmount: Decimal;
        UserSetup: Record "User Setup";
        JointNameVisible: Boolean;
        SurestepFactory: Codeunit "SURESTEP Factory";
        ReasonforWithdrawal: Option Relocation,"Financial Constraints","House/Group Challages","Join another Institution","Personal Reasons",Other;
        SFactory: Codeunit "SURESTEP Factory";
        ObjMembershipApp: Record "Membership Applications";
        OnlineUser: Record "Online Users";
        AdminPortal: Codeunit AdminPortal;
        CustMembr: Record "Member Register";


    procedure ActivateFields()
    begin
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        ActivateFields;
    end;
}

