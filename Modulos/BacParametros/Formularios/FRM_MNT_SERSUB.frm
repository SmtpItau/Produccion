VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form FRM_MNT_SERSUB 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Ingreso de Series Subyacentes.-"
   ClientHeight    =   3270
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   6465
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   3270
   ScaleWidth      =   6465
   Begin MSFlexGridLib.MSFlexGrid Grid 
      Height          =   2145
      Left            =   30
      TabIndex        =   4
      Top             =   1110
      Width           =   6420
      _ExtentX        =   11324
      _ExtentY        =   3784
      _Version        =   393216
      FixedCols       =   0
      BackColor       =   -2147483644
      ForeColor       =   -2147483641
      BackColorFixed  =   -2147483646
      ForeColorFixed  =   -2147483639
      BackColorBkg    =   -2147483645
      GridColor       =   -2147483648
      GridColorFixed  =   -2147483640
      FocusRect       =   0
      GridLines       =   2
      GridLinesFixed  =   0
      AllowUserResizing=   2
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   6465
      _ExtentX        =   11404
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Cerrar"
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   4485
         Top             =   165
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   4
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_SERSUB.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_SERSUB.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_SERSUB.frx":1DB4
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_SERSUB.frx":20CE
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame Frame1 
      Height          =   645
      Left            =   15
      TabIndex        =   1
      Top             =   435
      Width           =   6450
      Begin VB.TextBox txtSerie 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   1170
         MaxLength       =   20
         TabIndex        =   3
         Top             =   210
         Width           =   1440
      End
      Begin VB.Label lblInGlosa 
         Alignment       =   2  'Center
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Height          =   315
         Left            =   2625
         TabIndex        =   5
         Top             =   210
         Width           =   3750
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Instrumento"
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
         Left            =   75
         TabIndex        =   2
         Top             =   270
         Width           =   1035
      End
   End
End
Attribute VB_Name = "FRM_MNT_SERSUB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit


Private Sub Form_Load()
   Me.Top = 0: Me.Left = 0
   Me.Icon = BACSwapParametros.Icon
   
   Grid.TextMatrix(0, 0) = "Codigo"
   Grid.TextMatrix(0, 1) = "Series"
   Grid.ColWidth(0) = 1000
   Grid.ColWidth(1) = 3000
   
   Call CargarLista
   
End Sub

Private Function ValidarSerie(xSerie As String) As Boolean
   ValidarSerie = False
   
   Envia = Array()
   AddParam Envia, Trim(Mid(xSerie, 1, 12))
   If Not Bac_Sql_Execute("bactradersuda..SP_CHKINSTSER", Envia) Then
      Screen.MousePointer = 0
      MsgBox "¡ La serie ingresada no es valida, o bién no ha sido registrada en Tabla de Series. !", vbExclamation, TITSISTEMA
      Exit Function
   End If
   If Bac_SQL_Fetch(datos()) Then
      If Val(datos(1)) = 0 Then
         ValidarSerie = True
         lblInGlosa.Tag = datos(3)
         lblInGlosa.Caption = datos(4) & " - " & datos(12) & " -- " & datos(13)
      Else
         MsgBox "¡ La serie ingresada no es valida, o bién no ha sido registrada en Tabla de Series. !", vbExclamation, TITSISTEMA
      End If
   End If
End Function

Private Sub CargarLista()
   Dim datos()
   
   Envia = Array()
   AddParam Envia, CDbl(1)
   AddParam Envia, Trim(txtSerie.Text)
   AddParam Envia, 0
   If Not Bac_Sql_Execute("bacfwdsuda..SP_MNT_SERIES_SUBYACENTES", Envia) Then
      MsgBox "Se ha producido un error en la Busqueda de información", vbExclamation, TITSISTEMA
      Exit Sub
   End If
   Grid.Rows = 1
   Do While Bac_SQL_Fetch(datos())
      Grid.Rows = Grid.Rows + 1
      Grid.TextMatrix(Grid.Rows - 1, 0) = datos(1)
      Grid.TextMatrix(Grid.Rows - 1, 1) = datos(2)
   Loop
End Sub

Private Sub Buscar()
   Dim datos()
   
   Envia = Array()
   AddParam Envia, CDbl(1)
   AddParam Envia, ""
   AddParam Envia, 0
   If Not Bac_Sql_Execute("bacfwdsuda..SP_MNT_SERIES_SUBYACENTES", Envia) Then
      MsgBox "Se ha producido un error en la Busqueda de información", vbExclamation, TITSISTEMA
      Exit Sub
   End If
   Grid.Rows = 1
   Do While Bac_SQL_Fetch(datos())
      Grid.Rows = Grid.Rows + 1
      Grid.TextMatrix(Grid.Rows - 1, 0) = datos(1)
      Grid.TextMatrix(Grid.Rows - 1, 1) = datos(2)
   Loop
   txtSerie.Text = ""
   lblInGlosa.Caption = ""

End Sub


Private Sub Grabar()
   Dim datos()
   
   Envia = Array()
   AddParam Envia, CDbl(2)
   AddParam Envia, Trim(txtSerie.Text)
   AddParam Envia, Val(lblInGlosa.Tag)
   If Not Bac_Sql_Execute("bacfwdsuda..SP_MNT_SERIES_SUBYACENTES", Envia) Then
      MsgBox "Se ha producido un error en la Grabación de información", vbExclamation, TITSISTEMA
      Exit Sub
   End If
   Call Buscar
   MsgBox "Grabación de Información ha finalizado Correctamente.", vbInformation, TITSISTEMA
   
End Sub

Private Sub Eliminar()
   Dim datos()
   
   Envia = Array()
   AddParam Envia, CDbl(3)
   AddParam Envia, Trim(txtSerie.Text)
   AddParam Envia, Val(lblInGlosa.Tag)
   If Not Bac_Sql_Execute("bacfwdsuda..SP_MNT_SERIES_SUBYACENTES", Envia) Then
      MsgBox "Se ha producido un error en la Eliminación de información", vbExclamation, TITSISTEMA
      Exit Sub
   End If
   Call Buscar
   MsgBox "Eliminación de Información ha finalizado Correctamente.", vbInformation, TITSISTEMA
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 1
         Call CargarLista
      Case 2
         Call Grabar
      Case 3
         Call Eliminar
      Case 4
         Unload Me
   End Select
End Sub

Private Sub txtSerie_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      If ValidarSerie(UCase(txtSerie.Text)) = False Then
         txtSerie.Text = ""
         lblInGlosa.Caption = ""
         Toolbar1.Buttons(2).Enabled = False
      Else
         Toolbar1.Buttons(2).Enabled = True
      End If
   End If
End Sub

Private Sub txtSerie_KeyPress(KeyAscii As Integer)
   KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub

Private Sub Limpiar()
   txtSerie.Text = ""
   lblInGlosa.Caption = ""
End Sub
