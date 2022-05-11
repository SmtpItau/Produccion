VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.2#0"; "mscomctl.ocx"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form Ingreso_captaciones 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Ingreso Captaciones"
   ClientHeight    =   4965
   ClientLeft      =   1950
   ClientTop       =   3930
   ClientWidth     =   11070
   Icon            =   "Capta.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4965
   ScaleWidth      =   11070
   Tag             =   "IC"
   Begin Threed.SSCommand SSC_Limpiar 
      Height          =   450
      Left            =   1260
      TabIndex        =   14
      Top             =   5520
      Width           =   1200
      _Version        =   65536
      _ExtentX        =   2117
      _ExtentY        =   794
      _StockProps     =   78
      Caption         =   "&Limpiar"
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   3
   End
   Begin Threed.SSCommand SSC_Grabar 
      Height          =   450
      Left            =   0
      TabIndex        =   15
      Top             =   5520
      Width           =   1200
      _Version        =   65536
      _ExtentX        =   2117
      _ExtentY        =   794
      _StockProps     =   78
      Caption         =   "&Grabar"
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   3
   End
   Begin VB.Frame Frame3 
      Caption         =   "Detalle Operación"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00C00000&
      Height          =   2955
      Left            =   45
      TabIndex        =   17
      Top             =   2010
      Width           =   11010
      Begin VB.TextBox Txt_ingreso 
         BorderStyle     =   0  'None
         ForeColor       =   &H00FF0000&
         Height          =   345
         Left            =   1455
         TabIndex        =   22
         Text            =   "Text1"
         Top             =   3285
         Visible         =   0   'False
         Width           =   1185
      End
      Begin BACControles.TXTNumero text1 
         Height          =   195
         Left            =   2085
         TabIndex        =   10
         TabStop         =   0   'False
         Top             =   525
         Visible         =   0   'False
         Width           =   900
         _ExtentX        =   1588
         _ExtentY        =   344
         BackColor       =   -2147483635
         ForeColor       =   -2147483634
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BorderStyle     =   0
         Text            =   "0"
         Text            =   "0"
         Max             =   "9999999999.9999"
         Separator       =   -1  'True
      End
      Begin MSFlexGridLib.MSFlexGrid gr_cortes 
         Height          =   2295
         Left            =   60
         TabIndex        =   9
         Top             =   210
         Width           =   10890
         _ExtentX        =   19209
         _ExtentY        =   4048
         _Version        =   393216
         Cols            =   8
         FixedCols       =   0
         BackColor       =   -2147483633
         BackColorFixed  =   -2147483646
         ForeColorFixed  =   16777215
         BackColorBkg    =   -2147483644
         GridColor       =   -2147483636
         GridColorFixed  =   -2147483636
         FocusRect       =   0
         GridLines       =   2
         GridLinesFixed  =   1
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin VB.Label Lbl_Monto_Final 
         Alignment       =   1  'Right Justify
         BorderStyle     =   1  'Fixed Single
         Caption         =   "0"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   315
         Left            =   7845
         TabIndex        =   13
         Top             =   2550
         Width           =   1950
      End
      Begin VB.Label Lbl_Monto_Inicio_pesos 
         Alignment       =   1  'Right Justify
         BorderStyle     =   1  'Fixed Single
         Caption         =   "0"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   315
         Left            =   3840
         TabIndex        =   11
         Top             =   2550
         Width           =   1980
      End
      Begin VB.Label Lbl_Monto_inicio 
         Alignment       =   1  'Right Justify
         BorderStyle     =   1  'Fixed Single
         Caption         =   "0"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   315
         Left            =   5850
         TabIndex        =   12
         Top             =   2550
         Width           =   1980
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   495
      Left            =   0
      TabIndex        =   28
      Top             =   0
      Width           =   11070
      _ExtentX        =   19526
      _ExtentY        =   873
      ButtonWidth     =   847
      ButtonHeight    =   820
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   1
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbgrabar"
            Description     =   "GRABAR"
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmblimpiar"
            Description     =   "LIMPIAR"
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Cerrar"
            Description     =   "CERRAR"
            Object.ToolTipText     =   "Cerrar"
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   8745
         Top             =   30
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   25
         ImageHeight     =   25
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   3
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Capta.frx":030A
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Capta.frx":075C
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Capta.frx":0A76
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame Frm_fechas 
      Caption         =   "Datos Captación"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00C00000&
      Height          =   1545
      Left            =   45
      TabIndex        =   16
      Top             =   480
      Width           =   9930
      Begin VB.ComboBox cmbCondicion 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         ItemData        =   "Capta.frx":0D90
         Left            =   135
         List            =   "Capta.frx":0D97
         Style           =   2  'Dropdown List
         TabIndex        =   7
         Top             =   1080
         Width           =   3180
      End
      Begin VB.ComboBox cmbTipoEmision 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         ItemData        =   "Capta.frx":0DA9
         Left            =   3315
         List            =   "Capta.frx":0DB0
         Style           =   2  'Dropdown List
         TabIndex        =   8
         Top             =   1080
         Width           =   6480
      End
      Begin BACControles.TXTNumero Flt_TasaTran 
         Height          =   315
         Left            =   4650
         TabIndex        =   4
         Top             =   435
         Width           =   975
         _ExtentX        =   1720
         _ExtentY        =   556
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0,0000"
         Text            =   "0,0000"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTFecha Msk_Fecha_Vcto 
         Height          =   315
         Left            =   3315
         TabIndex        =   3
         Top             =   435
         Width           =   1335
         _ExtentX        =   2355
         _ExtentY        =   556
         Enabled         =   -1  'True
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "18/11/2000"
      End
      Begin BACControles.TXTNumero Txt_Dias 
         Height          =   315
         Left            =   2610
         TabIndex        =   2
         Top             =   435
         Width           =   675
         _ExtentX        =   1191
         _ExtentY        =   556
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0"
         Text            =   "0"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTNumero Msk_Tasa 
         Height          =   315
         Left            =   135
         TabIndex        =   0
         Top             =   435
         Width           =   1095
         _ExtentX        =   1931
         _ExtentY        =   556
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0,0000"
         Text            =   "0,0000"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
      End
      Begin VB.ComboBox Cmb_Tipo_Deposito 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         ItemData        =   "Capta.frx":0DC4
         Left            =   7545
         List            =   "Capta.frx":0DCB
         Style           =   2  'Dropdown List
         TabIndex        =   6
         Top             =   435
         Width           =   2265
      End
      Begin VB.ComboBox Cmb_Custodia 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         ItemData        =   "Capta.frx":0DE2
         Left            =   5640
         List            =   "Capta.frx":0DE9
         Style           =   2  'Dropdown List
         TabIndex        =   5
         Top             =   435
         Width           =   1905
      End
      Begin VB.ComboBox Cmb_Moneda 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   1230
         Style           =   2  'Dropdown List
         TabIndex        =   1
         Top             =   435
         Width           =   1380
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Condición"
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
         Left            =   165
         TabIndex        =   27
         Top             =   870
         Width           =   810
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Tipo Emisión"
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
         Left            =   3315
         TabIndex        =   26
         Top             =   870
         Width           =   1050
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Tipo Deposito"
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
         Left            =   7560
         TabIndex        =   25
         Top             =   225
         Width           =   1155
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Custodia"
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
         Left            =   5655
         TabIndex        =   24
         Top             =   225
         Width           =   735
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Tasa Tran."
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
         Left            =   4635
         TabIndex        =   23
         Top             =   225
         Width           =   885
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Vencimiento"
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
         Left            =   3315
         TabIndex        =   21
         Top             =   225
         Width           =   1050
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
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
         Height          =   195
         Index           =   5
         Left            =   1275
         TabIndex        =   20
         Top             =   220
         Width           =   675
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Plazo "
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
         Left            =   2640
         TabIndex        =   19
         Top             =   225
         Width           =   495
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Tasa"
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
         Left            =   120
         TabIndex        =   18
         Top             =   220
         Width           =   405
      End
   End
End
Attribute VB_Name = "Ingreso_captaciones"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Const C_CORTES = 1
Const C_MONTO_CORTE = 2
Const C_MONTO_CORTE_FINAL = 3
Const C_MONTO_INICIO_PESOS = 4
Const C_MONTO_INICIO = 5
Const C_MONTO_FINAL = 6

Dim varssql             As String
Dim varvData()          As Variant
Dim bControl            As Boolean
Dim bFlagEdit           As Boolean
Dim DiasMin             As Integer
Dim DiasVal             As Integer
Dim cFormato            As String
Dim Mon                 As Integer

