VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form Bac_Informes 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Bac Informes"
   ClientHeight    =   4665
   ClientLeft      =   1440
   ClientTop       =   2130
   ClientWidth     =   6630
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   4665
   ScaleWidth      =   6630
   Begin VB.Frame Fr_Area_Responsable 
      Caption         =   "Area Responsable"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   615
      Left            =   3375
      TabIndex        =   23
      Top             =   1350
      Width           =   3200
      Begin VB.ComboBox Cmb_Area_Responsable 
         Height          =   315
         Left            =   90
         Style           =   2  'Dropdown List
         TabIndex        =   24
         Top             =   210
         Width           =   3015
      End
   End
   Begin VB.Frame Fr_Cartera_Normativa 
      Caption         =   "Cartera Normativa"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   615
      Left            =   3375
      TabIndex        =   21
      Top             =   705
      Width           =   3200
      Begin VB.ComboBox Cmb_Cartera_Normativa 
         Height          =   315
         Left            =   90
         Style           =   2  'Dropdown List
         TabIndex        =   22
         Top             =   210
         Width           =   3015
      End
   End
   Begin VB.Frame Fr_Libro 
      Caption         =   "Libro"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   615
      Left            =   120
      TabIndex        =   19
      Top             =   1350
      Width           =   3200
      Begin VB.ComboBox Cmb_Libro 
         Height          =   315
         Left            =   90
         Style           =   2  'Dropdown List
         TabIndex        =   20
         Top             =   210
         Width           =   3015
      End
   End
   Begin VB.Frame fr_Cartera 
      Caption         =   "Cartera Financiera"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   615
      Left            =   120
      TabIndex        =   17
      Top             =   705
      Width           =   3200
      Begin VB.ComboBox Cmb_Cartera 
         Height          =   315
         Left            =   90
         Style           =   2  'Dropdown List
         TabIndex        =   18
         Top             =   210
         Width           =   3015
      End
   End
   Begin VB.Frame frm_fechas 
      Caption         =   "Fecha del Informe"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   690
      Left            =   105
      TabIndex        =   10
      Top             =   1995
      Width           =   6480
      Begin BACControles.TXTFecha txt_fecha_pro 
         Height          =   270
         Left            =   2610
         TabIndex        =   1
         Top             =   255
         Width           =   1320
         _ExtentX        =   2328
         _ExtentY        =   476
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
         Text            =   "14/12/2001"
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   660
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   6630
      _ExtentX        =   11695
      _ExtentY        =   1164
      ButtonWidth     =   1032
      ButtonHeight    =   1005
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Imprimir en Pantalla"
            ImageIndex      =   14
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Imprimir"
            ImageIndex      =   10
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "salir"
            ImageIndex      =   12
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   6330
      Top             =   45
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
            Picture         =   "bac_informes.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_informes.frx":031A
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_informes.frx":076C
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_informes.frx":0BBE
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_informes.frx":0ED8
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_informes.frx":11F2
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_informes.frx":1644
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_informes.frx":179E
            Key             =   ""
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_informes.frx":1BF0
            Key             =   ""
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_informes.frx":2042
            Key             =   ""
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_informes.frx":235C
            Key             =   ""
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_informes.frx":2676
            Key             =   ""
         EndProperty
         BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_informes.frx":27D0
            Key             =   ""
         EndProperty
         BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_informes.frx":2C22
            Key             =   ""
         EndProperty
         BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_informes.frx":3074
            Key             =   ""
         EndProperty
         BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_informes.frx":338E
            Key             =   ""
         EndProperty
         BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_informes.frx":36A8
            Key             =   ""
         EndProperty
         BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_informes.frx":39C2
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.Frame frm_fecha_inf 
      Caption         =   "Rango de Fechas"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   780
      Left            =   100
      TabIndex        =   12
      Top             =   2685
      Width           =   6480
      Begin BACControles.TXTFecha txt_fec2 
         Height          =   315
         Left            =   4800
         TabIndex        =   3
         Top             =   330
         Width           =   1230
         _ExtentX        =   2170
         _ExtentY        =   556
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
         Text            =   "14/12/2001"
      End
      Begin BACControles.TXTFecha txt_fec1 
         Height          =   315
         Left            =   1350
         TabIndex        =   2
         Top             =   315
         Width           =   1230
         _ExtentX        =   2170
         _ExtentY        =   556
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
         Text            =   "14/12/2001"
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Hasta el "
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000C0&
         Height          =   195
         Left            =   3915
         TabIndex        =   15
         Top             =   390
         Width           =   780
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Desde el "
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000C0&
         Height          =   195
         Left            =   465
         TabIndex        =   14
         Top             =   375
         Width           =   825
      End
   End
   Begin VB.Frame frm_tipo_cartera 
      Caption         =   "Tipo Cartera"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   750
      Left            =   150
      TabIndex        =   16
      Top             =   6645
      Width           =   6450
      Begin VB.CheckBox ch_tip_p 
         Caption         =   "Permanente"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000C0&
         Height          =   345
         Left            =   3345
         TabIndex        =   9
         Top             =   315
         Width           =   2805
      End
      Begin VB.CheckBox ch_tipo_n 
         Caption         =   "Normal"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000C0&
         Height          =   345
         Left            =   825
         TabIndex        =   8
         Top             =   315
         Width           =   2385
      End
   End
   Begin VB.Frame frm_unidad 
      Caption         =   "Unidad"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   1140
      Left            =   120
      TabIndex        =   13
      Top             =   3480
      Width           =   6465
      Begin BACControles.TXTNumero txt_unidad 
         Height          =   315
         Left            =   5520
         TabIndex        =   7
         Top             =   675
         Width           =   720
         _ExtentX        =   1270
         _ExtentY        =   556
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
      End
      Begin VB.OptionButton opt_todas 
         Caption         =   "Todas"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000C0&
         Height          =   300
         Left            =   150
         TabIndex        =   4
         Top             =   300
         Width           =   1155
      End
      Begin VB.OptionButton opt_una 
         Caption         =   "Una"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000C0&
         Height          =   300
         Left            =   1425
         TabIndex        =   5
         Top             =   300
         Width           =   1125
      End
      Begin VB.TextBox txt 
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
         Left            =   3270
         MaxLength       =   4
         TabIndex        =   11
         Top             =   1845
         Width           =   765
      End
      Begin VB.ComboBox box_unidad 
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
         Left            =   135
         Style           =   2  'Dropdown List
         TabIndex        =   6
         Top             =   675
         Width           =   5340
      End
   End
