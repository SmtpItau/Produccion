VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "COMCTL32.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacInicioDia 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Inicio de Día"
   ClientHeight    =   3000
   ClientLeft      =   1830
   ClientTop       =   2235
   ClientWidth     =   4275
   FillStyle       =   0  'Solid
   Icon            =   "bacinidia.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   3000
   ScaleWidth      =   4275
   ShowInTaskbar   =   0   'False
   Begin ComctlLib.Toolbar Toolbar1 
      Height          =   480
      Left            =   15
      TabIndex        =   8
      Top             =   0
      Width           =   4275
      _ExtentX        =   7541
      _ExtentY        =   847
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   327682
      BeginProperty Buttons {0713E452-850A-101B-AFC0-4210102A8DA7} 
         NumButtons      =   2
         BeginProperty Button1 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   ""
            Object.ToolTipText     =   "Grabar"
            Object.Tag             =   ""
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   ""
            Object.ToolTipText     =   "Salir"
            Object.Tag             =   ""
            ImageIndex      =   2
         EndProperty
      EndProperty
   End
   Begin BACControles.TXTNumero TEXT1 
      Height          =   255
      Left            =   270
      TabIndex        =   7
      Top             =   2040
      Visible         =   0   'False
      Width           =   720
      _ExtentX        =   1270
      _ExtentY        =   450
      BackColor       =   14737632
      Enabled         =   -1  'True
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BorderStyle     =   0
      Text            =   "0.0000"
      Text            =   "0.0000"
      Max             =   "999999.9999"
      CantidadDecimales=   "4"
   End
   Begin VB.Frame Frame2 
      Height          =   1020
      Left            =   0
      TabIndex        =   1
      Top             =   4110
      Visible         =   0   'False
      Width           =   3870
      Begin VB.CommandButton cmdGrabar 
         Caption         =   "&Grabar"
         Height          =   780
         Left            =   1320
         Picture         =   "bacinidia.frx":0442
         Style           =   1  'Graphical
         TabIndex        =   3
         Top             =   165
         Width           =   1200
      End
      Begin VB.CommandButton cmdSalir 
         Caption         =   "&Salir"
         Height          =   780
         Left            =   2520
         Picture         =   "bacinidia.frx":0884
         Style           =   1  'Graphical
         TabIndex        =   4
         Top             =   165
         Width           =   1200
      End
   End
   Begin MSFlexGridLib.MSFlexGrid msfValores 
      Height          =   1545
      Left            =   -15
      TabIndex        =   2
      Top             =   1440
      Width           =   4275
      _ExtentX        =   7541
      _ExtentY        =   2725
      _Version        =   393216
      Rows            =   4
      Cols            =   4
      BackColor       =   12632256
      BackColorFixed  =   8421376
      ForeColorFixed  =   -2147483634
      FillStyle       =   1
      GridLines       =   2
   End
   Begin VB.Frame Frame1 
      Caption         =   "Parámetros de Inicio"
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
      Height          =   975
      Left            =   45
      TabIndex        =   0
      Top             =   465
      Width           =   4230
      Begin BACControles.TXTFecha ucFechaProc 
         Height          =   375
         Left            =   105
         TabIndex        =   6
         Top             =   375
         Width           =   1830
         _ExtentX        =   3228
         _ExtentY        =   661
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "25/10/2000"
      End
      Begin VB.Label lblDia 
         Alignment       =   2  'Center
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00808000&
         Height          =   375
         Left            =   1980
         TabIndex        =   5
         Top             =   375
         Width           =   1770
      End
   End
   Begin ComctlLib.ImageList ImageList1 
      Left            =   780
      Top             =   5280
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   327682
      BeginProperty Images {0713E8C2-850A-101B-AFC0-4210102A8DA7} 
         NumListImages   =   2
         BeginProperty ListImage1 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "bacinidia.frx":0B8E
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "bacinidia.frx":0EA8
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "BacInicioDia"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim PasoTexto As String
Dim lInicioDia As Variant


'CONSTANTES DE BOTONES DE LA TOOLBAR
Const BtnGrabar = 1
Const btnSalir = 2
Function Chequea_Datos()
Dim i As Integer

Chequea_Datos = False

For i = 1 To msfValores.Rows - 1
    If msfValores.TextMatrix(i, 1) <> "" Then
       If msfValores.TextMatrix(i, 2) = "" Then
            MsgBox "Debe Ingresar Valores para la Moneda " & msfValores.TextMatrix(i, 1), vbCritical, "Control de Valores"
            msfValores.SetFocus
            Exit Function
       End If
    End If
