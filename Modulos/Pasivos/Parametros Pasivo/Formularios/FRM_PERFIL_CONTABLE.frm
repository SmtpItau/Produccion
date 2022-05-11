VERSION 5.00
Object = "{1C0489F8-9EFD-423D-887A-315387F18C8F}#1.0#0"; "vsflex8l.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{48E59290-9880-11CF-9754-00AA00C00908}#1.0#0"; "MSINET.OCX"
Begin VB.Form FRM_PERFIL_CONTABLE 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantención de Parametría QH"
   ClientHeight    =   5250
   ClientLeft      =   2700
   ClientTop       =   2280
   ClientWidth     =   10260
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
   LinkTopic       =   "Form5"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5250
   ScaleWidth      =   10260
   Begin VSFlex8LCtl.VSFlexGrid Grilla_Tmp 
      Height          =   1395
      Left            =   60
      TabIndex        =   7
      TabStop         =   0   'False
      Top             =   6315
      Visible         =   0   'False
      Width           =   9105
      _cx             =   16060
      _cy             =   2461
      Appearance      =   1
      BorderStyle     =   1
      Enabled         =   -1  'True
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MousePointer    =   0
      BackColor       =   -2147483643
      ForeColor       =   -2147483640
      BackColorFixed  =   -2147483633
      ForeColorFixed  =   -2147483630
      BackColorSel    =   -2147483635
      ForeColorSel    =   -2147483634
      BackColorBkg    =   -2147483636
      BackColorAlternate=   -2147483643
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
      GridLines       =   1
      GridLinesFixed  =   2
      GridLineWidth   =   1
      Rows            =   0
      Cols            =   7
      FixedRows       =   0
      FixedCols       =   0
      RowHeightMin    =   0
      RowHeightMax    =   0
      ColWidthMin     =   0
      ColWidthMax     =   0
      ExtendLastCol   =   0   'False
      FormatString    =   ""
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
      Editable        =   0
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
   Begin VSFlex8LCtl.VSFlexGrid Grilla 
      Height          =   3720
      Left            =   45
      TabIndex        =   2
      Top             =   1500
      Width           =   3045
      _cx             =   5371
      _cy             =   6562
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
      ForeColor       =   -2147483635
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
      FixedRows       =   2
      FixedCols       =   0
      RowHeightMin    =   0
      RowHeightMax    =   0
      ColWidthMin     =   0
      ColWidthMax     =   0
      ExtendLastCol   =   0   'False
      FormatString    =   $"FRM_PERFIL_CONTABLE.frx":0000
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
      Editable        =   0
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
      Left            =   5505
      Top             =   -30
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
            Picture         =   "FRM_PERFIL_CONTABLE.frx":0058
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_PERFIL_CONTABLE.frx":0F32
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_PERFIL_CONTABLE.frx":1E0C
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_PERFIL_CONTABLE.frx":2CE6
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_PERFIL_CONTABLE.frx":3BC0
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_PERFIL_CONTABLE.frx":3EDA
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_PERFIL_CONTABLE.frx":4DB4
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar TlbOpciones 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   4
      Top             =   0
      Width           =   10260
      _ExtentX        =   18098
      _ExtentY        =   847
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   7
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Nuevo"
            Object.ToolTipText     =   "Nuevo"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Key             =   "Grabar"
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Cargar"
            Object.ToolTipText     =   "Cargar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Buscar"
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Imprimir"
            Object.ToolTipText     =   "Imprimir"
            ImageIndex      =   6
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Vista Previa"
            Object.ToolTipText     =   "Vista Previa"
            ImageIndex      =   7
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   5
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin InetCtlsObjects.Inet netTrans_Archivo 
         Left            =   4740
         Top             =   15
         _ExtentX        =   1005
         _ExtentY        =   1005
         _Version        =   393216
         Protocol        =   2
         RemotePort      =   21
         URL             =   "ftp://"
      End
   End
   Begin VB.Frame Frame1 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   990
      Left            =   30
      TabIndex        =   5
      Top             =   465
      Width           =   10200
      Begin VB.TextBox txtCodigo_Operacion 
         Height          =   330
         Left            =   2025
         MaxLength       =   3
         TabIndex        =   0
         Top             =   345
         Width           =   855
      End
      Begin VB.ComboBox CmbCodigoOperacion 
         Enabled         =   0   'False
         Height          =   330
         ItemData        =   "FRM_PERFIL_CONTABLE.frx":5C8E
         Left            =   2895
         List            =   "FRM_PERFIL_CONTABLE.frx":5C90
         Style           =   1  'Simple Combo
         TabIndex        =   1
         Text            =   "CmbCodigoOperacion"
         Top             =   345
         Width           =   7215
      End
      Begin VB.Label lblCodigoOperacion 
         Caption         =   "Código de Operación"
         Height          =   270
         Left            =   135
         TabIndex        =   6
         Top             =   390
         Width           =   1815
      End
   End
   Begin VSFlex8LCtl.VSFlexGrid Grilla_Secuencia 
      Height          =   3720
      Left            =   3090
      TabIndex        =   3
      Top             =   1500
      Width           =   7125
      _cx             =   12568
      _cy             =   6562
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
      ForeColor       =   -2147483635
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
      FixedRows       =   2
      FixedCols       =   0
      RowHeightMin    =   0
      RowHeightMax    =   0
      ColWidthMin     =   0
      ColWidthMax     =   0
      ExtendLastCol   =   0   'False
      FormatString    =   $"FRM_PERFIL_CONTABLE.frx":5C92
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
      Editable        =   0
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
Attribute VB_Name = "FRM_PERFIL_CONTABLE"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim cSistema    As String
Dim cProducto   As String
Dim OptLocal    As String
Dim nEstado_FTP As Integer


