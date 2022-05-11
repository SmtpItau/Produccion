VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form FRM_MNT_CANAL_FPAGO 
   Caption         =   "Mantenedor de Canal de Envío por Forma de Pago."
   ClientHeight    =   3195
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6345
   LinkTopic       =   "Form2"
   MDIChild        =   -1  'True
   ScaleHeight     =   3195
   ScaleWidth      =   6345
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   6345
      _ExtentX        =   11192
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Buscar  /  Actualizar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Cerrar"
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   4755
         Top             =   15
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   3
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_CANAL_FPAGO.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_CANAL_FPAGO.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_CANAL_FPAGO.frx":1DB4
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame Frame1 
      Height          =   2745
      Left            =   0
      TabIndex        =   1
      Top             =   435
      Width           =   6330
      Begin VB.ComboBox cmbFPago 
         BackColor       =   &H80000002&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000009&
         Height          =   330
         Left            =   1215
         Style           =   2  'Dropdown List
         TabIndex        =   5
         Top             =   825
         Visible         =   0   'False
         Width           =   900
      End
      Begin VB.TextBox txtTextGrilla 
         BackColor       =   &H80000002&
         BorderStyle     =   0  'None
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000009&
         Height          =   210
         Left            =   3255
         TabIndex        =   4
         Top             =   870
         Visible         =   0   'False
         Width           =   930
      End
      Begin BACControles.TXTNumero txtNumGrilla 
         Height          =   210
         Left            =   2220
         TabIndex        =   3
         Top             =   870
         Visible         =   0   'False
         Width           =   915
         _ExtentX        =   1614
         _ExtentY        =   370
         BackColor       =   -2147483646
         ForeColor       =   -2147483639
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
         BorderStyle     =   0
         Text            =   "0"
         Text            =   "0"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin MSFlexGridLib.MSFlexGrid Grid 
         Height          =   2565
         Left            =   75
         TabIndex        =   2
         Top             =   135
         Width           =   6210
         _ExtentX        =   10954
         _ExtentY        =   4524
         _Version        =   393216
         Rows            =   3
         Cols            =   4
         FixedRows       =   2
         FixedCols       =   0
         RowHeightMin    =   315
         BackColor       =   -2147483644
         BackColorFixed  =   -2147483646
         ForeColorFixed  =   -2147483639
         BackColorSel    =   -2147483646
         BackColorBkg    =   -2147483638
         FocusRect       =   0
         GridLines       =   2
         GridLinesFixed  =   0
         AllowUserResizing=   1
         FormatString    =   ""
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
   End
End
Attribute VB_Name = "FRM_MNT_CANAL_FPAGO"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub NombresGrilla()
   Grid.TextMatrix(0, 0) = "Código":      Grid.TextMatrix(1, 0) = "Forma Pago"
   Grid.TextMatrix(0, 1) = "Forma":       Grid.TextMatrix(1, 1) = "Pago"
   Grid.TextMatrix(0, 2) = "Código":      Grid.TextMatrix(1, 2) = "Canal Envío"
   Grid.TextMatrix(0, 3) = "Descripción": Grid.TextMatrix(1, 3) = "Canal Envío"
   
   Grid.ColWidth(0) = 0
   Grid.ColWidth(1) = 2000
   Grid.ColWidth(2) = 1500
   Grid.ColWidth(3) = 2000
   
   Grid.Font.Size = 8
   Grid.Font.Bold = True
   Grid.Font.Name = "Arial"
   
   Grid.ColAlignment(1) = 2
   Grid.ColAlignment(3) = 2
   
End Sub
Private Sub CargarFormasPago()
   On Error GoTo ErrorCargaFPAgo
   Dim Datos()
   
   Envia = Array()
   AddParam Envia, CDbl(5)
   If Not Bac_Sql_Execute("SP_FPAGO_CANAL", Envia) Then
      GoTo ErrorCargaFPAgo
   End If
   cmbFPago.Clear
   Do While Bac_SQL_Fetch(Datos())
      cmbFPago.AddItem UCase(Datos(2))
      cmbFPago.ItemData(cmbFPago.NewIndex) = Datos(1)
   Loop
   
