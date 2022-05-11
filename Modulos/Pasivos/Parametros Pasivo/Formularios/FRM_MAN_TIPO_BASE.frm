VERSION 5.00
Object = "{1C0489F8-9EFD-423D-887A-315387F18C8F}#1.0#0"; "vsflex8l.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form FRM_MAN_TIPO_BASE 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Mantención de Tipo de Base"
   ClientHeight    =   4425
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   6000
   Icon            =   "FRM_MAN_TIPO_BASE.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   4425
   ScaleWidth      =   6000
   ShowInTaskbar   =   0   'False
   Begin VB.Frame Frame1 
      Height          =   705
      Left            =   0
      TabIndex        =   2
      Top             =   480
      Width           =   5955
      Begin VB.ComboBox Cmb_Sistema 
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
         Left            =   1200
         Style           =   2  'Dropdown List
         TabIndex        =   4
         Top             =   240
         Width           =   2265
      End
      Begin VB.Label Lbl_Sistema 
         Caption         =   "Módulo"
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
         Left            =   210
         TabIndex        =   3
         Top             =   300
         Width           =   1395
      End
   End
   Begin MSComctlLib.Toolbar Tlb_Botones 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   6000
      _ExtentX        =   10583
      _ExtentY        =   794
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Style           =   1
      ImageList       =   "Img_opciones"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      Begin MSComctlLib.ImageList Img_opciones 
         Left            =   4860
         Top             =   -60
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   24
         ImageHeight     =   24
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   16
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_TIPO_BASE.frx":2EFA
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_TIPO_BASE.frx":3361
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_TIPO_BASE.frx":3857
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_TIPO_BASE.frx":3CEA
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_TIPO_BASE.frx":41D2
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_TIPO_BASE.frx":46E5
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_TIPO_BASE.frx":4BB8
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_TIPO_BASE.frx":507E
               Key             =   ""
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_TIPO_BASE.frx":5575
               Key             =   ""
            EndProperty
            BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_TIPO_BASE.frx":596E
               Key             =   ""
            EndProperty
            BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_TIPO_BASE.frx":5D64
               Key             =   ""
            EndProperty
            BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_TIPO_BASE.frx":62A1
               Key             =   ""
            EndProperty
            BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_TIPO_BASE.frx":6762
               Key             =   ""
            EndProperty
            BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_TIPO_BASE.frx":6C18
               Key             =   ""
            EndProperty
            BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_TIPO_BASE.frx":705C
               Key             =   ""
            EndProperty
            BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_TIPO_BASE.frx":749E
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VSFlex8LCtl.VSFlexGrid Grd_Ingreso 
      Height          =   2595
      Left            =   30
      TabIndex        =   1
      Top             =   1230
      Width           =   5955
      _cx             =   10504
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
      FormatString    =   $"FRM_MAN_TIPO_BASE.frx":7863
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
   Begin MSComctlLib.Toolbar Toolbar2 
      Height          =   450
      Left            =   0
      TabIndex        =   5
      Top             =   3960
      Width           =   5955
      _ExtentX        =   10504
      _ExtentY        =   794
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Style           =   1
      ImageList       =   "Img_opciones"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Limpiar"
            Object.ToolTipText     =   "Agregar Fila"
            ImageIndex      =   15
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Quitar Fila"
            ImageIndex      =   16
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "FRM_MAN_TIPO_BASE"
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
Dim nOpcion As Integer
Private Function FUNC_LLENAR_COMBO()

      If BAC_SQL_EXECUTE("SP_CON_SISTEMA") Then
        
        Do While BAC_SQL_FETCH(Datos())
       
               Cmb_Sistema.AddItem (Datos(2) & Space(150) & Datos(1))
        Loop
      End If
      
      Cmb_Sistema.ListIndex = 0
End Function


Private Sub Form_Activate()
   PROC_CARGA_AYUDA Me, " "
   Opt = "Mnt_Tipo_Base"
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

Private Function FUNC_LIMPIAR_TIPO_BASE()

With Grd_Ingreso

   .Rows = 2
   .TextMatrix(1, 0) = ""
   .TextMatrix(1, 1) = ""
   .TextMatrix(1, 2) = ""
   
End With

End Function

Private Function FUNC_GRABAR_TIPO_BASE()


With Grd_Ingreso

.Redraw = flexRDNone
.Col = 0
.Row = 0

