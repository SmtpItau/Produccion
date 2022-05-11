VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{1A42DF62-3514-11D5-BF5A-00105ACD9C7B}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacPapeleta 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Reimpresión de Papeletas"
   ClientHeight    =   5580
   ClientLeft      =   735
   ClientTop       =   2460
   ClientWidth     =   11100
   ForeColor       =   &H00C0C0C0&
   Icon            =   "Bacpapel.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5580
   ScaleWidth      =   11100
   Begin VB.Frame frm_combo_opcion 
      Caption         =   "Opciones"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF0000&
      Height          =   720
      Left            =   150
      TabIndex        =   10
      Top             =   525
      Width           =   2730
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
         ItemData        =   "Bacpapel.frx":030A
         Left            =   375
         List            =   "Bacpapel.frx":0317
         Style           =   2  'Dropdown List
         TabIndex        =   11
         Top             =   240
         Width           =   1995
      End
   End
   Begin VB.Frame frm_fecha 
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
      ForeColor       =   &H00FF0000&
      Height          =   735
      Left            =   5955
      TabIndex        =   8
      Top             =   510
      Width           =   3180
      Begin BacControles.txtFecha txtFecha 
         Height          =   270
         Left            =   1515
         TabIndex        =   9
         Top             =   285
         Width           =   1485
         _ExtentX        =   2619
         _ExtentY        =   476
         Text            =   "10/10/2001"
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MinDate         =   5.20833333333333E-04
         MaxDate         =   2.5462962962963E-04
      End
   End
   Begin VB.Frame frm_option 
      BackColor       =   &H8000000B&
      Caption         =   "Infrome :"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF0000&
      Height          =   735
      Left            =   2955
      TabIndex        =   5
      Top             =   510
      Width           =   2865
      Begin VB.OptionButton Opt_Hist 
         Caption         =   "Histórico"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000080&
         Height          =   375
         Left            =   1395
         TabIndex        =   6
         Top             =   240
         Width           =   1215
      End
      Begin VB.OptionButton Opt_Dia 
         Caption         =   "Diario"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000080&
         Height          =   330
         Left            =   120
         TabIndex        =   7
         Top             =   255
         Width           =   975
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   4
      Top             =   0
      Width           =   11100
      _ExtentX        =   19579
      _ExtentY        =   794
      ButtonWidth     =   767
      ButtonHeight    =   741
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbimprimir"
            Description     =   "IMPRIMIR"
            Object.ToolTipText     =   "Imprimir"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbpantalla"
            Description     =   "PANTALLA"
            Object.ToolTipText     =   "Ver en Pantalla"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "MARCA"
            Description     =   "MARCA"
            Object.ToolTipText     =   "Marcar/Desmarcar todos"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbsalir"
            Description     =   "SALIR"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSFlexGridLib.MSFlexGrid Grd 
      Height          =   4200
      Left            =   105
      TabIndex        =   3
      Top             =   1335
      Width           =   10905
      _ExtentX        =   19235
      _ExtentY        =   7408
      _Version        =   393216
      FixedCols       =   0
      BackColor       =   12632256
      ForeColor       =   12582912
      BackColorFixed  =   8421376
      ForeColorFixed  =   16777215
      BackColorBkg    =   12632256
      FocusRect       =   0
      GridLines       =   2
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   0
      Top             =   0
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   6
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacpapel.frx":0335
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacpapel.frx":064F
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacpapel.frx":0AA3
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacpapel.frx":0DBD
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacpapel.frx":13E7
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacpapel.frx":1701
            Key             =   ""
         EndProperty
      EndProperty
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
      Top             =   7920
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
      Top             =   7920
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
      Top             =   7920
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
Public proFecha As Date
Public proTipo As String

Dim TipoImp     As String
Dim FilaSeleccionada As Integer
Dim Arreglo As Double

