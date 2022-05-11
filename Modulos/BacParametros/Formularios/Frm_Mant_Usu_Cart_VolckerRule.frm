VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form Frm_Mant_Usu_Cart_VolckerRule 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantención Usuarios Cartera VolckerRule"
   ClientHeight    =   6390
   ClientLeft      =   105
   ClientTop       =   435
   ClientWidth     =   4860
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   6390
   ScaleWidth      =   4860
   Begin VB.Frame frGrilla 
      Caption         =   "Mantención Usuarios"
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
      Height          =   3780
      Left            =   60
      TabIndex        =   10
      Top             =   2580
      Width           =   4755
      Begin MSFlexGridLib.MSFlexGrid Grd_Datos 
         Height          =   3465
         Left            =   90
         TabIndex        =   11
         Top             =   210
         Width           =   4590
         _ExtentX        =   8096
         _ExtentY        =   6112
         _Version        =   393216
         Cols            =   3
         FixedCols       =   0
         AllowBigSelection=   0   'False
      End
   End
   Begin VB.Frame frIds 
      Height          =   1950
      Left            =   60
      TabIndex        =   0
      Top             =   600
      Width           =   4770
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
         Left            =   1065
         Style           =   2  'Dropdown List
         TabIndex        =   6
         Top             =   930
         Width           =   2490
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
         Left            =   1065
         Style           =   2  'Dropdown List
         TabIndex        =   5
         Top             =   555
         Width           =   2490
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
         Left            =   1065
         Style           =   2  'Dropdown List
         TabIndex        =   4
         Top             =   180
         Width           =   2490
      End
      Begin VB.Frame Fr_IgualA 
         Height          =   540
         Left            =   1005
         TabIndex        =   1
         Top             =   1290
         Width           =   3630
         Begin VB.ComboBox cmbIguala 
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
            Left            =   1515
            Style           =   2  'Dropdown List
            TabIndex        =   2
            Top             =   150
            Width           =   2025
         End
         Begin Threed.SSCheck Chk_IgualA 
            Height          =   360
            Left            =   135
            TabIndex        =   3
            Top             =   135
            Width           =   1230
            _Version        =   65536
            _ExtentX        =   2170
            _ExtentY        =   635
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
         Height          =   210
         Index           =   2
         Left            =   120
         TabIndex        =   9
         Top             =   990
         Width           =   840
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
         Height          =   270
         Index           =   1
         Left            =   105
         TabIndex        =   8
         Top             =   585
         Width           =   765
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
         Height          =   210
         Index           =   0
         Left            =   120
         TabIndex        =   7
         Top             =   240
         Width           =   1020
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   3015
      Top             =   45
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
            Picture         =   "Frm_Mant_Usu_Cart_VolckerRule.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Frm_Mant_Usu_Cart_VolckerRule.frx":0452
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Frm_Mant_Usu_Cart_VolckerRule.frx":08A4
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Frm_Mant_Usu_Cart_VolckerRule.frx":0BBE
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Tbl_Opciones 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   12
      Top             =   0
      Width           =   4860
      _ExtentX        =   8573
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
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   4
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSComctlLib.ImageList ImageList2 
      Left            =   0
      Top             =   0
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
            Picture         =   "Frm_Mant_Usu_Cart_VolckerRule.frx":0ED8
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Frm_Mant_Usu_Cart_VolckerRule.frx":132A
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Frm_Mant_Usu_Cart_VolckerRule.frx":177C
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Frm_Mant_Usu_Cart_VolckerRule.frx":1A96
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "Frm_Mant_Usu_Cart_VolckerRule"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
' LD1-COR-035 MIGRACION ITAU
'CARTERA VOLCKER RULE
Dim DATOS()
Dim nContador1    As Integer

Private Const nColDesCart = 0
Private Const nColUtiliza = 1
Private Const nColDefault = 2
Private Const nColCodCart = 3

Private Const BtnGrabar = 1
Private Const BtnEliminar = 2
Private Const BtnLimpiar = 3
Private Const BtnSalir = 4

'CONSTANTE DE RETORNO DE SP_BACMNTCR_BUSCAPRODUCTO
Const nPro_Codigo = 1
Const nPro_Descripcion = 2

