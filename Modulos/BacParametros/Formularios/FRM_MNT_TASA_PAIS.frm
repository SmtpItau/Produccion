VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form FRM_MNT_TASA_PAIS 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Tasas de Interés - País"
   ClientHeight    =   7590
   ClientLeft      =   45
   ClientTop       =   375
   ClientWidth     =   5640
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   7590
   ScaleWidth      =   5640
   Begin VB.Frame Frame2 
      Height          =   6825
      Left            =   0
      TabIndex        =   2
      Top             =   600
      Width           =   5520
      Begin VB.ComboBox cmbReferencia 
         BackColor       =   &H80000003&
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
         ItemData        =   "FRM_MNT_TASA_PAIS.frx":0000
         Left            =   1470
         List            =   "FRM_MNT_TASA_PAIS.frx":0002
         Style           =   2  'Dropdown List
         TabIndex        =   3
         Top             =   1485
         Visible         =   0   'False
         Width           =   1050
      End
      Begin MSFlexGridLib.MSFlexGrid Grid 
         Height          =   6465
         Left            =   0
         TabIndex        =   1
         Top             =   120
         Width           =   5475
         _ExtentX        =   9657
         _ExtentY        =   11404
         _Version        =   393216
         Cols            =   4
         FixedCols       =   0
         BackColor       =   -2147483633
         ForeColor       =   -2147483641
         BackColorFixed  =   -2147483646
         ForeColorFixed  =   -2147483639
         BackColorBkg    =   -2147483636
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
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   5640
      _ExtentX        =   9948
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
         Left            =   4560
         Top             =   0
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
               Picture         =   "FRM_MNT_TASA_PAIS.frx":0004
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_TASA_PAIS.frx":0EDE
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_TASA_PAIS.frx":11F8
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
End
Attribute VB_Name = "FRM_MNT_TASA_PAIS"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Envio As Integer
Option Explicit

Private Function SettingGrid()
   Let Grid.Rows = 2:                       Let Grid.Cols = 6 '5 Agregar el SpotLag
   Let Grid.FixedRows = 1:                  Let Grid.FixedCols = 0
   Let Grid.RowHeightMin = 315
   
   Let Grid.TextMatrix(0, 0) = "Tasa":      Let Grid.ColWidth(0) = 2000
   Let Grid.TextMatrix(0, 1) = "País":      Let Grid.ColWidth(1) = 2000
   Let Grid.TextMatrix(0, 2) = "Cod.País":  Let Grid.ColWidth(2) = 0
   Let Grid.TextMatrix(0, 3) = "Cod.Tasa":  Let Grid.ColWidth(3) = 0
   Let Grid.TextMatrix(0, 4) = "PK":        Let Grid.ColWidth(4) = 0
   Let Grid.TextMatrix(0, 5) = "Spt Lag":   Let Grid.ColWidth(5) = 1000
   
   Let Grid.Enabled = False
End Function

Private Sub cmbProducto_KeyPress(KeyAscii As Integer)
    Call gKeyPress(KeyAscii)
End Sub

Private Sub Form_Load()
 
   Me.Icon = BACSwapParametros.Icon
   Let Me.Top = 0: Let Me.Left = 0
   Call SettingGrid
   Call TasaPais
   
End Sub
Private Function SpotLag()
   Dim Datos()
   
   Envia = Array()
   AddParam Envia, 6 'Valores para Spot Lag
   If Not Bac_Sql_Execute("BacParamsuda.dbo.SP_MNT_TASA_PAIS", Envia) Then
      Call MsgBox("Error de Lectura." & vbCrLf & vbCrLf & "No se Encuentran Spot Lag", vbExclamation, App.Title)
      Exit Function
   End If
   Call cmbReferencia.Clear
   Do While Bac_SQL_Fetch(Datos())
      Call cmbReferencia.AddItem(Datos(1))
       Let cmbReferencia.ItemData(cmbReferencia.NewIndex) = Datos(1)
   Loop
   Let cmbReferencia.ListIndex = 0
End Function
Private Function pais()
   Dim Datos()
   
   Envia = Array()
   AddParam Envia, 2 'Importa sólo datos país
   If Not Bac_Sql_Execute("BacParamsuda.dbo.SP_MNT_TASA_PAIS", Envia) Then
      Call MsgBox("Error de Lectura." & vbCrLf & vbCrLf & "No se Encuentran Tasas por País.", vbExclamation, App.Title)
      Exit Function
   End If
   Call cmbReferencia.Clear
   Do While Bac_SQL_Fetch(Datos())
      Call cmbReferencia.AddItem(Datos(1))
       Let cmbReferencia.ItemData(cmbReferencia.NewIndex) = Datos(2)
   Loop
   Let cmbReferencia.ListIndex = 0
