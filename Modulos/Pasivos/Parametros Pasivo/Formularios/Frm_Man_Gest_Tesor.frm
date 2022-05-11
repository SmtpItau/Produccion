VERSION 5.00
Object = "{1C0489F8-9EFD-423D-887A-315387F18C8F}#1.0#0"; "vsflex8l.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "Mscomctl.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "threed32.ocx"
Begin VB.Form Frm_Man_Gest_Tesor 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantenedor de Codigos para Interfazces de Gestion de Tesoreria"
   ClientHeight    =   3750
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   10035
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   3750
   ScaleWidth      =   10035
   Begin Threed.SSFrame SSFrame1 
      Height          =   615
      Left            =   15
      TabIndex        =   2
      Top             =   480
      Width           =   9960
      _Version        =   65536
      _ExtentX        =   17568
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
      Begin VB.ComboBox box_Sistemas 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   2055
         Style           =   2  'Dropdown List
         TabIndex        =   3
         Top             =   180
         Width           =   3630
      End
      Begin VB.Label Label1 
         Caption         =   "Nombre de Modulo"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   150
         TabIndex        =   4
         Top             =   240
         Width           =   1830
      End
   End
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
         NumListImages   =   4
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Frm_Man_Gest_Tesor.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Frm_Man_Gest_Tesor.frx":0EDA
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Frm_Man_Gest_Tesor.frx":1DB4
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Frm_Man_Gest_Tesor.frx":2C8E
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
      Width           =   10035
      _ExtentX        =   17701
      _ExtentY        =   847
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
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
            Key             =   "Buscar"
            Description     =   "Limpiar"
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Description     =   "Salir"
            Object.ToolTipText     =   "Cerrar Ventana"
            ImageIndex      =   4
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin VSFlex8LCtl.VSFlexGrid Grd_Gestion 
      Height          =   2610
      Left            =   15
      TabIndex        =   1
      Top             =   1110
      Width           =   10005
      _cx             =   17648
      _cy             =   4604
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
      Rows            =   2
      Cols            =   11
      FixedRows       =   1
      FixedCols       =   0
      RowHeightMin    =   0
      RowHeightMax    =   0
      ColWidthMin     =   0
      ColWidthMax     =   0
      ExtendLastCol   =   0   'False
      FormatString    =   $"Frm_Man_Gest_Tesor.frx":2FA8
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
Attribute VB_Name = "Frm_Man_Gest_Tesor"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Function FUNC_GRABAR_CODIGOS_GESTION() As Boolean

FUNC_GRABAR_CODIGOS_GESTION = False

With Grd_Gestion

    Redraw = flexRDNone
    
    If Not BAC_SQL_EXECUTE("BEGIN TRANSACTION") Then GoTo Errores
    
    Envia = Array()
    AddParam Envia, Trim(right(box_Sistemas.Text, 10)) 'Sistema
    If Not BAC_SQL_EXECUTE("SP_ELI_CODIGOS_GESTION", Envia) Then GoTo Errores
   
    For nIndice = 1 To .Rows - 1
          
        Envia = Array()
        AddParam Envia, Trim(right(box_Sistemas.Text, 10)) 'Sistema
        AddParam Envia, Val(.TextMatrix(nIndice, 0)) 'Familia
        AddParam Envia, Val(.TextMatrix(nIndice, 1)) 'Codigo Gestion
        AddParam Envia, .TextMatrix(nIndice, 2) 'Activo/Pasivo
        AddParam Envia, .TextMatrix(nIndice, 3) 'Tipo Cartera
        AddParam Envia, .TextMatrix(nIndice, 4) 'Sub Producto
        AddParam Envia, Val(.TextMatrix(nIndice, 5)) 'Forma pago Ini
        AddParam Envia, Val(.TextMatrix(nIndice, 6)) 'Forma Pago Fin
        AddParam Envia, Val(.TextMatrix(nIndice, 7))  'Moneda
        AddParam Envia, Val(.TextMatrix(nIndice, 8)) 'Emisor
        AddParam Envia, Val(.TextMatrix(nIndice, 9)) 'Tipo Tasa
        AddParam Envia, .TextMatrix(nIndice, 10) 'Tipo Operacion
        
        If Not BAC_SQL_EXECUTE("SP_ACT_CODIGOS_GESTION", Envia) Then GoTo Errores
        
    Next nIndice
    
    If Not BAC_SQL_EXECUTE("COMMIT TRANSACTION") Then GoTo Errores
    
    MsgBox "Información Grabada Correctamente.", vbOKOnly + vbInformation
    
    .Redraw = flexRDDirect
    
    FUNC_GRABAR_CODIGOS_GESTION = True
   
