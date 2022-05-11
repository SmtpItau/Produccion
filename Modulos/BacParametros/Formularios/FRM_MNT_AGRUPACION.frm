VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form FRM_MNT_AGRUPACION 
   Caption         =   "AGRUPACION DE OPERACIONES"
   ClientHeight    =   7455
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   13590
   LinkTopic       =   "Form2"
   ScaleHeight     =   7455
   ScaleWidth      =   13590
   StartUpPosition =   2  'CenterScreen
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   13590
      _ExtentX        =   23971
      _ExtentY        =   794
      ButtonWidth     =   1931
      ButtonHeight    =   741
      Appearance      =   1
      Style           =   1
      TextAlignment   =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "&Buscar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "&Grabar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "&Cerrar"
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin VB.PictureBox SinCheck 
         BorderStyle     =   0  'None
         Height          =   345
         Index           =   0
         Left            =   3795
         Picture         =   "FRM_MNT_AGRUPACION.frx":0000
         ScaleHeight     =   345
         ScaleWidth      =   375
         TabIndex        =   19
         Top             =   45
         Visible         =   0   'False
         Width           =   375
      End
      Begin VB.PictureBox ConCheck 
         BorderStyle     =   0  'None
         Height          =   360
         Index           =   0
         Left            =   4095
         Picture         =   "FRM_MNT_AGRUPACION.frx":015A
         ScaleHeight     =   360
         ScaleWidth      =   405
         TabIndex        =   18
         Top             =   45
         Visible         =   0   'False
         Width           =   405
      End
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   7350
         Top             =   15
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
               Picture         =   "FRM_MNT_AGRUPACION.frx":02B4
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_AGRUPACION.frx":118E
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_AGRUPACION.frx":2068
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_AGRUPACION.frx":2382
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame Frame1 
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   4800
      Left            =   45
      TabIndex        =   1
      Top             =   375
      Width           =   3285
      Begin MSComctlLib.Toolbar Toolbar2 
         Height          =   450
         Left            =   45
         TabIndex        =   27
         Top             =   4290
         Width           =   3150
         _ExtentX        =   5556
         _ExtentY        =   794
         ButtonWidth     =   2302
         ButtonHeight    =   741
         AllowCustomize  =   0   'False
         Wrappable       =   0   'False
         Appearance      =   1
         Style           =   1
         TextAlignment   =   1
         ImageList       =   "ImageList1"
         _Version        =   393216
         BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
            NumButtons      =   1
            BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Caption         =   "Agrupar ..."
               ImageIndex      =   4
            EndProperty
         EndProperty
         BorderStyle     =   1
      End
      Begin VB.Frame Frame6 
         Height          =   75
         Left            =   30
         TabIndex        =   26
         Top             =   4185
         Width           =   3210
      End
      Begin VB.Frame Frame4 
         Height          =   75
         Left            =   30
         TabIndex        =   23
         Top             =   3375
         Width           =   3210
      End
      Begin VB.Frame Frame3 
         Height          =   75
         Left            =   30
         TabIndex        =   22
         Top             =   495
         Width           =   3210
      End
      Begin VB.ComboBox CMB_ESTADO 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   60
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   21
         Top             =   2985
         Width           =   3105
      End
      Begin VB.TextBox TxtCodigo 
         Alignment       =   2  'Center
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   2910
         Locked          =   -1  'True
         TabIndex        =   15
         Text            =   "0"
         Top             =   3510
         Width           =   270
      End
      Begin VB.TextBox TxtNombre 
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   45
         Locked          =   -1  'True
         TabIndex        =   14
         Top             =   3855
         Width           =   3150
      End
      Begin VB.TextBox TxtRut 
         Alignment       =   1  'Right Justify
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   1365
         Locked          =   -1  'True
         TabIndex        =   13
         Text            =   "0"
         Top             =   3510
         Width           =   1515
      End
      Begin VB.ComboBox CMB_MEDIOPAGO 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   60
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   8
         Top             =   2430
         Width           =   3105
      End
      Begin VB.ComboBox CMB_MONEDA 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   60
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   7
         Top             =   1890
         Width           =   3105
      End
      Begin VB.ComboBox CMB_TIPOOPERACION 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   60
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   5
         Top             =   1335
         Width           =   3105
      End
      Begin VB.ComboBox CMB_SISTEMA 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   60
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   3
         Top             =   765
         Width           =   3105
      End
      Begin BACControles.TXTFecha TxtValuta 
         Height          =   315
         Left            =   1725
         TabIndex        =   11
         Top             =   165
         Width           =   1380
         _ExtentX        =   2434
         _ExtentY        =   556
         Enabled         =   -1  'True
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
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
      Begin VB.Label Label1 
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
         Index           =   4
         Left            =   60
         TabIndex        =   20
         Top             =   2790
         Width           =   555
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Cliente"
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
         Left            =   60
         TabIndex        =   12
         Top             =   3570
         Width           =   585
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
         Index           =   1
         Left            =   60
         TabIndex        =   10
         Top             =   210
         Width           =   510
      End
      Begin VB.Label Label1 
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
         Left            =   60
         TabIndex        =   9
         Top             =   2235
         Width           =   1215
      End
      Begin VB.Label Label1 
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
         Left            =   60
         TabIndex        =   6
         Top             =   1695
         Width           =   1110
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Tipo Operación"
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
         Left            =   60
         TabIndex        =   4
         Top             =   1125
         Width           =   1245
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Modulo"
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
         Left            =   60
         TabIndex        =   2
         Top             =   570
         Width           =   615
      End
   End
   Begin VB.Frame Frame2 
      Height          =   4785
      Left            =   3345
      TabIndex        =   16
      Top             =   390
      Width           =   10200
      Begin MSFlexGridLib.MSFlexGrid GRD 
         Height          =   4590
         Left            =   60
         TabIndex        =   17
         Top             =   135
         Width           =   10050
         _ExtentX        =   17727
         _ExtentY        =   8096
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
   Begin VB.Frame Frame5 
      Height          =   2355
      Left            =   30
      TabIndex        =   24
      Top             =   5100
      Width           =   13500
      Begin MSFlexGridLib.MSFlexGrid GRUP 
         Height          =   2145
         Left            =   60
         TabIndex        =   25
         Top             =   135
         Width           =   13365
         _ExtentX        =   23574
         _ExtentY        =   3784
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
Attribute VB_Name = "FRM_MNT_AGRUPACION"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub NOMBRES_GRUPO()
   GRUP.Rows = 3:  GRUP.FixedRows = 2
   GRUP.Cols = 17: GRUP.FixedCols = 0
   
   GRUP.TextMatrix(0, 0) = "MARCA":           GRUP.TextMatrix(1, 0) = "":                GRUP.ColWidth(0) = 0
   GRUP.TextMatrix(0, 1) = "MODULO":          GRUP.TextMatrix(1, 1) = "":                GRUP.ColWidth(1) = 1000
   GRUP.TextMatrix(0, 2) = "TIPO":            GRUP.TextMatrix(1, 2) = "OPER.":           GRUP.ColWidth(2) = 1000
   GRUP.TextMatrix(0, 3) = "NUMERO":          GRUP.TextMatrix(1, 3) = "OPER":            GRUP.ColWidth(3) = 0
   GRUP.TextMatrix(0, 4) = "RUT":             GRUP.TextMatrix(1, 4) = "CLIENTE":         GRUP.ColWidth(4) = 0
   GRUP.TextMatrix(0, 5) = "CODIGO":          GRUP.TextMatrix(1, 5) = "CLIENTE":         GRUP.ColWidth(5) = 0
   GRUP.TextMatrix(0, 6) = "NOMBRE":          GRUP.TextMatrix(1, 6) = "CLIENTE":         GRUP.ColWidth(6) = 2500
   GRUP.TextMatrix(0, 7) = "MONEDA":          GRUP.TextMatrix(1, 7) = "PAGO":            GRUP.ColWidth(7) = 1000
   GRUP.TextMatrix(0, 8) = "MONTO":           GRUP.TextMatrix(1, 8) = "":                GRUP.ColWidth(8) = 1500
   GRUP.TextMatrix(0, 9) = "MEDIO":           GRUP.TextMatrix(1, 9) = "PAGO":            GRUP.ColWidth(9) = 1500
   GRUP.TextMatrix(0, 10) = "TIPO":           GRUP.TextMatrix(1, 10) = "MOVIMIENTO":     GRUP.ColWidth(10) = 1500
   GRUP.TextMatrix(0, 11) = "CORRESPONSAL":   GRUP.TextMatrix(1, 11) = "":               GRUP.ColWidth(11) = 2500
   GRUP.TextMatrix(0, 12) = "MENSAJE":        GRUP.TextMatrix(1, 12) = "":               GRUP.ColWidth(12) = 1500
   
   GRUP.TextMatrix(0, 13) = "":               GRUP.TextMatrix(1, 13) = "":               GRUP.ColWidth(13) = 0
   GRUP.TextMatrix(0, 14) = "":               GRUP.TextMatrix(1, 14) = "":               GRUP.ColWidth(14) = 0
   GRUP.TextMatrix(0, 15) = "":               GRUP.TextMatrix(1, 15) = "":               GRUP.ColWidth(15) = 0
   GRUP.TextMatrix(0, 16) = "":               GRUP.TextMatrix(1, 16) = "":               GRUP.ColWidth(16) = 0
   GRUP.Rows = 2
