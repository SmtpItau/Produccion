VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BACCONTROLES.OCX"
Begin VB.Form Bac_Ventas_Filtro 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Ventas "
   ClientHeight    =   7965
   ClientLeft      =   -615
   ClientTop       =   3465
   ClientWidth     =   12240
   Icon            =   "frm_vtas.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   7965
   ScaleWidth      =   12240
   Begin VB.Frame Frame2 
      Height          =   1755
      Left            =   0
      TabIndex        =   3
      Top             =   6180
      Width           =   12165
      Begin MSFlexGridLib.MSFlexGrid grdTotal 
         Height          =   1095
         Left            =   540
         TabIndex        =   17
         Top             =   600
         Width           =   11475
         _ExtentX        =   20241
         _ExtentY        =   1931
         _Version        =   393216
         Rows            =   4
         Cols            =   5
         BackColor       =   -2147483633
         BackColorBkg    =   12632256
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
         ForeColor       =   &H8000000D&
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
         ForeColor       =   &H8000000D&
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
   Begin VB.Frame Frame3 
      Height          =   5535
      Left            =   30
      TabIndex        =   1
      Top             =   660
      Width           =   12180
      Begin BACControles.TXTNumero TEXT1 
         Height          =   255
         Left            =   2790
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
         Max             =   "99999999999.9999"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
      End
      Begin MSFlexGridLib.MSFlexGrid grilla 
         Height          =   5280
         Left            =   60
         TabIndex        =   2
         Top             =   180
         Width           =   12075
         _ExtentX        =   21299
         _ExtentY        =   9313
         _Version        =   393216
         Rows            =   3
         Cols            =   8
         FixedCols       =   0
         BackColor       =   -2147483644
         ForeColor       =   -2147483635
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
      Width           =   12240
      _ExtentX        =   21590
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



Function buscar_unidad(Unidad)
    Dim datos()
    envia = Array()
    AddParam envia, Unidad
    If Bac_Sql_Execute("Svc_Vnt_bus_uni", envia) Then
        Do While Bac_SQL_Fetch(datos)
            lbl_unidad.Caption = "Unidad : " & datos(1)
        Loop
    End If
    
End Function

Sub dibuja_grilla()
Dim i As Integer

grilla.Rows = grilla.FixedRows
grilla.Cols = 28


grilla.TextMatrix(0, 1) = "Instrumento"
grilla.TextMatrix(0, 2) = "Vcto"
grilla.TextMatrix(0, 3) = "Nominal"
grilla.TextMatrix(0, 4) = "TIR"
grilla.TextMatrix(0, 5) = "% V.Compra"
grilla.TextMatrix(0, 6) = "Monto"
grilla.TextMatrix(0, 7) = "Interés"
grilla.TextMatrix(0, 8) = "Custodia"
grilla.TextMatrix(0, 27) = "Moneda"

grilla.ColWidth(0) = 300
grilla.ColWidth(1) = 2300
grilla.ColWidth(2) = 1100
grilla.ColWidth(3) = 1500
grilla.ColWidth(4) = 1000
grilla.ColWidth(5) = 1200
grilla.ColWidth(6) = 1800
grilla.ColWidth(7) = 1200
grilla.ColWidth(8) = 1000

For i = 9 To grilla.Cols - 1
    grilla.ColWidth(i) = 0
Next
grilla.ColWidth(27) = 800
End Sub

Sub dibuja_grilla_Total()
Dim i As Integer

grdTotal.Rows = 2
grdTotal.Cols = 5

grdTotal.TextMatrix(1, 0) = "Total "
grdTotal.TextMatrix(0, 1) = "Nominal"
grdTotal.TextMatrix(0, 2) = "Principal"
grdTotal.TextMatrix(0, 3) = "Interés"
grdTotal.TextMatrix(0, 4) = "Monto Total "

grdTotal.ColWidth(0) = 1800
grdTotal.ColWidth(1) = 2300
grdTotal.ColWidth(2) = 2300
grdTotal.ColWidth(3) = 2300
grdTotal.ColWidth(4) = 2300

grdTotal.ColAlignment(1) = 7
grdTotal.ColAlignment(2) = 7
grdTotal.ColAlignment(3) = 7
grdTotal.ColAlignment(4) = 7

grdTotal.TextMatrix(1, 1) = "0.00"
grdTotal.TextMatrix(1, 2) = "0.00"
grdTotal.TextMatrix(1, 3) = "0.00"
grdTotal.TextMatrix(1, 4) = "0.00"

End Sub
Function existen_datos()
    Dim datos()
    existen_datos = 0
    If Bac_Sql_Execute("Svc_Vnt_bus_car ") Then
        Do While Bac_SQL_Fetch(datos)
            existen_datos = Val(datos(1))
        Loop
    End If
End Function
Sub Func_Restaurar()

    Call Restaurar_datos(1, grilla.Rows - 1)
    txt_nominal.Text = 0
    Txt_Monto_Pag.Text = 0
    lbl_monto_prin.Caption = ""
    lbl_int_dev.Caption = ""
    For i = 0 To grilla.Cols - 1
        grilla.Col = i
        Call grilla_LeaveCell
    Next i


