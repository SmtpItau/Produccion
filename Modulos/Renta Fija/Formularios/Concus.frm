VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form Consulta_Custodia 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Consulta de Custodia Captaciones"
   ClientHeight    =   6105
   ClientLeft      =   225
   ClientTop       =   1740
   ClientWidth     =   11580
   Icon            =   "Concus.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   6105
   ScaleWidth      =   11580
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   495
      Left            =   0
      TabIndex        =   11
      Top             =   0
      Width           =   11580
      _ExtentX        =   20426
      _ExtentY        =   873
      ButtonWidth     =   847
      ButtonHeight    =   820
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbbuscar"
            Description     =   "BUSCAR"
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbcancelar"
            Description     =   "CANCELAR"
            Object.ToolTipText     =   "Cancelar"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin VB.Data Data1 
      Caption         =   "Data1"
      Connect         =   "Access"
      DatabaseName    =   ""
      DefaultCursorType=   0  'DefaultCursor
      DefaultType     =   2  'UseODBC
      Exclusive       =   0   'False
      Height          =   300
      Left            =   615
      Options         =   0
      ReadOnly        =   0   'False
      RecordsetType   =   1  'Dynaset
      RecordSource    =   ""
      Top             =   7005
      Width           =   1155
   End
   Begin Threed.SSFrame SSFrame1 
      Height          =   1020
      Left            =   0
      TabIndex        =   0
      Top             =   450
      Width           =   11460
      _Version        =   65536
      _ExtentX        =   20214
      _ExtentY        =   1799
      _StockProps     =   14
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin VB.ComboBox Cmb_Custodia 
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         ItemData        =   "Concus.frx":030A
         Left            =   1380
         List            =   "Concus.frx":0314
         Style           =   2  'Dropdown List
         TabIndex        =   9
         Top             =   600
         Width           =   1290
      End
      Begin VB.TextBox txtCodigoCliente 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   300
         Left            =   2655
         TabIndex        =   2
         Top             =   210
         Width           =   570
      End
      Begin VB.TextBox txtRutCliente 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   300
         Left            =   1395
         MouseIcon       =   "Concus.frx":0329
         MousePointer    =   99  'Custom
         TabIndex        =   1
         Top             =   210
         Width           =   1245
      End
      Begin VB.Label lblCliente 
         BorderStyle     =   1  'Fixed Single
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
         Height          =   300
         Left            =   3240
         TabIndex        =   7
         Top             =   210
         Width           =   8130
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Custodia"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   240
         Left            =   360
         TabIndex        =   6
         Top             =   630
         Width           =   930
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Cliente"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   240
         Left            =   330
         TabIndex        =   5
         Top             =   240
         Width           =   975
      End
   End
   Begin Threed.SSFrame SSFrame2 
      Height          =   4545
      Left            =   0
      TabIndex        =   8
      Top             =   1410
      Width           =   11460
      _Version        =   65536
      _ExtentX        =   20214
      _ExtentY        =   8017
      _StockProps     =   14
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   8160
         Top             =   3360
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   25
         ImageHeight     =   25
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   2
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Concus.frx":0633
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Concus.frx":0A85
               Key             =   ""
            EndProperty
         EndProperty
      End
      Begin MSFlexGridLib.MSFlexGrid TabCustodia 
         Height          =   3975
         Left            =   120
         TabIndex        =   10
         Top             =   240
         Width           =   11175
         _ExtentX        =   19711
         _ExtentY        =   7011
         _Version        =   393216
         Cols            =   9
         FixedCols       =   0
         BackColor       =   12632256
         ForeColor       =   8388608
         BackColorFixed  =   8421376
         ForeColorFixed  =   16777215
         BackColorBkg    =   12632256
         GridLines       =   2
         SelectionMode   =   1
      End
   End
   Begin Threed.SSCommand BtnBuscar 
      Height          =   450
      Left            =   0
      TabIndex        =   3
      Top             =   6360
      Width           =   1200
      _Version        =   65536
      _ExtentX        =   2117
      _ExtentY        =   794
      _StockProps     =   78
      Caption         =   "&Buscar"
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   3
   End
   Begin Threed.SSCommand BtnCancelar 
      Height          =   450
      Left            =   1215
      TabIndex        =   4
      Top             =   6360
      Width           =   1200
      _Version        =   65536
      _ExtentX        =   2117
      _ExtentY        =   794
      _StockProps     =   78
      Caption         =   "&Cancelar"
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   3
   End
