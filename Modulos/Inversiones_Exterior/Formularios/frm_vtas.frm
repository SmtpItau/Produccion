VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form Bac_Ventas_Filtro 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Ventas "
   ClientHeight    =   8025
   ClientLeft      =   -615
   ClientTop       =   3465
   ClientWidth     =   14565
   Icon            =   "frm_vtas.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   8025
   ScaleWidth      =   14565
   Begin VB.Frame Frame3 
      Height          =   4980
      Left            =   30
      TabIndex        =   1
      Top             =   690
      Width           =   14490
      Begin BACControles.TXTNumero TEXT1 
         Height          =   255
         Left            =   2775
         TabIndex        =   16
         Top             =   1410
         Visible         =   0   'False
         Width           =   1215
         _ExtentX        =   2143
         _ExtentY        =   450
         BackColor       =   12632256
         ForeColor       =   192
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
         BorderStyle     =   0
         Text            =   "0.0000"
         Text            =   "0.0000"
         Min             =   "0"
         Max             =   "999999999999.999999"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
      End
      Begin MSFlexGridLib.MSFlexGrid grilla 
         Height          =   4740
         Left            =   60
         TabIndex        =   2
         Top             =   180
         Width           =   14355
         _ExtentX        =   25321
         _ExtentY        =   8361
         _Version        =   393216
         Rows            =   3
         Cols            =   8
         FixedCols       =   0
         BackColor       =   -2147483644
         ForeColor       =   -2147483642
         BackColorFixed  =   8421376
         ForeColorSel    =   -2147483638
         BackColorBkg    =   8421376
         GridColor       =   64
         HighLight       =   2
         GridLines       =   2
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   9
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MouseIcon       =   "frm_vtas.frx":030A
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   660
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   14565
      _ExtentX        =   25691
      _ExtentY        =   1164
      ButtonWidth     =   1032
      ButtonHeight    =   1005
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   8
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Description     =   "Grabar"
            Object.ToolTipText     =   "Grabar"
            Object.Tag             =   "Grabar"
            ImageIndex      =   10
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Description     =   "Vende"
            Object.ToolTipText     =   "Vender"
            Object.Tag             =   "Vender"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Description     =   "Restaurar"
            Object.ToolTipText     =   "Restaurar"
            Object.Tag             =   "Restaurar"
            ImageIndex      =   19
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Description     =   "Filtar"
            Object.ToolTipText     =   "Filtrar"
            Object.Tag             =   "Filtrar"
            ImageIndex      =   14
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Description     =   "Buscar"
            Object.ToolTipText     =   "Buscar"
            Object.Tag             =   "Buscar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Description     =   "Emisión"
            Object.ToolTipText     =   "Emisión"
            Object.Tag             =   "Emisión"
            ImageIndex      =   16
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Description     =   "Limpiar"
            Object.ToolTipText     =   "Limpiar"
            Object.Tag             =   "Limpiar"
            ImageIndex      =   12
         EndProperty
         BeginProperty Button8 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Description     =   "Salir"
            Object.ToolTipText     =   "Salir"
            Object.Tag             =   "Salir"
            ImageIndex      =   20
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   0
      Top             =   390
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   32
      ImageHeight     =   32
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   20
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_vtas.frx":075C
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_vtas.frx":0A76
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_vtas.frx":0D92
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_vtas.frx":11E4
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_vtas.frx":1636
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_vtas.frx":1950
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_vtas.frx":1C6A
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_vtas.frx":20BC
            Key             =   ""
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_vtas.frx":2216
            Key             =   ""
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_vtas.frx":2668
            Key             =   ""
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_vtas.frx":2ABA
            Key             =   ""
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_vtas.frx":2DD4
            Key             =   ""
         EndProperty
         BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_vtas.frx":30EE
            Key             =   ""
         EndProperty
         BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_vtas.frx":3248
            Key             =   ""
         EndProperty
         BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_vtas.frx":369A
            Key             =   ""
         EndProperty
         BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_vtas.frx":3AEC
            Key             =   ""
         EndProperty
         BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_vtas.frx":3E06
            Key             =   ""
         EndProperty
         BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_vtas.frx":4120
            Key             =   ""
         EndProperty
         BeginProperty ListImage19 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_vtas.frx":443A
            Key             =   ""
         EndProperty
         BeginProperty ListImage20 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_vtas.frx":488C
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.Frame Frame2 
      Height          =   1815
      Left            =   0
      TabIndex        =   3
      Top             =   5640
      Width           =   14520
      Begin MSFlexGridLib.MSFlexGrid grdTotal 
         Height          =   1095
         Left            =   540
         TabIndex        =   17
         Top             =   600
         Width           =   13350
         _ExtentX        =   23548
         _ExtentY        =   1931
         _Version        =   393216
         Rows            =   4
         Cols            =   5
         BackColor       =   -2147483633
         BackColorBkg    =   -2147483636
         GridColorFixed  =   12632256
         GridLines       =   0
         GridLinesFixed  =   0
         MergeCells      =   1
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin BACControles.TXTNumero txt_monto_pag 
         Height          =   270
         Left            =   9660
         TabIndex        =   4
         Top             =   780
         Width           =   1635
         _ExtentX        =   2884
         _ExtentY        =   476
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0.0000"
         Text            =   "0.0000"
         Min             =   "0"
         Max             =   "999999999.9999"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTNumero txt_nominal 
         Height          =   270
         Left            =   1530
         TabIndex        =   5
         Top             =   750
         Width           =   1995
         _ExtentX        =   3519
         _ExtentY        =   476
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0.0000"
         Text            =   "0.0000"
         Min             =   "0"
         Max             =   "999999999.9999"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTFecha txt_fec_neg 
         Height          =   285
         Left            =   2460
         TabIndex        =   6
         Top             =   240
         Width           =   1410
         _ExtentX        =   2487
         _ExtentY        =   503
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
         MinDate         =   2
         Text            =   "18/06/2002"
      End
      Begin BACControles.TXTFecha txt_fec_pag 
         Height          =   300
         Left            =   5610
         TabIndex        =   7
         Top             =   225
         Width           =   1410
         _ExtentX        =   2487
         _ExtentY        =   529
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
         MinDate         =   2
         Text            =   "18/06/2002"
      End
      Begin VB.Label Label15 
         AutoSize        =   -1  'True
         Caption         =   "Fecha de Negociación"
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
         Left            =   570
         TabIndex        =   15
         Top             =   285
         Width           =   1770
      End
      Begin VB.Label Label16 
         AutoSize        =   -1  'True
         Caption         =   "Nominal"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   210
         Left            =   870
         TabIndex        =   14
         Top             =   780
         Width           =   660
      End
      Begin VB.Label Label17 
         AutoSize        =   -1  'True
         Caption         =   "Monto a Pagar"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   210
         Left            =   9600
         TabIndex        =   13
         Top             =   840
         Width           =   1170
      End
      Begin VB.Label Label18 
         AutoSize        =   -1  'True
         Caption         =   "Fecha de pago"
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
         Left            =   4290
         TabIndex        =   12
         Top             =   285
         Width           =   1185
      End
      Begin VB.Label lbl_int 
         AutoSize        =   -1  'True
         Caption         =   "Interés Devengado"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   210
         Left            =   6120
         TabIndex        =   11
         Top             =   750
         Width           =   1560
      End
      Begin VB.Label lbl_int_dev 
         Alignment       =   1  'Right Justify
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
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   7710
         TabIndex        =   10
         Top             =   750
         Width           =   1650
      End
      Begin VB.Label Label23 
         AutoSize        =   -1  'True
         Caption         =   "Principal"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   210
         Left            =   3570
         TabIndex        =   9
         Top             =   750
         Width           =   705
      End
      Begin VB.Label lbl_monto_prin 
         Alignment       =   1  'Right Justify
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
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   4200
         TabIndex        =   8
         Top             =   720
         Width           =   1650
      End
   End
   Begin VB.Frame Fr_Estados 
      Caption         =   "Estados"
      Height          =   525
      Left            =   0
      TabIndex        =   18
      Top             =   7455
      Width           =   14520
      Begin VB.Label Label10 
         BackColor       =   &H00FFFF80&
         Height          =   255
         Left            =   6735
         TabIndex        =   28
         Top             =   210
         Width           =   240
      End
      Begin VB.Label Label9 
         Caption         =   "Seleccionada para abonar"
         ForeColor       =   &H00C0C000&
         Height          =   255
         Left            =   4695
         TabIndex        =   27
         Top             =   240
         Width           =   2055
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         BackColor       =   &H8000000A&
         Caption         =   "Pendiente"
         ForeColor       =   &H000000FF&
         Height          =   195
         Left            =   675
         TabIndex        =   26
         Top             =   240
         Width           =   720
      End
      Begin VB.Label Label2 
         BackColor       =   &H000000FF&
         Height          =   255
         Left            =   1485
         TabIndex        =   25
         Top             =   210
         Width           =   240
      End
      Begin VB.Label Label3 
         AutoSize        =   -1  'True
         BackColor       =   &H8000000A&
         Caption         =   "Utilizada"
         ForeColor       =   &H00000000&
         Height          =   195
         Left            =   2835
         TabIndex        =   24
         Top             =   240
         Width           =   600
      End
      Begin VB.Label Label4 
         BackColor       =   &H00000000&
         Height          =   255
         Left            =   3555
         TabIndex        =   23
         Top             =   210
         Width           =   240
      End
      Begin VB.Label Label5 
         AutoSize        =   -1  'True
         BackColor       =   &H8000000A&
         Caption         =   "Seleccionada para vender"
         ForeColor       =   &H0000FFFF&
         Height          =   195
         Left            =   8055
         TabIndex        =   22
         Top             =   240
         Width           =   1875
      End
      Begin VB.Label Label6 
         BackColor       =   &H0000FFFF&
         Height          =   255
         Left            =   10095
         TabIndex        =   21
         Top             =   210
         Width           =   240
      End
      Begin VB.Label Label7 
         AutoSize        =   -1  'True
         BackColor       =   &H8000000A&
         Caption         =   "Disponible"
         ForeColor       =   &H00FF0000&
         Height          =   195
         Left            =   11640
         TabIndex        =   20
         Top             =   240
         Width           =   735
      End
      Begin VB.Label Label8 
         BackColor       =   &H00C00000&
         Height          =   255
         Left            =   12510
         TabIndex        =   19
         Top             =   210
         Width           =   240
      End
   End
End
Attribute VB_Name = "Bac_Ventas_Filtro"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim total_ope As Double
Dim FilaSeleccionada As Integer
Dim Arreglo As Double

Const Btn_Grabar = 1
Const Btn_Vende = 2
Const Btn_Restaurar = 3
Const Btn_Filtar = 4
Const Btn_Buscar = 5
Const Btn_Emision = 6
Const Btn_Limpiar = 7
Const Btn_Salir = 8

Public cCodCarteraSuper As String
Public cCodLibro        As String
Public cCodCarteraFin   As String

'Const Btn_Aceptar = 3

Dim TR          As Double
Dim TE          As Double
Dim TV          As Double
Dim TT          As Double
Dim BA          As Double
Dim BF          As Double
Dim NOM         As Double
Dim MT          As Double
Dim VV          As Double
Dim VP          As Double
Dim PVP         As Double
Dim VAN         As Double
Dim FP          As Date
Dim FE          As Date
Dim FV          As Date
Dim FU          As Date
Dim FX          As Date
Dim FC          As Date
Dim CI          As Double
Dim CT          As Double
Dim INDEV       As Double
Dim PRINC       As Double
Dim FIP         As Date
Dim INCTR       As Double
Dim CAP         As Double
Dim FPG         As Double
Dim SPREAD As Double

Dim Valoriza As Integer
Dim ModCal
Dim marca As Integer
Dim CodMoneda As String



Function buscar_unidad(Unidad)
    Dim Datos()
    envia = Array()
    AddParam envia, Unidad
    If Bac_Sql_Execute("SVC_VNT_BUS_UNI", envia) Then
        Do While Bac_SQL_Fetch(Datos)
            lbl_unidad.Caption = "Unidad : " & Datos(1)
        Loop
    End If
    
End Function

Sub dibuja_grilla()
Dim i As Integer

grilla.Rows = grilla.FixedRows
'grilla.Cols = 30   'JBH, 27-10-2009 agregada 1 columna para guardar el encaje
'grilla.TextMatrix(x, 30) = encaje
'grilla.TextMatrix(x, 31) = monto_emision
'grilla.TextMatrix(x, 32) = forma_pago
'grilla.TextMatrix(x, 33) = fecha_negociacion
'grilla.TextMatrix(x, 34) = DurMacaulay
'grilla.TextMatrix(x, 35) = DurModificada
'grilla.TextMatrix(x, 36) = Convexidad
grilla.Cols = 38    'JBH, 27-10-2009 agregadas 6 columnas:
                    'una para el monto de la emisión,
                    'otra para la forma de pago,
                    'otra para la fecha de la negociación,
                    'otra para DurMacaulay
                    'otra para DurModificada y
                    'otra para Convexidad
                    


