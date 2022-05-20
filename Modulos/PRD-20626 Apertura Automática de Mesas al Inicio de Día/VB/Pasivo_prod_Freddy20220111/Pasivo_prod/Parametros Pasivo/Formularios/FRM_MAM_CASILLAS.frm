VERSION 5.00
Object = "{1C0489F8-9EFD-423D-887A-315387F18C8F}#1.0#0"; "vsflex8l.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "Mscomctl.ocx"
Begin VB.Form FRM_MAN_CASILLAS 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantenedor de Casillas de Transmision"
   ClientHeight    =   4005
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   8055
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
   ScaleHeight     =   4005
   ScaleWidth      =   8055
   Begin VB.Frame frm_Casillas 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   3495
      Left            =   45
      TabIndex        =   0
      Top             =   480
      Width           =   7965
      Begin VSFlex8LCtl.VSFlexGrid Grd_Casillas 
         Height          =   3315
         Left            =   60
         TabIndex        =   2
         Top             =   135
         Width           =   7860
         _cx             =   13864
         _cy             =   5847
         Appearance      =   1
         BorderStyle     =   1
         Enabled         =   -1  'True
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
         Cols            =   5
         FixedRows       =   1
         FixedCols       =   0
         RowHeightMin    =   0
         RowHeightMax    =   0
         ColWidthMin     =   0
         ColWidthMax     =   0
         ExtendLastCol   =   0   'False
         FormatString    =   $"FRM_MAM_CASILLAS.frx":0000
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
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   1
      Top             =   0
      Width           =   8055
      _ExtentX        =   14208
      _ExtentY        =   847
      ButtonWidth     =   820
      ButtonHeight    =   794
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Key             =   "Limpiar"
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Key             =   "Grabar"
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Key             =   "Eliminar"
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Buscar"
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   6
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   5790
         Top             =   -90
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   24
         ImageHeight     =   24
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   7
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAM_CASILLAS.frx":00B2
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAM_CASILLAS.frx":0F8C
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAM_CASILLAS.frx":1E66
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAM_CASILLAS.frx":2D40
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAM_CASILLAS.frx":3C1A
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAM_CASILLAS.frx":4AF4
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAM_CASILLAS.frx":4E0E
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
End
Attribute VB_Name = "FRM_MAN_CASILLAS"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit



Function FUNC_BUSCAR()
Dim Envia()

Grd_Casillas.Rows = 1

If BAC_SQL_EXECUTE("SP_CON_CASILLA_TRANSMISION") Then
    Do While BAC_SQL_FETCH(Datos())
        Grd_Casillas.Rows = Grd_Casillas.Rows + 1
        Grd_Casillas.TextMatrix(Grd_Casillas.Rows - 1, 0) = Datos(1)
        Grd_Casillas.TextMatrix(Grd_Casillas.Rows - 1, 1) = Datos(2)
        Grd_Casillas.TextMatrix(Grd_Casillas.Rows - 1, 2) = Datos(3)
        Grd_Casillas.TextMatrix(Grd_Casillas.Rows - 1, 3) = Datos(4)
        Grd_Casillas.TextMatrix(Grd_Casillas.Rows - 1, 4) = Datos(5)
    Loop
End If

End Function


Function FUNC_ELIMINAR()

If Grd_Casillas.TextMatrix(Grd_Casillas.Row, 0) = "LOCAL" Then
    MsgBox "No se puede eliminar este registro", vbExclamation
Else
    If Grd_Casillas.TextMatrix(Grd_Casillas.Row, 0) = "" Then
        Grd_Casillas.RemoveItem Grd_Casillas.Row
    Else
        If MsgBox("¿Seguro de Eliminar esta Casilla?", vbQuestion + vbYesNo) = vbYes Then
            Grd_Casillas.RowHeight(Grd_Casillas.Row) = 0
        End If
    End If
End If
Grd_Casillas.SetFocus

End Function

Function FUNC_GRABAR()
Dim nContador   As Long
Dim Envia()
Dim bLocal      As Boolean

