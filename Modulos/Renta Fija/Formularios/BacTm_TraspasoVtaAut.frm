VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacTm_TraspasoVtaAut 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Traspaso Tasa Mercado"
   ClientHeight    =   6120
   ClientLeft      =   1845
   ClientTop       =   2460
   ClientWidth     =   8250
   LinkTopic       =   "Form2"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   6120
   ScaleWidth      =   8250
   Begin VB.Frame Frame1 
      Caption         =   "Escenario"
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   735
      Left            =   120
      TabIndex        =   5
      Top             =   480
      Width           =   3855
      Begin VB.ComboBox CmbEscenario 
         Enabled         =   0   'False
         Height          =   315
         ItemData        =   "BacTm_TraspasoVtaAut.frx":0000
         Left            =   120
         List            =   "BacTm_TraspasoVtaAut.frx":0010
         Style           =   2  'Dropdown List
         TabIndex        =   6
         Top             =   260
         Width           =   3615
      End
   End
   Begin BACControles.TXTNumero txtgrilla 
      Height          =   375
      Left            =   1200
      TabIndex        =   4
      Top             =   2640
      Visible         =   0   'False
      Width           =   1335
      _ExtentX        =   2355
      _ExtentY        =   661
      BackColor       =   8388608
      ForeColor       =   16777215
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BorderStyle     =   0
      Text            =   "0"
      Text            =   "0"
      Max             =   "99"
      SelStart        =   1
   End
   Begin MSFlexGridLib.MSFlexGrid Table1 
      Height          =   4695
      Left            =   120
      TabIndex        =   0
      Top             =   1320
      Width           =   8055
      _ExtentX        =   14208
      _ExtentY        =   8281
      _Version        =   393216
      FixedCols       =   0
      BackColor       =   12632256
      ForeColor       =   8388608
      BackColorFixed  =   8421376
      ForeColorFixed  =   16777215
      BackColorBkg    =   12632256
      AllowBigSelection=   0   'False
      FocusRect       =   0
      GridLines       =   2
   End
   Begin Threed.SSFrame Fr_Sort 
      Height          =   735
      Left            =   4200
      TabIndex        =   1
      Top             =   480
      Width           =   2295
      _Version        =   65536
      _ExtentX        =   4048
      _ExtentY        =   1296
      _StockProps     =   14
      Caption         =   "Ordenar por"
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Times New Roman"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      Begin VB.ComboBox Cmb_Sort 
         Height          =   315
         Left            =   120
         Style           =   2  'Dropdown List
         TabIndex        =   2
         Top             =   270
         Width           =   2055
      End
   End
   Begin MSComctlLib.Toolbar Tool 
      Height          =   450
      Left            =   -120
      TabIndex        =   3
      Top             =   0
      Width           =   8295
      _ExtentX        =   14631
      _ExtentY        =   794
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList2"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdLimpiar"
            Description     =   "Limpiar"
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdTasas"
            Description     =   "Leer Tasas"
            Object.ToolTipText     =   "Lee tasas actualez"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdGrabar"
            Description     =   "Grabar"
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdSalir"
            Description     =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   3
         EndProperty
      EndProperty
      Begin MSComctlLib.ImageList ImageList2 
         Left            =   6120
         Top             =   120
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
               Picture         =   "BacTm_TraspasoVtaAut.frx":0044
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacTm_TraspasoVtaAut.frx":019E
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacTm_TraspasoVtaAut.frx":04B8
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacTm_TraspasoVtaAut.frx":07D2
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
End
Attribute VB_Name = "BacTm_TraspasoVtaAut"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'
'Sub graba_tasas()
'
'    'declaracion de variableslocales
'    Dim I As Double
'
'    Screen.MousePointer = vbHourglass
'
'    If Table1.TextMatrix(1, 0) = "" Or IsNull(Table1.TextMatrix(1, 0)) Then
'
'        Exit Sub
'    End If
'
'    For I = 1 To Table1.Rows - 1
'
'        Envia = Array()
'
'        AddParam Envia, Table1.TextMatrix(I, 1)
'        AddParam Envia, CDbl(Table1.TextMatrix(I, 7))
'        AddParam Envia, CDbl(Table1.TextMatrix(I, 8))
'        AddParam Envia, CDbl(Table1.TextMatrix(I, 6))
'        AddParam Envia, Format(Table1.TextMatrix(I, 3), "yyyymmdd")
'        AddParam Envia, CDbl(Table1.TextMatrix(I, 4))
'
'        If Not Bac_Sql_Execute("sp_tasamercado_vtaaut_grabatasa ", Envia()) Then
'            MsgBox "Se ha producido un error al grabar las tasas", vbCritical, gsBac_Version
'
'            Screen.MousePointer = vbDefault
'
'            Exit Sub
'        End If
'
'    Next
'
'    Screen.MousePointer = vbDefault
'
'    'aviso al usuario
'    MsgBox "Las tasas se han grabado sin problemas", vbInformation, gsBac_Version
'
'End Sub
'Sub pos_texto(key As Integer)
'
'With txtgrilla
'
'    .Width = Table1.CellWidth '- 20
'    .Height = Table1.CellHeight
'    .Top = Table1.CellTop + Table1.Top '+ 20
'    .Left = Table1.CellLeft + Table1.Left '+ 20
'
'    If IsNumeric(Chr(key)) Then
'        .Text = Chr(key)
'    End If
'
'    If key = 13 Then
'        .Text = Table1.Text
'    End If
'
'
'    .Visible = True
'    .SetFocus
'    .SelStart = Len(.Text)
'
'End With
'
'End Sub
'
'
'Sub Titulos_grilla()
'
'    Tool.Buttons(4).Enabled = False
'
'    With Table1
'
'        .Cols = 9
'        .Rows = 2
'        .Clear
'
'        Cmb_Sort.Clear
'
'        .ColWidth(0) = 0
'        .ColWidth(1) = 1500
'        .ColWidth(2) = 1300
'        .ColWidth(3) = 1300
'        .ColWidth(4) = 1200
'        .ColWidth(5) = 2300
'        .ColWidth(6) = 0
'        .ColWidth(7) = 0
'        .ColWidth(8) = 0
'
'        .TextMatrix(0, 0) = "Código"
'        .TextMatrix(0, 1) = "Serie": Cmb_Sort.AddItem "Serie"
'        .TextMatrix(0, 2) = "Emisor": Cmb_Sort.AddItem "Emisor"
'        .TextMatrix(0, 3) = "Fecha Vcto."
'        .TextMatrix(0, 4) = "Tasa": Cmb_Sort.AddItem "Tasa"
'        .TextMatrix(0, 5) = "Nominal"
'        .TextMatrix(0, 6) = "Rut"
'        .TextMatrix(0, 6) = "numdocu"
'        .TextMatrix(0, 6) = "correla"
'
'    End With
'
'End Sub
'
'Sub Trae_Tasas()
'
'    'declaracion de las variables locales
'    Dim datos()
'
'    Screen.MousePointer = vbHourglass
'
'    'limpio la pantalla
'    Call Titulos_grilla
'
'    'preparo datos para el sp
'    Envia = Array(CmbEscenario.ItemData(CmbEscenario.ListIndex))
'
'    'llamo procedimiento
'    If Not Bac_Sql_Execute("Sp_tasamercado_VtaAut_TraeTasas ", Envia()) Then
'
'        'aviso al usuario
'        MsgBox "Se ha producido un error al recuperar las tasas", vbCritical, gsBac_Version
'
'        Screen.MousePointer = vbDefault
'
'        Exit Sub
'
'    End If
'
'    Do While Bac_SQL_Fetch(datos())
'
'        With Table1
'
'            .TextMatrix(.Rows - 1, 0) = datos(1)
'            .TextMatrix(.Rows - 1, 1) = datos(2)
'            .TextMatrix(.Rows - 1, 2) = datos(7)
'            .TextMatrix(.Rows - 1, 3) = datos(3)
'            .TextMatrix(.Rows - 1, 4) = Format(datos(4), "0.0000")
'            .TextMatrix(.Rows - 1, 5) = Format(datos(5), "###,###,###,##0.0000")
'            .TextMatrix(.Rows - 1, 6) = datos(6)
'            .TextMatrix(.Rows - 1, 7) = Val(datos(8))
'            .TextMatrix(.Rows - 1, 8) = Val(datos(9))
'
'            .Rows = .Rows + 1
'        End With
'    Loop
'
'    If Table1.Rows > 2 Then
'
'        Table1.RemoveItem (Table1.Rows - 1)
'        Tool.Buttons(4).Enabled = True
'        MsgBox "Tasas se Cargaron Correctamente", vbInformation, gsBac_Version
'
'    Else
'
'        'aviso al usuario
'        MsgBox "No se encontraron registros", vbInformation, gsBac_Version
'
'    End If
'
'
'
'
'    Screen.MousePointer = vbDefault
'
'End Sub
'
'
'Sub Carga_Cartera()
'
'    'declaracion de las variables locales
'    Dim datos()
'
'    Screen.MousePointer = vbHourglass
'
'    'limpio la pantalla
'    Call Titulos_grilla
'
'    'llamo procedimiento
'    If Not Bac_Sql_Execute("Sp_tasamercado_VtaAut_TraeCartera 1") Then
'
'        'aviso al usuario
'        MsgBox "Se ha producido un error al recuperar las tasas", vbCritical, gsBac_Version
'
'        Screen.MousePointer = vbDefault
'
'        Exit Sub
'
'    End If
'
'    Do While Bac_SQL_Fetch(datos())
'
'        With Table1
'
'            .TextMatrix(.Rows - 1, 0) = datos(1)
'            .TextMatrix(.Rows - 1, 1) = datos(2)
'            .TextMatrix(.Rows - 1, 2) = datos(7)
'            .TextMatrix(.Rows - 1, 3) = datos(3)
'            .TextMatrix(.Rows - 1, 4) = Format(datos(4), "0.0000")
'            .TextMatrix(.Rows - 1, 5) = Format(datos(5), "###,###,###,##0.0000")
'            .TextMatrix(.Rows - 1, 6) = datos(6)
'            .TextMatrix(.Rows - 1, 7) = Val(datos(8))
'            .TextMatrix(.Rows - 1, 8) = Val(datos(9))
'
'
'            .Rows = .Rows + 1
'        End With
'    Loop
'
'    If Table1.Rows > 2 Then
'
'        Table1.RemoveItem (Table1.Rows - 1)
'
'    Else
'
'        'aviso al usuario
'        MsgBox "No se encontraron registros", vbInformation, gsBac_Version
'
'    End If
'
'    Screen.MousePointer = vbDefault
'
'End Sub
'
'
'Private Sub Cmb_Sort_Click()
'
''    Select Case Cmb_Sort.ListIndex
''        Case 0:
''           ' Ordena_Grilla Table1, 1, Ascendente, Caracter
''
''        Case 1:
''           ' Ordena_Grilla Table1, 2, Ascendente, Caracter
''
''        Case 2:
''            Ordena_Grilla Table1, 4, Ascendente
''
''    End Select
'
'End Sub
'
'Private Sub Form_Load()
'
'    'personalizo la ventana
'    Move 0, 0
'    Me.Icon = BacTrader.Icon
'
'    'posiciono el cmb
'    CmbEscenario.ListIndex = 0
'
'    'lleno grilla
'    Call Titulos_grilla
'    Call Carga_Cartera
'
'End Sub
'
'
'
'Private Sub Table1_KeyPress(KeyAscii As Integer)
'
'    If Table1.Col = 4 Then
'
'        BacCaracterNumerico KeyAscii
'
'        'posiciono mi super texto
'        Call pos_texto(KeyAscii)
'        Tool.Buttons(4).Enabled = True
'
'    End If
'
'End Sub
'
'
'Private Sub Tool_ButtonClick(ByVal Button As MSComctlLib.Button)
'
'    'determino el boton presionado por el usuario
'    Select Case Button.key
'
'        Case Is = "cmdLimpiar": Call Titulos_grilla
'        Case Is = "cmdTasas": Call Trae_Tasas
'        Case Is = "cmdGrabar": Call graba_tasas
'        Case Is = "cmdSalir": Unload Me
'
'    End Select
'End Sub
'
'Private Sub TxtGrilla_KeyPress(KeyAscii As Integer)
'
'    If KeyAscii = 13 Then
'
'        Table1.Text = txtgrilla.Text
'
'        txtgrilla.Visible = False
'
'        Table1.SetFocus
'
'    ElseIf KeyAscii = 27 Then
'
'        txtgrilla.Visible = False
'        Table1.SetFocus
'
'    End If
'End Sub
'
'Private Sub TxtGrilla_LostFocus()
'
'    txtgrilla.Visible = False
'
'End Sub
'
