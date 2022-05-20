VERSION 5.00
Object = "{1C0489F8-9EFD-423D-887A-315387F18C8F}#1.0#0"; "vsflex8l.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "Mscomctl.ocx"
Begin VB.Form FRM_MAN_EJECUTIVO 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Mantención de Ejecutivo"
   ClientHeight    =   3825
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   7380
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   3825
   ScaleWidth      =   7380
   ShowInTaskbar   =   0   'False
   Begin VB.Frame Frame1 
      Height          =   705
      Left            =   -15
      TabIndex        =   2
      Top             =   480
      Width           =   7350
      Begin VB.ComboBox Cmb_entidad 
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
         Left            =   4770
         Style           =   2  'Dropdown List
         TabIndex        =   6
         Top             =   210
         Width           =   2370
      End
      Begin VB.ComboBox Cmb_Area 
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
         Left            =   615
         Style           =   2  'Dropdown List
         TabIndex        =   4
         Top             =   195
         Width           =   3180
      End
      Begin VB.Label Label1 
         Caption         =   "Entidad"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   3975
         TabIndex        =   5
         Top             =   255
         Width           =   765
      End
      Begin VB.Label Lbl_Area 
         Caption         =   "Area"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   60
         TabIndex        =   3
         Top             =   290
         Width           =   1395
      End
   End
   Begin MSComctlLib.Toolbar Tlb_Botones 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   7380
      _ExtentX        =   13018
      _ExtentY        =   847
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "Ilst_Imagenes"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   5
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSComctlLib.ImageList Ilst_Imagenes 
      Left            =   0
      Top             =   0
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   24
      ImageHeight     =   24
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   5
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MAN_EJECUTIVO.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MAN_EJECUTIVO.frx":0EDA
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MAN_EJECUTIVO.frx":1DB4
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MAN_EJECUTIVO.frx":2C8E
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MAN_EJECUTIVO.frx":3B68
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VSFlex8LCtl.VSFlexGrid Grd_Ingreso 
      Height          =   2595
      Left            =   30
      TabIndex        =   1
      Top             =   1200
      Width           =   7305
      _cx             =   12885
      _cy             =   4577
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
      Cols            =   4
      FixedRows       =   1
      FixedCols       =   0
      RowHeightMin    =   0
      RowHeightMax    =   0
      ColWidthMin     =   0
      ColWidthMax     =   0
      ExtendLastCol   =   0   'False
      FormatString    =   $"FRM_MAN_EJECUTIVO.frx":3E82
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
Attribute VB_Name = "FRM_MAN_EJECUTIVO"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'  Autor          : Pamela Farías
'  Descripción    : Mantención de Tipo de Base
'  Fecha Creación : 29/11/2002
'  Fecha Modificación   : DD/MM/YYYY
'  Modificado Por       : Nombre de la persona que modifica la forma
'  Cambios Realizados   : Explicación de la modificación

Dim nIndice As Integer
Dim nCodigo As Long
Dim nRut    As Long
Dim nOpcion As Integer

Private Function FUNC_VALIDA_DATOS() As Boolean

   For nIndice = 1 To Grd_Ingreso.Rows - 1
   
        If (Trim(Grd_Ingreso.TextMatrix(nIndice, 2)) = "" Or Trim(Grd_Ingreso.TextMatrix(nIndice, 3)) = "") And Trim(Grd_Ingreso.TextMatrix(nIndice, 0)) <> "" And Grd_Ingreso.RowHidden(nIndice) = False Then
            
            FUNC_VALIDA_DATOS = False
            Exit Function
        End If
        
   Next nIndice
   
   FUNC_VALIDA_DATOS = True
   
End Function

Private Function FUNC_LLENAR_COMBO()

      If BAC_SQL_EXECUTE("Sp_BacIniValDef_DevuelveArea") Then
        
        Do While BAC_SQL_FETCH(Datos())
       
               Cmb_Area.AddItem (Datos(2) & Space(150) & Datos(1))
        Loop
      End If
      
      Cmb_Area.ListIndex = 0
      
      If BAC_SQL_EXECUTE("SP_CON_ENTIDAD") Then
        
        Do While BAC_SQL_FETCH(Datos())
               Cmb_entidad.AddItem (Datos(2) & Space(150) & Datos(1))
               Cmb_entidad.ItemData(NewIndex) = Datos(3)
        Loop
        
      End If
      
      Cmb_entidad.ListIndex = 0
End Function


Private Sub Form_Activate()
   Opt = "Mnt_EJECUTIVO"
   PROC_CARGA_AYUDA Me, " "
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
On Error GoTo err

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
                            If UCase(ActiveControl.Name) <> "TXTINGRESO" Then
                              nOpcion = 5
                            End If
                      
      End Select

      If nOpcion <> 0 Then
            If Tlb_Botones.Buttons(nOpcion).Enabled Then
               Call Tlb_Botones_ButtonClick(Tlb_Botones.Buttons(nOpcion))
            End If
            KeyCode = 0
      End If
  
      
   End If
Exit Sub
err:
  Resume Next

End Sub

Private Sub Form_Load()
Me.Icon = BAC_Parametros.Icon
Me.top = 0
Me.left = 0
FUNC_LLENAR_COMBO
Call Tlb_Botones_ButtonClick(Tlb_Botones.Buttons(1))
Grd_Ingreso.Enabled = False
End Sub

Private Function FUNC_LIMPIAR_EJECUTIVO()

With Grd_Ingreso

   .Rows = 2
   .TextMatrix(1, 0) = ""
   .TextMatrix(1, 1) = ""
   .TextMatrix(1, 2) = ""
   .TextMatrix(1, 3) = ""
   .Col = 0
End With

End Function

Private Function FUNC_GRABAR_EJECUTIVO()


With Grd_Ingreso

.Redraw = flexRDNone

If Not BAC_SQL_EXECUTE("BEGIN TRANSACTION") Then GoTo Errores

   For nIndice = 1 To .Rows - 1
   

     If .RowHidden(nIndice) = True Then
     
                   
            Envia = Array()
            AddParam Envia, Val(.TextMatrix(nIndice, 0))
            AddParam Envia, Val(.TextMatrix(nIndice, 2))
         
            If Not BAC_SQL_EXECUTE("SP_DEL_EJECUTIVO", Envia) Then GoTo Errores
               
            Do While BAC_SQL_FETCH(Datos())
               
               If Datos(1) = "NO" Then
                   sMensaje = sMensaje & " " & Val(.TextMatrix(nIndice, 0)) & ","
                   .RowHidden(nIndice) = False
               Else
                  Call LogAuditoria("03", Opt, Me.Caption, "", "Código: " & Val(.TextMatrix(nIndice, 0)))
               End If
               
            Loop
               
     End If
               
   Next nIndice
              

   For nIndice = 1 To .Rows - 1
   
      If .RowHidden(nIndice) = False And Trim(.TextMatrix(nIndice, 0)) <> "" Then
      
         Envia = Array()
         AddParam Envia, Cmb_entidad.ItemData(Cmb_entidad.ListIndex) 'rut entidad
         AddParam Envia, Val(right(Trim(Cmb_entidad.Text), 10)) 'codigo entidad
         AddParam Envia, Val(.TextMatrix(nIndice, 0)) 'Rut ejecutivo
         AddParam Envia, Val(.TextMatrix(nIndice, 2)) 'Código Ejecutivo
         AddParam Envia, Trim(.TextMatrix(nIndice, 3)) 'Nombre Ejecutivo
         AddParam Envia, Trim(right(Cmb_Area.Text, 5)) 'area
      
         If Not BAC_SQL_EXECUTE("SP_ACT_EJECUTIVO", Envia) Then GoTo Errores
         
         Do While BAC_SQL_FETCH(Datos())
               
               If Datos(1) = "SI" Then 'Ingreso
               
                  Call LogAuditoria("01", Opt, Me.Caption, "", "Código: " & Val(.TextMatrix(nIndice, 0)))
                  
               ElseIf Datos(1) = "MOD" Then 'Modificación
               
                  Call LogAuditoria("02", Opt, Me.Caption, "", "Código: " & Val(.TextMatrix(nIndice, 0)))
               End If
          Loop
          
      End If
      
   Next nIndice
   
   If sMensaje <> "" Then
      MsgBox "Los siguientes códigos no fueron eliminados por estar relacionados " & sMensaje, vbInformation
   End If
   
   If Not BAC_SQL_EXECUTE("COMMIT TRANSACTION") Then GoTo Errores

   MsgBox "Información Grabada Correctamente.", vbOKOnly + vbInformation
   
   Call FUNC_TRAER_EJECUTIVO
   
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


