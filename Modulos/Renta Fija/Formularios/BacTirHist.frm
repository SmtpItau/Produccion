VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacRepTirHist 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Informe Tir Historica"
   ClientHeight    =   1740
   ClientLeft      =   45
   ClientTop       =   345
   ClientWidth     =   4830
   Icon            =   "BacTirHist.frx":0000
   LinkTopic       =   "Form2"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   1740
   ScaleWidth      =   4830
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   2
      Top             =   0
      Width           =   4830
      _ExtentX        =   8520
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
      Height          =   1290
      Left            =   30
      TabIndex        =   0
      Top             =   405
      Width           =   4785
      Begin VB.ComboBox cmbTCart 
         Height          =   315
         ItemData        =   "BacTirHist.frx":030A
         Left            =   2116
         List            =   "BacTirHist.frx":030C
         Style           =   2  'Dropdown List
         TabIndex        =   4
         Top             =   720
         Width           =   2475
      End
      Begin BACControles.TXTNumero TXTNum 
         Height          =   300
         Left            =   2116
         TabIndex        =   3
         Top             =   360
         Width           =   855
         _ExtentX        =   1508
         _ExtentY        =   529
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
         Text            =   "0,0000"
         Text            =   "0,0000"
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
               Picture         =   "BacTirHist.frx":030E
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacTirHist.frx":062A
               Key             =   ""
            EndProperty
         EndProperty
      End
      Begin VB.Label Label2 
         BackStyle       =   0  'Transparent
         Caption         =   "Cartera"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   315
         Left            =   200
         TabIndex        =   5
         Top             =   720
         Width           =   1725
      End
      Begin VB.Label Label1 
         BackStyle       =   0  'Transparent
         Caption         =   "Media Interbancaria"
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
         Left            =   200
         TabIndex        =   1
         Top             =   405
         Width           =   1725
      End
   End
End
Attribute VB_Name = "BacRepTirHist"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim objTipCar       As New ClsCodigos

Private Sub Form_Load()
    Move 0, 0
    
'LD1-COR-035
'''' corregido para traer cartera normativa --> cod 1111
    'Call objTipCar.LeerCodigosItau(1111)
    'Call objTipCar.Coleccion2Control(cmbTCart)
    
'LD1-COR-035
'''' corregido para traer cartera normativa --> cod 1111
    Call PROC_LLENA_COMBOS(cmbTCart, 1111, False, GLB_ID_SISTEMA, "", "", "", gsBac_User)
    
    cmbTCart.ListIndex = 0 '--**
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Set objTipCar = Nothing
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Description
    Case "imprimir": Imprime_RPTTh
    Case "salir": Unload Me
End Select
End Sub
Sub Imprime_RPTTh()
Dim FecIniMes As Date
   