'+++cvegasan 2017.10.03 [CORRECCION] - Pantalla de Captaciones CLP =0 Dec / UF = 4 Dec / DO = 2 Dec.
Const cFormato_Pesos As String = "#,###,##0"
'--cvegasan 2017.10.03 [CORRECCION] - Pantalla de Captaciones CLP =0 Dec / UF = 4 Dec / DO = 2 Dec.
Public bValTasaPact     As Boolean
Public bValTasaEmision  As Boolean

   
Private Sub Formatos()

    '+++cvegasan 2017.10.03 [CORRECCION] - Pantalla de Captaciones CLP =0 Dec / UF = 4 Dec / DO = 2 Dec.
    Select Case Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex)
        Case 999:
            cFormato = "#,###,##0"
        Case 998:
'+++fmo 20180913 ingreso decimales moneda USD
            cFormato = "#,###,##0.0000" ' vb 16-11-2018 pedido por Camilo pino
'---fmo 20180913 ingreso decimales moneda USD
        Case 13, 994, 995:
            cFormato = "#,###,##0.00"
    End Select
    '---cvegasan 2017.10.03 [CORRECCION] - Pantalla de Captaciones CLP =0 Dec / UF = 4 Dec / DO = 2 Dec.
        
    If Mid(Cmb_Moneda.text, 1, 3) = gsBac_Dolar Or Mid(Cmb_Moneda.text, 1, 2) = "DO" Or Mid(Cmb_Moneda.text, 1, 3) = "DA" Then
        'cFormato = "#,###,##0.0000"
        '+++cvegasan 2017.10.03 [CORRECCION] - Pantalla de Captaciones CLP =0 Dec / UF = 4 Dec / DO = 2 Dec.
        'cFormato = "#,###,##0.00"
        '---cvegasan 2017.10.03 [CORRECCION] - Pantalla de Captaciones CLP =0 Dec / UF = 4 Dec / DO = 2 Dec.
        gr_cortes.Row = 0
        gr_cortes.TextMatrix(gr_cortes.Row, C_MONTO_CORTE) = "Monto Corte " + Trim(Mid(Cmb_Moneda.text, 1, 3)) '+ gsBac_Dolar
        gr_cortes.TextMatrix(gr_cortes.Row, C_MONTO_INICIO_PESOS) = "Valor Inicial " + Trim(Mid(Cmb_Moneda.text, 1, 3))  'gsBac_Dolar
           
        For y = 1 To gr_cortes.Rows - 1
            '+++cvegasan 2017.10.03 [CORRECCION] - Pantalla de Captaciones CLP =0 Dec / UF = 4 Dec / DO = 2 Dec.
            'gr_cortes.TextMatrix(y, C_MONTO_CORTE) = Format(gr_cortes.TextMatrix(y, C_MONTO_CORTE), cFormato)
            'gr_cortes.TextMatrix(y, C_MONTO_INICIO_PESOS) = Format(gr_cortes.TextMatrix(y, C_MONTO_INICIO_PESOS), cFormato)
'+++fmo 20180718 ingreso decimales moneda USD
            If Me.Cmb_Moneda.text = "USD" Then
                gr_cortes.TextMatrix(y, C_MONTO_CORTE) = Format(gr_cortes.TextMatrix(y, C_MONTO_CORTE), cFormato)
            Else
                gr_cortes.TextMatrix(y, C_MONTO_CORTE) = Format(gr_cortes.TextMatrix(y, C_MONTO_CORTE), cFormato_Pesos)
            End If
'---fmo 20180718 ingreso decimales moneda USD
            
            Select Case Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex)
                Case 13: gr_cortes.TextMatrix(y, C_MONTO_INICIO_PESOS) = Format(gr_cortes.TextMatrix(y, C_MONTO_INICIO_PESOS), cFormato)
                Case Else:
                        gr_cortes.TextMatrix(y, C_MONTO_INICIO_PESOS) = Format(gr_cortes.TextMatrix(y, C_MONTO_INICIO_PESOS), cFormato_Pesos)
            End Select
            '---cvegasan 2017.10.03 [CORRECCION] - Pantalla de Captaciones CLP =0 Dec / UF = 4 Dec / DO = 2 Dec.
            gr_cortes.TextMatrix(y, C_MONTO_CORTE_FINAL) = Format(gr_cortes.TextMatrix(y, C_MONTO_CORTE_FINAL), cFormato)
            gr_cortes.TextMatrix(y, C_MONTO_FINAL) = Format(gr_cortes.TextMatrix(y, C_MONTO_FINAL), cFormato)
            gr_cortes.TextMatrix(y, C_MONTO_INICIO) = Format(gr_cortes.TextMatrix(y, C_MONTO_INICIO), cFormato)
        Next y
        
        If Mid(Cmb_Moneda.text, 1, 2) = "DO" Or Mid(Cmb_Moneda.text, 1, 3) = "DA" Then
            gr_cortes.Row = 0
            gr_cortes.TextMatrix(gr_cortes.Row, C_MONTO_CORTE) = "Monto Corte $$"
            gr_cortes.TextMatrix(gr_cortes.Row, C_MONTO_INICIO_PESOS) = "Valor Inicial $$"
'             '+++jcamposd 20170512
'                gr_cortes.TextMatrix(gr_cortes.Row, C_MONTO_CORTE_FINAL) = "Monto Corte Final " + Trim(Mid(Cmb_Moneda.text, 1, 3))
'                gr_cortes.TextMatrix(gr_cortes.Row, C_MONTO_INICIO) = "Valor Inicial " + Trim(Mid(Cmb_Moneda.text, 1, 3))
'                gr_cortes.TextMatrix(gr_cortes.Row, C_MONTO_FINAL) = "Valor Final " + Trim(Mid(Cmb_Moneda.text, 1, 3))
'
'            '---jcamposd 20170512
            
            For y = 1 To gr_cortes.Rows - 1
                '+++cvegasan 2017.10.03 [CORRECCION] - Pantalla de Captaciones CLP =0 Dec / UF = 4 Dec / DO = 2 Dec.
                'gr_cortes.TextMatrix(y, C_MONTO_INICIO_PESOS) = Format(gr_cortes.TextMatrix(y, C_MONTO_INICIO_PESOS), "#,###,##0")
                Select Case Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex)
                    Case 13: gr_cortes.TextMatrix(y, C_MONTO_INICIO_PESOS) = Format(gr_cortes.TextMatrix(y, C_MONTO_INICIO_PESOS), cFormato)
                    Case Else:
                        gr_cortes.TextMatrix(y, C_MONTO_INICIO_PESOS) = Format(gr_cortes.TextMatrix(y, C_MONTO_INICIO_PESOS), cFormato_Pesos)
                End Select
                '---cvegasan 2017.10.03 [CORRECCION] - Pantalla de Captaciones CLP =0 Dec / UF = 4 Dec / DO = 2 Dec.
            Next y
        End If
           
    ElseIf Mid(Cmb_Moneda.text, 1, 2) = "$$" Or Mid(Cmb_Moneda.text, 1, 3) = "CLP" Then '--+++jcamposd se suma como CLP
        '+++cvegasan 2017.10.03 [CORRECCION] - Pantalla de Captaciones CLP =0 Dec / UF = 4 Dec / DO = 2 Dec.
        'cFormato = "#,###,##0"
        gr_cortes.Row = 0
        '---cvegasan 2017.10.03 [CORRECCION] - Pantalla de Captaciones CLP =0 Dec / UF = 4 Dec / DO = 2 Dec.
        gr_cortes.TextMatrix(gr_cortes.Row, C_MONTO_CORTE) = "Monto Corte $$"
        gr_cortes.TextMatrix(gr_cortes.Row, C_MONTO_INICIO_PESOS) = "Valor Inicial $$"
        
        For y = 1 To gr_cortes.Rows - 1
            gr_cortes.TextMatrix(y, C_MONTO_CORTE) = Format(gr_cortes.TextMatrix(y, C_MONTO_CORTE), cFormato)
            '+++cvegasan 2017.10.03 [CORRECCION] - Pantalla de Captaciones CLP =0 Dec / UF = 4 Dec / DO = 2 Dec.
            'gr_cortes.TextMatrix(y, C_MONTO_INICIO_PESOS) = Format(gr_cortes.TextMatrix(y, C_MONTO_INICIO_PESOS), cFormato)
            Select Case Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex)
                Case 13: gr_cortes.TextMatrix(y, C_MONTO_INICIO_PESOS) = Format(gr_cortes.TextMatrix(y, C_MONTO_INICIO_PESOS), cFormato)
                Case Else:
                        gr_cortes.TextMatrix(y, C_MONTO_INICIO_PESOS) = Format(gr_cortes.TextMatrix(y, C_MONTO_INICIO_PESOS), cFormato_Pesos)
            End Select
            '---cvegasan 2017.10.03 [CORRECCION] - Pantalla de Captaciones CLP =0 Dec / UF = 4 Dec / DO = 2 Dec.
            gr_cortes.TextMatrix(y, C_MONTO_CORTE_FINAL) = Format(gr_cortes.TextMatrix(y, C_MONTO_CORTE_FINAL), cFormato)
            gr_cortes.TextMatrix(y, C_MONTO_FINAL) = Format(gr_cortes.TextMatrix(y, C_MONTO_FINAL), cFormato)
            gr_cortes.TextMatrix(y, C_MONTO_INICIO) = Format(gr_cortes.TextMatrix(y, C_MONTO_INICIO), cFormato)
        Next y
    
    ElseIf Mid(Cmb_Moneda.text, 1, 2) = "UF" Then
        '+++cvegasan 2017.10.03 [CORRECCION] - Pantalla de Captaciones CLP =0 Dec / UF = 4 Dec / DO = 2 Dec.
        'cFormato = "#,###,##0.0000"
        '---cvegasan 2017.10.03 [CORRECCION] - Pantalla de Captaciones CLP =0 Dec / UF = 4 Dec / DO = 2 Dec.
        gr_cortes.Row = 0
        gr_cortes.TextMatrix(gr_cortes.Row, C_MONTO_CORTE) = "Monto Corte $$"
        gr_cortes.TextMatrix(gr_cortes.Row, C_MONTO_INICIO_PESOS) = "Valor Inicial $$"
