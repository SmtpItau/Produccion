VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Begin VB.Form FRM_ProcCoberturas 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Proceso de Actualización"
   ClientHeight    =   1020
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4920
   FillColor       =   &H8000000E&
   BeginProperty Font 
      Name            =   "Courier New"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   ForeColor       =   &H8000000D&
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1020
   ScaleWidth      =   4920
   StartUpPosition =   2  'CenterScreen
   Begin Threed.SSPanel Progress 
      Height          =   510
      Left            =   0
      TabIndex        =   1
      Top             =   510
      Width           =   4920
      _Version        =   65536
      _ExtentX        =   8678
      _ExtentY        =   900
      _StockProps     =   15
      ForeColor       =   -2147483634
      BackColor       =   13160660
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BorderWidth     =   2
      BevelInner      =   1
      FloodType       =   1
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   4920
      _ExtentX        =   8678
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
            Key             =   "Proceso"
            Object.ToolTipText     =   "Actualización de Coberturas"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Cerrar"
            Object.ToolTipText     =   "Cerrar"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   3750
         Top             =   0
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   2
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ProcCoberturas.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ProcCoberturas.frx":0EDA
               Key             =   ""
            EndProperty
         EndProperty
      End
      Begin VB.Timer Timer1 
         Interval        =   500
         Left            =   3810
         Top             =   60
      End
   End
End
Attribute VB_Name = "FRM_ProcCoberturas"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Form_Load()
   Me.Icon = BacControlFinanciero.Icon
   MiSwitch = False
End Sub

Private Sub ActualizacionCoberturas()
   Screen.MousePointer = vbHourglass
   Progress.FloodPercent = 50
   Call BacControlWindows(50)
   
   Call Bac_Sql_Execute("Bactradersuda.dbo.SP_ACTUALIZACION_COBERTURAS")
   
   Call BacControlWindows(50)
   Progress.FloodPercent = 100
   Screen.MousePointer = vbDefault
   
   MsgBox "Actualización Finalizada Corectamente.", vbInformation, TITSISTEMA
   Progress.FloodPercent = 0
   
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 1
         Call ActualizacionCoberturas
      Case 2
         Unload Me
   End Select
End Sub

