VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form FRM_MNT_PERFILUSUARIO 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Form2"
   ClientHeight    =   9000
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   14025
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   9000
   ScaleWidth      =   14025
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   14025
      _ExtentX        =   24739
      _ExtentY        =   794
      ButtonWidth     =   767
      ButtonHeight    =   741
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
         Left            =   6075
         Top             =   120
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
               Picture         =   "FRM_MNT_PERFILUSUARIO.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_PERFILUSUARIO.frx":0EDA
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame Frame1 
      Height          =   8595
      Left            =   15
      TabIndex        =   1
      Top             =   390
      Width           =   14040
      Begin VB.ComboBox cmbUsuario 
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
         TabIndex        =   4
         Top             =   360
         Width           =   7575
      End
      Begin VB.Frame Frame2 
         Enabled         =   0   'False
         Height          =   1530
         Left            =   15
         TabIndex        =   2
         Top             =   660
         Width           =   13965
         Begin VB.CheckBox chkMarcxarTodos 
            Caption         =   "Marcar Todos"
            BeginProperty Font 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   255
            Left            =   9315
            TabIndex        =   17
            Top             =   1185
            Width           =   3795
         End
         Begin VB.ComboBox cmbSistemas 
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
            Left            =   5640
            Style           =   2  'Dropdown List
            TabIndex        =   15
            Top             =   1140
            Width           =   2655
         End
         Begin VB.CheckBox chk_INST_FIN 
            Alignment       =   1  'Right Justify
            Caption         =   "Instituciones Financieras"
            BeginProperty Font 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   285
            Left            =   675
            TabIndex        =   14
            Top             =   420
            Width           =   2955
         End
         Begin VB.CheckBox chk_OTR_INST 
            Alignment       =   1  'Right Justify
            Caption         =   "Otras Instituciones"
            BeginProperty Font 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   285
            Left            =   3780
            TabIndex        =   13
            Top             =   420
            Width           =   2955
         End
         Begin VB.CheckBox chk_IMPR_PAP 
            Alignment       =   1  'Right Justify
            Caption         =   "Impresion de Papeletas"
            BeginProperty Font 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   285
            Left            =   675
            TabIndex        =   12
            Top             =   675
            Width           =   2955
         End
         Begin VB.CheckBox chk_MONT_OPER 
            Alignment       =   1  'Right Justify
            Caption         =   "Monitor de Operaciones"
            BeginProperty Font 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   285
            Left            =   675
            TabIndex        =   11
            Top             =   915
            Width           =   2955
         End
         Begin VB.CheckBox chk_LIB_OPER 
            Alignment       =   1  'Right Justify
            Caption         =   "Liberación de Operaciones"
            BeginProperty Font 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   285
            Left            =   675
            TabIndex        =   10
            Top             =   1170
            Width           =   2955
         End
         Begin VB.Label Etiquetas 
            AutoSize        =   -1  'True
            Caption         =   "Modulos"
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
            Index           =   1
            Left            =   5655
            TabIndex        =   16
            Top             =   945
            Width           =   705
         End
         Begin VB.Label Etiquetas 
            Alignment       =   2  'Center
            Caption         =   "LINEAS DE CREDITO"
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
            Index           =   2
            Left            =   45
            TabIndex        =   3
            Top             =   150
            Width           =   6660
         End
      End
      Begin VB.Frame Frame3 
         Enabled         =   0   'False
         Height          =   6465
         Left            =   15
         TabIndex        =   5
         Top             =   2100
         Width           =   13965
         Begin VB.PictureBox ConCheck 
            BorderStyle     =   0  'None
            Height          =   270
            Index           =   0
            Left            =   6105
            Picture         =   "FRM_MNT_PERFILUSUARIO.frx":11F4
            ScaleHeight     =   270
            ScaleWidth      =   285
            TabIndex        =   8
            Top             =   240
            Visible         =   0   'False
            Width           =   285
         End
         Begin VB.PictureBox SinCheck 
            BorderStyle     =   0  'None
            Height          =   270
            Index           =   0
            Left            =   5805
            Picture         =   "FRM_MNT_PERFILUSUARIO.frx":134E
            ScaleHeight     =   270
            ScaleWidth      =   285
            TabIndex        =   7
            Top             =   240
            Visible         =   0   'False
            Width           =   285
         End
         Begin MSFlexGridLib.MSFlexGrid GRID 
            Height          =   6285
            Left            =   30
            TabIndex        =   6
            Top             =   150
            Width           =   13890
            _ExtentX        =   24500
            _ExtentY        =   11086
            _Version        =   393216
            Cols            =   4
            FixedCols       =   3
            BackColor       =   12632256
            ForeColor       =   -2147483641
            BackColorFixed  =   -2147483646
            ForeColorFixed  =   -2147483640
            ForeColorSel    =   -2147483643
            BackColorBkg    =   12632256
            GridColor       =   -2147483642
            GridColorFixed  =   -2147483642
            WordWrap        =   -1  'True
            FillStyle       =   1
            GridLines       =   0
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
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Usuario"
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
         Left            =   690
         TabIndex        =   9
         Top             =   165
         Width           =   645
      End
   End
