VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Begin VB.Form FRM_Mnt_Criterios 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantención de Criterios"
   ClientHeight    =   6495
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   10695
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   6495
   ScaleWidth      =   10695
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   9930
      Top             =   5805
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   48
      ImageHeight     =   48
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   2
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_Mnt_Criterios.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_Mnt_Criterios.frx":08DA
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Height          =   840
      Left            =   7155
      TabIndex        =   11
      Top             =   5610
      Width           =   3525
      _ExtentX        =   6218
      _ExtentY        =   1482
      ButtonWidth     =   2831
      ButtonHeight    =   1429
      ToolTips        =   0   'False
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
            Caption         =   "Save"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Exit"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin VB.Frame FraCriterios 
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   4740
      Left            =   60
      TabIndex        =   12
      Top             =   -30
      Width           =   10590
      Begin MSComctlLib.ListView Listado 
         Height          =   4425
         Left            =   45
         TabIndex        =   0
         Top             =   150
         Width           =   10500
         _ExtentX        =   18521
         _ExtentY        =   7805
         View            =   3
         LabelEdit       =   1
         LabelWrap       =   0   'False
         HideSelection   =   0   'False
         OLEDropMode     =   1
         AllowReorder    =   -1  'True
         FullRowSelect   =   -1  'True
         _Version        =   393217
         ForeColor       =   -2147483640
         BackColor       =   -2147483643
         BorderStyle     =   1
         Appearance      =   1
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         OLEDropMode     =   1
         NumItems        =   0
      End
   End
   Begin VB.Frame Fra_CtasPatrimonio 
      Height          =   960
      Left            =   7110
      TabIndex        =   25
      Top             =   4635
      Width           =   3525
      Begin VB.Frame Frame8 
         Height          =   630
         Left            =   1770
         TabIndex        =   27
         Top             =   330
         Width           =   45
      End
      Begin VB.Frame Frame7 
         Height          =   90
         Left            =   150
         TabIndex        =   26
         Top             =   450
         Width           =   3285
      End
      Begin VB.TextBox TxtPatPas 
         Alignment       =   1  'Right Justify
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   1905
         MaxLength       =   9
         TabIndex        =   6
         Text            =   "760701014"
         Top             =   570
         Width           =   1470
      End
      Begin VB.TextBox TxtPatAct 
         Alignment       =   1  'Right Justify
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   210
         MaxLength       =   9
         TabIndex        =   5
         Text            =   "760701014"
         Top             =   570
         Width           =   1470
      End
      Begin VB.Label LBLEtiquetas 
         Alignment       =   2  'Center
         AutoSize        =   -1  'True
         Caption         =   "Pasivo"
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
         Index           =   8
         Left            =   2265
         TabIndex        =   30
         Top             =   285
         Width           =   585
      End
      Begin VB.Label LBLEtiquetas 
         Alignment       =   2  'Center
         AutoSize        =   -1  'True
         Caption         =   "Activo"
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
         Index           =   7
         Left            =   585
         TabIndex        =   29
         Top             =   285
         Width           =   555
      End
      Begin VB.Label LBLEtiquetas 
         Alignment       =   2  'Center
         Caption         =   "PATRIMONIO"
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
         Index           =   6
         Left            =   30
         TabIndex        =   28
         Top             =   120
         Width           =   3450
      End
   End
   Begin VB.Frame Fra_CtasRESULTADO 
      Height          =   960
      Left            =   3570
      TabIndex        =   19
      Top             =   4635
      Width           =   3525
      Begin VB.Frame Frame4 
         Height          =   945
         Left            =   1770
         TabIndex        =   20
         Top             =   330
         Width           =   45
      End
      Begin VB.TextBox TxtResPos 
         Alignment       =   1  'Right Justify
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   210
         MaxLength       =   9
         TabIndex        =   3
         Text            =   "760701014"
         Top             =   570
         Width           =   1470
      End
      Begin VB.TextBox TxtResNeg 
         Alignment       =   1  'Right Justify
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   1905
         MaxLength       =   9
         TabIndex        =   4
         Text            =   "760701014"
         Top             =   570
         Width           =   1470
      End
      Begin VB.Frame Frame5 
         Height          =   90
         Left            =   150
         TabIndex        =   21
         Top             =   450
         Width           =   3285
      End
      Begin VB.Label LBLEtiquetas 
         Alignment       =   2  'Center
         Caption         =   "RESULTADO"
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
         Index           =   5
         Left            =   30
         TabIndex        =   24
         Top             =   120
         Width           =   3450
      End
      Begin VB.Label LBLEtiquetas 
         Alignment       =   2  'Center
         AutoSize        =   -1  'True
         Caption         =   "Utilidad"
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
         Index           =   4
         Left            =   525
         TabIndex        =   23
         Top             =   285
         Width           =   675
      End
      Begin VB.Label LBLEtiquetas 
         Alignment       =   2  'Center
         AutoSize        =   -1  'True
         Caption         =   "Perdida"
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
         Index           =   3
         Left            =   2220
         TabIndex        =   22
         Top             =   285
         Width           =   675
      End
   End
   Begin VB.Frame Fra_CtasAVR 
      Height          =   960
      Left            =   30
      TabIndex        =   13
      Top             =   4635
      Width           =   3525
      Begin VB.Frame Frame3 
         Height          =   945
         Left            =   1770
         TabIndex        =   16
         Top             =   330
         Width           =   45
      End
      Begin VB.Frame Frame2 
         Height          =   90
         Left            =   150
         TabIndex        =   15
         Top             =   450
         Width           =   3285
      End
      Begin VB.TextBox TxtAvrNeg 
         Alignment       =   1  'Right Justify
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   1905
         MaxLength       =   9
         TabIndex        =   2
         Text            =   "760701014"
         Top             =   570
         Width           =   1470
      End
      Begin VB.TextBox TxtAvrPos 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   210
         MaxLength       =   9
         TabIndex        =   1
         Text            =   "760701014"
         Top             =   570
         Width           =   1470
      End
      Begin VB.Label LBLEtiquetas 
         Alignment       =   2  'Center
         AutoSize        =   -1  'True
         Caption         =   "AVR Negativo"
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
         Left            =   1980
         TabIndex        =   18
         Top             =   285
         Width           =   1155
      End
      Begin VB.Label LBLEtiquetas 
         Alignment       =   2  'Center
         AutoSize        =   -1  'True
         Caption         =   "AVR Positivo"
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
         Left            =   315
         TabIndex        =   17
         Top             =   285
         Width           =   1095
      End
      Begin VB.Label LBLEtiquetas 
         Alignment       =   2  'Center
         Caption         =   "AVR"
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
         Left            =   30
         TabIndex        =   14
         Top             =   120
         Width           =   3450
      End
   End
   Begin VB.Frame Fra_CtasCaja 
      Height          =   960
      Left            =   30
      TabIndex        =   31
      Top             =   5505
      Width           =   3525
      Begin VB.Frame Frame9 
         Height          =   945
         Left            =   1770
         TabIndex        =   32
         Top             =   330
         Width           =   45
      End
      Begin VB.TextBox TxtCajAct 
         Alignment       =   1  'Right Justify
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   210
         MaxLength       =   9
         TabIndex        =   7
         Text            =   "760701014"
         Top             =   570
         Width           =   1470
      End
      Begin VB.TextBox TxtCajPas 
         Alignment       =   1  'Right Justify
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   1905
         MaxLength       =   9
         TabIndex        =   8
         Text            =   "760701014"
         Top             =   570
         Width           =   1470
      End
      Begin VB.Frame Frame10 
         Height          =   90
         Left            =   150
         TabIndex        =   33
         Top             =   450
         Width           =   3285
      End
      Begin VB.Label LBLEtiquetas 
         Alignment       =   2  'Center
         AutoSize        =   -1  'True
         Caption         =   "Activo"
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
         Index           =   10
         Left            =   585
         TabIndex        =   35
         Top             =   285
         Width           =   555
      End
      Begin VB.Label LBLEtiquetas 
         Alignment       =   2  'Center
         AutoSize        =   -1  'True
         Caption         =   "Pasivo"
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
         Index           =   9
         Left            =   2265
         TabIndex        =   34
         Top             =   285
         Width           =   585
      End
      Begin VB.Label LBLEtiquetas 
         Alignment       =   2  'Center
         Caption         =   "CAJA"
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
         Index           =   11
         Left            =   30
         TabIndex        =   36
         Top             =   120
         Width           =   3450
      End
   End
   Begin VB.Frame Frame1 
      Enabled         =   0   'False
      Height          =   960
      Left            =   3585
      TabIndex        =   37
      Top             =   5505
      Visible         =   0   'False
      Width           =   3525
      Begin VB.Frame Frame11 
         Height          =   90
         Left            =   150
         TabIndex        =   39
         Top             =   450
         Width           =   3285
      End
      Begin VB.TextBox TxtNocPas 
         Alignment       =   1  'Right Justify
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   1905
         MaxLength       =   9
         TabIndex        =   10
         Text            =   "760701014"
         Top             =   570
         Width           =   1470
      End
      Begin VB.TextBox TxtNocAct 
         Alignment       =   1  'Right Justify
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   210
         MaxLength       =   9
         TabIndex        =   9
         Text            =   "760701014"
         Top             =   570
         Width           =   1470
      End
      Begin VB.Frame Frame6 
         Height          =   945
         Left            =   1770
         TabIndex        =   38
         Top             =   330
         Width           =   45
      End
      Begin VB.Label LBLEtiquetas 
         Alignment       =   2  'Center
         Caption         =   "NOCIONALES"
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
         Index           =   14
         Left            =   30
         TabIndex        =   42
         Top             =   120
         Width           =   3450
      End
      Begin VB.Label LBLEtiquetas 
         Alignment       =   2  'Center
         AutoSize        =   -1  'True
         Caption         =   "Pasivo"
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
         Index           =   13
         Left            =   2265
         TabIndex        =   41
         Top             =   285
         Width           =   585
      End
      Begin VB.Label LBLEtiquetas 
         Alignment       =   2  'Center
         AutoSize        =   -1  'True
         Caption         =   "Activo"
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
         Index           =   12
         Left            =   585
         TabIndex        =   40
         Top             =   285
         Width           =   555
      End
   End
End
Attribute VB_Name = "FRM_Mnt_Criterios"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private oItemSelected As Long
Private oBoxSelected  As Integer

Private Const nOrg = 1
Private Const nPrd = 2
Private Const nTip = 3
Private Const nMon = 4

Private Sub Form_Load()
    Let Me.Icon = BACSwapParametros.Icon

   Call FuncSettingListado
   Call FuncLoadCriteriosDisponibles
   Call FuncClearText
End Sub

Private Function FuncClearText()
   Let TxtAvrPos.Text = ""
   Let TxtAvrNeg.Text = ""
   Let TxtResPos.Text = ""
   Let TxtResNeg.Text = ""
   Let TxtPatAct.Text = ""
   Let TxtPatPas.Text = ""
   Let TxtCajAct.Text = ""
   Let TxtCajPas.Text = ""
End Function

Private Function FuncSettingListado()
   Let Listado.Font.Name = "Tahoma": Let Listado.Font.Size = 8:  Let Listado.Font.Bold = False
   Call Listado.ColumnHeaders.Clear
   Call Listado.ColumnHeaders.Add(nOrg, "A", "ORIGEN", 1500)
   Call Listado.ColumnHeaders.Add(nPrd, "B", "PRODUCTO", 5500)
   Call Listado.ColumnHeaders.Add(nTip, "C", "TIPO", 1600)
   Call Listado.ColumnHeaders.Add(nMon, "D", "MONEDA", 1200)
