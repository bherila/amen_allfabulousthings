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

Public Partial Class MyOrders : Inherits System.Web.UI.Page
	Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
		If (Not Page.IsPostBack) Then
			rptMyOrders.DataSource = OrdersManager.OrdersByUser(User.Identity.Name)
			rptMyOrders.DataBind()
		End If
	End Sub

End Class
