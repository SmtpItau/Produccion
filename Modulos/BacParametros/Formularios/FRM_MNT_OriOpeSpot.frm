VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form FRM_MNT_OriOpeSpot 
   Caption         =   "Form2"
   ClientHeight    =   4335
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   7335
   LinkTopic       =   "Form2"
   MDIChild        =   -1  'True
   ScaleHeight     =   4335
   ScaleWidth      =   7335
   Begin MSFlexGridLib.MSFlexGrid GridAux 
      Height          =   2295
      Left            =   480
      TabIndex        =   7
      Top             =   5040
      Width           =   4575
      _ExtentX        =   8070
      _ExtentY        =   4048
      _Version        =   393216
      Cols            =   3
      FixedCols       =   0
   End
   Begin Threed.SSFrame SSFrame1 
      Height          =   3495
      Left            =   120
      TabIndex        =   1
      Top             =   720
      Width           =   7095
      _Version        =   65536
      _ExtentX        =   12515
      _ExtentY        =   6165
      _StockProps     =   14
      Caption         =   " Origen de Operaciones Spot "
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin VB.ComboBox Combo_Auto 
         Height          =   315
         Left            =   3840
         Style           =   2  'Dropdown List
         TabIndex        =   8
         Top             =   1680
         Width           =   855
      End
      Begin VB.PictureBox ConCheck 
         BorderStyle     =   0  'None
         Height          =   285
         Index           =   0
         Left            =   1395
         Picture         =   "FRM_MNT_OriOpeSpot.frx":0000
         ScaleHeight     =   285
         ScaleWidth      =   315
         TabIndex        =   6
         Top             =   1440
         Visible         =   0   'False
         Width           =   315
      End
      Begin VB.PictureBox SinCheck 
         BorderStyle     =   0  'None
         Height          =   285
         Index           =   0
         Left            =   1080
         Picture         =   "FRM_MNT_OriOpeSpot.frx":015A
         ScaleHeight     =   285
         ScaleWidth      =   315
         TabIndex        =   5
         Top             =   1440
         Visible         =   0   'False
         Width           =   315
      End
      Begin VB.TextBox Txt_Des 
         Height          =   375
         Left            =   3360
         MaxLength       =   30
         TabIndex        =   4
         Text            =   "Txt_Des"
         Top             =   2520
         Width           =   1935
      End
      Begin VB.TextBox Txt_Cod 
         Height          =   375
         Left            =   1320
         MaxLength       =   10
         TabIndex        =   3
         Text            =   "Txt_Cod"
         Top             =   2520
         Width           =   1575
      End
      Begin MSFlexGridLib.MSFlexGrid Grid 
         Height          =   2895
         Left            =   240
         TabIndex        =   2
         Top             =   360
         Width           =   6615
         _ExtentX        =   11668
         _ExtentY        =   5106
         _Version        =   393216
         Cols            =   3
         FixedCols       =   0
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   7335
      _ExtentX        =   12938
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Grabar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Eliminar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   6720
         Top             =   120
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   3
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_OriOpeSpot.frx":02B4
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_OriOpeSpot.frx":0706
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_OriOpeSpot.frx":0A20
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
End
Attribute VB_Name = "FRM_MNT_OriOpeSpot"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim var_Fila As Long
Dim ModData As Boolean
Const COL_CHECK = 0
Const COL_COD = 1
Const COL_DES = 2
Const COL_MOD = 3
Const COL_DEF = 4
Const COL_IDX = 5

Private Sub Combo_Auto_Click()
    Grid.TextMatrix(Grid.Row, Grid.Col) = Combo_Auto.Text
    ModData = True

End Sub

Private Sub Combo_Auto_KeyDown(KeyCode As Integer, Shift As Integer)
   Key = KeyCode
   
   If KeyCode = 13 Then
      Combo_Auto_Click
      Me.Combo_Auto.Visible = False
      ModData = True
      
   ElseIf KeyCode = 27 Then
      Me.Grid.SetFocus
      Me.Combo_Auto.Visible = False
   End If

End Sub

Private Sub Combo_Auto_LostFocus()
    Combo_Auto.Visible = False

End Sub

Private Sub Form_Load()