End Sub

Sub Func_Vende()

Dim i As Integer

    grilla.TextMatrix(grilla.Row, 0) = "V"
    Call Valorizar(2)
    Call Totales
    For i = 0 To grilla.Cols - 1
               grilla.Col = i
               Call grilla_LeaveCell
    Next i
    
End Sub

Sub Totales_OLD()
    Dim i%
    Dim TotNominal As Double
    Dim TotPrincipal As Double
    Dim TotIntereses As Double
    Dim TotAPagar As Double
    
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
    Txt_Monto_Pag.Text = TotAPagar
    
    grdTotal.TextMatrix(1, 0) = "Total USD"
    grdTotal.TextMatrix(1, 1) = Format(TotNominal, "###,###,###,###,##0.00")
    grdTotal.TextMatrix(1, 2) = Format(TotPrincipal, "###,###,###,###,##0.00")
    grdTotal.TextMatrix(1, 3) = Format(TotIntereses, "###,###,###,###,##0.00")
    grdTotal.TextMatrix(1, 4) = Format(TotAPagar, "###,###,###,###,##0.00")
    
End Sub
Sub Totales()
    Dim i%
    Dim TotNominal As Double
    Dim TotPrincipal As Double
    Dim TotIntereses As Double
    Dim TotAPagar As Double
    Dim j As Integer
    Dim hasta As Integer
    
    hasta = UBound(MonedasOPVenta, 2)
    
    For j = 1 To hasta
        TotIntereses = 0
        TotPrincipal = 0
        TotNominal = 0
        TotAPagar = 0
        For i = 1 To grilla.Rows - 1
            If MonedasOPVenta(1, j) = Val(grilla.TextMatrix(i, 16)) Then
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
            End If
        Next
        
        TotAPagar = TotPrincipal + CDbl(TotIntereses)
        
        grdTotal.Rows = grdTotal.Rows + 1
        grdTotal.TextMatrix(j, 0) = "Total " & MonedasOPVenta(2, j)
        grdTotal.TextMatrix(j, 1) = Format(TotNominal, "###,###,###,###,##0.00")
        grdTotal.TextMatrix(j, 2) = Format(TotPrincipal, "###,###,###,###,##0.00")
        grdTotal.TextMatrix(j, 3) = Format(TotIntereses, "###,###,###,###,##0.00")
        grdTotal.TextMatrix(j, 4) = Format(TotAPagar, "###,###,###,###,##0.00")
    Next
        
End Sub

Function Func_Aceptar()

    gsBac_VarDouble = CDbl(grilla.TextMatrix(FilaSeleccionada, 6))
    gsBac_VarDouble2 = CDbl(grilla.TextMatrix(FilaSeleccionada, 7))
    giAceptar% = True
    
    Unload Me


End Function

Function Func_Limpiar()

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
    Txt_Monto_Pag.Text = 0
    lbl_monto_prin.Caption = ""
    lbl_int_dev.Caption = ""
    Text1.Visible = False
    grdTotal.Row = 1
    
    Call llena_combo_familia
    
    FilaSeleccionada = 0
    
End Function

