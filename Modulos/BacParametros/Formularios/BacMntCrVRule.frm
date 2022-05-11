VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form BacMntCrVRule 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantención de Cartera VolckerRule"
   ClientHeight    =   4455
   ClientLeft      =   105
   ClientTop       =   435
   ClientWidth     =   5070
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   4455
   ScaleWidth      =   5070
   Begin VB.TextBox txtIngreso 
      BackColor       =   &H00800000&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   330
      Left            =   6855
      TabIndex        =   0
      Top             =   3330
      Visible         =   0   'False
      Width           =   1125
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   1
      Top             =   0
      Width           =   5070
      _ExtentX        =   8943
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Grabar"
            Description     =   "Grabar"
            Object.ToolTipText     =   "Grabar Carteras"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Eliminar"
            Description     =   "Eliminar"
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Limpiar"
            Description     =   "Limpiar"
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Description     =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   4
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin Threed.SSFrame Frame 
      Height          =   1035
      Index           =   0
      Left            =   15
      TabIndex        =   2
      Top             =   495
      Width           =   5025
      _Version        =   65536
      _ExtentX        =   8864
      _ExtentY        =   1826
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
      Begin VB.ComboBox CmbTablaCartera 
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
         Height          =   315
         ItemData        =   "BacMntCrVRule.frx":0000
         Left            =   1320
         List            =   "BacMntCrVRule.frx":0002
         Style           =   2  'Dropdown List
         TabIndex        =   4
         Top             =   570
         Width           =   3300
      End
      Begin VB.ComboBox cmbSistema 
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
         Height          =   315
         ItemData        =   "BacMntCrVRule.frx":0004
         Left            =   1335
         List            =   "BacMntCrVRule.frx":0006
         Style           =   2  'Dropdown List
         TabIndex        =   3
         Top             =   165
         Width           =   3300
      End
      Begin VB.Label Label1 
         Caption         =   "Producto"
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
         Left            =   435
         TabIndex        =   6
         Top             =   630
         Width           =   840
      End
      Begin VB.Label Label2 
         Caption         =   "Sistema"
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
         Left            =   435
         TabIndex        =   5
         Top             =   225
         Width           =   840
      End
   End
   Begin Threed.SSFrame Frame 
      Height          =   2970
      Index           =   1
      Left            =   15
      TabIndex        =   7
      Top             =   1470
      Width           =   5010
      _Version        =   65536
      _ExtentX        =   8837
      _ExtentY        =   5239
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
      Begin VB.ComboBox CmbCartera 
         Height          =   315
         Left            =   2280
         Style           =   2  'Dropdown List
         TabIndex        =   8
         Top             =   2490
         Visible         =   0   'False
         Width           =   2595
      End
      Begin MSFlexGridLib.MSFlexGrid Table1 
         Height          =   2745
         Left            =   45
         TabIndex        =   9
         Top             =   150
         Width           =   4905
         _ExtentX        =   8652
         _ExtentY        =   4842
         _Version        =   393216
         FixedCols       =   0
         RowHeightMin    =   315
         BackColor       =   -2147483644
         ForeColor       =   12582912
         BackColorFixed  =   8421376
         ForeColorFixed  =   16777215
         BackColorBkg    =   -2147483645
         GridColor       =   16777215
         GridColorFixed  =   16777215
         FocusRect       =   0
         HighLight       =   2
         GridLines       =   2
         GridLinesFixed  =   0
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
   End
   Begin Threed.SSFrame Frame 
      Height          =   2025
      Index           =   3
      Left            =   6585
      TabIndex        =   10
      Top             =   1095
      Visible         =   0   'False
      Width           =   2730
      _Version        =   65536
      _ExtentX        =   4815
      _ExtentY        =   3572
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
      ShadowStyle     =   1
      Begin VB.PictureBox Grid1 
         BackColor       =   &H00FFFFFF&
         Height          =   780
         Left            =   375
         ScaleHeight     =   720
         ScaleWidth      =   2100
         TabIndex        =   11
         Top             =   255
         Width           =   2160
      End
      Begin VB.Label Label 
         BackColor       =   &H00FFFFFF&
         Caption         =   "Label(1)"
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   1
         Left            =   420
         TabIndex        =   13
         Top             =   1545
         Width           =   1860
      End
      Begin VB.Label Label 
         BackColor       =   &H00800000&
         Caption         =   "Label(0)"
         ForeColor       =   &H00FFFFFF&
         Height          =   285
         Index           =   0
         Left            =   420
         TabIndex        =   12
         Top             =   1200
         Width           =   1860
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   5160
      Top             =   600
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
            Picture         =   "BacMntCrVRule.frx":0008
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntCrVRule.frx":045A
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntCrVRule.frx":08AC
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntCrVRule.frx":0BC6
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "BacMntCrVRule"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private objcodtab       As Object
Private ObjCartera      As Object