Me.Icon = BACSwapParametros.Icon
Me.Caption = "Mantenedor de Origen de Operación Spot"

Height = 4845
Left = 0
Top = 0
Width = 7455 '6480

'FormatoGrilla
Call CargaGrilla
''Modifica Data, Indica si existe modificacion si es asi Graba en Forma Directo
ModData = False
Txt_Cod.Visible = False
Txt_Des.Visible = False
Combo_Auto.Visible = False

    Combo_Auto.Clear
    Combo_Auto.AddItem "N"
    Combo_Auto.ItemData(Combo_Auto.ListCount - 1) = 0
    Combo_Auto.AddItem "S"
    Combo_Auto.ItemData(Combo_Auto.ListCount - 1) = 1

End Sub
Function FormatoGrilla()
    
    With Grid
        .Cols = 6
        .Rows = 2
        
        .RowHeightMin = 315
        .Rows = 2
        .FocusRect = flexFocusHeavy
        
        .TextMatrix(0, COL_CHECK) = ""
        .TextMatrix(0, COL_COD) = "Código"
        .TextMatrix(0, COL_DES) = "Descripción"
        .TextMatrix(0, COL_MOD) = "Automático"
        .TextMatrix(0, COL_DEF) = ""
        .TextMatrix(0, COL_IDX) = ""
        
        .ColWidth(COL_CHECK) = 250
        .ColWidth(COL_COD) = 1500
        .ColWidth(COL_DES) = 3500
        .ColWidth(COL_MOD) = 900
        .ColWidth(COL_DEF) = 0
        .ColWidth(COL_IDX) = 0
        
        Set .CellPicture = SinCheck(0).Picture
    End With

End Function

Private Function CargaGrilla() As Boolean
 Dim DATOS()
Dim MiCheck As Object
Dim paso_1 As Boolean
paso_1 = True
 
 CargaGrilla = True
 Grid.Redraw = False
 
 FormatoGrilla
 
 Envia = Array()
  
 If Not Bac_Sql_Execute("SP_LEERORIOPESPOT", Envia) Then
      MsgBox "Problemas al Leer Origen de Operación Spot", vbCritical, TITSISTEMA
      'Call LogAuditoria("09", OptLocal, Me.Caption & " Problemas al Leer Asociación de Curvas", "", "")

      CargaGrilla = False
      Exit Function
 End If

'Set MiCheck = CreateObject("VB.CheckBox")
With Grid
    .Rows = 1
    Do While Bac_SQL_Fetch(DATOS())
       lExisten = True
       .Rows = .Rows + 1
       .Row = .Rows - 1
        .TextMatrix(.Row, COL_CHECK) = ""
        .TextMatrix(.Row, COL_COD) = DATOS(3)
        .TextMatrix(.Row, COL_DES) = DATOS(2)
        If DATOS(4) = 1 Then
            .TextMatrix(.Row, COL_MOD) = "S"
            .TextMatrix(.Row, COL_DEF) = "X"
        Else
            .TextMatrix(.Row, COL_MOD) = "N"
            .TextMatrix(.Row, COL_DEF) = ""
        End If
        .TextMatrix(.Row, COL_IDX) = DATOS(1)
        Set .CellPicture = SinCheck(0).Picture
    Loop
    .Redraw = True
    .Rows = .Rows + 1
End With


End Function

Private Sub Grid_Click()
    Txt_Cod.Visible = False
    Txt_Des.Visible = False
    Combo_Auto.Visible = False
    
    With Grid
    If (.TextMatrix(.Row, COL_DEF) = "" And .TextMatrix(.Row, COL_IDX) <> "1") Then
        Select Case .Col
            Case COL_CHECK
                If .CellPicture = ConCheck(0).Picture Then
                    Set .CellPicture = SinCheck(0).Picture
                Else
                    Set .CellPicture = ConCheck(0).Picture
                End If
        End Select
    End If
    End With

End Sub

