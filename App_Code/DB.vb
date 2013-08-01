Imports Microsoft.VisualBasic

Public Class DB
    Public Shared Function GetConnection() As Data.Odbc.OdbcConnection
        Dim cn As New Data.Odbc.OdbcConnection("dsn=misc;uid=misc;pwd=misc;")
        cn.Open()
        Return cn
    End Function
    Public Shared Function Prime(ByVal sql As String) As String
        Return sql.Replace("\", "\\").Replace("'", "\'")
    End Function
End Class