Exit Sub
ErrorCargaFPAgo:
   MsgBox Err.Description, vbExclamation, TITSISTEMA
End Sub

Private Sub CargarFPago()
   On Error GoTo ErrorCargaFPAgo
   Dim Datos()
   
   Envia = Array()
   AddParam Envia, CDbl(4)
   If Not Bac_Sql_Execute("SP_FPAGO_CANAL", Envia) Then
      GoTo ErrorCargaFPAgo
   End If
   Grid.Enabled = False
   Grid.Rows = 2
   Do While Bac_SQL_Fetch(Datos())
      Grid.Enabled = True
      Grid.Rows = Grid.Rows + 1
      Grid.TextMatrix(Grid.Rows - 1, 0) = Val(Datos(1))
      Grid.TextMatrix(Grid.Rows - 1, 1) = UCase(CStr(Trim(Datos(2))))
   Loop
   
Exit Sub
ErrorCargaFPAgo:
   MsgBox Err.Description, vbExclamation, TITSISTEMA
End Sub

Private Sub CargaCanalEnvio()
   On Error GoTo ErrorCargaCEnvio
   Dim Contador   As Integer
   Dim Datos()

   For Contador = 2 To Grid.Rows - 1
      Envia = Array()
      AddParam Envia, CDbl(1)
      AddParam Envia, CDbl(Grid.TextMatrix(Contador, 0))
      If Not Bac_Sql_Execute("SP_FPAGO_CANAL", Envia) Then
         GoTo ErrorCargaCEnvio
      End If
      If Bac_SQL_Fetch(Datos()) Then
         Grid.TextMatrix(Contador, 2) = Val(Datos(2))
         Grid.TextMatrix(Contador, 3) = UCase(CStr(Trim(Datos(3))))
      Else
         Grid.TextMatrix(Contador, 2) = -1
         Grid.TextMatrix(Contador, 3) = ""
      End If
   Next Contador

Exit Sub
ErrorCargaCEnvio:
   MsgBox Err.Description, vbExclamation, TITSISTEMA
End Sub

Private Sub GrabarDatos()
   On Error GoTo ErrorGrabacion
   Dim Contador   As Integer
   Dim Datos()
   
   Call Bac_Sql_Execute("BEGIN TRANSACTION")
   
   Envia = Array()
   AddParam Envia, CDbl(2)
   If Not Bac_Sql_Execute("SP_FPAGO_CANAL", Envia) Then
      GoTo ErrorGrabacion
   End If
   For Contador = 2 To Grid.Rows - 1
      If CDbl(Grid.TextMatrix(Contador, 2)) <> -1 Then
         Envia = Array()
         AddParam Envia, CDbl(3)
         AddParam Envia, CDbl(Grid.TextMatrix(Contador, 0))
         AddParam Envia, CDbl(Grid.TextMatrix(Contador, 2))
         AddParam Envia, Trim(Grid.TextMatrix(Contador, 3))
         If Not Bac_Sql_Execute("SP_FPAGO_CANAL", Envia) Then
            GoTo ErrorGrabacion
         End If
      End If
   Next Contador
   
   Call Bac_Sql_Execute("COMMIT TRANSACTION")
   
   MsgBox "Actualización de Canales de Envío por Formas de Pago ha Finalizado Correctamente.", vbInformation, TITSISTEMA
Exit Sub
ErrorGrabacion:
   Call Bac_Sql_Execute("ROLLBACK TRANSACTION")
   MsgBox Err.Description, vbExclamation, TITSISTEMA
End Sub

Private Sub cmbFPago_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      Call CtrlObj_Aceptar(Grid, cmbFPago)
      Grid.TextMatrix(Grid.RowSel, Grid.ColSel - 1) = cmbFPago.ItemData(cmbFPago.ListIndex)
   End If
   If KeyCode = vbKeyEscape Then
      Call CtrlObj_Cancelar(cmbFPago)
   End If
End Sub

