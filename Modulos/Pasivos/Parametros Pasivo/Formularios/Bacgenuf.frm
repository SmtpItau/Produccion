VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{989C9190-EDF5-45A8-AB6C-98E6EF0384D7}#1.0#0"; "Bac_Controles_Pas.ocx"
Begin VB.Form BacGenUF 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Generación Automática de UF"
   ClientHeight    =   5220
   ClientLeft      =   45
   ClientTop       =   2760
   ClientWidth     =   5760
   Icon            =   "Bacgenuf.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5220
   ScaleWidth      =   5760
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
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList Img_opciones 
         Left            =   4590
         Top             =   0
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
               Picture         =   "Bacgenuf.frx":2EFA
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacgenuf.frx":3361
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacgenuf.frx":3857
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacgenuf.frx":3CEA
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacgenuf.frx":41D2
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacgenuf.frx":46E5
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin Threed.SSPanel SSPanel1 
      Height          =   4680
      Left            =   0
      TabIndex        =   1
      Top             =   540
      Width           =   5745
      _Version        =   65536
      _ExtentX        =   10134
      _ExtentY        =   8255
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
         Height          =   1005
         Left            =   45
         TabIndex        =   2
         Top             =   15
         Width           =   5640
         _Version        =   65536
         _ExtentX        =   9948
         _ExtentY        =   1773
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
         Begin VB.TextBox DtxFechaUF 
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
            Height          =   315
            Left            =   1530
            Locked          =   -1  'True
            TabIndex        =   3
            Top             =   600
            Width           =   1215
         End
         Begin BACControles.TXTNumero FltUF 
            Height          =   315
            Left            =   165
            TabIndex        =   4
            Top             =   600
            Width           =   1275
            _ExtentX        =   2249
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
            Max             =   "999999.99"
            CantidadDecimales=   "4"
            Separator       =   -1  'True
         End
         Begin VB.Label Label3 
            AutoSize        =   -1  'True
            Caption         =   "Ultima UF Conocida"
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
            Left            =   165
            TabIndex        =   5
            Top             =   300
            Width           =   1560
         End
      End
      Begin Threed.SSFrame SSFrame4 
         Height          =   780
         Left            =   45
         TabIndex        =   6
         Top             =   960
         Width           =   5640
         _Version        =   65536
         _ExtentX        =   9948
         _ExtentY        =   1376
         _StockProps     =   14
         ForeColor       =   -2147483641
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
            Height          =   315
            Left            =   2745
            Locked          =   -1  'True
            MaxLength       =   4
            TabIndex        =   9
            Top             =   390
            Width           =   715
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
            Height          =   315
            Left            =   1545
            Locked          =   -1  'True
            TabIndex        =   8
            TabStop         =   0   'False
            Top             =   390
            Width           =   1095
         End
         Begin BACControles.TXTNumero FltIPC 
            Height          =   315
            Left            =   150
            TabIndex        =   7
            Top             =   375
            Width           =   1365
            _ExtentX        =   2408
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
            Min             =   "-10000"
            CantidadDecimales=   "6"
            Separator       =   -1  'True
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
            Left            =   2745
            TabIndex        =   12
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
            Left            =   1545
            TabIndex        =   11
            Top             =   150
            Width           =   360
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "IPC"
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
            Left            =   180
            TabIndex        =   10
            Top             =   150
            Width           =   270
         End
      End
      Begin Threed.SSFrame SSFrame2 
         Height          =   2850
         Left            =   45
         TabIndex        =   13
         Top             =   1755
         Width           =   2055
         _Version        =   65536
         _ExtentX        =   3620
         _ExtentY        =   5017
         _StockProps     =   14
         Caption         =   " Ingreso "
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
            Left            =   360
            Style           =   2  'Dropdown List
            TabIndex        =   17
            Top             =   600
            Width           =   1215
         End
         Begin VB.HScrollBar HSclano 
            Enabled         =   0   'False
            Height          =   315
            LargeChange     =   10
            Left            =   1320
            Max             =   2054
            Min             =   1900
            TabIndex        =   15
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
            Height          =   285
            Left            =   360
            TabIndex        =   14
            Top             =   1440
            Width           =   735
         End
         Begin BACControles.TXTNumero FltIpcIng 
            Height          =   315
            Left            =   345
            TabIndex        =   16
            Top             =   2280
            Width           =   1440
            _ExtentX        =   2540
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
            Min             =   "-1000"
            Max             =   "999.99"
            CantidadDecimales=   "6"
            Separator       =   -1  'True
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
            TabIndex        =   20
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
            Left            =   360
            TabIndex        =   19
            Top             =   1200
            Width           =   330
         End
         Begin VB.Label Label7 
            AutoSize        =   -1  'True
            Caption         =   "IPC"
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
            TabIndex        =   18
            Top             =   2040
            Width           =   270
         End
      End
      Begin MSFlexGridLib.MSFlexGrid grilla 
         Height          =   2655
         Left            =   2160
         TabIndex        =   21
         TabStop         =   0   'False
         Top             =   1905
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
         BackColorBkg    =   -2147483644
         GridColor       =   255
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
         Height          =   2850
         Left            =   2115
         TabIndex        =   22
         Top             =   1755
         Width           =   3585
         _Version        =   65536
         _ExtentX        =   6324
         _ExtentY        =   5027
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
   End
