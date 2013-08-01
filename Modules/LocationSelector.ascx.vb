Imports Microsoft.VisualBasic
	Imports System
	Imports System.Data
	Imports System.Drawing
	Imports System.Web
	Imports System.Web.UI.WebControls
	Imports System.Web.UI.HtmlControls

	''' <summary>
	'''		Summary description for LocationSelector.
	''' </summary>
	Public Partial Class LocationSelector : Inherits System.Web.UI.UserControl
		Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Load
			' Put user code to initialize the page here
		End Sub
		Public Function GetSelectedState() As String
			If ddlState.Visible Then
				Return ddlState.SelectedValue
			Else
				Return txtState.Text
			End If
		End Function
		Public Function GetSelectedCountry() As String
			Return ddlCountry.SelectedValue
		End Function
		Public Sub LoadDrops(ByVal selectedState As String, ByVal selectedCountry As String)
			If selectedCountry = "US" Then
				ToggleStateDrop(True)
				Try
					ddlState.SelectedValue=selectedState
				Catch

				End Try
			Else
				ToggleStateDrop(False)
				txtState.Text = selectedState

			End If
			ddlCountry.SelectedValue = selectedCountry

		End Sub
		Private Sub ToggleStateDrop(ByVal showIt As Boolean)

			ddlState.Visible=showIt
			valState.Visible=showIt
			txtState.Visible=Not showIt
		End Sub
		#Region "Web Form Designer generated code"
		Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
			'
			' CODEGEN: This call is required by the ASP.NET Web Form Designer.
			'
			InitializeComponent()
		End Sub

		''' <summary>
		'''		Required method for Designer support - do not modify
		'''		the contents of this method with the code editor.
		''' </summary>
		Private Sub InitializeComponent()
'			Me.ddlCountry.SelectedIndexChanged += New System.EventHandler(Me.ddlCountry_SelectedIndexChanged);
'			Me.Load += New System.EventHandler(Me.Page_Load);

		End Sub
		#End Region
		Private Sub ddlCountry_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlCountry.SelectedIndexChanged
			If ddlCountry.SelectedValue="US" Then
				ToggleStateDrop(True)
			Else
				ToggleStateDrop(False)
			End If
		End Sub

	End Class
