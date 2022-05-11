Attribute VB_Name = "BacLimitesALCO"
Option Explicit
'------- SE GENERA PRODUCTO DE LD1-COR-035

'-----------------------------------------------------------
'           MODULO BACLIMITESALCO.BAS :
'           Incorporado para implementar limites a ALCO
'
'-----------------------------------------------------------

Global SQL_VLA      As String
Global DATOS_VLA()

Global TOTAL_GRILLA_VALOR_PRESENTE    As Double
Global TOTAL_GRILLA_VALOR_PRESENTE_VP As Double
Global TOTAL_GRILLA_VALOR_PRESENTE_AN As Double
Global Total_Nominal                  As Double
Global TOTAL_GRILLA_VALOR_MERCADO     As Double

Global Cont1 As Long
Global Cont2 As Long

Dim ODBC_DBF_ATRIBUTOS As String

Dim BD_MDCA_IBL As New ADODB.Connection
Dim BD_MDCA_BIS As New ADODB.Connection
Dim MDCA_IBL    As New ADODB.Recordset
Dim MDCA_BIS    As New ADODB.Recordset

Dim SW_DBF_BISA             As Boolean
Dim SW_DBF_IBL              As Boolean

Global Autoriza_Motor_Pago     As Boolean

Dim SQL_LIM                 As String
Dim Resultados()

Global Codigo_Limite                        As String
Global Usuario_Autorizador                  As String

Global SW_Limite_Concentracion              As Boolean
Global SW_Total_PortFolio                   As Boolean
Global SW_Securities_Trading                As Boolean
Global SW_Total_Securities_Trading          As Boolean

Global Exeso_Limite_Concentracion           As Double
Global Exeso_Total_PortFolio                As Double
Global Exeso_Securities_Trading             As Double
Global Exeso_Total_Securities_Trading       As Double
Global Plazo_Total_Securities_Trading       As Integer
Global Plazo_Securities_Trading             As Integer

Global Codigos()
Global Series()
Global Montos_Series()
Global Nominal_Series()
Global Plazos()
Global Exesos_TRA_AVF()
Global Emisores()

Global Series_Vp()
Global Cartera_VP()
Global Montos_VP_MERC()
Global Montos_Series_VP()
Global Nominal_Series_VP()
Global Plazos_VP()
Global Emisores_VP()

Global Series_AN()
Global Montos_Series_AN()
Global Nominal_Series_AN()
Global Plazos_AN()
Global Emisores_AN()

Global TipoOper_AN                      As String
Global TipoProducto_AN                  As String

Global ML_Limite_Concentracion()
Global ML_Total_PortFolio               As Double
Global ML_Securities_Trading()
Global ML_Total_Securities_Trading      As Double

Global MP_Limite_Concentracion()
Global MP_Total_PortFolio               As Double
Global MP_Securities_Trading()
Global MP_Total_Securities_Trading      As Double

Global MP_Limite_Concentracion_VP()
Global MP_Total_PortFolio_VP            As Double
Global MP_Securities_Trading_VP()
Global MP_Total_Securities_Trading_VP   As Double

Global MP_Limite_Concentracion_AN()
Global MP_Total_PortFolio_AN            As Double
Global MP_Securities_Trading_AN()
Global MP_Total_Securities_Trading_AN   As Double

' gsBac_DBF_Path : Incorporada el 12-Nov-2001 - Para lectura de Cartera de DBF IBL , BISA
Global gsBac_DBF_Path_Cartera_IBL       As String
Global gsBac_DBF_Path_Cartera_BISA      As String
Global IRFTAG                           As String
Global gCodigo_Grupo_Limite             As Integer
Global gCodigo_Limite                   As Integer

' SE OCUPA
Public Function Valida_Limites_LIMITE_CONCENTRACION(Arreglo_Series() As Variant, Arreglo_Montos() As Variant, Arreglo_Emisores() As Variant) As Boolean
Dim Cont As Long
Dim Malos As Boolean
On Error GoTo ERROR_Valida_Limites_ALCO_DETALLE

Cont = 1
If UBound(Arreglo_Series) > -1 Then
    ReDim Exesos_TRA_AVF(UBound(Arreglo_Series))
    ReDim ML_Limite_Concentracion(UBound(Arreglo_Series))
    ReDim MP_Limite_Concentracion(UBound(Arreglo_Series))
Else
    Valida_Limites_LIMITE_CONCENTRACION = True
    Exit Function
End If
Malos = False
Do
    If Valida_Instrumento(Codigos(Cont), Arreglo_Emisores(Cont)) Then
    
        If Arreglo_Series(Cont) <> "" Then
            SQL_VLA = "SP_ALCO_TRAE_LIMITE_CONCENTRACION " & Arreglo_Series(Cont) & "," & Emisores(Cont)
            If Bac_Sql_Execute(SQL_VLA) Then
                If Bac_SQL_Fetch(DATOS_VLA) Then
                    If DATOS_VLA(1) < 0 Then
                        ML_Limite_Concentracion(Cont) = 0
                    Else
            '            ML_Limite_Concentracion(Cont) = VALOR_UM_PAPEL(CStr(Arreglo_Series(Cont)), CDbl(DATOS_VLA(1)))
                        ML_Limite_Concentracion(Cont) = DATOS_VLA(1)
                    End If
                Else
                    MsgBox "No Existe limite Concentración para Instrumento " & Arreglo_Series(Cont) & "  " & Emisores(Cont)
                    Valida_Limites_LIMITE_CONCENTRACION = False
                    ML_Limite_Concentracion(Cont) = 0
                    Exit Function
                End If
            Else
                MsgBox "Problemas al Ejecutar la Consulta de Validacion de Limites ALCO. TOTAL AVAILABLE FOR SALE.", vbCritical, TITSISTEMA
                Valida_Limites_LIMITE_CONCENTRACION = False
                Exit Function
            End If
            
            'MP_Limite_Concentracion(Cont) = VALOR_UM_PAPEL(CStr(Arreglo_Series(Cont)), CDbl(Arreglo_Montos(Cont)))
            MP_Limite_Concentracion(Cont) = CDbl(Arreglo_Montos(Cont))
            
            Exesos_TRA_AVF(Cont) = Format(ML_Limite_Concentracion(Cont), FDecimal) - Format(MP_Limite_Concentracion(Cont), FDecimal)
            If Exesos_TRA_AVF(Cont) < 0 Then
                Exesos_TRA_AVF(Cont) = Abs(Exesos_TRA_AVF(Cont))
                MsgBox "El monto del Limite para este papel es de " & Format(ML_Limite_Concentracion(Cont), FDecimal) & Chr(10) & Chr(13) & "El monto del " & Series(Cont) & "  " & Emisores(Cont) & " es de " & Format(MP_Limite_Concentracion(Cont), FDecimal) & Chr(10) & Chr(13) & "Su exceso es " & Format(Exesos_TRA_AVF(Cont), FDecimal), vbExclamation, "ALCO - Exceso de limite Limite Concentracion."
                Malos = True
            End If
        End If
    End If
    Cont = Cont + 1
Loop Until UBound(Arreglo_Series()) + 1 = Cont

If Malos Then
    Valida_Limites_LIMITE_CONCENTRACION = False
Else
    Valida_Limites_LIMITE_CONCENTRACION = True
End If

Exit Function

ERROR_Valida_Limites_ALCO_DETALLE:
    MsgBox err.Description, vbCritical, TITSISTEMA
    Resume Next
End Function

'SE OCUPA
Public Function Valida_Limites_TOTAL_PORTFOLIO(Arreglo_Series() As Variant, Monto_Total_Operacion_Nominal() As Variant) As Boolean
Dim Cont As Long
On Error GoTo ERROR_Valida_Limites_ALCO_TOTAL

MP_Total_PortFolio = 0
Exeso_Total_PortFolio = 0
ML_Total_PortFolio = 0

If UBound(Monto_Total_Operacion_Nominal()) <= -1 Then
    Valida_Limites_TOTAL_PORTFOLIO = True
    Exit Function
End If

Cont = 1
Do
    If Not (InStr(1, Arreglo_Series(Cont), "DPF") > 0 Or _
            InStr(1, Arreglo_Series(Cont), "DPR") > 0 Or _
            InStr(1, Arreglo_Series(Cont), "DPD") > 0) And Arreglo_Series(Cont) <> "" Then
       MP_Total_PortFolio = MP_Total_PortFolio + IIf(Codigos(Cont) = 35 Or Codigos(Cont) = 36 Or Codigos(Cont) = 37, CDbl(Monto_Total_Operacion_Nominal(Cont)), (CDbl(Monto_Total_Operacion_Nominal(Cont)) / gsValor_DO))
    End If
    Cont = Cont + 1
Loop Until UBound(Monto_Total_Operacion_Nominal()) + 1 = Cont

SQL_VLA = "SP_ALCO_TRAE_SECURITIE_PORTFOLIO"
If Bac_Sql_Execute(SQL_VLA) Then
    If Bac_SQL_Fetch(DATOS_VLA) Then
        If DATOS_VLA(1) < 0 Then
            ML_Total_PortFolio = 0
        Else
            ML_Total_PortFolio = DATOS_VLA(1)
        End If
    Else
        Valida_Limites_TOTAL_PORTFOLIO = False
        Exit Function
    End If
Else
    MsgBox "Problemas al Ejecutar la Consulta de Validación de Limites ALCO. TOTAL NATIONAL LIMIT", vbCritical, TITSISTEMA
    Valida_Limites_TOTAL_PORTFOLIO = False
End If

Exeso_Total_PortFolio = Format(ML_Total_PortFolio, FDecimal) - Format(MP_Total_PortFolio, FDecimal)

If Exeso_Total_PortFolio < 0 Then
    Exeso_Total_PortFolio = Abs(Exeso_Total_PortFolio)
    Valida_Limites_TOTAL_PORTFOLIO = False
    MsgBox "El Limite para esta operación es de " & Format(ML_Total_PortFolio, FDecimal) & ".El monto de la Operacion Total es " & Format(MP_Total_PortFolio, FDecimal) & " y su exceso es de " & Format(Exeso_Total_PortFolio, FDecimal), vbExclamation, "ALCO - Exceso de limite Total PortFolio."
Else
    Valida_Limites_TOTAL_PORTFOLIO = True
End If

Exit Function

ERROR_Valida_Limites_ALCO_TOTAL:
    MsgBox err.Description, vbCritical, TITSISTEMA
    Valida_Limites_TOTAL_PORTFOLIO = False
    
End Function

' SE OCUPA
Function VALOR_UM_PAPEL(Serie As String, Nominal As Double) As Double
On Error GoTo ERROR_VALOR_UM_PAPEL

Dim SQL_UM      As String
Dim DAOTS_UM()
    
    
    SQL_UM = "SP_VALOR_UM_PAPEL '" & Serie & "'," & Nominal
    If Bac_Sql_Execute(SQL_UM) Then
        If Bac_SQL_Fetch(DAOTS_UM) Then
            VALOR_UM_PAPEL = DAOTS_UM(1)
            If DAOTS_UM(1) = 0 Then
                MsgBox " Verifique al Valor de la Moneda de Emision de la Serie " & Serie & " de la Fecha " & gsBac_Fecp & ", Para poder Validar Correctamente Limites ALCO.", vbExclamation, "VALOR UM PAPEL "
            End If
        End If
    End If

Exit Function
ERROR_VALOR_UM_PAPEL:
    MsgBox err.Description, vbCritical, "ERROR VALOR UM PAPEL"
End Function


'SE OCUPA
Function Valida_Limite_TOTAL_SECURITIES_TRADING(MONTO_VALOR_PRESENTE_TOTAL As Double) As Boolean
On Error GoTo ERROR_Valida_Limite_TRADING
Dim Cont As Long
Cont = 1
If MONTO_VALOR_PRESENTE_TOTAL <= 0 Then
    Exeso_Total_Securities_Trading = 0
    Valida_Limite_TOTAL_SECURITIES_TRADING = True
    Exit Function
End If
If Codigos(Cont) = 35 Or Codigos(Cont) = 36 Or Codigos(Cont) = 37 Then
    MP_Total_Securities_Trading = MONTO_VALOR_PRESENTE_TOTAL
Else
    MP_Total_Securities_Trading = MONTO_VALOR_PRESENTE_TOTAL / gsValor_DO
End If


SQL_VLA = "SP_ALCO_TRAE_TOTAL_SECURITIE_TRADING"
 If Bac_Sql_Execute(SQL_VLA) Then
    If Bac_SQL_Fetch(DATOS_VLA) Then
        If DATOS_VLA(1) < 0 Then
            ML_Total_Securities_Trading = 0
        Else
            ML_Total_Securities_Trading = DATOS_VLA(1)
        End If
    Else
        Valida_Limite_TOTAL_SECURITIES_TRADING = False
        Exit Function
    End If
Else
    MsgBox "Problemas al ejecutar SQL, Total Trading.", vbCritical, TITSISTEMA
End If

Exeso_Total_Securities_Trading = Format(ML_Total_Securities_Trading, FDecimal) - Format(MP_Total_Securities_Trading, FDecimal)

If Exeso_Total_Securities_Trading > 0 Then
    Exeso_Total_Securities_Trading = 0
    Valida_Limite_TOTAL_SECURITIES_TRADING = True
Else
    Exeso_Total_Securities_Trading = Abs(Exeso_Total_Securities_Trading)
    MsgBox "El Limite para el total esta operacion es de " & Format(ML_Total_Securities_Trading, FDecimal) & ". Y el total de la operacion " & Format(MP_Total_Securities_Trading, FDecimal) & ".Su diferencia es en USD " & Format(Exeso_Total_Securities_Trading, FDecimal), vbExclamation, "ALCO - Exceso de limite Total Securities Trading."
    Valida_Limite_TOTAL_SECURITIES_TRADING = False
End If

Exit Function

ERROR_Valida_Limite_TRADING:
    MsgBox err.Description, vbCritical, TITSISTEMA

End Function

'SE USA
Function Valida_Limite_SECURITIES_TRADING(Serie_Papel() As Variant, MONTO_VALOR_PRESENTE_PAPEL() As Variant, PLAZO_PAPEL() As Variant) As Boolean
On Error GoTo ERROR_Valida_Limite_TRADING
Dim Cont As Long
Cont = 1

Valida_Limite_SECURITIES_TRADING = True
If UBound(MONTO_VALOR_PRESENTE_PAPEL) > -1 Then
    ReDim Exesos_TRA_AVF(UBound(MONTO_VALOR_PRESENTE_PAPEL))
    ReDim ML_Securities_Trading(UBound(MONTO_VALOR_PRESENTE_PAPEL))
    ReDim MP_Securities_Trading(UBound(MONTO_VALOR_PRESENTE_PAPEL))
Else
    Exit Function
End If

