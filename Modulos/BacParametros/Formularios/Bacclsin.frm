VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Begin VB.Form BacMntClientesSinacofi 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Mantención de Clientes SINACOFI"
   ClientHeight    =   4935
   ClientLeft      =   705
   ClientTop       =   1875
   ClientWidth     =   6165
   Icon            =   "Bacclsin.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4935
   ScaleWidth      =   6165
   ShowInTaskbar   =   0   'False
   Begin Threed.SSPanel SSPanel1 
      Height          =   4305
      Left            =   0
      TabIndex        =   6
      Top             =   570
      Width           =   6120
      _Version        =   65536
      _ExtentX        =   10795
      _ExtentY        =   7594
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
         Height          =   4140
         Index           =   0
         Left            =   90
         TabIndex        =   8
         Top             =   30
         Width           =   5985
         _Version        =   65536
         _ExtentX        =   10557
         _ExtentY        =   7302
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
            ForeColor       =   &H00800000&
            Height          =   315
            Left            =   1035
            MaxLength       =   10
            TabIndex        =   10
            Top             =   2460
            Width           =   1185
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
            ForeColor       =   &H00800000&
            Height          =   315
            Left            =   1035
            MaxLength       =   5
            TabIndex        =   9
            Top             =   2100
            Width           =   1185
         End
         Begin VB.TextBox txtDigito 
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   315
            Left            =   2820
            MaxLength       =   1
            TabIndex        =   2
            Top             =   240
            Width           =   330
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
            ForeColor       =   &H00800000&
            Height          =   315
            Left            =   1545
            MaxLength       =   40
            TabIndex        =   4
            Top             =   570
            Width           =   4290
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
            ForeColor       =   &H00800000&
            Height          =   315
            Left            =   1035
            MaxLength       =   4
            TabIndex        =   1
            Top             =   1380
            Width           =   1185
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
            ForeColor       =   &H00800000&
            Height          =   315
            Left            =   1035
            MaxLength       =   4
            TabIndex        =   5
            Top             =   1740
            Width           =   1185
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
            ForeColor       =   &H00800000&
            Height          =   315
            Left            =   4680
            MaxLength       =   10
            MouseIcon       =   "Bacclsin.frx":030A
            MousePointer    =   99  'Custom
            MultiLine       =   -1  'True
            TabIndex        =   3
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
            ForeColor       =   &H00800000&
            Height          =   315
            Left            =   1560
            MaxLength       =   10
            MouseIcon       =   "Bacclsin.frx":0614
            MousePointer    =   99  'Custom
            MultiLine       =   -1  'True
            TabIndex        =   0
            Top             =   240
            Width           =   1140
         End
         Begin Threed.SSFrame SSFrame1 
            Height          =   2985
            Left            =   90
            TabIndex        =   11
            Top             =   990
            Width           =   5850
            _Version        =   65536
            _ExtentX        =   10319
            _ExtentY        =   5265
            _StockProps     =   14
            Caption         =   "Según SINACOFI ..."
            ForeColor       =   16711680
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
            ShadowStyle     =   1
            Begin VB.TextBox txtSourceOfData 
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00800000&
               Height          =   315
               Left            =   4530
               MaxLength       =   10
               TabIndex        =   32
               Top             =   2430
               Visible         =   0   'False
               Width           =   1185
            End
            Begin VB.TextBox txtSystem 
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00800000&
               Height          =   315
               Left            =   4530
               MaxLength       =   50
               TabIndex        =   30
               Top             =   2040
               Visible         =   0   'False
               Width           =   1185
            End
            Begin VB.TextBox txtTerminal 
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00800000&
               Height          =   315
               Left            =   4530
               MaxLength       =   20
               TabIndex        =   28
               Top             =   1650
               Visible         =   0   'False
               Width           =   1185
            End
            Begin VB.TextBox txtSourceBac 
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00800000&
               Height          =   315
               Left            =   4530
               MaxLength       =   3
               TabIndex        =   26
               Top             =   1260
               Visible         =   0   'False
               Width           =   1185
            End
            Begin VB.TextBox txtCodeSwifth 
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00800000&
               Height          =   315
               Left            =   4530
               MaxLength       =   20
               TabIndex        =   24
               Top             =   870
               Visible         =   0   'False
               Width           =   1185
            End
            Begin VB.CheckBox chkPlataformaExterna 
               Alignment       =   1  'Right Justify
               Caption         =   "Plataforma Externa"
               Height          =   255
               Left            =   3990
               TabIndex        =   23
               Top             =   150
               Width           =   1725
            End
            Begin VB.TextBox txtDealinkCode 
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00800000&
               Height          =   315
               Left            =   4530
               MaxLength       =   20
               TabIndex        =   22
               Top             =   510
               Visible         =   0   'False
               Width           =   1185
            End
            Begin VB.Label Label7 
               AutoSize        =   -1  'True
               Caption         =   "Source of Data"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00800000&
               Height          =   210
               Left            =   3240
               TabIndex        =   33
               Top             =   2475
               Visible         =   0   'False
               Width           =   1185
            End
            Begin VB.Label Label6 
               AutoSize        =   -1  'True
               Caption         =   "System"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00800000&
               Height          =   210
               Left            =   3795
               TabIndex        =   31
               Top             =   2085
               Visible         =   0   'False
               Width           =   630
            End
            Begin VB.Label Label5 
               AutoSize        =   -1  'True
               Caption         =   "Terminal"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00800000&
               Height          =   210
               Left            =   3690
               TabIndex        =   29
               Top             =   1695
               Visible         =   0   'False
               Width           =   735
            End
            Begin VB.Label Label4 
               AutoSize        =   -1  'True
               Caption         =   "Source Bac"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00800000&
               Height          =   210
               Left            =   3510
               TabIndex        =   27
               Top             =   1305
               Visible         =   0   'False
               Width           =   915
            End
            Begin VB.Label lbCodeSwifth 
               AutoSize        =   -1  'True
               Caption         =   "Code Swifth"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00800000&
               Height          =   210
               Left            =   3420
               TabIndex        =   25
               Top             =   915
               Visible         =   0   'False
               Width           =   1005
            End
            Begin VB.Label lblDealinkCoded 
               AutoSize        =   -1  'True
               Caption         =   "Bank Dealink Code"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   700
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               ForeColor       =   &H00800000&
               Height          =   210
               Left            =   2895
               TabIndex        =   21
               Top             =   555
               Visible         =   0   'False
               Width           =   1530
            End
            Begin VB.Label Label 
               BackColor       =   &H00C0C0C0&
               BackStyle       =   0  'Transparent
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
               ForeColor       =   &H00800000&
               Height          =   375
               Index           =   3
               Left            =   240
               TabIndex        =   15
               Top             =   780
               Width           =   1095
            End
            Begin VB.Label Label 
               BackColor       =   &H00C0C0C0&
               BackStyle       =   0  'Transparent
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
               ForeColor       =   &H00800000&
               Height          =   375
               Index           =   4
               Left            =   240
               TabIndex        =   14
               Top             =   405
               Width           =   1095
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
               ForeColor       =   &H00800000&
               Height          =   255
               Left            =   240
               TabIndex        =   13
               Top             =   1140
               Width           =   1095
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
               ForeColor       =   &H00800000&
               Height          =   375
               Left            =   240
               TabIndex        =   12
               Top             =   1455
               Width           =   1095
            End
         End
         Begin Threed.SSFrame SSFrame2 
            Height          =   870
            Left            =   75
            TabIndex        =   16
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
               BackColor       =   &H00C0C0C0&
               BackStyle       =   0  'Transparent
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
               ForeColor       =   &H00800000&
               Height          =   315
               Index           =   5
               Left            =   3555
               TabIndex        =   20
               Top             =   150
               Width           =   1005
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
               Left            =   2670
               TabIndex        =   19
               Top             =   150
               Width           =   75
            End
            Begin VB.Label Label 
               BackColor       =   &H00C0C0C0&
               BackStyle       =   0  'Transparent
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
               ForeColor       =   &H00800000&
               Height          =   315
               Index           =   0
               Left            =   375
               TabIndex        =   18
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
               ForeColor       =   &H00800000&
               Height          =   240
               Left            =   360
               TabIndex        =   17
               Top             =   510
               Width           =   1005
            End
         End
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   4695
      Top             =   1785
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
            Picture         =   "Bacclsin.frx":091E
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacclsin.frx":0D70
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacclsin.frx":11C2
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacclsin.frx":14DC
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   7
      Top             =   0
      Width           =   6165
      _ExtentX        =   10874
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Grabar"
            Description     =   "Grabar"
            Object.ToolTipText     =   "Grabar Datos"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Eliminar"
            Description     =   "Eliminar"
            Object.ToolTipText     =   "Eliminar Datos"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Limpiar"
            Description     =   "Limpiar"
            Object.ToolTipText     =   "Limpiar Datos"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Description     =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   4
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
End
Attribute VB_Name = "BacMntClientesSinacofi"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim Sw                    As Integer

Private objCliente        As Object

Function HabilitarControles(Valor As Boolean)

   txtRut.Enabled = Not Valor
   txtDigito.Enabled = Not Valor
   TxtCodigo.Enabled = Valor
   txtNombre.Enabled = Not False
   txtNumero.Enabled = Valor
   txtSinacofi.Enabled = Valor
   txtdatatec.Enabled = Valor
   txtbolsa.Enabled = Valor

End Function

'Limpiar Pantalla
Sub Limpiar()
   txtRut.Text = ""
   txtDigito.Text = ""
   TxtCodigo.Text = ""
   txtNombre.Text = ""
   txtNumero.Text = ""
   txtSinacofi.Text = ""
   txtdatatec.Text = ""
   txtbolsa.Text = ""
    txtDealinkCode.Text = ""
    txtCodeSwifth.Text = ""
    txtSourceBac.Text = ""
    txtDealinkCode.Text = ""
    txtTerminal.Text = ""
    txtSystem.Text = ""
    txtSourceOfData.Text = ""
    txtCodeSwifth.Text = ""
   
   
End Sub
Sub Revisa()
   txtNumero.Tag = txtNumero.Text
   txtSinacofi.Tag = txtSinacofi.Text
   txtdatatec.Tag = txtdatatec.Text
   txtbolsa.Tag = txtbolsa.Text
End Sub

Function ValidarDatos() As Boolean
   ValidarDatos = False
   
   If Not Controla_RUT(txtRut, txtDigito) Then
    
        MsgBox "Error : Rut Incorrecto", 16, " Bac-Parametros"
        Call Limpiar
        Call HabilitarControles(False)
        txtRut.SetFocus
        
   ElseIf Trim$(txtRut) = "" Then
      MsgBox "ERROR : Rut vacio", 16, "Bac-Parametros"
      txtRut.SetFocus
      
   ElseIf Trim$(TxtCodigo) = "" Then
      MsgBox "ERROR : Codigo Cliente vacio", 16, "Bac-Parametros"
      txtRut.SetFocus
      
   ElseIf Trim$(txtNombre) = "" Then
      MsgBox "ERROR : Nombre Cliente vacio", 16, "Bac-Parametros"
      txtRut.SetFocus
      
   ElseIf Trim$(txtNumero) = "" Then
      MsgBox "ERROR : Número Sinacofi vacio", 16, "Bac-Parametros"
      'txtrut.SetFocus
      txtNumero.SetFocus
      
   ElseIf Trim$(txtSinacofi) = "" Then
      MsgBox "ERROR : Codigo/Nemo Sinacofi vacio", 16, "Bac-Parametros"
      txtSinacofi.SetFocus
      'txtrut.SetFocus
           
      
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
   
End Sub
Private Sub cmdGrabar()
   
   Me.MousePointer = 11

   If Not ValidarDatos() Then   'Valdiaci¢n de los datos del cliente.
      Me.MousePointer = 0
      Exit Sub
   
   End If
  
     
   objCliente.clrut = Val(txtRut.Text)
   objCliente.cldv = Val(txtDigito.Text)
   objCliente.clnombre = txtNombre.Text
   objCliente.clNumSinacofi = txtNumero.Text
   objCliente.clNomSinacofi = txtSinacofi.Text
   objCliente.cldatatec = txtdatatec.Text
   objCliente.clbolsa = txtbolsa.Text
        
   ' 12-03-2010 RQ3146 - RQ5276 - RQ5277
   'objCliente.clstandard = txtStandard.Text
   'objCliente.clbarclays = txtBarclays.Text
   'objCliente.clcitibank = Me.txtCitibank.Text
   
    If Me.chkPlataformaExterna.Value = 0 Then
        txtDealinkCode.Text = ""
        txtCodeSwifth.Text = ""
        txtSourceBac.Text = ""
        txtDealinkCode.Text = ""
        txtTerminal.Text = ""
        txtSystem.Text = ""
        txtSourceOfData.Text = ""
        txtCodeSwifth.Text = ""
    End If
    
    objCliente.PlataformaExterna = chkPlataformaExterna.Value
    objCliente.SourceBac = txtSourceBac.Text
    objCliente.BankDealinkCoded = txtDealinkCode.Text
    objCliente.Terminal = txtTerminal.Text
    objCliente.System = txtSystem.Text
    objCliente.SOfData = txtSourceOfData.Text
    objCliente.CodigoSwifth = txtCodeSwifth.Text
   
        
   '----------------------------------------------
   If objCliente.GrabarSINACOFI() Then
      MsgBox "Grabación se realizó con exito ", 64, "Bac-forward"
      Call CmdLimpiar

   Else
      MsgBox "ERROR :Grabación no se llevo a cabo ", 16, "Bac-forward"

   End If

   Me.MousePointer = 0

