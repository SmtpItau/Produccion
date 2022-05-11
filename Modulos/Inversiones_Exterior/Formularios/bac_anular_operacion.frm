VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form Bac_Anulacion 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Anulación"
   ClientHeight    =   6660
   ClientLeft      =   990
   ClientTop       =   1800
   ClientWidth     =   6555
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   6660
   ScaleWidth      =   6555
   Begin VB.Frame frmSelTipoOpe 
      Caption         =   "Tipos de Operación"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00C00000&
      Height          =   615
      Left            =   0
      TabIndex        =   40
      Top             =   720
      Width           =   6495
      Begin VB.OptionButton OptOpeIntramesas 
         Caption         =   "Intramesas"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   255
         Left            =   3600
         TabIndex        =   42
         Top             =   240
         Width           =   1455
      End
      Begin VB.OptionButton optOpeNormales 
         Caption         =   "Normales"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   255
         Left            =   1200
         TabIndex        =   41
         Top             =   240
         Width           =   1335
      End
   End
   Begin VB.Frame Frm_datosVenta 
      Caption         =   "Datos Generales Venta"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00C00000&
      Height          =   4290
      Left            =   30
      TabIndex        =   24
      Top             =   2160
      Width           =   6465
      Begin MSFlexGridLib.MSFlexGrid grid 
         Height          =   2835
         Left            =   120
         TabIndex        =   39
         Top             =   1380
         Width           =   6255
         _ExtentX        =   11033
         _ExtentY        =   5001
         _Version        =   393216
         Cols            =   4
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
      Begin VB.Label Label28 
         AutoSize        =   -1  'True
         Caption         =   "Nemotécnico"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   195
         Left            =   165
         TabIndex        =   38
         Top             =   4065
         Width           =   1125
      End
      Begin VB.Label Label26 
         AutoSize        =   -1  'True
         Caption         =   "Nominal"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   195
         Left            =   180
         TabIndex        =   37
         Top             =   2130
         Width           =   690
      End
      Begin VB.Label Label25 
         AutoSize        =   -1  'True
         Caption         =   "Tir"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   195
         Left            =   180
         TabIndex        =   36
         Top             =   2640
         Width           =   240
      End
      Begin VB.Label Label24 
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
         Height          =   285
         Left            =   2310
         TabIndex        =   35
         Top             =   4080
         Width           =   3900
      End
      Begin VB.Label Label23 
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
         Height          =   285
         Left            =   2250
         TabIndex        =   34
         Top             =   2580
         Width           =   1620
      End
      Begin VB.Label Label22 
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
         Height          =   285
         Left            =   2250
         TabIndex        =   33
         Top             =   2100
         Width           =   1620
      End
      Begin VB.Label Label20 
         AutoSize        =   -1  'True
         Caption         =   "Cliente"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   195
         Left            =   120
         TabIndex        =   32
         Top             =   405
         Width           =   600
      End
      Begin VB.Label lblcliente 
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
         Height          =   285
         Left            =   2280
         TabIndex        =   31
         Top             =   390
         Width           =   3900
      End
      Begin VB.Label lblfecha 
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
         Height          =   285
         Left            =   2250
         TabIndex        =   30
         Top             =   810
         Width           =   1620
      End
      Begin VB.Label Label17 
         AutoSize        =   -1  'True
         Caption         =   "Settlement"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   195
         Left            =   150
         TabIndex        =   29
         Top             =   900
         Width           =   915
      End
      Begin VB.Label Label16 
         AutoSize        =   -1  'True
         Caption         =   "Descripción"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   195
         Left            =   150
         TabIndex        =   28
         Top             =   3330
         Width           =   1020
      End
      Begin VB.Label Label15 
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
         Height          =   285
         Left            =   2280
         TabIndex        =   27
         Top             =   3405
         Width           =   3900
      End
      Begin VB.Label Label12 
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
         Height          =   285
         Left            =   2250
         TabIndex        =   26
         Top             =   2895
         Width           =   3900
      End
      Begin VB.Label Label7 
         AutoSize        =   -1  'True
         Caption         =   "Moneda Operación"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   195
         Left            =   210
         TabIndex        =   25
         Top             =   2970
         Width           =   1620
      End
   End
   Begin VB.Frame frm_datos 
      Caption         =   "Datos Generales Compra"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00C00000&
      Height          =   4290
      Left            =   30
      TabIndex        =   6
      Top             =   2160
      Width           =   6465
      Begin VB.Label Label10 
         Caption         =   "Moneda Operación"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   345
         Left            =   105
         TabIndex        =   21
         Top             =   3495
         Width           =   1725
      End
      Begin VB.Label lbl_moneda 
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
         Height          =   285
         Left            =   2250
         TabIndex        =   20
         Top             =   3465
         Width           =   3900
      End
      Begin VB.Label Label8 
         Caption         =   "Fecha De Emision"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   345
         Left            =   135
         TabIndex        =   19
         Top             =   1230
         Width           =   1965
      End
      Begin VB.Label lbl_fec_emi 
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
         Height          =   285
         Left            =   2280
         TabIndex        =   18
         Top             =   1185
         Width           =   1620
      End
      Begin VB.Label lbl_descrip 
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
         Height          =   285
         Left            =   2280
         TabIndex        =   17
         Top             =   345
         Width           =   3900
      End
      Begin VB.Label Label5 
         Caption         =   "Descripción"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   345
         Left            =   135
         TabIndex        =   16
         Top             =   375
         Width           =   1380
      End
      Begin VB.Label Label6 
         Caption         =   "Fecha de Proceso"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   345
         Left            =   120
         TabIndex        =   15
         Top             =   3060
         Width           =   1575
      End
      Begin VB.Label lbl_fec_pro 
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
         Height          =   285
         Left            =   2265
         TabIndex        =   14
         Top             =   3045
         Width           =   1620
      End
      Begin VB.Label lbl_cliente 
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
         Height          =   285
         Left            =   2280
         TabIndex        =   13
         Top             =   2700
         Width           =   3900
      End
      Begin VB.Label Label9 
         Caption         =   "Cliente"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   285
         Left            =   120
         TabIndex        =   12
         Top             =   2715
         Width           =   1095
      End
      Begin VB.Label lbl_fec_vcto 
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
         Height          =   285
         Left            =   2280
         TabIndex        =   3
         Top             =   1545
         Width           =   1620
      End
      Begin VB.Label lbl_nominal 
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
         Height          =   285
         Left            =   2280
         TabIndex        =   4
         Top             =   1935
         Width           =   1620
      End
      Begin VB.Label lbl_tir 
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
         Height          =   285
         Left            =   2280
         TabIndex        =   11
         Top             =   2295
         Width           =   1620
      End
      Begin VB.Label lbl_nemo 
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
         Height          =   285
         Left            =   2280
         TabIndex        =   2
         Top             =   780
         Width           =   3900
      End
      Begin VB.Label Label4 
         Caption         =   "Tir"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   345
         Left            =   135
         TabIndex        =   10
         Top             =   2325
         Width           =   1515
      End
      Begin VB.Label Label3 
         Caption         =   "Nominal"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   345
         Left            =   135
         TabIndex        =   9
         Top             =   1935
         Width           =   1485
      End
      Begin VB.Label Label2 
         Caption         =   "Fecha De Vencimiento"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   345
         Left            =   135
         TabIndex        =   8
         Top             =   1590
         Width           =   1965
      End
      Begin VB.Label Label1 
         Caption         =   "Nemotécnico"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   345
         Left            =   135
         TabIndex        =   7
         Top             =   765
         Width           =   1380
      End
   End
   Begin VB.Frame frm_fecha 
      Caption         =   "Número de Documento"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00C00000&
      Height          =   810
      Left            =   30
      TabIndex        =   5
      Top             =   1320
      Width           =   6480
      Begin BACControles.TXTNumero txt_num_docu 
         Height          =   300
         Left            =   135
         TabIndex        =   1
         Top             =   315
         Width           =   2205
         _ExtentX        =   3889
         _ExtentY        =   529
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0"
         Text            =   "0"
         Min             =   "0"
         Max             =   "9999999999"
      End
      Begin VB.Label Label11 
         Alignment       =   1  'Right Justify
         Caption         =   "Tipo Operación"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   270
         Left            =   3015
         TabIndex        =   23
         Top             =   360
         Width           =   1515
      End
      Begin VB.Label Lbl_operacion 
         Alignment       =   2  'Center
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
         Height          =   285
         Left            =   4605
         TabIndex        =   22
         Top             =   330
         Width           =   1620
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   660
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   6555
      _ExtentX        =   11562
      _ExtentY        =   1164
      ButtonWidth     =   1032
      ButtonHeight    =   1005
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.ToolTipText     =   "Anular"
            ImageIndex      =   8
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   11
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   12
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   0
      Top             =   5880
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   32
      ImageHeight     =   32
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   18
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_anular_operacion.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_anular_operacion.frx":031A
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_anular_operacion.frx":076C
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_anular_operacion.frx":0BBE
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_anular_operacion.frx":0ED8
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_anular_operacion.frx":11F2
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_anular_operacion.frx":1644
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_anular_operacion.frx":179E
            Key             =   ""
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_anular_operacion.frx":1BF0
            Key             =   ""
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_anular_operacion.frx":2042
            Key             =   ""
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_anular_operacion.frx":235C
            Key             =   ""
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_anular_operacion.frx":2676
            Key             =   ""
         EndProperty
         BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_anular_operacion.frx":27D0
            Key             =   ""
         EndProperty
         BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_anular_operacion.frx":2C22
            Key             =   ""
         EndProperty
         BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_anular_operacion.frx":3074
            Key             =   ""
         EndProperty
         BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_anular_operacion.frx":338E
            Key             =   ""
         EndProperty
         BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_anular_operacion.frx":36A8
            Key             =   ""
         EndProperty
         BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_anular_operacion.frx":39C2
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "Bac_Anulacion"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim Opcion As String
Function Lineas_Anular(cSist As String, nNumoper As Double)

    Dim Datos()
                    
    envia = Array()
    AddParam envia, gsBac_Fecp
    AddParam envia, "BEX"
    AddParam envia, nNumoper
                            
    Lineas_Anular = True
    If Not Bac_Sql_Execute(gsBac_LineasDB & "..SP_LINEAS_ANULA", envia) Then
        Lineas_Anular = False
    End If
    
