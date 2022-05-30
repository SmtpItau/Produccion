VERSION 5.00
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "comctl32.ocx"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacInformes 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Informe de Movimientos"
   ClientHeight    =   5295
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4290
   Icon            =   "BacInformes.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5295
   ScaleWidth      =   4290
   Begin ComctlLib.Toolbar Toolbar1 
      Height          =   480
      Left            =   0
      TabIndex        =   14
      Top             =   0
      Width           =   4290
      _ExtentX        =   7567
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
            Key             =   ""
            Object.ToolTipText     =   "Pantalla"
            Object.Tag             =   ""
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   ""
            Object.ToolTipText     =   "Impresora"
            Object.Tag             =   ""
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   ""
            Object.ToolTipText     =   "Salir"
            Object.Tag             =   ""
            ImageIndex      =   3
         EndProperty
      EndProperty
   End
   Begin VB.CommandButton btnPantalla 
      Caption         =   "&Pantalla"
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   780
      Left            =   660
      Picture         =   "BacInformes.frx":0442
      Style           =   1  'Graphical
      TabIndex        =   5
      ToolTipText     =   "Informe vista previa en Pantalla"
      Top             =   6975
      Visible         =   0   'False
      Width           =   1185
   End
   Begin VB.CommandButton btnSalir 
      Caption         =   "&Salir"
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   780
      Left            =   3090
      Picture         =   "BacInformes.frx":0884
      Style           =   1  'Graphical
      TabIndex        =   9
      ToolTipText     =   "Salir Pantalla"
      Top             =   6975
      Visible         =   0   'False
      Width           =   1185
   End
   Begin VB.CommandButton btnInforme 
      Caption         =   "&Informe"
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   780
      Left            =   1875
      Picture         =   "BacInformes.frx":0B8E
      Style           =   1  'Graphical
      TabIndex        =   8
      ToolTipText     =   "Informe directo a Impresora"
      Top             =   6975
      Visible         =   0   'False
      Width           =   1185
   End
   Begin VB.Frame Frame1 
      Height          =   4830
      Left            =   -15
      TabIndex        =   0
      Top             =   420
      Width           =   4260
      Begin VB.Frame Frame6 
         Caption         =   "SubCartera Normativa"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   615
         Left            =   60
         TabIndex        =   18
         Top             =   3300
         Width           =   4110
         Begin VB.ComboBox Cmb_SubCartera_Normativa 
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
            Left            =   90
            Style           =   2  'Dropdown List
            TabIndex        =   4
            Top             =   210
            Width           =   3945
         End
      End
      Begin VB.Frame Frame5 
         Caption         =   "Cartera Normativa"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   615
         Left            =   60
         TabIndex        =   17
         Top             =   2580
         Width           =   4110
         Begin VB.ComboBox Cmb_Cartera_Normativa 
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
            Left            =   90
            Style           =   2  'Dropdown List
            TabIndex        =   3
            Top             =   210
            Width           =   3945
         End
      End
      Begin VB.Frame Frame4 
         Caption         =   "Area Responsable"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   615
         Left            =   60
         TabIndex        =   16
         Top             =   1185
         Width           =   4110
         Begin VB.ComboBox Cmb_Area_Responsable 
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
            Left            =   90
            Style           =   2  'Dropdown List
            TabIndex        =   2
            Top             =   180
            Width           =   3945
         End
      End
      Begin VB.Frame Frame3 
         Caption         =   "Tipo de Cartera"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   615
         Left            =   60
         TabIndex        =   15
         Top             =   510
         Width           =   4110
         Begin VB.ComboBox Cmb_Cartera 
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
            Left            =   90
            Style           =   2  'Dropdown List
            TabIndex        =   1
            Top             =   210
            Width           =   3945
         End
      End
      Begin VB.Frame Frame2 
         Height          =   795
         Left            =   75
         TabIndex        =   10
         Top             =   3930
         Width           =   4095
         Begin BACControles.TXTFecha txtFecha 
            Height          =   315
            Left            =   1695
            TabIndex        =   7
            Top             =   150
            Width           =   1410
            _ExtentX        =   2487
            _ExtentY        =   556
            Enabled         =   -1  'True
            Enabled         =   -1  'True
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            MaxDate         =   2958465
            MinDate         =   -328716
            Text            =   "15/02/2001"
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "Fecha de Proceso"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   210
            Index           =   0
            Left            =   75
            TabIndex        =   12
            Top             =   180
            Width           =   1470
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "Día no Hábil"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00000080&
            Height          =   210
            Index           =   1
            Left            =   1770
            TabIndex        =   11
            Top             =   540
            Visible         =   0   'False
            Width           =   930
         End
      End
      Begin VB.Frame Frame7 
         Caption         =   "Libro"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   615
         Left            =   60
         TabIndex        =   19
         Top             =   1875
         Width           =   4110
         Begin VB.ComboBox Cmb_Libro 
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
            Left            =   90
            Style           =   2  'Dropdown List
            TabIndex        =   6
            Top             =   210
            Width           =   3945
         End
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Tipo Swap"
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
         Height          =   195
         Index           =   2
         Left            =   165
         TabIndex        =   13
         Top             =   195
         Width           =   915
      End
      Begin VB.Image Image1 
         Height          =   480
         Left            =   5415
         Picture         =   "BacInformes.frx":0E98
         Top             =   1530
         Width           =   480
      End
   End
   Begin ComctlLib.ImageList ImageList1 
      Left            =   30
      Top             =   5400
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
            Picture         =   "BacInformes.frx":12DA
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "BacInformes.frx":15F4
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "BacInformes.frx":190E
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "BacInformes"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Public Tipo_Producto    As String

