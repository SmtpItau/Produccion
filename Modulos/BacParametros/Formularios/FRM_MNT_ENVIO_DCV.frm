VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form FRM_MNT_ENVIO_DCV 
   Caption         =   "Envio de Contratos Forward a DCV"
   ClientHeight    =   6780
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   15870
   LinkTopic       =   "Form2"
   MDIChild        =   -1  'True
   ScaleHeight     =   6780
   ScaleWidth      =   15870
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   15870
      _ExtentX        =   27993
      _ExtentY        =   794
      ButtonWidth     =   2090
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      Style           =   1
      TextAlignment   =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   7
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Buscar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Enviar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Cerrar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Cod. DCV"
            ImageIndex      =   4
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   7980
         Top             =   0
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   4
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_ENVIO_DCV.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_ENVIO_DCV.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_ENVIO_DCV.frx":11F4
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_ENVIO_DCV.frx":20CE
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame MarcoFiltro 
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   780
      Left            =   0
      TabIndex        =   1
      Top             =   375
      Width           =   15855
      Begin VB.ComboBox CmbEstado 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   13215
         Style           =   2  'Dropdown List
         TabIndex        =   13
         Top             =   390
         Width           =   2565
      End
      Begin VB.ComboBox CmbFPago 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   9960
         Style           =   2  'Dropdown List
         TabIndex        =   11
         Top             =   390
         Width           =   3255
      End
      Begin VB.ComboBox CmbMoneda 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   6705
         Style           =   2  'Dropdown List
         TabIndex        =   9
         Top             =   390
         Width           =   3255
      End
      Begin VB.ComboBox CmbProducto 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   3840
         Style           =   2  'Dropdown List
         TabIndex        =   7
         Top             =   390
         Width           =   2865
      End
      Begin VB.ComboBox CmbModulo 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   1515
         Style           =   2  'Dropdown List
         TabIndex        =   4
         Top             =   390
         Width           =   2325
      End
      Begin BACControles.TXTFecha TxtFecha 
         Height          =   315
         Left            =   45
         TabIndex        =   3
         Top             =   390
         Width           =   1470
         _ExtentX        =   2593
         _ExtentY        =   556
         Enabled         =   -1  'True
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "04/10/2010"
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Estado"
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
         Index           =   5
         Left            =   13230
         TabIndex        =   12
         Top             =   180
         Width           =   570
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Forma Pago"
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
         Index           =   4
         Left            =   9990
         TabIndex        =   10
         Top             =   180
         Width           =   1005
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Moneda"
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
         Index           =   3
         Left            =   6735
         TabIndex        =   8
         Top             =   180
         Width           =   675
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Producto"
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
         Left            =   3855
         TabIndex        =   6
         Top             =   180
         Width           =   765
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Modulo"
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
         Left            =   1515
         TabIndex        =   5
         Top             =   180
         Width           =   615
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Fecha"
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
         Left            =   75
         TabIndex        =   2
         Top             =   180
         Width           =   495
      End
   End
   Begin VB.Frame MarcoGrilla 
      Height          =   5460
      Left            =   -15
      TabIndex        =   14
      Top             =   1065
      Width           =   15870
      Begin VB.PictureBox ConCheck 
         BorderStyle     =   0  'None
         Height          =   255
         Index           =   1
         Left            =   2100
         Picture         =   "FRM_MNT_ENVIO_DCV.frx":2FA8
         ScaleHeight     =   255
         ScaleWidth      =   270
         TabIndex        =   17
         Top             =   195
         Visible         =   0   'False
         Width           =   270
      End
      Begin VB.PictureBox SinCheck 
         BorderStyle     =   0  'None
         Height          =   255
         Index           =   1
         Left            =   2385
         Picture         =   "FRM_MNT_ENVIO_DCV.frx":332E
         ScaleHeight     =   255
         ScaleWidth      =   270
         TabIndex        =   16
         Top             =   195
         Visible         =   0   'False
         Width           =   270
      End
      Begin MSFlexGridLib.MSFlexGrid Grid 
         Height          =   5280
         Left            =   30
         TabIndex        =   15
         Top             =   120
         Width           =   15720
         _ExtentX        =   27728
         _ExtentY        =   9313
         _Version        =   393216
         BackColor       =   -2147483633
         ForeColor       =   -2147483641
         BackColorFixed  =   -2147483646
         ForeColorFixed  =   -2147483639
         BackColorBkg    =   -2147483636
         GridColor       =   -2147483633
         GridColorFixed  =   -2147483642
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
   Begin Threed.SSPanel PnlProgress 
      Align           =   2  'Align Bottom
      Height          =   255
      Left            =   0
      TabIndex        =   18
      Top             =   6525
      Width           =   15870
      _Version        =   65536
      _ExtentX        =   27993
      _ExtentY        =   450
      _StockProps     =   15
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BorderWidth     =   1
      BevelInner      =   1
      FloodType       =   1
      FloodColor      =   -2147483635
   End
