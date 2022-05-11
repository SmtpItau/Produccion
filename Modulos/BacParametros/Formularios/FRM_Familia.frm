VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.1#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form FRM_Familia 
   Caption         =   "Mantenedor Familia"
   ClientHeight    =   8400
   ClientLeft      =   120
   ClientTop       =   450
   ClientWidth     =   16140
   LinkTopic       =   "Form2"
   MDIChild        =   -1  'True
   ScaleHeight     =   8400
   ScaleWidth      =   16140
   Begin VB.TextBox TXTTextGrid 
      BackColor       =   &H80000002&
      BorderStyle     =   0  'None
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
      Height          =   195
      Left            =   3720
      TabIndex        =   3
      Text            =   "Text1"
      Top             =   1560
      Visible         =   0   'False
      Width           =   915
   End
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
      Left            =   3720
      Style           =   2  'Dropdown List
      TabIndex        =   2
      Top             =   1080
      Visible         =   0   'False
      Width           =   915
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   16140
      _ExtentX        =   28469
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
            ImageIndex      =   2
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.Visible         =   0   'False
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   6
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   3120
         Top             =   0
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
               Picture         =   "FRM_Familia.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_Familia.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_Familia.frx":1DB4
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_Familia.frx":2C8E
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_Familia.frx":3B68
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_Familia.frx":4A42
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin MSFlexGridLib.MSFlexGrid Grid 
      Height          =   7800
      Left            =   0
      TabIndex        =   1
      Top             =   600
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
Attribute VB_Name = "FRM_Familia"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False


Private Sub Form_Load()
   Let Me.Top = 0:   Let Me.Left = 0
   Let Me.Icon = BACSwapParametros.Icon
   
   Call SETTING_GRID
   Call Read_Familia
End Sub


Private Sub SETTING_GRID()
   Let Grid.Rows = 2:      Let Grid.Cols = 11
   Let Grid.FixedRows = 1: Let Grid.FixedCols = 0
   Let Grid.RowHeightMin = 315
   
   Let Grid.TextMatrix(0, 0) = "CODIGO_FAMILIA":           Let Grid.ColWidth(0) = 2500
   Let Grid.TextMatrix(0, 1) = "NOMBRE_FAMILIA":           Let Grid.ColWidth(1) = 2500
   Let Grid.TextMatrix(0, 2) = "DESCRIPCION_FAMILIA":      Let Grid.ColWidth(2) = 3500
   Let Grid.TextMatrix(0, 3) = "BASE_CALCULO":             Let Grid.ColWidth(3) = 1500
   Let Grid.TextMatrix(0, 4) = "CODIGO_MONEDA":            Let Grid.ColWidth(4) = 0
   Let Grid.TextMatrix(0, 5) = "MONEDA":                   Let Grid.ColWidth(5) = 1500
   Let Grid.TextMatrix(0, 6) = "CODIGO_MONEDA_PAGO":       Let Grid.ColWidth(6) = 0
   Let Grid.TextMatrix(0, 7) = "MONEDA_PAGO":              Let Grid.ColWidth(7) = 1500
   Let Grid.TextMatrix(0, 8) = "RUT_EMISOR":               Let Grid.ColWidth(8) = 1500
   Let Grid.TextMatrix(0, 9) = "CODIGO_EMISOR":            Let Grid.ColWidth(9) = 1500
   Let Grid.TextMatrix(0, 10) = "MODIFICA":                Let Grid.ColWidth(10) = 0
   
   
End Sub


