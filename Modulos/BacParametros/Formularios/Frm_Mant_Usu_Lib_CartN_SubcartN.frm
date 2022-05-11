VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form Frm_Mant_Usu_Lib_CartN_SubcartN 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantención Usuario/Libro Cart. Normativa y Sub Cart. Normativa"
   ClientHeight    =   5685
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   8985
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5685
   ScaleWidth      =   8985
   Begin VB.Frame frIds 
      Height          =   1455
      Left            =   30
      TabIndex        =   7
      Top             =   570
      Width           =   8910
      Begin VB.Frame frIgualA 
         Height          =   615
         Left            =   4395
         TabIndex        =   12
         Top             =   645
         Width           =   4260
         Begin VB.ComboBox cmbIgualA 
            BeginProperty Font 
               Name            =   "Courier New"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   330
            Left            =   1590
            Style           =   2  'Dropdown List
            TabIndex        =   5
            Top             =   195
            Width           =   2595
         End
         Begin Threed.SSCheck Chk_IgualA 
            Height          =   255
            Left            =   165
            TabIndex        =   4
            Top             =   210
            Width           =   1215
            _Version        =   65536
            _ExtentX        =   2143
            _ExtentY        =   450
            _StockProps     =   78
            Caption         =   "Crear Igual a"
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
         End
      End
      Begin VB.ComboBox cmbProducto 
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   1215
         Style           =   2  'Dropdown List
         TabIndex        =   3
         Top             =   870
         Width           =   3030
      End
      Begin VB.ComboBox cmbSistema 
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   1215
         Style           =   2  'Dropdown List
         TabIndex        =   2
         Top             =   525
         Width           =   3030
      End
      Begin VB.ComboBox cmbUsuario 
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   1215
         Style           =   2  'Dropdown List
         TabIndex        =   1
         Top             =   180
         Width           =   3030
      End
      Begin VB.Label lblProducto 
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
         Height          =   300
         Left            =   195
         TabIndex        =   11
         Top             =   1005
         Width           =   1125
      End
      Begin VB.Label lblSistema 
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
         Left            =   195
         TabIndex        =   10
         Top             =   645
         Width           =   1080
      End
      Begin VB.Label lblUsuario 
         Caption         =   "Usuario"
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
         Left            =   180
         TabIndex        =   9
         Top             =   270
         Width           =   825
      End
   End
   Begin VB.Frame frGrilla 
      Caption         =   "Mantención Usuario Normativo"
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
      Height          =   3600
      Left            =   30
      TabIndex        =   0
      Top             =   2055
      Width           =   8925
      Begin VB.ComboBox cmbSubCartNorm 
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   5790
         Style           =   2  'Dropdown List
         TabIndex        =   15
         Top             =   3015
         Width           =   2535
      End
      Begin VB.ComboBox cmbCartNorm 
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   3120
         Style           =   2  'Dropdown List
         TabIndex        =   14
         Top             =   3015
         Width           =   2610
      End
      Begin VB.ComboBox cmbLibro 
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   270
         Style           =   2  'Dropdown List
         TabIndex        =   13
         Top             =   3000
         Width           =   2760
      End
      Begin MSFlexGridLib.MSFlexGrid Grd_Datos 
         Height          =   3255
         Left            =   135
         TabIndex        =   6
         Top             =   180
         Width           =   8595
         _ExtentX        =   15161
         _ExtentY        =   5741
         _Version        =   393216
         Cols            =   8
         FixedCols       =   0
         RowHeightMin    =   315
         GridLinesFixed  =   0
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Index           =   0
      Left            =   4680
      Top             =   600
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   5
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Frm_Mant_Usu_Lib_CartN_SubcartN.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Frm_Mant_Usu_Lib_CartN_SubcartN.frx":0452
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Frm_Mant_Usu_Lib_CartN_SubcartN.frx":08A4
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Frm_Mant_Usu_Lib_CartN_SubcartN.frx":177E
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Frm_Mant_Usu_Lib_CartN_SubcartN.frx":1A98
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Tlb_Herramientas 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   8
      Top             =   0
      Width           =   8985
      _ExtentX        =   15849
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1(0)"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
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
            Enabled         =   0   'False
            Object.Visible         =   0   'False
            Key             =   "Buscar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Limpiar"
            Description     =   "Limpiar"
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Description     =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   5
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSComctlLib.ImageList ImageList1 
      Index           =   1
      Left            =   5565
      Top             =   570
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   5
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Frm_Mant_Usu_Lib_CartN_SubcartN.frx":1DB2
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Frm_Mant_Usu_Lib_CartN_SubcartN.frx":2204
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Frm_Mant_Usu_Lib_CartN_SubcartN.frx":2656
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Frm_Mant_Usu_Lib_CartN_SubcartN.frx":3530
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Frm_Mant_Usu_Lib_CartN_SubcartN.frx":384A
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "Frm_Mant_Usu_Lib_CartN_SubcartN"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public CodLibro As String

Dim Datos()
Dim nContador1    As Integer
Dim nContador2    As Integer
Dim nContador3    As Integer



'CONSTANTE DE LA FILA CABECERA
Const nFila_Cabecera = 0

Private Const nColCodLibro = 0
Private Const nColDesLibro = 1
Private Const nColCodCartNorm = 2
Private Const nColDesCartNorm = 3
Private Const nColCodSubCartNorm = 4
Private Const nColDesSubCartNorm = 5
Private Const nColUtiliza = 6
Private Const nColDefault = 7


Private Const BtnGrabar = 1
Private Const BtnEliminar = 2
Private Const BtnLimpiar = 4
Private Const BtnSalir = 5

'CONSTANTE DE RETORNO DE SP_BACMNTCR_BUSCAPRODUCTO
Const nPro_Codigo = 1
Const nPro_Descripcion = 2

'CONSTANTE DE LA COLUMNA DESCRIPCION
Const nCol_Codigo = 0
Const ncol_Descripcion = 1
'CONSTANTE DE RETORNO DE SP_CON_INFO_COMBO
Const PosCodigo = 2
Const PosDescripcion = 6

Private Sub Frame2_DragDrop(Source As Control, X As Single, Y As Single)

