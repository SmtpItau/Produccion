VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Begin VB.Form frm_Mnt_Contratos_Reportes 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Reportes y Contratos"
   ClientHeight    =   10785
   ClientLeft      =   45
   ClientTop       =   375
   ClientWidth     =   10440
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   10785
   ScaleWidth      =   10440
   Begin VB.PictureBox BannerLargoContrato 
      Height          =   2295
      Left            =   5280
      ScaleHeight     =   2235
      ScaleWidth      =   4020
      TabIndex        =   29
      Top             =   8370
      Width           =   4080
   End
   Begin VB.PictureBox BannerLargo 
      Height          =   2295
      Left            =   1080
      ScaleHeight     =   2235
      ScaleWidth      =   4020
      TabIndex        =   24
      Top             =   8370
      Width           =   4080
   End
   Begin VB.PictureBox BannerCorto 
      Height          =   2295
      Left            =   5280
      ScaleHeight     =   2235
      ScaleWidth      =   4020
      TabIndex        =   17
      Top             =   5250
      Width           =   4080
   End
   Begin VB.PictureBox Logo 
      Height          =   2295
      Left            =   1080
      ScaleHeight     =   2235
      ScaleWidth      =   4020
      TabIndex        =   14
      Top             =   5250
      Width           =   4080
   End
   Begin VB.Frame Frame1 
      Height          =   3615
      Left            =   0
      TabIndex        =   8
      Top             =   600
      Width           =   10335
      Begin VB.TextBox txtCodigo 
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
         Left            =   4440
         MaxLength       =   1
         TabIndex        =   28
         Top             =   240
         Width           =   330
      End
      Begin VB.TextBox txtRut 
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
         Height          =   285
         Left            =   1680
         MaxLength       =   8
         TabIndex        =   0
         Top             =   240
         Width           =   1095
      End
      Begin VB.ComboBox cboCiudad 
         Height          =   315
         Left            =   1680
         Style           =   2  'Dropdown List
         TabIndex        =   7
         Top             =   3120
         Width           =   3735
      End
      Begin VB.ComboBox cboComuna 
         Height          =   315
         Left            =   1680
         Style           =   2  'Dropdown List
         TabIndex        =   6
         Top             =   2640
         Width           =   3735
      End
      Begin VB.TextBox txtNombreFantasia 
         Height          =   285
         Left            =   1680
         TabIndex        =   3
         Top             =   1200
         Width           =   8415
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
         Left            =   3000
         MaxLength       =   1
         TabIndex        =   1
         Top             =   240
         Width           =   330
      End
      Begin VB.TextBox txt_Telefono 
         Height          =   285
         Left            =   1680
         TabIndex        =   5
         Top             =   2160
         Width           =   1695
      End
      Begin VB.TextBox txt_Direccion 
         Height          =   285
         Left            =   1680
         TabIndex        =   4
         Top             =   1680
         Width           =   8415
      End
      Begin VB.TextBox txt_RazonSocial 
         Height          =   285
         Left            =   1680
         TabIndex        =   2
         Top             =   720
         Width           =   8415
      End
      Begin VB.Label Label10 
         Caption         =   "Código"
         Height          =   255
         Left            =   3840
         TabIndex        =   27
         Top             =   240
         Width           =   855
      End
      Begin VB.Label Label8 
         Caption         =   "Ciudad"
         Height          =   255
         Left            =   240
         TabIndex        =   23
         Top             =   3120
         Width           =   1215
      End
      Begin VB.Label Label7 
         Caption         =   "Comuna"
         Height          =   255
         Left            =   240
         TabIndex        =   22
         Top             =   2640
         Width           =   1215
      End
      Begin VB.Label Label2 
         Caption         =   "Nombre Fantasía"
         Height          =   255
         Left            =   240
         TabIndex        =   21
         Top             =   1200
         Width           =   1455
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
         Left            =   2880
         TabIndex        =   13
         Top             =   240
         Width           =   75
      End
      Begin VB.Label Label5 
         Caption         =   "Teléfono Legal"
         Height          =   255
         Left            =   240
         TabIndex        =   12
         Top             =   2160
         Width           =   1095
      End
      Begin VB.Label Label4 
         Caption         =   "Diección Legal"
         Height          =   255
         Left            =   240
         TabIndex        =   11
         Top             =   1680
         Width           =   1455
      End
      Begin VB.Label Label3 
         Caption         =   "Razón Social"
         Height          =   255
         Left            =   240
         TabIndex        =   10
         Top             =   720
         Width           =   1095
      End
      Begin VB.Label Label1 
         Caption         =   "Rut"
         Height          =   255
         Left            =   240
         TabIndex        =   9
         Top             =   240
         Width           =   975
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Height          =   450
      Left            =   1080
      TabIndex        =   16
      Top             =   4560
      Width           =   4080
      _ExtentX        =   7197
      _ExtentY        =   794
      ButtonWidth     =   767
      ButtonHeight    =   741
      ToolTips        =   0   'False
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   4
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
      Enabled         =   0   'False
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   4995
         Top             =   15
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
               Picture         =   "frm_Mnt_Contratos_Reportes.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_Mnt_Contratos_Reportes.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_Mnt_Contratos_Reportes.frx":1034
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_Mnt_Contratos_Reportes.frx":1F0E
               Key             =   ""
            EndProperty
         EndProperty
      End
      Begin MSComDlg.CommonDialog CommonDialog 
         Left            =   4470
         Top             =   15
         _ExtentX        =   847
         _ExtentY        =   847
         _Version        =   393216
      End
   End
   Begin MSComctlLib.Toolbar Toolbar2 
      Height          =   450
      Left            =   5280
      TabIndex        =   19
      Top             =   4560
      Width           =   4080
      _ExtentX        =   7197
      _ExtentY        =   794
      ButtonWidth     =   767
      ButtonHeight    =   741
      ToolTips        =   0   'False
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   4
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
      Enabled         =   0   'False
      Begin MSComDlg.CommonDialog CommonDialog1 
         Left            =   4470
         Top             =   15
         _ExtentX        =   847
         _ExtentY        =   847
         _Version        =   393216
      End
      Begin MSComctlLib.ImageList ImageList2 
         Left            =   4995
         Top             =   15
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
               Picture         =   "frm_Mnt_Contratos_Reportes.frx":2DE8
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_Mnt_Contratos_Reportes.frx":3CC2
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_Mnt_Contratos_Reportes.frx":3E1C
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_Mnt_Contratos_Reportes.frx":4CF6
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin MSComctlLib.ImageList Img_opciones 
      Left            =   10680
      Top             =   3480
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   5
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_Mnt_Contratos_Reportes.frx":5BD0
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_Mnt_Contratos_Reportes.frx":5EEA
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_Mnt_Contratos_Reportes.frx":633C
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_Mnt_Contratos_Reportes.frx":678E
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_Mnt_Contratos_Reportes.frx":6BE0
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Tool_opciones 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   20
      Top             =   0
      Width           =   10440
      _ExtentX        =   18415
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "Img_opciones"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpia"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Graba"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   5
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSComctlLib.Toolbar Toolbar3 
      Height          =   450
      Left            =   1080
      TabIndex        =   25
      Top             =   7680
      Width           =   4080
      _ExtentX        =   7197
      _ExtentY        =   794
      ButtonWidth     =   767
      ButtonHeight    =   741
      ToolTips        =   0   'False
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   4
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
      Enabled         =   0   'False
      Begin MSComctlLib.ImageList ImageList3 
         Left            =   4995
         Top             =   15
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
               Picture         =   "frm_Mnt_Contratos_Reportes.frx":6EFA
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_Mnt_Contratos_Reportes.frx":7DD4
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_Mnt_Contratos_Reportes.frx":7F2E
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_Mnt_Contratos_Reportes.frx":8E08
               Key             =   ""
            EndProperty
         EndProperty
      End
      Begin MSComDlg.CommonDialog CommonDialog2 
         Left            =   4470
         Top             =   15
         _ExtentX        =   847
         _ExtentY        =   847
         _Version        =   393216
      End
   End
   Begin MSComctlLib.Toolbar Toolbar4 
      Height          =   450
      Left            =   5280
      TabIndex        =   30
      Top             =   7680
      Width           =   4080
      _ExtentX        =   7197
      _ExtentY        =   794
      ButtonWidth     =   767
      ButtonHeight    =   741
      ToolTips        =   0   'False
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   4
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
      Enabled         =   0   'False
      Begin MSComDlg.CommonDialog CommonDialog3 
         Left            =   4470
         Top             =   15
         _ExtentX        =   847
         _ExtentY        =   847
         _Version        =   393216
      End
      Begin MSComctlLib.ImageList ImageList4 
         Left            =   4995
         Top             =   15
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
               Picture         =   "frm_Mnt_Contratos_Reportes.frx":9CE2
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_Mnt_Contratos_Reportes.frx":ABBC
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_Mnt_Contratos_Reportes.frx":AD16
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_Mnt_Contratos_Reportes.frx":BBF0
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Label Label11 
      AutoSize        =   -1  'True
      Caption         =   "Banner Largo Contrato"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000007&
      Height          =   195
      Left            =   5295
      TabIndex        =   31
      Top             =   8160
      Width           =   1935
   End
   Begin VB.Label Label9 
      AutoSize        =   -1  'True
      Caption         =   "Banner Largo"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000007&
      Height          =   195
      Left            =   1080
      TabIndex        =   26
      Top             =   8160
      Width           =   1155
   End
   Begin VB.Label Label6 
      AutoSize        =   -1  'True
      Caption         =   "Banner Corto"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000007&
      Height          =   195
      Left            =   5295
      TabIndex        =   18
      Top             =   5040
      Width           =   1125
   End
   Begin VB.Label Label13 
      AutoSize        =   -1  'True
      Caption         =   "Logo"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000007&
      Height          =   195
      Left            =   1095
      TabIndex        =   15
      Top             =   5040
      Width           =   435
   End