End
Attribute VB_Name = "FRM_MNT_PERFILUSUARIO"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim oTodos        As Boolean
Dim Original()
Dim Modificacion()

Private Function Setting_Grid()
   Let Grid.Rows = 2:      Let Grid.Cols = 4
   Let Grid.FixedRows = 1: Let Grid.FixedCols = 3
   Let Grid.CellPictureAlignment = 4
   Let Grid.RowHeightMin = 300

   Let Grid.TextMatrix(0, 0) = "Sistema":    Let Grid.ColWidth(0) = 700:   Let Grid.ColAlignment(0) = flexAlignLeftCenter
   Let Grid.TextMatrix(0, 1) = "Codprod":    Let Grid.ColWidth(1) = 0:     Let Grid.ColAlignment(1) = flexAlignLeftCenter
   Let Grid.TextMatrix(0, 2) = "Producto":   Let Grid.ColWidth(2) = 3000:  Let Grid.ColAlignment(2) = flexAlignLeftCenter
End Function

Private Sub Load_User()
   Dim Datos()

   Envia = Array()
   AddParam Envia, CDbl(1)
   If Not Bac_Sql_Execute("dbo.SP_PERFIL_USUARIO_LINEAS", Envia) Then
      Call MsgBox("Se ha producido un error en la carga de usuarios.", vbExclamation, App.Title)
      Exit Sub
   End If
   Call cmbUsuario.Clear
   Do While Bac_SQL_Fetch(Datos())
      Call cmbUsuario.AddItem(Datos(2) & Space(500) & Datos(1))
   Loop
End Sub

Private Sub Load_Sistemas()
   Dim Datos()

   Envia = Array()
   AddParam Envia, CDbl(3)
   If Not Bac_Sql_Execute("dbo.SP_PERFIL_USUARIO_LINEAS", Envia) Then
      Call MsgBox("Se ha producido un error en la carga de usuarios.", vbExclamation, App.Title)
      Exit Sub
   End If
   Call cmbUsuario.Clear
  'Call cmbSistemas.AddItem("TODOS" & Space(500) & "")
   Do While Bac_SQL_Fetch(Datos())
      Call cmbSistemas.AddItem(Datos(2) & Space(500) & Datos(1))
   Loop
   Let cmbSistemas.ListIndex = 0
End Sub

Private Sub chk_IMPR_PAP_Click()
   Call Genera_Log("IMPRESION PAPELETA.", IIf(chk_IMPR_PAP.Value = 0, 1, 0), chk_IMPR_PAP.Value)
End Sub
Private Sub chk_INST_FIN_Click()
   Call Genera_Log("INST. FINANCIERA.", IIf(chk_INST_FIN.Value = 0, 1, 0), chk_INST_FIN.Value)
End Sub
Private Sub chk_LIB_OPER_Click()
   Call Genera_Log("LIBERACION DE OPERACIONES.", IIf(chk_LIB_OPER.Value = 0, 1, 0), chk_LIB_OPER.Value)
End Sub
Private Sub chk_MONT_OPER_Click()
   Call Genera_Log("MONITOREO OPERACIONES.", IIf(chk_MONT_OPER.Value = 0, 1, 0), chk_MONT_OPER.Value)
End Sub
Private Sub chk_OTR_INST_Click()
   Call Genera_Log("OTRAS INSTITUCIONES.", IIf(chk_OTR_INST.Value = 0, 1, 0), chk_OTR_INST.Value)
End Sub

