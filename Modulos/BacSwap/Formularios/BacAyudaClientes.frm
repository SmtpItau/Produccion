VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form BacAyudaClientes 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Ayuda de Clientes de BacSwap."
   ClientHeight    =   5070
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   5055
   LinkTopic       =   "Form2"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   5070
   ScaleWidth      =   5055
   StartUpPosition =   2  'CenterScreen
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   5055
      _ExtentX        =   8916
      _ExtentY        =   794
      ButtonWidth     =   1879
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      Style           =   1
      TextAlignment   =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Aceptar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Volcer"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   3450
         Top             =   -15
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
               Picture         =   "BacAyudaClientes.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacAyudaClientes.frx":0EDA
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame Frame1 
      Height          =   4680
      Left            =   45
      TabIndex        =   1
      Top             =   375
      Width           =   4995
      Begin VB.ListBox LSTNombres 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   4155
         Left            =   45
         TabIndex        =   4
         Top             =   465
         Width           =   4875
      End
      Begin VB.TextBox TXTBuscar 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   300
         Left            =   975
         TabIndex        =   3
         Text            =   "Text1"
         Top             =   150
         Width           =   3945
      End
      Begin VB.Label LblEtiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Buscar ..."
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   105
         TabIndex        =   2
         Top             =   180
         Width           =   750
      End
   End
End
Attribute VB_Name = "BacAyudaClientes"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public Enum MiAyuda
   [CLIENTES] = 0
End Enum
Public QueAyuda   As MiAyuda

Private Sub Form_Load()
   Let Icon = BACSwap.Icon
   Let TXTBuscar.Text = ""
   
   Let giAceptar = False
   If QueAyuda = CLIENTES Then
      Call CARGA_CLIENTES
   End If

End Sub

Private Sub LSTNombres_DblClick()
   Call Aceptar
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 2
         Call Aceptar
      Case 3
         Unload Me
   End Select
End Sub

Private Sub TXTBuscar_Change()
   Dim nContador  As Long
   
   If LSTNombres.ListCount = 0 Then
      Exit Sub
   End If
   
   For nContador = 0 To LSTNombres.ListCount - 1
      If Mid(LSTNombres.List(nContador), 1, Len(TXTBuscar.Text)) = TXTBuscar.Text Then
         LSTNombres.ListIndex = nContador
         Exit For
      End If
   Next nContador
End Sub

Private Sub TXTBuscar_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      Call Aceptar
   End If
End Sub

Private Sub TXTBuscar_KeyPress(KeyAscii As Integer)
   Let KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub

Private Function Aceptar()

   If LSTNombres.ListIndex = -1 Then
      Exit Function
   End If

   If QueAyuda = CLIENTES Then
      Let giAceptar = True
      gsNombre = Trim(Mid(LSTNombres.List(LSTNombres.ListIndex), 1, 100))
      gsCodCli = LSTNombres.ItemData(LSTNombres.ListIndex)
      gsCodigo = Trim(Mid(LSTNombres.List(LSTNombres.ListIndex), 100))
      gsDigito = Mid(gsCodigo, Len(gsCodigo), 1)
      gsCodigo = Mid(gsCodigo, 1, Len(gsCodigo) - 2)
   End If
   Unload Me
End Function

Private Function CARGA_CLIENTES()
   Dim SqlDatos()
   
   If Not Bac_Sql_Execute("dbo.SP_LEER_DATOS_CLIENTES") Then
      Exit Function
   End If
   Call LSTNombres.Clear
   Do While Bac_SQL_Fetch(SqlDatos())
      LSTNombres.AddItem SqlDatos(1) & Space(100) & Trim(SqlDatos(2)) & "-" & Trim(SqlDatos(3))
      LSTNombres.ItemData(LSTNombres.NewIndex) = SqlDatos(4)
   Loop

End Function
