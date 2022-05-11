VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Begin VB.Form BacFrmCLin 
   Caption         =   "Bloqueo y Desbloqueo de Lineas por Cliente"
   ClientHeight    =   5100
   ClientLeft      =   2265
   ClientTop       =   2340
   ClientWidth     =   10740
   Icon            =   "BacFrmCLin.frx":0000
   LinkTopic       =   "Form2"
   MDIChild        =   -1  'True
   ScaleHeight     =   5100
   ScaleWidth      =   10740
   Begin VB.TextBox Txt_Motivo 
      Appearance      =   0  'Flat
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
      Left            =   1125
      MaxLength       =   2000
      TabIndex        =   12
      Top             =   855
      Width           =   960
   End
   Begin Threed.SSPanel FiltroClientes 
      Height          =   1770
      Left            =   1740
      TabIndex        =   1
      Top             =   1170
      Visible         =   0   'False
      Width           =   5175
      _Version        =   65536
      _ExtentX        =   9128
      _ExtentY        =   3122
      _StockProps     =   15
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin Threed.SSPanel SSPanel1 
         Height          =   900
         Left            =   15
         TabIndex        =   3
         Top             =   840
         Width           =   5115
         _Version        =   65536
         _ExtentX        =   9022
         _ExtentY        =   1587
         _StockProps     =   15
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BorderWidth     =   1
         Begin Threed.SSFrame SSFrame1 
            Height          =   870
            Left            =   45
            TabIndex        =   4
            Top             =   0
            Width           =   5040
            _Version        =   65536
            _ExtentX        =   8890
            _ExtentY        =   1535
            _StockProps     =   14
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Begin Threed.SSCheck ChkTodos 
               Height          =   285
               Left            =   75
               TabIndex        =   9
               Top             =   135
               Width           =   3870
               _Version        =   65536
               _ExtentX        =   6826
               _ExtentY        =   503
               _StockProps     =   78
               Caption         =   "Todos"
               ForeColor       =   -2147483641
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Value           =   -1  'True
               Font3D          =   1
            End
            Begin VB.ComboBox CmbEstado 
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   330
               ItemData        =   "BacFrmCLin.frx":000C
               Left            =   1935
               List            =   "BacFrmCLin.frx":0016
               Style           =   2  'Dropdown List
               TabIndex        =   8
               Top             =   435
               Width           =   1875
            End
            Begin VB.ComboBox CmbTipoCliente 
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   330
               Left            =   1935
               Style           =   2  'Dropdown List
               TabIndex        =   7
               Top             =   1335
               Width           =   3015
            End
            Begin VB.Label Label2 
               Caption         =   "Estado del Cliente"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H80000007&
               Height          =   315
               Left            =   75
               TabIndex        =   6
               Top             =   495
               Width           =   1905
            End
            Begin VB.Label Label1 
               Caption         =   "Tipo de Cliente"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H80000007&
               Height          =   315
               Left            =   75
               TabIndex        =   5
               Top             =   1350
               Width           =   1905
            End
         End
      End
      Begin Threed.SSPanel SSPanel2 
         Height          =   375
         Left            =   -15
         TabIndex        =   2
         Top             =   0
         Width           =   5190
         _Version        =   65536
         _ExtentX        =   9155
         _ExtentY        =   661
         _StockProps     =   15
         Caption         =   "  Filtro de Clientes"
         ForeColor       =   16777215
         BackColor       =   -2147483646
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.24
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Alignment       =   1
      End
      Begin MSComctlLib.Toolbar Toolbar3 
         Height          =   450
         Left            =   30
         TabIndex        =   10
         Top             =   390
         Width           =   5100
         _ExtentX        =   8996
         _ExtentY        =   794
         ButtonWidth     =   820
         ButtonHeight    =   794
         AllowCustomize  =   0   'False
         Appearance      =   1
         Style           =   1
         ImageList       =   "ImageList3"
         _Version        =   393216
         BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
            NumButtons      =   2
            BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Key             =   "Aceptar"
               Object.ToolTipText     =   "Aceptar"
               ImageIndex      =   1
            EndProperty
            BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Key             =   "Cancelar"
               Object.ToolTipText     =   "Cancelar"
               ImageIndex      =   2
            EndProperty
         EndProperty
         Begin MSComctlLib.ImageList ImageList3 
            Left            =   5340
            Top             =   -15
            _ExtentX        =   1005
            _ExtentY        =   1005
            BackColor       =   -2147483643
            ImageWidth      =   24
            ImageHeight     =   24
            MaskColor       =   12632256
            _Version        =   393216
            BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
               NumListImages   =   2
               BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "BacFrmCLin.frx":0033
                  Key             =   ""
               EndProperty
               BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "BacFrmCLin.frx":0F0D
                  Key             =   ""
               EndProperty
            EndProperty
         End
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   9540
      Top             =   1440
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   24
      ImageHeight     =   24
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   3
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacFrmCLin.frx":1227
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacFrmCLin.frx":2101
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacFrmCLin.frx":241B
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   11
      Top             =   0
      Width           =   10740
      _ExtentX        =   18944
      _ExtentY        =   847
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Guardar"
            Object.ToolTipText     =   "Guardar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Filtrar"
            Object.ToolTipText     =   "Filtrar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList2 
         Left            =   4815
         Top             =   -90
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   24
         ImageHeight     =   24
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   1
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacFrmCLin.frx":32F5
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin MSFlexGridLib.MSFlexGrid Grid 
      Height          =   4605
      Left            =   0
      TabIndex        =   0
      Top             =   510
      Width           =   10680
      _ExtentX        =   18838
      _ExtentY        =   8123
      _Version        =   393216
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
End
Attribute VB_Name = "BacFrmCLin"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim ColorOriginal As String

