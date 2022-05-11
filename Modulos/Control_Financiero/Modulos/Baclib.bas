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
'12  Tipo de Amortizscion
'13  Tipo de operacion
'14  Estados de Registro
'15  Plazas
'16  Periodo


'Constantes Para la Tabla de Clientes
'------------------------------------
'Global Const MDTC_COMUNAS = 6
Global Const MDTC_TIPOCLIENTE = 207
Global Const MDTC_SECECONOMICO = 208
'Global Const MDTC_CIUDAD = 31
'Global Const MDTC_REGION = 32
Global Const MDTC_ENTIDAD = 234
Global Const MDTC_MERCADO = 202
Global Const MDTC_GRUPO = 233
Global Const MDTC_Pais = 180  'Antes 35
Global Const MDTC_CALIDADJURIDICA = 39 'Antes 36

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
Global Const MDFE_PLAZA = 6 ' 15

'Constantes para la tabla de instrumentos
'--------------------------------------------
Global Const MDIN_BASES = 11
Global Const MDIN_TIPOFECHA = 20
Global Const MDIN_TIPO = 19
Global Const MDIN_EMISION = 21
Global gs_Pusd As Boolean

'Constantes Para la Tabla de Series
'--------------------------------------------
Global Const MDSE_TIPOAMORTIZACION = 12
Global Const MDSE_TIPOPERIODO = 16
Global sql$, Datos(), Evento$, i%, Mensaje$, Panta$
'Constantes para Form. de Plan de Cuentas
Global Const MDPC_TIPO = 23
Global xEntidad As String
Global fecha_expira As Date






Public Function ProcesaBloqueo(Var As String)

    ProcesaBloqueo = False
    
    Envia = Array(Var)
    If Bac_Sql_Execute("sp_PreCierre", Envia) Then
        If Bac_SQL_Fetch(Datos()) = 0 Then
            ProcesaBloqueo = (Datos(1) = 0)
            Call ActuaIni(9, IIf(Var = "B", "1", "0"))
        End If
    End If
    If Not ProcesaBloqueo Then
        MsgBox "No se puede realizar PreCierre de Mesa", vbInformation, TITSISTEMA
    End If
        
End Function

Public Function BacFechaDMY(dFecha As Object) As Boolean

   Dim sSeparador       As String
   Dim nDia             As Integer
   Dim nMes             As Integer
   Dim nAno             As Integer
   Dim nDiaMes          As Integer

   BacFechaDMY = False

   If Mid$(dFecha.Text, 1, 2) < "01" Or Mid$(dFecha.Text, 1, 2) > "31" Then
      Exit Function

   End If

   If Mid$(dFecha.Text, 4, 2) < "01" Or Mid$(dFecha.Text, 4, 2) > "12" Then
      Exit Function

   End If

   If (Mid$(dFecha.Text, 3, 1) <> gsc_FechaSeparador Or Mid$(dFecha.Text, 6, 1) <> gsc_FechaSeparador) And (Mid$(dFecha.Text, 3, 1) <> "-" Or Mid$(dFecha.Text, 6, 1) <> "-") Then
      Exit Function

   End If

   If Len(dFecha.Text) > 8 Then
      If Mid$(dFecha.Text, 7, 4) < "1950" Or Mid$(dFecha.Text, 7, 4) > "2200" Then
         Exit Function

      End If
      nAno = Val(Mid$(dFecha.Text, 7, 4))

   Else
      If Mid$(dFecha.Text, 7, 4) > "49" Then
         nAno = 1900 + Val(Mid$(dFecha.Text, 7, 4))

      Else
         nAno = 2000 + Val(Mid$(dFecha.Text, 7, 4))

      End If

   End If

   sSeparador = Mid$(dFecha.Text, 3, 1)

   nDia = Val(Mid$(dFecha.Text, 1, 2))
   nMes = Val(Mid$(dFecha.Text, 4, 2))

   If nMes = 1 Or nMes = 3 Or nMes = 5 Or nMes = 7 Or nMes = 8 Or nMes = 10 Or nMes = 12 Then
      nDiaMes = 31

   ElseIf nMes = 4 Or nMes = 6 Or nMes = 9 Or nMes = 11 Then
      nDiaMes = 30

   ElseIf nMes = 2 Then
      If (nAno / 4) <> Int(nAno / 4) Then
         nDiaMes = 28

      Else
         nDiaMes = 29
   
      End If
   
   End If

   If nDia <= nDiaMes Then
      BacFechaDMY = True

   End If

   dFecha.Text = Format(nDia, "00") + sSeparador + Format(nMes, "00") + sSeparador + Format$(nAno, "0000")

End Function

Public Function BuscaOperaciones(pan As Form, TipMer$, TipOpe$, entidad$, Orden%) As Boolean
Dim C$
    C = 0
    
    Envia = Array(CDbl(entidad), _
                  TipMer, _
                  Trim(UCase(TipOpe$)), _
                  CDbl(Orden))
    If Not Bac_Sql_Execute("sp_Operaciones_Dia", Envia) Then
        Exit Function
    End If
    
    With pan
    'Dim XXXXX
    'Dim ESIGUAL
    'Dim ixxxxx
    .Grid1.Redraw = False
    .Grid1.Rows = 1
    'ESIGUAL = 0
     Do While Bac_SQL_Fetch(Datos())
            C = "1"
'            XXXXX = ""
'            XXXXX = Val(Datos(3))
'            For ixxxxx = 1 To .Grid1.Rows - 1
'                If XXXXX = Val(.Grid1.TextMatrix(ixxxxx, 1)) Then
'                    ESIGUAL = 1
'                End If
'            Next
'            If ESIGUAL = 0 Then
                    .Grid1.Rows = .Grid1.Rows + 1
                    .Grid1.Row = .Grid1.Rows - 1
    
    
    
            .Grid1.Col = 1:  .Grid1.Text = Str(Val(Datos(1)))                       '-- Entidad
            .Grid1.Col = 2:  .Grid1.Text = Trim(Datos(2))                           '-- Tipo de Mercado
            .Grid1.Col = 3:  .Grid1.Text = Val(Datos(3))                            '-- Nro.Oper
            .Grid1.Col = 4:  .Grid1.Text = CDbl(Val(Datos(4)))                      '-- Rut
            .Grid1.Col = 5:  .Grid1.Text = Datos(5)                                 '-- DV de Rut
            .Grid1.Col = 6:  .Grid1.Text = CDbl(Val(Datos(6)))                      '-- Codigo Cliente
            .Grid1.Col = 7:  .Grid1.Text = Trim(Datos(7))                           '-- Nombre
            .Grid1.Col = 8:  .Grid1.Text = IIf(Datos(8) = "C", "COMPRA", IIf(Datos(8) = "V", "VENTA", "ANULADA")) '-- C/V
            .Grid1.Col = 9:  .Grid1.Text = Trim(Datos(9))                           '-- Moneda Origen
            .Grid1.Col = 10: .Grid1.Text = Trim(Datos(10))                          '-- Contra Moneda
            .Grid1.Col = 11: .Grid1.Text = Format(CDbl(Val(Datos(11))), "#,##0.0000") '-- Monto en Moneda
            .Grid1.Col = 12: .Grid1.Text = Format(CDbl(Val(Datos(12))), "#,##0.00")   '-- T/C
            .Grid1.Col = 13: .Grid1.Text = Format(CDbl(Val(Datos(13))), "#,##0.00")   '-- T/C Costo
            .Grid1.Col = 14: .Grid1.Text = Format(CDbl(Val(Datos(14))), "#,##0.0000") '-- Paridad
            .Grid1.Col = 15: .Grid1.Text = Format(CDbl(Val(Datos(15))), "#,##0.0000") '-- Paridad Costo
            .Grid1.Col = 16: .Grid1.Text = Format(CDbl(Val(Datos(16))), "#,##0.00")   '-- Precio
            .Grid1.Col = 17: .Grid1.Text = Format(CDbl(Val(Datos(17))), "#,##0.00")   '-- Precio Costo
            .Grid1.Col = 18: .Grid1.Text = Format(CDbl(Val(Datos(18))), "#,##0.00")   '-- Monto en US$
            .Grid1.Col = 19: .Grid1.Text = Format(CDbl(Val(Datos(19))), "#,##0")      '-- Monto en Pesos
            .Grid1.Col = 20: .Grid1.Text = CDbl(Val(Datos(20)))                     '-- Codigo Entregamos
            .Grid1.Col = 21: .Grid1.Text = Trim(Datos(21))                          '-- Glosa  Entregamos
            .Grid1.Col = 22: .Grid1.Text = Trim(Datos(22))                          '-- Valuta Entregamos
            .Grid1.Col = 23: .Grid1.Text = CDbl(Val(Datos(23)))                     '-- Codigo Recibimos
            .Grid1.Col = 24: .Grid1.Text = Trim(Datos(24))                          '-- Glosa  Recibimos
            .Grid1.Col = 25: .Grid1.Text = Trim(Datos(25))                          '-- Valuta Recibimos
            .Grid1.Col = 26: .Grid1.Text = Trim(Datos(26))                          '-- Operador
            .Grid1.Col = 27: .Grid1.Text = Trim(Datos(27))                          '-- Fecha Operacion
            .Grid1.Col = 28: .Grid1.Text = Trim(Datos(28))                          '-- Hora  Operacion
 '         End If
