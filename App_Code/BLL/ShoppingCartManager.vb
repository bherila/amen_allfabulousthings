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
Imports System.Text
Imports System.IO
Imports Commerce.Providers

''' <summary>
''' The controller for the shopping cart
''' </summary>
Public Class ShoppingCartManager

	''' <summary>
	''' Returns the users name or a GUID, depending if they are logged in.
	''' </summary>
	''' <returns></returns>
	Private Shared Function GetUserName() As String

		Dim sUserName As String = ""
		If HttpContext.Current.User.Identity.IsAuthenticated Then
			sUserName = HttpContext.Current.User.Identity.Name
		Else

			'we'll tag them with an anon userName until they register
			If Not HttpContext.Current.Request.Cookies("shopperID") Is Nothing Then
				sUserName = HttpContext.Current.Request.Cookies("shopperID").Value
			Else

				'if we have never seen them, tag them with a cookie so we can track 
				'their basket.
				sUserName = System.Guid.NewGuid().ToString()
				HttpContext.Current.Response.Cookies("shopperID").Value = sUserName
				HttpContext.Current.Response.Cookies("shopperID").Expires = DateTime.Today.AddDays(365)
			End If
		End If
		Return sUserName
	End Function

	''' <summary>
	''' Adds an item to the cart
	''' </summary>
	''' <param name="productID"></param>
	''' <param name="itemName"></param>
	''' <param name="itemNumber"></param>
	''' <param name="price"></param>
	''' <param name="quantity"></param>
	Public Shared Sub AddItem(ByVal productID As Integer, ByVal quantity As Integer, ByVal modelName As String, ByVal modelNumber As String, ByVal description As String, ByVal price As Double, ByVal sku As String, ByVal weight As Double)

		Dim userName As String = GetUserName()
		Dim productIsActive As Boolean = CatalogManager.IsActive(productID)
		If (Not productIsActive) Then
			Throw New Exception("This product is no longer active")
		Else
			ShoppingCartProvider.Instance.CartAddItem(userName, productID, quantity, modelName, modelNumber, description, price, sku,weight)
		End If
	End Sub

	''' <summary>
	''' Removes an item from the cart
	''' </summary>
	''' <param name="ItemNumber"></param>
	Public Shared Sub RemoveItem(ByVal productID As Integer)

		ShoppingCartProvider.Instance.CartAdjustQuantity(GetUserName(), productID, 0)
	End Sub

	''' <summary>
	''' Adjusts the quantity of an item in the cart to the new quantity
	''' </summary>
	''' <param name="ItemNumber"></param>
	''' <param name="newQuantity"></param>
	Public Shared Sub AdjustQuantity(ByVal productID As Integer, ByVal newQuantity As Integer)

		ShoppingCartProvider.Instance.CartAdjustQuantity(GetUserName(), productID, newQuantity)
	End Sub


	''' <summary>
	''' Loads a simple cart object and it's items
	''' </summary>
	''' <returns></returns>
	Public Shared Function GetCart() As ShoppingCart
        Return New ShoppingCart() 'TODO: Uncomment



        Dim rdr As IDataReader = ShoppingCartProvider.Instance.CartGetCurrentCart(GetUserName())
		Dim cart As ShoppingCart = New ShoppingCart()
		cart.Load(rdr)

		'the items are the next bits
		If rdr.NextResult() Then
			cart.Items = New ShoppingCartItems()
			Dim dr As DataRow
			Dim counter As Integer = 0
			Do While rdr.Read()
				dr = cart.Items.NewRow()
				dr("productID") = CInt(rdr("productID"))
				dr("ModelName") = rdr("ModelName").ToString()
				dr("ModelNumber") = rdr("ModelNumber").ToString()
				dr("Price") = Convert.ToDouble(rdr("price").ToString())
				dr("LineTotal") = Convert.ToDouble(rdr("lineTotal").ToString())
				dr("Quantity") = CInt(rdr("quantity"))
				cart.Items.Rows.Add(dr)
			Loop
		End If

		rdr.Close()
		Return cart
	End Function

	Public Shared Function GetCartItems() As IDataReader
		Return ShoppingCartProvider.Instance.CartGetCartItems(GetUserName())
	End Function

	''' <summary>
	''' Transfers a cart from one user to another. This is used mainly with anonymous shopping,
	''' where an anonymous user logs in and doesn't want to lose their cart.
	''' </summary>
	''' <param name="fromUserName"></param>
	''' <param name="toUserName"></param>
	Public Shared Sub Transfer(ByVal fromUserName As String, ByVal toUserName As String)
		ShoppingCartProvider.Instance.CartTransfer(fromUserName,toUserName)
	End Sub

	Public Shared Sub UpdateCartPrices(ByVal productID As Integer, ByVal newPrice As Double)
		ShoppingCartProvider.Instance.UpdatePrices(productID, newPrice)
	End Sub
	Public Shared Sub RemoveAllProducts(ByVal productID As Integer)
		ShoppingCartProvider.Instance.RemoveProducts(productID)
	End Sub
	Public Shared Sub UpdateCartProducts(ByVal productID As Integer, ByVal newPrice As Double, ByVal newWeight As Double, ByVal newName As String, ByVal newNumber As String, ByVal newSKU As String)
		ShoppingCartProvider.Instance.UpdateProducts(productID, newPrice, newWeight, newName, newNumber, newSKU)
	End Sub
End Class
