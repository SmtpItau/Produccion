VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form Interfaces 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Interfaces"
   ClientHeight    =   1485
   ClientLeft      =   2985
   ClientTop       =   3210
   ClientWidth     =   4905
   Icon            =   "Interfaz.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   1485
   ScaleWidth      =   4905
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   4
      Top             =   0
      Width           =   4905
      _ExtentX        =   8652
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
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   2985
      Top             =   1830
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
            Picture         =   "Interfaz.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Interfaz.frx":0624
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin Threed.SSPanel Pnl_Porcentaje 
      Height          =   525
      Left            =   105
      TabIndex        =   0
      Top             =   570
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
   Begin Threed.SSCommand Cmd_Cancelar 
      Height          =   450
      Left            =   1305
      TabIndex        =   2
      Top             =   1815
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
   Begin Threed.SSCommand Cmd_Generar 
      Height          =   450
      Left            =   105
      TabIndex        =   1
      Top             =   1830
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
   Begin VB.Label Lbl_Interfaz 
      BorderStyle     =   1  'Fixed Single
      Height          =   300
      Left            =   3855
      TabIndex        =   3
      Top             =   1140
      Visible         =   0   'False
      Width           =   885
   End
End
Attribute VB_Name = "Interfaces"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Sub PROC_GENERA_PRAMS()
Dim datos()
Dim Comando$
Dim Registros As Double
Dim Contador  As Double
Dim Linea     As String
Dim Nominal   As Double
Dim Msg       As String
Dim Archivo1  As String
Dim Archivo2  As String

On Error GoTo Error_Carga:

' ----------------------------------------------------------------------------
' GENERA PRAMS STATIC DATA
' ----------------------------------------------------------------------------

Comando$ = "SP_INTERFAZ_PRAMS 'S'"

If miSQL.SQL_Execute(Comando$) <> 0 Then Exit Sub

ok_sql% = miSQL.SQL_Fetch(datos())

If ok_sql% <> 0 Then Exit Sub

Registros = Val(datos(1))

Contador = 1

Pnl_Porcentaje.FloodPercent = 0

Archivo1 = App.Path + "\STA" + Format(gsBac_Fecp, "ddmm") + ".TXT"

Open Archivo1 For Output As #1

Linea = "INVENTORY SECURITIES FOR CHILE " + Format(gsBac_Fecp, "yyyymmdd")
Print #1, Linea

Linea = "ISIN" & Chr(9) & "ISSUER NAME" & Chr(9) & "COUPON" & Chr(9) & "COUPON FREQUENCY" & Chr(9) & "MATURITY" & Chr(9) & "CCY" & Chr(9) & "FACTOR" & Chr(9) & "SECURITY TYPE" & Chr(9) & "COUPON BASIS" & Chr(9) & "COUNTRY OF ISSUE" & Chr(9) & "RATING" & Chr(9) & "RATING SOURCE" & Chr(9) & "TOTAL ISSUE NOMINAL"
Print #1, Linea

Do While ok_sql% = 0

   Pnl_Porcentaje.FloodPercent = (Contador * 100) / Registros

   Contador = Contador + 1
   
   Linea = datos(2) & Chr(9)
   Linea = Linea & datos(3) & Chr(9)
   Linea = Linea & datos(4) & Chr(9)
   Linea = Linea & Val(datos(5)) & Chr(9)
   Linea = Linea & Format(datos(6), "ddmmyyyy") & Chr(9)
   Linea = Linea & datos(7) & Chr(9)
   Linea = Linea & datos(8) & Chr(9)
   Linea = Linea & datos(9) & Chr(9)
   Linea = Linea & Val(datos(10)) & Chr(9)
   Linea = Linea & datos(11) & Chr(9)
   Linea = Linea & datos(12) & Chr(9)
   Linea = Linea & datos(13) & Chr(9)
   Linea = Linea & datos(14)
   
   Print #1, Linea
 
   ok_sql% = miSQL.SQL_Fetch(datos())

Loop

Linea = "END OF FILE" & Chr(9) & Format(Registros, "##0")
Print #1, Linea

Close #1

' ----------------------------------------------------------------------------
' GENERA PRAMS POSITION
' ----------------------------------------------------------------------------

Comando$ = "SP_INTERFAZ_PRAMS 'P'"

If miSQL.SQL_Execute(Comando$) <> 0 Then Exit Sub

ok_sql% = miSQL.SQL_Fetch(datos())

If ok_sql% <> 0 Then Exit Sub

Registros = Val(datos(1))

Contador = 1
Nominal = 0#

Pnl_Porcentaje.FloodPercent = 0

Archivo2 = App.Path + "\POS" + Format(gsBac_Fecp, "ddmm") + ".TXT"

Open Archivo2 For Output As #1

Linea = "INVENTORY POSITION FOR CHILE " + Format(gsBac_Fecp, "yyyymmdd")
Print #1, Linea

Linea = "ISIN" & Chr(9) & "BOOK" & Chr(9) & "CODE" & Chr(9) & "SECURITY NAME" & Chr(9) & "NOMINAL" & Chr(9) & "PRICE" & Chr(9) & "YIELD" & Chr(9) & "CCY"
Print #1, Linea

Do While ok_sql% = 0

   Pnl_Porcentaje.FloodPercent = (Contador * 100) / Registros

   Contador = Contador + 1
   
   Linea = datos(2) & Chr(9)
   Linea = Linea & datos(3) & Chr(9)
   Linea = Linea & datos(4) & Chr(9)
   Linea = Linea & datos(5) & Chr(9)
   Linea = Linea & datos(6) & Chr(9)
   Linea = Linea & datos(7) & Chr(9)
   Linea = Linea & datos(8)
   
   Nominal = Nominal + Val(datos(5))

   Print #1, Linea

   ok_sql% = miSQL.SQL_Fetch(datos())