Next i

Chequea_Datos = True

End Function

Function ChequeaInicio()
Dim SQL$
Dim Datos()

ChequeaInicio = True

'Sql$ = "EXECUTE sp_ContRol_Procesos "
'Sql$ = Sql$ & PAR_INICIO_DIA

Envia = Array()
AddParam Envia, PAR_INICIO_DIA

'If MISQL.SQL_Execute(Sql$) = 0 Then
If Bac_Sql_Execute("SP_CONTROL_PROCESOS", Envia) Then

'   While MISQL.SQL_Fetch(DATOS()) = 0
    While Bac_SQL_Fetch(Datos())
      
      lInicioDia = Val(Datos(1))
   
   Wend
   
End If

If lInicioDia = 1 Then
   MsgBox "Proceso de Inicio de Día ya fue realizado", vbInformation, "Control de Inicio de Día"
   ChequeaInicio = False
End If

End Function
Sub LimpiaTablasSim()
If Not Bac_Sql_Execute("SP_RESET_TABLAS_SIM") Then
End If
End Sub
Sub GrabaInicioDia()

    Dim SQL$
    Dim Datos()
    Dim cMsg$
    Dim cTexto$
    Dim nRetorno   As Integer
    Dim i          As Integer
    Dim nProblemas As Integer
    Dim lRet       As Boolean
    Dim fechaprox As String

    Screen.MousePointer = vbHourglass
    
    cMsg$ = "Inicio de Día NO Realizado"
    cTexto$ = ""
    nProblemas = 0

    fechaprox = BacProxHabil(ucFechaProc.Text)

    Envia = Array()
    AddParam Envia, Format(ucFechaProc.Text, "yyyymmdd")
    AddParam Envia, Format(fechaprox, "yyyymmdd")

    If Not Bac_Sql_Execute("SP_INICIODIA", Envia) Then
        lRet = True
        Select Case nRetorno
               Case -100: cTexto$ = "NO pudo actualizar estado de flujos"
               Case -101: cTexto$ = "NO pudo cargar registros en Cartera Historica"
               Case -102: cTexto$ = "NO pudo cargar registros en Archivo de Log"
               Case -103: cTexto$ = "NO pudo rebajar los Flujos Vencidos"
               Case -104: cTexto$ = "NO pudo Limpiar archivo de Movimientos del Día"
               Case -105: cTexto$ = "NO pudo Actualizar archivo de Parámetros"
               Case -110: cTexto$ = "NO pudo Liberar las operaciones con Garantías"
               Case Else: lRet = False
        End Select
        
        If lRet Then
            Screen.MousePointer = vbDefault
            MsgBox "Problemas al grabar datos en Inicio de Día, vbCritical, cMsg$"
            nProblemas = nProblemas + 1
        End If
    End If
   
    '==========================
    ' Carga valores de Monedas
    '==========================

    Dim datos2()
    For i = 1 To msfValores.Rows - 1

        If msfValores.TextMatrix(i, 1) <> "" Then
        
            Envia = Array()
            AddParam Envia, CDbl(msfValores.TextMatrix(i, 3))
            AddParam Envia, Format(ucFechaProc.Text, "yyyymmdd")
            AddParam Envia, CDbl(msfValores.TextMatrix(i, 2))
        
            If Not Bac_Sql_Execute("SP_GRABA_VALORESMONEDA", Envia) Then
                Screen.MousePointer = vbDefault
                MsgBox "Problemas al grabar la moneda " & Trim(msfValores.TextMatrix(i, 1)), vbCritical, "Actualización de Monedas"
                nProblemas = nProblemas + 1
            End If
        End If
    Next i

    cMsg$ = "Inicio de Día"

    If nProblemas > 0 Then
        Screen.MousePointer = vbDefault
        MsgBox "Ocurrieron " + Str(nProblemas) + " Error durante el Proceso de Inicio de Día", vbCritical, cMsg$
    Else
        Screen.MousePointer = vbDefault
        MsgBox "Proceso de Inicio de Día termino Exitosamente", vbInformation, cMsg$
        
        If gsc_Parametros.DatosGenerales() Then
            Call AsignaValoresParametros
            Call DatosBarraSistema
            BACSwap.Opc_20700.Checked = False
        Else
            Screen.MousePointer = vbDefault
            MsgBox "Error en la recuperación de la tabla de parámetros.", vbCritical, "MENSAJE"
        End If
    End If

   Envia = Array()
   If Not Bac_Sql_Execute("BacParamSuda..SP_GENERACION_AUTOMATICA_ICP") Then
      MsgBox "Actualización de Líneas Generales no se ha podido realizar." & vbCrLf & "Comiquese con su Administrador.", vbExclamation, TITSISTEMA
      Exit Sub
   End If
   If Bac_SQL_Fetch(Datos()) Then
      If Datos(1) < 0 Then
         MsgBox "Actualización de Líneas Generales no se ha podido realizar." & vbCrLf & "Comiquese con su Administrador.", vbExclamation, TITSISTEMA
         Exit Sub
      End If
   End If

    '+++CONTROL IDD, jcamposd procedimiento realiza un return, por lo que no recalcula línea
    Envia = Array()
    If Not Bac_Sql_Execute("SP_RECALC_LINEAS_SWAP", Envia) Then
        Screen.MousePointer = vbDefault
        MsgBox "Error al Cargar Lineas Swap.", vbCritical, "MENSAJE"
    End If

    Screen.MousePointer = vbDefault

