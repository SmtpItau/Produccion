VERSION 5.00
Object = "{1C0489F8-9EFD-423D-887A-315387F18C8F}#1.0#0"; "vsflex8l.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form BacMntArea 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantenedor de Areas"
   ClientHeight    =   3825
   ClientLeft      =   3525
   ClientTop       =   4020
   ClientWidth     =   11055
   Icon            =   "BacMntArea.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   3825
   ScaleWidth      =   11055
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   11055
      _ExtentX        =   19500
      _ExtentY        =   847
      ButtonWidth     =   820
      ButtonHeight    =   794
      Appearance      =   1
      Style           =   1
      ImageList       =   "Img_opciones"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Grabar"
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList Img_opciones 
         Left            =   5760
         Top             =   30
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   24
         ImageHeight     =   24
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   9
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntArea.frx":2EFA
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntArea.frx":3361
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntArea.frx":3857
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntArea.frx":3CEA
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntArea.frx":41D2
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntArea.frx":46E5
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntArea.frx":4BB8
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntArea.frx":507E
               Key             =   ""
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntArea.frx":5575
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame Frame1 
      Height          =   3390
      Left            =   -30
      TabIndex        =   1
      Top             =   480
      Width           =   11040
      Begin VSFlex8LCtl.VSFlexGrid Grilla 
         Height          =   3195
         Left            =   60
         TabIndex        =   2
         Top             =   120
         Width           =   10905
         _cx             =   19235
         _cy             =   5636
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
         ForeColor       =   8388608
         BackColorFixed  =   8421376
         ForeColorFixed  =   16777215
         BackColorSel    =   -2147483635
         ForeColorSel    =   -2147483644
         BackColorBkg    =   -2147483636
         BackColorAlternate=   -2147483644
         GridColor       =   -2147483633
         GridColorFixed  =   -2147483632
         TreeColor       =   -2147483632
         FloodColor      =   192
         SheetBorder     =   -2147483642
         FocusRect       =   1
         HighLight       =   1
         AllowSelection  =   -1  'True
         AllowBigSelection=   -1  'True
         AllowUserResizing=   0
         SelectionMode   =   0
         GridLines       =   2
         GridLinesFixed  =   0
         GridLineWidth   =   1
         Rows            =   2
         Cols            =   6
         FixedRows       =   1
         FixedCols       =   0
         RowHeightMin    =   0
         RowHeightMax    =   0
         ColWidthMin     =   0
         ColWidthMax     =   0
         ExtendLastCol   =   0   'False
         FormatString    =   $"BacMntArea.frx":5A6D
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
End
Attribute VB_Name = "BacMntArea"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim OptLocal As String
Dim cCodigo As String
Dim nCodigo As Integer
Dim Ncodigo_dos As Integer

Private Sub Form_Activate()
   PROC_CARGA_AYUDA Me, " "
   Call FUNC_LIMPIAR
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
Dim opcion As Integer

If KeyCode = vbKeyReturn And UCase(Me.ActiveControl.Name) <> "TXTNUMERICO" And UCase(Me.ActiveControl.Name) <> "GRILLA" Then
      KeyCode = 0
      Exit Sub
End If

If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) Then

   opcion = 0
   Select Case KeyCode

         
         Case vbKeyGrabar
               opcion = 1
         Case vbKeySalir
               opcion = 2
         End Select

   If opcion <> 0 Then
      If Toolbar1.Buttons(opcion).Enabled Then
         Call Toolbar1_ButtonClick(Toolbar1.Buttons(opcion))
      End If

   End If

End If

End Sub


Private Sub Form_Load()
   OptLocal = Opt
   Me.top = 0
   Me.left = 0
   Call FUNC_DIBUJA_GRILLA
   Call FUNC_TRAER_AREA
    
   Call LogAuditoria("07", OptLocal, Me.Caption, "", "")
   
End Sub
Private Function FUNC_DIBUJA_GRILLA()
   grilla.Rows = 2
   grilla.FixedRows = 1
   grilla.Cols = 6
   grilla.FixedCols = 0
   grilla.TextMatrix(0, 0) = "Código"
   grilla.TextMatrix(0, 1) = "Descripción"
   grilla.TextMatrix(0, 2) = "Posición Cambio"
   grilla.TextMatrix(0, 3) = "Posición Futuro"
   grilla.TextMatrix(0, 4) = "Ctb.Trader"
   grilla.TextMatrix(0, 5) = "Ctb.Inversiones"
   grilla.ColWidth(0) = 1600
   grilla.ColWidth(1) = 3500
   grilla.ColWidth(2) = 1500
   grilla.ColWidth(3) = 1500
   grilla.ColWidth(4) = 1500
   grilla.ColWidth(5) = 1500
   grilla.RowHeight(0) = 315
   grilla.Rows = 1
