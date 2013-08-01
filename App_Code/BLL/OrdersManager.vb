Imports Microsoft.VisualBasic
Imports System
Imports System.Data
Imports System.Configuration
Imports System.Web
Imports System.Web.Security
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Web.UI.WebControls.WebParts
Imports System.Web.UI.HtmlControls
Imports Commerce.Providers

''' <summary>
''' Summary description for OrderManager
''' </summary>
Public Class OrdersManager

	Public Const WAITING_ON_PAYPAL_PAYMENT_ID As Integer = 1
	Public Const RECEIVED_PAYMENT_PROCESSING_ORDER_ID As Integer = 2
	Public Const ORDER_PROCESSED_AND_SHIPPED_ID As Integer = 3
	Public Const ORDER_FULLY_REFUNDED_ID As Integer = 4
	Public Const INVALID_TOTALS_DONT_MATCH As Integer = 6
	Public Const WAITING_ON_ECHECK As Integer = 7

	#Region "Gateway Charger"
	''' <summary>
	''' Runs a charge through the Payment Gateway provider.
	''' </summary>
	''' <param name="firstName"></param>
	''' <param name="lastName"></param>
	''' <param name="address1"></param>
	''' <param name="address2"></param>
	''' <param name="city"></param>
	''' <param name="state"></param>
	''' <param name="zip"></param>
	''' <param name="country"></param>
	''' <param name="CCNumber"></param>
	''' <param name="CCExpMonth"></param>
	''' <param name="CCExpYear"></param>
	''' <param name="CCType"></param>
	''' <param name="CCCVV"></param>
	''' <param name="subtotal"></param>
	''' <param name="tax"></param>
	''' <param name="shipping"></param>
	''' <param name="shippingMethod"></param>
	''' <param name="paymentMethod"></param>
	''' <returns></returns>
	Public Shared Function RunCharge(ByVal firstName As String, ByVal lastName As String, ByVal address1 As String, ByVal address2 As String, ByVal city As String, ByVal state As String, ByVal zip As String, ByVal country As String, ByVal CCNumber As String, ByVal CCExpMonth As Integer, ByVal CCExpYear As Integer, ByVal CCType As CreditCardType, ByVal CCCVV As String, ByVal subtotal As Double, ByVal tax As Double, ByVal shipping As Double, ByVal shippingMethod As String, ByVal paymentMethod As String) As String
		Dim orderID As Integer = 0
		Dim sOut As String=""

		'get the currently logged on user
		Dim userName As String = System.Web.HttpContext.Current.User.Identity.Name

		'concatenate the shippingAddress - this simplifies shipping demands for foreign shipping addresses
		Dim shippingAddress As String=firstName & " " & lastName & Constants.vbCr & address1 & Constants.vbCr & address2 & Constants.vbCr & city & ", " & state & " " & zip & "  " & country

		'create an order number
		orderID = InitializeOrder(userName, shippingAddress, shippingMethod, subtotal, shipping, tax, zip, paymentMethod)

		If orderID > 0 Then

			Try
				'run the gateway charger - returns a transactionID or auth code
				Dim transactionID As String = Commerce.Providers.PaymentProvider.Instance.Charge(firstName, lastName,address1,address2,city,state,zip,country,CCNumber,CCExpMonth,CCExpYear, CCType,CCCVV,subtotal,tax,shipping,orderID.ToString())
				sOut = transactionID
				'commit the order in the db
				CommitOrder(orderID,transactionID)

				'Log this
				Log.Write("Checkout Completed Successfully", "Commerce", "Credit Card successfully charged for transactionID " & orderID.ToString(), transactionID, userName)
			Catch x As Exception
				'Kill the order
				'rethrow the Exception
				KillOrder(orderID)
				Throw x
			End Try
		End If
		Return sOut
	End Function

	#End Region

	#Region "API Calls"

	Public Shared Function RunExpressOrder(ByVal orderRec As Order, ByVal ppToken As String, ByVal payerID As String, ByVal items As Commerce.PayPal.APIWrapper.OrderItem()) As Commerce.PayPal.APIWrapper.OrderInfo

		Dim wrapper As Commerce.PayPal.APIWrapper = New Commerce.PayPal.APIWrapper(SiteConfiguration.PayPalAPIAccountName, SiteConfiguration.PayPalAPIAccountPassword, SiteConfiguration.PayPalAPICertificationPath, SiteConfiguration.PayPalAPICertificationPassword)
		Dim orderID As Integer = 0
		orderID = InitializeOrder(orderRec.UserName, orderRec.ShippingAddress, orderRec.ShippingMethod, orderRec.OrderSubTotal, orderRec.Shipping, orderRec.Tax, orderRec.OrderZipCode, orderRec.PaymentMethod)

		'add the order and the items, then run the charge to make sure
		Dim order As Commerce.PayPal.APIWrapper.OrderInfo = Nothing
		Try
			'create an order number
			'orderID = InitializeOrder(orderRec);
			If orderID > 0 Then

				'run the payment - no errors after this
				order = wrapper.DoExpressCheckout(orderRec.UserName, ppToken, payerID, orderRec.OrderSubTotal, orderRec.Tax, orderRec.Shipping, items, "", orderID.ToString())

				If order.Ack <> "Success" Then
					Throw New Exception(order.Ack)

				Else
					orderRec.PayPalTransactionID = order.TransactionID
					orderRec.OrderID = orderID

					'commit the order
					CommitOrder(orderID,order.TransactionID)
					'Log this
					Log.Write("Express Checkout Completed Successfully", "Commerce", "Order " & order.TransactionID & " completed successfully", order.TransactionID, System.Web.HttpContext.Current.User.Identity.Name)
				End If
			Else
				Throw New Exception("Invalid Order ID")
			End If
		Catch x As Exception
			'delete out the order and the order items
			KillOrder(orderID)
			'throw an exception
			Throw New Exception(x.Message)
		End Try
		'return the order info
		Return order
	End Function


	''' <summary>
	''' Refunds the entire sale amount using the PayPal API. This is NOT reversible.
	''' </summary>
	''' <param name="transactionID">The PayPal transactionID associated with the sale</param>
	''' <returns>A string representing "Success" if successful, or an error list if not.</returns>
	Public Shared Function RefundOrder(ByVal transactionID As String) As String
		Dim wrapper As Commerce.PayPal.APIWrapper = New Commerce.PayPal.APIWrapper(SiteConfiguration.PayPalAPIAccountName, SiteConfiguration.PayPalAPIAccountPassword, SiteConfiguration.PayPalAPICertificationPath, SiteConfiguration.PayPalAPICertificationPassword)

		'run the refund method. Errors are trapped in the routine
		'and returned as strings.
		Dim sOut As String=wrapper.RefundTransaction(transactionID)
		'Log this
		Log.Write("Refund Completed Successfully", "Commerce", "Order " & transactionID & " refunded successfully", transactionID, System.Web.HttpContext.Current.User.Identity.Name)


		Return sOut

	End Function

	''' <summary>
	''' Uses the PayPal API to get the transaction details of a particular transaction.
	''' </summary>
	''' <param name="transactionID">The PayPal transactionID associated with the sale</param>
	''' <returns>A delimited string with the basic transaction information</returns>
	Public Shared Function GetTransactionDetails(ByVal transactionID As String) As String
		Dim wrapper As Commerce.PayPal.APIWrapper = New Commerce.PayPal.APIWrapper(SiteConfiguration.PayPalAPIAccountName, SiteConfiguration.PayPalAPIAccountPassword, SiteConfiguration.PayPalAPICertificationPath, SiteConfiguration.PayPalAPICertificationPassword)
		Return wrapper.GetTransactionDetail(transactionID, "<br>")

	End Function
	#End Region

	#Region "Checkout Helper Functions"
	''' <summary>
	''' Creates and order record in the database prior to a sale.
	''' </summary>
	''' <param name="orderRec">The OrderRecord Object which contains the details of the sale</param>
	''' <param name="cart">The CartData object stored in the user's Profile</param>
	''' <returns>The new order ID (integer value)</returns>
	Public Shared Function InitializeOrder(ByVal userName As String, ByVal shippingAddress As String, ByVal shippingMethod As String, ByVal orderSubTotal As Double, ByVal shippintAmount As Double, ByVal taxAmount As Double, ByVal orderZipCode As String, ByVal paymentMethod As String) As Integer
		Dim context As String = ""
		Dim orderID As Integer = 0
		Try
			'create an order number
			orderID = OrdersProvider.Instance.OrderInsert(WAITING_ON_PAYPAL_PAYMENT_ID, userName, shippingAddress, shippingMethod, orderSubTotal, shippintAmount, taxAmount, orderZipCode, paymentMethod)

		Catch x As Exception
			'Kill the order on fail
			KillOrder(orderID)

			'throw an exception
			Throw New Exception(x.Message)
		End Try
		Return orderID
	End Function
	''' <summary>
	''' Deletes all order information, including the order details.
	''' </summary>
	''' <param name="orderID"></param>
	Public Shared Sub KillOrder(ByVal orderID As Integer)
		OrdersProvider.Instance.OrderDelete(orderID)
	End Sub

	''' <summary>
	''' Finalizes the order in the database, which includes updating the stats tables and debiting the inventory.
	''' Prior to the db routine running, the log enters that the payment has been received
	''' in case of any problems.
	''' </summary>
	''' <param name="orderRec">The OrderRecord Object</param>
	Public Shared Sub CommitOrder(ByVal orderID As Integer, ByVal transactionID As String)

	   'log the transaction
		'Log.Write("Purchase", "PayPal Payment Completed; finalizing order", "order " +
			'transactionID +
			'" has been paid", transctionID, System.Web.HttpContext.Current.User.Identity.Name);

		'finalize the order (checkout the cart, update the order status)
		OrdersProvider.Instance.OrderFinalize(orderID, transactionID)

		'debit the inventory
		'get the order items and adjust the inventory for each
		Dim rdr As IDataReader = OrdersManager.GetOrderItems(orderID)
		Do While rdr.Read()
			Dim productID As Integer = CInt(rdr("productID"))
			Dim quantity As Integer=CInt(rdr("quantity"))
			CatalogManager.AdjustInventory(productID, quantity, "Debit from sale " & transactionID)

		Loop
		rdr.Close()

		'email somebody to let them know an order was received...
		'TODO:implement order notification
	End Sub
	#End Region

	#Region "Get Functions"

	''' <summary>
	''' Gets an order by PayPal transactionID
	''' </summary>
	''' <param name="transactionID">PayPal transactionID</param>
	''' <returns>DataReader of the order</returns>
	Public Shared Function GetOrderByTransactionID(ByVal transactionID As String) As IDataReader
		Return OrdersProvider.Instance.OrderGetByTransactionID(transactionID)
	End Function
	''' <summary>
	''' Gets an order by orderID
	''' </summary>
	''' <param name="transactionID">PayPal transactionID</param>
	''' <returns>DataReader of the order</returns>
	Public Shared Function GetOrderByID(ByVal orderID As Integer) As Order
		Dim rdr As IDataReader=OrdersProvider.Instance.OrderGet(orderID)
		Dim order As Order = New Order()
		order.Load(rdr)
		rdr.Close()
		Return order
	End Function
	Public Shared Function GetOrderItems(ByVal orderID As Integer) As IDataReader
		Return OrdersProvider.Instance.OrdersGetItems(orderID)
	End Function
	''' <summary>
	''' Gets all orders for a given user
	''' </summary>
	''' <param name="userName">The user's login name</param>
	''' <returns>DataReader of the orders</returns>
	Public Shared Function OrdersByUser(ByVal userName As String) As IDataReader
		Return OrdersProvider.Instance.OrderGetByUser(userName)
	End Function

	''' <summary>
	''' Returns all orders with an order date falling within the specified range
	''' </summary>
	''' <param name="dateStart"></param>
	''' <param name="dateEnd"></param>
	''' <returns>DataReader</returns>
	Public Shared Function OrdersByDateRange(ByVal dateStart As String, ByVal dateEnd As String) As IDataReader
		Return OrdersProvider.Instance.OrdersByDateRange(dateStart, dateEnd)
	End Function

	''' <summary>
	''' Returns all orders for a partial transaction ID (such as transactionIDs starting with '8'
	''' </summary>
	''' <param name="transactionID"></param>
	''' <returns></returns>
	Public Shared Function OrdersByTransactionPartial(ByVal transactionID As String) As IDataReader
		Return OrdersProvider.Instance.OrdersByTransactionIDPartial(transactionID)
	End Function
	#End Region

	''' <summary>
	''' Updates the shipping address for a given order
	''' </summary>
	''' <param name="orderID"></param>
	''' <param name="shippingAddress">String blob of the the full address.</param>
	Public Shared Sub UpdateShippingAddress(ByVal orderID As Integer, ByVal shippingAddress As String)
		OrdersProvider.Instance.OrderUpdateShippingAddress(orderID, shippingAddress)
	End Sub

	''' <summary>
	''' Checks to see if the current user can view a specific order.
	''' </summary>
	''' <param name="userName"></param>
	''' <param name="transactionID"></param>
	''' <returns>True if the user put in the order</returns>
	Public Shared Function UserCanView(ByVal userName As String, ByVal transactionID As String) As Boolean
		Return OrdersProvider.Instance.OrderUserCanView(userName, transactionID)
	End Function

	#Region "Status Updates"

	''' <summary>
	''' Sets the order's ship date and status to shipped.
	''' </summary>
	''' <param name="orderID"></param>
	''' <param name="shipDate"></param>
	''' <param name="trackingNumber">The tracking number supplied by the shipping vendor (e.g. the Fedex Number)</param>
	Public Shared Sub SetAsShipped(ByVal orderID As Integer, ByVal shipDate As DateTime, ByVal trackingNumber As String)

		'depending on your shipping process, this is where you would notify the user
		'of the shipping/tracking info via email
		OrdersProvider.Instance.OrderSetShipped(orderID, shipDate,trackingNumber)
	End Sub

	''' <summary>
	''' Updates the order status to the supplied statusID.
	''' </summary>
	''' <param name="orderID"></param>
	''' <param name="statusID"></param>
	Public Shared Sub UpdateStatus(ByVal orderID As Integer, ByVal statusID As Integer)
		OrdersProvider.Instance.OrderUpdateStatus(orderID, statusID)

	End Sub
	#End Region
End Class

