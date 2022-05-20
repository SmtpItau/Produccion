VERSION 5.00
Object = "{1C0489F8-9EFD-423D-887A-315387F18C8F}#1.0#0"; "vsflex8l.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "threed32.ocx"
Begin VB.Form BACMNTCR 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Mantenedor de Carteras"
   ClientHeight    =   4530
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   5340
   BeginProperty Font 
      Name            =   "Arial"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "BACMNTCR.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   4530
   ScaleWidth      =   5340
   ShowInTaskbar   =   0   'False
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   5340
      _ExtentX        =   9419
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
         Left            =   4500
         Top             =   0
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
               Picture         =   "BACMNTCR.frx":2EFA
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BACMNTCR.frx":3361
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BACMNTCR.frx":3857
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BACMNTCR.frx":3CEA
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BACMNTCR.frx":41D2
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BACMNTCR.frx":46E5
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BACMNTCR.frx":4BB8
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BACMNTCR.frx":507E
               Key             =   ""
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BACMNTCR.frx":5575
               Key             =   ""
            EndProperty
            BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BACMNTCR.frx":596E
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin Threed.SSFrame Frame 
      Height          =   1410
      Index           =   0
      Left            =   15
      TabIndex        =   1
      Top             =   495
      Width           =   5310
      _Version        =   65536
      _ExtentX        =   9366
      _ExtentY        =   2487
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
      Begin VB.ComboBox cmbtablacartera 
         Height          =   330
         Left            =   1560
         Style           =   2  'Dropdown List
         TabIndex        =   3
         Top             =   300
         Width           =   3255
      End
      Begin VB.ComboBox CmbSubProducto 
         Height          =   330
         Left            =   1560
         Style           =   2  'Dropdown List
         TabIndex        =   2
         Top             =   840
         Width           =   3255
      End
      Begin VB.Label Label1 
         Caption         =   "Producto"
         ForeColor       =   &H80000007&
         Height          =   255
         Index           =   0
         Left            =   240
         TabIndex        =   5
         Top             =   360
         Width           =   840
      End
      Begin VB.Label Label1 
         Caption         =   "SubProducto"
         ForeColor       =   &H80000007&
         Height          =   255
         Index           =   1
         Left            =   240
         TabIndex        =   4
         Top             =   885
         Width           =   1080
      End
   End
   Begin Threed.SSFrame Frame 
      Height          =   2625
      Index           =   1
      Left            =   0
      TabIndex        =   6
      Top             =   1920
      Width           =   5340
      _Version        =   65536
      _ExtentX        =   9419
      _ExtentY        =   4630
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
      Begin VB.TextBox txtIngreso 
         BackColor       =   &H00800000&
         ForeColor       =   &H00FFFFFF&
         Height          =   330
         Left            =   4215
         TabIndex        =   7
         Top             =   2835
         Visible         =   0   'False
         Width           =   1125
      End
      Begin VSFlex8LCtl.VSFlexGrid Table1 
         Height          =   2310
         Left            =   105
         TabIndex        =   12
         Top             =   195
         Width           =   5190
         _cx             =   9155
         _cy             =   4075
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
         FormatString    =   $"BACMNTCR.frx":5D64
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
   Begin Threed.SSFrame Frame 
      Height          =   2025
      Index           =   3
      Left            =   7590
      TabIndex        =   8
      Top             =   1080
      Visible         =   0   'False
      Width           =   2730
      _Version        =   65536
      _ExtentX        =   4815
      _ExtentY        =   3572
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
      ShadowStyle     =   1
      Begin VB.PictureBox Grid1 
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   780
         Left            =   375
         ScaleHeight     =   720
         ScaleWidth      =   2100
         TabIndex        =   9
         Top             =   255
         Width           =   2160
      End
      Begin VB.Label Label 
         BackColor       =   &H00FFFFFF&
         Caption         =   "Label(1)"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   1
         Left            =   420
         TabIndex        =   11
         Top             =   1545
         Width           =   1860
      End
      Begin VB.Label Label 
         BackColor       =   &H00800000&
         Caption         =   "Label(0)"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   285
         Index           =   0
         Left            =   420
         TabIndex        =   10
         Top             =   1200
         Width           =   1860
      End
   End
End
Attribute VB_Name = "BACMNTCR"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private objcodtab       As Object
Private ObjCartera      As Object
Dim iCodProducto As Variant
Dim idSistema    As Variant
Dim nCodigo      As String
Dim ISubproducto As String
Dim ClasifQH    As String

Sub Dibuja_Grilla()

Table1.Cols = 5
Table1.Rows = 2

