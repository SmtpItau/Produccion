VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "threed32.ocx"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form Mantenedor_Plazo 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantenedor Plazo Permanencia"
   ClientHeight    =   8130
   ClientLeft      =   510
   ClientTop       =   1545
   ClientWidth     =   6420
   Icon            =   "Mantenedor_Plazo.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   8130
   ScaleWidth      =   6420
   Begin VB.Frame panel 
      Height          =   1500
      Left            =   0
      TabIndex        =   7
      Top             =   6600
      Width           =   6270
      Begin VB.TextBox txtUsr_ing 
         Enabled         =   0   'False
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
         Height          =   315
         Left            =   1050
         MaxLength       =   11
         TabIndex        =   12
         Top             =   270
         Width           =   2145
      End
      Begin VB.TextBox txtUsr_Aut 
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
         Height          =   315
         Left            =   1050
         MaxLength       =   11
         TabIndex        =   11
         Top             =   630
         Width           =   2145
      End
      Begin VB.ComboBox cmbStatus 
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
         Height          =   315
         Left            =   1050
         Style           =   2  'Dropdown List
         TabIndex        =   10
         Top             =   1020
         Width           =   2205
      End
      Begin VB.TextBox txtAccion 
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
         Height          =   315
         Left            =   4380
         MaxLength       =   11
         TabIndex        =   9
         Top             =   990
         Width           =   1725
      End
      Begin BACControles.TXTFecha txtFec_ing 
         Height          =   315
         Left            =   4380
         TabIndex        =   8
         Top             =   240
         Width           =   1305
         _ExtentX        =   2302
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
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "14/08/2001"
      End
      Begin BACControles.TXTFecha txtFec_Aut 
         Height          =   315
         Left            =   4380
         TabIndex        =   13
         Top             =   600
         Width           =   1305
         _ExtentX        =   2302
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
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "14/08/2001"
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Usr. Ing"
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
         Index           =   7
         Left            =   270
         TabIndex        =   19
         Top             =   285
         Width           =   690
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Usr. Aut"
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
         Index           =   4
         Left            =   270
         TabIndex        =   18
         Top             =   645
         Width           =   705
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Fec. Ing"
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
         Index           =   5
         Left            =   3540
         TabIndex        =   17
         Top             =   285
         Width           =   720
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Fec. Aut"
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
         Index           =   6
         Left            =   3540
         TabIndex        =   16
         Top             =   645
         Width           =   735
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Status"
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
         Index           =   8
         Left            =   270
         TabIndex        =   15
         Top             =   1020
         Width           =   555
      End
      Begin VB.Label Accion 
         Caption         =   "Acción"
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
         Height          =   240
         Left            =   3540
         TabIndex        =   14
         Top             =   1020
         Width           =   660
      End
   End
   Begin Threed.SSFrame Frame3 
      Height          =   4575
      Left            =   0
      TabIndex        =   0
      Top             =   2025
      Width           =   6375
      _Version        =   65536
      _ExtentX        =   11245
      _ExtentY        =   8070
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
      Begin VB.ComboBox Cmb_Cartera 
         BackColor       =   &H00C0C0C0&
         Height          =   315
         ItemData        =   "Mantenedor_Plazo.frx":030A
         Left            =   240
         List            =   "Mantenedor_Plazo.frx":031D
         Style           =   2  'Dropdown List
         TabIndex        =   21
         Top             =   1080
         Visible         =   0   'False
         Width           =   1935
      End
      Begin VB.TextBox texto 
         BackColor       =   &H00800000&
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   285
         Left            =   2280
         MaxLength       =   8
         TabIndex        =   23
         Top             =   1080
         Visible         =   0   'False
         Width           =   1185
      End
      Begin VB.ComboBox Cmb_Instrumento 
         BackColor       =   &H00C0C0C0&
         Height          =   315
         ItemData        =   "Mantenedor_Plazo.frx":0335
         Left            =   3600
         List            =   "Mantenedor_Plazo.frx":0348
         Style           =   2  'Dropdown List
         TabIndex        =   22
         Top             =   1080
         Visible         =   0   'False
         Width           =   1935
      End
      Begin MSFlexGridLib.MSFlexGrid Table1 
         Height          =   3180
         Left            =   75
         TabIndex        =   6
         Top             =   120
         Width           =   6240
         _ExtentX        =   11007
         _ExtentY        =   5609
         _Version        =   393216
         Cols            =   5
         FixedCols       =   0
         BackColor       =   -2147483644
         ForeColor       =   8388608
         BackColorFixed  =   8421376
         ForeColorFixed  =   16777215
         BackColorSel    =   8388608
         ForeColorSel    =   8388608
         BackColorBkg    =   -2147483645
         GridColor       =   255
         GridColorFixed  =   8421504
         GridLines       =   2
         ScrollBars      =   2
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
   End
   Begin Threed.SSFrame frame1 
      Height          =   1365
      Left            =   0
      TabIndex        =   3
      Top             =   570
      Width           =   6240
      _Version        =   65536
      _ExtentX        =   11007
      _ExtentY        =   2408
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
      Begin VB.ComboBox cmbcartera 
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
         Height          =   315
         Left            =   90
         Style           =   2  'Dropdown List
         TabIndex        =   1
         Top             =   495
         Width           =   4000
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Cartera"
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
         Left            =   90
         TabIndex        =   4
         Top             =   225
         Width           =   615
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   20
      Top             =   0
      Width           =   6420
      _ExtentX        =   11324
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   6
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Procesar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Description     =   "Imprimir"
            Object.ToolTipText     =   "Imprirmir"
            ImageIndex      =   6
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   4
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   0
      Top             =   0
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   6
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Mantenedor_Plazo.frx":0360
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Mantenedor_Plazo.frx":07B2
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Mantenedor_Plazo.frx":0C04
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Mantenedor_Plazo.frx":0F1E
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Mantenedor_Plazo.frx":1238
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Mantenedor_Plazo.frx":1552
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.Frame Frame 
      Caption         =   "Plazo Residual"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1245
      Left            =   45
      TabIndex        =   5
      Top             =   2340
      Visible         =   0   'False
      Width           =   6225
      Begin BACControles.TXTNumero TXTPlazoResidual 
         Height          =   270
         Left            =   150
         TabIndex        =   2
         Top             =   360
         Width           =   855
         _ExtentX        =   1508
         _ExtentY        =   476
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
         Text            =   "0"
         Text            =   "0"
         Min             =   "0"
         Max             =   "999999"
         MarcaTexto      =   -1  'True
      End
   End
