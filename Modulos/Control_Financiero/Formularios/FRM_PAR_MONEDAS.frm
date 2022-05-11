VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Begin VB.Form FRM_PAR_MONEDAS 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Pares de Monedas"
   ClientHeight    =   5220
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   7155
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5220
   ScaleWidth      =   7155
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   7155
      _ExtentX        =   12621
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
            NumListImages   =   3
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PAR_MONEDAS.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PAR_MONEDAS.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PAR_MONEDAS.frx":11F4
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame Frame1 
      Height          =   4770
      Left            =   15
      TabIndex        =   1
      Top             =   435
      Width           =   7110
      Begin VB.ComboBox CMBMoneda 
         BackColor       =   &H80000002&
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000009&
         Height          =   330
         Left            =   2055
         Style           =   2  'Dropdown List
         TabIndex        =   3
         Top             =   525
         Visible         =   0   'False
         Width           =   1125
      End
      Begin MSFlexGridLib.MSFlexGrid Grid 
         Height          =   4575
         Left            =   45
         TabIndex        =   2
         Top             =   135
         Width           =   7020
         _ExtentX        =   12383
         _ExtentY        =   8070
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
Attribute VB_Name = "FRM_PAR_MONEDAS"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Function Grid_Setting()
   Let Grid.Rows = 50:     Let Grid.Cols = 5
   Let Grid.FixedRows = 1: Let Grid.FixedCols = 0
   
   Let Grid.TextMatrix(0, 0) = "Moneda 1":      Let Grid.ColWidth(0) = 1500
   Let Grid.TextMatrix(0, 1) = "Codigo 1":      Let Grid.ColWidth(1) = 0
   Let Grid.TextMatrix(0, 2) = "Moneda 2":      Let Grid.ColWidth(2) = 1500
   Let Grid.TextMatrix(0, 4) = "Codigo 2":      Let Grid.ColWidth(3) = 0
   Let Grid.TextMatrix(0, 4) = "Par Monedas":   Let Grid.ColWidth(4) = 2800
End Function

Private Function Load_Monedas()
   Dim DATOS()
   
   Envia = Array()
   AddParam Envia, CDbl(0)
   If Not Bac_Sql_Execute("SP_LCRPARMDAGRUMDA", Envia) Then
      Call MsgBox("Error de Lectura." & vbCrLf & vbCrLf & "Se ha generado un error en la lecturea de Monedas.", vbExclamation, App.Title)
      Exit Function
   End If
   Call CMBMoneda.Clear
   Do While Bac_SQL_Fetch(DATOS())
      Call CMBMoneda.AddItem(DATOS(2) & " - " & DATOS(3))
       Let CMBMoneda.ItemData(CMBMoneda.NewIndex) = DATOS(1)
   Loop
End Function

