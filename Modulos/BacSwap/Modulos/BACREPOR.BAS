Attribute VB_Name = "BacReportes"
Option Explicit


Function BacLeeOperacionCalcePro()
   Dim Sql        As String
   Dim cCristal   As New clsCristal
   Dim Datos()

   'Limpieza de la tabla Access
   Sql = "DELETE FROM infcalpro;"

   DB.Execute Sql

   'Llamando procedimiento almacenado
   Sql = "Execute sp_mfccleercalcespro"
   
   If SQL_Execute(Sql) > 0 Then
      MsgBox "Problemas al leer operaciones de calces por producto ", vbCritical, "MENSAJE"
      Exit Function
   End If

   Do While SQL_Fetch(Datos()) = 0

      Sql = ""
      Sql = Sql & "INSERT INTO infcalpro VALUES ( "

      Sql = Sql & "'" & Trim(Datos(1)) & "', "              'Fecha Vencimiento
      Sql = Sql & bacTranMontoSql(Datos(2)) & ", "          'Numero Operacion CMP
      Sql = Sql & bacTranMontoSql(Datos(3)) & ", "          'Numero Operacion VTA
      Sql = Sql & "'" & Trim(Datos(4)) & "', "              'Nombre Cliente CMP
      Sql = Sql & "'" & Trim(Datos(5)) & "', "              'Nombre Cliente VTA
      Sql = Sql & "'" & Trim(Datos(6)) & "', "              'Tipo Calces CMP
      Sql = Sql & "'" & Trim(Datos(7)) & "', "              'Tipo Calces VTA
      Sql = Sql & bacTranMontoSql(Datos(8)) & ", "          'Futuros
      Sql = Sql & bacTranMontoSql(Datos(9)) & ", "          'Precio CMP
      Sql = Sql & bacTranMontoSql(Datos(10)) & ", "         'Precio VTA
      Sql = Sql & "'" & Trim(Datos(11)) & "', "             'Tipo Operacion CMP
      Sql = Sql & "'" & Trim(Datos(12)) & "', "             'Tipo Operacion VTA
      Sql = Sql & "'" & Trim(Datos(13)) & "', "             'Nombre Empresa
      Sql = Sql & "'" & Trim(Datos(14)) & "', "             'Direccion Empresa
      Sql = Sql & "'" & Trim(Datos(15)) & "', "             'Fecha Proceso
      Sql = Sql & "'" & Trim(Datos(16)) & "', "             'Fecha Compra
      Sql = Sql & "'" & Trim(Datos(17)) & "', "             'Fecha Venta
      Sql = Sql & bacTranMontoSql(Datos(18)) & ", "         'Codigo
      Sql = Sql & bacTranMontoSql(Datos(19)) & ", "         'Codigo2
      Sql = Sql & "'" & Trim(Datos(20)) & "', "             'Moneda Activo
      Sql = Sql & "'" & Trim(Datos(21)) & "'"               'Moneda Pasivo

      Sql = Sql & " );"

      DB.Execute Sql

   Loop

   'tipo de reporte
   cCristal.ReportType = "MDB"

   'Orden de impresión del reporte
   cCristal.PEN_ImprimirReporte "bacalpro", "(bacalpro)  operaciones de  calces por producto " & Format$(gsBAC_Fecp, "dd/mm/yyyy")

   Set cCristal = Nothing

End Function

Function BacLeeOperacionDescpro()

   Dim Sql        As String
   Dim cCristal   As New clsCristal
   Dim Datos()

   'Limpieza de la tabla Access
   Sql = "DELETE FROM infdcpro;"

   DB.Execute Sql

   'Llamando procedimiento almacenado
   Sql = "Execute sp_descalceopeproducto "

   If SQL_Execute(Sql) > 0 Then
      MsgBox "Problemas al leer operaciones de descalces por producto", vbCritical, "MENSAJE"
      Exit Function

   End If

   Do While SQL_Fetch(Datos()) = 0

      Sql = ""
      Sql = Sql & "INSERT INTO infdcpro VALUES ( "
      Sql = Sql & bacTranMontoSql(Datos(1)) & ", "                                    'Numero Operacion Compra
      Sql = Sql & "'" & Trim(Datos(2)) & "', "                                        'Nombre Cliente Compra
      Sql = Sql & "'" & IIf(Datos(3) = "", ".", Trim(Datos(3))) & "', "               'Tipo Operacion Compra
      Sql = Sql & "'" & IIf(Datos(4) = "", ".", Trim(Datos(4))) & "', "               'Fecha Vencimiento
      Sql = Sql & bacTranMontoSql(Datos(5)) & ", "                                    'Monto
      Sql = Sql & "'" & IIf(Datos(6) = "", ".", Trim(Datos(6))) & "', "               'Glosa
      Sql = Sql & bacTranMontoSql(Datos(7)) & ", "                                    'Precio Compra
      Sql = Sql & bacTranMontoSql(Datos(8)) & ", "                                    'Saldo
      Sql = Sql & "'" & IIf(Datos(9) = "", ".", Trim(Datos(9))) & "', "               'Fecha Compra
      Sql = Sql & "'" & IIf(Datos(10) = "", ".", Trim(Datos(10))) & "', "             'Fecha Proceso
      Sql = Sql & "'" & IIf(Datos(11) = "", ".", Trim(Datos(11))) & "', "             'Nombre Empresa
      Sql = Sql & "'" & IIf(Datos(12) = "", ".", Trim(Datos(12))) & "', "             'Direccion Empresa
      Sql = Sql & bacTranMontoSql(Datos(13)) & ", "                                   'Numero Operacion Venta
      Sql = Sql & "'" & Trim(Datos(14)) & "', "                                       'Nombre Cliente Venta
      Sql = Sql & "'" & IIf(Datos(15) = "", ".", Trim(Datos(15))) & "', "             'Tipo Operacion Venta
      Sql = Sql & bacTranMontoSql(Datos(16)) & ", "                                   'Precio Venta
      Sql = Sql & "'" & IIf(Datos(17) = "", ".", Trim(Datos(17))) & "', "             'Fecha Venta
      Sql = Sql & bacTranMontoSql(Datos(18)) & ", "                                   'Monto Venta
      Sql = Sql & bacTranMontoSql(Datos(19)) & ", "                                   'saldo Venta
      Sql = Sql & "'" & IIf(Datos(20) = "", ".", Trim(Datos(20))) & "', "             'Glosa venta
      Sql = Sql & "'" & IIf(Datos(21) = "", ".", Trim(Datos(21))) & "', "             'Fecha Vencimiento Venta
      Sql = Sql & bacTranMontoSql(Datos(22)) & ", "                                   'Codigo
      Sql = Sql & bacTranMontoSql(Datos(23)) & ", "                                   'Codigo2
      Sql = Sql & "'" & IIf(Datos(24) = "", ".", Trim(Datos(24))) & "', "             'Moneda Activo
      Sql = Sql & "'" & IIf(Datos(25) = "", ".", Trim(Datos(25))) & "'"               'Moneda Pasivo
      Sql = Sql & " );"

      DB.Execute Sql

   Loop

   'tipo de reporte
   cCristal.ReportType = "MDB"

   'Orden de impresión del reporte
   cCristal.PEN_ImprimirReporte "bacdcpro", "(bacdcpro)  operaciones de descalces por producto " & Format$(gsBAC_Fecp, "dd/mm/yyyy")

   Set cCristal = Nothing

End Function

