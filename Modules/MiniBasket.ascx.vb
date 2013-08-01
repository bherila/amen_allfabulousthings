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

Public Partial Class MiniBasket : Inherits System.Web.UI.UserControl
	Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)

		Dim cart As ShoppingCart = ShoppingCartManager.GetCart()
		If cart.ItemCount>0 Then
			Dim basketTotal As Double = cart.SubTotal
			lblTotal.Text = basketTotal.ToString("c")


			dlBasket.DataSource = cart.Items
			dlBasket.DataBind()
		Else
			pnlCart.Visible = False
		End If


	End Sub

End Class
