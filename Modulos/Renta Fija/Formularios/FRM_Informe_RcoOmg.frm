VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form FRM_Informe_RcoOmg 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Informes Excel Interfaces RCO y OGM"
   ClientHeight    =   5610
   ClientLeft      =   45
   ClientTop       =   375
   ClientWidth     =   6660
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5610
   ScaleWidth      =   6660
   ShowInTaskbar   =   0   'False
   Begin VB.Frame Frame1 
      Height          =   5655
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   6765
      Begin BACControles.TXTFecha DTP_FechaConsulta 
         Height          =   375
         Left            =   1200
         TabIndex        =   4
         Top             =   720
         Width           =   1815
         _ExtentX        =   3201
         _ExtentY        =   661
         Enabled         =   -1  'True
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "16-11-2015"
      End
      Begin MSFlexGridLib.MSFlexGrid Grid 
         Height          =   4095
         Left            =   120
         TabIndex        =   2
         Top             =   1320
         Width           =   6495
         _ExtentX        =   11456
         _ExtentY        =   7223
         _Version        =   393216
      End
      Begin MSComctlLib.Toolbar Toolbar 
         Height          =   555
         Left            =   0
         TabIndex        =   1
         Top             =   0
         Width           =   6690
         _ExtentX        =   11800
         _ExtentY        =   979
         ButtonWidth     =   847
         ButtonHeight    =   820
         AllowCustomize  =   0   'False
         Wrappable       =   0   'False
         Appearance      =   1
         ImageList       =   "ImageList"
         _Version        =   393216
         BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
            NumButtons      =   2
            BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Object.ToolTipText     =   "Genera Excel"
               ImageIndex      =   6
            EndProperty
            BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Object.ToolTipText     =   "Salir"
               ImageIndex      =   14
            EndProperty
         EndProperty
         BorderStyle     =   1
      End
      Begin MSComctlLib.ImageList ImageList 
         Left            =   4080
         Top             =   480
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   25
         ImageHeight     =   25
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   15
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_Informe_RcoOmg.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_Informe_RcoOmg.frx":0452
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_Informe_RcoOmg.frx":132C
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_Informe_RcoOmg.frx":2206
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_Informe_RcoOmg.frx":30E0
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_Informe_RcoOmg.frx":3FBA
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_Informe_RcoOmg.frx":4E94
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_Informe_RcoOmg.frx":51AE
               Key             =   ""
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_Informe_RcoOmg.frx":54C8
               Key             =   ""
            EndProperty
            BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_Informe_RcoOmg.frx":591A
               Key             =   ""
            EndProperty
            BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_Informe_RcoOmg.frx":5C34
               Key             =   ""
            EndProperty
            BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_Informe_RcoOmg.frx":6086
               Key             =   ""
            EndProperty
            BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_Informe_RcoOmg.frx":63A0
               Key             =   ""
            EndProperty
            BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_Informe_RcoOmg.frx":66BA
               Key             =   ""
            EndProperty
            BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_Informe_RcoOmg.frx":69D4
               Key             =   ""
            EndProperty
         EndProperty
      End
      Begin VB.Label Lbl_Fecha 
         Caption         =   "Fecha :"
         ForeColor       =   &H00FF0000&
         Height          =   255
         Left            =   120
         TabIndex        =   3
         Top             =   840
         Width           =   975
      End
   End
End
Attribute VB_Name = "FRM_Informe_RcoOmg"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

'----------------------------------------------------------------------------------------
' API DE CARPETA
'----------------------------------------------------------------------------------------
      Private Const BIF_RETURNONLYFSDIRS = 1
      Private Const BIF_DONTGOBELOWDOMAIN = 2
      Private Const MAX_PATH = 260

      Private Declare Function SHBrowseForFolder Lib "shell32" _
                                        (lpbi As BrowseInfo) As Long

      Private Declare Function SHGetPathFromIDList Lib "shell32" _
                                        (ByVal pidList As Long, _
                                        ByVal lpBuffer As String) As Long

      Private Declare Function lstrcat Lib "kernel32" Alias "lstrcatA" _
                                        (ByVal lpString1 As String, ByVal _
                                        lpString2 As String) As Long

      Private Type BrowseInfo
         hWndOwner      As Long
         pIDLRoot       As Long
         pszDisplayName As Long
         lpszTitle      As Long
         ulFlags        As Long
         lpfnCallback   As Long
         lParam         As Long
         iImage         As Long
      End Type
      
      