End
Attribute VB_Name = "Consulta_Custodia"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Function Limpiar()
   db.Execute "Delete * from ConCustodia"
   Data1.Refresh
   txtRutCliente.Text = ""
   txtCodigoCliente.Text = ""
   lblCliente.Caption = ""
   txtRutCliente.SetFocus
End Function



Private Sub BtnBuscar_Click()
'If Trim(Cmb_Custodia) = "" Then
'   Exit Sub
'End If
'
'Dim Sql As String
'Dim datos()
'Dim p As Integer
'Dim xCustodia As String
''db.Execute "Delete * from ConCustodia"
''Data1.Refresh
'TabCustodia.Rows = 2
'p = 0
'xCustodia = Mid(Cmb_Custodia.Text, 1, 1)
'Sql = "Sp_Trae_Consulta_Custodia " & Val(txtRutCliente) & ",'" & xCustodia & "'"
'If Bac_SQL_Execute(" ",Envia) = 0 Then
'  Do While Bac_SQL_Fetch(Datos())
'      p = p + 1
''     Sql = "INSERT INTO ConCustodia VALUES(" & Chr(10)
''     Sql = Sql & Datos(1) & "," & Chr(10)
''     Sql = Sql & Datos(2) & "," & Chr(10)
''     Sql = Sql & Datos(3) & "," & Chr(10)
''     Sql = Sql & Datos(4) & "," & Chr(10)
''     Sql = Sql & Datos(5) & "," & Chr(10)
''     Sql = Sql & "'" & Datos(6) & "'," & Chr(10)
''     Sql = Sql & "'" & Datos(7) & "'," & Chr(10)
''     Sql = Sql & "'" & Datos(8) & "'," & Chr(10)
''     Sql = Sql & "'" & Datos(9) & "'," & Chr(10)
''     Sql = Sql & Val(Datos(10)) & ")"
''     db.Execute Sql
'
'      With TabCustodia
'      .TextMatrix(.Row, 0) = Format(datos(2), "#,##0")
'      .TextMatrix(.Row, 1) = Format(datos(10), "#,##0.###0")
'      .TextMatrix(.Row, 2) = Format(datos(3), "#,##0.###0")
'      .TextMatrix(.Row, 3) = Format(datos(4), "#,##0.###0")
'      .TextMatrix(.Row, 4) = Format(datos(5), "#,##0.###0")
'      .TextMatrix(.Row, 5) = datos(6)
'      .TextMatrix(.Row, 6) = Format(datos(7), "DD/MM/YYYY")
'      .TextMatrix(.Row, 7) = Format(datos(8), "DD/MM/YYYY")
'      .TextMatrix(.Row, 8) = datos(9)
'      '.TextMatrix(.Row, 9) = Datos(10)
'      .Rows = .Rows + 1
'      .Row = .Rows - 1
'      End With
'  Loop
'End If
'      If TabCustodia.Rows = 2 Then
'         TabCustodia.Rows = 2
'      Else
'         TabCustodia.Rows = TabCustodia.Rows - 1
'      End If
'      '.Row = .Rows - 1
'
'If p = 0 Then
'  MsgBox "No existen datos para el criterio seleccionado", vbOKOnly + vbExclamation
'  Exit Sub
'End If
''Data1.Refresh
End Sub

Private Sub BtnCancelar_Click()
'    Unload Me
End Sub


Private Sub Form_Load()
Me.Top = 0
'Me.Left = 0
    With TabCustodia
    .TextMatrix(0, 0) = "Nº Ope"
    .TextMatrix(0, 1) = "Correlativo"
    .TextMatrix(0, 2) = "Valor Inicial"
    .TextMatrix(0, 3) = "Valor Final"
    .TextMatrix(0, 4) = "Tasa"
    .TextMatrix(0, 5) = "UM"
    .TextMatrix(0, 6) = "F.Inicio"
    .TextMatrix(0, 7) = "F.Termino"
    .TextMatrix(0, 8) = "Custodia"
    .ColWidth(0) = 800
    .ColWidth(1) = 1000
    .ColWidth(2) = 1500
    .ColWidth(3) = 1500
    .ColWidth(4) = 1300
    .ColWidth(5) = 600
    .ColWidth(6) = 1500
    .ColWidth(7) = 1500
    .ColWidth(8) = 1310
    .RowHeight(0) = 500
End With
'db.Execute "Delete * from ConCustodia"
'Data1.DatabaseName = gsMDB_Path + gsMDB_Database
'Data1.RecordSource = "ConCustodia"
'Data1.Refresh
End Sub

