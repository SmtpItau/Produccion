VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacMntco 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantención de Cortes"
   ClientHeight    =   5160
   ClientLeft      =   1815
   ClientTop       =   1905
   ClientWidth     =   7755
   FillColor       =   &H00C0C0C0&
   FillStyle       =   0  'Solid
   ForeColor       =   &H00C0C0C0&
   Icon            =   "Bacmntco.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5160
   ScaleWidth      =   7755
   Begin Threed.SSPanel SSPanel1 
      Height          =   4530
      Left            =   15
      TabIndex        =   3
      Top             =   585
      Width           =   7695
      _Version        =   65536
      _ExtentX        =   13573
      _ExtentY        =   7990
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
      Begin BACControles.TXTNumero FltTotCor 
         Height          =   300
         Left            =   5280
         TabIndex        =   16
         Top             =   3510
         Width           =   2325
         _ExtentX        =   4101
         _ExtentY        =   529
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0,0000"
         Text            =   "0,0000"
         Max             =   "999999999999.9999"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
      End
      Begin Threed.SSFrame FrmFrame 
         Height          =   930
         Index           =   0
         Left            =   150
         TabIndex        =   4
         Top             =   60
         Width           =   7470
         _Version        =   65536
         _ExtentX        =   13176
         _ExtentY        =   1640
         _StockProps     =   14
         Caption         =   " Datos operación "
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
         Begin BACControles.TXTNumero IntNumOpe 
            Height          =   300
            Left            =   150
            TabIndex        =   0
            Top             =   510
            Width           =   1185
            _ExtentX        =   2090
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
         End
         Begin VB.TextBox txtCartera 
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
            Height          =   300
            Left            =   1440
            TabIndex        =   1
            Top             =   510
            Width           =   2445
         End
         Begin VB.TextBox TxtTipOpe 
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
            Height          =   300
            Left            =   4020
            TabIndex        =   2
            Top             =   510
            Width           =   2745
         End
         Begin VB.Label lblLabel 
            AutoSize        =   -1  'True
            Caption         =   "Cartera"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   195
            Index           =   1
            Left            =   1455
            TabIndex        =   7
            Top             =   270
            Width           =   630
         End
         Begin VB.Label lblLabel 
            AutoSize        =   -1  'True
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
            Height          =   195
            Index           =   2
            Left            =   4020
            TabIndex        =   6
            Top             =   270
            Width           =   1320
         End
         Begin VB.Label lblLabel 
            AutoSize        =   -1  'True
            Caption         =   "Nº Operación"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   195
            Index           =   0
            Left            =   150
            TabIndex        =   5
            Top             =   270
            Width           =   1155
         End
      End
      Begin Threed.SSCommand cmdGrabarCortes 
         Height          =   405
         Left            =   7155
         TabIndex        =   13
         Top             =   3945
         Width           =   390
         _Version        =   65536
         _ExtentX        =   688
         _ExtentY        =   714
         _StockProps     =   78
         ForeColor       =   0
         BevelWidth      =   1
         AutoSize        =   2
         Picture         =   "Bacmntco.frx":030A
      End
      Begin Threed.SSCommand cmdEliminarCortes 
         Height          =   405
         Left            =   6720
         TabIndex        =   12
         Top             =   3945
         Width           =   390
         _Version        =   65536
         _ExtentX        =   688
         _ExtentY        =   714
         _StockProps     =   78
         ForeColor       =   0
         BevelWidth      =   1
         AutoSize        =   2
         Picture         =   "Bacmntco.frx":08D8
      End
      Begin Threed.SSCommand cmdEliminarFila 
         Height          =   405
         Left            =   4680
         TabIndex        =   11
         Top             =   3945
         Width           =   390
         _Version        =   65536
         _ExtentX        =   688
         _ExtentY        =   714
         _StockProps     =   78
         ForeColor       =   0
         BevelWidth      =   1
         AutoSize        =   2
         Picture         =   "Bacmntco.frx":0EA6
      End
      Begin Threed.SSCommand cmdAgregarFila 
         Height          =   405
         Left            =   4245
         TabIndex        =   10
         Top             =   3945
         Width           =   390
         _Version        =   65536
         _ExtentX        =   688
         _ExtentY        =   714
         _StockProps     =   78
         ForeColor       =   0
         BevelWidth      =   1
         AutoSize        =   2
         Picture         =   "Bacmntco.frx":1474
      End
      Begin MSFlexGridLib.MSFlexGrid GrdOpe 
         Height          =   3300
         Left            =   150
         TabIndex        =   15
         Top             =   1050
         Width           =   4005
         _ExtentX        =   7064
         _ExtentY        =   5821
         _Version        =   393216
         FixedCols       =   0
         BackColor       =   12632256
         ForeColor       =   8388608
         BackColorFixed  =   8421376
         ForeColorFixed  =   16777215
         BackColorSel    =   8388608
         ForeColorSel    =   16777215
         GridLines       =   2
         SelectionMode   =   1
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
      Begin BACControles.TXTNumero txtIngresar 
         Height          =   270
         Left            =   6240
         TabIndex        =   18
         Top             =   1830
         Visible         =   0   'False
         Width           =   900
         _ExtentX        =   1588
         _ExtentY        =   476
         BackColor       =   8388608
         ForeColor       =   16777215
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
         BorderStyle     =   0
         Text            =   "0"
         Text            =   "0"
         Max             =   "999999999999.9999"
         SelStart        =   1
      End
      Begin MSFlexGridLib.MSFlexGrid GrdDet 
         Height          =   2415
         Left            =   4200
         TabIndex        =   17
         Top             =   1050
         Width           =   3435
         _ExtentX        =   6059
         _ExtentY        =   4260
         _Version        =   393216
         FixedCols       =   0
         BackColor       =   -2147483638
         ForeColor       =   8388608
         BackColorFixed  =   8421376
         ForeColorFixed  =   16777215
         FocusRect       =   0
         GridLines       =   2
      End
      Begin VB.Label lblLabel 
         AutoSize        =   -1  'True
         Caption         =   "Total Cortes"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   3
         Left            =   4215
         TabIndex        =   14
         Top             =   3540
         Width           =   1050
      End
   End
   Begin VB.PictureBox GrdDet1 
      BackColor       =   &H00FFFFFF&
      Height          =   45
      Left            =   4215
      ScaleHeight     =   45
      ScaleWidth      =   45
      TabIndex        =   9
      TabStop         =   0   'False
      Top             =   3240
      Width           =   45
   End
   Begin VB.PictureBox GrdOpe1 
      BackColor       =   &H00FFFFFF&
      Height          =   165
      Left            =   4140
      ScaleHeight     =   165
      ScaleWidth      =   30
      TabIndex        =   8
      TabStop         =   0   'False
      Top             =   3165
      Width           =   30
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   5895
      Top             =   -45
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   25
      ImageHeight     =   25
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   2
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntco.frx":1A42
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntco.frx":1D5C
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   555
      Left            =   0
      TabIndex        =   19
      Top             =   0
      Width           =   7755
      _ExtentX        =   13679
      _ExtentY        =   979
      ButtonWidth     =   847
      ButtonHeight    =   820
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdSalir"
            Description     =   "Salir"
            Object.ToolTipText     =   "Salir de la Ventana"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdLimpiar"
            Description     =   "Limpiar"
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   1
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
End
Attribute VB_Name = "BacMntco"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim NumDocu          As Currency
Dim RutCartera       As Long
Dim Correlativo      As Long
Dim TipoDocumento    As String
Dim MontoNominal     As Double
Dim GuardaTex        As String
Dim GrillaOk         As Boolean
Dim Fil As Integer
Dim Col As Integer
Dim inicio           As Integer
Dim SwGrilla         As Integer

