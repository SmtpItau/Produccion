VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form FiltrarConsulta_Anticipo 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Filtro Consulta "
   ClientHeight    =   4575
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   5700
   Icon            =   "FiltrarConsulta_Anticipo.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   4575
   ScaleWidth      =   5700
   ShowInTaskbar   =   0   'False
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   33
      Top             =   0
      Width           =   5700
      _ExtentX        =   10054
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
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Aceptar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Cancelar / Salir."
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   6075
         Top             =   45
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
               Picture         =   "FiltrarConsulta_Anticipo.frx":000C
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FiltrarConsulta_Anticipo.frx":0EE6
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FiltrarConsulta_Anticipo.frx":1200
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FiltrarConsulta_Anticipo.frx":20DA
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame Frame1 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000007&
      Height          =   4230
      Index           =   0
      Left            =   30
      TabIndex        =   11
      Top             =   345
      Width           =   5655
      Begin VB.Frame Frame1 
         Height          =   1170
         Index           =   6
         Left            =   180
         TabIndex        =   14
         Top             =   7275
         Width           =   5685
         Begin BACControles.TXTFecha fecHasta 
            Height          =   255
            Left            =   3645
            TabIndex        =   21
            Top             =   360
            Width           =   1440
            _ExtentX        =   2540
            _ExtentY        =   450
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            MaxDate         =   2958465
            MinDate         =   -328716
            Text            =   "25/10/2000"
         End
         Begin BACControles.TXTFecha fecDesde 
            Height          =   255
            Left            =   1920
            TabIndex        =   20
            Top             =   360
            Width           =   1410
            _ExtentX        =   2487
            _ExtentY        =   450
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            MaxDate         =   2958465
            MinDate         =   -328716
            Text            =   "25/10/2000"
         End
         Begin VB.OptionButton optFecVenc 
            Caption         =   "Fecha Vencimiento"
            Enabled         =   0   'False
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00808000&
            Height          =   225
            Left            =   3630
            TabIndex        =   10
            Top             =   810
            Width           =   1965
         End
         Begin VB.OptionButton optFechaProc 
            Caption         =   "Fecha Proceso"
            Enabled         =   0   'False
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00808000&
            Height          =   195
            Left            =   1920
            TabIndex        =   9
            Top             =   810
            Width           =   2445
         End
         Begin VB.CheckBox chkEntreFec 
            Caption         =   "Entre Fechas "
            Enabled         =   0   'False
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00808000&
            Height          =   420
            Left            =   270
            TabIndex        =   8
            Top             =   270
            Width           =   1365
         End
      End
      Begin VB.Frame Frame1 
         Height          =   1860
         Index           =   5
         Left            =   180
         TabIndex        =   13
         Top             =   5655
         Width           =   5685
         Begin BACControles.TXTFecha fecFechaVcto 
            Height          =   255
            Left            =   1920
            TabIndex        =   19
            Top             =   1440
            Width           =   1410
            _ExtentX        =   2487
            _ExtentY        =   450
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            MaxDate         =   2958465
            MinDate         =   -328716
            Text            =   "25/10/2000"
         End
         Begin BACControles.TXTFecha fecFechaProceso 
            Height          =   255
            Left            =   1920
            TabIndex        =   18
            Top             =   1080
            Width           =   1410
            _ExtentX        =   2487
            _ExtentY        =   450
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            MaxDate         =   2958465
            MinDate         =   -328716
            Text            =   "25/10/2000"
         End
         Begin VB.TextBox txtCliente 
            Enabled         =   0   'False
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   330
            Left            =   1935
            TabIndex        =   3
            Top             =   225
            Width           =   3480
         End
         Begin VB.ComboBox cmbMonedas 
            Enabled         =   0   'False
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   315
            Left            =   1935
            Style           =   2  'Dropdown List
            TabIndex        =   5
            Top             =   630
            Width           =   3480
         End
         Begin VB.CheckBox chkMoneda 
            Caption         =   "Moneda"
            Enabled         =   0   'False
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00808000&
            Height          =   240
            Left            =   270
            TabIndex        =   4
            Top             =   675
            Width           =   1050
         End
         Begin VB.CheckBox chkFechaProc 
            Caption         =   "Fecha Proceso"
            Enabled         =   0   'False
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00808000&
            Height          =   375
            Left            =   270
            TabIndex        =   6
            Top             =   990
            Width           =   1680
         End
         Begin VB.CheckBox chkFechaVecto 
            Caption         =   "Fecha Vcto."
            Enabled         =   0   'False
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00808000&
            Height          =   420
            Left            =   270
            TabIndex        =   7
            Top             =   1350
            Width           =   1365
         End
         Begin VB.CheckBox chkCliente 
            Caption         =   "Cliente"
            Enabled         =   0   'False
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00808000&
            Height          =   240
            Left            =   270
            TabIndex        =   2
            Top             =   270
            Width           =   1050
         End
      End
      Begin VB.Frame Frame1 
         Height          =   1185
         Index           =   4
         Left            =   45
         TabIndex        =   12
         Top             =   375
         Width           =   5565
         Begin VB.CheckBox chkTodos 
            Caption         =   "Todas"
            BeginProperty Font 
               Name            =   "Tahoma"
               Size            =   9.75
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000007&
            Height          =   240
            Left            =   1935
            TabIndex        =   1
            Top             =   540
            Width           =   1050
         End
         Begin VB.ComboBox cmbPosicion 
            Appearance      =   0  'Flat
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
            Left            =   1935
            Style           =   2  'Dropdown List
            TabIndex        =   0
            Top             =   195
            Width           =   3480
         End
         Begin VB.ComboBox cmbEntidad 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   315
            Left            =   1935
            Style           =   2  'Dropdown List
            TabIndex        =   17
            Top             =   765
            Visible         =   0   'False
            Width           =   3480
         End
         Begin VB.Label Etiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Posición"
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
            Left            =   270
            TabIndex        =   16
            Top             =   225
            Width           =   690
         End
         Begin VB.Label Etiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Entidad"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   195
            Index           =   0
            Left            =   270
            TabIndex        =   15
            Top             =   750
            Visible         =   0   'False
            Width           =   660
         End
      End
      Begin VB.Frame Frame1 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   2220
         Index           =   2
         Left            =   45
         TabIndex        =   22
         Top             =   1485
         Width           =   2715
         Begin VB.OptionButton optFechaVcto 
            Caption         =   "Fecha Vencimiento"
            BeginProperty Font 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000007&
            Height          =   225
            Left            =   75
            TabIndex        =   26
            ToolTipText     =   "Fecha Término Operación"
            Top             =   1500
            Width           =   2220
         End
         Begin VB.OptionButton optFechaOper 
            Caption         =   "Fecha Operación"
            BeginProperty Font 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000007&
            Height          =   225
            Left            =   75
            TabIndex        =   25
            ToolTipText     =   "Fecha de Cierre Operación"
            Top             =   1185
            Width           =   2220
         End
         Begin VB.OptionButton optMoneda 
            Caption         =   "Moneda"
            BeginProperty Font 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000007&
            Height          =   225
            Left            =   75
            TabIndex        =   24
            Top             =   870
            Width           =   2220
         End
         Begin VB.OptionButton optCliente 
            Caption         =   "Cliente"
            BeginProperty Font 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000007&
            Height          =   225
            Left            =   75
            TabIndex        =   23
            ToolTipText     =   "Nombre"
            Top             =   540
            Width           =   1860
         End
         Begin VB.Label Etiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Ordenado Por"
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
            Left            =   105
            TabIndex        =   35
            Top             =   135
            Width           =   1155
         End
      End
      Begin VB.Frame Frame1 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   2220
         Index           =   3
         Left            =   2790
         TabIndex        =   27
         Top             =   1485
         Width           =   2820
         Begin VB.OptionButton optOpDia 
            Caption         =   "Operaciones del Día"
            Enabled         =   0   'False
            BeginProperty Font 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000007&
            Height          =   225
            Left            =   75
            TabIndex        =   32
            Top             =   540
            Width           =   2445
         End
         Begin VB.OptionButton optOpHistorica 
            Caption         =   "Operaciones Historicas"
            Enabled         =   0   'False
            BeginProperty Font 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000007&
            Height          =   225
            Left            =   75
            TabIndex        =   31
            Top             =   870
            Width           =   2445
         End
         Begin VB.OptionButton optOpVigente 
            Caption         =   "Operaciones Vigentes"
            BeginProperty Font 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000007&
            Height          =   225
            Left            =   75
            TabIndex        =   30
            Top             =   1185
            Value           =   -1  'True
            Width           =   2445
         End
         Begin VB.OptionButton optOpVencidas 
            Caption         =   "Operaciones Vencidas"
            Enabled         =   0   'False
            BeginProperty Font 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000007&
            Height          =   225
            Left            =   75
            TabIndex        =   29
            Top             =   1500
            Width           =   2445
         End
         Begin VB.OptionButton optPosicionVctos 
            Caption         =   "Posición por Vencimientos"
            Enabled         =   0   'False
            BeginProperty Font 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000007&
            Height          =   225
            Left            =   75
            TabIndex        =   28
            Top             =   1830
            Visible         =   0   'False
            Width           =   2685
         End
         Begin VB.Label Etiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Consulta de"
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
            Left            =   105
            TabIndex        =   36
            Top             =   135
            Width           =   990
         End
      End
      Begin VB.Frame Frame2 
         Height          =   570
         Left            =   45
         TabIndex        =   37
         Top             =   3615
         Width           =   5550
         Begin BACControles.TXTNumero TxtNumeroOperacion 
            Height          =   300
            Left            =   2745
            TabIndex        =   39
            Top             =   180
            Width           =   1890
            _ExtentX        =   3334
            _ExtentY        =   529
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Text            =   "0"
            Text            =   "0"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin VB.CheckBox CHKNumOperacion 
            Caption         =   "Número operación"
            BeginProperty Font 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   225
            Left            =   135
            TabIndex        =   38
            Top             =   210
            Width           =   2190
         End
      End
      Begin VB.Label Etiqueta 
         AutoSize        =   -1  'True
         Caption         =   "Filtro"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   240
         Index           =   2
         Left            =   165
         TabIndex        =   34
         Top             =   180
         Width           =   480
      End
   End
End
Attribute VB_Name = "FiltrarConsulta_Anticipo"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim colFechas        As New Collection
Dim colOrdenado      As New Collection
Dim colConsulta      As New Collection
Dim colFechasChk     As New Collection

Private ObjConsulta  As Object

Dim TipoSwap         As Integer
Dim TipOper          As Integer
Dim Cond             As Integer
Dim Ord              As Integer
Dim codcli           As Double
Dim RutCli           As Double
Dim CodMon           As Integer
Dim OpcFec           As Integer
Dim FechaD           As String 'Date
Dim FechaH           As String 'Date
Dim NumOper          As Long
Dim Frase            As String

Function FUNC_FILTRA_DATOS() As Boolean
   Dim SQL           As String
   Dim DATOS()

   FUNC_FILTRA_DATOS = False

   SqlAnticipo = ""

   Envia = Array()
   AddParam Envia, CDbl(Operacion)
   AddParam Envia, CDbl(TipoSwap)
   AddParam Envia, CDbl(CodMon)
   AddParam Envia, CDbl(Ord)
   AddParam Envia, CDbl(OpcFec)
   AddParam Envia, Format(FechaD, "yyyymmdd")
   AddParam Envia, Format(FechaH, "yyyymmdd")
   AddParam Envia, GLB_AREA_RESPONSABLE
   AddParam Envia, GLB_CARTERA_NORMATIVA
   AddParam Envia, GLB_SUB_CARTERA_NORMATIVA
   AddParam Envia, GLB_LIBRO
   AddParam Envia, CDbl(IIf(CHKNumOperacion.Value = 1, TxtNumeroOperacion.Text, 0))
   If Not Bac_Sql_Execute("SP_FILTRO_ANTICIPO", Envia) Then
      Exit Function
   End If

   GlbSQLAnticipo = VerSql
   Consulta_Anticipos.SQLConsulta = VerSql

   Let NumPaso = 0
   Let Filas = 1
   Let Consulta_Anticipos.grdConsulta.Rows = 1

   Do While Bac_SQL_Fetch(DATOS())
      Consulta_Anticipos.grdConsulta.Rows = Consulta_Anticipos.grdConsulta.Rows + 1

      Consulta_Anticipos.grdConsulta.TextMatrix(Filas, 0) = DATOS(1)
      Consulta_Anticipos.grdConsulta.TextMatrix(Filas, 1) = Val(DATOS(2))
      Consulta_Anticipos.grdConsulta.TextMatrix(Filas, 2) = DATOS(6)
      Consulta_Anticipos.grdConsulta.TextMatrix(Filas, 3) = DATOS(4)
      Consulta_Anticipos.grdConsulta.TextMatrix(Filas, 4) = DATOS(7)
      Consulta_Anticipos.grdConsulta.TextMatrix(Filas, 5) = DATOS(8)
      Consulta_Anticipos.grdConsulta.TextMatrix(Filas, 6) = DATOS(10)
      Consulta_Anticipos.grdConsulta.TextMatrix(Filas, 7) = Format(BacStrTran((DATOS(11)), ".", gsc_PuntoDecim), "###,###,###,##0.#0")
      Consulta_Anticipos.grdConsulta.TextMatrix(Filas, 8) = Format(BacStrTran((DATOS(12)), ".", gsc_PuntoDecim), "###,###,###,##0.#0")
      Consulta_Anticipos.grdConsulta.TextMatrix(Filas, 9) = Format(BacStrTran((DATOS(13)), ".", gsc_PuntoDecim), "###,###,###,##0.#0")
      Consulta_Anticipos.grdConsulta.TextMatrix(Filas, 10) = Format(BacStrTran((DATOS(14)), ".", gsc_PuntoDecim), "###,###,###,##0.#0")
      Consulta_Anticipos.grdConsulta.TextMatrix(Filas, 11) = DATOS(15)
      Consulta_Anticipos.grdConsulta.TextMatrix(Filas, 15) = Trim(DATOS(17))
      Consulta_Anticipos.grdConsulta.TextMatrix(Filas, 16) = Trim(DATOS(18))
      Consulta_Anticipos.grdConsulta.TextMatrix(Filas, 17) = Trim(DATOS(19))
      Consulta_Anticipos.grdConsulta.TextMatrix(Filas, 18) = Trim(DATOS(20))
      Consulta_Anticipos.grdConsulta.Tag = "SI"

      Filas = Filas + 1
   Loop

   FUNC_FILTRA_DATOS = True

End Function


Function Inicializar()

    TipoSwap = 0
    TipOper = 0
    Cond = 0
    Ord = 0
    codcli = 0
    CodMon = 0
    OpcFec = 0
    FechaD = fecFechaProceso.Text 'As Date
    FechaH = fecFechaProceso.Text  'As Date

End Function

Function ValidaDatos() As Boolean
   Dim MiObjeto
   Dim pos As Integer
   
   Call Inicializar    'Limpia variables

   ValidaDatos = False

   If cmbPosicion.ListIndex <> -1 And chkTodos.Value = 0 Then
      TipoSwap = cmbPosicion.ItemData(cmbPosicion.ListIndex)
   End If
   If chkMoneda.Value = 1 And cmbMonedas.ListIndex <> -1 Then
      CodMon = cmbMonedas.ItemData(cmbMonedas.ListIndex)
   End If

   pos = 1
   For Each MiObjeto In colConsulta
      If MiObjeto.Value = True Then
         TipOper = pos
         Exit For
      End If
      pos = pos + 1
   Next MiObjeto
    
    Select Case pos
        Case 1
            Frase = "Consulta Operaciones del Día"
        Case 2
            Frase = "Consulta Operaciones Históricas"
        Case 3
            Frase = "Consulta Operaciones Vigentes"
        Case 4
            Frase = "Consulta Operaciones Vencidas"
    End Select
    
    
    pos = 1
    For Each MiObjeto In colOrdenado
        If MiObjeto.Value = True Then
            Ord = pos
            Exit For
        End If
        pos = pos + 1
    Next MiObjeto
    
    Select Case pos
        Case 1
            Frase = Frase & " Ordenado por Cliente"
        Case 2
            Frase = Frase & " Ordenado por Moneda"
        Case 3
            Frase = Frase & " Ordenado por Fecha de Operación"
        Case 4
            Frase = Frase & " Ordenado por Fecha Vencimiento"
    End Select
    
    If chkFechaProc.Value = 1 Then
        OpcFec = 1
        FechaD = fecFechaProceso.Text
    End If
    If chkFechaVecto.Value = 1 Then
        OpcFec = 2
        FechaH = fecFechaVcto.Text
    End If
    
    If chkEntreFec.Value = 1 Then
        If optFechaProc.Value = True Then
            OpcFec = 3
        ElseIf optFecVenc.Value = True Then
            OpcFec = 4
        End If
        FechaD = fecDesde.Text
        FechaH = fecHasta.Text
    End If
    
    ValidaDatos = True

End Function

Function Filtrar()
   Dim ConsultaDatos    As New clsConsultasSwaps
   Dim Filas            As Long
   Dim Max              As Long
   Dim m, J             As Long
   Dim NumPaso          As Double

   Consulta_Anticipos.grdConsulta.Cols = 19
   Call BacLimpiaGrilla(Consulta_Anticipos.grdConsulta)

   Consulta_Anticipos.grdConsulta.Tag = "NO" 'Grilla no tiene datos
   swModTipoOpe = 0    'para discriminar la tabla

   Operacion = TipOper
   swModTipoOpe = TipOper

   If Not FUNC_FILTRA_DATOS() Then
      Call MsgBox("No existen datos con Parámetros seleccionados", vbExclamation, App.Title)
      Exit Function
   End If

   NumPaso = 0
   Filas = 1

   Let Consulta_Anticipos.EtiquetaTitulo.Caption = Frase
End Function


Private Sub chkEntreFec_Click()

    If chkEntreFec.Value = 1 Then
        chkFechaProc.Value = 0
        chkFechaVecto.Value = 0
        optFechaProc.Value = True
    End If

End Sub

Private Sub chkFechaProc_Click()

    If chkFechaProc.Value = 1 Then
        chkFechaVecto.Value = 0
        chkEntreFec.Value = 0
        optFechaProc.Value = False
        optFecVenc.Value = False
        optFecVenc.ForeColor = &H808000
        optFechaProc.ForeColor = &H808000
    End If
   


End Sub

Private Sub chkFechaVecto_Click()

    If chkFechaVecto.Value = 1 Then
        chkFechaProc.Value = 0
        chkEntreFec.Value = 0
        optFechaProc.Value = False
        optFecVenc.Value = False
        optFecVenc.ForeColor = &H808000
        optFechaProc.ForeColor = &H808000
    End If

End Sub

Private Sub chkMoneda_Click()

    If chkMoneda.Value = 1 Then
        cmbMonedas.ListIndex = 0
    Else
        cmbMonedas.ListIndex = -1
    End If

End Sub

Private Sub CHKNumOperacion_Click()
   Let TxtNumeroOperacion.Enabled = IIf(CHKNumOperacion.Value = 1, True, False)
   If TxtNumeroOperacion.Enabled = False Then
      TxtNumeroOperacion.Text = 0
   End If
End Sub

Private Sub Form_Load()
   Me.Icon = BACSwap.Icon

   'Para opcion Entre Fechas
   colFechas.Add Item:=optFechaProc, Key:=CStr(1)
   colFechas.Add Item:=optFecVenc, Key:=CStr(2)

   'Para opcion Ordenado Por...
   colOrdenado.Add Item:=optCliente, Key:=CStr(1)
   colOrdenado.Add Item:=optMoneda, Key:=CStr(2)
   colOrdenado.Add Item:=optFechaOper, Key:=CStr(3)
   colOrdenado.Add Item:=optFechaVcto, Key:=CStr(4)

   'Para opcion Consulta De ...
   colConsulta.Add Item:=optOpDia, Key:=CStr(1)
   colConsulta.Add Item:=optOpHistorica, Key:=CStr(2)
   colConsulta.Add Item:=optOpVigente, Key:=CStr(3)
   colConsulta.Add Item:=optOpVencidas, Key:=CStr(4)
   colConsulta.Add Item:=optPosicionVctos, Key:=CStr(5)
   
   'Para habilitar fechas
   colFechasChk.Add Item:=chkFechaProc, Key:=CStr(1)
   colFechasChk.Add Item:=chkFechaVecto, Key:=CStr(2)
   colFechasChk.Add Item:=chkEntreFec, Key:=CStr(3)
    
   fecFechaProceso.Text = Format(gsBAC_Fecp, gsc_FechaDMA)
   fecFechaVcto.Text = Format(gsBAC_Fecp, gsc_FechaDMA)
   fecDesde.Text = Format(gsBAC_Fecp, gsc_FechaDMA)
   fecHasta.Text = Format(gsBAC_Fecp, gsc_FechaDMA)

   '------------- Monedas
   Call LlenaComboCodGeneral(cmbMonedas, 0, Sistema, 2)

   '------------- Tipo de Swaps
   Call LlenaComboCodGeneral(cmbPosicion, MDTC_TIPOSWAP, Sistema, 1)

   If cmbMonedas.ListCount = 0 Then
      chkMoneda.Enabled = False
      cmbMonedas.Enabled = False
   End If
   If cmbPosicion.ListCount = 0 Then
      cmbPosicion.Enabled = False
   End If

   optOpVigente.Value = True
   
   Let CHKNumOperacion.Value = 0