grilla.TextMatrix(0, 1) = "Instrumento"
grilla.TextMatrix(0, 2) = "Vcto"
grilla.TextMatrix(0, 3) = "Nominal"
grilla.TextMatrix(0, 4) = "TIR"
grilla.TextMatrix(0, 5) = "% V.Compra"
grilla.TextMatrix(0, 6) = "Monto"
grilla.TextMatrix(0, 7) = "Interés"
grilla.TextMatrix(0, 8) = "Custodia"
grilla.TextMatrix(0, 9) = "Fecha Emi."
grilla.TextMatrix(0, 25) = "N° Oper."
grilla.TextMatrix(0, 27) = "Moneda"
grilla.TextMatrix(0, 28) = "Fecha Pago"

grilla.ColWidth(0) = 300
grilla.ColWidth(1) = 2000
grilla.ColWidth(2) = 1100
grilla.ColWidth(3) = 2000
grilla.ColWidth(4) = 1000
grilla.ColWidth(5) = 1200
grilla.ColWidth(6) = 1800
'grilla.ColWidth(7) = 1200
'JBH, 23-10-2009
grilla.ColWidth(7) = 1600
'fin JBH, 23-10-2009

grilla.ColWidth(8) = 1000


For i = 9 To grilla.Cols - 1
    grilla.ColWidth(i) = 0
Next

'+++jcamposd
grilla.ColWidth(9) = 1100
grilla.ColWidth(25) = 1000
'---jcamposd

grilla.ColWidth(27) = 800
grilla.ColWidth(28) = 1100
End Sub

Sub dibuja_grilla_Total()
Dim i As Integer

grdTotal.Rows = 2
grdTotal.Cols = 5

grdTotal.TextMatrix(1, 0) = "Total "
grdTotal.TextMatrix(0, 1) = "Nominal"
'grdTotal.TextMatrix(0, 2) = "Principal"    'JBH, 18-11-2009
grdTotal.TextMatrix(0, 3) = "Monto Total "
grdTotal.TextMatrix(0, 4) = "Interés"

grdTotal.ColWidth(0) = 1800
grdTotal.ColWidth(1) = 2300
grdTotal.ColWidth(2) = 0     ' 2300
grdTotal.ColWidth(3) = 2300
grdTotal.ColWidth(4) = 2300

grdTotal.ColAlignment(1) = 7
'grdTotal.ColAlignment(2) = 7
grdTotal.ColAlignment(3) = 7
grdTotal.ColAlignment(4) = 7

grdTotal.TextMatrix(1, 1) = "0.00"
'grdTotal.TextMatrix(1, 2) = "0.00"
grdTotal.TextMatrix(1, 3) = "0.00"
grdTotal.TextMatrix(1, 4) = "0.00"

End Sub
Function existen_datos()
    Dim Datos()
    existen_datos = 0
    If Bac_Sql_Execute("Svc_Vnt_bus_car ") Then
        Do While Bac_SQL_Fetch(Datos)
            existen_datos = Val(Datos(1))
        Loop
    End If
End Function
Sub Func_Restaurar()

    Call Restaurar_datos(1, grilla.Rows - 1)
    txt_nominal.Text = 0
    txt_monto_pag.Text = 0
    lbl_monto_prin.Caption = ""
    lbl_int_dev.Caption = ""
    For i = 0 To grilla.Cols - 1
        grilla.Col = i
        Call grilla_LeaveCell
    Next i
    Call dibuja_grilla_Total

    'JBH, 23-10-2009 Recalcular los totales
    Call Totales

End Sub

Sub Func_Vende()

Dim i As Integer

    If grilla.TextMatrix(grilla.row, 29) = "P" Then
        MsgBox "Este documento se encuentra pendiente a la espera de su aprobación, no es posible seleccionarlo para la venta.", vbOKOnly + vbExclamation, "Ventas"
        grilla.SetFocus
        Exit Sub
    End If
    
    '+++jcamposd no puede seleccionar documentos con distintas monedas
    If CodMoneda = "" Then
        CodMoneda = grilla.TextMatrix(grilla.row, 27)
    End If
    If CodMoneda = grilla.TextMatrix(grilla.row, 27) Then
        marca = marca + 1
        grilla.TextMatrix(grilla.row, 0) = "V"
        Call Valorizar(2)
        Call Totales
        For i = 0 To grilla.Cols - 1
               grilla.Col = i
               Call grilla_LeaveCell
        Next i
    Else
        MsgBox "No puede seleccionar Instrumentos de distinta moneda en una Venta", vbExclamation, gsBac_Version
    End If
    
End Sub

Sub Totales_OLD()
    Dim i%
    Dim TotNominal As Double
    Dim TotPrincipal As Double
    Dim TotIntereses As Double
    Dim TotAPagar As Double
    
    grdTotal.Rows = 2
    
    For i = 1 To grilla.Rows - 1
        If Trim(grilla.TextMatrix(i, 0)) <> "" Then
            If IsNumeric(grilla.TextMatrix(i, 3)) Then
                TotNominal = TotNominal + CDbl(grilla.TextMatrix(i, 3))
            End If
            
            If IsNumeric(grilla.TextMatrix(i, 23)) Then
                TotPrincipal = TotPrincipal + CDbl(grilla.TextMatrix(i, 23))
            End If
        
            If IsNumeric(grilla.TextMatrix(i, 7)) Then
                TotIntereses = TotIntereses + CDbl(grilla.TextMatrix(i, 7))
            End If
        End If
    Next
    
    TotAPagar = TotPrincipal + CDbl(TotIntereses)
    
    txt_nominal.Text = TotNominal
    lbl_monto_prin.Caption = Format(TotPrincipal, "###,###,###,###,##0.0000")
    lbl_int_dev.Caption = Format(TotIntereses, "###,###,###,###,##0.0000")
    txt_monto_pag.Text = TotAPagar
    
    grdTotal.TextMatrix(1, 0) = "Total USD"
    grdTotal.TextMatrix(1, 1) = Format(TotNominal, "#,###,###,###,###,##0.00") '--> jcamposd suma #
    grdTotal.TextMatrix(1, 2) = Format(TotPrincipal, "###,###,###,###,##0.00")
    grdTotal.TextMatrix(1, 3) = Format(TotIntereses, "###,###,###,###,##0.00")
    grdTotal.TextMatrix(1, 4) = Format(TotAPagar, "###,###,###,###,##0.00")
    
End Sub
Sub Totales()
    Dim i%
    Dim TotNominal As Double
    'Dim TotPrincipal As Double 'JBH, 18-11-2009
    Dim TotIntereses As Double
    Dim TotAPagar As Double
    
    Dim TotMonto As Double  'JBH, 18-11-2009
    
    Dim j As Integer
    Dim hasta As Integer
    Dim M
    
    hasta = UBound(MonedasOPVenta, 2)
    M = 0
    grdTotal.Rows = 2
    grdTotal.TextMatrix(1, 0) = "Total "
    grdTotal.TextMatrix(1, 1) = Format(TotNominal, "#,###,###,###,###,##0.00") '--> jcamposd suma #
    'grdTotal.TextMatrix(1, 2) = Format(TotPrincipal, "###,###,###,###,##0.00")
    grdTotal.TextMatrix(1, 4) = Format(TotIntereses, "###,###,###,###,##0.00")
    'grdTotal.TextMatrix(1, 4) = Format(TotAPagar, "###,###,###,###,##0.00")    'JBH, 18-11-2009
    grdTotal.TextMatrix(1, 3) = Format(TotMonto, "###,###,###,###,##0.00")

    For j = 1 To hasta
        TotIntereses = 0
        TotPrincipal = 0
        TotNominal = 0
        TotAPagar = 0
        TotMonto = 0    '18-11-2009
        For i = 1 To grilla.Rows - 1
            If MonedasOPVenta(1, j) = Val(grilla.TextMatrix(i, 16)) Then
                If Trim(grilla.TextMatrix(i, 0)) <> "" Then
                    If IsNumeric(grilla.TextMatrix(i, 3)) Then
                        TotNominal = TotNominal + CDbl(grilla.TextMatrix(i, 3))
                    End If
                    
'JBH, 18-11-2009  BLOQUEADO
'                    If IsNumeric(grilla.TextMatrix(i, 23)) Then
'                        TotPrincipal = TotPrincipal + CDbl(grilla.TextMatrix(i, 23))
'                    End If
                    If IsNumeric(grilla.TextMatrix(i, 6)) Then  'JBH, 18-11-2009
                        TotMonto = TotMonto + CDbl(grilla.TextMatrix(i, 6))
                    End If
                
                    If IsNumeric(grilla.TextMatrix(i, 7)) Then
                        TotIntereses = TotIntereses + CDbl(grilla.TextMatrix(i, 7))
                    End If
                End If
            End If
        Next
        
        
            TotAPagar = TotPrincipal + CDbl(TotIntereses)
'        If TotAPagar > 0 Then
        If TotMonto > 0 Then
            M = M + 1
            grdTotal.Rows = grdTotal.Rows + 1
            grdTotal.TextMatrix(M, 0) = "Total " & MonedasOPVenta(2, j)
            grdTotal.TextMatrix(M, 1) = Format(TotNominal, "#,###,###,###,###,##0.00") '--> jcamposd suma #
            'grdTotal.TextMatrix(M, 2) = Format(TotPrincipal, "###,###,###,###,##0.00") 'JBH, 18-11-2009
            grdTotal.TextMatrix(M, 4) = Format(TotIntereses, "###,###,###,###,##0.00")
            'grdTotal.TextMatrix(M, 4) = Format(TotAPagar, "###,###,###,###,##0.00")
            grdTotal.TextMatrix(M, 3) = Format(TotMonto, "###,###,###,###,##0.00")
        End If
    Next
        
End Sub

Function Func_Aceptar()

    gsBac_VarDouble = CDbl(grilla.TextMatrix(FilaSeleccionada, 6))
    gsBac_VarDouble2 = CDbl(grilla.TextMatrix(FilaSeleccionada, 7))
    giAceptar% = True
    
    Unload Me


End Function

Function Func_Limpiar()

    '+++jcamposd
    marca = 0
    CodMoneda = ""
    '---jcamposd
    Call dibuja_grilla
    Call dibuja_grilla_Total
    Toolbar1.Buttons(Btn_Limpiar).Enabled = False
    Toolbar1.Buttons(Btn_Buscar).Enabled = False
    Toolbar1.Buttons(Btn_Grabar).Enabled = False
    Toolbar1.Buttons(Btn_Emision).Enabled = False
    Toolbar1.Buttons(Btn_Salir).Enabled = True
    Toolbar1.Buttons(Btn_Vende).Enabled = False
    Toolbar1.Buttons(Btn_Restaurar).Enabled = False
    'Toolbar1.Buttons(Btn_Limpiar).Enabled = False
    txt_nominal.Text = 0
    txt_monto_pag.Text = 0
    lbl_monto_prin.Caption = ""
    lbl_int_dev.Caption = ""
    TEXT1.Visible = False
    grdTotal.row = 1
    
    Call llena_combo_familia
    
    FilaSeleccionada = 0
    
End Function
Function Clear_Objetos()
    Limpio = False
    'Me.lbl_tip_tasa.Caption = " "
    
'   txt_monto_emi.Text = " "
'   txt_monto_emi.Enabled = False
    txt_cod_emi.Visible = False
    txt_cod_emi.Text = " "
    box_dia.ListIndex = -1
    box_año.ListIndex = -1
    box_base.ListIndex = -1
    frm_nemo.Enabled = True
    box_nemo.Enabled = True
    box_nemo.ListIndex = -1
    box_familia.Enabled = True
    box_familia.ListIndex = -1
    box_basilea.ListIndex = -1
    box_familia.Enabled = True
    box_nemo.Enabled = False
    Txt_rut_Emi.Enabled = False
    Txt_rut_Emi.BackColor = &H80000004
    Op_Encaje_S.Value = False
    Op_Encaje_N.Value = False
    lbl_monto_emi.Caption = " "
    
    box_forma_pago.ListIndex = -1
    lbl_descrip.Caption = ""
    lbl_tip_tasa.Caption = ""
    Txt_rut_Emi = ""
    lbl_pais.Caption = ""
    lbl_emisor.Caption = ""
    
    txt_fec_emi.Text = Format(gsBac_Fecp, "DD/MM/YYYY")
    txt_fec_vcto.Text = Format(gsBac_Fecp, "DD/MM/YYYY")
    txt_tasa_vig.Text = 0
    txt_fec_neg.Text = Format(gsBac_Fecp, "DD/MM/YYYY")
    txt_fec_pag.Text = Format(gsBac_Fecp, "DD/MM/YYYY")
    txt_nominal.Text = ""
    txt_tir.Text = ""
    txt_pre_por.Text = ""
    txt_monto_pag.Text = ""
    lbl_int_dev.Caption = ""
    lbl_monto_prin.Caption = ""
    lbl_val_venc.Caption = ""
    box_mon_emi.ListIndex = -1
    BOX_MON_PAG.ListIndex = -1
    frm_datos_op.Enabled = False
    frm_descrip.Enabled = False
    frm_basilea.Enabled = False
    
    Toolbar1.Buttons(1).Enabled = False
    Toolbar1.Buttons(2).Enabled = False
    
    Txt_Nemo.Enabled = False
    Txt_Nemo.Text = ""
    
    txt_isin.Clear
    txt_cusip.Clear
    txt_bbnumber.Clear
    cbx_serie.Clear
    txt_mercado.Clear
    
    'Me.lblFactor.Caption = ""
    
   txtDur_Mac.Text = CDbl(0)
   txtDur_Mod.Text = CDbl(0)
   txtConvexi.Text = CDbl(0)

    