Loop

Linea = "END OF FILE" & Chr(9) & Format(Registros, "##0") & Chr(9) & Format(Nominal, "##0.00")
Print #1, Linea

Close #1

Screen.MousePointer = 0

Msg = "Archivos Generados como :" + Chr(10) + Chr(13)
Msg = Msg + Archivo1 + Chr(10) + Chr(13)
Msg = Msg + Archivo2

MsgBox Msg, vbInformation

Exit Sub

Error_Carga:

Screen.MousePointer = 0

MsgBox Error(Err), vbCritical, gsBac_Version

Exit Sub

End Sub

Sub PROC_GENERA_TSAR()
Dim datos()
Dim Comando$
Dim Registros As Double
Dim Contador  As Double
Dim Linea     As String
Dim Msg       As String
Dim Archivo1  As String
Dim Archivo2  As String

On Error GoTo Error_Carga:

' ----------------------------------------------------------------------------
' GENERA TSAR POSITION
' ----------------------------------------------------------------------------

Comando$ = "SP_INTERFAZ_TSAR 'P'"

If miSQL.SQL_Execute(Comando$) <> 0 Then Exit Sub

ok_sql% = miSQL.SQL_Fetch(datos())

If ok_sql% <> 0 Then Exit Sub

Registros = Val(datos(1))

Contador = 1

Pnl_Porcentaje.FloodPercent = 0

Archivo1 = App.Path + "\" + Format(gsBac_Fecp, "yyyymmdd") + ".POS"

Open Archivo1 For Output As #1

Do While ok_sql% = 0

   Pnl_Porcentaje.FloodPercent = (Contador * 100) / Registros

   Contador = Contador + 1
   
   Linea = datos(2) & Chr(9)
   Linea = Linea & datos(3) & Chr(9)
   Linea = Linea & datos(4) & Chr(9)
   Linea = Linea & datos(5) & Chr(9)
   Linea = Linea & datos(6) & Chr(9)
   Linea = Linea & datos(7) & Chr(9)
   Linea = Linea & datos(8)
   
   Print #1, Linea
 
   ok_sql% = miSQL.SQL_Fetch(datos())

Loop

Close #1

' ----------------------------------------------------------------------------
' GENERA TSAR TRADES
' ----------------------------------------------------------------------------

Comando$ = "SP_INTERFAZ_TSAR 'T'"

If miSQL.SQL_Execute(Comando$) <> 0 Then Exit Sub

ok_sql% = miSQL.SQL_Fetch(datos())

If ok_sql% <> 0 Then Exit Sub

Registros = Val(datos(1))

Contador = 1

Pnl_Porcentaje.FloodPercent = 0

Archivo2 = App.Path + "\" + Format(gsBac_Fecp, "yyyymmdd") + ".TRD"

Open Archivo2 For Output As #1

Do While ok_sql% = 0

   Pnl_Porcentaje.FloodPercent = (Contador * 100) / Registros

   Contador = Contador + 1
   
   Linea = Val(datos(2)) & Chr(9)
   Linea = Linea & datos(3) & Chr(9)
   Linea = Linea & datos(4) & Chr(9)
   Linea = Linea & datos(5) & Chr(9)
   Linea = Linea & datos(6) & Chr(9)
   Linea = Linea & datos(7) & Chr(9)
   Linea = Linea & datos(8) & Chr(9)
   Linea = Linea & datos(9) & Chr(9)
   Linea = Linea & datos(10) & Chr(9)
   Linea = Linea & datos(11) & Chr(9)
   Linea = Linea & datos(12) & Chr(9)
   Linea = Linea & datos(13) & Chr(9)
   Linea = Linea & datos(14) & Chr(9)
   Linea = Linea & datos(15) & Chr(9)
   Linea = Linea & datos(16) & Chr(9)
   Linea = Linea & datos(17) & Chr(9)
   Linea = Linea & datos(18) & Chr(9)
   Linea = Linea & datos(19)
  
   Print #1, Linea

   ok_sql% = miSQL.SQL_Fetch(datos())

Loop

Close #1

Screen.MousePointer = 0

Msg = "Archivos Generados como :" + Chr(10) + Chr(13)
Msg = Msg + Archivo1 + Chr(10) + Chr(13)
Msg = Msg + Archivo2

MsgBox Msg, vbInformation

Exit Sub

Error_Carga:

Screen.MousePointer = 0

MsgBox Error(Err), vbCritical, gsBac_Version

Exit Sub

End Sub

Private Sub Cmd_cancelar_Click()

'Unload Me

End Sub


Private Sub Cmd_Generar_Click()

'If MsgBox("Seguro de Generar Interface ?", 36) <> 6 Then Exit Sub
'
'Screen.MousePointer = 11
'
'Select Case Lbl_Interfaz.Caption
'       Case "PRAMS"
'             PROC_GENERA_PRAMS
'       Case "TSAR"
'             PROC_GENERA_TSAR
'End Select
'
'Screen.MousePointer = 0
'
End Sub


Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case UCase(Button.Description)
    Case "GENERAR"
        If MsgBox("Seguro de Generar Interface ?", 36) <> 6 Then Exit Sub
        Screen.MousePointer = 11
        Select Case Lbl_Interfaz.Caption
            Case "PRAMS"
                PROC_GENERA_PRAMS
            Case "TSAR"
                PROC_GENERA_TSAR
        End Select
        Screen.MousePointer = 0
    Case "SALIR"
        Unload Me
    
End Select
End Sub
