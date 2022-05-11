VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.2#0"; "mscomctl.ocx"
Object = "{989C9190-EDF5-45A8-AB6C-98E6EF0384D7}#1.0#0"; "Bac_Controles_Pas.ocx"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Begin VB.Form FRM_ING_BONOS 
   AutoRedraw      =   -1  'True
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Colocación de Bonos Propia emisión"
   ClientHeight    =   8115
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   12810
   Icon            =   "FRM_ING_BONOS.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   8115
   ScaleWidth      =   12810
   Begin BACControles.TXTFecha TXTFecha1 
      Height          =   285
      Left            =   7560
      TabIndex        =   17
      Top             =   2910
      Visible         =   0   'False
      Width           =   1215
      _ExtentX        =   2143
      _ExtentY        =   503
      BackColor       =   -2147483634
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
      ForeColor       =   -2147483635
      MaxDate         =   2958465
      MinDate         =   -328716
      Text            =   "31/08/2009"
   End
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
      Left            =   0
      TabIndex        =   8
      Top             =   1140
      Width           =   10485
      Begin BACControles.TXTNumero FTB_VALOR_ESTIMADO1 
         Height          =   345
         Left            =   3360
         TabIndex        =   13
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
         TabIndex        =   14
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
         TabIndex        =   15
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
         TabIndex        =   16
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
         TabIndex        =   18
         Top             =   0
         Width           =   1890
      End
      Begin VB.Label LBL_COSTO_EMISION_BONO 
         Caption         =   "Costo Emisión Bono"
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
         TabIndex        =   12
         Top             =   300
         Width           =   2235
      End
      Begin VB.Label LBL_OTROS 
         Caption         =   "Otros"
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
         TabIndex        =   11
         Top             =   660
         Width           =   1095
      End
      Begin VB.Label LBL_DESCUENTO_BONO 
         Caption         =   "Descuento Bono"
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
         Top             =   660
         Width           =   1665
      End
      Begin VB.Label LBL_COMISIONES_PAGADAS_CORREDOR 
         Caption         =   "Comisiones Pagadas a Corredor"
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
         Top             =   300
         Width           =   2745
      End
   End
   Begin VB.TextBox Txt_Texto 
      BackColor       =   &H8000000E&
      BorderStyle     =   0  'None
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
      Height          =   315
      Left            =   4050
      TabIndex        =   6
      TabStop         =   0   'False
      Top             =   3090
      Visible         =   0   'False
      Width           =   980
   End
   Begin BACControles.TXTNumero Txt_Grilla 
      Height          =   255
      Left            =   5190
      TabIndex        =   4
      TabStop         =   0   'False
      Top             =   3240
      Visible         =   0   'False
      Width           =   1095
      _ExtentX        =   1931
      _ExtentY        =   450
      BackColor       =   -2147483634
      ForeColor       =   -2147483635
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
      Appearance      =   0
      BorderStyle     =   0
      Text            =   "0"
      Text            =   "0"
      Min             =   "1"
      Max             =   "99999"
      Separator       =   -1  'True
   End
   Begin MSFlexGridLib.MSFlexGrid Grd_Compra_Bonos 
      Height          =   2715
      Left            =   0
      TabIndex        =   3
      Top             =   2250
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
   Begin Threed.SSFrame SFMR_Datos 
      Height          =   675
      Left            =   0
      TabIndex        =   1
      Top             =   480
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
         TabIndex        =   5
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
         TabIndex        =   2
         Top             =   255
         Width           =   1530
      End
   End
   Begin MSComctlLib.Toolbar Tlb_Menu 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   12810
      _ExtentX        =   22595
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
               Picture         =   "FRM_ING_BONOS.frx":2EFA
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_BONOS.frx":3361
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_BONOS.frx":3857
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_BONOS.frx":3CEA
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_BONOS.frx":41D2
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_BONOS.frx":46E5
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_BONOS.frx":4C22
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_BONOS.frx":5064
               Key             =   ""
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_BONOS.frx":551E
               Key             =   ""
            EndProperty
            BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_BONOS.frx":59F1
               Key             =   ""
            EndProperty
            BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_BONOS.frx":5E35
               Key             =   ""
            EndProperty
            BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_BONOS.frx":639C
               Key             =   ""
            EndProperty
            BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_BONOS.frx":686B
               Key             =   ""
            EndProperty
            BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_BONOS.frx":6C8A
               Key             =   ""
            EndProperty
            BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_BONOS.frx":7182
               Key             =   ""
            EndProperty
            BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_BONOS.frx":757B
               Key             =   ""
            EndProperty
            BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_BONOS.frx":79FE
               Key             =   ""
            EndProperty
            BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_BONOS.frx":7EC4
               Key             =   ""
            EndProperty
            BeginProperty ListImage19 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_BONOS.frx":83BB
               Key             =   ""
            EndProperty
            BeginProperty ListImage20 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_BONOS.frx":8871
               Key             =   ""
            EndProperty
            BeginProperty ListImage21 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_BONOS.frx":8C36
               Key             =   ""
            EndProperty
            BeginProperty ListImage22 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_BONOS.frx":902C
               Key             =   ""
            EndProperty
            BeginProperty ListImage23 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_BONOS.frx":9423
               Key             =   ""
            EndProperty
            BeginProperty ListImage24 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_BONOS.frx":982C
               Key             =   ""
            EndProperty
            BeginProperty ListImage25 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_BONOS.frx":9CEA
               Key             =   ""
            EndProperty
            BeginProperty ListImage26 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_ING_BONOS.frx":A1AB
               Key             =   ""
            EndProperty
         EndProperty
      End
      Begin VB.Timer Tmr 
         Interval        =   100
         Left            =   8910
         Top             =   90
      End
   End
   Begin BACControles.TXTNumero txt_Numero_Operacion 
      Height          =   255
      Left            =   3870
      TabIndex        =   7
      Top             =   2250
      Visible         =   0   'False
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
Attribute VB_Name = "FRM_ING_BONOS"
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
   