End Sub

Function LimpiaDatos(nTipo As Long)
   Chk_IgualA.Value = False
   cmbIguala.ListIndex = -1

    If nTipo = 1 Then ' Usuario
        cmbSistema.ListIndex = -1
        cmbProducto.ListIndex = -1
        cmbLibro.ListIndex = -1
        cmbCartNorm.ListIndex = -1
        cmbSubCartNorm.ListIndex = -1
    End If
    
    If nTipo = 2 Then ' Sistema
        cmbLibro.ListIndex = -1
        cmbCartNorm.ListIndex = -1
        cmbSubCartNorm.ListIndex = -1
    End If
End Function

Function LlenaGrilla()
    Grd_Datos.Clear
    
    
    Grd_Datos.TextMatrix(nFila_Cabecera, nColCodLibro) = "Cod Libro"
    Grd_Datos.TextMatrix(nFila_Cabecera, nColCodCartNorm) = "Cod Cart.Norma"
    Grd_Datos.TextMatrix(nFila_Cabecera, nColCodSubCartNorm) = "Cod Sub Cart.Norma"
    Grd_Datos.TextMatrix(nFila_Cabecera, nColDesLibro) = "Libro"
    Grd_Datos.TextMatrix(nFila_Cabecera, nColDesCartNorm) = "Cartera Normativa"
    Grd_Datos.TextMatrix(nFila_Cabecera, nColDesSubCartNorm) = "Sub Cart.Normativa"
    Grd_Datos.TextMatrix(nFila_Cabecera, nColDefault) = "Default"
    
    Grd_Datos.ColWidth(nColCodLibro) = 0
    Grd_Datos.ColWidth(nColDesLibro) = 2500
    Grd_Datos.ColWidth(nColCodCartNorm) = 0
    Grd_Datos.ColWidth(nColDesCartNorm) = 2500
    Grd_Datos.ColWidth(nColCodSubCartNorm) = 0
    Grd_Datos.ColWidth(nColDesSubCartNorm) = 2500
    Grd_Datos.Rows = 2
    Grd_Datos.Gridlines = flexGridRaised
End Function

Private Sub Chk_IgualA_Click(Value As Integer)
    If Chk_IgualA.Value = True Then
        cmbIguala.Enabled = True
    Else
        cmbIguala.Enabled = False
        cmbIguala.ListIndex = -1
    End If
End Sub

Private Sub cmbCartNorm_Click()
    With Grd_Datos
    
        If cmbCartNorm.Visible = True Then
    
            With Grd_Datos
                .TextMatrix(.Row, nColCodCartNorm) = Trim(Right(cmbCartNorm.Text, 10))
                .TextMatrix(.Row, nColDesCartNorm) = Trim(Left(cmbCartNorm.Text, 50))
                
                cmbCartNorm.Visible = False
                
                Tlb_Herramientas.Buttons(BtnGrabar).Enabled = True
                Tlb_Herramientas.Buttons(BtnEliminar).Enabled = True
                
                
                 If Trim(Right(cmbCartNorm.Text, 10)) <> CODCARTNORM Then

                    .TextMatrix(.Row, nColCodSubCartNorm) = ""
                    .TextMatrix(.Row, nColDesSubCartNorm) = ""

                End If
                
            End With
        End If
                    
        Envia = Array()
        AddParam Envia, 1
        AddParam Envia, GLB_CAT_SUBCARTERA_NORMATIVA
        AddParam Envia, IIf(cmbCartNorm.Visible = True, Trim(Right(cmbCartNorm.Text, 10)), .TextMatrix(.Row, nColCodCartNorm))
        
        Call PROC_LLENA_COMBOS("SP_CON_SUB_CART_NORM", Envia, cmbSubCartNorm, False, PosCodigo, PosDescripcion)
    
    End With
    
End Sub

Private Sub CmbCartNorm_KeyDown(KeyCode As Integer, Shift As Integer)
        
     Select Case KeyCode
        Case vbKeyReturn
            With Grd_Datos
                        
                .TextMatrix(.Row, nColCodCartNorm) = Trim(Right(cmbCartNorm.Text, 10))
                .TextMatrix(.Row, nColDesCartNorm) = Trim(Left(cmbCartNorm.Text, 50))
                
                cmbCartNorm.Visible = False
                
                Tlb_Herramientas.Buttons(BtnGrabar).Enabled = True
                Tlb_Herramientas.Buttons(BtnEliminar).Enabled = True
            End With
            
        Case vbKeyEscape
            cmbLibro.Visible = False
            Grd_Datos.SetFocus
    End Select
End Sub

Private Sub cmbCartNorm_LostFocus()
     cmbCartNorm.Visible = False
End Sub

Private Sub cmbIgualA_Change()
     If Me.Visible = True Then
        If cmbIguala.ListIndex > -1 Then
            cmbIguala.Enabled = True
        End If
    End If
End Sub