Function llena_grilla()
    
    Dim datos()
    Dim i
    
    If box_familia.ListIndex = -1 Then
        MsgBox "No ha Selecionado Familia de Instrumentos", vbExclamation, gsBac_Version
        box_familia.SetFocus
        Exit Function
    End If
    
    enviar = Array()
    AddParam enviar, box_familia.ItemData(box_familia.ListIndex)
    AddParam enviar, Bac_Usr_ofi
    
    i = 0
    
    If Bac_Sql_Execute("Svc_Vnt_fil_car", enviar) Then
    
        Do While Bac_SQL_Fetch(datos)
            If datos(1) = 0 Then
                MsgBox datos(2), vbExclamation, gsBac_Version
                Exit Function
            End If
            If datos(6) <> 0 Then
                grilla.Rows = grilla.Rows + 1
                
                    grilla.TextMatrix(grilla.Rows - 1, 0) = datos(1)
                    grilla.TextMatrix(grilla.Rows - 1, 1) = Format(datos(2), "DD/MM/YYYY")
                    grilla.TextMatrix(grilla.Rows - 1, 2) = Format(CDbl(datos(3)), "###,###,###,###,##0.00")
                    grilla.TextMatrix(grilla.Rows - 1, 3) = Format(CDbl(datos(4)), "###,###,###,###,##0.000")
                    grilla.TextMatrix(grilla.Rows - 1, 4) = Format(CDbl(datos(5)), "###,###,###,###,##0.000")
                    grilla.TextMatrix(grilla.Rows - 1, 5) = Format(CDbl(datos(6)), "###,###,###,###,##0.000")
                    grilla.TextMatrix(grilla.Rows - 1, 6) = CDbl(datos(7))
                    grilla.TextMatrix(grilla.Rows - 1, 7) = CDbl(datos(8))
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

    Dim datos()
    Dim num
    Dim i As Integer


    For i = 1 To grilla.Rows - 1

    
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
        AddParam envia, 1     'modalidad de calculo
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
        AddParam envia, INCTR
        AddParam envia, CAP
        AddParam envia, "S"
        AddParam envia, CDbl(grilla.TextMatrix(i, 16))
            
        If Bac_Sql_Execute("Svc_Prc_val_ins", envia) Then
            Do While Bac_SQL_Fetch(datos)
            
                grilla.TextMatrix(i, 4) = Format(CDbl(datos(1)), "##,##0.00000") 'Tir
                grilla.TextMatrix(i, 19) = CDbl(datos(2))  'Tasa Vigente
                grilla.TextMatrix(i, 19) = CDbl(datos(3))  'Tasa Vigente
                grilla.TextMatrix(i, 3) = Format(CDbl(datos(7)), "###,###,###,##0.00") 'nominal
                grilla.TextMatrix(i, 6) = Format(CDbl(datos(8)), "###,###,###,##0.0000") 'monto pagamos
                grilla.TextMatrix(i, 21) = Format(CDbl(datos(9)), "###,###,###,##0.0000") 'Valor Vencimiento
                grilla.TextMatrix(i, 5) = Format(CDbl(datos(11)), "###,##0.00000")
                'txt_fec_neg.Text = Format(datos(13), "DD/MM/YYYY")
                grilla.TextMatrix(i, 9) = Format(datos(14), "DD/MM/YYYY")
                grilla.TextMatrix(i, 17) = Format(datos(15), "DD/MM/YYYY")
                grilla.TextMatrix(i, 20) = Format(datos(18), "dd/mm/yyyy")
                grilla.TextMatrix(i, 7) = Format(CDbl(datos(21)), "###,###,###,###0.00") 'Interes Devengado
                grilla.TextMatrix(i, 23) = Format(CDbl(datos(22)), "###,###,###,###0.0000") 'Principal
                
                
                TR = CDbl(datos(1))
                TV = CDbl(datos(3))
                MT = CDbl(datos(8))
                VV = CDbl(datos(9))
                VP = CDbl(datos(10))
                PVP = CDbl(datos(11))
                VAN = CDbl(datos(12))
                FU = CDate(Format(datos(16), "dd/mm/yyyy"))
                FX = CDate(Format(datos(17), "dd/mm/yyyy"))
                CI = CDbl((datos(19)))
                CT = CDbl((datos(20)))
                INDEV = CDbl(datos(21))
                PRINC = CDbl(datos(22))
                
                If grilla.TextMatrix(i, 16) = 13 Or grilla.TextMatrix(i, 16) = 994 Then
                    grilla.TextMatrix(i, 26) = CDbl(datos(8)) * gsBac_ObsMesAnt
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


Private Sub Form_Load()

    Move 0, 0
    Tipo_op = "V"
    giAceptar% = False
    txt_fec_neg.Text = Format(gsBac_Fecp, "dd/mm/yyyy")
    Call Func_Limpiar
    Call buscar_unidad(Bac_Usr_ofi)
    Call dibuja_grilla_Total
    Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "Ingreso a Pantalla de Ventas")

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
        
               .Row = R
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
      .Row = f
      .Col = 0
      .FocusRect = flexFocusLight
      .Redraw = True
   End With
   
   
    If lrow > 1 Then
        grilla.TopRow = lrow
    End If
   
End Sub



Function llena_combo_familia()
    Dim datos()
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

Private Sub grilla_DblClick()

   If grilla.Col = 7 And (grilla.TextMatrix(grilla.Row, 0) = "V" Or grilla.TextMatrix(grilla.Row, 0) = "P") Then
'      Combo1.Visible = True
'      Combo1.SetFocus
   End If


End Sub


Private Sub grilla_KeyDown(KeyCode As Integer, Shift As Integer)
columnita = grilla.Col
     
End Sub

Private Sub grilla_KeyPress(KeyAscii As Integer)


Dim i          As Integer
Dim Sql        As String
Dim datos()
Dim reg        As Double
Dim bloq       As String
Dim fila_table As Double
Dim Fila As Integer
Dim nRowTop As Integer

 nRowTop = grilla.TopRow
 columna = grilla.Col
 
 If grilla.Row > 0 Then

        Select Case KeyAscii
            Case 118, 86 '(  V ó v)
                grilla.TextMatrix(grilla.Row, 0) = "V"
                Call Valorizar(2)
                Call Totales
'                 For I = 0 To grilla.Cols - 1
'                       grilla.Col = I
'                       Call grilla_LeaveCell
'                    Next I
            Case 114
                grilla.TextMatrix(grilla.Row, columnita) = "  "
                Call Restaurar_datos(grilla.Row, grilla.Row)
'                For I = 0 To grilla.Cols - 1
'                    grilla.Col = I
'                    Call grilla_LeaveCell
'                 Next I
                 Call Totales
                 
        End Select

 End If

 If grilla.Col = 3 Then
         Text1.CantidadDecimales = 2
         Text1.Max = CDbl(grilla.TextMatrix(grilla.Row, 24))
 ElseIf grilla.Col = 5 Then
        Text1.CantidadDecimales = 6
        Text1.Min = -999.999999