Private Sub chkMarcxarTodos_Click()
   Dim nFilas     As Long
   Dim nColumnas  As Long
   Dim oAccion    As Boolean
   
   Let oAccion = chkMarcxarTodos.Value
   Let Grid.Redraw = False
   
   For nFilas = 1 To Grid.Rows - 1
      For nColumnas = Grid.FixedCols To Grid.Cols - 1
         
         If oAccion = True Then
            Let Grid.Row = nFilas
            Let Grid.Col = nColumnas
            Let Grid.Text = "."
            Let Grid.CellPictureAlignment = flexAlignCenterCenter '->>>>>> flexAlignLeftCenter '->> flexAlignCenterCenter
            Set Grid.CellPicture = ConCheck(0).Picture
         Else
            Let Grid.Row = nFilas
            Let Grid.Col = nColumnas
            Let Grid.Text = ""
            Let Grid.CellPictureAlignment = flexAlignCenterCenter '->>>>>> flexAlignLeftCenter '->> flexAlignCenterCenter
            Set Grid.CellPicture = SinCheck(0).Picture
         End If

      Next nColumnas
   Next nFilas
   Let Grid.Redraw = True
 
   If oAccion = True Then
      Let chkMarcxarTodos.Caption = "DESMARCAR TODOS"
   Else
      Let chkMarcxarTodos.Caption = "MARCAR TODOS"
   End If

End Sub

Private Sub cmbSistemas_Click()
   Call Setting_Grid_Dinamic(Trim(Right(cmbSistemas.List(cmbSistemas.ListIndex), 5)))
   Call LLER_DATOS
End Sub

Private Sub cmbUsuario_Click()
   
   If cmbUsuario.ListIndex < 0 Then
      Exit Sub
   End If

   Let Frame2.Enabled = True
   Let Frame3.Enabled = True

   Call LLER_DATOS
   
   Call Limpiar_Log
      
End Sub

Private Sub Form_Load()
   Let Me.top = 0: Let Me.Left = 0
   Let Me.Icon = BacControlFinanciero.Icon
   Let Me.Caption = "Mantención de Perfiles de Acceso a Líneas."

   Call Setting_Grid
   Call Load_Sistemas
   Call Load_User
   Call Setting_Grid_Dinamic(Trim(Right(cmbSistemas.List(cmbSistemas.ListIndex), 5)))
End Sub

Private Function Setting_Grid_Dinamic(ByVal xModulo As String)
   Dim Datos()
   Dim nFilas  As Long

   Let Grid.Redraw = False
   Let Grid.RowHeightMin = 300

   Envia = Array()
   AddParam Envia, CDbl(2)
   AddParam Envia, ""
   AddParam Envia, xModulo
   If Not Bac_Sql_Execute("dbo.SP_PERFIL_USUARIO_LINEAS", Envia) Then
      Call MsgBox("se ha originado un error al tratar de leer los productos asociados al modulos.", vbExclamation, App.Title)
      Let Grid.Redraw = True
      Exit Function
   End If
   Let Grid.Rows = 1
   Do While Bac_SQL_Fetch(Datos())
      Let Grid.Rows = Grid.Rows + 1
      Let Grid.TextMatrix(Grid.Rows - 1, 0) = Datos(1)
      Let Grid.TextMatrix(Grid.Rows - 1, 1) = Datos(2)
      Let Grid.TextMatrix(Grid.Rows - 1, 2) = Datos(3)
   Loop

   Envia = Array()
   AddParam Envia, CDbl(4)
   If Not Bac_Sql_Execute("dbo.SP_PERFIL_USUARIO_LINEAS", Envia) Then
      Call MsgBox("se ha originado un error al tratar de leer los productos asociados al modulos.", vbExclamation, App.Title)
      Let Grid.Redraw = True
      Exit Function
   End If

   Let Grid.Cols = 3
   Do While Bac_SQL_Fetch(Datos())
      Let Grid.Cols = Grid.Cols + 1
      Let Grid.ColWidth(Grid.Cols - 1) = 750
      Let Grid.ColAlignment(Grid.Cols - 1) = flexAlignCenterCenter
      Let Grid.TextMatrix(0, Grid.Cols - 1) = Datos(2) & Space(100) & Datos(1)

      For nFilas = 1 To Grid.Rows - 1
         Let Grid.Row = nFilas
         Let Grid.Col = Grid.Cols - 1
         Let Grid.Text = ""
         Let Grid.CellPictureAlignment = flexAlignCenterCenter '->>>>>> flexAlignLeftCenter '->> flexAlignCenterCenter
         Set Grid.CellPicture = SinCheck(0).Picture
      Next nFilas
   Loop

   Let Grid.Redraw = True
End Function

