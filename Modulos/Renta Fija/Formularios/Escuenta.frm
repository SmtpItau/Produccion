VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form EstadoCuenta 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Estado de Cuenta de Clientes"
   ClientHeight    =   2970
   ClientLeft      =   2085
   ClientTop       =   1845
   ClientWidth     =   4305
   Icon            =   "Escuenta.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   2970
   ScaleWidth      =   4305
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   13
      Top             =   0
      Width           =   4305
      _ExtentX        =   7594
      _ExtentY        =   794
      ButtonWidth     =   767
      ButtonHeight    =   741
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbimprimir"
            Description     =   "IMPRIMIR"
            Object.ToolTipText     =   "Imprimir"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmblimpiar"
            Description     =   "LIMPIAR"
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbcancelar"
            Description     =   "CANCELAR"
            Object.ToolTipText     =   "Cancelar"
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   3585
      Top             =   3945
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
            Picture         =   "Escuenta.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Escuenta.frx":0624
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Escuenta.frx":093E
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.Frame Frame1 
      Height          =   1440
      Left            =   150
      TabIndex        =   2
      Top             =   1395
      Width           =   4095
      Begin VB.TextBox txtCodigo_Rut 
         Height          =   285
         Left            =   2520
         MaxLength       =   5
         TabIndex        =   1
         Top             =   480
         Width           =   1455
      End
      Begin VB.TextBox txtRut_Cliente 
         Alignment       =   1  'Right Justify
         Height          =   285
         Left            =   120
         MaxLength       =   10
         MouseIcon       =   "Escuenta.frx":0D90
         MousePointer    =   99  'Custom
         TabIndex        =   0
         Top             =   480
         Width           =   1455
      End
      Begin VB.Label Label4 
         Caption         =   "Nombre Cliente"
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
         Left            =   120
         TabIndex        =   7
         Top             =   840
         Width           =   1935
      End
      Begin VB.Label lblNombre_Cliente 
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Height          =   285
         Left            =   120
         TabIndex        =   6
         Top             =   1080
         Width           =   3855
      End
      Begin VB.Label Label3 
         Caption         =   "Código"
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
         Left            =   2520
         TabIndex        =   5
         Top             =   240
         Width           =   975
      End
      Begin VB.Label lblDigito_Rut 
         BorderStyle     =   1  'Fixed Single
         Height          =   285
         Left            =   1920
         TabIndex        =   4
         Top             =   480
         Width           =   255
      End
      Begin VB.Line Line1 
         X1              =   1680
         X2              =   1800
         Y1              =   600
         Y2              =   600
      End
      Begin VB.Label Label1 
         Caption         =   "Rut Cliente"
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
         Left            =   120
         TabIndex        =   3
         Top             =   240
         Width           =   975
      End
   End
   Begin Threed.SSFrame SSFrame2 
      Height          =   825
      Left            =   120
      TabIndex        =   11
      Top             =   570
      Width           =   4125
      _Version        =   65536
      _ExtentX        =   7276
      _ExtentY        =   1455
      _StockProps     =   14
      Caption         =   "Entidades"
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
      Begin VB.ComboBox Combo1 
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   345
         ItemData        =   "Escuenta.frx":109A
         Left            =   135
         List            =   "Escuenta.frx":10A1
         Style           =   2  'Dropdown List
         TabIndex        =   12
         Top             =   315
         Width           =   3930
      End
   End
   Begin Threed.SSCommand cmdImprimir 
      Height          =   450
      Left            =   75
      TabIndex        =   10
      Top             =   4065
      Width           =   1200
      _Version        =   65536
      _ExtentX        =   2117
      _ExtentY        =   794
      _StockProps     =   78
      Caption         =   "Imprimir"
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
      RoundedCorners  =   0   'False
   End
   Begin Threed.SSCommand cmdCancelar 
      Height          =   450
      Left            =   2475
      TabIndex        =   9
      Top             =   4065
      Width           =   1200
      _Version        =   65536
      _ExtentX        =   2117
      _ExtentY        =   794
      _StockProps     =   78
      Caption         =   "Cancelar"
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
      RoundedCorners  =   0   'False
   End
   Begin Threed.SSCommand cmdLimpiar 
      Height          =   450
      Left            =   1290
      TabIndex        =   8
      Top             =   4065
      Width           =   1200
      _Version        =   65536
      _ExtentX        =   2117
      _ExtentY        =   794
      _StockProps     =   78
      Caption         =   "Limpiar"
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
      RoundedCorners  =   0   'False
   End
End
Attribute VB_Name = "EstadoCuenta"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim Sql$
Dim Datos()

Public proOrigen  As String

Private Sub cmdBuscar_Click()

End Sub

Private Sub cmdCancelar_Click()
'    Call Limpiar
'    giAceptar% = False
'    Unload Me
End Sub

Private Sub Limpiar()
    txtRut_Cliente.Text = ""
    lblDigito_Rut.Caption = ""
    txtCodigo_Rut.Text = ""
    lblNombre_Cliente = ""
End Sub




