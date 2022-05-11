VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.2#0"; "mscomctl.ocx"
Object = "{989C9190-EDF5-45A8-AB6C-98E6EF0384D7}#1.0#0"; "Bac_Controles_Pas.ocx"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Begin VB.Form FRM_ACT_BONOS 
   Caption         =   "Actualiza"
   ClientHeight    =   5895
   ClientLeft      =   120
   ClientTop       =   450
   ClientWidth     =   10725
   LinkTopic       =   "Form1"
   ScaleHeight     =   5895
   ScaleWidth      =   10725
   StartUpPosition =   3  'Windows Default
   Begin VB.Frame FRM_VALOR_ESTIMADO 
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1095
      Left            =   120
      TabIndex        =   1
      Top             =   1560
      Width           =   10485
      Begin BACControles.TXTNumero FTB_VALOR_ESTIMADO1 
         Height          =   345
         Left            =   3360
         TabIndex        =   2
         Top             =   270
         Width           =   2025
         _ExtentX        =   3572
         _ExtentY        =   609
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
         Text            =   "0"
         Text            =   "0"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTNumero FTB_VALOR_ESTIMADO2 
         Height          =   345
         Left            =   3360
         TabIndex        =   3
         Top             =   660
         Width           =   2025
         _ExtentX        =   3572
         _ExtentY        =   609
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
         Text            =   "0"
         Text            =   "0"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTNumero FTB_VALOR_ESTIMADO3 
         Height          =   345
         Left            =   7620
         TabIndex        =   4
         Top             =   210
         Width           =   2025
         _ExtentX        =   3572
         _ExtentY        =   609
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
         Text            =   "0"
         Text            =   "0"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTNumero FTB_VALOR_ESTIMADO4 
         Height          =   345
         Left            =   7620
         TabIndex        =   5
         Top             =   600
         Width           =   2025
         _ExtentX        =   3572
         _ExtentY        =   609
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
         Text            =   "0"
         Text            =   "0"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin VB.Label LBL_COMISIONES_PAGADAS_CORREDOR 
         Caption         =   "Tasa estimada"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   540
         TabIndex        =   10
         Top             =   300
         Width           =   2745
      End
      Begin VB.Label LBL_DESCUENTO_BONO 
         Caption         =   "Monto Estimado CLP"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   540
         TabIndex        =   9
         Top             =   660
         Width           =   1665
      End
      Begin VB.Label LBL_OTROS 
         Caption         =   "Otros (Gasto) CLP"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   5700
         TabIndex        =   8
         Top             =   660
         Width           =   1095
      End
      Begin VB.Label LBL_COSTO_EMISION_BONO 
         Caption         =   "Monto Estimado UM"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   5700
         TabIndex        =   7
         Top             =   300
         Width           =   2235
      End
      Begin VB.Label Label1 
         Caption         =   "  Gastos Estimados"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   270
         Left            =   120
         TabIndex        =   6
         Top             =   0
         Width           =   1890
      End
   End
   Begin MSComctlLib.Toolbar Tlb_Menu 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   10725
      _ExtentX        =   18918
      _ExtentY        =   794
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Style           =   1
      ImageList       =   "Img_opciones"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Limpiar"
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Key             =   "Grabar"
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Key             =   "Datos de Emisión"
            Object.ToolTipText     =   "Datos de Emisión"
            ImageIndex      =   26
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      Begin VB.Timer Tmr 
         Interval        =   100
         Left            =   8910
         Top             =   90
      End
      Begin MSComctlLib.ImageList Img_opciones 
         Left            =   6360
         Top             =   0
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   24
         ImageHeight     =   24
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   26
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ACT_BONOS.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ACT_BONOS.frx":0467
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ACT_BONOS.frx":095D
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ACT_BONOS.frx":0DF0
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ACT_BONOS.frx":12D8
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ACT_BONOS.frx":17EB
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ACT_BONOS.frx":1D28
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ACT_BONOS.frx":216A
               Key             =   ""
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ACT_BONOS.frx":2624
               Key             =   ""
            EndProperty
            BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ACT_BONOS.frx":2AF7
               Key             =   ""
            EndProperty
            BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ACT_BONOS.frx":2F3B
               Key             =   ""
            EndProperty
            BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ACT_BONOS.frx":34A2
               Key             =   ""
            EndProperty
            BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ACT_BONOS.frx":3971
               Key             =   ""
            EndProperty
            BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ACT_BONOS.frx":3D90
               Key             =   ""
            EndProperty
            BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ACT_BONOS.frx":4288
               Key             =   ""
            EndProperty
            BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ACT_BONOS.frx":4681
               Key             =   ""
            EndProperty
            BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ACT_BONOS.frx":4B04
               Key             =   ""
            EndProperty
            BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ACT_BONOS.frx":4FCA
               Key             =   ""
            EndProperty
            BeginProperty ListImage19 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ACT_BONOS.frx":54C1
               Key             =   ""
            EndProperty
            BeginProperty ListImage20 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ACT_BONOS.frx":5977
               Key             =   ""
            EndProperty
            BeginProperty ListImage21 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ACT_BONOS.frx":5D3C
               Key             =   ""
            EndProperty
            BeginProperty ListImage22 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ACT_BONOS.frx":6132
               Key             =   ""
            EndProperty
            BeginProperty ListImage23 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ACT_BONOS.frx":6529
               Key             =   ""
            EndProperty
            BeginProperty ListImage24 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ACT_BONOS.frx":6932
               Key             =   ""
            EndProperty
            BeginProperty ListImage25 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ACT_BONOS.frx":6DF0
               Key             =   ""
            EndProperty
            BeginProperty ListImage26 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ACT_BONOS.frx":72B1
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin Threed.SSFrame SFMR_Datos 
      Height          =   675
      Left            =   120
      TabIndex        =   11
      Top             =   600
      Width           =   10485
      _Version        =   65536
      _ExtentX        =   18494
      _ExtentY        =   1191
      _StockProps     =   14
      ForeColor       =   -2147483641
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   3
      Begin VB.TextBox Txt_Total_Operación 
         Alignment       =   1  'Right Justify
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   1800
         TabIndex        =   12
         Text            =   "0"
         Top             =   210
         Width           =   3075
      End
      Begin VB.Label LBL_Total_Operacion 
         Caption         =   "Total Operación"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   270
         Left            =   270
         TabIndex        =   13
         Top             =   255
         Width           =   1530
      End
   End
   Begin MSFlexGridLib.MSFlexGrid Grd_Compra_Bonos 
      Height          =   2715
      Left            =   120
      TabIndex        =   14
      Top             =   2760
      Width           =   10545
      _ExtentX        =   18600
      _ExtentY        =   4789
      _Version        =   393216
      FixedCols       =   0
      RowHeightMin    =   350
      BackColor       =   -2147483644
      ForeColor       =   8388608
      BackColorFixed  =   8421376
      ForeColorFixed  =   16777215
      ForeColorSel    =   16777215
      BackColorBkg    =   -2147483644
      GridColor       =   0
      FocusRect       =   0
      GridLinesFixed  =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin BACControles.TXTNumero txt_Numero_Operacion 
      Height          =   255
      Left            =   10800
      TabIndex        =   15
      Top             =   1080
      Width           =   2085
      _ExtentX        =   3678
      _ExtentY        =   450
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
      Text            =   "0"
      Text            =   "0"
      Separator       =   -1  'True
      MarcaTexto      =   -1  'True
   End
End
Attribute VB_Name = "FRM_ACT_BONOS"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim cSerie        As String
Dim nInstrumento  As Integer
Dim nMoneda       As Integer
Dim cOptLocal     As String
Dim cEstado_ok    As String
Dim TR      As Double
Dim TE      As Double
Dim TV      As Double
Dim TT      As Double
Dim BA      As Double
Dim BF      As Double
Dim Nom     As Double
Dim MT      As Double
Dim VV      As Double
Dim VP      As Double
Dim PVP     As Double
Dim VAN     As Double
Dim FP      As Date
Dim FE      As Date
Dim FV      As Date
Dim FU      As Date
Dim FX      As Date
Dim FC      As Date
Dim CI      As Double
Dim CT      As Double
Dim INDEV   As Double
Dim PRINC   As Double
Dim INCTR   As Double
Dim FIP     As Date
Dim CAP     As Double

Private Sub Form_Activate()
   
   PROC_CARGA_AYUDA Me

   If Grd_Compra_Bonos.Enabled = True Then
      Grd_Compra_Bonos.SetFocus
   End If
   
   Me.Caption = "Colocación de Bonos Propia Emisión, operacion: " & Format(Me.txt_Numero_Operacion.Text, 0)
   
End Sub


Private Sub Form_Load()

   cOptLocal = GLB_cOptLocal
   Me.top = 1080
   Me.left = 60
