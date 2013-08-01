Imports Microsoft.VisualBasic
Imports System
Imports System.Data

Public Class ShoppingCart


	#Region "private vars"
	Private _CartID As Integer
	Private _UserName As String
	Private _DateCreated As DateTime
	Private _LastModified As DateTime
	Private _IsCheckedOut As Boolean
	Private _ItemCount As Integer
	Private _SubTotal As Double
	Private _TotalWeight As Double
	Private _Items As ShoppingCartItems

	#End Region
	Public IsLoaded As Boolean = False
	#Region "Public Props"

	Public Property Items() As ShoppingCartItems
		Get
			Return _Items
		End Get
		Set
			_Items = Value
		End Set

	End Property
	Public Property CartID() As Integer
		Get
			Return _CartID
		End Get
		Set
			_CartID = Value
		End Set
	End Property
	Public Property UserName() As String
		Get
			Return _UserName
		End Get
		Set
			_UserName = Value
		End Set
	End Property
	Public Property DateCreated() As DateTime
		Get
			Return _DateCreated
		End Get
		Set
			_DateCreated = Value
		End Set
	End Property
	Public Property LastModified() As DateTime
		Get
			Return _LastModified
		End Get
		Set
			_LastModified = Value
		End Set
	End Property
	Public Property IsCheckedOut() As Boolean
		Get
			Return _IsCheckedOut
		End Get
		Set
			_IsCheckedOut = Value
		End Set
	End Property
	Public Property ItemCount() As Integer
		Get
			Return _ItemCount
		End Get
		Set
			_ItemCount = Value
		End Set
	End Property
	Public Property SubTotal() As Double
		Get
			Return _SubTotal
		End Get
		Set
			_SubTotal = Value
		End Set
	End Property
	Public Property TotalWeight() As Double
		Get
			Return _TotalWeight
		End Get
		Set
			_TotalWeight = Value
		End Set
	End Property
	#End Region

	Public Sub Load(ByVal rdr As IDataReader)
		If rdr.Read() Then
			IsLoaded = True
			_CartID = CInt(rdr("CartID"))
			_UserName = rdr("UserName").ToString()
			_DateCreated = CDate(rdr("DateCreated"))
			_LastModified = CDate(rdr("LastModified"))
			_IsCheckedOut = CBool(rdr("IsCheckedOut"))
			_ItemCount = CInt(rdr("ItemCount"))
			Try
				_SubTotal = Convert.ToDouble(rdr("SubTotal").ToString())
			Catch
				_SubTotal = 0
			End Try
			Try
				_TotalWeight = Convert.ToDouble(rdr("TotalWeight").ToString())
			Catch
				_TotalWeight = 0
			End Try
		End If
	End Sub
End Class