End Function

Private Function FuncLoadCriteriosDisponibles()
    Dim cSqlString    As String
    Dim cModulo       As String * 5
    Dim cProducto     As String * 25
    Dim cTipo         As String * 10
    Dim cMoneda       As String * 15
    Dim oSqlDatos()

    If Not Bac_Sql_Execute("Sp_Tributarios_LeeCriterios") Then
        Exit Function
    End If
    Do While Bac_SQL_Fetch(oSqlDatos())
        Call Listado.ListItems.Add(, , oSqlDatos(2))
        Call Listado.ListItems.Item(Listado.ListItems.Count).ListSubItems.Add(, , oSqlDatos(6))
        Call Listado.ListItems.Item(Listado.ListItems.Count).ListSubItems.Add(, , oSqlDatos(7))
        Call Listado.ListItems.Item(Listado.ListItems.Count).ListSubItems.Add(, , oSqlDatos(8))
         Let Listado.ListItems.Item(Listado.ListItems.Count).Key = Chr((64 + oSqlDatos(1)))
    Loop

End Function

Private Sub Listado_ItemClick(ByVal Item As MSComctlLib.ListItem)
   Let oItemSelected = (Asc(Listado.ListItems.Item(Listado.SelectedItem.Index).Key) - 64)

   Call FuncLoadCtas(oItemSelected)
