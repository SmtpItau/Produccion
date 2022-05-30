Attribute VB_Name = "BacLib"
Option Explicit
' 1  Formas de Pago
' 2  Tipo de Mercado
' 3  Tipo de Custodia
' 4  Tipo de Cartera
' 5  Retiro
' 6  Comunas
' 7  Tipo de Cliente
' 8  Sector Economico
' 9  Monedas de Pacto
'10  Tipo de Emisor
'11  Base de Calculo
'12  Tipo de Amortizacion
'13  Tipo de operacion
'14  Estados de Registro
'15  Plazas
'16  Periodo

'Variables utilizadas por Acceso y CambioPassword
    Public Largo_Clave     As Integer
    Public Tipo_Clave      As String

'Constantes Para La Tabla de Emisores
'------------------------------------
Global Const MDEM_TIPOEMISOR = 10

'Constantes Para la Tabla de Monedas
'-----------------------------------
Global Const MDTB_PERIODO = 16
Global Const MDTB_BASE = 11
Global Const MDTB_TIPOPER = 50
Global Const MDTB_TIPVAL = 51
Global Const MDTB_TIPOMONEDA = 52
Global Const MDTB_PAIS = 53

'Constantes Para la Tabla de Feriados
'------------------------------------
Global Const MDFE_PLAZA = 15

'Constantes para la tabla de instrumentos
'--------------------------------------------
Global Const MDIN_BASES = 11
Global Const MDIN_TIPOFECHA = 20
Global Const MDIN_TIPO = 19
Global Const MDIN_EMISION = 21


'Constantes Para la Tabla de Series
'--------------------------------------------
Global Const MDSE_TIPOAMORTIZACION = 12
Global Const MDSE_TIPOPERIODO = 16

'Constantes para Form. de Plan de Cuentas
Global Const MDPC_TIPO = 23

Global xEntidad As String


Sub PROC_FMT_NUMERICO(texto As Control, NEnteros, NDecs As Integer, ByRef Tecla, Signo As String, Decim As String)

Dim PosPto As Integer

   If Tecla = 13 Or Tecla = 27 Then Exit Sub

   If Tecla = 45 And Signo = "+" Then Tecla = 0

    If Tecla <> 8 And (Tecla < 48 Or Tecla > 57) Then
    
  If NDecs = 0 Then
          Tecla = 0
    ElseIf Tecla <> Asc(Decim) Then 'Tecla <> 46 And Tecla <> 45 Then
           Tecla = 0
   
    End If
  
  End If

    If Tecla = 45 And Signo = "-" Then  ' Signo negativo
    If InStr(texto.text, "-") > 0 Then
           Tecla = 0
    ElseIf texto.SelStart > 0 Then
          If Mid(texto.text, texto.SelStart, 1) <> "" Then
             Tecla = 0
          End If
    End If
    End If


  PosPto% = InStr(texto.text, Decim)
  If PosPto% > 0 And Tecla = Asc(Decim) Then
       Tecla = 0
       Exit Sub
  End If

  If NDecs > 0 And PosPto% > 0 And PosPto% <= texto.SelStart Then
     PosPto% = PosPto% + 1
    If Len(Mid(texto.text, PosPto%, NDecs)) = NDecs And Tecla <> 8 Then
           Tecla = 0
    Else
           Exit Sub
    End If
  End If

  If PosPto% > 0 And texto.SelStart < PosPto% And Tecla <> 8 Then
     If Len(Mid(texto.text, 1, PosPto% - 1)) >= NEnteros Then Tecla = 0
     ElseIf PosPto% = 0 And Tecla <> 8 And Chr(Tecla) <> Decim Then
       If Len(texto.text) >= NEnteros Then Tecla = 0
  End If

End Sub
Function ChequeaCierreMesa()
Dim SQL$
Dim Datos()
Dim lCierreMesa As Integer

ChequeaCierreMesa = True

'Sql$ = "EXECUTE sp_Control_Procesos "
'Sql$ = Sql$ & PAR_CIERRE_MESA

'If MISQL.SQL_Execute(Sql$) = 0 Then

