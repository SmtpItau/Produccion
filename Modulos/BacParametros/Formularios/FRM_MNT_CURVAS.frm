VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form FRM_MNT_CURVAS 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Definición de Curvas"
   ClientHeight    =   4380
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   8325
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   4380
   ScaleWidth      =   8325
   ShowInTaskbar   =   0   'False
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   8325
      _ExtentX        =   14684
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      ToolTips        =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   11
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.Visible         =   0   'False
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            ImageIndex      =   4
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            ImageIndex      =   5
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   6
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button8 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button9 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button10 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            ImageIndex      =   7
         EndProperty
         BeginProperty Button11 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            ImageIndex      =   8
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   5100
         Top             =   60
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   8
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_CURVAS.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_CURVAS.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_CURVAS.frx":1DB4
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_CURVAS.frx":2C8E
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_CURVAS.frx":3B68
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_CURVAS.frx":4A42
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_CURVAS.frx":4D5C
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_CURVAS.frx":4E6E
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame Frame1 
      Height          =   3900
      Left            =   15
      TabIndex        =   1
      Top             =   450
      Width           =   8280
      Begin VB.TextBox Texto 
         BackColor       =   &H80000002&
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
         ForeColor       =   &H80000009&
         Height          =   285
         Left            =   1470
         TabIndex        =   4
         Top             =   3285
         Visible         =   0   'False
         Width           =   1695
      End
      Begin VB.ComboBox Combo 
         BackColor       =   &H80000002&
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000009&
         Height          =   315
         Left            =   6825
         Style           =   2  'Dropdown List
         TabIndex        =   3
         Top             =   3375
         Visible         =   0   'False
         Width           =   1155
      End
      Begin MSFlexGridLib.MSFlexGrid Grid 
         Height          =   3720
         Left            =   45
         TabIndex        =   2
         Top             =   150
         Width           =   8175
         _ExtentX        =   14420
         _ExtentY        =   6562
         _Version        =   393216
         Cols            =   3
         FixedCols       =   0
         BackColor       =   -2147483633
         ForeColor       =   -2147483641
         BackColorFixed  =   -2147483646
         ForeColorFixed  =   -2147483643
         FocusRect       =   0
         GridLines       =   2
         GridLinesFixed  =   0
         AllowUserResizing=   1
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
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
Attribute VB_Name = "FRM_MNT_CURVAS"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Enum ColumnasGrid
   [Curva] = 0
   [Glosa] = 1
   [Tipo] = 2
   [Local] = 3
End Enum
Private Enum Botonera
   [Buscar] = 1
   [Grabar] = 2
   [Eliminar] = 3
   [Imprimir] = 4
   [VistaPrevia] = 5
   [Cerrar] = 6
   [Copiar] = 10
   [Pegar] = 11
End Enum
Dim MiBtnPresiona As Botonera
Dim bCopiar       As Boolean
Dim bFilaCopia    As Long


Private Sub NombresGrilla()
   Let GRID.Rows = 2:             Let GRID.FixedRows = 1
   Let GRID.Cols = 4:             Let GRID.FixedCols = 0
   Let GRID.Font.Name = "Tahoma": Let GRID.Font.Size = 8
   Let GRID.RowHeightMin = 315

   Let GRID.TextMatrix(0, ColumnasGrid.Curva) = "Curva":       Let GRID.ColWidth(ColumnasGrid.Curva) = 2200:   Let GRID.ColAlignment(0) = flexAlignLeftCenter
   Let GRID.TextMatrix(0, ColumnasGrid.Glosa) = "Descripción": Let GRID.ColWidth(ColumnasGrid.Glosa) = 4200:   Let GRID.ColAlignment(1) = flexAlignLeftCenter
   Let GRID.TextMatrix(0, ColumnasGrid.Tipo) = "Tipo":         Let GRID.ColWidth(ColumnasGrid.Tipo) = 1500:    Let GRID.ColAlignment(2) = flexAlignLeftCenter
   Let GRID.TextMatrix(0, ColumnasGrid.Local) = "Local":       Let GRID.ColWidth(ColumnasGrid.Tipo) = 1500:    Let GRID.ColAlignment(3) = flexAlignLeftCenter

   Call Combo.AddItem("TASA")
   Call Combo.AddItem("SPREAD")
