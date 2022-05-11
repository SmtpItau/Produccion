VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form Traspaso_SBIF 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Traspaso sistema SBIF"
   ClientHeight    =   3300
   ClientLeft      =   2250
   ClientTop       =   3315
   ClientWidth     =   4920
   Icon            =   "Trassbif.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   3300
   ScaleWidth      =   4920
   ShowInTaskbar   =   0   'False
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   4380
      Top             =   0
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   2
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Trassbif.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Trassbif.frx":0624
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Height          =   450
      Left            =   0
      TabIndex        =   8
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
            Style           =   3
            Value           =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbgenerar"
            Description     =   "GENERAR"
            Object.ToolTipText     =   "Generar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbsalir"
            Description     =   "SALIR"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin Threed.SSPanel Pnl_Porc_RESBAN 
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
      FloodColor      =   12582912
   End
   Begin Threed.SSPanel Pnl_Porc_INFOTXB 
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
      FloodColor      =   12582912
   End
   Begin Threed.SSPanel Pnl_Porc_VVISTA 
      Height          =   525
      Left            =   90
      TabIndex        =   6
      Top             =   2565
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
      FloodColor      =   12582912
   End
   Begin Threed.SSCommand Cmd_Generar 
      Height          =   450
      Left            =   30
      TabIndex        =   2
      Top             =   4050
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
      Left            =   1230
      TabIndex        =   1
      Top             =   4050
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
   Begin VB.Label Label3 
      AutoSize        =   -1  'True
      Caption         =   "Generación Archivo Vale Vista"
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
      Left            =   150
      TabIndex        =   7
      Top             =   2370
      Width           =   2610
   End
   Begin VB.Label Label2 
      AutoSize        =   -1  'True
      Caption         =   "Generación Archivo Movimientos"
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
      Width           =   2805
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      Caption         =   "Generación Archivo Carteras"
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
      Width           =   2460
   End
End
Attribute VB_Name = "Traspaso_SBIF"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public parTipoOpcion As String
Function FUNC_ACTUALIZA_PARAM() As Boolean
Dim Base_Fox  As Database
Dim Param     As Recordset

FUNC_ACTUALIZA_PARAM = False

On Error GoTo Error_Carga:

Screen.MousePointer = 11

Set Base_Fox = OpenDatabase(Mid(gsFox_Contabco, 1, 17) + "SOFT", False, False, "FoxPro 2.6")
Set Param = Base_Fox.OpenRecordset("CONPARAM")

Param.MoveFirst

Param.Edit
   
Param!Trasp_Gest = 0
Param!fecTras = CDate(gsBac_Fecp)

Param.Update

Screen.MousePointer = 0

Param.Close
Base_Fox.Close

FUNC_ACTUALIZA_PARAM = True

Exit Function

Error_Carga:

Screen.MousePointer = 0

MsgBox error(Err), vbCritical, gsBac_Version

Exit Function

End Function

Function FUNC_GENERA_INFOTXB() As Boolean
Dim Datos()
Dim Comando$
Dim Base_Fox   As Database
Dim InfoTXB    As Recordset
Dim Registros  As Long
Dim Contador   As Long

FUNC_GENERA_INFOTXB = False

On Error GoTo Error_Carga:

Screen.MousePointer = 11

Comando$ = "SP_GENERA_INFOTXB '" + Format(gsBac_Fecp, "yyyymmdd") + "'"

If miSQL.SQL_Execute(Comando$) <> 0 Then
   Screen.MousePointer = 0
   Exit Function
End If

ok_sql% = miSQL.SQL_Fetch(Datos())

If ok_sql% <> 0 Then
   Screen.MousePointer = 0
   FUNC_GENERA_INFOTXB = True
   MsgBox "NO Existen Registros INFOTXB a Cargar.", vbCritical, gsBac_Version
   Exit Function
End If

Set Base_Fox = OpenDatabase(gsPath_Fox, False, False, "FoxPro 2.6")
Set InfoTXB = Base_Fox.OpenRecordset("INFOGES")

' -------------------------------
' BORRA LOS REGISTROS YA CARGADOS
' -------------------------------
If InfoTXB.RecordCount > 0 Then

   InfoTXB.MoveFirst
   Do While Not InfoTXB.EOF
      InfoTXB.Delete
      InfoTXB.MoveNext
   Loop
   
End If