End Function

Function Anular_Registro()
    Dim nomSp As String
    Dim TipoOpex As String
   Dim Datos()

    If MsgBox("¿Está Seguro de Anular la Operación?", vbQuestion + vbYesNo, gsBac_Version) <> vbYes Then
      Exit Function
   End If
    Select Case opcion_filtrado
        Case "N"
            nomSp = "SVA_ANU_CMP_PPA"
        Case "I"
            'nomSp = "Sva_Anu_cmp_ppa_IM"
            nomSp = "SP_ANULAPAROPER_TICKETINTRAMESA"   'JBH, 01-12-2009
        Case Else
            MsgBox "No ha seleccionado el Tipo de Operación!", vbExclamation, gsBac_Version
            Exit Function
    End Select
   If Lbl_operacion.Tag = "CP" Or Lbl_operacion.Tag = "VCP" Then
      envia = Array()
        
        If Num_Relac <> 0 Then  'JBH, 17-12-2009
            AddParam envia, Num_Relac
        Else    'JBH, 17-12-2009
      AddParam envia, CDbl(Me.txt_num_docu.Text)
        End If  'JBH, 17-12-2009
        
        
        If Bac_Sql_Execute(nomSp, envia) Then   'JBH, 02-11-2009
         If Bac_SQL_Fetch(Datos) Then
            If opcion_filtrado = "I" Then
                    Select Case Datos(1)
                        Case -1
                            MsgBox "El movimiento ya estaba anulado!", vbExclamation, gsBac_Version
                        Case -2
                            MsgBox "La operación espejo no se puede anular", vbCritical, gsBac_Version
                        Case -3
                            MsgBox "La operación tiene ventas asociadas, no se puede anular", vbInformation, gsBac_Version
                        Case 0
                            MsgBox "La operación ha sido anulada exitosamente", vbInformation, gsBac_Version
                    End Select
            Else
                 ' reviso si el Flag de encendido del proceso
                If blnProcesoArt84Activo("BEX") Then
                    If Not blnAnulaControlMargenes(CDbl(Me.txt_num_docu.Text), "BTR") Then
                      MsgBox "Problemas al Anular control de márgenes (Art84), para la siguiente operación :" + IntNumoper.Text, vbCritical, gsBac_Version
                    End If
                End If
                
               If Datos(1) = "1" Then
                  Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "Problemas al Anular Operación #" & txt_num_docu.Text)
                  MsgBox Datos(2), vbExclamation, gsBac_Version
               Else
                  Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "Operación #" & txt_num_docu.Text & " Anulada Correctamente")
                  MsgBox "Operación Anulada Exitosamente", vbInformation, gsBac_Version
                  If opcion_filtrado = "I" Then
                     TipoOpex = Lbl_operacion.Tag & "I"
                  Else
                     TipoOpex = Lbl_operacion.Tag
                  End If
                  'Call Imprimir_Papeletas(Lbl_operacion.Tag, CDbl(Me.txt_num_docu.Text), gsBac_Papeleta, "") 'JBH, 03-11-2009
                  Call Imprimir_Papeletas(TipoOpex, CDbl(Me.txt_num_docu.Text), gsBac_Papeleta, "")
                    
                    'Aplicar anulacion para el Control de Precios y Tasas, operaciones Normales
                    If opcion_filtrado <> "I" Then
                        envia = Array()
                        AddParam envia, "BEX"
                        AddParam envia, "CPX"
                        AddParam envia, CDbl(Me.txt_num_docu.Text)
                        If Bac_Sql_Execute("Bacparamsuda..sp_Borra_OpPendientePrecios", envia) Then
                    
                        End If
                    End If
            End If
                
            End If
         End If
      
      End If
   Else 'VENTAS
      envia = Array()
        Select Case opcion_filtrado
        Case "N"
            nomSp = "SVA_ANU_VNT_PPA"
        Case "I"
            'nomSp = "Sva_Anu_vnt_ppa_IM"
            nomSp = "SP_ANULAPAROPER_TICKETINTRAMESA"   'JBH, 01-12-2009
        Case Else
            MsgBox "No ha seleccionado el Tipo de Operación!", vbExclamation, gsBac_Version
            Exit Function
        End Select
        
        If Num_Relac <> 0 Then  'JBH, 17-12-2009
            AddParam envia, Num_Relac
        Else    'JBH, 17-12-2009
      AddParam envia, CDbl(Me.txt_num_docu.Text)
        End If  'JBH, 17-12-2009
        
        If Bac_Sql_Execute(nomSp, envia) Then   'JBH, 02-11-2009
         Do While Bac_SQL_Fetch(Datos)
            Select Case opcion_filtrado
                Case "I"
                    Select Case Datos(1)
                        Case -1
                            MsgBox "El movimiento ya estaba anulado!", vbExclamation, gsBac_Version
                        Case -2
                            MsgBox "La operación espejo no se puede anular", vbCritical, gsBac_Version
                        Case -3
                            MsgBox "La operación tiene ventas asociadas, no se puede anular", vbInformation, gsBac_Version
                        Case 0
                            MsgBox "La operación ha sido anulada exitosamente", vbInformation, gsBac_Version
                    End Select
                Case "N"
            If Datos(1) = "1" Then
               If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
                  MsgBox "No se pudo realizar devolución de transacción inicializada", vbCritical, gsBac_Version
               End If
               Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "Problemas al Anular Operación #" & txt_num_docu.Text)
               MsgBox Datos(2), vbExclamation, gsBac_Version
            Else
               Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "Operación #" & txt_num_docu.Text & " Anulada Correctamente")
                        
                        'Aplicar anulacion para el Control de Precios y Tasas, operaciones Normales
                        envia = Array()
                        AddParam envia, "BEX"
                        AddParam envia, "VPX"
                        AddParam envia, CDbl(Me.txt_num_docu.Text)
                        If Bac_Sql_Execute("Bacparamsuda..sp_Borra_OpPendientePrecios", envia) Then
                            Do While Bac_SQL_Fetch(Datos)
                            Loop
                        End If
                            
            End If
            End Select
         Loop
      End If
   End If
   '********** Linea -- Mkilo
   If gsBac_Lineas = "S" Then
      If Not Lineas_Anular("BEX", CDbl(Me.txt_num_docu.Text)) Then
            MsgBox "Problemas al realizar anulación interna de línea"
      Else
        '+++CONTROL IDD, jcamposd llamada a nuevo control IDD para las líneas
          Dim oParametrosLinea As New clsControlLineaIDD
          Dim product As String
          
          If Lbl_operacion.Tag = "CP" Then
              product = "CPX"
          Else
              product = "VPX"
          End If
          
            With oParametrosLinea
                .Modulo = "BEX"
                .Producto = product
                .Operacion = CDbl(Me.txt_num_docu.Text)
                .Documento = CDbl(Me.txt_num_docu.Text)
                .Correlativo = 1
                .Accion = "R"
          
                .RecuperaDatosLineaIDD
                If .numeroiddAnula <> 0 Then
                    .EjecutaProcesoWsLineaIDD
                End If
            End With
            Set oParametrosLinea = Nothing
            On Error GoTo seguirAnulacion ' debe seguir con el proceso
          '---CONTROL IDD, jcamposd llamada a nuevo control IDD para las líneas
      End If
   End If
   
seguirAnulacion:
   
   '********* Fin
   If opcion_filtrado <> "I" Then
        'SOLO PARA MOVIMIENTOS NO INTRAMESAS, JBH, 02-11-2009
   'Actualiza Coberturas Asociadas
    envia = Array()
    AddParam envia, "BEX"
    AddParam envia, CDbl(txt_num_docu.Text)
    AddParam envia, CDbl(1#)
    Call Bac_Sql_Execute("BacTraderSuda..SP_ACTUALIZACION_POSTVENTA", envia)
   'Actualiza Coberturas Asociadas
   End If

   Call Clear_Objetos
End Function

Sub Crear_grilla()

    grid.Cols = 4
    grid.Rows = 1
    grid.TextMatrix(0, 0) = "Corr"
    grid.TextMatrix(0, 1) = "Instrumento"
    grid.TextMatrix(0, 2) = "Nocional"
    'grid.TextMatrix(0, 3) = "Pagar"
    grid.TextMatrix(0, 3) = "Moneda"
    
    grid.ColWidth(0) = 500
    grid.ColWidth(1) = 2500
    grid.ColWidth(2) = 1500
    grid.ColWidth(3) = 1200
    'grid.ColWidth(3) = 1200
    
End Sub
Function buscar_registro(ByVal modo As String)

On Error GoTo Error_buscar      'JBH, 04-12-2009

    If CDbl(txt_num_docu.Text) = 0 Then
        Exit Function
    End If
    Dim nomSp As String 'JBH, 02-11-2009
    Call Crear_grilla
    
    Dim Datos()
    envia = Array()
    AddParam envia, CDbl(txt_num_docu.Text)
 
    Select Case modo
        Case "N"
            nomSp = "SVC_ANU_DAT_INS"
        Case "I"
            nomSp = "SVC_ANU_DAT_INS_IM"
    End Select
    'If Bac_Sql_Execute("Svc_Anu_dat_ins", envia) Then
    If Bac_Sql_Execute(nomSp, envia) Then
    
        Do While Bac_SQL_Fetch(Datos)
            If Datos(2) = "0" Then
                MsgBox Datos(1), vbExclamation, gsBac_Version
                Call Clear_Objetos
                Exit Function
            End If
            If Datos(1) = "0" Then
                MsgBox "Operacion No Se Puede Anular o No Existe", vbInformation, gsBac_Version
                Call Clear_Objetos
                Exit Function
            ElseIf Datos(6) = "A" Then
                MsgBox "Operación Anulada Anteriormente", vbInformation, gsBac_Version
                Call Clear_Objetos
                Exit Function
            Else
                If Datos(12) = "CP" Then
                    lbl_nemo.Caption = Datos(1)
                    lbl_fec_vcto.Caption = Format(Datos(2), "DD/MM/YYYY")
                    lbl_nominal.Caption = Format(CDbl(Datos(3)), "##,###,###,###,##0.00")
                    lbl_tir.Caption = Format(CDbl(Datos(4)), "#0.0000")
                    lbl_cliente.Caption = Datos(5)
                    lbl_fec_pro.Caption = Format(Datos(7), "DD/MM/YYYY")
                    lbl_descrip.Caption = UCase(Datos(8))
                    lbl_fec_emi.Caption = Format(Datos(9), "DD/MM/YYYY")
                    lbl_moneda.Caption = Datos(10)
                    Lbl_operacion.Caption = Datos(11)
                    Lbl_operacion.Tag = Datos(12)
                    frm_datos.Visible = True
                    Frm_datosVenta.Visible = False
                    If lbl_nemo.Caption = "" Then
                        MsgBox "Número de Operación Erróneo", vbExclamation, gsBac_Version
                        Call Clear_Objetos
                            Exit Function
                    End If
                Else
                    ' Si es venta
                    grid.Rows = grid.Rows + 1
                    grid.TextMatrix(grid.Rows - 1, 0) = Datos(14)
                    grid.TextMatrix(grid.Rows - 1, 1) = Datos(1)
                    grid.TextMatrix(grid.Rows - 1, 2) = Format(CDbl(Datos(3)), "##,###,###,###,##0.00")
                    'grid.TextMatrix(grid.Rows - 1, 3) = 1
                    grid.TextMatrix(grid.Rows - 1, 3) = Datos(10)
                    lblcliente.Caption = Datos(5)
                    lblfecha.Caption = Format(Datos(2), "DD/MM/YYYY")
                    Lbl_operacion.Caption = Datos(11)
                    Lbl_operacion.Tag = Datos(12)
                End If
            End If
            

        Loop
          
        Toolbar1.Buttons(1).Enabled = True
        Toolbar1.Buttons(2).Enabled = False
        txt_num_docu.Enabled = False
        If UCase(Lbl_operacion.Caption) = "VENTA" Then
            Frm_datosVenta.Visible = True
            frm_datos.Visible = False
        End If
        
    End If
    Exit Function   'JBH, 04-12-2009
Error_buscar:
MsgBox "Se ha producido el siguiente error:" & err.Description, vbCritical, gsBac_Version

    
End Function

Function Clear_Objetos()
    txt_num_docu.Text = " "
    lbl_nemo.Caption = " "
    lbl_fec_vcto.Caption = " "
    lbl_nominal.Caption = " "
    lbl_tir.Caption = " "
    lbl_cliente.Caption = " "
    lbl_fec_pro.Caption = " "
    lbl_descrip.Caption = " "
    lbl_fec_emi.Caption = " "
    lbl_moneda.Caption = " "
    Lbl_operacion.Caption = " "
    Toolbar1.Buttons(1).Enabled = False
    Toolbar1.Buttons(2).Enabled = True
    txt_num_docu.Enabled = True
    txt_num_docu.SetFocus
    frm_datos.Visible = True
    Frm_datosVenta.Visible = False
    'JBH, 02-11-2009
    optOpeNormales.Enabled = True
    OptOpeIntramesas.Enabled = True
    optOpeNormales.Value = False
    OptOpeIntramesas.Value = False
    
End Function


Private Sub Form_Load()
    
    Me.Top = 0  'JBH, 04-12-2009
    Me.Left = 0 'JBH, 04-12-2009
    
    Me.Icon = BAC_INVERSIONES.Icon
    Me.Caption = "Anulación de Operaciones"
    Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "Ingreso a Pantalla de anulación de Operaciones")
    frm_datos.Visible = True
    Frm_datosVenta.Visible = False
    
    