End Sub

Private Sub Nombres_Grilla()
   GRD.Rows = 3:  GRD.FixedRows = 2
   GRD.Cols = 17: GRD.FixedCols = 0
   GRD.TextMatrix(0, 0) = "MARCA":           GRD.TextMatrix(1, 0) = "":                GRD.ColWidth(0) = 800
   GRD.TextMatrix(0, 1) = "MODULO":          GRD.TextMatrix(1, 1) = "":                GRD.ColWidth(1) = 1000
   GRD.TextMatrix(0, 2) = "TIPO":            GRD.TextMatrix(1, 2) = "OPER.":           GRD.ColWidth(2) = 1000
   GRD.TextMatrix(0, 3) = "NUMERO":          GRD.TextMatrix(1, 3) = "OPER":            GRD.ColWidth(3) = 1000
   GRD.TextMatrix(0, 4) = "RUT":             GRD.TextMatrix(1, 4) = "CLIENTE":         GRD.ColWidth(4) = 0
   GRD.TextMatrix(0, 5) = "CODIGO":          GRD.TextMatrix(1, 5) = "CLIENTE":         GRD.ColWidth(5) = 0
   GRD.TextMatrix(0, 6) = "NOMBRE":          GRD.TextMatrix(1, 6) = "CLIENTE":         GRD.ColWidth(6) = 2500
   GRD.TextMatrix(0, 7) = "MONEDA":          GRD.TextMatrix(1, 7) = "PAGO":            GRD.ColWidth(7) = 1000
   GRD.TextMatrix(0, 8) = "MONTO":           GRD.TextMatrix(1, 8) = "":                GRD.ColWidth(8) = 1500
   GRD.TextMatrix(0, 9) = "MEDIO":           GRD.TextMatrix(1, 9) = "PAGO":            GRD.ColWidth(9) = 1500
   GRD.TextMatrix(0, 10) = "TIPO":           GRD.TextMatrix(1, 10) = "MOVIMIENTO":     GRD.ColWidth(10) = 1500
   GRD.TextMatrix(0, 11) = "CORRESPONSAL":   GRD.TextMatrix(1, 11) = "":               GRD.ColWidth(11) = 2500
   GRD.TextMatrix(0, 12) = "MENSAJE":        GRD.TextMatrix(1, 12) = "":               GRD.ColWidth(12) = 1500
   
   GRD.TextMatrix(0, 13) = "":               GRD.TextMatrix(1, 13) = "":               GRD.ColWidth(13) = 0
   GRD.TextMatrix(0, 14) = "":               GRD.TextMatrix(1, 14) = "":               GRD.ColWidth(14) = 0
   GRD.TextMatrix(0, 15) = "":               GRD.TextMatrix(1, 15) = "":               GRD.ColWidth(15) = 0
   GRD.TextMatrix(0, 16) = "":               GRD.TextMatrix(1, 16) = "":               GRD.ColWidth(16) = 0
   GRD.Rows = 2
