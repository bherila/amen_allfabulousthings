<%@ Page language="vb" %>
<script language="vb" runat="server">

' Messages
Private NoFileMessage As String = "No file selected"
Private UploadSuccessMessage As String = "Uploaded Sucess"
Private NoImagesMessage As String = "No Images"
Private NoFolderSpecifiedMessage As String = "No folder"
Private NoFileToDeleteMessage As String = "No file to delete"
Private InvalidFileTypeMessage As String = "Invalid file type"
Private AcceptedFileTypes As String() = New String() {"jpg","jpeg","jpe","gif","bmp","png"}

' Configuration
Private UploadIsEnabled As Boolean = True
Private DeleteIsEnabled As Boolean = True
Private DefaultImageFolder As String = "images"

Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
	Dim isframe As String = "" & Request("frame")

	If isframe <> "" Then
		MainPage.Visible = True
		iframePanel.Visible = False

		Dim rif As String = "" & Request("rif")
		Dim cif As String = "" & Request("cif")

		If cif <> "" AndAlso rif <> "" Then
			RootImagesFolder.Value = rif
			CurrentImagesFolder.Value = cif
		Else
			RootImagesFolder.Value = DefaultImageFolder
			CurrentImagesFolder.Value = DefaultImageFolder
		End If

		UploadPanel.Visible = UploadIsEnabled
		DeleteImage.Visible = DeleteIsEnabled

		Dim FileErrorMessage As String = ""
		Dim ValidationString As String = ".*("
		'[\.jpg]|[\.jpeg]|[\.jpe]|[\.gif]|[\.bmp]|[\.png])$"
		Dim i As Integer=0
		Do While i<AcceptedFileTypes.Length
			ValidationString &= "[\." & AcceptedFileTypes(i) & "]"
			If i < (AcceptedFileTypes.Length-1) Then
			ValidationString &= "|"
			End If
			FileErrorMessage &= AcceptedFileTypes(i)
			If i < (AcceptedFileTypes.Length-1) Then
			FileErrorMessage &= ", "
			End If
			i += 1
		Loop
		FileValidator.ValidationExpression = ValidationString & ")$"
		FileValidator.ErrorMessage=FileErrorMessage

		If (Not IsPostBack) Then
			DisplayImages()
		End If
	Else

	End If
End Sub

Public Sub UploadImage_OnClick(ByVal sender As Object, ByVal e As EventArgs)
	If Page.IsValid Then
		If CurrentImagesFolder.Value <> "" Then
			If UploadFile.PostedFile.FileName.Trim() <> "" Then
				If IsValidFileType(UploadFile.PostedFile.FileName) Then
					Try
						Dim UploadFileName As String = ""
						Dim UploadFileDestination As String = ""
						UploadFileName = UploadFile.PostedFile.FileName
						UploadFileName = UploadFileName.Substring(UploadFileName.LastIndexOf("\")+1)
						UploadFileDestination = HttpContext.Current.Request.PhysicalApplicationPath
						UploadFileDestination &= CurrentImagesFolder.Value
						UploadFileDestination &= "\"
						UploadFile.PostedFile.SaveAs(UploadFileDestination & UploadFileName)
						ResultsMessage.Text = UploadSuccessMessage
					Catch ex As Exception
						'ResultsMessage.Text = "Your file could not be uploaded: " + ex.Message;
						ResultsMessage.Text = "There was an error."
					End Try
				Else
					ResultsMessage.Text = InvalidFileTypeMessage
				End If
			Else
				ResultsMessage.Text = NoFileMessage
			End If
		Else
			ResultsMessage.Text = NoFolderSpecifiedMessage
		End If
	Else
		ResultsMessage.Text = InvalidFileTypeMessage

	End If
	DisplayImages()
End Sub

Public Sub DeleteImage_OnClick(ByVal sender As Object, ByVal e As EventArgs)
	If FileToDelete.Value <> "" AndAlso FileToDelete.Value <> "undefined" Then
		Try
			Dim AppPath As String = HttpContext.Current.Request.PhysicalApplicationPath
			System.IO.File.Delete(AppPath & CurrentImagesFolder.Value & "\" & FileToDelete.Value)
			ResultsMessage.Text = "Deleted: " & FileToDelete.Value
		Catch ex As Exception
			ResultsMessage.Text = "There was an error."
		End Try
	Else
		ResultsMessage.Text = NoFileToDeleteMessage
	End If
	DisplayImages()
End Sub

Private Function IsValidFileType(ByVal FileName As String) As Boolean
	Dim ext As String = FileName.Substring(FileName.LastIndexOf(".")+1,FileName.Length-FileName.LastIndexOf(".")-1)
	Dim i As Integer=0
	Do While i<AcceptedFileTypes.Length
		If ext = AcceptedFileTypes(i) Then
			Return True

		End If
		i += 1
	Loop
	Return False
End Function


Private Function ReturnFilesArray() As String()
	If CurrentImagesFolder.Value <> "" Then
		Try
			Dim AppPath As String = HttpContext.Current.Request.PhysicalApplicationPath
			Dim ImageFolderPath As String = AppPath & CurrentImagesFolder.Value
			Dim FilesArray As String() = System.IO.Directory.GetFiles(ImageFolderPath,"*")
			Return FilesArray


		Catch

			Return Nothing
		End Try
	Else
		Return Nothing
	End If

End Function

Private Function ReturnDirectoriesArray() As String()
	If CurrentImagesFolder.Value <> "" Then
		Try
			Dim AppPath As String = HttpContext.Current.Request.PhysicalApplicationPath
			Dim CurrentFolderPath As String = AppPath & CurrentImagesFolder.Value
			Dim DirectoriesArray As String() = System.IO.Directory.GetDirectories(CurrentFolderPath,"*")
			Return DirectoriesArray
		Catch
			Return Nothing
		End Try
	Else
		Return Nothing
	End If
End Function


Public Sub DisplayImages()
	Dim FilesArray As String() = ReturnFilesArray()
	Dim DirectoriesArray As String() = ReturnDirectoriesArray()
	Dim AppPath As String = HttpContext.Current.Request.PhysicalApplicationPath
	Dim AppUrl As String

	'Get the application's URL
	If Request.ApplicationPath = "/" Then
		AppUrl = Request.ApplicationPath
	Else
		AppUrl = Request.ApplicationPath & "/"
	End If

	GalleryPanel.Controls.Clear()
	If (FilesArray Is Nothing OrElse FilesArray.Length = 0) AndAlso (DirectoriesArray Is Nothing OrElse DirectoriesArray.Length = 0) Then
		gallerymessage.Text = NoImagesMessage & ": " & RootImagesFolder.Value
	Else
		Dim ImageFileName As String = ""
		Dim ImageFileLocation As String = ""

		Dim thumbWidth As Integer = 94
		Dim thumbHeight As Integer = 94

		If CurrentImagesFolder.Value <> RootImagesFolder.Value Then

			Dim myHtmlImage As System.Web.UI.HtmlControls.HtmlImage = New System.Web.UI.HtmlControls.HtmlImage()
			myHtmlImage.Src = AppUrl & "ui/images/ftb/folder.up.gif"
			myHtmlImage.Attributes("unselectable")="on"
			myHtmlImage.Attributes("align")="absmiddle"
			myHtmlImage.Attributes("vspace")="36"

			Dim ParentFolder As String = CurrentImagesFolder.Value.Substring(0,CurrentImagesFolder.Value.LastIndexOf("\"))

			Dim myImageHolder As System.Web.UI.WebControls.Panel = New System.Web.UI.WebControls.Panel()
			myImageHolder.CssClass = "imageholder"
			myImageHolder.Attributes("unselectable")="on"
			myImageHolder.Attributes("onclick")="divClick(this,'');"
			myImageHolder.Attributes("ondblclick")="gotoFolder('" & RootImagesFolder.Value & "','" & ParentFolder.Replace("\","\\") & "');"
			myImageHolder.Controls.Add(myHtmlImage)

			Dim myMainHolder As System.Web.UI.WebControls.Panel = New System.Web.UI.WebControls.Panel()
			myMainHolder.CssClass = "imagespacer"
			myMainHolder.Controls.Add(myImageHolder)

			Dim myTitleHolder As System.Web.UI.WebControls.Panel = New System.Web.UI.WebControls.Panel()
			myTitleHolder.CssClass = "titleHolder"
			myTitleHolder.Controls.Add(New LiteralControl("Up"))
			myMainHolder.Controls.Add(myTitleHolder)

			GalleryPanel.Controls.Add(myMainHolder)

		End If

		For Each _Directory As String In DirectoriesArray

			Try
				Dim DirectoryName As String = _Directory.ToString()


				Dim myHtmlImage As System.Web.UI.HtmlControls.HtmlImage = New System.Web.UI.HtmlControls.HtmlImage()
				myHtmlImage.Src = AppUrl & "ui/images/ftb/folder.big.gif"
				myHtmlImage.Attributes("unselectable")="on"
				myHtmlImage.Attributes("align")="absmiddle"
				myHtmlImage.Attributes("vspace")="29"

				Dim myImageHolder As System.Web.UI.WebControls.Panel = New System.Web.UI.WebControls.Panel()
				myImageHolder.CssClass = "imageholder"
				myImageHolder.Attributes("unselectable")="on"
				myImageHolder.Attributes("onclick")="divClick(this);"
				myImageHolder.Attributes("ondblclick")="gotoFolder('" & RootImagesFolder.Value & "','" & DirectoryName.Replace(AppPath,"").Replace("\","\\") & "');"
				myImageHolder.Controls.Add(myHtmlImage)

				Dim myMainHolder As System.Web.UI.WebControls.Panel = New System.Web.UI.WebControls.Panel()
				myMainHolder.CssClass = "imagespacer"
				myMainHolder.Controls.Add(myImageHolder)

				Dim myTitleHolder As System.Web.UI.WebControls.Panel = New System.Web.UI.WebControls.Panel()
				myTitleHolder.CssClass = "titleHolder"
				myTitleHolder.Controls.Add(New LiteralControl(DirectoryName.Replace(AppPath & CurrentImagesFolder.Value & "\","")))
				myMainHolder.Controls.Add(myTitleHolder)

				GalleryPanel.Controls.Add(myMainHolder)
			Catch
				' nothing for error
			End Try
		Next _Directory

		For Each ImageFile As String In FilesArray

			Try

				ImageFileName = ImageFile.ToString()
				ImageFileName = ImageFileName.Substring(ImageFileName.LastIndexOf("\")+1)
				ImageFileLocation = AppUrl
				ImageFileLocation = ImageFileLocation.Substring(ImageFileLocation.LastIndexOf("\")+1)
				'galleryfilelocation += "/";
				ImageFileLocation &= CurrentImagesFolder.Value
				ImageFileLocation &= "/"
				ImageFileLocation &= ImageFileName
				Dim myHtmlImage As System.Web.UI.HtmlControls.HtmlImage = New System.Web.UI.HtmlControls.HtmlImage()
				myHtmlImage.Src = ImageFileLocation
				Dim myImage As System.Drawing.Image = System.Drawing.Image.FromFile(ImageFile.ToString())
				myHtmlImage.Attributes("unselectable")="on"
				'myHtmlImage.border=0;

				' landscape image
				If myImage.Width > myImage.Height Then
					If myImage.Width > thumbWidth Then
						myHtmlImage.Width = thumbWidth
						myHtmlImage.Height = Convert.ToInt32(myImage.Height * thumbWidth/myImage.Width)
					Else
						myHtmlImage.Width = myImage.Width
						myHtmlImage.Height = myImage.Height
					End If
				' portrait image
				Else
					If myImage.Height > thumbHeight Then
						myHtmlImage.Height = thumbHeight
						myHtmlImage.Width = Convert.ToInt32(myImage.Width * thumbHeight/myImage.Height)
					Else
						myHtmlImage.Width = myImage.Width
						myHtmlImage.Height = myImage.Height
					End If
				End If

				If myHtmlImage.Height < thumbHeight Then
					myHtmlImage.Attributes("vspace") = Convert.ToInt32((thumbHeight/2)-(myHtmlImage.Height/2)).ToString()
				End If


				Dim myImageHolder As System.Web.UI.WebControls.Panel = New System.Web.UI.WebControls.Panel()
				myImageHolder.CssClass = "imageholder"
				myImageHolder.Attributes("onclick")="divClick(this,'" & ImageFileName & "');"
				myImageHolder.Attributes("ondblclick")="returnImage('" & ImageFileLocation.Replace("\","/") & "','" & myImage.Width.ToString() & "','" & myImage.Height.ToString() & "');"
				myImageHolder.Controls.Add(myHtmlImage)


				Dim myMainHolder As System.Web.UI.WebControls.Panel = New System.Web.UI.WebControls.Panel()
				myMainHolder.CssClass = "imagespacer"
				myMainHolder.Controls.Add(myImageHolder)

				Dim myTitleHolder As System.Web.UI.WebControls.Panel = New System.Web.UI.WebControls.Panel()
				myTitleHolder.CssClass = "titleHolder"
				myTitleHolder.Controls.Add(New LiteralControl(ImageFileName & "<BR>" & myImage.Width.ToString() & "x" & myImage.Height.ToString()))
				myMainHolder.Controls.Add(myTitleHolder)

				'GalleryPanel.Controls.Add(myImage);
				GalleryPanel.Controls.Add(myMainHolder)

				myImage.Dispose()
			Catch

			End Try
		Next ImageFile
		gallerymessage.Text = ""
	End If
End Sub
</script>
<asp:panel id="MainPage" runat="server" visible="false">
<HTML>
<HEAD runat=server>
<title>Insert Image</title>
<style>

body {
	margin: 0px 0px 0px 0px;
	padding: 0px 0px 0px 0px;
	background: #ffffff; 
	width: 100%;
	overflow:hidden;
	border: 0;
}

body,tr,td {
	color: #000000;
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10pt;
}

div.imagespacer {
	width: 120;
	height: 126;
	text-align: center;            
	float: left;
	font: 10pt verdana;
	margin: 5px;
	overflow: hidden;
}
div.imageholder {
	margin: 0px;
	padding: 0px;
	border: 1 solid #CCCCCC;
	width: 100;
	height: 100;
}

div.titleholder {
	font-family: ms sans serif, arial;
	font-size: 8pt;
	width: 100;
	text-overflow: ellipsis;
	overflow: hidden;
	white-space: nowrap;            
}        

</style>


<script language="javascript">
lastDiv = null;
function divClick(theDiv,filename) {
	if (lastDiv) {
		lastDiv.style.border = "1 solid #CCCCCC";
	}
	lastDiv = theDiv;
	theDiv.style.border = "2 solid #316AC5";
	
	document.getElementById("FileToDelete").value = filename;

}
function gotoFolder(rootfolder,newfolder) {
	window.navigate("ftb.imagegallery.aspx?frame=1&rif=" + rootfolder + "&cif=" + newfolder);
}        
function returnImage(imagename,width,height) {
	var arr = new Array();
	arr["filename"] = imagename;  
	arr["width"] = width;  
	arr["height"] = height;             
	window.parent.returnValue = arr;
	window.parent.close();    
}        
</script>        
</HEAD>
<body >
<table width=100% height=100% cellpadding=0 cellspacing=0 border=0>

<FORM encType="multipart/form-data" runat="server">

<tr><td>
	<div id="galleryarea" style="width=100%; height:100%; overflow: auto;">
		<asp:label id="gallerymessage" runat="server"></asp:label>
		<asp:panel id="GalleryPanel" runat="server"></asp:panel>
	</div>
</td></tr>
<asp:Panel id="UploadPanel" runat="server">
<tr><td height=16 style="padding-left:10px;border-top: 1 solid #999999; background-color:#99ccff;">
	
	<table>
	<tr>
		<td valign=top><input id="UploadFile" type="file" disabled="disabled" name="UploadFile" runat="server" style="width:300;"/></td>
		<td valign=top><asp:button id="UploadImage" Enabled="false" Text="Upload" runat="server" onclick="UploadImage_OnClick" /></td>
		<td valign=top><asp:button id="DeleteImage" Text="Delete" runat="server" onclick="DeleteImage_OnClick" /></td>
		<td valign=middle>        
	</tr>
	<tr>
		<td colspan=3>
			<asp:RegularExpressionValidator runat="server" 
				ControlToValidate="UploadFile" 
				id="FileValidator" display="dynamic"/>
			<asp:literal id="ResultsMessage" runat="server" />        
		</td>        
	</tr></table>    
	<input type="hidden" id="FileToDelete" Value="" runat="server" />
	<input type="hidden" id="RootImagesFolder" Value="images" runat="server" />
	<input type="hidden" id="CurrentImagesFolder" Value="images" runat="server" />
</td></tr>
</asp:panel>
</form>
</table>
</body>
</HTML>
</asp:panel>
<asp:panel id="iframePanel" runat="server" >
<html> 
<head><title>Insert Image</title></head>
<style>
body {
	margin: 0px 0px 0px 0px;
	padding: 0px 0px 0px 0px;
	background: #ffffff;
	overflow:hidden;
}
</style>
<body>
	<iframe style="width:100%;height:100%;border:0;" border=0 frameborder=0 src="ftb.imagegallery.aspx?frame=1&<%=Request.QueryString%>"></iframe>
</body>
</html>
</asp:panel>