Private Sub cmbIgualA_Click()

    Grd_Datos.Enabled = True
    
    If cmbIguala.ListIndex = -1 Then
        Exit Sub
    End If
    
    If cmbIguala.ListIndex = -1 Or cmbSistema.ListIndex = -1 Or cmbProducto.ListIndex = -1 Then
        Screen.MousePointer = vbDefault
        MsgBox "Debe seleccionar un Usuario, Sistema y Producto antes de este item", vbExclamation + vbOKOnly
        Chk_IgualA.Value = False
        Exit Sub
    End If

    If cmbUsuario.Text = cmbIguala.Text And cmbIguala.Text <> "" Then
        Screen.MousePointer = vbDefault
        MsgBox "No puede seleccionar al mismo usuario", vbExclamation + vbOKOnly
        cmbIguala.ListIndex = -1
        Exit Sub
    End If
    
    
    Grd_Datos.Enabled = True
    
    Envia = Array()
    AddParam Envia, 4 'opcion de busqueda
    AddParam Envia, Trim(Right(cmbSistema.Text, 10))
    AddParam Envia, Trim(Right(cmbProducto.Text, 10))
    AddParam Envia, ""
    AddParam Envia, GLB_CAT_LIBRO


    Call PROC_LLENA_COMBOS("SP_CON_INFO_COMBO", Envia, cmbLibro, False, PosCodigo, PosDescripcion)
    
    Envia = Array()
    AddParam Envia, Trim(cmbIguala.Text)
    AddParam Envia, Trim(Right(cmbSistema.Text, 10))
    AddParam Envia, Trim(Right(cmbProducto.Text, 10))
    
    If Not Bac_Sql_Execute("SP_CON_REL_USUARIO_NORMATIVO", Envia) Then
        Screen.MousePointer = vbDefault
        MsgBox "Ha ocurrido un error al intentar leer la parametrizacion del usuario", vbCritical + vbOKOnly, TITSISTEMA
        Exit Sub
    End If
        
    With Grd_Datos
        .Rows = 1
        
        Do While Bac_SQL_Fetch(Datos())
            .AddItem ""
            .TextMatrix(.Rows - 1, nColCodLibro) = Trim(Datos(4))
            .TextMatrix(.Rows - 1, nColCodCartNorm) = Trim(Datos(5))
            .TextMatrix(.Rows - 1, nColCodSubCartNorm) = Trim(Datos(6))
            .TextMatrix(.Rows - 1, nColDefault) = Trim(Datos(7))
            
            If .TextMatrix(.Rows - 1, nColDefault) = "S" Then
                .TextMatrix(.Rows - 1, nColDefault) = "SI"
                .Row = .Rows - 1
                .Col = nColDefault
                .CellBackColor = vbGreen
            Else
                .TextMatrix(.Rows - 1, nColDefault) = "NO"
                .Row = .Rows - 1
                .Col = nColDefault
                .CellBackColor = vbRed
            End If
        Loop
        
        For nContador2 = 1 To .Rows - 1
        
            .Row = nContador2
        
            For nContador1 = 0 To cmbLibro.ListCount - 1
                If Trim(Right(cmbLibro.List(nContador1), 10)) = .TextMatrix(nContador2, nColCodLibro) Then
                    .TextMatrix(nContador2, nColDesLibro) = Mid(cmbLibro.List(nContador1), 1, 80)
                    ''''cmbLibro.ListIndex = nContador1
                    ''''.TextMatrix(nContador2, nColDesLibro) = Mid(cmbLibro.Text, 1, 80)
                    Call cmbLibro_Click
                    Exit For
                End If
            Next nContador1
                    
            For nContador1 = 0 To cmbCartNorm.ListCount - 1
                If Trim(Right(cmbCartNorm.List(nContador1), 10)) = .TextMatrix(nContador2, nColCodCartNorm) Then
                    ''''cmbCartNorm.ListIndex = nContador1
                    ''''.TextMatrix(nContador2, nColDesCartNorm) = Mid(cmbCartNorm.Text, 1, 80)
                    .TextMatrix(nContador2, nColDesCartNorm) = Mid(cmbCartNorm.List(nContador1), 1, 80)
                    Call cmbCartNorm_Click
                    Exit For
                End If
            Next nContador1
            
            For nContador1 = 0 To cmbSubCartNorm.ListCount - 1
                If Trim(Right(cmbSubCartNorm.List(nContador1), 10)) = .TextMatrix(nContador2, nColCodSubCartNorm) Then
                    ''''cmbSubCartNorm.ListIndex = nContador1
                    ''''.TextMatrix(nContador2, nColDesSubCartNorm) = Mid(cmbSubCartNorm.Text, 1, 80)
                    .TextMatrix(nContador2, nColDesSubCartNorm) = Mid(cmbSubCartNorm.List(nContador1), 1, 80)
                    Exit For
                End If
              
            Next nContador1
            
            If .TextMatrix(nContador2, nColCodSubCartNorm) = "N/A" Then
                .TextMatrix(nContador2, nColDesSubCartNorm) = "N/A"
            End If
       
       Next nContador2
            
        If .Rows = 1 Then
            .Rows = 2
            Tlb_Herramientas.Buttons(BtnGrabar).Enabled = False
            Tlb_Herramientas.Buttons(BtnEliminar).Enabled = False
        Else
            Tlb_Herramientas.Buttons(BtnGrabar).Enabled = True
            Tlb_Herramientas.Buttons(BtnEliminar).Enabled = True
        End If

    End With
    
    If Grd_Datos.Rows > 1 Then
        Tlb_Herramientas.Buttons(BtnGrabar).Enabled = True
        Tlb_Herramientas.Buttons(BtnEliminar).Enabled = True
    End If
                   
    Grd_Datos.Redraw = True
    
End Sub

Private Sub cmbLibro_Click()
  
    With Grd_Datos
        If cmbLibro.Visible = True Then
            .TextMatrix(.Row, nColCodLibro) = Trim(Right(cmbLibro.Text, 10))
            .TextMatrix(.Row, nColDesLibro) = Trim(Left(cmbLibro.Text, 50))
            
            
            cmbLibro.Visible = False
            
            
            Tlb_Herramientas.Buttons(BtnGrabar).Enabled = True
            Tlb_Herramientas.Buttons(BtnEliminar).Enabled = True
            
            If .TextMatrix(.Rows - 1, nColDefault) = "" Then
                .TextMatrix(.Row, nColDefault) = "NO"
                .Col = nColDefault
                .CellBackColor = vbRed
            End If
                      
                If Trim(Right(cmbLibro.Text, 10)) <> CodLibro Then

                    .TextMatrix(.Row, nColCodCartNorm) = ""
                    .TextMatrix(.Row, nColDesCartNorm) = ""
                    .TextMatrix(.Row, nColCodSubCartNorm) = ""
                    .TextMatrix(.Row, nColDesSubCartNorm) = ""
               End If
        End If
             
            Envia = Array()
            AddParam Envia, 5 'opcion de busqueda de carteras normativas relacionadas a un libro
            AddParam Envia, Trim(Right(cmbSistema.Text, 10))
            AddParam Envia, Trim(Right(cmbProducto.Text, 10))
            AddParam Envia, IIf(cmbLibro.Visible = True, Trim(Right(cmbLibro.Text, 10)), .TextMatrix(.Row, nColCodLibro))
            AddParam Envia, ""
            AddParam Envia, GLB_CAT_CARTERA_NORMATIVA
            Call PROC_LLENA_COMBOS("SP_CON_INFO_COMBO", Envia, cmbCartNorm, False, PosCodigo, PosDescripcion)
            
        
    End With