Do
    SQL_VLA = "SP_ALCO_TRAE_SECURITIE_TRADING " & PLAZO_PAPEL(Cont)
    If Bac_Sql_Execute(SQL_VLA) Then
        If Bac_SQL_Fetch(DATOS_VLA) Then
            If DATOS_VLA(1) < 0 Then
                ML_Securities_Trading(Cont) = 0
            Else
                ML_Securities_Trading(Cont) = DATOS_VLA(1)
            End If
        Else
            MsgBox "No Existe Limite Securities Trading para el plazo del Instrumento, Plazo = " & PLAZO_PAPEL(Cont) & " días", vbCritical, TITSISTEMA
            Valida_Limite_SECURITIES_TRADING = False
            Exit Function
        End If
    Else
        MsgBox "Problemas al ejecutar SQL, Detalle Trading.", vbCritical, TITSISTEMA
    End If
    If Codigos(Cont) = 35 Or Codigos(Cont) = 36 Or Codigos(Cont) = 37 Then
        MP_Securities_Trading(Cont) = MONTO_VALOR_PRESENTE_PAPEL(Cont)
    Else
        MP_Securities_Trading(Cont) = (MONTO_VALOR_PRESENTE_PAPEL(Cont) / gsValor_DO)
    End If
    
    Exesos_TRA_AVF(Cont) = ML_Securities_Trading(Cont) - MP_Securities_Trading(Cont)
    If Exesos_TRA_AVF(Cont) < 0 Then
        Exesos_TRA_AVF(Cont) = Abs(Exesos_TRA_AVF(Cont))
        Valida_Limite_SECURITIES_TRADING = False
        MsgBox "El Limite para esta operacion es de USD " & Format(ML_Securities_Trading(Cont), FDecimal) & ". Se ha excedido el limite del la Serie " & Serie_Papel(Cont) & " cuyo monto es USD " & Format(MP_Securities_Trading(Cont), FDecimal) & ". Su diferencia es en USD " & Format(Exesos_TRA_AVF(Cont), FDecimal), vbExclamation, "ALCO - Exceso de limite Securities Trading."
    End If

    Cont = Cont + 1
    
Loop Until UBound(MONTO_VALOR_PRESENTE_PAPEL) + 1 = Cont

Exit Function

ERROR_Valida_Limite_TRADING:
    MsgBox err.Description, vbCritical, TITSISTEMA
    Resume Next
End Function

'SE USA
Function PLAZO_PAPEL_TRADING(Serie_Papel As String) As Integer
On Error GoTo ERROR_PLAZO_PAPEL_TRADING

SQL_VLA = "SP_PLAZO_PAPEL_TRADING " & "'" & Serie_Papel & "'"

 If Bac_Sql_Execute(SQL_VLA) Then
    If Bac_SQL_Fetch(DATOS_VLA) Then
         PLAZO_PAPEL_TRADING = DATOS_VLA(1)
    End If
 End If

Exit Function
ERROR_PLAZO_PAPEL_TRADING:
    MsgBox err.Description, vbCritical, TITSISTEMA

End Function

'SE USA
Sub Graba_Limite_Concentracion(Num_Oper As Double, Tip_Oper As String, Serie() As Variant, Monto_Operacion() As Variant, Exeso() As Variant, Trader As String, Trader_Autori As String, Rut_Clie As Double, Monto_Linea() As Variant, Monto_Posicion() As Variant, Codigo_Cliente As Integer)
On Error GoTo ERROR_Graba_Limite_Concentracion

Dim Cont As Integer
Cont = 1
If UBound(Serie) <= -1 Then
    Exit Sub
End If

Do

SQL_LIM = "SP_ALCO_LOG_LIMITE_CONCENTRACION " & _
                        "1" & "," & _
                        "'LIMITE CONCENTRACION'" & "," & _
                        Num_Oper & "," & _
                        "'" & Tip_Oper & "'," & _
                        "'" & Serie(Cont) & "'" & "," & _
                        CDbl((Monto_Operacion(Cont))) & "," & _
                        CDbl(Monto_Linea(Cont)) & "," & _
                        CDbl(Exeso(Cont)) & "," & _
                        "0" & "," & _
                        "'" & Trader & "'" & "," & _
                        "'" & Trader_Autori & "'" & "," & _
                         Rut_Clie & "," & _
                        Codigo_Cliente

If Not Bac_Sql_Execute(SQL_LIM) Then
    MsgBox "Problemas al Grabar Control Limites Concentracion.", vbCritical, TITSISTEMA
End If

Cont = Cont + 1

Loop Until UBound(Serie) + 1 = Cont

Exit Sub
ERROR_Graba_Limite_Concentracion:
    MsgBox err.Description, vbCritical, TITSISTEMA

End Sub

'SE USA
Sub Graba_Total_PortFolio(Num_Oper As Double, Tip_Oper As String, Monto_Operacion As Double, Exeso As Double, Trader As String, Trader_Autori As String, Rut_Clie As Double, Monto_Linea As Double, Monto_Posicion As Double, Codigo_Cliente As Integer)
On Error GoTo ERROR_Graba_Total_PortFolio

SQL_LIM = "SP_ALCO_LOG_LIMITE_CONCENTRACION " _
                                      & "2" & "," _
                                      & "'TOTAL PORTFOLIO'" & "," _
                                      & Num_Oper & "," _
                                      & "'" & Tip_Oper & "'" & "," _
                                      & "''" & "," _
                                      & REEMPLAZA_COMA_PUNTO(Monto_Operacion) & "," _
                                      & REEMPLAZA_COMA_PUNTO(Monto_Linea) & "," _
                                      & REEMPLAZA_COMA_PUNTO(Exeso) & "," _
                                      & "0" & "," _
                                      & "'" & Trader & "'" & "," _
                                      & "'" & Trader_Autori & "'" & "," _
                                      & Rut_Clie & "," _
                                      & Codigo_Cliente

If Not Bac_Sql_Execute(SQL_LIM) Then
    MsgBox "Problemas al Grabar Control Limites Total PortFolio.", vbCritical, TITSISTEMA
End If

Exit Sub
ERROR_Graba_Total_PortFolio:
    MsgBox err.Description, vbCritical, TITSISTEMA

End Sub

'SE USA
Sub Graba_Securities_Trading(Num_Oper As Double, Tip_Oper As String, Serie() As Variant, Monto_Operacion() As Variant, Exeso() As Variant, Plazo() As Variant, Trader As String, Trader_Autori As String, Rut_Clie As Double, Monto_Linea() As Variant, Monto_Posicion() As Variant, Codigo_Cliente As Integer)
On Error GoTo ERROR_Graba_Securities_Trading

Dim Cont As Integer
Cont = 1
If UBound(Serie) <= -1 Then
    Exit Sub
End If
Do

SQL_LIM = "SP_ALCO_LOG_LIMITE_CONCENTRACION " _
                & "3" & "," _
                & "'SECURITIES TRADING'" & "," _
                & Num_Oper & "," _
                & Tip_Oper & "," _
                & "'" & Serie(Cont) & "'" & "," _
                & REEMPLAZA_COMA_PUNTO((Monto_Operacion(Cont))) & "," _
                & REEMPLAZA_COMA_PUNTO(Monto_Linea(Cont)) & "," _
                & REEMPLAZA_COMA_PUNTO(Exeso(Cont)) & "," _
                & Plazo(Cont) & "," _
                & "'" & Trader & "'" & "," _
                & "'" & Trader_Autori & "'" & "," _
                & "'" & Rut_Clie & "'," _
                & Codigo_Cliente

If Not Bac_Sql_Execute(SQL_LIM) Then
    MsgBox "Problemas al Grabar Control Limites Securities Trading.", vbCritical, TITSISTEMA
End If

Cont = Cont + 1

Loop Until UBound(Serie) + 1 = Cont

Exit Sub
ERROR_Graba_Securities_Trading:
    MsgBox err.Description, vbCritical, TITSISTEMA
End Sub

'SE USA
Sub Graba_Total_Securities_Trading(Num_Oper As Double, Tip_Oper As String, Monto_Operacion As Double, Exeso As Double, Trader As String, Trader_Autori As String, Rut_Clie As Double, Monto_Linea As Double, Monto_Posicion As Double, Codigo_Cliente As Integer)
On Error GoTo ERROR_Graba_Total_Securities_Trading

SQL_LIM = "SP_ALCO_LOG_LIMITE_CONCENTRACION " _
                        & "4" & "," _
                        & "'TOTAL SECURITIES TRADING'" & "," _
                        & Num_Oper & "," _
                        & "'" & Tip_Oper & "'" & "," _
                        & "''" & "," _
                        & REEMPLAZA_COMA_PUNTO(Monto_Operacion) & "," _
                        & REEMPLAZA_COMA_PUNTO(Monto_Linea) & "," _
                        & REEMPLAZA_COMA_PUNTO(Exeso) & "," _
                        & "0" & "," _
                        & "'" & Trader & "'" & "," _
                        & "'" & Trader_Autori & "'" & "," _
                        & "'" & Rut_Clie & "'," _
                        & Codigo_Cliente

