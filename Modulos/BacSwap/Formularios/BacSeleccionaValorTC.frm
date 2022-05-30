VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form BacSeleccionaValorTC 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Seleccione Valor de TC"
   ClientHeight    =   3375
   ClientLeft      =   45
   ClientTop       =   375
   ClientWidth     =   7515
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3375
   ScaleWidth      =   7515
   StartUpPosition =   3  'Windows Default
   Begin MSFlexGridLib.MSFlexGrid mfgGridTasas 
      Height          =   3270
      Left            =   30
      TabIndex        =   0
      Top             =   60
      Width           =   7440
      _ExtentX        =   13123
      _ExtentY        =   5768
      _Version        =   393216
      Cols            =   12
      FixedCols       =   0
      BackColor       =   -2147483644
      BackColorFixed  =   -2147483646
      ForeColorFixed  =   -2147483639
      BackColorBkg    =   -2147483636
      GridLines       =   2
      GridLinesFixed  =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
End
Attribute VB_Name = "BacSeleccionaValorTC"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
'CONSTANTES DEL FORMULARIO
Const Chile = 6
Const EstadosUnidos = 225
Const Inglaterra = 510
Private Sub Form_Load()
Me.Icon = BACSwap.Icon
Me.Caption = "Modificando Valor " & TC
'**************************************************************
'                      CENTRO FORMULARIO
'**************************************************************
Me.Move (Screen.Width - Width) / 2, (Screen.Height - Height) / 2
'**************************************************************
'                      Creo formato de la grilla
'**************************************************************
Call Dibuja_Grilla_TC

'**************************************************************
'                      Realiza consulta SP
'**************************************************************
If gstrFechaFijacion <> "" Then
    Call TraeValoresTC(CDate(gstrFechaFijacion), glngCodMoneda)
End If
End Sub
Private Sub TraeValoresTC(dtFechaFijacion As Date, lCodTasa As Long)
Dim Datos()
Screen.MousePointer = vbHourglass

Envia = Array()
AddParam Envia, Format(dtFechaFijacion, "YYYYMMDD")
AddParam Envia, lCodTasa

If Not Bac_Sql_Execute("BacParamSuda..SP_GEN_CUADRO_MONEDA", Envia) Then
    MsgBox "Problemas en la ejecución del SP: SP_GEN_CUADRO_MONEDA", vbExclamation, TITSISTEMA
    Exit Sub
End If
Do While Bac_SQL_Fetch(Datos())
    Let mfgGridTasas.Rows = mfgGridTasas.Rows + 1
    Let mfgGridTasas.TextMatrix(mfgGridTasas.Rows - 1, 0) = UCase(Format(Datos(1), "ddd"))
    Let mfgGridTasas.TextMatrix(mfgGridTasas.Rows - 1, 1) = Datos(1)
    Let mfgGridTasas.TextMatrix(mfgGridTasas.Rows - 1, 2) = IIf(BacFormatoMonto(Datos(4), 6) <> 0, BacFormatoMonto(Datos(4), 6), "S/I")
    Let mfgGridTasas.TextMatrix(mfgGridTasas.Rows - 1, 3) = Datos(6)
    Let mfgGridTasas.TextMatrix(mfgGridTasas.Rows - 1, 4) = Datos(5)
    Let mfgGridTasas.TextMatrix(mfgGridTasas.Rows - 1, 5) = Datos(7)
Loop
Screen.MousePointer = vbDefault
End Sub
Private Sub Dibuja_Grilla_TC()
    mfgGridTasas.Cols = 6
    mfgGridTasas.Rows = 1
    
    mfgGridTasas.TextMatrix(0, 0) = "Día"
    mfgGridTasas.TextMatrix(0, 1) = "Fecha "
    mfgGridTasas.TextMatrix(0, 2) = "Valor TC"
    mfgGridTasas.TextMatrix(0, 3) = "Feriado CHI"
    mfgGridTasas.TextMatrix(0, 4) = "Feriado USA"
    mfgGridTasas.TextMatrix(0, 5) = "Feriado ENG"

    mfgGridTasas.RowHeight(0) = 500
    mfgGridTasas.ColAlignment(0) = 4:   mfgGridTasas.ColWidth(0) = 700
    mfgGridTasas.ColAlignment(1) = 4:   mfgGridTasas.ColWidth(1) = 1300
    mfgGridTasas.ColAlignment(2) = 4:   mfgGridTasas.ColWidth(2) = 1300
    mfgGridTasas.ColAlignment(3) = 4:   mfgGridTasas.ColWidth(3) = 1300
    mfgGridTasas.ColAlignment(4) = 4:   mfgGridTasas.ColWidth(4) = 1100
    mfgGridTasas.ColAlignment(5) = 4:   mfgGridTasas.ColWidth(5) = 1100
End Sub
Private Sub mfgGridTasas_DblClick()
Dim Respuesta As Integer
'Respuesta = 2
gdblValorTasaFlujo = 0
If mfgGridTasas.RowSel > 0 Then
    If mfgGridTasas.TextMatrix(mfgGridTasas.RowSel, 2) = "S/I" Then
         MsgBox "Día Sin Tipo de Cambio", vbExclamation
         Exit Sub
    End If
    
    If mfgGridTasas.TextMatrix(mfgGridTasas.RowSel, 3) = "X" Then Respuesta = MsgBox("Ha Seleccionado Día Festivo en Chile ", vbQuestion + vbOKCancel, "Día Festivo")
    If mfgGridTasas.TextMatrix(mfgGridTasas.RowSel, 4) = "X" Then Respuesta = MsgBox("Ha Seleccionado Día Festivo en Estados Unidos", vbQuestion + vbOKCancel, "Día Festivo")
    If mfgGridTasas.TextMatrix(mfgGridTasas.RowSel, 5) = "X" Then Respuesta = MsgBox("Ha Seleccionado Día Festivo en Inglaterra ", vbQuestion + vbOKCancel, "Día Festivo")
    If Respuesta = 2 Then Exit Sub

    gdblValorTasaFlujo = mfgGridTasas.TextMatrix(mfgGridTasas.RowSel, 2)
    gdblFechaTasaFlujo = mfgGridTasas.TextMatrix(mfgGridTasas.RowSel, 1)

        
    Unload Me
End If
End Sub
