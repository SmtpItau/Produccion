Attribute VB_Name = "BacGenSwaps"
Option Explicit
Global Tipo_Producto As String

Global nPorcentaje As Double
Global nPorcMinimo As Double
Global nPorcMaximo As Double


Public Function Proc_Valida_Tasa_Transferencia(nTasaCompra As Double, nTasaTrans As Double, ByRef cmensaje As String) As Boolean

    Proc_Valida_Tasa_Transferencia = False

    nPorcMaximo = nTasaCompra + (nTasaCompra * (nPorcentaje / 100))
    nPorcMinimo = nTasaCompra - (nTasaCompra * (nPorcentaje / 100))

    '- Control para Variación con Tasa de Transferencia Negativa. -'
    If nTasaTrans < 0 Then
       nPorcMaximo = nTasaCompra - (nTasaCompra * (nPorcentaje / 100))
       nPorcMinimo = nTasaCompra + (nTasaCompra * (nPorcentaje / 100))
    End If
    
    If nTasaTrans < nPorcMinimo Then
        cmensaje = "La tasa + spread de transaccion ingresada esta por debajo del porcentaje minimo de margen de transaccion" + vbCrLf + vbCrLf + "Valor Minimo : " + CStr(nPorcMinimo)
        Exit Function
    End If

    If nTasaTrans > nPorcMaximo Then
        cmensaje = "La tasa + spread ingresada sobrepasa el porcentaje maximo de margen de transaccion" + vbCrLf + vbCrLf + "Valor Maximo : " + CStr(nPorcMaximo)
        Exit Function
    End If

    Proc_Valida_Tasa_Transferencia = True

End Function

Public Sub Proc_Consulta_Porcentaje_Transacciones(cModulo As String)

    Dim Datos()
    Envia = Array()
    AddParam Envia, GLB_ID_SISTEMA
    AddParam Envia, cModulo
    
    If Not Bac_Sql_Execute("BACPARAMSUDA..SP_LEE_PORCENTAJE_TRANSFERENCIA", Envia) Then
        Screen.MousePointer = vbDefault
        MsgBox "Ha ocurrido un error al intentar recuperar el porcentaje de margen de transacciones", vbCritical + vbOKOnly
        Exit Sub
    End If
  
    nPorcentaje = 0
  
    If Bac_SQL_Fetch(Datos()) Then
        nPorcentaje = Val(Datos(1)) 'valor
    End If

End Sub
Public Function Func_Cartera(Combo As ComboBox, Sistema As String)
Dim Sql   As String
Dim Datos()
Dim i As Integer
    
Combo.Clear

Combo.AddItem "< TODAS >"
Combo.ItemData(Combo.NewIndex) = 0


Envia = Array()

    AddParam Envia, Sistema

    SQL = "BACPARAMSUDA..SP_LEECARTERASISTEMA"
   If Not Bac_Sql_Execute(SQL, Envia) Then
      Screen.MousePointer = 0
      Exit Function
   Else
      Do While Bac_SQL_Fetch(Datos())
           
           Combo.AddItem UCase(Datos(2))
           Combo.ItemData(Combo.NewIndex) = Val(Datos(1))
           
      Loop
   End If

If Combo.ListCount > 0 Then Combo.ListIndex = 0

End Function



Public Sub GRABA_LOG_AUDITORIA(codigoMenu, CodigoEvento, _
DetalleModificacion, TablaInvolucrada, ValorAntiguo, ValorNuevo As String)

Dim Tran As String
 
 Tran = giSQL_DatabaseCommon & "..SP_LOG_AUDITORIA" & " '" & 1 & "','" & Format(gsBAC_Fecp, "yyyymmdd") _
        & "', '" & gsBAC_IP & "', '" & gsBAC_User & _
        "', '" & "PCS" & "','" & codigoMenu & "','" & CodigoEvento & "','" & DetalleModificacion & "', '" _
        & TablaInvolucrada & "', '" & ValorAntiguo & "', '" & ValorNuevo & "'"
        
If Not Bac_Sql_Execute(Tran) Then
    MsgBox "Problemas al Grabar Log de Auditoria.", vbCritical
Else
    'grabacion exitosa
End If
  
End Sub
Function ValorAmort(Combo As Object, Desglose) As Integer

If Desglose = "D" Then
     'Total de dias real para Amortizacion Capital
    ValorAmort = Val(Right(Combo.ItemData(Combo.ListIndex), 3))
        
ElseIf Desglose = "M" Then
    'Total de meses real para Amortizacion Capital
    ValorAmort = Val(Left(Combo.ItemData(Combo.ListIndex), 2))
    
    If ValorAmort <> 12 And ValorAmort <> -1 Then
        ValorAmort = Val(Left(ValorAmort, 1))
    End If
    
End If

End Function
Function ValorTasaPeriodo(ByRef Asoc(), codigo, Periodo, Max) As Double
On Error GoTo Control:

