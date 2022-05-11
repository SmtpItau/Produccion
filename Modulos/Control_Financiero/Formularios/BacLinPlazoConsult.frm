VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacLinPlazoConsult 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Consulta Linea por Plazo"
   ClientHeight    =   4815
   ClientLeft      =   2970
   ClientTop       =   3210
   ClientWidth     =   7875
   Icon            =   "BacLinPlazoConsult.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4815
   ScaleWidth      =   7875
   Begin Threed.SSPanel SSPanel1 
      Height          =   4320
      Left            =   0
      TabIndex        =   0
      Top             =   480
      Width           =   7875
      _Version        =   65536
      _ExtentX        =   13891
      _ExtentY        =   7620
      _StockProps     =   15
      BackColor       =   -2147483644
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin VB.Frame marco1 
         BorderStyle     =   0  'None
         Height          =   3465
         Left            =   90
         TabIndex        =   1
         Top             =   45
         Width           =   7650
         Begin VB.ComboBox CmbCombo 
            BackColor       =   &H8000000D&
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000E&
            Height          =   315
            Left            =   90
            Style           =   2  'Dropdown List
            TabIndex        =   8
            Top             =   3015
            Visible         =   0   'False
            Width           =   1605
         End
         Begin BACControles.TXTNumero Texto 
            Height          =   345
            Left            =   1740
            TabIndex        =   7
            Top             =   2340
            Width           =   1905
            _ExtentX        =   3360
            _ExtentY        =   609
            BackColor       =   -2147483635
            ForeColor       =   -2147483634
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
            SelStart        =   1
         End
         Begin MSFlexGridLib.MSFlexGrid Grid 
            Height          =   3405
            Left            =   0
            TabIndex        =   2
            Top             =   45
            Width           =   7680
            _ExtentX        =   13547
            _ExtentY        =   6006
            _Version        =   393216
            Rows            =   5
            FixedCols       =   0
            BackColor       =   -2147483644
            ForeColor       =   8388608
            BackColorFixed  =   8421376
            ForeColorFixed  =   16777215
            BackColorSel    =   8388608
            ForeColorSel    =   16777215
            BackColorBkg    =   -2147483636
            GridColor       =   8421504
            GridColorFixed  =   14737632
            AllowBigSelection=   0   'False
            FocusRect       =   0
            GridLines       =   2
            GridLinesFixed  =   1
         End
      End
      Begin VB.Label LabTotMon 
         Alignment       =   1  'Right Justify
         BorderStyle     =   1  'Fixed Single
         Caption         =   "0"
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
         Height          =   345
         Left            =   4755
         TabIndex        =   6
         Top             =   3810
         Width           =   2490
      End
      Begin VB.Label LabTotLin 
         Alignment       =   1  'Right Justify
         BorderStyle     =   1  'Fixed Single
         Caption         =   "0"
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
         Height          =   345
         Left            =   270
         TabIndex        =   5
         Top             =   3810
         Width           =   2490
      End
      Begin VB.Label Label2 
         Alignment       =   2  'Center
         AutoSize        =   -1  'True
         Caption         =   "Total Monto"
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
         Height          =   240
         Left            =   5355
         TabIndex        =   4
         Top             =   3540
         Width           =   1275
      End
      Begin VB.Label Label1 
         Alignment       =   2  'Center
         AutoSize        =   -1  'True
         Caption         =   "Total Linea"
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
         Height          =   240
         Left            =   900
         TabIndex        =   3
         Top             =   3525
         Width           =   1215
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   9
      Top             =   0
      Width           =   7875
      _ExtentX        =   13891
      _ExtentY        =   847
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   9360
      Top             =   3390
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   24
      ImageHeight     =   24
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   3
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacLinPlazoConsult.frx":000C
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacLinPlazoConsult.frx":0EE6
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacLinPlazoConsult.frx":1DC0
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "BacLinPlazoConsult"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim RutCli, CodCli, IdSist, TotAsi, TotOcu, TotDis, TotExe, TotTra, TotRec

Dim ValNue     As String
Dim ValAnt     As String
Dim ValorRow
Dim ValorCol
Dim Titulo1
Dim Titulo2
Dim Anchos
Dim Titulo3


