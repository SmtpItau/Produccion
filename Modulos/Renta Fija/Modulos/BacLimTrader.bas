Attribute VB_Name = "BacLimTrader"
Option Explicit
'-----------------------------------------------------------
'
'           MODULO BACLIMTRADER.BAS :
'           Incorporado para implementar limites a los prodcutos
'           'Incorporada 31-Oct-2001
'-----------------------------------------------------------

Global Autorizado               As Boolean
Global Autorizado_II            As Boolean
Global Autorizado_III           As Boolean
Global Autorizacion_Grabacion   As Boolean
Global Autorizado_Operacion     As Boolean
Global SQL_LINEA                As String
Global DATOS_LINEA()
Global Usuario_limite           As Boolean
Global Datos_Error()
Global aTasasE()
Global aTasaTransferencia()
Global aTasasP()
Global aTasasN()
Global vInstrumento()
Global vCartera
Global LT_Fecha                 As String
Global LT_Sistema               As String
Global LT_Producto              As String
Global LT_Numero_Operacion      As Double
Global LT_Monto_Limite          As Double
Global LT_Monto_Producto        As Double
Global LT_Plazo                 As Integer
Global LT_Trader                As String
Global LT_Cartera               As Integer
Global LT_Trader_Autorizador    As String
Global LT_nombre_trader_aut    As String
Global LT_Codigo_Cliente        As String
Global LT_Rut_Cliente           As Double
Global LT_Producto_aux          As String
Global LT_Plazo_aux            As Integer
Global LT_Monto_Producto_aux   As Double
Global LT_Trader_Autorizador_aux As String

Global USD_DIA, UF_DIA           As Double

Public Function Valida_Limites_Trader(Sistema As String, Producto As String, Plazo As Integer, usuario As String, Monto_Limite As Double, cCart As Integer) As Boolean
On Error GoTo ERROR_Valida_Limites_Trader
Dim SQL_TRADER As String
Dim DATOS_TRADER()
Dim C As Integer
Valida_Limites_Trader = False

SQL_TRADER = giSQL_DatabaseCommon & "..SP_TRAE_LIMITE_POR_OPERADOR_BTR " & _
             "'" & Sistema & "'" & "," & _
             "'" & Producto & "'" & "," & _
             "'" & usuario & "'" & "," & _
            Plazo & "," & _
            cCart

If Not Bac_Sql_Execute(SQL_TRADER) Then
    MsgBox "Problemas al recuperar monto de límite del usuario " & usuario, vbCritical, TITSISTEMA
    Exit Function
Else
    If Bac_SQL_Fetch(DATOS_TRADER) Then
                
       If DATOS_TRADER(7) < Monto_Limite Then
        
            C = UBound(Datos_Error) + 1
            ReDim Preserve Datos_Error(C)
            Datos_Error(C) = Array(Producto, DATOS_TRADER(7), Monto_Limite, Plazo, cCart)
            Valida_Limites_Trader = False
            Autorizado = False
            Screen.MousePointer = 0
            Exit Function
       
       Else
            Valida_Limites_Trader = True
            Autorizado = True
            Autorizado_Operacion = False
        
       End If
       Usuario_limite = True
    Else
            C = UBound(Datos_Error) + 1
            ReDim Preserve Datos_Error(C)
            Datos_Error(C) = Array(Producto, 0, Monto_Limite, Plazo, cCart)

            Usuario_limite = False
            Valida_Limites_Trader = False
            Autorizado = False
            Screen.MousePointer = 0
            Exit Function

    End If
End If
    
Exit Function
ERROR_Valida_Limites_Trader:
    MsgBox err.Description, vbCritical, TITSISTEMA
    
End Function

Function Buscar_Autorizador(Usuario_Autorizador As String, Clave_Autorizador As String) As Boolean
On Error GoTo ERROR_Buscar_Autorizador

Buscar_Autorizador = False

