VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form Baccorrespon 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Corresponsales Internacionales"
   ClientHeight    =   11250
   ClientLeft      =   2460
   ClientTop       =   1800
   ClientWidth     =   15315
   Icon            =   "Baccorrespon.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   11250
   ScaleWidth      =   15315
   Begin VB.TextBox TextCodCorr 
      BackColor       =   &H80000002&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000009&
      Height          =   285
      Left            =   5160
      MaxLength       =   8
      TabIndex        =   29
      Top             =   3180
      Width           =   1215
   End
   Begin VB.TextBox Text2 
      BackColor       =   &H80000002&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000009&
      Height          =   285
      Left            =   2160
      MaxLength       =   4
      TabIndex        =   28
      Top             =   2220
      Visible         =   0   'False
      Width           =   1215
   End
   Begin BACControles.TXTFecha TXTFecha1 
      Height          =   255
      Left            =   2040
      TabIndex        =   27
      Top             =   3120
      Width           =   1455
      _ExtentX        =   2566
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
      Text            =   "08/09/2001"
   End
   Begin VB.TextBox TextCodCont 
      BackColor       =   &H80000002&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000009&
      Height          =   285
      Left            =   5160
      MaxLength       =   4
      TabIndex        =   26
      Top             =   2880
      Width           =   1215
   End
   Begin VB.TextBox txtgrilla2 
      BackColor       =   &H00800000&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000E&
      Height          =   315
      Left            =   3630
      MaxLength       =   50
      TabIndex        =   19
      TabStop         =   0   'False
      Top             =   2865
      Visible         =   0   'False
      Width           =   1500
   End
   Begin VB.TextBox TXTGRILLA 
      BackColor       =   &H00800000&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   315
      Left            =   3630
      MaxLength       =   11
      TabIndex        =   18
      TabStop         =   0   'False
      Top             =   3840
      Width           =   1500
   End
   Begin VB.ComboBox cmb_plaza 
      BackColor       =   &H00800000&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   315
      Left            =   2130
      Style           =   2  'Dropdown List
      TabIndex        =   8
      TabStop         =   0   'False
      Top             =   2865
      Visible         =   0   'False
      Width           =   1500
   End
   Begin VB.ComboBox cmb_pais 
      BackColor       =   &H00800000&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   315
      Left            =   2130
      Style           =   2  'Dropdown List
      TabIndex        =   7
      TabStop         =   0   'False
      Top             =   3840
      Visible         =   0   'False
      Width           =   1500
   End
   Begin VB.ComboBox cmb_Moneda 
      BackColor       =   &H00800000&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   315
      Left            =   2130
      Style           =   2  'Dropdown List
      TabIndex        =   6
      TabStop         =   0   'False
      Top             =   2550
      Visible         =   0   'False
      Width           =   1500
   End
   Begin VB.ComboBox cmbBANCE 
      BackColor       =   &H00800000&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   315
      ItemData        =   "Baccorrespon.frx":030A
      Left            =   2130
      List            =   "Baccorrespon.frx":0314
      Style           =   2  'Dropdown List
      TabIndex        =   11
      TabStop         =   0   'False
      Top             =   3510
      Visible         =   0   'False
      Width           =   1500
   End
   Begin VB.TextBox txtgrilla3 
      BackColor       =   &H00800000&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000E&
      Height          =   315
      Left            =   3630
      MaxLength       =   30
      TabIndex        =   9
      TabStop         =   0   'False
      Top             =   2565
      Visible         =   0   'False
      Width           =   1500
   End
   Begin VB.TextBox txtgrilla4 
      BackColor       =   &H00800000&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000E&
      Height          =   315
      Left            =   3630
      MaxLength       =   10
      TabIndex        =   10
      TabStop         =   0   'False
      Top             =   3195
      Visible         =   0   'False
      Width           =   1500
   End
   Begin VB.TextBox Text1 
      Height          =   315
      Left            =   3630
      TabIndex        =   17
      TabStop         =   0   'False
      Top             =   3510
      Visible         =   0   'False
      Width           =   1500
   End
   Begin MSFlexGridLib.MSFlexGrid Grid 
      Height          =   9960
      Left            =   45
      TabIndex        =   5
      Top             =   1170
      Width           =   15165
      _ExtentX        =   26749
      _ExtentY        =   17568
      _Version        =   393216
      Rows            =   3
      FixedRows       =   2
      FixedCols       =   0
      BackColor       =   -2147483638
      ForeColor       =   8388608
      BackColorFixed  =   8421376
      ForeColorFixed  =   -2147483634
      BackColorSel    =   8388608
      BackColorBkg    =   12632256
      GridColor       =   0
      FocusRect       =   0
      GridLines       =   2
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   15
      Top             =   0
      Width           =   15315
      _ExtentX        =   27014
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.ToolTipText     =   "Grabar"
            Object.Tag             =   "2"
            ImageIndex      =   1
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   1
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
            EndProperty
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   2
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   1
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
            EndProperty
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.ToolTipText     =   "Eliminar"
            Object.Tag             =   "3"
            ImageIndex      =   3
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   1
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
            EndProperty
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.ToolTipText     =   "Limpia"
            Object.Tag             =   "4"
            ImageIndex      =   4
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   1
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
            EndProperty
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            Object.Tag             =   "5"
            ImageIndex      =   5
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   8
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
               BeginProperty ButtonMenu2 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
               BeginProperty ButtonMenu3 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
               BeginProperty ButtonMenu4 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
               BeginProperty ButtonMenu5 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
               BeginProperty ButtonMenu6 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
               BeginProperty ButtonMenu7 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
               BeginProperty ButtonMenu8 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
            EndProperty
         EndProperty
      EndProperty
      BorderStyle     =   1
      MouseIcon       =   "Baccorrespon.frx":0320
      OLEDropMode     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   3600
         Top             =   -45
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
               Picture         =   "Baccorrespon.frx":063A
               Key             =   "Guardar"
               Object.Tag             =   "1"
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Baccorrespon.frx":0A8C
               Key             =   "Buscar"
               Object.Tag             =   "2"
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Baccorrespon.frx":0EDE
               Key             =   "Eliminar"
               Object.Tag             =   "3"
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Baccorrespon.frx":1330
               Key             =   "Limpiar"
               Object.Tag             =   "4"
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Baccorrespon.frx":164A
               Key             =   "Ayuda"
               Object.Tag             =   "6"
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Baccorrespon.frx":1964
               Key             =   ""
            EndProperty
         EndProperty
      End
      Begin VB.Label Label3 
         Caption         =   "Label3"
         Height          =   135
         Left            =   3960
         TabIndex        =   12
         Top             =   240
         Width           =   15
      End
   End
   Begin VB.Frame Frame1 
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
      Height          =   675
      Left            =   15
      TabIndex        =   0
      Top             =   435
      Width           =   15240
      Begin Threed.SSPanel SSPanel2 
         Height          =   420
         Left            =   3105
         TabIndex        =   22
         Top             =   195
         Width           =   2055
         _Version        =   65536
         _ExtentX        =   3625
         _ExtentY        =   741
         _StockProps     =   15
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Begin BACControles.TXTNumero txtCodigo 
            Height          =   315
            Left            =   780
            TabIndex        =   3
            Top             =   30
            Width           =   1095
            _ExtentX        =   1931
            _ExtentY        =   556
            Enabled         =   -1  'True
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Text            =   "0"
            Text            =   "0"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin VB.Label Label5 
            AutoSize        =   -1  'True
            Caption         =   "Codigo"
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
            Left            =   60
            TabIndex        =   23
            Top             =   75
            Width           =   600
         End
      End
      Begin Threed.SSPanel SSPanel3 
         Height          =   420
         Left            =   5160
         TabIndex        =   24
         Top             =   195
         Width           =   10050
         _Version        =   65536
         _ExtentX        =   17727
         _ExtentY        =   741
         _StockProps     =   15
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Begin VB.TextBox txtnombre 
            BeginProperty Font 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   330
            Left            =   810
            TabIndex        =   30
            Top             =   30
            Width           =   9180
         End
         Begin VB.Label Label6 
            Caption         =   "Nombre"
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
            Height          =   255
            Left            =   60
            TabIndex        =   25
            Top             =   75
            Width           =   840
         End
      End
      Begin Threed.SSPanel SSPanel1 
         Height          =   420
         Left            =   60
         TabIndex        =   20
         Top             =   195
         Width           =   3045
         _Version        =   65536
         _ExtentX        =   5371
         _ExtentY        =   741
         _StockProps     =   15
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Begin BACControles.TXTNumero txtrut 
            Height          =   300
            Left            =   975
            TabIndex        =   1
            Top             =   45
            Width           =   1455
            _ExtentX        =   2566
            _ExtentY        =   529
            Enabled         =   -1  'True
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Text            =   "0"
            Text            =   "0"
            Separator       =   -1  'True
            MarcaTexto      =   -1  'True
         End
         Begin VB.TextBox txtDigVer 
            BeginProperty Font 
               Name            =   "Tahoma"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   300
            Left            =   2625
            TabIndex        =   2
            Top             =   45
            Width           =   255
         End
         Begin VB.Label Label7 
            AutoSize        =   -1  'True
            Caption         =   "-"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   13.5
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   360
            Left            =   2490
            TabIndex        =   4
            Top             =   -30
            Width           =   120
         End
         Begin VB.Label Label4 
            AutoSize        =   -1  'True
            Caption         =   "Rut"
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
            Left            =   150
            TabIndex        =   21
            Top             =   90
            Width           =   315
         End
      End
      Begin VB.Label Label1 
         Caption         =   "Rut"
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
         Height          =   330
         Left            =   165
         TabIndex        =   16
         Top             =   285
         Width           =   705
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Codigo"
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
         Height          =   195
         Left            =   4665
         TabIndex        =   13
         Top             =   360
         Width           =   600
      End
   End
   Begin VB.Frame Frame2 
      Height          =   10185
      Left            =   15
      TabIndex        =   14
      Top             =   1020
      Width           =   15240
   End
