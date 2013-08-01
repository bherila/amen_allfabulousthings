Imports Microsoft.VisualBasic
Imports System
Imports System.Configuration
Imports System.Xml
Namespace Commerce.Providers
	''' <summary>
	''' Summary description for ContentConfigurationHandler.
	''' </summary>
	Public Class CatalogProviderConfigurationHandler : Implements IConfigurationSectionHandler
		Public Overridable Function Create(ByVal parent As Object, ByVal context As Object, ByVal node As XmlNode) As Object Implements IConfigurationSectionHandler.Create
			Dim config As CatalogProviderConfiguration = New CatalogProviderConfiguration()
			config.LoadValuesFromConfigurationXml(node)
			Return config
		End Function
	End Class

End Namespace