End
Attribute VB_Name = "BacGenUF"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim OptLocal As String

Private Sub MuestraIpcAnterior()
Dim Sql     As String
Dim cFecha  As String
Dim Datos()

    If cmbMes.ListIndex = -1 Then
       Exit Sub
    End If
    
    If cmbMes.ListIndex = 0 Then
       cFecha = "12/01/" + Trim$(CStr(IntAnnIng.Text - 1))
    Else
       cFecha = Trim$(CStr(Format(cmbMes.ItemData(cmbMes.ListIndex), "00"))) + "/01/" + Trim$(CStr(IntAnnIng.Text))
    End If
    
    'Sql = "EXECUTE sp_LeeIpcAnterior " & "'" & cFecha & "'"
    
    Envia = Array(cFecha)
    
    If Not BAC_SQL_EXECUTE("sp_LeeIpcAnterior", Envia) Then
       
       MsgBox "No se puede leer I.P.C. anterior", 64
       FltIpcIng.Text = 0
       Exit Sub
    
    End If
    
    
    If BAC_SQL_FETCH(Datos()) Then
       FltIpcIng.Text = BacCtrlTransMonto(Datos(1))
    End If
    

End Sub

Private Sub cmbMes_Click()

If cmbMes.ListIndex > -1 Then

If FechaMayorActual("01", Format(cmbMes.ItemData(cmbMes.ListIndex), "00"), IntAnnIng.Text) Then
  Toolbar1.Buttons(1).Enabled = True
  Toolbar1.Buttons(2).Enabled = True
  
  'IntAnnIng.Enabled = True
  FltIpcIng.Enabled = True
 ' GrdMo_1.Enabled = True
  grilla.Enabled = True
  Call MuestraIpcAnterior
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
   Dim AuxIpc As Double

   
   Screen.MousePointer = 11
   
   AuxMes = Format(cmbMes.ItemData(cmbMes.ListIndex), "00")
   AuxAno = Str(IntAnnIng.Text)
   AuxIpc = Val(FltIpcIng.Text)
   
   'Genera UF de un mes determinado
   '-------------------------------
   
   Envia = Array()
   AddParam Envia, CDbl(AuxMes)
   AddParam Envia, CDbl(AuxAno)
   AddParam Envia, CDbl(AuxIpc)
   AddParam Envia, "09/" + Format(gsbac_fecp, "MM/YYYY")
   
   If Not BAC_SQL_EXECUTE("Sp_GeneraUF", Envia) Then
      
      MsgBox "No se puede generar UF", 64
      Screen.MousePointer = 0
      Exit Sub
   
   End If
   
   'Muestra U.F. Generadas
   '----------------------
   
With grilla

   Dim Datos()
  
     
     .Rows = 2
     Call F_BacLimpiaGrilla(grilla)
     .Redraw = False
   Do While BAC_SQL_FETCH(Datos())
      
      .Row = .Rows - 1
      .TextMatrix(.Row, 0) = Datos(1)
      .TextMatrix(.Row, 1) = BacStrTran(CStr(Datos(2)), ",", ".")
      .Rows = .Rows + 1
      
      
   Loop
   If .Rows <> 2 Then .Rows = .Rows - 1
  .Redraw = True
End With
   
   Screen.MousePointer = 0

End Sub

Private Sub cmdlimpiar_Click()

  cmbMes.ListIndex = -1
  
  Label7.Caption = "IPC"
  
  cmbMes.ListIndex = -1
  FltIpcIng.Text = 0
  IntAnnIng.Text = Year(gsbac_fecp)
  HSclano.Value = IntAnnIng.Text
  grilla.Rows = 2
  Call F_BacLimpiaGrilla(grilla)
  'Call BacAgrandaGrilla(Grilla, 40)
  grilla.Enabled = False

  CmdGenerar.Enabled = False
  cmdLimpiar.Enabled = False
  FltIpcIng.Enabled = False
  IntAnnIng.Enabled = False
  
  ''GrdUF.Rows = 1
  ''GrdUF.Row = 0
  ''GrdMo_1.Enabled = False
  ''GrdMo_1.Rows = 0
  ''GrdMo_1.RowIndex = 0
  
  cmbMes.SetFocus

End Sub

Private Sub cmdSalir_Click()
  Unload BacGenUF
End Sub
Private Sub DtxFechaUF_KeyPress(KeyAscii As Integer)
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
   OptLocal = Opt
    Me.top = 0
    Me.left = 0

 
  '  GrdMo_1.ColumnCellAttrs(1) = True
  '  GrdMo_1.ColumnCellAttrs(2) = True

    
   'Meses
   Call BacLLenaComboMes(cmbMes)
   
   
      'Año de Ingreso
    IntAnnIng.Text = Trim(Year(gsbac_fecp))
    HSclano.Value = Trim(Year(gsbac_fecp))

    Toolbar1.Buttons(1).Enabled = False
    Toolbar1.Buttons(2).Enabled = False
   
   ''IntAnnIng.Text = Year(gsBac_Fecp)
   
   
   Envia = Array()
   AddParam Envia, "09/" + Format(gsbac_fecp, "MM/YYYY")
   AddParam Envia, "01/" + Format(gsbac_fecp, "MM/YYYY")
   
   
   If Not BAC_SQL_EXECUTE("sp_leeultimaUF", Envia) Then
      
      MsgBox "No Se puede Leer última U.F.", 64
      Screen.MousePointer = 0
      Exit Sub
   
   End If
 
   Dim Datos()
 
   If BAC_SQL_FETCH(Datos()) Then
       
       FltUF.Text = BacCtrlTransMonto(Datos(1))
       DtxFechaUF.Text = Format(Datos(2), "dd/mm/yyyy")
       FltIPC.Text = BacCtrlTransMonto(Datos(3))
       FltIpcIng.Text = BacCtrlTransMonto(Datos(3))
       
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
            
      GrdUF.Row = Row
      GrdUF.Col = Col
      GrdMo_1.Text = GrdUF.Text

      
End Sub



Private Sub GrdMo_1_FetchAttributes(Status As Integer, Split As Integer, Row As Long, Col As Integer, FgColor As Long, BgColor As Long, FontStyle As Integer)

    If Col = GrdMo_1.ColumnIndex And Row = GrdMo_1.RowIndex Then
        FgColor = BacToolTip.Color_Dest.ForeColor
        BgColor = BacToolTip.Color_Dest.BackColor
    Else
        FgColor = BacToolTip.Color_Normal.ForeColor
        BgColor = BacToolTip.Color_Normal.BackColor
    End If
       