Function FUNC_BUSCAR_EN_COMBO(cmb_combo As ComboBox, cCodigo_Caracter As String, nLargo_Campo As Integer) As Integer
Dim iContador As Integer
FUNC_BUSCAR_EN_COMBO = -1

    For iContador = 0 To cmb_combo.ListCount - 1
        If Trim(right(cmb_combo.List(iContador), nLargo_Campo)) = cCodigo_Caracter Then
                FUNC_BUSCAR_EN_COMBO = iContador
                Exit For
        End If
    Next
 
 
End Function


Sub PROC_CARGA_SISTEMA()
Dim Datos()

 If Not BAC_SQL_EXECUTE("Sp_CmbSistema") Then Exit Sub
 
 'cmb_Sistema.Clear
 
 Do While BAC_SQL_FETCH(Datos())
    'cmb_Sistema.AddItem Datos(2) & Space(100) & Datos(1)
 Loop
 

End Sub


Private Function FUNC_CARGAR_DATOS() As Boolean
   
   Dim cFileINI   As String
   Dim cFileFIN   As String
   Dim cRegistro  As String
   Dim Datos()
   Dim cCodigo_operacion    As String
   Dim cTipo_Operacion      As String
   Dim cConcepto_programa   As String
   Dim cConcepto_contable   As String
   Dim nSecuencia           As Integer
   Dim cDonde               As String
   
   FUNC_CARGAR_DATOS = False
   
   Envia = Array()
   AddParam Envia, "PCA"
   AddParam Envia, OptLocal
   
   Screen.MousePointer = vbHourglass
   
   With netTrans_Archivo
      
      .Cancel
      .Protocol = icFTP
      
      If Not BAC_SQL_EXECUTE("SP_CON_RESCATAR_CASILLA", Envia) Then
         
         Screen.MousePointer = vbDefault
         MsgBox "Problemas al Generar Información para Interfaz", vbCritical
         Exit Function
      
      End If
      
      Do While BAC_SQL_FETCH(Datos())
   
         cFileINI = Datos(5) & Datos(6)
         cFileFIN = Datos(7) & Datos(8)
         .RemoteHost = Datos(2)
         .UserName = Datos(3)
         .Password = Datos(4)
         
      Loop
            
      On Error GoTo No_Coneccion
      
      If Dir(cFileFIN, vbArchive) <> "" Then
         Kill cFileFIN
      End If
      
      nEstado_FTP = 0
      
      .Execute "ftp://" & .RemoteHost & "/", LCase("get " & cFileINI & " " & cFileFIN)

      Do While .StillExecuting
         
         If nEstado_FTP = 11 Then
            
            .Cancel
            Screen.MousePointer = vbDefault
            MsgBox "No se puede conectar con el host remoto", vbCritical
            Exit Function
         
         End If
         
         DoEvents
      
      Loop
      
      .Cancel
         
   End With
   
   If Dir(cFileFIN, vbArchive) = "" Then
      
      Screen.MousePointer = vbDefault
      MsgBox "No se puede transferir el archivo desde el host remoto", vbCritical
      Exit Function
   
   End If
   
   Open cFileFIN For Input As #1
   
   Do While Not EOF(1)
      
      Line Input #1, cRegistro
      
      If Trim(cRegistro) <> "" Then
         
         cCodigo_operacion = Trim(Mid(cRegistro, 1, 3))
         cTipo_Operacion = Trim(Mid(cRegistro, 4, 1))
         cConcepto_programa = Trim(Mid(cRegistro, 5, 5))
         cConcepto_contable = Trim(Mid(cRegistro, 10, 4))
         nSecuencia = CDbl(Mid(cRegistro, 14, 2))
         cDonde = Trim(Mid(cRegistro, 16, 1))
         
            Envia = Array()
            AddParam Envia, cCodigo_operacion
            AddParam Envia, cTipo_Operacion
            AddParam Envia, cConcepto_programa
            AddParam Envia, cConcepto_contable
            AddParam Envia, nSecuencia
            AddParam Envia, cDonde
            Screen.MousePointer = vbHourglass
   
            If BAC_SQL_EXECUTE("SP_GRABAR_PARAMETRIA_CONTABLE", Envia) Then
         
                 If BAC_SQL_FETCH(Datos()) Then
                    If Datos(1) = "ERROR" Then
                        Screen.MousePointer = vbDefault
                        MsgBox "Problemas al cargar información", vbCritical
                        
                        Close #1
                        Exit Function
                    End If
                 End If
            Else
                Screen.MousePointer = vbDefault
                MsgBox "Problemas al cargar información", vbCritical
                Close #1
                Exit Function
            End If
      
      End If
      
   Loop
   
   Close #1
   
   Screen.MousePointer = vbDefault
  
   FUNC_CARGAR_DATOS = True
   
   Exit Function

