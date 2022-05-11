VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form FRM_MNT_DatosSwiftMx 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Datos del Swift Moneda Extranjera (Mx)"
   ClientHeight    =   4425
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   7185
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4425
   ScaleWidth      =   7185
   StartUpPosition =   2  'CenterScreen
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   7185
      _ExtentX        =   12674
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
            Enabled         =   0   'False
            Object.Visible         =   0   'False
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
               Picture         =   "FRM_MNT_DatosSwiftMx.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_DatosSwiftMx.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MNT_DatosSwiftMx.frx":1DB4
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame Frame1 
      Height          =   3975
      Left            =   0
      TabIndex        =   1
      Top             =   435
      Width           =   10290
      Begin VB.ComboBox cBancoRecpetor 
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   7185
         Style           =   2  'Dropdown List
         TabIndex        =   2
         Top             =   180
         Visible         =   0   'False
         Width           =   3030
      End
      Begin VB.ComboBox cBancoIntermediario 
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   7185
         Style           =   2  'Dropdown List
         TabIndex        =   3
         Top             =   1380
         Visible         =   0   'False
         Width           =   3030
      End
      Begin VB.ComboBox cBancoBeneficiario 
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   7185
         Style           =   2  'Dropdown List
         TabIndex        =   4
         Top             =   2220
         Visible         =   0   'False
         Width           =   3030
      End
      Begin VB.Frame CuadroHabilitar 
         Enabled         =   0   'False
         Height          =   3975
         Left            =   15
         TabIndex        =   5
         Top             =   0
         Width           =   7170
         Begin VB.TextBox CiudadBeneficiario 
            BeginProperty Font 
               Name            =   "Courier New"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   330
            Left            =   2430
            MaxLength       =   48
            TabIndex        =   27
            Top             =   3585
            Width           =   4650
         End
         Begin VB.TextBox DirecciónBeneficiario 
            BeginProperty Font 
               Name            =   "Courier New"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   330
            Left            =   2430
            MaxLength       =   48
            TabIndex        =   26
            Top             =   3240
            Width           =   4650
         End
         Begin VB.TextBox SwiftBeneficiario 
            BeginProperty Font 
               Name            =   "Courier New"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   330
            Left            =   2430
            MaxLength       =   48
            TabIndex        =   23
            Top             =   2895
            Width           =   4650
         End
         Begin VB.TextBox CtaCorriente 
            BeginProperty Font 
               Name            =   "Courier New"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   330
            Left            =   2430
            MaxLength       =   48
            TabIndex        =   22
            Top             =   2550
            Width           =   4650
         End
         Begin VB.TextBox BancoBeneficiario 
            BeginProperty Font 
               Name            =   "Courier New"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   330
            Left            =   2430
            MaxLength       =   48
            TabIndex        =   21
            Top             =   2205
            Width           =   4650
         End
         Begin VB.TextBox SwiftIntermediario 
            BeginProperty Font 
               Name            =   "Courier New"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   330
            Left            =   2430
            MaxLength       =   48
            TabIndex        =   20
            Top             =   1710
            Width           =   4650
         End
         Begin VB.TextBox BancoIntermediario 
            BeginProperty Font 
               Name            =   "Courier New"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   330
            Left            =   2430
            MaxLength       =   48
            TabIndex        =   19
            Top             =   1365
            Width           =   4650
         End
         Begin VB.TextBox CtaContable 
            BeginProperty Font 
               Name            =   "Courier New"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   345
            Left            =   2430
            MaxLength       =   48
            TabIndex        =   18
            Top             =   840
            Width           =   4650
         End
         Begin VB.TextBox SwiftReceptor 
            BeginProperty Font 
               Name            =   "Courier New"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   330
            Left            =   2430
            MaxLength       =   48
            TabIndex        =   17
            Top             =   495
            Width           =   4650
         End
         Begin VB.TextBox BancoReceptor 
            BeginProperty Font 
               Name            =   "Courier New"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   315
            Left            =   2430
            MaxLength       =   48
            TabIndex        =   16
            Top             =   150
            Width           =   4650
         End
         Begin VB.Frame Frame3 
            Height          =   120
            Left            =   75
            TabIndex        =   7
            Top             =   2055
            Width           =   7065
         End
         Begin VB.Frame FraLinea0001 
            Height          =   120
            Left            =   75
            TabIndex        =   6
            Top             =   1200
            Width           =   7065
         End
         Begin VB.Label Etiquetas 
            Alignment       =   2  'Center
            BackColor       =   &H80000002&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "Ciudad Beneficiario"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000009&
            Height          =   330
            Index           =   9
            Left            =   30
            TabIndex        =   25
            Top             =   3585
            Width           =   2385
         End
         Begin VB.Label Etiquetas 
            Alignment       =   2  'Center
            BackColor       =   &H80000002&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "Dirección Beneficiario"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000009&
            Height          =   330
            Index           =   8
            Left            =   30
            TabIndex        =   24
            Top             =   3240
            Width           =   2385
         End
         Begin VB.Label Etiquetas 
            Alignment       =   2  'Center
            BackColor       =   &H80000002&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "Banco Receptor"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000009&
            Height          =   330
            Index           =   0
            Left            =   30
            TabIndex        =   15
            Top             =   165
            Width           =   2385
         End
         Begin VB.Label Etiquetas 
            Alignment       =   2  'Center
            BackColor       =   &H80000002&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "Swift Receptor"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000009&
            Height          =   330
            Index           =   1
            Left            =   30
            TabIndex        =   14
            Top             =   510
            Width           =   2385
         End
         Begin VB.Label Etiquetas 
            Alignment       =   2  'Center
            BackColor       =   &H80000002&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "Cta. Contable"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000009&
            Height          =   330
            Index           =   2
            Left            =   30
            TabIndex        =   13
            Top             =   855
            Width           =   2385
         End
         Begin VB.Label Etiquetas 
            Alignment       =   2  'Center
            BackColor       =   &H80000002&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "Swift Intermediario"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000009&
            Height          =   330
            Index           =   3
            Left            =   30
            TabIndex        =   12
            Top             =   1725
            Width           =   2385
         End
         Begin VB.Label Etiquetas 
            Alignment       =   2  'Center
            BackColor       =   &H80000002&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "Banco Intermediario"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000009&
            Height          =   330
            Index           =   4
            Left            =   30
            TabIndex        =   11
            Top             =   1380
            Width           =   2385
         End
         Begin VB.Label Etiquetas 
            Alignment       =   2  'Center
            BackColor       =   &H80000002&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "Cta. Corriente"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000009&
            Height          =   330
            Index           =   5
            Left            =   30
            TabIndex        =   10
            Top             =   2550
            Width           =   2385
         End
         Begin VB.Label Etiquetas 
            Alignment       =   2  'Center
            BackColor       =   &H80000002&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "Swift Beneficiario"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000009&
            Height          =   330
            Index           =   6
            Left            =   30
            TabIndex        =   9
            Top             =   2895
            Width           =   2385
         End
         Begin VB.Label Etiquetas 
            Alignment       =   2  'Center
            BackColor       =   &H80000002&
            BorderStyle     =   1  'Fixed Single
            Caption         =   "Banco Beneficiario"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000009&
            Height          =   330
            Index           =   7
            Left            =   30
            TabIndex        =   8
            Top             =   2205
            Width           =   2385
         End
      End
   End
End
Attribute VB_Name = "FRM_MNT_DatosSwiftMx"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Public NumeroOperacion  As Long
Public Sistema          As String
Private Dirección       As String
Private Ciudad          As String

Private Sub BancoBeneficiario_KeyPress(KeyAscii As Integer)
   KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub
Private Sub BancoIntermediario_KeyPress(KeyAscii As Integer)
   KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub
Private Sub CiudadBeneficiario_KeyPress(KeyAscii As Integer)
   KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub
Private Sub CtaContable_KeyPress(KeyAscii As Integer)
   KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub
Private Sub CtaCorriente_KeyPress(KeyAscii As Integer)
   KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub
Private Sub DirecciónBeneficiario_KeyPress(KeyAscii As Integer)
   KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub
Private Sub SwiftBeneficiario_KeyPress(KeyAscii As Integer)
   KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub
Private Sub SwiftIntermediario_KeyPress(KeyAscii As Integer)
   KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub
Private Sub SwiftReceptor_KeyPress(KeyAscii As Integer)
   KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub
Private Sub BancoReceptor_KeyPress(KeyAscii As Integer)
   KeyAscii = Asc(UCase(Chr(KeyAscii)))
End Sub

Private Sub cBancoBeneficiario_Click()
   Dim iMarca1 As Integer
   Dim iMarca2 As Integer
   
   BancoBeneficiario.Text = Trim(Mid(cBancoBeneficiario.Text, 1, 27))
   SwiftBeneficiario.Text = Trim(Mid(cBancoBeneficiario.Text, 28, 15))
   
   iMarca1 = InStr(1, cBancoBeneficiario.Text, "?") + 1
   iMarca2 = InStr(1, cBancoBeneficiario.Text, "¿") + 1
   
   Dirección = Mid(cBancoBeneficiario.Text, iMarca1, Abs(iMarca1 - iMarca2) - 1)
   Ciudad = Mid(cBancoBeneficiario.Text, iMarca2)
   
   DirecciónBeneficiario.Text = Dirección
   CiudadBeneficiario.Text = Ciudad
End Sub
Private Sub cBancoIntermediario_Click()
   BancoIntermediario.Text = Trim(Mid(cBancoIntermediario.Text, 1, 27))
   SwiftIntermediario.Text = Trim(Mid(cBancoIntermediario.Text, 33, 15))
   CtaCorriente.Text = Trim(Mid(cBancoIntermediario.Text, InStr(48, cBancoIntermediario.Text, "?") + 1))
End Sub
Private Sub cBancoRecpetor_Click()
   BancoReceptor.Text = Trim(Mid(cBancoRecpetor.Text, 1, 27))
   SwiftReceptor.Text = Trim(Mid(cBancoRecpetor.Text, 32))
   CtaContable.Text = Trim(cBancoRecpetor.ItemData(cBancoRecpetor.ListIndex))
End Sub

Private Sub Form_Load()
   Me.Icon = BACSwapParametros.Icon
   Call BuscarDatosSwiftMx
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 2
         Call GrabarDatosSwiftMt
   End Select
   Unload Me
End Sub

Private Sub GrabarDatosSwiftMt()
   On Error GoTo ErrSaveData

   Envia = Array()
   AddParam Envia, CDbl(NumeroOperacion)
   AddParam Envia, CStr(Sistema)
   AddParam Envia, CDbl(4) '--> Grabar
   AddParam Envia, Trim(CtaContable.Text)
   AddParam Envia, Trim(BancoReceptor.Text)
   AddParam Envia, Trim(SwiftReceptor.Text)
   AddParam Envia, Trim(CtaContable.Text)
   AddParam Envia, Trim(SwiftIntermediario.Text)
   AddParam Envia, Trim(BancoIntermediario.Text)
   AddParam Envia, Trim(CtaCorriente.Text)
   AddParam Envia, Trim(SwiftBeneficiario.Text)
   AddParam Envia, Trim(BancoBeneficiario.Text)
   AddParam Envia, Trim(DirecciónBeneficiario.Text)
   AddParam Envia, Trim(CiudadBeneficiario.Text)
   If Not Bac_Sql_Execute("SP_MNT_MDLBTR_MX", Envia) Then
      GoTo ErrSaveData
   End If
   
   MsgBox "Acción Finalizada Ok." & vbCrLf & vbCrLf & "Grabación de la información ha finalizado en forma correcta.", vbInformation, TITSISTEMA
   On Error GoTo 0
