VERSION 5.00
Object = "{1C0489F8-9EFD-423D-887A-315387F18C8F}#1.0#0"; "vsflex8l.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Begin VB.Form FRM_PLAZO 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Plazo de Curvas"
   ClientHeight    =   3195
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4830
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
   MinButton       =   0   'False
   Moveable        =   0   'False
   ScaleHeight     =   3195
   ScaleWidth      =   4830
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Begin MSComctlLib.Toolbar Tlb_botones 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   1
      Top             =   0
      Width           =   4830
      _ExtentX        =   8520
      _ExtentY        =   847
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin VB.TextBox LBL_GRUPO 
         BackColor       =   &H8000000F&
         BorderStyle     =   0  'None
         ForeColor       =   &H00000080&
         Height          =   345
         Left            =   1740
         TabIndex        =   2
         TabStop         =   0   'False
         Top             =   60
         Width           =   4575
      End
   End
   Begin VSFlex8LCtl.VSFlexGrid Grd_Plazos 
      Height          =   2640
      Left            =   45
      TabIndex        =   0
      Top             =   525
      Width           =   4755
      _cx             =   8387
      _cy             =   4657
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
      BackColor       =   -2147483633
      ForeColor       =   8388608
      BackColorFixed  =   8421376
      ForeColorFixed  =   16777215
      BackColorSel    =   -2147483635
      ForeColorSel    =   -2147483634
      BackColorBkg    =   -2147483636
      BackColorAlternate=   -2147483633
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
      Cols            =   4
      FixedRows       =   2
      FixedCols       =   0
      RowHeightMin    =   0
      RowHeightMax    =   0
      ColWidthMin     =   0
      ColWidthMax     =   0
      ExtendLastCol   =   0   'False
      FormatString    =   $"FRM_PLAZO.frx":0000
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
      Editable        =   1
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
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   510
      Top             =   1890
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
            Picture         =   "FRM_PLAZO.frx":0096
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_PLAZO.frx":0F70
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_PLAZO.frx":1E4A
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "FRM_PLAZO"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public nRut_cliente As Double
Public nCodigo_cliente As Double
Public nGrupo As String
Dim Datos()
Dim nIndice, nCodigo As Integer
Dim nTotal_SinRiesgo, nTotal_ConRiesgo, nTotal_Linea As Double
Public cTipo As String
Dim cTipo_Campo As String
Private Function FUNC_BUSCAR_PLAZO()

If FRM_MAN_RELACION_CURVA.Grd_Plazo_Grabar.Rows > 2 Then

  With Grd_Plazos
      
      For nIndice = 2 To FRM_MAN_RELACION_CURVA.Grd_Plazo_Grabar.Rows - 1
      
        
        
      
            If FRM_MAN_RELACION_CURVA.Grd_Plazo_Grabar.TextMatrix(nIndice, 3) = nGrupo And FRM_MAN_RELACION_CURVA.Grd_Plazo_Grabar.RowHidden(nIndice) = False Then
            
                .Rows = .Rows + 1
                .Row = .Rows - 1
                
                For nContador = 0 To FRM_MAN_RELACION_CURVA.Grd_Plazo_Grabar.Cols - 1
                     .TextMatrix(.Row, nContador) = FRM_MAN_RELACION_CURVA.Grd_Plazo_Grabar.TextMatrix(nIndice, nContador)
                Next nContador
            End If
            
        
        
      Next nIndice
  End With
End If

If Grd_Plazos.Rows < 3 Then
  Grd_Plazos.Rows = 3
  Call FUNC_LLENAR_BLANCOS(2)
End If

     
End Function

'******************JUANLIZAMA*****************
'Private Function FUNC_LEER_CURVA()
'
'Dim aCurva()  As CCurva
'Dim iContador As Integer
'
'Call ReadCurve(aCurva)
'
'With Me.Grd_Plazos
'
'    .ColComboList(2) = ""
'
'    For iContador = 1 To UBound(aCurva)
'        .ColComboList(2) = .ColComboList(2) & aCurva(iContador).nemotecnico & "|"
'    Next iContador
'
'End With
'
'End Function
'*********************************************
Private Function FUNC_GRABAR()

With FRM_MAN_RELACION_CURVA.Grd_Plazo_Grabar

  
  
  For nIndice = 2 To .Rows - 1
    
    If .TextMatrix(nIndice, 3) = nGrupo Then
        .RowHidden(nIndice) = True
    End If
    
  Next nIndice
  
  
  For nIndice = 2 To Grd_Plazos.Rows - 1
  
   If Grd_Plazos.RowHidden(nIndice) = False And Trim(Grd_Plazos.TextMatrix(nIndice, 2)) <> 0 Then
  
     .Rows = .Rows + 1
     .Row = .Rows - 1
    
      For nContador = 0 To Grd_Plazos.Cols - 1
      
           .TextMatrix(.Row, nContador) = Grd_Plazos.TextMatrix(nIndice, nContador)
          
      Next nContador
      
   End If
   
  Next nIndice
  
   
End With
End Function

Private Function FUNC_LLENAR_BLANCOS(Fila As Integer)
  
  For nIndice = 0 To Grd_Plazos.Cols - 1
   Grd_Plazos.TextMatrix(Fila, nIndice) = Format(0, Formato_Numero)
  Next nIndice
  If Grd_Plazos.Rows > 3 Then
    Grd_Plazos.TextMatrix(Fila, 0) = CDbl(Replace(Grd_Plazos.TextMatrix(Fila - 1, 1), gsc_SeparadorMiles, "")) + 1
    Grd_Plazos.TextMatrix(Fila, 1) = CDbl(Replace(Grd_Plazos.TextMatrix(Fila, 0), gsc_SeparadorMiles, "")) + 1
  Else
    Grd_Plazos.TextMatrix(Fila, 0) = 0
    Grd_Plazos.TextMatrix(Fila, 1) = 1
  End If
  
  Grd_Plazos.TextMatrix(Fila, 3) = nGrupo
  
End Function


Private Function FUNC_VALIDAR_PLAZOS()

If Grd_Plazos.Col = 0 Then

  If CDbl(Replace(Grd_Plazos.TextMatrix(Grd_Plazos.Row, Grd_Plazos.Col), gsc_SeparadorMiles, "")) >= CDbl(Replace(Grd_Plazos.TextMatrix(Grd_Plazos.Row, 1), gsc_SeparadorMiles, "")) Then
    MsgBox cTipo_Campo & " desde Mayor igual al " & cTipo_Campo & " Hasta", vbInformation
    Grd_Plazos.TextMatrix(Grd_Plazos.Row, Grd_Plazos.Col) = CDbl(Replace(Grd_Plazos.TextMatrix(Grd_Plazos.Row, 1), gsc_SeparadorMiles, "")) - 1

    Exit Function
  End If
  If Grd_Plazos.Row <> 2 Then

        If CDbl(Replace(Grd_Plazos.TextMatrix(Grd_Plazos.Row, Grd_Plazos.Col), gsc_SeparadorMiles, "")) <= CDbl(Replace(Grd_Plazos.TextMatrix(Grd_Plazos.Row - 1, 1), gsc_SeparadorMiles, "")) Then
            MsgBox cTipo_Campo & " desde Menor o Igual al " & cTipo_Campo & " Hasta anterior", vbInformation
            If Row = 2 Then
                If CDbl(Replace(Grd_Plazos.TextMatrix(Grd_Plazos.Row, 1), GSC_SEPARADORDECIMAL, "")) = 0 Then
                   Grd_Plazos.TextMatrix(Grd_Plazos.Row, Grd_Plazos.Col) = 0
                Else
                   Grd_Plazos.TextMatrix(Grd_Plazos.Row, Grd_Plazos.Col) = CDbl(Replace(Grd_Plazos.TextMatrix(Grd_Plazos.Row, 1), GSC_SEPARADORDECIMAL, "")) - 1
                End If
            Else
                Grd_Plazos.TextMatrix(Grd_Plazos.Row, Grd_Plazos.Col) = CDbl(Replace(Grd_Plazos.TextMatrix(Grd_Plazos.Row - 1, 1), gsc_SeparadorMiles, "")) + 1
            End If
            Exit Function
        End If
  End If
 End If

 If Grd_Plazos.Col = 1 Then

    If CDbl(Replace(Grd_Plazos.TextMatrix(Grd_Plazos.Row, Grd_Plazos.Col), gsc_SeparadorMiles, "")) <= CDbl(Replace(Grd_Plazos.TextMatrix(Grd_Plazos.Row, 0), gsc_SeparadorMiles, "")) Then
        MsgBox cTipo_Campo & " Hasta Menor o Igual al " & cTipo_Campo & " Desde", vbInformation
        Grd_Plazos.TextMatrix(Grd_Plazos.Row, Grd_Plazos.Col) = CDbl(Replace(Grd_Plazos.TextMatrix(Grd_Plazos.Row, 0), gsc_SeparadorMiles, "")) + 1
        Exit Function
    End If


 End If