'   'If misql.SQL_Fetch(Datos()) = 0 Then
'   While MISQL.SQL_Fetch(DATOS()) = 0
      
'      lCierreMesa = Val(Trim(DATOS(1)))
   
'   Wend
   
'End If

Envia = Array()
AddParam Envia, PAR_CIERRE_MESA
   
If Not Bac_Sql_Execute("SP_CONTROL_PROCESOS", Envia) Then
   Screen.MousePointer = 0
   Exit Function
Else
   Do While Bac_SQL_Fetch(Datos())
      lCierreMesa = Val(Trim(Datos(1)))
   Loop
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


'Function BacAbrirBaseDatosMDB() As Boolean

 '  On Error GoTo BacErrorHandler

 '  BacAbrirBaseDatosMDB = False
'
'   Set WS = DBEngine.Workspaces(0)
'   Set DB = WS.OpenDatabase(gsMDB_Path & gsMDB_Database, False, False)
    
'   BacAbrirBaseDatosMDB = True

'   Exit Function
    
'BacErrorHandler:
    
'   BacLogFile "AbrirBaseDatosMDB " & Err.Description$
'   If BacErrorHandlerMDB(Err) = True Then
'      Resume

'   End If

'   Exit Function

'End Function

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
         .Col = 1: .text = DateAdd("D", nDias, dFecha)

      Next nDias

   End With

End Function

Public Function BACLeerValoresMoneda(nCodMda As Integer, nMes As Integer, nAno As Integer, oControl As Object, sTipMnt As String) As Boolean

   Dim SQL           As String
   Dim Datos()

'   Sql = "EXECUTE sp_mdvmleervalmon " & nCodMda & ", " & nMes & ", " & nAno
'
   BACLeerValoresMoneda = False
'
'   If MISQL.SQL_Execute(Sql) <> 0 Then
'      MsgBox "Problemas al leer los valores de moneda", vbInformation, "MENSAJE"
'      Exit Function
'
'   End If
'
'   With oControl
'      .Rows = 1
'
'      Do While MISQL.SQL_Fetch(DATOS()) = 0
'
'         .Rows = .Rows + 1
'         .Row = .Rows - 1
'         .Col = 1: .Text = DATOS(5)
'
'         Select Case sTipMnt
'         Case "ME"
'            .Col = 2: .Text = Val(DATOS(3))
'            .Col = 3: .Text = Val(DATOS(4))
'
'         Case "MN"
'            .Col = 2: .Text = Val(DATOS(2))
'
'         End Select
'
'      Loop
'
'   End With

   Envia = Array()
   AddParam Envia, CDbl(nCodMda)
   AddParam Envia, CDbl(nMes)
   AddParam Envia, CDbl(nAno)

   If Not Bac_Sql_Execute("SP_MDVMLEERVALMON", Envia) Then
      MsgBox "Problemas al leer los valores de moneda", vbInformation, "MENSAJE"
      Screen.MousePointer = 0
      Exit Function
   Else
      With oControl
      .Rows = 1
      Do While Bac_SQL_Fetch(Datos())
         .Rows = .Rows + 1
         .Row = .Rows - 1
         .Col = 1: .text = Datos(5)
         Select Case sTipMnt
         Case "ME"
            .Col = 2: .text = Val(Datos(3))
            .Col = 3: .text = Val(Datos(4))
         Case "MN"
            .Col = 2: .text = Val(Datos(2))
         End Select
      Loop
      End With
   End If

   BACLeerValoresMoneda = True

End Function

Public Function BACGrabarValoresMoneda(nCodMda As Integer, oControl As Object, sTipMnt As String) As Boolean

   Dim SQL           As String
   Dim nLin          As Integer

   BACGrabarValoresMoneda = False

   Envia = Array()
   AddParam Envia, nCodMda
   
   With oControl

      For nLin = 1 To .Rows - 1