'          ESIGUAL = 0
        Loop
       
        BuscaOperaciones = (C = 1)
        
     '   .Grid1.Rows = .Grid1.Rows - 1
     '   .Grid1.Refresh
    .Grid1.Redraw = True
    End With
  
End Function
Public Function ActuaBoton(Lugar%, CmdGrabar2 As Object, CmdGrabar1 As Object)
    If Not ChkPrgF(Lugar) Then
        CmdGrabar2.Visible = False
        CmdGrabar1.Visible = True
    Else
        CmdGrabar2.top = CmdGrabar1.top
        CmdGrabar2.Left = CmdGrabar1.Left
        CmdGrabar2.Height = CmdGrabar1.Height
        CmdGrabar2.Width = CmdGrabar1.Width
        CmdGrabar1.Visible = False
        CmdGrabar2.Visible = True
    End If
End Function
Public Function ActuaIni(Pos%, ValPos$)
  
End Function
' los botones deben llamarce Cmdlimpiar y Cmdsalir
' el mdiform en la propiedad LinkTopic debe ser = MDIFORM
Public Function Sqlsale(pan As Form)
Dim u%

    If Not (pan.Name = "BacOpeEmp" Or pan.Name = "BacOpeBco" Or pan.Name = "BacOpeArb" Or pan.Name = "BacImpresiones") Then
        MsgBox "Solo Puede Ocupar SALIR", 16, TITSISTEMA
    End If
    pan.Toolbar1.Buttons(3).Tag = "n"
    If pan.LinkTopic = "MDIForm" Then
        Exit Function
    End If
    
    For i = 0 To pan.Controls.Count - 1
        If TypeOf pan.Controls(i) Is Label Or pan.Controls(i).Name = "CmdSalir" Or TypeOf pan.Controls(i) Is SSFrame Or (pan.Controls(i).Name = "CmdLimpiar" And (pan.Name = "BacOpeEmp" Or pan.Name = "BacOpeBco" Or pan.Name = "BacOpeArb")) Then
            pan.Controls(i).Enabled = True
        Else
               If Not TypeOf pan.Controls(i) Is ImageList Then
                    pan.Controls(i).Enabled = False
               End If
               
               If TypeOf pan.Controls(i) Is Toolbar Then
                   For u = 1 To pan.Controls(i).Buttons.Count
                     pan.Controls(i).Buttons(u).Enabled = False
                   Next u
               End If
        End If
    Next i

End Function

Public Function ChkPrgF(Lugar As Integer) As Boolean
Dim Impre$
    ChkPrgF = False
 
    Select Case Lugar
    Case 1 To 6, 1001, 1002, 112
        sql = "sp_CargaParametros" ' + "ME"  '-- PENDIENTE cambiar por gsEntidad
        Envia = Array("ME")
    Case 5107:
        'Sql = "sp_Bapcl "
    
    Case 5108:
        'Sql = "sp_bceng  '" & gsBAC_User & "' "
    
    Case 6002:
        'Impre = "N"
        'Sql = "sp_creatransferencia '" & Impre & "'"
    
    Case 6006:
        'Impre = "N"
        'Sql = "sp_creapapeleta '" & Impre & "'"
    
    Case 980, 981
        'Sql = "sp_BOperaEmpBco  '" & 0 & Muestra & "'," & 0
        'Envia = Array(CDbl(0), "ME")
    Case 982
        'Sql = "sp_barbit " & 0
    
    Case 983
        'Sql = "sp_barbme " & 0
    
    Case 999:
        'Sql = "sp_boperacarriendo " & 0 & "," & 0
    
    End Select

    If Not Bac_Sql_Execute(sql, Envia) Then
        Exit Function
    End If
  
    Select Case Lugar
    Case 1 To 6, 1001, 1002
        If Not Bac_SQL_Fetch(Datos()) Then
            MsgBox "Problemas con la Base de Datos", 16, TITSISTEMA
            Exit Function
        Else
            Select Case Lugar
              Case 1001, 1002: Lugar = 1
            End Select
            If Mid(Datos(11), Lugar, 1) <> "1" Then Exit Function
        End If
  
    Case 5106, 6002, 6003, 6009, 980 To 999, 6006   '--- Operaciones del día
        If Bac_SQL_Fetch(Datos()) Then
            MsgBox "No Hay Datos para Procesar", 16, TITSISTEMA
            Exit Function
        End If
   
    Case 5107:
        If Bac_SQL_Fetch(Datos()) Then
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


   
   BacAbrirBaseDatosMDB = False

   '---- MDB
''''''''   On Error GoTo BacErrorHandler
''''''''   Set WS = DBEngine.Workspaces(0)
''''''''   Set DB = WS.OpenDatabase(gsMDB_Path & gsMDB_Database, False, False)
''''''''
   BacAbrirBaseDatosMDB = True

   Exit Function
    
BacErrorHandler:
    
   BacLogFile "AbrirBaseDatosMDB " & Err.Description$
   
   MsgBox "No se Encuentra la BD en Access ", 16, TITSISTEMA
   
   'If BacErrorHandlerMDB(Err) = True Then
   '   Resume

   'End If

   Exit Function


End Function

Function BacFechaEnTexto(ByVal dFecha$)
    
    'OBS: dFecha$ en Formato DD/MM/AAAA
    
    Dim sFecha$
    
    sFecha$ = Mid(dFecha$, 1, 2) & " De "

    Select Case Val(Mid(dFecha$, 4, 2))
    
        Case 1:  sFecha$ = sFecha$ & "Enero"
        Case 2:  sFecha$ = sFecha$ & "Febrero"
        Case 3:  sFecha$ = sFecha$ & "Marzo"
        Case 4:  sFecha$ = sFecha$ & "Abril"
        Case 5:  sFecha$ = sFecha$ & "Mayo"
        Case 6:  sFecha$ = sFecha$ & "Junio"
        Case 7:  sFecha$ = sFecha$ & "Julio"
        Case 8:  sFecha$ = sFecha$ & "Agosto"
        Case 9:  sFecha$ = sFecha$ & "Septiembre"
        Case 10: sFecha$ = sFecha$ & "Octubre"
        Case 11: sFecha$ = sFecha$ & "Noviembre"
        Case 12: sFecha$ = sFecha$ & "Diciembre"
    
    End Select

    sFecha$ = sFecha$ & " Del " & Mid$(dFecha$, 7, 4)

    BacFechaEnTexto = sFecha$