If Not BAC_SQL_EXECUTE("BEGIN TRANSACTION") Then GoTo Errores

   For nIndice = 1 To .Rows - 1
   
     If .RowHidden(nIndice) = True Then
     
                   
            Envia = Array()
            AddParam Envia, Val(.TextMatrix(nIndice, 0))
            AddParam Envia, right(Trim(Cmb_Sistema.Text), 3)
         
            If Not BAC_SQL_EXECUTE("SP_DEL_TIPO_BASE", Envia) Then GoTo Errores
               
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
         AddParam Envia, Val(.TextMatrix(nIndice, 0))
         AddParam Envia, .TextMatrix(nIndice, 1)
         AddParam Envia, Val(.TextMatrix(nIndice, 2))
         AddParam Envia, right(Trim(Cmb_Sistema.Text), 3)
      
         If Not BAC_SQL_EXECUTE("SP_ACT_TIPO_BASE", Envia) Then GoTo Errores
         
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
      MsgBox "Los siguientes códigos no fueron eliminados por estar relacionados " & Trim(sMensaje), vbInformation
   End If
   
   If Not BAC_SQL_EXECUTE("COMMIT TRANSACTION") Then GoTo Errores

   MsgBox "Información Grabada Correctamente.", vbOKOnly + vbInformation
   
   Call FUNC_TRAER_TIPO_BASE
   
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


Private Function FUNC_ELIMINAR_TIPO_BASE()


With Grd_Ingreso

If Not BAC_SQL_EXECUTE("BEGIN TRANSACTION") Then GoTo Errores
      

   For nIndice = 1 To .Rows - 1
    
         Envia = Array()
         AddParam Envia, Val(.TextMatrix(nIndice, 0))
         AddParam Envia, right(Trim(Cmb_Sistema.Text), 3)
      
         If Not BAC_SQL_EXECUTE("SP_DEL_TIPO_BASE", Envia) Then GoTo Errores
         
           Do While BAC_SQL_FETCH(Datos())
               
                  If Datos(1) = "NO" Then
                     MsgBox Datos(2), vbOKOnly + vbInformation
                     GoTo Errores
                  End If
            Loop
     
   Next nIndice
   
   If Not BAC_SQL_EXECUTE("COMMIT TRANSACTION") Then GoTo Errores

   MsgBox "Información Eliminada Correctamente.", vbOKOnly + vbInformation
   Call FUNC_LIMPIAR_TIPO_BASE

   
End With

Exit Function

Errores:

If Not BAC_SQL_EXECUTE("ROLLBACK TRANSACTION") Then
   MsgBox "Error al Reversar la Acción", vbOKOnly + vbCritical
   Exit Function
End If

MsgBox "Información No fue Eliminada.", vbOKOnly + vbCritical

End Function



Private Function FUNC_TRAER_TIPO_BASE()

With Grd_Ingreso

      Envia = Array()
      AddParam Envia, right(Trim(Cmb_Sistema.Text), 3)
      
      If Not BAC_SQL_EXECUTE("SP_CON_TIPO_BASE", Envia) Then
      
         MsgBox "No fue posible leer información", vbOKOnly + vbCritical
         Exit Function
         
      Else
      
         .Rows = 1
         
         Do While BAC_SQL_FETCH(Datos())
         
             .Rows = .Rows + 1
             nIndice = .Rows - 1
            .TextMatrix(nIndice, 0) = Datos(1)
            .TextMatrix(nIndice, 1) = Datos(2)
            .TextMatrix(nIndice, 2) = Datos(3)
            
         Loop
        
     End If
    
    If .Rows = 1 Then
      Call FUNC_LIMPIAR_TIPO_BASE
    End If
    
   .Enabled = True
   Cmb_Sistema.Enabled = False
   Tlb_Botones.Buttons(2).Enabled = True
   Tlb_Botones.Buttons(3).Enabled = True
   Tlb_Botones.Buttons(4).Enabled = False
   Grd_Ingreso.Col = 0
   Grd_Ingreso.Row = 1
   
   If Grd_Ingreso.Enabled Then Grd_Ingreso.SetFocus
      
   
End With
End Function

Private Sub Grd_Ingreso_AfterEdit(ByVal Row As Long, ByVal Col As Long)

With Grd_Ingreso

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
   
   If Trim(.TextMatrix(Row, 0)) = "" Then
      
        .TextMatrix(Row, 1) = ""
        .TextMatrix(Row, 2) = ""
      
   End If
   
End With

If Col = 2 Then
   Grd_Ingreso.Col = 0
   Grd_Ingreso.Sort = flexSortNumericAscending
   Grd_Ingreso.Col = 2
End If

End Sub

Private Sub Grd_Ingreso_BeforeEdit(ByVal Row As Long, ByVal Col As Long, Cancel As Boolean)
         If Trim(Grd_Ingreso.TextMatrix(Row, 0)) <> "" And Col = 0 Then
            Cancel = True
          End If
End Sub

Private Sub Grd_Ingreso_KeyPressEdit(ByVal Row As Long, ByVal Col As Long, KeyAscii As Integer)

KeyAscii = Caracter(KeyAscii)
KeyAscii = Asc(UCase(Chr(KeyAscii)))