Private Sub Form_Load()
   Me.Top = 0: Me.Left = 0
   Me.Icon = BACSwapParametros.Icon
   Me.Toolbar1.Buttons(1).Visible = False
   Me.Caption = "Mentenedor de Canales de Envío por Formas de Pago."
   
   Call NombresGrilla
   Call CargarFPago
   Call CargaCanalEnvio
   Call CargarFormasPago
End Sub

Private Sub Form_Resize()
   On Error Resume Next
   Frame1.Width = Me.Width - 150
   Grid.Width = Frame1.Width - 150
   Frame1.Height = Me.Height - 850
   Grid.Height = Frame1.Height - 250
End Sub

Private Sub Grid_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      Select Case Grid.ColSel
         Case 1
            Call CtrlObj_Alinear(Grid, cmbFPago)
         Case 2
            Call CtrlObj_Alinear(Grid, txtNumGrilla)
         Case 3
            Call CtrlObj_Alinear(Grid, txtTextGrilla)
      End Select
   End If
   If KeyCode = vbKeyDelete Then
      If MsgBox("¿ Se encuentra seguro de eliminar el registro seleccionado en forma permanente ?", vbQuestion + vbYesNo, TITSISTEMA) = vbNo Then
         Exit Sub
      End If
      Grid.SetFocus
      If Grid.Rows = 3 Then
         Grid.Rows = 2
         Grid.Rows = 3
      Else
         Grid.RemoveItem (Grid.RowSel)
         If Grid.Rows <= Grid.FixedRows Then
            Grid.Rows = 3
         End If
      End If
   End If
   If KeyCode = vbKeyInsert Then
      If Grid.Rows >= 3 Then
         If Trim(Grid.TextMatrix(Grid.Rows - 1, 1)) <> "" And Val(Trim(Grid.TextMatrix(Grid.Rows - 1, 2))) > 0 Then
            Grid.Rows = Grid.Rows + 1
         Else
            MsgBox "¡ Debe completar los datos requeridos para continuar. !", vbInformation, TITSISTEMA
            Grid.SetFocus
         End If
      End If
   End If
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 1
      Case 2
         Call GrabarDatos
      Case 3
         Unload Me
   End Select
End Sub

Private Sub CtrlObj_Aceptar(nGrid As MSFlexGrid, oTexto As Object)
   nGrid.TextMatrix(nGrid.RowSel, nGrid.ColSel) = oTexto.Text
   oTexto.Visible = False
   
   nGrid.Enabled = True
   Toolbar1.Enabled = True
   Grid.SetFocus
End Sub
Private Sub CtrlObj_Cancelar(oTexto As Object)
   oTexto.Visible = False
   
   Grid.Enabled = True
   Toolbar1.Enabled = True
   Grid.SetFocus
End Sub

Private Sub CtrlObj_Alinear(nGrid As MSFlexGrid, nText As Object)
    On Error Resume Next
    nText.Top = nGrid.Top + nGrid.CellTop + 10
    nText.Left = nGrid.Left + nGrid.CellLeft + 50
    nText.Width = nGrid.CellWidth - 10
    nText.Height = nGrid.CellHeight - 10
    
    nText.Text = nGrid.TextMatrix(nGrid.RowSel, nGrid.ColSel)
    nText.SelStart = Len(nText.Text)
    
    nText.Visible = True
    nText.Enabled = True
    nGrid.Enabled = False
    Toolbar1.Enabled = False
    nText.SetFocus
End Sub

Private Sub txtNumGrilla_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyEscape Then
      Call CtrlObj_Cancelar(txtNumGrilla)
   End If
   If KeyCode = vbKeyReturn Then
      Call CtrlObj_Aceptar(Grid, txtNumGrilla)
   End If
End Sub

Private Sub txtTextGrilla_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyEscape Then
      Call CtrlObj_Cancelar(txtTextGrilla)
   End If
   If KeyCode = vbKeyReturn Then
      Call CtrlObj_Aceptar(Grid, txtTextGrilla)
   End If
End Sub

Private Sub txtTextGrilla_KeyPress(KeyAscii As Integer)
   KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub
