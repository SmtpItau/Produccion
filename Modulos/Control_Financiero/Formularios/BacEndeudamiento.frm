VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacEndeudamiento 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Endeudamiento"
   ClientHeight    =   1830
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   8130
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   1830
   ScaleMode       =   0  'User
   ScaleWidth      =   14468.19
   Begin VB.Frame Frame1 
      Height          =   1305
      Left            =   0
      TabIndex        =   0
      Top             =   450
      Width           =   8085
      Begin BACControles.TXTNumero txtActivo 
         Height          =   315
         Left            =   2400
         TabIndex        =   1
         Top             =   360
         Width           =   2325
         _ExtentX        =   4101
         _ExtentY        =   556
         ForeColor       =   -2147483635
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0,00"
         Text            =   "0,00"
         CantidadDecimales=   "2"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTNumero txtEndeudamiento_1 
         Height          =   315
         Left            =   2400
         TabIndex        =   2
         Top             =   720
         Width           =   915
         _ExtentX        =   1614
         _ExtentY        =   556
         ForeColor       =   -2147483635
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0,00"
         Text            =   "0,00"
         Min             =   "-99"
         Max             =   "99"
         CantidadDecimales=   "2"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTNumero txtFWD_Perd 
         Height          =   315
         Left            =   7050
         TabIndex        =   3
         Top             =   360
         Width           =   915
         _ExtentX        =   1614
         _ExtentY        =   556
         ForeColor       =   -2147483635
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0,00"
         Text            =   "0,00"
         Min             =   "-99"
         Max             =   "99"
         CantidadDecimales=   "2"
         Separator       =   -1  'True
      End
      Begin BACControles.TXTNumero txtMax_1 
         Height          =   315
         Left            =   7050
         TabIndex        =   4
         Top             =   720
         Width           =   915
         _ExtentX        =   1614
         _ExtentY        =   556
         ForeColor       =   -2147483635
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0,00"
         Text            =   "0,00"
         Min             =   "-99"
         Max             =   "99"
         CantidadDecimales=   "2"
         Separator       =   -1  'True
      End
      Begin VB.Label Label1 
         Caption         =   "Activo Circulante"
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
         Height          =   255
         Left            =   180
         TabIndex        =   8
         Top             =   390
         Width           =   2200
      End
      Begin VB.Label Label2 
         Caption         =   "% Endeudamiento Instituciones Financieras"
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
         Height          =   525
         Left            =   180
         TabIndex        =   7
         Top             =   720
         Width           =   2200
      End
      Begin VB.Label Label4 
         Caption         =   "% FWD Perdida Diferida"
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
         Height          =   255
         Left            =   4800
         TabIndex        =   6
         Top             =   390
         Width           =   2085
      End
      Begin VB.Label Label5 
         Caption         =   "% Máx. Endeudamiento Instituciones Financieras"
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
         Height          =   525
         Left            =   4800
         TabIndex        =   5
         Top             =   720
         Width           =   2175
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   5040
      Top             =   0
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
            Picture         =   "BacEndeudamiento.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacEndeudamiento.frx":0320
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacEndeudamiento.frx":0772
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   9
      Top             =   0
      Width           =   8130
      _ExtentX        =   14340
      _ExtentY        =   794
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
End
Attribute VB_Name = "BacEndeudamiento"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Form_Activate()
    Call Proc_Carga
End Sub

Private Sub Form_Load()
    Me.top = 0
    Me.Left = 0
End Sub

Private Sub Proc_Carga()
Dim Datos()

Dim procedimiento As String

    If Not Bac_Sql_Execute(gsBac_Parametros + ".dbo.Sp_Carga_Endeudamiento") Then
        MsgBox "Error al Carga Datos de Endeudamiento", 16, Me.Caption
        Exit Sub
    End If
    
    If Bac_SQL_Fetch(Datos()) Then
        txtActivo.Text = Format(Datos(1), FDecimal)
        txtEndeudamiento_1.Text = Format(Datos(2), FDecimal)
        txtFWD_Perd.Text = Format(Datos(4), FDecimal)
        txtMax_1.Text = Format(Datos(3), FDecimal)
    End If

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
    Select Case Button.Index
        Case 1
            Proc_Grabar
    
        Case 3
            Unload Me
    End Select
End Sub

Private Sub Proc_Grabar()
        
    Envia = Array()
    AddParam Envia, CDbl(txtActivo.Text)
    AddParam Envia, CDbl(txtEndeudamiento_1.Text)
    AddParam Envia, CDbl(txtMax_1.Text)
    AddParam Envia, CDbl(txtFWD_Perd.Text)
        
    If Not Bac_Sql_Execute(gsBac_Parametros + ".dbo.Sp_Graba_Endeudamiento", Envia) Then
        MsgBox "Problemas en la Grabación", 16, Me.Caption
        Exit Sub
    Else
        MsgBox "Datos Han sido Grabados Correctamente", vbInformation, Me.Caption
    End If

End Sub

