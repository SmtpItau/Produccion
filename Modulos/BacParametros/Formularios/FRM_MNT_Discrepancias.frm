VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form FRM_MNT_Discrepancias 
   Caption         =   "Mantenedor de Discrepancias"
   ClientHeight    =   4200
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   5175
   LinkTopic       =   "Form2"
   MDIChild        =   -1  'True
   ScaleHeight     =   4200
   ScaleWidth      =   5175
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   5175
      _ExtentX        =   9128
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Guardar ..."
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Eliminar ..."
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Cerrar ...."
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   3360
         Top             =   75
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
               Picture         =   "FRM_MNT_Discrepancias.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_Discrepancias.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_Discrepancias.frx":1DB4
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame FraCuadro 
      Height          =   3750
      Left            =   15
      TabIndex        =   1
      Top             =   450
      Width           =   5160
      Begin VB.TextBox txtDescripcion 
         BackColor       =   &H80000002&
         BorderStyle     =   0  'None
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000009&
         Height          =   315
         Left            =   2040
         TabIndex        =   3
         Text            =   "Descripcion"
         Top             =   525
         Width           =   1530
      End
      Begin MSFlexGridLib.MSFlexGrid Grid 
         Height          =   3525
         Left            =   30
         TabIndex        =   2
         Top             =   135
         Width           =   5040
         _ExtentX        =   8890
         _ExtentY        =   6218
         _Version        =   393216
         FixedCols       =   0
         RowHeightMin    =   315
         BackColor       =   -2147483644
         ForeColor       =   -2147483641
         BackColorFixed  =   -2147483646
         ForeColorFixed  =   -2147483639
         BackColorBkg    =   -2147483645
         GridColor       =   -2147483638
         GridColorFixed  =   -2147483642
         FocusRect       =   0
         GridLines       =   2
         GridLinesFixed  =   0
         FormatString    =   ""
      End
   End
End
Attribute VB_Name = "FRM_MNT_Discrepancias"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
'Mantenedor de Descrepancias
'Agregado el día : Miercoles 25 de Mayo del 2005 a las 13:03 Hras.
'Programador     : Referencia: [Req. N° G1.20 (Control Discrepancias)]
' Tabla          : dbo.DISCREPANCIAS
' Procedimientos : dbo.SP_MNT_DISCREPANCIAS
' Parametros     : a) @MiTag        --> Indica la Acción a seguir [C: Consulta; G:Grabar; E:Eliminar]
'                  b) @Codigo       --> Codigo de la Discrepancia
'                  c) @Descripcion  --> Descripción Asociada al codigo

Private Sub Nombres_Grilla()
   Grid.Rows = 2
   Grid.Cols = 2
   Grid.FixedRows = 1
   Grid.FixedCols = 0
   
   Grid.TextMatrix(0, 0) = "Código"
   Grid.TextMatrix(0, 1) = "Descripción"
   Grid.AllowUserResizing = flexResizeColumns
   
   Grid.ColWidth(0) = 1500
   Grid.ColWidth(1) = 4000
   Grid.Font.Name = "Arial"
End Sub

Private Sub CargarInformación()
   On Error GoTo ErrorCarga

   Envia = Array()
   AddParam Envia, "C"
   If Not Bac_Sql_Execute("SP_MNT_DISCREPANCIAS", Envia) Then
      GoTo ErrorCarga
   End If
   Grid.Rows = 1
   Do While Bac_SQL_Fetch(Datos())
      Grid.Rows = Grid.Rows + 1
      Grid.TextMatrix(Grid.Rows - 1, 0) = Format(CDbl(Datos(1)), FEntero)
      Grid.TextMatrix(Grid.Rows - 1, 1) = UCase(Datos(2))
   Loop
   Grid.Tag = "NO"
   
   On Error GoTo 0
Exit Sub
ErrorCarga:
   MsgBox "¡ Se ha producido un error en la carga de la información !" & vbCrLf & "Error N° " & Err.Number & vbCrLf & Err.Description, vbExclamation, TITSISTEMA
   On Error GoTo 0
End Sub

Private Sub GrabarInformación()
   On Error GoTo ErrorGrabacion
   Dim iContador  As Long
   Dim iRegistros As Long
   
   Call Bac_Sql_Execute("Begin Transaction")
   
   Envia = Array()
   AddParam Envia, "E"
   Call Bac_Sql_Execute("SP_MNT_DISCREPANCIAS", Envia)
   
   iRegistros = 0
   For iContador = 1 To Grid.Rows - 1
      If Val(Grid.TextMatrix(iContador, 0)) > 0 Then
         Envia = Array()
         AddParam Envia, "G"
         AddParam Envia, CDbl(Grid.TextMatrix(iContador, 0))
         AddParam Envia, UCase(Grid.TextMatrix(iContador, 1))
         If Not Bac_Sql_Execute("SP_MNT_DISCREPANCIAS", Envia) Then
            GoTo ErrorGrabacion
         Else
            iRegistros = iRegistros + 1
         End If
      End If
   Next iContador
   
   Call Bac_Sql_Execute("Commit Transaction")
   
   Grid.Tag = "NO"
   
   If iRegistros > 0 Then
      MsgBox "¡ Se han grabado en forma correcta " & iRegistros & " Registros. ", vbInformation, TITSISTEMA
   Else
      MsgBox "¡ No se han encontrado registros para grabar !", vbInformation, TITSISTEMA
   End If
   On Error GoTo 0

Exit Sub
ErrorGrabacion:
   Call Bac_Sql_Execute("Rollback Transaction")
   MsgBox "¡ Se ha producido un error en la grabación de la información !" & vbCrLf & "Error N° " & Err.Number & vbCrLf & Err.Description, vbExclamation, TITSISTEMA
   On Error GoTo 0
End Sub

Private Sub Form_Load()
   Me.Icon = BACSwapParametros.Icon
   Me.Top = 0: Me.Left = 0
   
   Me.Toolbar1.Buttons.Item(2).Visible = False
   
   txtDescripcion.Visible = False
   
   Call Nombres_Grilla
   Call CargarInformación
End Sub

Private Sub Form_Resize()
   On Error Resume Next
   
   FraCuadro.Width = (Me.Width - 150)
   FraCuadro.Height = (Me.Height - 850)
   
   Grid.Width = (FraCuadro.Width - 100)
   Grid.Height = (FraCuadro.Height - 200)
   On Error GoTo 0
End Sub

Private Sub Form_Unload(Cancel As Integer)
   Call ValidaModificaciones
End Sub

Private Sub Grid_KeyDown(KeyCode As Integer, Shift As Integer)
   
   If KeyCode = vbKeyReturn Then
      If Grid.ColSel = 1 Then
         Grid.Col = Grid.ColSel
         Grid.Row = Grid.RowSel
         
         txtDescripcion.Text = UCase(Grid.TextMatrix(Grid.RowSel, Grid.ColSel))
         txtDescripcion.Left = (Grid.CellLeft - 10)
         txtDescripcion.Top = (Grid.CellTop + 150)
         txtDescripcion.Height = (Grid.CellHeight - 10)
         txtDescripcion.Width = (Grid.CellWidth - 10)
         txtDescripcion.Visible = True
         txtDescripcion.SetFocus
         Grid.Enabled = False
      End If
   End If
   
   If KeyCode = vbKeyInsert Then
      Grid.Tag = "SI"
      If Val(Grid.TextMatrix(Grid.Rows - 1, 0)) = 0 Then
         MsgBox "¡ Debe primero completar la información antes de insertar un nuevo registro !", vbExclamation, TITSISTEMA
         If Grid.Enabled = True Then Grid.SetFocus
         Exit Sub
      End If
      Grid.Rows = Grid.Rows + 1
      Grid.Col = 0
      Grid.Row = Grid.Rows - 1
      
      If Grid.Rows = Grid.FixedRows + 1 Then
         Grid.TextMatrix(Grid.RowSel, 0) = 1
      Else
         If Val(Grid.TextMatrix(Grid.RowSel, 0)) = 0 Then
            Grid.TextMatrix(Grid.RowSel, 0) = CDbl(Grid.TextMatrix(Grid.RowSel - 1, 0)) + 1
         End If
      End If
      
      If Grid.Enabled = True Then Grid.SetFocus
   End If
   
   If KeyCode = vbKeyDelete Then
      Grid.Tag = "SI"
      If MsgBox("¿ Se encuentra segúro de eliminar el registro seleccionado ?", vbQuestion + vbYesNo, TITSISTEMA) = vbNo Then
         If Grid.Enabled = True Then Grid.SetFocus
         Exit Sub
      End If
      
      Grid.RemoveItem Grid.RowSel
      If Grid.Enabled = True Then Grid.SetFocus
      
   End If

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 1
         Call GrabarInformación
      Case 3
         Unload Me
   End Select
End Sub

Private Sub ValidaModificaciones()
   If Grid.Tag = "SI" Then
      If MsgBox("¡ Usted ha realizado algunas modificaciones. ! " & vbCrLf & " ¿ Desea grabar antes de cerrar ?", vbQuestion + vbYesNo, TITSISTEMA) = vbYes Then
         Call GrabarInformación
      End If
   End If
End Sub

Private Sub txtDescripcion_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      Grid.Tag = "SI"
      If Grid.Rows = Grid.FixedRows + 1 Then
         Grid.TextMatrix(Grid.RowSel, 0) = 1
      Else
         If Val(Grid.TextMatrix(Grid.RowSel, 0)) = 0 Then
            Grid.TextMatrix(Grid.RowSel, 0) = CDbl(Grid.TextMatrix(Grid.RowSel - 1, 0)) + 1
         End If
      End If
      Grid.TextMatrix(Grid.RowSel, 1) = UCase(txtDescripcion.Text)
      txtDescripcion.Text = ""
      Grid.Enabled = True
      txtDescripcion.Visible = False
      If Grid.Enabled = True Then: Grid.SetFocus
   End If
   
   If KeyCode = vbKeyEscape Then
      txtDescripcion.Text = ""
      Grid.Enabled = True
      txtDescripcion.Visible = False
      If Grid.Enabled = True Then: Grid.SetFocus
   End If
   
End Sub

Private Sub txtDescripcion_KeyPress(KeyAscii As Integer)
   KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub
