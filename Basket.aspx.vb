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

Public Partial Class Basket : Inherits System.Web.UI.Page
	Private cart As ShoppingCart
	Private Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)

		If (Not Page.IsPostBack) Then
			cart = ShoppingCartManager.GetCart()
			BindCart()
		Else
			UpdateQuantities()
		End If

	End Sub
	Private Sub BindCart()
		If cart.ItemCount>0 Then
			dgBasket.DataSource = cart.Items
			dgBasket.DataBind()

		Else
			pnlCheckout.Visible=False

		End If
	End Sub
	Protected Sub UpdateQuantities()
		Dim t As TextBox = Nothing
		Dim sProductID As String=""
		Dim newQuantity As Integer = 0
		Dim productID As Integer=0
		'start with the second row, which is not the header

		Dim i As Integer = 0
		Do While i < dgBasket.Rows.Count
			'get the quantities from the grid
			sProductID = dgBasket.Rows(i).Cells(0).Text
			productID = Integer.Parse(sProductID)
			t = CType(dgBasket.Rows(i).Cells(4).FindControl("txtQuantity"), TextBox)
			newQuantity = Integer.Parse(t.Text)

			If newQuantity = 0 Then
				'remove the item
				ShoppingCartManager.RemoveItem(productID)
			Else
				'update the profile
				ShoppingCartManager.AdjustQuantity(productID, newQuantity)

			End If
			i += 1
		Loop
		'redirect to current page to refresh the basket
		'and disable refresh problem
		Response.Redirect("Basket.aspx")
	End Sub
	Protected Sub Remove_Item(ByVal sender As Object, ByVal e As GridViewDeleteEventArgs)
		'the productID is the first column, get the value and delete the item
		'from the basket
		Dim sProductID As String = dgBasket.Rows(e.RowIndex).Cells(0).Text
		Dim productID As Integer = Integer.Parse(sProductID)
		ShoppingCartManager.RemoveItem(productID)

		'redirect to current page to refresh the basket
		'and disable refresh problem
		Response.Redirect("basket.aspx")
	End Sub


	Protected Sub DoCommand(ByVal sender As Object, ByVal e As GridViewCommandEventArgs)
	End Sub
	Protected Sub dgBasket_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs)

	End Sub
End Class
