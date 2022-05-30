VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacInterfaces 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   " Generador de Interfaz"
   ClientHeight    =   4245
   ClientLeft      =   3090
   ClientTop       =   2595
   ClientWidth     =   5160
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4245
   ScaleWidth      =   5160
   ShowInTaskbar   =   0   'False
   Begin Threed.SSPanel PnlPrg 
      Align           =   2  'Align Bottom
      Height          =   300
      Left            =   0
      TabIndex        =   7
      Top             =   3945
      Width           =   5160
      _Version        =   65536
      _ExtentX        =   9102
      _ExtentY        =   529
      _StockProps     =   15
      Caption         =   "SSPanel1"
      BackColor       =   13160660
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BorderWidth     =   2
      BevelInner      =   1
      FloodType       =   1
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   3180
      Top             =   1005
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
            Picture         =   "Bacinterfaces.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacinterfaces.frx":0454
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   5
      Top             =   0
      Width           =   5160
      _ExtentX        =   9102
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Aceptar"
            Description     =   "Aceptar"
            Object.ToolTipText     =   "Aceptar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Description     =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin VB.DriveListBox Drive1 
      Height          =   315
      Left            =   105
      TabIndex        =   3
      Top             =   1575
      Width           =   4950
   End
   Begin Threed.SSFrame SSFrame3 
      Height          =   765
      Left            =   0
      TabIndex        =   0
      Top             =   510
      Width           =   5160
      _Version        =   65536
      _ExtentX        =   9102
      _ExtentY        =   1349
      _StockProps     =   14
      Caption         =   "Fecha"
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   3
      Begin BACControles.TXTFecha TxtFecha 
         Height          =   324
         Left            =   108
         TabIndex        =   4
         Top             =   300
         Width           =   1224
         _ExtentX        =   2170
         _ExtentY        =   582
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "25/10/2000"
      End
      Begin BACControles.TXTFecha txtfechahasta 
         Height          =   330
         Left            =   2280
         TabIndex        =   6
         Top             =   300
         Width           =   1230
         _ExtentX        =   2170
         _ExtentY        =   582
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "25/10/2000"
      End
   End
   Begin Threed.SSFrame SSFrame1 
      Height          =   2700
      Left            =   0
      TabIndex        =   1
      Top             =   1230
      Width           =   5160
      _Version        =   65536
      _ExtentX        =   9102
      _ExtentY        =   4762
      _StockProps     =   14
      Caption         =   "Destino"
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   3
      Begin VB.DirListBox Dir1 
         Height          =   1890
         Left            =   105
         TabIndex        =   2
         Top             =   675
         Width           =   4950
      End
   End
End
Attribute VB_Name = "BacInterfaces"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public Interfaz As String

Private Sub Btnimprimir()
   Dim cFecbus As String
   Dim cruta As String
   
   cFecbus = Format(txtFecha.Text, FEFecha)
   cruta = BacRuta(Dir1.Path)
   
