VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form FRM_FILTRO_FLI 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Filtro FLI.-"
   ClientHeight    =   4950
   ClientLeft      =   2805
   ClientTop       =   5415
   ClientWidth     =   7530
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4950
   ScaleWidth      =   7530
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   7530
      _ExtentX        =   13282
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin Threed.SSFrame ssfLCGP 
      Height          =   615
      Left            =   0
      TabIndex        =   4
      Top             =   480
      Width           =   7455
      _Version        =   65536
      _ExtentX        =   13150
      _ExtentY        =   1085
      _StockProps     =   14
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin VB.OptionButton optTGR 
         Caption         =   "Instrumentos TGR"
         Height          =   195
         Left            =   3960
         TabIndex        =   9
         Top             =   280
         Width           =   2535
      End
      Begin VB.OptionButton optBCCH 
         Caption         =   "Instrumentos BCCH"
         Height          =   195
         Left            =   600
         TabIndex        =   8
         Top             =   280
         Width           =   2535
      End
      Begin Threed.SSCheck CHK_LCGP 
         Height          =   255
         Left            =   0
         TabIndex        =   7
         Top             =   0
         Width           =   1335
         _Version        =   65536
         _ExtentX        =   2355
         _ExtentY        =   450
         _StockProps     =   78
         Caption         =   "LCGP BCCH"
         ForeColor       =   16711680
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Font3D          =   3
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   7080
      Top             =   3720
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
            Picture         =   "FRM_FILTRO_FLI.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_FILTRO_FLI.frx":0EDA
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.Frame Frame1 
      Height          =   3900
      Left            =   30
      TabIndex        =   1
      Top             =   1035
      Width           =   7485
      Begin MSComctlLib.ListView LstCartFin 
         Height          =   3735
         Left            =   30
         TabIndex        =   2
         Top             =   120
         Width           =   3645
         _ExtentX        =   6429
         _ExtentY        =   6588
         View            =   3
         MultiSelect     =   -1  'True
         LabelWrap       =   0   'False
         HideSelection   =   -1  'True
         Checkboxes      =   -1  'True
         FullRowSelect   =   -1  'True
         HotTracking     =   -1  'True
         _Version        =   393217
         ForeColor       =   -2147483640
         BackColor       =   -2147483643
         BorderStyle     =   1
         Appearance      =   1
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         NumItems        =   0
      End
      Begin MSComctlLib.ListView LstCartNor 
         Height          =   3735
         Left            =   3705
         TabIndex        =   3
         Top             =   120
         Width           =   3705
         _ExtentX        =   6535
         _ExtentY        =   6588
         View            =   3
         MultiSelect     =   -1  'True
         LabelWrap       =   0   'False
         HideSelection   =   -1  'True
         Checkboxes      =   -1  'True
         FullRowSelect   =   -1  'True
         HotTracking     =   -1  'True
         _Version        =   393217
         ForeColor       =   -2147483640
         BackColor       =   -2147483643
         BorderStyle     =   1
         Appearance      =   1
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         NumItems        =   0
      End
   End
   Begin Threed.SSFrame SSFrame1 
      Height          =   495
      Left            =   0
      TabIndex        =   5
      Top             =   0
      Width           =   3375
      _Version        =   65536
      _ExtentX        =   5953
      _ExtentY        =   873
      _StockProps     =   14
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin Threed.SSCheck SSCheck2 
      Height          =   255
      Left            =   0
      TabIndex        =   6
      Top             =   0
      Width           =   1695
      _Version        =   65536
      _ExtentX        =   2990
      _ExtentY        =   450
      _StockProps     =   78
      Caption         =   "LCGP BCCH"
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
End
Attribute VB_Name = "FRM_FILTRO_FLI"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Const Descripcion = 1
Const Codigo = 2

Dim BacFrm                          'PRD-6006 CASS 24-12-2010

Private Sub Nombres(ByRef xListado As ListView, ByVal cCaption As String)
   xListado.ColumnHeaders.Clear
   xListado.ColumnHeaders.Add Descripcion, "A", cCaption, 3580
   xListado.ColumnHeaders.Add Codigo, "B", "N° CODIGO", 1
End Sub

Private Sub LCGP_Habilitar(bFlag As Boolean)
optBCCH.Value = False
optBCCH.Enabled = bFlag
optBCCH.Value = False
optTGR.Enabled = bFlag
End Sub

Private Sub CHK_LCGP_Click(Value As Integer) '20181221.RCH.LCGP
    LCGP_Habilitar (IIf(CHK_LCGP.Value, True, False))
    If Not CHK_LCGP.Value Then
         Set BacFrm = BacTrader.ActiveForm
         BacFrm.LGCP_Familia = ""
    End If
End Sub

Private Sub Form_Load()
   Let Me.Icon = BacTrader.Icon
   Set BacFrm = BacTrader.ActiveForm 'PRD-6006 CASS 24-12-2010
   Me.Caption = IIf(BacFrm.Name = "Frm_Vtas_con_Pcto", "FILTRO VENTAS CON PACTO", "FILTRO FLI")
   Call Nombres(LstCartFin, "CARTERA NORMATIVA")
   Call Nombres(LstCartNor, "CARTERA FINANCIERA")
   
   Call LCGP_Habilitar(False) '20181221.RCH.LCGP
   
   Let BacFrm.iAceptar = False
   Call CargaCatera(1111, LstCartFin)
   Call CargaCatera(204, LstCartNor)
   
   FRM_FILTRO_FLI.CHK_LCGP.Enabled = IIf(BacFrm.CHK_FCIC.Value = True, False, True)
   
   If Me.Caption = "FILTRO VENTAS CON PACTO" Then '20181227.RCH.LCGP
    If BacFrm.LGCP_Familia <> "" Then
         CHK_LCGP.Value = True
         optBCCH.Value = IIf(BacFrm.LGCP_Familia = "BCCH", True, False)
         optTGR.Value = IIf(BacFrm.LGCP_Familia = "TGR", True, False)
    Else
         optBCCH.Value = IIf(BacFrm.LGCP_Familia = "BCCH", True, False)
         optTGR.Value = IIf(BacFrm.LGCP_Familia = "TGR", True, False)
    End If
   ElseIf Me.Caption = "FILTRO FLI" Then '20190118.RCH.FLI
     If BacFrm.FLI_Familia <> "" Then
         CHK_LCGP.Value = True
         CHK_LCGP.Visible = False
         optBCCH.Value = IIf(BacFrm.FLI_Familia = "BCCH", True, False)
         optTGR.Value = IIf(BacFrm.FLI_Familia = "TGR", True, False)
    Else
         CHK_LCGP.Value = True
         CHK_LCGP.Visible = False
         optBCCH.Value = IIf(BacFrm.FLI_Familia = "BCCH", True, False)
         optTGR.Value = IIf(BacFrm.FLI_Familia = "TGR", True, False)
    End If
   Else
     ssfLCGP.Visible = False        '20181221.RCH.LCGP
     Frame1.Top = 480
     Me.Height = Me.Height - 400
   '  Frame1.Height =
   End If
End Sub

Private Function CargaCatera(ByVal iCodigo As Integer, ByRef xListado As ListView) As Boolean
   Dim Datos()

   Let CargaCatera = False

   Envia = Array()
   AddParam Envia, iCodigo
   If Not Bac_Sql_Execute("SP_LEE_CARTERAS", Envia) Then
      Call MsgBox("Se ha originado un error en la consulta SQL.", vbExclamation, App.Title)
      Exit Function
   End If
   xListado.ListItems.Clear
   Do While Bac_SQL_Fetch(Datos())
      xListado.ListItems.Add , , Datos(2)
      xListado.ListItems.Item(xListado.ListItems.Count).ListSubItems.Add , , Datos(1)
   Loop

   Let CargaCatera = True
End Function

Private Sub optBCCH_Click()
'20190118.RCH.FLI
If Me.Caption = "FILTRO VENTAS CON PACTO" Then
    BacFrm.LGCP_Familia = ""
    BacFrm.LGCP_Familia = "BCCH"

ElseIf Me.Caption = "FILTRO FLI" Then
    BacFrm.FLI_Familia = ""
    BacFrm.FLI_Familia = "BCCH"
End If
  
End Sub

Private Sub optTGR_Click()
'20190118.RCH.FLI
If Me.Caption = "FILTRO VENTAS CON PACTO" Then
    BacFrm.LGCP_Familia = ""
    BacFrm.LGCP_Familia = "TGR"

ElseIf Me.Caption = "FILTRO FLI" Then
    BacFrm.FLI_Familia = ""
    BacFrm.FLI_Familia = "TGR"
End If

End Sub


Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Let BacFrm.iAceptar = False

   Select Case Button.Index
      Case 1
         Call BuscarCarteras
         
         If Len(BacFrm.CarterasFinancieras) = 0 Or Len(BacFrm.CarterasNormativas) = 0 Then
           ' Call MsgBox("Debe seleccionar al menos un registro por cartera Financiera y Nomativa.", vbExclamation, App.Title)
           ' Let BACFLI.iAceptar = True
           ' Exit Sub
         End If

         Let BacFrm.iAceptar = True
         Call Unload(Me)
      Case 2
         Call Unload(Me)
   End Select

End Sub


Private Function BuscarCarteras()
   Dim nContador As Long
   
   Let BacFrm.CarterasFinancieras = ""
      
   For nContador = 1 To LstCartFin.ListItems.Count
      If LstCartFin.ListItems.Item(nContador).Checked = True Then
         Let BacFrm.CarterasFinancieras = BacFrm.CarterasFinancieras & "-" & LstCartFin.ListItems(nContador).ListSubItems(1).text
      End If
   Next nContador
  
   Let BacFrm.CarterasNormativas = ""
   For nContador = 1 To LstCartNor.ListItems.Count
      If LstCartNor.ListItems.Item(nContador).Checked = True Then
         Let BacFrm.CarterasNormativas = BacFrm.CarterasNormativas & "-" & LstCartNor.ListItems(nContador).ListSubItems(1).text
      End If
   Next nContador

End Function