Private Sub cmdImprimir_Click()
'
'    xRut = 0
'    xCodigo = 0
'
'    If txtRut_Cliente.Text <> "" And txtCodigo_Rut <> "" Then
'        giAceptar% = True
'        xRut = txtRut_Cliente.Text
'        xCodigo = txtCodigo_Rut.Text
'        Unload Me
'    Else
'        If Me.proOrigen = "ESTCTA" Then
'            MsgBox "No ha ingresado datos", vbCritical, gsBac_Version
'            txtRut_Cliente.SetFocus
'        Else
'                giAceptar% = True
'                Unload Me
'        End If
'    End If
'
End Sub

Private Sub cmdlimpiar_Click()
'    Call Limpiar
'    txtRut_Cliente.SetFocus
End Sub

Private Sub Form_Activate()

Screen.MousePointer = vbDefault

Me.Caption = IIf(Me.proOrigen = "ESTCTA", "Estado Cuenta Clientes", "Informe de Custodia captaciones por cliente")



End Sub

Private Sub Form_Load()

Screen.MousePointer = 11
giAceptar% = False
Combo1.Clear
Sql$ = ""
Sql$ = "SP_LEER_ENTIDADES"
If miSQL.SQL_Execute(Sql$) = 0 Then
    Combo1.AddItem "TODAS LAS ENTIDADES                                   "
  Do While Bac_SQL_Fetch(Datos())
    Combo1.AddItem Datos(1) & Space(30 + (30 - Len(Datos(1)))) & Str(Datos(2))
  Loop
Else
  MsgBox "Proceso " & Sql & "no existe", vbOKOnly + vbCritical, gsBac_Version
  Unload Me
End If

If Combo1.ListCount > 0 Then Combo1.ListIndex = 0

Screen.MousePointer = 0
End Sub


Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case UCase(Button.Description)
    Case "IMPRIMIR"
        xRut = 0
        xCodigo = 0
        If txtRut_Cliente.Text <> "" And txtCodigo_Rut <> "" Then
            giAceptar% = True
            xRut = txtRut_Cliente.Text
            xCodigo = txtCodigo_Rut.Text
            Unload Me
        Else
            If Me.proOrigen = "ESTCTA" Then
                MsgBox "No ha ingresado datos", vbCritical, gsBac_Version
                txtRut_Cliente.SetFocus
            Else
                giAceptar% = True
                Unload Me
            End If
        End If
    Case "LIMPIAR"
        Call Limpiar
        txtRut_Cliente.SetFocus
    Case "CANCELAR"
        Call Limpiar
        giAceptar% = False
        Unload Me
End Select
End Sub

Private Sub txtCodigo_Rut_KeyPress(KeyAscii As Integer)
   If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      SendKeys$ "{TAB}"

   ElseIf Not ((KeyAscii > 47 And KeyAscii < 58) Or KeyAscii = 8) Then
      KeyAscii = 0
     
   End If
     
   BacCaracterNumerico KeyAscii
End Sub


Public Function BacBuscaClie()
Dim Datos()

'    Sql = "SP_BCLIE " & txtRut_Cliente.Text & "," & txtCodigo_Rut.Text & ""

    Envia = Array(txtRut_Cliente.Text, txtCodigo_Rut.Text)
    
    If Not Bac_Sql_Execute("SP_BCLIE", Envia) Then
        MsgBox "Error en el proceso ", vbCritical, "Bac-Trader"
        Exit Function
    End If
   
    If Bac_SQL_Fetch(Datos()) Then
        lblDigito_Rut.Tag = Datos(1)
        lblDigito_Rut.Caption = Datos(1)

        lblNombre_Cliente.Tag = Datos(2)
        lblNombre_Cliente.Caption = Datos(2)
  
        txtRut_Cliente.Tag = txtRut_Cliente.Text
        txtCodigo_Rut.Tag = txtCodigo_Rut.Text
    Else
        MsgBox "No existe cliente", vbCritical, "Bac-Trader"
        Call Limpiar
        txtRut_Cliente.SetFocus
    End If
 
End Function


Private Sub txtCodigo_Rut_LostFocus()
If Trim(txtCodigo_Rut.Text) <> "" And Trim(txtRut_Cliente.Text) <> "" Then
  Call BacBuscaClie
Else
  MsgBox "Datos en blanco ", vbCritical, "Bac-Trader"
  Call Limpiar
  txtRut_Cliente.SetFocus
End If
End Sub




Private Sub txtRut_Cliente_DblClick()
    BacControlWindows 100
    BacAyuda.Tag = "MDCL"
    BacAyuda.Show 1

    If giAceptar% = True Then
      
        txtRut_Cliente.Text = Val(gsrut$)
        lblDigito_Rut.Caption = gsDigito$
        txtCodigo_Rut = gsvalor$
        lblNombre_Cliente = gsDescripcion$
        'Call HabilitarControles(True)
    
        SendKeys "{TAB}"

    End If
End Sub

Private Sub txtRut_Cliente_KeyPress(KeyAscii As Integer)
     BacCaracterNumerico KeyAscii
     If KeyAscii = 13 Then
         KeyAscii = 0
         SendKeys "{Tab}"
     End If
End Sub
