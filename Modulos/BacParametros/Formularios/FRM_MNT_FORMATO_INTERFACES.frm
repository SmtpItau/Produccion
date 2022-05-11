VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form FRM_MNT_FORMATO_INTERFACES 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantenedor Formato Interfaces"
   ClientHeight    =   7050
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   9780
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   7050
   ScaleWidth      =   9780
   Begin VB.Frame frm3 
      Caption         =   "Validacion"
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H0080000F&
      Height          =   1680
      Left            =   4680
      TabIndex        =   20
      Top             =   2175
      Width           =   5055
      Begin VB.CheckBox chkCampo 
         Caption         =   "Campo a Campo"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H0080000F&
         Height          =   255
         Left            =   240
         TabIndex        =   23
         Top             =   1200
         Width           =   2175
      End
      Begin VB.CheckBox chkConsistencia 
         Caption         =   "Consistencia"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H0080000F&
         Height          =   375
         Left            =   240
         TabIndex        =   22
         Top             =   720
         Width           =   2175
      End
      Begin VB.CheckBox chkLargo 
         Caption         =   "Largo"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H0080000F&
         Height          =   255
         Left            =   240
         TabIndex        =   21
         Top             =   360
         Width           =   1935
      End
   End
   Begin VB.Frame frm4 
      Caption         =   "Responsables"
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H0080000F&
      Height          =   3135
      Left            =   45
      TabIndex        =   8
      Top             =   3840
      Width           =   9705
      Begin VB.TextBox txtIngreso 
         BackColor       =   &H8000000F&
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
         ForeColor       =   &H80000007&
         Height          =   315
         Left            =   1905
         TabIndex        =   9
         Text            =   "txtIngreso"
         Top             =   1185
         Visible         =   0   'False
         Width           =   2175
      End
      Begin VB.ComboBox cmbUsuario 
         BackColor       =   &H8000000F&
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   315
         Left            =   4110
         Style           =   2  'Dropdown List
         TabIndex        =   19
         Top             =   1170
         Visible         =   0   'False
         Width           =   2175
      End
      Begin MSFlexGridLib.MSFlexGrid grdResponsables 
         Height          =   2850
         Left            =   75
         TabIndex        =   4
         Top             =   195
         Width           =   9570
         _ExtentX        =   16880
         _ExtentY        =   5027
         _Version        =   393216
         FixedCols       =   0
         RowHeightMin    =   300
         BackColor       =   -2147483633
         ForeColor       =   -2147483641
         BackColorFixed  =   -2147483646
         ForeColorFixed  =   -2147483639
         BackColorBkg    =   -2147483636
         GridColor       =   -2147483633
         GridColorFixed  =   -2147483642
         AllowBigSelection=   -1  'True
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
   Begin MSComctlLib.Toolbar Tbl_Opciones 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   9780
      _ExtentX        =   17251
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
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Nuevo"
            Description     =   "Nuevo"
            Object.ToolTipText     =   "Nuevo"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Grabar"
            Description     =   "Grabar"
            Object.ToolTipText     =   "Grabar/Actualizar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Eliminar"
            Description     =   "Eliminar"
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Description     =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   5
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   6840
      Top             =   120
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   5
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_FORMATO_INTERFACES.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_FORMATO_INTERFACES.frx":0EDA
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_FORMATO_INTERFACES.frx":1DB4
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_FORMATO_INTERFACES.frx":2C8E
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_FORMATO_INTERFACES.frx":3B68
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.Frame frm1 
      Height          =   1785
      Left            =   30
      TabIndex        =   1
      Top             =   390
      Width           =   9720
      Begin VB.ComboBox cmbModulo 
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
         Left            =   2040
         Style           =   2  'Dropdown List
         TabIndex        =   24
         Top             =   255
         Width           =   2775
      End
      Begin VB.TextBox txtNombreLargo 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   345
         Left            =   2040
         TabIndex        =   13
         Top             =   930
         Width           =   4935
      End
      Begin VB.ComboBox cmbPeriodicidad 
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
         Left            =   2040
         Style           =   2  'Dropdown List
         TabIndex        =   15
         Top             =   1290
         Width           =   2775
      End
      Begin VB.TextBox txtInterfaz 
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
         Left            =   2040
         MousePointer    =   14  'Arrow and Question
         TabIndex        =   11
         Top             =   600
         Width           =   4935
      End
      Begin VB.Label Label5 
         AutoSize        =   -1  'True
         Caption         =   "Periodicidad"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   360
         TabIndex        =   14
         Top             =   1380
         Width           =   1065
      End
      Begin VB.Label Label4 
         AutoSize        =   -1  'True
         Caption         =   "Nombre Largo"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   360
         TabIndex        =   12
         Top             =   1035
         Width           =   1200
      End
      Begin VB.Label lblInterfaz 
         AutoSize        =   -1  'True
         Caption         =   "Nombre Corto"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   360
         TabIndex        =   10
         Top             =   690
         Width           =   1170
      End
      Begin VB.Label lblModulo 
         AutoSize        =   -1  'True
         Caption         =   "Modulo"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   360
         TabIndex        =   2
         Top             =   330
         Width           =   630
      End
   End
   Begin VB.Frame frm2 
      Caption         =   "Largos"
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H0080000F&
      Height          =   1695
      Left            =   45
      TabIndex        =   3
      Top             =   2160
      Width           =   4575
      Begin BACControles.TXTNumero txtLenUltimo 
         Height          =   375
         Left            =   2040
         TabIndex        =   18
         Top             =   1080
         Width           =   1575
         _ExtentX        =   2778
         _ExtentY        =   661
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0"
         Text            =   "0"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTNumero txtLenCuerpo 
         Height          =   375
         Left            =   2040
         TabIndex        =   17
         Top             =   720
         Width           =   1575
         _ExtentX        =   2778
         _ExtentY        =   661
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0"
         Text            =   "0"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTNumero txtLenEncabezado 
         Height          =   375
         Left            =   2040
         TabIndex        =   16
         Top             =   360
         Width           =   1575
         _ExtentX        =   2778
         _ExtentY        =   661
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0"
         Text            =   "0"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin VB.Label Label3 
         Caption         =   "Ultimo"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H0080000F&
         Height          =   255
         Left            =   360
         TabIndex        =   7
         Top             =   1080
         Width           =   1335
      End
      Begin VB.Label Label2 
         Caption         =   "Cuerpo"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H0080000F&
         Height          =   255
         Left            =   360
         TabIndex        =   6
         Top             =   720
         Width           =   1575
      End
      Begin VB.Label Label1 
         Caption         =   "Encabezado"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H0080000F&
         Height          =   255
         Left            =   360
         TabIndex        =   5
         Top             =   360
         Width           =   1575
      End
   End
