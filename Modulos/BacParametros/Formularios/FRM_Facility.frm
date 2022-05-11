VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form FRM_Facility 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "PRODUCTO MESA DE DINERO FACILITY"
   ClientHeight    =   8550
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   16290
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   8550
   ScaleWidth      =   16290
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   16290
      _ExtentX        =   28734
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   3030
         Top             =   15
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   2
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_Facility.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_Facility.frx":0EDA
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame Frame1 
      Height          =   8010
      Left            =   30
      TabIndex        =   1
      Top             =   450
      Width           =   16170
      Begin VB.ComboBox CMBGrid 
         BackColor       =   &H80000002&
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000009&
         Height          =   315
         Left            =   1680
         Style           =   2  'Dropdown List
         TabIndex        =   3
         Top             =   480
         Visible         =   0   'False
         Width           =   915
      End
      Begin MSFlexGridLib.MSFlexGrid Grid 
         Height          =   7800
         Left            =   0
         TabIndex        =   2
         Top             =   120
         Width           =   16080
         _ExtentX        =   28363
         _ExtentY        =   13758
         _Version        =   393216
         Cols            =   3
         FixedCols       =   0
         RowHeightMin    =   315
         BackColor       =   -2147483633
         BackColorFixed  =   -2147483646
         ForeColorFixed  =   -2147483639
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
Attribute VB_Name = "FRM_Facility"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False


Private Sub Read_Facility()
   Dim DATOS()
   
   'Envia = Array()
   'AddParam Envia, CDbl(0)
   If Not Bac_Sql_Execute("BacParamSuda.dbo.SP_CONSULTA_PRODUCTOS_FACILITY") Then
      Call MsgBox("Error de Lectura." & vbCrLf & vbCrLf & "Se ha generado un error en la lectura de productos.", vbExclamation, App.Title)
      Exit Sub
   End If
   Let Grid.Rows = 1
   Do While Bac_SQL_Fetch(DATOS())
      Let Grid.Rows = Grid.Rows + 1
      Let Grid.TextMatrix(Grid.Rows - 1, 0) = DATOS(1) '--> Id_Sistema
      Let Grid.TextMatrix(Grid.Rows - 1, 1) = DATOS(2) '--> Descripcion de Sistema
      Let Grid.TextMatrix(Grid.Rows - 1, 2) = DATOS(3) '--> Codigo_producto
      Let Grid.TextMatrix(Grid.Rows - 1, 3) = DATOS(4) '--> Descripcion de Producto
      Let Grid.TextMatrix(Grid.Rows - 1, 4) = DATOS(5) '--> Codigo_producto_otro
      Let Grid.TextMatrix(Grid.Rows - 1, 5) = DATOS(6) '--> Codigo_Instrumento
      Let Grid.TextMatrix(Grid.Rows - 1, 6) = DATOS(7) '--> Descripcion Instrumento
      Let Grid.TextMatrix(Grid.Rows - 1, 7) = DATOS(8) '--> Facility
      Let Grid.TextMatrix(Grid.Rows - 1, 8) = DATOS(9) '--> Desc. Facility
      
      
   Loop
End Sub

Private Sub Read_ComboFacility(ByVal xIndice As Integer)
   Dim DATOS()
   
   'Envia = Array()
   'AddParam Envia, CDbl(xIndice)
   If Not Bac_Sql_Execute("BacParamSuda.dbo.SP_CONSULTA_CODIGOS_FACILITY") Then
      Call MsgBox("Error de Lectura." & vbCrLf & vbCrLf & "Se ha generado un error en la lectura de productos.", vbExclamation, App.Title)
      Exit Sub
   End If
   Call CMBGrid.Clear
   Do While Bac_SQL_Fetch(DATOS())
      Call CMBGrid.AddItem(DATOS(2))
       Let CMBGrid.ItemData(CMBGrid.NewIndex) = DATOS(1)
   Loop
End Sub