'        '+++jcamposd 20170512
'        gr_cortes.TextMatrix(gr_cortes.Row, C_MONTO_CORTE_FINAL) = "Monto Corte Final " + Trim(Mid(Cmb_Moneda.text, 1, 3))
'        gr_cortes.TextMatrix(gr_cortes.Row, C_MONTO_INICIO) = "Valor Inicial " + Trim(Mid(Cmb_Moneda.text, 1, 3))
'        gr_cortes.TextMatrix(gr_cortes.Row, C_MONTO_FINAL) = "Valor Final " + Trim(Mid(Cmb_Moneda.text, 1, 3))
'
'        '---jcamposd 20170512
        For y = 1 To gr_cortes.Rows - 1
            '+++cvegasan 2017.10.03 [CORRECCION] - Pantalla de Captaciones CLP =0 Dec / UF = 4 Dec / DO = 2 Dec.
            'gr_cortes.TextMatrix(y, C_MONTO_CORTE) = Format(gr_cortes.TextMatrix(y, C_MONTO_CORTE), cFormato)
            'gr_cortes.TextMatrix(y, C_MONTO_INICIO_PESOS) = Format(gr_cortes.TextMatrix(y, C_MONTO_INICIO_PESOS), cFormato)
            gr_cortes.TextMatrix(y, C_MONTO_CORTE) = Format(gr_cortes.TextMatrix(y, C_MONTO_CORTE), cFormato_Pesos)
             Select Case Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex)
                Case 13: gr_cortes.TextMatrix(y, C_MONTO_INICIO_PESOS) = Format(gr_cortes.TextMatrix(y, C_MONTO_INICIO_PESOS), sFormato)
                Case Else:
                        gr_cortes.TextMatrix(y, C_MONTO_INICIO_PESOS) = Format(gr_cortes.TextMatrix(y, C_MONTO_INICIO_PESOS), cFormato_Pesos)
            End Select
            '---cvegasan 2017.10.03 [CORRECCION] - Pantalla de Captaciones CLP =0 Dec / UF = 4 Dec / DO = 2 Dec.
            gr_cortes.TextMatrix(y, C_MONTO_CORTE_FINAL) = Format(gr_cortes.TextMatrix(y, C_MONTO_CORTE_FINAL), cFormato)
            gr_cortes.TextMatrix(y, C_MONTO_FINAL) = Format(gr_cortes.TextMatrix(y, C_MONTO_FINAL), cFormato)
            gr_cortes.TextMatrix(y, C_MONTO_INICIO) = Format(gr_cortes.TextMatrix(y, C_MONTO_INICIO), cFormato)
        Next y
    End If
    'Else
        'cFormato = "#,###,##0"
        gr_cortes.Row = 0
        gr_cortes.TextMatrix(gr_cortes.Row, C_MONTO_CORTE_FINAL) = "Monto Corte Final " + Trim(Mid(Cmb_Moneda.text, 1, 3))
        gr_cortes.TextMatrix(gr_cortes.Row, C_MONTO_INICIO) = "Valor Inicial " + Trim(Mid(Cmb_Moneda.text, 1, 3))
        gr_cortes.TextMatrix(gr_cortes.Row, C_MONTO_FINAL) = "Valor Final " + Trim(Mid(Cmb_Moneda.text, 1, 3))
        gr_cortes.Row = 1
    'End If
    

End Sub

Sub PROC_CREA_GRILLA()

    gr_cortes.cols = 7
    gr_cortes.Rows = 2

    Call TextMatrix(gr_cortes, 0, C_CORTES, "Cortes")
    Call TextMatrix(gr_cortes, 0, C_MONTO_CORTE, "Monto Corte")
    Call TextMatrix(gr_cortes, 0, C_MONTO_INICIO, "Monto Inicio UM")
    Call TextMatrix(gr_cortes, 0, C_MONTO_INICIO_PESOS, "Monto Inicio $")
    Call TextMatrix(gr_cortes, 0, C_MONTO_FINAL, "Monto Final UM")
    
    gr_cortes.ColWidth(C_CORTES) = 600
    gr_cortes.ColWidth(C_MONTO_CORTE) = 1500
    gr_cortes.ColWidth(C_MONTO_INICIO) = 2100
    gr_cortes.ColWidth(C_MONTO_INICIO_PESOS) = 2200
    gr_cortes.ColWidth(C_MONTO_FINAL) = 2200
    gr_cortes.ColWidth(C_MONTO_CORTE_FINAL) = 2000

    gr_cortes.Refresh

    gr_cortes.Row = 0
    gr_cortes.Col = C_CORTES
    gr_cortes.Col = C_MONTO_CORTE
    gr_cortes.Col = C_MONTO_INICIO
    
    Call TextMatrix(gr_cortes, 0, C_MONTO_INICIO, "Monto Inicio " + Trim(Mid(Cmb_Moneda.text, 1, 4)))
    
    gr_cortes.Col = C_MONTO_INICIO_PESOS
    gr_cortes.Col = C_MONTO_FINAL
    
    Call TextMatrix(gr_cortes, 0, C_MONTO_FINAL, "Monto Final " + Trim(Mid(Cmb_Moneda.text, 1, 3)))
End Sub

Function TextMatrix(GRILLA As Control, Fila As Integer, Columna As Integer, Dato As Variant) As Variant
    
    fil_g% = GRILLA.Row
    col_g% = GRILLA.Col

    GRILLA.Row = Fila
    GRILLA.Col = Columna

    If Dato = "X" Then
       TextMatrix = GRILLA.text
    Else
       GRILLA.text = Dato
    End If

    GRILLA.Row = fil_g%
    GRILLA.Col = col_g%

End Function

Sub Proc_Limpia_Pantalla()

    Call PROC_CREA_GRILLA
    
    gr_cortes.Enabled = False 'hipolito
    Msk_Tasa.text = 0
    Txt_Dias.text = 0
    Flt_TasaTran.text = 0
    
    Cmb_Moneda.ListIndex = 0
    For i% = 0 To Cmb_Moneda.ListCount - 1
        If Mid(Cmb_Moneda.List(i%), 1, 1) = "$" Then
           Cmb_Moneda.ListIndex = i%
           Exit For
        End If
    Next i%
        
    If gr_cortes.Rows > 2 Then
        For nRow = 1 To gr_cortes.Rows - 1
            gr_cortes.Row = nRow
            gr_cortes.RemoveItem gr_cortes.Row
        Next nRow
    
        gr_cortes.AddItem ""
        Table1.Rows = gr_cortes.Rows - 1
    Else
        Call TextMatrix(gr_cortes, 1, 1, "")
        Call TextMatrix(gr_cortes, 1, 2, "")
        Call TextMatrix(gr_cortes, 1, 3, "")
        Call TextMatrix(gr_cortes, 1, 4, "")
        Call TextMatrix(gr_cortes, 1, 5, "")
        Call TextMatrix(gr_cortes, 1, 6, "")
    End If
    
    Cmb_Tipo_Deposito.ListIndex = 0
    
    Lbl_Monto_inicio.Caption = ""
    Lbl_Monto_Inicio_pesos.Caption = ""
    Lbl_Monto_Final.Caption = ""
    
End Sub

Private Sub Cmb_Custodia_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
       Cmb_Tipo_Deposito.SetFocus
    End If
End Sub

Private Sub Cmb_Moneda_Change()
    Mon = Cmb_Moneda.ListIndex
End Sub

Private Sub Cmb_Moneda_Click()
    Dim lsMask$
    Dim y       As Integer
    
    cFormato = "#,###,##0"

    If bControl Then
        Call Proc_Calcula_Captacion(0)
    Else
        Call BaseCalculo
    End If
    
    DiasVal = DiasMin
    
    Do While True
        Msk_Fecha_Vcto.text = Format(DateAdd("d", DiasVal, gsBac_Fecp), "dd/mm/yyyy")
        
        If Not EsFeriado(Msk_Fecha_Vcto.text, "00001") Then
            Exit Do
        End If

        DiasVal = DiasVal + 1
    Loop
    
    Txt_Dias.text = DiasVal
            
    Call funcFindDatGralMoneda(Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex))
    
    SwMx = BacDatGrMon.mnmx

    If bControl Then
        Proc_Calcula_Captacion (0)
    End If
End Sub

Private Sub Cmb_Moneda_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        Sendkeys "{TAB}"
    End If
End Sub

Private Sub Cmb_Tipo_Deposito_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        gr_cortes.SetFocus
        Sendkeys "{DOWN}"
    End If
End Sub

Private Sub Flt_Tasatran_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        Sendkeys "{TAB}"
    End If
End Sub

Private Sub Form_Activate()
    Tipo_Operacion = "IC"
End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        Sendkeys "{TAB}"
    End If
End Sub

Private Sub Flt_TasaTran_LostFocus()

    '+++jcamposd 20170512
    If BacCtrlTransMonto(Flt_TasaTran.text) < 0 Then
       Call MsgBox("Tasa tranferencia debe ser positiva.", vbExclamation, App.Title)
       Call TOOLLIMPIAR
       Exit Sub
    End If
    '---jcamposd 20170512

    '''''''''
    If Me.Txt_Dias.text > 0 And Me.Flt_TasaTran.text > 0 And Me.Msk_Tasa.text > 0 Then
       ' If fx_ControlTasaMercado_Trasferencia = False Then
         '   Call DesplegarMensajes
       ' End If
        
         If Not Proc_Valida_Tasa_Transferencia(CDbl(Msk_Tasa.text), CDbl(Flt_TasaTran.text)) Then
            'se omite enviar desde aqui mensaje ya que lo envia la funcion de validacion
        End If
    End If
    
End Sub


Private Sub Form_Load()
    
    bControl = False

    Me.Left = 0
    Me.Top = 0

    Screen.MousePointer = vbHourglass

    gr_cortes.ColWidth(0) = 0

    If Not funcFindMoneda(Cmb_Moneda, "IC") Then
        Exit Sub
    End If

    Call Fx_Load_Data("CONDICION", Me.CmbCondicion)
    Call Fx_Load_Data("DEPOSITO", Me.cmbTipoEmision)

    Cmb_Tipo_Deposito.Clear
    
    Cmb_Tipo_Deposito.AddItem "RENOVABLE":  Cmb_Tipo_Deposito.ItemData(Cmb_Tipo_Deposito.NewIndex) = 0
    Cmb_Tipo_Deposito.AddItem "FIJO":       Cmb_Tipo_Deposito.ItemData(Cmb_Tipo_Deposito.NewIndex) = 1
    If Cmb_Custodia.ListCount > 0 Then
        Cmb_Custodia.ListIndex = 0
    End If
    
    Cmb_Custodia.Clear
    Call Cmb_Custodia.AddItem("PROPIA"):    Let Cmb_Custodia.ItemData(Cmb_Custodia.NewIndex) = 1
    Call Cmb_Custodia.AddItem("CLIENTE"):   Let Cmb_Custodia.ItemData(Cmb_Custodia.NewIndex) = 2
    Call Cmb_Custodia.AddItem("DCV"):       Let Cmb_Custodia.ItemData(Cmb_Custodia.NewIndex) = 2
    If Cmb_Custodia.ListCount > 0 Then
        Cmb_Custodia.ListIndex = 0
    End If
    
    Screen.MousePointer = vbDefault

    bControl = True
    'AGREGADO  PARA LD1-COR-035
    Call Proc_Consulta_Porcentaje_Transacciones("IC")
    Call Proc_Limpia_Pantalla
    
    If Cmb_Moneda.ListCount > 0 Then
        Cmb_Moneda.ListIndex = 0
    End If
    
    Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Ingreso a pantalla de captaciones")
    
    Call Formatos
    
End Sub

Private Sub gr_cortes_KeyDown(KeyCode As Integer, Shift As Integer)
    Dim nRowOld As Integer

    If KeyCode = 27 Then
        Exit Sub
    End If

    If KeyCode = vbKeyInsert Then
        nRowOld = gr_cortes.Row
        If Len(gr_cortes.TextMatrix(gr_cortes.Row, 1)) <> 0 Then
            gr_cortes.Rows = gr_cortes.Rows + 1
            gr_cortes.Row = nRowOld + 1
            gr_cortes.Col = 1
        End If
    End If

    If KeyCode = vbKeyDelete And Not bFlagEdit Then
        If gr_cortes.Rows > 2 Then
            gr_cortes.RemoveItem gr_cortes.Row
        Else
            Call TextMatrix(gr_cortes, 1, 1, "")
            Call TextMatrix(gr_cortes, 1, 2, "")
            Call TextMatrix(gr_cortes, 1, 3, "")
            Call TextMatrix(gr_cortes, 1, 4, "")
            Call TextMatrix(gr_cortes, 1, 5, "")
            Call TextMatrix(gr_cortes, 1, 6, "")
        End If

        gr_cortes.Refresh

        Call Proc_Calcula_Captacion(0)
    End If

End Sub

Private Sub Gr_Cortes_KeyPress(KeyAscii As Integer)
    
    If gr_cortes.Col = 1 Or gr_cortes.Col = 2 Then
        If KeyAscii = vbKeyReturn Then
            Text1.text = Format(gr_cortes.text, "00000")
        End If

        If KeyAscii > 47 And KeyAscii < 58 Then
            Text1.text = Chr(KeyAscii)
        End If
        
        Text1.Height = gr_cortes.CellHeight - 15
        
        Text1.SelStart = Len(Text1.text)
        
        Text1.Visible = True
        
        Text1.SetFocus
        
        
        
    End If

End Sub

Sub PROC_POSICIONA_TEXTO(GRILLA As Control, texto As Control)
    Dim n As Integer
    Dim i As Integer
    Dim F As Integer

    texto.Width = GRILLA.ColWidth(GRILLA.Col)
    texto.Height = GRILLA.RowHeight(GRILLA.Row)
 
    texto.Top = GRILLA.Top + (GRILLA.Row * 245)

    n = 0
    F = IIf(GRILLA.Col = 0, 0, GRILLA.Col - 1)
 
    If GRILLA.Col > 0 Then
        For i = 0 To F
            n = n + GRILLA.ColWidth(i) + 10
        Next i
    End If
    
    texto.Left = GRILLA.Left + n + 20

End Sub

Private Sub Msk_Fecha_Vcto_Change()
    If Not bControl Then
        Exit Sub
    End If
   'SendKeys "{TAB}"
End Sub

Private Sub Msk_Fecha_Vcto_Click()
   'SendKeys "{TAB}"
End Sub

Private Sub Msk_Fecha_Vcto_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = 13 Then
        Sendkeys "{TAB}"
    End If
End Sub


Private Sub Msk_Fecha_Vcto_LostFocus()
    Txt_Dias.text = DateDiff("D", Format(gsBac_Fecp, "dd/mm/yyyy"), Format(Msk_Fecha_Vcto.text, "dd/mm/yyyy"))
    
    If Txt_Dias.text < DiasMin Then
       Txt_Dias.text = DiasVal
       Msk_Fecha_Vcto.text = Format(DateAdd("d", DiasVal, gsBac_Fecp), "dd/mm/yyyy")
    End If
    
    If EsFeriado(Msk_Fecha_Vcto.text, "00001") Then
       MsgBox "Fecha de vencimiento es un día no habíl, Favor revisar plazo correcto", vbExclamation, gsBac_Version
       Msk_Fecha_Vcto.text = Format(gsBac_Fecp, "dd/mm/yyyy")
       Txt_Dias.text = DateDiff("D", Format(gsBac_Fecp, "dd/mm/yyyy"), Format(Msk_Fecha_Vcto.text, "dd/mm/yyyy"))
       Msk_Fecha_Vcto.SetFocus
    Else
       Proc_Calcula_Captacion (0)
    End If
    If Flt_TasaTran.text = 0# Then
        Flt_TasaTran.SetFocus
    End If
End Sub


Private Sub Msk_Tasa_Change()
    Call Proc_Calcula_Captacion(0)
End Sub

Private Sub Msk_Tasa_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        Sendkeys "{TAB}"
    End If
End Sub

Private Sub Msk_Tasa_LostFocus()

    '+++jcamposd 20170512
    If BacCtrlTransMonto(Msk_Tasa.text) < 0 Then
       Call MsgBox("Depósito debe tener tasa positiva.", vbExclamation, App.Title)
       Call TOOLLIMPIAR
       Exit Sub
    End If
    '---jcamposd 20170512
    
    Flt_TasaTran.text = BacCtrlTransMonto(Msk_Tasa.text)
    
    If Msk_Tasa.text <> 0 Then
        If Msk_Tasa.text > 0 Then
            Let bValTasaEmision = False
            
       'LD1-COR-035
        If Cmb_Moneda.ListIndex <> -1 And Txt_Dias.text > 0 And Msk_Tasa.text > 0 Then
            If ControlPreciosTasas("IC", Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex), CLng(Txt_Dias.text), CDbl(Msk_Tasa.text)) = "S" Then
                If Ctrlpt_ModoOperacion <> "S" Then 'PRD-3860, modo silencioso
                    If Ctrlpt_Mensaje <> "" Then
                        MsgBox Ctrlpt_Mensaje, vbExclamation, TITSISTEMA
                        Let bValTasaEmision = False
                    Else
                      '  MsgBox "Curva asociada no posee banda", vbExclamation, TITSISTEMA
                         Let bValTasaEmision = False
                    End If
                End If
            Else
                    Let bValTasaEmision = True
            End If
        End If
        End If
    End If
'->     Aca debe ir la llamada a la autorizacion de los Limites ALCO
'''''   If BacLimiteALCO.Visible = False Then
'''''       Flt_TasaTran.Text = Format(nTasaPacto, "#0.0000")
'''''   End If
'->     Aca debe ir la llamada a la autorizacion de los Limites ALCO
    
