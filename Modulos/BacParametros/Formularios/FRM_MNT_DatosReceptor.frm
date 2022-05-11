VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form FRM_MNT_DatosReceptor 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Datos del Banco Receptor"
   ClientHeight    =   3180
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   8295
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form2"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3180
   ScaleWidth      =   8295
   StartUpPosition =   2  'CenterScreen
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   11
      Top             =   0
      Width           =   8295
      _ExtentX        =   14631
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.Visible         =   0   'False
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Cerrar"
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   5355
         Top             =   60
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
               Picture         =   "FRM_MNT_DatosReceptor.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_DatosReceptor.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_DatosReceptor.frx":1DB4
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame Frame1 
      Height          =   2745
      Left            =   0
      TabIndex        =   12
      Top             =   435
      Width           =   8280
      Begin VB.TextBox txtRecep_Swift 
         Alignment       =   2  'Center
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
         Left            =   1200
         TabIndex        =   10
         Text            =   "BADECLRM"
         Top             =   2370
         Width           =   2340
      End
      Begin VB.TextBox txtRecep_Nombre 
         Alignment       =   2  'Center
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
         Left            =   3495
         TabIndex        =   9
         Text            =   "BANCO DEL DESARROLLO"
         Top             =   2040
         Width           =   4710
      End
      Begin VB.TextBox txtRecep_Dv 
         Alignment       =   2  'Center
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
         Left            =   2580
         TabIndex        =   7
         Text            =   "1"
         Top             =   2040
         Width           =   405
      End
      Begin VB.TextBox txtBenef_CtaCte 
         Alignment       =   2  'Center
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
         Left            =   1200
         TabIndex        =   5
         Text            =   "77-7777-77-777"
         Top             =   1230
         Width           =   2325
      End
      Begin VB.TextBox txtBenef_Direccion 
         Alignment       =   2  'Center
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
         Left            =   1185
         TabIndex        =   4
         Text            =   "Huerfanos 1072 (Noveno Piso)"
         Top             =   900
         Width           =   6990
      End
      Begin VB.TextBox txtBenef_Nombre 
         Alignment       =   2  'Center
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
         Left            =   3480
         TabIndex        =   3
         Text            =   "BANDESARROLLO C. DE B."
         Top             =   570
         Width           =   4710
      End
      Begin BACControles.TXTNumero txtBenef_codigo 
         Height          =   315
         Left            =   3000
         TabIndex        =   2
         Top             =   570
         Width           =   480
         _ExtentX        =   847
         _ExtentY        =   556
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "1"
         Text            =   "1"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin VB.TextBox txtBenef_Dv 
         Alignment       =   2  'Center
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
         Left            =   2565
         TabIndex        =   1
         Text            =   "3"
         Top             =   570
         Width           =   405
      End
      Begin BACControles.TXTNumero txtBenef_Rut 
         Height          =   315
         Left            =   1170
         TabIndex        =   0
         Top             =   570
         Width           =   1380
         _ExtentX        =   2434
         _ExtentY        =   556
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "96,611,310"
         Text            =   "96,611,310"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTNumero txtRecep_Rut 
         Height          =   315
         Left            =   1185
         TabIndex        =   6
         Top             =   2040
         Width           =   1380
         _ExtentX        =   2434
         _ExtentY        =   556
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "97,051,000"
         Text            =   "97,051,000"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTNumero txtRecep_Codigo 
         Height          =   315
         Left            =   3015
         TabIndex        =   8
         Top             =   2040
         Width           =   480
         _ExtentX        =   847
         _ExtentY        =   556
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "1"
         Text            =   "1"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin VB.Label NombresCampo 
         BorderStyle     =   1  'Fixed Single
         Caption         =   "Swift"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Index           =   4
         Left            =   90
         TabIndex        =   19
         Top             =   2370
         Width           =   1095
      End
      Begin VB.Label NombresCampo 
         BorderStyle     =   1  'Fixed Single
         Caption         =   "R.U.T:"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Index           =   3
         Left            =   90
         TabIndex        =   18
         Top             =   2040
         Width           =   1095
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Datos del Receptor"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   11.25
            Charset         =   0
            Weight          =   700
            Underline       =   -1  'True
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   1
         Left            =   120
         TabIndex        =   17
         Top             =   1665
         Width           =   2010
      End
      Begin VB.Label NombresCampo 
         BorderStyle     =   1  'Fixed Single
         Caption         =   "Cta. Cte."
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Index           =   2
         Left            =   75
         TabIndex        =   16
         Top             =   1230
         Width           =   1095
      End
      Begin VB.Label NombresCampo 
         BorderStyle     =   1  'Fixed Single
         Caption         =   "Dirección"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Index           =   1
         Left            =   75
         TabIndex        =   15
         Top             =   900
         Width           =   1095
      End
      Begin VB.Label NombresCampo 
         BorderStyle     =   1  'Fixed Single
         Caption         =   "R.U.T:"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Index           =   0
         Left            =   75
         TabIndex        =   14
         Top             =   570
         Width           =   1095
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Datos del Benefiriario"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   11.25
            Charset         =   0
            Weight          =   700
            Underline       =   -1  'True
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   0
         Left            =   75
         TabIndex        =   13
         Top             =   135
         Width           =   2280
      End
   End