Private Sub Proc_Grabar()

    Dim bUtiliza    As Boolean
    Dim bDefaul     As Boolean
    Dim bRespuesta  As Boolean

    With Grd_Datos
                    
        'If .Rows = 1 And Trim(.TextMatrix(1, nColCodCart)) = "" Then
            
        If .Rows = 1 Then
            MsgBox "No se ha asignado ninguna Cartera para grabar", vbExclamation
            Tbl_Opciones.Buttons(BtnGrabar).Enabled = False
            Tbl_Opciones.Buttons(BtnEliminar).Enabled = False
            Exit Sub
        End If
        
        If .Rows = 2 And Trim(.TextMatrix(1, nColCodCart)) = "" Then
            MsgBox "No se ha asignado ningun Usuario para grabar", vbExclamation
            Exit Sub
        End If
        
        bUtiliza = False
        
        For nContador1 = 1 To .Rows - 1
            If .TextMatrix(nContador1, nColUtiliza) = "SI" Then
                bUtiliza = True
                Exit For
            End If
        Next nContador1

        If bUtiliza = True Then
            bDefaul = False
            
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
        End If
        
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
                
        If Not Bac_Sql_Execute("SP_DEL_REL_USU_CART_VOLCKER_RULE", Envia) Then
            bRespuesta = Bac_Sql_Execute("ROLLBACK TRAN")
            Screen.MousePointer = vbDefault
            MsgBox "Ha ocurrido un error al intentar grabar la informacion", vbCritical
            Exit Sub
        End If
    
        For nContador1 = 1 To .Rows - 1
            If .TextMatrix(nContador1, nColUtiliza) = "SI" Then
                Envia = Array()
                AddParam Envia, cmbUsuario.Text
                AddParam Envia, Trim(Right(cmbSistema.Text, 10))
                AddParam Envia, Trim(Right(cmbProducto.Text, 10))
                AddParam Envia, .TextMatrix(nContador1, nColCodCart)
                AddParam Envia, IIf(.TextMatrix(nContador1, nColDefault) = "SI", "S", "N")
                                                                      
                If Not Bac_Sql_Execute("SP_ACT_REL_USU_CART_VOLCKER_RULE", Envia) Then
                    bRespuesta = Bac_Sql_Execute("ROLLBACK TRAN")
                    Screen.MousePointer = vbDefault
                    MsgBox "Ha ocurrido un error al intentar grabar la informacion", vbCritical
                    Exit Sub
                End If
            End If
        Next nContador1
        
        bRespuesta = Bac_Sql_Execute("COMMIT TRAN")
        Screen.MousePointer = vbDefault
        MsgBox "La informacion ha sido grabada con exito", vbInformation, TITSISTEMA
        Call Proc_Limpiar
    
    End With


End Sub

Private Sub Proc_Limpiar()

   Screen.MousePointer = vbDefault
   
   cmbUsuario.Enabled = True
       
    With Grd_Datos
    
        .Cols = 4
        .ColWidth(nColDesCart) = 2900
        .ColWidth(nColUtiliza) = 750
        .ColWidth(nColDefault) = 830
        .ColWidth(nColCodCart) = 0
        
        .TextMatrix(0, nColDesCart) = "CARTERA"
        .TextMatrix(0, nColUtiliza) = "OPERA"
        .TextMatrix(0, nColDefault) = "DEFAULT"
        .TextMatrix(0, nColCodCart) = "CODIGO CARTERA"
        
        .RowHeight(0) = 400
        .ColAlignment(nColUtiliza) = flexAlignCenterCenter
        .ColAlignment(nColDefault) = flexAlignCenterCenter
        
    End With
   
    ''''If Me.Visible = True Then
        cmbUsuario.ListIndex = -1
        cmbSistema.ListIndex = -1
        cmbProducto.ListIndex = -1
        Grd_Datos.Rows = 1
        
    ''''End If
   
    If cmbUsuario.ListIndex = -1 Then
        cmbSistema.Enabled = False
    End If
    
    If cmbSistema.ListIndex = -1 Then
        cmbProducto.Enabled = False
    End If
    
    cmbIguala.ListIndex = -1
    
    Chk_IgualA.Value = False
'    cmbIguala.Enabled = False
   
    Tbl_Opciones.Buttons(BtnGrabar).Enabled = False
    Tbl_Opciones.Buttons(BtnEliminar).Enabled = False
    
'    If Me.Visible = True Then
'        cmbSistema.SetFocus
'    End If