'----------------------------------------------------------------------------------------
' API DE CARPETA
'----------------------------------------------------------------------------------------
    Private Const INVALID_HANDLE_VALUE = -1

    Private Type FILETIME
        dwLowDateTime As Long
        dwHighDateTime As Long
    End Type

    Private Type WIN32_FIND_DATA
        dwFileAttributes As Long
        ftCreationTime As FILETIME
        ftLastAccessTime As FILETIME
        ftLastWriteTime As FILETIME
        nFileSizeHigh As Long
        nFileSizeLow As Long
        dwReserved0 As Long
        dwReserved1 As Long
        cFileName As String * MAX_PATH
        cAlternate As String * 14
        End Type

    Private Declare Function FindFirstFile Lib "kernel32" _
    Alias "FindFirstFileA" _
    (ByVal lpFileName As String, _
    lpFindFileData As WIN32_FIND_DATA) As Long

    Private Declare Function FindClose Lib "kernel32" _
    (ByVal hFindFile As Long) As Long
'----------------------------------------------------------------------------------------
' EXISTE ARCHIVOS
'----------------------------------------------------------------------------------------
Public Function FileExists(sSource As String) As Boolean


   Dim WFD As WIN32_FIND_DATA
   Dim hFile As Long
   
   hFile = FindFirstFile(sSource, WFD)
   FileExists = hFile <> INVALID_HANDLE_VALUE
   
   Call FindClose(hFile)

End Function

'----------------------------------------------------------------------------------------
' MARCAR O DESMARCAR INTERFACES
'----------------------------------------------------------------------------------------
Private Sub CHK_Marcar_Click()



    '-----------------------------------------------------------------------
    ' DECLARACION DE VARIABLES
    '-----------------------------------------------------------------------
    Dim Contador As Integer
    Dim Cantidad As Integer
    
    
    
    
    Cantidad = CHK_Informe.Count - 1
    


    '-----------------------------------------------------------------------
    ' MARCAR INTERFACES
    '-----------------------------------------------------------------------
    If (CHK_Marcar.Value = 1) Then
        
        CHK_Marcar.Caption = "Des-Marcar Todos"
        
        Contador = 0
        While Contador <= Cantidad
        
             CHK_Informe(Contador).Value = 1
             Contador = Contador + 1
             
        Wend
        
        
    Else
    
    
        CHK_Marcar.Caption = "Marcar Todos"
        
        Contador = 0
        While Contador <= Cantidad
        
             CHK_Informe(Contador).Value = 0
             Contador = Contador + 1
             
        Wend
    
        
    
    End If
    
    
End Sub

'----------------------------------------------------------------------------------------
' DIRECTORIO
'----------------------------------------------------------------------------------------
'Private Sub CMDchangeDirectory_Click()


'         Dim lpIDList As Long
'         Dim sBuffer As String
'         Dim szTitle As String
'         Dim tBrowseInfo As BrowseInfo

'         szTitle = "This is the title"
'         With tBrowseInfo
'            .hWndOwner = Me.Hwnd
'            .lpszTitle = lstrcat(szTitle, "")
'            .ulFlags = BIF_RETURNONLYFSDIRS + BIF_DONTGOBELOWDOMAIN
'         End With

'         lpIDList = SHBrowseForFolder(tBrowseInfo)

'        If (lpIDList) Then
'            sBuffer = Space(MAX_PATH)
'            SHGetPathFromIDList lpIDList, sBuffer
'            sBuffer = Left(sBuffer, InStr(sBuffer, vbNullChar) - 1)
'            Let LBLRutaAcceso.Caption = sBuffer
'         End If
         
   
   
   
'End Sub

