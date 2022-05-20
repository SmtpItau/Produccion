VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "Mscomctl.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "threed32.ocx"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form InterfacesTd 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Traspaso de Tablas de Desarrollo"
   ClientHeight    =   2385
   ClientLeft      =   4245
   ClientTop       =   4335
   ClientWidth     =   6075
   Icon            =   "InterfacesMovNormativos.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2385
   ScaleWidth      =   6075
   StartUpPosition =   2  'CenterScreen
   Begin Threed.SSPanel Progreso 
      Height          =   330
      Left            =   45
      TabIndex        =   8
      Top             =   1455
      Width           =   6000
      _Version        =   65536
      _ExtentX        =   10583
      _ExtentY        =   582
      _StockProps     =   15
      ForeColor       =   16777215
      BackColor       =   -2147483644
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      FloodType       =   1
      FloodColor      =   -2147483646
   End
   Begin MSFlexGridLib.MSFlexGrid Grilla 
      Height          =   2085
      Left            =   -15
      TabIndex        =   6
      Top             =   3255
      Visible         =   0   'False
      Width           =   6090
      _ExtentX        =   10742
      _ExtentY        =   3678
      _Version        =   393216
      Cols            =   11
      ForeColorFixed  =   -2147483643
      BackColorBkg    =   -2147483643
      GridColor       =   -2147483643
      GridColorFixed  =   -2147483643
      FocusRect       =   0
      AllowUserResizing=   3
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   5400
      Top             =   0
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   24
      ImageHeight     =   24
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   4
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "InterfacesMovNormativos.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "InterfacesMovNormativos.frx":11E4
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "InterfacesMovNormativos.frx":20BE
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "InterfacesMovNormativos.frx":23D8
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   6075
      _ExtentX        =   10716
      _ExtentY        =   847
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Carga"
            Object.ToolTipText     =   "Carga Interfaz"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Informe"
            Object.ToolTipText     =   "Imprimir"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Pantalla"
            Object.ToolTipText     =   "Vista Previa"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Object.ToolTipText     =   "Cerrar Ventana"
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSComctlLib.StatusBar stbProceso 
      Align           =   2  'Align Bottom
      Height          =   285
      Left            =   0
      TabIndex        =   1
      Top             =   2100
      Width           =   6075
      _ExtentX        =   10716
      _ExtentY        =   503
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   3
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Object.Width           =   4939
            MinWidth        =   4939
         EndProperty
         BeginProperty Panel2 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Alignment       =   1
            Object.Width           =   1111
            MinWidth        =   1111
         EndProperty
         BeginProperty Panel3 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Object.Width           =   4939
            MinWidth        =   4939
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.StatusBar stbNroRegistros 
      Height          =   285
      Left            =   0
      TabIndex        =   2
      Top             =   1815
      Width           =   6075
      _ExtentX        =   10716
      _ExtentY        =   503
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   2
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Object.Width           =   5394
            MinWidth        =   5394
         EndProperty
         BeginProperty Panel2 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Object.Width           =   5394
            MinWidth        =   5394
         EndProperty
      EndProperty
   End
   Begin Threed.SSFrame SSFrame1 
      Height          =   915
      Left            =   15
      TabIndex        =   3
      Top             =   495
      Width           =   6045
      _Version        =   65536
      _ExtentX        =   10663
      _ExtentY        =   1614
      _StockProps     =   14
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin Threed.SSCheck SSCheck1 
         Height          =   255
         Index           =   0
         Left            =   90
         TabIndex        =   4
         Top             =   165
         Width           =   1845
         _Version        =   65536
         _ExtentX        =   3254
         _ExtentY        =   450
         _StockProps     =   78
         Caption         =   "Series"
         ForeColor       =   -2147483641
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Enabled         =   0   'False
         Value           =   -1  'True
      End
      Begin Threed.SSCheck SSCheck1 
         Height          =   255
         Index           =   1
         Left            =   90
         TabIndex        =   5
         Top             =   420
         Width           =   2700
         _Version        =   65536
         _ExtentX        =   4762
         _ExtentY        =   450
         _StockProps     =   78
         Caption         =   "Tabla de Desarrollo"
         ForeColor       =   -2147483641
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Enabled         =   0   'False
         Value           =   -1  'True
      End
      Begin VB.Label Label2 
         Caption         =   "0 de 2"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   255
         Left            =   5310
         TabIndex        =   9
         Top             =   615
         Width           =   675
      End
   End
   Begin VB.Label Label1 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   390
      Left            =   15
      TabIndex        =   7
      Top             =   1425
      Width           =   6060
   End
