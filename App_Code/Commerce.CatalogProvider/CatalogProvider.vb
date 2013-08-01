Imports Microsoft.VisualBasic
Imports System
Imports System.Reflection
Imports System.Collections.Specialized
Imports System.Configuration.Provider
Imports System.Data
Imports System.Web.Caching
Imports System.Web
Imports System.Web.Configuration
Imports System.Configuration
Namespace Commerce.Providers

    Public MustInherit Class CatalogProvider : Inherits System.Configuration.Provider.ProviderBase

        Private Shared _instance As CatalogProvider

        Private Shared padLock As Object
        Public Shared ReadOnly Property Instance() As CatalogProvider

            Get
                Dim tempInstance As CatalogProvider
                If _instance Is Nothing Then
                    padLock = New Object()
                End If
                SyncLock padLock
                    tempInstance = LoadProvider()
                    _instance = tempInstance
                End SyncLock

                Return _instance
            End Get
        End Property
        Shared Function LoadProvider() As CatalogProvider
            ' Get the names of the providers
            ' Use the cache because the reflection used later is expensive
            Dim cache As Cache = System.Web.HttpRuntime.Cache
            Dim cacheKey As String = Nothing

            Dim _instanceLoader As CatalogProvider
            Dim config As CatalogProviderConfiguration = CatalogProviderConfiguration.GetConfig()
            cacheKey = "CatalogProvider::" & config.DefaultProvider


            Dim oProvider As Object = cache.Get(cacheKey)
            If Not oProvider Is Nothing Then
                _instanceLoader = CType(oProvider, CatalogProvider)
            Else

                Try

                    ' Initialize the provider with the attributes.
                    Dim cfg As New System.Collections.Specialized.NameValueCollection()
                    Dim cStringName As String = "CommerceTemplate" 'CatalogProvider.Attributes("connectionStringName")
                    Dim cString As String = System.Configuration.ConfigurationManager.ConnectionStrings(cStringName).ConnectionString
                    Dim CatalogProvider As New SqlCatalogProvider
                    CatalogProvider.Initialize(CatalogProvider.Name, cString) 'Provider = CType(config.Providers(config.DefaultProvider), Provider)
                    cache.Insert(cacheKey, CatalogProvider)
                    _instanceLoader = CatalogProvider

                Catch e As Exception
                    Throw New Exception("Unable to load provider", e)
                End Try
            End If
            Return _instanceLoader
        End Function


#Region "Products"
        Public MustOverride Function ProductsSearch(ByVal query As String) As IDataReader
        Public MustOverride Function GetProducts() As IDataReader
        Public MustOverride Function GetCategories() As IDataReader
        Public MustOverride Function GetProductsByCategory(ByVal categoryID As Integer) As IDataReader
        Public MustOverride Function GetProduct(ByVal productID As Integer) As IDataReader

        Public MustOverride Sub FillProductDataSet(ByVal productID As Integer, ByVal ds As DataSet)
        Public MustOverride Function ProductIsActive(ByVal productID As Integer) As Boolean

        Public MustOverride Sub ProductsAdjustInventory(ByVal productID As Integer, ByVal newAmount As Integer, ByVal comment As String)
        Public MustOverride Function ProductsInventoryHistory(ByVal productID As Integer) As IDataReader
        Public MustOverride Sub ProductInactivate(ByVal productID As Integer)
        Public MustOverride Sub ProductDeletePermanent(ByVal productID As Integer)

        Public MustOverride Function ProductInsert(ByVal categoryID As Integer, ByVal modelNumber As String, ByVal modelName As String, ByVal productImage As String, ByVal unitCost As Double, ByVal description As String, ByVal amountOnHand As Integer, ByVal sku As String, ByVal weight As Double) As Integer
        Public MustOverride Sub ProductUpdate(ByVal productID As Integer, ByVal categoryID As Integer, ByVal modelNumber As String, ByVal modelName As String, ByVal productImage As String, ByVal unitCost As Double, ByVal description As String, ByVal sku As String, ByVal isActive As Boolean, ByVal weight As Double, ByVal discountPercent As Integer)

#End Region
    End Class
End Namespace