If BAC_SQL_EXECUTE("BEGIN TRANSACTION") Then
   
    '/* Eliminando
    '------------- */
    For nContador = 1 To Grd_Casillas.Rows - 1
        If Grd_Casillas.RowHeight(nContador) = 0 Then
            Envia = Array()
            AddParam Envia, Grd_Casillas.TextMatrix(nContador, 0)
            If Not BAC_SQL_EXECUTE("SP_ELI_CASILLA_TRANSMISION", Envia) Then
                GoTo Sql_Error
            Else
                If BAC_SQL_FETCH(Datos()) Then
                    If Datos(1) = "NO" Then
                        MsgBox "Casilla " & Grd_Casillas.TextMatrix(nContador, 0) & " no se puede elimiar por estar relacionada", vbExclamation
                    End If
                End If
            End If
        End If
    Next
    
    '/* Grabando
    '----------- */
    bLocal = False
    For nContador = 1 To Grd_Casillas.Rows - 1
        
        If Grd_Casillas.TextMatrix(nContador, 0) = "LOCAL" Then
            bLocal = True
        End If
        
        If Grd_Casillas.RowHeight(nContador) <> 0 Then
            Envia = Array()
            AddParam Envia, Grd_Casillas.TextMatrix(nContador, 0)
            AddParam Envia, Grd_Casillas.TextMatrix(nContador, 1)
            AddParam Envia, Grd_Casillas.TextMatrix(nContador, 2)
            AddParam Envia, Grd_Casillas.TextMatrix(nContador, 3)
            AddParam Envia, Grd_Casillas.TextMatrix(nContador, 4)
        
            If Not BAC_SQL_EXECUTE("SP_ACT_GRABA_CASILLA_TRANSMISION", Envia) Then
                GoTo Sql_Error
            End If
        End If
        
    Next
    
    '/* Grabando LOCAL
    '----------------- */
    If Not bLocal Then
        
        Envia = Array()
        AddParam Envia, "LOCAL"
        AddParam Envia, ""
        AddParam Envia, ""
        AddParam Envia, ""
        AddParam Envia, ""
        
        If Not BAC_SQL_EXECUTE("SP_ACT_GRABA_CASILLA_TRANSMISION", Envia) Then
            GoTo Sql_Error
        End If
        
    End If
    
    If Not BAC_SQL_EXECUTE("COMMIT TRANSACTION") Then
        GoTo Sql_Error
    End If
    MsgBox "Información Grabada Correctamente.", vbInformation
    Grd_Casillas.Rows = 1
    Grd_Casillas.Enabled = False
    Toolbar1.Buttons(1).Enabled = False
    Toolbar1.Buttons(2).Enabled = False
    Toolbar1.Buttons(3).Enabled = False
    Toolbar1.Buttons(4).Enabled = True
    
End If

Exit Function

Sql_Error:
    
    Call BAC_SQL_EXECUTE("ROLLBACK TRANSACTION")
    MsgBox "Problemas con la Grabacion..", vbExclamation
    Exit Function

End Function

Private Sub Form_Activate()
   PROC_CARGA_AYUDA Me, " "
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
Dim nOpcion As Long

   nOpcion = 0
   
   If KeyCode = vbKeyF2 Then
      KeyCode = 0
   End If

   If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) Then
     
        Select Case KeyCode
         
            Case vbKeyLimpiar:
                              nOpcion = 1
   
            Case vbKeyGrabar:
                              nOpcion = 2
                              
            Case vbKeyEliminar:
                              nOpcion = 3
                              
            Case vbKeyBuscar:
                              nOpcion = 4

            Case vbKeySalir:
                              nOpcion = 5
                      
      End Select

      If nOpcion <> 0 Then
      
            If Toolbar1.Buttons(nOpcion).Enabled Then
            
               Call Toolbar1_ButtonClick(Toolbar1.Buttons(nOpcion))
               
            End If
            KeyCode = 0
            
      End If
      
   End If

End Sub

Private Sub Form_Load()

   Me.Icon = BAC_Parametros.Icon
   Me.left = 0
   Me.top = 0

End Sub

Private Sub Grd_Casillas_KeyDown(KeyCode As Integer, Shift As Integer)

With Grd_Casillas
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
            Call FUNC_ELIMINAR
       
    End Select
    
End With

End Sub


Private Function FUNC_VALIDA_BLANCOS() As Boolean
Dim nIndice As Long

With Grd_Casillas
   
      For nIndice = 1 To .Rows - 1
      
         If Trim(.TextMatrix(nIndice, 0)) = "" Or Trim(.TextMatrix(nIndice, 1)) = "" And .RowHidden(nIndice) = False Then
         
            If .TextMatrix(nIndice, 0) <> "LOCAL" Then
                FUNC_VALIDA_BLANCOS = False
                Exit Function
            End If
            
         End If
         
      Next nIndice
      
      FUNC_VALIDA_BLANCOS = True
      
End With

End Function


Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

Select Case UCase(Button.Key)
    Case "LIMPIAR"
        Grd_Casillas.Rows = 1
        Grd_Casillas.Enabled = False
        Toolbar1.Buttons(1).Enabled = False
        Toolbar1.Buttons(2).Enabled = False
        Toolbar1.Buttons(3).Enabled = False
        Toolbar1.Buttons(4).Enabled = True
        
    Case "GRABAR"
        Call FUNC_GRABAR
        
    Case "ELIMINAR"
        Call FUNC_ELIMINAR
        Grd_Casillas.SetFocus
        
    Case "BUSCAR"
        Grd_Casillas.Enabled = True
        Toolbar1.Buttons(1).Enabled = True
        Toolbar1.Buttons(2).Enabled = True
        Toolbar1.Buttons(3).Enabled = True
        Toolbar1.Buttons(4).Enabled = False
        Call FUNC_BUSCAR
        Grd_Casillas.SetFocus
        
    Case "SALIR"
        Unload Me
        
End Select


End Sub