End Function

Private Function FUNC_TRAER_AREA()

 If Not BAC_SQL_EXECUTE("Sp_Leer_Area_Producto") Then
   MsgBox "Problema al Leer Areas", vbInformation
   Me.MouseIcon = defalut
   Exit Function
 End If
 
 Do While BAC_SQL_FETCH(Datos())
  
   grilla.Rows = grilla.Rows + 1
   grilla.TextMatrix(grilla.Rows - 1, 0) = Datos(1)
   grilla.TextMatrix(grilla.Rows - 1, 1) = Datos(2)
   grilla.TextMatrix(grilla.Rows - 1, 2) = Datos(3)
   grilla.TextMatrix(grilla.Rows - 1, 3) = Datos(4)
   grilla.TextMatrix(grilla.Rows - 1, 4) = Datos(5)
   grilla.TextMatrix(grilla.Rows - 1, 5) = Datos(6)
   
 If grilla.TextMatrix(grilla.Row, 0) <> "" Then
 
   If grilla.Rows > 1 Then
      grilla.FocusRect = flexFocusNone
   End If
   
 End If
 

  
 Loop
End Function


Private Sub Form_Unload(Cancel As Integer)
   Call LogAuditoria("08", OptLocal, Me.Caption, "", "")
End Sub


Private Sub Grilla_AfterEdit(ByVal Row As Long, ByVal Col As Long)
With grilla

   If Col = 0 Then
      
      If Not FUNC_VALIDAR_CODIGO Then
      
         MsgBox "Código ya existe", vbOKOnly + vbInformation
         .TextMatrix(Row, 0) = ""
         .Col = 0
         .SetFocus
      Else
         .Col = 1
         .SetFocus
      End If
      
   End If
    
   If .Col > 1 Then
   
         'If .TextMatrix(.Row, 2) = True Or .TextMatrix(.Row, 3) = True Or .TextMatrix(.Row, 4) = True Or .TextMatrix(.Row, 5) = True Then
         For i = 1 To .Rows - 1
          If .TextMatrix(i, Col) = True And i <> .Row Then
           '   Exit Sub
             .TextMatrix(i, Col) = 0
          End If
          Next i
       
        Call FUNC_VALIDAR_AGRUPACION
   End If
   
   If Trim(.TextMatrix(Row, 0)) = "" Then
      
        .TextMatrix(Row, 1) = ""
      
   End If
   

If Col = 1 Then
   .Col = 0
   .Sort = flexSortStringAscending
   .Col = 1
End If
End With
End Sub

Private Sub Grilla_KeyDown(KeyCode As Integer, Shift As Integer)
With grilla

 Select Case KeyCode
   Case vbKeyInsert
   
      If FUNC_VALIDA_BLANCOS Then
         .Rows = .Rows + 1
         .Row = .Rows - 1
         .TextMatrix(grilla.Row, 2) = 0
         .TextMatrix(grilla.Row, 3) = 0
         .TextMatrix(grilla.Row, 4) = 0
         .TextMatrix(grilla.Row, 5) = 0
         .TopRow = .Row
         .Col = 0
         .Refresh
       Else
         MsgBox "Hay registros en Blanco", vbOKOnly + vbInformation
         .SetFocus
       End If

   Case vbKeyDelete
   
      If .Row <> 0 Then
      
        If Trim(.TextMatrix(.Row, 0)) = "" And Trim(.TextMatrix(.Row, 1)) = "" Then
          .RemoveItem (.Row)
        Else
        
                   
               Envia = Array()
               AddParam Envia, Trim(.TextMatrix(.Row, 0))
               AddParam Envia, Trim(.TextMatrix(.Row, 1))
               AddParam Envia, "S"
         
               If Not BAC_SQL_EXECUTE("Sp_Eliminar_Area_Producto", Envia) Then Exit Sub
               
               Do While BAC_SQL_FETCH(Datos())
               
                  If Datos(1) = "2" Then
                     MsgBox "No se puede eliminar código:" & Trim(.TextMatrix(.Row, 0)) & " datos relacionados", vbOKOnly + vbCritical
                  Else
                     .RowHidden(.Row) = True
                  End If
               Loop
              
        End If
        
        If FUNC_VALIDAR_UNA_FILA Then
            grilla.Rows = grilla.Rows + 1
            grilla.Row = grilla.Rows - 1
            grilla.Col = 0
        Else
             KeyCode = 40
        End If
        
          .SetFocus
        
        
      End If
      
  
   End Select