End Sub

Private Sub Form_Unload(Cancel As Integer)
    Call LogAuditoria("08", OptLocal, Me.Caption, "", "")
End Sub

Private Sub HSclano_Change()

IntAnnIng.Text = Val(HSclano.Value)

If FechaMayorActual("01", cmbMes.Text, IntAnnIng.Text) Then
     Call MuestraIpcAnterior
Else
    MsgBox "No se puede visualizar desde aqui valores de UF anteriores" & Chr(10) & "trate desde el mantenedor de valores de monedas", vbOKOnly + vbExclamation
    cmbMes.ListIndex = -1
End If


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


Public Function CargarParam_Vm(Grillas As Object)

With Grillas
        
         ''.ColWidth(0) = 1320
         ''.ColWidth(1) = 2100
         
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

Private Sub SSFrame3_Click()
    Bac_SendKey (vbKeyTab)
End Sub

Private Sub SSFrame4_Click()
    Bac_SendKey (vbKeyTab)
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index
    Case 2

         Genera_Uf
         grilla.Enabled = True
    Case 1
               
               grilla.Tag = grilla.Rows
               grilla.Rows = 1
               grilla.Rows = grilla.Tag
               grilla.Enabled = False
            'CmbMes.ListIndex = -1
'            Label7.Caption = "IPC"
'            cmbMes.ListIndex = -1
'            FltIpcIng.Text = FltIPC.Text
'            IntAnnIng.Text = Year(gsbac_fecp)
'            HSclano.Value = IntAnnIng.Text
'            grilla.Rows = 2
''
            Call F_BacLimpiaGrilla(grilla)
''
            'Call BacAgrandaGrilla(Grilla, 40)
''
            grilla.Enabled = False
            Toolbar1.Buttons(1).Enabled = False
            Toolbar1.Buttons(2).Enabled = False
            FltIpcIng.Enabled = False
            IntAnnIng.Enabled = False

    Case 3
            Unload BacGenUF

End Select

End Sub

Sub Genera_Uf()

            Dim Sql    As String
            Dim AuxMes As String
            Dim AuxAno As String
            Dim AuxIpc As Double
            
            Screen.MousePointer = 11
            
            AuxMes = Format(cmbMes.ItemData(cmbMes.ListIndex), "00")
            AuxAno = Str(IntAnnIng.Text)
            AuxIpc = FltIpcIng.Text
            
            'Genera UF de un mes determinado
            '-------------------------------
            
            'Sql = "Execute Sp_GeneraUF " & AuxMes & "," & AuxAno & "," & AuxIpc
            
            Envia = Array()
            AddParam Envia, CDbl(AuxMes)
            AddParam Envia, CDbl(AuxAno)
            AddParam Envia, CDbl(AuxIpc)
            AddParam Envia, CDbl(FltUF.Text)
            AddParam Envia, "09/" + Format(gsbac_fecp, "MM/YYYY")
            
            If Not BAC_SQL_EXECUTE("Sp_GeneraUF", Envia) Then
            
               MsgBox "No se puede generar UF", 64
               Screen.MousePointer = 0
               Exit Sub
            
            End If
            
            'Muestra U.F. Generadas
            '----------------------
            
            With grilla
            
               Dim Datos()
               
               '' GrdUF.Rows = 1
               
               .Rows = 2
               
               Call F_BacLimpiaGrilla(grilla)
               
               .Redraw = False
                  
                  Do While BAC_SQL_FETCH(Datos())
                  
                     .Row = .Rows - 1
                     .TextMatrix(.Row, 0) = Datos(2)
                     .TextMatrix(.Row, 1) = Format(Datos(3), FDecimal)
                     .Rows = .Rows + 1
                  
                  Loop
               
               If .Rows <> 2 Then .Rows = .Rows - 1
               .Redraw = True
               
            End With
            
            
            Screen.MousePointer = 0

End Sub



