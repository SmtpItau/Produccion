VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.2#0"; "mscomctl.ocx"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacInfCarteras 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Informes Cartera"
   ClientHeight    =   4830
   ClientLeft      =   1950
   ClientTop       =   1200
   ClientWidth     =   7770
   ForeColor       =   &H00C0C0C0&
   Icon            =   "Bacinfca.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4830
   ScaleWidth      =   7770
   Begin Threed.SSPanel SSPanel1 
      Height          =   4290
      Left            =   0
      TabIndex        =   2
      Top             =   525
      Width           =   7785
      _Version        =   65536
      _ExtentX        =   13732
      _ExtentY        =   7567
      _StockProps     =   15
      Caption         =   "SSPanel1"
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BevelInner      =   1
      Begin VB.Frame Frame3 
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   2130
         Left            =   75
         TabIndex        =   25
         Top             =   75
         Width           =   7620
         Begin VB.PictureBox ConCheck 
            AutoSize        =   -1  'True
            BorderStyle     =   0  'None
            Height          =   270
            Index           =   9
            Left            =   5610
            Picture         =   "Bacinfca.frx":030A
            ScaleHeight     =   270
            ScaleWidth      =   300
            TabIndex        =   43
            Top             =   1650
            Visible         =   0   'False
            Width           =   300
         End
         Begin VB.PictureBox SinCheck 
            AutoSize        =   -1  'True
            BorderStyle     =   0  'None
            Height          =   270
            Index           =   9
            Left            =   5610
            Picture         =   "Bacinfca.frx":0464
            ScaleHeight     =   270
            ScaleWidth      =   300
            TabIndex        =   42
            Top             =   1650
            Width           =   300
         End
         Begin VB.Frame Fr_Libro 
            Caption         =   "Libro"
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
            Height          =   630
            Left            =   3825
            TabIndex        =   40
            Top             =   810
            Width           =   3735
            Begin VB.ComboBox Cmb_Libro 
               Height          =   315
               Left            =   60
               Style           =   2  'Dropdown List
               TabIndex        =   41
               Top             =   210
               Width           =   3585
            End
         End
         Begin VB.Frame Frame4 
            Caption         =   "Entidad"
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
            Height          =   630
            Left            =   60
            TabIndex        =   38
            Top             =   165
            Width           =   3735
            Begin VB.ComboBox Combo1 
               BeginProperty Font 
                  Name            =   "Courier New"
                  Size            =   9
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   345
               Left            =   60
               Style           =   2  'Dropdown List
               TabIndex        =   39
               Top             =   195
               Width           =   3585
            End
         End
         Begin VB.Frame Ssf_Cartera_Normativa 
            Caption         =   "Cartera Normativa"
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
            Height          =   630
            Left            =   3825
            TabIndex        =   36
            Top             =   165
            Width           =   3735
            Begin VB.ComboBox Cmb_Cartera_Normativa 
               Height          =   315
               Left            =   75
               Style           =   2  'Dropdown List
               TabIndex        =   37
               Top             =   255
               Width           =   3585
            End
         End
         Begin VB.Frame fr_Cartera 
            Caption         =   "Cartera de Inversión"
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
            Height          =   630
            Left            =   60
            TabIndex        =   34
            Top             =   810
            Width           =   3735
            Begin VB.ComboBox Cmb_Cartera 
               Height          =   315
               Left            =   75
               Style           =   2  'Dropdown List
               TabIndex        =   35
               Top             =   210
               Width           =   3585
            End
         End
         Begin BACControles.TXTFecha TXTFecha 
            Height          =   255
            Left            =   1395
            TabIndex        =   30
            Top             =   1650
            Width           =   1335
            _ExtentX        =   2355
            _ExtentY        =   450
            Enabled         =   -1  'True
            Enabled         =   -1  'True
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            MaxDate         =   2958465
            MinDate         =   -328716
            Text            =   "07/09/2001"
         End
         Begin VB.Label Etiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Dolares"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   240
            Index           =   8
            Left            =   4755
            TabIndex        =   44
            Top             =   1680
            Width           =   720
            WordWrap        =   -1  'True
         End
         Begin VB.Label lblEtiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Fecha"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   240
            Index           =   0
            Left            =   645
            TabIndex        =   26
            Top             =   1680
            Width           =   570
         End
      End
      Begin VB.Frame Frame1 
         Caption         =   "Listados  de Cartera "
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
         Height          =   1995
         Left            =   75
         TabIndex        =   3
         Top             =   2220
         Width           =   7620
         Begin VB.PictureBox SinCheck 
            AutoSize        =   -1  'True
            BorderStyle     =   0  'None
            Height          =   270
            Index           =   11
            Left            =   240
            Picture         =   "Bacinfca.frx":05BE
            ScaleHeight     =   270
            ScaleWidth      =   300
            TabIndex        =   49
            Top             =   1560
            Width           =   300
         End
         Begin VB.PictureBox ConCheck 
            AutoSize        =   -1  'True
            BorderStyle     =   0  'None
            Height          =   270
            Index           =   11
            Left            =   3390
            Picture         =   "Bacinfca.frx":0718
            ScaleHeight     =   270
            ScaleWidth      =   300
            TabIndex        =   48
            Top             =   1560
            Visible         =   0   'False
            Width           =   300
         End
         Begin VB.PictureBox ConCheck 
            AutoSize        =   -1  'True
            BorderStyle     =   0  'None
            Height          =   270
            Index           =   10
            Left            =   7065
            Picture         =   "Bacinfca.frx":0872
            ScaleHeight     =   270
            ScaleWidth      =   300
            TabIndex        =   46
            Top             =   1590
            Visible         =   0   'False
            Width           =   300
         End
         Begin VB.PictureBox SinCheck 
            AutoSize        =   -1  'True
            BorderStyle     =   0  'None
            Height          =   270
            Index           =   10
            Left            =   3915
            Picture         =   "Bacinfca.frx":09CC
            ScaleHeight     =   270
            ScaleWidth      =   300
            TabIndex        =   45
            Top             =   1590
            Width           =   300
         End
         Begin VB.PictureBox ConCheck 
            AutoSize        =   -1  'True
            BorderStyle     =   0  'None
            Height          =   270
            Index           =   8
            Left            =   7065
            Picture         =   "Bacinfca.frx":0B26
            ScaleHeight     =   270
            ScaleWidth      =   300
            TabIndex        =   31
            Top             =   945
            Visible         =   0   'False
            Width           =   300
         End
         Begin VB.PictureBox SinCheck 
            AutoSize        =   -1  'True
            BorderStyle     =   0  'None
            Height          =   270
            Index           =   8
            Left            =   3915
            Picture         =   "Bacinfca.frx":0C80
            ScaleHeight     =   270
            ScaleWidth      =   300
            TabIndex        =   32
            Top             =   945
            Width           =   300
         End
         Begin VB.PictureBox SinCheck 
            AutoSize        =   -1  'True
            BorderStyle     =   0  'None
            Height          =   270
            Index           =   7
            Left            =   3915
            Picture         =   "Bacinfca.frx":0DDA
            ScaleHeight     =   270
            ScaleWidth      =   300
            TabIndex        =   28
            Top             =   1275
            Visible         =   0   'False
            Width           =   300
         End
         Begin VB.PictureBox ConCheck 
            AutoSize        =   -1  'True
            BorderStyle     =   0  'None
            Height          =   270
            Index           =   7
            Left            =   7065
            Picture         =   "Bacinfca.frx":0F34
            ScaleHeight     =   270
            ScaleWidth      =   300
            TabIndex        =   27
            Top             =   1290
            Visible         =   0   'False
            Width           =   300
         End
         Begin VB.PictureBox ConCheck 
            BorderStyle     =   0  'None
            Height          =   330
            Index           =   4
            Left            =   3390
            Picture         =   "Bacinfca.frx":108E
            ScaleHeight     =   330
            ScaleWidth      =   330
            TabIndex        =   17
            Top             =   3060
            Visible         =   0   'False
            Width           =   330
         End
         Begin VB.PictureBox ConCheck 
            AutoSize        =   -1  'True
            BorderStyle     =   0  'None
            Height          =   270
            Index           =   3
            Left            =   3390
            Picture         =   "Bacinfca.frx":11E8
            ScaleHeight     =   270
            ScaleWidth      =   300
            TabIndex        =   16
            Top             =   1245
            Visible         =   0   'False
            Width           =   300
         End
         Begin VB.PictureBox ConCheck 
            AutoSize        =   -1  'True
            BorderStyle     =   0  'None
            Height          =   270
            Index           =   2
            Left            =   3390
            Picture         =   "Bacinfca.frx":1342
            ScaleHeight     =   270
            ScaleWidth      =   300
            TabIndex        =   15
            Top             =   930
            Visible         =   0   'False
            Width           =   300
         End
         Begin VB.PictureBox ConCheck 
            AutoSize        =   -1  'True
            BorderStyle     =   0  'None
            Height          =   270
            Index           =   1
            Left            =   3390
            Picture         =   "Bacinfca.frx":149C
            ScaleHeight     =   270
            ScaleWidth      =   300
            TabIndex        =   14
            Top             =   600
            Visible         =   0   'False
            Width           =   300
         End
         Begin VB.PictureBox SinCheck 
            AutoSize        =   -1  'True
            BorderStyle     =   0  'None
            Height          =   270
            Index           =   2
            Left            =   240
            Picture         =   "Bacinfca.frx":15F6
            ScaleHeight     =   270
            ScaleWidth      =   300
            TabIndex        =   13
            Top             =   930
            Width           =   300
         End
         Begin VB.PictureBox SinCheck 
            BorderStyle     =   0  'None
            Height          =   330
            Index           =   4
            Left            =   240
            Picture         =   "Bacinfca.frx":1750
            ScaleHeight     =   330
            ScaleWidth      =   375
            TabIndex        =   12
            Top             =   3060
            Width           =   375
         End
         Begin VB.PictureBox SinCheck 
            AutoSize        =   -1  'True
            BorderStyle     =   0  'None
            Height          =   270
            Index           =   3
            Left            =   240
            Picture         =   "Bacinfca.frx":18AA
            ScaleHeight     =   270
            ScaleWidth      =   300
            TabIndex        =   11
            Top             =   1245
            Width           =   300
         End
         Begin VB.PictureBox SinCheck 
            AutoSize        =   -1  'True
            BorderStyle     =   0  'None
            Height          =   270
            Index           =   1
            Left            =   240
            Picture         =   "Bacinfca.frx":1A04
            ScaleHeight     =   270
            ScaleWidth      =   300
            TabIndex        =   10
            Top             =   600
            Width           =   300
         End
         Begin VB.PictureBox ConCheck 
            AutoSize        =   -1  'True
            BorderStyle     =   0  'None
            Height          =   270
            Index           =   0
            Left            =   3390
            Picture         =   "Bacinfca.frx":1B5E
            ScaleHeight     =   270
            ScaleWidth      =   300
            TabIndex        =   9
            Top             =   285
            Visible         =   0   'False
            Width           =   300
         End
         Begin VB.PictureBox SinCheck 
            AutoSize        =   -1  'True
            BorderStyle     =   0  'None
            Height          =   270
            Index           =   0
            Left            =   240
            Picture         =   "Bacinfca.frx":1CB8
            ScaleHeight     =   270
            ScaleWidth      =   300
            TabIndex        =   8
            Top             =   285
            Width           =   300
         End
         Begin VB.PictureBox ConCheck 
            AutoSize        =   -1  'True
            BorderStyle     =   0  'None
            Height          =   270
            Index           =   5
            Left            =   7065
            Picture         =   "Bacinfca.frx":1E12
            ScaleHeight     =   270
            ScaleWidth      =   300
            TabIndex        =   7
            Top             =   285
            Visible         =   0   'False
            Width           =   300
         End
         Begin VB.PictureBox SinCheck 
            AutoSize        =   -1  'True
            BorderStyle     =   0  'None
            Height          =   270
            Index           =   5
            Left            =   3915
            Picture         =   "Bacinfca.frx":1F6C
            ScaleHeight     =   270
            ScaleWidth      =   300
            TabIndex        =   6
            Top             =   285
            Width           =   300
         End
         Begin VB.PictureBox ConCheck 
            AutoSize        =   -1  'True
            BorderStyle     =   0  'None
            Height          =   270
            Index           =   6
            Left            =   7065
            Picture         =   "Bacinfca.frx":20C6
            ScaleHeight     =   270
            ScaleWidth      =   300
            TabIndex        =   5
            Top             =   615
            Visible         =   0   'False
            Width           =   300
         End
         Begin VB.PictureBox SinCheck 
            AutoSize        =   -1  'True
            BorderStyle     =   0  'None
            Height          =   270
            Index           =   6
            Left            =   3915
            Picture         =   "Bacinfca.frx":2220
            ScaleHeight     =   270
            ScaleWidth      =   300
            TabIndex        =   4
            Top             =   615
            Width           =   300
         End
         Begin VB.Label Etiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Cartera Captaciones a Plazo"
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   9
            Left            =   720
            TabIndex        =   50
            Top             =   1605
            Width           =   2010
         End
         Begin VB.Label Etiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Informe de Liquidez Msg 139 BCCH"
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   7
            Left            =   4410
            TabIndex        =   47
            Top             =   1620
            Width           =   2520
         End
         Begin VB.Label Etiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Cartera Propia de Letras"
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   10
            Left            =   4395
            TabIndex        =   33
            Top             =   960
            Width           =   1710
         End
         Begin VB.Label Etiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Pasivos"
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   11
            Left            =   4395
            TabIndex        =   29
            Top             =   1320
            Visible         =   0   'False
            Width           =   555
         End
         Begin VB.Label Etiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Cartera Propia Disponible"
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   4
            Left            =   720
            TabIndex        =   24
            Top             =   3120
            Width           =   1785
         End
         Begin VB.Label Etiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Cartera Ventas con Pacto"
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   3
            Left            =   720
            TabIndex        =   23
            Top             =   1290
            Width           =   1830
         End
         Begin VB.Label Etiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Cartera Compras con Pacto"
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   2
            Left            =   720
            TabIndex        =   22
            Top             =   960
            Width           =   1950
         End
         Begin VB.Label Etiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Cartera Propia Intermediada"
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   1
            Left            =   720
            TabIndex        =   21
            Top             =   645
            Width           =   1965
         End
         Begin VB.Label Etiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Cartera Propia"
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   0
            Left            =   720
            TabIndex        =   20
            Top             =   315
            Width           =   1005
         End
         Begin VB.Label Etiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Cartera Colocaciones Interbancarias"
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   5
            Left            =   4395
            TabIndex        =   19
            Top             =   300
            Width           =   2565
         End
         Begin VB.Label Etiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Cartera Captaciones Interbancarias"
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   6
            Left            =   4395
            TabIndex        =   18
            Top             =   645
            Width           =   2490
         End
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   7230
      Top             =   30
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
            Picture         =   "Bacinfca.frx":237A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacinfca.frx":2694
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacinfca.frx":2AE8
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Height          =   510
      Left            =   60
      TabIndex        =   1
      Top             =   0
      Width           =   7770
      _ExtentX        =   13705
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Generar Informe a Pantalla"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Imprimir Informe"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Cerrar Ventana"
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin VB.Label Lbl_index 
      BorderStyle     =   1  'Fixed Single
      Height          =   375
      Left            =   3810
      TabIndex        =   0
      Top             =   135
      Visible         =   0   'False
      Width           =   465
   End
