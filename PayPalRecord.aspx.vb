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

Public Partial Class PayPalRecord : Inherits System.Web.UI.Page
	Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
		If (Not Page.IsPostBack) Then

			If Not Request.QueryString("t") Is Nothing Then
				'make sure they can view this transaction
				Dim transactionID As String=Request.QueryString("t").ToString()
				If OrdersManager.UserCanView(User.Identity.Name, transactionID) Then
					Dim wrapper As Commerce.PayPal.APIWrapper = New Commerce.PayPal.APIWrapper(SiteConfiguration.PayPalAPIAccountName, SiteConfiguration.PayPalAPIAccountPassword, SiteConfiguration.PayPalAPICertificationPath, SiteConfiguration.PayPalAPICertificationPassword)
					lblTransaction.Text=wrapper.GetTransactionDetail(transactionID, "<br>")


				Else
					lblTransaction.Text="You are not allowed to review this order"
				End If
			Else
				lblTransaction.Text="Invalid Order Number"
			End If
		End If
	End Sub
End Class