Else
        Text1.CantidadDecimales = 4
 End If

   
 If (grilla.Col = 3 Or grilla.Col = 4 Or grilla.Col = 5 Or grilla.Col = 6) And IsNumeric(Chr(KeyAscii)) Then
    
      Text1.Text = grilla.TextMatrix(grilla.Row, grilla.Col)
      grilla.Col = columna
      Text1.Top = grilla.CellTop + grilla.Top + 20
      Text1.Left = grilla.CellLeft + grilla.Left + 20
      Text1.Width = grilla.CellWidth
            
      Text1.Text = Chr(KeyAscii)
      Text1.SelStart = 1
      Text1.Visible = True
      Text1.SetFocus
       
 End If
  
End Sub

Private Sub grilla_LeaveCell()

   If grilla.Row <> 0 And grilla.Col > 1 Then
        grilla.CellFontBold = True
        If grilla.TextMatrix(grilla.Row, 0) = "V" Then
            grilla.CellBackColor = vbBlue
            grilla.CellForeColor = vbWhite
        ElseIf grilla.TextMatrix(grilla.Row, 0) = "P" Then
            grilla.CellBackColor = vbCyan
            grilla.CellForeColor = vbBlack
        ElseIf grilla.TextMatrix(grilla.Row, 0) = "*" Then
            grilla.CellBackColor = vbGreen + vbWhite    'vbBlack
            grilla.CellForeColor = vbWhite
        ElseIf grilla.TextMatrix(grilla.Row, 0) = "B" Then
            grilla.CellBackColor = vbBlack + vbWhite    'vbBlack
            grilla.CellForeColor = vbBlack
        Else
            grilla.CellBackColor = vbBlack
            grilla.CellForeColor = vbBlack

        End If
        'grilla.CellFontBold = False

    End If


End Sub


