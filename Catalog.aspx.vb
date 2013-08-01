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

Public Partial Class Catalog : Inherits System.Web.UI.Page
	Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
		'read in the category name from the head

		If Not Request.QueryString("c") Is Nothing Then
			lblTitle.Text = Request.QueryString("c").ToString()
		End If
    End Sub
    Function FmtDesc(ByVal str As String) As String
        Return str.Split(New String() {"</p>"}, 2, StringSplitOptions.RemoveEmptyEntries)(0)
    End Function
	Protected Function GetThumb(ByVal sImage As Object) As String
		Dim imageName As String = sImage.ToString()
		Dim sType As String = System.IO.Path.GetExtension(imageName)
		Dim sThumb As String = sType.Replace(".", "_thumb.")
		imageName = imageName.Replace(sType, sThumb)
		Return imageName
	End Function
	Protected Function GetPrice(ByVal sUnitCost As Object, ByVal sDiscountPercent As Object) As String
		Dim sPrice As String = sUnitCost.ToString()
		Dim sDiscount As String = sDiscountPercent.ToString()
		Dim dOriginalPrice As Double=Convert.ToDouble(sPrice)
		Dim dDiscountPrice As Double = 0
		Dim sOut As String = ""

		Dim discountPercent As Integer = Integer.Parse(sDiscount)

		If discountPercent > 0 Then
			dDiscountPrice = CatalogManager.GetDiscountedPrice(dOriginalPrice, discountPercent)
			sOut = "<span class=oldprice>" & dOriginalPrice.ToString("c") & "</span>&nbsp;<span class=saleprice>" & dDiscountPrice.ToString("c") & "</span>"
		Else
			sOut = dOriginalPrice.ToString("c")

		End If

		Return sOut
	End Function
End Class