No_Coneccion:

   Screen.MousePointer = vbDefault
   MsgBox err.Description, vbCritical
   On Error GoTo 0

End Function





Private Sub CmbCodigoOperacion_Click()
'If Trim(Right(CmbCodigoOperacion.Text, 5)) <> txtCodigo_Operacion.Text Then
    'txtCodigo_Operacion.Text = Trim(Right(CmbCodigoOperacion.Text, 5))
'End If
End Sub


Private Sub Form_Activate()

    PROC_CARGA_AYUDA Me, " "

End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
Dim iOpcion          As Integer

   iOpcion = 0

   If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) Then
      Select Case KeyCode

      Case vbKeyLimpiar
         iOpcion = 1

      Case vbKeyGrabar
         iOpcion = 2
      
      Case vbKeyCarga
         iOpcion = 3
      
      Case vbKeyBuscar
         iOpcion = 4
      
      Case vbKeyImprimir
         iOpcion = 5
      
      Case vbKeyVistaPrevia
         iOpcion = 6

      Case vbKeySalir
         iOpcion = 7

      End Select

      If iOpcion <> 0 Then
         If TlbOpciones.Buttons(iOpcion).Enabled Then
            Call TlbOpciones_ButtonClick(TlbOpciones.Buttons(iOpcion))

         End If

         KeyCode = 0

      End If


   End If

End Sub


Private Sub Form_Load()
   
   OptLocal = Opt
   Me.Icon = BAC_Parametros.Icon
   Me.top = 0
   Me.left = 0
   PROC_LIMPIAR
   
   
   Call LogAuditoria("07", OptLocal, Me.Caption, "", "")

End Sub

Private Sub Form_Unload(Cancel As Integer)
   
   Call LogAuditoria("08", OptLocal, Me.Caption, "", "")

End Sub

Private Sub Grilla_AfterEdit(ByVal Row As Long, ByVal Col As Long)

    Select Case Col
        Case 0
            If Not FUNC_VALIDA_REPETIDOS(Row) Then
                MsgBox "El Valor no pude ser utilizado mas de una vez en la Columna " & Chr(34) & grilla.TextMatrix(0, Col) & " " & grilla.TextMatrix(1, Col) & Chr(34), vbExclamation
                grilla.TextMatrix(Row, Col) = ""
            End If
    End Select

    Select Case Col
      
         Case 0
            Grilla_Tmp.Col = 0
         
         Case 1
            Grilla_Tmp.Col = 1
    
    End Select

    
    Grilla_Tmp.TextMatrix(Grilla_Tmp.Row, Grilla_Tmp.Col) = grilla.TextMatrix(Row, Col)

End Sub

Private Function FUNC_VALIDA_REPETIDOS(nRow As Long) As Boolean
Dim vMatriz()
Dim nIndice1    As Long
Dim nIndice     As Integer

ReDim vMatriz(grilla.Cols)

   With grilla
       
       FUNC_VALIDA_REPETIDOS = False
       
       If .Rows = 2 Then
           FUNC_VALIDA_REPETIDOS = True
           Exit Function
       End If
       
       For nIndice = 0 To 0 '.Cols - 1
           vMatriz(nIndice) = .TextMatrix(nRow, nIndice)
       Next nIndice
           
       For nIndice = 1 To .Rows - 1
           
           If nIndice <> nRow Then
           
               FUNC_VALIDA_REPETIDOS = False
               
               For nIndice1 = 0 To 0 '.Cols - 1
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


