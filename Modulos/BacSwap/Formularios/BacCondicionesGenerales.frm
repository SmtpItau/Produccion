VERSION 5.00
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "comctl32.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.1#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacCondicionesGenerales 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Condiciones Generales"
   ClientHeight    =   7905
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   6390
   Icon            =   "BacCondicionesGenerales.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   7905
   ScaleWidth      =   6390
   Visible         =   0   'False
   Begin Threed.SSPanel Pnl_Seleccion 
      Height          =   7230
      Left            =   5400
      TabIndex        =   33
      Top             =   6840
      Visible         =   0   'False
      Width           =   6375
      _Version        =   65536
      _ExtentX        =   11245
      _ExtentY        =   12753
      _StockProps     =   15
      BackColor       =   14215660
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BevelOuter      =   1
      BevelInner      =   1
      Begin VB.Frame Fr_Avales 
         Caption         =   "Cantidad de Avales a Incluir"
         Height          =   840
         Left            =   1350
         TabIndex        =   43
         Top             =   4095
         Width           =   2325
         Begin VB.ComboBox Cmb_CantidadAvales 
            Height          =   315
            Left            =   645
            Sorted          =   -1  'True
            Style           =   2  'Dropdown List
            TabIndex        =   44
            Top             =   315
            Width           =   870
         End
      End
      Begin VB.CheckBox Chk_Preliminar 
         Caption         =   "Preliminar"
         Height          =   255
         Left            =   135
         TabIndex        =   42
         Top             =   4095
         Value           =   1  'Checked
         Width           =   1080
      End
      Begin VB.Frame Fr_Seleccion 
         Caption         =   "Seleccion de contratos y clausulas"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   3870
         Left            =   120
         TabIndex        =   36
         Top             =   150
         Width           =   6150
         Begin MSComctlLib.TreeView Trw_Seleccion 
            Height          =   3570
            Left            =   90
            TabIndex        =   37
            Top             =   210
            Width           =   5970
            _ExtentX        =   10530
            _ExtentY        =   6297
            _Version        =   393217
            LabelEdit       =   1
            LineStyle       =   1
            Style           =   7
            Checkboxes      =   -1  'True
            Appearance      =   1
         End
      End
      Begin VB.CommandButton Cmd_Cancelar 
         Caption         =   "Cancelar"
         Height          =   360
         Left            =   5235
         TabIndex        =   35
         Top             =   4590
         Width           =   1035
      End
      Begin VB.CommandButton Cmd_Continuar 
         Caption         =   "Continuar"
         Height          =   360
         Left            =   4125
         TabIndex        =   34
         Top             =   4590
         Width           =   1035
      End
   End
   Begin VB.Frame Frame2 
      Height          =   2580
      Left            =   15
      TabIndex        =   25
      Top             =   5280
      Width           =   6345
      Begin VB.TextBox txtRuta 
         Height          =   600
         Left            =   630
         Locked          =   -1  'True
         MultiLine       =   -1  'True
         ScrollBars      =   1  'Horizontal
         TabIndex        =   28
         Text            =   "BacCondicionesGenerales.frx":030A
         Top             =   1845
         Width           =   4875
      End
      Begin VB.DirListBox Directorio 
         Height          =   990
         Left            =   630
         TabIndex        =   27
         Top             =   810
         Width           =   4875
      End
      Begin VB.DriveListBox Drive1 
         Height          =   315
         Left            =   630
         TabIndex        =   26
         Top             =   450
         Width           =   4875
      End
      Begin VB.Label lblEtiqueta 
         AutoSize        =   -1  'True
         Caption         =   "Ruta Condiciones Generales"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   225
         Index           =   7
         Left            =   360
         TabIndex        =   29
         Top             =   225
         Width           =   2250
      End
   End
   Begin VB.Frame Frame1 
      Height          =   4740
      Index           =   0
      Left            =   15
      TabIndex        =   0
      Top             =   540
      Width           =   6345
      Begin VB.Frame Frame1 
         Caption         =   "Nombre"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   2265
         Index           =   2
         Left            =   210
         TabIndex        =   9
         Top             =   2340
         Width           =   5730
         Begin BACControles.TXTFecha TXTFecha 
            Height          =   255
            Left            =   2160
            TabIndex        =   30
            Top             =   1920
            Width           =   1335
            _ExtentX        =   2355
            _ExtentY        =   450
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
            Text            =   "06-12-2007"
         End
         Begin VB.ComboBox cmbRepCliente2 
            ForeColor       =   &H00800000&
            Height          =   315
            Left            =   1305
            Style           =   2  'Dropdown List
            TabIndex        =   22
            Top             =   1080
            Width           =   3075
         End
         Begin VB.ComboBox cmbRepCliente1 
            ForeColor       =   &H00800000&
            Height          =   315
            Left            =   1305
            Style           =   2  'Dropdown List
            TabIndex        =   10
            Top             =   720
            Width           =   3075
         End
         Begin VB.Label txtRutRepCli2 
            BackColor       =   &H00FFFFFF&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "Label1"
            ForeColor       =   &H00800000&
            Height          =   330
            Left            =   4455
            TabIndex        =   23
            Top             =   1080
            Width           =   1140
         End
         Begin VB.Label lblEtiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Representantes"
            Height          =   195
            Index           =   2
            Left            =   135
            TabIndex        =   17
            Top             =   765
            Width           =   1125
         End
         Begin VB.Label lblEtiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Dirección"
            Height          =   195
            Index           =   3
            Left            =   135
            TabIndex        =   16
            Top             =   1530
            Width           =   675
         End
         Begin VB.Label lblEtiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Fecha Condición General"
            Height          =   195
            Index           =   4
            Left            =   135
            TabIndex        =   15
            Top             =   1980
            Width           =   1800
         End
         Begin VB.Label txtCliente 
            BackColor       =   &H00FFFFFF&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "Label1"
            ForeColor       =   &H00800000&
            Height          =   330
            Left            =   105
            MouseIcon       =   "BacCondicionesGenerales.frx":0310
            MousePointer    =   99  'Custom
            TabIndex        =   14
            Top             =   270
            Width           =   4245
         End
         Begin VB.Label txtRutCli 
            BackColor       =   &H00FFFFFF&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "Label1"
            ForeColor       =   &H00800000&
            Height          =   330
            Left            =   4455
            TabIndex        =   13
            Top             =   270
            Width           =   1140
         End
         Begin VB.Label txtRutRepCli1 
            BackColor       =   &H00FFFFFF&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "Label1"
            ForeColor       =   &H00800000&
            Height          =   330
            Left            =   4455
            TabIndex        =   12
            Top             =   720
            Width           =   1140
         End
         Begin VB.Label txtDirecCli 
            BackColor       =   &H00FFFFFF&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "Label1"
            ForeColor       =   &H00800000&
            Height          =   330
            Left            =   1305
            TabIndex        =   11
            Top             =   1485
            Width           =   4290
         End
      End
      Begin VB.Frame Frame1 
         Caption         =   "Entidad"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   1815
         Index           =   1
         Left            =   135
         TabIndex        =   1
         Top             =   135
         Width           =   5910
         Begin VB.TextBox txtRutRepBco2 
            BackColor       =   &H00E0E0E0&
            ForeColor       =   &H00800000&
            Height          =   330
            Left            =   4455
            TabIndex        =   21
            Text            =   "Text1"
            Top             =   990
            Width           =   1140
         End
         Begin VB.ComboBox cmbRepBco2 
            ForeColor       =   &H00800000&
            Height          =   315
            Left            =   1305
            Style           =   2  'Dropdown List
            TabIndex        =   20
            Top             =   990
            Width           =   3075
         End
         Begin VB.ComboBox cmbRepBco1 
            ForeColor       =   &H00800000&
            Height          =   315
            Left            =   1305
            Style           =   2  'Dropdown List
            TabIndex        =   19
            Top             =   630
            Width           =   3075
         End
         Begin VB.TextBox txtDirecBco 
            BackColor       =   &H00E0E0E0&
            ForeColor       =   &H00800000&
            Height          =   330
            Left            =   1305
            TabIndex        =   7
            Text            =   "Text1"
            Top             =   1395
            Width           =   4290
         End
         Begin VB.TextBox txtRutRepBco1 
            BackColor       =   &H00E0E0E0&
            ForeColor       =   &H00800000&
            Height          =   330
            Left            =   4455
            TabIndex        =   5
            Text            =   "Text1"
            Top             =   630
            Width           =   1140
         End
         Begin VB.TextBox txtRepBco1 
            BackColor       =   &H00E0E0E0&
            ForeColor       =   &H00800000&
            Height          =   330
            Left            =   5400
            TabIndex        =   4
            Text            =   "Text1"
            Top             =   180
            Visible         =   0   'False
            Width           =   3075
         End
         Begin VB.TextBox txtEntidad 
            BackColor       =   &H00E0E0E0&
            ForeColor       =   &H00800000&
            Height          =   330
            Left            =   135
            TabIndex        =   2
            Text            =   "Text1"
            Top             =   225
            Width           =   5460
         End
         Begin VB.Label lblEtiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Dirección"
            Height          =   195
            Index           =   1
            Left            =   135
            TabIndex        =   6
            Top             =   1440
            Width           =   675
         End
         Begin VB.Label lblEtiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Representantes"
            Height          =   195
            Index           =   0
            Left            =   135
            TabIndex        =   3
            Top             =   720
            Width           =   1125
         End
      End
      Begin ComctlLib.TabStrip TabCliente 
         Height          =   2625
         Left            =   120
         TabIndex        =   18
         Top             =   2055
         Width           =   5910
         _ExtentX        =   10425
         _ExtentY        =   4630
         _Version        =   327682
         BeginProperty Tabs {0713E432-850A-101B-AFC0-4210102A8DA7} 
            NumTabs         =   2
            BeginProperty Tab1 {0713F341-850A-101B-AFC0-4210102A8DA7} 
               Caption         =   "Interbancarios"
               Key             =   ""
               Object.Tag             =   ""
               ImageVarType    =   2
            EndProperty
            BeginProperty Tab2 {0713F341-850A-101B-AFC0-4210102A8DA7} 
               Caption         =   "Empresas"
               Key             =   ""
               Object.Tag             =   ""
               ImageVarType    =   2
            EndProperty
         EndProperty
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin VB.Label lblEscrituraApo2 
         Height          =   255
         Left            =   4800
         TabIndex        =   32
         Top             =   2040
         Visible         =   0   'False
         Width           =   1335
      End
      Begin VB.Label lblEscrituraApo1 
         Height          =   255
         Left            =   2880
         TabIndex        =   31
         Top             =   2040
         Visible         =   0   'False
         Width           =   1815
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   24
      Top             =   0
      Width           =   6390
      _ExtentX        =   11271
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Description     =   "Imprimir"
            Object.ToolTipText     =   "Informe por pantalla"
            ImageIndex      =   2
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   1
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
            EndProperty
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Description     =   "Imprimir"
            Object.ToolTipText     =   "Imprimir Informe"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Description     =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   5715
      Top             =   6480
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
            Picture         =   "BacCondicionesGenerales.frx":0462
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacCondicionesGenerales.frx":077E
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacCondicionesGenerales.frx":0BD2
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.Label Lbl_CiudadCli 
      BorderStyle     =   1  'Fixed Single
      Caption         =   "Lbl_CiudadCli"
      Height          =   345
      Left            =   6735
      TabIndex        =   41
      Top             =   4395
      Width           =   2385
   End
   Begin VB.Label Lbl_ComunaCli 
      BorderStyle     =   1  'Fixed Single
      Caption         =   "Lbl_ComunaCli"
      Height          =   345
      Left            =   6735
      TabIndex        =   40
      Top             =   4755
      Width           =   2385
   End
   Begin VB.Label Lbl_CiudadBco 
      BorderStyle     =   1  'Fixed Single
      Caption         =   "Lbl_CiudadBco"
      Height          =   345
      Left            =   6690
      TabIndex        =   39
      Top             =   1785
      Width           =   2385
   End
   Begin VB.Label Lbl_ComunaBco 
      BorderStyle     =   1  'Fixed Single
      Caption         =   "Lbl_CoumnaBco"
      Height          =   345
      Left            =   6690
      TabIndex        =   38
      Top             =   2145
      Width           =   2385
   End
   Begin VB.Label LblImp 
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   11.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   690
      Left            =   135
      TabIndex        =   8
      Top             =   6885
      Width           =   2040
   End
End
Attribute VB_Name = "BacCondicionesGenerales"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim DatosContrato(26)

Dim RutCli           As Long
Dim Ciudad           As String
Dim Codigo           As Long
Dim bNuevoCcg        As Boolean
Dim cFechaAntiguoCcg As String
Dim cFechaNuevoCcg   As String


Private Sub carga()
   Call LimpiaEntidad
   Call LimpiaCliente
   Call CargaDatosEntidad
   
   TabCliente.Tabs(1).Selected = True
   txtRuta = Directorio.Path

   Frame1(0).Enabled = True
   Frame2.Enabled = True
   Pnl_Seleccion.Top = 22500
   Pnl_Seleccion.Left = 1950
   Pnl_Seleccion.Visible = False
   Pnl_Seleccion.Enabled = False
End Sub

Function ValidaDatos() As Boolean
Dim digBco As String
Dim TelefCli As String
Dim FaxCli As String
Dim TelefBco As String
Dim FaxBco As String
Dim Nomcli1 As String
Dim rutcli1 As String

   ValidaDatos = False
   
   If txtEntidad = "" Then
      MsgBox "Debe ingresar Nombre del Banco", vbInformation, Msj
      Exit Function
   End If
   
   If cmbRepBco1.ListIndex = -1 Then
      MsgBox "Debe ingresar Nombre del Representante del Banco", vbInformation, Msj
      Exit Function
   End If
   
   If txtRutRepBco1 = "" Then
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
   
   If cmbRepCliente1.ListIndex = -1 Then
     MsgBox "Debe Seleccionar Representante del Cliente", vbInformation, Msj
     cmbRepCliente1.SetFocus
     Exit Function
   End If
   
   If txtRutRepCli1 = "" Then
     MsgBox "Debe Ingresar Rut del Representante del Cliente", vbInformation, Msj
     Exit Function
   End If
   If txtDirecCli = "" Then
      MsgBox "Debe Ingresar Dirección del Cliente", vbInformation, Msj
      Exit Function
   End If

   TelefBco = gsc_Parametros.telefono
   FaxBco = gsc_Parametros.fax

   digBco = BacCheckRut(CStr(gsc_Parametros.Rut))
   Dim DatBco As New clsCliente
   
   If DatBco.LeerxRut(txtRutCli.Tag, txtCliente.Tag) Then
      TelefCli = DatBco.clfono
      FaxCli = DatBco.clfax
   Else
      TelefCli = ""
      FaxCli = ""
   End If
  
   If bNuevoCcg = False Then
      If txtFecha.Text > gsBAC_Fecp Then
         Call MsgBox("La fecha condiciones generales no puede ser mayor a la de proceso", vbExclamation, App.Title)
         txtFecha.Text = gsBAC_Fecp
         Exit Function
      End If
   Else
      If cFechaNuevoCcg <> "01/01/1900" And cFechaNuevoCcg <> "01-01-1900" Then
         MsgBox "El contrato de condiciones generales ya fue firmado por el cliente con fecha : " & cFechaNuevoCcg, vbExclamation + vbOKOnly
         Exit Function
      End If
   End If
    
   Set DatBco = Nothing
   DatosContrato(1) = txtEntidad
   DatosContrato(2) = BacFormatoRut(RutCli & "-" & digBco)
   DatosContrato(25) = RutCli
   DatosContrato(26) = Val(txtCliente.Tag)
   DatosContrato(3) = Trim(Left(cmbRepBco1, Len(cmbRepBco1) - 15))
   DatosContrato(4) = BacFormatoRut(txtRutRepBco1)
   DatosContrato(5) = txtDirecBco
   DatosContrato(6) = txtCliente
   DatosContrato(7) = (txtRutCli)
   DatosContrato(8) = Trim(Left(cmbRepCliente1, Len(cmbRepCliente1) - 15))
   DatosContrato(9) = BacFormatoRut(txtRutRepCli1)
   DatosContrato(10) = txtDirecCli
   DatosContrato(11) = txtFecha.Text
   DatosContrato(12) = Day(txtFecha.Text)
   DatosContrato(13) = BacMesStr(Month(txtFecha.Text))
   DatosContrato(14) = Year(txtFecha.Text)
   DatosContrato(15) = TelefBco
   DatosContrato(16) = FaxBco
   DatosContrato(17) = TelefCli
   DatosContrato(18) = FaxCli
   DatosContrato(19) = txtCliente.Tag
   DatosContrato(20) = IIf(UCase(txtRuta) = UCase("c:\"), "c:", txtRuta)
   
   If Len(Trim(cmbRepBco2)) > 0 Then
      DatosContrato(21) = Trim(Left(cmbRepBco2, Len(cmbRepBco2) - 15))
      DatosContrato(22) = BacFormatoRut(txtRutRepBco2)
   Else
      DatosContrato(21) = ""
      DatosContrato(22) = 0
   End If
   If cmbRepCliente2 <> "" Then
      Nomcli1 = Trim(Left(cmbRepCliente2, Len(cmbRepCliente2) - 15))
   Else
      Nomcli1 = " "
   End If
   
   DatosContrato(23) = Nomcli1
   DatosContrato(24) = BacFormatoRut(txtRutRepCli2)

   ValidaDatos = True
End Function

Private Sub Imprimir(cDonde As String)

   Dim nRutCli          As Long
   Dim nCodCli          As Integer
   Dim nRutRepBco1      As Long
   Dim nRutRepBco2      As Long
   Dim nRutRepCli1      As Long
   Dim nRutRepCli2      As Long
   Dim cContratoNuevo   As String
   Dim nContador        As Integer
   Dim bAbilitaAvales   As Boolean
   
   If ValidaDatos Then
   
      nRutCli = CLng(Str(Replace(Replace(Mid(txtRutCli.Caption, 1, Len(txtRutCli) - 2), ".", ""), ",", "")))
      nCodCli = txtCliente.Tag
      
      nRutRepBco1 = Mid(Trim(BacCondicionesGenerales.txtRutRepBco1.Text), 1, Len(Trim(BacCondicionesGenerales.txtRutRepBco1.Text)) - 2)
      nRutRepBco2 = Mid(Trim(BacCondicionesGenerales.txtRutRepBco2.Text), 1, Len(Trim(BacCondicionesGenerales.txtRutRepBco2.Text)) - 2)
      nRutRepCli1 = Mid(Trim(BacCondicionesGenerales.txtRutRepCli1.Caption), 1, Len(Trim(BacCondicionesGenerales.txtRutRepCli1.Caption)) - 2)
      nRutRepCli2 = Mid(Trim(BacCondicionesGenerales.txtRutRepCli2.Caption), 1, Len(Trim(BacCondicionesGenerales.txtRutRepCli2.Caption)) - 2)

      cContratoNuevo = Func_Revisa_Tipo_Contrato_Nuevo(nRutCli, nCodCli)
            
      If cContratoNuevo = "SI" Then
      
         Envia = Array()
         AddParam Envia, nRutCli
         AddParam Envia, nCodCli
         AddParam Envia, 0
         
         If Not Bac_Sql_Execute("SP_CON_CONTRATO_IMPRESO", Envia) Then
            Screen.MousePointer = vbDefault
            MsgBox "Ha ocurrido un error al intenter validar si el contrato ya fue emitido", vbCritical + vbOKOnly
            Exit Sub
         End If
                   
         If Bac_SQL_Fetch(Datos()) Then
            'el solo hecho de entrar aqui significa que existe un contrato emitido
            Screen.MousePointer = vbDefault
            MsgBox "Contrato del cliente " & vbCrLf & vbCrLf & "Rut :" & txtRutCli.Caption & vbCrLf & "Codigo : " & Str(nCodCli) & vbCrLf & vbCrLf & " Ya se encuentra emitido", vbExclamation + vbOKOnly
            Exit Sub
         End If
      
         Frame1(0).Enabled = False
         Frame2.Enabled = False
         bAbilitaAvales = False
         
         If Not Func_Genera_Arbol_Nuevo_Contrato(cConceptoCG, 0, nRutCli, nCodCli, nRutRepBco1, nRutRepBco2, nRutRepCli1, nRutRepCli2, Trw_Seleccion, Cmb_CantidadAvales, bAbilitaAvales) Then
            Pnl_Seleccion.Top = 22500
            Pnl_Seleccion.Left = 1950
            Pnl_Seleccion.Visible = False
            Pnl_Seleccion.Enabled = False
            
            Frame1(0).Enabled = True
            Frame2.Enabled = True
         Else
            If Cmb_CantidadAvales.ListCount > 0 Then
               Fr_Avales.Enabled = bAbilitaAvales
               Cmb_CantidadAvales.Enabled = bAbilitaAvales
            Else
               Fr_Avales.Enabled = False
               Cmb_CantidadAvales.Enabled = False
            End If
            
            Chk_Preliminar.Value = 1 'chequeado
            Pnl_Seleccion.Top = 615
            Pnl_Seleccion.Left = 0
            Pnl_Seleccion.Visible = True
            Pnl_Seleccion.Enabled = True
         End If
            
      ElseIf cContratoNuevo = "NO" Then
         Frame1(0).Enabled = True
         Frame2.Enabled = True
         Pnl_Seleccion.Top = 22500
         Pnl_Seleccion.Left = 1950
         Pnl_Seleccion.Visible = False
         Pnl_Seleccion.Enabled = False
   
         Screen.MousePointer = vbHourglass
               
      If TabCliente.Tabs(1).Selected = True Then
            Call BacDOCCondicionesGenerales(DatosContrato(), cDonde)
      Else
            Call BacDOCCondicionesGeneralesNoBanco(DatosContrato(), cDonde)
         End If
      
         Screen.MousePointer = vbDefault
         
      ElseIf cContratoNuevo = "NO" Then
         Screen.MousePointer = vbDefault
         MsgBox "Parametros de contratos para derivados no han sido definidos", vbExclamation + vbOKOnly
         Exit Sub
      End If
   End If
End Sub

Private Sub cmbRepBco1_Click()
   Dim Datos As New clsCliente
   
   If cmbRepBco1.ListIndex <> -1 Then
      txtRutRepBco1 = ""
      txtRutRepBco1 = cmbRepBco1.ItemData(cmbRepBco1.ListIndex)
      txtRutRepBco1 = txtRutRepBco1 & "-" & Trim(Right(cmbRepBco1.List(cmbRepBco1.ListIndex), 10))
      lblEscrituraApo1.Caption = vFechasEscrituras(cmbRepBco1.ListIndex)
   End If
End Sub


Private Sub cmbRepBco2_Click()
   Dim Datos As New clsCliente
    
   If cmbRepBco2.ListIndex <> -1 Then
      txtRutRepBco2 = ""
      txtRutRepBco2 = cmbRepBco2.ItemData(cmbRepBco2.ListIndex)
      txtRutRepBco2 = txtRutRepBco2 & "-" & Trim(Right(cmbRepBco2.List(cmbRepBco2.ListIndex), 10))
      lblEscrituraApo2.Caption = vFechasEscrituras(cmbRepBco2.ListIndex)
   End If
End Sub

Private Sub cmbRepCliente1_Click()
   If cmbRepCliente1.ListIndex <> -1 Then
      txtRutRepCli1 = ""
      txtRutRepCli1 = cmbRepCliente1.ItemData(cmbRepCliente1.ListIndex)
      txtRutRepCli1 = txtRutRepCli1 & "-" & Trim(Right(cmbRepCliente1.List(cmbRepCliente1.ListIndex), 10))
   End If
End Sub

Private Sub cmbRepCliente2_Click()
   If cmbRepCliente2.ListIndex <> -1 Then
      txtRutRepCli2 = ""
      txtRutRepCli2 = cmbRepCliente2.ItemData(cmbRepCliente2.ListIndex)
      txtRutRepCli2 = txtRutRepCli2 & "-" & Trim(Right(cmbRepCliente2.List(cmbRepCliente2.ListIndex), 10))
   End If
End Sub

Private Sub Cmd_cancelar_Click()

   Frame1(0).Enabled = True
   Frame2.Enabled = True
   
   Pnl_Seleccion.Top = 22500
   Pnl_Seleccion.Left = 1950
   Pnl_Seleccion.Visible = False
   Pnl_Seleccion.Enabled = False
   
End Sub

Private Sub Cmd_Continuar_Click()

   Dim ClienteOp        As Long
   Dim ClienteCod       As Integer
   Dim cContratoNuevo   As String
   Dim nContador        As Integer
   Dim ncontador2       As Integer
   Dim bPreliminar      As Boolean
   Dim Cliente          As New clsCliente
   
   Screen.MousePointer = vbHourglass
   
   Erase ArregloDatosBasicos
   
   ArregloDatosBasicos(ColsDatosBasicos.ApoderadoBco1) = Trim(Mid(cmbRepBco1.Text, 1, 60))
   ArregloDatosBasicos(ColsDatosBasicos.RutApoderadoBco1) = Trim(txtRutRepBco1.Text)
   ArregloDatosBasicos(ColsDatosBasicos.ApoderadoBco2) = Trim(Mid(cmbRepBco2.Text, 1, 60))
   ArregloDatosBasicos(ColsDatosBasicos.RutApoderadoBco2) = Trim(txtRutRepBco2.Text)
   ArregloDatosBasicos(ColsDatosBasicos.NombreCli) = Trim(txtCliente.Caption)
   ArregloDatosBasicos(ColsDatosBasicos.RutCli) = CLng(Str(Replace(Replace(Mid(txtRutCli.Caption, 1, Len(txtRutCli) - 2), ".", ""), ",", "")))
   ArregloDatosBasicos(ColsDatosBasicos.ApoderadoCli1) = Trim(Mid(cmbRepCliente1.Text, 1, 60))
   ArregloDatosBasicos(ColsDatosBasicos.RutApoderadoCli1) = Trim(txtRutRepCli1.Caption)
   ArregloDatosBasicos(ColsDatosBasicos.ApoderadoCli2) = Trim(Mid(cmbRepCliente2.Text, 1, 60))
   ArregloDatosBasicos(ColsDatosBasicos.RutApoderadoCli2) = Trim(txtRutRepCli2.Caption)
   ArregloDatosBasicos(ColsDatosBasicos.DireccionCli) = Trim(txtDirecCli.Caption)
   ArregloDatosBasicos(ColsDatosBasicos.ComunaCli) = Trim(Lbl_ComunaCli.Caption)
   ArregloDatosBasicos(ColsDatosBasicos.CiudadCli) = Trim(Lbl_CiudadCli.Caption)
      
   ClienteOp = CLng(Str(Replace(Replace(Mid(txtRutCli.Caption, 1, Len(txtRutCli) - 2), ".", ""), ",", "")))
   ClienteCod = txtCliente.Tag
   
   Call Cliente.LeerxRut(ClienteOp, CLng(ClienteCod))
   
   ArregloDatosBasicos(ColsDatosBasicos.FechaEscritura) = Cliente.clfecha_escritura   '.clfecha_escritura
   ArregloDatosBasicos(ColsDatosBasicos.NotariaCli) = Cliente.clnotaria               '.clnotaria
   ArregloDatosBasicos(ColsDatosBasicos.FonoCli) = Cliente.clfono                     '.clfono
   ArregloDatosBasicos(ColsDatosBasicos.FaxCli) = Cliente.clfax                       '.clfax
   
   ArregloDatosBasicos(ColsDatosBasicos.TipoCli) = Cliente.cltipocliente
   ArregloDatosBasicos(ColsDatosBasicos.FechaAntiguoCcg) = Cliente.clfecha_cond_generales
   ArregloDatosBasicos(ColsDatosBasicos.FechaNuevoCcg) = Cliente.clFechaNuevoCgg
   
   Set Cliente = Nothing
 
   ncontador2 = 0
      
   With Trw_Seleccion
      For nContador = 1 To Trw_Seleccion.Nodes.Count
         If .Nodes.Item(nContador).Checked = True Then
            ncontador2 = ncontador2 + 1
            ReDim Preserve MatrizSeleccionados(5, ncontador2)
            
            MatrizSeleccionados(1, ncontador2) = ClienteOp                                       ' RUT CLIENTE
            MatrizSeleccionados(2, ncontador2) = ClienteCod                                      ' CODIGO CLIENTE
            MatrizSeleccionados(3, ncontador2) = "PCS"                                           ' CODIGO SISTEMA
            MatrizSeleccionados(4, ncontador2) = Trim(Mid(.Nodes.Item(nContador).Key, 11, 10))   ' CODIGO DCTO PRINCIPAL
            MatrizSeleccionados(5, ncontador2) = Trim(Mid(.Nodes.Item(nContador).Key, 21, 10))   ' CODIGO DCTO
         End If
      Next nContador
   End With
   
   If ncontador2 = 0 Then
      Screen.MousePointer = vbDefault
      MsgBox "No ha seleccionado contrato alguno, por favor seleccione algun contrato para imprimir", vbExclamation + vbOKOnly
      Exit Sub
   End If
   
   bPreliminar = IIf(Chk_Preliminar.Value = 1, True, False)
   nCuentaAvales = Val(Cmb_CantidadAvales.Text)
     
   If Not Func_Genera_Contrato_Dinamico(ClienteOp, ClienteCod, 0, DatosContrato(), "", cConceptoCG, bPreliminar, Trw_Seleccion) Then
      Exit Sub
   End If
   
   Screen.MousePointer = vbDefault

   Frame1(0).Enabled = True
   Frame2.Enabled = True
   
   Pnl_Seleccion.Top = 22500
   Pnl_Seleccion.Left = 1950
   Pnl_Seleccion.Visible = False
   Pnl_Seleccion.Enabled = False

End Sub

Private Sub Directorio_Change()
   txtRuta = Directorio.Path
End Sub

Private Sub Drive1_Change()
   On Error GoTo Error
   
   Screen.MousePointer = 0
   Directorio.Path = Drive1.Drive
   Drive1.Refresh

Exit Sub
Error:
   MsgBox Error(err), vbExclamation
   Directorio.Path = "c:\"
   Drive1.Refresh
End Sub

Private Sub Form_Load()
   On Error GoTo ErrorRuta
      
   Me.Top = 0
   Me.Left = 0
   
   Directorio.Path = gsBac_Path_Contratos
   Drive1.Drive = Directorio.Path
   Directorio.Path = gsBac_Path_Contratos
   Drive1.Refresh
   
   Call carga
   
   txtFecha.Text = gsBAC_Fecp

Exit Sub
ErrorRuta:
   MsgBox err.Description, vbCritical, TITSISTEMA
   Directorio.Path = "c:\"
   Drive1.Drive = Directorio.Path
   Drive1.Refresh
    
   Call carga
End Sub

Function CargaDatosEntidad()
   Dim i As Integer
   Dim tot As Integer
   Dim Datos()
   Dim SQL As String

   If Not Bac_Sql_Execute("SP_LEERDATOSGENERALES") Then
      MsgBox "¡No se encuentran datos Principales de la Entidad!", vbCritical, Msj
      Exit Function
   End If
   If Bac_SQL_Fetch(Datos()) Then
      txtEntidad = Datos(3)
      txtDirecBco = Datos(5)
      RutCli = Val(Datos(4))
      Ciudad = Datos(7)
      Codigo = Datos(22)
      Lbl_CiudadBco.Caption = Datos(7)
      Lbl_ComunaBco.Caption = Datos(6)

      txtEntidad.Tag = Datos(22)
   End If
    
   '---- Carga de Apoderados
   Dim DatosClientes As New clsCliente
    
   With DatosClientes
      If Not .CargaApoderados(cmbRepBco1, RutCli, Codigo) Then
         cmbRepBco1.AddItem Space(10)
         cmbRepBco1.ItemData(cmbRepBco1.NewIndex) = 0
      End If
      'cmbRepBco1.AddItem Space(10)
      'cmbRepBco1.ListIndex = 0
      If Not .CargaApoderados(cmbRepBco2, RutCli, Codigo) Then
         cmbRepBco2.AddItem Space(10)
         cmbRepBco2.ItemData(cmbRepBco1.NewIndex) = 0
      End If
      'cmbRepBco2.AddItem Space(10)
      'cmbRepBco2.ListIndex = 0
      Set DatosClientes = Nothing
   End With

End Function

Function BuscaRepresentantes(RutCli)
   Dim i As Integer
   Dim tot As Integer
   Dim rr As String
   Dim DatosClientes As New clsCliente
    
   cmbRepCliente1.Clear
   cmbRepCliente2.Clear
   
   With DatosClientes
      If Not .CargaApoderados(cmbRepCliente1, Val(RutCli), Codigo) Then
         cmbRepBco1.AddItem Space(10)
         cmbRepBco1.ItemData(cmbRepBco1.NewIndex) = 0
      End If
      If cmbRepCliente1.ListCount > 0 Then
         ''''cmbRepBco1.ListIndex = 0
         cmbRepCliente1.ListIndex = 0
      End If
      
      If Not .CargaApoderados(cmbRepCliente2, Val(RutCli), Codigo) Then
         cmbRepBco2.AddItem Space(10)
         cmbRepBco2.ItemData(cmbRepBco1.NewIndex) = 0
      End If
      
      If cmbRepCliente2.ListCount > 0 Then
         ''''cmbRepBco2.ListIndex = 0
         cmbRepCliente2.ListIndex = 0
      End If
   End With
   Set DatosClientes = Nothing
End Function

Function LimpiaEntidad()
   txtEntidad = ""
   txtRepBco1 = ""
   cmbRepBco1.ListIndex = -1
   cmbRepBco2.ListIndex = -1
   txtRutRepBco1 = ""
   txtRutRepBco2 = ""
   txtRutRepCli1 = ""
   txtDirecBco = ""
End Function

Function LimpiaCliente()
   txtDirecCli = ""
   txtCliente = ""
   txtRutCli = ""
   cmbRepCliente1.ListIndex = -1
   cmbRepCliente2.ListIndex = -1
   txtRutRepCli2 = ""
   txtRutRepCli1 = ""
   txtCliente.Tag = 0
   txtRutCli.Tag = 0
   txtEntidad.Tag = 0
End Function

Private Sub TabCliente_Click()
   If TabCliente.Tabs(1).Selected = True Then
      If TabCliente.Tag <> "1" Then
         TabCliente.Tag = "1"    'Instituciones Financieras
         Call LimpiaCliente
      End If
   Else
      If TabCliente.Tag <> "7" Then
         TabCliente.Tag = "7"    'Empresas
         Call LimpiaCliente
      End If
   End If
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 1
         Call Imprimir("Pantalla")
      Case 2
         Call Imprimir("Impresora")
      Case 3
         Unload Me
   End Select
End Sub

Private Sub Trw_Seleccion_NodeCheck(ByVal Node As MSComctlLib.Node)

   Dim nContador     As Integer
   Dim bEstado       As Boolean
   Dim ncontador2    As Integer
   Dim nContador3    As Integer
  
   With Trw_Seleccion
      If Node.Checked = False Then
         If Node.Children > 0 Then
            For nContador = Node.Index To (Node.Index + Node.Children)
               .Nodes.Item(nContador).Checked = False
            Next nContador
         End If
      Else
         If Not Node.Parent Is Nothing Then
            .Nodes.Item(Node.Parent.Index).Checked = True
         End If
      End If
   End With
   
   bEstado = False

   With Trw_Seleccion
      For ncontador2 = 1 To .Nodes.Count
         If Trim(Mid(.Nodes(ncontador2).Key, 1, 10)) = "DINAMICO" Then
            If Node.Index <> ncontador2 Then
               For nContador3 = 1 To UBound(MatrizClausulas, 2)
                  If Trim(Mid(.Nodes(ncontador2).Key, 11, 10)) = MatrizClausulas(1, nContador3) _
                     And Trim(Mid(.Nodes(ncontador2).Key, 21, 10)) = MatrizClausulas(2, nContador3) _
                     And .Nodes(ncontador2).Checked = True And ncontador2 <> Node.Index And MatrizClausulas(4, nContador3) = "S" Then
                     bEstado = True
                     Exit For
                  End If
               Next nContador3
            End If
         End If
         
         If bEstado = True Then
            Exit For
         End If
      Next ncontador2
   End With
   
   If bEstado = False Then
      For ncontador2 = 1 To UBound(MatrizClausulas, 2)
         If Trim(Mid(Node.Key, 11, 10)) = MatrizClausulas(1, ncontador2) _
              And Trim(Mid(Node.Key, 21, 10)) = MatrizClausulas(2, ncontador2) _
              And Node.Checked = True And MatrizClausulas(4, ncontador2) = "S" Then
            bEstado = True
            Exit For
         End If
      Next ncontador2
   End If
   
   If bEstado = True Then
      If Cmb_CantidadAvales.ListCount > 0 Then
         Cmb_CantidadAvales.Enabled = True
         Fr_Avales.Enabled = True
      End If
   Else
      Cmb_CantidadAvales.Enabled = False
      Fr_Avales.Enabled = False
   End If

End Sub


Private Sub txtCliente_DblClick()
   Dim carac As String
   Dim AyudaCli As New clsCliente
   Dim codcli As Long

   With AyudaCli
      If .leeClientePorTipo("", TabCliente.Tag) Then
           If TabCliente.Tag = 1 Then
         BacAyudaSwap.Tag = "Cliente"
         BacAyudaSwap.Show 1
      Else
            BacAyudaCliente.Tag = "Cliente"
            BacAyudaCliente.Show
           End If
      Else
         Set AyudaCli = Nothing
         MsgBox "No Existen Datos para ayuda solicitada", vbExclamation, Msj
         Exit Sub
      End If
    
      If gsCodigo = "" Then
         Exit Sub
      End If

      txtRutCli.Tag = gsCodigo
      txtRutCli = Format(gsCodigo, "###,###,###") & "-" & gsDigito
      txtRutCli = BacStrTran(txtRutCli, ",", ".")
      txtCliente = gsNombre
      txtCliente.Tag = gsCodCli
  
      If .LeerxRut(CDbl(gsCodigo), CDbl(gsCodCli)) Then
         txtDirecCli = .cldireccion
         Lbl_CiudadCli.Caption = .clciudadglosa
         Lbl_ComunaCli.Caption = .clcomunaglosa
       
         gsfecha_escritura = .clfecha_escritura
         gsnotaria = .clnotaria
         gsFono = .clfono
         gsFax = .clfax
         Lbl_CiudadCli.Caption = .clciudadglosa
         Lbl_ComunaCli.Caption = .clcomunaglosa
         bNuevoCcg = .clUtilizaNuevoCgg
         cFechaAntiguoCcg = .clfecha_cond_generales
         cFechaNuevoCcg = .clFechaNuevoCgg
                  
         If bNuevoCcg = False Then
            If Year(.clfecha_cond_generales) = 1900 Then
               txtFecha.Text = gsBAC_Fecp
            Else
               txtFecha.Text = .clfecha_cond_generales ' txtFecha.Text = .clfec
            End If
            txtFecha.Enabled = True
         Else
            txtFecha.Enabled = False
            txtFecha.Text = .clfecha_cond_generales ' txtFecha.Text = .clfec
         End If
         
      Else
         txtDirecCli = "***"
      End If
      
      AyudaCli.Limpiar
      txtRutRepCli1 = ""
      cmbRepCliente1.ListIndex = -1
      
      Call BuscaRepresentantes(gsCodigo)
   End With
   
   Set AyudaCli = Nothing
End Sub