End Sub
Private Sub Listado_KeyPress(KeyAscii As Integer)
   Call SendKeys("{tab}")
End Sub


Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 2
         Call FuncSaveData
      Case 3
         Call Unload(Me)
   End Select
End Sub


Private Function FuncSaveData()
   Dim cStringSql    As String
   Dim bEstado       As Boolean

   Let cStringSql = ""
   Let cStringSql = cStringSql & " UPDATE BacParamSuda.dbo.TBL_TRIBUTARIOS_CRITERIOS "
   Let cStringSql = cStringSql & "     SET oCtaAvrPos  = '" & Trim(TxtAvrPos.Text) & "' "
   Let cStringSql = cStringSql & "     ,   oCtaAvrNeg  = '" & Trim(TxtAvrNeg.Text) & "' "
   Let cStringSql = cStringSql & "     ,   oCtaResPos  = '" & Trim(TxtResPos.Text) & "' "
   Let cStringSql = cStringSql & "     ,   oCtaResNeg  = '" & Trim(TxtResNeg.Text) & "' "
   Let cStringSql = cStringSql & "     ,   oCtaPatPos  = '" & Trim(TxtPatAct.Text) & "' "
   Let cStringSql = cStringSql & "     ,   oCtaPatNeg  = '" & Trim(TxtPatPas.Text) & "' "
   Let cStringSql = cStringSql & "     ,   oCtaCajPos  = '" & Trim(TxtCajAct.Text) & "' "
   Let cStringSql = cStringSql & "     ,   oCtaCajNeg  = '" & Trim(TxtCajPas.Text) & "' "
   Let cStringSql = cStringSql & " WHERE   oId         =  " & oItemSelected

   Let bEstado = Bac_Sql_Execute(cStringSql)

   If bEstado = False Then
      Call MsgBox("Se ha generado un error durante la grabación.", vbExclamation, App.Title)
   Else
      Call MsgBox("Se ha realizado la actualizado las cuentas para el producto seleccionado.", vbInformation, App.Title)
   End If

End Function

Private Function FuncLoadCtas(ByVal nId As Long)
    Dim cStringSql    As String
    Dim cSqlDatos()

    Let cStringSql = ""
    Let cStringSql = cStringSql & " SELECT oCtaAvrPos, oCtaAvrNeg, oCtaResPos, oCtaResNeg, oCtaPatPos, oCtaPatNeg, oCtaCajPos, oCtaCajNeg "
    Let cStringSql = cStringSql & " FROM   BacParamSuda.dbo.TBL_TRIBUTARIOS_CRITERIOS with(nolock) "
    Let cStringSql = cStringSql & " WHERE  oId = " & nId

    If Bac_Sql_Execute(cStringSql) Then
        If Bac_SQL_Fetch(cSqlDatos()) Then
            Let TxtAvrPos.Text = cSqlDatos(1)
            Let TxtAvrNeg.Text = cSqlDatos(2)
            Let TxtResPos.Text = cSqlDatos(3)
            Let TxtResNeg.Text = cSqlDatos(4)
            Let TxtPatAct.Text = cSqlDatos(5)
            Let TxtPatPas.Text = cSqlDatos(6)
            Let TxtCajAct.Text = cSqlDatos(7)
            Let TxtCajPas.Text = cSqlDatos(8)
        End If
    End If
End Function

Private Sub TxtAvrPos_KeyPress(KeyAscii As Integer)
   Let KeyAscii = FuncValidateText(KeyAscii)
End Sub
Private Sub TxtAvrNeg_KeyPress(KeyAscii As Integer)
   Let KeyAscii = FuncValidateText(KeyAscii)
End Sub
Private Sub TxtResPos_KeyPress(KeyAscii As Integer)
   Let KeyAscii = FuncValidateText(KeyAscii)
End Sub
Private Sub TxtResNeg_KeyPress(KeyAscii As Integer)
   Let KeyAscii = FuncValidateText(KeyAscii)
End Sub
Private Sub TxtPatAct_KeyPress(KeyAscii As Integer)
   Let KeyAscii = FuncValidateText(KeyAscii)
End Sub
Private Sub TxtPatPas_KeyPress(KeyAscii As Integer)
   Let KeyAscii = FuncValidateText(KeyAscii)