Private Sub Grilla_KeyDown(KeyCode As Integer, Shift As Integer)
'Dim nFila      As Integer
'
'   With Grilla
'
'    Select Case KeyCode
'      Case vbKeyInsert
'
'         If FUNC_VALIDA_BLANCOS Then
'            .Rows = .Rows + 1
'            .Row = .Rows - 1
'            .TopRow = .Row
'            .Col = 0
'            Call Grilla_SelChange
'            .Refresh
'
'         Else
'            MsgBox "Hay registros en Blanco", vbOKOnly + vbInformation
'            .SetFocus
'         End If
'
'      Case vbKeyDelete
'
'         If .Row <> 0 Then
'
'             For nFila = 0 To Grilla_Tmp.Rows - 1
'
'               If nFila > Grilla_Tmp.Rows - 1 Then Exit For
'
'               If Grilla_Tmp.TextMatrix(nFila, 0) = .TextMatrix(.Row, 0) Then
'                  Grilla_Tmp.RemoveItem (nFila)
'                  nFila = -1
'                  Grilla_Secuencia.Rows = 2
'
'               End If
'
'             Next
'
'             .RemoveItem (.Row)
'             .SetFocus
'             Call Grilla_SelChange
'         End If
'
'      End Select
'
'   End With

End Sub

Private Function FUNC_VALIDA_BLANCOS() As Boolean
Dim nIndice    As Integer

   With grilla
      
         For nIndice = 2 To .Rows - 1
         
            If Trim(.TextMatrix(nIndice, 0)) = "" Or Trim(.TextMatrix(nIndice, 1)) = "" Then
            
               FUNC_VALIDA_BLANCOS = False
               Exit Function
               
            End If
            
         Next nIndice
         
         FUNC_VALIDA_BLANCOS = True
         
   End With
End Function

Private Function FUNC_VALIDA_BLANCOS_SECUENCIA() As Boolean
Dim nIndice    As Integer

   With Grilla_Secuencia
      
         For nIndice = 2 To .Rows - 1
         
            If Trim(.TextMatrix(nIndice, 0)) = "" Or Trim(.TextMatrix(nIndice, 1)) = "" Or Trim(.TextMatrix(nIndice, 2)) = "" Or Trim(.TextMatrix(nIndice, 3)) = "" Then
            
               FUNC_VALIDA_BLANCOS_SECUENCIA = False
               Exit Function
               
            End If
            
         Next nIndice
         
         FUNC_VALIDA_BLANCOS_SECUENCIA = True
         
   End With
End Function

Private Function FUNC_VALIDA_BLANCOS_TEMPORAL() As Boolean
Dim nIndice    As Integer

   With Grilla_Tmp
      
         For nIndice = 2 To .Rows - 1
         
            If Trim(.TextMatrix(nIndice, 3)) = "" Or Trim(.TextMatrix(nIndice, 4)) = "" Or Trim(.TextMatrix(nIndice, 2)) = "" Or Trim(.TextMatrix(nIndice, 5)) = "" Then
            
               FUNC_VALIDA_BLANCOS_TEMPORAL = False
               Exit Function
               
            End If
            
         Next nIndice
         
         FUNC_VALIDA_BLANCOS_TEMPORAL = True
         
   End With
End Function


Private Sub Grilla_Secuencia_AfterEdit(ByVal Row As Long, ByVal Col As Long)
Dim nFila      As Long
   
   With Grilla_Tmp
   
      For nFila = 0 To .Rows - 1
      
         If grilla.TextMatrix(grilla.Row, 0) = .TextMatrix(nFila, 0) And .TextMatrix(nFila, 2) = Grilla_Secuencia.TextMatrix(Row, 0) Then
            .Row = nFila
            .Text = Grilla_Secuencia.Text
            Exit For
         
         End If
      
      Next
      
   End With

End Sub

Private Sub Grilla_Secuencia_DblClick()

   If Grilla_Secuencia.Col = 0 Then
      'Grilla_Secuencia.Editable = flexEDNone
   End If


End Sub

Private Sub Grilla_Secuencia_GotFocus()

   If Grilla_Secuencia.Enabled Then
      Grilla_Secuencia.Row = Grilla_Secuencia.Rows - 1
      Grilla_Secuencia.Col = 0
      
   End If

End Sub