Dim i As Long
Dim tot As Long

'*************************************************************************
'*           Busca Valor de la Tasa respecto al periodo almacenada en arreglo                *
'*************************************************************************

tot = Max

    For i = 1 To tot
        
        If codigo = Asoc(1, i) And Periodo = Asoc(2, i) Then
            ValorTasaPeriodo = Asoc(3, i)
            i = i + 1
            Exit For
        End If
    
    Next
    
Exit Function

Control:

    
End Function

Public Sub COMPARA_VALORES(ByRef VAnterior As String, ByRef VNuevo As String)
Dim Depura, Depura2 As String
Dim i, Co As Integer
Dim last_pos As Integer
Dim Arreglo()
Dim BVA, BVN As String
Dim VA(100), VN(100)

Depura = VAnterior
Depura2 = VNuevo
last_pos = 1
Co = 0
i = 0

For i = 1 To Len(Depura)
    
    If Mid(Depura, i, 1) = ";" Then
            
        VA(Co) = Mid(Depura, last_pos, i - last_pos)
        
        'MsgBox VA(Co)
        
        Co = Co + 1
        last_pos = i + 1
        
    End If
Next

i = 0
last_pos = 1
Co = 0

For i = 1 To Len(Depura2)
    
    If Mid(Depura2, i, 1) = ";" Then
       
        VN(Co) = Mid(Depura2, last_pos, i - last_pos)
        
        'MsgBox VN(Co)
        
        Co = Co + 1
        last_pos = i + 1
                
    End If
Next

i = 0
ValorA = ""
ValorN = ""

For i = 0 To 100

    If VA(i) <> VN(i) Then
    
        ValorA = ValorA + " " + VA(i) & ";"
    
        ValorN = ValorN + " " + VN(i) & ";"
    
    End If

Next i

    VAnterior = ValorA
    VNuevo = ValorN

End Sub


Function DatosBarraSistema()

With BACSwap
    .PnlEstado.Caption = Space(1) + gsBAC_Clien
   .PnlFecha.Caption = Format(gsBAC_Fecp, gsc_FechaDMA)
   .Pnl_UF.Caption = "U.F. : " & Format(gsBAC_ValmonUF, "###,##0.###0")
   .Pnl_DO.Caption = "D.O. : " & Format(gsBAC_DolarObs, "###,##0.###0")
   .PnlUsuario.Caption = gsBAC_User
   
End With

End Function

Public Function EstadoGrilla(grillas As Object)

 With grillas
 
        .Enabled = False
        .TopRow = 1
        .LeftCol = IIf(.ColWidth(0) < 100, 1, 0)
        .Row = 1
        .Col = 0
        .Enabled = True
        '.SetFocus
        
 End With
        
End Function

Public Sub PROC_ISNUM_GRILLA(ByRef Grilla As Control, Row As Long, Col As Long)

  
  With Grilla
          
         .Row = Row
         .Col = Col
         
         If Not IsNumeric(.TextMatrix(.Row, .Col)) Then
                 .TextMatrix(.Row, .Col) = "0.0"
         End If
        
  End With
       
End Sub

Public Function FUNC_SACACOMA_GRILLA(nMonto As Variant) As String
Dim sCadena       As String
Dim iPosicion     As Integer
Dim sFormato      As String

   
   sCadena = CStr(nMonto)
   FUNC_SACACOMA_GRILLA = sCadena
        
     iPosicion = 1
     
   Do While iPosicion > 0
        
         iPosicion = InStr(1, sCadena, ".")

        If iPosicion = 0 Then
           Exit Do
         Else
            sCadena = Mid$(sCadena, 1, iPosicion - 1) + Mid$(sCadena, iPosicion + 1)
        End If
   Loop
   
   
 
         iPosicion = InStr(1, sCadena, ",")

         If iPosicion = 0 Then
             FUNC_SACACOMA_GRILLA = sCadena
          Else
             FUNC_SACACOMA_GRILLA = Mid$(sCadena, 1, iPosicion - 1) + "." + Mid$(sCadena, iPosicion + 1)
         End If
 
   

End Function
Function FechaYMD(sFecha) As String

    FechaYMD = Format(sFecha, "yyyymmdd")

End Function

Function Glosas(sTabla$, lCodigo&) As String

    Glosas = "???"

    Select Case UCase(Trim(sTabla$))
    Case "ESTADO"
        Select Case lCodigo
        Case 0: Glosas = "Vencida"
        Case 1: Glosas = "Vigente"
        Case 2: Glosas = "Venciendo"
        End Select
    
    Case "MONEDA"
        Select Case lCodigo
        Case 13: Glosas = "Dolar USA"
        Case 72: Glosas = "Yen Japones"
        Case 994: Glosas = "Dolar Observado"
        Case 998: Glosas = "Unidad de Fomento"
        Case 999: Glosas = "Pesos"
        Case Else: Glosas = "Moneda Extranjera"
        End Select
    
    Case "GRABAR"
        Select Case lCodigo
        Case 0: Glosas = "Nueva"
        Case 1: Glosas = "Modificada"
        End Select
    
    Case Else
        Glosas = "TABLA NO DEFINIDA"
    End Select
    