Private Sub GRID_Click()
   Dim Tmp     As Variant
   
   If Grid.ColSel < 3 Then
      Exit Sub
   End If

   Let Tmp = Trim(Mid(Grid.TextMatrix(0, Grid.ColSel), 1, 20))
   
   If Grid.TextMatrix(Grid.RowSel, Grid.ColSel) = "" Then
      Let Grid.Row = Grid.RowSel
      Let Grid.Col = Grid.ColSel
      Let Grid.Text = "."
      Let Grid.CellPictureAlignment = flexAlignCenterCenter '->>>>>> flexAlignLeftCenter '->> flexAlignCenterCenter
      Set Grid.CellPicture = ConCheck(0).Picture
   Else
      Let Grid.Row = Grid.RowSel
      Let Grid.Col = Grid.ColSel
      Let Grid.Text = ""
      Let Grid.CellPictureAlignment = flexAlignCenterCenter '->>>>>> flexAlignLeftCenter '->> flexAlignCenterCenter
      Set Grid.CellPicture = SinCheck(0).Picture
   End If
   
   Call Genera_Log("Tipo de Cliente " & Tmp, IIf(Grid.Text = "", "1", "0"), IIf(Grid.Text = "", "0", "1"))

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 2
         Call GRABAR_DATOS
      Case 3
         Call Unload(Me)
   End Select
End Sub

Private Function GRABAR_DATOS()
   Dim nContador  As Long
   Dim nColumnas  As Long

   If cmbUsuario.ListIndex < 0 Then
      Exit Function
   End If

   Envia = Array()
   AddParam Envia, CDbl(5)
   AddParam Envia, UCase(Trim(Right(cmbUsuario.List(cmbUsuario.ListIndex), 20)))
   AddParam Envia, UCase(Trim(Right(cmbSistemas.List(cmbSistemas.ListIndex), 5)))
   If Not Bac_Sql_Execute("dbo.SP_PERFIL_USUARIO_LINEAS", Envia) Then
      Call MsgBox("Se ha producido un error al intentar al actualizar la información.", vbExclamation, App.Title)
      Exit Function
   End If

   For nContador = 1 To Grid.Rows - 1
      For nColumnas = 3 To Grid.Cols - 1
         Envia = Array()
         AddParam Envia, CDbl(6)                                        '->> Indicador de Grabación
         AddParam Envia, UCase(Trim(Right(cmbUsuario, 20)))             '->> Indicador de Usuario BAC
         AddParam Envia, Grid.TextMatrix(nContador, 0)                  '->> Indicador de Sistema BAC

         AddParam Envia, CDbl(chk_INST_FIN.Value)                       '->> Valor para Ver paleta de Instituciones Financieras
         AddParam Envia, CDbl(chk_OTR_INST.Value)                       '->> Valor para Ver paleta de Otras Instituciones
         AddParam Envia, CDbl(chk_IMPR_PAP.Value)                       '->> Valor para Imprimir Papeletas
         AddParam Envia, CDbl(chk_MONT_OPER.Value)                      '->> Valor Ingresar al Monitoreo de Operaciones
         AddParam Envia, CDbl(chk_LIB_OPER.Value)                       '->> Valor Ingresar a la Liberacion de Lineas
         AddParam Envia, Grid.TextMatrix(nContador, 1)                  '->> Codigo de Producto
         AddParam Envia, Val(Right(Grid.TextMatrix(0, nColumnas), 5))   '->> Codigo de Cliente [Tipo]
         If Len(Grid.TextMatrix(nContador, nColumnas)) = 0 Then         '->> Indicador de Activación de Tipo de Cliente en Filtro
            AddParam Envia, CDbl(0)
         Else
            AddParam Envia, CDbl(1)
         End If
         If Not Bac_Sql_Execute("dbo.SP_PERFIL_USUARIO_LINEAS", Envia) Then
            Call MsgBox("Se ha producido un error al intentar al actualizar la información.", vbExclamation, App.Title)
            Exit Function
         End If
      Next nColumnas
   Next nContador

   Call MsgBox("Actualización ha finalizado correctamente.", vbInformation, App.Title)

   Call Grabar_Log

End Function

Private Function LIMPIAR_MARCAS()
   Dim nFila      As Long
   Dim nColumna   As Long

   Let Grid.Redraw = False

   For nFila = 1 To Grid.Rows - 1
      For nColumna = 3 To Grid.Cols - 1
         Let Grid.Row = nFila
         Let Grid.Col = nColumna
         Let Grid.Text = ""
         Let Grid.CellPictureAlignment = flexAlignCenterCenter '->>>>>> flexAlignLeftCenter '->> flexAlignCenterCenter
         Set Grid.CellPicture = SinCheck(0).Picture
      Next nColumna
   Next nFila

   Let Grid.Redraw = True