If Not Bac_Sql_Execute(SQL_LIM) Then
    MsgBox "Problemas al Grabar Control Limites Total Securities Trading.", vbCritical, TITSISTEMA
End If

Exit Sub
ERROR_Graba_Total_Securities_Trading:
    MsgBox err.Description, vbCritical, TITSISTEMA
End Sub

'*****************************************************
'***************** Actualiza CP

Sub Actualiza_Limite_Concentracion(Serie_Papel(), Nominal_Papel())
On Error GoTo ERROR_Actualiza_Limite_Concentracion
Dim I As Integer

I = 1
If UBound(Serie_Papel) <= -1 Then
    Exit Sub
End If
Do
 If Valida_Instrumento(Codigos(I), Emisores(I)) Then
     SQL_VLA = "SP_ALCO_ACTUALIZA_LIMITE_CONCENTRACION '" & Serie_Papel(I) & "'," & CDbl(Nominal_Papel(I)) & "," & Emisores(I)
     If Bac_Sql_Execute(SQL_VLA) Then
        If Bac_SQL_Fetch(DATOS_VLA) Then
    '       MsgBox "Actualiza Limite Concentracion OK", vbInformation
        End If
    Else
        MsgBox "Problemas al ejecutar SQL, ACTUALIZA LIMITE CONCENTRACION.", vbCritical, "ACTUALIZA LIMITE CONCENTRACION"
    End If
End If
I = I + 1

Loop Until UBound(Serie_Papel) + 1 = I

Exit Sub
ERROR_Actualiza_Limite_Concentracion:
    MsgBox err.Description, vbCritical, "ERROR Actualiza Limite Concentracion"
    
End Sub

Sub Actuliza_Total_PortFolio(Monto_Operacion As Double)
On Error GoTo ERROR_Actuliza_Total_PortFolio
If Monto_Operacion <= 0 Then
    Exit Sub
End If

 SQL_VLA = "SP_ALCO_ACTUALIZA_TOTAL_PORTFOLIO " & CDbl(Monto_Operacion)
  If Bac_Sql_Execute(SQL_VLA) Then
    If Bac_SQL_Fetch(DATOS_VLA) Then
 '       MsgBox "Actualiza Limite Total PortFolio", vbInformation
    End If
 End If


Exit Sub
ERROR_Actuliza_Total_PortFolio:
    MsgBox err.Description, vbCritical, "ERROR Actuliza Total PortFolio"

End Sub

Sub Actuliza_Securities_Trading(Plazo(), Valor_Papel())
On Error GoTo ERROR_Actuliza_Securities_Trading

Dim I As Integer
Dim Monto As Double
I = 1
If UBound(Valor_Papel) <= -1 Then
   Exit Sub
End If
Do
 Monto = Valor_Papel(I) / gsValor_DO
 SQL_VLA = "SP_ALCO_ACTUALIZA_LIMITE_SECURITIE_TRADING '" & Plazo(I) & "'," & CDbl(Monto)
 
 If Bac_Sql_Execute(SQL_VLA) Then
    If Bac_SQL_Fetch(DATOS_VLA) Then
'       MsgBox "Actualiza Limite Securitie Trading", vbInformation
    End If
Else
    MsgBox "Problemas al ejecutar SQL, Actualiza Limite Securitie Trading.", vbCritical, "ACTUALIZA LIMITE SECURITIE TRADING"
End If

I = I + 1

Loop Until UBound(Valor_Papel) + 1 = I

Exit Sub
ERROR_Actuliza_Securities_Trading:
    MsgBox err.Description, vbCritical, "ERROR Actuliza Securities Trading"

End Sub

Sub Actuliza_Total_Securities_Trading(Total_Securities_Trading As Double)

On Error GoTo ERROR_Actuliza_Total_Securities_Trading

Dim Monto As Double
 If Total_Securities_Trading <= 0 Then
   Exit Sub
 End If
 Monto = Total_Securities_Trading / gsValor_DO
 SQL_VLA = "SP_ALCO_ACTULIZA_TOTAL_SECURITIES_TRADING " & CDbl(Monto)
 
  If Bac_Sql_Execute(SQL_VLA) Then
    If Bac_SQL_Fetch(DATOS_VLA) Then
'        MsgBox "Actualiza Limite Total Securitie Traing", vbInformation
    End If
 End If

Exit Sub
ERROR_Actuliza_Total_Securities_Trading:
    MsgBox err.Description, vbAbortRetryIgnore, "ERROR Actuliza Total Securities Trading"
    
End Sub
'***************** FIN Actualiza CP

'*****************************************************
'***************** Actualiza VP

Sub Actualiza_Limite_Concentracion_VP(Serie_Papel(), Nominal_Papel(), Emisores())
On Error GoTo ERROR_Actualiza_Limite_Concentracion
Dim I As Integer

I = 1

If UBound(Serie_Papel) <= -1 Then
    Exit Sub
End If

Do
 If Valida_Instrumento(Codigos(I), Emisores(I)) Then
     SQL_VLA = "SP_ALCO_ACTUALIZA_LIMITE_CONCENTRACION_VP '" & Serie_Papel(I) & "'," & CDbl(Nominal_Papel(I)) & "," & CDbl(Emisores(I))
     If Bac_Sql_Execute(SQL_VLA) Then
        If Bac_SQL_Fetch(DATOS_VLA) Then
    '       MsgBox "Actualiza Limite Concentracion", vbInformation
        End If
     Else
        MsgBox "Problemas al ejecutar SQL, ACTUALIZA LIMITE CONCENTRACION.", vbCritical, "ACTUALIZA LIMITE CONCENTRACION"
     End If
 End If

I = I + 1

Loop Until UBound(Serie_Papel) + 1 = I

Exit Sub
ERROR_Actualiza_Limite_Concentracion:
    MsgBox err.Description, vbCritical, "ERROR Actualiza Limite Concentracion"
    
End Sub

Sub Actuliza_Total_PortFolio_VP(Monto_Operacion As Double)
On Error GoTo ERROR_Actuliza_Total_PortFolio

 If Monto_Operacion <= 0 Then
    Exit Sub
 End If
 
 SQL_VLA = "SP_ALCO_ACTUALIZA_TOTAL_PORTFOLIO_VP " & CDbl(Monto_Operacion)
  If Bac_Sql_Execute(SQL_VLA) Then
    If Bac_SQL_Fetch(DATOS_VLA) Then
'        MsgBox "Actualiza Limite Total PortFolio", vbInformation
    End If
 End If


Exit Sub
ERROR_Actuliza_Total_PortFolio:
    MsgBox err.Description, vbCritical, "ERROR Actuliza Total PortFolio"

End Sub

Sub Actuliza_Securities_Trading_VP(Plazo(), Valor_Papel())
On Error GoTo ERROR_Actuliza_Securities_Trading

Dim I As Integer
Dim Monto As Double
I = 1

If UBound(Valor_Papel) <= -1 Then
    Exit Sub
End If

Do
 Monto = Valor_Papel(I) / gsValor_DO
 SQL_VLA = "SP_ALCO_ACTUALIZA_LIMITE_SECURITIE_TRADING_VP '" & Plazo(I) & "'," & CDbl(Monto)
 
 If Bac_Sql_Execute(SQL_VLA) Then
    If Bac_SQL_Fetch(DATOS_VLA) Then
'       MsgBox "Actualiza Limite Securitie Trading", vbInformation
    End If
Else
    MsgBox "Problemas al ejecutar SQL, Actualiza Limite Securitie Trading.", vbCritical, "ACTUALIZA LIMITE SECURITIE TRADING"
