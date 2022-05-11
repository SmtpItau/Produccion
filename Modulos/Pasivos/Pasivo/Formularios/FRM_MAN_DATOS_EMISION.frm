VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "threed32.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{989C9190-EDF5-45A8-AB6C-98E6EF0384D7}#1.0#0"; "Bac_Controles_Pas.ocx"
Begin VB.Form FRM_MAN_DATOS_EMISION 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Detalle de Instrumento"
   ClientHeight    =   2880
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   7965
   Icon            =   "FRM_MAN_DATOS_EMISION.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2880
   ScaleWidth      =   7965
   StartUpPosition =   3  'Windows Default
   Begin Threed.SSFrame SFRM_Emisor 
      Height          =   1065
      Left            =   30
      TabIndex        =   4
      Top             =   1770
      Width           =   7950
      _Version        =   65536
      _ExtentX        =   14023
      _ExtentY        =   1879
      _StockProps     =   14
      Caption         =   "Emisor"
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin VB.TextBox TXT_Nombre 
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
         Height          =   330
         Left            =   1185
         TabIndex        =   22
         Top             =   645
         Width           =   6600
      End
      Begin VB.TextBox TXT_Generico 
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
         Height          =   330
         Left            =   5580
         TabIndex        =   21
         Top             =   240
         Width           =   2205
      End
      Begin VB.TextBox TXT_Digito 
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
         Height          =   330
         Left            =   2835
         TabIndex        =   20
         Top             =   240
         Width           =   345
      End
      Begin BACControles.TXTNumero TXT_Rut 
         Height          =   330
         Left            =   1185
         TabIndex        =   18
         Top             =   240
         Width           =   1395
         _ExtentX        =   2461
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
         Text            =   "0"
         Text            =   "0"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin VB.Label LBL_Raya 
         Alignment       =   2  'Center
         Caption         =   "-"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   2625
         TabIndex        =   19
         Top             =   480
         Width           =   150
      End
      Begin VB.Label LBL_Nombre 
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
         Height          =   285
         Left            =   135
         TabIndex        =   13
         Top             =   705
         Width           =   1035
      End
      Begin VB.Label LBL_Generico 
         Caption         =   "Genérico"
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
         Height          =   270
         Left            =   4530
         TabIndex        =   12
         Top             =   315
         Width           =   1050
      End
      Begin VB.Label LBL_Rut 
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
         Height          =   210
         Left            =   180
         TabIndex        =   11
         Top             =   315
         Width           =   540
      End
   End
   Begin Threed.SSFrame SFRM_Tasa 
      Height          =   1200
      Left            =   5775
      TabIndex        =   3
      Top             =   555
      Width           =   2205
      _Version        =   65536
      _ExtentX        =   3889
      _ExtentY        =   2117
      _StockProps     =   14
      Caption         =   "Tasa"
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin BACControles.TXTNumero TXT_Base 
         Height          =   330
         Left            =   990
         TabIndex        =   17
         Top             =   705
         Width           =   1080
         _ExtentX        =   1905
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
         Text            =   "0"
         Text            =   "0"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTNumero TXT_Emision 
         Height          =   330
         Left            =   990
         TabIndex        =   16
         Top             =   315
         Width           =   1080
         _ExtentX        =   1905
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
         Text            =   "0,0000"
         Text            =   "0,0000"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin VB.Label LBL_Base 
         Caption         =   "Base"
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
         Height          =   225
         Left            =   150
         TabIndex        =   10
         Top             =   735
         Width           =   795
      End
      Begin VB.Label LBL_Emision 
         Caption         =   "Emisión"
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
         Height          =   225
         Left            =   135
         TabIndex        =   9
         Top             =   345
         Width           =   780
      End
   End
   Begin Threed.SSFrame SFMR_Fecha 
      Height          =   1200
      Left            =   3375
      TabIndex        =   2
      Top             =   555
      Width           =   2355
      _Version        =   65536
      _ExtentX        =   4154
      _ExtentY        =   2117
      _StockProps     =   14
      Caption         =   "Fecha"
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin BACControles.TXTFecha TXT_Fecha_Vcto 
         Height          =   330
         Left            =   945
         TabIndex        =   15
         Top             =   705
         Width           =   1290
         _ExtentX        =   2275
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
         Text            =   "10-04-2003"
      End
      Begin BACControles.TXTFecha TXT_Fecha_Emi 
         Height          =   330
         Left            =   945
         TabIndex        =   14
         Top             =   300
         Width           =   1290
         _ExtentX        =   2275
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
         Text            =   "10-04-2003"
      End
      Begin VB.Label LBL_Fec_Vcto 
         Caption         =   "Vcto."
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
         Height          =   195
         Left            =   135
         TabIndex        =   8
         Top             =   765
         Width           =   765
      End
      Begin VB.Label LBL_Fec_Emision 
         Caption         =   "Emisión"
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
         Height          =   255
         Left            =   135
         TabIndex        =   7
         Top             =   375
         Width           =   765
      End
   End
   Begin Threed.SSFrame SFMR_Instrumento 
      Height          =   1200
      Left            =   15
      TabIndex        =   1
      Top             =   555
      Width           =   3300
      _Version        =   65536
      _ExtentX        =   5821
      _ExtentY        =   2117
      _StockProps     =   14
      Caption         =   "Instrumento"
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin VB.TextBox TXT_Nemo 
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
         Height          =   330
         Left            =   1395
         TabIndex        =   24
         Top             =   315
         Width           =   1755
      End
      Begin VB.TextBox TXT_Moneda 
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
         Height          =   330
         Left            =   1395
         TabIndex        =   23
         Top             =   705
         Width           =   1755
      End
      Begin VB.Label LBL_Moneda 
         Caption         =   "Moneda"
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
         Height          =   270
         Left            =   150
         TabIndex        =   6
         Top             =   765
         Width           =   1125
      End
      Begin VB.Label LBL_Instrumento 
         Caption         =   "Nemotécnico"
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
         TabIndex        =   5
         Top             =   405
         Width           =   1215
      End
   End
   Begin MSComctlLib.Toolbar TBL_Menu 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   7965
      _ExtentX        =   14049
      _ExtentY        =   794
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Style           =   1
      ImageList       =   "Img_opciones"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   1
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      Begin MSComctlLib.ImageList Img_opciones 
         Left            =   6120
         Top             =   0
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   24
         ImageHeight     =   24
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   25
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_DATOS_EMISION.frx":2EFA
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_DATOS_EMISION.frx":3361
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_DATOS_EMISION.frx":3857
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_DATOS_EMISION.frx":3CEA
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_DATOS_EMISION.frx":41D2
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_DATOS_EMISION.frx":46E5
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_DATOS_EMISION.frx":4C22
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_DATOS_EMISION.frx":5064
               Key             =   ""
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_DATOS_EMISION.frx":551E
               Key             =   ""
            EndProperty
            BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_DATOS_EMISION.frx":59F1
               Key             =   ""
            EndProperty
            BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_DATOS_EMISION.frx":5E35
               Key             =   ""
            EndProperty
            BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_DATOS_EMISION.frx":639C
               Key             =   ""
            EndProperty
            BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_DATOS_EMISION.frx":686B
               Key             =   ""
            EndProperty
            BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_DATOS_EMISION.frx":6C8A
               Key             =   ""
            EndProperty
            BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_DATOS_EMISION.frx":7182
               Key             =   ""
            EndProperty
            BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_DATOS_EMISION.frx":757B
               Key             =   ""
            EndProperty
            BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_DATOS_EMISION.frx":79FE
               Key             =   ""
            EndProperty
            BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_DATOS_EMISION.frx":7EC4
               Key             =   ""
            EndProperty
            BeginProperty ListImage19 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_DATOS_EMISION.frx":83BB
               Key             =   ""
            EndProperty
            BeginProperty ListImage20 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_DATOS_EMISION.frx":8871
               Key             =   ""
            EndProperty
            BeginProperty ListImage21 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_DATOS_EMISION.frx":8C36
               Key             =   ""
            EndProperty
            BeginProperty ListImage22 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_DATOS_EMISION.frx":902C
               Key             =   ""
            EndProperty
            BeginProperty ListImage23 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_DATOS_EMISION.frx":9423
               Key             =   ""
            EndProperty
            BeginProperty ListImage24 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_DATOS_EMISION.frx":982C
               Key             =   ""
            EndProperty
            BeginProperty ListImage25 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_DATOS_EMISION.frx":9CEA
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
End
Attribute VB_Name = "FRM_MAN_DATOS_EMISION"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
Dim Opcion As Integer
If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) Then