Public Sub Read_Familia()
   Dim Datos()
   
   'Envia = Array()
   'AddParam Envia, CDbl(0)
   If Not Bac_Sql_Execute("BacParamSuda.dbo.SP_CONSULTA_FAMILIA_BONOS_EXT") Then
      Call MsgBox("Error de Lectura." & vbCrLf & vbCrLf & "Se ha generado un error en la lectura de productos.", vbExclamation, App.Title)
      Exit Sub
   End If
   Let Grid.Rows = 1
   Do While Bac_SQL_Fetch(Datos())
      Let Grid.Rows = Grid.Rows + 1
      Let Grid.TextMatrix(Grid.Rows - 1, 0) = Datos(1)   '--> CODIGO DE FAMILIA
      Let Grid.TextMatrix(Grid.Rows - 1, 1) = Datos(2)   '--> NOMBRE DE FAMILIA
      Let Grid.TextMatrix(Grid.Rows - 1, 2) = Datos(3)   '--> DESCRIPCION FAMILIA
      Let Grid.TextMatrix(Grid.Rows - 1, 3) = Datos(4)   '--> BASE DE CALCULO
      Let Grid.TextMatrix(Grid.Rows - 1, 4) = Datos(5)   '--> CODIGO DE MONEDA
      Let Grid.TextMatrix(Grid.Rows - 1, 5) = Datos(6)   '--> MONEDA NEMO
      Let Grid.TextMatrix(Grid.Rows - 1, 6) = Datos(7)   '--> CODIGO DE MONEDA PAGO
      Let Grid.TextMatrix(Grid.Rows - 1, 7) = Datos(8)   '--> MONEDA PAGO
      Let Grid.TextMatrix(Grid.Rows - 1, 8) = Datos(9)   '--> RUT EMISOR
      Let Grid.TextMatrix(Grid.Rows - 1, 9) = Datos(10)  '--> CODIGO EMISION
      Let Grid.TextMatrix(Grid.Rows - 1, 10) = Datos(11) '--> MODIFICA
     
      
   Loop
End Sub



Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

 Select Case Button.Index
      Case 1
         Call Save_Data
      Case 2
         FRM_FamiliaAgrega.Show vbModal
      Case 3
         Call Unload(Me)
   End Select
   

End Sub

Private Function Save_Data()
   Dim nContador  As Long
   Dim Datos()
   
   For nContador = 1 To Grid.Rows - 1
      Envia = Array()
      AddParam Envia, Trim(Grid.TextMatrix(nContador, 0)) 'CODIGO DE FAMILIA
      AddParam Envia, Trim(Grid.TextMatrix(nContador, 1)) 'NOMBRE DE FAMILIA
      AddParam Envia, Trim(Grid.TextMatrix(nContador, 2)) 'DESCRIPCION DE FAMILIA
      AddParam Envia, CDbl(Grid.TextMatrix(nContador, 3)) 'BASE DE CALCULO
      AddParam Envia, Trim(Grid.TextMatrix(nContador, 4)) 'CODIGO DE MONEDA
      AddParam Envia, Trim(Grid.TextMatrix(nContador, 6)) 'CODIGO DE MONEDA PAGO
      AddParam Envia, Trim(Grid.TextMatrix(nContador, 8)) 'RUT EMISOR
      AddParam Envia, Trim(Grid.TextMatrix(nContador, 9)) 'CODIGO DE EMISOR
      
      
      If Not Bac_Sql_Execute("BacParamSuda.dbo.SP_ACTUALIZAR_FAMILIA_BONOS_EXT", Envia) Then
         Call MsgBox("Error de Lectura." & vbCrLf & vbCrLf & "Se ha generado un error al actualizar Codigos de Familia.", vbExclamation, App.Title)
         Exit Function
      End If
   Next nContador
   
   Call MsgBox("Actualización Finalizada." & vbCrLf & vbCrLf & "Se ha han actualizado los los parametros de Familia en sistema", vbInformation, App.Title)
   Call Read_Familia
End Function



Private Sub Read_ComboMoneda()
   Dim Datos()
   
   If Not Bac_Sql_Execute("BacParamSuda.dbo.SP_LEER_MONEDA") Then
      Call MsgBox("Error de Lectura." & vbCrLf & vbCrLf & "Se ha generado un error en la lectura de monedas.", vbExclamation, App.Title)
      Exit Sub
   End If
   Call CMBGrid.Clear
   Do While Bac_SQL_Fetch(Datos())
      Call CMBGrid.AddItem(Datos(2))
       Let CMBGrid.ItemData(CMBGrid.NewIndex) = Datos(1)
   Loop
   CMBGrid.ListIndex = 0
   
End Sub

Private Sub GRID_DblClick()
   Call Grid_KeyDown(13, 0)
End Sub


Private Sub Grid_KeyDown(KeyCode As Integer, Shift As Integer)

   Dim Modifica As Boolean
   Modifica = CBool(Grid.TextMatrix(Grid.RowSel, 10))
   Dim Valor As String
   Dim Cod_emi As String
   Dim Emisor As String

   If Modifica = True Then

        If KeyCode = vbKeyReturn Then
        
         
           If Grid.ColSel = 5 Then
              Call Read_ComboMoneda
              Let Grid.Enabled = False
              Let CMBGrid.Visible = True
              Valor = CStr(Grid.TextMatrix(Grid.RowSel, Grid.ColSel))
              Call BuscaIDCombo(CMBGrid, Valor)
              Call AJObjeto(Grid, CMBGrid)
              Call CMBGrid.SetFocus
           End If
           
           If Grid.ColSel = 7 Then
              Call Read_ComboMoneda
              Let Grid.Enabled = False
              Let CMBGrid.Visible = True
              Valor = CStr(Grid.TextMatrix(Grid.RowSel, Grid.ColSel))
              Call BuscaIDCombo(CMBGrid, Valor)
              Call AJObjeto(Grid, CMBGrid)
              Call CMBGrid.SetFocus
           End If
           
           
           If Grid.ColSel = 0 Then Exit Sub
           If Grid.ColSel = 1 Then Exit Sub
           If Grid.ColSel = 3 Then Exit Sub
           If Grid.ColSel = 5 Then Exit Sub
           If Grid.ColSel = 7 Then Exit Sub
           If Grid.ColSel = 9 Then Exit Sub
           
           
           
           If Grid.ColSel = 8 Then
              
              BacAyuda.Tag = "EMISOR_BONOS_EXT"
              BacAyuda.Show 1
    
              If giAceptar% = True Then
                 
               
                 Emisor = CDbl(Trim(Mid(gsrut$, 44, 9)))
                 Cod_emi = CDbl(Trim(Mid(gsrut$, 58, 1)))
                 Grid.TextMatrix(Grid.RowSel, 8) = Emisor
                 Grid.TextMatrix(Grid.RowSel, 9) = Cod_emi
                 
              End If
              Exit Sub
           End If
           
                      
           
           Let Grid.Enabled = False
           Let TXTTextGrid.Visible = True
           Let TXTTextGrid.Text = Grid.TextMatrix(Grid.RowSel, Grid.ColSel)
           Call AJObjeto(Grid, TXTTextGrid)
           Call TXTTextGrid.SetFocus
           
        End If
   
   End If
End Sub
Private Sub BuscaIDCombo(Combo As ComboBox, Valor As String)

    Dim Contador As Integer
    Contador = 0

    
    
    Do While Contador <= Combo.ListCount - 1
        
       Combo.ListIndex = Contador
       
       If Combo.Text = Valor Then
           Exit Do
       End If
              
       Contador = Contador + 1
       
       
       
    Loop
    
    If Contador = Combo.ListCount Then
       Combo.ListIndex = 0
    End If


End Sub


Private Sub AJObjeto(Marco As MSFlexGrid, Objeto As Control)
   On Error Resume Next
   Let Objeto.Top = Marco.CellTop + Marco.Top
   Let Objeto.Left = Marco.CellLeft + Marco.Left
   Let Objeto.Height = Marco.CellHeight + 20
   Let Objeto.Width = Marco.CellWidth
   On Error GoTo 0
End Sub


Private Sub CMBGrid_KeyDown(KeyCode As Integer, Shift As Integer)


  

   If KeyCode = vbKeyReturn Then
      If Grid.ColSel = 5 Then
         Let Grid.TextMatrix(Grid.RowSel, Grid.ColSel) = CMBGrid.Text
         Let Grid.TextMatrix(Grid.RowSel, 4) = CMBGrid.ItemData(CMBGrid.ListIndex)
      End If
      If Grid.ColSel = 7 Then
         Let Grid.TextMatrix(Grid.RowSel, Grid.ColSel) = CMBGrid.Text
         Let Grid.TextMatrix(Grid.RowSel, 6) = CMBGrid.ItemData(CMBGrid.ListIndex)
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

Private Sub TXTTextGrid_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      Let Grid.TextMatrix(Grid.RowSel, Grid.ColSel) = TXTTextGrid.Text
      Let Grid.Enabled = True
      Call Grid.SetFocus
      Let TXTTextGrid.Visible = False
      Let Toolbar1.Enabled = True
   End If
   If KeyCode = vbKeyEscape Then
      Let Grid.Enabled = True
      Call Grid.SetFocus
      Let TXTTextGrid.Visible = False
      Let Toolbar1.Enabled = True
   End If
End Sub