End With

Exit Function

Errores:

If Not BAC_SQL_EXECUTE("ROLLBACK TRANSACTION") Then
   MsgBox "Error al Reversar la Acción", vbOKOnly + vbCritical
   Exit Function
End If

MsgBox "Información No fue Grabada.", vbOKOnly + vbCritical

End Function
Function FUNC_PAD(sDireccion As String, sString As Variant, sPad As String, nLargo As Long) As String

FUNC_PAD = sString

If Len(sString) >= nLargo Then
    If sDireccion = "R" Then
        FUNC_PAD = left(sString, nLargo)
    Else
        FUNC_PAD = right(sString, nLargo)
    End If
Else
    If sDireccion = "R" Then
        FUNC_PAD = sString & String(nLargo - Len(sString), sPad)
    Else
        FUNC_PAD = String(nLargo - Len(sString), sPad) & sString
    End If
End If

End Function


Function FUNC_TRAER_DATOS(nTipo_Consulta As Long) As Boolean
Dim nContador   As Long
Dim nContador1  As Long
Dim sCadena     As String
Dim nFila       As Long
Dim bDatos      As Boolean
Dim vAuxiliar1   As Variant
Dim vAuxiliar2   As Variant

FUNC_TRAER_DATOS = False
bDatos = False
ReDim vAuxiliar1(1)
ReDim vAuxiliar2(1)

