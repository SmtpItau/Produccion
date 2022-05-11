VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacMntTb 
   Caption         =   "Mantenedor de Tablas Generales.-"
   ClientHeight    =   3840
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6375
   LinkTopic       =   "Form2"
   MDIChild        =   -1  'True
   ScaleHeight     =   3840
   ScaleWidth      =   6375
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   2
      Top             =   0
      Width           =   6375
      _ExtentX        =   11245
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   6
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.ToolTipText     =   "Agregar"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Cerrar"
            ImageIndex      =   6
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   4365
         Top             =   30
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   6
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacmnttb.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacmnttb.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacmnttb.frx":1DB4
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacmnttb.frx":2C8E
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacmnttb.frx":3B68
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacmnttb.frx":4A42
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame fraCuadro 
      Height          =   3405
      Left            =   0
      TabIndex        =   3
      Top             =   435
      Width           =   6375
      Begin BACControles.TXTFecha txtIngresoFech 
         Height          =   300
         Left            =   1095
         TabIndex        =   9
         Top             =   1170
         Visible         =   0   'False
         Width           =   1395
         _ExtentX        =   2461
         _ExtentY        =   529
         BackColor       =   -2147483635
         Enabled         =   -1  'True
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   -2147483634
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "16/06/2005"
      End
      Begin VB.TextBox txtIngresoTex 
         BackColor       =   &H8000000D&
         BorderStyle     =   0  'None
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000E&
         Height          =   270
         Left            =   3990
         TabIndex        =   8
         Text            =   "Des"
         Top             =   1185
         Visible         =   0   'False
         Width           =   885
      End
      Begin BACControles.TXTNumero txtIngresoNum 
         Height          =   270
         Left            =   3015
         TabIndex        =   7
         Top             =   1185
         Visible         =   0   'False
         Width           =   915
         _ExtentX        =   1614
         _ExtentY        =   476
         BackColor       =   -2147483635
         ForeColor       =   -2147483634
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
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
         Height          =   2580
         Left            =   45
         TabIndex        =   6
         Top             =   780
         Width           =   6255
         _ExtentX        =   11033
         _ExtentY        =   4551
         _Version        =   393216
         Cols            =   5
         FixedCols       =   0
         RowHeightMin    =   315
         BackColor       =   -2147483644
         ForeColor       =   -2147483641
         BackColorFixed  =   -2147483646
         ForeColorFixed  =   -2147483639
         BackColorBkg    =   -2147483644
         GridColor       =   -2147483644
         GridColorFixed  =   -2147483641
         Enabled         =   0   'False
         FocusRect       =   0
         GridLines       =   2
         GridLinesFixed  =   0
         AllowUserResizing=   1
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin VB.TextBox txtDescripcion 
         Alignment       =   2  'Center
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   1260
         Locked          =   -1  'True
         TabIndex        =   1
         Top             =   450
         Width           =   5025
      End
      Begin BACControles.TXTNumero txtCodigo 
         CausesValidation=   0   'False
         Height          =   315
         Left            =   60
         TabIndex        =   0
         Top             =   450
         Width           =   1125
         _ExtentX        =   1984
         _ExtentY        =   556
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0"
         Text            =   "0"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Descripción de la Tabla"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   1275
         TabIndex        =   5
         Top             =   225
         Width           =   1935
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "N° Categoria"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   105
         TabIndex        =   4
         Top             =   225
         Width           =   1065
      End
   End
End
Attribute VB_Name = "BacMntTb"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Public Sub CambiaGeneralDetalle()
    Grid.TextMatrix(Grid.Row, 3) = BacDescTGen.ValorCambiado
End Sub