End
Attribute VB_Name = "InterfacesTd"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim Rut_Emisor       As Long
Dim Serie            As String * 20
Dim Instrumento      As String * 10
Dim fecha_emision    As String * 8
Dim Tasa_Emision     As Double
Dim TERA             As Double
Dim Moneda           As String * 15
Dim Base             As Integer
Dim Cupones          As Integer
Dim Periodo          As Integer

Dim OptLocal         As String
Dim Numero_Cupon     As Integer
Dim Fecha_Vcto_Cupon As String * 8
Dim Interes          As Double
Dim Amortizacion     As Double
Dim Saldo            As Double

Private Sub Form_Activate()
   PROC_CARGA_AYUDA Me, " "
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
On Error GoTo err
Dim opcion As Integer

   opcion = 0

  
   If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) Then
     
        Select Case KeyCode

           Case vbKeyCarga:
                              opcion = 1
   
           Case vbKeyImprimir:
                              opcion = 2

            Case vbKeyVistaPrevia:
                              opcion = 3
           
            Case vbKeySalir:
                              opcion = 4
                      
      End Select

      If opcion <> 0 Then
            If Toolbar1.Buttons(opcion).Enabled Then
               Call Toolbar1_ButtonClick(Toolbar1.Buttons(opcion))
            End If
   
            KeyCode = 0
      End If
    
      
   End If
Exit Sub
err:
  Resume Next
End Sub

Private Sub Form_Load()
   OptLocal = Opt
   Me.top = 0
   Me.left = 0
   CargaGrilla

   Call LogAuditoria("07", OptLocal, Me.Caption, "", "")
End Sub

Private Sub Form_Unload(Cancel As Integer)

   If Not Crea_Temporal(gsBAC_User + "-" + CStr(gsTerminal), "N") Then
   
      MsgBox "Problemas Eliminando Temporal Para Errores", vbExclamation
      Exit Sub
   
   End If

   Call LogAuditoria("08", OptLocal, Me.Caption, "", "")
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

   Select Case UCase(Button.Key)

      Case "CARGA"
            Call Interfaz
      
      Case "INFORME"
            Call InformeInterfaz(1)
      Case "PANTALLA"
            Call InformeInterfaz(0)

      
      Case "SALIR"
            
            
            Unload Me
         
   End Select

End Sub


Private Sub Interfaz()
Dim i As Integer
Dim Mensaje As String
Dim eStilo  As String
   
   
   Call CargaGrilla
   
   Mensaje = ""
   eStilo = "64"

   If Not Crea_Temporal(gsBAC_User + "-" + CStr(gsTerminal), "S") Then
   
      MsgBox "Problemas Creando Temporal Para Errores", vbExclamation
      Exit Sub
   
   End If
   
   If SSCheck1(0).Value Then
   
      Label2.Caption = "1 de 2"
      If Not GeneraInterfazSeries Then
         Mensaje = Mensaje + "Problemas al Subir Series" + vbCrLf
         eStilo = "16"
         
      End If
   
   End If
   
   DoEvents
   
   If SSCheck1(1).Value Then
   
      Label2.Caption = "2 de 2"
      If Not GeneraInterfazTD Then
         Mensaje = Mensaje + "Problemas al Subir Tabla de Desarrollo" + vbCrLf
         eStilo = "16"
      
      End If
   
   End If
   
   If Mensaje = "" Then
   
      Mensaje = "Interfaz Levantada Correctamente"
      Call LogAuditoria("09", OptLocal, Me.Caption, "", "")
   
   End If
   
   MsgBox Mensaje, eStilo
   
   Call CargaGrilla
   Progreso.FloodPercent = 0
   Label2.Caption = "0 de 2"
   
'   Call InformeInterfaz
   
End Sub

Private Function GeneraInterfazSeries() As Boolean

