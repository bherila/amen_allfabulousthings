Imports Microsoft.VisualBasic
Imports System
Imports System.Data

<System.ComponentModel.DesignerCategory("Code")> _
Public Class Product


	#Region "private vars"
	Private _ProductID As Integer
	Private _DiscountPercent As Integer
	Private _CategoryID As Integer
	Private _ModelNumber As String
	Private _ModelName As String
	Private _ProductImage As String
	Private _UnitCost As Double
	Private _Weight As Double
	Private _Description As String
	Private _AmountOnHand As Integer
	Private _SKU As String
	Private _IsActive As Boolean
	#End Region

	Public IsLoaded As Boolean = False

	#Region "Public Props"
	Public Property ProductID() As Integer
		Get
			Return _ProductID
		End Get
		Set
			_ProductID = Value
		End Set
	End Property
	Public Property DiscountPercent() As Integer
		Get
			Return _DiscountPercent
		End Get
		Set
			_DiscountPercent = Value
		End Set
	End Property
	Public Property CategoryID() As Integer
		Get
			Return _CategoryID
		End Get
		Set
			_CategoryID = Value
		End Set
	End Property
	Public Property ModelNumber() As String
		Get
			Return _ModelNumber
		End Get
		Set
			_ModelNumber = Value
		End Set
	End Property
	Public Property ModelName() As String
		Get
			Return _ModelName
		End Get
		Set
			_ModelName = Value
		End Set
	End Property
	Public Property ProductImage() As String
		Get
			Return _ProductImage
		End Get
		Set
			_ProductImage = Value
		End Set
	End Property
	Public Property UnitCost() As Double
		Get
			Return _UnitCost
		End Get
		Set
			_UnitCost = Value
		End Set
	End Property
	Public Property Description() As String
		Get
			Return _Description
		End Get
		Set
			_Description = Value
		End Set
	End Property
	Public Property AmountOnHand() As Integer
		Get
			Return _AmountOnHand
		End Get
		Set
			_AmountOnHand = Value
		End Set
	End Property
	Public Property SKU() As String
		Get
			Return _SKU
		End Get
		Set
			_SKU = Value
		End Set
	End Property
	Public Property IsActive() As Boolean
		Get
			Return _IsActive
		End Get
		Set
			_IsActive = Value
		End Set
	End Property
	Public Property Weight() As Double
		Get
			Return _Weight
		End Get
		Set
			_Weight = Value
		End Set
	End Property
	#End Region

	Public Sub Load(ByVal rdr As IDataReader)
		If rdr.Read() Then
			IsLoaded = True
			_ProductID = CInt(rdr("ProductID"))
			_CategoryID = CInt(rdr("CategoryID"))
			_ModelNumber = rdr("ModelNumber").ToString()
			_ModelName = rdr("ModelName").ToString()
			_ProductImage = rdr("ProductImage").ToString()
			_UnitCost = Convert.ToDouble(rdr("UnitCost").ToString())
			_Weight = Convert.ToDouble(rdr("Weight").ToString())
			_Description = rdr("Description").ToString()
			_AmountOnHand = CInt(rdr("AmountOnHand"))
			_SKU = rdr("SKU").ToString()
			_IsActive = CBool(rdr("IsActive"))
			_DiscountPercent = CInt(rdr("DiscountPercent"))
		End If
	End Sub
End Class