'----------------------------------------------------------------------------------------
' AL CARGAR FORMULARIO
'----------------------------------------------------------------------------------------
Private Sub Form_Load()


    '-----------------------------------------------------------------------
    ' DECLARACION DE VARIABLES
    '-----------------------------------------------------------------------
     Dim Fecha As Date


    '-----------------------------------------------------------------------
    ' LLENAR FECHA DE PROCESO COMO REFERENCIA
    '-----------------------------------------------------------------------
      Fecha = FechaProceso()
      DTP_FechaConsulta.Text = Format(Fecha, "DD/MM/YYYY")
      

     
     
     
    

    Call CargarGrilla



End Sub

'----------------------------------------------------------------------------------------
' CARGAR GRILLA
'----------------------------------------------------------------------------------------
Private Sub CargarGrilla()


    '-----------------------------------------------------------------------
    ' CAMPOS DE GRILLA
    '-----------------------------------------------------------------------
      Grid.cols = 3
      Grid.TextMatrix(0, 0) = "M"
      Grid.TextMatrix(0, 1) = "ID"
      Grid.TextMatrix(0, 2) = "Interface"


      Let Grid.ColWidth(0) = 300
      Let Grid.ColWidth(1) = 0
      Let Grid.ColWidth(2) = 6000

    '-----------------------------------------------------------------------
    ' CARGAR REGISTROS DESDE SP
    '-----------------------------------------------------------------------
     Dim Datos()
   
     If Not Bac_Sql_Execute("BacParamSuda.dbo.SP_LEER_INTERFACES_MODULO_CONFIGURACION") Then
        Call MsgBox("Error de Lectura." & vbCrLf & vbCrLf & "Se ha generado un error en la lectura de productos.", vbExclamation, App.Title)
        Exit Sub
     End If
     Let Grid.Rows = 1
     
     Do While Bac_SQL_Fetch(Datos())
        Let Grid.Rows = Grid.Rows + 1
        
        Let Grid.TextMatrix(Grid.Rows - 1, 1) = Datos(1) '--> ID
        Let Grid.TextMatrix(Grid.Rows - 1, 2) = Datos(2) '--> INTERFACES
        
     Loop



End Sub



Private Sub Grid_Click()

   Grid.Col = 0
   
   If Grid.Text <> "X" Then
      Grid.Text = "X"

   Else
      Grid.Text = ""

   End If
   
   

End Sub

'----------------------------------------------------------------------------------------
' TOOLBAR
'----------------------------------------------------------------------------------------
Private Sub Toolbar_ButtonClick(ByVal Button As MSComctlLib.Button)

   Select Case Button.Index
      Case 1
         Call GeneraInterfazExcel
      Case 2
         Call Unload(Me)
   End Select
   
End Sub
Private Function RetornaRutaSistema(Mensaje As String) As String


         Dim lpIDList As Long
         Dim sBuffer As String
         Dim szTitle As String
         Dim tBrowseInfo As BrowseInfo

         szTitle = Mensaje
         With tBrowseInfo
            .hWndOwner = Me.Hwnd
            .lpszTitle = lstrcat(szTitle, "")
            .ulFlags = BIF_RETURNONLYFSDIRS + BIF_DONTGOBELOWDOMAIN
         End With

         lpIDList = SHBrowseForFolder(tBrowseInfo)

         If (lpIDList) Then
            sBuffer = Space(MAX_PATH)
            SHGetPathFromIDList lpIDList, sBuffer
            sBuffer = Left(sBuffer, InStr(sBuffer, vbNullChar) - 1)
            Let RetornaRutaSistema = sBuffer
         End If
         
         
         
         

End Function



'----------------------------------------------------------------------------------------
' RUTAS DE ARCHIVOS EXCEL POR DEFECTO
'----------------------------------------------------------------------------------------
Private Function RutaInterfaz(Interfaz As String) As String

      
    Dim SqlDatos()
      
    '-----------------------------------------------------------------------
    ' SABER RUTA EXCEL DE LA GENERACION
    '-----------------------------------------------------------------------
     Envia = Array()
     AddParam Envia, Interfaz
     AddParam Envia, "BTR"
     AddParam Envia, "ARCHIVO"
     If Not Bac_Sql_Execute("BacParamSuda.dbo.SP_LEER_INTERFACES_MODULO_CONFIGURA", Envia) Then
    
       Let RutaInterfaz = ""
       
    End If
    
    
    Do While Bac_SQL_Fetch(SqlDatos())
    
        '----------------------------------------------------
        ' CODIGO 6 DE INTERFAZ PERTENECE A RUTA DE ARCHIVO
        ' EXCEL
        '----------------------------------------------------
         If (SqlDatos(1) = 6) Then
            RutaInterfaz = UCase(Trim(SqlDatos(3)))
         End If
                  
    Loop
    
    