End Sub

Private Sub BUSCAR_DATOS()
   Dim DATOS()
   Dim iFolio  As Integer

   Let iFolio = 0
   If Left(CMB_ESTADO.Text, 1) = "A" Then
      If GRUP.Rows > 2 Then
         Let iFolio = GRUP.TextMatrix(GRUP.RowSel, 3)
      End If
   End If
   
   Envia = Array()
   AddParam Envia, CDbl(1)
   AddParam Envia, Format(TxtValuta.Text, "YYYYMMDD")
   AddParam Envia, CDbl(0)
   AddParam Envia, Trim(Right(CMB_SISTEMA.Text, 3))
   AddParam Envia, Trim(Right(CMB_TIPOOPERACION.Text, 6))
   AddParam Envia, Val(TxtRut.Tag)
   AddParam Envia, CDbl(TxtCodigo.Text)
   AddParam Envia, Val(Trim(Right(CMB_MONEDA.Text, 5)))
   AddParam Envia, Val(Trim(Right(CMB_MEDIOPAGO, 5)))
   AddParam Envia, Trim(Right(CMB_ESTADO.Text, 5))
   AddParam Envia, gsBAC_User
   AddParam Envia, iFolio
   If Not Bac_Sql_Execute("dbo.SP_MNT_AGRUPACION", Envia) Then
      Exit Sub
   End If

   Let GRD.Rows = 2: Let GRD.Col = 0
   Let GRD.Redraw = False

   Do While Bac_SQL_Fetch(DATOS())
      Let GRD.Rows = GRD.Rows + 1
       Let GRD.Row = GRD.Rows - 1

      GRD.TextMatrix(GRD.Rows - 1, 0) = DATOS(1)
      GRD.TextMatrix(GRD.Rows - 1, 1) = DATOS(2)
      GRD.TextMatrix(GRD.Rows - 1, 2) = DATOS(3)
      GRD.TextMatrix(GRD.Rows - 1, 3) = DATOS(4)
      GRD.TextMatrix(GRD.Rows - 1, 4) = DATOS(5)
      GRD.TextMatrix(GRD.Rows - 1, 5) = DATOS(6)
      GRD.TextMatrix(GRD.Rows - 1, 6) = DATOS(7)
      GRD.TextMatrix(GRD.Rows - 1, 7) = DATOS(8)
      GRD.TextMatrix(GRD.Rows - 1, 8) = IIf(DATOS(8) = "CLP", Format(DATOS(9), FEntero), Format(DATOS(9), FDecimal))
      GRD.TextMatrix(GRD.Rows - 1, 9) = DATOS(10)
      GRD.TextMatrix(GRD.Rows - 1, 10) = DATOS(11)
      GRD.TextMatrix(GRD.Rows - 1, 11) = DATOS(12)
      GRD.TextMatrix(GRD.Rows - 1, 12) = DATOS(13)
      GRD.TextMatrix(GRD.Rows - 1, 16) = DATOS(14)

      If DATOS(1) = "" Then
         Set GRD.CellPicture = SinCheck(0).Picture
         Let GRD.TextMatrix(GRD.Rows - 1, 0) = Space(100) & ""
      Else
         Set GRD.CellPicture = ConCheck(0).Picture
         Let GRD.TextMatrix(GRD.Rows - 1, 0) = Space(100) & "M"
      End If
      Let Toolbar2.Buttons.Item(1).Enabled = True
   Loop

   Let GRD.Redraw = True

   If Toolbar2.Buttons.Item(1).Caption = "Desagrupar ..." Then
      Let GRD.Enabled = False
   Else
      Let GRD.Enabled = True
   End If