Private Sub Grid_DblClick()
    Select Case Grid.Col
        Case COL_COD
        If Grid.TextMatrix(Grid.Row, COL_DEF) = "" And Grid.TextMatrix(Grid.Row, COL_IDX) <> "1" Then

            Txt_Cod.Visible = True
            Txt_Des.Visible = False
            Combo_Auto.Visible = False
            Txt_Cod.Text = Grid.TextMatrix(Grid.Row, COL_COD)
            var_Fila = Grid.Row
            
            Txt_Cod.SelStart = 0
            Txt_Cod.SelLength = Txt_Cod.MaxLength
            Txt_Cod.SetFocus
            
            'Call PROC_POSICIONA_TEXTO(Grid, Txt_Cod)
            PROC_POSICIONA_TEXTOX Grid, Txt_Cod
        End If
        Case COL_DES
            Txt_Cod.Visible = False
            Txt_Des.Visible = True
            Combo_Auto.Visible = False
            Txt_Des.Text = Grid.TextMatrix(Grid.Row, COL_DES)
            
            Txt_Des.SelStart = 0
            Txt_Des.SelLength = Txt_Des.MaxLength
            Txt_Des.SetFocus
            
            'Call PROC_POSICIONA_TEXTO(Grid, Txt_Des)
            PROC_POSICIONA_TEXTOX Grid, Txt_Des
    
        Case COL_MOD
        If Grid.TextMatrix(Grid.Row, COL_DEF) = "" Then
            Txt_Cod.Visible = False
            Txt_Des.Visible = False
            Combo_Auto.Visible = True
            Call bacBuscarCombo(Combo_Auto, Grid.TextMatrix(Grid.Row, COL_MOD))
            'Combo_Auto.Text = Grid.TextMatrix(Grid.Row, COL_MOD)
            
            'Txt_Des.SelStart = 0
            'Txt_Des.SelLength = Txt_Des.MaxLength
            Combo_Auto.SetFocus
            
            Call PROC_POSICIONA_TEXTO(Grid, Combo_Auto)
            'PROC_POSICIONA_TEXTOX Grid, Combo_Auto
        End If
    
    End Select

End Sub

Private Sub Grid_KeyDown(KeyCode As Integer, Shift As Integer)
    
    Select Case KeyCode
        Case vbKeyInsert
            FUNC_INIT_ROW
        Case vbKeyDelete
            If Grid.Row > 1 And Grid.TextMatrix(Grid.Row, COL_COD) = "" Then Grid.RemoveItem Grid.Row
        Case vbKeyF2
            Grid_DblClick
    End Select

End Sub

Private Sub Grid_LostFocus()
   Col = 0
   Fil = Grid.Row
   Col = Grid.Col
   FilaAnt = Grid.Row

End Sub
Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Key
Case "Grabar"
    'If ValCampos(Grid) Then
        'Call OrdenarGrilla
        If ModData Then
            Call cmdGrabar
            ModData = False
        Else
            MsgBox "No se Han Realizado Cambios en la Data.", vbExclamation, TITSISTEMA
        End If
    'End If

Case "Eliminar"
    If ExistTicketElim Then
        If MsgBox("¿ Esta seguro de Eliminar ? ", vbQuestion + vbYesNo, gsBac_Version) = vbYes Then
            Call LimpiarGrilla
            Call cmdGrabar
        End If
    Else
        MsgBox "Para Eliminar Debe por lo menos Seleccionar un Registro", vbExclamation, TITSISTEMA
    End If

Case "Salir"
    Unload Me
End Select

End Sub

Private Sub Txt_Cod_KeyDown(KeyCode As Integer, Shift As Integer)
    
    If KeyCode = 13 Then
        If Not ValLlave(Grid, var_Fila) Then
            Txt_Cod.Visible = False
            Grid.TextMatrix(var_Fila, COL_COD) = Txt_Cod.Text
            Grid.Col = COL_COD
            Grid.Row = var_Fila
            ModData = True
        End If
    ElseIf KeyCode = 27 Then
        Grid.SetFocus
        Txt_Cod.Visible = False
    End If

End Sub

Private Sub Txt_Cod_KeyPress(KeyAscii As Integer)
    KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub

Private Sub Txt_Des_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = 13 Then
        Txt_Des.Visible = False
        Grid.TextMatrix(Grid.Row, COL_DES) = Txt_Des.Text
        ModData = True
    ElseIf KeyCode = 27 Then
        Grid.SetFocus
        Txt_Des.Visible = False
    End If