End
Attribute VB_Name = "FRM_MNT_FORMATO_INTERFACES"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Const nColRes = 0
Private Const nColEmail = 1
Private Const nColDefault = 0
Private Const nColEmal = 1

Const ncol_Descripcion = 0
Const ncol_Descripcion2 = 1
Const nCol_Codigo = 0

Public IdInterfaz As Integer
Private Enum Acevercion
   [YES] = 1
   [NO] = 0
End Enum


Private Function HabilitaCajas(ByVal oValor As Boolean, ByVal Todos As Acevercion)
         Let cmbModulo.Enabled = Not oValor
       Let txtInterfaz.Enabled = Not oValor
   
    Let txtNombreLargo.Enabled = oValor
   Let cmbPeriodicidad.Enabled = oValor
   
   Let frm2.Enabled = oValor
   Let frm3.Enabled = oValor
   
   If Todos = YES Then
      Let frm4.Enabled = oValor
   End If
End Function

Private Sub FuncSettingGrid()
   Let grdResponsables.Rows = 2:        Let grdResponsables.FixedRows = 1
   Let grdResponsables.Cols = 4:        Let grdResponsables.FixedCols = 0

   Let grdResponsables.TextMatrix(0, 0) = "Usuario":        Let grdResponsables.ColWidth(0) = 0:         Let grdResponsables.ColAlignment(0) = flexAlignLeftCenter
   Let grdResponsables.TextMatrix(0, 1) = "Nombre":         Let grdResponsables.ColWidth(1) = 3100:      Let grdResponsables.ColAlignment(1) = flexAlignLeftCenter
   Let grdResponsables.TextMatrix(0, 2) = "Cargo":          Let grdResponsables.ColWidth(2) = 3100:      Let grdResponsables.ColAlignment(2) = flexAlignLeftCenter
   Let grdResponsables.TextMatrix(0, 3) = "Email":          Let grdResponsables.ColWidth(3) = 3100:      Let grdResponsables.ColAlignment(3) = flexAlignLeftCenter