Function BacCarteraOperDerivados()

   Dim Sql        As String
   Dim cCristal   As New clsCristal
   Dim Datos()

   'Limpieza de la tabla Access
   Sql = "DELETE FROM infopeder;"

   DB.Execute Sql

   'Llamando procedimiento almacenado
   Sql = "Execute sp_carteraderivados "
   
   If SQL_Execute(Sql) > 0 Then
      MsgBox "Problemas al leer cartera de derivados", vbCritical, "MENSAJE"
      Exit Function

   End If
    
   Do While SQL_Fetch(Datos()) = 0

      Sql = ""
      Sql = Sql & "INSERT INTO infopeder VALUES ( "
         
      Sql = Sql & "'" & Trim(Datos(1)) & "', "                          'Tipo Operacion
      Sql = Sql & Val(Datos(2)) & ", "                                  'Numero Operacion
      Sql = Sql & "'" & Trim(Datos(3)) & "', "                          'Nombre Cliente
      Sql = Sql & "'" & Trim(Datos(4)) & "', "                          'Fecha vencimiento
      Sql = Sql & Val(Datos(5)) & ", "                                  'Dias
      Sql = Sql & "'" & Trim(Datos(6)) & "', "                          'Moneda1
      Sql = Sql & "'" & Trim(Datos(7)) & "', "                          'Moneda2
      Sql = Sql & "'" & Trim(Datos(8)) & "', "                          'Moneda
      Sql = Sql & bacTranMontoSql(Val(Datos(9))) & ", "                 'Monto M/X
      Sql = Sql & bacTranMontoSql(Val(Datos(10))) & ", "                'T/C Final
      Sql = Sql & bacTranMontoSql(Val(Datos(11))) & ", "                'Mtofincnv
      Sql = Sql & "'" & Trim(Datos(12)) & "', "                         'Modalidad Cumplimiento
      Sql = Sql & "'" & Trim(Datos(13)) & "', "                         'Nombre Empresa
      Sql = Sql & "'" & Trim(Datos(14)) & "', "                         'Direccion
      Sql = Sql & "'" & Trim(Datos(15)) & "', "                         'Fecha Proceso
      Sql = Sql & Val(Datos(16))                                        'Codigo Producto
      Sql = Sql & " );"

      DB.Execute Sql

   Loop

   'tipo de reporte
   cCristal.ReportType = "MDB"

   'Orden de impresión del reporte
   cCristal.PEN_ImprimirReporte "bacopder", "(bacopder) Informe Cartera de Derivados " & Format$(gsBAC_Fecp, "dd/mm/yyyy")

   Set cCristal = Nothing

End Function

Function BacCarteraOperpos(xEnt As String)

   Dim Sql        As String
   Dim cCristal   As New clsCristal
   Dim Datos()
   Dim Diasres    As Integer

   'Limpieza de la tabla Access
   Sql = "DELETE FROM infcaropepos;"

   DB.Execute Sql

   'Llamando procedimiento almacenado
   Sql = "Execute sp_carteraoperpos " & 4 & "," & Val(xEnt)
   
   If SQL_Execute(Sql) > 0 Then
      MsgBox "Problemas al leer cartera de operaciones de posicion", vbCritical, "MENSAJE"
      Exit Function

   End If

   Do While SQL_Fetch(Datos()) = 0

      Sql = ""
      Sql = Sql & "INSERT INTO infcaropepos VALUES ( "
         
      Sql = Sql & "'" & Trim(Datos(1)) & "', "                          'Tipo Operacion
      Sql = Sql & bacTranMontoSql(Val(Datos(2))) & ", "                 'Numero Operacion
      Sql = Sql & "'" & Trim(Datos(3)) & "', "                          'Nombre Cliente
      Sql = Sql & "'" & Trim(Datos(4)) & "', "                          'fecha inicio
      Sql = Sql & "'" & Trim(Datos(5)) & "', "                          'Fecha Termino
      Sql = Sql & bacTranMontoSql(Val(Datos(6))) & ", "                 'Plazo
      Diasres = DateDiff("D", Datos(20), Datos(5))                      'Dias res
      Sql = Sql & Diasres & ", "
      Sql = Sql & bacTranMontoSql(Val(Datos(7))) & ", "                 'Monto USD Finales
      Sql = Sql & bacTranMontoSql(Val(Datos(8))) & ", "                 'Monto USD inicial
      Sql = Sql & bacTranMontoSql(Val(Datos(9))) & ", "                 'Tasa USD
      Sql = Sql & bacTranMontoSql(Val(Datos(10))) & ", "                'Tasa CNV
      Sql = Sql & bacTranMontoSql(Val(Datos(11))) & ", "                'Precio Spot
      Sql = Sql & bacTranMontoSql(Val(Datos(12))) & ", "                'Precio Futuro
      Sql = Sql & "'" & Trim(Datos(13)) & "', "                         'Moneda1
      Sql = Sql & "'" & Trim(Datos(14)) & "', "                         'Moneda2
      Sql = Sql & bacTranMontoSql(Val(Datos(15))) & ", "                'Monto Diferir en Dolares
      Sql = Sql & bacTranMontoSql(Val(Datos(16))) & ", "                'Devengo Acumulado
      Sql = Sql & bacTranMontoSql(Val(Datos(17))) & ", "                'valorizacion
      Sql = Sql & "'" & Trim(Datos(18)) & "', "                         'Empresa
      Sql = Sql & "'" & Trim(Datos(19)) & "', "                         'Direccion
      Sql = Sql & "'" & Trim(Datos(20)) & "', "                         'Fecha Proceso
      Sql = Sql & bacTranMontoSql(Val(Datos(21))) & ", "                'Observado
      Sql = Sql & bacTranMontoSql(Val(Datos(22))) & ", "                       'Valor UF
      Sql = Sql & "'" & Trim(Datos(23))
      Sql = Sql & "' );"

      DB.Execute Sql

   Loop

   'tipo de reporte
   cCristal.ReportType = "MDB"

   'Orden de impresión del reporte
   cCristal.PEN_ImprimirReporte "bacopepo", "(bacopepo) Informe cartera de de operaciones de posicion " & Format$(gsBAC_Fecp, "dd/mm/yyyy")

   Set cCristal = Nothing

End Function

Function BacCarteraOper1446(xEnt As String)

   Dim Sql        As String
   Dim cCristal   As New clsCristal
   Dim Datos()
   Dim Diasres    As Integer

   'Limpieza de la tabla Access
   Sql = "DELETE FROM infoper1446;"

   DB.Execute Sql

   'Llamando procedimiento almacenado
   Sql = "Execute sp_carteraoper1446 " & 5 & "," & Val(xEnt)

   If SQL_Execute(Sql) > 0 Then
      MsgBox "Problemas al leer cartera de operaciones 1446", vbCritical, "MENSAJE"
      Exit Function

   End If

   Do While SQL_Fetch(Datos()) = 0

      Sql = ""
      Sql = Sql & "INSERT INTO infoper1446 VALUES ( "
         
      Sql = Sql & "'" & Trim(Datos(1)) & "', "                          'Tipo Operacion
      Sql = Sql & bacTranMontoSql(Val(Datos(2))) & ", "                                 'Numero Operacion
      Sql = Sql & "'" & Trim(Datos(3)) & "', "                          'Nombre Cliente
      Sql = Sql & "'" & Trim(Datos(4)) & "', "                          'fecha inicio
      Sql = Sql & "'" & Trim(Datos(5)) & "', "                          'Fecha Termino
      Sql = Sql & bacTranMontoSql(Val(Datos(6))) & ", "                 'Plazo
      Diasres = DateDiff("D", Datos(16), Datos(5))                      'Dias res
      Sql = Sql & Diasres & ", "
      Sql = Sql & bacTranMontoSql(Val(Datos(7))) & ", "                 'Monto USD Finales
      Sql = Sql & bacTranMontoSql(Val(Datos(8))) & ", "                 'Monto USD inicial
      Sql = Sql & bacTranMontoSql(Val(Datos(9))) & ", "                  'Tasa USD
      Sql = Sql & bacTranMontoSql(Val(Datos(10))) & ", "                'Observado
      Sql = Sql & bacTranMontoSql(Val(Datos(11))) & ", "                'Monto a Diferir en Dolares
      Sql = Sql & bacTranMontoSql(Val(Datos(12))) & ", "                'Devengo Acumulado en Dolares
      Sql = Sql & bacTranMontoSql(Val(Datos(13))) & ", "                'valorizacion
      Sql = Sql & "'" & Trim(Datos(14)) & "', "                         'Nombre
      Sql = Sql & "'" & Trim(Datos(15)) & "', "                         'Direccion
      Sql = Sql & "'" & Trim(Datos(16)) & "', "                         'Fecha Proceso
      Sql = Sql & bacTranMontoSql(Val(Datos(17))) & ", "                'Valor Observado
      Sql = Sql & bacTranMontoSql(Val(Datos(18))) & ", "                      'Valor UF
      Sql = Sql & "'" & Trim(Datos(19))
      Sql = Sql & "');"
     
      DB.Execute Sql

   Loop

   'tipo de reporte
   cCristal.ReportType = "MDB"

   'Orden de impresión del reporte
   cCristal.PEN_ImprimirReporte "baco1446", "(baco1446) Informe cartera de de operaciones 1446 " & Format$(gsBAC_Fecp, "dd/mm/yyyy")

   Set cCristal = Nothing

