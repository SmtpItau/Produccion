VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Begin VB.Form frmLogUsuario 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Detalles Log Auditoria"
   ClientHeight    =   6585
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   9120
   Icon            =   "frmLogUsuario.frx":0000
   LinkTopic       =   "Form2"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   6585
   ScaleWidth      =   9120
   ShowInTaskbar   =   0   'False
   Begin VB.TextBox txtVA 
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
      Height          =   1005
      Left            =   360
      Locked          =   -1  'True
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   8
      Top             =   3840
      Width           =   8295
   End
   Begin VB.TextBox txtEvento 
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
      Height          =   285
      Left            =   5520
      Locked          =   -1  'True
      TabIndex        =   7
      Text            =   "txtEvento"
      Top             =   1560
      Width           =   3255
   End
   Begin VB.TextBox txtOpMenu 
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
      Height          =   285
      Left            =   2160
      Locked          =   -1  'True
      TabIndex        =   6
      Text            =   "txtOpMenu"
      Top             =   2640
      Width           =   6615
   End
   Begin VB.TextBox txtModulo 
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
      Height          =   285
      Left            =   1800
      Locked          =   -1  'True
      TabIndex        =   5
      Text            =   "txtModulo"
      Top             =   1200
      Width           =   2775
   End
   Begin VB.TextBox txtFechaP 
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
      Height          =   285
      Left            =   1800
      Locked          =   -1  'True
      TabIndex        =   4
      Text            =   "txtFechaP"
      Top             =   1560
      Width           =   1695
   End
   Begin VB.TextBox txtHora 
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
      Height          =   285
      Left            =   5520
      Locked          =   -1  'True
      TabIndex        =   3
      Text            =   "txtHora"
      Top             =   1920
      Width           =   1335
   End
   Begin VB.TextBox txtTerminal 
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
      Height          =   285
      Left            =   5520
      Locked          =   -1  'True
      TabIndex        =   2
      Text            =   "txtTerminal"
      Top             =   1200
      Width           =   3255
   End
   Begin VB.TextBox txtUsuario 
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
      Height          =   285
      Left            =   1800
      Locked          =   -1  'True
      TabIndex        =   1
      Text            =   "txtUsuario"
      Top             =   840
      Width           =   2775
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   3120
      Top             =   0
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
            Picture         =   "frmLogUsuario.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmLogUsuario.frx":0624
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmLogUsuario.frx":093E
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmLogUsuario.frx":0D90
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frmLogUsuario.frx":11E2
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   9120
      _ExtentX        =   16087
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Imprimir"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   5
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin VB.Frame Frame1 
      Caption         =   "Modificacion de Datos"
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
      Height          =   3015
      Left            =   240
      TabIndex        =   9
      Top             =   3360
      Width           =   8655
      Begin VB.TextBox txtVN 
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
         Height          =   1005
         Left            =   120
         Locked          =   -1  'True
         MultiLine       =   -1  'True
         ScrollBars      =   2  'Vertical
         TabIndex        =   18
         Top             =   1800
         Width           =   8295
      End
      Begin VB.Label Label11 
         Caption         =   "Valor Nuevo :"
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
         Left            =   240
         TabIndex        =   24
         Top             =   240
         Width           =   1455
      End
      Begin VB.Label Label10 
         Caption         =   "Valor Anterior :"
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
         Left            =   240
         TabIndex        =   23
         Top             =   1560
         Width           =   1575
      End
   End
   Begin Threed.SSPanel SSPanel1 
      Height          =   5895
      Left            =   120
      TabIndex        =   10
      Top             =   600
      Width           =   8895
      _Version        =   65536
      _ExtentX        =   15690
      _ExtentY        =   10398
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
      BorderWidth     =   0
      BevelOuter      =   1
      BevelInner      =   2
      Alignment       =   0
      Begin VB.TextBox txtEntidad 
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
         Height          =   285
         Left            =   5400
         Locked          =   -1  'True
         TabIndex        =   28
         Text            =   "txtEntidad"
         Top             =   240
         Width           =   3255
      End
      Begin VB.TextBox txtTabla 
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
         Height          =   285
         Left            =   2040
         Locked          =   -1  'True
         TabIndex        =   25
         Text            =   "txtTabla"
         Top             =   1680
         Width           =   6615
      End
      Begin VB.TextBox txtFechaS 
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
         Height          =   285
         Left            =   1680
         Locked          =   -1  'True
         TabIndex        =   22
         Text            =   "txtFechaS"
         Top             =   1320
         Width           =   1695
      End
      Begin VB.TextBox txtDetalle 
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
         Height          =   285
         Left            =   2040
         Locked          =   -1  'True
         TabIndex        =   19
         Text            =   "txtDetalle"
         Top             =   2400
         Width           =   6615
      End
      Begin VB.Label Label13 
         Caption         =   "Entidad"
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
         Left            =   4560
         TabIndex        =   27
         Top             =   240
         Width           =   855
      End
      Begin VB.Label Label12 
         Caption         =   "Tabla Afectada"
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
         Left            =   240
         TabIndex        =   26
         Top             =   1680
         Width           =   1335
      End
      Begin VB.Label Label9 
         Caption         =   "Fecha Sistema"
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
         Left            =   240
         TabIndex        =   21
         Top             =   1320
         Width           =   1335
      End
      Begin VB.Label Label8 
         Caption         =   "Detalle Transaccion"
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
         Left            =   240
         TabIndex        =   20
         Top             =   2400
         Width           =   1815
      End
      Begin VB.Label Label3 
         Caption         =   "Hora"
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
         Left            =   4560
         TabIndex        =   17
         Top             =   1320
         Width           =   855
      End
      Begin VB.Label Label4 
         Caption         =   "Fecha Porceso"
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
         Left            =   240
         TabIndex        =   16
         Top             =   960
         Width           =   1335
      End
      Begin VB.Label Label1 
         Caption         =   "Nombre Usuario"
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
         Left            =   240
         TabIndex        =   15
         Top             =   240
         Width           =   1695
      End
      Begin VB.Label Label2 
         Caption         =   "Terminal"
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
         Left            =   4560
         TabIndex        =   14
         Top             =   600
         Width           =   855
      End
      Begin VB.Label Label5 
         Caption         =   "Modulo"
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
         Left            =   240
         TabIndex        =   13
         Top             =   600
         Width           =   1455
      End
      Begin VB.Label Label6 
         Caption         =   "Opcione Menu"
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
         Left            =   240
         TabIndex        =   12
         Top             =   2040
         Width           =   1455
      End
      Begin VB.Label Label7 
         Caption         =   "Evento"
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
         Left            =   4560
         TabIndex        =   11
         Top             =   960
         Width           =   735
      End
   End
End
Attribute VB_Name = "frmLogUsuario"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private Sub Form_Load()
    Me.Top = 1400
    Me.Left = 200
    Cargar_Usuario
End Sub
Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

Select Case Button.Index
   
    Case 1
         Imprimir
    Case 2
        Unload Me

End Select

End Sub

Sub Cargar_Usuario()
With frmLogAuditoria.Grd

    txtEntidad.Text = .TextMatrix(logFila, 0)
    txtFechaP.Text = .TextMatrix(logFila, 1)
    txtFechaS.Text = .TextMatrix(logFila, 2)
    txtHora.Text = .TextMatrix(logFila, 3)
    txtTerminal.Text = .TextMatrix(logFila, 4)
    txtUsuario.Text = .TextMatrix(logFila, 5)
    txtModulo.Text = .TextMatrix(logFila, 6)
    txtOpMenu.Text = .TextMatrix(logFila, 7)
    txtEvento.Text = .TextMatrix(logFila, 8)
    txtDetalle.Text = .TextMatrix(logFila, 9)
    txtTabla.Text = .TextMatrix(logFila, 10)
    txtVA.Text = .TextMatrix(logFila, 11)
    txtVN.Text = .TextMatrix(logFila, 12)
        
End With
End Sub
Sub Imprimir()
Dim SQL_Informe As String

On Error GoTo Errores
   
    LimpiarRPT
    
    Screen.MousePointer = vbHourglass
    BACSwapParametros.BACParam.Destination = crptToWindow
    BACSwapParametros.BACParam.ReportFileName = gsRPT_Path & "BacLogAuditoriaUsuario.RPT"
    BACSwapParametros.BACParam.WindowTitle = "INFORME DE LOG DE AUDITORIA"
    BACSwapParametros.BACParam.StoredProcParam(0) = txtEntidad.Text
    BACSwapParametros.BACParam.StoredProcParam(1) = txtHora.Text
    BACSwapParametros.BACParam.StoredProcParam(2) = txtTerminal.Text
    BACSwapParametros.BACParam.StoredProcParam(3) = txtUsuario.Text
    BACSwapParametros.BACParam.StoredProcParam(4) = txtModulo.Text
    BACSwapParametros.BACParam.Connect = SwConeccion
    BACSwapParametros.BACParam.WindowState = crptMaximized
    BACSwapParametros.BACParam.Action = 1
    Screen.MousePointer = vbDefault
Exit Sub

Errores:
     
     MsgBox Err.Description, vbInformation + vbOKOnly, TITSISTEMA: Screen.MousePointer = vbDefault: Exit Sub


End Sub
Sub LimpiarRPT()
Dim i As Integer
    For i = 0 To 20
        BACSwapParametros.BACParam.StoredProcParam(i) = ""
        
    Next i

End Sub

