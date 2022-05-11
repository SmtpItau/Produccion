VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form FRM_INF_LINCRAPRO 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Informe de Lineas por Contraparte y Producto."
   ClientHeight    =   2610
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   5220
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   2610
   ScaleWidth      =   5220
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   5220
      _ExtentX        =   9208
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "vista previa"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "impresora"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "cerrar"
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   2895
         Top             =   195
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
               Picture         =   "FRM_INF_LINCRAPRO.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_INF_LINCRAPRO.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_INF_LINCRAPRO.frx":1DB4
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame Frame1 
      Height          =   2175
      Left            =   30
      TabIndex        =   1
      Top             =   435
      Width           =   5205
      Begin VB.ComboBox cmbEstado 
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
         Left            =   1410
         Style           =   2  'Dropdown List
         TabIndex        =   12
         Top             =   1755
         Width           =   3675
      End
      Begin VB.Frame Frame2 
         Height          =   90
         Left            =   75
         TabIndex        =   10
         Top             =   735
         Width           =   4980
      End
      Begin VB.TextBox txtNombre 
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
         Left            =   960
         Locked          =   -1  'True
         TabIndex        =   7
         Top             =   1320
         Width           =   4140
      End
      Begin BACControles.TXTNumero txtRut 
         Height          =   330
         Left            =   960
         TabIndex        =   5
         Top             =   975
         Width           =   1260
         _ExtentX        =   2223
         _ExtentY        =   582
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
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin VB.ComboBox cmbTipoCliente 
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
         Left            =   135
         Style           =   2  'Dropdown List
         TabIndex        =   3
         Top             =   375
         Width           =   4935
      End
      Begin BACControles.TXTNumero txtCodigo 
         Height          =   330
         Left            =   2970
         TabIndex        =   6
         Top             =   975
         Width           =   330
         _ExtentX        =   582
         _ExtentY        =   582
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
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Estado Linea"
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
         Left            =   120
         TabIndex        =   11
         Top             =   1785
         Width           =   1050
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Codigo"
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
         Left            =   2280
         TabIndex        =   9
         Top             =   1035
         Width           =   585
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Nombre"
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
         Left            =   150
         TabIndex        =   8
         Top             =   1380
         Width           =   660
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
         Index           =   2
         Left            =   150
         TabIndex        =   4
         Top             =   1035
         Width           =   585
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
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
         Height          =   210
         Index           =   0
         Left            =   150
         TabIndex        =   2
         Top             =   165
         Width           =   1245
      End
   End
End
Attribute VB_Name = "FRM_INF_LINCRAPRO"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Enum oDestinoReporte
   [Windows] = crptToWindow
   [Printer] = crptToPrinter
End Enum

Private Sub Form_Load()
   Me.Top = 0: Me.Left = 0
   Me.Icon = BacControlFinanciero.Icon
   
  'Call CargarSistema
   Call CargarTipoCliente
   cmbEstado.ListIndex = 0
   cmbTipoCliente.ListIndex = 0
End Sub

Private Sub CargarTipoCliente()
   Dim Datos()
   
   Envia = Array()
   AddParam Envia, "072"   '--> 'TipopCliente
   If Not Bac_Sql_Execute("Bacparamsuda.dbo.SP_LEERCODIGOS", Envia) Then
      MsgBox "Problemas en Procedimiento Almacenado", vbCritical, TITSISTEMA
      Exit Sub
   End If
   cmbTipoCliente.Clear
   cmbTipoCliente.AddItem "<< TODOS >>" & Space(100) & 0
   Do While Bac_SQL_Fetch(Datos())
      cmbTipoCliente.AddItem Datos(6) & Space(100) & Datos(2)
      cmbTipoCliente.ItemData(cmbTipoCliente.NewIndex) = Datos(2)
   Loop
   
   cmbEstado.Clear
   cmbEstado.AddItem "Todos" & Space(100) & "0"
   cmbEstado.AddItem "Lineas Vigentes" & Space(100) & "1"
   cmbEstado.AddItem "Lineas Bloqueadas" & Space(100) & "2"
   cmbEstado.AddItem "Lineas Vencidas" & Space(100) & "3"
   
   
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 1: Call Imprimir(Windows)
      Case 2: Call Imprimir(Printer)
      Case 3: Unload Me
   End Select
End Sub

Private Sub Imprimir(Destino As oDestinoReporte)
   On Error GoTo ErrorImpresion
   
   Call Limpiar_Cristal
  'BacControlFinanciero.CryFinanciero.ReportFileName = gsRPT_Path & "rptlineacr_1.rpt"
   BacControlFinanciero.CryFinanciero.ReportFileName = gsRPT_Path & "RptLineasCredito.rpt"
   BacControlFinanciero.CryFinanciero.StoredProcParam(0) = CDbl(txtRut.Text)
   BacControlFinanciero.CryFinanciero.StoredProcParam(1) = CDbl(txtCodigo.Text)
   BacControlFinanciero.CryFinanciero.StoredProcParam(2) = CDbl(cmbTipoCliente.ItemData(cmbTipoCliente.ListIndex))
   BacControlFinanciero.CryFinanciero.StoredProcParam(3) = CDbl(Right(cmbEstado, 2))
   BacControlFinanciero.CryFinanciero.StoredProcParam(4) = gsBAC_User
   BacControlFinanciero.CryFinanciero.Connect = swConeccion
   BacControlFinanciero.CryFinanciero.Destination = Destino
   BacControlFinanciero.CryFinanciero.Action = 1
    
Exit Sub
ErrorImpresion:
   MsgBox Err.Description, vbExclamation, TITSISTEMA
End Sub

Private Sub TxtRut_DblClick()
'   BacAyuda.TipoCliente = cmbTipoCliente.ItemData(cmbTipoCliente.ListIndex)
'   BacAyuda.Tag = "Clientes"
'   BacAyuda.Show 1
   BacAyuda.TipoCliente = cmbTipoCliente.ItemData(cmbTipoCliente.ListIndex)
   BacAyuda.Tag = "Clientes"
    BacAyudaCliente.Show 1
    

   If giAceptar = True Then
      txtRut.Text = RetornoAyuda
      txtCodigo.Text = RetornoAyuda2
      Me.txtNombre = RetornoAyuda3
   End If

End Sub
