VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Begin VB.Form FRM_MNT_ROLES 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Ingreso de Roles"
   ClientHeight    =   6780
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   7575
   LinkTopic       =   "Form2"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   6780
   ScaleWidth      =   7575
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   4
      Top             =   0
      Width           =   7575
      _ExtentX        =   13361
      _ExtentY        =   794
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar / Actualizar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Cerrar"
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   4470
         Top             =   15
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   5
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_ROLES.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_ROLES.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_ROLES.frx":1DB4
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_ROLES.frx":20CE
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_ROLES.frx":2FA8
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame Frame1 
      Height          =   6390
      Left            =   30
      TabIndex        =   5
      Top             =   375
      Width           =   7515
      Begin VB.ComboBox CmbUsuario 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   975
         TabIndex        =   1
         Text            =   "CmbUsuario"
         Top             =   495
         Width           =   4005
      End
      Begin VB.TextBox TxtEmail 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   975
         TabIndex        =   2
         Text            =   "Text1"
         Top             =   825
         Width           =   4020
      End
      Begin VB.ComboBox CmbRol 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   975
         Style           =   2  'Dropdown List
         TabIndex        =   0
         Top             =   165
         Width           =   4005
      End
      Begin MSFlexGridLib.MSFlexGrid GRID 
         Height          =   4950
         Left            =   45
         TabIndex        =   3
         Top             =   1185
         Width           =   7425
         _ExtentX        =   13097
         _ExtentY        =   8731
         _Version        =   393216
         Cols            =   3
         FixedCols       =   0
         BackColor       =   -2147483633
         BackColorFixed  =   -2147483646
         ForeColorFixed  =   -2147483639
         BackColorBkg    =   -2147483636
         FocusRect       =   0
         GridLines       =   2
         GridLinesFixed  =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin VB.Label LblEtiqueta 
         AutoSize        =   -1  'True
         Caption         =   "E-Mail"
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
         Index           =   2
         Left            =   150
         TabIndex        =   8
         Top             =   870
         Width           =   510
      End
      Begin VB.Label LblEtiqueta 
         AutoSize        =   -1  'True
         Caption         =   "Usuario"
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
         Index           =   1
         Left            =   150
         TabIndex        =   7
         Top             =   540
         Width           =   645
      End
      Begin VB.Label LblEtiqueta 
         AutoSize        =   -1  'True
         Caption         =   "Rol"
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
         Index           =   0
         Left            =   150
         TabIndex        =   6
         Top             =   225
         Width           =   270
      End
   End
End
Attribute VB_Name = "FRM_MNT_ROLES"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Function SETTING_GRID()
   Let GRID.Rows = 2:         Let GRID.Cols = 3
   Let GRID.FixedRows = 1:    Let GRID.FixedCols = 0

   Let GRID.TextMatrix(0, 0) = "Rol":        Let GRID.ColWidth(0) = 2000
   Let GRID.TextMatrix(0, 1) = "Usuario":    Let GRID.ColWidth(1) = 2500
   Let GRID.TextMatrix(0, 2) = "E-mail":     Let GRID.ColWidth(2) = 2500
End Function

Private Sub LOAD_ROLES()
   Dim Datos()

   If Not Bac_Sql_Execute("dbo.SP_LEER_ROLES") Then
      Call MsgBox("Se ha generado un error en la Carga de Roles.", vbExclamation, App.Title)
      Exit Sub
   End If
   CmbRol.Clear
   Do While Bac_SQL_Fetch(Datos())
      CmbRol.AddItem Datos(2)
      CmbRol.ItemData(CmbRol.NewIndex) = Datos(1)
   Loop
End Sub

Private Sub LOAD_USUARIOS()
   Dim Datos()

   If Not Bac_Sql_Execute("dbo.SP_LEER_USUARIOS_ROLES") Then
      Call MsgBox("Se ha generado un error en la Carga de Usuarios.", vbExclamation, App.Title)
      Exit Sub
   End If
   CmbUsuario.Clear
   Do While Bac_SQL_Fetch(Datos())
      CmbUsuario.AddItem Datos(1)
   Loop
End Sub

Private Function CLEAR_OBJECTS()
   Let TxtEmail.Text = ""

   Call LOAD_ROLES
   Call LOAD_USUARIOS
   Call LOAD_MENSAJES
End Function

Private Sub CmbRol_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      Call FUNC_CONTROL_INGRESO
      Call CmbUsuario.SetFocus
   End If
End Sub

Private Sub CmbUsuario_KeyPress(KeyAscii As Integer)
   Let KeyAscii = Asc(UCase(Chr(KeyAscii)))
   If KeyAscii = vbKeyReturn Then
      Call FUNC_CONTROL_INGRESO
      Call TxtEmail.SetFocus
   End If
End Sub

Private Sub Form_Load()
   Let Me.Top = 0:   Let Me.Left = 0
   Let Me.Icon = BACSwapParametros.Icon
   Let Me.Caption = "Configuración de Email por rol de usuario."

   Call SETTING_GRID
   Call CLEAR_OBJECTS
   Call LOAD_MENSAJES
End Sub

Private Sub GRID_DblClick()
   On Error Resume Next
   Let CmbRol.Text = Trim(Left(GRID.TextMatrix(GRID.RowSel, 1), 50))
   Let CmbUsuario.Text = GRID.TextMatrix(GRID.RowSel, 0)
   Let TxtEmail.Text = GRID.TextMatrix(GRID.RowSel, 2)
   On Error GoTo 0
End Sub

Private Sub GRID_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyDelete Then
      Call DEL_MENSAJE
   End If
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 2
         Call CLEAR_OBJECTS
      Case 3
         Call FUNC_CONTROL_INGRESO
      Case 4
         Call DEL_MENSAJE(True)
      Case 5
         Call Unload(Me)
   End Select
End Sub

Private Sub Txtemail_KeyPress(KeyAscii As Integer)
   Let KeyAscii = Asc(LCase(Chr(KeyAscii)))
   
   If KeyAscii = vbKeyReturn Then
      Call FUNC_CONTROL_INGRESO
      Call CmbRol.SetFocus
   End If
End Sub

Private Function FUNC_CONTROL_INGRESO()
   If CmbRol.ListIndex < 0 Then
      Exit Function
   End If
   If Len(CmbUsuario.Text) <= 0 Then
      Exit Function
   End If
   If Len(TxtEmail.Text) <= 0 Then
      Exit Function
   End If

   Envia = Array()
   AddParam Envia, CDbl(0)
   AddParam Envia, CmbUsuario.Text
   AddParam Envia, CmbRol.ItemData(CmbRol.ListIndex)
   AddParam Envia, TxtEmail.Text
   If Not Bac_Sql_Execute("dbo.SP_CARGA_TABLA_ROLES", Envia) Then
      Call MsgBox("Se ha generado un error en la actualización de Roles.", vbExclamation, App.Title)
      Exit Function
   End If

   Call LOAD_MENSAJES
   Call CLEAR_OBJECTS
End Function

Private Sub LOAD_MENSAJES()
   Dim Datos()
   
   Envia = Array()
   AddParam Envia, CDbl(2)
   If Not Bac_Sql_Execute("dbo.SP_CARGA_TABLA_ROLES", Envia) Then
      Call MsgBox("Se ha generado un error en la lectura de Roles.", vbExclamation, App.Title)
      Exit Sub
   End If
   Let GRID.Redraw = False
   Let GRID.Rows = 1
   Do While Bac_SQL_Fetch(Datos())
      Let GRID.Rows = GRID.Rows + 1
      Let GRID.TextMatrix(GRID.Rows - 1, 0) = Datos(1)
      Let GRID.TextMatrix(GRID.Rows - 1, 1) = Datos(2)
      Let GRID.TextMatrix(GRID.Rows - 1, 2) = Datos(3)
   Loop
   Let GRID.Redraw = True

End Sub

Private Sub DEL_MENSAJE(Optional bTool As Boolean)
   Dim Datos()
   
   If MsgBox(" ¿ Esta seguro de elimiar el registro ?", vbQuestion + vbYesNo, App.Title) = vbNo Then
      Exit Sub
   End If
   
   If bTool = False Then
      If Len(Trim(GRID.TextMatrix(GRID.RowSel, 0))) = 0 Then
         Exit Sub
      End If
      
      Envia = Array()
      AddParam Envia, CDbl(1)
      AddParam Envia, GRID.TextMatrix(GRID.RowSel, 0)
      If Not Bac_Sql_Execute("dbo.SP_CARGA_TABLA_ROLES", Envia) Then
         Call MsgBox("Se ha generado un error en la lectura de Roles.", vbExclamation, App.Title)
         Exit Sub
      End If
   
      Call LOAD_MENSAJES
   End If
   
   If bTool = True Then
      
      If Len(CmbUsuario.Text) = 0 Then
         Exit Sub
      End If
      
      Envia = Array()
      AddParam Envia, CDbl(1)
      AddParam Envia, CmbUsuario.Text
      If Not Bac_Sql_Execute("dbo.SP_CARGA_TABLA_ROLES", Envia) Then
         Call MsgBox("Se ha generado un error en la lectura de Roles.", vbExclamation, App.Title)
         Exit Sub
      End If
   
      Call LOAD_MENSAJES
   End If
   
   Call CLEAR_OBJECTS
End Sub