End Function


Function llena_grilla()
    
    Dim Datos()
    Dim i
    
    If box_familia.ListIndex = -1 Then
        MsgBox "No ha Selecionado Familia de Instrumentos", vbExclamation, gsBac_Version
        box_familia.SetFocus
        Exit Function
    End If
    
    Enviar = Array()
    AddParam Enviar, box_familia.ItemData(box_familia.ListIndex)
    AddParam Enviar, Bac_Usr_ofi
    
    i = 0
    
    If Bac_Sql_Execute("SVC_VNT_FIL_CAR", Enviar) Then
    
        Do While Bac_SQL_Fetch(Datos)
            If Datos(1) = 0 Then
                MsgBox Datos(2), vbExclamation, gsBac_Version
                Exit Function
            End If
            If Datos(6) <> 0 Then
                grilla.Rows = grilla.Rows + 1
                
                    grilla.TextMatrix(grilla.Rows - 1, 0) = Datos(1)
                    grilla.TextMatrix(grilla.Rows - 1, 1) = Format(Datos(2), "DD/MM/YYYY")
                    grilla.TextMatrix(grilla.Rows - 1, 2) = Format(CDbl(Datos(3)), "###,###,###,###,##0.00")
                    grilla.TextMatrix(grilla.Rows - 1, 3) = Format(CDbl(Datos(4)), "###,###,###,###,##0.000")
                    grilla.TextMatrix(grilla.Rows - 1, 4) = Format(CDbl(Datos(5)), "###,###,###,###,##0.000")
                    grilla.TextMatrix(grilla.Rows - 1, 5) = Format(CDbl(Datos(6)), "###,###,###,###,##0.000")
                    grilla.TextMatrix(grilla.Rows - 1, 6) = CDbl(Datos(7))
                    grilla.TextMatrix(grilla.Rows - 1, 7) = CDbl(Datos(8))
                    grilla.TextMatrix(grilla.Rows - 1, 9) = Format(Datos(13), "DD/MM/YYYY")

                    Toolbar1.Buttons(3).Enabled = True
                    Toolbar1.Buttons(4).Enabled = True
            End If
        Loop
        Call Marcar
    End If
    
    box_familia.Enabled = False
    Toolbar1.Buttons(Btn_Buscar).Enabled = False
    
End Function

Function valoriza_fecha()

    Dim Datos()
    Dim num
    Dim i As Integer


    For i = 1 To grilla.Rows - 1

          '+++jcamposd para calcular correctamente la TIR
            If CDbl((grilla.TextMatrix(grilla.row, 12))) = 2006 Then
                    Dim expo As Double
                    Dim intNom As Double
                    Dim valorPre As Double
                    Dim plazoOpe As Integer
                    Dim Formu As Double
                    Dim interes As Double
                    
                    'grilla.TextMatrix(grilla.row, 4) = Round(((((CDbl(CDbl(grilla.TextMatrix(grilla.row, 3))) / (CDbl(grilla.TextMatrix(grilla.row, 6)))) - 1#) * 100#) / (DateDiff("d", gsBac_Fecp, CDate(grilla.TextMatrix(grilla.row, 2))))) * 365, 4)
                    
                     'interes = CDbl(grilla.TextMatrix(grilla.row, 7))
        
                    intNom = CDbl(grilla.TextMatrix(grilla.row, 3)) + CDbl(grilla.TextMatrix(grilla.row, 37))
                    valoPre = (CDbl(grilla.TextMatrix(grilla.row, 6)))
                    Formu = (intNom / valoPre)
                    plazoOpe = (DateDiff("d", gsBac_Fecp, CDate(grilla.TextMatrix(grilla.row, 2))))
                    expo = (365 / plazoOpe)
                    
                    grilla.TextMatrix(grilla.row, 4) = ((Formu ^ expo) - 1) * 100
                    
                    ModCal = 2

            End If
            '---jcamposd para calcular correctamente la TIR

        Screen.MousePointer = 11
    
        TR = CDbl(grilla.TextMatrix(i, 4))     'Tir
        TE = CDbl(grilla.TextMatrix(i, 19))    'tasa Vigente
        TV = CDbl(grilla.TextMatrix(i, 19)) ' tasa Vigente
        TT = 0
        BF = 0
        NOM = CDbl(grilla.TextMatrix(i, 3))
        MT = CDbl(grilla.TextMatrix(i, 6)) 'Monto Pagamos
        VV = 0
        PVP = CDbl(grilla.TextMatrix(i, 5))   ' Precio
        VAN = 0
        FP = CDate(txt_fec_pag.Text)    'CDate(grilla.TextMatrix(grilla.Row, 20))
        FE = CDate(grilla.TextMatrix(i, 9)) ' Fecha Emision
        FV = CDate(grilla.TextMatrix(i, 2))  'Fecha Vencimiento
        FU = CDate(grilla.TextMatrix(i, 2))  ' Fecha Vencimiento
        FX = CDate(grilla.TextMatrix(i, 2))  ' Fecha Vencimiento
        FC = CDate(txt_fec_pag.Text)    ' CDate(grilla.TextMatrix(grilla.Row, 20)) 'Fecha Pago
        CI = 0
        CT = 0
        INDEV = 0
        PRINC = 0
        FIP = CDate(txt_fec_pag.Text)    'CDate(grilla.TextMatrix(grilla.Row, 20))  'Fecha Pago
        INCTR = 0
        CAP = 0
        BA = CDbl(grilla.TextMatrix(i, 22))    'Base
        
        envia = Array()
        AddParam envia, CDate(txt_fec_pag.Text)    'CDate(grilla.TextMatrix(grilla.Row, 20)) 'Fecha Pago
        AddParam envia, " "
        If CDbl((grilla.TextMatrix(grilla.row, 12))) <> 2006 Then
            AddParam envia, 1     'modalidad de calculo
        Else
            AddParam envia, 2
        End If
        AddParam envia, CDbl((grilla.TextMatrix(i, 12))) 'Codigo Familia
        
        If (grilla.TextMatrix(i, 12)) = 2000 Then
            AddParam envia, grilla.TextMatrix(i, 1)    'Nombre Serie
        Else
            AddParam envia, grilla.TextMatrix(i, 18)    'Nombre Familia
        End If
        
        AddParam envia, CDate(grilla.TextMatrix(i, 2))
        AddParam envia, TR
        AddParam envia, TE
        AddParam envia, TV
        AddParam envia, TT
        AddParam envia, Val(BA)
        AddParam envia, BF
        AddParam envia, NOM
        AddParam envia, MT
        AddParam envia, VV
        AddParam envia, VP
        AddParam envia, PVP
        AddParam envia, VAN
        AddParam envia, FP
        AddParam envia, FE
        AddParam envia, FV
        AddParam envia, FU
        AddParam envia, FX
        AddParam envia, FC
        AddParam envia, CI
        AddParam envia, CT
        AddParam envia, INDEV
        AddParam envia, PRINC
        AddParam envia, FIP
        AddParam envia, CAP
        AddParam envia, INCTR
        AddParam envia, SPREAD
        AddParam envia, "S"
        AddParam envia, CDbl(grilla.TextMatrix(i, 16))
        '+++jcamposd 20161230 se suman los por defecto dato que se agrego si es venta al final
        AddParam envia, 0
        AddParam envia, 0
        AddParam envia, 0
        AddParam envia, 0
        AddParam envia, 0
        AddParam envia, 0
        '---jcamposd 20161230 se suman los por defecto dato que se agrego si es venta al final
        
        '+++jcamposd 20161230 se envia este parametro para identificar que es una venta para los COP (es opcional)
        AddParam envia, "S"
        '---jcamposd 20161230 se envia este parametro para identificar que es una venta para los COP (es opcional)
            
        If Bac_Sql_Execute("SVC_PRC_VAL_INS", envia) Then
            Do While Bac_SQL_Fetch(Datos)
            
                grilla.TextMatrix(i, 4) = Format(CDbl(Datos(1)), "##,##0.00000") 'Tir
                grilla.TextMatrix(i, 19) = CDbl(Datos(2))  'Tasa Vigente
                grilla.TextMatrix(i, 19) = CDbl(Datos(3))  'Tasa Vigente
                grilla.TextMatrix(i, 3) = Format(CDbl(Datos(7)), "#,###,###,###,##0.00") 'nominal '--> jcamposd suma #
                grilla.TextMatrix(i, 6) = Format(CDbl(Datos(8)), "###,###,###,##0.0000") 'monto pagamos
                grilla.TextMatrix(i, 21) = Format(CDbl(Datos(9)), "###,###,###,##0.0000") 'Valor Vencimiento
                grilla.TextMatrix(i, 5) = Format(CDbl(Datos(11)), "###,##0.00000")
                'txt_fec_neg.Text = Format(datos(13), "DD/MM/YYYY")
                grilla.TextMatrix(i, 9) = Format(Datos(14), "DD/MM/YYYY")
                grilla.TextMatrix(i, 17) = Format(Datos(15), "DD/MM/YYYY")
                grilla.TextMatrix(i, 20) = Format(Datos(18), "dd/mm/yyyy")
                '+++jcamposd 20170105 no debe recalcular interes devengado si es COP
                If CDbl((grilla.TextMatrix(grilla.row, 12))) <> 2006 Then
                    grilla.TextMatrix(grilla.row, 7) = Format(CDbl(Datos(21)), "###,###,###,###0.00") 'Interes Devengado
                End If
                '---jcamposd 20170105 no debe recalcular interes devengado si es COP
                grilla.TextMatrix(i, 23) = Format(CDbl(Datos(22)), "###,###,###,###0.0000") 'Principal
                
                
                TR = CDbl(Datos(1))
                TV = CDbl(Datos(3))
                MT = CDbl(Datos(8))
                VV = CDbl(Datos(9))
                VP = CDbl(Datos(10))
                PVP = CDbl(Datos(11))
                VAN = CDbl(Datos(12))
                FU = CDate(Format(Datos(16), "dd/mm/yyyy"))
                FX = CDate(Format(Datos(17), "dd/mm/yyyy"))
                CI = CDbl((Datos(19)))
                CT = CDbl((Datos(20)))
                INDEV = CDbl(Datos(21))
                PRINC = CDbl(Datos(22))
                
                If grilla.TextMatrix(i, 16) = 13 Or grilla.TextMatrix(i, 16) = 994 Then
                    grilla.TextMatrix(i, 26) = CDbl(Datos(8)) * gsBac_ObsMesAnt
                Else
                    
                End If
                
            Loop
       End If
       
       Call Totales
       
       Screen.MousePointer = 0


Next i

'    If ModCal = 1 And CDbl(grilla.TextMatrix(grilla.Row, 3)) = 0 Then
'        Exit Function
'    End If
'
'    If ModCal = 1 And CDbl(grilla.TextMatrix(grilla.Row, 5)) = 0 Then 'PRECIO
'        Exit Function
'    End If
'
'    If ModCal = 2 And CDbl(grilla.TextMatrix(grilla.Row, 4)) = 0 Then 'TIR
'        Exit Function
'    End If
'
'    If ModCal = 3 And CDbl(grilla.TextMatrix(grilla.Row, 12)) = 0 Then 'Monto Pagamos
'        Exit Function
'    End If
'
'    If CDbl(grilla.TextMatrix(grilla.Row, 19)) = 0 Then 'tasa Vigente
'        Exit Function
'    End If


End Function


Private Sub Form_Activate()
    cTipo_Oper = "VPX"
End Sub

Private Sub Form_Load()

    Move 0, 0
    Tipo_op = "V"
    giAceptar% = False
    txt_fec_neg.Text = Format(gsBac_Fecp, "dd/mm/yyyy")
            
    Call Func_Limpiar
    Call buscar_unidad(Bac_Usr_ofi)
    Call dibuja_grilla_Total
    Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "Ingreso a Pantalla de Ventas")
    grilla.SelectionMode = flexSelectionFree
    
    Call LeeModoControlPT   'PRD-3860, modo silencioso
End Sub

