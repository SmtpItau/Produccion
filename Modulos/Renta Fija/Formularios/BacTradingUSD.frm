VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BACControles.ocx"
Begin VB.Form BacTradingUSD 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Cartera Trading USD"
   ClientHeight    =   1650
   ClientLeft      =   45
   ClientTop       =   750
   ClientWidth     =   4035
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   1650
   ScaleWidth      =   4035
   Begin VB.Frame Frame1 
      Height          =   1050
      Left            =   120
      TabIndex        =   0
      Top             =   480
      Width           =   3840
      Begin BACControles.TXTNumero TXTNum 
         Height          =   255
         Left            =   2280
         TabIndex        =   1
         Top             =   360
         Width           =   975
         _ExtentX        =   1720
         _ExtentY        =   450
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
         Text            =   "0.0000"
         Text            =   "0.0000"
         Min             =   "-999"
         Max             =   "999"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
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
               Picture         =   "BacTradingUSD.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacTradingUSD.frx":031C
               Key             =   ""
            EndProperty
         EndProperty
      End
      Begin VB.Label Label1 
         Caption         =   "Tasa O/N"
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
         Width           =   1725
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   3
      Top             =   0
      Width           =   4035
      _ExtentX        =   7117
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
End
Attribute VB_Name = "BacTradingUSD"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Sub Imprime_RPTTh()

   
   Dim FecIniMes As Date
   
   On Error GoTo ERR_Imprime_RPT

   If CDbl(TXTNum.text) = 0 Then
      MsgBox "Tasa O/N no debe esta en cero", vbCritical, Me.Caption
      Exit Sub
   End If

   Call Limpiar_Cristal
   
   Screen.MousePointer = vbHourglass
   
   If Month(gsBac_Fecp) <> Month(gsBac_Fecx) Then
      FecIniMes = CDate("01/" + Str(Month(gsBac_Fecx)) + "/" + Str(Year(gsBac_Fecx)))
   Else
      FecIniMes = Format(gsBac_Fecp, "dd/mm/yyyy")
   End If
   

   Call Limpiar_Cristal

   Screen.MousePointer = vbHourglass



   If FecIniMes > gsBac_Fecp And FecIniMes < gsBac_Fecx Then

      BacTrader.bacrpt.Destination = crptToWindow
      BacTrader.bacrpt.ReportFileName = RptList_Path & "rep_trading_usd.rpt"
      BacTrader.bacrpt.StoredProcParam(0) = BacCtrlTransMonto(CDbl(TXTNum.text))
      BacTrader.bacrpt.StoredProcParam(1) = Format(gsBac_Fecp, "YYYYMMDD")
      BacTrader.bacrpt.StoredProcParam(2) = Format(FecIniMes, "YYYYMMDD")
      BacTrader.bacrpt.StoredProcParam(3) = 0
      BacTrader.bacrpt.WindowTitle = "REPORTE TRADING USD"
      BacTrader.bacrpt.Connect = CONECCION
      BacTrader.bacrpt.WindowState = crptMaximized
      BacTrader.bacrpt.Action = 1


      BacTrader.bacrpt.Destination = crptToWindow
      BacTrader.bacrpt.ReportFileName = RptList_Path & "rep_trading_usd.rpt"
      BacTrader.bacrpt.StoredProcParam(0) = BacCtrlTransMonto(CDbl(TXTNum.text))
      BacTrader.bacrpt.StoredProcParam(1) = Format(FecIniMes, "YYYYMMDD")
      BacTrader.bacrpt.StoredProcParam(2) = Format(gsBac_Fecx, "YYYYMMDD")
      BacTrader.bacrpt.StoredProcParam(3) = 1
      BacTrader.bacrpt.WindowTitle = "REPORTE TRADING USD"
      BacTrader.bacrpt.Connect = CONECCION
      BacTrader.bacrpt.WindowState = crptMaximized
      BacTrader.bacrpt.Action = 1


   Else
   
      BacTrader.bacrpt.Destination = crptToWindow
      BacTrader.bacrpt.ReportFileName = RptList_Path & "rep_trading_usd.rpt"
      BacTrader.bacrpt.StoredProcParam(0) = BacCtrlTransMonto(CDbl(TXTNum.text))
      BacTrader.bacrpt.StoredProcParam(1) = Format(gsBac_Fecp, "YYYYMMDD")
      BacTrader.bacrpt.StoredProcParam(2) = Format(gsBac_Fecx, "YYYYMMDD")
      BacTrader.bacrpt.StoredProcParam(3) = 0
      BacTrader.bacrpt.WindowTitle = "REPORTE TRADING USD"
      BacTrader.bacrpt.Connect = CONECCION
      BacTrader.bacrpt.WindowState = crptMaximized
      BacTrader.bacrpt.Action = 1


   End If
   
   Screen.MousePointer = vbDefault
    
Exit Sub
ERR_Imprime_RPT:
    MsgBox err.Description, vbCritical, TITSISTEMA
    Screen.MousePointer = vbDefault
    Exit Sub
    
End Sub

Private Sub Form_Load()
Move 0, 0
End Sub


Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Description
    Case "imprimir": Imprime_RPTTh
    Case "salir": Unload Me
End Select

End Sub

Private Sub TXTNum_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
       Call Imprime_RPTTh
   End If

End Sub