End
Attribute VB_Name = "BacInfCarteras"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim SQL As String
Dim Datos()
Dim TCartera As String

Private Sub Cmd_Generar(Donde)
Dim Nombre_Rpt      As String: Nombre_Rpt = ""
Dim TipRep          As String
Dim Fechaproc       As String
Dim Fechaprox       As String
Dim AuxTit          As String
Dim CDolar          As String
Dim nContador       As Integer
Dim Datos()


On Error GoTo Control:

If Cmb_Cartera_Normativa.ListIndex = -1 Then
    MsgBox "Indique Tipo Cartera a Imprimir", vbExclamation + vbOKOnly
    Exit Sub
End If

Fechaprox = Format(txtFecha.text, feFECHA)

Envia = Array()
AddParam Envia, Fechaprox
AddParam Envia, 6
AddParam Envia, Fechaprox
AddParam Envia, "V"

Fechaproc = ""

If Bac_Sql_Execute("SP_BACKHABIL", Envia) Then
   Do While Bac_SQL_Fetch(Datos())
      Fechaproc = Format(Datos(1), "YYYYMMDD")
   Loop
Else
   GoTo Control:
End If

If Fechaproc = "" Then
   MsgBox "Fecha no se Encuentra en Registros", vbExclamation, Me.Caption
   Exit Sub