''''   If BacInterfaces.Tag = "Interfaz Contable MN" Then                'Interfaz  Moneda Nacional
''''      Call BacInterfazContable(cruta, 1)
''''   ElseIf BacInterfaces.Tag = "Interfaz Contable MX" Then            'Interfaz Moneda Extranjera
''''      Call BacInterfazContable(cruta, 0)
''''    Se comenta, ya que interfaz se esta generando automáticamente al realizar la contabilidad
   If BacInterfaces.Tag = "Interfaz xFil" Then                   'Interfaz xFil o SAR
      Call BacInterfazxFil(cruta)
   ElseIf BacInterfaces.Tag = "Interfaz xFlu" Then                   'Interfaz xFil o SAR
      Call InterfazVencimientos_xFlu(cruta)
   ElseIf BacInterfaces.Interfaz = "Interfaz Operaciones" Then       'Interfaz operaciones
      Call InterfazOperaciones(cruta)
   ElseIf BacInterfaces.Interfaz = "Interfaz balance" Then           'Interfaz xbalance
      Call InterfazBalance(cruta)
   ElseIf BacInterfaces.Interfaz = "Interfaz Flujos" Then            'Interfaz flujos
      Call InterfazFlujos(cruta)
   ElseIf BacInterfaces.Interfaz = "Interfaz derivados" Then         'Interfaz derivados
      Call InterfazDerivados(cruta)
   ElseIf BacInterfaces.Interfaz = "Interfaz direcciones" Then       'Interfaz direcciones
      Call InterfazDirecciones(cruta)
   ElseIf BacInterfaces.Interfaz = "Interfaz Posicion" Then          'Interfaz posicion
      Call InterfazPosicion(cruta)
   'PRD-12713
   ElseIf BacInterfaces.Interfaz = "Interfaz Capítulo IX Anexo 3" Then   'Interfaz Capitulo IX Anexo 3
      Call InterfazCapIXAnexo3(FRM_CAPIX_ANEXO3.nMonths, FRM_CAPIX_ANEXO3.nYears, cruta)  'FRM_CAPIX_ANEXO3.
   ElseIf BacInterfaces.Interfaz = "Interfaz Capítulo IX Anexo 3 Cartera Vigente" Then   'Interfaz Capitulo IX Anexo 3 Cartera Vigente
      Call InterfazCapIXAnexo3Cartera_Vigente(FRM_FILTRA_FECHA.FechaIntCapIXA3, cruta)  'FRM_FILTRA_FECHA.
   'PRD-12713
   End If
   Unload Me
End Sub

Private Sub Drive1_Change()
   On Error GoTo Herror
   Dir1.Path = Drive1
   Exit Sub
Herror:
   MsgBox "Error: " & err.Number & " Descripción: " & err.Description, vbCritical, "Interfaz"
   Drive1 = "c:\"
   Dir1.Path = "c:\"
   Exit Sub
End Sub

Private Sub Form_Activate()
   Dim dUltDMesAnt  As String
   Dim dFirstDay    As String

   txtFecha.Text = Format$(gsBAC_Fecp, gsc_FechaDMA)
   TXTFechaHasta.Text = Format$(gsBAC_Fecp, gsc_FechaDMA)
   
   BacInterfaces.PnlPrg.Visible = False
   If BacInterfaces.Tag = "Interfaz Contable MN" Then       'Interfaz  Moneda Nacional
      txtFecha.Enabled = False
      TXTFechaHasta.Enabled = False
      BacInterfaces.PnlPrg.Visible = True
   ElseIf BacInterfaces.Tag = "Interfaz Contable MX" Then 'Interfaz Moneda Extranjera
      txtFecha.Enabled = False
      TXTFechaHasta.Enabled = False
      BacInterfaces.PnlPrg.Visible = True
   Else
      txtFecha.Enabled = False
      TXTFechaHasta.Enabled = False
      BacInterfaces.PnlPrg.Visible = False
   End If
   Call GRABA_LOG_AUDITORIA("Opc_60160", "07", "INGRESO A OPCION MENU", "", "", "")
End Sub

Private Sub Form_Load()
   On Error GoTo ErrorRutaAcceso
   Me.Top = 0: Me.Left = 0
   Me.Icon = BACSwap.Icon
   
   If Dir(gsBac_Path_Interfaces, vbDirectory) = "" Then
      Dir1.Path = Drive1
      gsBac_Path_Interfaces = Drive1
   ElseIf Interfaz = "Interfaz Posicion" Or Interfaz = "Interfaz Operaciones" Or Interfaz = "Interfaz Flujos" Or Interfaz = "Interfaz direcciones" Or Interfaz = "Interfaz derivados" Or Interfaz = "Interfaz balance" Then
      Drive1.Drive = gsBac_DIRIBS
      Dir1.Path = gsBac_DIRIBS
   Else
      Drive1.Drive = gsBac_Path_Interfaces
      Dir1.Path = gsBac_Path_Interfaces
   End If
   On Error GoTo 0
Exit Sub
ErrorRutaAcceso:
   If err.Number = 52 Then
      MsgBox "Acceso Denegado. " & vbCrLf & vbCrLf & gsBac_Path_Interfaces & vbCrLf & "No es una ruta de acceso valido o bién no tiene los privilegios suficientes para acceder. " & vbCrLf & "Comuniquese con su Administrador", vbExclamation, TITSISTEMA
      gsBac_Path_Interfaces = "C:\"
      Dir1.Path = "C:\"
      gsBac_DIRIBS = "C:\"
      On Error GoTo 0
      Exit Sub
   End If
   MsgBox err.Description, vbExclamation, TITSISTEMA
   On Error GoTo 0
End Sub


Private Sub Form_Unload(Cancel As Integer)
   Call GRABA_LOG_AUDITORIA("Opc_60160", "08", "SALIDA OPCION MENU", "", "", "")
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 1      '"Aceptar"
         Call Btnimprimir
      Case 2      '"Salir"
         Unload Me
   End Select
End Sub

Private Sub txtFecha_Change()
   If txtFecha.Text = "" Then
      txtFecha.Text = Format$(gsBAC_Fecp, gsc_FechaDMA)
      TXTFechaHasta.Text = Format$(gsBAC_Fecp, gsc_FechaDMA)
   End If
End Sub