End
Attribute VB_Name = "Mantenedor_Plazo"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'=====================================================
' LD1_COR_035 , Tema: Mantenedor Plazo Permanencia
' INICIO
'=====================================================
Dim lIngresa            As Boolean
Dim lDesviacionEstandar As Boolean
Dim lTasaInterbancaria  As Boolean
Dim nDesviacionEstandar As Double
Dim nMedia              As Double
Dim nMedia1             As Double
Dim nMedia2             As Double
Dim nMedia3             As Double
Dim nDesvEst            As Double
Dim nDesvEst1           As Double
Dim nDesvEst2           As Double
Dim nDesvEst3           As Double
Dim nDesMedia           As Double
Dim nDesFinal           As Double

Public ClsValorMoneda   As Object


Private Sub imprimir()
Dim SQL_Informe As String
On Error GoTo Errores

 Call Limpiar_Cristal
   If Me.Tag = "PRE" Then
        Screen.MousePointer = vbHourglass
        BacTrader.bacrpt.Connect = CONECCION
        BacTrader.bacrpt.Destination = crptToPrinter
        BacTrader.bacrpt.ReportFileName = RptList_Path & "Plazo_Permanencia_pre.RPT"
        BacTrader.bacrpt.WindowTitle = "INFORME DE PRE_ACTUALIZACIÓN PLAZO PERMANENCIA"
        BacTrader.bacrpt.StoredProcParam(0) = CDbl(cmbcartera.ItemData(cmbcartera.ListIndex))
        BacTrader.bacrpt.DiscardSavedData = True
        BacTrader.bacrpt.WindowState = crptMaximized
        BacTrader.bacrpt.Action = 1
      
   Else
        Screen.MousePointer = vbHourglass
        BacTrader.bacrpt.Connect = CONECCION
        BacTrader.bacrpt.Destination = crptToPrinter
        BacTrader.bacrpt.ReportFileName = RptList_Path & "Plazo_Permanencia.RPT"
        BacTrader.bacrpt.WindowTitle = "INFORME DE ACTUALIZACIÓN PLAZO PERMANENCIA"
        BacTrader.bacrpt.StoredProcParam(0) = CDbl(cmbcartera.ItemData(cmbcartera.ListIndex))
        BacTrader.bacrpt.DiscardSavedData = True
        BacTrader.bacrpt.WindowState = crptMaximized
        BacTrader.bacrpt.Action = 1
        
   End If
Screen.MousePointer = vbDefault
Exit Sub
Errores:
    MsgBox err.Description, vbCritical
    Screen.MousePointer = 0

End Sub


Private Sub Imprimir_Tool()
Dim SQL_Informe As String
On Error GoTo Errores
    
    Screen.MousePointer = vbHourglass
    BacTrader.bacrpt.Connect = CONECCION
    BacTrader.bacrpt.Destination = crptToPrinter
    BacTrader.bacrpt.ReportFileName = RptList_Path & "Plazo_Permanencia.RPT"
    BacTrader.bacrpt.WindowTitle = "INFORME DE PRE_ACTUALIZACIÓN PLAZO PERMANENCIA"
    BacTrader.bacrpt.StoredProcParam(0) = CDbl(cmbcartera.ItemData(cmbcartera.ListIndex))
    BacTrader.bacrpt.DiscardSavedData = True
    BacTrader.bacrpt.WindowState = crptMaximized
    BacTrader.bacrpt.Action = 1
    Screen.MousePointer = vbDefault

Errores:
    Screen.MousePointer = vbDefault
    Screen.MousePointer = 0

End Sub

Sub LimpiarPlandeCuentas()
    
    Set objCodigo = New clsCodigo
    
    Set objCodigo = Nothing
       
    LLENA_COMBO_ESTADO cmbStatus
       
    If Me.Tag = "APR" Then
        txtUsr_ing.text = ""
    Else
        txtUsr_Aut.text = ""
    End If
    
    Existe = False

'Toolbar.Buttons(1).Enabled = False

End Sub

Public Sub LLENA_COMBO_ESTADO(cmb As Control)

    cmb.Clear
    If Not Bac_Sql_Execute("Sp_Busca_Estados") Then
        MsgBox " No encuentra datos", 16
    End If
    
    Do While Bac_SQL_Fetch(DATOS)
        cmb.AddItem DATOS(1)
        cmb.ItemData(cmb.NewIndex) = DATOS(2)
    Loop
       
End Sub

Sub cmdimprimir()

  On Error GoTo Control:
  
  Call Limpiar_Cristal
  
  BacTrader.bacrpt.ReportFileName = gsRPT_Path & "Bacvalorestasasmtm.rpt"
  BacTrader.bacrpt.Destination = crptToWindow
  BacTrader.bacrpt.WindowTitle = TITSISTEMA & " - Informe de Valores Mark To Market"
  BacTrader.bacrpt.StoredProcParam(0) = Format$(gsBac_Fecp, feFECHA)
  BacTrader.bacrpt.Connect = CONECCION
  BacTrader.bacrpt.WindowState = crptMaximized
  BacTrader.bacrpt.Action = 1

   Exit Sub

Control:

    MsgBox "Problemas al generar Listado. " & err.Description & ", " & err.Number, vbCritical, "BACPARAMETROS"
    Screen.MousePointer = 0


End Sub



Sub cargar_grilla()
Dim nCont  As Integer
Dim nerror As String