End
Attribute VB_Name = "Baccorrespon"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public BUS
Public pais
Public Escape
Public paisactivo
Public SWGRA
Dim colpress As Long
Dim rowpress, Cont As Long
Dim inicio, i, SW2, CmbKey As Integer

 Private Sub BUSCAR()
  
  Dim Datos(), datos1()
  Dim i As Integer
  Dim Sw As Integer
  Dim sql As String
  
   var1 = CDbl(txtRut.Text)
   VAR2 = CDbl(txtCodigo.Text)

   Sw = 0
     
   Toolbar1.Buttons(2).Enabled = False
   txtCodigo.BackColor = &H8000000E
   txtCodigo.ForeColor = &H80000008
   txtRut.Enabled = False
   txtCodigo.Enabled = False
   txtNombre.Enabled = False
     
   Call cargar_grilla
   
   Grid.Enabled = True
   Grid.AddItem ("")
   Grid.TextMatrix(Grid.Row, 8) = "NO"
   Grid.TextMatrix(Grid.Row, 9) = Date
   Grid.RowHeight(2) = 315
   Grid.Row = 2
    
   Envia = Array(CDbl(var1), CDbl(VAR2))
      
   If Bac_Sql_Execute("SP_CORRESPONSALES_BUSCAR ", Envia) And Sw = 0 Then
     
     i = 2
     Grid.Enabled = True
     
     Do While Bac_SQL_Fetch(Datos())
        
         Sw = 1
         Grid.Rows = i + 1
         Grid.RowHeight(Grid.Rows - 1) = 315
         Grid.RowHeight(i) = 315
         txtNombre.Text = Datos(13)
         Grid.TextMatrix(i, 1) = Datos(10) + Space(50) + Datos(1)  ' moneda
         Grid.TextMatrix(i, 2) = Datos(11) + Space(50) + Datos(2)  ' pais
         Grid.TextMatrix(i, 3) = Datos(12) + Space(50) + Datos(3)  ' plaza
         Grid.TextMatrix(i, 4) = Datos(4)       ' codigo swift
         Grid.TextMatrix(i, 5) = Datos(5)       ' nombre
         Grid.TextMatrix(i, 6) = Datos(6)       ' cta cte
         Grid.TextMatrix(i, 7) = Datos(7)       ' oculto  swift santiago
         Grid.TextMatrix(i, 8) = Datos(8)       ' oculto  banco central
         Grid.TextMatrix(i, 9) = Datos(9)       ' oculto  fecha vencimiento
         Grid.TextMatrix(i, 10) = Datos(15)     ' Código contable
         Grid.TextMatrix(i, 11) = Datos(16)     ' Oculto correlativo corresponsal
         Grid.TextMatrix(i, 12) = "0" & Datos(14)     ' Código Corresponsal
         Grid.TextMatrix(i, 13) = Datos(17)     ' Rut Corresponsal
         
         i = i + 1
        
         Toolbar1.Buttons(3).Enabled = True
         
      Loop
                 
  End If

 If Sw = 0 Then
     
     If BUS = 1 Then
      SWGRA = 1
      txtRut.Enabled = False
      txtCodigo.Enabled = False
      txtNombre.Enabled = False
      'Grid.AddItem ("")
      Grid.Row = Grid.FixedRows
      Grid.Row = 2
      Grid.RowHeight(2) = 315
      Grid.Enabled = True
      Grid.Col = 1
      Grid.SetFocus
     
     Else
      
     
        Dim f As Integer
        f = MsgBox("Cliente No Registrado,¿Desea Consultar Ayuda? ", vbOKCancel, TITSISTEMA)
      

        If f = 1 Then
         
         Call llamarayuda
         SWGRA = 1
        Else
          
          Call Limpiar
          txtRut.Enabled = True
          txtRut.SetFocus
          txtCodigo.Enabled = False
                  
        End If
        
    End If
           
     
  Else
      SWGRA = 2
     
      Grid.Col = 1
      Grid.Row = Grid.FixedRows
      Grid.SetFocus
      Toolbar1.Buttons(4).Enabled = True
      
      
  End If
  
If KeyCode = 46 Then
  Toolbar1.Buttons(2).Enabled = True
  Call Eliminar
End If

End Sub
Sub cargar_grilla()
    
    Sw = 0
    Grid.Clear
    Grid.Rows = 3
    Grid.Cols = 14
    Grid.FixedRows = 2
    Grid.FixedCols = 0
    Grid.TextMatrix(0, 1) = "Moneda"
    Grid.TextMatrix(0, 2) = "Pais"
    Grid.TextMatrix(0, 3) = "Plaza "
    Grid.TextMatrix(0, 4) = "Codigo"
    Grid.TextMatrix(1, 4) = "Swift"
    Grid.TextMatrix(0, 5) = "Nombre"
    Grid.TextMatrix(0, 6) = "Cuenta "
    Grid.TextMatrix(1, 6) = "Corriente "
    Grid.TextMatrix(0, 7) = "Swift"
    Grid.TextMatrix(1, 7) = "Santiago"
    Grid.TextMatrix(0, 8) = "Banco"
    Grid.TextMatrix(1, 8) = "Central"
    Grid.TextMatrix(0, 9) = "Fecha"
    Grid.TextMatrix(1, 9) = "Venci."
    Grid.TextMatrix(0, 10) = "Codigo"
    Grid.TextMatrix(1, 10) = "Contable"
    Grid.TextMatrix(1, 11) = "Correlativo Corresponsal"
    Grid.TextMatrix(0, 12) = "Codigo"
    Grid.TextMatrix(1, 12) = "Corresponsal"
    Grid.TextMatrix(1, 13) = "Rut Corresponsal"
          
    Grid.ColWidth(0) = 0
    
    Grid.ColWidth(1) = 1000
    Grid.ColWidth(2) = 2200
    Grid.ColWidth(3) = 1300
    Grid.ColWidth(4) = 1300
    Grid.ColWidth(5) = 2500
    Grid.ColWidth(6) = 1300
    Grid.ColWidth(7) = 0 '1300
    Grid.ColWidth(8) = 0
    Grid.ColWidth(9) = 0
    Grid.ColWidth(10) = 1000
    Grid.ColWidth(11) = 0
    Grid.ColWidth(12) = 1300
    Grid.ColWidth(13) = 0
    
    For m = 0 To Grid.Rows - 2
        Grid.RowHeight(m) = 227
    Next m
    
    For m = 0 To Grid.Rows - 1
        For mm = 0 To Grid.Cols - 1
            Grid.Col = mm
            Grid.Row = m
            Grid.CellFontBold = True
            Grid.GridLinesFixed = flexGridNone
        Next mm
   Next m
   
   Grid.CellFontBold = False
   Grid.Rows = Grid.Rows - 1
   
   If Grid.Rows > 2 Then
      Grid.Col = 0
      Grid.ColSel = Grid.Cols - 1
   Else
      Grid.Col = 0
      Grid.ColSel = 0
   End If
   
   Grid.Enabled = False
   Grid.Font.Name = "Tahoma"
   Grid.Font.Size = 8
 
End Sub

Private Sub Cmb_Moneda_Click()
   
    cmb_Moneda_KeyPress 13
    CmbKey = 0

End Sub

Private Sub cmb_Moneda_GotFocus()
    cmb_pais.Visible = False
    cmb_plaza.Visible = False
    cmbBANCE.Visible = False
    TXTFecha1.Visible = False
    TXTGRILLA.Visible = False
    txtgrilla2.Visible = False
    txtgrilla3.Visible = False
    txtgrilla4.Visible = False

End Sub

Private Sub cmb_Moneda_KeyDown(KeyCode As Integer, Shift As Integer)
   CmbKey = KeyCode

End Sub

Private Sub cmb_Moneda_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 And cmb_moneda <> "" Then
       
       Dim Ind, Sub_ind As Integer
       Dim Busq As String
         
       Text1.Text = ""
       Text1.Text = cmb_moneda
       Busq = Text1.Text
      
       If Grid.Rows > 3 Then
              
              Grid.Text = Busq
              
              If Verifica_Existencia(Mid(Grid.TextMatrix(Grid.Row, 1), 1, 50), Mid(Grid.TextMatrix(Grid.Row, 2), 1, 50), Mid(Grid.TextMatrix(Grid.Row, 3), 1, 50), Mid(Grid.TextMatrix(Grid.Row, 4), 1, 50)) Then
                    
                    MsgBox "Moneda No se Puede Repetir", vbCritical, TITSISTEMA
                    cmb_Moneda_KeyPress (27)
                    Exit Sub
                    
              Else
                    cmb_moneda.Tag = cmb_moneda.Text
              
              End If
    
       End If
        
    End If


    If KeyAscii = 27 Then
         
         cmb_moneda.Visible = False
         Grid.Text = cmb_moneda.Tag
         'Grid.Col = 2
         Grid.SetFocus
    
    End If
    
    If KeyAscii = 13 Then
    On Error GoTo fin
        'cmb_Moneda.Tag = Grid.Text
        Grid.Text = cmb_moneda.Text
        cmb_moneda.Visible = False
        Grid.SetFocus
    
    End If
    
fin:
End Sub


Private Sub cmb_Moneda_LostFocus()

    If cmb_moneda.Visible = True Then
        
        'Grid.Text = cmb_Moneda.Tag
        cmb_moneda.Visible = False
    
    End If
    
End Sub

