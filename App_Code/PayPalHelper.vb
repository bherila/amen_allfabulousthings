Imports System
Imports System.Data
Imports System.Configuration
Imports System.Web
Imports System.Web.Security
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Web.UI.WebControls.WebParts
Imports System.Web.UI.HtmlControls
Imports System.Text
''' <summary>
''' Summary description for PayPalHelper
''' </summary>
Public Class PayPalHelper
    ''' <summary>
    ''' Creates a link for a BuyNow button
    ''' </summary>
    ''' <param name="itemName"></param>
    ''' <param name="itemNumber"></param>
    ''' <param name="price"></param>
    ''' <param name="tax"></param>
    ''' <param name="shipping"></param>
    ''' <param name="userName"></param>
    ''' <returns></returns>
    Public Shared Function GetBuyNowButton(ByVal itemName As String, ByVal itemNumber As String, ByVal price As Double, ByVal tax As Double, ByVal shipping As Double, ByVal userName As String) As String
        Dim url As StringBuilder = New StringBuilder()
        Dim serverURL As String = "https://www.sandbox.paypal.com/us/cgi-bin/webscr"
        If (Not SiteConfiguration.UseSandbox) Then
            serverURL = "https://www.paypal.com/us/cgi-bin/webscr"
        End If
        url.Append(serverURL & "?cmd=_xclick&currency_code=" & SiteConfiguration.CurrencyCode & "&business=" & HttpUtility.UrlEncode(SiteConfiguration.BusinessEmail))
        url.Append("&amount=" & price.ToString().Replace(",", "."))


        If tax > 0 Then
            url.AppendFormat("&tax=" & tax.ToString().Replace(",", "."))
        End If

        If shipping > 0 Then
            url.AppendFormat("&shipping=" & shipping.ToString().Replace(",", "."))
        End If

        url.AppendFormat("&item_name={0}", HttpUtility.UrlEncode(itemName))
        url.AppendFormat("&item_number={0}", HttpUtility.UrlEncode(itemNumber))
        url.AppendFormat("&custom={0}", HttpUtility.UrlEncode(userName))

        Return "<a href='" & url.ToString() & "' target=_blank><img src='http://www.paypal.com/en_US/i/btn/x-click-but01.gif' border='0' alt='Make payments with PayPal - it's fast, free and secure!'></a>"

    End Function
    ''' <summary>
    ''' Creates the URL to send to PayPal so that a user can check out using PaymentsStandard
    ''' </summary>
    ''' <param name="TaxAmount"></param>
    ''' <param name="Subtotal"></param>
    ''' <param name="ShippingAmount"></param>
    ''' <returns></returns>
    Public Shared Function GetUploadCartUrl(ByVal TaxAmount As Double, ByVal Subtotal As Double, ByVal ShippingAmount As Double) As String
        Dim cart As ShoppingCart = ShoppingCartManager.GetCart()
        'cart.Items.Load(ShoppingCartManager.GetCartItems());
        Dim total As Double = TaxAmount + Subtotal + ShippingAmount

        Dim url As StringBuilder = New StringBuilder()
        Dim serverURL As String = "https://www.sandbox.paypal.com/us/cgi-bin/webscr"
        If (Not SiteConfiguration.UseSandbox) Then
            serverURL = "https://www.paypal.com/us/cgi-bin/webscr"
        End If
        url.Append(serverURL & "?cmd=_cart&upload=1&currency_code=" & SiteConfiguration.CurrencyCode & "&business=" & HttpUtility.UrlEncode(SiteConfiguration.BusinessEmail))



        If total > 0 Then
            url.Append("&amount=" & total.ToString().Replace(",", "."))
        End If


        If TaxAmount > 0 Then
            url.AppendFormat("&tax_1=" & TaxAmount.ToString().Replace(",", "."))
        End If

        If ShippingAmount > 0 Then
            url.AppendFormat("&shipping_1=" & ShippingAmount.ToString().Replace(",", "."))
        End If

        'add the items
        Dim sItemNum As String = ""
        Dim i As Integer = 0
        Do While i < cart.Items.Rows.Count
            Dim index As Integer = i + 1
            sItemNum = index.ToString()

            url.AppendFormat("&item_name_" & sItemNum & "={0}", HttpUtility.UrlEncode(cart.Items.Rows(i)("ModelName").ToString()))
            url.AppendFormat("&item_number_" & sItemNum & "={0}", HttpUtility.UrlEncode(cart.Items.Rows(i)("ModelNumber").ToString()))
            url.AppendFormat("&amount_" & sItemNum & "={0}", HttpUtility.UrlEncode(cart.Items.Rows(i)("linetotal").ToString().Replace(",", ".")))

            i += 1
        Loop

        Dim SuccessUrl As String = Utility.GetSiteRoot() & "/PayPal/PDTHandler.aspx"
        Dim CancelUrl As String = Utility.GetSiteRoot() & "/Checkout.aspx"

        If Not SuccessUrl Is Nothing AndAlso SuccessUrl <> "" Then
            url.AppendFormat("&return={0}", HttpUtility.UrlEncode(SuccessUrl))
        End If
        If Not CancelUrl Is Nothing AndAlso CancelUrl <> "" Then
            url.AppendFormat("&cancel_return={0}", HttpUtility.UrlEncode(CancelUrl))
        End If
        Return url.ToString()

    End Function
End Class