'CONSTANTES DE COLUMNA DE LA GRILLA
Const nCol_Codigo = 0
Const ncol_Descripcion = 1

'CONSTANTE DE LA FILA CABECERA
Const nFila_Cabecera = 0

'CONSTANTES DE BOTONES DE LA TOOLBAR
Const Btn_Grabar = 1
Const Btn_Eliminar = 2
Const Btn_Limpiar = 3
Const Btn_Salir = 4

'CONSTANTE DE RETORNO DE sp_btr_sistemas_activos
Const nSis_Codigo = 1
Const nSis_Descripcion = 2

'CONSTANTE DE RETORNO DE SP_BACMNTCR_BUSCAPRODUCTO
Const nPro_Codigo = 1
Const nPro_Descripcion = 2

'CONSTANTE DE RETORNO DE sp_mdrcleercodigo
Const nCar_Codigo = 1
Const nCar_Descripcion = 2

'CONSTANTE DE RETORNO DE SP_CON_INFO_COMBO
Const nCartera_Codigo = 2
Const nCartera_Descripcion = 6
Sub Dibuja_Grilla()
'   Table1.TextMatrix(0, 0) = ""
   Table1.TextMatrix(0, nCol_Codigo) = "Codigo"
   Table1.TextMatrix(0, ncol_Descripcion) = "Glosa"
   
   Table1.RowHeight(nFila_Cabecera) = 315
   
   'Table1.ColWidth(0) = 1000
   Table1.ColWidth(nCol_Codigo) = 0
   Table1.ColWidth(ncol_Descripcion) = 4600
   
   Table1.ColAlignment(nCol_Codigo) = 4
   Table1.ColAlignment(ncol_Descripcion) = 1
End Sub

Function Valida_Datos() As Boolean
Dim I As Integer
Valida_Datos = False
With Table1

For I = 1 To .Rows - 1
    
   Envia = Array()
   AddParam Envia, Right(cmbSistema.Text, 3)
   AddParam Envia, Trim(Mid(CmbTablaCartera.Text, Len(CmbTablaCartera.Text) - 7, 5))
   AddParam Envia, CDbl(.TextMatrix(I, 1))
   AddParam Envia, RTrim(.TextMatrix(I, 2))
      If Not Bac_Sql_Execute("dbo.sp_Valida_Cartera_Sistema", Envia) Then
         Exit Function
      End If
      
      If Bac_SQL_Fetch(Datos()) = True Then
         If Datos(1) <> 0 Then
            If Datos(1) = -2 Then
                MsgBox "Cartera " & RTrim(.TextMatrix(I, 2)) & "," & Chr(10) & Datos(2) & Chr(10) & "Para el Sistema de " & LTrim(Left(cmbSistema.Text, 30)), vbExclamation
                Exit Function
            ElseIf Datos(1) = -1 Then
                MsgBox "Cartera " & RTrim(.TextMatrix(I, 2)) & "," & Chr(10) & Datos(2) & Chr(10) & "Para el Sistema de " & LTrim(Left(cmbSistema.Text, 30)), vbExclamation
                Exit Function
            Else
            End If
         End If
      End If

Next I

End With

Valida_Datos = True

End Function

Private Function ValidaGrilla() As Integer
   Dim Filas As Integer

   ValidaGrilla = False
   For Filas = 1 To Table1.Rows - 1
      Table1.Row = Filas
      ' Columna rut
      Table1.Col = 1
      If Val(Table1.Text) <= 0 Then
         MsgBox "Falta ingresar Código cartera", 16, TITSISTEMA
         Exit Function
      End If
      ' Columna nombre
      Table1.Col = 2
      If Table1.Text = "" Then
         MsgBox "Falta ingresar nombre cartera", 16, TITSISTEMA
         Exit Function
      End If
   Next Filas
   
   If Valida_Datos() = False Then
        Exit Function
   End If
   
   ValidaGrilla = True
End Function
Private Function HabilitarControles(Valor As Boolean)
   
   CmbTablaCartera.Enabled = Not Valor
   cmbSistema.Enabled = Not Valor
   Table1.Enabled = Valor
   
   Toolbar1.Buttons(Btn_Grabar).Enabled = Valor
   Toolbar1.Buttons(Btn_Eliminar).Enabled = Valor
   Toolbar1.Buttons(Btn_Limpiar).Enabled = Valor
   
End Function

Private Sub Limpiar()
   Table1.Clear
   Table1.Rows = 2
   Call Dibuja_Grilla
End Sub

Private Function ValidaAgr() As Integer
   Dim f As Long

   ValidaAgr = False
   For f = 1 To Table1.Rows
      Table1.Row = f
      'Columna del código
      Table1.Col = 1
      If Val(Table1.Text) = 0 Then
         ValidaAgr = True
         Exit For
      End If
      'Descripción del código
      Table1.Col = 2
      If Trim$(Table1.Text) = "" Then
         ValidaAgr = True
         Exit For
      End If
   Next f
End Function


Private Sub CmbCartera_KeyDown(KeyCode As Integer, Shift As Integer)
    Dim nContador As Integer

    Select Case KeyCode
        Case vbKeyReturn
            With Table1
                For nContador = 1 To .Rows - 1
                    If Trim(Right(CmbCartera.Text, 10)) = Trim(.TextMatrix(nContador, nCol_Codigo)) And nContador <> .Row Then
                        MsgBox "Cartera seleccionada ya existe", vbExclamation
                        CmbCartera.Visible = False
                        Exit Sub
                    End If
                Next nContador
        
                .TextMatrix(.Row, nCol_Codigo) = Trim(Right(CmbCartera.Text, 10))
                .TextMatrix(.Row, ncol_Descripcion) = Trim(Left(CmbCartera.Text, 50))
                CmbCartera.Visible = False
            End With
            
        Case vbKeyEscape
            CmbCartera.Visible = False
            Table1.SetFocus
    End Select
End Sub


Private Sub CmbCartera_LostFocus()
    CmbCartera.Visible = False
End Sub

