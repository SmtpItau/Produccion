VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form BacCierreMesa 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Cierre de Mesa"
   ClientHeight    =   1785
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   3015
   Icon            =   "BacCierreMesa.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   1785
   ScaleWidth      =   3015
   ShowInTaskbar   =   0   'False
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   2265
      Top             =   30
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
            Picture         =   "BacCierreMesa.frx":0442
            Key             =   "CERRAR"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacCierreMesa.frx":0894
            Key             =   "ABRIR"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacCierreMesa.frx":0CE6
            Key             =   "ESPERAR"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacCierreMesa.frx":1138
            Key             =   "SALIR"
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Height          =   450
      Left            =   0
      TabIndex        =   4
      Top             =   0
      Width           =   3015
      _ExtentX        =   5318
      _ExtentY        =   794
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "MESA"
            Object.ToolTipText     =   "Abrir Mesa"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "CERRAR"
            Object.ToolTipText     =   "Cerrar"
            ImageIndex      =   4
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin Threed.SSPanel SSPanel1 
      Height          =   1305
      Left            =   30
      TabIndex        =   0
      Top             =   450
      Width           =   2970
      _Version        =   65536
      _ExtentX        =   5239
      _ExtentY        =   2302
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
      Begin VB.Frame Frame1 
         BorderStyle     =   0  'None
         Height          =   1185
         Left            =   105
         TabIndex        =   1
         Top             =   105
         Width           =   2760
         Begin VB.CommandButton cmdAceptar 
            Height          =   705
            Left            =   1875
            Picture         =   "BacCierreMesa.frx":1452
            Style           =   1  'Graphical
            TabIndex        =   2
            Top             =   135
            Width           =   795
         End
         Begin VB.Image Image1 
            Height          =   480
            Index           =   0
            Left            =   1800
            Picture         =   "BacCierreMesa.frx":1894
            Top             =   1440
            Visible         =   0   'False
            Width           =   480
         End
         Begin VB.Image Image1 
            Height          =   480
            Index           =   1
            Left            =   2295
            Picture         =   "BacCierreMesa.frx":1CD6
            Top             =   1440
            Visible         =   0   'False
            Width           =   480
         End
         Begin VB.Label lblEtiqueta 
            Alignment       =   2  'Center
            Caption         =   "Label1"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   12
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H000000C0&
            Height          =   825
            Left            =   90
            TabIndex        =   3
            Top             =   195
            Width           =   1500
         End
      End
   End
End
Attribute VB_Name = "BacCierreMesa"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub CmdAceptar_Click()
    
    If gsc_Parametros.cierreMesa And BacCierreMesa.Tag = "N" Then
       MsgBox "Sólo se Puede Bloquear la Mesa", vbOKOnly, TITSISTEMA
       Exit Sub
    End If
 
    Call gsc_Parametros.CierreDeMesa
    
    If gsc_Parametros.cierreMesa = "1" Then
        CmdAceptar.Picture = Me.Image1(0).Picture
        
        Me.Toolbar1.Buttons(1).Image = "ABRIR"
        Me.Toolbar1.ToolTipText = "Abrir Mesa"
        
        Me.lblEtiqueta.Caption = "Mesa Cerrada"
        Me.lblEtiqueta.ForeColor = 192
               
    Else
         CmdAceptar.Picture = Me.Image1(1).Picture
         
         Me.Toolbar1.Buttons(1).Image = "CERRAR"
         Me.Toolbar1.ToolTipText = "Cerrar Mesa"
         
         Me.lblEtiqueta.Caption = "Mesa Abierta"
         Me.lblEtiqueta.ForeColor = 32768
         
    End If
    Call GRABA_LOG_AUDITORIA("Opc_20700", "01", "GRABA", "", "", "")
End Sub


Private Sub Form_Load()
    Me.Icon = BACSwap.Icon
    
    'PRD-5149, jbh, 12-01-2010, para evitar que el formulario "pasee" por toda la pantalla
    Me.Top = 0
    Me.Left = 0
    
    Me.lblEtiqueta.Caption = ""
    
    If gsc_Parametros.cierreMesa = "1" Then
        CmdAceptar.Picture = Me.Image1(0).Picture
        
        Me.Toolbar1.Buttons(1).Image = "ABRIR"
        Me.Toolbar1.ToolTipText = "Abrir Mesa"
        
        Me.lblEtiqueta.Caption = "Mesa Cerrada"
        Me.lblEtiqueta.ForeColor = 192
               
    Else
         CmdAceptar.Picture = Me.Image1(1).Picture
         
         Me.Toolbar1.Buttons(1).Image = "CERRAR"
         Me.Toolbar1.ToolTipText = "Cerrar Mesa"
         
         Me.lblEtiqueta.Caption = "Mesa Abierta"
         Me.lblEtiqueta.ForeColor = 32768
         
    End If
    
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

    Select Case Button.Key
       Case Is = UCase("mesa")
          CmdAceptar_Click
       Case Is = UCase("cerrar")
          Unload Me
    End Select
    
End Sub