Sub Marcar()

   Dim f, C, R, v As Integer

   Dim lrow As Integer

   FilaSeleccionada = grilla.RowSel
   
   lrow = grilla.TopRow
   
   With grilla
   
      f = .RowSel
      

      .FocusRect = flexFocusHeavy
      .Redraw = False

    For R = 1 To .Rows - 1
         
        For C = 0 To .Cols - 1
        
               .row = R
               .Col = C
               

                  If R <> f Then
                     .BackColorSel = &HC0C0C0
                     .BackColorFixed = &H808000
                     .ForeColorFixed = &H80000005
                     .CellBackColor = &HC0C0C0
                     .CellForeColor = vbBlue
                  End If
                  
               If f = R Then
                    .BackColorSel = &H800000
                    .BackColorFixed = &H808000
                    .ForeColorFixed = &H80000005
                    .CellBackColor = vbBlue    ''vbRed
                    .CellForeColor = vbWhite
               End If
        Next C
    Next R
      .row = f
      .Col = 0
      .FocusRect = flexFocusLight
      .Redraw = True
   End With
   
   
    If lrow > 1 Then
        grilla.TopRow = lrow
    End If
   
End Sub



Function llena_combo_familia()
    Dim Datos()
'    box_familia.Clear
'    If Bac_Sql_Execute("Svc_Gen_fam_ins") Then
'        Do While Bac_SQL_Fetch(datos)
'            box_familia.AddItem datos(2)
'            box_familia.ItemData(box_familia.NewIndex) = Val(datos(1))
'        Loop
'    End If
End Function

Private Sub Form_Unload(Cancel As Integer)

    Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "Ingreso a Pantalla de Ventas")

End Sub

Private Sub grilla_KeyDown(KeyCode As Integer, Shift As Integer)
columnita = grilla.Col
     
End Sub

Private Sub grilla_KeyPress(KeyAscii As Integer)


Dim i          As Integer
Dim Sql        As String
Dim Datos()
Dim reg        As Double
Dim bloq       As String
Dim fila_table As Double
Dim Fila As Integer
Dim nRowTop As Integer

 nRowTop = grilla.TopRow
 columna = grilla.Col
 
 If grilla.row > 0 Then

        Select Case KeyAscii
            Case 118, 86 '(  V ó v)
                'JBH, 23-10-2009
                Call Func_Vende
                'fin JBH, 23-10-2009
                
'                grilla.TextMatrix(grilla.row, 0) = "V"
'                Call Valorizar(2)
'                Call Totales
''                 For I = 0 To grilla.Cols - 1
''                       grilla.Col = I
''                       Call grilla_LeaveCell
''                    Next I
            Case 114
                'JBH, 23-10-2009
                Call Func_Restaurar
                'fin JBH, 23-10-2009
'                grilla.TextMatrix(grilla.row, columnita) = "  "
'                Call Restaurar_datos(grilla.row, grilla.row)
''                For I = 0 To grilla.Cols - 1
''                    grilla.Col = I
''                    Call grilla_LeaveCell
''                 Next I
'                 Call Totales
                 
        End Select

 End If

'JBH, 23-10-2009
If grilla.Col = 3 Or grilla.Col = 4 Or grilla.Col = 5 Or grilla.Col = 6 Then
'Verificar si el registro está pendiente
    If grilla.TextMatrix(grilla.RowSel, 29) = "P" Then
        MsgBox "Este documento se encuentra pendiente a la espera de su aprobación, no es posible modificarlo.", vbOKOnly + vbExclamation, "Ventas"
        grilla.SetFocus
        Exit Sub
    End If

End If
'fin JBH, 23-10-2009


 If grilla.Col = 3 Then
         TEXT1.CantidadDecimales = 2
         TEXT1.Max = CDbl(grilla.TextMatrix(grilla.row, 24))
 ElseIf grilla.Col = 5 Then
        TEXT1.CantidadDecimales = 6
        TEXT1.Min = -999.999999
ElseIf grilla.Col = 4 Then '+++jcamposd se suma 1 decimal a solicitud de usuario por los COP
        TEXT1.CantidadDecimales = 5
Else
        TEXT1.CantidadDecimales = 4
End If

   
 If (grilla.Col = 3 Or grilla.Col = 4 Or grilla.Col = 5 Or grilla.Col = 6) And IsNumeric(Chr(KeyAscii)) Then
    
      TEXT1.Text = grilla.TextMatrix(grilla.row, grilla.Col)
      grilla.Col = columna
      TEXT1.Top = grilla.CellTop + grilla.Top + 20
      TEXT1.Left = grilla.CellLeft + grilla.Left + 20
      TEXT1.Width = grilla.CellWidth
            
      TEXT1.Text = Chr(KeyAscii)
      TEXT1.SelStart = 1
      TEXT1.Visible = True
      TEXT1.SetFocus
       
 End If
  
End Sub

Private Sub grilla_LeaveCell()
    With grilla
        If .row <> 0 And .Col >= 1 Then
            .CellFontBold = True
            If .TextMatrix(grilla.row, 0) = "V" Then
                .CellBackColor = vbYellow
                .CellForeColor = vbBlack
            ElseIf .TextMatrix(.row, 0) = "P" Then
                .CellBackColor = vbCyan
                .CellForeColor = vbBlack
            ElseIf grilla.TextMatrix(.row, 0) = "*" Then
                .CellBackColor = vbBlack
                .CellForeColor = vbWhite
            ElseIf grilla.TextMatrix(.row, 0) = "B" Then
                .CellBackColor = vbBlack + vbWhite    'vbBlack
                .CellForeColor = vbBlack
            ElseIf .TextMatrix(.row, 29) = "P" Then
                .CellBackColor = vbRed
                .CellForeColor = vbWhite
            Else
                .CellForeColor = vbWhite
                .CellBackColor = vbBlue
            End If
        End If
    End With
End Sub


Private Sub grilla_RowColChange()
    
    grilla.CellForeColor = vbWhite
    grilla.CellBackColor = &H808000
    
End Sub


Private Sub grilla_Scroll()

Text1_LostFocus

End Sub


Private Sub Text1_GotFocus()

'If grilla.Col = 6 Then
'
'    TEXT1.SelStart = Len(TEXT1.Text)
' Else
'    If bFlagDpx Then
'         TEXT1.SelStart = Len(TEXT1.Text) - 3
'    Else
'        TEXT1.SelStart = Len(TEXT1.Text) - 5
'    End If
' End If

End Sub


Function Valorizar(ModCal)
Dim Datos()
Dim num

    If ModCal = 1 And CDbl(grilla.TextMatrix(grilla.row, 3)) = 0 Then
        Exit Function
    End If

    If ModCal = 1 And CDbl(grilla.TextMatrix(grilla.row, 5)) = 0 Then 'PRECIO
        Exit Function
    End If

    If ModCal = 2 And CDbl(grilla.TextMatrix(grilla.row, 4)) = 0 Then 'TIR
        Exit Function
    End If
    
    If ModCal = 3 And CDbl(grilla.TextMatrix(grilla.row, 12)) = 0 Then 'Monto Pagamos
        Exit Function
    End If
    
    If CDbl(grilla.TextMatrix(grilla.row, 19)) = 0 Then 'tasa Vigente
        Exit Function
    End If
    
    '+++jcamposd para calcular correctamente la TIR
    If CDbl((grilla.TextMatrix(grilla.row, 12))) = 2006 Then
        If ModCal = 3 And CDbl(grilla.TextMatrix(grilla.row, 12)) <> 0 Then
            Dim expo As Double
            Dim intNom As Double
            Dim valorPre As Double
            Dim plazoOpe As Integer
            Dim Formu As Double
            Dim interes As Double
            
            'grilla.TextMatrix(grilla.row, 4) = Round(((((CDbl(CDbl(grilla.TextMatrix(grilla.row, 3))) / (CDbl(grilla.TextMatrix(grilla.row, 6)))) - 1#) * 100#) / (DateDiff("d", gsBac_Fecp, CDate(grilla.TextMatrix(grilla.row, 2))))) * 365, 4)
            
             'interes = CDbl(grilla.TextMatrix(grilla.row, 7))

            intNom = CDbl(grilla.TextMatrix(grilla.row, 3)) + CDbl(grilla.TextMatrix(grilla.row, 37))
            valoPre = (CDbl(grilla.TextMatrix(grilla.row, 6)))
            Formu = (intNom / valoPre)
            plazoOpe = (DateDiff("d", gsBac_Fecp, CDate(grilla.TextMatrix(grilla.row, 2))))
            expo = (365 / plazoOpe)
            
            grilla.TextMatrix(grilla.row, 4) = ((Formu ^ expo) - 1) * 100
            
            ModCal = 2
        End If
    End If
    '---jcamposd para calcular correctamente la TIR
    
    
    Screen.MousePointer = 11

    TR = CDbl(grilla.TextMatrix(grilla.row, 4))     'Tir
    TE = CDbl(grilla.TextMatrix(grilla.row, 19))    'tasa Vigente
    TV = CDbl(grilla.TextMatrix(grilla.row, 19)) ' tasa Vigente
    TT = 0
    BF = 0
    NOM = CDbl(grilla.TextMatrix(grilla.row, 3))
    MT = CDbl(grilla.TextMatrix(grilla.row, 6)) 'Monto Pagamos
    VV = 0
    PVP = CDbl(grilla.TextMatrix(grilla.row, 5))   ' Precio
    VAN = 0
    FP = CDate(txt_fec_pag.Text)    'CDate(grilla.TextMatrix(grilla.Row, 20))
    FE = CDate(grilla.TextMatrix(grilla.row, 9)) ' Fecha Emision
    FV = CDate(grilla.TextMatrix(grilla.row, 2))  'Fecha Vencimiento
    FU = CDate(grilla.TextMatrix(grilla.row, 2))  ' Fecha Vencimiento
    FX = CDate(grilla.TextMatrix(grilla.row, 2))  ' Fecha Vencimiento
    FC = CDate(txt_fec_pag.Text)    ' CDate(grilla.TextMatrix(grilla.Row, 20)) 'Fecha Pago
    CI = 0
    CT = 0
    INDEV = 0
    PRINC = 0
    FIP = CDate(txt_fec_pag.Text)    'CDate(grilla.TextMatrix(grilla.Row, 20))  'Fecha Pago
    INCTR = 0
    CAP = 0
    BA = CDbl(grilla.TextMatrix(grilla.row, 22))    'Base
    SPREAD = 0
    
    envia = Array()
    AddParam envia, CDate(txt_fec_pag.Text)    'CDate(grilla.TextMatrix(grilla.Row, 20)) 'Fecha Pago
    AddParam envia, " "
    AddParam envia, ModCal
    AddParam envia, CDbl((grilla.TextMatrix(grilla.row, 12))) 'Codigo Familia
    
    If (grilla.TextMatrix(grilla.row, 12)) = 2000 Then
        AddParam envia, grilla.TextMatrix(grilla.row, 1)    'Nombre Serie
    Else
        AddParam envia, grilla.TextMatrix(grilla.row, 18)    'Nombre Familia
    End If
    
    AddParam envia, CDate(grilla.TextMatrix(grilla.row, 2))
    AddParam envia, TR
    AddParam envia, TE
    AddParam envia, TV
    AddParam envia, TT
    AddParam envia, Val(BA)
    AddParam envia, BF
    AddParam envia, NOM
    AddParam envia, MT
    AddParam envia, VV
    AddParam envia, VP
    AddParam envia, PVP
    AddParam envia, VAN
    AddParam envia, FP
    AddParam envia, FE
    AddParam envia, FV
    AddParam envia, FU
    AddParam envia, FX
    AddParam envia, FC
    AddParam envia, CI
    AddParam envia, CT
    AddParam envia, INDEV
    AddParam envia, PRINC
    AddParam envia, FIP
    AddParam envia, INCTR
    AddParam envia, CAP
    AddParam envia, SPREAD
    AddParam envia, "S"
    AddParam envia, CDbl(grilla.TextMatrix(grilla.row, 16))
    '+++jcamposd 20161230 se suman los por defecto dato que se agrego si es venta al final
    AddParam envia, 0
    AddParam envia, 0
    AddParam envia, 0
    AddParam envia, 0
    AddParam envia, 0
    AddParam envia, 0
    '---jcamposd 20161230 se suman los por defecto dato que se agrego si es venta al final
    
    '+++jcamposd 20161230 se envia este parametro para identificar que es una venta para los COP (es opcional)
    AddParam envia, "S"
    '---jcamposd 20161230 se envia este parametro para identificar que es una venta para los COP (es opcional)
    If Bac_Sql_Execute("SVC_PRC_VAL_INS", envia) Then
        Do While Bac_SQL_Fetch(Datos)
        
            grilla.TextMatrix(grilla.row, 4) = Format(CDbl(Datos(1)), "##,##0.00000") 'Tir
            grilla.TextMatrix(grilla.row, 19) = CDbl(Datos(2))  'Tasa Vigente
            grilla.TextMatrix(grilla.row, 19) = CDbl(Datos(3))  'Tasa Vigente
            grilla.TextMatrix(grilla.row, 3) = Format(CDbl(Datos(7)), "#,###,###,###,##0.00") 'nominal '--> jcamposd suma #
            If IsNull(Datos(8)) Then
                grilla.TextMatrix(grilla.row, 6) = Format(0, "###,###,###,##0.00") 'monto pagamos
            Else
                grilla.TextMatrix(grilla.row, 6) = Format(CDbl(Datos(8)), "###,###,###,##0.00") 'monto pagamos
            End If
            grilla.TextMatrix(grilla.row, 21) = Format(CDbl(Datos(9)), "###,###,###,##0.0000") 'Valor Vencimiento
            If IsNull(Datos(11)) Then
                grilla.TextMatrix(grilla.row, 5) = Format(0, "###,##0.000000")
            Else
                grilla.TextMatrix(grilla.row, 5) = Format(CDbl(Datos(11)), "###,##0.000000")
            End If
            'txt_fec_neg.Text = Format(datos(13), "DD/MM/YYYY")
            grilla.TextMatrix(grilla.row, 9) = Format(Datos(14), "DD/MM/YYYY")
            If opcion_filtrado <> "I" Then
            grilla.TextMatrix(grilla.row, 17) = Format(Datos(15), "DD/MM/YYYY")
            End If
            grilla.TextMatrix(grilla.row, 20) = Format(Datos(18), "dd/mm/yyyy")
            
            '+++jcamposd 20170105 no debe recalcular interes devengado si es COP
            If CDbl((grilla.TextMatrix(grilla.row, 12))) <> 2006 Then
                grilla.TextMatrix(grilla.row, 7) = Format(CDbl(Datos(21)), "###,###,###,###0.00") 'Interes Devengado
            End If
            '---jcamposd 20170105 no debe recalcular interes devengado si es COP
            If IsNull(Datos(22)) Then
                grilla.TextMatrix(grilla.row, 23) = Format(0, "###,###,###,###0.0000") 'Principal
            Else
                grilla.TextMatrix(grilla.row, 23) = Format(CDbl(Datos(22)), "###,###,###,###0.0000") 'Principal
            End If
            
                        
            
            TR = CDbl(Datos(1))
            TV = CDbl(Datos(3))
            MT = CDbl(Datos(8))
            VV = CDbl(Datos(9))
            VP = CDbl(Datos(10))
            PVP = CDbl(Datos(11))
            VAN = CDbl(Datos(12))
            FU = CDate(Format(Datos(16), "dd/mm/yyyy"))
            FX = CDate(Format(Datos(17), "dd/mm/yyyy"))
            CI = CDbl((Datos(19)))
            CT = CDbl((Datos(20)))
            INDEV = CDbl(Datos(21))
            PRINC = CDbl(Datos(22))
            
            'If Grilla.TextMatrix(Grilla.Row, 16) = 13 Or Grilla.TextMatrix(Grilla.Row, 16) = 994 Then
                grilla.TextMatrix(grilla.row, 26) = Monto_a_Peso("VP", grilla.TextMatrix(grilla.row, 16), CDbl(Datos(8)))   ' CDbl(Datos(8)) * gsBac_ObsMesAnt
            'Else
                
            'End If
            
        Loop
   End If
            
    Screen.MousePointer = 0
            