Dim Archivo     As String
Dim cNomArchivo As String
Dim Linea       As String
Dim Registros   As Long
Dim Cont        As Long
Dim Error       As String

   On Error GoTo ErrorSerie:

   GeneraInterfazSeries = False

   If Not BAC_SQL_EXECUTE("Sp_BacInterfaces_Archivo", Array("139")) Then
      stbProceso.Panels(2) = "Estado"
      MsgBox "Problemas al buscar la ruta", 16
      Exit Function
   Else
      If BAC_SQL_FETCH(Datos()) Then
         cNomArchivo = Datos(2)
         If Datos(4) <> "\" Then
            Archivo = Datos(4) + "\"
         Else
            Archivo = Datos(4)
         End If
      End If
   End If
   
   Registros = 0
   Archivo = Archivo + cNomArchivo
   
   stbNroRegistros.Panels(1).Text = "Procesando Archivo : " + cNomArchivo
   stbNroRegistros.Panels(2).Text = "Cantidad de Registros : " + CStr(Registros)
   
   stbProceso.Panels(1).Text = "Registros Procesados : " + "0"
   stbProceso.Panels(2).Text = "Estado"
   stbProceso.Panels(3).Text = "Sin Errores"
   
   
   Open Archivo For Input As #1
   
      Do While Not EOF(1)
      
         Line Input #1, Linea
         Registros = Registros + 1
         stbNroRegistros.Panels(2).Text = "Cantidad de Registros : " + CStr(Registros)
      
      Loop
   
   Close #1
   
   
   Open Archivo For Input As #1
   
   Do While Not EOF(1)
   
      Line Input #1, Linea
      Cont = Cont + 1
   
      stbProceso.Panels(1).Text = "Registros Procesados : " + CStr(Cont)
   
      Progreso.FloodPercent = (Cont * 100) / (Registros)
      
      Rut_Emisor = Val(Mid(Linea, 1, 9))
      Serie = Mid(Linea, 11, 20)
      Instrumento = Mid(Linea, 31, 10)
      fecha_emision = Mid(Linea, 41, 8)
      Tasa_Emision = FUNC_FMT_DOUBLE(Mid(Linea, 49, 4) & "." & Mid(Linea, 53, 4))
      TERA = FUNC_FMT_DOUBLE(Mid(Linea, 57, 4) & "." & Mid(Linea, 61, 4))
      Moneda = Mid(Linea, 65, 15)
      Base = Val(Mid(Linea, 80, 3))
      Cupones = Val(Mid(Linea, 83, 3))
      Periodo = Val(Mid(Linea, 86, 2))
      
      
      Envia = Array()
      
      AddParam Envia, Serie
      AddParam Envia, Rut_Emisor
      AddParam Envia, Instrumento
      AddParam Envia, fecha_emision
      AddParam Envia, Tasa_Emision
      AddParam Envia, TERA
      AddParam Envia, Moneda
      AddParam Envia, Base
      AddParam Envia, Cupones
      AddParam Envia, Periodo
      
      If Not BAC_SQL_EXECUTE("SP_CARGA_SERIES_BANCO", Envia) Then
      
         GoTo ErrorSerie:
      
      End If
      
      Error = ""
      
      If BAC_SQL_FETCH(Datos()) Then
      
         If Datos(1) = "OK" Or Datos(1) = "ERROR" Then
            
            Error = Datos(1)
            GoSub ErrorSerieGrilla:
                           
         End If
         
      Else
         
            Error = "ERROR"
            GoSub ErrorSerieGrilla:
         
      End If
      
   Loop
   
   Close #1
   
   Progreso.FloodPercent = 0
   GeneraInterfazSeries = True

Exit Function


ErrorSerie:
     
   Progreso.FloodPercent = 0
   GeneraInterfazSeries = False
   stbProceso.Panels(3).Text = err.Description
   MsgBox "ERROR : " + err.Description, vbCritical

   Exit Function
   
ErrorSerieGrilla:
   
   Call Graba_Series_Tmp(Serie, CDbl(Rut_Emisor), fecha_emision, CDbl(Tasa_Emision), CDbl(TERA), Moneda, CDbl(Base), CDbl(Cupones), CDbl(Periodo), Error, gsBAC_User + "-" + CStr(gsTerminal))
   
   If Error = "ERROR" Then

      stbProceso.Panels(3).Text = "Problemas Subiendo Series"

   End If
   
''   With Grilla
''
''      .Rows = .Rows + 1
''      .TextMatrix(.Rows - 1, 0) = Serie
''      .TextMatrix(.Rows - 1, 1) = Rut_Emisor
''      .TextMatrix(.Rows - 1, 2) = Instrumento
''      .TextMatrix(.Rows - 1, 3) = Fecha_Emision
''      .TextMatrix(.Rows - 1, 4) = Tasa_Emision
''      .TextMatrix(.Rows - 1, 5) = TERA
''      .TextMatrix(.Rows - 1, 6) = Moneda
''      .TextMatrix(.Rows - 1, 7) = Base
''      .TextMatrix(.Rows - 1, 8) = Cupones
''      .TextMatrix(.Rows - 1, 9) = Periodo
''      .TextMatrix(.Rows - 1, 10) = Error
''
''   End With

   Return

