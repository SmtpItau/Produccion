VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form FRM_CLASIFICACION_AGENCIAS 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Clasificación de Riesgo por Agencia"
   ClientHeight    =   7965
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   5760
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   7965
   ScaleWidth      =   5760
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   5760
      _ExtentX        =   10160
      _ExtentY        =   794
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
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
         Left            =   2910
         Top             =   0
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
               Picture         =   "FRM_CLASIFICACION_AGENCIAS.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_CLASIFICACION_AGENCIAS.frx":0EDA
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame Fra_Filtro 
      Height          =   930
      Left            =   30
      TabIndex        =   1
      Top             =   375
      Width           =   5715
      Begin VB.ComboBox cmbAgencia 
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
         Left            =   90
         Style           =   2  'Dropdown List
         TabIndex        =   3
         Top             =   450
         Width           =   5505
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Agencia de Clasificación"
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
         Index           =   0
         Left            =   105
         TabIndex        =   2
         Top             =   210
         Width           =   2010
      End
   End
   Begin VB.Frame Fra_Detalle 
      Height          =   6720
      Left            =   45
      TabIndex        =   4
      Top             =   1215
      Width           =   5700
      Begin VB.TextBox TxtGrid 
         Alignment       =   2  'Center
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
         Height          =   225
         Left            =   1110
         TabIndex        =   6
         Text            =   "??"
         Top             =   525
         Visible         =   0   'False
         Width           =   885
      End
      Begin MSFlexGridLib.MSFlexGrid Grid 
         Height          =   6555
         Left            =   45
         TabIndex        =   5
         Top             =   135
         Width           =   5625
         _ExtentX        =   9922
         _ExtentY        =   11562
         _Version        =   393216
         Cols            =   4
         FixedCols       =   0
         RowHeightMin    =   285
         BackColor       =   -2147483633
         ForeColor       =   -2147483641
         BackColorFixed  =   -2147483646
         ForeColorFixed  =   -2147483639
         BackColorBkg    =   -2147483636
         FocusRect       =   0
         GridLines       =   2
         GridLinesFixed  =   0
         FormatString    =   ""
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
Attribute VB_Name = "FRM_CLASIFICACION_AGENCIAS"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Enum FiltroSp
    [Carga Agencias] = 1
    [Carga Clasificaciones] = 2
End Enum

Enum OpcionGrabar
    [Borrar] = 1
    [Grabar] = 2
End Enum

Private Sub Form_Load()
    Let Me.Icon = BACSwapParametros.Icon
    
    Call FuncNameGrid
    Call FuncLoadAgencias
End Sub

Private Function FuncLoadAgencias()
    Dim Datos()
    
    Call cmbAgencia.Clear
    
    Envia = Array()
    AddParam Envia, CDbl(FiltroSp.[Carga Agencias])
    If Not Bac_Sql_Execute("Sp_Load_Data_Clasificacion", Envia) Then
        Call MsgBox("Error en la carga de agencias clasificadoras", vbExclamation, App.Title)
        Exit Function
    End If
    Do While Bac_SQL_Fetch(Datos())
        Call cmbAgencia.AddItem(Datos(2)):  Let cmbAgencia.ItemData(cmbAgencia.NewIndex) = Val(Datos(1))
    Loop
End Function

Private Sub cmbAgencia_Click()
    Call FuncLoadClasificacion
End Sub


Private Function FuncLoadClasificacion()
    Dim Datos()
    
    If cmbAgencia.ListIndex = -1 Then
        Exit Function
    End If
    
    Let Grid.Rows = 1
    
    Envia = Array()
    AddParam Envia, CDbl(FiltroSp.[Carga Clasificaciones])
    AddParam Envia, CDbl(cmbAgencia.ItemData(cmbAgencia.ListIndex))
    If Not Bac_Sql_Execute("Sp_Load_Data_Clasificacion", Envia) Then
        Call MsgBox("Error en la carga de agencias clasificadoras", vbExclamation, App.Title)
        Exit Function
    End If
    Do While Bac_SQL_Fetch(Datos())
        Let Grid.Rows = Grid.Rows + 1
        Let Grid.TextMatrix(Grid.Rows - 1, 0) = Datos(2)
        Let Grid.TextMatrix(Grid.Rows - 1, 1) = Datos(3)
        Let Grid.TextMatrix(Grid.Rows - 1, 2) = Datos(4)
        Let Grid.TextMatrix(Grid.Rows - 1, 3) = Datos(5)
    Loop
End Function

Private Function FuncNameGrid()
    Let Grid.Rows = 2:      Let Grid.Cols = 4
    Let Grid.FixedRows = 1: Let Grid.FixedCols = 0
    
    Let Grid.TextMatrix(0, 0) = "Id":               Let Grid.ColWidth(0) = 700:     Let Grid.ColAlignment(0) = flexAlignLeftCenter
    Let Grid.TextMatrix(0, 1) = "Corto Plazo":      Let Grid.ColWidth(1) = 1500:    Let Grid.ColAlignment(1) = flexAlignLeftCenter
    Let Grid.TextMatrix(0, 2) = "Largo Plazo":      Let Grid.ColWidth(2) = 1500:    Let Grid.ColAlignment(2) = flexAlignLeftCenter
    Let Grid.TextMatrix(0, 3) = "Cod.  D05":        Let Grid.ColWidth(3) = 1500:    Let Grid.ColAlignment(3) = flexAlignRightCenter
End Function