End Sub

Private Sub cmbLibro_KeyDown(KeyCode As Integer, Shift As Integer)
       
    Select Case KeyCode
        Case vbKeyReturn
            With Grd_Datos

        
                .TextMatrix(.Row, nColCodLibro) = Trim(Right(cmbLibro.Text, 10))
                .TextMatrix(.Row, nColDesLibro) = Trim(Left(cmbLibro.Text, 50))
                
                cmbLibro.Visible = False
                
                Tlb_Herramientas.Buttons(BtnGrabar).Enabled = True
                Tlb_Herramientas.Buttons(BtnEliminar).Enabled = True
            End With
            
        Case vbKeyEscape
            cmbLibro.Visible = False
            Grd_Datos.SetFocus
    End Select
    
   With Grd_Datos
   
    If .TextMatrix(.Rows - 1, nColDefault) = "" Then
        .TextMatrix(.Row, nColDefault) = "NO"
        .Col = nColDefault
        .CellBackColor = vbRed
    End If
    
    
    
   End With
   
   
  
    
End Sub

Private Sub cmbLibro_LostFocus()
    cmbLibro.Visible = False
End Sub

Private Sub cmbProducto_Click()
    
    Grd_Datos.Redraw = False
    
    
    Grd_Datos.Enabled = True
    
    Envia = Array()
    AddParam Envia, 4 'opcion de busqueda
    AddParam Envia, Trim(Right(cmbSistema.Text, 10))
    AddParam Envia, Trim(Right(cmbProducto.Text, 10))
    AddParam Envia, ""
    AddParam Envia, GLB_CAT_LIBRO


    Call PROC_LLENA_COMBOS("SP_CON_INFO_COMBO", Envia, cmbLibro, False, PosCodigo, PosDescripcion)
    
    Envia = Array()
    AddParam Envia, Trim(cmbUsuario.Text)
    AddParam Envia, Trim(Right(cmbSistema.Text, 10))
    AddParam Envia, Trim(Right(cmbProducto.Text, 10))
    
    If Not Bac_Sql_Execute("SP_CON_REL_USUARIO_NORMATIVO", Envia) Then
        Screen.MousePointer = vbDefault
        MsgBox "Ha ocurrido un error al intentar leer la parametrizacion del usuario", vbCritical + vbOKOnly, TITSISTEMA
        Exit Sub
    End If
        
    With Grd_Datos
        .Rows = 1
        
        Do While Bac_SQL_Fetch(Datos())
            .AddItem ""
            .TextMatrix(.Rows - 1, nColCodLibro) = Trim(Datos(4))
            .TextMatrix(.Rows - 1, nColCodCartNorm) = Trim(Datos(5))
            .TextMatrix(.Rows - 1, nColCodSubCartNorm) = Trim(Datos(6))
            .TextMatrix(.Rows - 1, nColDefault) = Trim(Datos(7))
            
            If .TextMatrix(.Rows - 1, nColDefault) = "S" Then
                .TextMatrix(.Rows - 1, nColDefault) = "SI"
                .Row = .Rows - 1
                .Col = nColDefault
                .CellBackColor = vbGreen
            Else
                .TextMatrix(.Rows - 1, nColDefault) = "NO"
                .Row = .Rows - 1
                .Col = nColDefault
                .CellBackColor = vbRed
            End If
        Loop
        
        For nContador2 = 1 To .Rows - 1
        
            .Row = nContador2
        
            For nContador1 = 0 To cmbLibro.ListCount - 1
                If Trim(Right(cmbLibro.List(nContador1), 10)) = .TextMatrix(nContador2, nColCodLibro) Then
                    .TextMatrix(nContador2, nColDesLibro) = Mid(cmbLibro.List(nContador1), 1, 80)
                    ''''cmbLibro.ListIndex = nContador1
                    ''''.TextMatrix(nContador2, nColDesLibro) = Mid(cmbLibro.Text, 1, 80)
                    Call cmbLibro_Click
                    Exit For
                End If
            Next nContador1
                    
            For nContador1 = 0 To cmbCartNorm.ListCount - 1
                If Trim(Right(cmbCartNorm.List(nContador1), 10)) = .TextMatrix(nContador2, nColCodCartNorm) Then
                    ''''cmbCartNorm.ListIndex = nContador1
                    ''''.TextMatrix(nContador2, nColDesCartNorm) = Mid(cmbCartNorm.Text, 1, 80)
                    .TextMatrix(nContador2, nColDesCartNorm) = Mid(cmbCartNorm.List(nContador1), 1, 80)
                    Call cmbCartNorm_Click
                    Exit For
                End If
            Next nContador1
            
            For nContador1 = 0 To cmbSubCartNorm.ListCount - 1
                If Trim(Right(cmbSubCartNorm.List(nContador1), 10)) = .TextMatrix(nContador2, nColCodSubCartNorm) Then
                    ''''cmbSubCartNorm.ListIndex = nContador1
                    ''''.TextMatrix(nContador2, nColDesSubCartNorm) = Mid(cmbSubCartNorm.Text, 1, 80)
                    .TextMatrix(nContador2, nColDesSubCartNorm) = Mid(cmbSubCartNorm.List(nContador1), 1, 80)
                    Exit For
                End If
              
            Next nContador1
            
            If .TextMatrix(nContador2, nColCodSubCartNorm) = "N/A" Then
                .TextMatrix(nContador2, nColDesSubCartNorm) = "N/A"
            End If
                          
       Next nContador2
                
        If .Rows = 1 Then
            .Rows = 2
            Tlb_Herramientas.Buttons(BtnGrabar).Enabled = False
            Tlb_Herramientas.Buttons(BtnEliminar).Enabled = False
        Else
            Tlb_Herramientas.Buttons(BtnGrabar).Enabled = True
            Tlb_Herramientas.Buttons(BtnEliminar).Enabled = True
        End If

        
    End With
    
    If Grd_Datos.Rows > 1 Then
        Tlb_Herramientas.Buttons(BtnGrabar).Enabled = True
        Tlb_Herramientas.Buttons(BtnEliminar).Enabled = True
    End If
    
    
    Grd_Datos.Redraw = True
    Chk_IgualA.Value = False
    cmbIguala.ListIndex = -1