End Sub

Private Sub Combo_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      GRID.TextMatrix(GRID.RowSel, GRID.ColSel) = Left(Combo.Text, 1)
      Call HabilitaCtr(True, Combo)
      GRID.SetFocus
   End If
   If KeyCode = vbKeyEscape Then
      Call HabilitaCtr(True, Combo)
      GRID.SetFocus
   End If
End Sub

Private Sub Form_Load()
   Let Me.Icon = BACSwapParametros.Icon
   Let Me.Top = 0: Let Me.Left = 0
   
   Call NombresGrilla
   Call BuscarCurvasCreadas
End Sub

Private Sub BuscarCurvasCreadas()
   On Error GoTo ErrorLectura
   Dim Datos()
   
   Let Me.MousePointer = vbHourglass
   Let Screen.MousePointer = vbHourglass
   
   Let Envia = Array()
   Call AddParam(Envia, CDbl(1))  '--> Consulta
   If Not Bac_Sql_Execute("SP_MNT_DEFINICION_CURVAS", Envia) Then
      GoTo ErrorLectura
   End If
   Let GRID.Rows = 1
   Do While Bac_SQL_Fetch(Datos())
      Let GRID.Rows = GRID.Rows + 1
      Let GRID.TextMatrix(GRID.Rows - 1, ColumnasGrid.Curva) = Datos(ColumnasGrid.Curva + 1)
      Let GRID.TextMatrix(GRID.Rows - 1, ColumnasGrid.Glosa) = Datos(ColumnasGrid.Glosa + 1)
      Let GRID.TextMatrix(GRID.Rows - 1, ColumnasGrid.Tipo) = Datos(ColumnasGrid.Tipo + 1)
      Let GRID.TextMatrix(GRID.Rows - 1, ColumnasGrid.Local) = Datos(ColumnasGrid.Local + 1)
   Loop
   
   If GRID.Rows = 1 Then
      Let GRID.Rows = 2
   Else
      Call HabilitaCtr(True, texto)
   End If
   
   Let Me.MousePointer = vbDefault
   Let Screen.MousePointer = vbDefault
   
   Me.Caption = "Definición de Curvas."
   
   On Error GoTo 0
Exit Sub
ErrorLectura:
   Let Me.MousePointer = vbDefault
   Let Screen.MousePointer = vbDefault
   MsgBox "Problemas durante la consulta de Curvas.", vbExclamation, TITSISTEMA
   On Error GoTo 0
End Sub

Private Sub AJObjeto(Marco As MSFlexGrid, Objeto As Control)
   On Error Resume Next
   Let Objeto.Top = Marco.CellTop + Marco.Top
   Let Objeto.Left = Marco.CellLeft + Marco.Left
   Let Objeto.Height = Marco.CellHeight + 20
   Let Objeto.Width = Marco.CellWidth
   On Error GoTo 0
End Sub


