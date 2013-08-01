Imports Microsoft.VisualBasic
Imports System
Imports System.Data

Public Class Order

	#Region "private vars"
	Private _OrderID As Integer
	Private _OrderGUID As String
	Private _OrderDate As DateTime
	Private _ShipDate As DateTime
	Private _OrderStatusID As Integer
	Private _UserName As String
	Private _ShippingAddress As String
	Private _OrderSubTotal As Double
	Private _Shipping As Double
	Private _Tax As Double
	Private _OrderZipCode As String
	Private _OrderStatus As String
	Private _ShippingMethod As String
	Private _PayPalTransactionID As String
	Private _DatePaid As DateTime
	Private _PaymentMethod As String
	Private _ShippingTrackingNumber As String

	#End Region

	#Region "Public Props"

	Public Property OrderID() As Integer
		Get
			Return _OrderID
		End Get
		Set
			_OrderID = Value
		End Set
	End Property
	Public Property ShippingTrackingNumber() As String
		Get
			Return _ShippingTrackingNumber
		End Get
		Set
			_ShippingTrackingNumber = Value
		End Set
	End Property
	Public Property OrderGUID() As String
		Get
			Return _OrderGUID
		End Get
		Set
			_OrderGUID = Value
		End Set
	End Property
	Public Property OrderStatus() As String
		Get
			Return _OrderStatus
		End Get
		Set
			_OrderStatus = Value
		End Set
	End Property
	Public Property OrderDate() As DateTime
		Get
			Return _OrderDate
		End Get
		Set
			_OrderDate = Value
		End Set
	End Property
	Public Property ShipDate() As DateTime
		Get
			Return _ShipDate
		End Get
		Set
			_ShipDate = Value
		End Set
	End Property
	Public Property OrderStatusID() As Integer
		Get
			Return _OrderStatusID
		End Get
		Set
			_OrderStatusID = Value
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
	Public Property ShippingAddress() As String
		Get
			Return _ShippingAddress
		End Get
		Set
			_ShippingAddress = Value
		End Set
	End Property
	Public Property OrderSubTotal() As Double
		Get
			Return _OrderSubTotal
		End Get
		Set
			_OrderSubTotal = Value
		End Set
	End Property
	Public Property Shipping() As Double
		Get
			Return _Shipping
		End Get
		Set
			_Shipping = Value
		End Set
	End Property
	Public Property Tax() As Double
		Get
			Return _Tax
		End Get
		Set
			_Tax = Value
		End Set
	End Property
	Public Property OrderZipCode() As String
		Get
			Return _OrderZipCode
		End Get
		Set
			_OrderZipCode = Value
		End Set
	End Property
	Public Property ShippingMethod() As String
		Get
			Return _ShippingMethod
		End Get
		Set
			_ShippingMethod = Value
		End Set
	End Property
	Public Property PayPalTransactionID() As String
		Get
			Return _PayPalTransactionID
		End Get
		Set
			_PayPalTransactionID = Value
		End Set
	End Property
	Public Property DatePaid() As DateTime
		Get
			Return _DatePaid
		End Get
		Set
			_DatePaid = Value
		End Set
	End Property
	Public Property PaymentMethod() As String
		Get
			Return _PaymentMethod
		End Get
		Set
			_PaymentMethod = Value
		End Set
	End Property
	#End Region

	Public Sub Load(ByVal rdr As IDataReader)
		If rdr.Read() Then
			_OrderID = CInt(rdr("OrderID"))
			_OrderGUID = rdr("OrderGUID").ToString()
			_OrderDate = CDate(rdr("OrderDate"))
			_ShipDate = CDate(rdr("ShipDate"))
			_OrderStatusID = CInt(rdr("OrderStatusID"))
			_UserName = rdr("UserName").ToString()
			_ShippingMethod = rdr("ShippingMethod").ToString()
			_ShippingAddress = rdr("ShippingAddress").ToString()
			_OrderSubTotal = Convert.ToDouble(rdr("OrderSubTotal").ToString())
			_Shipping = Convert.ToDouble(rdr("Shipping").ToString())
			_Tax = Convert.ToDouble(rdr("Tax").ToString())
			_OrderZipCode = rdr("OrderZipCode").ToString()
			_PayPalTransactionID = rdr("PayPalTransactionID").ToString()
			Try
				_DatePaid = CDate(rdr("DatePaid"))
			Catch
				_DatePaid = DateTime.Parse("1/1/1900")
			End Try
			_PaymentMethod = rdr("PaymentMethod").ToString()
			_OrderStatus = rdr("OrderStatus").ToString()
			_ShippingTrackingNumber = rdr("ShippingTrackingNumber").ToString()
		End If
	End Sub
End Class