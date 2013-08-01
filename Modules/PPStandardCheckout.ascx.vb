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
Imports System.Text

Public Partial Class Modules_PPStandardCheckout : Inherits System.Web.UI.UserControl
    Public ShippingMethod As String = ""
    Public ShippingAmount As Double = 0
    Public TaxAmount As Double = 0
    Public Subtotal As Double = 0



    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)

    End Sub

    Private Function InitOrder() As Integer
        Dim shipSummary As String = Profile.Commerce.ShipFirst & " " & Profile.Commerce.ShipLast & "<br>" & Profile.Commerce.ShipAddress1 & "<br>" & Profile.Commerce.ShipAddress2 & "<br>" & Profile.Commerce.ShipCity & ", " & Profile.Commerce.ShipState & " " & Profile.Commerce.ShipZip & "<br>" & Profile.Commerce.ShipCountry

        Return OrdersManager.InitializeOrder(Page.User.Identity.Name, shipSummary, ShippingMethod, Subtotal, ShippingAmount, TaxAmount, Profile.Commerce.ShipZip, "PayPal Payments Standard")

    End Function

    Protected Sub btnContinue_Click(ByVal sender As Object, ByVal e As EventArgs)

        Dim orderID As Integer = InitOrder()
        Dim sUrl As String = PayPalHelper.GetUploadCartUrl(TaxAmount, Subtotal, ShippingAmount)
        Response.Redirect(sUrl & "&custom=" & orderID.ToString())

    End Sub
End Class
