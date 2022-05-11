VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "TABCTL32.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form FRM_MNT_GARANTIA 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantenedor de Garantías Constituídas"
   ClientHeight    =   8280
   ClientLeft      =   105
   ClientTop       =   1695
   ClientWidth     =   12300
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   8280
   ScaleWidth      =   12300
   Begin VB.Frame Frame1 
      Height          =   1695
      Left            =   120
      TabIndex        =   8
      Top             =   600
      Width           =   11775
      Begin BACControles.TXTNumero txtFactorAditivo 
         Height          =   255
         Left            =   5880
         TabIndex        =   5
         Top             =   480
         Width           =   1815
         _ExtentX        =   3201
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
      Begin VB.TextBox txt_observaciones 
         Height          =   285
         Left            =   1320
         TabIndex        =   16
         Top             =   1200
         Width           =   9375
      End
      Begin VB.TextBox TxtCodigo 
         Alignment       =   2  'Center
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
         Height          =   285
         Left            =   1800
         MaxLength       =   5
         TabIndex        =   2
         Text            =   "1"
         Top             =   480
         Width           =   645
      End
      Begin VB.TextBox txtDigito 
         Enabled         =   0   'False
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
         Height          =   285
         Left            =   1470
         MaxLength       =   1
         TabIndex        =   1
         TabStop         =   0   'False
         Top             =   480
         Width           =   255
      End
      Begin VB.TextBox txtrut 
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
         ForeColor       =   &H00800000&
         Height          =   285
         Left            =   120
         MaxLength       =   9
         MouseIcon       =   "FRM_MNT_GARANTIAS.frx":0000
         MousePointer    =   99  'Custom
         MultiLine       =   -1  'True
         TabIndex        =   0
         Top             =   480
         Width           =   1275
      End
      Begin BACControles.TXTNumero TxtTotal 
         Height          =   255
         Left            =   7800
         TabIndex        =   6
         Top             =   480
         Width           =   2895
         _ExtentX        =   5106
         _ExtentY        =   450
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
      Begin VB.ComboBox Cmb_TipoGarantia 
         Height          =   315
         Left            =   3960
         Style           =   2  'Dropdown List
         TabIndex        =   4
         Top             =   480
         Width           =   1695
      End
      Begin BACControles.TXTFecha txt_FecRevision 
         Height          =   285
         Left            =   2640
         TabIndex        =   3
         Top             =   480
         Width           =   1215
         _ExtentX        =   2143
         _ExtentY        =   503
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
         Text            =   "18/05/2010"
      End
      Begin VB.Label Label4 
         AutoSize        =   -1  'True
         Caption         =   "Factor Aditivo"
         Height          =   195
         Left            =   5880
         TabIndex        =   17
         Top             =   240
         Width           =   975
      End
      Begin VB.Label Label3 
         Caption         =   "Observaciones"
         Height          =   255
         Left            =   120
         TabIndex        =   15
         Top             =   1250
         Width           =   1335
      End
      Begin VB.Label Label2 
         Caption         =   "Total"
         Height          =   255
         Index           =   4
         Left            =   7800
         TabIndex        =   14
         Top             =   240
         Width           =   375
      End
      Begin VB.Label LBL_NombreCliente 
         BackColor       =   &H00FFFFFF&
         BorderStyle     =   1  'Fixed Single
         Height          =   285
         Index           =   4
         Left            =   120
         TabIndex        =   7
         Top             =   840
         Width           =   10575
      End
      Begin VB.Label Label2 
         Caption         =   "Estatus"
         Height          =   255
         Index           =   2
         Left            =   5520
         TabIndex        =   13
         Top             =   240
         Visible         =   0   'False
         Width           =   615
      End
      Begin VB.Label Label2 
         Caption         =   "Tipo Garantía"
         Height          =   255
         Index           =   1
         Left            =   3960
         TabIndex        =   12
         Top             =   240
         Width           =   1095
      End
      Begin VB.Label Label2 
         Caption         =   "Fecha Revisión"
         Height          =   255
         Index           =   0
         Left            =   2640
         TabIndex        =   11
         Top             =   240
         Width           =   1215
      End
      Begin VB.Label Label1 
         Caption         =   "Rut Cliente  / Código Cliente"
         Height          =   255
         Left            =   120
         TabIndex        =   10
         Top             =   240
         Width           =   2175
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   9
      Top             =   0
      Width           =   12300
      _ExtentX        =   21696
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            Object.Tag             =   "Limpiar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            Object.Tag             =   "Grabar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            Object.Tag             =   "Salir"
            ImageIndex      =   8
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   7440
      Top             =   0
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   8
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_GARANTIAS.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_GARANTIAS.frx":11E4
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_GARANTIAS.frx":20BE
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_GARANTIAS.frx":2F98
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_GARANTIAS.frx":3E72
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_GARANTIAS.frx":4D4C
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_GARANTIAS.frx":5C26
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_GARANTIAS.frx":5F40
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin TabDlg.SSTab Paleta 
      Height          =   5775
      Left            =   240
      TabIndex        =   18
      Top             =   2400
      Width           =   12015
      _ExtentX        =   21193
      _ExtentY        =   10186
      _Version        =   393216
      Tabs            =   2
      TabsPerRow      =   2
      TabHeight       =   520
      TabCaption(0)   =   "Selección de Cartera"
      TabPicture(0)   =   "FRM_MNT_GARANTIAS.frx":625A
      Tab(0).ControlEnabled=   -1  'True
      Tab(0).Control(0)=   "Grilla"
      Tab(0).Control(0).Enabled=   0   'False
      Tab(0).Control(1)=   "Text1"
      Tab(0).Control(1).Enabled=   0   'False
      Tab(0).Control(2)=   "TxtIngreso"
      Tab(0).Control(2).Enabled=   0   'False
      Tab(0).ControlCount=   3
      TabCaption(1)   =   "Cartera Otorgada en Garantía"
      TabPicture(1)   =   "FRM_MNT_GARANTIAS.frx":6276
      Tab(1).ControlEnabled=   0   'False
      Tab(1).Control(0)=   "GridResumen"
      Tab(1).Control(1)=   "GridDetalle"
      Tab(1).ControlCount=   2
      Begin BACControles.TXTNumero TxtIngreso 
         Height          =   195
         Left            =   1320
         TabIndex        =   21
         Top             =   1680
         Visible         =   0   'False
         Width           =   915
         _ExtentX        =   1614
         _ExtentY        =   344
         BackColor       =   16744576
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
         BorderStyle     =   0
         Text            =   "0"
         Text            =   "0"
         Separator       =   -1  'True
      End
      Begin VB.TextBox Text1 
         BackColor       =   &H00FF8080&
         BorderStyle     =   0  'None
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   2760
         MaxLength       =   10
         TabIndex        =   20
         TabStop         =   0   'False
         Top             =   1680
         Visible         =   0   'False
         Width           =   980
      End
      Begin MSFlexGridLib.MSFlexGrid Grilla 
         Height          =   4365
         Left            =   120
         TabIndex        =   19
         TabStop         =   0   'False
         Top             =   480
         Width           =   11730
         _ExtentX        =   20690
         _ExtentY        =   7699
         _Version        =   393216
         Cols            =   7
         FixedCols       =   2
         BackColor       =   12632256
         ForeColor       =   0
         BackColorFixed  =   8388608
         ForeColorFixed  =   16777215
         BackColorSel    =   16744576
         ForeColorSel    =   16777215
         FocusRect       =   0
         GridLines       =   2
         GridLinesFixed  =   0
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
      Begin MSFlexGridLib.MSFlexGrid GridResumen 
         Height          =   2445
         Left            =   -74880
         TabIndex        =   22
         TabStop         =   0   'False
         Top             =   480
         Width           =   11370
         _ExtentX        =   20055
         _ExtentY        =   4313
         _Version        =   393216
         Cols            =   5
         FixedCols       =   2
         BackColor       =   12632256
         ForeColor       =   0
         BackColorFixed  =   8388608
         ForeColorFixed  =   16777215
         BackColorSel    =   16744576
         ForeColorSel    =   16777215
         FocusRect       =   0
         GridLines       =   2
         GridLinesFixed  =   0
         SelectionMode   =   1
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
      Begin MSFlexGridLib.MSFlexGrid GridDetalle 
         Height          =   2565
         Left            =   -74880
         TabIndex        =   23
         TabStop         =   0   'False
         Top             =   3000
         Width           =   11370
         _ExtentX        =   20055
         _ExtentY        =   4524
         _Version        =   393216
         Cols            =   5
         FixedCols       =   2
         BackColor       =   12632256
         ForeColor       =   0
         BackColorFixed  =   8388608
         ForeColorFixed  =   16777215
         BackColorSel    =   16744576
         ForeColorSel    =   16777215
         FocusRect       =   0
         GridLines       =   2
         GridLinesFixed  =   0
         SelectionMode   =   1
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
   End
End
Attribute VB_Name = "FRM_MNT_GARANTIA"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Public MihWnd                 As Long
Dim Sal         As BacTypeChkSerie
Dim DatosEnt    As BacValorizaInput  '-->   'Datos de Input
Dim DatosSal    As BacValorizaOutput '-->   'Datos de Salida


