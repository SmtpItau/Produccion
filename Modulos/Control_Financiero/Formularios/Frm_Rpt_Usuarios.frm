VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Begin VB.Form Frm_Rpt_Usuarios 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Form2"
   ClientHeight    =   1125
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   5175
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   1125
   ScaleWidth      =   5175
   Begin VB.ComboBox cmbTipOpe 
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
      Height          =   315
      Left            =   1290
      Style           =   2  'Dropdown List
      TabIndex        =   1
      Top             =   630
      Width           =   3540
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   5175
      _ExtentX        =   9128
      _ExtentY        =   847
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Imprimir"
            Object.ToolTipText     =   "Imprimir"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Preliminar"
            Object.ToolTipText     =   "Vista Previa"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   4170
         Top             =   -105
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   24
         ImageHeight     =   24
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   3
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Rpt_Usuarios.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Rpt_Usuarios.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Frm_Rpt_Usuarios.frx":11F4
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      Caption         =   "Operador"
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
      Height          =   375
      Left            =   195
      TabIndex        =   2
      Top             =   660
      Width           =   795
   End
End
Attribute VB_Name = "Frm_Rpt_Usuarios"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub Form_Load()
Me.Top = 0
Me.Left = 0
Me.Icon = BacControlFinanciero.Icon
Me.Caption = "Reporte de Atribución por Operador"

Call CargarCombos

End Sub


Sub CargarCombos()

    Dim Datos()
    Dim Espacio0 As Integer
    Dim Espacio1 As Integer
    Dim Espacio2 As Integer
    cmbTipOpe.Clear
    
    If Not Bac_Sql_Execute("SP_BACMATRIZATRIBUCIONES_LEEGENUSUARIO") Then
        Exit Sub
    End If
    
    Do While Bac_SQL_Fetch(Datos())
        cmbTipOpe.AddItem (Datos(2) & Space(100) & Datos(1))
    Loop
    
  
   cmbTipOpe.Enabled = True
   cmbTipOpe.ListIndex = IIf(cmbTipOpe.ListCount = 0, -1, 0)
    
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

Select Case UCase(Button.Index)
     Case 1, 2
            
            Call Limpiar_Cristal
            
            If Button.Index = 1 Then
                BacControlFinanciero.CryFinanciero.Destination = 1
            Else
                BacControlFinanciero.CryFinanciero.Destination = 0
            End If
            
            BacControlFinanciero.CryFinanciero.ReportFileName = gsRPT_Path & "rptatroper.rpt"
            BacControlFinanciero.CryFinanciero.StoredProcParam(0) = Trim(Right(cmbTipOpe, 20))
            BacControlFinanciero.CryFinanciero.Connect = swConeccion
            BacControlFinanciero.CryFinanciero.Action = 1
                       
    Case 3
        Unload Me
End Select

End Sub
