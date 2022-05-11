Attribute VB_Name = "BacLib"
Option Explicit
'insertado 20/12/200********

Global Const MDTC_COMUNAS = 44
'Global Const MDTC_TIPOCLIENTE = 72
Global Const MDTC_SECECONOMICO = 41
'Global Const MDTC_CIUDAD = 3
'Global Const MDTC_REGION = 32
Global Const MDTC_ENTIDAD = 234
'Global Const MDTC_MERCADO = 202
Global Const MDTC_GRUPO = 233

Global Const MDTC_Pais = 180

'Global Const MDTC_CALIDADJURIDICA = 39 'antes 36
'Global Const MDTC_RGBANCO = 40
'Global Const MDTC_RELACION = 32
'Global Const MDTC_CATEGORIADEUDOR = 42
'Global Const MDTC_COMINSTITUCIONAL = 41
'Global Const MDTC_CLASIFICACION = 103
'Global Const MDTC_ACTIVIDADECONOMICA = 13
'*************************************
Sub limpiar_cristal()
Dim i As Integer
   For i = 0 To 15
        BACSwapParametros.BACParam.StoredProcParam(i) = ""
        BACSwapParametros.BACParam.Formulas(i) = ""
   Next i

End Sub
Public Function ChkPrgF(Lugar As Integer) As Boolean
Dim Impre$

    ChkPrgF = False
 
    Envia = Array()
 
    Select Case Lugar
    
    Case 1 To 6, 1001, 1002, 112
        
        sql = "SP_CARGAPARAMETROS "
        
        AddParam Envia, "ME"
    
    Case 5107:
        
        sql = "SP_BAPCL"
        
        AddParam Envia, "NULO"
    
    Case 5108:
        
        sql = "SP_BCENG"
    
        AddParam Envia, gsBAC_User
    
    Case 6002:
        
        Impre = "N"
        sql = "SP_CREATRANSFERENCIA"
    
        AddParam Envia, Impre
    
    Case 6006:
        
        Impre = "N"
        sql = "SP_CREAPAPELETA"
    
        AddParam Envia, Impre
    
    Case 980, 981
        
        sql = "0"
        sql = "SP_BOPERAEMPBCO"
    
        AddParam Envia, Muestra
        AddParam Envia, 0
    
    Case 982
        
        sql = "SP_BARBIT "
        
        AddParam Envia, 0
    
    Case 983
        
        sql = "SP_BARBME "
    
        AddParam Envia, 0
    
    Case 999:
        
        sql = "SP_BOPERACARRIENDO "
    
        AddParam Envia, 0
        AddParam Envia, 0
    
    End Select
 

    If Envia(1) = "NULO" Then

         If Not Bac_Sql_Execute(Sql) Then
             
             Exit Function
         
         End If
    
    Else
    
         If Not Bac_Sql_Execute(Sql, Envia) Then
             
             Exit Function
         
         End If
  
    End If
    
    Select Case Lugar
    
    Case 1 To 6, 1001, 1002
        
        If Not Bac_SQL_Fetch(Datos()) Then
            
            MsgBox "Problemas con la Base de Datos", 16, TITSISTEMA
            Exit Function
        
        Else
            
            Select Case Lugar
              
              Case 1001, 1002: Lugar = 1
            
            '  Case 121217: lugar = 7
            '  Case 121218: lugar = 8
            
            End Select
            
            If Mid(Datos(11), Lugar, 1) <> "1" Then Exit Function
        
        End If
  
    
    Case 5106, 6002, 6003, 6009, 980 To 999, 6006   '--- Operaciones del día
        
        If Not Bac_SQL_Fetch(Datos()) Then
            
            MsgBox "No Hay Datos para Procesar", 16, TITSISTEMA
            Exit Function
        
        End If
   
    Case 5107:
        
        If Not Bac_SQL_Fetch(Datos()) Then
            
            MsgBox "No hay Operaciones de Lineas por Aprobar", 16, TITSISTEMA
            Exit Function
        
        End If
        
        If Datos(3) = "N" Then
            
            MsgBox "NO tiene Autorización para esta Opción", 16, TITSISTEMA
            Exit Function
        
        End If
 
    End Select
 
    ChkPrgF = True

End Function

Public Function ActuaBoton(Lugar%, CmdGrabar2 As Object, CmdGrabar1 As Object)
    If Not ChkPrgF(Lugar) Then
        CmdGrabar2.Visible = False
        CmdGrabar1.Visible = True
    Else
        CmdGrabar2.Top = CmdGrabar1.Top
        CmdGrabar2.Left = CmdGrabar1.Left
        CmdGrabar2.Height = CmdGrabar1.Height
        CmdGrabar2.Width = CmdGrabar1.Width
        CmdGrabar1.Visible = False
        CmdGrabar2.Visible = True
    End If
End Function
'*************************************
Sub PROC_FMT_NUMERICO(texto As Control, NEnteros, NDecs As Integer, ByRef tecla, Signo As String, Decim As String)

Dim PosPto As Integer

   If tecla = 13 Or tecla = 27 Then Exit Sub

   If tecla = 45 And Signo = "+" Then tecla = 0

    If tecla <> 8 And (tecla < 48 Or tecla > 57) Then
    
  If NDecs = 0 Then
          tecla = 0
    ElseIf tecla <> Asc(Decim) Then 'Tecla <> 46 And Tecla <> 45 Then
           tecla = 0
   
    End If
  
  End If

    If tecla = 45 And Signo = "-" Then  ' Signo negativo
    If InStr(texto.Text, "-") > 0 Then
           tecla = 0
    ElseIf texto.SelStart > 0 Then
          If Mid(texto.Text, texto.SelStart, 1) <> "" Then
             tecla = 0
          End If
    End If
    End If


  PosPto% = InStr(texto.Text, Decim)
  If PosPto% > 0 And tecla = Asc(Decim) Then
       tecla = 0
       Exit Sub
  End If

  If NDecs > 0 And PosPto% > 0 And PosPto% <= texto.SelStart Then
     PosPto% = PosPto% + 1
    If Len(Mid(texto.Text, PosPto%, NDecs)) = NDecs And tecla <> 8 Then
           tecla = 0
    Else
           Exit Sub
    End If
  End If

  If PosPto% > 0 And texto.SelStart < PosPto% And tecla <> 8 Then
     If Len(Mid(texto.Text, 1, PosPto% - 1)) >= NEnteros Then tecla = 0
     ElseIf PosPto% = 0 And tecla <> 8 And Chr(tecla) <> Decim Then
       If Len(texto.Text) >= NEnteros Then tecla = 0
  End If

End Sub
Function ChequeaCierreMesa()
Dim Sql$
Dim Datos()
Dim lCierreMesa As Integer

ChequeaCierreMesa = True

''''''''''''''''''''''''''''''''Sql$ = "EXECUTE sp_Control_Procesos "
''''''''''''''''''''''''''''''''Sql$ = Sql$ & PAR_CIERRE_MESA

Envia = Array()

AddParam Envia, CDbl(PAR_CIERRE_MESA)

If Bac_Sql_Execute("SP_CONTROL_PROCESOS", Envia) Then

   'If MISQL.SQL_FETCH(Datos()) = 0 Then
   While Bac_SQL_Fetch(Datos())
      
      lCierreMesa = Val(Trim(Datos(1)))
   
   Wend
   
End If

If lCierreMesa = 1 Then

   ChequeaCierreMesa = False
   
End If

End Function


Sub BacCaracterNumerico(ByRef KeyAscii As Integer)
   
   'si <> Enter y BackSpace
   If KeyAscii <> 13 And KeyAscii <> 8 Then
      'Si no es numerico
      If Not IsNumeric(Chr$(KeyAscii)) Then
         KeyAscii = 0
      End If
      
   End If
   
End Sub


Function BacAbrirBaseDatosMDB() As Boolean

   On Error GoTo BacErrorHandler

   BacAbrirBaseDatosMDB = False

   Set WS = DBEngine.Workspaces(0)
   Set DB = WS.OpenDatabase(gsMDB_Path & gsMDB_Database, False, False)
    
   BacAbrirBaseDatosMDB = True

   Exit Function
    
BacErrorHandler:
    
   BacLogFile "AbrirBaseDatosMDB " & Err.Description$
'   If BacErrorHandlerMDB(Err) = True Then
'      Resume

'   End If

   Exit Function

End Function

Function BacGeneraMes(nMes As Integer, nAno As Integer, oControl)

   Dim nLin          As Integer
   Dim nDias         As Integer
   Dim nMaxDia       As Integer
   Dim dFecha        As Date

   dFecha = Format("01/" + Format(nMes, "00") + "/" + Format(nAno, "0000"), gsc_FechaDMA)

   Select Case nMes
   Case 1:  nMaxDia = 31   'Enero
   Case 2:  nMaxDia = 28   'Febrero
   Case 3:  nMaxDia = 31   'Marzo
   Case 4:  nMaxDia = 30   'Abril
   Case 5:  nMaxDia = 31   'Mayo
   Case 6:  nMaxDia = 30   'Junio
   Case 7:  nMaxDia = 31   'Julio
   Case 8:  nMaxDia = 31   'Agosto
   Case 9:  nMaxDia = 30   'Septiembre
   Case 10: nMaxDia = 31   'Octubre
   Case 11: nMaxDia = 30   'Noviembre
   Case 12: nMaxDia = 31   'Diciembre
   End Select

   If (nMes / 4) <> Int(nMes / 4) And nMes = 2 Then nMaxDia = 29

   With oControl
      .Rows = nMaxDia + 1

      For nDias = 0 To nMaxDia - 1
         .Row = nDias + 1
         .Col = 1: .Text = DateAdd("D", nDias, dFecha)

      Next nDias

   End With

End Function

Public Function BACLeerValoresMoneda(nCodMda As Integer, nMes As Integer, nAno As Integer, oControl As Object, sTipMnt As String) As Boolean

   Dim Sql           As String
   Dim Datos()

''''''''''' Sql = "EXECUTE sp_mdvmleervalmon " & nCodMda & ", " & nMes & ", " & nAno

   Envia = Array()
   
   AddParam Envia, CDbl(nCodMda)
   AddParam Envia, CDbl(nMes)
   AddParam Envia, CDbl(nAno)
   
   BACLeerValoresMoneda = False

   If Not Bac_Sql_Execute("SP_MDVMLEERVALMON", Envia) Then
      
      MsgBox "Problemas al leer los valores de moneda", vbInformation, TITSISTEMA
      Exit Function

   End If

   With oControl
      .Rows = 1

      Do While Bac_SQL_Fetch(Datos())

         .Rows = .Rows + 1
         .Row = .Rows - 1
         .Col = 1: .Text = Datos(5)

         Select Case sTipMnt
         Case "ME"
            .Col = 2: .Text = Format(BacCtrlDesTransMonto(Datos(3)), "#,##0.000000")
            .Col = 3: .Text = Format(BacCtrlDesTransMonto(Datos(4)), "#,##0.000000")

         Case "MN"
            .Col = 2: .Text = Format(Datos(2), FDecimal)

         End Select

      Loop

   End With

   BACLeerValoresMoneda = True

End Function

Public Function BACGrabarValoresMoneda(nCodMda As Integer, oControl As Object, sTipMnt As String) As Boolean

   Dim Sql           As String
   Dim nLin          As Integer

   BACGrabarValoresMoneda = False

   With oControl

      For nLin = 1 To .Rows - 1
         
         Envia = Array()

         AddParam Envia, CDbl(nCodMda)

         '.Row = nLin
         
         Select Case sTipMnt
         
         Case "ME"
            AddParam Envia, 0
            AddParam Envia, CDbl(.TextMatrix(nLin, 2))
            AddParam Envia, CDbl(.TextMatrix(nLin, 3))
         Case "MN"
            AddParam Envia, .TextMatrix(nLin, 2)
            AddParam Envia, Format("0", FDecimal)
            AddParam Envia, Format("0", FDecimal)
         End Select
         
         AddParam Envia, Format(.TextMatrix(nLin, 1), "YYYYMMDD")
         
         If Not Bac_Sql_Execute("SP_MDVMGRABARVALMON", Envia) Then
            
            MsgBox "Problemas al leer los valores de moneda", vbInformation, TITSISTEMA
            Exit Function
        
         End If

      Next nLin

   End With

   BACGrabarValoresMoneda = True

End Function

'Function BacProxHabil(xFecha As String) As String
'    Dim dFecha As String
'
'   dFecha = xFecha
'   dFecha = Format(DateAdd("d", 1, dFecha), gsc_FechaDMA)
'
'   Do While Not BacEsHabil(dFecha)
'      dFecha = Format(DateAdd("d", 1, dFecha), gsc_FechaDMA)
'
'   Loop
'
'   BacProxHabil = dFecha
'
'
'End Function
Function BacProxHabil(dFecha As String, plaza As String) As String

   dFecha = Format(DateAdd("d", 1, dFecha), gsc_FechaDMA)

   Do While Not BacEsHabil(dFecha, plaza)
      dFecha = Format(DateAdd("d", 1, dFecha), gsc_FechaDMA)

   Loop

   BacProxHabil = dFecha


End Function
Public Function RELLENA_STRING(Dato As String, Pos As String, largo As Integer) As String

'rellena con blancos y completa el largo requerido
' Ejemplo : x$ = RELLENA_STRING(CStr(i#), "I", 10)
' Ejemplo : x$ = RELLENA_STRING(i$, "D", 10)

If Trim(Pos$) = "" Then Pos$ = "I"

If largo < Len(Trim(Dato)) Then
   RELLENA_STRING = Mid(Trim(Dato), 1, largo)
   Exit Function
End If

If Mid(Pos$, 1, 1) = "I" Then 'IZQUIERDA
   RELLENA_STRING = String(largo - Len(Trim(Dato)), " ") + Trim(Dato)
Else                          'DERECHA
   RELLENA_STRING = Trim(Dato) + String(largo - Len(Trim(Dato)), " ")
End If

RELLENA_STRING = Mid(RELLENA_STRING, 1, largo)

End Function
'insertado 22/12/2000
Sub PROC_POSI_TEXTO(Grilla As Control, texto As Control)
 '  SE EST AUTILIZANDO EN PROCESO DE INICIO DE DIA
    
    texto.Top = Grilla.CellTop + Grilla.Top + 20
    texto.Left = Grilla.CellLeft + Grilla.Left + 20
    texto.Width = Grilla.CellWidth - 20

End Sub
'Convierte el caracter a mayuscula y devuelve el codigo asccii
'97=a ---- 122=z
Sub BacToUCase(ByRef KeyAscii As Integer)

   If KeyAscii >= 97 Or KeyAscii <= 122 Then
      KeyAscii = Asc(UCase$(Chr$(KeyAscii)))
      
   End If
    
End Sub
Public Function CalFeriado(cmbMon, objConData, objOpt As Object, Estado%) As Boolean
Dim Var%, Sql1$
Dim i As Integer
    Select Case Estado
    Case 1, 10
        Sql1 = "00006"
    
    Case 2, 20
        If cmbMon.ListIndex = -1 Then
            Exit Function
        End If
        Var = cmbMon.ListIndex
        Sql = ""
        If objOpt.Value = True Then
            For i = 0 To cmbMon.ListCount - 1
                cmbMon.ListIndex = i
                If "USD" = Trim(Mid(cmbMon, 1, 3)) Then
                    Exit For
                End If
            Next i
        End If
        Sql1 = Bacllenat(Str(cmbMon.ItemData(cmbMon.ListIndex)), 5, 0)
        cmbMon.ListIndex = Var
    
    Case 3, 30
        Sql1 = "00006"
        For Var = 0 To Val(cmbMon) - 1 Step 1
            objConData.Text = DateAdd("d", 1, objConData.Text)
            If Not BacEsHabil(objConData.Text, Sql1) Then
                objConData.Text = BacProxHabil(objConData.Text, Sql1)
            End If
        Next Var

    End Select
  
    If BacEsHabil(objConData.Text, Sql1) = False Then
        If Estado > 3 Then
            MsgBox "Dia Feriado,Busco el Próximo Habil ", 16, TITSISTEMA
        End If
        objConData.Text = BacProxHabil(objConData.Text, Sql1)
    End If
  '  objConData.Refresh
    
End Function



Public Sub BacControlWindows(n%)

   Dim i%
   
   For i% = 1 To n%
      DoEvents
   
   Next
    
End Sub

Public Function BacEncript(sPassword$, bEncript As Boolean) As String

   Const LEN_PSW = 15
   'Const KEY_PSW = "jm*sx/ch^yr<=ze"
   Const KEY_PSW = "zbcdefghijklmno"
   Const nMAGIC1 = 5
   Const nMAGIC2 = 11
   Const nMAGIC3 = 253

   Dim iDir%, jDir%, kDir%, nAnt%, nAsc%, nKey%, nPsw%, cPsw$, i

   nAnt = nMAGIC1
   jDir = IIf(bEncript, Len(sPassword), 1)
   kDir = 0

   For iDir = 1 To Len(sPassword)
      If iDir > LEN_PSW Then
         kDir = 1

      Else
         kDir = kDir + 1

      End If

      nAsc = Asc(Mid$(sPassword$, jDir, 1))
      nKey = Asc(Mid$(KEY_PSW$, kDir, 1))
      nPsw = nAsc Xor nKey Xor nAnt Xor ((i / nMAGIC2) Mod nMAGIC3)

      If bEncript Then
         cPsw$ = cPsw$ & Chr$(nPsw)
         nAnt = nAsc
         jDir = jDir - 1

      Else
         cPsw$ = Chr$(nPsw) & cPsw$
         nAnt = nPsw
         jDir = jDir + 1

      End If

   Next
       
   BacEncript = cPsw$

End Function

Public Function BacExtraer(ByRef sBuff$) As String
   
   Dim iPos%
   iPos% = InStr(sBuff$, "|")
   
   If iPos% > 0 Then
      BacExtraer = Mid$(sBuff$, 1, iPos% - 1)
      sBuff$ = Mid$(sBuff$, iPos% + 1)
      
   Else
      BacExtraer = sBuff$
      sBuff$ = ""
      
   End If
   
End Function
'---------------------------------------------------
' BacLogFile
' Esta rutina escribe en el archivo LOG del usuario.
'---------------------------------------------------
Public Sub BacLogFile(sLogEvent$)
   
   Dim hFile%
   hFile% = FreeFile
   
   Open "bacswap.log" For Append Access Write Shared As #hFile%
   Write #hFile%, Format$(Now, gsc_FechaDMA + " hh:mm:ss") & ": " & sLogEvent$
   Close #hFile%
   
End Sub

            
'Función que quita las comas dependiendo del formato windows
'Al SqlServer no se le puede pasar un valor numérico con comas
Public Function BacStrTran(sCadena$, sFind$, sReplace$) As String
   
   Dim iPos%
   Dim iLen%
         
   If Trim$(sCadena$) = "" Then
      sCadena$ = "0"

   End If
   
   If sFind$ <> sReplace$ Then
   
    iPos% = 1
    
    iLen% = Len(sFind$)
    
    Do While True
       iPos% = InStr(1, sCadena$, sFind$)
       
       If iPos% = 0 Then
          Exit Do
          
       End If
       
       sCadena$ = Mid$(sCadena$, 1, iPos% - 1) + sReplace$ + Mid$(sCadena$, iPos% + iLen%)
    
    Loop
   
   End If
   
   BacStrTran = Trim$(CStr(sCadena$))
    
End Function
Public Function BacBuscaCodigo(obj As Object, CODI As Integer) As Long
        
   Dim f   As Long
   Dim Max As Long
        
   BacBuscaCodigo = -1
            
   Max = obj.coleccion.Count
            
   For f = 1 To Max
      If obj.coleccion(f).codigo = CODI Then
         BacBuscaCodigo = f - 1
         Exit For
      
      End If
   
   Next f

End Function

Public Function BacBuscaGlosa(obj As Object, CODI As String) As Long
   
   Dim f   As Long
   Dim Max As Long
        
   BacBuscaGlosa = -1
            
   Max = obj.coleccion.Count
      
   For f = 1 To Max
      If Trim$(obj.coleccion(f).glosa) = Trim(CODI) Then
         BacBuscaGlosa = f - 1
         Exit For
      
      End If
   
   Next f
            
End Function

Public Function BacDiaSem(sfec$) As String

   BacDiaSem = ""
    
   If IsDate(sfec$) Then
      Select Case Weekday(sfec$)
      Case 1: BacDiaSem = "Domingo"
      Case 2: BacDiaSem = "Lunes"
      Case 3: BacDiaSem = "Martes"
      Case 4: BacDiaSem = "Miércoles"
      Case 5: BacDiaSem = "Jueves"
      Case 6: BacDiaSem = "Viernes"
      Case 7: BacDiaSem = "Sábado"
      End Select
      
    End If

End Function

'Public Function BacEsHabil(cFecha As String) As Boolean
'
'   Dim objFeriado As New clsFeriado
'
'   Dim iAno       As Integer
'   Dim iMes       As Integer
'   Dim sDia       As String
'   Dim gcPlaza    As String
'   Dim n          As Integer
'
'   ' Temporalmente.-
'   '-----------------
'   gcPlaza = "00001"
'
'   sDia = BacDiaSem(cFecha)
'   If sDia = "Sábado" Or sDia = "Domingo" Then
'      BacEsHabil = False
'      Exit Function
'
'   End If
'
'   iAno = DatePart("yyyy", cFecha)
'   iMes = DatePart("m", cFecha)
'   sDia = Format(DatePart("d", cFecha), "00")
'
'   objFeriado.Leer iAno, gcPlaza
'
'   Select Case iMes
'   Case 1:  n = InStr(objFeriado.feene, sDia)
'   Case 2:  n = InStr(objFeriado.fefeb, sDia)
'   Case 3:  n = InStr(objFeriado.femar, sDia)
'   Case 4:  n = InStr(objFeriado.feabr, sDia)
'   Case 5:  n = InStr(objFeriado.femay, sDia)
'   Case 6:  n = InStr(objFeriado.fejun, sDia)
'   Case 7:  n = InStr(objFeriado.fejul, sDia)
'   Case 8:  n = InStr(objFeriado.feago, sDia)
'   Case 9:  n = InStr(objFeriado.fesep, sDia)
'   Case 10: n = InStr(objFeriado.feoct, sDia)
'   Case 11: n = InStr(objFeriado.fenov, sDia)
'   Case 12: n = InStr(objFeriado.fedic, sDia)
'   End Select
'
'   Set objFeriado = Nothing
'
'   If n > 0 Then
'      BacEsHabil = False
'
'   Else
'      BacEsHabil = True
'
'   End If
'
'End Function
Function BacEsHabil(cFecha As String, plaza As String) As Boolean

   Dim objFeriado As New clsFeriado
   
   Dim iAno       As Integer
   Dim iMes       As Integer
   Dim sDia       As String
    Dim n          As Integer
   
   sDia = BacDiaSem(cFecha)
   If sDia = "Sábado" Or sDia = "Domingo" Then
      BacEsHabil = False
      Exit Function
      
   End If
   
   iAno = DatePart("yyyy", cFecha)
   iMes = DatePart("m", cFecha)
   sDia = Format(DatePart("d", cFecha), "00")
   
   objFeriado.Leer iAno, plaza
   
   Select Case iMes
   Case 1:  n = InStr(objFeriado.feene, sDia)
   Case 2:  n = InStr(objFeriado.fefeb, sDia)
   Case 3:  n = InStr(objFeriado.femar, sDia)
   Case 4:  n = InStr(objFeriado.feabr, sDia)
   Case 5:  n = InStr(objFeriado.femay, sDia)
   Case 6:  n = InStr(objFeriado.fejun, sDia)
   Case 7:  n = InStr(objFeriado.fejul, sDia)
   Case 8:  n = InStr(objFeriado.feago, sDia)
   Case 9:  n = InStr(objFeriado.fesep, sDia)
   Case 10: n = InStr(objFeriado.feoct, sDia)
   Case 11: n = InStr(objFeriado.fenov, sDia)
   Case 12: n = InStr(objFeriado.fedic, sDia)
   End Select
   
   Set objFeriado = Nothing
   
   If n > 0 Then
      BacEsHabil = False
   
   Else
      BacEsHabil = True
   
   End If

End Function
Public Sub BacLLenaComboMes(cbx As Object)
   
   cbx.Clear
   
   cbx.AddItem "ENERO"
   cbx.ItemData(cbx.NewIndex) = 1
   cbx.AddItem "FEBRERO"
   cbx.ItemData(cbx.NewIndex) = 2
   cbx.AddItem "MARZO"
   cbx.ItemData(cbx.NewIndex) = 3
   cbx.AddItem "ABRIL"
   cbx.ItemData(cbx.NewIndex) = 4
   cbx.AddItem "MAYO"
   cbx.ItemData(cbx.NewIndex) = 5
   cbx.AddItem "JUNIO"
   cbx.ItemData(cbx.NewIndex) = 6
   cbx.AddItem "JULIO"
   cbx.ItemData(cbx.NewIndex) = 7
   cbx.AddItem "AGOSTO"
   cbx.ItemData(cbx.NewIndex) = 8
   cbx.AddItem "SEPTIEMBRE"
   cbx.ItemData(cbx.NewIndex) = 9
   cbx.AddItem "OCTUBRE"
   cbx.ItemData(cbx.NewIndex) = 10
   cbx.AddItem "NOVIEMBRE"
   cbx.ItemData(cbx.NewIndex) = 11
   cbx.AddItem "DICIEMBRE"
   cbx.ItemData(cbx.NewIndex) = 12
   
   cbx.ListIndex = -1
   
End Sub


Private Sub Respaldo_de_constantes()
    
    '/* ----------------------------------------------------------------------------------------
    '**
    '**              Contantes Globales para Los Mensajes de Clientes
    '**
    '*/ ----------------------------------------------------------------------------------------
    'Global Const MSG_CLConeccion = 10001     ', "No se puede conectar a tabla de clientes.-"
    'Global Const MSG_CLBorrar = 10002        ', "No se puede eliminar este cliente.-"
    'Global Const MSG_CLGrabar = 10003        ', "No se puede grabar este cliente.-"
    'Global Const MSG_ClValRut = 10004        ', "El rut del cliente es incorrecto.-"
    'Global Const MSG_ClValNombre = 10005     ', "No ingres¢ nombre del cliente.-"
    'Global Const MSG_CLValDireccion = 10006  ', "No ingres¢ direcci¢n del cliente.-"
    'Global Const MSG_CLValComuna = 10007     ', "No ingres¢ comuna del cliente.-"
    'Global Const MSG_CLValTipCli = 10008     ', "No ingres¢ tipo de cliente.-"
    'Global Const MSG_CLValSecEcon = 10009    ', "No ingres¢ setor econ¢mico del cliente.-"
    'Global Const MSG_CLGrabarOK = 10010      ', "Registro cliente ha sido grabado.-"
    'Global Const MSG_CLBorrarOK = 10011      ', "Registro cliente ha sido eliminado.-"
    'Global Const MSG_CLPregunta = 10012      ', "Seguro de eliminar cliente.-@PR"
    
    '/* ----------------------------------------------------------------------------------------
    '**
    '**              Contantes Globales para Los Mensajes de Emisores
    '**
    '*/ ----------------------------------------------------------------------------------------
    'Global Const MSG_EMConeccion = 11001    ', "No se puede conectar a tabla de emisores.-"'
    'Global Const MSG_EMGrabar = 11002       ', "No se puede grabar registro en la tabla de emisores.-"
    'Global Const MSG_EMBorrar = 11003       ', "No se puede eliminar registro de la tabla de emisores.-"
    'Global Const MSG_EMValRut = 11004       ', "El rut el emisor es incorrecto._"
    'Global Const MSG_EMValNombre = 11005    ', "No ha ingresado nombre.-"
    'Global Const MSG_EMValGenerico = 11006  ', "No ha ingresado nenérico.-"
    'Global Const MSG_EMValDirec = 11007     ', "No ha ingresado dirección.-"
    'Global Const MSG_EMValComuna = 11008    ', "No ha ingresado comuna.-"
    'Global Const MSG_EMGrabarOK = 11009     ', "El registro de emisor se grab¢ con éxito.-"
    'Global Const MSG_EMBorrarOK = 11010     ', "El registro de emisor ha sido eliminado.-"
    'Global Const MSG_EMPregunta = 11011     ', "Seguro de eliminar emisor.-@PR"
    '/* ----------------------------------------------------------------------------------------
    '**
    '**              Contantes Globales para Los Mensajes de Tablas de Uso General
    '**
    '*/ ----------------------------------------------------------------------------------------
    'Global Const MSG_TGConeccion = 12001      ', "No se puede conectar a tablas de uso general.-"
    'Global Const MSG_TGGrabar = 12002         ', "No se puede grabar registro en tablas generales.-"
    'Global Const MSG_TGBorrar = 12003         ', "No se pudo eliminar registro en tablas generales.-"
    'Global Const MSG_TGBegin = 12004          ', "No se puede grabar registro en tablas generales. Error en Begin Trans.-"
    'Global Const MSG_TGBorrarRollBack = 12005 ', "No se puede eliminar registro en tablas generales. Error en RollBack Trans.-"
    'Global Const MSG_TGGrabarRollback = 12006 ', "No se puede grabar registro en tablas generales. Error en RollBack Trans.-"
    'Global Const MSG_TGCommit = 12007         ', "No se puede grabar registro en tablas generales. Error en Commit Trans.-"
    'Global Const MSG_TGValCodigos = 12008     ', "Algunos c¢digos no est n ingresados.-"
    'Global Const MSG_TGValElemento = 12009    ', "No ha seleccionado elemento de la lista.-"
    'Global Const MSG_TGGrabarOK = 12010       ', "Grabaci¢n se realiz¢ con éxito.-"
    
    
    '/* ----------------------------------------------------------------------------------------
    '**
    '**              Contantes Globales para Los Mensajes de Monedas
    '**
    '*/ ----------------------------------------------------------------------------------------
    'Global Const MSG_MNConeccion = 13001     ', "No se puede conectar a tabla de monedas.-"
    'Global Const MSG_MNGrabar = 13002        ', "No se Puede grabar registro en la tabla de monedas.-"
    'Global Const MSG_MNBorrar = 13003        ', "No se puede eliminar registro de la tabla monedas.-"
    'Global Const MSG_MNValCodMon = 13004     ', "El c¢digo de moneda incorrecto.-"
    'Global Const MSG_MNValGlosa = 13005      ', "No ha ingresado glosa de moneda.-"
    'Global Const MSG_MNValNemo = 13006       ', "No ha ingresado nemot‚cnico.-"
    'Global Const MSG_MNValSimbolo = 13007    ', "No ha ingresado s¡mbolo.-"
    'Global Const MSG_MNGrabarOK = 13008      ', "Registro de moneda ha sido grabado.-"
    'Global Const MSG_MNBorrarOK = 13009      ', "Registro de moneda ha sido eliminado.-"
    'Global Const MSG_MNPregunta = 13010      ', "Seguro de eliminar moneda.-"
    
    '/* ----------------------------------------------------------------------------------------
    '**
    '**              Contantes Globales para Los Mensajes de Dueños de Carteras
    '**
    '*/ ----------------------------------------------------------------------------------------
    'Global Const MSG_DCConeccion = 14001     ', "No se puede conectar a tabla de due¤o de cartera.-"
    'Global Const MSG_DCGrabar = 14002        ', "No se puede grabar registro en tabla de d. de cartera.-"
    'Global Const MSG_DCBorrar = 14003        ', "No se puede eliminar registro en tabla de d. de cartera.-"
    'Global Const MSG_DCValrut = 14004        ', "El rut de due¤o de cratera es incorrecto.-"
    'Global Const MSG_DCValDescrip = 14005    ', "No ha ingresado descripci¢n de due¤os de cartera.-"
    'Global Const MSG_DCValcodigo = 14006     ', "No ha ingresado c¢digo de due¤os de cartera.-"
    'Global Const MSG_DCGrabarOK = 14007      ', "Registro de due¤os de cartera ha sido grabado.-"
    'Global Const MSG_DCBorrarOK = 14008      ', "Registro de due¤os de cartera ha sido eliminado.-"
    'Global Const MSG_DCPregunta = 14009      ', "Seguro de eliminar due¤o de cartera.-@PR"
    
    '/* ----------------------------------------------------------------------------------------
    '**
    '**              Contantes Globales para Los Mensajes de Valores de Monedas
    '**
    '*/ ----------------------------------------------------------------------------------------
    'Global Const MSG_VMConeccion = 15001      ', "No se puede conectar a tabla de valores de monedas.-@ST"
    'Global Const MSG_VMGrabar = 15002         ', "No se puede grabar registros de valores de monedas.-@ST"
    'Global Const MSG_VMGrabarBegin = 15003    ', "No se puede grabar registros de valores de monedas, error en Begin Trans.-@ST"
    'Global Const MSG_VMGrabarRollback = 15004 ', "No se puede grabar registros de valores de monedas, error en Rollback Trans.-@ST"
    'Global Const MSG_VMGrabarCommit = 15005   ', "No se puede grabar registros de valores de monedas, error en Commit Trans.-@ST"
    'Global Const MSG_VMValMes = 15006         ', "No ha elegido mes.-@VA"
    'Global Const MSG_VMGrabarOK = 15007       ', "Valores de monedas se grabaron exitosamente.-@OK"
    
    '/* ----------------------------------------------------------------------------------------
    '**
    '**              Contantes Globales para Los Mensajes de Feriados
    '**
    '*/ ----------------------------------------------------------------------------------------
    'Global Const MSG_FEConeccion = 16001      ', "No se puede conectar a tabla de feriados.-@ST"
    'Global Const MSG_FEGrabar = 16002         ', "No se puede grabar registro en tabla de feriados.-@ST"
    'Global Const MSG_FEValMes = 16003         ', "No ha seleccionado el mes.-@VA"
    'Global Const MSG_FEValPlaza = 16004       ', "No ha seleccionado la plaza.-@VA"
    'Global Const MSG_FEValAno = 16005         ', "El a¤o est  en blanco.-@VA"
    'Global Const MSG_FEValDiasFer = 16006     ', "Existen mas de 10 dias feriados.-@VA"
    'Global Const MSG_FEGrabarOK = 16007       ', "Registros de feriados se grabaron exitosamente.-@OK"

End Sub


Public Function BacValidaRut(rut As String, dig As String) As Integer

   Dim i       As Integer
   Dim D       As Integer
   Dim Divi    As Long
   Dim Suma    As Long
   Dim Digito  As String
   Dim Multi   As Double

   BacValidaRut = False
    
   If Trim$(rut) = "" Or Trim$(dig) = "" Then
      Exit Function
   
   End If
   Suma = 0
    
   rut = Format(rut, "000000000")
   D = 2
   For i = 9 To 1 Step -1
      Multi = Val(Mid$(rut, i, 1)) * D
     Suma = Suma + Multi
      D = D + 1
      
      If D = 8 Then
         D = 2
      
      End If
   Next i
    
   Divi = (Suma \ 11)
   Multi = Divi * 11
   Digito = Trim$(Str$(11 - (Suma - Multi)))
    
   If Digito = "10" Then
      Digito = "K"
   
   End If
    
   If Digito = "11" Then
      Digito = "0"
   
   End If
    
   If Trim$(UCase$(Digito)) = UCase$(Trim$(dig)) Then
      BacValidaRut = True
   
   End If

End Function

Public Function BacCheckRut(rut As String) As String

   Dim i       As Integer
   Dim D       As Integer
   Dim Divi    As Long
   Dim Suma    As Long
   Dim Digito  As String
   Dim Multi   As Double
   
   If Trim$(rut) = "" Then
      Exit Function
   
   End If
    
   rut = Format(rut, "00000000")
   D = 2
   For i = 8 To 1 Step -1
      Multi = Val(Mid$(rut, i, 1)) * D
     Suma = Suma + Multi
      D = D + 1
      
      If D = 8 Then
         D = 2
      
      End If
   Next i
    
   Divi = (Suma \ 11)
   Multi = Divi * 11
   Digito = Trim$(Str$(11 - (Suma - Multi)))
    
   If Digito = "10" Then
      Digito = "K"
   
   End If
    
   If Digito = "11" Then
      Digito = "0"
   
   End If
    
   BacCheckRut = Trim$(UCase$(Digito))
   
End Function

Public Function BacDiv(ByVal n1 As Double, ByVal n2 As Double) As Double
         
         If n2 = 0 Then
            BacDiv = 0
            
         Else
            BacDiv = n1 / n2
         
         End If
         
End Function

Sub Main()

'   BacInicio.Show vbNormal%
'
'   BacControlWindows 3000
'
'   Unload BacInicio

End Sub
Function BacFirstHabil(xFecha As String) As Boolean
   Dim iMesFecha      As Integer
   Dim iMesFecha1     As Integer
   Dim cFecha         As String
   
   cFecha = xFecha
   iMesFecha = DatePart("m", cFecha)
   iMesFecha1 = iMesFecha
   cFecha = Format(DateAdd("d", -1, cFecha), gsc_FechaDMA)

   Do While Not BacEsHabil(cFecha, "")
      cFecha = Format(DateAdd("d", -1, cFecha), gsc_FechaDMA)
      iMesFecha1 = DatePart("m", cFecha)
        
   Loop
    
   If iMesFecha = iMesFecha1 Then
      BacFirstHabil = False
      
   Else
      BacFirstHabil = True
      
   End If
   
End Function

Function BacLastHabil(xFecha As String) As Boolean
   Dim iMesFecha      As Integer
   Dim iMesFecha1     As Integer
   Dim cFecha         As String

   cFecha = xFecha
   cFecha = BacProxHabil(cFecha, "")
   
   iMesFecha = DatePart("m", xFecha)
   iMesFecha1 = DatePart("m", cFecha)
   
   If iMesFecha = iMesFecha1 Then
      BacLastHabil = False
      
   Else
      BacLastHabil = True
      
   End If
   
End Function

Function BacUltimoDia(cFecha As String, cAdelante As String) As String
   Dim nDia      As Integer
   Dim nMes      As Integer
   Dim nYear     As Integer
   Dim dFecha1   As String
   
   nMes = DatePart("m", cFecha)
   nDia = 1
   nYear = DatePart("yyyy", cFecha)
   
   If cAdelante = "SI" Then
           
      nMes = nMes + 1
      If nMes > 12 Then
         nMes = 1
         nYear = nYear + 1
      End If
      
   End If
   
   dFecha1 = Str(nDia) + "/" + Str(nMes) + "/" + Str(nYear)
   dFecha1 = Format$(dFecha1, gsc_FechaDMA)
   dFecha1 = Format(DateAdd("d", -1, dFecha1), gsc_FechaDMA)
   
   BacUltimoDia = dFecha1

End Function

Function BacPrevHabil(xFecha As String) As String
   Dim cFecha As String
    
   cFecha = xFecha
   cFecha = Format(DateAdd("d", -1, cFecha), gsc_FechaDMA)

   Do While Not BacEsHabil(cFecha, "")
      cFecha = Format(DateAdd("d", -1, cFecha), gsc_FechaDMA)

   Loop

   BacPrevHabil = cFecha

End Function

Function BacMonto_Escrito(n As Double) As String

ReDim uni(15) As String
ReDim dec(9) As String
Dim z, num, Var   As Variant
Dim c, D, u, v, i As Integer
Dim k
Dim nPosicion     As Integer
Dim cDecimales    As String
Dim cDenomi       As String

nPosicion = InStr(1, BacRemplazar(BacFormatoMonto(n, 4), gsc_SeparadorMiles, ""), gsc_PuntoDecim)

cDecimales = Mid(BacRemplazar(BacFormatoMonto(n, 4), gsc_SeparadorMiles, ""), nPosicion + 1, 4)
n = Val(Mid(BacRemplazar(BacFormatoMonto(n, 4), gsc_SeparadorMiles, ""), 1, nPosicion - 1))

If n = 0 Or n > 1E+17 Then
   BacMonto_Escrito = IIf(n = 0, "CERO", "*")
   Exit Function
End If

uni(1) = "UN"
uni(2) = "DOS"
uni(3) = "TRES"
uni(4) = "CUATRO"
uni(5) = "CINCO"
uni(6) = "SEIS"
uni(7) = "SIETE"
uni(8) = "OCHO"
uni(9) = "NUEVE"
uni(10) = "DIEZ"
uni(11) = "ONCE"
uni(12) = "DOCE"
uni(13) = "TRECE"
uni(14) = "CATORCE"
uni(15) = "QUINCE"

dec(3) = "TREINTA"
dec(4) = "CUARENTA"
dec(5) = "CINCUENTA"
dec(6) = "SESENTA"
dec(7) = "SETENTA"
dec(8) = "OCHENTA"
dec(9) = "NOVENTA"

num = String$(19 - Len(Str(Trim(n))), Space(1))
num = num + Trim(Str(n))
i = 1
z = ""

Do While True
   k = Mid(num, 18 - (i * 3 - 1), 3)

   If k = Space(3) Then
      Exit Do
   End If

   c = Val(Mid(k, 1, 1))
   D = Val(Mid(k, 2, 1))
   u = Val(Mid(k, 3, 1))
   v = Val(Mid(k, 2, 2))

   If i > 1 Then
      If (i = 2 Or i = 4) And Val(k) > 0 Then
         z = " MIL " + z
      End If
      If i = 3 And Val(Mid(num, 7, 6)) > 0 Then
         If Val(k) = 1 Then
            z = " MILLON " + z
         Else
            z = " MILLONES " + z
         End If
      End If
      If i = 5 And Val(k) > 0 Then
         If Val(k) = 1 Then
            z = " BILLON " + z
         Else
            z = " BILLONES " + z
         End If
      End If
   End If

   If v > 0 Then
      Select Case v
             Case 0 To 15
                  z = uni(v) + z
             Case 0 To 19
                  z = " DIECI" + uni(u) + z
             Case 20
                  z = " VEINTE " + z
             Case 0 To 29
                  z = " VEINTI" + uni(u) + z
             Case Else
                  If u = 0 Then
                     z = dec(D) + z
                  Else
                     z = dec(D) + " Y " + uni(u) + z
                  End If
      End Select
   End If

   If c > 0 Then
      If c = 1 Then
         If v = 0 Then
            z = " CIEN " + z
         Else
            z = " CIENTO " + z
         End If
      End If
      If c = 2 Or c = 3 Or c = 4 Or c = 6 Or c = 8 Then
         z = uni(c) + "CIENTOS " + z
      End If
      If c = 5 Then
         z = " QUINIENTOS " + z
      End If
      If c = 7 Then
         z = " SETECIENTOS " + z
      End If
      If c = 9 Then
         z = " NOVECIENTOS " + z
      End If
   End If

   i = i + 1
Loop

If cDecimales = "0000" Then
   cDecimales = "00"
   cDenomi = "/100"
Else
   cDenomi = "/10000"
   
   If Mid(cDecimales, 4, 1) = "0" Then
      cDecimales = Mid(cDecimales, 1, 3)
      cDenomi = "/1000"
      
      If Mid(cDecimales, 3, 1) = "0" Then
         cDecimales = Mid(cDecimales, 1, 2)
         cDenomi = "/100"
      End If
   End If
End If

cDecimales = BacRemplazar(Str(Val(cDecimales)), " ", "")
cDecimales = " CON  " + cDecimales + cDenomi

BacMonto_Escrito = "( " & BacRemplazar(Trim(z), "  ", " ") & cDecimales & " )"

End Function

Public Function BacFormatoFecha(cFormato As String, dFecha As Variant) As String
' cFormato ( DDMMAA )  =>  Día de Mes de Año
' cFormato ( MMDDAA )  =>  Mes, Día de Año
   If cFormato = "DDMMAA" Then
      BacFormatoFecha = Format(dFecha, "d") + " de " + Format(dFecha, "mmmm") + " de " + Format(dFecha, "yyyy")
   Else
      BacFormatoFecha = Format(dFecha, "mmmm ,") + Format(dFecha, "d") + " de " + Format(dFecha, "yyyy")
   End If
End Function

Public Function BacFormatoRut(cRut As Variant) As String
   Dim nPosicion As Integer
   Dim cString1  As String
   Dim cString2  As String
   Dim nMonto   As Long
   
   cRut = BacRemplazar(cRut, " ", "")
   nPosicion = InStr(cRut, "-")
   cString1 = Mid(cRut, 1, nPosicion - 1)
   cString2 = Mid(cRut, nPosicion + 1, 1)
   nMonto = Val(cString1)
   cString1 = Format(nMonto, "#,##0")
   cString1 = BacRemplazar(cString1, ",", ".")
   BacFormatoRut = cString1 + "-" + cString2
      
End Function

Public Function BacFormatoMonto(nMonto As Variant, nDecimales As Integer) As String
nMonto = Val(Str(nMonto))
   
Select Case nDecimales
   Case 0
      BacFormatoMonto = Format(nMonto, "#,##0")
   Case Else
      BacFormatoMonto = Format(nMonto, "#,##0." & String(nDecimales - 1, "#") & "0")
End Select
   
End Function

Function BacBuscaTxtCombo(oCombo As ComboBox, cTexto As String)
Dim i As Integer

BacBuscaTxtCombo = False

For i = 0 To oCombo.ListCount - 1
       
    oCombo.ListIndex = i
    
    If Trim(oCombo) = Trim(cTexto) Then
       BacBuscaTxtCombo = True
       Exit Function
    End If
    
Next

End Function

Public Function BacGlosaMon(cMoneda As Variant, lMoneda As Boolean, cCodMon As Variant, cCodCnv As Variant) As String
   
   Select Case cMoneda
       Case "CLP"
          BacGlosaMon = "PESOS"
       Case "UF"
          BacGlosaMon = "UNIDADES DE FOMENTO"
       Case Else
          BacGlosaMon = IIf(lMoneda, cCodMon, cCodCnv)
   End Select
   
End Function
Public Function BacGlosaPrecioFuturo(nPreFut As Variant, cCodMon As Variant, cCodCnv As Variant, nRelDolar As Variant) As String
   Dim cMonedas
   cMonedas = cCodCnv & " por " & cCodMon
   
   If cCodMon <> "USD" Then
      cMonedas = IIf(nRelDolar <> 1, cMonedas, cCodMon & " por " & cCodCnv)
   End If
   
   cMonedas = cMonedas & " 1,00"
   BacGlosaPrecioFuturo = BacFormatoMonto(Val(nPreFut), IIf(cCodCnv = "UF", 10, 4)) & " " & cMonedas

End Function
Public Function BacMasMes(pFecha As String, pMeses As Integer)

Dim nDia   As Integer
Dim nMes   As Integer
Dim nAno   As Integer
Dim dFecha As Variant

nDia = Day(pFecha)
nMes = Month(pFecha) + pMeses
nAno = Year(pFecha)

If nMes > 12 Then
        nMes = nMes - 12
        nAno = nAno + 1
End If

dFecha = Format("01" & sSeparadorFecha$ & Str(nMes) & sSeparadorFecha$ & Str(nAno), "dd/mm/yyyy")

If BacDiasMes(dFecha) < nDia Then
    nMes = nMes + 1
    nDia = nDia + BacDiasMes(dFecha)
End If

dFecha = Format(Str(nDia) & sSeparadorFecha$ & Str(nMes) & sSeparadorFecha$ & Str(nAno), "dd/mm/yyyy")
pFecha$ = dFecha

BacMasMes = BacProxHabil(pFecha$, "")

End Function
Public Function BacCortes(dFecIni As Variant, dFecVto As Variant, nCortes As Integer)

 Dim xDiaIni    As Integer
 Dim xMesIni    As Integer
 Dim xAnoIni    As Integer
 Dim xDiaVto    As Integer
 Dim xMesVto    As Integer
 Dim xAnoVto    As Integer
 Dim xCortes    As Integer
 Dim xLoop      As Integer

 xDiaIni = Day(dFecIni)
 xMesIni = Month(dFecIni)
 xAnoIni = Year(dFecIni)
 xDiaVto = Day(dFecVto)
 xMesVto = Month(dFecVto)
 xAnoVto = Year(dFecVto)
 xCortes = 0
 xLoop = True
 

 If nCortes = 1 And DateDiff("d", dFecIni, dFecVto) < 45 Then
    BacCortes = 1
 End If

 While xLoop
        If xAnoIni < xAnoVto Then
        
           If xMesIni = 12 Then
              xCortes = xCortes + 1
              xMesIni = 1
              xAnoIni = xAnoIni + 1
    
           ElseIf xMesIni > xMesVto Then
              xCortes = xCortes + 1
              xAnoIni = xAnoIni + 1
           Else
              xCortes = xCortes + 12
              xAnoIni = xAnoIni + 1
           End If
           
        ElseIf xMesIni < xMesVto Then
        
              xCortes = xCortes + 1
              xAnoIni = xAnoIni + 1
            Else
             xLoop = False
             
        End If
 Wend

 If xDiaIni > xDiaVto And (xDiaIni - xDiaVto) > 10 Then
    xCortes = xCortes - 1
 End If

'==============================

 xCortes = (xCortes / nCortes)

If Int(xCortes) <> xCortes Then
       MsgBox "Fechas NO concuerdan con Períodos Seleccionados", vbExclamation, TITSISTEMA
       xCortes = 0
       
ElseIf xCortes = 0 Then
       xCortes = 1
End If

BacCortes = xCortes

End Function
Public Function BacDiasMes(pFecha As Variant)
Dim nDia   As Integer
Dim nMes   As Integer
Dim nAno   As Integer
Dim dFec1  As Variant
Dim dFec2  As Variant

nDia = Day(pFecha)
nMes = Month(pFecha)
nAno = Year(pFecha)

dFec1 = Format("01" & sSeparadorFecha$ & Str(nMes) & sSeparadorFecha$ & Str(nAno), "dd/mm/yyyy")

nMes = nMes + 1

If nMes > 12 Then
    nMes = 1
    nAno = nAno + 1
End If

dFec2 = Format("01" & sSeparadorFecha$ & Str(nMes) & sSeparadorFecha$ & Str(nAno), "dd/mm/yyyy")

BacDiasMes = DateDiff("d", dFec1, dFec2)

End Function


Sub Despinta(Grilla As Object)

    With Grilla
      If .Row <> 0 Then
        .CellForeColor = -2147483635
'        .CellForeColor = &HC00000

        .CellBackColor = &H8000000F
      End If
    End With

End Sub

