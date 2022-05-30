VERSION 5.00
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "comctl32.ocx"
Begin VB.Form BacInformeCartera_Ticket 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Infome de Cartera"
   ClientHeight    =   2235
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
   Icon            =   "BacInformeCartera_Ticket.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   2235
   ScaleWidth      =   5025
   ShowInTaskbar   =   0   'False
   Begin ComctlLib.Toolbar Toolbar1 
      Height          =   480
      Left            =   0
      TabIndex        =   5
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
      Picture         =   "BacInformeCartera_Ticket.frx":0442
      Style           =   1  'Graphical
      TabIndex        =   4
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
      Picture         =   "BacInformeCartera_Ticket.frx":0884
      Style           =   1  'Graphical
      TabIndex        =   3
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
      Picture         =   "BacInformeCartera_Ticket.frx":0B8E
      Style           =   1  'Graphical
      TabIndex        =   2
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
      Height          =   1740
      Left            =   0
      TabIndex        =   1
      Top             =   390
      Width           =   5010
      Begin VB.Frame Frame2 
         Caption         =   "Cartera Destino"
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
         Left            =   780
         TabIndex        =   7
         Top             =   885
         Width           =   4110
         Begin VB.ComboBox CmbCarteraDestino 
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
            Left            =   105
            Style           =   2  'Dropdown List
            TabIndex        =   8
            Top             =   210
            Width           =   3945
         End
      End
      Begin VB.Frame Frame3 
         Caption         =   "Cartera Origen"
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
         TabIndex        =   6
         Top             =   180
         Width           =   4110
         Begin VB.ComboBox CmbCarteraOrigen 
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
      Begin VB.Image Image1 
         Height          =   480
         Left            =   60
         Picture         =   "BacInformeCartera_Ticket.frx":0E98
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
            Picture         =   "BacInformeCartera_Ticket.frx":12DA
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "BacInformeCartera_Ticket.frx":15F4
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "BacInformeCartera_Ticket.frx":190E
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "BacInformeCartera_Ticket"
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
    
   QueOp = "C"
    
    
   With BACSwap.Crystal
      Call BacLimpiaParamCrw
      If Donde = "Pantalla" Then
         .Destination = crptToWindow
      Else
         .Destination = crptToPrinter
      End If
        
      .ReportFileName = gsRPT_Path & "baccarteravigente_Ticket.rpt"
      .WindowTitle = "Movimientos en Cartera Ticket Intra Mesa"
      .StoredProcParam(0) = TipoSwap                           'tipo de swap - Tasa
      .StoredProcParam(1) = QueOp                              'Discriminacion (Compra o Venta)
      .StoredProcParam(2) = Format(gsBAC_Fecp, "YYYYMMDD")
      .StoredProcParam(3) = Format(gsBAC_Fecp, "YYYYMMDD")
      .StoredProcParam(4) = CmbCarteraOrigen.ItemData(CmbCarteraOrigen.ListIndex) 'Right(cmbCarteraOrig.Text, 2)
      .StoredProcParam(5) = CmbCarteraDestino.ItemData(CmbCarteraDestino.ListIndex) 'Right(cmbCarteraDest.Text, 2)
        
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

Private Sub Form_Activate()

 '

End Sub

Private Sub Form_Load()
    Me.Icon = BACSwap.Icon
    
    'PRD-5149, jbh, 12-01-2010, para evitar "paseo" del form por la pantalla
    Me.Top = 0
    Me.Left = 0
    
'    optRecibimos.Value = True
    Func_Cartera CmbCarteraOrigen, "PCS"
    Func_Cartera CmbCarteraDestino, "PCS"

End Sub

Private Sub Form_Unload(Cancel As Integer)

'    BacInformeCartera.Tag = ""

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As ComctlLib.Button)
Select Case Button.Index
   Case 1
      Call InformeCartera("Pantalla")
   Case 2
      Call BacLimpiaParamCrw
      Call InformeCartera("Impresora")
   Case 3
      Unload Me
End Select
End Sub