End Function

Function IsMonedaNacional(codigo%) As Boolean
Dim Monedas$

    Monedas$ = "994,995,998,999"

    IsMonedaNacional = (InStr(Monedas$, Format(codigo, "000")) > 0)

End Function

Function ColorOptionButton(ByRef coleccion As Collection, ByRef objeto As OptionButton)
Dim MiObjeto

    For Each MiObjeto In coleccion
        MiObjeto.ForeColor = &H808000

    Next MiObjeto
        objeto.ForeColor = &H80&

End Function
Public Function BacFechaStr(sfec$) As String

    BacFechaStr = ""
    BacFechaStr = " " & Format(sfec$, "dddd, d mmmm yyyy")

End Function
Function LlenaMonDocPago(Combo As Object, ByRef Asoc(), desde, codigo, Max, factor)
On Error GoTo Control:

Dim i, j As Long
Dim tot As Long
Dim colCod As Integer
Dim colDesc As Integer
Dim colCodigo As Integer
Dim codAnt As Integer
Dim CodMon As Integer
'*************************************************************************
'*  Función que llena combos Monedas de Pago Asociados a la moneda de Operacion *
'*  llena combos de Documentos de Pago asociados a la Moneda de Pago                   *
'*************************************************************************

tot = Max

colCod = factor
colDesc = (2 * factor) + 1
colCodigo = (2 * factor)
CodMon = Asoc(1, desde)

Combo.Clear
    For i = desde To tot
        
        If Val(codigo) = Val(Asoc(colCod, i)) Then
            Combo.Tag = i
            CodMon = Asoc(1, i)
            Do While Val(codigo) = Val(Asoc(colCod, i)) And Val(CodMon) = Val(Asoc(1, i))
                If codAnt <> Asoc(colCodigo, i) Then
                    Combo.AddItem Asoc(colDesc, i)
                    Combo.ItemData(Combo.NewIndex) = Asoc(colCodigo, i)
                    codAnt = Asoc(colCodigo, i)
                End If
                i = i + 1
                If i > tot Then Exit Do
            Loop
            Exit For
        End If
    
    Next
    
Exit Function

Control:

    
End Function

Function CreaFechaProx(Fecha, Plazo, dia, TipoAmort As String) As Date
'DEVUELVE PROXIMA FECHA DE VENCIMIENTO
'VALIDA QUE SEA DIA HABIL

Dim Fecha12$
Dim miFecha As String

Dim EsFinMes As Boolean
    
       
If TipoAmort = "M" Then
    ' si en la amortizacion las fecha suman MESES
    'If dia < 30 Then
        If dia <> Day(CDate(Fecha)) Then
            
            miFecha = BacPrevHabil(Str(Fecha))
            
            If dia > 29 Then
                Do While dia <> Day(CDate(miFecha))
                    EsFinMes = BACFinMES(miFecha)
                    If Not EsFinMes Then
                        miFecha = DateAdd("d", 1, miFecha)
                    Else
                        Exit Do
                    End If
                Loop
                
                Fecha12$ = DateAdd("m", Plazo, miFecha)
                
                If Day(CDate(Fecha12$)) <> dia Then
                    
                    If dia = 31 Then
                        Fecha12$ = BacUltimoDia(Fecha12$, "SI")
                    ElseIf dia = 30 And Month(CDate(Fecha12$)) <> 2 Then
                       
                        Fecha12$ = dia & Mid(Fecha12$, 3, Len(Fecha12$))
                    
                    End If
                End If
                
            
            Else
            
                Do While dia <> Day(CDate(miFecha))
                    miFecha = DateAdd("d", 1, miFecha)
                '    miFecha = Format(DateAdd("d", -1, Fecha), gsc_FechaDMA)
                    
                Loop
                Fecha12$ = DateAdd("m", Plazo, miFecha)
                
            End If
        Else
            miFecha = Fecha
            Fecha12$ = DateAdd("m", Plazo, miFecha)
        End If
            
'          Fecha12$ = DateAdd("m", Plazo, miFecha)
'          If Day(CDate(Fecha12$)) < Day(CDate(miFecha)) Then
'              'Fecha12$ = DateAdd("d", 1, Fecha12$)
'          ElseIf Day(CDate(Fecha12$)) < dia And dia = 31 Then
'                Fecha12$ = BacUltimoDia(Fecha12$, "SI")
'                'Fecha12$ = DateAdd("d", 1, Fecha12$)
'          End If
'
ElseIf TipoAmort = "D" Then
    ' si en la amortizacion las fecha suman DIAS
    Fecha12$ = DateAdd("d", Plazo, CDate(Fecha))
      
