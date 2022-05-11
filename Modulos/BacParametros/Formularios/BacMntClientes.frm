VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form BacMntClientes 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Mantención de Cliente"
   ClientHeight    =   6210
   ClientLeft      =   705
   ClientTop       =   1875
   ClientWidth     =   8790
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   6210
   ScaleWidth      =   8790
   ShowInTaskbar   =   0   'False
   Begin Threed.SSFrame Frame 
      Height          =   780
      Index           =   0
      Left            =   105
      TabIndex        =   0
      Top             =   105
      Width           =   8535
      _Version        =   65536
      _ExtentX        =   15055
      _ExtentY        =   1376
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
      Begin VB.TextBox txtNroCliente 
         Height          =   315
         Left            =   6100
         MaxLength       =   20
         TabIndex        =   3
         Top             =   300
         Width           =   1125
      End
      Begin VB.TextBox txtDigito 
         Height          =   315
         Left            =   2955
         MaxLength       =   1
         TabIndex        =   2
         Top             =   300
         Width           =   255
      End
      Begin VB.TextBox txtRut 
         Alignment       =   1  'Right Justify
         Height          =   315
         Left            =   1700
         MaxLength       =   10
         MouseIcon       =   "BacMntClientes.frx":0000
         MousePointer    =   99  'Custom
         MultiLine       =   -1  'True
         TabIndex        =   1
         Top             =   240
         Width           =   1140
      End
      Begin VB.Label Label 
         BackColor       =   &H00C0C0C0&
         Caption         =   "Código"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Index           =   4
         Left            =   4300
         TabIndex        =   38
         Top             =   300
         Width           =   1720
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "-"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   315
         Index           =   1
         Left            =   2850
         TabIndex        =   24
         Top             =   300
         Width           =   105
      End
      Begin VB.Label Label 
         BackColor       =   &H00C0C0C0&
         Caption         =   "Rut"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Index           =   0
         Left            =   120
         TabIndex        =   23
         Top             =   300
         Width           =   1500
      End
   End
   Begin Threed.SSFrame Frame 
      Height          =   3930
      Index           =   1
      Left            =   120
      TabIndex        =   25
      Top             =   885
      Width           =   8535
      _Version        =   65536
      _ExtentX        =   15055
      _ExtentY        =   6932
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
      Begin VB.ComboBox Cmbmercado 
         Height          =   315
         Left            =   1680
         Style           =   2  'Dropdown List
         TabIndex        =   17
         Top             =   3240
         Width           =   2535
      End
      Begin VB.TextBox txtNomSin 
         Height          =   315
         Left            =   6100
         MaxLength       =   10
         TabIndex        =   18
         Top             =   3150
         Width           =   2300
      End
      Begin VB.TextBox txtNumSin 
         Height          =   315
         Left            =   6100
         MaxLength       =   4
         TabIndex        =   16
         Top             =   2800
         Width           =   1140
      End
      Begin VB.TextBox txtctausd 
         Height          =   315
         Left            =   6100
         TabIndex        =   14
         Top             =   2400
         Width           =   2300
      End
      Begin VB.TextBox txtctacte 
         Height          =   315
         Left            =   1700
         TabIndex        =   13
         Top             =   2400
         Width           =   2500
      End
      Begin VB.ComboBox CmbTipoCliente 
         Height          =   315
         Left            =   1700
         Style           =   2  'Dropdown List
         TabIndex        =   15
         Top             =   2800
         Width           =   2500
      End
      Begin VB.ComboBox CmbComuna 
         Height          =   315
         Left            =   6100
         Style           =   2  'Dropdown List
         TabIndex        =   9
         Top             =   1320
         Width           =   2300
      End
      Begin VB.ComboBox CmbCiudad 
         Height          =   315
         Left            =   6100
         Style           =   2  'Dropdown List
         TabIndex        =   10
         Top             =   1640
         Width           =   2300
      End
      Begin VB.ComboBox CmbRegion 
         Height          =   315
         Left            =   1700
         Style           =   2  'Dropdown List
         TabIndex        =   8
         Top             =   1640
         Width           =   2500
      End
      Begin VB.TextBox TxtDireccion 
         Height          =   315
         Left            =   1700
         TabIndex        =   6
         Top             =   960
         Width           =   6700
      End
      Begin VB.TextBox TxtFax 
         Height          =   315
         Left            =   6120
         MaxLength       =   20
         TabIndex        =   12
         Top             =   1990
         Width           =   2300
      End
      Begin VB.TextBox TxtTelefono 
         Height          =   315
         Left            =   1700
         MaxLength       =   20
         TabIndex        =   11
         Top             =   1990
         Width           =   2490
      End
      Begin VB.TextBox TxtNombre 
         Height          =   315
         Left            =   1700
         MaxLength       =   40
         TabIndex        =   5
         Top             =   590
         Width           =   6700
      End
      Begin VB.ComboBox cmbPais 
         Height          =   315
         Left            =   1700
         Style           =   2  'Dropdown List
         TabIndex        =   7
         Top             =   1290
         Width           =   2500
      End
      Begin VB.TextBox txtgeneric 
         Height          =   315
         Left            =   1700
         MaxLength       =   5
         TabIndex        =   4
         Top             =   240
         Width           =   1140
      End
      Begin VB.Label Label 
         BackColor       =   &H00C0C0C0&
         Caption         =   "Mercado "
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Index           =   14
         Left            =   120
         TabIndex        =   42
         Top             =   3240
         Width           =   1500
      End
      Begin VB.Label Label 
         BackColor       =   &H00C0C0C0&
         Caption         =   "Nombre SINACOFI"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Index           =   13
         Left            =   4300
         TabIndex        =   41
         Top             =   3150
         Width           =   1720
      End
      Begin VB.Label Label 
         BackColor       =   &H00C0C0C0&
         Caption         =   "Codigo SINACOFI"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Index           =   8
         Left            =   4300
         TabIndex        =   40
         Top             =   2800
         Width           =   1720
      End
      Begin VB.Label Label 
         BackColor       =   &H00C0C0C0&
         Caption         =   "Cta.Corriente U$"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Index           =   7
         Left            =   4300
         TabIndex        =   39
         Top             =   2400
         Width           =   1720
      End
      Begin VB.Label Label 
         BackColor       =   &H00C0C0C0&
         Caption         =   "Tipo Cliente"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Index           =   6
         Left            =   120
         TabIndex        =   36
         Top             =   2800
         Width           =   1500
      End
      Begin VB.Label Label 
         BackColor       =   &H00C0C0C0&
         Caption         =   "Nombre"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Index           =   2
         Left            =   120
         TabIndex        =   35
         Top             =   590
         Width           =   1500
      End
      Begin VB.Label Label 
         BackColor       =   &H00C0C0C0&
         Caption         =   "Dirección"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Index           =   5
         Left            =   120
         TabIndex        =   34
         Top             =   940
         Width           =   1500
      End
      Begin VB.Label Label 
         BackColor       =   &H00C0C0C0&
         Caption         =   "Comuna"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Index           =   10
         Left            =   4300
         TabIndex        =   33
         Top             =   1290
         Width           =   1720
      End
      Begin VB.Label Label 
         BackColor       =   &H00C0C0C0&
         Caption         =   "Ciudad"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Index           =   11
         Left            =   4300
         TabIndex        =   32
         Top             =   1640
         Width           =   1720
      End
      Begin VB.Label Label 
         BackColor       =   &H00C0C0C0&
         Caption         =   "Región"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Index           =   12
         Left            =   120
         TabIndex        =   31
         Top             =   1640
         Width           =   1500
      End
      Begin VB.Label Label 
         BackColor       =   &H00C0C0C0&
         Caption         =   "Fax"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Index           =   16
         Left            =   4320
         TabIndex        =   30
         Top             =   1995
         Width           =   1725
      End
      Begin VB.Label Label 
         BackColor       =   &H00C0C0C0&
         Caption         =   "Telefono"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Index           =   15
         Left            =   120
         TabIndex        =   29
         Top             =   1990
         Width           =   1500
      End
      Begin VB.Label Label 
         BackColor       =   &H00C0C0C0&
         Caption         =   "Cta.Corriente $$"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Index           =   17
         Left            =   120
         TabIndex        =   28
         Top             =   2400
         Width           =   1500
      End
      Begin VB.Label Label 
         BackColor       =   &H00C0C0C0&
         Caption         =   "País"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Index           =   9
         Left            =   120
         TabIndex        =   27
         Top             =   1290
         Width           =   1500
      End
      Begin VB.Label Label 
         BackColor       =   &H00C0C0C0&
         Caption         =   "Generico"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Index           =   3
         Left            =   120
         TabIndex        =   26
         Top             =   240
         Width           =   1500
      End
   End
   Begin Threed.SSFrame Frame 
      Height          =   1215
      Index           =   2
      Left            =   120
      TabIndex        =   37
      Top             =   4920
      Width           =   8535
      _Version        =   65536
      _ExtentX        =   15055
      _ExtentY        =   2143
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
      Begin Threed.SSCommand cmdSalir 
         Height          =   840
         Left            =   7320
         TabIndex        =   22
         Top             =   240
         Width           =   960
         _Version        =   65536
         _ExtentX        =   1693
         _ExtentY        =   1482
         _StockProps     =   78
         Caption         =   "&Salir"
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Font3D          =   1
         Picture         =   "BacMntClientes.frx":030A
      End
      Begin Threed.SSCommand cmdLimpiar 
         Height          =   840
         Left            =   6360
         TabIndex        =   21
         Top             =   240
         Width           =   960
         _Version        =   65536
         _ExtentX        =   1693
         _ExtentY        =   1482
         _StockProps     =   78
         Caption         =   "&Limpiar"
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Font3D          =   1
         Picture         =   "BacMntClientes.frx":0624
      End
      Begin Threed.SSCommand cmdGrabar 
         Height          =   840
         Left            =   4440
         TabIndex        =   19
         Top             =   240
         Width           =   960
         _Version        =   65536
         _ExtentX        =   1693
         _ExtentY        =   1482
         _StockProps     =   78
         Caption         =   "&Grabar"
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Font3D          =   1
         Picture         =   "BacMntClientes.frx":093E
      End
      Begin Threed.SSCommand cmdEliminar 
         Height          =   840
         Left            =   5400
         TabIndex        =   20
         Top             =   240
         Width           =   960
         _Version        =   65536
         _ExtentX        =   1693
         _ExtentY        =   1482
         _StockProps     =   78
         Caption         =   "&Eliminar"
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Font3D          =   1
         Picture         =   "BacMntClientes.frx":0D90
      End
   End
End
Attribute VB_Name = "BacMntClientes"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private objCliente  As New clsCliente
Private objCodigo   As New clsCodigo
Function HabilitarControles(Valor As Boolean)
   
   txtRut.Enabled = Not Valor
   txtDigito.Enabled = Not Valor
   txtNroCliente.Enabled = Not Valor
   txtgeneric.Enabled = Valor
   txtNombre.Enabled = Valor
   TxtFax.Enabled = Valor
   TxtTelefono.Enabled = Valor
   TxtDireccion.Enabled = Valor
   CmbComuna.Enabled = Valor
   CmbCiudad.Enabled = Valor
   CmbRegion.Enabled = Valor
   cmbPais.Enabled = Valor
   cmbTipoCliente.Enabled = Valor
   CmbMercado.Enabled = Valor
   txtctacte.Enabled = Valor
   TxtCtaUSD.Enabled = Valor
   
   cmdGrabar.Enabled = Valor
   cmdEliminar.Enabled = Valor
   cmdLimpiar.Enabled = Valor

End Function

'Limpiar Pantalla
Sub Limpiar()

   txtRut.Text = ""
   txtDigito.Text = ""
   txtgeneric.Text = ""
   TxtDireccion.Text = ""
   TxtFax.Text = ""
   txtNombre.Text = ""
   txtNroCliente.Text = ""
   TxtTelefono.Text = ""
   txtctacte.Text = ""
   TxtCtaUSD.Text = ""
   txtNumSin.Text = ""
   txtNomSin.Text = ""
   cmbTipoCliente.ListIndex = -1
   CmbComuna.ListIndex = -1
   CmbCiudad.ListIndex = -1
   CmbRegion.ListIndex = -1
   cmbPais.ListIndex = -1
   CmbMercado.ListIndex = -1
   
   
