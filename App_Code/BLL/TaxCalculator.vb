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
''' The tax calculator uses the TaxProvider to calculate the tax amount on 
''' a set amount. You should consult your local tax laws before using/implementing.
''' </summary>
Public Class TaxCalculator

	''' <summary>
	''' Determine tax by state
	''' </summary>
	''' <param name="state"></param>
	''' <param name="subtotal"></param>
	''' <returns></returns>
	Public Shared Function GetTaxByState(ByVal state As String, ByVal subtotal As Double) As Double
		Return Commerce.Providers.TaxProvider.Instance.CalculateTaxAmount(state, subtotal)
	End Function
	''' <summary>
	''' Determine tax by zip code.
	''' </summary>
	''' <param name="zip"></param>
	''' <param name="subtotal"></param>
	''' <returns></returns>
	Public Shared Function GetTaxByZip(ByVal zip As String, ByVal subtotal As Double) As Double
		Return Commerce.Providers.TaxProvider.Instance.CalculateTaxAmount("", zip, subtotal)

	End Function
End Class
