VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MsComCtl.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form Frm_Relacion_Producto_Libro 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Relacion Producto / Libro"
   ClientHeight    =   4965
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4920
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   4965
   ScaleWidth      =   4920
   Begin MSComctlLib.Toolbar Tlb_Herramientas 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   9
      Top             =   0
      Width           =   4920
      _ExtentX        =   8678
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
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
            Picture         =   "Frm_Relacion_Producto_Libro.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Frm_Relacion_Producto_Libro.frx":0452
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Frm_Relacion_Producto_Libro.frx":08A4
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Frm_Relacion_Producto_Libro.frx":177E
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Frm_Relacion_Producto_Libro.frx":1A98
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin Threed.SSFrame FrPrincipal 
      Height          =   4455
      Left            =   15
      TabIndex        =   0
      Top             =   495
      Width           =   4890
      _Version        =   65536
      _ExtentX        =   8625
      _ExtentY        =   7858
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
      Begin Threed.SSFrame FrGrilla 
         Height          =   3090
         Left            =   405
         TabIndex        =   5
         Top             =   1275
         Width           =   4110
         _Version        =   65536
         _ExtentX        =   7250
         _ExtentY        =   5450
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
         Begin VB.ComboBox CmbLibro 
            Height          =   315
            Left            =   120
            Style           =   2  'Dropdown List
            TabIndex        =   4
            Top             =   2670
            Width           =   3705
         End
         Begin MSFlexGridLib.MSFlexGrid GrdLibro 
            Height          =   2880
            Left            =   60
            TabIndex        =   3
            Top             =   150
            Width           =   3975
            _ExtentX        =   7011
            _ExtentY        =   5080
            _Version        =   393216
            Rows            =   1
            RowHeightMin    =   315
            BackColor       =   -2147483644
            BackColorFixed  =   8421376
            ForeColorFixed  =   8388608
            BackColorBkg    =   -2147483645
            HighLight       =   2
         End
      End
      Begin Threed.SSFrame FrIds 
         Height          =   1065
         Left            =   60
         TabIndex        =   6
         Top             =   135
         Width           =   4740
         _Version        =   65536
         _ExtentX        =   8361
         _ExtentY        =   1879
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
         Begin VB.ComboBox CmbSistema 
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
            Left            =   930
            Style           =   2  'Dropdown List
            TabIndex        =   1
            Top             =   285
            Width           =   3735
         End
         Begin VB.ComboBox CmbProducto 
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
            Left            =   930
            Style           =   2  'Dropdown List
            TabIndex        =   2
            Top             =   645
            Width           =   3735
         End
         Begin VB.Label LblSistema 
            AutoSize        =   -1  'True
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
            Height          =   195
            Left            =   60
            TabIndex        =   8
            Top             =   360
            Width           =   675
         End
         Begin VB.Label LblProducto 
            AutoSize        =   -1  'True
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
            Height          =   195
            Left            =   60
            TabIndex        =   7
            Top             =   705
            Width           =   780
         End
      End
   End
End
Attribute VB_Name = "Frm_Relacion_Producto_Libro"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private nContador   As Integer



'CONSTANTE DE LA COLUMNA DESCRIPCION
Const nCol_Codigo = 0
Const ncol_Descripcion = 1

'CONSTANTE DE LA FILA CABECERA
Const nFila_Cabecera = 0

'CONSTANTES DE BOTONES DE LA TOOLBAR
Const BtnGrabar = 1
Const BtnEliminar = 2
Const BtnBuscar = 3
Const BtnLimpiar = 4
Const BtnSalir = 5

'CONSTANTE DE RETORNO DE sp_btr_sistemas_activos
Const PosCodSistema = 1
Const PosDescSistema = 2

'CONSTANTE DE RETORNO DE SP_BACMNTCR_BUSCAPRODUCTO
Const nPro_Codigo = 1
Const nPro_Descripcion = 2