End Sub

Private Sub MOSTAR_GRUPOS()
   Dim DATOS()
   
   Envia = Array()
   AddParam Envia, CDbl(7)
   AddParam Envia, Format(TxtValuta.Text, "YYYYMMDD")
   AddParam Envia, CDbl(0)
   AddParam Envia, Trim(Right(CMB_SISTEMA.Text, 3))
   AddParam Envia, Trim(Right(CMB_TIPOOPERACION.Text, 6))
   AddParam Envia, Val(TxtRut.Tag)
   AddParam Envia, CDbl(TxtCodigo.Text)
   AddParam Envia, Val(Trim(Right(CMB_MONEDA.Text, 5)))
   AddParam Envia, Val(Trim(Right(CMB_MEDIOPAGO, 5)))
   AddParam Envia, Trim(Right(CMB_ESTADO.Text, 5))
   AddParam Envia, gsBAC_User
   If Not Bac_Sql_Execute("dbo.SP_MNT_AGRUPACION", Envia) Then
      Exit Sub
   End If
   Let GRUP.Rows = 2
   Let GRUP.Redraw = False
   Do While Bac_SQL_Fetch(DATOS())
      GRUP.Rows = GRUP.Rows + 1
      GRUP.Row = GRUP.Rows - 1
      GRUP.TextMatrix(GRUP.Rows - 1, 0) = DATOS(1)
      GRUP.TextMatrix(GRUP.Rows - 1, 1) = DATOS(2)
      GRUP.TextMatrix(GRUP.Rows - 1, 2) = DATOS(3)
      GRUP.TextMatrix(GRUP.Rows - 1, 3) = DATOS(4)
      GRUP.TextMatrix(GRUP.Rows - 1, 4) = DATOS(5)
      GRUP.TextMatrix(GRUP.Rows - 1, 5) = DATOS(6)
      GRUP.TextMatrix(GRUP.Rows - 1, 6) = DATOS(7)
      GRUP.TextMatrix(GRUP.Rows - 1, 7) = DATOS(8)
      GRUP.TextMatrix(GRUP.Rows - 1, 8) = IIf(DATOS(8) = "CLP", Format(DATOS(9), FEntero), Format(DATOS(9), FDecimal))
      GRUP.TextMatrix(GRUP.Rows - 1, 9) = DATOS(10)
      GRUP.TextMatrix(GRUP.Rows - 1, 10) = DATOS(11)
      GRUP.TextMatrix(GRUP.Rows - 1, 11) = DATOS(12)
      GRUP.TextMatrix(GRUP.Rows - 1, 12) = DATOS(13)
      GRUP.TextMatrix(GRUP.Rows - 1, 16) = DATOS(14)

      Set GRUP.CellPicture = SinCheck(0).Picture
      Let GRUP.TextMatrix(GRUP.Rows - 1, 0) = Space(100) & ""
      Let Toolbar2.Buttons.Item(1).Enabled = True
   Loop
   Let GRUP.Redraw = True