Dim DATOS()

Table1.Redraw = False

Envia = Array()
AddParam Envia, CDbl(cmbcartera.ItemData(cmbcartera.ListIndex))
  
    If Bac_Sql_Execute("Sp_Carga_Plazos_Permanencia_preaprovado ", Envia) Then
       If Bac_SQL_Fetch(DATOS()) Then
       
            Existe = True
            nerror = DATOS(1)
        
        If Me.Tag = "APR" And nerror = "ERROR" Then
               MsgBox "No existe información, No se Puede Realizar una Aprobación", vbCritical, TITSISTEMA
               Call CmdLimpiar
               cmbcartera.SetFocus
               Exit Sub
        End If
                
        If Me.Tag = "PRE" And nerror = "ERROR" Then
               Table1.Clear
               Dibuja_Grilla
               cmbcartera.SetFocus
               Table1.Redraw = True
               Table1.Rows = Table1.Rows - Table1.Row + 1
               Exit Sub
        End If
        
        If nerror <> "ERROR" Then
        
        txtUsr_Aut.text = DATOS(6)
        If Me.Tag = "APR" Then
            
            txtUsr_Aut.text = gsBac_User
            txtFec_Aut.text = Format(gsBac_Fecp, gsc_fechadma)
            
            If gsBac_User = DATOS(5) Then
                    
               MsgBox "El Usuario a Autorizar No puede ser el mismo", vbCritical, TITSISTEMA
               Table1.Redraw = True
                Exit Sub
            End If
        End If
        End If

        
     End If
     
     
        If nerror <> "ERROR" Then
        
        Envia = Array()
        AddParam Envia, CDbl(cmbcartera.ItemData(cmbcartera.ListIndex))
  
        If Bac_Sql_Execute("Sp_Carga_Plazos_Permanencia_preaprovado ", Envia) Then
            
        With Table1

        .Rows = 1

        Do While Bac_SQL_Fetch(DATOS())

           .Rows = .Rows + 1
           .Row = .Rows - 1

           .Col = 0: .text = IIf(DATOS(1) = 2, "DISPONIBLE PARA LA VENTA", "NEGOCIACION")                                                              'Moneda
           .Col = 1: .text = DATOS(2)
           .Col = 2: .text = DATOS(3)
           .Col = 3: .text = DATOS(4)
           .Col = 4: .text = DATOS(9)
           
            If Table1.TextMatrix(Table1.Row, 4) = "ELIMINAR" Then
                'obj.Col = 4
                'Set obj.CellPicture = BacMntApoderado.picEliminar.Picture
                For i = 0 To Table1.cols - 1
                    Table1.Col = i
                    Table1.CellBackColor = vbRed
                Next
            End If
           
           
           '.Col = 4: .Text = DATOS(9)

        Loop

       End With
       End If
            If DATOS(5) = "" Then
                txtUsr_ing.text = gsBac_User
            Else
                txtUsr_ing.text = DATOS(5)
            End If
                
            txtFec_ing.text = IIf(Len(Trim(DATOS(7))) = 0, Format(gsBac_Fecp, "dd/mm/yyyy"), DATOS(7))
            txtFec_Aut.text = IIf(Len(Trim(DATOS(8))) = 0, Format(gsBac_Fecp, "dd/mm/yyyy"), DATOS(8))

            txtAccion.text = DATOS(9)
            cmbStatus.ListIndex = IIf(FUNC_POSICION_COMBO(cmbStatus, Trim(DATOS(9)), 30), FUNC_POSICION_COMBO(cmbStatus, Trim(DATOS(9)), 30), -1)
       End If
        Table1.Redraw = True
       Exit Sub
End If
Errores:

   MsgBox err.Description
End Sub

Function FUNC_POSICION_COMBO(Cmb_Control As Control, texto As String, Posicion As Integer) As Integer
Dim i%
Dim encontro As Boolean
  FUNC_POSICION_COMBO = 0
    For i% = 0 To Cmb_Control.ListCount - 1
      Cmb_Control.ListIndex = i%
        If Trim(Mid(Cmb_Control.text, 1, Posicion)) = Trim(texto) Then
          encontro = True
          FUNC_POSICION_COMBO = i%
          Exit For
        End If
    Next i%
End Function

Sub CmdAyuda()

Dim cTexto

cTexto = cTexto + "[F1]  => Ayuda" + vbCrLf
cTexto = cTexto + "[F2]  => Cambia Desviación Estandar" + vbCrLf
cTexto = cTexto + "[Ins] => Agrega Periodo" + vbCrLf
cTexto = cTexto + "[Del] => Elimina Periodo" + vbCrLf

MsgBox cTexto, , "Ayuda"
Table1.SetFocus

End Sub
Private Sub cmdGrabar()

    Dim iCartera        As Variant
    Dim iInstrumento    As Variant
    
   
   If cmbcartera.text = "" Then
                MsgBox "Debe Ingresar Cartera", vbInformation, TITSISTEMA
                cmbcartera.SetFocus
                Exit Sub
   End If
   
 
  
    With Table1
        For i = 1 To .Rows - 1
            .Row = i
                Envia = Array()
                AddParam Envia, IIf(.TextMatrix(.Row, 0) = "NEGOCIACION", 1, 2)
                AddParam Envia, Right(.TextMatrix(.Row, 1), 6)
                AddParam Envia, CDbl(.TextMatrix(.Row, 2))
                AddParam Envia, CDbl(.TextMatrix(.Row, 3))

   If Not Bac_Sql_Execute("Sp_Graba_Plazos", Envia) Then
      MsgBox "Grabación no tuvo éxito", vbCritical, TITSISTEMA
      Exit Sub
   End If
  Next
  End With

       ' MsgBox "Grabación se realizó con éxito", vbInformation, TITSISTEMA
'        Call Imprimir

    'Call cargar_grilla
    'TxtMinimo.Text = 0
    'TxtMaximo.Text = 0
    
    'cmbinstrumento.Clear
   
    'Call LeerInstrumentos
    'Call LeerPlazos
    'Toolbar1.Buttons(2).Enabled = False
    'Toolbar.Buttons(1).Enabled = False