Sub CrearGrillaOpe()
   
   Dim nCont As Integer
   
   SwGrilla = 0
   
   With GrdOpe
      .Clear
      .AllowBigSelection = False
      .ScrollBars = flexScrollBarVertical
      '.BackColor = &HC0C0C0               'Color de la grilla
      '.BackColorFixed = &H808000          'Fondo de los titulos
      .SelectionMode = flexSelectionByRow 'Selección por filas
      '.ForeColorFixed = &HFFFF00
      '.ForeColor = &HFF0000
      .Font.bold = False
      .Rows = 2
      .FixedRows = 1
      .FixedCols = 0
      .Cols = 6
      
      .RowHeight(0) = 505
      .ColWidth(0) = 600
      .ColWidth(1) = 1300
      .ColWidth(2) = 2000
      
      For nCont = 0 To .Cols - 1
         .FixedAlignment(nCont) = 4
      
      Next nCont
      
      .Font.bold = True
      .TextMatrix(0, 0) = "Corr."
      .TextMatrix(0, 1) = "Serie"
      .TextMatrix(0, 2) = "Nominal"
      .Font.bold = False
      
      For nCont = 3 To 5
         .ColWidth(nCont) = 0
      
      Next nCont
      
      '.Enabled = False
      .Col = 0
   
   End With

End Sub

