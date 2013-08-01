Imports Microsoft.VisualBasic
Imports System
Imports System.Data
Imports System.Configuration
Imports System.Collections
Imports System.Web
Imports System.Web.Security
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Web.UI.WebControls.WebParts
Imports System.Web.UI.HtmlControls

Public Partial Class ResultMessage : Inherits System.Web.UI.UserControl
	Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)

	End Sub
	Public Sub ShowSuccess(ByVal message As String)
		tblResult.Visible = True
		trSuccess.Visible = True
		trFail.Visible = False
		lblSuccess.Text = message
	End Sub
	Public Sub ShowFail(ByVal message As String)
		tblResult.Visible = True
		trSuccess.Visible = False
		trFail.Visible = True
		lblFail.Text = message

	End Sub
	Protected Function GetPath() As String
		Dim sPath As String = Request.ApplicationPath
		If sPath = "/" Then
			sPath = ""
		End If
		Return sPath
	End Function
End Class
