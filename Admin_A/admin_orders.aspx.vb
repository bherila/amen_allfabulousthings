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

Public Partial Class admin_orders : Inherits System.Web.UI.Page
	Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
		trError.Visible = False
		If (Not Page.IsPostBack) Then
			'put today's date into the first text box
			txtDateEnd.Text = DateTime.Today.ToShortDateString()
			'put a 30 day lag in for the start date
			Dim dThirty As DateTime= DateTime.Today.Subtract(TimeSpan.FromDays(30))
			txtDateStart.Text = dThirty.ToShortDateString()
		End If
	End Sub
	Protected Sub btnSearch_Click(ByVal sender As Object, ByVal e As EventArgs)
		Try
			dgResults.DataSource = OrdersManager.OrdersByDateRange(txtDateStart.Text, txtDateEnd.Text)
			dgResults.DataBind()
		Catch
			trError.Visible = True
		End Try

	End Sub
	Protected Sub btnUserSearch_Click(ByVal sender As Object, ByVal e As EventArgs)
		dgResults.DataSource = OrdersManager.OrdersByUser(txtUserName.Text)
		dgResults.DataBind()

	End Sub
	Protected Sub btnTrans_Click(ByVal sender As Object, ByVal e As EventArgs)
		dgResults.DataSource = OrdersManager.OrdersByTransactionPartial(txtTransactionID.Text)
		dgResults.DataBind()

	End Sub
End Class