End Function
Private Function tasas()
   Dim Datos()
   
   Envia = Array()
   AddParam Envia, 3 'Importa sólo datos tasa
   If Not Bac_Sql_Execute("BacParamsuda.dbo.SP_MNT_TASA_PAIS", Envia) Then
      Call MsgBox("Error de Lectura." & vbCrLf & vbCrLf & "No se Encuentran Tasas por País.", vbExclamation, App.Title)
      Exit Function
   End If
   Call cmbReferencia.Clear
   Do While Bac_SQL_Fetch(Datos())
      Call cmbReferencia.AddItem(Datos(1))
       Let cmbReferencia.ItemData(cmbReferencia.NewIndex) = Datos(2)
   Loop
   Let cmbReferencia.ListIndex = 0
End Function
Private Function TasaPais()
    Dim Datos()
    Dim nProducto  As String
    Dim cModalidad As String

    Envia = Array()
    AddParam Envia, 1  'Importa totalidad de datos (país y tasa)
    If Not Bac_Sql_Execute("BacParamsuda.dbo.SP_MNT_TASA_PAIS", Envia) Then
       Call MsgBox("Error de Lectura." & vbCrLf & vbCrLf & "No se Encuentran Tasas por País.", vbExclamation, App.Title)
        Call gKeyPress(13)
        Let Grid.Enabled = True
       Exit Function
    End If

    Let Grid.Rows = 1
    Do While Bac_SQL_Fetch(Datos())
       Let Grid.Rows = Grid.Rows + 1
       Let Grid.TextMatrix(Grid.Rows - 1, 0) = Datos(1)
       Let Grid.TextMatrix(Grid.Rows - 1, 1) = Datos(2)
       Let Grid.TextMatrix(Grid.Rows - 1, 2) = Datos(3)
       Let Grid.TextMatrix(Grid.Rows - 1, 3) = Datos(4)
       Let Grid.TextMatrix(Grid.Rows - 1, 4) = Datos(5)
       Let Grid.TextMatrix(Grid.Rows - 1, 5) = Datos(6)
    Loop

    Call gKeyPress(13)
    Let Grid.Enabled = True
End Function
Private Sub Grid_KeyDown(KeyCode As Integer, Shift As Integer)
   If Grid.RowSel = 0 And KeyCode = 13 Then Exit Sub
   If KeyCode = vbKeyReturn Then
      
      If Grid.ColSel = 0 Then
         Call tasas
         Call PosTexto(Grid, cmbReferencia)
         Let cmbReferencia.Visible = True
         Call cmbReferencia.SetFocus
         Let Grid.Enabled = False
         Let Toolbar1.Enabled = False
         Envio = 0
      End If
      
      If Grid.ColSel = 1 Then
         Call pais
         Call PosTexto(Grid, cmbReferencia)
         Let cmbReferencia.Visible = True
         Call cmbReferencia.SetFocus
         Let Grid.Enabled = False
         Let Toolbar1.Enabled = False
         Envio = 1
      End If
      
       If Grid.ColSel = 5 Then
         Call SpotLag
         Call PosTexto(Grid, cmbReferencia)
         Let cmbReferencia.Visible = True
         Call cmbReferencia.SetFocus
         Let Grid.Enabled = False
         Let Toolbar1.Enabled = False
         Envio = 2
      End If
      
      
      
      
   End If
   
   If KeyCode = vbKeyInsert Then
      Let Grid.Rows = Grid.Rows + 1
      Let Grid.Row = Grid.Rows - 1
      Let Grid.Col = 0
   End If

   If KeyCode = vbKeyDelete Then
      If Grid.Rows <= 2 Then
         Let Grid.Rows = 1

      Else
         Call Borrar
         Call Grid.RemoveItem(Grid.RowSel)
      End If
   End If
   
End Sub
Private Sub PosTexto(Marco As MSFlexGrid, Objeto As Control)
   On Error Resume Next
   Let Objeto.Top = Marco.CellTop + Marco.Top
   Let Objeto.Left = Marco.CellLeft + Marco.Left
   Let Objeto.Height = Marco.CellHeight + 20
   Let Objeto.Width = Marco.CellWidth
   On Error GoTo 0