End Sub
Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
Dim nOpcion As Integer

    If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) Then
    
    nOpcion = 0
       
       Select Case KeyCode
    
             Case vbKeyLimpiar
             
                   nOpcion = 1
    
             Case vbKeyGrabar
             
                   nOpcion = 2
            
             Case vbKeyVistaPrevia
             
                   nOpcion = 3
             
             Case vbKeySalir
                If Me.ActiveControl.Name <> "Txt_Texto" And Me.ActiveControl.Name <> "Txt_Grilla" And Me.ActiveControl.Name <> "TXTFecha1" Then
                   nOpcion = 4
                End If
       End Select
    
       If nOpcion <> 0 Then
          
          If Tlb_Menu.Buttons(nOpcion).Enabled Then
             
             Call TLB_Menu_ButtonClick(Tlb_Menu.Buttons(nOpcion))
          
          End If
       
       End If
    
    End If

End Sub

Private Sub Form_Load()

   cOptLocal = GLB_cOptLocal
   Me.top = 0
   Me.left = 0
   'Me.Width = 10695
   'Me.Height = 5550
   Me.Icon = FRM_MDI_PASIVO.Icon
   Me.Caption = "Colocación de Bonos Propia Emisión"

   'Me.Height = 4300
   
   Call FUNC_FORMATO_GRILLA(Grd_Compra_Bonos)

   PROC_TITULOS_GRILLA

   Call PROC_LOG_AUDITORIA("07", cOptLocal, Me.Caption, "", "")

   DoEvents
   
End Sub

Private Sub Form_Unload(Cancel As Integer)

   Call PROC_LOG_AUDITORIA("08", cOptLocal, Me.Caption, "", "")
   
   If Me.txt_Numero_Operacion.Text <> 0 Then
      FRM_CONSULTA_OPERACIONES.Show
   End If


End Sub


Private Sub FTB_VALOR_ESTIMADO1_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then Call FUNC_ENVIA_TECLA(vbKeyTab)
            
End Sub

Private Sub FTB_VALOR_ESTIMADO2_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then Call FUNC_ENVIA_TECLA(vbKeyTab)
End Sub

Private Sub FTB_VALOR_ESTIMADO3_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then Call FUNC_ENVIA_TECLA(vbKeyTab)
End Sub
Private Sub FTB_VALOR_ESTIMADO4_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then Call FUNC_ENVIA_TECLA(vbKeyTab)
End Sub
Private Sub Grd_Compra_Bonos_DblClick()
   
   Grd_Compra_Bonos_KeyPress (13)

End Sub
Private Sub Grd_Compra_Bonos_KeyDown(KeyCode As Integer, Shift As Integer)
Dim nContador As Integer
Dim vDatos_Retorno()

   If Me.txt_Numero_Operacion.Text <> 0 Then Exit Sub


   If KeyCode = vbKeyInsert Then
      
'      For nContador = 1 To Grd_Compra_Bonos.Rows - 1
'         If Trim(Grd_Compra_Bonos.TextMatrix(nContador, 0)) = "" Then
'            MsgBox "Falta serie en fila Nº" & nContador, vbExclamation
'            DoEvents
'            Grd_Compra_Bonos.SetFocus
'            Exit Sub
'         End If
'         If CDbl(Trim(Grd_Compra_Bonos.TextMatrix(nContador, 1))) = 0 Then
'            MsgBox "Falta nominal en fila Nº" & nContador, vbExclamation
'            DoEvents
'            Grd_Compra_Bonos.SetFocus
'            Exit Sub
'         End If
'         If CDbl(Grd_Compra_Bonos.TextMatrix(nContador, 2)) = 0 Then
'            MsgBox "Falta % tir en fila Nº" & nContador, vbExclamation
'            DoEvents
'            Grd_Compra_Bonos.SetFocus
'            Exit Sub
'         End If
'         If CDbl(Grd_Compra_Bonos.TextMatrix(nContador, 3)) = 0 Then
'            MsgBox "Falta base en fila Nº" & nContador, vbExclamation
'            DoEvents
'            Grd_Compra_Bonos.SetFocus
'            Exit Sub
'         End If
'         If CDbl(Grd_Compra_Bonos.TextMatrix(nContador, 4)) = 0 Then
'            MsgBox "Falta %var en fila Nº" & nContador, vbExclamation
'            DoEvents
'            Grd_Compra_Bonos.SetFocus
'            Exit Sub
'         End If
'         If CDbl(Grd_Compra_Bonos.TextMatrix(nContador, 5)) = 0 Then
'            MsgBox "Falta precio en fila Nº" & nContador, vbExclamation
'            DoEvents
'            Grd_Compra_Bonos.SetFocus
'            Exit Sub
'         End If
'      Next
'
'      Grd_Compra_Bonos.Rows = Grd_Compra_Bonos.Rows + 1
'      Grd_Compra_Bonos.Row = Grd_Compra_Bonos.Rows - 1
'      Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, 0) = ""
'      Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, 1) = Format(0, GLB_Formato_Decimal)
'      Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, 2) = Format(0, GLB_Formato_Decimal)
'      Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, 3) = Format(0, GLB_Formato_Entero)
'      Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, 4) = Format(0, GLB_Formato_Decimal)
'      Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, 5) = Format(0, GLB_Formato_Entero)
'      Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, 9) = GLB_Fecha_Proceso
'      Grd_Compra_Bonos.Col = 0
'
'      DoEvents
'      Grd_Compra_Bonos.SetFocus
   
   End If
   
   If KeyCode = vbKeyDelete Then
   
      If Grd_Compra_Bonos.Rows = 2 Then
         Grd_Compra_Bonos.TextMatrix(1, 0) = ""
         Grd_Compra_Bonos.TextMatrix(1, 1) = Format(0, GLB_Formato_Decimal)
         Grd_Compra_Bonos.TextMatrix(1, 2) = Format(0, GLB_Formato_Decimal)
         Grd_Compra_Bonos.TextMatrix(1, 3) = Format(0, GLB_Formato_Entero)
         Grd_Compra_Bonos.TextMatrix(1, 4) = Format(0, GLB_Formato_Decimal)
         Grd_Compra_Bonos.TextMatrix(1, 5) = Format(0, GLB_Formato_Entero)
         Grd_Compra_Bonos.TextMatrix(1, 9) = GLB_Fecha_Proceso
         DoEvents
         Grd_Compra_Bonos.SetFocus
         Exit Sub
      End If
      
         Grd_Compra_Bonos.RemoveItem (Grd_Compra_Bonos.Row)
         
      DoEvents
      Grd_Compra_Bonos.SetFocus
      
   End If
   

End Sub

Private Sub Grd_Compra_Bonos_KeyPress(KeyAscii As Integer)
Dim Moneda_Emision As Integer
Dim vDatos_Retorno()

   If Me.txt_Numero_Operacion.Text <> 0 Then Exit Sub
   
   If KeyAscii = 86 Or KeyAscii = 7 Or KeyAscii = 22 Or KeyAscii = 9 Then Exit Sub
   
   'If Grd_Compra_Bonos.Col > 0 And (KeyAscii < 48 Or KeyAscii > 57) Then Exit Sub
   If KeyAscii = 12 Then Exit Sub
   If KeyAscii = 71 Then Exit Sub

   If Grd_Compra_Bonos.Col = 3 Then
      Grd_Compra_Bonos.Col = Grd_Compra_Bonos.Col + 1
      Exit Sub
   End If

   If Grd_Compra_Bonos.Col > 0 And Trim(Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, 0)) = "" Then Exit Sub

   If Grd_Compra_Bonos.Col = 0 Then
   
      TXT_Texto.MaxLength = 12
   
   ElseIf Grd_Compra_Bonos.Col = 1 Then
   
      TXT_Grilla.CantidadDecimales = 4
      TXT_Grilla.Max = 9999999999999#
      TXT_Grilla.Min = 1
   
   ElseIf Grd_Compra_Bonos.Col = 5 Then
        GLB_Envia = Array()
        PROC_AGREGA_PARAMETRO GLB_Envia, 0
        PROC_AGREGA_PARAMETRO GLB_Envia, Mid(FRM_ING_BONOS.Grd_Compra_Bonos.TextMatrix(1, 0), 1, 12)
    
        If FUNC_EXECUTA_COMANDO_SQL("SP_CON_SERIES", GLB_Envia) Then
        
            If FUNC_LEE_RETORNO_SQL(vDatos_Retorno()) Then
                Moneda_Emision = vDatos_Retorno(6)
            End If
        End If
        
        If Moneda_Emision = 999 Or Moneda_Emision = 994 Or Moneda_Emision = 998 Then
            TXT_Grilla.CantidadDecimales = 0
            TXT_Grilla.Max = 9999999999999#
            TXT_Grilla.Min = 1
        Else
            TXT_Grilla.CantidadDecimales = 2
            TXT_Grilla.Max = 9999999999999#
            TXT_Grilla.Min = 1
        End If
   
   ElseIf Grd_Compra_Bonos.Col = 2 Or Grd_Compra_Bonos.Col = 4 Then
   
      TXT_Grilla.CantidadDecimales = 4
      TXT_Grilla.Max = 999
      TXT_Grilla.Min = -999
   
   ElseIf Grd_Compra_Bonos.Col = 3 Then
   
      TXT_Grilla.CantidadDecimales = 0
      TXT_Grilla.Max = 999
      TXT_Grilla.Min = 1
      
   End If

   If Grd_Compra_Bonos.Col = 0 Then
   
      TXT_Texto.top = Grd_Compra_Bonos.CellTop + Grd_Compra_Bonos.top + 50
      TXT_Texto.left = Grd_Compra_Bonos.CellLeft + Grd_Compra_Bonos.left + 30
      TXT_Texto.Width = Grd_Compra_Bonos.CellWidth - 50
      TXT_Texto.Height = Grd_Compra_Bonos.CellHeight - 40
      TXT_Texto.Visible = True
   
   ElseIf Grd_Compra_Bonos.Col = 9 Then
      
      TXTFecha1.top = Grd_Compra_Bonos.CellTop + Grd_Compra_Bonos.top + 40
      TXTFecha1.left = Grd_Compra_Bonos.CellLeft + Grd_Compra_Bonos.left + 25
      TXTFecha1.Width = Grd_Compra_Bonos.CellWidth - 30
      TXTFecha1.Height = Grd_Compra_Bonos.CellHeight - 30
      TXTFecha1.Visible = True
   
   Else
   
      TXT_Grilla.top = Grd_Compra_Bonos.CellTop + Grd_Compra_Bonos.top + 40
      TXT_Grilla.left = Grd_Compra_Bonos.CellLeft + Grd_Compra_Bonos.left + 25
      TXT_Grilla.Width = Grd_Compra_Bonos.CellWidth - 30
      TXT_Grilla.Height = Grd_Compra_Bonos.CellHeight - 30
      TXT_Grilla.Visible = True
      
   End If
   
   If KeyAscii = 13 Then
   
      If Grd_Compra_Bonos.Col = 0 Or Grd_Compra_Bonos.Col = 1 Then
      
         TXT_Texto.Text = Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, Grd_Compra_Bonos.Col)
         
      ElseIf Grd_Compra_Bonos.Col = 9 Then
      
        TXTFecha1.Text = CDate(Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, Grd_Compra_Bonos.Col))
      
      Else
      
         TXT_Grilla.Text = CDbl(Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, Grd_Compra_Bonos.Col))
         
      End If
   
   Else
   
      If Grd_Compra_Bonos.Col = 0 Then
         
         PROC_TO_CASE KeyAscii
         TXT_Texto.Text = Chr(KeyAscii)
      
      Else
         
         TXT_Grilla.Text = Chr(KeyAscii)
      
      End If
   
   End If
   
   If Grd_Compra_Bonos.Col = 0 Then
      
      TXT_Texto.SetFocus
   
   ElseIf Grd_Compra_Bonos.Col = 9 Then
   
    TXTFecha1.SetFocus
   Else
      
      TXT_Grilla.SetFocus
   
   End If