End If

xentidad = Val(Trim$(Right$(Combo1, 10)))

Screen.MousePointer = vbHourglass

If Donde = "Impresora" Then
    BacTrader.bacrpt.Destination = 0
Else
    BacTrader.bacrpt.Destination = 1
End If

'Opciones de Cartera
    Dim Inf%, X%, Marca  As Boolean
    
    Marca = False

'''''    If ConCheck.Item(7).Visible = True Then Marca = True
 
    
'''''    If Marca = True Then

        If ConCheck.Item(9).Visible = True Then
            CDolar = "S"
        Else
            CDolar = "N"
        End If
    
'''''    End If
    
'''''For i = 0 To ConCheck.Count - 2
   
'''''    If ConCheck.Item(i).Visible = True Then

'''''        Select Case i
'''''                Case 0  'ok


    '-> Mensaje 139 al BCCH historico con fechas    || 04-03-2014.- AGF
    If ConCheck.Item(10).Visible = True Then
        Call Limpiar_Cristal
        
        TitRpt = "INFORME DE LIQUIDEZ - Mensaje 139"
        
        BacTrader.bacrpt.ReportFileName = RptList_Path & "Mensaje_139_Fecha.rpt"
        BacTrader.bacrpt.StoredProcParam(0) = Format(txtFecha.text, "yyyy-mm-dd 00:00:00.000")
        BacTrader.bacrpt.Connect = CONECCION
        BacTrader.bacrpt.WindowTitle = TitRpt
        BacTrader.bacrpt.WindowState = crptMaximized
        BacTrader.bacrpt.Action = 1

        Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "MENSJAE 139" & TitRpt)
    End If
    '-> Mensaje 139 al BCCH historico con fechas    || 04-03-2014.- AGF
    
    If ConCheck.Item(0).Visible = True Then 'CARTERA DE INVERSIOENS COMPRAS
        nContador = IIf(Cmb_Cartera_Normativa.ListIndex > 0, 1, Cmb_Cartera_Normativa.ListCount - 1)
        
        For X = 1 To nContador 'inf
                 
            AuxTit = ""
            TCartera = ""
    
            TCartera = Trim(Right(Cmb_Cartera_Normativa.List(IIf(nContador = 1, Cmb_Cartera_Normativa.ListIndex, X)), 10))
            AuxTit = "" 'Trim(Left(Cmb_Cartera_Normativa.List(IIf(nContador = 1, Cmb_Cartera_Normativa.ListIndex, x)), 50))
                    
            If CDolar = "S" Then
                AuxTit = AuxTit & " EN DOLARES E ICP"
            End If
            
            Call Limpiar_Cristal
            
            TitRpt = "CARTERA DE INVERSIONES COMPRAS " & AuxTit
            
            BacTrader.bacrpt.ReportFileName = RptList_Path & "CAPRO.RPT"
            BacTrader.bacrpt.StoredProcParam(0) = "111"
            BacTrader.bacrpt.StoredProcParam(1) = "CP"
            BacTrader.bacrpt.StoredProcParam(2) = xentidad
            BacTrader.bacrpt.StoredProcParam(3) = Fechaproc
            BacTrader.bacrpt.StoredProcParam(4) = Fechaprox
            BacTrader.bacrpt.StoredProcParam(5) = TitRpt
            BacTrader.bacrpt.StoredProcParam(6) = TCartera
            BacTrader.bacrpt.StoredProcParam(7) = CDolar
            BacTrader.bacrpt.StoredProcParam(8) = IIf(Trim(Right(Cmb_Cartera.text, 10)) = "", 0, Trim(Right(Cmb_Cartera.text, 10))) 'Cmb_Cartera.ItemData(Cmb_Cartera.ListIndex)
            '------------------------------------------------------------------------------
            'Se envia este parametro para no tener que ponerlo en duro en el procedimiento
            BacTrader.bacrpt.StoredProcParam(9) = GLB_LIBRO
            '------------------------------------------------------------------------------
            BacTrader.bacrpt.StoredProcParam(10) = IIf(Trim(Right(Cmb_Libro.text, 10)) = "", Space(1), Trim(Right(Cmb_Libro.text, 10)))
            
            BacTrader.bacrpt.WindowTitle = TitRpt
            BacTrader.bacrpt.Connect = CONECCION
            BacTrader.bacrpt.Action = 1
        Next X
    End If

'''''               Case 1:
    If ConCheck.Item(1).Visible = True Then 'CARTERA PROPIA INTERMEDIADA
        nContador = IIf(Cmb_Cartera_Normativa.ListIndex > 0, 1, Cmb_Cartera_Normativa.ListCount - 1)
        
        For X = 1 To nContador 'inf
                        
            AuxTit = ""
            TCartera = ""
            
            TCartera = Trim(Right(Cmb_Cartera_Normativa.List(IIf(nContador = 1, Cmb_Cartera_Normativa.ListIndex, X)), 10))
            AuxTit = Trim(Left(Cmb_Cartera_Normativa.List(IIf(nContador = 1, Cmb_Cartera_Normativa.ListIndex, X)), 50))
                                    
            If CDolar = "S" Then
                AuxTit = AuxTit & " EN DOLARES E ICP"
            End If
            
            Call Limpiar_Cristal
            
            TitRpt = "CARTERA PROPIA INTERMEDIADA " & AuxTit
            
            BacTrader.bacrpt.ReportFileName = RptList_Path & "CAINT.RPT"
            BacTrader.bacrpt.StoredProcParam(0) = IIf(xentidad = Trim(""), 0, xentidad)
            BacTrader.bacrpt.StoredProcParam(1) = Fechaproc
            BacTrader.bacrpt.StoredProcParam(2) = Fechaprox
            BacTrader.bacrpt.StoredProcParam(3) = TitRpt
            BacTrader.bacrpt.StoredProcParam(4) = TCartera
            BacTrader.bacrpt.StoredProcParam(5) = CDolar
            BacTrader.bacrpt.StoredProcParam(6) = Trim(Right(Cmb_Cartera.text, 10)) 'Cmb_Cartera.ItemData(Cmb_Cartera.ListIndex)
            '------------------------------------------------------------------------------
            'Se envia este parametro para no tener que ponerlo en duro en el procedimiento
            BacTrader.bacrpt.StoredProcParam(7) = GLB_LIBRO
            '------------------------------------------------------------------------------
            BacTrader.bacrpt.StoredProcParam(8) = Trim(Right(Cmb_Libro.text, 10))
            
            BacTrader.bacrpt.WindowTitle = TitRpt
            BacTrader.bacrpt.Connect = CONECCION
            BacTrader.bacrpt.Action = 1
        Next X
    End If
                    