Private Sub cmbSistema_Click()
    Dim Datos()
   
    CmbTablaCartera.Clear
   
    Envia = Array()
    AddParam Envia, Trim(Right(cmbSistema.Text, 10))
   
    If Bac_Sql_Execute("SP_BACMNTCR_BUSCAPRODUCTO", Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            If Datos(1) <> "ERROR" Then
                CmbTablaCartera.AddItem (Datos(nPro_Descripcion)) + Space(80) + Datos(nPro_Codigo)
            End If
        Loop
    End If
   
End Sub

Private Sub CmbTablaCartera_Click()
    Dim iCodProducto  As Variant
    Dim idSistema     As Variant
   
    Table1.Redraw = False
   
    If CmbTablaCartera.ListIndex > -1 Then
        iCodProducto = Trim(Right(CmbTablaCartera.Text, 10))
        idSistema = Trim(Right(cmbSistema.Text, 10))
      
        Envia = Array()
        AddParam Envia, iCodProducto
        AddParam Envia, idSistema
        AddParam Envia, 206 'GLB_CAT_VOLCKER_RULE
        If Not Bac_Sql_Execute("SP_MDRCLEERCODIGO_VOLCKER_RULE ", Envia) Then
            Screen.MousePointer = vbDefault
            MsgBox "Problemas al leer cartera Volker Rule ", vbCritical, TITSISTEMA
            Exit Sub
        End If
        
        Table1.Rows = 1
   
        Do While Bac_SQL_Fetch(Datos())
            With Table1
                .AddItem ""
                .TextMatrix(.Rows - 1, nCol_Codigo) = Trim(Datos(nCar_Codigo))
                .TextMatrix(.Rows - 1, ncol_Descripcion) = Trim(Datos(nCar_Descripcion))
            End With
        Loop
      
      Call HabilitarControles(True)
      
      If Table1.Rows = 1 Then
         Table1.Rows = 2
      End If
      
      Table1.SetFocus
   End If
   Table1.Redraw = True
   
End Sub

Private Sub CmbTablaCartera_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
      Call CmbTablaCartera_LostFocus
   End If
End Sub

Private Sub CmbTablaCartera_LostFocus()
   Dim iCodProducto  As Variant
   Dim idSistema     As Variant
   
End Sub

Private Sub cmdEliminar()
   Dim a As Integer
   Dim iok          As Integer
   Dim iCodProducto As Variant
   Dim idSistema    As Variant
   Dim nCodigo      As Long
   Dim sql          As String

 
    If Trim(Table1.TextMatrix(Table1.Row, nCol_Codigo)) <> "" Then
        
        If MsgBox("¿Esta seguro de eliminar la cartera Volker Rule seleccionada?", vbQuestion + vbYesNo, TITSISTEMA) = vbYes Then
            Screen.MousePointer = vbHourglass
              
            Envia = Array()
            AddParam Envia, Trim(Right(CmbTablaCartera.Text, 10))
            AddParam Envia, Trim(Right(cmbSistema.Text, 10))
            AddParam Envia, CDbl(Table1.TextMatrix(Table1.Row, nCol_Codigo))
        
            If Not Bac_Sql_Execute("SP_MDRCELIMINACAR_VOLCKER_RULE", Envia) Then
                Screen.MousePointer = vbDefault
                MsgBox "Ha ocurrido un error al intentar eliminar la cartera selecionada", vbCritical, TITSISTEMA
                Exit Sub
            End If
            
            If Table1.Rows > 2 Then
                Table1.RemoveItem Table1.Row
            Else
                Table1.TextMatrix(Table1.Row, nCol_Codigo) = ""
                Table1.TextMatrix(Table1.Row, ncol_Descripcion) = ""
            End If
        End If
    End If
    
    Screen.MousePointer = vbDefault
    Table1.SetFocus
      
End Sub

Private Sub cmdGrabar()
    Dim bRespuesta As Boolean
    Dim iCodProducto     As Variant
    Dim idSistema        As Variant
    
    Screen.MousePointer = vbHourglass
    
    If Not Bac_Sql_Execute("BEGIN TRAN") Then
        Screen.MousePointer = vbDefault
        MsgBox "Ha ocurrido un error al intentar grabar la informacion", vbCritical
        Exit Sub
    End If
     
   
    Envia = Array()
    AddParam Envia, Trim(Right(cmbSistema.Text, 10)) ' idSistema
    AddParam Envia, Trim(Right(CmbTablaCartera.Text, 10)) 'iCodProducto
    
    If Not Bac_Sql_Execute("SP_ELIMINAR_TIPO_CARTERA_VOLCKER_RULE ", Envia) Then
        bRespuesta = Bac_Sql_Execute("ROLLBACK TRAN")
        Screen.MousePointer = vbDefault
        MsgBox "Ha ocurrido un error al intentar grabar la informacion", vbCritical
        Exit Sub
    End If
    
    If Not PGrabarCar(iCodProducto, idSistema) Then
        bRespuesta = Bac_Sql_Execute("ROLLBACK TRAN")
        Screen.MousePointer = vbDefault
        MsgBox "Ha ocurrido un error al intentar grabar la informacion", vbCritical
        Exit Sub
    Else
        bRespuesta = Bac_Sql_Execute("COMMIT TRAN")
        Screen.MousePointer = vbDefault
        MsgBox "Grabación se realizó con exito", 64, TITSISTEMA
        Call ObjCartera.LimpiarTodos
        Call Limpiar
        Call HabilitarControles(False)
    End If
    
    CmbTablaCartera.SetFocus

End Sub


Private Sub CmdLimpiar()

   Call ObjCartera.LimpiarTodos
   Call Limpiar
   Call HabilitarControles(False)
   
   Dibuja_Grilla
    txtIngreso.Text = ""
    txtIngreso.Visible = False
   CmbTablaCartera.SetFocus

End Sub



Private Sub Form_Load()
   Dim nCol    As Integer
   
   Me.Top = 0
   Me.Left = 0
   
   Call Grabar_Log_AUDITORIA(giBAC_Entidad, gsbac_fecp, gsBac_IP, gsBAC_User, "PCA", "OPC_680", "07", "INGRESO A OPCION MENU", " ", " ", " ")

   Set objcodtab = New clscodtabs
   Set ObjCartera = New clsCarte
   
   Call Dibuja_Grilla
   Call HabilitarControles(False)
   
   If Bac_Sql_Execute("sp_btr_sistemas_activos") Then
      Do While Bac_SQL_Fetch(Datos())
         cmbSistema.AddItem Datos(nSis_Descripcion) & Space(90) & Datos(nSis_Codigo)
      Loop
   End If
   
   
   Envia = Array()
   AddParam Envia, 1
   AddParam Envia, 206 ' GLB_CAT_VOLCKER_RULE
      
   If Bac_Sql_Execute("sp_con_info_combo", Envia) Then
      Do While Bac_SQL_Fetch(Datos())
         CmbCartera.AddItem Datos(nCartera_Descripcion) & Space(90) & Datos(nCartera_Codigo)
      Loop
   End If
   
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Set objcodtab = Nothing

End Sub

Private Sub Table1_EnterEdit()
   Label(1).Caption = "E"
End Sub

Private Sub Table1_ExitEdit()
   Label(1).Caption = ""
End Sub

Private Sub Table1_DblClick()
    Dim nContador As Integer
    
    With Table1
        If .Col = ncol_Descripcion Then
            If CmbCartera.ListCount > 0 Then
                For nContador = 0 To CmbCartera.ListCount - 1
                    If Trim(Right(CmbCartera.List(nContador), 10)) = Trim(.TextMatrix(.Row, nCol_Codigo)) Then
                        CmbCartera.ListIndex = nContador
                        Exit For
                    End If
                Next nContador
            
                CmbCartera.ListIndex = IIf(CmbCartera.ListCount > 0, 0, -1)
                CmbCartera.Visible = True
                CmbCartera.Width = .ColWidth(.Col)
                CmbCartera.Left = .Left + .CellLeft
                CmbCartera.Top = .Top + .CellTop
                CmbCartera.SetFocus
            End If
        End If
    End With
End Sub

Private Sub Table1_KeyDown(KeyCode As Integer, Shift As Integer)
'    Dim bOk        As Boolean
'    Dim nOk        As Integer
   
    Select Case KeyCode
        Case vbKeyInsert
            If Table1.TextMatrix(Table1.Rows - 1, nCol_Codigo) <> "" And Table1.TextMatrix(Table1.Rows - 1, ncol_Descripcion) <> "" Then
                Table1.AddItem ""
                Table1.SetFocus
                Table1.Col = ncol_Descripcion
                Table1.Row = Table1.Rows - 1
            End If
        Case vbKeyDelete
            'Validar que no se encuentre enlazado con algUn perfÝl.
            If Table1.Rows > 2 Then
                Table1.RemoveItem Table1.Row
            Else
                Table1.TextMatrix(1, nCol_Codigo) = ""
                Table1.TextMatrix(1, ncol_Descripcion) = ""
            End If
    End Select
End Sub

Private Sub Table1_KeyPress(KeyAscii As Integer)
   'If Not IsNumeric(Chr(KeyAscii)) And (UCase(Chr(KeyAscii)) >= "A" Or UCase(Chr(KeyAscii)) <= "Z") And KeyAscii <> 13 And KeyAscii <> 8 Then
   If Not IsNumeric(Chr(KeyAscii)) And UCase(Chr(KeyAscii)) < "A" And UCase(Chr(KeyAscii)) > "Z" And KeyAscii <> 13 And KeyAscii <> 8 Then
      KeyAscii = 0
   End If
   
   If KeyAscii = 13 Then
       Call Table1_DblClick
'      txtIngreso.Text = Table1.Text
'   Else
'      txtIngreso.Text = ""
   End If
   'Call PROC_POSICIONA_TEXTO(Table1, txtIngreso)
   'txtIngreso.Visible = True
   'txtIngreso.SetFocus
   'SendKeys "{END}"
End Sub



Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index
    
    Case Btn_Grabar          '"Grabar"
        Call cmdGrabar
      
    Case Btn_Eliminar          '"ELIMINAR"
        Call cmdEliminar
        
    Case Btn_Limpiar          '"Limpiar"
        Call CmdLimpiar
        
    Case Btn_Salir          '"Salir"
        Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                          , gsbac_fecp _
                          , gsBac_IP _
                          , gsBAC_User _
                          , "PCA" _
                          , "OPC_680 " _
                          , "08" _
                          , "SALIR DE OPCION MENU" _
                          , " " _
                          , " " _
                          , " ")
        Unload Me
    End Select