Function GeneraInforme(MiDestino As DestinationConstants)
   On Error GoTo Control
   Dim num    As Integer
   Dim Origen As Integer
   Dim Fecha  As Date
   Dim tipo   As Integer

   If CDate(txtFecha.Text) > CDate(gsBAC_Fecp) Then
      MsgBox "Fecha no puede ser mayor a fecha de proceso!", vbInformation, Msj
      txtFecha.SetFocus
      Exit Function
   End If
   If CDate(txtFecha.Text) = CDate(gsBAC_Fecp) Then
      Origen = 1
      Fecha = gsBAC_Fecp
   Else
      Origen = 2
      Fecha = txtFecha.Text
   End If

   Call BacLimpiaParamCrw

   If Tipo_Producto = Tipo_ProductoST Then
      tipo = 1
      BACSwap.Crystal.ReportFileName = gsRPT_Path & "movimientodiario.rpt"
      BACSwap.Crystal.StoredProcParam(0) = tipo
      BACSwap.Crystal.StoredProcParam(1) = " "
      BACSwap.Crystal.StoredProcParam(2) = Format(Fecha, "YYYYMMDD")
      BACSwap.Crystal.StoredProcParam(3) = Left(Time, 8)
      BACSwap.Crystal.StoredProcParam(4) = Origen                         'Mirar de donde viene
      BACSwap.Crystal.StoredProcParam(5) = IIf(Trim(Right(Cmb_Cartera.Text, 10)) = "", 0, Val(Trim(Right(Cmb_Cartera.Text, 10))))
      BACSwap.Crystal.StoredProcParam(6) = Trim(Right(Cmb_Area_Responsable.Text, 10))
      BACSwap.Crystal.StoredProcParam(7) = Trim(Right(Cmb_Cartera_Normativa.Text, 10))
      BACSwap.Crystal.StoredProcParam(8) = Trim(Right(Cmb_SubCartera_Normativa.Text, 10))
      BACSwap.Crystal.StoredProcParam(9) = Trim(Right(Cmb_Libro.Text, 10))
      BACSwap.Crystal.StoredProcParam(10) = GLB_AREA_RESPONSABLE
      BACSwap.Crystal.StoredProcParam(11) = GLB_CARTERA_NORMATIVA
      BACSwap.Crystal.StoredProcParam(12) = GLB_SUB_CARTERA_NORMATIVA
      BACSwap.Crystal.StoredProcParam(13) = GLB_LIBRO
   ElseIf Tipo_Producto = Tipo_ProductoSPC Then
      tipo = 4
      BACSwap.Crystal.ReportFileName = gsRPT_Path & "movimientodiario.rpt"
      BACSwap.Crystal.StoredProcParam(0) = tipo
      BACSwap.Crystal.StoredProcParam(1) = " "
      BACSwap.Crystal.StoredProcParam(2) = Format(Fecha, "YYYYMMDD")
      BACSwap.Crystal.StoredProcParam(3) = Left(Time, 8)
      BACSwap.Crystal.StoredProcParam(4) = Origen
      BACSwap.Crystal.StoredProcParam(5) = IIf(Trim(Right(Cmb_Cartera.Text, 10)) = "", 0, Val(Trim(Right(Cmb_Cartera.Text, 10))))
      BACSwap.Crystal.StoredProcParam(6) = Trim(Right(Cmb_Area_Responsable.Text, 10))
      BACSwap.Crystal.StoredProcParam(7) = Trim(Right(Cmb_Cartera_Normativa.Text, 10))
      BACSwap.Crystal.StoredProcParam(8) = Trim(Right(Cmb_SubCartera_Normativa.Text, 10))
      BACSwap.Crystal.StoredProcParam(9) = Trim(Right(Cmb_Libro.Text, 10))
      BACSwap.Crystal.StoredProcParam(10) = GLB_AREA_RESPONSABLE
      BACSwap.Crystal.StoredProcParam(11) = GLB_CARTERA_NORMATIVA
      BACSwap.Crystal.StoredProcParam(12) = GLB_SUB_CARTERA_NORMATIVA
      BACSwap.Crystal.StoredProcParam(13) = GLB_LIBRO
   ElseIf Tipo_Producto = Tipo_ProductoSM Then
      tipo = 2
      BACSwap.Crystal.ReportFileName = gsRPT_Path & "BacMovimDiarioMoneda.rpt"
      BACSwap.Crystal.StoredProcParam(0) = tipo
      BACSwap.Crystal.StoredProcParam(1) = Format(Fecha, "YYYYMMDD")
      BACSwap.Crystal.StoredProcParam(2) = Origen
      BACSwap.Crystal.StoredProcParam(3) = IIf(Trim(Right(Cmb_Cartera.Text, 10)) = "", 0, Trim(Right(Cmb_Cartera.Text, 10)))
      BACSwap.Crystal.StoredProcParam(4) = Trim(Right(Cmb_Area_Responsable.Text, 10))
      BACSwap.Crystal.StoredProcParam(5) = Trim(Right(Cmb_Cartera_Normativa.Text, 10))
      BACSwap.Crystal.StoredProcParam(6) = Trim(Right(Cmb_SubCartera_Normativa.Text, 10))
      BACSwap.Crystal.StoredProcParam(7) = Trim(Right(Cmb_Libro.Text, 10))
      BACSwap.Crystal.StoredProcParam(8) = GLB_AREA_RESPONSABLE
      BACSwap.Crystal.StoredProcParam(9) = GLB_CARTERA_NORMATIVA
      BACSwap.Crystal.StoredProcParam(10) = GLB_SUB_CARTERA_NORMATIVA
      BACSwap.Crystal.StoredProcParam(11) = GLB_LIBRO
   End If
   
   BACSwap.Crystal.WindowTitle = "Informe de Movimientos"
   BACSwap.Crystal.Destination = MiDestino
   BACSwap.Crystal.Connect = swConeccion
   BACSwap.Crystal.Action = 1

Exit Function
Control:
   MsgBox "Acción  Cancelada." & vbCrLf & vbCrLf & "Error al generar informe." & vbCrLf & BACSwap.Crystal.LastErrorString, vbExclamation, TITSISTEMA
End Function

Function InformeVoucher(MiDestino As DestinationConstants)
   On Error GoTo Control
   
   Call BacLimpiaParamCrw
   
   BACSwap.Crystal.WindowTitle = "Voucher Contable"
   BACSwap.Crystal.ReportFileName = gsRPT_Path & "BacinformeVouchers.rpt"
   BACSwap.Crystal.StoredProcParam(0) = Format(txtFecha.Text, "yyyymmdd")
   BACSwap.Crystal.StoredProcParam(1) = txtFecha.Text
   BACSwap.Crystal.Destination = MiDestino
   BACSwap.Crystal.Connect = swConeccion
   BACSwap.Crystal.Action = 1
Exit Function
Control:
   MsgBox "Acción  Cancelada." & vbCrLf & vbCrLf & "Error al generar informe." & vbCrLf & BACSwap.Crystal.LastErrorString, vbExclamation, TITSISTEMA
End Function

Function InformeVoucherConsolidado(MiDestino As DestinationConstants)
   On Error GoTo Control
   
   Call BacLimpiaParamCrw
   
   BACSwap.Crystal.WindowTitle = "Voucher Contable Consolidado"
   BACSwap.Crystal.ReportFileName = gsRPT_Path & "bacvoucherconsolidado.rpt"
   BACSwap.Crystal.StoredProcParam(0) = Format(txtFecha.Text, "yyyymmdd")
   BACSwap.Crystal.Destination = MiDestino
   BACSwap.Crystal.Connect = swConeccion
   BACSwap.Crystal.Action = 1