End Function

Private Sub Form_Activate()
 PROC_CARGA_AYUDA Me, " "
 Grd_Plazos.Col = 0
 Grd_Plazos.Row = 2
 Grd_Plazos.SetFocus
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
Dim opcion As Integer

If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) Then
opcion = 0
   Select Case KeyCode

         Case vbKeyLimpiar
               opcion = 1
         Case vbkeyAceptar
               opcion = 2
         
         Case vbKeySalir
               opcion = 3
   End Select

   If opcion <> 0 Then
         If Tlb_botones.Buttons(opcion).Enabled Then
            Call Tlb_Botones_ButtonClick(Tlb_botones.Buttons(opcion))
         End If
   End If

End If
End Sub

Private Sub Form_Load()
If cTipo = "P" Then
    Caption = "Rango por Plazos"
    Grd_Plazos.TextMatrix(0, 1) = "Plazo"
    Grd_Plazos.TextMatrix(0, 0) = "Plazo"
    cTipo_Campo = "Plazo"
    Grd_Plazos.ColFormat(0) = "#,###"
    Grd_Plazos.ColFormat(1) = "#,###"
    Grd_Plazos.ColEditMask(0) = "#,###"
    Grd_Plazos.ColEditMask(1) = "#,###"
Else
    Caption = "Rango por Tasas"
    Grd_Plazos.TextMatrix(0, 1) = "Tasa"
    Grd_Plazos.TextMatrix(0, 0) = "Tasa"
    Grd_Plazos.ColFormat(0) = "###.####"
    Grd_Plazos.ColFormat(1) = "###.####"
    Grd_Plazos.ColEditMask(0) = "###.####"
    Grd_Plazos.ColEditMask(1) = "###.####"
    cTipo_Campo = "Tasa"
End If
Call FUNC_BUSCAR_PLAZO
'*******JUANLIZAMA**********
'Call FUNC_LEER_CURVA
'***************************
Me.Icon = BAC_Parametros.Icon
Me.top = 1000
Me.left = 1000
End Sub


Private Sub Grd_Plazos_AfterEdit(ByVal Row As Long, ByVal Col As Long)

If Col <> 2 Then
  Grd_Plazos.TextMatrix(Grd_Plazos.Row, Grd_Plazos.Col) = Replace(Grd_Plazos.TextMatrix(Grd_Plazos.Row, Grd_Plazos.Col), " ", "")
End If

 Grd_Plazos.TextMatrix(Grd_Plazos.Row, Grd_Plazos.Col) = Trim(Grd_Plazos.TextMatrix(Grd_Plazos.Row, Grd_Plazos.Col))
 
 If Trim(Replace(Grd_Plazos.TextMatrix(Grd_Plazos.Row, Grd_Plazos.Col), gsc_SeparadorMiles, "")) = "" Then
   Grd_Plazos.TextMatrix(Grd_Plazos.Row, Grd_Plazos.Col) = 0
 End If
 
 Call FUNC_VALIDAR_PLAZOS
 
 Grd_Plazos.TextMatrix(Grd_Plazos.Row, Grd_Plazos.Col) = Trim(Grd_Plazos.Text)
 Grd_Plazos.TextMatrix(Grd_Plazos.Row, Grd_Plazos.Col) = Format(Replace(Grd_Plazos.TextMatrix(Grd_Plazos.Row, Grd_Plazos.Col), gsc_SeparadorMiles, ""), IIf(cTipo = "P", Formato_Numero, "###,##0.0000"))
 
 
 With Grd_Plazos
 
     
End With
End Sub

Private Sub Grd_Plazos_KeyDown(KeyCode As Integer, Shift As Integer)

With Grd_Plazos

 Select Case KeyCode
   Case vbKeyInsert
   
      If FUNC_VALIDA_BLANCOS Then
         .Rows = .Rows + 1
         .Row = .Rows - 1
         .TopRow = .Row
          Call FUNC_LLENAR_BLANCOS(.Row)
         .Col = 0
         .Refresh
       Else
         MsgBox "Hay registros en Blanco", vbOKOnly + vbInformation
         .SetFocus
       End If
    
   Case vbKeyDelete
   
      If .Row > 1 Then
      
          .RemoveItem (.Row)
        
        If FUNC_VALIDAR_UNA_FILA Then
        
            Grd_Plazos.Rows = Grd_Plazos.Rows + 1
            Grd_Plazos.Row = Grd_Plazos.Rows - 1
            Call FUNC_LLENAR_BLANCOS(Grd_Plazos.Row)
            Grd_Plazos.Col = 0
            
        Else
            KeyCode = 40
            
        End If
        
        .SetFocus
      End If
      
  
   End Select
End With
End Sub

Private Function FUNC_VALIDAR_UNA_FILA() As Boolean

FUNC_VALIDAR_UNA_FILA = False

nCodigo = 2
nIndice = 0

For nIndice = 1 To Grd_Plazos.Rows - 1
   If Grd_Plazos.RowHidden(nIndice) = True Then
         nCodigo = nCodigo + 1
   End If
Next nIndice

If nCodigo = nIndice Then

   FUNC_VALIDAR_UNA_FILA = True
End If

End Function
Private Function FUNC_VALIDA_BLANCOS() As Boolean

With Grd_Plazos
   
      For nIndice = 1 To .Rows - 1
      
         If Trim(.TextMatrix(nIndice, 0)) = "" Or Trim(.TextMatrix(nIndice, 1)) = "" Or Trim(.TextMatrix(nIndice, 2)) = 0 Then
         
            FUNC_VALIDA_BLANCOS = False
            Exit Function
            
         End If
         
      Next nIndice
      
      FUNC_VALIDA_BLANCOS = True
      
End With

End Function

Private Sub Grd_Plazos_KeyDownEdit(ByVal Row As Long, ByVal Col As Long, KeyCode As Integer, ByVal Shift As Integer)

'   If KeyCode = 13 Then
'     If (Grd_Plazos.Col + 1 = 5) Or (Left(FRM_LINEA_CREDITO.grd_Detalle_Linea.TextMatrix(FRM_LINEA_CREDITO.grd_Detalle_Linea.Row, 1), 1) = "S" And (Grd_Plazos.Col + 1 = 4)) Then
'          Grd_Plazos.Col = 0
'          Grd_Plazos.LeftCol = Grd_Plazos.Col
'     Else
'       If Left(FRM_LINEA_CREDITO.grd_Detalle_Linea.TextMatrix(FRM_LINEA_CREDITO.grd_Detalle_Linea.Row, 1), 1) = "N" And Col = 1 Then
'          Grd_Plazos.Col = Grd_Plazos.Col + 3
'       Else
'          Grd_Plazos.Col = Grd_Plazos.Col + 1
'       End If
'     End If
'   End If
End Sub

Private Sub Grd_Plazos_KeyPress(KeyAscii As Integer)

'If Chr(KeyAscii) = "-" Or Chr(KeyAscii) = "+" Then
'  KeyAscii = 0
'  Exit Sub
'End If
'
'If Grd_Plazos.Col = 0 Or Grd_Plazos.Col = 1 Then
'    Exit Sub
'End If
'If Grd_Plazos.Col = 2 Or Grd_Plazos.Col = 3 Or Grd_Plazos.Col = 4 Then
'    If Left(FRM_LINEA_CREDITO.grd_Detalle_Linea.TextMatrix(FRM_LINEA_CREDITO.grd_Detalle_Linea.Row, 1), 1) = "N" And Grd_Plazos.Col <> 4 Then
'        If Grd_Plazos.Col <> 2 Or Grd_Plazos.Col <> 3 Then
'            KeyAscii = 0
'        End If
'    ElseIf Left(FRM_LINEA_CREDITO.grd_Detalle_Linea.TextMatrix(FRM_LINEA_CREDITO.grd_Detalle_Linea.Row, 1), 1) = "S" And Grd_Plazos.Col = 4 Then
'            KeyAscii = 0
'    End If
'Else
'    KeyAscii = 0
'
'End If
End Sub

Private Sub Grd_Plazos_KeyPressEdit(ByVal Row As Long, ByVal Col As Long, KeyAscii As Integer)
If Chr(KeyAscii) = "-" Or Chr(KeyAscii) = "+" Then
  KeyAscii = 0
  Exit Sub
End If
End Sub

Private Sub Tlb_Botones_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index
Case 1
  Call FUNC_LIMPIAR
Case 2
  Call FUNC_GRABAR
  nGrupo = "OK"
  Unload Me
Case 3
  Unload Me
End Select

End Sub


Private Function FUNC_LIMPIAR()

   Grd_Plazos.Rows = 3
   Grd_Plazos.RemoveItem (2)
   Grd_Plazos.Rows = 3
   Call FUNC_LLENAR_BLANCOS(2)
End Function
