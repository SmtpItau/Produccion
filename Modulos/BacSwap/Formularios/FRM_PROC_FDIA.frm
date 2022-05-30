VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
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
         Width           =   7020
         _ExtentX        =   12383
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
         Left            =   75
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
   Begin MSFlexGridLib.MSFlexGrid GridOp 
      Height          =   2595
      Left            =   7320
      TabIndex        =   17
      Top             =   480
      Width           =   5940
      _ExtentX        =   10478
      _ExtentY        =   4577
      _Version        =   393216
      Cols            =   99
      FixedCols       =   0
      AllowUserResizing=   1
   End
   Begin MSFlexGridLib.MSFlexGrid GridBo 
      Height          =   2610
      Left            =   7320
      TabIndex        =   18
      Top             =   3240
      Width           =   6495
      _ExtentX        =   11456
      _ExtentY        =   4604
      _Version        =   393216
      Cols            =   23
      FixedCols       =   0
      AllowUserResizing=   1
   End
   Begin MSFlexGridLib.MSFlexGrid GridFli 
      Height          =   2280
      Left            =   7320
      TabIndex        =   19
      Top             =   6000
      Width           =   6180
      _ExtentX        =   10901
      _ExtentY        =   4022
      _Version        =   393216
      Cols            =   12
      FixedCols       =   0
      AllowUserResizing=   1
   End
End
Attribute VB_Name = "FRM_PROC_FDIA"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Const nCol0 = 0
Const nCol1 = 1
Const nCol2 = 2
Const nCol3 = 3
Const nCol4 = 4
Const nCol5 = 5

'Constante que identifica al sistema Renta Fija
Const iSistema = "PCS"

Dim cNomArchivo         As String
Dim cDia                As String

Public NombreArchivo    As String

Option Explicit

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
    Let Grid.TextMatrix(0, 3) = "Path":         Grid.ColWidth(3) = 0:        Grid.ColAlignment(3) = flexAlignLeftCenter
    Let Grid.TextMatrix(0, 4) = "FileName":     Grid.ColWidth(4) = 0:        Grid.ColAlignment(4) = flexAlignLeftCenter
    Let Grid.TextMatrix(0, 5) = "Consistencia": Grid.ColWidth(5) = 0:        Grid.ColAlignment(5) = flexAlignLeftCenter
    
    Let MarcoInterfaz.Enabled = False
End Function

Private Function Carga_Grilla()
    Dim i           As Integer
    Dim nCol        As Integer
    Dim sigla       As String
    Dim SqlDatos()
    
    Dim cPartName   As String
    Let cPartName = Format(TXTFechaGeneracion.Text, "yymmdd") & ".Dat"
    
    Envia = Array()
    AddParam Envia, iSistema
    If Not Bac_Sql_Execute("BacParamSuda.dbo.SP_LEER_INTERFACES_MODULO", Envia) Then
        Exit Function
    End If
   
    Let Grid.Rows = 1
   
    Do While Bac_SQL_Fetch(SqlDatos())
        Let Grid.Rows = Grid.Rows + 1
        Let Grid.Col = 0:   Let Grid.Row = Grid.Rows - 1
        Grid.CellPictureAlignment = flexAlignCenterCenter

        Set Grid.CellPicture = SinCheck.Item(0).Picture
        
        Let Grid.TextMatrix(Grid.Row, nCol0) = ""
        Let Grid.TextMatrix(Grid.Row, nCol1) = SqlDatos(1)
        Let Grid.TextMatrix(Grid.Row, nCol2) = SqlDatos(2)
        Let Grid.TextMatrix(Grid.Row, nCol3) = TraePathDeArchivo(SqlDatos(1))
        Let Grid.TextMatrix(Grid.Row, nCol4) = SqlDatos(1) & cPartName
        Let Grid.TextMatrix(Grid.Row, nCol5) = SqlDatos(4)
    Loop

    Let LBLEtiquetaAvance.Caption = "Interfaces Generadas : 0 de " & (Grid.Rows - 1) & "."

End Function