Exit Sub
ErrSaveData:
   MsgBox "Acción Cancelada." & vbCrLf & vbCrLf & "Problemas en la grabación de la información.", vbExclamation, TITSISTEMA
End Sub

Private Sub BuscarDatosSwiftMx()
   On Error GoTo ErroCarga
   Dim DATOS()
   
   cBancoRecpetor.Visible = False
   cBancoIntermediario.Visible = False
   cBancoBeneficiario.Visible = False
   
   Me.BancoReceptor.Text = ""
   Me.SwiftReceptor.Text = ""
   Me.CtaContable.Text = ""
   Me.SwiftIntermediario.Text = ""
   Me.BancoIntermediario.Text = ""
   Me.CtaCorriente.Text = ""
   Me.SwiftBeneficiario.Text = ""
   Me.BancoBeneficiario.Text = ""
   Me.DirecciónBeneficiario.Text = ""
   Me.CiudadBeneficiario.Text = ""


   Envia = Array()
   AddParam Envia, CDbl(NumeroOperacion)
   AddParam Envia, CStr(Sistema)
   If Not Bac_Sql_Execute("SP_MNT_MDLBTR_MX", Envia) Then
      GoTo ErroCarga
   End If
   If Bac_SQL_Fetch(DATOS()) Then
      Me.BancoReceptor.Text = DATOS(1)
      Me.SwiftReceptor.Text = DATOS(2)
      Me.CtaContable.Text = DATOS(3)
      
      Me.SwiftIntermediario.Text = DATOS(4)
      Me.BancoIntermediario.Text = DATOS(5)
      
      Me.CtaCorriente.Text = DATOS(6)
      Me.SwiftBeneficiario.Text = DATOS(7)
      Me.BancoBeneficiario.Text = DATOS(8)
      Me.DirecciónBeneficiario.Text = DATOS(9)
      Me.CiudadBeneficiario.Text = DATOS(10)
      
      If (DATOS(11) <> 1 Or DATOS(1) = "") Or Sistema = "BTR" Then
         
         Width = 10410
         CuadroHabilitar.Enabled = True
         Toolbar1.Buttons.Item(2).Visible = True
         Toolbar1.Buttons.Item(2).Enabled = True
         
         Envia = Array()
         AddParam Envia, CDbl(NumeroOperacion)
         AddParam Envia, CStr(Sistema)
         AddParam Envia, CDbl(1)
         If Not Bac_Sql_Execute("SP_MNT_MDLBTR_MX", Envia) Then
            GoTo ErroCarga
         End If
         Do While Bac_SQL_Fetch(DATOS())
            cBancoRecpetor.AddItem Mid(DATOS(1), 1, 27) & Space(32 - Len(Mid(DATOS(1), 1, 27))) & Space(2) & DATOS(2)
            cBancoRecpetor.ItemData(cBancoRecpetor.NewIndex) = Val(DATOS(3))
         Loop
         
         Envia = Array()
         AddParam Envia, CDbl(NumeroOperacion)
         AddParam Envia, CStr(Sistema)
         AddParam Envia, CDbl(2)
         If Not Bac_Sql_Execute("SP_MNT_MDLBTR_MX", Envia) Then
            GoTo ErroCarga
         End If
         Do While Bac_SQL_Fetch(DATOS())
            cBancoIntermediario.AddItem Mid(DATOS(2), 1, 27) & Space(32 - Len(Mid(DATOS(2), 1, 27))) & DATOS(1) & Space(25) & "?" & DATOS(3)
         Loop
         
         Envia = Array()
         AddParam Envia, CDbl(NumeroOperacion)
         AddParam Envia, CStr(Sistema)
         AddParam Envia, CDbl(3)
         If Not Bac_Sql_Execute("SP_MNT_MDLBTR_MX", Envia) Then
            GoTo ErroCarga
         End If
         Do While Bac_SQL_Fetch(DATOS())
            cBancoBeneficiario.AddItem Mid(DATOS(2), 1, 27) & Space(32 - Len(Mid(DATOS(2), 1, 27))) & DATOS(1) & Space(25) & "?" & DATOS(3) & "¿" & DATOS(4)
         Loop
         cBancoRecpetor.Visible = True
         cBancoIntermediario.Visible = True
         cBancoBeneficiario.Visible = True
      Else
         Me.BancoReceptor.Text = DATOS(1)
         Me.SwiftReceptor.Text = DATOS(2)
         Me.CtaContable.Text = DATOS(3)
         
         Me.SwiftIntermediario.Text = DATOS(4)
         Me.BancoIntermediario.Text = DATOS(5)
         
         Me.CtaCorriente.Text = DATOS(6)
         Me.SwiftBeneficiario.Text = DATOS(7)
         Me.BancoBeneficiario.Text = DATOS(8)
         
         Me.DirecciónBeneficiario.Text = DATOS(9)
         Me.CiudadBeneficiario.Text = DATOS(10)
      End If
   Else
      Width = 10410
      CuadroHabilitar.Enabled = True
      Toolbar1.Buttons.Item(2).Visible = True
      Toolbar1.Buttons.Item(2).Enabled = True
      
      Envia = Array()
      AddParam Envia, CDbl(NumeroOperacion)
      AddParam Envia, CStr(Sistema)
      AddParam Envia, CDbl(1)
      If Not Bac_Sql_Execute("SP_MNT_MDLBTR_MX", Envia) Then
         GoTo ErroCarga
      End If
      Do While Bac_SQL_Fetch(DATOS())
         cBancoRecpetor.AddItem Mid(DATOS(1), 1, 27) & Space(32 - Len(Mid(DATOS(1), 1, 27))) & Space(2) & DATOS(2)
         cBancoRecpetor.ItemData(cBancoRecpetor.NewIndex) = Val(DATOS(3))
      Loop
      
      Envia = Array()
      AddParam Envia, CDbl(NumeroOperacion)
      AddParam Envia, CStr(Sistema)
      AddParam Envia, CDbl(2)
      If Not Bac_Sql_Execute("SP_MNT_MDLBTR_MX", Envia) Then
         GoTo ErroCarga
      End If
      Do While Bac_SQL_Fetch(DATOS())
         cBancoIntermediario.AddItem Mid(DATOS(2), 1, 27) & Space(32 - Len(Mid(DATOS(2), 1, 27))) & DATOS(1) & Space(25) & "?" & DATOS(3)
      Loop
      
      Envia = Array()
      AddParam Envia, CDbl(NumeroOperacion)
      AddParam Envia, CStr(Sistema)
      AddParam Envia, CDbl(3)
      If Not Bac_Sql_Execute("SP_MNT_MDLBTR_MX", Envia) Then
         GoTo ErroCarga
      End If
      Do While Bac_SQL_Fetch(DATOS())
         cBancoBeneficiario.AddItem Mid(DATOS(2), 1, 27) & Space(32 - Len(Mid(DATOS(2), 1, 27))) & DATOS(1) & Space(25) & "?" & DATOS(3) & "¿" & DATOS(4)
      Loop
      cBancoRecpetor.Visible = True
      cBancoIntermediario.Visible = True
      cBancoBeneficiario.Visible = True
   End If
   
    If Sistema = "BTR" Then
        Width = 10410
        CuadroHabilitar.Enabled = True
        Toolbar1.Buttons.Item(2).Visible = True
        Toolbar1.Buttons.Item(2).Enabled = True
        
        cBancoRecpetor.Visible = True
        cBancoIntermediario.Visible = True
        cBancoBeneficiario.Visible = True
    End If
   
   
Exit Sub
ErroCarga:
   If Err.Description = "" Then
      MsgBox "Acción Cancelada" & vbCrLf & vbCrLf & "Se ha producido un erro al ejecutar: " & vbCrLf & VerSql, vbExclamation, TITSISTEMA
   Else
      MsgBox "Acción Cancelada" & vbCrLf & vbCrLf & Err.Description, vbExclamation, TITSISTEMA
   End If

End Sub

