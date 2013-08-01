Imports Microsoft.VisualBasic
Imports System
Imports System.Collections.Specialized
Imports System.Data.SqlClient
Imports System.Data

Namespace Commerce.Providers
	Friend Class SqlCatalogProvider : Inherits CatalogProvider

		Private _connectionString As String = ""

		#Region "Provider specific behaviors"
'INSTANT VB NOTE: The parameter name was renamed since Visual Basic will not uniquely identify class members when parameters have the same name:
        Public Overrides Sub Initialize(ByVal name_Renamed As String, ByVal configValue As NameValueCollection)
            _connectionString = configValue("connectionString").ToString()
        End Sub
        Public Overloads Sub Initialize(ByVal name_Renamed As String, ByVal connStr As String)
            _connectionString = connStr
        End Sub

		Public Overrides ReadOnly Property Name() As String
			Get
				Return Nothing
			End Get
		End Property
		#End Region

		#Region "Product Methods"
		Public Overrides Function ProductsSearch(ByVal query As String) As IDataReader
			Dim rdr As SqlDataReader = Nothing
			'Define the parameters
            Dim params() As SqlParameter = {New SqlParameter("@query", SqlDbType.VarChar, 100, ParameterDirection.Input, True, 0, 0, Nothing, DataRowVersion.Current, query)}
			Try
				'Fill the dataset using the connection string from the db base class
                rdr = Microsoft.ApplicationBlocks.Data.SqlHelper.ExecuteReader(_connectionString, CommandType.StoredProcedure, "CMRC_PRODUCTS_Search", params)
			Catch x As SqlException
                HandleError(params, x, "CMRC_PRODUCTS_Search")
			End Try
			Return rdr
		End Function

		Public Overrides Function ProductIsActive(ByVal productID As Integer) As Boolean
			Dim bOut As Boolean = False
			Dim rdr As SqlDataReader = Nothing
			'Define the parameters
            Dim params() As SqlParameter = {New SqlParameter("@productID", SqlDbType.Int, 0, ParameterDirection.Input, True, 10, 0, Nothing, DataRowVersion.Current, productID)}
            Try
                'Fill the dataset using the connection string from the db base class
                rdr = Microsoft.ApplicationBlocks.Data.SqlHelper.ExecuteReader(_connectionString, CommandType.StoredProcedure, "CMRC_PRODUCTS_ActiveCheck", params)
                If rdr.Read() Then
                    bOut = CBool(rdr(0))
                End If
                rdr.Close()
            Catch x As SqlException
                HandleError(params, x, "CMRC_PRODUCTS_ActiveCheck")
            End Try
            Return bOut
        End Function
        Public Overrides Function ProductInsert(ByVal categoryID As Integer, ByVal modelNumber As String, ByVal modelName As String, ByVal productImage As String, ByVal unitCost As Double, ByVal description As String, ByVal amountOnHand As Integer, ByVal sku As String, ByVal weight As Double) As Integer
            Dim rdr As SqlDataReader = Nothing
            'Define the parameters
            Dim iOut As Integer = 0
            Dim params() As SqlParameter = {New SqlParameter("@CategoryID", SqlDbType.Int, 0, ParameterDirection.Input, True, 10, 0, Nothing, DataRowVersion.Current, categoryID), New SqlParameter("@ModelNumber", SqlDbType.NVarChar, 50, ParameterDirection.Input, True, 0, 0, Nothing, DataRowVersion.Current, modelNumber), New SqlParameter("@ModelName", SqlDbType.NVarChar, 50, ParameterDirection.Input, True, 0, 0, Nothing, DataRowVersion.Current, modelName), New SqlParameter("@ProductImage", SqlDbType.NVarChar, 50, ParameterDirection.Input, True, 0, 0, Nothing, DataRowVersion.Current, productImage), New SqlParameter("@UnitCost", SqlDbType.Money, 0, ParameterDirection.Input, True, 19, 0, Nothing, DataRowVersion.Current, unitCost), New SqlParameter("@Description", SqlDbType.VarChar, 500, ParameterDirection.Input, True, 0, 0, Nothing, DataRowVersion.Current, description), New SqlParameter("@AmountOnHand", SqlDbType.Int, 0, ParameterDirection.Input, True, 10, 0, Nothing, DataRowVersion.Current, amountOnHand), New SqlParameter("@SKU", SqlDbType.VarChar, 50, ParameterDirection.Input, True, 0, 0, Nothing, DataRowVersion.Current, sku), New SqlParameter("@weight", SqlDbType.Money, 50, ParameterDirection.Input, True, 0, 0, Nothing, DataRowVersion.Current, weight)}
            Try
                'Fill the dataset using the connection string from the db base class
                rdr = Microsoft.ApplicationBlocks.Data.SqlHelper.ExecuteReader(_connectionString, CommandType.StoredProcedure, "CMRC_PRODUCTS_Insert", params)

                If rdr.Read() Then
                    iOut = Convert.ToInt32(rdr(0).ToString())
                End If
            Catch x As SqlException
                HandleError(params, x, "CMRC_PRODUCTS_Insert")
            End Try
            Return iOut
        End Function
		Public Overrides Sub ProductUpdate(ByVal productID As Integer, ByVal categoryID As Integer, ByVal modelNumber As String, ByVal modelName As String, ByVal productImage As String, ByVal unitCost As Double, ByVal description As String, ByVal sku As String, ByVal isActive As Boolean, ByVal weight As Double, ByVal discountPercent As Integer)
			'Define the parameters
            Dim params() As SqlParameter = {New SqlParameter("@ProductID", SqlDbType.Int, 0, ParameterDirection.Input, True, 10, 0, Nothing, DataRowVersion.Current, productID), New SqlParameter("@CategoryID", SqlDbType.Int, 0, ParameterDirection.Input, True, 10, 0, Nothing, DataRowVersion.Current, categoryID), New SqlParameter("@ModelNumber", SqlDbType.NVarChar, 50, ParameterDirection.Input, True, 0, 0, Nothing, DataRowVersion.Current, modelNumber), New SqlParameter("@ModelName", SqlDbType.NVarChar, 50, ParameterDirection.Input, True, 0, 0, Nothing, DataRowVersion.Current, modelName), New SqlParameter("@ProductImage", SqlDbType.NVarChar, 50, ParameterDirection.Input, True, 0, 0, Nothing, DataRowVersion.Current, productImage), New SqlParameter("@UnitCost", SqlDbType.Money, 0, ParameterDirection.Input, True, 19, 0, Nothing, DataRowVersion.Current, unitCost), New SqlParameter("@Description", SqlDbType.Text, description.Length, ParameterDirection.Input, True, 0, 0, Nothing, DataRowVersion.Current, description), New SqlParameter("@SKU", SqlDbType.VarChar, 50, ParameterDirection.Input, True, 0, 0, Nothing, DataRowVersion.Current, sku), New SqlParameter("@IsActive", SqlDbType.Bit, 50, ParameterDirection.Input, True, 0, 0, Nothing, DataRowVersion.Current, isActive), New SqlParameter("@weight", SqlDbType.Money, 50, ParameterDirection.Input, True, 0, 0, Nothing, DataRowVersion.Current, weight), New SqlParameter("@discountPercent", SqlDbType.Int, 0, ParameterDirection.Input, True, 10, 0, Nothing, DataRowVersion.Current, discountPercent)}
            Try

                'Execute the command using the connection string from the db base class 
                'and get the number of rows affected by the operation
                Microsoft.ApplicationBlocks.Data.SqlHelper.ExecuteNonQuery(_connectionString, CommandType.StoredProcedure, "CMRC_PRODUCTS_Update", params)
            Catch x As SqlException
                HandleError(params, x, "CMRC_PRODUCTS_Update")

            End Try
        End Sub



        Public Overrides Sub ProductsAdjustInventory(ByVal productID As Integer, ByVal newAmount As Integer, ByVal comment As String)
            'Define the parameters
            Dim params() As SqlParameter = {New SqlParameter("@productID", SqlDbType.Int, 0, ParameterDirection.Input, True, 10, 0, Nothing, DataRowVersion.Current, productID), New SqlParameter("@newAmount", SqlDbType.Int, 0, ParameterDirection.Input, True, 10, 0, Nothing, DataRowVersion.Current, newAmount), New SqlParameter("@comment", SqlDbType.VarChar, 500, ParameterDirection.Input, True, 0, 0, Nothing, DataRowVersion.Current, comment)}
            Try

                'Execute the command using the connection string from the db base class 
                'and get the number of rows affected by the operation
                Microsoft.ApplicationBlocks.Data.SqlHelper.ExecuteNonQuery(_connectionString, CommandType.StoredProcedure, "CMRC_PRODUCTS_AdjustInventory", params)
            Catch x As SqlException
                HandleError(params, x, "CMRC_PRODUCTS_AdjustInventory")

            End Try
        End Sub
		Public Overrides Function GetProducts() As IDataReader
			Dim rdr As SqlDataReader = Nothing
			'Define the parameters
            Dim params() As SqlParameter = {}
            Try
                'Fill the dataset using the connection string from the db base class
                rdr = Microsoft.ApplicationBlocks.Data.SqlHelper.ExecuteReader(_connectionString, CommandType.StoredProcedure, "CMRC_PRODUCTS_GetList", params)
            Catch x As SqlException
                Dim sException As String = "Error Executing CMRC_PRODUCTS_GetList: " & Constants.vbCrLf
                For Each p As SqlParameter In params
                    sException &= p.ParameterName & "=" & p.Value & Constants.vbCrLf
                Next p
                Throw New Exception(sException, x)

            End Try
            Return rdr
        End Function
        Public Overrides Function GetProductsByCategory(ByVal categoryID As Integer) As IDataReader
            Dim rdr As SqlDataReader = Nothing
            'Define the parameters
            Dim params() As SqlParameter = {New SqlParameter("@categoryID", SqlDbType.Int, 0, ParameterDirection.Input, True, 10, 0, Nothing, DataRowVersion.Current, categoryID)}
            Try
                'Fill the dataset using the connection string from the db base class
                rdr = Microsoft.ApplicationBlocks.Data.SqlHelper.ExecuteReader(_connectionString, CommandType.StoredProcedure, "CMRC_PRODUCTS_GetListByCategory", params)
            Catch x As SqlException
                Dim sException As String = "Error Executing CMRC_PRODUCTS_GetListByCategory: " & Constants.vbCrLf
                For Each p As SqlParameter In params
                    sException &= p.ParameterName & "=" & p.Value & Constants.vbCrLf
                Next p
                Throw New Exception(sException, x)

            End Try
            Return rdr
        End Function
        Public Overrides Function GetCategories() As IDataReader
            Dim rdr As SqlDataReader = Nothing
            'Define the parameters
            Dim params() As SqlParameter = {}
            Try
                'Fill the dataset using the connection string from the db base class
                rdr = Microsoft.ApplicationBlocks.Data.SqlHelper.ExecuteReader(_connectionString, CommandType.StoredProcedure, "CMRC_CATEGORIES_GetList", params)
            Catch x As SqlException
                Dim sException As String = "Error Executing CMRC_CATEGORIES_GetList: " & Constants.vbCrLf
                For Each p As SqlParameter In params
                    sException &= p.ParameterName & "=" & p.Value & Constants.vbCrLf
                Next p
                Throw New Exception(sException, x)

            End Try
            Return rdr
        End Function
        Public Overrides Function GetProduct(ByVal productID As Integer) As IDataReader
            Dim rdr As SqlDataReader = Nothing
            'Define the parameters
            Dim params() As SqlParameter = {New SqlParameter("@ProductID", SqlDbType.Int, 0, ParameterDirection.Input, True, 10, 0, Nothing, DataRowVersion.Current, productID)}
            Try
                'Fill the dataset using the connection string from the db base class
                rdr = Microsoft.ApplicationBlocks.Data.SqlHelper.ExecuteReader(_connectionString, CommandType.StoredProcedure, "CMRC_PRODUCTS_Get", params)
            Catch x As SqlException
                Dim sException As String = "Error Executing CMRC_PRODUCTS_Get: " & Constants.vbCrLf
                For Each p As SqlParameter In params
                    sException &= p.ParameterName & "=" & p.Value & Constants.vbCrLf
                Next p
                Throw New Exception(sException, x)

            End Try
            Return rdr
        End Function
		Public Overrides Sub FillProductDataSet(ByVal productID As Integer, ByVal ds As DataSet)
			Dim numRows As Integer = -1
			'Define the parameters
            Dim params() As SqlParameter = {New SqlParameter("@ProductID", SqlDbType.Int, 0, ParameterDirection.Input, True, 10, 0, Nothing, DataRowVersion.Current, productID)}
            Try
                Dim count As Integer = ds.Tables.Count
                Dim tableNames As String() = Nothing
                If count > 0 Then
                    tableNames = New String(count - 1) {}
                    Dim i As Integer = 0
                    Do While i < count
                        tableNames(i) = ds.Tables(i).TableName
                        i += 1
                    Loop
                End If

                'Fill the dataset using the connection string from the db base class
                Microsoft.ApplicationBlocks.Data.SqlHelper.FillDataset(_connectionString, CommandType.StoredProcedure, "CMRC_PRODUCTS_Get", ds, tableNames, params)

            Catch x As SqlException
                Dim sException As String = "Error Executing CMRC_PRODUCTS_Get: " & Constants.vbCrLf
                For Each p As SqlParameter In params
                    sException &= p.ParameterName & "=" & p.Value & Constants.vbCrLf
                Next p
                Throw New Exception(sException, x)

            End Try
        End Sub
        Public Overrides Function ProductsInventoryHistory(ByVal productID As Integer) As IDataReader
            Dim rdr As SqlDataReader = Nothing
            'Define the parameters
            Dim params() As SqlParameter = {New SqlParameter("@productID", SqlDbType.Int, 0, ParameterDirection.Input, True, 10, 0, Nothing, DataRowVersion.Current, productID)}
            Try
                'Fill the dataset using the connection string from the db base class
                rdr = Microsoft.ApplicationBlocks.Data.SqlHelper.ExecuteReader(_connectionString, CommandType.StoredProcedure, "CMRC_PRODUCTS_InventoryHistory", params)
            Catch x As SqlException
                HandleError(params, x, "CMRC_PRODUCTS_InventoryHistory")
            End Try
            Return rdr
        End Function
		Public Overrides Sub ProductInactivate(ByVal productID As Integer)
			'Define the parameters
            Dim params() As SqlParameter = {New SqlParameter("@ProductID", SqlDbType.Int, 0, ParameterDirection.Input, True, 10, 0, Nothing, DataRowVersion.Current, productID)}
            Try

                'Execute the command using the connection string from the db base class 
                'and get the number of rows affected by the operation
                Microsoft.ApplicationBlocks.Data.SqlHelper.ExecuteNonQuery(_connectionString, CommandType.StoredProcedure, "CMRC_PRODUCTS_Inactivate", params)
            Catch x As SqlException
                HandleError(params, x, "CMRC_PRODUCTS_Inactivate")

            End Try
        End Sub
        Public Overrides Sub ProductDeletePermanent(ByVal productID As Integer)
            'Define the parameters
            Dim params() As SqlParameter = {New SqlParameter("@ProductID", SqlDbType.Int, 0, ParameterDirection.Input, True, 10, 0, Nothing, DataRowVersion.Current, productID)}
            Try

                'Execute the command using the connection string from the db base class 
                'and get the number of rows affected by the operation
                Microsoft.ApplicationBlocks.Data.SqlHelper.ExecuteNonQuery(_connectionString, CommandType.StoredProcedure, "CMRC_PRODUCTS_DeletePermanent", params)
            Catch x As SqlException
                HandleError(params, x, "CMRC_PRODUCTS_DeletePermanent")

            End Try
        End Sub
		#End Region

		#Region "Error Handling"
'TODO: INSTANT VB TODO TASK: paramArray is a keyword in VB.NET. Change the name or use square brackets to override it:
        Private Sub HandleError(ByVal params As SqlParameter(), ByVal x As SqlException, ByVal sprocName As String)
            Dim sException As String = "Error Executing " & sprocName & ": " & x.Message & " " & Constants.vbCrLf
            For Each p As SqlParameter In params
                sException &= p.ParameterName & "=" & p.Value & Constants.vbCrLf
            Next p
            Throw New Exception(sException, x)
        End Sub

		#End Region
	End Class
End Namespace