End
Attribute VB_Name = "Bac_Informes"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim Informe As Form
Dim Op As Double

Function Informe_Anulacion_Oper(modi)

    Dim nSuc1 As Integer
    Dim nSuc2 As Integer


    If Me.opt_todas.Value = True Then
        nSuc1 = 0
        nSuc2 = 9999
    Else
        nSuc1 = Me.box_unidad.ItemData(Me.box_unidad.ListIndex)
        nSuc2 = Me.box_unidad.ItemData(Me.box_unidad.ListIndex)
    End If

    BAC_INVERSIONES.BacRpt.ReportFileName = RptList_Path & "Informe_de_ANULACION_OPERACION.rpt"
    BAC_INVERSIONES.BacRpt.WindowTitle = "INFORME DE ANULACIÓN DE OPERACIONES"
    BAC_INVERSIONES.BacRpt.StoredProcParam(0) = Format(Me.txt_fecha_pro.Text, "yyyymmdd")
    BAC_INVERSIONES.BacRpt.StoredProcParam(1) = nSuc1
    BAC_INVERSIONES.BacRpt.StoredProcParam(2) = nSuc2
    BAC_INVERSIONES.BacRpt.StoredProcParam(3) = Trim(Right(Cmb_Cartera.Text, 10)) 'Cmb_Cartera.ItemData(Cmb_Cartera.ListIndex)
    BAC_INVERSIONES.BacRpt.Destination = modi
    BAC_INVERSIONES.BacRpt.Connect = CONECCION
    BAC_INVERSIONES.BacRpt.Action = 1

End Function

Function Informe_basliea(Fec, modi)

    BAC_INVERSIONES.BacRpt.ReportFileName = RptList_Path & "informe_basilea.rpt"
    BAC_INVERSIONES.BacRpt.WindowTitle = "INFORME DE BASILEA "
    BAC_INVERSIONES.BacRpt.StoredProcParam(0) = Format(fec1, "YYYYMMDD")
    BAC_INVERSIONES.BacRpt.Destination = modi
    BAC_INVERSIONES.BacRpt.Connect = CONECCION
    BAC_INVERSIONES.BacRpt.Action = 1

End Function

Function Informe_cartera_pendiente(fec1, modi)
    BAC_INVERSIONES.BacRpt.ReportFileName = RptList_Path & "INFORME_DE_CARTERA_PENDIENTES.rpt"
    BAC_INVERSIONES.BacRpt.WindowTitle = "INFORME DE CARTERA PENDIENTE"
    BAC_INVERSIONES.BacRpt.StoredProcParam(0) = Format(fec1, "yyyymmdd")
    If modi = 1 Then
        BAC_INVERSIONES.BacRpt.Destination = crptToWindow
    Else
        BAC_INVERSIONES.BacRpt.Destination = crptToPrinter
    End If
    BAC_INVERSIONES.BacRpt.Connect = CONECCION
    BAC_INVERSIONES.BacRpt.Action = 1

    Call limpiar_cristal
End Function

Function Informe_compendio(Fecha, modi)

    BAC_INVERSIONES.BacRpt.ReportFileName = RptList_Path & "informe_compendio.rpt"
    BAC_INVERSIONES.BacRpt.WindowTitle = "COMPENDIO DE NORMAS"
    BAC_INVERSIONES.BacRpt.StoredProcParam(0) = Format(Fecha, "YYYYMMDD")
    BAC_INVERSIONES.BacRpt.Destination = modi
    BAC_INVERSIONES.BacRpt.Connect = CONECCION
    BAC_INVERSIONES.BacRpt.Action = 1

End Function

Function Informe_Compras_del_dia(tipo, modi)


    Dim nSuc1 As Integer
    Dim nSuc2 As Integer
     Dim cartera As String
     Dim cartera_normativa As String
     Dim libro As String
     

   
    Call limpiar_cristal
    
   If Trim(Right(Cmb_Cartera.Text, 10)) = "" Then
      cartera = "0"
   Else
      cartera = Trim(Right(Cmb_Cartera.Text, 10))
   End If
   
   If Trim(Right(Cmb_Cartera_Normativa.Text, 10)) = "" Then
      cartera_normativa = "0"
   Else
      cartera_normativa = Trim(Right(Cmb_Cartera_Normativa.Text, 10))
   End If
   
   If Trim(Right(Cmb_Libro.Text, 10)) = "" Then
      libro = "0"
   Else
      libro = Trim(Right(Cmb_Libro.Text, 10))
   End If
   

    If Me.opt_todas.Value = True Then
        nSuc1 = 0
        nSuc2 = 9999
    Else
        nSuc1 = Me.box_unidad.ItemData(Me.box_unidad.ListIndex)
        nSuc2 = Me.box_unidad.ItemData(Me.box_unidad.ListIndex)
    End If
  

    If Bac_Informe = "INFCOM" Then
        BAC_INVERSIONES.BacRpt.ReportFileName = RptList_Path & "Informe_compras.rpt"
        BAC_INVERSIONES.BacRpt.WindowTitle = "INFORME DE COMPRAS"
        tipo = "CP"
    Else
          BAC_INVERSIONES.BacRpt.ReportFileName = RptList_Path & "Informe_ventas.rpt"
        BAC_INVERSIONES.BacRpt.WindowTitle = "INFORME DE VENTAS"
        tipo = "VP"
    End If

    BAC_INVERSIONES.BacRpt.StoredProcParam(0) = tipo
    BAC_INVERSIONES.BacRpt.StoredProcParam(1) = Format(Me.txt_fecha_pro.Text, "yyyymmdd")
    BAC_INVERSIONES.BacRpt.StoredProcParam(2) = nSuc1
    BAC_INVERSIONES.BacRpt.StoredProcParam(3) = nSuc2
    BAC_INVERSIONES.BacRpt.StoredProcParam(4) = cartera 'Trim(Right(Cmb_Cartera.Text, 10)) 'Cmb_Cartera.ItemData(Cmb_Cartera.ListIndex)
    BAC_INVERSIONES.BacRpt.StoredProcParam(5) = cTipo_Oper
    BAC_INVERSIONES.BacRpt.StoredProcParam(6) = cartera_normativa 'Trim(Right(Cmb_Cartera_Normativa.Text, 10))
    BAC_INVERSIONES.BacRpt.StoredProcParam(7) = libro 'Trim(Right(Cmb_Libro.Text, 10))
    BAC_INVERSIONES.BacRpt.StoredProcParam(8) = IIf(Trim(Right(Cmb_Area_Responsable.Text, 10)) = "", " ", Trim(Right(Cmb_Area_Responsable.Text, 10)))
    BAC_INVERSIONES.BacRpt.StoredProcParam(9) = GLB_CARTERA_NORMATIVA
    BAC_INVERSIONES.BacRpt.StoredProcParam(10) = GLB_LIBRO
    BAC_INVERSIONES.BacRpt.StoredProcParam(11) = GLB_AREA_RESPONSABLE
    
    
    
    BAC_INVERSIONES.BacRpt.Destination = modi
    BAC_INVERSIONES.BacRpt.Connect = CONECCION
    BAC_INVERSIONES.BacRpt.Action = 1