Sub CrearGrillaDet()
   Dim nCont As Integer
   With GrdDet
      .Clear
      .AllowBigSelection = False
      .ScrollBars = flexScrollBarVertical
      '.BackColor = &HC0C0C0               'Color de la grilla
      '.BackColorFixed = &H808000          'Fondo de los titulos
      '.SelectionMode = flexSelectionByRow 'Selección por filas
      '.ForeColorFixed = &H80000009
      '.ForeColor = &HFF0000
      .Font.bold = False
      
      .Rows = 2
      .FixedRows = 1
      .FixedCols = 0
      .Cols = 3
      .ColWidth(2) = 0
      
      .RowHeight(0) = 505
      .ColWidth(0) = 1100
      .ColWidth(1) = 2230
      For nCont = 0 To .Cols - 1
         .FixedAlignment(nCont) = 4
      Next nCont
      .Font.bold = True
      .TextMatrix(0, 0) = "NºCort."
      .TextMatrix(0, 1) = "Monto Corte"
      '.Enabled = False
      .Font.bold = False
      .Col = 0
   End With

End Sub

Private Sub BuscaOperacion()

Dim Datos()
Dim IdFlag          As Integer
Dim Fila            As Long
Dim ObjCartera      As Object

    NumDocu = Val(IntNumOpe.Text)
    RutCartera = 0
    TipoDocumento = ""

    Call Limpiar

    Envia = Array(CDbl(RutCartera), CDbl(NumDocu))
   
    If Not Bac_Sql_Execute("SP_COLEERDOCUME", Envia) Then
        MsgBox "No se puede conectar a tabla de disponibilidad", vbCritical, gsBac_Version
        Exit Sub
    End If
   
    IdFlag = False
   
    With GrdOpe
      .Rows = 2
        .Row = 1
        Do While Bac_SQL_Fetch(Datos())
            If IdFlag = False Then
                RutCartera = Val(Datos(1))
                TipoDocumento = UCase$(Trim$(Datos(6)))
                IdFlag = True
            End If
            .TextMatrix(.Row, 0) = Val(Datos(3))
            .TextMatrix(.Row, 1) = Datos(4)
            .TextMatrix(.Row, 2) = Format(CDbl(Datos(5)), "###,###,##0.0000")
            .TextMatrix(.Row, 3) = Datos(7)
            .TextMatrix(.Row, 4) = Datos(8)
            .RowHeight(.Rows - 1) = 315
            .Rows = .Rows + 1
            .Row = .Row + 1
            
        Loop
        .Rows = .Rows - 1
        .SelectionMode = flexSelectionByRow
        .FocusRect = flexFocusNone
        .Enabled = True
        On Error Resume Next
        .SetFocus
    End With
   
    TxtTipope.Text = ""
   
    Set ObjCartera = New clsDCartera
   
    If IdFlag = True Then
        Select Case UCase$(Trim$(Datos(6)))
            Case "CP"
                TxtTipope.Text = "COMPRA PROPIA"
            Case "CI"
                TxtTipope.Text = "COMPRA CON PACTO"
        End Select
              
        If ObjCartera.LeerPorRut(Val(Datos(1))) = True Then
            TxtCartera.Text = ObjCartera.rcnombre
        End If
    Else
        MsgBox "No existen operaciones para este operación", vbExclamation, gsBac_Version
        IntNumOpe.Text = ""
        IntNumOpe.SetFocus
        Set ObjCartera = Nothing
        Exit Sub
    End If
    
    Set ObjCartera = Nothing
      
    IntNumOpe.Text = NumDocu
                 
    'cmdAgregarFila.Enabled = True
    'cmdEliminarFila.Enabled = True
    'cmdEliminarCortes.Enabled = True
    'cmdGrabarCortes.Enabled = True

End Sub

Private Sub Limpiar()
   
   GrdDet.Cols = 3
   
   IntNumOpe.Text = ""
   FltTotCor.Text = ""
      
   TxtCartera.Text = ""
   TxtTipope = ""
   
   GrdDet.Cols = 3
   GrdDet.Rows = 1
  ' GrdOpe.ColSel = 1
   'GrdOpe.Col = 3
   'GrdDet.Col = 2
   GrdOpe.Rows = 1
   'GrdDet.Rows = 1
   FltTotCor.Text = 0
   
   RutCartera = 0
   Correlativo = 0
   TipoDocumento = ""
   MontoNominal = 0
      
   cmdAgregarFila.Enabled = False
   cmdEliminarFila.Enabled = False
   cmdEliminarCortes.Enabled = False
   cmdGrabarCortes.Enabled = False
   GrdOpe.Enabled = False
   GrdDet.Enabled = False
   IntNumOpe.Enabled = True
   
   IntNumOpe.SelStart = 0
   IntNumOpe.SelLength = Len(IntNumOpe.Text)
   'GrdOpe.ColSel = 0
   'GrdOpe.Col = 3
   'GrdDet.Rows = 1
   
