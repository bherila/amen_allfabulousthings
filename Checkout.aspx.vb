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
Public Partial Class Checkout : Inherits System.Web.UI.Page
	Private cartSubTotal As Double = 0
	Private Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)

		'this page MUST be protected by SSL!
		Dim thisUrl As String=Request.Url.AbsoluteUri
		'if (!thisUrl.StartsWith("https")) {
			'redirect to a secure URL
			'Response.Redirect(SiteConfiguration.SecureURL + "/checkout.aspx");
		'}

		trContinue.Visible = SiteConfiguration.UseDirectPay
		pnlDirectPay.Visible = SiteConfiguration.UseDirectPay
        tblExpress.Visible = Not SiteConfiguration.UsePayPalPaymentsStandard

		If (Not Page.IsPostBack) Then

			'check the config file to make sure they need to login
			If SiteConfiguration.RequireLogin = "checkout" Then
				'if they are not logged in, then send them to the login page
				If (Not User.Identity.IsAuthenticated) Then
					Response.Redirect("login.aspx?ReturnUrl=checkout.aspx")
				End If
			End If

			'load the profile
			Me.LoadProfile()
			BindOrder()
		End If

	End Sub
	Private Sub BindOrder()

		Dim cart As ShoppingCart = ShoppingCartManager.GetCart()
		cartSubTotal = cart.SubTotal
		dgBasket.DataSource = cart.Items
		dgBasket.DataBind()


	End Sub
	Private Function GetUserEmail() As String
		'get the user's data
		Dim thisUser As MembershipUser = Membership.GetUser(User.Identity.Name)
		Return thisUser.Email

	End Function
	Private Sub LoadProfile()

		txtShipFirst.Text = Profile.Commerce.ShipFirst
		txtShipLast.Text = Profile.Commerce.ShipLast
		txtShipCity.Text = Profile.Commerce.ShipCity
		txtShipZip.Text = Profile.Commerce.ShipZip
		txtShipPhone.Text = Profile.Commerce.ShipPhone
		txtShipAddress2.Text = Profile.Commerce.ShipAddress2
		txtShipAddress.Text = Profile.Commerce.ShipAddress1
		txtShipEmail.Text = GetUserEmail()
		LocationSelector1.LoadDrops(Profile.Commerce.ShipState, Profile.Commerce.ShipCountry)

	End Sub
	Private Sub SetProfile()
		Profile.Commerce.ShipFirst = txtShipFirst.Text
		Profile.Commerce.ShipLast = txtShipLast.Text
		Profile.Commerce.ShipAddress1 = txtShipAddress.Text
		Profile.Commerce.ShipAddress2 = txtShipAddress2.Text
		Profile.Commerce.ShipCity = txtShipCity.Text
		Profile.Commerce.ShipState = LocationSelector1.GetSelectedState()
		Profile.Commerce.ShipCountry = LocationSelector1.GetSelectedCountry()

		Profile.Commerce.ShipPhone = txtShipPhone.Text
		Profile.Commerce.ShipZip = txtShipZip.Text
		Profile.Save()
	End Sub

	Protected Sub imgPayPal_Click(ByVal sender As Object, ByVal e As ImageClickEventArgs)
		SetExpressOrder()
	End Sub
	Private Sub SetExpressOrder()
		'use the API to get the SetCheckout response.
		'Then, redirect to PayPal
		Dim cart As ShoppingCart = ShoppingCartManager.GetCart()

		Dim wrapper As Commerce.PayPal.APIWrapper = New Commerce.PayPal.APIWrapper(SiteConfiguration.PayPalAPIAccountName, SiteConfiguration.PayPalAPIAccountPassword, SiteConfiguration.PayPalAPICertificationPath, SiteConfiguration.PayPalAPICertificationPassword)
		Dim sEmail As String = GetUserEmail()

		Try
			Dim baseURL As String = Request.Url.AbsoluteUri.Replace("checkout.aspx", "")
			Dim successURL As String = baseURL & "checkoutconfirm.aspx"
			Dim cancelURL As String = Request.Url.AbsoluteUri

			Dim ppToken As String = wrapper.SetExpressCheckout(sEmail, cart.SubTotal, successURL, cancelURL)
			Dim sUrl As String = "https://www.paypal.com/cgi-bin/webscr?cmd=_express-checkout&token=" & ppToken
			If SiteConfiguration.UseSandbox Then
				sUrl = "https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_express-checkout&token=" & ppToken
			End If

			Response.Redirect(sUrl)
		Catch x As Exception
			pnlError.Visible = True
			lblError.Text = x.Message
		End Try
	End Sub
	Private Sub ShowMessage(ByVal sMessage As String)
		pnlError.Visible = True
		lblError.Text = sMessage
	End Sub

	Protected Sub btnContinue_Click(ByVal sender As Object, ByVal e As EventArgs)
		'save up the shipping info
		SetProfile()
		Dim nextUrl As String = "billing.aspx"
        If SiteConfiguration.UsePayPalPaymentsStandard Then
            nextUrl = "checkoutconfirm.aspx?st=1"
        End If
		Response.Redirect(nextUrl)
	End Sub
End Class