End Sub


Private Sub cmbSistema_Click()
    Call LimpiaDatos(2)
    Call LlenaGrilla
    Envia = Array()
    AddParam Envia, Trim(Right(cmbSistema.Text, 10))
    
    Call PROC_LLENA_COMBOS("Sp_BacMan_BuscaProducto", Envia, cmbProducto, False, nPro_Codigo, nPro_Descripcion, False)

    If Me.Visible = True Then
        If cmbSistema.ListIndex > -1 Then
            cmbProducto.Enabled = True
        End If
    End If
    Chk_IgualA.Value = False
    cmbIguala.ListIndex = -1
End Sub


Private Sub cmbSubCartNorm_Click()
    
With Grd_Datos
    
        If cmbSubCartNorm.Visible = True Then
        
                .TextMatrix(.Row, nColCodSubCartNorm) = Trim(Right(cmbSubCartNorm.Text, 10))
                .TextMatrix(.Row, nColDesSubCartNorm) = Trim(Left(cmbSubCartNorm.Text, 50))
                cmbSubCartNorm.Visible = False
                        
                
            cmbCartNorm.Visible = False
            
            For nContador1 = 1 To .Rows - 1
                If Trim(Right(cmbLibro.Text, 10)) = Trim(.TextMatrix(nContador1, nColCodLibro)) _
                    And Trim(Right(cmbCartNorm.Text, 10)) = Trim(.TextMatrix(nContador1, nColCodCartNorm)) _
                    And Trim(Right(cmbSubCartNorm.Text, 10)) = Trim(.TextMatrix(nContador1, nColCodSubCartNorm)) _
                    And nContador1 <> .Row Then
                    cmbSubCartNorm.Visible = False
                    MsgBox "Registro seleccionado ya existe", vbExclamation

                    .TextMatrix(.Row, nColCodSubCartNorm) = ""
                    .TextMatrix(.Row, nColDesSubCartNorm) = ""
                    Exit Sub

                End If
            Next nContador1
                     
            For nContador1 = 1 To .Rows - 2
                For nContador2 = nContador1 + 1 To .Rows - 1
                                
                    If Trim(.TextMatrix(nContador1, nColCodLibro)) = Trim(.TextMatrix(nContador2, nColCodLibro)) _
                        And Trim(.TextMatrix(nContador1, nColCodCartNorm)) = Trim(.TextMatrix(nContador2, nColCodCartNorm)) _
                        And Trim(.TextMatrix(nContador1, nColCodSubCartNorm)) = Trim(.TextMatrix(nContador2, nColCodSubCartNorm)) _
                        And nContador1 <> .Row Then
                        
                        cmbSubCartNorm.Visible = False
                        MsgBox "Registro seleccionado ya existe", vbExclamation
                        
                        .TextMatrix(.Row, nColCodSubCartNorm) = ""
                        .TextMatrix(.Row, nColDesSubCartNorm) = ""
                        Exit Sub
        
                    End If
                    
                Next nContador2
            Next nContador1
       
        
        End If
        
       
End With
    
End Sub

Private Sub cmbSubCartNorm_KeyDown(KeyCode As Integer, Shift As Integer)

    Select Case KeyCode
        Case vbKeyReturn
            With Grd_Datos


            For nContador1 = 1 To .Rows - 1

                If Trim(Right(cmbLibro.Text, 10)) = Trim(.TextMatrix(nContador1, nColCodLibro)) _
                    And Trim(Right(cmbCartNorm.Text, 10)) = Trim(.TextMatrix(nContador1, nColCodCartNorm)) _
                    And Trim(Right(cmbSubCartNorm.Text, 10)) = Trim(.TextMatrix(nContador1, nColCodSubCartNorm)) _
                    And nContador1 <> .Row Then
                    MsgBox "Registro seleccionado ya existe", vbExclamation
                    cmbSubCartNorm.Visible = False
                    Exit Sub

                End If
            Next nContador1
            
            For nContador1 = 1 To .Rows - 1
                    For nContador2 = nContador1 + 1 To .Rows - 1
                                    
                        If Trim(.TextMatrix(nContador1, nColCodLibro)) = Trim(.TextMatrix(nContador2, nColCodLibro)) _
                            And Trim(.TextMatrix(nContador1, nColCodCartNorm)) = Trim(.TextMatrix(nContador2, nColCodCartNorm)) _
                            And Trim(.TextMatrix(nContador1, nColCodSubCartNorm)) = Trim(.TextMatrix(nContador2, nColCodSubCartNorm)) _
                            And nContador1 <> .Row Then
                            
                            cmbSubCartNorm.Visible = False
                            MsgBox "Registro seleccionado ya existe", vbExclamation
                            
                            .TextMatrix(.Row, nColCodSubCartNorm) = ""
                            .TextMatrix(.Row, nColDesSubCartNorm) = ""
                            Exit Sub
            
                        End If
                        
                    Next nContador2
            Next nContador1
       

        
                .TextMatrix(.Row, nColCodSubCartNorm) = Trim(Right(cmbSubCartNorm.Text, 10))
                .TextMatrix(.Row, nColDesSubCartNorm) = Trim(Left(cmbSubCartNorm.Text, 50))
                
                cmbSubCartNorm.Visible = False
                
                Tlb_Herramientas.Buttons(BtnGrabar).Enabled = True
                Tlb_Herramientas.Buttons(BtnEliminar).Enabled = True
            End With
            
        Case vbKeyEscape
            cmbLibro.Visible = False
            Grd_Datos.SetFocus
    End Select
        
End Sub
Private Sub cmbSubCartNorm_LostFocus()
     cmbSubCartNorm.Visible = False
End Sub