End Function


'----------------------------------------------------------------------------------------
' GENERA EXCEL POR INTERFACES
'----------------------------------------------------------------------------------------
Private Sub GeneraInterfazExcel()


    '-----------------------------------------------------------------------
    ' DECLARACION DE VARIABLES
    '-----------------------------------------------------------------------
     Dim valor As Integer
     Dim Contador As Integer
     Dim Ruta As String
     Dim Valida As Boolean
     Dim FechaCalculo As Date
     Dim ExportacionExcel As Boolean
     Dim cMarca   As String
     Dim IdInterfaz As Integer
     Dim Interfaz As String
     Dim Mensaje As String
     

    
    
     
    '-----------------------------------------------------------------------
    ' VERRIFICAR SI EXISTE DIRECTORIO
    '-----------------------------------------------------------------------
     'If LBLRutaAcceso.Caption = "" Then
     '   MsgBox "Selecione Carpeta para alojar archivos", vbCritical, gsBac_Version
     '   Exit Sub
     'End If

        
     'If FileExists(LBLRutaAcceso.Caption) = False Then
     '   MsgBox "Ruta Seleccionada No Existe en su disco", vbCritical, gsBac_Version
     '   Exit Sub
     'End If


     'Let Ruta = Trim(LBLRutaAcceso.Caption)


    '-----------------------------------------------------------------------
    ' FECHA EN CALENDARIOS
    '-----------------------------------------------------------------------
    FechaCalculo = CDate(DTP_FechaConsulta.Text)



    '-----------------------------------------------------------------------
    ' CAMPOS MARCADOS CON X EN LA APLICACION
    '-----------------------------------------------------------------------
     cMarca = ""
 
     If Grid.Rows - 1 = 0 Then
      
         MsgBox ("No Existen Interfaces en Tabla"), vbOKOnly + vbExclamation
   
     Else
       Grid.Redraw = False
       With Grid
          For iLin = 1 To Grid.Rows - 1
               
               .Row = iLin
               .Col = 0:  cMarca = .Text
               .Col = 1: IdInterfaz = CInt(.Text)
               .Col = 2: Interfaz = .Text
               
                
               If cMarca = "X" Then
               
                    Select Case IdInterfaz
                      Case Is = 15
                      
                         '-------------------------------------------------
                         'GENERACION RCO
                         '-------------------------------------------------
                         Let Ruta = RutaInterfaz(Interfaz)
                            
                         If (Len(Ruta) <= 0) Then
                         
                            Let Mensaje = " La Interface " & Interfaz & " no posee ruta parametrizada ¡ favor indicar destino !"
                            Let Ruta = RetornaRutaSistema(Mensaje)
                            
                            If Not (Len(Ruta) <= 0) Then
                         ExportacionExcel = GeneraInterfazExcelRCO(Ruta, FechaCalculo)
                            End If
                            
                         Else
                           ExportacionExcel = GeneraInterfazExcelRCO(Ruta, FechaCalculo)
                         End If
                         '-------------------------------------------------
                         'FIN GENERACION RCO
                         '-------------------------------------------------
                         
                      Case Is = 16
                      
                         '-------------------------------------------------
                         'GENERACION OGM DERIVADOS
                         '-------------------------------------------------
                         Let Ruta = RutaInterfaz(Interfaz)
                            
                         If (Len(Ruta) <= 0) Then
                         
                            Let Mensaje = " La Interface " & Interfaz & " no posee ruta parametrizada ¡ favor indicar destino !"
                            Let Ruta = RetornaRutaSistema(Mensaje)
                            
                            If Not (Len(Ruta) <= 0) Then
                         ExportacionExcel = GeneraInterfazExcelOGMDerivados(Ruta, FechaCalculo)
                            End If
                            
                         Else
                           ExportacionExcel = GeneraInterfazExcelOGMDerivados(Ruta, FechaCalculo)
                         End If
                         
                         '-------------------------------------------------
                         'FIN GENERACION OGM DERIVADOS
                         '-------------------------------------------------
                      Case Is = 17
                      
                         '-------------------------------------------------
                         'GENERACION OGM INVERSIONES
                         '-------------------------------------------------
                         Let Ruta = RutaInterfaz(Interfaz)
                            
                         If (Len(Ruta) <= 0) Then
                         
                            Let Mensaje = " La Interface " & Interfaz & " no posee ruta parametrizada ¡ favor indicar destino !"
                            Let Ruta = RetornaRutaSistema(Mensaje)
                            
                            If Not (Len(Ruta) <= 0) Then
                         ExportacionExcel = GeneraInterfazExcelOGMInversiones(Ruta, FechaCalculo)
                            End If
                            
                         Else
                           ExportacionExcel = GeneraInterfazExcelOGMInversiones(Ruta, FechaCalculo)
                         End If
                         '-------------------------------------------------
                         'FIN GENERACION OGM DERIVADOS
                         '-------------------------------------------------
                    End Select
               
                    Valida = True
                    
               End If
         
          Next iLin
    
       End With
       
    Grid.Redraw = True
    End If



    '-----------------------------------------------------------------------
    ' SI ESTAN CON CHECK LOS CONTROLES
    '-----------------------------------------------------------------------
     If Valida = True Then
         MsgBox "Proceso generado", vbInformation, gsBac_Version
     End If

     If Valida = False Then
         MsgBox "Debe Seleccionar interfaces para exportar archivos excel ", vbInformation, gsBac_Version
     End If


    

