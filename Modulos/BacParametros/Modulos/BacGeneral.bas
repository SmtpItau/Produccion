Attribute VB_Name = "BacGeneral"
Option Explicit
Public Declare Function GetDeviceCaps Lib "gdi32" (ByVal hDC As Long, ByVal nIndex As Long) As Long
Global PARAMETRO1 As Variant
Global PARAMETRO2 As Variant
Global PARAMETRO3 As Variant
Global RETORNOAYUDA As Variant
Global sFile$
Global Linea
Global aux
Global Const TITSISTEMA = "BAC-PARAMETROS"
Global Const feFecha = "yyyymmdd"

Global mon As Integer
Global mascarita As String
Global RptList_Path         As String
Global mascaraux As String
Global auxilio As Integer
Global OPTI As String
Global salir As String
Global eliminame As Integer
Global opecod
Global swa As Integer

'Formato con 4 decimales, para la configuración regional
Global Const FDecimal = "#,##0.0000"
Global Const FEntero = "#,##0"
Global Const fechaymd = "yyyymmdd"

Global FDecimales As Variant


'SQL
Global gsPARAMS_Version       As String
'Global SwConeccion  As String

'para que funcione el mdcl
Global idtipo As Integer
Global gsrut As String 'sacar
Global gsdirecc As String 'sacar
Global gsgeneric As String
Global gsciudad As String
Global gsPais As String
Global gscomuna As String
Global gsregion As String
Global gstipocliente As String
Global gsEntidad As String
Global gscalidadjuridica As String
Global gsGrupo As String
Global gsMercado As String
Global gsapoderado As String
Global gsctacte As String
Global clie As String
Global gsfono As String
Global gs1Nombre As String
Global gs2Nombre As String
Global gs1Apellido As String
Global gs2Apellido As String
Global gsCtausd As String
Global gsImplic As String
Global gsAba As String
Global gsChips As String
Global gsSwift As String
Global gsGlosa As String
Global gsCodigo As String
Global gsDigito As String
Global gsmxcontab As String
'VARIABLES DE ADMINISTRACION
Global gsUsuario As String
Global gsSistema As String
Global gsTerminal As String
Global gsNombreUs As String
Global gsUsuarioReal As String
'Variables usadas en la pantalla de Ayuda
Global gsDescripcion    As String
Global gsFax            As String
Global gsSerie          As String
Global gsNemo           As String
Global gsRedondeo       As String
Global gsValor          As String
Global gsNombre         As String
Global gsCodCli1         As Integer
Global gsCodCli         As Double
Global gsEstado         As String

Global GRABASINACOFI As Integer
'********************************



Global gsBac_PtoDec As String
Global Muestra$
Global gsGenerico          As String
Global gsBac_Tcamara As Integer
Global BacFrmIRF    As Form
'PUBLIC CONEXION CON ADDO
 Public MISQL As New BTPADODB.CADODB
'insertado 20/12/2000
'-- Insertadas Lunes 4 JUNIO 2001
'Para uso con tabla Ejecutivo y Sucursal
    Global sCodigo_Sucursal As Integer
    Global sNombre As String
    Global eCodigo As Integer
    Global eNombre As String
    Global eSucursal As Integer
    Global eMonto_Linea As Double
'--------------

Global Const GLB_CAT_CARTERA_NORMATIVA = "1111"
Global Const GLB_CAT_SUBCARTERA_NORMATIVA = "1554"
Global Const GLB_CAT_LIBRO = "1552"
Global Const GLB_CAT_CARTERA_FINANCIERA = "204"
Global Const GLB_CAT_AREA_RESPONSABLE = "1553"
Global Const GLB_CAT_VOLCKER_RULE = 206

'Colores
Global Const ColorNegro = &H0&
Global Const ColorAzul = &H800000
Global Const ColorBlanco = &H80000005
Global Const ColorVerde = &H808000
Global Const ColorGris = &HC0C0C0
Global Const ColorCeleste = &HFFFF00

'--Req.10449
Global gsBac_DIRPAE        As String