Private Sub BacCargaGrilla(nOpcion As Long)

    Dim cOpcion As String
    Dim nCant   As Integer
    Dim pasa    As Integer

    EnRojo = ""
    Screen.MousePointer = 11
    
    
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

        envia = Array(cOpcion)

        If Not Bac_Sql_Execute("sp_consultaoperpapel", envia) Then
            Screen.MousePointer = 0
            MsgBox "No se puede conectar a tabla de movimientos", 16
            Exit Sub
        End If
    Else
        
        envia = Array(proFecha, cOpcion)

        If Not Bac_Sql_Execute("sp_queryhispapel", envia) Then
            Screen.MousePointer = 0
            MsgBox "No se puede conectar a tabla de movimientos", 16
            Exit Sub
        End If

    End If
        
    Dim datos()
    
    Me.Grd.Cols = 12
    Me.Grd.Rows = 1
    Me.Grd.Row = 0
    nCant = 0
    
    Dim X
    
    For X = 7 To 10
        Me.Grd.ColWidth(X) = 0
    Next X
    
    Me.Grd.ColWidth(11) = 0
    
    Me.Grd.Redraw = False
    Do While Bac_SQL_Fetch(datos())
    
        pasa = True
        
        
        If TipoImp = "CON" Then
            If Mid$(datos(2), 1, 1) = "A" Or datos(2) = "COL" Then
                pasa = False
            End If
        End If
        
        If TipoImp = "CER" And datos(2) <> "VP" Then
            pasa = False
        End If
    
    
        If pasa = True Then
    
             Me.Grd.Rows = Me.Grd.Rows + 1
             Me.Grd.Row = Me.Grd.Rows - 1
             Me.Grd.RowHeight(Me.Grd.Row) = 280
             Me.Grd.Col = 0: Me.Grd.Text = Val(datos(1))
             Me.Grd.Col = 1: Me.Grd.Text = IIf(Mid$(datos(2), 1, 1) = "A" And Len(datos(10)) <> 0, Mid$(datos(2), 2), datos(2))
             Me.Grd.Col = 4: Me.Grd.Text = Format(CDbl(datos(5)), "###,###0.000")
             Me.Grd.Col = 3: Me.Grd.Text = datos(4)
             Me.Grd.Col = 5: Me.Grd.Text = datos(6)
             Me.Grd.Col = 2: Me.Grd.Text = datos(3)
             Me.Grd.Col = 6: Me.Grd.Text = datos(7)
             Me.Grd.Col = 7: Me.Grd.Text = IIf(Mid$(datos(2), 1, 1) = "A" And Len(datos(10)) <> 0, 2, 1)
             Me.Grd.Col = 8: Me.Grd.Text = datos(2)
             Me.Grd.Col = 9: Me.Grd.Text = datos(4)
             Me.Grd.Col = 10: Me.Grd.Text = datos(11)
             nCant = nCant + 1
            
             If datos(10) = "A" Then
                 EnRojo = EnRojo & Format(Me.Grd.Row, "000") & "  "
                 For X = 0 To 9
                     Me.Grd.Col = X
                     Me.Grd.CellForeColor = vbRed
                 Next X
             End If
        End If
        
    Loop
    
    Me.Grd.Redraw = True
    
    Screen.MousePointer = 0
    
    If nCant = 0 And Me.Visible = True Then
        MsgBox "No existen operaciones para Reimprimir ", vbExclamation, gsBac_Version
    End If
    
End Sub


Function Func_Imprimir_Certificados()
    
    Dim TitRpt           As String
    Dim NumOper          As String
   
    Grd.RowSel = FilaSeleccionada


    If Grd.RowSel = 0 Then
       Screen.MousePointer = 0
       MsgBox "No ha seleccionado elemento", vbExclamation, "Impresión de Contratos"
       Exit Function
    End If
   
    Grd.Row = Grd.Rows - 1

    Do While Grd.Row > 0
        Grd.RowSel = Grd.Row
        If Verifica_Fila(Grd.Row) Then

            Grd.Col = 0: NumOper = Grd.Text

            Call limpiar_cristal

            TitRpt = "CERTIFICADO DE VENTA DEFINITIVA DE VALORES "
            BacTrader.BacRpt.Destination = 1
            BacTrader.BacRpt.ReportFileName = RptList_Path & "Certvp.rpt"
            BacTrader.BacRpt.StoredProcParam(0) = NumOper
            BacTrader.BacRpt.StoredProcParam(1) = Format(proFecha, "YYYYMMDD")
            BacTrader.BacRpt.Formulas(0) = "tit='" & TitRpt & "'"
            BacTrader.BacRpt.Connect = CONECCION
            BacTrader.BacRpt.Action = 1

            Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Impresión " & TitRpt)
            Marcar
        End If
        Grd.Row = Grd.Row - 1
    Loop

End Function

Function Func_Imprimir_Papeletas(Destino As Integer)

    Dim Sql        As String
    Dim RutCartera As String
    Dim NumOper    As String
    Dim cTipOper   As String
    Dim Res        As String
    Dim bAnulado   As Boolean

    If Grd.RowSel = 0 Then
       MsgBox "No ha seleccionado elemento", vbExclamation, "Impresión de Contratos"
       Exit Function
    End If
    
    
    Screen.MousePointer = 11
    If Grd.CellForeColor = vbRed Then
      MsgBox "Operación anulada, no es posible imprimir papeleta", vbInformation, gsBac_Version
      Screen.MousePointer = 0
      Exit Function
    End If

    Grd.Row = Grd.Rows - 1

    Do While Grd.Row > 0
        Grd.RowSel = Grd.Row
        If Verifica_Fila(Grd.Row) Then
            Grd.Col = 0:   NumOper = Grd.Text
            
            Grd.Col = 1:   cTipOper = UCase(Grd.Text)
            
            Grd.Col = 2:   RutCartera = Grd.Text
            
            Grd.Col = 8
            bAnulado = IIf(Left(Grd.Text, 1) = "A", True, False)
            If bAnulado Then cTipOper = Grd.Text
            If cTipOper = "CAP" Or cTipOper = "COL" Then
                cTipOper = "IB"
            End If
            If cTipOper = "ACAP" Or cTipOper = "ACOL" Then
                cTipOper = "AIB"
            End If
            
            If Mid$(cTipOper, 1, 1) = "A" And bAnulado Then
                Res = ImprimeAnulacionPapeleta(RutCartera, NumOper, Mid$(cTipOper, 2), Trim(Str(Destino)), proFecha)
            Else
                Res = ImprimePapeleta(RutCartera, NumOper, IIf(cTipOper = "AIC", "AC", cTipOper), "N", Trim(Str(Destino)), proFecha)
            End If
            
            If Res = "NO" Then
               MsgBox "Papeleta no puede ser REIMPRESA", vbCritical, "PAPELETAS"
            End If

            Marcar

        End If

        Grd.Row = Grd.Row - 1
    Loop



    If cmbopcion.ListCount > 0 Then
       Call BacCargaGrilla(cmbopcion.ListIndex)
    Else
       Call BacCargaGrilla(0)
    End If
    
    Screen.MousePointer = 0
    Grd.SetFocus
    Grd.Row = Val(Grd.Tag)
    Grd.Col = 0
    Grd.SetFocus
    Arreglo = 0
    
End Function



Sub Nombres()

    With Me.Grd
        
       .Cols = 7:   .Rows = 2
       .Row = 0: .Col = 0: .Text = "N.Operación"
       .Row = 0: .Col = 1: .Text = "Operación"
       .Row = 0: .Col = 2: .Text = "Rut Cartera"
       .Row = 0: .Col = 3: .Text = "Nombre Cliente"
       .Row = 0: .Col = 4: .Text = "Total Operación"
       .Row = 0: .Col = 5: .Text = "Hora"
       .Row = 0: .Col = 6: .Text = "Usuario"
       .RowHeight(0) = 350
       .ColWidth(0) = 1000
       .ColWidth(1) = 900
       .ColWidth(2) = 1000
       .ColWidth(3) = 3000
       .ColWidth(4) = 2000
       .ColWidth(5) = 1000
       .ColWidth(6) = 1600
       .BackColorFixed = &H808000
       .ForeColorFixed = &HFFFFFF
    End With

End Sub

Private Sub cmbopcion_Change()

    Call Nombres
      
    Call BacCargaGrilla(cmbopcion.ListIndex)

End Sub

Private Sub cmbopcion_Click()
    Call Nombres
      
    Call BacCargaGrilla(cmbopcion.ListIndex)

End Sub

Private Sub Form_Activate()

    Call Nombres
      
    Call BacCargaGrilla(cmbopcion.ListIndex)
       
End Sub

Private Sub Form_Load()
    
    Me.Left = 0
    Me.Top = 0
    cmbopcion.ListIndex = 0
    
    
    proFecha = gsBac_Fecp
    proTipo = "DIA"
    
    TipoImp = gsPant_TipoPap
    
    
    If TipoImp = "PAP" Then
        Me.Caption = "REIMPRESION DE PAPELETAS"
    End If
    
    If TipoImp = "CON" Then
        Me.Caption = "IMPRESION DE CONTRATOS"
        Me.Toolbar1.Buttons(2).Visible = False
    End If
    
    If TipoImp = "CER" Then
        Me.Caption = "CERTIFICADOS DE VENTAS"
        Me.Toolbar1.Buttons(2).Visible = False
    End If

    
    
    txtFecha.Text = Format(gsBac_Fecp, "DD/MM/YYYY")
    
    Call Nombres
      
    Call BacCargaGrilla(0)
    
    
End Sub

Private Sub GrdOper_Fetch(Row As Long, Col As Integer, Value As String)
    Me.Grd.Row = Row
    Me.Grd.Col = Col
End Sub


Sub Marcar()
   
   
   Dim F, C, R, v As Integer
   
   Dim lrow As Integer
   
   FilaSeleccionada = Grd.RowSel
   
   lrow = Me.Grd.TopRow
   
   With Me.Grd
   
      F = .RowSel       ' fila clickeada
      If .CellForeColor <> vbRed Then

      End If
      MarcaFila (F)
      .FocusRect = flexFocusHeavy
      .Redraw = False

'    For R = 1 To .Rows - 1
      .Row = F
        For C = 0 To .Cols - 1


               .Col = C
               If InStr(EnRojo, Format(Trim$(F), "000") + " ") <> 0 Then
'                  If R <> F Then                ' fila anulada no seleccionada
                     .BackColorSel = &HC0C0C0
                     .BackColorFixed = &H808000
                     .ForeColorFixed = &H80000005
                     .CellBackColor = &HC0C0C0
                     .CellForeColor = vbRed
 '                 End If
               Else
                  If Not Verifica_Fila(FilaSeleccionada) Then                ' fila no seleccionada
                     .BackColorSel = &HC0C0C0
                     .BackColorFixed = &H808000
                     .ForeColorFixed = &H80000005
                     .CellBackColor = &HC0C0C0
                     .CellForeColor = vbBlue
                  End If
                  
               End If
               
               If Verifica_Fila(FilaSeleccionada) Then     ' fila clickeada, seleccionada
                    .BackColorSel = &H800000
                    .BackColorFixed = &H808000
                    .ForeColorFixed = &H80000005
                    .CellBackColor = vbBlue    ''vbRed
                    .CellForeColor = vbWhite

               End If
        Next C
 '   Next R
      .Row = F
      .Col = 0
      .FocusRect = flexFocusLight
      .Redraw = True
   End With
   
   
    If lrow > 1 Then
        Me.Grd.TopRow = lrow
    End If
   
End Sub

Private Sub Form_Unload(Cancel As Integer)

    If TipoImp = "PAP" Then
        gsPant_ImpPape = False
    End If


    If TipoImp = "CON" Then
        gsPant_ImpCont = False
    End If


    If TipoImp = "CER" Then
        gsPant_ImpCert = False
    End If