Private Sub Grilla_Secuencia_KeyDown(KeyCode As Integer, Shift As Integer)
'Dim nFila   As Integer
'
'   With Grilla_Secuencia
'
'    Select Case KeyCode
'      Case vbKeyInsert
'
'         If FUNC_VALIDA_BLANCOS_SECUENCIA Then
'            .Rows = .Rows + 1
'            .Row = .Rows - 1
'            .TopRow = .Row
'            .Col = 0
'            Grilla_Tmp.Rows = Grilla_Tmp.Rows + 1
'            Grilla_Tmp.TextMatrix(Grilla_Tmp.Rows - 1, 2) = .Rows - 2
'            Grilla_Tmp.TextMatrix(Grilla_Tmp.Rows - 1, 0) = Grilla.TextMatrix(Grilla.Row, 0)
'            Grilla_Tmp.TextMatrix(Grilla_Tmp.Rows - 1, 1) = Grilla.TextMatrix(Grilla.Row, 1)
'            .TextMatrix(.Row, 0) = .Rows - 2
'            .Refresh
'            Call Grilla_Secuencia_SelChange
'         Else
'            MsgBox "Hay registros en Blanco", vbOKOnly + vbInformation
'            .SetFocus
'         End If
'
'      Case vbKeyDelete
'
'         If .Row <> 0 Then
'
'            If .Rows = 2 Then Exit Sub
'
'             For nFila = 0 To Grilla_Tmp.Rows - 1
'
'               If nFila > Grilla_Tmp.Rows - 1 Then Exit For
'
'               If Grilla_Tmp.TextMatrix(nFila, 0) = Grilla.TextMatrix(Grilla.Row, 0) And Grilla_Tmp.TextMatrix(nFila, 2) = .TextMatrix(.Rows - 1, 0) Then
'                   Grilla_Tmp.RemoveItem (nFila)
'                   nFila = -1
'               End If
'
'             Next
'
'             .RemoveItem (.Rows - 1)
'
'             If Grilla_Secuencia.Rows = 2 Then
'               Grilla_Secuencia.Rows = 3
'               Grilla_Secuencia.Row = Grilla_Secuencia.Rows - 1
'               Grilla_Secuencia.TextMatrix(Grilla_Secuencia.Row, 0) = 1
'
'             End If
'
'             .SetFocus
'         End If
'
'      End Select
'
'   End With

End Sub

Private Sub Grilla_Secuencia_KeyPress(KeyAscii As Integer)

   If Grilla_Secuencia.Col = 0 Then
      KeyAscii = 0
   End If

End Sub

Private Sub Grilla_Secuencia_KeyPressEdit(ByVal Row As Long, ByVal Col As Long, KeyAscii As Integer)

   If Grilla_Secuencia.Col = 0 Then
      KeyAscii = 0
   End If

End Sub

Private Sub Grilla_Secuencia_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)

'   Grilla_Secuencia.Editable = flexEDKbdMouse

End Sub

Private Sub Grilla_Secuencia_SelChange()
Dim nFila   As Integer
   
   For nFila = 0 To Grilla_Tmp.Rows - 1

      If Grilla_Tmp.TextMatrix(nFila, 0) = grilla.TextMatrix(grilla.Row, 0) And Grilla_Tmp.TextMatrix(nFila, 2) = Grilla_Secuencia.TextMatrix(Grilla_Secuencia.Row, 0) Then
         Grilla_Tmp.Row = nFila
         Exit For

      End If

   Next
   
   Grilla_Tmp.Col = Grilla_Secuencia.Col + 2

End Sub

Private Sub Grilla_SelChange()
Dim nFila      As Integer

   Grilla_Tmp.Col = grilla.Col
   If grilla.Rows - 2 = Grilla_Tmp.Rows Then
      Grilla_Tmp.Row = grilla.Row - 2
   End If
   Call PROC_BUSCA_DATOS_GRILLA_TMP

End Sub

Private Sub TlbOpciones_ButtonClick(ByVal Button As MSComctlLib.Button)

   Select Case UCase(Button.Key)

      Case "NUEVO"
         Call PROC_LIMPIAR
         If txtCodigo_Operacion.Enabled Then
            txtCodigo_Operacion.SetFocus
         End If
         
      Case "GRABAR"
            PROC_GRABAR

      Case "CARGAR"
            
          If Not BacBeginTransaction Then
             Exit Sub
          End If

          If FUNC_CARGAR_DATOS Then
             Call BacCommitTransaction
          Else
             Call BacRollBackTransaction
          End If
      
      Case "BUSCAR"
         Call PROC_BUSCAR
      
      Case "IMPRIMIR"
         Call PROC_IMPRIMIR(1)
      
      Case "VISTA PREVIA"
         Call PROC_IMPRIMIR(0)
      
      Case "SALIR"
         Unload Me
      
      
   End Select

End Sub

Private Sub PROC_LIMPIAR()

   PROC_CARGA_CODIGO_OPERACION
   PROC_HABILITA_CONTROLES False
   
   PROC_CARGA_SISTEMA
   
   txtCodigo_Operacion.Text = ""
   

   

   cSistema = ""
   cProducto = ""
   grilla.Rows = 2
   Grilla_Secuencia.Rows = 2
   Grilla_Tmp.Rows = 0


End Sub

