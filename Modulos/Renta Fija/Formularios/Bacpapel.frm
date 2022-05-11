VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "msflxgrd.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.1#0"; "MSCOMCTL.OCX"
Begin VB.Form BacPapeleta 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Reimpresión de Papeletas"
   ClientHeight    =   4605
   ClientLeft      =   660
   ClientTop       =   3645
   ClientWidth     =   11325
   ForeColor       =   &H00C0C0C0&
   Icon            =   "Bacpapel.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4605
   ScaleWidth      =   11325
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   7
      Top             =   0
      Width           =   11325
      _ExtentX        =   19976
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
            Key             =   "cmbimprimir"
            Description     =   "IMPRIMIR"
            Object.ToolTipText     =   "Imprimir"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbMT298"
            Description     =   "MT298"
            Object.ToolTipText     =   "Genera MT298"
            ImageIndex      =   4
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
      Left            =   2505
      Top             =   6180
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
            Picture         =   "Bacpapel.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacpapel.frx":0624
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacpapel.frx":093E
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacpapel.frx":0F36
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSFlexGridLib.MSFlexGrid Grd 
      Height          =   3660
      Left            =   120
      TabIndex        =   6
      Top             =   930
      Width           =   11100
      _ExtentX        =   19579
      _ExtentY        =   6456
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
   Begin VB.ComboBox cmbopcion 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      ItemData        =   "Bacpapel.frx":1536
      Left            =   1740
      List            =   "Bacpapel.frx":1543
      Style           =   2  'Dropdown List
      TabIndex        =   5
      Top             =   585
      Width           =   1770
   End
   Begin Threed.SSCommand cmdsalir 
      Height          =   450
      Left            =   1290
      TabIndex        =   4
      Top             =   6285
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
   Begin Threed.SSCommand cmdimprimir 
      Height          =   450
      Left            =   105
      TabIndex        =   3
      Top             =   6285
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
   Begin VB.Label Label1 
      Caption         =   "Ver ordenado por:"
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
      Height          =   240
      Left            =   120
      TabIndex        =   8
      Top             =   645
      Width           =   1590
   End
   Begin VB.Label LblColor3 
      Appearance      =   0  'Flat
      BackColor       =   &H00808000&
      BorderStyle     =   1  'Fixed Single
      Caption         =   "AAA"
      ForeColor       =   &H00FFFF80&
      Height          =   375
      Left            =   3120
      TabIndex        =   2
      Top             =   5520
      Visible         =   0   'False
      Width           =   1215
   End
   Begin VB.Label LblColor2 
      Appearance      =   0  'Flat
      BackColor       =   &H000000FF&
      BorderStyle     =   1  'Fixed Single
      Caption         =   "AAA"
      ForeColor       =   &H00FFFF80&
      Height          =   375
      Left            =   1680
      TabIndex        =   1
      Top             =   5520
      Visible         =   0   'False
      Width           =   1215
   End
   Begin VB.Label LblColor 
      Appearance      =   0  'Flat
      BackColor       =   &H00FF0000&
      BorderStyle     =   1  'Fixed Single
      Caption         =   "AAA"
      ForeColor       =   &H00FFFF80&
      Height          =   375
      Left            =   240
      TabIndex        =   0
      Top             =   5520
      Visible         =   0   'False
      Width           =   1215
   End
End
Attribute VB_Name = "BacPapeleta"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim EnRojo As String
Public proFecha As String
Public proTipo As String
Private Sub BacCargaGrilla(nOpcion As Long)

    Dim cOpcion     As String
    Dim nCant       As Integer
    Dim nContador   As Integer
    Dim Datos()

    'Call Nombres

    EnRojo = ""
    Screen.MousePointer = vbHourglass
    
    ' Ordenado por Numero de Operación
    '---------------------------------
    If nOpcion = 0 Then
       cOpcion = "N"
    End If
    
    ' Ordenado por Tipo de operación"
    '---------------------------------
    If nOpcion = 1 Then
       cOpcion = "T"
    End If
    
    ' Ordenado por Cliente
    '---------------------------------
    If nOpcion = 2 Then
       cOpcion = "C"
    End If
    
    
    If proTipo = "DIA" Then
        Envia = Array(cOpcion, "P")

        If Not Bac_Sql_Execute("SP_CONSULTAOPERPAPEL", Envia) Then
            Screen.MousePointer = 0
            MsgBox "No se puede conectar a tabla de movimientos", 16
            Exit Sub
        End If
    Else
       
        Envia = Array(proFecha, cOpcion)

        If Not Bac_Sql_Execute("SP_QUERYHISPAPEL", Envia) Then
            Screen.MousePointer = 0
            MsgBox "No se puede conectar a tabla de movimientos", 16
            Exit Sub
        End If

    End If
    
    With Grd
    
    
'        .Cols = 12 ' 10
        .Rows = 1
        
        .Row = 0
                  
