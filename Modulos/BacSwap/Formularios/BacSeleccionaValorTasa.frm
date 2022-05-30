VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form BacSeleccionaValorTasa 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Seleccione Valor Tasa"
   ClientHeight    =   3045
   ClientLeft      =   45
   ClientTop       =   375
   ClientWidth     =   9225
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3045
   ScaleWidth      =   9225
   StartUpPosition =   3  'Windows Default
   Begin MSFlexGridLib.MSFlexGrid mfgGridTasas 
      Height          =   3000
      Left            =   30
      TabIndex        =   0
      Top             =   30
      Width           =   10000
      _ExtentX        =   17648
      _ExtentY        =   5292
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
Attribute VB_Name = "BacSeleccionaValorTasa"
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
    Me.Caption = "Modificando Valor " & Tasa
    '**************************************************************
    '                      CENTRO FORMULARIO
    '**************************************************************
    Me.Move (Screen.Width - Width) / 2, (Screen.Height - Height) / 2
    Call Dibuja_Grilla
    
    If gstrFechaFijacion <> "" Then
        Call TraeValoresTasa(CDate(gstrFechaFijacion), glngCodTasa, glngCodMoneda)
    End If
    
End Sub
Private Sub Dibuja_Grilla()
'*******************************
' ENCABEZADO DE LA GRILLA
'*******************************
    mfgGridTasas.Cols = 8
    mfgGridTasas.Rows = 1
    
    mfgGridTasas.TextMatrix(0, 0) = "Día"
    mfgGridTasas.TextMatrix(0, 1) = "Fecha "
    mfgGridTasas.TextMatrix(0, 2) = "Feriado CHI"
    mfgGridTasas.TextMatrix(0, 3) = "Feriado USA"
    mfgGridTasas.TextMatrix(0, 4) = "Feriado ENG"
    mfgGridTasas.TextMatrix(0, 5) = "Valor Tasa"
    mfgGridTasas.TextMatrix(0, 6) = "Tipo Tasa"
    mfgGridTasas.TextMatrix(0, 7) = "Moneda"
    
    mfgGridTasas.RowHeight(0) = 500
    mfgGridTasas.ColAlignment(0) = 4:   mfgGridTasas.ColWidth(0) = 700
    mfgGridTasas.ColAlignment(1) = 4:   mfgGridTasas.ColWidth(1) = 1100
    mfgGridTasas.ColAlignment(2) = 4:   mfgGridTasas.ColWidth(2) = 1300
    mfgGridTasas.ColAlignment(3) = 4:   mfgGridTasas.ColWidth(3) = 1300
    mfgGridTasas.ColAlignment(4) = 4:   mfgGridTasas.ColWidth(4) = 1300
    mfgGridTasas.ColAlignment(5) = 4:   mfgGridTasas.ColWidth(5) = 1100
    mfgGridTasas.ColAlignment(6) = 4:   mfgGridTasas.ColWidth(6) = 1100
    mfgGridTasas.ColAlignment(7) = 4:   mfgGridTasas.ColWidth(7) = 1100
End Sub
Private Sub TraeValoresTasa(dtFechaFijacion As Date, lCodTasa As Long, lCodMoneda As Long)
Dim Datos()
Dim lCodPeriodo As Long
Screen.MousePointer = vbHourglass
lCodPeriodo = 1

Envia = Array()
AddParam Envia, Format(dtFechaFijacion, "YYYYMMDD")
AddParam Envia, lCodMoneda
AddParam Envia, lCodTasa
AddParam Envia, lCodPeriodo

If Not Bac_Sql_Execute("BacParamSuda..SP_GEN_CUADRO_TASAS", Envia) Then
    MsgBox "Problemas en la ejecución del SP: SP_GEN_CUADRO_TASAS", vbExclamation, TITSISTEMA
    Exit Sub
End If

Do While Bac_SQL_Fetch(Datos())
    Let mfgGridTasas.Rows = mfgGridTasas.Rows + 1
    Let mfgGridTasas.TextMatrix(mfgGridTasas.Rows - 1, 0) = UCase(Format(Datos(1), "ddd"))
    Let mfgGridTasas.TextMatrix(mfgGridTasas.Rows - 1, 1) = Datos(1)
    Let mfgGridTasas.TextMatrix(mfgGridTasas.Rows - 1, 2) = Datos(7)
    Let mfgGridTasas.TextMatrix(mfgGridTasas.Rows - 1, 3) = Datos(8)
    Let mfgGridTasas.TextMatrix(mfgGridTasas.Rows - 1, 4) = Datos(9)
    Let mfgGridTasas.TextMatrix(mfgGridTasas.Rows - 1, 5) = IIf(BacFormatoMonto(Datos(6), 6) <> 0, BacFormatoMonto(Datos(6), 6), "S/I")
    Let mfgGridTasas.TextMatrix(mfgGridTasas.Rows - 1, 6) = Datos(5)
    Let mfgGridTasas.TextMatrix(mfgGridTasas.Rows - 1, 7) = Datos(3)
Loop

Screen.MousePointer = vbDefault
End Sub
Function dtGetFechaHabilByValorRef(dtFechaParam As Date, lngValRef As Long) As Date
Dim iDayPaso As Integer
Dim iDayTemp As Integer
Dim intRespDias As Integer

Dim dtFechaFinal As Date

'***************************
'VARIABLES PARA FERIADOS
'***************************
Dim intFeriadosCL As Integer
Dim intFeriadosUSA As Integer
Dim intFeriadosENG As Integer

Dim blnFeriadosCL As Boolean
Dim blnFeriadosUSA As Boolean
Dim blnFeriadosENG As Boolean