Screen.MousePointer = 0

End Sub



Private Sub cmdGrabar_Pre_Aprobado()

On Error GoTo xError
    Dim iCartera        As Variant
    Dim iInstrumento    As Variant
    Dim r%
    Dim i As Integer
   Dim Cont As Integer
    Cont = 0
    
       
    With Table1
    
        For i = 1 To .Rows - 1
            .Row = i
            If .CellBackColor = vbRed Then
                  Cont = Cont + 1
            End If
        Next

       ' If Cont > 0 Then
       '      If (MsgBox("Las filas que esten en rojo serán eliminados, ¿Está Seguro de Continuar?", vbQuestion + vbYesNo, TITSISTEMA) <> vbYes) Then
       '             Exit Sub
       '      End If
       ' End If
        

        For i = 1 To .Rows - 1
            .Row = i
            If .CellBackColor <> vbRed Then

                Envia = Array()
                AddParam Envia, IIf(.TextMatrix(.Row, 0) = "NEGOCIACION", 1, 2)
                AddParam Envia, Right(.TextMatrix(.Row, 1), 6)
                AddParam Envia, CDbl(.TextMatrix(.Row, 2))
                AddParam Envia, CDbl(.TextMatrix(.Row, 3))
          
          If Me.Tag = "APR" Then
            AddParam Envia, Trim(txtUsr_ing.text)
            AddParam Envia, gsBac_User
            AddParam Envia, Trim(txtFec_ing.text)
            AddParam Envia, Format(gsBac_Fecp, gsc_fechadma)
            AddParam Envia, cmbStatus.ItemData(cmbStatus.ListIndex)
          Else
            AddParam Envia, gsBac_User 'Trim(txtUsr_ing.Text)
            AddParam Envia, 0
            AddParam Envia, Trim(txtFec_ing.text)
            AddParam Envia, 0 ' Trim(txtFec_Aut.Text)
            AddParam Envia, 1 'cmbStatus.ItemData(cmbStatus.ListIndex) '---5815490

        End If
        
         AddParam Envia, IIf(Existe, 2, 1)
        
        If Not Bac_Sql_Execute("Sp_Graba_Plazos_preaprobado", Envia) Then
           MsgBox "Grabación no tuvo éxito", vbCritical, TITSISTEMA
           Exit Sub
        End If
    End If
  Next
  End With
'Next r%
   
      O = 0
      For y = 1 To Table1.Rows - 1
         Table1.Col = 4
         Table1.Row = y
         If Table1.CellBackColor = vbRed Then
           O = 1
           Exit For
         End If
      Next y
      If O > 0 Then
        If MsgBox("Los Datos Que Esten En Rojo Serán Eliminados, ¿Está Seguro de Continuar?", vbQuestion + vbYesNo, TITSISTEMA) = vbYes Then
            Call Elimina_Plazos_Preaprobado
        End If
      End If
      MsgBox "Grabación se realizó con exito", 64, TITSISTEMA
      If O = 0 Then  ' VGS 14/10/2005
        Call imprimir
      End If

   

Screen.MousePointer = 0

Exit Sub
xError:
    MsgBox err.Description, vbCritical, TITSISTEMA
End Sub



Sub DesviacionEstandar()

TxtDesviacionEstandar.Enabled = True
TxtDesviacionEstandar.SetFocus

End Sub

Sub Dibuja_Grilla()
 
   With Table1
   
      .cols = 23
      
      .TextMatrix(0, 0) = "Cartera"
      .TextMatrix(0, 1) = "Instrumento"
      .TextMatrix(0, 2) = "Plazo Mín."
      .TextMatrix(0, 3) = "Plazo Máx."
      .TextMatrix(0, 4) = "Acción"
      .TextMatrix(0, 5) = ""
      .TextMatrix(0, 6) = ""
      .TextMatrix(0, 7) = ""
      .TextMatrix(0, 8) = ""
      .TextMatrix(0, 9) = ""
      .TextMatrix(0, 10) = ""
      .TextMatrix(0, 11) = ""
      .TextMatrix(0, 12) = ""
      .TextMatrix(0, 13) = ""
      .TextMatrix(0, 14) = ""
      .TextMatrix(0, 15) = ""
      .TextMatrix(0, 16) = ""
      .TextMatrix(0, 17) = ""
      .TextMatrix(0, 18) = ""
      .TextMatrix(0, 19) = ""
      .TextMatrix(0, 20) = ""
      .TextMatrix(0, 21) = ""
      .TextMatrix(0, 22) = ""
             
      .RowHeight(0) = 310
      
      .ColAlignment(0) = 0:   .ColWidth(0) = 2730
      .ColAlignment(1) = 1:   .ColWidth(1) = 1300
      .ColAlignment(2) = 4:   .ColWidth(2) = 1000
      .ColAlignment(3) = 4:   .ColWidth(3) = 1000
    If Me.Tag = "APR" Then
      .ColAlignment(4) = 1:   .ColWidth(4) = 1500
    Else
      .ColAlignment(4) = 1:   .ColWidth(4) = 0
    End If
      .ColAlignment(5) = 7:   .ColWidth(5) = 0
      .ColAlignment(6) = 7:   .ColWidth(6) = 0
      .ColAlignment(7) = 7:   .ColWidth(7) = 0
      .ColAlignment(8) = 7:   .ColWidth(8) = 0
      .ColAlignment(9) = 7:   .ColWidth(9) = 0
      .ColAlignment(10) = 7:   .ColWidth(10) = 0
      .ColAlignment(11) = 7:   .ColWidth(11) = 0
      .ColAlignment(12) = 7:   .ColWidth(12) = 0
      .ColAlignment(13) = 7:   .ColWidth(13) = 0
      .ColAlignment(14) = 7:   .ColWidth(14) = 0
      .ColAlignment(15) = 7:   .ColWidth(15) = 0
      .ColAlignment(16) = 7:   .ColWidth(16) = 0
      .ColAlignment(17) = 7:   .ColWidth(17) = 0
      .ColAlignment(18) = 7:   .ColWidth(18) = 0
      .ColAlignment(19) = 7:   .ColWidth(19) = 0
      .ColAlignment(20) = 7:   .ColWidth(20) = 0
      .ColAlignment(21) = 7:   .ColWidth(21) = 0
      .ColAlignment(22) = 7:   .ColWidth(22) = 0
      
   
   End With
   