Private Sub Setting_Grid()
   Let Grid.Rows = 2:      Let Grid.Cols = 9
   Let Grid.FixedRows = 1: Let Grid.FixedCols = 0
   Let Grid.RowHeightMin = 315
   
   Let Grid.TextMatrix(0, 0) = "Id_Sistema":               Let Grid.ColWidth(0) = 1000
   Let Grid.TextMatrix(0, 1) = "Descripcion de Sistema":   Let Grid.ColWidth(1) = 3500
   Let Grid.TextMatrix(0, 2) = "Codigo_producto":          Let Grid.ColWidth(2) = 1000
   Let Grid.TextMatrix(0, 3) = "Descripcion de Producto":  Let Grid.ColWidth(3) = 3500
   Let Grid.TextMatrix(0, 4) = "Codigo_producto_otro":     Let Grid.ColWidth(4) = 1000
   Let Grid.TextMatrix(0, 5) = "Codigo_Instrumento":       Let Grid.ColWidth(5) = 1000
   Let Grid.TextMatrix(0, 6) = "Descripcion Instrumento":  Let Grid.ColWidth(6) = 3500
   Let Grid.TextMatrix(0, 7) = "Facility":                 Let Grid.ColWidth(7) = 1000
   Let Grid.TextMatrix(0, 8) = "Desc. Facility":           Let Grid.ColWidth(8) = 5000
End Sub

Private Sub CMBGrid_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      If Grid.ColSel = 8 Then
         Let Grid.TextMatrix(Grid.RowSel, Grid.ColSel) = CMBGrid.Text
         Let Grid.TextMatrix(Grid.RowSel, 7) = CMBGrid.ItemData(CMBGrid.ListIndex)
      End If
      Let Grid.Enabled = True
      Let Toolbar1.Enabled = True
      Let CMBGrid.Visible = False
      Call Grid.SetFocus
   End If
   If KeyCode = vbKeyEscape Then
      Let Grid.Enabled = True
      Let Toolbar1.Enabled = True
      Let CMBGrid.Visible = False
      Call Grid.SetFocus
   End If
End Sub

Private Sub Form_Load()
   Let Me.Top = 0:   Let Me.Left = 0
   Let Me.Icon = BACSwapParametros.Icon
   
   Call Setting_Grid
   Call Read_Facility
End Sub

Private Sub Grid_DblClick()
   Call Grid_KeyDown(13, 0)
End Sub

Private Sub Grid_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      Let Toolbar1.Enabled = False
      If Grid.ColSel = 8 Then
         Call Read_ComboFacility(Grid.ColSel)
         Let Grid.Enabled = False
         Let CMBGrid.Visible = True
         Let CMBGrid.Text = Grid.TextMatrix(Grid.RowSel, Grid.ColSel)
         Call AJObjeto(Grid, CMBGrid)
         Call CMBGrid.SetFocus
      End If
   End If
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 1
         Call Save_Data
      Case 2
         Call Unload(Me)
   End Select
End Sub

Private Sub AJObjeto(Marco As MSFlexGrid, Objeto As Control)
   On Error Resume Next
   Let Objeto.Top = Marco.CellTop + Marco.Top
   Let Objeto.Left = Marco.CellLeft + Marco.Left
   Let Objeto.Height = Marco.CellHeight + 20
   Let Objeto.Width = Marco.CellWidth
   On Error GoTo 0
End Sub

Private Function Save_Data()
   Dim nContador  As Long
   Dim DATOS()
   
   For nContador = 1 To Grid.Rows - 1
      Envia = Array()
      AddParam Envia, Trim(Grid.TextMatrix(nContador, 0)) 'SISTEMA
      AddParam Envia, Trim(Grid.TextMatrix(nContador, 2)) 'PRODUCTO
      AddParam Envia, Trim(Grid.TextMatrix(nContador, 4)) 'COD PRODUCTO OTRO
      AddParam Envia, CDbl(Grid.TextMatrix(nContador, 5)) 'COD INSTRUMENTO
      AddParam Envia, Trim(Grid.TextMatrix(nContador, 7)) 'CODIGO FACILITY
      If Not Bac_Sql_Execute("BacParamSuda.dbo.SP_UPDATE_CODIGOS_FACILITY", Envia) Then
         Call MsgBox("Error de Lectura." & vbCrLf & vbCrLf & "Se ha generado un error al actualizar Productos Facility.", vbExclamation, App.Title)
         Exit Function
      End If
   Next nContador
   
   Call MsgBox("Actualización Finalizada." & vbCrLf & vbCrLf & "Se ha han actualizado los Productos Facility en sistema", vbInformation, App.Title)
   Call Read_Facility
End Function

