VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Begin VB.Form Frm_Mant_Apo_Opciones 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantención Apoderados Opciones"
   ClientHeight    =   5280
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   11280
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5280
   ScaleWidth      =   11280
   Begin VB.Frame frGrilla 
      Caption         =   "Mantención Apoderados Opciones"
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
      Height          =   4605
      Left            =   135
      TabIndex        =   0
      Top             =   540
      Width           =   11085
      Begin VB.ComboBox cmbApod2 
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
         Left            =   5880
         Style           =   2  'Dropdown List
         TabIndex        =   5
         Top             =   3390
         Width           =   2535
      End
      Begin VB.ComboBox cmbEstructura 
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
         Left            =   240
         Style           =   2  'Dropdown List
         TabIndex        =   4
         Top             =   3390
         Width           =   2610
      End
      Begin VB.ComboBox cmbApod1 
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
         Left            =   3000
         Style           =   2  'Dropdown List
         TabIndex        =   3
         Top             =   3390
         Width           =   2760
      End
      Begin MSFlexGridLib.MSFlexGrid Grd_Datos 
         Height          =   4095
         Left            =   120
         TabIndex        =   1
         Top             =   360
         Width           =   10845
         _ExtentX        =   19129
         _ExtentY        =   7223
         _Version        =   393216
         Cols            =   6
         FixedCols       =   0
         RowHeightMin    =   315
         GridLinesFixed  =   0
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Index           =   0
      Left            =   5760
      Top             =   120
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
            Picture         =   "Frm_Mant_Apod_Opciones.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Frm_Mant_Apod_Opciones.frx":0452
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Frm_Mant_Apod_Opciones.frx":08A4
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Frm_Mant_Apod_Opciones.frx":177E
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Frm_Mant_Apod_Opciones.frx":1A98
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Tlb_Herramientas 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   2
      Top             =   0
      Width           =   11280
      _ExtentX        =   19897
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
      Left            =   6840
      Top             =   120
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
            Picture         =   "Frm_Mant_Apod_Opciones.frx":1DB2
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Frm_Mant_Apod_Opciones.frx":2204
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Frm_Mant_Apod_Opciones.frx":2656
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Frm_Mant_Apod_Opciones.frx":3530
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Frm_Mant_Apod_Opciones.frx":384A
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "Frm_Mant_Apo_Opciones"
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

Private Const nColCodEstructura = 0
Private Const nColDesEstructura = 1
Private Const nColRutApod1 = 2
Private Const nColDesApod1 = 3
Private Const nColRutApod2 = 4
Private Const nColDesApod2 = 5

Private ClieRut As Long
Private ClieCod As Long


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
   cmbIgualA.ListIndex = -1

    If nTipo = 1 Then ' Usuario
        cmbSistema.ListIndex = -1
        CmbProducto.ListIndex = -1
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
    
    
    Grd_Datos.TextMatrix(nFila_Cabecera, nColCodEstructura) = "Cod Estruc."
    Grd_Datos.TextMatrix(nFila_Cabecera, nColDesEstructura) = "Estructura"
    Grd_Datos.TextMatrix(nFila_Cabecera, nColRutApod1) = "Rut Apod1"
    Grd_Datos.TextMatrix(nFila_Cabecera, nColDesApod1) = "Descripción Apoderado1"
    Grd_Datos.TextMatrix(nFila_Cabecera, nColRutApod2) = "Rut Apod2"
    Grd_Datos.TextMatrix(nFila_Cabecera, nColDesApod2) = "Descripción Apoderado2"
    
    
    Grd_Datos.ColWidth(nColCodEstructura) = 400
    Grd_Datos.ColWidth(nColDesEstructura) = 2200
    Grd_Datos.ColWidth(nColCodApod1) = 800
    Grd_Datos.ColWidth(nColDesApod1) = 2500
    Grd_Datos.ColWidth(nColCodApod2) = 800
    Grd_Datos.ColWidth(nColDesApod2) = 2500
    Grd_Datos.Rows = 2
    Grd_Datos.Gridlines = flexGridRaised
    
    