Private Sub Form_Activate()
  Me.Icon = Acceso_Usuario.Icon
End Sub

Private Sub Form_Load()
    Call CargarGrilla
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Call BacLinCreGen3Consult.Sumatorias
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
    Dim Tmp As Integer
    Dim I%
    Dim x%
    Dim SW%

    Texto.Visible = False

    If ValidaRepetidos(Grid) = True Then
               MsgBox "Error, existen valores repetidos Producto - Instrumento - Plazo", vbCritical, TITSISTEMA
               Exit Sub
    End If
    
    
    Select Case Button.Index
    Case 1

        For I% = 1 To Grid.Rows - 1
            If Format(Grid.TextMatrix(Grid.Row, 4), FDecimal) < 0 Then
               MsgBox "Error", vbCritical, TITSISTEMA
               Exit Sub
            End If
        Next I%

      If cOptraerDatos = 0 Then
         RutCli = CDbl(Format(BacLinCreGen3Consult.TxtRut.Text, FEntero))
         CodCli = Format(BacLinCreGen3Consult.TxtCodCli.Text, FEntero)
         IdSist = Trim(Right(BacLinCreGen3Consult.Grid.TextMatrix(BacLinCreGen3Consult.Grid.Row, 0), 5))
      Else
         RutCli = CDbl(Format(BacLinCreGen3Consult.TxtRut2.Text, FEntero))
         CodCli = Format(BacLinCreGen3Consult.TxtCodCli2.Text, FEntero)
         IdSist = Trim(Right(BacLinCreGen3Consult.Grid2.TextMatrix(BacLinCreGen3Consult.Grid2.Row, 0), 5))
      End If
        
      Envia = Array("B")
      If Not Bac_Sql_Execute("SP_BCR_TRANSACTION", Envia) Then
         MsgBox "Error en Begin Transaction", vbCritical, TITSISTEMA
         Exit Sub
      End If
    
                  Envia = Array("E", _
                                RutCli, _
                                CodCli, _
                                IdSist)
                  
                  If Not Bac_Sql_Execute("SP_MNT_LINEA_PRODUCTO_POR_PLAZO", Envia) Then
                     
                     Envia = Array("R")
         
                     If Not Bac_Sql_Execute("SP_BCR_TRANSACTION", Envia) Then
         
                         MsgBox "Error en RollBack Transaction", vbCritical, TITSISTEMA
                         Grid1.SetFocus
         
                         Exit Sub
         
                     End If
                     
                  End If

               For I% = 2 To Grid.Rows - 1
                        
                  Dim cProducto     As String
                  Dim cInstrumento  As Integer
                  Dim cMoneda       As Integer
                  Dim cForPag       As Integer
                  Dim cDiasDesde    As Long
                  Dim cDiasHasta    As Long
                  Dim cMontoLinea   As Double
                  Dim cMontoOcupado As Double
                  Dim cMontoExceso  As Double
                  
                  cProducto = IIf(Trim(Right(Grid.TextMatrix(I%, 1), 20)) = "", " ", Trim(Right(Grid.TextMatrix(I%, 1), 20)))
                  cInstrumento = IIf(Trim(Right(Grid.TextMatrix(I%, 2), 20)) = "", 0, Trim(Right(Grid.TextMatrix(I%, 2), 20)))
                  cMoneda = IIf(Trim(Right(Grid.TextMatrix(I%, 3), 20)) = "", 0, Trim(Right(Grid.TextMatrix(I%, 3), 20)))
                  cForPag = IIf(Trim(Right(Grid.TextMatrix(I%, 4), 20)) = "", 0, Trim(Right(Grid.TextMatrix(I%, 4), 20)))
                  cDiasDesde = IIf(Trim(Right(Grid.TextMatrix(I%, 5), 20)) = "", 0, Trim(Right(Grid.TextMatrix(I%, 5), 20)))
                  cDiasHasta = IIf(Trim(Right(Grid.TextMatrix(I%, 6), 20)) = "", 0, Trim(Right(Grid.TextMatrix(I%, 6), 20)))
                  cMontoLinea = IIf(Grid.TextMatrix(I%, 7) = 0, 0, Grid.TextMatrix(I%, 7))
                  cMontoOcupado = IIf(Grid.TextMatrix(I%, 8) = 0, 0, Grid.TextMatrix(I%, 8))
                  cMontoExceso = IIf(Grid.TextMatrix(I%, 9) = 0, 0, Grid.TextMatrix(I%, 9))
                  
                  If cProducto = "" Or (cMontoLinea = 0 And cMontoOcupado = 0 And cMontoExceso = 0) Or (cDiasHasta = 0) Then GoTo PasarSig
                  'If cProducto = "" Or (cMontoLinea = 0 Or cDiasHasta = 0) Then GoTo PasarSig
                  
                  Envia = Array("I", _
                                RutCli, _
                                CodCli, _
                                IdSist, _
                                cProducto, _
                                cInstrumento, _
                                cMoneda, _
                                cForPag, _
                                cDiasDesde, _
                                cDiasHasta, _
                                CDbl(cMontoLinea), _
                                CDbl(cMontoOcupado), _
                                CDbl(cMontoExceso))
         
                 If Not Bac_Sql_Execute("SP_MNT_LINEA_PRODUCTO_POR_PLAZO", Envia) Then
         
                     Envia = Array("R")
         
                     If Not Bac_Sql_Execute("SP_BCR_TRANSACTION", Envia) Then
         
                         MsgBox "Error en RollBack Transaction", vbCritical, TITSISTEMA
                         Grid.SetFocus
                         Exit Sub
         
                     End If
         
                     MsgBox "No se puede Grabar problema con la comunicacion", vbCritical, TITSISTEMA
                     Grid.SetFocus
                     Exit Sub
         
                 End If
