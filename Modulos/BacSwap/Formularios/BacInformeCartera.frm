VERSION 5.00
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "comctl32.ocx"
Begin VB.Form BacInformeCartera 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Infome de Cartera"
   ClientHeight    =   4890
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   5025
   BeginProperty Font 
      Name            =   "Times New Roman"
      Size            =   8.25
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "BacInformeCartera.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   4890
   ScaleWidth      =   5025
   ShowInTaskbar   =   0   'False
   Begin ComctlLib.Toolbar Toolbar1 
      Height          =   480
      Left            =   0
      TabIndex        =   12
      Top             =   -15
      Width           =   5025
      _ExtentX        =   8864
      _ExtentY        =   847
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   327682
      BeginProperty Buttons {0713E452-850A-101B-AFC0-4210102A8DA7} 
         NumButtons      =   3
         BeginProperty Button1 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Object.ToolTipText     =   "Pantalla"
            Object.Tag             =   ""
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Object.ToolTipText     =   "Impresora"
            Object.Tag             =   ""
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Object.ToolTipText     =   "Salir"
            Object.Tag             =   ""
            ImageIndex      =   3
         EndProperty
      EndProperty
   End
   Begin VB.CommandButton btnPantalla 
      Caption         =   "&Pantalla"
      Enabled         =   0   'False
      Height          =   780
      Left            =   690
      Picture         =   "BacInformeCartera.frx":0442
      Style           =   1  'Graphical
      TabIndex        =   10
      ToolTipText     =   "Informe vista previa en Pantalla"
      Top             =   5265
      Visible         =   0   'False
      Width           =   1185
   End
   Begin VB.CommandButton btnImpresora 
      Caption         =   "&Impresora"
      Enabled         =   0   'False
      Height          =   780
      Left            =   1980
      Picture         =   "BacInformeCartera.frx":0884
      Style           =   1  'Graphical
      TabIndex        =   9
      ToolTipText     =   "Informe directo a Impresora"
      Top             =   5295
      Visible         =   0   'False
      Width           =   1185
   End
   Begin VB.CommandButton btnSalir 
      Caption         =   "&Salir"
      Enabled         =   0   'False
      Height          =   780
      Left            =   3195
      Picture         =   "BacInformeCartera.frx":0B8E
      Style           =   1  'Graphical
      TabIndex        =   8
      Top             =   5310
      Visible         =   0   'False
      Width           =   1185
   End
   Begin VB.Frame Frame1 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   4425
      Left            =   0
      TabIndex        =   2
      Top             =   390
      Width           =   5010
      Begin VB.Frame Frame4 
         Caption         =   "Area Responsable"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   615
         Left            =   750
         TabIndex        =   17
         Top             =   840
         Width           =   4110
         Begin VB.ComboBox Cmb_Area_Responsable 
            Height          =   330
            Left            =   75
            Style           =   2  'Dropdown List
            TabIndex        =   1
            Top             =   210
            Width           =   3945
         End
      End
      Begin VB.Frame Frame5 
         Caption         =   "Cartera Normativa"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   615
         Left            =   750
         TabIndex        =   16
         Top             =   2220
         Width           =   4110
         Begin VB.ComboBox Cmb_Cartera_Normativa 
            Height          =   330
            Left            =   90
            Style           =   2  'Dropdown List
            TabIndex        =   3
            Top             =   210
            Width           =   3945
         End
      End
      Begin VB.Frame Frame6 
         Caption         =   "SubCartera Normativa"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   615
         Left            =   750
         TabIndex        =   15
         Top             =   2910
         Width           =   4110
         Begin VB.ComboBox Cmb_SubCartera_Normativa 
            Height          =   330
            Left            =   90
            Style           =   2  'Dropdown List
            TabIndex        =   4
            Top             =   210
            Width           =   3945
         End
      End
      Begin VB.Frame Frame7 
         Caption         =   "Libro"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   615
         Left            =   750
         TabIndex        =   14
         Top             =   1530
         Width           =   4110
         Begin VB.ComboBox Cmb_Libro 
            Height          =   330
            Left            =   90
            Style           =   2  'Dropdown List
            TabIndex        =   5
            Top             =   210
            Width           =   3945
         End
      End
      Begin VB.Frame Frame3 
         Caption         =   "Tipo de Cartera"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   615
         Left            =   750
         TabIndex        =   13
         Top             =   180
         Width           =   4110
         Begin VB.ComboBox Cmb_Cartera 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   315
            Left            =   90
            Style           =   2  'Dropdown List
            TabIndex        =   0
            Top             =   210
            Width           =   3945
         End
      End
      Begin VB.Frame fr_Modalidad 
         Caption         =   "Flujos en Cartera opción :"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   660
         Left            =   750
         TabIndex        =   11
         Top             =   3660
         Width           =   4095
         Begin VB.OptionButton optRecibimos 
            Caption         =   "Recibimos"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00808000&
            Height          =   225
            Left            =   435
            TabIndex        =   6
            Top             =   300
            Width           =   1275
         End
         Begin VB.OptionButton optPagamos 
            Caption         =   "Pagamos"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00808000&
            Height          =   240
            Left            =   2205
            TabIndex        =   7
            Top             =   300
            Width           =   1725
         End
      End
      Begin VB.Image Image1 
         Height          =   480
         Left            =   60
         Picture         =   "BacInformeCartera.frx":0E98
         Top             =   150
         Width           =   480
      End
   End
   Begin ComctlLib.ImageList ImageList1 
      Left            =   3360
      Top             =   2580
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   327682
      BeginProperty Images {0713E8C2-850A-101B-AFC0-4210102A8DA7} 
         NumListImages   =   3
         BeginProperty ListImage1 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "BacInformeCartera.frx":12DA
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "BacInformeCartera.frx":15F4
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "BacInformeCartera.frx":190E
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "BacInformeCartera"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Public Tipo_Producto            As String
Function InformeCartera(Donde)
   On Error GoTo Control
   Dim QueOp As String
   Dim TipoSwap As Integer
    
   Dim envCartera As Long
   Dim envAreaResp As String
   Dim envCartNom As String
   Dim envSubCartNom As String
   Dim envLibro As String
    
   QueOp = "C"
    
   If BacInformeCartera.Tag <> "Tasa" Then
      If optRecibimos.Value Then
         QueOp = "C"
      Else
         QueOp = "V"
      End If
   End If
    
   With BACSwap.Crystal
      Call BacLimpiaParamCrw
      If Donde = "Pantalla" Then
         .Destination = crptToWindow
      Else
         .Destination = crptToPrinter
      End If
        
      If Tipo_Producto = Tipo_ProductoST Then
         .ReportFileName = gsRPT_Path & "baccarteravigente.rpt"
         TipoSwap = 1
      Else
         If BacInformeCartera.Tag = "PromedioCamara" Then
            .ReportFileName = gsRPT_Path & "baccarteravigente.rpt"
            TipoSwap = 4
         Else
            .ReportFileName = gsRPT_Path & "baccarteravigentemon.rpt"
            TipoSwap = 2
         End If
      End If
      
      If Trim(Right(Cmb_Cartera.Text, 10)) = "" Then
            envCartera = 0
      Else
            envCartera = CLng(Trim(Right(Cmb_Cartera.Text, 10)))
      End If
      
      If Trim(Right(Cmb_Area_Responsable.Text, 10)) = "" Then
            envAreaResp = Space(10)
      Else
            envAreaResp = Trim(Right(Cmb_Area_Responsable.Text, 10))
      End If
      
      If Trim(Right(Cmb_Cartera_Normativa.Text, 10)) = "" Then
            envCartNom = Space(10)
      Else
            envCartNom = Trim(Right(Cmb_Cartera_Normativa.Text, 10))
      End If
      
      If Trim(Right(Cmb_SubCartera_Normativa.Text, 10)) = "" Then
            envSubCartNom = Space(10)
      Else
            envSubCartNom = Trim(Right(Cmb_SubCartera_Normativa.Text, 10))
      End If
      
      If Trim(Right(Cmb_Libro.Text, 10)) = "" Then
            envLibro = Space(10)
      Else
            envLibro = Trim(Right(Cmb_Libro.Text, 10))
      End If
      
      .WindowTitle = "Movimientos en Cartera"
      .StoredProcParam(0) = TipoSwap                           'tipo de swap - Tasa
      .StoredProcParam(1) = QueOp                              'Discriminacion (Compra o Venta)
      .StoredProcParam(2) = Format(gsBAC_Fecp, "YYYYMMDD")
      .StoredProcParam(3) = Format(gsBAC_Fecp, "YYYYMMDD")
      .StoredProcParam(4) = envCartera  'Trim(Right(Cmb_Cartera.Text, 10))
      .StoredProcParam(5) = envAreaResp 'Trim(Right(Cmb_Area_Responsable.Text, 10))
      .StoredProcParam(6) = envCartNom  'Trim(Right(Cmb_Cartera_Normativa.Text, 10))
      .StoredProcParam(7) = envSubCartNom   'Trim(Right(Cmb_SubCartera_Normativa.Text, 10))
      .StoredProcParam(8) = envLibro    'Trim(Right(Cmb_Libro.Text, 10))
      .StoredProcParam(9) = GLB_AREA_RESPONSABLE
      .StoredProcParam(10) = GLB_CARTERA_NORMATIVA
      .StoredProcParam(11) = GLB_SUB_CARTERA_NORMATIVA
      .StoredProcParam(12) = GLB_LIBRO
        
      .Connect = swConeccion
      .Action = 1 'Envio
   End With
