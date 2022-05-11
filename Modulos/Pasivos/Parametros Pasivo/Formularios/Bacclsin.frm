VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "threed32.ocx"
Begin VB.Form BacMntClientesSinacofi 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Mantención de Clientes SINACOFI"
   ClientHeight    =   4155
   ClientLeft      =   2835
   ClientTop       =   2895
   ClientWidth     =   6030
   Icon            =   "Bacclsin.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4155
   ScaleWidth      =   6030
   ShowInTaskbar   =   0   'False
   Begin Threed.SSPanel SSPanel1 
      Height          =   3705
      Left            =   -90
      TabIndex        =   10
      Top             =   480
      Width           =   6120
      _Version        =   65536
      _ExtentX        =   10795
      _ExtentY        =   6535
      _StockProps     =   15
      BackColor       =   -2147483644
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin Threed.SSFrame Frame 
         Height          =   3750
         Index           =   0
         Left            =   60
         TabIndex        =   12
         Top             =   -120
         Width           =   5985
         _Version        =   65536
         _ExtentX        =   10557
         _ExtentY        =   6615
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
         Font3D          =   3
         Begin VB.TextBox txtDigito 
            Enabled         =   0   'False
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
            Left            =   2820
            MaxLength       =   1
            TabIndex        =   1
            Top             =   240
            Width           =   300
         End
         Begin VB.TextBox TxtNombre 
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
            Left            =   1545
            MaxLength       =   40
            TabIndex        =   3
            Top             =   570
            Width           =   4290
         End
         Begin VB.TextBox txtCodigo 
            Alignment       =   1  'Right Justify
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
            Left            =   4695
            MaxLength       =   5
            MouseIcon       =   "Bacclsin.frx":2EFA
            MousePointer    =   99  'Custom
            MultiLine       =   -1  'True
            TabIndex        =   2
            Top             =   240
            Width           =   1140
         End
         Begin VB.TextBox txtRut 
            Alignment       =   1  'Right Justify
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
            Left            =   1545
            MaxLength       =   9
            MouseIcon       =   "Bacclsin.frx":3204
            MousePointer    =   99  'Custom
            MultiLine       =   -1  'True
            TabIndex        =   0
            Top             =   240
            Width           =   1140
         End
         Begin Threed.SSFrame SSFrame1 
            Height          =   2550
            Left            =   75
            TabIndex        =   13
            Top             =   990
            Width           =   5850
            _Version        =   65536
            _ExtentX        =   10319
            _ExtentY        =   4498
            _StockProps     =   14
            Caption         =   "Según SINACOFI ..."
            ForeColor       =   -2147483641
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Font3D          =   3
            ShadowStyle     =   1
            Begin VB.TextBox Txt_Cliente_Sinacofi 
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
               Left            =   1695
               MaxLength       =   30
               TabIndex        =   9
               Top             =   2100
               Width           =   4065
            End
            Begin VB.TextBox txtSinacofi 
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
               Left            =   1695
               MaxLength       =   10
               TabIndex        =   5
               Top             =   690
               Width           =   2235
            End
            Begin VB.TextBox txtdatatec 
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
               Left            =   1695
               MaxLength       =   30
               TabIndex        =   6
               Top             =   1050
               Width           =   2235
            End
            Begin VB.TextBox txtbolsa 
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
               Left            =   1695
               MaxLength       =   10
               TabIndex        =   7
               Top             =   1410
               Width           =   2235
            End
            Begin VB.TextBox txtNumero 
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
               Left            =   1695
               MaxLength       =   4
               TabIndex        =   4
               Top             =   345
               Width           =   1185
            End
            Begin VB.TextBox txt_Cuenta_DCV 
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
               Left            =   1695
               MaxLength       =   8
               TabIndex        =   8
               Top             =   1755
               Width           =   2235
            End
            Begin VB.Label Label5 
               Caption         =   "Nombre Datatec"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H80000007&
               Height          =   300
               Left            =   120
               TabIndex        =   24
               Top             =   2100
               Width           =   1605
            End
            Begin VB.Label Label4 
               Caption         =   "Cuenta DCV"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H80000007&
               Height          =   300
               Left            =   135
               TabIndex        =   23
               Top             =   1785
               Width           =   1095
            End
            Begin VB.Label Label 
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
               ForeColor       =   &H80000007&
               Height          =   315
               Index           =   3
               Left            =   135
               TabIndex        =   17
               Top             =   720
               Width           =   1005
            End
            Begin VB.Label Label 
               Caption         =   "Código"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H80000007&
               Height          =   315
               Index           =   4
               Left            =   135
               TabIndex        =   16
               Top             =   375
               Width           =   1005
            End
            Begin VB.Label Label1 
               Caption         =   "Datatec"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H80000007&
               Height          =   240
               Left            =   135
               TabIndex        =   15
               Top             =   1110
               Width           =   1005
            End
            Begin VB.Label Label2 
               Caption         =   "Bolsa"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H80000007&
               Height          =   285
               Left            =   135
               TabIndex        =   14
               Top             =   1470
               Width           =   765
            End
         End
         Begin Threed.SSFrame SSFrame2 
            Height          =   870
            Left            =   75
            TabIndex        =   18
            Top             =   105
            Width           =   5850
            _Version        =   65536
            _ExtentX        =   10319
            _ExtentY        =   1535
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
            ShadowStyle     =   1
            Begin VB.Label Label 
               Caption         =   "Código"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H80000007&
               Height          =   315
               Index           =   5
               Left            =   3705
               TabIndex        =   22
               Top             =   150
               Width           =   840
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "-"
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
               Index           =   1
               Left            =   2640
               TabIndex        =   21
               Top             =   180
               Width           =   90
            End
            Begin VB.Label Label 
               Caption         =   "Rut"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H80000007&
               Height          =   315
               Index           =   0
               Left            =   375
               TabIndex        =   20
               Top             =   150
               Width           =   1005
            End
            Begin VB.Label Label3 
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
               ForeColor       =   &H80000007&
               Height          =   240
               Left            =   360
               TabIndex        =   19
               Top             =   510
               Width           =   1005
            End
         End
         Begin MSComctlLib.ImageList Img_opciones 
            Left            =   5130
            Top             =   -540
            _ExtentX        =   1005
            _ExtentY        =   1005
            BackColor       =   -2147483643
            ImageWidth      =   24
            ImageHeight     =   24
            MaskColor       =   12632256
            _Version        =   393216
            BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
               NumListImages   =   10
               BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "Bacclsin.frx":350E
                  Key             =   ""
               EndProperty
               BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "Bacclsin.frx":3975
                  Key             =   ""
               EndProperty
               BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "Bacclsin.frx":3E6B
                  Key             =   ""
               EndProperty
               BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "Bacclsin.frx":42FE
                  Key             =   ""
               EndProperty
               BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "Bacclsin.frx":47E6
                  Key             =   ""
               EndProperty
               BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "Bacclsin.frx":4CF9
                  Key             =   ""
               EndProperty
               BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "Bacclsin.frx":51CC
                  Key             =   ""
               EndProperty
               BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "Bacclsin.frx":5692
                  Key             =   ""
               EndProperty
               BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "Bacclsin.frx":5B89
                  Key             =   ""
               EndProperty
               BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
                  Picture         =   "Bacclsin.frx":5F82
                  Key             =   ""
               EndProperty
            EndProperty
         End
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   11
      Top             =   0
      Width           =   6030
      _ExtentX        =   10636
      _ExtentY        =   794
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Style           =   1
      ImageList       =   "Img_opciones"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Limpiar"
            Description     =   "Grabar"
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Grabar"
            Description     =   "Eliminar"
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Eliminar"
            Description     =   "Limpiar"
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Buscar"
            Description     =   "Salir"
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "BacMntClientesSinacofi"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim SW                    As Integer
Dim OptLocal              As String
Private objCliente        As Object

Function HabilitarControles(Valor As Boolean)
   txtRut.Enabled = Not Valor
   txtDigito.Enabled = False
   txtCodigo.Enabled = Not Valor
   TxtNombre.Enabled = False
   txtNumero.Enabled = Valor
   txtSinacofi.Enabled = Valor
   txtdatatec.Enabled = Valor
   txtbolsa.Enabled = Valor
   txt_Cuenta_DCV.Enabled = Valor
   Txt_Cliente_Sinacofi.Enabled = Valor
   Toolbar1.Buttons(2).Enabled = False

End Function

'Limpiar Pantalla
Sub Limpiar()
   txtRut.Text = ""
   txtDigito.Text = ""
   txtCodigo.Text = ""
   TxtNombre.Text = ""
   txtNumero.Text = ""
   txtSinacofi.Text = ""
   txtdatatec.Text = ""
   txtbolsa.Text = ""
   txt_Cuenta_DCV.Text = ""
   Txt_Cliente_Sinacofi.Text = ""
End Sub
Sub Revisa()
   txtNumero.Tag = txtNumero.Text
   txtSinacofi.Tag = txtSinacofi.Text
   txtdatatec.Tag = txtdatatec.Text
   txtbolsa.Tag = txtbolsa.Text
End Sub

Function ValidarDatos() As Boolean
   ValidarDatos = False
   
   If Trim$(txtNumero) = "" Then
      MsgBox "ERROR : Número Sinacofi vacio", 16
      'txtNumero.SetFocus
      
   ElseIf Trim$(txtSinacofi) = "" Then
      MsgBox "ERROR : Codigo/Nemo Sinacofi vacio", 16
      txtSinacofi.SetFocus
      
   Else
      ValidarDatos = True
      
   End If
   
