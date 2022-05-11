VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form EstadoProcesos 
   BackColor       =   &H80000004&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Estado de Procesos"
   ClientHeight    =   4815
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4725
   ForeColor       =   &H00C00000&
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   4815
   ScaleWidth      =   4725
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   2
      Top             =   0
      Width           =   4725
      _ExtentX        =   8334
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
            Key             =   "Grabar"
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Limpiar"
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
      MouseIcon       =   "EstadoProcesos.frx":0000
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   4200
      Top             =   0
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
            Picture         =   "EstadoProcesos.frx":031A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "EstadoProcesos.frx":076C
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "EstadoProcesos.frx":0A86
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.ListBox lstProcesos 
      BeginProperty Font 
         Name            =   "Courier New"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   2700
      Left            =   255
      Style           =   1  'Checkbox
      TabIndex        =   1
      Top             =   1635
      Width           =   4215
   End
   Begin VB.ComboBox cmbSistemas 
      BackColor       =   &H00FFFFFF&
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
      Left            =   255
      Style           =   2  'Dropdown List
      TabIndex        =   0
      Top             =   915
      Width           =   4215
   End
   Begin VB.Frame Frame1 
      Height          =   4335
      Left            =   15
      TabIndex        =   4
      Top             =   465
      Width           =   4695
      Begin VB.Label Label3 
         Caption         =   "Procesesos"
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
         TabIndex        =   6
         Top             =   930
         Width           =   1575
      End
      Begin VB.Label Label2 
         Caption         =   "Sistemas"
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
         TabIndex        =   5
         Top             =   240
         Width           =   1455
      End
   End
   Begin VB.Label Label1 
      Caption         =   "Sistemas"
      Height          =   255
      Left            =   0
      TabIndex        =   3
      Top             =   0
      Width           =   1095
   End
End
Attribute VB_Name = "EstadoProcesos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub cmbSistemas_Click()
    
    Dim DATOS()
    Dim Id_Sistema  As String
    Dim X           As Integer
    
    Id_Sistema$ = Right(cmbSistemas, 3)
 
    Envia = Array()
    AddParam Envia, Id_Sistema$
 
    If Not Bac_Sql_Execute("Sp_ControlProcesosLeer", Envia) Then
        MsgBox "No se Pudo Realizar la Consulta.", vbCritical, TITSISTEMA
        Exit Sub
        
    End If
    cmbSistemas.Enabled = False
    lstProcesos.Clear
    Do While Bac_SQL_Fetch(DATOS())
        For X = 1 To UBound(DATOS())
            lstProcesos.AddItem Mid(DATOS(X), 3)
            lstProcesos.Selected(X - 1) = (Mid(DATOS(X), 1, 1) = "1")
        Next
        lstProcesos.Enabled = True
    Loop
End Sub

Private Sub Form_Load()
    Me.Icon = BacTrader.Icon
    Me.Left = 0
    Me.Top = 0
    
    Dim DATOS()
    If Not Bac_Sql_Execute("SP_LEER_SISTAMA_CNT") Then
        MsgBox "Problema al leer Sistemas.", vbInformation, TITSISTEMA
        Exit Sub
    End If
    cmbSistemas.Clear
    Do While Bac_SQL_Fetch(DATOS())
        cmbSistemas.AddItem DATOS(2) & Space(100) & DATOS(1)
    Loop
   Call Limpiar
End Sub


Private Sub GrabarDatos()
   Dim X             As Integer
   Dim Id_Sistema    As String
   Dim sw_procesos   As String
   
   Id_Sistema$ = Right(cmbSistemas, 3)
   sw_procesos = ""
   
   For X = 0 To lstProcesos.ListCount - 1
      sw_procesos = sw_procesos & IIf(lstProcesos.Selected(X) = True, "1", "0")
   Next X
   
   Envia = Array()
   AddParam Envia, Id_Sistema$
   AddParam Envia, sw_procesos
   If Not Bac_Sql_Execute("Sp_ControlProcesosGrabar", Envia) Then
      MsgBox "No se Pudo Realizar la Consulta.", vbCritical, TITSISTEMA
      Exit Sub
        
   End If
 
End Sub


Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Key
      Case Is = "Grabar"
         Call GrabarDatos
      Case Is = "Limpiar"
         Call Limpiar
      Case Else
         Unload Me
   End Select
End Sub


Sub Limpiar()
   
   cmbSistemas.ListIndex = -1
   lstProcesos.Clear
   cmbSistemas.Enabled = True
   lstProcesos.Enabled = False

End Sub