End With
End Sub


Private Sub Grilla_KeyPress(KeyAscii As Integer)

   If Trim(grilla.TextMatrix(grilla.Row, 0)) <> "" And grilla.Col = 0 Then
       KeyAscii = 0
       Exit Sub
   End If
   
   If grilla.Col = 0 Then
      grilla.EditMaxLength = 5
   Else
      grilla.EditMaxLength = 50
   End If
End Sub



Private Sub Grilla_KeyPressEdit(ByVal Row As Long, ByVal Col As Long, KeyAscii As Integer)
KeyAscii = Caracter(KeyAscii)
KeyAscii = Asc(UCase(Chr(KeyAscii)))

If Col = 1 And Trim(grilla.TextMatrix(Row, 0)) = "" Then

   KeyAscii = 0
   MsgBox "Debe Ingresar Código", vbOKOnly + vbInformation
   grilla.Col = 0
   grilla.SetFocus
   
End If
End Sub

Private Function FUNC_VALIDA_BLANCOS() As Boolean

With grilla
   
      For nIndice = 1 To .Rows - 1
      
         If Trim(.TextMatrix(nIndice, 0)) = "" Or Trim(.TextMatrix(nIndice, 1)) = "" And .RowHidden(nIndice) = False Then
         
            FUNC_VALIDA_BLANCOS = False
            Exit Function
            
         End If
         
      Next nIndice
      
      FUNC_VALIDA_BLANCOS = True
      
End With

End Function

Private Function FUNC_VALIDAR_CODIGO() As Boolean

With grilla

 cCodigo = Trim(.TextMatrix(.Row, 0))
 
 For nIndice = 1 To .Rows - 1
 
   If cCodigo = Trim(.TextMatrix(nIndice, 0)) And nIndice <> .Row And .RowHidden(nIndice) = False Then
      
      FUNC_VALIDAR_CODIGO = False
      Exit Function
      
   End If
   
 Next nIndice
 
 FUNC_VALIDAR_CODIGO = True

End With

End Function


Private Function FUNC_VALIDAR_AGRUPACION() As Boolean

With grilla

 cCodigo = .Row
 
 For nIndice = 1 To .Rows - 1
 
  
  
   If nIndice <> cCodigo And .TextMatrix(nIndice, .Col) = True And .RowHidden(nIndice) = False Then
      .TextMatrix(nIndice, .Col) = 0
      FUNC_VALIDAR_AGRUPACION = False
      Exit Function
      
   End If
   
  
 Next nIndice
 
 
 FUNC_VALIDAR_AGRUPACION = True

End With

End Function



Private Function FUNC_VALIDAR_UNA_FILA() As Boolean

FUNC_VALIDAR_UNA_FILA = False

nCodigo = 1
nIndice = 0

For nIndice = 1 To grilla.Rows - 1
   If grilla.RowHidden(nIndice) = True Then
         nCodigo = nCodigo + 1
   End If
Next nIndice

If nCodigo = nIndice Then

   FUNC_VALIDAR_UNA_FILA = True
End If

End Function


Private Function FUNC_VALIDAR_AGRUPACION_MARCA() As Boolean

FUNC_VALIDAR_AGRUPACION_MARCA = True

nCodigo = 1


For nIndice = 1 To grilla.Rows - 1
   If grilla.RowHidden(nIndice) = False And grilla.TextMatrix(nIndice, 2) = 0 Then
         nCodigo = nCodigo + 1
   End If
Next nIndice

If nCodigo = nIndice Then

   FUNC_VALIDAR_AGRUPACION_MARCA = False
Else

    nCodigo = 1
    For nIndice = 1 To grilla.Rows - 1
       If grilla.RowHidden(nIndice) = False And grilla.TextMatrix(nIndice, 3) = 0 Then
             nCodigo = nCodigo + 1
       End If
    Next nIndice
    
    If nCodigo = nIndice Then
    
     FUNC_VALIDAR_AGRUPACION_MARCA = False
     
    End If
    
    nCodigo = 1
    For nIndice = 1 To grilla.Rows - 1
       If grilla.RowHidden(nIndice) = False And grilla.TextMatrix(nIndice, 4) = 0 Then
             nCodigo = nCodigo + 1
       End If
    Next nIndice
    
    If nCodigo = nIndice Then
    
     FUNC_VALIDAR_AGRUPACION_MARCA = False
     
    End If
        nCodigo = 1
    For nIndice = 1 To grilla.Rows - 1
       If grilla.RowHidden(nIndice) = False And grilla.TextMatrix(nIndice, 5) = 0 Then
             nCodigo = nCodigo + 1
       End If
    Next nIndice
    
    If nCodigo = nIndice Then
    
     FUNC_VALIDAR_AGRUPACION_MARCA = False
     
    End If
        
End If

End Function



Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
 Select Case Trim(UCase(Button.Key))
 Case "GRABAR"
  If FUNC_VALIDAR_AGRUPACION_MARCA Then
    Call FUNC_GRABAR_AREA
  Else
    MsgBox "Debe seleccionar un Area para cada Módulo", vbInformation
  End If
 Case "SALIR"
    Unload Me
 End Select
End Sub

Private Function FUNC_LIMPIAR()
    grilla.Redraw = False
    grilla.Rows = 1
    grilla.Col = 0
    grilla.Redraw = True
    Call FUNC_TRAER_AREA
   
End Function

Private Function FUNC_GRABAR_AREA()

  
Dim sMensaje As String

With grilla

.Redraw = flexRDNone

If Not BAC_SQL_EXECUTE("BEGIN TRANSACTION") Then GoTo Errores

   For nIndice = 1 To .Rows - 1
   
     If .RowHidden(nIndice) = True Then
     
            Envia = Array()
            AddParam Envia, Trim(.TextMatrix(nIndice, 0))
            AddParam Envia, Trim(.TextMatrix(nIndice, 1))
         
            If Not BAC_SQL_EXECUTE("Sp_Eliminar_Area_Producto", Envia) Then GoTo Errores
               
            Do While BAC_SQL_FETCH(Datos())
               
               If Datos(1) = "NO" Then
                   sMensaje = sMensaje & " " & Trim(.TextMatrix(nIndice, 0)) & ","
                   .RowHidden(nIndice) = False
               Else
                  Call LogAuditoria("03", Opt, Me.Caption, "", "Código: " & Trim(.TextMatrix(nIndice, 0)))
               End If
            Loop
            
     End If
               
   Next nIndice
              
   For nIndice = 1 To .Rows - 1
   
      If .RowHidden(nIndice) = False And Trim(.TextMatrix(nIndice, 0)) <> "" Then
      
         Envia = Array()
         AddParam Envia, Trim(.TextMatrix(nIndice, 0))
         AddParam Envia, Trim(.TextMatrix(nIndice, 1))
         AddParam Envia, IIf(Trim(.TextMatrix(nIndice, 2)) = -1, 1, .TextMatrix(nIndice, 2))
         AddParam Envia, IIf(Trim(.TextMatrix(nIndice, 3)) = -1, 1, .TextMatrix(nIndice, 3))
         AddParam Envia, IIf(Trim(.TextMatrix(nIndice, 4)) = -1, 1, .TextMatrix(nIndice, 4))
         AddParam Envia, IIf(Trim(.TextMatrix(nIndice, 5)) = -1, 1, .TextMatrix(nIndice, 5))
         
         If Not BAC_SQL_EXECUTE("Sp_Grabar_Area_Producto", Envia) Then GoTo Errores
         
          Do While BAC_SQL_FETCH(Datos())
               
               If Datos(1) = "SI" Then 'Ingreso

                  Call LogAuditoria("01", Opt, Me.Caption, "", "Código: " & Trim(.TextMatrix(nIndice, 0)))

               ElseIf Datos(1) = "MOD" Then 'Modificación

                  Call LogAuditoria("02", Opt, Me.Caption, "", "Código: " & Trim(.TextMatrix(nIndice, 0)))
               End If
          Loop
     
     End If
   Next nIndice
   
   If sMensaje <> "" Then
      MsgBox "Los siguientes códigos no fueron eliminados por estar relacionados " & sMensaje, vbInformation
   End If
   
   If Not BAC_SQL_EXECUTE("COMMIT TRANSACTION") Then GoTo Errores

   MsgBox "Información Grabada Correctamente.", vbOKOnly + vbInformation
   Call FUNC_LIMPIAR
   
   .Redraw = flexRDDirect
   
End With

Exit Function

Errores:

If Not BAC_SQL_EXECUTE("ROLLBACK TRANSACTION") Then
   MsgBox "Error al Reversar la Acción", vbOKOnly + vbCritical
   Exit Function
End If

MsgBox "Información No fue Grabada.", vbOKOnly + vbCritical

End Function


Private Sub PROC_HABILITA_CONTROLES(bValor As Boolean)

   With Toolbar1
      .Buttons(1).Enabled = True
      .Buttons(2).Enabled = bValor

   
   End With

End Sub