End Function

Function BacCarteraArbitrajes(xEnt As String)

   Dim Sql        As String
   Dim cCristal   As New clsCristal
   Dim Datos()
   Dim Diasres    As Integer

   'Limpieza de la tabla Access
   'SQL = "DELETE FROM infcaarb;"
    Sql = "DELETE FROM infaarb;"

   DB.Execute Sql

   'Llamando procedimiento almacenado
   Sql = "Execute sp_carteraarbitrajes " & 2 & "," & Val(xEnt)
   
   If SQL_Execute(Sql) > 0 Then
      MsgBox "Problemas al leer cartera de arbitajes", vbCritical, "MENSAJE"
      Exit Function

   End If

   Do While SQL_Fetch(Datos()) = 0

      Sql = ""
  '    SQL = SQL & "INSERT INTO infcaarb VALUES ( "
       Sql = Sql & "INSERT INTO infaarb VALUES ( "
         
  '    Sql = Sql & bacTranMontoSql(Val(Datos(10))) & ", "                                  'Monto Clp Inicial
         
         
      Sql = Sql & "'" & Trim(Datos(1)) & "', "                          'Tipo Operacion
      Sql = Sql & Val(Datos(2)) & ", "                                  'Numero Operacion
      Sql = Sql & "'" & Trim(Datos(3)) & "', "                          'Nombre Cliente
      Sql = Sql & "'" & Trim(Datos(4)) & "', "                          'fecha inicio
      Sql = Sql & "'" & Trim(Datos(5)) & "', "                          'Fecha Termino
      Sql = Sql & Val(Datos(6)) & ", "                                  'Dias Cnt
      Sql = Sql & "'" & Trim(Datos(7)) & "', "                          'PRM
      Sql = Sql & bacTranMontoSql(Val(Datos(8))) & ", "                 'Tipo Cambio Inicio
      Sql = Sql & bacTranMontoSql(Val(Datos(9))) & ", "                 'Paridad Futura
      Sql = Sql & bacTranMontoSql(Val(Datos(10))) & ", "                'Tipo Cambio Valorizacion
      Sql = Sql & bacTranMontoSql(Val(Datos(11))) & ", "                'Paridad Valorizacion
      Sql = Sql & "'" & Trim(Datos(12)) & "', "                         'M/X Ope
      Sql = Sql & bacTranMontoSql(Val(Datos(13))) & ", "                'Monto Operacion
      Sql = Sql & "'" & Trim(Datos(14)) & "', "                         'M/X CNV
      Sql = Sql & bacTranMontoSql(Val(Datos(15))) & ", "                'Monto Conversion
      Sql = Sql & bacTranMontoSql(Val(Datos(16))) & ", "                'Valorizacion
      Sql = Sql & "'" & Trim(Datos(17)) & "', "                         'Modalidad
      Sql = Sql & "'" & Trim(Datos(18)) & "', "                         'Nombre Empresa
      Sql = Sql & "'" & Trim(Datos(19)) & "', "                         'Direccion
      Sql = Sql & "'" & Trim(Datos(20)) & "', "                         'Fecha Proceso
      Sql = Sql & bacTranMontoSql(Val(Datos(21))) & ", "                      'Observado
      Sql = Sql & "'" & Trim(Datos(22))
      Sql = Sql & "' );"

      DB.Execute Sql

   Loop

   'tipo de reporte
   cCristal.ReportType = "MDB"

   'Orden de impresión del reporte
   cCristal.PEN_ImprimirReporte "bacaarb", "(bacaarb) Informe cartera de arbitrajes" & Format$(gsBAC_Fecp, "dd/mm/yyyy")

   Set cCristal = Nothing

End Function

Function BacCarteravenSegInflacion(xEnt As String)

   Dim Sql        As String
   Dim cCristal   As New clsCristal
   Dim Datos()
   Dim Diasres    As Integer

   'Limpieza de la tabla Access
   Sql = "DELETE FROM infcarvsi;"

   DB.Execute Sql

   'Llamando procedimiento almacenado
   Sql = "Execute sp_carteravenfuturo " & 3 & "," & Val(xEnt)
   
   If SQL_Execute(Sql) > 0 Then
      MsgBox "Problemas al leer cartera de seguros de inflacion", vbCritical, "MENSAJE"
      Exit Function

   End If

   Do While SQL_Fetch(Datos()) = 0

      Sql = ""
      Sql = Sql & "INSERT INTO infcarvsi VALUES ( "
      Sql = Sql & "'" & Trim(Datos(1)) & "', "                          'Tipo Operacion
      Sql = Sql & Val(Datos(2)) & ", "                                  'Numero Operacion
      Sql = Sql & "'" & Trim(Datos(3)) & "', "                          'Nombre Cliente
      Sql = Sql & "'" & Trim(Datos(4)) & "', "                          'fecha inicio
      Sql = Sql & "'" & Trim(Datos(5)) & "', "                          'Fecha Termino
      Sql = Sql & Val(Datos(6)) & ", "                                  'Dias Cto
      Diasres = DateDiff("D", Datos(20), Datos(5))                      'Dias res
      Sql = Sql & Diasres & ", "
      Sql = Sql & "'" & Trim(Datos(7)) & "', "                          'Mon
      Sql = Sql & bacTranMontoSql(Val(Datos(8))) & ", "                 'Monto uf
      Sql = Sql & bacTranMontoSql(Val(Datos(9))) & ", "                 'Valor Uf Inicial
      Sql = Sql & bacTranMontoSql(Val(Datos(10))) & ", "                'Monto Clp Inicial
      Sql = Sql & "'" & Trim(Datos(11)) & "', "                         'M/N CNV
      Sql = Sql & bacTranMontoSql(Val(Datos(12))) & ", "                'Valor Uf Futuro
      Sql = Sql & bacTranMontoSql(Val(Datos(13))) & ", "                'Monto Clp Uf ini
      Sql = Sql & bacTranMontoSql(Val(Datos(14))) & ", "                'Valor a diferir
      Sql = Sql & bacTranMontoSql(Val(Datos(15))) & ", "                'Devengo Acumulado
      Sql = Sql & bacTranMontoSql(Val(Datos(16))) & ", "                'valorización
      Sql = Sql & "'" & Trim(Datos(17)) & "', "                         'Modalidad
      Sql = Sql & "'" & Trim(Datos(18)) & "', "                         'Nombre Empresa
      Sql = Sql & "'" & Trim(Datos(19)) & "', "                         'Direccion
      Sql = Sql & "'" & Trim(Datos(20)) & "' "                  'Fecha Proceso
      Sql = Sql & "," & bacTranMontoSql(Val(Datos(21))) & ", "        'Uf de Fecha Proceso
      Sql = Sql & "'" & Trim(Datos(22))
      Sql = Sql & "');"

      DB.Execute Sql

   Loop

   'tipo de reporte
   cCristal.ReportType = "MDB"

   'Orden de impresión del reporte
   cCristal.PEN_ImprimirReporte "bacarvsi", "(bacarvsi) Informe cartera de Seguros de Inflacion" & Format$(gsBAC_Fecp, "dd/mm/yyyy")

   Set cCristal = Nothing

End Function

