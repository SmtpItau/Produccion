VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form FRM_MNT_FILTROGRUPO 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Filtro - Agrupación de Operaciones"
   ClientHeight    =   7875
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   14070
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   7875
   ScaleWidth      =   14070
   StartUpPosition =   2  'CenterScreen
   Begin VB.PictureBox ConCheck 
      BorderStyle     =   0  'None
      Height          =   360
      Index           =   0
      Left            =   8055
      Picture         =   "FRM_MNT_FILTROGRUPO.frx":0000
      ScaleHeight     =   360
      ScaleWidth      =   405
      TabIndex        =   22
      Top             =   45
      Visible         =   0   'False
      Width           =   405
   End
   Begin VB.PictureBox SinCheck 
      BorderStyle     =   0  'None
      Height          =   345
      Index           =   0
      Left            =   7755
      Picture         =   "FRM_MNT_FILTROGRUPO.frx":015A
      ScaleHeight     =   345
      ScaleWidth      =   375
      TabIndex        =   21
      Top             =   45
      Visible         =   0   'False
      Width           =   375
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   14070
      _ExtentX        =   24818
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
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Caption         =   "Aceptar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Buscar"
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Cerrar"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   4155
         Top             =   15
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
               Picture         =   "FRM_MNT_FILTROGRUPO.frx":02B4
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_FILTROGRUPO.frx":118E
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_FILTROGRUPO.frx":14A8
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame FRM_CLIENTE 
      Height          =   540
      Left            =   30
      TabIndex        =   14
      Top             =   375
      Width           =   14025
      Begin VB.TextBox TxtRut 
         Alignment       =   1  'Right Justify
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   1560
         Locked          =   -1  'True
         TabIndex        =   17
         Text            =   "0"
         Top             =   150
         Width           =   1515
      End
      Begin VB.TextBox TxtNombre 
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   3405
         Locked          =   -1  'True
         TabIndex        =   16
         Top             =   150
         Width           =   4560
      End
      Begin VB.TextBox TxtCodigo 
         Alignment       =   2  'Center
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   3105
         Locked          =   -1  'True
         TabIndex        =   15
         Text            =   "0"
         Top             =   150
         Width           =   270
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Datos del Cliente"
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
         Index           =   0
         Left            =   90
         TabIndex        =   18
         Top             =   180
         Width           =   1395
      End
   End
   Begin VB.Frame FRM_MARCO 
      Height          =   1245
      Left            =   30
      TabIndex        =   1
      Top             =   825
      Width           =   14025
      Begin MSComctlLib.ImageList ImageList2 
         Left            =   13350
         Top             =   -375
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
               Picture         =   "FRM_MNT_FILTROGRUPO.frx":2382
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_FILTROGRUPO.frx":325C
               Key             =   ""
            EndProperty
         EndProperty
      End
      Begin VB.ComboBox CmdEstado 
         Enabled         =   0   'False
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
         Left            =   3135
         Style           =   2  'Dropdown List
         TabIndex        =   20
         Top             =   840
         Width           =   3180
      End
      Begin VB.ComboBox CmbTipoOperacion 
         Enabled         =   0   'False
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
         Left            =   3135
         Style           =   2  'Dropdown List
         TabIndex        =   10
         Top             =   300
         Width           =   6420
      End
      Begin VB.ComboBox CmbSistema 
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
         Left            =   45
         Style           =   2  'Dropdown List
         TabIndex        =   9
         Top             =   300
         Width           =   3075
      End
      Begin BACControles.TXTFecha TxtValuta 
         Height          =   315
         Left            =   6645
         TabIndex        =   7
         Top             =   840
         Width           =   1500
         _ExtentX        =   2646
         _ExtentY        =   556
         Enabled         =   -1  'True
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Courier New"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "25/10/2007"
      End
      Begin VB.ComboBox CmbMedioPago 
         Enabled         =   0   'False
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
         Left            =   45
         Style           =   2  'Dropdown List
         TabIndex        =   5
         Top             =   840
         Width           =   3075
      End
      Begin VB.ComboBox CmbMonPago 
         Enabled         =   0   'False
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
         Left            =   9570
         Style           =   2  'Dropdown List
         TabIndex        =   3
         Top             =   300
         Width           =   3075
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Estado"
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
         Index           =   6
         Left            =   3165
         TabIndex        =   19
         Top             =   645
         Width           =   555
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Tipo de Operación"
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
         Index           =   5
         Left            =   3135
         TabIndex        =   11
         Top             =   105
         Width           =   1500
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "908"
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
         Index           =   4
         Left            =   60
         TabIndex        =   8
         Top             =   105
         Width           =   270
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Valuta"
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
         Index           =   3
         Left            =   6645
         TabIndex        =   6
         Top             =   645
         Width           =   510
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Medio de Pago"
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
         Index           =   2
         Left            =   75
         TabIndex        =   4
         Top             =   645
         Width           =   1215
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Moneda Pago"
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
         Index           =   1
         Left            =   9585
         TabIndex        =   2
         Top             =   105
         Width           =   1110
      End
   End
   Begin VB.Frame FRA_DETALLE 
      Height          =   3570
      Left            =   30
      TabIndex        =   12
      Top             =   1995
      Width           =   14025
      Begin MSFlexGridLib.MSFlexGrid GRILLA 
         Height          =   3390
         Left            =   30
         TabIndex        =   13
         Top             =   135
         Width           =   13935
         _ExtentX        =   24580
         _ExtentY        =   5980
         _Version        =   393216
         FixedCols       =   0
         BackColor       =   12632256
         BackColorFixed  =   -2147483646
         ForeColorFixed  =   -2147483639
         BackColorBkg    =   -2147483636
         FocusRect       =   0
         GridLines       =   2
         GridLinesFixed  =   0
         AllowUserResizing=   1
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
   End
   Begin VB.Frame FRA_GRUPO 
      Height          =   2355
      Left            =   30
      TabIndex        =   23
      Top             =   5490
      Width           =   14025
      Begin MSFlexGridLib.MSFlexGrid GRUPO 
         Height          =   2190
         Left            =   30
         TabIndex        =   24
         Top             =   120
         Width           =   13935
         _ExtentX        =   24580
         _ExtentY        =   3863
         _Version        =   393216
         FixedCols       =   0
         BackColor       =   12632256
         BackColorFixed  =   -2147483646
         ForeColorFixed  =   -2147483639
         BackColorBkg    =   -2147483636
         FocusRect       =   0
         GridLines       =   2
         GridLinesFixed  =   0
         AllowUserResizing=   1
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
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
Attribute VB_Name = "FRM_MNT_FILTROGRUPO"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub HABILITA_SELECCION()
   Let Toolbar1.Buttons(1).Enabled = False
   
     If CmbSistema.ListIndex < 0 Then Exit Sub
     If CmbMonPago.ListIndex < 0 Then Exit Sub
   If CmbMedioPago.ListIndex < 0 Then Exit Sub
   
   Let Toolbar1.Buttons(1).Enabled = True
   
End Sub

Private Sub BUSCAR_OPERACIONES()
   Dim DATOS()
   Dim iMoneda    As Integer
   Dim iFPago     As Integer
   Dim oFormato   As String
   
   Let iMoneda = CmbMonPago.ItemData(CmbMonPago.ListIndex)
   Let iFPago = CmbMedioPago.ItemData(CmbMedioPago.ListIndex)

   Envia = Array()
   AddParam Envia, CDbl(0)
   AddParam Envia, CDbl(0)
   AddParam Envia, Format(gsbac_fecp, "yyyymmdd")
   AddParam Envia, Format(TxtValuta.Text, "yyyymmdd")
   AddParam Envia, CDbl(TxtRut.Text)
   AddParam Envia, CDbl(TxtCodigo.Text)
   AddParam Envia, Trim(Right(CmbSistema.Text, 5))
   AddParam Envia, Trim(Right(CmbTipoOperacion.Text, 5))
   AddParam Envia, iMoneda
   AddParam Envia, iFPago
   AddParam Envia, CmdEstado.ItemData(CmdEstado.ListIndex)
   If Not Bac_Sql_Execute("SP_GENERA_GRUPO", Envia) Then
      Exit Sub
   End If
   
   Let GRILLA.Rows = 2
   Let GRILLA.Col = 0
   Let GRILLA.Redraw = False
   Do While Bac_SQL_Fetch(DATOS())
      Let oFormato = IIf(Val(Right(DATOS(10), 3)) = 999, FEntero, FDecimal)
      Let GRILLA.Rows = GRILLA.Rows + 1
      Let GRILLA.Row = GRILLA.Rows - 1
      
      Let GRILLA.TextMatrix(GRILLA.Rows - 1, 0) = DATOS(1)
      Let GRILLA.TextMatrix(GRILLA.Rows - 1, 1) = DATOS(2)
      Let GRILLA.TextMatrix(GRILLA.Rows - 1, 2) = DATOS(3)
      Let GRILLA.TextMatrix(GRILLA.Rows - 1, 3) = DATOS(4)
      Let GRILLA.TextMatrix(GRILLA.Rows - 1, 4) = DATOS(5)
      Let GRILLA.TextMatrix(GRILLA.Rows - 1, 5) = DATOS(6)
      Let GRILLA.TextMatrix(GRILLA.Rows - 1, 6) = DATOS(7)
      Let GRILLA.TextMatrix(GRILLA.Rows - 1, 7) = DATOS(8)
      Let GRILLA.TextMatrix(GRILLA.Rows - 1, 8) = DATOS(9)
      Let GRILLA.TextMatrix(GRILLA.Rows - 1, 9) = DATOS(10)
      Let GRILLA.TextMatrix(GRILLA.Rows - 1, 10) = Format(DATOS(11), oFormato)
      Let GRILLA.TextMatrix(GRILLA.Rows - 1, 11) = DATOS(12)
      Let GRILLA.TextMatrix(GRILLA.Rows - 1, 12) = DATOS(13)
      Let GRILLA.TextMatrix(GRILLA.Rows - 1, 13) = DATOS(14)
      Let GRILLA.TextMatrix(GRILLA.Rows - 1, 14) = DATOS(15)
      Let GRILLA.TextMatrix(GRILLA.Rows - 1, 15) = 0
      Let GRILLA.CellPictureAlignment = 4
      
      If DATOS(2) = "Pend." Then
         Set GRILLA.CellPicture = ConCheck(0).Picture
         Let GRILLA.TextMatrix(GRILLA.RowSel, 0) = Space(100) & "M"
      Else
         Set GRILLA.CellPicture = SinCheck(0).Picture
         Let GRILLA.TextMatrix(GRILLA.RowSel, 0) = Space(100) & ""
      End If
   Loop
   Let GRILLA.Redraw = True
   
   
   Envia = Array()
   AddParam Envia, CDbl(1)
   AddParam Envia, CDbl(0)
   AddParam Envia, Format(gsbac_fecp, "yyyymmdd")
   AddParam Envia, Format(TxtValuta.Text, "yyyymmdd")
   AddParam Envia, CDbl(TxtRut.Text)
   AddParam Envia, CDbl(TxtCodigo.Text)
   AddParam Envia, Trim(Right(CmbSistema.Text, 5))
   AddParam Envia, Trim(Right(CmbTipoOperacion.Text, 5))
   AddParam Envia, iMoneda
   AddParam Envia, iFPago
   AddParam Envia, CmdEstado.ItemData(CmdEstado.ListIndex)
   If Not Bac_Sql_Execute("SP_GENERA_GRUPO", Envia) Then
      Exit Sub
   End If
   
   Let GRUPO.Rows = 2
   Let GRUPO.Col = 0
   Let GRUPO.Redraw = False
   Do While Bac_SQL_Fetch(DATOS())
      Let oFormato = IIf(Val(Right(DATOS(10), 3)) = 999, FEntero, FDecimal)
      Let GRUPO.Rows = GRUPO.Rows + 1
      Let GRUPO.Row = GRUPO.Rows - 1
      
      Let GRUPO.TextMatrix(GRUPO.Rows - 1, 0) = DATOS(1)
      Let GRUPO.TextMatrix(GRUPO.Rows - 1, 1) = DATOS(2)
      Let GRUPO.TextMatrix(GRUPO.Rows - 1, 2) = DATOS(3)
      Let GRUPO.TextMatrix(GRUPO.Rows - 1, 3) = DATOS(4)
      Let GRUPO.TextMatrix(GRUPO.Rows - 1, 4) = DATOS(5)
      Let GRUPO.TextMatrix(GRUPO.Rows - 1, 5) = DATOS(6)
      Let GRUPO.TextMatrix(GRUPO.Rows - 1, 6) = DATOS(7)
      Let GRUPO.TextMatrix(GRUPO.Rows - 1, 7) = DATOS(8)
      Let GRUPO.TextMatrix(GRUPO.Rows - 1, 8) = DATOS(9)
      Let GRUPO.TextMatrix(GRUPO.Rows - 1, 9) = DATOS(10)
      Let GRUPO.TextMatrix(GRUPO.Rows - 1, 10) = Format(DATOS(11), oFormato)
      Let GRUPO.TextMatrix(GRUPO.Rows - 1, 11) = DATOS(12)
      Let GRUPO.TextMatrix(GRUPO.Rows - 1, 12) = DATOS(13)
      Let GRUPO.TextMatrix(GRUPO.Rows - 1, 13) = DATOS(14)
      Let GRUPO.TextMatrix(GRUPO.Rows - 1, 14) = DATOS(15)
      Let GRUPO.TextMatrix(GRUPO.Rows - 1, 15) = 0
      Let GRUPO.CellPictureAlignment = 4
      
      Set GRUPO.CellPicture = SinCheck(0).Picture
   Loop
   Let GRUPO.Redraw = True

   
