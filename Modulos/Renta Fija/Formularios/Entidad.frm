VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form Entidad 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Seleccione entidad"
   ClientHeight    =   1995
   ClientLeft      =   2520
   ClientTop       =   1830
   ClientWidth     =   4530
   ForeColor       =   &H00C0C0C0&
   Icon            =   "Entidad.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   1995
   ScaleWidth      =   4530
   Begin VB.OptionButton Option1 
      Caption         =   "Permanente"
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   225
      Index           =   2
      Left            =   3060
      TabIndex        =   7
      Top             =   3930
      Width           =   1335
   End
   Begin VB.OptionButton Option1 
      Caption         =   "Ambas"
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   225
      Index           =   1
      Left            =   1830
      TabIndex        =   6
      Top             =   3945
      Width           =   900
   End
   Begin VB.OptionButton Option1 
      Caption         =   "Transable"
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   225
      Index           =   0
      Left            =   345
      TabIndex        =   5
      Top             =   3945
      Width           =   1215
   End
   Begin Threed.SSFrame Ssf_Cartera_Normativa 
      Height          =   705
      Left            =   15
      TabIndex        =   4
      Top             =   1200
      Width           =   4470
      _Version        =   65536
      _ExtentX        =   7885
      _ExtentY        =   1244
      _StockProps     =   14
      Caption         =   "Cartera Super"
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
      Font3D          =   4
      Begin VB.ComboBox Cmb_Cartera_Normativa 
         Height          =   315
         Left            =   120
         TabIndex        =   1
         Text            =   "Combo2"
         Top             =   255
         Width           =   4260
      End
   End
   Begin Threed.SSFrame SSFrame2 
      Height          =   705
      Left            =   15
      TabIndex        =   2
      Top             =   495
      Width           =   4470
      _Version        =   65536
      _ExtentX        =   7885
      _ExtentY        =   1244
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
         ItemData        =   "Entidad.frx":030A
         Left            =   120
         List            =   "Entidad.frx":0311
         Style           =   2  'Dropdown List
         TabIndex        =   0
         Top             =   255
         Width           =   4260
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   3900
      Top             =   -30
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   25
      ImageHeight     =   25
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   5
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Entidad.frx":0357
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Entidad.frx":07A9
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Entidad.frx":0AC3
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Entidad.frx":0DDD
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Entidad.frx":122F
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Height          =   495
      Left            =   15
      TabIndex        =   3
      Top             =   0
      Width           =   4515
      _ExtentX        =   7964
      _ExtentY        =   873
      ButtonWidth     =   847
      ButtonHeight    =   820
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbgenerar"
            Description     =   "Generar"
            Object.ToolTipText     =   "Generar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbsalir"
            Description     =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   5
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
End
Attribute VB_Name = "Entidad"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim Sql As String
Dim Datos()

Private Sub Btnimprimir_Click()
 giAceptar% = True
 xentidad = Trim(Right(Combo1.Text, 10))
 Unload Me
End Sub


Private Sub Cmd_Salir_Click()
Unload Me
End Sub

Private Sub cmdAceptar_Click()

 giAceptar% = True
 xentidad = Trim(Right(Combo1.Text, 10))
 Unload Me

End Sub

Private Sub Command2_Click()


End Sub

Private Sub cmdCancelar_Click()
Unload Me
End Sub

Private Sub Cmb_Cartera_Normativa_Click()
 
  XCarteraSuper = IIf(Cmb_Cartera_Normativa.ListIndex > 0, Trim(Right(Cmb_Cartera_Normativa.Text, 10)), "")
  Titulo = IIf(Cmb_Cartera_Normativa.ListIndex > 0, Trim(Left(Cmb_Cartera_Normativa.Text, 50)), "")
  
End Sub


Private Sub Form_Load()

    If Cartera = False Then
        Me.Height = 1620
    Else
        Me.Height = 2265
    End If
    
    Screen.MousePointer = vbHourglass
    giAceptar% = False
    Combo1.Clear
    
    Sql = "SP_LEER_ENTIDADES"

    If Bac_Sql_Execute("SP_LEER_ENTIDADES") Then
        Combo1.AddItem "TODAS LAS ENTIDADES                                   "
        Do While Bac_SQL_Fetch(Datos())
            Combo1.AddItem Datos(1) & Space(30 + (30 - Len(Datos(1)))) & Str(Datos(2))
        Loop
    Else
        MsgBox "Proceso " & Sql & "no existe", vbOKOnly + vbCritical, gsBac_Version
        Unload Me
    End If
    
    Option1(0).Value = True
    If Combo1.ListCount > 0 Then Combo1.ListIndex = 0
    
    ''''Call PROC_LLENA_COMBOS(GLB_CARTERA_NORMATIVA, Cmb_Cartera_Normativa, True)
    Call PROC_LLENA_COMBOS(Cmb_Cartera_Normativa, 1, False, GLB_CARTERA_NORMATIVA, GLB_ID_SISTEMA)

    Screen.MousePointer = vbDefault
    
End Sub

Private Sub Option1_Click(Index As Integer)
'''''Combo1.Enabled = True
'''''Select Case Index
'''''   Case 0: XCarteraSuper = "T": Titulo = "TRANSABLE"
'''''   Case 1: XCarteraSuper = "": Titulo = ""
'''''   Case 2: XCarteraSuper = "P": Titulo = "PERMANENTE"
'''''End Select
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Key
   Case Is = "cmbgenerar"
      giAceptar% = True
      xentidad = Trim(Right(Combo1.Text, 10))
      Unload Me
   Case Is = "cmbsalir"
      Unload Me
End Select
End Sub
