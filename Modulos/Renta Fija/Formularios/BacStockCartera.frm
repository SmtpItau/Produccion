VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BACControles.ocx"
Begin VB.Form BacStockCartera 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Informe Stock de cartera"
   ClientHeight    =   1500
   ClientLeft      =   45
   ClientTop       =   345
   ClientWidth     =   3945
   Icon            =   "BacStockCartera.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   1500
   ScaleWidth      =   3945
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   3
      Top             =   0
      Width           =   3945
      _ExtentX        =   6959
      _ExtentY        =   794
      ButtonWidth     =   767
      ButtonHeight    =   741
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Description     =   "imprimir"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Description     =   "salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin VB.Frame Frame1 
      Height          =   1050
      Left            =   45
      TabIndex        =   0
      Top             =   405
      Width           =   3840
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   3330
         Top             =   180
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   2
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacStockCartera.frx":030A
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacStockCartera.frx":0626
               Key             =   ""
            EndProperty
         EndProperty
      End
      Begin BACControles.TXTFecha txtFecha 
         Height          =   285
         Left            =   1890
         TabIndex        =   1
         Top             =   405
         Width           =   1410
         _ExtentX        =   2487
         _ExtentY        =   503
         Enabled         =   -1  'True
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
         ForeColor       =   8388608
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "07/09/2001"
      End
      Begin VB.Label Label1 
         Caption         =   "Fecha Proceso"
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
         Left            =   270
         TabIndex        =   2
         Top             =   405
         Width           =   1365
      End
   End
End
Attribute VB_Name = "BacStockCartera"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Form_Load()
Me.TXTFecha.text = gsBac_Fecp
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Description
    Case "imprimir": Imprime_RPT
    Case "salir": Unload Me
End Select
End Sub
Sub Imprime_RPT()
On Error GoTo ERR_Imprime_RPT_Stock
 If Me.TXTFecha.text < gsBac_Fecp Then
    MsgBox "Fecha debe ser mayor o Igual a Fecha de Proceso", vbCritical
    Me.TXTFecha.text = gsBac_Fecp
    Exit Sub
 End If
    Call Limpiar_Cristal
    Screen.MousePointer = vbHourglass
    Call Limpiar_Cristal
    BacTrader.bacrpt.Destination = crptToWindow
    BacTrader.bacrpt.ReportFileName = RptList_Path & "bacstockcartera.rpt"
    BacTrader.bacrpt.StoredProcParam(0) = Format(Me.TXTFecha.text, "yyyymmdd")
    BacTrader.bacrpt.WindowTitle = "STOCK CARTERA"
    BacTrader.bacrpt.Connect = CONECCION
    BacTrader.bacrpt.WindowState = crptMaximized
    BacTrader.bacrpt.Action = 1
    '-----------Resumen
    Call Limpiar_Cristal
    BacTrader.bacrpt.Destination = crptToWindow
    BacTrader.bacrpt.ReportFileName = RptList_Path & "saldos_cartera.rpt"
    BacTrader.bacrpt.WindowTitle = "RESUMEN STOCK CARTERA"
    BacTrader.bacrpt.Connect = CONECCION
    BacTrader.bacrpt.WindowState = crptMaximized
    BacTrader.bacrpt.Action = 1

    Screen.MousePointer = vbDefault
    Exit Sub
       
Exit Sub
ERR_Imprime_RPT_Stock:
    MsgBox err.Description, vbCritical, TITSISTEMA
    Screen.MousePointer = vbDefault
    Exit Sub
End Sub

Private Sub TXTFecha_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
      Call Imprime_RPT
   End If
End Sub