End Sub

Private Sub PRE_AGRUPACION(ByVal iFila As Long)
   Dim DATOS()

   If GRILLA.Rows <= 2 Then
      Exit Sub
   End If

   Envia = Array()
   AddParam Envia, CDbl(2)
   AddParam Envia, CDbl(GRILLA.TextMatrix(iFila, 6))
   AddParam Envia, Format(gsbac_fecp, "yyyymmdd")
   AddParam Envia, Format(TxtValuta.Text, "yyyymmdd")
   AddParam Envia, CDbl(TxtRut.Text)
   AddParam Envia, CDbl(TxtCodigo.Text)
   AddParam Envia, Trim(Right(GRILLA.TextMatrix(iFila, 4), 5))
   AddParam Envia, Trim(Right(GRILLA.TextMatrix(iFila, 5), 5))
   AddParam Envia, Val(Trim(Right(GRILLA.TextMatrix(iFila, 9), 5)))
   AddParam Envia, Val(Trim(Right(GRILLA.TextMatrix(iFila, 11), 5)))
   AddParam Envia, CmdEstado.ItemData(CmdEstado.ListIndex)
   If Not Bac_Sql_Execute("SP_GENERA_GRUPO", Envia) Then
      Exit Sub
   End If

   Let GRUPO.Rows = 2
   Let GRUPO.Col = 0
   Let GRUPO.Redraw = False
   Do While Bac_SQL_Fetch(DATOS())
      Let oFormato = IIf(Val(Right(DATOS(10), 3)) = 999, FEntero, FDecimal)
      Let GRUPO.Rows = GRUPO.Rows + 1
      Let GRUPO.Row = GRUPO.Rows - 1
      
      Let GRUPO.TextMatrix(GRUPO.Rows - 1, 0) = DATOS(1)
      Let GRUPO.TextMatrix(GRUPO.Rows - 1, 1) = DATOS(2)
      Let GRUPO.TextMatrix(GRUPO.Rows - 1, 2) = DATOS(3)
      Let GRUPO.TextMatrix(GRUPO.Rows - 1, 3) = DATOS(4)
      Let GRUPO.TextMatrix(GRUPO.Rows - 1, 4) = DATOS(5)
      Let GRUPO.TextMatrix(GRUPO.Rows - 1, 5) = DATOS(6)
      Let GRUPO.TextMatrix(GRUPO.Rows - 1, 6) = DATOS(7)
      Let GRUPO.TextMatrix(GRUPO.Rows - 1, 7) = DATOS(8)
      Let GRUPO.TextMatrix(GRUPO.Rows - 1, 8) = DATOS(9)
      Let GRUPO.TextMatrix(GRUPO.Rows - 1, 9) = DATOS(10)
      Let GRUPO.TextMatrix(GRUPO.Rows - 1, 10) = Format(DATOS(11), oFormato)
      Let GRUPO.TextMatrix(GRUPO.Rows - 1, 11) = DATOS(12)
      Let GRUPO.TextMatrix(GRUPO.Rows - 1, 12) = DATOS(13)
      Let GRUPO.TextMatrix(GRUPO.Rows - 1, 13) = DATOS(14)
      Let GRUPO.TextMatrix(GRUPO.Rows - 1, 14) = DATOS(15)
      Let GRUPO.TextMatrix(GRUPO.Rows - 1, 15) = 0
      Let GRUPO.CellPictureAlignment = 4
      
      Set GRUPO.CellPicture = SinCheck(0).Picture
   Loop
   Let GRUPO.Redraw = True

End Sub

Private Sub CAMPOS_GRILLA()
   Let GRILLA.Rows = 3:    Let GRILLA.FixedRows = 2
   Let GRILLA.Cols = 16:   Let GRILLA.FixedCols = 0
   Let GRILLA.TextMatrix(0, 0) = "M":              Let GRILLA.TextMatrix(1, 0) = "":               Let GRILLA.ColWidth(0) = 500:    Let GRILLA.ColAlignment(0) = flexAlignLeftCenter
   Let GRILLA.TextMatrix(0, 1) = "Agrupado":       Let GRILLA.TextMatrix(1, 1) = "":               Let GRILLA.ColWidth(1) = 800:    Let GRILLA.ColAlignment(1) = flexAlignLeftCenter
   Let GRILLA.TextMatrix(0, 2) = "N°":             Let GRILLA.TextMatrix(1, 2) = "Grupo":          Let GRILLA.ColWidth(2) = 800:    Let GRILLA.ColAlignment(2) = flexAlignRightCenter
   Let GRILLA.TextMatrix(0, 3) = "Enviada":        Let GRILLA.TextMatrix(1, 3) = "":               Let GRILLA.ColWidth(3) = 0:      Let GRILLA.ColAlignment(3) = flexAlignLeftCenter
   Let GRILLA.TextMatrix(0, 4) = "Modulo":         Let GRILLA.TextMatrix(1, 4) = "":               Let GRILLA.ColWidth(4) = 1000:   Let GRILLA.ColAlignment(4) = flexAlignLeftCenter
   Let GRILLA.TextMatrix(0, 5) = "Tipo":           Let GRILLA.TextMatrix(1, 5) = "Operación":      Let GRILLA.ColWidth(5) = 1000:   Let GRILLA.ColAlignment(5) = flexAlignLeftCenter
   Let GRILLA.TextMatrix(0, 6) = "Numero":         Let GRILLA.TextMatrix(1, 6) = "Operación":      Let GRILLA.ColWidth(6) = 1000:   Let GRILLA.ColAlignment(6) = flexAlignRightCenter
   Let GRILLA.TextMatrix(0, 7) = "Nombre":         Let GRILLA.TextMatrix(1, 7) = "Cliente":        Let GRILLA.ColWidth(7) = 3000:   Let GRILLA.ColAlignment(7) = flexAlignLeftCenter
   Let GRILLA.TextMatrix(0, 8) = "Fecha":          Let GRILLA.TextMatrix(1, 8) = "Operación":      Let GRILLA.ColWidth(8) = 1000:   Let GRILLA.ColAlignment(8) = flexAlignLeftCenter
   Let GRILLA.TextMatrix(0, 9) = "Moneda":         Let GRILLA.TextMatrix(1, 9) = "":               Let GRILLA.ColWidth(9) = 850:    Let GRILLA.ColAlignment(9) = flexAlignLeftCenter
   Let GRILLA.TextMatrix(0, 10) = "Monto":         Let GRILLA.TextMatrix(1, 10) = "Liquidación":   Let GRILLA.ColWidth(10) = 1500:  Let GRILLA.ColAlignment(10) = flexAlignRightCenter
   Let GRILLA.TextMatrix(0, 11) = "Forma":         Let GRILLA.TextMatrix(1, 11) = "Pago":          Let GRILLA.ColWidth(11) = 1500:  Let GRILLA.ColAlignment(11) = flexAlignLeftCenter
   Let GRILLA.TextMatrix(0, 12) = "Fecha":         Let GRILLA.TextMatrix(1, 12) = "Liquidación":   Let GRILLA.ColWidth(12) = 1200:  Let GRILLA.ColAlignment(12) = flexAlignLeftCenter
   Let GRILLA.TextMatrix(0, 13) = "Corresponsal":  Let GRILLA.TextMatrix(1, 13) = "Liquidación":   Let GRILLA.ColWidth(13) = 2500:  Let GRILLA.ColAlignment(13) = flexAlignLeftCenter
   Let GRILLA.TextMatrix(0, 14) = "MT":            Let GRILLA.TextMatrix(1, 14) = "":              Let GRILLA.ColWidth(14) = 1000:  Let GRILLA.ColAlignment(14) = flexAlignLeftCenter
   Let GRILLA.TextMatrix(0, 15) = "Conteo":        Let GRILLA.TextMatrix(1, 15) = "":              Let GRILLA.ColWidth(15) = 0:     Let GRILLA.ColAlignment(15) = flexAlignLeftCenter
   Let GRILLA.Font.Bold = False
   
   Call CmdEstado.AddItem("<< TODOS >>"):          Let CmdEstado.ItemData(CmdEstado.NewIndex) = 0
   Call CmdEstado.AddItem("<< AGRUPADOS >>"):      Let CmdEstado.ItemData(CmdEstado.NewIndex) = 1
   Call CmdEstado.AddItem("<< DESAGRUPADOS >>"):   Let CmdEstado.ItemData(CmdEstado.NewIndex) = 2
    Let CmdEstado.ListIndex = 0
   
   
   Let GRUPO.Rows = 3:    Let GRUPO.FixedRows = 2
   Let GRUPO.Cols = 16:   Let GRUPO.FixedCols = 0
   Let GRUPO.TextMatrix(0, 0) = "M":              Let GRUPO.TextMatrix(1, 0) = "":               Let GRUPO.ColWidth(0) = 500:    Let GRUPO.ColAlignment(0) = flexAlignLeftCenter
   Let GRUPO.TextMatrix(0, 1) = "Agrupado":       Let GRUPO.TextMatrix(1, 1) = "":               Let GRUPO.ColWidth(1) = 800:    Let GRUPO.ColAlignment(1) = flexAlignLeftCenter
   Let GRUPO.TextMatrix(0, 2) = "N°":             Let GRUPO.TextMatrix(1, 2) = "Grupo":          Let GRUPO.ColWidth(2) = 800:    Let GRUPO.ColAlignment(2) = flexAlignRightCenter
   Let GRUPO.TextMatrix(0, 3) = "Enviada":        Let GRUPO.TextMatrix(1, 3) = "":               Let GRUPO.ColWidth(3) = 0:      Let GRUPO.ColAlignment(3) = flexAlignLeftCenter
   Let GRUPO.TextMatrix(0, 4) = "Modulo":         Let GRUPO.TextMatrix(1, 4) = "":               Let GRUPO.ColWidth(4) = 1000:   Let GRUPO.ColAlignment(4) = flexAlignLeftCenter
   Let GRUPO.TextMatrix(0, 5) = "Tipo":           Let GRUPO.TextMatrix(1, 5) = "Operación":      Let GRUPO.ColWidth(5) = 1000:   Let GRUPO.ColAlignment(5) = flexAlignLeftCenter
   Let GRUPO.TextMatrix(0, 6) = "Numero":         Let GRUPO.TextMatrix(1, 6) = "Operación":      Let GRUPO.ColWidth(6) = 0:      Let GRUPO.ColAlignment(6) = flexAlignRightCenter
   Let GRUPO.TextMatrix(0, 7) = "Nombre":         Let GRUPO.TextMatrix(1, 7) = "Cliente":        Let GRUPO.ColWidth(7) = 3000:   Let GRUPO.ColAlignment(7) = flexAlignLeftCenter
   Let GRUPO.TextMatrix(0, 8) = "Fecha":          Let GRUPO.TextMatrix(1, 8) = "Operación":      Let GRUPO.ColWidth(8) = 0:      Let GRUPO.ColAlignment(8) = flexAlignLeftCenter
   Let GRUPO.TextMatrix(0, 9) = "Moneda":         Let GRUPO.TextMatrix(1, 9) = "":               Let GRUPO.ColWidth(9) = 850:    Let GRUPO.ColAlignment(9) = flexAlignLeftCenter
   Let GRUPO.TextMatrix(0, 10) = "Monto":         Let GRUPO.TextMatrix(1, 10) = "Liquidación":   Let GRUPO.ColWidth(10) = 1500:  Let GRUPO.ColAlignment(10) = flexAlignRightCenter
   Let GRUPO.TextMatrix(0, 11) = "Forma":         Let GRUPO.TextMatrix(1, 11) = "Pago":          Let GRUPO.ColWidth(11) = 1500:  Let GRUPO.ColAlignment(11) = flexAlignLeftCenter
   Let GRUPO.TextMatrix(0, 12) = "Fecha":         Let GRUPO.TextMatrix(1, 12) = "Liquidación":   Let GRUPO.ColWidth(12) = 1200:  Let GRUPO.ColAlignment(12) = flexAlignLeftCenter
   Let GRUPO.TextMatrix(0, 13) = "Corresponsal":  Let GRUPO.TextMatrix(1, 13) = "Liquidación":   Let GRUPO.ColWidth(13) = 2500:  Let GRUPO.ColAlignment(13) = flexAlignLeftCenter
   Let GRUPO.TextMatrix(0, 14) = "MT":            Let GRUPO.TextMatrix(1, 14) = "":              Let GRUPO.ColWidth(14) = 1000:  Let GRUPO.ColAlignment(14) = flexAlignLeftCenter
   Let GRUPO.TextMatrix(0, 15) = "Conteo":        Let GRUPO.TextMatrix(1, 15) = "":              Let GRUPO.ColWidth(15) = 0:     Let GRUPO.ColAlignment(15) = flexAlignLeftCenter
   Let GRUPO.Font.Bold = False
   