End If

I = I + 1

Loop Until UBound(Valor_Papel) + 1 = I

Exit Sub
ERROR_Actuliza_Securities_Trading:
    MsgBox err.Description, vbCritical, "ERROR Actuliza Securities Trading"

End Sub

Sub Actuliza_Total_Securities_Trading_VP(Total_Securities_Trading As Double)

On Error GoTo ERROR_Actuliza_Total_Securities_Trading

Dim Monto As Double
 If Total_Securities_Trading <= 0 Then
    Exit Sub
 End If
 Monto = Total_Securities_Trading / gsValor_DO
 SQL_VLA = "SP_ALCO_ACTULIZA_TOTAL_SECURITIES_TRADING_VP " & CDbl(Monto)
 
  If Bac_Sql_Execute(SQL_VLA) Then
    If Bac_SQL_Fetch(DATOS_VLA) Then
'        MsgBox "Actualiza Limite Total Securitie Traing", vbInformation
    End If
 End If

Exit Sub
ERROR_Actuliza_Total_Securities_Trading:
    MsgBox err.Description, vbAbortRetryIgnore, "ERROR Actuliza Total Securities Trading"
    
End Sub

'**************** FIN Actualiza VP

'*****************************************************
'***************** Actualiza ANULACION

Sub Actualiza_Limite_Concentracion_AN(Serie_Papel(), Nominal_Papel(), Producto As String, Emisores())
On Error GoTo ERROR_Actualiza_Limite_Concentracion
Dim I As Integer

I = 1

If UBound(Serie_Papel) <= -1 Then
    Exit Sub
End If

Do
 If Valida_Instrumento(Codigos(I), Emisores(I)) Then
     SQL_VLA = "SP_ALCO_ACTUALIZA_LIMITE_CONCENTRACION_AN '" & Serie_Papel(I) & "'," & CDbl(Nominal_Papel(I)) & ",'" & Producto & "'" & "," & Emisores(I)
     If Bac_Sql_Execute(SQL_VLA) Then
        If Bac_SQL_Fetch(DATOS_VLA) Then
    '       MsgBox "Actualiza Limite Concentracion", vbInformation
        End If
     Else
        MsgBox "Problemas al ejecutar SQL, ACTUALIZA LIMITE CONCENTRACION.", vbCritical, "ACTUALIZA LIMITE CONCENTRACION"
     End If
End If
I = I + 1

Loop Until UBound(Serie_Papel) + 1 = I

Exit Sub
ERROR_Actualiza_Limite_Concentracion:
    MsgBox err.Description, vbCritical, "ERROR Actualiza Limite Concentracion"
    
End Sub

Sub Actuliza_Total_PortFolio_AN(Monto_Operacion As Double, Producto As String)
On Error GoTo ERROR_Actuliza_Total_PortFolio

 If Monto_Operacion <= 0 Then Exit Sub
 
 SQL_VLA = "SP_ALCO_ACTUALIZA_TOTAL_PORTFOLIO_AN " & CDbl(Monto_Operacion) & ",'" & Producto & "'"
  If Bac_Sql_Execute(SQL_VLA) Then
    If Bac_SQL_Fetch(DATOS_VLA) Then
'        MsgBox "Actualiza Limite Total PortFolio", vbInformation
    End If
 End If

Exit Sub
ERROR_Actuliza_Total_PortFolio:
    MsgBox err.Description, vbCritical, "ERROR Actuliza Total PortFolio"

End Sub

Sub Actuliza_Securities_Trading_AN(Plazo(), Valor_Papel(), Producto)
On Error GoTo ERROR_Actuliza_Securities_Trading

Dim I As Integer
Dim Monto As Double
I = 1

If UBound(Valor_Papel) <= -1 Then Exit Sub

Do
 Monto = Valor_Papel(I) / gsValor_DO
 SQL_VLA = "SP_ALCO_ACTUALIZA_LIMITE_SECURITIE_TRADING_AN '" & Plazo(I) & "'," & CDbl(Monto) & ",'" & Producto & "'"
 If Bac_Sql_Execute(SQL_VLA) Then
    If Bac_SQL_Fetch(DATOS_VLA) Then
'       MsgBox "Actualiza Limite Securitie Trading", vbInformation
    End If
Else
    MsgBox "Problemas al ejecutar SQL, Actualiza Limite Securitie Trading.", vbCritical, "ACTUALIZA LIMITE SECURITIE TRADING"
End If

I = I + 1

Loop Until UBound(Valor_Papel) + 1 = I

Exit Sub
ERROR_Actuliza_Securities_Trading:
    MsgBox err.Description, vbCritical, "ERROR Actuliza Securities Trading"

End Sub

Sub Actuliza_Total_Securities_Trading_AN(Total_Securities_Trading As Double, Producto As String)

On Error GoTo ERROR_Actuliza_Total_Securities_Trading

Dim Monto As Double

 If Total_Securities_Trading <= 0 Then Exit Sub

 Monto = Total_Securities_Trading / gsValor_DO
 SQL_VLA = "SP_ALCO_ACTULIZA_TOTAL_SECURITIES_TRADING_AN " & REEMPLAZA_COMA_PUNTO(Monto) & ",'" & Producto & "'"
 
  If Bac_Sql_Execute(SQL_VLA) Then
    If Bac_SQL_Fetch(DATOS_VLA) Then
'        MsgBox "Actualiza Limite Total Securitie Traing", vbInformation
    End If
 End If

Exit Sub
ERROR_Actuliza_Total_Securities_Trading:
    MsgBox err.Description, vbAbortRetryIgnore, "ERROR Actuliza Total Securities Trading"
    
End Sub
'***************** FIN Actualiza ANULACION

Sub Graba_Log_Exeso_Trading_AvailableFS(TopoOperacion As String)
        
        If SW_Limite_Concentracion And Grabacion_Operacion Then ' COD 1 - Limite Concentracion
            Call Graba_Limite_Concentracion(LT_Numero_Operacion, TopoOperacion, Series, MP_Limite_Concentracion, Exesos_TRA_AVF, gsBac_User, Usuario_Autorizador, LT_Rut_Cliente, ML_Limite_Concentracion, MP_Limite_Concentracion, CInt(Val(LT_Codigo_Cliente)))
        End If
        
        If SW_Total_PortFolio And Grabacion_Operacion Then 'COD 2 - Total PortFolio
            Call Graba_Total_PortFolio(LT_Numero_Operacion, TopoOperacion, MP_Total_PortFolio, Exeso_Total_PortFolio, gsBac_User, Usuario_Autorizador, LT_Rut_Cliente, ML_Total_PortFolio, MP_Total_PortFolio, CInt(Val(LT_Codigo_Cliente)))
        End If
        
        If SW_Securities_Trading And Grabacion_Operacion Then ' COD - 3 Securities Trading
            Call Graba_Securities_Trading(LT_Numero_Operacion, TopoOperacion, Series, MP_Securities_Trading, Exesos_TRA_AVF, Plazos, gsBac_User, Usuario_Autorizador, LT_Rut_Cliente, ML_Securities_Trading, MP_Securities_Trading, CInt(Val(LT_Codigo_Cliente)))
        End If

        If SW_Total_Securities_Trading And Grabacion_Operacion Then ' COD 4 - Total Securities Trading
            Call Graba_Total_Securities_Trading(LT_Numero_Operacion, TopoOperacion, MP_Total_Securities_Trading, Exeso_Total_Securities_Trading, gsBac_User, Usuario_Autorizador, LT_Rut_Cliente, ML_Total_Securities_Trading, MP_Total_Securities_Trading, CInt(Val(LT_Codigo_Cliente)))
        End If
        
End Sub

Sub Actualiza_Trading_AvailableFS(TipoOperacion As String, cTipoCart As String)
Dim Cont As Long
On Error GoTo ERROR_Actualiza_Trading_AvailableFS
                