Sub Nombres_Grilla()
   Grid.Rows = 3:       Grid.Cols = 7
   Grid.FixedRows = 2:  Grid.FixedCols = 0
      
   Grid.TextMatrix(0, 0) = "":               Grid.TextMatrix(1, 0) = "":         Grid.ColWidth(0) = 0
   Grid.TextMatrix(0, 1) = "Rut ":           Grid.TextMatrix(1, 1) = "Cliente":  Grid.ColWidth(1) = 1300:   Grid.ColAlignment(1) = flexAlignLeftCenter
   Grid.TextMatrix(0, 2) = "Código":         Grid.TextMatrix(1, 2) = "Cliente":  Grid.ColWidth(2) = 1100:   Grid.ColAlignment(2) = flexAlignLeftCenter
   Grid.TextMatrix(0, 3) = "Nombre":         Grid.TextMatrix(1, 3) = "Cliente":  Grid.ColWidth(3) = 5000:   Grid.ColAlignment(3) = flexAlignLeftCenter
   Grid.TextMatrix(0, 4) = "Bloqueado":      Grid.TextMatrix(1, 4) = "":         Grid.ColWidth(4) = 1000:   Grid.ColAlignment(4) = flexAlignLeftCenter
   Grid.TextMatrix(0, 5) = "Motivo Bloqueo": Grid.TextMatrix(1, 5) = "":         Grid.ColWidth(5) = 5000:   Grid.ColAlignment(5) = flexAlignLeftCenter
   Grid.TextMatrix(0, 6) = "Modificado":     Grid.TextMatrix(1, 6) = "":         Grid.ColWidth(6) = 0:      Grid.ColAlignment(6) = flexAlignLeftCenter
End Sub

Private Sub ChkTodos_Click(Value As Integer)

   If Value <> 0 Then
      CmbTipoCliente.ListIndex = -1
      CmbEstado.ListIndex = -1
   End If

End Sub

Private Sub CmbEstado_Click()
  If Trim(CmbEstado.Text) <> "" Then
     ChkTodos.Value = False
  End If
End Sub

Private Sub CmbTipoCliente_Click()
  If Trim(CmbTipoCliente.Text) <> "" Then
     ChkTodos.Value = False
  End If
End Sub

Private Sub Form_Load()
   Me.Icon = BacControlFinanciero.Icon
   Me.Left = 0:   Me.Top = 0
   Call Nombres_Grilla
   Call Formato_Grilla(Me.Grid)
   Call Cargar_Grilla
   Call Carga_TipoCliente
   
   Let ColorOriginal = Grid.CellBackColor
   Let Txt_Motivo.Visible = False
   Let Grid.RowHeightMin = 300
   
