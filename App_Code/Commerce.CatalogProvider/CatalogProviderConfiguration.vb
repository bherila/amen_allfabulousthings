Imports Microsoft.VisualBasic
Imports System
Imports System.Configuration
Imports System.Collections
Imports System.Xml
Imports System.Collections.Specialized

Namespace Commerce.Providers

	Public Class CatalogProviderConfiguration
		Private defaultProvider_Renamed As String
		Private providers_Renamed As Hashtable = New Hashtable()

		Public Shared Function GetConfig() As CatalogProviderConfiguration
			Return CType(ConfigurationSettings.GetConfig("CommerceCatalogProvider"), CatalogProviderConfiguration)
		End Function

		Public Sub LoadValuesFromConfigurationXml(ByVal node As XmlNode)
			Dim attributeCollection As XmlAttributeCollection = node.Attributes

			' Get the default provider
			defaultProvider_Renamed = attributeCollection("defaultProvider").Value

			' Read child nodes
			For Each child As XmlNode In node.ChildNodes
				If child.Name = "providers" Then
					GetProviders(child)
				End If
			Next child
		End Sub

		Private Sub GetProviders(ByVal node As XmlNode)
            For Each xprovider As XmlNode In node.ChildNodes
                Select Case xprovider.Name
                    Case "add"
                        providers_Renamed.Add(xprovider.Attributes("name").Value, New BaseProvider(xprovider.Attributes))

                    Case "remove"
                        providers_Renamed.Remove(xprovider.Attributes("name").Value)

                    Case "clear"
                        providers_Renamed.Clear()
                End Select
            Next xprovider
		End Sub

		' Properties
		'
		Public ReadOnly Property DefaultProvider() As String
			Get
				Return defaultProvider_Renamed
			End Get
		End Property
		Public ReadOnly Property Providers() As Hashtable
			Get
				Return providers_Renamed
			End Get
		End Property

	End Class

    Public Class BaseProvider
        Private name_Renamed As String
        Private providerType As String
        Private providerAttributes As NameValueCollection = New NameValueCollection()

        'INSTANT VB NOTE: The parameter attributes was renamed since Visual Basic will not uniquely identify class members when parameters have the same name:
        Public Sub New(ByVal attributes_Renamed As XmlAttributeCollection)

            ' Set the name of the provider
            '
            name_Renamed = attributes_Renamed("name").Value

            ' Set the type of the provider
            '
            providerType = attributes_Renamed("type").Value

            ' Store all the attributes in the attributes bucket
            '
            For Each attribute As XmlAttribute In attributes_Renamed

                If (attribute.Name <> "name") AndAlso (attribute.Name <> "type") Then
                    providerAttributes.Add(attribute.Name, attribute.Value)
                End If

            Next attribute

        End Sub

        Public ReadOnly Property Name() As String
            Get
                Return name_Renamed
            End Get
        End Property

        Public ReadOnly Property Type() As String
            Get
                Return providerType
            End Get
        End Property

        Public ReadOnly Property Attributes() As NameValueCollection
            Get
                Return providerAttributes
            End Get
        End Property

    End Class

End Namespace
