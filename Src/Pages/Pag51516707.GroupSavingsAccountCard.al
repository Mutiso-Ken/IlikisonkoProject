#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516707 "Group Savings Account Card"
{
    Caption = 'Account Card';
    Editable = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Approval,Budgetary Control,Cancellation,Category7_caption,Category8_caption,Category9_caption,Category10_caption';
    RefreshOnActivate = true;
    SourceTable = Vendor;
    SourceTableView = where("Creditor Type"=const("Savings Account"),
                            "Vendor Posting Group"=const('GROUP'));

    layout
    {
        area(content)
        {
            group(AccountTab)
            {
                Caption = 'General Info';
                Editable = true;
                field("No.";"No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Account No.';
                    Editable = false;

                    trigger OnAssistEdit()
                    begin
                        if AssistEdit(xRec) then
                          CurrPage.Update;
                    end;
                }
                field("Joint Account Name";"Joint Account Name")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field(Name;Name)
                {
                    ApplicationArea = Basic;
                }
                field("Account Type";"Account Type")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Account Category";"Account Category")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ID No.";"ID No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'ID No.';
                    Editable = false;
                }
                field("Passport No.";"Passport No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Personal No.";"Personal No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("BOSA Account No";"BOSA Account No")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member No.';
                }
                field("Mobile Phone No";"Mobile Phone No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Employer Code";"Employer Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("Station/Sections";"Station/Sections")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Phone No.";"Phone No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Date of Birth";"Date of Birth")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date of Birth';
                    Editable = false;
                }
                field(txtGender;Gender)
                {
                    ApplicationArea = Basic;
                    Caption = 'Gender';
                    Editable = false;
                }
                field("Marital Status";"Marital Status")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Registration Date";"Registration Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Uncleared Cheques";"Uncleared Cheques")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("""Balance (LCY)""-((""Uncleared Cheques""-""Cheque Discounted Amount"")+""ATM Transactions""+""EFT Transactions""+MinBalance+""Mobile Transactions"")+""Cheque Discounted""";"Balance (LCY)"-(("Uncleared Cheques"-"Cheque Discounted Amount")+"ATM Transactions"+"EFT Transactions"+MinBalance+"Mobile Transactions")+"Cheque Discounted")
                {
                    ApplicationArea = Basic;
                    Caption = 'Book Balance';
                    Enabled = false;
                    Visible = false;
                }
                field(AvailableBal;"Balance (LCY)")
                {
                    ApplicationArea = Basic;
                    Caption = 'Withdrawable Balance';
                    Editable = false;
                }
                field("Cheque Discounted";"Cheque Discounted")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Comission On Cheque Discount";"Comission On Cheque Discount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Vendor Posting Group";"Vendor Posting Group")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("Global Dimension 1 Code";"Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("Global Dimension 2 Code";"Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Reason For Blocking Account";"Reason For Blocking Account")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field(Blocked;Blocked)
                {
                    ApplicationArea = Basic;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        //TESTFIELD("Resons for Status Change");
                    end;
                }
                field("Account Frozen";"Account Frozen")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ATM No.";"ATM No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Cheque Acc. No";"Cheque Acc. No")
                {
                    ApplicationArea = Basic;
                }
                field("Last Date Modified";"Last Date Modified")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field(Picture;Picture)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(Signature;Signature)
                {
                    ApplicationArea = Basic;
                    Editable = true;
                }
                field(Status;Status)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Style = Standard;
                    StyleExpr = true;

                    trigger OnValidate()
                    begin
                        TestField("Resons for Status Change");
                        
                        StatusPermissions.Reset;
                        StatusPermissions.SetRange(StatusPermissions."User ID",UserId);
                        StatusPermissions.SetRange(StatusPermissions."Function",StatusPermissions."function"::"Account Status");
                        if StatusPermissions.Find('-') = false then
                        Error('You do not have permissions to change the account status.');
                        
                        if "Account Type" = 'FIXED' then begin
                        if "Balance (LCY)" > 0 then begin
                        CalcFields("Last Interest Date");
                        
                        if "Call Deposit" = true then begin
                        if Status = Status::Closed then begin
                        if "Last Interest Date" < Today then
                        Error('Fixed deposit interest not UPDATED. Please update interest.');
                        end else begin
                        if "Last Interest Date" < "FD Maturity Date" then
                        Error('Fixed deposit interest not UPDATED. Please update interest.');
                        end;
                        end;
                        end;
                        end;
                        
                        if Status = Status::Active then begin
                        if Confirm('Are you sure you want to re-activate this account? This will recover re-activation fee.',false) = false then begin
                        Error('Re-activation terminated.');
                        end;
                        
                        Blocked:=Blocked::" ";
                        Modify;
                        
                        
                        
                        
                        
                        end;
                        
                        
                        //Account Closure
                        if Status = Status::Closed then begin
                        TestField("Closure Notice Date");
                        if Confirm('Are you sure you want to close this account? This will recover closure fee and any '
                        + 'interest earned before maturity will be forfeited.',false) = false then begin
                        Error('Closure terminated.');
                        end;
                        
                        
                        GenJournalLine.Reset;
                        GenJournalLine.SetRange(GenJournalLine."Journal Template Name",'PURCHASES');
                        GenJournalLine.SetRange(GenJournalLine."Journal Batch Name",'FTRANS');
                        if GenJournalLine.Find('-') then
                        GenJournalLine.DeleteAll;
                        
                        
                        
                        AccountTypes.Reset;
                        AccountTypes.SetRange(AccountTypes.Code,"Account Type");
                        if AccountTypes.Find('-') then  begin
                        "Date Closed":=Today;
                        
                        //Closure charges
                        /*Charges.RESET;
                        IF CALCDATE(AccountTypes."Closure Notice Period","Closure Notice Date") > TODAY THEN
                        Charges.SETRANGE(Charges.Code,AccountTypes."Closing Prior Notice Charge") */
                        
                        Charges.Reset;
                        if CalcDate(AccountTypes."Closure Notice Period","Closure Notice Date") > Today then
                        Charges.SetRange(Charges.Code,AccountType."Closing Charge")
                        
                        else
                        Charges.SetRange(Charges.Code,AccountTypes."Closing Charge");
                        if Charges.Find('-') then begin
                        LineNo:=LineNo+10000;
                        
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='PURCHASES';
                        GenJournalLine."Journal Batch Name":='FTRANS';
                        GenJournalLine."Document No.":="No."+'-CL';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No.":="No.";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine.Description:=Charges.Description;
                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                        GenJournalLine.Amount:=Charges."Charge Amount";
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"G/L Account";
                        GenJournalLine."Bal. Account No.":=Charges."GL Account";
                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;
                        
                        end;
                        //Closure charges
                        
                        
                        //Interest forfeited/Earned on maturity
                        CalcFields("Untranfered Interest");
                        if "Untranfered Interest" > 0 then begin
                        ForfeitInterest:=true;
                        //If FD - Check if matured
                        if AccountTypes."Fixed Deposit" = true then begin
                        if "FD Maturity Date" <= Today then
                        ForfeitInterest:=false;
                        if "Call Deposit" = true then
                        ForfeitInterest:=false;
                        
                        end;
                        
                        //PKK INGORE MATURITY
                        ForfeitInterest:=false;
                        //If FD - Check if matured
                        
                        if ForfeitInterest = true then begin
                        LineNo:=LineNo+10000;
                        
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='PURCHASES';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Journal Batch Name":='FTRANS';
                        GenJournalLine."Document No.":="No."+'-CL';
                        GenJournalLine."External Document No.":="No.";
                        GenJournalLine."Account Type":=GenJournalLine."account type"::"G/L Account";
                        GenJournalLine."Account No.":=AccountTypes."Interest Forfeited Account";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine.Description:='Interest Forfeited';
                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                        GenJournalLine.Amount:=-"Untranfered Interest";
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"G/L Account";
                        GenJournalLine."Bal. Account No.":=AccountTypes."Interest Payable Account";
                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                        GenJournalLine."Shortcut Dimension 1 Code":="Global Dimension 1 Code";
                        GenJournalLine."Shortcut Dimension 2 Code":="Global Dimension 2 Code";
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");
                        GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;
                        
                        InterestBuffer.Reset;
                        InterestBuffer.SetRange(InterestBuffer."Account No","No.");
                        if InterestBuffer.Find('-') then
                        InterestBuffer.ModifyAll(InterestBuffer.Transferred,true);
                        
                        
                        end else begin
                        LineNo:=LineNo+10000;
                        
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='PURCHASES';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Journal Batch Name":='FTRANS';
                        GenJournalLine."Document No.":="No."+'-CL';
                        GenJournalLine."External Document No.":="No.";
                        GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                        if AccountTypes."Fixed Deposit" = true then
                        GenJournalLine."Account No.":="Savings Account No."
                        else
                        GenJournalLine."Account No.":="No.";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine.Description:='Interest Earned';
                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                        GenJournalLine.Amount:=-"Untranfered Interest";
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        GenJournalLine."Bal. Account Type":=GenJournalLine."bal. account type"::"G/L Account";
                        GenJournalLine."Bal. Account No.":=AccountTypes."Interest Payable Account";
                        GenJournalLine.Validate(GenJournalLine."Bal. Account No.");
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;
                        
                        InterestBuffer.Reset;
                        InterestBuffer.SetRange(InterestBuffer."Account No","No.");
                        if InterestBuffer.Find('-') then
                        InterestBuffer.ModifyAll(InterestBuffer.Transferred,true);
                        
                        
                        
                        end;
                        
                        
                        //Transfer Balance if Fixed Deposit
                        if AccountTypes."Fixed Deposit" = true then begin
                        CalcFields("Balance (LCY)");
                        
                        TestField("Savings Account No.");
                        
                        LineNo:=LineNo+10000;
                        
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='PURCHASES';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Journal Batch Name":='FTRANS';
                        GenJournalLine."Document No.":="No."+'-CL';
                        GenJournalLine."External Document No.":="No.";
                        GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No.":="Savings Account No.";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine.Description:='FD Balance Tranfers';
                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                        if "Amount to Transfer" <> 0 then
                        GenJournalLine.Amount:=-"Amount to Transfer"
                        else
                        GenJournalLine.Amount:=-"Balance (LCY)";
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;
                        
                        LineNo:=LineNo+10000;
                        
                        GenJournalLine.Init;
                        GenJournalLine."Journal Template Name":='PURCHASES';
                        GenJournalLine."Line No.":=LineNo;
                        GenJournalLine."Journal Batch Name":='FTRANS';
                        GenJournalLine."Document No.":="No."+'-CL';
                        GenJournalLine."External Document No.":="No.";
                        GenJournalLine."Account Type":=GenJournalLine."account type"::Vendor;
                        GenJournalLine."Account No.":="No.";
                        GenJournalLine.Validate(GenJournalLine."Account No.");
                        GenJournalLine."Posting Date":=Today;
                        GenJournalLine.Description:='FD Balance Tranfers';
                        GenJournalLine.Validate(GenJournalLine."Currency Code");
                        if "Amount to Transfer" <> 0 then
                        GenJournalLine.Amount:="Amount to Transfer"
                        else
                        GenJournalLine.Amount:="Balance (LCY)";
                        GenJournalLine.Validate(GenJournalLine.Amount);
                        if GenJournalLine.Amount<>0 then
                        GenJournalLine.Insert;
                        
                        
                        end;
                        
                        //Transfer Balance if Fixed Deposit
                        
                        
                        end;
                        
                        //Interest forfeited/Earned on maturity
                        /*
                        //Post New
                        GenJournalLine.RESET;
                        GenJournalLine.SETRANGE("Journal Template Name",'PURCHASES');
                        GenJournalLine.SETRANGE("Journal Batch Name",'FTRANS');
                        IF GenJournalLine.FIND('-') THEN BEGIN
                        CODEUNIT.RUN(CODEUNIT::Codeunit,GenJournalLine);
                        END;
                        //Post New
                        */
                        
                        Message('Funds transfered successfully to main account and account closed.');
                        
                        
                        
                        
                        end;
                        end;
                        
                        
                        //Account Closure

                    end;
                }
                field("Staff Account";"Staff Account")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Closure Notice Date";"Closure Notice Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("Resons for Status Change";"Resons for Status Change")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Signing Instructions";"Signing Instructions")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    MultiLine = true;
                }
                field("Interest Earned";"Interest Earned")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Untranfered Interest";"Untranfered Interest")
                {
                    ApplicationArea = Basic;
                    Importance = Additional;
                }
                field("Allowable Cheque Discounting %";"Allowable Cheque Discounting %")
                {
                    ApplicationArea = Basic;
                    Editable = true;
                    Importance = Additional;
                }
                field("S-Mobile No";"S-Mobile No")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Mobile Transactions";"Mobile Transactions")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("E-Loan Qualification Amount";"E-Loan Qualification Amount")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("Reason for Freezing Account";"Reason for Freezing Account")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("Account Frozen By";"Account Frozen By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    Importance = Additional;
                }
                field("Account Special Instructions";"Account Special Instructions")
                {
                    ApplicationArea = Basic;
                    Importance = Additional;
                    Style = Attention;
                    StyleExpr = true;
                }
                field("No Of Signatories";"No Of Signatories")
                {
                    ApplicationArea = Basic;
                    Importance = Additional;
                }
                field("Created By";"Created By")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            group(AccountTab1)
            {
                Caption = 'Communication Info';
                Editable = true;
                field(Address;Address)
                {
                    ApplicationArea = Basic;
                }
                field("Post Code";"Post Code")
                {
                    ApplicationArea = Basic;
                    Caption = 'Post Code/City';
                }
                field(City;City)
                {
                    ApplicationArea = Basic;
                }
                field("Address 2";"Address 2")
                {
                    ApplicationArea = Basic;
                }
                field("E-Mail";"E-Mail")
                {
                    ApplicationArea = Basic;
                }
                field("Home Page";"Home Page")
                {
                    ApplicationArea = Basic;
                }
                field(Contact;Contact)
                {
                    ApplicationArea = Basic;
                }
                field("ContacPerson Phone";"ContacPerson Phone")
                {
                    ApplicationArea = Basic;
                }
                field("ContactPerson Occupation";"ContactPerson Occupation")
                {
                    ApplicationArea = Basic;
                }
                field(CodeDelete;CodeDelete)
                {
                    ApplicationArea = Basic;
                }
                field("Home Address";"Home Address")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Joint2Details)
            {
                Caption = 'Joint2Details';
                Visible = Joint2DetailsVisible;
                field("Name 2";"Name 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Name';
                    Editable = false;
                }
                field("Payroll/Staff No2";"Payroll/Staff No2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Payroll No';
                    Editable = false;
                }
                field("Address3-Joint";"Address3-Joint")
                {
                    ApplicationArea = Basic;
                    Caption = 'Address';
                    Editable = false;
                }
                field("Postal Code 2";"Postal Code 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Postal Code';
                    Editable = false;
                }
                field("Town 2";"Town 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Town';
                    Editable = false;
                }
                field("Mobile No. 3";"Mobile No. 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Mobile No.';
                    Editable = false;
                }
                field("Date of Birth2";"Date of Birth2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date of Birth';
                    Editable = false;
                }
                field("ID No.2";"ID No.2")
                {
                    ApplicationArea = Basic;
                    Caption = 'ID No.';
                    Editable = false;
                }
                field("Passport 2";"Passport 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Passport No.';
                    Editable = false;
                }
                field("Member Parish 2";"Member Parish 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Parish';
                    Editable = false;
                }
                field("Member Parish Name 2";"Member Parish Name 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Parish Name';
                    Editable = false;
                }
                field(Gender2;Gender2)
                {
                    ApplicationArea = Basic;
                    Caption = 'Gender';
                    Editable = false;
                }
                field("Marital Status2";"Marital Status2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Marital Status';
                    Editable = false;
                }
                field("Home Postal Code2";"Home Postal Code2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Home Postal Code';
                    Editable = false;
                }
                field("Home Town2";"Home Town2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Home Town';
                    Editable = false;
                }
                field("Employer Code2";"Employer Code2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employer Code';
                    Editable = false;
                }
                field("Employer Name2";"Employer Name2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employer Name';
                    Editable = false;
                }
                field("E-Mail (Personal2)";"E-Mail (Personal2)")
                {
                    ApplicationArea = Basic;
                    Caption = 'E-Mail (Personal)';
                    Editable = false;
                }
                field("Picture 2";"Picture 2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Picture';
                    Editable = false;
                }
                field("Signature  2";"Signature  2")
                {
                    ApplicationArea = Basic;
                    Caption = 'Signature';
                    Editable = false;
                }
            }
            group(Joint3Details)
            {
                Visible = Joint3DetailsVisible;
                field("Name 3";"Name 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Name';
                    Editable = false;
                }
                field("Payroll/Staff No3";"Payroll/Staff No3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Payroll/Staff No';
                    Editable = false;
                }
                field(Address4;Address4)
                {
                    ApplicationArea = Basic;
                    Caption = 'Address';
                    Editable = false;
                }
                field("Postal Code 3";"Postal Code 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Postal Code';
                    Editable = false;
                }
                field("Town 3";"Town 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Town';
                    Editable = false;
                }
                field("Mobile No. 4";"Mobile No. 4")
                {
                    ApplicationArea = Basic;
                    Caption = 'Mobile No.';
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Date of Birth3";"Date of Birth3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Date of Birth';
                    Editable = false;
                    ShowMandatory = true;
                }
                field("ID No.3";"ID No.3")
                {
                    ApplicationArea = Basic;
                    Caption = 'ID No.';
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Passport 3";"Passport 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Passport No.';
                    Editable = false;
                }
                field("Member Parish 3";"Member Parish 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Parish';
                    Editable = false;
                    ShowMandatory = true;
                }
                field("Member Parish Name 3";"Member Parish Name 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Member Parish Name';
                    Editable = false;
                }
                field(Gender3;Gender3)
                {
                    ApplicationArea = Basic;
                    Caption = 'Gender';
                    Editable = false;
                }
                field("Marital Status3";"Marital Status3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Marital Status';
                    Editable = false;
                }
                field("Home Postal Code3";"Home Postal Code3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Home Postal Code';
                    Editable = false;
                }
                field("Home Town3";"Home Town3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Home Town';
                    Editable = false;
                }
                field("Employer Code3";"Employer Code3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employer Code';
                    Editable = false;
                }
                field("Employer Name3";"Employer Name3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Employer Name';
                    Editable = false;
                }
                field("E-Mail (Personal3)";"E-Mail (Personal3)")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Picture 3";"Picture 3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Picture';
                    Editable = false;
                }
                field("Signature  3";"Signature  3")
                {
                    ApplicationArea = Basic;
                    Caption = 'Signature';
                    Editable = false;
                }
            }
            group("Term Deposit Details")
            {
                Caption = 'Term Deposit Details';
                field("Fixed Deposit Type";"Fixed Deposit Type")
                {
                    ApplicationArea = Basic;
                    Caption = 'Term Deposit Type';
                    Editable = false;
                    Visible = true;
                }
                field("Fixed Deposit Start Date";"Fixed Deposit Start Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Fixed Duration";"Fixed Duration")
                {
                    ApplicationArea = Basic;
                    Caption = 'Term Duration';
                    Editable = false;
                }
                field("Amount to Transfer";"Amount to Transfer")
                {
                    ApplicationArea = Basic;
                    Caption = 'Amount to Transfer from Current';
                    Editable = false;
                }
                field("Fixed Deposit Certificate No.";"Fixed Deposit Certificate No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Expected Interest On Term Dep";"Expected Interest On Term Dep")
                {
                    ApplicationArea = Basic;
                    Caption = 'Expected Interest Earned';
                    Editable = false;
                }
                field("FD Maturity Date";"FD Maturity Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Maturity Date';
                    Editable = false;
                }
                field("Fixed Deposit Status";"Fixed Deposit Status")
                {
                    ApplicationArea = Basic;
                    Caption = 'Term Deposit Status';
                    Editable = false;
                }
                field("Term Deposit Status Type";"FDR Deposit Status Type")
                {
                    ApplicationArea = Basic;
                    Caption = 'Term Deposit Status Type';
                    Editable = false;
                }
                field("On Term Deposit Maturity";"On Term Deposit Maturity")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Interest rate";"Interest rate")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Savings Account No.";"Savings Account No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Current Account No.';
                    Editable = false;
                }
                field("Transfer Amount to Savings";"Transfer Amount to Savings")
                {
                    ApplicationArea = Basic;
                    Caption = 'Transfer Amount to Current';
                    Editable = false;
                }
                field("Last Interest Earned Date";"Last Interest Earned Date")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
            group("Previous Term Deposit Details")
            {
                Caption = 'Previous Term Deposit Details';
                field("Prevous Fixed Deposit Type";"Prevous Fixed Deposit Type")
                {
                    ApplicationArea = Basic;
                    Caption = 'Fixed Deposit Type';
                    Editable = false;
                }
                field("Prevous FD Start Date";"Prevous FD Start Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Fixed Deposit Start Date';
                    Editable = false;
                }
                field("Prevous Fixed Duration";"Prevous Fixed Duration")
                {
                    ApplicationArea = Basic;
                    Caption = 'Fixed Deposit Duration';
                    Editable = false;
                }
                field("Prevous Expected Int On FD";"Prevous Expected Int On FD")
                {
                    ApplicationArea = Basic;
                    Caption = 'Expected Int On Fixed Deposit';
                    Editable = false;
                }
                field("Prevous FD Maturity Date";"Prevous FD Maturity Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Fixed Maturity Date';
                    Editable = false;
                }
                field("Prevous FD Deposit Status Type";"Prevous FD Deposit Status Type")
                {
                    ApplicationArea = Basic;
                    Caption = 'Fixed Deposit Status Type';
                    Editable = false;
                }
                field("Prevous Interest Rate FD";"Prevous Interest Rate FD")
                {
                    ApplicationArea = Basic;
                    Caption = 'Interest Rate Fixed Deposit';
                    Editable = false;
                }
                field("Date Renewed";"Date Renewed")
                {
                    ApplicationArea = Basic;
                }
            }
            group("ATM Details")
            {
                Caption = 'ATM Details';
                field("ATM No.B";"ATM No.")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("ATM Withdrawal Limit";"ATM Withdrawal Limit")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Transactions";"ATM Transactions")
                {
                    ApplicationArea = Basic;
                }
                field("Atm card ready";"Atm card ready")
                {
                    ApplicationArea = Basic;
                    Caption = 'ATM Card Ready For Collection';
                }
                field("FDR Deposit Status Type";"ATM Issued")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Self Picked";"ATM Self Picked")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Collector Name";"ATM Collector Name")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Collector's ID";"ATM Collector's ID")
                {
                    ApplicationArea = Basic;
                }
                field("ATM Collector's Mobile";"ATM Collector's Mobile")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Bulk Withdrawal Application")
            {
                Caption = 'Bulk Withdrawal Application';
                field("Bulk Withdrawal Appl Done";"Bulk Withdrawal Appl Done")
                {
                    ApplicationArea = Basic;
                    Caption = 'Bulk Withdrawal Appl. Done';
                    Editable = false;
                }
                field("Bulk Withdrawal Appl Date";"Bulk Withdrawal Appl Date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Bulk Withdrawal Appl. Date';
                    Editable = false;
                }
                field("Bulk Withdrawal App Date For W";"Bulk Withdrawal App Date For W")
                {
                    ApplicationArea = Basic;
                    Caption = 'Withdrawal Date';
                }
                field("Bulk Withdrawal Appl Amount";"Bulk Withdrawal Appl Amount")
                {
                    ApplicationArea = Basic;
                    Caption = 'Bulk Withdrawal Appl. Amount';
                    Editable = false;
                }
                field("Bulk Withdrawal Fee";"Bulk Withdrawal Fee")
                {
                    ApplicationArea = Basic;
                    Caption = 'Bulk Withdrawal Fee';
                    Editable = false;
                }
                field("Bulk Withdrawal App Done By";"Bulk Withdrawal App Done By")
                {
                    ApplicationArea = Basic;
                    Caption = 'Bulk Withdrawal Appl. Captured By';
                    Editable = false;
                }
            }
        }
        area(factboxes)
        {
            part(Control1000000034;"FOSA Statistics FactBox")
            {
                SubPageLink = "No."=field("No.");
            }
            part(Control16;"Member Statistics FactBox")
            {
                Caption = 'BOSA Statistics FactBox';
                SubPageLink = "No."=field("BOSA Account No");
            }
            part(Control1000000116;"Vendor Picture-Uploaded")
            {
                ApplicationArea = All;
                Caption = 'Picture';
                SubPageLink = "No."=field("No.");
            }
            part(Control1000000115;"Vendor Signature-Uploaded")
            {
                ApplicationArea = All;
                Caption = 'Signature';
                SubPageLink = "No."=field("No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Account)
            {
                Caption = 'Account';
                action("Ledger E&ntries")
                {
                    ApplicationArea = Basic;
                    Caption = 'Ledger E&ntries';
                    Image = VendorLedger;
                    RunObject = Page "Vendor Ledger Entries";
                    RunPageLink = "Vendor No."=field("No.");
                    RunPageView = sorting("Vendor No.");
                    ShortCutKey = 'Ctrl+F7';
                }
                action("GROUP Loans")
                {
                    ApplicationArea = Basic;
                    Caption = 'All Loans';
                    Promoted = true;
                    RunObject = Page "Loans Sub-Page List";
                    RunPageLink = "Account No"=field("No.");
                }
                action("Close Account")
                {
                    ApplicationArea = Basic;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    begin
                         if Confirm('Are you sure you want to Close this Account?',false)=true then begin
                         if "Balance (LCY)"-("Uncleared Cheques"+"ATM Transactions"+"EFT Transactions"+MinBalance+UnclearedLoan)<0 then
                         Error('This Member does not enough Savings to recover Withdrawal Fee')
                        else
                            LineN:=LineN+10000;
                            Gnljnline.Init;
                            Gnljnline."Journal Template Name":='GENERAL';
                            Gnljnline."Journal Batch Name":='ACC CLOSED';
                            Gnljnline."Line No.":=LineN;
                            Gnljnline."Account Type":=Gnljnline."account type"::Vendor;
                            Gnljnline."Account No.":="No.";
                            Gnljnline.Validate(Gnljnline."Account No.");
                            Gnljnline."Document No.":='LR-'+"No.";
                            Gnljnline."Posting Date":=Today;
                            Gnljnline.Amount:=500;
                            Gnljnline.Description:='Account Closure Fee';
                            Gnljnline.Validate(Gnljnline.Amount);
                            if Gnljnline.Amount<>0 then
                            Gnljnline.Insert;

                            LineN:=LineN+10000;
                            Gnljnline.Init;
                            Gnljnline."Journal Template Name":='GENERAL';
                            Gnljnline."Journal Batch Name":='ACC CLOSED';
                            Gnljnline."Line No.":=LineN;
                            Gnljnline."Account Type":=Gnljnline."bal. account type"::"G/L Account";
                            Gnljnline."Bal. Account No.":='105113';
                            Gnljnline.Validate(Gnljnline."Bal. Account No.");
                            Gnljnline."Document No.":='LR-'+"No.";
                            Gnljnline."Posting Date":=Today;
                            Gnljnline.Amount:=-500;
                            Gnljnline.Description:='Account Closure Fee';
                            Gnljnline.Validate(Gnljnline.Amount);
                            if Gnljnline.Amount<>0 then
                            Gnljnline.Insert;


                        end;
                    end;
                }
                action("Page Vendor Statement")
                {
                    ApplicationArea = Basic;
                    Caption = 'Statement';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        if ("Assigned System ID"<>'')  then begin //AND ("Assigned System ID"<>USERID)
                          if UserSetup.Get(UserId) then
                        begin
                        if UserSetup."View Special Accounts"=false then Error ('You do not have permission to view this account Details, Contact your system administrator! ')
                        end;

                          end;
                        Vend.Reset;
                        Vend.SetRange(Vend."No.","No.");
                        if Vend.Find('-') then
                        Report.Run(51516890,true,false,Vend)

                        //REPORT.RUN(51516476,TRUE,FALSE,Vend)
                    end;
                }
                action("Page Vendor Statistics")
                {
                    ApplicationArea = Basic;
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = "Report";
                    RunObject = Page "Vendor Statistics";
                    RunPageLink = "No."=field("No."),
                                  "Global Dimension 1 Filter"=field("Global Dimension 1 Filter"),
                                  "Global Dimension 2 Filter"=field("Global Dimension 2 Filter");
                    ShortCutKey = 'F7';
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        
        //Hide balances for hidden accounts
        /*IF CurrForm.UnclearedCh.VISIBLE=FALSE THEN BEGIN
        CurrForm.BookBal.VISIBLE:=TRUE;
        CurrForm.UnclearedCh.VISIBLE:=TRUE;
        CurrForm.AvalBal.VISIBLE:=TRUE;
        CurrForm.Statement.VISIBLE:=TRUE;
        CurrForm.Account.VISIBLE:=TRUE;
        END;
        
        
        IF Hide = TRUE THEN BEGIN
        IF UsersID.GET(USERID) THEN BEGIN
        IF UsersID."Show Hiden" = FALSE THEN BEGIN
        CurrForm.BookBal.VISIBLE:=FALSE;
        CurrForm.UnclearedCh.VISIBLE:=FALSE;
        CurrForm.AvalBal.VISIBLE:=FALSE;
        CurrForm.Statement.VISIBLE:=FALSE;
        CurrForm.Account.VISIBLE:=FALSE;
        END;
        END;
        END;
        //Hide balances for hidden accounts
          */
        MinBalance:=0;
        if AccountType.Get("Account Type") then
        MinBalance:=AccountType."Minimum Balance";
        
        /*CurrForm.lblID.VISIBLE := TRUE;
        CurrForm.lblDOB.VISIBLE := TRUE;
        CurrForm.lblRegNo.VISIBLE := FALSE;
        CurrForm.lblRegDate.VISIBLE := FALSE;
        CurrForm.lblGender.VISIBLE := TRUE;
        CurrForm.txtGender.VISIBLE := TRUE;
        IF "Account Category" <> "Account Category"::Single THEN BEGIN
        CurrForm.lblID.VISIBLE := FALSE;
        CurrForm.lblDOB.VISIBLE := FALSE;
        CurrForm.lblRegNo.VISIBLE := TRUE;
        CurrForm.lblRegDate.VISIBLE := TRUE;
        CurrForm.lblGender.VISIBLE := FALSE;
        CurrForm.txtGender.VISIBLE := FALSE;
        END;*/
        OnAfterGetCurrRecord;
        
        Statuschange.Reset;
        Statuschange.SetRange(Statuschange."User ID",UserId);
        Statuschange.SetRange(Statuschange."Function",Statuschange."function"::"Account Status");
        if not Statuschange.Find('-')then
        CurrPage.Editable:=false
        else
        CurrPage.Editable:=true;
        
        CalcFields(NetDis);
        UnclearedLoan:=NetDis;
        
        Joint2DetailsVisible:=false;
        Joint3DetailsVisible:=false;
        if "Account Category"="account category"::Joint then
          begin
            Joint2DetailsVisible:=true;
            Joint3DetailsVisible:=true;
            end;
        
        
        if ("Assigned System ID"<>'')  then begin //AND ("Assigned System ID"<>USERID)
          if UserSetup.Get(UserId) then
        begin
        if UserSetup."View Special Accounts"=false then Error ('You do not have permission to view this account Details, Contact your system administrator! ')
        end;
        
          end;

    end;

    trigger OnFindRecord(Which: Text): Boolean
    var
        RecordFound: Boolean;
    begin
        RecordFound := Find(Which);
        CurrPage.Editable := RecordFound or (GetFilter("No.") = '');
        exit(RecordFound);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        "Creditor Type":="creditor type"::"Savings Account";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord;
    end;

    trigger OnOpenPage()
    begin
        ActivateFields;


        Joint2DetailsVisible:=false;
        Joint3DetailsVisible:=false;
        if "Account Category"="account category"::Joint then
          begin
            Joint2DetailsVisible:=true;
            Joint3DetailsVisible:=true;
            end;
        //CueMgnt.GetVisitFrequency(ObjCueControl."Member No"::"2","No.");
    end;

    var
        CalendarMgmt: Codeunit "Calendar Management";
        PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
        CustomizedCalEntry: Record "Customized Calendar Entry";
        CustomizedCalendar: Record "Customized Calendar Change";
        Text001: label 'Do you want to allow payment tolerance for entries that are currently open?';
        Text002: label 'Do you want to remove payment tolerance from entries that are currently open?';
        PictureExists: Boolean;
        AccountTypes: Record "Account Types-Saving Products";
        GenJournalLine: Record "Gen. Journal Line";
        GLPosting: Codeunit "Gen. Jnl.-Post Line";
        StatusPermissions: Record "Status Change Permision";
        Charges: Record Charges;
        ForfeitInterest: Boolean;
        InterestBuffer: Record "Interest Buffer";
        FDType: Record "Fixed Deposit Type";
        Vend: Record Vendor;
        Cust: Record "Member Register";
        LineNo: Integer;
        UsersID: Record User;
        DActivity: Code[20];
        DBranch: Code[20];
        MinBalance: Decimal;
        OBalance: Decimal;
        OInterest: Decimal;
        Gnljnline: Record "Gen. Journal Line";
        TotalRecovered: Decimal;
        LoansR: Record "Loans Register";
        LoanAllocation: Decimal;
        LGurantors: Record "Loan GuarantorsFOSA";
        Loans: Record "Loans Register";
        DefaulterType: Code[20];
        LastWithdrawalDate: Date;
        AccountType: Record "Account Types-Saving Products";
        ReplCharge: Decimal;
        Acc: Record Vendor;
        SearchAcc: Code[10];
        Searchfee: Decimal;
        Statuschange: Record "Status Change Permision";
        UnclearedLoan: Decimal;
        LineN: Integer;
        Joint2DetailsVisible: Boolean;
        Joint3DetailsVisible: Boolean;
        GenSetup: Record "Sacco General Set-Up";
        UserSetup: Record "User Setup";
        Saccosetup: Record "Sacco No. Series";
        NewMembNo: Code[30];
        OpenApprovalEntriesExist: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        CanCancelApprovalForRecord: Boolean;
        EventFilter: Text;
        EnableCreateMember: Boolean;
        FieldStyleI: Text;
        ObjCueControl: Record "Guarantor Info Update Temp";


    procedure ActivateFields()
    begin
        //CurrForm.Contact.EDITABLE("Primary Contact No." = '');
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        ActivateFields;
    end;

    local procedure SetFieldStyle()
    begin
        FieldStyleI := '';

        if "Account Special Instructions"<>'' then
          FieldStyleI := 'Attention';
    end;
}