End If
   
               CreaFechaProx = ValidaFecha(Fecha12$)
   
End Function
Function BACFinMES(Fecha) As Boolean
BACFinMES = False
    If Day(CDate(Fecha)) = 30 And (Month(CDate(Fecha)) = 11 Or Month(CDate(Fecha)) = 4 Or Month(CDate(Fecha)) = 6 Or Month(CDate(Fecha)) = 11) Then
        BACFinMES = True
    ElseIf Day(CDate(Fecha)) = 31 And (Month(CDate(Fecha)) = 1 Or Month(CDate(Fecha)) = 3 Or Month(CDate(Fecha)) = 5 Or Month(CDate(Fecha)) = 7 Or Month(CDate(Fecha)) = 31 Or Month(CDate(Fecha)) = 10 Or Month(CDate(Fecha)) = 12) Then
        BACFinMES = True
    ElseIf (Day(CDate(Fecha)) = 28 Or Day(CDate(Fecha)) = 29) And Month(CDate(Fecha)) = 2 Then
        BACFinMES = True
        
    End If


End Function


Sub MonYDocxMoneda(ByRef Asociados(), ByRef total)
Dim Sql As String
Dim Datos()
Dim i As Integer
'*********************************************************************
'Se guarda en arreglo dinámico monedas de operacion con las monedas de pago y
'documentos de pago asociado a éstas, para una busqueda rápida desde la ejecución
'del programa
'*********************************************************************
    
Envia = Array()
AddParam Envia, Trim(Sistema)
i = 0
If Not Bac_Sql_Execute("SP_MONDOCXMONEDA", Envia) Then
   Screen.MousePointer = 0
'   Exit Function
Else
   i = 1
   While Bac_SQL_Fetch(Datos())
      ReDim Preserve Asociados(5, i)
      Asociados(1, i) = Val(Datos(1))   'Codigo Moneda Operación
      Asociados(2, i) = Val(Datos(2))   'Codigo moneda de Pago
      Asociados(3, i) = Datos(3)        'Nombre moneda de Pago
      Asociados(4, i) = Val(Datos(4))   'Codigo de Documento de Pago
      Asociados(5, i) = Datos(5)        'Nombre de Documento de Pago
      i = i + 1
   Wend
   total = i - 1
End If

End Sub


Function SacaCodigo(Combo As Object) As Double
    'Devuelve codigo o valores que estan en el itemdata del combo
    Dim Cod As Double
    
    Cod = 0
    If Combo.ListCount > 0 Then
        If Combo.ListIndex <> -1 Then
            Cod = Combo.ItemData(Combo.ListIndex)
        End If
    End If
    
    SacaCodigo = Cod
    
End Function
Function LlenaComboPagRec(Combo As Object, CodMon As Integer)

'Saca datos tabla mdtc y llena combo
Dim Sql   As String
Dim Datos()
Dim i As Integer

Combo.Clear

'    Sql = "EXEC " & giSQL_DatabaseCommon & "..sp_leerdocumentosmoneda "
'    Sql = Sql & "'" & Sistema & "', "
'    Sql = Sql & CodMon
'
'    If MISQL.SQL_Execute(Sql) <> 0 Then
'        MsgBox "No se encontraron formas de Pago asociadas a ésta Moneda!", vbInformation, Msj
'        Exit Function
'    End If
'
'    Do While MISQL.SQL_Fetch(DATOS()) = 0
'            combo.AddItem DATOS(2) '& Space(100) & Datos(3)
'            combo.ItemData(combo.NewIndex) = Val(DATOS(1))
'    Loop

Envia = Array()
AddParam Envia, Sistema
AddParam Envia, CDbl(CodMon)
   
If Not Bac_Sql_Execute("SP_LEERDOCUMENTOSMONEDA", Envia) Then
   MsgBox "No se encontraron formas de Pago asociadas a ésta Moneda!", vbInformation, Msj
   Screen.MousePointer = 0
   Exit Function
Else
   Do While Bac_SQL_Fetch(Datos())
      Combo.AddItem Datos(2)
      Combo.ItemData(Combo.NewIndex) = Val(Datos(1))
   Loop
End If
    
    'Combo.ListIndex = 0
           
End Function

Function BuscaCmbAmortiza(Combo As Object, Cod)
Dim i

    If Combo.ListCount = 0 Then Exit Function
    
    For i = 0 To Combo.ListCount - 1
        If Val(Trim(Right(Combo.List(i), 10))) = Cod Then
            Combo.ListIndex = i
            Exit For
        End If
    Next

End Function

Sub CargaCombos(oCombo As ComboBox, nCodigo As Integer, cSistema As String, cStorProc As String, nPosIni As Integer, nPos1 As Integer, nPos2 As Integer)
Dim Sql As String
Dim Datos()