' --------------------------
' CARGA LOS REGISTROS NUEVOS
' --------------------------
Registros = Val(Datos(1))

Contador = 1

Pnl_Porc_INFOTXB.FloodPercent = 0

Do While ok_sql% = 0

   Pnl_Porc_INFOTXB.FloodPercent = (Contador * 100) / Registros

   Contador = Contador + 1
   
   InfoTXB.AddNew
   
   InfoTXB!Entidad = Datos(2)
   InfoTXB!Correla = Val(Datos(3))
   InfoTXB!Operacion = Val(Datos(4))
   InfoTXB!codClte = Val(Datos(5))
   InfoTXB!codemi = Val(Datos(6))
   InfoTXB!instrum = Datos(7)
   InfoTXB!Serie = Datos(8)
   InfoTXB!MonPac = Datos(9)
   InfoTXB!Nominal = Val(Datos(10))
   InfoTXB!compraps = Val(Datos(11))
   InfoTXB!fcompra = CDate(Datos(12))
   InfoTXB!fpacto = CDate(Datos(13))
   InfoTXB!fvcto = CDate(Datos(14))
   InfoTXB!tasaac = Val(Datos(15))
   InfoTXB!Cartera = Val(Datos(16))
   InfoTXB!TipCar = Val(Datos(17))
   InfoTXB!insreal = Datos(18)
   InfoTXB!Moncon = Datos(19)
   InfoTXB!tasaop = Val(Datos(20))
   InfoTXB!plzo = Datos(21)
   InfoTXB!codtx = Datos(22)
   InfoTXB!fecact = CDate(Datos(12))
   InfoTXB!nominfi = Datos(23)
   InfoTXB!TasEmis = Val(Datos(24))
   InfoTXB!vfinal = Val(Datos(25))
   InfoTXB!monnom = Datos(26)
   InfoTXB!tipocar = Datos(27)
   InfoTXB!vfinpac = Val(Datos(28))
   InfoTXB!spread = Val(Datos(29))
   InfoTXB!tipo_tasa = Val(Datos(30))
   InfoTXB!base_fluc = Val(Datos(31))
   InfoTXB!fpagpa = Trim(Datos(32))
   InfoTXB!fpagre = Trim(Datos(33))
   
   InfoTXB.Update

   ok_sql% = miSQL.SQL_Fetch(Datos())

Loop

Screen.MousePointer = 0

InfoTXB.Close
Base_Fox.Close

FUNC_GENERA_INFOTXB = True

Exit Function

Error_Carga:

Screen.MousePointer = 0

MsgBox error(Err), vbCritical, gsBac_Version

Exit Function

End Function

Function FUNC_GENERA_VVISTA() As Boolean
Dim Datos()
Dim Comando$
Dim Base_Fox  As Database
Dim VVista    As Recordset
Dim Registros As Long
Dim Contador  As Long
Dim Path      As String

FUNC_GENERA_VVISTA = False

On Error GoTo Error_Carga:

Screen.MousePointer = 11

Comando$ = "SP_GENERA_VVISTA"

If miSQL.SQL_Execute(Comando$) <> 0 Then
   Screen.MousePointer = 0
   Exit Function
End If

ok_sql% = miSQL.SQL_Fetch(Datos())

If ok_sql% <> 0 Then
   Screen.MousePointer = 0
   FUNC_GENERA_VVISTA = True
   MsgBox "NO Existen Registros Vale Vista a Cargar.", vbCritical, gsBac_Version
   Exit Function
End If

Path = Mid(gsPath_Fox, 1, 2) + "\APPS\FOXDOC\DATA\"

Set Base_Fox = OpenDatabase(Path, False, False, "FoxPro 2.6")
Set VVista = Base_Fox.OpenRecordset("DCVFIL04")

' -------------------------------
' BORRA LOS REGISTROS YA CARGADOS
' -------------------------------
If VVista.RecordCount > 0 Then

   VVista.MoveFirst
   Do While Not VVista.EOF
      VVista.Delete
      VVista.MoveNext
   Loop
   
End If

' --------------------------
' CARGA LOS REGISTROS NUEVOS
' --------------------------
Registros = Val(Datos(1))

Contador = 1

Pnl_Porc_VVISTA.FloodPercent = 0

Do While ok_sql% = 0

   Pnl_Porc_VVISTA.FloodPercent = (Contador * 100) / Registros

   Contador = Contador + 1
   
   VVista.AddNew
   
   VVista!TipO = Datos(2)
   VVista!Estado = Datos(3)
   VVista!codigocl = Val(Datos(4))
   VVista!sector = Val(Datos(5))
   VVista!montoem = Val(Datos(6))
   
   VVista.Update

   ok_sql% = miSQL.SQL_Fetch(Datos())

Loop

Screen.MousePointer = 0

VVista.Close
Base_Fox.Close

FUNC_GENERA_VVISTA = True

Exit Function

Error_Carga:

Screen.MousePointer = 0

MsgBox error(Err), vbCritical, gsBac_Version

Exit Function

End Function

Private Sub Cmd_cancelar_Click()

'Unload Me

End Sub


Private Sub Cmd_Generar_Click()

'    If MsgBox("Seguro de generar archivo ?", 36) <> 6 Then Exit Sub
'
'    If Not FUNC_GENERA_RESBAN() Then Exit Sub
'    If Not FUNC_GENERA_INFOTXB() Then Exit Sub
'    If Not FUNC_GENERA_VVISTA() Then Exit Sub
'    If Not FUNC_ACTUALIZA_PARAM() Then Exit Sub
'
'    MsgBox "Proceso Terminado.", 64

End Sub
Function FUNC_GENERA_RESBAN() As Boolean
Dim Datos()
Dim Comando$
Dim Base_Fox     As Database
Dim ResBan       As Recordset
Dim Registros    As Long
Dim Contador     As Long
Dim Fecha_Contab As String
Dim Fin_Feriado  As Boolean

FUNC_GENERA_RESBAN = False

On Error GoTo Error_Carga:

Screen.MousePointer = 11

If Busca_Fin_Mes_Feriado() Then
   Fecha_Contab = Format(gsBac_Feca, "dd/mm/yyyy")
   Fin_Feriado = True
Else
   Fecha_Contab = Format(gsBac_Fecp, "dd/mm/yyyy")
   Fin_Feriado = False
End If

Comando$ = "SP_GENERA_RESBAN '" + Format(gsBac_Fecp, "yyyymmdd") + "'"

If miSQL.SQL_Execute(Comando$) <> 0 Then
   Screen.MousePointer = 0
   Exit Function
End If

ok_sql% = miSQL.SQL_Fetch(Datos())

If ok_sql% <> 0 Then
   Screen.MousePointer = 0
   FUNC_GENERA_RESBAN = True
   MsgBox "NO Existen Registros RESBAN a Cargar.", vbCritical, gsBac_Version
   Exit Function
End If

Set Base_Fox = OpenDatabase(gsPath_Fox, False, False, "FoxPro 2.6")
Set ResBan = Base_Fox.OpenRecordset("RESBGES")

' -------------------------------
' BORRA LOS REGISTROS YA CARGADOS
' -------------------------------
If ResBan.RecordCount > 0 And Not Fin_Feriado Then

   ResBan.MoveFirst
   Do While Not ResBan.EOF
      ResBan.Delete
      ResBan.MoveNext
   Loop
   
End If

' --------------------------
' CARGA LOS REGISTROS NUEVOS
' --------------------------
Registros = Val(Datos(1))

Contador = 1

Pnl_Porc_RESBAN.FloodPercent = 0

Do While ok_sql% = 0

   Pnl_Porc_RESBAN.FloodPercent = (Contador * 100) / Registros

   Contador = Contador + 1
   
   ResBan.AddNew
   
   ResBan!fecpro = CDate(Fecha_Contab)
   ResBan!Entidad = Datos(3)
   ResBan!Correla = Val(Datos(4))
   ResBan!codClte = Val(Datos(5))
   ResBan!codemi = Val(Datos(6))
   ResBan!Operacion = Val(Datos(7))
   ResBan!Cartera = Val(Datos(8))
   ResBan!TipCar = Val(Datos(9))
   ResBan!tipocar = Datos(10)
   ResBan!insreal = Datos(11)
   ResBan!InstSer = Datos(12)
   ResBan!fecemi = CDate(Datos(13))
   ResBan!Fecini = CDate(Datos(14))
   ResBan!fecfin = CDate(Datos(15))
   ResBan!fecext = CDate(Datos(16))
   ResBan!Moncon = Datos(17)
   ResBan!Tasa = Val(Datos(18))
   ResBan!TasEmis = Val(Datos(19))
   ResBan!vfinal = Val(Datos(20))
   ResBan!capps = Val(Datos(21))
   ResBan!intps = Val(Datos(22))
   ResBan!Nominal = Val(Datos(23))
   ResBan!pcupon = Val(Datos(24))
   ResBan!plzo = Datos(25)
   ResBan!compraor = Val(Datos(26))
   ResBan!mtocup = Val(Datos(27))
   ResBan!tipo_emp = Datos(28)
   ResBan!com_del = Datos(29)
   ResBan!monnom = Datos(30)
   ResBan!valmerc = Datos(31)
   ResBan!diferido = Datos(32)
   ResBan!spread = Val(Datos(33))
   ResBan!tipo_tasa = Val(Datos(34))
   ResBan!base_fluc = Val(Datos(35))
   
   ResBan.Update

   ok_sql% = miSQL.SQL_Fetch(Datos())

Loop

Screen.MousePointer = 0

ResBan.Close
Base_Fox.Close

FUNC_GENERA_RESBAN = True

Exit Function

Error_Carga:

Screen.MousePointer = 0

MsgBox error(Err), vbCritical, gsBac_Version

Exit Function

End Function


'=========================================================================================
Function funcGeneraPERBAN() As Boolean
'=========================================================================================
'   Función     :   funcGeneraPERBAN
'   Objetivo    :   Genera Archivo PERBAN para el Gran .... sistema de Foxpro
'   Autor       :   Victor Barra Fuentes
'   Fecha       :   Mayo 2000
'=========================================================================================
Dim Datos()
Dim cSql        As String
Dim nTotReg     As Long
Dim Contador    As Long
Dim Base_Fox    As Database
Dim PerBan      As Recordset

On Error GoTo ErrPerban:

    funcGeneraPERBAN = False

    Screen.MousePointer = vbHourglass

    cSql = "EXECUTE SP_GENFILEPERBAN"

    If miSQL.SQL_Execute(cSql) <> 0 Then
        Screen.MousePointer = vbDefault
        Exit Function
    End If
    

    gsPath_Fox = "g:\apps\sbif\contabil\data\"

    Set Base_Fox = OpenDatabase(gsPath_Fox, False, False, "FoxPro 2.6")
    Set PerBan = Base_Fox.OpenRecordset("PERGES")
    
    Contador = 1
    Pnl_Porc_RESBAN.FloodPercent = 0

    Do While Bac_SQL_Fetch(Datos())
        
        nTotReg = Val(Datos(1))
'        Pnl_Porc_RESBAN.FloodPercent = (Contador * 100) / nTotReg

        Contador = Contador + 1
   
        PerBan.AddNew
        PerBan!Moneda = Datos(2)
        PerBan!FecVcto = CDate(Datos(3))
        PerBan!difdia = Datos(4)
        PerBan!capact = CDbl(Datos(5))
        PerBan!vfiact = CDbl(Datos(6))
        PerBan!vpreact = CDbl(Datos(7))
        PerBan!tasaac = CDbl(Datos(8))
        PerBan!tipocar = Datos(9)
        PerBan.Update

    Loop

    Screen.MousePointer = vbDefault

    PerBan.Close
    Base_Fox.Close

    funcGeneraPERBAN = True
    Exit Function

ErrPerban:

    Screen.MousePointer = vbDefault
    MsgBox "Problemas en carga de archivo PERBAN: " & Err.Description & ".Comunique al Administrador.", vbCritical, gsBac_Version
    Exit Function
    
End Function


Private Sub Form_Load()

    Pnl_Porc_RESBAN.FloodPercent = 0
    Pnl_Porc_INFOTXB.FloodPercent = 0
    Pnl_Porc_VVISTA.FloodPercent = 0
    
End Sub


Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case UCase(Button.Description)
Case "GENERAR"
    If MsgBox("Seguro de generar archivo ?", 36) <> 6 Then Exit Sub
    If Not FUNC_GENERA_RESBAN() Then Exit Sub
    If Not FUNC_GENERA_INFOTXB() Then Exit Sub
    If Not FUNC_GENERA_VVISTA() Then Exit Sub
    If Not FUNC_ACTUALIZA_PARAM() Then Exit Sub
    MsgBox "Proceso Terminado.", 64
Case "SALIR"
    Unload Me
End Select
End Sub