End Sub


Private Sub SSC_Grabar_Click()
'Dim varsMensaje As String
'
'    If Not ValidData() Then Exit Sub
'
'    BacIrfGr.proMtoOper = Lbl_Monto_Inicio_pesos.Caption
'    BacIrfGr.proHwnd = hWnd
'    BacIrfGr.proMoneda = Trim$(Mid$(Cmb_Moneda.Text, 1, 3))
'
'    Call BacGrabarTX
'
End Sub

Function ValidData() As Boolean
    Dim cMens As String
    Dim nRow As Integer

    ValidData = False
    cMens = " "
    
    If Val(Txt_Dias.text) = 0 Then
        cMens = " - Falta ingresar plazo de captación " & vbCrLf
    End If
    
    If CDbl(Flt_TasaTran.text) = 0 Then
        cMens = " - Falta ingresar tasa de transferencia" & vbCrLf
    End If
    
    If CDbl(Msk_Tasa.text) = 0 Then
        cMens = " - Falta ingresar tasa de transferencia" & vbCrLf
    End If
    
    If Format$(Msk_Fecha_Vcto.text, "yyyymmdd") <= Format$(gsBac_Fecp, "yyyymmdd") Then
        cMens = " - Fecha de vencimiento debe ser mayor a la de proceso " & vbCrLf
    End If
    
   If gr_cortes.Rows > 1 Then
'        For nRow = 1 To Gr_Cortes.Rows - 1'
'            If Len(Trim$(TextMatrix(Gr_Corte's, nRow, 1, "X"))) <> 0 And Len(Trim$(TextMatrix(Gr_Cortes, nRow, 2, "X"))) = 0 Then
'                cMens = " - Fila : " & nRow & " No posee monto de inicio " & vbCrLf
'            End If
            
'            If Len(Trim$(TextMatrix(Gr_Cortes, nRow, 1, "X"))) <> 0 And Len(Trim$(TextMatrix(Gr_Cortes, nRow, 2, "X"))) <> 0 And Len(Trim$(TextMatrix(Gr_Cortes, nRow, 3, "X"))) = 0 Then'
'                cMens = " - Fila : " & nRow & " No posee monto de corte  " & vbCrLf
'            End If
'        Next nRow
    Else
        cMens = " - No se registra detalle de captaciones " & vbCrLf
    End If
    
    If Len(Trim$(cMens)) > 0 Then
        MsgBox " Ingreso de captaciones presenta las siguientes anomalias: " & vbCrLf & vbCrLf & cMens & vbCrLf & " Verifque, e intente nuevamente la grabación de la operación.", vbExclamation, gsBac_Version
        Exit Function
    End If
    
    Dim iMoneda As Integer
    Dim cPlaza  As String
    
    If Cmb_Moneda.ListCount > 0 Then
        Let iMoneda = Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex)
        Let cPlaza = IIf(iMoneda = 13, 225, IIf(iMoneda = 142, 338, IIf(iMoneda = 999, 6, 0)))
        Let cPlaza = IIf(cPlaza = 0, 6, cPlaza)
                
        If EsFeriado(Me.Msk_Fecha_Vcto.text, cPlaza) = True Then
            Call MsgBox("La fecha de vencimiento para la moneda " & Trim(Cmb_Moneda.List(Cmb_Moneda.ListIndex)) & ", no es día hábil de acuerdo a la plaza de la moneda." & vbCrLf & vbCrLf & "... Favor revisar el plazo.", vbExclamation, App.Title)
            Exit Function
        End If
    End If
    
    For nRow = 1 To gr_cortes.Rows - 1
        gr_cortes.Row = nRow
        BacControlWindows 10
        If Val(gr_cortes.TextMatrix(gr_cortes.Row, 1)) = 0 Or Val(gr_cortes.TextMatrix(gr_cortes.Row, 2)) = 0 Then
            MsgBox "Faltan datos en detalle de captación", vbExclamation, gsBac_Version
            Exit Function
        End If
    Next nRow
    ValidData = True
    
End Function


Private Sub SSC_Limpiar_Click()

'Proc_Limpia_Pantalla
'
'Msk_Tasa.SetFocus

End Sub

Private Sub Table1_ColumnChange()

    bFlagEdit = False
    
End Sub

Private Sub Table1_EnterEdit()
    bFlagEdit = True
    
End Sub

Private Sub Table1_Fetch(Row As Long, Col As Integer, Value As String)

    gr_cortes.Row = Row
    gr_cortes.Col = Col
    Table1.text = gr_cortes.text
    
    
End Sub


Private Sub Table1_FetchAttributes(Status As Integer, Split As Integer, Row As Long, Col As Integer, FgColor As Long, BgColor As Long, FontStyle As Integer)
    
    If Col = Table1.ColumnIndex And Row = Table1.RowIndex Then
        FgColor = BacToolTip.Color_Dest.ForeColor
        BgColor = BacToolTip.Color_Dest.BackColor
    Else
        FgColor = BacToolTip.Color_Normal.ForeColor
        BgColor = BacToolTip.Color_Normal.BackColor
    End If
    
End Sub


Private Sub Table1_KeyDown(KeyCode As Integer, Shift As Integer)
Dim nRowOld As Integer
    
    If KeyCode = 27 Then
       Exit Sub
    End If

    If KeyCode = vbKeyInsert Then
       nRowOld = Table1.RowIndex
       If Len(Trim$(TextMatrix(gr_cortes, Table1.Rows, 1, "X"))) <> 0 Then
          gr_cortes.Rows = gr_cortes.Rows + 1
          Table1.Rows = gr_cortes.Rows - 1
          Table1.RowIndex = Table1.Rows
          Table1.ColumnIndex = 1
       End If
    End If
    
    If KeyCode = vbKeyDelete And Not bFlagEdit Then
       If gr_cortes.Rows > 2 Then
          gr_cortes.RemoveItem Table1.RowIndex
       Else
          Call TextMatrix(gr_cortes, 1, 1, "")
          Call TextMatrix(gr_cortes, 1, 2, "")
          Call TextMatrix(gr_cortes, 1, 3, "")
          Call TextMatrix(gr_cortes, 1, 4, "")
          Call TextMatrix(gr_cortes, 1, 5, "")
          Call TextMatrix(gr_cortes, 1, 6, "")
       End If
       Table1.Rows = gr_cortes.Rows - 1
       Table1.Refresh
       
       Proc_Calcula_Captacion 0
    End If
    
End Sub

Private Sub Table1_KeyPress(KeyAscii As Integer)



    If Not IsNumeric(Chr(KeyAscii)) And (KeyAscii <> 8 And KeyAscii <> 13 And KeyAscii <> Asc(".") And KeyAscii <> Asc(",")) Or KeyAscii = 27 Or KeyAscii = 45 Then
        KeyAscii = 0
    End If
    
    If bFlagEdit Then
        If Trim$(Cmb_Moneda.text) = gsBac_Dolar Then
          '  KeyAscii = BacPunto(TABLE1, KeyAscii, 12, 2)
        Else
           'VB 30/08/2000  KeyAscii = BacPunto(Table1, KeyAscii, 12, 4)
         '   KeyAscii = BacPunto(TABLE1, KeyAscii, 12, 0)

        End If
    End If
    
    If Trim$(Cmb_Moneda.text) = "$$" Then
        If Chr(KeyAscii) = "," Or Chr(KeyAscii) = "." Then
            KeyAscii = 0
        End If
    End If
    
    
