VERSION 5.00
Object = "{1C0489F8-9EFD-423D-887A-315387F18C8F}#1.0#0"; "vsflex8l.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Begin VB.Form FRM_MAN_TIPO_OPERACION_SPOT 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Mantención de Tipo de Operación Spot"
   ClientHeight    =   3180
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   11445
   Icon            =   "FRM_MAN_TIPO_OPERACION_SPOT.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   3180
   ScaleWidth      =   11445
   ShowInTaskbar   =   0   'False
   Begin VSFlex8LCtl.VSFlexGrid Grd_Ingreso 
      Height          =   2595
      Left            =   60
      TabIndex        =   1
      Top             =   525
      Width           =   11340
      _cx             =   20002
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
      Cols            =   7
      FixedRows       =   1
      FixedCols       =   0
      RowHeightMin    =   0
      RowHeightMax    =   0
      ColWidthMin     =   0
      ColWidthMax     =   0
      ExtendLastCol   =   0   'False
      FormatString    =   $"FRM_MAN_TIPO_OPERACION_SPOT.frx":000C
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
      Height          =   480
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   11445
      _ExtentX        =   20188
      _ExtentY        =   847
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "Ilst_Imagenes"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.Visible         =   0   'False
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList Ilst_Imagenes 
         Left            =   8040
         Top             =   30
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   24
         ImageHeight     =   24
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   3
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_TIPO_OPERACION_SPOT.frx":00B5
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_TIPO_OPERACION_SPOT.frx":0F8F
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_TIPO_OPERACION_SPOT.frx":1E69
               Key             =   ""
            EndProperty
         EndProperty
      End
      Begin MSComctlLib.ImageList imgIconos 
         Left            =   6780
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
               Picture         =   "FRM_MAN_TIPO_OPERACION_SPOT.frx":2183
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_TIPO_OPERACION_SPOT.frx":21E1
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_TIPO_OPERACION_SPOT.frx":223F
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_TIPO_OPERACION_SPOT.frx":229D
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_TIPO_OPERACION_SPOT.frx":22FB
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
End
Attribute VB_Name = "FRM_MAN_TIPO_OPERACION_SPOT"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'  Autor          : Rodrigo Olivos
'  Descripción    : Mantención de Tipo de Operaciones Spot
'  Fecha Creación : 07/03/2005
'  Fecha Modificación   : DD/MM/YYYY
'  Modificado Por       : Nombre de la persona que modifica la forma
'  Cambios Realizados   : Explicación de la modificación

Option Explicit

'Dim nIndice As Integer
'Dim nCodigo As Long
'Dim nOpcion As Integer

Dim gsBac_DESKManager As String

Const Codigo_ = 0
Const Glosa_ = 1
Const Afecta_Posicion_Contable_ = 2
Const Afecta_Descalce_Tc_ = 3
Const Codigo_Producto_ = 4
Const Afecta_Contabiliza_ = 5
Const Afecta_CodComercio_ = 6

Const btnLimpiar = 1
Const btnGrabar = 2
Const btnSalir = 3

Private Function FUNC_VALIDA_BLANCOS() As Boolean

Dim nIndice

With Grd_Ingreso
   
      For nIndice = 1 To .Rows - 1
      
         If Trim(.TextMatrix(nIndice, Codigo_)) = "" Or _
            Trim(.TextMatrix(nIndice, Glosa_)) = "" Or _
            Trim(.TextMatrix(nIndice, Afecta_Posicion_Contable_)) = "" Or _
            Trim(.TextMatrix(nIndice, Afecta_Descalce_Tc_)) = "" Or _
            Trim(.TextMatrix(nIndice, Codigo_Producto_)) = "" And _
            Trim(.TextMatrix(nIndice, Afecta_Contabiliza_)) = "" And _
            Trim(.TextMatrix(nIndice, Afecta_CodComercio_)) = "" And _
            .RowHidden(nIndice) = False Then
         
            FUNC_VALIDA_BLANCOS = False
            Exit Function
            
         End If
         
      Next nIndice
      
      FUNC_VALIDA_BLANCOS = True
      
End With

End Function

Private Function FUNC_GRABAR_TIPO_OPERACION_SPOT()

Dim nIndice             As Integer
Dim sMensaje            As String
Dim sMensajeDeskManager As String
Dim DESKManager         As Object

FUNC_GRABAR_TIPO_OPERACION_SPOT = False
   

Set DESKManager = CreateObject("DLL_DESKManager.DESKManager")

With Grd_Ingreso

If Not FUNC_VALIDA_BLANCOS() Then
    MsgBox "Hay registros en Blanco", vbOKOnly + vbInformation
    .SetFocus
    Exit Function
End If

'.Redraw = flexRDNone
.Col = 0
.Row = 0

sMensaje = ""

                
If Not BAC_SQL_EXECUTE("BEGIN TRANSACTION") Then GoTo Errores

   For nIndice = 1 To .Rows - 1
   
     If .RowHidden(nIndice) = True Then
     
         Envia = Array()
         AddParam Envia, Val(.TextMatrix(nIndice, Codigo_))
         
         If Not BAC_SQL_EXECUTE("SP_DEL_TIPO_OPERACION_SPOT", Envia) Then GoTo Errores
               
         Do While BAC_SQL_FETCH(Datos())
            
            If Datos(1) = "NO" Then
                sMensaje = sMensaje & " " & Val(.TextMatrix(nIndice, 0)) & ","
            Else
               If Datos(1) = "SI" Then
                  Call LogAuditoria("03", Opt, Me.Caption, "", "Código: " & Val(.TextMatrix(nIndice, 0)))
               End If
            End If
         Loop
         
         If gsBac_DESKManager = "S" And sMensaje = "" Then
            If Not DESKManager.FUNC_DEL_TIPO_OPERACION_SPOT(Val(.TextMatrix(nIndice, Codigo_))) Then
                   sMensajeDeskManager = sMensajeDeskManager & " " & Val(.TextMatrix(nIndice, 0)) & ","
            End If
         End If
         
         
     End If
               
   Next nIndice

If sMensaje <> "" Then

   MsgBox "Datos No Grabados " & Chr(13) & "Los siguientes códigos no se pueden eliminar por estar relacionados " & sMensaje, vbInformation
   
   If Not BAC_SQL_EXECUTE("ROLLBACK TRANSACTION") Then
      MsgBox "Error al Reversar la Acción", vbOKOnly + vbCritical
      Set DESKManager = Nothing
      Exit Function
   End If

   Exit Function
   
End If

If sMensajeDeskManager <> "" Then

   MsgBox "Datos No Grabados " & Chr(13) & "Los siguientes códigos no se pueden eliminar en DeskManager por estar relacionados " & sMensajeDeskManager, vbInformation
   
   If Not BAC_SQL_EXECUTE("ROLLBACK TRANSACTION") Then
      MsgBox "Error al Reversar la Acción", vbOKOnly + vbCritical
      Set DESKManager = Nothing
      Exit Function
   End If

   Exit Function
   
End If


For nIndice = 1 To .Rows - 1
    
    If .RowHidden(nIndice) = False And Trim(.TextMatrix(nIndice, 0)) <> "" Then
    
         Envia = Array()
         AddParam Envia, Val(.TextMatrix(nIndice, Codigo_))
         AddParam Envia, .TextMatrix(nIndice, Glosa_)
         AddParam Envia, .TextMatrix(nIndice, Afecta_Posicion_Contable_)
         AddParam Envia, .TextMatrix(nIndice, Afecta_Descalce_Tc_)
         AddParam Envia, .TextMatrix(nIndice, Codigo_Producto_)
         AddParam Envia, .TextMatrix(nIndice, Afecta_Contabiliza_)
         AddParam Envia, .TextMatrix(nIndice, Afecta_CodComercio_)

         If Not BAC_SQL_EXECUTE("SP_ACT_TIPO_OPERACION_SPOT", Envia) Then GoTo Errores
         
          Do While BAC_SQL_FETCH(Datos())
               
               If Datos(1) = "SI" Then 'Ingreso
               
                  Call LogAuditoria("01", Opt, Me.Caption, "", "Código: " & Val(.TextMatrix(nIndice, 0)))
                  
               ElseIf Datos(1) = "MOD" Then 'Modificación
               
                  Call LogAuditoria("02", Opt, Me.Caption, "", "Código: " & Val(.TextMatrix(nIndice, 0)))
               End If
          Loop
     
          If gsBac_DESKManager = "S" Then
            If Not DESKManager.FUNC_ACT_TIPO_OPERACION_SPOT(Val(.TextMatrix(nIndice, Codigo_)), _
                                                                .TextMatrix(nIndice, Glosa_), _
                                                                .TextMatrix(nIndice, Codigo_Producto_)) Then
                   sMensajeDeskManager = sMensajeDeskManager & " " & Val(.TextMatrix(nIndice, 0)) & ","
            End If
         End If

    End If
    
   Next nIndice
   
   If sMensajeDeskManager <> "" Then
   
      MsgBox "Datos No Grabados " & Chr(13) & "Los siguientes códigos no se puedieron grabar en DeskManager por estar relacionados " & sMensajeDeskManager, vbInformation
      
      If Not BAC_SQL_EXECUTE("ROLLBACK TRANSACTION") Then
         MsgBox "Error al Reversar la Acción", vbOKOnly + vbCritical
         Set DESKManager = Nothing
         Exit Function
      End If
   
      Exit Function
      
   End If
   
   
   If Not BAC_SQL_EXECUTE("COMMIT TRANSACTION") Then GoTo Errores
      
      
   MsgBox "Información Grabada Correctamente.", vbOKOnly + vbInformation
      
   Call FUNC_TRAER_TIPO_OPERACION_SPOT
      
   .Redraw = flexRDDirect
   
End With

FUNC_GRABAR_TIPO_OPERACION_SPOT = True


Exit Function

Errores:

If Not BAC_SQL_EXECUTE("ROLLBACK TRANSACTION") Then
   MsgBox "Error al Reversar la Acción", vbOKOnly + vbCritical
   Set DESKManager = Nothing
   Exit Function
End If

Set DESKManager = Nothing
MsgBox "Información No fue Grabada.", vbOKOnly + vbCritical


End Function

Private Function FUNC_TRAER_TIPO_OPERACION_SPOT()

Dim nIndice As Integer

With Grd_Ingreso

      If Not BAC_SQL_EXECUTE("SP_CON_TIPO_OPERACION_SPOT") Then
      
         MsgBox "No fue posible leer información", vbOKOnly + vbCritical
         Exit Function
         
      Else
      
         .Rows = 1
         
         Do While BAC_SQL_FETCH(Datos())
         
             .Rows = .Rows + 1
             nIndice = .Rows - 1

            .TextMatrix(nIndice, Codigo_) = Datos(1)
            .TextMatrix(nIndice, Glosa_) = Datos(2)
            .TextMatrix(nIndice, Afecta_Posicion_Contable_) = Datos(3)
            .TextMatrix(nIndice, Afecta_Descalce_Tc_) = Datos(4)
            .TextMatrix(nIndice, Codigo_Producto_) = Datos(5)
            .TextMatrix(nIndice, Afecta_Contabiliza_) = Datos(6)
            .TextMatrix(nIndice, Afecta_CodComercio_) = Datos(7)
         
         Loop
         
     End If
   
   
End With
End Function

Private Function FUNC_SETEA_GRILLA()

    With Grd_Ingreso
    
        .ColComboList(Afecta_Posicion_Contable_) = "#S;SI|#N;NO"
        .ColComboList(Afecta_Descalce_Tc_) = "#S;SI|#N;NO"
        .ColComboList(Afecta_Contabiliza_) = "#S;SI|#N;NO|#V;VARIABLE"
        .ColComboList(Afecta_CodComercio_) = "#U;UNICO|#V;VARIABLE"
    
        Envia = Array()
        AddParam Envia, "BCC"
    
        If BAC_SQL_EXECUTE("Sp_Productos_X_Sistema", Envia) Then
    
            Do While BAC_SQL_FETCH(Datos())
    
               .ColComboList(Codigo_Producto_) = Grd_Ingreso.ColComboList(Codigo_Producto_) & "#" & Datos(1) & ";" & Datos(2) & "|"
    
            Loop
        End If
       
    End With

End Function

Private Function FUNC_VALIDAR_CODIGO() As Boolean

Dim nIndice As Integer
Dim nCodigo As Integer

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
    Dim nCodigo As Integer
    Dim nIndice As Integer
    
    
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
    If Grd_Ingreso.Rows > 1 Then
       Grd_Ingreso.Row = 1
    End If
    Grd_Ingreso.SetFocus
    
    Opt = "Mnt_Tipo_Moneda"

End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)

Dim nOpcion As Integer

   nOpcion = 0
   
   If KeyCode = vbKeyF2 Then
      KeyCode = 0
   End If

   If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) Then
     
        Select Case KeyCode
        
            Case vbKeyLimpiar:
                              nOpcion = btnLimpiar
            
            Case vbKeyGrabar:
                              nOpcion = btnGrabar
   
            Case vbKeySalir:
                              nOpcion = btnSalir
                      
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
    
    
    gsBac_DESKManager = "S"
    
    Call FUNC_TRAER_TIPO_OPERACION_SPOT
    Call FUNC_SETEA_GRILLA

End Sub

Private Sub Grd_Ingreso_AfterEdit(ByVal Row As Long, ByVal Col As Long)

With Grd_Ingreso

   If Col = Codigo_ Then
      
      If Not FUNC_VALIDAR_CODIGO Then
      
         MsgBox "Código ya existe", vbOKOnly + vbInformation
         .TextMatrix(Row, Codigo_) = ""
         .Col = Codigo_
         .SetFocus
       Else
         .Col = Glosa_
         .SetFocus
       End If
      
   End If
   
   If Trim(.TextMatrix(Row, 0)) = "" Then
      
        .TextMatrix(Row, 1) = ""
      
   End If
   
End With

'If Col = 1 Then
'   Grd_Ingreso.Col = 0
'   Grd_Ingreso.Sort = flexSortNumericAscending
'   Grd_Ingreso.Col = 1
'End If

End Sub

Private Sub Grd_Ingreso_BeforeEdit(ByVal Row As Long, ByVal Col As Long, Cancel As Boolean)

    With Grd_Ingreso
    
        If Col = Codigo_ Then
           .EditMaxLength = 3
           If Trim(.TextMatrix(Row, Col)) <> "" Then
               Cancel = True
           End If
        End If
        
        If .Col = Glosa_ Then
            .EditMaxLength = 25
            Cancel = False
        End If
    
    End With

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
          
             If .TextMatrix(.Row, Codigo_) = "" Then
                 .RemoveItem .Row
             Else
                 .RowHidden(.Row) = True
             End If
                             
            If FUNC_VALIDAR_UNA_FILA Then
                .Rows = .Rows + 1
                .Row = .Rows - 1
                .Col = 0
            Else
                KeyCode = 40
            End If
                  
              .SetFocus
            
          End If
          
      
       End Select
    End With

End Sub


Private Sub Grd_Ingreso_KeyPressEdit(ByVal Row As Long, ByVal Col As Long, KeyAscii As Integer)

    KeyAscii = Caracter(KeyAscii)
    KeyAscii = Asc(UCase(Chr(KeyAscii)))

    
    If Col <> Codigo_ Then
    
       If Trim(Grd_Ingreso.TextMatrix(Row, Codigo_)) = "" Then
    
          KeyAscii = 0
          MsgBox "Debe Ingresar Código", vbOKOnly + vbInformation
          Grd_Ingreso.Col = Codigo_
          Grd_Ingreso.SetFocus
          
       End If
       
    End If


End Sub

Private Sub Tlb_Botones_ButtonClick(ByVal Button As MSComctlLib.Button)

    Select Case Button.Index
           Case btnLimpiar
                Call FUNC_TRAER_TIPO_OPERACION_SPOT
           
           Case btnGrabar
           
                Call FUNC_GRABAR_TIPO_OPERACION_SPOT
                     Grd_Ingreso.SetFocus
                     
           Case btnSalir
              Unload Me
    End Select

End Sub