End
Attribute VB_Name = "frm_Mnt_Contratos_Reportes"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
    
Private Sub Form_Activate()
    If Not Bac_Sql_Execute("SP_BUSCA_DATOS_LOGO") Then
        Exit Sub
    End If
        
    If Bac_SQL_Fetch(Datos()) Then
        txtRut = Datos(1)
        txtRut_KeyPress (13)
    Else
        If Len(txtRut.Text) <> 0 Then
            Digito = BacDevuelveDig(txtRut.Text)
            txtDigito.Text = Digito
            txtDigito.Enabled = True
        End If
    End If
End Sub

Private Sub Form_Load()
    Me.Top = 0: Me.Left = 0
    Me.Icon = BACSwapParametros.Icon
    
    If Not Bac_Sql_Execute("SP_MOSTRAR_COMUNAS_LOGO") Then
        Exit Sub
    End If
   
    cboComuna.Clear
    Do While Bac_SQL_Fetch(Datos())
        cboComuna.AddItem Datos(3)
        cboComuna.ItemData(cboComuna.NewIndex) = Datos(1)
    Loop
   
    Envia = Array()
    If Not Bac_Sql_Execute("SP_MOSTRAR_CUIDADES_LOGO") Then
        Exit Sub
    End If
   
    cboCiudad.Clear
    Do While Bac_SQL_Fetch(Datos())
        cboCiudad.AddItem Datos(3)
        cboCiudad.ItemData(cboCiudad.NewIndex) = Datos(1)
    Loop
   
    Toolbar1.Buttons(1).Enabled = False
    Toolbar1.Buttons(2).Enabled = False
    Toolbar1.Buttons(3).Enabled = False
    
    Toolbar2.Buttons(1).Enabled = False
    Toolbar2.Buttons(2).Enabled = False
    Toolbar2.Buttons(3).Enabled = False
    
    Toolbar3.Buttons(1).Enabled = False
    Toolbar3.Buttons(2).Enabled = False
    Toolbar3.Buttons(3).Enabled = False
    
    Toolbar4.Buttons(1).Enabled = False
    Toolbar4.Buttons(2).Enabled = False
    Toolbar4.Buttons(3).Enabled = False
    
    Tool_opciones.Buttons(2).Enabled = False
    Tool_opciones.Buttons(3).Enabled = False

End Sub

Private Sub Tool_opciones_ButtonClick(ByVal Button As MSComctlLib.Button)
    Select Case Button.Index
    Case 1
        Call Limpiar_Datos
    Case 2
        Call grabar_datos
    Case 3
        Unload Me
    End Select
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
    On Error GoTo ErrorOpen
    Static PathFile     As String
    Static nStatdo      As Integer
    
    Select Case Button.Index
        Case 1
            PathFile = ""
            Logo.Picture = Nothing
            nStatdo = 1
            Toolbar1.Buttons(3).Enabled = True
        Case 2
              ' CommonDialog.Filter = "JPG(*.jpg)|*.jpg|PNG(*.png)|*.png|GIF(*… *.Png, *.Gif, *.Tiff, *.Jpeg, *.Bmp)|*.Jpg; *.Png; *.Gif; *.Tiff; *.Jpeg; *.jpg"
            nStatdo = 2
            CommonDialog.Filter = "JPG(*.jpg)|*.jpg|*.Jpg"
            CommonDialog.FilterIndex = 1
            CommonDialog.ShowOpen
            
            PathFile = CommonDialog.FileName
            Logo.Picture = LoadPicture(CommonDialog.FileName)
                
            Toolbar1.Buttons(3).Enabled = True
            
        Case 3
             Dim MiImagen As New clsImagen
             Call MiImagen.PutImageInDB(PathFile, txtRut, nStatdo, 1)
             Set MiImagen = Nothing
             
    End Select
    
    On Error GoTo 0
