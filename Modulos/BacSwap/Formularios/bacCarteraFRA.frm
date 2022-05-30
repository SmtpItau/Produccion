VERSION 5.00
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "comctl32.ocx"
Begin VB.Form bacCarteraFRA 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Informe de Cartera"
   ClientHeight    =   1335
   ClientLeft      =   45
   ClientTop       =   345
   ClientWidth     =   4020
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   1335
   ScaleWidth      =   4020
   ShowInTaskbar   =   0   'False
   Begin ComctlLib.Toolbar Toolbar1 
      Height          =   480
      Left            =   0
      TabIndex        =   4
      Top             =   0
      Width           =   3975
      _ExtentX        =   7011
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
   Begin VB.Frame Frame1 
      Height          =   855
      Left            =   15
      TabIndex        =   0
      Top             =   465
      Width           =   3975
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
         Height          =   675
         Left            =   720
         TabIndex        =   5
         Top             =   120
         Width           =   3015
         Begin VB.ComboBox Cmb_Cartera 
            Height          =   315
            Left            =   90
            Style           =   2  'Dropdown List
            TabIndex        =   6
            Top             =   210
            Width           =   2865
         End
      End
      Begin VB.Frame Frame2 
         Caption         =   " Forward Rate Agreements "
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
         Height          =   1185
         Left            =   705
         TabIndex        =   1
         Top             =   855
         Visible         =   0   'False
         Width           =   3030
         Begin VB.OptionButton optVenta 
            Caption         =   "Ventas"
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
            Height          =   255
            Left            =   720
            TabIndex        =   3
            Top             =   720
            Width           =   1700
         End
         Begin VB.OptionButton optCompra 
            Caption         =   "Compras"
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
            Height          =   255
            Left            =   720
            TabIndex        =   2
            Top             =   360
            Value           =   -1  'True
            Width           =   1700
         End
      End
      Begin VB.Image Image1 
         Height          =   480
         Left            =   90
         Picture         =   "bacCarteraFRA.frx":0000
         Top             =   195
         Width           =   480
      End
   End
   Begin ComctlLib.ImageList ImageList1 
      Left            =   3345
      Top             =   2535
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
            Picture         =   "bacCarteraFRA.frx":0442
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "bacCarteraFRA.frx":075C
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "bacCarteraFRA.frx":0A76
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "bacCarteraFRA"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub btnImpresora_Click(Index As Integer)
   On Error GoTo Control
   Dim TipOpe  As String
   Dim Datos()

   TipOpe = IIf(optCompra.Value, "C", "V")

   Call BacControlWindows(100)
   
   If Cmb_Cartera.ListIndex = -1 Then
      Cmb_Cartera.ListIndex = 2
   End If
   
   Envia = Array()
   AddParam Envia, ""
   AddParam Envia, CDbl(Cmb_Cartera.ItemData(Cmb_Cartera.ListIndex))
   If Not Bac_Sql_Execute("SP_INFORME_CARTERA_FRA", Envia) Then
      MsgBox "Problemas en generación de Informe de Cartera Forward Rate Agreements.", vbExclamation, TITSISTEMA
      Exit Sub
   End If
   If Not Bac_SQL_Fetch(Datos()) Then
      MsgBox "No existen operaciones Forward Rate Agreement para la cartera seleccionada.", vbExclamation, TITSISTEMA
      Exit Sub
   Else
      If Datos(1) = -1 Then
         MsgBox "No existen operaciones Forward Rate Agreement para la cartera " & Trim(Cmb_Cartera.Text), vbExclamation, TITSISTEMA
         Exit Sub
      End If
   End If

   Call BacLimpiaParamCrw
   BACSwap.Crystal.Destination = IIf(Index = 1, crptToWindow, crptToPrinter)
   BACSwap.Crystal.ReportFileName = gsRPT_Path & "Informe_Cartera_fra.rpt"
   BACSwap.Crystal.WindowTitle = "Informe de Cartera Forward Rate Agreement."
   BACSwap.Crystal.ReportTitle = "Informe de Cartera Forward Rate Agreement."
   BACSwap.Crystal.StoredProcParam(0) = ""
   BACSwap.Crystal.StoredProcParam(1) = Cmb_Cartera.ItemData(Cmb_Cartera.ListIndex)
   BACSwap.Crystal.Connect = swConeccion
   BACSwap.Crystal.Action = 1

Exit Sub
Control:
   Select Case BACSwap.Crystal.LastErrorNumber
      Case 20527
         MsgBox "No Existen datos para generar informe solicitado", vbInformation, Msj
      Case Else
         MsgBox BACSwap.Crystal.LastErrorString, vbCritical, Msj
   End Select
End Sub

Private Sub btnSalir_Click()
   Unload Me
End Sub

Private Sub Form_Activate()
   If WindowState = 0 Then
      Top = 1: Left = 15
   End If
   Caption = "Carteras Forward Rate Agreements"
End Sub

Private Sub Form_Load()
   optCompra.Value = True
   Func_Cartera Cmb_Cartera, "PCS"
End Sub

Private Sub Form_Unload(Cancel As Integer)
   Me.Tag = ""
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As ComctlLib.Button)
   Select Case Button.Index
      Case 1
         Call btnImpresora_Click(1)
      Case 2
         Call BacLimpiaParamCrw
         Call btnImpresora_Click(2)
      Case 3
         Unload bacCarteraFRA
   End Select
End Sub
