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
''' Summary description for CatalogManager
''' </summary>
Public Class CatalogManager

	''' <summary>
	''' Gets all the products in the database
	''' </summary>
	''' <returns>Reader</returns>
	Private Sub New()
	End Sub
	Public Shared Function GetProducts() As IDataReader
	   'return Commerce.Providers.
		'Commerce.Providers.CatalogProvider.g
		Return Commerce.Providers.CatalogProvider.Instance.GetProducts()
	End Function

	''' <summary>
	''' Gets products by product category
	''' </summary>
	''' <param name="categoryID"></param>
	''' <returns>Reader</returns>
	Public Shared Function GetProductsByCategory(ByVal categoryID As Integer) As IDataReader
		Return Commerce.Providers.CatalogProvider.Instance.GetProductsByCategory(categoryID)
	End Function

	Public Shared Function IsActive(ByVal productID As Integer) As Boolean
		Return CatalogProvider.Instance.ProductIsActive(productID)
	End Function

	''' <summary>
	''' Gets a specific product
	''' </summary>
	''' <param name="productID"></param>
	''' <returns></returns>
	Public Shared Function GetProduct(ByVal productID As Integer) As IDataReader
		Return Commerce.Providers.CatalogProvider.Instance.GetProduct(productID)

	End Function

	''' <summary>
	''' Gets product information and fills a dataset
	''' </summary>
	''' <param name="productID"></param>
	''' <param name="ds">The dataset to fill</param>
	Public Shared Sub FillProductDataSet(ByVal productID As Integer, ByVal ds As DataSet)
		Commerce.Providers.CatalogProvider.Instance.FillProductDataSet(productID, ds)
	End Sub

	''' <summary>
	''' Gets all category records in the database
	''' </summary>
	''' <returns>Reader</returns>
	Public Shared Function GetCategories() As IDataReader
		Return Commerce.Providers.CatalogProvider.Instance.GetCategories()
	End Function

	''' <summary>
	''' Debits the inventory by the supplied amount. Note that if you enter "5", 5 will be deducted from AmountOnHand
	''' </summary>
	''' <param name="productID"></param>
	''' <param name="adjustment">The amount to debit</param>
	''' <param name="comment"></param>
	Public Shared Sub AdjustInventory(ByVal productID As Integer, ByVal adjustment As Integer, ByVal comment As String)
		Commerce.Providers.CatalogProvider.Instance.ProductsAdjustInventory(productID, adjustment, comment)
	End Sub
	Public Shared Function GetInventoryHistory(ByVal productID As Integer) As IDataReader
		Return Commerce.Providers.CatalogProvider.Instance.ProductsInventoryHistory(productID)
	End Function
	Public Shared Sub InactivateProduct(ByVal productID As Integer)
		Commerce.Providers.CatalogProvider.Instance.ProductInactivate(productID)

		'remove the products from open baskets
		ShoppingCartManager.RemoveAllProducts(productID)
	End Sub
	Public Shared Function AddProduct(ByVal product As Product) As Integer
		Return Commerce.Providers.CatalogProvider.Instance.ProductInsert(product.CategoryID, product.ModelNumber, product.ModelName, product.ProductImage, product.UnitCost, product.Description, product.AmountOnHand, product.SKU,product.Weight)
	End Function
	Public Shared Function GetDiscountedPrice(ByVal originalPrice As Double, ByVal discountPercent As Integer) As Double
		Dim dOut As Double = 0
		Dim discount As Double = 0
		If discountPercent > 0 Then
			discount = Convert.ToDouble(discountPercent) / 100
		End If
		Dim discountAmount As Double = originalPrice * discount
		Return originalPrice - discountAmount

	End Function
	Public Shared Sub UpdateProduct(ByVal product As Product)
		Commerce.Providers.CatalogProvider.Instance.ProductUpdate(product.ProductID,product.CategoryID, product.ModelNumber, product.ModelName, product.ProductImage, product.UnitCost, product.Description, product.SKU,product.IsActive,product.Weight,product.DiscountPercent)

		'apply any newly added discounts
		'this will carry through to the basket updates
		If product.DiscountPercent > 0 Then
			product.UnitCost = GetDiscountedPrice(product.UnitCost,product.DiscountPercent)
		End If


		'update any items currently in the shopping carts (active carts only)
		ShoppingCartManager.UpdateCartProducts(product.ProductID, product.UnitCost, product.Weight, product.ModelName, product.ModelNumber,product.SKU)

		'if this product has been inactivated, don't allow 
		'anyone to buy it.
		If (Not product.IsActive) Then
			ShoppingCartManager.RemoveAllProducts(product.ProductID)
		End If
	End Sub
	Public Shared Sub PermanentDelete(ByVal productID As Integer)
		CatalogProvider.Instance.ProductDeletePermanent(productID)

		'remove them from the carts
		ShoppingCartManager.RemoveAllProducts(productID)

	End Sub

	Public Shared Function Search(ByVal query As String) As IDataReader
		Return CatalogProvider.Instance.ProductsSearch(query)
	End Function
End Class