Exit Sub:
ErrorOpen:

    On Error GoTo 0
    Exit Sub
End Sub

Private Sub Toolbar2_ButtonClick(ByVal Button As MSComctlLib.Button)
    On Error GoTo ErrorOpen
    Static PathFile     As String
    Static nStatdo      As Integer
    
    Select Case Button.Index
        Case 1
            PathFile = ""
            BannerCorto.Picture = Nothing
            nStatdo = 1
            Toolbar2.Buttons(3).Enabled = True
        Case 2
              ' CommonDialog.Filter = "JPG(*.jpg)|*.jpg|PNG(*.png)|*.png|GIF(*… *.Png, *.Gif, *.Tiff, *.Jpeg, *.Bmp)|*.Jpg; *.Png; *.Gif; *.Tiff; *.Jpeg; *.jpg"
            nStatdo = 2
            CommonDialog.Filter = "JPG(*.jpg)|*.jpg|*.Jpg"
            CommonDialog.FilterIndex = 1
            CommonDialog.ShowOpen
            
            PathFile = CommonDialog.FileName
            BannerCorto.Picture = LoadPicture(CommonDialog.FileName)
                
            Toolbar2.Buttons(3).Enabled = True
        Case 3
            Dim MiImagen As New clsImagen
            Call MiImagen.PutImageInDB(PathFile, txtRut, nStatdo, 2)
            Set MiImagen = Nothing
    End Select
    
    On Error GoTo 0
Exit Sub:
ErrorOpen:

    On Error GoTo 0
    Exit Sub
End Sub

Private Sub Toolbar3_ButtonClick(ByVal Button As MSComctlLib.Button)
    On Error GoTo ErrorOpen
    Static PathFile     As String
    Static nStatdo      As Integer
    
    Select Case Button.Index
        Case 1
            PathFile = ""
            BannerLargo.Picture = Nothing
            nStatdo = 1
            Toolbar3.Buttons(3).Enabled = True
        Case 2
              ' CommonDialog.Filter = "JPG(*.jpg)|*.jpg|PNG(*.png)|*.png|GIF(*… *.Png, *.Gif, *.Tiff, *.Jpeg, *.Bmp)|*.Jpg; *.Png; *.Gif; *.Tiff; *.Jpeg; *.jpg"
            nStatdo = 2
            CommonDialog.Filter = "JPG(*.jpg)|*.jpg|*.Jpg"
            CommonDialog.FilterIndex = 1
            CommonDialog.ShowOpen
            
            PathFile = CommonDialog.FileName
            BannerLargo.Picture = LoadPicture(CommonDialog.FileName)
                
            Toolbar3.Buttons(3).Enabled = True
        Case 3
            Dim MiImagen As New clsImagen
            Call MiImagen.PutImageInDB(PathFile, txtRut, nStatdo, 3)
            Set MiImagen = Nothing
    End Select
    
    On Error GoTo 0