End Function

Sub limpiar_objetos()
   objCliente.clrut = ""
   objCliente.cldv = ""
   objCliente.clnombre = ""
   objCliente.clNumSinacofi = ""
   objCliente.clNomSinacofi = ""
   objCliente.cldatatec = ""
   objCliente.clbolsa = ""
   objCliente.clCuenta_Dcv = ""
   objCliente.clnombre_datatec = ""
End Sub

Private Sub cmdGrabar()
   Me.MousePointer = 11

   If Not ValidarDatos() Then   'Valdiaci¢n de los datos del cliente.
      Me.MousePointer = 0
      Exit Sub
   
   End If

   objCliente.clrut = txtRut.Text
   objCliente.cldv = txtDigito.Text
   objCliente.clnombre = TxtNombre.Text
   objCliente.clNumSinacofi = txtNumero.Text
   objCliente.clNomSinacofi = txtSinacofi.Text
   objCliente.cldatatec = txtdatatec.Text
   objCliente.clbolsa = txtbolsa.Text
   objCliente.clCuenta_Dcv = txt_Cuenta_DCV.Text
   objCliente.clnombre_datatec = Txt_Cliente_Sinacofi.Text

   '----------------------------------------------
   If objCliente.GrabarSINACOFI() Then
      MsgBox "Grabación se realizó con exito ", 64
      Call LogAuditoria("01", OptLocal, Me.Caption, "", "Rut: " & txtRut.Text & "-" & txtDigito.Text & " Codigo: " & txtCodigo.Text & " Codigo SINACOFI: " & txtNumero.Text & " Datatec: " & txtdatatec.Text & " Bolsa: " & txtbolsa.Text)
      Call cmdLimpiar
   Else
      MsgBox "ERROR :Grabación no se llevo a cabo ", 16
      Call LogAuditoria("01", OptLocal, Me.Caption & " Error al grabar- Rut: " & txtRut.Text & "-" & txtDigito.Text & " Codigo: " & txtCodigo.Text & " Codigo SINACOFI: " & txtNumero.Text & " Datatec: " & txtdatatec.Text & " Bolsa: " & txtbolsa.Text, "", "")
   End If
   Me.MousePointer = 0
End Sub

Private Sub cmdLimpiar()
   
   Call Limpiar
   Call HabilitarControles(False)
   Toolbar1.Buttons(4).Enabled = True
   Toolbar1.Buttons(3).Enabled = False
   txtRut.SetFocus

End Sub

Private Sub Form_Activate()
   PROC_CARGA_AYUDA Me, " "
   If txtRut.Enabled Then
      txtRut.SetFocus
   End If
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
Dim opcion As Integer
If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) Then

opcion = 0
   Select Case KeyCode

         Case vbKeyLimpiar
               opcion = 1

         Case vbKeyGrabar
               opcion = 2
         
         Case vbKeyEliminar
               opcion = 3

         Case vbKeyBuscar
               opcion = 4
         
         Case vbKeySalir
               opcion = 5
   End Select

   If opcion <> 0 Then
      If Toolbar1.Buttons(opcion).Enabled Then
         Call Toolbar1_ButtonClick(Toolbar1.Buttons(opcion))
      End If

   End If

End If

End Sub


Private Sub Form_KeyPress(KeyAscii As Integer)

   If KeyAscii = 13 Then
      Bac_SendKey vbKeyTab
   End If

End Sub

Private Sub Form_Load()
   OptLocal = Opt
    Me.top = 0
    Me.left = 0

   Set objCliente = New clsCliente

   Call HabilitarControles(False)
   Toolbar1.Buttons(3).Enabled = False
   
   Call LogAuditoria("07", OptLocal, Me.Caption, "", "")
End Sub

Private Sub cmdEliminar()

   objCliente.clrut = txtRut.Text
   
   If objCliente.BorrarSINACOFI() = True Then
      Call LogAuditoria("03", OptLocal, Me.Caption, "Rut: " & txtRut.Text & "-" & txtDigito.Text & " Codigo: " & txtCodigo.Text & " Codigo SINACOFI: " & txtNumero.Text & " Datatec: " & txtdatatec.Text & " Bolsa: " & txtbolsa.Text, "")
      Call cmdLimpiar
      txtRut.SetFocus

   Else
      MsgBox "Datos no pueden ser Removidos de Archivos", vbExclamation + vbOKOnly
      Call LogAuditoria("03", OptLocal, Me.Caption & " Error al eliminar- Rut: " & txtRut.Text & "-" & txtDigito.Text & " Codigo: " & txtCodigo.Text & " Codigo SINACOFI: " & txtNumero.Text & " Datatec: " & txtdatatec.Text & " Bolsa: " & txtbolsa.Text, "", "")
   End If

End Sub

Private Sub Form_Unload(Cancel As Integer)
   Call LogAuditoria("08", OptLocal, Me.Caption, "", "")
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Trim(UCase(Button.Key))
Case "LIMPIAR"
    cmdLimpiar
Case "GRABAR"
    cmdGrabar
    Call limpiar_objetos

Case "ELIMINAR"
Dim ss
ss = MsgBox("Seguro de Eliminar Sinacofi : " & Chr(13) & txtSinacofi.Text, vbQuestion + vbYesNo)
If ss = 6 Then
    cmdEliminar
    Call limpiar_objetos
   
End If
Case "BUSCAR"
   txtDigito_LostFocus
Case "SALIR"
    Unload Me
End Select
End Sub



Private Sub txtCodigo_DblClick()
    'txtRut_DblClick
End Sub

Private Sub TxtCodigo_KeyDown(KeyCode As Integer, Shift As Integer)
   'If KeyCode = vbKeyF3 Then Call txtRut_DblClick
End Sub

Private Sub txtCodigo_KeyPress(KeyAscii As Integer)
 
   If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      Bac_SendKey vbKeyTab

   ElseIf Not ((KeyAscii > 47 And KeyAscii < 58) Or KeyAscii = 8) Then
      KeyAscii = 0
     
   End If
     
   BacCaracterNumerico KeyAscii

End Sub

Private Sub txtbolsa_KeyPress(KeyAscii As Integer)
    KeyAscii = Caracter(KeyAscii)
    If KeyAscii <> 8 Then
       KeyAscii = Asc(UCase(Chr(KeyAscii)))
    End If
End Sub

Private Sub TxtCodigo_LostFocus()

   Call txtDigito_LostFocus

End Sub

Private Sub txtdatatec_KeyPress(KeyAscii As Integer)
    KeyAscii = Caracter(KeyAscii)
    If KeyAscii <> 8 Then
       KeyAscii = Asc(UCase(Chr(KeyAscii)))
    End If
End Sub

Private Sub txtDigito_KeyPress(KeyAscii As Integer)

   If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      Bac_SendKey vbKeyTab

   ElseIf Not ((KeyAscii > 47 And KeyAscii < 58) Or KeyAscii = 75 Or KeyAscii = 107 Or KeyAscii = 8) Then
      KeyAscii = 0

   End If

   BacToUCase KeyAscii

End Sub

Private Sub txtDigito_LostFocus()
Dim idRut     As String
Dim IdDig     As String
Dim IdCod     As String
Dim Bandera   As Integer

    Bandera = True
    
    idRut = txtRut.Text
    IdDig = txtDigito.Text
    IdCod = txtCodigo.Text

    If Not Controla_RUT(txtRut, txtDigito) Then
        MsgBox "Rut Incorrecto", vbOKOnly + vbExclamation
        Call Limpiar
        Call HabilitarControles(False)
        If txtRut.Enabled Then
         txtRut.SetFocus
        End If
        Exit Sub
    End If
    
    objCliente.clrut = Val(txtRut.Text)
    objCliente.cldv = txtDigito.Text
    objCliente.clcodigo = Val(txtCodigo.Text)
    
    If Not objCliente.LeerPorRut(objCliente.clrut, objCliente.clcodigo) Then
        IdCod = 0
        If objCliente.clcodigo = 0 Then
            If objCliente.LeerPorRut(Val(idRut), 1) Then
                IdCod = 1
            End If
        End If
        If IdCod = 0 Then
            MsgBox "Cliente No Existe", vbInformation
            txtRut.SetFocus
            Call Limpiar
            Exit Sub
        End If
    End If
    
    If objCliente.clrut = 0 Then
       Call Limpiar
       txtRut.Text = idRut
       txtDigito.Text = IdDig
       txtCodigo.Text = IdCod
       
    Else
       txtCodigo.Text = objCliente.clcodigo
       txtCodigo.Tag = txtCodigo.Text
    
       TxtNombre.Text = objCliente.clnombre
       TxtNombre.Tag = TxtNombre.Text
       
       txtNumero.Text = objCliente.clNumSinacofi
       txtNumero.Tag = txtNumero.Text
    
       txtSinacofi.Text = objCliente.clNomSinacofi
       txtSinacofi.Tag = txtSinacofi.Text
       
       txtdatatec.Text = objCliente.cldatatec
       txtdatatec.Tag = txtdatatec.Text
       
       txtbolsa.Text = objCliente.clbolsa
       txtbolsa.Tag = txtbolsa.Text
       
       txt_Cuenta_DCV.Text = objCliente.clCuenta_Dcv
       txt_Cuenta_DCV.Tag = txt_Cuenta_DCV.Text
       
       Txt_Cliente_Sinacofi.Text = objCliente.clnombre_datatec
       Txt_Cliente_Sinacofi.Tag = Txt_Cliente_Sinacofi.Text
       
       Toolbar1.Buttons(3).Enabled = True
    
    End If
    
    Call HabilitarControles(True)
    
    Toolbar1.Buttons(1).Enabled = (objCliente.clrut <> 0)
    Toolbar1.Buttons(2).Enabled = True
    Toolbar1.Buttons(4).Enabled = False
    txtNumero.SetFocus
      

End Sub

Private Sub TxtNumero_KeyPress(KeyAscii As Integer)
   KeyAscii = Caracter(KeyAscii)
   KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub

Private Sub txtRut_DblClick()
   clie = "SINACOFI"
   MiTag = "MDCL"
   BacAyuda.Show 1

   If giAceptar% = True Then
      Toolbar1.Buttons(2).Enabled = True
      Toolbar1.Buttons(3).Enabled = True
      
      txtRut.Text = Val(gsCodigo$)
      txtDigito.Text = gsDigito$
      txtCodigo.Text = gsCodCli
      If txtCodigo.Enabled Then
         txtCodigo.SetFocus
      End If
      'txtDigito.SetFocus
      Bac_SendKey vbKeyTab
            
   End If

End Sub

Private Sub txtRut_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyF3 Then Call txtRut_DblClick
End Sub


Private Sub txtRut_KeyPress(KeyAscii As Integer)

   If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      Bac_SendKey vbKeyTab
      txtDigito.Text = BacDevuelveDig(txtRut.Text)
   ElseIf Not ((KeyAscii > 47 And KeyAscii < 58) Or KeyAscii = 8) Then
      KeyAscii = 0
     
   End If
     
   BacCaracterNumerico KeyAscii
   
End Sub

Public Function BacDevuelveDig(Rut As String) As String

   Dim i       As Integer
   Dim D       As Integer
   Dim Divi    As Long
   Dim Suma    As Long
   Dim Digito  As String
   Dim Multi   As Double

   BacDevuelveDig = ""
   
   Select Case Len(Rut)
      Case 1
         Rut = Format(Rut, "0")
      Case 2
         Rut = Format(Rut, "00")
      Case 3
         Rut = Format(Rut, "000")
      Case 4
         Rut = Format(Rut, "0000")
      Case 5
         Rut = Format(Rut, "00000")
      Case 6
         Rut = Format(Rut, "000000")
      Case 7
         Rut = Format(Rut, "0000000")
      Case 8
         Rut = Format(Rut, "00000000")
      Case 9
         Rut = Format(Rut, "000000000")
   
   End Select
   
   D = 2
   For i = Len(Rut) To 1 Step -1
     Multi = Val(Mid$(Rut, i, 1)) * D
     Suma = Suma + Multi
     D = D + 1
      
      If D = 8 Then
         D = 2
      End If
      
   Next i
    
   Divi = (Suma \ 11)
   Multi = Divi * 11
   Digito = Trim$(Str$(11 - (Suma - Multi)))
    
   If Digito = "10" Then
      Digito = "K"
   
   End If
    
   If Digito = "11" Then
      Digito = "0"
   
   End If
    
   BacDevuelveDig = UCase(Digito)

End Function


Private Sub txtSinacofi_KeyPress(KeyAscii As Integer)

    KeyAscii = Caracter(KeyAscii)
    If KeyAscii <> 8 Then
        KeyAscii = Asc(UCase(Chr(KeyAscii)))
    End If
End Sub

