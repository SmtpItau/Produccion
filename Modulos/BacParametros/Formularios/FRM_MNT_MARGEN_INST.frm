VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Begin VB.Form FRM_MNT_MARGEN_INST 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Margen por Instrumento (SOMA)"
   ClientHeight    =   6270
   ClientLeft      =   4320
   ClientTop       =   7245
   ClientWidth     =   5625
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   6270
   ScaleWidth      =   5625
   WhatsThisHelp   =   -1  'True
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   4
      Top             =   0
      Width           =   5625
      _ExtentX        =   9922
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Grabar"
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   9
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Eliminar"
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   11
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Limpiar"
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   10
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Buscar"
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   6
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComDlg.CommonDialog MiCommand 
         Left            =   2550
         Top             =   15
         _ExtentX        =   847
         _ExtentY        =   847
         _Version        =   393216
      End
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   4365
         Top             =   60
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   11
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_MARGEN_INST.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_MARGEN_INST.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_MARGEN_INST.frx":1DB4
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_MARGEN_INST.frx":2C8E
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_MARGEN_INST.frx":3B68
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_MARGEN_INST.frx":4A42
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_MARGEN_INST.frx":4D5C
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_MARGEN_INST.frx":5C36
               Key             =   ""
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_MARGEN_INST.frx":6B10
               Key             =   ""
            EndProperty
            BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_MARGEN_INST.frx":6F62
               Key             =   ""
            EndProperty
            BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_MARGEN_INST.frx":727C
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame CuadroFecha 
      Height          =   1695
      Left            =   120
      TabIndex        =   5
      Top             =   495
      Width           =   5430
      Begin BACControles.TXTFecha TXTFecha 
         Height          =   300
         Left            =   1755
         TabIndex        =   2
         Top             =   1200
         Width           =   1425
         _ExtentX        =   2514
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
         ForeColor       =   12582912
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "02/11/2010"
      End
      Begin VB.ComboBox Cmb_TipoOpSoma 
         Height          =   315
         ItemData        =   "FRM_MNT_MARGEN_INST.frx":76CE
         Left            =   1770
         List            =   "FRM_MNT_MARGEN_INST.frx":76D5
         Style           =   2  'Dropdown List
         TabIndex        =   0
         Top             =   255
         Width           =   1920
      End
      Begin VB.ComboBox Cmb_Familia 
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
         ItemData        =   "FRM_MNT_MARGEN_INST.frx":76E9
         Left            =   1755
         List            =   "FRM_MNT_MARGEN_INST.frx":76F0
         Style           =   2  'Dropdown List
         TabIndex        =   1
         TabStop         =   0   'False
         Top             =   735
         Width           =   2655
      End
      Begin VB.Label LblFecha 
         Caption         =   "Fecha"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   225
         Left            =   165
         TabIndex        =   11
         Top             =   1275
         Width           =   1200
      End
      Begin VB.Label LblTipoSoma 
         Caption         =   "Tipo Op. SOMA"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   270
         Left            =   120
         TabIndex        =   10
         Top             =   360
         Width           =   1335
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Tipo Instrumento"
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
         Height          =   195
         Index           =   1
         Left            =   150
         TabIndex        =   6
         Top             =   855
         Width           =   1485
      End
   End
   Begin VB.Frame CuadroDetalle 
      Enabled         =   0   'False
      Height          =   3930
      Left            =   90
      TabIndex        =   7
      Top             =   2250
      Width           =   5430
      Begin BACControles.TXTNumero TXTDiasHasta 
         Height          =   255
         Left            =   1920
         TabIndex        =   9
         Top             =   1500
         Visible         =   0   'False
         Width           =   975
         _ExtentX        =   1720
         _ExtentY        =   450
         BackColor       =   -2147483635
         ForeColor       =   -2147483643
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
         Min             =   "1"
         Max             =   "99999"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTNumero NumeroGrid 
         Height          =   285
         Left            =   570
         TabIndex        =   8
         Top             =   1485
         Visible         =   0   'False
         Width           =   885
         _ExtentX        =   1561
         _ExtentY        =   503
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
         Text            =   "0"
         Text            =   "0"
         Min             =   "0"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin MSFlexGridLib.MSFlexGrid Grid 
         Height          =   3510
         Left            =   165
         TabIndex        =   3
         Top             =   240
         Width           =   5130
         _ExtentX        =   9049
         _ExtentY        =   6191
         _Version        =   393216
         Cols            =   6
         FixedCols       =   0
         BackColor       =   -2147483633
         ForeColor       =   -2147483641
         BackColorFixed  =   -2147483646
         ForeColorFixed  =   -2147483639
         BackColorBkg    =   -2147483636
         Enabled         =   -1  'True
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
   End
End
Attribute VB_Name = "FRM_MNT_MARGEN_INST"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim Grilla()
Dim oMensaje   As String

Const Cons_CodInst = 0
Const Cons_ClasfRiesgo = 1
Const Cons_PlazoDesde = 2
Const Cons_PlazoHasta = 3
Const Cons_Margen = 4
Const Cons_TipoOpSoma = 5



Private Sub Proc_CargaDatosOcultos()
    With GRID
        
         .TextMatrix(.Row, Cons_CodInst) = Trim(Right(Cmb_Familia.Text, 10))
        If Trim(Left(Cmb_Familia.Text, 10)) = "LH-AA" Then
            .TextMatrix(.Row, Cons_ClasfRiesgo) = "AA"
        ElseIf Trim(Left(Cmb_Familia.Text, 10)) = "LH-A" Then
            .TextMatrix(.Row, Cons_ClasfRiesgo) = "A"
        Else
            .TextMatrix(.Row, Cons_ClasfRiesgo) = ""
        End If
        .TextMatrix(.Row, Cons_TipoOpSoma) = Trim(Left(Me.Cmb_TipoOpSoma.Text, 10))
    End With
End Sub