'´ '   Me.Width = 10695
'   Me.Height = 5550
   Me.Icon = FRM_MDI_PASIVO.Icon
   
'   Me.Caption = "Colocación de Bonos Propia Emisión " & Me.txt_Numero_Operacion.Text

   'Me.Height = 4300
   
   Call FUNC_FORMATO_GRILLA(Grd_Compra_Bonos)

   PROC_TITULOS_GRILLA

'   Call PROC_LOG_AUDITORIA("07", cOptLocal, Me.Caption, "", "")

   DoEvents
   

End Sub
Sub PROC_CARGA_AYUDA(oForm As Form)

'On Error GoTo ERRCARGAAYUDA

'   Dim vDatos_Retorno()

'   GLB_Envia = Array()
'   PROC_AGREGA_PARAMETRO GLB_Envia, "PSV"
'   PROC_AGREGA_PARAMETRO GLB_Envia, oForm.Name
'
'   If FUNC_EXECUTA_COMANDO_SQL("SP_CON_AYUDA_SISTEMA", GLB_Envia) Then 'GoTo ERRCARGAAYUDA
'      If FUNC_LEE_RETORNO_SQL(vDatos_Retorno()) Then ' GoTo ERRCARGAAYUDA
'         If Dir(vDatos_Retorno(1)) <> "" Then  'GoTo ERRCARGAAYUDA
'             App.HelpFile = vDatos_Retorno(1)
'             oForm.HelpContextID = vDatos_Retorno(2)
'         End If
'      End If
'   End If
'   Exit Sub

'ERRCARGAAYUDA:
   
'   App.HelpFile = ""
'   oForm.HelpContextID = 0

End Sub

Function FUNC_FORMATO_GRILLA(Grilla As MSFlexGrid)

   With Grilla
      .ForeColor = GLB_AzulOsc
      .GridLines = flexGridInset
      .GridLinesFixed = flexGridNone
      .ForeColorFixed = GLB_Blanco
      .BackColorFixed = GLB_Verde
      .BackColor = GLB_Gris
      .BackColorBkg = GLB_Gris
      .Font.Name = "Arial"
      .Font.Bold = True
      .Font.Size = 8

   End With

End Function

Sub PROC_TITULOS_GRILLA()

  
   
   Grd_Compra_Bonos.Cols = 21
   Grd_Compra_Bonos.Rows = 2
   
   Grd_Compra_Bonos.ColWidth(0) = 1400
   Grd_Compra_Bonos.ColWidth(1) = 2300
   Grd_Compra_Bonos.ColWidth(2) = 900
   Grd_Compra_Bonos.ColWidth(3) = 900
   Grd_Compra_Bonos.ColWidth(4) = 900
   Grd_Compra_Bonos.ColWidth(5) = 2300
   Grd_Compra_Bonos.ColWidth(6) = 0
   Grd_Compra_Bonos.ColWidth(7) = 0
   Grd_Compra_Bonos.ColWidth(8) = 0
   Grd_Compra_Bonos.ColWidth(9) = 1500
   Grd_Compra_Bonos.ColWidth(10) = 0
   Grd_Compra_Bonos.ColWidth(11) = 0
   Grd_Compra_Bonos.ColWidth(12) = 0
   Grd_Compra_Bonos.ColWidth(13) = 0
   Grd_Compra_Bonos.ColWidth(14) = 0
   
   Grd_Compra_Bonos.ColWidth(15) = 0
   Grd_Compra_Bonos.ColWidth(16) = 0
   Grd_Compra_Bonos.ColWidth(17) = 0
   Grd_Compra_Bonos.ColWidth(18) = 0
   Grd_Compra_Bonos.ColWidth(19) = 0
   Grd_Compra_Bonos.ColWidth(20) = 0
   
   Grd_Compra_Bonos.TextMatrix(0, 0) = "Serie"
   Grd_Compra_Bonos.TextMatrix(0, 1) = "Nominal"
   Grd_Compra_Bonos.TextMatrix(0, 2) = "%Tir"
   Grd_Compra_Bonos.TextMatrix(0, 3) = "Base"
   Grd_Compra_Bonos.TextMatrix(0, 4) = "%Var"
   Grd_Compra_Bonos.TextMatrix(0, 5) = "Precio"
   Grd_Compra_Bonos.TextMatrix(0, 9) = "Fecha Col."
   
   Grd_Compra_Bonos.ColAlignment(0) = flexAlignLeftCenter
   Grd_Compra_Bonos.ColAlignment(1) = flexAlignRightCenter
   Grd_Compra_Bonos.ColAlignment(2) = flexAlignRightCenter
   Grd_Compra_Bonos.ColAlignment(3) = flexAlignRightCenter
   Grd_Compra_Bonos.ColAlignment(4) = flexAlignRightCenter
   Grd_Compra_Bonos.ColAlignment(5) = flexAlignRightCenter
   Grd_Compra_Bonos.ColAlignment(9) = flexAlignRightCenter

   Grd_Compra_Bonos.TextMatrix(1, 0) = ""
   Grd_Compra_Bonos.TextMatrix(1, 1) = Format(0, GLB_Formato_Decimal)
   Grd_Compra_Bonos.TextMatrix(1, 2) = Format(0, GLB_Formato_Decimal)
   Grd_Compra_Bonos.TextMatrix(1, 3) = Format(0, GLB_Formato_Entero)
   Grd_Compra_Bonos.TextMatrix(1, 4) = Format(0, GLB_Formato_Decimal)
   Grd_Compra_Bonos.TextMatrix(1, 5) = Format(0, GLB_Formato_Entero)
   Grd_Compra_Bonos.TextMatrix(1, 9) = GLB_Fecha_Proceso
   
End Sub

Private Sub Form_Unload(Cancel As Integer)

   Call PROC_LOG_AUDITORIA("08", cOptLocal, Me.Caption, "", "")
   
   If Me.txt_Numero_Operacion.Text <> 0 Then
      FRM_CONSULTA_OPERACIONES.Show
   End If

End Sub

Private Sub Tlb_Menu_ButtonClick(ByVal Button As MSComctlLib.Button)

   Select Case Trim(UCase(Button.Key))
   
      Case "LIMPIAR"
          
'          Call PROC_LIMPIAR_PANTALLA
          
      Case "DATOS DE EMISIÓN"
          
'          Call PROC_DATOS_EMISION
      
      Case "GRABAR"
            Call PROC_GRABAR_BONOS
          
'          If GLB_Tipo_llamado = "M" Then
'            Call PROC_GRABAR_ESTIMADO
'          Else
'            Call PROC_GRABAR_BONOS
'          End If
          
'          If GLB_Aceptar% = True And GLB_Tipo_llamado <> "M" Then
'              Call PROC_LIMPIAR_PANTALLA
'          End If
               
      Case "SALIR"
          
          Unload Me
   
   End Select
   
End Sub

Sub PROC_GRABAR_BONOS()

Dim vDatos_Retorno()


    GLB_Envia = Array()
    PROC_AGREGA_PARAMETRO GLB_Envia, CDbl(Me.txt_Numero_Operacion.Text)
    PROC_AGREGA_PARAMETRO GLB_Envia, CDbl(Me.FTB_VALOR_ESTIMADO1.Text)
    PROC_AGREGA_PARAMETRO GLB_Envia, CDbl(Me.FTB_VALOR_ESTIMADO2.Text)
    PROC_AGREGA_PARAMETRO GLB_Envia, CDbl(Me.FTB_VALOR_ESTIMADO3.Text)
    PROC_AGREGA_PARAMETRO GLB_Envia, CDbl(Me.FTB_VALOR_ESTIMADO4.Text)

    If FUNC_EXECUTA_COMANDO_SQL("SP_ACT_OPERACION_MONTOS", GLB_Envia) Then
            MsgBox "Operacion Actualizada", vbInformation
            Call PROC_LOG_AUDITORIA("19", "Trader", Me.Caption & " Operacion Actualizada: " & GLB_Usuario_Bac, "", "")
    End If

End Sub