End Sub

Sub Cargar_Grilla()
   Dim Datos()
   
   Envia = Array()
   AddParam Envia, ""
   AddParam Envia, 0
   
   If Not Bac_Sql_Execute("SP_FILTRA_BLOQUEO_LINEA", Envia) Then
      MsgBox "Problemas en la Lectura de Información ", vbExclamation, TITSISTEMA
      Exit Sub
   End If

   Grid.Rows = 3
   Do While Bac_SQL_Fetch(Datos())
      Grid.TextMatrix(Grid.Rows - 1, 1) = Datos(1)
      Grid.TextMatrix(Grid.Rows - 1, 2) = Datos(2)
      Grid.TextMatrix(Grid.Rows - 1, 3) = Datos(3)
      Grid.TextMatrix(Grid.Rows - 1, 4) = IIf(Datos(4) = "N", "NO", "SI")
      Grid.TextMatrix(Grid.Rows - 1, 5) = Datos(5)
      Grid.TextMatrix(Grid.Rows - 1, 6) = "" '--> Limpia la Columna de las Modificaciones
      Grid.Rows = Grid.Rows + 1
   Loop
      Grid.Rows = Grid.Rows - 1
End Sub

Private Sub Form_Resize()
    On Error Resume Next
        
    Grid.Width = Me.Width - 250
    Grid.Height = Me.Height - 950
    

    On Error GoTo 0
End Sub

Private Sub Grid_Click()
   If Grid.Col = 4 Then
      If Trim(Grid.TextMatrix(Grid.Row, 4)) = "NO" Then
         Grid.TextMatrix(Grid.Row, 4) = "SI"
      Else
         Grid.TextMatrix(Grid.Row, 4) = "NO"
      End If
      
      If Grid.TextMatrix(Grid.Row, 0) = "X" Then
      
         Marca_Selecciones Grid.TextMatrix(Grid.Row, 4)
      End If
        
      Let Grid.TextMatrix(Grid.RowSel, 6) = "M"
   End If
 
   If Grid.Col = 4 Then
    
        If Grid.TextMatrix(Grid.RowSel, 4) = "NO" Then
             Me.Txt_Motivo.Text = Grid.TextMatrix(Grid.Row, 5)
             Grid.TextMatrix(Grid.Row, 5) = "Cliente desbloqueado por " & gsBAC_User
        Else
             Grid.TextMatrix(Grid.Row, 5) = Me.Txt_Motivo.Text
      End If
   End If
End Sub

Private Sub Grid_DblClick()
Dim Col As Integer

   With Grid
   
      Col = .Col
   
      If .TextMatrix(.Row, 0) = "X" Then
         .TextMatrix(.Row, 0) = ""
         Call IntraDay_Marca_Operacion(Grid, .Row, ColorOriginal, AzulOsc)
      Else
         .TextMatrix(.Row, 0) = "X"
         Call IntraDay_Marca_Operacion(Grid, .Row, Celeste, AzulOsc)
      End If
      
      .Col = Col
      
   End With

   If Grid.TextMatrix(Grid.RowSel, 0) = "X" Then
      Let Grid.TextMatrix(Grid.RowSel, 0) = ""
   Else
      Let Grid.TextMatrix(Grid.RowSel, 0) = "X"
   End If
   Let Grid.TextMatrix(Grid.RowSel, 6) = "M"
   
End Sub

Private Sub Grid_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyReturn Then
        If Grid.ColSel = 5 Then
            If Grid.TextMatrix(Grid.RowSel, 4) = "SI" Then
                Txt_Motivo.Text = ""
                
                Txt_Motivo.Text = Me.Grid.TextMatrix(Grid.RowSel, Grid.ColSel)
                
                Call PROC_POSICIONA_TEXTO(Me.Grid, Txt_Motivo)
                
                Txt_Motivo.Visible = True
                Grid.Enabled = False
                Toolbar1.Enabled = False
                Toolbar3.Enabled = False
                Txt_Motivo.SetFocus
            End If
            
        End If
    End If
