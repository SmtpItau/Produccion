VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{989C9190-EDF5-45A8-AB6C-98E6EF0384D7}#1.0#0"; "Bac_Controles_Pas.ocx"
Begin VB.Form FRM_RPT_CARTERA 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Informes de Cartera"
   ClientHeight    =   5160
   ClientLeft      =   2640
   ClientTop       =   1800
   ClientWidth     =   4335
   ForeColor       =   &H8000000F&
   Icon            =   "FRM_RPT_CARTERA.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5160
   ScaleWidth      =   4335
   Begin VB.Frame Frame1 
      Caption         =   "Listados  de Cartera"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000007&
      Height          =   3615
      Left            =   0
      TabIndex        =   8
      Top             =   1530
      Width           =   4335
      Begin VB.PictureBox SinCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   10
         Left            =   240
         Picture         =   "FRM_RPT_CARTERA.frx":2EFA
         ScaleHeight     =   330
         ScaleWidth      =   375
         TabIndex        =   37
         Top             =   3210
         Width           =   375
      End
      Begin VB.PictureBox ConCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   10
         Left            =   3495
         Picture         =   "FRM_RPT_CARTERA.frx":3262
         ScaleHeight     =   330
         ScaleWidth      =   330
         TabIndex        =   36
         Top             =   3210
         Visible         =   0   'False
         Width           =   330
      End
      Begin VB.PictureBox ConCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   4
         Left            =   3500
         Picture         =   "FRM_RPT_CARTERA.frx":35E8
         ScaleHeight     =   330
         ScaleWidth      =   330
         TabIndex        =   26
         Top             =   1440
         Visible         =   0   'False
         Width           =   330
      End
      Begin VB.PictureBox SinCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   4
         Left            =   240
         Picture         =   "FRM_RPT_CARTERA.frx":396E
         ScaleHeight     =   330
         ScaleWidth      =   375
         TabIndex        =   25
         Top             =   1440
         Width           =   375
      End
      Begin VB.PictureBox SinCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   0
         Left            =   240
         Picture         =   "FRM_RPT_CARTERA.frx":3CD6
         ScaleHeight     =   330
         ScaleWidth      =   375
         TabIndex        =   24
         Top             =   360
         Width           =   375
      End
      Begin VB.PictureBox ConCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   0
         Left            =   3500
         Picture         =   "FRM_RPT_CARTERA.frx":403E
         ScaleHeight     =   330
         ScaleWidth      =   330
         TabIndex        =   23
         Top             =   360
         Visible         =   0   'False
         Width           =   330
      End
      Begin VB.PictureBox SinCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   1
         Left            =   240
         Picture         =   "FRM_RPT_CARTERA.frx":43C4
         ScaleHeight     =   330
         ScaleWidth      =   375
         TabIndex        =   22
         Top             =   720
         Width           =   375
      End
      Begin VB.PictureBox SinCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   2
         Left            =   240
         Picture         =   "FRM_RPT_CARTERA.frx":472C
         ScaleHeight     =   330
         ScaleWidth      =   375
         TabIndex        =   21
         Top             =   1080
         Width           =   375
      End
      Begin VB.PictureBox ConCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   1
         Left            =   3500
         Picture         =   "FRM_RPT_CARTERA.frx":4A94
         ScaleHeight     =   330
         ScaleWidth      =   330
         TabIndex        =   20
         Top             =   720
         Visible         =   0   'False
         Width           =   330
      End
      Begin VB.PictureBox ConCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   2
         Left            =   3500
         Picture         =   "FRM_RPT_CARTERA.frx":4E1A
         ScaleHeight     =   330
         ScaleWidth      =   330
         TabIndex        =   19
         Top             =   1080
         Visible         =   0   'False
         Width           =   330
      End
      Begin VB.PictureBox ConCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   5
         Left            =   3495
         Picture         =   "FRM_RPT_CARTERA.frx":51A0
         ScaleHeight     =   330
         ScaleWidth      =   330
         TabIndex        =   18
         Top             =   3720
         Visible         =   0   'False
         Width           =   330
      End
      Begin VB.PictureBox SinCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   5
         Left            =   240
         Picture         =   "FRM_RPT_CARTERA.frx":5526
         ScaleHeight     =   330
         ScaleWidth      =   375
         TabIndex        =   17
         Top             =   3735
         Visible         =   0   'False
         Width           =   375
      End
      Begin VB.PictureBox ConCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   6
         Left            =   3495
         Picture         =   "FRM_RPT_CARTERA.frx":588E
         ScaleHeight     =   330
         ScaleWidth      =   330
         TabIndex        =   16
         Top             =   1800
         Visible         =   0   'False
         Width           =   330
      End
      Begin VB.PictureBox SinCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   6
         Left            =   240
         Picture         =   "FRM_RPT_CARTERA.frx":5C14
         ScaleHeight     =   330
         ScaleWidth      =   375
         TabIndex        =   15
         Top             =   1800
         Width           =   375
      End
      Begin VB.PictureBox SinCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   7
         Left            =   240
         Picture         =   "FRM_RPT_CARTERA.frx":5F7C
         ScaleHeight     =   330
         ScaleWidth      =   375
         TabIndex        =   14
         Top             =   2880
         Width           =   375
      End
      Begin VB.PictureBox ConCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   7
         Left            =   3495
         Picture         =   "FRM_RPT_CARTERA.frx":62E4
         ScaleHeight     =   330
         ScaleWidth      =   330
         TabIndex        =   13
         Top             =   2880
         Visible         =   0   'False
         Width           =   330
      End
      Begin VB.PictureBox ConCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   8
         Left            =   3495
         Picture         =   "FRM_RPT_CARTERA.frx":666A
         ScaleHeight     =   330
         ScaleWidth      =   330
         TabIndex        =   12
         Top             =   2520
         Visible         =   0   'False
         Width           =   330
      End
      Begin VB.PictureBox ConCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   9
         Left            =   3495
         Picture         =   "FRM_RPT_CARTERA.frx":69F0
         ScaleHeight     =   330
         ScaleWidth      =   330
         TabIndex        =   11
         Top             =   2160
         Visible         =   0   'False
         Width           =   330
      End
      Begin VB.PictureBox SinCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   8
         Left            =   240
         Picture         =   "FRM_RPT_CARTERA.frx":6D76
         ScaleHeight     =   330
         ScaleWidth      =   375
         TabIndex        =   10
         Top             =   2520
         Width           =   375
      End
      Begin VB.PictureBox SinCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   9
         Left            =   240
         Picture         =   "FRM_RPT_CARTERA.frx":70DE
         ScaleHeight     =   330
         ScaleWidth      =   375
         TabIndex        =   9
         Top             =   2160
         Width           =   375
      End
      Begin VB.Label Etiqueta 
         AutoSize        =   -1  'True
         Caption         =   "Bonos Emitidos"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   210
         Index           =   10
         Left            =   720
         TabIndex        =   38
         Top             =   3255
         Width           =   1290
      End
      Begin VB.Label Etiqueta 
         AutoSize        =   -1  'True
         Caption         =   "Creditos Bancos Extranjeros"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   210
         Index           =   4
         Left            =   720
         TabIndex        =   35
         Top             =   1485
         Width           =   2355
      End
      Begin VB.Label Etiqueta 
         AutoSize        =   -1  'True
         Caption         =   "Bonos Propia Emision"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   210
         Index           =   0
         Left            =   720
         TabIndex        =   34
         Top             =   405
         Width           =   1800
      End
      Begin VB.Label Etiqueta 
         AutoSize        =   -1  'True
         Caption         =   "Creditos Corfo"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   210
         Index           =   1
         Left            =   720
         TabIndex        =   33
         Top             =   765
         Width           =   1230
      End
      Begin VB.Label Etiqueta 
         AutoSize        =   -1  'True
         Caption         =   "Creditos Bancos Locales"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   210
         Index           =   2
         Left            =   720
         TabIndex        =   32
         Top             =   1125
         Width           =   2055
      End
      Begin VB.Label Etiqueta 
         AutoSize        =   -1  'True
         Caption         =   "Letras Hipotecarias"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   210
         Index           =   5
         Left            =   720
         TabIndex        =   31
         Top             =   3780
         Visible         =   0   'False
         Width           =   1860
      End
      Begin VB.Label Etiqueta 
         AutoSize        =   -1  'True
         Caption         =   "Bonos Propia Emision  T/E"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   210
         Index           =   6
         Left            =   720
         TabIndex        =   30
         Top             =   1845
         Width           =   2130
      End
      Begin VB.Label Etiqueta 
         AutoSize        =   -1  'True
         Caption         =   "Creditos Bancos Extranjeros T/E"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   210
         Index           =   7
         Left            =   720
         TabIndex        =   29
         Top             =   2925
         Width           =   2640
      End
      Begin VB.Label Etiqueta 
         AutoSize        =   -1  'True
         Caption         =   "Creditos Bancos Locales T/E"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   210
         Index           =   8
         Left            =   720
         TabIndex        =   28
         Top             =   2565
         Width           =   2340
      End
      Begin VB.Label Etiqueta 
         AutoSize        =   -1  'True
         Caption         =   "Creditos Corfo T/E"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   210
         Index           =   9
         Left            =   720
         TabIndex        =   27
         Top             =   2205
         Width           =   1515
      End
   End
   Begin VB.Frame Frame3 
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   1020
      Left            =   30
      TabIndex        =   4
      Top             =   495
      Width           =   4320
      Begin VB.PictureBox SinCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   3
         Left            =   240
         ScaleHeight     =   330
         ScaleWidth      =   375
         TabIndex        =   1
         Top             =   660
         Width           =   375
      End
      Begin VB.PictureBox ConCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   3
         Left            =   3500
         ScaleHeight     =   330
         ScaleWidth      =   330
         TabIndex        =   3
         Top             =   660
         Visible         =   0   'False
         Width           =   330
      End
      Begin VB.Frame Frame2 
         BorderStyle     =   0  'None
         Height          =   660
         Index           =   0
         Left            =   75
         TabIndex        =   5
         Top             =   1515
         Width           =   3825
      End
      Begin BACControles.TXTFecha TxtFecProc 
         Height          =   315
         Left            =   1560
         TabIndex        =   0
         Top             =   210
         Width           =   1215
         _ExtentX        =   2143
         _ExtentY        =   556
         Enabled         =   -1  'True
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   402133
         MinDate         =   18264
         Text            =   "18/06/2001"
      End
      Begin VB.Label Etiqueta 
         AutoSize        =   -1  'True
         Caption         =   "Resumen"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   210
         Index           =   3
         Left            =   720
         TabIndex        =   2
         Top             =   705
         Width           =   795
      End
      Begin VB.Label lblEtiqueta 
         AutoSize        =   -1  'True
         Caption         =   "Fecha Proceso"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   210
         Index           =   1
         Left            =   240
         TabIndex        =   6
         Top             =   225
         Width           =   1215
      End
   End
   Begin MSComctlLib.Toolbar Tlb_Movimiento 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   7
      Top             =   0
      Width           =   4335
      _ExtentX        =   7646
      _ExtentY        =   794
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Style           =   1
      ImageList       =   "Img_opciones"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Imprimir"
            ImageIndex      =   17
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Vista Previa"
            ImageIndex      =   18
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      Begin MSComctlLib.ImageList Img_opciones 
         Left            =   3480
         Top             =   0
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   24
         ImageHeight     =   24
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   25
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_CARTERA.frx":7446
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_CARTERA.frx":78AD
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_CARTERA.frx":7DA3
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_CARTERA.frx":8236
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_CARTERA.frx":871E
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_CARTERA.frx":8C31
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_CARTERA.frx":916E
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_CARTERA.frx":95B0
               Key             =   ""
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_CARTERA.frx":9A6A
               Key             =   ""
            EndProperty
            BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_CARTERA.frx":9F3D
               Key             =   ""
            EndProperty
            BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_CARTERA.frx":A381
               Key             =   ""
            EndProperty
            BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_CARTERA.frx":A8E8
               Key             =   ""
            EndProperty
            BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_CARTERA.frx":ADB7
               Key             =   ""
            EndProperty
            BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_CARTERA.frx":B1D6
               Key             =   ""
            EndProperty
            BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_CARTERA.frx":B6CE
               Key             =   ""
            EndProperty
            BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_CARTERA.frx":BAC7
               Key             =   ""
            EndProperty
            BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_CARTERA.frx":BF4A
               Key             =   ""
            EndProperty
            BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_CARTERA.frx":C410
               Key             =   ""
            EndProperty
            BeginProperty ListImage19 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_CARTERA.frx":C907
               Key             =   ""
            EndProperty
            BeginProperty ListImage20 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_CARTERA.frx":CDBD
               Key             =   ""
            EndProperty
            BeginProperty ListImage21 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_CARTERA.frx":D182
               Key             =   ""
            EndProperty
            BeginProperty ListImage22 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_CARTERA.frx":D578
               Key             =   ""
            EndProperty
            BeginProperty ListImage23 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_CARTERA.frx":D96F
               Key             =   ""
            EndProperty
            BeginProperty ListImage24 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_CARTERA.frx":DD78
               Key             =   ""
            EndProperty
            BeginProperty ListImage25 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_CARTERA.frx":E236
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
End
Attribute VB_Name = "FRM_RPT_CARTERA"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim Sql As String
Dim Datos()
Dim TCartera As String
Dim tipo As String
Dim cOptLocal As String
Const ForeSeleccion = &H8000000E
Const BackSeleccion = &H8000000D
Const ForeNormal = &H80000007
Const BackNormal = &H8000000F

