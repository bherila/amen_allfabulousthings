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

Public Partial Class Login : Inherits System.Web.UI.Page
	Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)

	End Sub
	Protected Sub LogInUser(ByVal sender As Object, ByVal e As EventArgs)
		 'check to see if this person has a cookie
		If Not Request.Cookies("shopperID") Is Nothing Then
			Dim sAnonID As String = Request.Cookies("shopperID").Value

			'get the user id and transfer the cart
			ShoppingCartManager.Transfer(sAnonID, Login1.UserName)
		End If
	End Sub
End Class
