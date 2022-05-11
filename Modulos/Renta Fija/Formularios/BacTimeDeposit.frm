VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{05BDEB52-1755-11D5-9109-000102BF881D}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacTimeDeposit 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Time Deposit e Interbancarios"
   ClientHeight    =   3195
   ClientLeft      =   1905
   ClientTop       =   1800
   ClientWidth     =   7380
   ForeColor       =   &H00C0C0C0&
   Icon            =   "BacTimeDeposit.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   Moveable        =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   3195
   ScaleWidth      =   7380
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   6570
      Top             =   -30
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   25
      ImageHeight     =   25
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   3
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacTimeDeposit.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacTimeDeposit.frx":075C
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacTimeDeposit.frx":0A76
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin Threed.SSPanel SSPanel1 
      Height          =   2610
      Left            =   45
      TabIndex        =   1
      Top             =   555
      Width           =   7305
      _Version        =   65536
      _ExtentX        =   12885
      _ExtentY        =   4604
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
      BevelInner      =   1
      Begin Threed.SSFrame SSFrame1 
         Height          =   735
         Left            =   75
         TabIndex        =   2
         Top             =   75
         Width           =   7095
         _Version        =   65536
         _ExtentX        =   12515
         _ExtentY        =   1296
         _StockProps     =   14
         Caption         =   "Tipo Operación"
         ForeColor       =   8388608
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Font3D          =   3
         Begin Threed.SSPanel Pnl_FecProceso 
            Height          =   315
            Left            =   5040
            TabIndex        =   3
            Top             =   300
            Width           =   1440
            _Version        =   65536
            _ExtentX        =   2540
            _ExtentY        =   556
            _StockProps     =   15
            ForeColor       =   0
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            BevelOuter      =   1
         End
         Begin Threed.SSCheck ChkCap 
            Height          =   315
            Left            =   195
            TabIndex        =   4
            Top             =   315
            Width           =   1110
            _Version        =   65536
            _ExtentX        =   1958
            _ExtentY        =   556
            _StockProps     =   78
            Caption         =   "Captación"
            ForeColor       =   0
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Value           =   -1  'True
         End
         Begin Threed.SSCheck ChkCol 
            Height          =   315
            Left            =   1710
            TabIndex        =   5
            Top             =   315
            Width           =   1410
            _Version        =   65536
            _ExtentX        =   2487
            _ExtentY        =   556
            _StockProps     =   78
            Caption         =   "Colocación"
            ForeColor       =   0
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
         End
         Begin VB.Label Label6 
            AutoSize        =   -1  'True
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
            Height          =   195
            Left            =   3675
            TabIndex        =   7
            Top             =   330
            Width           =   1290
         End
         Begin VB.Label Label1 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00C00000&
            Height          =   315
            Left            =   6525
            TabIndex        =   6
            Top             =   315
            Width           =   450
         End
      End
      Begin Threed.SSFrame SSFrame3 
         Height          =   1725
         Left            =   90
         TabIndex        =   8
         Top             =   780
         Width           =   7080
         _Version        =   65536
         _ExtentX        =   12488
         _ExtentY        =   3043
         _StockProps     =   14
         Caption         =   "Operación"
         ForeColor       =   8388608
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Font3D          =   3
         Begin VB.ComboBox CmbMoneda 
            Appearance      =   0  'Flat
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   315
            ItemData        =   "BacTimeDeposit.frx":0D90
            Left            =   3915
            List            =   "BacTimeDeposit.frx":0D92
            Style           =   2  'Dropdown List
            TabIndex        =   14
            Top             =   540
            Width           =   1140
         End
         Begin BacControles.txtNumero IntBase 
            Height          =   255
            Left            =   7080
            TabIndex        =   9
            Top             =   1080
            Visible         =   0   'False
            Width           =   1215
            _ExtentX        =   2143
            _ExtentY        =   450
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
            Max             =   "99999999999.9999999"
         End
         Begin BacControles.txtFecha Dtefecven 
            Height          =   315
            Left            =   3210
            TabIndex        =   10
            Top             =   1185
            Width           =   1215
            _ExtentX        =   2143
            _ExtentY        =   556
            Text            =   "13/11/2000"
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            MinDate         =   -328716
            MaxDate         =   2958465
         End
         Begin BacControles.txtNumero Intdias 
            Height          =   315
            Left            =   2490
            TabIndex        =   11
            Top             =   1185
            Width           =   495
            _ExtentX        =   873
            _ExtentY        =   556
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Text            =   "0"
            CantidadDecimales=   "0"
         End
         Begin BacControles.txtNumero FltTasa 
            Height          =   315
            Left            =   2325
            TabIndex        =   12
            Top             =   540
            Width           =   1455
            _ExtentX        =   2566
            _ExtentY        =   556
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            SelStart        =   2
            Text            =   "0.00000"
            CantidadDecimales=   "5"
         End
         Begin BacControles.txtNumero FltMtoini 
            Height          =   315
            Left            =   210
            TabIndex        =   13
            Top             =   540
            Width           =   1935
            _ExtentX        =   3413
            _ExtentY        =   556
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Text            =   "0"
            CantidadDecimales=   "0"
            Max             =   "99999999999999.999"
         End
         Begin Threed.SSPanel Lbl_Mt_Inicial 
            Height          =   315
            Left            =   165
            TabIndex        =   15
            Top             =   1200
            Width           =   2100
            _Version        =   65536
            _ExtentX        =   3704
            _ExtentY        =   556
            _StockProps     =   15
            ForeColor       =   0
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            BevelOuter      =   1
            Alignment       =   4
         End
         Begin Threed.SSPanel Lbl_Mt_Final 
            Height          =   315
            Left            =   4620
            TabIndex        =   16
            Top             =   1185
            Width           =   2310
            _Version        =   65536
            _ExtentX        =   4075
            _ExtentY        =   556
            _StockProps     =   15
            ForeColor       =   0
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            BevelOuter      =   1
            Alignment       =   4
         End
         Begin Threed.SSPanel Lbl_ValMon 
            Height          =   315
            Left            =   5280
            TabIndex        =   17
            Top             =   540
            Width           =   1650
            _Version        =   65536
            _ExtentX        =   2910
            _ExtentY        =   556
            _StockProps     =   15
            ForeColor       =   0
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            BevelOuter      =   1
            Alignment       =   4
         End
         Begin VB.Label Lbl_Titulo_Fin 
            AutoSize        =   -1  'True
            Caption         =   "Monto Final $$"
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
            Height          =   195
            Left            =   5265
            TabIndex        =   26
            Top             =   990
            Width           =   1275
         End
         Begin VB.Label Label4 
            AutoSize        =   -1  'True
            Caption         =   "Tasa Interes"
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
            Height          =   195
            Left            =   2595
            TabIndex        =   25
            Top             =   345
            Width           =   1080
         End
         Begin VB.Label Label3 
            AutoSize        =   -1  'True
            Caption         =   "Monto Inicial $$"
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
            Height          =   195
            Left            =   750
            TabIndex        =   24
            Top             =   345
            Width           =   1380
         End
         Begin VB.Label Label7 
            AutoSize        =   -1  'True
            Caption         =   "Moneda"
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
            Height          =   195
            Left            =   3930
            TabIndex        =   23
            Top             =   345
            Width           =   690
         End
         Begin VB.Label Label9 
            AutoSize        =   -1  'True
            Caption         =   "Vencimiento"
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
            Height          =   195
            Left            =   3225
            TabIndex        =   22
            Top             =   990
            Width           =   1050
         End
         Begin VB.Label Label8 
            AutoSize        =   -1  'True
            Caption         =   "Dias"
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
            Height          =   195
            Left            =   2625
            TabIndex        =   21
            Top             =   990
            Width           =   390
         End
         Begin VB.Label Label2 
            AutoSize        =   -1  'True
            Caption         =   "Valor Moneda"
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
            Height          =   195
            Left            =   5715
            TabIndex        =   20
            Top             =   345
            Width           =   1185
         End
         Begin VB.Label Lbl_Titulo_Ini 
            AutoSize        =   -1  'True
            Caption         =   "Monto Inicial $$"
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
            Height          =   195
            Left            =   840
            TabIndex        =   19
            Top             =   990
            Width           =   1410
         End
         Begin VB.Label Label5 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00C00000&
            Height          =   330
            Left            =   3870
            TabIndex        =   18
            Top             =   1185
            Width           =   450
         End
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Height          =   555
      Left            =   45
      TabIndex        =   0
      Top             =   0
      Width           =   7290
      _ExtentX        =   12859
      _ExtentY        =   979
      ButtonWidth     =   847
      ButtonHeight    =   820
      ToolTips        =   0   'False
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdGrabar"
            Description     =   "Grabar"
            Object.ToolTipText     =   "Grabar Datos"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdLimpiar"
            Description     =   "Limpiar"
            Object.ToolTipText     =   "Limpiar Pantalla"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdSalir"
            Description     =   "SAlir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