'************** SOLO CP
If UBound(Series) <= -1 Then
    Exit Sub
End If

If TipoOperacion = "CP" Then
    If cTipoCart = "AVAILABLE FOR SALE" Then
        If Grabacion_Operacion Then ' Limite Concentracion
            Cont = 1
            ReDim MP_Limite_Concentracion(UBound(Series))
            Do
                If Valida_Instrumento(Codigos(Cont), Emisores(Cont)) Then
                    MP_Limite_Concentracion(Cont) = CDbl(Nominal_Series(Cont))
                End If
                Cont = Cont + 1
            Loop Until UBound(Nominal_Series()) + 1 = Cont
            Call Actualiza_Limite_Concentracion(Series, MP_Limite_Concentracion)
        End If
        
        If Grabacion_Operacion Then 'Actualiza Total Portfolio
            Cont = 1
            MP_Total_PortFolio = 0
            Do
                If Not (InStr(1, Series(Cont), "DPF") > 0 Or _
                        InStr(1, Series(Cont), "DPR") > 0 Or _
                        InStr(1, Series(Cont), "DPD") > 0) And Series(Cont) <> "" Then
                    MP_Total_PortFolio = MP_Total_PortFolio + (Montos_Series(Cont) / gsValor_DO)
                End If
                Cont = Cont + 1
            Loop Until UBound(MP_Limite_Concentracion()) + 1 = Cont
            Call Actuliza_Total_PortFolio(MP_Total_PortFolio)
        End If
    ElseIf cTipoCart = "TRADING" Then
        If Grabacion_Operacion Then 'Actualiza Securitie Trading
            Call Actuliza_Securities_Trading(Plazos, Montos_Series)
        End If
            
        If Grabacion_Operacion Then ' Actualiza Total Securitie Trading
            Call Actuliza_Total_Securities_Trading(TOTAL_GRILLA_VALOR_PRESENTE)
        End If
    End If
End If
'************* FIN CP *******************

'********* VP
'If TipoOperacion = "VP" Then
'    If cTipoCart = "AVAILABLE FOR SALE" Then
'        If Grabacion_Operacion Then ' Limite Concentracion
'            Cont = 1
'            ReDim MP_Limite_Concentracion_VP(UBound(Series_Vp))
'            Do
'                MP_Limite_Concentracion_VP(Cont) = VALOR_UM_PAPEL(CStr(Series_Vp(Cont)), CDbl(Nominal_Series_VP(Cont)))
'                Cont = Cont + 1
'            Loop Until UBound(Nominal_Series_VP) + 1 = Cont
'            Call Actualiza_Limite_Concentracion_VP(Series_Vp, MP_Limite_Concentracion_VP)
'        End If
'
'        If Grabacion_Operacion Then 'Actualiza Total Portfolio
'            Cont = 1
'            MP_Total_PortFolio_VP = 0
'            Do
'                MP_Total_PortFolio_VP = MP_Total_PortFolio_VP + MP_Limite_Concentracion_VP(Cont)
'                Cont = Cont + 1
'            Loop Until UBound(MP_Limite_Concentracion_VP) + 1 = Cont
'            Call Actuliza_Total_PortFolio_VP(MP_Total_PortFolio_VP)
'        End If
'    ElseIf cTipoCart = "TRADING" Then
'        If Grabacion_Operacion Then 'Actualiza Securitie Trading
'            Call Actuliza_Securities_Trading_VP(Plazos_VP, Montos_Series_VP)
'        End If
'
'        If Grabacion_Operacion Then ' Actualiza Total Securitie Trading
'            Call Actuliza_Total_Securities_Trading_VP(TOTAL_GRILLA_VALOR_PRESENTE_VP)
'        End If
'    End If
'End If
'************* FIN VP *******************

Exit Sub
ERROR_Actualiza_Trading_AvailableFS:
    MsgBox err.Description, vbCritical, "ERROR_Actualiza_Trading_AvailableFS"

End Sub

Sub Actualiza_Limites_Por_Anulacion(Operacion As String, Producto As String, cCartera As String)
Dim Cont As Long
On Error GoTo ERROR_Actualiza_Limtes_Por_Anulacion

If Operacion = "AN" Then
 If cCartera = "AVAILABLE FOR SALE" Then
    '*** Concentracion
        Cont = 1
        ReDim MP_Limite_Concentracion_AN(UBound(Series_AN))
        Do
            If Valida_Instrumento(Codigos(Cont), Emisores_AN(Cont)) Then
                MP_Limite_Concentracion_AN(Cont) = CDbl(Nominal_Series_AN(Cont))   'VALOR_UM_PAPEL(CStr(Series_AN(Cont)), CDbl(Nominal_Series_AN(Cont)))
            End If
            Cont = Cont + 1
        Loop Until UBound(Nominal_Series_AN) + 1 = Cont
        Call Actualiza_Limite_Concentracion_AN(Series_AN, MP_Limite_Concentracion_AN, Producto, Emisores_AN)
    '****************
    
    '*** Portfolio
        Cont = 1
        MP_Total_PortFolio_AN = 0
        Do
            If Not (InStr(1, Series_AN(Cont), "DPF") > 0 Or _
                    InStr(1, Series_AN(Cont), "DPR") > 0 Or _
                    InStr(1, Series_AN(Cont), "DPD") > 0) Then
        
                MP_Total_PortFolio_AN = MP_Total_PortFolio_AN + (Montos_Series_AN(Cont) / gsValor_DO)
            End If
            
            Cont = Cont + 1
        Loop Until UBound(MP_Limite_Concentracion_AN) + 1 = Cont
        Call Actuliza_Total_PortFolio_AN(MP_Total_PortFolio_AN, Producto)
    '*************
 ElseIf cCartera = "TRADING" Then
    '*** Trading
        Call Actuliza_Securities_Trading_AN(Plazos_AN, Montos_Series_AN, Producto)
    '***********
    
    '*** Total Trading
        Call Actuliza_Total_Securities_Trading_AN(TOTAL_GRILLA_VALOR_PRESENTE_AN, Producto)
    '*****************
 End If
End If

Exit Sub
ERROR_Actualiza_Limtes_Por_Anulacion:
    MsgBox err.Description, vbCritical, "ERROR_Actualiza_Limtes_Por_Anulacion"
End Sub

'******************************************************
'Proceso de Recalculo de Limites INICIO DIA RENTA FIJA
'******************************************************

Function Proc_Recalcula_Limites_ALCO() As Boolean
On Error GoTo ERROR_Proc_Recalcula_Limites_ALCO

OtraVez:

Dim SW_LC, SW_ST, SW_TST, SW_TPF As Boolean
Dim Mensaje As String

Proc_Recalcula_Limites_ALCO = False

Mensaje = Empty

'************************** Limpia  Tablas IBL & BISA
'If Not Proc_Crea_Tablas_IBL_BISA Then
'    MsgBox "Problemas al Intentar Crear Tablas MDCA IBL BISA.", vbExclamation, "Proc_Recalcula_Limites_ALCO"
'    Exit Function
'End If

'************************** IBL  mdca.DBF --> IBL_MDCA SQL Server
'************************** BISA mdca.DBF --> BISA_MDCA SQL Server
'If Not Proc_Ejecuta_DTS Then
'    MsgBox "Problemas al Intentar Subir los Datos de PC-Trader(DBF) a Bac-Trader(SQL Server).", vbExclamation, "Proc_Recalcula_Limites_ALCO"
'    Exit Function
'End If

Dim Cont As Long

For Cont = 1 To 6000

Next

'************************** Recalcula Limite Concentracion
If Not Bac_Sql_Execute("SP_ALCO_INIDIA_RECALCULA_LIMITE_CONCENTRACION") Then
    MsgBox "Problemas al Actulizar Limites RECALCULA_LIMITE_CONCENTRACION. Vuelva a intentarlo.", vbExclamation, "Recalculo de Limites"