PasarSig:
         
             Next I%
   
         Envia = Array("C")
         
         If Not Bac_Sql_Execute("SP_BCR_TRANSACTION", Envia) Then
             MsgBox "Error en Commit Transaction", vbCritical, TITSISTEMA
             Exit Sub
         End If
         
         MsgBox "Grabación Realizada con Exito", vbInformation, TITSISTEMA
             
        Unload Me

    Case 2
        Call BacLinCreGen3Consult.Sumatorias
        Unload Me

    End Select

End Sub

Private Sub Grid_KeyPress(KeyAscii As Integer)
    Dim datos()
    
    If KeyAscii > 47 And KeyAscii < 58 Then
        TeclaPre = KeyAscii
        
        If Grid.Col = 5 Or Grid.Col = 6 Or Grid.Col = 7 Then
            Call ActivaCombo
            Texto.Text = ""
            Texto.Text = Chr(TeclaPre)
            Texto.SelStart = 1
        End If
    End If
    
    Select Case KeyAscii
        Case 13
        
            If cOptraerDatos = 0 Then
               RutCli = CDbl(Format(BacLinCreGen3Consult.TxtRut.Text, FEntero))
               CodCli = Format(BacLinCreGen3Consult.TxtCodCli.Text, FEntero)
               IdSist = Trim(Right(BacLinCreGen3Consult.Grid.TextMatrix(BacLinCreGen3Consult.Grid.Row, 0), 5))
            Else
               RutCli = CDbl(Format(BacLinCreGen3Consult.TxtRut2.Text, FEntero))
               CodCli = Format(BacLinCreGen3Consult.TxtCodCli2.Text, FEntero)
               IdSist = Trim(Right(BacLinCreGen3Consult.Grid2.TextMatrix(BacLinCreGen3Consult.Grid2.Row, 0), 5))
            End If
            
            ValorRow = Grid.Row
            ValorCol = Grid.Col
            
            If Grid.Col = 3 Or Grid.Col = 4 Then
               
               Envia = Array()
               AddParam Envia, "3"
               AddParam Envia, IdSist
               AddParam Envia, Trim(Right(Grid.TextMatrix(Grid.Row, 1), 20))
         
               If Not Bac_Sql_Execute("SP_MTN_PRODUCTO_SISTEMA", Envia) Then
                  MsgBox "Problemas en la recuperacion de datos", vbCritical, TITSISTEMA
               End If
               
               Do While Bac_SQL_Fetch(datos())
                   If Grid.Col = 3 And datos(1) = 0 Then
                        Exit Sub
                   ElseIf Grid.Col = 4 And datos(2) = 0 Then
                        Exit Sub
                   End If
               Loop
               
            End If
            ' 02 Nov. 2009  - Se agrega Opciones a if , ya que no para este modulo no existe instrumento(Columna 2 de Grilla)
            If (IdSist = "BFW" Or IdSist = "BCC" Or IdSist = "OPT") And Grid.Col = 2 Then
               Grid.SetFocus
            Else
              If Grid.TextMatrix(Grid.Row, 8) <> 0 And Grid.Col = 1 Then
                 Grid.SetFocus
              Else
                 Call ActivaCombo
              End If
            End If
    End Select