End
Attribute VB_Name = "FRM_MNT_ENVIO_DCV"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim oLoadForm     As Boolean
Dim nRowsSel      As Long
Dim oFltrar       As Boolean

Private Const MiButton_Buscar = 2
Private Const MiButton_Enviar = 3
Private Const MiButton_Cerrar = 5
Private Const MiButton_Client = 7

Private Const MiTag_Modulos = 0
Private Const MiTag_Productos = 1
Private Const MiTag_Moneda = 2
Private Const MiTag_FPago = 3
Private Const MiTag_Estado = 4

Private Const MiGrid_Marca = 0
Private Const MiGrid_Fecha = 1
Private Const MiGrid_Modul = 2
Private Const MiGrid_Prodc = 3
Private Const MiGrid_Contr = 4
Private Const MiGrid_Estad = 5
Private Const MiGrid_Clien = 6
Private Const MiGrid_Moned = 7
Private Const MiGrid_FPago = 8
Private Const MiGrid_Monto = 9
Private Const MiGrid_Preci = 10
Private Const MiGrid_FVCto = 11
Private Const MiGrid_IdGrp = 12
Private Const MiGrid_EsGrp = 13
Private Const MiGrid_Reser = 14
Private Const MiGrid_VMark = 15
Private Const MiGrid_SisMo = 16

Private Const MiTag_nFolio = 0
Private Const MiTag_nMarca = 1

Private Const bBackColor = &H8000000F
Private Const bBackColorBk = &H8000000C
Private Const bBackColorFix = &H80000002
Private Const bBackcolorCel = &H8000000D

Private Const fForeColor = &H80000007
Private Const fForeColorFix = &H80000009
Private Const fForeColorSel = &H8000000E

Private Function FuncSettingGrid()
   Let Grid.Rows = 2:         Let Grid.Cols = 17
   Let Grid.FixedRows = 1:    Let Grid.FixedCols = 0
   Let Grid.RowHeightMin = 300

        Let Grid.BackColor = bBackColor:          Let Grid.ForeColor = fForeColor
   Let Grid.BackColorFixed = bBackColorFix:  Let Grid.ForeColorFixed = fForeColorFix
     Let Grid.BackColorSel = bBackcolorCel:    Let Grid.ForeColorSel = fForeColorSel

   Let Grid.TextMatrix(0, MiGrid_Marca) = "M":              Let Grid.ColWidth(MiGrid_Marca) = 550:    Let Grid.ColAlignment(MiGrid_Marca) = flexAlignCenterCenter
   Let Grid.TextMatrix(0, MiGrid_Fecha) = "Fecha":          Let Grid.ColWidth(MiGrid_Fecha) = 1200:   Let Grid.ColAlignment(MiGrid_Fecha) = flexAlignRightCenter
   Let Grid.TextMatrix(0, MiGrid_Modul) = "Modulo":         Let Grid.ColWidth(MiGrid_Modul) = 1200:   Let Grid.ColAlignment(MiGrid_Modul) = flexAlignLeftCenter
   Let Grid.TextMatrix(0, MiGrid_Prodc) = "Producto":       Let Grid.ColWidth(MiGrid_Prodc) = 2900:   Let Grid.ColAlignment(MiGrid_Prodc) = flexAlignLeftCenter
   Let Grid.TextMatrix(0, MiGrid_Contr) = "N° Contrato":    Let Grid.ColWidth(MiGrid_Contr) = 1200:   Let Grid.ColAlignment(MiGrid_Contr) = flexAlignRightCenter
   Let Grid.TextMatrix(0, MiGrid_Estad) = "Estado":         Let Grid.ColWidth(MiGrid_Estad) = 1200:   Let Grid.ColAlignment(MiGrid_Estad) = flexAlignLeftCenter
   Let Grid.TextMatrix(0, MiGrid_Clien) = "Cliente":        Let Grid.ColWidth(MiGrid_Clien) = 3700:   Let Grid.ColAlignment(MiGrid_Clien) = flexAlignLeftCenter
   Let Grid.TextMatrix(0, MiGrid_Moned) = "Monedas":        Let Grid.ColWidth(MiGrid_Moned) = 1000:   Let Grid.ColAlignment(MiGrid_Moned) = flexAlignLeftCenter
   Let Grid.TextMatrix(0, MiGrid_FPago) = "F. Pago":        Let Grid.ColWidth(MiGrid_FPago) = 1800:   Let Grid.ColAlignment(MiGrid_FPago) = flexAlignLeftCenter
   Let Grid.TextMatrix(0, MiGrid_Monto) = "Monto":          Let Grid.ColWidth(MiGrid_Monto) = 1500:   Let Grid.ColAlignment(MiGrid_Monto) = flexAlignRightCenter
   Let Grid.TextMatrix(0, MiGrid_Preci) = "Precio":         Let Grid.ColWidth(MiGrid_Preci) = 1200:   Let Grid.ColAlignment(MiGrid_Preci) = flexAlignRightCenter
   Let Grid.TextMatrix(0, MiGrid_FVCto) = "F. Vcto":        Let Grid.ColWidth(MiGrid_FVCto) = 1200:   Let Grid.ColAlignment(MiGrid_FVCto) = flexAlignRightCenter
   Let Grid.TextMatrix(0, MiGrid_IdGrp) = "Id Grupo":       Let Grid.ColWidth(MiGrid_IdGrp) = 0:      Let Grid.ColAlignment(MiGrid_IdGrp) = flexAlignRightCenter
   Let Grid.TextMatrix(0, MiGrid_EsGrp) = "E. Grupo":       Let Grid.ColWidth(MiGrid_EsGrp) = 0:      Let Grid.ColAlignment(MiGrid_EsGrp) = flexAlignRightCenter
   Let Grid.TextMatrix(0, MiGrid_Reser) = "Reservado":      Let Grid.ColWidth(MiGrid_Reser) = 0:      Let Grid.ColAlignment(MiGrid_Reser) = flexAlignRightCenter
   Let Grid.TextMatrix(0, MiGrid_VMark) = "Marca":          Let Grid.ColWidth(MiGrid_VMark) = 0:      Let Grid.ColAlignment(MiGrid_VMark) = flexAlignRightCenter
   Let Grid.TextMatrix(0, MiGrid_SisMo) = "Modulo":         Let Grid.ColWidth(MiGrid_SisMo) = 0:      Let Grid.ColAlignment(MiGrid_SisMo) = flexAlignRightCenter

   Let Etiquetas(0).Caption = "Fecha":                      Let Etiquetas(0).Font.Name = "Tahoma":    Let Etiquetas(0).Font.Size = 8:  Let Etiquetas(0).Font.Bold = True
   Let Etiquetas(1).Caption = "Modulos":                    Let Etiquetas(1).Font.Name = "Tahoma":    Let Etiquetas(1).Font.Size = 8:  Let Etiquetas(1).Font.Bold = True
   Let Etiquetas(2).Caption = "Productos":                  Let Etiquetas(2).Font.Name = "Tahoma":    Let Etiquetas(2).Font.Size = 8:  Let Etiquetas(2).Font.Bold = True
   Let Etiquetas(3).Caption = "Moneda Conversión":          Let Etiquetas(3).Font.Name = "Tahoma":    Let Etiquetas(3).Font.Size = 8:  Let Etiquetas(3).Font.Bold = True
   Let Etiquetas(4).Caption = "Formas de Pago":             Let Etiquetas(4).Font.Name = "Tahoma":    Let Etiquetas(4).Font.Size = 8:  Let Etiquetas(4).Font.Bold = True
   Let Etiquetas(5).Caption = "Estados":                    Let Etiquetas(5).Font.Name = "Tahoma":    Let Etiquetas(5).Font.Size = 8:  Let Etiquetas(5).Font.Bold = True

   Let Grid.Rows = Grid.FixedRows
End Function

Private Function FuncLoadModulos()
   Dim Sqldatos()
   Dim oDefecto   As Long

   Envia = Array()
   Call AddParam(Envia, CDbl(MiTag_Modulos))
   If Not Bac_Sql_Execute("dbo.SVC_CARGA_FILTRO", Envia) Then
      Exit Function
   End If
   Call CmbModulo.Clear
   Do While Bac_SQL_Fetch(Sqldatos())
      Call CmbModulo.AddItem(Sqldatos(1) & Space(100) & Sqldatos(2))
   Loop
   If CmbModulo.ListCount = 1 Then
      Let CmbModulo.ListIndex = 0
      Let CmbModulo.Enabled = False
   End If
End Function

Private Function FuncloadProductos(ByVal MiModulo As String)
   Dim Sqldatos()

   Envia = Array()
   Call AddParam(Envia, MiTag_Productos)
   Call AddParam(Envia, MiModulo)
   If Not Bac_Sql_Execute("dbo.SVC_CARGA_FILTRO", Envia) Then
      Exit Function
   End If
   Call CmbProducto.Clear
   Call CmbProducto.AddItem(" << TODOS >> " & Space(100) & " ")
   Do While Bac_SQL_Fetch(Sqldatos())
      Call CmbProducto.AddItem(Sqldatos(1) & Space(100) & Sqldatos(2))
   Loop
   Let CmbProducto.ListIndex = 0
End Function

Private Function FuncLoadMonedas(ByVal MiModulo As String, ByVal MiProducto As String)
   Dim Sqldatos()

   Envia = Array()
   Call AddParam(Envia, MiTag_Moneda)
   Call AddParam(Envia, MiModulo)
   Call AddParam(Envia, MiProducto)
   If Not Bac_Sql_Execute("dbo.SVC_CARGA_FILTRO", Envia) Then
      Exit Function
   End If
   Call CmbMoneda.Clear
   Call CmbMoneda.AddItem(" << TODOS >> " & Space(100) & "0")
   Do While Bac_SQL_Fetch(Sqldatos())
      Call CmbMoneda.AddItem(Sqldatos(1) & Space(100) & Sqldatos(2))
   Loop
   Let CmbMoneda.ListIndex = 0
End Function

Private Function FuncloadFPago(ByVal nMoneda As Long)
   Dim Sqldatos()

   Envia = Array()
   Call AddParam(Envia, MiTag_FPago)
   Call AddParam(Envia, "")
   Call AddParam(Envia, "")
   Call AddParam(Envia, nMoneda)
   If Not Bac_Sql_Execute("dbo.SVC_CARGA_FILTRO", Envia) Then
      Exit Function
   End If
   Call CmbFPago.Clear
   Call CmbFPago.AddItem(" << TODOS >> " & Space(100) & " ")
   Do While Bac_SQL_Fetch(Sqldatos())
      Call CmbFPago.AddItem(Sqldatos(1) & Space(100) & Sqldatos(2))
   Loop
   Let CmbFPago.ListIndex = 0
End Function

Private Function FuncLoadEstados()
   Dim Sqldatos()

   Envia = Array()
   Call AddParam(Envia, MiTag_Estado)
   Call AddParam(Envia, "")
   Call AddParam(Envia, "")
   Call AddParam(Envia, 0)
   If Not Bac_Sql_Execute("dbo.SVC_CARGA_FILTRO", Envia) Then
      Exit Function
   End If
   
   Call CmbEstado.Clear
   Call CmbEstado.AddItem(" << TODOS >> " & Space(100) & " ")
   
   Do While Bac_SQL_Fetch(Sqldatos())

      Call CmbEstado.AddItem(Sqldatos(1) & Space(100) & Sqldatos(2))

   Loop
   
   Let CmbEstado.ListIndex = 0
End Function

Private Sub Grid_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeySpace Then
      Call Grid_Click
   End If
End Sub

Private Sub TxtFecha_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyReturn Then
      Call FuncLoadDatos
   End If
End Sub

Private Sub cmbModulo_Click()
   
   If CmbModulo.ListCount > 0 Then
      If CmbModulo.ListIndex >= 0 Then

         Let oFltrar = True:  Call FuncloadProductos(Trim(Right(CmbModulo.List(CmbModulo.ListIndex), 5)))
         Let oFltrar = False: Call FuncLoadDatos

      End If
   End If

End Sub

Private Sub cmbProducto_Click()
   
   If CmbProducto.ListIndex >= 0 Then
      
      If oFltrar = False Then
         Let oFltrar = True:  Call FuncLoadMonedas(Trim(Right(CmbModulo.List(CmbModulo.ListIndex), 5)), Trim(Right(CmbProducto.List(CmbProducto.ListIndex), 5)))
         Let oFltrar = False: Call FuncLoadDatos
      Else
         Call FuncLoadMonedas(Trim(Right(CmbModulo.List(CmbModulo.ListIndex), 5)), Trim(Right(CmbProducto.List(CmbProducto.ListIndex), 5)))
      End If
   End If

End Sub

Private Sub cmbMoneda_Click()
   
   If CmbMoneda.ListIndex >= 0 Then

      If oFltrar = False Then
         Let oFltrar = True:  Call FuncloadFPago(Val(Trim(Right(CmbMoneda.List(CmbMoneda.ListIndex), 5))))
         Let oFltrar = False: Call FuncLoadDatos
      Else
         Call FuncloadFPago(Val(Trim(Right(CmbMoneda.List(CmbMoneda.ListIndex), 5))))
      End If

   End If

End Sub

Private Sub CmbFPago_Click()
   If oFltrar = False Then
      Let oFltrar = True:  Call FuncLoadDatos:  Let oFltrar = False
   Else
      Call FuncLoadDatos
   End If
End Sub

Private Sub CmbEstado_Click()
   Call FuncLoadDatos
End Sub


Private Sub Form_Load()
   Let Me.Top = 0:   Let Me.Left = 0
   Let Me.Icon = BACSwapParametros.Icon

   Let TxtFecha.Text = gsbac_fecp
   Let Toolbar1.Buttons(MiButton_Enviar).Enabled = False

   Let oLoadForm = False
   Let NewId = 0
   Let nRowsSel = 0

  '-->  Let PnlProgress.Visible = False
   Let oFltrar = True
   Call FuncSettingGrid
   Call FuncLoadModulos
   Call FuncLoadEstados
      
   If CmbEstado.ListCount > 1 Then Let CmbEstado.ListIndex = 1

   Let oFltrar = False

   Let Toolbar1.Buttons(MiButton_Buscar).ToolTipText = "Buscar Operaciones. ..."
   Let Toolbar1.Buttons(MiButton_Enviar).ToolTipText = "Generación de archivo con operaciones selecionadas. ... "
   Let Toolbar1.Buttons(MiButton_Cerrar).ToolTipText = "Cerrar ventana. ...."
End Sub

Private Sub Form_Resize()
   On Error Resume Next
   Let MarcoFiltro.Width = Me.Width - 170

   Let MarcoGrilla.Width = MarcoFiltro.Width
   Let MarcoGrilla.Height = Me.Height - (MarcoFiltro.Height + Toolbar1.Height + 400) - 180

   Let Grid.Width = MarcoGrilla.Width - 150
   Let Grid.Height = MarcoGrilla.Height - 150
   On Error GoTo 0
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case MiButton_Buscar:      Call FuncLoadDatos
      Case MiButton_Enviar:      Call FuncGenerar
      Case MiButton_Cerrar:      Call Unload(Me)
      Case MiButton_Client:      Call FRM_MNT_CODIGO_DCV.Show(vbModal)
   End Select
End Sub

Private Function FuncLoadOperacionesDCV() As Boolean
   Let FuncLoadOperacionesDCV = False
   Let Screen.MousePointer = vbHourglass

   Envia = Array()
   If Not Bac_Sql_Execute("dbo.SVC_CARGA_OPERACIONES_DCV", Envia) Then
      Let Screen.MousePointer = vbDefault
      Exit Function
   End If

   Let Screen.MousePointer = vbDefault
   Let FuncLoadOperacionesDCV = True
End Function

Private Function FuncLoadDatos()
   Dim Sqldatos()
   Dim xFecha     As String
   Dim xModulo    As String
   Dim xProducto  As String
   Dim xMoneda    As Long
   Dim xFPago     As Long
   Dim xEstado    As String
   Dim xFilas     As Long
   Dim nContador  As Long

   Let BACSwapParametros.Timer1.Enabled = False

   If oFltrar = True Then
      Exit Function
   End If

   If FuncLoadOperacionesDCV = False Then
      Call MsgBox("[ CONTROL DE CARGA DE OPERACIONES DEL DÍA ]" & vbCrLf & vbCrLf & "se ha generado un error durante la carga de operaciones.", vbExclamation, App.Title)
      Exit Function
   End If

   Let PnlProgress.Visible = True
   Let Screen.MousePointer = vbHourglass
   Let PnlProgress.FloodColor = &H8000000D

   Let xFecha = Format(TxtFecha.Text, "yyyymmdd")
   Let xModulo = Trim(Right(CmbModulo.List(CmbModulo.ListIndex), 5))
   Let xProducto = Trim(Right(CmbProducto.List(CmbProducto.ListIndex), 5))
   Let xMoneda = Val(Trim(Right(CmbMoneda.List(CmbMoneda.ListIndex), 5)))
   Let xFPago = Val(Trim(Right(CmbFPago.List(CmbFPago.ListIndex), 5)))
   Let xEstado = Trim(Right(CmbEstado.List(CmbEstado.ListIndex), 3))

   Envia = Array()
   Call AddParam(Envia, xFecha)
   Call AddParam(Envia, xModulo)
   Call AddParam(Envia, xProducto)
   Call AddParam(Envia, xMoneda)
   Call AddParam(Envia, xFPago)
   Call AddParam(Envia, xEstado)
   If Not Bac_Sql_Execute("dbo.SVC_LEER_OPERACIONES_DCV", Envia) Then
      Let Grid.Redraw = True
      Let Screen.MousePointer = vbDefault
      Exit Function
   End If

   Let xFilas = -1
   Let nContador = 0
   Let Grid.Rows = 1
   Let Grid.Redraw = False
   Let Grid.Enabled = False

   Do While Bac_SQL_Fetch(Sqldatos())
      Let nContador = nContador + 1
      Let Grid.Rows = Grid.Rows + 1

      Let Grid.TextMatrix(Grid.Rows - 1, MiGrid_Marca) = "" '--> SqlDatos(MiGrid_Marca + 1)
      Let Grid.TextMatrix(Grid.Rows - 1, MiGrid_VMark) = Sqldatos(MiGrid_Marca + 1)
      Let Grid.TextMatrix(Grid.Rows - 1, MiGrid_Fecha) = Sqldatos(MiGrid_Fecha + 1)
      Let Grid.TextMatrix(Grid.Rows - 1, MiGrid_Modul) = Sqldatos(MiGrid_Modul + 1)
      Let Grid.TextMatrix(Grid.Rows - 1, MiGrid_Prodc) = Sqldatos(MiGrid_Prodc + 1)
      Let Grid.TextMatrix(Grid.Rows - 1, MiGrid_Contr) = Sqldatos(MiGrid_Contr + 1)
      Let Grid.TextMatrix(Grid.Rows - 1, MiGrid_Estad) = Sqldatos(MiGrid_Estad + 1)
      Let Grid.TextMatrix(Grid.Rows - 1, MiGrid_Clien) = Sqldatos(MiGrid_Clien + 1)
      Let Grid.TextMatrix(Grid.Rows - 1, MiGrid_Moned) = Sqldatos(MiGrid_Moned + 1)
      Let Grid.TextMatrix(Grid.Rows - 1, MiGrid_FPago) = Sqldatos(MiGrid_FPago + 1)
      Let Grid.TextMatrix(Grid.Rows - 1, MiGrid_Monto) = Format(Sqldatos(MiGrid_Monto + 1), FDecimal)
      Let Grid.TextMatrix(Grid.Rows - 1, MiGrid_Preci) = Format(Sqldatos(MiGrid_Preci + 1), FDecimal)
      Let Grid.TextMatrix(Grid.Rows - 1, MiGrid_FVCto) = Sqldatos(MiGrid_FVCto + 1)
      Let Grid.TextMatrix(Grid.Rows - 1, MiGrid_IdGrp) = Sqldatos(MiGrid_IdGrp + 1)
      Let Grid.TextMatrix(Grid.Rows - 1, MiGrid_EsGrp) = Sqldatos(MiGrid_EsGrp + 1)
      Let Grid.TextMatrix(Grid.Rows - 1, MiGrid_Reser) = Sqldatos(MiGrid_Reser + 1)
      Let Grid.TextMatrix(Grid.Rows - 1, MiGrid_VMark) = 0
      Let Grid.TextMatrix(Grid.Rows - 1, MiGrid_SisMo) = Sqldatos(MiGrid_SisMo)

      Call FuncSettingIconDefecto(Grid.Rows - 1, 0, False)

      If xFilas = -1 Then
         Let xFilas = Sqldatos(Grid.Cols)
      End If

      Call FuncMoveProgress(nContador, xFilas)
      Call BacControlWindows(1)
   Loop
   
   Let Grid.Redraw = True
   If Grid.Rows > Grid.FixedRows Then
      Let Grid.Enabled = True
   End If
   
   Let Screen.MousePointer = vbDefault
   Let PnlProgress.FloodColor = &H8000000F
   Let PnlProgress.Visible = False

   Let BACSwapParametros.Timer1.Enabled = True
  '--> Let PnlProgress.Visible = False
End Function

Private Function FuncMoveProgress(ByVal nRow As Long, ByVal nRous As Long)
   On Error Resume Next

   If ((nRow * 100#) / nRous) > 49 Then
      Let PnlProgress.ForeColor = vbWhite
   Else
      Let PnlProgress.ForeColor = vbBlack
   End If

   Let PnlProgress.FloodPercent = ((nRow * 100#) / nRous)

   On Error GoTo 0
End Function

Private Sub Grid_Click()
   Dim nContrato  As Long

   If Val(Grid.TextMatrix(Grid.RowSel, MiGrid_VMark)) = 0 Then
      If UCase(Left(Grid.TextMatrix(Grid.RowSel, MiGrid_Estad), 1)) = "E" Then
         Call MsgBox("[ CONTROL DE ENVIO DE OPERACIONES ]" & vbCrLf & vbCrLf & "- Operación se encuentra enviada, no es posible seleccionarla para un posible envío.", vbExclamation, App.Title)
        'Exit Sub
      End If

      Let nContrato = Grid.TextMatrix(Grid.RowSel, MiGrid_Contr)
      If ChequeaCodigoCliente(nContrato) = False Then
         Call MsgBox("[ CONTROL DE ENVIO DE OPERACIONES ]" & vbCrLf & vbCrLf & "- Se debe definir el codigo DCV, para el clientes antes de enviar.", vbExclamation, App.Title)
         Call Grid.SetFocus
         Exit Sub
      End If

      Call FuncSettingIconDefecto(Grid.RowSel, 0, True)
      Let Grid.TextMatrix(Grid.RowSel, MiGrid_VMark) = 1
      Let nRowsSel = nRowsSel + 1
   Else
      Call FuncSettingIconDefecto(Grid.RowSel, 0, False)
      Let Grid.TextMatrix(Grid.RowSel, MiGrid_VMark) = 0
      Let nRowsSel = nRowsSel - 1
   End If

   Let Toolbar1.Buttons(MiButton_Enviar).Enabled = IIf(nRowsSel > 0, True, False)
End Sub

Private Function FuncSettingIconDefecto(ByVal xFila As Long, ByVal xColumna As Long, ByVal xMarcar As Boolean)
   Let Grid.Row = xFila
   Let Grid.Col = xColumna
   Let Grid.CellPictureAlignment = flexAlignCenterCenter
   Set Grid.CellPicture = IIf(xMarcar = False, SinCheck(1).Image, ConCheck(1).Image)
End Function

Private Function FuncGenerar()
   Dim Sqldatos()
   Dim ClaseInterfaz As New clsInterfazDCV
   Dim nContador     As Long
   Dim xContrato     As Long
   Dim xModulo       As String

  '--> Este proceso marca las operaciones que seran enviadas en la tabla de operacions, con un numero de grupo.
   Call BacBeginTransaction

   Let NewId = FuncLoadNewCodEnvio

   For nContador = Grid.FixedRows To Grid.Rows - 1
      If Grid.TextMatrix(nContador, MiGrid_VMark) = 1 Then

         Let xModulo = Grid.TextMatrix(nContador, MiGrid_SisMo)
         Let xContrato = Grid.TextMatrix(nContador, MiGrid_Contr)

         Envia = Array()
         AddParam Envia, MiTag_nMarca
         AddParam Envia, NewId
         AddParam Envia, xModulo
         AddParam Envia, xContrato
         If Not Bac_Sql_Execute("dbo.SP_GENERA_NEW_GRUPO", Envia) Then
            Call BacRollBackTransaction
            GoTo ErrClass
            Exit Function
         End If
      End If

   Next nContador

   Call BacCommitTransaction

   '--> Este proceso marca las operaciones que seran enviadas en la tabla de operacions
   If ClaseInterfaz.FuncGenIntDcv_Contratos(Grid, [ARCHIVO DE CONTRATOS], NewId) = False Then
      Call MsgBox("[ Control de Generación ]" & vbCrLf & vbCrLf & "Se ha generado un error en la generación del archivo.", vbExclamation, App.Title)
   Else
     'Call MsgBox("[ Control de Generación ]" & vbCrLf & vbCrLf & "Archivo se ha generado correctamente.", vbInformation, App.Title)
      Call FuncLoadDatos
   End If

   Set ClaseInterfaz = Nothing

Exit Function
ErrClass:
   Set ClaseInterfaz = Nothing
   Call MsgBox("Error en la generacion del Archivo", vbExclamation, App.Title)
End Function

Private Function FuncLoadNewCodEnvio() As Long
   Dim Sqldatos()

   Let FuncLoadNewCodEnvio = 1

   Envia = Array()
   AddParam Envia, MiTag_nFolio
   If Not Bac_Sql_Execute("dbo.SP_GENERA_NEW_GRUPO", Envia) Then
      Exit Function
   End If
   If Bac_SQL_Fetch(Sqldatos()) Then
      Let FuncLoadNewCodEnvio = Sqldatos(1)
   End If
End Function

Private Function ChequeaCodigoCliente(ByVal xNumContrato As Long) As Boolean
   Dim Sqldatos()
   
   Let ChequeaCodigoCliente = False
   
   Envia = Array()
   AddParam Envia, CDbl(3)
   AddParam Envia, xNumContrato
   AddParam Envia, CDbl(0)
   AddParam Envia, CDbl(0)
   AddParam Envia, CDbl(0)
   AddParam Envia, ""
   If Not Bac_Sql_Execute("SP_MNT_TBL_CODIGO_CLIENTE_DCV", Envia) Then
      Call MsgBox("Se ha generado un error inesperado, en la recuperacion de codigo de cliente en dcv.", vbExclamation, ap.ti)
   End If
   If Bac_SQL_Fetch(Sqldatos()) Then
      If Sqldatos(1) < 0 Then
         Exit Function
      End If
   End If

   Let ChequeaCodigoCliente = True

End Function