End Function


Function BacGeneraMes(nMes As Integer, nAno As Integer, oControl)

   Dim nLin          As Integer
   Dim nDias         As Integer
   Dim nMaxDia       As Integer
   Dim dFecha        As Date
   
   dFecha = Format("01/" + Format(nMes, "00") + gsc_FechaSeparador + Format(nAno, "0000"), gsc_FechaDMA)

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

'Convierte el caracter a mayuscula y devuelve el codigo asccii
'97=a ---- 122=z
Sub BacToUCase(ByRef KeyAscii As Integer)

   If KeyAscii >= 97 Or KeyAscii <= 122 Then
      KeyAscii = Asc(UCase$(Chr$(KeyAscii)))
      
   End If
    
End Sub
Public Sub BacControlWindows(n&)

   Dim i&
   
   For i = 1 To n
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

   Dim iDir%, jDir%, kDir%, nAnt%, nAsc%, nKey%, nPsw%, cPsw$

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
   
   Dim HFile%
   HFile% = FreeFile
   
   Open "btrader.log" For Append Access Write Shared As #HFile%
   Write #HFile%, Format$(Now, gsc_FechaDMA + " hh:mm:ss") & ": " & sLogEvent$
   Close #HFile%
   
End Sub

            
'Función que quita las comas dependiendo del formato windows
'Al SqlServer no se le puede pasar un valor numérico con comas
Public Function BacStrTran(sCadena$, sFind$, sReplace$) As String
   
   Dim iPos%
   Dim iLen%
         
   If Trim$(sCadena$) = "" Then
      sCadena$ = "0"

   End If
   
   iPos% = 1
   
   iLen% = Len(sFind$)
   
   Do While True
      iPos% = InStr(1, sCadena$, sFind$)
      
      If iPos% = 0 Then
         Exit Do
         
      End If
      
      sCadena$ = Mid$(sCadena$, 1, iPos% - 1) + sReplace$ + Mid$(sCadena$, iPos% + iLen%)
   
   Loop
   
   BacStrTran = Trim$(CStr(sCadena$))
    
End Function
Public Function BacBuscaCodigo(obj As Object, codi As Integer) As Long
        
   Dim F   As Long
   Dim Max As Long
        
   BacBuscaCodigo = -1
            
   Max = obj.coleccion.Count
            
   For F = 1 To Max
      If obj.coleccion(F).Codigo = codi Then
         BacBuscaCodigo = F - 1
         Exit For
      
      End If
   
   Next F

End Function

Public Function BacBuscaGlosa(obj As Object, codi As String) As Long
   
   Dim F   As Long
   Dim Max As Long
        
   BacBuscaGlosa = -1
            
   Max = obj.coleccion.Count
      
   For F = 1 To Max
      If Trim$(obj.coleccion(F).Glosa) = Trim(codi) Then
         BacBuscaGlosa = F - 1
         Exit For
      
      End If
   
   Next F
            
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

Public Function PosGrid(Grid1, Table1 As Object)
'MsgBox table1.RowIndex

    If Grid1.Row = 0 Then
        Grid1.Row = 1
    End If

    Grid1.Row = Grid1.Row
    Grid1.Col = Grid1.Col
    Grid1.Text = Grid1.TextMatrix(Grid1.Row, Grid1.Col)
    
 End Function



Public Function BacValidaRut(Rut As String, dig As String) As Integer

   Dim i       As Integer
   Dim D       As Integer
   Dim Divi    As Long
   Dim Suma    As Long
   Dim Digito  As String
   Dim Multi   As Double

   BacValidaRut = False
    
   If Trim$(Rut) = "" Or Trim$(dig) = "" Then
      Exit Function
   
   End If
    
   Rut = Format(Rut, "00000000")
   D = 2
   For i = 8 To 1 Step -1
      Multi = Val(Mid$(Rut, i, 1)) * D
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

Public Function BacDiv(n1 As Double, n2 As Double) As Double
         
         If n2 = 0 Then
            BacDiv = 0
            
         Else
            BacDiv = n1 / n2
         
         End If
         
End Function

'Sub Main()

'   BacInicio.Show vbNormal%
'
'   BacControlWindows 3000
'
'   Unload BacInicio

'End Sub

Public Function BotonTruFal(pan As Form, Estado As Boolean)

   For i = 0 To pan.Controls.Count - 1
    'MsgBox pan.Controls(i).Name
    If pan.Controls(i).Name = "DateText1" Or pan.Controls(i).Name = "DateText2" Or pan.Controls(i).Name = "DateText3" Then
        pan.Controls(i).Enabled = False
    Else
        pan.Controls(i).Enabled = Estado
     End If
   Next i

End Function

Public Function IniProc()

'''    'aclogdig
''''    Sql = "sp_Graba_ValorInicial 'ME', '000000000'"
'''    Envia = Array("ME", "0000000000")
'''    If Bac_Sql_Execute("sp_Graba_ValorInicial", Envia) Then
'''        Exit Function
'''    End If
'''
''''    If Bac_SQL_Fetch(Datos()) = 0 Then
''''        Sql = Datos(1)
''''    Else
''''        MsgBox "Falla Recuperando Valor Inicial.", 16, "Bac-Cambio"
''''    End If
''''
End Function



Public Function BacValorDef(oControl As Object, Valor$, Lugar%, Tipo%)
Dim var1$

    For i = 0 To oControl.ListCount - 1
        oControl.ListIndex = i
        If Tipo = 1 Then
            var1 = Trim(Mid(oControl, 1, Lugar))
        Else
            var1 = Trim(oControl.ItemData(oControl.ListIndex))
        End If
        If var1 = Trim(Valor) Then
            sql = "1"
            Exit For
        End If
    Next i
    
    If sql = "1" Then
        sql = " "
        oControl.ListIndex = i - 1
        sql = "1"
        oControl.ListIndex = i - 1
        sql = " "
    End If
    
End Function

Sub LimpiarCristal()

   Dim x                      As Integer

   For x = 0 To 401
        BacControlFinanciero.CryFinanciero.StoredProcParam(x) = ""
        BacControlFinanciero.CryFinanciero.Formulas(x) = ""
   Next

End Sub



Public Function ErrorInforme(NombreReporte As String)

   MsgBox "No se ha encontrado el reporte:" & Chr(10) & NombreReporte, vbCritical, TITSISTEMA & " - Error en Reporte"

End Function

'imprime  papeletas segun numero operacion y nombre del formulario de crystal
Public Function BacImprimpapeletas(xNumoper As Long, Informe_crystal As String, Optional Entre As Long, Optional salida As Integer)

   On Error GoTo Err_Impre
  
  
    SwImprimir = 0
   Call Limpiar_Cristal
   
If salida = 0 Then
    BacControlFinanciero.CryFinanciero.Destination = crptToPrinter
    
Else
    BacControlFinanciero.CryFinanciero.Destination = crptToWindow
    
End If

'''''        If gsBac_QUEDEF <> gsBac_IMPWIN And Salida = 0 Then
'''''            Call ActArcIni(gsBac_QUEDEF)
'''''        End If
     
   BacControlFinanciero.CryFinanciero.ReportFileName = gsRPT_PathBCC & Informe_crystal
   BacControlFinanciero.CryFinanciero.Destination = IIf(salida = 0, crptToPrinter, crptToWindow)
   BacControlFinanciero.CryFinanciero.WindowTitle = TITSISTEMA & " - Papeleta de Operaciones"
   BacControlFinanciero.CryFinanciero.WindowState = crptMaximized
   
   If xNumoper = 0 Then
      BacControlFinanciero.CryFinanciero.StoredProcParam(0) = xNumoper    ''Numero_O    '
   Else
      BacControlFinanciero.CryFinanciero.StoredProcParam(0) = xNumoper
   End If
   
   BacControlFinanciero.CryFinanciero.StoredProcParam(1) = Entre
   BacControlFinanciero.CryFinanciero.Connect = swConeccionBCC
   BacControlFinanciero.CryFinanciero.Action = 1
   

     
    BacControlFinanciero.CryFinanciero.Destination = crptToPrinter
     