End Sub

Private Sub CmdLimpiar()
   
  Set objCodigo = New clsCodigo
    
    Set objCodigo = Nothing
   
    Table1.Clear
    Table1.Rows = 2
'    TxtMinimo.Text = 0
'    TxtMaximo.Text = 0
'    TXTPlazoResidual.Enabled = True
'    TXTPlazoResidual.Text = 0
    
    Cmb_Cartera.Clear
    Cmb_Instrumento.Clear
    cmbcartera.Clear
   
    Dibuja_Grilla
    Call LeerCarteras
    Call LeerInstrumentos
 
      
    LLENA_COMBO_ESTADO cmbStatus
       
    If Me.Tag = "APR" Then
        txtUsr_ing.text = ""
    Else
        txtUsr_Aut.text = ""
    End If
    
    Existe = False
    
    'Toolbar1.Buttons(2).Enabled = False
 'Toolbar.Buttons(1).Enabled = False
   
End Sub

Private Sub cmdsalir()
   Unload Me
End Sub


Sub LeerCarteras()

Dim DATOS()

If Not Bac_Sql_Execute("sp_carga_cartera") Then
   
   MsgBox "Problemas al leer Carteras", vbCritical, "MENSAJE"
   Exit Sub

End If

Do While Bac_SQL_Fetch(DATOS())
   cmbcartera.AddItem DATOS(1)
   cmbcartera.ItemData(cmbcartera.NewIndex) = DATOS(2)
Loop
   
End Sub

Sub LeerInstrumentos()

On Error GoTo ErrCarga
    
    Dim DATOS()


    With Cmb_Instrumento
        .Clear
        If Bac_Sql_Execute("sp_carga_instrumentos ") Then
            Do While Bac_SQL_Fetch(DATOS())
                .AddItem DATOS(1) '& Space(100) & DATOS(1)
            Loop
        Else
            MsgBox "No se pudo obtener información del servidor", 16, TITSISTEMA
            Exit Sub
        End If
        .ListIndex = 0
    End With
    
    


    With Cmb_Cartera
        .Clear
        If Bac_Sql_Execute("sp_carga_cartera ") Then
            Do While Bac_SQL_Fetch(DATOS())
                .AddItem DATOS(1) '& Space(100) & DATOS(1)
            Loop
        Else
            MsgBox "No se pudo obtener información del servidor", 16, TITSISTEMA
            Exit Sub
        End If
        .ListIndex = 0
    End With

    
    
    
    
Exit Sub
ErrCarga:
    MsgBox "Se detectó problemas en carga de información: " & err.Description & ". Comunique al Administrador.", 16, TITSISTEMA



End Sub

Private Sub LeerPlazos()

Dim DATOS()

If Not Bac_Sql_Execute("Sp_Carga_Plazo_Residual") Then
   
   MsgBox "Problemas al leer Plazos", vbCritical, "MENSAJE"
   Exit Sub

End If

Do While Bac_SQL_Fetch(DATOS())
   TXTPlazoResidual.text = DATOS(1)
Loop

End Sub



Function MtmTasa(nCodigo As Integer, ByVal dFecPro As String, nPlazo As Integer) As Double

Dim DATOS()
   
Envia = Array()
AddParam Envia, nCodigo
AddParam Envia, dFecPro
AddParam Envia, nPlazo

If Not Bac_Sql_Execute("sp_mtmtasa", Envia) Then
   MsgBox "Problemas al leer tasas MTM", vbCritical, "MENSAJE"
   Exit Function
End If

Do While Bac_SQL_Fetch(DATOS())
   MtmTasa = DATOS(1)
Loop

End Function

Sub TasasDolarInterbancario()

TxtMinimo.Enabled = True
TxtMaximo.Enabled = True
TxtMinimo.SetFocus

End Sub

Private Sub Cmb_Cartera_KeyPress(KeyAscii As Integer)

 With Table1

     If KeyAscii = 27 Then
        Cmb_Cartera.Visible = False
        .SetFocus
     End If

    If KeyAscii = 13 Then
            .TextMatrix(.Row, 0) = IIf(Cmb_Cartera.text = "DISPONIBLE PARA LA VENTA", "DISPONIBLE PARA LA VENTA", "NEGOCIACION")
            Cmb_Cartera.Visible = False
            .Col = .Col + 1
            .SetFocus
            Exit Sub
    End If
 End With


End Sub


Private Sub Cmb_Cartera_LostFocus()

       Cmb_Cartera.Visible = False
       Table1.SetFocus

End Sub


Private Sub Cmb_Instrumento_KeyPress(KeyAscii As Integer)

 With Table1

     If KeyAscii = 27 Then
        Cmb_Instrumento.Visible = False
        .SetFocus
     End If

    If KeyAscii = 13 Then
            .TextMatrix(.Row, 1) = Cmb_Instrumento.text
            Cmb_Instrumento.Visible = False
            .Col = .Col + 1
            .SetFocus
            Exit Sub
    End If
 End With

End Sub

Private Sub Cmb_Instrumento_LostFocus()

       Cmb_Instrumento.Visible = False
       Table1.SetFocus
       
End Sub


Private Sub cmbcartera_Click()

'Call LeerPlazos

If cmbcartera.text = "NEGOCIACION" Then
    TXTPlazoResidual.Enabled = False
Else
    TXTPlazoResidual.Enabled = True
End If

If Me.Tag = "PRE" Then
    Frame3.Enabled = True
Else
    Frame3.Enabled = False
End If

Call cargar_grilla

End Sub

Private Sub cmbinstrumento_Click()

Toolbar1.Buttons(2).Enabled = True
'Toolbar.Buttons(1).Enabled = True

End Sub

Private Sub Combo1_KeyPress(KeyAscii As Integer)

 With Table1

     If KeyAscii = 27 Then
        Cmb_Producto.Visible = False
        .SetFocus
     End If

    If KeyAscii = 13 Then
            .TextMatrix(.Row, .Col) = Combo1.text
            Combo1.Visible = False
            .Col = .Col + 1
            .SetFocus
            Exit Sub
    End If
 End With
 
End Sub


Private Sub Combo1_LostFocus()

       Combo1.Visible = False
       Table1.SetFocus
       
End Sub


Private Sub Form_Activate()

Call Dibuja_Grilla

If Me.Tag = "APR" Then
    Me.Caption = "Aprobación de Plazo Permanencia"
    
    Toolbar1.Buttons(1).Visible = False
    Toolbar1.Buttons(2).Visible = False
    Toolbar1.Buttons(3).Visible = True
    Toolbar1.Buttons(4).Visible = True
    Toolbar1.Buttons(5).Visible = True
    Toolbar1.Buttons(6).Visible = True

    
    txtUsr_ing.Enabled = False
    txtUsr_Aut.Enabled = False
    txtFec_ing.Enabled = False
    txtFec_Aut.Enabled = False
    txtAccion.Enabled = False
    cmbStatus.Enabled = True
    
    txtUsr_Aut.text = gsBac_User
    txtFec_Aut.text = Format(gsBac_Fecp, gsc_fechadma)
    txtFec_ing.text = Format(gsBac_Fecp, gsc_fechadma)
    txtUsr_ing.text = ""
    
Else
    
    Me.Caption = "Pre-Aprobación de Plazo Permanencia"
    Me.Accion.Visible = False
    Me.txtAccion.Visible = False
    
    panel.Enabled = False
    Toolbar1.Buttons(1).Visible = True
    Toolbar1.Buttons(2).Visible = True
    Toolbar1.Buttons(3).Visible = False
    Toolbar1.Buttons(4).Visible = False
    Toolbar1.Buttons(5).Visible = True
    Toolbar1.Buttons(6).Visible = True

    
    txtUsr_ing.text = gsBac_User
    txtFec_ing.text = Format(gsBac_Fecp, gsc_fechadma)
    txtFec_Aut.text = Format(gsBac_Fecp, gsc_fechadma)
    txtUsr_Aut.text = ""
    cmbStatus.Enabled = True

    
    txtUsr_Aut.Visible = False
    txtFec_Aut.Visible = False
    Label2(6).Visible = False
    Label2(4).Visible = False
End If
End Sub

Private Sub Form_Load()

Me.Top = 0
Me.Left = 0

Set ClsValorMoneda = New ClsValorMoneda

Call LeerCarteras
Call LeerInstrumentos
'Call Dibuja_Grilla
Frame3.Enabled = False

'Toolbar1.Buttons(2).Enabled = False

Call LimpiarPlandeCuentas


End Sub


Private Sub Table1_DblClick()

    With Table1
        If .Col = 0 Then
            Cmb_Cartera.Visible = True
            Cmb_Cartera.ListIndex = 0
            Proc_Posiciona_Combo Table1, Cmb_Cartera
            Cmb_Cartera.SetFocus
        End If
        
        If .Col = 1 Then
            Cmb_Instrumento.Visible = True
            Cmb_Instrumento.ListIndex = 0
            Proc_Posiciona_Combo Table1, Cmb_Instrumento
            Cmb_Instrumento.SetFocus
        End If

        If .Col = 2 Or .Col = 3 Then
           PROC_POSICIONA_TEXTO Table1, texto
           texto.Visible = True
           texto.SetFocus
        End If

End With

End Sub



Sub Proc_Posiciona_Combo(GRILLA As Control, texto As Control)

   If Not TypeOf texto Is ComboBox Then
      texto.Height = 270

   End If

   texto.Top = GRILLA.CellTop + GRILLA.Top + 20
   texto.Left = GRILLA.CellLeft + GRILLA.Left + 20
   texto.Width = GRILLA.CellWidth - 20

End Sub


Private Sub Table1_KeyDown(KeyCode As Integer, Shift As Integer)

Dim i As Integer

   Dim DATOS()

   With Table1
   
      If KeyCode = 46 Then ' Suprimir
        If (.TextMatrix(.Row, 0) = "" And .TextMatrix(.Row, 1) = "" And .TextMatrix(.Row, 2) = "") And .Rows > 2 Then
           .RemoveItem (.Row)
           .SetFocus
           Exit Sub
        Else
            If (.TextMatrix(.Row, 0) <> "") Then
                     Col = .Col
                     Fil = .Row

                     If .CellBackColor <> vbRed Then
                        For i = 0 To .cols - 1
                           .Col = i
                           .CellBackColor = vbRed

                        Next
                     Else
                        For i = 0 To .cols - 1
                           .Col = i
                           .CellBackColor = &H80000004

                        Next
                     End If

                     .Col = Col
                     .Row = Fil
              End If

         End If
      End If

      If KeyCode = 45 Then 'Insert
         If .TextMatrix(.Rows - 1, 0) <> "" Or .TextMatrix(.Rows - 1, 1) <> "" Or .TextMatrix(.Rows - 1, 2) <> "" Or .TextMatrix(.Rows - 1, 3) <> "" Then
            .Rows = .Rows + 1
            .Row = .Rows - 1
            .Col = 0
            .TextMatrix(.Row, 0) = IIf(cmbcartera.text = "DISPONIBLE PARA LA VENTA", "AFS", "NEGOCIACION")
         Else
               .TextMatrix(.Row, 0) = IIf(cmbcartera.text = "DISPONIBLE PARA LA VENTA", "AFS", "NEGOCIACION")
         End If
      End If
   End With

End Sub


Private Sub Table1_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
        Call Table1_DblClick
    End If
    
    If Table1.Col = 2 Or Table1.Col = 3 Then
        If (KeyAscii >= 47 And KeyAscii <= 57) Then
           PROC_POSICIONA_TEXTO Table1, texto
           texto.Visible = True
           texto.text = Chr(KeyAscii)
           SendKeys "{END}"
           texto.SetFocus
        End If
    End If

End Sub


Private Sub Texto_KeyPress(KeyAscii As Integer)

With Table1
    
   KeyAscii = Asc(UCase$(Chr$(KeyAscii)))
   
     If KeyAscii = 13 Then
          .TextMatrix(.Row, .Col) = texto.text
            texto.text = ""
           .Enabled = True
           texto.Visible = False
           
            If .Col = .cols - 1 Then
                .Col = 0
            Else
                .Col = .Col + 1
            End If
            .SetFocus
      End If
      If KeyAscii = 27 Then
           texto.text = ""
           texto.Visible = False
           .Enabled = True
           .SetFocus
      End If
     
 End With
BacCaracterNumerico KeyAscii

End Sub

Private Sub Texto_LostFocus()

   Texto_KeyPress 27
   
End Sub


Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Dim coun
Dim fo
    Dim DATOS()
    
   Select Case Button.Index
   Case 1
    Call cmdGrabar_Pre_Aprobado
    Call CmdLimpiar
     
    Call LeerInstrumentos
    'Call LeerPlazos
    Toolbar1.Buttons(2).Enabled = False

   Case 2
          Dim Res
                
        
        Res = MsgBox("¿Confirma que desea Eliminar" & "?", vbYesNo + vbQuestion, TITSISTEMA)
        If Res = 6 Then
            
        Envia = Array()
        AddParam Envia, CDbl(cmbcartera.ItemData(cmbcartera.ListIndex))

            
            nerror = 0
            sError = "Cuenta fue Eliminada con Exito"
            
          With Table1

   
        For i = 1 To .Rows - 1
            .Row = i
                Envia = Array()
                AddParam Envia, IIf(.TextMatrix(.Row, 0) = "NEGOCIACION", 1, 2)
                AddParam Envia, Right(.TextMatrix(.Row, 1), 6)
                AddParam Envia, 3
                AddParam Envia, gsBac_User
                AddParam Envia, 1
                AddParam Envia, 0
                AddParam Envia, txtFec_ing.text
            
                If Not Bac_Sql_Execute("Sp_Elimina_Plazos_preaprobacion", Envia) Then
                    MsgBox "Eliminación no tuvo éxito", vbCritical, TITSISTEMA
                Exit Sub
        End If
    Next
  End With
            If Bac_SQL_Fetch(DATOS()) Then
                MsgBox DATOS(1), vbCritical, TITSISTEMA
                'nerror = DATOS(2)
            End If
            
            If nerror = 0 Then
                Call imprimir
                Call CmdLimpiar 'LimpiarPlandeCuentas
                'txtCta.SetFocus
            End If
        End If
     Case 3
        If txtAccion.text = "" Then
           MsgBox "No hay acción a realizar", 16, TITSISTEMA
           Call CmdLimpiar
           cmbcartera.SetFocus
           Exit Sub
        End If
        If cmbStatus.text = "PENDIENTE" Then
           Call CmdLimpiar
           cmbcartera.SetFocus
        End If
        
        If cmbStatus.text = "RECHAZADO" Then
           
                Res = MsgBox("¿Confirma que desea Rechazar Carteras " & (cmbcartera.text) & "?", vbYesNo + vbQuestion, TITSISTEMA)
                If Res = 6 Then
                    nerror = 0
                    sError = "Rechazado con Exito"
                    
    With Table1
        For i = 1 To .Rows - 1
            .Row = i
                Envia = Array()
                    AddParam Envia, IIf(.TextMatrix(.Row, 0) = "NEGOCIACION", 1, 2)
                    AddParam Envia, Right(.TextMatrix(.Row, 1), 6)
                    AddParam Envia, 2
                    AddParam Envia, Format(gsBac_Fecp, gsc_fechadma)
                    AddParam Envia, txtUsr_Aut.text
                       If Not Bac_Sql_Execute("sp_Rechaza_Plazo_Permanencia", Envia) Then
                            MsgBox "Grabación no tuvo éxito", vbCritical, TITSISTEMA
                            Exit Sub
                        End If
          Next
        End With
                    
                    If Bac_SQL_Fetch(DATOS()) Then
                        nerror = DATOS(1)
                        sError = DATOS(2)
                    End If
                    
                    MsgBox sError, vbInformation + vbOKOnly, TITSISTEMA
                        
                    If nerror = 0 Then
                        'Call Imprimir
                        Call CmdLimpiar
                        cmbcartera.SetFocus
                    End If
                End If
                Exit Sub
        End If
        
        If cmbStatus.text = "AUTORIZADO" And UCase(Trim(txtAccion.text)) <> "ELIMINAR" Then
                    Call cmdGrabar
                    Call cmdGrabar_Pre_Aprobado
                    Call Elimina_Plazos
                    Call CmdLimpiar
                    'cmbcartera.SetFocus
                    
                    
                    
                    
                    
        End If
           
           If txtAccion.text = "ELIMINAR" And cmbStatus.text = "AUTORIZADO" Then
             Res = MsgBox("¿Confirma que desea Eliminar Plazos " & "?", vbYesNo + vbQuestion, TITSISTEMA)
               If Res = 6 Then
                    Call imprimir
                    Call Elimina_Plazos
                    'Call Imprimir
                    Call CmdLimpiar


                    
'    With Table1
'        For i = 1 To .Rows - 1
'            .Row = i
'                Envia = Array()
'                AddParam Envia, IIf(.TextMatrix(.Row, 0) = "TRADING", 1, 2)
'                AddParam Envia, Right(.TextMatrix(.Row, 1), 6)
'                    If Not Bac_Sql_Execute("Sp_Elimina_Plazos ", Envia) Then
'                       nerror = -1
'                       sError = "Problemas al Eliminar la Cuenta " & txtCta
'                    End If
'        Next
'    End With
'                If Bac_SQL_Fetch(DATOS()) Then
'                    nerror = DATOS(1)
'                    sError = DATOS(2)
'            End If
'                MsgBox sError, vbInformation + vbOKOnly, TITSISTEMA
'                    If nerror = 0 Then
'                        Call cmdLimpiar
'                        cmbcartera.SetFocus
'                    End If
           End If
          End If
   Case 4
         Call Imprimir_Tool
   Case 5
      CmdLimpiar
   Case 6
       Unload Me
End Select
End Sub
Private Sub Toolbar_ButtonClick(ByVal Button As MSComctlLib.Button)
Dim coun
Dim fo
Select Case Button.Index
   Case 1
    Call cmdGrabar_Pre_Aprobado
   Case 2
       Call Elimina_Plazos
       Call cargar_grilla
       TxtMinimo.text = 0
       TxtMaximo.text = 0
       cmbinstrumento.Clear
      Call LeerInstrumentos
      Call LeerPlazos
   Case 3
      CmdLimpiar
   Case 4
      Unload Me
End Select
End Sub

Sub Elimina_Plazos()

If CDbl(cmbcartera.ItemData(cmbcartera.ListIndex)) Then


With Table1

 Dim i
   
 For i = 1 To Table1.Rows - 1
       Table1.Row = i
       Table1.Col = 5
    If Table1.TextMatrix(Table1.Row, 4) = "ELIMINAR" Then
        Envia = Array()
        AddParam Envia, CDbl(cmbcartera.ItemData(cmbcartera.ListIndex))
        AddParam Envia, Table1.TextMatrix(Table1.Row, 1)
    
        'If MsgBox("Esta Seguro de Eliminar este elemento?", 36, TITSISTEMA) = 6 Then
            If Not Bac_Sql_Execute("Sp_Elimina_Plazos", Envia) Then
                MsgBox "Proceso no se realizó con éxito", vbCritical, TITSISTEMA
                Exit Sub
         'End If
            End If
    End If

Next
End With
Else
         MsgBox "Falta ingresar información para la Eliminación", vbCritical, TITSISTEMA

End If


End Sub


Sub Elimina_Plazos_Preaprobado()
Dim i

If CDbl(cmbcartera.ItemData(cmbcartera.ListIndex)) <> 0 Then
    
With Table1
       
     For i = 1 To Table1.Rows - 1
            Table1.Row = i
            Table1.Col = 4
            If Table1.CellBackColor = vbRed Then

                Envia = Array()
                AddParam Envia, IIf(.TextMatrix(.Row, 0) = "NEGOCIACION", 1, 2)
                AddParam Envia, Right(.TextMatrix(.Row, 1), 6)
                AddParam Envia, Trim(txtUsr_ing.text)
                AddParam Envia, gsBac_User
                AddParam Envia, Trim(txtFec_ing.text)
                AddParam Envia, Format(gsBac_Fecp, gsc_fechadma)
                AddParam Envia, cmbStatus.ItemData(cmbStatus.ListIndex)
                AddParam Envia, 3
            Else
                Envia = Array()
                AddParam Envia, IIf(.TextMatrix(.Row, 0) = "NEGOCIACION", 1, 2)
                AddParam Envia, Right(.TextMatrix(.Row, 1), 6)
                AddParam Envia, Trim(txtUsr_ing.text)
                AddParam Envia, gsBac_User
                AddParam Envia, Trim(txtFec_ing.text)
                AddParam Envia, Format(gsBac_Fecp, gsc_fechadma)
                AddParam Envia, cmbStatus.ItemData(cmbStatus.ListIndex)
                AddParam Envia, 2
            End If
            

            If Not Bac_Sql_Execute("Sp_Elimina_Plazos_Aprobacion", Envia) Then
                MsgBox "No se Pudo Eliminar Limite", vbCritical, TITSISTEMA
                Screen.MousePointer = 0
                Exit Sub
            End If
     Next i
 
     MsgBox "Instrumentos Eliminados OK", vbInformation, TITSISTEMA
         
     Call imprimir
'     Call cmdLimpiar
     
End With
Else
         MsgBox "Falta ingresar información para la Eliminación", vbCritical, TITSISTEMA
End If
End Sub


Private Sub Txt_Ingreso_KeyPress(KeyAscii As Integer)


End Sub



Private Sub TxtDesviacionEstandar_GotFocus()
lDesviacionEstandar = True
End Sub

Private Sub TxtDesviacionEstandar_KeyPress(KeyAscii As Integer)

If KeyAscii% = vbKeyReturn Then
   KeyAscii% = 0
   SendKeys$ "{TAB}"

Else
   KeyAscii = Asc(UCase(Chr(KeyAscii))) 'KeyPress(KeyAscii)

End If

End Sub

Private Sub TxtMinimo_GotFocus()
lTasaInterbancaria = True
End Sub

Private Sub TxtMinimo_KeyPress(KeyAscii As Integer)

If KeyAscii% = vbKeyReturn Then
   KeyAscii% = 0
   SendKeys$ "{TAB}"

Else
   'Call bacKeyPress(KeyAscii)
      KeyAscii = Asc(UCase(Chr(KeyAscii)))

End If

End Sub

Private Sub TxtMaximo_KeyPress(KeyAscii As Integer)

If KeyAscii% = vbKeyReturn Then
   KeyAscii% = 0
   SendKeys$ "{TAB}"

Else
   'Call bacKeyPress(KeyAscii)
      KeyAscii = Asc(UCase(Chr(KeyAscii)))

End If

End Sub


'=====================================================
' LD1_COR_035 , Tema: Mantenedor Plazo Permanencia
' FIN
'=====================================================