'CONSTANTE DE RETORNO DE SP_CON_INFO_COMBO
Const PosCodigo = 2
Const PosDescripcion = 6






Private Sub Proc_Buscar()

    Envia = Array()
    AddParam Envia, 4 'opcion de busqueda
    AddParam Envia, Trim(Right(cmbSistema.Text, 10))
    AddParam Envia, Trim(Right(CmbProducto.Text, 10))
    AddParam Envia, ""
    AddParam Envia, GLB_CAT_LIBRO
    
    If Not Bac_Sql_Execute("SP_CON_INFO_COMBO", Envia) Then
        Screen.MousePointer = vbDefault
        MsgBox "Ha ocurrido un error al intentar buscar los libros relacionados", vbCritical, TITSISTEMA
        Exit Sub
    End If
    
    With GrdLibro
    
        .Rows = 1
    
        Do While Bac_SQL_Fetch(Datos())
            .AddItem ""
            .TextMatrix(.Rows - 1, nCol_Codigo) = Trim(Datos(PosCodigo))
            .TextMatrix(.Rows - 1, ncol_Descripcion) = Trim(Datos(PosDescripcion))
        Loop
        
        If .Rows = 1 Then
            .Rows = 2
            Tlb_Herramientas.Buttons(BtnGrabar).Enabled = False
            Tlb_Herramientas.Buttons(BtnEliminar).Enabled = False
        Else
            Tlb_Herramientas.Buttons(BtnGrabar).Enabled = True
            Tlb_Herramientas.Buttons(BtnEliminar).Enabled = True
        End If
        
    End With
    
    cmbSistema.Enabled = False
    CmbProducto.Enabled = False
    GrdLibro.Enabled = True
    

End Sub

Private Sub Proc_Eliminar()

    With GrdLibro
        
        If Trim(.TextMatrix(.Row, nCol_Codigo)) = "" Then
            Screen.MousePointer = vbDefault
            MsgBox "No ha seleccionado ningun libro para eliminar", vbExclamation
            Exit Sub
        End If
        
        Screen.MousePointer = vbHourglass
        
        Envia = Array()
        AddParam Envia, Trim(Right(cmbSistema.Text, 10))
        AddParam Envia, Trim(Right(CmbProducto.Text, 10))
        AddParam Envia, .TextMatrix(.Row, nCol_Codigo)
        
        If Not Bac_Sql_Execute("SP_DEL_REL_PRODUCTO_LIBRO ", Envia) Then
            Screen.MousePointer = vbDefault
            MsgBox "Ha ocurrido un error al intentar grabar la informacion", vbCritical
            Exit Sub
        Else