End Sub

Private Sub Grid_KeyDown(KEYCODE As Integer, Shift As Integer)
    If KEYCODE = 45 Then
        
'       With Grid
'
'            If Trim(Right(.TextMatrix(.Row, 1), 20)) = "" Or _
'               .TextMatrix(.Row, 6) = 0 Or _
'               .TextMatrix(.Row, 7) = 0 Then
'               Exit Sub
'            End If
'
'       End With
'
'      Call InsertarRow(Grid)
'      Grid.SetFocus
    End If
    
    If KEYCODE = 46 Then
'      If Grid.Rows <= 2 Then Exit Sub
'
'      If Grid.TextMatrix(Grid.Row, 8) > 0 Then
'         MsgBox "La fila no se puede eliminar ya que tiene monto ocupado", vbInformation, TITSISTEMA
'         Exit Sub
'      End If
'
'      'CASS
'        If Grid.Rows - 1 = 2 Then
'            Grid.TextMatrix(Grid.Row, 0) = ""
'            Grid.TextMatrix(Grid.Row, 1) = ""
'            Grid.TextMatrix(Grid.Row, 2) = ""
'            Grid.TextMatrix(Grid.Row, 3) = ""
'            Grid.TextMatrix(Grid.Row, 4) = ""
'            Grid.TextMatrix(Grid.Row, 5) = 0
'            Grid.TextMatrix(Grid.Row, 6) = 0
'            Grid.TextMatrix(Grid.Row, 7) = 0
'            Grid.TextMatrix(Grid.Row, 8) = 0
'            Grid.TextMatrix(Grid.Row, 9) = 0
'        Else
'      Grid.RemoveItem (Grid.Row)
'        End If
'
'      Grid.SetFocus
    
    End If

End Sub

Private Sub CmbCombo_KeyDown(KEYCODE As Integer, Shift As Integer)
    Select Case KEYCODE
        'Case vbKeyReturn
        Case 13
        
            If Not FUNC_RECALOCUPADO(CDbl(Grid.TextMatrix(Grid.Row, 7)), CDbl(Grid.TextMatrix(Grid.Row, 8)), Val(Right(CmbCombo.Text, 9)), Val(Right(Grid.TextMatrix(Grid.Row, 3), 9))) Then
                CmbCombo.Visible = False
                Exit Sub
            End If
        
      
            Grid.TextMatrix(Grid.RowSel, Grid.ColSel) = CmbCombo.Text
               'Grid.TextMatrix(ValorRow, ValorCol) = CmbCombo.Text
               
            CmbCombo.Visible = False
        Case 27
            CmbCombo.Visible = False
            Grid.SetFocus
    End Select
End Sub

Private Sub CmbCombo_LostFocus()

   CmbCombo.Visible = False
   Grid.SetFocus
End Sub