End Function


Private Function LLER_DATOS()
   Dim nFila      As Long
   Dim nColumna   As Long
   Dim Datos()

   If cmbUsuario.ListIndex < 0 Then
      Exit Function
   End If

   Call LIMPIAR_MARCAS

   Let chkMarcxarTodos.Caption = "MARCAR TODOS"
   Let chkMarcxarTodos.Value = 0

   Envia = Array()
   AddParam Envia, CDbl(7)
   AddParam Envia, UCase(Trim(Right(cmbUsuario, 20)))
   AddParam Envia, ""
   If Not Bac_Sql_Execute("dbo.SP_PERFIL_USUARIO_LINEAS", Envia) Then
      Call MsgBox("Se ha producido un error al intentar leer información de perfiles de acceso.", vbExclamation, App.Title)
      Exit Function
   End If

   Let Grid.Redraw = False
   Let oTodos = True
   
   Do While Bac_SQL_Fetch(Datos())
      Let chk_INST_FIN.Value = Datos(3)                      '->> Valor para Ver paleta de Instituciones Financieras
      Let chk_OTR_INST.Value = Datos(4)                      '->> Valor para Ver paleta de Otras Instituciones
      Let chk_IMPR_PAP.Value = Datos(5)                      '->> Valor para Imprimir Papeletas
      Let chk_MONT_OPER.Value = Datos(6)                     '->> Valor Ingresar al Monitoreo de Operaciones
      Let chk_LIB_OPER.Value = Datos(7)                      '->> Valor Ingresar a la Liberacion de Lineas

      For nFila = 1 To Grid.Rows - 1                         '->> Recorre las Filas para encontrar el Sistema y Producto
         '->> Si encuentra coincidencias de Sistema y Producto
         
         If Datos(2) = Grid.TextMatrix(nFila, 0) And Datos(8) = Grid.TextMatrix(nFila, 1) Then
            
            For nColumna = 3 To Grid.Cols - 1                '--> Recorre las Columnas de la Fila para Encontrar el Tipo de Cliente
               
               '->> Buscando el Tipo de Cliente en la Fila de los Titulos
               If Datos(9) = Val(Right(Grid.TextMatrix(0, nColumna), 5)) Then
                  If Datos(10) = 1 Then
                     Let Grid.Row = nFila
                     Let Grid.Col = nColumna
                     Let Grid.Text = "."
                     Let Grid.CellPictureAlignment = flexAlignCenterCenter '->>>>>> flexAlignLeftCenter '->> flexAlignCenterCenter
                     Set Grid.CellPicture = ConCheck(0).Picture
                     'Let oTodos = True
                  Else
                     Let oTodos = False
                  End If
               End If
            
            Next nColumna
         
         End If

      Next nFila

   Loop

   If oTodos = True Then
      Let chkMarcxarTodos.Caption = "DESMARCAR TODOS"
      Let chkMarcxarTodos.Value = 1
   End If
  ' Else
  '    Let chkMarcxarTodos.Caption = "MARCAR TODOS"
  '    Let chkMarcxarTodos.Value = 0
  ' End If

   Let Grid.Redraw = True
End Function


Private Function Genera_Log(ByVal oGlosa As String, ByVal oValorOriginal As Variant, ByVal oValorNuevo As Variant)

       AddParam Original, oGlosa & " : " & IIf(oValorOriginal = 1, "HABILITADO", "DESHABILITADO")
   AddParam Modificacion, oGlosa & " : " & IIf(oValorNuevo = 1, "HABILITADO", "DESHABILITADO")

End Function

Private Function Grabar_Log()
   Dim nContador  As Long
   Dim Modulo     As String
   Dim Menu       As String
   Dim Evento     As String
   Dim Detalle    As String
   Dim Tabla      As String
   
   Let Modulo = "SCF"
   Let Menu = "OPT_70031"
   Let Evento = "01"
   Let Detalle = "GRABACION/ACTUALIZACION DE PERFILES DE ACCESO A LINEAS"
   Let Tabla = "PERFIL_USUARIO_LINEAS"
   
   For nContador = 1 To UBound(Original)

      Call GRABA_LOG_AUDITORIA(1, Trim(gsBAC_Fecp), gsBac_IP, gsBAC_User, Modulo, Menu, Evento, Detalle, Tabla, Trim(Original(nContador)), Trim(Modificacion(nContador)))

   Next nContador
   
End Function

Private Function Limpiar_Log()
   Original = Array()
   Modificacion = Array()
End Function
