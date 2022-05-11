VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form FrmMnt_CertificadoPacto 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Generación de Certificados de Pactos"
   ClientHeight    =   7680
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   10815
   LinkTopic       =   "Form2"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   7680
   ScaleWidth      =   10815
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   10815
      _ExtentX        =   19076
      _ExtentY        =   794
      ButtonWidth     =   2355
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      TextAlignment   =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Buscar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Vista Previa"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Imprimir"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Cerrar"
            ImageIndex      =   4
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   7485
         Top             =   -15
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   4
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FrmMnt_CertificadoPacto.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FrmMnt_CertificadoPacto.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FrmMnt_CertificadoPacto.frx":1DB4
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FrmMnt_CertificadoPacto.frx":2C8E
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame FraFlitro 
      Height          =   1365
      Left            =   30
      TabIndex        =   1
      Top             =   375
      Width           =   10755
      Begin BACControles.TXTFecha TXT_FechaDesde 
         Height          =   285
         Left            =   1515
         TabIndex        =   10
         Top             =   975
         Width           =   2505
         _ExtentX        =   4419
         _ExtentY        =   503
         Enabled         =   -1  'True
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "23/05/2013"
      End
      Begin VB.TextBox TXT_Nombre 
         Alignment       =   2  'Center
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   300
         Left            =   1515
         TabIndex        =   8
         Text            =   "BANCO SECURITY"
         Top             =   540
         Width           =   6255
      End
      Begin VB.TextBox Txt_Dv 
         Alignment       =   2  'Center
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   300
         Left            =   3060
         TabIndex        =   4
         Text            =   "9"
         Top             =   195
         Width           =   285
      End
      Begin BACControles.TXTNumero Txt_Rut 
         Height          =   300
         Left            =   1515
         TabIndex        =   3
         Top             =   195
         Width           =   1515
         _ExtentX        =   2672
         _ExtentY        =   529
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "97,053,000"
         Text            =   "97,053,000"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTNumero TXT_Codigo 
         Height          =   300
         Left            =   5280
         TabIndex        =   6
         Top             =   195
         Width           =   825
         _ExtentX        =   1455
         _ExtentY        =   529
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "99"
         Text            =   "99"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTFecha TXT_FechaHasta 
         Height          =   285
         Left            =   5280
         TabIndex        =   11
         Top             =   975
         Width           =   2505
         _ExtentX        =   4419
         _ExtentY        =   503
         Enabled         =   -1  'True
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "23/05/2013"
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Fecha Hasta"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   4
         Left            =   4155
         TabIndex        =   12
         Top             =   1020
         Width           =   1035
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Fecha Desde"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   3
         Left            =   390
         TabIndex        =   9
         Top             =   1020
         Width           =   1065
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Nombre"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   2
         Left            =   420
         TabIndex        =   7
         Top             =   600
         Width           =   660
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Código"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   0
         Left            =   4155
         TabIndex        =   5
         Top             =   255
         Width           =   570
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Rut"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   1
         Left            =   420
         TabIndex        =   2
         Top             =   255
         Width           =   300
      End
   End
   Begin VB.Frame FraDatos 
      Height          =   5610
      Left            =   45
      TabIndex        =   13
      Top             =   1665
      Width           =   10725
      Begin MSFlexGridLib.MSFlexGrid GrdDatos 
         Height          =   5430
         Left            =   30
         TabIndex        =   14
         Top             =   135
         Width           =   10665
         _ExtentX        =   18812
         _ExtentY        =   9578
         _Version        =   393216
         Cols            =   8
         FixedCols       =   0
         BackColor       =   -2147483633
         BackColorFixed  =   -2147483646
         ForeColorFixed  =   -2147483639
         BackColorBkg    =   -2147483636
         GridColor       =   -2147483633
         GridColorFixed  =   -2147483642
         FocusRect       =   0
         GridLines       =   2
         GridLinesFixed  =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
   End
   Begin VB.Frame FraTotal 
      Height          =   465
      Left            =   45
      TabIndex        =   15
      Top             =   7200
      Width           =   10725
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Total Monto Final"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   6
         Left            =   6765
         TabIndex        =   19
         Top             =   165
         Width           =   1455
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Total Monto Inicial"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   5
         Left            =   2625
         TabIndex        =   18
         Top             =   180
         Width           =   1575
      End
      Begin VB.Label LBL_nMontoFinal 
         Alignment       =   1  'Right Justify
         BorderStyle     =   1  'Fixed Single
         Caption         =   "0"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   270
         Left            =   8280
         TabIndex        =   17
         Top             =   135
         Width           =   2280
      End
      Begin VB.Label LBL_nMontoInicial 
         Alignment       =   1  'Right Justify
         BorderStyle     =   1  'Fixed Single
         Caption         =   "0"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   270
         Left            =   4245
         TabIndex        =   16
         Top             =   135
         Width           =   2280
      End
   End
End
Attribute VB_Name = "FrmMnt_CertificadoPacto"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Function FuncSettinggrid()
    GrdDatos.Rows = 2:          GrdDatos.cols = 8
    GrdDatos.FixedRows = 1:     GrdDatos.FixedCols = 0
    
    GrdDatos.TextMatrix(0, 0) = "Serie":                GrdDatos.ColWidth(0) = 1500
    GrdDatos.TextMatrix(0, 1) = "Operación":            GrdDatos.ColWidth(1) = 950
    GrdDatos.TextMatrix(0, 2) = "Fecha Inicio":         GrdDatos.ColWidth(2) = 1500
    GrdDatos.TextMatrix(0, 3) = "Fecha Termino":        GrdDatos.ColWidth(3) = 1500
    GrdDatos.TextMatrix(0, 4) = "Plazo":                GrdDatos.ColWidth(4) = 950
    GrdDatos.TextMatrix(0, 5) = "Tasa":                 GrdDatos.ColWidth(5) = 950
    GrdDatos.TextMatrix(0, 6) = "Monto Inicial":        GrdDatos.ColWidth(6) = 1500
    GrdDatos.TextMatrix(0, 7) = "Monto Final":          GrdDatos.ColWidth(7) = 1500
End Function

Private Function FuncClear()
    Let Txt_Rut.Text = 0
    Let TXT_Codigo.Text = 0
    Let Txt_Dv.Text = ""
    Let TXT_Nombre.Text = ""
    
    Let TXT_FechaDesde.Text = Format(gsBac_Fecp, "dd-mm-yyyy")
    Let TXT_FechaHasta.Text = Format(gsBac_Fecp, "dd-mm-yyyy")
    
    Let GrdDatos.Rows = 1

    Let LBL_nMontoInicial.Caption = 0
    Let LBL_nMontoFinal.Caption = 0

    Let Toolbar1.Buttons(2).Enabled = False
    Let Toolbar1.Buttons(3).Enabled = False
    Let Toolbar1.Buttons(4).Enabled = False
End Function

Private Sub Form_Load()
    Let Me.Icon = BacTrader.Icon

    Call FuncSettinggrid
    Call FuncClear
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
    Select Case Button.Index
        Case 2
            Call FuncLoadData
        Case 3
            Call FuncGenCertificado(crptToWindow)
        Case 4
            Call FuncGenCertificado(crptToPrinter)
        Case 5
            Call Unload(Me)
    End Select
End Sub

Private Sub Txt_Rut_DblClick()
    Let giAceptar% = False
    
    Call BacControlWindows(1)

    Let BacAyudaCliente.Tag = "MDCL"

    Call BacAyudaCliente.Show(vbModal)

    If giAceptar% = True Then
        Call FuncLoadCliente(Val(gsrut$), Val(gsvalor$))
    End If
End Sub

Private Function FuncLoadCliente(ByVal clrut As Long, ByVal clcodigo As Integer)
    Dim ObjCliente      As New clsCliente

    Call ObjCliente.LeerPorRut(clrut, "", 0, Val(clcodigo))

    Let Txt_Rut.Text = ObjCliente.clrut
    Let Txt_Dv.Text = ObjCliente.cldv
    Let TXT_Codigo.Text = ObjCliente.clcodigo
    Let TXT_Nombre.Text = ObjCliente.clnombre
        
    Let Toolbar1.Buttons(2).Enabled = True
    Let Toolbar1.Buttons(3).Enabled = True
    Let Toolbar1.Buttons(4).Enabled = True
        
    Set ObjCliente = Nothing
End Function

Private Sub Txt_Rut_KeyDown(KeyCode As Integer, Shift As Integer)
    If (KeyCode = vbKeyDelete) Or (KeyCode = vbKeyBack) Then
        Call FuncClear
    End If
End Sub

Private Function FuncLoadData()
    Dim SqlDatos()
    Dim nMontoInicial   As Double
    Dim nMontoFinal     As Double
    
    Let Screen.MousePointer = vbHourglass
    Let nMontoInicial = 0
    Let nMontoFinal = 0
    
    Envia = Array()
    Call AddParam(Envia, TXT_FechaDesde.Text)
    Call AddParam(Envia, TXT_FechaHasta.Text)
    Call AddParam(Envia, CDbl(Txt_Rut.Text))
    Call AddParam(Envia, CDbl(TXT_Codigo.Text))
    If Not Bac_Sql_Execute("dbo.Sp_Certificados_Pacto", Envia) Then
        Let Screen.MousePointer = vbDefault
        Call MsgBox("Error en la extracción de los datos. [Sp_Certificados_Pacto]", vbExclamation, App.Title)
        Exit Function
    End If

    Let GrdDatos.Rows = 1

    Do While Bac_SQL_Fetch(SqlDatos())
        Let GrdDatos.Rows = GrdDatos.Rows + 1

        Let GrdDatos.TextMatrix(GrdDatos.Rows - 1, 0) = SqlDatos(3)
        Let GrdDatos.TextMatrix(GrdDatos.Rows - 1, 1) = SqlDatos(4)
        Let GrdDatos.TextMatrix(GrdDatos.Rows - 1, 2) = SqlDatos(5)
        Let GrdDatos.TextMatrix(GrdDatos.Rows - 1, 3) = SqlDatos(6)
        Let GrdDatos.TextMatrix(GrdDatos.Rows - 1, 4) = SqlDatos(7)
        Let GrdDatos.TextMatrix(GrdDatos.Rows - 1, 5) = Format(SqlDatos(8), FDecimal)
        Let GrdDatos.TextMatrix(GrdDatos.Rows - 1, 6) = Format(SqlDatos(9), FEntero)
        Let GrdDatos.TextMatrix(GrdDatos.Rows - 1, 7) = Format(SqlDatos(10), FEntero)
    
        Let nMontoInicial = nMontoInicial + CDbl(SqlDatos(9))
          Let nMontoFinal = nMontoFinal + CDbl(SqlDatos(10))
    Loop

    Let LBL_nMontoInicial.Caption = IIf(nMontoInicial = 0, 0, Format(nMontoInicial, FEntero))
    Let LBL_nMontoFinal.Caption = IIf(nMontoFinal = 0, 0, Format(nMontoFinal, FEntero))

    Let Screen.MousePointer = vbDefault
    
End Function

Private Function FuncGenCertificado(ByVal WinDestination As Crystal.DestinationConstants)
    On Error GoTo ErrorImpresion
    Call Limpiar_Cristal

    BacTrader.bacrpt.WindowTitle = "Certificado de Pacto"
    BacTrader.bacrpt.WindowState = crptMaximized
    BacTrader.bacrpt.Destination = WinDestination

    BacTrader.bacrpt.ReportFileName = RptList_Path & "Certificado_Pacto.rpt"
    
    BacTrader.bacrpt.StoredProcParam(0) = Format(TXT_FechaDesde.Text, "yyyy-mm-dd") + " 00:00:00.000"
    BacTrader.bacrpt.StoredProcParam(1) = Format(TXT_FechaHasta.Text, "yyyy-mm-dd") + " 00:00:00.000"
    BacTrader.bacrpt.StoredProcParam(2) = CDbl(Txt_Rut.Text)
    BacTrader.bacrpt.StoredProcParam(3) = CDbl(TXT_Codigo.Text)
    BacTrader.bacrpt.Connect = CONECCION
    BacTrader.bacrpt.Action = 1
    On Error GoTo 0

Exit Function
ErrorImpresion:

    Call MsgBox(err.Description, vbExclamation, App.Title)

End Function