End Sub
Private Sub Proc_Eliminar()
  
    With Grd_Datos
            
        If Trim(.TextMatrix(.Row, nColCodCart)) = "" Then
            Screen.MousePointer = vbDefault
            MsgBox "No ha seleccionado ningun usuario para eliminar", vbExclamation
            Exit Sub
        End If
        
        If MsgBox("Esta seguro de eliminar Usuario, Cartera Financiara", vbQuestion + vbYesNo, TITSISTEMA) = vbNo Then
            Exit Sub
        End If
        
        Screen.MousePointer = vbHourglass
    
        For nContador1 = 1 To .Rows - 1
            
            Envia = Array()
            AddParam Envia, Trim(Right(cmbUsuario.Text, 10))
            AddParam Envia, Trim(Right(cmbSistema.Text, 10))
            AddParam Envia, Trim(Right(cmbProducto.Text, 10))
            'AddParam Envia, Trim(.TextMatrix(.Row, nColCodCart))
            
            If Not Bac_Sql_Execute("SP_DEL_REL_USU_CART_VOLCKER_RULE", Envia) Then
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


End Sub

Private Sub Chk_IgualA_Click(Value As Integer)

    If Chk_IgualA.Value = True Then
        cmbIguala.Enabled = True
    Else
        cmbIguala.Enabled = False
        cmbIguala.ListIndex = -1
    End If

End Sub

Private Sub cmbIgualA_Change()
    If Me.Visible = True Then
        If cmbIguala.ListIndex > -1 Then
            cmbIguala.Enabled = True
        End If
    End If
End Sub

Private Sub cmbIgualA_Click()
    
    If cmbIguala.ListIndex = -1 Then
        Exit Sub
    End If
     
    If cmbUsuario.ListIndex = -1 Or cmbSistema.ListIndex = -1 Or cmbProducto.ListIndex = -1 Then
        Screen.MousePointer = vbDefault
        MsgBox "Debe seleccionar un Usuario, Sistema y Producto antes de este item", vbExclamation + vbOKOnly
        Chk_IgualA.Value = False
        Exit Sub
    End If
    
    If cmbIguala.Text = cmbUsuario.Text And cmbIguala.Text <> "" Then
        Screen.MousePointer = vbDefault
        MsgBox "No puede seleccionar al mismo usuario", vbExclamation + vbOKOnly
        cmbIguala.ListIndex = -1
        Exit Sub
    End If
    
    Grd_Datos.Rows = 1

    Envia = Array()
    AddParam Envia, Trim(Right(cmbProducto.Text, 10))
    AddParam Envia, Trim(Right(cmbSistema.Text, 10))
    AddParam Envia, GLB_CAT_VOLCKER_RULE
    
    If Not Bac_Sql_Execute("SP_MDRCLEERCODIGO_VOLCKER_RULE ", Envia) Then
        Screen.MousePointer = vbDefault
        MsgBox "Problemas al leer carteras por producto", vbCritical, TITSISTEMA
        Exit Sub
    End If
    
    Do While Bac_SQL_Fetch(DATOS())
        With Grd_Datos
            .Rows = .Rows + 1
            .TextMatrix(.Rows - 1, nColCodCart) = Trim(DATOS(1))
            .TextMatrix(.Rows - 1, nColDesCart) = Trim(DATOS(2))
            .Row = .Rows - 1
            .Col = nColUtiliza
            .TextMatrix(.Row, nColUtiliza) = "NO"
            .CellBackColor = vbRed
            .Col = nColDefault
            .TextMatrix(.Row, nColDefault) = "NO"
            .CellBackColor = vbRed
        End With
    Loop
    
    Envia = Array()
    AddParam Envia, Trim(cmbIguala.Text)
    AddParam Envia, Trim(Right(cmbSistema.Text, 10))
    AddParam Envia, Trim(Right(cmbProducto.Text, 10))
    
    If Not Bac_Sql_Execute("SP_CON_REL_USU_CART_VOLCKER_RULE", Envia) Then
        Screen.MousePointer = vbDefault
        MsgBox "Ha ocurrido un error al intentar leer la parametrizacion del usuario", vbCritical + vbOKOnly, TITSISTEMA
        Exit Sub
    End If
    
    Do While Bac_SQL_Fetch(DATOS())
        With Grd_Datos
            For nContador1 = 1 To Grd_Datos.Rows - 1
                If Trim(DATOS(4)) = .TextMatrix(nContador1, nColCodCart) Then
                    .Col = nColUtiliza
                    .Row = nContador1
                    .TextMatrix(.Row, .Col) = "SI"
                    .CellBackColor = vbGreen
                    
                    If Trim(DATOS(5)) = "S" Then
                        .Col = nColDefault
                        .TextMatrix(.Row, .Col) = "SI"
                        .CellBackColor = vbGreen
                    End If
                    
                    Exit For
                End If
            Next nContador1
        End With
    Loop
    
    If Grd_Datos.Rows > 1 Then
        Tbl_Opciones.Buttons(BtnGrabar).Enabled = True
        Tbl_Opciones.Buttons(BtnEliminar).Enabled = True
    End If

