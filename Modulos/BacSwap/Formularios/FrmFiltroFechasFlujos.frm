VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "baccontroles.ocx"
Begin VB.Form FrmFiltroFechasFlujos 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Filtro por rango de Fechas"
   ClientHeight    =   1515
   ClientLeft      =   45
   ClientTop       =   375
   ClientWidth     =   5880
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1515
   ScaleWidth      =   5880
   Begin VB.Frame Frame1 
      Height          =   915
      Left            =   15
      TabIndex        =   1
      Top             =   480
      Width           =   5805
      Begin BACControles.TXTFecha Txt_fecha_desde 
         Height          =   285
         Left            =   1335
         TabIndex        =   2
         Top             =   180
         Width           =   1515
         _ExtentX        =   2672
         _ExtentY        =   503
         Enabled         =   -1  'True
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "14/08/2006"
      End
      Begin BACControles.TXTFecha Txt_Fecha_Hasta 
         Height          =   285
         Left            =   1335
         TabIndex        =   3
         Top             =   510
         Width           =   1515
         _ExtentX        =   2672
         _ExtentY        =   503
         Enabled         =   -1  'True
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "14/08/2006"
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Fecha Desde"
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
         Left            =   165
         TabIndex        =   8
         Top             =   225
         Width           =   1065
      End
      Begin VB.Label lblFecha 
         Alignment       =   2  'Center
         Caption         =   "Miercoles, 21 de Septiembre del 2006"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000FF&
         Height          =   285
         Left            =   45
         TabIndex        =   7
         Top             =   1485
         Width           =   4155
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Fecha Hasta"
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
         Left            =   150
         TabIndex        =   6
         Top             =   555
         Width           =   1035
      End
      Begin VB.Label LblFechaLargaDesde 
         Caption         =   "Miercoles, 21 de Septiembre del 2007"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   270
         Left            =   2895
         TabIndex        =   5
         Top             =   210
         Width           =   2775
      End
      Begin VB.Label LblFechaLargaHasta 
         Caption         =   "Miercoles, 21 de Septiembre del 2007"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   270
         Left            =   2895
         TabIndex        =   4
         Top             =   540
         Width           =   2775
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   5880
      _ExtentX        =   10372
      _ExtentY        =   794
      ButtonWidth     =   1958
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      TextAlignment   =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Aceptar"
            Key             =   "Aceptar"
            Object.ToolTipText     =   "Aceptar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Salir"
            Key             =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   3975
         Top             =   495
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
               Picture         =   "FrmFiltroFechasFlujos.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FrmFiltroFechasFlujos.frx":0EDA
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
End
Attribute VB_Name = "FrmFiltroFechasFlujos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private Sub Form_Load()
Dim FecProcAnt   As Date
    Me.Icon = BACSwap.Icon
    
    '**************************************************************
    '                      CENTRO FORMULARIO
    '**************************************************************
    Me.Move (Screen.Width - Width) / 2, (Screen.Height - Height) / 2
    
    FecProcAnt = Format(gsc_Parametros.FechaAnt, gsc_FechaDMA)
    Txt_fecha_desde.Text = DateAdd("d", 1, FecProcAnt)
    LblFechaLargaDesde.Caption = Format(Txt_fecha_desde.Text, "dddd, dd") & " de " & Format(Txt_fecha_desde.Text, "mmmm") & " del " & Format(Txt_fecha_desde.Text, "yyyy")
    
    Txt_Fecha_Hasta.Text = gsBAC_Fecp
    LblFechaLargaHasta.Caption = Format(Txt_Fecha_Hasta.Text, "dddd, dd") & " de " & Format(Txt_Fecha_Hasta.Text, "mmmm") & " del " & Format(Txt_Fecha_Hasta.Text, "yyyy")

End Sub
Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 1
        Call FiltraFlujos
      Case 2
         Unload Me
   End Select
End Sub
Private Sub Txt_fecha_desde_Change()
   LblFechaLargaDesde.Caption = Format(Txt_fecha_desde.Text, "dddd, dd") & " de " & Format(Txt_fecha_desde.Text, "mmmm") & " del " & Format(Txt_fecha_desde.Text, "yyyy")
End Sub
Private Sub Txt_Fecha_Hasta_Change()
   LblFechaLargaHasta.Caption = Format(Txt_Fecha_Hasta.Text, "dddd, dd") & " de " & Format(Txt_Fecha_Hasta.Text, "mmmm") & " del " & Format(Txt_Fecha_Hasta.Text, "yyyy")
End Sub
Private Sub FiltraFlujos()
    gstrFechaOrigen = Txt_fecha_desde.Text
    gstrFechaFinal = Txt_Fecha_Hasta.Text
    Unload Me
End Sub