Exit Function
Control:
   MsgBox "Acción  Cancelada." & vbCrLf & vbCrLf & "Error al generar informe." & vbCrLf & BACSwap.Crystal.LastErrorString, vbExclamation, TITSISTEMA
End Function

Private Sub btnPantalla_Click()
   If Label1(1).Visible = True Then
      MsgBox "Fecha Seleccionada para consulta no es Hábil!", vbExclamation, Msj
      txtFecha.SetFocus
      
   ElseIf BacInformes.Tag = "VOUCHER" Then
      Call InformeVoucher(crptToWindow)
   ElseIf BacInformes.Tag = "CONSOLIDADO" Then
      Call InformeVoucherConsolidado(crptToWindow)
   ElseIf BacInformes.Tag = "RECUENTAS" Then
      Call InformeResumenCuentas(crptToWindow)
   Else
      Call GeneraInforme(crptToWindow)
   End If
End Sub

Private Sub btnInforme_Click()
   If Label1(1).Visible = True Then
      MsgBox "Fecha Seleccionada para consulta no es Hábil!", vbInformation, Msj
      txtFecha.SetFocus
   
   ElseIf BacInformes.Tag = "VOUCHER" Then
      Call InformeVoucher(crptToPrinter)
   ElseIf BacInformes.Tag = "CONSOLIDADO" Then
      Call InformeVoucherConsolidado(crptToPrinter)
   ElseIf BacInformes.Tag = "RECUENTAS" Then
      Call InformeResumenCuentas(crptToPrinter)
   Else
      Call GeneraInforme(crptToPrinter)
   End If
End Sub



Private Sub btnSalir_Click()
   Unload BacInformes
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
    
   Frame3.Enabled = False
   txtFecha.Enabled = False
   If BacInformes.Tag = "TASAS" Then
      Label1(2).Caption = "Swap de Tasas"
      txtFecha.Enabled = True
      Frame3.Enabled = True
      If Cmb_Cartera.Enabled = True And Cmb_Cartera.Visible = True Then
         Cmb_Cartera.SetFocus
      End If
   ElseIf BacInformes.Tag = "SPC" Then
      Label1(2).Caption = "Swap Promedio Camara"
      txtFecha.Enabled = True    'False
      Frame3.Enabled = True
        
      If Cmb_Cartera.Enabled = True And Cmb_Cartera.Visible = True Then
         Cmb_Cartera.SetFocus
      End If
      
   ElseIf BacInformes.Tag = "MONEDAS" Then
      Label1(2).Caption = "Swap de Monedas"
      txtFecha.Enabled = True                'False
      Frame3.Enabled = True
   ElseIf BacInformes.Tag = "VOUCHER" Then
      BacInformes.Caption = "Informe de Voucher"
      Label1(2).Caption = "Voucher Contable"
   ElseIf BacInformes.Tag = "CONSOLIDADO" Then
      BacInformes.Caption = "Informe de Voucher"
      Label1(2).Caption = "Informe de Voucher Consolidado"
   ElseIf BacInformes.Tag = "RECUENTAS" Then
      BacInformes.Caption = "Informe de Resumen de Cuentas"
      Label1(2).Caption = "Informe de Resumen de Cuentas"
      Frame3.Enabled = False
      Frame4.Enabled = False
      Frame7.Enabled = False
      Frame5.Enabled = False
      Frame6.Enabled = False
   End If
   