End Function

Private Function GeneraInterfazTD() As Boolean
Dim Archivo     As String
Dim cNomArchivo As String
Dim Linea       As String
Dim Registros   As Long
Dim Cont        As Long
Dim Datos()
Dim Error       As String

   On Error GoTo ErrorSerie:

   GeneraInterfazTD = False

   If Not BAC_SQL_EXECUTE("Sp_BacInterfaces_Archivo", Array("140")) Then
      stbProceso.Panels(2) = "Estado"
      MsgBox "Problemas al buscar la ruta", 16
      Exit Function
   Else
      If BAC_SQL_FETCH(Datos()) Then
         cNomArchivo = Datos(2)
         If Datos(4) <> "\" Then
            Archivo = Datos(4) + "\"
         Else
            Archivo = Datos(4)
         End If
      End If
   End If
   
   Archivo = Archivo + cNomArchivo
   Registros = 0
   
   stbNroRegistros.Panels(1).Text = "Procesando Archivo : " + cNomArchivo
   stbNroRegistros.Panels(2).Text = "Cantidad de Registros : " + CStr(Registros)
   
   stbProceso.Panels(1).Text = "Registros Procesados : " + "0"
   stbProceso.Panels(2).Text = "Estado"
   stbProceso.Panels(3).Text = "Sin Errores"
   
   
   Open Archivo For Input As #1
   
      Do While Not EOF(1)
      
         Line Input #1, Linea
         Registros = Registros + 1
         stbNroRegistros.Panels(2).Text = "Cantidad de Registros : " + CStr(Registros)
      
      Loop
   
   Close #1
   
   
   Open Archivo For Input As #1
   
   Do While Not EOF(1)
   
      Line Input #1, Linea
      Cont = Cont + 1
   
      stbProceso.Panels(1).Text = "Registros Procesados : " + CStr(Cont)
   
      Progreso.FloodPercent = (Cont * 100) / (Registros)
      
      Serie = Mid(Linea, 11, 20)
      Numero_Cupon = Val(Mid(Linea, 31, 3))
      Fecha_Vcto_Cupon = Mid(Linea, 34, 8)
      Interes = FUNC_FMT_DOUBLE(Mid(Linea, 42, 4) & "." & Mid(Linea, 46, 6))
      Amortizacion = FUNC_FMT_DOUBLE(Mid(Linea, 53, 5) & "." & Mid(Linea, 58, 6))
      Saldo = FUNC_FMT_DOUBLE(Mid(Linea, 64, 5) & "." & Mid(Linea, 69, 6))
      
      Envia = Array()
      
      AddParam Envia, Serie
      AddParam Envia, Numero_Cupon
      AddParam Envia, Fecha_Vcto_Cupon
      AddParam Envia, Interes
      AddParam Envia, Amortizacion
      AddParam Envia, Saldo
      AddParam Envia, gsBAC_User + "-" + CStr(gsTerminal)
      
      If Not BAC_SQL_EXECUTE("SP_CARGA_TD_BANCO", Envia) Then
      
         GoTo ErrorSerie:
      
      End If
      
      Error = ""
      
      If BAC_SQL_FETCH(Datos()) Then
      
         If Datos(1) = "OK" Or Datos(1) = "ERROR" Then
           
           Error = Datos(1)
           GoSub ErrorSerieGrilla:
          
         End If
      
      Else
      
           Error = "ERROR"
           GoSub ErrorSerieGrilla:
      
      End If
            
      
   Loop
   
   Close #1
   
   Progreso.FloodPercent = 0
   GeneraInterfazTD = True

Exit Function


ErrorSerie:

   Progreso.FloodPercent = 0
   GeneraInterfazTD = False
   stbProceso.Panels(3).Text = err.Description
   MsgBox "ERROR : " + err.Description, vbCritical
   Close #1
   Exit Function
   
ErrorSerieGrilla:

'   Call Graba_Series_Tmp(Serie, 0, Format(gsbac_fecp, "yyyymmdd"), 0, 0, " ", 0, 0, 0, Error, gsBAC_User + "-" + CStr(gsTerminal))

   If Error = "ERROR" Then

      stbProceso.Panels(3).Text = "Problemas Subiendo Series"

   End If