Private Sub PROC_GRABAR()
Dim nFila      As Integer
Dim cMensaje   As String
   With Grilla_Tmp
      
      Call BacBeginTransaction
      
      Envia = Array()


      AddParam Envia, Trim(right(CmbCodigoOperacion.Text, 10))
      
      'If Not BAC_SQL_EXECUTE("SP_ELI_PERFIL_CONTABILIDAD", Envia) Then
      '   Call BacRollBackTransaction
      '   MsgBox "Problemas Ejecutando Consulta", vbExclamation
      '   Exit Sub
      'End If
      
      For nFila = 0 To .Rows - 1

         If Not (.TextMatrix(nFila, 0) = "") And Not (.TextMatrix(nFila, 0) = grilla.TextMatrix(1, 0)) Then

            Envia = Array()
      
'            AddParam Envia, Trim(right(cmb_Sistema.Text, 3))
'            AddParam Envia, Trim(right(cmb_Producto.Text, 5))
            AddParam Envia, Trim(right(CmbCodigoOperacion.Text, 10))
            AddParam Envia, .TextMatrix(nFila, 0)
            AddParam Envia, .TextMatrix(nFila, 2)
            AddParam Envia, .TextMatrix(nFila, 1)
            AddParam Envia, Trim(.TextMatrix(nFila, 3))
            AddParam Envia, Trim(.TextMatrix(nFila, 4))
            AddParam Envia, .TextMatrix(nFila, 5)
            AddParam Envia, .TextMatrix(nFila, 6)
      
            If Not BAC_SQL_EXECUTE("SP_ACT_PERFIL_CONTABILIDAD", Envia) Then
               Call BacRollBackTransaction
               MsgBox "Problemas Ejecutando Consulta", vbExclamation
               Call LogAuditoria("01", OptLocal, "Error " & Me.Caption, "", "")
               Exit Sub
            End If
            If BAC_SQL_FETCH(Datos()) Then
               If Datos(1) = "NO" Then
                   cMensaje = Datos(2)
                   Call BacRollBackTransaction
                   MsgBox cMensaje, vbOKOnly + vbExclamation
                   Exit Sub
               End If
            End If
   
         End If
  
      Next

   End With

   Call BacCommitTransaction
   MsgBox "Información Grabada Correctamente.", vbInformation
   Call LogAuditoria("01", OptLocal, Me.Caption, "", "")

   Call PROC_LIMPIAR

   If CmbCodigoOperacion.Enabled Then
      CmbCodigoOperacion.SetFocus
   
   End If

End Sub

Private Sub PROC_ELIMINAR()



   If MsgBox("¿ Seguro de Eliminar Registro?", vbYesNo + vbQuestion) = vbYes Then

      Call BacBeginTransaction
      
      Envia = Array()

      AddParam Envia, cSistema
      AddParam Envia, cProducto
      AddParam Envia, Trim(right(CmbCodigoOperacion, 10))
      
      If Not BAC_SQL_EXECUTE("SP_ELI_PERFIL_CONTABILIDAD", Envia) Then
         Call BacRollBackTransaction
         MsgBox "Problemas Ejecutando Consulta", vbExclamation
         Exit Sub
      End If
   
      Call BacCommitTransaction
      MsgBox "El Registro fue eliminado.", vbInformation
      Call LogAuditoria("03", OptLocal, Me.Caption, "", "")
   
      Call PROC_LIMPIAR
      
      If CmbCodigoOperacion.Enabled Then
         CmbCodigoOperacion.SetFocus
      
      End If

   End If

End Sub