Private Function TraePathDeArchivo(ByVal cSigla As String) As String

    Let TraePathDeArchivo = UCase(ReadINI("INTERFAZ_IBS", "PATH_SWAP_IBS", App.Path & "\" & "Bac-Sistemas.ini"))

'    If cSigla = "C18" Then
'        Let TraePathDeArchivo = UCase(Func_Read_INI("INTERFAZ", "PATH_C18", App.Path & "\" & "Bac-Sistemas.ini"))
'    End If
'    If cSigla = "P40" Then
'        Let TraePathDeArchivo = UCase(Func_Read_INI("INTERFAZ", "PATH_P40", App.Path & "\" & "Bac-Sistemas.ini"))
'    End If

End Function

Private Function FuncResetCheck()
    Dim iContador   As Long
    
    For iContador = 1 To Grid.Rows - 1
        Let Grid.Col = 0:   Let Grid.Row = iContador
        Set Grid.CellPicture = SinCheck.Item(0).Picture
    Next iContador

    Let Pnl_Progreso.FloodPercent = 0
    Let Pnl_ProgresoTot.FloodPercent = 0

    Let LBLEtiquetaAvance.Caption = "Interfaces Generadas : 0 de " & (Grid.Rows - 1) & "."
End Function

Private Sub Form_Load()
    Let Me.Icon = BACSwap.Icon
    Let Me.Caption = "Generacion de Fin de Día"
   
    Let LBLRutaAcceso.Caption = gsBac_DIRIBS
   
    Let TXTFechaGeneracion.Text = Format(gsBAC_Fecp, "dd-mm-yyyy")
   
    Call Setea_Grilla
    
    Call Carga_Grilla
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
    Dim cAsunto         As String
    
    If MsgBox("¿ Decea procesar el fin de día. ?", vbQuestion + vbYesNo, App.Title) = vbNo Then
       Let Screen.MousePointer = vbDefault
       Exit Function
    End If
    
    Call FuncEraseErrores(iSistema)
     
    Let Pnl_Progreso.Visible = True:     Let Pnl_ProgresoTot.Visible = True
    Let Pnl_Progreso.FloodPercent = 0:   Let Pnl_ProgresoTot.FloodPercent = 0
    
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
        Let Grid.Row = iContador
        
        Let cNombre = Grid.TextMatrix(iContador, 4)
        Let cDirectorio = Grid.TextMatrix(iContador, 3)
        
        If Grid.TextMatrix(iContador, 1) = "OP52" Then
            Set Grid.CellPicture = ConCheck.Item(0).Picture
            Let nConsistencia = CInt(Grid.TextMatrix(iContador, 5))
            If Modulo_Interfaces.InterfazOperacionesSWP(cDirectorio, cNombre, Pnl_Progreso, bInterfazDatos) = True Then
                If bInterfazDatos = True Then
                    nInterfazOP = 0
                    'Call BacParcelaInterfaz.FuncParcelaInterfaz(cDirectorio & cNombre, GridOp, "OP52", iSistema)
                Else
                    Call BacParcelaInterfaz.FuncInsertMsgError(iSistema, cNombre, 0, 0, 0, "INTERFAZ SIN DATOS", True)
                End If
            End If
            Call BacControlWindows(1)
        End If
        
        If Grid.TextMatrix(iContador, 1) = "BO52" Then
            Set Grid.CellPicture = ConCheck.Item(0).Picture
            If Modulo_Interfaces.InterfazBalanceSWP(cDirectorio, cNombre, Pnl_Progreso, bInterfazDatos) = True Then
                If bInterfazDatos = True Then
                    nInterfazBO = 0
                    'Call BacParcelaInterfaz.FuncParcelaInterfaz(cDirectorio & cNombre, GridBo, "BO52", iSistema)
                Else
                    Call BacParcelaInterfaz.FuncInsertMsgError(iSistema, cNombre, 0, 0, 0, "INTERFAZ SIN DATOS", True)
                End If
            End If
            Call BacControlWindows(1)
        End If

        If Grid.TextMatrix(iContador, 1) = "DE52" Then
            Set Grid.CellPicture = ConCheck.Item(0).Picture
            If Modulo_Interfaces.InterfazDerivadosSWP(cDirectorio, cNombre, Pnl_Progreso, bInterfazDatos) = True Then
                If bInterfazDatos = True Then
                    nInterfazFL = 0
                    'Call BacParcelaInterfaz.FuncParcelaInterfaz(cDirectorio & cNombre, GridFli, "DE52", iSistema)
                Else
                    Call BacParcelaInterfaz.FuncInsertMsgError(iSistema, cNombre, 0, 0, 0, "INTERFAZ SIN DATOS", True)
                End If
            End If
            Call BacControlWindows(1)
        End If

        If Grid.TextMatrix(iContador, 1) = "DD52" Then
            Set Grid.CellPicture = ConCheck.Item(0).Picture
            If Modulo_Interfaces.InterfazDireccionesSWP(cDirectorio, cNombre, Pnl_Progreso) = True Then Set Grid.CellPicture = ConCheck.Item(0).Picture
            Call BacControlWindows(1)
        End If

        If Grid.TextMatrix(iContador, 1) = "PC52" Then
            Set Grid.CellPicture = ConCheck.Item(0).Picture
            If Modulo_Interfaces.InterfazPosicionSWP(cDirectorio, cNombre, Pnl_Progreso) = True Then Set Grid.CellPicture = ConCheck.Item(0).Picture
            Call BacControlWindows(1)
        End If

        If Grid.TextMatrix(iContador, 1) = "FD52" Then
            Set Grid.CellPicture = ConCheck.Item(0).Picture
            If Modulo_Interfaces.InterfazFlujosSWP(cDirectorio, cNombre, Pnl_Progreso) = True Then Set Grid.CellPicture = ConCheck.Item(0).Picture
            Call BacControlWindows(1)
        End If

        If Grid.TextMatrix(iContador, 1) = "CHEQ" Then
            Set Grid.CellPicture = ConCheck.Item(0).Picture
            If nConsistencia = 1 And GridOp.Rows > 1 Then
                Call BacParcelaInterfaz.FuncValidaInterfaz(Grid, GridOp, GridBo, GridFli, iSistema, Pnl_Progreso)
            End If
            Call BacControlWindows(1)

            If BacParcelaInterfaz.FuncLoadErroresProcesos(iSistema, MensajeError, cAsunto) = False Then
                Call BacParcelaInterfaz.FuncSendMail(iSistema, MensajeError, cAsunto)
            End If
        End If

        If Grid.TextMatrix(iContador, 1) = "FDIA" Then
            If nInterfazOP = 0 And nInterfazBO = 0 And nInterfazFL = 0 Then
                Set Grid.CellPicture = ConCheck.Item(0).Picture
                'If BacParcelaInterfaz.FuncLoadErroresProcesos(iSistema, MensajeError, cAsunto) = False Then
                '    Call MsgBox("Proceso de cierre ha encontrado errores durante el cierre.", vbExclamation, App.Title)
                'Else
                    If FuncGenFinDiaSwap(Pnl_Progreso, MensajeFinDia) = True Then
                        Call MsgBox("Proceso de cierre se ha realizado correctamente.", vbInformation, App.Title)
                    Else
                        MsgBox MensajeFinDia, vbCritical, Msj
                    End If
                'End If
                Call BacControlWindows(1)
            Else
                Call MsgBox(" Se generaron interfaces vacías, favor revisar. ", vbExclamation, App.Title)
            End If

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


Private Function FuncGenFinDiaSwap(ByRef Barra As SSPanel, cTexto As String) As Boolean
    Dim i           As Integer
    Dim nTotal      As Integer
    Dim SQL         As String
    Dim lRet        As Boolean
    Dim nRetorno
    Dim Datos()
    
    Let nTotal = 0
    
    Let FuncGenFinDiaSwap = False
    
    Barra.FloodPercent = 0
    Barra.ForeColor = vbBlack

    If MISQL.SQL_Execute("BEGIN TRANSACTION") Then
        Exit Function
    End If
    
    For i = 0 To 4

        Envia = Array()
        AddParam Envia, (Format(gsBAC_Fecp, "yyyymmdd"))
        AddParam Envia, Str(i)
        If Bac_Sql_Execute("SP_FINDIA", Envia) Then
            If Bac_SQL_Fetch(Datos()) Then
                lRet = True
                nRetorno = Val(Datos(1))
                Select Case nRetorno
                    Case -211: cTexto = "NO pudo Limpiar datos en Cartera Historica"
                    Case -111: cTexto = "NO pudo Actualizar datos en Cartera Historica"
                    Case -212: cTexto = "NO pudo Limpiar registros en Cartera Log"
                    Case -112: cTexto = "NO pudo Actualizar datos en Cartera Log"
                    Case -213: cTexto = "NO pudo Limpiar datos en Movimiento Histórico"
                    Case -113: cTexto = "NO pudo Actualizar datos Movimiento Histórico"
                    Case -214: cTexto = "NO pudo Limpiar datos en Swap General Histórico"
                    Case -114: cTexto = "NO pudo Actualizar datos en Swap General Histórico"
                    Case -115: cTexto = "NO pudo Actualizar datos en Swap General"
                    Case -300: cTexto = "NO pudo Limpiar datos en Cartera Vigente Historica"
                    Case -310: cTexto = "NO pudo Actualizar datos en Cartera Vigente Historica"
                    Case -320: cTexto = "NO pudo Limpiar los últimos 60 dias de la Cartera Vigente Historica"
                    Case 0:    lRet = False
                    Case Else: cTexto = "Problemas NO pudo Actualizar datos"        ' lRet = False
                End Select
             
                If lRet Then
                    If MISQL.SQL_Execute("ROLLBACK TRANSACTION") <> 0 Then
                        Exit Function
                    End If
                End If
            End If
        Else
            If MISQL.SQL_Execute("ROLLBACK TRANSACTION") <> 0 Then
                Exit Function
            End If
            Exit Function
        End If
        
        nTotal = nTotal + 1
        
        Let Barra.FloodPercent = ((nTotal * 100) / 5)
        If Barra.FloodPercent >= 49 Then
            Barra.ForeColor = vbWhite
        End If
        Call BacControlWindows(1)
    Next i


    If MISQL.SQL_Execute("COMMIT TRANSACTION") <> 0 Then
        Exit Function
    Else
        Call ChequeaRelacionOperGtia
        If gsc_Parametros.DatosGenerales() Then
            Call AsignaValoresParametros
        End If
    End If

    Let FuncGenFinDiaSwap = True
End Function


Private Function ChequeaRelacionOperGtia() As Boolean

    ChequeaRelacionOperGtia = True

    Envia = Array()
    AddParam Envia, "PCS"
    If Not Bac_Sql_Execute("BacParamSuda.dbo.SP_CHKRELACION_OPER_GARANTIAS", Envia) Then
        ChequeaRelacionOperGtia = False
        Exit Function
    End If

    ChequeaRelacionOperGtia = True

End Function
