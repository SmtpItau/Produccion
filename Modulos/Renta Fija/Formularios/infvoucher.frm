VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BACControles.ocx"
Begin VB.Form infvoucher 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Informe Vouchers"
   ClientHeight    =   1185
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   3165
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   1185
   ScaleWidth      =   3165
   ShowInTaskbar   =   0   'False
   Begin VB.Frame Frame1 
      Height          =   1095
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   3135
      Begin Threed.SSCommand SSCommand1 
         Height          =   615
         Left            =   2400
         TabIndex        =   3
         Top             =   240
         Width           =   615
         _Version        =   65536
         _ExtentX        =   1085
         _ExtentY        =   1085
         _StockProps     =   78
         Picture         =   "infvoucher.frx":0000
      End
      Begin BACControles.TXTFecha txtFecha1 
         Height          =   255
         Left            =   840
         TabIndex        =   2
         Top             =   360
         Width           =   1455
         _ExtentX        =   2566
         _ExtentY        =   450
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
         Text            =   "13/08/2001"
      End
      Begin VB.Label Label1 
         Caption         =   "Fecha"
         Height          =   255
         Left            =   120
         TabIndex        =   1
         Top             =   360
         Width           =   855
      End
   End
End
Attribute VB_Name = "infvoucher"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub Form_Load()
    Me.Icon = BacTrader.Icon
    Me.txtFecha1.Text = Format(gsBac_Fecp, "dd/mm/yyyy")
End Sub

Private Sub SSCommand1_Click()
         Dim TitRpt As String
         Screen.MousePointer = vbHourglass
         Call Limpiar_Cristal
         TitRpt = "INFORME OPERACIONES CONTABILIZADAS AL " & Me.txtFecha1.Text
         BacTrader.bacrpt.Connect = CONECCION
         BacTrader.bacrpt.ReportFileName = RptList_Path & "VOUCHER.RPT"
         BacTrader.bacrpt.StoredProcParam(0) = Format(txtFecha1.Text, "yyyymmdd")
         BacTrader.bacrpt.Formulas(0) = "tit='" & TitRpt & "'"
         BacTrader.bacrpt.Action = 1
         Screen.MousePointer = vbDefault
End Sub