'''''        If gsBac_QUEDEF <> gsBac_IMPWIN And Salida = 0 Then
'''''            Call ActArcIni(gsBac_QUEDEF)
'''''        End If
     
   Exit Function

Err_Impre:

'''''   If gsBac_QUEDEF <> gsBac_IMPWIN And Salida = 0 Then
'''''      Call ActArcIni(gsBac_IMPWIN)
'''''   End If


   MsgBox "Problemas en impresión de comprobantes de operación: " & Err.Description, vbExclamation, gsBac_Version
   SwImprimir = 1
   
   Exit Function
End Function


Function ImprimirPapeletaBFW(nNumPapeleta As Long, Tipo As Integer, cMov As String) As Integer
   On Error GoTo ErrorInforme
   
   SwImprimir = 0
   Call Limpiar_Cristal
   
   If Tipo = 0 Then
      BacControlFinanciero.CryFinanciero.Destination = crptToPrinter
   Else
      BacControlFinanciero.CryFinanciero.Destination = crptToWindow
      BacControlFinanciero.CryFinanciero.WindowState = crptMaximized
   End If
  
   If cMov = OP_OPCIONES Then
      BacControlFinanciero.CryFinanciero.ReportFileName = gsRPT_PathBFW & "Bacpapeletaopciones.rpt"
      BacControlFinanciero.CryFinanciero.WindowState = crptMaximized
      BacControlFinanciero.CryFinanciero.WindowTitle = TITSISTEMA & " - Papeleta de Operaciones"
      BacControlFinanciero.CryFinanciero.StoredProcParam(0) = nNumPapeleta
      BacControlFinanciero.CryFinanciero.Connect = swConeccionBFW
      BacControlFinanciero.CryFinanciero.Action = 1
   Else
      If cMov = OP_SINTETICO Or cMov = OP_OPERHEDGE Or cMov = OP_OPERA1446 Then
         BacControlFinanciero.CryFinanciero.ReportFileName = gsRPT_PathBFW & "bacpapsintetico.rpt"
         BacControlFinanciero.CryFinanciero.WindowTitle = TITSISTEMA & " - Papeleta de Operaciones"
         BacControlFinanciero.CryFinanciero.StoredProcParam(0) = nNumPapeleta
         BacControlFinanciero.CryFinanciero.Connect = swConeccionBFW
         BacControlFinanciero.CryFinanciero.Action = 1
      ElseIf cMov = OP_FBT Then
         BacControlFinanciero.CryFinanciero.ReportFileName = gsRPT_PathBFW & "PAPELETA_FBT.rpt"
         BacControlFinanciero.CryFinanciero.WindowState = crptMaximized
         BacControlFinanciero.CryFinanciero.WindowTitle = TITSISTEMA & " - Papeleta de Operaciones"
         BacControlFinanciero.CryFinanciero.StoredProcParam(0) = nNumPapeleta
         BacControlFinanciero.CryFinanciero.StoredProcParam(1) = gsBAC_User
         BacControlFinanciero.CryFinanciero.StoredProcParam(2) = "BFW"
         BacControlFinanciero.CryFinanciero.Connect = swConeccionBFW
         BacControlFinanciero.CryFinanciero.Action = 1
      ElseIf cMov = OP_OTL Then
         BacControlFinanciero.CryFinanciero.ReportFileName = gsRPT_PathBFW & "PAPELETA_BTL.rpt"
         BacControlFinanciero.CryFinanciero.WindowState = crptMaximized
         BacControlFinanciero.CryFinanciero.WindowTitle = TITSISTEMA & " - Papeleta de Operaciones"
         BacControlFinanciero.CryFinanciero.StoredProcParam(0) = nNumPapeleta
         BacControlFinanciero.CryFinanciero.StoredProcParam(1) = gsBAC_User
         BacControlFinanciero.CryFinanciero.StoredProcParam(2) = "BFW"
         BacControlFinanciero.CryFinanciero.Connect = swConeccionBFW
         BacControlFinanciero.CryFinanciero.Action = 1
      ElseIf cMov = OP_ARBITRAJEMX$ Then
         BacControlFinanciero.CryFinanciero.ReportFileName = gsRPT_PathBFW & "PAPELETA_ARBMXCLP.rpt"
         BacControlFinanciero.CryFinanciero.WindowTitle = TITSISTEMA & " - Papeleta de Operaciones"
         BacControlFinanciero.CryFinanciero.StoredProcParam(0) = nNumPapeleta
         BacControlFinanciero.CryFinanciero.Connect = swConeccion
         BacControlFinanciero.CryFinanciero.Action = 1
      Else
         BacControlFinanciero.CryFinanciero.ReportFileName = gsRPT_PathBFW & "bacpapeleta.rpt"
         BacControlFinanciero.CryFinanciero.WindowState = crptMaximized
         BacControlFinanciero.CryFinanciero.WindowTitle = TITSISTEMA & " - Papeleta de Operaciones"
         BacControlFinanciero.CryFinanciero.StoredProcParam(0) = nNumPapeleta
         BacControlFinanciero.CryFinanciero.StoredProcParam(1) = GLB_AREA_RESPONSABLE
         BacControlFinanciero.CryFinanciero.StoredProcParam(2) = GLB_CARTERA
         BacControlFinanciero.CryFinanciero.StoredProcParam(3) = GLB_LIBRO
         BacControlFinanciero.CryFinanciero.StoredProcParam(4) = GLB_CARTERA_NORMATIVA
         BacControlFinanciero.CryFinanciero.StoredProcParam(5) = GLB_SUB_CARTERA_NORMATIVA
         BacControlFinanciero.CryFinanciero.Connect = swConeccionBFW
         BacControlFinanciero.CryFinanciero.Action = 1
      End If

    End If
   
   
Exit Function
ErrorInforme:
   
   If BacControlFinanciero.CryFinanciero.LastErrorNumber = 20507 Then
      MsgBox "Crystal Report. " & vbCrLf & vbCrLf & "Informe no encontrado... " & vbCrLf & BacControlFinanciero.CryFinanciero.ReportFileName, vbExclamation, App.Title
   End If
   
   Let SwImprimir = 1
End Function

Function ImprimePapeletaBTR(sRutCart$, sNumoper$, stipoper$, sOpT$, Optional rutcli$, Optional Correlativo$) As String

