VERSION 5.00
Object = "{1C0489F8-9EFD-423D-887A-315387F18C8F}#1.0#0"; "vsflex8l.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form FRM_MAN_TIPO_FECHA 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Mantención de Tipo de Fecha"
   ClientHeight    =   3690
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   5730
   Icon            =   "FRM_MAN_TIPO_FECHA.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   3690
   ScaleWidth      =   5730
   ShowInTaskbar   =   0   'False
   Begin VSFlex8LCtl.VSFlexGrid Grd_Ingreso 
      Height          =   2595
      Left            =   30
      TabIndex        =   1
      Top             =   510
      Width           =   5685
      _cx             =   10028
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
      Cols            =   2
      FixedRows       =   1
      FixedCols       =   0
      RowHeightMin    =   0
      RowHeightMax    =   0
      ColWidthMin     =   0
      ColWidthMax     =   0
      ExtendLastCol   =   0   'False
      FormatString    =   $"FRM_MAN_TIPO_FECHA.frx":2EFA
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
   Begin MSComctlLib.Toolbar Tlb_Botones 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   5730
      _ExtentX        =   10107
      _ExtentY        =   794
      ButtonWidth     =   820
      ButtonHeight    =   794
      Style           =   1
      ImageList       =   "Img_opciones"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      Begin MSComctlLib.ImageList Img_opciones 
         Left            =   4470
         Top             =   -30
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
               Picture         =   "FRM_MAN_TIPO_FECHA.frx":2F6B
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_TIPO_FECHA.frx":33D2
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_TIPO_FECHA.frx":38C8
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_TIPO_FECHA.frx":3D5B
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_TIPO_FECHA.frx":4243
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_TIPO_FECHA.frx":4756
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_TIPO_FECHA.frx":4C29
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_TIPO_FECHA.frx":50EF
               Key             =   ""
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_TIPO_FECHA.frx":55E6
               Key             =   ""
            EndProperty
            BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_TIPO_FECHA.frx":59DF
               Key             =   ""
            EndProperty
            BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_TIPO_FECHA.frx":5DD5
               Key             =   ""
            EndProperty
            BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_TIPO_FECHA.frx":6312
               Key             =   ""
            EndProperty
            BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_TIPO_FECHA.frx":67D3
               Key             =   ""
            EndProperty
            BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_TIPO_FECHA.frx":6C89
               Key             =   ""
            EndProperty
            BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_TIPO_FECHA.frx":70CD
               Key             =   ""
            EndProperty
            BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_TIPO_FECHA.frx":750F
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin MSComctlLib.Toolbar Toolbar2 
      Height          =   450
      Left            =   0
      TabIndex        =   2
      Top             =   3240
      Width           =   5715
      _ExtentX        =   10081
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
Attribute VB_Name = "FRM_MAN_TIPO_FECHA"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'  Autor          : Pamela Farías
'  Descripción    : Mantención de Tipo de Fecha
'  Fecha Creación : 03/12/2002
'  Fecha Modificación   : DD/MM/YYYY
'  Modificado Por       : Nombre de la persona que modifica la forma
'  Cambios Realizados   : Explicación de la modificación

Dim nIndice As Integer
Dim nCodigo As String
Dim nOpcion As Integer
Private Function FUNC_VALIDA_BLANCOS() As Boolean

With Grd_Ingreso
   
      For nIndice = 1 To .Rows - 1
      
         If Trim(.TextMatrix(nIndice, 0)) = "" Or Trim(.TextMatrix(nIndice, 1)) = "" Then
         
            FUNC_VALIDA_BLANCOS = False
            Exit Function
            
         End If
         
      Next nIndice
      
      FUNC_VALIDA_BLANCOS = True
      
End With

End Function

Private Function FUNC_GRABAR_TIPO_FECHA()
Dim sMensaje As String

With Grd_Ingreso

.Redraw = flexRDNone
.Col = 0
.Row = 0


If Not BAC_SQL_EXECUTE("BEGIN TRANSACTION") Then GoTo Errores

   For nIndice = 1 To .Rows - 1
   
     If .RowHidden(nIndice) = True Then
     
            Envia = Array()
            AddParam Envia, Trim(.TextMatrix(nIndice, 0))
         
            If Not BAC_SQL_EXECUTE("SP_DEL_TIPO_FECHA", Envia) Then GoTo Errores
               
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
         AddParam Envia, .TextMatrix(nIndice, 1)
      
         If Not BAC_SQL_EXECUTE("SP_ACT_TIPO_FECHA", Envia) Then GoTo Errores
         
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
      MsgBox "Los siguientes códigos no fueron eliminados por estar relacionados " & sMensaje, vbInformation, TITSISTEMA
   End If
   
   If Not BAC_SQL_EXECUTE("COMMIT TRANSACTION") Then GoTo Errores

   MsgBox "Información Grabada Correctamente.", vbOKOnly + vbInformation, TITSISTEMA
   
   Call FUNC_TRAER_TIPO_FECHA
   
   .Redraw = flexRDDirect
   
End With

Exit Function

Errores:

If Not BAC_SQL_EXECUTE("ROLLBACK TRANSACTION") Then
   MsgBox "Error al Reversar la Acción", vbOKOnly + vbCritical, TITSISTEMA
   Exit Function
End If

MsgBox "Información No fue Grabada.", vbOKOnly + vbCritical, TITSISTEMA

End Function

Private Function FUNC_TRAER_TIPO_FECHA()

With Grd_Ingreso

      If Not BAC_SQL_EXECUTE("SP_CON_TIPO_FECHA") Then
      
         MsgBox "No fue posible leer información", vbOKOnly + vbCritical, TITSISTEMA
         Exit Function
         
      Else
      
         .Rows = 1
         
         Do While BAC_SQL_FETCH(Datos())
         
             .Rows = .Rows + 1
             nIndice = .Rows - 1
            .TextMatrix(nIndice, 0) = Datos(1)
            .TextMatrix(nIndice, 1) = Datos(2)
         
         Loop
         
     End If
   
   
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


Private Sub Form_Activate()
   PROC_CARGA_AYUDA Me, " "
   Grd_Ingreso.Col = 0
   Grd_Ingreso.Row = 1
   Grd_Ingreso.SetFocus
   Opt = "Mnt_Tipo_Fecha"
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)



   nOpcion = 0
   
   If KeyCode = vbKeyF2 Then
      KeyCode = 0
   End If

   If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) Then
     
        Select Case KeyCode

         
            Case vbKeyGrabar:
                              nOpcion = 1
   
            Case vbKeySalir:
                              nOpcion = 2
                      
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
Call FUNC_TRAER_TIPO_FECHA
Me.Icon = BAC_Parametros.Icon
Me.top = 0
Me.left = 0
End Sub


Private Sub Grd_Ingreso_AfterEdit(ByVal Row As Long, ByVal Col As Long)

With Grd_Ingreso

   If Col = 0 Then
      
      If Not FUNC_VALIDAR_CODIGO Then
      
         MsgBox "Código ya existe", vbOKOnly + vbInformation, TITSISTEMA
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
      
   End If
   
End With

If Col = 1 Then
   Grd_Ingreso.Col = 0
   Grd_Ingreso.Sort = flexSortNumericAscending
   Grd_Ingreso.Col = 1
End If

End Sub

Private Sub Grd_Ingreso_BeforeEdit(ByVal Row As Long, ByVal Col As Long, Cancel As Boolean)
         If Trim(Grd_Ingreso.TextMatrix(Row, 0)) <> "" And Col = 0 Then
            Cancel = True
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
         MsgBox "Hay registros en Blanco", vbOKOnly + vbInformation, TITSISTEMA
         .SetFocus
       End If

   Case vbKeyDelete
   
      If .Row <> 0 Then
      
        If Trim(.TextMatrix(.Row, 0)) = "" And Trim(.TextMatrix(.Row, 1)) = "" Then
          .RemoveItem (.Row)
        Else
        
                   
               Envia = Array()
               AddParam Envia, Trim(.TextMatrix(.Row, 0))
               AddParam Envia, "S"
         
               If Not BAC_SQL_EXECUTE("SP_DEL_TIPO_FECHA", Envia) Then Exit Sub
               
               Do While BAC_SQL_FETCH(Datos())
               
                  If Datos(1) = "NO" Then
                     MsgBox Datos(2), vbOKOnly + vbCritical, TITSISTEMA
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
      .EditMaxLength = 30
  
   End If
        
         
  
End With



End Sub

Private Sub Grd_Ingreso_KeyPressEdit(ByVal Row As Long, ByVal Col As Long, KeyAscii As Integer)

KeyAscii = Caracter(KeyAscii)
KeyAscii = Asc(UCase(Chr(KeyAscii)))



If Col = 1 And Trim(Grd_Ingreso.TextMatrix(Row, 0)) = "" Then

   KeyAscii = 0
   MsgBox "Debe Ingresar Código", vbOKOnly + vbInformation, TITSISTEMA
   Grd_Ingreso.Col = 0
   Grd_Ingreso.SetFocus
   
End If




End Sub


Private Sub Tlb_Botones_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index
   Case 1
   
      
         Call FUNC_GRABAR_TIPO_FECHA
         Grd_Ingreso.SetFocus
         
   Case 2
      Unload Me
End Select
End Sub


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
      
        If Trim(.TextMatrix(.Row, 0)) = "" And Trim(.TextMatrix(.Row, 1)) = "" Then
          .RemoveItem (.Row)
        Else
        
                   
               Envia = Array()
               AddParam Envia, Trim(.TextMatrix(.Row, 0))
               AddParam Envia, "S"
         
               If Not BAC_SQL_EXECUTE("SP_DEL_TIPO_FECHA", Envia) Then Exit Sub
               
               Do While BAC_SQL_FETCH(Datos())
               
                  If Datos(1) = "NO" Then
                     MsgBox Datos(2), vbOKOnly + vbCritical, TITSISTEMA
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