End Sub


'----------------------------------------------------------------------------------------
' GENERA EXCEL POR INTERFACES
'----------------------------------------------------------------------------------------
Private Function GeneraInterfazExcelRCO(Ruta As String, Fecha As Date) As Boolean


    '-----------------------------------------------------------------------
    ' DECLARACION DE VARIABLES
    '-----------------------------------------------------------------------
      Dim oExcel As Object
      Dim oBook As Object
      Dim oSheet As Object
      Dim FileExcel As String
      Dim Mensaje As String
      Dim SqlDatos()
      Dim Fila As Integer
      Dim Columna As Integer
      
      
      
      On Error GoTo ErrorGeneraInterfazExcelRCO
      
      
      
      
      Let FileExcel = Ruta & "\" & "RCO_" & Format(Fecha, "DD_MM_YYYY") & ".xls"
      
      
      
    '-----------------------------------------------------------------------
    ' CREACION DE OBJETO EXCEL
    '-----------------------------------------------------------------------
     Set oExcel = CreateObject("Excel.Application")
     Set oBook = oExcel.Workbooks.Add



     Set oSheet = oBook.Worksheets(1)
     
          
          
 
          
          
    '-----------------------------------------------------------------------
    ' RETORNO DE REGISTROS EN MATRIZ
    '-----------------------------------------------------------------------
      Dim Cabezera()
      Dim Registros()
     
     
     
      Call ConectaDataRecordset(Cabezera, Registros, "RCO", Fecha)
     
     
    '-----------------------------------------------------------------------
    ' CABEZERA EN ARCHIVO EXCEL
    '-----------------------------------------------------------------------
     Columna = 0
     While Columna <= UBound(Cabezera)
     
           oSheet.Cells(1, Columna + 1) = Cabezera(Columna)
     
           With oSheet.Cells(1, Columna + 1) ' Celda
                .Interior.ColorIndex = 49    ' Color fondo = azul
                .Font.Size = 12              ' tamaño de letra
                .Font.bold = True            ' Fuente en negrita
                .Font.ColorIndex = 2         ' Color fuente = blanco
            End With
           
     
           Columna = Columna + 1
     Wend
     
     
    '-----------------------------------------------------------------------
    ' FILAS EN ARCHIVO EXCEL
    '-----------------------------------------------------------------------
     Columna = 0
     Filas = 0
     While Filas <= UBound(Registros, 2)
           
           Columna = 0
           While Columna <= UBound(Registros)
                oSheet.Cells(Filas + 2, Columna + 1) = Registros(Columna, Filas)
               
                Columna = Columna + 1
           Wend
           Filas = Filas + 1
           
     Wend
     

     oSheet.Cells.EntireColumn.AutoFit
   
   
   
   
   
    '-----------------------------------------------------------------------
    ' CIERRA EXCEL
    '-----------------------------------------------------------------------
     oBook.SaveAs FileExcel
     oExcel.Quit
     Set oExcel = Nothing
     Set oBook = Nothing
     Set oSheet = Nothing



     GeneraInterfazExcelRCO = True
     
     
     