End Sub
Private Sub cmdGrabar_Click()

If Not Chequea_Datos() Then Exit Sub

Call GrabaInicioDia

Call LimpiaTablasSim

Unload Me

End Sub

Private Sub cmdSalir_Click()

'If MsgBox("Esta seguro de Salir?", 36) = vbYes Then
   Unload Me
'End If

End Sub

Private Sub Form_Load()
    Me.Icon = BACSwap.Icon
    Me.Top = 1620
    Me.Left = 1350
   
    '====================< Titulos
    msfValores.Rows = 6
    msfValores.Cols = 4
    msfValores.TextMatrix(0, 1) = "   Moneda"
    msfValores.TextMatrix(0, 2) = "   Valor"
    
    '====================< Aspecto
    msfValores.RowHeight(0) = 250
    msfValores.ColWidth(0) = 1
    msfValores.ColWidth(1) = 2190
    msfValores.ColWidth(2) = 1450
    msfValores.ColWidth(3) = 1
    
    '============================< Fecha Anterior de Proceso
    ucFechaProc.Text = BacProxHabil(gsBAC_Fecp)
    lblDia.Caption = BacDiaSem(ucFechaProc.Text)
    ucFechaProc.MinDate = ucFechaProc.Text
    'ucFechaProc.BISIESTO (Year(gsBAC_Fecp))
    ucFechaProc.Enabled = False
    TEXT1.Text = ""
    If Not GeneraGrilla() Then
       MsgBox "Error en la Conexión!!", 48
    End If
    

End Sub

Function GeneraGrilla()
Dim SQL As String
Dim Datos()
Dim nRows As Integer
Dim AuxFecha As Date

GeneraGrilla = True
cmdGrabar.Enabled = False
'giSQL_DatabaseCommon = "bacparametros"
nRows = 1

'AuxFecha = Format(ucFechaProc.Text, "yyyymmdd")

SQL = "SP_BUSCA_VALORES_MERCADO "
SQL = SQL & "'PCS'"
SQL = SQL & ",'" & Format(ucFechaProc.Text, "yyyymmdd") & "'"

Envia = Array()
AddParam Envia, "PCS"
AddParam Envia, Format(ucFechaProc.Text, "yyyymmdd")

'If MISQL.SQL_Execute(Sql) <> 0 Then
If Not Bac_Sql_Execute("SP_BUSCA_VALORES_MERCADO", Envia) Then
   GeneraGrilla = False
   MsgBox "Error en la Conexión!!", 48
   Exit Function
End If
    
'    Do While MISQL.SQL_Fetch(DATOS()) = 0
    Do While Bac_SQL_Fetch(Datos())
          
          msfValores.TextMatrix(nRows%, 1) = Datos(1)
          msfValores.TextMatrix(nRows%, 2) = BacStrTran((Datos(2)), ".", gsc_PuntoDecim)
          'BacFormatoMonto(Datos(2), 4)
          msfValores.TextMatrix(nRows%, 3) = Val(Datos(3))
          
          nRows% = nRows% + 1
          cmdGrabar.Enabled = True
    Loop

End Function


Private Sub Form_Unload(Cancel As Integer)
BACSwap.Enabled = True
End Sub

Private Sub msfValores_KeyPress(KeyAscii As Integer)

'If Not (KeyAscii < 57 And KeyAscii > 48) Then Exit Sub