Private Sub CMBMoneda_KeyDown(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyReturn Then
      If Grid.ColSel = 0 Then
         Let Grid.TextMatrix(Grid.RowSel, Grid.ColSel) = Trim(Mid(CMBMoneda.Text, 1, 3))
         Let Grid.TextMatrix(Grid.RowSel, 1) = CMBMoneda.ItemData(CMBMoneda.ListIndex)
      End If
      If Grid.ColSel = 2 Then
         Let Grid.TextMatrix(Grid.RowSel, Grid.ColSel) = Trim(Mid(CMBMoneda.Text, 1, 3))
         Let Grid.TextMatrix(Grid.RowSel, 3) = CMBMoneda.ItemData(CMBMoneda.ListIndex)
      End If

      If Grid.TextMatrix(Grid.RowSel, 0) <> "" And Grid.TextMatrix(Grid.RowSel, 2) <> "" Then
         GoSub GENERA_CLAVE
      End If

      Let Grid.Enabled = True
      Let Toolbar1.Enabled = True
      Let CMBMoneda.Visible = False
      Call Grid.SetFocus
   End If

   If KeyCode = vbKeyEscape Then
      Let Grid.Enabled = True
      Let Toolbar1.Enabled = True
      Let CMBMoneda.Visible = False
      Call Grid.SetFocus
   End If

Exit Sub
GENERA_CLAVE:

   Let Grid.TextMatrix(Grid.RowSel, 4) = Grid.TextMatrix(Grid.RowSel, 0) & "_" & Grid.TextMatrix(Grid.RowSel, 2)

   If VALIDA_FILA(Grid.TextMatrix(Grid.RowSel, 4), Grid.RowSel) = False Then
      Let Grid.TextMatrix(Grid.RowSel, Grid.ColSel) = ""
      Let Grid.TextMatrix(Grid.RowSel, 4) = ""
      Exit Sub
   Else
      Return
   End If
End Sub

Private Function VALIDA_FILA(xValor As Variant, xFila As Long) As Boolean
   Dim nContador  As Long
   Dim iMoneda1   As Variant
   Dim iMoneda2   As Variant
   
   Let VALIDA_FILA = False
   
   For nContador = 1 To Grid.Rows - 1
      Let iMoneda1 = Grid.TextMatrix(nContador, 0)
      Let iMoneda2 = Grid.TextMatrix(nContador, 2)
      
      If xValor = (iMoneda1 & "_" & iMoneda2) And nContador <> xFila Then
         Call MsgBox("Par de Monedas, se encuentra especificado.", vbExclamation, App.Title)
         Exit Function
      End If
      If xValor = (iMoneda2 & "_" & iMoneda1) And nContador <> xFila Then
         Call MsgBox("Par de Monedas, se encuentra especificado.", vbExclamation, App.Title)
         Exit Function
      End If
   Next nContador

   Let VALIDA_FILA = True
End Function

Private Sub Form_Load()
   Let Me.Icon = BacControlFinanciero.Icon
   Let Me.Top = 0: Let Me.Left = 0

   Call Grid_Setting
   Call Load_Monedas
   Call Load_Data
End Sub

Private Sub AJObjeto(Marco As MSFlexGrid, Objeto As Control)
   On Error Resume Next
   Let Objeto.Top = Marco.CellTop + Marco.Top
   Let Objeto.Left = Marco.CellLeft + Marco.Left
   Let Objeto.Height = Marco.CellHeight + 20
   Let Objeto.Width = Marco.CellWidth
   On Error GoTo 0
End Sub

Private Function DeleteItems(xItem As Long) As Boolean
   Dim DATOS()
   Dim xxItems    As Long
   
   xxItems = Grid.TextMatrix(Grid.RowSel, 3)
   
   Let DeleteItems = False
   
   If MsgBox("Se eliminara un par de monedas " & Grid.TextMatrix(Grid.RowSel, 4) & vbCrLf & " ¿ esta seguro ?", vbQuestion + vbYesNo, App.Title) = vbNo Then
      Exit Function
   End If
   
   Call Grid.SetFocus
   
   Envia = Array()
   AddParam Envia, CDbl(4)
   AddParam Envia, xItem
   AddParam Envia, xxItems
   If Not Bac_Sql_Execute("SP_LCRPARMDAGRUMDA", Envia) Then
      Call MsgBox("Error de Lectura." & vbCrLf & vbCrLf & "Se ha generado un error en el proceso de lectura", vbExclamation, App.Title)
      Call Grid.SetFocus
      Exit Function
   End If
   If Bac_SQL_Fetch(DATOS()) Then
      If DATOS(1) < 0 Then
         Call MsgBox("Error de Eliminación" & vbCrLf & DATOS(2), vbExclamation, App.Title)
         Call Grid.SetFocus
         Exit Function
      End If
   End If
   
   Let DeleteItems = True

   Call MsgBox("Itemas ha sido Eliminadoen de manera correcta.", vbInformation, App.Title)
   Call Grid.SetFocus

End Function

Private Sub Grid_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyInsert Then
      Let Grid.Rows = Grid.Rows + 1
   End If
   
   If KeyCode = vbKeyDelete Then
      
      If Grid.TextMatrix(Grid.RowSel, 0) <> "" Then
         If DeleteItems(Grid.TextMatrix(Grid.RowSel, 1)) = False Then
            Exit Sub
         End If
      End If

      If Grid.Rows - 1 = Grid.FixedRows Then
         Let Grid.Rows = 1
      Else
         Call Grid.RemoveItem(Grid.RowSel)
      End If
   End If
End Sub

Private Sub Grid_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyReturn Then
      Let Toolbar1.Enabled = False
      If Grid.ColSel = 0 Or Grid.ColSel = 2 Then
         Let Grid.Enabled = False
         Let CMBMoneda.Visible = True
         If Grid.TextMatrix(Grid.RowSel, Grid.ColSel) <> "" Then
            Call buscaItems
         End If
         Call AJObjeto(Grid, CMBMoneda)
         Call CMBMoneda.SetFocus
      End If
   End If
End Sub

Private Function buscaItems()
   Dim nContador  As Long
   
   For nContador = 0 To CMBMoneda.ListCount - 1
      If Trim(Mid(CMBMoneda.List(nContador), 1, 3)) = Grid.TextMatrix(Grid.RowSel, Grid.ColSel) Then
         CMBMoneda.ListIndex = nContador
         Exit Function
      End If
   Next nContador
End Function

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 1
         Call Save_Data
      Case 2
         Call Unload(Me)
   End Select
End Sub

Private Function Save_Data()
   Dim DATOS()
   Dim nContador  As Long
   
   If Not Bac_Sql_Execute("BEGIN TRANSACTION") Then
      Call MsgBox("Error al iniciar la Transacción", vbExclamation, App.Title)
      Exit Function
   End If
   
   For nContador = 1 To Grid.Rows - 1
      If Trim(Grid.TextMatrix(nContador, 4)) <> "" Then
         Envia = Array()
         AddParam Envia, CDbl(2)
         AddParam Envia, Val(Grid.TextMatrix(nContador, 1))
         AddParam Envia, Val(Grid.TextMatrix(nContador, 3))
         If Not Bac_Sql_Execute("SP_LCRPARMDAGRUMDA", Envia) Then
            Call Bac_Sql_Execute("ROLLBACK TRANSACTION")
            Call MsgBox("Error de Escritura" & vbCrLf & vbCrLf & "Ha ocurrido un error en la actualización", vbExclamation, App.Title)
            Exit Function
         End If
      End If
   Next nContador
   
   If Not Bac_Sql_Execute("COMMIT TRANSACTION") Then
      Call MsgBox("Error al Confirmar la Transacción", vbExclamation, App.Title)
      Exit Function
   End If
   
   Call MsgBox("Accion Finalizada" & vbCrLf & vbCrLf & "Actualización de datos ha finalizao sin problemas.", vbInformation, App.Title)
   
   Call Load_Data
End Function

Private Function Load_Data()
   Dim DATOS()
   Dim nContador  As Long
   
   Envia = Array()
   AddParam Envia, CDbl(1)
   If Not Bac_Sql_Execute("SP_LCRPARMDAGRUMDA", Envia) Then
      Exit Function
   End If
   Let Grid.Rows = 1
   Let Grid.Rows = 50
   Let nContador = 0
   Do While Bac_SQL_Fetch(DATOS())
      Let nContador = nContador + 1
      Let Grid.TextMatrix(nContador, 0) = DATOS(1)
      Let Grid.TextMatrix(nContador, 1) = DATOS(2)
      Let Grid.TextMatrix(nContador, 2) = DATOS(3)
      Let Grid.TextMatrix(nContador, 3) = DATOS(4)
      Let Grid.TextMatrix(nContador, 4) = DATOS(5)
   Loop
End Function
