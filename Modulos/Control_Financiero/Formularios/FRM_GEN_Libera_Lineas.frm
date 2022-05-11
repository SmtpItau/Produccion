VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form FRM_GEN_Libera_Lineas 
   Caption         =   "Liberación de Lineas de Credito."
   ClientHeight    =   4515
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   10440
   LinkTopic       =   "Form2"
   LockControls    =   -1  'True
   MDIChild        =   -1  'True
   ScaleHeight     =   4515
   ScaleWidth      =   10440
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   10440
      _ExtentX        =   18415
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   9
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Buscar..."
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Liberrar..."
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.Visible         =   0   'False
            Object.ToolTipText     =   "Rechazar..."
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Vista Previa...."
            ImageIndex      =   4
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Impresora"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Cerrar ..."
            ImageIndex      =   6
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button8 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "<< Marcar Todos >>"
            ImageIndex      =   7
         EndProperty
         BeginProperty Button9 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "<< Desmarcar Todos >>"
            ImageIndex      =   8
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   2685
         Top             =   30
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   8
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_GEN_Libera_Lineas.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_GEN_Libera_Lineas.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_GEN_Libera_Lineas.frx":1DB4
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_GEN_Libera_Lineas.frx":2C8E
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_GEN_Libera_Lineas.frx":3B68
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_GEN_Libera_Lineas.frx":4A42
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_GEN_Libera_Lineas.frx":4D5C
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_GEN_Libera_Lineas.frx":5C36
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame CuadroFiltro 
      Height          =   1245
      Left            =   15
      TabIndex        =   1
      Top             =   435
      Width           =   10410
      Begin VB.ComboBox cmbFormaPago 
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
         Left            =   6150
         Style           =   2  'Dropdown List
         TabIndex        =   16
         Top             =   135
         Width           =   3600
      End
      Begin VB.TextBox txtDvCliente 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   915
         Locked          =   -1  'True
         TabIndex        =   14
         Text            =   "K"
         Top             =   840
         Width           =   270
      End
      Begin BACControles.TXTNumero txtRutCliente 
         Height          =   315
         Left            =   1200
         TabIndex        =   13
         Top             =   840
         Width           =   1155
         _ExtentX        =   2037
         _ExtentY        =   556
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "97,051,000"
         Text            =   "97,051,000"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin VB.ComboBox cmdEstado 
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
         Left            =   6150
         Style           =   2  'Dropdown List
         TabIndex        =   11
         Top             =   480
         Width           =   3600
      End
      Begin VB.ComboBox cmbMoneda 
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
         Left            =   6105
         Style           =   2  'Dropdown List
         TabIndex        =   10
         Top             =   840
         Visible         =   0   'False
         Width           =   3600
      End
      Begin VB.ComboBox cmbProducto 
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
         Left            =   1230
         Style           =   2  'Dropdown List
         TabIndex        =   9
         Top             =   495
         Width           =   3615
      End
      Begin VB.ComboBox cmbModulo 
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
         Left            =   1245
         Style           =   2  'Dropdown List
         TabIndex        =   8
         Top             =   150
         Width           =   3600
      End
      Begin BACControles.TXTNumero txtCodigoCliente 
         Height          =   315
         Left            =   2385
         TabIndex        =   15
         Top             =   840
         Width           =   360
         _ExtentX        =   635
         _ExtentY        =   556
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0"
         Text            =   "0"
         Min             =   "9"
         Max             =   "9"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Forma de Pago"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Index           =   5
         Left            =   4890
         TabIndex        =   17
         Top             =   195
         Width           =   1230
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Cliente"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Index           =   4
         Left            =   150
         TabIndex        =   12
         Top             =   915
         Width           =   585
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Estado"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Index           =   3
         Left            =   4890
         TabIndex        =   7
         Top             =   555
         Width           =   555
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Moneda"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Index           =   2
         Left            =   4845
         TabIndex        =   6
         Top             =   915
         Visible         =   0   'False
         Width           =   660
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Operación"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Index           =   1
         Left            =   150
         TabIndex        =   5
         Top             =   540
         Width           =   840
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Sistema"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Index           =   0
         Left            =   150
         TabIndex        =   4
         Top             =   195
         Width           =   675
      End
   End
   Begin VB.Frame CuadroDetalle 
      Height          =   2910
      Left            =   0
      TabIndex        =   2
      Top             =   1605
      Width           =   10410
      Begin MSComctlLib.ListView List 
         Height          =   2715
         Left            =   60
         TabIndex        =   3
         Top             =   135
         Width           =   10275
         _ExtentX        =   18124
         _ExtentY        =   4789
         View            =   3
         Sorted          =   -1  'True
         LabelWrap       =   0   'False
         HideSelection   =   -1  'True
         OLEDragMode     =   1
         OLEDropMode     =   1
         AllowReorder    =   -1  'True
         FullRowSelect   =   -1  'True
         HotTracking     =   -1  'True
         HoverSelection  =   -1  'True
         _Version        =   393217
         ForeColor       =   -2147483640
         BackColor       =   -2147483643
         BorderStyle     =   1
         Appearance      =   1
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         OLEDragMode     =   1
         OLEDropMode     =   1
         NumItems        =   0
      End
   End
End
Attribute VB_Name = "FRM_GEN_Libera_Lineas"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private Enum ModoInforme
   [VistaPrevia] = crptToWindow
   [Impresora] = crptToPrinter
End Enum
   
Private Sub CargaFormaPago(ObjFormaPago As ComboBox, iMoneda As Integer)
   Dim Datos()
   
   Envia = Array()
   AddParam Envia, CDbl(4)       ' --> Codigo Evento
   AddParam Envia, ""            ' --> Sistema
   AddParam Envia, ""            ' --> Producto
   AddParam Envia, CDbl(iMoneda) ' --> Moneda
   If Not Bac_Sql_Execute("SP_MNT_LINEAS_RETENIDAS", Envia) Then
      Exit Sub
   End If
   ObjFormaPago.Clear
   ObjFormaPago.AddItem "<< TODAS >>" & Space(100) & " "
   ObjFormaPago.ItemData(ObjFormaPago.NewIndex) = Val(0)
   Do While Bac_SQL_Fetch(Datos())
      ObjFormaPago.AddItem Datos(2)
      ObjFormaPago.ItemData(ObjFormaPago.NewIndex) = Val(Datos(1))
   Loop
End Sub

Private Sub CargaMoneda(ObjMoneda As ComboBox)
   Dim Datos()
   
   Envia = Array()
   AddParam Envia, CDbl(3) ' --> Codigo Evento
   If Not Bac_Sql_Execute("SP_MNT_LINEAS_RETENIDAS", Envia) Then
      Exit Sub
   End If
   ObjMoneda.Clear
   ObjMoneda.AddItem "<< TODAS >>" & Space(100) & " "
   Do While Bac_SQL_Fetch(Datos())
      ObjMoneda.AddItem Datos(2) & " - " & Datos(3)
      ObjMoneda.ItemData(ObjMoneda.NewIndex) = Val(Datos(1))
   Loop
End Sub

Private Sub Carga_Productos(Sistema As String)
   Dim Datos()
   
   Envia = Array()
   AddParam Envia, CDbl(2)       ' --> Codigo Evento
   AddParam Envia, Trim(Sistema) ' --> Sistema
   If Not Bac_Sql_Execute("SP_MNT_LINEAS_RETENIDAS", Envia) Then
      Exit Sub
   End If
   cmbProducto.Clear
   cmbProducto.AddItem "<< TODOS >>" & Space(100) & " "
   Do While Bac_SQL_Fetch(Datos())
      cmbProducto.AddItem Datos(1) & Space(100) & Datos(2)
   Loop
End Sub

Private Sub Carga_Sistemas()
   Dim Datos()
   
   Envia = Array()
   AddParam Envia, CDbl(1)       ' --> Codigo Evento
   If Not Bac_Sql_Execute("SP_MNT_LINEAS_RETENIDAS", Envia) Then
      Exit Sub
   End If
   cmbModulo.Clear
   cmbModulo.AddItem "<< TODOS >>" & Space(100) & " "
   Do While Bac_SQL_Fetch(Datos())
      cmbModulo.AddItem Datos(1) & Space(100) & Datos(2)
   Loop
End Sub

Private Sub Nombres()
   List.ListItems.Clear
   
   Envia = Array()
   AddParam Envia, "Numero Operación"
   AddParam Envia, "Fecha"
   AddParam Envia, "Estado"
   AddParam Envia, "Sistema"
   AddParam Envia, "Producto"
   AddParam Envia, "Tipo Operación"
   AddParam Envia, "Cliente"
   AddParam Envia, "Monto"
   AddParam Envia, "Tir"
   AddParam Envia, "Forma Pago"
  'AddParam Envia, "Fecha"

   Call LlenaListado(Envia, True)
   
End Sub

Private Sub Cargar()
   On Error GoTo ErrorCarga
   Dim Datos()
   Dim iFormaPago As Integer
   
   If cmbFormaPago.ListIndex = -1 Then
      iFormaPago = 0
   Else
      iFormaPago = cmbFormaPago.ItemData(cmbFormaPago.ListIndex)
   End If
   
   List.Sorted = False
   List.Checkboxes = True
   List.AllowColumnReorder = False
   List.ListItems.Clear
   
   Envia = Array()
   AddParam Envia, Format(gsBAC_Fecp, "yyyymmdd")
   AddParam Envia, Trim(Right(cmbModulo.Text, 3))
   AddParam Envia, Trim(Right(cmbProducto.Text, 5))
   AddParam Envia, Trim(Right(cmdEstado.Text, 5))
   AddParam Envia, CDbl(txtRutCliente.Text)
   AddParam Envia, CDbl(txtCodigoCliente.Text)
   AddParam Envia, CDbl(iFormaPago)
   AddParam Envia, gsBAC_User
   If Not Bac_Sql_Execute("SP_LEE_LINEAS_RETENIDAS", Envia) Then
      Exit Sub
   End If
   Do While Bac_SQL_Fetch(Datos())
      List.ListItems.Add , , Format(Datos(7), FEntero)                                                               ' Numero Operacion
      List.ListItems.Item(List.ListItems.Count).ListSubItems.Add , , Datos(1)                                        ' Estado
      List.ListItems.Item(List.ListItems.Count).ListSubItems.Add , , Datos(11)                                        ' Fecha
      List.ListItems.Item(List.ListItems.Count).ListSubItems.Add , , Datos(2)                                       ' Sistema
      List.ListItems.Item(List.ListItems.Count).ListSubItems.Add , , Datos(3)                                        ' Producto
      List.ListItems.Item(List.ListItems.Count).ListSubItems.Add , , Datos(4)                                        ' Tipo Operacion
      List.ListItems.Item(List.ListItems.Count).ListSubItems.Add , , Format(Datos(6), FEntero) + Space(5) + Datos(5) ' Nombre Cliente - Rut
      List.ListItems.Item(List.ListItems.Count).ListSubItems.Add , , Format(Datos(8), FEntero)                       ' Monto
      List.ListItems.Item(List.ListItems.Count).ListSubItems.Add , , Format(Datos(9), FDecimal)                      ' Tir
      List.ListItems.Item(List.ListItems.Count).ListSubItems.Add , , Datos(10)                                       ' Forma Pago
     'List.ListItems.Item(List.ListItems.Count).ListSubItems.Add , , Datos(1)                                        ' Estado
   Loop
Exit Sub
ErrorCarga:
   MsgBox Err.Description, vbExclamation, TITSISTEMA
End Sub

Private Sub CmbModulo_Click()
   Dim oModulo As String
   Let oModulo = Trim(Right(cmbModulo.Text, 5))
   
   Call Carga_Productos(oModulo)
   Call Privilegios.CARGAR_PRODUCTOS_HABILITADOS(gsBAC_User, oModulo, cmbProducto, 1)
   
End Sub
Private Sub cmbMoneda_Click()
   Dim iMoneda As Integer
   
   If CmbMoneda.ListIndex > -1 Then
      iMoneda = CmbMoneda.ItemData(CmbMoneda.ListIndex)
   Else
      iMoneda = 0
   End If
   Call CargaFormaPago(cmbFormaPago, iMoneda)
End Sub

Private Sub cmdEstado_Click()
   Call Cargar
End Sub

Private Sub Form_Activate()

   BacControlFinanciero.MousePointer = 0
   
   Call Privilegios.ACTUALIZADOR(gsBAC_User)

   If Privilegios.objPrivilegios.Liberacion_Operaciones = 0 Then
      Let CuadroFiltro.Enabled = False
      Let CuadroDetalle.Enabled = False
      Let Toolbar1.Enabled = False
      Call List.ListItems.Clear
      Let Me.Caption = "Liberacion de Líneas de Credito.- OPCION NO HABILITADA POR [PERFILES DE ACCESO ALINEAS].-"
   Else
      Let CuadroFiltro.Enabled = True
      Let CuadroDetalle.Enabled = True
      Let Toolbar1.Enabled = True

      Let Me.Caption = "Liberacion de Líneas de Credito.-"
      Call Privilegios.CARGAR_SISTEMAS_HABILITADOS(gsBAC_User, cmbModulo, 1)
   End If
End Sub

Private Sub Form_Load()
   Me.Icon = BacControlFinanciero.Icon
   Me.Top = 0: Me.Left = 0
   
   Call Nombres
   Call Carga_Sistemas
   Call CargaMoneda(CmbMoneda)
   Call CargaFormaPago(cmbFormaPago, 0)
   
   txtRutCliente.Text = 0
   txtCodigoCliente.Text = 0
   txtDvCliente.Visible = False
   
   cmdEstado.AddItem "RETENIDAS" & Space(100) & "N"
   cmdEstado.AddItem "LIBERADAS" & Space(100) & "S"
   cmdEstado.AddItem "<< TODOS >>" & Space(100) & " "
   cmdEstado.ListIndex = 0
   
   CmbMoneda.ListIndex = -1
   
   
 End Sub

Private Sub Form_Resize()
   On Error GoTo ErrorResize

   CuadroFiltro.Width = Me.Width - 150
   CuadroDetalle.Width = Me.Width - 150
   List.Width = CuadroDetalle.Width - 150
   
   CuadroDetalle.Height = (Me.Height - CuadroFiltro.Height) - 800
   List.Height = CuadroDetalle.Height - 250

   Exit Sub
ErrorResize:
End Sub

Private Sub LlenaListado(Arreglo As Variant, Titulos As Boolean)
   Dim nRegistro As Integer
   
   With List
      For nRegistro = 0 To UBound(Arreglo)
         If Titulos Then
            .ColumnHeaders.Add nRegistro + 1, , Arreglo(nRegistro), 2000
            If nRegistro = 0 Then
            End If
         Else
            If nRegistro = 0 Then
               .ListItems.Add , , Arreglo(nRegistro)
            Else
               .ListItems.Item(.ListItems.Count).ListSubItems.Add , , Arreglo(nRegistro)
            End If
         End If
      Next nRegistro
   End With
End Sub


Private Sub List_ItemCheck(ByVal Item As MSComctlLib.ListItem)
   List.SelectedItem = Item
   If Left(List.ListItems(List.SelectedItem.Index).ListSubItems.Item(2).Text, 1) <> "R" Then
      List.ListItems(List.SelectedItem.Index).Checked = False
   End If
End Sub

Private Sub Informe_Lineas_Liberadas(Destino As ModoInforme)
   On Error GoTo ErrorImprimir
   
   Call Limpiar_Cristal
   
   BacControlFinanciero.CryFinanciero.WindowTitle = "Informe de Líneas Liberadas Manualmente.-"
   BacControlFinanciero.CryFinanciero.ReportFileName = gsRPT_Path & "Informe_Lineas_Liberadas.rpt"
   BacControlFinanciero.CryFinanciero.Destination = Destino
   BacControlFinanciero.CryFinanciero.StoredProcParam(0) = Format$(gsBAC_Fecp, "yyyy-mm-dd 00:00:00.000")
   BacControlFinanciero.CryFinanciero.StoredProcParam(1) = CStr(gsBAC_User)
   BacControlFinanciero.CryFinanciero.Connect = swConeccion
   BacControlFinanciero.CryFinanciero.WindowState = crptMaximized
   BacControlFinanciero.CryFinanciero.WindowTitle = "LINEAS OCUPADAS FORWARD"
   BacControlFinanciero.CryFinanciero.Action = 1

Exit Sub
ErrorImprimir:
   MsgBox "¡ Problemas al Emitir Informe de Lineas Liberadas. !", vbExclamation, TITSISTEMA
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 1 ' Buscar
         Call Cargar
      Case 2 ' Liberar
         Call Liberar
      Case 4 'Vista Previa
         Call Informe_Lineas_Liberadas(VistaPrevia)
      Case 5 'Impresora
         Call Informe_Lineas_Liberadas(Impresora)
      Case 6
         Unload Me
      Case 8
         Call Marcas(True)
      Case 9
         Call Marcas(False)
   End Select
End Sub

Sub Marcas(oValor As Boolean)
   Dim iContador  As Long
   
   For iContador = 1 To List.ListItems.Count
      If Left(List.ListItems(iContador).ListSubItems.Item(1).Text, 1) = "R" Then
         List.ListItems(iContador).Checked = oValor
      End If
   Next iContador
   
End Sub
Private Sub Liberar()
   On Error GoTo ErrorLiberacion
   Dim Datos()
   Dim iContador        As Long
   Dim iMensaje         As String
   Dim iMensajeOperacion As String  'PROD-13828
   Dim Id_sistema       As String
   Dim Codigo_Producto  As String
   Dim Numero_Operacion As Long
   Dim Monto            As Double
   
   If List.ListItems.Count = 0 Then
      MsgBox "No existen operaciones para liberar....", vbInformation, TITSISTEMA
      Exit Sub
   End If
   
   If Not Bac_Sql_Execute("BEGIN TRANSACTION") Then
      Exit Sub
   End If
   
   iMensaje = ""
   For iContador = 1 To List.ListItems.Count
      If List.ListItems(iContador).Checked = True Then
         Id_sistema = Trim(Left(List.ListItems(iContador).ListSubItems.Item(3).Text, 3))
         Codigo_Producto = Trim(Left(List.ListItems(iContador).ListSubItems.Item(4).Text, 4))
         Numero_Operacion = List.ListItems(iContador).Text
         Monto = CDbl(List.ListItems(iContador).ListSubItems.Item(7).Text)
         
         Envia = Array()
         AddParam Envia, CStr(Id_sistema)
         AddParam Envia, CStr(Codigo_Producto)
         AddParam Envia, CDbl(Numero_Operacion)
         AddParam Envia, CDbl(Monto)
         If Not Bac_Sql_Execute("SP_LIBERA_LINEAS_RETENIDAS", Envia) Then
            Call Bac_Sql_Execute("ROLLBACK TRANSACTION")
            MsgBox "Problemas al Rechazar Operación", vbCritical, TITSISTEMA
            Exit Sub
         End If
         If Bac_SQL_Fetch(Datos()) Then
            If Datos(1) = "NO" Then
               Call Bac_Sql_Execute("ROLLBACK TRANSACTION")
               MsgBox Datos(2), vbOKOnly + vbExclamation
               Exit Sub
            End If
         Else
            iMensaje = iMensaje & " -   Sistema : " & Id_sistema & "   Operación : " & Numero_Operacion & vbCrLf
         End If
         iMensajeOperacion = "Sistema : " & Id_sistema & "   Operación : " & Numero_Operacion
         'PROD-13828
         'Opt50006 : Opcion de Liberación de Lineas
         '01       : evento, 01 es grabar
         Call GRABA_LOG_AUDITORIA(1, (gsBAC_Fecp), gsBac_IP, gsBAC_User, "SCF", "Opt50006", "01", "Liberación línea retenida", "Lineas_retenidas", iMensajeOperacion, "")
      End If
   Next iContador
   
   Call Bac_Sql_Execute("COMMIT TRANSACTION")
   
   If Len(iMensaje) > 0 Then
      MsgBox "Se han liberado las siguientes linéas de crédito :" & vbCrLf & iMensaje, vbInformation, TITSISTEMA
   End If
   
   Call Cargar
   
   On Error GoTo 0
Exit Sub
ErrorLiberacion:
   Call Bac_Sql_Execute("ROLLBACK TRANSACTION")
   MsgBox "Problemas en la liberación de Operaciones." & vbCrLf & vbCrLf & Err.Description, vbExclamation, TITSISTEMA
End Sub

Private Sub txtRutCliente_DblClick()
'   BacAyuda.Tag = "Clientes"
'   BacAyuda.Show 1
    BacAyudaCliente.Tag = "Cliente"
    BacAyudaCliente.Show 1
   If giAceptar = True Then
      txtRutCliente.Text = RetornoAyuda
      txtCodigoCliente.Text = RetornoAyuda2
   End If
End Sub