End Sub

Private Sub Table1_Update(Row As Long, Col As Integer, Value As String)
Dim nValor1 As Double
Dim nValor2 As Double
Dim nValor3 As Double
Dim nValor4 As Double


    gr_cortes.Row = Row
    gr_cortes.Col = Col
    gr_cortes.text = Value
            
            
    Proc_Calcula_Captacion (Col)
    
    Table1.ColumnIndex = IIf(Col = 1, 2, 1)
        
    
    
End Sub

Private Sub Table1_Validate(Row As Long, Col As Integer, Value As String, Cancel As Integer)

    If Not IsNumeric(Value) Then Value = 0
    
    gr_cortes.Row = Row
    gr_cortes.Col = Col
    
End Sub

Private Sub Text1_GotFocus()
'+++fmo 20180718 decimales moneda USD
    If Me.Cmb_Moneda.text = "USD" And Me.gr_cortes.Col = 2 Then
        Text1.CantidadDecimales = 2
    Else
        If Me.Cmb_Moneda.text = "UF" And Me.gr_cortes.Col = 2 Then
            Text1.CantidadDecimales = 4
        Else
            Text1.CantidadDecimales = 0
        End If
    End If
'---fmo 20180718 decimales moneda USD

    Call PROC_POSI_TEXTO(gr_cortes, Text1)
'+++fmo 20180718 decimales moneda USD
    If Me.gr_cortes.Col = 2 Then
        If Me.Cmb_Moneda.text = "USD" Then
            Text1.CantidadDecimales = 2
        End If
        If Me.Cmb_Moneda.text = "UF" Then
            Text1.CantidadDecimales = 4
        End If
    End If
'---fmo 20180718 decimales moneda USD
End Sub

Private Sub Text1_KeyDown(KeyCode As Integer, Shift As Integer)
    Dim Row As Integer
    
    If KeyCode = 27 Then
        Text1_LostFocus
    End If
    
    If KeyCode = 13 Then
        Row = gr_cortes.Row
'+++fmo 20180718 decimales moneda USD
        If Me.Cmb_Moneda.text = "USD" And Me.gr_cortes.Col = 2 Then
            gr_cortes.TextMatrix(gr_cortes.Row, gr_cortes.Col) = Format(Text1.text, FDecimal)
        Else
            If Me.Cmb_Moneda.text = "UF" And Me.gr_cortes.Col = 2 Then
                gr_cortes.TextMatrix(gr_cortes.Row, gr_cortes.Col) = Format(Text1.text, FDecimal)
            Else
                gr_cortes.TextMatrix(gr_cortes.Row, gr_cortes.Col) = Format(Text1.text, FEntero)
            End If
        End If
'---fmo 20180718 decimales moneda USD
        
        Proc_Calcula_Captacion (Col)
        gr_cortes.Row = Row
        gr_cortes.Col = gr_cortes.Col + 1
        gr_cortes.SetFocus
    End If
End Sub

Private Sub Text1_LostFocus()
    Text1.text = 0
    Text1.Visible = False
    gr_cortes.SetFocus
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
    Select Case UCase(Button.Description)
        Case "GRABAR"
            Call TOOLGRABAR
        Case "LIMPIAR"
            Call TOOLLIMPIAR
        Case "CERRAR"
            Call Unload(Me)
    End Select
End Sub

Function TOOLLIMPIAR()
    Proc_Limpia_Pantalla
    Msk_Tasa.SetFocus

End Function

Function TOOLGRABAR()
    Dim varsMensaje As String

    If Not Proc_Valida_Tasa_Transferencia(CDbl(Msk_Tasa.text), CDbl(Flt_TasaTran.text)) Then
        Flt_TasaTran.SetFocus
        Exit Function
    End If


    If Not ValidData() Then
        Exit Function
    End If
    
    If Cmb_Tipo_Deposito.ListIndex = -1 Then
        Call MsgBox("Debe Seleccionar el Tipo de Depósito.", vbExclamation, App.Title)
        Exit Function
    End If
    If cmbTipoEmision.ListIndex = -1 Then
        Call MsgBox("Debe Seleccionar el Tipo de Emisión del Depósito.", vbExclamation, App.Title)
        Exit Function
    End If

    If Cmb_Tipo_Deposito.List(Cmb_Tipo_Deposito.ListIndex) = "RENOVABLE" Then
        If cmbTipoEmision.List(cmbTipoEmision.ListIndex) Like "*DESMATERIALIZADO*" Then
            Call MsgBox("Depósito Desmaterializado, no puede ser Renovable.", vbExclamation, App.Title)
            Exit Function
        End If
    End If

       BacMain11.vCondicion = Mid(Me.CmbCondicion.List(CmbCondicion.ListIndex), 1, 1)
    BacMain11.vTipoDeposito = Me.Cmb_Tipo_Deposito.ItemData(Cmb_Tipo_Deposito.ListIndex)
     BacMain11.vTipoEmision = Me.cmbTipoEmision.ItemData(cmbTipoEmision.ListIndex)
    
    BacIrfGr.proMtoOper = Lbl_Monto_Inicio_pesos.Caption
    BacIrfGr.proHwnd = hWnd
    BacIrfGr.proMoneda = Trim(Mid$(Cmb_Moneda.text, 1, 3))

    Call BacGrabarTX

End Function

Private Sub Txt_Dias_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        Sendkeys "{TAB}"
    End If
End Sub

Private Sub Txt_Dias_LostFocus()

    If Txt_Dias.text < DiasMin Then
       Txt_Dias.text = DiasVal
    End If

    Msk_Fecha_Vcto.text = Format(DateAdd("d", Val(Txt_Dias.text), gsBac_Fecp), "dd/mm/yyyy")
    
    If EsFeriado(Msk_Fecha_Vcto.text, "00001") Then
        MsgBox "Plazo ingresado proporciona día no habíl, favor revise plazo ingresado.", vbExclamation, gsBac_Version
        Txt_Dias.text = DiasVal
        Msk_Fecha_Vcto.text = Format(DateAdd("d", DiasVal, gsBac_Fecp), "dd/mm/yyyy")
        Txt_Dias.SetFocus
    Else
        Proc_Calcula_Captacion (0)
    End If
        
    
End Sub

Private Sub Txt_Ingreso_KeyPress(KeyAscii As Integer)

    If KeyAscii = 27 Then
        gr_cortes.SetFocus
        Exit Sub
    End If
    
    If gr_cortes.Col = C_MONTO_CORTE Then
        Proc_fmt_Numerico Txt_ingreso, 15, 4, KeyAscii, "+"
    Else
        Proc_fmt_Numerico Txt_ingreso, 3, 0, KeyAscii, "+"
    End If
    
    If KeyAscii = 13 Then
        If gr_cortes.Col = C_MONTO_CORTE Then
            gr_cortes.text = Format(Txt_ingreso.text, "#,##0.0000")
        Else
            gr_cortes.text = Format(Txt_ingreso.text, "##0")
        End If

        Call TextMatrix(gr_cortes, gr_cortes.Row, C_MONTO_INICIO, Format(Func_fmt_double(TextMatrix(gr_cortes, gr_cortes.Row, C_CORTES, "X")) * Func_fmt_double(TextMatrix(gr_cortes, gr_cortes.Row, C_MONTO_CORTE, "X")), "#,##0.0000"))

        Sendkeys "{RIGHT}"
        gr_cortes.SetFocus
    End If


End Sub


Sub Proc_fmt_Numerico(texto As Control, NEnteros, NDecs As Integer, ByRef Tecla, Signo As String)

    If Tecla = 13 Or Tecla = 27 Then
        Exit Sub
    End If
    
    If Tecla = 45 And Signo = "+" Then
        Tecla = 0
    End If
    
    If Tecla <> 8 And (Tecla < 48 Or Tecla > 57) Then
        If NDecs = 0 Then
            Tecla = 0
        ElseIf Tecla <> 46 And Tecla <> 45 Then
            Tecla = 0
        End If
    End If
    
    If Tecla = 45 And Signo = "-" Then  ' Signo negativo
        If InStr(texto.text, "-") > 0 Then
            Tecla = 0
        ElseIf texto.SelStart > 0 Then
            If Mid(texto.text, texto.SelStart, 1) <> "" Then
                Tecla = 0
            End If
        End If
    End If

    PosPto% = InStr(texto.text, ".")
    If PosPto% > 0 And Tecla = 46 Then
        Tecla = 0
        Exit Sub
    End If

    If NDecs > 0 And PosPto% > 0 And PosPto% <= texto.SelStart Then
        PosPto% = PosPto% + 1
        If Len(Mid(texto.text, PosPto%, NDecs)) = NDecs And Tecla <> 8 Then
            Tecla = 0
        Else
            Exit Sub
        End If
    End If

    If PosPto% > 0 And texto.SelStart < PosPto% And Tecla <> 8 Then
        If Len(Mid(texto.text, 1, PosPto% - 1)) >= NEnteros Then
            Tecla = 0
        End If
    ElseIf PosPto% = 0 And Tecla <> 8 And Chr(Tecla) <> "." Then
        If Len(texto.text) >= NEnteros Then
            Tecla = 0
        End If
    End If