Private Function FUNC_ELIMINAR_EJECUTIVO()


With Grd_Ingreso

If Not BAC_SQL_EXECUTE("BEGIN TRANSACTION") Then GoTo Errores
      

   For nIndice = 1 To .Rows - 1
    
         Envia = Array()
            AddParam Envia, Val(.TextMatrix(nIndice, 0))
            AddParam Envia, Val(.TextMatrix(nIndice, 2))
      
         If Not BAC_SQL_EXECUTE("SP_DEL_EJECUTIVO", Envia) Then GoTo Errores
         
           Do While BAC_SQL_FETCH(Datos())
               
                  If Datos(1) = "NO" Then
                     MsgBox Datos(2), vbOKOnly + vbInformation
                     GoTo Errores
                  End If
            Loop
     
   Next nIndice
   
   If Not BAC_SQL_EXECUTE("COMMIT TRANSACTION") Then GoTo Errores
   Call Tlb_Botones_ButtonClick(Tlb_Botones.Buttons(1))
   MsgBox "Información Eliminada Correctamente.", vbOKOnly + vbInformation

   
End With

Exit Function

Errores:

If Not BAC_SQL_EXECUTE("ROLLBACK TRANSACTION") Then
   MsgBox "Error al Reversar la Acción", vbOKOnly + vbCritical
   Exit Function
End If

MsgBox "Información No fue Eliminada.", vbOKOnly + vbCritical

End Function



Private Function FUNC_TRAER_EJECUTIVO()

With Grd_Ingreso

      Envia = Array()
      AddParam Envia, Trim(right(Cmb_Area.Text, 5))
      AddParam Envia, Cmb_entidad.ItemData(Cmb_entidad.ListIndex) 'rut entidad
      AddParam Envia, Val(right(Trim(Cmb_entidad.Text), 5))
      
      If Not BAC_SQL_EXECUTE("SP_CON_EJECUTIVO", Envia) Then
      
         MsgBox "No fue posible leer información", vbOKOnly + vbCritical
         Exit Function
         
      Else
      
         .Rows = 1
         
         Do While BAC_SQL_FETCH(Datos())
         
             .Rows = .Rows + 1
             nIndice = .Rows - 1
            .TextMatrix(nIndice, 0) = Datos(1)
            .TextMatrix(nIndice, 1) = BacDevuelveDig(Trim(Datos(1)))
            .TextMatrix(nIndice, 2) = Datos(2)
            .TextMatrix(nIndice, 3) = Datos(3)
            
         Loop
        
     End If
    
    If .Rows = 1 Then
      Call FUNC_LIMPIAR_EJECUTIVO
    End If
    
   .Enabled = True
   Cmb_Area.Enabled = False
   Cmb_entidad.Enabled = False
   Tlb_Botones.Buttons(2).Enabled = True
   Tlb_Botones.Buttons(3).Enabled = True
   Tlb_Botones.Buttons(4).Enabled = False
   Grd_Ingreso.Col = 0
   Grd_Ingreso.Row = 1
   Grd_Ingreso.SetFocus
   
End With
End Function

Private Sub Grd_Ingreso_AfterEdit(ByVal Row As Long, ByVal Col As Long)

