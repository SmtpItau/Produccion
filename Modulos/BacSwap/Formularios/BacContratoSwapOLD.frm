VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacContratoSwap 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Contratos Swaps"
   ClientHeight    =   6960
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   10845
   Icon            =   "BacContratoSwap.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   Picture         =   "BacContratoSwap.frx":030A
   ScaleHeight     =   6960
   ScaleWidth      =   10845
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   555
      Left            =   0
      TabIndex        =   32
      Top             =   0
      Width           =   10845
      _ExtentX        =   19129
      _ExtentY        =   979
      ButtonWidth     =   847
      ButtonHeight    =   820
      Appearance      =   1
      ImageList       =   "ImageList1"
      DisabledImageList=   "ImageList1"
      HotImageList    =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   9960
      Top             =   5400
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   25
      ImageHeight     =   25
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   2
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacContratoSwap.frx":0614
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacContratoSwap.frx":092E
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.Frame Frame3 
      Height          =   2490
      Left            =   4950
      TabIndex        =   23
      Top             =   4440
      Width           =   4560
      Begin VB.TextBox txtRuta 
         Height          =   600
         Left            =   135
         Locked          =   -1  'True
         MultiLine       =   -1  'True
         ScrollBars      =   1  'Horizontal
         TabIndex        =   26
         Top             =   1755
         Width           =   4290
      End
      Begin VB.DirListBox Directorio 
         Height          =   990
         Left            =   135
         TabIndex        =   25
         Top             =   720
         Width           =   4290
      End
      Begin VB.DriveListBox Drive1 
         Height          =   315
         Left            =   135
         TabIndex        =   24
         Top             =   360
         Width           =   4290
      End
      Begin VB.Label lblEtiqueta 
         AutoSize        =   -1  'True
         Caption         =   "Ruta Contratos"
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
         Index           =   8
         Left            =   135
         TabIndex        =   27
         Top             =   135
         Width           =   1290
      End
   End
   Begin VB.Frame Frame2 
      Caption         =   "Opción"
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
      Height          =   6315
      Left            =   0
      TabIndex        =   12
      Top             =   600
      Width           =   4830
      Begin BACControles.TXTFecha txtFechaOperacion 
         Height          =   330
         Left            =   1620
         TabIndex        =   33
         Top             =   270
         Width           =   1230
         _ExtentX        =   2170
         _ExtentY        =   582
         Enabled         =   -1  'True
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
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "15/06/2001"
      End
      Begin VB.CommandButton OK 
         Caption         =   "o.k."
         Height          =   375
         Left            =   3000
         Picture         =   "BacContratoSwap.frx":0C48
         Style           =   1  'Graphical
         TabIndex        =   15
         Top             =   240
         Width           =   465
      End
      Begin MSFlexGridLib.MSFlexGrid grdLista 
         Height          =   4965
         Left            =   45
         TabIndex        =   14
         ToolTipText     =   "Doble click Acepta"
         Top             =   1260
         Width           =   4740
         _ExtentX        =   8361
         _ExtentY        =   8758
         _Version        =   393216
         FixedCols       =   0
         BackColor       =   12632256
         ForeColor       =   0
         BackColorFixed  =   8421376
         ForeColorFixed  =   16777215
         GridLines       =   2
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Times New Roman"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin VB.Label etqTitulo 
         Alignment       =   2  'Center
         BackColor       =   &H00808000&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   330
         Left            =   45
         TabIndex        =   16
         Top             =   945
         Width           =   4740
      End
      Begin VB.Label lblEtiqueta 
         AutoSize        =   -1  'True
         Caption         =   "Fecha"
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
         Index           =   7
         Left            =   945
         TabIndex        =   13
         Top             =   360
         Width           =   540
      End
   End
   Begin VB.Frame Frame1 
      Height          =   3840
      Index           =   0
      Left            =   4920
      TabIndex        =   0
      Top             =   600
      Width           =   5865
      Begin VB.Frame Frame1 
         Caption         =   "Cliente"
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
         Height          =   1815
         Index           =   2
         Left            =   90
         TabIndex        =   2
         Top             =   1935
         Width           =   5685
         Begin VB.ComboBox cmbRepCliente2 
            ForeColor       =   &H00800000&
            Height          =   315
            Left            =   1260
            Style           =   2  'Dropdown List
            TabIndex        =   31
            Top             =   990
            Width           =   3075
         End
         Begin VB.ComboBox cmbRepCliente1 
            ForeColor       =   &H00800000&
            Height          =   315
            Left            =   1260
            Style           =   2  'Dropdown List
            TabIndex        =   6
            Top             =   630
            Width           =   3075
         End
         Begin VB.Label txtRutRepCli2 
            BackColor       =   &H00FFFFFF&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "Label1"
            ForeColor       =   &H00800000&
            Height          =   330
            Left            =   4410
            TabIndex        =   30
            Top             =   990
            Width           =   1140
         End
         Begin VB.Label txtDirecCli 
            BackColor       =   &H00FFFFFF&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "Label1"
            ForeColor       =   &H00800000&
            Height          =   330
            Left            =   1260
            TabIndex        =   11
            Top             =   1395
            Width           =   4290
         End
         Begin VB.Label txtRutRepCli1 
            BackColor       =   &H00FFFFFF&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "Label1"
            ForeColor       =   &H00800000&
            Height          =   330
            Left            =   4410
            TabIndex        =   10
            Top             =   630
            Width           =   1140
         End
         Begin VB.Label txtRutCli 
            BackColor       =   &H00FFFFFF&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "Label1"
            ForeColor       =   &H00800000&
            Height          =   330
            Left            =   4410
            TabIndex        =   9
            Top             =   225
            Width           =   1140
         End
         Begin VB.Label txtCliente 
            BackColor       =   &H00FFFFFF&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "Label1"
            ForeColor       =   &H00800000&
            Height          =   330
            Left            =   90
            MouseIcon       =   "BacContratoSwap.frx":117A
            TabIndex        =   8
            Top             =   225
            Width           =   4245
         End
         Begin VB.Label lblEtiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Dirección"
            Height          =   195
            Index           =   3
            Left            =   90
            TabIndex        =   7
            Top             =   1440
            Width           =   765
         End
         Begin VB.Label lblEtiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Representante"
            Height          =   195
            Index           =   2
            Left            =   90
            TabIndex        =   5
            Top             =   675
            Width           =   1050
         End
      End
      Begin VB.Frame Frame1 
         Caption         =   "Entidad"
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
         Height          =   1815
         Index           =   1
         Left            =   90
         TabIndex        =   1
         Top             =   135
         Width           =   5685
         Begin VB.ComboBox cmbRepBco2 
            BackColor       =   &H00E0E0E0&
            ForeColor       =   &H00800000&
            Height          =   315
            Left            =   1260
            Style           =   2  'Dropdown List
            TabIndex        =   29
            Top             =   990
            Width           =   3075
         End
         Begin VB.ComboBox cmbRepBco1 
            BackColor       =   &H00E0E0E0&
            ForeColor       =   &H00800000&
            Height          =   315
            Left            =   1260
            Style           =   2  'Dropdown List
            TabIndex        =   17
            Top             =   630
            Width           =   3075
         End
         Begin VB.Label txtRutRepBco2 
            BackColor       =   &H00E0E0E0&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "Label1"
            ForeColor       =   &H00800000&
            Height          =   330
            Left            =   4410
            TabIndex        =   28
            Top             =   990
            Width           =   1140
         End
         Begin VB.Label txtDirecBco 
            BackColor       =   &H00E0E0E0&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "Label1"
            ForeColor       =   &H00800000&
            Height          =   330
            Left            =   1260
            TabIndex        =   20
            Top             =   1395
            Width           =   4290
         End
         Begin VB.Label txtRutRepBco1 
            BackColor       =   &H00E0E0E0&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "Label1"
            ForeColor       =   &H00800000&
            Height          =   330
            Left            =   4410
            TabIndex        =   19
            Top             =   630
            Width           =   1140
         End
         Begin VB.Label txtEntidad 
            BackColor       =   &H00E0E0E0&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "Label1"
            ForeColor       =   &H00800000&
            Height          =   330
            Left            =   90
            MouseIcon       =   "BacContratoSwap.frx":12CC
            TabIndex        =   18
            Top             =   225
            Width           =   5460
         End
         Begin VB.Label lblEtiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Dirección"
            Height          =   195
            Index           =   1
            Left            =   90
            TabIndex        =   4
            Top             =   1395
            Width           =   675
         End
         Begin VB.Label lblEtiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Representante"
            Height          =   195
            Index           =   0
            Left            =   90
            TabIndex        =   3
            Top             =   720
            Width           =   1050
         End
      End
   End
   Begin VB.Label lblNumero 
      Alignment       =   2  'Center
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   11.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00808000&
      Height          =   330
      Left            =   9720
      TabIndex        =   22
      Top             =   4920
      Width           =   915
   End
   Begin VB.Label lblEtiqueta 
      AutoSize        =   -1  'True
      Caption         =   "N° Operación :"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00808000&
      Height          =   195
      Index           =   4
      Left            =   9585
      TabIndex        =   21
      Top             =   4560
      Width           =   1275
   End
End
Attribute VB_Name = "BacContratoSwap"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim DatosContrato(33)
Dim RutCli As Long
Dim Ciudad As String
Dim MercadoCli As Integer
Dim Codigo As Long

Private Sub btnImpresora()

Dim m

    Screen.MousePointer = 11
    If ValidaDatos Then
        If BacContratoSwapTasaBanco(DatosContrato(), lblNumero.Caption, "Pantalla") Then
            'EtqMensaje.Caption = "Informe enviado a Impresora!"
            'BacControlWindows 60000
            'EtqMensaje.Caption = ""
        End If
    End If
    Screen.MousePointer = 0

End Sub
Function ValidaDatos() As Boolean
On Error GoTo Control:

Dim digBco, fechaCont As String
'Dim txtruta As String
Dim TelefCli As String
Dim FaxCli As String
Dim TelefBco As String
Dim FaxBco As String
Dim Sql  As String
Dim digCli As String
Dim Datos()

    ValidaDatos = False
    If txtEntidad = "" Then
        MsgBox "Debe ingresar Nombre del Banco", vbInformation, Msj
        Exit Function
    End If
    If Trim(cmbRepBco1) = "" Then
        MsgBox "Debe seleccionar un Representante del Banco", vbInformation, Msj
        Exit Function
    End If
    If txtRutRepBco1 = "" And Trim(cmbRepBco1) <> "" Then
        MsgBox "Debe ingresar RUT del Representante del Banco", vbInformation, Msj
        Exit Function
    End If
    If txtDirecBco = "" Then
        MsgBox "Debe ingresar dirección del Banco", vbInformation, Msj
        Exit Function
    End If
    If txtCliente = "" Then
        MsgBox "Debe Ingresar nombre del Cliente", vbInformation, Msj
        Exit Function
    End If
    If txtRutCli = "" Then
        MsgBox "Debe Ingresar RUT del Cliente", vbInformation, Msj
        Exit Function
    End If
    If Trim(cmbRepCliente1) = "" Then
        MsgBox "Debe Seleccionar un Representante del Cliente", vbInformation, Msj
        cmbRepCliente1.SetFocus
        Exit Function
    End If
    If txtRutRepCli1 = "" And Trim(cmbRepCliente1) <> "" Then
        MsgBox "Debe Ingresar Rut del Representante del Cliente", vbInformation, Msj
        Exit Function
    End If
    If txtDirecCli = "" Then
        MsgBox "Debe Ingresar Dirección del Cliente", vbInformation, Msj
        Exit Function
    End If
    
    If lblNumero.Caption = 0 Or lblNumero.Caption = "" Then
        MsgBox "Debe seleccionar Operación para imprimir Contrato", vbInformation, Msj
        Exit Function
    End If
    
    'Busca digito verificador rut del banco
      digBco = BacCheckRut(CStr(RutCli))
    
    Dim DatBco As New clsCliente
    

    If DatBco.LeerxRut(txtRutCli.Tag, txtCliente.Tag) Then
        digCli = DatBco.cldv
        TelefBco = DatBco.clfono
        FaxBco = DatBco.clfax
        TelefCli = DatBco.clfono
        FaxCli = DatBco.clfax
        
    Else
    
        digCli = "*"
        TelefBco = ""
        FaxBco = ""
        TelefCli = ""
        FaxCli = ""
    End If
    
    Set DatBco = Nothing
        
    If IsDate(txtDirecCli.Tag) Then
        If Year(txtDirecCli.Tag) < 1960 Then
            fechaCont = txtFechaOperacion.Text
        Else
            fechaCont = txtDirecCli.Tag
        End If
    Else
        fechaCont = txtFechaOperacion.Text
    End If

    DatosContrato(1) = UCase(txtEntidad)
    DatosContrato(2) = BacFormatoRut(RutCli & "-" & digBco)
    DatosContrato(3) = UCase(Trim(Left(cmbRepBco1, 30)))
    DatosContrato(4) = BacFormatoRut(txtRutRepBco1)
    DatosContrato(5) = txtDirecBco
    DatosContrato(6) = UCase(txtCliente)
    DatosContrato(7) = BacFormatoRut(txtRutCli)
    DatosContrato(8) = UCase(Trim(Left(cmbRepCliente1, Len(cmbRepCliente1) - 15)))
    DatosContrato(9) = BacFormatoRut(txtRutRepCli1)
    DatosContrato(10) = txtDirecCli
    DatosContrato(11) = fechaCont
    DatosContrato(12) = Day(txtFechaOperacion.Text)
    DatosContrato(13) = BacMesStr(Month(txtFechaOperacion.Text))
    DatosContrato(14) = Year(txtFechaOperacion.Text)
    DatosContrato(15) = TelefBco
    DatosContrato(16) = FaxBco
    DatosContrato(17) = TelefCli
    DatosContrato(18) = FaxCli
    DatosContrato(19) = txtCliente.Tag
    DatosContrato(20) = IIf(UCase(txtRuta) = UCase("c:\"), "c:", txtRuta)
    
    If DatosContrato(20) = "" Then
        DatosContrato(20) = "c:"
    End If
    
    DatosContrato(21) = UCase(Trim(Left(cmbRepBco2, 30)))
    DatosContrato(22) = BacFormatoRut(txtRutRepBco2)
    DatosContrato(23) = UCase(Trim(Left(cmbRepCliente2, Len(cmbRepCliente2) - 15)))
    DatosContrato(24) = BacFormatoRut(txtRutRepCli2)
    DatosContrato(26) = BacFormatoRut(txtRutRepCli2)
    DatosContrato(31) = Day(fechaCont)
    DatosContrato(32) = BacMesStr(Month(fechaCont))
    DatosContrato(33) = Year(fechaCont)
            
    ValidaDatos = True
    
Exit Function
    
Control:
        
        Resume Next
    
End Function

Private Sub btnImpresora_Click()

End Sub


Private Sub btnSalir_Click()

    Unload Me

End Sub

Private Sub cmbRepBco1_Click()
    
    'If cmbRepBco1.ListIndex <> -1 Then
    '    txtRutRepBco1 = Trim(Right(cmbRepBco1, 15))
    'End If
    
    If cmbRepBco1.ListIndex <> -1 Then
        txtRutRepBco1 = ""
        txtRutRepBco1 = cmbRepBco1.ItemData(cmbRepBco1.ListIndex)
        txtRutRepBco1 = txtRutRepBco1 & "-" & Trim(Right(cmbRepBco1.List(cmbRepBco1.ListIndex), 10))

   End If

    
End Sub


Private Sub cmbRepBco2_Click()
    
  If cmbRepBco2.ListIndex <> -1 Then
        txtRutRepBco2 = ""
        txtRutRepBco2 = cmbRepBco2.ItemData(cmbRepBco2.ListIndex)
        txtRutRepBco2 = txtRutRepBco2 & "-" & Trim(Right(cmbRepBco2.List(cmbRepBco2.ListIndex), 10))

   End If
    
  '  If cmbRepBco2.ListIndex <> -1 Then
  '      txtRutRepBco2 = Trim(Right(cmbRepBco2, 15))
  '  End If
End Sub

Private Sub cmbRepCliente1_Click()

    If cmbRepCliente1.ListIndex <> -1 Then
        txtRutRepCli1 = ""
        txtRutRepCli1 = cmbRepCliente1.ItemData(cmbRepCliente1.ListIndex)
        txtRutRepCli1 = txtRutRepCli1 & "-" & Trim(Right(cmbRepCliente1.List(cmbRepCliente1.ListIndex), 10))
   End If

    'If cmbRepCliente1.ListIndex <> -1 Then
    '    txtRutRepCli1 = Trim(Right(cmbRepCliente1, 13))
    'End If

End Sub

Private Sub cmbRepCliente2_Click()
    
    
     If cmbRepCliente2.ListIndex <> -1 Then
        txtRutRepCli2 = ""
        txtRutRepCli2 = cmbRepCliente2.ItemData(cmbRepCliente2.ListIndex)
        txtRutRepCli2 = txtRutRepCli2 & "-" & Trim(Right(cmbRepCliente2.List(cmbRepCliente2.ListIndex), 10))
   End If

    
    
'    If cmbRepCliente2.ListIndex <> -1 Then
 '       txtRutRepCli2 = Trim(Right(cmbRepCliente2, 13))
  '  End If

End Sub

Private Sub Directorio_Change()

    txtRuta = Directorio.Path

End Sub

Private Sub Drive1_Change()
    
    Screen.MousePointer = 0
    On Error GoTo Error
    Directorio.Path = Drive1.Drive
    Drive1.Refresh

Exit Sub

Error:
MsgBox Error(Err), vbExclamation
Directorio.Path = "c:\"
Drive1.Refresh

End Sub

Private Sub Form_Activate()
    
    If BacContratoSwap.Tag = "Empresa" Then
        BacContratoSwap.Caption = "Contratos con Empresas"
        MercadoCli = 1     ' SECUNDARIO
    Else
        BacContratoSwap.Caption = "Contratos Interbancarios"
        MercadoCli = 0     'PRIMARIO
    End If
    
End Sub

Private Sub Form_Load()
 
 On Error GoTo ErrorRuta
 
    Directorio.Path = gsBac_Path_Contratos
    Drive1.Drive = Directorio.Path
    Directorio.Path = gsBac_Path_Contratos
    Drive1.Refresh
    Call carga
   Exit Sub
ErrorRuta:
    MsgBox Err.Description, vbCritical, TITSISTEMA
    Directorio.Path = "c:\"
    Drive1.Drive = Directorio.Path
    Drive1.Refresh
    Call carga
    
   
End Sub
Private Sub carga()
    Limpia True, True
    Call InicializaGrilla
    Call CargaDatosEntidad
    txtFechaOperacion.MaxDate = gsBAC_Fecp
    txtFechaOperacion.Text = gsBAC_Fecp
    
    lblNumero = 0
    etqTitulo.Caption = "Operaciones"
    

End Sub

Function InicializaGrilla()

Dim i As Integer

    With grdLista
        .Cols = 11
        .Rows = 18
        
        .RowHeight(0) = 500
        .TextMatrix(0, 0) = "N° Oper."
        .TextMatrix(0, 1) = "Tip.Operación"
        .TextMatrix(0, 2) = "Cliente"
        
        .ColWidth(0) = 900
        .ColWidth(1) = 1200
        .ColWidth(2) = 2300
        .ColWidth(3) = 0
        .ColWidth(4) = 0
        .ColWidth(5) = 0
        .ColWidth(6) = 0
        .ColWidth(7) = 0
        .ColWidth(8) = 0
        .ColWidth(9) = 0
        .Row = 0
        
        For i = 0 To .Cols - 1
            .Col = i
            .CellAlignment = 4
        Next
               
    End With

End Function

Function CargaDatosEntidad()

Dim i As Integer
    Dim tot As Integer
    Dim Datos()
    Dim Sql As String
    
   Sql = ""
   Sql = "EXECUTE sp_leerdatosgenerales "
            
    If MISQL.SQL_Execute(Sql) <> 0 Then
        MsgBox "¡No se encuentran datos Principales de la Entidad!", vbCritical, Msj
        Exit Function

    End If

    If MISQL.SQL_Fetch(Datos()) = 0 Then
               
        txtEntidad = Datos(3)
        txtDirecBco = Datos(5)
        RutCli = Val(Datos(4))
        Ciudad = Datos(7)
        Codigo = Datos(22)
        txtEntidad.Tag = Datos(22)
        
    End If
    
    '---- Carga de Apoderados
    Dim DatosClientes As New clsCliente
    
    With DatosClientes
    
    If Not .CargaApoderados(cmbRepBco1, RutCli, Codigo) Then
        cmbRepBco1.AddItem Space(10)
        cmbRepBco1.ItemData(cmbRepBco1.NewIndex) = 0
    End If
      cmbRepBco1.AddItem Space(10)
      cmbRepBco1.ItemData(cmbRepBco1.NewIndex) = 0
      cmbRepBco1.ListIndex = 0
    
    If Not .CargaApoderados(cmbRepBco2, RutCli, Codigo) Then
        cmbRepBco2.AddItem Space(10)
        cmbRepBco2.ItemData(cmbRepBco1.NewIndex) = 0
    End If
      cmbRepBco2.AddItem Space(10)
      cmbRepBco2.ItemData(cmbRepBco1.NewIndex) = 0
      cmbRepBco2.ListIndex = 0
    
    Set DatosClientes = Nothing

   End With
       
Exit Function
    

End Function
Function BuscaRepresentantes(RutCli)
    Dim i As Integer
    Dim tot As Integer
    Dim DatosClientes As New clsCliente
    
    cmbRepCliente1.Clear
    cmbRepCliente2.Clear
        
    With DatosClientes
'    If .LeerApoderadosCliente(RutCli) Then
'        tot = .coleccion.Count
'        'cmbRepCliente1.AddItem "        "
'
'        For i = 1 To tot
'            cmbRepCliente1.AddItem .coleccion(i).clnombre & Space(50) & Format(.coleccion(i).clrut, "###,###,##0") & "-" & .coleccion(i).cldv
'            cmbRepCliente2.AddItem .coleccion(i).clnombre & Space(50) & Format(.coleccion(i).clrut, "###,###,##0") & "-" & .coleccion(i).cldv
'        Next
'        If tot = 2 Then
'            cmbRepCliente1.ListIndex = 0
'
'        End If
'
'    Else
'        Set DatosClientes = Nothing
'        btnImpresora.Enabled = False
'        MsgBox "Cliente no tiene Representantes ingresados", vbCritical, Msj
'
'    End If
    
    End With
    
    Set DatosClientes = Nothing

End Function

Function Limpia(LpBco As Boolean, LpCli As Boolean)
    
    If LpBco Then
        txtEntidad = ""
        txtRutRepBco1 = ""
        cmbRepBco1.Clear
        cmbRepBco2.Clear
        txtDirecBco = ""
    End If
    If LpCli Then
        txtRutRepCli1 = ""
        txtRutRepCli2 = ""
        txtDirecCli = ""
        txtCliente = ""
        txtRutCli = ""
        cmbRepCliente1.Clear
        cmbRepCliente2.Clear
        
    End If
    
End Function



Private Sub grdLista_DblClick()

    With grdLista
    If .TextMatrix(.Row, 0) <> "" Then
        lblNumero = .TextMatrix(.Row, 0)
        DatosContrato(25) = .TextMatrix(.Row, 7)
        DatosContrato(27) = .TextMatrix(.Row, 7)  'Fecha de Inicio
        DatosContrato(28) = .TextMatrix(.Row, 8)  'Fecha de Termino
        DatosContrato(29) = .TextMatrix(.Row, 9)  'Moneda Operacion
        DatosContrato(30) = .TextMatrix(.Row, 10)  'Monto Operacion
        
        Call DatosCli
    Else
         lblNumero = 0
         DatosContrato(25) = ""
        DatosContrato(27) = ""
        DatosContrato(28) = ""
        DatosContrato(29) = 0
        DatosContrato(30) = 0
         Limpia False, True
    End If
    End With
    
End Sub

Private Sub OK_Click()

lblNumero = 0
If CDate(txtFechaOperacion.Text) = CDate(gsBAC_Fecp) Then
    'Mostrara datos del movimiento diario
    Call Buscar(1)

Else
    'Mostrara datos del movimiento historico
    Call Buscar(2)
    
End If

End Sub
Function Buscar(Tabla)

Dim Filas   As Long
Dim Max     As Long
Dim m, j As Long
Dim NumPaso As Double
Dim Sql  As String
Dim Datos()


    grdLista.Cols = 13
    grdLista.Rows = 18
    Call BacLimpiaGrilla(grdLista)
    
    grdLista.Tag = Tabla
    
    Select Case Tabla
    Case 1
        etqTitulo.Caption = "Operaciones del Día"
        
    Case 2
        etqTitulo.Caption = "Operaciones Días Anteriores"
           
    End Select
    
    'consulta
    Sql = ""

   If MercadoCli = 0 Then  'iNST FINANCIERAS
      Sql = "EXECUTE sp_consultasfiltrocontrato " & Tabla & ", 'S' , 'N'"
   Else  'EMPRESAS
      Sql = "EXECUTE sp_consultasfiltrocontrato " & Tabla & ", 'N' , 'S'"
   End If

    If MISQL.SQL_Execute(Sql) > 0 Then
        Exit Function
    End If

    
   NumPaso = 0
   Filas = 1
  Do While MISQL.SQL_Fetch(Datos()) = 0
        If NumPaso <> Val((Datos(2))) Then
            grdLista.TextMatrix(Filas, 0) = Val(Datos(2))
            grdLista.TextMatrix(Filas, 1) = Datos(1)
            grdLista.TextMatrix(Filas, 2) = Datos(4)
            grdLista.TextMatrix(Filas, 3) = Datos(6)
            grdLista.TextMatrix(Filas, 4) = Datos(3)   ' Codigo Cliente
            grdLista.TextMatrix(Filas, 5) = Trim(Left(Datos(16), Len(Datos(16)) - 2)) & Right(Datos(16), 2)
            grdLista.TextMatrix(Filas, 6) = Trim(Left(Datos(16), Len(Datos(16)) - 2))
            grdLista.TextMatrix(Filas, 7) = Datos(7)
            grdLista.TextMatrix(Filas, 8) = Datos(8)
            grdLista.TextMatrix(Filas, 9) = Val(Datos(9))                                                           'Moneda Operacion
            grdLista.TextMatrix(Filas, 10) = BacStrTran((Datos(11)), ".", gsc_PuntoDecim)        'Monto Operacion
            grdLista.TextMatrix(Filas, 11) = Datos(18)
            grdLista.TextMatrix(Filas, 12) = Datos(19)      'Fecha Cond Gral
              If Filas > 13 Then
                      grdLista.Rows = grdLista.Rows + 1
              End If
              
            NumPaso = Val(Datos(2))
            Filas = Filas + 1
        End If
   Loop
   
End Function


Function DatosCli()

Dim carac As String
Dim Cliente As New clsCliente
Dim codcli As Long

    With Cliente
    
    txtRutCli = grdLista.TextMatrix(grdLista.Row, 5)
    txtCliente = grdLista.TextMatrix(grdLista.Row, 2)
    codcli = Trim(grdLista.TextMatrix(grdLista.Row, 4))
    txtCliente.Tag = codcli
    txtRutCli.Tag = Trim(grdLista.TextMatrix(grdLista.Row, 6))
    txtDirecCli = grdLista.TextMatrix(grdLista.Row, 11)
    txtDirecCli.Tag = grdLista.TextMatrix(grdLista.Row, 12)
    txtRutRepCli1 = ""
    txtRutRepCli2 = ""
    
   If Not .CargaApoderados(cmbRepCliente1, txtRutCli.Tag, codcli) Then
        cmbRepCliente1.AddItem Space(10)
        cmbRepCliente1.ItemData(cmbRepCliente1.NewIndex) = 0
    End If
    cmbRepCliente1.AddItem "  "

    cmbRepCliente1.ListIndex = 0
    
    If Not .CargaApoderados(cmbRepCliente2, txtRutCli.Tag, codcli) Then
        cmbRepCliente2.AddItem Space(10)
        cmbRepCliente2.ItemData(0) = 0
    End If
    cmbRepCliente2.AddItem "  "
    cmbRepCliente2.ListIndex = 0
   
    End With
    Set Cliente = Nothing
    
End Function

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

Select Case Button.Index

    Case 1
        Call btnImpresora
    Case 2
        Unload Me
End Select

End Sub

Private Sub txtFechaOperacion_LostFocus()
    
    If CDate(txtFechaOperacion.Text) > CDate(gsBAC_Fecp) Then
        MsgBox "Fecha no puede ser mayor a fecha de proceso!", vbInformation, Msj
        txtFechaOperacion.Text = gsBAC_Fecp
        txtFechaOperacion.SetFocus
        Exit Sub
    End If
End Sub

