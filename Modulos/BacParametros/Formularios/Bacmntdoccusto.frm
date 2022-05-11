VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{316A9483-A459-11D4-9073-005004A524B9}#1.0#0"; "BacControles.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "threed32.ocx"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form Bacmntdoccusto 
   Caption         =   "Form1"
   ClientHeight    =   7020
   ClientLeft      =   -165
   ClientTop       =   120
   ClientWidth     =   11880
   LinkTopic       =   "Form1"
   ScaleHeight     =   7020
   ScaleWidth      =   11880
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   4440
      Top             =   0
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   1
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntdoccusto.frx":0000
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin Threed.SSPanel SSPanel1 
      Height          =   6375
      Left            =   0
      TabIndex        =   0
      Top             =   600
      Width           =   11895
      _Version        =   65536
      _ExtentX        =   20981
      _ExtentY        =   11245
      _StockProps     =   15
      BackColor       =   12632256
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
      Begin VB.Frame Frame2 
         Caption         =   "Fechas de"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   1095
         Left            =   0
         TabIndex        =   18
         Top             =   3480
         Width           =   8415
         Begin BacControles.txtFecha txtFecha5 
            Height          =   315
            Left            =   240
            TabIndex        =   19
            Top             =   480
            Width           =   1335
            _ExtentX        =   2355
            _ExtentY        =   556
            Text            =   "09/03/2001"
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   8388608
            MinDate         =   -328716
            MaxDate         =   2958465
         End
         Begin BacControles.txtFecha txtFecha6 
            Height          =   315
            Left            =   1800
            TabIndex        =   20
            Top             =   480
            Width           =   1335
            _ExtentX        =   2355
            _ExtentY        =   556
            Text            =   "09/03/2001"
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   8388608
            MinDate         =   -328716
            MaxDate         =   2958465
         End
         Begin BacControles.txtFecha txtFecha8 
            Height          =   315
            Left            =   5040
            TabIndex        =   21
            Top             =   480
            Width           =   1335
            _ExtentX        =   2355
            _ExtentY        =   556
            Text            =   "09/03/2001"
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   8388608
            MinDate         =   -328716
            MaxDate         =   2958465
         End
         Begin BacControles.txtFecha txtFecha7 
            Height          =   315
            Left            =   3480
            TabIndex        =   22
            Top             =   480
            Width           =   1335
            _ExtentX        =   2355
            _ExtentY        =   556
            Text            =   "09/03/2001"
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   8388608
            MinDate         =   -328716
            MaxDate         =   2958465
         End
         Begin BacControles.txtFecha txtFecha9 
            Height          =   315
            Left            =   6480
            TabIndex        =   23
            Top             =   480
            Width           =   1335
            _ExtentX        =   2355
            _ExtentY        =   556
            Text            =   "09/03/2001"
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   8388608
            MinDate         =   -328716
            MaxDate         =   2958465
         End
         Begin VB.Label Label7 
            Caption         =   "Emision"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   255
            Left            =   240
            TabIndex        =   26
            Top             =   240
            Width           =   1335
         End
         Begin VB.Label Label8 
            Caption         =   "Recepcion"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   255
            Left            =   1800
            TabIndex        =   25
            Top             =   240
            Width           =   1215
         End
         Begin VB.Label Label9 
            Caption         =   "Firma Contrato"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   255
            Left            =   3480
            TabIndex        =   24
            Top             =   240
            Width           =   1335
         End
      End
      Begin VB.ComboBox cmb_producto 
         Height          =   315
         Left            =   4200
         TabIndex        =   16
         Text            =   "Combo1"
         Top             =   2040
         Width           =   2655
      End
      Begin VB.ComboBox cmb_tipoperacioon 
         Height          =   315
         Left            =   4200
         Style           =   2  'Dropdown List
         TabIndex        =   15
         Top             =   2400
         Width           =   1935
      End
      Begin VB.Frame Frame1 
         Caption         =   "Filtrar por"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   1215
         Left            =   360
         TabIndex        =   2
         Top             =   120
         Width           =   7695
         Begin VB.ComboBox cmb_tipprod 
            Height          =   315
            Left            =   5760
            Style           =   2  'Dropdown List
            TabIndex        =   10
            Top             =   600
            Width           =   1695
         End
         Begin VB.TextBox cmb_cliente 
            Height          =   285
            Left            =   3840
            MouseIcon       =   "Bacmntdoccusto.frx":031A
            MousePointer    =   99  'Custom
            TabIndex        =   7
            Top             =   600
            Width           =   1575
         End
         Begin BacControles.txtFecha txtFecha1 
            Height          =   315
            Left            =   2040
            TabIndex        =   5
            Top             =   600
            Width           =   1335
            _ExtentX        =   2355
            _ExtentY        =   556
            Text            =   "09/03/2001"
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   8388608
            MinDate         =   -328716
            MaxDate         =   2958465
         End
         Begin BacControles.txtFecha txtFecha2 
            Height          =   315
            Left            =   480
            TabIndex        =   6
            Top             =   600
            Width           =   1335
            _ExtentX        =   2355
            _ExtentY        =   556
            Text            =   "09/03/2001"
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   8388608
            MinDate         =   -328716
            MaxDate         =   2958465
         End
         Begin VB.Label Label4 
            Caption         =   "Tipo Producto"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   255
            Left            =   5760
            TabIndex        =   9
            Top             =   360
            Width           =   1335
         End
         Begin VB.Label Label3 
            Caption         =   "Rut cliente"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   255
            Left            =   3840
            TabIndex        =   8
            Top             =   360
            Width           =   1095
         End
         Begin VB.Label Label2 
            Caption         =   "Fecha Final"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   255
            Left            =   2040
            TabIndex        =   4
            Top             =   360
            Width           =   1455
         End
         Begin VB.Label Label1 
            Caption         =   "Fecha Inicio"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   255
            Left            =   480
            TabIndex        =   3
            Top             =   360
            Width           =   1215
         End
      End
      Begin BacControles.txtFecha txtFecha3 
         Height          =   315
         Left            =   600
         TabIndex        =   12
         Top             =   1680
         Width           =   1335
         _ExtentX        =   2355
         _ExtentY        =   556
         Text            =   "09/03/2001"
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   8388608
         MinDate         =   -328716
         MaxDate         =   2958465
      End
      Begin BacControles.txtFecha txtFecha4 
         Height          =   315
         Left            =   5160
         TabIndex        =   13
         Top             =   1680
         Width           =   1335
         _ExtentX        =   2355
         _ExtentY        =   556
         Text            =   "09/03/2001"
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   8388608
         MinDate         =   -328716
         MaxDate         =   2958465
      End
      Begin BacControles.txtNumero txtcontcli 
         Height          =   375
         Left            =   1800
         TabIndex        =   17
         Top             =   2400
         Width           =   1215
         _ExtentX        =   2143
         _ExtentY        =   661
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         SelStart        =   5
         Text            =   "0.0000"
         Max             =   "99999999"
      End
      Begin MSFlexGridLib.MSFlexGrid MSFlexGrid1 
         Height          =   6375
         Left            =   8520
         TabIndex        =   27
         Top             =   0
         Width           =   3495
         _ExtentX        =   6165
         _ExtentY        =   11245
         _Version        =   393216
      End
      Begin VB.Label Label6 
         Caption         =   "Fecha Venc."
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   5040
         TabIndex        =   14
         Top             =   1440
         Width           =   1335
      End
      Begin VB.Label Label5 
         Caption         =   "Fecha Incio"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000D&
         Height          =   255
         Left            =   600
         TabIndex        =   11
         Top             =   1440
         Width           =   1335
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   1
      Top             =   0
      Width           =   11880
      _ExtentX        =   20955
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "Bacmntdoccusto"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cmb_cliente_Change()

End Sub

Private Sub cmb_cliente_DblClick()
Call llamarayuda
End Sub

Private Sub cmb_producto_Change()

End Sub

Private Sub Form_Load()

End Sub

Private Sub txtFecha1_FechaInvalida()

End Sub

Private Sub txtFecha2_FechaInvalida()

End Sub
Function llamarayuda()
 BacAyuda.Tag = "MDCL_U"
   BacAyuda.Show 1
   
   
   If giAceptar% = True Then
    
        cmb_cliente = gsCodigo
        
        
   End If
End Function
Function filtar_fecha()

End Function
Function filtrar_cliente()


End Function

Function activar_paramodi()

End Function
Function desactivar_paramodi()

End Function
Function veri_txtcontcli()

End Function

Private Sub txtFecha4_FechaInvalida()

End Sub