With Grd_Ingreso

   If Col = 0 Or Col = 2 Then
      
      If Not FUNC_VALIDAR_CODIGO Then
      
         MsgBox "Rut y Código ya existe", vbOKOnly + vbInformation
         .TextMatrix(Row, 0) = ""
         .Col = 0
         
      Else
         If Col = 0 Then
         .TextMatrix(.Row, 1) = BacDevuelveDig(Trim(.TextMatrix(.Row, 0)))
         .Col = 2
         End If
      End If
      If .Enabled = True Then .SetFocus
   End If
   
   If Trim(.TextMatrix(Row, 0)) = "" Then
      
        .TextMatrix(Row, 1) = ""
        .TextMatrix(Row, 2) = ""
      
   End If
   
   If Col = 3 Then
    .Col = 0
    .Sort = flexSortNumericAscending
    .Col = 3
   End If

   
End With


End Sub

Private Sub Grd_Ingreso_AfterRowColChange(ByVal OldRow As Long, ByVal OldCol As Long, ByVal NewRow As Long, ByVal NewCol As Long)
If OldCol = 0 And NewCol = 1 Then
    Grd_Ingreso.Col = 2
ElseIf OldCol = 2 And NewCol = 1 Then
    Grd_Ingreso.Col = 0
End If

End Sub

Private Sub Grd_Ingreso_KeyDownEdit(ByVal Row As Long, ByVal Col As Long, KeyCode As Integer, ByVal Shift As Integer)

If Col = 2 And KeyCode = 13 Then
    Grd_Ingreso.Col = 3
    Grd_Ingreso.SetFocus
End If

If Col = 1 And KeyCode = 13 Then
    Grd_Ingreso.Col = 2
    Grd_Ingreso.SetFocus
End If
End Sub

Private Sub Grd_Ingreso_KeyPressEdit(ByVal Row As Long, ByVal Col As Long, KeyAscii As Integer)

KeyAscii = Caracter(KeyAscii)
KeyAscii = Asc(UCase(Chr(KeyAscii)))

If Col = 1 Then KeyAscii = 0
   

If (Col = 3 Or Col = 2) And Trim(Grd_Ingreso.TextMatrix(Row, 0)) = "" Then

   KeyAscii = 0
   MsgBox "Debe Ingresar Rut", vbOKOnly + vbInformation
   Grd_Ingreso.Col = 0
   Grd_Ingreso.SetFocus
   
ElseIf Col = 3 And Trim(Grd_Ingreso.TextMatrix(Row, 2)) = "" Then
   
   KeyAscii = 0
   MsgBox "Debe Ingresar Código", vbOKOnly + vbInformation
   Grd_Ingreso.Col = 2
   Grd_Ingreso.SetFocus
ElseIf Col = 1 Then
    KeyAscii = 0

End If


End Sub
Private Sub Grd_Ingreso_KeyDown(KeyCode As Integer, Shift As Integer)

With Grd_Ingreso

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
      
        If Trim(.TextMatrix(.Row, 0)) = "" And Trim(.TextMatrix(.Row, 1)) = "" And Trim(.TextMatrix(.Row, 2)) = "" And Trim(.TextMatrix(.Row, 3)) = "" Then
          .RemoveItem (.Row)
        Else
' Se usara para la validación de Relación del Ejecutivo
'               Envia = Array()
                
'               AddParam Envia, Val(.TextMatrix(nIndice, 0))
'               AddParam Envia, Val(.TextMatrix(nIndice, 2))
'               AddParam Envia, "S"
'
'               If Not BAC_SQL_EXECUTE("SP_DEL_EJECUTIVO", Envia) Then Exit Sub
'
'               Do While BAC_SQL_FETCH(Datos())
'
'                  If Datos(1) = "NO" Then
'                     MsgBox Datos(2), vbOKOnly + vbInformation
'                  Else
                     .RowHidden(.Row) = True