With Grd_Gestion
        
    Select Case nTipo_Consulta
        Case 1 'Traer Sistemas
            Envia = Array()
            AddParam Envia, ""
            AddParam Envia, 8
            
            If Not BAC_SQL_EXECUTE("SP_CON_TRAER_CODIGOS_GESTION", Envia) Then
                MsgBox "No fue posible leer información", vbOKOnly + vbCritical
                Exit Function
            Else
                Do While BAC_SQL_FETCH(Datos())
                    box_Sistemas.AddItem Datos(2) & Space(100) & Trim(Datos(1))
                Loop
            End If
            
        Case 2 'Llenar Combos de Grilla
        
            For nContador1 = 0 To Grd_Gestion.Cols - 1
                Grd_Gestion.ColComboList(nContador1) = ""
            Next
            
            For nContador = 1 To 7
                Envia = Array()
                AddParam Envia, UCase(Trim(right(box_Sistemas, 10)))
                AddParam Envia, nContador
                If Not BAC_SQL_EXECUTE("SP_CON_TRAER_CODIGOS_GESTION", Envia) Then
                    MsgBox "No fue posible leer información", vbOKOnly + vbCritical
                    Exit Function
                Else
                    
                    Do While BAC_SQL_FETCH(Datos())
                        bDatos = True
                        Select Case nContador
                            Case 1 'Familia
                                nFila = 0
                                Grd_Gestion.ColComboList(nFila) = Grd_Gestion.ColComboList(nFila) & "#" & Datos(1) & ";" & Datos(2) & "|"
                            Case 2 'Tipo Cartera
                                nFila = 3
                                Grd_Gestion.ColComboList(nFila) = Grd_Gestion.ColComboList(nFila) & "#" & FUNC_PAD("R", Datos(2), " ", 5) & FUNC_PAD("R", Datos(3), " ", 15) & FUNC_PAD("R", Datos(4), " ", 5) & ";" & Datos(2) & "--" & FUNC_PAD("R", Datos(3), " ", 6) & "--" & Datos(5) & "|"
                                vAuxiliar1(UBound(vAuxiliar1) - 1) = FUNC_PAD("R", Datos(2), " ", 5) & FUNC_PAD("R", Datos(3), " ", 15) & FUNC_PAD("R", Datos(4), " ", 5)
                                vAuxiliar2(UBound(vAuxiliar2) - 1) = Datos(2) & "--" & Datos(5)
                                ReDim Preserve vAuxiliar1(UBound(vAuxiliar1) + 1)
                                ReDim Preserve vAuxiliar2(UBound(vAuxiliar2) + 1)
                            Case 3 'Forma de Pago
                                nFila = 5
                                Grd_Gestion.ColComboList(nFila) = Grd_Gestion.ColComboList(nFila) & "#" & Datos(1) & ";" & Datos(2) & "|"
                            Case 4 'Moneda
                                nFila = 7
                                Grd_Gestion.ColComboList(nFila) = Grd_Gestion.ColComboList(nFila) & "#" & Datos(1) & ";" & Datos(2) & "|"
                            Case 5 'Emisor
                                nFila = 8
                                Grd_Gestion.ColComboList(nFila) = Grd_Gestion.ColComboList(nFila) & "#" & Datos(2) & ";" & Datos(4) & "|"
                            Case 6 'Tipo Variabilidad
                                nFila = 9
                                Grd_Gestion.ColComboList(nFila) = Grd_Gestion.ColComboList(nFila) & "#" & Datos(1) & ";" & Datos(2) & "|"
                            Case 7 'Tipo operacion
                                nFila = 10
                                Grd_Gestion.ColComboList(nFila) = Grd_Gestion.ColComboList(nFila) & "#" & Datos(2) & ";" & Datos(3) & "|"
                        End Select
                    Loop
                    If bDatos Then
                        Grd_Gestion.ColComboList(nFila) = left(Grd_Gestion.ColComboList(nFila), Len(Grd_Gestion.ColComboList(nFila)) - 1)
                        If nFila = 5 Then
                            Grd_Gestion.ColComboList(6) = Grd_Gestion.ColComboList(5)
                        End If
                        Grd_Gestion.ColComboList(2) = "ACTIVO;ACTIVO|PASIVO;PASIVO"
                    End If
                End If
            Next nContador
            
            If bDatos Then
                Envia = Array()
                AddParam Envia, UCase(Trim(right(box_Sistemas, 10)))
                AddParam Envia, 9 'Codigo de Gestion
                If BAC_SQL_EXECUTE("SP_CON_TRAER_CODIGOS_GESTION", Envia) Then
                    Do While BAC_SQL_FETCH(Datos())
                        .TextMatrix(.Rows - 1, 0) = Datos(2)
                        .TextMatrix(.Rows - 1, 1) = Datos(3)
                        .TextMatrix(.Rows - 1, 2) = Datos(4)
                        
                        For nContador = 0 To UBound(vAuxiliar1) - 1
                            If Datos(5) = Trim(vAuxiliar1(nContador)) Then
                                .TextMatrix(.Rows - 1, 3) = vAuxiliar2(nContador)
                                .Cell(flexcpText, .Rows - 1, 3) = vAuxiliar1(nContador)
                                Exit For
                            End If
                        Next nContador
                        
                        .TextMatrix(.Rows - 1, 4) = Datos(6)
                        .TextMatrix(.Rows - 1, 5) = Datos(7)
                        .TextMatrix(.Rows - 1, 6) = Datos(8)
                        .TextMatrix(.Rows - 1, 7) = Datos(9)
                        .TextMatrix(.Rows - 1, 8) = Datos(10)
                        .TextMatrix(.Rows - 1, 9) = Datos(11)
                        .TextMatrix(.Rows - 1, 10) = Datos(12)
                        .Rows = .Rows + 1
                    Loop
                    .Rows = .Rows - 1
                    FUNC_TRAER_DATOS = True
                End If
            End If
            
    End Select

End With

End Function

Private Function FUNC_VALIDA_BLANCOS() As Boolean

With Grd_Gestion
   
      For nIndice = 1 To .Rows - 1
      
         If Trim(.TextMatrix(nIndice, 0)) = "" Or Trim(.TextMatrix(nIndice, 1)) = "" Or _
            Trim(.TextMatrix(nIndice, 2)) = "" Or Trim(.TextMatrix(nIndice, 4)) = "" Then
         
            FUNC_VALIDA_BLANCOS = False
            Exit Function
            
         End If
         
      Next nIndice
      
      FUNC_VALIDA_BLANCOS = True
      
End With

End Function

Private Function FUNC_VALIDA_REPETIDOS(nRow As Long) As Boolean
Dim vMatriz()
Dim nIndice1    As Long

ReDim vMatriz(Grd_Gestion.Cols)

With Grd_Gestion
    
    FUNC_VALIDA_REPETIDOS = False
    
    If .Rows = 2 Then
        FUNC_VALIDA_REPETIDOS = True
        Exit Function
    End If
    
    For nIndice = 0 To .Cols - 1
        vMatriz(nIndice) = .TextMatrix(nRow, nIndice)
    Next nIndice
        
    For nIndice = 1 To .Rows - 1
        
        If nIndice <> nRow Then
        
            FUNC_VALIDA_REPETIDOS = False
            
            For nIndice1 = 0 To .Cols - 1
                If nIndice1 <> 4 Then
                    If Trim(vMatriz(nIndice1)) <> Trim(.TextMatrix(nIndice, nIndice1)) Then
                        FUNC_VALIDA_REPETIDOS = True
                    End If
                End If
            Next nIndice1
            
            If Not FUNC_VALIDA_REPETIDOS Then
                Exit Function
            End If
            
        End If
        
    Next nIndice
      
End With

End Function

Private Sub Form_Activate()
   PROC_CARGA_AYUDA Me, " "
    Grd_Gestion.Col = 0
    Grd_Gestion.Row = 0
    box_Sistemas.ListIndex = 0
    If box_Sistemas.Enabled Then
        box_Sistemas.SetFocus
        Me.top = 0
        Me.left = 0
    End If

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
                            nOpcion = 3

            Case vbKeySalir:
                            nOpcion = 4
                      
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
    
    Call FUNC_TRAER_DATOS(1)

End Sub


Private Sub Grd_Gestion_AfterEdit(ByVal Row As Long, ByVal Col As Long)

    Select Case Col
        Case 0, 1, 2, 3, 5, 6, 7, 8, 9, 10, 11, 12
            If Not FUNC_VALIDA_REPETIDOS(Row) Then
                MsgBox "Hay registro repetidos..", vbExclamation
                Grd_Gestion.TextMatrix(Row, Col) = ""
            End If
    End Select

End Sub

Private Sub Grd_Gestion_KeyDown(KeyCode As Integer, Shift As Integer)

With Grd_Gestion

 Select Case KeyCode
   Case vbKeyInsert
   
      If FUNC_VALIDA_BLANCOS Then
         .Rows = .Rows + 1
         .Row = .Rows - 1
         .TopRow = .Row
         .Col = 0
         .Refresh
      Else
         MsgBox "Hay registros en Blanco", vbOKOnly + vbInformation
         .SetFocus
      End If

   Case vbKeyDelete
   
      If .Row <> 0 Then
          .RemoveItem (.Row)
          .SetFocus
      End If
  
   End Select
   
End With

End Sub


Private Sub Tlb_Botones_ButtonClick(ByVal Button As MSComctlLib.Button)

Select Case UCase(Button.Key)
    Case "LIMPIAR"
        box_Sistemas.Enabled = True
        Tlb_Botones.Buttons(1).Enabled = False
        Tlb_Botones.Buttons(2).Enabled = False
        Tlb_Botones.Buttons(3).Enabled = True
        Grd_Gestion.Col = 0
        Grd_Gestion.Row = 0
        Grd_Gestion.Rows = 1
        Grd_Gestion.Rows = 2
        Grd_Gestion.Enabled = False
        box_Sistemas.SetFocus
        
    Case "GRABAR"
        If FUNC_VALIDA_BLANCOS Then
            If FUNC_GRABAR_CODIGOS_GESTION() Then
                box_Sistemas.Enabled = True
                Tlb_Botones.Buttons(1).Enabled = False
                Tlb_Botones.Buttons(2).Enabled = False
                Tlb_Botones.Buttons(3).Enabled = True
                Grd_Gestion.Col = 0
                Grd_Gestion.Row = 0
                Grd_Gestion.Rows = 1
                Grd_Gestion.Rows = 2
                Grd_Gestion.Enabled = False
                box_Sistemas.SetFocus
            End If
        Else
            MsgBox "Hay registros en Blanco", vbOKOnly + vbInformation
            Grd_Gestion.SetFocus
        End If
        
    Case "BUSCAR"
        
        If FUNC_TRAER_DATOS(2) Then
            box_Sistemas.Enabled = False
            Grd_Gestion.Enabled = True
            Tlb_Botones.Buttons(1).Enabled = True
            Tlb_Botones.Buttons(2).Enabled = True
            Tlb_Botones.Buttons(3).Enabled = False
            
            If Grd_Gestion.Rows = 1 Then
                Grd_Gestion.Rows = 2
            End If
            
            Grd_Gestion.Col = 0
            Grd_Gestion.Row = 1
            Grd_Gestion.SetFocus
            
        End If
        
    Case "SALIR"
        Unload Me
        
End Select

End Sub


