Imports Microsoft.VisualBasic
	Imports System
	Imports System.Data

	<System.ComponentModel.DesignerCategory("Code")> _
	Public Class ShoppingCartItems : Inherits DataTable



		Public Sub New()
			BuildDataTables()
			Me.TableName = "Cart"
		End Sub
		Private _cartGUID As String
		Public Property CartGUID() As String
			Get
				Return _cartGUID
			End Get
			Set
				_cartGUID = Value
			End Set
		End Property
		Private Sub BuildDataTables()

			Dim columns As DataColumnCollection = Me.Columns
			columns.Add("ProductID", GetType(System.Int32))
			columns.Add("ModelName", GetType(System.String))
			columns.Add("ModelNumber", GetType(System.String))
			columns.Add("Description", GetType(System.String))
			columns.Add("Price", GetType(System.Double))
			columns.Add("LineTotal", GetType(System.Double))
			columns.Add("Quantity", GetType(System.Int32))
			columns.Add("DateAdded", GetType(System.DateTime))
			columns.Add("Weight", GetType(System.Double))
		End Sub

	End Class