Private Sub Texto_KeyDown(KEYCODE As Integer, Shift As Integer)
    Select Case KEYCODE
        Case vbKeyReturn
        
            If CDbl(Texto.Text) < Grid.TextMatrix(Grid.RowSel, 9) Then
                    MsgBox "Error: Asignado no puede ser menor a ocupado", vbInformation + vbOKOnly, "CONTROL FINANCIERO"
                    Texto.Visible = False
                    Grid.SetFocus
                    Exit Sub
            End If
        
            If CDbl(Grid.TextMatrix(Grid.RowSel, 8)) > 0 And CDbl(Grid.TextMatrix(Grid.RowSel, Grid.ColSel)) <> 0 And (CDbl(Texto.Text) = CDbl(Grid.TextMatrix(Grid.RowSel, 8))) Then
               Texto.Visible = False
               Grid.SetFocus
               Exit Sub
            End If
            Grid.TextMatrix(Grid.RowSel, Grid.ColSel) = Texto.Text
            
            If Grid.Col = 7 Then
               Grid.TextMatrix(Grid.RowSel, Grid.ColSel) = Format(Texto.Text, FDecimal)
            ElseIf Grid.Col = 6 Or Grid.Col = 5 Then
               Grid.TextMatrix(Grid.RowSel, Grid.ColSel) = Format(Texto.Text, FEntero)
            End If

            If CDbl(Grid.TextMatrix(Grid.RowSel, 7)) >= CDbl(Grid.TextMatrix(Grid.RowSel, 9)) Then
                    Grid.TextMatrix(Grid.RowSel, 9) = Format(0, FEntero)
            End If
            Texto.Visible = False
            Texto.Text = ""
            Grid.SetFocus
        
        Case 27
            Texto.Visible = False
            Grid.SetFocus
    End Select
End Sub

Private Function CargarGrilla()
    Dim I%
    Dim xx%

    Texto.Visible = False
    Grid.Rows = 3
    Grid.FixedRows = 2
    Grid.FixedCols = 0
    Grid.Cols = 11
    Grid.BackColorFixed = ColorVerde
    Grid.ForeColorFixed = ColorBlanco
    Grid.BackColor = ColorGris
    Grid.ForeColor = ColorAzul
    Grid.BackColorSel = ColorAzul
    Grid.ForeColorSel = ColorBlanco

    Toolbar1.Buttons(1).Enabled = False

    Titulo1 = Array(".", "        ", "        ", "        ", "Forma", "Dias ", "Dias ", "Monto", "Monto", "Monto", "Mon")
    Titulo2 = Array("", "Producto", "Instrumento", "Moneda", "de Pago", "Desde", "Hasta", "Linea", "Ocupado", "Exceso", "")
    Anchos = Array("0", "2900", "3200", "1300", "2400", "1000", "1000", "2390", "2390", "2390", "0")
    Titulo3 = Array("0", " ", " ", " ", " ", "0", "0", BacLinCreGen3Consult.Grid.TextMatrix(BacLinCreGen3Consult.Grid.Row, 5), "0", "0", "0")
    
    Call PROC_CARGARGRILLA(Grid, 315, 215, Anchos, Titulo1, , Titulo2)

    Me.Tag = Format(BacLinCreGen3Consult.Grid.TextMatrix(BacLinCreGen3Consult.Grid.Row, 5), FDecimal)
    LabTotLin.Caption = Format(BacLinCreGen3Consult.Grid.TextMatrix(BacLinCreGen3Consult.Grid.Row, 5), FDecimal)

    Grid.Col = 0: Grid.Row = 2
    Grid.Rows = 2
    
      If cOptraerDatos = 0 Then
         RutCli = CDbl(Format(BacLinCreGen3Consult.TxtRut.Text, FEntero))
         CodCli = Format(BacLinCreGen3Consult.TxtCodCli.Text, FEntero)
         IdSist = Trim(Right(BacLinCreGen3Consult.Grid.TextMatrix(BacLinCreGen3Consult.Grid.Row, 0), 5))
      Else
         RutCli = CDbl(Format(BacLinCreGen3Consult.TxtRut2.Text, FEntero))
         CodCli = Format(BacLinCreGen3Consult.TxtCodCli2.Text, FEntero)
         IdSist = Trim(Right(BacLinCreGen3Consult.Grid2.TextMatrix(BacLinCreGen3Consult.Grid2.Row, 0), 5))
      End If

    With BacLinCreGen3Consult.Grid

        For I% = 1 To .Rows - 1

            If IdSist = Trim(Right(.TextMatrix(I%, 0), 5)) Then
                Grid.Rows = Grid.Rows + 1
                Grid.CellFontBold = False
                Grid.RowHeight(Grid.Rows - 1) = 315
                Grid.TextMatrix(Grid.Rows - 1, 1) = ""
                Grid.TextMatrix(Grid.Rows - 1, 1) = " "
                Grid.TextMatrix(Grid.Rows - 1, 2) = " "
                Grid.TextMatrix(Grid.Rows - 1, 3) = " "
                Grid.TextMatrix(Grid.Rows - 1, 4) = " "
                Grid.TextMatrix(Grid.Rows - 1, 5) = 0
                Grid.TextMatrix(Grid.Rows - 1, 6) = 0
                Grid.TextMatrix(Grid.Rows - 1, 7) = Format(.TextMatrix(I%, 2), FDecimal)
                Grid.TextMatrix(Grid.Rows - 1, 8) = Format(.TextMatrix(I%, 3), FDecimal)
                Grid.TextMatrix(Grid.Rows - 1, 9) = Format(.TextMatrix(I%, 5), FDecimal)
                Grid.TextMatrix(Grid.Rows - 1, 10) = 0
            End If

        Next I%

    End With

    If Grid.Rows = 2 Then
        Grid.Rows = Grid.Rows + 1
        For I% = 2 To Grid.Rows - 1
            Grid.RowHeight(I%) = 315
            For xx% = 0 To Grid.Cols - 1
                Grid.CellFontBold = False
                Grid.TextMatrix(I%, xx%) = Titulo3(xx%)
            Next xx%
        Next I%
    End If

    Grid.GridLinesFixed = flexGridNone
    Call Calculo
    Call CargaComboProducto(CStr(IdSist), 1)
    Call Proc_LLena_Grilla
    Call Calculo