Else
    SW_LC = True
    Mensaje = Mensaje + " Limite Concentracion Recalculado, " & Chr(13)
End If
    
'************************** Recalcula Total Portfolio
If Not Bac_Sql_Execute("SP_ALCO_INIDIA_RECALCULA_PORTFOLIO_TRADING_SWAP 2") Then
    MsgBox "Problemas al Actulizar Limites RECALCULA_PORTFOLIO. Vuelva a intentarlo.", vbExclamation, "Recalculo de Limites"
Else
    SW_TPF = True
    Mensaje = Mensaje + " Limite Securitie Portfolio Recalculado, " & Chr(13)
End If

'************************** Recalcula Securitie Trading
If Not Bac_Sql_Execute("SP_ALCO_INIDIA_RECALCULA_LIMITE_SECURITIE_TRADING") Then
    MsgBox "Problemas al Actulizar Limites RECALCULA_LIMITE_SECURITIE_TRADING. Vuelva a intentarlo." & Chr(13) & " Se intentara Recalcularlos Otra Vez.", vbExclamation, "LIMITE SECURITIE TRADING"
Else
    SW_ST = True
    Mensaje = Mensaje + " Limite Securitie Trading Recalculado, " & Chr(13)
End If
'************************** Recalcula Total Securitie PortFolio
If Not Bac_Sql_Execute("SP_ALCO_INIDIA_RECALCULA_PORTFOLIO_TRADING_SWAP 4") Then
    MsgBox "Problemas al Actulizar Limites RECALCULA_TRADING. Vuelva a intentarlo.", vbExclamation, "Recalculo de Limites"
Else
    SW_TST = True
    Mensaje = Mensaje + " Limite Total Securitie Trading Recalculado. " & Chr(13)
End If

'************************** Drop Tablas IBL & BISA
'If Not Proc_Elimina_Tablas_IBL_BISA Then
'    MsgBox "Problemas al Intentar Eliminar Tablas MDCA IBL BISA.", vbExclamation, "Proc_Recalcula_Limites_ALCO"
'    Exit Function
'End If

If Mensaje <> Empty Then
    MsgBox Mensaje, vbInformation, "Recalculo de Limites."
End If

If SW_LC And SW_ST And SW_TST And SW_TPF Then
    Proc_Recalcula_Limites_ALCO = True
Else
    If MsgBox("Se ha Producido un error al Calcular Lineas de Limites, Desea Recalcular Limites Otra Vez?.", vbInformation + vbYesNo, "Limites ALCO") = vbYes Then
        GoTo OtraVez:
    End If
End If

Exit Function
   
ERROR_Proc_Recalcula_Limites_ALCO:
    MsgBox err.Description, vbCritical, "ERROR Recalcula Limites ALCO"
    'Call Proc_Elimina_Tablas_IBL_BISA
    
End Function



' LD1-COR-035--> Segun definicion, este procedimiento ya no es parte del sistema
Function Proc_Elimina_Tablas_IBL_BISA() As Boolean
On Error GoTo Proc_Elimina_Tablas_IBL_BISA
Dim Data()

If Bac_Sql_Execute("SP_ALCO_ELIMINA_DBF_IBL_BISA") Then
    Do While Bac_SQL_Fetch(Data)
        
        If Data(1) = "2" Then
            Proc_Elimina_Tablas_IBL_BISA = True
        Else
            Proc_Elimina_Tablas_IBL_BISA = False
        End If
        
    Loop
End If

Exit Function
Proc_Elimina_Tablas_IBL_BISA:
    MsgBox err.Description, vbCritical, "ERROR Proc Crea Tablas IBL BISA"

End Function

Function Proc_Ejecuta_DTS() As Boolean
On Error GoTo ERROR_Proc_Ejecuta_DTS
Dim SQL_DTS As String

SQL_DTS = "exec msdb..sp_start_job 'DTS_MDCA_UPLOAD_IBL_BISA'"

If Not Bac_Sql_Execute(SQL_DTS) Then
    MsgBox "Problemas al Ejecutar DTS. No se encontro Paquete DTS_MDCA_UPLOAD_IBL_BISA", vbCritical, "Proc_Ejecuta_DTS"
    Proc_Ejecuta_DTS = False
Else
    Proc_Ejecuta_DTS = True
End If

Exit Function
ERROR_Proc_Ejecuta_DTS:
    MsgBox err.Description, vbCritical, "ERROR_Proc_Ejecuta_DTS"
End Function

Function Proc_BCP_IBL_BISA() As Boolean
On Error GoTo ERROR_Proc_BCP_IBL_BISA
    
    Proc_BCP_IBL_BISA = False
        
        Call Abrir_Tabla_Cartera_PCTrader
    
        If SW_DBF_IBL And SW_DBF_BISA Then
            Call PROC_SUBIDA_IBL_BISA
        Else
            Exit Function
        End If
    
        Call Cerrar_Tabla_Cartera_PCTrader
    
    Proc_BCP_IBL_BISA = True
    
Exit Function
ERROR_Proc_BCP_IBL_BISA:
    MsgBox err.Description, vbExclamation, "ERROR_Proc_BCP_IBL_BISA"
    
End Function

Function Abrir_Tabla_Cartera_PCTrader()
On Error GoTo ERROR_Abrir_Tabla_Cartera_PCTrader

SW_DBF_BISA = False
SW_DBF_IBL = False

