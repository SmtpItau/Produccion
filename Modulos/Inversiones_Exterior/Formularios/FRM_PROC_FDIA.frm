VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Begin VB.Form FRM_PROC_FDIA 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Fin de Día"
   ClientHeight    =   6990
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   7245
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   6990
   ScaleWidth      =   7245
   Begin MSFlexGridLib.MSFlexGrid GridFli 
      Height          =   1815
      Left            =   7515
      TabIndex        =   19
      Top             =   6570
      Width           =   4200
      _ExtentX        =   7408
      _ExtentY        =   3201
      _Version        =   393216
   End
   Begin MSFlexGridLib.MSFlexGrid GridBo 
      Height          =   2805
      Left            =   7485
      TabIndex        =   18
      Top             =   3720
      Width           =   4215
      _ExtentX        =   7435
      _ExtentY        =   4948
      _Version        =   393216
      Cols            =   7
      FixedCols       =   0
   End
   Begin MSFlexGridLib.MSFlexGrid GridOp 
      Height          =   3120
      Left            =   7455
      TabIndex        =   17
      Top             =   495
      Width           =   4275
      _ExtentX        =   7541
      _ExtentY        =   5503
      _Version        =   393216
      Cols            =   19
      FixedCols       =   0
      AllowUserResizing=   1
   End
   Begin VB.PictureBox ConCheck 
      BorderStyle     =   0  'None
      Height          =   360
      Index           =   0
      Left            =   825
      Picture         =   "FRM_PROC_FDIA.frx":0000
      ScaleHeight     =   360
      ScaleWidth      =   405
      TabIndex        =   11
      Top             =   8040
      Visible         =   0   'False
      Width           =   405
   End
   Begin VB.PictureBox SinCheck 
      BorderStyle     =   0  'None
      Height          =   345
      Index           =   0
      Left            =   0
      Picture         =   "FRM_PROC_FDIA.frx":015A
      ScaleHeight     =   345
      ScaleWidth      =   375
      TabIndex        =   10
      Top             =   8040
      Visible         =   0   'False
      Width           =   375
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   7245
      _ExtentX        =   12779
      _ExtentY        =   794
      ButtonWidth     =   2064
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      Style           =   1
      TextAlignment   =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Procesar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Cerrar"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComDlg.CommonDialog Command 
         Left            =   5340
         Top             =   60
         _ExtentX        =   847
         _ExtentY        =   847
         _Version        =   393216
      End
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   5940
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
               Picture         =   "FRM_PROC_FDIA.frx":02B4
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PROC_FDIA.frx":118E
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PROC_FDIA.frx":12E8
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame Frame2 
      Height          =   1800
      Left            =   45
      TabIndex        =   1
      Top             =   375
      Width           =   7125
      Begin VB.CommandButton CMDchangeDirectory 
         Caption         =   "..."
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   12
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   630
         Left            =   6630
         TabIndex        =   6
         Top             =   1065
         Width           =   435
      End
      Begin BACControles.TXTFecha TXTFechaGeneracion 
         Height          =   315
         Left            =   105
         TabIndex        =   3
         Top             =   435
         Width           =   1830
         _ExtentX        =   3228
         _ExtentY        =   556
         BackColor       =   12648447
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "01/07/2011"
      End
      Begin VB.Label LBLRutaAcceso 
         BackColor       =   &H00C0FFFF&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   615
         Left            =   105
         TabIndex        =   5
         Top             =   1080
         Width           =   6525
      End
      Begin VB.Label LBLEtiquetaSup 
         AutoSize        =   -1  'True
         Caption         =   "Directorio de Generación"
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
         Left            =   135
         TabIndex        =   4
         Top             =   855
         Width           =   2100
      End
      Begin VB.Label LBLEtiquetaSup 
         AutoSize        =   -1  'True
         Caption         =   "Fecha de Generación"
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
         Left            =   135
         TabIndex        =   2
         Top             =   225
         Width           =   1755
      End
   End
   Begin MSComctlLib.ProgressBar Prg 
      Height          =   345
      Left            =   0
      TabIndex        =   13
      Top             =   0
      Visible         =   0   'False
      Width           =   3600
      _ExtentX        =   6350
      _ExtentY        =   609
      _Version        =   393216
      Appearance      =   1
   End
   Begin MSComctlLib.ProgressBar ProgressBar1 
      Height          =   345
      Left            =   0
      TabIndex        =   14
      Top             =   0
      Visible         =   0   'False
      Width           =   3600
      _ExtentX        =   6350
      _ExtentY        =   609
      _Version        =   393216
      Appearance      =   1
   End
   Begin VB.Frame MarcoInterfaz 
      Height          =   3795
      Left            =   45
      TabIndex        =   8
      Top             =   2115
      Width           =   7125
      Begin MSFlexGridLib.MSFlexGrid Grid 
         Height          =   3555
         Left            =   30
         TabIndex        =   9
         Top             =   150
         Width           =   7005
         _ExtentX        =   12356
         _ExtentY        =   6271
         _Version        =   393216
         Cols            =   3
         FixedCols       =   0
         BackColor       =   -2147483633
         BackColorFixed  =   -2147483646
         ForeColorFixed  =   -2147483639
         BackColorSel    =   -2147483633
         BackColorBkg    =   -2147483633
         GridColor       =   -2147483633
         GridColorFixed  =   -2147483633
         FocusRect       =   0
         GridLines       =   0
         GridLinesFixed  =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
   End
   Begin VB.Frame Frame3 
      Height          =   1095
      Left            =   45
      TabIndex        =   7
      Top             =   5835
      Width           =   7125
      Begin Threed.SSPanel Pnl_Progreso 
         Height          =   285
         Left            =   60
         TabIndex        =   12
         Top             =   720
         Visible         =   0   'False
         Width           =   6960
         _Version        =   65536
         _ExtentX        =   12277
         _ExtentY        =   503
         _StockProps     =   15
         ForeColor       =   -2147483640
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BevelOuter      =   1
         FloodType       =   1
         FloodColor      =   -2147483646
      End
      Begin Threed.SSPanel Pnl_ProgresoTot 
         Height          =   300
         Left            =   60
         TabIndex        =   16
         Top             =   390
         Visible         =   0   'False
         Width           =   6960
         _Version        =   65536
         _ExtentX        =   12277
         _ExtentY        =   529
         _StockProps     =   15
         ForeColor       =   -2147483640
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BevelOuter      =   1
         FloodType       =   1
         FloodColor      =   -2147483646
      End
      Begin VB.Label LBLEtiquetaAvance 
         AutoSize        =   -1  'True
         Caption         =   "Procesadas"
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
         Left            =   90
         TabIndex        =   15
         Top             =   180
         Width           =   975
      End
   End
