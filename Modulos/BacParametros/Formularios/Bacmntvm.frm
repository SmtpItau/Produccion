VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BACCONTROLES.OCX"
Begin VB.Form BacMntVm 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantención Valores De Monedas"
   ClientHeight    =   3915
   ClientLeft      =   3075
   ClientTop       =   2625
   ClientWidth     =   5760
   ForeColor       =   &H00C0C0C0&
   Icon            =   "Bacmntvm.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   3915
   ScaleWidth      =   5760
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   5490
      Top             =   0
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   3
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntvm.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntvm.frx":075E
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacmntvm.frx":0A82
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   6
      Top             =   0
      Width           =   5760
      _ExtentX        =   10160
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin Threed.SSPanel SSPanel1 
      Height          =   3360
      Left            =   0
      TabIndex        =   0
      Top             =   540
      Width           =   5790
      _Version        =   65536
      _ExtentX        =   10213
      _ExtentY        =   5927
      _StockProps     =   15
      Caption         =   "SSPanel1"
      BackColor       =   -2147483644
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin BACControles.TXTNumero TXTNUM 
         Height          =   255
         Left            =   5880
         TabIndex        =   19
         Top             =   2520
         Visible         =   0   'False
         Width           =   1455
         _ExtentX        =   2566
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
         Text            =   "0,0000"
         Text            =   "0,0000"
         Max             =   "10000000"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTNumero txtNumerico 
         Height          =   270
         Left            =   3960
         TabIndex        =   8
         Top             =   1560
         Visible         =   0   'False
         Width           =   1200
         _ExtentX        =   2117
         _ExtentY        =   476
         BackColor       =   8388608
         ForeColor       =   16777215
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0,0000"
         Text            =   "0,0000"
         Max             =   "99999999999"
         CantidadDecimales=   "4"
      End
      Begin VB.TextBox txtCodigo 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00FFFFFF&
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
         Height          =   300
         Left            =   240
         MaxLength       =   3
         MouseIcon       =   "Bacmntvm.frx":0DA6
         MousePointer    =   99  'Custom
         TabIndex        =   1
         Top             =   360
         Width           =   735
      End
      Begin VB.TextBox txtDesMon 
         BackColor       =   &H00FFFFFF&
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
         Height          =   300
         Left            =   1800
         MaxLength       =   50
         TabIndex        =   2
         Top             =   360
         Width           =   3870
      End
      Begin MSFlexGridLib.MSFlexGrid grilla 
         Height          =   2415
         Left            =   1800
         TabIndex        =   5
         Top             =   810
         Width           =   3870
         _ExtentX        =   6826
         _ExtentY        =   4260
         _Version        =   393216
         Rows            =   13
         Cols            =   3
         FixedCols       =   0
         RowHeightMin    =   315
         BackColor       =   -2147483644
         ForeColor       =   8388608
         BackColorFixed  =   8421376
         ForeColorFixed  =   16777215
         BackColorSel    =   8388608
         ForeColorSel    =   16777215
         BackColorBkg    =   -2147483645
         GridColor       =   16777215
         GridColorFixed  =   16777215
         FocusRect       =   0
         GridLines       =   2
         GridLinesFixed  =   0
         AllowUserResizing=   2
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
      Begin Threed.SSFrame SSFrame1 
         Height          =   720
         Left            =   60
         TabIndex        =   9
         Top             =   15
         Width           =   1650
         _Version        =   65536
         _ExtentX        =   2910
         _ExtentY        =   1270
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
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "Cód. Moneda"
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
            Index           =   0
            Left            =   90
            TabIndex        =   10
            Top             =   135
            Width           =   1140
         End
      End
      Begin VB.Frame Frame1 
         Height          =   2655
         Left            =   60
         TabIndex        =   7
         Top             =   660
         Width           =   1650
         Begin VB.ComboBox cmbMes 
            BackColor       =   &H00FFFFFF&
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
            Left            =   120
            Style           =   2  'Dropdown List
            TabIndex        =   3
            Top             =   495
            Width           =   1395
         End
         Begin VB.HScrollBar HSclano 
            Height          =   315
            LargeChange     =   10
            Left            =   930
            Max             =   2054
            Min             =   1900
            TabIndex        =   4
            Top             =   1560
            Value           =   2000
            Width           =   495
         End
         Begin Threed.SSFrame SSFrame4 
            Height          =   810
            Left            =   60
            TabIndex        =   14
            Top             =   120
            Width           =   1530
            _Version        =   65536
            _ExtentX        =   2699
            _ExtentY        =   1429
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
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Mes"
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
               Index           =   2
               Left            =   120
               TabIndex        =   15
               Top             =   150
               Width           =   360
            End
         End
         Begin Threed.SSFrame SSFrame5 
            Height          =   1080
            Left            =   60
            TabIndex        =   16
            Top             =   915
            Width           =   1515
            _Version        =   65536
            _ExtentX        =   2672
            _ExtentY        =   1905
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
            Begin VB.Label itbano 
               Alignment       =   2  'Center
               BackColor       =   &H80000005&
               BorderStyle     =   1  'Fixed Single
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
               TabIndex        =   18
               ToolTipText     =   "Cambio de Año ->"
               Top             =   645
               Width           =   615
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Año"
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
               Index           =   3
               Left            =   90
               TabIndex        =   17
               Top             =   330
               Width           =   345
            End
         End
      End
      Begin Threed.SSFrame SSFrame2 
         Height          =   720
         Left            =   1725
         TabIndex        =   11
         Top             =   15
         Width           =   4020
         _Version        =   65536
         _ExtentX        =   7091
         _ExtentY        =   1270
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
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "Descripción Moneda"
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
            Index           =   1
            Left            =   90
            TabIndex        =   12
            Top             =   135
            Width           =   1755
         End
      End
      Begin Threed.SSFrame SSFrame3 
         Height          =   2640
         Left            =   1725
         TabIndex        =   13
         Top             =   675
         Width           =   4020
         _Version        =   65536
         _ExtentX        =   7091
         _ExtentY        =   4657
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
   Begin VB.Data Data1 
      Caption         =   "Data1"
      Connect         =   "Access"
      DatabaseName    =   ""
      DefaultCursorType=   0  'DefaultCursor
      DefaultType     =   2  'UseODBC
      Exclusive       =   0   'False
      Height          =   345
      Left            =   450
      Options         =   0
      ReadOnly        =   0   'False
      RecordsetType   =   1  'Dynaset
      RecordSource    =   ""
      Top             =   5490
      Width           =   2895
   End
