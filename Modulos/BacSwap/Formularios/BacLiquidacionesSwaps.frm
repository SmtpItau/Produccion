VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "comctl32.ocx"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacLiquidacionesSwaps 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Liquidaciones de Vencimiento"
   ClientHeight    =   6240
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   9015
   Icon            =   "BacLiquidacionesSwaps.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   6240
   ScaleWidth      =   9015
   ShowInTaskbar   =   0   'False
   Begin ComctlLib.Toolbar Toolbar1 
      Height          =   480
      Left            =   75
      TabIndex        =   10
      Top             =   0
      Width           =   8895
      _ExtentX        =   15690
      _ExtentY        =   847
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   327682
      BeginProperty Buttons {0713E452-850A-101B-AFC0-4210102A8DA7} 
         NumButtons      =   4
         BeginProperty Button1 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Object.ToolTipText     =   "Pantalla"
            Object.Tag             =   ""
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Object.ToolTipText     =   "Impresora"
            Object.Tag             =   ""
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Caption         =   "M"
            Key             =   "X"
            Description     =   "X"
            Object.ToolTipText     =   "X"
            Object.Tag             =   "X"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Object.ToolTipText     =   "Salir"
            Object.Tag             =   ""
            ImageIndex      =   4
         EndProperty
      EndProperty
      MouseIcon       =   "BacLiquidacionesSwaps.frx":0442
   End
   Begin VB.CommandButton btnPantalla 
      Caption         =   "&Pantalla"
      Height          =   780
      Left            =   4260
      Picture         =   "BacLiquidacionesSwaps.frx":075C
      Style           =   1  'Graphical
      TabIndex        =   1
      ToolTipText     =   "Informe vista previa en Pantalla"
      Top             =   6960
      Visible         =   0   'False
      Width           =   1185
   End
   Begin VB.Frame Frame2 
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   9
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   5220
      Left            =   75
      TabIndex        =   5
      Top             =   390
      Width           =   8940
      Begin BACControles.TXTFecha txtFechaOperacion 
         Height          =   375
         Left            =   3225
         TabIndex        =   9
         Top             =   240
         Width           =   1335
         _ExtentX        =   2355
         _ExtentY        =   661
         Enabled         =   -1  'True
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
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "25/10/2000"
      End
      Begin VB.CommandButton OK 
         Caption         =   "o.k."
         Height          =   390
         Left            =   4590
         Picture         =   "BacLiquidacionesSwaps.frx":0B9E
         Style           =   1  'Graphical
         TabIndex        =   0
         Top             =   225
         Width           =   555
      End
      Begin MSFlexGridLib.MSFlexGrid grdLista 
         Height          =   4155
         Left            =   45
         TabIndex        =   4
         Top             =   975
         Width           =   8640
         _ExtentX        =   15240
         _ExtentY        =   7329
         _Version        =   393216
         FixedCols       =   0
         BackColor       =   12632256
         ForeColor       =   0
         BackColorFixed  =   8421376
         ForeColorFixed  =   16777215
         BackColorSel    =   8388608
         FocusRect       =   2
         GridLines       =   2
         SelectionMode   =   1
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin VB.Label etqTitulo 
         Alignment       =   2  'Center
         BackColor       =   &H00800000&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   330
         Left            =   45
         TabIndex        =   7
         Top             =   660
         Width           =   8730
      End
      Begin VB.Label lblEtiqueta 
         AutoSize        =   -1  'True
         Caption         =   "Fecha"
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
         Index           =   7
         Left            =   2580
         TabIndex        =   6
         Top             =   315
         Width           =   540
      End
   End
   Begin VB.CommandButton btnSalir 
      Caption         =   "&Salir"
      Height          =   780
      Left            =   6915
      Picture         =   "BacLiquidacionesSwaps.frx":10D0
      Style           =   1  'Graphical
      TabIndex        =   3
      Top             =   6960
      Visible         =   0   'False
      Width           =   1185
   End
   Begin VB.CommandButton btnImpresora 
      Caption         =   "&Impresora"
      Height          =   780
      Left            =   5520
      Picture         =   "BacLiquidacionesSwaps.frx":13DA
      Style           =   1  'Graphical
      TabIndex        =   2
      ToolTipText     =   "Informe directo a Impresora"
      Top             =   6960
      Visible         =   0   'False
      Width           =   1185
   End
   Begin ComctlLib.ImageList ImageList1 
      Left            =   1920
      Top             =   7035
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   327682
      BeginProperty Images {0713E8C2-850A-101B-AFC0-4210102A8DA7} 
         NumListImages   =   4
         BeginProperty ListImage1 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "BacLiquidacionesSwaps.frx":16E4
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "BacLiquidacionesSwaps.frx":19FE
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "BacLiquidacionesSwaps.frx":1D18
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "BacLiquidacionesSwaps.frx":2032
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.Label EtqMensaje 
      Caption         =   "EtqMensaje"
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   9
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   240
      Left            =   165
      TabIndex        =   8
      Top             =   5820
      Width           =   3615
   End