Opcion = 0
   Select Case KeyCode
         Case vbKeySalir
               Opcion = 1
              
   End Select

   If Opcion <> 0 Then
      If TBL_MENU.Buttons(Opcion).Enabled Then
         Call TBL_Menu_ButtonClick(TBL_MENU.Buttons(Opcion))
      End If
   End If

End If

End Sub

Private Sub Form_Load()
Me.Icon = FRM_MDI_PASIVO.Icon
Me.top = 1150
Me.left = 30
Me.Caption = "Datos de Emisión"
Call PROC_BUSCA_DATOS
PROC_CENTRAR_PANTALLA Me
End Sub

Private Sub PROC_BUSCA_DATOS()
Dim vDatos_Retorno()
Dim nInstru As Integer
Dim cSerie As String


GLB_Envia = Array()
    PROC_AGREGA_PARAMETRO GLB_Envia, CDbl(GLB_Instrumento)
    PROC_AGREGA_PARAMETRO GLB_Envia, GLB_Serie

    If FUNC_EXECUTA_COMANDO_SQL("SP_CON_SERIES", GLB_Envia) Then
        
        If FUNC_LEE_RETORNO_SQL(vDatos_Retorno()) Then
        
            Me.TXT_Nemo.Text = vDatos_Retorno(2)
            Me.Txt_Moneda = vDatos_Retorno(20)
            Me.TXT_Fecha_Emi.Text = vDatos_Retorno(14)
            Me.Txt_Fecha_Vcto.Text = vDatos_Retorno(13)
            Me.TXT_Emision.Text = Format(vDatos_Retorno(4), GLB_Formato_Decimal)
            Me.Txt_Base.Text = vDatos_Retorno(5)
            Me.TXT_Rut.Text = vDatos_Retorno(3)
            Me.TXT_Digito = vDatos_Retorno(22)
            Me.Txt_Nombre = vDatos_Retorno(21)
            Me.TXT_Generico = vDatos_Retorno(19)
        End If
    End If
            
            

End Sub


Private Sub TBL_Menu_ButtonClick(ByVal Button As MSComctlLib.Button)

Select Case Trim(UCase(Button.Key))
Case "SALIR"
    Unload Me
End Select

End Sub