End Sub
'Private Sub Tmr_Timer()
'
'   PROC_TOTALES
'
'End Sub


Private Sub TLB_Menu_ButtonClick(ByVal Button As MSComctlLib.Button)

   Select Case Trim(UCase(Button.Key))
   
      Case "LIMPIAR"
          
          Call PROC_LIMPIAR_PANTALLA
          
      Case "DATOS DE EMISIÓN"
          
          Call PROC_DATOS_EMISION
      
      Case "GRABAR"
          
          If GLB_Tipo_llamado = "M" Then
            Call PROC_GRABAR_ESTIMADO
          Else
            Call PROC_GRABAR_BONOS
          End If
          
          If GLB_Aceptar% = True And GLB_Tipo_llamado <> "M" Then
              Call PROC_LIMPIAR_PANTALLA
          End If
               
      Case "SALIR"
          
          Unload Me
   
   End Select
   
End Sub

Private Sub PROC_LIMPIAR_PANTALLA()
    
   PROC_TITULOS_GRILLA
   Tlb_Menu.Buttons(2).Enabled = False
   Tlb_Menu.Buttons(3).Enabled = False
   Me.Txt_Total_Operación.Text = 0
   Grd_Compra_Bonos.SetFocus
   Grd_Compra_Bonos.Col = 0
    Me.FTB_VALOR_ESTIMADO1.Text = 0
    Me.FTB_VALOR_ESTIMADO2.Text = 0
    Me.FTB_VALOR_ESTIMADO3.Text = 0
    Me.FTB_VALOR_ESTIMADO4.Text = 0
    Me.FTB_VALOR_ESTIMADO1.CantidadDecimales = 0
    Me.FTB_VALOR_ESTIMADO2.CantidadDecimales = 0
    Me.FTB_VALOR_ESTIMADO3.CantidadDecimales = 0
    Me.FTB_VALOR_ESTIMADO4.CantidadDecimales = 0

End Sub

Private Sub PROC_DATOS_EMISION()

   If Mid(Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, 0), 1, 12) <> "" Then
 
      GLB_Serie = Mid(Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, 0), 1, 12)
      GLB_Instrumento = 0
      FRM_MAN_DATOS_EMISION.Show 1
   
   End If

End Sub

Private Sub PROC_GRABAR_BONOS()

      For nContador = 1 To Grd_Compra_Bonos.Rows - 1
         If Trim(Grd_Compra_Bonos.TextMatrix(nContador, 0)) = "" Then
            MsgBox "Falta serie en fila Nº" & nContador, vbExclamation
            DoEvents
            Grd_Compra_Bonos.SetFocus
            Exit Sub
         End If
         If CDbl(Trim(Grd_Compra_Bonos.TextMatrix(nContador, 1))) = 0 Then
            MsgBox "Falta nominal en fila Nº" & nContador, vbExclamation
            DoEvents
            Grd_Compra_Bonos.SetFocus
            Exit Sub
         End If
         If CDbl(Grd_Compra_Bonos.TextMatrix(nContador, 2)) = 0 Then
            MsgBox "Falta % tir en fila Nº" & nContador, vbExclamation
            DoEvents
            Grd_Compra_Bonos.SetFocus
            Exit Sub
         End If
         If CDbl(Grd_Compra_Bonos.TextMatrix(nContador, 3)) = 0 Then
            MsgBox "Falta base en fila Nº" & nContador, vbExclamation
            DoEvents
            Grd_Compra_Bonos.SetFocus
            Exit Sub
         End If
         If CDbl(Grd_Compra_Bonos.TextMatrix(nContador, 4)) = 0 And CDbl(Trim(Grd_Compra_Bonos.TextMatrix(nContador, 6))) = 15 Then
            MsgBox "Falta %var en fila Nº" & nContador, vbExclamation
            DoEvents
            Grd_Compra_Bonos.SetFocus
            Exit Sub
         End If
         If CDbl(Grd_Compra_Bonos.TextMatrix(nContador, 5)) = 0 Then
            MsgBox "Falta precio en fila Nº" & nContador, vbExclamation
            DoEvents
            Grd_Compra_Bonos.SetFocus
            Exit Sub
         End If
      Next

   GLB_Formulario = Me.Name
   
   FRM_ING_GRABACION.Show 1

End Sub

Function FUNC_CALCULOS(nModCal As Integer, nFila As Integer)

Dim vDatos_Retorno()
Dim ntasa_emision As Double
Dim dfecha_emision As Date
Dim dFecha_Vence As Date
Dim nValor_Base As Double
Dim nMoneda_Emision As Double

If Grd_Compra_Bonos.TextMatrix(nFila, 1) = "" Then Exit Function
If Grd_Compra_Bonos.TextMatrix(nFila, 2) = "." Then Exit Function
If Grd_Compra_Bonos.TextMatrix(nFila, 1) = "." Then Exit Function
If Grd_Compra_Bonos.TextMatrix(nFila, 1) = "." Then Exit Function


FUNC_CALCULOS = False

'If Grd_Compra_Bonos.TextMatrix(nFila, 2) = "" Then Exit Function

    GLB_Envia = Array()
    PROC_AGREGA_PARAMETRO GLB_Envia, 0
    PROC_AGREGA_PARAMETRO GLB_Envia, Mid(FRM_ING_BONOS.Grd_Compra_Bonos.TextMatrix(nFila, 0), 1, 12)

    If FUNC_EXECUTA_COMANDO_SQL("SP_CON_SERIES", GLB_Envia) Then
    
        If FUNC_LEE_RETORNO_SQL(vDatos_Retorno()) Then
            
            ntasa_emision = vDatos_Retorno(4)
            dfecha_emision = vDatos_Retorno(14)
            dFecha_Vence = vDatos_Retorno(13)
            nValor_Base = vDatos_Retorno(5)
            nMoneda_Emision = vDatos_Retorno(6)
               
            Grd_Compra_Bonos.TextMatrix(nFila, 3) = CDbl(vDatos_Retorno(5))
            
        End If
    End If
        
    If nModCal = 2 Then
        
        Nom = CDbl(Me.Grd_Compra_Bonos.TextMatrix(nFila, 1))
        TR = CDbl(Me.Grd_Compra_Bonos.TextMatrix(nFila, 2))
        MT = 0
        PVP = 0
    
    End If
    
    If nModCal = 1 Then
        
        Nom = CDbl(Me.Grd_Compra_Bonos.TextMatrix(nFila, 1))
        PVP = CDbl(Me.Grd_Compra_Bonos.TextMatrix(nFila, 4))
        TR = 0
        MT = 0
    
    End If
    
    If nModCal = 3 Then
        
        Nom = CDbl(Me.Grd_Compra_Bonos.TextMatrix(nFila, 1))
        PVP = 0
        TR = 0
        MT = CDbl(Me.Grd_Compra_Bonos.TextMatrix(nFila, 5))
    
    End If
    
    TE = ntasa_emision
    TV = ntasa_emision
    TT = 0
    BF = 0
    VV = 0
    VP = 0
    VAN = 0
    FP = GLB_Fecha_Proceso
    FE = dfecha_emision
    FV = dFecha_Vence
    FC = GLB_Fecha_Proceso
    FP = Format(FP, "DD/MM/YYYY")
    FE = Format(FE, "DD/MM/YYYY")
    FV = Format(FV, "DD/MM/YYYY")
    FC = Format(FC, "DD/MM/YYYY")
    INDEV = 0
    PRINC = 0
    FIP = Format(FIP, "DD/MM/YYYY")
    INCTR = 0
    CAP = 0
    BA = nValor_Base
    
      GLB_Envia = Array()
    
      PROC_AGREGA_PARAMETRO GLB_Envia, nModCal
      PROC_AGREGA_PARAMETRO GLB_Envia, Format(Me.Grd_Compra_Bonos.TextMatrix(nFila, 9), "YYYYMMDD")
      PROC_AGREGA_PARAMETRO GLB_Envia, Val(Me.Grd_Compra_Bonos.TextMatrix(nFila, 6))
      PROC_AGREGA_PARAMETRO GLB_Envia, Trim(Mid(FRM_ING_BONOS.Grd_Compra_Bonos.TextMatrix(nFila, 0), 1, 12))
      PROC_AGREGA_PARAMETRO GLB_Envia, nMoneda_Emision
      PROC_AGREGA_PARAMETRO GLB_Envia, Format(FE, "YYYYMMDD")
      PROC_AGREGA_PARAMETRO GLB_Envia, Format(FV, "YYYYMMDD")
      PROC_AGREGA_PARAMETRO GLB_Envia, TE
      PROC_AGREGA_PARAMETRO GLB_Envia, BA
      PROC_AGREGA_PARAMETRO GLB_Envia, TE 'tasa estimada
      PROC_AGREGA_PARAMETRO GLB_Envia, Nom
      PROC_AGREGA_PARAMETRO GLB_Envia, TR
      PROC_AGREGA_PARAMETRO GLB_Envia, PVP
      PROC_AGREGA_PARAMETRO GLB_Envia, MT

   If Not FUNC_EXECUTA_COMANDO_SQL("SP_PRO_VALORIZA_USUARIO", GLB_Envia) Then
        
        Screen.MousePointer = 0
        Exit Function
   
   Else
        
        Do While FUNC_LEE_RETORNO_SQL(vDatos_Retorno)
            
            If vDatos_Retorno(1) <> "NO" Then
               If CDbl(Grd_Compra_Bonos.TextMatrix(nFila, 1)) <> 0 Then
                  If Grd_Compra_Bonos.Col <> 2 Then
                     Grd_Compra_Bonos.TextMatrix(nFila, 2) = Format(CDbl(vDatos_Retorno(3)), GLB_Formato_Decimal)
                  End If
                  If Grd_Compra_Bonos.Col <> 5 Then
                        If nMoneda_Emision = 999 Or nMoneda_Emision = 994 Or nMoneda_Emision = 998 Then
                          Grd_Compra_Bonos.TextMatrix(nFila, 5) = Format(CDbl(vDatos_Retorno(5)), GLB_Formato_Entero)
                        Else
                          Grd_Compra_Bonos.TextMatrix(nFila, 5) = Format(CDbl(vDatos_Retorno(5)), GLB_Formato_Decimal)
                        End If
                  End If
                  If Grd_Compra_Bonos.Col <> 4 Then
                     If nModCal <> 1 Then
                        Grd_Compra_Bonos.TextMatrix(nFila, 4) = Format(CDbl(vDatos_Retorno(4)), GLB_Formato_Decimal)
                     End If
                  End If
               End If
               Call PROC_TOTALES
               If IsDate(vDatos_Retorno(16)) = True Then
                    GLB_FecpCupon = vDatos_Retorno(16) ' Fecha primer cupón
               End If
               GLB_FecuCupon = vDatos_Retorno(11) ' Fecha ultimo cupón
            Else
               Screen.MousePointer = 0
               MsgBox vDatos_Retorno(2), vbExclamation
               Exit Function
           End If
   
        Loop
   
   End If

   Screen.MousePointer = 0

