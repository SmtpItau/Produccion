Attribute VB_Name = "BacGenSwaps"
Option Explicit

Public Function EstadoGrilla(Grillas As Object)

 With Grillas
 
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
Function FechaYMD2(sFecha) As String

    FechaYMD2 = Format(sFecha, "yyyymmdd")

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

Dim I, j As Long
Dim Tot As Long
Dim colCod As Integer
Dim colDesc As Integer
Dim colCodigo As Integer
Dim codAnt As Integer
Dim CodMon As Integer
'*************************************************************************
'*  Función que llena combos Monedas de Pago Asociados a la moneda de Operacion *
'*  llena combos de Documentos de Pago asociados a la Moneda de Pago                   *
'*************************************************************************

Tot = Max

colCod = factor
colDesc = (2 * factor) + 1
colCodigo = (2 * factor)
CodMon = Asoc(1, desde)

Combo.Clear
    For I = desde To Tot
        
        If codigo = Asoc(colCod, I) Then
            Combo.Tag = I
            CodMon = Asoc(1, I)
            Do While codigo = Asoc(colCod, I) And CodMon = Asoc(1, I)
                If codAnt <> Asoc(colCodigo, I) Then
                    Combo.AddItem Asoc(colDesc, I)
                    Combo.ItemData(Combo.NewIndex) = Asoc(colCodigo, I)
                    codAnt = Asoc(colCodigo, I)
                End If
                I = I + 1
                If I > Tot Then Exit Do
            Loop
            Exit For
        End If
    
    Next
    
Exit Function

Control:

    
End Function




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


Function CambiaColorCeldas(Grd As Object)
'Para las pantallas de operaciones de Monedas y Tasas

Dim I, j

    With Grd
    For I = 1 To .Rows - 1
        If .TextMatrix(I, .Cols - 1) = "CH" Then
            .Row = I
            For j = 1 To .Cols - 1
                .Col = j
                .CellForeColor = &HFFFFC0
            Next
        End If
    Next
    End With
    
End Function
Function BuscaCmbAmortiza(Combo As Object, Cod)
Dim I

    If Combo.ListCount = 0 Then Exit Function
    
    For I = 0 To Combo.ListCount - 1
        If Val(Trim(Right(Combo.List(I), 10))) = Cod Then
            Combo.ListIndex = I
            Exit For
        End If
    Next

End Function


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
                    MsgBox " Existe Codigo en la Tabla ", 16, TITSISTEMA
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
' FUNCIÒN DUPLICADA
'Public Sub BacAgrandaGrilla(oGrilla As Object, Row_ToTal As Long)
'Dim Fila%
'
'   With oGrilla
'
'        If .Rows < Row_ToTal Then
'
'            For Fila% = 1 To (Row_ToTal - .Rows)
'                .Rows = .Rows + 1
'            Next Fila%
'
'        Else
'            .Rows = .Rows + 1
'        End If
'
'    End With
'
'End Sub
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
   Dim Sql   As String
   Dim Datos()
   Dim I As Integer
    
   'Saca datos tabla mdtc y llena combo
   
   Envia = Array()
   
   Select Case indica
       
       Case 1
           
           sql = "SP_LEER_TC "
           
           AddParam Envia, TipCodigo
   
            If Not Bac_Sql_Execute(Sql, Envia) Then
               
               Exit Function
               
            End If
           
       Case 2
       
           sql = "SP_MONEDAS "
   
            If Not Bac_Sql_Execute(Sql) Then
               
               Exit Function
               
            End If
         
       'Case 3
       '    -- Fecha Omisión : 13/Febrero/2001
       '    Sql = "EXEC " & giSQL_DatabaseCommon & "..sp_monedasPago"
       '
       
   End Select
     
   Combo.Clear
    
   Do While Bac_SQL_Fetch(Datos())
   
      Combo.AddItem Datos(3)
      Combo.ItemData(Combo.NewIndex) = Val(Datos(2))
      
   Loop
           
End Function

Function CreaFechaProx(fecha, Diasplazo, aa) As Date
'DEVUELVE PROXIMA FECHA DE VENCIMIENTO
'VALIDA QUE SEA DIA HABIL
Dim mesesPlazo%, I%, Meses%
Dim dia%, Mes%, año%, mesAm%, añoAm%
Dim Fecha12$
Dim ultdia%
Dim miFecha As String
    
    mesesPlazo% = (Diasplazo)
    miFecha = fecha
    
    If aa > 28 Then
       dia% = aa
        If aa <> Day(CDate(miFecha)) Then
            Fecha12$ = BacPrevHabil(miFecha)
            If Day(Fecha12$) > 1 And Day(Fecha12$) < 10 Then
                Fecha12$ = CDate(Fecha12$) - Day(Fecha12$)
            End If
            'dia% = aa
            Mes% = Month(CDate(Fecha12$))
            año% = Year(CDate(Fecha12$))
        Else
           Mes% = Month(CDate(fecha))
           año% = Year(CDate(fecha))
           'meses% = (mes% + mesesPlazo%)
        End If
    Else
        dia% = aa
        Mes% = Month(CDate(fecha))
        año% = Year(CDate(fecha))
    
    End If
    