End
Attribute VB_Name = "BacTimeDeposit"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Public Moneda           As Object
Public bLoad            As Boolean
Dim Sql                 As String
Dim DATOS()

Private Sub Func_Grabar()

   BacIrfGr.proMoneda = Trim$(Mid$(CmbMoneda.Text, 1, 3))
   BacIrfGr.proMtoOper = CDbl(FltMtoini.Text)
   BacIrfGr.proHwnd = hWnd

   Call BacGrabarTX

   If Grabacion_Operacion Then
      Call Proc_Limpia_Interbancario
      FltMtoini.SetFocus
   
   End If

End Sub

Private Sub CalcInter(nNominal As String, nMtofin As String, nTasa As String, nValmon As String, nBase As String, dFecven As String, dfecpro As String, nmodal As String)

    If Lbl_ValMon.Caption > 0 Then
        Lbl_Mt_Inicial.Caption = Format(FltMtoini.Text / Lbl_ValMon.Caption, "#,##0.0000")
    Else
        Lbl_Mt_Inicial.Caption = Format(0#, "#,##0.0000")
    End If

    If nTasa = 0 Then
        Exit Sub
    End If
   
'   Sql = "SP_TIMEDEPOSIT_CALCULOINTERBANCARIO "
'   Sql = Sql & BacStrTran(nNominal, ",", ".") & ","
'   Sql = Sql & BacStrTran(Format(nMtofin, "##0.0000"), ",", ".") & ","
'   Sql = Sql & BacStrTran(nTasa, ",", ".") & ","
'   Sql = Sql & BacStrTran(Format(nValmon, "##0.0000"), ",", ".") & ","
'   Sql = Sql & nBase & ","
'   Sql = Sql & "'" & Format(dFecven, "dd/mm/yyyy") & "',"
'   Sql = Sql & "'" & Format(dfecpro, "dd/mm/yyyy") & "',"
'   Sql = Sql & nmodal & ",'" & Trim$(CmbMoneda.Text) & "'"
'   Sql = Sql & "," & Val(Intdias)
   
    Envia = Array(CDbl(nNominal), _
            CDbl(nMtofin), _
            CDbl(nTasa), _
            CDbl(nValmon), _
            CDbl(nBase), _
            Format(dFecven, "dd/mm/yyyy"), _
            Format(dfecpro, "dd/mm/yyyy"), _
            Trim$(CmbMoneda.Text), _
            CDbl(Intdias))
    
    If Not Bac_Sql_Execute("SP_TIMEDEPOSIT_CALCULOINTERBANCARIO", Envia) Then
        MsgBox "Falla SP_TIMEDEPOSIT_CALCULOINTERBANCARIO.", 16
        Exit Sub
    End If

    Do While Bac_SQL_Fetch(DATOS())
        FltMtoini.Text = Val(DATOS(1))
        FltTasa.Text = Val(DATOS(2))
        Lbl_Mt_Final.Caption = Format(Val(DATOS(3)), "#,##0.0000")
        FltMtoini.Tag = Val(DATOS(1))
        FltTasa.Tag = Val(DATOS(2))
        Lbl_Mt_Final.Tag = Val(DATOS(3))
    Loop

End Sub

Sub Proc_Limpia_Interbancario()

   Dim nSw%
   Dim nCont%

   ChkCap.Value = True

   Pnl_FecProceso.Caption = Format(gsBac_Fecp, "dd/mm/yyyy")
   Label1.Caption = Mid$(BacDiaSem(Pnl_FecProceso.Caption), 1, 3)

   nSw = 0
   nCont = 1

   Do While nSw = 0
      Intdias.Text = nCont
      Dtefecven.Text = Format$(DateAdd("d", Intdias.Text, Pnl_FecProceso.Caption), "dd/mm/yyyy")

      If EsFeriado(CDate(Dtefecven.Text), "00001") Then
         nCont = nCont + 1

      Else
         nSw = 1

      End If

   Loop

   FltMtoini.Text = 0
   FltTasa.Text = 0
   Lbl_ValMon.Caption = Format(0, "#,##0.0000")
   Lbl_Mt_Inicial.Caption = Format(0, "#,##0.0000")
   Lbl_Mt_Final.Caption = Format(0, "#,##0.0000")

   CmbMoneda.ListIndex = -1

   If CmbMoneda.ListCount > 1 Then
      CmbMoneda.ListIndex = 0

   End If

End Sub

Private Sub ChkCap_Click(Value As Integer)

   If ChkCap.Value = False Then
      ChkCol.Value = True

   Else
      ChkCol.Value = False

   End If

End Sub

Private Sub ChkCap_KeyPress(KeyAscii As Integer)

   If KeyAscii = 13 Then
      FltMtoini.SetFocus

   End If

End Sub

Private Sub ChkCol_Click(Value As Integer)

   If ChkCol.Value = False Then
      ChkCap.Value = True

   Else
      ChkCap.Value = False

   End If

End Sub

Private Sub ChkCol_KeyPress(KeyAscii As Integer)

   If KeyAscii = 13 Then
      FltMtoini.SetFocus

   End If

End Sub

Private Sub CmbMoneda_Click()
Dim X   As Integer

    If bLoad = True Then
        Exit Sub
    End If

    If CmbMoneda.ListIndex <= -1 Then
        Exit Sub
    End If

    Lbl_Titulo_Ini.Caption = "Monto Inicial " + Trim(CmbMoneda.Text)
    Lbl_Titulo_Fin.Caption = "Monto Final " + Trim(CmbMoneda.Text)

    Screen.MousePointer = vbHourglass

    If Mid$(CmbMoneda.Text, 1, 1) <> "$" And Mid$(CmbMoneda.Text, 1, 3) <> "CLP" Then
        Lbl_ValMon.Caption = Format(0#, "#,##0.0000")

'      Sql = "SP_VALBASE_MONEDA "
'      Sql = Sql & CmbMoneda.ItemData(CmbMoneda.ListIndex)
'      Sql = Sql & ",'" & Format(gsBac_Fecp, "yyyymmdd") & "',"
'      Sql = Sql & CmbMoneda.ItemData(CmbMoneda.ListIndex)

        Envia = Array(CDbl(CmbMoneda.ItemData(CmbMoneda.ListIndex)), _
                        gsBac_Fecp, _
                CDbl(CmbMoneda.ItemData(CmbMoneda.ListIndex)))

        If Not Bac_Sql_Execute("SP_VALBASE_MONEDA", Envia) Then
            Screen.MousePointer = 0
            MsgBox "NO Encuentra Datos de Moneda Seleccionada.", 16
            Exit Sub
        End If

        Do While Bac_SQL_Fetch(DATOS())
            Lbl_ValMon.Caption = Format(DATOS(1), "#,##0.0000")
            IntBase.Text = Val(DATOS(2))
        Loop

    Else
   'modificado02/02/2001
        IntBase.Text = IIf(Mid$(CmbMoneda.Text, 1, 1) = "$", 30, 30 Or IIf(Mid$(CmbMoneda.Text, 1, 1) = "CLP", 30, 30))
        Lbl_ValMon.Caption = Format(1, "#,##0.0000")

    End If

    Screen.MousePointer = 0

    Call CalcInter(FltMtoini.Text, Lbl_Mt_Final.Caption, FltTasa.Text, Lbl_ValMon.Caption, IntBase.Text, Format(Dtefecven.Text, "mm/dd/yyyy"), Format(gsBac_Fecp, "mm/dd/yyyy"), " 1")

End Sub

Private Sub cmbMoneda_KeyPress(KeyAscii As Integer)

   If KeyAscii = 13 Then
      Call Bac_SendKey(vbKeyTab)

   End If

End Sub

Private Sub Dtefecven_Change()

   Label5.Caption = Mid$(BacDiaSem(Dtefecven.Text), 1, 3)

End Sub

Private Sub dtefecven_GotFocus()

   Dtefecven.Tag = Dtefecven.Text

End Sub

Private Sub dtefecven_LostFocus()

   If Dtefecven.Tag <> Dtefecven.Text Then
      If Dtefecven.Text <> Pnl_FecProceso.Caption Then
         If BacEsHabil(Dtefecven.Text) Then
            Intdias.Text = DateDiff("d", Pnl_FecProceso.Caption, Dtefecven.Text)
            Intdias.Tag = DateDiff("d", Pnl_FecProceso.Caption, Dtefecven.Text)
            Call Bac_SendKey(vbKeyTab)
            Call CalcInter(FltMtoini.Text, Lbl_Mt_Final.Caption, FltTasa.Text, Lbl_ValMon.Caption, IntBase.Text, Format(Dtefecven.Text, "mm/dd/yyyy"), Format(gsBac_Fecp, "mm/dd/yyyy"), " 1")

         Else
            MsgBox "Fecha de Vcto. no es día Hábil", 16
            Intdias.Text = Intdias.Tag
            Dtefecven.Text = Format$(DateAdd("d", Intdias.Text, Pnl_FecProceso.Caption), "dd/mm/yyyy")

         End If

      Else
         MsgBox "Fecha de Vcto. Ingresada igual a la de Proceso; Por favor reingrese", vbCritical, "DIAS PACTOS"
         Intdias.Text = Intdias.Tag
         Dtefecven.Text = Format$(DateAdd("d", Intdias.Text, Pnl_FecProceso.Caption), "dd/mm/yyyy")

      End If

   End If

   If Format(Dtefecven.Text, "yyyymmdd") <= Format(gsBac_Fecp, "yyyymmdd") Then
      MsgBox "Fecha de Vcto. debe ser Mayor a Fecha de Proceso; Por favor reingrese", vbCritical, "DIAS PACTOS"
      Intdias.Text = Intdias.Tag
      Dtefecven.Text = Format$(DateAdd("d", Intdias.Text, Pnl_FecProceso.Caption), "dd/mm/yyyy")

   End If

End Sub

Private Sub FltMtoini_GotFocus()

   FltMtoini.Tag = FltMtoini.Text

End Sub

Private Sub FltMtoini_KeyPress(KeyAscii As Integer)

   If Chr(KeyAscii) = "." Or Chr(KeyAscii) = "," Then
      KeyAscii = Asc(gsBac_PtoDec)

   End If

   If KeyAscii = 13 Then
      Call Bac_SendKey(vbKeyTab)

   End If

End Sub

Private Sub FltMtoini_LostFocus()

   If FltMtoini.Text <> FltMtoini.Tag Then
      Call CalcInter(FltMtoini.Text, Lbl_Mt_Final.Caption, FltTasa.Text, Lbl_ValMon.Caption, IntBase.Text, Format(Dtefecven.Text, "mm/dd/yyyy"), Format(gsBac_Fecp, "mm/dd/yyyy"), "1")

   End If

End Sub

Private Sub FltTasa_GotFocus()

   FltTasa.Tag = FltTasa.Text

End Sub

Private Sub FltTasa_KeyPress(KeyAscii As Integer)

   If Chr(KeyAscii) = "." Or Chr(KeyAscii) = "," Then
      KeyAscii = Asc(gsBac_PtoDec)

   End If

   If KeyAscii = 13 Then
      Call Bac_SendKey(vbKeyTab)

   End If

End Sub

Private Sub FltTasa_LostFocus()

   If FltTasa.Tag <> FltTasa.Text Then
      Call CalcInter(FltMtoini.Text, Lbl_Mt_Final.Caption, FltTasa.Text, Lbl_ValMon.Caption, IntBase.Text, Format(Dtefecven.Text, "mm/dd/yyyy"), Format(gsBac_Fecp, "mm/dd/yyyy"), " 1")

   End If

End Sub

Private Sub Form_Activate()

   FltMtoini.SetFocus

End Sub

Private Sub Form_Load()

   Dim i                As Integer

   Me.Top = 0
   Me.Left = 0

   Me.Tag = "IB"

   bLoad = True

   If Not funcFindMoneda(CmbMoneda, "IB") Then
      Exit Sub

   End If

   bLoad = False

   Proc_Limpia_Interbancario

   Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Ingreso a pantalla de interbancarios")

End Sub

Private Sub IntBase_KeyPress(KeyAscii As Integer)

   If KeyAscii = 13 Then
      Call Bac_SendKey(vbKeyTab)

   End If

End Sub

Private Sub Intdias_GotFocus()

   Intdias.Tag = Intdias.Text

End Sub

Private Sub Intdias_KeyPress(KeyAscii As Integer)

   If KeyAscii = 13 Then
      Call Bac_SendKey(vbKeyTab)

   End If

End Sub

Private Sub Intdias_LostFocus()

   Dim sfec             As String

   If Intdias.Tag <> Intdias.Text Then
      If Intdias.Text <> 0 Then
         sfec = Format(DateAdd("d", Intdias.Text, Pnl_FecProceso.Caption), "dd/mm/yyyy")

         If BacEsHabil(sfec) Then
            Dtefecven.Text = sfec
            Dtefecven.Tag = sfec
            Call Bac_SendKey(vbKeyTab)
            Call CalcInter(FltMtoini.Text, Lbl_Mt_Final.Caption, FltTasa.Text, Lbl_ValMon.Caption, IntBase.Text, Format(Dtefecven.Text, "mm/dd/yyyy"), Format(gsBac_Fecp, "mm/dd/yyyy"), " 1")

         Else
            MsgBox "Fecha de Vcto. no es día Hábil", 16
            Intdias.Text = Intdias.Tag
            Intdias.SetFocus
            Dtefecven.Text = Format$(DateAdd("d", Intdias.Text, Pnl_FecProceso.Caption), "dd/mm/yyyy")

         End If

      Else
         MsgBox "Fecha de Vcto. Ingresada igual a la de Proceso; Por favor reingrese", vbCritical, "DIAS PACTOS"
         Intdias.Text = Intdias.Tag
         Dtefecven.Text = Format$(DateAdd("d", Intdias.Text, Pnl_FecProceso.Caption), "dd/mm/yyyy")

      End If

   End If

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

   Select Case UCase(Button.Description)
   Case "GRABAR"
      Call Func_Grabar

   Case "LIMPIAR"
      Call Proc_Limpia_Interbancario
      FltMtoini.SetFocus

   Case "SALIR"
      Unload Me

   End Select

End Sub