''''            If Bac_SQL_Fetch(Datos()) Then
''''                If Datos(1) <> "" Then
''''                    Screen.MousePointer = vbDefault
''''                    MsgBox "El Registro no puede ser eliminado ya que existen relaciones con alguna Cartera Super", vbExclamation, Me.Caption
''''                    Exit Sub
''''                End If
''''            End If

        
            Call GrdLibro_KeyDown(vbKeyDelete, 0)
            Screen.MousePointer = vbDefault
            MsgBox "El registro ha sido eliminado con exito", vbInformation
        End If
        
    End With
    
End Sub

Private Sub Proc_Grabar()

    Dim bRespuesta As String

    With GrdLibro
        
        If .Rows = 2 And Trim(.TextMatrix(1, nCol_Codigo)) = "" Then
            MsgBox "No se ha asignado ningun libro para grabar", vbExclamation
            Exit Sub
        End If
        
        Screen.MousePointer = vbHourglass
        
        
        If Not Bac_Sql_Execute("BEGIN TRAN") Then
            Screen.MousePointer = vbDefault
            MsgBox "Ha ocurrido un error al intentar grabar la informacion", vbCritical
            Exit Sub
        End If
        
        Envia = Array()
        AddParam Envia, Trim(Right(cmbSistema.Text, 10))
        AddParam Envia, Trim(Right(CmbProducto.Text, 10))
        
        If Not Bac_Sql_Execute("SP_DEL_REL_PRODUCTO_LIBRO ", Envia) Then
            bRespuesta = Bac_Sql_Execute("ROLLBACK TRAN")
            Screen.MousePointer = vbDefault
            MsgBox "Ha ocurrido un error al intentar grabar la informacion", vbCritical
            Exit Sub
        End If
    
        For nContador = 1 To .Rows - 1
        
            Envia = Array()
            AddParam Envia, Trim(Right(cmbSistema.Text, 10))
            AddParam Envia, Trim(Right(CmbProducto.Text, 10))
            AddParam Envia, .TextMatrix(nContador, nCol_Codigo)
                                                                      
            If Not Bac_Sql_Execute("SP_ACT_REL_PRODUCTO_LIBRO ", Envia) Then
                bRespuesta = Bac_Sql_Execute("ROLLBACK TRAN")
                Screen.MousePointer = vbDefault
                MsgBox "Ha ocurrido un error al intentar grabar la informacion", vbCritical
                Exit Sub
            End If
            
        Next nContador
        
        bRespuesta = Bac_Sql_Execute("COMMIT TRAN")
        Screen.MousePointer = vbDefault
        MsgBox "La informacion ha sido grabada con exito", vbInformation, TITSISTEMA
        Call Proc_Limpiar
    
    End With


End Sub

Private Sub Proc_Limpiar()

    GrdLibro.Rows = 1
    GrdLibro.AddItem ""
    
    Tlb_Herramientas.Buttons(BtnGrabar).Enabled = False
    Tlb_Herramientas.Buttons(BtnEliminar).Enabled = False
    
    CmbLibro.Visible = False
    
    cmbSistema.Enabled = True
    CmbProducto.Enabled = True
    
    GrdLibro.Enabled = False
    
End Sub

Private Sub CmbLibro_GotFocus()

    With GrdLibro
    
        If Trim(.TextMatrix(.Row, nCol_Codigo)) <> "" Then
            For nContador = 1 To CmbLibro.ListCount - 1
                If Trim(Right(CmbLibro.List(nContador), 10)) = Trim(.TextMatrix(.Row, nCol_Codigo)) Then
                    CmbLibro.ListIndex = nContador
                    Exit For
                End If
            Next nContador
        End If

    End With


End Sub

Private Sub CmbLibro_KeyDown(KeyCode As Integer, Shift As Integer)
    
    Select Case KeyCode
        Case vbKeyReturn
            With GrdLibro
                For nContador = 1 To .Rows - 1
                    If Trim(Right(CmbLibro.Text, 10)) = Trim(.TextMatrix(nContador, nCol_Codigo)) And nContador <> .Row Then
                        MsgBox "Libro seleccionado ya existe", vbExclamation
                        CmbLibro.Visible = False
                        Exit Sub
                    End If
                Next nContador
        
                .TextMatrix(.Row, nCol_Codigo) = Trim(Right(CmbLibro.Text, 10))
                .TextMatrix(.Row, ncol_Descripcion) = Trim(Left(CmbLibro.Text, 50))
                
                CmbLibro.Visible = False
                
                Tlb_Herramientas.Buttons(BtnGrabar).Enabled = True
                Tlb_Herramientas.Buttons(BtnEliminar).Enabled = True
            End With
            
        Case vbKeyEscape
            CmbLibro.Visible = False
            GrdLibro.SetFocus
    End Select

End Sub

Private Sub CmbLibro_LostFocus()
    
    CmbLibro.Visible = False
    
    
End Sub


Private Sub cmbSistema_Click()
    
    Envia = Array()
    AddParam Envia, Trim(Right(cmbSistema.Text, 10))
    
    Call PROC_LLENA_COMBOS("SP_BACMNTCR_BUSCAPRODUCTO", Envia, CmbProducto, False, 1, 2)
    
End Sub


Private Sub Form_Load()

    Tlb_Herramientas.Buttons(BtnGrabar).Enabled = False
    Tlb_Herramientas.Buttons(BtnEliminar).Enabled = False
    
    Envia = Array()
    AddParam Envia, 1
    AddParam Envia, GLB_CAT_LIBRO
    
    Call PROC_LLENA_COMBOS("SP_CON_INFO_COMBO", Envia, CmbLibro, False, PosCodigo, PosDescripcion)
    Call PROC_LLENA_COMBOS("Sp_CmbSistema", Array(), cmbSistema, False, PosCodSistema, PosDescSistema)
    
    GrdLibro.TextMatrix(nFila_Cabecera, ncol_Descripcion) = "Libro"
    GrdLibro.ColWidth(nCol_Codigo) = 0
    GrdLibro.ColWidth(ncol_Descripcion) = 3600
    GrdLibro.Rows = 2
    GrdLibro.GridLines = flexGridRaised
    
    'CmbLibro.Visible = False
    
    Call Proc_Limpiar
       

End Sub


Private Sub GrdCartNorm_Click()

End Sub


Private Sub GrdCartNorm_DblClick()

    

End Sub


Private Sub GrdLibro_DblClick()
    
    Dim nContador As Integer
    
    With GrdLibro
        If .Col = ncol_Descripcion Then
            If CmbLibro.ListCount > 0 Then
                For nContador = 0 To CmbLibro.ListCount - 1
                    If Trim(Right(CmbLibro.List(nContador), 10)) = Trim(.TextMatrix(.Row, nCol_Codigo)) Then
                        CmbLibro.ListIndex = nContador
                        Exit For
                    End If
                Next nContador
            
                CmbLibro.ListIndex = IIf(CmbLibro.ListCount > 0, 0, -1)
                CmbLibro.Visible = True
                CmbLibro.Width = .ColWidth(.Col)
                CmbLibro.Left = .Left + .CellLeft
                CmbLibro.Top = .Top + .CellTop
                CmbLibro.SetFocus
            End If
        End If
    End With

End Sub


Private Sub GrdLibro_KeyDown(KeyCode As Integer, Shift As Integer)
    
    With GrdLibro
    
        Select Case KeyCode
            
            Case vbKeyInsert 'inserta
                If .TextMatrix(.Rows - 1, nCol_Codigo) <> "" And .TextMatrix(.Rows - 1, ncol_Descripcion) <> "" Then
                    .AddItem ""
                    .SetFocus
                    .Col = ncol_Descripcion
                    .Row = .Rows - 1
                End If
            
            Case vbKeyDelete 'elimina
                If .Rows > 2 Then
                    .RemoveItem .Row
                Else
                    .TextMatrix(1, nCol_Codigo) = ""
                    .TextMatrix(1, ncol_Descripcion) = ""
                End If
        End Select

    End With
    
End Sub


Private Sub GrdLibro_KeyPress(KeyAscii As Integer)


   If Not IsNumeric(Chr(KeyAscii)) And UCase(Chr(KeyAscii)) < "A" And UCase(Chr(KeyAscii)) > "Z" And KeyAscii <> 13 And KeyAscii <> 8 Then
      KeyAscii = 0
   End If
   
   If KeyAscii = 13 Then
       Call GrdLibro_DblClick
   End If

End Sub


Private Sub Tlb_Herramientas_ButtonClick(ByVal Button As MSComctlLib.Button)

    Select Case Button.Index
    
        Case BtnGrabar
            Call Proc_Grabar
                
        Case BtnEliminar
            Call Proc_Eliminar
            
        Case BtnBuscar
            Call Proc_Buscar
                
        Case BtnLimpiar
            Call Proc_Limpiar
                
        Case BtnSalir
            Unload Me
        
    End Select

End Sub