Private Sub grilla_RowColChange()

    grilla.CellBackColor = &H808000
    grilla.CellForeColor = vbWhite
    
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
Dim datos()
Dim num

    If ModCal = 1 And CDbl(grilla.TextMatrix(grilla.Row, 3)) = 0 Then
        Exit Function
    End If

    If ModCal = 1 And CDbl(grilla.TextMatrix(grilla.Row, 5)) = 0 Then 'PRECIO
        Exit Function
    End If

    If ModCal = 2 And CDbl(grilla.TextMatrix(grilla.Row, 4)) = 0 Then 'TIR
        Exit Function
    End If
    
    If ModCal = 3 And CDbl(grilla.TextMatrix(grilla.Row, 12)) = 0 Then 'Monto Pagamos
        Exit Function
    End If
    
    If CDbl(grilla.TextMatrix(grilla.Row, 19)) = 0 Then 'tasa Vigente
        Exit Function
    End If
    
    Screen.MousePointer = 11

    TR = CDbl(grilla.TextMatrix(grilla.Row, 4))     'Tir
    TE = CDbl(grilla.TextMatrix(grilla.Row, 19))    'tasa Vigente
    TV = CDbl(grilla.TextMatrix(grilla.Row, 19)) ' tasa Vigente
    TT = 0
    BF = 0
    NOM = CDbl(grilla.TextMatrix(grilla.Row, 3))
    MT = CDbl(grilla.TextMatrix(grilla.Row, 6)) 'Monto Pagamos
    VV = 0
    PVP = CDbl(grilla.TextMatrix(grilla.Row, 5))   ' Precio
    VAN = 0
    FP = CDate(txt_fec_pag.Text)    'CDate(grilla.TextMatrix(grilla.Row, 20))
    FE = CDate(grilla.TextMatrix(grilla.Row, 9)) ' Fecha Emision
    FV = CDate(grilla.TextMatrix(grilla.Row, 2))  'Fecha Vencimiento
    FU = CDate(grilla.TextMatrix(grilla.Row, 2))  ' Fecha Vencimiento
    FX = CDate(grilla.TextMatrix(grilla.Row, 2))  ' Fecha Vencimiento
    FC = CDate(txt_fec_pag.Text)    ' CDate(grilla.TextMatrix(grilla.Row, 20)) 'Fecha Pago
    CI = 0
    CT = 0
    INDEV = 0
    PRINC = 0
    FIP = CDate(txt_fec_pag.Text)    'CDate(grilla.TextMatrix(grilla.Row, 20))  'Fecha Pago
    INCTR = 0
    CAP = 0
    BA = CDbl(grilla.TextMatrix(grilla.Row, 22))    'Base
    SPREAD = 0
    envia = Array()
    AddParam envia, CDate(txt_fec_pag.Text)    'CDate(grilla.TextMatrix(grilla.Row, 20)) 'Fecha Pago
    AddParam envia, " "
    AddParam envia, ModCal
    AddParam envia, CDbl((grilla.TextMatrix(grilla.Row, 12))) 'Codigo Familia
    
    If (grilla.TextMatrix(grilla.Row, 12)) = 2000 Then
        AddParam envia, grilla.TextMatrix(grilla.Row, 1)    'Nombre Serie
    Else
        AddParam envia, grilla.TextMatrix(grilla.Row, 18)    'Nombre Familia
    End If
    
    AddParam envia, CDate(grilla.TextMatrix(grilla.Row, 2))
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
    AddParam envia, CDbl(grilla.TextMatrix(grilla.Row, 16))
        
    If Bac_Sql_Execute("Svc_Prc_val_ins", envia) Then
        Do While Bac_SQL_Fetch(datos)
        
            grilla.TextMatrix(grilla.Row, 4) = Format(CDbl(datos(1)), "##,##0.00000") 'Tir
            grilla.TextMatrix(grilla.Row, 19) = CDbl(datos(2))  'Tasa Vigente
            grilla.TextMatrix(grilla.Row, 19) = CDbl(datos(3))  'Tasa Vigente
            grilla.TextMatrix(grilla.Row, 3) = Format(CDbl(datos(7)), "###,###,###,##0.00") 'nominal
            If IsNull(datos(8)) Then
                grilla.TextMatrix(grilla.Row, 6) = Format(0, "###,###,###,##0.00") 'monto pagamos
            Else
                grilla.TextMatrix(grilla.Row, 6) = Format(CDbl(datos(8)), "###,###,###,##0.00") 'monto pagamos
            End If
            grilla.TextMatrix(grilla.Row, 21) = Format(CDbl(datos(9)), "###,###,###,##0.0000") 'Valor Vencimiento
            If IsNull(datos(11)) Then
                grilla.TextMatrix(grilla.Row, 5) = Format(0, "###,##0.000000")
            Else
                grilla.TextMatrix(grilla.Row, 5) = Format(CDbl(datos(11)), "###,##0.000000")
            End If
            'txt_fec_neg.Text = Format(datos(13), "DD/MM/YYYY")
            grilla.TextMatrix(grilla.Row, 9) = Format(datos(14), "DD/MM/YYYY")
            grilla.TextMatrix(grilla.Row, 17) = Format(datos(15), "DD/MM/YYYY")
            grilla.TextMatrix(grilla.Row, 20) = Format(datos(18), "dd/mm/yyyy")
            grilla.TextMatrix(grilla.Row, 7) = Format(CDbl(datos(21)), "###,###,###,###0.00") 'Interes Devengado
            If IsNull(datos(22)) Then
                grilla.TextMatrix(grilla.Row, 23) = Format(0, "###,###,###,###0.0000") 'Principal
            Else
                grilla.TextMatrix(grilla.Row, 23) = Format(CDbl(datos(22)), "###,###,###,###0.0000") 'Principal
            End If
            
                        
            
            TR = CDbl(datos(1))
            TV = CDbl(datos(3))
            MT = CDbl(datos(8))
            VV = CDbl(datos(9))
            VP = CDbl(datos(10))
            PVP = CDbl(datos(11))
            VAN = CDbl(datos(12))
            FU = CDate(Format(datos(16), "dd/mm/yyyy"))
            FX = CDate(Format(datos(17), "dd/mm/yyyy"))
            CI = CDbl((datos(19)))
            CT = CDbl((datos(20)))
            INDEV = CDbl(datos(21))
            PRINC = CDbl(datos(22))
            
            'If Grilla.TextMatrix(Grilla.Row, 16) = 13 Or Grilla.TextMatrix(Grilla.Row, 16) = 994 Then
                grilla.TextMatrix(grilla.Row, 26) = Monto_a_Peso("VP", grilla.TextMatrix(grilla.Row, 16), CDbl(datos(8)))   ' CDbl(Datos(8)) * gsBac_ObsMesAnt
            'Else
                
            'End If
            
        Loop
   End If
            
    Screen.MousePointer = 0
            
End Function

Function ValorizarOLD_COPIA(ModCal)
Dim datos()

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
    
    
    If ModCal = 3 And CDbl(Txt_Monto_Pag.Text) = 0 Then
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
    MT = CDbl(Txt_Monto_Pag.Text)
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
    
    If Bac_Sql_Execute("Svc_Prc_val_ins", envia) Then
        Do While Bac_SQL_Fetch(datos)
        
            txt_tir.Text = CDbl(datos(1))
            txt_tasa_vig.Text = CDbl(datos(2))
            txt_tasa_vig.Text = CDbl(datos(3))
            txt_nominal.Text = CDbl(datos(7))
            Txt_Monto_Pag.Text = Format(CDbl(datos(8)), "###,###,###,##0.00") 'CDbl(datos(8))
            lbl_val_venc.Caption = Format(CDbl(datos(9)), "###,###,###,##0.00")
            txt_pre_por.Text = CDbl(datos(11))
            txt_fec_neg.Text = Format(datos(13), "DD/MM/YYYY")
            txt_fec_emi.Text = Format(datos(14), "DD/MM/YYYY")
            txt_fec_vcto.Text = Format(datos(15), "DD/MM/YYYY")
            txt_fec_pag.Text = Format(datos(18), "dd/mm/yyyy")
            lbl_int_dev.Caption = Format(CDbl(datos(21)), "###,###,###,###0.00")
            lbl_monto_prin.Caption = Format(CDbl(datos(22)), "###,###,###,###0.00")
            
            TR = CDbl(datos(1))
            TV = CDbl(datos(3))
            MT = CDbl(datos(8))
            VV = CDbl(datos(9))
            VP = CDbl(datos(10))
            PVP = CDbl(datos(11))
            VAN = CDbl(datos(12))
            FU = CDate(Format(datos(16), "dd/mm/yyyy"))
            FX = CDate(Format(datos(17), "dd/mm/yyyy"))
            CI = CDbl((datos(19)))
            CT = CDbl((datos(20)))
            INDEV = CDbl(datos(21))
            PRINC = CDbl(datos(22))
            
        Loop
   End If
            
    Screen.MousePointer = 0
            