Exit Sub:
ErrorOpen:

    On Error GoTo 0
    Exit Sub
End Sub

Private Sub Toolbar4_ButtonClick(ByVal Button As MSComctlLib.Button)
    On Error GoTo ErrorOpen
    Static PathFile     As String
    Static nStatdo      As Integer
    
    Select Case Button.Index
        Case 1
            PathFile = ""
            BannerLargoContrato.Picture = Nothing
            nStatdo = 1
            Toolbar4.Buttons(3).Enabled = True
        Case 2
              ' CommonDialog.Filter = "JPG(*.jpg)|*.jpg|PNG(*.png)|*.png|GIF(*… *.Png, *.Gif, *.Tiff, *.Jpeg, *.Bmp)|*.Jpg; *.Png; *.Gif; *.Tiff; *.Jpeg; *.jpg"
            nStatdo = 2
            CommonDialog.Filter = "JPG(*.jpg)|*.jpg|*.Jpg"
            CommonDialog.FilterIndex = 1
            CommonDialog.ShowOpen
            
            PathFile = CommonDialog.FileName
            BannerLargoContrato.Picture = LoadPicture(CommonDialog.FileName)
                
            Toolbar4.Buttons(3).Enabled = True
        Case 3
            Dim MiImagen As New clsImagen
            Call MiImagen.PutImageInDB(PathFile, txtRut, nStatdo, 4)
            Set MiImagen = Nothing
    End Select
    
    On Error GoTo 0
Exit Sub:
ErrorOpen:

    On Error GoTo 0
    Exit Sub
End Sub

Private Sub txtRut_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
    Envia = Array()
            
    AddParam Envia, txtRut.Text
            
    If Not Bac_Sql_Execute("SP_BUSCA_RUT_LOGO", Envia) Then
        Exit Sub
    End If
        
    If Bac_SQL_Fetch(Datos()) Then
        txtRut = Datos(1)
        txtDigito = Datos(2)
        txtCodigo = Datos(3)
        txt_RazonSocial = Datos(4)
        txtNombreFantasia = Datos(5)
        txt_Direccion = Datos(6)
        txt_Telefono = Datos(7)
        cboComuna.Text = Datos(8)
        cboCiudad.Text = Datos(9)
        
        Dim oImagen As New clsImagen
        
        Me.Logo.Picture = oImagen.GetImageFromField(txtRut, 1)
        Me.BannerCorto.Picture = oImagen.GetImageFromField(txtRut, 2)
        Me.BannerLargo.Picture = oImagen.GetImageFromField(txtRut, 3)
        Me.BannerLargoContrato.Picture = oImagen.GetImageFromField(txtRut, 4)
        
        Set oImagen = Nothing
  
        Toolbar1.Enabled = True
        Toolbar1.Buttons(1).Enabled = True
        Toolbar1.Buttons(2).Enabled = True
        Toolbar1.Buttons(3).Enabled = False

        Toolbar2.Enabled = True
        Toolbar2.Buttons(1).Enabled = True
        Toolbar2.Buttons(2).Enabled = True
        Toolbar2.Buttons(3).Enabled = False
        
        Toolbar3.Enabled = True
        Toolbar3.Buttons(1).Enabled = True
        Toolbar3.Buttons(2).Enabled = True
        Toolbar3.Buttons(3).Enabled = False
        
        Toolbar4.Enabled = True
        Toolbar4.Buttons(1).Enabled = True
        Toolbar4.Buttons(2).Enabled = True
        Toolbar4.Buttons(3).Enabled = False
        
        txt_RazonSocial.SetFocus
    Else
        If Len(txtRut.Text) <> 0 Then
            Digito = BacDevuelveDig(txtRut.Text)
            txtDigito.Text = Digito
            txtDigito.Enabled = True
        End If
    End If
    txt_RazonSocial.SetFocus

    Tool_opciones.Buttons(2).Enabled = True
    Tool_opciones.Buttons(3).Enabled = True
