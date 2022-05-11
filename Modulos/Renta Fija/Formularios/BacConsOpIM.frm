VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacConsOpIM 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Consulta Operaciones Intramesas"
   ClientHeight    =   5505
   ClientLeft      =   510
   ClientTop       =   2310
   ClientWidth     =   13845
   ControlBox      =   0   'False
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5505
   ScaleWidth      =   13845
   Begin VB.Frame Frame2 
      Height          =   735
      Left            =   4245
      TabIndex        =   7
      Top             =   960
      Width           =   5535
      Begin VB.CommandButton Command2 
         Height          =   255
         Left            =   2640
         Style           =   1  'Graphical
         TabIndex        =   10
         Top             =   240
         Width           =   255
      End
      Begin VB.CommandButton Command1 
         BackColor       =   &H00FFFF00&
         Height          =   255
         Left            =   240
         Style           =   1  'Graphical
         TabIndex        =   8
         Top             =   240
         Width           =   255
      End
      Begin VB.Label Label4 
         Caption         =   "Operaciones Normales"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   3120
         TabIndex        =   11
         Top             =   240
         Width           =   2055
      End
      Begin VB.Label Label3 
         Caption         =   "Operaciones Espejo"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   600
         TabIndex        =   9
         Top             =   240
         Width           =   1815
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Período"
      Height          =   855
      Left            =   150
      TabIndex        =   2
      Top             =   840
      Width           =   3015
      Begin BACControles.TXTFecha FechaDesde 
         Height          =   315
         Left            =   120
         TabIndex        =   3
         Top             =   480
         Width           =   1215
         _ExtentX        =   2143
         _ExtentY        =   556
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
         Text            =   "02-07-2009"
      End
      Begin BACControles.TXTFecha FechaHasta 
         Height          =   315
         Left            =   1680
         TabIndex        =   4
         Top             =   480
         Width           =   1215
         _ExtentX        =   2143
         _ExtentY        =   556
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
         Text            =   "02-07-2009"
      End
      Begin VB.Label Label2 
         Caption         =   "Hasta"
         Height          =   255
         Left            =   1680
         TabIndex        =   6
         Top             =   240
         Width           =   855
      End
      Begin VB.Label Label1 
         Caption         =   "Desde"
         Height          =   255
         Left            =   120
         TabIndex        =   5
         Top             =   240
         Width           =   975
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   765
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   13845
      _ExtentX        =   24421
      _ExtentY        =   1349
      ButtonWidth     =   1191
      ButtonHeight    =   1191
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Anular"
            Key             =   "botAnular"
            Description     =   "Anular Operación"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Buscar"
            Key             =   "botBuscar"
            Description     =   "Buscar Operaciones"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Imprimir"
            Key             =   "botImprimir"
            Description     =   "Imprimir Papeleta"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Excel"
            Key             =   "botExcel"
            Description     =   "Copiar a Excel"
            ImageIndex      =   6
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Salir"
            Key             =   "botSalir"
            Description     =   "Salir"
            ImageIndex      =   14
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   8040
      Top             =   300
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   25
      ImageHeight     =   25
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   15
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacConsOpIM.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacConsOpIM.frx":0452
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacConsOpIM.frx":132C
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacConsOpIM.frx":2206
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacConsOpIM.frx":30E0
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacConsOpIM.frx":3FBA
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacConsOpIM.frx":4E94
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacConsOpIM.frx":51AE
            Key             =   ""
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacConsOpIM.frx":54C8
            Key             =   ""
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacConsOpIM.frx":591A
            Key             =   ""
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacConsOpIM.frx":5C34
            Key             =   ""
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacConsOpIM.frx":6086
            Key             =   ""
         EndProperty
         BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacConsOpIM.frx":63A0
            Key             =   ""
         EndProperty
         BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacConsOpIM.frx":66BA
            Key             =   ""
         EndProperty
         BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacConsOpIM.frx":69D4
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSFlexGridLib.MSFlexGrid grilla 
      Height          =   3615
      Left            =   120
      TabIndex        =   1
      Top             =   1800
      Width           =   13665
      _ExtentX        =   24104
      _ExtentY        =   6376
      _Version        =   393216
      FixedCols       =   0
      BackColor       =   12632256
      ForeColor       =   12582912
      BackColorFixed  =   8421376
      ForeColorFixed  =   16777215
      BackColorBkg    =   12632256
      HighLight       =   2
      GridLines       =   2
   End
End
Attribute VB_Name = "BacConsOpIM"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim oDesde As Date
Dim oHasta As Date
'Dim filaSel As Integer
'Dim colSel As Integer
Private Sub Form_Load()
    'JBH, 11-11-2009
    FechaDesde.Text = gsBac_Fecp
    FechaHasta.Text = gsBac_Fecp
    oDesde = FechaDesde.Text
    oHasta = FechaHasta.Text
    Call confGrilla
    Call LlenaGrilla