FUNC_CALCULOS = True

End Function

Private Sub PROC_TOTALES()

Dim nContador As Integer
Dim nMonto    As Double

   nMonto = 0
   
   For nContador = 1 To FRM_ING_BONOS.Grd_Compra_Bonos.Rows - 1
   
       If Trim(Grd_Compra_Bonos.TextMatrix(nContador, 5)) = "" Then Exit Sub
       
       nMonto = nMonto + CDbl(Grd_Compra_Bonos.TextMatrix(nContador, 5))
       
       If (Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, 1) = "" _
         Or Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, 1) = "0,0000") _
         Or (Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, 2) = "" _
         Or Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, 2) = "0,0000") Then
            Exit Sub
       End If
       
   Next nContador
   
   If Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, 8) = 999 Or Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, 8) = 998 Or Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, 8) = 994 Then
    Me.Txt_Total_Operación.Text = Format(nMonto, GLB_Formato_Entero)
   Else
    Me.Txt_Total_Operación.Text = Format(nMonto, GLB_Formato_Decimal)
   End If
   
   If nMonto > 0 Then
      If txt_Numero_Operacion.Text = 0 Then
         Tlb_Menu.Buttons(2).Enabled = True
      End If
   Else
      If txt_Numero_Operacion.Text = 0 Then
         Tlb_Menu.Buttons(2).Enabled = False
      End If
   End If

End Sub

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
Private Sub Txt_Grilla_GotFocus()

   TXT_Grilla.SelStart = 1

End Sub

Private Sub Txt_Grilla_KeyPress(KeyAscii As Integer)
Dim nContador As Integer
Dim vDatos_Retorno()
Dim Moneda_Emision As Integer

   PROC_TO_CASE KeyAscii

    GLB_Envia = Array()
    PROC_AGREGA_PARAMETRO GLB_Envia, 0
    PROC_AGREGA_PARAMETRO GLB_Envia, Mid(FRM_ING_BONOS.Grd_Compra_Bonos.TextMatrix(1, 0), 1, 12)

    If FUNC_EXECUTA_COMANDO_SQL("SP_CON_SERIES", GLB_Envia) Then
    
        If FUNC_LEE_RETORNO_SQL(vDatos_Retorno()) Then
            Moneda_Emision = vDatos_Retorno(6)
        End If
    End If

   If KeyAscii = 13 Then
      
    If Grd_Compra_Bonos.Col = 1 Then
        If CDbl(TXT_Grilla.Text) > CDbl(Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, 10)) And CDbl(Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, 6)) = 15 Then
            MsgBox "Nominal a colocar es mayor que el nominal emitido vigente", vbExclamation
            Grd_Compra_Bonos.SetFocus
            Exit Sub
        Else
            FTB_VALOR_ESTIMADO1.Text = (CDbl(Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, 11)) / CDbl(Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, 10))) * CDbl(TXT_Grilla.Text)
            Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, 15) = (CDbl(Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, 11)) / CDbl(Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, 10))) * CDbl(TXT_Grilla.Text)
            FTB_VALOR_ESTIMADO2.Text = (CDbl(Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, 12)) / CDbl(Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, 10))) * CDbl(TXT_Grilla.Text)
            Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, 16) = (CDbl(Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, 12)) / CDbl(Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, 10))) * CDbl(TXT_Grilla.Text)
            FTB_VALOR_ESTIMADO3.Text = (CDbl(Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, 13)) / CDbl(Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, 10))) * CDbl(TXT_Grilla.Text)
            Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, 17) = (CDbl(Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, 13)) / CDbl(Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, 10))) * CDbl(TXT_Grilla.Text)
            FTB_VALOR_ESTIMADO4.Text = (CDbl(Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, 14)) / CDbl(Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, 10))) * CDbl(TXT_Grilla.Text)
            Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, 18) = (CDbl(Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, 14)) / CDbl(Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, 10))) * CDbl(TXT_Grilla.Text)
        End If
    End If
      
      If Grd_Compra_Bonos.Col <> 3 And Grd_Compra_Bonos.Col <> 5 Then
      
            Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, Grd_Compra_Bonos.Col) = Format(TXT_Grilla.Text, GLB_Formato_Decimal)
        
      Else
        If Moneda_Emision = 998 Or Moneda_Emision = 994 Or Moneda_Emision = 998 Then
            Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, Grd_Compra_Bonos.Col) = Format(TXT_Grilla.Text, GLB_Formato_Entero)
        Else
            Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, Grd_Compra_Bonos.Col) = Format(TXT_Grilla.Text, GLB_Formato_Decimal)
        End If
      End If
      
      If Grd_Compra_Bonos.Col = 2 Or Grd_Compra_Bonos.Col = 1 Then
         
         If (Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, 1) = "" _
         Or Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, 1) = "0,0000") _
         Or (Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, 2) = "" _
         Or Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, 2) = "0,0000") Then
            Tlb_Menu.Buttons(2).Enabled = False
            DoEvents
            If Grd_Compra_Bonos.Enabled = True Then
                Grd_Compra_Bonos.SetFocus
            End If
            Exit Sub
         Else
           Tlb_Menu.Buttons(2).Enabled = True
           If Not FUNC_CALCULOS(2, Grd_Compra_Bonos.Row) Then
              
              If Grd_Compra_Bonos.Col <> 3 And Grd_Compra_Bonos.Col <> 5 Then
        
                 Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, Grd_Compra_Bonos.Col) = Format(0, GLB_Formato_Decimal)
        
              Else
        
                 Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, Grd_Compra_Bonos.Col) = Format(0, GLB_Formato_Entero)
        
              End If
           
                DoEvents
                If Grd_Compra_Bonos.Enabled = True Then
                    Grd_Compra_Bonos.SetFocus
                End If
            Exit Sub
           End If
         End If
      
      ElseIf Grd_Compra_Bonos.Col = 4 Then
      
         If Not FUNC_CALCULOS(1, Grd_Compra_Bonos.Row) Then
            
            If Grd_Compra_Bonos.Col <> 3 And Grd_Compra_Bonos.Col <> 5 Then
      
               Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, Grd_Compra_Bonos.Col) = Format(0, GLB_Formato_Decimal)
      
            Else
      
               Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, Grd_Compra_Bonos.Col) = Format(0, GLB_Formato_Entero)
      
            End If
         
                DoEvents
                If Grd_Compra_Bonos.Enabled = True Then
                    Grd_Compra_Bonos.SetFocus
                End If
           
            Exit Sub
         
         End If
      
      ElseIf Grd_Compra_Bonos.Col = 5 Then
      
         If Not FUNC_CALCULOS(3, Grd_Compra_Bonos.Row) Then
            
            If Grd_Compra_Bonos.Col <> 3 And Grd_Compra_Bonos.Col <> 5 Then
      
               Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, Grd_Compra_Bonos.Col) = Format(0, GLB_Formato_Decimal)
      
            Else
      
               Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, Grd_Compra_Bonos.Col) = Format(0, GLB_Formato_Entero)
      
            End If
            
                DoEvents
                If Grd_Compra_Bonos.Enabled = True Then
                    Grd_Compra_Bonos.SetFocus
                End If
            Exit Sub
         
         End If
      
      End If
      
      TXT_Grilla.Visible = False
      DoEvents
      
      If Grd_Compra_Bonos.Enabled = True Then
         Grd_Compra_Bonos.SetFocus
      End If
      
   End If
   
   If KeyAscii = 27 Then
      TXT_Grilla.Visible = False
      DoEvents
      Grd_Compra_Bonos.SetFocus
   End If

End Sub
Private Sub Txt_Grilla_LostFocus()
   
   TXT_Grilla.Visible = False
   
   If Grd_Compra_Bonos.Col < 5 Then
   
      Grd_Compra_Bonos.Col = Grd_Compra_Bonos.Col + 1
   
   ElseIf Grd_Compra_Bonos.Col = 5 Then
        
        Grd_Compra_Bonos.Col = 9
   
   Else
   
      Grd_Compra_Bonos.Col = Grd_Compra_Bonos.Col
   
   End If

End Sub

Private Sub Txt_Texto_GotFocus()

      TXT_Texto.SelStart = 1

End Sub

Private Sub Txt_Texto_KeyPress(KeyAscii As Integer)
Dim nInstrumento As Integer
Dim nContador As Integer
Dim vDatos_Retorno()

   PROC_TO_CASE KeyAscii
   cEstado_ok = "N"
   If KeyAscii = 13 Then
      
      If Grd_Compra_Bonos.Col = 0 Then
      
        If Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, 0) = TXT_Texto.Text Then
            TXT_Texto.Visible = False
            cEstado_ok = "S"
            DoEvents
            If Grd_Compra_Bonos.Enabled = True Then
                Grd_Compra_Bonos.SetFocus
            End If
            Exit Sub
                  
        End If
      
         GLB_Envia = Array()
         PROC_AGREGA_PARAMETRO GLB_Envia, 0
         PROC_AGREGA_PARAMETRO GLB_Envia, TXT_Texto.Text

       If Not FUNC_EXECUTA_COMANDO_SQL("SP_CON_SERIES", GLB_Envia) Then
            
            Screen.MousePointer = 0
            MsgBox ("Problemas al realizar búsqueda"), vbCritical
            Exit Sub
       
       Else
           ' DoEvents
           If FUNC_LEE_RETORNO_SQL(vDatos_Retorno()) Then
               DoEvents
               nInstrumento = vDatos_Retorno(1)
               cProducto = vDatos_Retorno(23)
               nMoneda = vDatos_Retorno(6)
               If nMoneda = 999 Or nMoneda = 998 Or nMoneda = 994 Then
                    FTB_VALOR_ESTIMADO1.CantidadDecimales = 0
                    FTB_VALOR_ESTIMADO2.CantidadDecimales = 0
                    FTB_VALOR_ESTIMADO3.CantidadDecimales = 0
                    FTB_VALOR_ESTIMADO4.CantidadDecimales = 0
               Else
                    FTB_VALOR_ESTIMADO1.CantidadDecimales = 2
                    FTB_VALOR_ESTIMADO2.CantidadDecimales = 2
                    FTB_VALOR_ESTIMADO3.CantidadDecimales = 2
                    FTB_VALOR_ESTIMADO4.CantidadDecimales = 2
               End If
               
               If Trim(TXT_Texto.Text) <> "" Then
                  Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, 3) = vDatos_Retorno(5)
                  Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, 10) = CDbl(vDatos_Retorno(32))
                  Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, 11) = CDbl(vDatos_Retorno(34))
                  Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, 12) = CDbl(vDatos_Retorno(35))
                  Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, 13) = CDbl(vDatos_Retorno(36))
                  Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, 14) = CDbl(vDatos_Retorno(37))
               End If
                  Tlb_Menu.Buttons(3).Enabled = True
           Else
               
               MsgBox ("Serie no encontrada"), vbExclamation
               Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, Grd_Compra_Bonos.Col) = ""
               Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, 3) = 0
               TXT_Texto.Visible = False
               Grd_Compra_Bonos.SetFocus
               Exit Sub
               
           End If
           
       End If
      
      End If
      
      Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, Grd_Compra_Bonos.Col) = TXT_Texto.Text
      Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, 6) = nInstrumento
      Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, 7) = cProducto
      Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, 8) = nMoneda
      TXT_Texto.Visible = False
      DoEvents
      
      If Grd_Compra_Bonos.Enabled = True Then
         Grd_Compra_Bonos.SetFocus
      End If
      
     
   End If
   
   If KeyAscii = 27 Then
      TXT_Texto.Visible = False
      DoEvents
      Grd_Compra_Bonos.SetFocus
   End If

End Sub
Private Sub Txt_Texto_LostFocus()
    If cEstado_ok = "S" Then
        TXT_Texto.Visible = False
        Exit Sub
    End If

   TXT_Texto.Visible = False
   Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, 1) = Format(0, GLB_Formato_Decimal)
   Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, 2) = Format(0, GLB_Formato_Decimal)
   If Trim(Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, 0)) = "" Then
      Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, 3) = Format(0, GLB_Formato_Entero)
   End If
   Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, 4) = Format(0, GLB_Formato_Decimal)
   Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, 5) = Format(0, GLB_Formato_Entero)
   If Trim(Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, 0)) = "" Then
      Grd_Compra_Bonos.Col = 0
   Else
      Grd_Compra_Bonos.Col = 1
   End If
   
End Sub
Private Sub TXTFecha1_KeyPress(KeyAscii As Integer)
Dim nContador As Integer
Dim vDatos_Retorno()

   PROC_TO_CASE KeyAscii

   If KeyAscii = 13 Then
      
            Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, Grd_Compra_Bonos.Col) = TXTFecha1.Text
      
      
      If Grd_Compra_Bonos.Col = 9 Then
         
         If (Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, 1) = "" _
         Or Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, 1) = "0,0000") _
         Or (Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, 2) = "" _
         Or Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, 2) = "0,0000") Then
            Tlb_Menu.Buttons(2).Enabled = False
            TXTFecha1.Visible = False
            Exit Sub
         Else
           Tlb_Menu.Buttons(2).Enabled = True
           If Not FUNC_CALCULOS(2, Grd_Compra_Bonos.Row) Then
              
              Grd_Compra_Bonos.TextMatrix(Grd_Compra_Bonos.Row, Grd_Compra_Bonos.Col) = TXTFecha1.Text
           
              TXTFecha1.Visible = False
              
              Exit Sub
           End If
         End If
      
      End If
      
      TXTFecha1.Visible = False
      DoEvents
      
      If Grd_Compra_Bonos.Enabled = True Then
         Grd_Compra_Bonos.SetFocus
      End If
      
   End If
   
   If KeyAscii = 27 Then
      TXTFecha1.Visible = False
      DoEvents
      Grd_Compra_Bonos.SetFocus
   End If

End Sub

Private Sub TXTFecha1_LostFocus()
    TXTFecha1.Visible = False
End Sub

Private Sub PROC_GRABAR_ESTIMADO()

    If MsgBox("¿ Está seguro de grabar valores estimados ?", vbQuestion + vbYesNo) = vbYes Then
    
        FUNC_EXECUTA_COMANDO_SQL ("BEGIN TRANSACTION")
        
        For nContador = 1 To Grd_Compra_Bonos.Rows - 1
            
            GLB_Envia = Array()
            PROC_AGREGA_PARAMETRO GLB_Envia, CDbl(Grd_Compra_Bonos.TextMatrix(nContador, 15))
            PROC_AGREGA_PARAMETRO GLB_Envia, CDbl(Grd_Compra_Bonos.TextMatrix(nContador, 16))
            PROC_AGREGA_PARAMETRO GLB_Envia, CDbl(Grd_Compra_Bonos.TextMatrix(nContador, 17))
            PROC_AGREGA_PARAMETRO GLB_Envia, CDbl(Grd_Compra_Bonos.TextMatrix(nContador, 18))
            PROC_AGREGA_PARAMETRO GLB_Envia, CLng(Grd_Compra_Bonos.TextMatrix(nContador, 20))
            PROC_AGREGA_PARAMETRO GLB_Envia, CLng(Grd_Compra_Bonos.TextMatrix(nContador, 19))


            If Not FUNC_EXECUTA_COMANDO_SQL("SP_ACT_PAGOS_SERIE", GLB_Envia) Then
                 Screen.MousePointer = 0
                 MsgBox ("Problemas al realizar grabacion de Valores estimados"), vbCritical
                 FUNC_EXECUTA_COMANDO_SQL ("ROLLBACK TRANSACTION")
                 Exit Sub
            End If
        Next
    
       MsgBox ("Grabacion correcta de Valores estimados"), vbInformation
       FUNC_EXECUTA_COMANDO_SQL ("COMMIT TRANSACTION")
  
    End If
      
End Sub