End Sub

Private Function FuncCargaModulos()
   Dim Datos()

   Let Screen.MousePointer = vbHourglass

   If Not Bac_Sql_Execute("SP_BACMNTMP_SISTEMA") Then
      Let Screen.MousePointer = vbDefault
      Call MsgBox("Ha ocurrido un error al intentar obtener los datos de los sistemas", vbOKOnly + vbCritical, App.Title)
      Exit Function
   End If

   Call cmbModulo.Clear
   
   Do While Bac_SQL_Fetch(Datos())
      If Datos(1) <> "DRV" And Datos(1) <> "BCC" Then
         Call cmbModulo.AddItem(Datos(2) & Space(50) & Datos(1))
      End If
   Loop
   
   Call cmbModulo.AddItem("PASIVOS" & Space(50) & "PAS")
End Function

Private Sub cmbModulo_Click()
   Call Limpiar
End Sub

Private Sub Form_Load()
   Let Me.Top = 0:    Let Me.Left = 0
   Let Me.Icon = BACSwapParametros.Icon

   Let IdInterfaz = 0

   Call FuncSettingGrid
   Call FuncCargaModulos

   Call Limpiar
   Call PROC_CARGA_TIPO_USUARIO(cmbUsuario, "")
   Call PROC_CARGA_PERIODICIDAD(cmbPeriodicidad)
   
   Call HabilitaCajas(False, si)
   
End Sub

Private Function FuncCargaDatosResponsable(ByRef oGrid As MSFlexGrid, ByVal cUsuario As String, nFila As Long) As Boolean
   Dim SQLDatos()
    
   Let FuncCargaDatosResponsable = False
    
   Envia = Array()
   AddParam Envia, cUsuario
   If Not Bac_Sql_Execute("BacParamSuda.dbo.SP_LEER_RESPONSABLES", Envia) Then
      Call MsgBox("Ha ocurrido un error al intentar obtener los datos de los Responsables.", vbOKOnly + vbExclamation, App.Title)
      Exit Function
   End If
   If Bac_SQL_Fetch(SQLDatos()) Then
      If Len(SQLDatos(4)) = 0 Then
         Call MsgBox("Usuario no tiene correo electrónico, Favor primero debe crear o solicitar que este creado.", vbExclamation, App.Title)
         Exit Function
      End If

      Let oGrid.TextMatrix(nFila, 0) = SQLDatos(1)
      Let oGrid.TextMatrix(nFila, 1) = SQLDatos(2)
      Let oGrid.TextMatrix(nFila, 2) = SQLDatos(3)
      Let oGrid.TextMatrix(nFila, 3) = SQLDatos(4)

      Let FuncCargaDatosResponsable = True
   End If
End Function


Private Sub PROC_CARGA_TIPO_USUARIO(ByRef Combo As Object, ByVal nValor As String)
   Dim SQLDatos()
    
   Envia = Array()
   AddParam Envia, nValor
   If Not Bac_Sql_Execute("BacParamSuda.dbo.SP_LEER_RESPONSABLES") Then
      Call MsgBox("Ha ocurrido un error al intentar obtener los datos de los Responsables.", vbOKOnly + vbExclamation, App.Title)
      Exit Sub
   End If

   Call Combo.Clear

   Do While Bac_SQL_Fetch(SQLDatos())
      Call Combo.AddItem(SQLDatos(2) & Space(80 - Len(SQLDatos(2))) & " - " & SQLDatos(1))
   Loop

 End Sub


Sub PROC_CARGA_PERIODICIDAD(Combo As Object)
   Dim Datos()
    
   Envia = Array(6, "9500", "", "", "", "")
   If Not Bac_Sql_Execute("SP_CON_INFO_COMBO", Envia) Then
      Exit Sub
   End If
    
   Combo.Clear
    
   Do While Bac_SQL_Fetch(Datos)
   
      Call Combo.AddItem(Datos(6) & Space(50) & Datos(2))

   Loop
End Sub