SQL_LINEA = giSQL_DatabaseCommon & "..SP_BUSCA_USUARIO_AUTORIZADOR " & _
                "'" & Usuario_Autorizador & "'" & "," & _
                "'" & Encript(Clave_Autorizador, True) & "'" & "," & _
                "' '" & "," & _
                "' '" & "," & _
                "'B'"
    
    ' Verifica la existencia del usuario autorizador
    If Bac_Sql_Execute(SQL_LINEA) Then
        If Bac_SQL_Fetch(DATOS_LINEA) Then
            If DATOS_LINEA(1) = "SI" Then
                Buscar_Autorizador = True
                LT_nombre_trader_aut = DATOS_LINEA(2)
            ElseIf DATOS_LINEA(1) = "NO" Then
                MsgBox "Usuario o Clave Invalida, Ingrese nuevamente.", vbExclamation, TITSISTEMA
                Buscar_Autorizador = False
                Exit Function
            End If
        End If
    End If

    
Exit Function

ERROR_Buscar_Autorizador:
    MsgBox err.Description, vbCritical, TITSISTEMA
    
End Function

Function Verifica_MontoLinea_Aurorizador(Usuario_Autorizador As String, Producto_Autorizador As String, Plazo As Integer, Sistema As String, MontoLinea_Autorizador As Double, nCartera As Integer) As Boolean
On Error GoTo ERROR_Verifica_MontoLinea_Aurorizador

'Verifica monto linea del usuario
Verifica_MontoLinea_Aurorizador = False
Sistema = "BTR"
        SQL_LINEA = giSQL_DatabaseCommon & "..SP_TRAE_LIMITE_POR_OPERADOR_BTR " & _
                 "'" & Sistema & "'" & "," & _
                 "'" & Producto_Autorizador & "'" & "," & _
                 "'" & Usuario_Autorizador & "'" & "," & _
                 Plazo & "," & _
                 nCartera
                
        If Not Bac_Sql_Execute(SQL_LINEA) Then
            MsgBox "Problemas al Ejecutar Transaccion SQL", vbCritical, TITSISTEMA
        Else
            If Bac_SQL_Fetch(DATOS_LINEA) Then
                If DATOS_LINEA(7) >= MontoLinea_Autorizador Then
                    Verifica_MontoLinea_Aurorizador = True
                    Valida_limite_over = True
                Else
                    MsgBox "El monto de linea del usuario " & Usuario_Autorizador & " es " & Format(DATOS_LINEA(7), "#,##0.00") & " US$" & " para el Producto " & Producto_Autorizador & ", y necesita " & Format(MontoLinea_Autorizador, "#,##0.00") & " US$" & _
                    " para poder generara la operacion.", vbCritical, TITSISTEMA
                    Verifica_MontoLinea_Aurorizador = False
                    Valida_limite_over = False
                End If
            Else
                MsgBox "El usuario " & Usuario_Autorizador & " no dispone de monto de linea para esta operacion." & Chr(13) + Chr(10) & IIf(nCartera = 1, "Cartera TRADING", IIf(nCartera = 2, "Cartera AVAILABLE FOR SALE", "")), vbExclamation, TITSISTEMA
                Verifica_MontoLinea_Aurorizador = False
                Valida_limite_over = False
            End If
        End If
        
Exit Function
ERROR_Verifica_MontoLinea_Aurorizador:
    MsgBox err.Description, vbCritical, TITSISTEMA
    
End Function

Function Grabar_Registro_Limite(Sistema As String, Producto As String, Tipo_Operacion As String, Numero_Operacion As Double, Monto_Limite As Double, Monto_Producto As Double, Plazo As Integer, Trader As String, Trader_Autorizador As String, Rut_Cliente As Double, Codigo_Cliente As String, nCart As Integer)
On Error GoTo ERROR_Grabar_Registro_Limite

SQL_LINEA = giSQL_DatabaseCommon & "..SP_GRABA_REGISTRO_LIMITE_TRADER " & _
                    "'" & Sistema & "'" & "," & _
                    "'" & Producto & "'" & "," & _
                    "'" & Tipo_Operacion & "'" & "," & _
                          Numero_Operacion & "," & _
                          REEMPLAZA_COMA_PUNTO(Round(Monto_Limite, 4)) & "," & _
                          REEMPLAZA_COMA_PUNTO(Round(Monto_Producto, 4)) & "," & _
                          Plazo & "," & _
                    "'" & Trader & "'" & "," & _
                    "'" & Trader_Autorizador & "'" & "," & _
                    Rut_Cliente & "," & _
                    "'" & Codigo_Cliente & "'," _
                    & nCart