Exit Function
ErrorGeneraInterfazExcelRCO:

     MsgBox err.Description, vbCritical, gsBac_Version

End Function
'----------------------------------------------------------------------------------------
' CADENA DE COENXION VIA RECORDSET
'----------------------------------------------------------------------------------------
Private Sub ConectaDataRecordset(ByRef Cabezera(), ByRef Registros(), Interfaz As String, Fecha As Date)



    '-----------------------------------------------------------------------
    ' DECLARACION DE VARIABLES
    '-----------------------------------------------------------------------
      Dim cnn As ADODB.Connection
      Dim rst As ADODB.Recordset
      Dim CadenaConexion As String
      Dim Filas As Integer
      Dim Columnas As Integer
      
      
      On Error GoTo ErrorConectaDataRecordset
      
    '-----------------------------------------------------------------------
    ' CADENA DE CONEXION
    '-----------------------------------------------------------------------
      CadenaConexion = ""
      CadenaConexion = CadenaConexion & "Provider=SQLOLEDB; "
      CadenaConexion = CadenaConexion & "Initial Catalog=" & gsSQL_Database & ";"
      CadenaConexion = CadenaConexion & "Data Source=" & gsSQL_Server$ & ";"
      CadenaConexion = CadenaConexion & "User Id=" & gsSQL_Login$ & ";"
      CadenaConexion = CadenaConexion & "Password=" & gsSQL_Password$ & ";"
      
      
      
    '-----------------------------------------------------------------------
    ' CONEXION
    '-----------------------------------------------------------------------
     Set cnn = Nothing
     Set rst = Nothing
     Set cnn = New ADODB.Connection
     Set rst = New ADODB.Recordset
    
   
     cnn.Open CadenaConexion
     
     
     
     
     
     
     
    '-----------------------------------------------------------------------
    ' OBJETO COMMAND
    '-----------------------------------------------------------------------
      Dim objCmd As ADODB.Command
      Set objCmd = New ADODB.Command
      objCmd.CommandType = adCmdStoredProc
      
      
      
      If (Interfaz = "RCO") Then
          objCmd.CommandText = "SP_FUSION_INTERFAZ_ART84"
          'objCmd.Parameters.Append objCmd.CreateParameter("@fecCont", adDate, adParamInput, 8, Fecha)
      End If
      
      If (Interfaz = "OGMDerivados") Then
          objCmd.CommandText = "SP_FUSION_INTERFAZ_LCR_Interno_Derivados"
          'objCmd.Parameters.Append objCmd.CreateParameter("@fecCont", adDate, adParamInput, 8, Fecha)
      End If
      
      
      If (Interfaz = "OGMInversiones") Then
          objCmd.CommandText = "SP_FUSION_INTERFAZ_LCR_Interno_Inversiones"
          'objCmd.Parameters.Append objCmd.CreateParameter("@fecCont", adDate, adParamInput, 8, Fecha)
      End If
      
      'MAP 2015-nov-19
      objCmd.Parameters.Append objCmd.CreateParameter("@fecCont", adDate, adParamInput, 8, Fecha)
      objCmd.Parameters.Append objCmd.CreateParameter("@Formateada", adChar, adParamInput, 1, "N")
      'MAP 2015-nov-19
      
      Set objCmd.ActiveConnection = cnn


    '-----------------------------------------------------------------------
    ' ENVIO DE PARAMETROS Y EJECUCION DE RESULTADOS
    '-----------------------------------------------------------------------
     Set rst = objCmd.Execute

     
     
    '-----------------------------------------------------------------------
    ' RECORRER RECORSET ENCABEZADO
    '-----------------------------------------------------------------------
     ReDim Preserve Cabezera(0 To rst.Fields.Count - 1)
     For i = 0 To rst.Fields.Count - 1
           Cabezera(i) = rst.Fields(i).Name
     Next
     
     
    '-----------------------------------------------------------------------
    ' RECORRER RECORSET FILAS
    '-----------------------------------------------------------------------
     Filas = 0
     Columnas = UBound(Cabezera)
     
    
          
     While Not rst.EOF
     
     
         ReDim Preserve Registros(Columnas, Filas)
         
         
         For i = 0 To rst.Fields.Count - 1
             Registros(i, Filas) = rst.Fields(i)
         Next
         
         Filas = Filas + 1
         rst.MoveNext
     Wend
    
    
    
     
     
     
     Set objCmd.ActiveConnection = Nothing
     cnn.Close
     Set cnn = Nothing
     Set rst = Nothing
     Set objCmd = Nothing
     
             
             
             
