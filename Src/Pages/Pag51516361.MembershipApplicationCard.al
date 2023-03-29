#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516361 "Membership Application Card"
{
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    SourceTable = "Membership Applications";

    layout
    {
        area(content)
        {
            group("General Info")
            {
                Caption = 'General Info';
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'No.';
                    Editable = false;
                }
                field("Assigned No."; "Assigned No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Enabled = false;
                }
                field("Account Category"; "Account Category")
                {
                    ApplicationArea = Basic;
                    Editable = AccountCategoryEditable;
                    OptionCaption = 'Individual,Joint,Institutional,Group';

                    trigger OnValidate()
                    begin
                        Joint2DetailsVisible := false;
                        Joint3DetailsVisible := false;

                        if "Account Category" = "account category"::Joint then begin
                            Joint2DetailsVisible := true;
                            Joint3DetailsVisible := true;
                        end;
                        if "Account Category" = "account category"::Single then begin
                            Joint2DetailsVisible := false;
                            Joint3DetailsVisible := false;
                        end;
                        CurrPage.Update;
                    end;
                }
                field("Member Class"; "Member Class")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Joint Account Name"; "Joint Account Name")
                {
                    ApplicationArea = Basic;
                    Visible = Joint2DetailsVisible;

                    trigger OnValidate()
                    begin
                        Name := "Joint Account Name"
                    end;
                }
                field("First Name"; "First Name")
                {
                    ApplicationArea = Basic;
                    Editable = FirstNameEditable;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        Name := "First Name";
                    end;
                }
                field("Middle Name"; "Middle Name")
                {
                    ApplicationArea = Basic;
                    Editable = MiddleNameEditable;
                    ShowMandatory = false;

                    trigger OnValidate()
                    begin
                        if "Account Category" = "account category"::Joint then begin
                            // Name:="First Name"+' '+"First Name2";
                            Name := "Joint Account Name";
                        end else begin
                            Name := "First Name" + ' ' + "Middle Name";
                        end;
                    end;
                }
                field("Last Name"; "Last Name")
                {
                    ApplicationArea = Basic;
                    Editable = LastNameEditable;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin

                        if "Account Category" = "account category"::Joint then begin
                            // Name:="First Name"+' '+"First Name2"+"First Name3";
                            Name := "Joint Account Name";
                        end else begin
                            Name := "First Name" + ' ' + "Middle Name" + ' ' + "Last Name";

                        end;
                    end;
                }
                field(Name; Name)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Registration No"; "Registration No")
                {
                    ApplicationArea = Basic;
                }
                field("Contact Person"; "Contact Person")
                {
                    ApplicationArea = Basic;
                }
                field("Contact Person Phone"; "Contact Person Phone")
                {
                    ApplicationArea = Basic;
                }
                field("Payroll No"; "Payroll No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Payroll No.';
                    Editable = PayrollNoEditable;
                    ShowMandatory = false;
                }
                field(Address; Address)
                {
                    ApplicationArea = Basic;
                    Editable = AddressEditable;
                    ShowMandatory = true;
                }
                field("Postal Code"; "Postal Code")
                {
                    ApplicationArea = Basic;
                    Editable = PostCodeEditable;
                    ShowMandatory = true;
                }
                field(Town; Town)
                {
                    ApplicationArea = Basic;
                    Editable = TownEditable;
                }
                field("Country/Region Code"; "Country/Region Code")
                {
                    ApplicationArea = Basic;
                    Editable = CountryEditable;
                }
                field(County; County)
                {
                    ApplicationArea = Basic;
                    Editable = CountryEditable;
                    Visible = false;
                }
                field(Region; Region)
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;
                }
                field("Mobile Phone No"; "Mobile Phone No")
                {
                    ApplicationArea = Basic;
                    Editable = MobileEditable;
                    ShowMandatory = true;
                }
                field("Secondary Mobile No"; "Secondary Mobile No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Telephone No';
                    Editable = SecondaryMobileEditable;
                }
                field("E-Mail (Personal)"; "E-Mail (Personal)")
                {
                    ApplicationArea = Basic;
                    Caption = 'E-Mail';
                    Editable = EmailEdiatble;
                }
                field("Date of Birth"; "Date of Birth")
                {
                    ApplicationArea = Basic;
                    Editable = DOBEditable;
                    ShowMandatory = true;
                }
                field(Age; Age)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ID No."; "ID No.")
                {
                    ApplicationArea = Basic;
                    Editable = IDNoEditable;
                    ShowMandatory = true;
                }
                field("Passport No."; "Passport No.")
                {
                    ApplicationArea = Basic;
                    Editable = PassportEditable;
                }
                field("KRA PIN"; "KRA PIN")
                {
                    ApplicationArea = Basic;
                    Editable = KRAPinEditable;
                    ShowMandatory = false;
                }
                field("Member Share Class"; "Member Share Class")
                {
                    ApplicationArea = Basic;
                    Editable = ShareClassEditable;
                    ShowMandatory = true;
                    Visible = false;
                }
                field(Gender; Gender)
                {
                    ApplicationArea = Basic;
                    Editable = GenderEditable;
                    OptionCaption = ' ,Male,Female';
                    ShowMandatory = true;
                }
                field("Marital Status"; "Marital Status")
                {
                    ApplicationArea = Basic;
                    Editable = MaritalstatusEditable;
                }
                field("How Did you know About Us"; "How Did you know About Us")
                {
                    ApplicationArea = Basic;
                    Caption = 'How Did you know About Us';
                    Editable = MaritalstatusEditable;
                }
                field("Recruited By"; "Recruited By")
                {
                    ApplicationArea = Basic;
                    Editable = RecruitedByEditable;
                }
                field("Recruiter Name"; "Recruiter Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Captured By"; "Captured By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Created By"; "Created By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Application Category"; "Application Category")
                {
                    ApplicationArea = Basic;
                    Editable = AppCategoryEditable;
                }
                field("Registration Date"; "Registration Date")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(Picture; Picture)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Signature; Signature)
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Signing Instructions"; "Signing Instructions")
                {
                    ApplicationArea = Basic;
                }
                field("Customer Posting Group"; "Customer Posting Group")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Status; Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Monthly Contribution"; "Monthly Contribution")
                {
                    ApplicationArea = Basic;
                    Editable = MonthlyContributionEdit;
                    ShowMandatory = true;
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
                    ShowMandatory = true;
                }
                field("Member's Residence"; "Member's Residence")
                {
                    ApplicationArea = Basic;
                    Editable = MemberResidenceEditable;
                    Visible = false;
                }
            }
            group("Employment Details")
            {
                Caption = 'Employment Details';
                field("Employment Info"; "Employment Info")
                {
                    ApplicationArea = Basic;
                    Editable = EmploymentInfoEditable;

                    trigger OnValidate()
                    begin
                        if "Employment Info" = "employment info"::Employed then begin
                            EmployerCodeEditable := true;
                            DepartmentEditable := true;
                            TermsofEmploymentEditable := true;
                            ContractingEditable := false;
                            EmployedEditable := false;
                            OccupationEditable := false

                        end else
                            if "Employment Info" = "employment info"::Contracting then begin
                                ContractingEditable := true;
                                EmployerCodeEditable := false;
                                DepartmentEditable := false;
                                TermsofEmploymentEditable := false;
                                OccupationEditable := false;
                            end else
                                if "Employment Info" = "employment info"::Others then begin
                                    OthersEditable := true;
                                    ContractingEditable := false;
                                    EmployerCodeEditable := false;
                                    DepartmentEditable := false;
                                    TermsofEmploymentEditable := false;
                                    OccupationEditable := false
                                end else
                                    if "Employment Info" = "employment info"::UnEmployed then begin
                                        OccupationEditable := true;
                                        EmployerCodeEditable := false;
                                        DepartmentEditable := false;
                                        TermsofEmploymentEditable := false;
                                        ContractingEditable := false;
                                        EmployedEditable := false

                                    end;
                    end;
                }
                field("Employer Code"; "Employer Code")
                {
                    ApplicationArea = Basic;
                    Editable = EmployerCodeEditable;
                    ShowMandatory = true;
                }
                field("Employer Name"; "Employer Name")
                {
                    ApplicationArea = Basic;
                    Editable = EmployedEditable;
                }
                field(Department; Department)
                {
                    ApplicationArea = Basic;
                    Caption = 'WorkStation / Depot';
                    Editable = DepartmentEditable;
                    Visible = false;
                }
                field("Terms of Employment"; "Terms of Employment")
                {
                    ApplicationArea = Basic;
                    Editable = TermsofEmploymentEditable;
                    ShowMandatory = true;
                }
                field(Occupation; Occupation)
                {
                    ApplicationArea = Basic;
                    Editable = OccupationEditable;
                }
                field("Others Details"; "Others Details")
                {
                    ApplicationArea = Basic;
                    Editable = OthersEditable;
                }
            }
            group("Bank Details")
            {
                Caption = 'Bank Details';
                field("Bank Code"; "Bank Code")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Name"; "Bank Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Bank Branch"; "Bank Branch")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Account No"; "Bank Account No")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Joint2Details)
            {
                Caption = 'Joint2Details';
                Visible = Joint2DetailsVisible;
                field("First Name2"; "First Name2")
                {
                    ApplicationArea = Basic;
                    Caption = 'First Name';
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        "Name 2" := "First Name2";
                    end;
                }
                field("Middle Name2"; "Middle Name2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Middle Name';
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        "Name 2" := "First Name2" + ' ' + "Middle Name2";
                    end;
                }
                field("Last Name2"; "Last Name2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Last Name';
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        "Name 2" := "First Name2" + ' ' + "Middle Name2" + ' ' + "Last Name2";
                    end;
                }
                field("Name 2"; "Name 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Name';
                    Editable = false;
                }
                field("Payroll/Staff No2"; "Payroll/Staff No2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Payroll No';
                }
                field(Address3; Address3)
                {
                    ApplicationArea = Basic;
                    Caption = 'Address';
                }
                field("Postal Code 2"; "Postal Code 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Postal Code';
                }
                field("Town 2"; "Town 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Town';
                }
                field("Mobile No. 3"; "Mobile No. 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Mobile No.';
                    ShowMandatory = true;
                }
                field("Date of Birth2"; "Date of Birth2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date of Birth';
                }
                field("ID No.2"; "ID No.2")
                {
                    ApplicationArea = Basic;
                    Caption = 'ID No.';
                    ShowMandatory = true;
                }
                field("Passport 2"; "Passport 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Passport No.';
                }
                field(Gender2; Gender2)
                {
                    ApplicationArea = Basic;
                    Caption = 'Gender';
                    ShowMandatory = true;
                }
                field("Marital Status2"; "Marital Status2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Marital Status';
                }
                field("Home Postal Code2"; "Home Postal Code2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Home Postal Code';
                }
                field("Home Town2"; "Home Town2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Home Town';
                }
                field("Employer Code2"; "Employer Code2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employer Code';
                }
                field("Employer Name2"; "Employer Name2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employer Name';
                }
                field("E-Mail (Personal2)"; "E-Mail (Personal2)")
                {
                    ApplicationArea = Basic;
                    Caption = 'E-Mail';
                }
                field("Picture 2"; "Picture 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Picture';
                }
                field("Signature  2"; "Signature  2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Signature';
                }
            }
            group(Joint3Details)
            {
                Visible = Joint3DetailsVisible;
                field("First Name3"; "First Name3")
                {
                    ApplicationArea = Basic;
                    Caption = 'First Name';
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        "Name 3" := "First Name3";
                    end;
                }
                field("Middle Name 3"; "Middle Name 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Middle Name';
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        "Name 3" := "First Name3" + ' ' + "Middle Name 3";
                    end;
                }
                field("Last Name3"; "Last Name3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Last Name';
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        "Name 3" := "First Name3" + ' ' + "Middle Name 3" + ' ' + "Last Name3";
                    end;
                }
                field("Name 3"; "Name 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Name';
                    Editable = false;
                }
                field("Payroll/Staff No3"; "Payroll/Staff No3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Payroll/Staff No';
                    ShowMandatory = true;
                }
                field(Address4; Address4)
                {
                    ApplicationArea = Basic;
                    Caption = 'Address';
                }
                field("Postal Code 3"; "Postal Code 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Postal Code';
                }
                field("Town 3"; "Town 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Town';
                }
                field("Mobile No. 4"; "Mobile No. 4")
                {
                    ApplicationArea = Basic;
                    Caption = 'Mobile No.';
                    ShowMandatory = true;
                }
                field("Date of Birth3"; "Date of Birth3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date of Birth';
                    ShowMandatory = true;
                }
                field("ID No.3"; "ID No.3")
                {
                    ApplicationArea = Basic;
                    Caption = 'ID No.';
                    ShowMandatory = true;
                }
                field("Passport 3"; "Passport 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Passport No.';
                }
                field(Gender3; Gender3)
                {
                    ApplicationArea = Basic;
                    Caption = 'Gender';
                    ShowMandatory = true;
                }
                field("Marital Status3"; "Marital Status3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Marital Status';
                }
                field("Home Postal Code3"; "Home Postal Code3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Home Postal Code';
                }
                field("Home Town3"; "Home Town3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Home Town';
                }
                field("Employer Code3"; "Employer Code3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employer Code';
                }
                field("Employer Name3"; "Employer Name3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employer Name';
                }
                field("E-Mail (Personal3)"; "E-Mail (Personal3)")
                {
                    ApplicationArea = Basic;
                }
                field("Picture 3"; "Picture 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Picture';
                }
                field("Signature  3"; "Signature  3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Signature';
                }
            }
        }
        area(factboxes)
        {
            part(Control1000000032; "Member Picture-App")
            {
                ApplicationArea = All;
                Caption = 'Picture';
                Editable = MobileEditable;
                Enabled = MobileEditable;
                SubPageLink = "No." = field("No.");
            }
            part(Control1000000028; "Member Signature-App")
            {
                ApplicationArea = All;
                Caption = 'Signature';
                Editable = MobileEditable;
                Enabled = MobileEditable;
                SubPageLink = "No." = field("No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Function")
            {
                Caption = 'Function';
                action("Select Products")
                {
                    ApplicationArea = Basic;
                    Image = Accounts;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "Membership App Products";
                    RunPageLink = "Membership Applicaton No" = field("No.");
                }
                action("Next of Kin Details")
                {
                    ApplicationArea = Basic;
                    Caption = 'Next of Kin Details';
                    Image = Relationship;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    RunObject = Page "Membership App Nominee Detail";
                    RunPageLink = "Account No" = field("No.");
                }
                action("Account Signatories ")
                {
                    ApplicationArea = Basic;
                    Caption = 'Signatories';
                    Image = Group;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Membership App Signatories";
                    RunPageLink = "Account No" = field("No.");
                    RunPageOnRec = false;
                }
                separator(Action6)
                {
                    Caption = '-';
                }
                action("Send Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Send Approval Request';
                    Enabled = (not OpenApprovalEntriesExist) and EnabledApprovalWorkflowsExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        Text001: label 'This request is already pending approval';
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin

                        FnCheckfieldrestriction();

                        GenSetUp.Get();


                        //Check of Member Already Exists
                        if "ID No." <> '' then begin
                            Cust.Reset;
                            Cust.SetRange(Cust."ID No.", "ID No.");
                            Cust.SetRange(Cust."Customer Type", Cust."customer type"::Member);
                            if Cust.Find('-') then begin
                                if (Cust."No." <> "No.") and ("Account Category" = "account category"::Single) and (Cust.Status = Cust.Status::Active) then
                                    Error('Member has already been created');
                            end;
                        end;


                        //****************Check Next of Kin Info***************
                        if ("Account Category" = "account category"::Single) then begin
                            NOkApp.Reset;
                            NOkApp.SetRange(NOkApp."Account No", "No.");
                            if NOkApp.Find('-') = false then begin
                                //ERROR('Please Insert Next of kin Information');
                            end;
                        end;


                        //****************Check if there is any product Selected***************
                        ProductsApp.Reset;
                        ProductsApp.SetRange(ProductsApp."Membership Applicaton No", "No.");
                        if ProductsApp.Find('-') = false then begin
                            Error('Please Select Products to be Openned');
                        end;



                        if ApprovalsMgmt.CheckMembershipApplicationApprovalsWorkflowEnabled(Rec) then
                            ApprovalsMgmt.OnSendMembershipApplicationForApproval(Rec);

                        //Application Send SMS*********************************
                        if GenSetUp."Send Membership App SMS" = true then begin
                            FnSendReceivedApplicationSMS();
                        end;

                        //Application Send Email********************************
                        if GenSetUp."Send Membership App Email" = true then begin
                            FnSendReceivedApplicationEmail("No.", "E-Mail (Personal)", "ID No.");
                        end;
                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic;
                    Caption = 'Cancel Approval Request';
                    Enabled = CanCancelApprovalForRecord;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        Approvalmgt: Codeunit "Approvals Mgmt.";
                    begin
                        if Confirm('Are you sure you want to cancel this approval request', false) = true then
                            ApprovalsMgmt.OnCancelMembershipApplicationApprovalRequest(Rec);
                    end;
                }
                action(Approval)
                {
                    ApplicationArea = Basic;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        DocumentType := Documenttype::MembershipApplication;
                        ApprovalEntries.Setfilters(Database::"Membership Applications", DocumentType, "No.");
                        ApprovalEntries.Run;
                    end;
                }
                separator(Action2)
                {
                    Caption = '       -';
                }
                action("Create Account ")
                {
                    ApplicationArea = Basic;
                    Enabled = EnableCreateMember;
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        "count": Integer;
                        OrdAcc: Code[30];
                        DocumentAttachment: Record "Document Attachment";
                        secondName: Text;
                        thirdName: Text;
                        branch: Code[10];
                    begin
                        if Status <> Status::Approved then
                            Error('This application has not been approved');


                        AccountSignApp.Reset;
                        AccountSignApp.SetRange(AccountSignApp."Account No", "No.");
                        if not AccountSignApp.FindFirst() then begin
                            if "Account Category" = "account category"::Corporate then
                                Error('Please add signatories');

                            if "Account Category" = "account category"::Group then
                                Error('Please add signatories');
                        end;



                        if Confirm('Are you sure you want to create account application?', false) = true then begin


                            ProductsApp.Reset;
                            ProductsApp.SetRange(ProductsApp."Membership Applicaton No", "No.");
                            ProductsApp.SetRange(ProductsApp.Product, 'INUKA');
                            if ProductsApp.Find('-') then begin
                                //Check if copy of ID is attached
                                DocumentAttachment.Reset;
                                DocumentAttachment.SetRange("No.", Rec."No.");
                                DocumentAttachment.SetRange("Document Type", DocumentAttachment."document type"::"Copy of ID");
                                if not DocumentAttachment.FindFirst then
                                    Error('Please attach copy of ID');

                                //Check if passport photo is attached
                                DocumentAttachment.Reset;
                                DocumentAttachment.SetRange("No.", Rec."No.");
                                DocumentAttachment.SetRange("Document Type", DocumentAttachment."document type"::"User Photo");
                                if not DocumentAttachment.FindFirst then
                                    Error('Please attach photo');

                            end;

                            //Check Certificate for Institutional and Group Account
                            if ("Account Category" = "account category"::Group) or ("Account Category" = "account category"::Corporate) then begin
                                DocumentAttachment.Reset;
                                DocumentAttachment.SetRange("No.", Rec."No.");
                                DocumentAttachment.SetRange("Document Type", DocumentAttachment."document type"::Certificate);
                                if not DocumentAttachment.FindFirst then
                                    Error('Please attach copy of certificate');
                            end;

                            ProductsApp.Reset;
                            ProductsApp.SetRange(ProductsApp."Membership Applicaton No", "No.");
                            if ProductsApp.Find('-') then begin
                                repeat


                                    //Back office Account***********************************************************************************************

                                    if ProductsApp."Product Source" = ProductsApp."product source"::BOSA then begin
                                        //MESSAGE(' AcctNo is %1', AcctNo);
                                        //IF Cust."Customer Posting Group"<> 'PLAZA' THEN


                                        //MODIFY ID No for rejoining Members who had withdrawn
                                        //FnModifyIdNumber();
                                        //End MODIFY ID No for rejoining Members who had withdrawn
                                        if "ID No." <> '' then begin
                                            Cust.Reset;
                                            Cust.SetRange(Cust."ID No.", "ID No.");
                                            Cust.SetRange(Cust."Customer Type", Cust."customer type"::Member);
                                            if Cust.Find('-') then begin
                                                if (Cust."No." <> "No.") and ("Account Category" = "account category"::Single) then
                                                    Error('Member has already been created');

                                                if "Phone No." <> '' then begin
                                                    Cust.Reset;
                                                    Cust.SetRange(Cust."Phone No.", "Phone No.");
                                                    Cust.SetRange(Cust."Customer Type", Cust."customer type"::Member);
                                                    if Cust.Find('-') then begin
                                                        if (Cust."Phone No." <> "Phone No.") and ("Account Category" = "account category"::Single) then
                                                            //IF (Cust."Phone No." <> "Phone No.") AND ("Account Category"="Account Category"::Single) THEN
                                                            Message('Phone No already Exists');
                                                    end;
                                                end;
                                            end;
                                        end;
                                        TestField("Global Dimension 2 Code");
                                        DValues.Reset;
                                        DValues.SetRange(DValues.Code, "Global Dimension 2 Code");
                                        if DValues.Find('-') then begin
                                            BCode := DValues.Code;
                                        end;

                                        GenSetUp.Get();

                                        Saccosetup.Get();
                                        NewMembNo := Saccosetup.BosaNumber; /*GenSetUp."BOSA Code"+'-'+"Global Dimension 2 Code"+'-'+*/

                                        // IF "Account Category"="Account Category"::Group THEN
                                        // NewMembNo:=Saccosetup."Microfinance Last No Used";

                                        // IF "Account Category"="Account Category"::Corporate THEN
                                        // NewMembNo:=Saccosetup."Corporate Account Nos";

                                        //Create BOSA account
                                        Cust."No." := Format(NewMembNo);
                                        Cust.Name := Name;
                                        if "Account Category" = "account category"::Joint then begin
                                            secondName := ' & ' + "First Name2";
                                            thirdName := ' & ' + "First Name3";
                                            if thirdName <> ' & ' then
                                                Cust.Name := "First Name" + secondName + thirdName;
                                            if (thirdName = ' & ') and (secondName <> ' & ') then
                                                Cust.Name := "First Name" + secondName;
                                        end;
                                        Cust.Address := Address;
                                        Cust."Post Code" := "Postal Code";
                                        Cust.County := City;
                                        Cust."Phone No." := "Mobile Phone No";
                                        Cust."Global Dimension 1 Code" := "Global Dimension 1 Code";
                                        Cust."Global Dimension 2 Code" := "Global Dimension 2 Code";
                                        Cust."Customer Posting Group" := "Customer Posting Group";
                                        Cust."Registration Date" := Today;
                                        Cust."Mobile Phone No" := "Mobile Phone No";
                                        Cust.Status := Cust.Status::Active;
                                        Cust."Employer Code" := "Employer Code";
                                        Cust."Date of Birth" := "Date of Birth";
                                        Cust."Station/Department" := "Station/Department";
                                        Cust."E-Mail" := "E-Mail (Personal)";
                                        Cust.Location := Address;
                                        Cust.Title := Title;
                                        Cust."Home Address" := Address;
                                        Cust."Home Postal Code" := "Home Postal Code";
                                        Cust."Home Town" := "Home Town";
                                        Cust."Recruited By" := "Recruited By";
                                        Cust."Contact Person" := "Contact Person";
                                        Cust."ContactPerson Relation" := "ContactPerson Relation";
                                        Cust."ContactPerson Occupation" := "ContactPerson Occupation";
                                        Cust."Members Parish" := "Members Parish";
                                        Cust."Parish Name" := "Parish Name";
                                        Cust."Member class" := "Member Class";
                                        Cust."Member's Residence" := "Member's Residence";
                                        Cust.Region := Region;
                                        Cust.Picture := Picture;
                                        Cust.Signature := Signature;
                                        Cust."Signing Instructions" := "Signing Instructions";
                                        //Cust."Member Cell Group":="Member Cell Group";

                                        //*****************************to Sort Joint
                                        Cust."Name 2" := "Name 2";
                                        Cust."Address3-Joint" := Address3;
                                        Cust."Postal Code 2" := "Postal Code 2";
                                        Cust."Home Postal Code2" := "Home Postal Code2";
                                        Cust."Town 2" := "Home Town2";
                                        Cust."Mobile No 3" := "Mobile No. 3";
                                        Cust."ID No.2" := "ID No.2";
                                        Cust."Passport 2" := "Passport 2";
                                        Cust.Gender2 := Gender2;
                                        Cust."Marital Status2" := "Marital Status2";
                                        Cust."E-Mail (Personal3)" := "E-Mail (Personal2)";
                                        Cust."Employer Code2" := "Employer Code2";
                                        Cust."Employer Name2" := "Employer Name2";
                                        CalcFields("Picture 2", "Signature  2", "Picture 3", "Signature  3");
                                        Cust."Picture 2" := "Picture 2";
                                        Cust."Signature  2" := "Signature  2";
                                        Cust."Member Parish 2" := "Member Parish 2";
                                        Cust."Member Parish Name 2" := "Member Parish Name 2";


                                        Cust."Name 3" := "Name 3";
                                        Cust."Address3-Joint" := Address4;
                                        Cust."Postal Code 3" := "Postal Code 3";
                                        Cust."Home Postal Code3" := "Home Postal Code3";
                                        Cust."Mobile No. 4" := "Mobile No. 4";
                                        Cust."Home Town3" := "Home Town3";
                                        Cust."ID No.3" := "ID No.3";
                                        Cust."Passport 3" := "Passport 3";
                                        Cust.Gender3 := Gender3;
                                        Cust."Marital Status3" := "Marital Status3";
                                        Cust."E-Mail (Personal3)" := "E-Mail (Personal3)";
                                        Cust."Employer Code3" := "Employer Code3";
                                        Cust."Employer Name3" := "Employer Name3";
                                        Cust."Picture 3" := "Picture 3";
                                        Cust."Signature  3" := "Signature  3";
                                        Cust."Member Parish Name 3" := "Member Parish Name 3";
                                        Cust."Member Parish Name 3" := "Member Parish Name 3";
                                        Cust."Joint Account Name" := "First Name" + '& ' + "First Name2" + '& ' + "First Name3" + 'JA';
                                        Cust."Account Category" := "Account Category";

                                        //****************************End to Sort Joint

                                        //**
                                        Cust."Office Branch" := "Office Branch";
                                        Cust.Department := Department;
                                        Cust.Occupation := Occupation;
                                        Cust.Designation := Designation;
                                        Cust."Bank Code" := "Bank Code";
                                        Cust."Bank Account No." := "Bank Account No";
                                        //**
                                        Cust."Sub-Location" := "Sub-Location";
                                        Cust.District := District;
                                        Cust."Personal No" := "Employer No";
                                        Cust."ID No." := "ID No.";
                                        Cust."Mobile Phone No" := "Mobile Phone No";
                                        Cust."Marital Status" := "Marital Status";
                                        Cust."Customer Type" := Cust."customer type"::Member;
                                        Cust.Gender := Gender;
                                        Cust."Monthly Contribution" := "Monthly Contribution";
                                        Cust."Contact Person" := "Contact Person";
                                        Cust."Contact Person Phone" := "Contact Person Phone";
                                        Cust."ContactPerson Relation" := "ContactPerson Relation";
                                        Cust."Recruited By" := "Recruited By";
                                        Cust."ContactPerson Occupation" := "ContactPerson Occupation";
                                        Cust."Village/Residence" := "Village/Residence";
                                        Cust."Member class" := "Member Class";
                                        Cust."Any Other Sacco" := "Any Other Sacco";
                                        Cust."Employment Info" := "Employment Info";
                                        Cust."Terms Of Employment" := "Terms of Employment";

                                        Cust.Insert(true);

                                        BOSAACC := Cust."No.";
                                        Message('Bosa Acc is %1', BOSAACC);
                                        NextOfKinApp.Reset;
                                        NextOfKinApp.SetRange(NextOfKinApp."Account No", "No.");
                                        if NextOfKinApp.Find('-') then begin
                                            repeat
                                                NextOfKin.Init;
                                                NextOfKin."Account No" := BOSAACC;
                                                NextOfKin.Name := NextOfKinApp.Name;
                                                NextOfKin.Relationship := NextOfKinApp.Relationship;
                                                NextOfKin.Beneficiary := NextOfKinApp.Beneficiary;
                                                NextOfKin."Date of Birth" := NextOfKinApp."Date of Birth";
                                                NextOfKin.Address := NextOfKinApp.Address;
                                                NextOfKin.Telephone := NextOfKinApp.Telephone;
                                                NextOfKin."Next Of Kin Type" := NextOfKinApp."Next Of Kin Type";
                                                NextOfKin.Email := NextOfKinApp.Email;
                                                NextOfKin."ID No." := NextOfKinApp."ID No.";
                                                NextOfKin."%Allocation" := NextOfKinApp."%Allocation";
                                                NextOfKin.Insert;
                                            until NextOfKinApp.Next = 0;
                                        end;

                                        // AccountSignApp.RESET;
                                        // AccountSignApp.SETRANGE(AccountSignApp."Account No","No.");
                                        // IF AccountSignApp.FIND('-') THEN BEGIN
                                        // REPEAT
                                        //  AccountSign.INIT;
                                        //  AccountSign."Account No":=AcctNo;
                                        //  AccountSign.Names:=AccountSignApp.Names;
                                        //  AccountSign."Date Of Birth":=AccountSignApp."Date Of Birth";
                                        //  AccountSign."Staff/Payroll":=AccountSignApp."Staff/Payroll";
                                        //  AccountSign."ID No.":=AccountSignApp."ID No.";
                                        //  AccountSign.Signatory:=AccountSignApp.Signatory;
                                        //  AccountSign."Must Sign":=AccountSignApp."Must Sign";
                                        //  AccountSign."Must be Present":=AccountSignApp."Must be Present";
                                        //  AccountSign.Picture:=AccountSignApp.Picture;
                                        //  AccountSign.Signature:=AccountSignApp.Signature;
                                        //  AccountSign."Expiry Date":=AccountSignApp."Expiry Date";
                                        //  AccountSign.INSERT;
                                        // UNTIL AccountSignApp.NEXT = 0;
                                        // END;

                                        Saccosetup.BosaNumber := IncStr(Saccosetup.BosaNumber);
                                        Saccosetup.Modify;
                                        BOSAACC := Cust."No.";
                                    end;
                                until ProductsApp.Next = 0;

                            end;
                        end;
                        //End Back Office Account*****************************************************************************

                        //Front Office Accounts*******************************************************************************
                        ProductsApp.Reset;
                        ProductsApp.SetRange(ProductsApp."Membership Applicaton No", "No.");
                        ProductsApp.SetRange(ProductsApp."Product Source", ProductsApp."product source"::FOSA);
                        if ProductsApp.Find('-') then begin
                            repeat
                                ProductsApp.CalcFields(ProductsApp."Last No. Issued");
                                DValues.Reset;
                                //DValues.SETRANGE(DValues.Code,"Shortcut Dimension 3");
                                if DValues.Find('-') then begin
                                    BCode := DValues.Code;
                                end;

                                AccoutTypes.Reset;
                                AccoutTypes.SetRange(AccoutTypes.Code, ProductsApp.Product);
                                if AccoutTypes.Find('-') then begin
                                    LastNoUsed := AccountTypes."Last No Used";
                                    if "Global Dimension 2 Code" = 'LTK' then
                                        branch := '1';
                                    if "Global Dimension 2 Code" = 'KMN' then
                                        branch := '2';
                                    if "Global Dimension 2 Code" = 'ROMBO' then
                                        branch := '3';
                                    AcctNo := branch + AccoutTypes."Account No Prefix" + BOSAACC;
                                end;


                                AccoutTypes.Reset;
                                AccoutTypes.SetRange(AccoutTypes.Code, ProductsApp.Product);
                                if AccoutTypes.Find('-') then begin



                                    //Create FOSA account
                                    Accounts.Init;
                                    Accounts."No." := AcctNo;
                                    if ProductsApp.Product = 'ORDINARY' then
                                        OrdAcc := AcctNo;
                                    Accounts."Date of Birth" := "Date of Birth";
                                    Accounts.Name := Name;
                                    Accounts."Creditor Type" := Accounts."creditor type"::"Savings Account";
                                    Accounts."Personal No." := "Payroll No";
                                    Accounts."ID No." := "ID No.";
                                    Accounts."Mobile Phone No" := "Mobile Phone No";
                                    Accounts."Registration Date" := "Registration Date";
                                    Accounts."Post Code" := "Postal Code";
                                    Accounts.County := City;
                                    Accounts."BOSA Account No" := Cust."No.";
                                    Accounts.Picture := Picture;
                                    Accounts."Employer No" := "Employer No";
                                    Accounts.Signature := Signature;
                                    Accounts."Passport No." := "Passport No.";
                                    Accounts."Employer Code" := "Employer Code";
                                    Accounts.Status := Accounts.Status::New;
                                    Accounts."Account Type" := ProductsApp.Product;
                                    Accounts."Date of Birth" := "Date of Birth";
                                    Accounts."Global Dimension 1 Code" := 'FOSA';
                                    Accounts."Global Dimension 2 Code" := "Global Dimension 2 Code";
                                    Accounts.Address := Address;
                                    if "Account Category" = "account category"::Corporate then begin
                                        Accounts."Account Category" := Accounts."account category"::Corporate
                                    end else
                                        Accounts."Account Category" := "Account Category";
                                    Accounts."Address 2" := "Address 2";
                                    Accounts."Phone No." := "Phone No.";
                                    Accounts."Registration Date" := Today;
                                    Accounts.Status := Accounts.Status::Active;
                                    Accounts.Section := Section;
                                    Accounts."Home Address" := "Home Address";
                                    Accounts.District := District;
                                    Accounts.Location := Location;
                                    Accounts."Sub-Location" := "Sub-Location";
                                    Accounts."Registration Date" := Today;
                                    Accounts."Monthly Contribution" := "Monthly Contribution";
                                    Accounts."E-Mail" := "E-Mail (Personal)";
                                    Accounts."Group/Corporate Trade" := "Group/Corporate Trade";
                                    Accounts."Name of the Group/Corporate" := "Name of the Group/Corporate";
                                    Accounts."Certificate No" := "Certificate No";
                                    Accounts."Registration Date" := "Registration Date";
                                    //Accounts."Member Cell Group":="Member Cell Group";
                                    //Accounts."Home Page":="Home Page";
                                    //Accounts."CURRENT Account No.":="CURRENT Account No.";
                                    //Accounts."Signing Instructions":="Signing Instructions";
                                    //Accounts."Fixed Deposit Type":="Fixed Deposit Type";
                                    //Accounts."FD Maturity Date":="FD Maturity Date";
                                    //Accounts."Electrol Zone Code":="Electrol Zone Code";
                                    //Accounts."Departments Code":="Departments Code";
                                    //Accounts."Sections Code":="Sections Code";

                                    //*************To sort for Joint Accounts****************
                                    Accounts."Name 2" := "Name 2";
                                    Accounts."Address3-Joint" := Address3;
                                    Accounts."Postal Code 2" := "Postal Code 2";
                                    Accounts."Home Postal Code2" := "Home Postal Code2";
                                    Accounts."Home Town2" := "Home Town2";
                                    Accounts."ID No.2" := "ID No.2";
                                    Accounts."Passport 2" := "Passport 2";
                                    Accounts.Gender2 := Gender2;
                                    Accounts."Marital Status2" := "Marital Status2";
                                    Accounts."E-Mail (Personal2)" := "E-Mail (Personal2)";
                                    Accounts."Employer Code2" := "Employer Code2";
                                    Accounts."Employer Name2" := "Employer Name2";
                                    Accounts."Picture 2" := "Picture 2";
                                    Accounts."Signature  2" := "Signature  2";
                                    Accounts."Member Parish 2" := "Member Parish 2";
                                    Accounts."Member Parish Name 2" := "Member Parish Name 2";
                                    Accounts."Member's Residence" := "Member's Residence";
                                    Accounts."Joint Account Name" := "First Name" + ' ' + "First Name2";


                                    Accounts."Name 3" := "Name 3";
                                    Accounts."Address3-Joint" := Address4;
                                    Accounts."Postal Code 3" := "Postal Code 3";
                                    Accounts."Home Postal Code3" := "Home Postal Code3";
                                    Accounts."Home Town3" := "Home Town3";
                                    Accounts."ID No.3" := "ID No.3";
                                    Accounts."Passport 3" := "Passport 3";
                                    Accounts.Gender3 := Gender3;
                                    Accounts."Marital Status3" := "Marital Status3";
                                    Accounts."E-Mail (Personal3)" := "E-Mail (Personal3)";
                                    Accounts."Employer Code3" := "Employer Code3";
                                    Accounts."Employer Name3" := "Employer Name3";
                                    Accounts."Picture 3" := "Picture 3";
                                    Accounts."Signature  3" := "Signature  3";
                                    Accounts."Member Parish Name 3" := "Member Parish Name 3";
                                    Accounts."Member Parish Name 3" := "Member Parish Name 3";
                                    Accounts."Joint Account Name" := "First Name" + ' ' + "First Name2" + ' ' + "First Name3" + 'JA';
                                    Accounts.Gender := Gender;
                                    //************End to Sort for Joint Accounts*************
                                    Accounts.Insert;


                                    Accounts.Reset;
                                    if Accounts.Get(AcctNo) then begin
                                        Accounts.Validate(Accounts.Name);
                                        Accounts.Validate(Accounts."Account Type");
                                        //Accounts.VALIDATE(Accounts."Global Dimension 1 Code");
                                        //Accounts.VALIDATE(Accounts."Global Dimension 2 Code");
                                        Accounts.Modify;

                                        AccoutTypes.Reset;
                                        AccoutTypes.SetRange(AccoutTypes.Code, ProductsApp.Product);
                                        if AccoutTypes.Find('-') then begin
                                            AccoutTypes."Last No Used" := IncStr(AccoutTypes."Last No Used");
                                            AccoutTypes.Modify;
                                        end;
                                    end;
                                    //Update BOSA with FOSA Account
                                    if Cust.Get(BOSAACC) then begin
                                        Cust."FOSA Account No." := AcctNo;
                                        Cust.Modify;
                                    end;
                                    //END;


                                    NextOfKinApp.Reset;
                                    NextOfKinApp.SetRange(NextOfKinApp."Account No", "No.");
                                    if NextOfKinApp.Find('-') then begin
                                        repeat
                                            NextofKinFOSA.Init;
                                            NextofKinFOSA."Account No" := AcctNo;
                                            NextofKinFOSA.Name := NextOfKinApp.Name;
                                            NextofKinFOSA.Relationship := NextOfKinApp.Relationship;
                                            NextofKinFOSA.Beneficiary := NextOfKinApp.Beneficiary;
                                            NextofKinFOSA."Date of Birth" := NextOfKinApp."Date of Birth";
                                            NextofKinFOSA.Address := NextOfKinApp.Address;
                                            NextofKinFOSA.Telephone := NextOfKinApp.Telephone;
                                            //NextOfKin.Fax:=NextOfKinApp.Fax;
                                            NextofKinFOSA."Next Of Kin Type" := NextOfKinApp."Next Of Kin Type";
                                            NextofKinFOSA.Email := NextOfKinApp.Email;
                                            NextofKinFOSA."ID No." := NextOfKinApp."ID No.";
                                            NextofKinFOSA."%Allocation" := NextOfKinApp."%Allocation";
                                            NextofKinFOSA.Insert;
                                        until NextOfKinApp.Next = 0;
                                    end;

                                    // AccountSignApp.RESET;//FOR FOSA Accounts
                                    // AccountSignApp.SETRANGE(AccountSignApp."Account No","No.");
                                    // IF AccountSignApp.FIND('-') THEN BEGIN
                                    // REPEAT
                                    //  AccountSign.INIT;
                                    //  AccountSign."Account No":=AcctNo;
                                    //  AccountSign.Names:=AccountSignApp.Names;
                                    //  AccountSign."Date Of Birth":=AccountSignApp."Date Of Birth";
                                    //  AccountSign."Staff/Payroll":=AccountSignApp."Staff/Payroll";
                                    //  AccountSign."ID No.":=AccountSignApp."ID No.";
                                    //  AccountSign.Signatory:=AccountSignApp.Signatory;
                                    //  AccountSign."Must Sign":=AccountSignApp."Must Sign";
                                    //  AccountSign."Must be Present":=AccountSignApp."Must be Present";
                                    //  AccountSign.Picture:=AccountSignApp.Picture;
                                    //  AccountSign.Signature:=AccountSignApp.Signature;
                                    //  AccountSign."Expiry Date":=AccountSignApp."Expiry Date";
                                    //  //AccountSign."Mobile No.":=AccountSignApp."Mobile No.";
                                    //  AccountSign.INSERT;
                                    // UNTIL AccountSignApp.NEXT = 0;
                                    // END;
                                end;
                            until ProductsApp.Next = 0;


                            //Account Signatories
                            if "Account Category" <> "account category"::Single then begin
                                AccountSignApp.Reset;
                                AccountSignApp.SetRange(AccountSignApp."Account No", "No.");
                                if AccountSignApp.Find('-') then begin
                                    //AccountSignApp.CALCFIELDS(AccountSignApp.Picture,AccountSignApp.Signature);
                                    repeat
                                        AccSignatories.Init;

                                        AccSignatories."Account No" := BOSAACC;
                                        AccSignatories."BOSA No." := BOSAACC;
                                        AccSignatories.Names := AccountSignApp.Names;
                                        AccSignatories."Date Of Birth" := AccountSignApp."Date Of Birth";
                                        AccSignatories."Staff/Payroll" := AccountSignApp."Staff/Payroll";
                                        AccSignatories."ID No." := AccountSignApp."ID No.";
                                        AccSignatories.Signatory := AccountSignApp.Signatory;
                                        AccSignatories."Must Sign" := AccountSignApp."Must Sign";
                                        AccSignatories."Must be Present" := AccountSignApp."Must be Present";
                                        AccSignatories.Picture := AccountSignApp.Picture;
                                        AccSignatories.Signature := AccountSignApp.Signature;
                                        AccSignatories."Expiry Date" := AccountSignApp."Expiry Date";
                                        //AccSignatories."Mobile Phone No.":=AccountSignApp."Mobile Phone No.";

                                        //Update Group Accounts
                                        Cust.Reset;
                                        Cust.SetRange(Cust."No.", AccountSignApp."BOSA No.");
                                        if Cust.FindSet then begin
                                            Cust."Group Account No" := AcctNo;
                                            Cust.Modify;
                                        end;


                                        AccSignatories.Insert;
                                    until AccountSignApp.Next = 0;
                                end;

                            end;
                            //Charge Registration Fee
                            GenJournalLine.Reset;
                            GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                            GenJournalLine.SetRange("Journal Batch Name", 'REGFee');
                            GenJournalLine.DeleteAll;



                            GenSetUp.Get();
                            //Charge Registration Fee
                            if GenSetUp."Charge BOSA Registration Fee" = true then begin

                                LineNo := LineNo + 10000;


                                GenJournalLine.Init;
                                GenJournalLine."Journal Template Name" := 'GENERAL';
                                GenJournalLine."Journal Batch Name" := 'REGFee';
                                GenJournalLine."Document No." := "No.";
                                GenJournalLine."Line No." := LineNo;
                                // IF "Member Class"="Member Class"::"Class A" THEN BEGIN
                                GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                                GenJournalLine."Account No." := Cust."No.";
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                GenJournalLine."External Document No." := 'REGFEE/' + Format("Payroll No");
                                GenJournalLine.Description := 'Membership Registration Fee';
                                GenJournalLine."Transaction Type" := GenJournalLine."transaction type"::"Registration Fee";
                                if ("Account Category" = "account category"::Corporate) or ("Account Category" = "account category"::Group) then begin
                                    GenJournalLine.Amount := GenSetUp."BOSA Reg Fee Class B";
                                end
                                else
                                    if "Account Category" = "account category"::Single then begin
                                        GenJournalLine.Amount := GenSetUp."BOSA Registration Fee Amount";
                                    end;
                                if "Member Class" = "member class"::"Class B" then
                                    GenJournalLine."Account Type" := GenJournalLine."account type"::Member;
                                GenJournalLine."Account No." := BOSAACC;
                                GenJournalLine.Validate(GenJournalLine."Account No.");
                                //GenJournalLine.Amount:=GenSetUp."BOSA Reg Fee Class B";
                                GenJournalLine.Validate(GenJournalLine.Amount);
                                GenJournalLine."Shortcut Dimension 1 Code" := 'BOSA';
                                GenJournalLine."Shortcut Dimension 2 Code" := "Global Dimension 2 Code";
                                GenJournalLine."Bal. Account Type" := GenJournalLine."bal. account type"::"G/L Account";
                                GenJournalLine."Bal. Account No." := GenSetUp."BOSA Registration Fee Account";
                                //GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
                                //  END ELSE BEGIN
                                //    GenJournalLine."Account Type":=GenJournalLine."Account Type"::Vendor;
                                //    GenJournalLine."Account No.":=OrdAcc;
                                //    GenJournalLine.VALIDATE(GenJournalLine."Account No.");
                                //    GenJournalLine."External Document No.":='REGFEE/'+FORMAT("Payroll No");
                                //    GenJournalLine.Description:='Membership Registration Fee';
                                //    //GenJournalLine."Transaction Type":=GenJournalLine."Transaction Type"::"Registration Fee";
                                //    GenJournalLine.Amount:=GenSetUp."BOSA Reg Fee Class B";
                                //    GenJournalLine.VALIDATE(GenJournalLine.Amount);
                                //    GenJournalLine."Shortcut Dimension 1 Code":='FOSA';
                                //    GenJournalLine."Shortcut Dimension 2 Code":="Global Dimension 2 Code";
                                //    GenJournalLine."Bal. Account Type":=GenJournalLine."Bal. Account Type"::"G/L Account";
                                //    GenJournalLine."Bal. Account No.":=GenSetUp."BOSA Registration Fee Account";
                                //  END;
                                GenJournalLine."Posting Date" := Today;
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                                if GenJournalLine.Amount <> 0 then
                                    GenJournalLine.Insert;

                                GenJournalLine.Reset;
                                GenJournalLine.SetRange("Journal Template Name", 'GENERAL');
                                GenJournalLine.SetRange("Journal Batch Name", 'REGFee');
                                if GenJournalLine.Find('-') then begin
                                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post Sacco", GenJournalLine);
                                end;

                            end;

                            //SMS MESSAGE

                            // SendEmailAct();
                            /*SMSMessage.RESET;
                            IF SMSMessage.FIND('+') THEN BEGIN
                            iEntryNo:=SMSMessage."Entry No";
                            iEntryNo:=iEntryNo+1;
                            END
                            ELSE BEGIN
                            iEntryNo:=1;
                            END;

                            SMSMessage.RESET;
                            SMSMessage.INIT;
                            SMSMessage."Entry No":=iEntryNo;
                            SMSMessage."Account No":=AcctNo;
                            SMSMessage."Date Entered":=TODAY;
                            SMSMessage."Time Entered":=TIME;
                            SMSMessage.Source:= 'FOSA ACC';
                            SMSMessage."Entered By":=USERID;
                            SMSMessage."Sent To Server":=SMSMessage."Sent To Server"::No;
                            SMSMessage."SMS Message":='Your membership application is approved.'+
                                                      ' Member No. is '+Cust."No."+' Kindly deposit Ksh 600 to activate your account '+ 'ILKISONKO SACCO';
                            SMSMessage."Telephone No":="Phone No.";
                            SMSMessage.INSERT;

                            MESSAGE('Account created successfully.');
                            MESSAGE('The Member No. is %1',BOSAACC);*/
                        end;

                    end;
                }
                action(Attachments)
                {
                    ApplicationArea = Basic;
                    Image = Attach;
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
                action("Exempt interest")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        WorkflowManagement: Codeunit "Workflow Management";
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        UpdateControls();
        EnableCreateMember := false;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RecordId);
        EnabledApprovalWorkflowsExist := true;
        if Rec.Status = Status::Approved then begin
            OpenApprovalEntriesExist := false;
            CanCancelApprovalForRecord := false;
            EnabledApprovalWorkflowsExist := false;
        end;
        if ((Rec.Status = Status::Approved) and (Rec."Assigned No." = '')) then
            EnableCreateMember := true;
    end;

    trigger OnAfterGetRecord()
    begin
        /*Joint2DetailsVisible:=FALSE;
        Joint3DetailsVisible:=FALSE;
        
        //"Self Recruited":=TRUE;
        IF "Account Category"<>"Account Category"::Joint THEN BEGIN
        Joint2DetailsVisible:=FALSE;
        Joint3DetailsVisible:=FALSE;
        END ELSE
        Joint2DetailsVisible:=TRUE;
        Joint3DetailsVisible:=TRUE;*/

        GenSetUp.Get();
        if ("Monthly Contribution" = 0) or ("Monthly Contribution" < GenSetUp."Monthly Share Contributions") then
            "Monthly Contribution" := GenSetUp."Monthly Share Contributions";


        if "Employment Info" = "employment info"::Employed then begin
            EmployerCodeEditable := true;
            DepartmentEditable := true;
            TermsofEmploymentEditable := true;
            ContractingEditable := false;
            EmployedEditable := false;
            OccupationEditable := false

        end else
            if "Employment Info" = "employment info"::Contracting then begin
                ContractingEditable := true;
                EmployerCodeEditable := false;
                DepartmentEditable := false;
                TermsofEmploymentEditable := false;
                OccupationEditable := false;
            end else
                if "Employment Info" = "employment info"::Others then begin
                    OthersEditable := true;
                    ContractingEditable := false;
                    EmployerCodeEditable := false;
                    DepartmentEditable := false;
                    TermsofEmploymentEditable := false;
                    OccupationEditable := false
                end else
                    if "Employment Info" = "employment info"::UnEmployed then begin
                        OccupationEditable := true;
                        EmployerCodeEditable := false;
                        DepartmentEditable := false;
                        TermsofEmploymentEditable := false;
                        ContractingEditable := false;
                        EmployedEditable := false

                    end;

    end;

    trigger OnDeleteRecord(): Boolean
    begin
        if (Rec.Status = Status::Approved) and (Rec."Assigned No." <> '') then
            Error('Account has already been created,record cannot be deleted');
    end;

    trigger OnInit()
    begin
        GenSetUp.Get();
        "Customer Posting Group" := GenSetUp."Default Customer Posting Group";
        "Global Dimension 1 Code" := 'BOSA';
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        "Responsibility Centre" := UserMgt.GetSalesFilter;
        ObJMemberApplication.Reset;
        ObJMemberApplication.SetRange(ObJMemberApplication.Created, false);
        ObJMemberApplication.SetRange(ObJMemberApplication."Created By", UserId);
        if ObJMemberApplication.Find('-') then begin
            if ObJMemberApplication."ID No." = '' then begin
                if ObJMemberApplication.Count > 1 then begin
                    if Confirm('There are still some Unused Application Nos. Continue?', false) = false then begin
                        Error('There are still some Unused Application Nos. Please utilise them first');
                    end;
                end;
            end;
        end;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        UserMgt: Codeunit "User Management";
    begin
        GenSetUp.Get();
        if ("Monthly Contribution" = 0) or ("Monthly Contribution" < GenSetUp."Monthly Share Contributions") then
            "Monthly Contribution" := GenSetUp."Monthly Share Contributions";
        "Customer Posting Group" := GenSetUp."Default Customer Posting Group";
        "Global Dimension 1 Code" := 'BOSA';

        //"Self Recruited":=TRUE;





        /*IF "Account Category"<>"Account Category"::Joint THEN BEGIN
        Joint2DetailsVisible:=FALSE;
        Joint3DetailsVisible:=FALSE;
        END ELSE
        Joint2DetailsVisible:=TRUE;
        Joint3DetailsVisible:=TRUE;*/

    end;

    trigger OnOpenPage()
    begin

        if UserMgt.GetSalesFilter <> '' then begin
            FilterGroup(2);
            SetRange("Responsibility Centre", UserMgt.GetSalesFilter);
            FilterGroup(0);
        end;

        Joint2DetailsVisible := false;
        Joint3DetailsVisible := false;

        if "Account Category" = "account category"::Joint then begin
            Joint2DetailsVisible := true;
            Joint3DetailsVisible := true;
        end;
        if "Account Category" = "account category"::Single then begin
            Joint2DetailsVisible := false;
            Joint3DetailsVisible := false;
        end;
    end;

    var
        StatusPermissions: Record "Status Change Permision";
        Cust: Record "Member Register";
        Accounts: Record Vendor;
        AcctNo: Code[20];
        NextOfKinApp: Record "Member App Nominee";
        AccountSign: Record "Products Signatories Details";
        AccountSignApp: Record "Member App Signatories";
        Acc: Record Vendor;
        UsersID: Record User;
        Nok: Record "Member App Nominee";
        NOKBOSA: Record "Members Nominee";
        BOSAACC: Code[20];
        NextOfKin: Record "Members Nominee";
        PictureExists: Boolean;
        text001: label 'Status must be open';
        UserMgt: Codeunit "User Setup Management";
        NotificationE: Codeunit Mail;
        MailBody: Text[250];
        ccEmail: Text[1000];
        toEmail: Text[1000];
        GenSetUp: Record "Sacco General Set-Up";
        ClearingAcctNo: Code[20];
        AdvrAcctNo: Code[20];
        AccountTypes: Record "Account Types-Saving Products";
        DivAcctNo: Code[20];
        NameEditable: Boolean;
        AddressEditable: Boolean;
        NoEditable: Boolean;
        DioceseEditable: Boolean;
        HomeAdressEditable: Boolean;
        GlobalDim1Editable: Boolean;
        GlobalDim2Editable: Boolean;
        CustPostingGroupEdit: Boolean;
        PhoneEditable: Boolean;
        MaritalstatusEditable: Boolean;
        IDNoEditable: Boolean;
        RegistrationDateEdit: Boolean;
        OfficeBranchEditable: Boolean;
        DeptEditable: Boolean;
        SectionEditable: Boolean;
        OccupationEditable: Boolean;
        DesignationEdiatble: Boolean;
        EmployerCodeEditable: Boolean;
        EmployerNameEditable: Boolean;
        DepartmentEditable: Boolean;
        TermsofEmploymentEditable: Boolean;
        DOBEditable: Boolean;
        EmailEdiatble: Boolean;
        StaffNoEditable: Boolean;
        GenderEditable: Boolean;
        MonthlyContributionEdit: Boolean;
        PostCodeEditable: Boolean;
        CityEditable: Boolean;
        WitnessEditable: Boolean;
        StatusEditable: Boolean;
        BankCodeEditable: Boolean;
        BranchCodeEditable: Boolean;
        BankAccountNoEditable: Boolean;
        ProductEditable: Boolean;
        SecondaryMobileEditable: Boolean;
        AccountCategoryEditable: Boolean;
        OfficeTelephoneEditable: Boolean;
        OfficeExtensionEditable: Boolean;
        MemberParishEditable: Boolean;
        KnowDimkesEditable: Boolean;
        CountyEditable: Boolean;
        DistrictEditable: Boolean;
        LocationEditable: Boolean;
        SubLocationEditable: Boolean;
        EmploymentInfoEditable: Boolean;
        VillageResidence: Boolean;
        SignatureExists: Boolean;
        NewMembNo: Code[30];
        Saccosetup: Record "Sacco No. Series";
        NOkApp: Record "Member App Nominee";
        TitleEditable: Boolean;
        PostalCodeEditable: Boolean;
        HomeAddressPostalCodeEditable: Boolean;
        HomeTownEditable: Boolean;
        RecruitedEditable: Boolean;
        ContactPEditable: Boolean;
        ContactPRelationEditable: Boolean;
        ContactPOccupationEditable: Boolean;
        CopyOFIDEditable: Boolean;
        CopyofPassportEditable: Boolean;
        SpecimenEditable: Boolean;
        ContactPPhoneEditable: Boolean;
        PictureEditable: Boolean;
        SignatureEditable: Boolean;
        PayslipEditable: Boolean;
        RegistrationFeeEditable: Boolean;
        CopyofKRAPinEditable: Boolean;
        membertypeEditable: Boolean;
        FistnameEditable: Boolean;
        dateofbirth2: Boolean;
        registrationeditable: Boolean;
        EstablishdateEditable: Boolean;
        RegistrationofficeEditable: Boolean;
        Signature2Editable: Boolean;
        Picture2Editable: Boolean;
        MembApp: Record "Membership Applications";
        title2Editable: Boolean;
        mobile3editable: Boolean;
        emailaddresEditable: Boolean;
        gender2editable: Boolean;
        postal2Editable: Boolean;
        town2Editable: Boolean;
        passpoetEditable: Boolean;
        maritalstatus2Editable: Boolean;
        payrollno2editable: Boolean;
        Employercode2Editable: Boolean;
        address3Editable: Boolean;
        DateOfAppointmentEDitable: Boolean;
        TermsofServiceEditable: Boolean;
        HomePostalCode2Editable: Boolean;
        Employername2Editable: Boolean;
        ageEditable: Boolean;
        CopyofconstitutionEditable: Boolean;
        Table_id: Integer;
        Doc_No: Code[20];
        Doc_Type: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application","Account Opening";
        RecruitedByEditable: Boolean;
        RecruiterNameEditable: Boolean;
        RecruiterRelationShipEditable: Boolean;
        AccoutTypes: Record "Account Types-Saving Products";
        NomineeEditable: Boolean;
        TownEditable: Boolean;
        CountryEditable: Boolean;
        MobileEditable: Boolean;
        PassportEditable: Boolean;
        RejoiningDateEditable: Boolean;
        PrevousRegDateEditable: Boolean;
        AppCategoryEditable: Boolean;
        RegistrationDateEditable: Boolean;
        DataSheet: Record "Data Sheet Main";
        SMSMessage: Record "SMS Messages";
        iEntryNo: Integer;
        Cuat: Integer;
        EmployedEditable: Boolean;
        ContractingEditable: Boolean;
        OthersEditable: Boolean;
        Joint2DetailsVisible: Boolean;
        ProductsApp: Record "Membership Reg. Products Appli";
        NextofKinFOSA: Record "FOSA Account NOK Details";
        UsersRec: Record User;
        Joint3DetailsVisible: Boolean;
        CompInfo: Record "Company Information";
        LineNo: Integer;
        GenJournalLine: Record "Gen. Journal Line";
        FirstNameEditable: Boolean;
        MiddleNameEditable: Boolean;
        LastNameEditable: Boolean;
        PayrollNoEditable: Boolean;
        MemberResidenceEditable: Boolean;
        ShareClassEditable: Boolean;
        KRAPinEditable: Boolean;
        ViewLog: Record "View Log Entry";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," ","Purchase Requisition",RFQ,"Store Requisition","Payment Voucher",MembershipApplication,LoanApplication,LoanDisbursement,ProductApplication,StandingOrder,MembershipWithdrawal,ATMCard,GuarantorRecovery;
        WelcomeMessage: label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">Welcome to Chuna Sacco</p><p style="font-family:Verdana,Arial;font-size:9pt">This is to confirm that your membership Application has been received and Undergoing Approval</p><p style="font-family:Verdana,Arial;font-size:9pt"> </b></p><br>Regards<p>%3</p><p><b>CHUNA SACCO LTD</b></p>';
        RegistrationMessage: label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">Welcome to Chuna Sacco</p><p style="font-family:Verdana,Arial;font-size:9pt">This is to confirm that your membership registration has been successfully processed</p><p style="font-family:Verdana,Arial;font-size:9pt">Your membership number is <b>%2</b></p><br>Regards<p>%3</p><p><b>CHUNA SACCO LTD</b></p>';
        OpenApprovalEntriesExist: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        CanCancelApprovalForRecord: Boolean;
        EventFilter: Text;
        EnableCreateMember: Boolean;
        SFactory: Codeunit "SURESTEP Factory";
        ObJMemberApplication: Record "Membership Applications";
        ObjEmployer: Record "Sacco Employers";
        DValues: Record "Dimension Value";
        LastNoUsed: Code[20];
        BCode: Code[20];
        DocumentAttachmentDetails: Page "Document Attachment Details";
        AccountSignatoriesApp: Record "Member Account Signatories";
        AccSignatories: Record "Member Account Signatories";


    procedure UpdateControls()
    begin

        if Status = Status::Approved then begin
            NameEditable := false;
            NoEditable := false;
            AddressEditable := false;
            GlobalDim1Editable := false;
            GlobalDim2Editable := false;
            CustPostingGroupEdit := false;
            PhoneEditable := false;
            MaritalstatusEditable := false;
            IDNoEditable := false;
            PhoneEditable := false;
            RegistrationDateEdit := false;
            OfficeBranchEditable := false;
            DeptEditable := false;
            SectionEditable := false;
            OccupationEditable := false;
            DesignationEdiatble := false;
            EmployerCodeEditable := false;
            DOBEditable := false;
            EmailEdiatble := false;
            StaffNoEditable := false;
            GenderEditable := false;
            MonthlyContributionEdit := false;
            PostCodeEditable := false;
            CityEditable := false;
            WitnessEditable := false;
            BankCodeEditable := false;
            BranchCodeEditable := false;
            BankAccountNoEditable := false;
            VillageResidence := false;
            TitleEditable := false;
            PostalCodeEditable := false;
            HomeAddressPostalCodeEditable := false;
            HomeTownEditable := false;
            RecruitedEditable := false;
            ContactPEditable := false;
            ContactPRelationEditable := false;
            ContactPOccupationEditable := false;
            CopyOFIDEditable := false;
            CopyofPassportEditable := false;
            SpecimenEditable := false;
            ContactPPhoneEditable := false;
            HomeAdressEditable := false;
            PictureEditable := false;
            SignatureEditable := false;
            PayslipEditable := false;
            RegistrationFeeEditable := false;
            title2Editable := false;
            emailaddresEditable := false;
            gender2editable := false;
            HomePostalCode2Editable := false;
            town2Editable := false;
            passpoetEditable := false;
            maritalstatus2Editable := false;
            payrollno2editable := false;
            Employercode2Editable := false;
            address3Editable := false;
            Employername2Editable := false;
            ageEditable := false;
            CopyofconstitutionEditable := false;
            NomineeEditable := false;
            TownEditable := false;
            CountryEditable := false;
            MobileEditable := false;
            PassportEditable := false;
            RejoiningDateEditable := false;
            PrevousRegDateEditable := false;
            AppCategoryEditable := false;
            RegistrationDateEditable := false;
            TermsofServiceEditable := false;
            ProductEditable := false;
            SecondaryMobileEditable := false;
            AccountCategoryEditable := false;
            OfficeTelephoneEditable := false;
            OfficeExtensionEditable := false;
            CountyEditable := false;
            DistrictEditable := false;
            LocationEditable := false;
            SubLocationEditable := false;
            EmploymentInfoEditable := false;
            MemberParishEditable := false;
            KnowDimkesEditable := false;
            EmployerCodeEditable := false;
            DepartmentEditable := false;
            TermsofEmploymentEditable := false;
            FirstNameEditable := false;
            MiddleNameEditable := false;
            LastNameEditable := false;
            PayrollNoEditable := false;
            MemberResidenceEditable := false;
            ShareClassEditable := false;
            KRAPinEditable := false;
            RecruitedByEditable := false;
        end;

        if Status = Status::"Pending Approval" then begin
            NameEditable := false;
            NoEditable := false;
            AddressEditable := false;
            GlobalDim1Editable := false;
            GlobalDim2Editable := false;
            CustPostingGroupEdit := false;
            PhoneEditable := false;
            MaritalstatusEditable := false;
            IDNoEditable := false;
            PhoneEditable := false;
            RegistrationDateEdit := false;
            OfficeBranchEditable := false;
            DeptEditable := false;
            SectionEditable := false;
            OccupationEditable := false;
            DesignationEdiatble := false;
            EmployerCodeEditable := false;
            DOBEditable := false;
            EmailEdiatble := false;
            StaffNoEditable := false;
            GenderEditable := false;
            MonthlyContributionEdit := false;
            PostCodeEditable := false;
            CityEditable := false;
            WitnessEditable := false;
            BankCodeEditable := false;
            BranchCodeEditable := false;
            BankAccountNoEditable := false;
            VillageResidence := false;
            TitleEditable := false;
            PostalCodeEditable := false;
            HomeAddressPostalCodeEditable := false;
            HomeTownEditable := false;
            RecruitedEditable := false;
            ContactPEditable := false;
            ContactPRelationEditable := false;
            ContactPOccupationEditable := false;
            CopyOFIDEditable := false;
            CopyofPassportEditable := false;
            SpecimenEditable := false;
            ContactPPhoneEditable := false;
            HomeAdressEditable := false;
            PictureEditable := true;
            SignatureEditable := true;
            PayslipEditable := false;
            RegistrationFeeEditable := false;
            title2Editable := false;
            emailaddresEditable := false;
            gender2editable := false;
            HomePostalCode2Editable := false;
            town2Editable := false;
            passpoetEditable := false;
            maritalstatus2Editable := false;
            payrollno2editable := false;
            Employercode2Editable := false;
            address3Editable := false;
            Employername2Editable := false;
            ageEditable := false;
            CopyofconstitutionEditable := false;
            NomineeEditable := false;
            TownEditable := false;
            CountryEditable := false;
            MobileEditable := false;
            PassportEditable := false;
            RejoiningDateEditable := false;
            PrevousRegDateEditable := false;
            AppCategoryEditable := false;
            RegistrationDateEditable := false;
            TermsofServiceEditable := false;
            ProductEditable := false;
            SecondaryMobileEditable := false;
            AccountCategoryEditable := false;
            OfficeTelephoneEditable := false;
            OfficeExtensionEditable := false;
            CountyEditable := false;
            DistrictEditable := false;
            LocationEditable := false;
            SubLocationEditable := false;
            EmploymentInfoEditable := false;
            MemberParishEditable := false;
            KnowDimkesEditable := false;
            EmployerCodeEditable := false;
            DepartmentEditable := false;
            TermsofEmploymentEditable := false;
            FirstNameEditable := false;
            MiddleNameEditable := false;
            LastNameEditable := false;
            PayrollNoEditable := false;
            MemberResidenceEditable := false;
            ShareClassEditable := false;
            KRAPinEditable := false;
            RecruitedByEditable := false;
        end;


        if Status = Status::Open then begin
            NameEditable := true;
            AddressEditable := true;
            GlobalDim1Editable := true;
            GlobalDim2Editable := true;
            CustPostingGroupEdit := true;
            PhoneEditable := true;
            MaritalstatusEditable := true;
            IDNoEditable := true;
            PhoneEditable := true;
            RegistrationDateEdit := true;
            OfficeBranchEditable := true;
            DeptEditable := true;
            SectionEditable := true;
            OccupationEditable := true;
            DesignationEdiatble := true;
            EmployerCodeEditable := true;
            DOBEditable := true;
            EmailEdiatble := true;
            StaffNoEditable := true;
            GenderEditable := true;
            MonthlyContributionEdit := true;
            PostCodeEditable := true;
            CityEditable := true;
            WitnessEditable := true;
            BankCodeEditable := true;
            BranchCodeEditable := true;
            BankAccountNoEditable := true;
            VillageResidence := true;
            TitleEditable := true;
            PostalCodeEditable := true;
            HomeAddressPostalCodeEditable := true;
            HomeTownEditable := true;
            RecruitedEditable := true;
            ContactPEditable := true;
            ContactPRelationEditable := true;
            ContactPOccupationEditable := true;
            CopyOFIDEditable := true;
            CopyofPassportEditable := true;
            SpecimenEditable := true;
            ContactPPhoneEditable := true;
            HomeAdressEditable := true;
            PictureEditable := true;
            SignatureEditable := true;
            PayslipEditable := true;
            RegistrationFeeEditable := true;
            title2Editable := true;
            emailaddresEditable := true;
            gender2editable := true;
            HomePostalCode2Editable := true;
            town2Editable := true;
            passpoetEditable := true;
            maritalstatus2Editable := true;
            payrollno2editable := true;
            Employercode2Editable := true;
            address3Editable := true;
            Employername2Editable := true;
            ageEditable := true;
            mobile3editable := true;
            CopyofconstitutionEditable := true;
            NomineeEditable := true;
            TownEditable := true;
            CountryEditable := true;
            MobileEditable := true;
            PassportEditable := true;
            RejoiningDateEditable := true;
            PrevousRegDateEditable := true;
            AppCategoryEditable := true;
            RegistrationDateEditable := true;
            TermsofServiceEditable := true;
            ProductEditable := true;
            SecondaryMobileEditable := true;
            AccountCategoryEditable := true;
            OfficeTelephoneEditable := true;
            OfficeExtensionEditable := true;
            CountyEditable := true;
            DistrictEditable := true;
            LocationEditable := true;
            SubLocationEditable := true;
            EmploymentInfoEditable := true;
            MemberParishEditable := true;
            KnowDimkesEditable := true;
            EmployerCodeEditable := true;
            DepartmentEditable := true;
            TermsofEmploymentEditable := true;
            FirstNameEditable := true;
            MiddleNameEditable := true;
            LastNameEditable := true;
            PayrollNoEditable := true;
            MemberResidenceEditable := true;
            ShareClassEditable := true;
            KRAPinEditable := true;
            RecruitedByEditable := true;
        end
    end;

    local procedure SelfRecruitedControl()
    begin
        /*
            IF "Self Recruited"=TRUE THEN BEGIN
             RecruitedByEditable:=FALSE;
             RecruiterNameEditable:=FALSE;
             RecruiterRelationShipEditable:=FALSE;
             END ELSE
            IF "Self Recruited"<>TRUE THEN BEGIN
             RecruitedByEditable:=TRUE;
             RecruiterNameEditable:=TRUE;
             RecruiterRelationShipEditable:=TRUE;
             END;
             */

    end;


    procedure FnSendReceivedApplicationSMS()
    begin

        GenSetUp.Get;
        CompInfo.Get;



        //SMS MESSAGE
        /*SMSMessage.RESET;
        IF SMSMessage.FIND('+') THEN BEGIN
        iEntryNo:=SMSMessage."Entry No";
        iEntryNo:=iEntryNo+1;
        END
        ELSE BEGIN
        iEntryNo:=1;
        END;
        
        
        SMSMessage.INIT;
        SMSMessage."Entry No":=iEntryNo;
        SMSMessage."Batch No":="No.";
        SMSMessage."Document No":='';
        SMSMessage."Account No":=BOSAACC;
        SMSMessage."Date Entered":=TODAY;
        SMSMessage."Time Entered":=TIME;
        SMSMessage.Source:='MEMBAPP';
        SMSMessage."Entered By":=USERID;
        SMSMessage."Sent To Server":=SMSMessage."Sent To Server"::No;
        SMSMessage."SMS Message":='Dear Member your application has been received and going through approval,'
        +' ' +CompInfo.Name+' '+GenSetUp."Customer Care No";
        SMSMessage."Telephone No":="Mobile Phone No";
        IF "Mobile Phone No"<>'' THEN
        SMSMessage.INSERT;*/

    end;


    procedure FnSendRegistrationSMS()
    begin

        GenSetUp.Get;
        CompInfo.Get;



        //SMS MESSAGE
        SMSMessage.Reset;
        if SMSMessage.Find('+') then begin
            iEntryNo := SMSMessage."Entry No";
            iEntryNo := iEntryNo + 1;
        end
        else begin
            iEntryNo := 1;
        end;


        SMSMessage.Init;
        SMSMessage."Entry No" := iEntryNo;
        SMSMessage."Batch No" := "No.";
        SMSMessage."Document No" := '';
        SMSMessage."Account No" := BOSAACC;
        SMSMessage."Date Entered" := Today;
        SMSMessage."Time Entered" := Time;
        SMSMessage.Source := 'MEMBREG';
        SMSMessage."Entered By" := UserId;
        SMSMessage."Sent To Server" := SMSMessage."sent to server"::No;
        SMSMessage."SMS Message" := 'Mr/Mrs' + Name + 'you have successfully registered as a member of Ilkisonko Sacco Society Ltd. Your Membership number is '
        + BOSAACC + ' and FOSA account number is' + AcctNo + 'Thank you and welcome ,Tuboreshe Maisha Yetu';
        SMSMessage."Telephone No" := "Mobile Phone No";
        if "Mobile Phone No" <> '' then
            SMSMessage.Insert;
    end;

    local procedure UpdateViewLogEntries()
    begin
        ViewLog.Init;
        ViewLog."Entry No." := ViewLog."Entry No." + 1;
        ViewLog."User ID" := UserId;
        ViewLog."Table No." := 51516364;
        ViewLog."Table Caption" := 'Members Register';
        ViewLog.Date := Today;
        ViewLog.Time := Time;
    end;

    local procedure FnCheckfieldrestriction()
    begin
        if ("Account Category" = "account category"::Single) or ("Account Category" = "account category"::Joint) then begin
            TestField(Name);
            TestField("ID No.");
            //TESTFIELD("Member Class");
            TestField("Mobile Phone No");
            TestField(Region);
            //TESTFIELD("Monthly Contribution");
            //TESTFIELD("KRA PIN");
            TestField("Customer Posting Group");
            TestField("Global Dimension 1 Code");
            TestField(Picture);
            TestField(Signature);
            if "Member Class" = "member class"::" "
              then
                Error('Please select Member Class');
        end else

            if ("Account Category" = "account category"::Group) or ("Account Category" = "account category"::Corporate) then begin

                if "Member Class" = "member class"::" "
                then
                    Error('Please select Member Class');
                TestField(Name);
                TestField("Registration No");
                //TESTFIELD("Copy of KRA Pin");
                //TESTFIELD("Member Registration Fee Receiv");
                TestField("Customer Posting Group");
                TestField("Global Dimension 1 Code");
                TestField("Global Dimension 2 Code");
                TestField("Contact Person");
                TestField("Contact Person Phone");
                //TESTFIELD(Picture);
                //TESTFIELD(Signature);
                TestField(Region);

            end;

        //Account Signatories
        // IF "Account Category"<>"Account Category"::Single THEN BEGIN
        // AccountSignApp.RESET;
        // AccountSignApp.SETRANGE(AccountSignApp."Account No","No.");
        // IF AccountSignApp.FIND('-') THEN BEGIN
        // //AccountSignApp.CALCFIELDS(AccountSignApp.Picture,AccountSignApp.Signature);
        // REPEAT
        // AccountSignApp.TESTFIELD(Signature);
        // AccountSignApp.TESTFIELD(Picture);
        // UNTIL AccountSignApp.NEXT=0;
        // END;
        // END;
    end;

    local procedure FnSendReceivedApplicationEmail(ApplicationNo: Code[20]; Email: Text[50]; IDNo: Code[20])
    var
        Memb: Record "Membership Applications";
        SMTPMail: Codeunit UnknownCodeunit400;
        SMTPSetup: Record "SMTP Mail Setup";
        FileName: Text[100];
        Attachment: Text[250];
        CompanyInfo: Record "Company Information";
    begin
        SMTPSetup.Get();

        Memb.Reset;
        Memb.SetRange(Memb."No.", ApplicationNo);
        if Memb.Find('-') then begin
            if Email = '' then begin
                Error('Email Address Missing for Member Application number' + '-' + Memb."No.");
            end;
            if Memb."E-Mail (Personal)" <> '' then
                SMTPMail.CreateMessage(SMTPSetup."Email Sender Name", SMTPSetup."Email Sender Address", Email, 'Membership Application', '', true);
            SMTPMail.AppendBody(StrSubstNo(WelcomeMessage, Memb.Name, IDNo, UserId));
            SMTPMail.AppendBody(SMTPSetup."Email Sender Name");
            SMTPMail.AppendBody('<br><br>');
            SMTPMail.AddAttachment(FileName, Attachment);
            SMTPMail.Send;
        end;
    end;

    local procedure FnSendRegistrationEmail(ApplicationNo: Code[20]; Email: Text[50]; IDNo: Code[20])
    var
        Memb: Record "Membership Applications";
        SMTPMail: Codeunit UnknownCodeunit400;
        SMTPSetup: Record "SMTP Mail Setup";
        FileName: Text[100];
        Attachment: Text[250];
        CompanyInfo: Record "Company Information";
    begin
        SMTPSetup.Get();

        Memb.Reset;
        Memb.SetRange(Memb."No.", ApplicationNo);
        if Memb.Find('-') then begin
            if Email = '' then begin
                Error('Email Address Missing for Member Application number' + '-' + Memb."No.");
            end;
            if Memb."E-Mail (Personal)" <> '' then
                SMTPMail.CreateMessage(SMTPSetup."Email Sender Name", SMTPSetup."Email Sender Address", Email, 'Membership Registration', '', true);
            SMTPMail.AppendBody(StrSubstNo(RegistrationMessage, Memb.Name, BOSAACC, UserId));
            SMTPMail.AppendBody(SMTPSetup."Email Sender Name");
            SMTPMail.AppendBody('<br><br>');
            SMTPMail.AddAttachment(FileName, Attachment);
            SMTPMail.Send;
        end;
    end;

    local procedure FnModifyIdNumber()
    begin
        if "ID No." <> '' then begin
            Cust.Reset;
            Cust.SetRange(Cust."ID No.", "ID No.");
            Cust.SetRange(Cust."Customer Type", Cust."customer type"::Member);
            Cust.SetFilter(Cust.Status, '%1|%2', Cust.Status::Withdrawal, Cust.Status::Termination);
            if Cust.Find('-') then begin
                if (Cust."No." <> "No.") and ("Account Category" = "account category"::Single) then begin
                    Cust."ID No." := Cust."ID No." + '_W';
                    Cust.Modify;
                end;

                if "Phone No." <> '' then begin
                    Cust.Reset;
                    Cust.SetRange(Cust."Phone No.", "Phone No.");
                    Cust.SetRange(Cust."Customer Type", Cust."customer type"::Member);
                    Cust.SetFilter(Cust.Status, '%1|%2', Cust.Status::Withdrawal, Cust.Status::Termination);
                    if Cust.Find('-') then begin
                        if (Cust."Phone No." <> "Phone No.") and ("Account Category" = "account category"::Single) then
                            Cust."ID No." := Cust."Phone No." + '_W';
                        Cust.Modify;
                    end;
                end;
            end;
        end;
    end;
}