If Not Bac_Sql_Execute(SQL_LINEA) Then
    MsgBox "Problemas al ejecuatar la transaccion SQL, no se pudieron guardar los datos.", vbCritical, TITSISTEMA
Else
    If Bac_SQL_Fetch(DATOS_LINEA) Then
        If DATOS_LINEA(1) = "SI" Then
            MsgBox "Grabacion de operacion exitosa, autorizada por " & Trader_Autorizador & " con un monto de " & Format(Monto_Producto, "#,###0.0000"), vbInformation, TITSISTEMA
        End If
    End If
End If

Exit Function

ERROR_Grabar_Registro_Limite:
    MsgBox err.Description, vbCritical, TITSISTEMA

End Function

Function Conversion_Moneda(Codigo_Moneda_Origen As Integer, Codigo_Moneda_Convercion As Integer, Monto_Moneda_Origen As Double) As Double
On Error GoTo ERROR_Conversion_Moneda

If Codigo_Moneda_Origen = "UF" And Codigo_Moneda_Convercion = "CLP" Then
    Conversion_Moneda = Monto_Moneda_Origen * BacTrader.Pnl_UF.Caption
ElseIf Codigo_Moneda_Origen = "CLP" And Codigo_Moneda_Convercion = "UF" Then
    Conversion_Moneda = Monto_Moneda_Origen / BacTrader.Pnl_UF.Caption
End If

Exit Function

ERROR_Conversion_Moneda:
    MsgBox err.Description, vbCritical, TITSISTEMA
End Function

Public Function REEMPLAZA_COMA_PUNTO(Numero As Variant) As String
On Error GoTo ERROR_REEMPLAZA_COMA_PUNTO
    
    REEMPLAZA_COMA_PUNTO = Replace(Replace(Numero, gsBac_PtoMiles, ""), gsBac_PtoDec, ".")
    
    
Exit Function

ERROR_REEMPLAZA_COMA_PUNTO:
    MsgBox err.Description, vbCritical, TITSISTEMA

End Function

Public Function Conversion_UF_USD(Monto_Origen_UF As Double) As Double
On Error GoTo ERROR_Conversion_US

Conversion_UF_USD = (UF_DIA * Monto_Origen_UF) / USD_DIA

Exit Function
ERROR_Conversion_US:
    MsgBox err.Description, vbCritical, TITSISTEMA
    
End Function

Public Function Conversion_CLP_USD(Monto_Origen_CLP As Double) As Double
On Error GoTo ERROR_Conversion_US

If BacFrmIRF.Data1.Recordset("Tm_Codigo") = 35 Or BacFrmIRF.Data1.Recordset("Tm_Codigo") = 36 Or BacFrmIRF.Data1.Recordset("Tm_Codigo") = 37 Or BacFrmIRF.Data1.Recordset("Tm_Codigo") = 41 Then
    Conversion_CLP_USD = Monto_Origen_CLP / 1
Else
    'Conversion_CLP_USD = Monto_Origen_CLP / USD_DIA
    If BacFrmIRF.Data1.Recordset("tm_monemi").Value <> 13 Then
        Conversion_CLP_USD = Monto_Origen_CLP / USD_DIA
    End If
End If

'If BacIrfGr.proCodMoneda <> 13 Then
'    Conversion_CLP_USD = Monto_Origen_CLP / USD_DIA
'Else
'    Conversion_CLP_USD = Monto_Origen_CLP / 1
'End If


Exit Function
ERROR_Conversion_US:
    MsgBox err.Description, vbCritical, TITSISTEMA
    
End Function


'Public Function Conversion2_CLP_USD(Monto_Origen_CLP As Double) As Double
'On Error GoTo ERROR_Conversion_US
'
'
'If BacIrfGr.proCodMoneda <> 13 Then
'    Conversion2_CLP_USD = Monto_Origen_CLP / USD_DIA
'Else
'    Conversion2_CLP_USD = Monto_Origen_CLP / 1
'End If
'
'
'Exit Function
'ERROR_Conversion_US:
'    MsgBox err.Description, vbCritical, TITSISTEMA
'
'End Function