End Sub

Private Sub Grid_KeyPress(KeyAscii As Integer)

   If KeyAscii = vbKeyReturn Then
      Call Grid_Click
   
   End If

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 1
         Call Grabar
      Case 2
         Grid.Enabled = False
         Toolbar1.Buttons(1).Enabled = False
         CmbTipoCliente.ListIndex = -1
         CmbEstado.ListIndex = -1
         ChkTodos.Value = True
         FiltroClientes.Visible = True
      Case 3
         Unload Me
   End Select
End Sub

Private Function FuncSaveData()
   Dim nContador     As Long
   Dim Estado        As String
   Dim oRutPaso      As String
   Dim RutCliente    As Long
   Dim CodCliente    As Long
   Dim Motivos       As String
   Dim oMarca        As String
   Dim nModificados  As Long
   
   Let nModificados = 0
   
   For nContador = 2 To Grid.Rows - 1

        Let oRutPaso = Grid.TextMatrix(nContador, 1)
          Let Estado = Mid(Grid.TextMatrix(nContador, 4), 1)
      Let RutCliente = Mid(oRutPaso, 1, (Len(oRutPaso) - 2))
      Let CodCliente = Grid.TextMatrix(nContador, 2)
         Let Motivos = Grid.TextMatrix(nContador, 5)
          Let oMarca = Grid.TextMatrix(nContador, 6)
      
      If Len(oMarca) > 0 Then
         Let nModificados = nModificados + 1
         
         Envia = Array()
         AddParam Envia, Estado
         AddParam Envia, RutCliente
         AddParam Envia, CodCliente
         AddParam Envia, Motivos
         If Not Bac_Sql_Execute("SP_GUARDA_LINEAS_CLIENTE", Envia) Then
            Call MsgBox("Problema en la Actualización de Lineas", vbExclamation, App.Title)
         End If
         
         Let Grid.TextMatrix(nContador, 6) = ""
         
      End If
   Next nContador

   If nModificados > 0 Then
      Call MsgBox("Actualización de bloqueo de líneas para clientes finalizo correctamente.", vbInformation, App.Title)
   Else
      Call MsgBox("No se han encontrado modificaciones de estado.", vbExclamation, App.Title)
   End If
End Function


Sub Grabar()

   Call FuncSaveData

Exit Sub


Dim Datos()
Dim Estado  As String
Dim Rut_Cli As Long
Dim Cod_Cli As Long
   Dim Gls_Cli    As String
   Dim Mot_Blq    As String
Dim X       As Long
   Dim cMensaje   As String
        
   cMensaje = ""
   
Call BacBeginTransaction
   
   For X = 2 To Grid.Rows - 1

      Estado = Mid(Grid.TextMatrix(X, 4), 1, 1)
      Rut_Cli = Mid(Grid.TextMatrix(X, 1), 1, InStr(1, Grid.TextMatrix(X, 1), "-") - 1)
      Cod_Cli = CDbl(Grid.TextMatrix(X, 2))
      Mot_Blq = Grid.TextMatrix(X, 5)
      Gls_Cli = Trim(Grid.TextMatrix(X, 1)) & " " & Grid.TextMatrix(X, 3)
   
      Envia = Array()
      AddParam Envia, Estado
      AddParam Envia, Rut_Cli
      AddParam Envia, Cod_Cli
      AddParam Envia, Mot_Blq

      If Estado = "S" And Trim(Mot_Blq) = "" Then
         cMensaje = cMensaje & Gls_Cli & Chr(13)
      End If
   
      If Not Bac_Sql_Execute("SP_GUARDA_LINEAS_CLIENTE", Envia) Then
         Call BacRollBackTransaction
         MsgBox "Problema en la Actualización de Lineas", vbExclamation, App.Title
         Exit Sub
      End If
      
     If Bac_SQL_Fetch(Datos()) Then
         If Datos(1) > 0 Then
            MsgBox Datos(2), vbExclamation, App.Title
         End If
      End If
   
   Next X
   
   Call BacCommitTransaction
   
   If Trim(cMensaje) <> "" Then
      Call MsgBox("Existen Registro de Líneas Bloqueadas SIN Motivo Ingresado... Favor Regularizar.", vbInformation, App.Title)
     'Call BacRollBackTransaction
     'Exit Sub
   End If

   Call MsgBox("Actualización de Bloqueo de Líneas para clientes finalizo correctamente.", vbInformation, App.Title)
  