On Error GoTo ErrPrinter

    ''ImprimePapeleta = "SI"
    gsTipoPapeleta = "P"
    SwImprimir = 0
    Call Limpiar_Cristal
    '''''BacControlFinanciero.CryFinanciero.Destination = crptToWindow
    ''''' BacControlFinanciero.CryFinanciero.Destination = gsBac_Papeleta
    
   If sOpT$ = "N" Then
        BacControlFinanciero.CryFinanciero.Destination = crptToPrinter
   Else
        BacControlFinanciero.CryFinanciero.Destination = crptToWindow
   End If

    If stipoper = "CI" Then
            BacControlFinanciero.CryFinanciero.ReportFileName = gsRPT_PathBTR & "PAMDCI1.RPT"    'Hasta aqui voy
            BacControlFinanciero.CryFinanciero.WindowState = crptMaximized
            BacControlFinanciero.CryFinanciero.StoredProcParam(0) = sRutCart$
            BacControlFinanciero.CryFinanciero.StoredProcParam(1) = Trim(sNumoper$)
            BacControlFinanciero.CryFinanciero.StoredProcParam(2) = gsTipoPapeleta
            BacControlFinanciero.CryFinanciero.Formulas(0) = "Titulo ='" & "" & "'"
            BacControlFinanciero.CryFinanciero.Connect = swConeccionBTR
            BacControlFinanciero.CryFinanciero.Action = 1

    ElseIf stipoper = "CP" Then
            BacControlFinanciero.CryFinanciero.WindowState = crptMaximized
            BacControlFinanciero.CryFinanciero.ReportFileName = gsRPT_PathBTR & "PAMDCP1.RPT"
            BacControlFinanciero.CryFinanciero.StoredProcParam(0) = sRutCart$
            BacControlFinanciero.CryFinanciero.StoredProcParam(1) = Trim(sNumoper$)
            BacControlFinanciero.CryFinanciero.StoredProcParam(2) = gsTipoPapeleta
            BacControlFinanciero.CryFinanciero.Formulas(0) = "Titulo ='" & "" & "'"
            BacControlFinanciero.CryFinanciero.Connect = swConeccionBTR
            BacControlFinanciero.CryFinanciero.Action = 1

    ElseIf stipoper = "VP" Then
            BacControlFinanciero.CryFinanciero.ReportFileName = gsRPT_PathBTR & "PAMDVP1.RPT"
            BacControlFinanciero.CryFinanciero.WindowState = crptMaximized
            BacControlFinanciero.CryFinanciero.StoredProcParam(0) = sRutCart$
            BacControlFinanciero.CryFinanciero.StoredProcParam(1) = Trim(sNumoper$)
            BacControlFinanciero.CryFinanciero.StoredProcParam(2) = gsTipoPapeleta
            BacControlFinanciero.CryFinanciero.StoredProcParam(3) = stipoper
            BacControlFinanciero.CryFinanciero.Formulas(0) = "Titulo ='" & "" & "'"
            BacControlFinanciero.CryFinanciero.Connect = swConeccionBTR
            BacControlFinanciero.CryFinanciero.Action = 1

   ElseIf stipoper = "VI" Then
         If rutcli$ = "97029000" And stipoper = "IB" Then   ' banco central
            BacControlFinanciero.CryFinanciero.ReportFileName = gsRPT_PathBTR & "PAMDV2.RPT"
            BacControlFinanciero.CryFinanciero.WindowState = crptMaximized
            BacControlFinanciero.CryFinanciero.StoredProcParam(0) = rutcli$
           Else
            BacControlFinanciero.CryFinanciero.ReportFileName = gsRPT_PathBTR & "PAMDVI1.RPT"
            BacControlFinanciero.CryFinanciero.WindowState = crptMaximized
            BacControlFinanciero.CryFinanciero.StoredProcParam(0) = sRutCart$
            BacControlFinanciero.CryFinanciero.Formulas(0) = "Titulo ='" & "" & "'"
         End If
            BacControlFinanciero.CryFinanciero.StoredProcParam(1) = Trim(sNumoper$)
            BacControlFinanciero.CryFinanciero.StoredProcParam(2) = gsTipoPapeleta

            BacControlFinanciero.CryFinanciero.Connect = swConeccionBTR
            BacControlFinanciero.CryFinanciero.Action = 0

   ElseIf stipoper = "IB" Then
            BacControlFinanciero.CryFinanciero.ReportFileName = gsRPT_PathBTR & "PAINTER.RPT"
            BacControlFinanciero.CryFinanciero.WindowState = crptMaximized
            BacControlFinanciero.CryFinanciero.StoredProcParam(0) = sRutCart$
            BacControlFinanciero.CryFinanciero.StoredProcParam(1) = Trim(sNumoper$)
            BacControlFinanciero.CryFinanciero.StoredProcParam(2) = gsTipoPapeleta
            BacControlFinanciero.CryFinanciero.StoredProcParam(4) = ""
            BacControlFinanciero.CryFinanciero.StoredProcParam(5) = ""
            BacControlFinanciero.CryFinanciero.StoredProcParam(6) = ""
            BacControlFinanciero.CryFinanciero.StoredProcParam(7) = ""
            BacControlFinanciero.CryFinanciero.Formulas(0) = "Titulo = '" & "" & "'"
            BacControlFinanciero.CryFinanciero.Connect = swConeccionBTR
            BacControlFinanciero.CryFinanciero.Action = 1

   ElseIf stipoper = "RCA" Then
            BacControlFinanciero.CryFinanciero.ReportFileName = gsRPT_PathBTR & "PAMDRCA.RPT"
            BacControlFinanciero.CryFinanciero.WindowState = crptMaximized
            BacControlFinanciero.CryFinanciero.StoredProcParam(0) = gsBac_RutC
            BacControlFinanciero.CryFinanciero.StoredProcParam(1) = Trim(sNumoper$)
            BacControlFinanciero.CryFinanciero.StoredProcParam(2) = gsTipoPapeleta
            BacControlFinanciero.CryFinanciero.Connect = swConeccionBTR
            BacControlFinanciero.CryFinanciero.Action = 1

    ElseIf stipoper = "RVA" Then
            BacControlFinanciero.CryFinanciero.ReportFileName = gsRPT_PathBTR & "PAMDRVA.RPT"
            BacControlFinanciero.CryFinanciero.WindowState = crptMaximized
            BacControlFinanciero.CryFinanciero.StoredProcParam(0) = sRutCart$
            BacControlFinanciero.CryFinanciero.StoredProcParam(1) = Trim(sNumoper$)
            BacControlFinanciero.CryFinanciero.StoredProcParam(2) = gsTipoPapeleta
            BacControlFinanciero.CryFinanciero.Connect = swConeccionBTR
            BacControlFinanciero.CryFinanciero.Action = 1

    ElseIf stipoper = "ST" Then
            BacControlFinanciero.CryFinanciero.ReportFileName = gsRPT_PathBTR & "PAMDST1.RPT"
            BacControlFinanciero.CryFinanciero.WindowState = crptMaximized
            BacControlFinanciero.CryFinanciero.StoredProcParam(0) = sRutCart$
            BacControlFinanciero.CryFinanciero.StoredProcParam(1) = Trim(sNumoper$)
            BacControlFinanciero.CryFinanciero.StoredProcParam(2) = gsTipoPapeleta
            BacControlFinanciero.CryFinanciero.StoredProcParam(3) = "VP"
            BacControlFinanciero.CryFinanciero.Formulas(0) = "Titulo ='" & "" & "'"
            BacControlFinanciero.CryFinanciero.Connect = swConeccionBTR
            BacControlFinanciero.CryFinanciero.Action = 1

    ElseIf stipoper = "IC" Then
            BacControlFinanciero.CryFinanciero.ReportFileName = gsRPT_PathBTR & "PACAPTA1.RPT"
            BacControlFinanciero.CryFinanciero.WindowState = crptMaximized
            BacControlFinanciero.CryFinanciero.StoredProcParam(0) = Trim(sNumoper$)
            BacControlFinanciero.CryFinanciero.Connect = swConeccionBTR
            BacControlFinanciero.CryFinanciero.Action = 1

    ElseIf stipoper = "AC" Then
        If LlenarPACAPTAANT(sRutCart$, sNumoper$, "ANTICIPO") Then
            BacControlFinanciero.CryFinanciero.ReportFileName = gsRPT_PathBTR & "PAANTCAP.RPT"
            BacControlFinanciero.CryFinanciero.WindowState = crptMaximized
            BacControlFinanciero.CryFinanciero.Action = 1
        Else
