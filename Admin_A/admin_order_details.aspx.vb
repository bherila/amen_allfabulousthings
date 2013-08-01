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

Public Partial Class admin_order_details : Inherits System.Web.UI.Page
	Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)

		If (Not Page.IsPostBack) Then

			LoadReceipt()
		End If

	End Sub
	Private Sub LoadReceipt()
		Dim transactionID As String = ""
		If Not Request.QueryString("t") Is Nothing Then
			transactionID = Request.QueryString("t").ToString()
			Try
				Dim rdr As IDataReader = OrdersManager.GetOrderByTransactionID(transactionID)
				Dim order As Order = New Order()
				order.Load(rdr)
				rdr.NextResult()

				dgItems.DataSource = rdr
				dgItems.DataBind()

				rdr.Close()

				'make sure this user recorded this order
				txtShippingAddress.Text = order.ShippingAddress.Replace("<br>",Constants.vbCrLf)
				lblShippingMethod.Text = order.ShippingMethod
				lblShipping.Text = order.Shipping.ToString("C")
				lblTax.Text = order.Tax.ToString("C")
				lblPaymentMethod.Text = order.PaymentMethod
				lblTransactionID.Text = order.PayPalTransactionID
				lblID.Text = order.OrderID.ToString()
				lblStatus.Text = order.OrderStatus
				txtTrackingNumber.Text = order.ShippingTrackingNumber

				btnRefundFull.Attributes.Add("onclick", "return CheckRefund()")

				txtShipDate.Text = DateTime.Now.ToShortDateString()
				Dim orderTotal As Double = order.OrderSubTotal + order.Tax + order.Shipping

				'if the order was refunded
				'disable the refund bits
				If order.OrderStatusID = OrdersManager.ORDER_FULLY_REFUNDED_ID Then
					DisableRefund()
					DisableShipping()

				End If

				If order.OrderStatusID = OrdersManager.ORDER_PROCESSED_AND_SHIPPED_ID Then
					DisableShipping()
					'DisableRefund();
				End If

				Dim dTotal As Double = order.OrderSubTotal + order.Tax + order.Shipping
				lblTotal.Text = dTotal.ToString("C")
			Catch x As Exception
				ShowMessage("Error Retreiving Order: " & x.Message, False)
			End Try
		End If

	End Sub
	Private Sub DisableRefund()
		btnRefundFull.Enabled = False

	End Sub
	Private Sub DisableShipping()
		btnSetShipped.Enabled = False
		txtShippingAddress.Enabled = False
		btnUpdateShipping.Enabled = False
		txtTrackingNumber.Enabled = False
		txtShipDate.Enabled = False
	End Sub
	Private Sub ShowMessage(ByVal sMessage As String, ByVal success As Boolean)
		uResult.Visible = True
		If success Then
			uResult.ShowSuccess(sMessage)
		Else
			uResult.ShowFail(sMessage)

		End If
	End Sub
	Protected Sub btnUpdateShipping_Click(ByVal sender As Object, ByVal e As EventArgs)
		Try
			OrdersManager.UpdateShippingAddress(Integer.Parse(lblID.Text), txtShippingAddress.Text.Replace(Constants.vbCrLf, "<br>"))
			ShowMessage("Shipping Address Updated",True)
			LoadReceipt()
		Catch x As Exception
			ShowMessage("Ship address failure: " & x.Message,False)
		End Try
	End Sub
	Protected Sub btnSetShipped_Click(ByVal sender As Object, ByVal e As EventArgs)
		Try

			Dim dShipped As DateTime=Convert.ToDateTime(txtShipDate.Text)
			OrdersManager.SetAsShipped(Integer.Parse(lblID.Text), dShipped, txtTrackingNumber.Text)
			ShowMessage("Order Set as Shipped",True)
			LoadReceipt()
		Catch x As Exception
			ShowMessage("Status Update failure: " & x.Message,False)
		End Try

	End Sub

	Private Sub LoadPP()
		lblPP.Text = OrdersManager.GetTransactionDetails(lblTransactionID.Text)
		lnkGetPPRecord.Visible = False
	End Sub
	Protected Sub btnRefundFull_Click(ByVal sender As Object, ByVal e As EventArgs)
		Dim sOut As String = OrdersManager.RefundOrder(lblTransactionID.Text)
		If sOut = "Success" Then
			'set the status in the db
			OrdersManager.UpdateStatus(Integer.Parse(lblID.Text), OrdersManager.ORDER_FULLY_REFUNDED_ID)
			ShowMessage(lblTotal.Text & " refunded successfully", True)
		Else
			ShowMessage(sOut, False)
		End If
		LoadReceipt()

	End Sub
	Protected Sub lnkGetPPRecord_Click(ByVal sender As Object, ByVal e As EventArgs)
		LoadPP()
	End Sub
End Class
