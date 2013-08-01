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

Public Partial Class PDTHandler : Inherits System.Web.UI.Page
	Private Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
		Dim ppTX As String = Request.QueryString("tx").ToString()
		Dim sOrderID As String = Request.QueryString("cm").ToString()
		Dim sAmount As String = Request.QueryString("amt").ToString()
		Dim status As String = Request.QueryString("st").ToString()

		'log this
		Log.Write("PDT", "Info", "Incoming PDT for order " & sOrderID, sOrderID, "")

		Dim pdtResponse As String = GetPDT(ppTX)
		'all we need at this point is the SUCCESS flag
		If pdtResponse.StartsWith("SUCCESS") Then
			'get the amount
            Dim dPaidFor As Double = Double.Parse(sAmount)

            'make sure the totals add up
            Dim orderID As Integer = Convert.ToInt16(sOrderID)
            Dim order As Order = OrdersManager.GetOrderByID(orderID)

            Dim dTotal As Double = order.OrderSubTotal + order.Tax + order.Shipping
            dTotal = dTotal.ToString("c")

            'this may seem like a hack, but there is an issue with
            'parsing decimal numbers from strings under different localizations


            If dPaidFor >= dTotal Then
                OrdersManager.CommitOrder(orderID, ppTX)

                'if your PayPal account is setup to accept eChecks, 
                'the payment will come back with a status of "Pending"
                'if it's pending, mark the order as such
                'the IPN will fire the order when the check clears
                If status.ToLower().Equals("pending") Then
                    OrdersManager.UpdateStatus(orderID, OrdersManager.WAITING_ON_ECHECK)

                End If
                Log.Write("PDT", "Info", "Order Reconciled " & sOrderID, sOrderID, order.UserName)

                'send them to the receipt page
                Response.Redirect(Utility.GetSiteRoot() & "/receipt.aspx?t=" & ppTX)
            Else
                'set as invalid\
                'commit the order, then invalidate it
                OrdersManager.CommitOrder(orderID, ppTX)
                OrdersManager.UpdateStatus(orderID, OrdersManager.INVALID_TOTALS_DONT_MATCH)
                Log.Write("PDT", "Warning", "Order Invalid! Payments don't match (Amount Paid:" & dPaidFor.ToString("c") & "; Amount Billed: " & dTotal.ToString("c"), sOrderID, order.UserName)

                'TODO: Send an email to notify customer as well as store owner of an Invalid Payment

            End If

        End If



	End Sub
	Private Function GetPDTValue(ByVal pdt As String, ByVal key As String) As String

		Dim keys As String() = pdt.Split(ControlChars.Lf)
		Dim thisVal As String = ""
		Dim thisKey As String=""
		For Each s As String In keys
			Dim bits As String() = s.Split("="c)
			If bits.Length > 1 Then
				thisVal = bits(1)
				thisKey = bits(0)
				If thisKey.ToLower().Equals(key) Then
					Exit For
				End If
			End If
		Next s
		Return thisVal


	End Function
	Private Function GetPDT(ByVal transactionID As String) As String

		Dim sOut As String = ""
		Dim PDTID As String = ""
		Try
			PDTID = System.Configuration.ConfigurationSettings.AppSettings("PayPalPDTID").ToString()
		Catch

		End Try
		Dim sCmd As String = "_notify-synch"

		Dim serverURL As String = ""
		If SiteConfiguration.UseSandbox Then
			serverURL = "https://www.sandbox.paypal.com/cgi-bin/webscr"
		Else
			serverURL = "https://www.paypal.com/cgi-bin/webscr"


		End If


		Try
			Dim strFormValues As String = Request.Form.ToString()
			Dim strNewValue As String
			Dim strResponse As String

			' Create the request back
			Dim req As HttpWebRequest = CType(WebRequest.Create(serverURL), HttpWebRequest)

			' Set values for the request back
			req.Method = "POST"
			req.ContentType = "application/x-www-form-urlencoded"
			strNewValue = strFormValues & "&cmd=_notify-synch&at=" & PDTID & "&tx=" & transactionID
			req.ContentLength = strNewValue.Length

			' Write the request back IPN strings
			Dim stOut As StreamWriter = New StreamWriter(req.GetRequestStream(), System.Text.Encoding.ASCII)
			stOut.Write(strNewValue)
			stOut.Close()

			' Do the request to PayPal and get the response
			Dim stIn As StreamReader = New StreamReader(req.GetResponse().GetResponseStream())
			strResponse = stIn.ReadToEnd()

			stIn.Close()
			sOut = Server.UrlDecode(strResponse)


		Catch x As Exception
		End Try
		Return sOut

	End Function
End Class
