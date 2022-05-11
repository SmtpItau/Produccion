VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{05BDEB52-1755-11D5-9109-000102BF881D}#1.0#0"; "BacControles.ocx"
Begin VB.Form Anticipo_Captaciones 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Anticipo de Captaciones"
   ClientHeight    =   5220
   ClientLeft      =   840
   ClientTop       =   2985
   ClientWidth     =   10905
   Icon            =   "Antcapta.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   Moveable        =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5220
   ScaleWidth      =   10905
   Tag             =   "AC"
   Begin Threed.SSFrame SSFrame2 
      Height          =   675
      Left            =   105
      TabIndex        =   17
      Top             =   1170
      Width           =   10695
      _Version        =   65536
      _ExtentX        =   18865
      _ExtentY        =   1191
      _StockProps     =   14
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin BacControles.txtNumero TxtDeltaAnt 
         Height          =   315
         Left            =   8145
         TabIndex        =   18
         Top             =   300
         Width           =   1815
         _ExtentX        =   3201
         _ExtentY        =   556
         Enabled         =   0   'False
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0.0000"
         Min             =   "-99999999.9999"
      End
      Begin BacControles.txtNumero TxtValAnt 
         Height          =   315
         Left            =   4695
         TabIndex        =   19
         Top             =   300
         Width           =   1755
         _ExtentX        =   3096
         _ExtentY        =   556
         Enabled         =   0   'False
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0.0000"
         Min             =   "-99999999.9999"
      End
      Begin BacControles.txtNumero TxtValact 
         Height          =   315
         Left            =   795
         TabIndex        =   20
         Top             =   300
         Width           =   1755
         _ExtentX        =   3096
         _ExtentY        =   556
         Enabled         =   0   'False
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0.0000"
         Min             =   "-99999999.9999"
      End
      Begin VB.Label lbl4 
         AutoSize        =   -1  'True
         Caption         =   "Valor actual"
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
         Height          =   195
         Index           =   0
         Left            =   1515
         TabIndex        =   26
         Top             =   105
         Width           =   1035
      End
      Begin VB.Label lbl6 
         AutoSize        =   -1  'True
         Caption         =   "Diferencia"
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
         Height          =   195
         Left            =   9060
         TabIndex        =   25
         Top             =   105
         Width           =   885
      End
      Begin VB.Label lbl5 
         AutoSize        =   -1  'True
         Caption         =   "Valor Anticipo"
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
         Height          =   195
         Left            =   5250
         TabIndex        =   24
         Top             =   105
         Width           =   1200
      End
      Begin VB.Label lbl7 
         AutoSize        =   -1  'True
         Caption         =   "$"
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
         Height          =   195
         Left            =   4545
         TabIndex        =   23
         Top             =   345
         Width           =   120
      End
      Begin VB.Label lbl8 
         AutoSize        =   -1  'True
         Caption         =   "$"
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
         Height          =   195
         Left            =   615
         TabIndex        =   22
         Top             =   345
         Width           =   120
      End
      Begin VB.Label lbl9 
         AutoSize        =   -1  'True
         Caption         =   "$"
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
         Height          =   195
         Left            =   7995
         TabIndex        =   21
         Top             =   345
         Width           =   120
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   2655
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
            Picture         =   "Antcapta.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Antcapta.frx":075C
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Antcapta.frx":0A76
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Antcapta.frx":0EC8
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Height          =   510
      Left            =   0
      TabIndex        =   16
      Top             =   0
      Width           =   10905
      _ExtentX        =   19235
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdGrabar"
            Description     =   "Grabar"
            Object.ToolTipText     =   "Grabar Datos"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdLimpiar"
            Description     =   "Limpiar"
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdDatos"
            Description     =   "Datos"
            Object.ToolTipText     =   "Datos Iniciales"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdSalir"
            Description     =   "Salir"
            Object.ToolTipText     =   "Salir de la Ventana"
            ImageIndex      =   4
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin VB.Frame Frame3 
      Caption         =   "Detalle Operación"
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
      Height          =   2865
      Left            =   100
      TabIndex        =   5
      Top             =   1860
      Width           =   10695
      Begin BacControles.txtNumero TxtTasaAnt 
         Height          =   225
         Left            =   1080
         TabIndex        =   15
         Top             =   510
         Visible         =   0   'False
         Width           =   975
         _ExtentX        =   1720
         _ExtentY        =   397
         BackColor       =   -2147483647
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   16711680
         Text            =   "0.0000"
         Max             =   "99999999999.9999"
         BorderStyle     =   0
      End
      Begin VB.TextBox Txt_ingreso 
         BorderStyle     =   0  'None
         ForeColor       =   &H00FF0000&
         Height          =   270
         Left            =   6075
         TabIndex        =   6
         Text            =   "Text1"
         Top             =   2895
         Visible         =   0   'False
         Width           =   1185
      End
      Begin MSFlexGridLib.MSFlexGrid Gr_Cortes 
         Height          =   2595
         Left            =   75
         TabIndex        =   12
         Top             =   195
         Width           =   10515
         _ExtentX        =   18547
         _ExtentY        =   4577
         _Version        =   393216
         BackColor       =   -2147483644
         BackColorFixed  =   8421376
         ForeColorFixed  =   -2147483634
         BackColorSel    =   8388608
         ForeColorSel    =   16777215
         FocusRect       =   0
         GridLines       =   2
      End
   End
   Begin Threed.SSFrame SSFrame1 
      Height          =   675
      Left            =   100
      TabIndex        =   1
      Top             =   495
      Width           =   10695
      _Version        =   65536
      _ExtentX        =   18865
      _ExtentY        =   1191
      _StockProps     =   14
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin VB.TextBox txtOperacion 
         Alignment       =   1  'Right Justify
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
         Left            =   1110
         MaxLength       =   10
         TabIndex        =   0
         Top             =   225
         Width           =   1230
      End
      Begin VB.Label lblNombre 
         BackColor       =   &H80000005&
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
         ForeColor       =   &H80000008&
         Height          =   315
         Left            =   3270
         TabIndex        =   4
         Top             =   225
         Width           =   5700
      End
      Begin VB.Label Label2 
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
         ForeColor       =   &H00800000&
         Height          =   255
         Left            =   2610
         TabIndex        =   3
         Top             =   285
         Width           =   705
      End
      Begin VB.Label Label1 
         Caption         =   "Operacion"
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
         Height          =   300
         Left            =   135
         TabIndex        =   2
         Top             =   270
         Width           =   1065
      End
   End
   Begin VB.TextBox txtMoneda 
      Height          =   315
      Left            =   6450
      TabIndex        =   7
      Top             =   4830
      Visible         =   0   'False
      Width           =   1020
   End
   Begin Threed.SSPanel SSP_DataCaptacion 
      Height          =   420
      Left            =   7530
      TabIndex        =   8
      Top             =   4785
      Visible         =   0   'False
      Width           =   3315
      _Version        =   65536
      _ExtentX        =   5847
      _ExtentY        =   741
      _StockProps     =   15
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin BacControles.txtFecha Msk_Fecha_Vcto 
         Height          =   315
         Left            =   1560
         TabIndex        =   14
         Top             =   30
         Width           =   1695
         _ExtentX        =   2990
         _ExtentY        =   556
         Text            =   "20/11/2000"
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MinDate         =   -328716
         MaxDate         =   2958465
      End
      Begin BacControles.txtFecha Fecini 
         Height          =   315
         Left            =   60
         TabIndex        =   13
         Top             =   30
         Width           =   1335
         _ExtentX        =   2355
         _ExtentY        =   556
         Text            =   "20/11/2000"
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MinDate         =   -328716
         MaxDate         =   2958465
      End
   End
   Begin VB.TextBox TxtFpagVcto 
      Height          =   315
      Left            =   4935
      TabIndex        =   10
      Text            =   "TxtFpagVcto"
      Top             =   4830
      Visible         =   0   'False
      Width           =   1455
   End
   Begin MSFlexGridLib.MSFlexGrid Gr_Cortes2 
      Height          =   675
      Left            =   120
      TabIndex        =   11
      Top             =   5895
      Visible         =   0   'False
      Width           =   10695
      _ExtentX        =   18865
      _ExtentY        =   1191
      _Version        =   393216
   End
   Begin VB.Label LblTasa 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      Caption         =   "Tasa"
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
      Height          =   195
      Left            =   8490
      TabIndex        =   9
      Top             =   5550
      Visible         =   0   'False
      Width           =   435
   End
