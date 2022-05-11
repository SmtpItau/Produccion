VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form FRM_GEN_INF_SEG_DCV 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Informe de Seguimiento Op. Enviadas"
   ClientHeight    =   3795
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   3780
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   3795
   ScaleWidth      =   3780
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   5
      Top             =   0
      Width           =   3780
      _ExtentX        =   6668
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Imprimir"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Vista Previa"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Cerrar Ventana"
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   1680
         Top             =   255
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   3
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_GEN_INF_SEG_DCV.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_GEN_INF_SEG_DCV.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_GEN_INF_SEG_DCV.frx":1DB4
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame Frame1 
      Height          =   3360
      Left            =   0
      TabIndex        =   6
      Top             =   435
      Width           =   3765
      Begin VB.TextBox SerieInstrumento 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Left            =   675
         MaxLength       =   13
         TabIndex        =   17
         Top             =   2280
         Width           =   2970
      End
      Begin VB.ComboBox Usuario 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   690
         Style           =   2  'Dropdown List
         TabIndex        =   14
         Top             =   2925
         Width           =   2955
      End
      Begin BACControles.TXTNumero Documento 
         Height          =   315
         Left            =   690
         TabIndex        =   2
         Top             =   1695
         Width           =   1410
         _ExtentX        =   2487
         _ExtentY        =   556
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0"
         Text            =   "0"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTFecha Desde 
         Height          =   300
         Left            =   705
         TabIndex        =   0
         Top             =   630
         Width           =   1440
         _ExtentX        =   2540
         _ExtentY        =   529
         Enabled         =   -1  'True
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "25/04/2006"
      End
      Begin BACControles.TXTFecha Hasta 
         Height          =   300
         Left            =   2175
         TabIndex        =   1
         Top             =   630
         Width           =   1440
         _ExtentX        =   2540
         _ExtentY        =   529
         Enabled         =   -1  'True
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "25/04/2006"
      End
      Begin BACControles.TXTNumero Correlativo 
         Height          =   315
         Left            =   2190
         TabIndex        =   3
         Top             =   1695
         Width           =   1425
         _ExtentX        =   2514
         _ExtentY        =   556
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0"
         Text            =   "0"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Serie Instrumento"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Index           =   7
         Left            =   675
         TabIndex        =   16
         Top             =   2070
         Width           =   1515
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Usuario"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Index           =   6
         Left            =   675
         TabIndex        =   15
         Top             =   2700
         Width           =   630
      End
      Begin VB.Label diaHasta 
         Caption         =   "Miercoles"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Left            =   2220
         TabIndex        =   13
         Top             =   960
         Width           =   690
      End
      Begin VB.Label DiaDesde 
         Caption         =   "Miercoles"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Left            =   720
         TabIndex        =   4
         Top             =   960
         Width           =   690
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "N° Correlativo"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Index           =   5
         Left            =   2220
         TabIndex        =   12
         Top             =   1500
         Width           =   1125
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "N° Documento"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Index           =   4
         Left            =   705
         TabIndex        =   11
         Top             =   1500
         Width           =   1155
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Filtro Operativo"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Index           =   3
         Left            =   75
         TabIndex        =   10
         Top             =   1245
         Width           =   1260
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Hasta"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Index           =   2
         Left            =   2160
         TabIndex        =   9
         Top             =   420
         Width           =   450
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Desde"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Index           =   1
         Left            =   735
         TabIndex        =   8
         Top             =   435
         Width           =   525
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Filtro de Fechas"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Index           =   0
         Left            =   105
         TabIndex        =   7
         Top             =   165
         Width           =   1305
      End
   End