Private Sub Nombres_Grilla()
   Grid.Cols = 6
   Grid.TextMatrix(0, 0) = "Código":         Grid.ColWidth(0) = 1000: Grid.ColAlignment(0) = flexAlignRightCenter
   Grid.TextMatrix(0, 1) = "Tasa":           Grid.ColWidth(1) = 1500: Grid.ColAlignment(1) = flexAlignRightCenter
   Grid.TextMatrix(0, 2) = "Fecha":          Grid.ColWidth(2) = 2000: Grid.ColAlignment(2) = flexAlignLeftCenter
   Grid.TextMatrix(0, 3) = "Valor":          Grid.ColWidth(3) = 1500: Grid.ColAlignment(3) = flexAlignRightCenter
   Grid.TextMatrix(0, 4) = "Descripción":    Grid.ColWidth(4) = 3000: Grid.ColAlignment(4) = flexAlignLeftCenter
   Grid.TextMatrix(0, 5) = "Recal. Diario":  Grid.ColWidth(5) = 0:    Grid.ColAlignment(5) = flexAlignLeftCenter
   Grid.RowHeightMin = 315
End Sub

Private Sub Form_Load()
   Me.Top = 0: Me.Left = 0
   Me.Icon = BACSwapParametros.Icon
   
   TxtCodigo.Separator = False
   Call Nombres_Grilla
End Sub

Private Sub Form_Resize()
   On Error GoTo ErrorResize
   FraCuadro.Width = Me.Width - 150
   FraCuadro.Height = Me.Height - 850
   Grid.Width = FraCuadro.Width - 80
   Grid.Height = FraCuadro.Height - (Grid.Top + 50)
   
   txtDescripcion.Width = Grid.Width - (txtDescripcion.Left)
   On Error GoTo 0
Exit Sub
ErrorResize:
   On Error GoTo 0
End Sub

Private Sub Grid_DblClick()
   If Grid.ColSel = 1 And CStr(TxtCodigo.Text) = "1042" Then
      BacControlWindows 100
      BacAyuda.Tag = "Periodos"
      BacAyuda.Show 1
      If giAceptar% = True Then
         Grid.TextMatrix(Grid.RowSel, Grid.ColSel) = Trim(gsDescripcion) & " / " & gsCodigo
         Grid.TextMatrix(Grid.RowSel, 3) = gsValor$
      End If
   End If
   
   If Grid.ColSel = 5 And CStr(TxtCodigo.Text) = "1042" Then
      If Grid.TextMatrix(Grid.RowSel, 0) <> "13" Then
         If Grid.TextMatrix(Grid.RowSel, Grid.ColSel) = "NO" Then
            Grid.TextMatrix(Grid.RowSel, Grid.ColSel) = "SI"
         Else
            Grid.TextMatrix(Grid.RowSel, Grid.ColSel) = "NO"
         End If
      End If
   End If
   
    If Grid.ColSel = 3 And CStr(txtCodigo.Text) = "1042" Then
        Centrar_frm BacDescTGen
    End If
End Sub


Public Sub Centrar_frm(ByVal FRM)
    FRM.Top = (Screen.Height / 2) - (FRM.Height / 2)
    FRM.Left = (Screen.Width / 2) - (FRM.Width / 2)
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 1
         Call Limpiar
      Case 2
         Call Buscar(TxtCodigo.Text)
      Case 3
         Call Grabar
      Case 4
         Call Eliminar
      Case 5
         Call Agregar
      Case 6
         Call Cerrar
   End Select
End Sub

Private Sub Agregar()
   
End Sub
Private Sub Eliminar()
   If MsgBox("¿ Esta seguro que desea eliminar todos los los registros para la Categoria " & CStr(TxtCodigo.Text) & " / " & Trim(txtDescripcion.Text) & " ?", vbQuestion + vbYesNo + vbDefaultButton2, TITSISTEMA) = vbNo Then
      Exit Sub
   End If
   
   Envia = Array()
   AddParam Envia, Trim(txtCodigo.Text)
   If Not Bac_Sql_Execute("SP_ELIMINATABLA", Envia) Then
      Exit Sub
   End If
   
End Sub

