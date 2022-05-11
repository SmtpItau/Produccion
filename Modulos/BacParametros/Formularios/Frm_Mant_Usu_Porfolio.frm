VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.1#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form Frm_Mant_Usu_Porfolio 
   Caption         =   "Mantención Usuario Portfolio"
   ClientHeight    =   4725
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4905
   LinkTopic       =   "Form2"
   MDIChild        =   -1  'True
   ScaleHeight     =   4725
   ScaleWidth      =   4905
   Begin VB.Frame frIds 
      Height          =   1020
      Left            =   45
      TabIndex        =   4
      Top             =   525
      Width           =   4830
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
         Left            =   1125
         Style           =   2  'Dropdown List
         TabIndex        =   1
         Top             =   345
         Width           =   2370
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
         Height          =   300
         Left            =   255
         TabIndex        =   5
         Top             =   405
         Width           =   735
      End
   End
   Begin VB.Frame frGrilla 
      Caption         =   "Mantención Usuario Portfolio"
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
      Height          =   3150
      Left            =   30
      TabIndex        =   0
      Top             =   1545
      Width           =   4830
      Begin MSFlexGridLib.MSFlexGrid Grd_Datos 
         Height          =   2835
         Left            =   135
         TabIndex        =   2
         Top             =   210
         Width           =   4575
         _ExtentX        =   8070
         _ExtentY        =   5001
         _Version        =   393216
         Cols            =   3
         FixedCols       =   0
         BackColorFixed  =   -2147483644
         ForeColorFixed  =   -2147483641
         BackColorSel    =   -2147483646
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
            Picture         =   "Frm_Mant_Usu_Porfolio.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Frm_Mant_Usu_Porfolio.frx":0452
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Frm_Mant_Usu_Porfolio.frx":08A4
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Frm_Mant_Usu_Porfolio.frx":0BBE
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Tbl_Opciones 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   3
      Top             =   0
      Width           =   4905
      _ExtentX        =   8652
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
End
Attribute VB_Name = "Frm_Mant_Usu_Porfolio"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim Datos()
Dim nContador1    As Integer

Private Const nColDesPorfolio = 0
Private Const nColUtiliza = 1
Private Const nColDefault = 2
Private Const nColCodPorfolio = 3

Private Const BtnGrabar = 1
Private Const BtnEliminar = 2
Private Const BtnLimpiar = 3
Private Const BtnSalir = 4

'CONSTANTE DE RETORNO DE SP_BACMNTCR_BUSCAPRODUCTO
Const nPro_Codigo = 1
Const nPro_Descripcion = 2

Private Sub cmbUsuario_Click()
    

        
    Grd_Datos.Rows = 1
    
    If Not Bac_Sql_Execute("SP_CARGAMESAS ") Then
        Screen.MousePointer = vbDefault
        MsgBox "Problemas al leer carteras por producto", vbCritical, TITSISTEMA
        Exit Sub
    End If
    
    Do While Bac_SQL_Fetch(Datos())
        With Grd_Datos
            .Rows = .Rows + 1
            .TextMatrix(.Rows - 1, nColCodPorfolio) = Trim(Datos(1))
            .TextMatrix(.Rows - 1, nColDesPorfolio) = Trim(Datos(2))
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
    'AddParam Envia, Trim(Right(cmbSistema.Text, 10))
    'AddParam Envia, Trim(Right(cmbProducto.Text, 10))
    
    If Not Bac_Sql_Execute("SP_CON_REL_USU_PORFOLIO", Envia) Then
        Screen.MousePointer = vbDefault
        MsgBox "Ha ocurrido un error al intentar leer la parametrizacion del usuario", vbCritical + vbOKOnly, TITSISTEMA
        Exit Sub
    End If
    
    Do While Bac_SQL_Fetch(Datos())
        With Grd_Datos
            For nContador1 = 1 To Grd_Datos.Rows - 1
                If Trim(Datos(2)) = .TextMatrix(nContador1, nColCodPorfolio) Then
                    .Col = nColUtiliza
                    .Row = nContador1
                    .TextMatrix(.Row, .Col) = "SI"
                    .CellBackColor = vbGreen
                    
                    If Trim(Datos(3)) = "S" Then
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

Private Sub Form_Load()
    Me.Icon = BACSwapParametros.Icon
    Me.Top = 0: Me.Left = 0
    Me.Width = 9570: Me.Height = 8685
    
        
        
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
            cmbUsuario.AddItem UCase(Datos(1))
        Loop
    End If
      
    Call Proc_Limpiar
    
End Sub

Private Sub Form_Resize()
    On Error Resume Next
    '-> Agregado con Fecha 05-05-2017
    
    frIds.Width = Me.Width - 250
    cmbUsuario.Width = frIds.Width - 1250
    
    frGrilla.Left = frIds.Left
    frGrilla.Width = frIds.Width
    Grd_Datos.Width = frGrilla.Width - 250
    
    frGrilla.Height = (Me.Height - (frIds.Top + frIds.Height + Me.Tbl_Opciones.Height))
    Grd_Datos.Height = (frGrilla.Height - 350)
    
    Grd_Datos.ColWidth(nColDesPorfolio) = (Grd_Datos.Width - (Grd_Datos.ColWidth(nColUtiliza) + Grd_Datos.ColWidth(nColDefault))) - 350
    
    '-> Agregado con Fecha 05-05-2017
    On Error GoTo 0
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


Private Sub Proc_Limpiar()

   Screen.MousePointer = vbDefault
   
   cmbUsuario.Enabled = True
       
    With Grd_Datos
        .Cols = 4
        .ColWidth(nColDesPorfolio) = 2900
        .ColWidth(nColUtiliza) = 750
        .ColWidth(nColDefault) = 830
        .ColWidth(nColCodPorfolio) = 0
        
        .TextMatrix(0, nColDesPorfolio) = "PORTFOLIO"
        .TextMatrix(0, nColUtiliza) = "OPERA"
        .TextMatrix(0, nColDefault) = "DEFAULT"
        .TextMatrix(0, nColCodPorfolio) = "CODIGO PORTFOLIO"
        
        .RowHeight(0) = 400
        .ColAlignment(nColUtiliza) = flexAlignCenterCenter
        .ColAlignment(nColDefault) = flexAlignCenterCenter
        
        '-> Agregado con Fecha 05-05-2017
        .AllowUserResizing = flexResizeBoth
        .BackColorFixed = &H80000004
        .ForeColorFixed = &H80000007
        .BackColor = &H80000005
        .ForeColor = &H80000008
        .Font.Name = "Arial"
        .Font.Size = 9
       '.FocusRect = flexFocusNone
        
        '-> Agregado con Fecha 05-05-2017
    End With
    
    cmbUsuario.ListIndex = -1
    cmbUsuario.Font.Name = "Arial"
    cmbUsuario.Font.Size = 10
    
    
    
    Tbl_Opciones.Buttons(BtnGrabar).Enabled = False
    Tbl_Opciones.Buttons(BtnEliminar).Enabled = False
    
    Grd_Datos.Rows = 1
    
    
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

Private Sub Proc_Grabar()
    Dim bUtiliza    As Boolean
    Dim bDefaul     As Boolean
    Dim bRespuesta  As Boolean

    With Grd_Datos
    
    
        If .Rows = 1 Then
            MsgBox "No se ha asignado ninguna Cartera para grabar", vbExclamation
            Tbl_Opciones.Buttons(BtnGrabar).Enabled = False
            Tbl_Opciones.Buttons(BtnEliminar).Enabled = False
            Exit Sub
        End If
        
        If .Rows = 2 And Trim(.TextMatrix(1, nColCodPorfolio)) = "" Then
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
        AddParam Envia, Trim(Right(cmbUsuario.Text, 15))
'        AddParam Envia, Trim(Right(cmbSistema.Text, 10))
'        AddParam Envia, Trim(Right(cmbProducto.Text, 10))
                
        If Not Bac_Sql_Execute("SP_DEL_REL_USU_PORFOLIO", Envia) Then
            bRespuesta = Bac_Sql_Execute("ROLLBACK TRAN")
            Screen.MousePointer = vbDefault
            MsgBox "Ha ocurrido un error al intentar grabar la informacion", vbCritical
            Exit Sub
        End If
    
        For nContador1 = 1 To .Rows - 1
            If .TextMatrix(nContador1, nColUtiliza) = "SI" Then
                Envia = Array()
                AddParam Envia, cmbUsuario.Text
                'AddParam Envia, Trim(Right(cmdUsuario.Text, 10))
                'AddParam Envia, Trim(Right(cmbProducto.Text, 10))
                AddParam Envia, .TextMatrix(nContador1, nColCodPorfolio)
                AddParam Envia, IIf(.TextMatrix(nContador1, nColDefault) = "SI", "S", "N")
                                                                      
                If Not Bac_Sql_Execute("SP_ACT_REL_USU_PORFOLIO", Envia) Then
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

Private Sub Proc_Eliminar()
  
    With Grd_Datos
            
        If Trim(.TextMatrix(.Row, nColCodPorfolio)) = "" Then
            Screen.MousePointer = vbDefault
            MsgBox "No ha seleccionado ningun usuario para eliminar", vbExclamation
            Exit Sub
        End If
        
        
        If MsgBox("Esta seguro de eliminar Usuario por Folio", vbQuestion + vbYesNo, TITSISTEMA) = vbNo Then
            Exit Sub
        End If

        
        Screen.MousePointer = vbHourglass
    
    For nContador1 = 1 To .Rows - 1
        
        Envia = Array()
        AddParam Envia, Trim(Right(cmbUsuario.Text, 10))
        'AddParam Envia, Trim(Right(cmbSistema.Text, 10))
        'AddParam Envia, Trim(Right(cmbProducto.Text, 10))
        'AddParam Envia, Trim(.TextMatrix(.Row, nColCodCart))
        
        If Not Bac_Sql_Execute("SP_DEL_REL_USU_PORFOLIO", Envia) Then
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