End Sub
Private Sub TxtCajAct_KeyPress(KeyAscii As Integer)
   Let KeyAscii = FuncValidateText(KeyAscii)
End Sub
Private Sub TxtCajPas_KeyPress(KeyAscii As Integer)
   Let KeyAscii = FuncValidateText(KeyAscii)
End Sub
Private Sub TxtNocAct_KeyPress(KeyAscii As Integer)
   Let KeyAscii = FuncValidateText(KeyAscii)
End Sub
Private Sub TxtNocPas_KeyPress(KeyAscii As Integer)
   Let KeyAscii = FuncValidateText(KeyAscii)
End Sub

Private Function FuncValidateText(ByVal Ascii As Integer) As Integer
   If Ascii = 13 Then
      Call SendKeys("{tab}")
   End If
   If Not IsNumeric(Chr(Ascii)) Then
      If Ascii <> vbKeyBack Then
        ' Let Ascii = 0
      End If
   End If
   
   Let FuncValidateText = Ascii
End Function

Private Sub Listado_GotFocus()
    Let oBoxSelected = 0:  Call FuncSettingColor
End Sub
Private Sub TxtAvrPos_GotFocus()
   Let oBoxSelected = 1:   Call FuncSettingColor
End Sub
Private Sub TxtAvrNeg_GotFocus()
   Let oBoxSelected = 2:   Call FuncSettingColor
End Sub
Private Sub TxtResPos_GotFocus()
   Let oBoxSelected = 3:   Call FuncSettingColor
End Sub
Private Sub TxtResNeg_GotFocus()
   Let oBoxSelected = 4:   Call FuncSettingColor
End Sub
Private Sub TxtPatAct_GotFocus()
   Let oBoxSelected = 5:   Call FuncSettingColor
End Sub
Private Sub TxtPatPas_GotFocus()
   Let oBoxSelected = 6:   Call FuncSettingColor
End Sub
Private Sub TxtCajAct_GotFocus()
   Let oBoxSelected = 7:   Call FuncSettingColor
End Sub
Private Sub TxtCajPas_GotFocus()
   Let oBoxSelected = 8:   Call FuncSettingColor
End Sub
Private Sub TxtNocAct_GotFocus()
   Let oBoxSelected = 9:   Call FuncSettingColor
End Sub
Private Sub TxtNocPas_GotFocus()
   Let oBoxSelected = 10:  Call FuncSettingColor
End Sub

Private Function FuncSettingColor()
   Dim oColorSelected As Variant
   Let oColorSelected = &H80FFFF
   
   If oBoxSelected = 0 Then
      Let TxtAvrPos.BackColor = vbWhite
      Let TxtAvrNeg.BackColor = vbWhite
      Let TxtResPos.BackColor = vbWhite
      Let TxtResNeg.BackColor = vbWhite
      Let TxtPatAct.BackColor = vbWhite
      Let TxtPatPas.BackColor = vbWhite
      Let TxtCajAct.BackColor = vbWhite
      Let TxtCajPas.BackColor = vbWhite
      Let TxtNocAct.BackColor = vbWhite
      Let TxtNocPas.BackColor = vbWhite
   Else
      Let TxtAvrPos.BackColor = IIf(oBoxSelected = 1, oColorSelected, vbWhite)
      Let TxtAvrNeg.BackColor = IIf(oBoxSelected = 2, oColorSelected, vbWhite)
      Let TxtResPos.BackColor = IIf(oBoxSelected = 3, oColorSelected, vbWhite)
      Let TxtResNeg.BackColor = IIf(oBoxSelected = 4, oColorSelected, vbWhite)
      Let TxtPatAct.BackColor = IIf(oBoxSelected = 5, oColorSelected, vbWhite)
      Let TxtPatPas.BackColor = IIf(oBoxSelected = 6, oColorSelected, vbWhite)
      Let TxtCajAct.BackColor = IIf(oBoxSelected = 7, oColorSelected, vbWhite)
      Let TxtCajPas.BackColor = IIf(oBoxSelected = 8, oColorSelected, vbWhite)
      Let TxtNocAct.BackColor = IIf(oBoxSelected = 9, oColorSelected, vbWhite)
      Let TxtNocPas.BackColor = IIf(oBoxSelected = 10, oColorSelected, vbWhite)
   End If
End Function