End Function

Function ValorizarOLD_COPIA(ModCal)
Dim Datos()

    If Not IsDate(txt_fec_pag.Text) Then
        Exit Function
    End If
    
    If CDbl(txt_nominal.Text) = 0 Then
        Exit Function
    End If
    
    If ModCal = 1 And CDbl(txt_pre_por.Text) = 0 Then
        Exit Function
    End If
    
    If ModCal = 2 And CDbl(txt_tir.Text) = 0 Then
        Exit Function
    End If
    
    
    If ModCal = 3 And CDbl(txt_monto_pag.Text) = 0 Then
        Exit Function
    End If
    
    
    If Not IsDate(txt_fec_emi.Text) Then
        Exit Function
    End If
    
    If Not IsDate(txt_fec_vcto.Text) Then
        Exit Function
    End If
    
    If Not IsDate(txt_fec_neg.Text) Then
        Exit Function
    End If

    If CDbl(txt_tasa_vig.Text) = 0 Then
        Exit Function
    End If
    
    Screen.MousePointer = 11

    
    TR = CDbl(txt_tir.Text)
    TE = CDbl(txt_tasa_vig.Text)
    TV = CDbl(txt_tasa_vig.Text)
    TT = 0
    BF = 0
    NOM = CDbl(txt_nominal.Text)
    MT = CDbl(txt_monto_pag.Text)
    VV = 0
    PVP = CDbl(txt_pre_por.Text)
    VAN = 0
    FP = CDate(txt_fec_pag.Text)
    FE = CDate(txt_fec_emi.Text)
    FV = CDate(txt_fec_vcto.Text)
    FU = CDate(txt_fec_vcto.Text)
    FX = CDate(txt_fec_vcto.Text)
    FC = CDate(txt_fec_pag.Text)
    CI = 0
    CT = 0
    INDEV = 0
    PRINC = 0
    FIP = CDate(txt_fec_pag.Text) 'aaaaa
    INCTR = 0
    CAP = 0
    
    envia = Array()
    AddParam envia, CDate(txt_fec_pag.Text)
    AddParam envia, " "
    AddParam envia, ModCal
    AddParam envia, box_familia.ItemData(box_familia.ListIndex)
    
    If box_familia.ItemData(box_familia.ListIndex) = 2000 Then
        AddParam envia, Txt_Nemo.Text
    Else
        AddParam envia, box_familia.Text
    End If
    
    AddParam envia, txt_fec_vcto.Text
    AddParam envia, TR
    AddParam envia, TE
    AddParam envia, TV
    AddParam envia, TT
    AddParam envia, Val(BA)
    AddParam envia, BF
    AddParam envia, NOM
    AddParam envia, MT
    AddParam envia, VV
    AddParam envia, VP
    AddParam envia, PVP
    AddParam envia, VAN
    AddParam envia, FP
    AddParam envia, FE
    AddParam envia, FV
    AddParam envia, FU
    AddParam envia, FX
    AddParam envia, FC
    AddParam envia, CI
    AddParam envia, CT
    AddParam envia, INDEV
    AddParam envia, PRINC
    AddParam envia, FIP
    AddParam envia, INCTR
    AddParam envia, CAP
    AddParam envia, "S"
    AddParam envia, box_moneda.ItemData(box_moneda.ListIndex)
    Dim num
    
    If Bac_Sql_Execute("SVC_PRC_VAL_INS", envia) Then
        Do While Bac_SQL_Fetch(Datos)
        
            txt_tir.Text = CDbl(Datos(1))
            txt_tasa_vig.Text = CDbl(Datos(2))
            txt_tasa_vig.Text = CDbl(Datos(3))
            txt_nominal.Text = CDbl(Datos(7))
            txt_monto_pag.Text = Format(CDbl(Datos(8)), "###,###,###,##0.00") 'CDbl(datos(8))
            lbl_val_venc.Caption = Format(CDbl(Datos(9)), "###,###,###,##0.00")
            txt_pre_por.Text = CDbl(Datos(11))
            txt_fec_neg.Text = Format(Datos(13), "DD/MM/YYYY")
            txt_fec_emi.Text = Format(Datos(14), "DD/MM/YYYY")
            txt_fec_vcto.Text = Format(Datos(15), "DD/MM/YYYY")
            txt_fec_pag.Text = Format(Datos(18), "dd/mm/yyyy")
            lbl_int_dev.Caption = Format(CDbl(Datos(21)), "###,###,###,###0.00")
            lbl_monto_prin.Caption = Format(CDbl(Datos(22)), "###,###,###,###0.00")
            
            TR = CDbl(Datos(1))
            TV = CDbl(Datos(3))
            MT = CDbl(Datos(8))
            VV = CDbl(Datos(9))
            VP = CDbl(Datos(10))
            PVP = CDbl(Datos(11))
            VAN = CDbl(Datos(12))
            FU = CDate(Format(Datos(16), "dd/mm/yyyy"))
            FX = CDate(Format(Datos(17), "dd/mm/yyyy"))
            CI = CDbl((Datos(19)))
            CT = CDbl((Datos(20)))
            INDEV = CDbl(Datos(21))
            PRINC = CDbl(Datos(22))
            
        Loop
   End If
            
    Screen.MousePointer = 0
            
End Function

Private Sub TEXT1_KeyDown(KeyCode As Integer, Shift As Integer)
Dim ptInstr As String
Dim ptPlazo As Integer
Dim ptTasa As Double

ptInstr = grilla.TextMatrix(grilla.row, 12)     'antes apuntaba a la posición 13    PRD-10494
ptPlazo = DateDiff("D", gsBac_Fecp, CDate(grilla.TextMatrix(grilla.row, 2)))
ptTasa = CDbl(grilla.TextMatrix(grilla.row, 4))

If KeyCode = 13 Then
    If grilla.Col = 3 Then
        If TEXT1.Text = 0 Then
            MsgBox "Monto Nominal no puede ser 0", vbInformation, "Mensaje"
            grilla.TextMatrix(grilla.row, 3) = Format(grilla.TextMatrix(grilla.row, 24), "#,###,###,###,###0.00") 'JBH, 25-11-2009 cambiado de ...0,00") a ....0.00")'--> jcamposd suma #
            TEXT1.Visible = False
           TEXT1.Text = 0
           Exit Sub
        End If
    End If
   grilla.Text = TEXT1.Text
   TEXT1.Visible = False
   TEXT1.Text = 0

    If CDbl(grilla.TextMatrix(grilla.row, 3)) = CDbl(grilla.TextMatrix(grilla.row, 24)) Then
         grilla.TextMatrix(grilla.row, 0) = "V"
    ElseIf CDbl(grilla.TextMatrix(grilla.row, 3)) < CDbl(grilla.TextMatrix(grilla.row, 24)) Then
         grilla.TextMatrix(grilla.row, 0) = "P"
    End If
    
    If grilla.Col = 3 And grilla.TextMatrix(grilla.row, 3) <> 0 Then
        Call Valorizar(2)
    End If

    If grilla.Col = 4 And grilla.TextMatrix(grilla.row, 4) <> 0 Then
        Call Valorizar(2)
        'Aplicar aquí el Control de Precios y Tasas (columna del TIR)
        
        'Usar como tasa el nuevo valor ingresado en la grilla  PRD-10494
        ptTasa = CDbl(grilla.TextMatrix(grilla.row, 4))
        
        'Aun no tengo cliente...
        Ctrlpt_RutCliente = ""
        Ctrlpt_CodCliente = ""
        
        If ControlPreciosTasas("VPX", ptInstr, ptPlazo, ptTasa) = "S" Then
            If Ctrlpt_ModoOperacion <> "S" Then 'PRD-3860, modo silencioso
            MsgBox Ctrlpt_Mensaje, vbExclamation, TITSISTEMA
        End If
    End If
    End If

    If grilla.Col = 5 And grilla.TextMatrix(grilla.row, 5) <> 0 Then
        Call Valorizar(1)
    End If

    If grilla.Col = 6 And grilla.TextMatrix(grilla.row, 6) <> 0 Then
        Call Valorizar(3)
    End If
    
    Call Marcar
    Call Totales
    
'   grilla.SetFocus

ElseIf KeyCode = 27 Then
        TEXT1.Visible = False

End If

End Sub

Private Sub Text1_LostFocus()

On Error Resume Next
'text1.Text = 0
TEXT1.Visible = False
BacControlWindows 100
grilla.SetFocus
'SendKeys "{right}"

End Sub
Function Valida_Vendidos() As Boolean
Dim i%


    Valida_Vendidos = False

    For i = 1 To grilla.Rows - 1
        If Trim(grilla.TextMatrix(i, 0)) <> "" Then
        
            Valida_Vendidos = True
            
        End If
        
    Next

End Function
Function Valida_FechaPago() As Boolean
Dim i%
Dim fechaPagoCompra As Date

   fechaPagoCompra = CDate(txt_fec_pag.Text)

   Valida_FechaPago = False

    For i = 1 To grilla.Rows - 1
        If Trim(grilla.TextMatrix(i, 0)) <> "" Then
        
           If fechaPagoCompra < CDate(Trim(grilla.TextMatrix(i, 28))) Then
              fechaPagoCompra = CDate(Trim(grilla.TextMatrix(i, 28)))
           End If
           
        End If
    Next
    If CDate(txt_fec_pag.Text) >= fechaPagoCompra Then
        
              Valida_FechaPago = True
            
    End If
    
    If Not Valida_FechaPago Then
       MsgBox "No se puede realizar transacción por que la Fecha de Pago de la Venta es menor a la Fecha de Pago de la Compra", vbExclamation, gsBac_Version
    End If

End Function


Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
'JBH, 23-10-2009
Dim p As Integer
Dim titulo As String
'fin JBH, 23-10-2009