End Sub
Private Sub confGrilla()
With grilla
        .Rows = 1
        .cols = 13
        
        .TextMatrix(0, 0) = "Fecha"
        .TextMatrix(0, 1) = "N° Oper."
        .TextMatrix(0, 2) = "Tipo Operación"
        .TextMatrix(0, 3) = "Moneda"
        .TextMatrix(0, 4) = "Tir"
        .TextMatrix(0, 5) = "Monto Operación"
        .TextMatrix(0, 6) = "Fecha Vcto."
        .TextMatrix(0, 7) = "Portafolio"
        .TextMatrix(0, 8) = "Contraparte"
        .TextMatrix(0, 9) = "Cartera Origen"
        .TextMatrix(0, 10) = "Cartera Destino"
        .TextMatrix(0, 11) = "Usuario"
        
        
        .RowHeight(0) = 550
        
        .ColWidth(0) = 1000
        .ColWidth(1) = 1000
        .ColWidth(2) = 2800
        .ColWidth(3) = 850
        .ColWidth(4) = 1200
        .ColWidth(5) = 2000
        .ColWidth(6) = 1400
        .ColWidth(7) = 1600
        .ColWidth(8) = 1600
        .ColWidth(9) = 1600
        .ColWidth(10) = 1600
        .ColWidth(11) = 1600
        .ColWidth(12) = 0
        .BackColorFixed = vbActiveTitleBar '&H808000
        .ForeColorFixed = vbTitleBarText '&HFFFFFF
        .FocusRect = flexFocusNone
        .SelectionMode = flexSelectionByRow
        .AllowBigSelection = False
        .AllowUserResizing = flexResizeNone
End With

End Sub
Private Sub LlenaGrilla()
Dim colAhora As ColorConstants
Call LimpiaGrilla
Dim Datos()


Envia = Array()

    AddParam Envia, FechaDesde.Text
    AddParam Envia, FechaHasta.Text

    Sql = "DBO.SP_CARGAMOVTICKETRTAFIJA"
    colAhora = grilla.BackColor
   If Not Bac_Sql_Execute(Sql, Envia) Then
      Screen.MousePointer = 0
      Exit Sub
   Else
    With grilla
      Do While Bac_SQL_Fetch(Datos())
        .Rows = .Rows + 1
        .Row = .Rows - 1
        .TextMatrix(.Row, 0) = Datos(1)     'Fecha Operación
        .TextMatrix(.Row, 1) = Datos(2)     'N° Operación
        If IsNull(Datos(3)) Then    'Tipo Operación
            .TextMatrix(.Row, 2) = ""
        Else
            .TextMatrix(.Row, 2) = Datos(3)
        End If
        If IsNull(Datos(5)) Then    'Moneda
            .TextMatrix(.Row, 3) = ""
        Else
            .TextMatrix(.Row, 3) = Datos(5)
        End If
        If IsNull(Datos(6)) Then    'Tir
            .TextMatrix(.Row, 4) = ""
        ElseIf Datos(6) = 0 Then
            .TextMatrix(.Row, 4) = ""
        Else
            .TextMatrix(.Row, 4) = Format(Datos(6), "###.####0")
        End If
        .TextMatrix(.Row, 5) = Format(Datos(7), "###,###,###,###,###,###,###.####0")    'Monto Operación
        If IsNull(Datos(10)) Then   'Fecha Vencimiento
            .TextMatrix(.Row, 6) = ""
        Else
            .TextMatrix(.Row, 6) = Datos(10)
        End If
                If IsNull(Datos(11)) Then   'Mesa Origen
            .TextMatrix(.Row, 7) = ""
        Else
            .TextMatrix(.Row, 7) = Datos(11)
        End If
        
        If IsNull(Datos(12)) Then   'Mesa Destino
            .TextMatrix(.Row, 8) = ""
        Else
            .TextMatrix(.Row, 8) = Datos(12)
        End If

        If IsNull(Datos(13)) Then           'Cartera Origen
            .TextMatrix(.Row, 9) = ""
        Else
            .TextMatrix(.Row, 9) = Datos(13)
        End If
        If IsNull(Datos(14)) Then            'Cartera Destino
            .TextMatrix(.Row, 10) = ""
        Else
            .TextMatrix(.Row, 10) = Datos(14)
        End If
        .TextMatrix(.Row, 11) = Datos(15)   'Usuario
        .TextMatrix(.Row, 12) = Datos(17)
        If Datos(17) <> 0 Then
            Call Pintafila(.Row, vbCyan)
        Else
            Call Pintafila(.Row, colAhora)
        End If
      Loop
    End With
   End If