End Sub

Private Sub CARGA_SISTEMAS()
   Dim DATOS()

   Call CmbSistema.AddItem("<< TODOS >>" & Space(90) & " ")

   Envia = Array()
   AddParam Envia, CDbl(1)
   If Bac_Sql_Execute("SP_CARGA_VARIABLES", Envia) Then
      Do While Bac_SQL_Fetch(DATOS())
         Call CmbSistema.AddItem(DATOS(2) & Space(90) & DATOS(1))
      Loop
      If CmbSistema.ListCount > 0 Then
         Let CmbSistema.ListIndex = 0
      End If
   End If
End Sub

Private Sub CARGA_TIPOOPERACION()
   Dim DATOS()
   
   Call CmbTipoOperacion.Clear
   Call CmbTipoOperacion.AddItem("<< TODOS >>" & Space(90) & " ")
   
   Envia = Array()
   AddParam Envia, CDbl(2)
   AddParam Envia, Right(CmbSistema.List(CmbSistema.ListIndex), 3)
   If Bac_Sql_Execute("SP_CARGA_VARIABLES", Envia) Then
      Do While Bac_SQL_Fetch(DATOS())
         Call CmbTipoOperacion.AddItem(DATOS(2) & Space(90) & DATOS(1))
      Loop
   End If
   Let CmbTipoOperacion.ListIndex = 0
