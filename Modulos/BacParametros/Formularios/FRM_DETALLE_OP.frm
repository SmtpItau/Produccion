VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form FRM_DETALLE_OP 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Cambio de Estado."
   ClientHeight    =   2415
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   5685
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2415
   ScaleWidth      =   5685
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame Frame1 
      Enabled         =   0   'False
      Height          =   1725
      Left            =   15
      TabIndex        =   0
      Top             =   -75
      Width           =   5670
      Begin BACControles.TXTNumero txtNumOperacion 
         Height          =   330
         Left            =   3495
         TabIndex        =   3
         Top             =   480
         Width           =   2085
         _ExtentX        =   3678
         _ExtentY        =   582
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "137,560"
         Text            =   "137,560"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTNumero TxtMontoMn 
         Height          =   330
         Left            =   3405
         TabIndex        =   5
         Top             =   1260
         Width           =   2175
         _ExtentX        =   3836
         _ExtentY        =   582
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "750,000,000"
         Text            =   "750,000,000"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTNumero TxtMontoMx 
         Height          =   330
         Left            =   75
         TabIndex        =   7
         Top             =   1260
         Width           =   1800
         _ExtentX        =   3175
         _ExtentY        =   582
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "1,000,000"
         Text            =   "1,000,000"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTNumero TxtTCambio 
         Height          =   330
         Left            =   1980
         TabIndex        =   8
         Top             =   1260
         Width           =   1290
         _ExtentX        =   2275
         _ExtentY        =   582
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "750.0000"
         Text            =   "750.0000"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Monto Pesos"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   4
         Left            =   3435
         TabIndex        =   9
         Top             =   1050
         Width           =   1080
      End
      Begin VB.Label Etiquetas 
         Alignment       =   1  'Right Justify
         AutoSize        =   -1  'True
         Caption         =   "Monto Operación"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   3
         Left            =   105
         TabIndex        =   6
         Top             =   1050
         Width           =   1440
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Tipo de Cambio"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   2
         Left            =   1980
         TabIndex        =   4
         Top             =   1050
         Width           =   1290
      End
      Begin VB.Label Etiquetas 
         Alignment       =   1  'Right Justify
         AutoSize        =   -1  'True
         Caption         =   "Número de la Operación"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   1
         Left            =   1380
         TabIndex        =   2
         Top             =   540
         Width           =   2010
      End
      Begin VB.Label Etiquetas 
         Alignment       =   1  'Right Justify
         AutoSize        =   -1  'True
         Caption         =   "Datos de la Operación seleccionada"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   0
         Left            =   60
         TabIndex        =   1
         Top             =   240
         Width           =   2985
      End
   End
   Begin VB.Frame Frame2 
      Height          =   840
      Left            =   30
      TabIndex        =   10
      Top             =   1560
      Width           =   5655
      Begin MSComctlLib.Toolbar Toolbar1 
         Height          =   660
         Left            =   3750
         TabIndex        =   15
         Top             =   135
         Width           =   1845
         _ExtentX        =   3254
         _ExtentY        =   1164
         ButtonWidth     =   1429
         ButtonHeight    =   1111
         Appearance      =   1
         Style           =   1
         ImageList       =   "ImageList1"
         _Version        =   393216
         BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
            NumButtons      =   3
            BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               ImageIndex      =   1
               Style           =   3
            EndProperty
            BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Caption         =   "Actualizar"
               ImageIndex      =   1
            EndProperty
            BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Caption         =   "Cerrar"
               ImageIndex      =   2
            EndProperty
         EndProperty
         BorderStyle     =   1
      End
      Begin BACControles.TXTNumero txtNumIBS 
         Height          =   330
         Left            =   75
         TabIndex        =   12
         Top             =   375
         Width           =   1635
         _ExtentX        =   2884
         _ExtentY        =   582
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "137,560"
         Text            =   "137,560"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTNumero TxtMontoIBS 
         Height          =   330
         Left            =   1815
         TabIndex        =   14
         Top             =   375
         Width           =   1800
         _ExtentX        =   3175
         _ExtentY        =   582
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "1,000,000"
         Text            =   "1,000,000"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   885
         Top             =   375
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
               Picture         =   "FRM_DETALLE_OP.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_DETALLE_OP.frx":0EDA
               Key             =   ""
            EndProperty
         EndProperty
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Monto Liquidado"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   6
         Left            =   1845
         TabIndex        =   13
         Top             =   165
         Width           =   1395
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Número IBS"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   5
         Left            =   90
         TabIndex        =   11
         Top             =   165
         Width           =   990
      End
   End
End
Attribute VB_Name = "FRM_DETALLE_OP"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public MiNumeroBac   As Long
Public MiMontoMx     As Double
Public MiMontoMn     As Double
Public MiTCambio     As Double
Public MiNumeroIBS   As Long
Public MiMontoIBS    As Double

Private Sub Form_Load()
   txtNumOperacion.Text = MiNumeroBac
   TxtMontoMx.Text = MiMontoMx
   TxtTCambio.Text = MiTCambio
   TxtMontoMn.Text = MiMontoMn
   txtNumIBS.Text = MiNumeroIBS
   TxtMontoIBS.Text = MiMontoIBS
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 2
         Call Confirmaciones
         Unload Me
      Case 3
         Unload Me
   End Select
End Sub

Private Sub Confirmaciones()
   
   Envia = Array()
   AddParam Envia, CDbl(2)
   AddParam Envia, Format(gsbac_fecp, "YYYYMMDD")
   AddParam Envia, Format(gsbac_fecp, "YYYYMMDD")
   AddParam Envia, 0
   AddParam Envia, CDbl(txtNumOperacion.Text)
   AddParam Envia, 0
   AddParam Envia, CDbl(TxtMontoIBS.Text)
   AddParam Envia, CDbl(txtNumIBS.Text)
   If Not Bac_Sql_Execute("dbo.SP_CONSULTA_MERCADOCAMBIARIO", Envia) Then
      MsgBox "Problemas en la confirmación de Operaciones.", vbExclamation, TITSISTEMA
      Exit Sub
   End If
   
   FRM_CONSULTA_MERCADO.iConfirma = True
   MsgBox "Confirmación de Operaciones. " & vbCrLf & vbCrLf & "- Operación " & CDbl(txtNumOperacion.Text) & " ha sido confirmada exitosamente.", vbInformation, TITSISTEMA
End Sub