'            ImprimePapeleta = "NO"
        End If

    ElseIf stipoper = "CPP" Then
            BacControlFinanciero.CryFinanciero.WindowState = crptMaximized
            BacControlFinanciero.CryFinanciero.ReportFileName = gsRPT_PathBTR & "PAPECPP.RPT"
            BacControlFinanciero.CryFinanciero.StoredProcParam(0) = sRutCart$
            BacControlFinanciero.CryFinanciero.StoredProcParam(1) = Trim(sNumoper$)
            BacControlFinanciero.CryFinanciero.StoredProcParam(2) = gsTipoPapeleta
            BacControlFinanciero.CryFinanciero.Formulas(0) = "Titulo ='" & "" & "'"
            BacControlFinanciero.CryFinanciero.Connect = swConeccionBTR
            BacControlFinanciero.CryFinanciero.Action = 1
            
            
    ElseIf stipoper = "FLI" Then
        BacControlFinanciero.CryFinanciero.ReportFileName = gsRPT_PathBTR & "PAMFLI.RPT"
        BacControlFinanciero.CryFinanciero.StoredProcParam(0) = sRutCart$
        BacControlFinanciero.CryFinanciero.StoredProcParam(1) = Trim(sNumoper$)
        BacControlFinanciero.CryFinanciero.StoredProcParam(2) = gsTipoPapeleta
        BacControlFinanciero.CryFinanciero.Formulas(0) = "Titulo ='" & "" & "'"
        BacControlFinanciero.CryFinanciero.Connect = swConeccionBTR
        BacControlFinanciero.CryFinanciero.Action = 1

    ElseIf stipoper = "FLIP" Then

        BacControlFinanciero.CryFinanciero.ReportFileName = gsRPT_PathBTR & "PAMFLI_PAGOS.RPT"
        BacControlFinanciero.CryFinanciero.StoredProcParam(0) = sRutCart$
        BacControlFinanciero.CryFinanciero.StoredProcParam(1) = Trim(sNumoper$)
        BacControlFinanciero.CryFinanciero.StoredProcParam(2) = gsTipoPapeleta
        BacControlFinanciero.CryFinanciero.StoredProcParam(3) = Correlativo
        BacControlFinanciero.CryFinanciero.Formulas(0) = "Titulo ='" & "" & "'"
        BacControlFinanciero.CryFinanciero.Connect = swConeccionBTR
        BacControlFinanciero.CryFinanciero.Action = 1

    End If

    BacControlFinanciero.CryFinanciero.Destination = 0
    Exit Function

ErrPrinter:

    MsgBox "Problemas en impresión de comprobantes de operación: " & Err.Description, vbExclamation, gsBac_Version
    SwImprimir = 1
    Exit Function

End Function

Function ImprimePapeletaSwap(NroOperacion, OrigenDatos, Donde, TipSwap) As Boolean

    On Error GoTo Control
    SwImprimir = 0
    Call Limpiar_Cristal
 
ImprimePapeletaSwap = False

    
    With BacControlFinanciero.CryFinanciero
    
        If Donde = "Pantalla" Then
            .Destination = crptToWindow  'Vista previa pantalla
        Else
            .Destination = crptToPrinter   'Directo a Impresora
        End If
        
        Select Case TipSwap
            
            Case 1
                .ReportFileName = gsRPT_PathPCS & "PAPELETA_SWAP.rpt"
                .WindowState = crptMaximized
                .WindowTitle = "Papeleta Swap de Tasas"
                .StoredProcParam(0) = Val(NroOperacion)
           '     .StoredProcParam(1) = GLB_LIBRO
           '     .StoredProcParam(2) = GLB_CARTERA_NORMATIVA
           '     .StoredProcParam(3) = GLB_SUB_CARTERA_NORMATIVA
           '     .StoredProcParam(4) = GLB_CARTERA
           '     .StoredProcParam(5) = GLB_AREA_RESPONSABLE
                
            Case 2
                .ReportFileName = gsRPT_PathPCS & "PAPELETA_SWAP.rpt"
                .WindowState = crptMaximized
                .WindowTitle = "Papeleta Swap de Moneda"
                .StoredProcParam(0) = Val(NroOperacion)
           '     .StoredProcParam(1) = GLB_LIBRO
           '     .StoredProcParam(2) = GLB_CARTERA_NORMATIVA
           '     .StoredProcParam(3) = GLB_SUB_CARTERA_NORMATIVA
           '     .StoredProcParam(4) = GLB_CARTERA
           '     .StoredProcParam(5) = GLB_AREA_RESPONSABLE
               
            Case 3
                .ReportFileName = gsRPT_PathPCS & "PapeletaFra.rpt"
                .WindowState = crptMaximized
                .WindowTitle = "Papeleta Forward Rate Agreements"
                .StoredProcParam(0) = NroOperacion

            Case 4
               .ReportFileName = gsRPT_PathPCS & "PAPELETA_SWAP.rpt"
               .WindowState = crptMaximized
               .WindowTitle = "Papeleta Swap Promedio Camara."
               .StoredProcParam(0) = Val(NroOperacion)
            '   .StoredProcParam(1) = GLB_LIBRO
            '    .StoredProcParam(2) = GLB_CARTERA_NORMATIVA
            '    .StoredProcParam(3) = GLB_SUB_CARTERA_NORMATIVA
            '    .StoredProcParam(4) = GLB_CARTERA
            '    .StoredProcParam(5) = GLB_AREA_RESPONSABLE
            Case Else
                MsgBox "Papeleta no definida para este producto", vbExclamation
                Exit Function
            
        End Select
        
        .Connect = swConeccionPCS
        
        .Action = 1 'Envio
        
        
        ImprimePapeletaSwap = True
    
    End With
    
    BacControlFinanciero.CryFinanciero.Destination = 0
    
    Exit Function

Control:
    
    
    MsgBox "Problemas en impresión de comprobantes de operación: " & Err.Description, vbExclamation, gsBac_Version
    SwImprimir = 1
    Exit Function
    '''''MsgBox BacControlFinanciero.CryFinanciero.LastErrorString, vbCritical, Msj

End Function

Sub Imprimir_PapeletasBonex(Tipoper As String, Numoper As Long, Destino As Integer, Mensaje As String)

On Error GoTo ErrPrinter

SwImprimir = 0
    Call Limpiar_Cristal
    
    
    If Destino = 0 Then
    
       BacControlFinanciero.CryFinanciero.Destination = crptToPrinter
    Else
    
        BacControlFinanciero.CryFinanciero.Destination = crptToWindow
    End If
       
    

    If Tipoper = "COMPRA" Then

        BacControlFinanciero.CryFinanciero.ReportFileName = gsRPT_PathBEX & "PAPELE_COMPRA.RPT"
        BacControlFinanciero.CryFinanciero.WindowState = crptMaximized
        BacControlFinanciero.CryFinanciero.WindowTitle = "COMPRA DE INSTRUMENTOS"
        BacControlFinanciero.CryFinanciero.StoredProcParam(0) = "CP"
        BacControlFinanciero.CryFinanciero.StoredProcParam(1) = Numoper
        BacControlFinanciero.CryFinanciero.StoredProcParam(2) = GLB_LIBRO
        BacControlFinanciero.CryFinanciero.StoredProcParam(3) = GLB_CARTERA_NORMATIVA
        BacControlFinanciero.CryFinanciero.StoredProcParam(4) = GLB_CARTERA
        BacControlFinanciero.CryFinanciero.Connect = swConeccionBEX
        BacControlFinanciero.CryFinanciero.Action = 1
    
    Else
        BacControlFinanciero.CryFinanciero.ReportFileName = gsRPT_PathBEX & "PAPELE_VENTA.RPT"
        BacControlFinanciero.CryFinanciero.WindowState = crptMaximized
        BacControlFinanciero.CryFinanciero.WindowTitle = "VENTA DE INSTRUMENTOS"
        BacControlFinanciero.CryFinanciero.StoredProcParam(0) = "VP"
        BacControlFinanciero.CryFinanciero.StoredProcParam(1) = CDbl(Numoper)
        BacControlFinanciero.CryFinanciero.StoredProcParam(2) = GLB_LIBRO
        BacControlFinanciero.CryFinanciero.StoredProcParam(3) = GLB_CARTERA_NORMATIVA
        BacControlFinanciero.CryFinanciero.StoredProcParam(4) = GLB_CARTERA
        BacControlFinanciero.CryFinanciero.Connect = swConeccionBEX
        BacControlFinanciero.CryFinanciero.Action = 1
    End If

    
    '''Call Limpiar_Cristal

  BacControlFinanciero.CryFinanciero.Destination = 0
  
    Exit Sub