'         Sql = "EXECUTE sp_mdvmgrabarvalmon " & nCodMda & ", "
'
'         .Row = nLin
'         Select Case sTipMnt
'         Case "ME"
'            Sql = Sql & "0, "
'            .Col = 2: Sql = Sql & Val(.Text) & ", "
'            .Col = 3: Sql = Sql & Val(.Text) & ", "
'
'         Case "MN"
'            .Col = 2: Sql = Sql & Val(.Text) & ", "
'            Sql = Sql & "0, 0, "
'
'         End Select
'
'         .Col = 1: Sql = Sql & "'" & Format(.Text, "YYYYMMDD") & "'"
'
'         If MISQL.SQL_Execute(Sql) <> 0 Then
'            MsgBox "Problemas al leer los valores de moneda", vbInformation, "MENSAJE"
'            Exit Function
'
'         End If

         .Row = nLin
         Select Case sTipMnt
         Case "ME"
            AddParam Envia, "0"
            .Col = 2
            AddParam Envia, CDbl(Val(.text))
            .Col = 3
            AddParam Envia, CDbl(Val(.text))
         Case "MN"
            .Col = 2
            AddParam Envia, CDbl(Val(.text))
            AddParam Envia, "0"
            AddParam Envia, "0"

         End Select
         .Col = 1
'         Sql = Sql & "'" & Format(.Text, "YYYYMMDD") & "'"
         AddParam Envia, Format(.text, "yyyymmdd")
   
         If Not Bac_Sql_Execute("SP_MDVMGRABARVALMON", Envia) Then
            Screen.MousePointer = 0
            MsgBox "Problemas al leer los valores de moneda", vbInformation, "MENSAJE"
            Exit Function
         End If

      Next nLin

   End With

   BACGrabarValoresMoneda = True

End Function

Function BacProxHabil(xFecha As String) As String
    Dim dFecha As String
    
   dFecha = xFecha
   dFecha = Format(DateAdd("d", 1, dFecha), gsc_FechaDMA)

   Do While Not BacEsHabil(dFecha)
      dFecha = Format(DateAdd("d", 1, dFecha), gsc_FechaDMA)

   Loop

   BacProxHabil = dFecha


End Function

Public Function RELLENA_STRING(Dato As String, pos As String, Largo As Integer) As String

'rellena con blancos y completa el largo requerido
' Ejemplo : x$ = RELLENA_STRING(CStr(i#), "I", 10)
' Ejemplo : x$ = RELLENA_STRING(i$, "D", 10)

If Trim(pos$) = "" Then pos$ = "I"

If Largo < Len(Trim(Dato)) Then
   RELLENA_STRING = Mid(Trim(Dato), 1, Largo)
   Exit Function
End If

If Mid(pos$, 1, 1) = "I" Then 'IZQUIERDA
   RELLENA_STRING = String(Largo - Len(Trim(Dato)), " ") + Trim(Dato)
Else                          'DERECHA
   RELLENA_STRING = Trim(Dato) + String(Largo - Len(Trim(Dato)), " ")
End If

RELLENA_STRING = Mid(RELLENA_STRING, 1, Largo)

End Function

'Convierte el caracter a mayuscula y devuelve el codigo asccii
'97=a ---- 122=z
Sub BacToUCase(ByRef KeyAscii As Integer)

   If KeyAscii >= 97 Or KeyAscii <= 122 Then
      KeyAscii = Asc(UCase$(Chr$(KeyAscii)))
      
   End If
    
End Sub
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
Public Function BacBuscaCodigo(obj As Object, codi As Integer) As Long
        
   Dim f   As Long
   Dim Max As Long
        
   BacBuscaCodigo = -1
            
   Max = obj.coleccion.Count
            
   For f = 1 To Max
      If obj.coleccion(f).Codigo = codi Then
         BacBuscaCodigo = f - 1
         Exit For
      
      End If
   
   Next f

End Function

