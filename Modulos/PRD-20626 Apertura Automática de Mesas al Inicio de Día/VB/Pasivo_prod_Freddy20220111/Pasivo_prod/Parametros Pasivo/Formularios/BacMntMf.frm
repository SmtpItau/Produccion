VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "threed32.ocx"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form BacMntMF 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Mantenedor de Formas de Pago por Monedas"
   ClientHeight    =   4500
   ClientLeft      =   5985
   ClientTop       =   2445
   ClientWidth     =   6285
   Icon            =   "BacMntMf.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4500
   ScaleWidth      =   6285
   ShowInTaskbar   =   0   'False
   Begin VB.PictureBox ConCheck 
      BorderStyle     =   0  'None
      Height          =   345
      Index           =   0
      Left            =   975
      Picture         =   "BacMntMf.frx":2EFA
      ScaleHeight     =   345
      ScaleWidth      =   405
      TabIndex        =   8
      Top             =   4515
      Visible         =   0   'False
      Width           =   405
   End
   Begin VB.PictureBox SinCheck 
      BorderStyle     =   0  'None
      Height          =   330
      Index           =   0
      Left            =   150
      Picture         =   "BacMntMf.frx":3054
      ScaleHeight     =   330
      ScaleWidth      =   375
      TabIndex        =   7
      Top             =   4500
      Visible         =   0   'False
      Width           =   375
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   6
      Top             =   0
      Width           =   6285
      _ExtentX        =   11086
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
         Left            =   5460
         Top             =   -30
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   24
         ImageHeight     =   24
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   12
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntMf.frx":31AE
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntMf.frx":3615
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntMf.frx":3B0B
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntMf.frx":3F9E
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntMf.frx":4486
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntMf.frx":4999
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntMf.frx":4E6C
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntMf.frx":5332
               Key             =   ""
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntMf.frx":5829
               Key             =   ""
            EndProperty
            BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntMf.frx":5C22
               Key             =   ""
            EndProperty
            BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntMf.frx":6018
               Key             =   ""
            EndProperty
            BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntMf.frx":6555
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin Threed.SSPanel SSPanel1 
      Height          =   4050
      Left            =   0
      TabIndex        =   1
      Top             =   540
      Width           =   6285
      _Version        =   65536
      _ExtentX        =   11086
      _ExtentY        =   7144
      _StockProps     =   15
      BackColor       =   -2147483644
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin VB.Frame Frame2 
         Height          =   1425
         Left            =   60
         TabIndex        =   3
         Top             =   0
         Width           =   6165
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
            Left            =   1620
            Style           =   2  'Dropdown List
            TabIndex        =   14
            Top             =   285
            Width           =   2700
         End
         Begin VB.TextBox txt_codigo_moneda 
            Alignment       =   1  'Right Justify
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
            Left            =   1620
            MaxLength       =   5
            MouseIcon       =   "BacMntMf.frx":6A16
            MousePointer    =   99  'Custom
            TabIndex        =   11
            Top             =   1050
            Visible         =   0   'False
            Width           =   855
         End
         Begin VB.ComboBox CmbMoneda_Pagadora 
            Enabled         =   0   'False
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000007&
            Height          =   330
            Left            =   2550
            Style           =   1  'Simple Combo
            TabIndex        =   10
            Text            =   "CmbMoneda_Pago"
            Top             =   1065
            Visible         =   0   'False
            Width           =   3555
         End
         Begin VB.ComboBox CmbMoneda_Pago 
            Enabled         =   0   'False
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000007&
            Height          =   330
            Left            =   2550
            Style           =   1  'Simple Combo
            TabIndex        =   9
            Top             =   660
            Width           =   3555
         End
         Begin VB.TextBox TxtCodigo 
            Alignment       =   1  'Right Justify
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
            Left            =   1620
            MaxLength       =   5
            MouseIcon       =   "BacMntMf.frx":6D20
            MousePointer    =   99  'Custom
            TabIndex        =   0
            Top             =   645
            Width           =   855
         End
         Begin VB.Label Label2 
            Caption         =   "Sistema"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000007&
            Height          =   255
            Left            =   75
            TabIndex        =   13
            Top             =   330
            Width           =   1455
         End
         Begin VB.Label lbl_moneda_pagadora 
            Caption         =   "Moneda Pagadora"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000007&
            Height          =   225
            Left            =   75
            TabIndex        =   12
            Top             =   1095
            Visible         =   0   'False
            Width           =   1560
         End
         Begin VB.Label lbl_moneda 
            Caption         =   "Moneda"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000007&
            Height          =   255
            Left            =   75
            TabIndex        =   4
            Top             =   735
            Width           =   1485
         End
      End
      Begin Threed.SSFrame Frame 
         Height          =   2580
         Index           =   1
         Left            =   30
         TabIndex        =   5
         Top             =   1395
         Width           =   6165
         _Version        =   65536
         _ExtentX        =   10874
         _ExtentY        =   4551
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
         Begin MSFlexGridLib.MSFlexGrid grilla 
            Height          =   2355
            Left            =   60
            TabIndex        =   2
            Top             =   135
            Width           =   6015
            _ExtentX        =   10610
            _ExtentY        =   4154
            _Version        =   393216
            Cols            =   3
            RowHeightMin    =   315
            BackColor       =   -2147483644
            ForeColor       =   8388608
            BackColorFixed  =   8421376
            ForeColorFixed  =   16777215
            BackColorSel    =   8388608
            ForeColorSel    =   16777215
            BackColorBkg    =   12632256
            GridColor       =   0
            FocusRect       =   0
            GridLines       =   2
            GridLinesFixed  =   0
            ScrollBars      =   2
            SelectionMode   =   1
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
      End
   End
