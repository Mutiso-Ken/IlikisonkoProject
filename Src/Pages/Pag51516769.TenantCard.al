#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516769 "Tenant Card"
{
    DeleteAllowed = false;
    SourceTable = Vendor;
    SourceTableView = where("Vendor Posting Group" = const('TENANT'));

    layout
    {
        area(content)
        {
            group(Control9)
            {
                field("Vendor Posting Group"; "Vendor Posting Group")
                {
                    ApplicationArea = Basic;
                }
                field("No."; "No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field(Name; Name)
                {
                    ApplicationArea = Basic;
                }
                field("ID No."; "ID No.")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        if "Phone No." <> '' then begin
                            Customer.Reset;
                            Customer.SetRange(Customer."ID No.", "ID No.");
                            Customer.SetRange(Customer."Vendor Posting Group", 'TENANT');
                            if Customer.Find('-') then begin
                                if (Customer."No." <> "No.") then
                                    Error('ID No. already exists in the Tenant List');
                            end;
                        end;
                    end;
                }
                field("Phone No."; "Phone No.")
                {
                    ApplicationArea = Basic;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        if "ID No." <> '' then begin
                            Customer.Reset;
                            Customer.SetRange(Customer."Phone No.", "Phone No.");
                            Customer.SetRange(Customer."Vendor Posting Group", 'TENANT');
                            if Customer.Find('-') then begin
                                if (Customer."No." <> "No.") then
                                    Error('Phone No. already exists in the Tenant List');
                            end;
                        end;
                    end;
                }
                field(Gender; Gender)
                {
                    ApplicationArea = Basic;
                }
                field(Address; Address)
                {
                    ApplicationArea = Basic;
                }
                field(City; City)
                {
                    ApplicationArea = Basic;
                }
                field(Rental; Rental)
                {
                    ApplicationArea = Basic;
                    Caption = 'Property No';
                }
                field("Rental Name"; "Rental Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Property Name';
                    Editable = false;
                }
                field("House Allocated"; "House Allocated")
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    var
                        House: Record House;
                    begin
                        if "House Allocated" <> '' then begin
                            House.Reset;
                            House.SetRange("House Code", "House Allocated");
                            House.SetRange("Property Code", Rental);
                            if House.Find('-') then begin
                                if House.Status = House.Status::Vacant then
                                    House.Status := House.Status::Reserved;
                                House."Tenant No" := "No.";
                                House."Tenant Name" := Name;
                                House."Reservation Date" := Today;
                                House.Modify;
                            end;
                            House.Reset;
                            House.SetRange("House Code", xRec."House Allocated");
                            House.SetRange("Property Code", Rental);
                            if House.Find('-') then begin
                                if House.Status = House.Status::Reserved then
                                    House.Status := House.Status::Vacant;
                                House."Tenant No" := '';
                                House."Tenant Name" := '';
                                House."Reservation Date" := 0D;
                                House."Date allocated" := 0D;
                                House.Modify;
                            end;
                            "Allocation Status" := "allocation status"::"Pending Approval";
                        end else
                            "Allocation Status" := "allocation status"::" ";
                        Modify;
                        CurrPage.Update;
                    end;
                }
                field("Allocation Status"; "Allocation Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date Notice Issued"; "Date Notice Issued")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Notice Due Date"; "Notice Due Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account Type"; "Account Type")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Balance; Balance)
                {
                    ApplicationArea = Basic;
                }
                field("Tenant defaulters report"; "Tenant defaulters report")
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
            group("Request Approval")
            {
                Caption = 'Request Approval';
                Image = SendApprovalRequest;
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedOnly = true;
                    ToolTip = 'Request approval to change the record.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        TestField("ID No.");
                        TestField("Phone No.");

                        if ApprovalsMgmt.CheckVendorApprovalsWorkflowEnabled(Rec) then
                            ApprovalsMgmt.OnSendVendorForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedOnly = true;
                    ToolTip = 'Cancel the approval request.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                        WorkflowWebhookManagement: Codeunit "Workflow Webhook Management";
                    begin
                        ApprovalsMgmt.OnCancelVendorApprovalRequest(Rec);
                        WorkflowWebhookManagement.FindAndCancel(RecordId);
                    end;
                }
                action("Issue Notice")
                {
                    ApplicationArea = Basic;
                    Enabled = NoticeEnabled;
                    Image = Info;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        if "Allocation Status" = "allocation status"::"Serving Notice"
                          then
                            Error('Tenant is already serving Notice');
                        //Property
                        House.Reset;
                        House.SetRange("Tenant No", "No.");
                        House.SetRange(Status, House.Status::Occupied);
                        if House.Find('-') then begin
                            House.CalcFields(House."Notice Period");
                            SURESTEPFactory.FnSendSMS('LANDLORD', 'Dear ' + Name + ', this is to notify you that you are required to vacate House No ' + House."House Code" + ' on or before ' + Format(CalcDate(Format(House."Notice Period") + 'D', Today)), '', "Phone No.");
                            "Allocation Status" := "allocation status"::"Serving Notice";
                            Property.Reset;
                            Property.SetRange(No, House."Property Code");
                            if Property.Find('-') then begin
                                "Notice Due Date" := CalcDate('<' + Format(Property."Notice Period") + 'D>', Today);
                                "Date Notice Issued" := Today;
                            end;
                            Modify;
                            CurrPage.Update;
                        end else
                            Error('Tenant has not been allocated any house');
                    end;
                }
                action("Allocate House")
                {
                    ApplicationArea = Basic;
                    Image = Allocate;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        if "Approval Status" <> "approval status"::Approved then
                            Message('Tenant record has not been approved');

                        if "House Allocated" <> '' then begin
                            House.Reset;
                            House.SetRange("House Code", "House Allocated");
                            House.SetRange("Property Code", Rental);
                            if House.Find('-') then begin
                                if (House.Status = House.Status::Vacant) or (House.Status = House.Status::Reserved) then begin
                                    House.Status := House.Status::Occupied;
                                    House."Tenant No" := "No.";
                                    House."Tenant Name" := Name;
                                    House."Date allocated" := Today;
                                    House.Modify;

                                    //Create History
                                    HouseOccupationHistory.Init;
                                    HouseOccupationHistory."Entry No" := 0;
                                    HouseOccupationHistory."Property Code" := House."Property Code";
                                    HouseOccupationHistory."Property Name" := House."Property Name";
                                    HouseOccupationHistory."House Code" := House."House Code";
                                    HouseOccupationHistory."Tentant No" := House."Tenant No";
                                    HouseOccupationHistory."Tenant Name" := Name;
                                    HouseOccupationHistory."Tenant ID No" := "ID No.";
                                    HouseOccupationHistory."Tenant Phone No" := "Phone No.";
                                    HouseOccupationHistory."Date Reserved" := House."Reservation Date";
                                    HouseOccupationHistory."Date Allocated" := House."Date allocated";
                                    HouseOccupationHistory."Date Vacated" := House."Date Vacated";
                                    HouseOccupationHistory."Entry Type" := HouseOccupationHistory."entry type"::Occupation;
                                    HouseOccupationHistory."Last Modified By" := UserId;
                                    HouseOccupationHistory.Insert;
                                    "Allocation Status" := "allocation status"::Allocated;
                                    Modify;
                                    CurrPage.Update;
                                    Message('House allocation is succesfull');
                                end;
                            end;
                        end else
                            Error('Please select the house to be allocated');
                    end;
                }
                action("Vacate House")
                {
                    ApplicationArea = Basic;
                    Image = Close;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        Property: Record Property;
                        HouseCheckList: Record "House CheckList";
                    begin
                        if "Approval Status" <> "approval status"::Approved then
                            Message('Tenant record has not been approved');

                        if "House Allocated" <> '' then begin
                            House.Reset;
                            House.SetRange("House Code", "House Allocated");
                            House.SetRange("Property Code", Rental);
                            if House.Find('-') then begin
                                if "Notice Issued" then
                                    Error('Tenant has not been given notice of vacation');
                                if House.Status = House.Status::Occupied then begin

                                    //Create History
                                    HouseOccupationHistory.Init;
                                    HouseOccupationHistory."Entry No" := 0;
                                    HouseOccupationHistory."Property Code" := House."Property Code";
                                    HouseOccupationHistory."Property Name" := House."Property Name";
                                    HouseOccupationHistory."House Code" := House."House Code";
                                    HouseOccupationHistory."Tentant No" := House."Tenant No";
                                    HouseOccupationHistory."Tenant Name" := Name;
                                    HouseOccupationHistory."Tenant ID No" := "ID No.";
                                    HouseOccupationHistory."Tenant Phone No" := "Phone No.";
                                    HouseOccupationHistory."Date Reserved" := House."Reservation Date";
                                    HouseOccupationHistory."Date Allocated" := House."Date allocated";
                                    HouseOccupationHistory."Date Vacated" := House."Date Vacated";
                                    HouseOccupationHistory."Entry Type" := HouseOccupationHistory."entry type"::Vacation;
                                    HouseOccupationHistory."Last Modified By" := UserId;
                                    HouseOccupationHistory.Insert;

                                    House.Status := House.Status::Vacant;
                                    House."Date allocated" := 0D;
                                    House."Reservation Date" := 0D;
                                    House."Date Vacated" := Today;
                                    House."Tenant No" := '';
                                    House."Tenant Name" := '';
                                    House.Modify;

                                    HouseCheckList.Reset;
                                    HouseCheckList.SetRange("Property Code", Rental);
                                    HouseCheckList.SetRange("House Code", "House Allocated");
                                    HouseCheckList.SetRange("Tenant No", "No.");
                                    if HouseCheckList.Find('-') then begin
                                        HouseCheckList.DeleteAll;
                                    end;

                                    Property.Reset;
                                    Property.SetRange(No, Rental);
                                    if Property.Find('-') then begin
                                        //Send Notification to landlord
                                        Property.CalcFields(Contact);
                                        SURESTEPFactory.FnSendSMS('LANDLORD', 'Dear ' + Property."Member Name" + ', this is to notify you that house No. ' + House."House Code" + '(' + House."Property Name" + ')' + ' has been vacated.', Property."Owner No", Property.Contact);
                                        "Allocation Status" := "allocation status"::Vaccated;
                                        Modify;
                                        CurrPage.Update;
                                    end;

                                    Message('House vacated succesfully');
                                end else
                                    Error('House is not yet occuped');
                            end;
                        end else
                            Error('No house has been allocated');
                    end;
                }
                action("Clear Reservation")
                {
                    ApplicationArea = Basic;
                    Image = ClearLog;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        HouseCheckList: Record "House CheckList";
                    begin
                        if "Approval Status" <> "approval status"::Open then
                            Message('Tenant record is not open');

                        if ("House Allocated" <> '') and ("Allocation Status" = "allocation status"::"Pending Approval") then begin
                            House.Reset;
                            House.SetRange("House Code", "House Allocated");
                            House.SetRange("Property Code", Rental);
                            if House.Find('-') then begin
                                if House.Status = House.Status::Reserved then begin
                                    House.Status := House.Status::Vacant;
                                    House."Date allocated" := 0D;
                                    House."Reservation Date" := 0D;
                                    House."Tenant No" := '';
                                    House."Tenant Name" := '';
                                    House.Modify;
                                    "House Allocated" := '';
                                    "Allocation Status" := "allocation status"::" ";
                                    Modify;

                                    HouseCheckList.Reset;
                                    HouseCheckList.SetRange("Property Code", Rental);
                                    HouseCheckList.SetRange("House Code", "House Allocated");
                                    HouseCheckList.SetRange("Tenant No", "No.");
                                    if HouseCheckList.Find('-') then begin
                                        HouseCheckList.DeleteAll;
                                    end;

                                    CurrPage.Update;
                                    Message('House reservation cleared succesfully');
                                end else
                                    Error('No active reservation for this tenant yet');
                            end;
                        end else
                            Error('House not yet reserved');
                    end;
                }
                action("House CheckList")
                {
                    ApplicationArea = Basic;
                    Image = CheckList;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "House CheckList";
                    RunPageLink = "Tenant No" = field("No."),
                                  "House Code" = field("House Allocated");
                }
                action("Penalties/Deposit Ledger Entries")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "Vendor Ledger Entries";
                    RunPageLink = "Vendor No." = field("No.");
                }
                action("Revoke Notice")
                {
                    ApplicationArea = Basic;
                    Enabled = NoticeEnabled;
                    Image = Info;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    begin
                        // IF "Allocation Status"<>"Allocation Status"::"Serving Notice"
                        //  THEN ERROR('Status must be Serving Notice');
                        // //Property
                        // House.RESET;
                        // House.SETRANGE("Tenant No","No.");
                        // House.SETRANGE(Status,House.Status::Occupied);
                        // IF House.FIND('-') THEN BEGIN
                        //  House.CALCFIELDS(House."Notice Period");
                        //  SURESTEPFactory.FnSendSMS('LANDLORD','Dear '+Name+', this is to notify you that you are required to vacate House No '+House."House Code"+' on or before '+FORMAT(CALCDATE(FORMAT(House."Notice Period")+'D',TODAY)),'',"Phone No.");
                        //  SURESTEPFactory.FnSendSMS('LANDLORD','Dear '+Name+', this is to notify you that you are required to vacate House No '+House."House Code"+' on or before '+FORMAT(CALCDATE(FORMAT(House."Notice Period")+'D',TODAY)),'',"Phone No.");
                        //  "Allocation Status":="Allocation Status"::Allocated;
                        //  Property.RESET;
                        //  Property.SETRANGE(No,House."Property Code");
                        //  IF Property.FIND('-') THEN BEGIN
                        //     "Notice Due Date":=0D;
                        //     "Date Notice Issued":=0D;
                        //  END;
                        //  MODIFY;
                        //  CurrPage.UPDATE;
                        // END ELSE
                        // ERROR('Tenant has not been allocated any house');
                    end;
                }
                action("Page Vendor Statement")
                {
                    ApplicationArea = Basic;
                    Caption = 'Deposit Statement';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        Vend.Reset;
                        Vend.SetRange(Vend."No.", "No.");
                        if Vend.Find('-') then
                            Report.Run(51516893, true, false, Vend)

                    end;
                }
                action("Page Vendor Statement1")
                {
                    ApplicationArea = Basic;
                    Caption = 'Tenant Statement';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        Vend.Reset;
                        Vend.SetRange(Vend."No.", "No.");
                        if Vend.Find('-') then
                            Report.Run(51516561, true, false, Vend)

                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        WorkflowManagement: Codeunit "Workflow Management";
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        // CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);
        //
        // // EventFilter := WorkflowEventHandling.RunWorkflowOnSendCustomerForApprovalCode + '|' +
        // //  WorkflowEventHandling.RunWorkflowOnCustomerChangedCode;
        //
        // EnabledApprovalWorkflowsExist := WorkflowManagement.EnabledWorkflowExist(DATABASE::Customer,EventFilter);
        //
        // WorkflowWebhookManagement.GetCanRequestAndCanCancel(RECORDID,CanRequestApprovalForFlow,CanCancelApprovalForFlow);
        if "Allocation Status" = "allocation status"::Allocated then
            NoticeEnabled := true;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        "Vendor Posting Group" := 'TENANT';
        "Country/Region Code" := '254';
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Vendor Posting Group" := 'TENANT';
        "Country/Region Code" := '254';
    end;

    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        OpenApprovalEntriesExistCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        CanRequestApprovalForFlow: Boolean;
        CanCancelApprovalForFlow: Boolean;
        Customer: Record Vendor;
        ShowWorkflowStatus: Boolean;
        EventFilter: Text;
        SURESTEPFactory: Codeunit "SURESTEP Factory";
        Property: Record Property;
        House: Record House;
        NoticeEnabled: Boolean;
        HouseOccupationHistory: Record "House Occupation History";
        Vend: Record Vendor;
}