'Const Btn_Grabar = 1
'Const Btn_Vende = 2
'Const Btn_Restaurar = 3
'Const Btn_Filtar = 4
'Const Btn_Buscar = 5
'Const Btn_Emision = 6
'Const Btn_Limpiar = 7
'Const Btn_Salir = 8

    Select Case Button.Index
     
    Case Btn_Grabar
        If Valida_Vendidos And Valida_FechaPago Then
            Call Grabar_Ventas
        End If
            
    Case Btn_Vende
        Call Func_Vende
            
    Case Btn_Restaurar
        Call Func_Restaurar
        
    Case Btn_Filtar
       BacIrfSl.Show vbModal
        Call buscar_datos
        
        'JBH, 23-10-2009
        titulo = Me.Caption
        p = InStr(1, Me.Caption, "(", vbTextCompare)
        If opcion_filtrado = "N" Then
            If p > 0 Then
                titulo = Mid$(titulo, 1, p - 2)
            End If
            titulo = titulo & " (Operaciones Normales)"
            Me.Caption = titulo
        ElseIf opcion_filtrado = "I" Then
            If p > 0 Then
                titulo = Mid$(titulo, 1, p - 2)
            End If
            titulo = titulo & " (Operaciones Intramesas)"
            Me.Caption = titulo
        End If

        'fin JBH, 23-10-2009
       
        
    Case Btn_Emision
        Nom_inst = grilla.TextMatrix(grilla.row, 1)
        Fechadet = grilla.TextMatrix(grilla.row, 2)
        Bac_detalle.Show vbModal
       
    Case Btn_Limpiar
        Call Func_Limpiar
       
   Case Btn_Aceptar
       Call Func_Aceptar
   
   Case Btn_Salir
       Unload Me
        
        
    End Select
End Sub


Function buscar_datos()

Dim hasta As Integer
Dim Numdocu As Double
Dim Datos()
Dim j As Integer
Dim M As Integer
Dim nContador As Integer
'JBH, 22-10-2009
Dim nomSp As String
    
    If bAceptar = False Then Exit Function
    
    Call Func_Limpiar

    envia = Envia_Filtrar
    
    Bac_Ventas_Filtro.cCodCarteraSuper = envia(4)
    Bac_Ventas_Filtro.cCodCarteraFin = envia(5)
    Bac_Ventas_Filtro.cCodLibro = envia(6)
                
    'JBH, 22-10-2009
    If opcion_filtrado = "N" Then
        nomSp = "Svc_Vnt_dat_ins"
    ElseIf opcion_filtrado = "I" Then
        nomSp = "SP_VENTASFILTROINTRAMESAS"
    End If
    'fin JBH, 22-10-2009
    
    'If Bac_Sql_Execute("Svc_Vnt_dat_ins", envia) Then
    If Bac_Sql_Execute(nomSp, envia) Then
        Screen.MousePointer = vbHourglass
                
        Do While Bac_SQL_Fetch(Datos)
            grilla.Redraw = False
            grilla.Rows = grilla.Rows + 1
            M = grilla.Rows - 1
            grilla.TextMatrix(M, 1) = Datos(5)      'Serie
            
            grilla.TextMatrix(M, 2) = Format(Datos(17), "DD/MM/YYYY")  'Fecha Vencimiento
            grilla.TextMatrix(M, 3) = Format(CDbl(Datos(8)), "#,###,###,###,###,##0.00") 'Nominal'--> jcamposd suma #
            grilla.TextMatrix(M, 4) = Format(CDbl(Datos(11)), "#,##0.00000") ' Tir
            grilla.TextMatrix(M, 5) = Format(CDbl(Datos(10)), "#,##0.000000") ' Valor compra - Precio
            grilla.TextMatrix(M, 6) = Format(CDbl(Datos(12)), "###,###,###,###,##0.00") ' Monto Pagamos
            grilla.TextMatrix(M, 7) = Format(CDbl(Datos(39)), "#,###,###,###,###,##0.00")   'Interes --> jcamposd antes por defecto 0 hoy COP
            grilla.TextMatrix(M, 37) = Format(CDbl(Datos(40)), "#,###,###,###,###,##0.00")   'Interes --> jcamposd antes por defecto 0 hoy COP
            If Datos(36) = "0" Then
                grilla.TextMatrix(M, 8) = ""
            Else
                grilla.TextMatrix(M, 8) = Datos(36)
            End If
            
            grilla.TextMatrix(M, 9) = Format(Datos(16), "DD/MM/YYYY")  ' Fecha Emision
            grilla.TextMatrix(M, 10) = CDbl(Datos(18)) 'Rut Emisor
            grilla.TextMatrix(M, 11) = CDbl(Datos(32))  'Cod Emisor
            grilla.TextMatrix(M, 12) = CDbl(Datos(28)) 'Codigo Familia
            grilla.TextMatrix(M, 13) = Datos(34)    'cusip
            grilla.TextMatrix(M, 14) = Datos(29)               'Moneda de Pago
            grilla.TextMatrix(M, 15) = Datos(6)               'Base
            grilla.TextMatrix(M, 16) = Val(Datos(19))       'Moneda Emision
            grilla.TextMatrix(M, 17) = Val(Datos(20))       'Basilea
            grilla.TextMatrix(M, 18) = Datos(35)       'Nombre Familia
            grilla.TextMatrix(M, 19) = CDbl(Datos(7))   ' Tasa Vigente
            grilla.TextMatrix(M, 20) = Format(gsBac_Fecp, "DD/MM/YYYY")  ' Fecha Pago
            grilla.TextMatrix(M, 21) = CDbl(Datos(9))   ' Valor Vencimiento
            grilla.TextMatrix(M, 22) = CDbl(Datos(6))   ' Base
            grilla.TextMatrix(M, 23) = 0                            'Principal
            grilla.TextMatrix(M, 24) = CDbl(Datos(8)) 'Nominal
            grilla.TextMatrix(M, 25) = Datos(2) 'Numdocu              'Numero de Documento
            grilla.TextMatrix(M, 27) = Datos(37)              'moneda
            grilla.TextMatrix(M, 28) = Format(Datos(13), "DD/MM/YYYY")  'Fecha Pago
            txt_fec_pag.MinDate = Format(gsBac_Fecp, "DD/MM/YYYY")
            txt_fec_pag.Text = Format(gsBac_Fecp, "DD/MM/YYYY")
            grilla.TextMatrix(M, 29) = Datos(38)
                
            'JBH, 27-10-2009
            If opcion_filtrado = "I" Then
                grilla.TextMatrix(M, 30) = Datos(22) 'Encaje
                grilla.TextMatrix(M, 31) = Datos(39) 'Monto Emisión
                grilla.TextMatrix(M, 32) = Datos(31) 'Forma de Pago
                grilla.TextMatrix(M, 33) = Datos(40) 'Fecha de Negociación
                grilla.TextMatrix(M, 34) = Datos(41) 'DurMacaulay
                grilla.TextMatrix(M, 35) = Datos(42) 'DurModificada
                grilla.TextMatrix(M, 36) = Datos(43) 'Convexidad
            End If
            'agregar
            'fin JBH, 27-10-2009
                                 
            For nContador = 1 To grilla.Cols - 1
                grilla.row = M
                grilla.Col = nContador
                Call grilla_LeaveCell
            Next nContador
            grilla.Redraw = True
        Loop
    End If
'''''    End If
'''''Next M

    If grilla.Rows > 1 Then
        Toolbar1.Buttons(1).Enabled = True
        Toolbar1.Buttons(2).Enabled = True
        Toolbar1.Buttons(3).Enabled = True
        Toolbar1.Buttons(5).Enabled = False
        Toolbar1.Buttons(6).Enabled = True
        Toolbar1.Buttons(7).Enabled = True
    End If
Screen.MousePointer = Default
End Function

Function RetSpxOpcionFiltrado(Opcion) As String
Select Case Opcion
    Case "N"
        RetSpxOpcionFiltrado = "SVC_VNT_DAT_INS"
    Case "I"
        RetSpxOpcionFiltrado = "SP_VENTASFILTROINTRAMESAS"
End Select
End Function
Function Restaurar_datos(desde, hasta)

'JBH, 23-10-2009
Dim nomSp As String
'fin JBH, 23-10-2009

'Dim Hasta As Integer
Dim Numdocu As Double
Dim Datos()
Dim j As Integer
Dim M As Integer
    
    
''''' For M = desde To hasta
'''''    If IsNumeric(grilla.TextMatrix(M, 25)) Then
'''''                 Numdocu = (grilla.TextMatrix(M, 25))
                 
                envia = Array()
                envia = Envia_Filtrar
'''''                AddParam envia, gsBac_RutC
'''''                AddParam envia, Numdocu
                
                'JBH, 23-10-2009
                nomSp = RetSpxOpcionFiltrado(opcion_filtrado)
                'fin JBH, 23-10-2009
                'If Bac_Sql_Execute("Svc_Vnt_dat_ins", envia) Then  'JBH, 23-10-2009
                If Bac_Sql_Execute(nomSp, envia) Then
                    M = grilla.row
                    Do While Bac_SQL_Fetch(Datos)

                            If (grilla.TextMatrix(M, 25)) = Datos(2) Then
        '                        grilla.Rows = grilla.Rows + 1
                                
                                grilla.TextMatrix(M, 0) = " "
                                
                                
                                grilla.TextMatrix(M, 1) = Datos(5)      'Serie
                                grilla.TextMatrix(M, 2) = Format(Datos(17), "DD/MM/YYYY")  'Fecha Vencimiento
                                grilla.TextMatrix(M, 3) = Format(CDbl(Datos(8)), "#,###,###,###,###,##0.00") 'Nominal'--> jcamposd suma #
                                grilla.TextMatrix(M, 4) = Format(CDbl(Datos(11)), "#,##0.00000") ' Tir
                                grilla.TextMatrix(M, 5) = Format(CDbl(Datos(10)), "#,##0.000000") ' Valor compra - Precio
                                grilla.TextMatrix(M, 6) = Format(CDbl(Datos(12)), "###,###,###,###,##0.00") ' Monto Pagamos
                                grilla.TextMatrix(M, 7) = Format(CDbl(Datos(39)), "#,###,###,###,###,##0.00")   'Interes --> jcamposd antes por defecto 0 hoy COP
                                grilla.TextMatrix(M, 37) = Format(CDbl(Datos(40)), "#,###,###,###,###,##0.00")   'Interes --> jcamposd antes por defecto 0 hoy COP
'''''                                grilla.TextMatrix(M, 8) = "Custodia"
                                If Datos(36) = "0" Then
                                    grilla.TextMatrix(M, 8) = ""
                                Else
                                    grilla.TextMatrix(M, 8) = Datos(36)
                                End If
                                grilla.TextMatrix(M, 9) = Format(Datos(16), "DD/MM/YYYY")  ' Fecha Emision
                                grilla.TextMatrix(M, 10) = CDbl(Datos(18)) 'Rut Emisor
                                grilla.TextMatrix(M, 11) = CDbl(Datos(32))  'Cod Emisor
                                grilla.TextMatrix(M, 12) = CDbl(Datos(28)) 'Codigo Familia
                                grilla.TextMatrix(M, 13) = Datos(34)    'cusip
                                grilla.TextMatrix(M, 14) = Datos(29)               'Moneda de Pago
                                grilla.TextMatrix(M, 15) = Datos(6)               'Base
                                grilla.TextMatrix(M, 16) = Val(Datos(19))       'Moneda Emision
                                grilla.TextMatrix(M, 17) = Val(Datos(20))       'Basilea
                                grilla.TextMatrix(M, 18) = Datos(35)       'Nombre Familia
                                grilla.TextMatrix(M, 19) = CDbl(Datos(7))   ' Tasa Vigente
                                grilla.TextMatrix(M, 20) = Format(gsBac_Fecp, "DD/MM/YYYY")  ' Fecha Pago
                                grilla.TextMatrix(M, 21) = CDbl(Datos(9))   ' Valor Vencimiento
                                grilla.TextMatrix(M, 22) = CDbl(Datos(6))   ' Base
                                grilla.TextMatrix(M, 23) = 0                            'Principal
                                grilla.TextMatrix(M, 24) = CDbl(Datos(8)) 'Nominal
                                grilla.TextMatrix(M, 25) = Datos(2) 'Numdocu              'Numero de Documento
                                grilla.TextMatrix(M, 28) = Format(Datos(13), "DD/MM/YYYY")  'Fecha Pago
                                txt_fec_pag.MinDate = Format(gsBac_Fecp, "DD/MM/YYYY")
                                txt_fec_pag.Text = Format(gsBac_Fecp, "DD/MM/YYYY")
                                '+++jcamposd
                                If CodMoneda = grilla.TextMatrix(M, 27) Then
                                    marca = marca - 1
                                    If marca = 0 Then
                                        CodMoneda = ""
                                    End If
                                End If
                                '---jcamposd
                                Exit Function 'lo encontro y restauro
                            End If
                    Loop
                End If
'''''    End If
'''''Next M

End Function