End Sub

Private Sub CARGAR_SISTEMAS()
   Dim DATOS()

   CMB_SISTEMA.Clear
   CMB_SISTEMA.AddItem "<< TODOS >>" & Space(100) & " "

   Envia = Array()
   AddParam Envia, CDbl(1)
   If Not Bac_Sql_Execute("dbo.SP_CARGA_VARIABLES", Envia) Then
      Exit Sub
   End If
   Do While Bac_SQL_Fetch(DATOS())
      CMB_SISTEMA.AddItem DATOS(2) & Space(100) & DATOS(1)
   Loop
   Let CMB_SISTEMA.ListIndex = 0
End Sub

Private Sub CARGAR_TIPO_OPERACION()
   Dim DATOS()
   Dim cSistema   As String
   
   CMB_TIPOOPERACION.Clear
   CMB_TIPOOPERACION.AddItem "<< TODOS >>" & Space(100) & " "
   
   Envia = Array()
   AddParam Envia, CDbl(2)
   If CMB_SISTEMA.ListIndex > 0 Then
      cSistema = Right(CMB_SISTEMA, 3)
      AddParam Envia, cSistema
   End If
   If Not Bac_Sql_Execute("dbo.SP_CARGA_VARIABLES", Envia) Then
      Exit Sub
   End If
   Do While Bac_SQL_Fetch(DATOS())
      CMB_TIPOOPERACION.AddItem DATOS(3) & Space(100) & DATOS(2)
   Loop
   Let CMB_TIPOOPERACION.ListIndex = 0
End Sub

Private Sub CARGAR_MONEDA_PAGO()
   Dim DATOS()
   
   CMB_MONEDA.Clear
   CMB_MONEDA.AddItem "<< TODOS >>" & Space(100) & 0
   
   Envia = Array()
   AddParam Envia, CDbl(3)
   If Not Bac_Sql_Execute("dbo.SP_CARGA_VARIABLES", Envia) Then
      Exit Sub
   End If
   Do While Bac_SQL_Fetch(DATOS())
      CMB_MONEDA.AddItem DATOS(2) & Space(100) & DATOS(1)
   Loop
   Let CMB_MONEDA.ListIndex = 2
End Sub

Private Sub CARGAR_MEDIO_PAGO()
   Dim DATOS()
   
   CMB_MEDIOPAGO.Clear
   CMB_MEDIOPAGO.AddItem "<< TODOS >>" & Space(100) & 0
   
   Envia = Array()
   AddParam Envia, CDbl(4)
   If Not Bac_Sql_Execute("dbo.SP_CARGA_VARIABLES", Envia) Then
      Exit Sub
   End If
   Do While Bac_SQL_Fetch(DATOS())
      CMB_MEDIOPAGO.AddItem DATOS(2) & Space(100) & DATOS(1)
   Loop
   Let CMB_MEDIOPAGO.ListIndex = 0
End Sub

Private Sub CARGAR_ESTADOS()
   CMB_ESTADO.AddItem "DESAGRUPADAS" & Space(100) & "D"
   CMB_ESTADO.AddItem "AGRUPADAS" & Space(100) & "A"
   CMB_ESTADO.Text = "DESAGRUPADAS" & Space(100) & "D"
End Sub

Private Sub CMB_ESTADO_Click()
   Let GRD.Rows = 2
   Let GRUP.Rows = 2
   If Left(CMB_ESTADO.Text, 1) = "D" Then
      Let Toolbar2.Buttons(1).Caption = "Agrupar ..."
      Let GRUP.ColWidth(0) = 0
      Call BUSCAR_DATOS
   Else
      Let Toolbar2.Buttons(1).Caption = "Desagrupar ..."
      Let GRUP.ColWidth(0) = 800
      Call MOSTAR_GRUPOS
   End If
