VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form FRM_GEN_INFORME_DCV 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Informe Operaciones al DCV"
   ClientHeight    =   1350
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   3720
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   1350
   ScaleWidth      =   3720
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   3720
      _ExtentX        =   6562
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
            Object.ToolTipText     =   "Imprimir"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Vista Previa"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Cerrar Ventana"
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   1680
         Top             =   255
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
               Picture         =   "FRM_GEN_INFORME_DCV.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_GEN_INFORME_DCV.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_GEN_INFORME_DCV.frx":1DB4
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame Frame1 
      Height          =   915
      Left            =   30
      TabIndex        =   1
      Top             =   435
      Width           =   3675
      Begin BACControles.TXTFecha FechaCorta 
         Height          =   315
         Left            =   1905
         TabIndex        =   3
         Top             =   150
         Width           =   1470
         _ExtentX        =   2593
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
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "24/04/2006"
      End
      Begin VB.Label Etiquetas 
         Alignment       =   2  'Center
         BackColor       =   &H80000004&
         Caption         =   "Miercoles, 26 de Septiembre del 2006"
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
         Height          =   330
         Index           =   1
         Left            =   90
         TabIndex        =   4
         Top             =   555
         Width           =   3495
      End
      Begin VB.Label Etiquetas 
         Alignment       =   2  'Center
         AutoSize        =   -1  'True
         Caption         =   "Fecha de Generación"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Index           =   0
         Left            =   90
         TabIndex        =   2
         Top             =   195
         Width           =   1740
      End
   End
End
Attribute VB_Name = "FRM_GEN_INFORME_DCV"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub FechaCorta_Change()
   Etiquetas(1).Caption = Format(FechaCorta.Text, "dddd, dd") & " de " & Format(FechaCorta.Text, "mmmm") & " del " & Format(FechaCorta.Text, "yyyy")
End Sub

Private Sub Form_Load()
   Me.Top = 0: Me.Left = 0
   Me.Icon = BacTrader.Icon
   
   FechaCorta.Text = Format(gsBac_Fecp, "dd/mm/yyyy")
End Sub

Private Sub PrintInformeOp(MiDestino As DestinationConstants, MiFecha As Date)
   On Error GoTo ErrImpresion
   
   Call Limpiar_Cristal
   BacTrader.bacrpt.WindowTitle = "Informe de Operaciones enviadas a DCV [DBO.SVC_INFORME_OPERACIONES]"
   BacTrader.bacrpt.ReportTitle = "Informe de Operaciones enviadas a DCV [DBO.SVC_INFORME_OPERACIONES]"
   BacTrader.bacrpt.WindowState = crptMaximized
   BacTrader.bacrpt.Destination = MiDestino
   BacTrader.bacrpt.ReportFileName = RptList_Path & "Informe_Estado_OperacionesDcv.rpt"
                    ' Store Procedure : DBO.SVC_INFORME_OPERACIONES.sql
   BacTrader.bacrpt.StoredProcParam(0) = Format(MiFecha, "yyyy-mm-dd 00:00:00.000")
   BacTrader.bacrpt.StoredProcParam(1) = gsBac_User
   BacTrader.bacrpt.Connect = CONECCION
   BacTrader.bacrpt.Action = 1

   
   Call Limpiar_Cristal
   BacTrader.bacrpt.WindowTitle = "Informe de Operaciones enviadas a DCV [DBO.SVC_INFORME_OPERACIONES]"
   BacTrader.bacrpt.ReportTitle = "Informe de Operaciones enviadas a DCV [DBO.SVC_INFORME_OPERACIONES]"
   BacTrader.bacrpt.WindowState = crptMaximized
   BacTrader.bacrpt.Destination = MiDestino
   BacTrader.bacrpt.ReportFileName = RptList_Path & "Informe_Operaciones_Enviadas.rpt"
                    ' Store Procedure : DBO.SVC_INFORME_OPERACIONES.sql
   BacTrader.bacrpt.StoredProcParam(0) = Format(MiFecha, "yyyy-mm-dd 00:00:00.000")
   BacTrader.bacrpt.StoredProcParam(1) = gsBac_User
   BacTrader.bacrpt.Connect = CONECCION
   BacTrader.bacrpt.Action = 1
   
Exit Sub
ErrImpresion:
   MsgBox "Error de impresión" & vbCrLf & vbCrLf & err.Description, vbExclamation, TITSISTEMA
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 1
         Call PrintInformeOp(crptToPrinter, FechaCorta.Text)
      Case 2
         Call PrintInformeOp(crptToWindow, FechaCorta.Text)
      Case 3
         Unload Me
   End Select
End Sub