With oCombo
    
'    Sql$ = giSQL_DatabaseCommon & ".." & cStorProc
'    Sql$ = Sql & " '" & Trim(cSistema$) & "',"
'    Sql$ = Sql & Trim(Str(nCodigo))
    
    .Clear
    
    
'    If MISQL.SQL_Execute(Sql$) = 0 Then
'       While MISQL.SQL_Fetch(DATOS()) = 0
'             .AddItem DATOS(nPos1)
'             .ItemData(.NewIndex) = Val(DATOS(nPos2))
'       Wend
       '.Text = .List(nPosIni)
       '.Text = .List(nPosIni)
'    End If
    
Envia = Array()
AddParam Envia, cSistema
AddParam Envia, Trim(Str(nCodigo))
   
If Not Bac_Sql_Execute(cStorProc, Envia) Then
   Screen.MousePointer = 0
'   Exit Function
Else
   Do While Bac_SQL_Fetch(Datos())
      .AddItem Datos(nPos1)
      .ItemData(.NewIndex) = Val(Datos(nPos2))
   Loop
End If
    
    
End With

End Sub
Public Function BacIniciaGrilla(Rows As Integer, Cols As Integer, Rowsf As Integer, Colsf As Integer, Valor As Boolean, oGrilla As Object)
    
With oGrilla
     
     .Cols = Cols
     .Rows = Rows
     .FixedCols = Colsf
     .FixedRows = Rowsf
     .Enabled = Valor

End With

End Function

Public Function bacBuscaRepetidoGrilla(Col As Long, Gril As Control, Busca_Col As Variant) As Boolean
Dim Fila%
Dim Row_Old, Col_Old As Long

bacBuscaRepetidoGrilla = False

With Gril
  
    Row_Old = .Row
    Col_Old = .Col
  
    For Fila% = 1 To .Rows - 1
      
        .Row = Fila%
      
        If Trim$(.TextMatrix(.Row, Col)) <> "" Then
            If Trim$(.TextMatrix(.Row, Col)) = Busca_Col Then
                If .Row <> Row_Old Then
                    .Row = Row_Old
                    .Col = Col_Old
                    MsgBox " Existe Codigo en la Tabla ", 16, gsPARAMS_Version
                    bacBuscaRepetidoGrilla = True
                    Exit Function
                End If
            End If
        End If
    
    Next Fila%
   
    .Row = Row_Old
    .Col = Col_Old
   
End With
 
End Function
Public Sub BacAgrandaGrilla(oGrilla As Object, Row_ToTal As Long)
Dim Fila%

   With oGrilla
        
        If .Rows < Row_ToTal Then

            For Fila% = 1 To (Row_ToTal - .Rows)
                .Rows = .Rows + 1
            Next Fila%
            
        Else
            .Rows = .Rows + 1
        End If
      
    End With
      
End Sub
Sub BacSoloNumeros(ByRef KeyAscii As Integer)
   
   'Si No es  Enter y No es BackSpace
   
   If KeyAscii <> 13 And KeyAscii <> 8 Then
      'Si no es numerico
      
        If Not IsNumeric(Chr$(KeyAscii)) Then
               KeyAscii = 0
        End If
      
   End If
   
End Sub

Function LlenaComboCodGeneral(ByRef Combo As ComboBox, TipCodigo As Integer, queSistema As String, _
                                                    indica As Integer)

'Saca datos tabla mdtc y llena combo
Dim Sql   As String
Dim Datos()
Dim i As Integer
    
Envia = Array()

If TipCodigo = 1004 Then
    SQL = "BACPARAMSUDA..SP_MDRCLEERCODIGO "
    AddParam Envia, Tipo_Producto
    AddParam Envia, queSistema
    indica = 9
End If

    Select Case indica
       Case 1
          SQL = "SP_LEER_TC"
          AddParam Envia, CDbl(TipCodigo)
       Case 2
          SQL = "SP_LEER_MONEDA"
       Case 3
          SQL = "SP_MONEDASPAGO"  'Este Sp NO existe en ninguna BD!!
    End Select
    
    Combo.Clear
    
   If Not Bac_Sql_Execute(Sql, Envia) Then
      Screen.MousePointer = 0
      Exit Function
   Else
 
'      Do While MISQL.SQL_Fetch(DATOS()) = 0
    
      Do While Bac_SQL_Fetch(Datos())
    
         If indica = 1 Then
            Combo.AddItem UCase(Datos(3))
            Combo.ItemData(Combo.NewIndex) = Val(Datos(2))
         ElseIf indica = 2 Then
            Combo.AddItem UCase(Datos(4))
            Combo.ItemData(Combo.NewIndex) = Val(Datos(1))
         ElseIf indica = 3 Then
         ElseIf indica = 9 Then
            Combo.AddItem UCase(Datos(2))
            Combo.ItemData(Combo.NewIndex) = Val(Datos(1))
       
         End If
           
    Loop
           
   End If