'''''               Case 2: 'oK
    If ConCheck.Item(2).Visible = True Then ' Cartera de Compras con Pacto Disponible
        AuxTit = ""
        
        If CDolar = "S" Then
            AuxTit = AuxTit & " EN DOLARES"
        End If
        
        Call Limpiar_Cristal
        
        TitRpt = "CARTERA DE COMPRAS CON PACTO " & AuxTit
        
        BacTrader.bacrpt.ReportFileName = RptList_Path & "CARTCI.RPT"
        BacTrader.bacrpt.StoredProcParam(0) = 112
        BacTrader.bacrpt.StoredProcParam(1) = IIf(xentidad = Trim(""), 0, xentidad)
        BacTrader.bacrpt.StoredProcParam(2) = Fechaproc
        BacTrader.bacrpt.StoredProcParam(3) = Fechaprox
        BacTrader.bacrpt.Formulas(0) = "Titu='" & TitRpt & "'"
        BacTrader.bacrpt.StoredProcParam(4) = TitRpt
        BacTrader.bacrpt.StoredProcParam(5) = CDolar
        BacTrader.bacrpt.StoredProcParam(6) = Trim(Right(Cmb_Cartera.text, 10)) 'Cmb_Cartera.ItemData(Cmb_Cartera.ListIndex)
        '------------------------------------------------------------------------------
        'Se envia este parametro para no tener que ponerlo en duro en el procedimiento
        BacTrader.bacrpt.StoredProcParam(7) = GLB_LIBRO
        '------------------------------------------------------------------------------
        BacTrader.bacrpt.StoredProcParam(8) = Trim(Right(Cmb_Libro.text, 10))
        
        BacTrader.bacrpt.WindowTitle = TitRpt
        
        BacTrader.bacrpt.Connect = CONECCION
        BacTrader.bacrpt.Action = 1
    End If
                    
'''''               Case 3:
    If ConCheck.Item(3).Visible = True Then
        AuxTit = ""
        
        If CDolar = "S" Then
            AuxTit = AuxTit & " EN DOLARES"
        End If
        
        Call Limpiar_Cristal
        
        TitRpt = "CARTERA DE VENTAS CON PACTO " & AuxTit
        
        BacTrader.bacrpt.ReportFileName = RptList_Path & "CARTVI.RPT"
        BacTrader.bacrpt.StoredProcParam(0) = 115
        BacTrader.bacrpt.StoredProcParam(1) = IIf(xentidad = Trim(""), 0, xentidad)
        BacTrader.bacrpt.StoredProcParam(2) = Fechaproc
        BacTrader.bacrpt.StoredProcParam(3) = Fechaprox
        '------------------------------------------------------------------------------
        'Se envia este parametro para no tener que ponerlo en duro en el procedimiento
        
        BacTrader.bacrpt.Formulas(0) = "Titu='" & TitRpt & "'"
        BacTrader.bacrpt.StoredProcParam(4) = TitRpt
        BacTrader.bacrpt.StoredProcParam(5) = CDolar
        
        BacTrader.bacrpt.StoredProcParam(6) = GLB_LIBRO
        '------------------------------------------------------------------------------
        BacTrader.bacrpt.StoredProcParam(7) = IIf(Trim(Right(Cmb_Libro.text, 10)) = "", "0", Trim(Right(Cmb_Libro.text, 10)))
        
        BacTrader.bacrpt.Connect = CONECCION
        BacTrader.bacrpt.Action = 1
    End If
    
'''''               Case 4
    If ConCheck.Item(4).Visible = True Then 'Cartera Propia Disponible
        nContador = IIf(Cmb_Cartera_Normativa.ListIndex > 0, 1, Cmb_Cartera_Normativa.ListCount - 1)
        
        For X = 1 To nContador 'inf
            
            AuxTit = ""
            TCartera = ""
            
            TCartera = Trim(Right(Cmb_Cartera_Normativa.List(IIf(nContador = 1, Cmb_Cartera_Normativa.ListIndex, X)), 10))
            AuxTit = Trim(Left(Cmb_Cartera_Normativa.List(IIf(nContador = 1, Cmb_Cartera_Normativa.ListIndex, X)), 50))
         
            If CDolar = "S" Then
               AuxTit = AuxTit & " EN DOLARES"
            End If
           
            Call Limpiar_Cristal
           
            TitRpt = "CARTERA PROPIA DISPONIBLE " & AuxTit & Format(FgsBac_Fecp, "dd/mm/yyyy")
           
            BacTrader.bacrpt.ReportFileName = RptList_Path & "CARTDISP.RPT"
            BacTrader.bacrpt.StoredProcParam(0) = IIf(xentidad = Trim(""), 0, xentidad)
            BacTrader.bacrpt.StoredProcParam(1) = TCartera
            BacTrader.bacrpt.StoredProcParam(2) = Fechaproc
            BacTrader.bacrpt.StoredProcParam(3) = Fechaprox
            BacTrader.bacrpt.StoredProcParam(4) = CDolar
            BacTrader.bacrpt.StoredProcParam(5) = TitRpt
            '------------------------------------------------------------------------------
            'Se envia este parametro para no tener que ponerlo en duro en el procedimiento
            BacTrader.bacrpt.StoredProcParam(6) = GLB_LIBRO
            '------------------------------------------------------------------------------
            BacTrader.bacrpt.StoredProcParam(7) = Trim(Right(Cmb_Libro.text, 10))
    
            BacTrader.bacrpt.Connect = CONECCION
            BacTrader.bacrpt.Action = 1
        Next X
    End If
 
'''''                Case 5
    If ConCheck.Item(5).Visible = True Then 'Cartera de Colocaciones Interbancarias
        AuxTit = ""
        
        If CDolar = "S" Then
            AuxTit = AuxTit & " EN DOLARES"
        End If
        
        Call Limpiar_Cristal
        
        TitRpt = "CARTERA DE COLOCACIONES INTERBANCARIAS " & AuxTit
        
        BacTrader.bacrpt.ReportFileName = RptList_Path & "CARTINTER.RPT"
        BacTrader.bacrpt.StoredProcParam(0) = "ICOL"
        BacTrader.bacrpt.StoredProcParam(1) = Fechaproc
        BacTrader.bacrpt.StoredProcParam(2) = Fechaprox
        BacTrader.bacrpt.StoredProcParam(3) = TitRpt
        BacTrader.bacrpt.StoredProcParam(4) = CDolar
        BacTrader.bacrpt.StoredProcParam(5) = Trim(Right(Cmb_Cartera.text, 10)) 'Cmb_Cartera.ItemData(Cmb_Cartera.ListIndex)
        '------------------------------------------------------------------------------
        'Se envia este parametro para no tener que ponerlo en duro en el procedimiento
        BacTrader.bacrpt.StoredProcParam(6) = GLB_LIBRO
        '------------------------------------------------------------------------------
        BacTrader.bacrpt.StoredProcParam(7) = Trim(Right(Cmb_Libro.text, 10))
    
        BacTrader.bacrpt.WindowTitle = TitRpt
        BacTrader.bacrpt.Connect = CONECCION
        BacTrader.bacrpt.Action = 1
    End If
                    
'''''               Case 6
    If ConCheck.Item(6).Visible = True Then
        AuxTit = ""
        
        If CDolar = "S" Then
            AuxTit = AuxTit & " EN DOLARES"
        End If
        
        Call Limpiar_Cristal
        
        TitRpt = "CARTERA DE CAPTACIONES INTERBANCARIAS " & AuxTit
        
        BacTrader.bacrpt.ReportFileName = RptList_Path & "CARTINTER.RPT"
        BacTrader.bacrpt.StoredProcParam(0) = "ICAP"
        BacTrader.bacrpt.StoredProcParam(1) = Fechaproc
        BacTrader.bacrpt.StoredProcParam(2) = Fechaprox
        BacTrader.bacrpt.StoredProcParam(3) = TitRpt
        BacTrader.bacrpt.StoredProcParam(4) = CDolar
        BacTrader.bacrpt.StoredProcParam(5) = Trim(Right(Cmb_Cartera.text, 10)) 'Cmb_Cartera.ItemData(Cmb_Cartera.ListIndex)
        '------------------------------------------------------------------------------
        'Se envia este parametro para no tener que ponerlo en duro en el procedimiento
        BacTrader.bacrpt.StoredProcParam(6) = GLB_LIBRO
        '------------------------------------------------------------------------------
        BacTrader.bacrpt.StoredProcParam(7) = Trim(Right(Cmb_Libro.text, 10))
        
        BacTrader.bacrpt.WindowTitle = TitRpt
        BacTrader.bacrpt.Connect = CONECCION
        BacTrader.bacrpt.Action = 1
    End If
    
'''''             Case 7
    If ConCheck.Item(7).Visible = True Then
        Call Limpiar_Cristal
        
        BacTrader.bacrpt.ReportFileName = RptList_Path & "infcartpasivo.RPT"
        BacTrader.bacrpt.StoredProcParam(0) = Fechaproc
        BacTrader.bacrpt.StoredProcParam(1) = Fechaprox
        BacTrader.bacrpt.StoredProcParam(2) = UCase(CDolar)
        BacTrader.bacrpt.Connect = CONECCION
        BacTrader.bacrpt.Action = 1
    End If
                    
'''''             Case 8
    If ConCheck.Item(8).Visible = True Then
        Call Limpiar_Cristal
        
        TitRpt = "CARTERA DE INVERSIONES COMPRAS DE LETRAS "
        
        BacTrader.bacrpt.ReportFileName = RptList_Path & "CAPROLCHR.RPT"
        BacTrader.bacrpt.StoredProcParam(0) = "111"
        BacTrader.bacrpt.StoredProcParam(1) = "CP"
        BacTrader.bacrpt.StoredProcParam(2) = xentidad
        BacTrader.bacrpt.StoredProcParam(3) = Fechaproc
        BacTrader.bacrpt.StoredProcParam(4) = Fechaprox
        BacTrader.bacrpt.StoredProcParam(5) = TitRpt
        BacTrader.bacrpt.StoredProcParam(6) = ""
        BacTrader.bacrpt.StoredProcParam(7) = CDolar
        BacTrader.bacrpt.StoredProcParam(8) = Trim(Right(Cmb_Cartera.text, 10)) 'Cmb_Cartera.ItemData(Cmb_Cartera.ListIndex)
        '------------------------------------------------------------------------------
        'Se envia este parametro para no tener que ponerlo en duro en el procedimiento
        BacTrader.bacrpt.StoredProcParam(9) = GLB_LIBRO
        '------------------------------------------------------------------------------
        BacTrader.bacrpt.StoredProcParam(10) = Trim(Right(Cmb_Libro.text, 10))
        
        BacTrader.bacrpt.WindowTitle = TitRpt
        BacTrader.bacrpt.Connect = CONECCION
        BacTrader.bacrpt.Action = 1
    End If
    
''''' Case 11
    If ConCheck.Item(11).Visible = True Then
        Call Limpiar_Cristal
        
        TitRpt = "CARTERA DE CAPTACIONES A PLAZO "
        
        BacTrader.bacrpt.ReportFileName = RptList_Path & "bacinfcaptaciones.rpt"
        BacTrader.bacrpt.StoredProcParam(0) = Fechaproc
        
        BacTrader.bacrpt.WindowTitle = TitRpt
        BacTrader.bacrpt.Connect = CONECCION
        BacTrader.bacrpt.Action = 1
    End If
    
    
       
'''''        End Select
'''''    End If
'''''Next i

Screen.MousePointer = vbDefault
Exit Sub

Control:
    MsgBox "Problemas al generar Listado de Cartera. " & err.Description & ", " & err.Number, vbCritical, "BACTRADER"
    Screen.MousePointer = vbDefault
End Sub
Function BacProxHabil(xFecha As String) As String
Dim gsc_fechadma As String
    Dim dFecha As String
    
   dFecha = xFecha
  
   dFecha = Format(DateAdd("d", 1, dFecha), gsc_fechadma)
   Do While Not BacEsHabil(dFecha)
      dFecha = Format(DateAdd("d", 1, dFecha), gsc_fechadma)

   Loop

   BacProxHabil = dFecha


End Function

Private Sub Cmd_Salir_Click()
Unload Me
End Sub

Private Sub Combo2_Change()

End Sub


Private Sub ConCheck_Click(Index As Integer)

    SinCheck.Item(Index).Visible = Not SinCheck.Item(Index).Visible
    ConCheck.Item(Index).Visible = Not ConCheck.Item(Index).Visible

    If Index = 0 Or Index = 1 Or Index = 4 Then
        If ConCheck.Item(0).Visible = False And ConCheck.Item(1).Visible = False Then
           Ssf_Cartera_Normativa.Enabled = False
           Cmb_Cartera_Normativa.Enabled = False
        End If
    End If

End Sub

Private Sub Form_Load()
Dim X As Integer
Dim FecNueva As String

    Me.Top = 0
    Me.Left = 0
    Me.Icon = BacTrader.Icon
    
    Screen.MousePointer = vbHourglass
    giAceptar% = False

    Combo1.Clear
    If Bac_Sql_Execute("SP_LEER_ENTIDADES") Then
        Combo1.AddItem "TODAS LAS ENTIDADES                                                 "
        Do While Bac_SQL_Fetch(Datos())
            Combo1.AddItem Datos(1) & Space(50 + (30 - Len(Datos(1)))) & Str(Datos(2))
        Loop
    Else
        MsgBox "Proceso " & SQL & "no existe", vbOKOnly + vbCritical, "Entidades"
        Unload Me
    End If
    
    Combo1.ListIndex = 0
    
    '''''Call PROC_LLENA_COMBOS(GLB_LIBRO, Cmb_Libro, True)
    '''''Call PROC_LLENA_COMBOS(GLB_CARTERA_NORMATIVA, Cmb_Cartera_Normativa, True)
    
    Call PROC_LLENA_COMBOS(Cmb_Libro, 3, True, GLB_LIBRO)
    Call PROC_LLENA_COMBOS(Cmb_Cartera_Normativa, 3, True, GLB_CARTERA_NORMATIVA)
    Call PROC_LLENA_COMBOS(Cmb_Cartera, 4, True, "", GLB_CARTERA, GLB_ID_SISTEMA)
   
    Ssf_Cartera_Normativa.Enabled = False
    Cmb_Cartera_Normativa.Enabled = False
  
    txtFecha.text = gsBac_Fecx  'Format(FecNueva, "dd/mm/YYYY")
        
    'Func_Cartera Cmb_Cartera, "BTR"
    
    Screen.MousePointer = vbDefault
    
End Sub

Private Sub SSCommand1_Click()

End Sub

Private Sub SinCheck_Click(Index As Integer)
    ConCheck.Item(Index).Left = SinCheck.Item(Index).Left
    SinCheck.Item(Index).Visible = Not SinCheck.Item(Index).Visible
    ConCheck.Item(Index).Visible = Not ConCheck.Item(Index).Visible
    
    If Index = 0 Or Index = 1 Or Index = 4 Then
        Ssf_Cartera_Normativa.Enabled = True
        Cmb_Cartera_Normativa.Enabled = True
    End If

    
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
       
    Screen.MousePointer = vbHourglass
    
    Select Case Button.Index
       Case 1
          Call Cmd_Generar("Impresora")
       Case 2
          Call Cmd_Generar("Pantalla")
       Case 3
          Screen.MousePointer = vbDefault
          Unload Me
    End Select
    
    Screen.MousePointer = vbDefault
End Sub