End
Attribute VB_Name = "BacMntVm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

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
Dim sql         As String
Dim Datos()

Function GrabarValoresMoneda() As Boolean
   Dim Fila%
   Dim tmpLogic As Boolean
   On Error GoTo ErrGrabaValores
   
   GrabarValoresMoneda = False
   
        With grilla
         
            For Fila% = 1 To .Rows - 1
                If Trim$(.TextMatrix(Fila%, 0)) <> "" Then
               
                    Envia = Array()
                    AddParam Envia, CDbl(txtCodigo.Text)
                    AddParam Envia, Format(.TextMatrix(Fila%, 0), "yyyymmdd")
                    AddParam Envia, CDbl(.TextMatrix(Fila%, 1))
               
                    If Not Bac_Sql_Execute("SP_GRABA_VALORESMONEDA ", Envia) Then
                       MsgBox "No Se Pudo Grabar Valor Moneda Día " & Format(.TextMatrix(Fila%, 0), "dd/mm/yyyy")
                    End If
                
                    If Bac_SQL_Fetch(Datos()) Then
                        If Datos(1) = "NO" Then
                            MsgBox "No Se Pudo Grabar Valor Moneda Día " & Format(.TextMatrix(Fila%, 0), "dd/mm/yyyy")
                        End If
                    End If

                    If CDbl(.TextMatrix(Fila%, 1)) <> 0 Then
                        Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                                            , gsbac_fecp _
                                            , gsBac_IP _
                                            , gsBAC_User _
                                            , "PCA" _
                                            , "OPC_33 " _
                                            , "01" _
                                            , "Graba" _
                                            , " VALOR_MONEDA " _
                                            , " " _
                                            , .TextMatrix(Fila%, 1))
                    End If
                End If
            Next Fila%
        End With
    

    GrabarValoresMoneda = True
    
Exit Function

ErrGrabaValores:

   MsgBox "Error : " & Err.descripton, vbOKOnly + vbCritical, TITSISTEMA

End Function

Public Function LeerMoneda(CodMon As Integer) As Boolean
    
    LeerMoneda = False
    Envia = Array()
    AddParam Envia, CodMon
    
    If Not Bac_Sql_Execute("SP_MNLEER ", Envia) Then Exit Function
   
    If Bac_SQL_Fetch(Datos()) Then
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

Public Function LeerValores(Codigo As Integer, Mes As Integer, Ano As Integer, Periodo As Single, Pais As Integer) As Boolean

Dim Existe As Boolean
Dim Fila As Integer
Dim Numero As Long
On Error GoTo ErrMDB

Numero = 0
   ' db.Execute "Delete * From MDVM;"
   ' Data1.Refresh
    
    LeerValores = False: Existe = False
    
    Envia = Array()
    AddParam Envia, CDbl(codigo)
    AddParam Envia, CDbl(Mes)
    AddParam Envia, CDbl(Ano)
    AddParam Envia, CDbl(Periodo)
    AddParam Envia, CDbl(Pais)
   
   
   If Not Bac_Sql_Execute("SP_TRAE_VALORESMONEDA_DIAS_HABILES ", Envia) Then
       Exit Function
   End If
    
    
 With grilla
 
   .Redraw = False
   .Rows = 2
    Call F_BacLimpiaGrilla(grilla)
    
    Do While Bac_SQL_Fetch(Datos())
         
           Existe = True
         .TextMatrix(.Rows - 1, 0) = Datos(2) 'fecha
         .TextMatrix(.Rows - 1, 1) = BacCtrlDesTransMonto(Datos(3)) ' VALOR
         .TextMatrix(.Rows - 1, 2) = BacCtrlDesTransMonto(Datos(4)) ' SI ES DIA HABIL
         
         
         ' Data1.Recordset.AddNew
         ' Data1.Recordset("VmCodigo") = CDBL(Datos(1))
         ' Data1.Recordset("VmValor") = CDbl(Datos(3))
         ' Data1.Recordset("VmFecha") = Datos(2)
         ' Data1.Recordset.Update
        
          .Rows = .Rows + 1
         
    Loop
        
         Data1.Refresh
         
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
     MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical, TITSISTEMA
     Exit Function

End Function

Private Function DiasDelMes(Mes As Integer, Ann As Integer) As Integer

Dim Dias    As String
Dim Residuo As Currency

    Dias = "312831303130313130313031"
    
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
          DiasDelMes = CDbl(Mid$(Dias, ((Mes * 2) - 1), 2))
       End If
     End If
     
End Function

Private Sub cmbMes_Click()

    If cmbMes.ListIndex <> -1 Then
       Call Valores2Grilla
    End If

End Sub

Private Sub cmdGrabar_Click()

On Error GoTo Label1

    Screen.MousePointer = 11
     
    If GrabarValoresMoneda Then
       MsgBox "La grabación se realizó con éxito", vbOKOnly + vbInformation, TITSISTEMA
       
    Else
       MsgBox "No se completo la grabación", vbOKOnly + vbExclamation, TITSISTEMA
    End If
    
    Screen.MousePointer = 0
    Exit Sub

Label1:
       Screen.MousePointer = 0
       MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical, TITSISTEMA
       Exit Sub
End Sub

Private Sub cmdlimpiar_Click()
   
   txtNumerico.Visible = False
   txtNumerico.Text = ""
   txtCodigo.Text = ""
   txtDesMon.Text = ""
   itbano.Caption = Trim(Year(gsbac_fecp))
   cmbMes.ListIndex = Month(gsbac_fecp) - 1
   txtCodigo.Enabled = True
   txtCodigo.SetFocus
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
        HSclano.SetFocus
    End If
    
End Sub