End Sub

Private Sub Txt_Ingreso_LostFocus()
    Txt_ingreso.Visible = False
End Sub


Sub PROC_LLENA_FORMA_PAGO(objeto As Control)
    Dim Datos()

    Comando$ = "SP_LEEFORPAG 0,''"
    
    If miSQL.SQL_Execute(Comando$) <> 0 Then Exit Sub
    
    Do While Bac_SQL_Fetch(Datos())
        objeto.AddItem RELLENA_STRING((Datos(2)), "D", 30) + Space(30) + Format(Datos(1), "###")
    Loop

End Sub
Public Function RELLENA_STRING(Dato As String, Pos As String, Largo As Integer) As String

'rellena con blancos y completa el largo requerido
' Ejemplo : x$ = RELLENA_STRING(CStr(i#), "I", 10)
' Ejemplo : x$ = RELLENA_STRING(i$, "D", 10)

    If Trim(Pos$) = "" Then
        Pos$ = "I"
    End If
    
    If Largo < Len(Trim(Dato)) Then
       RELLENA_STRING = Mid(Trim(Dato), 1, Largo)
       Exit Function
    End If
    
    If Mid(Pos$, 1, 1) = "I" Then 'IZQUIERDA
       RELLENA_STRING = String(Largo - Len(Trim(Dato)), " ") + Trim(Dato)
    Else                          'DERECHA
       RELLENA_STRING = Trim(Dato) + String(Largo - Len(Trim(Dato)), " ")
    End If
    
    RELLENA_STRING = Mid(RELLENA_STRING, 1, Largo)

End Function

Sub PROC_LLENA_MONEDAS(objeto As Control)
    Dim Datos()
    Dim dValor As Double

    dValor = 22
    Envia = Array(dValor)

    If Not Bac_Sql_Execute("SP_TCLEECODIGOS1", Envia) Then
        Exit Sub
    End If
     
    objeto.Clear
    Do While Bac_SQL_Fetch(Datos())
        objeto.AddItem Datos(2) + Space(20) + Format(Datos(1), "#0")
    Loop

End Sub

Sub Proc_Calcula_Captacion(ByVal nCol As Integer)
    Dim monto_corte   As Double
    Dim Valor_Moneda  As Double
    Dim Dias          As Double
    Dim Monto_Final   As Double
    Dim Total_Nominal As Double
    Dim Total_Pesos   As Double
    Dim Total_Final   As Double
    Dim nBasecalculo  As Double
    Dim Monto_Inicio  As Double
    Dim Cortes        As Integer
    Dim Total_Cortes  As Integer
    Dim sFormato      As String
    Dim redondeo      As Integer
        
        
    If Cmb_Moneda.ListIndex < 0 Then
        Exit Sub
    End If
    '+++cvegasan 2017.10.03 [CORRECCION] - Pantalla de Captaciones CLP =0 Dec / UF = 4 Dec / DO = 2 Dec.
    'If Mid(Cmb_Moneda.text, 1, 3) = gsBac_Dolar Or Mid(Cmb_Moneda.text, 1, 2) = "DO" Or Mid(Cmb_Moneda.text, 1, 3) = "DA" Then
    '    sFormato = "#,###,##0.00"
    'ElseIf Mid(Cmb_Moneda.text, 1, 2) = "$$" Or Mid(Cmb_Moneda.text, 1, 3) = "CLP" Then
    '    sFormato = "#,###,##0"
    'ElseIf Mid(Cmb_Moneda.text, 1, 2) = "UF" Then
    '    sFormato = "#,###,##0.0000"
    'Else
    '    sFormato = "#,###,##0.00"
    'End If
    '---cvegasan 2017.10.03 [CORRECCION] - Pantalla de Captaciones CLP =0 Dec / UF = 4 Dec / DO = 2 Dec.
'+++jcamposd el formato viene definido al momento de seleccionar moneda
'    Let sFormato = "#,##0.0000"
'    If Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex) = 999 Then
'        Let sFormato = "#,##0"
'    End If
'---jcamposd el formato viene definido al momento de seleccionar moneda
    '+++cvegasan 2017.09.14 [CORRECCION] - Pantalla de Captaciones cuando es Pesos base tiene que ser 30
    If Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex) = 999 Then
        nBasecalculo = 30
    Else
        nBasecalculo = BaseCalculo()
    End If
    '---cvegasan 2017.09.14 [CORRECCION] - Pantalla de Captaciones cuando es Pesos base tiene que ser 30
    
    If nCol <> 0 Then
        If Not bControl Then
            Exit Sub
        End If

        If Not IsDate(Msk_Fecha_Vcto.text) Then
            Exit Sub
        End If

        Call TextMatrix(gr_cortes, gr_cortes.Row, C_MONTO_INICIO, Format(Func_fmt_double(TextMatrix(gr_cortes, gr_cortes.Row, C_CORTES, "X")) * Func_fmt_double(TextMatrix(gr_cortes, gr_cortes.Row, C_MONTO_CORTE, "X")), "#,##0.0000"))
    End If

    If bControl Then
        '---jcamposd controla UF con cambio de formato configuracion regional
        If Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex) = 998 Then
            Valor_Moneda = gsValor_UF
        ElseIf Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex) = 994 Then
            Valor_Moneda = gsValor_DO
        Else
            Valor_Moneda = FUNC_BUSCA_VALOR_MONEDA(Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex), Format(gsBac_Fecp, "DD/MM/YYYY"))
        End If
        
        If Valor_Moneda = 0 Then
            gr_cortes.Enabled = False
            Me.Cmb_Moneda.ListIndex = Mon
            Exit Sub
        Else
            gr_cortes.Enabled = True
        End If
        
        '+++cvegasan 2017.10.03 [CORRECCION] - Pantalla de Captaciones CLP =0 Dec / UF = 4 Dec / DO = 2 Dec.
        '+++jcamposd
        'If Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex) = 999 Then
        '    redondeo = 0
        'Else
        '    redondeo = 2
        'End If
        
        Select Case Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex)
            Case 999:
                redondeo = 0
                sFormato = "#,###,##0"
            Case 998:
'+++fmo 20180913 ingreso decimales moneda USD
                redondeo = 4
                sFormato = "#,###,##0.0000" ' VB 16-11-2018 pedido por Camilo Pino