End Sub

Private Sub Txt_Des_KeyPress(KeyAscii As Integer)
    KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub
Private Function FUNC_INIT_ROW() As Boolean
  Dim i As Integer
    
  FUNC_INIT_ROW = False
  
  With Grid
    .Rows = .Rows + 1
    .Row = .Rows - 1

  End With
  
  FUNC_INIT_ROW = True
End Function

Private Sub cmdGrabar()
    Dim lExito      As Boolean
    Dim Sqlbca      As String
    Dim DATOS()
    Dim var_ind As Long
    Dim var_auto As Integer
    
    
    'Inicia la Transacción
    If Not BacBeginTransaction() Then
        MsgBox "No Pudo Iniciar Transacción ", vbCritical, TITSISTEMA
        Exit Sub
    End If
    
    Screen.MousePointer = 11
    
    Envia = Array()

    If Not Bac_Sql_Execute("SP_BORRARORIOPESPOT", Envia) Then
        MsgBox "Problemas Borrar Origen de Operación Spot", vbCritical, TITSISTEMA
        'Call LogAuditoria("03", OptLocal, Me.Caption & " Problemas al Eliminar Paridades Existentes", Valor_Antiguo, Valor_Nuevo)
        Exit Sub
    End If
         
    'Call Refrescar(0, True)
    lExito = True


    Grid.Col = 0
    var_ind = 1
    For var_ind = 1 To Grid.Rows - 1
        Sql = ""
        Grid.Col = 0
        Grid.Row = var_ind
        
        If Grid.TextMatrix(var_ind, COL_COD) <> "" Then
            Envia = Array()
            AddParam Envia, var_ind ' Correlativo
            AddParam Envia, Grid.TextMatrix(var_ind, COL_DES) 'Descripcion
            AddParam Envia, Grid.TextMatrix(var_ind, COL_COD) 'Codigo
            If Grid.TextMatrix(var_ind, COL_MOD) = "S" Then
                var_auto = 1
            Else
                var_auto = 0
            End If
            AddParam Envia, var_auto 'Automatico
    
            If Not Bac_Sql_Execute("SP_GRABARORIOPESPOT", Envia) Then
                     
                   lExito = False
                     If BacRollBackTransaction() Then
                   End If
                   
                   MsgBox "Problemas al Grabar Origen de Operación Spot", vbCritical, TITSISTEMA
                   'Call LogAuditoria("01", OptLocal, Me.Caption & " Error al Grabar Asociación de Curvas", "", Valor_Nuevo)
                   Exit For
            Else
                lExito = True
            End If
        End If
            
    Next var_ind

    Screen.MousePointer = 0
    
    If lExito Then 'No Tuvo Ningún Problema al Grabar y asegura los registros
        If BacCommitTransaction() Then
            MsgBox "Grabación se Realizó con Exito", vbInformation, TITSISTEMA
        End If
    End If
    
    Call CargaGrilla
    
    
End Sub

Private Function ValCampos(ByVal grilla As MSFlexGrid) As Boolean
    Dim var_ind As Long

    ValCampos = True

    For var_ind = 1 To grilla.Rows - 1
        grilla.Col = 0
        grilla.Row = var_ind
        
        If (Trim(grilla.TextMatrix(var_ind, COL_COD)) = "" Or _
            Trim(grilla.TextMatrix(var_ind, COL_DES)) = "") Then
                MsgBox "La Fila " & var_ind & " le Faltan Datos por Completar ", vbInformation, "Informacion"
                Grid.Col = COL_COD
                Grid.Row = var_ind
                Grid.SetFocus
                ValCampos = False
                Exit Function
        End If
    Next var_ind

End Function


Private Function ValLlave(ByVal grilla As MSFlexGrid, ByVal FilaSel As Long) As Boolean
    Dim var_ind As Long
    Dim var_cod As String

    ValLlave = False
    var_cod = Txt_Cod.Text  'Codigo de Producto

    For var_ind = 1 To grilla.Rows - 1
        grilla.Col = 0
        grilla.Row = var_ind
        
        If FilaSel <> var_ind Then
            If Trim(var_cod) = Trim(grilla.TextMatrix(var_ind, COL_COD)) Then
                MsgBox "El Registro < Codigo >" & Chr(13) & "  YA FUE INGRESADO", vbInformation, "Informacion"
                ValLlave = True
                Exit Function
            End If
        End If
    Next var_ind