Exit Function
Control:
   Select Case BACSwap.Crystal.LastErrorNumber
      Case 20527
         MsgBox "No Existen datos para generar informe solicitado", vbInformation, Msj
      Case Else
         MsgBox BACSwap.Crystal.LastErrorString, vbCritical, Msj
   End Select
End Function

Private Sub btnImpresora_Click()

    Call BacLimpiaParamCrw
    Call InformeCartera("Impresora")

End Sub

Private Sub btnPantalla_Click()

    Call InformeCartera("Pantalla")

End Sub

Private Sub btnSalir_Click()

    Unload BacInformeCartera

End Sub

Private Sub Cmb_Cartera_Normativa_Click()
    If Cmb_Cartera_Normativa.ListIndex > 0 Then
        Call PROC_LLENA_COMBOS(Cmb_SubCartera_Normativa, 1, True, GLB_SUB_CARTERA_NORMATIVA, Trim(Right(Cmb_Cartera_Normativa.Text, 10)))
    Else
        Cmb_SubCartera_Normativa.Clear
        Cmb_SubCartera_Normativa.AddItem "<TODOS [AS]>" + Space(100)
        Cmb_SubCartera_Normativa.ListIndex = 0
    End If
End Sub


Private Sub Form_Activate()

   If BacInformeCartera.Tag = "Tasa" Or UCase(BacInformeCartera.Tag) Like UCase("*Camara*") Then
      If UCase(BacInformeCartera.Tag) Like UCase("*Camara*") Then
         BacInformeCartera.Caption = "Informe de Cartera Swap Promedio Camara"
      Else
         BacInformeCartera.Caption = "Informe de Cartera Swap de Tasa"
      End If
      optRecibimos.Caption = "Recibimos"
      optPagamos.Caption = "Pagamos"
        
      optRecibimos.Enabled = False
      optPagamos.Enabled = False
   Else
      BacInformeCartera.Caption = "Informe de Cartera Swap de Moneda"
      fr_Modalidad.Caption = "Entregamos / Recibimos  - USD"
      optRecibimos.Caption = "Recibimos"
      optPagamos.Caption = "Entregamos"
   End If

End Sub

Private Sub Form_Load()
Me.Icon = BACSwap.Icon

'PRD-5149, jbh, 12-01-2010, para evitar "paseo" del form por la pantalla
Me.Top = 0
Me.Left = 0

optRecibimos.Value = True
'Func_Cartera Cmb_Cartera, "PCS"

   Call PROC_LLENA_COMBOS(Cmb_Cartera, 3, True, GLB_CARTERA)
   Call PROC_LLENA_COMBOS(Cmb_Area_Responsable, 3, True, GLB_AREA_RESPONSABLE)
   Call PROC_LLENA_COMBOS(Cmb_Libro, 3, True, GLB_LIBRO)
   Call PROC_LLENA_COMBOS(Cmb_Cartera_Normativa, 3, True, GLB_CARTERA_NORMATIVA)

End Sub

Private Sub Form_Unload(Cancel As Integer)

    BacInformeCartera.Tag = ""

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As ComctlLib.Button)
Select Case Button.Index
   Case 1
      Call InformeCartera("Pantalla")
   Case 2
      Call BacLimpiaParamCrw
      Call InformeCartera("Impresora")
   Case 3
      Unload BacInformeCartera
End Select
End Sub