Sub PROC_LLENA_COMBOS(cProcedimiento As String, Arreglo_Parametros As Variant, Combo As Object, bTodos As Boolean, nCodigo As Integer, nDescripcion As Integer, Optional bPrimeroLista As Variant)
Dim Datos()

    Envia = Arreglo_Parametros
    
    If Not Bac_Sql_Execute(cProcedimiento, Envia) Then
        MsgBox "Problemas al Intentar llanar el combo", vbExclamation + vbOKOnly
        Exit Sub
    End If
    
    Combo.Clear
    
    If bTodos = True Then
       Combo.AddItem "TODOS" & Space(80)
    End If
    
    Do While Bac_SQL_Fetch(Datos())
        Combo.AddItem Datos(nDescripcion) & Space(80) & Datos(nCodigo)
    Loop
    
    If IsMissing(bPrimeroLista) Then
        bPrimeroLista = True
    End If
    
    If bPrimeroLista = True And Combo.Visible = True Then
       If Combo.ListCount > 0 Then
         Combo.ListIndex = 0
       End If
    End If

End Sub


Function Valida_Configuracion_Regional() As Boolean

Valida_Configuracion_Regional = False

If CStr(Format(CDate("31/12/2000"), feFecha)) <> Format("31/12/2000", feFecha) Then
   MsgBox "Debe cambiar el formato de fecha como dd/mm/aaaa antes de ejecutar el sistema.", vbCritical, TITSISTEMA
   Exit Function
End If

Valida_Configuracion_Regional = True

End Function


Public Function funcBaseMoneda(parECodMoneda As Integer) As Integer
Dim cSql As String
Dim Datos()
On Error GoTo ErrMon

    funcBaseMoneda = 0
        