End
Attribute VB_Name = "Anticipo_Captaciones"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Const C_CORTES = 0
Const C_MONTO_CORTE = 1
Const C_MONTO_INICIO = 2
Const C_MONTO_INICIO_PESOS = 3
Const C_TASA = 4
Const C_MONTO_FINAL = 5
Const C_MONTO_ANTICIPO = 6
Const C_MONTO_ANTICIPO_CLP = 7
Const C_DIFERENCIA = 8
Const C_MONTO_VP = 9
Const C_MARCA = 10
Const C_VAL_ANTICIPO = 11
Const C_CORRELATIVO = 12

Dim Sql                 As String
Dim DATOS()

Dim GuardaFil           As Integer
Dim GuardaCol           As Integer

Dim varssql             As String
Dim varvData()          As Variant
Dim bControl            As Boolean
Dim bFlagEdit           As Boolean
Dim DiasMin             As Integer
Dim DiasVal             As Integer
Dim dTipcam             As Double

Private Function Func_fmt_double(Tpaso As String) As Double

   Dim i%

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

Private Sub Proc_Calcula_Captacion(ByVal nCol As Integer)

   Dim monto_corte      As Double
   Dim Valor_moneda     As Double
   Dim Dias             As Double
   Dim Monto_Final      As Double
   Dim Total_Cortes     As Double
   Dim Total_Pesos      As Double
   Dim Total_Final      As Double
   Dim nBasecalculo     As Double
   Dim Monto_anticipo   As Double
   Dim dTotalDifer      As Double
   Dim dPorcentaje      As Double
   Dim dDiferCorte      As Double
   Dim dMontoVp         As Double
   Dim i%

   nBasecalculo = BaseCalculo()

   dTotalDifer = CDbl(TxtDeltaAnt.Text)

   If nCol <> 0 Then
      If Not IsDate(Msk_Fecha_Vcto.Text) Then Exit Sub

      Call TextMatrix(Gr_Cortes, Gr_Cortes.Row, C_MONTO_INICIO, Format(Func_fmt_double(TextMatrix(Gr_Cortes, Gr_Cortes.Row, C_CORTES, "X")) * Func_fmt_double(TextMatrix(Gr_Cortes, Gr_Cortes.Row, C_MONTO_CORTE, "X")), "#,##0.0000"))

   End If

   Total_Cortes = 0#
   
   Valor_moneda = FUNC_BUSCA_VALOR_MONEDA(TxtMoneda.Text, Format(gsBac_Fecp, "DD/MM/YYYY"))

   Dias = DateDiff("d", FecInip, gsBac_Fecp)

   Total_Final = 0

   For i% = 1 To Gr_Cortes.Rows - 1
      Gr_Cortes.Row = i%
      Gr_Cortes.Col = C_MARCA

      Gr_Cortes.Col = C_MONTO_INICIO

      If Val(Gr_Cortes.Text) = 0 Then Exit For

      monto_corte = CDbl(Gr_Cortes.Text)

      Gr_Cortes.Col = C_MONTO_FINAL: Monto_Final = CDbl(Gr_Cortes.Text)

      Monto_anticipo = monto_corte * (1 + (Func_fmt_double(TxtTasaAnt.Text) * Dias) / (nBasecalculo * 100))
    
      Gr_Cortes.Col = C_MONTO_ANTICIPO: Gr_Cortes.Text = Format$(Monto_anticipo, "###0.0000")
      Total_Final = Total_Final + Format$(Monto_anticipo * Valor_moneda, "#,##0.0000")

      Gr_Cortes.Col = C_MONTO_VP
      dMontoVp = CDbl(Gr_Cortes.Text)

      Gr_Cortes.Col = C_DIFERENCIA:     Gr_Cortes.Text = Format$(CDbl(dMontoVp) - Format$(Monto_anticipo * Valor_moneda, "#,##0.0000"), "######0")
      If i% = Gr_Cortes.Rows - 1 Then Gr_Cortes.Text = CDbl(Gr_Cortes.Text) - 1

   Next i%

   TxtValAnt.Text = Total_Final

