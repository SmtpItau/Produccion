VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacIniBlo 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Informe"
   ClientHeight    =   1095
   ClientLeft      =   2685
   ClientTop       =   2085
   ClientWidth     =   3525
   BeginProperty Font 
      Name            =   "MS Sans Serif"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   ForeColor       =   &H00C0C0C0&
   Icon            =   "Bacblo.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Moveable        =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   1095
   ScaleWidth      =   3525
   ShowInTaskbar   =   0   'False
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   2940
      Top             =   15
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   1
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacblo.frx":030A
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.Frame Frame1 
      ForeColor       =   &H00800000&
      Height          =   570
      Left            =   0
      TabIndex        =   2
      Top             =   525
      Width           =   3525
      Begin BACControles.TXTFecha txtFechaProceso 
         Height          =   315
         Left            =   2055
         TabIndex        =   3
         Top             =   180
         Width           =   1335
         _ExtentX        =   2355
         _ExtentY        =   556
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
         Text            =   "09/04/2001"
      End
      Begin VB.Label Label1 
         Caption         =   "Fecha de Proceso"
         ForeColor       =   &H00800000&
         Height          =   270
         Left            =   135
         TabIndex        =   4
         Top             =   255
         Width           =   2055
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Height          =   510
      Left            =   0
      TabIndex        =   1
      Top             =   15
      Width           =   3525
      _ExtentX        =   6218
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbgenerainforme"
            Description     =   "GENERAINFORME"
            Object.ToolTipText     =   "Generar Informe"
            ImageIndex      =   1
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin Threed.SSCommand CmdAceptar 
      Height          =   465
      Left            =   0
      TabIndex        =   0
      Top             =   1815
      Width           =   1755
      _Version        =   65536
      _ExtentX        =   3096
      _ExtentY        =   820
      _StockProps     =   78
      Caption         =   "&Generar Informe"
      ForeColor       =   8388608
      Font3D          =   3
   End
End
Attribute VB_Name = "BacIniBlo"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub cmdAceptar_Click()
 
' giAceptar% = True
' xFecha = txtFechaProceso.Text
' Unload Me
'
End Sub

Private Sub Form_Load()
Dim Datos()

    giAceptar% = False

'Sql = ""
'Sql = " SP_LEEFECPRO "

    If Bac_Sql_Execute("SP_LEEFECPRO") Then
        If Bac_SQL_Fetch(Datos()) Then
            txtFechaProceso.Text = Format(CDate(Datos(1)), "DD/MM/YYYY")
        End If
    Else
        MsgBox "Proceso " & Sql & "No Existe", vbOKOnly + vbCritical, gsBac_Version
        Unload Me
    End If

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case UCase(Button.Description)
Case "GENERAINFORME"
    giAceptar% = True
    xFecha = txtFechaProceso.Text
    Unload Me
End Select
End Sub