Function BacCarteraComSegInflacion(xEnt As String)

   Dim Sql        As String
   Dim cCristal   As New clsCristal
   Dim Datos()
   Dim Diasres    As Integer

   'Limpieza de la tabla Access
   Sql = "DELETE FROM infcarcsi;"

   DB.Execute Sql

   'Llamando procedimiento almacenado
   Sql = "Execute sp_carteracomfuturo " & 3 & "," & Val(xEnt)
   
   If SQL_Execute(Sql) > 0 Then
      MsgBox "Problemas al leer cartera de seguros de inflacion", vbCritical, "MENSAJE"
      Exit Function

   End If
    

   Do While SQL_Fetch(Datos()) = 0
      Sql = ""
      Sql = Sql & "INSERT INTO infcarcsi VALUES ( "
 
      Sql = Sql & "'" & Trim(Datos(1)) & "', "                  'Tipo Operacion
      Sql = Sql & Val(Datos(2)) & ", "                          'Numero Operacion
      Sql = Sql & "'" & Trim(Datos(3)) & "', "                  'Nombre Cliente
      Sql = Sql & "'" & Trim(Datos(4)) & "', "                  'fecha inicio
      Sql = Sql & "'" & Trim(Datos(5)) & "', "                  'Fecha Termino
      Sql = Sql & Val(Datos(6)) & ", "                          'Dias Cto
      Diasres = DateDiff("D", Datos(20), Datos(5))              ' Dias res
      Sql = Sql & Diasres & ", "
      Sql = Sql & "'" & Trim(Datos(7)) & "', "                  'Mon
      Sql = Sql & bacTranMontoSql(Val(Datos(8))) & ", "         'Monto uf
      Sql = Sql & bacTranMontoSql(Val(Datos(9))) & ", "         'Valor Uf Inicial
      Sql = Sql & bacTranMontoSql(Val(Datos(10))) & ", "        'Monto Clp Inicial
      Sql = Sql & "'" & Trim(Datos(11)) & "', "                 'M/N CNV
      Sql = Sql & bacTranMontoSql(Val(Datos(12))) & ", "        'Valor Uf Final
      Sql = Sql & bacTranMontoSql(Val(Datos(13))) & ", "        'Monto Clp Uf Fwd
      Sql = Sql & bacTranMontoSql(Val(Datos(14))) & ", "        'Valor a diferir
      Sql = Sql & bacTranMontoSql(Val(Datos(15))) & ", "        'Devengo Acumulado
      Sql = Sql & bacTranMontoSql(Val(Datos(16))) & ", "        'valorización
      Sql = Sql & "'" & Trim(Datos(17)) & "', "                 'Modalidad
      Sql = Sql & "'" & Trim(Datos(18)) & "', "                 'Nombre Empresa
      Sql = Sql & "'" & Trim(Datos(19)) & "', "                 'Direccion
      Sql = Sql & "'" & Trim(Datos(20)) & "' "                  'Fecha Proceso
      Sql = Sql & "," & bacTranMontoSql(Val(Datos(21))) & ", "        'Uf de Fecha Proceso
      Sql = Sql & "'" & Trim(Datos(22))
      Sql = Sql & "');"

      DB.Execute Sql

   Loop

   'tipo de reporte
   cCristal.ReportType = "MDB"

   'Orden de impresión del reporte
   cCristal.PEN_ImprimirReporte "bacarcsi", "(bacarcsi) Informe cartera de Seguros de Inflacion" & Format$(gsBAC_Fecp, "dd/mm/yyyy")

   Set cCristal = Nothing

End Function

Function BacLeeSegurosCambio(xEnt As String)

   Dim Sql        As String
   Dim cCristal   As New clsCristal
   Dim Datos()

   'Limpieza de la tabla Access
   Sql = "DELETE FROM incaseca2;"

   DB.Execute Sql

   'Llamando procedimiento almacenado
   Sql = "Execute sp_caseca2 " & 1 & "," & Val(xEnt)
   
   If SQL_Execute(Sql) <> 0 Then
      MsgBox "Problemas al leer cartera de ventas seguros de cambio", vbCritical, "MENSAJE"
      Exit Function

   End If

   Do While SQL_Fetch(Datos()) = 0

      Sql = ""
      Sql = Sql & "INSERT INTO incaseca2 VALUES ( "
      Sql = Sql & Val(Datos(1)) & ", "                                  'Numero
      Sql = Sql & "'" & Trim(Datos(2)) & "', "                          'Operacion
      Sql = Sql & "'" & Trim(Datos(3)) & "', "                          'Cliente
      Sql = Sql & "'" & Trim(Datos(4)) & "', "                          'fecha inicio
      Sql = Sql & "'" & Trim(Datos(5)) & "', "                          'Fecha Termino
      Sql = Sql & "'" & Trim(Datos(6)) & "', "                          'M/X
      Sql = Sql & bacTranMontoSql(Val(Datos(7))) & ", "                 'MTO M/X Comprada
      Sql = Sql & "'" & Trim(Datos(8)) & "', "                          'Moneda
      Sql = Sql & bacTranMontoSql(Val(Datos(9))) & ", "                 'Punta ventas
      Sql = Sql & bacTranMontoSql(Val(Datos(10))) & ", "                'Mto CLP Inicial T/C
      Sql = Sql & "'" & Trim(Datos(11)) & "', "                         'M/N CNV
      Sql = Sql & bacTranMontoSql(Val(Datos(12))) & ", "                'T/C Inicial
      Sql = Sql & bacTranMontoSql(Val(Datos(13))) & ", "                'Monto CLP
      Sql = Sql & bacTranMontoSql(Val(Datos(14))) & ", "                'Mto CLP UF Inicial
      Sql = Sql & bacTranMontoSql(Val(Datos(15))) & ", "                'Valor a Diferir
      Sql = Sql & bacTranMontoSql(Val(Datos(16))) & ", "                'Devengo Acumulado
      Sql = Sql & bacTranMontoSql(Val(Datos(17))) & ", "                'Ajuste Variacion UF
      Sql = Sql & bacTranMontoSql(Val(Datos(18))) & ", "                'Valorizacion
      Sql = Sql & "'" & Trim(Datos(19)) & "', "                         'M
      Sql = Sql & bacTranMontoSql(Val(Datos(20))) & ", "                'Tasa
      Sql = Sql & bacTranMontoSql(Val(Datos(21))) & ", "                'Nº Dias
      Sql = Sql & bacTranMontoSql(Val(Datos(22))) & ", "                'Dias Residuales
      Sql = Sql & bacTranMontoSql(Val(Datos(23))) & ", "                'Precio Equilibrio
      Sql = Sql & "'" & Trim(Datos(24)) & "', "                         'Fecha Proceso
      Sql = Sql & "'" & Trim(Datos(25)) & "', "                         'Nombre Empresa
      Sql = Sql & "'" & Trim(Datos(26)) & "', "                         'Direccion Empresa
      Sql = Sql & bacTranMontoSql(Val(Datos(27))) & ", "                'Valor UF
      Sql = Sql & bacTranMontoSql(Val(Datos(28))) & ", "                       'Valor Observado
      Sql = Sql & "'" & Datos(29)
      Sql = Sql & "');"

      DB.Execute Sql

   Loop

   'tipo de reporte
   cCristal.ReportType = "MDB"

   'Orden de impresión del reporte
   cCristal.PEN_ImprimirReporte "bacsgvta", "(bacsgvta) Informe de Cartera de Venta Seguros de Cambio" & Format$(gsBAC_Fecp, "dd/mm/yyyy")

   Set cCristal = Nothing


End Function

