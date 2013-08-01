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

Public Partial Class Receipt : Inherits System.Web.UI.Page
	Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)

		Dim transactionID As String = ""
		If (Not Page.IsPostBack) Then
			If Not Request.QueryString("t") Is Nothing Then
				transactionID = Request.QueryString("t").ToString()
				Page.Title = "Order Receipt: " & transactionID
				lblTitle.Text = transactionID
				Try
					Dim rdr As IDataReader = OrdersManager.GetOrderByTransactionID(transactionID)
					Page.Title = "Your Receipt: " & transactionID
					Dim order As Order = New Order()
					order.Load(rdr)
					rdr.NextResult()

					dgItems.DataSource = rdr
					dgItems.DataBind()

					rdr.Close()

					LoadReceipt(order)
				Catch x As Exception
					ShowMessage("Error Retreiving Order: " & x.Message)
				End Try
			End If


		End If

	End Sub
	Private Sub LoadReceipt(ByVal order As Order)

		'make sure this user recorded this order
		If User.Identity.Name.ToLower()= order.UserName.ToLower() Then
			lblShippingSummary.Text = order.ShippingAddress.Replace(Constants.vbCr,"<br>")
			lblShippingMethod.Text = order.ShippingMethod
			lblShipping.Text=order.Shipping.ToString("C")
			lblTax.Text=order.Tax.ToString("C")
			lblPaymentMethod.Text=order.PaymentMethod
			lblTransactionID.Text=order.PayPalTransactionID
			lblStatus.Text = order.OrderStatus
			lblTrackingNumber.Text = order.ShippingTrackingNumber
			Dim dTotal As Double=order.OrderSubTotal+order.Tax+order.Shipping
			lblTotal.Text=dTotal.ToString("C")

		Else
			ShowMessage("This is not an order you can review")

		End If

	End Sub
	Private Sub ShowMessage(ByVal sMessage As String)
		trError.Visible = True
		lblError.Text = sMessage
		pnlDetail.Visible = False
	End Sub
End Class
