VERSION 5.00
Object = "{1C0489F8-9EFD-423D-887A-315387F18C8F}#1.0#0"; "vsflex8l.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "Mscomctl.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "threed32.ocx"
Begin VB.Form FRM_PLAZO_INFORME_CARTERA 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Plazo para Informe De Cartera (Plazo Residual)"
   ClientHeight    =   3765
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
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   Moveable        =   0   'False
   ScaleHeight     =   3765
   ScaleWidth      =   4830
   ShowInTaskbar   =   0   'False
   Begin VB.Frame Frame1 
      Height          =   3270
      Left            =   15
      TabIndex        =   2
      Top             =   495
      Width           =   4815
      Begin VSFlex8LCtl.VSFlexGrid Grd_Plazos 
         Height          =   2640
         Left            =   45
         TabIndex        =   3
         Top             =   585
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
         Rows            =   3
         Cols            =   3
         FixedRows       =   2
         FixedCols       =   0
         RowHeightMin    =   0
         RowHeightMax    =   0
         ColWidthMin     =   0
         ColWidthMax     =   0
         ExtendLastCol   =   0   'False
         FormatString    =   $"FRM_PLAZO_INFORME_CARTERA.frx":0000
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
      Begin Threed.SSOption SSOption1 
         Height          =   165
         Index           =   0
         Left            =   2175
         TabIndex        =   4
         Top             =   225
         Width           =   675
         _Version        =   65536
         _ExtentX        =   1191
         _ExtentY        =   291
         _StockProps     =   78
         Caption         =   "Días"
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin Threed.SSOption SSOption1 
         Height          =   165
         Index           =   1
         Left            =   2940
         TabIndex        =   5
         Top             =   240
         Width           =   870
         _Version        =   65536
         _ExtentX        =   1535
         _ExtentY        =   291
         _StockProps     =   78
         Caption         =   "Meses"
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin Threed.SSOption SSOption1 
         Height          =   165
         Index           =   2
         Left            =   3885
         TabIndex        =   6
         Top             =   240
         Width           =   675
         _Version        =   65536
         _ExtentX        =   1191
         _ExtentY        =   291
         _StockProps     =   78
         Caption         =   "Años"
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin VB.Label Label1 
         Caption         =   "Plazo En "
         Height          =   255
         Left            =   165
         TabIndex        =   7
         Top             =   210
         Width           =   1440
      End
   End
   Begin MSComctlLib.Toolbar Tlb_botones 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   0
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
            ImageIndex      =   4
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
         Left            =   1620
         TabIndex        =   1
         TabStop         =   0   'False
         Top             =   90
         Width           =   4575
      End
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
         NumListImages   =   4
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_PLAZO_INFORME_CARTERA.frx":008D
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_PLAZO_INFORME_CARTERA.frx":0F67
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_PLAZO_INFORME_CARTERA.frx":1E41
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_PLAZO_INFORME_CARTERA.frx":215B
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "FRM_PLAZO_INFORME_CARTERA"
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
Private Function FUNC_BUSCAR_PLAZO()
With Grd_Plazos

      If Not BAC_SQL_EXECUTE("SP_CON_PLAZOS_INFORME_CARTERA") Then
      
         MsgBox "No fue posible leer información", vbOKOnly + vbCritical
         Exit Function
         
      Else
      
         .Rows = 2
         
         Do While BAC_SQL_FETCH(Datos())
         
             .Rows = .Rows + 1
             nIndice = .Rows - 1
            .TextMatrix(nIndice, 0) = Datos(1)
            .TextMatrix(nIndice, 1) = Datos(2)
            If Datos(3) = "D" Then Me.SSOption1(0).Value = True
            If Datos(3) = "M" Then Me.SSOption1(1).Value = True
            If Datos(3) = "A" Then Me.SSOption1(2).Value = True
         Loop
         
     End If
   If .Rows = 2 Then
       .Rows = 3
       FUNC_LLENAR_BLANCOS (2)
   End If
   
End With
      
End Function



Private Function FUNC_GRABAR()

With Grd_Plazos
If Not BAC_SQL_EXECUTE("BEGIN TRANSACTION") Then GoTo Errores