End If
End Sub

Private Sub txtrut_LostFocus()

If txtRut.Text <> "" Then
    Envia = Array()
            
    AddParam Envia, txtRut.Text
            
    If Not Bac_Sql_Execute("SP_BUSCA_RUT_LOGO", Envia) Then
        Exit Sub
    End If
        
    If Bac_SQL_Fetch(Datos()) Then
        txtRut = Datos(1)
        txtDigito = Datos(2)
        txtCodigo = Datos(3)
        txt_RazonSocial = Datos(4)
        txtNombreFantasia = Datos(5)
        txt_Direccion = Datos(6)
        txt_Telefono = Datos(7)
        cboComuna.Text = Datos(8)
        cboCiudad.Text = Datos(9)
    Else
        If Len(txtRut.Text) <> 0 Then
            Digito = BacDevuelveDig(txtRut.Text)
            txtDigito.Text = Digito
            txtDigito.Enabled = True
        End If
    End If
    txt_RazonSocial.SetFocus
End If
End Sub

Private Sub Limpiar_Datos()
    txtRut.Text = ""
    txtDigito = ""
    txtCodigo = ""
    txt_RazonSocial = ""
    txtNombreFantasia = ""
    txt_Direccion = ""
    txt_Telefono = ""
    cboCiudad.ListIndex = -1
    cboComuna.ListIndex = -1
    txtRut.SetFocus
    
    Logo.Picture = Nothing
    BannerCorto.Picture = Nothing
    BannerLargo.Picture = Nothing
    
    Toolbar1.Buttons(1).Enabled = False
    Toolbar1.Buttons(2).Enabled = False
    Toolbar1.Buttons(3).Enabled = False
    
    Toolbar2.Buttons(1).Enabled = False
    Toolbar2.Buttons(2).Enabled = False
    Toolbar2.Buttons(3).Enabled = False
    
    Toolbar3.Buttons(1).Enabled = False
    Toolbar3.Buttons(2).Enabled = False
    Toolbar3.Buttons(3).Enabled = False
    
    Toolbar4.Buttons(1).Enabled = False
    Toolbar4.Buttons(2).Enabled = False
    Toolbar4.Buttons(3).Enabled = False
    
    Tool_opciones.Buttons(2).Enabled = False
    
    PathFile = ""
    nStatdo = 1
End Sub

Private Sub grabar_datos()
Static nStatdo      As Integer
Static PathFile     As String

    If txtRut = "" Then
        MsgBox "Debe ingresar el Rut antes de grabar", vbInformation
        Exit Sub
    End If
            
    Envia = Array()
    AddParam Envia, txtRut
    AddParam Envia, txtDigito
    AddParam Envia, txtCodigo
    AddParam Envia, txt_RazonSocial
    AddParam Envia, txtNombreFantasia
    AddParam Envia, txt_Direccion
    AddParam Envia, txt_Telefono
    AddParam Envia, cboComuna
    AddParam Envia, cboCiudad
            
    If Not Bac_Sql_Execute("SP_GRABAR_DATOS_LOGO", Envia) Then
        Exit Sub
    End If
   
    Call Limpiar_Datos
End Sub

Public Function BacDevuelveDig(Rut As String) As String

   Dim i       As Integer
   Dim D       As Integer
   Dim Divi    As Long
   Dim Suma    As Long
   Dim Digito  As String
   Dim Multi   As Double

   BacDevuelveDig = ""

   Rut = Format(Rut, "000000000")
   D = 2
   Suma = 0
   For i = 9 To 1 Step -1
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
