VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form InterPV01 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Generación Interfaces"
   ClientHeight    =   2445
   ClientLeft      =   3045
   ClientTop       =   2085
   ClientWidth     =   4920
   Icon            =   "Intepv01.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   2445
   ScaleWidth      =   4920
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   7
      Top             =   0
      Width           =   4920
      _ExtentX        =   8678
      _ExtentY        =   794
      ButtonWidth     =   767
      ButtonHeight    =   741
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbgenerar"
            Description     =   "GENERAR"
            Object.ToolTipText     =   "Generar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbimprimir"
            Description     =   "IMPRIMIR"
            Object.ToolTipText     =   "Imprimir"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbsalir"
            Description     =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   4245
      Top             =   3030
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
            Picture         =   "Intepv01.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Intepv01.frx":0624
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Intepv01.frx":093E
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin Threed.SSPanel PorcPV01 
      Height          =   525
      Left            =   75
      TabIndex        =   0
      Top             =   870
      Width           =   4710
      _Version        =   65536
      _ExtentX        =   8308
      _ExtentY        =   926
      _StockProps     =   15
      ForeColor       =   16777215
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BevelOuter      =   0
      BevelInner      =   2
      FloodType       =   1
   End
   Begin Threed.SSPanel PorcCRI 
      Height          =   525
      Left            =   75
      TabIndex        =   3
      Top             =   1710
      Width           =   4710
      _Version        =   65536
      _ExtentX        =   8308
      _ExtentY        =   926
      _StockProps     =   15
      ForeColor       =   16777215
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BevelOuter      =   0
      BevelInner      =   2
      FloodType       =   1
      FloodColor      =   8421376
   End
   Begin Threed.SSCommand SSC_Imprimir 
      Height          =   450
      Left            =   1230
      TabIndex        =   6
      Top             =   3150
      Width           =   1200
      _Version        =   65536
      _ExtentX        =   2117
      _ExtentY        =   794
      _StockProps     =   78
      Caption         =   "&Imprimir"
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   3
   End
   Begin Threed.SSCommand Cmd_Generar 
      Height          =   450
      Left            =   45
      TabIndex        =   2
      Top             =   3150
      Width           =   1200
      _Version        =   65536
      _ExtentX        =   2117
      _ExtentY        =   794
      _StockProps     =   78
      Caption         =   "&Generar"
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   3
   End
   Begin Threed.SSCommand Cmd_Cancelar 
      Height          =   450
      Left            =   2415
      TabIndex        =   1
      Top             =   3150
      Width           =   1200
      _Version        =   65536
      _ExtentX        =   2117
      _ExtentY        =   794
      _StockProps     =   78
      Caption         =   "&Salir"
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   3
   End
   Begin VB.Label Label2 
      AutoSize        =   -1  'True
      Caption         =   "Generación archivo CRI"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Left            =   135
      TabIndex        =   5
      Top             =   1515
      Width           =   2055
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      Caption         =   "Generación Archivo PV01"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Left            =   135
      TabIndex        =   4
      Top             =   660
      Width           =   2205
   End
End
Attribute VB_Name = "InterPV01"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim TotReg_PV01 As Integer
Dim TotReg_CRI  As Integer



Function funcGeneraPV01(TipInter As String, TipSistema As String, iTotRegistros As Integer) As Boolean
Dim cSql            As String
Dim Datos()
Dim hFile%
Dim cCadenaWrite    As String
Dim nRegAct         As Integer


On Error GoTo ErrInter


    funcGeneraPV01 = False
    nRegAct = 1
    
    cSql = "EXECUTE SP_CREAINTERFAZ '" & TipInter & "', '" & TipSistema & "'"
    If miSQL.SQL_Execute(cSql) <> 0 Then Exit Function

    If TipInter = "PV01" Then
        Open gsBac_DIRIN & "\CONFLUJO.TXT" For Output As #1

        cCadenaWrite = "HEADER" & Chr(59) & "SAN" & Chr(59) & "EMERGING MARKETS" & Chr(59) & "LATIN AMERICAN LOCAL MARKETS" & Chr(59) & "TRADING" & Chr(59) & "TRADING" & Chr(59) & "IR" & Chr(59) & Trim$(CStr(iTotRegistros + 1)) & Chr(59) & Format$(gsBac_Fecp, "dd/mm/yyyy") & Chr(59) & gsBac_Dolar
        Print #1, cCadenaWrite
    Else
        Open gsBac_DIRIN & "\CRIFLUJO.TXT" For Output As #1
    End If
    
    nRegAct = 1
    
    Do While Bac_SQL_Fetch(Datos())
        If TipInter = "PV01" Then
            cCadenaWrite = Datos(1) & Chr(59) & Datos(2) & Chr(59) & Datos(3) & Chr(59) & Datos(4) & Chr(59) & Datos(5) & Chr(59) & Datos(6) & Chr(59) & Datos(7)
            PorcPV01.FloodPercent = (nRegAct * 100) / iTotRegistros
        Else
            PorcCRI.FloodPercent = (nRegAct * 100) / iTotRegistros
            cCadenaWrite = Datos(1) & Chr(59) & Datos(2) & Chr(59) & Datos(3) & Chr(59) & Datos(4) & Chr(59) & Datos(5) & Chr(59) & Datos(6) & Chr(59) & Datos(7) & Chr(59) & Datos(8) & Chr(59) & Datos(10)
        End If
        
        Print #1, cCadenaWrite
        
        nRegAct = nRegAct + 1
        
    Loop
    
    If TipInter = "PV01" Then
        PorcPV01.FloodPercent = 100
    Else
        PorcCRI.FloodPercent = 100
    End If
    Close #1
    
    funcGeneraPV01 = True
    
    
    Exit Function
ErrInter:
    Close #1
    MsgBox "No se pudo realizar generación de Archivo " & TipInter & ": <" & err.Description & ">.  Comunique al Administrador.", vbCritical, gsBac_Version
    Exit Function
End Function

Function funcLlena_ActPas_Pv01(parSistema As String, parModalidad As String) As Boolean
Dim cSql As String
Dim Datos()

    funcLlena_ActPas_Pv01 = False
    
  
    cSql = "EXECUTE SP_IMPRIME_ACTPAS_PV01 '" & parSistema & "','" & parModalidad & "'"
    
    If miSQL.SQL_Execute(cSql) <> 0 Then Exit Function
    Do While Bac_SQL_Fetch(Datos())
        cSql = ""
        cSql = cSql & "INSERT INTO PV01_ACT_PAS VALUES( "
        cSql = cSql & "'" & Datos(1) & "' ,"
        cSql = cSql & Datos(2) & ","
        cSql = cSql & Datos(3) & ","
        cSql = cSql & Datos(4) & ","
        cSql = cSql & Datos(5) & ","
        cSql = cSql & Datos(6) & ","
        cSql = cSql & Datos(7) & ","
        cSql = cSql & Datos(8) & ","
        cSql = cSql & Datos(9) & ","
        cSql = cSql & Datos(10) & ","
        cSql = cSql & "'" & Datos(11) & "' ,"
        cSql = cSql & "'" & Datos(12) & "' ,"
        cSql = cSql & Datos(13) & ");"
        db.Execute cSql
    Loop
    
    funcLlena_ActPas_Pv01 = True

End Function



Function funcLlena_Pv01(parSistema As String) As Boolean
Dim cSql As String
Dim Datos()

    funcLlena_Pv01 = False
   
    cSql = "EXECUTE SP_IMPRIME_PV01 '" & parSistema & "'"
    
    If miSQL.SQL_Execute(cSql) <> 0 Then Exit Function
    Do While Bac_SQL_Fetch(Datos())
        cSql = ""
        cSql = cSql & "INSERT INTO PV01_PV01 VALUES( "
        cSql = cSql & "'" & Datos(1) & "' ,"
        cSql = cSql & Datos(2) & ","
        cSql = cSql & Datos(3) & ","
        cSql = cSql & Datos(4) & ","
        cSql = cSql & Datos(6) & ","
        cSql = cSql & Datos(7) & ","
        cSql = cSql & Datos(8) & ","
        cSql = cSql & "'" & Datos(10) & "' );"
        db.Execute cSql
    Loop
    
    funcLlena_Pv01 = True

End Function


Private Sub Cmd_cancelar_Click()
'Unload Me
End Sub

Private Sub Cmd_Generar_Click()
'Dim cSql As String
'Dim Data()
'
'    Screen.MousePointer = vbHourglass
'    TotReg_PV01 = 0
'    TotReg_CRI = 0
'
'    cSql = "EXECUTE SP_INTERFAZ_PV01 "
'
'    If miSQL.SQL_Execute(cSql) <> 0 Then Exit Sub
'
'    If miSQL.SQL_Fetch(Data()) <> 0 Then Exit Sub
'
'    If Data(1) <> "SI" Then
'        MsgBox "Problemas en generación de interface", vbCritical, gsBac_Version
'        Exit Sub
'    Else
'        TotReg_PV01 = Data(2)
'        TotReg_CRI = Data(3)
'    End If
'
'    PorcPV01.FloodPercent = 0
'    PorcCRI.FloodPercent = 0
'
'    Call funcGeneraPV01("PV01", "CON", TotReg_PV01)
'    PorcCRI.FloodPercent = 0
'
'    Call funcGeneraPV01("CRI", "CON", TotReg_CRI)
'
'    Screen.MousePointer = vbDefault
'
'    MsgBox "Generación de archivos finalizado.", vbInformation, gsBac_Version
'
'    Cmd_Generar.Enabled = False
'    SSC_Imprimir.Enabled = True
    
End Sub

Private Sub SSCommand1_Click()

End Sub


