#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Report 51516118 "Store Requisition"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Store Requisition.rdlc';

    dataset
    {
        dataitem("Store Requistion Header";"Store Requistion Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";
            column(ReportForNavId_1826; 1826)
            {
            }
            column(FORMAT_TODAY_0_4_;Format(Today,0,4))
            {
            }
            column(CurrReport_PAGENO;CurrReport.PageNo)
            {
            }
            column(USERID;UserId)
            {
            }
            column(Store_Requistion_Header__Required_Date_;"Required Date")
            {
            }
            column(Store_Requistion_Header__Shortcut_Dimension_4_Code_;"Shortcut Dimension 4 Code")
            {
            }
            column(Store_Requistion_Header_Dim4;Dim4)
            {
            }
            column(Store_Requistion_Header__Request_date_;"Request date")
            {
            }
            column(Store_Requistion_Header__Shortcut_Dimension_3_Code_;"Shortcut Dimension 3 Code")
            {
            }
            column(Store_Requistion_Header_Dim3;Dim3)
            {
            }
            column(Store_Requistion_Header__Request_Description_;"Request Description")
            {
            }
            column(Store_Requistion_Header__Shortcut_Dimension_2_Code_;"Shortcut Dimension 2 Code")
            {
            }
            column(Store_Requistion_Header__Budget_Center_Name_;"Budget Center Name")
            {
            }
            column(Store_Requistion_Header__No__;"No.")
            {
            }
            column(Store_Requistion_Header__Global_Dimension_1_Code_;"Global Dimension 1 Code")
            {
            }
            column(Store_Requistion_Header__Function_Name_;"Function Name")
            {
            }
            column(TIME_PRINTED_____FORMAT_TIME_;'TIME PRINTED:' + Format(Time))
            {
                AutoFormatType = 1;
            }
            column(DATE_PRINTED_____FORMAT_TODAY_0_4_;'DATE PRINTED:' + Format(Today,0,4))
            {
                AutoFormatType = 1;
            }
            column(USERID_Control1102755048;UserId)
            {
            }
            column(Store_RequistionCaption;Store_RequistionCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption;CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Store_Requistion_Lines_DescriptionCaption;"Store Requistion Lines".FieldCaption(Description))
            {
            }
            column(Store_Requistion_Lines_QuantityCaption;"Store Requistion Lines".FieldCaption(Quantity))
            {
            }
            column(UoMCaption;UoMCaptionLbl)
            {
            }
            column(Store_Requistion_Lines__Line_Amount_Caption;"Store Requistion Lines".FieldCaption("Line Amount"))
            {
            }
            column(Store_Requistion_Lines__Unit_Cost_Caption;"Store Requistion Lines".FieldCaption("Unit Cost"))
            {
            }
            column(Store_Requistion_Header__Required_Date_Caption;FieldCaption("Required Date"))
            {
            }
            column(Store_Requistion_Header__Shortcut_Dimension_4_Code_Caption;FieldCaption("Shortcut Dimension 4 Code"))
            {
            }
            column(Store_Requistion_Lines__No__Caption;"Store Requistion Lines".FieldCaption("No."))
            {
            }
            column(Store_Requistion_Header__Request_date_Caption;FieldCaption("Request date"))
            {
            }
            column(Store_Requistion_Header__Shortcut_Dimension_3_Code_Caption;FieldCaption("Shortcut Dimension 3 Code"))
            {
            }
            column(Store_Requistion_Header__Request_Description_Caption;FieldCaption("Request Description"))
            {
            }
            column(Store_Requistion_Header__Shortcut_Dimension_2_Code_Caption;FieldCaption("Shortcut Dimension 2 Code"))
            {
            }
            column(Store_Requistion_Header__No__Caption;FieldCaption("No."))
            {
            }
            column(Store_Requistion_Header__Global_Dimension_1_Code_Caption;FieldCaption("Global Dimension 1 Code"))
            {
            }
            column(Date_Caption;Date_CaptionLbl)
            {
            }
            column(Name_Caption;Name_CaptionLbl)
            {
            }
            column(RecipientCaption;RecipientCaptionLbl)
            {
            }
            column(Printed_By_Caption;Printed_By_CaptionLbl)
            {
            }
            column(Name_Caption_Control1102755052;Name_Caption_Control1102755052Lbl)
            {
            }
            column(Date_Caption_Control1102755053;Date_Caption_Control1102755053Lbl)
            {
            }
            column(Signature_Caption;Signature_CaptionLbl)
            {
            }
            column(AuthorisationsCaption;AuthorisationsCaptionLbl)
            {
            }
            column(EmptyStringCaption;EmptyStringCaptionLbl)
            {
            }
            column(Signature_Caption_Control1102755000;Signature_Caption_Control1102755000Lbl)
            {
            }
            column(DocHeader;DocHeader)
            {
            }
            column(CompanyInfoName;CompanyInfo.Name)
            {
            }
            column(CompanyInfoAdd;CompanyInfo.Address)
            {
            }
            column(CompanyInfoAdd2;CompanyInfo."Address 2")
            {
            }
            column(CompanyInfoPicture;CompanyInfo.Picture)
            {
            }
            dataitem("Store Requistion Lines";"Store Requistion Lines")
            {
                DataItemLink = "Requistion No"=field("No.");
                DataItemTableView = sorting("Requistion No","Line No.") order(ascending);
                column(ReportForNavId_7187; 7187)
                {
                }
                column(Store_Requistion_Lines__No__;"No.")
                {
                }
                column(Store_Requistion_Lines_Description;Description)
                {
                }
                column(Store_Requistion_Lines_Quantity;Quantity)
                {
                }
                column(Store_Requistion_Lines__Unit_of_Measure_;"Unit of Measure")
                {
                }
                column(Store_Requistion_Lines__Line_Amount_;"Line Amount")
                {
                }
                column(Store_Requistion_Lines__Unit_Cost_;"Unit Cost")
                {
                }
                column(Store_Requistion_Lines_Requistion_No;"Requistion No")
                {
                }
            }
            dataitem("Approval Entry";"Approval Entry")
            {
                DataItemLink = "Document No."=field("No.");
                DataItemTableView = where("Document Type"=const("Staff Claims "),Status=const(Approved));
                column(ReportForNavId_1102755003; 1102755003)
                {
                }
                column(SequenceNo_ApprovalEntry;"Approval Entry"."Sequence No.")
                {
                }
                column(SenderID_ApprovalEntry;"Approval Entry"."Sender ID")
                {
                }
                column(ApproverID_ApprovalEntry;"Approval Entry"."Approver ID")
                {
                }
                column(DateTimeSentforApproval_ApprovalEntry;"Approval Entry"."Date-Time Sent for Approval")
                {
                }
                column(LastDateTimeModified_ApprovalEntry;"Approval Entry"."Last Date-Time Modified")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                if "Document Type"="document type"::Grant then
                  DocHeader:='Staff Grant Requisition'
                else
                  DocHeader:='Store Requisition';

                if Status = Status::Posted then
                begin
                  if "Document Type"="document type"::Grant then
                  DocHeader:='Staff Grant Issue'
                else
                  DocHeader:='Store Issue'
                end
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
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture)
    end;

    var
        Store_RequistionCaptionLbl: label 'Store Requistion';
        CurrReport_PAGENOCaptionLbl: label 'Page';
        UoMCaptionLbl: label 'UoM';
        Date_CaptionLbl: label 'Date:';
        Name_CaptionLbl: label 'Name:';
        RecipientCaptionLbl: label 'Recipient';
        Printed_By_CaptionLbl: label 'Printed By:';
        Name_Caption_Control1102755052Lbl: label 'Name:';
        Date_Caption_Control1102755053Lbl: label 'Date:';
        Signature_CaptionLbl: label 'Signature:';
        AuthorisationsCaptionLbl: label 'Authorisations';
        EmptyStringCaptionLbl: label '================================================================================================================================================================================================';
        Signature_Caption_Control1102755000Lbl: label 'Signature:';
        DocHeader: Text;
        CompanyInfo: Record "Company Information";
}