End Sub

Private Sub CARGA_MONEDAS()
   Dim DATOS()
   Dim iIndicadorDef As String
   
   Call CmbMonPago.Clear
   Call CmbMonPago.AddItem("<< TODAS >>")
    Let CmbMonPago.ItemData(CmbMonPago.NewIndex) = 0


   Envia = Array()
   AddParam Envia, CDbl(3)
   If Bac_Sql_Execute("SP_CARGA_VARIABLES", Envia) Then
      Do While Bac_SQL_Fetch(DATOS())
         Call CmbMonPago.AddItem(DATOS(2))
         Let CmbMonPago.ItemData(CmbMonPago.NewIndex) = Val(DATOS(1))
         If Val(DATOS(1)) = 999 Then
            Let iIndicadorDef = DATOS(2)
         End If
      Loop
      Let CmbMonPago.Text = iIndicadorDef
   End If
End Sub

Private Sub CARGA_MEDIOPAGO()
   Dim DATOS()
   Dim cModulo    As String
   Dim iMoneda    As Integer
   
   Let cModulo = ""
   If CmbSistema.ListIndex >= 0 Then Let cModulo = Right(CmbSistema.List(CmbSistema.ListIndex), 3)
   
   Call CmbMedioPago.Clear
   Call CmbMedioPago.AddItem("<< TODAS >>")
    Let CmbMedioPago.ItemData(CmbMedioPago.NewIndex) = 0
   
   Envia = Array()
   AddParam Envia, CDbl(4)
   AddParam Envia, Trim(cModulo)
   If Bac_Sql_Execute("SP_CARGA_VARIABLES", Envia) Then
      Do While Bac_SQL_Fetch(DATOS())
         Call CmbMedioPago.AddItem(DATOS(2))
         Let CmbMedioPago.ItemData(CmbMedioPago.NewIndex) = DATOS(1)
      Loop
   End If
   Let CmbMedioPago.ListIndex = 0