End Function
Private Sub LimpiarGrilla()
    Dim DATOS()
    Dim var_ind, var_ind_aux As Long
    
    GridAux.Cols = 6
    GridAux.Rows = 2
    Grid.Col = 0
    var_ind = 0
    var_ind_aux = 0
    For var_ind = 0 To Grid.Rows - 1
        Sql = ""
        Grid.Col = 0
        Grid.Row = var_ind
        
        If ValGrid(Grid, var_ind) Then
            If Grid.CellPicture = SinCheck(0).Picture Then
                'GridAux.Col = 0
                'GridAux.Row = var_ind_aux
                
                GridAux.Rows = var_ind_aux + 1
                
                GridAux.TextMatrix(var_ind_aux, COL_CHECK) = Grid.TextMatrix(var_ind, COL_CHECK) 'Check
                GridAux.TextMatrix(var_ind_aux, COL_COD) = Grid.TextMatrix(var_ind, COL_COD) 'Codigo
                GridAux.TextMatrix(var_ind_aux, COL_DES) = Grid.TextMatrix(var_ind, COL_DES) 'Descripcion
                GridAux.TextMatrix(var_ind_aux, COL_MOD) = Grid.TextMatrix(var_ind, COL_MOD) 'Automatico
                GridAux.TextMatrix(var_ind_aux, COL_DEF) = Grid.TextMatrix(var_ind, COL_DEF) 'indica que no se puede modificar automatico
                GridAux.TextMatrix(var_ind_aux, COL_IDX) = Grid.TextMatrix(var_ind, COL_IDX) 'Codigo Correlativo
                var_ind_aux = var_ind_aux + 1
            End If
        End If
            
    Next var_ind

    Screen.MousePointer = 0
    
    For var_ind = 0 To GridAux.Rows - 1
        Sql = ""
        
        GridAux.Col = 0
        GridAux.Row = var_ind
        
        var_ind_aux = var_ind + 1
        Grid.Rows = var_ind_aux + 1
        
        Grid.TextMatrix(var_ind_aux, COL_CHECK) = GridAux.TextMatrix(var_ind, COL_CHECK) 'Check
        Grid.TextMatrix(var_ind_aux, COL_COD) = GridAux.TextMatrix(var_ind, COL_COD) 'Codigo
        Grid.TextMatrix(var_ind_aux, COL_DES) = GridAux.TextMatrix(var_ind, COL_DES) 'Descripcion
        Grid.TextMatrix(var_ind_aux, COL_MOD) = GridAux.TextMatrix(var_ind, COL_MOD) 'Automatico
        Grid.TextMatrix(var_ind_aux, COL_DEF) = GridAux.TextMatrix(var_ind, COL_DEF) 'indica que no se puede modificar automatico
        Grid.TextMatrix(var_ind_aux, COL_IDX) = GridAux.TextMatrix(var_ind, COL_IDX) 'Codigo Correlativo
        
        Set Grid.CellPicture = Nothing
        'Set Grid.CellPicture = SinCheck(0).Picture
            
    Next var_ind
    
    'Call CargaGrilla
    
    
End Sub

Private Function ValGrid(ByVal grilla As MSFlexGrid, ByVal Ind As Long) As Boolean

    If (grilla.TextMatrix(Ind, COL_COD) = "" And grilla.TextMatrix(Ind, COL_DES) = "") Then
        ValGrid = False
    Else
        ValGrid = True
    End If
    'Grilla.mos
End Function
Private Function ExistTicketElim() As Boolean
    Dim var_ind As Long
    
    Grid.Col = 0
    var_ind = 0
    ExistTicketElim = False
    For var_ind = 0 To Grid.Rows - 1
        Sql = ""
        Grid.Col = 0
        Grid.Row = var_ind
        If Grid.CellPicture = ConCheck(0).Picture Then
            ExistTicketElim = True
            Exit For
        End If
    Next var_ind

End Function