End Function

'Function CreaFechaProx(Fecha, Diasplazo, aa) As Date
''DEVUELVE PROXIMA FECHA DE VENCIMIENTO
''VALIDA QUE SEA DIA HABIL
'Dim mesesPlazo%, i%, Meses%
'Dim dia%, Mes%, año%, mesAm%, añoAm%
'Dim Fecha12$
'Dim ultdia%
'Dim miFecha As String
'
'    mesesPlazo% = (Diasplazo)
'    miFecha = Fecha
'
'    If aa > 28 Then
'       dia% = aa
'        If aa <> Day(CDate(miFecha)) Then
'            Fecha12$ = BacPrevHabil(miFecha)
'            If Day(Fecha12$) > 1 And Day(Fecha12$) < 10 Then
'                Fecha12$ = CDate(Fecha12$) - Day(Fecha12$)
'            End If
'            'dia% = aa
'            Mes% = Month(CDate(Fecha12$))
'            año% = Year(CDate(Fecha12$))
'        Else
'           Mes% = Month(CDate(Fecha))
'           año% = Year(CDate(Fecha))
'           'meses% = (mes% + mesesPlazo%)
'        End If
'    Else
'        dia% = aa
'        Mes% = Month(CDate(Fecha))
'        año% = Year(CDate(Fecha))
'
'    End If
'
''dia% = aa
''mes% = Month(CDate(Fecha))
''año% = Year(CDate(Fecha))
'Meses% = (Mes% + mesesPlazo%)
'
'
'
'    If Meses% > 12 Then
'        añoAm% = año% + (Int(Meses% / 12))
'
'         If Meses% = ((Int(Meses% / 12)) * 12) Then
'            Meses% = 1
'         Else
'            mesAm% = Meses% - ((Int(Meses% / 12)) * 12)
'         End If
'
'    Else
'        añoAm% = año%
'        mesAm% = Meses%
'    End If
'
'    Fecha12$ = dia% & gsc_FechaSeparador & mesAm% & gsc_FechaSeparador & añoAm%
'
'   If dia% > 28 Then
'        If Not IsDate(Fecha12$) Then
'            Dim aass As String
'
'            aass = "1" & gsc_FechaSeparador & (mesAm%) & gsc_FechaSeparador & (añoAm%)
'
'            ultdia% = Day(CDate(BacUltimoDia(aass, "SI")))
'
'            dia% = dia% - ultdia%
'            'dia% = ultdia%
'            mesAm% = mesAm% + 1
'        End If
'   End If
'
'   Fecha12$ = dia% & gsc_FechaSeparador & mesAm% & gsc_FechaSeparador & añoAm%
'
'   CreaFechaProx = ValidaFecha(Fecha12$)
'
'End Function
Function UltimaFechaFlujo(FechaFlujo As Date, fechaTermino As Date) As Boolean
'si la ultima fecha de flujo no es igual a fecha termino verifica si esta en los 10 dias de "GRACIAS" y cambia la fecha
' de termino de flujo con fecha de termino


'optimizar la consulta AGB
    'UltimaFechaFlujo = FechaFlujo
    UltimaFechaFlujo = False
    If FechaFlujo > fechaTermino Then
         If Abs(DateDiff("d", (FechaFlujo), (fechaTermino))) <= 10 Then
             FechaFlujo = fechaTermino
             UltimaFechaFlujo = True
         End If
    Else
         If Abs(DateDiff("d", CDate(fechaTermino), CDate(FechaFlujo))) <= 10 Then
            FechaFlujo = fechaTermino
            UltimaFechaFlujo = True
        End If
    End If

End Function

Function BacLimpiaNumero(Valor As Variant) As Double
'Devuelve numero sin separador de miles
'Para el dato de USERCONTROL_NUMERO
Dim j%
Dim num

num = 0

    For j% = 1 To Len(Valor)
    
        If Mid(Valor, j%, 1) <> gsc_SeparadorMiles Then
            If Mid(Valor, j%, 1) = gsc_PuntoDecim Then
                num = num & gsc_PuntoDecim
            Else
                num = num & Mid(Valor, j%, 1)
            End If
        End If
    
    Next j%



BacLimpiaNumero = CDbl(num)

End Function

Function ValorMoneda(CodMon As Integer, fechaMon) As Double
Dim ValorMon As New ClsMoneda
    
    ValorMoneda = ValorMon.ValorMoneda(CodMon, CStr(fechaMon))
    
    Set ValorMon = Nothing
    
End Function
Function ValorMontoADolar(Monto As Double, CodMon As Integer, fechaMon) As Double
Dim ValorMon As New ClsMoneda