End Sub


Private Sub cmbSistema_Click()
   If CmbSistema.ListIndex < 0 Then
      Exit Sub
   End If
   Call CARGA_TIPOOPERACION
   Call CARGA_MEDIOPAGO
   Call CARGA_MONEDAS

   Let CmbTipoOperacion.Enabled = True
   Let CmbMonPago.Enabled = True
   Let CmbMedioPago.Enabled = True
   Let TxtRut.Enabled = True
   Let CmdEstado.Enabled = True
End Sub

Private Sub LIMPIAR_PANTALLA()
   CmbSistema.ListIndex = 0
End Sub

Private Sub Form_Load()
   Let Me.Icon = BacGenMensaje.Icon
   
   Let TxtValuta.Text = Format(gsbac_fecp, "DD/MM/YYYY")
   
   Call CAMPOS_GRILLA
   Call CARGA_SISTEMAS
   Call CARGA_MONEDAS
   Call CARGA_MEDIOPAGO
   
   Call BUSCAR_OPERACIONES
End Sub

Private Sub MARCAR_GRUPO()
   Static iContador  As Long
   Dim iNumoper      As Long

   If GRUPO.RowSel < 2 Then
      Exit Sub
   End If

   If Trim(GRUPO.TextMatrix(GRUPO.RowSel, 0)) = "M" Then
      Let iContador = iContador - 1

      Let GRUPO.TextMatrix(GRUPO.RowSel, 0) = ""
      Let GRUPO.TextMatrix(GRUPO.RowSel, 15) = 0
      Let GRUPO.CellPictureAlignment = 4
      Set GRUPO.CellPicture = SinCheck(0).Picture
   Else
      Let iContador = iContador + 1

      Let GRUPO.TextMatrix(GRUPO.RowSel, 0) = Space(100) & "M"
      Let GRUPO.TextMatrix(GRUPO.RowSel, 15) = iContador
      Let GRUPO.CellPictureAlignment = 4
      Set GRUPO.CellPicture = ConCheck(0).Picture
   End If