'---fmo 20180913 ingreso decimales moneda USD
            Case 13, 994, 995:
                redondeo = 2
                 sFormato = "#,###,##0.00"
        End Select
        
        '---cvegasan 2017.10.03 [CORRECCION] - Pantalla de Captaciones CLP =0 Dec / UF = 4 Dec / DO = 2 Dec.
    End If

    Dias = DateDiff("d", gsBac_Fecp, Msk_Fecha_Vcto.text)
    
    Total_Nominal = 0#
    Total_Cortes = 0

    ' --------------------------------------------------------------------------------
    ' CALCULA TOTAL DE CORTES
    ' --------------------------------------------------------------------------------
    For i% = 1 To gr_cortes.Rows - 1
        If Val(TextMatrix(gr_cortes, i%, C_CORTES, "X")) > 0 Then
           Total_Cortes = Total_Cortes + Val(TextMatrix(gr_cortes, i%, C_CORTES, "X"))
        End If
    Next i%

    ' --------------------------------------------------------------------------------
    ' CALCULA VALORES DE CAPTACION
    ' --------------------------------------------------------------------------------
    For i% = 1 To gr_cortes.Rows - 1
        
        If Trim(TextMatrix(gr_cortes, i%, C_CORTES, "X")) = "" Or Trim(TextMatrix(gr_cortes, i%, C_MONTO_CORTE, "X")) = "" Then
            Exit For
        End If
        
        Cortes = Val(TextMatrix(gr_cortes, i%, C_CORTES, "X"))
        monto_corte = (TextMatrix(gr_cortes, i%, C_MONTO_CORTE, "X"))

        Monto_Inicio = monto_corte * Cortes
        Call TextMatrix(gr_cortes, i%, C_MONTO_INICIO_PESOS, Format(Monto_Inicio, sFormato))  '-> "#,##0.0000"))

        Monto_Final = (monto_corte / Valor_Moneda) * ((Func_fmt_double(Msk_Tasa.text) / (nBasecalculo * 100)) * Dias + 1#)
        Call TextMatrix(gr_cortes, i%, C_MONTO_CORTE_FINAL, Format(Monto_Final, sFormato))  '-> "#,##0.0000"))

        Monto_Inicio = Round(Monto_Inicio / Valor_Moneda, redondeo)
        Call TextMatrix(gr_cortes, i%, C_MONTO_INICIO, Format(Monto_Inicio, sFormato))  '-> "#,##0.0000"))

        Monto_Final = Round(Monto_Inicio * ((Func_fmt_double(Msk_Tasa.text) / (nBasecalculo * 100)) * Dias + 1#), redondeo)
        Call TextMatrix(gr_cortes, i%, C_MONTO_FINAL, Format(Monto_Final, sFormato))  '-> "#,##0.0000"))

        Total_Nominal = Total_Nominal + CDbl(TextMatrix(gr_cortes, i%, C_MONTO_INICIO, "X"))
        Total_Pesos = Total_Pesos + CDbl(TextMatrix(gr_cortes, i%, C_MONTO_INICIO_PESOS, "X"))
        Total_Final = Total_Final + Monto_Final
    Next i%

    Lbl_Monto_inicio.Caption = Format(Total_Nominal, sFormato)  '-> "#,##0.0000")
    '+++cvegasan 2017.10.03 [CORRECCION] - Pantalla de Captaciones CLP =0 Dec / UF = 4 Dec / DO = 2 Dec.
    'If Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex) = 13 Then
    '    Lbl_Monto_Inicio_pesos.Caption = Format(Total_Pesos, sFormato)  '-> "#,##0.0000")
    'Else
    '    Lbl_Monto_Inicio_pesos.Caption = Format(Total_Pesos, sFormato)  '-> "#,##0")
    'End If
    
    Select Case Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex)
        Case 13: Lbl_Monto_Inicio_pesos.Caption = Format(Total_Pesos, sFormato)
        Case Else:
            Lbl_Monto_Inicio_pesos.Caption = Format(Total_Pesos, cFormato_Pesos)
    End Select
    
    '---cvegasan 2017.10.03 [CORRECCION] - Pantalla de Captaciones CLP =0 Dec / UF = 4 Dec / DO = 2 Dec.
    Lbl_Monto_Final.Caption = Format(Total_Final, sFormato)  '-> "#,##0.0000")
    
    Call Formatos

End Sub


Function BaseCalculo() As Integer
    On Error GoTo ErrFind
    Dim varssql         As String
    Dim varDatos()

    BaseCalculo = 1

    If IsNull(Cmb_Moneda.text) = True Or Cmb_Moneda.text = "" Then
        Exit Function
    End If
    
    varssql = "EXECUTE SP_TRAE_MONEDA " & Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex)
    
    If miSQL.SQL_Execute(varssql) = 0 Then
        Do While miSQL.SQL_Fetch(varDatos()) = 0
            BaseCalculo = varDatos(3)
            DiasMin = varDatos(4)
            Exit Function
        Loop
    End If

Exit Function
ErrFind:
    BaseCalculo = 1

    MsgBox "Problemas en busqueda de bases de calculo: " & err.Description & ".Comunique al Administrador. ", vbCritical, gsBac_Version
    
    Exit Function
End Function

Function Func_fmt_double(Tpaso As String) As Double
    If Not IsNumeric(Tpaso) Then
        Tpaso = 0
    End If

    For i% = 1 To Len(Tpaso)
        If Mid(Tpaso, i%, 1) = "0" Then Mid(Tpaso, i%, 1) = " " Else Exit For
    Next i%

    If Trim(Tpaso) = "" Or Trim(Tpaso) = "." Then
        Func_fmt_double = 0#
    Else
        Func_fmt_double = CDbl(Tpaso)
    End If

End Function

Sub PROC_LLENA_ENTIDAD(Combo As Control)
    Dim Datos()

    Combo.Clear
    
    If Bac_Sql_Execute("SP_LEER_ENTIDADES") Then
        Do While Bac_SQL_Fetch(Datos())
            Combo.AddItem Datos(1) & Space(30 + (30 - Len(Datos(1)))) & Val(Datos(2))
        Loop
    End If

End Sub

Private Function Fx_Load_Data(ByVal nCategoria As String, ByRef oCombo As ComboBox) As Boolean
    On Error GoTo errLoadData
    Dim SqlString   As String
    Dim SqlDatos()
    
    Let Fx_Load_Data = False
    
    If nCategoria = "CONDICION" Then
        Let SqlString = "SP_LEECONDICION "
    End If
    If nCategoria = "DEPOSITO" Then
        Let SqlString = "SP_TCLEECODIGOS1 10"
    End If
    
    Call oCombo.Clear

    If Not Bac_Sql_Execute(SqlString) Then
        Exit Function
    End If
    Do While Bac_SQL_Fetch(SqlDatos())
        Call oCombo.AddItem(SqlDatos(2))
         Let oCombo.ItemData(oCombo.NewIndex) = SqlDatos(1)
    Loop
    
    Let Fx_Load_Data = True
    
    If oCombo.ListCount > 0 Then
        Let oCombo.ListIndex = 0
    End If
    
    On Error GoTo 0
Exit Function
errLoadData:

    Call MsgBox("Error en la carga de informacion para " & nCategoria & vbCrLf & err.Description, vbExclamation, App.Title)

    On Error GoTo 0
End Function

Private Function fx_ControlTasaMercado() As Boolean
    ' Debe ser implementada por Otro RQ
End Function

Private Function fx_ControlTasaMercado_Trasferencia() As Boolean
    ' Debe ser implementada por Otro RQ
End Function

Private Function DesplegarMensajes() As Boolean
    Dim cSaltoLinea     As String
    Dim cMensaje        As String

'>  LD1_035
'>  Se comento el control hasta que se defina como va a quedar.
    
Exit Function
    
'''''    If Txt_Dias.Text > 0 And Flt_TasaTran.Text > 0 And Msk_Tasa.Text > 0 Then
'''''        aTasaTransferencia = Array()
'''''        gInsertaExcesoEnTasaTransferencia = False
'''''
'''''        If Control_Tasas_Mercado_Transferencia(703, Cmb_Moneda.ItemData(Cmb_Moneda.ListIndex), CDate(Msk_Fecha_Vcto.Text), "V", Trim(Flt_TasaTran.Text), "CAPTACIONES A PLAZO (TASA TRANSFERENCIA)", 0) = False Then
'''''
'''''            cSaltoLinea = Chr(13) & Chr(10)
'''''
'''''            cMensaje = "El siguiente Producto está Excedido en el Límite de Tasas de Transferencia. ¿ Desea que otro Usuario Autorice.? " & cSaltoLinea & cSaltoLinea
'''''            cMensaje = cMensaje & "Instrumento                    Tasa Transf. Límite                            Tasa Transferencia" & cSaltoLinea
'''''            cMensaje = cMensaje & "=======================================================" & cSaltoLinea
'''''            cMensaje = cMensaje & "CAPTACION A PLAZO" & Space(13) & Format(nTasaPacto, "#0.000000") & Space(40) & Format(Flt_TasaTran.Text, "#0.000000") & cSaltoLinea
'''''
'''''            If MsgBox(cMensaje, vbYesNo, "Bac-Trader") = vbYes Then
'''''
'''''                c = UBound(aTasaTransferencia) + 1
'''''                ReDim Preserve aTasaTransferencia(c)
'''''
'''''                aTasaTransferencia(c) = Array("TP", "CAPTACIONES", nTasaPacto, Flt_TasaTran.Text, Txt_Dias.Text, Lbl_Monto_Inicio_pesos.Caption, 1)
'''''
'''''                Autorizado = False
'''''                Tas_Plazo = Txt_Dias.Text
'''''                SW_TASA_TRAN = 1
'''''
'''''                If Not Aprobacion_Pantalla(4, 3) Then  'CONTROL DE TASA TRANSFERENCIA
'''''                    'No está Autorizado
'''''                    Flt_TasaTran.Text = Format(nTasaPacto, "#0.0000")
'''''                    gAutorizador_Tasa_Trans = ""
'''''                    gInsertaExcesoEnTasaTransferencia = False
'''''                    Exit Function
'''''                Else
'''''                    'Está Autorizado
'''''                    gInsertaExcesoEnTasaTransferencia = True 'Esta var me indica si al grabar la operación tambien grabo el excedente de limite.
'''''                    bValTasaPact = True
'''''                    Exit Function
'''''                End If
'''''            Else
'''''                Flt_TasaTran.Text = Format(nTasaPacto, "#0.0000")
'''''                gInsertaExcesoEnTasaTransferencia = False
'''''            End If
'''''        End If
'''''    End If
    
End Function