End Function

Private Sub TEXT1_KeyDown(KeyCode As Integer, Shift As Integer)

If KeyCode = 13 Then
    If grilla.Col = 3 Then
        If Text1.Text = 0 Then
            MsgBox "Monto Nominal no puede ser 0", vbInformation, "Mensaje"
            grilla.TextMatrix(grilla.Row, 3) = Format(grilla.TextMatrix(grilla.Row, 24), "###,###,###,###0,00")
            Text1.Visible = False
           Text1.Text = 0
           Exit Sub
        End If
    End If
   grilla.Text = Text1.Text
   Text1.Visible = False
   Text1.Text = 0

    If CDbl(grilla.TextMatrix(grilla.Row, 3)) = CDbl(grilla.TextMatrix(grilla.Row, 24)) Then
         grilla.TextMatrix(grilla.Row, 0) = "V"
    ElseIf CDbl(grilla.TextMatrix(grilla.Row, 3)) < CDbl(grilla.TextMatrix(grilla.Row, 24)) Then
         grilla.TextMatrix(grilla.Row, 0) = "P"
    End If
    
    If grilla.Col = 3 And grilla.TextMatrix(grilla.Row, 3) <> 0 Then
        Call Valorizar(2)
    End If

    If grilla.Col = 4 And grilla.TextMatrix(grilla.Row, 4) <> 0 Then
        Call Valorizar(2)
    End If

    If grilla.Col = 5 And grilla.TextMatrix(grilla.Row, 5) <> 0 Then
        Call Valorizar(1)
    End If

    If grilla.Col = 6 And grilla.TextMatrix(grilla.Row, 6) <> 0 Then
        Call Valorizar(3)
    End If
    
    Call Marcar
    Call Totales
    
'   grilla.SetFocus

ElseIf KeyCode = 27 Then
        Text1.Visible = False

End If

End Sub

Private Sub Text1_LostFocus()

On Error Resume Next
'text1.Text = 0
Text1.Visible = False
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

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

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
                   
            If Valida_Vendidos Then
                    Call Grabar_Venta

            End If
            
    Case Btn_Vende
        Call Func_Vende
            
    Case Btn_Restaurar
        Call Func_Restaurar
        
    Case Btn_Filtar
        BacIrfSl.Show vbModal
        Call buscar_datos
        
    Case Btn_Buscar
      

    Case Btn_Emision
    
    Nom_inst = grilla.TextMatrix(grilla.Row, 1)
    Fechadet = grilla.TextMatrix(grilla.Row, 2)
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
Dim datos()
Dim j As Integer
Dim M As Integer
    
    
    hasta = UBound(OperacionesVenta)  ' Devuelve 10.
    
    If hasta > 0 Then
      Call Func_Limpiar
    End If
    
 For M = 1 To hasta
    If IsNumeric(OperacionesVenta(M)) Then
                 Numdocu = OperacionesVenta(M)
                 
                envia = Array()
                AddParam envia, gsBac_RutC
                AddParam envia, Numdocu
                
                If Bac_Sql_Execute("Svc_Vnt_dat_ins", envia) Then
                
                    Do While Bac_SQL_Fetch(datos)
                        grilla.Rows = grilla.Rows + 1
                        grilla.TextMatrix(M, 1) = datos(5)      'Serie
                        grilla.TextMatrix(M, 2) = Format(datos(17), "DD/MM/YYYY")  'Fecha Vencimiento
                        grilla.TextMatrix(M, 3) = Format(CDbl(datos(8)), "###,###,###,###,##0.00") 'Nominal
                        grilla.TextMatrix(M, 4) = Format(CDbl(datos(11)), "#,##0.00000") ' Tir
                        grilla.TextMatrix(M, 5) = Format(CDbl(datos(10)), "#,##0.000000") ' Valor compra - Precio
                        grilla.TextMatrix(M, 6) = Format(CDbl(datos(12)), "###,###,###,###,##0.00") ' Monto Pagamos
                        grilla.TextMatrix(M, 7) = 0 'Interes
                        If datos(36) = "0" Then
                            grilla.TextMatrix(M, 8) = ""
                        Else
                            grilla.TextMatrix(M, 8) = datos(36)
                        End If
                        
                        grilla.TextMatrix(M, 9) = Format(datos(16), "DD/MM/YYYY")  ' Fecha Emision
                        grilla.TextMatrix(M, 10) = CDbl(datos(18)) 'Rut Emisor
                        grilla.TextMatrix(M, 11) = CDbl(datos(32))  'Cod Emisor
                        grilla.TextMatrix(M, 12) = CDbl(datos(28)) 'Codigo Familia
                        grilla.TextMatrix(M, 13) = datos(34)    'cusip
                        grilla.TextMatrix(M, 14) = datos(29)               'Moneda de Pago
                        grilla.TextMatrix(M, 15) = datos(6)               'Base
                        grilla.TextMatrix(M, 16) = Val(datos(19))       'Moneda Emision
                        grilla.TextMatrix(M, 17) = Val(datos(20))       'Basilea
                        grilla.TextMatrix(M, 18) = datos(35)       'Nombre Familia
                        grilla.TextMatrix(M, 19) = CDbl(datos(7))   ' Tasa Vigente
                        grilla.TextMatrix(M, 20) = Format(gsBac_Fecp, "DD/MM/YYYY")  ' Fecha Pago
                        grilla.TextMatrix(M, 21) = CDbl(datos(9))   ' Valor Vencimiento
                        grilla.TextMatrix(M, 22) = CDbl(datos(6))   ' Base
                        grilla.TextMatrix(M, 23) = 0                            'Principal
                        grilla.TextMatrix(M, 24) = CDbl(datos(8)) 'Nominal
                        grilla.TextMatrix(M, 25) = Numdocu              'Numero de Documento
                        grilla.TextMatrix(M, 27) = datos(37)              'moneda
                        txt_fec_pag.MinDate = Format(gsBac_Fecp, "DD/MM/YYYY")
                        txt_fec_pag.Text = Format(gsBac_Fecp, "DD/MM/YYYY")
            
                    
            Loop
        End If
    End If