Dim nTCambio  As Double
Dim Monto_Usd As Double
Dim nEquivUSD As String


   nTCambio = ValorMon.ValorMoneda(CodMon, CStr(fechaMon))
   If ValorMon.LeerxCodigo(CodMon) Then
      nEquivUSD$ = ValorMon.mnrefusd
   End If

   If CodMon = 13 Then
       Monto_Usd = Monto
   Else
       If CodMon = 998 Or CodMon = 999 Then '--- Es Moneda Local
           Monto_Usd = Round(Round(Monto * nTCambio, 0) / IIf(gsBAC_DolarObs = 0, 1, gsBAC_DolarObs), 2)
       ElseIf nEquivUSD$ = "1" Then
           Monto_Usd = Round(Monto * nTCambio, 2)
       Else
           Monto_Usd = Round(BacDiv(Monto, nTCambio), 2)
       End If
   End If
        
    ValorMontoADolar = Monto_Usd
    
    Set ValorMon = Nothing
    
End Function

Function ValidaFecha(FechaAm) As String
    Dim fecPaso As String
    
    fecPaso = FechaAm
    
   Do While Not BacEsHabil(fecPaso)
            FechaAm = CDate(FechaAm) + 1
            fecPaso = FechaAm
    Loop

    ValidaFecha = Format(CDate(FechaAm), "dd/mm/yyyy")
    
End Function

Function LlenaComboAmortizaANT(ByRef Combo As ComboBox, TipCodigo As Integer, queSistema As String)

'Saca datos tabla mdperiodos y llena combo
Dim Sql   As String
Dim Datos()
Dim i As Integer
    
'    Sql = "EXEC " & giSQL_DatabaseCommon & "..sp_leerperiodosAmortiza " & TipCodigo
'    Sql = Sql & ",'" & queSistema & "'"
    
'    If MISQL.SQL_Execute(Sql) <> 0 Then
'        Exit Function
'    End If
     
Combo.Clear
    
'    Do While MISQL.SQL_Fetch(DATOS()) = 0
'         combo.AddItem DATOS(2) & Space(100) & DATOS(1)
'         combo.ItemData(combo.NewIndex) = Val(DATOS(3))
'    Loop
           
Envia = Array()
AddParam Envia, TipCodigo
AddParam Envia, queSistema
   
If Not Bac_Sql_Execute("SP_LEERPERIODOSAMORTIZA", Envia) Then
   Screen.MousePointer = 0
   Exit Function
Else
   Do While Bac_SQL_Fetch(Datos())
      Combo.AddItem Datos(2) & Space(100) & Datos(1)
      Combo.ItemData(Combo.NewIndex) = Val(Datos(3))
   Loop
End If
         
End Function
Function LlenaComboAmortiza(ByRef Combo As ComboBox, TipCodigo As Integer, queSistema As String)
   'Saca datos tabla mdperiodos y llena combo
   Dim Sql   As String
   Dim Datos()
   Dim i As Integer
    
   Envia = Array()
   AddParam Envia, TipCodigo
   AddParam Envia, queSistema
   If Not Bac_Sql_Execute("SP_LEER_PERIODO", Envia) Then
      Screen.MousePointer = 0
      Exit Function
   Else
      Combo.Clear
      Do While Bac_SQL_Fetch(Datos())
         Combo.AddItem Datos(2) & Space(100) & Val(Datos(1))
         If Val(Datos(3)) <> -1 Then
            Combo.ItemData(Combo.NewIndex) = CDbl(Val(Datos(4)) & "00" & Val(Datos(3)))
         Else
            Combo.ItemData(Combo.NewIndex) = -1
         End If
      Loop
   End If
End Function

Function TasasPorMoneda(ByRef Combo As ComboBox, CodMon As Integer, CodSist As Integer, sFecha, Periodo)

'Saca datos tabla mdperiodos y llena combo
Dim Sql   As String
Dim Datos()
Dim i As Integer



Envia = Array()
    AddParam Envia, CDbl(CodMon)
    AddParam Envia, 0
    AddParam Envia, Periodo
    AddParam Envia, sFecha
    
    If Not Bac_Sql_Execute("SP_LEER_TASASMONEDAS", Envia) Then
        MsgBox "No se encontraron Tasas asociadas a ésta Moneda!", vbInformation, Msj
        Exit Function
    End If
    Combo.Clear
    
    'Datos(1) = nombre tasa / Datos(2) = codigo tasa / Datos(3) = valor tasa
    
   
    Do While Bac_SQL_Fetch(Datos())
        'combo.ListIndex = -1
        'Call bacBuscarCombo(combo, Val(Datos(2)))
        'If combo.ListIndex < 0 Then
            If Val(Datos(3)) <> 0 Then
                Combo.AddItem Datos(4) & Space(100) & Datos(8)
                Combo.ItemData(Combo.NewIndex) = Val(Datos(3))
            End If
        'End If
    Loop
    Combo.AddItem "FIJA" & Space(100) & "0"
    Combo.ItemData(Combo.NewIndex) = 0