End Sub

Private Sub MuestraDetCortes()
Dim Datos()
Dim lsMask    As String
Dim x As Integer

    GrillaOk = False
    GrdOpe.Col = 0
    Correlativo = Val(GrdOpe.Text)
   
    GrdOpe.Col = 2
    If CDbl(GrdOpe.Text) = 0 Then
        MontoNominal = 0
    Else
        MontoNominal = GrdOpe.TextMatrix(GrdOpe.Row, 2)
    End If
   
'   Sql = "SP_COLEERCORTES " & Chr(10)
'   Sql = Sql & RutCartera & "," & Chr(10)
'   Sql = Sql & NumDocu & "," & Chr(10)
'   Sql = Sql & Correlativo

    Envia = Array(CDbl(RutCartera), _
            CDbl(NumDocu), _
            CDbl(Correlativo))
   
    If Not Bac_Sql_Execute("SP_COLEERCORTES", Envia) Then
        MsgBox "No se puede conectar a tabla de detalle de cortes", vbCritical, gsBac_Version
        Exit Sub
    End If
       
    GrdDet.Rows = 2
    GrdDet.Cols = 2
    
    Do While Bac_SQL_Fetch(Datos())
        If IsNumeric(Datos(2)) Then
            GrdDet.Col = 0: GrdDet.Text = CDbl(Datos(6))
            GrdDet.Col = 1: GrdDet.Text = Format(CDbl(Datos(4)), "###,###,##0.0000")
            GrdDet.Rows = GrdDet.Rows + 1
            GrdDet.Row = GrdDet.Row + 1
        End If
    Loop
   
    GrdDet.Rows = GrdDet.Rows - 1
   
    For x = 0 To GrdDet.Rows - 1
        GrdDet.RowHeight(x) = 315
    Next x
    
    GrdDet.RowHeight(0) = 505
   
'   Call LlenaGrdDet
   
    Call SumaCorte
    
    If GrdDet.Rows < 2 Then
   
         GrdDet.Cols = 3
         GrdDet.Col = 2
   
    End If
    
    GrillaOk = True
   
    
    
End Sub


Private Sub SumaCorte()
Dim Fila      As Long
Dim IdNumero  As Double
Dim Monto     As Double
Dim multi     As Double
Dim TotCorte  As Double
Dim nRow      As Integer

BacControlWindows 100
If GrdDet.Rows > 1 Then

    TotCorte = 0
    
    For Fila = 1 To GrdDet.Rows - 1
        IdNumero = CDbl(IIf(GrdDet.TextMatrix(Fila, 0) = "", "0", GrdDet.TextMatrix(Fila, 0)))
        'GrdDet.Col = 1:
        
        Monto = IIf(GrdDet.TextMatrix(Fila, 1) = "", 0, GrdDet.TextMatrix(Fila, 1))
        multi = (Monto * IdNumero)
        TotCorte = TotCorte + multi
    
    Next Fila

    FltTotCor.Text = TotCorte
    
End If

BacControlWindows 100
If GrdDet.Enabled Then GrdDet.SetFocus
End Sub


Private Function ValidaMontos() As Boolean
   Dim Fila     As Long
   Dim Fila1    As Long
   Dim Monto1   As Double
   Dim Monto2   As Double
   
   ValidaMontos = False
   BacControlWindows 100
   
   For Fila = 1 To GrdDet.Rows - 1
      
      If GrdDet.TextMatrix(Fila, 0) > "" Then
         
         Monto1 = CDbl(GrdDet.TextMatrix(Fila, 1)) '-------------------------
         
         For Fila1 = Fila + 1 To GrdDet.Rows - 1
         'For Fila1 = GrdDet.Row To GrdDet.Rows - 1
            
            If GrdDet.TextMatrix(Fila1, 0) > "" Then
               
               Monto2 = CDbl(GrdDet.TextMatrix(Fila1, 1))
               
               If Monto1 = Monto2 Then
                  
                  Exit Function
               
               End If
            
            End If
          
          Next Fila1
      
      End If
   
   Next Fila
    
   BacControlWindows 100
   ValidaMontos = True
If GrdDet.Enabled Then GrdDet.SetFocus
   
End Function

Private Function ValidaRow() As Integer
On Error GoTo ErrorF:

