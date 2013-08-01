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

Public Partial Class admin_products : Inherits System.Web.UI.Page
	Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
		pnlEdit.Visible = False
		pnlGrid.Visible = True
		If (Not Page.IsPostBack) Then
			If Not Request.QueryString("p") Is Nothing Then
				'load the drop down
				LoadCategoryDrop()

				Dim productID As String = Request.QueryString("p").ToString()
				If productID <> "0" Then
					LoadEditor(Integer.Parse(productID))

				Else
					LoadAddForm()
				End If


			Else
				LoadProductList()
			End If
		End If
	End Sub
	Private Sub ToggleGrid(ByVal showGrid As Boolean)
		'toggle the panels
		pnlEdit.Visible = Not showGrid
		pnlGrid.Visible = showGrid
	End Sub
	Private Sub LoadAddForm()
		ToggleGrid(False)
		tblInventory.Visible = False
		btnSave.Text = "Add"
		trID.Visible = False
		trAmountOnHand.Visible = False
		chkIsActive.Checked = True
		btnPerm.Visible = False
	End Sub
	Private Sub LoadEditor(ByVal productID As Integer)

		ToggleGrid(False)
		btnPerm.Attributes.Add("onclick", "CheckDelete()")
		'load the product reader
		Dim product As Product = New Product()
		product.Load(CatalogManager.GetProduct(productID))

		'load up the form
		ddlCategoryID.SelectedValue = product.CategoryID.ToString()
		txtModelName.Text = product.ModelName
		txtModelNumber.Text = product.ModelNumber
		txtSKU.Text = product.SKU
		txtProductImage.Text = product.ProductImage
		imgProductImage.ImageUrl = "../images/ProductImages/" & product.ProductImage
		txtDescription.Text = product.Description
		txtUnitCost.Text = product.UnitCost.ToString()
		lblID.Text = product.ProductID.ToString()
		chkIsActive.Checked = product.IsActive
		txtWeight.Text = product.Weight.ToString()
		txtDiscount.Text = product.DiscountPercent.ToString()
		lblAmountOnHand.Text = product.AmountOnHand.ToString()

		If product.AmountOnHand <= 0 Then
			tdAmountOnHand.BgColor = "#990000"
			lblAmountOnHand.ForeColor = System.Drawing.Color.FromName("white")
		Else If product.AmountOnHand <= 5 Then
			tdAmountOnHand.BgColor = "ffffcc"
			lblAmountOnHand.ForeColor = System.Drawing.Color.FromName("#990000")
		Else
			tdAmountOnHand.BgColor = "white"

		End If

		'load the history
		LoadInventoryHistory(product.ProductID)
	End Sub
	Private Sub LoadProductList()
		dgProducts.DataSource = CatalogManager.GetProducts()
		dgProducts.DataBind()
	End Sub
	Private Sub LoadInventoryHistory(ByVal productID As Integer)
		dgInventory.DataSource = CatalogManager.GetInventoryHistory(productID)
		dgInventory.DataBind()
	End Sub
	Private Sub LoadCategoryDrop()
		ddlCategoryID.DataSource = CatalogManager.GetCategories()
		ddlCategoryID.DataTextField = "CategoryName"
		ddlCategoryID.DataValueField = "CategoryID"
		ddlCategoryID.DataBind()
	End Sub

	Protected Sub btnAdjustInventory_Click(ByVal sender As Object, ByVal e As EventArgs)
		Dim adjustment As Integer = Integer.Parse(txtAmountOnHand.Text)
		CatalogManager.AdjustInventory(Integer.Parse(lblID.Text), -adjustment, "Administrative adjustment by " & User.Identity.Name & " on " & DateTime.Now.ToString())
		'redirect to avoid the refresh problem
		Response.Redirect("admin_products.aspx?p=" & lblID.Text)
	End Sub
	Protected Sub OnHandCheck(ByVal sender As Object, ByVal e As EventArgs)

	End Sub
	Protected Sub InventoryCheck(ByVal sender As Object, ByVal e As GridViewRowEventArgs)
		Dim sAmount As String=e.Row.Cells(5).Text
		Try
			Dim amountOnHand As Integer = Convert.ToInt32(sAmount)

			If amountOnHand <= 0 Then
				e.Row.Cells(5).BackColor = System.Drawing.Color.FromName("#990000")
				e.Row.Cells(5).ForeColor = System.Drawing.Color.FromName("white")
			Else If amountOnHand <= 5 Then
				e.Row.Cells(5).BackColor = System.Drawing.Color.FromName("#ffffcc")

			End If
		Catch

		End Try
	End Sub
	Protected Sub btnDelete_Click(ByVal sender As Object, ByVal e As EventArgs)
		CatalogManager.InactivateProduct(Integer.Parse(lblID.Text))
		Response.Redirect("admin_products.aspx")

	End Sub
	Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As EventArgs)

		Dim product As Product = New Product()
		product.CategoryID = Integer.Parse(ddlCategoryID.SelectedValue)
		product.ModelNumber = txtModelNumber.Text
		product.ModelName = txtModelName.Text
		product.ProductImage = txtProductImage.Text
		product.UnitCost = Double.Parse(txtUnitCost.Text)
		product.Description = txtDescription.Text
		product.AmountOnHand = 0
		product.SKU = txtSKU.Text
		product.IsActive = chkIsActive.Checked
		product.Weight = Convert.ToDouble(txtWeight.Text)
		product.DiscountPercent = Integer.Parse(txtDiscount.Text)

		Dim haveError As Boolean = False
		Dim newID As Integer = 0
		If lblID.Text <> "" Then
			product.ProductID = Integer.Parse(lblID.Text)
			'it's an edit
			ToggleGrid(False)
			uResult.Visible = True
		   Try
			   CatalogManager.UpdateProduct(product)
			   'load it up again
			   LoadEditor(product.ProductID)
			   uResult.ShowSuccess("Product Updated")
			Catch x As Exception
				haveError = True
				uResult.ShowFail("Update Failed: " & x.Message)
			End Try

		Else
			'it's an insert
			Try
				newID = CatalogManager.AddProduct(product)
			Catch x As Exception
				haveError = True
				uResult.Visible = True
				uResult.ShowFail("Add Failed: " & x.Message)
			End Try
			If (Not haveError) Then
				Response.Redirect("admin_products.aspx?p=" & newID.ToString())
			End If

		End If



	End Sub
	Protected Sub btnPerm_Click(ByVal sender As Object, ByVal e As EventArgs)
		uResult.Visible = True
		ToggleGrid(False)
	   Try
		   CatalogManager.PermanentDelete(Integer.Parse(lblID.Text))
			uResult.ShowSuccess("Product Permanently Deleted")
			tblInventory.Visible = False
			btnSave.Enabled = False
			btnPerm.Enabled = False
		Catch x As Exception
			uResult.ShowFail("Cannot delete this product - there are orders associated with it")
		End Try

	End Sub
End Class
