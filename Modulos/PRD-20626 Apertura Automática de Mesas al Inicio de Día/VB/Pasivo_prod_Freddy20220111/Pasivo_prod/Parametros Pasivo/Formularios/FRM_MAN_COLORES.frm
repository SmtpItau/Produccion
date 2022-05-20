VERSION 5.00
Object = "{1C0489F8-9EFD-423D-887A-315387F18C8F}#1.0#0"; "vsflex8l.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "Mscomctl.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "threed32.ocx"
Begin VB.Form FRM_MAN_COLORES 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Mantenedor de Colores"
   ClientHeight    =   3750
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4935
   BeginProperty Font 
      Name            =   "Arial"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   3750
   ScaleWidth      =   4935
   ShowInTaskbar   =   0   'False
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   4020
      Top             =   0
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   24
      ImageHeight     =   24
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   6
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MAN_COLORES.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MAN_COLORES.frx":0EDA
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MAN_COLORES.frx":1DB4
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MAN_COLORES.frx":2C8E
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MAN_COLORES.frx":2FA8
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MAN_COLORES.frx":3E82
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Tlb_Botones 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   4935
      _ExtentX        =   8705
      _ExtentY        =   847
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Key             =   "Limpiar"
            Description     =   "Buscar"
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Key             =   "Grabar"
            Description     =   "Grabar"
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Default"
            Object.ToolTipText     =   "Trae los colores por Defecto"
            ImageIndex      =   6
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Buscar"
            Description     =   "Limpiar"
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Description     =   "Salir"
            Object.ToolTipText     =   "Cerrar Ventana"
            ImageIndex      =   4
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin Threed.SSFrame SSFrame1 
      Height          =   615
      Left            =   60
      TabIndex        =   1
      Top             =   450
      Width           =   4890
      _Version        =   65536
      _ExtentX        =   8625
      _ExtentY        =   1085
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
      Begin VB.ComboBox box_Usuarios 
         Height          =   330
         Left            =   2055
         Style           =   2  'Dropdown List
         TabIndex        =   2
         Top             =   180
         Width           =   2565
      End
      Begin VB.Label Label1 
         Caption         =   "Nombre de Usuario"
         Height          =   255
         Left            =   150
         TabIndex        =   3
         Top             =   240
         Width           =   1830
      End
   End
   Begin VSFlex8LCtl.VSFlexGrid Grd_Colores 
      Height          =   2655
      Left            =   60
      TabIndex        =   4
      Top             =   1080
      Width           =   4875
      _cx             =   8599
      _cy             =   4683
      Appearance      =   1
      BorderStyle     =   1
      Enabled         =   0   'False
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MousePointer    =   0
      BackColor       =   -2147483644
      ForeColor       =   8388672
      BackColorFixed  =   8421376
      ForeColorFixed  =   16777215
      BackColorSel    =   -2147483635
      ForeColorSel    =   -2147483634
      BackColorBkg    =   -2147483636
      BackColorAlternate=   -2147483644
      GridColor       =   -2147483633
      GridColorFixed  =   -2147483632
      TreeColor       =   -2147483632
      FloodColor      =   192
      SheetBorder     =   -2147483642
      FocusRect       =   0
      HighLight       =   1
      AllowSelection  =   -1  'True
      AllowBigSelection=   -1  'True
      AllowUserResizing=   0
      SelectionMode   =   0
      GridLines       =   2
      GridLinesFixed  =   0
      GridLineWidth   =   1
      Rows            =   1
      Cols            =   2
      FixedRows       =   1
      FixedCols       =   1
      RowHeightMin    =   0
      RowHeightMax    =   0
      ColWidthMin     =   0
      ColWidthMax     =   0
      ExtendLastCol   =   0   'False
      FormatString    =   $"FRM_MAN_COLORES.frx":4D5C
      ScrollTrack     =   0   'False
      ScrollBars      =   3
      ScrollTips      =   0   'False
      MergeCells      =   0
      MergeCompare    =   0
      AutoResize      =   -1  'True
      AutoSizeMode    =   0
      AutoSearch      =   0
      AutoSearchDelay =   2
      MultiTotals     =   -1  'True
      SubtotalPosition=   1
      OutlineBar      =   0
      OutlineCol      =   0
      Ellipsis        =   0
      ExplorerBar     =   0
      PicturesOver    =   0   'False
      FillStyle       =   0
      RightToLeft     =   0   'False
      PictureType     =   0
      TabBehavior     =   0
      OwnerDraw       =   0
      Editable        =   2
      ShowComboButton =   1
      WordWrap        =   0   'False
      TextStyle       =   0
      TextStyleFixed  =   0
      OleDragMode     =   0
      OleDropMode     =   0
      ComboSearch     =   3
      AutoSizeMouse   =   -1  'True
      FrozenRows      =   0
      FrozenCols      =   0
      AllowUserFreezing=   0
      BackColorFrozen =   0
      ForeColorFrozen =   0
      WallPaperAlignment=   9
      AccessibleName  =   ""
      AccessibleDescription=   ""
      AccessibleValue =   ""
      AccessibleRole  =   24
   End
End
Attribute VB_Name = "FRM_MAN_COLORES"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Function FUNC_GRABAR()
Dim nContador As Long
    
If Not BAC_SQL_EXECUTE("BEGIN TRANSACTION") Then
    MsgBox "Información No fue Grabada.", vbOKOnly + vbCritical
    Exit Function
End If
    
For nContador = 1 To Grd_Colores.Rows - 1
    
    Grd_Colores.Row = nContador
    Grd_Colores.Col = 1
    Grd_Colores.RowSel = nContador
    Grd_Colores.ColSel = 1
    
    Envia = Array()
    AddParam Envia, box_Usuarios.Text
    AddParam Envia, left(Grd_Colores.TextMatrix(nContador, 0), 1)
    AddParam Envia, Grd_Colores.CellBackColor
    AddParam Envia, Grd_Colores.CellForeColor
    
    If Not BAC_SQL_EXECUTE("SP_ACT_GRABA_COLOR", Envia) Then
        GoTo Errores
    End If
    
Next

If Not BAC_SQL_EXECUTE("COMMIT TRANSACTION") Then GoTo Errores

MsgBox "Datos grabados en forma correcta", vbInformation

Exit Function

Errores:

If Not BAC_SQL_EXECUTE("ROLLBACK TRANSACTION") Then
   MsgBox "Error al Reversar la Acción", vbOKOnly + vbCritical
   Exit Function
End If

MsgBox "Información No fue Grabada.", vbOKOnly + vbCritical

End Function
Function FUNC_TRAER_COLOR_POR_USUARIO(Optional nUser As Long)
Dim lSw As Boolean

With Grd_Colores

    'TRAER COLORES
    Envia = Array()
    If nUser = 0 Then
        AddParam Envia, box_Usuarios.Text
    Else
        AddParam Envia, box_Usuarios.Text
        AddParam Envia, 1
    End If
    lSw = True
    
    If Not BAC_SQL_EXECUTE("SP_CON_TRAER_COLOR", Envia) Then
        
        lSw = False
        Envia = Array()
        AddParam Envia, box_Usuarios.Text
        AddParam Envia, 1
        
        If Not BAC_SQL_EXECUTE("SP_CON_TRAER_COLOR", Envia) Then
            MsgBox "No fue posible leer información", vbOKOnly + vbCritical
            Exit Function
        End If
        
    End If
    
    nContador = 1
    Do While BAC_SQL_FETCH(Datos())

        .Row = nContador
        .Col = 1
        .RowSel = nContador
        .ColSel = 1
        .TextMatrix(.Row, 1) = "COLOR"
        .CellBackColor = Datos(3)
        .CellForeColor = Datos(4)
        nContador = nContador + 1
        
    Loop

End With

End Function


Private Function FUNC_TRAER_USUARIOS()
Dim nContador As Long

With Grd_Colores

    If Not BAC_SQL_EXECUTE("SP_CON_Usuarios") Then
    
        MsgBox "No fue posible leer información", vbOKOnly + vbCritical
        Exit Function
    
    Else
    
        Do While BAC_SQL_FETCH(Datos())
    
            box_Usuarios.AddItem Datos(1)
    
        Loop
    
    End If
    
    'TRAER ESTADOS
    If Not BAC_SQL_EXECUTE("SP_CON_TIPO_ESTADO") Then
    
        MsgBox "No fue posible leer información", vbOKOnly + vbCritical
        Exit Function
    
    Else
    
        .FixedCols = 1
        Do While BAC_SQL_FETCH(Datos())
    
            .Rows = .Rows + 1
            .Row = .Rows - 1
            .RowSel = .Row
            .Col = 0
            .ColSel = 0
            .ColComboList(1) = "F;Color de Fondo|T;Color de Texto"
            .TextMatrix(.Rows - 1, 0) = left(Datos(1), 1) & "-" & Mid(Datos(1), 3)
    
        Loop
    
    End If

    For nContador = 1 To Grd_Colores.Rows - 1
        .Row = nContador
        .Col = 1
        .CellBackColor = Label1.BackColor
        .CellForeColor = Label1.ForeColor
    Next
    
End With

End Function


Private Sub box_Usuarios_Change()
    Call FUNC_TRAER_COLOR_POR_USUARIO
End Sub

Private Sub Form_Activate()
    PROC_CARGA_AYUDA Me, " "
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)

   nOpcion = 0
   If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) Then
     
        Select Case KeyCode
            Case vbKeyLimpiar:
                            nOpcion = 1
   
            Case vbKeyGrabar:
                            nOpcion = 2
                           
            Case vbKeyBuscar:
                            nOpcion = 4

            Case vbKeySalir:
                            nOpcion = 5
                      
      End Select

      If nOpcion <> 0 Then
            If Tlb_Botones.Buttons(nOpcion).Enabled Then
               Call Tlb_Botones_ButtonClick(Tlb_Botones.Buttons(nOpcion))
            End If
            KeyCode = 0
      End If
      
   End If

End Sub

Private Sub Form_Load()
    Me.Icon = BAC_Parametros.Icon
    Me.top = 0
    Me.left = 0
    Call FUNC_TRAER_USUARIOS
End Sub

Private Sub Grd_Colores_ComboCloseUp(ByVal Row As Long, ByVal Col As Long, FinishEdit As Boolean)

    BAC_Parametros.dlg_Principal.ShowColor
    If BAC_Parametros.dlg_Principal.Color <> 0 Then
        With Grd_Colores
            If Grd_Colores.TextMatrix(Row, Col) = "Color de Fondo" Then
                Grd_Colores.CellBackColor = BAC_Parametros.dlg_Principal.Color
            Else
                Grd_Colores.CellForeColor = BAC_Parametros.dlg_Principal.Color
            End If
        End With
    End If


End Sub


Private Sub Tlb_Botones_ButtonClick(ByVal Button As MSComctlLib.Button)
Dim nContador As Long

Select Case UCase(Button.Key)
    Case "LIMPIAR"
        Tlb_Botones.Buttons(1).Enabled = False
        Tlb_Botones.Buttons(2).Enabled = False
        Tlb_Botones.Buttons(3).Enabled = False
        Tlb_Botones.Buttons(4).Enabled = True
        Grd_Colores.Enabled = False
        box_Usuarios.Enabled = True
        With Grd_Colores
            For nContador = 1 To Grd_Colores.Rows - 1
                .Row = nContador
                .Col = 1
                .CellBackColor = Label1.BackColor
                .CellForeColor = Label1.ForeColor
            Next
        End With
        box_Usuarios.SetFocus
        
    Case "GRABAR"
        Call FUNC_GRABAR
    Case "DEFAULT"
        Call FUNC_TRAER_COLOR_POR_USUARIO(1)
    Case "BUSCAR"
        Call FUNC_TRAER_COLOR_POR_USUARIO
        box_Usuarios.Enabled = False
        Grd_Colores.Enabled = True
        Tlb_Botones.Buttons(4).Enabled = False
        Tlb_Botones.Buttons(3).Enabled = True
        Tlb_Botones.Buttons(1).Enabled = True
        Tlb_Botones.Buttons(2).Enabled = True
        Grd_Colores.SetFocus
    Case "SALIR"
        Unload Me
End Select


End Sub