Dim Fila As Long

    ValidaRow = False
    
     For Fila = 1 To GrdDet.Rows - 1
        'GrdDet.Row = Fila
        'GrdDet.Col = 0
        If Val(GrdDet.TextMatrix(Fila, 0)) = 0 Then
           Exit Function
        End If
        'GrdDet.Col = 1
        If GrdDet.TextMatrix(Fila, 1) = 0 Then
           Exit Function
        End If
    Next Fila
   
    GrdDet.Row = 0
         
    
    ValidaRow = True
    
   Exit Function
    
ErrorF:
    
    GrdDet.Row = 0
    GrdDet.Cols = 3
    GrdDet.Col = 2
    GrdDet.ColWidth(2) = 0
    GrdDet.Col = 2
    
End Function

Private Sub cmdAgregarFila_Click()
    
    'Agrega una nueva Fila a la grilla del detalle de corte
    '-------------------------------------------------------
    
    If GrdDet.Rows < 1 Then
    
      Exit Sub
    
    End If
    If GrdDet.Rows = 1 Then
        GrdDet.Rows = GrdDet.Rows + 1
        GrdDet.TextMatrix(1, 0) = 0
        GrdDet.TextMatrix(1, 1) = 0
        GrdDet.SetFocus
        Exit Sub
    End If
    
    If ValidaRow() = False Then
        MsgBox "Datos incorrectos en la grilla", vbExclamation, gsBac_Version
        GrdDet.Row = GrdDet.Rows - 1
        GrdDet.Col = 0
        
        If GrdDet.Rows = 1 Then
         
               GrdDet.Row = 0
               GrdDet.Cols = 3
               GrdDet.Col = 2
               GrdDet.ColWidth(2) = 0
               GrdDet.Col = 2
        
        End If
        
        GrdDet.Enabled = True
        GrdDet.SetFocus
        Exit Sub
    End If
    
    If CDbl(FltTotCor.Text) >= CDbl(BacStrTran(GrdOpe.TextMatrix(GrdOpe.Row, 2), ",", "")) Then
        MsgBox "Suma de definiciòn de cortes, corresponde a nominal original", vbExclamation, gsBac_Version
        Exit Sub
    Else
        
        GrdDet.Rows = GrdDet.Rows + 1
        GrdDet.RowHeight(GrdDet.Rows - 1) = 315
        GrdDet.Col = 0: GrdDet.Row = GrdDet.Rows - 1
        GrdDet.TextMatrix(GrdDet.Row, 1) = 0
    End If
End Sub

Private Sub cmdEliminarCortes_Click()

  GrdDet.Clear
  If GrdDet.Row <> 0 Then
     Call MuestraDetCortes
  End If
  IntNumOpe.Enabled = True:    GrdOpe.Enabled = True
End Sub

Private Sub cmdEliminarFila_Click()
   Dim x As Integer
   
   If GrdDet.Rows < 2 Then
   
      Exit Sub
   
   End If
   
   If GrdDet.RowSel = 0 Then
      MsgBox "Error...Elemento no seleccionado", vbExclamation, gsBac_Version
      Exit Sub
   End If
   If GrdDet.Rows > 2 Then
      x = GrdDet.RowSel
      GrdDet.RemoveItem GrdDet.RowSel
      GrdDet.Row = x - 1
      GrdDet.SetFocus
   Else
      GrdDet.Rows = 1
      GrdDet.Cols = 3
      GrdDet.Col = 2
      GrdDet.ColWidth(2) = 0
      Exit Sub
   End If
  
   Call SumaCorte
      GrdDet.Col = 0

End Sub

Private Sub cmdGrabarCortes_Click()
Dim Fila        As Long

    Call SumaCorte
    
    
  If GrdDet.Rows > 1 Then
    
    If ValidaRow() = False Then
        MsgBox "Existen Valores Incorrectos en la última Fila", vbExclamation, gsBac_Version
        Exit Sub
    End If
    
    If ValidaMontos() = False Then
        MsgBox "Montos del detalle de corte se repiten", vbExclamation, gsBac_Version
        Exit Sub
    End If
       
       
    If CDbl(GrdOpe.TextMatrix(GrdOpe.Row, 2)) <> CDbl(FltTotCor.Text) Then
        MsgBox "Monto de corte no coincide con monto del detalle", vbExclamation, gsBac_Version
        Exit Sub
    End If
    
    If miSQL.SQL_Execute("BEGIN TRANSACTION") <> 0 Then
        MsgBox "No se puede grabar detalle de corte" & Chr(10) & "Error en BEGIN TRANS.", vbCritical, gsBac_Version
        IntNumOpe.Enabled = True:    GrdOpe.Enabled = True
        Exit Sub
    End If
    
    'Eliminamos el detalle