Private Function FuncValida(ByVal Fila As Long) As Boolean
    Dim Datos()
    
    Let FuncValida = False
    
    If cmbAgencia.ListIndex = -1 Then
        Exit Function
    End If
    
    Envia = Array()
    AddParam Envia, CDbl(cmbAgencia.ItemData(cmbAgencia.ListIndex))
    AddParam Envia, Grid.TextMatrix(Fila, 2)
    If Not Bac_Sql_Execute("dbo.Sp_Validate_Data_Clasificacion", Envia) Then
        Exit Function
    End If
    If Bac_SQL_Fetch(Datos()) Then
        Let FuncValida = Datos(1)
    End If

    If FuncValida = False Then
        Call MsgBox(Datos(2), vbExclamation, App.Title)
        On Error Resume Next
        Call Grid.SetFocus
        On Error GoTo 0
    End If

End Function


Private Sub Grid_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyInsert Then
        Let Grid.Rows = Grid.Rows + 1
        Let Grid.TextMatrix(Grid.Rows - 1, 0) = (Grid.Rows - 1)
    End If

    If KeyCode = vbKeyDelete Then
        If FuncValida(Grid.Rows - 1) = True Then
            If Grid.Rows <= (Grid.FixedRows + 1) Then
                Grid.Rows = 1
            Else
                Let Grid.Rows = Grid.Rows - 1
            End If
        End If
    End If
    
    If KeyCode = vbKeyReturn Then
        If Grid.ColSel = 0 Then
            Exit Sub
        End If

        If FuncValida(Grid.RowSel) = False Then
            Exit Sub
        End If

        If Grid.ColSel = 1 Then Let TxtGrid.Alignment = 0:      Let TxtGrid.MaxLength = 10
        If Grid.ColSel = 2 Then Let TxtGrid.Alignment = 0:      Let TxtGrid.MaxLength = 10
        If Grid.ColSel = 3 Then Let TxtGrid.Alignment = 1:      Let TxtGrid.MaxLength = 2

        Call FuncSettingTexto(Grid, TxtGrid)

        Let TxtGrid.Visible = True: Let Grid.Enabled = False:   Let Toolbar1.Enabled = False:   Let cmbAgencia.Enabled = False:  Call TxtGrid.SetFocus:
    End If
End Sub

Private Function FuncSettingTexto(ByRef grilla As Object, ByRef texto As Object)
   On Error Resume Next
   Const PosDefecto = 20
   
    Let texto.Top = grilla.CellTop + grilla.Top + PosDefecto
    Let texto.Left = grilla.CellLeft + grilla.Left + PosDefecto
    Let texto.Width = grilla.CellWidth - PosDefecto
    Let texto.Height = grilla.CellHeight
    Let texto.Text = grilla.TextMatrix(grilla.RowSel, grilla.ColSel)
   On Error GoTo 0
End Function

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
    Select Case Button.Index
        Case 2
            Call FuncSaveData
        Case 3
            Call Unload(Me)
    End Select
End Sub

Private Sub TxtGrid_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyEscape Then
        Let Grid.Enabled = True:    Let TxtGrid.Visible = False:    Let Toolbar1.Enabled = True:    Let cmbAgencia.Enabled = True: Call Grid.SetFocus
    End If
    If KeyCode = vbKeyReturn Then
        Let Grid.TextMatrix(Grid.RowSel, Grid.ColSel) = TxtGrid.Text
        Let Grid.Enabled = True:    Let TxtGrid.Visible = False:    Let Toolbar1.Enabled = True:    Let cmbAgencia.Enabled = True: Call Grid.SetFocus
    End If
End Sub

Private Sub TxtGrid_KeyPress(KeyAscii As Integer)
    If Grid.ColSel = 3 And (KeyAscii <> vbKeyTab And KeyAscii <> vbKeyBack) Then
        If Not IsNumeric(Chr(KeyAscii)) Then
            Let KeyAscii = 0
        End If
    End If
   'Let KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub

Private Function FuncSaveData()
    On Error GoTo ErrSaveData
    Dim nContador   As Long

    If cmbAgencia.ListIndex = -1 Then
        Call MsgBox("Debe seleccionar una Agencia Clasificadora", vbExclamation, App.Title)
        Exit Function
    End If

    Call BacBeginTransaction

    Envia = Array()
    AddParam Envia, CDbl(OpcionGrabar.Borrar)
    AddParam Envia, CDbl(cmbAgencia.ItemData(cmbAgencia.ListIndex))
    If Not Bac_Sql_Execute("dbo.Sp_Save_Data_Clasificacion", Envia) Then
        Call BacRollBackTransaction
        Exit Function
    End If

    For nContador = 1 To Grid.Rows - 1
        Envia = Array()
        AddParam Envia, CDbl(OpcionGrabar.Grabar)
        AddParam Envia, CDbl(cmbAgencia.ItemData(cmbAgencia.ListIndex))
        AddParam Envia, CDbl(Grid.TextMatrix(nContador, 0))
        AddParam Envia, Grid.TextMatrix(nContador, 1)
        AddParam Envia, Grid.TextMatrix(nContador, 2)
        AddParam Envia, CDbl(Grid.TextMatrix(nContador, 3))
        If Not Bac_Sql_Execute("dbo.Sp_Save_Data_Clasificacion", Envia) Then
            Call BacRollBackTransaction
            Exit Function
        End If
    Next nContador

    Call BacCommitTransaction

Exit Function
ErrSaveData:
    
    Call BacRollBackTransaction
    Call MsgBox(Err.Description, vbExclamation, App.Title)
    
End Function