intFeriadosCL = glngFeriadoCL
intFeriadosUSA = glngFeriadoUSA
intFeriadosENG = glngFeriadoENG


If lngValRef > 0 Then
    iDayPaso = lngValRef
Else
    iDayPaso = lngValRef * -1
End If

Do While iDayTemp < iDayPaso
    If intRespDias > 0 Then
        dtFechaFinal = DateAdd("d", 1, dtFechaFinal)
    Else
        dtFechaFinal = DateAdd("d", -1, dtFechaFinal)
    End If
    '***************************************
    ' SETEO VARIABLES BOOLEAN EN FALSE
    '***************************************
    blnFeriadosCL = False
    blnFeriadosUSA = False
    blnFeriadosENG = False
    '***************************************
    ' REVISO FERIADOS CL
    '***************************************
    If intFeriadosCL = 1 Then
        If blnFechaFinNoHabil(dtFechaFinal, Chile) = True Then
            blnFeriadosCL = True
        End If
    End If
    '***************************************
    ' REVISO FERIADOS USA
    '***************************************
    If intFeriadosUSA = 1 Then
        If blnFechaFinNoHabil(dtFechaFinal, EstadosUnidos) = True Then
            blnFeriadosUSA = True
        End If
    End If
    '***************************************
    ' REVISO FERIADOS ENG
    '***************************************
    If intFeriadosENG = 1 Then
        If blnFechaFinNoHabil(dtFechaFinal, Inglaterra) = True Then
            blnFeriadosENG = True
        End If
    End If
    '*********************************************************************
    '  AUMENTO CONTADOR SOLO CUANDO ES DÍA HABIL EN TODOS LOS CALENDARIOS
    '*********************************************************************
    If blnFeriadosCL = False And blnFeriadosUSA = False And blnFeriadosENG = False Then
        iDayTemp = iDayTemp + 1
    End If
Loop

End Function
Function blnFechaFinNoHabil(dtFecFinFlujo As Date, intPlaza As Integer) As Boolean
Dim clsDiasFeriados As New clsFeriado
Dim intYear As Integer
Dim intMonth As Integer
Dim intDay As Integer
Dim strDays As String
Dim intPos As Integer

intYear = CInt(Format(dtFecFinFlujo, "yyyy"))
intMonth = CInt(Format(dtFecFinFlujo, "mm"))
intDay = CInt(Format(dtFecFinFlujo, "dd"))

If clsDiasFeriados.Leer(intYear, CStr(intPlaza)) = True Then
    Select Case intMonth
        Case 1:
            strDays = clsDiasFeriados.feene
        Case 2:
            strDays = clsDiasFeriados.fefeb
        Case 3:
            strDays = clsDiasFeriados.femar
        Case 4:
            strDays = clsDiasFeriados.feabr
        Case 5:
            strDays = clsDiasFeriados.femay
        Case 6:
            strDays = clsDiasFeriados.fejun
        Case 7:
            strDays = clsDiasFeriados.fejul
        Case 8:
            strDays = clsDiasFeriados.feago
        Case 9:
            strDays = clsDiasFeriados.fesep
        Case 10:
            strDays = clsDiasFeriados.feoct
        Case 11:
            strDays = clsDiasFeriados.fenov
        Case 12:
            strDays = clsDiasFeriados.fedic
    End Select
    
    If intDay < 10 Then
        intPos = InStr(1, strDays, "0" & CStr(intDay))
    Else
        intPos = InStr(1, strDays, intDay)
    End If
    If intPos = 0 Then
        blnFechaFinNoHabil = False
    Else
        blnFechaFinNoHabil = True
    End If
End If
End Function
Private Sub mfgGridTasas_DblClick()
Dim Respuesta As Integer
'Respuesta = 2
'If mfgGridTasas.RowSel > 0 Then
 '   gdblValorTasaFlujo = 0
  '  gdblValorTasaFlujo = CDbl(mfgGridTasas.TextMatrix(mfgGridTasas.RowSel, 5))
    
    
   ' gstrFechaFinal = ""
    'gstrFechaFinal = Trim(mfgGridTasas.TextMatrix(mfgGridTasas.RowSel, 1))
    'Unload Me
'End If
''''''''''''''''''''
If mfgGridTasas.RowSel > 0 Then
    If mfgGridTasas.TextMatrix(mfgGridTasas.RowSel, 5) = "S/I" Then
         MsgBox "Día Sin Valor de Tasa", vbExclamation
         Exit Sub
    End If
    
    If mfgGridTasas.TextMatrix(mfgGridTasas.RowSel, 2) = "X" Then Respuesta = MsgBox("Ha Seleccionado Día Festivo en Chile ", vbQuestion + vbOKCancel, "Día Festivo")
    If mfgGridTasas.TextMatrix(mfgGridTasas.RowSel, 3) = "X" Then Respuesta = MsgBox("Ha Seleccionado Día Festivo en Estados Unidos", vbQuestion + vbOKCancel, "Día Festivo")
    If mfgGridTasas.TextMatrix(mfgGridTasas.RowSel, 4) = "X" Then Respuesta = MsgBox("Ha Seleccionado Día Festivo en Inglaterra ", vbQuestion + vbOKCancel, "Día Festivo")
    If Respuesta = 2 Then Exit Sub
    gdblValorTasaFlujo = CDbl(mfgGridTasas.TextMatrix(mfgGridTasas.RowSel, 5))
    gstrFechaFinal = Trim(mfgGridTasas.TextMatrix(mfgGridTasas.RowSel, 1))
    
        
    Unload Me
End If



End Sub

