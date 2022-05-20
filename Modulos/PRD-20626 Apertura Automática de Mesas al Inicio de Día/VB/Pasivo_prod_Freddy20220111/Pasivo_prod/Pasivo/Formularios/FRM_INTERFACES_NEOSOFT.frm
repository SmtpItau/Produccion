VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "Mscomctl.ocx"
Begin VB.Form FRM_INTERFACES 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   " Generador de Interfaz"
   ClientHeight    =   3105
   ClientLeft      =   3090
   ClientTop       =   2595
   ClientWidth     =   5100
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   3105
   ScaleWidth      =   5100
   ShowInTaskbar   =   0   'False
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   3180
      Top             =   200
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   2
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_INTERFACES_NEOSOFT.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_INTERFACES_NEOSOFT.frx":1052
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   330
      Left            =   0
      TabIndex        =   3
      Top             =   0
      Width           =   5100
      _ExtentX        =   8996
      _ExtentY        =   582
      ButtonWidth     =   609
      ButtonHeight    =   582
      AllowCustomize  =   0   'False
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Aceptar"
            Description     =   "Aceptar"
            Object.ToolTipText     =   "Aceptar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Description     =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
   End
   Begin VB.DriveListBox Drive1 
      Height          =   315
      Left            =   105
      TabIndex        =   2
      Top             =   600
      Width           =   4950
   End
   Begin Threed.SSFrame SSFrame1 
      Height          =   2700
      Left            =   0
      TabIndex        =   0
      Top             =   350
      Width           =   5100
      _Version        =   65536
      _ExtentX        =   8996
      _ExtentY        =   4762
      _StockProps     =   14
      Caption         =   "Destino"
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
      Begin VB.DirListBox Dir1 
         Height          =   1890
         Left            =   105
         TabIndex        =   1
         Top             =   675
         Width           =   4950
      End
   End
End
Attribute VB_Name = "FRM_INTERFACES"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim sOpcionSistema As String

Private Sub Btnimprimir()
Dim cRuta As String
       
    If Dir1.Path = "C:\" Then
        cRuta = Dir1.Path
    Else
        cRuta = Dir1.Path & "\"
    End If
   
    If FRM_INTERFACES.Tag = "Interfaz Operaciones" Then
        Call InterfazOperaciones(cRuta)
       
    ElseIf FRM_INTERFACES.Tag = "Interfaz Flujos" Then
        Call InterfazFlujoXOperacion(cRuta)
        
    ElseIf FRM_INTERFACES.Tag = "Interfaz Balance" Then
        Call InterfazBalanceXOperacion(cRuta)
        
    ElseIf FRM_INTERFACES.Tag = "Interfaz Descalce" Then
        'Call InterfazDescalce(cRuta)
        
    ElseIf FRM_INTERFACES.Tag = "Interfaz Cliente Operacion" Then
        Call InterfazClienteOperacion(cRuta)
        
    End If
      
End Sub
Private Sub Drive1_Change()

On Error GoTo Error

   Dir1.Path = Drive1

   Exit Sub
    
Error:
   MsgBox Err.Description, vbExclamation, "Interfaz"
   Drive1 = "C:"
   Dir1.Path = GLB_Ruta_Int_Contable
   Exit Sub

End Sub

Private Sub Form_Load()
    Drive1 = "C:"
    Dir1.Path = GLB_Ruta_Int_Contable
    
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

    Select Case Button.Index
        Case 1      '"Aceptar"
            Call Btnimprimir
        Case 2      '"Salir"
            Unload Me
    End Select
    
End Sub