Function BacLeeCarteraSegurosCambio(xEnt As String)
   Dim Sql        As String
   Dim cCristal   As New clsCristal
   Dim Datos()

   'Limpieza de la tabla Access
   Sql = "DELETE FROM cainseca;"

   DB.Execute Sql

   'Llamando procedimiento almacenado
   Sql = "Execute sp_incaseca " & 1 & "," & Val(xEnt)
   
   If SQL_Execute(Sql) <> 0 Then
      MsgBox "Problemas al leer cartera de seguros de cambio", vbCritical, "MENSAJE"
      Exit Function

   End If

   Do While SQL_Fetch(Datos()) = 0

      Sql = ""
      Sql = Sql & "INSERT INTO cainseca VALUES ( "
      Sql = Sql & "'" & IIf(Trim(Datos(2)) = "", ".", Trim(Datos(2))) & "', "            'Operacion
      Sql = Sql & "'" & IIf(Trim(Datos(3)) = "", ".", Trim(Datos(3))) & "', "            'Cliente
      Sql = Sql & "'" & IIf(Trim(Datos(4)) = "", ".", Trim(Datos(4))) & "', "            'fecha inicio
      Sql = Sql & "'" & IIf(Trim(Datos(5)) = "", ".", Trim(Datos(5))) & "', "            'Fecha Termino
      Sql = Sql & "'" & IIf(Trim(Datos(6)) = "", ".", Trim(Datos(6))) & "', "            'M/X
      Sql = Sql & bacTranMontoSql(Val(Datos(7))) & ", "                                  'MTO M/X Comprada
      Sql = Sql & "'" & IIf(Trim(Datos(8)) = "", ".", Trim(Datos(8))) & "', "            'Moneda
      Sql = Sql & bacTranMontoSql(Val(Datos(9))) & ", "                                  'Punta Compra
      Sql = Sql & bacTranMontoSql(Val(Datos(10))) & ", "                                 'Mto CLP Inicial T/C
      Sql = Sql & "'" & IIf(Trim(Datos(11)) = "", ".", Trim(Datos(11))) & "', "          'M/N CNV
      Sql = Sql & bacTranMontoSql(Val(Datos(12))) & ", "                                 'T/C Inicial
      Sql = Sql & bacTranMontoSql(Val(Datos(13))) & ", "                                 'Monto CLP
      Sql = Sql & bacTranMontoSql(Val(Datos(14))) & ", "                                 'Mto CLP UF Inicial
      Sql = Sql & bacTranMontoSql(Val(Datos(15))) & ", "                                 'Valor a Diferir
      Sql = Sql & bacTranMontoSql(Val(Datos(16))) & ", "                                 'Devengo Acumulado
      Sql = Sql & bacTranMontoSql(Val(Datos(17))) & ", "                                 'Ajuste Variacion UF
      Sql = Sql & bacTranMontoSql(Val(Datos(18))) & ", "                                 'Valorizacion
      Sql = Sql & "'" & IIf(Trim(Datos(19)) = "", ".", Trim(Datos(19))) & "', "          'M
      Sql = Sql & bacTranMontoSql(Val(Datos(20))) & ", "                                 'Tasa
      Sql = Sql & bacTranMontoSql(Val(Datos(21))) & ", "                                 'Nº Dias
      Sql = Sql & bacTranMontoSql(Val(Datos(22))) & ", "                                 'Dias Residuales
      Sql = Sql & bacTranMontoSql(Val(Datos(23))) & ", "                                 'Precio Equilibrio
      Sql = Sql & "'" & IIf(Trim(Datos(24)) = "", ".", Trim(Datos(24))) & "', "          'Fecha Proceso
      Sql = Sql & "'" & IIf(Trim(Datos(25)) = "", ".", Trim(Datos(25))) & "', "          'Nombre Empresa
      Sql = Sql & "'" & IIf(Trim(Datos(26)) = "", ".", Trim(Datos(26))) & "', "          'Direccion Empresa
      Sql = Sql & bacTranMontoSql(Val(Datos(27))) & ", "                                 'Valor UF
      Sql = Sql & bacTranMontoSql(Val(Datos(28))) & ", "                                 'Valor Observado
      Sql = Sql & Val(Datos(1)) & ","                                                          'Numero
      Sql = Sql & "'" & Trim(Datos(29))                                                                      ' Entidad
      Sql = Sql & "' );"

      DB.Execute Sql

   Loop

   'tipo de reporte
   cCristal.ReportType = "MDB"

   'Orden de impresión del reporte
   cCristal.PEN_ImprimirReporte "bacsgcom", "(bacsgcom) Informe de cartera de  Seguros de cambio" & Format$(gsBAC_Fecp, "dd/mm/yyyy")

   Set cCristal = Nothing

End Function

Function BacLeeOperacionDescalce()

   Dim Sql        As String
   Dim cCristal   As New clsCristal
   Dim Datos()

   'Limpieza de la tabla Access
   Sql = "DELETE FROM infdescalces;"

   DB.Execute Sql

   'Llamando procedimiento almacenado
   Sql = "Execute sp_descalceoperaciones"
   
   If SQL_Execute(Sql) > 0 Then
      MsgBox "Problemas al leer operaciones de descalces", vbCritical, "MENSAJE"
      Exit Function

   End If

   Do While SQL_Fetch(Datos()) = 0
   
      
      Sql = ""
      Sql = Sql & "INSERT INTO infdescalces VALUES ( "
         
      Sql = Sql & bacTranMontoSql(Datos(1)) & ", "                              'Numero Operacion Compra
      Sql = Sql & "'" & IIf(Datos(2) = "", ".", Trim(Datos(2))) & "', "         'Nombre Cliente Compra
      Sql = Sql & "'" & IIf(Datos(3) = "", ".", Trim(Datos(3))) & "', "         'Tipo Operacion Compra
      Sql = Sql & "'" & IIf(Datos(4) = "", ".", Trim(Datos(4))) & "', "         'Fecha Vencimiento
      Sql = Sql & bacTranMontoSql(Datos(5)) & ", "                              'Monto
      Sql = Sql & "'" & IIf(Datos(6) = "", ".", Trim(Datos(6))) & "', "         'Glosa
      Sql = Sql & bacTranMontoSql(Datos(7)) & ", "                              'Precio Compra
      Sql = Sql & bacTranMontoSql(Datos(8)) & ", "                              'Saldo
      Sql = Sql & "'" & IIf(Datos(9) = "", ".", Trim(Datos(9))) & "', "         'Fecha Compra
      Sql = Sql & "'" & IIf(Datos(10) = "", ".", Trim(Datos(10))) & "', "       'Fecha Proceso
      Sql = Sql & "'" & IIf(Datos(11) = "", ".", Trim(Datos(11))) & "', "       'Nombre Empresa
      Sql = Sql & "'" & IIf(Datos(12) = "", ".", Trim(Datos(12))) & "', "       'Direccion Empresa
      Sql = Sql & bacTranMontoSql(Datos(13)) & ", "                             'Numero Operacion Venta
      Sql = Sql & "'" & IIf(Datos(14) = "", ".", Trim(Datos(14))) & "', "       'Nombre Cliente Venta
      Sql = Sql & "'" & IIf(Datos(15) = "", ".", Trim(Datos(15))) & "', "       'Tipo Operacion Venta
      Sql = Sql & bacTranMontoSql(Datos(16)) & ", "                             'Precio Venta
      Sql = Sql & "'" & IIf(Datos(17) = "", ".", Trim(Datos(17))) & "', "       'Fecha Venta
      Sql = Sql & bacTranMontoSql(Datos(18)) & ", "                             'Monto Venta
      Sql = Sql & bacTranMontoSql(Datos(19)) & ", "                             'saldo Venta
      Sql = Sql & "'" & IIf(Datos(20) = "", ".", Trim(Datos(20))) & "', "       'Glosa venta
      Sql = Sql & "'" & IIf(Datos(21) = "", ".", Trim(Datos(21))) & "' "        'Fecha Vencimiento Venta
      Sql = Sql & " );"

      DB.Execute Sql

   Loop

   'tipo de reporte
   cCristal.ReportType = "MDB"

   'Orden de impresión del reporte
   cCristal.PEN_ImprimirReporte "bacdcal", "(bacdcal)  operaciones de descalces " & Format$(gsBAC_Fecp, "dd/mm/yyyy")

   Set cCristal = Nothing

End Function

Function BacLeeOperacionCalce()

   Dim Sql        As String
   Dim cCristal   As New clsCristal
   Dim Datos()

   'Limpieza de la tabla Access
   Sql = "DELETE FROM infcales;"

   DB.Execute Sql

   'Llamando procedimiento almacenado
   Sql = "Execute sp_mfccleercalces"
   
   If SQL_Execute(Sql) > 0 Then
      MsgBox "Problemas al leer operaciones de calces", vbCritical, "MENSAJE"
      Exit Function

   End If

   Do While SQL_Fetch(Datos()) = 0
   
 
      Sql = ""
      Sql = Sql & "INSERT INTO infcales VALUES ( "

      Sql = Sql & "'" & Trim(Datos(1)) & "', "              'Fecha Vencimiento
      Sql = Sql & bacTranMontoSql(Datos(2)) & ", "          'Numero Operacion CMP
      Sql = Sql & bacTranMontoSql(Datos(3)) & ", "          'Numero Operacion VTA
      Sql = Sql & "'" & Trim(Datos(4)) & "', "              'Nombre Cliente CMP
      Sql = Sql & "'" & Trim(Datos(5)) & "', "              'Nombre Cliente VTA
      Sql = Sql & "'" & Trim(Datos(6)) & "', "              'Tipo Calces CMP
      Sql = Sql & "'" & Trim(Datos(7)) & "', "              'Tipo Calces VTA
      Sql = Sql & bacTranMontoSql(Datos(8)) & ", "          'Futuros
      Sql = Sql & bacTranMontoSql(Datos(9)) & ", "          'Precio CMP
      Sql = Sql & bacTranMontoSql(Datos(10)) & ", "         'Precio VTA
      Sql = Sql & "'" & Trim(Datos(11)) & "', "             'Tipo Operacion CMP
      Sql = Sql & "'" & Trim(Datos(12)) & "', "             'Tipo Operacion VTA
      Sql = Sql & "'" & Trim(Datos(13)) & "', "             'Nombre Empresa
      Sql = Sql & "'" & Trim(Datos(14)) & "', "             'Direccion Empresa
      Sql = Sql & "'" & Trim(Datos(15)) & "', "              'Fecha Proceso
      Sql = Sql & "'" & Trim(Datos(16)) & "', "              'Fecha Compra
      Sql = Sql & "'" & Trim(Datos(17)) & "' "              'Fecha Venta
      Sql = Sql & " );"

      DB.Execute Sql

   Loop
 
   'tipo de reporte
   cCristal.ReportType = "MDB"

   'Orden de impresión del reporte
   cCristal.PEN_ImprimirReporte "baccalce", "(baccalce)  operaciones de  calces " & Format$(gsBAC_Fecp, "dd/mm/yyyy")

   Set cCristal = Nothing

