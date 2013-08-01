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
Imports System.Globalization

Public Partial Class CheckoutConfirm : Inherits System.Web.UI.Page
	'set scope so all methods can access
	Private cart As ShoppingCart

	Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
		'this page MUST be protected by SSL!

		cart = ShoppingCartManager.GetCart()
		If (Not Page.IsPostBack) Then
		   BindOrder()

			If Not Request.QueryString("token") Is Nothing Then
				Dim sToken As String = Request.QueryString("token").ToString()
				'load up the info
				LoadFromPP(sToken)
			Else If Not Request.QueryString("st") Is Nothing Then
				'this is a Payments Standard checkout
				'so set the payment method, and hide the other payment
				'bits
				lblPaymentSummary.Text = "PayPal Payment"
				tblBillInfo.Visible = False

			Else
				SaveBillingInfo()
				LoadFromProfile()
			End If

			Dim fromZip As String = ConfigurationManager.AppSettings("ShipFromZip").ToString()
			BindShipping(fromZip, Profile.Commerce.ShipZip, cart.TotalWeight)
            ddlShipService.Items.Add(New ListItem("Free local pick-up", "0.00"))
            ddlShipService.Items.Add(New ListItem("Free home delivery in Bernardsville, NJ area", "0.00"))

			LoadBillingLabels()
			LoadShippingLabels()
			SetTax(Profile.Commerce.ShipState)
			SetShipping()
			SetTotals()

		End If

        If SiteConfiguration.UsePayPalPaymentsStandard Then
            trPlaceOrder.Visible = False
            trRunPayPal.Visible = True
            PPStandardCheckout1.Subtotal = cart.SubTotal
            PPStandardCheckout1.TaxAmount = TaxCalculator.GetTaxByZip(Profile.Commerce.ShipZip, cart.SubTotal)
            PPStandardCheckout1.ShippingMethod = ddlShipService.SelectedItem.Text
            PPStandardCheckout1.ShippingAmount = Convert.ToDouble(ddlShipService.SelectedValue)


        Else
            trPlaceOrder.Visible = True
            trRunPayPal.Visible = False

        End If


	End Sub

	#Region "Control Bindings"
	Private Sub BindOrder()
			dgBasket.DataSource = cart.Items
			dgBasket.DataBind()

	End Sub
		Private Sub BindShipping(ByVal fromZip As String, ByVal toZip As String, ByVal weight As Double)
			Dim rdr As IDataReader = ShippingManager.GetShippingChoices(fromZip, toZip, weight)
			ddlShipService.DataSource = rdr
			ddlShipService.DataTextField = "Service"
			ddlShipService.DataValueField = "Rate"
			ddlShipService.DataBind()
			rdr.Close()

			'localize it
			Dim dRate As Double=0
			For Each l As ListItem In ddlShipService.Items
				dRate=Convert.ToDouble(l.Value)
				l.Text = l.Text & ": " & dRate.ToString("C")
			Next l
		End Sub

		Private Sub LoadShippingLabels()
			lblShipName.Text = Profile.Commerce.ShipFirst & " " & Profile.Commerce.ShipLast
			lblShipAddress1.Text = Profile.Commerce.ShipAddress1
			lblShipAddress2.Text = Profile.Commerce.ShipAddress2 & "<br>"
			lblShipAddress2.Visible = Profile.Commerce.ShipAddress2 <> String.Empty
			lblShipCity.Text = Profile.Commerce.ShipCity
			lblShipState.Text = Profile.Commerce.ShipState
			lblShipCountry.Text = Profile.Commerce.ShipCountry
			lblShipZip.Text = Profile.Commerce.ShipZip

		End Sub
		Private Sub LoadBillingLabels()
			lblName.Text = Profile.First & " " & Profile.Last
			lblAddress1.Text = Profile.Address1
			lblAddress2.Text = Profile.Address2 & "<br>"
			lblAddress2.Visible = Profile.Address2 <> String.Empty
			lblCity.Text = Profile.City
			lblState.Text = Profile.State
			lblCountry.Text = Profile.Country
			lblZip.Text = Profile.Zip


		End Sub

		Private Sub LoadFromPP(ByVal sToken As String)
			Dim wrapper As Commerce.PayPal.APIWrapper = New Commerce.PayPal.APIWrapper(SiteConfiguration.PayPalAPIAccountName, SiteConfiguration.PayPalAPIAccountPassword, SiteConfiguration.PayPalAPICertificationPath, SiteConfiguration.PayPalAPICertificationPassword)

			'they have come back from the PayPal site and have a token, so use this token to go get their info
			'and populate the shipping etc.
			Dim payer As Commerce.PayPal.APIWrapper.PayerInfo = wrapper.GetExpressCheckout(sToken)
			SavePayPalInfo(payer)



			'populate the final payment screen
			lblPaymentSummary.Text = "PayPal account<br>" & payer.PayerEmail
			txtToken.Text = payer.Token
			txtPayerID.Text = payer.PayerID

		End Sub
		Private Sub LoadFromProfile()

			If Not PreviousPage Is Nothing AndAlso PreviousPage.IsCrossPagePostBack Then

				'using a CrossPagePost to hold the credit card. We DO NOT want to save
				'this to the DB.

				txtCCNumber.Text = GetPreviousTextValue("txtCCNumber")
				txtCCAuthCode.Text = GetPreviousTextValue("txtCCAuthCode")
				txtCCType.Text = GetPreviousSelectValue("ddlCCType")
				txtCCExpMonth.Text = GetPreviousSelectValue("ddlExpMonth")
				txtCCExpYear.Text = GetPreviousSelectValue("ddlExpYear")


				Dim CCNumber As String = txtCCNumber.Text 'Encryption.Decrypt(Profile.Commerce.CCNumber, SiteConfiguration.EncryptionPassword);


				Dim lastFour As String = "XXXX"
				If CCNumber.Length > 4 Then
					'get the last 4 digits
					lastFour = CCNumber.Substring(CCNumber.Length - 4, 4)
				Else

				End If
				Dim ccNumReplaced As String = ""
				Dim i As Integer = 0
				Do While i < CCNumber.Length - 4
					ccNumReplaced &= "X"
					i += 1
				Loop
				ccNumReplaced &= lastFour

				lblPaymentSummary.Text = "Credit Card Account: <br>" & txtCCType.Text & ": " & ccNumReplaced
			End If

		End Sub
	#End Region

	#Region "Event Handlers"
	Protected Sub btnOrder_Click(ByVal sender As Object, ByVal e As EventArgs)

		'if there is a token in the querystring
		'this is a return from PayPal, and is therefore
		'an express checkout
		Dim transactionID As String = ""
		If Not Request.QueryString("token") Is Nothing Then
			transactionID=RunExpressCheckout()
		Else
			transactionID = RunCharge()
		End If

		'if an error occurred, the error will be shown in
		'tablerow trError. if that's visible, don't send them off
		If uResult.Visible = False Then
			Response.Redirect(Request.ApplicationPath & "/Receipt.aspx?t=" & transactionID)
		End If
	End Sub
	Protected Sub btnChange_Click(ByVal sender As Object, ByVal e As EventArgs)
		Response.Redirect("Checkout.aspx")

	End Sub


	Protected Sub ddlShipService_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs)
		SetShipping()
		SetTotals()
	End Sub
	#End Region

	#Region "Profile Updaters"
	Private Sub SaveBillingInfo()
		'get the billing and save to profile
		Profile.First = GetPreviousTextValue("txtBillFirst")
		Profile.Last = GetPreviousTextValue("txtBillLast")
		Profile.City = GetPreviousTextValue("txtBillCity")
		Profile.Zip = GetPreviousTextValue("txtBillZip")
		Profile.Address1 = GetPreviousTextValue("txtBillAddress")
		Profile.Address2 = GetPreviousTextValue("txtBillAddress2")
		Profile.Country = GetPreviousSelectValue("ddlCountry")
		If Profile.Country = "US" Then
			Profile.State = GetPreviousSelectValue("ddlState")
		Else
			Profile.State = GetPreviousTextValue("txtState")

		End If

		Profile.Save()

	End Sub
	Private Sub SavePayPalInfo(ByVal payer As Commerce.PayPal.APIWrapper.PayerInfo)
		'save the profile info for later
		Profile.Commerce.ShipFirst = payer.PayerFirst
		Profile.Commerce.ShipLast = payer.PayerLast
		Profile.Commerce.ShipAddress1 = payer.PayerAddress1
		Profile.Commerce.ShipAddress2 = payer.PayerAddress2
		Profile.Commerce.ShipCity = payer.PayerCity
		Profile.Commerce.ShipCountry = payer.PayerCountry
		Profile.Commerce.ShipZip = payer.PayerZip
		Profile.Commerce.ShipState = payer.PayerState
		Profile.Save()

	End Sub
	#End Region

	#Region "Helper Functions"
	Private Function CreateOrderObject() As Order
		Dim orderRec As Order = New Order()
		Dim dSubtotal As Double = cart.SubTotal
		Dim dShipping As Double = Double.Parse(ddlShipService.SelectedValue)
		Dim shippingMethod As String = ddlShipService.SelectedItem.Text
		Dim dTax As Double = Double.Parse(txtTaxAmount.Text)

		Dim shipSummary As String = Profile.Commerce.ShipFirst & " " & Profile.Commerce.ShipLast & "<br>" & Profile.Commerce.ShipAddress1 & "<br>" & Profile.Commerce.ShipAddress2 & "<br>" & Profile.Commerce.ShipCity & ", " & Profile.Commerce.ShipState & " " & Profile.Commerce.ShipZip & "<br>" & Profile.Commerce.ShipCountry

		orderRec.UserName = User.Identity.Name
		orderRec.OrderSubTotal = cart.SubTotal
		orderRec.Shipping = dShipping
		orderRec.ShippingAddress = shipSummary
		orderRec.Tax = dTax
		orderRec.ShippingMethod = shippingMethod
		orderRec.PaymentMethod = lblPaymentSummary.Text

		Return orderRec

	End Function

	Private Overloads Function FindControl(ByVal controlID As String, ByVal controls As ControlCollection) As Control
		For Each c As Control In controls
			If c.ID = controlID Then

				Return c
			End If
			If c.HasControls() Then
				Dim cTmp As Control = Me.FindControl(controlID, c.Controls)
				If Not cTmp Is Nothing Then
					Return cTmp
				End If
			End If
		Next c
		Return Nothing
	End Function
	Private Function GetPreviousTextValue(ByVal controlName As String) As String
		Dim sOut As String = ""
		Dim txt As TextBox = CType(FindControl(controlName, PreviousPage.Controls), TextBox)
		If Not txt Is Nothing Then
			sOut = txt.Text
		End If
		Return sOut

	End Function
	Private Function GetPreviousSelectValue(ByVal controlName As String) As String
		Dim sOut As String = ""
		Dim drop As DropDownList = CType(FindControl(controlName, PreviousPage.Controls), DropDownList)
		If Not drop Is Nothing Then
			sOut = drop.SelectedValue
		End If
		Return sOut

	End Function
	Private Sub ShowMessage(ByVal sMessage As String)
		uResult.Visible = True
		uResult.ShowFail(sMessage)
	End Sub
	#End Region

	#Region "Calculators"
	Private Sub SetTax(ByVal sState As String)

		'tax calculation
		'the tax amount is legally set by where the order is 
		'to be shipped, not where the buyer is located
		'when the information is entered for shipping
		'calculate the tax rate and output.

		'please consult a tax advisor or 
		'your legal department for proper
		'application of tax
		Dim dTax As Double = TaxCalculator.GetTaxByState(sState, cart.SubTotal)
		lblTax.Text = dTax.ToString("c")
		txtTaxAmount.Text = dTax.ToString()

	End Sub
	Private Sub SetShipping()
		'shipping calculation
		Dim dShipping As Double = 0
		Try
			dShipping=Convert.ToDouble(ddlShipService.SelectedValue)
		Catch x As Exception

		End Try
		lblShipping.Text = dShipping.ToString("c")
	End Sub
	Private Sub SetTotals()
		'calculate the final total
		Try
			Dim dShipping As Double = Convert.ToDouble(ddlShipService.SelectedValue)
			Dim dTax As Double = Convert.ToDouble(txtTaxAmount.Text)
			Dim dTotal As Double = cart.SubTotal + dTax + dShipping
			lblTotal.Text = dTotal.ToString("c")
		Catch

		End Try

	End Sub

	#End Region

	#Region "Charger"
	Private Function RunCharge() As String
		Dim dSubtotal As Double = cart.SubTotal
		Dim dShipping As Double = Double.Parse(ddlShipService.SelectedValue)
		Dim shippingMethod As String = ddlShipService.SelectedItem.Text
		Dim dTax As Double = 0
		Try
			dTax = Double.Parse(txtTaxAmount.Text)
		Catch

		End Try
		Dim ccType As Commerce.Providers.CreditCardType = Commerce.Providers.CreditCardType.Visa
		Dim sOut As String = ""

		If txtCCType.Text = "MasterCard" Then
			ccType = Commerce.Providers.CreditCardType.MasterCard
		Else If txtCCType.Text = "AMEX" Then
			ccType = Commerce.Providers.CreditCardType.AMEX

		End If

		Try
			sOut=OrdersManager.RunCharge(Profile.First, Profile.Last, Profile.Address1, Profile.Address2, Profile.City, Profile.State, Profile.Zip, Profile.Country, txtCCNumber.Text, Integer.Parse(txtCCExpMonth.Text), Integer.Parse(txtCCExpYear.Text), ccType, txtCCAuthCode.Text, dSubtotal, Math.Round(dTax,2), dShipping, shippingMethod, lblPaymentSummary.Text)
		Catch x As Exception
			ShowMessage(x.Message)
		End Try
		Return sOut
	End Function


	#End Region


	'For use with Express Checkout
	#Region "API Calls"

	Private Function GetOrderItemsArray() As Commerce.PayPal.APIWrapper.OrderItem()
		'loop out the basket items into a an array of 
		'Commerce.OrderItem[]
		Dim item As Commerce.PayPal.APIWrapper.OrderItem

		Dim itemCount As Integer =cart.Items.Rows.Count
		Dim items As Commerce.PayPal.APIWrapper.OrderItem() = New Commerce.PayPal.APIWrapper.OrderItem(itemCount - 1){}

		Dim dr As DataRow
		Dim i As Integer = 0
		Do While i < itemCount
			dr = cart.Items.Rows(i)
			item = New Commerce.PayPal.APIWrapper.OrderItem()
			item.ProductName = dr("ModelName").ToString()
			item.SKU = dr("ModelNumber").ToString()
			item.UnitPrice = CDbl(dr("Price"))
			item.Quantity = CInt(dr("Quantity"))

			'add to the array
			items(i) = item
			i += 1
		Loop
		Return items
	End Function


	Private Function RunExpressCheckout() As String

		Dim items As Commerce.PayPal.APIWrapper.OrderItem() = Me.GetOrderItemsArray()
		Dim transactionID As String = ""
		Try
			'use the wrapper to call PayPal and run the charge
			Dim order As Commerce.PayPal.APIWrapper.OrderInfo = OrdersManager.RunExpressOrder(CreateOrderObject(), txtToken.Text,txtPayerID.Text, items)


			If order.Ack = "Success" Then
				transactionID = order.TransactionID

			Else
				ShowMessage(order.Ack)
			End If
		Catch x As Exception
			ShowMessage(x.Message)
		End Try
		Return transactionID
	End Function
	#End Region


End Class