End Sub

'si ccalculo   = 'A'  - > calculo valor anticipo
'si ccalculo   = 'T'  - > calculo valor anticipo
Private Function subCalAnticipo(cCalculo As String)

   Dim monto_corte      As Double
   Dim fTasaAnt         As Double
   Dim nBasecalculo     As Integer
   Dim dTipCambio       As Double
   Dim dMontoAnt        As Double
   Dim dMontoVp         As Double
   Dim iPlazo           As Integer

   Gr_Cortes.Row = Gr_Cortes.Row
   iPlazo = DateDiff("d", FecInip, gsBac_Fecp)

   With Gr_Cortes
      nBasecalculo = BaseCalculo()

      dTipCambio = dTipcam#

      ' Capital del corte
      .Col = C_MONTO_INICIO
      monto_corte = CDbl(Gr_Cortes.Text)
        
      ' Calculo de valor anticipo
      If cCalculo = "T" Then
         ' Tasa afecta
         .Col = C_TASA
         fTasaAnt = CDbl(Gr_Cortes.Text)

         ' Calculo monto a rendimiento
         If Val(TxtMoneda.Text) = 999 And Val(TxtMoneda.Text) = 13 Then
            dMontoAnt = Format$(monto_corte * (1 + (fTasaAnt * iPlazo) / (nBasecalculo * 100#)), "############0")

         Else
            dMontoAnt = Format$(monto_corte * (1 + ((fTasaAnt * iPlazo) / (nBasecalculo * 100#))), "############0.0000")

         End If

         ' Actualizo monto anticipado
         .Col = C_MONTO_ANTICIPO
         .Text = Format$(dMontoAnt, "#########0.0000")

         .Col = C_MONTO_ANTICIPO_CLP
         .Text = Format$((dMontoAnt * dTipcam), "############0")

      Else   ' Calculo de Tasa
         .Col = C_MONTO_ANTICIPO_CLP
         dMontoAnt = .Text

         dMontoAnt = Format$(dMontoAnt / dTipcam, "############0.0000")

         .Col = C_MONTO_ANTICIPO
         .Text = dMontoAnt

         fTasaAnt = Format$((((((dMontoAnt / monto_corte) - 1) / iPlazo)) * (nBasecalculo * 100#)), "##0.0000")
         .Col = C_TASA
         .Text = CDbl(fTasaAnt)

      End If

      ' Saco valor Presente del corte
      .Col = C_MONTO_VP
      dMontoVp = Format$(.Text, "###0")
        
      ' Actualizo diferencia
      .Col = C_DIFERENCIA
      .Text = Format$(CDbl(dMontoVp) - Format$(dMontoAnt * dTipcam#, "#,##0.0000"), "######0")

   End With

   Call subMarca
    
End Function

Private Sub subCalTotal()

   Dim i%
   Dim dMontoAnt        As Double
   Dim dMontoAct        As Double

   For i% = 1 To Gr_Cortes.Rows - 1
      Gr_Cortes.Row = i%
      Gr_Cortes.Col = C_MARCA

      If Gr_Cortes.Text = "V" Then
         Gr_Cortes.Col = C_MONTO_ANTICIPO_CLP
         dMontoAnt = dMontoAnt + CDbl(Gr_Cortes.Text)

         Gr_Cortes.Col = C_MONTO_VP
         dMontoAct = dMontoAct + CDbl(Gr_Cortes.Text)

      End If

   Next i%

   TxtValAnt.Text = Format(dMontoAnt, "##,###,###")
   TxtValact.Text = Format(dMontoAct, "##,###,###")
   TxtDeltaAnt.Text = Format(dMontoAct - dMontoAnt, "##,###,###")

End Sub

Private Function TextMatrix(Grilla As Control, Fila As Integer, Columna As Integer, Dato As Variant) As Variant

   Dim fil_g%, col_g%

   fil_g% = Grilla.Row
   col_g% = Grilla.Col

   Grilla.Row = Fila
   Grilla.Col = Columna

   If Dato = "X" Then
      TextMatrix = Grilla.Text

   Else
      Grilla.Text = Dato

   End If

   Grilla.Row = fil_g%
   Grilla.Col = col_g%

End Function

Private Function BaseCalculo() As Integer

   Dim varssql          As String
   Dim varDatos()

   On Error GoTo ErrFind

   BaseCalculo = 1

   varssql = "EXECUTE sp_trae_moneda " & TxtMoneda.Text

   If miSQL.SQL_Execute(varssql) = 0 Then
      Do While miSQL.SQL_Fetch(varDatos()) = 0
         BaseCalculo = varDatos(3)
         DiasMin = varDatos(4)
         Exit Function

      Loop

   End If

   On Error GoTo 0

   Exit Function

ErrFind:
   On Error GoTo 0

   BaseCalculo = 1

   MsgBox "Problemas en busqueda de bases de calculo: " & Err.Description & ".Comunique al Administrador. ", vbCritical, gsBac_Version

   Exit Function

End Function

Private Sub Proc_Limpia_Pantalla()

   txtOperacion.Enabled = True
   txtOperacion.Text = ""
   lblNombre.Caption = ""
   TxtValact.Text = 0
   TxtTasaAnt.Text = 0
   TxtValAnt.Text = 0
   TxtDeltaAnt.Text = 0
   Toolbar1.Buttons(2).Enabled = False
   Toolbar1.Buttons(3).Enabled = False
   Toolbar1.Buttons(4).Enabled = False
   TxtTasaAnt.Enabled = False
   Gr_Cortes.Enabled = False
   Gr_Cortes.Rows = 1
   Show
   txtOperacion.SetFocus
  
End Sub

Sub TitulosGrilla()

   Dim X    As Integer

   With Gr_Cortes

      Gr_Cortes.Cols = 13
      Gr_Cortes.FixedCols = 0
      .RowHeight(0) = 400

      For X = 0 To .Cols - 1
         .FixedAlignment(X) = 4

      Next X

      .ScrollBars = flexScrollBarVertical
      .TextMatrix(0, C_CORTES) = "Num.Corte"
      .TextMatrix(0, C_MONTO_CORTE) = "Monto Corte"
      .TextMatrix(0, C_MONTO_INICIO_PESOS) = "Valor Inicial $$"
      .TextMatrix(0, C_TASA) = "Tasa Interés"
      .TextMatrix(0, C_MONTO_ANTICIPO) = "Valor Anticipo U.M."
      .TextMatrix(0, C_MONTO_ANTICIPO_CLP) = "Valor Anticipo $$"

      .ColWidth(C_CORTES) = 870
      .ColWidth(C_MONTO_CORTE) = 1970
      .ColWidth(C_MONTO_INICIO) = 0
      .ColWidth(C_MONTO_INICIO_PESOS) = 1970
      .ColWidth(C_TASA) = 1500
      .ColWidth(C_MONTO_FINAL) = 0
      .ColWidth(C_MONTO_ANTICIPO) = 1970
      .ColWidth(C_MONTO_ANTICIPO_CLP) = 1970
      .ColWidth(C_DIFERENCIA) = 0
      .ColWidth(C_MONTO_VP) = 0
      .ColWidth(C_MARCA) = 0
      .ColWidth(C_VAL_ANTICIPO) = 0
      .ColWidth(C_CORRELATIVO) = 0

   End With

End Sub

Private Function Trae_Captacion(xOperacion As Double) As Boolean
Dim Numero_Corte        As Double
Dim monto_corte         As Double
Dim Monto_InicioUM      As Double
Dim Monto_Inicio_Pesos  As Double
Dim Monto_Final         As Double
Dim nRow                As Long

    Trae_Captacion = False
    nRow = 0
    
'    Sql = "sp_trae_captacion " & xOperacion
    Envia = Array(xOperacion)

    If Bac_Sql_Execute("sp_trae_captacion", Envia) Then
        Do While Bac_SQL_Fetch(DATOS())
            If DATOS(1) = "N" Then
                MsgBox DATOS(2), vbOKOnly + vbExclamation
                Exit Function
            End If

            lblNombre.Caption = DATOS(4)
            TxtValact.Text = Format(DATOS(5), "##,###,###")
            TxtTasaAnt.Text = DATOS(7)
            TxtValAnt.Text = Format(DATOS(6), "##,###,###")
            TxtDeltaAnt.Text = DATOS(5) - DATOS(6)
            TxtMoneda.Text = DATOS(17)

            With Gr_Cortes

                .Rows = .Rows + 1
                nRow = nRow + 1

                .TextMatrix(nRow, C_CORTES) = Val(DATOS(8))
                .TextMatrix(nRow, C_MONTO_CORTE) = Format(DATOS(9), "###,###,###,##0.0000")
                .TextMatrix(nRow, C_MONTO_INICIO) = DATOS(9)
                .TextMatrix(nRow, C_MONTO_INICIO_PESOS) = Format(DATOS(10), "###,###,###,##0")
                .ForeColor = &H800200
                .TextMatrix(nRow, C_TASA) = Format(DATOS(7), "##0.0000")

                .TextMatrix(nRow, C_MONTO_FINAL) = DATOS(11)
                .TextMatrix(nRow, C_MONTO_ANTICIPO) = Format(DATOS(31), "###,###,###,##0.0000")
                .TextMatrix(nRow, C_MONTO_ANTICIPO_CLP) = Format(DATOS(30), "###,###,###,##0") 'Format$(Datos(11) * CDbl(Datos(29)), "########0")
                .TextMatrix(nRow, C_DIFERENCIA) = DATOS(27)
                .TextMatrix(nRow, C_MONTO_VP) = DATOS(30)
                .TextMatrix(nRow, C_VAL_ANTICIPO) = DATOS(11)
                .TextMatrix(nRow, C_CORRELATIVO) = DATOS(28)

                Fecini.Text = DATOS(19)
                RutCli = Val(DATOS(2))
                Codcli = Val(DATOS(3))
                NomCli = Me.lblNombre.Caption
                FecInip = DATOS(19)
                FecVenp = DATOS(18)
                Msk_Fecha_Vcto.Text = DATOS(18)
                PlazoP = DateDiff("d", FecInip, FecVenp)
                TasaP = DATOS(7)
                BaseP = DATOS(25)
                MonedaP = DATOS(26)
                UmInip = DATOS(20)
                ValInip = DATOS(21)
                UmVenp = DATOS(24)
                ValVenp = DATOS(24)
                dTipcam = DATOS(29)

            End With

        Loop

    End If

    Gr_Cortes.SetFocus
    Trae_Captacion = True

End Function

Private Sub Form_Load()

   Me.Top = 0
   Me.Left = 0
   Toolbar1.Buttons(2).Enabled = False
   Toolbar1.Buttons(3).Enabled = False
   Toolbar1.Buttons(4).Enabled = False

   Proc_Limpia_Pantalla

   TitulosGrilla

End Sub

Private Sub Gr_Cortes_DblClick()

   Gr_Cortes_KeyPress 13

End Sub

Private Sub Gr_Cortes_KeyPress(KeyAscii As Integer)

   With Gr_Cortes
      GuardaFil = .RowSel
      GuardaCol = .ColSel

      If .Col = C_TASA Or .Col = C_MONTO_ANTICIPO_CLP Then
         bFlagEdit = False
         Proc_Posi_Texto Gr_Cortes, TxtTasaAnt
         TxtTasaAnt.Text = .TextMatrix(.RowSel, .ColSel)
         TxtTasaAnt.Visible = True
         TxtTasaAnt.SetFocus

      End If

   End With

End Sub

Private Sub DesMarca()

   Dim dMontoOri        As Double

   Gr_Cortes.Col = C_MARCA
   Gr_Cortes.Text = " "

   Gr_Cortes.Col = C_TASA
   Gr_Cortes.Text = CDbl(TxtTasaAnt.Text)

   Gr_Cortes.Col = C_VAL_ANTICIPO
   dMontoOri = Gr_Cortes.Text

   Gr_Cortes.Col = C_MONTO_ANTICIPO
   Gr_Cortes.Text = CDbl(dMontoOri)

   Gr_Cortes.Col = C_DIFERENCIA
   Gr_Cortes.Text = 0

   Gr_Cortes.Col = C_MONTO_ANTICIPO_CLP
   Gr_Cortes.Text = CDbl(dMontoOri) * dTipcam#

   Gr_Cortes.Rows = Gr_Cortes.Rows - 1
   Gr_Cortes.Refresh

End Sub

Private Sub subMarca()

   Gr_Cortes.Col = C_MARCA
   Gr_Cortes.Text = "V"

End Sub

Private Sub Gr_Cortes_RowColChange()

   bFlagEdit = True

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

   Select Case UCase(Button.Description)
   Case "GRABAR"
      BacIrfGr.proMtoOper = CDbl(TxtValAnt.Text)
      Call BacGrabarTX

   Case "LIMPIAR"
      Call Proc_Limpia_Pantalla

   Case "DATOS"            'Boton de Datos Inicio

      Screen.MousePointer = vbHourglass

      If Val(txtOperacion.Text) = 0 Then
         Screen.MousePointer = vbDefault
         Exit Sub

      End If
      If FecInip = "" Or FecVenp = "" Then
         MsgBox "Numero de operación no es valido", vbExclamation, gsBac_Version
         Screen.MousePointer = vbDefault
         Exit Sub
      End If

      BacIrfPac.TxtFecIni.Text = FecInip
      BacIrfPac.TxtFecVto.Text = FecVenp
      BacIrfPac.TxtPlazop.Text = Val(PlazoP)
      BacIrfPac.TxtTasPac.Text = CDbl(TasaP)
      BacIrfPac.txtbaspac.Text = Val(BaseP)
      BacIrfPac.TxtMonPac.Text = MonedaP
      BacIrfPac.TxtValiniMp.Text = Val(UmInip)
      BacIrfPac.TxtValiniPs.Text = CDbl(ValInip)
      BacIrfPac.TxtValvtoMp.Text = CDbl(UmVenp)
      BacIrfPac.TxtValvtoPs.Text = CDbl(ValVenp)

      BacIrfPac.LblFecIni.Caption = BacDiaSem(FecInip)
      BacIrfPac.LblFecVto.Caption = BacDiaSem(FecVenp)
      BacIrfPac.LblMonIni.Caption = MonedaP
      BacIrfPac.LblMonVto.Caption = MonedaP

      Screen.MousePointer = vbDefault

      BacIrfPac.Caption = "Datos iniciales captación"
      BacIrfPac.Show vbModal
            
   Case "SALIR"
      Unload Me

   End Select

End Sub


Private Sub txtOperacion_KeyPress(KeyAscii As Integer)

   If Not IsNumeric(Chr(KeyAscii)) And KeyAscii <> 8 And KeyAscii <> 13 Then
      KeyAscii = 0

   End If

   If KeyAscii = vbKeyReturn Then
      If Val(txtOperacion.Text) = 0 Then
         txtOperacion.Enabled = True
         txtOperacion.SetFocus
         Exit Sub

      End If

      Gr_Cortes.Enabled = True

      If Not Trae_Captacion(Val(txtOperacion.Text)) Then
         Proc_Limpia_Pantalla
         Toolbar1.Buttons(2).Enabled = False
         Toolbar1.Buttons(3).Enabled = False
         Toolbar1.Buttons(4).Enabled = False
         TxtTasaAnt.Enabled = False
         Exit Sub

      End If
   
      Toolbar1.Buttons(2).Enabled = True
      Toolbar1.Buttons(3).Enabled = True
      Toolbar1.Buttons(4).Enabled = True

      txtOperacion.Enabled = False
      TxtTasaAnt.Enabled = True

   End If

End Sub

Private Sub TxtTasaAnt_GotFocus()

   Dim Col              As Integer
   Dim Row              As Integer
   Dim Value            As String

   With Gr_Cortes
      Row = .Row
      Col = 4
      Value = .Text
   End With

   Gr_Cortes.Row = Row
   Gr_Cortes.Col = Col
   Gr_Cortes.Text = Val(Value)

   If Col = C_TASA Then Call subCalAnticipo("T")
   If Col = C_MONTO_ANTICIPO_CLP Then Call subCalAnticipo("M")

   Call subCalTotal

   Select Case Gr_Cortes.Col
   Case C_TASA
      TxtTasaAnt.Max = 999.99999

   Case C_MONTO_ANTICIPO_CLP
      TxtTasaAnt.Max = 999999999.99999

   End Select

End Sub

Private Sub TxtTasaAnt_KeyPress(KeyAscii As Integer)

   If Chr(KeyAscii) = "." Or Chr(KeyAscii) = "," Then
      KeyAscii = Asc(gsBac_PtoDec)

   End If
       
   If KeyAscii = 27 Then bFlagEdit = True

   If Chr(KeyAscii) = "V" Or Chr(KeyAscii) = "v" Then
      Call subMarca
      Gr_Cortes.Col = C_DIFERENCIA
      Gr_Cortes.Text = 0
      Call subCalTotal
      
   End If

   If Chr(KeyAscii) = "R" Or Chr(KeyAscii) = "r" Then
      Call DesMarca
      Call subCalTotal

   End If

   Select Case Gr_Cortes.Col
   Case C_TASA
      If KeyAscii <> 27 Then
         If Not bFlagEdit Then
            KeyAscii = BacPunto(TxtTasaAnt, KeyAscii, 3, 4)

         End If

         KeyAscii = BACValIngNumGrid(KeyAscii)

      End If

   Case C_MONTO_ANTICIPO_CLP
      If KeyAscii <> 27 Then
         If Not bFlagEdit Then
            KeyAscii = BacPunto(TxtTasaAnt, KeyAscii, 19, 0)

         End If

         KeyAscii = BACValIngNumGrid(KeyAscii)

      End If

   End Select

End Sub

Private Sub TxtTasaAnt_LostFocus()
 
   Call Proc_Calcula_Captacion(0)

   bFlagEdit = True

   Gr_Cortes.Text = TxtTasaAnt.Text
   TxtTasaAnt.Visible = False
   Gr_Cortes.Row = GuardaFil
   Gr_Cortes.Col = GuardaCol
   Gr_Cortes.SetFocus

End Sub

Private Sub TxtValAnt_Change()

   TxtDeltaAnt.Text = TxtValact.Text - TxtValAnt.Text

End Sub

