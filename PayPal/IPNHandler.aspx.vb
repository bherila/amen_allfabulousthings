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
Imports System.Net
Imports System.IO

Public Partial Class IPNHandler : Inherits System.Web.UI.Page
	Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
		Dim ppTX As String = Request.Form("txn_id").ToString()
		Dim sOrderID As String = Request.Form("custom").ToString()
		Dim sAmount As String = Request.Form("mc_gross").ToString()
		Dim status As String = Request.Form("payment_status").ToString()

		'log the incoming IPN
		Log.Write("IPN", "Info", "Incoming IPN for order " & sOrderID, sOrderID, "")
		'all we need at this point is the SUCCESS flag
		If VerifyIPN() Then
			'get the amount
			If sAmount <> String.Empty Then

				Dim dPaidFor As Double = Double.Parse(sAmount)

                'make sure the totals add up
				Dim orderID As Integer = Convert.ToInt16(sOrderID)
				Dim order As Order = OrdersManager.GetOrderByID(orderID)

				Dim dTotal As Double = order.OrderSubTotal + order.Tax + order.Shipping
                If dTotal >= dPaidFor Then
                    OrdersManager.CommitOrder(orderID, ppTX)
                    Log.Write("IPN", "Info", "Order Reconciled " & sOrderID, sOrderID, order.UserName)

                    'if your PayPal account is setup to accept eChecks, 
                    'the payment will come back with a status of "Pending"
                    'if it's pending, mark the order as such
                    'the IPN will fire the order when the check clears
                    If status.ToLower().Equals("pending") Then
                        OrdersManager.UpdateStatus(orderID, OrdersManager.WAITING_ON_PAYPAL_PAYMENT_ID)

                    End If
                Else
                    'set as invalid
                    OrdersManager.UpdateStatus(orderID, OrdersManager.INVALID_TOTALS_DONT_MATCH)
                    Log.Write("IPN", "Warning", "Order Invalid! Payments don't match " & sOrderID, sOrderID, order.UserName)

                    'TODO: Send an email to notify customer as well as store owner of an Invalid Payment

                End If

			End If
		End If

	End Sub
	Private Function VerifyIPN() As Boolean
		Dim strFormValues As String = Request.Form.ToString()
		Dim strNewValue As String
		Dim strResponse As String
		Dim serverURL As String = ""

		If SiteConfiguration.UseSandbox Then
			serverURL = "https://www.sandbox.paypal.com/cgi-bin/webscr"
		Else
			serverURL = "https://www.paypal.com/cgi-bin/webscr"

			'serverURL="http://www.eliteweaver.co.uk/cgi-bin/webscr ";
		End If
		' Create the request back
		Dim req As HttpWebRequest = CType(WebRequest.Create(serverURL), HttpWebRequest)

		' Set values for the request back
		req.Method = "POST"
		req.ContentType = "application/x-www-form-urlencoded"
		strNewValue = strFormValues & "&cmd=_notify-validate"
		req.ContentLength = strNewValue.Length

		' Write the request back IPN strings
		Dim stOut As StreamWriter = New StreamWriter(req.GetRequestStream(), System.Text.Encoding.ASCII)
		stOut.Write(strNewValue)
		stOut.Close()

		' Do the request to PayPal and get the response
		Dim stIn As StreamReader = New StreamReader(req.GetResponse().GetResponseStream())
		strResponse = stIn.ReadToEnd()
		stIn.Close()


		' Confirm whether the IPN was VERIFIED or INVALID. If INVALID, just ignore the IPN
		Return strResponse = "VERIFIED"

	End Function

End Class
