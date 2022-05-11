VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form Traspaso_Contab 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Traspaso Sistema Contabilidad"
   ClientHeight    =   1290
   ClientLeft      =   2100
   ClientTop       =   2790
   ClientWidth     =   4950
   Icon            =   "Trascont.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   1290
   ScaleWidth      =   4950
   ShowInTaskbar   =   0   'False
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   3
      Top             =   0
      Width           =   4950
      _ExtentX        =   8731
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
      Left            =   4110
      Top             =   1680
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
            Picture         =   "Trascont.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Trascont.frx":0624
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin Threed.SSPanel Pnl_Porcentaje 
      Height          =   525
      Left            =   90
      TabIndex        =   0
      Top             =   555
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
      Left            =   105
      TabIndex        =   2
      Top             =   1815
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
      Left            =   1320
      TabIndex        =   1
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
End
Attribute VB_Name = "Traspaso_Contab"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub Cmd_cancelar_Click()

'Unload Me

End Sub


Private Sub Cmd_Generar_Click()

'If MsgBox("Seguro de Generar Archivo ?", 36) <> 6 Then Exit Sub
'
'PROC_GENERA_CONTAB

End Sub
Sub PROC_GENERA_CONTAB()
Dim datos()
Dim Comando$
Dim Base_Fox     As Database
Dim Tabla_Fox    As Recordset
Dim Registros    As Long
Dim Contador     As Long
Dim Fecha_Contab As String

On Error GoTo Error_Carga:

Screen.MousePointer = 11

If Busca_Fin_Mes_Feriado() Then
   Fecha_Contab = Format(gsBac_Feca, "dd/mm/yyyy")
Else
   Fecha_Contab = Format(gsBac_Fecp, "dd/mm/yyyy")
End If

Comando$ = "SP_BUSCA_VOUCHERS '" + Format(gsBac_Fecp, "yyyymmdd") + "'"

If miSQL.SQL_Execute(Comando$) <> 0 Then
   Screen.MousePointer = 0
   Exit Sub
End If

ok_sql% = miSQL.SQL_Fetch(datos())

If ok_sql% <> 0 Then
   Screen.MousePointer = 0
   MsgBox "NO Existen Registros a Cargar.", vbCritical, gsBac_Version
   Exit Sub
End If

Set Base_Fox = OpenDatabase(gsPath_Fox, False, False, "FoxPro 2.6")
Set Tabla_Fox = Base_Fox.OpenRecordset("movcont")

' -------------------------------
' BORRA LOS REGISTROS YA CARGADOS
' -------------------------------
If Tabla_Fox.RecordCount > 0 Then

   Tabla_Fox.MoveFirst
   Do While Not Tabla_Fox.EOF
      Tabla_Fox.Delete
      Tabla_Fox.MoveNext
   Loop
   
End If

' --------------------------
' CARGA LOS REGISTROS NUEVOS
' --------------------------
Contador = 1

Pnl_Porcentaje.FloodPercent = 0

Do While ok_sql% = 0

   Registros = Val(datos(1))

   Pnl_Porcentaje.FloodPercent = (Contador * 100) / Registros

   Contador = Contador + 1
   
   Tabla_Fox.AddNew
   
   Tabla_Fox!ctacont = Val(datos(3))
   Tabla_Fox!tipomon = IIf(datos(4) = "D", 2, 8)
   Tabla_Fox!seccion = 1                           ' CONTABILIDAD
   Tabla_Fox!fecgen = CDate(Fecha_Contab)
   Tabla_Fox!fecval = CDate(Fecha_Contab)
   Tabla_Fox!montoor = Val(datos(5))
   Tabla_Fox!centcost = 0
   Tabla_Fox!cliente = 0
   Tabla_Fox!usr_con = gsBac_User
   Tabla_Fox!voucher = datos(6)
 
   Tabla_Fox.Update

   ok_sql% = miSQL.SQL_Fetch(datos())

Loop

Pnl_Porcentaje.FloodPercent = 100

Screen.MousePointer = 0

Tabla_Fox.Close
Base_Fox.Close

MsgBox "Proceso Terminado.", vbInformation, gsBac_Version

Exit Sub

Error_Carga:

Screen.MousePointer = 0

MsgBox Error(Err), vbCritical, gsBac_Version

Exit Sub

End Sub


Private Sub Form_Load()

Pnl_Porcentaje.FloodPercent = 0

End Sub


Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case UCase(Button.Description)
Case "GENERAR"
    If MsgBox("Seguro de Generar Archivo ?", 36) <> 6 Then Exit Sub
    PROC_GENERA_CONTAB
Case "SALIR"
    Unload Me
End Select
End Sub