'    Sql = "SP_COELIMCORTES " & Chr(10)
'    Sql = Sql & RutCartera & "," & Chr(10)
'    Sql = Sql & NumDocu & "," & Chr(10)
'    Sql = Sql & Correlativo

    Envia = Array(CDbl(RutCartera), _
            CDbl(NumDocu), _
            CDbl(Correlativo))
    
    If Not Bac_Sql_Execute("SP_COELIMCORTES", Envia) Then
    
        If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
            MsgBox "No se Puede Eliminar registros de detalle de Cortes" & Chr(10) & "Error en ROLLBACK TRANS.", vbCritical, gsBac_Version
            IntNumOpe.Enabled = True:    GrdOpe.Enabled = True
            Exit Sub
        End If
        
        MsgBox "No se Puede Eliminar registros de detalle de Cortes", vbCritical, gsBac_Version
        IntNumOpe.Enabled = True:    GrdOpe.Enabled = True
        Exit Sub
        
    End If
    
    'Grabamos el detalle

    For Fila = 1 To GrdDet.Rows - 1
         GrdDet.Row = Fila
'         Sql = "SP_COGRABCORTES " & Chr(10)
'         Sql = Sql & RutCartera & "," & Chr(10)
'         Sql = Sql & NumDocu & "," & Chr(10)
'         Sql = Sql & Correlativo & "," & Chr(10)

         GrdDet.Col = 0
'         Sql = Sql & BacStrTran(CStr(GrdDet.Text), ",", ".") & "," & Chr(10)
         GrdDet.Col = 1
'         Sql = Sql & BacStrTran(CStr(CDbl(GrdDet.Text)), ",", ".")

        Envia = Array(CDbl(RutCartera), _
            CDbl(NumDocu), _
            CDbl(Correlativo), _
            CDbl(GrdDet.TextMatrix(GrdDet.Row, 0)), _
            CDbl(GrdDet.TextMatrix(GrdDet.Row, 1)))
            
         If Not Bac_Sql_Execute("SP_COGRABCORTES", Envia) Then
         
            If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
                MsgBox "No se Puede grabar registros de detalle de Cortes" & Chr(10) & "Error en ROLLBACK TRANS.", vbCritical, gsBac_Version
                IntNumOpe.Enabled = True:    GrdOpe.Enabled = True
                Exit Sub
            End If
            
            MsgBox "No se Puede grabar registros de detalle de Cortes"
            IntNumOpe.Enabled = True:    GrdOpe.Enabled = True
            Exit Sub
            
         End If
         
    Next Fila
    
    If Not Bac_Sql_Execute("COMMIT TRANSACTION") Then
        MsgBox "No se Puede grabar registros de detalle de Cortes" & Chr(10) & "Error en COMMIT TRANS.", vbCritical, gsBac_Version
        IntNumOpe.Enabled = True: GrdOpe.Enabled = True
        Exit Sub
    End If

    MsgBox "Información grabada correctamente", vbInformation, gsBac_Version
    'IntNumOpe.Enabled = True:
    GrdOpe.Enabled = True
    
  End If
    
End Sub



Private Sub Form_Activate()
'IntNumOpe.SetFocus
End Sub

Private Sub Form_Load()

   SwGrilla = 0
   Me.Top = 0
   Me.Left = 0
   cmdAgregarFila.Enabled = False
   cmdEliminarFila.Enabled = False
   cmdEliminarCortes.Enabled = False
   cmdGrabarCortes.Enabled = False
   
   Call CrearGrillaOpe
   Call CrearGrillaDet
   Call Limpiar
   
End Sub


Private Sub GrdDatCor_Fetch(Row As Long, Col As Integer, Value As String)
       
    Select Case Col
           Case 1
                GrdDet.Row = Row
                GrdDet.Col = Col
                GrdDet.Text = GrdDet.Text
           Case 2
                GrdDet.Row = Row
                GrdDet.Col = Col
                GrdDet.Text = GrdDet.Text
    End Select
       
End Sub


Private Sub GrdDet_KeyDown(KeyCode As Integer, Shift As Integer)
BacControlWindows 100
Select Case KeyCode
   Case vbKeyInsert
      cmdAgregarFila_Click
   Case vbKeyDelete
      cmdEliminarFila_Click
End Select
BacControlWindows 100
End Sub

Private Sub GrdDet_KeyPress(KeyAscii As Integer)
   
   If GrdDet.Row = 0 Then Exit Sub
   
   If GrdDet.Col = 0 Then
    txtIngresar.CantidadDecimales = 0
   Else
    txtIngresar.CantidadDecimales = 4
   End If
   
   PROC_POSI_TEXTO GrdDet, txtIngresar
   GrdDet.Row = GrdDet.RowSel
   GrdDet.Col = GrdDet.ColSel


   If KeyAscii >= 48 And KeyAscii <= 57 Then
      txtIngresar.Text = Chr(KeyAscii)
   Else
      txtIngresar.Text = BacCtrlTransMonto(GrdDet.TextMatrix(GrdDet.Row, GrdDet.Col))
   End If
   txtIngresar.SelStart = Len(txtIngresar.Text)
   txtIngresar.Visible = True
   txtIngresar.SetFocus

End Sub






Private Sub GrdOpe_EnterCell()
Dim Datos()
Dim lsMask    As String
Dim x As Integer
'BacControlWindows 100
'
'
'      With GrdOpe
'
'
'      If .Rows > 2 Then
'
'         If .Row <> 0 And SwGrilla = 1 Then
'
'            FltTotCor.Text = ""
'
'            If CDbl(Val(.TextMatrix(.Row, 2))) = 0 Then
'               cmdAgregarFila.Enabled = False
'               cmdEliminarCortes.Enabled = False
'               cmdEliminarFila.Enabled = False
'               cmdGrabarCortes.Enabled = False
'
'            Else
'               cmdAgregarFila.Enabled = True
'               cmdEliminarCortes.Enabled = True
'               cmdEliminarFila.Enabled = True
'               cmdGrabarCortes.Enabled = True
'
'            End If
'
'                   GrillaOk = False
'                   Correlativo = Val(GrdOpe.TextMatrix(.Row, 0))
'
'                   If Val(GrdOpe.TextMatrix(.Row, 2)) = 0 Then
'
'                       MontoNominal = 0
'
'                   Else
'
'                       MontoNominal = GrdOpe.TextMatrix(.Row, 2)
'
'                   End If
'
'                   Envia = Array(CDbl(RutCartera), _
'                           CDbl(NumDocu), _
'                           CDbl(Correlativo))
'
'                   If Not Bac_Sql_Execute("SP_COLEERCORTES", Envia) Then
'
'                       MsgBox "No se puede conectar a tabla de detalle de cortes", vbCritical, gsBac_Version
'                       Exit Sub
'
'                   End If
'
'                   GrdDet.Rows = 2
'                   GrdDet.Cols = 3
'
'                   Do While Bac_SQL_Fetch(datos())
'
'                       If IsNumeric(datos(2)) Then
'
'                           GrdDet.TextMatrix(GrdDet.Row, 0) = Val(datos(6))
'                           GrdDet.TextMatrix(GrdDet.Row, 1) = Format(datos(4), FDecimal)
'                           GrdDet.Rows = GrdDet.Rows + 1
'                           GrdDet.Row = GrdDet.Row + 1
'
'                       End If
'
'                   Loop
'
'                   GrdDet.Rows = GrdDet.Rows - 1
'
'                   For x = 0 To GrdDet.Rows - 1
'                       GrdDet.RowHeight(x) = 315
'                   Next x
'
'                   GrdDet.RowHeight(0) = 505
'
'               '   Call LlenaGrdDet
'
'                   Call SumaCorte
'
'                   If GrdDet.Rows < 2 Then
'
'                        GrdDet.Cols = 3
'                        GrdDet.Col = 2
'
'                   End If
'
'                   GrillaOk = True
'
'            GrdOpe.Col = 0
'            GrdOpe.ColSel = GrdOpe.Cols - 1
'
'         End If
'
'      End If
'
'      End With
'BacControlWindows 100
End Sub

Private Sub GrdOpe_KeyDown(KeyCode As Integer, Shift As Integer)

'   If KeyCode = 13 Or KeyCode = 40 Or KeyCode = 37 Then
'
'      With GrdOpe
'
'         If .Row <> 0 Then
'
'            FltTotCor.Text = ""
'
'            If CDbl(Val(.TextMatrix(.Row, 2))) = 0 Then
'               cmdAgregarFila.Enabled = False
'               cmdEliminarCortes.Enabled = False
'               cmdEliminarFila.Enabled = False
'               cmdGrabarCortes.Enabled = False
'
'            Else
'               cmdAgregarFila.Enabled = True
'               cmdEliminarCortes.Enabled = True
'               cmdEliminarFila.Enabled = True
'               cmdGrabarCortes.Enabled = True
'
'            End If
'
'            Call MuestraDetCortes
'            GrdOpe.Col = 0
'            GrdOpe.ColSel = GrdOpe.Cols - 1
'
'         End If
'
'      End With
'
'   End If
'
End Sub



Private Sub IntNumOpe_DblClick()

    
    SwGrilla = 0
    Me.Tag = ""
    BacAyuda.Tag = "NUMOPE"
    BacAyuda.Show 1
    
    If giAceptar = True Then
      
      IntNumOpe.Text = Me.Tag
      Call BuscaOperacion
    
      If IntNumOpe.Text <> 0 Then
      
         IntNumOpe.Enabled = False
         IntNumOpe.TabStop = IntNumOpe.Enabled
         SwGrilla = 1
      
      End If
    
    End If

End Sub

Private Sub IntNumOpe_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = 13 Then
      
      If Val(IntNumOpe.Text) > 0 Then
        
        Call BuscaOperacion
      
         If IntNumOpe.Text <> 0 Then
         
            IntNumOpe.Enabled = False
            IntNumOpe.TabStop = IntNumOpe.Enabled
         End If
      
      End If
   
   End If
End Sub

Private Sub IntNumOpe_LostFocus()

    If Val(IntNumOpe.Text) > 0 Then
        
        Call BuscaOperacion
    
         If IntNumOpe.Text <> 0 Then
      
            IntNumOpe.Enabled = False
            IntNumOpe.TabStop = IntNumOpe.Enabled
         End If
    
    
    End If

End Sub



Private Sub GrdDatOpe_Click()
'
'   If GrdDatOpe.RowIndex <> 0 Then
'   If GrdDatOpe.Row <> 0 Then
'       GrdDet.Rows = 1
'       GrdDatCor.Rows = 0
'   End If
'
End Sub

Private Sub GrdOpe_Click()
   
   SwGrilla = 0
      
   With GrdOpe

         If .Row <> 0 Then

            FltTotCor.Text = ""

            If CDbl(.TextMatrix(.Row, 2)) = 0 Then

                cmdAgregarFila.Enabled = False
                cmdEliminarCortes.Enabled = False
                cmdEliminarFila.Enabled = False
                cmdGrabarCortes.Enabled = False

            Else

                cmdAgregarFila.Enabled = True
                cmdEliminarCortes.Enabled = True
                cmdEliminarFila.Enabled = True
                cmdGrabarCortes.Enabled = True

            End If
            BacControlWindows 100
            GrdDet.Clear
            Call MuestraDetCortes
            BacControlWindows 100
            GrdOpe.Col = 0
            GrdOpe.ColSel = GrdOpe.Cols - 1

         End If

   End With
   
   SwGrilla = 1

   GrdDet.Enabled = True
   GrdDet.SetFocus

End Sub

Private Sub SSCommand1_Click()

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Key
   Case Is = "cmdLimpiar"
      Call Limpiar
      'Call CrearGrillaOpe
      'Call CrearGrillaDet
      FltTotCor.SetFocus
      IntNumOpe.Enabled = True
      IntNumOpe.SetFocus
   Case Is = "cmdSalir"
      Unload Me
End Select
End Sub

Private Sub txtIngresar_GotFocus()
IntNumOpe.Enabled = False
IntNumOpe.TabStop = IntNumOpe.Enabled
GrdOpe.Enabled = False
If txtIngresar.CantidadDecimales = 0 Then
    txtIngresar.SelStart = Len(txtIngresar.Text)
Else

    txtIngresar.SelStart = Len(txtIngresar.Text) - 5
    
End If
End Sub

Private Sub txtIngresar_KeyDown(KeyCode As Integer, Shift As Integer)
Select Case KeyCode
      Case Is = 27
         GrdDet.TextMatrix(Fil, Col) = GrdDet.TextMatrix(Fil, Col)
         txtIngresar.Visible = False
         GrdDet.SetFocus
      
      Case Is = 13
         BacControlWindows 100
         If GrdDet.Col = 0 Then
            GrdDet.TextMatrix(GrdDet.Row, GrdDet.Col) = txtIngresar.Text
         Else                                                     '99999999.9999
            GrdDet.TextMatrix(GrdDet.Row, GrdDet.Col) = txtIngresar.Text
         End If
       
            Call SumaCorte
       
            Call ValidaMontos
       
            txtIngresar.Visible = False
            GrdDet.SetFocus
            
      Case Else
      
   End Select

End Sub

Private Sub TxtTipOpe_GotFocus()
IntNumOpe.Enabled = False
IntNumOpe.TabStop = IntNumOpe.Enabled
GrdOpe.Enabled = False
End Sub