Exit Sub
ErrorConectaDataRecordset:

     MsgBox err.Description, vbCritical, gsBac_Version
  

End Sub

'----------------------------------------------------------------------------------------
' GENERA EXCEL POR INTERFACES
'----------------------------------------------------------------------------------------
Private Function GeneraInterfazExcelOGMDerivados(Ruta As String, Fecha As Date) As Boolean


    '-----------------------------------------------------------------------
    ' DECLARACION DE VARIABLES
    '-----------------------------------------------------------------------
      Dim oExcel As Object
      Dim oBook As Object
      Dim oSheet As Object
      Dim FileExcel As String
      Dim Mensaje As String
      Dim SqlDatos()
      Dim Fila As Integer
      
      
      
      On Error GoTo ErrorGeneraInterfazExcelOGMDerivados
      
      
      
      Let FileExcel = Ruta & "\" & "OGMDerivados_" & Format(Fecha, "DD_MM_YYYY") & ".xls"
      
      
      
      
      
      
    '-----------------------------------------------------------------------
    ' CREACION DE OBJETO EXCEL
    '-----------------------------------------------------------------------
     Set oExcel = CreateObject("Excel.Application")
     Set oBook = oExcel.Workbooks.Add



     Set oSheet = oBook.Worksheets(1)
     
          
          
    '-----------------------------------------------------------------------
    ' RETORNO DE REGISTROS EN MATRIZ
    '-----------------------------------------------------------------------
      Dim Cabezera()
      Dim Registros()
            
 
                    
      Call ConectaDataRecordset(Cabezera, Registros, "OGMDerivados", Fecha)
     
     
    '-----------------------------------------------------------------------
    ' CABEZERA EN ARCHIVO EXCEL
    '-----------------------------------------------------------------------
     Columna = 0
     While Columna <= UBound(Cabezera)
     
           oSheet.Cells(1, Columna + 1) = Cabezera(Columna)
     
           With oSheet.Cells(1, Columna + 1) ' Celda
                .Interior.ColorIndex = 49    ' Color fondo = azul
                .Font.Size = 12              ' tamaño de letra
                .Font.bold = True            ' Fuente en negrita
                .Font.ColorIndex = 2         ' Color fuente = blanco
            End With
     

           Columna = Columna + 1
     Wend
     
     
    '-----------------------------------------------------------------------
    ' FILAS EN ARCHIVO EXCEL
    '-----------------------------------------------------------------------
     Columna = 0
     Filas = 0
     While Filas <= UBound(Registros, 2)
     
           Columna = 0
           While Columna <= UBound(Registros)
                oSheet.Cells(Filas + 2, Columna + 1) = Registros(Columna, Filas)
     
                Columna = Columna + 1
           Wend
           Filas = Filas + 1
           
     Wend

   
     oSheet.Cells.EntireColumn.AutoFit
   
   
   
   
    '-----------------------------------------------------------------------
    ' CIERRA EXCEL
    '-----------------------------------------------------------------------
     oBook.SaveAs FileExcel
     oExcel.Quit
     Set oExcel = Nothing
     Set oBook = Nothing
     Set oSheet = Nothing



     GeneraInterfazExcelOGMDerivados = True
     
     
     