Private Sub Form_Activate()

    Call CargarParam_Vm(grilla)
    'Call BacAgrandaGrilla(Grilla, 40)
    grilla.Enabled = True
    grilla.Row = grilla.FixedRows
    grilla.Col = 0
    
End Sub

Private Sub Form_Load()
    Me.Top = 0
    Me.Left = 0
    Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                          , gsbac_fecp _
                          , gsBac_IP _
                          , gsBAC_User _
                          , "PCA" _
                          , "OPC_33" _
                          , "07" _
                          , "INGRESO A OPCION MENU" _
                          , " " _
                          , " " _
                          , " ")
On Error GoTo Label1

    Call BacLLenaComboMes(cmbMes)
    
    Toolbar1.Buttons(1).Enabled = False
    itbano.Caption = Trim(Year(gsbac_fecp))
    HSclano.Value = Trim(Year(gsbac_fecp)) 'aqui se cae

    
    If gsBac_Tcamara = 1 Then
        txtCodigo.Text = 7
        txtCodigo.Enabled = False
        cmbMes.ListIndex = Month(gsbac_fecp) - 1
        Call TxtCodigo_LostFocus
    End If
        
     If cmbMes.ListIndex = -1 Then
          cmbMes.ListIndex = Month(gsbac_fecp) - 1
     End If
    
     grilla.Row = grilla.FixedRows
     grilla.Col = 0
   
    'Data1.DatabaseName = gsMDB_Path + gsMDB_Database
    'Data1.RecordSource = "MDVM"
    'Data1.Refresh
    
    
    Call Grabar_Log("BTR", gsBAC_User, gsbac_fecp, "Ingreso pantalla de valores de monedas")
    Exit Sub

Label1:
      MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical, TITSISTEMA
      Unload Me
      Exit Sub
End Sub

Private Sub Form_Unload(Cancel As Integer)
' db.Execute "Delete * from MDVM"
End Sub

Private Sub grilla_DblClick()
 
 Call grilla_KeyPress(13)

End Sub

Private Sub Grilla_GotFocus()
   With grilla
      
      
      '   .Row = linea
      
   End With
End Sub


Private Sub grilla_KeyPress(KeyAscii As Integer)
On Error GoTo ErrGrabaValores

With grilla


   Dim Habil As String
   Habil = CStr(grilla.TextMatrix(grilla.RowSel, 2))


   If (.Col = 1 And Trim$(.TextMatrix(.Row, 0)) <> "") And (KeyAscii = 13 Or KeyAscii = 8 Or IsNumeric(Chr(KeyAscii))) Then
   
   
      If txtCodigo.Text = "700" And Habil = "N" Then
         MsgBox "Para Esta Moneda no podra Modificar Dias no Habiles", vbOKOnly + vbExclamation, TITSISTEMA
         Me.SetFocus
         Exit Sub
      End If
   
   
   
      .Enabled = False
      TXTNumerico.Visible = True
      linea = .Row
      PROC_POSICIONA_TEXTOX grilla, txtNumerico
      
     ' If IsNumeric(Chr(KeyAscii)) Then
         
     '    txtNumerico.Text = Chr(KeyAscii) ' + .TextMatrix(.Row, 1)
      
     ' Else
        txtNumerico.Text = 0
        txtNumerico.Text = Chr(KeyAscii) '.TextMatrix(.Row, 1) 'BacCtrlTransMonto(.TextMatrix(.Row, 1)) 'AQUI
        txtNumerico.SetFocus
        txtNumerico.SelStart = 1
'        SendKeys ("RIGHT")
'
'        If Chr(KeyAscii) = "." Or Chr(KeyAscii) = "-" Then
'           SendKeys ("RIGHT")
'
'        End If
'
     ' End If
      
     'SendKeys "{end}"    'Comienzo Izquierda
   End If
 End With

Exit Sub

ErrGrabaValores:
  
 ' MsgBox "Error : " & Err.descripton, vbOKOnly + vbCritical
   grilla.Enabled = True
   txtNumerico.Visible = False
  Exit Sub
  
End Sub

Private Sub HSclano_Change()

    itbano.Caption = CDbl(HSclano.Value)
    Call Valores2Grilla
    itbano.Tag = "AÑO"
  
End Sub

Private Sub HSclano_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = 13 And grilla.Text <> "" Then
        grilla.Row = 1
        grilla.Col = 0
        grilla.SetFocus
    End If
End Sub

Private Sub itbAno_Change()

    Call Valores2Grilla
    itbano.Tag = "AÑO"
  
End Sub

Private Sub itbAno_LostFocus()
  
  If itbano.Tag = "" Then
     Call Valores2Grilla
  End If
  
    itbano.Tag = ""
  
End Sub

Private Sub Valores2Grilla()
On Error GoTo Label1

Dim Dias      As Integer
Dim Mes       As Integer
Dim Ann       As Integer
Dim iPeriodo  As Integer
Dim iRedondeo As Integer
Dim lsMask    As String
Dim f         As Integer
Dim Max       As Integer
Dim Pais      As Integer
    
    
If txtCodigo <> "" Then
    
    MousePointer = 11
         
         If CDbl(txtCodigo.Text) = 0 Then
            MousePointer = 0
            Exit Sub
         End If
    
'    If cmbMes.Enabled = True Then
       
       If cmbMes.ListIndex = -1 Then
          MsgBox "Debe seleccionar mes", vbOKOnly + vbExclamation, TITSISTEMA
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
    
    Ann = CDbl(itbano.Caption)
    
    Dias = DiasDelMes(Mes, Ann)
    If Dias = 0 Then
        Dias = 12
    End If

    
    If txtCodigo.Text = "700" Then
       Pais = 220
    Else
       Pais = 6
    End If
    


    
    If LeerValores(CDbl(txtCodigo.Text), Format(Mes, "00"), Ann, xmnperiodo, Pais) Then
        iPeriodo = xmnperiodo
        iRedondeo = xmnredondeo
           ' lsMask$ = "#,###,##0" + IIf(iRedondeo = 0, "", "." + String$(iRedondeo, "0"))
           ' grdVMon.EditMask(2) = lsMask$
           ' grdVMon.ColumnSize(2) = Len(lsMask$)
       
         Toolbar1.Buttons(1).Enabled = True
    Else
       MsgBox "Problemas en Valores de Moneda", vbOKOnly + vbExclamation, TITSISTEMA
    End If
    

    MousePointer = 0

End If

Exit Sub

Label1:
    MousePointer = 0
    MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical, TITSISTEMA
    Exit Sub
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

Select Case Button.Index
    Case 1
            On Error GoTo Label11

    Screen.MousePointer = 11
     
    If GrabarValoresMoneda Then

       MsgBox "La grabación se realizó con éxito", vbOKOnly + vbInformation, TITSISTEMA
'      Call Grabar_Log_AUDITORIA(giBAC_Entidad _
'                                    , gsbac_fecp _
'                                    , gsBAC_Term _
'                                    , gsBAC_User _
'                                    , "PCA" _
'                                    , "OPC_33 " _
'                                    , "01" _
'                                    , "Graba" _
'                                    , " VALOR_MONEDA " _
'                                    , " " _
'                                    , " ")
    Else
       MsgBox "No se completo la grabación", vbOKOnly + vbExclamation, TITSISTEMA
       
     
    End If
    
    Screen.MousePointer = 0
   

    Call Limpiar
    
    Exit Sub

Label11:
       Screen.MousePointer = 0
       MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical, TITSISTEMA
       Exit Sub
    Case 2
    
       Call Limpiar
    
    Case 3
    Call Grabar_Log_AUDITORIA(giBAC_Entidad _
                          , gsbac_fecp _
                          , gsBac_IP _
                          , gsBAC_User _
                          , "PCA" _
                          , "OPC_33" _
                          , "08" _
                          , "SALIR DE OPCION MENU " _
                          , " " _
                          , " " _
                          , " ")
        Unload Me
End Select
End Sub

Private Sub Txtcodigo_Change()

    txtDesMon.Text = ""
    'cmbMes.ListIndex = -1

End Sub