If gsBac_DBF_Path_Cartera_BISA <> Empty And gsBac_DBF_Path_Cartera_IBL <> Empty Then
If Dir(gsBac_DBF_Path_Cartera_BISA & "\") <> Empty And Dir(gsBac_DBF_Path_Cartera_IBL & "\") <> Empty Then
   ODBC_DBF_ATRIBUTOS = "DSN=" & "SQL_BISA_BTR" & ";uid=;pwd=;defaultdir=" & gsBac_DBF_Path_Cartera_BISA
   DBEngine.RegisterDatabase "SQL_BISA_BTR", "Microsoft dBase Driver (*.dbf)", True, ODBC_DBF_ATRIBUTOS

   ODBC_DBF_ATRIBUTOS = "DSN=" & "SQL_IBL_BTR" & ";uid=;pwd=;defaultdir=" & gsBac_DBF_Path_Cartera_IBL
   DBEngine.RegisterDatabase "SQL_IBL_BTR", "Microsoft dBase Driver (*.dbf)", True, ODBC_DBF_ATRIBUTOS

   If BD_MDCA_IBL.State = 0 Then
        BD_MDCA_IBL.Open "SQL_IBL_BTR"
        SW_DBF_IBL = True
   End If

   If BD_MDCA_BIS.State = 0 Then
        BD_MDCA_BIS.Open "SQL_BISA_BTR"
        SW_DBF_BISA = True
   End If
Else
    MsgBox "No se encontro la Path de cartera Bisa " & gsBac_DBF_Path_Cartera_BISA & ", y la Path cartera Boston " & gsBac_DBF_Path_Cartera_IBL, vbCritical, TITSISTEMA
End If

Else
    MsgBox "No se encontro la Path de cartera Bisa " & gsBac_DBF_Path_Cartera_BISA & ", y la Path cartera Boston " & gsBac_DBF_Path_Cartera_IBL, vbCritical, TITSISTEMA
End If

Exit Function
ERROR_Abrir_Tabla_Cartera_PCTrader:
    MsgBox err.Description & Chr(13) & " Problablemente la Path " & gsBac_DBF_Path_Cartera_BISA & " no esta Lista." & Chr(13) & " Asegurese que la Path este Correcta y vuelva a intentarlo.", vbExclamation, TITSISTEMA

End Function

Function Cerrar_Tabla_Cartera_PCTrader() As Boolean
On Error GoTo ERROR_Cerrar_Tabla_Cartera_PCTrader
Cerrar_Tabla_Cartera_PCTrader = False

    If BD_MDCA_IBL.State <> 0 Then
        BD_MDCA_IBL.Close
    End If

    If BD_MDCA_BIS.State <> 0 Then
        BD_MDCA_BIS.Close
    End If

Cerrar_Tabla_Cartera_PCTrader = True
Exit Function

ERROR_Cerrar_Tabla_Cartera_PCTrader:
    MsgBox err.Description, vbCritical, TITSISTEMA

End Function

Function PROC_SUBIDA_IBL_BISA() As Boolean
Dim sData As String
Dim Fila, Col As Long
Dim Paso As String
Dim BCP_CMD As String

On Error GoTo ERROR_PROC_SUBIDA_IBL_BISA

If SW_DBF_BISA Then
    
    Set MDCA_BIS = BD_MDCA_BIS.Execute("select * from mdca")
    sData = Empty
    Fila = 0
    Col = 0
    Do
        Col = 0
        Do
            If IsNull(MDCA_BIS(Col)) Then
                Paso = " "
            ElseIf IsDate(MDCA_BIS(Col)) Then
                Paso = Format(MDCA_BIS(Col), "YYYYMMDD")
            ElseIf IsNumeric(MDCA_BIS(Col)) Then
                Paso = REEMPLAZA_COMA_PUNTO(MDCA_BIS(Col))
            Else
                Paso = "'" & MDCA_BIS(Col) & "'"
            End If
            
            sData = sData & Paso & ";"
            Col = Col + 1
            
        Loop Until Col = 77
        
        sData = sData & Chr(13) + Chr(10)
        Fila = Fila + 1
        MDCA_BIS.MoveNext
        
    Loop Until MDCA_BIS.EOF
    
    MDCA_BIS.Close
    
    If Dir(WinPath & "BISA_MDCA.txt") <> Empty Then
        Kill WinPath & "BISA_MDCA.txt"
    End If
    
    Open WinPath & "BISA_MDCA.txt" For Binary Access Write As #1
    Put #1, , sData
    Close #1
        
    BCP_CMD = "BCP " & gsSQL_Database & "..BISA_MDCA in " & WinPath & "BISA_MDCA.txt" & " -S" & gsSQL_Server & " -P" & gsSQL_Password & " -U" & gsSQL_Login & " -t; -c"

    If Shell(BCP_CMD, vbNormalFocus) = -1 Then
        MsgBox "Fallo BCP." & BCP_CMD, vbExclamation, "BCP"
    End If
End If
    

If SW_DBF_IBL Then
    Set MDCA_IBL = BD_MDCA_IBL.Execute("select * from mdca")

    Do
        Col = 0
        Do
            If IsNull(MDCA_IBL(Col)) Then
                Paso = " "
            Else
                Paso = MDCA_IBL(Col)
            End If
            
            sData = sData & Paso & ";"
            Col = Col + 1
            
        Loop Until Col = 50
        
        sData = sData & Chr(13) + Chr(10)
        Fila = Fila + 1
        MDCA_BIS.MoveNext
        
    Loop Until MDCA_IBL.EOF
    
    MDCA_IBL.Close
    
    If Dir(WinPath & "IBL_MDCA.txt") <> Empty Then
        Kill WinPath & "IBL_MDCA.txt"
    End If
    
    Open WinPath & "\IBL_MDCA.txt" For Binary Access Write As #1
    Put #1, , sData
    Close #1

End If

Exit Function
ERROR_PROC_SUBIDA_IBL_BISA:
    MsgBox err.Description, vbCritical, TITSISTEMA
    Resume Next
End Function

Function WinPath() As String
Dim sSave As String, Ret As Long

    sSave = Space(255)
    Ret = GetSystemDirectory(sSave, 255)
    WinPath = Left$(sSave, Ret) & "\"
  
End Function

Function Aprobacion_Pantalla(Codigo_Grupo_Limite As Integer, Codigo_Limite As Integer) As Boolean

    On Error GoTo ERROR_Aprobacion_Pantalla
    
    gCodigo_Grupo_Limite = Codigo_Grupo_Limite
    gCodigo_Limite = Codigo_Limite
    If SW_TASA_TRAN <> 1 Then
        If Codigo_Grupo_Limite <> 5 Then
            'BacLimiteALCO.Caption = TraeGlosaLimite(Codigo_Grupo_Limite, Codigo_Limite) + " ESTA EXCEDIDO"
        Else
            'BacLimiteALCO.Caption = TraeGlosaLimite(Codigo_Grupo_Limite, Codigo_Limite)
        End If
    End If
    
    'BacLimiteALCO.Show 1
   
     
     
     
    'If BacLimiteALCO.Tag = "NO" Then
       ' Aprobacion_Pantalla = False
    'Else
     '   Aprobacion_Pantalla = True
   ' End If
    
Exit Function

ERROR_Aprobacion_Pantalla:
        MsgBox err.Description, vbCritical, "ERROR_Aprobacion_Pantalla"

End Function

Function TraeGlosaLimite(Codigo_Grupo_Limite As Integer, Codigo_Limite As Integer) As String

    Dim DATOS_VLA()
    
    SQL_VLA = "SP_ALCO_TRAE_GLOSA_LIMITE " & Codigo_Grupo_Limite & "," & Codigo_Limite
    TraeGlosaLimite = ""
    If Bac_Sql_Execute(SQL_VLA) Then
        If Bac_SQL_Fetch(DATOS_VLA) Then
            TraeGlosaLimite = DATOS_VLA(1)
        Else
            MsgBox "No Existe Limite "
        End If
    Else
        MsgBox "Problemas al Ejecutar la Consulta de Glosa Tipo Limite", vbCritical, TITSISTEMA
    End If

End Function
Sub Actualiza_Trading_VP(CarteraVP() As Variant, Nominal() As Variant, Montos() As Variant, MontosMERC() As Variant, PlazosVp() As Variant, SeriesVp() As Variant, EmisoresVp() As Variant)
Dim I, Cont As Integer

If UBound(Nominal_Series_VP) <= -1 Then Exit Sub

For I = 1 To UBound(CarteraVP)
'********* VP
    If CarteraVP(I) = 2 Then  ' "AVAILABLE FOR SALE"
        If Grabacion_Operacion Then ' Limite Concentracion
            Cont = 1
            ReDim MP_Limite_Concentracion_VP(UBound(SeriesVp))
            Do
                If Valida_Instrumento(Codigos(Cont), Emisores_VP(Cont)) Then
                   MP_Limite_Concentracion_VP(Cont) = CDbl(Nominal(Cont))
                End If
                Cont = Cont + 1
                
            Loop Until UBound(Nominal_Series_VP) + 1 = Cont
            Call Actualiza_Limite_Concentracion_VP(SeriesVp, MP_Limite_Concentracion_VP, EmisoresVp())
        End If
        
        If Grabacion_Operacion Then 'Actualiza Total Portfolio
            Cont = 1
            MP_Total_PortFolio_VP = 0
            Do
                If Not (InStr(1, Series_Vp(Cont), "DPF") > 0 Or _
                        InStr(1, Series_Vp(Cont), "DPR") > 0 Or _
                        InStr(1, Series_Vp(Cont), "DPD") > 0) Then
            
                    MP_Total_PortFolio_VP = MP_Total_PortFolio_VP + (Montos(Cont) / gsValor_DO)
                End If
                Cont = Cont + 1
            Loop Until UBound(MP_Limite_Concentracion_VP) + 1 = Cont
            Call Actuliza_Total_PortFolio_VP(MP_Total_PortFolio_VP)
        End If
    ElseIf CarteraVP(I) = 1 Then  ' "TRADING" Then
        If Grabacion_Operacion Then 'Actualiza Securitie Trading
            Call Actuliza_Securities_Trading_VP(PlazosVp, MontosMERC)
        End If
            
        If Grabacion_Operacion Then ' Actualiza Total Securitie Trading
            Call Actuliza_Total_Securities_Trading_VP(TOTAL_GRILLA_VALOR_MERCADO)
        End If
    End If
'************* FIN VP *******************
Next I
End Sub