Exit Function
ErrorGeneraInterfazExcelOGMDerivados:

     MsgBox err.Description, vbCritical, gsBac_Version

End Function

'----------------------------------------------------------------------------------------
' GENERA EXCEL POR INTERFACES
'----------------------------------------------------------------------------------------
Private Function GeneraInterfazExcelOGMInversiones(Ruta As String, Fecha As Date) As Boolean


    '-----------------------------------------------------------------------
    ' DECLARACION DE VARIABLES
    '-----------------------------------------------------------------------
      Dim oExcel As Object
      Dim oBook As Object
      Dim oSheet As Object
      Dim FileExcel As String
      Dim Mensaje As String
      Dim SqlDatos()
      Dim Fila As Integer
      
      
      
      On Error GoTo ErrorGeneraInterfazExcelOGMInversiones
      
      
      
      Let FileExcel = Ruta & "\" & "OGMInversiones_" & Format(Fecha, "DD_MM_YYYY") & ".xls"
      
      
      
      
      
      
    '-----------------------------------------------------------------------
    ' CREACION DE OBJETO EXCEL
    '-----------------------------------------------------------------------
     Set oExcel = CreateObject("Excel.Application")
     Set oBook = oExcel.Workbooks.Add



     Set oSheet = oBook.Worksheets(1)
     
          
          
     '-----------------------------------------------------------------------
    ' RETORNO DE REGISTROS EN MATRIZ
    '-----------------------------------------------------------------------
      Dim Cabezera()
      Dim Registros()
            
          
          
      Call ConectaDataRecordset(Cabezera, Registros, "OGMInversiones", Fecha)
     
     
    '-----------------------------------------------------------------------
    ' CABEZERA EN ARCHIVO EXCEL
    '-----------------------------------------------------------------------
     Columna = 0
     While Columna <= UBound(Cabezera)
     
           oSheet.Cells(1, Columna + 1) = Cabezera(Columna)
           
           With oSheet.Cells(1, Columna + 1) ' Celda
                .Interior.ColorIndex = 49    ' Color fondo = azul
                .Font.Size = 12              ' tamaño de letra
                .Font.bold = True            ' Fuente en negrita
                .Font.ColorIndex = 2         ' Color fuente = blanco
            End With
     
     
           Columna = Columna + 1
     Wend
     
     
    '-----------------------------------------------------------------------
    ' FILAS EN ARCHIVO EXCEL
    '-----------------------------------------------------------------------
     Columna = 0
     Filas = 0
     While Filas <= UBound(Registros, 2)
           
           Columna = 0
           While Columna <= UBound(Registros)
                oSheet.Cells(Filas + 2, Columna + 1) = Registros(Columna, Filas)
     
                Columna = Columna + 1
           Wend
           Filas = Filas + 1
     
     Wend
     
     
     oSheet.Cells.EntireColumn.AutoFit

   
   
   
   
   
    '-----------------------------------------------------------------------
    ' CIERRA EXCEL
    '-----------------------------------------------------------------------
     oBook.SaveAs FileExcel
     oExcel.Quit
     Set oExcel = Nothing
     Set oBook = Nothing
     Set oSheet = Nothing



     GeneraInterfazExcelOGMInversiones = True
     
     
     
Exit Function
ErrorGeneraInterfazExcelOGMInversiones:

     MsgBox err.Description, vbCritical, gsBac_Version

End Function

'----------------------------------------------------------------------------------------
' FECHA DE PROCESO
'----------------------------------------------------------------------------------------
Private Function FechaProceso() As Date


    '-----------------------------------------------------------------------
    ' EXTRAER FECHA DE PROCESO DE SISTEMA
    '-----------------------------------------------------------------------
     Dim Datos()

     
     Let FechaProceso = Now
     

     If Bac_Sql_Execute("SP_LEEFECPRO") Then
        If Bac_SQL_Fetch(Datos()) Then
            Let FechaProceso = CDate(Format(CDate(Datos(1)), "DD/MM/YYYY"))
        End If
     Else
        MsgBox "No se encontro fecha de proceso en sistema", vbOKOnly + vbCritical, gsBac_Version
     End If
     
 
     


End Function





