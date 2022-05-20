VERSION 5.00
Object = "{1C0489F8-9EFD-423D-887A-315387F18C8F}#1.0#0"; "vsflex8l.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "threed32.ocx"
Begin VB.Form BACMNTGRPCR 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Mantenedor Grupos de Carteras"
   ClientHeight    =   4920
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   5175
   BeginProperty Font 
      Name            =   "Arial"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "BACMNTGRPCR.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   4920
   ScaleWidth      =   5175
   ShowInTaskbar   =   0   'False
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   5175
      _ExtentX        =   9128
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
            Key             =   "Limpiar"
            Description     =   "Grabar"
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Grabar"
            Description     =   "Eliminar"
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Key             =   "Eliminar"
            Description     =   "Limpiar"
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Buscar"
            Description     =   "Salir"
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      Begin MSComctlLib.ImageList Img_opciones 
         Left            =   4320
         Top             =   -90
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   24
         ImageHeight     =   24
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   10
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BACMNTGRPCR.frx":2EFA
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BACMNTGRPCR.frx":3361
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BACMNTGRPCR.frx":3857
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BACMNTGRPCR.frx":3CEA
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BACMNTGRPCR.frx":41D2
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BACMNTGRPCR.frx":46E5
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BACMNTGRPCR.frx":4BB8
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BACMNTGRPCR.frx":507E
               Key             =   ""
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BACMNTGRPCR.frx":5575
               Key             =   ""
            EndProperty
            BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BACMNTGRPCR.frx":596E
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin Threed.SSFrame Frame 
      Height          =   4320
      Index           =   1
      Left            =   45
      TabIndex        =   1
      Top             =   495
      Width           =   5085
      _Version        =   65536
      _ExtentX        =   8969
      _ExtentY        =   7620
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
      Begin VSFlex8LCtl.VSFlexGrid Table1 
         Height          =   4005
         Left            =   105
         TabIndex        =   2
         Top             =   180
         Width           =   4725
         _cx             =   8334
         _cy             =   7064
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
         ForeColor       =   -2147483640
         BackColorFixed  =   8421376
         ForeColorFixed  =   16777215
         BackColorSel    =   -2147483635
         ForeColorSel    =   -2147483634
         BackColorBkg    =   13160660
         BackColorAlternate=   -2147483644
         GridColor       =   8421504
         GridColorFixed  =   0
         TreeColor       =   -2147483632
         FloodColor      =   192
         SheetBorder     =   -2147483642
         FocusRect       =   1
         HighLight       =   1
         AllowSelection  =   -1  'True
         AllowBigSelection=   -1  'True
         AllowUserResizing=   1
         SelectionMode   =   0
         GridLines       =   1
         GridLinesFixed  =   2
         GridLineWidth   =   1
         Rows            =   1
         Cols            =   13
         FixedRows       =   1
         FixedCols       =   0
         RowHeightMin    =   0
         RowHeightMax    =   0
         ColWidthMin     =   0
         ColWidthMax     =   0
         ExtendLastCol   =   0   'False
         FormatString    =   $"BACMNTGRPCR.frx":5D64
         ScrollTrack     =   0   'False
         ScrollBars      =   3
         ScrollTips      =   0   'False
         MergeCells      =   0
         MergeCompare    =   0
         AutoResize      =   -1  'True
         AutoSizeMode    =   0
         AutoSearch      =   1
         AutoSearchDelay =   2
         MultiTotals     =   -1  'True
         SubtotalPosition=   1
         OutlineBar      =   1
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
End
Attribute VB_Name = "BACMNTGRPCR"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private ObjCartera      As Object

Sub Dibuja_Grilla()
    Table1.Cols = 2
    Table1.Rows = 2
    Table1.TextMatrix(0, 0) = "Código"
    Table1.TextMatrix(0, 1) = "Descripción"
    Table1.RowHeight(0) = 315
    Table1.ColWidth(0) = 800
    Table1.ColWidth(1) = 3750
    Table1.ColAlignment(0) = 1
    Table1.ColAlignment(1) = 1
End Sub

Private Function ValidaGrilla() As Integer
   Dim Filas As Integer
   ValidaGrilla = False
   For Filas = 1 To Table1.Rows - 1
      Table1.Row = Filas
      Table1.Col = 0
      If Table1.Rows = 2 Then
         If Table1.TextMatrix(1, 1) = "" And Table1.TextMatrix(1, 2) = "" Then
            Exit For
         End If
      End If
      If Table1.Text = "" Then
         MsgBox "Falta Ingresar Código del Grupo de Cartera", vbInformation
         Exit Function
      End If
      Table1.Col = 1
      If Table1.Text = "" Then
         MsgBox "Falta ingresar descripción del grupo de cartera", 16
         Exit Function
      End If
   Next Filas
   ValidaGrilla = True
End Function

Private Function HabilitarControles(Valor As Boolean)
    Table1.Enabled = Valor
    Toolbar1.Buttons(2).Enabled = Valor
    Toolbar1.Buttons(3).Enabled = Valor
    Toolbar1.Buttons(4).Enabled = Not Valor
End Function

Private Sub Limpiar()
   Table1.Clear
   Table1.Rows = 2
   Dibuja_Grilla
   HabilitarControles (False)
End Sub

Private Function Buscar()
   Table1.Redraw = False
      If ObjCartera.LeerGruposCartera() = False Then
         MsgBox "Problemas al leer grupos de carteras", vbCritical
         Exit Function
      End If
      Table1.Editable = flexEDKbdMouse
      Call ObjCartera.CargarGridGruposCarteras(Table1)
      Call HabilitarControles(True)
      Table1.SetFocus
   Table1.Redraw = True
End Function

Private Sub cmdEliminar()
   Dim A As Integer
   Dim iok          As Integer
   Dim Sql          As String
   If Table1.Row < 1 Then
      Exit Sub
   End If
   iok = MsgBox("¿Seguro de eliminar los GRUPOS DE CARTERAS?", vbInformation + vbYesNo)
   Select Case iok
   Case vbYes
      Call ObjCartera.EliminarGrupoCartera
      Call ObjCartera.LimpiarTodos
      Call Limpiar
      Call HabilitarControles(False)
   End Select
End Sub

Private Sub cmdGrabar()
   If ValidaGrilla() = False Then
      Table1.SetFocus
      Exit Sub
   End If
   Call ObjCartera.EliminarGrupoCartera
   If PGrabarGrpCar() = False Then
      MsgBox "No se puede grabar en tabla grupos de carteras", 16
   Else
      MsgBox "Grabación se realizó con exito", 64
      Call ObjCartera.LimpiarTodos
      Call Limpiar
      Call HabilitarControles(False)
   End If
End Sub

Private Sub cmdLimpiar()
   Call ObjCartera.LimpiarTodos
   Call Limpiar
   Call HabilitarControles(False)
   Dibuja_Grilla
End Sub

Private Sub Form_Activate()
   PROC_CARGA_AYUDA Me, " "
   Call Limpiar
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
On Error GoTo err
Dim opcion As Integer
  opcion = 0
   If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) Then
        Select Case KeyCode
           Case vbKeyLimpiar:
                              opcion = 1
            Case vbKeyGrabar:
                              opcion = 2
            Case vbKeyEliminar:
                              opcion = 3
            Case vbKeyBuscar:
                              opcion = 4
            Case vbKeySalir:
                            If UCase(ActiveControl.Name) <> "TXTINGRESO" Then
                              opcion = 5
                            End If
      End Select
      If opcion <> 0 Then
            If Toolbar1.Buttons(opcion).Enabled Then
               Call Toolbar1_ButtonClick(Toolbar1.Buttons(opcion))
            End If
            KeyCode = 0
      End If
   End If
Exit Sub
err:
  Resume Next
End Sub

Private Sub Form_Load()
   Me.top = 0
   Me.left = 0
   Me.Icon = BAC_Parametros.Icon
   Dim nCol    As Integer
   Set ObjCartera = New clsCarte
   Call HabilitarControles(False)
End Sub

Private Sub Table1_KeyDown(KeyCode As Integer, Shift As Integer)
   Dim bOk        As Boolean
   Dim nOk        As Integer
   Dim EsNull       As Boolean
   Select Case KeyCode
   Case vbKeyInsert
      Table1.Rows = Table1.Rows + 1
      Table1.Row = Table1.Rows - 1
      Table1.Refresh
   Case vbKeyDelete
    EsNull = True
    Envia = Array()
    AddParam Envia, Trim(Table1.TextMatrix(Table1.Row, 0))
    If BAC_SQL_EXECUTE("Sp_MDRCConsultaGrupoCarteraAsignado ", Envia) Then
        Do While BAC_SQL_FETCH(Datos())
               EsNull = False
        Loop
    End If
    If EsNull Then
      If Table1.Rows > 2 Then
         Table1.RemoveItem Table1.Row
      Else
         Table1.Rows = 1
         Table1.Rows = 2
      End If
    Else
        MsgBox "No se puede eliminar código asociado a una cartera", vbInformation
    End If
   End Select
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
    Select Case Button.Index
        Case 2          '"Grabar"
            Call cmdGrabar
        Case 3          '"ELIMINAR"
            Call cmdEliminar
        Case 1          '"Limpiar"
            Call cmdLimpiar
        Case 4
            Call Buscar
        Case 5         '"Salir"
            Unload Me
    End Select
End Sub

Public Function PGrabarGrpCar() As Boolean
   Dim Fila       As Long
   Dim imax       As Long
   Dim Sql        As String
   PGrabarGrpCar = False
   imax = Table1.Rows - 1
   With Table1
      .Col = 1
      For Fila = 1 To imax
         Envia = Array()
         AddParam Envia, .TextMatrix(Fila, 0)
         AddParam Envia, .TextMatrix(Fila, 1)
         If Not BAC_SQL_EXECUTE("Sp_MDRCGrabarGruposCarteras", Envia) Then
            Exit Function
         End If
      Next Fila
End With
PGrabarGrpCar = True
End Function