On Error GoTo ERR_Imprime_RPT
    
    If CDbl(TXTNum.text) = 0 Then
        MsgBox "Media Interbancaria no debe esta en cero", vbCritical, Me.Caption
        Exit Sub
    End If
    
    Screen.MousePointer = vbHourglass
    If Month(gsBac_Fecp) <> Month(gsBac_Fecx) Then
        FecIniMes = CDate("01/" + Str(Month(gsBac_Fecx)) + "/" + Str(Year(gsBac_Fecx)))
    Else
        FecIniMes = Format(gsBac_Fecp, "dd/mm/yyyy")
    End If

    Screen.MousePointer = vbHourglass
    'modificado para LD1-COR-035
    Dim codigo As String
    codigo = Trim(Right(cmbTCart.text, 5))
    
       ' Select Case cmbTCart.ItemData(cmbTCart.ListIndex)
        Select Case codigo
        Case "T": BacTrader.bacrpt.ReportFileName = RptList_Path & "reptirhist.RPT"
        Case "P": BacTrader.bacrpt.ReportFileName = RptList_Path & "AFStirhist.RPT"
        Case Else:
            MsgBox "Informe de Cartera No Existe.", vbExclamation, Me.Caption
            Screen.MousePointer = vbDefault
            Exit Sub
        End Select

   
    If FecIniMes > gsBac_Fecp And FecIniMes < gsBac_Fecx Then

       '-------------------------------------------------------------------------
        Call Limpiar_Cristal
       '-------------------------------------------------------------------------
        BacTrader.bacrpt.Destination = crptToWindow
       'BacTrader.bacrpt.ReportFileName = RptList_Path & "reptirhist.RPT"
        BacTrader.bacrpt.StoredProcParam(0) = BacCtrlTransMonto(CDbl(TXTNum.text))
        BacTrader.bacrpt.StoredProcParam(1) = Format(gsBac_Fecp, "YYYYMMDD")
        BacTrader.bacrpt.StoredProcParam(2) = Format(FecIniMes, "YYYYMMDD")
        BacTrader.bacrpt.StoredProcParam(3) = 0
        BacTrader.bacrpt.WindowTitle = "REPORTE TIR HISTORICA " & Me.Tag
        BacTrader.bacrpt.Connect = CONECCION
        BacTrader.bacrpt.WindowState = crptMaximized
        BacTrader.bacrpt.Action = 1
       '-------------------------------------------------------------------------
        Call Limpiar_Cristal
       '-------------------------------------------------------------------------
        BacTrader.bacrpt.Destination = crptToWindow
       'BacTrader.bacrpt.ReportFileName = RptList_Path & "reptirhist.RPT"
        BacTrader.bacrpt.StoredProcParam(0) = BacCtrlTransMonto(CDbl(TXTNum.text))
        BacTrader.bacrpt.StoredProcParam(1) = Format(FecIniMes, "YYYYMMDD")
        BacTrader.bacrpt.StoredProcParam(2) = Format(gsBac_Fecx, "YYYYMMDD")
        BacTrader.bacrpt.StoredProcParam(3) = 1
        BacTrader.bacrpt.WindowTitle = "REPORTE TIR HISTORICA " & Me.Tag
        BacTrader.bacrpt.Connect = CONECCION
        BacTrader.bacrpt.WindowState = crptMaximized
        BacTrader.bacrpt.Action = 1
    Else
       '-------------------------------------------------------------------------
        Call Limpiar_Cristal
       '-------------------------------------------------------------------------
        BacTrader.bacrpt.Destination = crptToWindow
       'BacTrader.bacrpt.ReportFileName = RptList_Path & "reptirhist.RPT"
        BacTrader.bacrpt.StoredProcParam(0) = BacCtrlTransMonto(CDbl(TXTNum.text))
        BacTrader.bacrpt.StoredProcParam(1) = Format(gsBac_Fecp, "YYYYMMDD")
        BacTrader.bacrpt.StoredProcParam(2) = Format(gsBac_Fecx, "YYYYMMDD")
        BacTrader.bacrpt.StoredProcParam(3) = 0
        BacTrader.bacrpt.WindowTitle = "REPORTE TIR HISTORICA " & Me.Tag
        BacTrader.bacrpt.Connect = CONECCION
        BacTrader.bacrpt.WindowState = crptMaximized
        BacTrader.bacrpt.Action = 1
    End If
    
    '-------------------------------------------------------------------------
     Call Limpiar_Cristal
    '-------------------------------------------------------------------------
    BacTrader.bacrpt.Destination = crptToWindow
    BacTrader.bacrpt.ReportFileName = RptList_Path & "rep_formas.RPT"
    BacTrader.bacrpt.WindowTitle = "REPORTE TIR HISTORICA " & Me.Tag
    BacTrader.bacrpt.Connect = CONECCION
    BacTrader.bacrpt.WindowState = crptMaximized
    BacTrader.bacrpt.Action = 1
    Screen.MousePointer = vbDefault
    Exit Sub

ERR_Imprime_RPT:
    MsgBox err.Description, vbCritical, TITSISTEMA
    Screen.MousePointer = vbDefault
    Exit Sub
    
End Sub

Private Sub TXTNum_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
       Call Imprime_RPTTh
   End If
End Sub