End Function

Function Informe_D05(modi)

    BAC_INVERSIONES.BacRpt.ReportFileName = RptList_Path & "Informe_d05.rpt"
    BAC_INVERSIONES.BacRpt.WindowTitle = "INFORME D05 DE INVERSIONES "
    BAC_INVERSIONES.BacRpt.StoredProcParam(0) = Format(Me.txt_fecha_pro.Text, "YYYYMMDD")
    BAC_INVERSIONES.BacRpt.Destination = modi
    BAC_INVERSIONES.BacRpt.Connect = CONECCION
    BAC_INVERSIONES.BacRpt.Action = 1

End Function

Function Informe_De_Cartera_valutas_vigentes(modi)

    Dim nSuc1 As Integer
    Dim nSuc2 As Integer


    If Me.opt_todas.Value = True Then
        nSuc1 = 0
        nSuc2 = 9999
    Else
        nSuc1 = Me.box_unidad.ItemData(Me.box_unidad.ListIndex)
        nSuc2 = Me.box_unidad.ItemData(Me.box_unidad.ListIndex)
    End If
    
    BAC_INVERSIONES.BacRpt.ReportFileName = RptList_Path & "CarteraPagosPendientes.rpt"
    BAC_INVERSIONES.BacRpt.StoredProcParam(0) = Format(Me.txt_fecha_pro.Text, "yyyymmdd")
    BAC_INVERSIONES.BacRpt.Destination = modi
    BAC_INVERSIONES.BacRpt.Connect = CONECCION
    BAC_INVERSIONES.BacRpt.Action = 1

''
'    BAC_INVERSIONES.BacRpt.ReportFileName = RptList_Path & "informe_cartera_de_valutas_vigente.RPT"
'    BAC_INVERSIONES.BacRpt.WindowTitle = "INFORME DE CARTERA DE VALUTAS VIGENTES"
'    BAC_INVERSIONES.BacRpt.StoredProcParam(0) = Format(Me.txt_fecha_pro.Text, "YYYYMMDD")
'    BAC_INVERSIONES.BacRpt.StoredProcParam(1) = nSuc1
'    BAC_INVERSIONES.BacRpt.StoredProcParam(2) = nSuc2
'    BAC_INVERSIONES.BacRpt.Destination = modi
'    BAC_INVERSIONES.BacRpt.Connect = CONECCION
'    BAC_INVERSIONES.BacRpt.Action = 1

End Function

Function Informe_De_Cartera_vigentes(modi)

    Dim nSuc1 As Integer
    Dim nSuc2 As Integer
    Dim cTipo As String
    Dim nContador   As Integer
    Dim nVeces      As Integer
    Dim nHasta      As Integer

    If Me.opt_todas.Value = True Then
        nSuc1 = 0
        nSuc2 = 9999
    Else
        nSuc1 = Me.box_unidad.ItemData(Me.box_unidad.ListIndex)
        nSuc2 = Me.box_unidad.ItemData(Me.box_unidad.ListIndex)
    End If
    
    With Cmb_Cartera_Normativa
        nVeces = IIf(.ListIndex = 0, 1, .ListIndex)
        nHasta = IIf(.ListIndex = 0, .ListCount - 1, .ListIndex)
    End With
    
    For nContador = nVeces To nHasta
        Call limpiar_cristal
        With BAC_INVERSIONES.BacRpt
            .ReportFileName = RptList_Path & "informe_cartera_vigente.RPT"
            .WindowTitle = "INFORME DE CARTERA VIGENTES"
            .StoredProcParam(0) = Format(Me.txt_fecha_pro.Text, "YYYYMMDD")
            .StoredProcParam(1) = nSuc1
            .StoredProcParam(2) = nSuc2
            .StoredProcParam(3) = Trim(Right(Cmb_Cartera_Normativa.List(nContador), 10))
            .StoredProcParam(4) = Trim(Right(Cmb_Cartera.Text, 10)) 'Cmb_Cartera.ItemData(Cmb_Cartera.ListIndex)
            .StoredProcParam(5) = Trim(Right(Cmb_Libro.Text, 10))
            .StoredProcParam(6) = Trim(Right(Cmb_Area_Responsable.Text, 10))
            .StoredProcParam(7) = GLB_CARTERA_NORMATIVA
            .StoredProcParam(8) = GLB_LIBRO
            .StoredProcParam(9) = GLB_AREA_RESPONSABLE
            .Destination = modi
            .Connect = CONECCION
            .Action = 1
        End With
    Next nContador

'''''    If ch_tip_p.Value = 1 Then
'''''        BAC_INVERSIONES.BacRpt.ReportFileName = RptList_Path & "informe_cartera_vigente.RPT"
'''''        BAC_INVERSIONES.BacRpt.WindowTitle = "INFORME DE CARTERA VIGENTES"
'''''        BAC_INVERSIONES.BacRpt.StoredProcParam(0) = Format(Me.txt_fecha_pro.Text, "YYYYMMDD")
'''''        BAC_INVERSIONES.BacRpt.StoredProcParam(1) = nSuc1
'''''        BAC_INVERSIONES.BacRpt.StoredProcParam(2) = nSuc2
'''''        BAC_INVERSIONES.BacRpt.StoredProcParam(3) = "P"
'''''        BAC_INVERSIONES.BacRpt.StoredProcParam(4) = Cmb_Cartera.ItemData(Cmb_Cartera.ListIndex)
'''''        BAC_INVERSIONES.BacRpt.Destination = modi
'''''        BAC_INVERSIONES.BacRpt.Connect = CONECCION
'''''        BAC_INVERSIONES.BacRpt.Action = 1
'''''    End If
'''''
'''''
'''''    If ch_tipo_n.Value = 1 Then
'''''        BAC_INVERSIONES.BacRpt.ReportFileName = RptList_Path & "informe_cartera_vigente.RPT"
'''''        BAC_INVERSIONES.BacRpt.WindowTitle = "INFORME DE CARTERA VIGENTES"
'''''        BAC_INVERSIONES.BacRpt.StoredProcParam(0) = Format(Me.txt_fecha_pro.Text, "YYYYMMDD")
'''''        BAC_INVERSIONES.BacRpt.StoredProcParam(1) = nSuc1
'''''        BAC_INVERSIONES.BacRpt.StoredProcParam(2) = nSuc2
'''''        BAC_INVERSIONES.BacRpt.StoredProcParam(3) = "T" ''"N"
'''''        BAC_INVERSIONES.BacRpt.StoredProcParam(4) = Cmb_Cartera.ItemData(Cmb_Cartera.ListIndex)
'''''        BAC_INVERSIONES.BacRpt.Destination = modi
'''''        BAC_INVERSIONES.BacRpt.Connect = CONECCION
'''''        BAC_INVERSIONES.BacRpt.Action = 1
'''''    End If
    