End Sub

Private Sub txtIngreso_KeyPress(KeyAscii As Integer)
If KeyAscii = 27 Then

   txtIngreso.Visible = False
   Table1.SetFocus
   
End If

    If Table1.Col = 1 Then
        KeyAscii = BacPunto(txtIngreso, KeyAscii, 5, 0)
    Else
        KeyAscii = Asc(UCase(Chr(KeyAscii)))
    End If
    
If KeyAscii = 13 Then

    If Trim(txtIngreso.Text) = "" Then Exit Sub
    If Table1.Col = 1 Then
       Call PVerCodigo
    End If
     
    Table1.Text = txtIngreso.Text
    txtIngreso.Visible = False
    Table1.SetFocus

End If
End Sub
Public Function PGrabarCar(iCodProducto, idSistema As Variant) As Boolean
    Dim Fila       As Long
    Dim imax       As Long
    Dim sql        As String

    PGrabarCar = False
   
    With Table1
        For Fila = 1 To .Rows - 1
            
            Envia = Array()
            AddParam Envia, Trim(Right(CmbTablaCartera.Text, 10)) 'iCodProducto
            AddParam Envia, Trim(Right(cmbSistema.Text, 10)) 'idSistema
            AddParam Envia, CDbl(.TextMatrix(Fila, nCol_Codigo))
           ' AddParam Envia, .TextMatrix(Fila, ncol_Descripcion)
         
            If Not Bac_Sql_Execute("SP_MDRCGRABAR_VOLCKER_RULE", Envia) Then
                Exit Function
            End If
         
            Call Grabar_Log_AUDITORIA(giBAC_Entidad, gsbac_fecp, gsBac_IP, gsBAC_User, "PCA", "OPC_680 ", "01", "Graba, Tipo Cartera ", "TIPO_CARTERA  ", " ", "Graba, Tipo Cartera " & Trim(Right(CmbTablaCartera.Text, 10)) & " " & Str(CDbl(.TextMatrix(Fila, nCol_Codigo))) & " " & .TextMatrix(Fila, ncol_Descripcion))
        Next Fila
    End With

   PGrabarCar = True
End Function


Public Function PVerCodigo()

   Dim Fila       As Long
   Dim imax       As Long
   Dim sql        As String

   imax = Table1.Rows - 1
   With Table1
      .Col = 1
      For Fila = 1 To imax
          .Row = Fila
          If txtIngreso.Text = .Text Then
             MsgBox "Codigo " & .Text & " ya existe en tabla", vbCritical, TITSISTEMA
             .Row = Table1.Rows - 1
             .Text = ""
             txtIngreso.Text = ""
             txtIngreso.SetFocus
             Exit Function
          End If
      Next Fila
   End With

End Function