Sub CodigoMon()
On Error GoTo Label1
    txtCodigo.Text = 0
    BacAyuda.Tag = "MDMN"
    BacAyuda.Show 1
    If giAceptar% = True Then
       txtCodigo.Text = gsCodigo$
       txtCodigo.SetFocus
       SendKeys "{ENTER}"
    End If
    Exit Sub

Label1:
    MousePointer = 0
    MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical, TITSISTEMA
    Exit Sub
End Sub

Private Sub txtCodigo_DblClick()
    auxilio = 100
   Call CodigoMon
End Sub


Private Sub txtCodigo_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyF3 Then Call CodigoMon
End Sub

Private Sub txtCodigo_KeyPress(KeyAscii As Integer)

    BacCaracterNumerico KeyAscii
    
    If KeyAscii = 13 Then
       SendKeys "{TAB}"
    End If
    
End Sub

Private Sub TxtCodigo_LostFocus()

If Val(txtCodigo.Text) = 0 Then Exit Sub

On Error GoTo Label1

    If Trim$(txtCodigo.Text) <> "" Then
     '   cmbMes.ListIndex = -1
        cmbMes.Enabled = True
        itbano.Enabled = True
        If LeerMoneda(txtCodigo.Text) = True Then
            If xmncodmon <> 0 Then
                'Encontró la moneda
                '-------------------------------------
                txtDesMon.Text = xmndescrip
                txtCodigo.Enabled = False
               ' Select Case xmnperiodo
               '     Case 1
               '         cmbMes.Enabled = True
               '     Case 30
               '         cmbMes.Enabled = False
               ' End Select
            Else
                'Moneda no existe en tabla de monedas
                '-------------------------------------
                txtCodigo.Text = ""
                txtDesMon.Text = ""
                '' itbano.Caption = Year(gsBac_Fecp)
                itbano.Caption = Trim(Year(gsbac_fecp))
                cmbMes.ListIndex = Month(gsbac_fecp) - 1
                ''LimpiaData
                MsgBox "Moneda no existe", vbCritical, TITSISTEMA
                txtCodigo.SetFocus
            End If
            
        Else
            txtCodigo.Text = ""
        End If
        
        If cmbMes.Enabled = True Then
            If cmbMes.ListIndex = -1 Then
                cmbMes.ListIndex = Month(gsbac_fecp) - 1
                Exit Sub
            End If
        End If
        Call Valores2Grilla
    End If

    Exit Sub

Label1:
    MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical, TITSISTEMA
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
         .ColWidth(2) = 0
         
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

Private Sub txtNumerico_KeyPress(KeyAscii As Integer)

 Dim FechaGrilla As Date
 FechaGrilla = CDate(grilla.TextMatrix(grilla.RowSel, 0))


 Select Case KeyAscii
      Case vbKeyReturn
      
            grilla.Text = IIf(txtCodigo.Text = "700" And FechaGrilla <= gsbac_fecp, IIf(TXTNumerico.Text = 0, grilla.Text, TXTNumerico.Text), TXTNumerico.Text)
            'grilla.Text = TXTNumerico.Text
            grilla.Text = BacFormatoMonto(grilla.Text, 4)
            txtNumerico.Text = 0
            txtNumerico.Visible = False
            
      Case vbKeyEscape
            txtNumerico.Text = 0
            txtNumerico.Visible = False
 End Select
 
If KeyAscii = 13 Then
   grilla.Enabled = True
   grilla.SetFocus
End If
End Sub

Private Sub txtNumerico_LostFocus()

   txtNumerico.Text = ""
   txtNumerico.Visible = False
   grilla.Enabled = True
   
End Sub

Sub Limpiar()

                txtNumerico.Visible = False
                txtNumerico.Text = ""
                txtCodigo.Text = ""
                txtDesMon.Text = ""
                itbano.Caption = Trim(Year(gsbac_fecp))
                cmbMes.ListIndex = Month(gsbac_fecp) - 1
                txtCodigo.Enabled = True
                txtCodigo.SetFocus
                grilla.Rows = 2
                Call F_BacLimpiaGrilla(grilla)
                'Call BacAgrandaGrilla(Grilla, 40)
                grilla.Enabled = False
  

End Sub