End
Attribute VB_Name = "FRM_GEN_INF_SEG_DCV"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub CargaUsuarios()
   Dim SQL As String
   Dim datos()
   
   SQL = "SELECT nombre , usuario FROM BacParamSuda..USUARIO ORDER BY NOMBRE"
   If Not Bac_Sql_Execute(SQL) Then
      MsgBox "Problemas al cargar usuarios.", vbExclamation, TITSISTEMA
      Exit Sub
   End If
   Usuario.Clear
   Usuario.AddItem "<< TODOS >>"
   Do While Bac_SQL_Fetch(datos())
      If InStr(1, datos(1), "-") > 0 Then
         Usuario.AddItem Mid(datos(1), 1, InStr(1, datos(1), "-") - 1) & Space(100) & datos(2)
      Else
         Usuario.AddItem datos(1) & Space(100) & datos(2)
      End If
   Loop
   Usuario.ListIndex = 0
End Sub

Private Sub Desde_Change()
   DiaDesde.Caption = Format(Desde.Text, "dddd")
   
   Desde.ForeColor = vbBlack
   DiaDesde.ForeColor = vbBlack
   If Weekday(Desde.Text) = 7 Or Weekday(Desde.Text) = 1 Then
      Desde.ForeColor = vbRed
      DiaDesde.ForeColor = vbRed
   End If
End Sub

Private Sub Form_Load()
   Me.Top = 0: Me.Left = 0
   Me.Icon = BacTrader.Icon
   
   Desde.Text = Format(gsBac_Fecp, "dd/mm/yyyy")
   Hasta.Text = Format(gsBac_Fecp, "dd/mm/yyyy")
   Call CargaUsuarios
End Sub

Private Sub Hasta_Change()
   diaHasta.Caption = Format(Hasta.Text, "dddd")
   Hasta.ForeColor = vbBlack
   diaHasta.ForeColor = vbBlack
   If Weekday(Hasta.Text) = 7 Or Weekday(Hasta.Text) = 1 Then
      Hasta.ForeColor = vbRed
      diaHasta.ForeColor = vbRed
   End If

End Sub

Private Sub SerieInstrumento_KeyPress(KeyAscii As Integer)
   KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 1
         Call ImprimirSegimiento(crptToPrinter)
      Case 2
         Call ImprimirSegimiento(crptToWindow)
      Case 3
         Unload Me
   End Select
End Sub

Private Sub ImprimirSegimiento(MiDestino As DestinationConstants)
   On Error GoTo ErrPrint
   Dim MiUsuario  As String
   
   Call Limpiar_Cristal
   
   If Usuario.Text = "<< TODOS >>" Then
      MiUsuario = ""
   Else
      MiUsuario = Trim(Mid(Usuario.Text, 100))
   End If
   
   BacTrader.bacrpt.WindowTitle = "Informe de Segimiento a Operaciones Enviadas a DCV."
   BacTrader.bacrpt.ReportTitle = "Informe de Segimiento a Operaciones Enviadas a DCV."
   BacTrader.bacrpt.WindowState = crptMaximized
   BacTrader.bacrpt.Destination = MiDestino
   BacTrader.bacrpt.ReportFileName = RptList_Path & "Informe_SegimientoOpEnviadas.rpt"
                                 ' Store Procedure : dbo.SVC_INFORME_SEGIMIENTO_OPDCV
   BacTrader.bacrpt.StoredProcParam(0) = gsBac_User
   BacTrader.bacrpt.StoredProcParam(1) = Format(Desde.Text, "yyyy-mm-dd 00:00:00.000")
   BacTrader.bacrpt.StoredProcParam(2) = Format(Hasta.Text, "yyyy-mm-dd 00:00:00.000")
   BacTrader.bacrpt.StoredProcParam(3) = CDbl(Documento.Text)
   BacTrader.bacrpt.StoredProcParam(4) = CDbl(Correlativo.Text)
   BacTrader.bacrpt.StoredProcParam(5) = IIf(MiUsuario = "", Space(1), MiUsuario)
   BacTrader.bacrpt.StoredProcParam(6) = IIf(SerieInstrumento.Text = "", Space(1), SerieInstrumento.Text)
   
   
   BacTrader.bacrpt.Connect = CONECCION
   BacTrader.bacrpt.Action = 1

Exit Sub
ErrPrint:
   MsgBox "Error de Impresión" & vbCrLf & vbCrLf & err.Description, vbExclamation, TITSISTEMA
End Sub