Private Sub cmb_pais_Click()

    cmb_pais_KeyPress (13)
    CmbKey = 0

End Sub

Private Sub cmb_pais_GotFocus()

    paisactivo = 1
    
    pais = 0
    Escape = 0
    cmb_moneda.Visible = False
    cmb_plaza.Visible = False
    cmbBANCE.Visible = False
    TXTFecha1.Visible = False
    TXTGRILLA.Visible = False
    txtgrilla2.Visible = False
    txtgrilla3.Visible = False
    txtgrilla4.Visible = False
    TextCodCont.Visible = False
    TextCodCorr.Visible = False

End Sub

Private Sub cmb_pais_KeyDown(KeyCode As Integer, Shift As Integer)

   CmbKey = KeyCode

End Sub

Private Sub cmb_pais_KeyPress(KeyAscii As Integer)

If KeyAscii = 13 And cmb_pais <> "" Then

  Dim Ind1, Sub_ind1 As Integer

  Dim Busq1 As String
     
   Grid.TextMatrix(Grid.Row, Grid.Col + 1) = ""
   Text1.Text = ""
   Text1.Text = cmb_pais
   Busq1 = Text1.Text
   Grid.Text = ""
   If Grid.Rows > 3 Then
        
          Cont = 1
            
          Grid.Text = Busq1
        
          If Verifica_Existencia(Mid(Grid.TextMatrix(Grid.Row, 1), 1, 50), Mid(Grid.TextMatrix(Grid.Row, 2), 1, 50), Mid(Grid.TextMatrix(Grid.Row, 3), 1, 50), Mid(Grid.TextMatrix(Grid.Row, 4), 1, 50)) Then
                
                MsgBox "Pais No se Puede Repetir", vbCritical, TITSISTEMA
                cmb_pais_KeyPress (27)
                
                Exit Sub

          End If
                
   End If

         'cmb_pais.Visible = False
         Grid.Text = cmb_pais + Space(50) + Trim(Right(cmb_pais.Text, 50))
            
         If Bac_Sql_Execute("SP_CORRESPONSALES_CMBPLAZA") Then
         
            cmb_plaza.Clear
            
            Do While Bac_SQL_Fetch(Datos())
             
             If Trim(Right(Grid.TextMatrix(Grid.Row, Grid.Col), 50)) = Datos(3) Then 'cmb_pais.ItemData(cmb_pais.ListIndex) = datos(3)
                
                cmb_plaza.AddItem Datos(2) + Space(50) + Datos(1)
                cmb_plaza.ItemData(cmb_plaza.NewIndex) = Datos(1)
                
             End If
            
            Loop
          
          End If
        
End If

If KeyAscii = 27 Then
  
   cmb_pais.Visible = False
   Grid.SetFocus
 
End If

If KeyAscii = 13 Then

    If Grid.Col = 2 Or Grid.Col = 3 Then
        
        If cmb_plaza.ListCount = 0 And Escape <> 1 Then
          
          MsgBox "Pais No contiene Plazas,Seleccione otro Pais", vbExclamation, TITSISTEMA
           
          SW2 = 1
          pais = 1
          Grid.Col = 3
          Grid.Text = ""
    
           Grid.SetFocus

           Grid.Col = 2
           cmb_pais.Visible = True
           cmb_pais.SetFocus
        
        Else
            
           cmb_pais.Tag = Grid.Text
           Grid.Text = cmb_pais.Text
           cmb_pais.Visible = False
           Grid.SetFocus
            
        End If
    
    End If


End If

End Sub

Private Sub cmb_pais_LostFocus()
  
If cmb_pais.Visible = True Then
   
   cmb_pais.Visible = False
   Grid.Col = 2
   Grid.Text = cmb_pais.Tag
   Grid.SetFocus

End If

End Sub

Private Sub cmb_plaza_Click()

    cmb_plaza_KeyPress (13)
    
    CmbKey = 0

End Sub

Private Sub cmb_plaza_GotFocus()
     
    If Grid.Col = 2 And Grid.Text = "" And cmb_plaza.ListCount = 0 Then
         
       MsgBox "Se Requiere de un Pais ", vbInformation, TITSISTEMA
       Grid.SetFocus
       cmb_plaza.Visible = False
   
    End If
    
    cmb_pais.Visible = False
    cmb_moneda.Visible = False
    cmbBANCE.Visible = False
    TXTFecha1.Visible = False
    TXTGRILLA.Visible = False
    txtgrilla2.Visible = False
    txtgrilla3.Visible = False
    txtgrilla4.Visible = False
    TextCodCont.Visible = False
    TextCodCorr.Visible = False

End Sub

Private Sub cmb_plaza_KeyDown(KeyCode As Integer, Shift As Integer)

   CmbKey = KeyCode
   CmbKey = 0

End Sub

Private Sub cmb_plaza_KeyPress(KeyAscii As Integer)
 
    If KeyAscii = 27 Then
       
       cmb_plaza.Visible = False
       Grid.Text = ""
       Grid.SetFocus
    
    End If

   If KeyAscii = 13 Then
        
        Grid.Text = cmb_plaza.Text
        
        If Verifica_Existencia(Mid(Grid.TextMatrix(Grid.Row, 1), 1, 50), Mid(Grid.TextMatrix(Grid.Row, 2), 1, 50), Mid(Grid.TextMatrix(Grid.Row, 3), 1, 50), Mid(Grid.TextMatrix(Grid.Row, 4), 1, 50)) Then

            MsgBox "No se puede repetir la plaza", vbExclamation, TITSISTEMA
            cmb_plaza_KeyPress (27)
            
        Else
            
            cmb_plaza.Tag = Grid.Text
            cmb_plaza.Visible = False
            Grid.Text = cmb_plaza + Space(50) + Trim(Right(cmb_plaza.Text, 50))
            Grid.SetFocus
       
        End If

        Grid.SetFocus
    
    End If
 
End Sub


Private Sub cmb_plaza_LostFocus()

    If cmb_plaza.Visible = True Then
        cmb_plaza.Visible = False
    
    End If

End Sub

Private Sub cmbBANCE_Click()

    cmbBANCE_KeyPress (13)
    CmbKey = 0

End Sub

Private Sub cmbBANCE_GotFocus()

    cmb_pais.Visible = False
    cmb_plaza.Visible = False
    cmb_moneda.Visible = False
    TXTFecha1.Visible = False
    TXTGRILLA.Visible = False
    txtgrilla2.Visible = False
    txtgrilla3.Visible = False
    txtgrilla4.Visible = False
    TextCodCont.Visible = False
    TextCodCorr.Visible = False

End Sub

Private Sub cmbBANCE_KeyDown(KeyCode As Integer, Shift As Integer)

   CmbKey = KeyCode

End Sub

Private Sub cmbBANCE_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 And cmbBANCE <> "" Then
       
       Grid.Col = 8
       cmbBANCE.Tag = Grid.Text
       cmbBANCE.Visible = False
       Grid.Text = cmbBANCE
       Grid.SetFocus
    
    End If

   If KeyAscii = 27 And Grid.Col = 8 Then
        
        Grid.Col = 8
        Grid.Text = cmbBANCE.Tag
        cmbBANCE.Visible = False
        Grid.Text = cmbBANCE
        'Grid.Col = 7
        Grid.SetFocus
 
   End If
End Sub


Private Sub cmbBANCE_LostFocus()

    If cmbBANCE.Visible = True Then

        'Grid.Col = 8
        'Grid.Text = cmbBANCE.Tag
        cmbBANCE.Visible = False
        Grid.SetFocus
    
    End If


End Sub

Private Sub Grid_EnterCell()
 
 
If Grid.Col = 3 Then
 
  cmb_plaza.Clear
  'If KeyCode <> 13 Then
 
     If Bac_Sql_Execute("SP_CORRESPONSALES_CMBPLAZA") Then
        
        Do While Bac_SQL_Fetch(Datos())
         
         If Trim(Right(Grid.TextMatrix(Grid.Row, Grid.Col - 1), 50)) = Datos(3) Then 'cmb_pais.ItemData(cmb_pais.ListIndex) = datos(3)
            
            cmb_plaza.AddItem Datos(2) + Space(50) + Datos(1)
            cmb_plaza.ItemData(cmb_plaza.NewIndex) = Datos(1)
            
         End If
        
        Loop
      
      End If
 
End If
 
End Sub

Private Sub GRID_DblClick()

    Toolbar1.Buttons(1).Enabled = True

    If Grid.Col = 1 Then
         'cmb_Moneda.Height = Grid.CellHeight
         cmb_moneda.Top = Grid.CellTop + Grid.Top
         cmb_moneda.Left = Grid.CellLeft + Grid.Left + 20
         cmb_moneda.Width = Grid.CellWidth - 20
         cmb_moneda.Visible = True
         cmb_moneda.SetFocus
    End If
   If Grid.Col = 2 Then
        'cmb_pais.Height = Grid.CellHeight
         cmb_pais.Top = Grid.CellTop + Grid.Top
         cmb_pais.Left = Grid.CellLeft + Grid.Left + 20
         cmb_pais.Width = Grid.CellWidth - 20
         cmb_pais.Visible = True
         cmb_pais.SetFocus
   End If
    If Grid.Col = 3 Then
       ' cmb_plaza.Height = Grid.CellHeight
        cmb_plaza.Top = Grid.CellTop + Grid.Top
        cmb_plaza.Left = Grid.CellLeft + Grid.Left + 20
        cmb_plaza.Width = Grid.CellWidth - 20
        cmb_plaza.Visible = True
        cmb_plaza.SetFocus
    End If
   If Grid.Col = 4 Then
         TXTGRILLA.Height = Grid.CellHeight
         TXTGRILLA.Top = Grid.CellTop + Grid.Top
         TXTGRILLA.Left = Grid.CellLeft + Grid.Left + 20
         TXTGRILLA.Width = Grid.CellWidth - 20
         TXTGRILLA.Visible = True
         TXTGRILLA.SetFocus

   End If
   If Grid.Col = 5 Then
        txtgrilla2.Height = Grid.CellHeight
         txtgrilla2.Top = Grid.CellTop + Grid.Top
         txtgrilla2.Left = Grid.CellLeft + Grid.Left + 20
         txtgrilla2.Width = Grid.CellWidth - 20
         txtgrilla2.Visible = True
         txtgrilla2.SetFocus

   End If
      If Grid.Col = 6 Then
         txtgrilla3.Height = Grid.CellHeight
         txtgrilla3.Top = Grid.CellTop + Grid.Top
         txtgrilla3.Left = Grid.CellLeft + Grid.Left + 20
         txtgrilla3.Width = Grid.CellWidth - 20
         txtgrilla3.Visible = True
         txtgrilla3.SetFocus

    End If


  If Grid.Col = 10 Then
  TextCodCont.Height = Grid.CellHeight
  TextCodCont.Top = Grid.CellTop + Grid.Top
  TextCodCont.Left = Grid.CellLeft + Grid.Left + 20
  TextCodCont.Width = Grid.CellWidth - 20
  TextCodCont.Visible = True
  TextCodCont.SetFocus
  End If

  If Grid.Col = 12 Then
  TextCodCorr.Height = Grid.CellHeight
  TextCodCorr.Top = Grid.CellTop + Grid.Top
  TextCodCorr.Left = Grid.CellLeft + Grid.Left + 20
  TextCodCorr.Width = Grid.CellWidth - 20
  TextCodCorr.Visible = True
  TextCodCorr.SetFocus
  End If

End Sub

Private Sub Grid_GotFocus()
    
    Toolbar1.Buttons(4).Enabled = True
    Toolbar1.Buttons(2).Enabled = False
    
End Sub

Private Sub Grid_KeyUp(KeyCode As Integer, Shift As Integer)
On Error GoTo ErrorF:
    If inicio = 1 Then
    
        Grid.Col = colpress
        Grid.Row = rowpress
        Grid.ColSel = colpress

    End If

    inicio = 1
ErrorF:
End Sub

Private Sub Grid_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)

    If inicio = 1 Then
    
        colpress = Grid.Col
        rowpress = Grid.Row
        Grid.ColSel = colpress
    
    End If

End Sub

Private Sub Grid_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
On Error GoTo fin:
    If inicio = 1 Then
    
        Grid.Col = colpress
        Grid.Row = rowpress
        Grid.ColSel = colpress
    
    End If
    
    inicio = 1
    
fin:
End Sub

Private Sub Grid_Scroll()
    
    cmb_moneda.Visible = False
    cmb_pais.Visible = False
    cmb_plaza.Visible = False
    cmbBANCE.Visible = False
    TXTFecha1.Visible = False
    TXTGRILLA.Visible = False
    txtgrilla2.Visible = False
    txtgrilla3.Visible = False
    txtgrilla4.Visible = False
    TextCodCont.Visible = False
    TextCodCorr.Visible = False
End Sub

Private Sub TextCodCont_GotFocus()
If Grid.Text <> "" Then
  TextCodCont.Text = Grid.Text
End If
 cmb_pais.Visible = False
 cmb_plaza.Visible = False
 cmbBANCE.Visible = False
 TXTFecha1.Visible = False
 TXTGRILLA.Visible = False
 txtgrilla2.Visible = False
 txtgrilla3.Visible = False
 cmb_moneda.Visible = False
 TextCodCorr.Visible = False
End Sub

Private Sub TextCodCont_KeyPress(KeyAscii As Integer)
If KeyAscii = 45 Then
      If Campos_Blancos = 0 Then
        Grid.Col = 1
        Grid.SetFocus
        Grid.AddItem ("")
        Grid.RowHeight(Grid.Rows - 1) = 315 'Grid.Rows - 1
        Grid.SetFocus
      Else
        MsgBox "Debe Insertar Datos Antes de Insertar una Nueva Fila", vbOKOnly, TITSISTEMA
        Grid.SetFocus
      End If
Else
  
 If KeyAscii = 27 Then
    Grid.Col = 10
    TextCodCont.Visible = False
    Grid.SetFocus
 End If
      
 If KeyAscii = 13 And Grid.Col = 10 Then
 '  Grid.Col = 10
   TextCodCont.Visible = False
   Grid.Text = TextCodCont.Text
   TextCodCont.Tag = Grid.Text
   Grid.Text = TextCodCont.Text
   Grid.SetFocus
 End If
 
 End If

End Sub

Private Sub TextCodCont_LostFocus()
 If TextCodCont.Visible = True Then
    TextCodCont.Visible = False
    Grid.SetFocus
 End If
End Sub


Private Sub TextCodCorr_GotFocus()
If Grid.Text <> "" Then
  TextCodCorr.Text = Grid.Text
End If
 cmb_pais.Visible = False
 cmb_plaza.Visible = False
 cmbBANCE.Visible = False
 TXTFecha1.Visible = False
 TXTGRILLA.Visible = False
 txtgrilla2.Visible = False
 txtgrilla3.Visible = False
 cmb_moneda.Visible = False
 TextCodCont.Visible = False
End Sub

Private Sub TextCodCorr_KeyPress(KeyAscii As Integer)
If KeyAscii = 45 Then
      If Campos_Blancos = 0 Then
        Grid.Col = 1
        Grid.SetFocus
        Grid.AddItem ("")
        Grid.RowHeight(Grid.Rows - 1) = 315 'Grid.Rows - 1
        Grid.SetFocus
      Else
        MsgBox "Debe Insertar Datos Antes de Insertar una Nueva Fila", vbOKOnly, TITSISTEMA
        Grid.SetFocus
      End If
Else
  
 If KeyAscii = 27 Then
    Grid.Col = 10
    TextCodCorr.Visible = False
    Grid.SetFocus
 End If
      
 If KeyAscii = 13 And Grid.Col = 12 Then
 '  Grid.Col = 10
   TextCodCorr.Visible = False
   Grid.Text = TextCodCorr.Text
   TextCodCorr.Tag = Grid.Text
   Grid.Text = TextCodCorr.Text
   Grid.SetFocus
 End If
 
 End If


End Sub

Private Sub TextCodCorr_LostFocus()
 If TextCodCorr.Visible = True Then
    TextCodCorr.Visible = False
    Grid.SetFocus
 End If
End Sub

Private Sub txtcodigo_GotFocus()

    txtCodigo.BackColor = &H8000000D
    txtCodigo.ForeColor = &H8000000E

End Sub

Private Sub txtCodigo_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = 13 And txtCodigo.Text <> "0" Then
    
   Call BUSCAR
   txtNombre.Enabled = False
  
End If
End Sub

Private Sub txtCodigo_KeyPress(KeyAscii As Integer)
  If KeyCode = 13 Then
    SendKeys "{tab}"
  End If
End Sub

Private Sub TxtCodigo_LostFocus()

    txtCodigo.BackColor = &H8000000E
    txtCodigo.ForeColor = &H80000008

End Sub


Private Sub txtDigVer_KeyPress(KeyAscii As Integer)
  If KeyAscii = 13 Then
     If KeyAscii = 13 And txtRut.Text <> "0" Then
        txtCodigo.Enabled = True
        SendKeys "{tab}"
     End If
  End If
End Sub


Private Sub txtFecha1_Change()

          On Error GoTo fin:
          Grid.Col = 9
          TXTFecha1.Tag = Grid.Text
          Grid.Text = TXTFecha1.Text
                   
          Cont = 0

          If Format(Grid.Text, "yyyy") > Format(Date, "yyyy") Then Cont = 1
          If Format(Grid.Text, "yyyy") = Format(Date, "yyyy") And Format(Grid.Text, "mm") = Format(Date, "mm") And Format(Grid.Text, "dd") >= Format(Date, "dd") Then Cont = 1
          If Format(Grid.Text, "yyyy") = Format(Date, "yyyy") And Format(Grid.Text, "mm") > Format(Date, "mm") Then Cont = 1
          
          If Cont = 0 Then
                
                Grid.Text = TXTFecha1.Tag
                TXTFecha1.Text = TXTFecha1.Tag
                
          End If
 

 
fin:


End Sub

Private Sub txtFecha1_GotFocus()

    If Grid.Text <> "" Then
    
        TXTFecha1.Text = Grid.Text
    
    End If
    
    
    TXTFecha1.BackColor = &H8000000D
    TXTFecha1.ForeColor = &H8000000E
    
    cmb_pais.Visible = False
    cmb_plaza.Visible = False
    cmbBANCE.Visible = False
    cmb_moneda.Visible = False
    TXTGRILLA.Visible = False
    txtgrilla2.Visible = False
    txtgrilla3.Visible = False
    txtgrilla4.Visible = False
    TextCodCont.Visible = False
    TextCodCorr.Visible = False

End Sub

Private Sub txtFecha1_KeyPress(KeyAscii As Integer)

If KeyAscii = 45 Then
      If Campos_Blancos = 0 Then
        Grid.Col = 1
        Grid.SetFocus
        Grid.AddItem ("")
        Grid.RowHeight(Grid.Rows - 1) = 315 'Grid.Rows - 1
        Grid.SetFocus
      Else
        MsgBox "Debe Insertar Datos Antes de Insertar una Nueva Fila", vbOKOnly, TITSISTEMA
        Grid.SetFocus
      End If
Else
  
      If KeyAscii = 27 And Grid.Col = 9 Then
           Grid.Col = 9
             TXTFecha1.Visible = False
             Grid.SetFocus
           
                          
      End If
      If KeyAscii = 13 Then
      On Error GoTo fin:
          Grid.Col = 9
          TXTFecha1.Tag = Grid.Text
          TXTFecha1.Visible = False
          Grid.Text = TXTFecha1.Text
          Grid.SetFocus
            
          Cont = 0

          If Format(Grid.Text, "yyyy") > Format(Date, "yyyy") Then Cont = 1
          If Format(Grid.Text, "yyyy") = Format(Date, "yyyy") And Format(Grid.Text, "mm") = Format(Date, "mm") And Format(Grid.Text, "dd") >= Format(Date, "dd") Then Cont = 1
          If Format(Grid.Text, "yyyy") = Format(Date, "yyyy") And Format(Grid.Text, "mm") > Format(Date, "mm") Then Cont = 1
            
          If Cont <> 1 Then
              MsgBox "Error Fecha de Vencimiento Debe ser Mayor o Igual a la Fecha Actual", vbInformation, TITSISTEMA
              TXTFecha1.Visible = True
              Grid.Text = TXTFecha1.Tag
              TXTFecha1.SetFocus
            
          End If
          
       End If
  
 End If

 
fin:
End Sub

Private Sub txtFecha1_LostFocus()

    TXTFecha1.BackColor = &H8000000E
    TXTFecha1.ForeColor = &H80000008
    
    TXTFecha1.Text = Grid.TextMatrix(Grid.Row, 9)
    
    If TXTFecha1.Visible = True Then
    
        TXTFecha1.Visible = False
        Grid.SetFocus
        
    End If
    

End Sub

Private Sub TXTGRILLA_GotFocus()

    If Grid.Text <> "" Then
    
        TXTGRILLA.Text = Grid.Text
    
    End If
    cmb_pais.Visible = False
    cmb_plaza.Visible = False
    cmbBANCE.Visible = False
    TXTFecha1.Visible = False
    cmb_moneda.Visible = False
    txtgrilla2.Visible = False
    txtgrilla3.Visible = False
    txtgrilla4.Visible = False
    TextCodCont.Visible = False
    TextCodCorr.Visible = False

End Sub

Private Sub TxtGrilla_LostFocus()
       
If TXTGRILLA.Visible = True Then

       TXTGRILLA.Visible = False
       TXTGRILLA.Tag = TXTGRILLA.Text
  
      'Grid.Col = 5
      Grid.SetFocus

End If

End Sub

Private Sub txtgrilla2_GotFocus()

    If Grid.Text <> "" Then
        
        txtgrilla2.Text = Grid.Text
    
    End If
    
    cmb_pais.Visible = False
    cmb_plaza.Visible = False
    cmbBANCE.Visible = False
    TXTFecha1.Visible = False
    TXTGRILLA.Visible = False
    cmb_moneda.Visible = False
    txtgrilla3.Visible = False
    txtgrilla4.Visible = False
    TextCodCont.Visible = False
    TextCodCorr.Visible = False

End Sub

Private Sub txtgrilla2_LostFocus()
 
  If txtgrilla2.Visible = True Then
        
        txtgrilla2.Visible = False
        'Grid.Col = 6
        Grid.SetFocus
        
  End If

End Sub

Private Sub txtgrilla3_GotFocus()

    If Grid.Text <> "" Then
    
        txtgrilla3.Text = Grid.Text
    
    End If
    
    cmb_pais.Visible = False
    cmb_plaza.Visible = False
    cmbBANCE.Visible = False
    TXTFecha1.Visible = False
    TXTGRILLA.Visible = False
    txtgrilla2.Visible = False
    cmb_moneda.Visible = False
    txtgrilla4.Visible = False
    TextCodCont.Visible = False
    TextCodCorr.Visible = False
End Sub

Private Sub txtgrilla3_KeyPress(KeyAscii As Integer)
Dim Char As String
Dim SW2 As Integer

KeyAscii = Asc(UCase(Chr(KeyAscii)))

Char = "'&()?¿%·*+=$<>""@!¡{}¨Ç"
SW2 = 0

For i = 1 To Len(Char)

    If Mid(Char, i, 1) = UCase(Chr(KeyAscii)) Then
        SW2 = 1
        Exit For
    End If

Next i

If SW2 = 1 Then

    KeyAscii = 0

End If


  If KeyCode = 45 Then
      
      If Campos_Blancos = 0 Then
          
          Grid.Col = 1
          Grid.SetFocus
          Grid.AddItem ("")
          Grid.RowHeight(Grid.Rows - 1) = 313 'Grid.Rows - 1
          Grid.SetFocus
     
     Else
        
        MsgBox "Debe Insertar Datos Antes de Insertar una Nueva Fila", vbOKOnly, TITSISTEMA
        Grid.SetFocus
     
     End If
 
 End If
 
        If KeyAscii = 27 Then
             
             txtgrilla3.Visible = False
             txtgrilla3.Text = ""
             txtgrilla3.Text = Grid.Text
             Grid.Text = txtgrilla3.Text
             'Grid.Col = 7
             Grid.SetFocus
         
        End If
            
  If KeyAscii = 13 And Grid.Col = 6 Then
     txtgrilla3.Visible = False
     txtgrilla3.Tag = Grid.Text
     Grid.Text = txtgrilla3.Text
           
            'Grid.Col = 7
     Grid.SetFocus
  End If

End Sub


Private Sub txtgrilla3_LostFocus()
    
    If txtgrilla3.Visible = True Then
                
        'Grid.Col = 6
        txtgrilla3.Visible = False
        'Grid.Text = txtgrilla3.Tag
        
        'Grid.Col = 7
        Grid.SetFocus
    
    End If

End Sub

Private Sub txtgrilla4_GotFocus()

   If Grid.Text <> "" Then
     txtgrilla4.Text = Grid.Text
   End If
   cmb_pais.Visible = False
   cmb_plaza.Visible = False
   cmbBANCE.Visible = False
   TXTFecha1.Visible = False
   TXTGRILLA.Visible = False
   txtgrilla2.Visible = False
   txtgrilla3.Visible = False
   cmb_moneda.Visible = False
   TextCodCont.Visible = False
   TextCodCorr.Visible = False

End Sub

Private Sub txtgrilla4_KeyPress(KeyAscii As Integer)
Dim Char As String
Dim SW2 As Integer

KeyAscii = Asc(UCase(Chr(KeyAscii)))
Char = "'/&()?¿%·*+=$<>""@!¡{}¨Ç-"
SW2 = 0

For i = 1 To Len(Char)

    If Mid(Char, i, 1) = UCase(Chr(KeyAscii)) Then

        SW2 = 1
        Exit For

    End If

Next i

If SW2 = 1 Then

    KeyAscii = 0

End If

    If KeyAscii = 45 Then
         
         If Campos_Blancos = 0 Then
              
              Grid.Col = 1
              Grid.SetFocus
              Grid.AddItem ("")
              Grid.RowHeight(Grid.Rows - 1) = 313 'Grid.Rows - 1
              Grid.SetFocus
         
         Else
            
            MsgBox "Debe Insertar Datos Antes de Insertar una Nueva Fila", vbOKOnly, TITSISTEMA
            Grid.SetFocus
         
         End If
     Else
     
        If KeyAscii = 27 Then
             
             txtgrilla4.Visible = False
             txtgrilla4.Text = ""
             txtgrilla4.Text = Grid.Text
             Grid.Text = txtgrilla4.Text
             'Grid.Col = 8
             Grid.SetFocus
        
        End If
            
        If KeyAscii = 13 And Grid.Col = 7 Then
            
             txtgrilla4.Visible = False
             Grid.Text = txtgrilla4.Text
             'Grid.Col = 8
             Grid.SetFocus
        
        End If
      
     
    End If

End Sub


Private Sub txtgrilla4_LostFocus()
 If txtgrilla4.Visible = True Then
    txtgrilla4.Visible = False
    Grid.SetFocus
 End If
End Sub

Private Sub txtNombre_GotFocus()
  txtNombre.BackColor = &H8000000D
  txtNombre.ForeColor = &H8000000E
End Sub

Private Sub txtNombre_LostFocus()

    txtNombre.BackColor = &H8000000E
    txtNombre.ForeColor = &H80000008

End Sub



Private Sub TxtRut_DblClick()
       
    BUS = 1
    Call llamarayuda
    Grid.Col = 1
End Sub
 Function llamarayuda()
  
   'BacAyuda.Tag = "MDCL_U"
   'BacAyuda.Show 1
   'Arm Se implementa nuevo formulario ayuda
   BacAyudaCliente.Tag = "MDCL_U"
   BacAyudaCliente.Show 1
   
   If giAceptar% = True Then
    
        'Toolbar1.Buttons(2).Enabled = False
        BUS = 1
        txtDigVer.Text = gsDigito
        txtRut.Text = gsCodigo
        txtCodigo.Text = gsCodCli
        txtNombre.Text = gsNombre
        Call BUSCAR
        Toolbar1.Buttons(2).Enabled = True
        Grid.Row = 2
        Grid.Col = 1
        Grid.SetFocus
        giAceptar% = False
   Else
        
        Call Limpiar
        Grid.Enabled = False
        txtRut.Enabled = True
        txtRut.SetFocus
        Grid.Row = 1
        Grid.Col = 0
        
   End If

   Grid.Col = 0
   
End Function

Private Sub txtrut_GotFocus()

    Toolbar1.Buttons(2).Enabled = True
    Toolbar1.Buttons(4).Enabled = False
    txtRut.BackColor = &H8000000D
    txtRut.ForeColor = &H8000000E

End Sub


Private Sub TxtRut_KeyDown(KeyCode As Integer, Shift As Integer)

    If KeyAscii = 13 And txtRut.Text <> "0" Then
    
         txtCodigo.Enabled = True
         txtCodigo.SetFocus
         SendKeys "{tab}"
    
       
    End If
    
    If KeyCode = vbKeyF3 Then
       
         Call llamarayuda
    
    End If
    
    If KeyCode = 27 Then
     
     Unload Baccorrespon
    
    End If

End Sub

Private Sub Form_Load()
    Me.Top = 0
    Me.Left = 0
    inicio = 0
    SWGRA = 0
    paisactivo = 0
    BUS = 0
    
    Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                          , gsbac_fecp _
                          , gsBac_IP _
                          , gsBAC_User _
                          , "PCA" _
                          , "OPC_750" _
                          , "07" _
                          , "INGRESO A OPCION DE MENU" _
                          , " " _
                          , " " _
                          , " ")
     
     Call Limpiar
     
     Call cargar_grilla
     
     Toolbar1.Buttons(2).Visible = False
     SW2 = 0
     
     
End Sub

Sub Limpiar()
        
     CmbKey = 0
        Toolbar1.Buttons(1).Enabled = False
'          Toolbar1.Buttons(2).Enabled = False
'          Toolbar1.Buttons(3).Enabled = False
'          Toolbar1.Buttons(4).Enabled = False
                    
     cmb_moneda.Visible = False
     cmb_pais.Visible = False
     cmb_plaza.Visible = False
     cmbBANCE.Visible = False
     TXTFecha1.Visible = False
     TXTGRILLA.Visible = False
     txtgrilla2.Visible = False
     txtgrilla3.Visible = False
     txtgrilla4.Visible = False
     TXTFecha1.Text = Date
     TXTGRILLA.Text = ""
     txtgrilla2.Text = ""
     txtgrilla3.Text = ""
     txtgrilla4.Text = ""
     TextCodCont.Text = ""
     TextCodCorr.Text = ""
     TextCodCorr.Visible = False
     TextCodCont.Visible = False
     Grid.Rows = 2
     Grid.Col = 0
     
     Call Correspon_Limpia
     Call Correspon_Carga_Datos


End Sub

Sub Correspon_Limpia()
     
     txtRut.Text = "0000000"
     txtDigVer.Text = ""
     txtCodigo.Text = ""
     txtNombre.Text = ""
     txtCodigo.Enabled = False
     txtNombre.Enabled = False

End Sub
Sub Correspon_Carga_Datos()
Dim Datos()

      Envia = Array(1)
     If Bac_Sql_Execute("SP_CORRESPONSALES_CMBMONEDA", Envia) Then
          
          cmb_moneda.Clear
          
          Do While Bac_SQL_Fetch(Datos())
               
               cmb_moneda.AddItem Datos(1) + Space(50) + Datos(2)
               cmb_moneda.ItemData(cmb_moneda.NewIndex) = Datos(2)
          
          Loop
          
     End If

     sql = "Sp_corresponsales_cmbpais"
     
     If Bac_Sql_Execute("SP_CORRESPONSALES_CMBPAIS") Then
          
          cmb_pais.Clear
          
          Do While Bac_SQL_Fetch(Datos())
               
               cmb_pais.AddItem Datos(1) + Space(50) + Datos(2)
               cmb_pais.ItemData(cmb_pais.NewIndex) = Datos(2)
          
          Loop
     
     End If

cmb_moneda.ListIndex = 0
'cmb_pais.ListIndex = 0

End Sub
Private Sub Grid_KeyDown(KeyCode As Integer, Shift As Integer)
Dim SW3 As Integer
Dim Y As Integer
Dim G As Integer
Dim k As Integer
Dim i As Integer

    Toolbar1.Buttons(1).Enabled = True
    
    If KeyCode = 45 Then
       
       SWGRA = 1
       TXTGRILLA.Text = ""
       txtgrilla2.Text = ""
       txtgrilla3.Text = ""
       txtgrilla4.Text = ""
     
     If Campos_Blancos = 1 Then
          
          MsgBox "Deben haber datos antes de Insertar Otra fila", vbOKOnly, TITSISTEMA
          Grid.SetFocus
        
     Else
         
         Grid.Col = 1
         Grid.SetFocus
         Grid.AddItem ("")
         Grid.TextMatrix(Grid.Row + 1, 8) = "NO"
         Grid.TextMatrix(Grid.Row + 1, 9) = Date
         Grid.RowHeight(Grid.Rows - 1) = 315 'Grid.Rows - 1
         Grid.SetFocus
     
     End If
    
    End If
    
    If KeyCode = 46 Then
        On Error GoTo Fin2:
        Cont = 0
        
        For i = 1 To Grid.Cols - 1
            
            If Grid.TextMatrix(Grid.Row, i) = "" Then
                Cont = Cont + 1
                    
            End If
            
        Next i
        
        If Cont >= 1 Then
        
            Grid.RemoveItem (Grid.Row)
            Limpia
        Else
            
            Call Eliminar
            Limpia
            Exit Sub
                   
        End If
        
    End If

    If inicio = 1 Then
    
        colpress = Grid.Col
        rowpress = Grid.Row
        Grid.ColSel = colpress
    
    End If

    Grid.SetFocus


    Exit Sub

Fin2:

    'Colpress = 1
    'Rowpress = 2
    'Grid.ColSel = Colpress
    
    For i = 1 To Grid.Cols - 1
    
        Grid.TextMatrix(Grid.Row, i) = ""
        
    Next i
    
    If Grid.Rows > 3 Then
    
        Grid.Col = 1
        Grid.Row = 2
        Grid.SetFocus
        
    Else
        
        Grid.Col = 0
        Grid.Row = 0
            
    End If
    Limpia
    
End Sub
Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Dim i            As Integer
   Dim var1         As String
   Dim Sw           As Integer
   Dim VAR2         As Integer
   Dim Datos()
   
   If TXTGRILLA.Visible = True Then
        TxtGrilla_KeyPress (13)
   End If
   If txtgrilla2.Visible = True Then
        txtgrilla2_KeyPress (13)
   End If
   If txtgrilla3.Visible = True Then
        txtgrilla3_KeyPress (13)
   End If
   If txtgrilla4.Visible = True Then
        txtgrilla4_KeyPress (13)
   End If
   If cmb_moneda.Visible = True Then
        cmb_Moneda_KeyPress (13)
   End If
   If cmb_plaza.Visible = True Then
        cmb_plaza_KeyPress (13)
   End If
   If cmb_pais.Visible = True Then
        cmb_pais_KeyPress (13)
   End If
   If cmbBANCE.Visible = True Then
        cmb_pais_KeyPress (13)
   End If
   If TXTFecha1.Visible = True Then
        txtFecha1_KeyPress (13)
   End If
   If TextCodCont.Visible = True Then
       TextCodCont_KeyPress (13)
   End If
   If TextCodCorr.Visible = True Then
       TextCodCorr_KeyPress (13)
   End If

   
    Select Case Button.Index
        Case 1
            If guardar = True Then
                Call Limpiar
                txtRut.Enabled = True
                cmb_moneda.Enabled = True
                txtRut.SetFocus
                Call Grabar_Log_AUDITORIA(giBAC_Entidad, gsbac_fecp, gsBac_IP, gsBAC_User, "PCA", "OPC_750", "01", "GRABA", " CORRESPONSAL  ", " ", " ")
            Else
                Call Grabar_Log_AUDITORIA(giBAC_Entidad, gsbac_fecp, gsBac_IP, gsBAC_User, "PCA", "OPC_750", "02", "GRABAR - Error al Grabar", "CORRESPONSAL  ", " ", " ")
            End If
       
        Case 2
            If txtRut.Text <> "0" And txtCodigo.Text <> "0" Then
                Call BUSCAR
                Grid.Row = 2
                Grid.ColSel = 0
            Else
                Call llamarayuda
            End If
      
        Case 3
            Call Eliminar
            Call Grabar_Log_AUDITORIA(giBAC_Entidad, gsbac_fecp, gsBac_IP, gsBAC_User, "PCA", "OPC_750", "03", "ELIMINA", " CORRESPONSAL  ", " ", " ")

        Case 4
            Call Limpiar
            txtRut.Enabled = True
            txtRut.SetFocus
            Toolbar1.Buttons(3).Enabled = False
        Case 5
            Call Grabar_Log_AUDITORIA(giBAC_Entidad, gsbac_fecp, gsBac_IP, gsBAC_User, "PCA", "OPC_750", "08", "SALIR OPCION DE MENU", " ", " ", " ")
            Unload Me
    End Select

End Sub

Private Function guardar() As Boolean
    Dim Sw      As Integer
    Dim i       As Long
    Dim Datos()
    Dim Y       As Integer
    Dim Mensaje, Estilo, Título, Respuesta
    Dim Rut     As Double
  
  
    Let guardar = False
    Let Screen.MousePointer = vbHourglass
    
    SWGRA = 1
  
    If Not Bac_Sql_Execute("Begin Transaction") Then
        Let Screen.MousePointer = vbDefault
        Exit Function
    End If
  
    If SWGRA = 1 Then
        
        Envia = Array(CDbl(txtRut.Text), CDbl(txtCodigo.Text))
        If Not Bac_Sql_Execute("SP_CORRESPONSALES_ELIMINAR ", Envia) Then
            Call Bac_Sql_Execute("Rollback Transaction")
            Let Screen.MousePointer = vbDefault
            Exit Function
        End If

        Let Grid.Redraw = False
        For i = 2 To Grid.Rows - 1
            Grid.Row = i
            sql = ""
            sql = "SP_CORRESPONSALES_GRABAR"
            sql = sql & " " & CDbl(txtRut.Text) & ","
            sql = sql & " " & CDbl(txtCodigo.Text) & ","
            sql = sql & " " & Val(Trim(Right(Grid.TextMatrix(i, 1), 50))) & " ,"
            sql = sql & " " & Val(Trim(Right(Grid.TextMatrix(i, 2), 50))) & " ,"
            sql = sql & " " & Val(Trim(Right(Grid.TextMatrix(i, 3), 50))) & " ,"
            sql = sql & " '" & Grid.TextMatrix(i, 4) & "' ,"
            sql = sql & " '" & Grid.TextMatrix(i, 5) & "' ,"
            sql = sql & " '" & Grid.TextMatrix(i, 6) & "' ,"
            sql = sql & " '" & Grid.TextMatrix(i, 7) & "' ,"
            sql = sql & " '" & Mid(Grid.TextMatrix(i, 8), 1, 1) & "' ,"
            sql = sql & " '" & Format(Grid.TextMatrix(i, 9), "yyyymmdd") & "' ,"
            sql = sql & " '" & Trim(Grid.TextMatrix(i, 10)) & "' ,"   'codigo contable
            sql = sql & " " & Val(Grid.TextMatrix(i, 11)) & " ,"
            sql = sql & " " & Val(Grid.TextMatrix(i, 12)) & " ,"
            sql = sql & " " & Val(Grid.TextMatrix(i, 13)) & " "
            If Bac_Sql_Execute(sql) Then
                If Bac_SQL_Fetch(Datos()) Then
                    Select Case Datos(1)
                       Case Is = "ok": Sw = 1
                    End Select
                 End If
            Else
                Call Bac_Sql_Execute("Rollback Transaction")
                Let Screen.MousePointer = vbDefault
                Call MsgBox("Problemas en Sql" & vbCrLf & Err.Description, vbCritical, TITSISTEMA)
                Let Grid.Redraw = True
                Grid.SetFocus
                Exit Function
            End If
        Next i
    End If
  
    Let Screen.MousePointer = vbDefault
    Let Grid.Redraw = True
    Call Bac_Sql_Execute("Commit Transaction")
    Let guardar = True
    
    If Sw = 1 Then
       Toolbar1.Buttons(1).Enabled = True
       MsgBox "La información ha sido Grabada", vbInformation + vbOKOnly, TITSISTEMA
       Grid.SetFocus
    End If
    
    If Sw = 2 Then
       MsgBox "La información ha sido Modificada", vbInformation + vbOKOnly, TITSISTEMA
       Grid.SetFocus
    End If
   
    Toolbar1.Buttons(3).Enabled = False
    Toolbar1.Buttons(2).Enabled = False
    Toolbar1.Buttons(4).Enabled = True

    If KeyCode = 46 Then
        Toolbar1.Buttons(2).Enabled = True
        Call Eliminar
    End If
End Function

Private Sub TxtGrilla_KeyPress(KeyAscii As Integer)

Dim Char As String
Dim SW2 As Integer

KeyAscii = Asc(UCase(Chr(KeyAscii)))
Char = "'/&()?¿%·*+=$<>""@!¡{}¨Ç-"
SW2 = 0

For i = 1 To Len(Char)

    If Mid(Char, i, 1) = UCase(Chr(KeyAscii)) Then

        SW2 = 1
        Exit For

    End If

Next i

If SW2 = 1 Then

    KeyAscii = 0

End If

