VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{989C9190-EDF5-45A8-AB6C-98E6EF0384D7}#1.0#0"; "Bac_Controles_Pas.ocx"
Begin VB.Form FRM_RPT_VENCIMIENTOS 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Informes de Vencimientos"
   ClientHeight    =   3720
   ClientLeft      =   2640
   ClientTop       =   1800
   ClientWidth     =   4890
   ForeColor       =   &H8000000F&
   Icon            =   "FRM_RPT_VENCIMIENTOS.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   3720
   ScaleWidth      =   4890
   Begin VB.Frame Frame3 
      Caption         =   "Fechas Proyectadas"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   1230
      Left            =   150
      TabIndex        =   14
      Top             =   540
      Width           =   4590
      Begin VB.PictureBox ConCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   3
         Left            =   3660
         ScaleHeight     =   330
         ScaleWidth      =   330
         TabIndex        =   4
         Top             =   810
         Visible         =   0   'False
         Width           =   330
      End
      Begin VB.PictureBox SinCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   3
         Left            =   645
         ScaleHeight     =   330
         ScaleWidth      =   375
         TabIndex        =   2
         Top             =   810
         Width           =   375
      End
      Begin BACControles.TXTFecha TxtFecProc 
         Height          =   315
         Left            =   810
         TabIndex        =   0
         Top             =   360
         Width           =   1215
         _ExtentX        =   2143
         _ExtentY        =   556
         Enabled         =   -1  'True
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
         MaxDate         =   402133
         MinDate         =   18264
         Text            =   "18/06/2001"
      End
      Begin BACControles.TXTFecha TxtFecProx 
         Height          =   315
         Left            =   2985
         TabIndex        =   1
         Top             =   360
         Width           =   1215
         _ExtentX        =   2143
         _ExtentY        =   556
         Enabled         =   -1  'True
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
         MaxDate         =   402133
         MinDate         =   18264
         Text            =   "18/06/2001"
      End
      Begin VB.Label Etiqueta 
         AutoSize        =   -1  'True
         Caption         =   "Resumen"
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
         Left            =   1260
         TabIndex        =   3
         Top             =   870
         Width           =   795
      End
      Begin VB.Label lblEtiqueta 
         AutoSize        =   -1  'True
         Caption         =   "Desde"
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
         Index           =   1
         Left            =   225
         TabIndex        =   16
         Top             =   375
         Width           =   525
      End
      Begin VB.Label lblEtiqueta 
         AutoSize        =   -1  'True
         Caption         =   "Hasta"
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
         Left            =   2400
         TabIndex        =   15
         Top             =   375
         Width           =   450
      End
   End
   Begin MSComctlLib.Toolbar Tlb_Movimiento 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   17
      Top             =   0
      Width           =   4890
      _ExtentX        =   8625
      _ExtentY        =   794
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Style           =   1
      ImageList       =   "Img_opciones"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Imprimir"
            ImageIndex      =   17
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Vista Previa"
            ImageIndex      =   18
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      Begin MSComctlLib.ImageList Img_opciones 
         Left            =   3720
         Top             =   0
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   24
         ImageHeight     =   24
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   25
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_VENCIMIENTOS.frx":2EFA
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_VENCIMIENTOS.frx":3361
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_VENCIMIENTOS.frx":3857
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_VENCIMIENTOS.frx":3CEA
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_VENCIMIENTOS.frx":41D2
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_VENCIMIENTOS.frx":46E5
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_VENCIMIENTOS.frx":4C22
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_VENCIMIENTOS.frx":5064
               Key             =   ""
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_VENCIMIENTOS.frx":551E
               Key             =   ""
            EndProperty
            BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_VENCIMIENTOS.frx":59F1
               Key             =   ""
            EndProperty
            BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_VENCIMIENTOS.frx":5E35
               Key             =   ""
            EndProperty
            BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_VENCIMIENTOS.frx":639C
               Key             =   ""
            EndProperty
            BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_VENCIMIENTOS.frx":686B
               Key             =   ""
            EndProperty
            BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_VENCIMIENTOS.frx":6C8A
               Key             =   ""
            EndProperty
            BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_VENCIMIENTOS.frx":7182
               Key             =   ""
            EndProperty
            BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_VENCIMIENTOS.frx":757B
               Key             =   ""
            EndProperty
            BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_VENCIMIENTOS.frx":79FE
               Key             =   ""
            EndProperty
            BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_VENCIMIENTOS.frx":7EC4
               Key             =   ""
            EndProperty
            BeginProperty ListImage19 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_VENCIMIENTOS.frx":83BB
               Key             =   ""
            EndProperty
            BeginProperty ListImage20 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_VENCIMIENTOS.frx":8871
               Key             =   ""
            EndProperty
            BeginProperty ListImage21 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_VENCIMIENTOS.frx":8C36
               Key             =   ""
            EndProperty
            BeginProperty ListImage22 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_VENCIMIENTOS.frx":902C
               Key             =   ""
            EndProperty
            BeginProperty ListImage23 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_VENCIMIENTOS.frx":9423
               Key             =   ""
            EndProperty
            BeginProperty ListImage24 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_VENCIMIENTOS.frx":982C
               Key             =   ""
            EndProperty
            BeginProperty ListImage25 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_RPT_VENCIMIENTOS.frx":9CEA
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Reportes"
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
      Height          =   1815
      Left            =   150
      TabIndex        =   18
      Top             =   1785
      Width           =   4590
      Begin VB.PictureBox SinCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   4
         Left            =   1245
         ScaleHeight     =   330
         ScaleWidth      =   375
         TabIndex        =   20
         Top             =   1800
         Visible         =   0   'False
         Width           =   375
      End
      Begin VB.PictureBox ConCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   4
         Left            =   3720
         ScaleHeight     =   330
         ScaleWidth      =   330
         TabIndex        =   19
         Top             =   1440
         Visible         =   0   'False
         Width           =   330
      End
      Begin VB.PictureBox SinCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   0
         Left            =   630
         Picture         =   "FRM_RPT_VENCIMIENTOS.frx":A1AB
         ScaleHeight     =   330
         ScaleWidth      =   375
         TabIndex        =   5
         Top             =   360
         Width           =   375
      End
      Begin VB.PictureBox ConCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   0
         Left            =   3705
         Picture         =   "FRM_RPT_VENCIMIENTOS.frx":A513
         ScaleHeight     =   330
         ScaleWidth      =   330
         TabIndex        =   7
         Top             =   360
         Visible         =   0   'False
         Width           =   330
      End
      Begin VB.PictureBox SinCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   1
         Left            =   630
         Picture         =   "FRM_RPT_VENCIMIENTOS.frx":A899
         ScaleHeight     =   330
         ScaleWidth      =   375
         TabIndex        =   8
         Top             =   720
         Width           =   375
      End
      Begin VB.PictureBox SinCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   2
         Left            =   630
         Picture         =   "FRM_RPT_VENCIMIENTOS.frx":AC01
         ScaleHeight     =   330
         ScaleWidth      =   375
         TabIndex        =   11
         Top             =   1080
         Width           =   375
      End
      Begin VB.PictureBox ConCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   1
         Left            =   3705
         Picture         =   "FRM_RPT_VENCIMIENTOS.frx":AF69
         ScaleHeight     =   330
         ScaleWidth      =   330
         TabIndex        =   10
         Top             =   720
         Visible         =   0   'False
         Width           =   330
      End
      Begin VB.PictureBox ConCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   2
         Left            =   3705
         Picture         =   "FRM_RPT_VENCIMIENTOS.frx":B2EF
         ScaleHeight     =   330
         ScaleWidth      =   330
         TabIndex        =   13
         Top             =   1080
         Visible         =   0   'False
         Width           =   330
      End
      Begin VB.Label Etiqueta 
         AutoSize        =   -1  'True
         Caption         =   "Letras Hipotecarias"
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
         Index           =   5
         Left            =   1815
         TabIndex        =   21
         Top             =   1845
         Visible         =   0   'False
         Width           =   1605
      End
      Begin VB.Label Etiqueta 
         AutoSize        =   -1  'True
         Caption         =   "Bonos"
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
         Left            =   1230
         TabIndex        =   6
         Top             =   405
         Width           =   525
      End
      Begin VB.Label Etiqueta 
         AutoSize        =   -1  'True
         Caption         =   "Créditos Corfo"
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
         Index           =   1
         Left            =   1230
         TabIndex        =   9
         Top             =   765
         Width           =   1230
      End
      Begin VB.Label Etiqueta 
         AutoSize        =   -1  'True
         Caption         =   "Créditos Locales"
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
         Left            =   1230
         TabIndex        =   12
         Top             =   1125
         Width           =   1410
      End
   End
End
Attribute VB_Name = "FRM_RPT_VENCIMIENTOS"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim Sql As String
Dim Datos()
Dim TCartera As String
Dim tipo As String
Dim cOptLocal As String
Const ForeSeleccion = &H8000000E
Const BackSeleccion = &H8000000D
Const ForeNormal = &H80000007
Const BackNormal = &H8000000F


Private Sub Generar_Listado(cTipo_Salida As String)
   
   Dim nContador        As Integer
   Dim cFecha_Desde     As String
   Dim cFecha_Hasta     As String
   Dim Titulo                             As String
   Dim bExisten_Marcados                  As Boolean
   Dim cNombre_rpt    As String
   
  On Error GoTo Control:

'   Call objCentralizacion.Chequeo_Estado(GLB_Sistema, cOptLocal, False)
    Call Chequeo_Estado(GLB_Sistema, cOptLocal, False)
   
'   If Not objCentralizacion.Estado And (objCentralizacion.Error = 0 Or objCentralizacion.Error = 300) Then
   
            Screen.MousePointer = 11
            bExisten_Marcados = False
            
            If cTipo_Salida = "Impresora" Then
            
                FRM_MDI_PASIVO.Pasivo_Rpt.Destination = 1
                cTipo_Salida = "P"
            
            Else
                
                FRM_MDI_PASIVO.Pasivo_Rpt.Destination = 0
                cTipo_Salida = "V"
            
            End If
         
          
            For nContador = 0 To 4
            
               If ConCheck.Item(nContador).Visible = True Then
                  
                  bExisten_Marcados = True
               
               End If
            
            Next nContador
             
            If bExisten_Marcados = False Then
            
               MsgBox "Debe Seleccionar Tipo de Listado ", vbInformation
               Screen.MousePointer = vbDefault
               Exit Sub
            
            End If
         
          
         cFecha_Desde = Format(TxtFecProc.Text, "yyyymmdd")
         cFecha_Hasta = Format(TxtFecProx.Text, "yyyymmdd")
          
            
          If UCase(cOptLocal) = "OPCION_MENU_4301" Then
               cNombre_rpt = "RPT_VENCIMIENTOS_DIARIOS.RPT"
          Else
              cNombre_rpt = "RPT_VENCIMIENTOS_FUTUROS.RPT"
                       cFecha_Desde = Format(TxtFecProc.Text, "yyyymmdd")
                       cFecha_Hasta = Format(TxtFecProx.Text, "yyyymmdd")
          End If
             
         If ConCheck.Item(0).Visible = True Then
               Call PROC_LIMPIAR_CRISTAL
                     
               FRM_MDI_PASIVO.Pasivo_Rpt.ReportFileName = GLB_Ubicacion_Reporte & cNombre_rpt
               PROC_ESTABLECE_UBICACION FRM_MDI_PASIVO.Pasivo_Rpt.RetrieveDataFiles, FRM_MDI_PASIVO.Pasivo_Rpt
               FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(0) = cFecha_Desde
               FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(1) = cFecha_Hasta
               FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(2) = "BONOS"
               FRM_MDI_PASIVO.Pasivo_Rpt.Formulas(0) = "xUsuario='" & GLB_Usuario & "'"
               FRM_MDI_PASIVO.Pasivo_Rpt.Connect = GLB_CONECCION
               FRM_MDI_PASIVO.Pasivo_Rpt.Action = 1
               
               
               Call PROC_LOG_AUDITORIA("10", cOptLocal, Me.Caption & " Informe de Vencimientos de Bonos Proyectados: " & TxtFecProc.Text, "", "")
         
         
         End If

         If ConCheck.Item(1).Visible = True Then
               Call PROC_LIMPIAR_CRISTAL
                     
               
               FRM_MDI_PASIVO.Pasivo_Rpt.ReportFileName = GLB_Ubicacion_Reporte & cNombre_rpt
               PROC_ESTABLECE_UBICACION FRM_MDI_PASIVO.Pasivo_Rpt.RetrieveDataFiles, FRM_MDI_PASIVO.Pasivo_Rpt
               FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(0) = cFecha_Desde
               FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(1) = cFecha_Hasta
               FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(2) = "CORFO"
               FRM_MDI_PASIVO.Pasivo_Rpt.Formulas(0) = "xUsuario='" & GLB_Usuario & "'"
               FRM_MDI_PASIVO.Pasivo_Rpt.Connect = GLB_CONECCION
               FRM_MDI_PASIVO.Pasivo_Rpt.Action = 1
               
               
               Call PROC_LOG_AUDITORIA("10", cOptLocal, Me.Caption & " Informe de Vencimientos de Bonos Proyectados: " & TxtFecProc.Text, "", "")
         
         
         End If
         
         
         If ConCheck.Item(2).Visible = True Then
               Call PROC_LIMPIAR_CRISTAL
                     
               
               FRM_MDI_PASIVO.Pasivo_Rpt.ReportFileName = GLB_Ubicacion_Reporte & cNombre_rpt
               PROC_ESTABLECE_UBICACION FRM_MDI_PASIVO.Pasivo_Rpt.RetrieveDataFiles, FRM_MDI_PASIVO.Pasivo_Rpt
               FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(0) = cFecha_Desde
               FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(1) = cFecha_Hasta
               FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(2) = "LOCAL"
               FRM_MDI_PASIVO.Pasivo_Rpt.Formulas(0) = "xUsuario='" & GLB_Usuario & "'"
               FRM_MDI_PASIVO.Pasivo_Rpt.Connect = GLB_CONECCION
               FRM_MDI_PASIVO.Pasivo_Rpt.Action = 1
               
               
               Call PROC_LOG_AUDITORIA("10", cOptLocal, Me.Caption & " Informe de Vencimientos de Bonos Proyectados: " & TxtFecProc.Text, "", "")
         
         
         End If
         
         
         If ConCheck.Item(4).Visible = True Then
               Call PROC_LIMPIAR_CRISTAL
                     
               
               FRM_MDI_PASIVO.Pasivo_Rpt.ReportFileName = GLB_Ubicacion_Reporte & cNombre_rpt
               PROC_ESTABLECE_UBICACION FRM_MDI_PASIVO.Pasivo_Rpt.RetrieveDataFiles, FRM_MDI_PASIVO.Pasivo_Rpt
               FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(0) = cFecha_Desde
               FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(1) = cFecha_Hasta
               FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(2) = "EXTRA"
               FRM_MDI_PASIVO.Pasivo_Rpt.Formulas(0) = "xUsuario='" & GLB_Usuario & "'"
               FRM_MDI_PASIVO.Pasivo_Rpt.Connect = GLB_CONECCION
               FRM_MDI_PASIVO.Pasivo_Rpt.Action = 1
               
               
               Call PROC_LOG_AUDITORIA("10", cOptLocal, Me.Caption & " Informe de Vencimientos de Bonos Proyectados: " & TxtFecProc.Text, "", "")
         
         
         End If
         
         If ConCheck.Item(4).Visible = True Then
               Call PROC_LIMPIAR_CRISTAL
                     
               FRM_MDI_PASIVO.Pasivo_Rpt.ReportFileName = GLB_Ubicacion_Reporte & cNombre_rpt
               PROC_ESTABLECE_UBICACION FRM_MDI_PASIVO.Pasivo_Rpt.RetrieveDataFiles, FRM_MDI_PASIVO.Pasivo_Rpt
               FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(0) = cFecha_Desde
               FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(1) = cFecha_Hasta
               FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(2) = "LETRA"
               FRM_MDI_PASIVO.Pasivo_Rpt.Formulas(0) = "xUsuario='" & GLB_Usuario & "'"
               FRM_MDI_PASIVO.Pasivo_Rpt.Connect = GLB_CONECCION
               FRM_MDI_PASIVO.Pasivo_Rpt.Action = 1
               
               
               Call PROC_LOG_AUDITORIA("10", cOptLocal, Me.Caption & " Informe de Vencimientos de Bonos Proyectados: " & TxtFecProc.Text, "", "")
         
         
         End If
         Screen.MousePointer = 0
   
   
'   Else
'         MsgBox objCentralizacion.Mensaje, vbExclamation
'
'   End If

Exit Sub

Control:

   Call PROC_LOG_AUDITORIA("10", cOptLocal, Me.Caption & " Error al emitir reporte- Informe de Listado de Movimientos- Fecha Proceso: " & TxtFecProc.Text, "", "")
   MsgBox "Problemas al generar Listado de Movimientos. " & Err.Description, vbCritical

   Screen.MousePointer = 0
   
End Sub

Private Sub Form_Activate()

   PROC_CARGA_AYUDA Me

End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)

Dim nOpcion As Integer

    If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) Then

        Select Case KeyCode
            
            Case VbKeyImprimir 'Imprimir
                
                nOpcion = 1
            
            Case vbKeyVistaPrevia 'Vista Previa
                
                nOpcion = 2
            
            Case vbKeySalir 'Salir
                
                nOpcion = 3
        
        End Select
        
        If nOpcion > 0 Then
            
            If Tlb_Movimiento.Buttons(nOpcion).Enabled Then
                
                Tlb_Movimiento_ButtonClick Tlb_Movimiento.Buttons(nOpcion)
            
            End If
        
        End If
    
    End If

End Sub

Private Sub Form_Load()

Dim X As Integer

    Me.Icon = FRM_MDI_PASIVO.Icon
    TxtFecProc.Text = GLB_Fecha_Proceso
    TxtFecProx.Text = GLB_Fecha_Proxima
    Me.top = 0
    Me.left = 0
  
    Screen.MousePointer = 11
    giAceptar% = False
    
    Screen.MousePointer = 0
    cOptLocal = GLB_Opcion_Menu
    DoEvents
    
   If UCase(cOptLocal) = "OPCION_MENU_4301" Then
   
      TxtFecProc.Text = GLB_Fecha_Proceso
      TxtFecProx.Text = GLB_Fecha_Proceso
      Me.Caption = "Vencimientos del Día"
      lblEtiqueta(0).Visible = False
      TxtFecProx.Visible = False
      lblEtiqueta(1).left = 500
      SinCheck(3).left = 1200
      Etiqueta(3).left = 1800
      lblEtiqueta(1).Caption = "Fecha de Cartera"
      TxtFecProc.left = 2100
      TxtFecProc.Width = 1500
      lblEtiqueta(1).left = 150
      
   Else
      
      Me.Caption = "Vencimientos Proyectados"
      Frame3.Caption = "Fechas de Proyeccion"
      TxtFecProc.Text = GLB_Fecha_Proceso
      TxtFecProx.Text = GLB_Fecha_Proxima
   End If
   
    Etiqueta(3).Visible = False
    Me.ConCheck(3).Visible = False
    Me.SinCheck(3).Visible = False
    
    Call PROC_LOG_AUDITORIA("07", cOptLocal, Me.Caption, "", "")

End Sub

Private Sub Form_Unload(Cancel As Integer)

   Call PROC_LOG_AUDITORIA("08", cOptLocal, Me.Caption, "", "")
   
End Sub

Private Sub Tlb_Movimiento_ButtonClick(ByVal Button As MSComctlLib.Button)

   
   Select Case Button.Index

   Case 1
      
      If PROC_VALIDA_FECHAS = False Then Exit Sub
      
      Call Generar_Listado("Impresora")

   Case 2
      
      If PROC_VALIDA_FECHAS = False Then Exit Sub
      
      Call Generar_Listado("Pantalla")

   Case 3
   
      Unload Me

   End Select

End Sub

Function PROC_VALIDA_FECHAS() As Boolean

   PROC_VALIDA_FECHAS = False
   
   If UCase(cOptLocal) = "OPCION_MENU_4302" Then
    
      If CDate(TxtFecProx.Text) < CDate(TxtFecProc.Text) Then
      
         MsgBox "Fecha hasta debe ser mayor a fecha desde.", vbInformation
         TxtFecProx.SetFocus
         Exit Function
         
'      ElseIf FUNC_VALIDA_FECHA_FERIADO(GLB_nPais_Chile, GLB_nPlaza_Stgo, CDate(TxtFecProc.Text)) Then
'
'         MsgBox "No puede seleccionar una fecha que sea feriado.", vbInformation
'         TxtFecProc.SetFocus
'         Exit Function
'
'      ElseIf FUNC_VALIDA_FECHA_FERIADO(GLB_nPais_Chile, GLB_nPlaza_Stgo, CDate(TxtFecProx.Text)) Then
'
'         MsgBox "No puede seleccionar una fecha que sea feriado.", vbInformation
'         TxtFecProc.SetFocus
'         Exit Function
'
      End If

'   Else
'
'    '  If FUNC_VALIDA_FECHA_FERIADO(GLB_nPais_Chile, GLB_nPlaza_Stgo, CDate(TxtFecProc.Text)) Then
'     If FUNC_VALIDA_FECHA_FERIADO(CDate(TxtFecProc.Text), GLB_nPlaza_Stgo, 0) Then
'
'         MsgBox "No puede seleccionar una fecha que sea feriado.", vbInformation
'         TxtFecProc.SetFocus
'         Exit Function
''
   '   End If
            
   End If
   
   PROC_VALIDA_FECHAS = True
   
End Function

Private Sub TxtFecProc_KeyPress(KeyAscii As Integer)
   
    If KeyAscii = 13 Then
        
        FUNC_ENVIA_TECLA (vbKeyTab)
    
    End If

End Sub

Private Sub TxtFecProx_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
        
        FUNC_ENVIA_TECLA (vbKeyTab)
    
    End If

End Sub

Private Sub SinCheck_Click(Index As Integer)
    
    ConCheck.Item(Index).left = SinCheck.Item(Index).left
    SinCheck.Item(Index).Visible = Not SinCheck.Item(Index).Visible
    ConCheck.Item(Index).Visible = Not ConCheck.Item(Index).Visible
    DoEvents
    ConCheck.Item(Index).SetFocus

End Sub
Private Sub SinCheck_GotFocus(Index As Integer)
      
      Etiqueta(Index).BackColor = BackSeleccion
      Etiqueta(Index).ForeColor = ForeSeleccion

End Sub

Private Sub SinCheck_KeyPress(Index As Integer, KeyAscii As Integer)
    
    If KeyAscii = 109 Or KeyAscii = 32 Then
        
        SinCheck_Click (Index)
    
    End If
    
    If KeyAscii = 13 Then
        
        FUNC_ENVIA_TECLA (vbKeyTab)
    
    End If

End Sub

Private Sub SinCheck_LostFocus(Index As Integer)

      Etiqueta(Index).BackColor = BackNormal
      Etiqueta(Index).ForeColor = ForeNormal

End Sub

Private Sub ConCheck_Click(Index As Integer)

   SinCheck.Item(Index).Visible = Not SinCheck.Item(Index).Visible
   ConCheck.Item(Index).Visible = Not ConCheck.Item(Index).Visible
   DoEvents
   SinCheck.Item(Index).SetFocus
   
End Sub

Private Sub ConCheck_GotFocus(Index As Integer)

      Etiqueta(Index).BackColor = BackSeleccion
      Etiqueta(Index).ForeColor = ForeSeleccion

End Sub

Private Sub ConCheck_KeyPress(Index As Integer, KeyAscii As Integer)
    
    If KeyAscii = 109 Or KeyAscii = 32 Then
        
        ConCheck_Click (Index)
    
    End If
    
    If KeyAscii = 13 Then
        
        FUNC_ENVIA_TECLA (vbKeyTab)
    
    End If

End Sub

Private Sub ConCheck_LostFocus(Index As Integer)

      Etiqueta(Index).BackColor = BackNormal
      Etiqueta(Index).ForeColor = ForeNormal

End Sub