End Sub
Private Sub CmdLimpiar()
   
   Call Limpiar
   Call HabilitarControles(False)
   txtRut.SetFocus

End Sub

Private Sub chkPlataformaExterna_Click()

    lblDealinkCoded.Visible = Not (chkPlataformaExterna.Value = 0)
    txtDealinkCode.Visible = Not (chkPlataformaExterna.Value = 0)
    lbCodeSwifth.Visible = Not (chkPlataformaExterna.Value = 0)
    txtCodeSwifth.Visible = Not (chkPlataformaExterna.Value = 0)
    
    txtSourceBac.Visible = Not (chkPlataformaExterna.Value = 0)
    txtDealinkCode.Visible = Not (chkPlataformaExterna.Value = 0)
    txtTerminal.Visible = Not (chkPlataformaExterna.Value = 0)
    txtSystem.Visible = Not (chkPlataformaExterna.Value = 0)
    txtSourceOfData.Visible = Not (chkPlataformaExterna.Value = 0)
    txtCodeSwifth.Visible = Not (chkPlataformaExterna.Value = 0)
    
    Label4.Visible = Not (chkPlataformaExterna.Value = 0)
    Label5.Visible = Not (chkPlataformaExterna.Value = 0)
    Label6.Visible = Not (chkPlataformaExterna.Value = 0)
    Label7.Visible = Not (chkPlataformaExterna.Value = 0)
    
    
    
End Sub

Private Sub Form_Activate()
txtRut.SetFocus
End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)

   If KeyAscii = 13 Then
      SendKeys "{TAB}"

   End If

End Sub

Private Sub Form_Load()
    Me.Top = 0
    Me.Left = 0

   Set objCliente = New clsCliente

   Call HabilitarControles(False)
   
End Sub

Private Sub cmdEliminar()

   objCliente.clrut = txtRut.Text
   
   If objCliente.BorrarSINACOFI() = True Then
      Call CmdLimpiar
      txtRut.SetFocus

   Else
      MsgBox "Datos no pueden ser Removidos de Archivos", vbExclamation + vbOKOnly, "Bac-Forward"

   End If

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index
Case 1      '"Grabar"
    cmdGrabar
    Call limpiar_objetos
Case 2      '"Eliminar"
Dim ss
ss = MsgBox("Seguro de Eliminar Sinacofi : " & Chr(13) & txtSinacofi.Text, vbQuestion + vbYesNo)
If ss = 6 Then
    cmdEliminar
    Call limpiar_objetos
   
End If
Case 3      '"Limpiar"
    CmdLimpiar
Case 4      '"Salir"
    Unload Me
End Select
End Sub

Private Sub txtBarclays_KeyPress(KeyAscii As Integer)
'    If KeyAscii = 13 Then
'        txtBarclays.SetFocus
'    ElseIf KeyAscii <> 8 Then
'        KeyAscii = Asc(UCase(Chr(KeyAscii)))
'    End If
End Sub

Private Sub txtCitibank_KeyPress(KeyAscii As Integer)
'   If KeyAscii = 13 Then
'        txtCitibank.SetFocus
'    ElseIf KeyAscii <> 8 Then
'       KeyAscii = Asc(UCase(Chr(KeyAscii)))
'    End If
End Sub

Private Sub txtCodigo_DblClick()
    TxtRut_DblClick
End Sub

Private Sub txtCodigo_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyF3 Then Call TxtRut_DblClick
End Sub

Private Sub txtCodigo_KeyPress(KeyAscii As Integer)

   If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      SendKeys$ "{TAB}"

   ElseIf Not ((KeyAscii > 47 And KeyAscii < 58) Or KeyAscii = 8) Then
      KeyAscii = 0
     
   End If
     
   BacCaracterNumerico KeyAscii

End Sub

Private Sub txtbolsa_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
     '   txtRut.SetFocus
    ElseIf KeyAscii <> 8 Then
       KeyAscii = Asc(UCase(Chr(KeyAscii)))
    End If
End Sub

Private Sub txtdatatec_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
        txtbolsa.SetFocus
    ElseIf KeyAscii <> 8 Then
       KeyAscii = Asc(UCase(Chr(KeyAscii)))
    End If
End Sub


Private Sub txtDealinkCode_KeyPress(KeyAscii As Integer)
    KeyAscii = Asc(UCase(Chr(KeyAscii)))
    If KeyAscii = 13 Then
        txtDealinkCode.SetFocus
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
Dim idRut     As String
Dim IdDig     As String
Dim IdCod     As String
Dim Bandera   As Integer

    Bandera = True
    
    idRut = txtRut.Text
    IdDig = txtDigito.Text
    IdCod = TxtCodigo.Text

    If txtRut.Text = "" Then
        Exit Sub
    End If
          
    If Not Controla_RUT(txtRut, txtDigito) Then
    
        MsgBox "Error : Rut Incorrecto", 16, " Bac-Parametros"
        Call Limpiar
        Call HabilitarControles(False)
        txtRut.SetFocus
        Exit Sub
    End If
    
    objCliente.clrut = txtRut.Text
    objCliente.cldv = txtDigito.Text
    objCliente.clcodigo = Val(TxtCodigo.Text)
    
    If Not objCliente.LeerPorRut(objCliente.clrut, objCliente.clcodigo) Then
        IdCod = 0
        If objCliente.clcodigo = 0 Then
            If objCliente.LeerPorRut(Val(idRut), 1) Then
                IdCod = 1
            End If
        End If
        If IdCod = 0 Then
            MsgBox "Error : Cliente no se encuentra", 16, "Bac-Parametros"
            txtRut.SetFocus
            Exit Sub
        End If
    End If
    
    If objCliente.clrut = 0 Then
       Call Limpiar
       txtRut.Text = idRut
       txtDigito.Text = IdDig
       TxtCodigo.Text = IdCod
       
    Else
       TxtCodigo.Text = objCliente.clcodigo
       TxtCodigo.Tag = TxtCodigo.Text
    
       txtNombre.Text = objCliente.clnombre
       txtNombre.Tag = txtNombre.Text
       
       txtNumero.Text = objCliente.clNumSinacofi
       txtNumero.Tag = txtNumero.Text
    
       txtSinacofi.Text = objCliente.clNomSinacofi
       txtSinacofi.Tag = txtSinacofi.Text
       
       txtdatatec.Text = objCliente.cldatatec
       txtdatatec.Tag = txtdatatec.Text
       
       txtbolsa.Text = objCliente.clbolsa
       txtbolsa.Tag = txtbolsa.Text
       
       'txtStandard.Text = objCliente.clstandard
       'txtStandard.Tag = txtStandard.Text
        
        'txtBarclays.Text = objCliente.clbarclays
        'txtBarclays.Tag = txtBarclays.Text
       
        'txtCitibank.Text = objCliente.clcitibank
        'txtCitibank.Tag = txtCitibank.Text
        
        chkPlataformaExterna.Value = IIf(objCliente.PlataformaExterna, 1, 0)
        
        txtSourceBac.Text = objCliente.SourceBac
        txtDealinkCode.Text = objCliente.BankDealinkCoded
        txtTerminal.Text = objCliente.Terminal
        txtSystem.Text = objCliente.System
        txtSourceOfData.Text = objCliente.SOfData
        txtCodeSwifth.Text = objCliente.CodigoSwifth
    
    End If
    
    Call HabilitarControles(True)
    
    Toolbar1.Buttons(1).Enabled = (objCliente.clrut <> 0)
    
    txtNumero.SetFocus
      

End Sub

Private Sub txtNumero_KeyPress(KeyAscii As Integer)

If KeyAscii = 13 Then
        txtSinacofi.SetFocus
    ElseIf KeyAscii <> 8 Then
        KeyAscii = Asc(UCase(Chr(KeyAscii)))
    End If
End Sub


Private Sub TxtRut_DblClick()
clie = "SINACOFI"
   'BacAyuda.Tag = "MDCL"
   'BacAyuda.Show 1
   'Arm Se implementa nuevo formulario ayuda
   BacAyudaCliente.Tag = "MDCL"
   BacAyudaCliente.Show 1

   If giAceptar% = True Then
      txtRut.Text = Val(gsCodigo$)
      txtDigito.Text = gsDigito$
      TxtCodigo.Text = gsCodCli
      txtDigito.SetFocus
      SendKeys "{ENTER}"
      giAceptar% = False
   End If

End Sub

Private Sub TxtRut_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyF3 Then Call TxtRut_DblClick
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

Private Sub txtSinacofi_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
      txtdatatec.SetFocus
    ElseIf KeyAscii <> 8 Then
        KeyAscii = Asc(UCase(Chr(KeyAscii)))
    End If
End Sub


