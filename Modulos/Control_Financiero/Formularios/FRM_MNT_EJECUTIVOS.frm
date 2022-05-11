VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form FRM_MNT_EJECUTIVOS 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantención de Ejecutivos"
   ClientHeight    =   5250
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   5790
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5250
   ScaleWidth      =   5790
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   5790
      _ExtentX        =   10213
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
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   6975
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
            Picture         =   "FRM_MNT_EJECUTIVOS.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_EJECUTIVOS.frx":0EDA
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_EJECUTIVOS.frx":1DB4
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.Frame Frame2 
      Height          =   4875
      Left            =   45
      TabIndex        =   1
      Top             =   375
      Width           =   5715
      Begin VB.TextBox TXTNombre 
         BackColor       =   &H80000002&
         BorderStyle     =   0  'None
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000009&
         Height          =   195
         Left            =   1095
         TabIndex        =   3
         Top             =   450
         Visible         =   0   'False
         Width           =   885
      End
      Begin MSFlexGridLib.MSFlexGrid Grilla 
         Height          =   4710
         Left            =   30
         TabIndex        =   2
         Top             =   120
         Width           =   5655
         _ExtentX        =   9975
         _ExtentY        =   8308
         _Version        =   393216
         FixedCols       =   0
         BackColor       =   -2147483633
         ForeColor       =   -2147483641
         BackColorFixed  =   -2147483646
         ForeColorFixed  =   -2147483639
         BackColorBkg    =   -2147483636
         GridColor       =   -2147483633
         GridColorFixed  =   -2147483642
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
   End
End
Attribute VB_Name = "FRM_MNT_EJECUTIVOS"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Function FuncSettingGrid()
   Grilla.Rows = 2:        Grilla.Cols = 2
   Grilla.FixedRows = 1:   Grilla.FixedCols = 0
   
   Grilla.TextMatrix(0, 0) = "Codigo":             Grilla.ColWidth(0) = 0
   Grilla.TextMatrix(0, 1) = "Nombre Ejecutivo":   Grilla.ColWidth(1) = 5000
End Function

Private Function FuncLoadEjecutivos()
   Dim SQLDatos()
   
   Envia = Array()
   AddParam Envia, CDbl(1)
   If Not Bac_Sql_Execute("BacParamSuda.dbo.SP_MNT_EJECUTIVOS", Envia) Then
      Exit Function
   End If
   Grilla.Rows = 1
   Do While Bac_SQL_Fetch(SQLDatos())
      Grilla.Rows = Grilla.Rows + 1
      Grilla.TextMatrix(Grilla.Rows - 1, 0) = SQLDatos(1)
      Grilla.TextMatrix(Grilla.Rows - 1, 1) = SQLDatos(2)
   Loop
End Function

Private Function FuncSettingGenFolio() As Long
   Dim SQLDatos()
   
   Envia = Array()
   AddParam Envia, CDbl(2)
   If Not Bac_Sql_Execute("BacParamSuda.dbo.SP_MNT_EJECUTIVOS", Envia) Then
      Exit Function
   End If
   If Bac_SQL_Fetch(SQLDatos()) Then
      FuncSettingGenFolio = SQLDatos(1)
   End If
End Function

Private Function FuncSettingDropFolio() As Long
   Dim SQLDatos()
   
   Envia = Array()
   AddParam Envia, CDbl(4)
   If Not Bac_Sql_Execute("BacParamSuda.dbo.SP_MNT_EJECUTIVOS", Envia) Then
      Exit Function
   End If
End Function

Private Function FuncDropEjecutivo() As Long
   Dim SQLDatos()

   Envia = Array()
   AddParam Envia, CDbl(5)
   AddParam Envia, CDbl(Grilla.TextMatrix(Grilla.RowSel, 0))
   If Not Bac_Sql_Execute("BacParamSuda.dbo.SP_MNT_EJECUTIVOS", Envia) Then
      Exit Function
   End If
   If Bac_SQL_Fetch(SQLDatos()) Then
      If SQLDatos(1) < 0 Then
         Call MsgBox(SQLDatos(2), vbExclamation, App.Title)
         Call Grilla.SetFocus
         Exit Function
      End If
   End If

   Call Grilla.RemoveItem(Grilla.RowSel)

End Function


Private Function FuncSaveEjecutivos()
   Dim nContador  As Long
   Dim SQLDatos()

   For nContador = 1 To Grilla.Rows - 1
      Envia = Array()
      AddParam Envia, CDbl(3)
      AddParam Envia, CDbl(Grilla.TextMatrix(nContador, 0))
      AddParam Envia, Trim(Grilla.TextMatrix(nContador, 1))
      If Not Bac_Sql_Execute("BacParamSuda.dbo.SP_MNT_EJECUTIVOS", Envia) Then
         Exit Function
      End If
   Next nContador

   Call FuncSettingDropFolio

   Call MsgBox("Actualización de Ejecutivos ha finalizado correctamente.", vbInformation, App.Title)

   Call FuncLoadEjecutivos
End Function

Private Sub FuncCentrarObjetos(Marco As MSFlexGrid, Objeto As Control)
   On Error Resume Next
   Let Objeto.top = Marco.CellTop + Marco.top
   Let Objeto.Left = Marco.CellLeft + Marco.Left + 10
   Let Objeto.Height = Marco.CellHeight + 20
   Let Objeto.Width = Marco.CellWidth
   On Error GoTo 0
End Sub

Private Sub Form_Load()
   Me.top = 0: Me.Left = 0
   Me.Icon = BacControlFinanciero.Icon

   Call FuncSettingGrid
   Call FuncLoadEjecutivos
End Sub

Private Sub Form_Unload(Cancel As Integer)
   Call FuncSettingDropFolio
End Sub

Private Sub Grilla_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn And Grilla.ColSel = 1 Then
      Call FuncCentrarObjetos(Grilla, TXTNombre)
      TXTNombre.Text = Grilla.TextMatrix(Grilla.RowSel, Grilla.ColSel)
      TXTNombre.Visible = True
      Call TXTNombre.SetFocus
      Grilla.Enabled = False
      Toolbar1.Enabled = False
   End If

   If KeyCode = vbKeyInsert Then
      Grilla.Rows = Grilla.Rows + 1
   End If

   If KeyCode = vbKeyDelete Then
      Call FuncDropEjecutivo
   End If

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 2
         Call FuncLoadEjecutivos
      Case 3
         Call FuncSaveEjecutivos
      Case 4
         Call Unload(Me)
   End Select
End Sub

Private Sub TXTNombre_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      Grilla.TextMatrix(Grilla.RowSel, 1) = TXTNombre.Text
      Grilla.TextMatrix(Grilla.RowSel, 0) = FuncSettingGenFolio
      Grilla.Enabled = True
      Toolbar1.Enabled = True
      Grilla.SetFocus
      TXTNombre.Visible = False
   End If
   If KeyCode = vbKeyEscape Then
      Grilla.Enabled = True
      Toolbar1.Enabled = True
      Grilla.SetFocus
      TXTNombre.Visible = False
   End If
End Sub

Private Sub TXTNombre_KeyPress(KeyAscii As Integer)
   KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub
