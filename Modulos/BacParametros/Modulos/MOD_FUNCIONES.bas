Attribute VB_Name = "MOD_FUNCIONES"

Public Function FuncReturnDate(ByVal oFecha As String) As String
   Dim cSqlString    As String
   Dim oSqlDatos()
   
   Let cSqlString = ""
   Let cSqlString = cSqlString & " declare @dFechaCierrePeriodo DATETIME "
   Let cSqlString = cSqlString & " declare @dFechaInicioPeriodo DATETIME "
   Let cSqlString = cSqlString & " execute BacParamSuda.dbo.SP_BDD_fechaCierrePeriodo '" & oFecha & "'"
   Let cSqlString = cSqlString & " , @dFechaCierrePeriodo OUTPUT, @dFechaInicioPeriodo OUTPUT "
   Let cSqlString = cSqlString & " select  @dFechaCierrePeriodo ,  @dFechaInicioPeriodo"

   If Not Bac_Sql_Execute(cSqlString) Then
      Exit Function
   End If
   If Bac_SQL_Fetch(oSqlDatos()) Then
      Let FuncReturnDate = oSqlDatos(1)
   End If

End Function

Public Function FuncFechaCierreMes() As Date
   Dim cSqlString    As String
   Dim oSqlDatos()

   Let cSqlString = ""
   Let cSqlString = cSqlString & " SELECT isnull(MAX( Fecha ), '') FROM dbo.TBL_PATRIMONIO "

   If Not Bac_Sql_Execute(cSqlString) Then
      Exit Function
   End If
   If Bac_SQL_Fetch(oSqlDatos()) Then
      Let FuncFechaCierreMes = oSqlDatos(1)
   End If

End Function