Private Sub GRID_KeyDown(KeyCode As Integer, Shift As Integer)
   
   If KeyCode = vbKeyReturn Then
      
      If GRID.ColSel = ColumnasGrid.Curva Then
         Call HabilitaCtr(False, texto)
         Call AJObjeto(GRID, texto)
         Let texto.Text = GRID.TextMatrix(GRID.RowSel, GRID.ColSel)
         Call texto.SetFocus
      End If
      
      If GRID.ColSel = ColumnasGrid.Glosa Then
         Call HabilitaCtr(False, texto)
         Call AJObjeto(GRID, texto)
         Let texto.Text = GRID.TextMatrix(GRID.RowSel, GRID.ColSel)
         Call texto.SetFocus
      End If
      
      If GRID.ColSel = ColumnasGrid.Tipo Then
         Call Combo.Clear
         Call Combo.AddItem("TASA")
         Call Combo.AddItem("SPREAD")

         Call HabilitaCtr(False, Combo)
         Call AJObjeto(GRID, Combo)
         If GRID.TextMatrix(GRID.RowSel, GRID.ColSel) = "T" Then
            Let Combo.Text = "TASA"
         Else
            Let Combo.Text = "SPREAD"
         End If
         Call Combo.SetFocus
      End If
      
      If GRID.ColSel = ColumnasGrid.Local Then
         Call Combo.Clear
         Call Combo.AddItem("S")
         Call Combo.AddItem("N")
         
         Call HabilitaCtr(False, Combo)
         Call AJObjeto(GRID, Combo)
         If GRID.TextMatrix(GRID.RowSel, GRID.ColSel) = "N" Then
            Let Combo.Text = "N"
         Else
            Let Combo.Text = "S"
         End If
         Call Combo.SetFocus
      End If

   End If
   
   If KeyCode = vbKeyInsert Then
      If GRID.Rows <= 2 Then
         If GRID.TextMatrix(GRID.RowSel, ColumnasGrid.Curva) = "" Then
            Exit Sub
         End If
      Else
         If GRID.TextMatrix(GRID.Rows - 1, ColumnasGrid.Curva) = "" Then
            Exit Sub
         End If
      End If
      Toolbar1.Buttons(Botonera.Copiar).Enabled = True
      Let GRID.Rows = GRID.Rows + 1
   End If
   
   If KeyCode = vbKeyDelete Then
      If GenAdvertencia(GRID.TextMatrix(GRID.RowSel, 0)) = False Then
         Exit Sub
      End If
      If GRID.Rows <= 2 Then
         Let GRID.Rows = 1: Let GRID.Rows = 2
      Else
         Call GRID.RemoveItem(GRID.RowSel)
      End If
      Me.Caption = "Definición de Curvas.     [ Para Confirmar la Eliminación debe Grabar ]."
   End If
   
End Sub

Private Sub Texto_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      Let GRID.TextMatrix(GRID.RowSel, GRID.ColSel) = texto.Text
      Call HabilitaCtr(True, texto)
      Call GRID.SetFocus
   End If
   If KeyCode = vbKeyEscape Then
      Call HabilitaCtr(True, texto)
      Call GRID.SetFocus
   End If
End Sub

Private Sub Texto_KeyPress(KeyAscii As Integer)
   KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case Botonera.Buscar
         Call BuscarCurvasCreadas
      Case Botonera.Grabar
         
         Call GrabarCurvas
         
      Case Botonera.Cerrar
         Call Unload(Me)
      Case Botonera.Copiar
         If GRID.RowSel = 0 Then
            Exit Sub
         End If
         bCopiar = True
         bFilaCopia = GRID.RowSel
         Toolbar1.Buttons(Botonera.Copiar).Enabled = False
         Toolbar1.Buttons(Botonera.Pegar).Enabled = True
      Case Botonera.Pegar
         If bFilaCopia = 0 Then
            Exit Sub
         End If
         
         bCopiar = False
         GRID.TextMatrix(GRID.RowSel, ColumnasGrid.Curva) = GRID.TextMatrix(bFilaCopia, ColumnasGrid.Curva)
         GRID.TextMatrix(GRID.RowSel, ColumnasGrid.Glosa) = GRID.TextMatrix(bFilaCopia, ColumnasGrid.Glosa)
         GRID.TextMatrix(GRID.RowSel, ColumnasGrid.Tipo) = GRID.TextMatrix(bFilaCopia, ColumnasGrid.Tipo)
         
         Toolbar1.Buttons(Botonera.Copiar).Enabled = True
         Toolbar1.Buttons(Botonera.Pegar).Enabled = False
         bFilaCopia = 0
   End Select
End Sub

Private Sub HabilitaCtr(ByVal iValor_ As Boolean, ByRef obj As Control)
   Let obj.Enabled = Not iValor_
   Let obj.Visible = Not iValor_
   
   Let Toolbar1.Enabled = iValor_
   Let Toolbar1.Buttons(Botonera.Buscar).Enabled = iValor_
   Let Toolbar1.Buttons(Botonera.Grabar).Enabled = iValor_
   Let Toolbar1.Buttons(Botonera.Eliminar).Enabled = iValor_
   Let Toolbar1.Buttons(Botonera.Imprimir).Enabled = iValor_
   Let Toolbar1.Buttons(Botonera.VistaPrevia).Enabled = iValor_
   Let Toolbar1.Buttons(Botonera.Cerrar).Enabled = iValor_
   Let GRID.Enabled = iValor_

End Sub



Private Sub GrabarCurvas()
   On Error GoTo ErrorGrabarCurvas
   Dim Datos()
   Dim iContador  As Long
   
   Let Screen.MousePointer = vbHourglass
   Let Me.MousePointer = vbHourglass
   
   Call BacBeginTransaction
   
   Let Envia = Array()
   Call AddParam(Envia, 2) '--> Elimina Curvas
   If Not Bac_Sql_Execute("SP_MNT_DEFINICION_CURVAS", Envia) Then
      GoTo ErrorGrabarCurvas
   End If
   
   For iContador = 1 To GRID.Rows - 1
      
      Let Envia = Array()
      Call AddParam(Envia, 3) '--> Grabación Curvas
      Call AddParam(Envia, GRID.TextMatrix(iContador, ColumnasGrid.Curva)) '--> Grabación Curvas
      Call AddParam(Envia, GRID.TextMatrix(iContador, ColumnasGrid.Glosa)) '--> Grabación Curvas
      Call AddParam(Envia, GRID.TextMatrix(iContador, ColumnasGrid.Tipo))  '--> Grabación Curvas
      Call AddParam(Envia, GRID.TextMatrix(iContador, ColumnasGrid.Local))   '--> Curva Local
      If Not Bac_Sql_Execute("SP_MNT_DEFINICION_CURVAS", Envia) Then
         GoTo ErrorGrabarCurvas
      End If
   
   Next iContador

   Let Envia = Array()
   Call AddParam(Envia, 6)
   If Not Bac_Sql_Execute("SP_MNT_DEFINICION_CURVAS", Envia) Then
      GoTo ErrorGrabarCurvas
   End If

   Call BacCommitTransaction
   
   Let Screen.MousePointer = vbDefault
   Let Me.MousePointer = vbDefault
   
   MsgBox "Proceso OK" & vbCrLf & vbCrLf & "Proceso de actualización de curvas ha finalizado correctamente.", vbInformation, TITSISTEMA
   
   Call BuscarCurvasCreadas
   
Exit Sub
ErrorGrabarCurvas:
   Call BacRollBackTransaction
   
   Let Screen.MousePointer = vbDefault
   Let Me.MousePointer = vbDefault

   MsgBox "ERROR" & vbCrLf & vbCrLf & "Proceso de actualización de curvas ha finalizado con Errores.", vbExclamation, TITSISTEMA
End Sub

Private Function GenAdvertencia(ByVal cCurva As String) As Boolean
   Dim Datos()
   
   GenAdvertencia = False
   
   Envia = Array()
   AddParam Envia, CDbl(5) '--> Indice de Validación
   AddParam Envia, cCurva
   If Not Bac_Sql_Execute("SP_MNT_DEFINICION_CURVAS", Envia) Then
      Exit Function
   End If
   If Bac_SQL_Fetch(Datos()) Then
      If Datos(1) = -1 Then
         If MsgBox("Advertencia." & vbCrLf & vbCrLf & Datos(2) & vbCrLf & vbCrLf & "¿ Seguro de Continuar. ?", vbQuestion + vbYesNo, TITSISTEMA) = vbNo Then
            GRID.SetFocus
            Exit Function
         End If
         GRID.SetFocus
      End If
   End If
   
   GenAdvertencia = True
   
End Function


