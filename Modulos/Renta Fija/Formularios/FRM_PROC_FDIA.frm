VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.1#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BACControles.ocx"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Begin VB.Form FRM_PROC_FDIA 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Fin de Día"
   ClientHeight    =   10530
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   7215
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   10530
   ScaleWidth      =   7215
   Begin VB.PictureBox ConCheck 
      BorderStyle     =   0  'None
      Height          =   255
      Index           =   0
      Left            =   825
      Picture         =   "FRM_PROC_FDIA.frx":0000
      ScaleHeight     =   255
      ScaleWidth      =   285
      TabIndex        =   11
      Top             =   8040
      Visible         =   0   'False
      Width           =   285
   End
   Begin VB.PictureBox SinCheck 
      BorderStyle     =   0  'None
      Height          =   255
      Index           =   0
      Left            =   0
      Picture         =   "FRM_PROC_FDIA.frx":015A
      ScaleHeight     =   255
      ScaleWidth      =   285
      TabIndex        =   10
      Top             =   8040
      Visible         =   0   'False
      Width           =   285
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   7215
      _ExtentX        =   12726
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
      Enabled         =   0   'False
      Height          =   1800
      Left            =   15
      TabIndex        =   1
      Top             =   435
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
         Left            =   6555
         TabIndex        =   6
         Top             =   390
         Visible         =   0   'False
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
         Alignment       =   2  'Center
         BackColor       =   &H00C0FFFF&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   675
         Left            =   75
         TabIndex        =   5
         Top             =   1050
         Width           =   6960
         WordWrap        =   -1  'True
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
      Height          =   7290
      Left            =   15
      TabIndex        =   8
      Top             =   2160
      Width           =   7140
      Begin MSFlexGridLib.MSFlexGrid Grid 
         Height          =   7095
         Left            =   30
         TabIndex        =   9
         Top             =   135
         Width           =   7050
         _ExtentX        =   12435
         _ExtentY        =   12515
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
      Left            =   15
      TabIndex        =   7
      Top             =   9405
      Width           =   7140
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
   Begin MSFlexGridLib.MSFlexGrid GridOp 
      Height          =   2595
      Left            =   7320
      TabIndex        =   17
      Top             =   540
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
      Top             =   3135
      Width           =   5910
      _ExtentX        =   10425
      _ExtentY        =   4604
      _Version        =   393216
      Cols            =   23
      FixedCols       =   0
      AllowUserResizing=   1
   End
   Begin MSFlexGridLib.MSFlexGrid GridFli 
      Height          =   2280
      Left            =   7365
      TabIndex        =   19
      Top             =   5790
      Width           =   5820
      _ExtentX        =   10266
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
Const iSistema = "BTR"

Dim bHabilitaCtrl       As Boolean

Dim cNomArchivo         As String
Dim cDia                As String

Public NombreArchivo    As String

Option Explicit

Private Sub CMDchangeDirectory_Click()
   Call Command.ShowSave
   
   Let LBLRutaAcceso.Caption = Replace(Command.FileName, Command.FileTitle, "")
End Sub

Private Function Setea_Grilla()
    Let Grid.Rows = 2:              Let Grid.cols = 6
    Let Grid.FixedRows = 1:         Let Grid.FixedCols = 0

    Let Grid.RowHeight(0) = 500
    
    Let Grid.TextMatrix(0, 0) = "Estado":       Grid.ColWidth(0) = 750:      Grid.ColAlignment(0) = flexAlignLeftCenter
    Let Grid.TextMatrix(0, 1) = "Sigla":        Grid.ColWidth(1) = 1280:     Grid.ColAlignment(1) = flexAlignLeftCenter
    Let Grid.TextMatrix(0, 2) = "Nombre":       Grid.ColWidth(2) = 4900:     Grid.ColAlignment(2) = flexAlignLeftCenter
    Let Grid.TextMatrix(0, 3) = "Path":         Grid.ColWidth(3) = 0:        Grid.ColAlignment(2) = flexAlignLeftCenter
    Let Grid.TextMatrix(0, 4) = "FileName":     Grid.ColWidth(4) = 0:        Grid.ColAlignment(2) = flexAlignLeftCenter
    Let Grid.TextMatrix(0, 5) = "Consistencia": Grid.ColWidth(5) = 0:        Grid.ColAlignment(5) = flexAlignLeftCenter
    
    Let Grid.RowHeightMin = 250
    Let Grid.Font.Name = "Tahoma"
    Let Grid.Font.Size = 8
    
    Let MarcoInterfaz.Enabled = False
End Function

Private Function Carga_Grilla()
    Dim i           As Integer
    Dim nCol        As Integer
    Dim sigla       As String
    Dim SqlDatos()
    
    Dim cPartName   As String
        Let cPartName = Format(TXTFechaGeneracion.text, "yymmdd") & ".DAT"
    
    
    Envia = Array()
    AddParam Envia, iSistema
    If Not Bac_Sql_Execute("BacParamSuda.dbo.SP_LEER_INTERFACES_MODULO", Envia) Then
        Exit Function
    End If
   
    Let Grid.Rows = 1
   
    Do While Bac_SQL_Fetch(SqlDatos())
        Let Grid.Rows = Grid.Rows + 1
        Let Grid.Col = 0:   Let Grid.Row = Grid.Rows - 1
        Let Grid.CellPictureAlignment = flexAlignCenterCenter

        Set Grid.CellPicture = SinCheck.Item(0).Picture
        
        Let Grid.TextMatrix(Grid.Row, nCol0) = ""
        Let Grid.TextMatrix(Grid.Row, nCol1) = UCase(SqlDatos(1))
        Let Grid.TextMatrix(Grid.Row, nCol2) = UCase(SqlDatos(2))
        Let Grid.TextMatrix(Grid.Row, nCol3) = TraePathDeArchivo(SqlDatos(1))
       'Let Grid.TextMatrix(Grid.Row, nCol4) = SqlDatos(1) & IIf(SqlDatos(1) = "CMMD", Replace(cPartName, ".DAT", ".TXT"), cPartName)
        Let Grid.TextMatrix(Grid.Row, nCol4) = ConfiguraExtencion(SqlDatos(1), cPartName)
        Let Grid.TextMatrix(Grid.Row, nCol5) = SqlDatos(4)
        
        Let bHabilitaCtrl = IIf(SqlDatos(5) = 1, True, False)
    Loop

    Let LBLEtiquetaAvance.Caption = "Interfaces Generadas : 0 de " & (Grid.Rows - 1) & "."

End Function

Public Function ConfiguraExtencion(ByVal cSigla As String, ByVal strFecha As String) As String
    Dim cExtension  As String
    
    If cSigla = "D16_D17" Then
        Let ConfiguraExtencion = UCase(Func_Read_INI("INTERFAZ_D_1617", "NAME_ARCHIVO", App.Path & "\" & "Bac-Sistemas.ini"))
        Let strFecha = Replace(strFecha, ".DAT", ".TXT")
        Let ConfiguraExtencion = Replace(ConfiguraExtencion, ".TXT", strFecha)
        Exit Function
    End If
    
    If cSigla = "MESTRN" Then
        Let ConfiguraExtencion = UCase(Func_Read_INI("SOS", "SOS_File_MESTRN", App.Path & "\" & "Bac-Sistemas.ini"))
        Exit Function
    End If
    If cSigla = "MESCTACL" Then
        Let ConfiguraExtencion = UCase(Func_Read_INI("SOS", "SOS_File_MESCTACL", App.Path & "\" & "Bac-Sistemas.ini"))
        Exit Function
    End If
    If cSigla = "MESCLI" Then
        Let ConfiguraExtencion = UCase(Func_Read_INI("SOS", "SOS_File_MESCLI", App.Path & "\" & "Bac-Sistemas.ini"))
        Exit Function
    End If
    If cSigla = "MESOFC" Then
        Let ConfiguraExtencion = UCase(Func_Read_INI("SOS", "SOS_File_MESOFC", App.Path & "\" & "Bac-Sistemas.ini"))
        Exit Function
    End If
    
    If cSigla = "PARMES" Then
        Let ConfiguraExtencion = UCase(Func_Read_INI("INTERFAZ_PARMES", "NAME_ARCHIVO", App.Path & "\" & "Bac-Sistemas.ini"))
        
        Let ConfiguraExtencion = Replace(ConfiguraExtencion, "DD", Format(gsBac_Fecp, "DD"))
        Let ConfiguraExtencion = Replace(ConfiguraExtencion, "MM", Format(gsBac_Fecp, "MM"))
        Let ConfiguraExtencion = Replace(ConfiguraExtencion, "AA", Format(gsBac_Fecp, "YY"))
        Exit Function
    End If

    
    '=================================================================================
    ' LD1_COR_035 , Tema: INTERFACES Renta 1, 2, 3 y 4 (Gen_cap, mdci, mdvi, mdcp)
    ' INICIO
    '=================================================================================
    
    If cSigla = "RGENCAP" Then
        Let ConfiguraExtencion = UCase(Func_Read_INI("INTERFAZ_RGENCAP", "NAME_ARCHIVO", App.Path & "\" & "Bac-Sistemas.ini"))
        Exit Function
    End If
    
    If cSigla = "RMDCI" Then
        Let ConfiguraExtencion = UCase(Func_Read_INI("INTERFAZ_RMDCI", "NAME_ARCHIVO", App.Path & "\" & "Bac-Sistemas.ini"))
        Exit Function
    End If
    
    If cSigla = "RMDCP" Then
        Let ConfiguraExtencion = UCase(Func_Read_INI("INTERFAZ_RMDCP", "NAME_ARCHIVO", App.Path & "\" & "Bac-Sistemas.ini"))
        Exit Function
    End If
    
    If cSigla = "RMDVI" Then
        Let ConfiguraExtencion = UCase(Func_Read_INI("INTERFAZ_RMDVI", "NAME_ARCHIVO", App.Path & "\" & "Bac-Sistemas.ini"))
        Exit Function
    End If
    
    '=================================================================================
    ' LD1_COR_035 , Tema: INTERFACES Renta 1, 2, 3 y 4 (Gen_cap, mdci, mdvi, mdcp)
    ' FIN
    '=================================================================================
    
    
    '=================================================================================
    ' LD1_COR_035 , Tema: INTERFACES BACEN
    ' INICIO
    '=================================================================================
    
    If cSigla = "BACEN" Then
        Let ConfiguraExtencion = UCase(Func_Read_INI("INTERFAZ_BACEN", "NAME_ARCHIVO", App.Path & "\" & "Bac-Sistemas.ini"))
        Exit Function
    End If
    
    '=================================================================================
    ' LD1_COR_035 , Tema: INTERFACES BACEN
    ' FIN
    '=================================================================================
    
    
    If cSigla = "CMMD" Then
        Let ConfiguraExtencion = cSigla & Replace(strFecha, ".DAT", ".TXT")
        Exit Function
    Else
        Let ConfiguraExtencion = cSigla & strFecha '& ".DAT"
        Exit Function
    End If

End Function

Public Function TraePathDeArchivo(ByVal cSigla As String) As String
    Let TraePathDeArchivo = UCase(Func_Read_INI("INTERFAZ_IBS", "PATH_BTR_IBS", App.Path & "\" & "Bac-Sistemas.ini"))

    If cSigla = "MESTRN" Or cSigla = "MESCTACL" Or cSigla = "MESCLI" Or cSigla = "MESOFC" Then
        Let TraePathDeArchivo = UCase(Func_Read_INI("SOS", "SOS_PathFile_Produccion", App.Path & "\" & "Bac-Sistemas.ini"))
    End If

    If cSigla = "D16_D17" Then
        Let TraePathDeArchivo = UCase(Func_Read_INI("INTERFAZ_D_1617", "RUTA_ARCHIVO", App.Path & "\" & "Bac-Sistemas.ini"))
    End If

    If cSigla = "C18" Then
        Let TraePathDeArchivo = UCase(Func_Read_INI("INTERFAZ", "PATH_C18", App.Path & "\" & "Bac-Sistemas.ini"))
        If Len(TraePathDeArchivo) = 0 Then
            Let TraePathDeArchivo = UCase(Func_Read_INI("INTERFAZ_IBS", "PATH_BTR_IBS", App.Path & "\" & "Bac-Sistemas.ini"))
            Let TraePathDeArchivo = TraePathDeArchivo & "C18\"
        End If
    End If

    If cSigla = "P40" Then
        Let TraePathDeArchivo = UCase(Func_Read_INI("INTERFAZ", "PATH_P40", App.Path & "\" & "Bac-Sistemas.ini"))
        If Len(TraePathDeArchivo) = 0 Then
            Let TraePathDeArchivo = UCase(Func_Read_INI("INTERFAZ_IBS", "PATH_BTR_IBS", App.Path & "\" & "Bac-Sistemas.ini"))
        End If
    End If
    If cSigla = "CMMD" Then
        Let TraePathDeArchivo = gsBac_DIRIN
    End If
    
    If cSigla = "PARMES" Then
        Let TraePathDeArchivo = UCase(Func_Read_INI("INTERFAZ_PARMES", "RUTA_ARCHIVO", App.Path & "\" & "Bac-Sistemas.ini"))
    End If


    '=================================================================================
    ' LD1_COR_035 , Tema: INTERFACES Renta 1, 2, 3 y 4 (Gen_cap, mdci, mdvi, mdcp)
    ' INICIO
    '=================================================================================
    If cSigla = "RGENCAP" Then
        Let TraePathDeArchivo = UCase(Func_Read_INI("INTERFAZ_RGENCAP", "RUTA_ARCHIVO", App.Path & "\" & "Bac-Sistemas.ini"))
    End If
    
    If cSigla = "RMDCI" Then
        Let TraePathDeArchivo = UCase(Func_Read_INI("INTERFAZ_RMDCI", "RUTA_ARCHIVO", App.Path & "\" & "Bac-Sistemas.ini"))
    End If
    
    If cSigla = "RMDCP" Then
        Let TraePathDeArchivo = UCase(Func_Read_INI("INTERFAZ_RMDCP", "RUTA_ARCHIVO", App.Path & "\" & "Bac-Sistemas.ini"))
    End If
    
    If cSigla = "RMDVI" Then
        Let TraePathDeArchivo = UCase(Func_Read_INI("INTERFAZ_RMDVI", "RUTA_ARCHIVO", App.Path & "\" & "Bac-Sistemas.ini"))
    End If
    
    '=================================================================================
    ' LD1_COR_035 , Tema: INTERFACES Renta 1, 2, 3 y 4 (Gen_cap, mdci, mdvi, mdcp)
    ' FIN
    '=================================================================================
    
    
    '=================================================================================
    ' LD1_COR_035 , Tema: INTERFACES BACEN
    ' INICIO
    '=================================================================================
    If cSigla = "BACEN" Then
        Let TraePathDeArchivo = UCase(Func_Read_INI("INTERFAZ_BACEN", "RUTA_ARCHIVO", App.Path & "\" & "Bac-Sistemas.ini"))
    End If
   
    '=================================================================================
    ' LD1_COR_035 , Tema: INTERFACES BACEN
    ' FIN
    '=================================================================================
    
End Function

Private Function FuncResetCheck()
    Dim iContador   As Long
    
    For iContador = 1 To Grid.Rows - 1
        Let Grid.Col = 0:   Let Grid.Row = iContador
        Set Grid.CellPicture = SinCheck.Item(0).Picture
    Next iContador

    Let Pnl_Progreso.FloodPercent = 0
    Let Pnl_ProgresoTot.FloodPercent = 0

    Let Pnl_ProgresoTot.FloodColor = vbBlue:   Let Pnl_ProgresoTot.ForeColor = vbBlack
    Let Pnl_Progreso.FloodColor = vbBlue:      Let Pnl_Progreso.ForeColor = vbBlack

    Let LBLEtiquetaAvance.Caption = "Interfaces Generadas : 0 de " & (Grid.Rows - 1) & "."
End Function

Private Sub Form_Load()
Me.Top = 0
Me.Left = 0
    Let Me.Icon = BacTrader.Icon
    
    '=================================================================================
    ' LD1_COR_035 , Tema: INTERFACES Renta 1, 2, 3 y 4 (Gen_cap, mdci, mdvi, mdcp)
   ' INICIO
    '=================================================================================
   
   ' Let Me.Width = 7245:                            Let Me.Height = 11160
   ' Let Me.MarcoInterfaz.Width = 7140:              Let Me.MarcoInterfaz.Height = 6690
   ' Let Me.Grid.Height = 6480:                      Let Me.Grid.Width = 7050
    Let TXTFechaGeneracion.BackColor = &H80000005:  Let TXTFechaGeneracion.ForeColor = &H80000008
    Let LBLRutaAcceso.BackColor = &H80000005:       Let LBLRutaAcceso.ForeColor = &H80000008
   ' Let Frame3.Top = 8040
    '=================================================================================
    ' LD1_COR_035 , Tema: INTERFACES Renta 1, 2, 3 y 4 (Gen_cap, mdci, mdvi, mdcp)
    ' FIN
    '=================================================================================
    
    Let Me.Caption = "Generacion de Fin de Día"
    Let LBLRutaAcceso.Caption = gsBac_DIRIBS
    Let TXTFechaGeneracion.text = Format(gsBac_Fecp, "dd-mm-yyyy")
    
    Let CMDchangeDirectory.Visible = False
    Let CMDchangeDirectory.Enabled = False
    
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
    Dim Msj             As String
    Dim cAsunto         As String
    Dim oInterfaz       As String
    
    Call fnMarcaGrilla(vbBlack, 0, True)
    
    If MsgBox("¿ Decea procesar el fin de día. ?", vbQuestion + vbYesNo, App.Title) = vbNo Then
       Let Screen.MousePointer = vbDefault
       Exit Function
    End If

    If FnControlParidadesMensuales() = False Then
        Let Screen.MousePointer = vbDefault
        Exit Function
    End If

    Call FuncEraseErrores(iSistema)
    
    If FuncCargaDatosInterfaz_SOS = False Then
        Call MsgBox("Se ha generado un error en la carga de información para interfaces SOS.", vbExclamation, App.Title)
        Exit Function
    End If
    
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
    Let Msj = ""

    Call BacControlWindows(5)

    For iContador = 1 To Grid.Rows - 1
        Let Grid.Col = 0
        Let Grid.Row = iContador

        Let cNombre = Grid.TextMatrix(iContador, 4)
        Let cDirectorio = Grid.TextMatrix(iContador, 3)
        Let oInterfaz = UCase(Grid.TextMatrix(iContador, 1))    '-> Para Identificar donde va.

        Let Pnl_Progreso.FloodPercent = 0:  Let Pnl_Progreso.FloodColor = vbBlue:   Let Pnl_Progreso.ForeColor = vbBlack

        Call BacControlWindows(1)
        Call fnMarcaGrilla(vbBlue, iContador, False)
        Call BacControlWindows(1)


        If oInterfaz = "OP15" Then
            Let nConsistencia = CInt(Grid.TextMatrix(iContador, 5))

            If Modulo_Interfaces.InterfazOperaciones(cDirectorio, cNombre, Pnl_Progreso, bInterfazDatos) = True Then
                Set Grid.CellPicture = ConCheck.Item(0).Picture
                Call BacControlWindows(1)
                If bHabilitaCtrl = True Then
                    If bInterfazDatos = True Then
                        nInterfazOP = 0
                        Call BacParcelaInterfaz.FuncParcelaInterfaz(cDirectorio & cNombre, GridOp, "OP15", iSistema)
                    Else
                        Call BacParcelaInterfaz.FuncInsertMsgError(iSistema, cNombre, 0, 0, 0, "INTERFAZ SIN DATOS", True)
                    End If
                End If
            Else
                GoTo ErrorGeneracionProcesoCierre
            End If
            Call BacControlWindows(1)
        End If

        
        If oInterfaz = "BO15" Then
            If Modulo_Interfaces.InterfazBalance(cDirectorio, cNombre, Pnl_Progreso, bInterfazDatos) = True Then
                Set Grid.CellPicture = ConCheck.Item(0).Picture
                Call BacControlWindows(1)
                If bHabilitaCtrl = True Then
                    If bInterfazDatos = True Then
                        nInterfazBO = 0
                        Call BacParcelaInterfaz.FuncParcelaInterfaz(cDirectorio & cNombre, GridBo, "BO15", iSistema)
                    Else
                        Call BacParcelaInterfaz.FuncInsertMsgError(iSistema, cNombre, 0, 0, 0, "INTERFAZ SIN DATOS", True)
                    End If
                End If
            Else
               GoTo ErrorGeneracionProcesoCierre
            End If
            Call BacControlWindows(1)
        End If


        If oInterfaz = "FL15" Then
            If Modulo_Interfaces.Interfazflujosmutuos(cDirectorio, cNombre, Pnl_Progreso, bInterfazDatos) = True Then
                Set Grid.CellPicture = ConCheck.Item(0).Picture
                Call BacControlWindows(1)
                If bHabilitaCtrl = True Then
                    If bInterfazDatos = True Then
                        nInterfazFL = 0
                        Call BacParcelaInterfaz.FuncParcelaInterfaz(cDirectorio & cNombre, GridFli, "FL15", iSistema)
                    Else
                        Call BacParcelaInterfaz.FuncInsertMsgError(iSistema, cNombre, 0, 0, 0, "INTERFAZ SIN DATOS", True)
                    End If
                End If
            Else
               GoTo ErrorGeneracionProcesoCierre
            End If
            Call BacControlWindows(1)
        End If

        If oInterfaz = "DD15" Then
            If Modulo_Interfaces.InterfazDirecciones(cDirectorio, cNombre, Pnl_Progreso) = False Then
                GoTo ErrorGeneracionProcesoCierre
            End If
            Set Grid.CellPicture = ConCheck.Item(0).Picture
            Call BacControlWindows(1)
        End If

        If oInterfaz = "PC15" Then
            If Modulo_Interfaces.InterfazPosicion(cDirectorio, cNombre, Pnl_Progreso) = False Then
                GoTo ErrorGeneracionProcesoCierre
            End If
            Set Grid.CellPicture = ConCheck.Item(0).Picture
            Call BacControlWindows(1)
        End If

        If oInterfaz = "CO15" Then
            If Modulo_Interfaces.InterfazDeudores_resp(cDirectorio, cNombre, Pnl_Progreso) = False Then
                GoTo ErrorGeneracionProcesoCierre
            End If
            Set Grid.CellPicture = ConCheck.Item(0).Picture
            Call BacControlWindows(1)
        End If

        If oInterfaz = "CL14" Then
            If Modulo_Interfaces.Clientes(cDirectorio, cNombre, Pnl_Progreso) = False Then
                GoTo ErrorGeneracionProcesoCierre
            End If
            Set Grid.CellPicture = ConCheck.Item(0).Picture
            Call BacControlWindows(1)
        End If

        If oInterfaz = "CMMD" Then
            If Modulo_Interfaces.InterfazArt84(cDirectorio, cNombre, Pnl_Progreso) = True Then
                Set Grid.CellPicture = ConCheck.Item(0).Picture
            Else
                Exit For
            End If
            Set Grid.CellPicture = ConCheck.Item(0).Picture
            Call BacControlWindows(1)
        End If

        If oInterfaz = "P40" Then
            If Modulo_Interfaces.SIGUIR(cDirectorio, cNombre, Pnl_Progreso) = False Then
                GoTo ErrorGeneracionProcesoCierre
            End If
            Set Grid.CellPicture = ConCheck.Item(0).Picture
            Call BacControlWindows(1)
        End If

        If oInterfaz = "C18" Then
            If Modulo_Interfaces.FuncGeneracionC18(True, cDirectorio, cNombre, Pnl_Progreso) = False Then
                GoTo ErrorGeneracionProcesoCierre
            End If
            Set Grid.CellPicture = ConCheck.Item(0).Picture
            Call BacControlWindows(1)
        End If

        '-> INTERFACES PARA SISTEMA SOS - LAVADO DE ACTIVOS
        If oInterfaz = "MESTRN" Then
            If Modulo_Interfaces.Interfaz_SOS_MAESTRN(cDirectorio, cNombre, Pnl_Progreso, TXTFechaGeneracion.text) = False Then
                GoTo ErrorGeneracionProcesoCierre
            Else
                Set Grid.CellPicture = ConCheck.Item(0).Picture
                Call BacControlWindows(1)
            End If
        End If
        If oInterfaz = "MESCTACL" Then
            If Modulo_Interfaces.Interfaz_SOS_MESCTACL(cDirectorio, cNombre, Pnl_Progreso, TXTFechaGeneracion.text) = False Then
                GoTo ErrorGeneracionProcesoCierre
            Else
                Set Grid.CellPicture = ConCheck.Item(0).Picture
                Call BacControlWindows(1)
            End If
        End If
        If oInterfaz = "MESCLI" Then
            If Modulo_Interfaces.Interfaz_SOS_MESCLI(cDirectorio, cNombre, Pnl_Progreso, TXTFechaGeneracion.text) = False Then
                GoTo ErrorGeneracionProcesoCierre
            Else
                Set Grid.CellPicture = ConCheck.Item(0).Picture
                Call BacControlWindows(1)
            End If
        End If
        If oInterfaz = "MESOFC" Then
            If Modulo_Interfaces.Interfaz_SOS_MESOFC(cDirectorio, cNombre, Pnl_Progreso, TXTFechaGeneracion.text) = False Then
                GoTo ErrorGeneracionProcesoCierre
            Else
                Set Grid.CellPicture = ConCheck.Item(0).Picture
                Call BacControlWindows(1)
            End If
        End If
        '-> INTERFACES PARA SISTEMA SOS - LAVADO DE ACTIVOS

        '-> Interfaz Garantias D16 D17
        If oInterfaz = "D16_D17" Then
            If Modulo_Interfaces.InterfazD16_D17(cDirectorio, cNombre, Pnl_Progreso, TXTFechaGeneracion.text) = False Then
                GoTo ErrorGeneracionProcesoCierre
            End If
            Set Grid.CellPicture = ConCheck.Item(0).Picture
            Call BacControlWindows(1)
        End If

        '-> Interfaz de Paridades Mensuales
        If oInterfaz = "PARMES" Then
            If Modulo_Interfaces.Interfaz_ParidadesMensuales(cDirectorio, cNombre, Pnl_Progreso, TXTFechaGeneracion.text) = False Then
                GoTo ErrorGeneracionProcesoCierre
            End If
            Call fnMarcaGrilla(vbBlue, iContador, False)
            Set Grid.CellPicture = ConCheck.Item(0).Picture
            Call BacControlWindows(1)
        End If
        '-> Interfaz de Paridades Mensuales


        'Interfaces OGM - RCO --> INICIO    --> Agregadas por Fusion para ITAU
        If oInterfaz = "RCO" Then
            If Modulo_Interfaces.Interfaz_ITAU(cDirectorio, Pnl_Progreso, TXTFechaGeneracion.text, CStr(Grid.TextMatrix(iContador, 1)), Msj) = False Then
               GoTo ErrorGeneracionProcesoCierre
            End If
            Set Grid.CellPicture = ConCheck.Item(0).Picture
            Call BacControlWindows(1)
        End If
              
''''' Dejar comentado
'''''        If Grid.TextMatrix(iContador, 1) = "OGMDerivados" Then
'''''            If Modulo_Interfaces.Interfaz_ITAU(cDirectorio, Pnl_Progreso, TXTFechaGeneracion.text, CStr(Grid.TextMatrix(iContador, 1)), Msj) = False Then
'''''                GoTo ErrorGeneracionProcesoCierre
'''''            End If
'''''            Set Grid.CellPicture = ConCheck.Item(0).Picture
'''''            Call BacControlWindows(1)
'''''        End If
        
        
        If oInterfaz = UCase("OGMInversiones") Then
            If Modulo_Interfaces.Interfaz_ITAU(cDirectorio, Pnl_Progreso, TXTFechaGeneracion.text, CStr(Grid.TextMatrix(iContador, 1)), Msj) = False Then
                GoTo ErrorGeneracionProcesoCierre
            End If
            Set Grid.CellPicture = ConCheck.Item(0).Picture
            Call BacControlWindows(1)
        End If
       'Interfaces OGM - RCO --> FIN
        
        
        '=================================================================================
        ' LD1_COR_035 , Tema: INTERFACES Renta 1, 2, 3 y 4 (Gen_cap, mdci, mdvi, mdcp)
        ' INICIO
        '=================================================================================
        
        '-> Interfaz Renta GEN CAP
        If oInterfaz = "RGENCAP" Then
            If Modulo_Interfaces.Genera_GENERA_DTS_GEN_CAP(cDirectorio, cNombre, Pnl_Progreso, TXTFechaGeneracion.text) = False Then
                GoTo ErrorGeneracionProcesoCierre
            End If
            Set Grid.CellPicture = ConCheck.Item(0).Picture
            Call BacControlWindows(1)
        End If
        '-> Interfaz Renta GEN CAP
        
        '-> Interfaz Renta MDCI
        If oInterfaz = "RMDCI" Then
            If Modulo_Interfaces.Genera_GENERA_DTS_GEN_MDCI(cDirectorio, cNombre, Pnl_Progreso, TXTFechaGeneracion.text) = False Then
                GoTo ErrorGeneracionProcesoCierre
            End If
            Set Grid.CellPicture = ConCheck.Item(0).Picture
            Call BacControlWindows(1)
        End If
        '-> Interfaz Renta MDCI
        
        '-> Interfaz Renta MDCI
        If oInterfaz = "RMDCP" Then
            If Modulo_Interfaces.Genera_GENERA_DTS_GEN_MDCP(cDirectorio, cNombre, Pnl_Progreso, TXTFechaGeneracion.text) = False Then
                GoTo ErrorGeneracionProcesoCierre
            End If
            Set Grid.CellPicture = ConCheck.Item(0).Picture
            Call BacControlWindows(1)
        End If
        '-> Interfaz Renta MDCI
        
        '-> Interfaz Renta MDVI
        If oInterfaz = "RMDVI" Then
            If Modulo_Interfaces.Genera_GENERA_DTS_MDVI(cDirectorio, cNombre, Pnl_Progreso, TXTFechaGeneracion.text) = False Then
                GoTo ErrorGeneracionProcesoCierre
            End If
            Set Grid.CellPicture = ConCheck.Item(0).Picture
            Call BacControlWindows(1)
        End If
        '-> Interfaz Renta MDVI

        '=================================================================================
        ' LD1_COR_035 , Tema: INTERFACES Renta 1, 2, 3 y 4 (Gen_cap, mdci, mdvi, mdcp)
        ' FIN
        '=================================================================================


        '=================================================================================
        ' LD1_COR_035 , Tema: INTERFACES BACEN
        ' INICIO
        '=================================================================================
        If oInterfaz = "BACEN" Then
            If Modulo_Interfaces.Genera_BACEN(cDirectorio, cNombre, Pnl_Progreso, TXTFechaGeneracion.text) = False Then
                GoTo ErrorGeneracionProcesoCierre
            End If

            Set Grid.CellPicture = ConCheck.Item(0).Picture
            Call BacControlWindows(1)
        End If
        '=================================================================================
        ' LD1_COR_035 , Tema: INTERFACES BACEN
        ' FIN
        '=================================================================================
        

        If oInterfaz = "CHEQ" Then
            If bHabilitaCtrl = True Then
            If nConsistencia = 1 And GridOp.Rows > 1 Then
                Call BacParcelaInterfaz.FuncValidaInterfaz(Grid, GridOp, GridBo, GridFli, iSistema, Pnl_Progreso)
            End If

            Set Grid.CellPicture = ConCheck.Item(0).Picture
            Call BacControlWindows(1)

            If BacParcelaInterfaz.FuncLoadErroresProcesos(iSistema, MensajeError, cAsunto) = False Then
               Call BacParcelaInterfaz.FuncSendMail(iSistema, MensajeError, cAsunto)
               GoTo ErrorGeneracionProcesoCierre:
            End If
            Else
                Set Grid.CellPicture = ConCheck.Item(0).Picture
            End If
        End If


        If oInterfaz = "FDIA" Then
            If bHabilitaCtrl = False Then
                nInterfazOP = 0
                nInterfazBO = 0
                nInterfazFL = 0
            End If

            If nInterfazOP = 0 And nInterfazBO = 0 And nInterfazFL = 0 Then
                If bHabilitaCtrl = False Then
                    If FuncGenFinDia(Pnl_Progreso, MensajeFinDia) = True Then
                        Set Grid.CellPicture = ConCheck.Item(0).Picture
                    Else
                        Call MsgBox(MensajeFinDia, vbCritical, Msj)
                        GoTo ErrorGeneracionProcesoCierre:
                    End If
                Else
                    If FuncLoadErroresProcesos(iSistema, MensajeError, cAsunto) = False Then
                        Call MsgBox("Se han encontrado errores en el proceso de cierre.", vbExclamation, App.Title)
                        GoTo ErrorGeneracionProcesoCierre:
                    Else
                        If FuncGenFinDia(Pnl_Progreso, MensajeFinDia) = True Then
                            Set Grid.CellPicture = ConCheck.Item(0).Picture
                            'Call MsgBox("Proceso de cierre se ha realizado correctamente.", vbInformation, App.Title)
                        Else
                            Call MsgBox(MensajeFinDia, vbCritical, Msj)
                            GoTo ErrorGeneracionProcesoCierre:
                        End If
                    End If
                End If
                Call BacControlWindows(1)
            Else
                Call MsgBox(" Se generaron interfaces vacías, favor revisar. ", vbExclamation, App.Title)
            End If
        End If
        
        
        Call BacControlWindows(1)
        Call fnMarcaGrilla(vbBlack, iContador, False)
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

    Call generar_interfaz_cliente
    
    Let Pnl_ProgresoTot.FloodPercent = 100
    Let Pnl_ProgresoTot.FloodColor = vbGreen:   Let Pnl_ProgresoTot.ForeColor = vbBlack
    Let Pnl_Progreso.FloodColor = vbGreen:      Let Pnl_Progreso.ForeColor = vbBlack
    
    Call MsgBox("Proceso de cierre se ha realizado correctamente.", vbInformation, App.Title)
    
    On Error GoTo 0
Exit Function
ErrorGeneracionProcesoCierre:

    Call fnMarcaGrilla(vbRed, iContador, False)

    Let Pnl_ProgresoTot.FloodColor = vbRed:   Let Pnl_ProgresoTot.ForeColor = vbWhite
    Let Pnl_Progreso.FloodColor = vbRed:      Let Pnl_Progreso.ForeColor = vbWhite

    If Len(Msj) <> 0 Then
        Call MsgBox("E- ERROR EN GENERACION DE INTERFACES" & vbCrLf & Msj & vbCrLf & "Proceso no finalizado...", vbCritical, App.Title)
    Else
   Call MsgBox("E- ERROR EN GENERACION DE INTERFACES" & vbCrLf & vbCrLf & "Proceso no finalizado...", vbCritical, App.Title)
    End If

End Function

Private Function FuncGeneracion()
    Dim Cont As Integer
    
    Call FuncResetCheck
    
    Call FuncGeneracionInterfaz

End Function

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 2:   Call FuncGeneracion
      Case 3:   Call Unload(Me)
   End Select
End Sub

Private Function FuncGenFinDia(ByRef Barra As SSPanel, cTexto As String) As Boolean
Dim Datos()
Dim cFechoy$
Dim Dias    As Integer
Dim dFecha  As Date

   Let FuncGenFinDia = False
    
    cFechoy$ = Trim(Str(Month(gsBac_Fecp))) + "/" + Trim(Str(Day(gsBac_Fecp))) + "/" + Trim(Str(Year(gsBac_Fecp)))
   
    Screen.MousePointer = 11
   
    ''========================================================================
    '' VGS 22/04/2005
    ''========================================================================
   
    Dias = DateDiff("d", gsBac_Fecp, gsBac_Fecx)
    dFecha = DateAdd("d", Dias, gsBac_Fecp)
    If DatePart("d", dFecha) >= 15 And DatePart("m", gsBac_Fecp) = 12 Then
         If Not ValidaFeriadosProximoAno(DatePart("yyyy", gsBac_Fecp) + 1) Then
             Screen.MousePointer = 0
             Exit Function
         End If
    End If
    ''========================================================================
    If miSQL.SQL_Execute("SP_FDIA") <> 0 Then
        Screen.MousePointer = 0
        Exit Function
    End If
   
    Screen.MousePointer = 0
   
    If Bac_SQL_Fetch(Datos()) Then
        If Datos(1) = "SI" Then
        Else
            cTexto = Datos(2)
        End If
    End If
   
    Screen.MousePointer = 0
   
   Let FuncGenFinDia = True
End Function

Private Function ValidaFeriadosProximoAno(nano As Double) As Boolean
Dim Datos()
Dim cMsg    As String
Dim SW      As Boolean

cMsg = "Falta los Feriados de los Siguientes meses del Año " & nano & vbCrLf & vbCrLf
ValidaFeriadosProximoAno = False
SW = True

Envia = Array()
AddParam Envia, nano
If Not Bac_Sql_Execute("SP_VALIDA_FERIADO_NEXT_YEAR", Envia) Then
    MsgBox "Error al Validar Feriados del Proximo Año", vbCritical, "FIN DE DIA"
    Exit Function
Else
    Do While Bac_SQL_Fetch(Datos())
        If Datos(1) = "NO" Then
            Select Case Datos(2)
                Case Is = 0: cMsg = "Debe Ingresar Feriados del Año " & nano & " Completo" & vbCrLf
                Case Is = 1: cMsg = cMsg & "Enero " & vbCrLf
                Case Is = 2: cMsg = cMsg & "Febrero " & vbCrLf
                Case Is = 3: cMsg = cMsg & "Marzo " & vbCrLf
                Case Is = 4: cMsg = cMsg & "Abril " & vbCrLf
                Case Is = 5: cMsg = cMsg & "Mayo " & vbCrLf
                Case Is = 6: cMsg = cMsg & "Junio " & vbCrLf
                Case Is = 7: cMsg = cMsg & "Julio " & vbCrLf
                Case Is = 8: cMsg = cMsg & "Agosto " & vbCrLf
                Case Is = 9: cMsg = cMsg & "Septiembre " & vbCrLf
                Case Is = 10: cMsg = cMsg & "Octubre " & vbCrLf
                Case Is = 11: cMsg = cMsg & "Noviembre " & vbCrLf
                Case Is = 12: cMsg = cMsg & "Diciembre "
            End Select
            SW = False
        End If
    Loop
    
    If Not SW Then
        MsgBox cMsg, vbCritical, "FIN DE DIA"
        Exit Function
    End If

End If
ValidaFeriadosProximoAno = True

End Function


Private Sub fnMarcaGrilla(ByVal oColor As Variant, ByVal nFila As Integer, ByVal nTodaGrilla As Boolean)
    On Error Resume Next
    Dim nFilas      As Integer
    Dim nColumnas   As Integer
    
    Let Grid.Redraw = False
    
    If nTodaGrilla = True Then

        For nFilas = (Grid.FixedRows) To (Grid.Rows - 1)
            Let Grid.Row = nFilas
    
            For nColumnas = 0 To (Grid.cols - 1)
                Let Grid.Col = nColumnas
                Let Grid.CellForeColor = oColor
            Next nColumnas
        Next nFilas

    Else

        For nFilas = nFila To nFila
            Let Grid.Row = nFilas
    
            For nColumnas = 0 To (Grid.cols - 1)
                Let Grid.Col = nColumnas
                Let Grid.CellForeColor = oColor
            Next nColumnas
        Next nFilas
    End If
    
    Let Grid.Col = 0
    
    Let Grid.Redraw = True

    On Error GoTo 0
End Sub


Sub generar_interfaz_cliente()
Dim oExcel As Object
Dim oBook As Object
Dim oSheet As Object
Dim Tabla() As Variant
Dim SqlDatos()

Dim NombreArch As String
Dim PathArch As String

On Error GoTo ErrorGenInterCli

Set oExcel = CreateObject("Excel.Application")
Set oBook = oExcel.Workbooks.Add
Set oSheet = oBook.Worksheets(1)

Screen.MousePointer = vbHourglass

Envia = Array()
AddParam Envia, 380 ' Interfaz Cliente para el Bloqueo
If Not Bac_Sql_Execute("sp_BacInterfaces_Archivo", Envia) Then
        Exit Sub
End If
If Bac_SQL_Fetch(SqlDatos()) Then
    Let NombreArch = SqlDatos(4) + SqlDatos(2) + Format(gsBac_Fecp, "yyyymmdd") + ".xlsx"
Else
    Let NombreArch = "C:\Temp\INFOCLI_" + Format(gsBac_Fecp, "yyyymmdd") + ".xlsx"
End If


If Len(Dir(NombreArch)) > 0 Then
        Call Kill(NombreArch)
End If

'Create a Recordset from all the records in the Orders table

    Dim objConn As New ADODB.Connection
    Dim objCmd As New ADODB.Command
    Dim objRs As New ADODB.Recordset
  
    objCmd.CommandText = "EXEC SP_LISTA_CLIENTES "
    objCmd.CommandType = adCmdText 'adCmdText 'adCmdStoredProc SP 'adCmdTable Table
    
    objCmd.Parameters.Append objCmd.CreateParameter("@FECHA", adDBTimeStamp, adParamInput, , gsBac_Fecp)
    
    Set objConn = GetNewConnection
    objCmd.ActiveConnection = objConn
  
    ' Execute once and display...
    
    'Ejecuta el procedimiento
    On Error Resume Next
        Set objRs = objCmd.Execute
    On Error GoTo ErrorGenInterCli
   
    
'Create a new workbook in Excel

    'Transfer the data to Excel
    oSheet.Range("A1:J1").Value = Array("Rut_Cliente", "DV_Cliente", "Codigo_Cliente", "Nombre_Contraparte", "Habilitado_Operar", "Origen", "Producto", "Folio_Operacion", "Fecha_Operacion", "usuario")

    oSheet.Range("A2").CopyFromRecordset objRs

    'Save the Workbook and Quit Excel
    
    oBook.SaveAs NombreArch
    oExcel.Quit
    
Screen.MousePointer = vbDefault
    
    Set oSheet = Nothing
    Set oBook = Nothing
    Set oExcel = Nothing
   
    'clean up
    objRs.Close
    objConn.Close
    Set objRs = Nothing
    Set objConn = Nothing
    Set objCmd = Nothing
    
    
    Exit Sub
  

ErrorGenInterCli:
    'clean up
    If objRs.State = adStateOpen Then
        objRs.Close
    End If
  
    If objConn.State = adStateOpen Then
        objConn.Close
    End If
  
    Set objRs = Nothing
    Set objConn = Nothing
    Set objCmd = Nothing
  
    Call BacParcelaInterfaz.FuncSendMail(iSistema, "ERROR INTERFAZ CLIENTE ", "INTERFAZ BLOQUEO DE CLIENTES")
    
    Screen.MousePointer = vbDefault
  
    If err <> 0 Then
        MsgBox err.Source & "-->" & err.Description, , "Error"
    End If

End Sub
