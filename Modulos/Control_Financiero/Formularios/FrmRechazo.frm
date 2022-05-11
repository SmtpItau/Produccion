VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BACCONTROLES.OCX"
Begin VB.Form FrmRechazo 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Informe de Rechazados"
   ClientHeight    =   1275
   ClientLeft      =   2670
   ClientTop       =   1935
   ClientWidth     =   5130
   Icon            =   "FrmRechazo.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   1275
   ScaleWidth      =   5130
   Begin Threed.SSFrame SSFrame1 
      Height          =   735
      Left            =   0
      TabIndex        =   0
      Top             =   525
      Width           =   5100
      _Version        =   65536
      _ExtentX        =   8996
      _ExtentY        =   1296
      _StockProps     =   14
      Caption         =   "Fechas "
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   1
      Begin BACControles.TXTFecha txtFechaInicio 
         Height          =   315
         Left            =   840
         TabIndex        =   4
         Top             =   300
         Width           =   1575
         _ExtentX        =   2778
         _ExtentY        =   556
         Enabled         =   -1  'True
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "24/11/2003"
      End
      Begin BACControles.TXTFecha txtFechaTermino 
         Height          =   315
         Left            =   3360
         TabIndex        =   5
         Top             =   300
         Width           =   1575
         _ExtentX        =   2778
         _ExtentY        =   556
         Enabled         =   -1  'True
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "24/11/2003"
      End
      Begin VB.Label Label3 
         BackColor       =   &H00808000&
         BackStyle       =   0  'Transparent
         Caption         =   "Desde"
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
         Left            =   105
         TabIndex        =   1
         Top             =   345
         Width           =   1140
      End
      Begin VB.Label Label1 
         BackColor       =   &H00808000&
         BackStyle       =   0  'Transparent
         Caption         =   "Hasta"
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
         Left            =   2715
         TabIndex        =   3
         Top             =   345
         Width           =   960
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   2
      Top             =   0
      Width           =   5130
      _ExtentX        =   9049
      _ExtentY        =   847
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Imprimir"
            Object.ToolTipText     =   "Imprimir"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Preliminar"
            Object.ToolTipText     =   "Vista Previa"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   6090
         Top             =   -60
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   24
         ImageHeight     =   24
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   3
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FrmRechazo.frx":000C
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FrmRechazo.frx":0EE6
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FrmRechazo.frx":1200
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
End
Attribute VB_Name = "FrmRechazo"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub Form_Load()
   Me.Icon = BacControlFinanciero.Icon
   Me.txtFechaInicio.Text = gsBAC_Fecp
   Me.txtFechaTermino.Text = gsBAC_Fecp
   Me.Left = 0:   Me.Top = 0
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

Select Case UCase(Button.Index)
     Case 1, 2
            
            Call Limpiar_Cristal
            If Button.Index = 1 Then
                BacControlFinanciero.CryFinanciero.Destination = 1
            Else
                BacControlFinanciero.CryFinanciero.Destination = 0
            End If
            BacControlFinanciero.CryFinanciero.ReportFileName = gsRPT_Path & "\Informe_Rechazados.rpt"

            BacControlFinanciero.CryFinanciero.StoredProcParam(0) = Format(txtFechaInicio.Text, "yyyy-mm-dd 00:00:00.000")
            BacControlFinanciero.CryFinanciero.StoredProcParam(1) = Format(txtFechaTermino.Text, "yyyy-mm-dd 00:00:00.000")
            BacControlFinanciero.CryFinanciero.StoredProcParam(2) = "R"
            BacControlFinanciero.CryFinanciero.Connect = swConeccion
            BacControlFinanciero.CryFinanciero.Action = 1
            MousePointer = 0
    Case 3
        Unload Me
End Select

End Sub