End
Attribute VB_Name = "FRM_MNT_DatosReceptor"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Public nNumOper   As Variant
Public cSistema   As String
Public iMoneda    As String

Dim SeActivo      As Boolean

Private Sub Form_Activate()
   If SeActivo = False Then
      SeActivo = True
      Call BuscarDatos
   End If
   
End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)
   If KeyAscii = vbKeyReturn Then
      SendKeys "{TAB}"
   End If
End Sub

Private Sub Form_Load()
   Me.Icon = BACSwapParametros.Icon
   Call Limpiar
   SeActivo = False
End Sub

Private Sub Form_Unload(Cancel As Integer)
   SeActivo = False
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 1
         Call Limpiar
      Case 2
         Call Agregar
      Case 3
         If MsgBox("¿ Desea grabar la información ?", vbQuestion + vbYesNo, TITSISTEMA) = vbYes Then
            Call Agregar
         End If
         
         Unload Me
         
   End Select
End Sub

Private Sub txtNombre_KeyPress(Index As Integer, KeyAscii As Integer)
   KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub

Private Sub Limpiar()
   txtBenef_Rut.Text = 0
   txtBenef_codigo.Text = 0
   txtBenef_Dv.Text = ""
   txtBenef_Nombre.Text = ""
   txtBenef_Direccion.Text = ""
   txtBenef_CtaCte.Text = ""
   
   txtRecep_Rut.Text = 0
   txtRecep_Codigo.Text = 0
   txtRecep_Dv.Text = ""
   txtRecep_Nombre.Text = ""
   txtRecep_Swift.Text = ""
End Sub

Private Sub Agregar()
   On Error GoTo ErrorCargaDatos
   
   Envia = Array()
   AddParam Envia, CDbl(nNumOper)
   AddParam Envia, CDbl(txtRecep_Rut.Text)
   AddParam Envia, CDbl(txtRecep_Codigo.Text)
   AddParam Envia, CStr(txtRecep_Swift.Text)
   AddParam Envia, CStr(txtBenef_Direccion.Text)
   AddParam Envia, CStr(txtBenef_CtaCte.Text)
   AddParam Envia, cSistema
   If Not Bac_Sql_Execute("SP_CargaDatos_Receptor_Beneficiario", Envia) Then
      GoTo ErrorCargaDatos
   End If
   MsgBox "Se han actualizado en forma correcta los valores ", vbInformation, TITSISTEMA
   Unload Me
Exit Sub
ErrorCargaDatos:
   MsgBox Err.Description, vbExclamation, TITSISTEMA
End Sub

Private Sub BuscarDatos()
   On Error GoTo ErrorDatos
   Dim DATOS()
   
   Envia = Array()
   AddParam Envia, CDbl(nNumOper)
   AddParam Envia, cSistema
   AddParam Envia, iMoneda
   If Not Bac_Sql_Execute("Sp_Datos_Receptor_Beneficiario", Envia) Then
      GoTo ErrorDatos
   End If
   If Bac_SQL_Fetch(DATOS()) Then
      txtBenef_Rut.Text = DATOS(1)
      txtBenef_codigo.Text = DATOS(2)
      txtBenef_Dv.Text = UCase(DATOS(3))
      txtBenef_Nombre.Text = UCase(DATOS(4))
      txtBenef_Direccion.Text = UCase(DATOS(5))
      txtBenef_CtaCte.Text = UCase(DATOS(6))
      
      txtRecep_Rut.Text = DATOS(7)
      txtRecep_Codigo.Text = DATOS(8)
      txtRecep_Dv.Text = UCase(DATOS(9))
      txtRecep_Nombre.Text = UCase(DATOS(10))
      txtRecep_Swift.Text = UCase(DATOS(11))
   End If
Exit Sub
ErrorDatos:
   MsgBox Err.Description, vbExclamation, TITSISTEMA
End Sub

Private Sub txtBenef_CtaCte_KeyPress(KeyAscii As Integer)
   KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub

Private Sub txtBenef_Direccion_KeyPress(KeyAscii As Integer)
   KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub

Private Sub txtRecep_Rut_DblClick()
   BacAyuda.Tag = "MDCL_B"
   BacAyuda.Show 1
   If giAceptar = True Then
      Call BacControlWindows(10)
      txtRecep_Rut.Text = Val(gsrut)
      txtRecep_Dv.Text = Trim(gsDigito)
      txtRecep_Codigo.Text = Val(gsCodigo)
      txtRecep_Nombre.Text = Trim(gsDescripcion$)
      txtRecep_Swift.Text = Trim(gsSwift)
   End If
End Sub