For nIndice = 2 To .Rows - 1

         Envia = Array()
         AddParam Envia, Val(.TextMatrix(nIndice, 0))
         AddParam Envia, Val(.TextMatrix(nIndice, 1))
         If Me.SSOption1(0).Value = True Then
            AddParam Envia, "D"
         ElseIf Me.SSOption1(1).Value = True Then
            AddParam Envia, "M"
         Else
            AddParam Envia, "A"
         End If
         AddParam Envia, nIndice
          
        If Not BAC_SQL_EXECUTE("SP_ACT_PLAZO_INFORME_CARTERA", Envia) Then GoTo Errores
   
Next nIndice

If Not BAC_SQL_EXECUTE("COMMIT TRANSACTION") Then GoTo Errores

MsgBox "Información Grabada Correctamente.", vbOKOnly + vbInformation
End With
Call FUNC_BUSCAR_PLAZO

Exit Function
Errores:
If Not BAC_SQL_EXECUTE("ROLLBACK TRANSACTION") Then
   MsgBox "Error al Reversar la Acción", vbOKOnly + vbCritical
   Exit Function
End If

MsgBox "Información No fue Grabada.", vbOKOnly + vbCritical
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
  
  
  
End Function


Private Function FUNC_VALIDAR_PLAZOS()

If Grd_Plazos.Col = 0 Then

  If CDbl(Replace(Grd_Plazos.TextMatrix(Grd_Plazos.Row, Grd_Plazos.Col), gsc_SeparadorMiles, "")) >= CDbl(Replace(Grd_Plazos.TextMatrix(Grd_Plazos.Row, 1), gsc_SeparadorMiles, "")) Then
    MsgBox "Plazo desde Mayor igual al Plazo Hasta", vbInformation
    Grd_Plazos.TextMatrix(Grd_Plazos.Row, Grd_Plazos.Col) = CDbl(Replace(Grd_Plazos.TextMatrix(Grd_Plazos.Row, 1), gsc_SeparadorMiles, "")) - 1

    Exit Function
  End If
  If Grd_Plazos.Row <> 2 Then

        If CDbl(Replace(Grd_Plazos.TextMatrix(Grd_Plazos.Row, Grd_Plazos.Col), gsc_SeparadorMiles, "")) <= CDbl(Replace(Grd_Plazos.TextMatrix(Grd_Plazos.Row - 1, 1), gsc_SeparadorMiles, "")) Then
            MsgBox "Plazo desde Menor o Igual al Plazo Hasta anterior", vbInformation
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
        MsgBox "Plazo Hasta Menor o Igual al Plazo Desde", vbInformation
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
         If Tlb_Botones.Buttons(opcion).Enabled Then
            Call Tlb_Botones_ButtonClick(Tlb_Botones.Buttons(opcion))
         End If
   End If

End If
End Sub

Private Sub Form_Load()
Call FUNC_BUSCAR_PLAZO
Me.Icon = BAC_Parametros.Icon
Me.top = 0
Me.left = 0
End Sub


Private Sub Grd_Plazos_AfterEdit(ByVal Row As Long, ByVal Col As Long)

 Grd_Plazos.TextMatrix(Grd_Plazos.Row, Grd_Plazos.Col) = Replace(Grd_Plazos.TextMatrix(Grd_Plazos.Row, Grd_Plazos.Col), " ", "")
 
 If Trim(Replace(Grd_Plazos.TextMatrix(Grd_Plazos.Row, Grd_Plazos.Col), gsc_SeparadorMiles, "")) = "" Then
   Grd_Plazos.TextMatrix(Grd_Plazos.Row, Grd_Plazos.Col) = 0
 End If
 
 Call FUNC_VALIDAR_PLAZOS
 
 Grd_Plazos.TextMatrix(Grd_Plazos.Row, Grd_Plazos.Col) = Replace(Grd_Plazos.Text, " ", "")
 Grd_Plazos.TextMatrix(Grd_Plazos.Row, Grd_Plazos.Col) = Format(Replace(Grd_Plazos.TextMatrix(Grd_Plazos.Row, Grd_Plazos.Col), gsc_SeparadorMiles, ""), Formato_Numero)
 
 
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
      
         If Trim(.TextMatrix(nIndice, 0)) = "" Or Trim(.TextMatrix(nIndice, 1)) = "" Then
         
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