End Sub

Private Sub MARCAR_GRILLA(ByVal nFila As Long)
   Static iContador  As Long
   Dim iNumoper      As Long

   If GRILLA.RowSel < 2 Then
      Exit Sub
   End If

   If Trim(GRILLA.TextMatrix(nFila, 0)) = "M" Then
      Let iContador = iContador - 1

      Let GRILLA.TextMatrix(nFila, 0) = ""
      Let GRILLA.TextMatrix(nFila, 15) = 0
      Let GRILLA.CellPictureAlignment = 4
      Set GRILLA.CellPicture = SinCheck(0).Picture
   Else
      Let iContador = iContador + 1

      Let GRILLA.TextMatrix(nFila, 0) = Space(100) & "M"
      Let GRILLA.TextMatrix(nFila, 15) = iContador
      Let GRILLA.CellPictureAlignment = 4
      Set GRILLA.CellPicture = ConCheck(0).Picture
   End If
   Call PRE_AGRUPACION(nFila)
End Sub

Private Sub GRILLA_Click()
   If GRILLA.ColSel = 0 Then
      Call MARCAR_GRILLA(GRILLA.RowSel)
   End If
End Sub

Private Sub GRILLA_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeySpace Then
      Call MARCAR_GRILLA(GRILLA.RowSel)
   End If
End Sub

Private Sub PINTAR_GRILLA(ByVal Color_Caja As Variant, ByVal Color_Letra As Variant)
   Dim iContador  As Integer
   Dim iPuntero   As Integer
   
   Let iPuntero = GRILLA.ColSel
   
   Let GRILLA.Redraw = False
   For iContador = 0 To GRILLA.Cols - 1
      Let GRILLA.Row = GRILLA.RowSel
      Let GRILLA.Col = iContador
      Let GRILLA.CellBackColor = Color_Caja
      Let GRILLA.CellForeColor = Color_Letra
   Next iContador
   Let GRILLA.Redraw = True
   
   Let GRILLA.Col = iPuntero
End Sub

Private Sub GRUPO_Click()
   Call MARCAR_GRUPO
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 2
         
      Case 3
         Call BUSCAR_OPERACIONES
      Case 4
         Unload Me
   End Select
End Sub

Private Sub TxtRut_Change()
   If TxtRut.Text = "" Then
      TxtRut.Text = 0
      TxtCodigo.Text = 0
   End If
End Sub

Private Sub TxtRut_DblClick()
    Let BacAyuda.Tag = "MDCL"
   Call BacAyuda.Show(vbModal)

   If giAceptar = True Then
      TxtRut.Text = Format(Trim(gsrut), FEntero) & "-" & gsDigito$
      TxtCodigo.Text = gsValor$
      Me.TxtNombre.Text = Trim(gsNombre$)
   End If
End Sub


Private Sub TxtRut_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyDelete Then
      Let TxtRut.Text = "0"
      Let TxtCodigo.Text = 0
      Let TxtNombre.Text = ""
   End If
End Sub