End
Attribute VB_Name = "BacMntMF"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim Nada                As Integer
Dim i                   As Integer
Dim OptLocal            As String
Private objProducto     As New clsCodigo
Private objMoneda       As New clsMoneda
Private objcoigo        As New clsCodigo
Private objForPago      As New clsForPago
Dim IniGrilla           As Integer

Private Function FUNC_BUSCAR_DATOS()
        Call PROC_Habilitacontroles(True)

         grilla.Row = 1
         grilla.ColSel = grilla.Cols - 1

         grilla.Redraw = True

         grilla.Enabled = True



         objForPago.CargaObjectos grilla, 1
         Toolbar1.Buttons(3).Enabled = objForPago.CargaxMoneda(CDbl(txtCodigo.Text), IIf(Me.txt_codigo_moneda.Visible = True, Val(Me.txt_codigo_moneda.Text), CDbl(txtCodigo.Text)), grilla, 1, right(Cmb_Sistema.Text, 5))
         grilla.Redraw = False
         grilla.Redraw = True
         grilla.Row = 1

         Call PROC_CargaOptions

         grilla.Row = 1
         grilla.ColSel = grilla.Cols - 1

         grilla.Redraw = True
         
         If grilla.Rows > grilla.FixedRows Then
            grilla.Enabled = True
         
         End If
         
End Function

Private Sub PROC_Habilitacontroles(Valor As Boolean)

   txtCodigo.Enabled = Not Valor
   txt_codigo_moneda.Enabled = Not Valor
   Cmb_Sistema.Enabled = Not Valor
   grilla.Enabled = Valor
   Toolbar1.Buttons(2).Enabled = Valor
   Toolbar1.Buttons(3).Enabled = Valor
   Toolbar1.Buttons(4).Enabled = Not Valor
   Screen.MousePointer = 0

End Sub

Private Sub PROC_LIMPIAR()

   Screen.MousePointer = 11

   Call PROC_Habilitacontroles(False)

   grilla.Enabled = False
   objForPago.CargaObjectos grilla, 1

   Call BacLimpiaGrilla(grilla)

   txtCodigo = ""
   CmbMoneda_Pago.ListIndex = -1
   txtCodigo.SetFocus

   Screen.MousePointer = 0

End Sub

Private Sub Cmb_Sistema_Click()
If right(Cmb_Sistema.Text, 3) = "SWP" Then
    lbl_moneda_pagadora.Visible = True
    txt_codigo_moneda.Visible = True
    CmbMoneda_Pagadora.Visible = True
Else
    lbl_moneda_pagadora.Visible = False
    txt_codigo_moneda.Visible = False
    CmbMoneda_Pagadora.Visible = False

End If
End Sub


Private Sub Form_Activate()
   
   PROC_CARGA_AYUDA Me, " "
   If Nada = 1 Then
      
      Unload Me

   End If
   
   If Cmb_Sistema.Enabled Then
      Cmb_Sistema.SetFocus
   End If

   Me.MousePointer = 0
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)

   On Error GoTo Errores

   Dim iOpcion       As Integer

   iOpcion = 0

   If KeyCode = vbKeyReturn Then
      KeyCode = 0
      Bac_SendKey vbKeyTab
      Exit Sub

   End If

   If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) Then
      Select Case KeyCode
      Case vbKeyLimpiar
         iOpcion = 1

      Case vbKeyGrabar
         iOpcion = 2

      Case vbKeyEliminar
         iOpcion = 3

      Case vbKeyBuscar
         iOpcion = 4

      Case vbKeySalir
         iOpcion = 5

      End Select

      If iOpcion <> 0 Then
         If Toolbar1.Buttons(iOpcion).Enabled Then
            Call Toolbar1_ButtonClick(Toolbar1.Buttons(iOpcion))

         End If

         KeyCode = 0

      End If

   End If

   On Error GoTo 0

   Exit Sub

