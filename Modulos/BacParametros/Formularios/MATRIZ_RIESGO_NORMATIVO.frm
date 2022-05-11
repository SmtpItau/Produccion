VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form MATRIZ_RIESGO_NORMATIVO 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Matriz de Riesgo Equivalente."
   ClientHeight    =   5610
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   5805
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5610
   ScaleWidth      =   5805
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   5805
      _ExtentX        =   10239
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
            ImageIndex      =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   5220
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
               Picture         =   "MATRIZ_RIESGO_NORMATIVO.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "MATRIZ_RIESGO_NORMATIVO.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "MATRIZ_RIESGO_NORMATIVO.frx":11F4
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame Frame1 
      Height          =   5145
      Left            =   30
      TabIndex        =   1
      Top             =   450
      Width           =   5760
      Begin BACControles.TXTNumero TXTNumGrid 
         Height          =   210
         Left            =   2025
         TabIndex        =   5
         Top             =   870
         Visible         =   0   'False
         Width           =   930
         _ExtentX        =   1640
         _ExtentY        =   370
         BackColor       =   -2147483646
         ForeColor       =   -2147483639
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BorderStyle     =   0
         Text            =   "0"
         Text            =   "0"
         Min             =   "0"
         Max             =   "999999999"
         Separator       =   -1  'True
      End
      Begin VB.ComboBox CMBRiesgo 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   675
         Style           =   2  'Dropdown List
         TabIndex        =   3
         Top             =   180
         Width           =   2715
      End
      Begin MSFlexGridLib.MSFlexGrid Grid 
         Height          =   4575
         Left            =   30
         TabIndex        =   4
         Top             =   540
         Width           =   5700
         _ExtentX        =   10054
         _ExtentY        =   8070
         _Version        =   393216
         Cols            =   3
         FixedCols       =   0
         BackColor       =   -2147483633
         BackColorFixed  =   -2147483646
         ForeColorFixed  =   -2147483639
         Enabled         =   0   'False
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
      Begin VB.Label LBLMENSAJE 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000FF&
         Height          =   255
         Left            =   3420
         TabIndex        =   6
         Top             =   195
         Width           =   2220
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Riesgo"
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
         Left            =   75
         TabIndex        =   2
         Top             =   240
         Width           =   570
      End
   End
End
Attribute VB_Name = "MATRIZ_RIESGO_NORMATIVO"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub Grid_Setting()
   Let Grid.Rows = 50:     Let Grid.Cols = 4
   Let Grid.FixedRows = 1: Let Grid.FixedCols = 0

   Let Grid.TextMatrix(0, 0) = "Desde":    Let Grid.ColWidth(0) = 1000
   Let Grid.TextMatrix(0, 1) = "Hasta":    Let Grid.ColWidth(1) = 1000
   Let Grid.TextMatrix(0, 2) = "Factor 1": Let Grid.ColWidth(2) = 1200
   Let Grid.TextMatrix(0, 3) = "Factor 2": Let Grid.ColWidth(3) = 1200
End Sub

Private Sub Load_Riesgo()
   Dim Datos()

   Envia = Array()
   AddParam Envia, CDbl(0)
   If Not Bac_Sql_Execute("dbo.SP_MATRIZ_RIESGO_NORMATIVO", Envia) Then
      Call MsgBox("Error de lectura." & vbCrLf & "Se ha producido un erro de lectura.", vbExclamation, App.Title)
      Exit Sub
   End If
   Call CMBRiesgo.Clear
   Do While Bac_SQL_Fetch(Datos())
      Call CMBRiesgo.AddItem(Datos(2))
       Let CMBRiesgo.ItemData(CMBRiesgo.NewIndex) = Datos(1)
   Loop
   Let CMBRiesgo.ListIndex = -1
End Sub

Private Function Load_Matriz()
   Dim iContador  As Long
   Dim Datos()

   If CMBRiesgo.ListIndex < 0 Then
      Exit Function
   End If

   Envia = Array()
   AddParam Envia, CDbl(1)
   AddParam Envia, CDbl(CMBRiesgo.ItemData(CMBRiesgo.ListIndex))
   If Not Bac_Sql_Execute("dbo.SP_MATRIZ_RIESGO_NORMATIVO", Envia) Then
      Call MsgBox("Error de lectura." & vbCrLf & "Se ha producido un erro de lectura.", vbExclamation, App.Title)
      Exit Function
   End If
   Let iContador = 0
   Do While Bac_SQL_Fetch(Datos())
      Let iContador = iContador + 1
      Let Grid.TextMatrix(iContador, 0) = Datos(1)
      Let Grid.TextMatrix(iContador, 1) = Datos(2)
      Let Grid.TextMatrix(iContador, 2) = Format(Datos(3), FDecimal)
      Let Grid.TextMatrix(iContador, 3) = Format(Datos(4), FDecimal)
   Loop

   Let CMBRiesgo.Enabled = False
   Let Grid.Enabled = True
   Call Grid.SetFocus