Private Sub cmbUsuario_Click()
    
    If Me.Visible = True Then
        If cmbUsuario.ListIndex > -1 Then
            cmbSistema.Enabled = True
        End If
    End If
    Call LimpiaDatos(1)
    Call LlenaGrilla
      
    Tlb_Herramientas.Buttons(BtnGrabar).Enabled = False
    Tlb_Herramientas.Buttons(BtnEliminar).Enabled = False
      
    If cmbSistema.ListIndex = -1 Then
        cmbProducto.Enabled = False
    End If
    cmbIguala.ListIndex = -1
End Sub
Private Sub Combo1_Change()

End Sub

Private Sub cmdLibro_GotFocus()
     With Grd_Datos
    
        If Trim(.TextMatrix(.Row, nColCodLibro)) <> "" Then
            For nContador1 = 1 To cmbLibro.ListCount - 1
                If Trim(Right(cmbLibro.List(nContador1), 10)) = Trim(.TextMatrix(.Row, nColCodLibro)) Then
                    cmbLibro.ListIndex = nContador1
                    Exit For
                End If
            Next nContador1
        End If

    End With
End Sub


Private Sub Form_Load()

    Me.Icon = BACSwapParametros.Icon
    Me.Top = 0: Me.Left = 0
    
    
    Envia = Array()
    AddParam Envia, "U"
    AddParam Envia, ""
    
    If Not Bac_Sql_Execute("SP_BUSCA_ACCESO_USUARIO", Envia) Then
        Screen.MousePointer = vbDefault
        MsgBox "Ha ocurrido un error al intentar obtener los datos de los usuarios", vbOKOnly + vbCritical
        Exit Sub
    Else
        cmbUsuario.Clear
        Do While Bac_SQL_Fetch(Datos)
            cmbUsuario.AddItem Datos(1)
            cmbIguala.AddItem Datos(1)
        Loop
    End If

    If Not Bac_Sql_Execute("SP_BACMNTMP_SISTEMA") Then
        Screen.MousePointer = vbDefault
        MsgBox "Ha ocurrido un error al intentar obtener los datos de los sistemas", vbOKOnly + vbCritical
        Exit Sub
    Else
        cmbSistema.Clear
        Do While Bac_SQL_Fetch(Datos())
           cmbSistema.AddItem (Datos(2) & Space(150) & Datos(1))
        Loop
    End If
    
            '-- PRD-21039
    '+++cvegasan 2017.06.05 Se dejan NY afuera en procedimiento almacenado
    'cmbSistema.RemoveItem (1) '--> Oculta Bonos Exterior NY
    'cmbSistema.RemoveItem (6) ' --> Oculta Swap NY
    '---cvegasan 2017.06.05 Se dejan NY afuera en procedimiento almacenado
    Call Proc_Limpiar
    Call LlenaGrilla
    
   cmbIguala.Enabled = False
   
    
End Sub
Private Sub Proc_Grabar()
    Dim bUtiliza    As Boolean
    Dim bDefaul     As Boolean
    Dim bRespuesta  As Boolean

    With Grd_Datos
        For nContador2 = 1 To .Rows - 1
        If .Rows = .Rows And Trim(.TextMatrix(nContador2, nColCodLibro)) = "" Or .Rows = .Rows And Trim(.TextMatrix(nContador2, nColCodCartNorm)) = "" _
            Or .Rows = .Rows And Trim(.TextMatrix(nContador2, nColDesLibro)) = "" Or .Rows = .Rows And Trim(.TextMatrix(nContador2, nColDesCartNorm)) = "" Then
            
            MsgBox "No se ha asignado ningun Libro o Cartera Normativa para grabar", vbExclamation
            
            Exit Sub
        End If
        Next nContador2
        
        For nContador1 = 1 To .Rows - 1
            If .TextMatrix(nContador1, nColDefault) = "SI" Then
                bDefaul = True
                Exit For
            End If
        Next nContador1


        If bDefaul = False Then
            Screen.MousePointer = vbDefault
            MsgBox "No ha seleccionado una opcion DEFAULT", vbOKOnly + vbExclamation
            Exit Sub
        End If
        
        For nContador1 = 1 To .Rows - 2
            For nContador2 = nContador1 + 1 To .Rows - 1
                                
                If Trim(.TextMatrix(nContador1, nColCodLibro)) = Trim(.TextMatrix(nContador2, nColCodLibro)) _
                        And Trim(.TextMatrix(nContador1, nColCodCartNorm)) = Trim(.TextMatrix(nContador2, nColCodCartNorm)) _
                        And IIf(Trim(.TextMatrix(nContador1, nColCodSubCartNorm)) = "", "N/A", Trim(.TextMatrix(nContador1, nColCodSubCartNorm))) = IIf(Trim(.TextMatrix(nContador2, nColCodSubCartNorm)) = "", "N/A", Trim(.TextMatrix(nContador2, nColCodSubCartNorm))) Then
                        
                    cmbSubCartNorm.Visible = False
                    MsgBox "Existe un Registro duplicado", vbExclamation
                    
                    .TextMatrix(.Row, nColCodSubCartNorm) = ""
                    .TextMatrix(.Row, nColDesSubCartNorm) = ""
                    Exit Sub
        
                End If
                    
            Next nContador2
        Next nContador1
        
        Screen.MousePointer = vbHourglass
        
        If Not Bac_Sql_Execute("BEGIN TRAN") Then
            Screen.MousePointer = vbDefault
            MsgBox "Ha ocurrido un error al intentar grabar la informacion", vbCritical
            Exit Sub
        End If
        
        Envia = Array()
        AddParam Envia, Trim(Right(cmbUsuario.Text, 10))
        AddParam Envia, Trim(Right(cmbSistema.Text, 10))
        AddParam Envia, Trim(Right(cmbProducto.Text, 10))
                
        If Not Bac_Sql_Execute("SP_DEL_REL_USUARIO_NORMATIVO", Envia) Then
            bRespuesta = Bac_Sql_Execute("ROLLBACK TRAN")
            Screen.MousePointer = vbDefault
            MsgBox "Ha ocurrido un error al intentar grabar la informacion", vbCritical
            Exit Sub
        End If
    
        For nContador1 = 1 To .Rows - 1
            
            'If .TextMatrix(nContador1, nColDefault) = "SI" Then
                
                Envia = Array()
                AddParam Envia, cmbUsuario.Text
                AddParam Envia, Trim(Right(cmbSistema.Text, 10))
                AddParam Envia, Trim(Right(cmbProducto.Text, 10))
                AddParam Envia, .TextMatrix(nContador1, nColCodLibro)
                AddParam Envia, .TextMatrix(nContador1, nColCodCartNorm)
                AddParam Envia, IIf(.TextMatrix(nContador1, nColCodSubCartNorm) = "", "N/A", .TextMatrix(nContador1, nColCodSubCartNorm))
                AddParam Envia, IIf(.TextMatrix(nContador1, nColDefault) = "SI", "S", "N")
                                                                      
                If Not Bac_Sql_Execute("SP_ACT_REL_USUARIO_NORMATIVO", Envia) Then
                    bRespuesta = Bac_Sql_Execute("ROLLBACK TRAN")
                    Screen.MousePointer = vbDefault
                    MsgBox "Ha ocurrido un error al intentar grabar la informacion", vbCritical
                    Exit Sub
                End If
            'End If
        Next nContador1
        
        
        bRespuesta = Bac_Sql_Execute("COMMIT TRAN")
        Screen.MousePointer = vbDefault
        MsgBox "La informacion ha sido grabada con exito", vbInformation, TITSISTEMA
        
        Call Proc_Limpiar
        
    End With


End Sub

Private Sub Proc_Eliminar()
  
    With Grd_Datos
            
        If Trim(.TextMatrix(.Row, nColCodLibro)) = "" Then
            Screen.MousePointer = vbDefault
            MsgBox "No ha seleccionado ningun usuario para eliminar", vbExclamation
            Exit Sub
        End If
        
        If MsgBox("Esta seguro de eliminar Usuario Normativo", vbQuestion + vbYesNo, TITSISTEMA) = vbNo Then
            Exit Sub
        End If
        
        Screen.MousePointer = vbHourglass
    
        For nContador1 = 1 To .Rows - 1
            
            Envia = Array()
            AddParam Envia, Trim(Right(cmbUsuario.Text, 10))
            AddParam Envia, Trim(Right(cmbSistema.Text, 10))
            AddParam Envia, Trim(Right(cmbProducto.Text, 10))
            
            
            If Not Bac_Sql_Execute("SP_DEL_REL_USUARIO_NORMATIVO", Envia) Then
                Screen.MousePointer = vbDefault
                MsgBox "Ha ocurrido un error al intentar grabar la informacion", vbCritical
                Exit Sub
            End If
        Next nContador1
    
            'Call GrdCartNorm_KeyDown(vbKeyDelete, 0)
            Screen.MousePointer = vbDefault
            MsgBox "El registro ha sido eliminado con exito", vbInformation
            Call Proc_Limpiar
    End With

Call LlenaGrilla
    
End Sub

Private Sub Grd_Datos_DblClick()

    Dim nFilaAnt As Integer
    Dim nColAnt  As Integer

    With Grd_Datos

        If .Enabled = False Then
            Exit Sub
        End If
        
        If Trim(Right(cmbProducto.Text, 10)) = "" Then
            Exit Sub
        End If
        
        If .Col = nColDesLibro Then
            If cmbLibro.ListCount > 0 Then
                For nContador1 = 0 To cmbLibro.ListCount - 1
                    If Trim(Right(cmbLibro.List(nContador1), 10)) = Trim(.TextMatrix(.Row, nColCodLibro)) Then
                        cmbLibro.ListIndex = nContador1
                        CodLibro = Trim(.TextMatrix(.Row, nColCodLibro))
                        Exit For
                        
                    
                    End If
                    
                Next nContador1

                cmbLibro.Visible = True
                cmbLibro.Width = .ColWidth(.Col)
                cmbLibro.Left = .Left + .CellLeft
                cmbLibro.Top = .Top + .CellTop
                cmbLibro.SetFocus
            End If
        End If
    
        If Trim(Grd_Datos.TextMatrix(Grd_Datos.Row, nColCodLibro)) = "" Then
            Exit Sub
        Else
            
            If .Col = nColDesCartNorm Then
            
            Envia = Array()
            AddParam Envia, 5 'opcion de busqueda de carteras normativas relacionadas a un libro
            AddParam Envia, Trim(Right(cmbSistema.Text, 10))
            AddParam Envia, Trim(Right(cmbProducto.Text, 10))
            AddParam Envia, .TextMatrix(.Row, nColCodLibro)
            AddParam Envia, ""
            AddParam Envia, GLB_CAT_CARTERA_NORMATIVA
            Call PROC_LLENA_COMBOS("SP_CON_INFO_COMBO", Envia, cmbCartNorm, False, PosCodigo, PosDescripcion)
                
                If cmbCartNorm.ListCount > 0 Then
                    For nContador1 = 0 To cmbCartNorm.ListCount - 1
                        If Trim(Right(cmbCartNorm.List(nContador1), 10)) = Trim(.TextMatrix(.Row, nColCodCartNorm)) Then
                            cmbCartNorm.ListIndex = nContador1
                            CODCARTNORM = Trim(.TextMatrix(.Row, nColCodCartNorm))
                            Exit For
                        End If
                    Next nContador1
                            
                    cmbCartNorm.Visible = True
                    cmbCartNorm.Width = .ColWidth(.Col)
                    cmbCartNorm.Left = .Left + .CellLeft
                    cmbCartNorm.Top = .Top + .CellTop
                    cmbCartNorm.SetFocus
                End If
            End If
            
            If .Col = nColDesSubCartNorm Then
                Envia = Array()
                AddParam Envia, 1
                AddParam Envia, GLB_CAT_SUBCARTERA_NORMATIVA
                AddParam Envia, .TextMatrix(.Row, nColCodCartNorm)
                Call PROC_LLENA_COMBOS("SP_CON_SUB_CART_NORM", Envia, cmbSubCartNorm, False, PosCodigo, PosDescripcion)
                cmbSubCartNorm.AddItem ""
            
                If cmbSubCartNorm.ListCount > 0 Then
                    For nContador1 = 0 To cmbSubCartNorm.ListCount - 1
                        If Trim(Right(cmbSubCartNorm.List(nContador1), 10)) = Trim(.TextMatrix(.Row, nColCodSubCartNorm)) Then
                            cmbSubCartNorm.ListIndex = nContador1
                            Exit For
                        End If
                    Next nContador1
                          
                    cmbSubCartNorm.Visible = True
                    cmbSubCartNorm.Width = .ColWidth(.Col)
                    cmbSubCartNorm.Left = .Left + .CellLeft
                    cmbSubCartNorm.Top = .Top + .CellTop
                    cmbSubCartNorm.SetFocus
                End If
            End If
       
            If Grd_Datos.Rows > 1 Then
                Tlb_Herramientas.Buttons(BtnGrabar).Enabled = True
                Tlb_Herramientas.Buttons(BtnEliminar).Enabled = True
            End If
        End If
        
    
        If .Col = nColDefault And .Row > 0 Then
            If .TextMatrix(.Row, .Col) = "SI" Then
                .TextMatrix(.Row, nColDefault) = "NO"
                .CellBackColor = vbRed
            Else 'OPCION NO
            
                nFilaAnt = .Row

                For nContador1 = 1 To .Rows - 1
                    If nFilaAnt <> nContador1 Then
                        If .TextMatrix(nContador1, nColDefault) = "SI" Then
                            .TextMatrix(nContador1, nColDefault) = "NO"
                            .Col = nColDefault
                            .Row = nContador1
                            .CellBackColor = vbRed
                            Exit For
                        End If
                    End If
                Next nContador1
                
                .TextMatrix(nFilaAnt, nColDefault) = "SI"
                .Row = nFilaAnt
                .Col = nColDefault
                .CellBackColor = vbGreen
            End If
        End If
                
    End With
         
End Sub


Private Sub Proc_Limpiar()

   Grd_Datos.Rows = 1
   
    cmbUsuario.ListIndex = -1
    cmbSistema.ListIndex = -1
    cmbProducto.ListIndex = -1
    Grd_Datos.AddItem ""
    Chk_IgualA = False
    
    Tlb_Herramientas.Buttons(BtnGrabar).Enabled = False
    Tlb_Herramientas.Buttons(BtnEliminar).Enabled = False
    
    cmbLibro.Visible = False
    cmbCartNorm.Visible = False
    cmbSubCartNorm.Visible = False
    
   
    Grd_Datos.Enabled = False
    Grd_Datos.ColWidth(nColUtiliza) = 0
    
    Call LlenaGrilla
    
    If cmbUsuario.ListIndex = -1 Then
        cmbSistema.Enabled = False
    End If
    
    If cmbSistema.ListIndex = -1 Then
        cmbProducto.Enabled = False
    End If
    
End Sub


Private Sub Grd_Datos_KeyDown(KeyCode As Integer, Shift As Integer)

With Grd_Datos

    Select Case KeyCode
    
        Case vbKeyInsert 'inserta
            If .TextMatrix(.Rows - 1, nColCodLibro) <> "" And .TextMatrix(.Rows - 1, nColDesLibro) <> "" _
               And .TextMatrix(.Rows - 1, nColCodCartNorm) <> "" And .TextMatrix(.Rows - 1, nColDesCartNorm) <> "" Then
                
                For nContador1 = 1 To .Rows - 2
                    For nContador2 = nContador1 + 1 To .Rows - 1
                        If Trim(.TextMatrix(nContador1, nColCodLibro)) = Trim(.TextMatrix(nContador2, nColCodLibro)) _
                            And Trim(.TextMatrix(nContador1, nColCodCartNorm)) = Trim(.TextMatrix(nContador2, nColCodCartNorm)) _
                            And Trim(.TextMatrix(nContador1, nColCodSubCartNorm)) = Trim(.TextMatrix(nContador2, nColCodSubCartNorm)) _
                            And nContador1 <> .Row Then
                    
                            cmbSubCartNorm.Visible = False
                            MsgBox "Registro seleccionado ya existe", vbExclamation
                            
                            .TextMatrix(.Row, nColCodSubCartNorm) = ""
                            .TextMatrix(.Row, nColDesSubCartNorm) = ""
                            Exit Sub
                        End If
                
                    Next nContador2
                Next nContador1
                                                
                .AddItem ""
                .SetFocus
                .Col = nColDesLibro
                .Row = .Rows - 1
            End If
    
        Case vbKeyDelete 'elimina
            If .Rows > 2 Then
                .RemoveItem .Row
            Else
                .TextMatrix(1, nColCodLibro) = ""
                .TextMatrix(1, nColDesLibro) = ""
            End If
            
        Case vbKeyReturn
            If .Col = nColDefault And .Row > 0 Then
                If .TextMatrix(.Row, .Col) = "SI" Then
                    .TextMatrix(.Row, nColDefault) = "NO"
                    .CellBackColor = vbRed
                Else 'OPCION NO
                
                    nFilaAnt = .Row
    
                    For nContador1 = 1 To .Rows - 1
                        If nFilaAnt <> nContador1 Then
                            If .TextMatrix(nContador1, nColDefault) = "SI" Then
                                .TextMatrix(nContador1, nColDefault) = "NO"
                                .Col = nColDefault
                                .Row = nContador1
                                .CellBackColor = vbRed
                                Exit For
                            End If
                        End If
                    Next nContador1
                    
                    .TextMatrix(nFilaAnt, nColDefault) = "SI"
                    .Row = nFilaAnt
                    .Col = nColDefault
                    .CellBackColor = vbGreen
                End If
            End If
        
    End Select

    End With

    
    
End Sub

Private Sub SSCheck1_Click(Value As Integer)
    
End Sub

Private Sub Tlb_Herramientas_ButtonClick(ByVal Button As MSComctlLib.Button)

    Select Case Button.Index
    
        Case BtnGrabar
           Call Proc_Grabar
              
        Case BtnEliminar
          Call Proc_Eliminar
            
        
        Case BtnLimpiar
            Call Proc_Limpiar
                
        Case BtnSalir
            Unload Me
        
    End Select

End Sub

