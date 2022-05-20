VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "threed32.ocx"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{989C9190-EDF5-45A8-AB6C-98E6EF0384D7}#1.0#0"; "Bac_Controles_Pas.ocx"
Begin VB.Form BacMntVm 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantención Valores De Monedas"
   ClientHeight    =   4245
   ClientLeft      =   3735
   ClientTop       =   2895
   ClientWidth     =   5490
   ForeColor       =   &H00C0C0C0&
   Icon            =   "Bacmntvm.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4245
   ScaleWidth      =   5490
   Begin VB.Frame Etiqueta 
      BackColor       =   &H00800000&
      BorderStyle     =   0  'None
      Height          =   390
      Left            =   195
      TabIndex        =   13
      Top             =   4335
      Visible         =   0   'False
      Width           =   5025
      Begin VB.Label Label2 
         Alignment       =   2  'Center
         BackColor       =   &H00800000&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "Actualizando Flujos de SWAP en Desk-Manager, Espere ..."
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   300
         Left            =   60
         TabIndex        =   14
         Top             =   45
         Width           =   4890
      End
   End
   Begin VB.ComboBox cmbMes 
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
      Left            =   75
      Style           =   2  'Dropdown List
      TabIndex        =   2
      Top             =   1800
      Width           =   1440
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   3
      Top             =   0
      Width           =   5490
      _ExtentX        =   9684
      _ExtentY        =   794
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Style           =   1
      ImageList       =   "Img_opciones"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      Begin MSComctlLib.ImageList Img_opciones 
         Left            =   4770
         Top             =   60
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   24
         ImageHeight     =   24
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   12
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacmntvm.frx":2EFA
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacmntvm.frx":3361
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacmntvm.frx":3857
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacmntvm.frx":3CEA
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacmntvm.frx":41D2
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacmntvm.frx":46E5
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacmntvm.frx":4BB8
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacmntvm.frx":507E
               Key             =   ""
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacmntvm.frx":5575
               Key             =   ""
            EndProperty
            BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacmntvm.frx":596E
               Key             =   ""
            EndProperty
            BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacmntvm.frx":5D64
               Key             =   ""
            EndProperty
            BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Bacmntvm.frx":62A1
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin BACControles.TXTNumero txtNumerico 
      Height          =   240
      Left            =   1650
      TabIndex        =   4
      Top             =   1545
      Visible         =   0   'False
      Width           =   990
      _ExtentX        =   1746
      _ExtentY        =   423
      BackColor       =   8388608
      ForeColor       =   16777215
      Enabled         =   -1  'True
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BorderStyle     =   0
      Text            =   "0.0000"
      Text            =   "0.0000"
      Min             =   "-999999.9999"
      Max             =   "99999999999"
      CantidadDecimales=   "4"
      Separator       =   -1  'True
   End
   Begin MSFlexGridLib.MSFlexGrid grilla 
      Height          =   2895
      Left            =   1575
      TabIndex        =   1
      Top             =   1320
      Width           =   3915
      _ExtentX        =   6906
      _ExtentY        =   5106
      _Version        =   393216
      Rows            =   13
      FixedCols       =   0
      RowHeightMin    =   280
      BackColor       =   -2147483644
      ForeColor       =   8388608
      BackColorFixed  =   8421376
      ForeColorFixed  =   16777215
      BackColorSel    =   8388608
      ForeColorSel    =   16777215
      BackColorBkg    =   -2147483636
      GridColor       =   0
      FocusRect       =   0
      GridLines       =   2
      GridLinesFixed  =   0
      AllowUserResizing=   2
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
   Begin Threed.SSFrame SSFrame1 
      Height          =   840
      Left            =   30
      TabIndex        =   5
      Top             =   450
      Width           =   5445
      _Version        =   65536
      _ExtentX        =   9604
      _ExtentY        =   1482
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
      Begin VB.TextBox txtCodigo 
         Alignment       =   1  'Right Justify
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   300
         Left            =   75
         MaxLength       =   3
         MouseIcon       =   "Bacmntvm.frx":6762
         MousePointer    =   99  'Custom
         TabIndex        =   0
         Top             =   345
         Width           =   735
      End
      Begin VB.TextBox txtDesMon 
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
         Left            =   1320
         MaxLength       =   50
         TabIndex        =   7
         Top             =   345
         Width           =   4035
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Cód. Moneda"
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
         Index           =   0
         Left            =   90
         TabIndex        =   6
         Top             =   135
         Width           =   1080
      End
   End
   Begin Threed.SSFrame SSFrame4 
      Height          =   2895
      Left            =   30
      TabIndex        =   8
      Top             =   1320
      Width           =   1530
      _Version        =   65536
      _ExtentX        =   2699
      _ExtentY        =   5106
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
      Begin VB.ComboBox cmbano 
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
         Left            =   90
         Style           =   2  'Dropdown List
         TabIndex        =   11
         Top             =   1200
         Width           =   1290
      End
      Begin VB.Label Label 
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
         Index           =   3
         Left            =   75
         TabIndex        =   10
         Top             =   960
         Width           =   330
      End
      Begin VB.Label Label 
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
         Index           =   2
         Left            =   120
         TabIndex        =   9
         Top             =   150
         Width           =   360
      End
   End
   Begin VB.Label Label1 
      Caption         =   "Label1"
      Height          =   270
      Left            =   2430
      TabIndex        =   12
      Top             =   1785
      Width           =   2025
   End