'dia% = aa
'mes% = Month(CDate(Fecha))
'año% = Year(CDate(Fecha))
Meses% = (Mes% + mesesPlazo%)
 
 
    
    If Meses% > 12 Then
        añoAm% = año% + (Int(Meses% / 12))
        mesAm% = Meses% - ((Int(Meses% / 12)) * 12)
    Else
        añoAm% = año%
        mesAm% = Meses%
    End If
    
    Fecha12$ = dia% & gsc_FechaSeparador & mesAm% & gsc_FechaSeparador & añoAm%
   
   If dia% > 28 Then
        If Not IsDate(Fecha12$) Then
            Dim aass As String
            
            aass = "1" & gsc_FechaSeparador & (mesAm%) & gsc_FechaSeparador & (añoAm%)
            
            ultdia% = Day(CDate(BacUltimoDia(aass, "SI")))
            
            dia% = dia% - ultdia%
            'dia% = ultdia%
            mesAm% = mesAm% + 1
        End If
   End If
  
   Fecha12$ = dia% & gsc_FechaSeparador & mesAm% & gsc_FechaSeparador & añoAm%
   
   CreaFechaProx = ValidaFecha(Fecha12$)
   
End Function

Function UltimaFechaFlujo(FechaFlujo As Date, FechaTermino As Date) As Boolean
'si la ultima fecha de flujo no es igual a fecha termino verifica si esta en los 10 dias de "GRACIAS" y cambia la fecha
' de termino de flujo con fecha de termino


'optimizar la consulta AGB
    'UltimaFechaFlujo = FechaFlujo
    UltimaFechaFlujo = False
    If FechaFlujo > FechaTermino Then
         If Abs(DateDiff("d", (FechaFlujo), (FechaTermino))) <= 10 Then
             FechaFlujo = FechaTermino
             UltimaFechaFlujo = True
         End If
    Else
         If Abs(DateDiff("d", CDate(FechaTermino), CDate(FechaFlujo))) <= 10 Then
            FechaFlujo = FechaTermino
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
Dim ValorMon As New clsMoneda
    
    ValorMoneda = ValorMon.ValorMoneda(CodMon, CStr(fechaMon))
    
    Set ValorMon = Nothing
    
End Function

Function ValidaFecha(FechaAm) As Date
    Dim fecPaso As String
    
    fecPaso = FechaAm
    
   Do While Not BacEsHabil(fecPaso, "")
            FechaAm = CDate(FechaAm) + 1
            fecPaso = FechaAm
    Loop

    ValidaFecha = CDate(FechaAm)
    
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
Function Operadores(obj As Object, lRutCli&, lCodCli&, tipo%) As Boolean
Dim objCliente As New clsCliente
      
    Operadores = objCliente.CargaOperador(obj, lRutCli, lCodCli, 0)
    
    Set objCliente = Nothing

End Function

Function Apoderados(obj As Object, lRutCli&, lCodCli&, tipo%) As Boolean
Dim objCliente As New clsCliente
      
    Apoderados = objCliente.CargaApoderados(obj, lRutCli, lCodCli, tipo)
    
    Set objCliente = Nothing

End Function


Sub Centra_Form(Pantalla As Form)

  'If mascarita <> 2000 Then Pantalla.Left = ((Screen.Width - Pantalla.Width) / 2):  Pantalla.Top = ((Screen.Height - Pantalla.Height) / 8)
    
End Sub

Function bacBuscarComboR(cControl As Object, nValor As Variant)

   Dim iLin    As Integer

   With cControl
   
      For iLin = 0 To .ListCount - 1
      
         If VarType(nValor) = vbString Then
            If Right(.List(iLin), Len(nValor)) = nValor Then
                .ListIndex = iLin
                Exit For
            End If
            
         ElseIf .ItemData(iLin) = nValor Then
            .ListIndex = iLin
            Exit For

         End If

      Next iLin

   End With

End Function

Public Function FUNC_SACACOMA_GRILLA_STandar(nMonto As Variant) As String

Dim sCadena       As String
Dim iPosicion     As Integer
Dim sFormato      As String

   
   sCadena = CStr(nMonto)
   FUNC_SACACOMA_GRILLA_STandar = sCadena
        
     iPosicion = 1
     
   Do While iPosicion > 0
        
         iPosicion = InStr(1, sCadena, ",")

        If iPosicion = 0 Then
           Exit Do
         Else
            sCadena = Mid$(sCadena, 1, iPosicion - 1) + Mid$(sCadena, iPosicion + 1)
        End If
   Loop
   
         iPosicion = InStr(1, sCadena, ".")

         If iPosicion = 0 Then
             FUNC_SACACOMA_GRILLA_STandar = sCadena
          Else
             FUNC_SACACOMA_GRILLA_STandar = Mid$(sCadena, 1, iPosicion - 1) + "." + Mid$(sCadena, iPosicion + 1)
         End If
 
End Function
