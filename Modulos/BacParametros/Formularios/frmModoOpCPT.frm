VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form frmModoOpCPT 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Modo Operación Control Precios y Tasas"
   ClientHeight    =   1830
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4065
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   1830
   ScaleWidth      =   4065
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   540
      Left            =   0
      TabIndex        =   3
      Top             =   0
      Width           =   4065
      _ExtentX        =   7170
      _ExtentY        =   953
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      DisabledImageList=   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Limpiar"
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Grabar"
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   4
         EndProperty
      EndProperty
   End
   Begin VB.Frame Frame1 
      Caption         =   "Seleccione Modo de Operación"
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
      Height          =   855
      Left            =   120
      TabIndex        =   0
      Top             =   840
      Width           =   3855
      Begin VB.OptionButton optSilencioso 
         Caption         =   "Silencioso"
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
         Height          =   255
         Left            =   2280
         TabIndex        =   2
         Top             =   360
         Width           =   1215
      End
      Begin VB.OptionButton optNormal 
         Caption         =   "Normal"
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
         Height          =   255
         Left            =   240
         TabIndex        =   1
         Top             =   360
         Width           =   1095
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   3480
      Top             =   360
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
            Picture         =   "frmModoOpCPT.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmModoOpCPT.frx":0EDA
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmModoOpCPT.frx":1DB4
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmModoOpCPT.frx":2C8E
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "frmModoOpCPT"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Form_Load()
Dim modoOp As String
Me.Top = 0
Me.Left = 0
Me.Icon = BACSwapParametros.Icon

modoOp = "N"
modoOp = ModoOperacion()
Select Case modoOp
    Case "N"
        optNormal.Value = True
    Case "S"
        optSilencioso.Value = True
    Case Else
        optNormal.Value = True
End Select
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index
    Case 1  'Limpiar
        optNormal.Value = False
        optSilencioso.Value = False
    Case 2  'Grabar
        Call Grabar
    Case 3  'Salir
        Unload Me
End Select
End Sub
Private Function Grabar() As Boolean
If optNormal.Value = False And optSilencioso.Value = False Then
    MsgBox "No ha seleccionado el Modo de Operación del Control!", vbExclamation, TITSISTEMA
    Grabar = False
    Exit Function
End If
Dim modo As String
Dim sp As String
If optNormal.Value = True Then
    modo = "N"
Else
    modo = "S"
End If
sp = "Bacparamsuda.dbo.SP_GRABAMODOCONTROLPRECIOSTASAS"
Dim Datos()
Envia = Array()
AddParam Envia, modo
If Not Bac_Sql_Execute(sp, Envia) Then
    MsgBox "Se ha producido un error al grabar el modo de Operación del Control!", vbCritical, TITSISTEMA
    Grabar = False
    Exit Function
End If
Grabar = True
MsgBox "El modo de operación del control ha sido grabado en forma exitosa.", vbInformation, TITSISTEMA
End Function
Private Function ModoOperacion() As String
Dim nomSp As String
Dim DATOS()
Envia = Array()
nomSp = "Bacparamsuda.dbo.sp_RETMODOCONTROLPRECIOSTASAS"
If Not Bac_Sql_Execute(nomSp) Then
    Exit Function
End If
Do While Bac_SQL_Fetch(DATOS())
    ModoOperacion = UCase(DATOS(1))
    Exit Do
Loop
End Function