End Sub

Private Sub Cmb_Sistema_Click()
   Call CARGAR_TIPO_OPERACION
End Sub

Private Sub Form_Load()
   Let TxtValuta.Text = gsbac_fecp

   Call CARGAR_SISTEMAS
   Call CARGAR_TIPO_OPERACION
   Call CARGAR_MONEDA_PAGO
   Call CARGAR_MEDIO_PAGO
   Call Nombres_Grilla
   Call NOMBRES_GRUPO

   Call CARGAR_ESTADOS
   Let Toolbar2.Buttons.Item(1).Enabled = False
   Let Toolbar1.Buttons(2).Enabled = False
End Sub

Private Sub Form_Resize()
   On Error Resume Next

   Let Frame2.Width = Me.Width - 3500
   Let GRD.Width = Frame2.Width - 150
   Let Frame5.Width = Me.Width - 180
   Let GRUP.Width = Frame5.Width - 150
   Let Frame5.Height = Me.Height - 5800
   Let GRUP.Height = Frame5.Height - 250

   On Error GoTo 0
End Sub

Private Sub Form_Unload(Cancel As Integer)
   Envia = Array()
   AddParam Envia, CDbl(4)
   AddParam Envia, Format(TxtValuta.Text, YYYYMMDD)
   AddParam Envia, GRD.TextMatrix(GRD.RowSel, 3)
   AddParam Envia, ""
   AddParam Envia, ""
   AddParam Envia, CDbl(0)
   AddParam Envia, CDbl(0)
   AddParam Envia, CDbl(0)
   AddParam Envia, CDbl(0)
   AddParam Envia, "D"
   AddParam Envia, gsBAC_User
   If Not Bac_Sql_Execute("dbo.SP_MNT_AGRUPACION", Envia) Then
      Exit Sub
   End If
End Sub

Private Sub GRD_Click()
   Call MARCAR_GRILLA(GRD.RowSel)
End Sub

Private Sub GRD_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      Call MARCAR_GRILLA(GRD.RowSel)
   End If
End Sub

Private Sub GRUP_Click()
   Dim iContador  As Long
   Dim iFila      As Long

   Let GRUP.Redraw = False
   Let iFila = GRUP.RowSel
   For iContador = 2 To GRUP.Rows - 1
      Let GRUP.Col = 0
      Let GRUP.Row = iContador
      Let GRUP.TextMatrix(iContador, 0) = ""
      Set GRUP.CellPicture = SinCheck(0).Picture
   Next iContador
   Let GRUP.Redraw = True

   Call MARCAR_GRUP(iFila)
   Call BUSCAR_DATOS
End Sub

Private Sub GRUP_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      Call GRUP_Click
   End If
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 1
         If Left(CMB_ESTADO.Text, 1) = "A" Then
            Call MOSTAR_GRUPOS
            Let GRD.Rows = 2
         Else
            Call BUSCAR_DATOS
            Let Toolbar1.Buttons(2).Enabled = False
            Let GRUP.Rows = 2
            Let Toolbar2.Buttons(1).Enabled = False
         End If
      Case 2
         Call Grabar
      Case 3
         Unload Me
   End Select
End Sub

Private Sub Toolbar2_ButtonClick(ByVal Button As MSComctlLib.Button)
   If Left(Toolbar2.Buttons(1).Caption, 1) = "D" Then
      Call GENERA_DESAGRUPACION
   Else
      Call GENERA_AGRUPACION
   End If
End Sub

Private Sub GENERA_DESAGRUPACION()
   Dim DATOS()
   Dim iContador  As Long

   For iContador = 2 To GRUP.Rows - 1
      If Trim(GRUP.TextMatrix(iContador, 0)) = "M" Then
         If GRUP.TextMatrix(iContador, 16) = "E" Then
            MsgBox "Grupo de Operaciones, ya ha sido enviado... No se puede desagrupar", vbExclamation, App.Title
            Exit For
         End If
      
         Envia = Array()
         AddParam Envia, CDbl(8)
         AddParam Envia, Format(TxtValuta.Text, YYYYMMDD)
         AddParam Envia, CDbl(GRUP.TextMatrix(iContador, 3))
         AddParam Envia, ""
         AddParam Envia, ""
         AddParam Envia, CDbl(0)
         AddParam Envia, CDbl(0)
         AddParam Envia, CDbl(0)
         AddParam Envia, CDbl(0)
         AddParam Envia, "D"
         AddParam Envia, gsBAC_User
         If Not Bac_Sql_Execute("dbo.SP_MNT_AGRUPACION", Envia) Then
            Exit Sub
         End If
         If Bac_SQL_Fetch(DATOS()) Then
            If DATOS(1) < 0 Then
               MsgBox "W - Imposible desagrupar operaciones..." & vbCrLf & DATOS(2), vbExclamation, TITSISTEMA
               Exit Sub
            Else
               MsgBox "Operaciones han sido desagrupadas en forma correcta.", vbExclamation, TITSISTEMA
               Call MOSTAR_GRUPOS
               Let GRD.Rows = 2
               Let BacGenMensaje.iAceptarGrupo = True
               Unload Me
               Exit Sub
            End If
         End If
      End If
   Next iContador