End Function

Function Informe_De_Valorizacion(modi)

    Dim nSuc1 As Integer
    Dim nSuc2 As Integer


    If Me.opt_todas.Value = True Then
        nSuc1 = 0
        nSuc2 = 9999
    Else
        nSuc1 = Me.box_unidad.ItemData(Me.box_unidad.ListIndex)
        nSuc2 = Me.box_unidad.ItemData(Me.box_unidad.ListIndex)
    End If

    With BAC_INVERSIONES.BacRpt
        .ReportFileName = RptList_Path & "informe_VALORIZACION_DE_MERCADO.rpt"
        .WindowTitle = "INFORME DE VALORIZACIÓN DE MERCADO"
        .StoredProcParam(0) = Format(Me.txt_fecha_pro.Text, "YYYYMMDD")
        .StoredProcParam(1) = nSuc1
        .StoredProcParam(2) = nSuc2
        .StoredProcParam(3) = GLB_LIBRO
        .StoredProcParam(4) = GLB_CARTERA_NORMATIVA
        .StoredProcParam(5) = GLB_CARTERA
        .StoredProcParam(6) = GLB_AREA_RESPONSABLE
        .StoredProcParam(7) = Trim(Right(Cmb_Libro.Text, 10))
        .StoredProcParam(8) = Trim(Right(Cmb_Cartera_Normativa.Text, 10))
        .StoredProcParam(9) = Trim(Right(Cmb_Cartera.Text, 10))
        .StoredProcParam(10) = Trim(Right(Cmb_Area_Responsable.Text, 10))
    
        .Destination = modi
        .Connect = CONECCION
        .Action = 1
    End With


End Function

Function Informe_Movimiento_de_valuta(modi)

    Dim nSuc1 As Integer
    Dim nSuc2 As Integer
   Dim cartera As String
   
   
   If Trim(Right(Cmb_Cartera.Text, 10)) = "" Then
      cartera = "0"
   Else
      cartera = Trim(Right(Cmb_Cartera.Text, 10))
   End If
   
    If Me.opt_todas.Value = True Then
        nSuc1 = 0
        nSuc2 = 9999
    Else
        nSuc1 = Me.box_unidad.ItemData(Me.box_unidad.ListIndex)
        nSuc2 = Me.box_unidad.ItemData(Me.box_unidad.ListIndex)
    End If

        
'    Informe de valutas
    BAC_INVERSIONES.BacRpt.ReportFileName = RptList_Path & "informe_de_movimiento_de_valuta.rpt"
    BAC_INVERSIONES.BacRpt.WindowTitle = "INFORME DE MOVIMIENTO DE VALUTA"
    BAC_INVERSIONES.BacRpt.StoredProcParam(0) = Format(Me.txt_fecha_pro.Text, "yyyymmdd")
    BAC_INVERSIONES.BacRpt.StoredProcParam(1) = nSuc1
    BAC_INVERSIONES.BacRpt.StoredProcParam(2) = nSuc2
    BAC_INVERSIONES.BacRpt.StoredProcParam(3) = cartera 'Trim(Right(Cmb_Cartera.Text, 10)) 'Cmb_Cartera.ItemData(Cmb_Cartera.ListIndex)
    BAC_INVERSIONES.BacRpt.Destination = modi
    BAC_INVERSIONES.BacRpt.Connect = CONECCION
    BAC_INVERSIONES.BacRpt.Action = 1
    
    
End Function

Function Informe_encaje(Fecha, modi)

    BAC_INVERSIONES.BacRpt.ReportFileName = RptList_Path & "informe_encaje.rpt"
    BAC_INVERSIONES.BacRpt.WindowTitle = "INFORME DE ENCAJE"
    BAC_INVERSIONES.BacRpt.StoredProcParam(0) = Format(Fecha, "YYYYMMDD")
    BAC_INVERSIONES.BacRpt.Destination = modi
    BAC_INVERSIONES.BacRpt.Connect = CONECCION
    BAC_INVERSIONES.BacRpt.Action = 1

End Function

Function informe_movimiento(modi)

    Dim nSuc1 As Integer
    Dim nSuc2 As Integer

    If Me.opt_todas.Value = True Then
        nSuc1 = 0
        nSuc2 = 9999
    Else
        nSuc1 = Me.box_unidad.ItemData(Me.box_unidad.ListIndex)
        nSuc2 = Me.box_unidad.ItemData(Me.box_unidad.ListIndex)
    End If


    BAC_INVERSIONES.BacRpt.ReportFileName = RptList_Path & "Informe_MOVIMIENTO.rpt"
    BAC_INVERSIONES.BacRpt.WindowTitle = "INFORME DE MOVIMIENTO"
    BAC_INVERSIONES.BacRpt.StoredProcParam(0) = Format(Me.txt_fec1.Text, "yyyymmdd")
    BAC_INVERSIONES.BacRpt.StoredProcParam(1) = Format(Me.txt_fec2.Text, "yyyymmdd")
    BAC_INVERSIONES.BacRpt.StoredProcParam(2) = nSuc1
    BAC_INVERSIONES.BacRpt.StoredProcParam(3) = nSuc2
    BAC_INVERSIONES.BacRpt.Destination = modi
    BAC_INVERSIONES.BacRpt.Connect = CONECCION
    BAC_INVERSIONES.BacRpt.Action = 1
    
End Function

Function Informe_Vocher(modi)

    BAC_INVERSIONES.BacRpt.ReportFileName = RptList_Path & "Informe_Voucher.rpt"
    BAC_INVERSIONES.BacRpt.WindowTitle = "INFORME DE VOUCHER CONTABLE"
    BAC_INVERSIONES.BacRpt.StoredProcParam(0) = Format(Me.txt_fecha_pro.Text, "yyyymmdd")
    BAC_INVERSIONES.BacRpt.Destination = modi
    BAC_INVERSIONES.BacRpt.Connect = CONECCION
    BAC_INVERSIONES.BacRpt.Action = 1
    
End Function
Function Informe_Vocher_Consolidado(modi)

    BAC_INVERSIONES.BacRpt.ReportFileName = RptList_Path & "Informe_voucher_consolidado.rpt"
    BAC_INVERSIONES.BacRpt.WindowTitle = "INFORME DE VOUCHER CONTABLE CONSOLIDADO"
    BAC_INVERSIONES.BacRpt.StoredProcParam(0) = Format(Me.txt_fecha_pro.Text, "yyyymmdd")
    BAC_INVERSIONES.BacRpt.Destination = modi
    BAC_INVERSIONES.BacRpt.Connect = CONECCION
    BAC_INVERSIONES.BacRpt.Action = 1
    
End Function


Function Informe_De_Cartera_vigentes_resumen(modi As Integer)

    Dim nSuc1 As Integer
    Dim nSuc2 As Integer
    Dim cTipo As String
    Dim nVeces      As Integer
    Dim nHasta      As Integer
    Dim nContador   As Integer

    If Me.opt_todas.Value = True Then
        nSuc1 = 0
        nSuc2 = 9999
    Else
        nSuc1 = Me.box_unidad.ItemData(Me.box_unidad.ListIndex)
        nSuc2 = Me.box_unidad.ItemData(Me.box_unidad.ListIndex)
    End If

    With Cmb_Cartera_Normativa
        nVeces = IIf(.ListIndex = 0, 1, .ListIndex)
        nHasta = IIf(.ListIndex = 0, .ListCount - 1, .ListIndex)
    End With
    
    For nContador = nVeces To nHasta
        With BAC_INVERSIONES.BacRpt
            .ReportFileName = RptList_Path & "informe_resumen.RPT"
            .WindowTitle = "RESUMEN DE CARTERA"
            .StoredProcParam(0) = Format(Me.txt_fecha_pro.Text, "YYYYMMDD")
            .StoredProcParam(1) = nSuc1
            .StoredProcParam(2) = nSuc2
            .StoredProcParam(3) = Trim(Right(Cmb_Cartera_Normativa.List(nContador), 10))   '"P"
            .StoredProcParam(4) = Trim(Right(Cmb_Cartera.Text, 10)) 'Cmb_Cartera.ItemData(Cmb_Cartera.ListIndex)
            .Destination = modi
            .Connect = CONECCION
            .Action = 1
        End With
    Next nContador

'''''If ch_tip_p.Value = 1 Then
'''''        BAC_INVERSIONES.BacRpt.ReportFileName = RptList_Path & "informe_resumen.RPT"
'''''        BAC_INVERSIONES.BacRpt.WindowTitle = "RESUMEN DE CARTERA"
'''''        BAC_INVERSIONES.BacRpt.StoredProcParam(0) = Format(Me.txt_fecha_pro.Text, "YYYYMMDD")
'''''        BAC_INVERSIONES.BacRpt.StoredProcParam(1) = nSuc1
'''''        BAC_INVERSIONES.BacRpt.StoredProcParam(2) = nSuc2
'''''        BAC_INVERSIONES.BacRpt.StoredProcParam(3) = "P"
'''''        BAC_INVERSIONES.BacRpt.StoredProcParam(4) = Cmb_Cartera.ItemData(Cmb_Cartera.ListIndex)
'''''        BAC_INVERSIONES.BacRpt.Destination = modi
'''''        BAC_INVERSIONES.BacRpt.Connect = CONECCION
'''''        BAC_INVERSIONES.BacRpt.Action = 1
'''''End If
'''''If ch_tipo_n.Value = 1 Then
'''''        BAC_INVERSIONES.BacRpt.ReportFileName = RptList_Path & "informe_resumen.RPT"
'''''        BAC_INVERSIONES.BacRpt.WindowTitle = "RESUMEN DE CARTERA"
'''''        BAC_INVERSIONES.BacRpt.StoredProcParam(0) = Format(Me.txt_fecha_pro.Text, "YYYYMMDD")
'''''        BAC_INVERSIONES.BacRpt.StoredProcParam(1) = nSuc1
'''''        BAC_INVERSIONES.BacRpt.StoredProcParam(2) = nSuc2
'''''        BAC_INVERSIONES.BacRpt.StoredProcParam(3) = "M"
'''''        BAC_INVERSIONES.BacRpt.StoredProcParam(4) = Cmb_Cartera.ItemData(Cmb_Cartera.ListIndex)
'''''        BAC_INVERSIONES.BacRpt.Destination = modi
'''''        BAC_INVERSIONES.BacRpt.Connect = CONECCION
'''''        BAC_INVERSIONES.BacRpt.Action = 1
'''''End If

End Function

Function Informe_vencimientos(modi)

    BAC_INVERSIONES.BacRpt.ReportFileName = RptList_Path & "informe_de_vctos.rpt"
    BAC_INVERSIONES.BacRpt.WindowTitle = "INFORME DE VENCIMIENTOS"
    BAC_INVERSIONES.BacRpt.StoredProcParam(0) = Format(Me.txt_fec1.Text, "yyyymmdd")
    BAC_INVERSIONES.BacRpt.StoredProcParam(1) = Format(Me.txt_fec2.Text, "yyyymmdd")
    BAC_INVERSIONES.BacRpt.Destination = modi
    BAC_INVERSIONES.BacRpt.Connect = CONECCION
    BAC_INVERSIONES.BacRpt.Action = 1

End Function

Function Llena_Combo_Unidades()
    Dim DATOS()
    box_unidad.Clear
    If Bac_Sql_Execute("SVC_GEN_BUS_UNI") Then
        Do While Bac_SQL_Fetch(DATOS)
            box_unidad.AddItem DATOS(2)
            box_unidad.ItemData(box_unidad.NewIndex) = Val(DATOS(1))
        Loop
    End If
End Function

Private Sub box_unidad_Click()
    If box_unidad.ListIndex <> -1 Then
        txt_unidad.Text = Format(Me.box_unidad.ItemData(Me.box_unidad.ListIndex), "000")
    End If
End Sub