'''''''''''''''''    cSql = "EXECUTE sp_findbasemoneda " & parECodMoneda
       
    Envia = Array()
    
    AddParam Envia, parECodMoneda
       
    If Bac_Sql_Execute("SP_FINDBASEMONEDA", Envia) Then
        
        Do While Bac_SQL_Fetch(Datos())
            
            funcBaseMoneda = Datos(1)
        
        Loop
    
    End If
    
    Exit Function
    
ErrMon:
    
    MsgBox "Problemas en busqueda de base de monedas: " & Err.Description & ". Comunique al Administrador. ", vbCritical, TITSISTEMA
    
    Exit Function
    
End Function
'insertado 21/12/2000

Public Function bacLeerMonedas(Optional RetornaDatos) As Boolean

    bacLeerMonedas = False
    
    bacLeerMonedas = (Bac_Sql_Execute("SP_GENERAL_LEE_MONEDA "))
    
    If Not IsMissing(RetornaDatos) Then
        
        Do While Bac_SQL_Fetch(Datos())
            
            bacLeerMonedas = True
            'RetornaDatos = Datos
        
        Loop
    
    End If
    
End Function

'insertado 20/12/2000
Public Function funcFindMonVal(comboMoneda As Object, ComboBase As Object, Tipo_Operacion As String) As Boolean
Dim cSql As String
Dim Datos()
On Error GoTo ErrMon

    funcFindMonVal = False
        
    If Trim(Tipo_Operacion) = "" Then
       
       cSql = "SP_FINDBASE"
    
    End If
    
    If Bac_Sql_Execute(cSql) Then
        
        Do While Bac_SQL_Fetch(Datos())
            
            comboMoneda.AddItem Datos(2)
            comboMoneda.ItemData(comboMoneda.NewIndex) = Datos(1)
        
          ' ComboBase.AddItem datos(3)
          ' ComboBase.ItemData(comboMoneda.NewIndex) = datos(1)
        
        Loop
    
    End If
    
    funcFindMonVal = True
    
    Exit Function
    
ErrMon:
    MsgBox "Problemas en busqueda de base de monedas: " & Err.Description & ". Comunique al Administrador. ", vbCritical, TITSISTEMA
    Exit Function
    
End Function
'insertado 20/12/2000
Public Function bacMonedaRRDA(Moneda As Variant) As String
Dim sql$, Datos()
    
    bacMonedaRRDA = "D"
    If VarType(Moneda) = vbString Then
        Moneda = Left(Moneda, 3)
    End If
    
    sql = "SELECT mnrrda"
    sql = sql & " FROM moneda "
    sql = sql & " WHERE "
    If VarType(Moneda) = vbString Then
        sql = sql & "SUBSTRING(mnsimbol,1,3) = '" & Moneda & "'"
    Else
        sql = sql & "mncodmon = " & Moneda
    End If
    If MISQL.SQL_Execute(sql) <> 0 Then
        MsgBox "Referencia US$ de  " & Moneda & " no puede ser capturada", vbInformation, TITSISTEMA
    Else
        If MISQL.SQL_Fetch(Datos()) = 0 Then
            bacMonedaRRDA = IIf(Datos(1) = "M", "M", "D")
        End If
    End If

End Function

Public Function BacControlIni() As Boolean

    BacControlIni = True

   If gsc_Parametros.findia = "0" Then
      MsgBox "Fin de día no ha sido realizado.-", 16, TITSISTEMA
      BacControlIni = False
      Exit Function

   End If

   If gsc_Parametros.iniciodia = "1" Then
      MsgBox "Inicio de día ya fue realizado.-", 16, TITSISTEMA
      BacControlIni = False
      Exit Function

   End If

End Function

Public Function TipoFormato(cCodMon As String)

    Select Case Trim(cCodMon$)
    Case "UF", "UFR"
           TipoFormato = "##,##0.0000"
           
    Case "$", "$$", "CLP"
           TipoFormato = "##,##0"
           
    Case Else
           TipoFormato = "##,##0.00"
    
    End Select

End Function

Public Sub BacSetMinBox(fForm As Form, Optional bMoveForm As Variant)
Dim nStyle As Long

   If IsMissing(bMoveForm) Then
      bMoveForm = False

   End If

   'nStyle = GetWindowLong(fForm.hWnd, GWL_STYLE)
   'nStyle = nStyle Or WS_MINIMIZEBOX
'   hForm.ClipControls = True
   'Call SetWindowLong(fForm.hWnd, GWL_STYLE, nStyle)

   If (bMoveForm = True) Then
      fForm.Move 0, 0

   End If

   fForm.Refresh

End Sub

Sub PROC_POSICIONA_TEXTO(Grilla As Control, Texto As Control)

    Texto.Top = Grilla.CellTop + Grilla.Top
    Texto.Left = Grilla.CellLeft + Grilla.Left
    Texto.Width = Grilla.CellWidth
    
    If Not TypeOf Texto Is ComboBox Then
        Texto.Height = 360
    End If

End Sub

Sub PROC_POSICIONA_TEXTO2(Grilla As Control, texto As Control)

    texto.Top = Grilla.CellTop + Grilla.Top
    texto.Left = Grilla.CellLeft + Grilla.Left
    texto.Width = Grilla.CellWidth
    
    If Not TypeOf texto Is ComboBox Then
        texto.Height = 250
    End If

End Sub

Public Sub AsignaValoresParametros()

    gsbac_fecp = Format(gsc_Parametros.fechaproc, gsc_FechaDMA)
    gsBAC_Clien = gsc_Parametros.nombre
    gsBAC_Rut = gsc_Parametros.rut
    gsBAC_ValmonUF = gsc_Parametros.valorUf
    gsBAC_DolarObs = gsc_Parametros.DolarObs

End Sub


Function bacBuscarCombo(cControl As Object, nValor As Variant) As Integer
Dim iLin    As Integer

    If VarType(nValor) = vbString Then
        nValor = Trim(nValor)
    End If

    bacBuscarCombo = -1

    For iLin = 0 To cControl.ListCount - 1
        If VarType(nValor) = vbString Then
            If Left(cControl.List(iLin), Len(nValor)) = nValor Then
                bacBuscarCombo = iLin
            End If
        ElseIf cControl.ItemData(iLin) = nValor Then
            bacBuscarCombo = iLin
        End If
        If bacBuscarCombo = iLin And iLin > -1 Then
            cControl.ListIndex = iLin
            Exit For
        End If
    Next iLin

End Function


Function bacKeyPress(ByRef KeyAscii As Integer)

   If Chr(KeyAscii) = "." Or Chr(KeyAscii) = "," Then
      KeyAscii = Asc(gsc_PuntoDecim)

   End If

End Function

Public Function bacTranMontoSql(nMonto As Variant) As String
Dim sCadena       As String
Dim iPosicion     As Integer
Dim sFormato      As String

   bacTranMontoSql = "0.0"

   sCadena = CStr(nMonto)

   iPosicion = InStr(1, sCadena, gsc_PuntoDecim)

   If iPosicion = 0 Then
      bacTranMontoSql = sCadena

   Else
      bacTranMontoSql = Mid$(sCadena, 1, iPosicion - 1) + "." + Mid$(sCadena, iPosicion + 1)

   End If

End Function

Function FUNC_FMT_DOUBLE(Tpaso As String) As Double
Dim i%

  For i% = 1 To Len(Tpaso)
    
    If Mid(Tpaso, i%, 1) = "0" Then
        
        Mid(Tpaso, i%, 1) = " "
    Else
        Exit For
    End If
    
  Next i%
  
  If Trim(Tpaso) = "" Or Trim(Tpaso) = "." Then
    FUNC_FMT_DOUBLE = 0#
  Else
    FUNC_FMT_DOUBLE = CDbl(Tpaso)
  End If
End Function


Public Function DiaSemana(dFecha As String, oControl As Object) As String

   Dim iDia       As Integer
   Dim sql        As String

   DiaSemana = ""
   iDia = Weekday(Format(dFecha, gsc_FechaDMA))
'   MsgBox "El simbolo utilizado en el separador de miles" & vbCrLf & "y del punto decimal son iguales.", vbOKOnly + vbCritical, "Fatal ERROR"

   oControl.ForeColor = &H8000&
   oControl.Tag = "OK"

   Select Case iDia
   Case 0: DiaSemana = "Error"
      oControl.ForeColor = vbBlue
      oControl.Tag = "ER"

   Case 1: DiaSemana = "Domingo"
      oControl.ForeColor = vbRed
      oControl.Tag = "FE"

   Case 2: DiaSemana = "Lunes"
   Case 3: DiaSemana = "Martes"
   Case 4: DiaSemana = "Miercoles"
   Case 5: DiaSemana = "Jueves"
   Case 6: DiaSemana = "Viernes"
   Case 7: DiaSemana = "Sabado"
      oControl.ForeColor = vbRed
      oControl.Tag = "FE"

   End Select

   If Not BacEsHabil(dFecha, "") Then
      oControl.ForeColor = vbRed
      oControl.Tag = "FE"

   End If

   oControl.Caption = DiaSemana

End Function

Public Function BacInit() As Boolean
   
   Dim sFile$
   Dim sFile1$
   Dim sSeparadorFecha$
   Dim directorio As String
   BacInit = False

   'Traer datos generales del Sistema
'   sFile$ = App.Path & "\Bac-Sistemas.ini"
   sFile$ = "Bac-Sistemas.ini"
   'sFile = "Bac-Sistem.ini"
   
   If Dir("C:\WINNT\" & sFile$) <> "" Then
      
      sFile$ = "C:\WINNT\" & sFile$
      
   ElseIf Dir("C:\WINDOWS\" & sFile$) <> "" Then
      
      sFile$ = "C:\WINDOWS\" & sFile$
      
   ElseIf Dir("C:\BTRADER\" & sFile$) <> "" Then
      
      sFile$ = "C:\BTRADER\" & sFile$
   
   ElseIf Dir("C:\" & sFile$) <> "" Then
      
      sFile$ = "C:\" & sFile$
   
   ElseIf Dir(App.Path & "\" & sFile$) <> "" Then
      
      sFile$ = App.Path & "\" & sFile$
   
   Else
      
      MsgBox "Archivo de configuraciones no existe.", vbCritical, TITSISTEMA
      End
   
   End If
   
   
   'NET y Datos Grales.
   gsBAC_User = Func_Read_INI("NET", "NET_UserName", sFile$)
   gsBAC_Term = Func_Read_INI("NET", "NET_ComputerName", sFile$)
   gsTerminal = Func_Read_INI("NET", "NET_ComputerName", sFile$)
   gsBAC_Pass$ = ""


   'Esto porque En Banco SudAmericano se Solicitaron el Mantener la Password
   'y el Login en un INI en el Servidor
   sFile1$ = Func_Read_INI("INI", "DBO_PATH", sFile$) & "DBO.INI"

   'SQL
   gsSQL_Database = Func_Read_INI("SQL", "DB_Parametros", sFile$)
   gsSQL_Server = Func_Read_INI("SQL", "Server_Name", sFile$)
   '+++cvegasan 2017.06.05 HOM Ex-Itau Se quita Bacuser
   'gsSQL_Login = Func_Read_INI("usuario", "usuario", sFile1$)
   'gsSQL_Password = Encript(Trim(Func_Read_INI("usuario", "Password", sFile1$)), False)
   '---cvegasan 2017.06.05 HOM Ex-Itau Se quita Bacuser
  ' gsSQL_Login = Func_Read_INI("SQL", "Login_Name", sFile$)
  ' gsSQL_Password = Func_Read_INI("SQL", "Password", sFile$)
   giSQL_LoginTimeOut = Val(Func_Read_INI("SQL", "Login_TimeOut", sFile$))
   giSQL_QueryTimeOut = Val(Func_Read_INI("SQL", "Query_TimeOut", sFile$))
   giSQL_ConnectionMode = Val(Func_Read_INI("SQL", "Connection_Mode", sFile$))
   gsODBC = Func_Read_INI("SQL", "ODBC_Parametros", sFile$)
   gsBac_DIRPAE = Trim(Func_Read_INI("TXT", "Dir_PAE", sFile$))  ' PRD-10449
      
   'gsSQL_Password = "bacuserx"
   'gsSQL_Server = "tecno001"
   
    
    
   If gsSQL_Database = "" Or gsSQL_Server = "" Then
      MsgBox "Servidor No esta definido para conectarse con Base de Datos", vbCritical, TITSISTEMA
      Exit Function
   '+++cvegasan 2017.06.05 HOM Ex-Itau Se quita Bacuser
   'ElseIf gsSQL_Login = "" Or gsSQL_Password = "" Then
   '   MsgBox "Usuario No esta definido para conectarse con Base de Datos", vbCritical, TITSISTEMA
   '   Exit Function
   '---cvegasan 2017.06.05 HOM Ex-Itau Se quita Bacuser
   ElseIf giSQL_LoginTimeOut <= 0 Or giSQL_QueryTimeOut <= 0 Then
      MsgBox "Tiempos de Respuesta No son los apropiados para conectarse con Base de Datos", vbCritical, TITSISTEMA
      Exit Function
      
   End If
   
   '---- Coneccion ODBC
   If gsODBC = "" Then
      MsgBox "Coneccion ODBC No esta definida para conectarse con Base de Datos", vbCritical, TITSISTEMA
      Exit Function
   End If
   
                     
   'RPT
   gsRPT_Path = Func_Read_INI("REPORTES", "RPT_Parametros", sFile$)
   
   'Separadores
   sSeparadorFecha$ = Mid$(Date, 2, 2)
   
   If InStr("0123456789 ", Left(sSeparadorFecha$, 1)) = 0 Then
      sSeparadorFecha$ = Left(sSeparadorFecha$, 1)
   Else
      sSeparadorFecha$ = Right(sSeparadorFecha$, 1)
   End If
   gsc_PuntoDecim = Mid$(Format(0#, "0.0"), 2, 1)
   
   If gsc_PuntoDecim = "." Then
       gsc_SeparadorMiles = ","
       
   Else
       gsc_SeparadorMiles = "."

   End If
     
   gsc_FechaDMA = "DD" + sSeparadorFecha$ + "MM" + sSeparadorFecha$ + "YYYY"
   gsc_FechaMDA = "MM" + sSeparadorFecha$ + "DD" + sSeparadorFecha$ + "YYYY"
   gsc_FechaAMD = "YYYY" + sSeparadorFecha$ + "MM" + sSeparadorFecha$ + "DD"
   gsc_FechaSeparador = sSeparadorFecha$

   If gsc_PuntoDecim = gsc_SeparadorMiles Then
      MsgBox "El simbolo utilizado en el separador de miles" & vbCrLf & "y del punto decimal son iguales.", vbCritical, TITSISTEMA
      Exit Function

   End If

   If sSeparadorFecha$ <> "/" And sSeparadorFecha$ <> "-" Then
      MsgBox "El simbolo utilizado en la separación " & vbCrLf & "de la fecha no corresponde.", vbCritical, TITSISTEMA
      Exit Function
   End If
   
   
    'PARAMS
   gsPARAMS_Version = Func_Read_INI("PARAMS", "VERSION", sFile$)
   If gsPARAMS_Version = "" Then
      MsgBox "Versión de Sistema No esta definida en ", vbCritical, sFile$
      Exit Function
   End If
   
   Msj = gsPARAMS_Version
   
   '---- Define Coneccion
   '+++cvegasan 2017.06.05 HOM Ex-Itau Se quita Bacuser
   'SwConeccion = "DSN=" & gsODBC
   'SwConeccion = SwConeccion & ";UID=" & gsSQL_Login
   'SwConeccion = SwConeccion & ";PWD=" & gsSQL_Password
   'SwConeccion = SwConeccion & ";DSQ=" & gsSQL_Database
   SwConeccion = "DSN=" & gsODBC
   SwConeccion = SwConeccion & ";TRUSTED_CONNECTION = yes"
   SwConeccion = SwConeccion & ";DSQ=" & gsSQL_Database
   '---cvegasan 2017.06.05 HOM Ex-Itau Se quita Bacuser
   
   Dim Attribs As String
   Attribs = "Description=BACTRADERFULL" & Chr$(13)
   Attribs = Attribs & "Server=" & gsSQL_Server & Chr$(13)
   '+++cvegasan 2017.06.05 HOM Ex-Itau
    If giSQL_ConnectionMode = 3 Then
    Attribs = Attribs & "Trusted_Connection=yes" & Chr$(13)
    End If
    '---cvegasan 2017.06.05 HOM Ex-Itau
   Attribs = Attribs & "Database=" & gsSQL_Database
   DBEngine.RegisterDatabase gsODBC, "SQL Server", True, Attribs

   BacInit = True
   
End Function

Sub BacSetBotones(iOpc%, iModo%)

'    Select Case iOpc%
'
'        Case iGlbBotonGrabar%
'                BacFwd.CmdGrabar.Enabled = iModo%
'                BacFwd.CmdGrabar.Picture = BacTrd.ImgGrabar(IIf(iModo%, 1, 0)).Picture
'
'        Case iGlbBotonMValr%
'                BacFwd.CmdMValr.Enabled = iModo%
'                BacFwd.CmdMValr.Picture = BacTrd.ImgMValr(IIf(iModo%, 1, 0)).Picture
'
'        Case iGlbBotonNETrader%
'                BacFwd.CmdNet.Enabled = iModo%
'
'        Case iGlbBotonSelec%
'                BacFwd.CmdSelec.Enabled = iModo%
'                BacFwd.CmdSelec.Picture = BacTrd.ImgSelec(IIf(iModo%, 1, 0)).Picture
'
'        Case iGlbBotonAsign%
'                BacFwd.CmdAsign.Enabled = iModo%
'                BacFwd.CmdAsign.Picture = BacTrd.ImgAsign(IIf(iModo%, 1, 0)).Picture
'
'
'
'    End Select
    
End Sub

'Public Function BuscaListIndex(COMBO As Object, BUSCA As String) As Integer
'
' '-'
' Dim Lin As Integer
'
' BuscaListIndex = 0              ' Nada en el ComboList
'
'  With COMBO
'
'    If .ListCount <> 0 Then       ' = 0 Nada
'
'        For Lin = 0 To .ListCount - 1
'            .ListIndex = Lin
'            If UCase(Trim$(.List(.ListIndex))) = UCase(Trim$(BUSCA)) Then
'                     BuscaListIndex = Lin
'                     Exit Function
'            End If
'        Next Lin
'
'    End If
'
' End With
      
'End Function
Public Function ControlRUT(tex As String, tex1 As String)
   
   Dim Valida As Integer
   Dim idRut As String
   Dim IdDig As String

   idRut = tex
   IdDig = tex1

   Valida = True

   If Trim$(idRut$) = "" Or Trim$(IdDig$) = "" Or (Trim$(idRut$) = "0" And Trim$(IdDig$) = "0") Then
      Valida = False
   
   End If
    
   If BacValidaRut(tex, tex1) = False Then
      Valida = False
   
   End If

   ControlRUT = Valida

End Function

Public Sub DetectarResolucion(MDIFormx As Object, Formx As Object)
   Dim Ancho As Integer, alto As Integer
   Ancho = GetDeviceCaps(Formx.hDC, 8)
   alto = GetDeviceCaps(Formx.hDC, 10)
   If Ancho <> 800 And alto <> 600 Then
      MDIFormx.Picture = Formx.Picture
      Unload Formx
   End If
End Sub

Public Function Bac_Check_Valor(vCadena As Variant, vValorDefecto As Variant, sTipo As String) As Variant

    If sTipo = "N" Then
        Bac_Check_Valor = vValorDefecto
        If vCadena <> "" Then
            Bac_Check_Valor = CDbl(vCadena)
            
        End If
    
    End If

End Function


Sub PROC_LLENA_COMBOS2(Combo As Object, opcion As Integer, bTodos As Boolean, cParametro1 As String, Optional cParametro2 As String, Optional cParametro3 As String, Optional cParametro4 As String, Optional cParametro5 As String)

    Dim Datos()

    Envia = Array()
    AddParam Envia, opcion
    AddParam Envia, IIf(Trim(cParametro1) <> "", Trim(cParametro1), "")
    AddParam Envia, IIf(Trim(cParametro2) <> "", Trim(cParametro2), "")
    AddParam Envia, IIf(Trim(cParametro3) <> "", Trim(cParametro3), "")
    AddParam Envia, IIf(Trim(cParametro4) <> "", Trim(cParametro4), "")
    AddParam Envia, IIf(Trim(cParametro5) <> "", Trim(cParametro5), "")
        
    If Not Bac_Sql_Execute("SP_CON_INFO_COMBO", Envia) Then
        MsgBox "Problemas al Intentar llanar el combo", vbCritical
        Exit Sub
    End If
    
    Combo.Clear
    
    If bTodos = True Then
        Combo.AddItem "< TODOS [AS] >" & Space(110)
    End If
    
    Do While Bac_SQL_Fetch(Datos())
            Combo.AddItem Datos(6) & Space(110) & Datos(2)
    Loop
    
    If Combo.ListCount > 0 Then
        Combo.ListIndex = 0
    End If

End Sub

Public Function VerififcaSistemaOpciones() As Boolean
Dim Datos()

   VerififcaSistemaOpciones = False
   
   Envia = Array()
   AddParam Envia, "S"
   If Not Bac_Sql_Execute("SP_VERIFICA_LNKSERVER_OPC", Envia) Then
        Exit Function
   End If
        
   Do While Bac_SQL_Fetch(Datos())
      If CDbl(Datos(1)) < 0 Then
          Exit Function
      End If
   Loop
   
   VerififcaSistemaOpciones = True

End Function


