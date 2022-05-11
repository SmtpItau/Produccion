Attribute VB_Name = "BacLib"
Global devolver     As String

'Constantes para llenar combos
Global Const GLB_CARTERA = "204"
Global Const GLB_CATEG = "245"
Global Const GLB_CARTERA_NORMATIVA = "1111"
Global Const GLB_LIBRO = "1552"
Global Const GLB_AREA_RESPONSABLE = "1553"
Global Const GLB_SUB_CARTERA_NORMATIVA = "1554"
Global Const GLB_ENLACE_CARTERA_SUBCARTERA = "1556"

Global Const GLB_ID_SISTEMA = "BEX"

Global Envia_Filtrar()  As Variant
Global bAceptar         As Boolean

'Variables utilizadas por Acceso y CambioPassword
Global Largo_Clave     As Integer
Global Tipo_Clave      As String

Public Function BacValidaRut(rut As String, dig As String) As Integer
Dim i       As Integer
Dim D       As Integer
Dim Divi    As Long
Dim Suma    As Long
Dim Digito  As String
Dim multi   As Double

    BacValidaRut = False
    
    If Trim$(rut) = "" Or Trim$(dig) = "" Then
       Exit Function
    End If
    
    rut = Format(rut, "00000000")
    D = 2
    For i = 8 To 1 Step -1
        multi = Val(Mid$(rut, i, 1)) * D
        Suma = Suma + multi
        D = D + 1
        If D = 8 Then
           D = 2
        End If
    Next i
    
    Divi = (Suma \ 11)
    multi = Divi * 11
    Digito = Trim$(Str$(11 - (Suma - multi)))
    
    If Digito = "10" Then
       Digito = "K"
    End If
    
    If Digito = "11" Then
       Digito = "0"
    End If
    
    'baccliente.txtDigito = Digito
    devolver = Digito
    
    If Trim$(UCase$(Digito)) = UCase$(Trim$(dig)) Then
       BacValidaRut = True
    End If
    
End Function

Function bacBuscarCombo(cControl As Object, nValor As Variant)

   Dim iLin    As Integer

   With cControl
      For iLin = 0 To .ListCount - 1
         If .ItemData(iLin) = nValor Then
            .ListIndex = iLin
           
            Exit For

         End If

      Next iLin

   End With

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

Public Function BacInit() As Boolean
     Dim sFile$       ', datos()
   Dim sFile1$
   Dim cDato       As String
   Dim nI          As Integer
   Dim cNewqueue   As String

   BacInit = False

   'Traer datos generales del Sistema
   sFile$ = "Bac-Sistemas.ini"
      
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

   'NET y Datos Grales.administra
   
   gsBac_User = Func_Read_INI("NET", "NET_UserName", sFile$)
   gsBac_Term = Func_Read_INI("NET", "NET_ComputerName", sFile$)
   sFile1$ = Func_Read_INI("INI", "DBO_PATH", sFile$) & "DBO.INI"
   gsBac_Pass$ = ""
   
   ' FTP
   gsNom_maq = Func_Read_INI("FTP_TRADER", "NOM_SER", sFile$)
   gsUser_maq = Func_Read_INI("FTP_TRADER", "USERNAME", sFile$)
   gsPass_maq = Func_Read_INI("FTP_TRADER", "PASSWORD", sFile$)
   gsPath_maq = Func_Read_INI("FTP_TRADER", "RUTA_ARCHIVO", sFile$)
   
    
    
    
   'SQL
   gsSQL_Database = Func_Read_INI("SQL", "DB_Invext", sFile$)
   gsSQL_Server = Func_Read_INI("SQL", "Server_Name", sFile$)
   '+++cvegasan 2017.06.05 HOM Ex-Itau Se quita Bacuser
   'gsSQL_Login = Func_Read_INI("usuario", "usuario", sFile1$)
   'gsSQL_Password = Encript((Func_Read_INI("usuario", "password", sFile1$)), False) 'Encript(Trim(Func_Read_INI("usuario", "password", sFile1$)), False)
   '---cvegasan 2017.06.05 HOM Ex-Itau Se quita Bacuser
   giSQL_LoginTimeOut = Val(Func_Read_INI("SQL", "Login_TimeOut", sFile$))
   giSQL_QueryTimeOut = Val(Func_Read_INI("SQL", "Query_TimeOut", sFile$))
   giSQL_ConnectionMode = Val(Func_Read_INI("SQL", "Connection_Mode", sFile$))
   GsODBC = Func_Read_INI("SQL", "ODBC_Invex", sFile$)
   gsSQL_Database_comun = Func_Read_INI("SQL", "DB_Parametros", sFile$)

    '+++ cvegasan 2017.08.08 Control Lineas IDD
    gsBac_Url_WebService = Func_Read_INI("WEB", "URL_WEBSERVICE", sFile$)
    gsBac_Url_WebMethod = Func_Read_INI("WEB", "URL_WEBMETHOD", sFile$)
    '--- cvegasan 2017.08.08 Control Lineas IDD


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
      
   ElseIf GsODBC = "" Then
      MsgBox "Coneccion ODBC No esta definida para conectarse con Base de Datos", vbCritical, TITSISTEMA
      Exit Function
      
   End If
   '+++cvegasan 2017.06.05 HOM Ex-Itau Se quita Bacuser
    SwConeccion = "DSN=" & GsODBC
    SwConeccion = SwConeccion & ";TRUSTED_CONNECTION = yes"
    SwConeccion = SwConeccion & ";DSQ=" & gsSQL_Database
   '---cvegasan 2017.06.05 HOM Ex-Itau Se quita Bacuser
   CONECCION = SwConeccion
   
   'gsMDB_Path = Func_Read_INI("MDB", "MDB_Path", sFile$)
   'gsMDB_Database = Func_Read_INI("MDB", "MDB_Trader", sFile$)
   