Private Sub TabCustodia_FetchAttributes(Status As Integer, Split As Integer, Row As Long, Col As Integer, FgColor As Long, BgColor As Long, FontStyle As Integer)
    If Row = TabCustodia.Row Then
        FgColor = BacToolTip.Color_Dest.ForeColor
        BgColor = BacToolTip.Color_Dest.BackColor
    Else
        FgColor = BacToolTip.Color_Normal.ForeColor
        BgColor = BacToolTip.Color_Normal.BackColor
    End If
End Sub


Private Sub TabCustodia_KeyPress(KeyAscii As Integer)
KeyAscii = 0
End Sub




Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case UCase(Button.Description)
    Case "BUSCAR"
        Call TOLLBUSCAR
    Case "CANCELAR"
        Unload Me
End Select
End Sub
Function TOLLBUSCAR()
Dim DATOS()
Dim p As Integer
Dim xCustodia As String

    If Trim(Cmb_Custodia) = "" Then
        MsgBox "Eliga Custodia", vbInformation
        Exit Function
    End If

    TabCustodia.Rows = 2
    p = 0
    xCustodia = Mid(Cmb_Custodia.Text, 1, 1)
'    Sql = "Sp_Trae_Consulta_Custodia " & Val(txtRutCliente) & ",'" & xCustodia & "'"

    Envia = Array(txtRutCliente.Text, xCustodia)
    
    If Bac_Sql_Execute("Sp_Trae_Consulta_Custodia", Envia) Then
    
        Do While Bac_SQL_Fetch(DATOS())
            p = p + 1
            With TabCustodia
                .TextMatrix(.Row, 0) = Format(DATOS(2), "#,##0")
                .TextMatrix(.Row, 1) = Format(DATOS(10), "#,##0.###0")
                .TextMatrix(.Row, 2) = Format(DATOS(3), "#,##0.###0")
                .TextMatrix(.Row, 3) = Format(DATOS(4), "#,##0.###0")
                .TextMatrix(.Row, 4) = Format(DATOS(5), "#,##0.###0")
                .TextMatrix(.Row, 5) = DATOS(6)
                .TextMatrix(.Row, 6) = Format(DATOS(7), "DD/MM/YYYY")
                .TextMatrix(.Row, 7) = Format(DATOS(8), "DD/MM/YYYY")
                .TextMatrix(.Row, 8) = DATOS(9)
                '.TextMatrix(.Row, 9) = Datos(10)
                .Rows = .Rows + 1
                .Row = .Rows - 1
            End With
        Loop
    End If
    
    If TabCustodia.Rows = 2 Then
        TabCustodia.Rows = 2
    Else
        TabCustodia.Rows = TabCustodia.Rows - 1
    End If

    If p = 0 Then
        MsgBox "No existen datos para el criterio seleccionado", vbOKOnly + vbExclamation
        Exit Function
    End If

End Function
Private Sub txtCodigoCliente_KeyPress(KeyAscii As Integer)
If Not IsNumeric(Chr(KeyAscii)) And KeyAscii <> 8 And KeyAscii = 13 Then
  KeyAscii = 0
End If
If KeyAscii = 13 Then
  Cmb_Custodia.SetFocus
End If
End Sub

Private Sub txtCodigoCliente_LostFocus()
Dim DATOS()

'    Sql = "sp_clleerrut1 " & Val(txtRutCliente) & "," & Val(txtCodigoCliente)

    Envia = Array(txtRutCliente.Text, txtCodigoCliente)
    
    If Bac_Sql_Execute("sp_clleerrut1", Envia) Then
        If Bac_SQL_Fetch(DATOS()) Then
            lblCliente.Caption = DATOS(4)
        Else
            MsgBox "Cliente no Existe", vbOKOnly + vbCritical
        End If
    End If
    
End Sub


Private Sub txtRutCliente_DblClick()
    BacAyuda.Tag = "MDCL"
    BacAyuda.Show 1
    If giAceptar = True Then
      txtRutCliente.Text = Val(gsrut$)
      lblCliente.Caption = gsDescripcion$
      txtCodigoCliente.Text = gsvalor$
      SendKeys "{ENTER 2} "
    End If
End Sub


Private Sub txtRutCliente_KeyPress(KeyAscii As Integer)
If Not IsNumeric(Chr(KeyAscii)) And KeyAscii <> 8 And KeyAscii = 13 Then
  KeyAscii = 0
End If
If KeyAscii = 13 Then
  txtCodigoCliente.SetFocus
End If
End Sub