Private Sub Form_Load()

    Me.Top = 0
    Me.Left = 0
    
    Call PROC_LLENA_COMBOS(Cmb_Area_Responsable, 1, True, GLB_AREA_RESPONSABLE, GLB_ID_SISTEMA)
    Call PROC_LLENA_COMBOS(Cmb_Cartera, 4, True, "", GLB_CARTERA, GLB_ID_SISTEMA)
    Call PROC_LLENA_COMBOS(Cmb_Cartera_Normativa, 3, True, GLB_CARTERA_NORMATIVA)
    Call PROC_LLENA_COMBOS(Cmb_Libro, 3, True, GLB_LIBRO)
    
    Fr_Cartera_Normativa.Enabled = False
    Fr_Libro.Enabled = False
    Fr_Area_Responsable.Enabled = False

    Me.txt_fecha_pro.Text = Format(gsBac_Fecp, "DD/MM/YYYY")
    Me.Icon = BAC_INVERSIONES.Icon
    Me.txt_fec1.Text = Format(gsBac_Fecp, "DD/MM/YYYY")
    Me.txt_fec2.Text = Format(gsBac_Fecp, "DD/MM/YYYY")
    Me.opt_todas.Value = True
    Me.ch_tipo_n.Value = 1

    Select Case Bac_Informe
    
        Case "TRASC" 'Ok
            Me.frm_fecha_inf.Enabled = False
            Me.frm_tipo_cartera.Enabled = False
            Me.frm_unidad.Enabled = False
            Me.frm_fechas.Enabled = True

'''''            Me.frm_fechas.Top = 750
'''''            Me.Height = Me.frm_fechas.Height + 1300

            Me.fr_Cartera.Enabled = False
            Me.Caption = "Traspaso De Cartera"
            Bac_Informe = "TRASC"

        Case "INFVEN" 'ok
            frm_fecha_inf.Enabled = False
            frm_tipo_cartera.Enabled = False
            frm_unidad.Enabled = False
            Fr_Cartera_Normativa.Enabled = True
            Fr_Libro.Enabled = True
            Fr_Area_Responsable.Enabled = True
            frm_fechas.Enabled = True
            
            Me.Caption = "Informe de Ventas"
            cTipo_Oper = "VPX"

'''''            Me.frm_fechas.Top = 750
'''''            Me.frm_unidad.Top = Me.frm_fechas.Top + Me.frm_fechas.Height + 100
'''''            Me.Height = Me.frm_fechas.Top + Me.frm_fechas.Height + 500
'''''            Me.fr_Cartera.Visible = True
            
        Case "INFCOM" 'ok
            Me.frm_fecha_inf.Enabled = False
            Me.frm_tipo_cartera.Enabled = False
            Me.frm_unidad.Enabled = False
            Me.frm_fechas.Enabled = True
            Fr_Cartera_Normativa.Enabled = True
            Fr_Libro.Enabled = True
            Fr_Area_Responsable.Enabled = True

'''''            Me.frm_fechas.Top = 750
'''''            Me.frm_unidad.Top = Me.frm_fechas.Top + Me.frm_fechas.Height + 100
'''''            Me.Height = Me.frm_fechas.Top + Me.frm_fechas.Height + 500

            Me.fr_Cartera.Enabled = True
            Me.Caption = "Informe de Compras"
            cTipo_Oper = "CPX"
            
        Case "INFCAR"
            Me.frm_fecha_inf.Enabled = False
'''''            Me.frm_tipo_cartera.Enabled = True
            Fr_Cartera_Normativa.Enabled = True
            Me.frm_unidad.Enabled = False
            Me.frm_fechas.Enabled = True

'''''            Me.frm_fechas.Top = 750
'''''            Me.frm_tipo_cartera.Top = Me.frm_fechas.Top + Me.frm_fechas.Height + 100
'''''            Me.frm_unidad.Top = Me.frm_tipo_cartera.Top + Me.frm_tipo_cartera.Height + 100
'''''            Me.Height = Me.frm_tipo_cartera.Top + Me.frm_tipo_cartera.Height + 500

            Bac_Informe = "INFCAR"
            Me.Caption = "Informe de Cartera"
            Me.fr_Cartera.Enabled = False

        Case "INFVALU" 'Ok
            Me.frm_fecha_inf.Enabled = False
'''''            Me.frm_tipo_cartera.Enabled = True
            Me.frm_unidad.Enabled = False
            Me.frm_fechas.Enabled = True

'''''            Me.frm_fechas.Top = 750
'''''            Me.frm_tipo_cartera.Top = Me.frm_fechas.Top + Me.frm_fechas.Height + 100
'''''            Me.frm_unidad.Top = Me.frm_tipo_cartera.Top + Me.frm_tipo_cartera.Height + 100
'''''            Me.Height = Me.frm_tipo_cartera.Top + Me.frm_tipo_cartera.Height + 500

            Bac_Informe = "INFVALU"
            Me.Caption = "Informe de Cartera De Valutas Vigentes"
            Me.fr_Cartera.Enabled = True
            
        Case "INFCARV" 'Ok
            Me.frm_fecha_inf.Enabled = False
'''''            Me.frm_tipo_cartera.Enabled = True
            Fr_Cartera_Normativa.Enabled = True
            Me.frm_unidad.Enabled = False
            Me.frm_fechas.Enabled = True
            Fr_Libro.Enabled = True
            Fr_Area_Responsable.Enabled = True


'''''            Me.frm_fechas.Top = 750
'''''            Me.frm_tipo_cartera.Top = Me.frm_fechas.Top + Me.frm_fechas.Height + 100
'''''            Me.frm_unidad.Top = Me.frm_tipo_cartera.Top + Me.frm_tipo_cartera.Height + 100
'''''            Me.Height = Me.frm_tipo_cartera.Top + Me.frm_tipo_cartera.Height + 500

            Me.txt_fecha_pro.Enabled = True
            Bac_Informe = "INFCARV"
            Me.Caption = "Informe de Cartera Vigentes"
            Me.fr_Cartera.Enabled = True
            
        Case "INFMOV"
            Me.frm_fecha_inf.Enabled = True
            Me.frm_tipo_cartera.Enabled = False
            Me.frm_unidad.Enabled = False
            Me.frm_fechas.Enabled = False