Private Sub Limpiar()

   Screen.MousePointer = vbDefault
   
   grdResponsables.Rows = 1:  grdResponsables.Rows = 2
   
  'cmbModulo.ListIndex = -1
   grdResponsables.Rows = 2
   
   IdInterfaz = 0
   txtInterfaz.Text = "":     txtInterfaz.Tag = 0
   
   txtLenEncabezado.Text = ""
   txtLenCuerpo.Text = ""
   txtLenUltimo.Text = ""
   txtInterfaz = ""
   txtNombreLargo = ""
   cmbPeriodicidad.ListIndex = -1
   cmbUsuario.ListIndex = -1
   cmbUsuario.Visible = False
   chkLargo.Value = 0
   chkConsistencia.Value = 0
   chkCampo.Value = 0
     
   Call HabilitaCajas(False, si)
     
End Sub


Private Sub Activa_responsables()
   Dim nContador As Integer
    
   grdResponsables.Col = 0
   If grdResponsables.Col = ncol_Descripcion Then
      If cmbUsuario.ListCount > 0 Then
         cmbUsuario.Visible = True
         cmbUsuario.Width = grdResponsables.ColWidth(grdResponsables.Col)
         cmbUsuario.Left = grdResponsables.Left + grdResponsables.CellLeft
         cmbUsuario.Top = grdResponsables.Top + grdResponsables.CellTop
         cmbUsuario.SetFocus
      End If
   End If
End Sub


Private Sub Verifica_Responsables()
   Dim nContador  As Long
   Dim xUsuario   As String
   Dim nFila      As Long
   
   Let xUsuario = grdResponsables.TextMatrix(grdResponsables.RowSel, 0)
   Let nFila = grdResponsables.RowSel
   
   For nContador = 1 To grdResponsables.Rows - 1
      If grdResponsables.TextMatrix(nContador, 0) = xUsuario And nContador <> nFila Then
         Call MsgBox("El musuario ya se encuentra ingresado.", vbExclamation, App.Title)
         Exit For
      End If
   Next nContador
    

End Sub


Private Sub grdResponsables_KeyDown(KeyCode As Integer, Shift As Integer)
    
   If KeyCode = vbKeyReturn Then
      On Error Resume Next
      Call PROC_POSICIONA_TEXTO(grdResponsables, cmbUsuario)
      On Error GoTo 0
      
      Let cmbUsuario.Visible = True
      Let grdResponsables.Enabled = False
      Call bacBuscarCombo(cmbUsuario, grdResponsables.TextMatrix(grdResponsables.RowSel, 1))
      Call cmbUsuario.SetFocus
      
      Exit Sub
   End If
    
    Select Case KeyCode
        Case vbKeyInsert
        
            If grdResponsables.TextMatrix(grdResponsables.Rows - 2, nCol_Codigo) <> "" And grdResponsables.TextMatrix(grdResponsables.Rows - 2, ncol_Descripcion) <> "" Then
               If Len(grdResponsables.TextMatrix(grdResponsables.Rows - 1, 0)) = 0 Then
                  Exit Sub
               End If
               Let grdResponsables.Rows = grdResponsables.Rows + 1:     Let grdResponsables.Col = 1:  Let grdResponsables.Row = grdResponsables.Rows - 1
               Call grdResponsables.SetFocus
            End If
           
        Case vbKeyDelete
            If grdResponsables.Rows > 2 Then
                grdResponsables.RemoveItem grdResponsables.Row
            Else
                grdResponsables.TextMatrix(1, 0) = ""
                grdResponsables.TextMatrix(1, 1) = ""
                grdResponsables.TextMatrix(1, 2) = ""
                grdResponsables.TextMatrix(1, 3) = ""
            End If

    End Select

End Sub

Private Sub grdResponsables_KeyPress(KeyAscii As Integer)

   If Not IsNumeric(Chr(KeyAscii)) And UCase(Chr(KeyAscii)) < "A" And UCase(Chr(KeyAscii)) > "Z" And KeyAscii <> 13 And KeyAscii <> 8 Then
      KeyAscii = 0
   End If
   If KeyAscii = 13 Then
   
   End If
End Sub