End Sub

Private Sub Func_Imprimir_Contratos()

   Dim TitRpt           As String
   Dim RutCartera       As String
   Dim NumOper          As String
   Dim cTipOper         As String
   Dim nMoneda          As Integer


   Grd.RowSel = FilaSeleccionada

   Screen.MousePointer = 11
   gsTipoPapeleta = "C"

   If Grd.RowSel = 0 Then
      Screen.MousePointer = 0
      MsgBox "No ha seleccionado elemento", vbExclamation, "Impresión de Contratos"
      Exit Sub
   End If

    Grd.Row = Grd.Rows - 1

    Do While Grd.Row > 0
        Grd.RowSel = Grd.Row
        If Verifica_Fila(Grd.Row) Then
           
           Grd.Col = 0: NumOper = Grd.Text
           Grd.Col = 1: cTipOper = Grd.Text
           Grd.Col = 2: RutCartera = Grd.Text
           Grd.Col = 10: nMoneda = Grd.Text
        
           If cTipOper = "CAP" Then
              cTipOper = "IB"
        
           End If
        
           BacTrader.BacRpt.Destination = crptToPrinter
           
           
           Call limpiar_cristal
           
           Select Case Trim$(UCase$(cTipOper))
           Case "CI"
              'Adrian Listo
              TitRpt = "COMPRA CON PACTO "
              BacTrader.BacRpt.ReportFileName = RptList_Path & "PAPCNTCI.RPT"
              BacTrader.BacRpt.StoredProcParam(0) = RutCartera
              BacTrader.BacRpt.StoredProcParam(1) = NumOper
              BacTrader.BacRpt.StoredProcParam(2) = "C"
              BacTrader.BacRpt.StoredProcParam(3) = Format(proFecha, "YYYYMMDD")
              BacTrader.BacRpt.Formulas(0) = "TIT='" & TitRpt & "'"
              BacTrader.BacRpt.Connect = CONECCION
              BacTrader.BacRpt.Action = 1
              BacTrader.BacRpt.ReportFileName = RptList_Path & "PAPCNTCIV.RPT" 'Promesa de Venta
              BacTrader.BacRpt.StoredProcParam(0) = RutCartera
              BacTrader.BacRpt.StoredProcParam(1) = NumOper
              BacTrader.BacRpt.StoredProcParam(2) = "C"
              BacTrader.BacRpt.StoredProcParam(3) = Format(proFecha, "YYYYMMDD")
              BacTrader.BacRpt.Formulas(0) = "TIT='" & TitRpt & "'"
              BacTrader.BacRpt.Connect = CONECCION
              BacTrader.BacRpt.Action = 1
              Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Impresión " & TitRpt)
        
           Case "VI"
              'Adrian listo
              TitRpt = "VENTA CON PACTO "
              BacTrader.BacRpt.ReportFileName = RptList_Path & "PAPCNTVI.RPT"
              BacTrader.BacRpt.StoredProcParam(0) = RutCartera
              BacTrader.BacRpt.StoredProcParam(1) = NumOper
              BacTrader.BacRpt.StoredProcParam(2) = "P"
              BacTrader.BacRpt.StoredProcParam(3) = Format(proFecha, "YYYYMMDD")
              BacTrader.BacRpt.Formulas(0) = "TIT='" & TitRpt & "'"
              BacTrader.BacRpt.Connect = CONECCION
              BacTrader.BacRpt.Action = 1
              Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Impresión " & TitRpt)
        
           Case "CP"
              'Adrian Listo
              TitRpt = "COMPRA DEFINITIVA "
              BacTrader.BacRpt.ReportFileName = RptList_Path & "PAP_CP.RPT"
              BacTrader.BacRpt.StoredProcParam(0) = RutCartera
              BacTrader.BacRpt.StoredProcParam(1) = NumOper
              BacTrader.BacRpt.StoredProcParam(2) = "P"
              BacTrader.BacRpt.StoredProcParam(3) = Format(proFecha, "YYYYMMDD")
              BacTrader.BacRpt.Formulas(0) = "TIT='" & TitRpt & "'"
              BacTrader.BacRpt.Connect = CONECCION
              BacTrader.BacRpt.Action = 1
              Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Impresión " & TitRpt)
        
           Case "VP"
              'Adrian Listo
              TitRpt = "VENTA DEFINITIVA "
              BacTrader.BacRpt.ReportFileName = RptList_Path & "PAP_VP.RPT"
              BacTrader.BacRpt.StoredProcParam(0) = RutCartera
              BacTrader.BacRpt.StoredProcParam(1) = NumOper
              BacTrader.BacRpt.StoredProcParam(2) = "P"
              BacTrader.BacRpt.StoredProcParam(3) = "VP"
              BacTrader.BacRpt.StoredProcParam(4) = Format(proFecha, "YYYYMMDD")
              BacTrader.BacRpt.Formulas(0) = "TIT='" & TitRpt & "'"
              BacTrader.BacRpt.Connect = CONECCION
              BacTrader.BacRpt.Action = 1
              Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Impresión " & TitRpt)
        
           Case "IB"
              'Adrian Listo
              TitRpt = "PAGARE INTERBANCARIO EN  "
              If nMoneda = 999 Then
                  BacTrader.BacRpt.ReportFileName = RptList_Path & "CONINTER.RPT"
              Else
                  BacTrader.BacRpt.ReportFileName = RptList_Path & "CONINTER2.RPT"
              End If
              BacTrader.BacRpt.StoredProcParam(0) = RutCartera
              BacTrader.BacRpt.StoredProcParam(1) = NumOper
              BacTrader.BacRpt.StoredProcParam(2) = "C"
              BacTrader.BacRpt.StoredProcParam(3) = Format(proFecha, "YYYYMMDD")
              BacTrader.BacRpt.Formulas(0) = "TIT='" & TitRpt & "'"
              BacTrader.BacRpt.Connect = CONECCION
              BacTrader.BacRpt.Action = 1
              Call Grabar_Log("BTR", gsBac_User, gsBac_Fecp, "Impresión " & TitRpt)
        
           Case "COL"
              MsgBox "Colocación Interbancaria no Genera Contrato", 64
        
           Case "ST"
              MsgBox "Sorteo de Letras no Genera Contrato", 64
        
           End Select
           Marcar
        End If
        Grd.Row = Grd.Row - 1
    Loop

   If cmbopcion.ListCount > 0 Then
      Call BacCargaGrilla(cmbopcion.ListIndex)

   Else
      Call BacCargaGrilla(0)

   End If

   Screen.MousePointer = 0

End Sub


Private Sub Grd_Click()
Me.Grd.Tag = Me.Grd.RowSel
Call Marcar
End Sub

Private Sub Grd_LostFocus()
'Grd.Tag = Grd.RowSel
End Sub

Private Sub Opt_Dia_Click(Value As Integer)

    Me.txtFecha.Text = Format(gsBac_Fecp, "DD/MM/YYYY")
    Me.txtFecha.Enabled = False

    proFecha = gsBac_Fecp
    proTipo = "DIA"

    Call BacCargaGrilla(Me.cmbopcion.ListIndex)

End Sub

Private Sub Opt_Hist_Click(Value As Integer)

    Me.txtFecha.Enabled = True
    
    Me.Grd.Cols = 10
    Me.Grd.Rows = 1
    Me.Grd.Row = 0

End Sub


Private Sub Option1_Click()

End Sub

Private Sub Option2_Click()

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Dim i As Double
Dim J As Double

    Select Case UCase(Button.Description)
    
    Case "PANTALLA"
    
        If TipoImp = "PAP" Then
            Call Func_Imprimir_Papeletas(0)
        End If

    
    Case "IMPRIMIR"
    
        If TipoImp = "PAP" Then
            Call Func_Imprimir_Papeletas(1)
        End If
        
        If TipoImp = "CON" Then
            Call Func_Imprimir_Contratos
        End If

        If TipoImp = "CER" Then
            Call Func_Imprimir_Certificados
        End If

    Case "MARCA"
        If Button.Image = 5 Then 'marco todos
            For i = Grd.Rows - 1 To 1 Step -1
                Grd.Redraw = False
                Grd.TextMatrix(i, 11) = "X"
                Grd.Row = i
                Grd.TopRow = i
                For J = 0 To Grd.Cols - 1
                    Grd.Col = J
                    Grd.BackColorSel = &H800000
                    Grd.BackColorFixed = &H808000
                    Grd.ForeColorFixed = &H80000005
                    Grd.CellBackColor = vbBlue       ''vbRed
                    Grd.CellForeColor = vbWhite
                Next J
                Grd.Redraw = True
            Next i
        Else
            For i = 1 To Grd.Rows - 1
                Grd.TextMatrix(i, 11) = ""
                Grd.Redraw = False
                Grd.Row = i
                For J = 0 To Grd.Cols - 1
                    Grd.Col = J
                    If InStr(EnRojo, Format(Trim$(i), "000") + " ") <> 0 Then
                        Grd.BackColorSel = &HC0C0C0
                        Grd.BackColorFixed = &H808000
                        Grd.ForeColorFixed = &H80000005
                        Grd.CellBackColor = &HC0C0C0
                        Grd.CellForeColor = vbRed
                    Else
                        Grd.BackColorSel = &HC0C0C0
                        Grd.BackColorFixed = &H808000
                        Grd.ForeColorFixed = &H80000005
                        Grd.CellBackColor = &HC0C0C0
                        Grd.CellForeColor = vbBlue
                    End If
                Next J
                Grd.Redraw = True
            Next i
        End If
        
        Button.Image = IIf((Button.Image = 6), 5, 6)

        
    Case "SALIR"
    
        Unload Me
            
    End Select
    
    Exit Sub

