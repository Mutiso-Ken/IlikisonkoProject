#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Page 51516864 "Fosa Picture"
{
    PageType = CardPart;
    SourceTable = Vendor;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Picture2;Picture2)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    var
        CameraAvailable: Boolean;
        DeleteExportEnabled: Boolean;
        HideActions: Boolean;
        OverrideImageQst: label 'The existing picture will be replaced. Do you want to continue?';
        DeleteImageQst: label 'Are you sure you want to delete the picture?';
        SelectPictureTxt: label 'Select a picture to upload';
        DownloadImageTxt: label 'Download image';

    procedure ImportFromDevice()
    var
        FileManagement: Codeunit "File Management";
        FileName: Text;
        ClientFileName: Text;
    begin
        Find;
        TestField("No.");
        //TESTFIELD(Description);

        if Picture.Count > 0 then
          if not Confirm(OverrideImageQst) then
            Error('');

        ClientFileName := '';
        FileName := FileManagement.UploadFile(SelectPictureTxt,ClientFileName);
        if FileName = '' then
          Error('');

        Clear(Picture);
        Picture.ImportFile(FileName,ClientFileName);
        if not Insert(true) then
          Modify(true);

        if FileManagement.DeleteServerFile(FileName) then;
    end;

    local procedure SetEditableOnPictureActions()
    begin
        DeleteExportEnabled := Picture.Count <> 0;
    end;

    procedure IsCameraAvailable(): Boolean
    begin
        //EXIT(CameraProvider.IsAvailable);
    end;

    procedure SetHideActions()
    begin
        HideActions := true;
    end;


    procedure DeleteItemPicture()
    begin
        TestField("No.");

        if not Confirm(DeleteImageQst) then
          exit;

        Clear(Picture);
        Modify(true);
    end;
}

