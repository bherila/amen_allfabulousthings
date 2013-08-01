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
''' Summary description for Utility
''' </summary>
Public Class Utility
	Public Shared Function GetSiteRoot() As String
		Dim Port As String = System.Web.HttpContext.Current.Request.ServerVariables("SERVER_PORT")
		If Port Is Nothing OrElse Port = "80" OrElse Port = "443" Then
			Port = ""
		Else
			Port = ":" & Port
		End If

		Dim Protocol As String = System.Web.HttpContext.Current.Request.ServerVariables("SERVER_PORT_SECURE")
		If Protocol Is Nothing OrElse Protocol = "0" Then
			Protocol = "http://"
		Else
			Protocol = "https://"
		End If

		Dim sOut As String = Protocol & System.Web.HttpContext.Current.Request.ServerVariables("SERVER_NAME") & Port & System.Web.HttpContext.Current.Request.ApplicationPath
		Return sOut
	End Function
End Class