End Function

Function BacMovFuturoUF(xEnt As String)

   Dim Sql        As String
   Dim cCristal   As New clsCristal
   Dim Datos()

   'Limpieza de la tabla Access
   Sql = "DELETE FROM infseginf;"

   DB.Execute Sql

   'Llamando procedimiento almacenado
   Sql = "Execute sp_leeinfseginf " & 3 & "," & Val(xEnt)
   
   If SQL_Execute(Sql) > 0 Then
      MsgBox "Problemas al leer operaciones de seguros de inflacion", vbCritical, "MENSAJE"
      Exit Function

   End If

   Do While SQL_Fetch(Datos()) = 0

      Sql = ""
      Sql = Sql & "INSERT INTO infseginf VALUES ( "
      Sql = Sql & Val(Datos(1)) & ", "                                  'Numero Contrato
      Sql = Sql & Val(Datos(2)) & ", "                                  'Rut Cliente
      Sql = Sql & "'" & Trim(Datos(3)) & "', "                          'Digito Verificador
      Sql = Sql & "'" & Trim(Datos(4)) & "', "                          'Nombre Cliente
      Sql = Sql & "'" & Trim(Datos(5)) & "', "                          'fecha inicio
      Sql = Sql & "'" & Trim(Datos(6)) & "', "                          'Fecha Termino
      Sql = Sql & Val(Datos(7)) & ", "                                  'Dias
      Sql = Sql & "'" & Trim(Datos(8)) & "', "                          'Moneda M/X
      Sql = Sql & bacTranMontoSql(Val(Datos(9))) & ", "                 'Monto M/X
      Sql = Sql & "'" & Trim(Datos(10)) & "',"                          'M/N CNV
      Sql = Sql & bacTranMontoSql(Val(Datos(11))) & ", "                'Precio
      Sql = Sql & bacTranMontoSql(Val(Datos(12))) & ", "                'Monto Final
      Sql = Sql & "'" & Trim(Datos(13)) & "', "                         'mod.cumplimiento
      Sql = Sql & "'" & Trim(Datos(14)) & "', "                         'Pago M/N
      Sql = Sql & "'" & Trim(Datos(15)) & "', "                         'Pago M/X
      Sql = Sql & "'" & Trim(Datos(16)) & "', "                         'Nombre Empresa
      Sql = Sql & "'" & Trim(Datos(17)) & "', "                         'Tipo de Operacion
      Sql = Sql & bacTranMontoSql(Val(Datos(18))) & ", "                'Tasa Compra
      Sql = Sql & bacTranMontoSql(Val(Datos(19))) & ", "                'Tasa Venta
      Sql = Sql & bacTranMontoSql(Val(Datos(20))) & ", "                'Spread
      Sql = Sql & "'" & Trim(Datos(21)) & "', "                         'Direccion
      Sql = Sql & "'" & Trim(Datos(22)) & "', "                          'Fecha Proceso
      Sql = Sql & "'" & Trim(Datos(23)) & "' "
      Sql = Sql & " );"

      DB.Execute Sql

   Loop

   'tipo de reporte
   cCristal.ReportType = "MDB"

   'Orden de impresión del reporte
   cCristal.PEN_ImprimirReporte "bacmovsi", "(bacmovsi) Informe Diario de Seguros de Inflacion" & Format$(gsBAC_Fecp, "dd/mm/yyyy")

   Set cCristal = Nothing

End Function

Function BacMovArbitrajeFut(xEnt As String)

   Dim Sql        As String
   Dim cCristal   As New clsCristal
   Dim Datos()

   'Limpieza de la tabla Access
   Sql = "DELETE FROM infarb;"

   DB.Execute Sql

   'Llamando procedimiento almacenado
   Sql = "Execute sp_leeinfarb " & 2 & "," & Val(xEnt)

   If SQL_Execute(Sql) > 0 Then
      MsgBox "Problemas al leer operaciones de arbitraje", vbCritical, "MENSAJE"
      Exit Function

   End If

   Do While SQL_Fetch(Datos()) = 0

      Sql = ""
      Sql = Sql & "INSERT INTO infarb VALUES ( "
         
      Sql = Sql & Val(Datos(1)) & ", "                                  'Numero Contrato
      Sql = Sql & "'" & Trim(Datos(2)) & "', "                                  'Rut Cliente      SQL = SQL & "'" & Trim(Datos(3)) & "', "                          'Nombre Cliente
      Sql = Sql & "'" & Datos(3) & "', "                                'fecha inicio
      Sql = Sql & "'" & Datos(4) & "', "                                'Fecha Termino
      Sql = Sql & Val(Datos(5)) & ", "                                  'Dias
      Sql = Sql & "'" & Trim(Datos(6)) & "', "                          'M/X
      Sql = Sql & bacTranMontoSql(Val(Datos(7))) & ", "                                  'Monto M/X
      Sql = Sql & bacTranMontoSql(Val(Datos(8))) & ", "                                  'Paridad Futuro
      Sql = Sql & "'" & Trim(Datos(9)) & "', "                          'CNV
      Sql = Sql & bacTranMontoSql(Val(Datos(10))) & ", "                                 'Monto Final
      Sql = Sql & bacTranMontoSql(Val(Datos(11))) & ", "                                 'Paridad Spot Compra
      Sql = Sql & "'" & Trim(Datos(12)) & "', "                          'PRM
      Sql = Sql & bacTranMontoSql(Val(Datos(13))) & ", "                                 'TC Inicial compra
      Sql = Sql & "'" & Trim(Datos(14)) & "', "                         'Modalidad Cumplimiento
      Sql = Sql & "'" & Trim(Datos(15)) & "', "                         'Pago M/X
      Sql = Sql & "'" & Trim(Datos(16)) & "', "                         'Pago M/N
      Sql = Sql & "'" & Trim(Datos(17)) & "', "                         'Nombre Empresa
      Sql = Sql & "'" & Trim(Datos(18)) & "', "                         'Tipo de Operacion
      Sql = Sql & "'" & Trim(Datos(19)) & "', "                         'Direccion
      Sql = Sql & "'" & Datos(20) & "',"                            'Fecha de Proceso
      Sql = Sql & "'" & Datos(21) & "'"
      Sql = Sql & " );"

      DB.Execute Sql

   Loop

   'tipo de reporte
   cCristal.ReportType = "MDB"

   'Orden de impresión del reporte
   cCristal.PEN_ImprimirReporte "bacmovar", "(bacmovar) Informe Diario de arbitraje" & Format$(gsBAC_Fecp, "dd/mm/yyyy")

   Set cCristal = Nothing

End Function

