VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "Mscomctl.ocx"
Object = "{989C9190-EDF5-45A8-AB6C-98E6EF0384D7}#1.0#0"; "Bac_Controles_Pas.ocx"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form FRM_ING_INICIODIA 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Inicio de Día Centralizado"
   ClientHeight    =   5565
   ClientLeft      =   3405
   ClientTop       =   2010
   ClientWidth     =   6735
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5565
   ScaleWidth      =   6735
   ShowInTaskbar   =   0   'False
   Begin VB.Frame FRM_Monedas 
      Height          =   3975
      Left            =   30
      TabIndex        =   5
      Top             =   1560
      Width           =   6660
      Begin MSFlexGridLib.MSFlexGrid GRD_ValoresMoneda 
         Height          =   3570
         Left            =   120
         TabIndex        =   6
         Top             =   240
         Width           =   6435
         _ExtentX        =   11351
         _ExtentY        =   6297
         _Version        =   393216
         Cols            =   5
         FixedCols       =   0
         RowHeightMin    =   260
         BackColor       =   -2147483644
         ForeColor       =   8388608
         BackColorFixed  =   8421376
         ForeColorFixed  =   16777215
         BackColorSel    =   8388608
         ForeColorSel    =   16777215
         BackColorBkg    =   -2147483644
         GridColor       =   255
         FillStyle       =   1
         GridLines       =   2
         GridLinesFixed  =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
   End
   Begin VB.Frame FRM_Fechas 
      Enabled         =   0   'False
      Height          =   1065
      Left            =   30
      TabIndex        =   0
      Top             =   480
      Width           =   6660
      Begin BACControles.TXTFecha TXT_Fecha_Prox 
         Height          =   315
         Left            =   120
         TabIndex        =   1
         Top             =   600
         Width           =   1290
         _ExtentX        =   2275
         _ExtentY        =   556
         Enabled         =   -1  'True
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
         MaxDate         =   402133
         MinDate         =   18264
         Text            =   "07/11/2000"
      End
      Begin BACControles.TXTFecha TXT_Fecha_Hoy 
         Height          =   315
         Left            =   120
         TabIndex        =   2
         Top             =   240
         Width           =   1290
         _ExtentX        =   2275
         _ExtentY        =   556
         Enabled         =   -1  'True
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
         MaxDate         =   402133
         MinDate         =   18264
         Text            =   "07/11/2000"
      End
      Begin VB.Label LBL_FecPrx 
         BackColor       =   &H00FFFFFF&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   315
         Left            =   1545
         TabIndex        =   4
         Top             =   615
         Width           =   5010
      End
      Begin VB.Label LBL_FecPro 
         BackColor       =   &H00FFFFFF&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   315
         Left            =   1545
         TabIndex        =   3
         Top             =   255
         Width           =   5010
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   5250
      Top             =   -90
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   24
      ImageHeight     =   24
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   2
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_ING_INICIODIA.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_ING_INICIODIA.frx":0EDA
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar TBL_Menu 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   7
      Top             =   0
      Width           =   6735
      _ExtentX        =   11880
      _ExtentY        =   847
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Procesar"
            Description     =   "Procesar"
            Object.ToolTipText     =   "Procesar Inicio de Dia"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Description     =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
End
Attribute VB_Name = "FRM_ING_INICIODIA"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim objInicioDia         As New CLS_InicioDia

Sub PROC_Setea_Grilla()

   With GRD_ValoresMoneda
      .ColWidth(0) = 3530
      .ColWidth(1) = 2000
      .ColWidth(2) = 0
      .ColWidth(3) = 0
      .ColWidth(4) = 0

      .RowHeight(0) = 350
      .CellFontWidth = 4
      .Row = 0

      .Col = 0
      .FixedAlignment(0) = 4
      .CellFontBold = True
      .Text = " Moneda/Tasa "
      .ColAlignment(0) = 2

      .Col = 1
      .FixedAlignment(1) = 4
      .CellFontBold = True
      .Text = " Proceso "
      .ColAlignment(1) = 8

'      .Col = 2
'      .FixedAlignment(2) = 4
'      .CellFontBold = True
'      .Text = " Proximo Proceso "
'      .ColAlignment(2) = 8

   End With

End Sub

Private Sub Form_Activate()
   PROC_CARGA_AYUDA Me
End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)

   Select Case KeyAscii
   Case VbKeyProcesar
      If TBL_Menu.Buttons(1).Enabled Then
         'Call TBL_Menu_ButtonClick(TBL_Menu.Buttons(1))

      End If

   Case vbKeySalir
      Unload Me

   End Select

End Sub

Private Sub Form_Load()

    PROC_Setea_Grilla

    Me.Icon = FRM_MDI_PASIVO.Icon
    Me.Left = 0
    Me.Top = 0
   
    'MDI_MENU.TmrMsg.Enabled = False
    Me.TXT_Fecha_Hoy.Text = GLB_Fecha_Proxima
    Me.TXT_Fecha_Prox.Text = GLB_Fecha_Proxima
    
    LBL_FecPro.Caption = FUNC_Format_Fecha(TXT_Fecha_Hoy.Text, "DDDD", "MMMM", "AAAA")
    LBL_FecPrx.Caption = FUNC_Format_Fecha(TXT_Fecha_Prox.Text, "DDDD", "MMMM", "AAAA")

    PROC_LOG_AUDITORIA "07", GLB_cOptLocal, Me.Caption, "", ""

End Sub

Private Sub Form_Unload(Cancel As Integer)
  PROC_LOG_AUDITORIA "08", GLB_cOptLocal, Me.Caption, "", ""
  
End Sub





