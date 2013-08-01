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


Public Class SiteConfiguration
	Public Sub New()
	End Sub
	Public Shared ReadOnly Property SimpleTaxRate() As Double
		Get
			Dim sSetting As String = GetSetting("SimpleTaxRate")
			Return Convert.ToDouble(sSetting)
		End Get
	End Property
	Public Shared ReadOnly Property CurrencyCode() As String
		Get
			Return GetSetting("CurrencyCode")
		End Get

	End Property
	Public Shared ReadOnly Property SecureURL() As String
		Get
			Return GetSetting("SecureURL")
		End Get

	End Property
    Public Shared ReadOnly Property UsePayPalPaymentsStandard() As Boolean

        Get
            Dim bOut As Boolean = False
            Try
                bOut = Convert.ToBoolean(GetSetting("UsePayPalPaymentsStandard"))
            Catch

            End Try
            Return bOut
        End Get

    End Property
	Public Shared ReadOnly Property UseBuyNow() As Boolean
		Get
			Dim bOut As Boolean = False
			Try
				bOut = Convert.ToBoolean(GetSetting("UseBuyNow"))
			Catch

			End Try
			Return bOut
		End Get

	End Property
	Public Shared ReadOnly Property ShowZeroInventoryItems() As Boolean
		Get
			Dim bOut As Boolean = False
			Try
				bOut = Convert.ToBoolean(GetSetting("ShowZeroInventoryItems"))
			Catch

			End Try
			Return bOut
		End Get

	End Property
	Public Shared ReadOnly Property RequireShipping() As Boolean
		Get
			Dim bOut As Boolean = False
			Try
				bOut = Convert.ToBoolean(GetSetting("RequireShipping"))
			Catch

			End Try
			Return bOut
		End Get

	End Property
	Public Shared ReadOnly Property SiteURL() As String
		Get
			Return GetSetting("SiteURL")
		End Get

	End Property


	Public Shared ReadOnly Property MailServer() As String
		Get
			Return GetSetting("MailServer")
		End Get

	End Property

	Public Shared ReadOnly Property RequireLogin() As String
		Get
			Return GetSetting("RequireLogin")
		End Get

	End Property



	#Region "PayPal Bits"
	Public Shared ReadOnly Property BusinessEmail() As String
		Get
			Return GetSetting("BusinessEmail")
		End Get

	End Property

	Public Shared ReadOnly Property UseSandbox() As Boolean
		Get
			Dim bOut As Boolean = False
			Try
				bOut = Convert.ToBoolean(GetSetting("UseSandbox"))
			Catch

			End Try
			Return bOut
		End Get

	End Property

	  Public Shared ReadOnly Property PayPalAPIReturnURL() As String
		Get
			Return GetSetting("PayPalAPIReturnURL")
		End Get

	  End Property
	Public Shared ReadOnly Property PayPalAPICancelUrl() As String
		Get
			Return GetSetting("PayPalAPICancelUrl")
		End Get

	End Property
	Public Shared ReadOnly Property PayPalAPIAccountName() As String
		Get
			Return GetSetting("PayPalAPIAccountName")
		End Get

	End Property
	Public Shared ReadOnly Property PayPalAPIAccountPassword() As String
		Get
			Return GetSetting("PayPalAPIAccountPassword")
		End Get

	End Property
	Public Shared ReadOnly Property PayPalAPICertificationPath() As String
		Get


			Dim certFile As String = GetSetting("PayPalAPICertificate")
			Dim thisAppPath As String = System.Web.HttpContext.Current.Request.ApplicationPath
			If thisAppPath = "/" Then
				thisAppPath = ""
			End If
			Dim filePath As String = System.Web.HttpContext.Current.Server.MapPath(thisAppPath & "/App_Data/" & certFile)
			Return filePath
		End Get

	End Property
	Public Shared ReadOnly Property PayPalAPICertificationPassword() As String
		Get
			Return GetSetting("PayPalAPICertificationPassword")
		End Get

	End Property
	Public Shared ReadOnly Property EncryptionPassword() As String
		Get
			Return GetSetting("EncryptionPassword")
		End Get

	End Property
	Public Shared ReadOnly Property UseDirectPay() As Boolean
		Get
			Dim bOut As Boolean = False
			Try
				bOut = Convert.ToBoolean(GetSetting("UseDirectPay"))
			Catch

			End Try
			Return bOut
		End Get
	End Property
	#End Region




	Private Shared Function GetSetting(ByVal key As String) As String
		Try
			Return System.Configuration.ConfigurationSettings.AppSettings(key).ToString()
		Catch
			Throw New Exception("No " & key & " setting in the web.config.")
		End Try

	End Function
End Class