End Function

Private Function Calculo()
    Dim I%
    LabTotMon.Caption = 0

    For I% = 2 To Grid.Rows - 1
        LabTotMon.Caption = LabTotMon.Caption + CDbl(Format(Grid.TextMatrix(I%, 8), FDecimal))
    Next I%

    LabTotLin.Caption = Format(BacLinCreGen3Consult.LabTotLin.Text, FDecimal)
    LabTotMon.Caption = Format(LabTotMon.Caption, FDecimal)

End Function

Private Function ActivaCombo()
         CmbCombo.Visible = False
         Texto.Visible = False

        If Grid.Col = 1 Or Grid.Col = 2 Or Grid.Col = 3 Or Grid.Col = 4 Then
''''            CmbCombo.Visible = True
            Call PROC_POSICIONA_TEXTO(Grid, CmbCombo)
            Call CargaComboProducto(CStr(IdSist), Grid.Col)
''''            CmbCombo.SetFocus
        Else
         If Grid.Col = 8 Or Grid.Col = 9 Then Exit Function
            CmbCombo.Visible = False
''''            Texto.Visible = True
            Call PROC_POSICIONA_TEXTO(Grid, Texto)
            
            If Grid.Col = 7 Then
               Texto.Text = Format(Texto.Text, FDecimal)
            ElseIf Grid.Col = 6 Or Grid.Col = 5 Then
               Texto.Text = Format(Texto.Text, FEntero)
            End If

''''            Texto.SetFocus
         End If

End Function