Private Sub PROC_BUSCAR()
Dim Datos()
Dim bDatos     As Boolean
Dim nColumnas  As Integer
Dim cConceptoProg As String
Dim cSistema  As String
Dim cProducto As String
   bDatos = False

   With grilla

      If CmbCodigoOperacion = "" Then
         Exit Sub
      
      End If
   
      If Not BAC_SQL_EXECUTE("SP_CON_CODIGO_OPERACION_CONTABILIDAD") Then
         MsgBox "Problemas en Consulta", vbExclamation
         Exit Sub
      End If
      
      While BAC_SQL_FETCH(Datos())
         
         If Datos(1) = Trim(right(CmbCodigoOperacion, 10)) Then
            cSistema = Datos(3)
            cProducto = Datos(4)
         End If
         
      Wend
   
      For nColumnas = 0 To .Cols - 1
         .ColComboList(nColumnas) = ""
      Next
   
      For nColumnas = 0 To Grilla_Secuencia.Cols - 1
         Grilla_Secuencia.ColComboList(nColumnas) = ""
      Next
   
   
      Envia = Array()
      AddParam Envia, ""
      AddParam Envia, cSistema
      AddParam Envia, cProducto
   
      If Not BAC_SQL_EXECUTE("SP_CON_CAMPO_CONTABILIDAD", Envia) Then
         MsgBox "Problemas ejecutando Consulta", vbExclamation
         Exit Sub
      End If
      
      While BAC_SQL_FETCH(Datos())
         .ColComboList(0) = .ColComboList(0) & "#" & Datos(1) & ";" & Datos(1) & "|"
      Wend
      Grilla_Secuencia.ColComboList(4) = Grilla_Secuencia.ColComboList(4) & "#" & "D" & ";" & "DEBE" & "|"
      Grilla_Secuencia.ColComboList(4) = Grilla_Secuencia.ColComboList(4) & "#" & "H" & ";" & "HABER"
      
      If Not BAC_SQL_EXECUTE("SP_CON_CONCEPTO_CONTABILIDAD") Then
         MsgBox "Problemas ejecutando Consulta", vbExclamation
         Exit Sub
      End If
      
      While BAC_SQL_FETCH(Datos())
         Grilla_Secuencia.ColComboList(3) = Grilla_Secuencia.ColComboList(3) & "#" & Datos(1) & ";" & Datos(1) & "|"
      Wend
      
      
      If Not BAC_SQL_EXECUTE("sp_mnleetodo") Then
         MsgBox "Problemas ejecutando Consulta", vbExclamation
         Exit Sub
      End If
      
      While BAC_SQL_FETCH(Datos())
         .ColComboList(1) = .ColComboList(1) & "#" & Datos(1) & ";" & Datos(2) & "|"
   
      Wend
   
   
      Envia = Array()
      AddParam Envia, Trim(right(CmbCodigoOperacion.Text, 10))
     ' AddParam Envia, Trim(right(cmb_Sistema.Text, 3))
     ' AddParam Envia, Trim(right(cmb_Producto.Text, 5))
      
      If Not BAC_SQL_EXECUTE("SP_CON_PERFIL_CONTABILIDAD", Envia) Then
         MsgBox "Problemas en Consulta", vbExclamation
         Exit Sub
      End If
      
      .Rows = 2
      Grilla_Tmp.Rows = 0
      Grilla_Secuencia.Rows = 2
      cConceptoProg = ""
      
      While BAC_SQL_FETCH(Datos())
         
         bDatos = True
         
         If cConceptoProg <> Datos(4) Then
         
            .Rows = .Rows + 1
            .TextMatrix(.Rows - 1, 0) = Datos(4)
            .TextMatrix(.Rows - 1, 1) = Datos(6)
            cConceptoProg = Datos(4)
            cSistema = Datos(1)
            cProducto = Datos(2)
            
            
         End If
         
         Grilla_Tmp.Rows = Grilla_Tmp.Rows + 1
         Grilla_Tmp.TextMatrix(Grilla_Tmp.Rows - 1, 0) = Datos(4)
         Grilla_Tmp.TextMatrix(Grilla_Tmp.Rows - 1, 1) = Datos(6)
         Grilla_Tmp.TextMatrix(Grilla_Tmp.Rows - 1, 2) = Datos(5)
         Grilla_Tmp.TextMatrix(Grilla_Tmp.Rows - 1, 3) = Datos(7)
         Grilla_Tmp.TextMatrix(Grilla_Tmp.Rows - 1, 4) = Datos(8)
         Grilla_Tmp.TextMatrix(Grilla_Tmp.Rows - 1, 5) = Datos(9)
         Grilla_Tmp.TextMatrix(Grilla_Tmp.Rows - 1, 6) = Datos(10)
         
   
      Wend
      
      
   
      PROC_HABILITA_CONTROLES True
   
      If Not bDatos Then
         .Rows = .Rows + 1
         Grilla_Tmp.Rows = Grilla_Tmp.Rows + 1
         Grilla_Tmp.TextMatrix(Grilla_Tmp.Rows - 1, 2) = 1
         Grilla_Secuencia.Rows = Grilla_Secuencia.Rows + 1
         Grilla_Secuencia.TextMatrix(2, 0) = "1"
         TlbOpciones.Buttons(4).Enabled = False
      End If
      
   End With

   If grilla.Enabled Then
      grilla.Row = 2
      grilla.Col = 0
      grilla.SetFocus
   
   End If


End Sub


Private Sub PROC_HABILITA_CONTROLES(bEstado As Boolean)

   With TlbOpciones
      .Buttons(2).Enabled = bEstado
      .Buttons(3).Enabled = Not bEstado
      .Buttons(4).Enabled = Not bEstado
      .Buttons(5).Enabled = bEstado
      .Buttons(6).Enabled = bEstado
   End With

   txtCodigo_Operacion.Enabled = Not bEstado
   'CmbCodigoOperacion.Enabled = Not bEstado
  
   'cmb_Sistema.Enabled = (Not bEstado)
   'cmb_Producto.Enabled = (Not bEstado)
   
   grilla.Enabled = bEstado

End Sub

Private Sub PROC_CARGA_CODIGO_OPERACION()
Dim Datos()

   If Not BAC_SQL_EXECUTE("SP_CON_CODIGO_OPERACION_CONTABILIDAD") Then
      MsgBox "Problemas en Consulta", vbExclamation
      Exit Sub
   End If
   
   CmbCodigoOperacion.Clear
   
   While BAC_SQL_FETCH(Datos())
      
      CmbCodigoOperacion.AddItem Datos(8) & Space(200) & Datos(1)
   
   Wend

End Sub

Private Sub PROC_BUSCA_DATOS_GRILLA_TMP()
Dim nFila        As Integer
Dim bPrimeraVez  As Boolean
   
   
   bPrimeraVez = True
   
   With Grilla_Tmp
   
      For nFila = 0 To .Rows - 1

         If .TextMatrix(nFila, 0) = grilla.TextMatrix(grilla.Row, 0) Then
            If bPrimeraVez Then
               Grilla_Secuencia.Rows = 2
               bPrimeraVez = False
            End If
            
            Grilla_Secuencia.Rows = Grilla_Secuencia.Rows + 1
            Grilla_Secuencia.TextMatrix(Grilla_Secuencia.Rows - 1, 0) = .TextMatrix(nFila, 2)
            Grilla_Secuencia.TextMatrix(Grilla_Secuencia.Rows - 1, 1) = .TextMatrix(nFila, 3)
            Grilla_Secuencia.TextMatrix(Grilla_Secuencia.Rows - 1, 2) = .TextMatrix(nFila, 4)
            Grilla_Secuencia.TextMatrix(Grilla_Secuencia.Rows - 1, 3) = .TextMatrix(nFila, 5)
            Grilla_Secuencia.TextMatrix(Grilla_Secuencia.Rows - 1, 4) = .TextMatrix(nFila, 6)
            .Row = nFila
            
         End If

      Next

   End With

   If bPrimeraVez Then
      Grilla_Secuencia.Rows = 2
      Grilla_Secuencia.Rows = 3
      Grilla_Secuencia.TextMatrix(Grilla_Secuencia.Rows - 1, 0) = 1
      Grilla_Tmp.Rows = Grilla_Tmp.Rows + 1
      Grilla_Tmp.TextMatrix(Grilla_Tmp.Rows - 1, 0) = grilla.TextMatrix(grilla.Row, 0)
      Grilla_Tmp.TextMatrix(Grilla_Tmp.Rows - 1, 1) = grilla.TextMatrix(grilla.Row, 1)
      Grilla_Tmp.TextMatrix(Grilla_Tmp.Rows - 1, 2) = 1
   End If

End Sub

Private Sub PROC_IMPRIMIR(nDestinacion As Integer)

      On Error GoTo ErrorRpt:
      
      With BAC_Parametros.BacParam
      
         Call limpiar_cristal
         Screen.MousePointer = vbHourglass
         .Destination = nDestinacion
         .ReportFileName = gsRPT_Path & "Informe_Parametria_QH.rpt"
         Call PROC_ESTABLECE_UBICACION(.RetrieveDataFiles, BAC_Parametros.BacParam)
         .WindowTitle = "INFORME DE PARAMETRIA QH"
         '.StoredProcParam(0) = "" 'Trim(right(cmb_Sistema.Text, 3))
         '.StoredProcParam(1) = "" 'Trim(right(cmb_Producto.Text, 5))
         .StoredProcParam(0) = Trim(right(CmbCodigoOperacion, 10))
         .Formulas(0) = "xusuario='" & gsUsuario & "'"
         .Connect = SwConeccion
         .Action = 1
         Screen.MousePointer = vbDefault
         Call LogAuditoria("10", OptLocal, Me.Caption, "", "")
      
      End With
      
      Exit Sub
ErrorRpt:
      Screen.MousePointer = vbDefault
      MsgBox "Problemas Al Emitir Informe", vbExclamation
      Call LogAuditoria("10", OptLocal, Me.Caption & " - Error al emitir informe", "", "")


End Sub

Private Sub txtCodigo_Operacion_Change()
  CmbCodigoOperacion.ListIndex = FUNC_BUSCAR_EN_COMBO(CmbCodigoOperacion, txtCodigo_Operacion.Text, 3)
End Sub

Private Sub txtCodigo_Operacion_DblClick()
   MiTag = "CODIGO_OPERACION_CONTABILIDAD"
   BacAyuda.Show vbModal
   
   If giAceptar Then
   
      txtCodigo_Operacion.Text = gsCodigo
      PROC_BUSCAR
      
   End If

End Sub


Private Sub txtCodigo_Operacion_KeyPress(KeyAscii As Integer)
  KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub


