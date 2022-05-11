VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form FRM_MNT_DatosClientes 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantención de Clasificación de Riesgo Cliente"
   ClientHeight    =   2520
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   6285
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   2520
   ScaleWidth      =   6285
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   1
      Top             =   0
      Width           =   6285
      _ExtentX        =   11086
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
         NumButtons      =   8
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   5
         EndProperty
         BeginProperty Button8 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   6
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   7080
      Top             =   250
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
            Picture         =   "FRM_MNT_DatosClientes.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_DatosClientes.frx":0EDA
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_DatosClientes.frx":1DB4
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_DatosClientes.frx":2C8E
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_DatosClientes.frx":2FA8
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_DatosClientes.frx":3E82
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.Frame Frame1 
      Height          =   2115
      Left            =   45
      TabIndex        =   2
      Top             =   375
      Width           =   6225
      Begin VB.Frame Frame2 
         BorderStyle     =   0  'None
         Enabled         =   0   'False
         Height          =   645
         Left            =   1440
         TabIndex        =   10
         Top             =   210
         Width           =   4740
         Begin VB.TextBox txtDV 
            Alignment       =   2  'Center
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   330
            Left            =   0
            Locked          =   -1  'True
            TabIndex        =   12
            Text            =   "0"
            Top             =   210
            Width           =   375
         End
         Begin VB.TextBox txtNombre 
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   330
            Left            =   405
            Locked          =   -1  'True
            TabIndex        =   11
            Text            =   "BANCO DEL DESARROLLO"
            Top             =   210
            Width           =   4260
         End
         Begin VB.Label LblEtiquetas 
            AutoSize        =   -1  'True
            Caption         =   "Nombre"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   210
            Index           =   1
            Left            =   435
            TabIndex        =   13
            Top             =   0
            Width           =   555
         End
      End
      Begin VB.ComboBox CmbClasificacionRiesgo 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         ItemData        =   "FRM_MNT_DatosClientes.frx":4D5C
         Left            =   120
         List            =   "FRM_MNT_DatosClientes.frx":4D5E
         Style           =   2  'Dropdown List
         TabIndex        =   6
         Top             =   1050
         Width           =   2565
      End
      Begin VB.ComboBox CmbSegmentoComercial 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   2685
         Style           =   2  'Dropdown List
         TabIndex        =   5
         Top             =   1050
         Width           =   3435
      End
      Begin VB.ComboBox cmbEjecutivoComercial 
         Height          =   315
         Left            =   120
         Style           =   2  'Dropdown List
         TabIndex        =   4
         Top             =   1680
         Width           =   6015
      End
      Begin VB.TextBox TXTRut 
         Alignment       =   1  'Right Justify
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   105
         Locked          =   -1  'True
         MousePointer    =   14  'Arrow and Question
         TabIndex        =   0
         Text            =   "97051000"
         Top             =   420
         Width           =   1305
      End
      Begin VB.Label LblEtiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Clasificación de Riesgo"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Index           =   2
         Left            =   120
         TabIndex        =   9
         Top             =   840
         Width           =   1680
      End
      Begin VB.Label LblEtiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Segmento Comercial"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Index           =   3
         Left            =   2685
         TabIndex        =   8
         Top             =   840
         Width           =   1470
      End
      Begin VB.Label LblEtiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Ejecutivo Comercial"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Index           =   4
         Left            =   135
         TabIndex        =   7
         Top             =   1470
         Width           =   1395
      End
      Begin VB.Label LblEtiquetas 
         AutoSize        =   -1  'True
         Caption         =   "RutCliente"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Index           =   0
         Left            =   120
         TabIndex        =   3
         Top             =   210
         Width           =   720
      End
   End
End
Attribute VB_Name = "FRM_MNT_DatosClientes"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public origRiesgo As String

Private Sub Form_Load()
   Let Me.top = 0:    Let Me.Left = 0
   Let Me.Icon = BacControlFinanciero.Icon

   Call Limpiar
   Call LlenaRiesgo(CmbClasificacionRiesgo)
   Call LlenaSegmento(CmbSegmentoComercial)
   Call LlenaEjecutivos(cmbEjecutivoComercial)
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 2:  Call CargaDatos
      Case 3:  Call Limpiar
      Case 4:  Call Grabar
      Case 5:  Call Unload(Me)
      Case 7:  Call FuncGenClasificaRiesgo(crptToPrinter)
      Case 8:  Call FuncGenClasificaRiesgo(crptToWindow)
   End Select
End Sub

Private Function FuncGenClasificaRiesgo(ByVal Destino As DestinationConstants)
   On Error GoTo ErrorInforme
   
   Dim nRutCliente   As Long
   Dim nCodCliente   As Long
   
   nRutCliente = 0
   If Len(TXTRut.Text) > 0 Then
      nRutCliente = CDbl(TXTRut.Text)
   End If
   nCodCliente = Val(TXTRut.Tag)

   Call Limpiar_Cristal

   BacControlFinanciero.CryFinanciero.ReportFileName = gsRPT_Path & "INFORME_CLASIFICACION_CLIENTE.rpt"
   BacControlFinanciero.CryFinanciero.Destination = Destino
   BacControlFinanciero.CryFinanciero.WindowTitle = "INFORME DE CLASIFICACION DE RIESGO CLIENTE"
   BacControlFinanciero.CryFinanciero.StoredProcParam(0) = nRutCliente
   BacControlFinanciero.CryFinanciero.StoredProcParam(1) = nCodCliente
   BacControlFinanciero.CryFinanciero.StoredProcParam(2) = gsBAC_User
   BacControlFinanciero.CryFinanciero.Connect = swConeccion
   BacControlFinanciero.CryFinanciero.WindowState = crptMaximized
   BacControlFinanciero.CryFinanciero.Action = 1

Exit Function
ErrorInforme:
   Call MsgBox(Err.Description, vbExclamation, App.Title)
End Function

Private Function Grabar()
   On Error GoTo falla
   Dim nomRiesgo     As String
   Dim nomEjecutivo  As String
   Dim codSegmento   As Integer
   Dim Datos()

   If TXTRut.Text = "" Then
      Exit Function
   End If
   If CmbClasificacionRiesgo.ListIndex = -1 Then
      MsgBox "No ha seleccionado la Clasificación del Riesgo!", vbExclamation, TITSISTEMA
      Exit Function
   End If
   If CmbSegmentoComercial.ListIndex = -1 Then
      MsgBox "No ha seleccionado el Segmento Comercial!", vbExclamation, TITSISTEMA
      Exit Function
   End If
   If cmbEjecutivoComercial.ListIndex = -1 Then
     'MsgBox "No ha seleccionado el Ejecutivo Comercial!", vbExclamation, TITSISTEMA
     'Exit Function
   End If

   nomRiesgo = RTrim(Mid$(CmbClasificacionRiesgo.List(CmbClasificacionRiesgo.ListIndex), 1, 100))
   nomEjecutivo = RTrim(Mid$(cmbEjecutivoComercial.List(cmbEjecutivoComercial.ListIndex), 1, 100))
   codSegmento = CInt(LTrim(Mid$(CmbSegmentoComercial.List(CmbSegmentoComercial.ListIndex), 100)))

   Envia = Array()
   AddParam Envia, CDbl(TXTRut.Text)
   AddParam Envia, Val(TXTRut.Tag)
   AddParam Envia, nomRiesgo
   AddParam Envia, codSegmento
   AddParam Envia, nomEjecutivo
   AddParam Envia, IIf(origRiesgo = nomRiesgo, "NO", "SI") '--> Indicador de cambio del riesgo
   If Not Bac_Sql_Execute("BacParamSuda.dbo.SP_GRABADATOSRIESGOCLIENTE", Envia) Then
      MsgBox "Se ha producido un error y no se pudo realizar la grabación de los datos!", vbCritical, TITSISTEMA
      Exit Function
   End If
   If Bac_SQL_Fetch(Datos()) Then
      If Datos(1) = "-1" Then
         MsgBox "Error: " & Datos(2), vbCritical, TITSISTEMA
      Else
         MsgBox Datos(2), vbInformation, TITSISTEMA
         Call Limpiar
      End If
   End If

Exit Function
falla:
   MsgBox "Se ha producido el siguiente error:" & vbCrLf & Err.Description, vbCritical, TITSISTEMA
End Function

Private Function Limpiar()
   TXTRut.Text = ""
   txtDV.Text = ""
   TXTNombre.Text = ""
   origRiesgo = ""
   CmbClasificacionRiesgo.ListIndex = -1
   cmbEjecutivoComercial.ListIndex = -1
   CmbSegmentoComercial.ListIndex = -1
   Call Bloquear
End Function

Private Function LlenaRiesgo(Combo As ComboBox) As Boolean
   Dim Datos()

   LlenaRiesgo = False

   Call Combo.Clear

   Envia = Array()
   If Not Bac_Sql_Execute("Bacparamsuda.dbo.SP_TRAECLASIFICACIONRIESGO") Then
      Exit Function
   End If
   Do While Bac_SQL_Fetch(Datos())
      If Not IsNull(Datos(1)) Then
         Combo.AddItem Datos(1) & Space(200) & Datos(2)
      End If
   Loop

   LlenaRiesgo = True
End Function

Private Function LlenaSegmento(Combo As ComboBox)
   Dim Datos()

   Let LlenaSegmento = False

   Call Combo.Clear

   Envia = Array()
   If Not Bac_Sql_Execute("Bacparamsuda.dbo.SP_TRAESEGMENTOCOMERCIAL") Then
      Exit Function
   End If
   Do While (Bac_SQL_Fetch(Datos()))
      If Not IsNull(Datos(1)) Then
         Combo.AddItem Datos(1) & Space(200) & Datos(2)
      End If
   Loop
   Let LlenaSegmento = True
End Function

Private Function LlenaEjecutivos(Combo As ComboBox)
   Dim Datos()

   LlenaEjecutivos = False

   Combo.Clear
   Envia = Array()
   If Not Bac_Sql_Execute("Bacparamsuda.dbo.SP_TRAEEJECUTIVOS") Then
      Exit Function
   End If
   Do While (Bac_SQL_Fetch(Datos()))
      If Not IsNull(Datos(1)) Then
         Combo.AddItem Datos(1) & Space(200) & Datos(2)
      End If
   Loop
   LlenaEjecutivos = True
End Function

Private Sub TxtRut_DblClick()
   
   giAceptar = False

   Call Limpiar

   RetornoAyuda = ""
   RetornoAyuda2 = ""
   RetornoAyuda3 = ""

'   BacAyuda.Tag = "Cliente"
'   BacAyuda.Show 1
    BacAyudaCliente.Tag = "Cliente"
    BacAyudaCliente.Show 1
   If Not giAceptar Then
      Exit Sub
   End If

   TXTRut.Text = RetornoAyuda
   TXTRut.Tag = CStr(Val(RetornoAyuda2))
   Call CargaDatos
End Sub

Private Function CargaDatos()
   Dim Datos()
   Dim nomRiesgo     As String
   Dim nomEjecutivo  As String
   Dim codSegmento   As Integer
   Dim nomSegmento   As String

   If LTrim(RTrim(TXTRut.Text)) = "" Then
      MsgBox "No hay datos para cargar!", vbExclamation, TITSISTEMA
      Exit Function
   End If

   Envia = Array()
   AddParam Envia, TXTRut.Text
   AddParam Envia, TXTRut.Tag
   If Not Bac_Sql_Execute("Bacparamsuda.dbo.SP_TRAEDATOSRIESGOCLIENTE", Envia) Then
      MsgBox "Error! No es posible obtener datos de riesgo de cliente seleccionado.", vbCritical, TITSISTEMA
      Exit Function
   End If
   If Bac_SQL_Fetch(Datos()) Then
      Let TXTNombre.Text = Datos(4)
      Let txtDV.Text = Datos(2)
      Let nomRiesgo = Datos(5)
      Call FijaCombo(CmbClasificacionRiesgo, nomRiesgo)

      Let nomEjecutivo = IIf(IsNull(Datos(8)), "", Datos(8))
      Call FijaCombo(cmbEjecutivoComercial, nomEjecutivo)

      Let nomRiesgo = IIf(IsNull(Datos(5)), "", Datos(5))
      Let origRiesgo = nomRiesgo

      If IsNull(Datos(6)) Then
         codSegmento = -1
         CmbSegmentoComercial.ListIndex = -1
      Else
         codSegmento = CInt(Datos(6))
         nomSegmento = Datos(7)
         Call FijaCombo(CmbSegmentoComercial, nomSegmento)
      End If
   End If

   Call Desbloquear
End Function

Private Function FijaCombo(ByRef Combo As ComboBox, ByVal Dato As String)
   Dim nContador  As Long
   Dim n       As Integer
   Dim p       As Integer
   Dim rev     As String

   If Len(Dato) = 0 Then
      Combo.ListIndex = -1
      Exit Function
   End If

   For nContador = 0 To Combo.ListCount - 1
      If Mid(Combo.List(nContador), 1, Len(Dato)) = Dato Then
         Combo.ListIndex = nContador
         Exit For
      End If
   Next nContador
End Function

Private Function Bloquear()
   CmbClasificacionRiesgo.Enabled = False
   cmbEjecutivoComercial.Enabled = False
   CmbSegmentoComercial.Enabled = False
End Function

Private Function Desbloquear()
   CmbClasificacionRiesgo.Enabled = True
   cmbEjecutivoComercial.Enabled = True
   CmbSegmentoComercial.Enabled = True
End Function