Function Grabar_Ventas()
   Dim Datos()
   Dim Numoper       As Double
   Dim Numdocu       As Double
   Dim Correlativo   As Integer
   Dim okGrabar      As Boolean
   Dim nFactor       As Double
    
   gsmoneda = 13               'Str(box_moneda.ItemData(box_moneda.ListIndex))
   Tipo_op = "V"
   
   Bac_Intermediario.cCodCarteraFin = Bac_Ventas_Filtro.cCodCarteraFin
   Bac_Intermediario.cCodCarteraSuper = Bac_Ventas_Filtro.cCodCarteraSuper
   Bac_Intermediario.cCodLibro = Bac_Ventas_Filtro.cCodLibro
   Bac_Intermediario.Show vbModal
   If giAceptar = True Then
   
      'JBH, 26-10-2009
      
      If Trim(rut_cli) = gsBac_RutC Then    '"97023000" JBH, 04-12-2009
            Call VT_GrabarVenta
      Else
            Call VT_GrabarTx
      End If
      'fin JBH, 26-10-2009
    End If
    
   Grabar_Ventas = 0
End Function
Function VT_GrabarVenta()
'Caso de operación intramesas
'Esto implica grabar además, la Compra como contrapartida. JBH, 26-10-2009
'
'Primero, grabar la Venta en MOV_ticketbonext
'
'-------------------------------------------------------------------------------
'( nRutcart ,     -- rut del due¤o de cartera.-
'  cTipcart ,     -- código tipo de cartera.-
'  nForpagi ,     -- código de forma de inicio
'  cTipcust ,     -- con l mina o sin lámina.- S/N
'  cRetiro  ,     -- tipo de retiro.-          V/I
'  cPagohoy ,     -- pago hoy o ma¤ana         H/M
'  cObserva ,     -- Observaciones
'  nRutcli  ,     -- Rut del cliente
'  fCPForm  )     -- Formulario de la compra.-
'-------------------------------------------------------------------------------

'El numoper para el caso de los movtos. Venta es el mismo, JBH, 28-10-2009

    On Error GoTo VT_GrabarVentaError

    Dim Datos()
    Dim dNumdocu    As Double
    'JBH, 20-10-2009
    Dim i As Integer
    Dim n As Integer
    Dim txtNemo As String
    Dim dNumDocCompra As Double
    Dim dNumDocVenta As Double
    Dim valOperacionRelacionada As Double
    Dim codFamilia As String
    Dim fechaPago As String
    Dim monEmi As Integer
    Dim monPago As Integer
    Dim Encaje As String
    Dim montoEmision As Double
    Dim FormaPago As Double
    Dim fechaNeg As String
    Dim CorrelVenta As Double
    Dim parGrabados As String
    'fin JBH, 20-10-2009
    n = grilla.Rows
        
    Dim iCorrela%
    Dim sMascara$, sInstSer$, sGenEmi$, sNemMon$, dNominal#, dTir#, sFecpcup$
    Dim dPvp#, dVPar#, dMt#, dMt100#, iNumUCup%, dTasEst#, sFecEmi$
    Dim sFecVen$, sMdse$, lCodigo&, sSerie$, iMonemi%, lRutemi&
    Dim dTasEmi#, iBasemi%
    Dim dTirMcd#, dPvpMcd#, dMtMcd#, dMtMcd100#
    Dim sFecPro$
    Dim FlagTx       As Boolean
    Dim Resultado%
    Dim Correlativo&
    Dim CorteMin#
    Dim cCustodiaDCV As String
    Dim cClaveDCV    As String
    Dim cCarteraSuper As String
'VB+- 27/06/2000 se crean estas variables para grabar en las compras propias estos datos
    Dim dConvexidad  As Double
    Dim dDuratMac    As Double
    Dim dDuratMod    As Double
    Dim iCodExeLIM   As Integer
    Dim dMtoExcLIM   As Double
    Dim iPlazo       As Integer
    Dim dMontoOriginal As Double
   
    Dim bExisteDPX      As Boolean
    Dim PagarPeso As Double
    Dim PendienteLinea  As String
   
    PendienteLinea = "P"
    bExisteDPX = False
    sFecPro = Format(gsBac_Fecp, feFECHA)
    ' Pone en falso indicando que todavia no se realiz un Begin Transaction
    FlagTx = False
    'mmp
      If Not Bac_Sql_Execute("BEGIN TRANSACTION") Then
        GoTo VT_GrabarVentaError
    End If
        
    ' Indica inicio de Begin Transaction y se puede hacer el RollBack
    FlagTx = True
    
    
    ' Primera llamada, para generar el correlativo de la Venta
    If Not Bac_Sql_Execute("SP_OPMDAC_BONEXT") Then
        GoTo VT_GrabarVentaError
    End If
        
  ' Recupero el Numero de Documento
    If Bac_SQL_Fetch(Datos()) Then
       dNumdocu = Val(Datos(1)) + 1
       dNumDocVenta = dNumdocu
    End If
    
    'Recorro la grilla y selecciono solo aquellas filas con una V o una P
    parGrabados = ""
    CorrelVenta = 0 'Este es el nuevo correlativo (correl_relacion) de la tabla MOV_ticketbonext, JBH, 28-10-2009
                    'Se debe incrementar solo para el registro de las Ventas
                    
    For i = 0 To n - 1
        If grilla.TextMatrix(i, 0) = "V" Or grilla.TextMatrix(i, 0) = "P" Then
            'Procesar registro
            CorrelVenta = CorrelVenta + 1
            txtNemo = grilla.TextMatrix(i, 1)
        
            '********** Linea -- Mkilo
            If gsBac_Lineas = "S" Then
                Dim Mensaje     As String
                Dim SwResp      As Integer
                Dim TCambio     As Double
                Mensaje = ""
                iCorrela% = 0
                If Trim$(txtNemo) <> "" Then
                    If Mid(Trim$(txtNemo), 1, 3) = "DPX" Then
                        TCambio = 0
                    Else
                        TCambio = gsBac_TCambio
                    End If
                End If
            End If
            '********** Fin
            If Trim$(txtNemo) <> "" Then
                NOM = grilla.TextMatrix(i, 3)
                MT = grilla.TextMatrix(i, 6)
                TR = grilla.TextMatrix(i, 4)
                PVP = grilla.TextMatrix(i, 5)
                VP = 0
                INDEV = grilla.TextMatrix(i, 7)
                PRINC = grilla.TextMatrix(i, 23)
                Numdocu = grilla.TextMatrix(i, 25)
                Encaje = grilla.TextMatrix(i, 30)
                montoEmision = grilla.TextMatrix(i, 31)
                FormaPago = CDbl(grilla.TextMatrix(i, 32))
                fechaNeg = CDate(grilla.TextMatrix(i, 33))
                ' Recupera datos del Data Control del Form enviado
                Dim Op
                codFamilia = grilla.TextMatrix(i, 12)
                fechaPago = grilla.TextMatrix(i, 9)
                If codFamilia = "2000" Then
                    Op = Feriados_inter(fechaPago, Pais_invers)
                Else
                    Op = Feriados_inter(fechaPago, Pais_invers)
                End If
        
                If Op = False Then
                    MsgBox "Fecha De Pago en el Pais De origen Es Feriado", vbInformation, gsBac_Version
                    Screen.MousePointer = 0
                    Exit Function
                End If
                monEmi = CInt(grilla.TextMatrix(i, 16))
                monPago = CInt(grilla.TextMatrix(i, 14))
                PagarPeso = Monto_a_Peso("CP", monEmi, CDbl(MT))
                
                envia = Array()
                AddParam envia, gsBac_Fecp
                AddParam envia, CDbl(gsBac_RutC)
                AddParam envia, CDbl(codFamilia)
                If codFamilia = "2000" Then
                    AddParam envia, txtNemo
                Else
                    AddParam envia, codFamilia
                End If
                AddParam envia, txtNemo
                AddParam envia, CDbl(rut_cli)
                AddParam envia, Cod_cli
                AddParam envia, FE
                AddParam envia, FV
                AddParam envia, monEmi
                AddParam envia, monPago
                AddParam envia, TE
                AddParam envia, BA
                AddParam envia, CDbl(grilla.TextMatrix(i, 10))  'Rut emisor, JBH, 28-10-2009
                AddParam envia, CDate(grilla.TextMatrix(i, 20)) 'Fecha de Pago, JBH, 28-10-2009
                AddParam envia, CDbl(NOM)
                AddParam envia, CDbl(MT)
                AddParam envia, CDbl(VV)
                AddParam envia, CDbl(TR)
                AddParam envia, CDbl(PVP)
                AddParam envia, CDbl(VP)
                AddParam envia, CDbl(INDEV)
                AddParam envia, PRINC
                AddParam envia, CDbl(CI - 1)
                AddParam envia, CI
                AddParam envia, FU
                AddParam envia, FX
                AddParam envia, gsBac_User
                AddParam envia, ""  'Terminal
                AddParam envia, obseravcion
                AddParam envia, CDbl(grilla.TextMatrix(i, 17))  'Basilea, JBH, 28-10-2009
                If codFamilia = "" Then
                    AddParam envia, 100
                Else
                    AddParam envia, Val(grilla.TextMatrix(i, 19))
                End If
                AddParam envia, Encaje  'JBH, 27-10-2009
                AddParam envia, 0   'Monto encaje
                AddParam envia, codigo_cartera_super
                AddParam envia, Tipo_Inversion
                AddParam envia, ""  'Operador banco
                AddParam envia, ""  'Tipo Inversión
                AddParam envia, Tipo_Inversion  'Tipo riesgo
                AddParam envia, ""  'grado riesgo
                AddParam envia, ""  'codigo riesgo
                AddParam envia, ""  'nombre custodia
                'JBH, 27-10-2009
                If codFamilia = "2000" Then
                    AddParam envia, montoEmision
                Else
                    AddParam envia, 0
                End If
                If codFamilia = "2001" Then
                    cusip = 2001
                Else
                    If CInt(grilla.TextMatrix(i, 13)) = 0 Then
                        cusip = 0
                    Else
                        cusip = CInt(grilla.TextMatrix(i, 13))
                    End If
                End If
                AddParam envia, FormaPago
                AddParam envia, ""
                AddParam envia, CDbl(Cod_emi)
                AddParam envia, fechaNeg
                AddParam envia, Trim(cusip)
                AddParam envia, dNumdocu
                AddParam envia, PendienteLinea
                AddParam envia, PagarPeso
        
                AddParam envia, CDbl(grilla.TextMatrix(i, 34))  'DurMacaulay
                AddParam envia, CDbl(grilla.TextMatrix(i, 35))  'DurModificada
                AddParam envia, CDbl(grilla.TextMatrix(i, 36))  'Convexidad
        
                AddParam envia, Area_Responsable
                AddParam envia, libro
                'Nuevos parametros
                AddParam envia, cod_mesa_origen
                AddParam envia, cod_mesa_destino
                AddParam envia, cod_cartera_destino
                AddParam envia, CorrelVenta
                AddParam envia, Numdocu
                If Not Bac_Sql_Execute("SVA_VNT_GRB_OPE_BONEXTMOV", envia) Then
                    If FlagTx = True Then
                        If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
                            MsgBox "No se pudo grabar el registro de la Venta", vbCritical, gsBac_Version
      End If
                    End If

                    MsgBox "Operación de Venta " & dNumDocVenta & " no pudo ser grabada", vbCritical, gsBac_Version
                    Exit Function
                Else
                    'leer los resultados
                    If Bac_SQL_Fetch(Datos()) Then
                        dNumDocVenta = Val(Datos(2))
                        dNumDocCompra = Val(Datos(3))
                    End If
                    If dNumDocVenta <> 0 Then
                        parGrabados = parGrabados & dNumDocVenta & "/" & dNumDocCompra & vbCrLf
                    End If
               End If
            End If
        End If
        
    Next i
    
    
    MsgBox "Operación de Venta Entre Tickets Grabada Con los siguientes Pares:" & vbCrLf & parGrabados, vbInformation, gsBac_Version
       
    If Not Bac_Sql_Execute("COMMIT TRANSACTION") Then
        GoTo VT_GrabarVentaError
    End If
    
    Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "Operación de Venta número: " & dNumDocVenta & " - " & dNumDocCompra & ", grabada con éxito.")
    grilla.Rows = 1
   
    VT_GrabarVenta = dNumdocu
    Call Func_Limpiar
      
    Exit Function
        
        
VT_GrabarVentaError:

    MsgBox "Se ha producido un problema en la grabación de la operación de Venta: " & err.Description & ". Comunique al Administrador. ", vbCritical, gsBac_Version
           
    If FlagTx = True Then
        If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
            MsgBox "No se pudo realizar devolución de transacción inicializada", vbCritical, gsBac_Version
      End If
    End If
    VT_GrabarVenta = 0
    Exit Function