End Function

Private Sub CMBRiesgo_Click()
   Call Load_Matriz
End Sub

Private Sub Form_Load()
   Let Me.Icon = BACSwapParametros.Icon
   Let Me.Top = 0: Let Me.Left = 0
   Call Grid_Setting
   Call Load_Riesgo
End Sub

Private Sub AJObjeto(Marco As MSFlexGrid, Objeto As Control)
   On Error Resume Next
   Let Objeto.Top = Marco.CellTop + Marco.Top
   Let Objeto.Left = Marco.CellLeft + Marco.Left
   Let Objeto.Height = Marco.CellHeight + 20
   Let Objeto.Width = Marco.CellWidth
   On Error GoTo 0
End Sub

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)
   If Toolbar1.Enabled = False Then
      If MsgBox("Se están modificando valores.." & vbCrLf & vbCrLf & "Está seguro que desea cerrar la aplicación. los valores se perderán.", vbQuestion + vbYesNo, App.Title) = vbNo Then
         Call TXTNumGrid.SetFocus
         Let Cancel = True
         Exit Sub
      End If
   End If
End Sub

Private Sub Grid_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      If Grid.ColSel = 0 Or Grid.ColSel = 1 Then
         Let TXTNumGrid.CantidadDecimales = 0
      End If
      If Grid.ColSel = 2 Or Grid.ColSel = 3 Then
         Let TXTNumGrid.CantidadDecimales = 4
      End If
      Let Toolbar1.Enabled = False
      Let TXTNumGrid.Visible = True
      Let TXTNumGrid.Text = Grid.TextMatrix(Grid.RowSel, Grid.ColSel)
      Let Grid.Enabled = False
      Call AJObjeto(Grid, TXTNumGrid)
      Call TXTNumGrid.SetFocus
   End If
   If KeyCode = vbKeyDelete Then
      If Grid.Rows = 2 Then
         Let Grid.Rows = 1: Grid.Rows = 2
      Else
         Let Grid.Rows = Grid.RowSel
         Let Grid.Rows = (50 - Grid.Rows)
         Let Grid.Row = Grid.RowSel + 1
      End If
   End If
   If KeyCode = vbKeyInsert Then
      Let Grid.Rows = Grid.Rows + 1
   End If
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 1
         Let CMBRiesgo.Enabled = True
         Let Grid.Rows = 1:   Let Grid.Rows = 50
         Let Grid.Enabled = False
          Let CMBRiesgo.ListIndex = -1
         Call CMBRiesgo.SetFocus
      Case 2
         Call Save_Data
      Case 3
         Call Unload(Me)
   End Select
End Sub

Private Sub TXTNumGrid_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      If Grid.ColSel = 0 Or Grid.ColSel = 1 Then
         Let LBLMENSAJE.Caption = ""
         If Validacion(CDbl(TXTNumGrid.Text)) = False Then
            Exit Sub
         End If
      End If
      Let Grid.Enabled = True
      Let Toolbar1.Enabled = True
      If Grid.ColSel = 0 Or Grid.ColSel = 1 Then
         Let Grid.TextMatrix(Grid.RowSel, Grid.ColSel) = CDbl(TXTNumGrid.Text)
         Let Grid.TextMatrix(Grid.RowSel, 2) = Format(0, FDecimal)
         Let Grid.TextMatrix(Grid.RowSel, 3) = Format(0, FDecimal)
      Else
         Let Grid.TextMatrix(Grid.RowSel, Grid.ColSel) = Format(CDbl(TXTNumGrid.Text), FDecimal)
      End If
      Let TXTNumGrid.Visible = False
   End If

   If KeyCode = vbKeyEscape Then
      Let LBLMENSAJE.Caption = ""
      Let Grid.Enabled = True
      Let Toolbar1.Enabled = True
      Let TXTNumGrid.Visible = False
   End If
End Sub

