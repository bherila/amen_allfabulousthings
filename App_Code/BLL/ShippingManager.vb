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

''' <summary>
''' Returns a Reader with the shipping choices based on zips and weight.
''' </summary>
Public Class ShippingManager
	Public Shared Function GetShippingChoices(ByVal fromZip As String, ByVal toZip As String, ByVal weight As Double) As IDataReader
		Return Commerce.Providers.ShippingProvider.Instance.GetShippingChoices(fromZip, toZip, weight)
	End Function
End Class