'   RptList_Path = App.Path & "\" & Func_Read_INI("REPORTES", "RPT_Trader", sFile$)
   RptList_Path = Func_Read_INI("REPORTES", "RPT_Invex", sFile$)

   gsDOC_Path = Func_Read_INI("DOCUMENTOS", "DOC_Trader", sFile$)

    gsBac_DIRINTCONTA = Trim(Func_Read_INI("INTERFAZ", "PATH_CO", sFile$))
    
    gsBac_DIRCONTA = Trim(Func_Read_INI("INTERFAZ_CONT", "PATH_INTER_CONT ", sFile$))

  ' PARAMSe
    giMonLoc = Val(Func_Read_INI("PARAMS", "MonedaLocal", sFile$))
    gsBac_Timer = Val(Func_Read_INI("PARAMS", "Tiempo_Val", sFile$)) 'Rango tiempo del Timer
    gsBac_Timer_Adicional = Val(Func_Read_INI("PARAMS", "ADICIONAL_TIMER", sFile$))
  
  ' Definición Busqueda de Archivos TXT
    gsBac_DIRIN = Trim(Func_Read_INI("INTERFAZ", "PATH_INVEX", sFile$))
    gsBac_Version = Trim(Func_Read_INI("PARAMS", "VERSION", sFile$))
    gsBac_Papeleta = Trim(Func_Read_INI("PARAM_INVEXT", "PAPELETA_OP", sFile$))
    gsBac_DIREXEL = Trim(Func_Read_INI("INTERFAZ", "PATH_EXEL", sFile$))
   gsBac_DIRIBS = Trim(Func_Read_INI("INTERFAZ_IBS", "PATH_BEX_IBS", sFile$))


  ' Impresora y Cola de Impresión a Utilizar Bac-Trader
    gsBac_IMPDEF = Func_Read_INI("PRINTERS", "PRNDEF", sFile$)
    gsBac_QUEDEF = Func_Read_INI("PRINTERS", "QUEDEF", sFile$)
    gsBac_IMPPPC = Func_Read_INI("PRINTERS", "PRNPPC", sFile$)
    gsBac_QUEPPC = Func_Read_INI("PRINTERS", "QUEPPC", sFile$)
    
  'Lineas
    gsBac_Lineas = Func_Read_INI("LINEAS", "Lineas", sFile$)
    gsBac_LineasDB = Func_Read_INI("SQL", "DB_Lineas", sFile$)
    
    gsBac_LineasDB = "BacLineas"
    gsBac_Lineas = "S"
    
  ' Impresoras o Colas de Impresión por defecto Windows
    gsBac_IMPWIN = Func_Read_INI("windows", "device", "WIN.INI")
    
   If UCase(Mid$(gsBac_QUEDEF, Len(gsBac_IMPDEF) + 2, Len(gsBac_QUEDEF))) <> UCase(Func_Read_INI("Devices", gsBac_IMPDEF, "WIN.INI")) Or gsBac_QUEDEF = "" Then
      gsBac_QUEDEF = gsBac_IMPWIN
   Else
      cNewqueue = ""
      If InStr(1, gsBac_QUEDEF, "=") > 0 Then
         For nI = 1 To Len(gsBac_QUEDEF)
            cDato = Mid(gsBac_QUEDEF, nI, 1)
            If cDato = "=" Then
               cNewqueue = cNewqueue + ","
            Else
               cNewqueue = cNewqueue + cDato
            End If
         Next nI
         gsBac_QUEDEF = cNewqueue
      End If
   End If
    
   'Impresora de Matriz de Punto que Imprime Pases por Caja de Ricardo Estay
   If InStr(1, UCase(Func_Read_INI("Devices", gsBac_IMPPPC, "WIN.INI")), "RESTAY") > 0 Then
       gsBac_QUEPPC = Func_Read_INI("PRINTERS", "QUEPPO", sFile$)
   End If
            
  ' Otros.-
   
   gbBac_Login = False
   gsBac_PtoDec = Mid(Format(0#, "0.0"), 2, 1)
   
      'Creación automatica de ODBC
   Dim Attribs As String
   Dim MyWorkspace As Workspace
   Set MyWorkspace = Workspaces(0)

   Attribs = "Description=BacTrader" & Chr$(13)
   Attribs = Attribs & "Server=" & gsSQL_Server & Chr$(13)
    '+++cvegasan 2017.06.05 HOM Ex-Itau
    If giSQL_ConnectionMode = 3 Then
    Attribs = Attribs & "Trusted_Connection=yes" & Chr$(13)
    End If
    '---cvegasan 2017.06.05 HOM Ex-Itau
   Attribs = Attribs & "Database=" & gsSQL_Database

   DBEngine.RegisterDatabase GsODBC, "SQL Server", True, Attribs

   MyWorkspace.Close

'Separadores
   sSeparadorFecha$ = Mid$(Date, 3, 1)                  'ReadINI("INTL", "SDATE", "WIN.INI")
   gsBac_PtoDec = Mid(Format(0#, "0.0"), 2, 1)



   gsc_fechadma = "DD" + sSeparadorFecha$ + "MM" + sSeparadorFecha$ + "YYYY"
   gsc_FechaMDA = "MM" + sSeparadorFecha$ + "DD" + sSeparadorFecha$ + "YYYY"
   gsc_FechaAMD = "YYYY" + sSeparadorFecha$ + "MM" + sSeparadorFecha$ + "DD"
   gsc_FechaSeparador = sSeparadorFecha$
  
   BacInit = True
 
End Function
Sub PROC_POSI_TEXTO(grilla As Control, Texto As Control)
'On Error Resume Next
    Texto.Top = grilla.CellTop + grilla.Top + 20
    Texto.Left = grilla.CellLeft + grilla.Left + 20
    Texto.Width = grilla.CellWidth - 20
End Sub

Public Function Proc_Carga_Parametros() As Boolean

    Dim datos()
    Dim cSql    As String

    Proc_Carga_Parametros = True
   
    If Bac_Sql_Execute("Sva_gen_usr_par") Then

        If Bac_SQL_Fetch(datos()) Then
        
            gsBac_Fecp = datos(1)
            gsBac_Clien = datos(2)
            gsBac_Fecx = datos(3)
            gsBac_RutC = datos(4)
            gsBac_DigC = datos(5)
            gsBac_RutComi = datos(6)
            gsBac_PrComi = datos(7)
            gsBac_Iva = datos(8)
            
            gsBac_CartRUT = datos(9)
            gsBac_CartDV = datos(10)
            gsBac_CartNOM = datos(11)
            gsBac_TCambio = datos(13)
            gsBac_Feca = datos(15)
            Ruta_Interfaces = datos(16) & "\"
           
          ' Variable que contiene el plazo minimo de pactos para papeles no BCCH
            DIAS_PACTO_PAPEL_NO_CENTRAL = datos(14)
            
            gsBac_fondos_banco_c = datos(17)
            gsBac_fondos_cta_c = datos(18)
            gsBac_fondos_pais_c = datos(19)
            gsBac_fondos_ciud_c = datos(20)
            gsBac_fondos_banco_v = datos(21)
            gsBac_fondos_cta_v = datos(22)
            gsBac_fondos_pais_v = datos(23)
            gsBac_fondos_ciud_v = datos(24)
            gsBac_DolarMesAnt = datos(25)
            
            BAC_INVERSIONES.barraestado.Panels(1).Text = Format(gsBac_Fecp, "DD/MM/YYYY")
            BAC_INVERSIONES.barraestado.Panels(2).Text = "INVERSIONES EN EL EXTERIOR"
            BAC_INVERSIONES.barraestado.Panels(3).Text = gsBac_Clien
           
       
        End If

        envia = Array()
        AddParam envia, 994
        AddParam envia, Format(gsBac_Fecp, "YYYYMMDD")
   
        If Not Bac_Sql_Execute("Sp_LeerMonedasValor", envia) Then
           Exit Function
        End If

       If Bac_SQL_Fetch(datos()) Then
            gsBac_DolarObs = datos(12)
       End If
        
    Else
       Proc_Carga_Parametros = False
       Exit Function
    
    End If
    
End Function


Function Func_Read_INI(cSection$, cKeyName$, sFilename As String) As String
   
   Dim sret As String
   sret = String(255, Chr(0))
   Func_Read_INI = Left(sret, GetPrivateProfileString(cSection$, ByVal cKeyName$, "", sret, Len(sret), sFilename))

End Function
Public Sub BacControlWindows(n%)

    Dim i%
    For i% = 1 To n%
          DoEvents
    Next
    
End Sub