Private Sub SSC_Imprimir_Click()
'Dim cSql As String
'
'On Error GoTo PrintPV01
'   Call limpiar_cristal
'    Screen.MousePointer = vbHourglass
'
'
'    BacTrader.bacrpt.ReportFileName = RptList_Path & "PV01ACPA1.RPT"
'    BacTrader.bacrpt.Destination = crptToWindow
'    BacTrader.bacrpt.Formulas(0) = "Entidad ='" & gsBac_Clien & "'"
'    BacTrader.bacrpt.Formulas(1) = "fecha_hoy = '" & Format(gsBac_Fecp, "dd/mm/yyyy") & "'"
'    BacTrader.bacrpt.Formulas(2) = "titulo_informe= '" & "" & "'"
'    BacTrader.bacrpt.Formulas(3) = "hora ='" & Time & "'"
'    BacTrader.bacrpt.Connect = CONECCION
'    BacTrader.bacrpt.Action = 1
'
'
''    Call funcLlena_Pv01("BTR")
'    'Call funcLlena_Pv01("CON")
'    'Call funcLlena_Pv01("BFW")
'
'    BacTrader.bacrpt.Destination = crptToWindow
'    BacTrader.bacrpt.ReportFileName = RptList_Path & "PV01PV011.RPT"
'    BacTrader.bacrpt.Formulas(0) = "Entidad ='" & gsBac_Clien & "'"
'    BacTrader.bacrpt.Formulas(1) = "fecha_hoy = '" & Format(gsBac_Fecp, "dd/mm/yyyy") & "'"
'    BacTrader.bacrpt.Formulas(2) = "hora ='" & Time & "'"
'    BacTrader.bacrpt.Connect = CONECCION
'    BacTrader.bacrpt.Action = 1
'
'    Screen.MousePointer = vbDefault
'    Exit Sub
'
'PrintPV01:
'    Screen.MousePointer = vbDefault
'    MsgBox "Problemas en impresión de reporte PV01: " & Err.Description, vbExclamation, gsBac_Version
'    Exit Sub
End Sub


Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case UCase(Button.Description)
    Case "GENERAR"
    Dim cSql As String
    Dim Data()

    Screen.MousePointer = vbHourglass
    TotReg_PV01 = 0
    TotReg_CRI = 0

    cSql = "EXECUTE SP_INTERFAZ_PV01 "
    
    If miSQL.SQL_Execute(cSql) <> 0 Then Exit Sub
    
    If miSQL.SQL_Fetch(Data()) <> 0 Then Exit Sub
    
    If Data(1) <> "SI" Then
        MsgBox "Problemas en generación de interface", vbCritical, gsBac_Version
        Exit Sub
    Else
        TotReg_PV01 = Data(2)
        TotReg_CRI = Data(3)
    End If
    
    PorcPV01.FloodPercent = 0
    PorcCRI.FloodPercent = 0
    
    Call funcGeneraPV01("PV01", "CON", TotReg_PV01)
    PorcCRI.FloodPercent = 0
    
    Call funcGeneraPV01("CRI", "CON", TotReg_CRI)
    
    Screen.MousePointer = vbDefault
    
    MsgBox "Generación de archivos finalizado.", vbInformation, gsBac_Version
    
    'Cmd_Generar.Enabled = False
    Toolbar1.Buttons(2).Enabled = False
    'SSC_Imprimir.Enabled = True
    Toolbar1.Buttons(3).Enabled = True

    Case "IMPRIMIR"
        'Dim cSql As String

On Error GoTo PrintPV01
   Call Limpiar_Cristal
    Screen.MousePointer = vbHourglass


    BacTrader.bacrpt.ReportFileName = RptList_Path & "PV01ACPA1.RPT"
    BacTrader.bacrpt.Destination = crptToWindow
    BacTrader.bacrpt.Formulas(0) = "Entidad ='" & gsBac_Clien & "'"
    BacTrader.bacrpt.Formulas(1) = "fecha_hoy = '" & Format(gsBac_Fecp, "dd/mm/yyyy") & "'"
    BacTrader.bacrpt.Formulas(2) = "titulo_informe= '" & "" & "'"
    BacTrader.bacrpt.Formulas(3) = "hora ='" & Time & "'"
    BacTrader.bacrpt.Connect = CONECCION
    BacTrader.bacrpt.Action = 1
    
    
'    Call funcLlena_Pv01("BTR")
    'Call funcLlena_Pv01("CON")
    'Call funcLlena_Pv01("BFW")
    
    BacTrader.bacrpt.Destination = crptToWindow
    BacTrader.bacrpt.ReportFileName = RptList_Path & "PV01PV011.RPT"
    BacTrader.bacrpt.Formulas(0) = "Entidad ='" & gsBac_Clien & "'"
    BacTrader.bacrpt.Formulas(1) = "fecha_hoy = '" & Format(gsBac_Fecp, "dd/mm/yyyy") & "'"
    BacTrader.bacrpt.Formulas(2) = "hora ='" & Time & "'"
    BacTrader.bacrpt.Connect = CONECCION
    BacTrader.bacrpt.Action = 1
    
    Screen.MousePointer = vbDefault
    Exit Sub
    
PrintPV01:
    Screen.MousePointer = vbDefault
    MsgBox "Problemas en impresión de reporte PV01: " & err.Description, vbExclamation, gsBac_Version
    Exit Sub
    Case "SALIR"
        Unload Me
End Select
End Sub