End Sub

Private Sub cmbProducto_Click()
    If cmbProducto.ListIndex = -1 Then
        Exit Sub
    End If
    
    Grd_Datos.Rows = 1

    Envia = Array()
    AddParam Envia, Trim(Right(cmbProducto.Text, 10))
    AddParam Envia, Trim(Right(cmbSistema.Text, 10))
    AddParam Envia, 206 '-> GLB_CAT_VOLCKER_RULE
    If Not Bac_Sql_Execute("SP_MDRCLEERCODIGO_VOLCKER_RULE", Envia) Then
        Screen.MousePointer = vbDefault
        MsgBox "Problemas al leer carteras por producto", vbCritical, TITSISTEMA
        Exit Sub
    End If
    
    Do While Bac_SQL_Fetch(DATOS())
        With Grd_Datos
            .Rows = .Rows + 1
            .TextMatrix(.Rows - 1, nColCodCart) = Trim(DATOS(1))
            .TextMatrix(.Rows - 1, nColDesCart) = Trim(DATOS(2))
            .Row = .Rows - 1
            .Col = nColUtiliza
            .TextMatrix(.Row, nColUtiliza) = "NO"
            .CellBackColor = vbRed
            .Col = nColDefault
            .TextMatrix(.Row, nColDefault) = "NO"
            .CellBackColor = vbRed
        End With
    Loop
    
    Envia = Array()
    AddParam Envia, Trim(cmbUsuario.Text)
    AddParam Envia, Trim(Right(cmbSistema.Text, 10))
    AddParam Envia, Trim(Right(cmbProducto.Text, 10))
    
    If Not Bac_Sql_Execute("SP_CON_REL_USU_CART_VOLCKER_RULE", Envia) Then
        Screen.MousePointer = vbDefault
        MsgBox "Ha ocurrido un error al intentar leer la parametrizacion del usuario", vbCritical + vbOKOnly, TITSISTEMA
        Exit Sub
    End If
    
    Do While Bac_SQL_Fetch(DATOS())
        With Grd_Datos
            For nContador1 = 1 To Grd_Datos.Rows - 1
                If Trim(DATOS(4)) = .TextMatrix(nContador1, nColCodCart) Then
                    .Col = nColUtiliza
                    .Row = nContador1
                    .TextMatrix(.Row, .Col) = "SI"
                    .CellBackColor = vbGreen
                    
                    If Trim(DATOS(5)) = "S" Then
                        .Col = nColDefault
                        .TextMatrix(.Row, .Col) = "SI"
                        .CellBackColor = vbGreen
                    End If
                    
                    Exit For
                End If
            Next nContador1
        End With
    Loop
    
    If Grd_Datos.Rows > 1 Then
        Tbl_Opciones.Buttons(BtnGrabar).Enabled = True
        Tbl_Opciones.Buttons(BtnEliminar).Enabled = True
    End If
    Chk_IgualA.Value = False
    cmbIguala.ListIndex = -1
End Sub

Private Sub cmbSistema_Click()

    Envia = Array()
    AddParam Envia, Trim(Right(cmbSistema.Text, 10))
    
    Call PROC_LLENA_COMBOS("Sp_BacMan_BuscaProducto", Envia, cmbProducto, False, nPro_Codigo, nPro_Descripcion, False)

    If Me.Visible = True Then
        If cmbSistema.ListIndex > -1 Then
            cmbProducto.Enabled = True
        End If
    End If
    
    cmbProducto.ListIndex = -1
    Chk_IgualA.Value = False
    cmbIguala.ListIndex = -1
End Sub

Private Sub cmbUsuario_Click()

    If Me.Visible = True Then
        If cmbUsuario.ListIndex > -1 Then
            cmbSistema.Enabled = True
        End If
    End If
    
    cmbSistema.ListIndex = -1
    cmbProducto.ListIndex = -1
    cmbIguala.ListIndex = -1
    Grd_Datos.Rows = 1
    
    Tbl_Opciones.Buttons(BtnGrabar).Enabled = False
    Tbl_Opciones.Buttons(BtnEliminar).Enabled = False

    If cmbSistema.ListIndex = -1 Then
        cmbProducto.Enabled = False
    End If
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
        Do While Bac_SQL_Fetch(DATOS)
            cmbUsuario.AddItem DATOS(1)
            cmbIguala.AddItem DATOS(1)
        Loop
    End If

    If Not Bac_Sql_Execute("SP_BACMNTMP_SISTEMA") Then
        Screen.MousePointer = vbDefault
        MsgBox "Ha ocurrido un error al intentar obtener los datos de los sistemas", vbOKOnly + vbCritical
        Exit Sub
    Else
        cmbSistema.Clear
        Do While Bac_SQL_Fetch(DATOS())
           cmbSistema.AddItem (DATOS(2) & Space(150) & DATOS(1))
        Loop
    End If
    
      '-- PRD-21039
    cmbSistema.RemoveItem (1) '--> Oculta Bonos Exterior NY
    cmbSistema.RemoveItem (6) ' --> Oculta Swap NY
    
   Call Proc_Limpiar
    cmbIguala.Enabled = False
End Sub

Private Sub Grd_Datos_DblClick()

    Dim nFilaAnt As Integer
    Dim nColAnt  As Integer

    With Grd_Datos
    
        If .Col = nColUtiliza And .Row > 0 Then
            If .TextMatrix(.Row, nColUtiliza) = "SI" Then
                .TextMatrix(.Row, nColUtiliza) = "NO"
                .CellBackColor = vbRed
                .TextMatrix(.Row, nColDefault) = "NO"
                .Col = nColDefault
                .CellBackColor = vbRed
            Else
                .TextMatrix(.Row, nColUtiliza) = "SI"
                .CellBackColor = vbGreen
            End If
            .Col = nColUtiliza
        End If
            
        If .Col = nColDefault And .Row > 0 Then
            If .TextMatrix(.Row, .Col) = "SI" Then
                .TextMatrix(.Row, nColDefault) = "NO"
                .CellBackColor = vbRed
            Else 'OPCION NO
                
                If .TextMatrix(.Row, nColUtiliza) = "NO" Then
                    Exit Sub
                End If
            
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


Private Sub Grd_Datos_KeyDown(KeyCode As Integer, Shift As Integer)
           
Dim nFilaAnt As Integer
Dim nColAnt  As Integer
           
    Select Case KeyCode
        Case vbKeyReturn
    
            With Grd_Datos
            
                If .Col = nColUtiliza And .Row > 0 Then
                    If .TextMatrix(.Row, nColUtiliza) = "SI" Then
                        .TextMatrix(.Row, nColUtiliza) = "NO"
                        .CellBackColor = vbRed
                        .TextMatrix(.Row, nColDefault) = "NO"
                        .Col = nColDefault
                        .CellBackColor = vbRed
                    Else
                        .TextMatrix(.Row, nColUtiliza) = "SI"
                        .CellBackColor = vbGreen
                    End If
                    .Col = nColUtiliza
                End If
                    
                If .Col = nColDefault And .Row > 0 Then
                    If .TextMatrix(.Row, .Col) = "SI" Then
                        .TextMatrix(.Row, nColDefault) = "NO"
                        .CellBackColor = vbRed
                    Else 'OPCION NO
                        
                        If .TextMatrix(.Row, nColUtiliza) = "NO" Then
                            Exit Sub
                        End If
                    
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
           
    End Select
End Sub


Private Sub Tbl_Opciones_ButtonClick(ByVal Button As MSComctlLib.Button)
    
    Select Case Button.Index
      
      Case BtnLimpiar
         Proc_Limpiar
      
      Case BtnGrabar
         Proc_Grabar
      
      Case BtnEliminar
         Proc_Eliminar
      
      Case BtnSalir
         Unload Me

   End Select

End Sub

Private Sub GrdCartNorm_KeyDown(KeyCode As Integer, Shift As Integer)
    
    With Grd_Datos
    
        Select Case KeyCode
            
            Case vbKeyInsert 'inserta
                If .TextMatrix(.Rows - 1, nColDesCart) <> "" And .TextMatrix(.Rows - 1, nColUtiliza) <> "" _
                And .TextMatrix(.Rows - 1, nColDefault) <> "" And .TextMatrix(.Rows - 1, nColCodCart) <> "" Then
                    .AddItem ""
                    .SetFocus
                    .Col = nColDesCart
                    .Row = .Rows - 1
                End If
            
            Case vbKeyDelete 'elimina
                If .Rows > 2 Then
                    .RemoveItem .Rows
                Else
                    .TextMatrix(1, nColDesCart) = ""
                    .TextMatrix(1, nColUtiliza) = ""
                    .TextMatrix(1, nColDefault) = ""
                    .TextMatrix(1, nColCodCart) = ""
                    
                End If
        End Select

    End With


End Sub