End
Attribute VB_Name = "BacMntVm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim OptLocal As String
Dim Modificado As Boolean
Dim xmncodmon   As Single
Dim xmnnemo     As String
Dim xmnsimbol   As String
Dim xmndescrip  As String
Dim xmnredondeo As Single
Dim xmnbase     As Single
Dim xmntipmon   As Single
Dim xmnperiodo  As Single
Dim xmncodsuper As Single
Dim xmncodbcch  As Single
Dim Sql         As String
Dim Datos()
Dim i As Double

Function GrabarValoresMoneda() As Boolean
   Dim Fila%
   Dim tmpLogic        As Boolean
   On Error GoTo ErrGrabaValores
      
   GrabarValoresMoneda = False
   
   If BacBeginTransaction() Then
      
      With grilla
         
         For Fila% = 1 To .Rows - 1
            If Trim$(.TextMatrix(Fila%, 0)) <> "" Then
               
               Envia = Array()
               AddParam Envia, CDbl(TxtCodigo.Text)
               AddParam Envia, .TextMatrix(Fila%, 0)
               AddParam Envia, CDbl(.TextMatrix(Fila%, 1))
               
               If Not BAC_SQL_EXECUTE("Sp_Graba_ValoresMoneda ", Envia) Then
                  
                  tmpLogic = BacRollBackTransaction()
                  Exit Function
               
               End If
               If BAC_SQL_FETCH(Datos()) Then
                  If Datos(1) = "NO" Then
                     tmpLogic = BacRollBackTransaction()
                     Exit Function
                  End If
               End If
            End If
         Next Fila%
      End With
        
      '----------------------------------------------------------
      'EBQ: Se agrega Actualización de Flujos Swap a Desk-Manager
      '----------------------------------------------------------
      If CDbl(TxtCodigo.Text) = 444 Then
           For Fila% = 1 To 100
                DoEvents
                Me.Height = 5130
                Etiqueta.Visible = True
           Next Fila%
           If Not FUNC_Tasa_Flujo(gsbac_fecp) Then
                err.Description = "¡ No se actualizaron los Flujos en Desk-Manager !"
                Etiqueta.Visible = False
                Me.Height = 4620
                GoTo ErrGrabaValores:
           End If
      End If
      Me.Height = 4620
      Etiqueta.Visible = False
      '----------------------------------------------------------
      
      If Not BacCommitTransaction() Then
         Exit Function
      End If
   Else
      tmpLogic = BacRollBackTransaction()
      Exit Function
   End If
   GrabarValoresMoneda = True
    
Exit Function

ErrGrabaValores:

   tmpLogic = BacRollBackTransaction()
   MsgBox "Error : " & err.descripton, vbOKOnly + vbCritical

End Function

Function FUNC_Tasa_Flujo(dFecha As Date) As Boolean
' ***********************************************************************************
' Repricing de Flujos Variables en DeskManager, gatillado en ingreso de Tasas de SWAP
' ***********************************************************************************
Dim iNumeroFlujo    As Integer
Dim iTipoFlujo      As Integer
Dim lOperacionID    As Long
Dim dTasa           As Double
Dim dInteres        As Double
Dim Conta As Integer
Dim Datos()
Dim Datos1()
        
    Conta = 0
    Dim rst_mensajes As New ADODB.Recordset
    
    If Not FUNC_INFORMACION_CONEXION_DESKMANAGER(rst_mensajes) Then
        FUNC_Tasa_Flujo = False
        Exit Function
    End If
 
    Envia = Array()
    AddParam Envia, dFecha
                                
    If Not BAC_SQL_EXECUTE(cDatabase & "..SP_ACT_TASA_FLUJO", Envia) Then
        FUNC_Tasa_Flujo = False
        Exit Function
    End If
    
    FUNC_Tasa_Flujo = True
    
End Function


Public Function LeerMoneda(CodMon As Integer) As Boolean
    
    LeerMoneda = False
    Envia = Array()
    AddParam Envia, CodMon
    
    If Not BAC_SQL_EXECUTE("sp_mnleer ", Envia) Then Exit Function
   
    If BAC_SQL_FETCH(Datos()) Then
    
        If Val(Datos(1)) > 0 Then
        
            xmncodmon = Datos(1)
            xmnnemo = Datos(2)
            xmnsimbol = Datos(3)
            xmndescrip = Datos(4)
            xmnredondeo = CDbl(Datos(5))
            xmnbase = Datos(6)
            If IsNull(Datos(7)) Then
            
                xmntipmon = Datos(7)
            
            Else
            
                xmntipmon = 0
            
            End If
            
            xmnperiodo = CDbl(Datos(9))
            xmncodsuper = CDbl(Datos(8))
            xmncodbcch = CDbl(Datos(13)) 'MJ se lee el codigo del banco central para luego ser utilizado en fox
        End If
        
    Else
        xmncodmon = 0
        xmnnemo = ""
        xmnsimbol = ""
        xmndescrip = ""
        xmnredondeo = 0
        xmnbase = 0
        xmntipmon = 0
        xmnperiodo = 0
        xmncodsuper = 0
        xmncodbcch = 0
    End If
        LeerMoneda = True
End Function

Public Function LeerValores(codigo As Integer, Mes As Integer, Ano As Integer, Periodo As Single) As Boolean

Dim Existe As Boolean
Dim Fila As Integer

On Error GoTo ErrMDB


   ' db.Execute "Delete * From MDVM;"
   ' Data1.Refresh
    
    LeerValores = False: Existe = False
    
    Envia = Array()
    AddParam Envia, CDbl(codigo)
    AddParam Envia, CDbl(Mes)
    AddParam Envia, CDbl(Ano)
    AddParam Envia, CDbl(Periodo)
   
   If Not BAC_SQL_EXECUTE("Sp_Trae_ValoresMoneda ", Envia) Then
       Exit Function
   End If
    
    
 With grilla
 
   .Redraw = False
   .Rows = 2
    Call F_BacLimpiaGrilla(grilla)
    
    Do While BAC_SQL_FETCH(Datos())
         
           Existe = True
         .TextMatrix(.Rows - 1, 0) = Datos(2) 'fecha
         .TextMatrix(.Rows - 1, 1) = BacCtrlDesTransMonto(Datos(3))
        
         ' Data1.Recordset.AddNew
         ' Data1.Recordset("VmCodigo") = CDBL(Datos(1))
         ' Data1.Recordset("VmValor") = CDbl(Datos(3))
         ' Data1.Recordset("VmFecha") = Datos(2)
         ' Data1.Recordset.Update
        
          .Rows = .Rows + 1
         
    Loop
        
         
    If Existe Then
        
        .Enabled = True
        
        If .Rows <> 3 Then
                
                .Rows = .Rows - 1
           
           Else
              
              'Call BacAgrandaGrilla(Grilla, 20)
        
        End If
    
    Else
         
         .Enabled = False
    
    End If
   
  .Redraw = True
    .Row = .FixedRows
    .Col = 0
   
End With
    
     LeerValores = True
     
     Exit Function

ErrMDB:
     MsgBox "Error : " & err.Description, vbOKOnly + vbCritical
     Exit Function

End Function

Private Function DiasDelMes(Mes As Integer, Ann As Integer) As Integer

Dim dias    As String
Dim Residuo As Currency

    dias = "312831303130313130313031"
    
    If Mes = 2 Then
       Residuo = Ann Mod 4
       If Residuo = 0 Then
          DiasDelMes = 29
       Else
          DiasDelMes = 28
       End If
     Else
       If Mes = 0 Then
          DiasDelMes = 0
       Else
          DiasDelMes = CDbl(Mid$(dias, ((Mes * 2) - 1), 2))
       End If
     End If
     
End Function

Private Sub cmbano_Click()
Call Valores2Grilla
End Sub

Private Sub cmbano_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = 13 Then
   Me.grilla.SetFocus
End If
End Sub

Private Sub cmbMes_Click()

    If cmbMes.ListIndex <> -1 Then
       Call Valores2Grilla
    End If

End Sub

Private Sub cmdGrabar_Click()

On Error GoTo Label1

    Screen.MousePointer = 11
     
    If GrabarValoresMoneda Then
       MsgBox "La grabación se realizó con éxito", vbOKOnly + vbInformation
       
    Else
       MsgBox "No se completo la grabación", vbOKOnly + vbExclamation
    End If
    
    Screen.MousePointer = 0
    Exit Sub

Label1:
       Screen.MousePointer = 0
       MsgBox "Error : " & err.Description, vbOKOnly + vbCritical
       Exit Sub
End Sub

Private Sub cmdlimpiar_Click()
   
   txtNumerico.Visible = False
   txtNumerico.Text = ""
   TxtCodigo.Text = ""
   txtDesMon.Text = ""
'   itbano.Caption = Trim(Year(gsbac_fecp))
   cmbano.Text = Trim(Year(gsbac_fecp))
   cmbMes.ListIndex = Month(gsbac_fecp) - 1
   TxtCodigo.Enabled = True
   TxtCodigo.SetFocus
   grilla.Rows = 2
   Call F_BacLimpiaGrilla(grilla)
   'Call BacAgrandaGrilla(Grilla, 40)
   grilla.Enabled = False
   
   
End Sub

Private Sub cmdSalir_Click()
        
        Unload Me

End Sub


Private Sub cmbMes_KeyDown(KeyCode As Integer, Shift As Integer)
    
    If KeyCode = 13 Then
        cmbano.SetFocus
    End If
    
End Sub

Private Sub PROC_HABILITA_TOOLBAR(bValor As Boolean)

    With Toolbar1
    
      .Buttons(3).Enabled = Not bValor
      '.Buttons(1).Enabled = bValor
      .Buttons(2).Enabled = bValor
    
    End With

End Sub

Private Sub Form_Activate()
   PROC_CARGA_AYUDA Me, " "
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
On Error GoTo err
Dim opcion As Integer

   opcion = 0

'   If KeyCode = vbKeyReturn And Me.ActiveControl.Name <> "TXTNumerico" And Me.ActiveControl.Name <> "grilla" Then
'      KeyCode = 0
'      Bac_SendKey vbKeyTab
'      Exit Sub
'   End If

   If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) Then
     
        Select Case KeyCode

           Case vbKeyLimpiar:
                              opcion = 1
   
            Case vbKeyGrabar:
                              opcion = 2
   
            Case vbKeyBuscar:
                              opcion = 3
                              
            Case vbKeySalir:
                           If UCase(Me.ActiveControl.Name) <> "TXTNUMERICO" Then
                              opcion = 4
                           End If
                      
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
    Modificado = False
On Error GoTo Label1
    
    Call CargarParam_Vm(grilla)
    
    
    Call BacLLenaComboMes(cmbMes)
    For i = 1900 To 2054
      Me.cmbano.AddItem i
    Next i
    
    Call PROC_HABILITA_TOOLBAR(False)
    Me.cmbano.Text = Trim(Year(gsbac_fecp))
    'itbano.Text = Trim(Year(gsbac_fecp))
    'HSclano.Value = Trim(Year(gsbac_fecp)) 'aqui se cae

    cmbMes.Enabled = False
'    HSclano.Enabled = False
     cmbano.Enabled = False

    
    If gsBac_Tcamara = 1 Then
        TxtCodigo.Text = 7
        TxtCodigo.Enabled = False
        cmbMes.ListIndex = Month(gsbac_fecp) - 1
        Call TxtCodigo_LostFocus
    End If
        
     If cmbMes.ListIndex = -1 Then
          cmbMes.ListIndex = Month(gsbac_fecp) - 1
     End If
    
     grilla.Row = grilla.FixedRows
     
     grilla.Rows = 1
     grilla.Enabled = False
     grilla.Cols = 3
     grilla.ColWidth(2) = 0
     grilla.Col = 2
     
     
     Call LogAuditoria("07", OptLocal, Me.Caption, "", "")
     
   
        
   
    Exit Sub

Label1:
      MsgBox "Error : " & err.Description, vbOKOnly + vbCritical
      Unload Me
      Exit Sub
End Sub

Private Sub Form_Unload(Cancel As Integer)
' db.Execute "Delete * from MDVM"
    Call LogAuditoria("08", OptLocal, Me.Caption, "", "")
End Sub

Private Sub Grilla_DblClick()
 
 Call Grilla_KeyPress(13)

End Sub



Private Sub Grilla_GotFocus()
grilla.Col = 1
End Sub

Private Sub Grilla_KeyPress(KeyAscii As Integer)
On Error GoTo ErrGrabaValores
With grilla

   
   If (.Col = 1 And Trim$(.TextMatrix(.Row, 0)) <> "") And (KeyAscii = 13 Or KeyAscii = 8 Or IsNumeric(Chr(KeyAscii))) Then
      
      .Enabled = False
      Linea = .Row
      PROC_POSICIONA_TEXTOX grilla, txtNumerico
      
      If IsNumeric(Chr(KeyAscii)) Then
         
         txtNumerico.Text = Chr(KeyAscii) ' + .TextMatrix(.Row, 1)
         txtNumerico.SelStart = 1
      
      Else
         
         txtNumerico.Text = BacCtrlTransMonto(.TextMatrix(.Row, 1))
      
      End If
      txtNumerico.Visible = True
      txtNumerico.SetFocus
   End If
 End With

Exit Sub

ErrGrabaValores:
  
 ' MsgBox "Error : " & Err.descripton, vbOKOnly + vbCritical
   grilla.Enabled = True
   txtNumerico.Visible = False
  Exit Sub
  
End Sub




Private Sub Valores2Grilla()
On Error GoTo Label1

Dim dias      As Integer
Dim Mes       As Integer
Dim Ann       As Integer
Dim iPeriodo  As Integer
Dim iRedondeo As Integer
Dim lsMask    As String
Dim f         As Integer
Dim Max       As Integer

    
    
If TxtCodigo <> "" Then
    
    MousePointer = 11
         
         If CDbl(TxtCodigo.Text) = 0 Then
            MousePointer = 0
            Exit Sub
         End If
    
'    If cmbMes.Enabled = True Then
       
       If cmbMes.ListIndex = -1 Then
          MsgBox "Debe seleccionar mes", vbOKOnly + vbExclamation
          MousePointer = 0
          Exit Sub
       Else
        Mes = cmbMes.ItemData(cmbMes.ListIndex)
       End If
'    End If
       
 '   Mes = 0
   
'    If cmbMes.ListIndex <> -1 Then
 '       Mes = cmbMes.ItemData(cmbMes.ListIndex)
 '   End If
    
    'Ann = CDbl(itbano.Text)
    Ann = CDbl(cmbano.Text)
    dias = DiasDelMes(Mes, Ann)
    If dias = 0 Then
        dias = 12
    End If

    
    If LeerValores(CDbl(TxtCodigo.Text), Format(Mes, "00"), Ann, xmnperiodo) Then
        iPeriodo = xmnperiodo
        iRedondeo = xmnredondeo
           ' lsMask$ = "#,###,##0" + IIf(iRedondeo = 0, "", "." + String$(iRedondeo, "0"))
           ' grdVMon.EditMask(2) = lsMask$
           ' grdVMon.ColumnSize(2) = Len(lsMask$)
       
    Else
       MsgBox "Problemas en Valores de Moneda", vbOKOnly + vbExclamation
    End If
    

    MousePointer = 0

End If

Exit Sub

Label1:
    MousePointer = 0
    MsgBox "Error : " & err.Description, vbOKOnly + vbCritical
    Exit Sub
End Sub

Private Sub SSFrame1_Click()
    Bac_SendKey (vbKeyTab)
End Sub

Private Sub SSFrame4_Click()
    Bac_SendKey (vbKeyTab)
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index
    
    Case 3
       If Not TxtCodigo.Text = "" Then
       
         If Val(TxtCodigo.Text) > 0 Then
            TxtCodigo_LostFocus
         
         End If
       
       End If
      
    
    Case 1
       Call Limpiar
        
    Case 2
            On Error GoTo Label11

       If TxtCodigo.Text <> "" Then

          Screen.MousePointer = 11
           
          If GrabarValoresMoneda Then
             MsgBox "La grabación se realizó con éxito", vbOKOnly + vbInformation
             Call LogAuditoria("01", OptLocal, Me.Caption, "", "Codigo: " & TxtCodigo.Text & " Mes: " & cmbMes.Text & " Año: " & cmbano.Text)
             If Modificado = True Then Call Grabar_Swich: Modificado = False
          Else
             MsgBox "No se completo la grabación", vbOKOnly + vbExclamation
             Call LogAuditoria("01", OptLocal, Me.Caption & " Error al grabar- Codigo: " & TxtCodigo.Text & " Mes: " & cmbMes.Text & " Año: " & cmbano.Text, "", "")
          End If
          
          Screen.MousePointer = 0
          Call Limpiar
      
      End If
      Exit Sub
      
Label11:
         Screen.MousePointer = 0
         MsgBox "Error : " & err.Description, vbOKOnly + vbCritical
         Exit Sub
    
    Case 4
        Unload Me
End Select
End Sub

Sub Grabar_Swich()
'grabación de swich de tasa de cámara

   Envia = Array()
   AddParam Envia, 1

   If Not BAC_SQL_EXECUTE("Sp_Graba_Swich_Tasa_Camara", Envia) Then

      Exit Sub

   End If

   If BAC_SQL_FETCH(Datos()) Then
      If Datos(1) = "SI" Then
         Exit Sub
      End If
   End If

'fin grabación
End Sub

Private Sub txtcodigo_Change()

    txtDesMon.Text = ""

End Sub

Sub CodigoMon()
On Error GoTo Label1
    TxtCodigo.Text = 0
    MiTag = "MDMN"
    BacAyuda.Show 1
    If giAceptar% = True Then
       TxtCodigo.Text = gsCodigo$
       txtCodigo_KeyPress 13
'       SendKeys "{ENTER}"
    End If
    Exit Sub

Label1:
    MousePointer = 0
    MsgBox "Error : " & err.Description, vbOKOnly + vbCritical
    Exit Sub
End Sub

Private Sub txtCodigo_DblClick()
    auxilio = 100
   Call CodigoMon
End Sub


Private Sub TxtCodigo_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyF3 Then Call CodigoMon
End Sub

Private Sub txtCodigo_KeyPress(KeyAscii As Integer)

    BacCaracterNumerico KeyAscii
    
    If KeyAscii = 13 Then
       TxtCodigo_LostFocus
    End If
    
End Sub

Private Sub TxtCodigo_LostFocus()

If Val(TxtCodigo.Text) = 0 Then Exit Sub

On Error GoTo Label1

    If Trim$(TxtCodigo.Text) <> "" Then
     '   cmbMes.ListIndex = -1
           
        If LeerMoneda(TxtCodigo.Text) = True Then
            If xmncodmon <> 0 Then
                'Encontró la moneda
                '-------------------------------------
               txtDesMon.Text = xmndescrip
               TxtCodigo.Enabled = False
               cmbMes.Enabled = True
               cmbano.Enabled = True
               cmbMes.Enabled = True
'               itbano.Enabled = True
               cmbano.Enabled = True
               grilla.Enabled = True
               grilla.SetFocus
               Call PROC_HABILITA_TOOLBAR(True)
 
            
            Else
                'Moneda no existe en tabla de monedas
                '-------------------------------------
                TxtCodigo.Text = ""
                txtDesMon.Text = ""
                '' itbano.Caption = Year(gsBac_Fecp)
 '               itbano.Text = Trim(Year(gsbac_fecp))
               cmbano.Text = Trim(Year(gsbac_fecp))
                cmbMes.ListIndex = Month(gsbac_fecp) - 1
                ''LimpiaData
                MsgBox "Moneda no existe", vbInformation
                TxtCodigo.SetFocus
            End If
            
        Else
            TxtCodigo.Text = ""
        End If
        
'        If cmbMes.Enabled = True Then
'            If cmbMes.ListIndex = -1 Then
'                cmbMes.ListIndex = Month(gsbac_fecp) - 1
'                Exit Sub
'            End If
'        End If
        Call Valores2Grilla
    
        If grilla.Rows > 1 Then
           grilla.Enabled = True
        Else
           grilla.Enabled = False
        End If
    
    End If

    If grilla.Enabled Then
       grilla.SetFocus
    
    End If

    Exit Sub


Label1:
    MsgBox "Error : " & err.Description, vbOKOnly + vbCritical
    Exit Sub

End Sub

Sub LimpiaData()
'If Data1.Recordset.RecordCount() > 0 Then
'Data1.Recordset.MoveFirst
'Do While Not Data1.Recordset.EOF
' Data1.Recordset.Delete
' Data1.Recordset.MoveNext
'Loop
'End If
'data1.Recordset.Update
End Sub


Public Function CargarParam_Vm(Grillas As Object)

With Grillas

         '.ColWidth(0) = 1
         .ColWidth(0) = 1320
         .ColWidth(1) = 2100
         
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
'         .ColAlignment(1) = 8

End With

End Function

Private Sub TXTFecha1_Change()

End Sub

Private Sub TXTNumerico_KeyPress(KeyAscii As Integer)
   With grilla
      Select Case KeyAscii
         
         Case vbKeyReturn 'Keyascii=13
            
            If CDate(.TextMatrix(.Row, 0)) = CDate(gsbac_fecp) And Me.TxtCodigo.Text = "15" Then Modificado = True
            .TextMatrix(.Row, .Col) = Format(txtNumerico.Text, "#,##0.0000")
            .Enabled = True
            'If .Row = .Rows - 1 Then
            '   Exit Sub
            'Else
            txtNumerico.Visible = False
            If Linea = .Rows - 1 Then
              .TopRow = 1
              .Row = 1
              
         
            Else
               .Row = Linea + 1
            End If
             '.Row = Linea
         
            'End If
             .SetFocus
         Case vbKeyEscape  'Keyascii=27
            
            .Enabled = True
            .SetFocus
                  
            
      End Select
      
  '    .Row = Linea
   End With
End Sub

Private Sub TXTNumerico_LostFocus()

   txtNumerico.Text = ""
   txtNumerico.Visible = False
   grilla.Enabled = True
   
End Sub

Sub Limpiar()

      txtNumerico.Visible = False
      txtNumerico.Text = ""
      TxtCodigo.Text = ""
      txtDesMon.Text = ""
'      itbano.Caption = Trim(Year(gsbac_fecp))
      cmbano.Text = Trim(Year(gsbac_fecp))
      cmbMes.ListIndex = Month(gsbac_fecp) - 1
      TxtCodigo.Enabled = True
      TxtCodigo.SetFocus
      grilla.Rows = 2
      Call F_BacLimpiaGrilla(grilla)
      grilla.Enabled = False
      grilla.Rows = 1
      grilla.Cols = 3
      grilla.ColWidth(2) = 0
      grilla.Col = 2
      cmbMes.Enabled = False
      cmbano.Enabled = False
      'HSclano.Enabled = False
      PROC_HABILITA_TOOLBAR False
   

End Sub

Private Sub PROC_POSICIONA_TEXTOX(grilla As Control, texto As Control)


    texto.top = grilla.CellTop + grilla.top + 10
    texto.left = grilla.CellLeft + grilla.left + 10
    texto.Height = grilla.CellHeight - 20
    texto.Width = grilla.CellWidth - 10

End Sub