''''        For nContador = 7 To 10
''''            .ColWidth(nContador) = 0
''''        Next nContador
        
        nCant = 0
                
        Grd.Redraw = False
                
        Do While Bac_SQL_Fetch(Datos())
            .Rows = .Rows + 1
            .Row = .Rows - 1
            
            .TextMatrix(.Row, 0) = Val(Datos(1))
            .TextMatrix(.Row, 1) = IIf(Mid$(Datos(2), 1, 1) = "A" And Len(Datos(10)) <> 0, Mid$(Datos(2), 2), Datos(2))
            .TextMatrix(.Row, 4) = Format(Val(Datos(5)), "###,###0.0000")
            .TextMatrix(.Row, 3) = Datos(4)
            .TextMatrix(.Row, 5) = Datos(6)
            .TextMatrix(.Row, 2) = Datos(3)
            .TextMatrix(.Row, 6) = Datos(7)
            .TextMatrix(.Row, 7) = IIf(Mid$(Datos(2), 1, 1) = "A" And Len(Datos(10)) <> 0, 2, 1)
            .TextMatrix(.Row, 8) = Datos(2)
            .TextMatrix(.Row, 9) = Datos(4)
            .TextMatrix(.Row, 10) = Datos(12)
            .TextMatrix(.Row, 11) = Val(Datos(13))
            .TextMatrix(.Row, 12) = Val(Datos(15))      '20190107.RCHS.LCGP
            
            nCant = nCant + 1
            .RowHeight(.Row) = 350
            
           
            If Trim(Datos(10)) = "A" Then
                EnRojo = EnRojo & Format(.Row, "000") & "-"
                
                For nContador = 0 To 9
                    .Col = nContador
                    .CellForeColor = vbRed
                Next nContador
                
            End If
            
        Loop
        
        .Redraw = True
    
    End With
    
    Screen.MousePointer = vbDefault
    
    If nCant = 0 Then
        MsgBox "No existen operaciones para Reimprimir ", vbExclamation, gsBac_Version
    End If
    
End Sub


Private Sub Proc_Imprimir_Papeleta()

    Dim SQL        As String
    Dim RutCartera As String
    Dim Numoper    As String
    Dim cTipOper   As String
    Dim Res        As String
    Dim bAnulado   As Boolean
    Dim correla    As String
    Dim lcgp       As Integer
    On Error GoTo ErrPrinter


    Screen.MousePointer = vbHourglass
    
    If Grd.CellForeColor = vbRed Then
        MsgBox "Operación anulada, no es posible imprimir papeleta", vbInformation, "BacTrader Full"
        Screen.MousePointer = 0
        Exit Sub
    End If
    
    Grd.Col = 0:   Numoper = Grd.text
    
    Grd.Col = 1:   cTipOper = UCase(Grd.text)
    
    Grd.Col = 2:   RutCartera = Grd.text
    
    Grd.Col = 11:  correla = Grd.text
    
    Grd.Col = 12: lcgp = Grd.text
    
    Grd.Col = 8
    
    
    bAnulado = IIf(Left(Grd.text, 1) = "A", True, False)
    
    If bAnulado Then cTipOper = Grd.text
    
    If cTipOper = "CAP" Or cTipOper = "COL" Then
        cTipOper = "IB"
    End If
    
    If cTipOper = "ACAP" Or cTipOper = "ACOL" Then
        cTipOper = "AIB"
    End If
    
    If proTipo = "DIA" Then
        If Mid$(cTipOper, 1, 1) = "A" And bAnulado Then
            Res = ImprimeAnulacionPapeleta(RutCartera, Numoper, Mid$(cTipOper, 2))
        Else
            Res = ImprimePapeleta(RutCartera, Numoper, IIf(cTipOper = "AIC", "AC", cTipOper), "N", Grd.TextMatrix(Grd.Row, 10), correla, lcgp)
        End If
    End If
    
    If Res = "NO" Then
       MsgBox "Papeleta no puede ser REIMPRESA", vbCritical, "PAPELETAS"
    End If
    
    If cmbopcion.ListCount > 0 Then
       Call BacCargaGrilla(cmbopcion.ListIndex)
    Else
       Call BacCargaGrilla(0)
    End If
    
    Screen.MousePointer = vbDefault
    
    If Grd.Rows > 1 Then
        Grd.SetFocus
        Grd.Row = Val(Grd.Tag)
        Grd.Col = 0
        Grd.SetFocus
    End If
    
    Exit Sub



ErrPrinter:

    MsgBox "Problemas en impresión de papeletas: " & err.Description & ". Verifique. ", vbExclamation, "BAC Trader"
    Exit Sub



End Sub

Private Sub cmbopcion_Click()

    If cmbopcion.ListIndex <> -1 Then
       Call BacCargaGrilla(cmbopcion.ListIndex)
    End If
      
End Sub



Private Sub cmdImprimir_Click()
Dim SQL        As String
Dim RutCartera As String
Dim Numoper    As String
Dim cTipOper   As String
Dim Res        As String
Dim bAnulado   As Boolean

On Error GoTo ErrPrinter

    Screen.MousePointer = 11
    
    Grd.Col = 0:   Numoper = Grd.text
    
    Grd.Col = 1:   cTipOper = Grd.text
    
    Grd.Col = 2:   RutCartera = Grd.text
    
    Grd.Col = 8
    bAnulado = IIf(Left(Grd.text, 1) = "A", True, False)
    
    If cTipOper = "CAP" Or cTipOper = "COL" Then
        cTipOper = "IB"
    End If
    If cTipOper = "ACA" Or cTipOper = "ACO" Then
        cTipOper = "AIB"
    End If
    
    If proTipo = "DIA" Then
        If Mid$(cTipOper, 1, 1) = "A" And bAnulado Then
            Res = ImprimeAnulacionPapeleta(RutCartera, Numoper, Mid$(cTipOper, 2))
        Else
            Res = ImprimePapeleta(RutCartera, Numoper, IIf(cTipOper = "AIC", "AC", cTipOper), "N")
        End If
    Else
    '   Res = IIf(Not PrintPapeletaHistoricas(RutCartera, NumOper, cTipOper), "NO", "SI")
    End If
    
    If Res = "NO" Then
       MsgBox "Papeleta no puede ser REIMPRESA", vbCritical, "PAPELETAS"
    End If
    
    If cmbopcion.ListCount > 0 Then
       Call BacCargaGrilla(cmbopcion.ListIndex)
    Else
       Call BacCargaGrilla(0)
    End If
    
    Screen.MousePointer = 0
    
    Exit Sub
ErrPrinter:
    MsgBox "Problemas en impresión de papeletas: " & err.Description & ". Verifique. ", vbExclamation, "BAC Trader"
    Exit Sub
End Sub

Private Sub cmdSalir_Click()
'    Unload Me
End Sub


Sub Nombres()
    
    With Grd
        
        .Rows = 1
        .cols = 13 '    20190107.RCHS.LCGP  .cols = 12
        
        .TextMatrix(0, 0) = "Numero"
        .TextMatrix(0, 1) = "Tipo"
        .TextMatrix(0, 2) = "Rut Cartera"
        .TextMatrix(0, 3) = "Nombre Cliente"
        .TextMatrix(0, 4) = "Total Operación"
        .TextMatrix(0, 5) = "Hora"
        .TextMatrix(0, 6) = "Usuario"
        
        .RowHeight(0) = 350
        .ColWidth(0) = 800
        .ColWidth(1) = 500
        .ColWidth(2) = 950
        .ColWidth(3) = 3200
        .ColWidth(4) = 1800
        .ColWidth(5) = 1000
        .ColWidth(6) = 1600
        .ColWidth(7) = 0
        .ColWidth(8) = 0
        .ColWidth(9) = 0
        .ColWidth(10) = 0
        .ColWidth(11) = 0
        .ColWidth(12) = 0
        
        .BackColorFixed = vbActiveTitleBar '&H808000
        .ForeColorFixed = vbTitleBarText '&HFFFFFF
        
        .FocusRect = flexFocusNone
        .SelectionMode = flexSelectionByRow
        .AllowBigSelection = False
        .AllowUserResizing = flexResizeNone
        
    End With


End Sub
Private Sub Form_Load()

    Me.Left = 0
    Me.Top = 0
    
    Call Nombres
    cmbopcion.ListIndex = 0
    'Call BacCargaGrilla(0)
   
    If proTipo = "HIS" Then
        Me.Caption = "Reimpresión papeletas del día : " & Mid$(Me.proFecha, 7, 2) & "/" & Mid$(Me.proFecha, 5, 2) & "/" & Mid$(Me.proFecha, 1, 4)
    End If
    
End Sub

Private Sub GrdOper_Fetch(Row As Long, Col As Integer, Value As String)
    Grd.Row = Row
    Grd.Col = Col
End Sub


Private Sub GrdOper_FetchAttributes(Status As Integer, Split As Integer, Row As Long, Col As Integer, FgColor As Long, BgColor As Long, FontStyle As Integer)
'    Grd.Row = Row
End Sub


Sub Marcar()
   
   
   Dim F, C, r, v As Integer
   With Grd
      F = .RowSel
      If .CellForeColor <> vbRed Then
      
      End If
      .FocusRect = flexFocusHeavy
      .Redraw = False
    For r = 1 To .Rows - 1
         
        For C = 0 To .cols - 1
               .Row = r
               .Col = C
               If InStr(EnRojo, Format(r, "000")) <> 0 Then
                  If r <> F Then
                     .BackColorSel = &HC0C0C0
                     .BackColorFixed = &H808000
                     .ForeColorFixed = &H80000005
                     .CellBackColor = &HC0C0C0
                     .CellForeColor = vbRed
                  End If
                  ''''
               Else 'Es Azul
               
                  If r <> F Then
                     .BackColorSel = &HC0C0C0
                     .BackColorFixed = &H808000
                     .ForeColorFixed = &H80000005
                     .CellBackColor = &HC0C0C0
                     .CellForeColor = vbBlue
                  End If
                  
               End If
               '' NUEVO
                If F = r Then
                     .BackColorSel = &H800000
                     .BackColorFixed = &H808000
                     .ForeColorFixed = &H80000005
                     .CellBackColor = vbBlue    ''vbRed
                     .CellForeColor = vbWhite
                End If
               '' FIN NUEVO
        Next C
    Next r
      .Row = F
      .Col = 0
      .FocusRect = flexFocusLight
      .Redraw = True
   End With
End Sub

Private Sub Grd_Click()
Grd.Tag = Grd.RowSel
'Call Marcar
End Sub

Private Sub Grd_EnterCell()
    Dim nContador   As Integer
    
    If Me.Visible = True Then
      
        With Grd
        
            .BackColorSel = vbHighlight '&H800000
            If InStr(EnRojo, Format(.Row, "000")) <> 0 Then
                .ForeColorSel = vbYellow
            Else
                .ForeColorSel = vbWhite
            End If
            
            
        End With
    End If
    
End Sub

Private Sub Grd_LeaveCell()

    If Me.Visible = True Then

        With Grd
            If InStr(EnRojo, Format(.Row, "000")) <> 0 Then
                '.BackColorSel = &HC0C0C0
                '.BackColorFixed = &H808000
                '.ForeColorFixed = &H80000005
                .CellBackColor = &HC0C0C0
                .CellForeColor = vbRed
            Else
            
                '.BackColorSel = &HC0C0C0
                '.BackColorFixed = &H808000
                '.ForeColorFixed = &H80000005
                .CellBackColor = &HC0C0C0
                .CellForeColor = vbBlue
               
            End If
        End With
    End If

End Sub


Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
    
    Select Case UCase(Button.Description)
        Case "IMPRIMIR"
            Proc_Imprimir_Papeleta
    
        Case "MT298"
            PROC_IMPRIME_MT298
     
        Case "SALIR"
            Unload Me
            
    End Select

End Sub



Sub PROC_IMPRIME_MT298()

Dim TitRpt      As String
Dim Numoper     As Long
Dim cTipOper    As String
Dim nTopRow     As Integer
Dim cSistema    As String

   nTopRow = Grd.TopRow

   If Grd.RowSel = 0 Then
      Screen.MousePointer = 0
      MsgBox "No ha seleccionado elemento", 32, "Impresión de Contratos"
      Exit Sub
   End If

   Grd.Col = 0: Numoper = Grd.text
   Grd.Col = 1: cTipOper = Grd.text

   cSistema = "BTR"

   If cTipOper <> "CAP" And cTipOper <> "COL" And cTipOper <> "VP" And cTipOper <> "CP" And cTipOper <> "CI" And cTipOper <> "VI" Then
      MsgBox "Mensaje no disponible para este tipo de operación", vbCritical
      Exit Sub
   End If

   Screen.MousePointer = 11

   BacTrader.bacrpt.Destination = crptToWindow
   
   Call Limpiar_Cristal

   If cTipOper = "CAP" Then
      BacTrader.bacrpt.ReportFileName = RptList_Path & "MT298.RPT"
   ElseIf cTipOper = "COL" Then
      BacTrader.bacrpt.ReportFileName = RptList_Path & "MT299.RPT"
   ElseIf cTipOper = "CP" Then
      BacTrader.bacrpt.ReportFileName = RptList_Path & "MT298_CP.RPT"
   ElseIf cTipOper = "VI" Then
      BacTrader.bacrpt.ReportFileName = RptList_Path & "MT298_VI.RPT"
   ElseIf cTipOper = "VP" Then
      BacTrader.bacrpt.ReportFileName = RptList_Path & "MT299_VP.RPT"
   ElseIf cTipOper = "CI" Then
      BacTrader.bacrpt.ReportFileName = RptList_Path & "MT299_CI.RPT"
   End If
   
      BacTrader.bacrpt.StoredProcParam(0) = cSistema
      BacTrader.bacrpt.StoredProcParam(1) = Numoper
      BacTrader.bacrpt.Formulas(0) = ""
      BacTrader.bacrpt.Connect = CONECCION
      BacTrader.bacrpt.WindowState = crptMaximized
      BacTrader.bacrpt.Action = 1
   
   Grd.TopRow = nTopRow
   
   Screen.MousePointer = 0

End Sub