End Function
Function Feriados_inter(Fecha, pais)

    Dim Datos()
    Dim Feriados As String
    Dim Ano As Double
    Dim Mes As Double
    Dim Dia As Double
    Dim dia_1 As Integer
    Dim i As Double
    Dia = Format(Mid(Fecha, 1, 2), "00")
    Mes = Format(Mid(Fecha, 4, 2), "00")
    Ano = Format(Mid(Fecha, 7, 4), "0000")
    envia = Array()
    AddParam envia, Ano
    AddParam envia, pais
    AddParam envia, Mes
    If Bac_Sql_Execute("SVC_OPE_LEE_FRD ", envia) Then
        Do While Bac_SQL_Fetch(Datos)
            If Datos(1) = 1 Then
                Feriados_inter = True
                Exit Function
            Else
                Feriados = Datos(3)
            End If
        Loop
    End If
    Feriados = Trim(Feriados)
    If Feriados = "" Then
        Feriados_inter = True
        Exit Function
    End If
    For i = 1 To 100
        If (Mid(Feriados, i, 1)) = "," Then
            i = i + 1
        End If
        If Mid(Feriados, i, 2) = "" Then
            Feriados_inter = True
            Exit Function
        End If
        dia_1 = CDbl(Mid(Feriados, i, 2))
        i = i + 1
        If Dia = dia_1 Then
            Feriados_inter = False
            Exit Function
        End If
    Next i
    Feriados_inter = True
End Function

Function VT_GrabarTx()
   Dim Datos()
   Dim Numoper       As Double
   Dim Numdocu       As Double
   Dim nFactor       As Double
   '--- para el control de precios y tasas
   Dim ptCodInst As String
   Dim ptPlazo As Integer
   Dim ptTasa As Double
   Dim resControlPT As String
   Dim Mensaje_CPT As String
   
   On Error GoTo VT_GrabarTxError
      ' Indica inicio de Begin Transaction y se puede hacer el RollBack
   If Not Bac_Sql_Execute("BEGIN TRANSACTION") Then
      GoTo VT_GrabarTxError
   End If
      FlagTx = True
      ' Consulto el número de documento de tabla mdac (Mesa Dinero Archivo Control)
      If Not Bac_Sql_Execute("SP_OPMDAC") Then
         GoTo VT_GrabarTxError
      End If
      ' Recupero el Numero de Documento
      If Bac_SQL_Fetch(Datos()) Then
         Numoper = Val(Datos(1)) + 1
      End If
      Correlativo = 0
      okGrabar = False
      
      For i = 1 To grilla.Rows - 1
         Numdocu = CDbl(grilla.TextMatrix(i, 25))
         nFactor = CDbl(grilla.TextMatrix(i, 3)) / CDbl(grilla.TextMatrix(i, 24))
         If Trim(grilla.TextMatrix(i, 0)) <> "" Then     'Las que esten Vendidas o parcialmente Vendidas
            '********** Linea -- Mkilo
            If gsBac_Lineas = "S" Then
               If Not Lineas_ChequearGrabar("BEX", "VPX", Numoper, Numdocu, 1, CDbl(rut_cli), Cod_cli, CDbl(grilla.TextMatrix(i, 6)), gsBac_TCambio, gsBac_Fecp, 0, 0, gsBac_Fecp, 0, "S", 0, "C", 0, "N", 0, gsBac_Fecp, nFactor, 0, 0, 0, "") Then
               End If
            End If
            Mensaje = Mensaje & Lineas_Chequear("BEX", "VP", Numoper, " ", " ", " ")
            If Mensaje <> "" Then
               MsgBox "Error al Chequear Lineas : " + Chr(10) + Chr(13) + Chr(10) + Chr(13) + Mensaje, vbCritical
               If FlagTx = True Then
                  If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
                     MsgBox "No se pudo realizar devolución de transacción inicializada", vbCritical, gsBac_Version
                  End If
               End If
               Exit Function
            End If
            
            '********** Fin Linea
            Correlativo = Correlativo + 1
            NOM = CDbl(grilla.TextMatrix(i, 3))
            MT = CDbl(grilla.TextMatrix(i, 6))
            TR = CDbl(grilla.TextMatrix(i, 4))
            PVP = CDbl(grilla.TextMatrix(i, 5))
            VP = 0
            INDEV = CDbl(grilla.TextMatrix(i, 7))           'CDbl(grilla.TextMatrix(I, 21)) ACACACACACACACACACa
            PRINC = CDbl(grilla.TextMatrix(i, 23))
            Numdocu = CDbl(grilla.TextMatrix(i, 25))
                
            envia = Array()
            AddParam envia, gsBac_Fecp
            AddParam envia, gsBac_RutC
            AddParam envia, Numdocu
            AddParam envia, CDbl(grilla.TextMatrix(i, 12))  'Codigo Familia
            If (grilla.TextMatrix(grilla.row, 12)) = 2000 Then
               AddParam envia, grilla.TextMatrix(i, 1)      'Nombre Serie
            Else
               AddParam envia, grilla.TextMatrix(i, 18)     'Nombre Familia
            End If
            AddParam envia, grilla.TextMatrix(i, 1)
            AddParam envia, CDbl(rut_cli)
            AddParam envia, Cod_cli
            AddParam envia, CDate(txt_fec_pag.Text)
            AddParam envia, NOM
            AddParam envia, MT
            AddParam envia, TR
            AddParam envia, PVP
            AddParam envia, VP
            AddParam envia, INDEV
            AddParam envia, PRINC
            AddParam envia, gsBac_User
            AddParam envia, ""
            AddParam envia, obseravcion
            AddParam envia, corr_bco_bco
            AddParam envia, corr_bco_Cta
            AddParam envia, corr_bco_ABA
            AddParam envia, corr_bco_pais
            AddParam envia, 0
            AddParam envia, corr_bco_swi
            AddParam envia, corr_bco_ref
            AddParam envia, corr_cli_bco
            AddParam envia, corr_cli_Cta
            AddParam envia, corr_cli_ABA
            AddParam envia, corr_cli_pais
            AddParam envia, 0
            AddParam envia, corr_cli_swi
            AddParam envia, corr_cli_ref
            AddParam envia, Oper_Con
            AddParam envia, Oper_bech
            AddParam envia, grilla.TextMatrix(i, 14)       'box_mon_pag.ItemData(box_mon_pag.ListIndex)
            AddParam envia, Confirmacion
            AddParam envia, gsFormaPago
            AddParam envia, Cod_emi
            AddParam envia, txt_fec_neg.Text
            AddParam envia, CDbl(grilla.TextMatrix(i, 26))       ' Monto a Pagar en Pesos --- para contabilidad
            AddParam envia, Correlativo
            AddParam envia, Numoper
            AddParam envia, CDbl(0) '-- Duración Macaulay
            AddParam envia, CDbl(0) '-- Duración Modificada
            AddParam envia, CDbl(0) '-- Convexidad
            If Bac_Sql_Execute("SVA_VNT_GRB_OPE", envia) Then
               Do While Bac_SQL_Fetch(Datos)
                  If Datos(1) <> "OK" Then
                     If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
                        MsgBox "No se pudo realizar devolución de transacción inicializada", vbCritical, gsBac_Version
                     End If
                  End If
               Loop
              
              '****************************************************************************
              'Actualiza las Coberturas
                  envia = Array()
                  AddParam envia, "BEX"
                  AddParam envia, CDbl(Numdocu)
                  AddParam envia, CDbl(Correlativo)
                  Call Bac_Sql_Execute("BacTraderSuda..SP_ACTUALIZACION_POSTVENTA", envia)
              'Actualiza las Coberturas
              '****************************************************************************
            Else
               Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "Problemas al grabar Operación de Venta #" & Numoper)
               MsgBox "Problemas al grabar operación", vbCritical, "Bonos Exterior"
               Exit Function
            End If
            If gsBac_Lineas = "S" Then
               If Not Lineas_GrbOperacion("BEX", "VP", Numoper, Numoper, " ", " ", " ") Then
                  GoTo VT_GrabarTxError
               End If
            End If
            
            'Aplicar Control de Precios y Tasas para grabar
            ptCodInst = grilla.TextMatrix(i, 12)        'antes apuntaba a la posición 13.  PRD-10494
            ptPlazo = DateDiff("D", gsBac_Fecp, CDate(grilla.TextMatrix(i, 2)))
            ptTasa = CDbl(grilla.TextMatrix(i, 4))
            resControlPT = ControlPreciosTasas("VPX", ptCodInst, ptPlazo, ptTasa, False)
            
            If Ctrlpt_AplicarControl Then
            If Ctrlpt_ModoOperacion = "S" Then
                'Modo silencioso
                Ctrlpt_codProducto = "VPX"
                Ctrlpt_NumOp = Numoper
                Ctrlpt_NumDocu = ""
                Ctrlpt_TipoOp = "V"
                Ctrlpt_Correlativo = Correlativo
                Mensaje_CPT = ""
                Call GrabaModoSilencioso
            Else
                'grabar el instrumento ssi EnviarCF = "S"
                If EnviarCF = "S" Then
                Ctrlpt_codProducto = "VPX"
                Ctrlpt_NumOp = Numoper
                Ctrlpt_NumDocu = ""
                Ctrlpt_TipoOp = "V"
                Ctrlpt_Correlativo = Correlativo
                    Mensaje_CPT = Ctrlpt_Mensaje
                Call GrabaLineaPendPrecios
                        Call GrabaModoSilencioso    'PRD-10494 Incidencia 1
            End If
            End If
            End If
            Mensaje_Lin = ""
            Mensaje_Lim = ""
            Mens_Lin_Graba = ""
            Mens_Lim_Graba = ""
            If gsBac_Lineas = "S" Then
               Mensaje_Lin = Lineas_Error("BEX", CDbl(Numoper))
               Mensaje_Lim = Limites_Error("BEX", CDbl(Numoper))
               Mens_Lin_Graba = Mensaje_Lin
               Mens_Lim_Graba = Mensaje_Lim
               Mens_Lin_Graba = Replace(Mens_Lin_Graba, vbCrLf, "")
               Mens_Lin_Graba = Replace(Mens_Lin_Graba, Chr(10), "")
               Mens_Lin_Graba = Replace(Mens_Lin_Graba, "Problemas Lineas: ", "")
               Mens_Lim_Graba = Replace(Mens_Lim_Graba, vbCrLf, "")
               Mens_Lim_Graba = Replace(Mens_Lim_Graba, Chr(10), "")
               Mens_Lim_Graba = Replace(Mens_Lim_Graba, "Problemas Limites ", "")
               If Mens_Lim_Graba <> "" Or Mens_Lin_Graba <> "" Then
                  MsgBox (Mens_Lin_Graba + Mens_Lim_Graba), vbCritical + vbOKOnly, "Inversion Exterior"
               End If
            End If
            okGrabar = True
         End If
      Next i
         
      If okGrabar = True Then
         envia = Array()
         AddParam envia, Numoper
         If Bac_Sql_Execute("SP_ACTNUMEROOPERACION", envia) Then
            If Bac_SQL_Fetch(Datos) Then
               If Datos(1) <> "OK" Then
                  MsgBox Datos(2)
                  If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
                     MsgBox "No se pudo realizar devolución de transacción inicializada", vbCritical, gsBac_Version
                  End If
                  Exit Function
               End If
            End If
         End If
      End If
        
      If Not Bac_Sql_Execute("COMMIT TRANSACTION") Then
         GoTo VT_GrabarTxError
      Else
         If Trim(Mensaje_Lin) <> "" Then
            Mensaje_CPT = ""
         ElseIf Trim(Mensaje_CPT) <> "" Then
            Mensaje_CPT = vbCrLf & vbCrLf & Mensaje_CPT
         End If
      
         MsgBox "La Venta ha sido grabada con el número " & Trim(CStr(Numoper)) & Mensaje_CPT, vbInformation + vbOKOnly, "Inversion Exterior"
      End If
      
      'JBH, 22-12-2009
      gsBac_User = auxUser
      gsUsuario = auxUser
      If Not ActualizaDigitador(Numoper) Then
            MsgBox "No se pudo actualizar el Digitador en el movto. N° " & Numoper, vbCritical
      End If
      'fin JBH, 22-12-2009

      
      Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "Operación de Venta #" & Numoper & ", se grabó con éxito.")
      grilla.Rows = 1
      VT_GrabarTx = Numoper
      Call Func_Limpiar
   'End If
Exit Function
VT_GrabarTxError:
   MsgBox "Se ha producido un problema en la grabación de la operación de venta: " & err.Description & ". Comunique al Administrador. ", vbCritical, gsBac_Version
   If FlagTx = True Then
      If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
         MsgBox "No se pudo realizar devolución de transacción inicializada", vbCritical, gsBac_Version
      End If
   End If
   VT_GrabarTx = 0
End Function

Private Sub txt_fec_pag_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
        Call valoriza_fecha
        grilla.SetFocus
    End If

End Sub
Private Sub txt_fec_pag_LostFocus()

 If CDate(txt_fec_pag.Text) < CDate(txt_fec_pag.MinDate) Then
      MsgBox "Fecha no puede ser menor a fecha sugerida", vbInformation, "Mensaje"
      txt_fec_pag.Text = txt_fec_pag.MinDate
      Exit Sub
   End If

End Sub

