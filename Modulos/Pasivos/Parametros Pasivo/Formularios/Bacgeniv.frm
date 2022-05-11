VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{989C9190-EDF5-45A8-AB6C-98E6EF0384D7}#1.0#0"; "Bac_Controles_Pas.ocx"
Begin VB.Form BacGeniv 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Generación Automática de IVP"
   ClientHeight    =   5055
   ClientLeft      =   2235
   ClientTop       =   2835
   ClientWidth     =   5760
   Icon            =   "Bacgeniv.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5055
   ScaleWidth      =   5760
   Begin MSComctlLib.ImageList Img_opciones 
      Left            =   5010
      Top             =   -30
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   24
      ImageHeight     =   24
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   6
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacgeniv.frx":2EFA
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacgeniv.frx":3361
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacgeniv.frx":3857
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacgeniv.frx":3CEA
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacgeniv.frx":41D2
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacgeniv.frx":46E5
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   5760
      _ExtentX        =   10160
      _ExtentY        =   847
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "Img_opciones"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Generar"
            ImageIndex      =   6
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Cerrar Ventana"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin Threed.SSPanel SSPanel1 
      Height          =   4620
      Left            =   0
      TabIndex        =   1
      Top             =   480
      Width           =   5760
      _Version        =   65536
      _ExtentX        =   10160
      _ExtentY        =   8149
      _StockProps     =   15
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin Threed.SSFrame SSFrame1 
         Height          =   945
         Left            =   45
         TabIndex        =   2
         Top             =   15
         Width           =   5655
         _Version        =   65536
         _ExtentX        =   9975
         _ExtentY        =   1667
         _StockProps     =   14
         Caption         =   " Datos  "
         ForeColor       =   -2147483641
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Font3D          =   3
         ShadowStyle     =   1
         Begin VB.TextBox DtxFechaIVP 
            Alignment       =   2  'Center
            Enabled         =   0   'False
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   320
            Left            =   2040
            Locked          =   -1  'True
            TabIndex        =   3
            Top             =   540
            Width           =   1215
         End
         Begin BACControles.TXTNumero FltIVP 
            Height          =   315
            Left            =   150
            TabIndex        =   4
            Top             =   540
            Width           =   1350
            _ExtentX        =   2381
            _ExtentY        =   556
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Text            =   "0,0000"
            Text            =   "0,0000"
            Min             =   "-999999.99999999"
            Max             =   "999999.99999999"
            CantidadDecimales=   "4"
         End
         Begin VB.Label Label3 
            AutoSize        =   -1  'True
            Caption         =   "Ultima IVP Conocido"
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
            Height          =   210
            Left            =   120
            TabIndex        =   5
            Top             =   300
            Width           =   1650
         End
      End
      Begin Threed.SSFrame SSFrame2 
         Height          =   2850
         Left            =   60
         TabIndex        =   6
         Top             =   1695
         Width           =   2055
         _Version        =   65536
         _ExtentX        =   3620
         _ExtentY        =   5017
         _StockProps     =   14
         Caption         =   " Ingreso "
         ForeColor       =   -2147483641
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.23
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Font3D          =   3
         Begin VB.ComboBox CmbMes 
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   330
            ItemData        =   "Bacgeniv.frx":4BB8
            Left            =   345
            List            =   "Bacgeniv.frx":4BBA
            Style           =   2  'Dropdown List
            TabIndex        =   10
            Top             =   570
            Width           =   1215
         End
         Begin VB.HScrollBar HSclano 
            Enabled         =   0   'False
            Height          =   315
            LargeChange     =   10
            Left            =   1305
            Max             =   2054
            Min             =   1900
            TabIndex        =   8
            Top             =   1440
            Value           =   2000
            Width           =   495
         End
         Begin VB.TextBox IntAnnIng 
            Alignment       =   2  'Center
            Enabled         =   0   'False
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   320
            Left            =   360
            MaxLength       =   4
            TabIndex        =   7
            Top             =   1440
            Width           =   855
         End
         Begin BACControles.TXTNumero FltIpcIng 
            Height          =   315
            Left            =   360
            TabIndex        =   9
            Top             =   2280
            Width           =   1470
            _ExtentX        =   2593
            _ExtentY        =   556
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Text            =   "0,000000"
            Text            =   "0,000000"
            Min             =   "-9999.9999999999"
            Max             =   "9999.9999999999"
            CantidadDecimales=   "6"
            SelStart        =   3
         End
         Begin VB.Label Label5 
            AutoSize        =   -1  'True
            Caption         =   "Mes a Generar"
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
            Height          =   210
            Left            =   360
            TabIndex        =   13
            Top             =   360
            Width           =   1215
         End
         Begin VB.Label Label6 
            AutoSize        =   -1  'True
            Caption         =   "Año"
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
            Height          =   210
            Left            =   375
            TabIndex        =   12
            Top             =   1245
            Width           =   330
         End
         Begin VB.Label Label7 
            AutoSize        =   -1  'True
            Caption         =   "Ind. IPC"
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
            Height          =   210
            Left            =   360
            TabIndex        =   11
            Top             =   2070
            Width           =   615
         End
      End
      Begin MSFlexGridLib.MSFlexGrid grilla 
         Height          =   2655
         Left            =   2160
         TabIndex        =   14
         Top             =   1830
         Width           =   3495
         _ExtentX        =   6165
         _ExtentY        =   4683
         _Version        =   393216
         Rows            =   13
         FixedCols       =   0
         BackColor       =   -2147483644
         ForeColor       =   8388608
         BackColorFixed  =   8421376
         ForeColorFixed  =   16777215
         BackColorSel    =   8388608
         ForeColorSel    =   8388608
         BackColorBkg    =   12632256
         GridColor       =   255
         GridColorFixed  =   8421504
         GridLines       =   2
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin Threed.SSFrame SSFrame3 
         Height          =   2835
         Left            =   2115
         TabIndex        =   15
         Top             =   1710
         Width           =   3585
         _Version        =   65536
         _ExtentX        =   6324
         _ExtentY        =   5001
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
      Begin Threed.SSFrame SSFrame4 
         Height          =   795
         Left            =   45
         TabIndex        =   16
         Top             =   900
         Width           =   5655
         _Version        =   65536
         _ExtentX        =   9975
         _ExtentY        =   1402
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
         ShadowStyle     =   1
         Begin VB.TextBox IntAnn 
            Alignment       =   1  'Right Justify
            Enabled         =   0   'False
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   320
            Left            =   2940
            Locked          =   -1  'True
            MaxLength       =   4
            TabIndex        =   19
            Text            =   "0"
            Top             =   345
            Width           =   735
         End
         Begin VB.TextBox TxtMes 
            Enabled         =   0   'False
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   320
            Left            =   1785
            Locked          =   -1  'True
            TabIndex        =   18
            TabStop         =   0   'False
            Top             =   345
            Width           =   1095
         End
         Begin BACControles.TXTNumero FltIPC 
            Height          =   300
            Left            =   150
            TabIndex        =   17
            Top             =   345
            Width           =   1350
            _ExtentX        =   2381
            _ExtentY        =   529
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Text            =   "0,000000"
            Text            =   "0,000000"
            Min             =   "-999999.9999999999"
            Max             =   "999999.9999999999"
            CantidadDecimales=   "6"
            SelStart        =   3
         End
         Begin VB.Label Label4 
            AutoSize        =   -1  'True
            Caption         =   "Año"
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
            Height          =   210
            Left            =   3015
            TabIndex        =   22
            Top             =   150
            Width           =   330
         End
         Begin VB.Label Label2 
            AutoSize        =   -1  'True
            Caption         =   "Mes"
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
            Height          =   210
            Left            =   1815
            TabIndex        =   21
            Top             =   150
            Width           =   360
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "Ind. IPC"
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
            Height          =   210
            Left            =   195
            TabIndex        =   20
            Top             =   150
            Width           =   615
         End
      End
   End
End
Attribute VB_Name = "BacGeniv"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim OptLocal As String

Private Sub cmbMes_Click()

 IntAnnIng.Text = Val(HSclano.Value)
 
If cmbMes.ListIndex > -1 Then
    
    If FechaMayorActual("01", Format(cmbMes.ItemData(cmbMes.ListIndex), "00"), IntAnnIng.Text) Then
  
         Toolbar1.Buttons(1).Enabled = True
         Toolbar1.Buttons(2).Enabled = True
        ' IntAnnIng.Enabled = True
'        HSclano.Enabled = True
        FltIpcIng.Enabled = True
        ''GrdMo_1.Enabled = True
  
     Call MuestraIIpcAnterior
    Else
 
        MsgBox "No se puede visualizar desde aqui valores de UF anteriores" & Chr(10) & "trate desde el mantenedor de valores de monedas", vbOKOnly + vbExclamation
        cmbMes.ListIndex = -1
    End If
End If
  
End Sub


Private Sub CmdGenerar_Click()

   Dim Sql    As String
   Dim AuxMes As String
   Dim AuxAno As String
   Dim AuxIipc As Double
   Dim Fila   As Integer
   
   Screen.MousePointer = 11
   
   AuxMes = Format(cmbMes.ItemData(cmbMes.ListIndex), "00")
   AuxAno = Str(IntAnnIng.Text)
   AuxIipc = FltIpcIng.Text
   
   'Genera IVP de un mes determinado
   '-------------------------------
   'Sql = "Execute Sp_GeneraIVP " & AuxMes & "," & AuxAno & "," & AuxIipc
   
   Envia = Array()
   AddParam Envia, CDbl(AuxMes)
   AddParam Envia, CDbl(AuxAno)
   AddParam Envia, CDbl(AuxIipc)
   
   
   
   If Not BAC_SQL_EXECUTE("Sp_GeneraIVP", Envia) Then
      
      MsgBox "No se puede generar Ind I.P.C.", vbCritical
      Screen.MousePointer = 0
      Exit Sub
   
   End If
   
   'Muestra I.V.P. Generadas
   '------------------------
   
    
   Dim Datos()
 ''  GrdMo_1.Rows = 0
 ''  GrdIVP.Rows = 1
   
  With grilla
       .Rows = 2
        Call F_BacLimpiaGrilla(grilla)
       .Redraw = False
   Do While BAC_SQL_FETCH(Datos())
       
       .Row = .Rows - 1
       .TextMatrix(.Row, 0) = Format(Datos(1), "dd/mm/yyyy")
       .TextMatrix(.Row, 1) = Datos(2)
       .Rows = .Rows + 1
      
      
      '' GrdIVP.Rows = GrdIVP.Rows + 1
      '' GrdIVP.Row = GrdIVP.Rows - 1
      '' GrdIVP.Col = 1: GrdIVP.Text = datos(1)
      '' GrdIVP.Col = 2: GrdIVP.Text = Val(datos(2))
   Loop
 If .Rows <> 2 Then .Rows = .Rows - 1
    .Redraw = True
 End With
   
   Screen.MousePointer = 11
   
  '' GrdMo_1.Rows = 0
  '' GrdMo_1.Refresh
  '' GrdMo_1.Rows = GrdIVP.Rows - 1
   
   Screen.MousePointer = 0

End Sub

Private Sub cmdlimpiar_Click()
  
  cmbMes.ListIndex = -1
  Label7.Caption = "IPC"
  grilla.Rows = 2
  Call F_BacLimpiaGrilla(grilla)
  'Call BacAgrandaGrilla(Grilla, 40)
  grilla.Enabled = False

  cmbMes.ListIndex = -1
  FltIpcIng.Text = 0
  IntAnnIng.Text = Year(gsbac_fecp)

  Toolbar1.Buttons(1).Enabled = False
  Toolbar1.Buttons(2).Enabled = False
  
  FltIpcIng.Enabled = False
  ''IntAnnIng.Enabled = False
  HSclano.Enabled = False
 '' GrdIVP.Rows = 1
 '' GrdIVP.Row = 0
 '' GrdMo_1.Enabled = False
 '' GrdMo_1.Rows = 0
 '' GrdMo_1.RowIndex = 0
  
  cmbMes.SetFocus

End Sub

Private Sub cmdSalir_Click()
    Unload Me
End Sub

Private Sub MuestraIIpcAnterior()
Dim Sql     As String
Dim nMes    As Integer
Dim nAnn    As Integer
Dim Datos()

On Error GoTo Error
    
    If cmbMes.ListIndex = -1 Then
       Exit Sub
    End If
    
    If cmbMes.ListIndex = 0 Then
       nMes = 12
       nAnn = Val(IntAnnIng.Text) - 1
    Else
       nMes = cmbMes.ItemData(cmbMes.ListIndex) - 1
       nAnn = IntAnnIng.Text
    End If
    
    'Sql = "EXECUTE sp_LeeIipcAnterior " & nMes & "," & nAnn
    
    Envia = Array(nMes, nAnn)
    
    If Not BAC_SQL_EXECUTE("sp_LeeIipcAnterior", Envia) Then
       
       MsgBox "No se puede leer Indice I.P.C. anterior", vbCritical
       Exit Sub
    
    End If
    
    FltIpcIng.Text = 0
    
    If BAC_SQL_FETCH(Datos()) Then
       
       FltIpcIng.Text = BacCtrlTransMonto(Datos(1))
    
    End If
    
    Exit Sub
    
Error:
    MsgBox "Problemas en lectura de I.P.C: " & err.desctiption & ". Comunique al Administrador.", vbCritical
    Exit Sub
End Sub

Private Sub DtxFechaIVP_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
    Bac_SendKey (vbKeyTab)
End If
End Sub

Private Sub FltIpcIng_LostFocus()
    'FltIpcIng.SetFocus
End Sub

Private Sub Form_Activate()
   PROC_CARGA_AYUDA Me, " "
   Call CargarParam_Vm(grilla)
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
On Error GoTo err
Dim opcion As Integer

   opcion = 0

   If KeyCode = vbKeyReturn Then
      KeyCode = 0
      Bac_SendKey vbKeyTab
      Exit Sub
   End If

   If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) Then
     
        Select Case KeyCode
            
           Case vbKeyCalcular
                              opcion = 2

           Case vbKeyLimpiar:
                              opcion = 1
   
            Case vbKeySalir:
                              opcion = 3
                      
      End Select

      If opcion <> 0 Then
            If Toolbar1.Buttons(opcion).Enabled Then
               Call Toolbar1_ButtonClick(Toolbar1.Buttons(opcion))
            End If
   
            KeyCode = 0
      End If
    
      
   End If
Exit Sub
err:
  Resume Next
End Sub

Private Sub Form_Load()
    Me.top = 0
    Me.left = 0
   
   'Meses
   Call BacLLenaComboMes(cmbMes)
   
   'Año de Ingreso
   IntAnnIng.Text = Trim(Year(gsbac_fecp))
   HSclano.Value = Trim(Year(gsbac_fecp))

   
  '' IntAnnIng.Text = Year(gsBac_Fecp)
  
    Toolbar1.Buttons(1).Enabled = False
    Toolbar1.Buttons(2).Enabled = False
   
   Envia = Array()
   AddParam Envia, "09/" + Format(gsbac_fecp, "MM/YYYY")
   AddParam Envia, "01/" + Format(gsbac_fecp, "MM/YYYY")

   
   If Not BAC_SQL_EXECUTE("sp_leeultimoIVP", Envia) Then
      
      MsgBox "No se puede leer última I.V.P. ", vbCritical
      Screen.MousePointer = 0
      Exit Sub
   
   End If
 
   Dim Datos()
 
   If BAC_SQL_FETCH(Datos()) Then
       
       FltIVP.Text = BacCtrlTransMonto(Datos(1))
       DtxFechaIVP.Text = Format(Datos(2), "dd/mm/yyyy")
       FltIPC.Text = BacCtrlTransMonto(Datos(3))
       FltIpcIng.Text = BacCtrlTransMonto(FltIPC.Text)
       
       If Trim(Datos(4)) <> "" Then
            
          TxtMes.Text = cmbMes.List(Val(Mid$(Datos(4), 4, 2)) - 1)
          IntAnn.Text = Val(DatePart("yyyy", Datos(4)))
          cmbMes.Text = cmbMes.List(Val(Mid$(Datos(2), 4, 2)) - 1)
       Else
          
          TxtMes.Text = ""
          IntAnn.Text = 0
       
       End If
   
   End If
 
   Screen.MousePointer = 0
   grilla.Enabled = False
   FltIpcIng.Enabled = True
    
   Call LogAuditoria("07", OptLocal, Me.Caption, "", "")
End Sub

Private Sub GrdMo_1_Fetch(Row As Long, Col As Integer, Value As String)

'      GrdIVP.Row = Row
'      GrdIVP.Col = Col
'      GrdMo_1.Text = GrdIVP.Text

End Sub



Private Sub GrdMo_1_FetchAttributes(Status As Integer, Split As Integer, Row As Long, Col As Integer, FgColor As Long, BgColor As Long, FontStyle As Integer)
'   If Col = GrdMo_1.ColumnIndex And Row = GrdMo_1.RowIndex Then
'        FgColor = BacToolTip.Color_Dest.ForeColor
'        BgColor = BacToolTip.Color_Dest.BackColor
'    Else
'        FgColor = BacToolTip.Color_Normal.ForeColor
'        BgColor = BacToolTip.Color_Normal.BackColor
'    End If
End Sub

Private Sub Form_Unload(Cancel As Integer)
   Call LogAuditoria("08", OptLocal, Me.Caption, "", "")
End Sub

Private Sub HSclano_Change()

  IntAnnIng.Text = Val(HSclano.Value)

 If FechaMayorActual("01", cmbMes.Text, IntAnnIng.Text) Then
    Call MuestraIIpcAnterior
 Else
    MsgBox "No se puede visualizar desde aqui valores de UF anteriores" & Chr(10) & "trate desde el mantenedor de valores de monedas", vbOKOnly + vbExclamation
    cmbMes.ListIndex = -1
End If


End Sub

Public Function CargarParam_Vm(Grillas As Object)

With Grillas

         '.ColWidth(0) = 1
         .ColWidth(0) = 1270
         .ColWidth(1) = 1850
         
         .RowHeight(0) = 350
         .CellFontWidth = 4
         

         .Row = 0
         
         .Col = 0
         .FixedAlignment(0) = 4
         .CellFontBold = True
         .Text = " Fecha "
         .ColAlignment(0) = 4

         .Col = 1
         .FixedAlignment(1) = 4
         .CellFontBold = True
         .Text = " Valor "
         .ColAlignment(1) = 8

End With

End Function

Private Sub IntAnn_NumeroInvalido()

End Sub

Private Sub IntAnn_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
    Bac_SendKey (vbKeyTab)
End If
End Sub

Private Sub SSFrame1_Click()
    Bac_SendKey (vbKeyTab)
End Sub

Private Sub SSFrame2_Click()
    Bac_SendKey (vbKeyTab)
End Sub

Private Sub SSFrame3_Click()
    Bac_SendKey (vbKeyTab)
End Sub

Private Sub SSFrame4_Click()
    Bac_SendKey (vbKeyTab)
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index
    Case 2
           Dim Sql    As String
   Dim AuxMes As String
   Dim AuxAno As String
   Dim AuxIipc As Double
   Dim Fila   As Integer
   
   Screen.MousePointer = 11
   grilla.Enabled = True
   AuxMes = Format(cmbMes.ItemData(cmbMes.ListIndex), "00")
   AuxAno = Str(IntAnnIng.Text)
   AuxIipc = FltIpcIng.Text
   
   'Genera IVP de un mes determinado
   '-------------------------------
   'Sql = "Execute Sp_GeneraIVP " & AuxMes & "," & AuxAno & "," & AuxIipc
   
   Envia = Array()
   AddParam Envia, CDbl(AuxMes)
   AddParam Envia, CDbl(AuxAno)
   AddParam Envia, CDbl(AuxIipc)
   AddParam Envia, CDbl(FltIVP.Text)
   AddParam Envia, "09/" + Format(gsbac_fecp, "MM/YYYY")
   
   If Not BAC_SQL_EXECUTE("Sp_GeneraIVP ", Envia) Then
      
      MsgBox "No se puede generar Ind I.P.C.", vbCritical
      Screen.MousePointer = 0
      Exit Sub
   
   End If
   
   'Muestra I.V.P. Generadas
   '------------------------
   
    
   Dim Datos()
 ''  GrdMo_1.Rows = 0
 ''  GrdIVP.Rows = 1
   
  With grilla
       .Rows = 2
        Call F_BacLimpiaGrilla(grilla)
       .Redraw = False
   Do While BAC_SQL_FETCH(Datos())
       
       .Row = .Rows - 1
       .TextMatrix(.Row, 0) = Format(Datos(1), "dd/mm/yyyy")
       .TextMatrix(.Row, 1) = Format(Datos(2), FDecimal)
       .Rows = .Rows + 1
      
      
      '' GrdIVP.Rows = GrdIVP.Rows + 1
      '' GrdIVP.Row = GrdIVP.Rows - 1
      '' GrdIVP.Col = 1: GrdIVP.Text = datos(1)
      '' GrdIVP.Col = 2: GrdIVP.Text = Val(datos(2))
   Loop
 If .Rows <> 2 Then .Rows = .Rows - 1
    .Enabled = True
    .Redraw = True
 End With
   
   Screen.MousePointer = 11
   
  '' GrdMo_1.Rows = 0
  '' GrdMo_1.Refresh
  '' GrdMo_1.Rows = GrdIVP.Rows - 1
   
   Screen.MousePointer = 0

    Case 1
    
         grilla.Tag = grilla.Rows
         grilla.Rows = 1
         grilla.Rows = grilla.Tag
         grilla.Enabled = False
         cmbMes.ListIndex = -1
''''''  Label7.Caption = "IPC"
''''''  grilla.Rows = 2
''''''  Call F_BacLimpiaGrilla(grilla)
''''''  'Call BacAgrandaGrilla(Grilla, 40)
''''''  grilla.Enabled = False
''''''
''''''  'CmbMes.ListIndex = -1
''''''  FltIpcIng.Text = 0
''''''  IntAnnIng.Text = Year(gsbac_fecp)
''''''
''''''  Toolbar1.Buttons(1).Enabled = False
''''''  Toolbar1.Buttons(2).Enabled = False
''''''  FltIpcIng.Enabled = False
''''''  ''IntAnnIng.Enabled = False
''''''  HSclano.Enabled = False
'''''' '' GrdIVP.Rows = 1
'''''' '' GrdIVP.Row = 0
'''''' '' GrdMo_1.Enabled = False
'''''' '' GrdMo_1.Rows = 0
'''''' '' GrdMo_1.RowIndex = 0
  
    Case 3
    Unload Me
End Select
    
End Sub