End
Attribute VB_Name = "BacLiquidacionesSwaps"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Function GeneraLiquidaVctos(Donde As DestinationConstants) As Boolean
   On Error GoTo Control
   Dim Num        As Integer
   Dim Origen     As Integer
   Dim Fecha      As Date
   Dim TiProd     As Integer


   If grdLista.Row = 0 Then
      Exit Function
   End If
   If grdLista.TextMatrix(grdLista.Row, 0) = "" Or grdLista.Tag = "" Or grdLista.TextMatrix(grdLista.Row, 8) = "" Then
      MsgBox "Datos incorrectos para generar Liquidación.", vbInformation, TITSISTEMA
      Exit Function
   End If
   
   Screen.MousePointer = vbHourglass
   
   
   Num = grdLista.TextMatrix(grdLista.Row, 0)
   Fecha = grdLista.Tag
   TiProd = Val(grdLista.TextMatrix(grdLista.Row, 8))

   Call BacLimpiaParamCrw

   BACSwap.Crystal.WindowTitle = "Carta de Liquidación de Flujos."
   'CER 05/11/2008 - Se cambia reporte.
   BACSwap.Crystal.ReportFileName = gsRPT_Path & "Carta_Liquidacion_Swap_Flujos_Multiples.rpt"
   BACSwap.Crystal.StoredProcParam(0) = Num
   BACSwap.Crystal.StoredProcParam(1) = Format(grdLista.TextMatrix(grdLista.Row, 9), "YYYY-MM-DD 00:00:00.000") 'Format(Fecha, "YYYY-MM-DD 00:00:00.000") Modificado el día 06-04-2015 PRD21657
   BACSwap.Crystal.StoredProcParam(2) = Format(grdLista.TextMatrix(grdLista.Row, 9), "YYYY-MM-DD 00:00:00.000") 'Incorporado el día 06-04-2015 PRD21657
   BACSwap.Crystal.Connect = swConeccion
   BACSwap.Crystal.Destination = Donde
   BACSwap.Crystal.Action = 1
   
'If TiProd = 1 Or TiProd = 4 Then
'   BACSwap.Crystal.ReportFileName = gsRPT_Path & "BacCartaLiquidacionTasa.rpt"
'   BACSwap.Crystal.WindowTitle = "Carta Liquidación Swap de Tasas"
'Else
'   BACSwap.Crystal.ReportFileName = gsRPT_Path & "BacCartaLiquidacionTasa.rpt"
'  'BACSwap.Crystal.ReportFileName = gsRPT_Path & "BacCartaLiquidacionMon.rpt"
'   BACSwap.Crystal.WindowTitle = "Carta Liquidación Swap de Monedas"
'End If
'BACSwap.Crystal.StoredProcParam(0) = num
'BACSwap.Crystal.StoredProcParam(1) = giSQL_DatabaseCommon
'BACSwap.Crystal.StoredProcParam(2) = Format(Fecha, "YYYYMMDD")
'BACSwap.Crystal.Connect = swConeccion
'BACSwap.Crystal.Destination = Donde
'BACSwap.Crystal.Action = 1
   
   Screen.MousePointer = vbDefault
Exit Function
Control:
   Select Case BACSwap.Crystal.LastErrorNumber
      Case 20527
         MsgBox "No Existen datos para generar informe solicitado", vbInformation, Msj
      Case Else
         If BACSwap.Crystal.LastErrorString <> "" Then
            'MsgBox BACSwap.Crystal.LastErrorString, vbCritical, Msj
            MsgBox "Debe Revisar Referencias de Mercado para Operación", vbCritical, Msj
         Else
            MsgBox err.Description, vbCritical, Msj
         End If
   End Select
   
   Screen.MousePointer = vbDefault
   
End Function

Private Sub btnSalir_Click()
    Unload Me
End Sub

Private Sub Form_Load()
   Me.Icon = BACSwap.Icon
   Call InicializaGrilla
   txtFechaOperacion.MaxDate = gsBAC_Fecp
   txtFechaOperacion.Text = gsBAC_Fecp
   etqTitulo.Caption = "Operaciones Vencidas"
   EtqMensaje.Caption = ""
End Sub

Function InicializaGrilla()
   Dim i As Integer
   
   grdLista.Cols = 11
   grdLista.Rows = 15

   grdLista.RowHeight(0) = 500
   grdLista.TextMatrix(0, 0) = "N° Oper."
   grdLista.TextMatrix(0, 1) = "Tip.Oper."
   grdLista.TextMatrix(0, 2) = "Tip.Prod."
   grdLista.TextMatrix(0, 3) = "Cliente"
   grdLista.TextMatrix(0, 4) = "Monto"
   grdLista.TextMatrix(0, 5) = "Monto"
   grdLista.TextMatrix(0, 6) = "N° Flujo"
   grdLista.TextMatrix(0, 7) = "Modalidad"
   grdLista.TextMatrix(0, 8) = "Cod. tip. Op."
   grdLista.TextMatrix(0, 9) = "FecLiq" 'Incorporado el dìa 02-04-2015
   grdLista.TextMatrix(0, 10) = "M"     'Marca para impresión multiple

   grdLista.ColWidth(0) = 800
   grdLista.ColWidth(1) = 900
   grdLista.ColWidth(2) = 1000
   grdLista.ColWidth(3) = 2500
   grdLista.ColWidth(4) = 0
   grdLista.ColWidth(5) = 0
   grdLista.ColWidth(6) = 1000
   grdLista.ColWidth(7) = 1500
   grdLista.ColWidth(8) = 0
   grdLista.ColWidth(9) = 0  'Incorporado el dìa 02-04-2015
   grdLista.ColWidth(10) = 400
   grdLista.Row = 0

   For i = 0 To grdLista.Cols - 1
      grdLista.Col = i
      grdLista.CellAlignment = 4
   Next
End Function

Private Sub grdLista_Click()
  grdLista.Col = 10
  If grdLista.TextMatrix(grdLista.Row, grdLista.Col) = "X" Then
     grdLista.TextMatrix(grdLista.Row, grdLista.Col) = " "
  Else
     grdLista.TextMatrix(grdLista.Row, grdLista.Col) = "X"
  End If
End Sub

Private Sub OK_Click()
   'Mostrara datos del movimiento diario
   Call BUSCAR
End Sub

Function BUSCAR()
   Dim ConsultaVencidos As New clsConsultasSwaps
   Dim Max              As Long
   Dim m, j             As Long
   Dim NumPaso          As Double
   Dim iMensaje         As String

   If txtFechaOperacion.Text = gsBAC_Fecp Then
      etqTitulo.Caption = "Operaciones Vencidas en Cartera"
   Else
      etqTitulo.Caption = "Operaciones Vencidas en Cartera Histórica"
   End If
   grdLista.Tag = txtFechaOperacion.Text

   ConsultaVencidos.Fecha1 = txtFechaOperacion.Text
    
   If Not ConsultaVencidos.ConsultaVecimientos Then
      Set ConsultaVencidos = Nothing
      MsgBox "No existen datos con Parámetros seleccionados", vbExclamation, Msj
      Exit Function
   End If
    
   Max = ConsultaVencidos.coleccion.Count
        
   Call BacLimpiaGrilla(grdLista)
    
   NumPaso = 0
   iMensaje = ""
    
   For m = 1 To Max
      If m = 1 Then
         If (ConsultaVencidos.coleccion(m).iValorICP) = 0# Then
            iMensaje = "ERROR"
         End If
      End If
      If m >= grdLista.Rows Then
         grdLista.Rows = grdLista.Rows + 1
      End If
      grdLista.TextMatrix(m, 0) = (ConsultaVencidos.coleccion(m).NumOperacion)
      grdLista.TextMatrix(m, 1) = (ConsultaVencidos.coleccion(m).TipoOperacion)
      grdLista.TextMatrix(m, 2) = (ConsultaVencidos.coleccion(m).TipProd)
      grdLista.TextMatrix(m, 3) = (ConsultaVencidos.coleccion(m).Cliente)
      grdLista.TextMatrix(m, 4) = (ConsultaVencidos.coleccion(m).MontoOp)
      grdLista.TextMatrix(m, 5) = (ConsultaVencidos.coleccion(m).MontoConv)
      grdLista.TextMatrix(m, 6) = (ConsultaVencidos.coleccion(m).NumFlujo)
      grdLista.TextMatrix(m, 7) = (ConsultaVencidos.coleccion(m).Modalidad)
      grdLista.TextMatrix(m, 8) = (ConsultaVencidos.coleccion(m).CodTipoOp)
      grdLista.TextMatrix(m, 9) = (ConsultaVencidos.coleccion(m).FechaLiq)
      grdLista.TextMatrix(m, 10) = "X"
   Next m

   Set ConsultaVencidos = Nothing
   
   If iMensaje = "ERROR" Then
      MsgBox "Información." & vbCrLf & vbCrLf & "No se ha ingresado el Indice Camara Promedio para el Día de Hoy.", vbExclamation, TITSISTEMA
   End If

End Function

Private Sub Toolbar1_ButtonClick(ByVal Button As ComctlLib.Button)

   Dim i As Long
   Dim Marcado As String
   Dim MarcoTodo As String
   
   If Button.Index = 3 Then
        For i = 1 To grdLista.Rows - 1
             If grdLista.TextMatrix(i, 10) = "X" Then
                grdLista.TextMatrix(i, 10) = " "
             Else
                grdLista.TextMatrix(i, 10) = "X"
             End If
             If grdLista.TextMatrix(i, 0) = "" Then
                 grdLista.TextMatrix(i, 10) = " "
             End If
        Next i
   
   Else
        Let Marcado = "No"
        Let MarcoTodo = "No"
        
        Let MarcoTodo = "Si"
        For i = 1 To grdLista.Rows - 1
             If grdLista.TextMatrix(i, 10) = " " Then
                Let MarcoTodo = "No"
             End If
        Next i
        If MarcoTodo = "Si" Then
           If MsgBox("Desea imprimir todo lo marcado?", vbYesNo) = vbNo Then
              GoTo Salir
           End If
        End If
   
        For i = 0 To grdLista.Rows - 1
             Let grdLista.Row = i
             If grdLista.TextMatrix(i, 10) = "X" Then
                 Let Marcado = "Si"
                 Select Case Button.Index
                    Case 1
                       Call GeneraLiquidaVctos(crptToWindow)
                    Case 2
                       Call GeneraLiquidaVctos(crptToPrinter)
                    Case 4
                       Unload Me
                 End Select
             End If
        Next i
        If Marcado = "No" Then
           MsgBox "Marcar en ultima columna para imprimir"
        End If
   End If
Salir:
End Sub

Private Sub txtFechaOperacion_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
      OK.SetFocus
   End If
End Sub

Private Sub txtFechaOperacion_LostFocus()
   If CDate(txtFechaOperacion.Text) > CDate(gsBAC_Fecp) Then
      MsgBox "Fecha no puede ser mayor a fecha de proceso!", vbInformation, Msj
      txtFechaOperacion.Text = gsBAC_Fecp
      txtFechaOperacion.SetFocus
      Exit Sub
   End If
End Sub
