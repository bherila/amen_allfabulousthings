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

Public Partial Class site : Inherits System.Web.UI.MasterPage
	Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        'pnlAdmin.Visible = Page.User.IsInRole("Administrators")
	End Sub

	Protected Sub lnkLogout_Click(ByVal sender As Object, ByVal e As EventArgs)
        FormsAuthentication.SignOut()
		Response.Redirect("login.aspx")
    End Sub
	Protected Sub btnSearch_Click(ByVal sender As Object, ByVal e As ImageClickEventArgs)
		If txtSearch.Text <> String.Empty Then
			Response.Redirect("search.aspx?q=" & txtSearch.Text)
		End If
	End Sub
End Class