Private Sub cmbUsuario_KeyDown(KeyCode As Integer, Shift As Integer)
    Dim nContador As Integer

   Select Case KeyCode
        Case vbKeyReturn

            If cmbUsuario.ListIndex < 0 Then
               Exit Sub
            End If

            '-> Funcion que carga los datos del usuario a la grilla
            Call FuncCargaDatosResponsable(grdResponsables, Trim(Mid(cmbUsuario.List(cmbUsuario.ListIndex), InStr(1, cmbUsuario.List(cmbUsuario.ListIndex), "-") + 1)), grdResponsables.RowSel)
            '-> Funcion que carga los datos del usuario a la grilla
            Let cmbUsuario.Visible = False
            Let grdResponsables.Enabled = True
            Call grdResponsables.SetFocus:      grdResponsables.Row = grdResponsables.RowSel:    grdResponsables.Col = 1

         Case vbKeyEscape
            Let cmbUsuario.Visible = False
            Let grdResponsables.Enabled = True
            Call grdResponsables.SetFocus
   End Select

End Sub

Private Sub cmbUsuario_LostFocus()
   'Call Verifica_Responsables
End Sub


Private Sub Tbl_Opciones_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 1      '"Nuevo"
         Call Limpiar
      Case 2      '"Grabar"
         If cmdGrabar() Then
            MsgBox "Se grabraron los datos OK.", vbInformation, TITSISTEMA
         End If
         Call Limpiar
      Case 3      '"Eliminar"
         Call Proc_Eliminar
      Case 4      '"Salir"
         Unload Me
   End Select

End Sub

Function cmdGrabar() As Boolean
    Dim bRespuesta As Boolean
    Dim iCodProducto     As Variant
    Dim idSistema        As Variant
        
    Screen.MousePointer = vbHourglass
    If cmbPeriodicidad.ListIndex < 0 Then
        cmbPeriodicidad.ListIndex = 0
    End If
    
    If BacBeginTransaction = False Then
        Let Screen.MousePointer = vbDefault
        Call MsgBox("Ha ocurrido un error al intentar grabar la informacion", vbCritical, App.Title)
        Exit Function
    End If
           
    Envia = Array()
    AddParam Envia, IdInterfaz
    AddParam Envia, Trim(Left(txtInterfaz.Text, 20))        ' nombre corto interfaz
    AddParam Envia, Trim(Left(txtNombreLargo.Text, 20))     ' nombre largo interfaz
    AddParam Envia, Trim(Right(txtLenEncabezado.Text, 4))   ' largo encabezado
    AddParam Envia, Trim(Right(txtLenCuerpo.Text, 4))       ' largo cuerpo
    AddParam Envia, Trim(Right(txtLenUltimo.Text, 4))       ' largo ultimo campo
    AddParam Envia, Trim(Right(cmbModulo, 3))               ' sistema
    AddParam Envia, CInt(Trim(Right(cmbPeriodicidad, 1)))   ' periodicidad
    AddParam Envia, 0                                       ' Tipo update
    AddParam Envia, chkLargo.Value                          ' valida largo
    AddParam Envia, chkConsistencia.Value                   ' valida consistencia
    AddParam Envia, chkCampo.Value                          ' valida campo a campo

    Envia2 = Array()
    AddParam Envia2, IdInterfaz
    AddParam Envia2, ""
    AddParam Envia2, ""                                     ' responsable
    AddParam Envia2, Trim(Right(cmbModulo, 3))              ' Sistema
    AddParam Envia2, 1                                      ' Tipo operacion DELETE
    If Not Bac_Sql_Execute("SP_GRABA_RESPONSABLE_INTERFAZ ", Envia2) Then
        Let Screen.MousePointer = vbDefault
        Call BacRollBackTransaction
        Call MsgBox("Ha ocurrido un error al intentar grabar la informacion", vbCritical, App.Title)
        Exit Function
    End If

    Erase Envia2

    With grdResponsables
        For nLin = 1 To .Rows - 1
            Envia2 = Array()
            AddParam Envia2, IdInterfaz
            AddParam Envia2, Trim(Left(txtInterfaz.Text, 20))
            AddParam Envia2, Trim(Right(grdResponsables.TextMatrix(nLin, 0), 15))   ' responsable
            AddParam Envia2, Trim(Right(cmbModulo, 3))                              ' Sistema
            AddParam Envia2, 2                                                      ' Tipo operacion INSERT
            If Not Bac_Sql_Execute("SP_GRABA_RESPONSABLE_INTERFAZ ", Envia2) Then
                Let Screen.MousePointer = vbDefault
               Call BacRollBackTransaction
               Call MsgBox("Ha ocurrido un error al intentar grabar la informacion", vbCritical, App.Title)
               Exit Function
            End If
            Erase Envia2
        Next nLin
    End With

    If Not Bac_Sql_Execute("SP_GRABA_FORMATO_INTERFACES ", Envia) Then
         Let Screen.MousePointer = vbDefault
        Call BacRollBackTransaction
        Call MsgBox("Ha ocurrido un error al intentar grabar la informacion", vbCritical, App.Title)
        Exit Function
    Else
        Call BacCommitTransaction
         Let Screen.MousePointer = vbDefault
    End If

    cmdGrabar = True

    Exit Function