ErrPrinter:
    MsgBox "Problemas en impresión de papeletas: " & Err.Description & ". Verifique. ", vbExclamation, "BAC Trader"
    Exit Sub


End Sub






Private Sub TxtFecha_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
        SendKeys "{TAB}"
    End If


End Sub

Private Sub TxtFecha_LostFocus()

    If CDate(Me.txtFecha.Text) = gsBac_Fecp Then
        proTipo = "DIA"
        proFecha = gsBac_Fecp
    Else
        proTipo = "HIS"
        proFecha = CDate(Me.txtFecha.Text)
    End If

    If Me.cmbopcion.ListIndex <> -1 And Me.Visible = True Then
        Call BacCargaGrilla(Me.cmbopcion.ListIndex)
    End If
      
End Sub

Function Verifica_Fila(fila As Integer) As Boolean

Dim Max As Integer
Dim i As Integer
Dim Aux As Double

Dim H
Dim jjjjjj As Double


If Grd.TextMatrix(fila, 11) = "X" Then
    Verifica_Fila = True
Else
    Verifica_Fila = False
End If


'Aux = Arreglo
'
'Max = Me.Grd.Rows
'
'For i = Max To 0 Step -1
'
'If (2 ^ i) <= Aux Then
'    Aux = Aux - (2 ^ i)
'    If i = fila Then
'        Verifica_Fila = True
'        Exit For
'    End If
'End If
'If Aux = 0 Or i = fila Then
'    Verifica_Fila = False
'    Exit For
'End If
'Next i

End Function    'jlc

Function MarcaFila(fila As Integer)

If Grd.TextMatrix(fila, 11) = "X" Then
    Grd.TextMatrix(fila, 11) = ""
Else
    Grd.TextMatrix(fila, 11) = "X"
End If

'If Verifica_Fila(fila) Then
'    Arreglo = Arreglo - (2 ^ fila)
'Else
'    Arreglo = Arreglo + (2 ^ fila)
'End If

End Function    'jlc