Private Function Validacion(ByVal xValor As Double) As Boolean
   On Error Resume Next
   Dim nContador  As Long

   Let Validacion = False

   If Grid.RowSel = 1 And Grid.ColSel = 0 Then
      If xValor <> 0 Then
         Let LBLMENSAJE.Caption = "Se esperaba un cero."
         On Error GoTo 0
         Exit Function
      End If
      Let Validacion = True
      On Error GoTo 0
      Exit Function
   End If
   
   If Grid.RowSel = 1 And Grid.ColSel = 1 Then
      If Val(Grid.TextMatrix(1, 0)) < xValor Then
         Let Validacion = True
      End If
      On Error GoTo 0
      Exit Function
   End If

   If Grid.ColSel = 0 Then
      If Val(Grid.TextMatrix(Grid.RowSel - 1, 1)) >= xValor Then
         Let LBLMENSAJE.Caption = "Valor Incorrecto."
         On Error GoTo 0
         Exit Function
      End If
      If Abs((Val(Grid.TextMatrix(Grid.RowSel - 1, 1)) - xValor)) > Abs(1) Then
         Let LBLMENSAJE.Caption = "NO se permiten lagunas."
         On Error GoTo 0
         Exit Function
      End If
   End If

   If Grid.ColSel = 1 Then
      If Val(Grid.TextMatrix(Grid.RowSel, 0)) >= xValor Then
         Let LBLMENSAJE.Caption = "Valor Incorrecto."
         On Error GoTo 0
         Exit Function
      End If
   End If

   If Grid.Rows > Grid.RowSel Then
      If Grid.TextMatrix(Grid.RowSel + 1, 0) <> "" Then
         If Grid.TextMatrix(Grid.RowSel + 1, 0) <= xValor Then
            If MsgBox("Error de Ingreso" & vbCrLf & vbCrLf & "El valor se solapa con el valor posterior... para continuar el sistema borrara desde el registro posterior al ingreso." & vbCrLf & "¿ Desea Continuar ?", vbExclamation + vbYesNo + vbDefaultButton2, App.Title) = vbNo Then
               Call TXTNumGrid.SetFocus
               On Error GoTo 0
               Exit Function
            End If
            Let Grid.Rows = Grid.RowSel + 1
            Let Grid.Rows = 50 - Grid.RowSel + 1
         End If
         
         If (Val(Grid.TextMatrix(Grid.RowSel + 1, 0)) - xValor) > 1 Then
            If MsgBox("Error de Ingreso" & vbCrLf & vbCrLf & "Debido a la redifinición del valor, se ha generado una laguna en los plazos." & vbCrLf & " ¿ Desea corregir los plazos siguientes de acuerdo a la redifinición ?", vbExclamation + vbYesNo + vbDefaultButton2, App.Title) = vbNo Then
               Call TXTNumGrid.SetFocus

               On Error GoTo 0
               Exit Function
            End If
            Let Grid.TextMatrix(Grid.RowSel + 1, 0) = (xValor + 1)
         End If
         
      End If
   End If

   Let Validacion = True
   
   On Error GoTo 0
   
End Function

Private Function CheckInPut() As Boolean
   Dim nContador  As Long
   
   Let CheckInPut = False
   
   For nContador = 1 To Grid.Rows - 1
      If Grid.TextMatrix(nContador, 0) <> "" Then
         If Grid.TextMatrix(nContador, 1) = "" Then
            Call MsgBox("Error de ingreso de datos... Revisar. ", vbExclamation, App.Title)
            Exit Function
         End If
      Else
         Exit For
      End If
   Next nContador
   
   Let CheckInPut = True
End Function

Private Function Save_Data()
   Dim nContador     As Long
   Dim Datos()
   
   If CMBRiesgo.ListIndex = -1 Then
      Exit Function
   End If
   
   If CheckInPut = False Then
      Exit Function
   End If
   
   Envia = Array()
   AddParam Envia, CDbl(2)
   AddParam Envia, CDbl(CMBRiesgo.ItemData(CMBRiesgo.ListIndex))
   If Not Bac_Sql_Execute("dbo.SP_MATRIZ_RIESGO_NORMATIVO", Envia) Then
      Call MsgBox("Error de Lectura." & vbCrLf & "Se ha generado un error de lectura.", vbExclamation, App.Title)
      Exit Function
   End If
   
   For nContador = 1 To Grid.Rows - 1
      If Grid.TextMatrix(nContador, 0) <> "" Then
         
         Envia = Array()
         AddParam Envia, CDbl(3)
         AddParam Envia, CDbl(CMBRiesgo.ItemData(CMBRiesgo.ListIndex))
         AddParam Envia, CDbl(Grid.TextMatrix(nContador, 0))
         AddParam Envia, CDbl(Grid.TextMatrix(nContador, 1))
         AddParam Envia, CDbl(Grid.TextMatrix(nContador, 2))
         AddParam Envia, CDbl(Grid.TextMatrix(nContador, 3))
         If Not Bac_Sql_Execute("dbo.SP_MATRIZ_RIESGO_NORMATIVO", Envia) Then
            Call MsgBox("Error de Escritura." & vbCrLf & "Se ha generado un error en la grabación.", vbExclamation, App.Title)
            Exit Function
         End If
      
      End If
   Next nContador

   Call MsgBox("Proceso Finalizado." & vbCrLf & "Proceso de actualización ha finalizado correctamente.", vbInformation, App.Title)
   Let Grid.Rows = 1
   Let Grid.Rows = 50
   Call Load_Matriz
End Function