End Sub

Private Sub Marca_Selecciones(Estado As String)
Dim i, X As Integer
   
   With Grid
   
      For i = .FixedRows To .Rows - 1
   
         If .TextMatrix(i, 0) = "X" Then
         
            .TextMatrix(i, 4) = Estado
         
         End If
   
      Next i

   End With

End Sub

Private Sub Toolbar2_ButtonClick(ByVal Button As MSComctlLib.Button)
   
   Grid.Enabled = False
   Toolbar1.Buttons(1).Enabled = False
   Toolbar1.Buttons(3).Enabled = False
   Toolbar2.Buttons(1).Enabled = False
   CmbTipoCliente.ListIndex = -1
   CmbEstado.ListIndex = -1
   ChkTodos.Value = True
   FiltroClientes.Visible = True

End Sub

Private Sub Toolbar3_ButtonClick(ByVal Button As MSComctlLib.Button)
Dim Datos()

   Select Case UCase(Button.Key)
         Case "ACEPTAR"
         
                        
               Envia = Array()
               
               If ChkTodos.Value Then
               
                  AddParam Envia, ""
                  AddParam Envia, 0
               
               Else
               
                  AddParam Envia, IIf(Left(CmbEstado.Text, 1) = "B", "S", "N")
                  AddParam Envia, Val(Right(CmbTipoCliente.Text, 1))
               
               End If
               
               
               If Not Bac_Sql_Execute("SP_FILTRA_BLOQUEO_LINEA", Envia) Then
                  MsgBox "Problemas en la Lectura de Información ", vbExclamation, TITSISTEMA
                  Exit Sub
               End If
            
               Grid.Rows = 3
               Do While Bac_SQL_Fetch(Datos())
                  Grid.TextMatrix(Grid.Rows - 1, 1) = Datos(1)
                  Grid.TextMatrix(Grid.Rows - 1, 2) = Datos(2)
                  Grid.TextMatrix(Grid.Rows - 1, 3) = Datos(3)
                  Grid.TextMatrix(Grid.Rows - 1, 4) = IIf(Datos(4) = "N", "NO", "SI")
                  Grid.Rows = Grid.Rows + 1
               Loop
                  Grid.Rows = Grid.Rows - 1
         
         
   End Select
         
   Grid.Enabled = True
   
   If Grid.Rows = Grid.FixedRows Then
      Grid.Col = 0
      Grid.Enabled = False

   End If


   Toolbar1.Buttons(1).Enabled = True
   Toolbar1.Buttons(3).Enabled = True
   FiltroClientes.Visible = False

End Sub

Private Sub Carga_TipoCliente()
Dim Datos()

   Envia = Array()
   AddParam Envia, "06"

   If Not Bac_Sql_Execute("SP_LEERCODIGOS2", Envia) Then

      MsgBox "Problems en la carga de Tipo Clientes", vbExclamation, TITSISTEMA
      Exit Sub
   End If

   CmbTipoCliente.Clear

   While Bac_SQL_Fetch(Datos())

      CmbTipoCliente.AddItem Datos(3) + Space(100) + Datos(2)

   Wend

   CmbTipoCliente.ListIndex = -1

End Sub

Private Sub Txt_Motivo_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyEscape Then
        Grid.Enabled = True
        Toolbar1.Enabled = True
        Toolbar3.Enabled = True
        Txt_Motivo.Visible = False
        Grid.SetFocus
    End If
    If KeyCode = vbKeyReturn Then
        Grid.TextMatrix(Grid.RowSel, Grid.ColSel) = Txt_Motivo.Text
        Grid.Enabled = True
        Toolbar1.Enabled = True
        Toolbar3.Enabled = True
        Txt_Motivo.Visible = False
        Grid.SetFocus
    End If
End Sub

Private Sub Txt_Motivo_KeyPress(KeyAscii As Integer)
    KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub
