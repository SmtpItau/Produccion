VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacIniDia 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Parámetros Diarios"
   ClientHeight    =   4545
   ClientLeft      =   60
   ClientTop       =   2010
   ClientWidth     =   9870
   ForeColor       =   &H00C0C0C0&
   Icon            =   "Bacinidi.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4545
   ScaleWidth      =   9870
   Begin VB.Frame Frame1 
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
      Height          =   2955
      Left            =   60
      TabIndex        =   10
      Top             =   1485
      Width           =   3315
      Begin VB.CheckBox Chk_Valutas 
         Caption         =   "Vencimiento de Valutas"
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
         Height          =   345
         Left            =   100
         TabIndex        =   5
         Top             =   1425
         Width           =   2475
      End
      Begin VB.CheckBox Chk_fechas 
         Caption         =   "Actualización de Fechas"
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
         Height          =   345
         Left            =   100
         TabIndex        =   4
         Top             =   1005
         Width           =   2475
      End
      Begin VB.CheckBox Chk_Moneda 
         Caption         =   "Actualización de Monedas"
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
         Height          =   345
         Left            =   100
         TabIndex        =   3
         Top             =   585
         Width           =   2580
      End
      Begin VB.Label Label1 
         Caption         =   "Procesos Realizados"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   330
         Left            =   210
         TabIndex        =   15
         Top             =   240
         Width           =   2460
      End
      Begin VB.Label lbl_Valu 
         Alignment       =   2  'Center
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
         Height          =   300
         Left            =   2730
         TabIndex        =   13
         Top             =   1440
         Width           =   480
      End
      Begin VB.Label Lbl_Fec 
         Alignment       =   2  'Center
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
         Height          =   300
         Left            =   2730
         TabIndex        =   12
         Top             =   1020
         Width           =   480
      End
      Begin VB.Label lbl_Mon 
         Alignment       =   2  'Center
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
         Height          =   300
         Left            =   2730
         TabIndex        =   11
         Top             =   600
         Width           =   480
      End
   End
   Begin VB.Frame frmmonedas 
      Caption         =   "Valores De Monedas"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000D&
      Height          =   3810
      Left            =   3420
      TabIndex        =   8
      Top             =   630
      Width           =   6420
      Begin BACControles.TXTNumero text1 
         Height          =   255
         Left            =   1140
         TabIndex        =   14
         Top             =   600
         Visible         =   0   'False
         Width           =   960
         _ExtentX        =   1693
         _ExtentY        =   450
         BackColor       =   12632256
         ForeColor       =   16711680
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
         Text            =   "0.0000"
         Text            =   "0.0000"
         Min             =   "0"
         Max             =   "999999.9999"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
      End
      Begin MSFlexGridLib.MSFlexGrid Grilla 
         Height          =   3450
         Left            =   105
         TabIndex        =   9
         Top             =   270
         Width           =   6210
         _ExtentX        =   10954
         _ExtentY        =   6085
         _Version        =   393216
         Cols            =   5
         FixedCols       =   0
         BackColor       =   12632256
         ForeColor       =   12582912
         BackColorFixed  =   8421376
         ForeColorFixed  =   16777215
         BackColorSel    =   8388608
         ForeColorSel    =   8388608
         GridColor       =   255
         GridColorFixed  =   8421504
         FillStyle       =   1
         GridLines       =   2
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
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   1
      Top             =   0
      Width           =   9870
      _ExtentX        =   17410
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdBuscar"
            Description     =   "Buscar"
            Object.ToolTipText     =   "Buscar Datos"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdGrabar"
            Description     =   "Grabar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdLimpiar"
            Description     =   "Limpiar"
            Object.ToolTipText     =   "Limpiar Pantalla"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdSalir"
            Description     =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   4
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   2490
      Top             =   105
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
            Picture         =   "Bacinidi.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacinidi.frx":075C
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacinidi.frx":0BAE
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacinidi.frx":0EC8
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin BACControles.TXTFecha TxtFecProx 
      Height          =   315
      Left            =   1545
      TabIndex        =   2
      Top             =   765
      Width           =   1245
      _ExtentX        =   2196
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
      Text            =   "07/11/2000"
   End
   Begin BACControles.TXTFecha TxtFecPro 
      Height          =   315
      Left            =   120
      TabIndex        =   0
      Top             =   765
      Width           =   1245
      _ExtentX        =   2196
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
      Text            =   "07/11/2000"
   End
   Begin VB.Label Lbl_FecPrx 
      Alignment       =   2  'Center
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   300
      Left            =   1560
      TabIndex        =   6
      Top             =   1125
      Width           =   1245
   End
   Begin VB.Label Lbl_FecPro 
      Alignment       =   2  'Center
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   300
      Left            =   120
      TabIndex        =   7
      Top             =   1125
      Width           =   1245
   End
End
Attribute VB_Name = "BacIniDia"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim Status_Dev             As String         'Estado del devengamiento
                                             '  0: Proceso OK
                                             '  1: Problemas en la ejecución y
                                             '  2:Problema en el devengamiento
Dim Mensaje_Dev            As String         'Mensaje devengamiento
Dim Retorno_Dev            As String         'Retorno del procedimiento del devengamiento
Dim swDevengo              As String         'Flag que identifica si esta devengado
Dim Fecha_Proceso_Dev      As String         'Fecha Proceso del devengo
Dim Fecha_Proximo_Dev      As String         'Fecha Proximo Proceso del devengo
Dim Fecha_Cierre_Mes       As String         'Cierre de Mes
Dim Fecha_Proceso          As String         'Fecha Proceso
Dim Fecha_Anterior         As String         'Fecha Proceso
Dim Fecha_Proximo_Proceso  As String         'Fecha Proximo Proceso
Dim valPCDUSD              As Double
Dim valPCDUF               As Double
Dim valPTF                 As Double

Dim cCategoria             As Single
Dim cTasa                  As Single
Dim cFecpro                As String
Dim cFecprox               As String
Dim cSW_PD                 As String
Private objMensajesPD      As Object
Dim bFlagEdit              As Boolean
Dim bParidadesBCCH         As Boolean

Dim Vcol%
Dim i%
Dim mens1$
Dim j%
Dim a1%
Dim nPos%
Dim ContOp$
Dim VCodigo$
Dim VGlosa$
Dim KeyAscii%
'
Dim sDia
'

'Variables utilizadas en Sql Server
Dim Sql                    As String
Dim Datos()

Function FuncProcesaValutas() As Boolean

    FuncProcesaValutas = False
    
    
    Screen.MousePointer = vbHourglass

    If Not Bac_Sql_Execute("SVA_IND_ACT_VLU") Then
        Screen.MousePointer = vbDefault
        Exit Function
    End If
    
    Chk_Valutas.Value = 1
    lbl_Valu.Caption = "OK"
    
        
    FuncProcesaValutas = True
    Screen.MousePointer = vbDefault

End Function



Function FuncActualizaCartera() As Boolean

    FuncActualizaCartera = False
    
    Screen.MousePointer = vbHourglass

    envia = Array()
    AddParam envia, gsBac_Fecp

    If Not Bac_Sql_Execute("SVA_IND_ACT_CAR", envia) Then
        Screen.MousePointer = vbDefault
        Exit Function
    End If
    
    envia = Array()
    AddParam envia, GLB_ID_SISTEMA

    If Not Bac_Sql_Execute("BACTRADERSUDA..SP_ACT_CARTERA_LIBRE_TRADING", envia) Then
        Screen.MousePointer = vbDefault
        Exit Function
    End If
        
    FuncActualizaCartera = True
    Screen.MousePointer = vbDefault

End Function

Function FuncActualizaDolarFinMes() As Boolean

    FuncActualizaDolarFinMes = False
    
    Screen.MousePointer = vbHourglass

    If Month(Fecha_Proceso) <> Month(Fecha_Anterior) Then
        envia = Array()
        AddParam envia, Fecha_Anterior
      
        If Bac_Sql_Execute("sp_ActDolarFinMes", envia) Then
            If Bac_SQL_Fetch(Datos()) <> 0 Then
                If Datos(1) = 0 Then
                    MsgBox "Dólar Obs. del último día hábil del Mes Anterior tiene Valor 0", vbCritical, "Bonos Exterior"
                    
                    Screen.MousePointer = vbDefault
                    Exit Function
                End If
            
            End If
            
        End If
    
    End If
    
    FuncActualizaDolarFinMes = True
    Screen.MousePointer = vbDefault

End Function


Private Sub Func_Grabar_Datos()
'On Error GoTo Label1

Dim iRow             As Long
Dim cCodigo          As Integer
Dim nValor           As Double
Dim nCodBcch         As Integer
Dim objValoresMoneda As Object
Dim bOk              As Boolean

    Screen.MousePointer = vbHourglass

    If BacChkFechas() = False Then
        Screen.MousePointer = vbDefault
        MsgBox "Error en Fecha de proceso o Fecha de próximo proceso", vbExclamation, gsBac_Version
       ''On Error GoTo 0
        Exit Sub
    End If

    Set objValoresMoneda = New clsValoresMoneda


    If objValoresMoneda.Grabar() = True Then
    
    
        Chk_Moneda.Value = 1
        lbl_Mon.Caption = "OK"

        bOk = False

        If Not Bac_Sql_Execute("BEGIN TRANSACTION") Then
            MsgBox "Error", vbCritical, gsBac_Version
        End If

        cFecpro = CStr(TxtFecPro.Text)
        cFecprox = CStr(TxtFecProx.Text)

        If Not BacGrabarParamAc(cFecpro, cFecprox) Then
            GoTo Error_Proceso
        End If


        If Not FuncActualizaCartera Then
            GoTo Error_Proceso
        End If

       
        If Not FuncProcesaValutas Then
            GoTo Error_Proceso
        End If

        Fecha_Proceso = cFecpro 'cFecprox
        Fecha_Anterior = gsBac_Fecp 'cFecpro
        If Not FuncActualizaDolarFinMes Then
            GoTo Error_Proceso
        End If
        
        
        If Not Bac_Sql_Execute("COMMIT TRANSACTION") Then
            MsgBox "Error", vbCritical, gsBac_Version
        End If
       
        '+++CONTROL IDD, jcamposd, realiza la llamada al recalculo pero el sp realiza un return
        If Not Bac_Sql_Execute("SP_RECALC_LINEAS_INV") Then
            MsgBox "Error: al cargar Lineas", vbCritical, gsBac_Version
        End If
        
        
        Call Proc_Carga_Parametros

        Toolbar1.Buttons(2).Enabled = False
        MsgBox "Parámetros diarios grabados satisfactoriamente.", vbInformation, gsBac_Version
        Toolbar1.Buttons(1).Enabled = False
        Toolbar1.Buttons(2).Enabled = False
        Toolbar1.Buttons(3).Enabled = False
        
    Else
        MsgBox "Parámetros diarios no se pueden grabar.", vbCritical, gsBac_Version
        Unload Me
    End If

    Set objValoresMoneda = Nothing
    Screen.MousePointer = vbDefault

   ''On Error GoTo 0
   
    'Generar reporte de inicio de día
    Call limpiar_cristal
'    BacTrader.bacrpt.ReportFileName = RptList_Path & "Inf_InicioDia.rpt"
'    BacTrader.bacrpt.Destination = crptToPrinter
'    BacTrader.bacrpt.Formulas(0) = "Proceso = '" & Trim(cFecpro) & "'"
'    BacTrader.bacrpt.Formulas(1) = "ProcesoDA = '" & Grilla.TextMatrix(4, 1) & "'"
'    BacTrader.bacrpt.Formulas(2) = "ProcesoDO = '" & Grilla.TextMatrix(3, 1) & "'"
'    BacTrader.bacrpt.Formulas(3) = "ProcesoIVP = '" & Grilla.TextMatrix(2, 1) & "'"
'    BacTrader.bacrpt.Formulas(4) = "ProcesoUF = '" & Grilla.TextMatrix(1, 1) & "'"
'    BacTrader.bacrpt.Formulas(5) = "Proximo = '" & cFecprox & "'"
'    BacTrader.bacrpt.Formulas(6) = "ProximoDA = '" & Grilla.TextMatrix(4, 2) & "'"
'    BacTrader.bacrpt.Formulas(7) = "ProximoDO = '" & Grilla.TextMatrix(3, 2) & "'"
'    BacTrader.bacrpt.Formulas(8) = "ProximoIVP = '" & Grilla.TextMatrix(2, 2) & "'"
'    BacTrader.bacrpt.Formulas(9) = "ProximoUF = '" & Grilla.TextMatrix(1, 2) & "'"
'    BacTrader.bacrpt.Formulas(10) = "Recompras= '" & Label1.Caption & "'"
'    BacTrader.bacrpt.Formulas(11) = "Reventas = '" & Label2.Caption & "'"
'    BacTrader.bacrpt.Formulas(12) = "Vencimientos = '" & Label3.Caption & "'"
'    BacTrader.bacrpt.Connect = CONECCION
'    BacTrader.bacrpt.Action = 1
    
    
    Exit Sub


Label1:
    Screen.MousePointer = vbDefault
    Call objMensajesPD.BacMsgError
    Exit Sub
    
Error_Proceso:
    If Not Bac_Sql_Execute("ROLLBACK TRANSACTION") Then
        MsgBox "Error", vbCritical, gsBac_Version
    End If

    Screen.MousePointer = vbDefault
    MsgBox "Problemas En Proceso, Inicio de Día no Será Efectuado", vbCritical, gsBac_Version
    Call Proc_Carga_Parametros
    Toolbar1.Buttons(1).Enabled = False
    Toolbar1.Buttons(2).Enabled = False
    
End Sub
Sub limpiar_cristal()
Dim i As Integer
   For i = 0 To 20
       ' BacTrader.bacrpt.StoredProcParam(I) = ""
       ' BacTrader.bacrpt.Formulas(I) = ""
   Next i
   
'   BacTrader.bacrpt.WindowTitle = ""

End Sub
Private Sub Func_Limpiar_Pantalla()

  ''On Error GoTo Label1

   grilla.Rows = 2
   Call F_BacLimpiaGrilla(grilla)

   grilla.Enabled = False
   Toolbar1.Buttons(3).Enabled = True
   Toolbar1.Buttons(2).Enabled = False
   TxtFecPro.Enabled = False
   TxtFecProx.Enabled = False
   TxtFecPro.Text = cFecpro
   TxtFecProx.Text = cFecprox
   Lbl_FecPrx.Caption = ""
   Lbl_FecPro.Caption = ""
   'ChKact.Value = 0
   'ChkRc.Value = 0
   'Chkrv.Value = 0
   'ChkVenCap.Value = 0
   frmmonedas.Enabled = False

  ''On Error GoTo 0
   Exit Sub

Label1:
  ''On Error GoTo 0
   Call objMensajesPD.BacMsgError

End Sub

Public Function F_BacLimpiaGrilla(ByRef ObjGril As Object)
 
 Dim Fila%, Col%

 With ObjGril
 
    For Fila% = 1 To .Rows - 1
        For Col% = 0 To .Cols - 1
            .TextMatrix(Fila%, Col%) = ""
        Next
    Next
    
 End With
    
End Function
Private Sub Func_Buscar_Datos()

  ''On Error GoTo Label1

   Dim Fila             As Long

   cFecpro = TxtFecPro.Text
   cFecprox = TxtFecProx.Text

   With grilla

      .Rows = 1
      
      If BacChkFechas() = False Then
         .Enabled = False
         Toolbar1.Buttons(2).Enabled = False
         Exit Sub

      End If
    
      If BacLeeParamPd(TxtFecPro.Text, TxtFecProx.Text, grilla) = True Then
         .Enabled = True
         Toolbar1.Buttons(2).Enabled = IIf(cSW_PD = "1", False, True)

      Else
         .Enabled = False
         Toolbar1.Buttons(2).Enabled = False

      End If
   
      TxtFecPro.Enabled = False
      TxtFecProx.Enabled = False

   End With

   frmmonedas.Enabled = IIf(cSW_PD = "1", False, True)

   Exit Sub

Label1:

   Call objMensajesPD.BacMsgError

End Sub

Private Function BacChkFechas() As Boolean

  ''On Error GoTo Label1

   BacChkFechas = True

   If Not BacChkFecpro() Then
      BacChkFechas = False
      Exit Function

   End If

   If Not BacChkFecprx() Then
      BacChkFechas = False

   End If

  ''On Error GoTo 0

   Exit Function

Label1:
  ''On Error GoTo 0
   Call objMensajesPD.BacMsgError

End Function

Function BacGrabarParamAc(cFecpro As String, cFecprox As String)


    BacGrabarParamAc = False

    envia = Array(Format(cFecpro, "YYYYMMDD"), Format(cFecprox, "YYYYMMDD"))
    
    If Not Bac_Sql_Execute("EXECUTE SVA_IND_GRB_PAT", envia) Then
        Exit Function
    End If

    Chk_fechas.Value = 1
    Lbl_Fec.Caption = "OK"


    BacGrabarParamAc = True

    Exit Function

End Function

Public Function BacLeeParamPd(Fechapro As String, Fechaprox As String, Grd As MSFlexGrid)
  ''On Error GoTo Label1

   BacLeeParamPd = False

   envia = Array(Fechapro, Fechaprox)

   If Not Bac_Sql_Execute("SVC_IND_LEE_MON", envia) Then
      
      Exit Function
   
   End If

   With Grd
        
      .Rows = 1
      
      Do While Bac_SQL_Fetch(Datos())
      
         .Rows = .Rows + 1
         
         .TextMatrix(.Rows - 1, 0) = Datos(2)
         .TextMatrix(.Rows - 1, 1) = Format(Datos(3), FDecimal)
         .TextMatrix(.Rows - 1, 2) = Format(Datos(4), FDecimal)
         .TextMatrix(.Rows - 1, 3) = Datos(1)
         .TextMatrix(.Rows - 1, 4) = Datos(5)
      
      Loop
        
      If .Rows > 1 Then
         
         Grd.Enabled = True
         
         .RowSel = 1
         .Col = 0
         .ColSel = 0
      
      End If

    End With
    
    BacLeeParamPd = True

   ''On Error GoTo 0

    Exit Function


Label1:
   ''On Error GoTo 0
    Call objMensajesPD.BacMsgError

End Function

Public Function BacLeerParamAc(ByRef cFecpro As String, ByRef cFecprox As String, ByRef cSW_PD As String) As Boolean

  ''On Error GoTo Label1

   BacLeerParamAc = False

   If Not Bac_Sql_Execute("SVC_IND_LEE_PAR") Then
      
      Exit Function

   End If

   If Bac_SQL_Fetch(Datos()) Then
      cFecpro = Datos(2)
      cFecprox = Datos(2)
      cSW_PD = Datos(3)
      cFecprox = Format(DateAdd("d", 1, cFecprox), "DD/MM/YYYY")

      BacLeerParamAc = True

   End If

   While WeekDay(cFecprox) = vbSunday Or WeekDay(cFecprox) = vbSaturday Or Not BacEsHabil(cFecprox)
      cFecprox = DateAdd("d", 1, cFecprox)

   Wend

    


   BacLeerParamAc = True

  ''On Error GoTo 0

   Exit Function

Label1:
  ''On Error GoTo 0
   Call objMensajesPD.BacMsgError

End Function

Private Function BacChkFecpro() As Boolean

  ''On Error GoTo Label1

   If BacEsHabil(TxtFecPro.Text) = True Then
      Lbl_FecPro.ForeColor = &H0&
      Lbl_FecPro.Caption = BacDiaSem(TxtFecPro.Text)
      BacChkFecpro = True

   Else
      If Month(TxtFecPro.Text) = Month(DateAdd("d", 1, TxtFecPro.Text)) Then
         Lbl_FecPro.ForeColor = &HFF&
         Lbl_FecPro.Caption = BacDiaSem(TxtFecPro.Text)
         MsgBox "Fecha proceso ingresada no es Día Hábil", vbOKOnly, gsBac_Version

      Else
         BacChkFecpro = True

      End If

   End If

  ''On Error GoTo 0
   Exit Function

Label1:
  ''On Error GoTo 0
   Call objMensajesPD.BacMsgError

End Function
Public Function BacDiaSem(sfec$) As String

    BacDiaSem = ""
    
    If IsDate(sfec$) Then
        Select Case WeekDay(sfec$)
            Case 1
                BacDiaSem = "Domingo"
            Case 2
                BacDiaSem = "Lunes"
            Case 3
                BacDiaSem = "Martes"
            Case 4
                BacDiaSem = "Miércoles"
            Case 5
                BacDiaSem = "Jueves"
            Case 6
                BacDiaSem = "Viernes"
            Case 7
                BacDiaSem = "Sábado"
        End Select
    End If

End Function

Function BacEsHabil(cFecha As String) As Boolean

Dim objFeriado As New clsFeriado

Dim iAno       As Integer
Dim iMes       As Integer
Dim cDia       As String
Dim gcPlaza    As String
Dim n          As Integer

            

            ' Temporalmente.-
            '-----------------
            'gcPlaza = "00997"
            gcPlaza = "00006"
            sDia = BacDiaSem(cFecha)
            If sDia = "Sábado" Or sDia = "Domingo" Then
                        BacEsHabil = False
                        Exit Function
            End If

            iAno = DatePart("yyyy", cFecha)
            iMes = DatePart("m", cFecha)
            cDia = Format(DatePart("d", cFecha), "00")

            objFeriado.Leer iAno, gcPlaza

            Select Case iMes
                   Case 1:  n = InStr(objFeriado.feene, cDia)
                   Case 2:  n = InStr(objFeriado.fefeb, cDia)
                   Case 3:  n = InStr(objFeriado.femar, cDia)
                   Case 4:  n = InStr(objFeriado.feabr, cDia)
                   Case 5:  n = InStr(objFeriado.femay, cDia)
                   Case 6:  n = InStr(objFeriado.fejun, cDia)
                   Case 7:  n = InStr(objFeriado.fejul, cDia)
                   Case 8:  n = InStr(objFeriado.feago, cDia)
                   Case 9:  n = InStr(objFeriado.fesep, cDia)
                   Case 10: n = InStr(objFeriado.feoct, cDia)
                   Case 11: n = InStr(objFeriado.fenov, cDia)
                   Case 12: n = InStr(objFeriado.fedic, cDia)
            End Select

            Set objFeriado = Nothing

            If n > 0 Then
                 BacEsHabil = False
            Else
                 BacEsHabil = True
            End If


End Function

Private Function BacChkFecprx() As Boolean

  ''On Error GoTo Label1

   If DateDiff("d", CDate(TxtFecPro.Text), CDate(TxtFecProx.Text)) <= 0 Then
      MsgBox "Fecha próximo proceso menor o igual a la de proceso?", vbOKOnly, gsBac_Version
      BacChkFecprx = False
      Exit Function

   End If

   If BacEsHabil(TxtFecProx.Text) = True Then
      Lbl_FecPrx.ForeColor = &H0&
      Lbl_FecPrx.Caption = BacDiaSem(TxtFecProx.Text)
      BacChkFecprx = True

   Else
      If Month(TxtFecProx.Text) = Month(DateAdd("d", 1, TxtFecProx.Text)) Then
         Lbl_FecPrx.ForeColor = &HFF&
         Lbl_FecPrx.Caption = BacDiaSem(TxtFecProx.Text)
         MsgBox "Fecha próximo proceso ingresada no es Día Hábil", vbOKOnly, gsBac_Version
         BacChkFecprx = False

      Else
         BacChkFecprx = True

      End If

   End If

  ''On Error GoTo 0
   Exit Function

Label1:
  ''On Error GoTo 0
   Call objMensajesPD.BacMsgError

End Function


Private Sub Form_Activate()

  ''On Error GoTo Label1

   Screen.MousePointer = 0

   Call CargarParam_Grilla(grilla)

  ' Me.Height = 2070
   frmmonedas.Enabled = False

  ''On Error GoTo 0

   Exit Sub

Label1:
  ''On Error GoTo 0
   Call objMensajesPD.BacMsgError

End Sub

Private Sub Form_Load()

   Set objMensajesPD = New ClsMsg

  ''On Error GoTo Label1

   'Lee Parametros.-
   Me.tag = ""

   cCategoria = 21
   cTasa = 0

   If BacLeerParamAc(cFecpro, cFecprox, cSW_PD) = False Then
      Me.tag = "S"
      Exit Sub

   End If

   Me.tag = ""
   TxtFecPro.Text = cFecpro
   TxtFecProx.Text = cFecprox

   TxtFecPro.Enabled = False
   TxtFecProx.Enabled = False

   grilla.Enabled = False
   Toolbar1.Buttons(2).Enabled = False

    Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "Ingreso a Pantalla de Inicio de Día")
   Exit Sub

Label1:
  ''On Error GoTo 0
   Call objMensajesPD.BacMsgError

End Sub

Private Sub Form_Unload(Cancel As Integer)

    Call Grabar_Log("BEX", gsBac_User, gsBac_Fecp, "Salida de Pantalla de Inicio de Día")
   Set objMensajesPD = Nothing

End Sub

Private Sub Grilla_GotFocus()

   j = 1

End Sub

Private Sub grilla_KeyPress(KeyAscii As Integer)

   If grilla.Enabled = True Then
   
      If Trim(grilla.TextMatrix(grilla.row, 0)) <> "" Then
      
         If (KeyAscii = 13 Or IsNumeric(Chr(KeyAscii))) And grilla.Col = 1 Or grilla.Col = 2 Then
         
            Text1.Visible = True

            If KeyAscii = 13 Then
            
               Text1.Text = grilla.TextMatrix(grilla.RowSel, grilla.Col)

            ElseIf IsNumeric(Chr(KeyAscii)) Then
            
               Text1.Text = Chr(KeyAscii)
               Text1.SelStart = 1

            End If

            Call PROC_POSI_TEXTO(grilla, Text1)
            Text1.SetFocus

         End If

      End If

   End If

End Sub

Private Sub Grilla_LostFocus()

   j = 1

End Sub

Private Sub Text1_GotFocus()

   j = 1

End Sub

Private Sub Text1_KeyPress(KeyAscii As Integer)

   If KeyAscii = 13 Then
      grilla.TextMatrix(grilla.RowSel, grilla.Col) = Format(Text1.Text, "###,###,###0.###0")
      Text1.Visible = False
      grilla.SetFocus

   ElseIf KeyAscii = 27 Then
      Text1.Visible = False
      grilla.SetFocus

   End If

End Sub

Private Sub Text1_LostFocus()

   j = 1
   Text1.Visible = False

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
    Select Case Button.Index
   Case 1
      
      Call Func_Buscar_Datos

   Case 2
      Call Func_Grabar_Datos
      Call guardar_hora_proceso("in", Time, cFecpro)
      Call guardar_hora_proceso("id", Time, gsBac_Fecp)
      
      Me.MousePointer = vbDefault
   Case 3
      Call Func_Limpiar_Pantalla

   Case 4
   
      Unload Me

   End Select
     
End Sub

Private Sub TxtFecPro_KeyPress(KeyAscii As Integer)

   If Format$(TxtFecPro.Text, "yyyymmdd") < Format$(gsBac_Fecp, "yyyymmdd") Then
      MsgBox "Fecha de proceso debe ser igual o mayor a la del proceso en curso ", vbExclamation, gsBac_Version
      Exit Sub

   End If

End Sub

Private Sub TxtFecPro_LostFocus()

   Lbl_FecPrx.ForeColor = &H0&

   If Trim$(TxtFecPro.tag) = "" Then
      TxtFecPro.tag = TxtFecPro.Text

   End If

   Lbl_FecPro.Caption = BacDiaSem(TxtFecPro.Text)

End Sub

Private Sub TxtFecProx_LostFocus()

   Lbl_FecPrx.ForeColor = &H0&
   Lbl_FecPrx.Caption = BacDiaSem(TxtFecProx.Text)

End Sub

Private Sub CargarParam_Grilla(Grillas As Object)

   With grilla
      .ColWidth(0) = 2700
      .ColWidth(1) = 1700
      .ColWidth(2) = 1700
      .ColWidth(3) = 0
      .ColWidth(4) = 0

      .RowHeight(0) = 350
      .CellFontWidth = 4
      .row = 0

      .Col = 0
      .FixedAlignment(0) = 4
      .CellFontBold = True
      .Text = " Moneda/Tasa "
      .ColAlignment(0) = 2

      .Col = 1
      .FixedAlignment(1) = 4
      .CellFontBold = True
      .Text = " Proceso "
      .ColAlignment(1) = 8

      .Col = 2
      .FixedAlignment(2) = 4
      .CellFontBold = True
      .Text = " Próximo Proceso "
      .ColAlignment(2) = 8

   End With

End Sub