End Function
Private Sub Proc_ClienteApoderado(ClieRut As Long, ClieCod As Long)
    
    If cmbApod1.ListCount > 0 Then
       cmbApod1.Clear
    End If
     If cmbApod2.ListCount > 0 Then
      cmbApod2.Clear
    End If
        
    Envia = Array()
    AddParam Envia, ClieRut
    AddParam Envia, ClieCod
    
    If Not Bac_Sql_Execute("SP_CLIENTE_APODERADO", Envia) Then
        Screen.MousePointer = vbDefault
        MsgBox "Ha ocurrido un error al intentar obtener los datos Apoderados", vbOKOnly + vbCritical
        Exit Sub
    Else
       
        Do While Bac_SQL_Fetch(Datos)
                cmbApod1.AddItem Datos(2) & Space(80) & Datos(1)
                cmbApod2.AddItem Datos(2) & Space(80) & Datos(1)
           Loop
    End If
    
     If cmbApod1.ListCount > 0 Then
         cmbApod1.ListIndex = 0
     End If
      If cmbApod2.ListCount > 0 Then
         cmbApod2.ListIndex = 0
     End If
End Sub
Private Sub Proc_ConsultaApoderadoOpciones()
      Grd_Datos.Redraw = False
    
    
    Grd_Datos.Enabled = True
   
      
    If Not Bac_Sql_Execute("SP_CON_APODERADOS_OPCIONES") Then
        Screen.MousePointer = vbDefault
        MsgBox "Ha ocurrido un error al intentar leer la parametrizacion del usuario", vbCritical + vbOKOnly, TITSISTEMA
        Exit Sub
    End If
        
    With Grd_Datos
        .Rows = 1
        
        Do While Bac_SQL_Fetch(Datos())
            .AddItem ""
            .TextMatrix(.Rows - 1, nColCodEstructura) = Trim(Datos(1))
            .TextMatrix(.Rows - 1, nColDesEstructura) = Trim(Datos(2))
            .TextMatrix(.Rows - 1, nColRutApod1) = Trim(Datos(3))
            .TextMatrix(.Rows - 1, nColDesApod1) = Trim(Datos(4))
            .TextMatrix(.Rows - 1, nColRutApod2) = Trim(Datos(5))
            .TextMatrix(.Rows - 1, nColDesApod2) = Trim(Datos(6))
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
    
    If Grd_Datos.Rows > 1 Then
        Tlb_Herramientas.Buttons(BtnGrabar).Enabled = True
        Tlb_Herramientas.Buttons(BtnEliminar).Enabled = True
    End If
    
    
    Grd_Datos.Redraw = True
    
End Sub

Private Sub Proc_OpcionEstructura()
       
    If Not Bac_Sql_Execute("SP_OPCIONESTRUCTURA") Then
        Screen.MousePointer = vbDefault
        MsgBox "Ha ocurrido un error al intentar obtener los datos de Estructuras en Opcione", vbOKOnly + vbCritical
        Exit Sub
    Else
       
        Do While Bac_SQL_Fetch(Datos)
                cmbEstructura.AddItem Datos(2) & Space(80) & Datos(1)
           Loop
    End If
    
    
End Sub

Private Sub cmbApod1_KeyDown(KeyCode As Integer, Shift As Integer)
     Select Case KeyCode
        Case vbKeyReturn
            With Grd_Datos
    
        
                .TextMatrix(.Row, nColRutApod1) = Trim(Right(cmbApod1.Text, 10))
                .TextMatrix(.Row, nColDesApod1) = Trim(Left(cmbApod1.Text, 50))
                
                cmbApod1.Visible = False
                
                Tlb_Herramientas.Buttons(BtnGrabar).Enabled = True
                Tlb_Herramientas.Buttons(BtnEliminar).Enabled = True
            End With
            
        Case vbKeyEscape
            cmbApod1.Visible = False
            Grd_Datos.SetFocus
    End Select
       
     If cmbEstructura.ListCount > 0 Then
         cmbEstructura.ListIndex = 0
     End If
    
   
    
End Sub
Private Sub cmbApod1_LostFocus()
    cmbApod1.Visible = False
End Sub

Private Sub cmbApod2_KeyDown(KeyCode As Integer, Shift As Integer)
     Select Case KeyCode
        Case vbKeyReturn
            With Grd_Datos
    
        
                .TextMatrix(.Row, nColRutApod2) = Trim(Right(cmbApod2.Text, 10))
                .TextMatrix(.Row, nColDesApod2) = Trim(Left(cmbApod2.Text, 50))
                
                cmbApod2.Visible = False
                
                Tlb_Herramientas.Buttons(BtnGrabar).Enabled = True
                Tlb_Herramientas.Buttons(BtnEliminar).Enabled = True
            End With
            
        Case vbKeyEscape
            cmbApod2.Visible = False
            Grd_Datos.SetFocus
    End Select
            
End Sub
Private Sub cmbApod2_LostFocus()
      cmbApod2.Visible = False
End Sub
Private Sub cmbEstructura_KeyDown(KeyCode As Integer, Shift As Integer)


    Select Case KeyCode
        Case vbKeyReturn
            With Grd_Datos
    
        
                .TextMatrix(.Row, nColCodEstructura) = Trim(Right(cmbEstructura.Text, 10))
                .TextMatrix(.Row, nColDesEstructura) = Trim(Left(cmbEstructura.Text, 50))
                
                cmbEstructura.Visible = False
                
                Tlb_Herramientas.Buttons(BtnGrabar).Enabled = True
                Tlb_Herramientas.Buttons(BtnEliminar).Enabled = True
            End With
            
        Case vbKeyEscape
            cmbEstructura.Visible = False
            Grd_Datos.SetFocus
    End Select
    
End Sub

Private Sub cmbEstructura_LostFocus()
    cmbEstructura.Visible = False
End Sub

Private Sub Form_Load()

    Me.Icon = BACSwapParametros.Icon
    Me.Top = 0: Me.Left = 0
    
    
    cmbEstructura.Visible = False
    cmbApod1.Visible = False
    cmbApod2.Visible = False
    

    Call Proc_Limpiar

    If cmbEstructura.ListCount > 0 Then
        Combo.ListIndex = 0
    End If
      
    Call LlenaGrilla
    
    ClieRut = Val(gsCodigo$)
    ClieCod = Val(gsCodCli)

    Proc_OpcionEstructura
    Call Proc_ClienteApoderado(ClieRut, ClieCod)
    Call Proc_ConsultaApoderadoOpciones
    
End Sub




Private Sub Proc_Eliminar()
    
  
With Grd_Datos

    For nContador2 = 1 To .Rows - 1
        
        If .Rows = .Rows And Trim(.TextMatrix(nContador2, nColCodEstructura)) = "" Or .Rows = .Rows And Trim(.TextMatrix(nContador2, nColDesEstructura)) = "" _
                     Or .Rows = .Rows And Trim(.TextMatrix(nContador2, nColRutApod1)) = "" Or .Rows = .Rows And Trim(.TextMatrix(nContador2, nColDesApod1)) = "" _
                     Or .Rows = .Rows And Trim(.TextMatrix(nContador2, nColRutApod2)) = "" Or .Rows = .Rows And Trim(.TextMatrix(nContador2, nColDesApod2)) = "" Then
             Screen.MousePointer = vbDefault
             MsgBox "No ha seleccionado ningun registro para eliminar", vbExclamation
             Exit Sub
         End If
    
    Next nContador2
    
    
    
    If MsgBox("Se eliminara registro " & .TextMatrix(.Row, nColCodEstructura) & " " & .TextMatrix(.Row, nColDesEstructura) & ", esta Seguro", vbQuestion + vbYesNo, TITSISTEMA) = vbNo Then
        Exit Sub
    End If
    
    
    If .Rows > 2 Then
    
        .RemoveItem .Row
    Else
        .TextMatrix(1, nColCodEstructura) = ""
        .TextMatrix(1, nColDesEstructura) = ""
        .TextMatrix(1, nColRutApod1) = ""
        .TextMatrix(1, nColDesApod1) = ""
        .TextMatrix(1, nColRutApod2) = ""
        .TextMatrix(1, nColDesApod2) = ""
        
        
    End If
    
   
    Call Proc_ClienteApoderado(ClieRut, ClieCod)
    Call Proc_ConsultaApoderadoOpciones
    Call Proc_Grabar
    Call LlenaGrilla
    
End With

End Sub

Private Sub Grd_Datos_DblClick()
    
    With Grd_Datos

        If .Enabled = False Then
            Exit Sub
        End If
        
'        If Trim(Right(cmbEstructura.Text, 10)) = "" Then
'            Exit Sub
'        End If
        
        If .Col = nColDesEstructura Then
            If cmbEstructura.ListCount > 0 Then
                For nContador1 = 0 To cmbEstructura.ListCount - 1
                    If Trim(Right(cmbEstructura.List(nContador1), 10)) = Trim(.TextMatrix(.Row, nColDesEstructura)) Then
                        cmbEstructura.ListIndex = nContador1
                       
                        Exit For
            End If
                    
                Next nContador1

                cmbEstructura.Visible = True
                cmbEstructura.Width = .ColWidth(.Col)
                cmbEstructura.Left = .Left + .CellLeft
                cmbEstructura.Top = .Top + .CellTop
                cmbEstructura.SetFocus
            End If
        End If
        
        If .Col = nColDesApod1 Then
            If cmbApod1.ListCount > 0 Then
                For nContador1 = 0 To cmbApod1.ListCount - 1
                    If Trim(Right(cmbApod1.List(nContador1), 10)) = Trim(.TextMatrix(.Row, nColDesApod1)) Then
                        cmbApod1.ListIndex = nContador1
                        
                        Exit For
                        
             End If
                    
                Next nContador1
            
                cmbApod1.Visible = True
                cmbApod1.Width = .ColWidth(.Col)
                cmbApod1.Left = .Left + .CellLeft
                cmbApod1.Top = .Top + .CellTop
                cmbApod1.SetFocus
            End If
        End If
        
        If .Col = nColDesApod2 Then
           If cmbApod2.ListCount > 0 Then
               For nContador1 = 0 To cmbApod2.ListCount - 1
                   If Trim(Right(cmbApod2.List(nContador1), 10)) = Trim(.TextMatrix(.Row, nColDesApod2)) Then
                       cmbApod2.ListIndex = nContador1
                       
                       Exit For
                                          
                   End If
                   
               Next nContador1
           
               cmbApod2.Visible = True
               cmbApod2.Width = .ColWidth(.Col)
               cmbApod2.Left = .Left + .CellLeft
               cmbApod2.Top = .Top + .CellTop
               cmbApod2.SetFocus
           End If
        End If
                
    End With
         
End Sub
Private Sub Proc_Limpiar()

   Grd_Datos.Rows = 1
   
    cmbEstructura.ListIndex = -1
    cmbApod1.ListIndex = -1
    cmbApod2.ListIndex = -1
    Grd_Datos.AddItem ""
  
    
    Tlb_Herramientas.Buttons(BtnGrabar).Enabled = False
    Tlb_Herramientas.Buttons(BtnEliminar).Enabled = False
    
    cmbEstructura.Visible = False
    cmbApod1.Visible = False
    cmbApod2.Visible = False
    
       
    Call LlenaGrilla
    Call Proc_ClienteApoderado(ClieRut, ClieCod)
    Call Proc_ConsultaApoderadoOpciones
     
End Sub

Private Sub Grd_Datos_KeyDown(KeyCode As Integer, Shift As Integer)
    With Grd_Datos

    Select Case KeyCode
    
        Case vbKeyInsert 'inserta
            If .TextMatrix(.Rows - 1, nColCodEstructura) <> "" And .TextMatrix(.Rows - 1, nColDesEstructura) <> "" _
               And .TextMatrix(.Rows - 1, nColRutApod1) <> "" And .TextMatrix(.Rows - 1, nColDesApod1) <> "" _
               And .TextMatrix(.Rows - 1, nColRutApod2) <> "" And .TextMatrix(.Rows - 1, nColDesApod2) <> "" Then
                                                                
                .AddItem ""
                .SetFocus
                .Col = nColCodEstructura
                .Row = .Rows - 1
            End If
    
        Case vbKeyDelete 'elimina
            If .Rows > 2 Then
                .RemoveItem .Row
            Else
                .TextMatrix(1, nColCodEstructura) = ""
                .TextMatrix(1, nColDesEstructura) = ""
                .TextMatrix(1, nColRutApod1) = ""
                .TextMatrix(1, nColDesApod1) = ""
                .TextMatrix(1, nColRutApod2) = ""
                .TextMatrix(1, nColDesApod2) = ""
                
                
            End If
    End Select

    End With

End Sub

Private Sub Grd_Datos_KeyPress(KeyAscii As Integer)
   
   If Not IsNumeric(Chr(KeyAscii)) And UCase(Chr(KeyAscii)) < "A" And UCase(Chr(KeyAscii)) > "Z" And KeyAscii <> 13 And KeyAscii <> 8 Then
      KeyAscii = 0
   End If
   
   
   If KeyAscii = 13 Then
       Call Grd_Datos_DblClick
   End If
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


Private Sub Proc_Grabar()
   
   With Grd_Datos
        For nContador2 = 1 To .Rows - 1
            If .Rows = .Rows And Trim(.TextMatrix(nContador2, nColCodEstructura)) = "" Or .Rows = .Rows And Trim(.TextMatrix(nContador2, nColDesEstructura)) = "" _
                Or .Rows = .Rows And Trim(.TextMatrix(nContador2, nColRutApod1)) = "" Or .Rows = .Rows And Trim(.TextMatrix(nContador2, nColDesApod1)) = "" _
                Or .Rows = .Rows And Trim(.TextMatrix(nContador2, nColRutApod2)) = "" Or .Rows = .Rows And Trim(.TextMatrix(nContador2, nColDesApod2)) = "" Then
                
                MsgBox "No se ha asignado Apoderado para grabar", vbExclamation
                
                Exit Sub
            End If
        Next nContador2
        
        For nContador2 = 1 To .Rows - 1
            If Trim(.TextMatrix(nContador2, nColRutApod1)) = Trim(.TextMatrix(nContador2, nColRutApod2)) Then
               
                
                MsgBox "No se puede asignar mismo apoderado para grabar", vbExclamation
                
                Exit Sub
            End If
        Next nContador2
        
      
           
        For nContador1 = 1 To .Rows - 2
            For nContador2 = nContador1 + 1 To .Rows - 1
                                
                If Trim(.TextMatrix(nContador1, nColCodEstructura)) = Trim(.TextMatrix(nContador2, nColCodEstructura)) Then
                                            
                    MsgBox "Existe un Registro duplicado", vbExclamation
                    
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
        
              
        If Not Bac_Sql_Execute("SP_DEL_APODERADOS_OPCIONES") Then
            bRespuesta = Bac_Sql_Execute("ROLLBACK TRAN")
            Screen.MousePointer = vbDefault
            MsgBox "Ha ocurrido un error al intentar grabar la informacion", vbCritical
            Exit Sub
        End If
    
        For nContador1 = 1 To .Rows - 1
                                     
                Envia = Array()
                AddParam Envia, Val(1)
                AddParam Envia, .TextMatrix(nContador1, nColCodEstructura)
                AddParam Envia, .TextMatrix(nContador1, nColRutApod1)
                          
                If Not Bac_Sql_Execute("SP_INS_APODERADOS_OPCIONES", Envia) Then
                    bRespuesta = Bac_Sql_Execute("ROLLBACK TRAN")
                    Screen.MousePointer = vbDefault
                    MsgBox "Ha ocurrido un error al intentar grabar la informacion", vbCritical
                    Exit Sub
                End If
                
                
                Envia = Array()
                AddParam Envia, Val(2)
                AddParam Envia, .TextMatrix(nContador1, nColCodEstructura)
                AddParam Envia, .TextMatrix(nContador1, nColRutApod2)
                          
                If Not Bac_Sql_Execute("SP_INS_APODERADOS_OPCIONES", Envia) Then
                    bRespuesta = Bac_Sql_Execute("ROLLBACK TRAN")
                    Screen.MousePointer = vbDefault
                    MsgBox "Ha ocurrido un error al intentar grabar la informacion", vbCritical
                    Exit Sub
                End If
                     
        Next nContador1
        
        
        bRespuesta = Bac_Sql_Execute("COMMIT TRAN")
        Screen.MousePointer = vbDefault
        MsgBox "La informacion ha sido grabada con exito", vbInformation, TITSISTEMA
        
        Call Proc_Limpiar
        
    End With


End Sub