Errores:

   Resume Next
   On Error GoTo 0

End Sub

Private Sub Form_Load()

   OptLocal = Opt
   Me.top = 0
   Me.left = 0
   mon = 1000

   Call LogAuditoria("07", OptLocal, Me.Caption, "", "")

   Call PROC_LimpiarDatos
   

  If BAC_SQL_EXECUTE("SP_CON_SISTEMA") Then
        
    Do While BAC_SQL_FETCH(Datos())
       
       Cmb_Sistema.AddItem (Datos(2) & Space(150) & Datos(1))
    Loop
  End If
     
  Cmb_Sistema.ListIndex = 0
 
  Me.MousePointer = 0

End Sub

Private Sub Form_Unload(Cancel As Integer)

   Me.MousePointer = 0
   Call LogAuditoria("08", OptLocal, Me.Caption, "", "")

End Sub

Private Sub Frame_Click(Index As Integer)

   Bac_SendKey (vbKeyTab)

End Sub

Private Sub Frame2_Click()

   Bac_SendKey (vbKeyTab)

End Sub

Private Sub Grilla_Click()

   If IniGrilla = 1 Then
      With grilla
         .CellPictureAlignment = 4

         If .Col = 1 Then
            .Col = 2

            If Trim$(.Text) <> "" Then
               .Col = 1

               If Trim(.Text) = "X" Then
                  .Text = ""
                  .Col = 1
                  Set .CellPicture = SinCheck(0).Picture
                  .ColSel = .Cols - 1

               Else
                  .Text = Space(100) + "X"
                  .Col = 1
                  Set .CellPicture = ConCheck(0).Picture
                  .ColSel = .Cols - 1

               End If

            End If

         End If

         If .Col = 2 Then
            If Trim$(.Text) <> "" Then
               .Col = 1

               If Trim(.Text) = "X" Then
                  .Text = " "
                  .Col = 1
                  Set .CellPicture = SinCheck(0).Picture
                  .ColSel = .Cols - 1

               Else
                  .Text = Space(100) + "X"
                  .Col = 1
                  Set .CellPicture = ConCheck(0).Picture
                  .ColSel = .Cols - 1

               End If

            End If

         End If

      End With

   Else
      IniGrilla = 1

   End If

End Sub

Private Sub Grilla_KeyPress(KeyAscii As Integer)

   Call Grilla_Click

End Sub

Private Sub Label1_Click()

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

   Dim iError        As Integer

   Select Case Button.Index
   Case 4
    ' TxtCodigo_LostFocus
    ' VALIDAR LOS CODIGOS
     If (Val(txtCodigo.Text) <> 0 And right(Cmb_Sistema.Text, 3) <> "SWP") Or (Val(txtCodigo.Text) <> 0 And Val(Me.txt_codigo_moneda.Text) <> 0 And right(Cmb_Sistema.Text, 3) = "SWP") Then
         If right(Cmb_Sistema.Text, 3) <> "" Then
            Call FUNC_BUSCAR_DATOS
            If grilla.Rows > grilla.FixedRows Then
               grilla.Enabled = True
            End If
         End If
     End If
   Case 1
      Call PROC_LimpiarDatos
      txtCodigo.SetFocus

   Case 2
      Screen.MousePointer = 11

      iError = True

      For i = 1 To grilla.Rows - 1
         If Trim(grilla.TextMatrix(i, 1)) = "X" Then
            CODI = Len(CmbMoneda_Pago.Text)
            codipag = IIf(Me.txt_codigo_moneda.Visible = True, Val(txt_codigo_moneda.Text), CDbl(txtCodigo.Text))
            CODI = CDbl(txtCodigo.Text)
            iError = Not objMoneda.GrabarxProductos(right(Cmb_Sistema.Text, 3), CDbl(grilla.TextMatrix(i, 0)), objProducto.codigo, "1")

         Else
            If Trim$(grilla.TextMatrix(i, 0)) <> "" Then
               CODI = Len(CmbMoneda_Pago.Text)
               codipag = CDbl(Mid(CmbMoneda_Pago.Text, (CODI - 3), CODI))
               CODI = CDbl(txtCodigo.Text)
               iError = Not objMoneda.BorrarxProductos(CDbl(grilla.TextMatrix(i, 0)), objProducto.codigo, right(Cmb_Sistema.Text, 3))

            End If

         End If

         If iError Then
            Exit For

         End If

      Next i

      If iError Then
         MsgBox "No se puede continúar Actualizando", vbExclamation
         Call LogAuditoria("01", OptLocal, Me.Caption + " Error al grabar- Codigo: " & txtCodigo.Text, "", "")

      Else
         MsgBox "Grabación se realizó con exito", 64
         Call LogAuditoria("01", OptLocal, Me.Caption, "", "Codigo: " & txtCodigo.Text)
         Call PROC_LimpiarDatos

         txtCodigo.SetFocus

      End If

      Screen.MousePointer = 0

   Case 3
      If (MsgBox("¿Seguro que desea eliminar todos los campos marcados?", vbQuestion + vbYesNo)) = vbYes Then
         Screen.MousePointer = 11

         iError = False
         grilla.Redraw = False
         grilla.Row = 1

         For i = 1 To grilla.Rows - 1
            CODI = Len(CmbMoneda_Pago.Text)
            codipag = IIf(Me.txt_codigo_moneda.Visible = True, Val(txt_codigo_moneda.Text), CDbl(txtCodigo.Text))
            CODI = CDbl(txtCodigo.Text)
            iError = Not objMoneda.BorrarxProductos(CDbl(grilla.TextMatrix(i, 0)), objProducto.codigo, right(Cmb_Sistema.Text, 3))

            If iError Then
               Exit For

            End If

         Next i

         grilla.ColSel = grilla.Cols - 1
         grilla.Redraw = True

         If iError Then
            MsgBox "Error al eliminar", vbInformation
            Call LogAuditoria("03", OptLocal, Me.Caption + " Error al eliminar- Codigo: " + txtCodigo.Text, "", "")

         Else
            MsgBox "Eliminación se realizó con exito", 64
            Call LogAuditoria("03", OptLocal, Me.Caption, "Codigo: " & txtCodigo.Text, "")
            Call PROC_LimpiarDatos
            txtCodigo.SetFocus

         End If

         Screen.MousePointer = 0

      Else
         Exit Sub

      End If

   Case 5
      Unload Me

   End Select

End Sub

Private Sub txt_codigo_moneda_DblClick()
  IniGrilla = 0

   BacControlWindows 100
   MiTag = "MDMN_U"
   BacAyuda.Show 1

   If giAceptar% = True Then
      txt_codigo_moneda.Text = gsCodigo
      Call txt_codigo_moneda_LostFocus

   End If

   MousePointer = 0

End Sub

Private Sub txt_codigo_moneda_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      Call txt_codigo_moneda_LostFocus

   End If

   If KeyCode = vbKeyF3 Then
      Call txt_codigo_moneda_DblClick

   End If
End Sub

Private Sub txt_codigo_moneda_KeyPress(KeyAscii As Integer)
   BacSoloNumeros KeyAscii

   If KeyAscii = vbKeyReturn Then
      Call txt_codigo_moneda_LostFocus

   End If

End Sub

Private Sub txt_codigo_moneda_LostFocus()
   grilla.Enabled = False

   If txt_codigo_moneda.Text <> "" Then
      If CDbl(txt_codigo_moneda.Text) > 0 Then
         grilla.Redraw = False

         If Not objMoneda.LeerxCodigo(CDbl(txt_codigo_moneda.Text)) Then
            MsgBox "No existe Codigo", vbInformation
            grilla.Enabled = True
            Exit Sub

         End If

         Call objMoneda.CargaObjectos(CmbMoneda_Pagadora, "PAGADORA", 0)

         CmbMoneda_Pagadora.AddItem left(objMoneda.mnglosa & Space(80), 80) & "  " & objMoneda.mncodigo
         CmbMoneda_Pagadora.ItemData(CmbMoneda_Pagadora.NewIndex) = objMoneda.mncodigo
         CmbMoneda_Pagadora.ListIndex = 0
         CmbMoneda_Pagadora.Tag = CmbMoneda_Pagadora.ItemData(CmbMoneda_Pagadora.ListIndex)
         
     

      End If

   End If

   grilla.Redraw = True

   If grilla.Enabled Then
      DoEvents
      IniGrilla = 1
      grilla.SetFocus
   
   End If

   If grilla.Rows > grilla.FixedRows + 1 Then
      grilla.Enabled = True
   
   End If


