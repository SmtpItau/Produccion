Attribute VB_Name = "BacGarantias"
Declare Sub KeyBD_Event Lib "User32" Alias "keybd_event" (ByVal bVk As Byte, ByVal bScan As Byte, ByVal dwFlags As Long, ByVal dwExtraInfo As Long)
'--- Valor para Control de Garantías
Global gsMONEDA_Codigo As Long
Global gsMONEDA_Meno As String
Global gsMONEDA_Decimales As Long
Global gsMONEDA_Nacional As String

Global Gar_ValorRec     As Double
Global Gar_RutCliente   As Long
Global Gar_CodCliente   As Integer
Global Gar_NumOper      As Long
Global BacDatEmi    As BacDatEmiType
Global Tipo_Carga As String * 2

Type BacTypeChkSerie
    nerror  As Integer
    cMascara    As String
    nCodigo     As Long
    nSerie      As String
    sFamilia    As String    'FLI
    nRutemi     As Long
    nMonemi     As Integer
    fTasemi     As Double
    fBasemi     As Integer
    dFecemi     As String
    dFecVen     As String
    cRefnomi    As String
    cGenemi     As String
    cNemmon     As String
    nCorMin     As Double
    cSeriado    As String
    cLeeEmi     As String
End Type

' Estructura datos de emisión.-
Type BacDatEmiType
    iok             As Integer
    sInstSer        As String * 12
    lRutemi         As Long
    lCodemi         As Long
    iMonemi         As Integer
    sNemo           As String
    sFecEmi         As String * 10
    sFecvct         As String * 10
    dTasEmi         As Double
    iBasemi         As Integer
    sRefNomi        As String * 1
    sLecemi         As String * 6
    sGeneri         As String * 6
    ' para datos extras en ventas
    sFecpcup        As String * 10
    dNumoper        As Double
    sTipoper        As String * 3
    sFecvtop        As String * 10
    iDiasdis        As Integer
End Type


'Tipo de Datos de entrada para el valorizador
'Type BacValorizaInput
'    ModCal    As Integer
'    FecCal    As String
'    Codigo    As Long
'    Mascara   As String
'    MonEmi    As Integer
'    fecemi    As String
'    FecVen    As String
'    TasEmi    As Double
'    BasEmi    As Integer
'    TasEst    As Long
'    Nominal   As Double
'    tir       As Double
'    Pvp       As Double
'    Mt        As Double
'End Type

'Tipo de Datos de Salida para el valorizador
Type BacValorizaOutput
    Nominal     As Double
    tir         As Double
    Pvp         As Double
    Mt          As Double
    MtUM        As Double
    Mt100       As Double
    Van         As Double
    Vpar        As Double
    Numucup     As Integer
    Fecucup     As String
    Intucup     As Double
    Amoucup     As Double
    Salucup     As Double
    Numpcup     As Integer
    Fecpcup     As String
    Intpcup     As Double
    Amopcup     As Double
    Salpcup     As Double
  ' VB +- 17/06/2000 a las 00:10 para controlar Limites
    duratmac  As Double   ' Duration Macaulay
    duratmod  As Double   ' Duration Modificada
    convexid  As Double   ' Convexidad
    
End Type
Public Function Bac_SendKey(ByVal nKey As Integer)
 
   KeyBD_Event nKey, 0, 0, 0
 
End Function
Public Function FilaVacia(ByVal Grilla As MSFlexGrid, ByVal fila As Long) As Boolean
Dim i As Long
Dim Estado As Boolean
Estado = True
For i = 1 To Grilla.Cols - 1
    If Trim(Grilla.TextMatrix(fila, i)) <> "" Then
        Estado = False
        Exit For
    End If
Next i
FilaVacia = Estado
End Function
Function LOAD_Destinatarios(ByVal Combo As ComboBox) As Boolean
   Dim Datos()

   If Not Bac_Sql_Execute("bacparamsuda.dbo.SP_GAR_TIPO_DESTINATARIO") Then
      Call MsgBox("Se ha generado un error en la carga de Información.", vbExclamation, App.Title)
      Exit Function
   End If
  
   'CmbTipoDestino.Clear
   Combo.Clear
   Do While Bac_SQL_Fetch(Datos())
      'CmbTipoDestino.AddItem Datos(2)
      'CmbTipoDestino.ItemData(CmbTipoDestino.NewIndex) = Datos(1)
      Combo.AddItem Datos(2)
      Combo.ItemData(Combo.NewIndex) = Datos(1)
   Loop
End Function
Function LOAD_TiposGarantias(ByVal Combo As ComboBox, ByVal tipo As String) As Boolean
    Dim Datos()
    Dim nomSp As String
    nomSp = "Bacparamsuda.dbo.SP_TIPOSDEGARANTIAS"
    Envia = Array()
    AddParam Envia, UCase(tipo)
    If Not Bac_Sql_Execute(nomSp, Envia) Then
      Call MsgBox("Se ha generado un error en la carga de los Tipos de Garantías.", vbExclamation, App.Title)
      Exit Function
   End If
   Combo.Clear
   Do While Bac_SQL_Fetch(Datos())
    Combo.AddItem Datos(2)
    Combo.ItemData(Combo.NewIndex) = Datos(1)
   Loop
End Function


Public Function funcChkSerie(ByVal cInstser As String, ByRef Sal As BacTypeChkSerie) As Boolean
On Error GoTo ErrorHandler
Dim Datos()

    funcChkSerie = False
    Envia = Array(cInstser)

    If Not Bac_Sql_Execute("bactradersuda.dbo.SP_CHKINSTSER", Envia) Then
        MsgBox "Serie no pudo ser validada", vbExclamation, gsBac_Version
        Exit Function
    End If

    funcChkSerie = True

    If Bac_SQL_Fetch(Datos()) Then
        Sal.nerror = Val(Datos(1))

        If Sal.nerror = 0 Then
            If Format(Datos(10), "yyyymmdd") <= Format(gsbac_fecp, "yyyymmdd") Then
                Call MsgBox("Serie ingresada esta vencida ", vbInformation, gsBac_Version)
                funcChkSerie = False
                Exit Function
            End If

            With Sal
                .cMascara = Datos(2)
                .nCodigo = Val(Datos(3))
                .nSerie = Datos(4)
                .nRutemi = Val(Datos(5))
                .nMonemi = Val(Datos(6))
                .fTasemi = Datos(7)
                .fBasemi = Val(Datos(8))
                .dFecemi = Datos(9)
                .dFecVen = Datos(10)
                .cRefnomi = Datos(11)
                .cGenemi = Datos(12)
                .cNemmon = Datos(13)
                .nCorMin = Val(Datos(14))
                .cSeriado = Datos(15)
                .cLeeEmi = Datos(16)
            End With
        Else
            funcChkSerie = False
            Select Case Sal.nerror
                Case 1: MsgBox "'DD' no es dia", vbExclamation, gsBac_Version
                Case 2: MsgBox "'MM' no es fecha", vbExclamation, gsBac_Version
                Case 3: MsgBox "'YY' no es año", vbExclamation, gsBac_Version
                Case 4: MsgBox "'DDMMAA' o 'AAMMDD' no es fecha", vbExclamation, gsBac_Version
                Case 5: MsgBox "' ' no es blanco", vbExclamation, gsBac_Version
                Case 6: MsgBox "'N' no es número", vbExclamation, gsBac_Version
                Case 7: MsgBox "No Coincidió con ninguna máscara", vbExclamation, gsBac_Version
                Case 8: MsgBox "No existe en familia de instrumentos", vbExclamation, gsBac_Version
                Case 9: MsgBox "No existe en series", vbExclamation, gsBac_Version
                Case 10: MsgBox "No fue posible determinar fecha de vencimiento", vbExclamation, gsBac_Version
                Case 11: MsgBox "Fecha de la serie no es válida", vbExclamation, gsBac_Version
                Case 12:
                    With Sal
                        .nerror = 0
                        .cMascara = Datos(2)
                        .nCodigo = Val(Datos(3))
                        .nSerie = Datos(4)
                        .nRutemi = Val(Datos(5))
                        .nMonemi = Val(Datos(6))
                        .fTasemi = Val(Datos(7))
                        .fBasemi = Val(Datos(8))
                        .dFecemi = Datos(9)
                        .dFecVen = Datos(10)
                        .cRefnomi = Datos(11)
                        .cGenemi = Datos(12)
                        .cNemmon = Datos(13)
                        .nCorMin = Val(Datos(14))
                        .cSeriado = Datos(15)
                        .cLeeEmi = Datos(16)
                    End With

                Case 15: MsgBox "Serie ingresada no es valida", vbExclamation, gsBac_Version
                Case 30: MsgBox "Plazo residual debe ser menor o igual a 180 días", vbExclamation, gsBac_Version
                Case 31: MsgBox "Plazo residual debe ser mayor a 180 días", vbExclamation, gsBac_Version
                Case Else: MsgBox "No se encontró máscara", vbExclamation, gsBac_Version
            End Select
        End If
    Else
        Call MsgBox("No se pudo chequear la serie", vbExclamation, gsBac_Version)
    End If

        Exit Function


ErrorHandler:
    Call MsgBox("Problemas en chequeo de serie : " & Err.Description, vbCritical, gsBac_Version)
    Exit Function

End Function
Function funcBuscaClienteGARANTIA(nRut As Long, nDigito As String, nCodigo As Long, ByRef sNombre As String) As Boolean
Dim sql As String
Dim Datos()
Dim datosSTR As String
Dim nCont As Integer
    
    Let Screen.MousePointer = 11

    funcBuscaClienteGARANTIA = False
    
    Envia = Array()
    AddParam Envia, CDbl(nRut)
    AddParam Envia, nDigito
    AddParam Envia, CDbl(nCodigo)
          
    If Not Bac_Sql_Execute("SP_MDCLLEERRUT", Envia) Then
        
        Call MsgBox("Consulta en BacParametros Ha Fallado. Servidor SQL No Responde", vbCritical, TITSISTEMA)
        Exit Function
    
    End If
       
    If Bac_SQL_Fetch(Datos()) Then
   '       txtrut.Text = Val(Datos(1))
   '       txtDigito.Text = Datos(2)
   '       TxtCodigo.Text = Val(Datos(3))
        sNombre = Datos(4)
    End If
      
    Let funcBuscaClienteGARANTIA = True
    Let Screen.MousePointer = 0
End Function


Function FUNC_Decimales_de_Moneda(vMoneda As Variant) As Long
Dim Datos()
   If Not IsNumeric(vMoneda) Then
      vMoneda = Val(vMoneda)
   End If
If Bac_Sql_Execute("bactradersuda.dbo.SP_CON_INFORMACION_MONEDA", Array(vMoneda)) Then
    Do While Bac_SQL_Fetch(Datos())
        gsMONEDA_Codigo = Datos(1)
        gsMONEDA_Meno = Datos(2)
        gsMONEDA_Decimales = Datos(3)
        gsMONEDA_Nacional = IIf(Datos(4) = 0, "S", "N")
        FUNC_Decimales_de_Moneda = Datos(3)
    Loop
Else
    MsgBox "Problemas con la conneccion de al servidor", vbExclamation
End If

End Function

Function PintaFila(ByVal Grilla As MSFlexGrid, ByVal fila As Integer, ByVal colF As Long, colB As Long) As Boolean
Dim i As Integer
For i = 0 To Grilla.Cols - 1
    Grilla.Row = fila
    Grilla.Col = i
    Grilla.CellForeColor = colF
    Grilla.CellBackColor = colB
Next
End Function

Function MontoFaltaGarantia(ByVal rutClte As Long, ByVal codClte As Integer, ByVal numOperacion As Long, ByRef valorRec As Double) As Double
'primero, determinar el valor del rec de la operación
Dim Datos()
MontoFaltaGarantia = 0#
Envia = Array()
AddParam Envia, gsSistema
AddParam Envia, numOperacion
If Not Bac_Sql_Execute("Bacparamsuda.dbo.SP_RETVALORRECOPERACION", Envia) Then
    MsgBox "Error al recuperar el valor Rec de la operación!", vbExclamation, TITSISTEMA
    MontoFaltaGarantia = 0#
    Exit Function
End If
valorRec = 0#
If Bac_SQL_Fetch(Datos()) <> 0 Then
    valorRec = CDbl(Datos(1))
End If
'luego, determinar si falta o no para la operacion
Envia = Array()
AddParam Envia, rutClte
AddParam Envia, codClte
AddParam Envia, valorRec
If Not Bac_Sql_Execute("Bacparamsuda.dbo.SP_VERIFICASIFALTAGARANTIA", Envia) Then
    MsgBox "Error al verificar falta de Garantía", vbExclamation, TITSISTEMA
    MontoFaltaGarantia = 0#
    Exit Function
End If
If Bac_SQL_Fetch(Datos()) <> 0 Then
    If Datos(1) = "SI" Then
        MontoFaltaGarantia = CDbl(Datos(2))
    Else
        MontoFaltaGarantia = 0#
    End If
End If
End Function
Function CantidadGarantias(ByVal rutClte As Long, ByVal codClte As Integer) As Integer
Dim Datos()
Envia = Array()
AddParam Envia, rutClte
AddParam Envia, codClte
If Not Bac_Sql_Execute("Bacparamsuda.dbo.SP_CANTGARANTIASDISPONIBLES", Envia) Then
    MsgBox "Error al buscar la cantidad de Garantías disponibles del cliente!", vbExclamation, TITSISTEMA
    CantidadGarantias = -1
    Exit Function
End If
If Bac_SQL_Fetch(Datos()) <> 0 Then
    CantidadGarantias = CInt(Datos(1))
End If
End Function
Function ControlGarantias(ByVal rutClte As Long, ByVal codClte As Integer, ByVal numOperacion As Long) As Boolean
    Dim valorRec As Double
    Dim faltanteGarantia As Double
    Dim cantGtias As Integer
    
    Gar_RutCliente = rutClte
    Gar_CodCliente = codClte
    Gar_NumOper = numOperacion
    
    If ProcesarConRecCero() = False Then
        ControlGarantias = False
        Exit Function
    End If
    'comparar el valor del REC de la operación contra el total de garantías disponibles del cliente
    valorRec = 0#
    faltanteGarantia = MontoFaltaGarantia(rutClte, codClte, numOperacion, valorRec)
    If faltanteGarantia > 0# Then
        'Marcar la operación en Líneas agregándole mensaje que cliente no tiene garantías constituídas
        MsgBox "Atención! El cliente no tiene garantías constituídas para esta operación", vbExclamation, TITSISTEMA
        'Call MarcarOperacion
        ControlGarantias = False
        Exit Function
    Else  'No faltan, pero hay que asociar la operación a garantías disponibles
        Gar_ValorRec = valorRec
        'Por ver si entra aun cuando el rec sea cero...
        cantGtias = CantidadGarantias(rutClte, codClte)
        If cantGtias = -1 Then
            ControlGarantias = False
            Exit Function
        End If
        If cantGtias = 0 Then
            MsgBox "El cliente no tiene garantías constituídas disponibles para esta operación!", vbExclamation, TITSISTEMA
            ControlGarantias = False
            Exit Function
        ElseIf cantGtias > 0 Then
            ControlGarantias = True
        End If
    End If
End Function
Function ProcesarConRecCero() As Boolean
Dim salida As String
Dim Datos()
Envia = Array()
If Not Bac_Sql_Execute("Bacparamsuda.dbo.SP_RETPARAMETROSGARANTIAS") Then
    MsgBox "Error al buscar Parámetros de Garantías!", vbExclamation, TITSISTEMA
    Exit Function
End If
If Bac_SQL_Fetch(Datos()) <> 0 Then
    salida = Datos(1)
End If
salida = UCase(salida)
If salida = "S" Then
    ProcesarConRecCero = True
Else
    ProcesarConRecCero = False
End If
End Function

Sub BacCentrarPantalla(hForm As Form)

    hForm.Top = (Screen.Height - hForm.Height) / 2
    hForm.Left = (Screen.Width - hForm.Width) / 2

End Sub
Function BacEsHabilGar(cFecha As String) As Boolean

Dim objFeriado As New clsFeriado

Dim iAno       As Integer
Dim iMes       As Integer
Dim cDia       As String
Dim gcPlaza    As String
Dim n          As Integer

            

            ' Temporalmente.-
            '-----------------
'            gcPlaza = "00001"
            gcPlaza = "00006"
            sDia = BacDiaSem(cFecha)
            If sDia = "Sábado" Or sDia = "Domingo" Then
                        BacEsHabilGar = False
                        Exit Function
            End If

            iAno = DatePart("yyyy", cFecha)
            iMes = DatePart("m", cFecha)
            cDia = Format(DatePart("d", cFecha), "00")

            objFeriado.Leer iAno, gcPlaza

            Select Case iMes
                   Case 1:  n = InStr(objFeriado.feene, cDia)
                   Case 2:  n = InStr(objFeriado.fefeb, cDia)
                   Case 3:  n = InStr(objFeriado.femar, cDia)
                   Case 4:  n = InStr(objFeriado.feabr, cDia)
                   Case 5:  n = InStr(objFeriado.femay, cDia)
                   Case 6:  n = InStr(objFeriado.fejun, cDia)
                   Case 7:  n = InStr(objFeriado.fejul, cDia)
                   Case 8:  n = InStr(objFeriado.feago, cDia)
                   Case 9:  n = InStr(objFeriado.fesep, cDia)
                   Case 10: n = InStr(objFeriado.feoct, cDia)
                   Case 11: n = InStr(objFeriado.fenov, cDia)
                   Case 12: n = InStr(objFeriado.fedic, cDia)
            End Select

            Set objFeriado = Nothing

            If n > 0 Then
                 BacEsHabilGar = False
            Else
                 BacEsHabilGar = True
            End If


End Function
Function llenalista(ByVal data As String, ByRef salida() As Variant)
Dim i As Integer, n As Integer, p As Integer
Dim nData As String
Dim car As String
nData = data
Do While Len(nData) > 0
    p = InStr(1, nData, ",")
    If p > 0 Then
        car = Mid$(nData, 1, p - 1)
        AddParam salida, car
        nData = Mid(nData, p + 1)
    Else
        AddParam salida, nData
        Exit Do
    End If
Loop
End Function

