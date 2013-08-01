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
Imports Commerce.Providers
Imports System.Data.SqlClient
''' <summary>
''' Summary description for Log
''' </summary>
Public Class Log
	Public Shared Sub Write(ByVal sEvent As String, ByVal category As String, ByVal message As String, ByVal itemID As String, ByVal userName As String)
		WriteLog(category, sEvent, message, itemID, userName)
	End Sub
	Public Shared Sub Write(ByVal sEvent As String, ByVal category As String, ByVal message As String, ByVal userName As String)
		WriteLog(category, sEvent, message, "", userName)

	End Sub
	Public Shared Sub Write(ByVal sEvent As String, ByVal message As String, ByVal userName As String)
		WriteLog("General", sEvent, message, "", userName)

	End Sub
	Public Shared Sub Write(ByVal message As String, ByVal userName As String)
		WriteLog("General", "Informational", message, "", userName)

	End Sub
	Public Shared Sub Write(ByVal message As String)
		WriteLog("General", "Informational", message, "", "System")

	End Sub
	Public Shared Sub Write(ByVal x As Exception, ByVal userName As String)
		WriteLog("Error", "Application Exception", x.Message+Constants.vbCrLf+GetStackTrace(x), "", "System")

	End Sub
	Private Shared Sub WriteLog(ByVal sEvent As String, ByVal category As String, ByVal message As String, ByVal itemID As String, ByVal userName As String)
	   Try
		   LogInsert(category, sEvent, message,itemID, userName)
	   Catch
	   End Try
	End Sub
	#Region "DB Call"
	Public Shared Sub LogInsert(ByVal category As String, ByVal sEvent As String, ByVal message As String, ByVal itemID As String, ByVal userName As String)
		'Define the parameters
        Dim params() As SqlParameter = {New SqlParameter("@category", SqlDbType.VarChar, 50, ParameterDirection.Input, True, 0, 0, Nothing, DataRowVersion.Current, category), New SqlParameter("@event", SqlDbType.VarChar, 50, ParameterDirection.Input, True, 0, 0, Nothing, DataRowVersion.Current, sEvent), New SqlParameter("@itemID", SqlDbType.VarChar, 50, ParameterDirection.Input, True, 0, 0, Nothing, DataRowVersion.Current, itemID), New SqlParameter("@userName", SqlDbType.VarChar, 50, ParameterDirection.Input, True, 0, 0, Nothing, DataRowVersion.Current, userName), New SqlParameter("@message", SqlDbType.VarChar, 1000, ParameterDirection.Input, True, 0, 0, Nothing, DataRowVersion.Current, message)}
		Try
			Dim connString As String = System.Configuration.ConfigurationManager.ConnectionStrings("CommerceTemplate").ConnectionString
			'Execute the command using the connection string from the db base class 
			'and get the number of rows affected by the operation
            Microsoft.ApplicationBlocks.Data.SqlHelper.ExecuteNonQuery(connString, CommandType.StoredProcedure, "CMRC_LOGS_Insert", params)
		Catch x As SqlException
            HandleError(params, x, "CMRC_LOGS_Insert")

		End Try
	End Sub
	#End Region

	#Region "Error Handling"
'TODO: INSTANT VB TODO TASK: paramArray is a keyword in VB.NET. Change the name or use square brackets to override it:
	Private Shared Sub HandleError(ByVal [paramArray] As SqlParameter(), ByVal x As SqlException, ByVal sprocName As String)
		Dim sException As String = "Error Executing " & sprocName & ": " & x.Message & " " & Constants.vbCrLf
		For Each p As SqlParameter In [paramArray]
			sException &= p.ParameterName & "=" & p.Value & Constants.vbCrLf
		Next p
		Throw New Exception(sException, x)
	End Sub

	#End Region
	Private Shared Function GetStackTrace(ByVal x As Exception) As String

		Dim logException As Exception = x
		If Not x.InnerException Is Nothing Then
			logException = x.InnerException
		End If

		Dim strErrorMsg As String = Constants.vbLf + Constants.vbLf & "Error in Path :" & System.Web.HttpContext.Current.Request.Path

		' Get the QueryString along with the Virtual Path
		strErrorMsg &= Constants.vbLf + Constants.vbLf & "Error Raw Url :" & System.Web.HttpContext.Current.Request.RawUrl


		' Get the error message
		strErrorMsg &= Constants.vbLf + Constants.vbLf & "Error Message :" & logException.Message

		' Source of the message
		strErrorMsg &= Constants.vbLf + Constants.vbLf & "Error Source :" & logException.Source

		' Stack Trace of the error

		strErrorMsg &= Constants.vbLf + Constants.vbLf & "Error Stack Trace :" & logException.StackTrace

		' Method where the error occurred
        strErrorMsg &= Constants.vbLf + Constants.vbLf & "Error TargetSite :" & logException.TargetSite.ToString()
		Return strErrorMsg
	End Function
End Class