End Sub

Private Sub txtCodigo_DblClick()

   IniGrilla = 0

   BacControlWindows 100
   MiTag = "MDMN_U"
   BacAyuda.Show 1

   If giAceptar% = True Then
      txtCodigo.Text = gsCodigo
      Call TxtCodigo_LostFocus

   End If

   MousePointer = 0

End Sub

Private Sub TxtCodigo_KeyDown(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then
      Call TxtCodigo_LostFocus

   End If

   If KeyCode = vbKeyF3 Then
      Call txtCodigo_DblClick

   End If

End Sub

Private Sub txtCodigo_KeyPress(KeyAscii As Integer)

   BacSoloNumeros KeyAscii

   If KeyAscii = vbKeyReturn Then
      Call TxtCodigo_LostFocus

   End If

End Sub

Private Sub TxtCodigo_LostFocus()

   grilla.Enabled = False

   If txtCodigo.Text <> "" Then
      If CDbl(txtCodigo.Text) > 0 Then
         grilla.Redraw = False

         If Not objMoneda.LeerxCodigo(CDbl(txtCodigo.Text)) Then
            MsgBox "No existe Codigo", vbInformation
            grilla.Enabled = True
            Exit Sub

         End If

         Call objMoneda.CargaObjectos(CmbMoneda_Pago, "PAGADORA", 0)

         CmbMoneda_Pago.AddItem left(objMoneda.mnglosa & Space(80), 80) & "  " & objMoneda.mncodigo
         CmbMoneda_Pago.ItemData(CmbMoneda_Pago.NewIndex) = objMoneda.mncodigo
         CmbMoneda_Pago.ListIndex = 0
         CmbMoneda_Pago.Tag = CmbMoneda_Pago.ItemData(CmbMoneda_Pago.ListIndex)
         
     

      End If

   End If

   grilla.Redraw = True
   
   If grilla.Enabled Then
      DoEvents
      IniGrilla = 1
      grilla.SetFocus
   
   End If

   If grilla.Rows > grilla.FixedRows + 1 Then
      grilla.Enabled = True
   
   End If

End Sub


Private Function PROC_SeteoGrilla(Grillas As Object)

   With Grillas
      .Redraw = False
      .Enabled = True
      .FixedCols = 1
      .FixedRows = 1
      .RowHeight(0) = 320
      .CellFontWidth = 3         ' TAMAÑO

      .ColWidth(0) = 75
      .ColWidth(1) = 1500
      .ColWidth(2) = 4300

      .Rows = 2
      .Row = 0

      .Col = 1
      .FixedAlignment(1) = 4
      .CellFontBold = True       'RESALSE
      .Text = "Marca"
      .ColAlignment(1) = 4

      .Col = 2
      .FixedAlignment(2) = 4
      .CellFontBold = True       'RESALSE
      .Text = "Descripción "

      .Row = 1
      .Col = 1
      .Redraw = True

   End With

End Function

Private Sub PROC_CargaOptions()

   With grilla
      .Redraw = False
      .Enabled = True

      For i = 1 To .Rows - 1
         .Row = i

         .CellPictureAlignment = 4

         If Trim(.TextMatrix(i, 1)) = "X" Then
            .Col = 1
            Set .CellPicture = ConCheck(0).Picture
            .Text = Space(100) + "X"

         Else
            Set .CellPicture = SinCheck(0).Picture

         End If

      Next i

      If .TextMatrix(.Rows - 1, 2) = "" Then
         .Rows = .Rows - 1

      End If

      .Redraw = True

   End With

End Sub

Private Sub PROC_LimpiarDatos()

   grilla.Clear

   mon = 1000

   Call PROC_SeteoGrilla(grilla)

   Nada = 0

   If Not objMoneda.CargaObjectos(CmbMoneda_Pago, "PAGADORA") Then
      MsgBox "No hay Moneda Pagadoras Disponibles, verifique ...", vbInformation
      Me.MousePointer = 0
      Nada = 1
      Exit Sub

   End If

   If Not objMoneda.CargaObjectos(CmbMoneda_Pagadora, "PAGADORA") Then
      MsgBox "No hay Moneda Pagadoras Disponibles, verifique ...", vbInformation
      Me.MousePointer = 0
      Nada = 1
      Exit Sub

   End If
   txtCodigo.Text = ""
   txt_codigo_moneda.Text = ""
   Cmb_Sistema.ListIndex = -1
   Call PROC_Habilitacontroles(False)

   grilla.ColWidth(0) = 0
   grilla.Enabled = False

End Sub