End Sub

Private Sub Form_Unload(Cancel As Integer)

    'Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "Salida de Pantalla de anulación de Operaciones")   'JBH, 11-12-2009

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
    Dim tipoOpSel As String
    tipoOpSel = ""
    If optOpeNormales.Value = True Then
        tipoOpSel = "N"
        opcion_filtrado = "N"
    ElseIf OptOpeIntramesas.Value = True Then
        tipoOpSel = "I"
        opcion_filtrado = "I"
    End If
    Select Case Button.Index
        Case 1
'           Bac_Anulacion_Password.Show vbModal
'           If giAceptar% = True Then
                Call Anular_Registro
'           Else
'               Call Clear_Objetos
'           End If
        Case 2
            Call buscar_registro(tipoOpSel) 'JBH, 02-11-2009
            'Call buscar_registro
        Case 3
            Call Clear_Objetos
        Case 4
            Unload Me
    End Select
End Sub

Private Sub txt_num_docu_DblClick()
    'JBH, 02-11-2009, 1° determinar el tipo de operaciones seleccionado
    Dim tipoOpSel As String
    tipoOpSel = ""
    If optOpeNormales.Value = True Then
        tipoOpSel = "N"
    ElseIf OptOpeIntramesas.Value = True Then
        tipoOpSel = "I"
    End If
    If Trim(tipoOpSel) = "" Then
        MsgBox "No ha seleccionado el Tipo de Operación!", vbExclamation, gsBac_Version
        Exit Sub
    End If
    opcion_filtrado = tipoOpSel
    'fin JBH, 02-11-2009

    Bac_Ayuda_Anular.Show vbModal
    If giAceptar% = True Then
        Me.txt_num_docu.Text = Num_Docu
        'Call buscar_registro
        Call buscar_registro(tipoOpSel) 'JBH, 02-11-2009
    End If


End Sub

Private Sub txt_num_docu_KeyPress(KeyAscii As Integer)
    'JBH, 02-11-2009, 1° determinar el tipo de operaciones seleccionado
    Dim tipoOpSel As String
    tipoOpSel = ""
    If optOpeNormales.Value = True Then
        tipoOpSel = "N"
    ElseIf OptOpeIntramesas.Value = True Then
        tipoOpSel = "I"
    End If
    If Trim(tipoOpSel) = "" Then
        MsgBox "No ha seleccionado el Tipo de Operación!", vbExclamation, gsBac_Version
        Exit Sub
    End If
    'fin JBH, 02-11-2009
    If KeyAscii = 13 Then
        Call buscar_registro(tipoOpSel)
    End If
End Sub