Private Enum bEstado
   [Normal] = 0
   [Tomado] = 1
   [VtaTotal] = 2
   [VtaParcial] = 3
End Enum

Const FDec4Dec = "#,##0.0000"
Const FDec2Dec = "#,##0.00"
Const FDec0Dec = "#,##0"

Const COL_Serie = 0
Const Col_Moneda = 1
Const Col_Nominal = 2
Const Col_Tir = 3
Const Col_VPar = 4
Const Col_MT = 5
Const Col_FactorM = 6
Const Col_MT_Gar = 7
Const Col_FechaVcto = 8

Const Col_Mascara = 9
Const Col_Codigo = 10
Const Col_RutEmi = 11
Const Col_MonEmi = 12

Const Col_TasEmi = 13
Const Col_BasEmi = 14
Const Col_FecEmi = 15
Const Col_FecVen = 16
Const Col_RefNom = 17
Const Col_GenEmi = 18
Const Col_NemMon = 19
Const Col_CorMin = 20
Const Col_Seriad = 21
Const Col_cLeEmi = 22
Const Col_Durata = 23
Const Col_Convex = 24
Const Col_DurMod = 25

Dim nModoCalculo        As Integer
Dim cMascara            As String
Dim nNominal            As Double
Dim nTir                As Double
Dim nPvp                As Double
Dim nMonto              As Double
Dim cFecCal             As String
Dim nFactor             As Double
Dim nValorInicial       As Double
Dim cUsuario            As String
Dim nVentana            As Double
Dim nMontoAnterior      As Double

Dim cSql                As String

Public bFlagDpx         As Boolean
Public bFlagPas         As Boolean
Public bajoOk           As Boolean

Dim SwEmision           As Boolean
Dim FormHandle          As Long
Dim bufNominal          As Double
Dim factorMulti         As Double
Dim factorAditi         As Double
Dim REGISTRO            As Integer
Dim tecla               As String
Dim iFlagKeyDown
Dim ANTES
' Constantes para la grilla de seleccion de Constituidas
' --------------------------------------------------------
Const Col_Con_Sel = 0
Const COL_Con_Fecha = 1
Const Col_Con_Folio = 2
Const Col_Con_Tipo = 3
Const Col_Con_Presente = 4
Const Col_Con_Monto = 5
Const Col_Con_FactorA = 6
' --------------------------------------------------------------

' Constantes para la grilla de seleccion detalle de Constituidas
' --------------------------------------------------------------
Const Col_det_numdocu = 0
Const COL_det_corre = 1
Const Col_det_nemo = 2
Const Col_det_Nominal = 3
Const Col_det_Tir = 4
Const Col_det_vpar = 5
Const Col_det_Valor = 6
Const Col_det_Factor = 7
Const Col_det_ValorAct = 8
Private objCliente As Object
Private Function funcTotalGrilla() As Double
Dim dblTotalGrilla  As Double
Dim iRow            As Long

    Let funcTotalGrilla = 0
    dblTotalGrilla = 0#
    
    For iRow = 1 To grilla.Rows - 1
    
        If grilla.TextMatrix(iRow, COL_Serie) <> "" Then
        
            Let dblTotalGrilla = dblTotalGrilla + CDbl(grilla.TextMatrix(iRow, Col_MT_Gar))
            
        End If
        
    Next iRow
    
    Let funcTotalGrilla = dblTotalGrilla

End Function
Private Function CargaTransaccionesConstituidas(ByVal modo As Boolean) As Long
Dim I As Long
    I = 0
    Envia = Array()
    AddParam Envia, Me.txtRut.Text
    AddParam Envia, Me.TxtCodigo.Text

        'If Not Bac_Sql_Execute("bacparamsuda.dbo.sp_gar_buscar_operaciones_constituidas", Envia) Then
        If Not Bac_Sql_Execute("bacparamsuda.dbo.SP_GAR_BUSOPERCONST", Envia) Then
        Let Screen.MousePointer = vbDefault
        Call MsgBox("Se ha originado un error en la lectura de operaciones." & vbCrLf & vbCrLf & VerSql, vbExclamation, App.Title)
        CargaTransaccionesConstituidas = 0
        Exit Function
    End If
    
    Let GridResumen.Rows = 1
    
        Do While Bac_SQL_Fetch(Datos())
        If modo Then
            Let GridResumen.Rows = GridResumen.Rows + 1
            Let GridResumen.TextMatrix(GridResumen.Rows - 1, Col_Con_Sel) = ""
            Let GridResumen.TextMatrix(GridResumen.Rows - 1, COL_Con_Fecha) = Datos(1)
            Let GridResumen.TextMatrix(GridResumen.Rows - 1, Col_Con_Folio) = Datos(2)
            Let GridResumen.TextMatrix(GridResumen.Rows - 1, Col_Con_Tipo) = Datos(4)
            Let GridResumen.TextMatrix(GridResumen.Rows - 1, Col_Con_Presente) = Format(Datos(5), FDec0Dec)
            Let GridResumen.TextMatrix(GridResumen.Rows - 1, Col_Con_Monto) = Format(Datos(6), FDec0Dec)
            Let GridResumen.TextMatrix(GridResumen.Rows - 1, Col_Con_FactorA) = Format(Datos(3), FDec0Dec)
        End If
        I = I + 1
    Loop
    CargaTransaccionesConstituidas = I
End Function
Private Sub subCargaTransaccionesConstituidasDetalle(iFolio As Long)

    Envia = Array()
    AddParam Envia, iFolio
    

    'If Not Bac_Sql_Execute("bacparamsuda.dbo.sp_gar_buscar_operaciones_constituidas_detalle", Envia) Then
    If Not Bac_Sql_Execute("bacparamsuda.dbo.SP_GAR_BUSOPERCONST_DET", Envia) Then
        Let Screen.MousePointer = vbDefault
        Call MsgBox("Se ha originado un error en la lectura de operaciones." & vbCrLf & vbCrLf & VerSql, vbExclamation, App.Title)
        Exit Sub
    End If
    
    Let GridDetalle.Rows = 1
    
    Do While Bac_SQL_Fetch(Datos())
        GridDetalle.Rows = GridDetalle.Rows + 1
        GridDetalle.TextMatrix(GridDetalle.Rows - 1, Col_det_numdocu) = Datos(1)
        GridDetalle.TextMatrix(GridDetalle.Rows - 1, COL_det_corre) = Datos(2)
        GridDetalle.TextMatrix(GridDetalle.Rows - 1, Col_det_nemo) = Datos(3)
        GridDetalle.TextMatrix(GridDetalle.Rows - 1, Col_det_Nominal) = Format(Datos(4), FDec4Dec)
        GridDetalle.TextMatrix(GridDetalle.Rows - 1, Col_det_Tir) = Format(Datos(5), FDec4Dec)
        GridDetalle.TextMatrix(GridDetalle.Rows - 1, Col_det_vpar) = Format(Datos(6), FDec4Dec)
        GridDetalle.TextMatrix(GridDetalle.Rows - 1, Col_det_Valor) = Format(Datos(7), FDec0Dec)
        GridDetalle.TextMatrix(GridDetalle.Rows - 1, Col_det_Factor) = Format(Datos(8), FDec4Dec)
        GridDetalle.TextMatrix(GridDetalle.Rows - 1, Col_det_ValorAct) = Format(Datos(9), FDec0Dec)
    Loop
    

End Sub


Private Sub subSettingGridVisible(ByRef xGrilla As MSFlexGrid)
Dim nContador  As Long

    
    Let xGrilla.WordWrap = True
    
    Let xGrilla.Rows = 2:      Let xGrilla.Cols = Col_DurMod + 1 ' VB+- 25/01/2010 Se agregan 2 columas para el tema de la carteras
    Let xGrilla.Row = 1:       Let xGrilla.Col = 1
    Let xGrilla.FixedRows = 1: Let xGrilla.FixedCols = 0
    
    Let xGrilla.RowHeight(0) = 500
    Let xGrilla.TextMatrix(0, COL_Serie) = "Nemotecnico":        Let xGrilla.ColWidth(COL_Serie) = 1300:         Let xGrilla.TextMatrix(1, COL_Serie) = ""
    Let xGrilla.TextMatrix(0, Col_Moneda) = "UM":                Let xGrilla.ColWidth(Col_Moneda) = 500:         Let xGrilla.TextMatrix(1, Col_Moneda) = ""
    Let xGrilla.TextMatrix(0, Col_Nominal) = "Nominal":          Let xGrilla.ColWidth(Col_Nominal) = 2000:       Let xGrilla.TextMatrix(1, Col_Nominal) = Format(0#, FDec4Dec)
    Let xGrilla.TextMatrix(0, Col_Tir) = "TIR":                  Let xGrilla.ColWidth(Col_Tir) = 1000:           Let xGrilla.TextMatrix(1, Col_Tir) = Format(0#, FDec4Dec)
    Let xGrilla.TextMatrix(0, Col_VPar) = "%Vpar":               Let xGrilla.ColWidth(Col_VPar) = 900:           Let xGrilla.TextMatrix(1, Col_VPar) = Format(0#, FDec4Dec)
    Let xGrilla.TextMatrix(0, Col_MT) = "Valor Presente":        Let xGrilla.ColWidth(Col_MT) = 2500:            Let xGrilla.TextMatrix(1, Col_MT) = Format(0#, FDec0Dec)
    Let xGrilla.TextMatrix(0, Col_FactorM) = "Factor Mult.":    Let xGrilla.ColWidth(Col_FactorM) = 900:         Let xGrilla.TextMatrix(1, Col_FactorM) = Format(0#, FDec4Dec)
    Let xGrilla.TextMatrix(0, Col_MT_Gar) = "Valor Actualizado": Let xGrilla.ColWidth(Col_MT_Gar) = 2500:        Let xGrilla.TextMatrix(1, Col_MT_Gar) = Format(0#, FDec0Dec)
    
    Let xGrilla.TextMatrix(0, Col_FechaVcto) = "Fecha Vcto":     Let xGrilla.ColWidth(Col_FechaVcto) = 0:        Let xGrilla.TextMatrix(1, Col_FechaVcto) = ""
   
    For nContador = Col_FechaVcto + 1 To Col_DurMod
    
        Let xGrilla.ColWidth(nContador) = 0
    
    Next nContador
    xGrilla.TextMatrix(1, Col_FactorM) = factorMulti
End Sub
Private Sub Valorizar_RentaFija(iModCal As Integer)
Dim iCurrentRow As Integer

On Error GoTo ValorizarError


    Let Screen.MousePointer = vbHourglass

    Let iCurrentRow = grilla.RowSel

    Let DatosEnt.ModCal = iModCal
    Let DatosEnt.FecCal = Format$(gsbac_fecp, "yyyymmdd")
    
    Let DatosEnt.Codigo = grilla.TextMatrix(iCurrentRow, Col_Codigo)
    Let DatosEnt.Mascara = grilla.TextMatrix(iCurrentRow, COL_Serie)
    Let DatosEnt.Nominal = grilla.TextMatrix(iCurrentRow, Col_Nominal)
    
    Let DatosEnt.tir = grilla.TextMatrix(iCurrentRow, Col_Tir)
    Let DatosEnt.Pvp = grilla.TextMatrix(iCurrentRow, Col_VPar)
    Let DatosEnt.Mt = grilla.TextMatrix(iCurrentRow, Col_MT)
    
    Let DatosEnt.TasEst = 0
    Let DatosEnt.MonEmi = grilla.TextMatrix(iCurrentRow, Col_MonEmi)
    Let DatosEnt.fecemi = grilla.TextMatrix(iCurrentRow, Col_FecEmi)
    Let DatosEnt.FecVen = grilla.TextMatrix(iCurrentRow, Col_FecVen)
    Let DatosEnt.TasEmi = grilla.TextMatrix(iCurrentRow, Col_TasEmi)
    Let DatosEnt.BasEmi = grilla.TextMatrix(iCurrentRow, Col_BasEmi)


    If Mid(DatosEnt.Mascara, 1, 6) <> "FMUTUO" Then
        If DatosEnt.Nominal# = 0 Then
            Let Screen.MousePointer = 0
            Exit Sub
        End If
    End If
       
    Envia = Array(CDbl(DatosEnt.ModCal), _
            DatosEnt.FecCal, _
            CDbl(DatosEnt.Codigo), _
            DatosEnt.Mascara, _
            CDbl(DatosEnt.MonEmi), _
            DatosEnt.fecemi, _
            DatosEnt.FecVen, _
            CDbl(DatosEnt.TasEmi), _
            CDbl(DatosEnt.BasEmi), _
            CDbl(DatosEnt.TasEst&), _
            DatosEnt.Nominal, _
            CDbl(DatosEnt.tir), _
            DatosEnt.Pvp, _
            DatosEnt.Mt)
    
    If Not Bac_Sql_Execute("bactradersuda.dbo.SP_VALORIZAR_CLIENT", Envia) Then
        GoTo ValorizarError
    End If
       
    Dim Datos()
    If Bac_SQL_Fetch(Datos()) Then
    
        If Val(Datos(1)) = 0 Then
            Let DatosSal.Nominal# = Datos(2)
            Let DatosSal.tir# = Datos(3)
            Let DatosSal.Pvp# = Datos(4)
            Let DatosSal.Mt# = Datos(5)
            Let DatosSal.MtUM# = Datos(6)
            Let DatosSal.Mt100# = Datos(7)
            Let DatosSal.van# = Datos(8)
            Let DatosSal.Vpar# = Datos(9)
            Let DatosSal.Numucup% = Datos(10)
            Let DatosSal.Fecucup$ = Datos(11)
            Let DatosSal.Intucup# = Datos(12)
            Let DatosSal.Amoucup# = Datos(13)
            Let DatosSal.Salucup# = Datos(14)
            Let DatosSal.Numpcup% = Datos(15)
            Let DatosSal.Fecpcup$ = Datos(16)
            Let DatosSal.Intpcup# = Datos(17)
            Let DatosSal.Amopcup# = Datos(18)
            Let DatosSal.Salpcup# = Datos(19)
            Let DatosSal.duratmac# = Datos(20)
            Let DatosSal.convexid# = Datos(21)
            Let DatosSal.duratmod# = Datos(22)
        Else
           Let Screen.MousePointer = 0
           Call MsgBox(Datos(2), vbExclamation, gsBac_Version)
           Exit Sub
        End If
    
    End If
   
    Let Screen.MousePointer = 0
    
    Let grilla.TextMatrix(iCurrentRow, Col_Nominal) = Format(DatosSal.Nominal, FDec4Dec)
    Let grilla.TextMatrix(iCurrentRow, Col_Tir) = Format(DatosSal.tir, FDec4Dec)
    Let grilla.TextMatrix(iCurrentRow, Col_VPar) = Format(DatosSal.Pvp, FDec4Dec)
    Let grilla.TextMatrix(iCurrentRow, Col_MT) = Format(DatosSal.Mt, FDec0Dec)
    
  ' Se Calcula Monto actualizado del Margen
    Let grilla.TextMatrix(iCurrentRow, Col_MT_Gar) = Format(DatosSal.Mt * grilla.TextMatrix(iCurrentRow, Col_FactorM), FDec0Dec)
    
    Let grilla.TextMatrix(iCurrentRow, Col_Durata) = DatosSal.duratmac
    Let grilla.TextMatrix(iCurrentRow, Col_Convex) = DatosSal.convexid
    Let grilla.TextMatrix(iCurrentRow, Col_DurMod) = DatosSal.duratmod

    Exit Sub
    
ValorizarError:

    Let Screen.MousePointer = 0

    If Err <> 0 Then
        Call MsgBox(Datos(2), vbCritical, gsBac_Version)
    End If
    Exit Sub


End Sub



Private Sub Cmb_TipoGarantia_KeyPress(KeyAscii As Integer)
    If KeyAscii = vbKeyReturn Then
        txtFactorAditivo.SetFocus
    End If
End Sub

Private Sub Cmb_TipoGarantia_LostFocus()
    If Trim(LBL_NombreCliente(4).Caption) = "" Then
        MsgBox "No ha seleccionado Cliente!", vbExclamation, TITSISTEMA
        txtRut.SetFocus
        Exit Sub
    End If
    txtFactorAditivo.SetFocus
End Sub

Private Sub Form_Load()

    Me.Top = 0: Me.Left = 0
    Set objCliente = New clsCliente
    Screen.MousePointer = vbHourglass
    Let iFlagKeyDown = True
    factorMulti = 1#
    FormHandle = Me.hWnd
    
    txtFactorAditivo.Text = 0
    Call subSettingGridVisible(Me.grilla)
    
    'Call LOAD_Destinatarios(Cmb_TipoGarantia)
    Call LOAD_TiposGarantias(Cmb_TipoGarantia, "C")
    
    Call BloqueaBotones(True, "2")
    grilla.Enabled = False
    txt_FecRevision.Text = gsBAC_Fecpx
    Paleta.TabVisible(0) = True
    Paleta.TabVisible(1) = False
    
    Screen.MousePointer = vbDefault
    
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Set objCliente = Nothing
End Sub

Private Sub GridResumen_Click()
    If Val(GridResumen.TextMatrix(GridResumen.RowSel, Col_Con_Folio)) <> 0 Then
        Call subCargaTransaccionesConstituidasDetalle(GridResumen.TextMatrix(GridResumen.RowSel, Col_Con_Folio))
    End If
End Sub

Private Sub Grilla_GotFocus()

        If grilla.Enabled = True Then
            Frame1.Enabled = False
        
        End If

End Sub

'
Private Sub grilla_KeyDown(KeyCode As Integer, Shift As Integer)
Dim Columna As Integer
    
    Let Columna = grilla.Col
    If Columna = Col_Moneda Then
        'SendKeys "{RIGHT}"
        Exit Sub
    End If
    If Columna = Col_MT_Gar Then
        Exit Sub
    End If
    
    If Not iFlagKeyDown Then
        On Error GoTo 0
        Exit Sub
    End If

    If KeyCode = vbKeyInsert Then
    
        Let aux = grilla.Row
        
        If grilla.Enabled = True Then grilla.SetFocus
    
        Call BacControlWindows(60)
        Call Bac_SendKey(vbKeyHome)
    
        If Trim$(grilla.TextMatrix(grilla.Row, COL_Serie)) = "" Then
            Call MsgBox("Ingrese serie antes de insertar otra Fila", vbInformation, TITSISTEMA)
            If grilla.Enabled = True Then: grilla.SetFocus
            Exit Sub
        End If

        BacControlWindows 60

        If Trim$(grilla.TextMatrix(grilla.Row, Col_Moneda) <> "" And grilla.TextMatrix(grilla.Row, Col_Tir) <> 0 And Val(grilla.TextMatrix(grilla.Row, Col_MT))) <> 0 Then
            BacControlWindows 60
            grilla.Col = COL_Serie
        Else
            If Trim$(Mid(grilla.TextMatrix(grilla.Row, COL_Serie), 1, 6) = "FMUTUO" And Val(grilla.TextMatrix(grilla.Row, Col_MT))) <> 0 Then
                BacControlWindows 60
                grilla.Col = COL_Serie
            Else
                grilla.Row = aux
            End If
        End If

        grilla.Rows = grilla.Rows + 1
        Call subLimpia_grilla
        grilla.Row = grilla.Rows - 1

    
        Let grilla.Col = COL_Serie
        Let grilla.ColSel = COL_Serie
    
    ElseIf KeyCode = vbKeyUp Then
    
        If Trim$(grilla.TextMatrix(grilla.Row, COL_Serie)) = "" Then
        
            Call BacControlWindows(60)
            
            TxtTotal.Text = funcTotalGrilla() + factorAditi
        
        End If
    
    
    ElseIf KeyCode = vbKeyDelete Then
    
            If Not grilla.Rows = 2 Then
    
                Call grilla.RemoveItem(grilla.Row)
                Let grilla.Col = COL_Serie
                Let grilla.ColSel = COL_Serie
    
            Else
    
                Let grilla.TextMatrix(1, 0) = ""
                Let grilla.TextMatrix(1, 1) = ""
                Call subLimpia_grilla
    
            End If
    
            Call grilla.Refresh
            Let TxtTotal.Text = funcTotalGrilla() + factorAditi
    
        End If
    
    On Error GoTo 0
        Exit Sub
    
KeyDownError:
   On Error GoTo 0
   MsgBox "Problemas en tabla de ingreso de datos: " & Err.Description, vbExclamation, gsBac_Version
   Exit Sub


End Sub
Private Sub Paleta_Click(PreviousTab As Integer)
    If Paleta.Tab = 0 Then
        Call BloqueaBotones(False, "2")
    End If

    If Paleta.Tab = 1 Then
         Call BloqueaBotones(True, "2")
         Call subSettingGridVisible(Me.GridResumen)
         Call subSettingGridConstituidas(Me.GridResumen)
         Call CargaTransaccionesConstituidas(True)
         Call subSettingGridConstituidasDetalle(Me.GridDetalle)
    End If

End Sub
Private Sub subSettingGridConstituidas(ByRef xGrilla As MSFlexGrid)

    Let xGrilla.WordWrap = True
    
    Let xGrilla.Rows = 2:      Let xGrilla.Cols = 7
    Let xGrilla.Row = 1:       Let xGrilla.Col = 1
    Let xGrilla.FixedRows = 1: Let xGrilla.FixedCols = 0
    
    Let xGrilla.RowHeight(0) = 500
    Let xGrilla.TextMatrix(0, Col_Con_Sel) = "S":                        Let xGrilla.ColWidth(Col_Con_Sel) = 500:            Let xGrilla.TextMatrix(1, Col_Con_Sel) = ""
    Let xGrilla.TextMatrix(0, COL_Con_Fecha) = "Fecha":                  Let xGrilla.ColWidth(COL_Con_Fecha) = 1500:         Let xGrilla.TextMatrix(1, COL_Con_Fecha) = ""
    Let xGrilla.TextMatrix(0, Col_Con_Folio) = "N° Oper.":                Let xGrilla.ColWidth(Col_Con_Folio) = 1500:         Let xGrilla.TextMatrix(1, Col_Con_Folio) = ""
    Let xGrilla.TextMatrix(0, Col_Con_Tipo) = "Tipo Garantía":           Let xGrilla.ColWidth(Col_Con_Tipo) = 3000:          Let xGrilla.TextMatrix(1, Col_Con_Tipo) = ""
    Let xGrilla.TextMatrix(0, Col_Con_Presente) = "Garantia Original":   Let xGrilla.ColWidth(Col_Con_Presente) = 2500:      Let xGrilla.TextMatrix(1, Col_Con_Presente) = Format(0#, FDec0Dec)
    Let xGrilla.TextMatrix(0, Col_Con_Monto) = "Monto Actualizado":      Let xGrilla.ColWidth(Col_Con_Monto) = 2500:         Let xGrilla.TextMatrix(1, Col_Con_Monto) = Format(0#, FDec0Dec)
    Let xGrilla.TextMatrix(0, Col_Con_FactorA) = "Factor Aditivo":      Let xGrilla.ColWidth(Col_Con_FactorA) = 2500:         Let xGrilla.TextMatrix(1, Col_Con_FactorA) = Format(0#, FDec0Dec)

End Sub
Private Sub subSettingGridConstituidasDetalle(ByRef xGrilla As MSFlexGrid)

    Let xGrilla.WordWrap = True
    
    Let xGrilla.Rows = 2:      Let xGrilla.Cols = 9
    xGrilla.RowSel = 1
    Let xGrilla.FixedRows = 1: Let xGrilla.FixedCols = 0
    
    Let xGrilla.RowHeight(0) = 500
    Let xGrilla.TextMatrix(0, Col_det_numdocu) = "N° Oper.":         Let xGrilla.ColWidth(Col_det_numdocu) = 1500:            Let xGrilla.TextMatrix(1, Col_det_numdocu) = Format(0#, FDec0Dec)
    Let xGrilla.TextMatrix(0, COL_det_corre) = "Correlativo":       Let xGrilla.ColWidth(COL_det_corre) = 1000:             Let xGrilla.TextMatrix(1, COL_det_corre) = Format(0#, FDec0Dec)
    Let xGrilla.TextMatrix(0, Col_det_nemo) = "Instrumento":        Let xGrilla.ColWidth(Col_det_nemo) = 1500:              Let xGrilla.TextMatrix(1, Col_det_nemo) = ""
    Let xGrilla.TextMatrix(0, Col_det_Nominal) = "Nominal":         Let xGrilla.ColWidth(Col_det_Nominal) = 2500:           Let xGrilla.TextMatrix(1, Col_det_Nominal) = Format(0#, FDec4Dec)
    Let xGrilla.TextMatrix(0, Col_det_Tir) = "TIR":                 Let xGrilla.ColWidth(Col_det_Tir) = 1500:               Let xGrilla.TextMatrix(1, Col_det_Tir) = Format(0#, FDec4Dec)
    Let xGrilla.TextMatrix(0, Col_det_vpar) = "VPAR":               Let xGrilla.ColWidth(Col_det_vpar) = 1500:              Let xGrilla.TextMatrix(1, Col_det_vpar) = Format(0#, FDec4Dec)
    Let xGrilla.TextMatrix(0, Col_det_Valor) = "Valor Presente":     Let xGrilla.ColWidth(Col_det_Valor) = 2500:             Let xGrilla.TextMatrix(1, Col_det_Valor) = Format(0#, FDec4Dec)
    xGrilla.TextMatrix(0, Col_det_Factor) = "Factor Mult.":         xGrilla.ColWidth(Col_det_Factor) = 1500:                xGrilla.TextMatrix(1, Col_det_Factor) = Format(0#, FDec4Dec)
    xGrilla.TextMatrix(0, Col_det_ValorAct) = "Valor Pte. Act.":    xGrilla.ColWidth(Col_det_ValorAct) = 2500:                xGrilla.TextMatrix(1, Col_det_ValorAct) = Format(0#, FDec4Dec)
End Sub


Private Sub txt_FecRevision_KeyPress(KeyAscii As Integer)
If KeyAscii = vbKeyReturn Then
    Cmb_TipoGarantia.SetFocus
End If
End Sub

Private Sub txt_observaciones_KeyPress(KeyAscii As Integer)
    
    Call BacToUCase(KeyAscii)
    
End Sub


Private Sub TxtCodigo_LostFocus()
Dim idRut       As Long
Dim IdDig       As String
Dim IdCod       As Long
Dim I           As Long
Dim tecla       As Integer
Dim sNombreCli As String



    If Trim(txtRut.Text) = "" Then
        Exit Sub
    End If
    If Trim(TxtCodigo.Text) = "" Then
        Exit Sub
    End If
    objCliente.clrut = txtRut.Text
    objCliente.clcodigo = TxtCodigo.Text
    If objCliente.LeerPorRut(objCliente.clrut, objCliente.clcodigo) Then
        txtRut.Enabled = True
        'txtDigito.Enabled = True
        TxtCodigo.Enabled = True
        txtRut.Text = objCliente.clrut
        txtDigito.Text = objCliente.cldv
        TxtCodigo.Text = objCliente.clcodigo
        LBL_NombreCliente(4).Caption = objCliente.clnombre
        If CargaTransaccionesConstituidas(False) > 0 Then
            Paleta.TabVisible(1) = True
        End If
         'Bloquear Rut
        txtRut.Enabled = False
        txtDigito.Enabled = False
        TxtCodigo.Enabled = False
    Else
        MsgBox "Atención!, el cliente buscado no existe.", vbExclamation, TITSISTEMA
        Call Limpiar
        txtRut.SetFocus
        Exit Sub
    End If






'    If Val(txtrut.Text) = 0 Or Trim(txtDigito.Text) = "" Then Exit Sub
'
'    If Trim(LBL_NombreCliente(4).Caption) = "" Then
'        MsgBox "No ha seleccionado Cliente!", vbExclamation, TITSISTEMA
'        txtrut.SetFocus
'        Exit Sub
'    End If
'
'    If Trim(TxtCodigo) = "" Or Trim(txtrut) = "" Then
'        If Val(TxtCodigo) = 0 Then
'            MsgBox "Error : El código no puede ser cero ", 16, TITSISTEMA
'        Else
'            MsgBox "Error : Datos en Blanco ", 16, TITSISTEMA
'        End If
'
'        txtrut.SetFocus
'        Exit Sub
'    End If
'
'    idRut = txtrut.Text
'    IdDig = txtDigito.Text
'    IdCod = TxtCodigo.Text

    'If funcBuscaClienteGARANTIA(idRut, IdDig, IdCod, sNombreCli) Then
'        LBL_NombreCliente(4).Caption = sNombreCli
'        If CargaTransaccionesConstituidas(False) > 0 Then
'            Paleta.TabVisible(1) = True
'        End If
    'End If
   
   Call BloqueaBotones(False, "2")
   grilla.Enabled = True
   grilla.TextMatrix(grilla.Rows - 1, Col_FactorM) = factorMulti
End Sub

Private Sub txtCodigo_KeyPress(KeyAscii As Integer)
    If KeyAscii% = vbKeyReturn Then
        KeyAscii% = 0
        SendKeys "{TAB}"
    ElseIf Not ((KeyAscii > 47 And KeyAscii < 58) Or KeyAscii = 8) Then
        KeyAscii = 0
        BacCaracterNumerico KeyAscii
    End If
End Sub
Private Sub subLimpia_grilla()
   
   Let grilla.TextMatrix(grilla.Rows - 1, Col_Nominal) = Format(0#, FDec4Dec)
   Let grilla.TextMatrix(grilla.Rows - 1, Col_Tir) = Format(0#, FDec4Dec)
   Let grilla.TextMatrix(grilla.Rows - 1, Col_VPar) = Format(0#, FDec4Dec)
   Let grilla.TextMatrix(grilla.Rows - 1, Col_MT) = Format(0#, FDec0Dec)
   Let grilla.TextMatrix(grilla.Rows - 1, Col_FactorM) = Format(factorMulti, FDec4Dec)
   Let grilla.TextMatrix(grilla.Rows - 1, Col_MT_Gar) = Format(0#, FDec0Dec)
   Let grilla.TextMatrix(grilla.Rows - 1, Col_FechaVcto) = ""
   
End Sub
Private Sub grilla_KeyPress(KeyAscii As Integer)

Dim Columna As Integer
      
    Let Columna = grilla.Col
    
    If Columna = Col_Moneda Then
        'SendKeys "{RIGHT}"
        Exit Sub
    End If
    If Columna = Col_MT_Gar Then
        Exit Sub
    End If
    
    If Columna = COL_Serie Then
        Call BacControlWindows(100)
        Let Text1.Enabled = True
        Let Text1.Visible = True

        If KeyAscii <> vbKeyReturn Then
            Let Text1.Text = UCase(Chr(KeyAscii))
        Else
            Let Text1.Text = Trim(grilla.TextMatrix(grilla.Row, Columna))
        End If

        Let Text1.MaxLength = 10        'era 12
        Call Text1.SetFocus
        Call BacControlWindows(100)
        
        Exit Sub
        
    End If

    Call FUNC_Decimales_de_Moneda(grilla.TextMatrix(grilla.Row, Col_Moneda))
        
    If Columna <> COL_Serie And Columna <> Col_Moneda Then
    
        If Columna = Col_Tir And Mid(grilla.TextMatrix(grilla.Row, COL_Serie), 1, 6) = "FMUTUO" Then
            Let TxtIngreso.Enabled = False
            Exit Sub
        Else
            Let TxtIngreso.Enabled = True
            Let TxtIngreso.Text = BacCtrlTransMonto(CDbl(grilla.TextMatrix(grilla.Row, Columna)))
        End If
        
        If Columna = Col_MT Then
            
            Let TxtIngreso.CantidadDecimales = gsMONEDA_Decimales
            
        Else
            If Mid(grilla.TextMatrix(grilla.Row, COL_Serie), 1, 6) = "FMUTUO" Then
            
                If grilla.TextMatrix(grilla.Row, Col_Moneda) = "CLP" Then
                
                    If Columna = Col_VPar Then
                        Let TxtIngreso.CantidadDecimales = 4
                    Else
                        Let TxtIngreso.CantidadDecimales = 4 '--> 0
                    End If
                    
                Else
                
                    Let TxtIngreso.CantidadDecimales = 4
                    
                End If
            Else
                If bFlagDpx Then
                
                    Let TxtIngreso.CantidadDecimales = 2
                    
                Else
                
                    Let TxtIngreso.CantidadDecimales = 4
                    
                End If
                
            End If
        End If
        
        'TxtIngreso.Visible = True
        If KeyAscii > 47 And KeyAscii < 58 Then
            TxtIngreso.Visible = True
            TxtIngreso.Text = Chr(KeyAscii)
            TxtIngreso.SetFocus
            Exit Sub
        End If
    End If
    
    Call BacToUCase(KeyAscii)

    If grilla.Col > COL_Serie Then
        If Len(Trim$(grilla.TextMatrix(grilla.Row, COL_Serie))) = 0 Then
            Let KeyAscii = 0
        End If
    End If


    Select Case Columna
    
        Case Col_Nominal, Col_MT
            If KeyAscii <> 27 Then
                If Not iFlagKeyDown Then
                    KeyAscii = BacPunto(grilla, KeyAscii, 12, 4)
                End If
        
                KeyAscii = BACValIngNumGrid(KeyAscii)
            End If
        
        Case Col_Tir, Col_VPar
        
            If KeyAscii <> 27 Then
                If Not iFlagKeyDown Then
                    KeyAscii = BacPunto(grilla, KeyAscii, 3, 4)
                End If
        
                KeyAscii = BACValIngNumGrid(KeyAscii)
            End If
            
    End Select


End Sub



Private Sub Text1_GotFocus()

   Call PROC_POSI_TEXTO(grilla, Text1)
   Text1.SelStart = Len(Text1)

End Sub
Private Sub Text1_KeyDown(KeyCode As Integer, Shift As Integer)
Dim Porcentaje       As Double
Dim Nominal          As Double

Dim Value            As String
Dim cFormato         As String

Dim Col              As Integer
Dim nFilaValida      As Integer

Dim CorteMin#
Dim iok%
Dim Columna%
Dim LeeEmi$


On Error GoTo ExitEditError

   
If KeyCode = vbKeyEscape Then
    Let Text1.Text = ""
    Let Text1.Visible = False
End If
   
    
If KeyCode = vbKeyReturn Then
    If grilla.Col = COL_Serie Then
        If Not Validar_SerieFM(Text1.Text) Then
            MsgBox "Serie ingresada no corresponde"
            Exit Sub
        End If
        grilla.ColWidth(3) = 900
        If Text1.Text = "FMUTUO" Then
            grilla.ColWidth(3) = 1800
        ElseIf Mid$(Text1.Text, 1, 3) = "DPX" Then
            MsgBox "PAPEL NO VALIDO", vbExclamation, Me.Caption
            Text1.SetFocus
            Exit Sub
        End If
    End If
    If grilla.Col <> COL_Serie Then
        Value = CDec(TxtIngreso.Text)
    End If
    Col% = grilla.Col
    Select Case Col%
         Case COL_Serie:
             Value = Text1.Text
             iok = funcChkSerie(Value, Sal)
             If iok = False Then
                 Call subLimpia_grilla
                 grilla.TextMatrix(grilla.Row, COL_Serie) = ""
                 Exit Sub
                 iFlagKeyDown = False
             Else
                 Call subLimpia_grilla
                 Columna = grilla.Col
                 LeeEmi$ = Sal.cLeeEmi
                 SwEmision = True
               ' Se actualiza los otros datos del Registro de Ingreso
               ' ====================================================
                 grilla.TextMatrix(grilla.Row, COL_Serie) = Trim(Text1.Text)
                 grilla.TextMatrix(grilla.Row, Col_Codigo) = Sal.nCodigo
                 grilla.TextMatrix(grilla.Row, Col_RutEmi) = Sal.nRutemi
                 grilla.TextMatrix(grilla.Row, Col_MonEmi) = Sal.nMonemi
                 grilla.TextMatrix(grilla.Row, Col_BasEmi) = Sal.fBasemi
                 grilla.TextMatrix(grilla.Row, Col_TasEmi) = Sal.fTasemi
                 grilla.TextMatrix(grilla.Row, Col_FecEmi) = Sal.dFecemi
                 grilla.TextMatrix(grilla.Row, Col_FecVen) = Sal.dFecVen
                 grilla.TextMatrix(grilla.Row, Col_RefNom) = Sal.cRefnomi
                 grilla.TextMatrix(grilla.Row, Col_GenEmi) = Sal.cGenemi
                 grilla.TextMatrix(grilla.Row, Col_NemMon) = Sal.cNemmon
                 grilla.TextMatrix(grilla.Row, Col_CorMin) = Sal.nCorMin
                 grilla.TextMatrix(grilla.Row, Col_Seriad) = Sal.cSeriado
                 grilla.TextMatrix(grilla.Row, Col_cLeEmi) = Sal.cLeeEmi
                 grilla.TextMatrix(grilla.Row, Col_Durata) = 0#
                 grilla.TextMatrix(grilla.Row, Col_Convex) = 0#
                 grilla.TextMatrix(grilla.Row, Col_DurMod) = 0#
               ' ----------------------------------------------------
                 grilla.TextMatrix(grilla.Row, Col_FactorM) = factorMulti
                 If InStr("S", LeeEmi$) Then
                     SwEmision = False
                     Call Func_Emision(grilla)
                 End If
                 Text1.Text = Value
                 'reestablecer valor almacenado en Sal
                 grilla.TextMatrix(grilla.Row, Col_Codigo) = Sal.nCodigo
                 Call subLimpia_grilla
             End If
serie:
            grilla.Col = Col%
            grilla.TextMatrix(grilla.Row, grilla.Col) = Trim(Text1.Text)
        Case Col_Nominal:
            If CDbl(Value) < 0 Or Len(Value) > 22 Then
                MsgBox "Nominal ingresado NO es valido.", 16, gsBac_Version
                Value = 0
                Exit Sub
            End If
            If Not IsNumeric(Value) Then
                Value = 0
            End If
            Nominal# = CDbl(Value)
            Call Valorizar_RentaFija(2) 'nuevo
        Case Col_Tir:
            Call Valorizar_RentaFija(2)
        Case Col_VPar
            Call Valorizar_RentaFija(1)
        Case Col_MT:
            If CDbl(Value) < 0 Or Len(Value) > 16 Then
                MsgBox "Valor presente ingresado NO es valido.", 16, gsBac_Version
                Value = 0
                If grilla.Enabled = True Then
                   grilla.SetFocus
                End If
                Exit Sub
            End If
            Call Valorizar_RentaFija(3)
           'Calcular el Valor Actualizado por el factor Multiplicativo
            grilla.TextMatrix(grilla.Row, Col_MT_Gar) = Format(grilla.TextMatrix(grilla.Row, Col_MT) * grilla.TextMatrix(grilla.Row, Col_FactorM), FDec0Dec)
        Case Col_FactorM
            grilla.TextMatrix(grilla.Row, Col_MT_Gar) = Format(grilla.TextMatrix(grilla.Row, Col_MT) * grilla.TextMatrix(grilla.Row, Col_FactorM), FDec0Dec)
           
      End Select
      Columna = grilla.Col
      BacControlWindows 20
      If Columna > Col_Moneda Then
           BacControlWindows 12
            TxtTotal.Text = BacCtrlTransMonto(funcTotalGrilla() + factorAditi)
      End If
      iFlagKeyDown = True
      If Columna = COL_Serie Then
         grilla.Col = Columna + 2
      ElseIf Columna = Col_Nominal Then
        
         If Mid(grilla.TextMatrix(grilla.Row, COL_Serie), 1, 6) = "FMUTUO" Then
             grilla.Col = Columna + 2
         Else
            grilla.Col = Columna + 1
         End If
 
      End If


      Text1.Text = ""
      Text1.Visible = False
      TxtIngreso.Text = 0
      TxtIngreso.Visible = False

      If grilla.Col <> Col_Nominal Then
        ' Llena_Grilla()
                
      Else
        grilla.TextMatrix(grilla.Row, Col_Moneda) = Sal.cNemmon
         Call subLimpia_grilla
      End If
   End If
    
   On Error GoTo 0

Exit Sub
ExitEditError:
   On Error GoTo 0
   iFlagKeyDown = True
   grilla.Row = grilla.Rows - 1
 '  Grilla.TextMatrix(Grilla.Row, nCol_TIR) = Format(Monto, "###,###,###,##0.0000")
   Text1.Visible = False
End Sub
Function Validar_SerieFM(serie As String) As Boolean
Dim iRow As Integer
Dim noOk As Boolean

noOk = True

    If Mid(serie, 1, 6) = "FMUTUO" Then
       For iRow = 1 To grilla.Rows - 2
            If grilla.TextMatrix(iRow, COL_Serie) <> serie Then
                noOk = False
                Exit Function
            End If
       Next iRow
    Else
       For iRow = 1 To grilla.Rows - 2
            If Mid(grilla.TextMatrix(iRow, COL_Serie), 1, 6) = "FMUTUO" Then
                noOk = False
                Exit Function
            End If
       Next iRow
    End If

Validar_SerieFM = noOk

End Function





Private Sub Text1_KeyPress(KeyAscii As Integer)

   KeyAscii = Asc(UCase(Chr(KeyAscii)))
 '  SwEmision = True

End Sub

Private Sub Text1_LostFocus()

   Text1.Text = ""
   Text1.Visible = False

'   If SwEmision Then
          If grilla.Enabled = True Then: grilla.SetFocus
 '  End If

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

    Select Case Button.Index
        Case 1  'Limpiar
            Call Limpiar
        Case 2
            Call subGraba_Garantias
        Case 3
            Unload Me
    End Select
   
End Sub
Private Sub Limpiar()
    Frame1.Enabled = True
    txtRut.Enabled = True
    txtDigito.Enabled = True
    TxtCodigo.Enabled = True
    txtRut.Text = ""
    TxtCodigo.Text = ""
    txtDigito.Text = ""
    txt_FecRevision.Text = gsBAC_Fecpx
    Cmb_TipoGarantia.ListIndex = -1
    txtFactorAditivo.Text = 0
    TxtTotal.Text = 0
    LBL_NombreCliente(4).Caption = ""
    txt_observaciones.Text = ""
    grilla.Clear
    Call subSettingGridVisible(Me.grilla)
    Call BloqueaBotones(True, "2")
    Paleta.TabVisible(0) = True
    Paleta.TabVisible(1) = False
    grilla.Enabled = False
End Sub


Private Sub txtFactorAditivo_KeyPress(KeyAscii As Integer)
    If KeyAscii = vbKeyReturn Then
        txt_observaciones.SetFocus
    End If
End Sub
Private Sub txtFactorAditivo_LostFocus()
    factorAditi = CDbl(txtFactorAditivo.Text)
    TxtTotal.Text = funcTotalGrilla() + factorAditi
End Sub

Private Sub TxtRut_DblClick()
Dim xx
On Error GoTo Error
    
    BacControlWindows 100
    'BacAyuda.Tag = "MDCL"
    'BacAyuda.Show 1
    'ARM se Implementa nuevo formulario ayuda
    BacAyudaCliente.Tag = "MDCL"
    BacAyudaCliente.Show 1
    If giAceptar = True Then
        txtRut.Text = Val(gsrut$)
        txtDigito.Text = gsDigito$
        txtCodigo.Text = gsValor$
        LBL_NombreCliente(4).Caption = gsNombre
        
        txtRut.Enabled = True
        txtDigito.Enabled = True
        TxtCodigo.Enabled = True
        txtDigito.SetFocus
        
        Call TxtCodigo_LostFocus
'        Call HabilitarControles(True)
'        SendKeys "{TAB}"
    End If

Error:
  If Err.Number <> 0 Then MsgBox Err.Description
  

End Sub


Private Sub txtRut_KeyPress(KeyAscii As Integer)
  If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      txtDigito.Enabled = True
      SendKeys$ "{TAB}"

   ElseIf Not ((KeyAscii > 47 And KeyAscii < 58) Or KeyAscii = 8) Then
        KeyAscii = 0
   End If

End Sub


Private Sub txtrut_LostFocus()
Dim Digito As String
If Len(txtRut.Text) <> 0 Then
   Digito = BacDevuelveDig(txtRut.Text)
   txtDigito.Enabled = True

End If
End Sub


Public Function BacDevuelveDig(rut As String) As String

   Dim I       As Integer
   Dim D       As Integer
   Dim Divi    As Long
   Dim Suma    As Long
   Dim Digito  As String
   Dim Multi   As Double

   BacDevuelveDig = ""

   rut = Format(rut, "000000000")
   D = 2
   Suma = 0
   For I = 9 To 1 Step -1
      Multi = Val(Mid$(rut, I, 1)) * D
     Suma = Suma + Multi
      D = D + 1
      
      If D = 8 Then
         D = 2
      
      End If
   Next I
    
   Divi = (Suma \ 11)
   Multi = Divi * 11
   Digito = Trim$(Str$(11 - (Suma - Multi)))
    
   If Digito = "10" Then
      Digito = "K"
   
   End If
    
   If Digito = "11" Then
      Digito = "0"
   
   End If
    
   BacDevuelveDig = UCase(Digito)

End Function
Private Sub TxtIngreso_GotFocus()
Dim Columna As Integer
    If grilla.Col = Col_Moneda Or grilla.Col = Col_MT_Gar Then
        Exit Sub
    End If

   Call PROC_POSI_TEXTO(grilla, TxtIngreso)
   Let Columna = grilla.Col
      
         
   If Columna = Col_MT Then
        Let TxtIngreso.SelStart = Len(TxtIngreso.Text) - (TxtIngreso.CantidadDecimales - 1)
   Else
        If Mid(grilla.TextMatrix(grilla.Row, COL_Serie), 1, 6) = "FMUTUO" Then
          If grilla.TextMatrix(grilla.Row, Col_Moneda) = "CLP" Then
              If Columna = Col_VPar Then
                 TxtIngreso.SelStart = Len(TxtIngreso.Text) - 5
              Else
                 TxtIngreso.SelStart = Len(TxtIngreso.Text)
              End If
          Else
              TxtIngreso.SelStart = Len(TxtIngreso.Text) - 5
          End If
        Else
            If bFlagDpx Then
              TxtIngreso.SelStart = Len(TxtIngreso.Text) - 3
            Else
              TxtIngreso.SelStart = Len(TxtIngreso.Text) - 5
            End If
          End If
   End If

End Sub

Private Sub TxtIngreso_KeyDown(KeyCode As Integer, Shift As Integer)
Dim cFormato         As Variant
    
    If KeyCode = vbKeyEscape Then
        TxtIngreso.Text = ""
        TxtIngreso.Visible = False
    End If
    
    If KeyCode = vbKeyReturn Then
        ANTES = grilla.TextMatrix(grilla.RowSel, grilla.ColSel)
        'grilla.TextMatrix(grilla.RowSel, grilla.ColSel) = CDec(TxtIngreso.Text)
        grilla.TextMatrix(grilla.RowSel, grilla.ColSel) = Format(TxtIngreso.Text, FDecimal)
        
        TxtIngreso.Visible = False
        
        Call TxtIngreso_LostFocus
        Call Text1_KeyDown(13, 1)
    End If
    
End Sub
   

Private Sub TxtIngreso_LostFocus()
On Error Resume Next
   
   TxtIngreso.Visible = False
       If grilla.Enabled = True Then: grilla.SetFocus
   
End Sub

Private Sub subGraba_Garantias()
Dim nContador       As Long
Dim sMensajeTX      As String
Dim nNumfolio       As Long

Dim ErrorLineaGtia As Boolean   'Para control de línea de emisor garantías PRD-5521
Dim MsgErrorLineaGtia As String 'Mensaje de error al tomar linea de emisor en Garantias
Dim MsgMotivoError As String    'Motivo del error

On Error GoTo ErrTransaction


    If Not funcValidacion() Then
    
        Exit Sub
    
    End If
    
    If MsgBox("¿Está seguro de registrar la garantía según los documentos ingresados?", vbQuestion + vbYesNo + vbDefaultButton2, TITSISTEMA) = vbNo Then
        Exit Sub
        End If
    
    Let Screen.MousePointer = vbHourglass
    
    On Error GoTo 0
    
    'Aquí llamar a sp para revisar si no hay errores al tomar líneas por emisor en Garantías
    MsgErrorLineaGtia = ""
    MsgMotivoError = ""
    ErrorLineaGtia = VerificaLineaGarantia(MsgErrorLineaGtia, MsgMotivoError, False)
    If ErrorLineaGtia = False Then
        MsgBox "No es posible tomar Líneas por Emisor para esta garantía debido a:" & vbCrLf & vbCrLf & MsgMotivoError & vbCrLf & MsgErrorLineaGtia, vbExclamation, TITSISTEMA
        Call Limpiar
        Exit Sub
    End If
    Call BacBeginTransaction
           
    On Error GoTo ErrTransaction
    
    If Not Bac_Sql_Execute("dbo.SP_GAR_NUMFOLIO_GARANTIAS_CONSTITUIDAS") Then
       Let Screen.MousePointer = vbDefault
       GoTo ErrTransaction
    End If
    
    If Bac_SQL_Fetch(Datos()) Then
        
        Let nNumfolio = Datos(1)
        
    End If
    
    
    Envia = Array()
    AddParam Envia, nNumfolio
    AddParam Envia, CDbl(txtFactorAditivo.Text)
    AddParam Envia, Me.txtRut.Text
    AddParam Envia, Me.TxtCodigo.Text
    AddParam Envia, Format(gsbac_fecp, "yyyymmdd")
    AddParam Envia, "I"
    AddParam Envia, Str(Me.TxtTotal.Text)
    AddParam Envia, "V"
    AddParam Envia, Me.txt_observaciones.Text
    AddParam Envia, gsBAC_User
    AddParam Envia, Format(Me.txt_FecRevision.Text, "yyyymmdd")
    AddParam Envia, Cmb_TipoGarantia.ItemData(Cmb_TipoGarantia.ListIndex)


    If Not Bac_Sql_Execute("bacparamsuda.dbo.SP_GAR_GRABA_ENCABEZADO_GARANTIAS_CONSTITUIDAS", Envia) Then
       Let Screen.MousePointer = vbDefault
       GoTo ErrTransaction
    End If
    
    If Bac_SQL_Fetch(Datos()) Then
        If Datos(1) <> 0 Then
            GoTo ErrTransaction
        End If
    End If
    
    
    For nContador = 1 To grilla.Rows - 1
    
            Envia = Array()
            
            AddParam Envia, nNumfolio
            AddParam Envia, grilla.TextMatrix(nContador, Col_FactorM)
            AddParam Envia, Str(nContador)
            AddParam Envia, grilla.TextMatrix(nContador, COL_Serie)
            AddParam Envia, grilla.TextMatrix(nContador, Col_Mascara)
            AddParam Envia, Str(grilla.TextMatrix(nContador, Col_Codigo))
            AddParam Envia, grilla.TextMatrix(nContador, Col_Seriad)
            AddParam Envia, grilla.TextMatrix(nContador, Col_FecEmi)
            AddParam Envia, grilla.TextMatrix(nContador, Col_FecVen)
            AddParam Envia, grilla.TextMatrix(nContador, Col_MonEmi)
            AddParam Envia, grilla.TextMatrix(nContador, Col_BasEmi)
            AddParam Envia, Str(grilla.TextMatrix(nContador, Col_RutEmi))
            AddParam Envia, Str(grilla.TextMatrix(nContador, Col_Nominal))
            AddParam Envia, Str(grilla.TextMatrix(nContador, Col_Tir))
            AddParam Envia, Str(grilla.TextMatrix(nContador, Col_VPar))
            AddParam Envia, Str(grilla.TextMatrix(nContador, Col_VPar))
            AddParam Envia, Str(grilla.TextMatrix(nContador, Col_MT))
            AddParam Envia, Str(grilla.TextMatrix(nContador, Col_Durata))
            AddParam Envia, Str(grilla.TextMatrix(nContador, Col_Convex))
            AddParam Envia, Str(grilla.TextMatrix(nContador, Col_DurMod))
    
            
            If Not Bac_Sql_Execute("bacparamsuda.dbo.SP_GAR_GRABA_DETALLE_GARANTIAS_CONSTITUIDAS", Envia) Then
               Let Screen.MousePointer = vbDefault
               GoTo ErrTransaction
            End If
            
            If Bac_SQL_Fetch(Datos()) Then
                If Datos(1) <> 0 Then
                    GoTo ErrTransaction
                End If
            End If
        
        
    Next nContador

    
    Call BacCommitTransaction
    
    'Tomar líneas por emisor
    ErrorLineaGtia = VerificaLineaGarantia(MsgErrorLineaGtia, MsgMotivoError, True)
    
    On Error GoTo 0
    
    Let Screen.MousePointer = vbDefault
    
    Call MsgBox("Se han registrado satisfactoriamente los instrumentos seleccionados como garantías constituídas con el número: " & nNumfolio, vbInformation, TITSISTEMA)
    Call Limpiar
    Exit Sub
    
ErrGral:
    Let Screen.MousePointer = vbDefault
    Call MsgBox("Se han presentado problemas en rutina de grabación: " & Err.Description, vbExclamation, TITSISTEMA)
    Exit Sub
ErrTransaction:
    Call BacRollBackTransaction
    Let Screen.MousePointer = vbDefault
    Call MsgBox("Se han presentado problemas en la grabación de la transacción:  " & vbCrLf & vbCrLf & sMensajeTX, vbExclamation, TITSISTEMA)
    Exit Sub
End Sub
Private Function VerificaLineaGarantia(ByRef MensajeSalida As String, ByRef MotivoMensaje As String, ByVal modo As Boolean) As Boolean
'modo = True ---> Tomar líneas (COMMIT)
'modo = False --> No tomar líneas, solo consultar (ROLLBACK)

'Si no hay error, MensajeSalida está vacío
On Error GoTo ErrVerifTransaction
MensajeSalida = ""
MotivoMensaje = ""
'Recorrer todos los papeles de la grilla "Grilla" consultando si está ok
Dim nomSp As String
Dim I As Long
nomSp = "BacLineas.dbo.SP_LINEAS_GRABAR_GARANTIAS"
Dim falla As Boolean
Dim Datos()
falla = False

Call BacBeginTransaction

For I = 1 To grilla.Rows - 1
    If Not (grilla.TextMatrix(I, Col_RutEmi) = 97023000 Or grilla.TextMatrix(I, Col_RutEmi) = 97029000) Then
        
        Envia = Array()
        
        AddParam Envia, gsbac_fecp                              'Fecha de Proceso
        AddParam Envia, Str(grilla.TextMatrix(I, Col_RutEmi))   'Rut del Emisor
        AddParam Envia, CDate(txt_FecRevision.Text)                   'Fecha de la operación
        AddParam Envia, Str(grilla.TextMatrix(I, Col_MT))       'Valor Presente del papel
        AddParam Envia, grilla.TextMatrix(I, Col_FecVen)        'Fecha venc. del papel
        AddParam Envia, Str(grilla.TextMatrix(I, Col_Codigo))   'Código del instrumento
        
        If Not Bac_Sql_Execute(nomSp, Envia) Then
           Let Screen.MousePointer = vbDefault
           GoTo ErrVerifTransaction
        End If
        
        If Bac_SQL_Fetch(Datos()) Then
            If Datos(1) <> "OK" Then
                falla = True
                VerificaLineaGarantia = False
                MotivoMensaje = IIf(IsNull(Datos(2)), "NULO", Datos(2))
                MensajeSalida = IIf(IsNull(Datos(3)), "NULO", Datos(3))
                GoTo ErrVerifTransaction
            End If
        End If
    End If

Next I
If Not falla Then
    VerificaLineaGarantia = True
    MensajeSalida = ""
    MotivoMensaje = ""
End If
If modo Then
    Call BacCommitTransaction
Else
    Call BacRollBackTransaction
End If
Screen.MousePointer = vbDefault
Exit Function
ErrVerifTransaction:
    Call BacRollBackTransaction
    Screen.MousePointer = vbDefault
End Function

Private Function funcValidacion() As Boolean
Dim sMensaje        As String
Dim iTotWRate       As Long
Dim iRow            As Long
Dim iVan            As Long
    Let funcValidacion = False
            
    Let sMensaje = ""
    
    iVan = 0
    
    If CDbl(Me.txtRut.Text) = 0 Then
        Let sMensaje = sMensaje & " - Falta Ingresar RUT de cliente. " & vbCrLf & vbCrLf
    End If
    
    If Len(Trim(Me.txtDigito.Text)) = 0 Then
        Let sMensaje = sMensaje & " - Falta Ingresar DV del RUT de cliente. " & vbCrLf & vbCrLf
    End If
     
    If CDbl(Me.TxtCodigo.Text) = 0 Then
        Let sMensaje = sMensaje & " - Falta Ingresar código de cliente. " & vbCrLf & vbCrLf
    End If
    
    If Format(Me.txt_FecRevision.Text, "yyyymmdd") <= Format(gsbac_fecp, "yyyymmdd") Then
        Let sMensaje = sMensaje & " - Fecha ingresada debe mayor a la fecha de proceso. " & vbCrLf & vbCrLf
    End If
    
    If Me.Cmb_TipoGarantia.ListIndex = -1 Then
        Let sMensaje = sMensaje & " - Se debe registrar el tipo de garantía " & vbCrLf & vbCrLf
    End If
    
    
    For iRow = 1 To grilla.Rows - 1
    
        If grilla.TextMatrix(iRow, COL_Serie) <> "" Then
        
            If grilla.TextMatrix(iRow, Col_Tir) = 0 Then
            
                Let sMensaje = sMensaje & " -  Serie : " & grilla.TextMatrix(iRow, COL_Serie) & " con tasa Cero " & vbCrLf & vbCrLf
                
            Else
            
                If grilla.TextMatrix(iRow, Col_MT) = 0 Then
                    Let sMensaje = sMensaje & " -  Serie : " & grilla.TextMatrix(iRow, COL_Serie) & " con valor presente en Cero " & vbCrLf & vbCrLf
                End If
                
            End If
            If Format(grilla.TextMatrix(iRow, Col_FecVen), "yyyymmdd") < Format(Me.txt_FecRevision.Text, "yyyymmdd") Then
                sMensaje = sMensaje & " -  Papel : " & grilla.TextMatrix(iRow, COL_Serie) & " Vence (" & Format(grilla.TextMatrix(iRow, Col_FecVen), "dd/mm/yyyy") & ")  antes de la garantia" & vbCrLf & vbCrLf
            End If
            
            If grilla.TextMatrix(iRow, Col_Nominal) = 0 Then
                sMensaje = sMensaje & " -  Serie : " & grilla.TextMatrix(iRow, COL_Serie) & " con valor nominal en Cero " & vbCrLf & vbCrLf
            End If
        Else
            iVan = iVan + 1
            
        End If
    
    Next iRow
    If iVan > 0 Then
        sMensaje = sMensaje & " -  Serie : Serie(s) en blanco"
    End If
    
    If Len(Trim(sMensaje)) > 0 Then
    
        Call MsgBox(sMensaje, vbExclamation, TITSISTEMA)
        Let funcValidacion = False
        Exit Function
    End If
    
    
    Let funcValidacion = True

End Function

Private Sub Func_Emision(ByVal Table1 As MSFlexGrid)

   Dim Sal As BacTypeChkSerie
   Dim Fila As Integer, colu As Integer
   Fila = Table1.Row
   colu = Table1.Col
   Tipo_Carga = "MN"
   Dim bufFecVen$
   
   If Table1.TextMatrix(Fila, COL_Serie) = "FMUTUO" Then
      Exit Sub
   End If

'   If Trim(Table1.TextMatrix(Fila, COL_Serie)) = "" Then
'      Exit Sub
'   End If

   With BacDatEmi
        .sInstSer = Table1.TextMatrix(Fila, COL_Serie)
        .lRutemi = Table1.TextMatrix(Fila, Col_RutEmi)
        .lCodemi = Table1.TextMatrix(Fila, Col_Codigo)
        .iMonemi = Table1.TextMatrix(Fila, Col_MonEmi)
        .sFecEmi = Table1.TextMatrix(Fila, Col_FecEmi)
        .sFecvct = Table1.TextMatrix(Fila, Col_FecVen)
        .dTasEmi = Table1.TextMatrix(Fila, Col_TasEmi)
        .iBasemi = Table1.TextMatrix(Fila, Col_BasEmi)
        .sRefNomi = Table1.TextMatrix(Fila, Col_RefNom)
        .sGeneri = Table1.TextMatrix(Fila, Col_GenEmi)
        
        .sLecemi = Table1.TextMatrix(Fila, Col_Seriad)
        
    End With
    
   Let bufFecVen = BacDatEmi.sFecvct

   If Tipo_Carga = "MN" Or (Tipo_Carga = "AU" And Mid(Trim(BacDatEmi.sInstSer), 1, 2) = "DP") Then
       'Let BacIrfEm.varPsSeriado = Data1.Recordset("tm_mdse")
       BacIrfEm.varPsSeriado = Table1.TextMatrix(Fila, Col_Seriad)
       Let BacIrfEm.Tag = "CP"
       If Mid(Table1.TextMatrix(Table1.Row, COL_Serie), 1, 6) = "FMUTUO" Or Mid(Text1.Text, 1, 6) = "FMUTUO" Then
                  
           Let BacIrfEm.Tag = "CP;FMUTUO"
           'Let BacDatEmi.lRutemi = 0
       End If
       Call BacIrfEm.Show(vbModal)
   End If

   If giAceptar% = True Then
    'Traspasar valores a la Grilla
    Table1.TextMatrix(Fila, Col_RutEmi) = BacDatEmi.lRutemi
    Table1.TextMatrix(Fila, Col_Codigo) = BacDatEmi.lCodemi
    Table1.TextMatrix(Fila, Col_GenEmi) = BacDatEmi.sGeneri
'      Call Data1.Recordset.Edit
'       Let Data1.Recordset("tm_instser") = BacDatEmi.sInstSer
'       Let Data1.Recordset("tm_rutemi") = BacDatEmi.lRutemi
'       Let Data1.Recordset("tm_codemi") = BacDatEmi.lCodemi
'       Let Data1.Recordset("tm_monemi") = BacDatEmi.iMonemi
'       Let Data1.Recordset("tm_nemmon") = BacDatEmi.sNemo
'       Let Data1.Recordset("tm_fecemi") = BacDatEmi.sFecEmi
'       Let Data1.Recordset("tm_fecven") = BacDatEmi.sFecvct
'       Let Data1.Recordset("tm_tasemi") = BacDatEmi.dTasEmi
'       Let Data1.Recordset("tm_basemi") = BacDatEmi.iBasemi
'       Let Data1.Recordset("tm_genemi") = BacDatEmi.sGeneri
      If bufFecVen <> BacDatEmi.sFecvct Then
          'Let Data1.Recordset("tm_valmcd") = "N"
      End If
      'Call Data1.Recordset.Update
   End If

   Call BacControlWindows(12)
   If Table1.Enabled = True Then
      Call Table1.SetFocus
   End If

End Sub
Private Function BloqueaBotones(ByVal bloqueo As Boolean, lista As String) As Boolean
Dim I As Integer, j As Integer, n As Integer
Dim salida()
Call llenalista(lista, salida)
If lista <> "" Then
    n = UBound(salida)
    If n > 0 Then
        For I = 1 To n
            j = salida(I)
            Toolbar1.Buttons(j).Enabled = Not bloqueo
        Next I
        Exit Function
    End If
End If
BloqueaBotones = True
End Function