Function BacMovDiaSegCam(xEnt As String)

   Dim Sql        As String
   Dim cCristal   As New clsCristal
   Dim Datos()

   'Limpieza de la tabla Access
   Sql = "DELETE FROM infsegcam;"

   DB.Execute Sql

   'Llamando procedimiento almacenado
   Sql = "Execute sp_leeinfsegcam " & 1 & "," & Val(xEnt)
   
   If SQL_Execute(Sql) > 0 Then
      MsgBox "Problemas al leer operaciones de seguros de cambio", vbCritical, "MENSAJE"
      Exit Function

   End If
    
   Do While SQL_Fetch(Datos()) = 0

      Sql = ""
      Sql = Sql & "INSERT INTO infsegcam VALUES ( "
      Sql = Sql & Val(Datos(1)) & ", "                                  'Numero Contrato
      Sql = Sql & Val(Datos(2)) & ", "                                  'Rut Cliente
      Sql = Sql & "'" & Trim(Datos(3)) & "', "                          'Digito Verificador
      Sql = Sql & "'" & Trim(Datos(4)) & "', "                          'Nombre Cliente
      Sql = Sql & "'" & Datos(5) & "', "                                'fecha inicio
      Sql = Sql & "'" & Datos(6) & "', "                                'Fecha Termino
      Sql = Sql & Val(Datos(7)) & ", "                                  'Dias
      Sql = Sql & "'" & Trim(Datos(8)) & "', "                          'Moneda
      Sql = Sql & "'" & Trim(Datos(9)) & "', "                          'M/X
      Sql = Sql & bacTranMontoSql(Val(Datos(10))) & ", "                'Monto M/X
      Sql = Sql & "'" & Trim(Datos(11)) & "',"                          'M/N CNV
      Sql = Sql & bacTranMontoSql(Val(Datos(12))) & ", "                'Precio
      Sql = Sql & bacTranMontoSql(Val(Datos(13))) & ", "                'T/C Final
      Sql = Sql & bacTranMontoSql(Val(Datos(14))) & ", "                'Monto Final
      Sql = Sql & "'" & Trim(Datos(15)) & "', "                         'mod.cumplimiento
      Sql = Sql & "'" & Trim(Datos(16)) & "', "                         'Pago M/N
      Sql = Sql & "'" & Trim(Datos(17)) & "', "                         'Pago M/X
      Sql = Sql & "'" & Trim(Datos(18)) & "', "                         'Nombre Empresa
      Sql = Sql & "'" & Trim(Datos(19)) & "', "                         'Tipo de Operacion
      Sql = Sql & bacTranMontoSql(Val(Datos(20))) & ", "               'Spread
      Sql = Sql & "'" & Trim(Datos(21)) & "', "                         'Direccion
      Sql = Sql & "'" & Trim(Datos(22)) & "', "                          'Fecha Proceso
      Sql = Sql & "'" & Trim(Datos(23)) & "' "
      Sql = Sql & " );"

      DB.Execute Sql

   Loop

   'tipo de reporte
   cCristal.ReportType = "MDB"

   'Orden de impresión del reporte
   cCristal.PEN_ImprimirReporte "bacmovsg", "(bacmovsg) Informe Diario de Seguros de Cambio" & Format$(gsBAC_Fecp, "dd/mm/yyyy")

   Set cCristal = Nothing

End Function


Function BacOpeAnuSegCam(Fecanu As Date)
Dim Sql        As String
Dim cCristal   As New clsCristal
Dim Datos()
 
   'Limpieza de la tabla Access
   Sql = "DELETE FROM infanusegcam;"

   DB.Execute Sql

   'Llamando procedimiento almacenado
   Sql = "Execute sp_infopeanusegcam '" & Format$(Fecanu, "yyyymmdd") & "'"
   
   If SQL_Execute(Sql) > 0 Then
      MsgBox "Problemas al leer operaciones de seguros de cambio", vbCritical, "MENSAJE"
      Exit Function

   End If
    
   Do While SQL_Fetch(Datos()) = 0

      Sql = ""
      Sql = Sql & "INSERT INTO infanusegcam VALUES ( "
      Sql = Sql & Val(Datos(1)) & ", "                                                          'Numero Contrato
      Sql = Sql & "'" & Trim(Datos(2)) & "', "                                                   'Nombre Cliente
      Sql = Sql & "'" & Trim(Datos(3)) & "', "                                                  'Tipo de Operación
      Sql = Sql & Val(Datos(4)) & ", "                                                         'Plazo
      Sql = Sql & "'" & Datos(5) & "', "                                                        'Fecha Vencimiento
      Sql = Sql & "'" & Trim(Datos(6)) & "', "                                                  'Moneda
      Sql = Sql & bacTranMontoSql(CDbl(Datos(7))) & ", "                                        'Monto M/X
      Sql = Sql & bacTranMontoSql(CDbl(Datos(8))) & ", "                                        'Precio
      Sql = Sql & bacTranMontoSql(CDbl(Datos(9))) & ", "                                        'T/C Final
      Sql = Sql & bacTranMontoSql(CDbl(Datos(10))) & ", "                                       'Monto Final
      Sql = Sql & "'" & IIf(Trim(Datos(11)) = "C", "COMPENSACIÓN", "ENTREGA FÍSICA") & "', "    'Modalidad
      Sql = Sql & "'" & Trim(Datos(12)) & "', "                                                 'Pago M/N
      Sql = Sql & "'" & Trim(Datos(13)) & "', "                                                 'Pago M/X
      Sql = Sql & "'" & Trim(Datos(14)) & "', "                                                 'Operador
      Sql = Sql & "'" & Datos(15) & "', "                                                       'Nombre propietario
      Sql = Sql & "'" & Datos(16) & "', "                                                       'Dirección propietario
      Sql = Sql & "'" & "bacanusc.rpt" & "', "                                                  'Nombre reporte
      Sql = Sql & "'" & Datos(17) & "',"                                                        'Fecha de proceso
      Sql = Sql & "'" & Datos(18) & "',"                                                        'Moneda 1
      Sql = Sql & "'" & Datos(19) & "'"                                                         'Moneda 2
      Sql = Sql & " );"
      
      DB.Execute Sql

   Loop
   
   'tipo de reporte
   cCristal.ReportType = "MDB"

   'Orden de impresión del reporte
   cCristal.PEN_ImprimirReporte "bacanusc", "(bacanusc) Informe Operaciones Anuladas Seguro de Cambio " & Format$(Fecanu, "dd/mm/yyyy")

   Set cCristal = Nothing
 
End Function
Function BacOpeMTM()
   Dim Sql        As String
   Dim cCristal   As New clsCristal
   Dim Datos()

   'Limpieza de la tabla Access
   Sql = "DELETE FROM bacMTM;"

   DB.Execute Sql

   'Llamando procedimiento almacenado
   Sql = "Execute sp_caroperacionesmtm "
   
   If SQL_Execute(Sql) > 0 Then
      MsgBox "Problemas al leer operaciones Mark to Market", vbCritical, "MENSAJE"
      Exit Function

   End If

   Do While SQL_Fetch(Datos()) = 0

      Sql = ""
      Sql = Sql & "INSERT INTO bacMTM VALUES ( "
      Sql = Sql & Val(Datos(1)) & ", "                                  'Numero Contrato
      Sql = Sql & "'" & Trim(Datos(2)) & "', "                          'Nombre Cliente
      Sql = Sql & "'" & Trim(Datos(3)) & "', "                          'Tipo de Operacion
      Sql = Sql & "'" & Trim(Datos(4)) & "', "                          'Fecha Vcto
      Sql = Sql & "'" & Trim(Datos(5)) & "', "                          'Moneda
      Sql = Sql & bacTranMontoSql(Val(Datos(6))) & ", "                 'Monto USD
      Sql = Sql & "'" & Trim(Datos(7)) & "', "                          'Fecha Inicio
      Sql = Sql & Val(Datos(8)) & ", "                                  'Plazo Residual
      Sql = Sql & bacTranMontoSql(Val(Datos(9))) & ", "                 'Precio Futuro
      Sql = Sql & bacTranMontoSql(Val(Datos(10))) & ", "                'Monto MTM
      Sql = Sql & bacTranMontoSql(Val(Datos(11))) & ", "                'Precio FWD
      Sql = Sql & "'" & Trim(Datos(12)) & "', "                         'Fecha Proceso
      Sql = Sql & "'" & Trim(Datos(13)) & "', "                         'Nombre Empresa
      Sql = Sql & "'" & Trim(Datos(14)) & "',"                           'Direccion
      Sql = Sql & bacTranMontoSql(Val(Datos(15))) & ", "                'Monto Cnv
      Sql = Sql & bacTranMontoSql(Val(Datos(16))) & ", "                'Dolar Observado
      Sql = Sql & bacTranMontoSql(Val(Datos(17)))                       'Valor Uf
      Sql = Sql & " );"

      DB.Execute Sql

   Loop

   'tipo de reporte
    cCristal.ReportType = "MDB"

   'Orden de impresión del reporte
   cCristal.PEN_ImprimirReporte "BacOpMTM", "(BacOpMTM) Informe de Operaciones Mark to Market" & Format$(gsBAC_Fecp, "dd/mm/yyyy")

   Set cCristal = Nothing

End Function
Function BacLeeCapituloVII_1(cFecha As String)
   Dim Sql        As String
   Dim cCristal   As New clsCristal
   Dim Datos()
   Dim nConta1    As Integer
   Dim nConta2    As Integer
   
   nConta1 = 0
   nConta2 = 1
   
   'Limpieza de la tabla Access
   Sql = "DELETE FROM infcap7_1;"

   DB.Execute Sql

   'Llamando procedimiento almacenado
   Sql = "Execute sp_capvii '" & Format$(cFecha, "YYYYMMDD") & "',"
   Sql = Sql & Bac_Apoderados.Txt_Rut1 & ","
   Sql = Sql & Bac_Apoderados.Txt_Rut2
   
   If SQL_Execute(Sql) > 0 Then
      MsgBox "Problemas al leer operaciones para capitulo VII anexo 1", vbCritical, "MENSAJE"
      Exit Function
   End If

   Do While SQL_Fetch(Datos()) = 0
   
        nConta1 = nConta1 + 1
        
        If nConta1 > 15 Then
           nConta1 = 1
           nConta2 = nConta2 + 1
           
        End If
      
        Sql = ""
        Sql = Sql & "INSERT INTO infcap7_1 VALUES ( "
        Sql = Sql & "'" & Trim(Datos(1)) & "', "        ' Tipo de Operación
        Sql = Sql & bacTranMontoSql(Datos(2)) & ", "    ' Número de Operación
        Sql = Sql & bacTranMontoSql(Datos(3)) & ", "    ' Rut Cliente
        Sql = Sql & "'" & Trim(Datos(5)) & "', "        ' Nombre Cliente
        Sql = Sql & "'" & Trim(Datos(6)) & "', "        ' Fecha de inicio
        Sql = Sql & "'" & Trim(Datos(7)) & "', "        ' Fecha de Término
        Sql = Sql & bacTranMontoSql(Datos(8)) & ", "    ' Moneda Comprada
        Sql = Sql & "'" & Trim(Datos(9)) & "', "        ' NemoTecnico Moneda Comprada
        Sql = Sql & bacTranMontoSql(Datos(10)) & ", "   ' Monto Comprado
        Sql = Sql & "'" & Trim(Datos(11)) & "', "       ' Moneda Venta
        Sql = Sql & "'" & Trim(Datos(12)) & "', "       ' NemoTecnico Moneda Venta
        Sql = Sql & bacTranMontoSql(Datos(13)) & ", "   ' Monto Venta
        Sql = Sql & "'" & Trim(Datos(14)) & "', "       ' Modalidad
        Sql = Sql & bacTranMontoSql(Datos(15)) & ", "   ' Precio Futuro
        Sql = Sql & bacTranMontoSql(Datos(16)) & ", "   ' Precio Spot
        Sql = Sql & bacTranMontoSql(Datos(19)) & ", "   ' Rut Propietario
        Sql = Sql & "'" & Trim(Datos(20)) & "', "       ' Digito Propietario
        Sql = Sql & "'" & Trim(Datos(18)) & "', "       ' Dirección Propietario
        Sql = Sql & "'" & Trim(Datos(17)) & "', "       ' Nombre Propietario
        Sql = Sql & "'" & Trim(Datos(4)) & "', "        ' Digito Cliente
        Sql = Sql & "'" & Trim(Datos(21)) & "', "       ' Fecha del Informe
        Sql = Sql & bacTranMontoSql(Datos(22)) & ", "   ' Código de la Institución
        Sql = Sql & "'" & Trim(Datos(23)) & "', "       ' Fecha de Proceso
        Sql = Sql & "'" & Trim(Datos(24)) & "', "       ' Marca
        Sql = Sql & bacTranMontoSql(Datos(25)) & ", "   ' Días de la Operación
        Sql = Sql & "'" & Trim(Datos(26)) & "', "       ' Apoderado 1
        Sql = Sql & "'" & Trim(Datos(27)) & "', "       ' Cargo Apoderado 1
        Sql = Sql & "'" & Trim(Datos(28)) & "', "       ' Fono Apoderado 1
        Sql = Sql & "'" & Trim(Datos(29)) & "', "       ' Apoderado 2
        Sql = Sql & "'" & Trim(Datos(30)) & "', "       ' Cargo Apoderado 2
        Sql = Sql & "'" & Trim(Datos(31)) & "', "       ' Fono Apoderado 2
        Sql = Sql & "'" & Chr$(nConta2 + 64) & "') "    ' marca para cantidad de Registros por Página
        
        DB.Execute Sql

   Loop

   'tipo de reporte
   cCristal.ReportType = "MDB"

   'Orden de impresión del reporte
   cCristal.PEN_ImprimirReporte "BacC7A1", "(BCCH Cap.VII Anexo I) Operaciones al BCCH por Capitulo VII Anexo 1 " & Format$(gsBAC_Fecp, "dd/mm/yyyy")

   Set cCristal = Nothing

End Function

Function BacVencimientosDia(xEnt As String)
   Dim iLin       As Integer
   Dim Sql        As String
   Dim cCristal   As New clsCristal
   Dim nDolarObs  As Double
   Dim nValorUf   As Double
   Dim Datos()


   nDolarObs = gsc_Parametros.AcValDolObs
   nValorUf = gsc_Parametros.ACvaloruf
   
   'Limpieza de la tabla Access
   Sql = "DELETE FROM movopervenc;"

   DB.Execute Sql

   'Llamando procedimiento almacenado
   Sql = "Execute sp_leervencimientos " & Val(xEnt)
   
   If SQL_Execute(Sql) > 0 Then
      MsgBox "Problemas al leer operaciones de seguros de cambio", vbCritical, "MENSAJE"
      Exit Function

   End If
    
    
   Do While SQL_Fetch(Datos()) = 0
         Sql = ""
         Sql = Sql & "INSERT INTO movopervenc VALUES ( "
         Sql = Sql & "'" & Trim(Datos(1)) & "', "           'Tipo Cartera
         Sql = Sql & "'" & Trim(Datos(2)) & "', "           'Tipo de Operación
         Sql = Sql & "'" & Trim(Datos(3)) & "', "           'Nombre
         Sql = Sql & "'" & Trim(Datos(4)) & "', "           'Moneda 1
         Sql = Sql & bacTranMontoSql(Datos(5)) & ", " 'Monto Moneda1
         Sql = Sql & bacTranMontoSql(Datos(6)) & ", " 'Precio
         Sql = Sql & "'" & Trim(Datos(7)) & "', "           'Moneda 2
         Sql = Sql & bacTranMontoSql(Datos(8)) & ", " 'Monto Moneda2
         Sql = Sql & bacTranMontoSql(Datos(9)) & ", " 'Numero Operacion
         Sql = Sql & "'" & Trim(Datos(10)) & "', "           'Fecha de Inicio
         Sql = Sql & "'" & Trim(Datos(11)) & "', "           'Nombre Propietario
         Sql = Sql & "'" & Trim(Datos(12)) & "', "           'Driección Propietario
         Sql = Sql & "'" & Trim(Datos(13)) & "',"            'Fecha de Proceso
         Sql = Sql & bacTranMontoSql(CDbl(14)) & ", " 'Monto a Liquidar
         Sql = Sql & "'" & Trim(Datos(15)) & "', "           'Fecha de Vencimiento
         Sql = Sql & "'" & Trim(Datos(16)) & "', "           'Modalidad
         Sql = Sql & bacTranMontoSql(nDolarObs) & ", "   'Valor UF
         Sql = Sql & bacTranMontoSql(nValorUf)           'Valor Observado
         Sql = Sql & " );"

         DB.Execute Sql

   Loop
   
   'tipo de reporte
   cCristal.ReportType = "MDB"

   'Orden de impresión del reporte
   cCristal.PEN_ImprimirReporte "BACOPVEN", "(BacOpVen) Movimiento de operaciones Vencidas del dia " & Format$(gsBAC_Fecp, gsc_FechaDMA)

   Set cCristal = Nothing

End Function