''   With Grilla
''
''      .Rows = .Rows + 1
''      .TextMatrix(.Rows - 1, 0) = Serie
''      .TextMatrix(.Rows - 1, 1) = Numero_Cupon
''      .TextMatrix(.Rows - 1, 2) = Fecha_Vcto_Cupon
''      .TextMatrix(.Rows - 1, 3) = Interes
''      .TextMatrix(.Rows - 1, 4) = Amortizacion
''      .TextMatrix(.Rows - 1, 5) = Saldo
''      .TextMatrix(.Rows - 1, 10) = Error
''
''   End With

   Return

End Function



Function TotalRegistros(Archivo As String) As Long
Dim DB As Database
Dim TB As Recordset

   Set DB = OpenDatabase(Archivo, False, False, "TEXT")
   Set TB = DB.OpenRecordset(Archivo)

   TotalRegistros = TB.RecordCount

   TB.Close
   DB.Close

End Function


Private Sub CargaGrilla()

   stbNroRegistros.Panels(1).Text = ""
   stbNroRegistros.Panels(2).Text = ""
   stbProceso.Panels(1).Text = ""
   stbProceso.Panels(2).Text = ""
   stbProceso.Panels(3).Text = ""

   With Grilla
   
      .Rows = 2
      .FixedRows = 1
      .Rows = 1
      .FixedCols = 0

   End With
   
End Sub


Private Sub Graba_Series_Tmp(Serie As String, Emisor As Double, fecha_emision As String, Tasa_Emision As Double, Tasa_Real As Double, UM As String, Base As Double, Numero_Cupones As Double, Perido_Pago As Double, Estado As String, Terminal As String)

   Envia = Array()
   AddParam Envia, Serie
   AddParam Envia, Emisor
   AddParam Envia, fecha_emision
   AddParam Envia, Tasa_Emision
   AddParam Envia, Tasa_Real
   AddParam Envia, UM
   AddParam Envia, Base
   AddParam Envia, Numero_Cupones
   AddParam Envia, Perido_Pago
   AddParam Envia, Estado
   AddParam Envia, Terminal
   
   
   Call BAC_SQL_EXECUTE("Sp_PasoInterfazSerie_Graba", Envia)
   
   
End Sub

Private Function Crea_Temporal(Terminal, Crea As String) As Boolean

     Envia = Array()
     AddParam Envia, Terminal
     AddParam Envia, Crea

     Crea_Temporal = BAC_SQL_EXECUTE("Sp_CreaPasoInterfazSerie", Envia)

End Function

Private Sub InformeInterfaz(Tipo_Impresion As Integer)
Dim Datos()
   On Error GoTo Elpt
   
   Envia = Array()
   AddParam Envia, gsBAC_User + "-" + CStr(gsTerminal)
   
'   If Not BAC_SQL_EXECUTE("Sp_InformeInterfazSerie", Envia) Then
'
'      MsgBox "Problemas Buscando Información para Informe", vbExclamation
'
'      Exit Sub
'
'   End If
'
'   If BAC_SQL_FETCH(Datos()) Then
'
'      If Datos(1) = 0 Then
'         MsgBox "No Existe Información para Informe", vbInformation
'         Exit Sub
'      End If
'
'   End If

   Call limpiar_cristal
   Screen.MousePointer = vbHourglass
   BAC_Parametros.BacParam.Destination = Tipo_Impresion
   BAC_Parametros.BacParam.ReportFileName = gsRPT_Path & "InterfazSerie.Rpt"
   Call PROC_ESTABLECE_UBICACION(BAC_Parametros.BacParam.RetrieveDataFiles, BAC_Parametros.BacParam)
   BAC_Parametros.BacParam.WindowTitle = "Informe De Series"
   BAC_Parametros.BacParam.StoredProcParam(0) = gsBAC_User + "-" + CStr(gsTerminal)
   BAC_Parametros.BacParam.Formulas(0) = "xUsuario='" & gsBAC_User & "'"
   BAC_Parametros.BacParam.Connect = SwConeccion
   BAC_Parametros.BacParam.Action = 1
   Screen.MousePointer = vbDefault

   Call LogAuditoria("10", OptLocal, Me.Caption, "", "")
   Exit Sub
   
Elpt:
   MsgBox "Problemas Al Emitir Informe", vbExclamation
   Screen.MousePointer = vbDefault
   Call LogAuditoria("10", OptLocal, Me.Caption & " Error al emitir informe", "", "")
   
End Sub