End
Attribute VB_Name = "FRM_PROC_FDIA"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Const nCol0 = 0
Const nCol1 = 1
Const nCol2 = 2
Const nCol3 = 3
Const nCol4 = 4
Const nCol5 = 5

'Constante que identifica al sistema BEX
Const iSistema = "BEX"
Dim bHabilitaCtrl       As Boolean
Dim cNomArchivo         As String
Dim cDia                As String
Public NombreArchivo    As String

'Option Explicit

Private Sub CMDchangeDirectory_Click()
   Call Command.ShowSave
   Let LBLRutaAcceso.Caption = Replace(Command.FileName, Command.FileTitle, "")
End Sub

Private Function Setea_Grilla()
    Let Grid.Rows = 2:              Let Grid.Cols = 6
    Let Grid.FixedRows = 1:         Let Grid.FixedCols = 0

    Let Grid.RowHeight(0) = 500
    
    Let Grid.TextMatrix(0, 0) = "Estado":       Grid.ColWidth(0) = 750:      Grid.ColAlignment(0) = flexAlignLeftCenter
    Let Grid.TextMatrix(0, 1) = "Sigla":        Grid.ColWidth(1) = 1000:     Grid.ColAlignment(1) = flexAlignLeftCenter
    Let Grid.TextMatrix(0, 2) = "Nombre":       Grid.ColWidth(2) = 5000:     Grid.ColAlignment(2) = flexAlignLeftCenter
    Let Grid.TextMatrix(0, 3) = "Path":         Grid.ColWidth(3) = 0:        Grid.ColAlignment(2) = flexAlignLeftCenter
    Let Grid.TextMatrix(0, 4) = "FileName":     Grid.ColWidth(4) = 0:        Grid.ColAlignment(2) = flexAlignLeftCenter
    Let Grid.TextMatrix(0, 5) = "Consistencia": Grid.ColWidth(5) = 0:        Grid.ColAlignment(5) = flexAlignLeftCenter
    
    Let MarcoInterfaz.Enabled = False
End Function

Private Function Carga_Grilla()
    Dim i           As Integer
    Dim nCol        As Integer
    Dim sigla       As String
    Dim Sqldatos()
    
    Dim cPartName   As String
    Let cPartName = Format(TXTFechaGeneracion.Text, "yymmdd") & ".Dat"
    
    envia = Array()
    AddParam envia, iSistema
    If Not Bac_Sql_Execute("BacParamSuda.dbo.SP_LEER_INTERFACES_MODULO", envia) Then
        Exit Function
    End If
   
    Let Grid.Rows = 1
   
    Do While Bac_SQL_Fetch(Sqldatos())
        Let Grid.Rows = Grid.Rows + 1
        Let Grid.Col = 0:   Let Grid.row = Grid.Rows - 1
        Grid.CellPictureAlignment = flexAlignCenterCenter

        Set Grid.CellPicture = SinCheck.Item(0).Picture
        
        Let Grid.TextMatrix(Grid.row, nCol0) = ""
        Let Grid.TextMatrix(Grid.row, nCol1) = Sqldatos(1)
        Let Grid.TextMatrix(Grid.row, nCol2) = Sqldatos(2)
        Let Grid.TextMatrix(Grid.row, nCol3) = TraePathDeArchivo(Sqldatos(1))
        Let Grid.TextMatrix(Grid.row, nCol4) = Sqldatos(1) & cPartName
        Let Grid.TextMatrix(Grid.row, nCol5) = Sqldatos(4)
        
        Let bHabilitaCtrl = IIf(Sqldatos(5) = 1, True, False)
    Loop

    Let LBLEtiquetaAvance.Caption = "Interfaces Generadas : 0 de " & (Grid.Rows - 1) & "."

End Function

Private Function TraePathDeArchivo(ByVal cSigla As String) As String
    Let TraePathDeArchivo = UCase(Func_Read_INI("INTERFAZ_IBS", "PATH_BEX_IBS", App.Path & "\" & "Bac-Sistemas.ini"))
End Function

Private Function FuncResetCheck()
    Dim iContador   As Long
     For iContador = 1 To Grid.Rows - 1
        Let Grid.Col = 0:   Let Grid.row = iContador
        Set Grid.CellPicture = SinCheck.Item(0).Picture
    Next iContador
    Let Pnl_Progreso.FloodPercent = 0
    Let Pnl_ProgresoTot.FloodPercent = 0
    Let LBLEtiquetaAvance.Caption = "Interfaces Generadas : 0 de " & (Grid.Rows - 1) & "."
    Let Pnl_ProgresoTot.FloodColor = vbBlue:   Let Pnl_ProgresoTot.ForeColor = vbBlack
    Let Pnl_Progreso.FloodColor = vbBlue:      Let Pnl_Progreso.ForeColor = vbBlack
End Function

Private Sub Form_Load()
    'Let Me.Icon = Inv_Ext.Icon
    Let Me.Caption = "Generacion de Fin de Día"
    Let Me.Icon = BAC_INVERSIONES.Icon
    Let Me.Caption = "Generación de Fin de Día"
    Let LBLRutaAcceso.Caption = gsBac_DIRIBS
    Let TXTFechaGeneracion.Text = Format(gsBac_Fecp, "dd-mm-yyyy")
    Call Setea_Grilla
    Call Carga_Grilla
    'Llama Grilla - ini
'    Call seteaGrid1
'    Call cargaGrid1
'    Call seteaGrid2
'    Call cargaGrid2
    'Llama Grilla - ini
    
End Sub

Private Function FuncGeneracionInterfaz() As Boolean
    Dim iContador       As Long
    Dim cNombre         As String
    Dim cDirectorio     As String
    Dim nConsistencia   As Integer
    Dim bInterfazDatos  As Boolean
    Dim nInterfazOP     As Integer
    Dim nInterfazBO     As Integer
    Dim nInterfazFL     As Integer
    Dim MensajeError    As String
    Dim MensajeFinDia   As String
    Dim Msj             As String
    Dim cAsunto         As String
    
    If MsgBox("¿ Decea procesar el fin de día. ?", vbQuestion + vbYesNo, App.Title) = vbNo Then
       Let Screen.MousePointer = vbDefault
       Exit Function
    End If
    Call FuncEraseErrores(iSistema)
     
    Let Pnl_Progreso.Visible = True:     Let Pnl_ProgresoTot.Visible = True
    Let Pnl_Progreso.FloodPercent = 0:   Let Pnl_ProgresoTot.FloodPercent = 0
    
    Let Pnl_ProgresoTot.FloodColor = vbBlue:    Let Pnl_ProgresoTot.ForeColor = vbBlack
    Let Pnl_Progreso.FloodColor = vbBlue:       Let Pnl_Progreso.ForeColor = vbBlack
    Let MensajeError = ""
    Let MensajeFinDia = ""
    Let cAsunto = ""
    Let GridOp.Rows = 1
    Let GridBo.Rows = 1
    Let GridFli.Rows = 1
    Let nInterfazOP = -1
    Let nInterfazBO = -1
    Let nInterfazFL = -1
        
    Call BacControlWindows(5)

    For iContador = 1 To Grid.Rows - 1
        Let Grid.Col = 0
        Let Grid.row = iContador
        
        Let cNombre = Grid.TextMatrix(iContador, 4)
        Let cDirectorio = Grid.TextMatrix(iContador, 3)
        
        If Grid.TextMatrix(iContador, 1) = "OP51" Then
            Set Grid.CellPicture = ConCheck.Item(0).Picture
            Let nConsistencia = CInt(Grid.TextMatrix(iContador, 5))
            If Modulo_Interfaces.InterfazOperacionesBEX(cDirectorio, cNombre, Pnl_Progreso, bInterfazDatos) = True Then
                If bHabilitaCtrl = True Then
                    If bInterfazDatos = True Then
                        nInterfazOP = 0
                        Call BacParcelaInterfaz.FuncParcelaInterfaz(cDirectorio & cNombre, GridOp, "OP51", iSistema)
                    Else
                        Call BacParcelaInterfaz.FuncInsertMsgError(iSistema, cNombre, 0, 0, 0, "INTERFAZ SIN DATOS", True)
                    End If
                End If
            Else
                GoTo ErrorGeneracionProcesoCierre
            End If
            Call BacControlWindows(1)
        End If
         
        If Grid.TextMatrix(iContador, 1) = "BO51" Then
            Set Grid.CellPicture = ConCheck.Item(0).Picture
            If Modulo_Interfaces.InterfazBalanceBEX(cDirectorio, cNombre, Pnl_Progreso, bInterfazDatos) = True Then
                If bHabilitaCtrl = True Then
                    If bInterfazDatos = True Then
                        nInterfazBO = 0
                        Call BacParcelaInterfaz.FuncParcelaInterfaz(cDirectorio & cNombre, GridBo, "BO51", iSistema)
                    Else
                        Call BacParcelaInterfaz.FuncInsertMsgError(iSistema, cNombre, 0, 0, 0, "INTERFAZ SIN DATOS", True)
                    End If
                End If
            Else
                GoTo ErrorGeneracionProcesoCierre
            End If
            Call BacControlWindows(1)
        End If
        
        If Grid.TextMatrix(iContador, 1) = "FL51" Then
            Set Grid.CellPicture = ConCheck.Item(0).Picture
            If Modulo_Interfaces.InterfazFlujosBEX(cDirectorio, cNombre, Pnl_Progreso, bInterfazDatos) = True Then
                If bHabilitaCtrl = True Then
                    If bInterfazDatos = True Then
                        nInterfazFL = 0
                        Call BacParcelaInterfaz.FuncParcelaInterfaz(cDirectorio & cNombre, GridFli, "FL51", iSistema)
                    Else
                        Call BacParcelaInterfaz.FuncInsertMsgError(iSistema, cNombre, 0, 0, 0, "INTERFAZ SIN DATOS", True)
                    End If
                End If
            Else
                GoTo ErrorGeneracionProcesoCierre
            End If
            Call BacControlWindows(1)
        End If

        If Grid.TextMatrix(iContador, 1) = "DD51" Then
            If Modulo_Interfaces.InterfazDireccionesBEX(cDirectorio, cNombre, Pnl_Progreso) = False Then
                GoTo ErrorGeneracionProcesoCierre
            End If
            Set Grid.CellPicture = ConCheck.Item(0).Picture
            Call BacControlWindows(1)
        End If

        If Grid.TextMatrix(iContador, 1) = "PC51" Then
            If Modulo_Interfaces.InterfazPosicionBEX(cDirectorio, cNombre, Pnl_Progreso) = False Then
                GoTo ErrorGeneracionProcesoCierre
            End If
            Set Grid.CellPicture = ConCheck.Item(0).Picture
            Call BacControlWindows(1)
        End If

        If Grid.TextMatrix(iContador, 1) = "CO51" Then
            If Modulo_Interfaces.InterfazDeudoresBEX(cDirectorio, cNombre, Pnl_Progreso) = False Then
                GoTo ErrorGeneracionProcesoCierre
            End If
            Set Grid.CellPicture = ConCheck.Item(0).Picture
            Call BacControlWindows(1)
        End If

        If Grid.TextMatrix(iContador, 1) = "P40" Then
            If Modulo_Interfaces.InterfazP40BEX(cDirectorio, cNombre, Pnl_Progreso) = False Then
                GoTo ErrorGeneracionProcesoCierre
            End If
            Set Grid.CellPicture = ConCheck.Item(0).Picture
            Call BacControlWindows(1)
        End If

        If Grid.TextMatrix(iContador, 1) = "CHEQ" Then
            Set Grid.CellPicture = ConCheck.Item(0).Picture
            If bHabilitaCtrl = True Then
            If nConsistencia = 1 Then
                If nInterfazOP = 0 Then
                    Call BacParcelaInterfaz.FuncValidaInterfaz(Grid, GridOp, GridBo, GridFli, iSistema, Pnl_Progreso)
                End If
            End If
                Set Grid.CellPicture = ConCheck.Item(0).Picture
            Call BacControlWindows(1)

            If BacParcelaInterfaz.FuncLoadErroresProcesos(iSistema, MensajeError, cAsunto) = False Then
               Call BacParcelaInterfaz.FuncSendMail(iSistema, MensajeError, cAsunto)
                   GoTo ErrorGeneracionProcesoCierre
                End If
            End If
            Call BacControlWindows(1)
        End If

        If Grid.TextMatrix(iContador, 1) = "FDIA" Then
            If bHabilitaCtrl = False Then
                nInterfazOP = 0
                nInterfazBO = 0
                nInterfazFL = 0
            End If

            If nInterfazOP = 0 And nInterfazBO = 0 And nInterfazFL = 0 Then
                If bHabilitaCtrl = True Then
                    If FuncLoadErroresProcesos(iSistema, MensajeError, cAsunto) = False Then
                        Call MsgBox("Proceso de cierre ha encontrado errores durante el cierre.", vbExclamation, App.Title)
                        GoTo ErrorGeneracionProcesoCierre
                    Else
                        If FuncGenFinDiaInvExt(Pnl_Progreso, MensajeFinDia) = True Then
                            Set Grid.CellPicture = ConCheck.Item(0).Picture
                            Call MsgBox("Proceso de cierre se ha realizado correctamente.", vbInformation, App.Title)
                        Else
                            Call MsgBox(MensajeFinDia, vbCritical, Msj)
                            GoTo ErrorGeneracionProcesoCierre
                        End If
                    End If
                Else
                    If FuncGenFinDiaInvExt(Pnl_Progreso, MensajeFinDia) = True Then
                        Set Grid.CellPicture = ConCheck.Item(0).Picture
                        Call MsgBox("Proceso de cierre se ha realizado correctamente.", vbInformation, App.Title)
                    Else
                        MsgBox MensajeFinDia, vbCritical, Msj
                        GoTo ErrorGeneracionProcesoCierre
                    End If
                End If
                Call BacControlWindows(1)
            Else
                Call MsgBox(" Se generaron interfaces vacías, favor revisar. ", vbExclamation, App.Title)
            End If
            Call BacControlWindows(1)
        End If
        
        Call BacControlWindows(1)

        Let LBLEtiquetaAvance.Caption = "Interfaces Generadas : " & Str(iContador) & " de " & (Grid.Rows - 1) & "."
        Let Pnl_ProgresoTot.FloodPercent = ((iContador * 100) / Grid.Rows - 1)
        If Pnl_ProgresoTot.FloodPercent >= 49 Then
            Let Pnl_ProgresoTot.FloodColor = vbBlue: Let Pnl_ProgresoTot.ForeColor = vbWhite
        Else
            Let Pnl_ProgresoTot.FloodColor = vbBlue: Let Pnl_ProgresoTot.ForeColor = vbBlack
        End If
        Call BacControlWindows(1)
    
    Next iContador
    
    Let Pnl_ProgresoTot.FloodPercent = 100
    
    Let Pnl_ProgresoTot.FloodColor = vbGreen:   Let Pnl_ProgresoTot.ForeColor = vbBlack
    Let Pnl_Progreso.FloodColor = vbGreen:      Let Pnl_Progreso.ForeColor = vbBlack

    Let Pnl_ProgresoTot.FloodPercent = 100
Exit Function
ErrorGeneracionProcesoCierre:
    Let Pnl_ProgresoTot.FloodColor = vbRed:   Let Pnl_ProgresoTot.ForeColor = vbWhite
    Let Pnl_Progreso.FloodColor = vbRed:      Let Pnl_Progreso.ForeColor = vbWhite
   Call MsgBox("E- ERROR EN GENERACION DE INTERFACES" & vbCrLf & vbCrLf & "Proceso no finalizado...", vbCritical, App.Title)
End Function

Private Function FuncGeneracion()
    Dim Cont As Integer
    Call FuncResetCheck
    Call FuncGeneracionInterfaz
Exit Function
End Function

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 2:   Call FuncGeneracion
      Case 3:   Call Unload(Me)
   End Select
End Sub
'Private Function seteaGridOp()
' Let Grid.Rows = 2:              Let Grid.Cols = 5
'    Let Grid.FixedRows = 1:         Let Grid.FixedCols = 0
'
'    Let GridOp.RowHeight(0) = 500
'
'    Let GridOp.TextMatrix(0, 0) = "XX":   Grid.ColWidth(0) = 3:      Grid.ColAlignment(0) = flexAlignLeftCenter
'    Let GridOp.TextMatrix(0, 1) = "XX":   Grid.ColWidth(1) = 8:     Grid.ColAlignment(1) = flexAlignLeftCenter
'    Let GridOp.TextMatrix(0, 2) = "XX":   Grid.ColWidth(2) = 8:     Grid.ColAlignment(2) = flexAlignLeftCenter
'    Let GridOp.TextMatrix(0, 3) = "XX identificador":     Grid.ColWidth(3) = 14:        Grid.ColAlignment(2) = flexAlignLeftCenter
'    Let GridOp.TextMatrix(0, 4) = "Codigo empresa": Grid.ColWidth(4) = 3:        Grid.ColAlignment(2) = flexAlignLeftCenter
'
'    Let MarcoInterfaz.Enabled = False
'End Function
'Public Function cargaGridOp(cNombre, cDirectorio)
'    Dim Sqldatos(1)
'    Dim i As Integer
'    Dim FILAS As Integer
'    Dim cNomArchivo As String
'    Dim archivo As String
'    Dim col0 As String
'
'    cNomArchivo = cNombre & Format(gsBac_Fecp, "YYMMDD") & ".DAT"
'    archivo = cDirectorio & cNomArchivo
'    FILAS = FreeFile
'    Open archivo For Input As #FILAS
'      Do Until EOF(FILAS)
'        Let GridOp.Rows = GridOp.Rows + 1
'        Let GridOp.row = GridOp.row + 1
'        Let GridOp.Col = 0:
'        Input #FILAS, col0
'        Let GridOp.TextMatrix(GridOp.row, GridOp.Col) = Mid(col0, 1, 15)
'        GridOp.Col = GridOp.Col + 1
'        Let GridOp.TextMatrix(GridOp.row, GridOp.Col) = Mid(col0, 16, 8)
'      Loop
'   Close #1
'End Function




Private Function FuncGenFinDiaInvExt(ByRef Barra As SSPanel, cTexto As String) As Boolean
    Dim Datos()
    Dim nTotal     As Integer
    
    Let nTotal = 0
    
    Let FuncGenFinDiaInvExt = False
    
    Barra.FloodPercent = 0
    Barra.ForeColor = vbBlack
    
    If Not Bac_Sql_Execute("BEGIN TRANSACTION") Then
        Exit Function
    End If
    If Bac_Sql_Execute("SVA_PRC_FIN_DIA") Then
        Do While Bac_SQL_Fetch(Datos)
        
            If Trim(Datos(1)) = "SI" Then
                
            Else
                If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
                    cTexto = "Problemas al Ejecutar Proceso"
                    Exit Function
                End If
            End If

        Loop
    Else
        If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
            cTexto = "Problemas al Ejecutar Proceso"
            Exit Function
        End If
        
    End If
    
    Call guardar_hora_proceso("fd", Time, gsBac_Fecp)
    
    Let FuncGenFinDiaInvExt = True
     
    nTotal = nTotal + 1
        
    Call BacControlWindows(1)
    Let Barra.FloodPercent = ((nTotal * 100) / 1)
    If Barra.FloodPercent >= 49 Then
        Barra.ForeColor = vbWhite
    End If
    
    If Bac_Sql_Execute("COMMIT TRANSACTION") <> 0 Then
        Exit Function
    End If

End Function





