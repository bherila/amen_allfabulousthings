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

Public Partial Class Billing : Inherits System.Web.UI.Page
	Private cartSubTotal As Double = 0
	Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)

		'this page MUST be protected by SSL!
		pnlBillInfo.Visible = radPayType.SelectedIndex = 0
		trPlaceOrder.Visible = radPayType.SelectedIndex = 0
		If (Not Page.IsPostBack) Then
			'as a convenience
			LoadExpirationYear()
			LoadProfile()
			BindOrder()

		End If
	End Sub
	Private Sub BindOrder()

		Dim cart As ShoppingCart = ShoppingCartManager.GetCart()
		cartSubTotal = cart.SubTotal
		dgBasket.DataSource = cart.Items
		dgBasket.DataBind()

	End Sub
	Private Sub LoadExpirationYear()
		Dim i As Integer = DateTime.Now.Year
		Do While i < DateTime.Now.Year + 6
			ddlExpYear.Items.Add(New ListItem(i.ToString(), i.ToString()))
			i += 1
		Loop
	End Sub
	Private Function GetUserEmail() As String
		'get the user's data
		Dim thisUser As MembershipUser = Membership.GetUser(User.Identity.Name)
		Return thisUser.Email

	End Function
	Private Sub LoadProfile()
		'if the profile has been set, 
		'use that
		Dim sState As String = ""
		Dim sCountry As String = ""
		If Profile.First <> String.Empty Then
			txtBillFirst.Text = Profile.First
			txtBillLast.Text = Profile.Last
			txtBillCity.Text = Profile.City
			txtBillZip.Text = Profile.Zip
			txtBillAddress2.Text = Profile.Address2
			txtBillAddress.Text = Profile.Address1
			sState = Profile.State
			sCountry = Profile.Country
		Else
			'assume it's the same as shipping
			txtBillFirst.Text = Profile.Commerce.ShipFirst
			txtBillLast.Text = Profile.Commerce.ShipLast
			txtBillCity.Text = Profile.Commerce.ShipCity
			txtBillZip.Text = Profile.Commerce.ShipZip
			txtBillAddress2.Text = Profile.Commerce.ShipAddress2
			txtBillAddress.Text = Profile.Commerce.ShipAddress1
			sState = Profile.Commerce.ShipState
			sCountry = Profile.Commerce.ShipCountry

		End If
		LocationSelector1.LoadDrops(sState, sCountry)
	End Sub
	Private Sub SetProfile()
		Profile.First = txtBillFirst.Text
		Profile.Last = txtBillLast.Text
		Profile.City = txtBillCity.Text
		Profile.Zip = txtBillZip.Text
		Profile.Address1 = txtBillAddress.Text
		Profile.Address2 = txtBillAddress2.Text
		Profile.State = LocationSelector1.GetSelectedState()
		Profile.Country = LocationSelector1.GetSelectedCountry()
		Profile.Save()

	End Sub

	Protected Sub btnPayPal_Click(ByVal sender As Object, ByVal e As EventArgs)
		SetExpressOrder()
	End Sub
	Private Sub SetExpressOrder()
		'use the API to get the SetCheckout response.
		'Then, redirect to PayPal
		Dim wrapper As Commerce.PayPal.APIWrapper = New Commerce.PayPal.APIWrapper(SiteConfiguration.PayPalAPIAccountName, SiteConfiguration.PayPalAPIAccountPassword, SiteConfiguration.PayPalAPICertificationPath, SiteConfiguration.PayPalAPICertificationPassword)
		Dim sEmail As String = GetUserEmail()
		Dim cart As ShoppingCart = ShoppingCartManager.GetCart()

		Try
			Dim successURL As String = Utility.GetSiteRoot() & "/checkoutconfirm.aspx"
			Dim cancelURL As String = Utility.GetSiteRoot() & "/checkout.aspx"

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
End Class