End Function

Private Sub txtInterfaz_DblClick()
    If cmbModulo.ListIndex = -1 Then
        Exit Sub
    End If
    
    Call BacControlWindows(1)

    Let FRM_AYUDA_INTERFAZ.Tag = "INTERFACES"

    Let gsCodigo = Trim(Right(Me.cmbModulo.Text, 3))

    FRM_AYUDA_INTERFAZ.Show 1
    
    If giAceptar = True Then
        IdInterfaz = gsCodigo
        txtInterfaz.Text = gsDescripcion$
        txtInterfaz.Tag = gsNombre
        Call txtInterfaz_KeyPress(vbKeyReturn)

        Call HabilitaCajas(True, si)
    End If
End Sub

Private Sub txtInterfaz_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyReturn Then
      Call Busca_Interfaz
      Call Proc_Busca_Interfaz
        
      If txtInterfaz.Enabled = True Then
         Call txtInterfaz.SetFocus
      End If
   End If
     
    If KeyAscii >= Asc("a") And KeyAscii <= Asc("z") Then
        KeyAscii = KeyAscii - 32
    End If
    
End Sub

Private Sub Busca_Interfaz()
   If cmbModulo.ListIndex = -1 Then
      MsgBox "Debe seleccionar un SISTEMA", vbExclamation + vbOKOnly
      Exit Sub
   End If
   
   If txtInterfaz.Tag = "0" And cmbModulo.ListIndex >= 0 And Len(txtInterfaz.Text) > 0 Then
     'Let txtInterfaz.Tag = FuncExtraeIdInterfaz(Right(cmbModulo.List(cmbModulo.ListIndex), 3), txtInterfaz.Text)
      Let txtInterfaz.Tag = txtInterfaz.Text
   End If
   
   Screen.MousePointer = vbHourglass
        
   If gsCodigo = "" Then
       gsCodigo = 0
   End If

   Envia = Array()
   AddParam Envia, Right(cmbModulo.Text, 3)
   AddParam Envia, 0
   AddParam Envia, 2
   AddParam Envia, Trim(txtInterfaz.Tag)
   If Not Bac_Sql_Execute("BacParamSuda.dbo.SP_TRAE_DATOS_INTERFACE", Envia) Then
      Screen.MousePointer = vbDefault
      MsgBox "Ha ocurrido un error al intenter consultar las interfaces", vbOKOnly + vbCritical
      Exit Sub
   Else
      If Bac_SQL_Fetch(Datos()) Then
         Let IdInterfaz = Trim(Datos(1))

         '-> Determina Registro Nuevo -- Nueva Entrada
         If Datos(2) = -1 Then
            Call HabilitaCajas(True, YES)
         Else
            Call HabilitaCajas(True, YES)
         End If

      End If
   End If
   
   Screen.MousePointer = vbDefault
    
End Sub

Sub Proc_Busca_Interfaz()

   If cmbModulo.ListIndex = -1 Then
      MsgBox "Debe seleccionar un SISTEMA", vbExclamation + vbOKOnly
      Exit Sub
   End If
   
   Screen.MousePointer = vbHourglass

   Envia = Array()
   AddParam Envia, Right(cmbModulo.Text, 3)
   AddParam Envia, IdInterfaz 'gsCodigo 'Right(gsCodigo, 20)
   If Not Bac_Sql_Execute("BACPARAMSUDA..SP_TRAE_ENCABEZADO_INTERFACES", Envia) Then
      Screen.MousePointer = vbDefault
      MsgBox "Ha ocurrido un error al intenter consultar las interfaces", vbOKOnly + vbCritical
      Exit Sub
   Else
        If Bac_SQL_Fetch(Datos()) Then
            IdInterfaz = Trim(Datos(1))
            txtInterfaz.Text = Trim(Datos(2))
            txtNombreLargo.Text = Trim(Datos(3))
            txtLenEncabezado.Text = Trim(Datos(4))
            txtLenCuerpo.Text = Trim(Datos(5))
            txtLenUltimo.Text = Trim(Datos(6))
            
            cmbPeriodicidad.ListIndex = -1
            If Datos(7) <> "" And Datos(7) <> 0 Then
               cmbPeriodicidad.ListIndex = Datos(7) - 1
            End If
            
            chkLargo.Value = IIf(Len(Datos(8)) = 0, 0, Datos(8))
            chkConsistencia.Value = Datos(9)
            chkCampo.Value = Datos(10)
        End If
    End If
    
   Envia2 = Array()
   AddParam Envia2, IdInterfaz 'Right(txtInterfaz.Text, 20)
   AddParam Envia2, Right(cmbModulo.Text, 3)
   If Not Bac_Sql_Execute("BACPARAMSUDA..SP_TRAE_DETALLE_INTERFACES", Envia2) Then
      Screen.MousePointer = vbDefault
      MsgBox "Ha ocurrido un error al intenter consultar las interfaces", vbOKOnly + vbCritical
      Exit Sub
   End If
   grdResponsables.Rows = 1
   
   Do While Bac_SQL_Fetch(Datos())
      grdResponsables.Rows = grdResponsables.Rows + 1
      grdResponsables.TextMatrix(grdResponsables.Rows - 1, 0) = Trim(Datos(1))
      grdResponsables.TextMatrix(grdResponsables.Rows - 1, 1) = Trim(Datos(2))
      grdResponsables.TextMatrix(grdResponsables.Rows - 1, 2) = Trim(Datos(3))
      grdResponsables.TextMatrix(grdResponsables.Rows - 1, 3) = Trim(Datos(4))
   Loop

   If grdResponsables.Rows = 1 Then
      grdResponsables.Rows = 2
   End If

   Screen.MousePointer = vbDefault

End Sub


Private Sub Proc_Eliminar()

    Dim a As Integer
    Dim iok          As Integer
    Dim iCodProducto As Variant
    Dim idSistema    As Variant
    Dim nCodigo      As Long
    Dim sql          As String
    
'    If Trim(grdResponsables.TextMatrix(grdResponsables.Row, nCol_Codigo)) <> "" Then
       
        If MsgBox("¿Esta seguro de eliminar la interfaz seleccionada?", vbQuestion + vbYesNo, TITSISTEMA) = vbYes Then
            Screen.MousePointer = vbHourglass
              
            Envia = Array()
            AddParam Envia, Trim(Right(cmbModulo.Text, 3))
            AddParam Envia, Trim(Right(txtInterfaz.Text, 20))
                    
            If Not Bac_Sql_Execute("SP_ELIMINA_FORMATO_INTERFACES", Envia) Then
                Screen.MousePointer = vbDefault
                MsgBox "Ha ocurrido un error al intentar eliminar la interfaz selecionada", vbCritical, TITSISTEMA
                Exit Sub
            End If
            
            If grdResponsables.Rows > 2 Then
                grdResponsables.RemoveItem grdResponsables.Row
            Else
                grdResponsables.TextMatrix(grdResponsables.Row, nCol_Codigo) = ""
                grdResponsables.TextMatrix(grdResponsables.Row, ncol_Descripcion) = ""
            End If
        End If
'    End If

    Screen.MousePointer = vbDefault

    Call Limpiar
End Sub


Private Sub txtInterfaz_LostFocus()
'    Call HabilitaCajas(True, si)
    Let txtNombreLargo.Enabled = True
End Sub

Private Sub txtNombreLargo_KeyPress(KeyAscii As Integer)
 If KeyAscii >= Asc("a") And KeyAscii <= Asc("z") Then
        KeyAscii = KeyAscii - 32
    End If
End Sub

Private Function FuncExtraeIdInterfaz(ByVal Modulo As String, ByVal Interfaz As String) As Long
   Dim cSql    As String
   Dim cSqlDatos()
   
   Let cSql = "SELECT id_interfaz FROM BacParamSuda.dbo.FORMATO_INTERFACES WHERE Sistema = '" & Modulo & "' AND Nombre_interfaz = '" & Interfaz & "' "

   Let FuncExtraeIdInterfaz = 0

   If Bac_Sql_Execute(cSql) Then
      If Bac_SQL_Fetch(cSqlDatos()) Then
         Let FuncExtraeIdInterfaz = cSqlDatos(1)
      End If
   End If

End Function