Public Function BacBuscaGlosa(obj As Object, codi As String) As Long
   
   Dim f   As Long
   Dim Max As Long
        
   BacBuscaGlosa = -1
            
   Max = obj.coleccion.Count
      
   For f = 1 To Max
      If Trim$(obj.coleccion(f).Glosa) = Trim(codi) Then
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
Public Function BacEsHabil(cFecha As String) As Boolean

   Dim objFeriado As New clsFeriado
   
   Dim iAno       As Integer
   Dim iMes       As Integer
   Dim sDia       As String
   Dim gcPlaza    As String
   Dim n          As Integer
   
   ' Temporalmente.-
   '-----------------
   gcPlaza = "00006"
   
   sDia = BacDiaSem(cFecha)
   If sDia = "Sábado" Or sDia = "Domingo" Then
      BacEsHabil = False
      Exit Function
      
   End If
   
   iAno = DatePart("yyyy", cFecha)
   iMes = DatePart("m", cFecha)
   sDia = Format(DatePart("d", cFecha), "00")
   
   objFeriado.Leer iAno, gcPlaza
   
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
   
   cbx.AddItem "Enero"
   cbx.ItemData(cbx.NewIndex) = 1
   cbx.AddItem "Febrero"
   cbx.ItemData(cbx.NewIndex) = 2
   cbx.AddItem "Marzo"
   cbx.ItemData(cbx.NewIndex) = 3
   cbx.AddItem "Abril"
   cbx.ItemData(cbx.NewIndex) = 4
   cbx.AddItem "Mayo"
   cbx.ItemData(cbx.NewIndex) = 5
   cbx.AddItem "Junio"
   cbx.ItemData(cbx.NewIndex) = 6
   cbx.AddItem "Julio"
   cbx.ItemData(cbx.NewIndex) = 7
   cbx.AddItem "Agosto"
   cbx.ItemData(cbx.NewIndex) = 8
   cbx.AddItem "Septiembre"
   cbx.ItemData(cbx.NewIndex) = 9
   cbx.AddItem "Octubre"
   cbx.ItemData(cbx.NewIndex) = 10
   cbx.AddItem "Noviembre"
   cbx.ItemData(cbx.NewIndex) = 11
   cbx.AddItem "Diciembre"
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


Public Function BacValidaRut(Rut As String, dig As String) As Integer

   Dim i       As Integer
   Dim D       As Integer
   Dim Divi    As Long
   Dim Suma    As Long
   Dim digito  As String
   Dim multi   As Double

   BacValidaRut = False
    
   If Trim$(Rut) = "" Or Trim$(dig) = "" Then
      Exit Function
   
   End If
    
   Rut = Format(Rut, "00000000")
   D = 2
   For i = 8 To 1 Step -1
      multi = Val(Mid$(Rut, i, 1)) * D
     Suma = Suma + multi
      D = D + 1
      
      If D = 8 Then
         D = 2
      
      End If
   Next i
    
   Divi = (Suma \ 11)
   multi = Divi * 11
   digito = Trim$(Str$(11 - (Suma - multi)))
    
   If digito = "10" Then
      digito = "K"
   
   End If
    
   If digito = "11" Then
      digito = "0"
   
   End If
    
   If Trim$(UCase$(digito)) = UCase$(Trim$(dig)) Then
      BacValidaRut = True
   
   End If

End Function

Public Function BacCheckRut(Rut As String) As String

   Dim i       As Integer
   Dim D       As Integer
   Dim Divi    As Long
   Dim Suma    As Long
   Dim digito  As String
   Dim multi   As Double
   
   If Trim$(Rut) = "" Then
      Exit Function
   
   End If
    
   Rut = Format(Rut, "00000000")
   D = 2
   For i = 8 To 1 Step -1
      multi = Val(Mid$(Rut, i, 1)) * D
     Suma = Suma + multi
      D = D + 1
      
      If D = 8 Then
         D = 2
      
      End If
   Next i
    
   Divi = (Suma \ 11)
   multi = Divi * 11
   digito = Trim$(Str$(11 - (Suma - multi)))
    
   If digito = "10" Then
      digito = "K"
   
   End If
    
   If digito = "11" Then
      digito = "0"
   
   End If
    
   BacCheckRut = Trim$(UCase$(digito))
   
End Function

Public Function BacDiv(n1 As Double, n2 As Double) As Double
         
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

   Do While Not BacEsHabil(cFecha)
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
   cFecha = BacProxHabil(cFecha)
   
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
   
   
   'cFecha = Format$(cFecha, gsc_FechaDMA)
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

   Do While Not BacEsHabil(cFecha)
      cFecha = Format(DateAdd("d", -1, cFecha), gsc_FechaDMA)

   Loop

   BacPrevHabil = cFecha

End Function

Function BacMonto_Escrito(n As Double) As String

ReDim uni(15) As String
ReDim Dec(9) As String
Dim z, Num, Var   As Variant
Dim C, D, u, v, i As Integer
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

Dec(3) = "TREINTA"
Dec(4) = "CUARENTA"
Dec(5) = "CINCUENTA"
Dec(6) = "SESENTA"
Dec(7) = "SETENTA"
Dec(8) = "OCHENTA"
Dec(9) = "NOVENTA"

Num = String$(19 - Len(Str(Trim(n))), Space(1))
Num = Num + Trim(Str(n))
i = 1
z = ""

Do While True
   k = Mid(Num, 18 - (i * 3 - 1), 3)

   If k = Space(3) Then
      Exit Do
   End If

   C = Val(Mid(k, 1, 1))
   D = Val(Mid(k, 2, 1))
   u = Val(Mid(k, 3, 1))
   v = Val(Mid(k, 2, 2))

   If i > 1 Then
      If (i = 2 Or i = 4) And Val(k) > 0 Then
         z = " MIL " + z
      End If
      If i = 3 And Val(Mid(Num, 7, 6)) > 0 Then
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
                     z = Dec(D) + z
                  Else
                     z = Dec(D) + " Y " + uni(u) + z
                  End If
      End Select
   End If

   If C > 0 Then
      If C = 1 Then
         If v = 0 Then
            z = " CIEN " + z
         Else
            z = " CIENTO " + z
         End If
      End If
      If C = 2 Or C = 3 Or C = 4 Or C = 6 Or C = 8 Then
         z = uni(C) + "CIENTOS " + z
      End If
      If C = 5 Then
         z = " QUINIENTOS " + z
      End If
      If C = 7 Then
         z = " SETECIENTOS " + z
      End If
      If C = 9 Then
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
   
   If cRut = "" Then Exit Function

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
       MsgBox "Fechas NO concuerdan con Períodos Seleccionados"
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

Public Function BacDifDias30(FechaDesde, FechaHasta, Optional tipo As String = "P") As Double
Dim Meses As Integer
Dim FechaCalc As String
Dim DifDias As Integer

   Dim Datos()
   
   Envia = Array()
   AddParam Envia, Format(FechaDesde, "yyyymmdd")
   AddParam Envia, Format(FechaHasta, "yyyymmdd")
   AddParam Envia, tipo
   If Not Bac_Sql_Execute("SP_DIFDIAS30", Envia) Then
      Exit Function
   End If
   If Bac_SQL_Fetch(Datos()) Then
      BacDifDias30 = Datos(1)
   End If
   
Exit Function
   
    Meses = DateDiff("m", FechaDesde, FechaHasta)

    FechaCalc = DateAdd("m", Meses, FechaDesde)
    
    DifDias = DateDiff("d", FechaCalc, FechaHasta)
    
    BacDifDias30 = (Meses * 30) + DifDias
    
End Function


'BeginNewConnection
Public Function GetNewConnection() As ADODB.Connection
    
    Dim oCn As New ADODB.Connection
    Dim CadenaConexion As String
  
    CadenaConexion = ""
    
    If gsSQL_Login$ = "bacuser" Then
      CadenaConexion = CadenaConexion & "Provider=SQLOLEDB; "
      CadenaConexion = CadenaConexion & "Initial Catalog=" & gsSQL_Database & ";"
      CadenaConexion = CadenaConexion & "Data Source=" & gsSQL_Server$ & ";"
      CadenaConexion = CadenaConexion & "User Id=" & gsSQL_Login$ & ";"
      CadenaConexion = CadenaConexion & "Password=" & gsSQL_Password$ & ";"
    Else
      CadenaConexion = "Provider=SQLOLEDB;Data Source=" & gsSQL_Server & ";Database=" & gsSQL_Database & ";trusted_connection=yes;Connect Timeout=" & giSQL_LoginTimeOut
    End If
    
    oCn.Open CadenaConexion
  
    If oCn.State = adStateOpen Then
        Set GetNewConnection = oCn
    End If
  
End Function
'EndNewConnection