End Sub

'Llena los combos despues de hacer un refresh
Sub LlenaCombos()


    '---- Tipos de Clientes
    If Not objCodigo.CargaObjetos(cmbTipoCliente, MDTC_TIPOCLIENTE) Then
        MsgBox "Tipos de Clientes no han sido ingresados en Tablas Generales", vbInformation, Msj
    End If

    '---- Comuna
    If Not objCodigo.CargaObjetos(CmbComuna, MDTC_COMUNAS) Then
        MsgBox "Comunas no han sido ingresados en Tablas Generales", vbInformation, Msj
    End If

    '---- Ciudad
    If Not objCodigo.CargaObjetos(CmbCiudad, MDTC_CIUDAD) Then
        MsgBox "Ciudades no han sido ingresados en Tablas Generales", vbInformation, Msj
    End If

    '---- Region
    If Not objCodigo.CargaObjetos(CmbRegion, MDTC_REGION) Then
        MsgBox "Regiones no han sido ingresados en Tablas Generales", vbInformation, Msj
    End If

    '---- Pais
    If Not objCodigo.CargaObjetos(cmbPais, MDTC_PAIS) Then
        MsgBox "Paises no han sido ingresados en Tablas Generales", vbInformation, Msj
    End If

     If Not objCodigo.CargaObjetos(CmbMercado, MDTC_MERCADO) Then
        MsgBox "Paises no han sido ingresados en Tablas Generales", vbInformation, Msj
    End If

End Sub
Sub Revisa()
   
   txtctacte.Tag = txtctacte.Text
   TxtDireccion.Tag = TxtDireccion.Text
   txtNombre.Tag = txtNombre.Text
   txtgeneric.Tag = txtgeneric.Text
   TxtFax.Tag = TxtFax.Text
   TxtTelefono.Tag = TxtTelefono.Text
   CmbComuna.Tag = CmbComuna.ListIndex
   CmbRegion.Tag = CmbRegion.ListIndex
   cmbTipoCliente.Tag = cmbTipoCliente.ListIndex
   CmbCiudad.Tag = CmbCiudad.ListIndex
   cmbPais.Tag = cmbPais.ListIndex

End Sub

Function ValidarDatos() As Boolean

   ValidarDatos = True
   
   If Trim$(txtNombre) = "" Then
      MsgBox "ERROR : Nombre vacio", 16, gsPARAMS_Version
      txtNombre.SetFocus
      ValidarDatos = False
      Exit Function
   End If
   
   If Trim$(txtgeneric) = "" Then
      MsgBox "ERROR : Codigo Generico  Vacio", 16, gsPARAMS_Version
      txtgeneric.SetFocus
      ValidarDatos = False
      Exit Function
   End If
   
   
    If CmbCiudad.ListCount <= 0 Then
      MsgBox "ERROR : Debe Ingresar Datos a la Tabla Ciudad", 16, gsPARAMS_Version
      CmbCiudad.SetFocus
      ValidarDatos = False
      Exit Function
   End If
   

   If CmbCiudad.ListIndex = -1 And CmbCiudad.ListCount > 0 Then
      MsgBox "ERROR : Debe Selecionar Ciudad", 16, gsPARAMS_Version
      CmbCiudad.SetFocus
      ValidarDatos = False
      Exit Function
   End If
   
   
    If CmbComuna.ListCount <= 0 Then
      MsgBox "ERROR : Debe Ingresar Datos a la Tabla Comuna", 16, gsPARAMS_Version
      CmbComuna.SetFocus
      ValidarDatos = False
      Exit Function
   End If
   
   
   If CmbComuna.ListIndex = -1 And CmbComuna.ListCount > 0 Then
      MsgBox "ERROR : Debe Selecionar Comuna", 16, gsPARAMS_Version
      CmbComuna.SetFocus
      ValidarDatos = False
      Exit Function
   End If
   
   
   If CmbRegion.ListCount <= 0 Then
      MsgBox "ERROR : Debe Ingresar Datos a la Tabla Region", 16, gsPARAMS_Version
      CmbRegion.SetFocus
      ValidarDatos = False
      Exit Function
   End If
   
   If CmbRegion.ListIndex = -1 And CmbRegion.ListCount > 0 Then
      MsgBox "ERROR : Debe Selecionar Region", 16, gsPARAMS_Version
      CmbRegion.SetFocus
      ValidarDatos = False
      Exit Function
   End If
   
   
   If cmbTipoCliente.ListCount <= 0 Then
      MsgBox "ERROR : Debe Ingresar Datos a la Tabla tipo Cliente", 16, gsPARAMS_Version
      cmbTipoCliente.SetFocus
      ValidarDatos = False
      Exit Function
   End If
   
   
   If cmbTipoCliente.ListIndex = -1 And cmbTipoCliente.ListCount > 0 Then
      MsgBox "ERROR : Debe Selecionar tipo Cliente", 16, gsPARAMS_Version
      cmbTipoCliente.SetFocus
      ValidarDatos = False
      Exit Function
   End If
      
      
   If cmbPais.ListCount <= 0 Then
      MsgBox "ERROR : Debe Ingresar Datos a la Tabla Pais", 16, gsPARAMS_Version
      cmbPais.SetFocus
      ValidarDatos = False
      Exit Function
   End If
      
         
   If cmbPais.ListIndex = -1 And cmbPais.ListCount > 0 Then
      MsgBox "ERROR : Debe Ingresar Pais", 16, gsPARAMS_Version
      cmbPais.SetFocus
      ValidarDatos = False
      Exit Function
   End If
   
    If CmbMercado.ListCount <= 0 Then
      MsgBox "ERROR : Debe Ingresar Datos a la Tabla Mercado", 16, gsPARAMS_Version
      CmbMercado.SetFocus
      ValidarDatos = False
      Exit Function
   End If
   
   
   If CmbMercado.ListIndex = -1 And CmbMercado.ListCount > 0 Then
      MsgBox "ERROR : Debe Selecionar Mercado", 16, gsPARAMS_Version
      CmbMercado.SetFocus
      ValidarDatos = False
      Exit Function
   End If
   

End Function

Private Sub CmbCiudad_KeyPress(KeyAscii As Integer)

   If KeyAscii = 13 Then
      CmbRegion.SetFocus

   End If

End Sub

Private Sub cmbComuna_KeyPress(KeyAscii As Integer)

   If KeyAscii = 13 Then
      CmbCiudad.SetFocus

   End If

End Sub

Private Sub cmbPais_KeyPress(KeyAscii As Integer)

If KeyAscii = 13 Then
   CmbComuna.SetFocus

End If

End Sub


Private Sub CmbRegion_KeyPress(KeyAscii As Integer)

   If KeyAscii = 13 Then
      TxtTelefono.SetFocus

   End If

End Sub

Private Sub cmbTipoCliente_KeyPress(KeyAscii As Integer)

   If KeyAscii = 13 Then
      txtNumSin.SetFocus

   End If

End Sub


Private Sub CmdGrabar_Click()
    
    Me.MousePointer = 11
    
    If Not ValidarDatos() Then   'Valdiaci¢n de los datos del cliente.
        Me.MousePointer = 0
        Exit Sub
    End If
    
    objCliente.clrut = txtRut.Text
    objCliente.cldv = txtDigito.Text
    objCliente.clcodigo = txtNroCliente
    objCliente.clnombre = txtNombre.Text
    objCliente.clgenerico = txtgeneric.Text
    objCliente.cldireccion = TxtDireccion
    
    objCliente.clcomuna = CmbComuna.ItemData(CmbComuna.ListIndex)
    objCliente.clciudad = CmbCiudad.ItemData(CmbCiudad.ListIndex)
    objCliente.clregion = CmbRegion.ItemData(CmbRegion.ListIndex)
    objCliente.clPais = cmbPais.ItemData(cmbPais.ListIndex)
    objCliente.clmercado = CmbMercado.ItemData(CmbMercado.ListIndex)
    objCliente.cltipocliente = cmbTipoCliente.ItemData(cmbTipoCliente.ListIndex)
        
    objCliente.clctacte = txtctacte.Text
    objCliente.clctausd = TxtCtaUSD.Text
    objCliente.clfono = TxtTelefono.Text
    objCliente.clfax = TxtFax.Text
    objCliente.clnumsin = txtNumSin.Text
    objCliente.clnomsin = txtNomSin.Text
    
    '----------------------------------------------
    If objCliente.Grabar Then
        Me.MousePointer = 0
        MsgBox "Grabación se realizó con exito ", 64, gsPARAMS_Version
        Call Limpiar
        Call HabilitarControles(False)
        txtRut.SetFocus
    End If

    Me.MousePointer = 0

End Sub
Private Sub CmdLimpiar_Click()
   
   Call Limpiar
   Call LlenaCombos
   Call HabilitarControles(False)
   txtRut.SetFocus

End Sub


Private Sub cmdSalir_Click()

   Unload Me

End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)

   If KeyAscii = 13 Then
      SendKeys "{TAB}"

   End If

End Sub

Private Sub Form_Load()

    Call LlenaCombos
    Call HabilitarControles(False)

End Sub

Private Sub cmdEliminar_Click()

    objCliente.clrut = txtRut.Text
    
    If objCliente.Eliminar(objCliente.clrut, objCliente.clcodigo) Then
        MsgBox "Eliminaciòn se realizó con Exito ", 64, gsPARAMS_Version
        objCliente.Limpiar
        Call Limpiar
        Call HabilitarControles(False)
        txtRut.SetFocus
    End If
    
    
End Sub

Private Sub txtctacte_KeyPress(KeyAscii As Integer)

   BacToUCase KeyAscii

   If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      SendKeys$ "{TAB}"

   End If

End Sub


Private Sub TxtCtaUSD_KeyPress(KeyAscii As Integer)

   BacToUCase KeyAscii

   If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      SendKeys$ "{TAB}"

   End If

End Sub

Private Sub txtDigito_KeyPress(KeyAscii As Integer)

   If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      SendKeys$ "{TAB}"

   ElseIf Not ((KeyAscii > 47 And KeyAscii < 58) Or KeyAscii = 75 Or KeyAscii = 107 Or KeyAscii = 8) Then
      KeyAscii = 0

   End If

   BacToUCase KeyAscii

End Sub


Private Sub txtDigito_LostFocus()

   If Not Controla_RUT(txtRut, txtDigito) Then
      MsgBox "Error : El Rut Esta Incorrecto", 16, gsPARAMS_Version
      'Call Limpiar
      Call HabilitarControles(False)
      txtRut.SetFocus
   Else
      txtNroCliente.SetFocus
   End If

End Sub


Private Sub TxtDireccion_KeyPress(KeyAscii As Integer)
   BacToUCase KeyAscii

   If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      SendKeys$ "{TAB}"

   End If

End Sub


Private Sub txtFax_KeyPress(KeyAscii As Integer)

   BacToUCase KeyAscii

   If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      SendKeys$ "{TAB}"

   End If

End Sub


Private Sub txtgeneric_KeyPress(KeyAscii As Integer)

   BacToUCase KeyAscii

   If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      SendKeys$ "{TAB}"

   End If

End Sub


Private Sub TxtNombre_KeyPress(KeyAscii As Integer)

   BacToUCase KeyAscii

   If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      SendKeys$ "{TAB}"

   End If

End Sub


Private Sub txtNomSin_KeyPress(KeyAscii As Integer)
   
   BacToUCase KeyAscii

   If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      SendKeys$ "{TAB}"

   End If

End Sub

Private Sub txtNroCliente_KeyPress(KeyAscii As Integer)

    BacSoloNumeros KeyAscii
    
    If KeyAscii = 13 Then
        SendKeys "{TAB}"
    
    ElseIf KeyAscii = 27 Then
        cmdSalir.SetFocus
    
    End If

End Sub

Private Sub txtNroCliente_LostFocus()

    objCliente.clrut = Val(txtRut.Text)
    objCliente.cldv = txtDigito.Text
    objCliente.clcodigo = Val(txtNroCliente.Text)
    
    If (objCliente.clcodigo = 0 And objCliente.clrut = 0) Or objCliente.clrut = 0 Then
        txtRut.SetFocus
        Exit Sub
    End If
      
    If objCliente.clcodigo = 0 Then
        If Not objCliente.LeerxRut(objCliente.clrut, 0) Then
            objCliente.clcodigo = -1
        End If
    End If
    
    If objCliente.LeerxRut(objCliente.clrut, objCliente.clcodigo) Then
    'If objCliente.LeerxCodigo(objCliente.clcodigo) Then
    
        txtNroCliente.Text = objCliente.clcodigo
        txtNroCliente.Tag = txtNroCliente.Text
        
        txtctacte.Text = objCliente.clctacte
        txtctacte.Tag = txtctacte.Text
        
        TxtDireccion.Text = objCliente.cldireccion
        TxtDireccion.Tag = TxtDireccion.Text
        
        txtNombre.Text = objCliente.clnombre
        txtNombre.Tag = txtNombre.Text
        
        txtgeneric.Text = objCliente.clgenerico
        txtgeneric.Tag = txtgeneric.Text
        
        TxtFax.Text = objCliente.clfax
        TxtFax.Tag = TxtFax.Text
        
        TxtTelefono.Text = objCliente.clfono
        TxtTelefono.Tag = TxtTelefono.Text
        
        CmbCiudad.ListIndex = bacBuscarCombo(CmbCiudad, Val(objCliente.clciudad))
        CmbCiudad.Tag = CmbCiudad.ListIndex
        
        CmbComuna.ListIndex = bacBuscarCombo(CmbComuna, Val(objCliente.clcomuna))
        CmbComuna.Tag = CmbComuna.ListIndex
        
        CmbRegion.ListIndex = bacBuscarCombo(CmbRegion, Val(objCliente.clregion))
        CmbRegion.Tag = CmbRegion.ListIndex
        
        cmbPais.ListIndex = bacBuscarCombo(cmbPais, Val(objCliente.clPais))
        cmbPais.Tag = cmbPais.ListIndex
             
        cmbTipoCliente.ListIndex = bacBuscarCombo(cmbTipoCliente, Val(objCliente.cltipocliente))
        cmbTipoCliente.Tag = cmbTipoCliente.ListIndex
        
        CmbMercado.ListIndex = bacBuscarCombo(CmbMercado, Val(objCliente.clmercado))
        CmbMercado.Tag = CmbMercado.ListIndex
        
        TxtCtaUSD.Text = objCliente.clctausd
        TxtCtaUSD.Tag = TxtCtaUSD.Text
        
        txtNumSin.Text = objCliente.clnumsin
        txtNumSin.Tag = txtNumSin.Text
         
        txtNomSin.Text = objCliente.clnomsin
        txtNomSin.Tag = txtNomSin.Text
        
        
    Else
        objCliente.clrut = txtRut.Text
        objCliente.cldv = txtDigito.Text
        objCliente.clcodigo = Val(txtNroCliente.Text)
        Call Limpiar
        txtRut.Text = objCliente.clrut
        txtDigito.Text = objCliente.cldv
        txtNroCliente.Text = objCliente.clcodigo
        cmdEliminar.Enabled = False
        
    End If
      
    Call HabilitarControles(True)

    txtNombre.SetFocus

End Sub


Private Sub txtNumSin_KeyPress(KeyAscii As Integer)
   
   BacToUCase KeyAscii

   If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      SendKeys$ "{TAB}"

   End If

End Sub

Private Sub txtRut_DblClick()

    BacControlWindows 100

   ' If Not objCliente.Ayuda("") Then
   '     Exit Sub
   ' End If
    
    BacAyuda.Tag = "MDCL_U"
    BacAyuda.Show 1

    If giAceptar% Then
       txtRut.Text = Val(gsCodigo$)
       txtDigito.Text = gsDigito$
       txtNroCliente.Text = gsCodCli
       txtNroCliente.SetFocus
       SendKeys "{TAB}"
    End If

End Sub


Private Sub txtRut_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyF3 Then Call txtRut_DblClick
End Sub


Private Sub txtRut_KeyPress(KeyAscii As Integer)

   If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      SendKeys$ "{TAB}"

   ElseIf Not ((KeyAscii > 47 And KeyAscii < 58) Or KeyAscii = 8) Then
      KeyAscii = 0
     
   End If
     
   BacCaracterNumerico KeyAscii
   
End Sub

   

Private Sub TxtTelefono_KeyPress(KeyAscii As Integer)

   BacToUCase KeyAscii

   If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      SendKeys$ "{TAB}"

   End If

End Sub