End Sub
Private Function Pintafila(Fila, Color)
Dim cols As Integer
Dim I As Integer
cols = grilla.cols
grilla.Row = Fila
With grilla
    For I = 0 To cols - 1
        .Col = I
        .CellBackColor = Color
    Next I
End With
End Function
Private Sub LimpiaGrilla()
With grilla
    .Rows = 1
End With
End Sub
Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Dim opcion As Integer
Dim Fila As Integer
Dim Col As Integer
Dim estoy As Integer
Dim Numero As String
Dim tipo As String
Fila = grilla.Row
Col = grilla.Col
    

opcion = Button.Index
Select Case opcion
    Case 1  'Anular
        Call Anular_Oper_IM
    Case 2  'Buscar
    
        If CDate(FechaDesde.Text) > CDate(FechaHasta.Text) Then
            MsgBox "La fecha inicial no puede ser posterior a la fecha final", vbExclamation, gsBac_Version
            FechaDesde.Text = oDesde
            FechaHasta.Text = oHasta
            Exit Sub
        End If
        oDesde = FechaDesde.Text
        oHasta = FechaHasta.Text
        Call LlenaGrilla
    Case 3  'Imprimir papeletas
            estoy = grilla.RowSel
            Numero = grilla.TextMatrix(estoy, 1)
            tipo = grilla.TextMatrix(estoy, 2)
            Select Case tipo
                Case "VENTA DEFINITIVA"
                    Call ImprimeMovtosIM(Numero)
                Case "COMPRA DEFINITIVA"
                    Call ImprimeMovtosIM(Numero)
                Case "COMPRAS CON PACTO"
                    Call ImprimeMovtosPacto(Numero)
                Case "VENTAS CON PACTO"
                    Call ImprimeMovtosPacto(Numero)
            End Select
            
           
    
    Case 4  'Copiar a Excel
        If grilla.Rows = 0 Then
            MsgBox "No hay datos para exportar a Excel!", vbExclamation, gsBac_Version
            Exit Sub
        End If
        Call subGENERACIONEXCEL
    Case 5  'Salir
        Unload Me
    Case Else
    'Error

End Select

End Sub
Private Function ImprimeMovtosPacto(ByVal numMovto As Integer)
    Call Limpiar_Cristal
    BacTrader.bacrpt.ReportFileName = RptList_Path & "MovtosPactoIM.rpt"
    BacTrader.bacrpt.StoredProcParam(0) = CDbl(numMovto)
    BacTrader.bacrpt.Connect = CONECCION
    BacTrader.bacrpt.Destination = crptToPrinter
    BacTrader.bacrpt.Action = 1
End Function
Private Function ImprimeMovtosIM(ByVal numMovto As Integer)
    Call Limpiar_Cristal
    BacTrader.bacrpt.ReportFileName = RptList_Path & "MovtosIM.rpt"
    BacTrader.bacrpt.StoredProcParam(0) = CDbl(numMovto)
    BacTrader.bacrpt.Connect = CONECCION
    BacTrader.bacrpt.Destination = crptToPrinter
    BacTrader.bacrpt.Action = 1
End Function
Private Sub subGENERACIONEXCEL()
Dim iContador           As Integer
Dim bMarcado            As Boolean
Dim iFlujo              As Integer
Dim sNivel              As String
Dim iEntidad            As Integer
Dim iFondo              As Integer
Dim irow                As Integer
Dim iCols               As Integer
Dim fSaldoDiario        As Double
Dim iCMoneda            As Integer
Dim dFecha              As Date
Dim sMoneda             As String
Dim bImprime            As Boolean
Dim AppExcel            As Variant
Dim bExcel              As Boolean
Dim oSheet              As Variant
Dim wkSheet             As Variant
Dim rnRange             As Variant

On Error GoTo Err_Informe


    Let Screen.MousePointer = vbHourglass

    Let bExcel = False

    Set AppExcel = CreateObject("Excel.Application")

    bExcel = True
    AppExcel.Visible = False
    Set oSheet = AppExcel.Workbooks.Add

    Call oSheet.Worksheets.Add
    Set wkSheet = oSheet.ActiveSheet
    Set rnRange = wkSheet.Range("a5")

    Let wkSheet.Range("B1").Value = "Operaciones Intramesas"
    Let wkSheet.Range("B1").HorizontalAlignment = -4108
    Let wkSheet.Range("B1").Font.Size = 22
    wkSheet.Range("b1:p1").Merge

    'Let wkSheet.Range("l2").Value = "Fecha:": Let wkSheet.Range("M2").Value = Control.Fecha_Proceso

    For iFlujo = 0 To grilla.cols - 1
        Let rnRange.Offset(, iFlujo).Value = grilla.TextMatrix(0, iFlujo)
    Next iFlujo
    'Call subSET_Cell_Titles(rnRange.Offset(, 1).Resize(, grilla.Cols - 2))


    For irow = 1 To grilla.Rows - 1
        Let rnRange.Offset(irow, 0).Value = grilla.TextMatrix(irow, 0)
        Let rnRange.Offset(irow, 1).Value = grilla.TextMatrix(irow, 1)
        Let rnRange.Offset(irow, 2).Value = grilla.TextMatrix(irow, 2)
        Let rnRange.Offset(irow, 3).Value = grilla.TextMatrix(irow, 3)
        Let rnRange.Offset(irow, 4).Value = Format(grilla.TextMatrix(irow, 4), "#.####0")   'TIR
        Let rnRange.Offset(irow, 5).Value = Format(grilla.TextMatrix(irow, 5), "###,###,###,###,###.####0") 'Monto Operación
        Let rnRange.Offset(irow, 6).Value = grilla.TextMatrix(irow, 6) 'Vencimiento
        Let rnRange.Offset(irow, 7).Value = grilla.TextMatrix(irow, 7)
        Let rnRange.Offset(irow, 8).Value = grilla.TextMatrix(irow, 8)
        Let rnRange.Offset(irow, 9).Value = grilla.TextMatrix(irow, 9)
        Let rnRange.Offset(irow, 10).Value = grilla.TextMatrix(irow, 10)
        Let rnRange.Offset(irow, 11).Value = grilla.TextMatrix(irow, 11)
        
    Next irow

    'Call subSET_Borders(rnRange.Offset(1, 1).Resize(irow - 1, (grilla.Cols - 2)))

    wkSheet.Cells.EntireColumn.AutoFit


Salir:

 If bExcel Then AppExcel.Visible = True    ' Pone visible la aplicación Excel
 Let Screen.MousePointer = vbDefault
  Set AppExcel = Nothing                    ' Libera el objeto
  Exit Sub


Err_Informe:
  Select Case err.Number
    Case 91
      MsgBox "!! No se pudo abrir Excel !!", 16, "Ocurrió un error"
'Indica que el objeto no se logró abrir
      Resume Salir
    Case 429
      Set AppExcel = CreateObject("Excel.Application")  'Indica que Excel no está abierto y crea un objeto con aplication de Excel
      Resume Next
    Case 2302
      sNivel = "!! El archivo ya se encuentra abierto !!" & vbCrLf & "Debe cerrarlo antes de continuar"
      MsgBox sNivel, 16, "Ocurrió un error al abrir el archivo"
      Resume Salir
    Case 3265
      Resume Next
    Case Else
      MsgBox err.Number & " - " & err.Description
      err.Clear
      Resume Salir
  End Select


End Sub
Private Sub Anular_Oper_IM()
Dim Numero As String
Dim estoy As Integer
Dim posSel As Integer
Dim numSalida As Integer
Dim motSalida As String
Dim numeroEspejo As String
posSel = grilla.Row
Dim nomSp As String
Dim Datos()
Envia = Array()
'Ver columna 12
With grilla

    estoy = .RowSel

    Numero = .TextMatrix(estoy, 1)


   ' VB+- 17/12/2009 Se elimina el control
    If .TextMatrix(.RowSel, 12) <> 0 Then
        Numero = .TextMatrix(.RowSel, 12)
        'Es espejo, no se puede anular
       ' MsgBox "La operación seleccionada es Espejo, no se puede anular!", vbExclamation, gsBac_Version
       ' Exit Sub
    End If
   
   

    
    If MsgBox("¿Confirma la anulación del movimiento N° " + Numero + "?", vbQuestion + vbYesNo, "Anulación de Operaciones Intramesas") = vbNo Then
        Exit Sub
    End If
    .RowSel = estoy
    .Row = estoy
    
    nomSp = "SP_ANULAOPERACION_TICKETINTRAMESA"
    AddParam Envia, CDbl(Numero)
    
   ' AddParam Envia, CDbl(numeroEspejo)
    
    
    If Not Bac_Sql_Execute(nomSp, Envia) Then
        Screen.MousePointer = 0
        Exit Sub
    Else
        Do While Bac_SQL_Fetch(Datos())
            numSalida = Datos(1)
            motSalida = Datos(2)
        Loop
    End If
    If numSalida <> 0 Then
        MsgBox "Se ha producido el siguiente error:" & vbCrLf & motSalida, vbCritical, gsBac_Version
        Exit Sub
    ElseIf motSalida = "OK" Then
        MsgBox "El movimiento ha sido anulado exitosamente.", vbInformation, gsBac_Version
        'Refrescar la grilla
        Call LlenaGrilla
    End If
End With
End Sub
