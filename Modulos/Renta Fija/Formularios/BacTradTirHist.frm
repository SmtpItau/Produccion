VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacTradTirHist 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Reporte Cartera"
   ClientHeight    =   2475
   ClientLeft      =   45
   ClientTop       =   345
   ClientWidth     =   4875
   Icon            =   "BacTradTirHist.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   2475
   ScaleWidth      =   4875
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   2
      Top             =   0
      Width           =   4875
      _ExtentX        =   8599
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
      Height          =   2010
      Left            =   45
      TabIndex        =   0
      Top             =   405
      Width           =   4800
      Begin VB.ComboBox Cmb_fam_inst 
         Height          =   315
         Left            =   2160
         TabIndex        =   9
         Text            =   "Combo1"
         Top             =   1440
         Width           =   2535
      End
      Begin VB.ComboBox Cmb_clasInst 
         Height          =   315
         Left            =   2160
         TabIndex        =   8
         Text            =   "Combo1"
         Top             =   1080
         Width           =   2535
      End
      Begin VB.ComboBox cmbTCart 
         Height          =   315
         ItemData        =   "BacTradTirHist.frx":030A
         Left            =   2160
         List            =   "BacTradTirHist.frx":030C
         Style           =   2  'Dropdown List
         TabIndex        =   4
         Top             =   720
         Width           =   2535
      End
      Begin BACControles.TXTNumero TXTNum 
         Height          =   315
         Left            =   2160
         TabIndex        =   3
         Top             =   360
         Width           =   975
         _ExtentX        =   1720
         _ExtentY        =   556
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
               Picture         =   "BacTradTirHist.frx":030E
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacTradTirHist.frx":062A
               Key             =   ""
            EndProperty
         EndProperty
      End
      Begin VB.Label Lbl_fam_inst 
         BackStyle       =   0  'Transparent
         Caption         =   "Familia de Inst."
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
         Height          =   435
         Left            =   195
         TabIndex        =   7
         Top             =   1440
         Width           =   1725
      End
      Begin VB.Label Lbl_clasInst 
         BackStyle       =   0  'Transparent
         Caption         =   "Clasificación de Inst."
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
         Left            =   195
         TabIndex        =   6
         Top             =   1080
         Width           =   1725
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
         Left            =   195
         TabIndex        =   5
         Top             =   720
         Width           =   1725
      End
      Begin VB.Label Label1 
         BackStyle       =   0  'Transparent
         Caption         =   "Media Interbancaria"
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
         Left            =   195
         TabIndex        =   1
         Top             =   360
         Width           =   1725
      End
   End
End
Attribute VB_Name = "BacTradTirHist"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim objTipCar       As New ClsCodigos
Dim objclaseInst As New ClsCodigos
Dim objfamInst  As New ClsCodigos

Private Sub Form_Activate()
    If Me.Tag = "CTRTotal" Then
        Me.Caption = "Informe de Cartera Total"
        Label1.Enabled = False
        TXTNum.Enabled = False
        Lbl_clasInst.Visible = False
        Cmb_clasInst.Visible = False
        Lbl_fam_inst.Visible = False
        Cmb_fam_inst.Visible = False
        Me.ScaleHeight = 1740
        Frame1.Height = 1290
    ElseIf Me.Tag = "CTRTrading" Then
        Me.Caption = "Reporte por Tipo de Cartera "
        Label1.Enabled = True
        TXTNum.Enabled = True
    End If
End Sub

Private Sub Form_Load()
Move 0, 0

'LD1-COR-035
'''' corregido para traer cartera normativa --> cod 1111
    Call PROC_LLENA_COMBOS(cmbTCart, 1111, False, GLB_ID_SISTEMA, "", "", "", gsBac_User)
    
    'Call objTipCar.LeerCodigosItau(1111)
    'Call objTipCar.Coleccion2Control(cmbTCart)
    cmbTCart.ListIndex = 0
    
    
    Call objclaseInst.LeerCodigosItau(1622)
    Call objclaseInst.Coleccion2Control(Cmb_clasInst)
    Cmb_clasInst.AddItem "TODOS"
    Cmb_clasInst.ListIndex = 2
    
    Call objfamInst.LeerCodigosItau(1975)
    Call objfamInst.Coleccion2Control(Cmb_fam_inst)
    Cmb_fam_inst.AddItem "TODOS"
    Cmb_fam_inst.ListIndex = Cmb_fam_inst.ListCount - 1 '45
    
    
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Set objTipCar = Nothing
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Description
    Case "imprimir":
        If Me.Tag = "CTRTotal" Then
            Call Cartera_Total
        ElseIf Me.Tag = "CTRTrading" Then
            Call Imprime_RPTTh
        End If

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

   Call Limpiar_Cristal
   
   Screen.MousePointer = vbHourglass
   
   If Month(gsBac_Fecp) <> Month(gsBac_Fecx) Then
      FecIniMes = CDate("01/" + Str(Month(gsBac_Fecx)) + "/" + Str(Year(gsBac_Fecx)))
   Else
      FecIniMes = Format(gsBac_Fecp, "dd/mm/yyyy")
   End If
   

    Call Limpiar_Cristal
    Screen.MousePointer = vbHourglass
    'modificado para LD1-COR-035
    Dim Codigo As String
    Codigo = Trim(Right(cmbTCart.text, 5))
    
   '  Select Case cmbTCart.ItemData(cmbTCart.ListIndex)
    Select Case Codigo
    'modificado para LD1-COR-035
    Case "T": '---> CASE 1
            BacTrader.bacrpt.ReportFileName = RptList_Path & "reptrtirhist.RPT"
    Case "P": 'Case 2
            BacTrader.bacrpt.ReportFileName = RptList_Path & "AFStrtirhist.rpt"
    Case Else:
            MsgBox "Informe de Cartera No Existe.", vbExclamation, Me.Caption
            Screen.MousePointer = vbDefault
            Exit Sub
    End Select
    
    If FecIniMes > gsBac_Fecp And FecIniMes < gsBac_Fecx Then
        BacTrader.bacrpt.Destination = crptToWindow
        BacTrader.bacrpt.StoredProcParam(0) = BacCtrlTransMonto(CDbl(TXTNum.text))
        BacTrader.bacrpt.StoredProcParam(1) = Format(gsBac_Fecp, "YYYYMMDD")
        BacTrader.bacrpt.StoredProcParam(2) = Format(FecIniMes, "YYYYMMDD")
        BacTrader.bacrpt.StoredProcParam(3) = 0
        BacTrader.bacrpt.StoredProcParam(4) = Cmb_clasInst.ItemData(Cmb_clasInst.ListIndex)
        BacTrader.bacrpt.StoredProcParam(5) = Cmb_fam_inst.ItemData(Cmb_fam_inst.ListIndex)

        BacTrader.bacrpt.WindowTitle = "REPORTE TIR HISTORICA " & BacTradTirHist.Tag
        BacTrader.bacrpt.Connect = CONECCION
        BacTrader.bacrpt.WindowState = crptMaximized
        BacTrader.bacrpt.Action = 1
    
        BacTrader.bacrpt.Destination = crptToWindow
        BacTrader.bacrpt.StoredProcParam(0) = BacCtrlTransMonto(CDbl(TXTNum.text))
        BacTrader.bacrpt.StoredProcParam(1) = Format(FecIniMes, "YYYYMMDD")
        BacTrader.bacrpt.StoredProcParam(2) = Format(gsBac_Fecx, "YYYYMMDD")
        BacTrader.bacrpt.StoredProcParam(3) = 1
        BacTrader.bacrpt.StoredProcParam(4) = Cmb_clasInst.ItemData(Cmb_clasInst.ListIndex)
        BacTrader.bacrpt.StoredProcParam(5) = Cmb_fam_inst.ItemData(Cmb_fam_inst.ListIndex)
        
        BacTrader.bacrpt.WindowTitle = "REPORTE TIR HISTORICA " & BacTradTirHist.Tag
        BacTrader.bacrpt.Connect = CONECCION
        BacTrader.bacrpt.WindowState = crptMaximized
        BacTrader.bacrpt.Action = 1
    Else
        BacTrader.bacrpt.Destination = crptToWindow
        BacTrader.bacrpt.StoredProcParam(0) = BacCtrlTransMonto(CDbl(TXTNum.text))
        BacTrader.bacrpt.StoredProcParam(1) = Format(gsBac_Fecp, "YYYYMMDD")
        BacTrader.bacrpt.StoredProcParam(2) = Format(gsBac_Fecx, "YYYYMMDD")
        BacTrader.bacrpt.StoredProcParam(3) = 0
        BacTrader.bacrpt.StoredProcParam(4) = Cmb_clasInst.ItemData(Cmb_clasInst.ListIndex)
        BacTrader.bacrpt.StoredProcParam(5) = Cmb_fam_inst.ItemData(Cmb_fam_inst.ListIndex)
        BacTrader.bacrpt.WindowTitle = "REPORTE TIR HISTORICA " & BacTradTirHist.Tag
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

Private Sub TXTNum_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        If Me.Tag = "CTRTotal" Then
            Cartera_Total
        ElseIf Me.Tag = "CTRTrading" Then
            Imprime_RPTTh
        End If
    End If
End Sub


Private Sub Cartera_Total()
Dim Datos()
Dim Fecha_Proceso_Dev      As String         'Fecha Proceso del devengo
Dim Fecha_Proximo_Dev      As String         'Fecha Proximo Proceso del devengo
Dim Fecha_Cierre_Mes       As String         'Cierre de Mes
Dim Fecha_Proceso          As String         'Fecha Proceso
Dim Fecha_Proximo_Proceso  As String         'Fecha Proximo Proceso
Dim iSwDev As Integer
On Error GoTo Err_RptT

    If Bac_Sql_Execute("sp_chkfechasdevengamiento") Then
        Do While Bac_SQL_Fetch(Datos())
            Fecha_Proceso = Datos(1)
            Fecha_Proximo_Proceso = Datos(2)
            Fecha_Cierre_Mes = Datos(3)
        Loop
    End If
    Fecha_Proceso_Dev = Fecha_Proceso
    Fecha_Proximo_Dev = Fecha_Cierre_Mes

    iSwDev = 0

    If Fecha_Proceso_Dev = Fecha_Proximo_Dev Then
      iSwDev = 1
    End If

    Screen.MousePointer = vbHourglass
    Call Limpiar_Cristal
     'modificado para LD1-COR-035
    Dim Codigo As String
    Codigo = Trim(Right(cmbTCart.text, 5))
    
    
    'Select Case cmbTCart.ItemData(cmbTCart.ListIndex)
    Select Case Codigo
     'modificado para LD1-COR-035
    Case "T": 'Case 1 --> Trading (negociacion)
            BacTrader.bacrpt.ReportFileName = RptList_Path & "carttot.rpt"
    Case "P": 'Case 2 --> Disponible para la venta
            BacTrader.bacrpt.ReportFileName = RptList_Path & "carttotAFS.rpt"
    Case Else:
            MsgBox "Informe de Cartera No Existe.", vbExclamation, Me.Caption
            Screen.MousePointer = vbDefault
            Exit Sub
    End Select

    BacTrader.bacrpt.Destination = crptToWindow
    BacTrader.bacrpt.StoredProcParam(0) = 0
    BacTrader.bacrpt.WindowTitle = "CARTERA TOTAL"
    BacTrader.bacrpt.Connect = CONECCION
    BacTrader.bacrpt.WindowState = crptMaximized
    BacTrader.bacrpt.Action = 1
    

    If Fecha_Cierre_Mes <> Fecha_Proximo_Proceso And iSwDev = 0 Then
       Screen.MousePointer = vbHourglass
       Call Limpiar_Cristal
       BacTrader.bacrpt.Destination = crptToWindow
       BacTrader.bacrpt.StoredProcParam(0) = 1
       BacTrader.bacrpt.WindowTitle = "CARTERA TOTAL"
       BacTrader.bacrpt.Connect = CONECCION
       BacTrader.bacrpt.WindowState = crptMaximized
       BacTrader.bacrpt.Action = 1

    End If

'  ***********************************************************************************
'  Se incorpora la actualizacion de los limites ALCO para reporte de Limites ALCO se imprima al Fin de Dia.
'  Se debe tener en cuenta que esta actualizacion sera calculada con los valores de moneda del dia y una vez que se
'  realize el inicio de dia del dia siguiente los limites se recalcularan nuevamnte pero con los valores de moneda del dia
'  siguiente, por lo tanto existira una diferencia entre el reporte de cierre y el reporte de inico de dia siguiente
'  (Esto se conversó y se aclaro con Benjamin Levi quedando este conforme con este punto 29/10/2002) -- VMGS --.
     
'''    '+++jcamposd 20160606, no se utiliza en el nuevo banco
'''    If Not Proc_Recalcula_Limites_ALCO Then
'''      MsgBox "Problemas al Actualizar Lineas de Limites ALCO.", vbAbortRetryIgnore, Me.Caption
'''   End If
'''    '---jcamposd 20160606, no se utiliza en el nuevo banco
'  ***********************************************************************************


    Screen.MousePointer = vbDefault
Exit Sub

Err_RptT:
    Screen.MousePointer = vbDefault
    MsgBox err.Description, vbCritical, TITSISTEMA
    Exit Sub

End Sub