Private Sub NombresGrilla()
    GRID.Rows = 2:         GRID.FixedRows = 1
    GRID.Cols = 6:         GRID.FixedCols = 0
    
    GRID.Font.Name = "Tahoma"
    GRID.Font.Size = 8
    GRID.RowHeightMin = 315
    
    GRID.TextMatrix(0, Cons_CodInst) = "Cod.Inst."
    GRID.TextMatrix(0, Cons_ClasfRiesgo) = "Clasf.Riesgo"
    GRID.TextMatrix(0, Cons_PlazoDesde) = "Días Desde"
    GRID.TextMatrix(0, Cons_PlazoHasta) = "Días Hasta"
    GRID.TextMatrix(0, Cons_Margen) = "Margen "
    GRID.TextMatrix(0, Cons_TipoOpSoma) = "Tipo.Op.Soma"
    
    
    GRID.ColWidth(Cons_CodInst) = 0
    GRID.ColWidth(Cons_ClasfRiesgo) = 0
    GRID.ColWidth(Cons_PlazoDesde) = 1500
    GRID.ColWidth(Cons_PlazoHasta) = 1500
    GRID.ColWidth(Cons_Margen) = 1500
    GRID.ColWidth(Cons_TipoOpSoma) = 0
    
    GRID.Rows = 1
    GRID.Rows = GRID.Rows + 1
    GRID.Row = GRID.Rows - 1
    GRID.TextMatrix(GRID.Row, Cons_PlazoDesde) = Format(0, FEntero)
    GRID.TextMatrix(GRID.Row, Cons_PlazoHasta) = Format(0, FEntero)
    GRID.TextMatrix(GRID.Row, Cons_Margen) = Format(0#, FDecimal)
    Call Proc_CargaDatosOcultos
  
End Sub

Private Sub Proc_CargaCmbTipoOpSoma()
   Dim Datos()

   If Not Bac_Sql_Execute("SP_LEERTIPOOPSOMA") Then
      Exit Sub
   End If
   Call Cmb_TipoOpSoma.Clear
   Do While Bac_SQL_Fetch(Datos())
      Call Cmb_TipoOpSoma.AddItem(Trim(Datos(6)) & String(80 - Len(Trim(Datos(6))), " ") & Datos(2))
   Loop
End Sub

Private Sub Proc_ValidaRango()
    Dim TotGrid As Integer
    Dim nContador As Long
    
    TotGrid = GRID.Rows - 1
    For nContador = 1 To GRID.Rows - 1
        If TotGrid = nContador And nContador >= 1 Then
       
        Else
            If CDbl(GRID.TextMatrix(nContador + 1, Cons_PlazoDesde)) > CDbl(GRID.TextMatrix(nContador, Cons_PlazoHasta)) + 1 Then
                Call MsgBox("Revizar Plazos " & "Dias Hasta Valor:" & CDbl(GRID.TextMatrix(nContador, Cons_PlazoHasta)), vbInformation, App.Title)
                GRID.Col = Cons_PlazoHasta
                GRID.Row = nContador
                GRID.SetFocus
                GRID.CellBackColor = vbRed
            End If
        End If
    Next nContador
   
End Sub

Private Sub Cmb_Familia_Click()
   GRID.Enabled = True
   Let CuadroDetalle.Enabled = True
   
   If Cmb_Familia.ListIndex = -1 Then
      Exit Sub
   End If
   GRID.Clear
   GRID.Rows = 1
   Let CuadroDetalle.Enabled = True
   Call NombresGrilla
   FRM_MNT_MARGEN_INST.Show
   Call Buscar
     
   Cmb_Familia.Enabled = False
   Cmb_TipoOpSoma.Enabled = False
End Sub

Private Sub Cmb_TipoOpSoma_Click()
    CuadroDetalle.Enabled = True
   
   If Cmb_TipoOpSoma.ListIndex = -1 Then
      Exit Sub
   End If
   Let CuadroDetalle.Enabled = True

End Sub

Private Sub Form_Load()
    Me.Icon = BACSwapParametros.Icon
    Me.Top = 0:        Me.Left = 0
    
    Toolbar1.Buttons("Grabar").Enabled = False
    Toolbar1.Buttons("Eliminar").Enabled = False
   
    Call NombresGrilla
    Call CargaCmbFamilia
    Call Proc_CargaCmbTipoOpSoma
    If Me.Cmb_TipoOpSoma.ListCount > 0 Then
        Cmb_TipoOpSoma.ListIndex = 0
    End If
    If Me.Cmb_Familia.ListCount > 0 Then
        Cmb_Familia.ListIndex = 0
    End If
    
    TXTFecha.Text = gsbac_fecp
    
End Sub

Private Sub CargaCmbFamilia()
   Dim Datos()

   If Not Bac_Sql_Execute("SP_LEERFAMILIASTASAREF") Then
      Exit Sub
   End If
   Call Cmb_Familia.Clear
   Do While Bac_SQL_Fetch(Datos())
      Call Cmb_Familia.AddItem(Trim(Datos(2)) & String(80 - Len(Trim(Datos(2))), " ") & Datos(1))
   Loop
End Sub

Private Sub Form_Resize()
'   On Error Resume Next
'   Let CuadroFecha.Width = Me.Width - 150
'   Let CuadroDetalle.Width = CuadroFecha.Width
'   Let Grid.Width = CuadroDetalle.Width - 130
'   Let CuadroDetalle.Height = Me.Height - 1950
'   Let Grid.Height = CuadroDetalle.Height - 500
'   On Error GoTo 0
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Dim TotGrid As Integer
    Dim nContador As Integer
    Dim nContador1 As Integer
    If MsgBox("¿Esta seguro que desea Salir, ¿Grabo la Información? ", vbQuestion + vbYesNo, App.Title) = vbNo Then
       Cancel = vbCancel
    Else
    
         If Trim(GRID.TextMatrix(1, Cons_PlazoDesde)) <> 0 And Trim(GRID.TextMatrix(1, Cons_PlazoHasta)) <> 0 _
         And Trim(GRID.TextMatrix(1, Cons_Margen)) <> 0# Then
            
            TotGrid = GRID.Rows - 1
            For nContador = 1 To GRID.Rows - 1
                If TotGrid = nContador And nContador >= 1 Then
               
                Else
                    If CDbl(GRID.TextMatrix(nContador + 1, Cons_PlazoDesde)) > CDbl(GRID.TextMatrix(nContador, Cons_PlazoHasta)) + 1 Then
                        Call MsgBox("Revizar Plazos " & "Dias Hasta Valor:" & CDbl(GRID.TextMatrix(nContador, Cons_PlazoHasta)), vbInformation, App.Title)
                        GRID.Col = Cons_PlazoHasta
                        GRID.Row = nContador
                        GRID.SetFocus
                        GRID.CellBackColor = vbRed
                        Cancel = vbCancel
                    End If
                End If
            Next nContador
'            With GRID
'            For nContador1 = 1 To .Rows - 1
'                    If CDbl(.TextMatrix(nContador1, Cons_Margen)) = Format(0, FDecimal) _
'                    Or CDbl(.TextMatrix(nContador1, Cons_PlazoHasta)) = Format(0, FEntero) Then
'                      Call MsgBox("No puede grabar Valor en 0,000. Revizar fila N° " & nContador1, vbInformation, App.Title)
'                      .Row = nContador1
'                      .Col = Cons_Margen: .CellBackColor = vbRed
'                      .Col = Cons_PlazoHasta: .CellBackColor = vbRed
'                      .SetFocus
'                       Cancel = vbCancel
'                    End If
'                Next nContador1
'            End With
            Exit Sub
        End If
    End If
End Sub

Private Sub GRID_DblClick()
   Select Case GRID.Col
      Case Cons_PlazoHasta
         
        If GRID.Row > 0 Then
          TxtDiasHasta.CantidadDecimales = 0
          TxtDiasHasta.Text = GRID.TextMatrix(GRID.RowSel, GRID.ColSel)
          Call AJObjeto(GRID, TxtDiasHasta)
          Call Habilitacion(True, TxtDiasHasta)
        End If
      Case Cons_Margen
      
            NumeroGrid.CantidadDecimales = 0
            If GRID.ColSel >= 1 Then
               NumeroGrid.CantidadDecimales = 4
            End If
            
            If GRID.Row > 0 Then
             NumeroGrid.Text = GRID.TextMatrix(GRID.RowSel, GRID.ColSel)
             Call AJObjeto(GRID, NumeroGrid)
             Call Habilitacion(True, NumeroGrid)
            End If
   End Select
End Sub

Private Sub GRID_KeyDown(KeyCode As Integer, Shift As Integer)
   Dim iValor     As Double
   Dim iContador  As Integer
   Dim nContador1  As Integer
   If GRID.Row = 0 Then
         Exit Sub
   End If


   If KeyCode = vbKeyInsert Then
      
      If CDbl(GRID.TextMatrix(GRID.RowSel, Cons_PlazoHasta)) = 0 Then
         Call MsgBox("Días hasta debe ser mayor a 0", vbInformation, App.Title)
         GRID.SetFocus
         Exit Sub
      End If
   
      
'      If CDbl(GRID.TextMatrix(GRID.RowSel, Cons_Margen)) = 0# Then
'         Call MsgBox(" a dejado Margen en 0,0000", vbInformation, App.Title)
'         GRID.SetFocus
'         Exit Sub
'      End If
   
      
      If CDbl(GRID.TextMatrix(GRID.RowSel, Cons_PlazoDesde)) > CDbl(GRID.TextMatrix(GRID.RowSel, Cons_PlazoHasta)) Then
         Call MsgBox("Periodo de Dias Hasta, debe ser mayor al periodo de Dias Desde, para poder agregar nuevos valores.", vbInformation, App.Title)
         GRID.SetFocus
         Exit Sub
      End If
      
'      If CDbl(GRID.TextMatrix(GRID.RowSel, Cons_PlazoDesde)) = CDbl(GRID.TextMatrix(GRID.RowSel, Cons_PlazoHasta)) Then
'         Call MsgBox("Periodo de Dias hasta, debe ser mayor al periodo de Dias Desde, para poder agregar nuevos valores.", vbInformation, App.Title)
'         GRID.SetFocus
'         Exit Sub
'      End If
      With GRID
        For nContador1 = 1 To .Rows - 1
               If CDbl(.TextMatrix(nContador1, Cons_Margen)) = Format(0, FDecimal) _
               Or CDbl(.TextMatrix(nContador1, Cons_PlazoHasta)) = Format(0, FEntero) Then
                 Call MsgBox(" Valores de Margen en 0,000. Revizar fila N° " & nContador1, vbInformation, App.Title)
                 .Row = nContador1
                 .Col = Cons_Margen
                 .Col = Cons_PlazoHasta
                 .SetFocus
                 'Exit Sub
               End If
        Next nContador1
        
        For nContador1 = 1 To .Rows - 1
               If CDbl(.TextMatrix(nContador1, Cons_Margen)) > Format(1, FEntero) _
               Or CDbl(.TextMatrix(nContador1, Cons_Margen)) < Format(0, FEntero) Then
                 Call MsgBox(" Valores de Margen no puede ser mayor que 1 ni menor que 0, Revizar fila N° " & nContador1, vbInformation, App.Title)
                 .Row = nContador1
                 .Col = Cons_Margen
                 .SetFocus
                 Exit Sub
               End If
        Next nContador1
           
      End With
      
            
      If PuedeInsertarFila Then
         Call FUNC_INIT_ROW
      Else
         MsgBox "Debe Completar Valores para Insertar Registro.", vbExclamation, App.Title
      End If
      Call Proc_CargaDatosOcultos
   End If

   If KeyCode = vbKeyDelete Then
   
         If GRID.Rows = 1 Then
              Call MsgBox("Debe existir registro para eliminar.", vbInformation, App.Title)
              Exit Sub
         End If
        
         If Cmb_Familia.ListIndex = -1 Then
            Call MsgBox("Debe Seleccionar Familia de Instrumentos para Poder Eliminar Registros.", vbInformation, App.Title)
            Exit Sub
         End If
         
         If MsgBox("¿ Esta seguro que desea Eliminar Margen Familia Instrumentos? ", vbQuestion + vbYesNo, App.Title) = vbNo Then
            Exit Sub
         End If
         
         
         If GRID.Row = 0 Then
                Call MsgBox("Debe Seleccionar Familia de Instrumentos para Poder Eliminar Registros.", vbInformation, App.Title)
                Exit Sub
         Else
      
                If GRID.Rows > 2 Then
                   GRID.RemoveItem GRID.Row
                   
                   If GRID.TextMatrix(1, Cons_PlazoDesde) <> 1 Then
                      GRID.TextMatrix(1, Cons_PlazoDesde) = Format(1, FEntero)
                   End If
                   
                   Call CargaDiasDesde(0)
                   GRID.SetFocus
                Else
                   GRID.TextMatrix(GRID.Rows - 1, Cons_PlazoDesde) = Format(0, FEntero)
                   GRID.TextMatrix(GRID.Rows - 1, Cons_PlazoHasta) = Format(0, FEntero)
                   GRID.TextMatrix(GRID.Rows - 1, Cons_Margen) = Format(0, FDecimal)
                       
                End If
        End If
   End If

   If KeyCode = vbKeyF2 Or KeyCode = vbKeyReturn Then
      Call GRID_DblClick
   End If
End Sub

Private Sub Grid_KeyPress(KeyAscii As Integer)
    If Not IsNumeric(Chr(KeyAscii)) And UCase(Chr(KeyAscii)) < "A" And UCase(Chr(KeyAscii)) > "Z" And KeyAscii <> 13 And KeyAscii <> 8 Then
     KeyAscii = 0
    End If
End Sub

Private Sub Grid_LostFocus()
 If TxtDiasHasta.Visible = False And NumeroGrid.Visible = False Then
    GRID.Row = 0
 End If
End Sub

                
Private Sub NumeroGrid_KeyDown(KeyCode As Integer, Shift As Integer)
   Dim nContador1 As Integer
   
   If KeyCode = vbKeyReturn Then
      Let GRID.TextMatrix(GRID.RowSel, GRID.ColSel) = IIf(GRID.ColSel = 0, Format(NumeroGrid.Text, FEntero), Format(NumeroGrid.Text, FDecimal))
      Call Habilitacion(False, NumeroGrid)
      Call GRID.SetFocus
      
      With GRID
       For nContador1 = 1 To .Rows - 1
               If CDbl(.TextMatrix(nContador1, Cons_Margen)) > Format(1, FEntero) _
               Or CDbl(.TextMatrix(nContador1, Cons_Margen)) < Format(0, FEntero) Then
                 Call MsgBox(" Valores de Margen no puede ser mayor que 1 ni menor que 0, Revizar fila N° " & nContador1, vbInformation, App.Title)
                 .Row = nContador1
                 .Col = Cons_Margen
                 .SetFocus
                 NumeroGrid.Visible = True
                 NumeroGrid.SetFocus
                 Exit Sub
               End If
        Next nContador1
      End With
        
        
   End If
   If KeyCode = vbKeyEscape Then
      Call Habilitacion(False, NumeroGrid)
      Call GRID.SetFocus
   End If
   If KeyCode = 189 Then ' "-"
      KeyCode = 0
   End If
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Key
      
      Case "Eliminar"
            Call Eliminar
      
      Case "Limpiar"
            Call Limpiar
            Cmb_Familia.Enabled = True
            Cmb_TipoOpSoma.Enabled = True
          
         
      Case "Grabar"
            Call Grabar
      
      Case "Buscar"
            Call Buscar
            Cmb_Familia.Enabled = False
            Cmb_TipoOpSoma.Enabled = False
      Case "Salir"
             Unload Me
   End Select

End Sub

Private Sub Limpiar()
    Dim TotGrid As Integer
    Dim nContador As Long
    If GRID.Rows - 1 Then
        If MsgBox("¿ Esta seguro que desea limpiar, ¿Grabo la Información? ", vbQuestion + vbYesNo, App.Title) = vbNo Then
           Exit Sub
        End If
        TotGrid = GRID.Rows - 1
        For nContador = 1 To GRID.Rows - 1
            If TotGrid = nContador And nContador >= 1 Then
           
            Else
                If CDbl(GRID.TextMatrix(nContador + 1, Cons_PlazoDesde)) > CDbl(GRID.TextMatrix(nContador, Cons_PlazoHasta)) + 1 Then
                    Call MsgBox("Revizar Plazos " & "Dias Hasta Valor:" & CDbl(GRID.TextMatrix(nContador, Cons_PlazoHasta)), vbInformation, App.Title)
                    GRID.Col = Cons_PlazoHasta
                    GRID.Row = nContador
                    GRID.SetFocus
                    GRID.CellBackColor = vbRed
                    Exit Sub
                    
                End If
            End If
        Next nContador
     End If
    Call NombresGrilla
    TxtDiasHasta.Visible = False
    NumeroGrid.Visible = False
End Sub

Private Function ValidaContenidoGrilla()
   Dim nContador  As Long
   
   For nContador = 1 To GRID.Rows - 1
      GRID.TextMatrix(nContador, Cons_PlazoDesde) = Format(IIf(GRID.TextMatrix(nContador, Cons_PlazoDesde) = "", 0, CDbl(GRID.TextMatrix(nContador, Cons_PlazoDesde))), FEntero)
      GRID.TextMatrix(nContador, Cons_PlazoHasta) = Format(IIf(GRID.TextMatrix(nContador, Cons_PlazoHasta) = "", 0, CDbl(GRID.TextMatrix(nContador, Cons_PlazoHasta))), FEntero)
      GRID.TextMatrix(nContador, Cons_Margen) = Format(IIf(GRID.TextMatrix(nContador, Cons_Margen) = "", 0, CDbl(GRID.TextMatrix(nContador, Cons_Margen))), FDecimal)
   Next nContador
End Function

Private Sub Grabar()
   Dim nContador           As Long
   Dim nFamiliaInstrumento As Long
   Dim Datos()
   Dim ClasfRiesgo As String
   Dim oPasoValidacion     As Boolean
   Dim TotGrid As Integer
   Let oPasoValidacion = True
   
   
   If MsgBox("¿ Esta seguro que desea actualizar los valores. ? ", vbQuestion + vbYesNo, App.Title) = vbNo Then
      Exit Sub
   End If
   
    If GRID.Rows = 1 Then
                Call MsgBox("Debe Ingresar registro para Grabar.", vbInformation, App.Title)
                Exit Sub
    End If
    
    If Trim(GRID.TextMatrix(1, Cons_PlazoDesde)) = 0 And Trim(GRID.TextMatrix(1, Cons_PlazoHasta)) = 0 _
     And Trim(GRID.TextMatrix(1, Cons_Margen)) = 0# Then
     
            If MsgBox("¿Eliminara toda la información?", vbQuestion + vbYesNo, App.Title) = vbNo Then
            Exit Sub
            End If
    
    Else
           
           TotGrid = GRID.Rows - 1
           For nContador = 1 To GRID.Rows - 1
                If TotGrid = nContador And nContador >= 1 Then
                  
                Else
                    If CDbl(GRID.TextMatrix(nContador + 1, Cons_PlazoDesde)) > CDbl(GRID.TextMatrix(nContador, Cons_PlazoHasta)) + 1 Then
                        Call MsgBox("Revizar Plazos " & "Dias Hasta Valor:" & CDbl(GRID.TextMatrix(nContador, Cons_PlazoHasta)), vbInformation, App.Title)
                        GRID.Col = Cons_PlazoHasta
                        GRID.Row = nContador
                        GRID.SetFocus
                        GRID.CellBackColor = vbRed
                        Exit Sub
                    End If
                End If
            Next nContador
           
           For nContador = 1 To GRID.Rows - 1
              If GRID.TextMatrix(nContador, Cons_PlazoDesde) <> "" And GRID.TextMatrix(nContador, Cons_PlazoHasta) <> "" Then
                 If CDbl(GRID.TextMatrix(nContador, Cons_PlazoDesde)) > CDbl(GRID.TextMatrix(nContador, Cons_PlazoHasta)) Then
                    Let oPasoValidacion = False
                    Exit For
                 End If
'                 If CDbl(GRID.TextMatrix(nContador, Cons_PlazoDesde)) = CDbl(GRID.TextMatrix(nContador, Cons_PlazoHasta)) Then
'                    Let oPasoValidacion = False
'                    Exit For
'                 End If
              Else
                 Exit For
              End If
           Next nContador
           
           If oPasoValidacion = False Then
              Call MsgBox("Se han encontrado errores en la definicion de periodos... Favor Revisar antes de Continuar.", vbExclamation, App.Title)
              Call GRID.SetFocus
              Exit Sub
           End If
           
           With GRID
       For nContador = 1 To .Rows - 1
               If CDbl(.TextMatrix(nContador, Cons_Margen)) > Format(1, FEntero) _
               Or CDbl(.TextMatrix(nContador, Cons_Margen)) < Format(0, FEntero) Then
                 Call MsgBox(" Valores de Margen no puede ser mayor que 1 ni menor que 0, Revizar fila N° " & nContador, vbInformation, App.Title)
                 .Row = nContador
                 .Col = Cons_Margen
                 .SetFocus
                 Exit Sub
               End If
        Next nContador
      End With
           
           
           
           
           For nContador = 1 To GRID.Rows - 1
            If CDbl(GRID.TextMatrix(nContador, Cons_Margen)) = Format(0, FDecimal) Then
              'Call MsgBox("No puede grabar Margen en 0,000. Revizar fila N° " & nContador, vbInformation, App.Title)
              If MsgBox("Valores de Margen en  0,000. Revizar fila N° " & nContador & ", Desea Grabar? ", vbQuestion + vbYesNo, App.Title) = vbNo Then
                    
                    GRID.Col = Cons_Margen
                    GRID.Row = nContador
                    GRID.SetFocus
                    GRID.CellBackColor = vbRed
                    Exit Sub
                    
              End If
              
            End If
           Next nContador
    End If
    
'   If MsgBox("¿ Esta seguro que desea actualizar los valores. ? ", vbQuestion + vbYesNo, App.Title) = vbNo Then
'      Exit Sub
'   End If

   If Not ValidarDatos Then
      Exit Sub
   End If

   If Cmb_Familia.ListIndex = -1 Then
      Exit Sub
   End If
   Let nFamiliaInstrumento = Trim(Right(Cmb_Familia.Text, 10))
   
   Call ValidaContenidoGrilla
   
   If Not BacBeginTransaction() Then
      Call MsgBox("Error en inicio de transacción, no se puede iniciar la actualización de Margenes.", vbExclamation, App.Title)
      Exit Sub
   End If
  
   
   
   Screen.MousePointer = vbHourglass
   If Trim(Left(Cmb_Familia.Text, 10)) = "LH-AA" Then
          ClasfRiesgo = "AA"
   ElseIf Trim(Left(Cmb_Familia.Text, 10)) = "LH-A" Then
          ClasfRiesgo = "A"
   Else
          ClasfRiesgo = ""
   End If
    
   
    Envia = Array()
    AddParam Envia, Trim(Right(Cmb_Familia.Text, 10))                '->> Fecha de Margenes
    AddParam Envia, ClasfRiesgo                                     '->> Familia de Instrumentos
    AddParam Envia, Trim(Left(Me.Cmb_TipoOpSoma.Text, 10))

    If Not Bac_Sql_Execute("SP_DELMARGENSOMA", Envia) Then
       Let Screen.MousePointer = vbDefault
       Call MsgBox("Error en proceso." & vbCrLf & "No se ha podido iniciar la actualización de la Información.", vbExclamation, App.Title)
       Exit Sub
    End If
    
    If Trim(GRID.TextMatrix(1, Cons_PlazoDesde)) <> 0 And Trim(GRID.TextMatrix(1, Cons_PlazoHasta)) <> 0 Then
     
           For nContador = 1 To GRID.Rows - 1
                  Envia = Array()
                  AddParam Envia, "I"                                             '->> Indicador accion
                  AddParam Envia, Trim(Right(Cmb_Familia.Text, 10))                '->> Fecha de Margenes
                  AddParam Envia, ClasfRiesgo                                     '->> Familia de Instrumentos
                  AddParam Envia, CDbl(GRID.TextMatrix(nContador, Cons_PlazoDesde))       '->> Dias Desde
                  AddParam Envia, CDbl(GRID.TextMatrix(nContador, Cons_PlazoHasta))      '->> Dias Hasta
                  AddParam Envia, bacTranMontoSql(CDbl(GRID.TextMatrix(nContador, Cons_Margen)))        '->> Margen Asignado
                  AddParam Envia, Trim(Left(Me.Cmb_TipoOpSoma.Text, 10))
                  
                  If Not Bac_Sql_Execute("SP_MANTMARGINST", Envia) Then
                     Let Screen.MousePointer = vbDefault
                     Call BacRollBackTransaction
                     Call MsgBox("Error en la grabación." & vbCrLf & "Problemas al actualizar información de Margenes para Familia Instrumentos,", vbExclamation, App.Title)
                     Exit For
                  End If
            Next nContador
    End If
   If Not BacCommitTransaction() Then
      Call MsgBox("Error en la Confirmación de la Transacción." & vbCrLf & "Ha ocurrido un error en la confirmación de la Transacción.", vbExclamation, App.Title)
      Exit Sub
   End If
   
   Let Screen.MousePointer = vbDefault
   Call MsgBox("Actualización de Factores." & vbCrLf & "Se han actualizado correctamente los margenes para la familia de instrumentos.", vbInformation, App.Title)
    GRID.Rows = 1
    GRID.Rows = GRID.Rows + 1
    GRID.Row = GRID.Rows - 1
    GRID.TextMatrix(GRID.Row, Cons_PlazoDesde) = Format(0, FEntero)
    GRID.TextMatrix(GRID.Row, Cons_PlazoHasta) = Format(0, FEntero)
    GRID.TextMatrix(GRID.Row, Cons_Margen) = Format(0#, FDecimal)
    
    If Trim(GRID.TextMatrix(1, Cons_PlazoDesde)) <> 0 And Trim(GRID.TextMatrix(1, Cons_PlazoHasta)) <> 0 Then

        Toolbar1.Buttons("Grabar").Enabled = True
        Toolbar1.Buttons("Eliminar").Enabled = True
    Else
   
        Toolbar1.Buttons("Grabar").Enabled = False
        Toolbar1.Buttons("Eliminar").Enabled = False

    End If
End Sub

Private Function FMT_Number(Valor As Variant) As String
   Dim new_valor As String

   new_valor = Replace(Valor, ".", "")
   new_valor = Replace(new_valor, ",", ".")

   FMT_Number = new_valor
End Function

Private Sub AJObjeto(Marco As MSFlexGrid, Objeto As Control)
   On Error Resume Next

   Let Objeto.Top = Marco.CellTop + Marco.Top
   Let Objeto.Left = Marco.CellLeft + Marco.Left
   Let Objeto.Height = Marco.CellHeight + 20
   Let Objeto.Width = Marco.CellWidth

   On Error GoTo 0
End Sub

Private Sub Habilitacion(ByVal iVal_ As Boolean, iObjeto As Object)
   Let Toolbar1.Enabled = Not iVal_
   Let CuadroFecha.Enabled = Not iVal_
   Let GRID.Enabled = Not iVal_
   Let iObjeto.Visible = iVal_

   If iVal_ = True Then
      Call iObjeto.SetFocus
   Else
      Call GRID.SetFocus
   End If
End Sub

Private Sub Eliminar()
   
   If GRID.Rows = 1 Then
        Call MsgBox("Debe existir registro para eliminar.", vbInformation, App.Title)
        Exit Sub
   End If
  
   If Cmb_Familia.ListIndex = -1 Then
      Call MsgBox("Debe Seleccionar Familia de Instrumentos para Poder Eliminar Registros.", vbInformation, App.Title)
      Exit Sub
   End If
   
   If MsgBox("¿ Esta seguro que desea Eliminar Margen Familia Instrumentos? ", vbQuestion + vbYesNo, App.Title) = vbNo Then
      Exit Sub
   End If
   
   
   If GRID.Row = 0 Then
        Call MsgBox("Debe Seleccionar Familia de Instrumentos para Poder Eliminar Registros.", vbInformation, App.Title)
        Exit Sub
   Else
   
        If GRID.Rows > 2 Then
             GRID.RemoveItem GRID.Row
             
             If GRID.TextMatrix(1, Cons_PlazoDesde) <> 1 Then
                GRID.TextMatrix(1, Cons_PlazoDesde) = Format(1, FEntero)
             End If
             
             Call CargaDiasDesde(0)
        Else
             GRID.TextMatrix(GRID.Rows - 1, Cons_PlazoDesde) = Format(0, FEntero)
             GRID.TextMatrix(GRID.Rows - 1, Cons_PlazoHasta) = Format(0, FEntero)
             GRID.TextMatrix(GRID.Rows - 1, Cons_Margen) = Format(0, FDecimal)
                 
        End If
    
'        Envia = Array()
'        AddParam Envia, "E" ' Indicador accion
'        AddParam Envia, CDbl(Grid.TextMatrix(Grid.Row, Cons_CodInst))
'        AddParam Envia, Grid.TextMatrix(Grid.Row, Cons_ClasfRiesgo)
'        AddParam Envia, CDbl(Grid.TextMatrix(Grid.Row, Cons_PlazoDesde))
'        AddParam Envia, CDbl(Grid.TextMatrix(Grid.Row, Cons_PlazoHasta))
'        AddParam Envia, 0
'        AddParam Envia, Grid.TextMatrix(Grid.Row, Cons_TipoOpSoma)
'
'        If Not Bac_Sql_Execute("SP_MANTMARGINST", Envia) Then
'            Call MsgBox("Problemas al Borrar ", vbCritical, App.Title)
'        Else
'
'         Do While Bac_SQL_Fetch(Datos())
'             If (Datos(1)) = -1 Then
'                 Call MsgBox((Datos(2)), vbInformation, App.Title)
'                 Exit Sub
'             End If
'         Loop
'
'             Call GRID_KeyDown(vbKeyDelete, 0)
'             Screen.MousePointer = vbDefault
'             MsgBox "El registro ha sido eliminado con exito", vbInformation
'        End If
   End If
End Sub

Private Function FUNC_INIT_ROW() As Boolean
   Dim oValorAnterior   As Double
   Dim nContador As Integer
   Let FUNC_INIT_ROW = False
   
   
  
   Let GRID.Rows = GRID.Rows + 1
   Let GRID.Row = GRID.Rows - 1
    


   Let oValorAnterior = CDbl(GRID.TextMatrix(GRID.Rows - 2, Cons_PlazoHasta)) + 1
   Let GRID.TextMatrix(GRID.Rows - 1, Cons_PlazoDesde) = Format(oValorAnterior, FEntero)
   Let GRID.TextMatrix(GRID.Rows - 1, Cons_PlazoHasta) = Format(0, FEntero)
   Let GRID.TextMatrix(GRID.Rows - 1, Cons_Margen) = Format(0, FDecimal)

   Let FUNC_INIT_ROW = True
End Function

Private Function Buscar() As Boolean
   Dim Datos()
   Dim Codigo, Mensaje As String
   Dim ClasfRiesgo As String
   Dim lExisten        As Boolean
  
   If Trim(Left(Cmb_Familia.Text, 10)) = "LH-AA" Then
          ClasfRiesgo = "AA"
   ElseIf Trim(Left(Cmb_Familia.Text, 10)) = "LH-A" Then
          ClasfRiesgo = "A"
   Else
          ClasfRiesgo = ""
   End If
      
   Envia = Array()
   AddParam Envia, "C"
   AddParam Envia, Trim(Right(Cmb_Familia.Text, 10))
   AddParam Envia, ClasfRiesgo
   AddParam Envia, 0
   AddParam Envia, 0
   AddParam Envia, 0
   AddParam Envia, Trim(Left(Cmb_TipoOpSoma.Text, 10))
   
   If Not Bac_Sql_Execute("SP_MANTMARGINST", Envia) Then
      Call MsgBox("Problemas al Leer Margen por Instrumento", vbCritical, App.Title)
      Let Buscar = False
      Exit Function
   End If

   GRID.Rows = 1
   Do While Bac_SQL_Fetch(Datos())
      lExisten = True
      GRID.Rows = GRID.Rows + 1
      GRID.Row = GRID.Rows - 1
      
      If Datos(1) = "005" Then
         Codigo = Datos(1)
         Mensaje = Datos(2)
                         
         GRID.TextMatrix(GRID.Row, Cons_PlazoDesde) = Format(0, FEntero)
         GRID.TextMatrix(GRID.Row, Cons_PlazoHasta) = Format(0, FEntero)
         GRID.TextMatrix(GRID.Row, Cons_Margen) = Format(0#, FDecimal)
         Call Proc_CargaDatosOcultos
         Exit Do
      Else
         GRID.TextMatrix(GRID.Row, Cons_CodInst) = (Datos(1))
         GRID.TextMatrix(GRID.Row, Cons_ClasfRiesgo) = (Datos(2))
         GRID.TextMatrix(GRID.Row, Cons_PlazoDesde) = Format(Datos(3), FEntero)
         GRID.TextMatrix(GRID.Row, Cons_PlazoHasta) = Format(Datos(4), FEntero)
         GRID.TextMatrix(GRID.Row, Cons_Margen) = Format(Datos(5), FDecimal)
         GRID.TextMatrix(GRID.Row, Cons_TipoOpSoma) = (Datos(6))
       
      End If
      
   Loop

   If Codigo = "005" Then
      Call MsgBox(Trim(Mensaje), vbInformation, App.Title)
     
   End If
   
   If Trim(GRID.TextMatrix(1, Cons_PlazoDesde)) <> 0 And Trim(GRID.TextMatrix(1, Cons_PlazoHasta)) <> 0 Then

        Toolbar1.Buttons("Grabar").Enabled = True
        Toolbar1.Buttons("Eliminar").Enabled = True
   Else
   
        Toolbar1.Buttons("Grabar").Enabled = False
        Toolbar1.Buttons("Eliminar").Enabled = False

   End If
   
End Function

Private Sub TxtDiasHasta_KeyDown(KeyCode As Integer, Shift As Integer)
   Dim xValor  As Double
   Dim TotGrid As Integer
   If KeyCode = vbKeyBack Then
      If Len(TxtDiasHasta.Text) = 1 Then
         Let TxtDiasHasta.Text = Format(0, FEntero)
      End If
   End If

   If KeyCode = vbKeyReturn Then
      xValor = TxtDiasHasta.Text

      If xValor = 0 Then
         Call MsgBox("Es necesario, que ingrese un valor mayor al dato anterior.", vbInformation, App.Title)
         TxtDiasHasta.SetFocus
         Exit Sub
      End If
    
    TotGrid = GRID.Rows - 1
    If TotGrid = GRID.Row Then
      
    Else
        If CDbl(GRID.TextMatrix(GRID.Row + 1, Cons_PlazoDesde)) <= CDbl(TxtDiasHasta.Text) Then
                  Call MsgBox("Dias desde siguiente fila, no puede ser menor o igual que Dias Hasta.", vbInformation, App.Title)
                  TxtDiasHasta.SetFocus
                  Exit Sub
        End If
    End If

    If ValDiasDesde Then
      
      
    Let GRID.TextMatrix(GRID.RowSel, GRID.ColSel) = Format(TxtDiasHasta.Text, FEntero)
         
    TotGrid = GRID.Rows - 1
    
        If TotGrid = GRID.Row And GRID.Rows - 1 >= 1 Then
          
          Else
            If CDbl(GRID.TextMatrix(GRID.Row + 1, Cons_PlazoDesde)) >= CDbl(TxtDiasHasta.Text) + 1 Then
                 GRID.TextMatrix(GRID.Row + 1, Cons_PlazoDesde) = CDbl(TxtDiasHasta.Text) + 1
            End If
        End If
    
    
         Call Habilitacion(False, TxtDiasHasta)
         
         Call GRID.SetFocus
      End If

   End If
   If KeyCode = vbKeyEscape Then
      Call Habilitacion(False, TxtDiasHasta)
      Call GRID.SetFocus
   End If
   Toolbar1.Buttons("Grabar").Enabled = True
   Toolbar1.Buttons("Eliminar").Enabled = True
   
End Sub

Private Function ValDiasDesde() As Boolean
   Dim var_hasta As Long
   Dim nContador As Integer
   Dim nContador2 As Integer
   ValDiasDesde = True
   
   If GRID.Rows = 2 Then
      If GRID.Row = 1 Then
         GRID.TextMatrix(1, Cons_PlazoDesde) = "1"
      End If
   Else
      
      var_hasta = TxtDiasHasta.Text
      
      If GRID.Rows - 1 = GRID.Row Then
         If var_hasta > GRID.TextMatrix(GRID.Row - 1, Cons_PlazoHasta) Then
            Call CargaDiasDesde(1)
         Else
            ValDiasDesde = False
            Call MsgBox("Debe Ingresar un Rango Mayor al anterior.", vbInformation, App.Title)
            TxtDiasHasta.SetFocus
         End If
      Else
         If GRID.Row = 1 Then
            If var_hasta < GRID.TextMatrix(GRID.Row + 1, Cons_PlazoHasta) Then
               Call CargaDiasDesde(1)
            Else
               ValDiasDesde = False
               Call MsgBox("Debe Ingresar un Rango Menor al siguiente.", vbInformation, App.Title)
               TxtDiasHasta.SetFocus
            End If
         Else
            If var_hasta > GRID.TextMatrix(GRID.Row - 1, Cons_PlazoHasta) And var_hasta < GRID.TextMatrix(GRID.Row + 1, Cons_PlazoHasta) Then
               Call CargaDiasDesde(1)
            Else
               ValDiasDesde = False
               Call MsgBox("Debe Ingresar un Rango menor al siguiente y uno mayor al anterior.", vbInformation, App.Title)
               TxtDiasHasta.SetFocus
            End If
         End If
      End If
  
  
   End If
    
End Function

Private Sub CargaDiasDesde(ind_mod As Integer)
   Dim var_ind          As Long
   Dim var_row, var_col As Long

Exit Sub

   var_row = GRID.Row
   var_col = GRID.Col

   If ind_mod = 1 Then
      GRID.TextMatrix(GRID.Row, Cons_PlazoHasta) = TxtDiasHasta.Text
   End If

   For var_ind = 1 To GRID.Rows - 1
      If var_ind = 1 Then
         GRID.TextMatrix(var_ind, Cons_PlazoDesde) = "1"
         GRID.TextMatrix(1, Cons_PlazoDesde) = "1"
      Else
         If Trim(GRID.TextMatrix(GRID.Row, Cons_PlazoHasta)) <> "" Then
           'Grid.TextMatrix(var_ind, COLDIAD) = Format(Str(Val(Replace(Grid.TextMatrix(var_ind - 1, COLDIAH), ".", "")) + 1), FEntero)
            GRID.TextMatrix(var_ind, Cons_PlazoDesde) = Format(GRID.TextMatrix(var_ind - 1, Cons_PlazoHasta), FEntero)
         End If
      End If
   Next var_ind
   GRID.Row = var_row
   GRID.Col = var_col
End Sub

Private Function ValidarDatos() As Boolean
   Dim var_ind As Long

   ValidarDatos = True
   If GRID.Rows = 1 Then
      ValidarDatos = False
      Call MsgBox("Debe Seleccionar Familia de Instrumentos y completar Datos para Poder Grabar Registros.", vbExclamation, App.Title)
   Else
      For var_ind = 1 To GRID.Rows - 1
         If Trim(GRID.TextMatrix(var_ind, Cons_PlazoDesde)) = "" Or Trim(GRID.TextMatrix(var_ind, Cons_PlazoHasta)) = "" Or Trim(GRID.TextMatrix(var_ind, Cons_Margen)) = "" Or Cmb_Familia.ListIndex = -1 Then
            ValidarDatos = False
            Call MsgBox("Debe Completar Datos Para Poder Grabar Registros.", vbExclamation, App.Title)
            Exit For
         End If
      Next var_ind
   End If
End Function

Private Function PuedeInsertarFila() As Boolean
   Dim nContador As Long

   Let PuedeInsertarFila = True

   For nContador = 1 To GRID.Rows - 1
      If Len(GRID.TextMatrix(nContador, Cons_PlazoDesde)) = 0 Then
         PuedeInsertarFila = False
         Exit For
      End If
   Next nContador

End Function