If (Col = 1 Or Col = 2) And Trim(Grd_Ingreso.TextMatrix(Row, 0)) = "" Then

   KeyAscii = 0
   MsgBox "Debe Ingresar Código", vbOKOnly + vbInformation
   Grd_Ingreso.Col = 0
   If Grd_Ingreso.Enabled Then Grd_Ingreso.SetFocus
   
End If


If Col = 1 And KeyAscii = 13 Then
      Grd_Ingreso.Col = 2
      If Grd_Ingreso.Enabled Then Grd_Ingreso.SetFocus
      
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
      
        If Trim(.TextMatrix(.Row, 0)) = "" And Trim(.TextMatrix(.Row, 1)) = "" And Trim(.TextMatrix(.Row, 2)) = "" Then
          .RemoveItem (.Row)
        Else
        
               Envia = Array()
               AddParam Envia, Val(.TextMatrix(Grd_Ingreso.Row, 0))
               AddParam Envia, right(Trim(Cmb_Sistema.Text), 3)
               AddParam Envia, "S"
         
               If Not BAC_SQL_EXECUTE("SP_DEL_TIPO_BASE", Envia) Then Exit Sub
               
               Do While BAC_SQL_FETCH(Datos())
               
                  If Datos(1) = "NO" Then
                     MsgBox Datos(2), vbOKOnly + vbInformation
                  Else
                     .RowHidden(.Row) = True
                  End If
               Loop
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

   If Trim(.TextMatrix(.Row, 0)) <> "" And .Col = 0 Then
       KeyAscii = 0
       Exit Sub
   End If
   
   If .Col = 1 Then
      .EditMaxLength = 40
   End If
        
 
         
  
End With



End Sub

Private Sub Tlb_Botones_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index
   Case 1
      Cmb_Sistema.ListIndex = -1
      Cmb_Sistema.Enabled = True
      Grd_Ingreso.Enabled = False
      Tlb_Botones.Buttons(2).Enabled = False
      Tlb_Botones.Buttons(3).Enabled = False
      Tlb_Botones.Buttons(4).Enabled = True
      
      Call FUNC_LIMPIAR_TIPO_BASE
      
   Case 2
   
     
         Call FUNC_GRABAR_TIPO_BASE
         Call Tlb_Botones_ButtonClick(Tlb_Botones.Buttons(1))
         
         If Grd_Ingreso.Enabled Then Grd_Ingreso.SetFocus
    
   Case 3
   
      If MsgBox("¿ Seguro de Eliminar Todos los Registros del Sistema " & Trim(left(Cmb_Sistema.Text, 30)) & " ?", vbYesNo + vbInformation) = vbYes Then
                
         Call FUNC_ELIMINAR_TIPO_BASE
            
         If FUNC_VALIDAR_UNA_FILA Then
            Grd_Ingreso.Rows = Grd_Ingreso.Rows + 1
            Grd_Ingreso.Row = Grd_Ingreso.Rows - 1
            Grd_Ingreso.Col = 0
         Else
            KeyCode = 40
         End If
         
      End If
      
         
      If Grd_Ingreso.Enabled Then Grd_Ingreso.SetFocus
   Case 4
   
     If Cmb_Sistema.ListIndex > -1 Then
      Call FUNC_TRAER_TIPO_BASE
     End If
     
   Case 5
      Unload Me
      
End Select
End Sub

Private Function FUNC_VALIDA_BLANCOS() As Boolean

With Grd_Ingreso
   
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

With Grd_Ingreso

 nCodigo = Val(.TextMatrix(.Row, 0))
 
 For nIndice = 1 To .Rows - 1
 
   If nCodigo = Val(.TextMatrix(nIndice, 0)) And nIndice <> .Row And .RowHidden(nIndice) = False Then
      
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

Private Sub Toolbar2_ButtonClick(ByVal Button As MSComctlLib.Button)
With Grd_Ingreso

Select Case Button.Index
   Case 1
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
   Case 2
      If .Row <> 0 Then
      
        If Trim(.TextMatrix(.Row, 0)) = "" And Trim(.TextMatrix(.Row, 1)) = "" And Trim(.TextMatrix(.Row, 2)) = "" Then
          .RemoveItem (.Row)
        Else
        
               Envia = Array()
               AddParam Envia, Val(.TextMatrix(Grd_Ingreso.Row, 0))
               AddParam Envia, right(Trim(Cmb_Sistema.Text), 3)
               AddParam Envia, "S"
         
               If Not BAC_SQL_EXECUTE("SP_DEL_TIPO_BASE", Envia) Then Exit Sub
               
               Do While BAC_SQL_FETCH(Datos())
               
                  If Datos(1) = "NO" Then
                     MsgBox Datos(2), vbOKOnly + vbInformation
                  Else
                     .RowHidden(.Row) = True
                  End If
               Loop
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