'''''            Me.frm_fecha_inf.Top = 750
'''''            Me.frm_unidad.Top = Me.frm_fecha_inf.Top + Me.frm_fecha_inf.Height + 100
'''''            Me.Height = Me.frm_fecha_inf.Top + Me.frm_fecha_inf.Height + 500
'''''            Bac_Informe = "INFMOV"
'''''            Me.Caption = "Informe de Movimiento"
'''''            Me.fr_Cartera.Visible = True
       Case "INFVAL" 'Ok

            Me.frm_fecha_inf.Enabled = False
            Me.frm_tipo_cartera.Enabled = False
            Me.frm_unidad.Enabled = False
            Me.frm_fechas.Enabled = True
            txt_fecha_pro.Enabled = True
            Fr_Cartera_Normativa.Enabled = True
            Fr_Libro.Enabled = True
            Fr_Area_Responsable.Enabled = True
            Bac_Informe = "INFVAL"
            Me.Caption = "Informe de Valorización de Mercado"
            Me.fr_Cartera.Enabled = True
            
        Case "INFD05"

            Me.frm_fecha_inf.Enabled = False
            Me.frm_tipo_cartera.Enabled = False
            Me.frm_unidad.Enabled = False
            Me.frm_fechas.Enabled = True

'''''            Me.frm_fechas.Top = 750
'''''            Me.Height = Me.frm_fechas.Top + Me.frm_fechas.Height + 500

            Me.Caption = "Informe D05"
            Bac_Informe = "INFD05"
            Me.fr_Cartera.Enabled = False
            
        Case "INFCOMP"
            Me.frm_fecha_inf.Enabled = False
            Me.frm_tipo_cartera.Enabled = False
            Me.frm_unidad.Enabled = False
            Me.frm_fechas.Enabled = True
'''''            Me.Height = Me.frm_fechas.Top + Me.frm_fechas.Height + 500

            Bac_Informe = "INFCOMP"
            Me.Caption = "Compendio de Normas BCCH"
            Me.fr_Cartera.Enabled = False
            
        Case "INFBAS"
            Me.frm_fecha_inf.Enabled = False
            Me.frm_tipo_cartera.Enabled = False
            Me.frm_unidad.Enabled = False
            Me.frm_fechas.Enabled = True

'''''            Me.frm_fechas.Top = 750
'''''            Me.Height = Me.frm_fechas.Top + Me.frm_fechas.Height + 500

            Me.Caption = "Informe de Basilea"
            Bac_Informe = "INFBAS"
            Me.fr_Cartera.Enabled = False
            
        Case "INFENC"
            Me.frm_fecha_inf.Enabled = False
            Me.frm_tipo_cartera.Enabled = False
            Me.frm_unidad.Enabled = False
            Me.frm_fechas.Enabled = True

'''''            Me.frm_fechas.Top = 750
'''''            Me.Height = Me.frm_fechas.Top + Me.frm_fechas.Height + 500

            Bac_Informe = "INFENC"
            Me.Caption = "Informe de Encaje"
            Me.fr_Cartera.Enabled = False
            
        Case "ANUCOM"
            Me.frm_fecha_inf.Enabled = False
            Me.frm_tipo_cartera.Enabled = False
            Me.frm_unidad.Enabled = False
            Me.frm_fechas.Enabled = True

'''''            Me.frm_fechas.Top = 750
'''''            Me.frm_unidad.Top = Me.frm_fechas.Top + Me.frm_fechas.Height + 100
'''''            Me.Height = Me.frm_fechas.Top + Me.frm_fechas.Height + 500

            Me.Caption = "Informe de Anulación de Operaciones"
            Me.fr_Cartera.Enabled = True
            
        Case "ANUVEN"
'''''            Me.frm_unidad.Top = Me.frm_fecha_inf.Top
            Me.frm_fecha_inf.Enabled = False
''''''            Me.frm_unidad.Top = Me.frm_fecha_inf.Top
''''''            Me.Height = 3600
            Me.Caption = "Informe de Anulación de Ventas"
            Me.fr_Cartera.Enabled = False
            
        Case "VENCI"
'''''            Me.frm_fecha_inf.Top = Me.frm_fechas.Top
            Me.frm_fechas.Enabled = False
            Me.frm_unidad.Enabled = False
            Bac_Informe = "VENCI"
'''''            Me.Height = 2100
            Me.Caption = "Informe de Vencimientos"
            Me.fr_Cartera.Enabled = False
            
        Case "INFMVA"
            Bac_Informe = "INFMVA"

            Me.frm_fecha_inf.Enabled = False
            Me.frm_tipo_cartera.Enabled = False
            Me.frm_unidad.Enabled = False
            Me.frm_fechas.Enabled = True
            txt_fecha_pro.Enabled = True
            
'''''            Me.frm_fechas.Top = 750
'''''            Me.frm_unidad.Top = Me.frm_fechas.Top + Me.frm_fechas.Height + 100
'''''            Me.Height = Me.frm_fechas.Top + Me.frm_fechas.Height + 500

            Me.Caption = "Informe de Movimiento de Valuta"
            Me.fr_Cartera.Enabled = True
            
        Case "INFRES" 'Ok
            Me.frm_fecha_inf.Enabled = False
'''''            Me.frm_tipo_cartera.Enabled = True
            Fr_Cartera_Normativa.Enabled = True
            Me.frm_unidad.Enabled = False
            Me.frm_fechas.Enabled = True
            Fr_Libro.Enabled = True
            Fr_Area_Responsable.Enabled = True
            

'''''            Me.frm_fechas.Top = 750
'''''            Me.frm_tipo_cartera.Top = Me.frm_fechas.Top + Me.frm_fechas.Height + 100
'''''            Me.frm_unidad.Top = Me.frm_tipo_cartera.Top + Me.frm_tipo_cartera.Height + 100
'''''            Me.Height = Me.frm_tipo_cartera.Top + Me.frm_tipo_cartera.Height + 500

            Bac_Informe = "INFRES"
            Me.Caption = "Informe Resumen De Cartera"
            Me.fr_Cartera.Enabled = True
            
    Case "INFVOU"
            txt_fecha_pro.Enabled = True
            Me.frm_fecha_inf.Enabled = False
            Me.frm_tipo_cartera.Enabled = False
            Me.frm_unidad.Enabled = False
            Me.frm_fechas.Enabled = True

'''''            Me.frm_fecha_inf.Top = 750
'''''            Me.frm_unidad.Top = Me.frm_fecha_inf.Top + Me.frm_fecha_inf.Height + 100
'''''            Me.Height = Me.frm_fecha_inf.Top + Me.frm_fecha_inf.Height + 500

            Bac_Informe = "INFVOU"
            Me.Caption = "Informe Voucher Contable"
            Me.fr_Cartera.Enabled = False
            
    Case "INFVOUCONS"
            txt_fecha_pro.Enabled = True
            Me.frm_fecha_inf.Enabled = False
            Me.frm_tipo_cartera.Enabled = False
            Me.frm_unidad.Enabled = False
            Me.frm_fechas.Enabled = True