ErrPrinter:

    MsgBox "Problemas en impresión de comprobantes de operación: " & Err.Description, vbExclamation, gsBac_Version
    SwImprimir = 1
    Exit Sub

End Sub


Function ActArcIni(cString As String) As Integer
        ActArcIni = WriteINI("windows", "device", cString, "win.ini")
End Function

Function WriteINI(cSection$, cKeyName$, cNewString$, sFilename As String) As Integer
    WriteINI = WritePrivateProfileString(cSection$, cKeyName$, cNewString$, sFilename)
End Function


Function LlenarPAMDVP(Rut$, Doc$, stipoper) As Boolean
Dim sql As String
Dim Datos()

    LlenarPAMDVP = True
    sql = "DELETE FROM PAMDVP;"
    DB.Execute sql

    sql = "SP_PAPELETAVP "
    sql = sql + Rut$ + ","
    sql = sql + Doc$ + ","
    sql = sql + gsTipoPapeleta + ","
    sql = sql + stipoper

    If Bac_Sql_Execute(sql, Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            sql = "INSERT INTO PAMDVP VALUES ( " & Chr(10)
            sql = sql + "'" + Datos(1) + "'," & Chr(10)
            sql = sql + "'" + Datos(2) + "'," & Chr(10)
            sql = sql + "'" + Datos(3) + "'," & Chr(10)
            sql = sql + "'" + Datos(4) + "'," & Chr(10)
            sql = sql + "'" + Datos(5) + "'," & Chr(10)
            sql = sql + Datos(6) + "," & Chr(10)
            sql = sql + Datos(7) + "," & Chr(10)
            sql = sql + "'" + Datos(8) + "'," & Chr(10)
            sql = sql + Datos(9) + "," & Chr(10)
            sql = sql + "'" + Datos(10) + "'," & Chr(10)
            sql = sql + Datos(11) + "," & Chr(10)
            sql = sql + Datos(12) + "," & Chr(10)
            sql = sql + Datos(13) + "," & Chr(10)
            sql = sql + "'" + Datos(14) + "'," & Chr(10)
            sql = sql + "'" + Datos(15) + "'," & Chr(10)
            sql = sql + "'" + Datos(16) + "'," & Chr(10)
            sql = sql + "'" + Datos(17) + "'," & Chr(10)
            sql = sql + "'" + Datos(18) + "'," & Chr(10)
            sql = sql + "'" + Datos(19) + "'," & Chr(10)
            sql = sql + "'" + Datos(20) + "'," & Chr(10)
            sql = sql + "'" + Datos(21) + "'," & Chr(10)
            sql = sql + "'" + Datos(22) + "'," & Chr(10)
            sql = sql + "'" + Datos(23) + "'," & Chr(10)
            sql = sql + "'" + Datos(24) + "'," & Chr(10)
            sql = sql + "'" + Datos(25) + "'," & Chr(10)
            sql = sql + "'" + Datos(26) + "'," & Chr(10)
            sql = sql + "'" + Datos(27) + "'," & Chr(10)
            sql = sql + "'" + Datos(28) + "'," & Chr(10)
            sql = sql + "'" + Datos(29) + "'," & Chr(10)
            sql = sql + "'" + Datos(30) + "'," & Chr(10)
            sql = sql + "'" + Datos(31) + "'," & Chr(10)
            sql = sql + Datos(32) + "," & Chr(10)
            sql = sql + Datos(33) + "," & Chr(10)
            sql = sql + "'" + Datos(34) + "'," & Chr(10)
            sql = sql + "'" + Datos(35) + "'," & Chr(10)
            sql = sql + Datos(36) + "," & Chr(10)
            ' el 37 no se debe ocupar
            sql = sql + Datos(38) + "," & Chr(10)
            sql = sql + Datos(39) + "," & Chr(10)
            sql = sql + Datos(40) + "," & Chr(10)
            sql = sql + Datos(41) + "," & Chr(10)
            sql = sql + Datos(42) + "," & Chr(10)
            sql = sql + "'" + Datos(43) & "'," & Chr(10)
            sql = sql + "'" + Datos(44) & "'," & Chr(10)
            sql = sql + "'" + Datos(45) & "');"
            DB.Execute sql
        Loop
    Else
        LlenarPAMDVP = False
    End If

End Function

Function LlenarPACAPTAANT(Rut$, Doc$, Estado$) As Boolean
Dim sql As String
Dim Datos()
Dim p As Boolean
Dim Estado_Operacion As String

    p = False

    LlenarPACAPTAANT = False
    
    DB.Execute "DELETE * FROM papantcapta"

    sql = "sp_papeletaantic "
    sql = sql + Doc$

    If Bac_Sql_Execute(sql, Envia) Then
        Do While Bac_SQL_Fetch(Datos())
        
            If Datos(29) = "A" Then
               Estado_Operacion = "ANULADA"
            Else
               Estado_Operacion = Estado$
            End If
            
            sql = "INSERT INTO papantcapta VALUES ( " & Chr(10)
            sql = sql & "'" & Datos(1) & "'," & Chr(10)                         '1 Fecha de Proceso
            sql = sql & "'" & Datos(2) & "'," & Chr(10)                         '2 Rut Cartera
            sql = sql & Datos(3) & "," & Chr(10)                                '3 Numero de Documento
            sql = sql & Datos(4) & "," & Chr(10)                                '4 Correlativo
            sql = sql & Datos(5) & "," & Chr(10)                                '5 Numero de Operación
            sql = sql & "'" & Datos(6) & "'," & Chr(10)                         '6 Tipo de Operación
            sql = sql & Datos(7) & "," & Chr(10)                                '7 Nominal
            sql = sql & Datos(8) & "," & Chr(10)                                '8 Valor Inicial $$
            sql = sql & Datos(9) & "," & Chr(10)                                '9 Tasa
            sql = sql & Datos(10) & "," & Chr(10)                               '10 Tasa Transacción
            sql = sql & "'" & Datos(11) & "'," & Chr(10)                        '11 Fecha Inicio
            sql = sql & "'" & Datos(12) & "'," & Chr(10)                        '12 Fecha Vencimiento
            sql = sql & Datos(13) & "," & Chr(10)                               '13 Plazo
            sql = sql & Datos(14) & "," & Chr(10)                               '14 Valor Inicio UM
            sql = sql & Datos(15) & "," & Chr(10)                               '15 Valor Final UM
            sql = sql & "'" & Datos(16) & "'," & Chr(10)                        '16 Moneda
            sql = sql & "'" & Datos(17) & "'," & Chr(10)                        '17 Forma de Pago al Inicio
            sql = sql & "'" & Datos(18) & "'," & Chr(10)                        '18 Rut Cliente
            sql = sql & "'" & Datos(20) & "'," & Chr(10)                        '19 Tipo Retiro
            sql = sql & "'" & Datos(21) & "'," & Chr(10)                        '20 Custodia
            sql = sql & "'" & Datos(22) & "'," & Chr(10)                        '21 Hora
            sql = sql & "'" & Datos(23) & "'," & Chr(10)                        '22 Usuario
            sql = sql & "'" & Datos(24) & "'," & Chr(10)                        '23 Terminal
            sql = sql & "'" & Datos(25) & "'," & Chr(10)                        '24 Tipo Deposito
            sql = sql & "'" & Datos(26) & "'," & Chr(10)                        '25 Entidad
            sql = sql & "'" & Datos(27) & "'," & Chr(10)                         '26 Cliente
            sql = sql & Datos(28) & ",'" & Estado_Operacion & "'," & Chr(10)
            sql = sql & Datos(30) & ","
            sql = sql & Datos(31) & "," & Chr(10)                        '25 Entidad
            sql = sql & Datos(32) & "," & Chr(10)
            sql = sql & Datos(33) & " );"                                                   '27 Valor Unidad Monetaria
            DB.Execute sql
            p = True
        Loop
    Else
        Exit Function
    End If
    If Not p Then
       Exit Function
    End If
     LlenarPACAPTAANT = True
End Function

Public Function DiaSemanaDos(dFecha As String, oControl As Object) As String

   Dim iDia       As Integer
   Dim sql        As String

   DiaSemanaDos = ""
   iDia = Weekday(Format(dFecha, gsc_FechaDMA))
'   MsgBox "El simbolo utilizado en el separador de miles" & vbCrLf & "y del punto decimal son iguales.", vbOKOnly + vbCritical, "Fatal ERROR"

   oControl.ForeColor = &H8000&
   oControl.Tag = "OK"

   Select Case iDia
   Case 0: DiaSemanaDos = "Error"
      oControl.ForeColor = vbBlue
      oControl.Tag = "ER"

   Case 1: DiaSemanaDos = "Domingo"
      oControl.ForeColor = vbRed
      oControl.Tag = "FE"

   Case 2: DiaSemanaDos = "Lunes"
   Case 3: DiaSemanaDos = "Martes"
   Case 4: DiaSemanaDos = "Miercoles"
   Case 5: DiaSemanaDos = "Jueves"
   Case 6: DiaSemanaDos = "Viernes"
   Case 7: DiaSemanaDos = "Sabado"
      oControl.ForeColor = vbRed
      oControl.Tag = "FE"

   End Select

   If Not BacEsHabilDos(dFecha, "") Then
      oControl.ForeColor = vbRed
      oControl.Tag = "FE"

   End If

   oControl.Caption = DiaSemanaDos

End Function

Function BacEsHabilDos(cFecha As String, plaza As String) As Boolean

   Dim objFeriado As New clsFeriado
   
   Dim iAno       As Integer
   Dim iMes       As Integer
   Dim sDia       As String
    Dim n          As Integer
   
   sDia = BacDiaSem(cFecha)
   If sDia = "Sábado" Or sDia = "Domingo" Then
      BacEsHabilDos = False
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
      BacEsHabilDos = False
   
   Else
      BacEsHabilDos = True
   
   End If

End Function




Function ImprimirPapeletaOPT(nNumPapeleta As Long, Tipo As Integer, cMov As String) As Integer
   On Error GoTo ErrorInforme
   
   Dim dFechaDesde        As Date
   Dim dFechaHasta        As Date
   
   SwImprimir = 0
   Call Limpiar_Cristal
   
   If Tipo = 0 Then
      BacControlFinanciero.CryFinanciero.Destination = crptToPrinter
   Else
      BacControlFinanciero.CryFinanciero.Destination = crptToWindow
      BacControlFinanciero.CryFinanciero.WindowState = crptMaximized
   End If
  
         BacControlFinanciero.CryFinanciero.ReportFileName = gsRPT_Path & "OPT_CaFixDesdeHastaOpt.rpt"
         BacControlFinanciero.CryFinanciero.WindowState = crptMaximized
         BacControlFinanciero.CryFinanciero.WindowTitle = TITSISTEMA & " - Papeleta de Operaciones"
         BacControlFinanciero.CryFinanciero.StoredProcParam(0) = Format("01-01-1900", "yyyy-mm-dd 00:00:00.000") 'nNumPapeleta
         BacControlFinanciero.CryFinanciero.StoredProcParam(1) = Format("01-01-2030", "yyyy-mm-dd 00:00:00.000") 'GLB_AREA_RESPONSABLE
         BacControlFinanciero.CryFinanciero.StoredProcParam(2) = nNumPapeleta
         BacControlFinanciero.CryFinanciero.StoredProcParam(3) = gsBAC_User    ' 19 Oct. 2009
         BacControlFinanciero.CryFinanciero.Connect = swConeccionBFW
         BacControlFinanciero.CryFinanciero.Action = 1
   
Exit Function
ErrorInforme:
   
   If BacControlFinanciero.CryFinanciero.LastErrorNumber = 20507 Then
      MsgBox "Crystal Report. " & vbCrLf & vbCrLf & "Informe no encontrado... " & vbCrLf & BacControlFinanciero.CryFinanciero.ReportFileName, vbExclamation, App.Title
   End If
   
   Let SwImprimir = 1
End Function


Function ImprimeInformacionLineas(rutcli$, Codigo$) As String
'PROD-10967

   On Error GoTo ErrorInforme

   SwImprimir = 0
   Call Limpiar_Cristal

      BacControlFinanciero.CryFinanciero.Destination = crptToWindow
      BacControlFinanciero.CryFinanciero.WindowState = crptMaximized

      BacControlFinanciero.CryFinanciero.ReportFileName = gsRPT_Path & "Rpt_Informe_Lineas.rpt"
      BacControlFinanciero.CryFinanciero.WindowState = crptMaximized
      BacControlFinanciero.CryFinanciero.WindowTitle = TITSISTEMA & " - Informe de Lineas"
      BacControlFinanciero.CryFinanciero.StoredProcParam(0) = Format(rutcli$, "")
      BacControlFinanciero.CryFinanciero.StoredProcParam(1) = Format(Codigo$, "")
      BacControlFinanciero.CryFinanciero.Connect = swConeccion
      BacControlFinanciero.CryFinanciero.Action = 1
      
      BacControlFinanciero.CryFinanciero.ReportFileName = gsRPT_Path & "Rpt_Informe_Lineas_Por_Plazo.rpt"
      BacControlFinanciero.CryFinanciero.WindowState = crptMaximized
      BacControlFinanciero.CryFinanciero.WindowTitle = TITSISTEMA & " - Informe de Lineas"
      BacControlFinanciero.CryFinanciero.StoredProcParam(0) = Format(rutcli$, "")
      BacControlFinanciero.CryFinanciero.StoredProcParam(1) = Format(Codigo$, "")
      BacControlFinanciero.CryFinanciero.Connect = swConeccion
      BacControlFinanciero.CryFinanciero.Action = 1

      
ErrorInforme:
   
   If BacControlFinanciero.CryFinanciero.LastErrorNumber = 20507 Then
      MsgBox "Crystal Report. " & vbCrLf & vbCrLf & "Informe no encontrado... " & vbCrLf & BacControlFinanciero.CryFinanciero.ReportFileName, vbExclamation, App.Title
   End If
   
   Let SwImprimir = 1
      

End Function