If Chr(KeyAscii) = "-" Then GoTo fin:
    


    If KeyAscii = 45 Then
          
          If Campos_Blancos = 0 Then
              
              Grid.Col = 1
              Grid.SetFocus
              Grid.AddItem ("")
              Grid.RowHeight(Grid.Rows - 1) = 313 'Grid.Rows - 1
              Grid.SetFocus
         
         Else
            
            MsgBox "Debe Insertar Datos Antes de Insertar una Nueva Fila", vbOKOnly, TITSISTEMA
            Grid.SetFocus
         
         End If
    Else
      If KeyAscii = 27 Then
          
          TXTGRILLA.Visible = False
          TXTGRILLA.Text = ""
          'TXTGRILLA.Text = Grid.Text
          Grid.Text = TXTGRILLA.Tag
          'Grid.Col = 5
          Grid.SetFocus
       
       End If
       
       If KeyAscii = 13 Then
       
            Dim Ind2, Sub_ind2 As Integer
            Dim Busq2 As String
            Text1.Text = ""
            Text1.Text = TXTGRILLA.Text
            Busq2 = Text1.Text
          
      
    
    '''''        'For Ind2 = 1 To Grid.Rows - 1
    '''''
    '''''          For Sub_ind2 = 1 To Grid.Rows - 1
    '''''
    '''''               If Ind2 <> Sub_ind2 Then
    '''''
    '''''                    If Trim(Grid.TextMatrix(Sub_ind2, 4)) = Trim(Busq2) Then MsgBox "Codigo Swift No se Puede Repetir ": Exit Sub
    '''''
    '''''               End If
    '''''
    '''''          Next Sub_ind2
    '''''
    '''''        'Next Ind2
'''''              Cont = 0
'''''
'''''              For Sub_ind1 = 1 To Grid.Rows - 1
'''''                   'If Ind1 <> Sub_ind1 Then
'''''                        If Trim(Grid.TextMatrix(Sub_ind1, 4)) = Trim(Busq2) Then
'''''                            Cont = Cont + 1
'''''                        End If
'''''                        If Grid.TextMatrix(Grid.Row, Grid.Col) = Busq2 Then
'''''
'''''                            Cont = Cont - 1
'''''
'''''                        End If
'''''                   'End If
'''''              Next Sub_ind1
'''''
'''''            'Next Ind1
'''''
'''''            If Cont > 0 Then MsgBox "Codigo Swift No se Puede Repetir ": Exit Sub
            
            Grid.Text = Busq2
            
            If Verifica_Existencia(Mid(Grid.TextMatrix(Grid.Row, 1), 1, 50), Mid(Grid.TextMatrix(Grid.Row, 2), 1, 50), Mid(Grid.TextMatrix(Grid.Row, 3), 1, 50), Mid(Grid.TextMatrix(Grid.Row, 4), 1, 50)) Then
            
                MsgBox "Codigo Swift No se Puede Repetir ", vbInformation, TITSISTEMA
                TXTGRILLA.Text = ""
                TxtGrilla_KeyPress (27)
                Exit Sub
            
            End If
            
            TXTGRILLA.Tag = TXTGRILLA.Text
            Grid.Text = TXTGRILLA.Text
            TXTGRILLA.Text = ""
            TXTGRILLA.Visible = False
         
          
         
            'Grid.Col = 5
            Grid.SetFocus
    
       End If
       
     
       If KeyAscii = 13 And Grid.Col = 9 Then
          
          TXTGRILLA.Visible = False
          Grid.Text = TXTGRILLA.Text
          TXTGRILLA.Text = ""
       
       End If
     
     End If
     
     If KeyCode = 46 Then
      
        Toolbar1.Buttons(2).Enabled = True
        Call Eliminar
     
     End If
 
fin:
 
End Sub
Private Sub Grid_KeyPress(KeyAscii As Integer)

Toolbar1.Buttons(1).Enabled = True
'Toolbar1.Buttons(3).Enabled = False
'Toolbar1.Buttons(4).Enabled = True
'Toolbar1.Buttons(5).Enabled = True

2 If KeyAscii = 45 Then
  
   SWGRA = 1
   TXTGRILLA.Text = ""
   txtgrilla2.Text = ""
   txtgrilla3.Text = ""
   txtgrilla4.Text = ""
   TextCodCont.Text = ""
   
   If Campos_Blancos = 0 Then
     
     Grid.Col = 1
     Grid.SetFocus
     Grid.AddItem ("")
      
     Grid.RowHeight(Grid.Rows - 1) = 313 'Grid.Rows - 1
     Limpia
     Grid.SetFocus
    Else
      MsgBox "Debe Existir datos antes de Insertar una Nueva Fila", vbOKOnly, TITSISTEMA
      Grid.SetFocus
  End If
Else
 If KeyAscii = 27 Then
   MsgBox "Operacion Invalida ", vbOKOnly, TITSISTEMA
   Grid.SetFocus
  Else
    
  If Grid.Col = 1 Then
         'cmb_Moneda.Height = Grid.CellHeight
         cmb_moneda.Top = Grid.CellTop + Grid.Top
         cmb_moneda.Left = Grid.CellLeft + Grid.Left + 20
         cmb_moneda.Width = Grid.CellWidth - 20
         cmb_moneda.Visible = True
         cmb_moneda.SetFocus
    End If
   If Grid.Col = 2 Then
       
        'cmb_pais.Height = Grid.CellHeight
         cmb_pais.Tag = Grid.Text
         cmb_pais.Top = Grid.CellTop + Grid.Top
         cmb_pais.Left = Grid.CellLeft + Grid.Left + 20
         cmb_pais.Width = Grid.CellWidth - 20
         cmb_pais.Visible = True
         cmb_pais.SetFocus
   End If
    If Grid.Col = 3 Then
    'And KeyAscii <> 13'
       ' cmb_plaza.Height = Grid.CellHeight
        cmb_plaza.Top = Grid.CellTop + Grid.Top
        cmb_plaza.Left = Grid.CellLeft + Grid.Left + 20
        cmb_plaza.Width = Grid.CellWidth - 20
        cmb_plaza.Visible = True
        cmb_plaza.SetFocus
    End If
   If Grid.Col = 4 Then
   'And KeyAscii <> 13'
         TXTGRILLA.Tag = Grid.Text
         TXTGRILLA.Height = Grid.CellHeight
         TXTGRILLA.Top = Grid.CellTop + Grid.Top
         TXTGRILLA.Left = Grid.CellLeft + Grid.Left + 20
         TXTGRILLA.Width = Grid.CellWidth - 20
         TXTGRILLA.Visible = True
         TXTGRILLA.SetFocus

   End If
   If Grid.Col = 5 Then
        txtgrilla2.Height = Grid.CellHeight
         txtgrilla2.Top = Grid.CellTop + Grid.Top
         txtgrilla2.Left = Grid.CellLeft + Grid.Left + 20
         txtgrilla2.Width = Grid.CellWidth - 20
         txtgrilla2.Visible = True
         txtgrilla2.SetFocus

   End If
      If Grid.Col = 6 Then
         txtgrilla3.Height = Grid.CellHeight
         txtgrilla3.Top = Grid.CellTop + Grid.Top
         txtgrilla3.Left = Grid.CellLeft + Grid.Left + 20
         txtgrilla3.Width = Grid.CellWidth - 20
         txtgrilla3.Visible = True
         txtgrilla3.SetFocus
           
    End If

  If Grid.Col = 10 Then
      TextCodCont.Height = Grid.CellHeight
      TextCodCont.Top = Grid.CellTop + Grid.Top
      TextCodCont.Left = Grid.CellLeft + Grid.Left + 20
      TextCodCont.Width = Grid.CellWidth - 20
      TextCodCont.Visible = True
      TextCodCont.SetFocus
    End If

  If Grid.Col = 12 Then
      TextCodCorr.Height = Grid.CellHeight
      TextCodCorr.Top = Grid.CellTop + Grid.Top
      TextCodCorr.Left = Grid.CellLeft + Grid.Left + 20
      TextCodCorr.Width = Grid.CellWidth - 20
      TextCodCorr.Visible = True
      TextCodCorr.SetFocus
    End If

'****************************  Estas  columnas se encuentran ocultas  *********************
'   If Grid.Col = 7 Then
'    txtgrilla4.Height = Grid.CellHeight
'         txtgrilla4.Top = Grid.CellTop + Grid.Top
'         txtgrilla4.Left = Grid.CellLeft + Grid.Left + 20
'         txtgrilla4.Width = Grid.CellWidth - 20
'         txtgrilla4.Visible = True
'         txtgrilla4.SetFocus
'
'   End If
'   If Grid.Col = 8 Then
'        'TXTGRILLA.Height = Grid.CellHeight
'         cmbBANCE.Top = Grid.CellTop + Grid.Top
'         cmbBANCE.Left = Grid.CellLeft + Grid.Left + 20
'         cmbBANCE.Width = Grid.CellWidth - 20
'         cmbBANCE = "NO"
'         cmbBANCE.Visible = True
'         cmbBANCE.SetFocus
'
'   End If
'   If Grid.Col = 9 Then
'
'         txtFecha1.Height = Grid.CellHeight
'         txtFecha1.Top = Grid.CellTop + Grid.Top
'         txtFecha1.Left = Grid.CellLeft + Grid.Left + 20
'         txtFecha1.Width = Grid.CellWidth - 20
'         txtFecha1.Visible = True
'         txtFecha1.SetFocus
'   End If
'********************************************************************************************
  
  
          
  End If
   If KeyCode = 46 Then
       'Call Eliminar
       Toolbar1.Buttons(2).Enabled = True
   End If

End If
End Sub
Private Sub txtgrilla2_KeyPress(KeyAscii As Integer)
Dim Char As String
Dim SW2 As Integer

KeyAscii = Asc(UCase(Chr(KeyAscii)))
Char = "'/&()?¿%·*+=$<>""@!¡{}¨Ç-"
SW2 = 0

For i = 1 To Len(Char)

    If Mid(Char, i, 1) = UCase(Chr(KeyAscii)) Then

        SW2 = 1
        Exit For

    End If

Next i

If SW2 = 1 Then

    KeyAscii = 0

End If

If KeyAscii = 45 Then
   
   If Campos_Blancos = 0 Then
     
       Grid.Col = 1
       Grid.SetFocus
       Grid.AddItem ("")
       Grid.RowHeight(Grid.Rows - 1) = 315 'Grid.Rows - 1
       Grid.SetFocus
    
    Else
      
       MsgBox "Debe Insertar Datos Antes de Insertar una Nueva Fila", vbOKOnly, TITSISTEMA
       Grid.SetFocus
  
  End If

Else
  
    If KeyAscii = 27 Then
        
        txtgrilla2.Visible = False
        txtgrilla2.Text = ""
        txtgrilla2.Text = Grid.Text
        Grid.Text = txtgrilla2.Text
        'Grid.Col = 6
        Grid.SetFocus
     
     End If
     
     If KeyAscii = 13 Then
        
        txtgrilla2.Visible = False
        Grid.Text = txtgrilla2.Text
        txtgrilla2.Text = ""
        'Grid.Col = 6
        Grid.SetFocus

     End If


End If

If KeyCode = 46 Then
 
    Toolbar1.Buttons(2).Enabled = True
    Call Eliminar

End If

End Sub

Sub Eliminar()
On Error GoTo fin:
Dim Datos()
Dim Y As Integer
Dim Sw As Integer
Dim i As Long
       Grid.SetFocus
 
     If Grid.RowSel >= 2 Then
       If MsgBox("¿Seguro de eliminar Corresponsal?", vbYesNo, TITSISTEMA) = vbYes Then
            
          Dim Rut As Double
         
               If Grid.Rows > 3 Then
         
                  Grid.RemoveItem (Grid.Row)
                  Grid.Row = 2
                  Grid.Col = 1
                           
               Else
               
                  Grid.Rows = 2
                  Grid.AddItem ("")
                  Grid.Row = 1
                  Grid.Col = 0
                  
                  If Grid.Rows > 1 Then
                     
                     'Grid.RowHeight = 315
                  
                  End If
               End If
               
               Rut = txtRut.Text
''             Sql = "SP_CORRESPONSALES_ELIMINAR " & rut
''             Sql = Sql & "," & Val(txtCODIGO.Text)
     
               a = Grid.Rows - 1
            
'               Envia = Array(rut, CDbl(txtCodigo.Text))
'
'            If Not Bac_Sql_Execute("SP_CORRESPONSALES_ELIMINAR ", Envia) Then
'
'               MsgBox "PROBLEMAS EN sql", vbCritical, TITSISTEMA
'
'            Else
'
'              Do While Bac_SQL_Fetch(datos())
'
'                    Select Case datos(1)
'
'                        Case "OK"
'                             MsgBox "Corresponsal Eliminado", vbInformation, TITSISTEMA
'                             Toolbar1.Buttons(3).Enabled = False
'                             Grid.Rows = 2
''                             If Grid.Rows = 3 Then
''                              Call Me.Cargar_Grilla
''                             Else
''                              Grid.RemoveItem (Grid.RowSel)
''                              Grid.SetFocus
''                             End If
''
'                              'Call Correspon_Limpia
'                              'Call Correspon_Carga_Datos
'                              'Call Cargar_Grilla
'                              Call Limpiar
'                              txtrut.Enabled = True
'                              Cmb_Moneda.Enabled = True
'                              txtrut.SetFocus
'
'                        Case "NO EXISTE"
'                             'MsgBox "No Existe Corresponsal  "
'                             Grid.SetFocus
'                    End Select
'
'                     '    MsgBox "Error", vbCritical, "Bac-Parametros"
'                 Loop
'             End If
'
          End If
    End If
    
    Grid.SetFocus
 
fin:
End Sub

Function Campos_Blancos() As Integer
Dim Y As Integer
Dim G As Integer
    Y = Grid.Rows - 1
        Campos_Blancos = 0
      For k = 1 To 11
        If k = 7 Then
           Grid.TextMatrix(Y, k) = 0
        ElseIf k = 4 And Grid.TextMatrix(Y, k) = "" Then
           Grid.TextMatrix(Y, k) = " "
           ElseIf k = 11 And Grid.TextMatrix(Y, 11) = "" Then
            Grid.TextMatrix(Y, 11) = 0
         End If
        
      If Grid.TextMatrix(Y, k) = "" Or Grid.TextMatrix(Y, k) = "." Then
        Campos_Blancos = 1
      End If
    Next k
  
End Function



Private Sub txtRut_KeyPress(KeyAscii As Integer)
  If KeyAscii = 13 Then
     SendKeys "{tab}"
  End If
End Sub

Private Sub txtrut_LostFocus()
  txtRut.BackColor = &H8000000E
  txtRut.ForeColor = &H80000008
End Sub



Sub Limpia()

     TXTFecha1.Text = Date
     TXTGRILLA.Text = ""
     txtgrilla2.Text = ""
     txtgrilla3.Text = ""
     txtgrilla4.Text = ""
        
     TXTFecha1.Tag = Date
     TXTGRILLA.Tag = ""
     txtgrilla2.Tag = ""
     txtgrilla3.Tag = ""
     txtgrilla4.Tag = ""

End Sub


Function Verifica_Existencia(Moneda, pais, plaza, CodSwif As String) As Boolean
Dim i As Long
Dim ContV As Integer

    Verifica_Existencia = False
    
    ContV = 0
    
    For i = 1 To Grid.Rows - 1
    
        If Mid(Grid.TextMatrix(i, 1), 1, 50) = Mid(Moneda, 1, 50) And Mid(Grid.TextMatrix(i, 2), 1, 50) = Mid(pais, 1, 50) _
           And Mid(Grid.TextMatrix(i, 3), 1, 50) = Mid(plaza, 1, 50) And Mid(Grid.TextMatrix(i, 4), 1, 50) = Mid(CodSwif, 1, 50) Then
            
            ContV = ContV + 1
            If ContV > 1 Then
                
                Verifica_Existencia = True
                Exit Function
                
            End If
           
        
        End If
    
    Next i

End Function