End Sub
Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 1
         Call SaveData
      Case 2
         Call Unload(Me)
   End Select
End Sub

Private Sub cmbReferencia_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then



      Let Toolbar1.Enabled = True
      Let Grid.Enabled = True
      Call Grid.SetFocus
      If Envio = 0 Then
        Let Grid.TextMatrix(Grid.RowSel, Grid.ColSel) = cmbReferencia.List(cmbReferencia.ListIndex)
        Let Grid.TextMatrix(Grid.RowSel, 2) = cmbReferencia.ItemData(cmbReferencia.ListIndex)
        If Grid.TextMatrix(Grid.RowSel, 3) <> Empty Then Call CheckReference
      Else
        If Envio = 1 Then
           Let Grid.TextMatrix(Grid.RowSel, Grid.ColSel) = cmbReferencia.List(cmbReferencia.ListIndex)
           Let Grid.TextMatrix(Grid.RowSel, 3) = cmbReferencia.ItemData(cmbReferencia.ListIndex)
           Call CheckReference
        Else
             'La columna Spot Lag
             Let Grid.TextMatrix(Grid.RowSel, Grid.ColSel) = cmbReferencia.List(cmbReferencia.ListIndex)
             Let Grid.TextMatrix(Grid.RowSel, Grid.ColSel) = cmbReferencia.ItemData(cmbReferencia.ListIndex)
             Call CheckReference
        End If
      End If
      
      Let cmbReferencia.Visible = False
     
   End If

   If KeyCode = vbKeyEscape Then
      Let Toolbar1.Enabled = True
      Let Grid.Enabled = True
      Call Grid.SetFocus
      Let cmbReferencia.Visible = False
      
   End If
End Sub
Private Function SaveData()
   Dim nContador  As Long
   
   If Not BacBeginTransaction Then
      Exit Function
   End If

   For nContador = Grid.FixedRows To Grid.Rows - 1
         Envia = Array()
         AddParam Envia, 4
         AddParam Envia, Val(Grid.TextMatrix(nContador, 4))
         AddParam Envia, Val(Grid.TextMatrix(nContador, 2))
         AddParam Envia, Val(Grid.TextMatrix(nContador, 3))
         AddParam Envia, Val(Grid.TextMatrix(nContador, 5))

         If Not Bac_Sql_Execute("BacParamsuda.dbo.SP_MNT_TASA_PAIS", Envia) Then
            Call BacRollBackTransaction
            Call MsgBox("Error en Actualizacion de Tasa por País.", vbExclamation, App.Title)
            Exit Function
         End If

   Next nContador
   
   If Not BacCommitTransaction Then
      Exit Function
   End If
   
   Call MsgBox("Actualizacion de tasas por país, se ha completado exitosamente.", vbInformation, App.Title)

End Function
Private Function CheckReference() As Boolean
   Dim nContador  As Long

   
   Let CheckReference = False
   
   For nContador = Grid.FixedRows To Grid.Rows - 1
      If nContador <> Grid.RowSel Then
        If Val(Grid.TextMatrix(nContador, 2)) = Grid.TextMatrix(Grid.RowSel, 2) And _
             Val(Grid.TextMatrix(nContador, 3)) = Grid.TextMatrix(Grid.RowSel, 3) Then
             Call MsgBox("Validación. " & vbCrLf & "Combinación Tasa País se encuentra disponible.", vbExclamation, App.Title)
             Me.SetFocus
             Exit Function
        End If
      End If
   Next nContador
   Let CheckReference = True

End Function
Private Sub gKeyPress(intAscii As Integer)
    If intAscii = 13 Then           'detecta si la tecla presionada es Enter
        intAscii = 0                'para luego aceptar el ingreso
        SendKeys "{TAB}"
    End If
End Sub

Private Function Borrar()
   Dim Datos()
If (Grid.TextMatrix(Grid.RowSel, 4)) <> Empty Then
   Envia = Array()
   AddParam Envia, 5
   AddParam Envia, Val(Grid.TextMatrix(Grid.RowSel, 4))
   If Not Bac_Sql_Execute("BacParamsuda.dbo.SP_MNT_TASA_PAIS", Envia) Then
      Call MsgBox("Se ha producido un error en la eliminación del Items.", vbExclamation, App.Title)
      Exit Function
   End If
   Call MsgBox("Eliminacion de Registro ha finalizado correctamente.", vbInformation, App.Title)
End If
End Function