'                  End If
'               Loop
        End If
        
        If FUNC_VALIDAR_UNA_FILA Then
            Grd_Ingreso.Rows = Grd_Ingreso.Rows + 1
            Grd_Ingreso.Row = Grd_Ingreso.Rows - 1
            Grd_Ingreso.Col = 0
        Else
            KeyCode = 40
        End If
        
          .SetFocus
        
      End If
      
   End Select
End With

End Sub

Private Sub Grd_Ingreso_KeyPress(KeyAscii As Integer)

With Grd_Ingreso

   If (Trim(.TextMatrix(.Row, 0)) <> "" And .Col = 0) Or (Trim(.TextMatrix(.Row, 2)) <> "" And .Col = 2) Then
       KeyAscii = 0
       Exit Sub
   End If
   
   If .Col = 2 Then
      .EditMaxLength = 40
   End If
    

    
 
         
  
End With



End Sub

Private Sub Tlb_Botones_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index
   Case 1
   
      Cmb_Area.Enabled = True
      Cmb_entidad.Enabled = True
      Grd_Ingreso.Enabled = False
      Tlb_Botones.Buttons(2).Enabled = False
      Tlb_Botones.Buttons(3).Enabled = False
      Tlb_Botones.Buttons(4).Enabled = True
      
      Call FUNC_LIMPIAR_EJECUTIVO
      
   Case 2
     
       If FUNC_VALIDA_DATOS Then
       
          Call FUNC_GRABAR_EJECUTIVO
          Call Tlb_Botones_ButtonClick(Tlb_Botones.Buttons(1))
          Cmb_Area.SetFocus
       Else
       
          MsgBox "Hay registros en Blanco", vbOKOnly + vbInformation
         Grd_Ingreso.SetFocus
          
       End If
   Case 3
   
      If MsgBox("¿ Seguro de Eliminar Todos los Ejecutivos del Area " & left(Cmb_Area.Text, 30) & "?", vbYesNo + vbInformation) = vbYes Then
                
         Call FUNC_ELIMINAR_EJECUTIVO
      End If
     
   Case 4
   
     If Cmb_Area.ListIndex > -1 Then
      Call FUNC_TRAER_EJECUTIVO
     End If
     
   Case 5
      Unload Me
      
End Select
End Sub

Private Function FUNC_VALIDA_BLANCOS() As Boolean

With Grd_Ingreso
   
      For nIndice = 1 To .Rows - 1
      
         If (Trim(.TextMatrix(nIndice, 0)) = "" Or Trim(.TextMatrix(nIndice, 1)) = "" _
         Or Trim(.TextMatrix(nIndice, 2)) = "" Or Trim(.TextMatrix(nIndice, 3)) = "") _
         And .RowHidden(nIndice) = False Then
         
            FUNC_VALIDA_BLANCOS = False
            Exit Function
            
         End If
         
      Next nIndice
      
      FUNC_VALIDA_BLANCOS = True
      
End With

End Function
Private Function FUNC_VALIDAR_CODIGO() As Boolean

With Grd_Ingreso

 nCodigo = Val(.TextMatrix(.Row, 2))
 nRut = Val(.TextMatrix(.Row, 0))
 
 For nIndice = 1 To .Rows - 1
 
   If nCodigo = Val(.TextMatrix(nIndice, 2)) And nRut = Val(.TextMatrix(nIndice, 0)) And nIndice <> .Row And .RowHidden(nIndice) = False Then
      
      FUNC_VALIDAR_CODIGO = False
      Exit Function
      
   End If
   
 Next nIndice
 
 FUNC_VALIDAR_CODIGO = True

End With

End Function
Private Function FUNC_VALIDAR_UNA_FILA() As Boolean

FUNC_VALIDAR_UNA_FILA = False

nCodigo = 1
nIndice = 0

For nIndice = 1 To Grd_Ingreso.Rows - 1
   If Grd_Ingreso.RowHidden(nIndice) = True Then
         nCodigo = nCodigo + 1
   End If
Next nIndice

If nCodigo = nIndice Then

   FUNC_VALIDAR_UNA_FILA = True
End If

End Function