End Sub

Private Sub Form_Load()
   Me.Icon = BACSwap.Icon
   
   'PRD-5149, jbh, 12-01-2010, para evitar "paseo" del form en la pantalla
   Me.Top = 0
   Me.Left = 0
   
   txtFecha.MaxDate = gsBAC_Fecp
   txtFecha.Text = gsBAC_Fecp
   Label1(1).Visible = False
    
   Call PROC_LLENA_COMBOS(Cmb_Cartera, 4, True, "", GLB_CARTERA, GLB_ID_SISTEMA)
   Call PROC_LLENA_COMBOS(Cmb_Area_Responsable, 1, True, GLB_AREA_RESPONSABLE, GLB_ID_SISTEMA)
   Call PROC_LLENA_COMBOS(Cmb_Libro, 3, True, GLB_LIBRO)
   Call PROC_LLENA_COMBOS(Cmb_Cartera_Normativa, 3, True, GLB_CARTERA_NORMATIVA)
   Call ValidaFecha
End Sub

Function ValidaFecha()
   If Not BacEsHabil(txtFecha.Text) Then
      txtFecha.ForeColor = &HC0&
      Label1(1).Visible = True
   Else
      Label1(1).Visible = False
      txtFecha.ForeColor = &HC00000
   End If
End Function

Private Sub Toolbar1_ButtonClick(ByVal Button As ComctlLib.Button)
   Select Case Button.Index
      Case 1
         Call btnPantalla_Click
      Case 2
         Call btnInforme_Click
      Case 3
         Unload BacInformes
   End Select
End Sub

Private Sub InformeResumenCuentas(MiDestino As DestinationConstants)
   On Error GoTo ErrPrint
   
   Call BacLimpiaParamCrw
   BACSwap.Crystal.WindowTitle = "Informe de Resumen de Cuentas a la Fecha " & txtFecha.Text
   BACSwap.Crystal.ReportFileName = gsRPT_Path & "Informe_Resumen_Cuentas.rpt"
                  'Store Procedure: dbo.SP_INFORME_RESUMEN_CUENTAS
   BACSwap.Crystal.StoredProcParam(0) = Format(txtFecha.Text, "yyyy-mm-dd 00:00:00.000")
   BACSwap.Crystal.StoredProcParam(1) = gsBAC_User
   BACSwap.Crystal.Destination = MiDestino
   BACSwap.Crystal.Connect = swConeccion
   BACSwap.Crystal.Action = 1

   On Error GoTo 0
Exit Sub
ErrPrint:
   MsgBox "Acción  Cancelada." & vbCrLf & vbCrLf & "Error al generar informe." & vbCrLf & BACSwap.Crystal.LastErrorString, vbExclamation, TITSISTEMA
End Sub


Private Sub txtFecha_Change()
   Call ValidaFecha
End Sub

Private Sub txtFecha_LostFocus()
   Call ValidaFecha
   
   If CDate(txtFecha.Text) > CDate(gsBAC_Fecp) Then
      MsgBox "Fecha no puede ser mayor a fecha de proceso!", vbInformation, Msj
      txtFecha.Text = gsBAC_Fecp
      txtFecha.SetFocus
   End If
End Sub