If KeyAscii = 13 And msfValores.Col = 2 Then
     
  With msfValores
     
     If Trim$(msfValores.TextMatrix(.Row, 1)) <> "" Then
     
    
     
        PROC_POSICIONA_TEXTO msfValores, TEXT1
        .Enabled = False
        TEXT1.Visible = True
        TEXT1.Text = msfValores.TextMatrix(.Row, .Col)
        TEXT1.SetFocus
        SendKeys "{RIGHT}"    'Comienzo Izquierda

     
     
     
    ' TEXT1.Visible = True
    ' Call PROC_POSICIONA_TEXTO(msfValores, TEXT1)
    ' TEXT1.SetFocus
     
     'Text1.Text = Chr(KeyAscii)
     'Text1.Refresh
     
     End If
     
   End With
     
   
   
  End If
  
End Sub

Private Sub Text1_KeyPress(KeyAscii As Integer)

With msfValores
 
  '  PROC_FMT_NUMERICO text1, 6, 4, KeyAscii, "", gsc_PuntoDecim

    Select Case KeyAscii
    
    Case 13
        .TextMatrix(.Row, .Col) = Format(TEXT1.Text, "#,##0.0000")
        TEXT1.Text = ""
        .Enabled = True
        TEXT1.Visible = False
        .SetFocus
    
    Case 27
        TEXT1.Text = ""
        TEXT1.Visible = False
        .Enabled = True
        .SetFocus
        
    End Select
    
End With


'If KeyAscii = 13 Then

   ' msfValores.TextMatrix(msfValores.Row, 2) = Trim(TEXT1.Text)
   ' TEXT1.Visible = False

'End If

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As ComctlLib.Button)

    Select Case Button.Index
        Case BtnGrabar
            Call cmdGrabar_Click
        
        Case btnSalir
            Unload Me
    End Select
    
End Sub

Private Sub ucFechaProc_Change()

'    ucFechaProc.Text = Format(ucFechaProc.Text, gsc_FechaDMA)
'
'    lblDia.Caption = BacDiaSem(ucFechaProc.Text)
'
'    If Not BacEsHabil(ucFechaProc.Text) Then
'        lblDia.ForeColor = vbRed
'    Else
'        lblDia.ForeColor = vbBlack
'    End If
'
'    If CDate(ucFechaProc.Text) < CDate(gsBAC_Fecp) Then
'        MsgBox "Fecha No puede ser menor a la de Procesos", vbCritical, Msj
'        ucFechaProc.Text = gsBAC_Fecp
'        ucFechaProc.SetFocus
'    End If

End Sub

Function ValidaDatos() As Boolean

Dim i As Integer

ValidaDatos = False

If CDate(ucFechaProc.Text) <= CDate(gsBAC_Fecp) Then
   MsgBox "Fecha ya fue Procesada", vbInformation, Msj
   Exit Function
End If


For i = 1 To msfValores.Rows - 1
    
    If msfValores.TextMatrix(i, 1) <> "" Then
       If msfValores.TextMatrix(i, 2) = "" And msfValores.TextMatrix(i, 1) <> "" Then
            MsgBox "Debe Ingresar Valores para la Moneda " & msfValores.TextMatrix(i, 1), vbCritical, "Control de Valores"
            msfValores.SetFocus
            Exit Function
       End If
    ElseIf msfValores.TextMatrix(i, 2) = "" And msfValores.TextMatrix(i, 1) = "" Then
            MsgBox "Debe Ingresar Valores para la Moneda " & msfValores.TextMatrix(i, 1), vbCritical, "Control de Valores"
            msfValores.SetFocus
            Exit Function
    End If

Next i

ValidaDatos = True

End Function

Private Sub ucFechaProc_Click()

'lblDia.Caption = BacDiaSem(ucFechaProc.Text)

'If Not BacEsHabil(ucFechaProc.Text) Then
'   lblDia.ForeColor = "H000000FF"
'End If

End Sub


Private Sub ucFechaProc_KeyPress(KeyAscii As Integer)

'If KeyAscii = 13 Then SendKeys "{tab}"

End Sub


Private Sub ucFechaProc_LostFocus()

'If Not BacEsHabil(ucFechaProc.Text) Then
'   MsgBox "Fecha NO es día Hábil", vbCritical, "Control de Fecha"
'   ucFechaProc.SetFocus
'End If
'
'ucFechaProc_Change
'
'ucFechaProc.Text = Format(ucFechaProc.Text, gsc_FechaDMA)

End Sub


Private Sub UserControl_Numero1_Click()

End Sub