'''''            Me.frm_fecha_inf.Top = 750
'''''            Me.frm_unidad.Top = Me.frm_fecha_inf.Top + Me.frm_fecha_inf.Height + 100
'''''            Me.Height = Me.frm_fecha_inf.Top + Me.frm_fecha_inf.Height + 500
            
            Bac_Informe = "INFVOUCONS"
            Me.Caption = "Informe Voucher Contable Consolidado"
            Me.fr_Cartera.Enabled = False
    End Select

    Set objSucursales = New clsSucursales

    Call Llena_Combo_Unidades
    ''''Func_Cartera Cmb_Cartera, "BEX"
    
    Cmb_Cartera.Enabled = fr_Cartera.Enabled
    Cmb_Cartera_Normativa.Enabled = Fr_Cartera_Normativa.Enabled
    Cmb_Libro.Enabled = Fr_Libro.Enabled
    Cmb_Area_Responsable.Enabled = Fr_Area_Responsable.Enabled
    
    txt_fec1.Enabled = frm_fecha_inf.Enabled
    txt_fec2.Enabled = frm_fecha_inf.Enabled
    
    opt_todas.Enabled = frm_unidad.Enabled
    opt_una.Enabled = frm_unidad.Enabled
    box_unidad.Enabled = frm_unidad.Enabled

End Sub

Private Sub Fr_Cartera_Normativa_Click()
    If Fr_Cartera_Normativa.Enabled = False Then
        Cmb_Cartera_Normativa.Enabled = False
    End If
End Sub

Private Sub opt_todas_Click()
    Op = 1
    Me.box_unidad.ListIndex = -1
    Me.txt_unidad.Text = "    "
    Me.box_unidad.Enabled = False
    Me.txt_unidad.Enabled = False
End Sub

Private Sub opt_una_Click()
    Op = 2
    Me.box_unidad.Enabled = True
    Me.txt_unidad.Enabled = True
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
    Select Case Button.Index
        Case 1
            Call Evalua_Reportes(0)
        Case 2
            Call Evalua_Reportes(1)
        Case 3
            Unload Me
    End Select
End Sub

Function Evalua_Reportes(modi As Integer)
 
    Dim tipo_cartera

    If frm_fechas.Visible = True Then
        If Me.txt_fecha_pro.Text = "  /  /    " Then
            MsgBox "Falta Ingresar fecha De Proceso", vbExclamation, gsBac_Version
            Me.txt_fecha_pro.SetFocus
            Exit Function
        End If
    End If

    If frm_unidad.Visible = True Then
        If Me.txt_unidad.Text = " " Then
            MsgBox "Falta Ingresar Sucursal", vbExclamation, gsBac_Version
            Me.txt_unidad.SetFocus
            Exit Function
        End If
    End If

    If frm_tipo_cartera.Visible = True Then
        If Me.ch_tip_p.Value = 0 And Me.ch_tipo_n.Value = 0 Then
            MsgBox "Debe Elejir Al Menos Un Tipo De Cartera", vbExclamation, gsBac_Version
            Me.ch_tipo_n.SetFocus
            Exit Function
        End If
    End If

    If frm_fecha_inf.Visible = True Then
        If Me.txt_fec1.Text = "  /  /    " Or Me.txt_fec2.Text = "  /  /    " Then
            MsgBox "Falta Ingresar fechas Parametros ", vbExclamation, gsBac_Version
             Me.txt_fec1.SetFocus
            Exit Function
        End If
    End If

    Screen.MousePointer = vbHourglass

    Call limpiar_cristal

    Select Case Bac_Informe

        Case "INFVEN"
            Call Informe_Compras_del_dia("VP", modi)
            
        Case "INFCOM"
            Call Informe_Compras_del_dia("CP", modi)

        Case "INFMVA"
            Call Informe_Movimiento_de_valuta(modi)

        Case "INFMOV"
            Call informe_movimiento(modi)

        Case "ANUCOM"
            Call Informe_Anulacion_Oper(modi)
    'Desde aquí se modifico
        Case "INFCARV" 'Ok
            Informe_De_Cartera_vigentes ((modi)) 'Ok

        Case "INFRES" 'Ok
            Informe_De_Cartera_vigentes_resumen (modi) 'ok
    
        Case "INFVAL"
            Informe_De_Valorizacion (modi)
    
        Case "INFVALU"
            Informe_De_Cartera_valutas_vigentes (modi)
        
        Case "TRASC"
            informe_traspaso_cartera (modi)
    
        Case "INFD05"
            Call Informe_D05(modi)

        Case "INFBAS"
            Call Informe_basliea(Me.txt_fecha_pro.Text, modi)

        Case "INFENC"
            Call Informe_encaje(Me.txt_fecha_pro.Text, modi)

        Case "INFCOMP"
             Call Informe_compendio(Me.txt_fecha_pro.Text, modi)

        Case "VENCI"
             Informe_vencimientos (modi)

        Case "INFVOU"
            Call Informe_Vocher(modi)

        Case "INFVOUCONS"
            Call Informe_Vocher_Consolidado(modi)
        
    End Select

    Screen.MousePointer = vbDefault

    Call limpiar_cristal

'    Unload Me

End Function

Function informe_traspaso_cartera(modi)

    BAC_INVERSIONES.BacRpt.ReportFileName = RptList_Path & "informe_traspaso_cartera.rpt"
    BAC_INVERSIONES.BacRpt.WindowTitle = "INFORME TRASPASO DE CARTERA"
    BAC_INVERSIONES.BacRpt.StoredProcParam(0) = Format(Me.txt_fecha_pro.Text, "YYYYMMDD")
    BAC_INVERSIONES.BacRpt.Destination = modi
    BAC_INVERSIONES.BacRpt.Connect = CONECCION
    BAC_INVERSIONES.BacRpt.Action = 1

End Function

Private Sub txt_unidad_KeyPress(KeyAscii As Integer)
     Dim k As Integer
    Dim i As Integer
    Dim sw As Boolean
    
    sw = False
    
    k = KeyAscii
    
    If (k > 47 And k < 58) Or k = 13 Or k = 8 Then
    
    If k = 13 Then
    
        For i = 0 To Me.box_unidad.ListCount - 1
        If IsNumeric(Me.txt_unidad.Text) Then
            If Me.box_unidad.ItemData(i) = Me.txt_unidad.Text Then
        
                Me.box_unidad.ListIndex = i
                Exit For
            End If
        Else
                Me.box_unidad.ListIndex = -1
                Me.txt_unidad.Text = ""
            
       End If
                    
        Next i
        
    End If
    
    Else
    
    k = 0
    Exit Sub
    
    End If

End Sub


