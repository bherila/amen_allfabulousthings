Imports Microsoft.VisualBasic
Imports System
Imports System.Data
Imports System.Data.Odbc
Imports System.Configuration
Imports System.Collections
Imports System.Web
Imports System.Web.Security
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Web.UI.WebControls.WebParts
Imports System.Web.UI.HtmlControls
Imports System.Data.SqlClient

Public Partial Class ProductPage : Inherits System.Web.UI.Page
	Private productID As Integer=0
	Private Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
		If Not Request.QueryString("id") Is Nothing Then
				productID = Integer.Parse(Request.QueryString("id").ToString())
		End If

		If (Not IsPostBack) AndAlso productID<>0 Then
            LoadProductInfo(productID)

            'Dim cn As OdbcConnection = DB.GetConnection()
            'Dim cmd As New OdbcCommand()
            'cmd.Connection = cn
            'cmd.CommandText = "select ID, concat(LastName, ', ', FirstName) FullName from amen_users order by LastName asc"
            'Dim dr As OdbcDataReader = cmd.ExecuteReader()
            'dlRegistryUsers.Items.Clear()
            'While dr.Read
            '    Dim li As New ListItem(dr(1).ToString(), dr(0).ToString())
            '    dlRegistryUsers.Items.Add(li)
            'End While
            'dr.Close()
            'cmd.Dispose()
            'cn.Close()
            'cn.Dispose()


        End If

	End Sub
	Private Sub LoadProductInfo(ByVal productID As Integer)
        Dim product As Product = New Product()
        product.Load(CatalogManager.GetProduct(productID))

        If product.IsLoaded AndAlso product.IsActive Then
            'log the view
            Log.Write("Viewing Product", "Browsing", "Viewing " & product.ModelName, productID.ToString(), User.Identity.Name)
            lblModelName.Text = product.ModelName
            lblModelNumber.Text = product.ModelNumber
            lblDescription.Text = product.Description
            If (product.UnitCost > 1) Then
                lblDescription.Text &= "</form><br><br><hr height='1'><table border='0' cellpadding='6' cellspacing='0'><tr><td align='right' width='33%'>" _
                                & "<form target=""paypal"" action=""https://www.paypal.com/cgi-bin/webscr"" method=""post"">" _
                                & "<input type=""image"" src=""https://www.paypal.com//en_US/i/btn/x-click-but10.gif"" border=""0"" name=""submit"" alt=""Make payments with PayPal - it's fast, free and secure!"">" _
                                & "<img alt="""" border=""0"" src=""https://www.paypal.com/en_US/i/scr/pixel.gif"" width=""1"" height=""1"">" _
                                & "<input type=""hidden"" name=""add"" value=""1"">" _
                                & "<input type=""hidden"" name=""cmd"" value=""_cart"">" _
                                & "<input type=""hidden"" name=""business"" value=""lyn@allfabulousthings.com"">" _
                                & "<input type=""hidden"" name=""item_name"" value=""" & product.ModelName & """>" _
                                & "<input type=""hidden"" name=""item_number"" value=""" & product.ModelNumber & "/" & product.SKU & """>" _
                                & "<input type=""hidden"" name=""amount"" value=""" & product.UnitCost & """>" _
                                & "<input type=""hidden"" name=""no_shipping"" value=""2"">" _
                                & "<input type=""hidden"" name=""return"" value=""http://www.allfabulousthings.com"">" _
                                & "<input type=""hidden"" name=""cancel_return"" value=""http://www.allfabulousthings.com"">" _
                                & "<input type=""hidden"" name=""currency_code"" value=""USD"">" _
                                & "<input type=""hidden"" name=""bn"" value=""PP-ShopCartBF"">" _
                                & "</form>" _
                                & "</td><td align='center' width='34%'>" _
                                & "<form action=""https://www.paypal.com/cgi-bin/webscr"" method=""post"">" _
                                & "<input type=""hidden"" name=""cmd"" value=""_xclick"">" _
                                & "<input type=""hidden"" name=""business"" value=""lyn@allfabulousthings.com"">" _
                                & "<input type=""hidden"" name=""undefined_quantity"" value=""1"">" _
                                & "<input type=""hidden"" name=""item_name"" value=""" & product.ModelName & """>" _
                                & "<input type=""hidden"" name=""item_number"" value=""" & product.ModelNumber & "/" & product.SKU & """>" _
                                & "<input type=""hidden"" name=""amount"" value=""" & product.UnitCost & """>" _
                                & "<input type=""hidden"" name=""no_shipping"" value=""2"">" _
                                & "<input type=""hidden"" name=""return"" value=""http://www.allfabulousthings.com"">" _
                                & "<input type=""hidden"" name=""cancel_return"" value=""http://www.allfabulousthings.com"">" _
                                & "<input type=""hidden"" name=""currency_code"" value=""USD"">" _
                                & "<input type=""hidden"" name=""bn"" value=""PP-BuyNowBF"">" _
                                & "<input type=""image"" src=""https://www.paypal.com/en_US/i/btn/x-click-but9.gif"" border=""0"" name=""submit"" alt=""Make payments with PayPal - it's fast, free and secure!"">" _
                                & "<img alt="""" border=""0"" src=""https://www.paypal.com/en_US/i/scr/pixel.gif"" width=""1"" height=""1"">" _
                                & "</form>" _
                                & "</td><td align='left' width='33%'>" _
                                & "<form target=""paypal"" action=""https://www.paypal.com/cgi-bin/webscr"" method=""post"">" _
                                & "<input type=""hidden"" name=""cmd"" value=""_cart"">" _
                                & "<input type=""hidden"" name=""business"" value=""lyn@allfabulousthings.com"">" _
                                & "<input type=""image"" src=""https://www.paypal.com/en_US/i/btn/view_cart_03.gif"" border=""0"" name=""submit"" alt=""Make payments with PayPal - it's fast, free and secure!"">" _
                                & "<input type=""hidden"" name=""display"" value=""1"">" _
                                & "</form></td></tr></table>"
            End If
            lblWeight.Text = product.Weight.ToString()
            imgProduct.ImageUrl = "images/productimages/" & product.ProductImage

            lblUnitCost.Text = product.UnitCost.ToString("c")
            'if the product is discounted, calc out the new price
            Dim dPrice As Double = product.UnitCost
            lblPrice.Text = dPrice.ToString()
            If product.DiscountPercent > 0 Then
                dPrice = CatalogManager.GetDiscountedPrice(product.UnitCost, product.DiscountPercent)
                lblDiscountPrice.Visible = True
                lblDiscountPrice.Text = dPrice.ToString("C")
                lblDPrice.Text = dPrice.ToString()
                lblUnitCost.Font.Strikeout = True
                lblUnitCost.Text &= "<br>"
            Else

            End If

            Page.Title = "Product Detail: " & product.ModelName

            If product.AmountOnHand <= 0 Then
                lnkAddToCart.Visible = SiteConfiguration.ShowZeroInventoryItems
                lblOutOfStock.Visible = Not SiteConfiguration.ShowZeroInventoryItems
            End If

        Else
            lblModelName.Text = "Invalid Product"
            imgProduct.Visible = False
            lnkAddToCart.Visible = False
        End If

    End Sub
	Protected Sub lnkAddToCart_Click(ByVal sender As Object, ByVal e As EventArgs)
		Log.Write("Adding To Cart", "Browsing", "Adding " & lblModelName.Text, productID.ToString(), User.Identity.Name)
		AddItemToCart()
	End Sub
	Protected Sub AddItemToCart()
		Dim dPrice As Double=0

		'find out if we're dealing with a discounted item
		'if the discount label is active, this is the case
		If lblDiscountPrice.Visible Then
			dPrice = Convert.ToDouble(lblDPrice.Text)
		Else
			dPrice = Convert.ToDouble(lblPrice.Text)
		End If

		ShoppingCartManager.AddItem(productID, 1, lblModelName.Text, lblModelNumber.Text, lblDescription.Text, dPrice, lblModelNumber.Text, Convert.ToDouble(lblWeight.Text))

		'redirect the page to refresh the counts
		'and disable the refresher from adding more items 
		'to the cart
		'this will also allow the summary basket to load
		Response.Redirect(Request.Url.PathAndQuery)

	End Sub

    'Protected Sub btnAddToRegistry_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAddToRegistry.Click
    '    Dim cn As OdbcConnection = DB.GetConnection()
    '    Dim cmd As New OdbcCommand()
    '    cmd.Connection = cn
    '    cmd.CommandText = _
    '        String.Format("insert into amen_items (UserID, Item, ItemURL, Complete) values ('{0}', '{1}', '{2}', 0)", _
    '        DB.Prime(dlRegistryUsers.SelectedValue), DB.Prime(lblModelName.Text), DB.Prime(Request.RawUrl))
    '    cmd.ExecuteNonQuery()
    '    cmd.Dispose()
    '    cn.Close()
    '    cn.Dispose()
    '    Response.Redirect("RegistryUser.aspx?id=" & dlRegistryUsers.SelectedValue, True)
    'End Sub
End Class