Private Sub Grabar()
   On Error GoTo ErrorGrabacion
   
   Dim iContador  As Integer
   
   Call Bac_Sql_Execute("Begin Transaction")
   
   Envia = Array()
   AddParam Envia, Trim(txtCodigo.Text)
   If Not Bac_Sql_Execute("SP_ELIMINATABLA", Envia) Then
      GoTo ErrorGrabacion
   End If
   
   For iContador = 1 To Grid.Rows - 1
      If Len(Grid.TextMatrix(iContador, 0)) > 0 Then
         
         If Me.TxtCodigo.Text = 1042 Then
            Envia = Array()
            AddParam Envia, CStr(TxtCodigo.Text)
            AddParam Envia, Trim(Grid.TextMatrix(iContador, 0))
            AddParam Envia, Val(Right(Grid.TextMatrix(iContador, 1), 2))
            AddParam Envia, Format(Grid.TextMatrix(iContador, 2), "yyyymmdd")
            '''AddParam Envia, Val(0)
            AddParam Envia, Val(Grid.TextMatrix(iContador, 3))
            AddParam Envia, Trim(Grid.TextMatrix(iContador, 4))
            AddParam Envia, Left(Grid.TextMatrix(iContador, 5), 1)
         Else
            Envia = Array()
            AddParam Envia, CStr(TxtCodigo.Text)
            AddParam Envia, Trim(Grid.TextMatrix(iContador, 0))
            AddParam Envia, CDbl(Grid.TextMatrix(iContador, 1))
            AddParam Envia, Format(Grid.TextMatrix(iContador, 2), "yyyymmdd")
            AddParam Envia, CdBl(Grid.TextMatrix(iContador, 3)) 'MAP20150709
            AddParam Envia, Trim(Grid.TextMatrix(iContador, 4))
            'AddParam Envia, ""
            AddParam Envia, Trim(GRID.TextMatrix(iContador, 5)) ''REQ.5539-7494
         End If
         
         If Not Bac_Sql_Execute("SP_GRABATABLA", Envia) Then
            GoTo ErrorGrabacion
         End If
      End If
   Next iContador

   Call Bac_Sql_Execute("Commit Transaction")
   
   MsgBox "Grabación de datos en tabla general detalle para el codigo de tabla : " & CStr(TxtCodigo.Text) & " ha finalizado correctamente. ", vbInformation, TITSISTEMA
   
   Call Limpiar
Exit Sub
ErrorGrabacion:
   Call Bac_Sql_Execute("Rollback Transaction")
   MsgBox "Grabación de datos en tabla general detalle para el codigo de tabla : " & CStr(TxtCodigo.Text) & " Ha finalizado con problemas", vbExclamation, TITSISTEMA
End Sub

Private Sub Buscar(ByVal iCategoria As Variant)
   Dim DATOS()

   Envia = Array()
   AddParam Envia, CStr(iCategoria)
   If Not Bac_Sql_Execute("SP_MDCTLEERCAT", Envia) Then
      Exit Sub
   End If
   If Not Bac_SQL_Fetch(DATOS()) Then
      Exit Sub
   Else
      txtDescripcion.Text = Trim(DATOS(2))
   End If
 
   If iCategoria = 1042 Then
      Grid.ColWidth(5) = 1500
      GRID.TextMatrix(0, 5) = "Recal. Diario"
   Else
      'GRID.ColWidth(5) = 0
      ''REQ.5539-7494
      GRID.ColWidth(5) = 1500
      GRID.TextMatrix(0, 5) = "Nemo"
   End If
 
   Envia = Array()
   AddParam Envia, CStr(iCategoria)
   If Not Bac_Sql_Execute("SP_LEETABLA", Envia) Then
      Exit Sub
   End If
   Grid.Rows = 1
   TxtCodigo.Enabled = False
   txtDescripcion.Enabled = False
   Do While Bac_SQL_Fetch(DATOS())
      Grid.Rows = Grid.Rows + 1
      If TxtCodigo.Text = 1042 Then
         Grid.TextMatrix(Grid.Rows - 1, 0) = Trim(DATOS(1))
         Grid.TextMatrix(Grid.Rows - 1, 1) = DATOS(2)
         Grid.TextMatrix(Grid.Rows - 1, 2) = Format(DATOS(3), "dd/mm/yyyy")
         Grid.TextMatrix(Grid.Rows - 1, 3) = Format(CDbl(DATOS(4)), "#,##0")
         Grid.TextMatrix(Grid.Rows - 1, 4) = Trim(DATOS(5))
         Grid.TextMatrix(Grid.Rows - 1, 5) = IIf(Trim(DATOS(6)) = "--", "NO APLICA", Trim(DATOS(6)))
      Else
         Grid.TextMatrix(Grid.Rows - 1, 0) = Trim(DATOS(1))
         Grid.TextMatrix(Grid.Rows - 1, 1) = CDbl(DATOS(2))
         Grid.TextMatrix(Grid.Rows - 1, 2) = Format(DATOS(3), "dd/mm/yyyy")
         Grid.TextMatrix(Grid.Rows - 1, 3) = Format(CDbl(DATOS(4)), "#,##0.0000")
         Grid.TextMatrix(Grid.Rows - 1, 4) = Trim(DATOS(5))
         GRID.TextMatrix(GRID.Rows - 1, 5) = Trim(Datos(6)) ''REQ.5539-7494
      End If
   Loop
   Toolbar1.Buttons(1).Enabled = True
   Toolbar1.Buttons(2).Enabled = False
   Toolbar1.Buttons(3).Enabled = True
   Toolbar1.Buttons(4).Enabled = True
   Grid.Enabled = True
   Grid.SetFocus
   
End Sub

Private Sub Limpiar()
   Grid.Rows = 1
   Grid.Rows = 2
   Grid.ColWidth(5) = 0
   
   TxtCodigo.Text = 0
   txtDescripcion.Text = ""
   
   Grid.Enabled = False
   TxtCodigo.Enabled = True
   
   Toolbar1.Buttons(1).Enabled = True
   Toolbar1.Buttons(2).Enabled = True
   Toolbar1.Buttons(3).Enabled = False
   Toolbar1.Buttons(4).Enabled = False
   
   TxtCodigo.SetFocus
End Sub

Private Sub Cerrar()
   Unload Me
End Sub

Private Sub txtCodigo_DblClick()
   BacControlWindows 100
   BacAyuda.Tag = "MDCT"
   BacAyuda.Show 1
   If giAceptar% = True Then
      TxtCodigo.Text = CDbl(gsCodigo$)
      txtDescripcion.Text = Trim(gsGlosa$)
   End If
   Call Buscar(TxtCodigo.Text)
   
End Sub

Private Sub Grid_KeyDown(KeyCode As Integer, Shift As Integer)
   Dim iColumna   As Integer
   iColumna = Grid.ColSel
   
   If KeyCode = vbKeyReturn Then
      
      Call HabilitaControls(False)
      
      If iColumna = 0 Then
         Call CtrlObj_Alinear(Grid, txtIngresoTex)
         txtIngresoTex.Text = Grid.TextMatrix(Grid.RowSel, Grid.ColSel)
         txtIngresoTex.Visible = True
         Grid.Enabled = False
         Toolbar1.Enabled = False
      End If
      If iColumna = 1 Then
         Call CtrlObj_Alinear(Grid, txtIngresoNum)
         txtIngresoNum.CantidadDecimales = 0
         txtIngresoNum.Text = Grid.TextMatrix(Grid.RowSel, Grid.ColSel)
         txtIngresoNum.Visible = True
         Grid.Enabled = False
         Toolbar1.Enabled = False
      End If
      If iColumna = 2 Then
         Call CtrlObj_Alinear(Grid, txtIngresoFech)
         txtIngresoFech.Text = Grid.TextMatrix(Grid.RowSel, Grid.ColSel)
         txtIngresoFech.Visible = True
         Grid.Enabled = False
         Toolbar1.Enabled = False
      End If
      If iColumna = 3 Then
         Call CtrlObj_Alinear(Grid, txtIngresoNum)
         txtIngresoNum.CantidadDecimales = 4
         txtIngresoNum.Text = Grid.TextMatrix(Grid.RowSel, Grid.ColSel)
         txtIngresoNum.Visible = True
         Grid.Enabled = False
         Toolbar1.Enabled = False
      End If
      If iColumna = 4 Then
         Call CtrlObj_Alinear(Grid, txtIngresoTex)
         txtIngresoTex.Text = Grid.TextMatrix(Grid.RowSel, Grid.ColSel)
         txtIngresoTex.Visible = True
         Grid.Enabled = False
         Toolbar1.Enabled = False
      End If
      
      'REQ.5539-7494
      If iColumna = 5 Then
         Call CtrlObj_Alinear(GRID, txtIngresoTex)
         txtIngresoTex.Text = GRID.TextMatrix(GRID.RowSel, GRID.ColSel)
         txtIngresoTex.Visible = True
         GRID.Enabled = False
         Toolbar1.Enabled = False
      End If
      
   End If
   
   If KeyCode = vbKeyDelete Then
      If MsgBox("¿ Seguro de Eliminar el " & Grid.RowSel & "° Registro.  ?", vbQuestion + vbYesNo + vbDefaultButton2, TITSISTEMA) = vbNo Then
         Grid.SetFocus
         Exit Sub
      End If
      If (Grid.Rows - 1) > Grid.FixedRows Then
         Grid.RemoveItem (Grid.RowSel)
      Else
         Grid.Rows = 1
      End If
      Grid.SetFocus
   End If
   
   If KeyCode = vbKeyInsert Then
      Grid.Rows = Grid.Rows + 1
      If Me.TxtCodigo.Text = 1042 Then
         Grid.TextMatrix(Grid.Rows - 1, 0) = (Val(Grid.TextMatrix(Grid.Rows - 2, 0)) + 1)
         Grid.TextMatrix(Grid.Rows - 1, 1) = "0"
         Grid.TextMatrix(Grid.Rows - 1, 2) = Format(Date, "dd/mm/yyyy")
         Grid.TextMatrix(Grid.Rows - 1, 3) = "0"
         Grid.TextMatrix(Grid.Rows - 1, 4) = ""
      Else
         Grid.TextMatrix(Grid.Rows - 1, 0) = (Val(Grid.TextMatrix(Grid.Rows - 2, 0)) + 1)
         Grid.TextMatrix(Grid.Rows - 1, 1) = "0"
         Grid.TextMatrix(Grid.Rows - 1, 2) = Format(Date, "dd/mm/yyyy")
         Grid.TextMatrix(Grid.Rows - 1, 3) = "0.0000"
         Grid.TextMatrix(Grid.Rows - 1, 4) = ""
      End If
   End If
End Sub

Public Sub CtrlObj_Alinear(nGrid As MSFlexGrid, nText As Object)
    On Error Resume Next
    nText.Top = nGrid.Top + nGrid.CellTop + 10
    nText.Left = nGrid.Left + nGrid.CellLeft + 50
    nText.Width = nGrid.CellWidth - 10
    nText.Height = nGrid.CellHeight - 10
    
    nText.Text = nGrid.TextMatrix(nGrid.RowSel, nGrid.ColSel)
    nText.SelStart = Len(nText.Text)
    nText.Visible = True
    nText.SetFocus
End Sub

Private Sub txtCodigo_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      Call Buscar(TxtCodigo.Text)
   End If
End Sub

Private Sub txtIngresoFech_KeyDown(KeyCode As Integer, Shift As Integer)
   Dim iColumna   As Integer
   iColumna = Grid.ColSel
   
   If KeyCode = vbKeyReturn Then
      If iColumna = 2 Then
         Grid.TextMatrix(Grid.RowSel, Grid.ColSel) = txtIngresoFech.Text
         Grid.Enabled = True
         Toolbar1.Enabled = True
         txtIngresoFech.Visible = False
         Grid.SetFocus
         Call HabilitaControls(True)
      End If
   End If
   If KeyCode = vbKeyEscape Then
      If iColumna = 2 Then
         Grid.Enabled = True
         Toolbar1.Enabled = True
         txtIngresoFech.Visible = False
         Grid.SetFocus
         Call HabilitaControls(True)
      End If
   End If
End Sub

Private Sub txtIngresoNum_KeyDown(KeyCode As Integer, Shift As Integer)
   Dim iColumna   As Integer
   iColumna = Grid.ColSel
   
   If KeyCode = vbKeyReturn Then
      If iColumna = 1 Or iColumna = 3 Then
         Grid.TextMatrix(Grid.RowSel, Grid.ColSel) = txtIngresoNum.Text
         Grid.Enabled = True
         Toolbar1.Enabled = True
         txtIngresoNum.Visible = False
         Grid.SetFocus
         Call HabilitaControls(True)
      End If
   End If
   If KeyCode = vbKeyEscape Then
      If iColumna = 1 Or iColumna = 3 Then
         Grid.Enabled = True
         Toolbar1.Enabled = True
         txtIngresoNum.Visible = False
         Grid.SetFocus
         Call HabilitaControls(True)
      End If
   End If
End Sub

Private Function ValidaColumnaCodigo(ByVal xValor As Variant, ByVal oFila As Long) As Boolean
   Dim iContador  As Long
   
   Let ValidaColumnaCodigo = False
   
   If xValor = "" Then
      MsgBox "Codificación se encuentra en blanco... Favor verificar.!", vbOKOnly + vbExclamation, App.Title
      Let ValidaColumnaCodigo = True
      Exit Function
   End If
   
   For iContador = 1 To Grid.Rows - 1
      If iContador <> oFila And Grid.TextMatrix(iContador, 0) = xValor Then
         Exit Function
      End If
   Next iContador
   Let ValidaColumnaCodigo = True
End Function

Private Sub txtIngresoTex_KeyDown(KeyCode As Integer, Shift As Integer)
   Dim iColumna   As Integer
   iColumna = Grid.ColSel
   
   If KeyCode = vbKeyReturn Then
      If iColumna = 0 Then
         If ValidaColumnaCodigo(txtIngresoTex, Grid.RowSel) = False Then
            MsgBox "Codificación ya se encuentra asignada, favor verifique. ", vbExclamation + vbOKOnly, App.Title
            Exit Sub
         End If
      End If
     ' If iColumna = 4 Then
         Grid.TextMatrix(Grid.RowSel, Grid.ColSel) = UCase(Trim(txtIngresoTex.Text))
         Grid.Enabled = True
         Toolbar1.Enabled = True
         txtIngresoTex.Visible = False
         Grid.SetFocus
         Call HabilitaControls(True)
     ' End If
   End If
   If KeyCode = vbKeyEscape Then
     ' If iColumna = 4 Or iColumna = 0 Then
         Grid.Enabled = True
         Toolbar1.Enabled = True
         txtIngresoTex.Visible = False
         Grid.SetFocus
         Call HabilitaControls(True)
     ' End If
   End If
End Sub

Private Sub txtIngresoTex_KeyPress(KeyAscii As Integer)
   KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub


Private Sub HabilitaControls(ByVal xValor As Boolean)
   Dim iContador As Integer

   For iContador = 1 To Toolbar1.Buttons.Count
      Let Toolbar1.Buttons.Item(iContador).Enabled = xValor
   Next iContador
   
   Let Toolbar1.Buttons.Item(5).Enabled = False

End Sub