Table1.TextMatrix(0, 0) = ""
Table1.TextMatrix(0, 1) = "Codigo"
Table1.TextMatrix(0, 2) = "Glosa"
Table1.TextMatrix(0, 3) = "Clasif. Qh"
Table1.TextMatrix(0, 4) = "Grupo Cartera"

Table1.RowHeight(0) = 315

Table1.ColWidth(0) = 0
Table1.ColWidth(1) = 1000
Table1.ColWidth(2) = 3750
Table1.ColWidth(3) = 3000
Table1.ColWidth(4) = 3750

Table1.ColAlignment(1) = 1
Table1.ColAlignment(2) = 1

End Sub


Private Function ValidaGrilla() As Integer

   Dim Filas As Integer

   ValidaGrilla = False

   For Filas = 1 To Table1.Rows - 1

      Table1.Row = Filas

      ' Columna rut
      '-----------------------
      Table1.Col = 1

      If Table1.Rows = 2 Then
         If Table1.TextMatrix(1, 1) = "" And Table1.TextMatrix(1, 2) = "" Then
            Exit For
         End If
      
      End If

      If Table1.Text = "" Then
         MsgBox "Falta Ingresar Código de Cartera", vbInformation
         Exit Function

      End If

      ' Columna nombre
      '--------------------------
      Table1.Col = 2

      If Table1.Text = "" Then
         MsgBox "Falta ingresar nombre cartera", 16
         Exit Function

      End If

   Next Filas

   ValidaGrilla = True


End Function

Private Function HabilitarControles(Valor As Boolean)

   cmbtablacartera.Enabled = Not Valor
   CmbSubProducto.Enabled = Not Valor
   
    Table1.Enabled = Valor
    Toolbar1.Buttons(2).Enabled = Valor
    Toolbar1.Buttons(3).Enabled = Valor
    Toolbar1.Buttons(4).Enabled = Not Valor
End Function

Private Sub Limpiar()

   Table1.Clear
   Table1.Rows = 2

   cmbtablacartera.ListIndex = -1
   CmbSubProducto.ListIndex = -1

   Dibuja_Grilla
   HabilitarControles (False)
   cmbtablacartera.SetFocus
End Sub





Private Function ValidaAgr() As Integer

   Dim f As Long

   ValidaAgr = False

   For f = 1 To Table1.Rows

      Table1.Row = f

      'Columna del código
      '------------------------------
      Table1.Col = 1

      If Val(Table1.Text) = 0 Then
         ValidaAgr = True
         Exit For

      End If

      'Descripción del código
      '------------------------------
      Table1.Col = 2

      If Trim$(Table1.Text) = "" Then
         ValidaAgr = True
         Exit For

      End If

   Next f

End Function

Private Function Buscar()
 Dim iCodProducto  As Variant
   Dim idSistema     As Variant
   Dim Subproducto   As Variant
   
   Table1.Redraw = False

   If cmbtablacartera.ListIndex > -1 And CmbSubProducto.ListIndex > -1 Then
      'iCodProducto = CmbTablaCartera.ItemData(CmbTablaCartera.ListIndex)
      
      iCodProducto = Trim(Mid(cmbtablacartera.Text, Len(cmbtablacartera.Text) - 9, 7))
      Subproducto = Trim(Mid(CmbSubProducto.Text, Len(CmbSubProducto.Text) - 9, 7))
      iCodProducto = Trim(Mid(cmbtablacartera.Text, Len(cmbtablacartera.Text) - 9, 7))
      idSistema = right(cmbtablacartera.Text, 3)

      If ObjCartera.LeerCarProducto(Subproducto, idSistema, iCodProducto) = False Then
         MsgBox "Problemas al leer carteras por producto", vbCritical
         Exit Function
      End If
      
      Table1.Editable = flexEDKbdMouse
      Call ObjCartera.CargarGrid(Table1)
      
      Call HabilitarControles(True)
      
      
      If Table1.Rows = 1 Then
         Table1.Rows = 2
      Else
         Table1.Row = 1
         Table1.Col = 1
      End If
      
      Table1.SetFocus

   End If
   
   Table1.Redraw = True
End Function

Private Sub CmbSubProducto_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = 13 Then
    Me.cmbtablacartera.SetFocus
End If

End Sub

Private Sub CmbTablaCartera_Click()

CmbSubProducto.Clear

Envia = Array()
AddParam Envia, Trim(left(right(Trim(Me.cmbtablacartera.Text), 8), 5))

If BAC_SQL_EXECUTE("SP_CON_BuscaSubproducto", Envia) Then
      
         Do While BAC_SQL_FETCH(Datos())
         
            If Datos(1) <> "NO TIENE" Then
               
               Me.CmbSubProducto.AddItem (Datos(2)) + Space(80) + Datos(1) + Datos(3)
            
            End If
         
         Loop
End If

If Not CmbSubProducto.ListCount = 0 Then
   Me.CmbSubProducto.ListIndex = 0

End If

End Sub

Private Sub cmbtablacartera_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = 13 Then
    Me.CmbSubProducto.SetFocus
End If
End Sub

Private Sub cmdEliminar()

   Dim A As Integer
   Dim iok          As Integer
   
   Dim Sql          As String

   If Table1.Row < 1 Then
      Exit Sub
   End If

   With Table1
      .Row = Table1.Row
      .Col = 1:  nCodigo = .Text
   End With

   'iCodProducto = CmbTablaCartera.ItemData(CmbTablaCartera.ListIndex)
   
   iCodProducto = Trim(Mid(cmbtablacartera.Text, Len(cmbtablacartera.Text) - 7, 5))
   ISubproducto = Trim(Mid(Me.CmbSubProducto.Text, Len(Me.CmbSubProducto.Text) - 9, 7))
   idSistema = right(cmbtablacartera.Text, 3)
   
   iok = MsgBox("¿Seguro de eliminar CARTERAS?", vbInformation + vbYesNo)

   Select Case iok
   Case vbYes
      Call ObjCartera.EliminarCar(iCodProducto, idSistema, nCodigo, ISubproducto)
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
    
   'iCodProducto = CmbTablaCartera.ItemData(CmbTablaCartera.ListIndex)
   
   iCodProducto = Trim(Mid(cmbtablacartera.Text, Len(cmbtablacartera.Text) - 7, 5))
   idSistema = right(cmbtablacartera.Text, 3)
   ISubproducto = IIf(Trim(Mid(Me.CmbSubProducto.Text, Len(Me.CmbSubProducto.Text) - 7, 5)) = "", 0, Trim(Mid(Me.CmbSubProducto.Text, Len(Me.CmbSubProducto.Text) - 9, 7)))
   
   Call ObjCartera.EliminarCar(iCodProducto, idSistema, nCodigo, ISubproducto)
   
   If PGrabarCar(iCodProducto, idSistema, ISubproducto) = False Then
      
      MsgBox "No se puede grabar en tabla carteras", 16

   Else
      
      MsgBox "Grabación se realizó con exito", 64
      Call ObjCartera.LimpiarTodos
      Call Limpiar
      Call HabilitarControles(False)
   
   End If

   cmbtablacartera.SetFocus

End Sub


Private Sub cmdLimpiar()

   Call ObjCartera.LimpiarTodos
   Call Limpiar
   Call HabilitarControles(False)
   
   Dibuja_Grilla
    txtIngreso.Text = ""
    txtIngreso.Visible = False
   cmbtablacartera.SetFocus

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
   
   Set objcodtab = New clscodtabs
   Set ObjCartera = New clsCarte
   
   If BAC_SQL_EXECUTE("SP_BACMNTCR_BUSCAPRODUCTO") Then
      
         Do While BAC_SQL_FETCH(Datos())
         
            If Datos(1) <> "ERROR" Then
               
               cmbtablacartera.AddItem (Datos(2)) + Space(80) + Datos(1) + Datos(3)
            
            End If
         
         Loop
   End If
 
   
   Call HabilitarControles(False)


End Sub

Private Sub Form_Unload(Cancel As Integer)
    Set objcodtab = Nothing

End Sub


Private Sub Table1_EnterEdit()

   Label(1).Caption = "E"

End Sub


Private Sub Table1_ExitEdit()

   Label(1).Caption = ""

End Sub

Private Sub GrillaFlujos_Click()

End Sub

Private Sub Table1_KeyDown(KeyCode As Integer, Shift As Integer)
   
   Dim bOk        As Boolean
   Dim nOk        As Integer

   Select Case KeyCode
   Case vbKeyInsert
      Table1.Rows = Table1.Rows + 1
      Table1.Row = Table1.Rows - 1
      Table1.Refresh

   Case vbKeyDelete

      If Table1.Rows > 2 Then
         Table1.RemoveItem Table1.Row

      Else
         Table1.Rows = 1
         Table1.Rows = 2

      End If

   End Select

End Sub





Private Sub Table1_KeyPress(KeyAscii As Integer)

   KeyAscii = Caracter(KeyAscii)
   
   If Not IsNumeric(Chr(KeyAscii)) And UCase(Chr(KeyAscii)) < "A" And UCase(Chr(KeyAscii)) > "Z" And KeyAscii <> 13 And KeyAscii <> 8 Then
       KeyAscii = 0
   End If
      
      If Table1.Col = 1 Or Table1.Col = 3 Then
         txtIngreso.MaxLength = 1
      Else
         txtIngreso.MaxLength = 40
      
      End If
      
      If KeyAscii = 13 Then
         txtIngreso.Text = Table1.Text
      Else
        If Me.Table1.Col = 1 And Not IsNumeric(Chr(KeyAscii)) Then
            txtIngreso.Text = ""
        Else
          KeyAscii = Asc(UCase(Chr(KeyAscii)))
          txtIngreso.Text = Chr(KeyAscii)
        End If
      End If
      
      
      PROC_POSICIONA_TEXTO Table1, txtIngreso
      
      txtIngreso.Visible = True

      txtIngreso.SetFocus
      
      Bac_SendKey (vbKeyEnd)

End Sub

Private Sub Table1_Scroll()

   txtIngreso_KeyDown vbKeyEscape, 0
   cmbtablacartera_KeyDown vbKeyEscape, 0

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

Private Sub txtIngreso_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = 27 Then
    txtIngreso.Visible = False
    If Table1.Enabled Then Table1.SetFocus
End If
End Sub

Private Sub txtIngreso_KeyPress(KeyAscii As Integer)

KeyAscii = Caracter(KeyAscii)

If KeyAscii = 27 Then

   txtIngreso.Visible = False
   Table1.SetFocus
   
End If

    If Table1.Col = 1 Then
        KeyAscii = BacPunto(txtIngreso, KeyAscii, 5, 0)
    Else
        KeyAscii = Asc(UCase(Chr(KeyAscii)))
    End If
    
    KeyAscii = Asc(UCase(Chr(KeyAscii)))
    
If KeyAscii = 13 Then

'    If Trim(txtIngreso.Text) = "" Then Exit Sub
    If Table1.Col = 1 Then
       Call PVerCodigo
    End If
     
    Table1.Text = txtIngreso.Text
    txtIngreso.Visible = False
    If Table1.Col = 1 Then
        Table1.Col = 2
    ElseIf Table1.Col = 2 Then
        Table1.Col = 3
    Else
         Table1.Col = 1
    End If
    Table1.TopRow = Table1.Row
    Table1.SetFocus

End If
End Sub
Public Function PGrabarCar(iCodProducto, idSistema As Variant, nCodigo As Variant) As Boolean

   Dim Fila       As Long
   Dim imax       As Long
   Dim Sql        As String

   PGrabarCar = False
   imax = Table1.Rows - 1
   
   With Table1
      
      .Col = 1
      
      For Fila = 1 To imax
          
          '.Row = Fila

' Set objBuffer = New clsCarte
           
'''''''''''''''''''''''           Sql = "EXECUTE sp_mdrcgrabar " & Chr(10)
'''''''''''''''''''''''           Sql = Sql & iCodProducto & "," & Chr(10)
'''''''''''''''''''''''          .Col = 1: Sql = Sql & .Text & "," & Chr(10)
'''''''''''''''''''''''          .Col = 2: Sql = Sql & "'" & .Text & "'"
         
         Envia = Array()
         
         'AddParam Envia, nCodigo
         AddParam Envia, idSistema
         AddParam Envia, .TextMatrix(Fila, 1)
         AddParam Envia, .TextMatrix(Fila, 2)
         AddParam Envia, iCodProducto
         AddParam Envia, .TextMatrix(Fila, 3)
         AddParam Envia, .TextMatrix(Fila, 4)
         
         If Not BAC_SQL_EXECUTE("sp_mdrcgrabar", Envia) Then
            
            Exit Function
         
         End If
     ' coleccion.Add objBuffer
     ' Set objBuffer = Nothing
      
      Next Fila

End With

PGrabarCar = True

End Function


Public Function PVerCodigo()

   Dim Fila       As Long
   Dim imax       As Long
   Dim Sql        As String

   imax = Table1.Rows - 1
   With Table1
      For Fila = 1 To imax
          
          If txtIngreso.Text = .TextMatrix(Fila, 1) And Not Fila = .Row Then
             MsgBox "Codigo " & .Text & " ya existe en tabla", vbCritical
             .TextMatrix(Table1.Rows - 1, 1) = ""
             txtIngreso.Text = ""
             txtIngreso.SetFocus
             Exit Function
          End If
      Next Fila
   End With

End Function



Private Sub txtIngreso_LostFocus()


   txtIngreso_KeyDown vbKeyEscape, 0
   cmbtablacartera_KeyDown vbKeyEscape, 0

End Sub