Next M

If grilla.Rows > 1 Then
    Toolbar1.Buttons(1).Enabled = True
    Toolbar1.Buttons(2).Enabled = True
    Toolbar1.Buttons(3).Enabled = True
    Toolbar1.Buttons(5).Enabled = False
    Toolbar1.Buttons(6).Enabled = True
    Toolbar1.Buttons(7).Enabled = True
End If


End Function

Function Restaurar_datos(desde, hasta)

'Dim Hasta As Integer
Dim Numdocu As Double
Dim datos()
Dim j As Integer
Dim M As Integer
    
    
 For M = desde To hasta
    If IsNumeric(grilla.TextMatrix(M, 25)) Then
                 Numdocu = (grilla.TextMatrix(M, 25))
                 
                envia = Array()
                AddParam envia, gsBac_RutC
                AddParam envia, Numdocu
                
                If Bac_Sql_Execute("Svc_Vnt_dat_ins", envia) Then
                
                    Do While Bac_SQL_Fetch(datos)
'                        grilla.Rows = grilla.Rows + 1
                        grilla.TextMatrix(M, 0) = " "
                        grilla.TextMatrix(M, 1) = datos(5)      'Serie
                        grilla.TextMatrix(M, 2) = Format(datos(17), "DD/MM/YYYY")  'Fecha Vencimiento
                        grilla.TextMatrix(M, 3) = Format(CDbl(datos(8)), "###,###,###,###,##0.0000") 'Nominal
                        grilla.TextMatrix(M, 4) = Format(CDbl(datos(11)), "#,##0.00000") ' Tir
                        grilla.TextMatrix(M, 5) = Format(CDbl(datos(10)), "#,##0.00000") ' Valor compra - Precio
                        grilla.TextMatrix(M, 6) = Format(CDbl(datos(12)), "###,###,###,###,##0.00") ' Monto Pagamos
                        grilla.TextMatrix(M, 7) = 0 'Interes
                        grilla.TextMatrix(M, 8) = "Custodia"
                        
                        grilla.TextMatrix(M, 9) = Format(datos(16), "DD/MM/YYYY")  ' Fecha Emision
                        grilla.TextMatrix(M, 10) = CDbl(datos(18)) 'Rut Emisor
                        grilla.TextMatrix(M, 11) = CDbl(datos(32))  'Cod Emisor
                        grilla.TextMatrix(M, 12) = CDbl(datos(28)) 'Codigo Familia
                        grilla.TextMatrix(M, 13) = datos(34)    'cusip
                        grilla.TextMatrix(M, 14) = datos(29)               'Moneda de Pago
                        grilla.TextMatrix(M, 15) = datos(6)               'Base
                        grilla.TextMatrix(M, 16) = Val(datos(19))       'Moneda Emision
                        grilla.TextMatrix(M, 17) = Val(datos(20))       'Basilea
                        grilla.TextMatrix(M, 18) = datos(35)       'Nombre Familia
                        grilla.TextMatrix(M, 19) = CDbl(datos(7))   ' Tasa Vigente
                        grilla.TextMatrix(M, 20) = Format(gsBac_Fecp, "DD/MM/YYYY")  ' Fecha Pago
                        grilla.TextMatrix(M, 21) = CDbl(datos(9))   ' Valor Vencimiento
                        grilla.TextMatrix(M, 22) = CDbl(datos(6))   ' Base
                        grilla.TextMatrix(M, 23) = 0                            'Principal
                        grilla.TextMatrix(M, 24) = CDbl(datos(8)) 'Nominal
                        grilla.TextMatrix(M, 25) = Numdocu              'Numero de Documento
                        txt_fec_pag.MinDate = Format(gsBac_Fecp, "DD/MM/YYYY")
                        txt_fec_pag.Text = Format(gsBac_Fecp, "DD/MM/YYYY")
            
            Loop
        End If
    End If
Next M

End Function


Function Grabar_Venta()

    Dim datos()
    Dim Numoper As Double
    Dim Correlativo As Integer
    Dim okGrabar  As Boolean
    
    gsmoneda = 13               'Str(box_moneda.ItemData(box_moneda.ListIndex))
    Tipo_op = "V"
    Bac_Intermediario.Show vbModal
  
   If giAceptar = True Then
   
        If Not Bac_Sql_Execute("BEGIN TRANSACTION") Then
             GoTo CP_GrabarTxError
         End If
             
        ' Indica inicio de Begin Transaction y se puede hacer el RollBack
          FlagTx = True
    
        ' Consulto el número de documento de tabla mdac (Mesa Dinero Archivo Control)
          If Not Bac_Sql_Execute("sp_opmdac") Then
              GoTo CP_GrabarTxError
          End If
        
        ' Recupero el Numero de Documento
         If Bac_SQL_Fetch(datos()) Then
             Numoper = Val(datos(1)) + 1
         End If
        Correlativo = 0
        okGrabar = False
        For i = 1 To grilla.Rows - 1
            If Trim(grilla.TextMatrix(i, 0)) <> "" Then     'Las que esten Vendidas o parcialmente Vendidas
                Correlativo = Correlativo + 1
                NOM = CDbl(grilla.TextMatrix(i, 3))
                MT = CDbl(grilla.TextMatrix(i, 6))
                TR = CDbl(grilla.TextMatrix(i, 4))
                PVP = CDbl(grilla.TextMatrix(i, 5))
                VP = 0
                INDEV = CDbl(grilla.TextMatrix(i, 7)) 'CDbl(grilla.TextMatrix(I, 21)) ACACACACACACACACACa
                PRINC = CDbl(grilla.TextMatrix(i, 23))
                Numdocu = CDbl(grilla.TextMatrix(i, 25))
                
                envia = Array()
                
                AddParam envia, gsBac_Fecp
                AddParam envia, gsBac_RutC
                AddParam envia, Numdocu
                AddParam envia, CDbl(grilla.TextMatrix(i, 12)) 'Codigo Familia
                
                If (grilla.TextMatrix(grilla.Row, 12)) = 2000 Then
                    AddParam envia, grilla.TextMatrix(i, 1)    'Nombre Serie
                Else
                    AddParam envia, grilla.TextMatrix(i, 18)    'Nombre Familia
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
                If Bac_Sql_Execute("Sva_Vnt_grb_ope", envia) Then
                    Do While Bac_SQL_Fetch(datos)
                        If datos(1) <> "OK" Then
                            If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
                                MsgBox "No se pudo realizar devolución de transacción inicializada", vbCritical, gsBac_Version
                            End If
                        End If
                    Loop
                    
                Else
                        Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "Problemas al grabar Operación de Venta #" & Numoper)
                        MsgBox "Problemas al grabar operación", vbCritical, "Bonos Exterior"
                        Exit Function
                End If
                
                okGrabar = True
            End If
            
        Next
        If okGrabar = True Then
            envia = Array()
            AddParam envia, Numoper
            If Bac_Sql_Execute("sp_ActNumeroOperacion", envia) Then
                 If Bac_SQL_Fetch(datos) Then
                    If datos(1) <> "OK" Then
                        MsgBox datos(2)
                        If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
                            MsgBox "No se pudo realizar devolución de transacción inicializada", vbCritical, gsBac_Version
                        End If
                        Exit Function
                    End If
                End If
            End If
        End If
        
        If Not Bac_Sql_Execute("COMMIT TRANSACTION") Then
            GoTo CP_GrabarTxError
        End If
        Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "Operación de Venta #" & Numoper & ", se grabó con éxito.")
        Call Imprimir_Papeletas("VP", Numoper, gsBac_Papeleta, "")
                    
        
        grilla.Rows = 1
        Call Func_Limpiar
    End If
   
   
    Exit Function
        
        
CP_GrabarTxError:

    MsgBox "Se ha producido un problema en la grabación de la operación de venta: " & err.Description & ". Comunique al Administrador. ", vbCritical, gsBac_Version
   
            
    If FlagTx = True Then
        If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
            MsgBox "No se pudo realizar devolución de transacción inicializada", vbCritical, gsBac_Version
        End If
    End If
   
    CP_GrabarTx = 0

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

