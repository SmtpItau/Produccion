VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form FRM_GEN_INF_LimitesGlobales 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Informe Ventas Cartera Permanente"
   ClientHeight    =   1335
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4680
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   1335
   ScaleWidth      =   4680
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   4680
      _ExtentX        =   8255
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      ToolTips        =   0   'False
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Vista Previa"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Imresora"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Cerrar"
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   3885
         Top             =   45
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
               Picture         =   "FRM_GEN_INF_LimitesGlobales.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_GEN_INF_LimitesGlobales.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_GEN_INF_LimitesGlobales.frx":1DB4
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame FrameCuadro 
      Height          =   900
      Left            =   15
      TabIndex        =   1
      Top             =   435
      Width           =   4665
      Begin BACControles.TXTFecha TxtFechaDatos 
         Height          =   300
         Left            =   1290
         TabIndex        =   3
         Top             =   195
         Width           =   1305
         _ExtentX        =   2302
         _ExtentY        =   529
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
         Text            =   "10/11/2004"
      End
      Begin VB.Label LblFechaLarga 
         Alignment       =   2  'Center
         Caption         =   "Miercoles, 16 de Septiembre de 2004"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   285
         Left            =   60
         TabIndex        =   4
         Top             =   540
         Width           =   4500
      End
      Begin VB.Label LblEtiqueta 
         AutoSize        =   -1  'True
         Caption         =   "Fecha"
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
         Left            =   465
         TabIndex        =   2
         Top             =   240
         Width           =   480
      End
   End
End
Attribute VB_Name = "FRM_GEN_INF_LimitesGlobales"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private Enum EmisionVia
    [Impresora] = crptToPrinter
    [VistaPrevia] = crptToWindow
End Enum

Private Sub Form_Load()
    Me.Icon = BacControlFinanciero.Icon
    Me.Top = 0: Me.Left = 0
    
    TxtFechaDatos.Text = Format(gsBAC_Fecp, "dd/mm/yyyy")
End Sub
Private Sub TxtFechaDatos_Change()
    LblFechaLarga.Caption = Format(TxtFechaDatos.Text, "dddd dd ") & " de " & Format(TxtFechaDatos.Text, "mmmm") & " del " & Format(TxtFechaDatos.Text, "yyyy")
End Sub
Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
    Select Case Button.Index
        Case 1
            Call Informe_LimitesGlobales(VistaPrevia, TxtFechaDatos.Text)
        Case 2
            Call Informe_LimitesGlobales(Impresora, TxtFechaDatos.Text)
        Case 3
            Unload Me
    End Select
End Sub
Private Sub Informe_LimitesGlobales(Via As EmisionVia, Fecha As Date)
    On Error GoTo ErrorImpresion
    
    Call Limpiar_Cristal
    
    BacControlFinanciero.CryFinanciero.Destination = Via
    BacControlFinanciero.CryFinanciero.ReportFileName = gsRPT_Path & "Informe_Diario_Ventas_Cartera_Permanente.rpt"
    BacControlFinanciero.CryFinanciero.StoredProcParam(0) = Format(Fecha, "yyyy-mm-dd 00:00:00.000")
    BacControlFinanciero.CryFinanciero.StoredProcParam(1) = gsBAC_User
    BacControlFinanciero.CryFinanciero.Connect = swConeccion
    BacControlFinanciero.CryFinanciero.Action = 1
Exit Sub
ErrorImpresion:
    MsgBox Err.Description, vbExclamation, TITSISTEMA
End Sub