Private Sub Generar_Listado(cTipo_Salida As String)
   
   Dim nContador        As Integer
   Dim cFecha_Desde     As String
   Dim cFecha_Hasta     As String
   Dim Titulo                             As String
   Dim bExisten_Marcados                  As Boolean

On Error GoTo Control:

   
            Screen.MousePointer = 11
            bExisten_Marcados = False
            
            If cTipo_Salida = "Impresora" Then
                FRM_MDI_PASIVO.Pasivo_Rpt.Destination = 1
                cTipo_Salida = "P"
            
            Else
                
                FRM_MDI_PASIVO.Pasivo_Rpt.Destination = 0
                cTipo_Salida = "V"
            
            End If
         
          
            For nContador = 0 To 10
            
               If ConCheck.Item(nContador).Visible = True Then
                  
                  bExisten_Marcados = True
               
               End If
            
            Next nContador
             
            If bExisten_Marcados = False Then
            
               MsgBox "Debe Seleccionar Tipo de Listado ", vbInformation
               Screen.MousePointer = vbDefault
               Exit Sub
            
            End If
             
             
            If ConCheck.Item(0).Visible Then
            
               If ConCheck.Item(3).Visible = False Then
               
  
                  Call PROC_LIMPIAR_CRISTAL
                     
                  cFecha_Desde = Format(TxtFecProc.Text, "yyyymmdd")
                  cFecha_Hasta = Format(GLB_Fecha_Proxima, "yyyymmdd")
                  
                  
                     FRM_MDI_PASIVO.Pasivo_Rpt.WindowTitle = " Informe de Cartera bonos."
                     FRM_MDI_PASIVO.Pasivo_Rpt.ReportFileName = GLB_Ubicacion_Reporte & "RPT_CARTERA_BONOS.rpt"
                     PROC_ESTABLECE_UBICACION FRM_MDI_PASIVO.Pasivo_Rpt.RetrieveDataFiles, FRM_MDI_PASIVO.Pasivo_Rpt
                     FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(0) = cFecha_Desde
                     FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(1) = cFecha_Hasta
                     FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(2) = "N"
                     FRM_MDI_PASIVO.Pasivo_Rpt.Formulas(0) = "xUsuario='" & GLB_Usuario & "'"
                     FRM_MDI_PASIVO.Pasivo_Rpt.Connect = GLB_CONECCION
                     FRM_MDI_PASIVO.Pasivo_Rpt.Action = 1


                     Call PROC_LOG_AUDITORIA("10", cOptLocal, Me.Caption & " Informe de Cartera de bonos: " & TxtFecProc.Text, "", "")
                  
               Else
               
                     Call PROC_LIMPIAR_CRISTAL
                     
                     cFecha_Desde = Format(TxtFecProc.Text, "yyyymmdd")
                     cFecha_Hasta = Format(GLB_Fecha_Proxima, "yyyymmdd")
              
              
                     FRM_MDI_PASIVO.Pasivo_Rpt.WindowTitle = " Informe de Resumen Cartera bonos."
                     FRM_MDI_PASIVO.Pasivo_Rpt.ReportFileName = GLB_Ubicacion_Reporte & "RPT_RES_CARTERA_BONOS.rpt"
                     PROC_ESTABLECE_UBICACION FRM_MDI_PASIVO.Pasivo_Rpt.RetrieveDataFiles, FRM_MDI_PASIVO.Pasivo_Rpt
                     FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(0) = cFecha_Desde
                     FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(1) = cFecha_Hasta
                     FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(2) = "R"
                     FRM_MDI_PASIVO.Pasivo_Rpt.Formulas(0) = "xUsuario='" & GLB_Usuario & "'"
                     FRM_MDI_PASIVO.Pasivo_Rpt.Connect = GLB_CONECCION
                     FRM_MDI_PASIVO.Pasivo_Rpt.Action = 1
             
               
                  Call PROC_LOG_AUDITORIA("10", cOptLocal, Me.Caption & " Informe de Resumen Cartera de bonos: " & TxtFecProc.Text, "", "")
                  
               End If
               
            End If
               
            If ConCheck.Item(1).Visible Then
            
               If ConCheck.Item(3).Visible = False Then
               
                  Call PROC_LIMPIAR_CRISTAL
                     
                     cFecha_Desde = Format(TxtFecProc.Text, "yyyymmdd")
                     cFecha_Hasta = Format(GLB_Fecha_Proxima, "yyyymmdd")
               
               
                     FRM_MDI_PASIVO.Pasivo_Rpt.WindowTitle = " Informe de Cartera Corfo."
                     FRM_MDI_PASIVO.Pasivo_Rpt.ReportFileName = GLB_Ubicacion_Reporte & "RPT_CARTERA_CORFO.rpt"
                     PROC_ESTABLECE_UBICACION FRM_MDI_PASIVO.Pasivo_Rpt.RetrieveDataFiles, FRM_MDI_PASIVO.Pasivo_Rpt
                     FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(0) = cFecha_Desde
                     FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(1) = cFecha_Hasta
                     FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(2) = "CORFO"
                     FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(3) = "N"
                     FRM_MDI_PASIVO.Pasivo_Rpt.Formulas(0) = "xUsuario='" & GLB_Usuario & "'"
                     FRM_MDI_PASIVO.Pasivo_Rpt.Connect = GLB_CONECCION
                     FRM_MDI_PASIVO.Pasivo_Rpt.Action = 1
               
'                     Call PROC_LOG_AUDITORIA("10", cOptLocal, Me.Caption & " Informe de Cartera de corfos: " & TxtFecProc.Text, "", "")
                  
               Else
               
                     Call PROC_LIMPIAR_CRISTAL
                     
                     cFecha_Desde = Format(TxtFecProc.Text, "yyyymmdd")
                     cFecha_Hasta = Format(GLB_Fecha_Proxima, "yyyymmdd")
               
                     FRM_MDI_PASIVO.Pasivo_Rpt.WindowTitle = " Informe de Cartera Corfo."
                     FRM_MDI_PASIVO.Pasivo_Rpt.ReportFileName = GLB_Ubicacion_Reporte & "RPT_RES_CARTERA_CORFO.rpt"
                     PROC_ESTABLECE_UBICACION FRM_MDI_PASIVO.Pasivo_Rpt.RetrieveDataFiles, FRM_MDI_PASIVO.Pasivo_Rpt
                     FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(0) = cFecha_Desde
                     FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(1) = cFecha_Hasta
                     FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(2) = "CORFO"
                     FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(3) = "R"
                     FRM_MDI_PASIVO.Pasivo_Rpt.Formulas(0) = "xUsuario='" & GLB_Usuario & "'"
                     FRM_MDI_PASIVO.Pasivo_Rpt.Connect = GLB_CONECCION
                     FRM_MDI_PASIVO.Pasivo_Rpt.Action = 1
                             
                     Call PROC_LOG_AUDITORIA("10", cOptLocal, Me.Caption & " Informe de Resumen Cartera de corfos: " & TxtFecProc.Text, "", "")
                  
               End If
               
            End If
               
            If ConCheck.Item(2).Visible = True Then
                     
               If ConCheck.Item(3).Visible = False Then
               
                  Call PROC_LIMPIAR_CRISTAL
                     
                  cFecha_Desde = Format(TxtFecProc.Text, "yyyymmdd")
                  cFecha_Hasta = Format(GLB_Fecha_Proxima, "yyyymmdd")
               
               
                  FRM_MDI_PASIVO.Pasivo_Rpt.WindowTitle = " Informe de Cartera Local."
                  FRM_MDI_PASIVO.Pasivo_Rpt.ReportFileName = GLB_Ubicacion_Reporte & "RPT_CARTERA_LOCAL.rpt"
                  PROC_ESTABLECE_UBICACION FRM_MDI_PASIVO.Pasivo_Rpt.RetrieveDataFiles, FRM_MDI_PASIVO.Pasivo_Rpt
                  FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(0) = cFecha_Desde
                  FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(1) = cFecha_Hasta
                  FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(2) = "LOCAL"
                  FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(3) = "N"
                  FRM_MDI_PASIVO.Pasivo_Rpt.Formulas(0) = "xUsuario='" & GLB_Usuario & "'"
                  FRM_MDI_PASIVO.Pasivo_Rpt.Connect = GLB_CONECCION
                  FRM_MDI_PASIVO.Pasivo_Rpt.Action = 1
               
                  Call PROC_LOG_AUDITORIA("10", cOptLocal, Me.Caption & " Informe de Cartera de bancos locales: " & TxtFecProc.Text, "", "")
                  
               Else
               
                  Call PROC_LIMPIAR_CRISTAL
                     
                  cFecha_Desde = Format(TxtFecProc.Text, "yyyymmdd")
                  cFecha_Hasta = Format(GLB_Fecha_Proxima, "yyyymmdd")
               
               
                  FRM_MDI_PASIVO.Pasivo_Rpt.WindowTitle = " Informe de Cartera Local."
                  FRM_MDI_PASIVO.Pasivo_Rpt.ReportFileName = GLB_Ubicacion_Reporte & "RPT_RES_CARTERA_LOCAL.rpt"
                  PROC_ESTABLECE_UBICACION FRM_MDI_PASIVO.Pasivo_Rpt.RetrieveDataFiles, FRM_MDI_PASIVO.Pasivo_Rpt
                  FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(0) = cFecha_Desde
                  FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(1) = cFecha_Hasta
                  FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(2) = "LOCAL"
                  FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(3) = "R"
                  FRM_MDI_PASIVO.Pasivo_Rpt.Formulas(0) = "xUsuario='" & GLB_Usuario & "'"
                  FRM_MDI_PASIVO.Pasivo_Rpt.Connect = GLB_CONECCION
                  FRM_MDI_PASIVO.Pasivo_Rpt.Action = 1
               
              
                  Call PROC_LOG_AUDITORIA("10", cOptLocal, Me.Caption & " Informe de Resumen Cartera de bancos locales: " & TxtFecProc.Text, "", "")
                  
               End If
                     
            End If
               
            If ConCheck.Item(4).Visible = True Then
                  
               If ConCheck.Item(3).Visible = False Then
               
                  Call PROC_LIMPIAR_CRISTAL
                     
                  cFecha_Desde = Format(TxtFecProc.Text, "yyyymmdd")
                  cFecha_Hasta = Format(GLB_Fecha_Proxima, "yyyymmdd")


                  FRM_MDI_PASIVO.Pasivo_Rpt.WindowTitle = " Informe de Cartera Extranjera."
                  FRM_MDI_PASIVO.Pasivo_Rpt.ReportFileName = GLB_Ubicacion_Reporte & "RPT_CARTERA_EXTRA.rpt"
                  PROC_ESTABLECE_UBICACION FRM_MDI_PASIVO.Pasivo_Rpt.RetrieveDataFiles, FRM_MDI_PASIVO.Pasivo_Rpt
                  FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(0) = cFecha_Desde
                  FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(1) = cFecha_Hasta
                  FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(2) = "EXTRA"
                  FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(3) = "N"
                  FRM_MDI_PASIVO.Pasivo_Rpt.Formulas(0) = "xUsuario='" & GLB_Usuario & "'"
                  FRM_MDI_PASIVO.Pasivo_Rpt.Connect = GLB_CONECCION
                  FRM_MDI_PASIVO.Pasivo_Rpt.Action = 1

                  Call PROC_LOG_AUDITORIA("10", cOptLocal, Me.Caption & " Informe de Cartera de bancos extranjeros: " & TxtFecProc.Text, "", "")
                  
               Else
               
                  Call PROC_LIMPIAR_CRISTAL
                     
                  cFecha_Desde = Format(TxtFecProc.Text, "yyyymmdd")
                  cFecha_Hasta = Format(GLB_Fecha_Proxima, "yyyymmdd")
                  
                  FRM_MDI_PASIVO.Pasivo_Rpt.WindowTitle = " Informe de Cartera EXTRA."
                  FRM_MDI_PASIVO.Pasivo_Rpt.ReportFileName = GLB_Ubicacion_Reporte & "RPT_RES_CARTERA_EXTRA.rpt"
                  PROC_ESTABLECE_UBICACION FRM_MDI_PASIVO.Pasivo_Rpt.RetrieveDataFiles, FRM_MDI_PASIVO.Pasivo_Rpt
                  FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(0) = cFecha_Desde
                  FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(1) = cFecha_Hasta
                  FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(2) = "EXTRA"
                  FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(3) = "R"
                  FRM_MDI_PASIVO.Pasivo_Rpt.Formulas(0) = "xUsuario='" & GLB_Usuario & "'"
                  FRM_MDI_PASIVO.Pasivo_Rpt.Connect = GLB_CONECCION
                  FRM_MDI_PASIVO.Pasivo_Rpt.Action = 1

              
                  Call PROC_LOG_AUDITORIA("10", cOptLocal, Me.Caption & " Informe de Resumen Cartera de bancos extranjeros: " & TxtFecProc.Text, "", "")
                  
               End If

                        
            End If
            
            If ConCheck.Item(5).Visible Then
            
               If ConCheck.Item(3).Visible = False Then
               
  
                  Call PROC_LIMPIAR_CRISTAL
                     
                  cFecha_Desde = Format(TxtFecProc.Text, "yyyymmdd")
                  cFecha_Hasta = Format(GLB_Fecha_Proxima, "yyyymmdd")
                  
                  
                     FRM_MDI_PASIVO.Pasivo_Rpt.WindowTitle = " Informe de Cartera Letras Hipotecarias"
                     FRM_MDI_PASIVO.Pasivo_Rpt.ReportFileName = GLB_Ubicacion_Reporte & "RPT_CARTERA_LETRA.rpt"
                     PROC_ESTABLECE_UBICACION FRM_MDI_PASIVO.Pasivo_Rpt.RetrieveDataFiles, FRM_MDI_PASIVO.Pasivo_Rpt
                     FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(0) = cFecha_Desde
                     FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(1) = cFecha_Hasta
                     FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(2) = "N"
                     FRM_MDI_PASIVO.Pasivo_Rpt.Formulas(0) = "xUsuario='" & GLB_Usuario & "'"
                     FRM_MDI_PASIVO.Pasivo_Rpt.Connect = GLB_CONECCION
                     FRM_MDI_PASIVO.Pasivo_Rpt.Action = 1


                     Call PROC_LOG_AUDITORIA("10", cOptLocal, Me.Caption & " Informe de Cartera de Letras Hipotecarias: " & TxtFecProc.Text, "", "")
                  
               Else
               
                     Call PROC_LIMPIAR_CRISTAL
                     
                     cFecha_Desde = Format(TxtFecProc.Text, "yyyymmdd")
                     cFecha_Hasta = Format(GLB_Fecha_Proxima, "yyyymmdd")
              
              
                     FRM_MDI_PASIVO.Pasivo_Rpt.WindowTitle = " Informe de Resumen Cartera Letras Hipotecarias."
                     FRM_MDI_PASIVO.Pasivo_Rpt.ReportFileName = GLB_Ubicacion_Reporte & "RPT_RES_CARTERA_LETRA.rpt"
                     PROC_ESTABLECE_UBICACION FRM_MDI_PASIVO.Pasivo_Rpt.RetrieveDataFiles, FRM_MDI_PASIVO.Pasivo_Rpt
                     FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(0) = cFecha_Desde
                     FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(1) = cFecha_Hasta
                     FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(2) = "R"
                     FRM_MDI_PASIVO.Pasivo_Rpt.Formulas(0) = "xUsuario='" & GLB_Usuario & "'"
                     FRM_MDI_PASIVO.Pasivo_Rpt.Connect = GLB_CONECCION
                     FRM_MDI_PASIVO.Pasivo_Rpt.Action = 1
             
               
                  Call PROC_LOG_AUDITORIA("10", cOptLocal, Me.Caption & " Informe de Resumen Cartera de Letras Hipotecarias: " & TxtFecProc.Text, "", "")
                  
               End If
               
            End If
            
            If ConCheck.Item(6).Visible Then
            
               If ConCheck.Item(3).Visible = False Then
               
  
                  Call PROC_LIMPIAR_CRISTAL
                     
                  cFecha_Desde = Format(TxtFecProc.Text, "yyyymmdd")
                  cFecha_Hasta = Format(GLB_Fecha_Proxima, "yyyymmdd")
                  
                  
                     FRM_MDI_PASIVO.Pasivo_Rpt.WindowTitle = " Informe de Cartera Estinada de bonos."
                     FRM_MDI_PASIVO.Pasivo_Rpt.ReportFileName = GLB_Ubicacion_Reporte & "RPT_CARTERA_BONOS_EST.rpt"
                     PROC_ESTABLECE_UBICACION FRM_MDI_PASIVO.Pasivo_Rpt.RetrieveDataFiles, FRM_MDI_PASIVO.Pasivo_Rpt
                     FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(0) = cFecha_Desde
                     FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(1) = cFecha_Hasta
                     FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(2) = "N"
                     FRM_MDI_PASIVO.Pasivo_Rpt.Formulas(0) = "xUsuario='" & GLB_Usuario & "'"
                     FRM_MDI_PASIVO.Pasivo_Rpt.Connect = GLB_CONECCION
                     FRM_MDI_PASIVO.Pasivo_Rpt.Action = 1


                     Call PROC_LOG_AUDITORIA("10", cOptLocal, Me.Caption & " Informe de Cartera Estimada bonos: " & TxtFecProc.Text, "", "")
                  
               Else
               
                     Call PROC_LIMPIAR_CRISTAL
                     
                     cFecha_Desde = Format(TxtFecProc.Text, "yyyymmdd")
                     cFecha_Hasta = Format(GLB_Fecha_Proxima, "yyyymmdd")
              
              
                     FRM_MDI_PASIVO.Pasivo_Rpt.WindowTitle = " Informe de Resumen Cartera Estinada bonos."
                     FRM_MDI_PASIVO.Pasivo_Rpt.ReportFileName = GLB_Ubicacion_Reporte & "RPT_RES_CARTERA_BONOS_EST.rpt"
                     PROC_ESTABLECE_UBICACION FRM_MDI_PASIVO.Pasivo_Rpt.RetrieveDataFiles, FRM_MDI_PASIVO.Pasivo_Rpt
                     FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(0) = cFecha_Desde
                     FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(1) = cFecha_Hasta
                     FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(2) = "R"
                     FRM_MDI_PASIVO.Pasivo_Rpt.Formulas(0) = "xUsuario='" & GLB_Usuario & "'"
                     FRM_MDI_PASIVO.Pasivo_Rpt.Connect = GLB_CONECCION
                     FRM_MDI_PASIVO.Pasivo_Rpt.Action = 1
             
               
                  Call PROC_LOG_AUDITORIA("10", cOptLocal, Me.Caption & " Informe de Resumen Cartera Estimada de bonos: " & TxtFecProc.Text, "", "")
                  
               End If
               
            End If
            
            If ConCheck.Item(7).Visible = True Then
                  
               If ConCheck.Item(3).Visible = False Then
               
                  Call PROC_LIMPIAR_CRISTAL
                     
                  cFecha_Desde = Format(TxtFecProc.Text, "yyyymmdd")
                  cFecha_Hasta = Format(GLB_Fecha_Proxima, "yyyymmdd")


                  FRM_MDI_PASIVO.Pasivo_Rpt.WindowTitle = " Informe de Cartera Estimada Extranjera."
                  FRM_MDI_PASIVO.Pasivo_Rpt.ReportFileName = GLB_Ubicacion_Reporte & "RPT_CARTERA_EXTRA_EST.rpt"
                  PROC_ESTABLECE_UBICACION FRM_MDI_PASIVO.Pasivo_Rpt.RetrieveDataFiles, FRM_MDI_PASIVO.Pasivo_Rpt
                  FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(0) = cFecha_Desde
                  FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(1) = cFecha_Hasta
                  FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(2) = "EXTRA"
                  FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(3) = "N"
                  FRM_MDI_PASIVO.Pasivo_Rpt.Formulas(0) = "xUsuario='" & GLB_Usuario & "'"
                  FRM_MDI_PASIVO.Pasivo_Rpt.Connect = GLB_CONECCION
                  FRM_MDI_PASIVO.Pasivo_Rpt.Action = 1

                  Call PROC_LOG_AUDITORIA("10", cOptLocal, Me.Caption & " Informe de Cartera Estimada de bancos extranjeros: " & TxtFecProc.Text, "", "")
                  
               Else
               
                  Call PROC_LIMPIAR_CRISTAL
                     
                  cFecha_Desde = Format(TxtFecProc.Text, "yyyymmdd")
                  cFecha_Hasta = Format(GLB_Fecha_Proxima, "yyyymmdd")
                  
                  FRM_MDI_PASIVO.Pasivo_Rpt.WindowTitle = " Informe Resumen de Cartera Estimada EXTRA."
                  FRM_MDI_PASIVO.Pasivo_Rpt.ReportFileName = GLB_Ubicacion_Reporte & "RPT_RES_CARTERA_EXTRA_EST.rpt"
                  PROC_ESTABLECE_UBICACION FRM_MDI_PASIVO.Pasivo_Rpt.RetrieveDataFiles, FRM_MDI_PASIVO.Pasivo_Rpt
                  FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(0) = cFecha_Desde
                  FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(1) = cFecha_Hasta
                  FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(2) = "EXTRA"
                  FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(3) = "R"
                  FRM_MDI_PASIVO.Pasivo_Rpt.Formulas(0) = "xUsuario='" & GLB_Usuario & "'"
                  FRM_MDI_PASIVO.Pasivo_Rpt.Connect = GLB_CONECCION
                  FRM_MDI_PASIVO.Pasivo_Rpt.Action = 1

              
                  Call PROC_LOG_AUDITORIA("10", cOptLocal, Me.Caption & " Informe de Resumen Cartera Estimada de bancos extranjeros: " & TxtFecProc.Text, "", "")
                  
               End If

                        
            End If
               
            If ConCheck.Item(9).Visible Then
            
               If ConCheck.Item(3).Visible = False Then
               
                  Call PROC_LIMPIAR_CRISTAL
                     
                     cFecha_Desde = Format(TxtFecProc.Text, "yyyymmdd")
                     cFecha_Hasta = Format(GLB_Fecha_Proxima, "yyyymmdd")
               
               
                     FRM_MDI_PASIVO.Pasivo_Rpt.WindowTitle = " Informe de Cartera Tasa Estimada Corfo."
                     FRM_MDI_PASIVO.Pasivo_Rpt.ReportFileName = GLB_Ubicacion_Reporte & "RPT_CARTERA_CORFO_EST.rpt"
                     PROC_ESTABLECE_UBICACION FRM_MDI_PASIVO.Pasivo_Rpt.RetrieveDataFiles, FRM_MDI_PASIVO.Pasivo_Rpt
                     FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(0) = cFecha_Desde
                     FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(1) = cFecha_Hasta
                     FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(2) = "CORFO"
                     FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(3) = "N"
                     FRM_MDI_PASIVO.Pasivo_Rpt.Formulas(0) = "xUsuario='" & GLB_Usuario & "'"
                     FRM_MDI_PASIVO.Pasivo_Rpt.Connect = GLB_CONECCION
                     FRM_MDI_PASIVO.Pasivo_Rpt.Action = 1
               
'                     Call PROC_LOG_AUDITORIA("10", cOptLocal, Me.Caption & " Informe de Cartera de corfos: " & TxtFecProc.Text, "", "")
                  
               Else
               
                     Call PROC_LIMPIAR_CRISTAL
                     
                     cFecha_Desde = Format(TxtFecProc.Text, "yyyymmdd")
                     cFecha_Hasta = Format(GLB_Fecha_Proxima, "yyyymmdd")
               
                     FRM_MDI_PASIVO.Pasivo_Rpt.WindowTitle = " Informe de Cartera Tasa Estimada Corfo."
                     FRM_MDI_PASIVO.Pasivo_Rpt.ReportFileName = GLB_Ubicacion_Reporte & "RPT_RES_CARTERA_CORFO_EST.rpt"
                     PROC_ESTABLECE_UBICACION FRM_MDI_PASIVO.Pasivo_Rpt.RetrieveDataFiles, FRM_MDI_PASIVO.Pasivo_Rpt
                     FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(0) = cFecha_Desde
                     FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(1) = cFecha_Hasta
                     FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(2) = "CORFO"
                     FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(3) = "R"
                     FRM_MDI_PASIVO.Pasivo_Rpt.Formulas(0) = "xUsuario='" & GLB_Usuario & "'"
                     FRM_MDI_PASIVO.Pasivo_Rpt.Connect = GLB_CONECCION
                     FRM_MDI_PASIVO.Pasivo_Rpt.Action = 1
                             
                     Call PROC_LOG_AUDITORIA("10", cOptLocal, Me.Caption & " Informe de Resumen Cartera Tasa Estimada de corfos: " & TxtFecProc.Text, "", "")
                  
               End If
               
            End If
               
            If ConCheck.Item(8).Visible = True Then
                     
               If ConCheck.Item(3).Visible = False Then
               
                  Call PROC_LIMPIAR_CRISTAL
                     
                  cFecha_Desde = Format(TxtFecProc.Text, "yyyymmdd")
                  cFecha_Hasta = Format(GLB_Fecha_Proxima, "yyyymmdd")
               
               
                  FRM_MDI_PASIVO.Pasivo_Rpt.WindowTitle = " Informe de Cartera Tasa Estimada Local."
                  FRM_MDI_PASIVO.Pasivo_Rpt.ReportFileName = GLB_Ubicacion_Reporte & "RPT_CARTERA_LOCAL_EST.rpt"
                  PROC_ESTABLECE_UBICACION FRM_MDI_PASIVO.Pasivo_Rpt.RetrieveDataFiles, FRM_MDI_PASIVO.Pasivo_Rpt
                  FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(0) = cFecha_Desde
                  FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(1) = cFecha_Hasta
                  FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(2) = "LOCAL"
                  FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(3) = "N"
                  FRM_MDI_PASIVO.Pasivo_Rpt.Formulas(0) = "xUsuario='" & GLB_Usuario & "'"
                  FRM_MDI_PASIVO.Pasivo_Rpt.Connect = GLB_CONECCION
                  FRM_MDI_PASIVO.Pasivo_Rpt.Action = 1
               
                  Call PROC_LOG_AUDITORIA("10", cOptLocal, Me.Caption & " Informe de Cartera Tasa Estimada de bancos locales: " & TxtFecProc.Text, "", "")
                  
               Else
               
                  Call PROC_LIMPIAR_CRISTAL
                     
                  cFecha_Desde = Format(TxtFecProc.Text, "yyyymmdd")
                  cFecha_Hasta = Format(GLB_Fecha_Proxima, "yyyymmdd")
               
               
                  FRM_MDI_PASIVO.Pasivo_Rpt.WindowTitle = " Informe de Cartera Tasa Estimada Local."
                  FRM_MDI_PASIVO.Pasivo_Rpt.ReportFileName = GLB_Ubicacion_Reporte & "RPT_RES_CARTERA_LOCAL_EST.rpt"
                  PROC_ESTABLECE_UBICACION FRM_MDI_PASIVO.Pasivo_Rpt.RetrieveDataFiles, FRM_MDI_PASIVO.Pasivo_Rpt
                  FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(0) = cFecha_Desde
                  FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(1) = cFecha_Hasta
                  FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(2) = "LOCAL"
                  FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(3) = "R"
                  FRM_MDI_PASIVO.Pasivo_Rpt.Formulas(0) = "xUsuario='" & GLB_Usuario & "'"
                  FRM_MDI_PASIVO.Pasivo_Rpt.Connect = GLB_CONECCION
                  FRM_MDI_PASIVO.Pasivo_Rpt.Action = 1
               
              
                  Call PROC_LOG_AUDITORIA("10", cOptLocal, Me.Caption & " Informe de Resumen Cartera Tasa Estimada de bancos locales: " & TxtFecProc.Text, "", "")
                  
               End If
                     
            End If
            If ConCheck.Item(10).Visible Then
            
                  Call PROC_LIMPIAR_CRISTAL
                     
                  cFecha_Desde = Format(TxtFecProc.Text, "yyyymmdd")
                  cFecha_Hasta = Format(GLB_Fecha_Proxima, "yyyymmdd")
                  
                  
                     FRM_MDI_PASIVO.Pasivo_Rpt.WindowTitle = " Informe de Cartera bonos Emitidos."
                     FRM_MDI_PASIVO.Pasivo_Rpt.ReportFileName = GLB_Ubicacion_Reporte & "RPT_CARTERA_BONOS_EMISION.RPT"
                     PROC_ESTABLECE_UBICACION FRM_MDI_PASIVO.Pasivo_Rpt.RetrieveDataFiles, FRM_MDI_PASIVO.Pasivo_Rpt
                     FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(0) = cFecha_Desde
                     FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(1) = cFecha_Hasta
                     FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(2) = "N"
                     FRM_MDI_PASIVO.Pasivo_Rpt.Formulas(0) = "xUsuario='" & GLB_Usuario & "'"
                     FRM_MDI_PASIVO.Pasivo_Rpt.Connect = GLB_CONECCION
                     FRM_MDI_PASIVO.Pasivo_Rpt.Action = 1

                     Call PROC_LOG_AUDITORIA("10", cOptLocal, Me.Caption & " Informe de Cartera de bonos emitidos: " & TxtFecProc.Text, "", "")
            End If
               
Screen.MousePointer = 0
   
   

Exit Sub

Control:

   Call PROC_LOG_AUDITORIA("10", cOptLocal, Me.Caption & " Error al emitir reporte- Informe de Listado de Movimientos- Fecha Proceso: " & TxtFecProc.Text, "", "")
   MsgBox "Problemas al generar Listado de Carteras. " & Err.Description, vbCritical

   Screen.MousePointer = 0
   
End Sub
Private Sub ConCheck_Click(Index As Integer)

   SinCheck.Item(Index).Visible = Not SinCheck.Item(Index).Visible
   ConCheck.Item(Index).Visible = Not ConCheck.Item(Index).Visible
   DoEvents
   SinCheck.Item(Index).SetFocus
   
End Sub

Private Sub ConCheck_GotFocus(Index As Integer)

      Etiqueta(Index).BackColor = BackSeleccion
      Etiqueta(Index).ForeColor = ForeSeleccion

End Sub

Private Sub ConCheck_KeyPress(Index As Integer, KeyAscii As Integer)
    
    If KeyAscii = 109 Or KeyAscii = 32 Then
        
        ConCheck_Click (Index)
    
    End If
    
    If KeyAscii = 13 Then
        
        FUNC_ENVIA_TECLA (vbKeyTab)
    
    End If

End Sub

Private Sub ConCheck_LostFocus(Index As Integer)

      Etiqueta(Index).BackColor = BackNormal
      Etiqueta(Index).ForeColor = ForeNormal

End Sub

Private Sub Form_Activate()

   PROC_CARGA_AYUDA Me

End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)

Dim nOpcion As Integer

    If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) Then

        Select Case KeyCode
            
            Case VbKeyImprimir 'Imprimir
                
                nOpcion = 1
            
            Case vbKeyVistaPrevia 'Vista Previa
                
                nOpcion = 2
            
            Case vbKeySalir 'Salir
                
                nOpcion = 3
        
        End Select
        
        If nOpcion > 0 Then
            
            If Tlb_Movimiento.Buttons(nOpcion).Enabled Then
                
                Tlb_Movimiento_ButtonClick Tlb_Movimiento.Buttons(nOpcion)
            
            End If
        
        End If
    
    End If

End Sub

Private Sub Form_Load()

Dim X As Integer

    Me.Icon = FRM_MDI_PASIVO.Icon
    TxtFecProc.Text = GLB_Fecha_Proceso
    Me.top = 0
    Me.left = 0
    SinCheck(0).top = 360
    ConCheck(0).top = 360
    Etiqueta(0).top = 405
  
    Screen.MousePointer = 11
'    giAceptar% = False
    
    Screen.MousePointer = 0
    cOptLocal = GLB_Opcion_Menu
    DoEvents
    
    
    Call PROC_LOG_AUDITORIA("07", cOptLocal, Me.Caption, "", "")

End Sub

Private Sub Form_Unload(Cancel As Integer)

   Call PROC_LOG_AUDITORIA("08", cOptLocal, Me.Caption, "", "")
   
End Sub

Private Sub SinCheck_Click(Index As Integer)
    
    ConCheck.Item(Index).left = SinCheck.Item(Index).left
    SinCheck.Item(Index).Visible = Not SinCheck.Item(Index).Visible
    ConCheck.Item(Index).Visible = Not ConCheck.Item(Index).Visible
    DoEvents
    ConCheck.Item(Index).SetFocus

End Sub
Private Sub SinCheck_GotFocus(Index As Integer)
      
      Etiqueta(Index).BackColor = BackSeleccion
      Etiqueta(Index).ForeColor = ForeSeleccion

End Sub

Private Sub SinCheck_KeyPress(Index As Integer, KeyAscii As Integer)
    
    If KeyAscii = 109 Or KeyAscii = 32 Then
        
        SinCheck_Click (Index)
    
    End If
    
    If KeyAscii = 13 Then
        
        FUNC_ENVIA_TECLA (vbKeyTab)
    
    End If

End Sub

Private Sub SinCheck_LostFocus(Index As Integer)

      Etiqueta(Index).BackColor = BackNormal
      Etiqueta(Index).ForeColor = ForeNormal

End Sub

Private Sub Tlb_Movimiento_ButtonClick(ByVal Button As MSComctlLib.Button)

   
   Select Case Button.Index

   Case 1
         
      If PROC_VALIDA_FECHAS = False Then Exit Sub

      Call Generar_Listado("Impresora")

   Case 2
         
      If PROC_VALIDA_FECHAS = False Then Exit Sub

      Call Generar_Listado("Pantalla")

   Case 3
   
      Unload Me

   End Select

End Sub

Function PROC_VALIDA_FECHAS() As Boolean

   PROC_VALIDA_FECHAS = False
   
   If CDate(TxtFecProc.Text) > CDate(GLB_Fecha_Proceso) Then
   
    If mvarFinMesEspecial = True And CDate(TxtFecProc.Text) = CDate(GLB_Fecha_FinMes) Then
    
    Else
      MsgBox "Fecha desde no puede ser mayor a la fecha hasta.", vbInformation
      TxtFecProc.SetFocus
      Exit Function
   End If
   'ElseIf FUNC_VALIDA_FECHA_FERIADO(GLB_nPais_Chile, GLB_nPlaza_Stgo, CDate(TxtFecProc.Text)) Then
'     ElseIf FUNC_VALIDA_FECHA_FERIADO(CDate(TxtFecProc.Text), GLB_nPlaza_Stgo, 0) Then
'
'      MsgBox "No puede seleccionar una fecha que sea feriado.", vbInformation
'      TxtFecProc.SetFocus
'      Exit Function
'
   End If
        
   PROC_VALIDA_FECHAS = True
   
End Function

Private Sub TxtFecProc_KeyPress(KeyAscii As Integer)
   
    If KeyAscii = 13 Then
        
        FUNC_ENVIA_TECLA (vbKeyTab)
    
    End If

End Sub