End Sub

Private Sub TxtRut_Change()
   If TxtRut.Text = "" Then
      Let TxtRut.Text = 0
      Let TxtCodigo.Text = 0
   End If
End Sub

Private Sub TxtRut_DblClick()
   BacAyuda.Tag = "MDCL"
   BacAyuda.Show vbModal

   If giAceptar = True Then
      Let TxtRut.Text = Format(Trim(gsrut), FEntero) & "-" & gsDigito$
      Let TxtRut.Tag = gsrut
      Let TxtCodigo.Text = gsValor$
      Let TxtNombre.Text = Trim(gsNombre$)
   End If
End Sub

Private Sub TxtRut_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyDelete Then
      Let TxtRut.Text = "0"
      Let TxtCodigo.Text = 0
      Let TxtNombre.Text = ""
   End If
End Sub

Private Sub MARCAR_GRUP(ByVal nFila As Long)
   Dim iEvento    As Integer
   Dim iColsel    As Integer

   If GRUP.RowSel < 2 Then
      Exit Sub
   End If

   Let iColsel = GRUP.ColSel
   Let GRUP.Col = 0: Let GRUP.Row = nFila

   If Trim(GRUP.TextMatrix(nFila, 0)) = "M" Then
      Let GRUP.TextMatrix(nFila, 0) = ""
      Set GRUP.CellPicture = SinCheck(0).Picture
   Else
      Let GRUP.TextMatrix(nFila, 0) = Space(100) & "M"
      Set GRUP.CellPicture = ConCheck(0).Picture
   End If
   Let Toolbar2.Buttons(1).Enabled = True
   Let GRUP.Col = iColsel
End Sub

Private Sub MARCAR_GRILLA(ByVal nFila As Long)
   Dim iEvento    As Integer
   Dim iColsel    As Integer
   
   If GRD.RowSel < 2 Then Exit Sub
      
   Let iColsel = GRD.ColSel
   Let GRD.Col = 0
   If Trim(GRD.TextMatrix(nFila, 0)) = "M" Then
      Let GRD.TextMatrix(nFila, 0) = ""
      Set GRD.CellPicture = SinCheck(0).Picture
      Let iEvento = 3
   Else
      Let GRD.TextMatrix(nFila, 0) = Space(100) & "M"
      Set GRD.CellPicture = ConCheck(0).Picture
      Let iEvento = 2
   End If
   Let Toolbar2.Buttons(1).Enabled = True
   Let GRD.Col = iColsel
End Sub