End Sub

Private Sub Form_Unload(Cancel As Integer)

Set colFechas = Nothing
Set colOrdenado = Nothing
Set colConsulta = Nothing
Set colFechasChk = Nothing


End Sub

Private Sub optCliente_Click()

    Call ColorOptionButton(colOrdenado, optCliente)

End Sub

Private Sub optFechaOper_Click()

    Call ColorOptionButton(colOrdenado, optFechaOper)
    
End Sub

Private Sub optFechaProc_Click()

    Call ColorOptionButton(colFechas, optFechaProc)

End Sub

Private Sub optFechaVcto_Click()

    Call ColorOptionButton(colOrdenado, optFechaVcto)
  
End Sub

Private Sub optFecVenc_Click()

    Call ColorOptionButton(colFechas, optFecVenc)

End Sub

Private Sub optMoneda_Click()

    Call ColorOptionButton(colOrdenado, optMoneda)

End Sub

Private Sub optOpDia_Click()

    Call ColorOptionButton(colConsulta, optOpDia)
  
End Sub

Private Sub optOpHistorica_Click()

    Call ColorOptionButton(colConsulta, optOpHistorica)
  
End Sub

Private Sub optOpVencidas_Click()

    Call ColorOptionButton(colConsulta, optOpVencidas)
    
End Sub

Private Sub optOpVigente_Click()

    Call ColorOptionButton(colConsulta, optOpVigente)
  
End Sub

Private Sub optPosicionVctos_Click()

    Call ColorOptionButton(colConsulta, optPosicionVctos)

End Sub



Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 2
         
         If ValidaDatos() Then
            Call Filtrar
            Call Unload(FiltrarConsulta_Anticipo)
         End If
      Case 3

         Call Unload(FiltrarConsulta_Anticipo)

   End Select
End Sub

Private Sub txtCliente_DblClick()
Dim Cliente As New clsCliente

    If Not Cliente.Ayuda("") Then
        MsgBox "No Existen Datos para ayuda solicitada", vbExclamation, Msj
        Exit Sub
    End If
    
    BacAyudaSwap.Tag = "Cliente"
    BacAyudaSwap.Show 1
    
    If giAceptar Then
        If Cliente.LeerxRut(CDbl(gsCodigo), CDbl(gsCodCli)) Then
        'If Cliente.LeerxRut(Cliente.clrut, Cliente.clcodigo) Then
            'txtRut = Format(gsCodigo, "###,###,###") & "-" & gsDigito
            txtCliente = Cliente.clnombre
            txtCliente.Tag = Cliente.clcodigo
            optCliente.Tag = Cliente.clrut
        Else
            MsgBox "No se encontro información de Cliente solicitado", vbCritical, Msj
        End If
    End If
    
    Set Cliente = Nothing

End Sub