End Function

Public Function BacMesStr(sfec$) As String

   BacMesStr = ""
    
      Select Case (sfec$)
      Case 1: BacMesStr = "Enero"
      Case 2: BacMesStr = "Febrero"
      Case 3: BacMesStr = "Marzo"
      Case 4: BacMesStr = "Abril"
      Case 5: BacMesStr = "Mayo"
      Case 6: BacMesStr = "Junio"
      Case 7: BacMesStr = "Julio"
      Case 8: BacMesStr = "Agosto"
      Case 9: BacMesStr = "Septiembre"
      Case 10: BacMesStr = "Octubre"
      Case 11: BacMesStr = "Noviembre"
      Case 12: BacMesStr = "Diciembre"
      End Select

End Function

Public Function BacLimpiaGrilla(ByRef Grilla As Object)

Dim m, j As Integer

    For m = 1 To Grilla.Rows - 1
        For j = 0 To Grilla.Cols - 1
            Grilla.TextMatrix(m, j) = ""
        Next
    Next
    
End Function
Function Operadores(obj As Object, lRutCli, lCodCli) As Boolean
Dim objCliente As New clsCliente
      
    Operadores = objCliente.CargaOperador(obj, lCodCli, lRutCli)
    
    Set objCliente = Nothing

End Function

Function Apoderados(obj As Object, lRutCli&, lCodCli&) As Boolean
Dim objCliente As New clsCliente
      
    Apoderados = objCliente.CargaApoderados(obj, lRutCli, lCodCli)
    
    Set objCliente = Nothing

End Function


Function GRABALOG(Evento As String, OpcionSistema As String, NumeroOperacion As String, TipoSwap As Integer, ValorAnterior As String, ValorUltimo As String)

Dim CodEvento As String
Dim Tablas As String
Dim DetalleEvento As String

Tablas = ""
If Evento = "Ingreso" Then
    ValorAnterior = ""
    CodEvento = "01"
    Tablas = "MovDiario-"
ElseIf Evento = "Modificacion" Or Evento = "ModificacionCartera" Then
    Call COMPARA_VALORES(ValorAnterior, ValorUltimo)
    CodEvento = "02"
End If

Tablas = Tablas & "Cartera-Carteralog"

DetalleEvento = Evento & " Operacion " & NumeroOperacion

Select Case TipoSwap
Case 1
    DetalleEvento = DetalleEvento & " Swap de Tasas "
Case 2
    DetalleEvento = DetalleEvento & " Swap de Monedas "
Case 3
    DetalleEvento = DetalleEvento & " FRA "
End Select
DetalleEvento = DetalleEvento & "operacion N. " & NumeroOperacion
DetalleEvento = "operacion N. " & NumeroOperacion

Call COMPARA_VALORES(ValorAnterior, ValorUltimo)

Call GRABA_LOG_AUDITORIA(OpcionSistema, _
                            CodEvento, _
                            DetalleEvento, _
                            Tablas, _
                            ValorAnterior, _
                            ValorUltimo)

End Function
Public Function BacPad(sCadena As String, nLargo As Integer) As String

    Dim nCarac          As Integer

    If Len(sCadena) >= nLargo Then
        BacPad = Mid$(sCadena, 1, nLargo)

    Else
       BacPad = sCadena + Space$(nLargo - Len(sCadena))

    End If

End Function

Public Function BacRuta(sCadena As String) As String

    Dim nCarac  As Integer
    Dim ccadena As String
    nCarac = Len(sCadena)
    ccadena = Mid(sCadena, nCarac, 1)
    If ccadena <> "\" Then
       BacRuta = sCadena + "\"
    Else
       BacRuta = sCadena
    End If

End Function

Function SacaTipoPeriodo(cmb As ComboBox) As String

    If Left(cmb, 1) = "A" Then
        SacaTipoPeriodo = "D"
    Else
        SacaTipoPeriodo = "M"
    End If
    
End Function

Public Function BorrarOpThreshold() As Boolean
'PRD-4858
Dim DATOS()
BorrarOpThreshold = False
Envia = Array()
AddParam Envia, "PCS"
AddParam Envia, Thr_CodProducto
AddParam Envia, Thr_NumeroOperacion

If Not Bac_Sql_Execute("BacParamsuda.dbo.SP_ELIMINA_THRESHOLD_OPERACION", Envia) Then
    BorrarOpThreshold = False
    Exit Function
End If
If Bac_SQL_Fetch(DATOS()) Then
    Select Case DATOS(1)
        Case -1     'Error al eliminar operación
            BorrarOpThreshold = True
        Case 0      'Eliminación exitosa
            BorrarOpThreshold = True
        Case 1      'No hay datos para eliminar
            BorrarOpThreshold = False
    End Select
End If
End Function