Private Sub GENERA_AGRUPACION()
   Dim iFilas     As Long
   Dim iColumnas  As Long
   Dim oError     As Boolean
   Dim oFormato   As String
   Dim iCantidad  As Long
   
   Let oError = False
   
   Let GRUP.Rows = 2
   Let GRD.Redraw = False
   Let iCantidad = 0
   
   For iFilas = 2 To GRD.Rows - 1
      Call Pintar_Celdas(iFilas, &HC0C0C0, &H80000008)
      
      If Trim(GRD.TextMatrix(iFilas, 0)) = "M" Then
         If GRUP.Rows = 2 Then
            
            Let GRUP.Rows = GRUP.Rows + 1
            For iColumnas = 0 To GRD.Cols - 1
               If iColumnas = 7 Then
                  Let oFormato = IIf(GRD.TextMatrix(iFilas, iColumnas) = "CLP", FEntero, FDecimal)
               End If
               If iColumnas = 8 Then
                  Let GRUP.TextMatrix(GRUP.Rows - 1, iColumnas) = Format(CDbl(GRD.TextMatrix(iFilas, iColumnas)), oFormato)
               Else
                  Let GRUP.TextMatrix(GRUP.Rows - 1, iColumnas) = GRD.TextMatrix(iFilas, iColumnas)
               End If
            Next iColumnas
            Let iCantidad = iCantidad + 1

         Else

            For iColumnas = 1 To GRD.Cols - 1
               If (iColumnas = 3 Or iColumnas = 8) Then
                  If iColumnas = 8 Then
                     If oError = False Then
                        Let GRUP.TextMatrix(GRUP.Rows - 1, iColumnas) = Format(CDbl(GRUP.TextMatrix(GRUP.Rows - 1, iColumnas)) + CDbl(GRD.TextMatrix(iFilas, iColumnas)), oFormato)
                     End If
                  End If
               Else
                  If Not GRD.TextMatrix(iFilas, iColumnas) = GRUP.TextMatrix(GRUP.Rows - 1, iColumnas) Then
                     Call Pintar_Celdas(iFilas, vbRed, vbWhite)
                     Let oError = True
                  End If
               End If
            Next iColumnas
            Let iCantidad = iCantidad + 1
         End If
      End If
   Next iFilas

   Let GRD.Redraw = True

   If iCantidad = 1 Then
      Let Toolbar1.Buttons(2).Enabled = False
      MsgBox "No es posible generar un grupo que contenga una sola operación.", vbExclamation, App.Title
      Exit Sub
   End If

   If oError = True Then
      Let Toolbar1.Buttons(2).Enabled = False
      MsgBox "E - Error en la Agrupación" & vbCrLf & vbCrLf & "Hay seleccionadas operaciones que no se pueden agrupar.", vbExclamation, TITSISTEMA
   Else
      If GRUP.TextMatrix(GRUP.Rows - 1, 1) = "BTR" And (GRUP.TextMatrix(GRUP.Rows - 1, 2) = "CI" Or GRUP.TextMatrix(GRUP.Rows - 1, 2) = "CP") Then
         Let Toolbar1.Buttons(2).Enabled = False
         MsgBox "W - No es posible Agrupar Operaciones de Renta Fija, que no sean Interbancarios", vbExclamation
      End If
      Let Toolbar1.Buttons(2).Enabled = True
      MsgBox "Ok - Agrupación de Operaciones Correcta.", vbInformation, TITSISTEMA
   End If

End Sub

Private Sub Pintar_Celdas(ByVal iFila As Long, bColor As Variant, fColor As Variant)
   Dim iContador  As Integer

   Let GRD.Row = iFila
   For iContador = 0 To GRD.Cols - 1
      Let GRD.Col = iContador
      Let GRD.CellBackColor = bColor
      Let GRD.CellForeColor = fColor
   Next iContador

End Sub

Private Sub TxtValuta_Change()
   If TxtValuta.Text < gsbac_fecp Then
      MsgBox "W - No se deben seleccionar fechas anteriores.", vbExclamation, TITSISTEMA
      Let TxtValuta.Text = Format(gsbac_fecp, "dd/mm/yyyy")
   End If
End Sub

Private Sub Grabar()
   On Error GoTo Error_Grabacion
   Dim DATOS()
   Dim IdFolio    As Long
   Dim iContador  As Long
   Dim iInstancia As Integer
   
   Let iInstancia = 0
   Let IdFolio = 0

   For iContador = 2 To GRD.Rows - 1
      If Trim(GRD.TextMatrix(iContador, 0)) = "M" Then
         iInstancia = iInstancia + 1
         Envia = Array()
         AddParam Envia, IIf(iInstancia = 1, CDbl(5), CDbl(6))
         AddParam Envia, Format(TxtValuta.Text, "YYYYMMDD")
         AddParam Envia, CDbl(GRD.TextMatrix(iContador, 3))
         AddParam Envia, GRD.TextMatrix(iContador, 1)
         AddParam Envia, GRD.TextMatrix(iContador, 2)
         AddParam Envia, CDbl(0)
         AddParam Envia, CDbl(0)
         AddParam Envia, CDbl(0)
         AddParam Envia, CDbl(0)
         AddParam Envia, ""
         AddParam Envia, gsBAC_User
         AddParam Envia, IdFolio
         If Not Bac_Sql_Execute("SP_MNT_AGRUPACION", Envia) Then
            MsgBox "Error " & vbCrLf & vbCrLf & "Problemas en la recuperación del Folio de Grupo.", vbExclamation, TITSISTEMA
            GoTo Error_Grabacion
         End If
         If Bac_SQL_Fetch(DATOS()) Then
            IdFolio = DATOS(1)
         End If
      End If
      
   Next iContador

   Let BacGenMensaje.iAceptarGrupo = True

   Unload Me

Exit Sub
Error_Grabacion:

End Sub