Private Function CargaComboProducto(sSistema As String, Col As String)
    Dim datos()
    
    Envia = Array()
    AddParam Envia, sSistema
    If Col = 1 Then
        If Bac_Sql_Execute("SP_LEERPRODUCTOSSISTEMAS", Envia) Then
           CmbCombo.Clear
           Do While Bac_SQL_Fetch(datos())
                 CmbCombo.AddItem datos(2) & Space(100) & datos(1)
           Loop
        End If
        Exit Function
    End If
    
    If sSistema = "BTR" And Col = 2 Then
        If Bac_Sql_Execute("SP_BACMATRIZATRIBUCIONES_LEEINSTRUMENTO") Then
            CmbCombo.Clear
            Do While Bac_SQL_Fetch(datos())
                CmbCombo.AddItem datos(2) & Space(100) & datos(1)
           Loop
        End If
        Exit Function
    End If

    If Col = 3 Then
        Envia = Array()
        AddParam Envia, "1"
        If Bac_Sql_Execute("SP_BUSCA_DATOS_OPCIONALES", Envia) Then
           CmbCombo.Clear
           Do While Bac_SQL_Fetch(datos())
                CmbCombo.AddItem datos(2) & Space(100) & datos(1)
           Loop
        End If
        Exit Function
    End If

    If Col = 4 Then
        Envia = Array()
        AddParam Envia, "2"
        If Bac_Sql_Execute("SP_BUSCA_DATOS_OPCIONALES", Envia) Then
           CmbCombo.Clear
           Do While Bac_SQL_Fetch(datos())
                CmbCombo.AddItem datos(2) & Space(100) & datos(1)
           Loop
        End If
        Exit Function
    End If

End Function
 
 Private Function Proc_LLena_Grilla()
      Dim datos()
      Dim lExiste As Boolean

      If cOptraerDatos = 0 Then
         RutCli = CDbl(Format(BacLinCreGen3Consult.TxtRut.Text, FEntero))
         CodCli = Format(BacLinCreGen3Consult.TxtCodCli.Text, FEntero)
         IdSist = Trim(Right(BacLinCreGen3Consult.Grid.TextMatrix(BacLinCreGen3Consult.Grid.Row, 0), 5))
      Else
         RutCli = CDbl(Format(BacLinCreGen3Consult.TxtRut2.Text, FEntero))
         CodCli = Format(BacLinCreGen3Consult.TxtCodCli2.Text, FEntero)
         IdSist = Trim(Right(BacLinCreGen3Consult.Grid2.TextMatrix(BacLinCreGen3Consult.Grid2.Row, 0), 5))
      End If
           Envia = Array("C", _
                     RutCli, _
                     CodCli, _
                     IdSist)
          If Not Bac_Sql_Execute("SP_MNT_LINEA_PRODUCTO_POR_PLAZO", Envia) Then
              Exit Function
          End If
          
         lExiste = False
         Do While Bac_SQL_Fetch(datos())
            lExiste = True
            Grid.TextMatrix(Grid.Rows - 1, 1) = IIf(IsNull(datos(10)), "", datos(10)) + Space(100) + IIf(IsNull(datos(1)), "", datos(1))
            Grid.TextMatrix(Grid.Rows - 1, 2) = IIf(IsNull(datos(11)), "", datos(11)) + Space(100) + IIf(IsNull(datos(2)), "", datos(2))
            Grid.TextMatrix(Grid.Rows - 1, 3) = IIf(IsNull(datos(13)), "", datos(13)) + Space(100) + IIf(IsNull(datos(3)), "", datos(3))
            Grid.TextMatrix(Grid.Rows - 1, 4) = IIf(IsNull(datos(12)), "", datos(12)) + Space(100) + IIf(IsNull(datos(4)), "", datos(4))
            Grid.TextMatrix(Grid.Rows - 1, 5) = IIf(IsNull(datos(5)), "", datos(5))
            Grid.TextMatrix(Grid.Rows - 1, 6) = IIf(IsNull(datos(6)), "", datos(6))
            Grid.TextMatrix(Grid.Rows - 1, 7) = Format(datos(7), FDecimal)
            Grid.TextMatrix(Grid.Rows - 1, 8) = Format(datos(8), FDecimal)
            Grid.TextMatrix(Grid.Rows - 1, 9) = Format(datos(9), FDecimal)
            Grid.Rows = Grid.Rows + 1
         Loop
         
         If lExiste Then
            Grid.Rows = Grid.Rows - 1
         End If

 End Function

Sub InsertarRow(Grid As MSFlexGrid)
    Dim Monto   As Integer
    Dim nDesde  As Integer
    Dim nHasta  As Integer
    
    If Grid.Row > 2 Then
       nDesde = Grid.TextMatrix(Grid.Row, 6) + 1
       nHasta = nDesde + 1
    End If
    
    Grid.Rows = Grid.Rows + 1
    Grid.Row = Grid.Rows - 1
    Grid.Col = 0
    
    Grid.TextMatrix(Grid.Row, 0) = ""
    Grid.TextMatrix(Grid.Row, 1) = ""
    Grid.TextMatrix(Grid.Row, 2) = ""
    Grid.TextMatrix(Grid.Row, 3) = ""
    Grid.TextMatrix(Grid.Row, 4) = ""
    Grid.TextMatrix(Grid.Row, 5) = 0
    Grid.TextMatrix(Grid.Row, 6) = 0
    Grid.TextMatrix(Grid.Row, 7) = 0
    Grid.TextMatrix(Grid.Row, 8) = 0
    Grid.TextMatrix(Grid.Row, 9) = 0
           
    Grid.TextMatrix(Grid.Row, 5) = Format(nDesde, FEntero)
    Grid.TextMatrix(Grid.Row, 6) = Format(nHasta, FEntero)
    Grid.TextMatrix(Grid.Row, 7) = Format(0, FDecimal)
    Grid.TextMatrix(Grid.Row, 8) = Format(Grid.TextMatrix(Grid.Row, 8), FDecimal)
    Grid.TextMatrix(Grid.Row, 9) = Format(Grid.TextMatrix(Grid.Row, 9), FDecimal)
    
    Grid.SetFocus

End Sub



Private Function FUNC_RECALOCUPADO(nlinea As Double, nMonto As Double, nMoneda As Integer, nmonedant As Integer)
On Error GoTo Mal
   
   Dim datos()
    
   If nMoneda = 0 Or nmonedant = 0 Then
        FUNC_RECALOCUPADO = True
        Exit Function
   End If
       
   
   FUNC_RECALOCUPADO = False
   
    Envia = Array()
    AddParam Envia, CDbl(nlinea)
    AddParam Envia, CDbl(nMonto)
    AddParam Envia, CDbl(nMoneda)
    AddParam Envia, CDbl(nmonedant)

    If Not Bac_Sql_Execute("SP_RECALCULA_OCUPADO", Envia) Then
        Exit Function
    End If

    Do While Bac_SQL_Fetch(datos())
        If datos(1) = "ERROR" Then
            MsgBox datos(2), vbCritical
            Exit Function
        End If
        
        Grid.TextMatrix(Grid.Row, 7) = datos(3)
        Grid.TextMatrix(Grid.Row, 8) = datos(2)
        Grid.TextMatrix(Grid.Row, 9) = datos(5)


        Grid.TextMatrix(Grid.Row, 7) = Format(Grid.TextMatrix(Grid.Row, 7), FEntero)
        Grid.TextMatrix(Grid.Row, 8) = Format(Grid.TextMatrix(Grid.Row, 8), FEntero)
        Grid.TextMatrix(Grid.Row, 9) = Format(Grid.TextMatrix(Grid.Row, 9), FEntero)
        
    Loop

FUNC_RECALOCUPADO = True
Exit Function
Mal:

FUNC_RECALOCUPADO = False
End Function

Function ValidaRepetidos(GRD As MSFlexGrid)
 
 Dim Fila As Single, Columna As Single
 Dim TxtCompara As String
 Dim Texto As String
 Dim I, Cont As Integer
 ReDim Matriz(Grid.Rows)
 
 I = 1
 
 ValidaRepetidos = False
     
 For Fila = 2 To Grid.Rows - 1
        Matriz(I) = Trim(Right(Grid.TextMatrix(Fila, 1), 20)) & Trim(Left(Grid.TextMatrix(Fila, 2), 20)) & Trim(Right(Format(Grid.TextMatrix(Fila, 5), FEntero), 20)) & Trim(Right(Format(Grid.TextMatrix(Fila, 6), FEntero), 20))
        I = I + 1
 Next
 
 I = 1
 
 For I = 1 To UBound(Matriz) - 1
    For Cont = I + 1 To UBound(Matriz)
          If Trim(Matriz(I)) = Trim(Matriz(Cont)) And Not IsEmpty(Matriz(Cont)) Then
             ValidaRepetidos = True
          End If
    Next

 Next
 
  
End Function
