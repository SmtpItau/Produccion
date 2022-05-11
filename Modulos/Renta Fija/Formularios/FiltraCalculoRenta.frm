VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form FiltraOperRenta 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Filtra operaciones para rentabilidad "
   ClientHeight    =   4740
   ClientLeft      =   660
   ClientTop       =   3645
   ClientWidth     =   10740
   ForeColor       =   &H00C0C0C0&
   Icon            =   "FiltraCalculoRenta.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4740
   ScaleWidth      =   10740
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   7
      Top             =   0
      Width           =   10740
      _ExtentX        =   18944
      _ExtentY        =   794
      ButtonWidth     =   767
      ButtonHeight    =   741
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbimprimir"
            Description     =   "IMPRIMIR"
            Object.ToolTipText     =   "Imprimir"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
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
         NumListImages   =   2
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FiltraCalculoRenta.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FiltraCalculoRenta.frx":0624
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSFlexGridLib.MSFlexGrid Grd 
      Height          =   3660
      Left            =   120
      TabIndex        =   6
      Top             =   930
      Width           =   10560
      _ExtentX        =   18627
      _ExtentY        =   6456
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
      ItemData        =   "FiltraCalculoRenta.frx":093E
      Left            =   1740
      List            =   "FiltraCalculoRenta.frx":094B
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
Attribute VB_Name = "FiltraOperRenta"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit
Dim EnRojo As String
Public proFecha As String
Public proTipo As String
Private Sub BacCargaGrilla(nOpcion As Long)
Dim cOpcion As String
Dim nCant   As Integer

    Call Nombres

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
'        Sql = "EXECUTE SP_CONSULTAOPERPAPEL '" & cOpcion & "'"

        Envia = Array(cOpcion, "P")

        If Not Bac_Sql_Execute("SP_CONSULTAOPERPAPEL", Envia) Then
            Screen.MousePointer = 0
            MsgBox "No se puede conectar a tabla de movimientos", 16
            Exit Sub
        End If
    Else
'        Sql = "EXECUTE SP_QUERYHISPAPEL '" & proFecha & "','" & cOpcion & "'"
        
        Envia = Array(proFecha, cOpcion)

        If Not Bac_Sql_Execute("SP_QUERYHISPAPEL", Envia) Then
            Screen.MousePointer = 0
            MsgBox "No se puede conectar a tabla de movimientos", 16
            Exit Sub
        End If

    End If
        
    Dim Datos()
    
    Grd.Cols = 10
    Grd.Rows = 1
    Grd.Row = 0
    nCant = 0
    
    Dim x
    
    For x = 7 To 9
        Grd.ColWidth(x) = 0
    Next x
    
    Grd.Redraw = False
    Do While Bac_SQL_Fetch(Datos())
        Grd.Rows = Grd.Rows + 1
        Grd.Row = Grd.Rows - 1
        Grd.Col = 0: Grd.Text = Val(Datos(1))
        Grd.Col = 1: Grd.Text = IIf(Mid$(Datos(2), 1, 1) = "A" And Len(Datos(10)) <> 0, Mid$(Datos(2), 2), Datos(2))
        Grd.Col = 4: Grd.Text = Format(Val(Datos(5)), "###,###0.000")
        Grd.Col = 3: Grd.Text = Datos(4)
        Grd.Col = 5: Grd.Text = Datos(6)
        Grd.Col = 2: Grd.Text = Datos(3)
        Grd.Col = 6: Grd.Text = Datos(7)
        Grd.Col = 7: Grd.Text = IIf(Mid$(Datos(2), 1, 1) = "A" And Len(Datos(10)) <> 0, 2, 1)
        Grd.Col = 8: Grd.Text = Datos(2)
        Grd.Col = 9: Grd.Text = Datos(4)
        nCant = nCant + 1
        Grd.RowHeight(Grd.Row) = 350
        
       
        If Datos(10) = "A" Then
            EnRojo = EnRojo & Format(Grd.Row, "000") & "-"
            For x = 0 To 9
                Grd.Col = x
                Grd.CellForeColor = vbRed
            Next x
        End If
        
    Loop
    
    Grd.Redraw = True
    'GrdOper.Rows = 0
    'GrdOper.Rows = Grd.Rows - 1
    
    Screen.MousePointer = 0
    If nCant = 0 Then
        MsgBox "No existen operaciones para Reimprimir ", vbExclamation, gsBac_Version
    End If
    
End Sub


Private Sub cmbopcion_Click()

      If cmbopcion.ListIndex <> -1 Then
         Call BacCargaGrilla(cmbopcion.ListIndex)
      End If
      
End Sub



Private Sub cmdImprimir_Click()
Dim Sql        As String
Dim RutCartera As String
Dim NumOper    As String
Dim cTipOper   As String
Dim Res        As String
Dim bAnulado   As Boolean

On Error GoTo ErrPrinter

    Screen.MousePointer = 11
    
    Grd.Col = 0:   NumOper = Grd.Text
    
    Grd.Col = 1:   cTipOper = Grd.Text
    
    Grd.Col = 2:   RutCartera = Grd.Text
    
    Grd.Col = 8
    bAnulado = IIf(Left(Grd.Text, 1) = "A", True, False)
    
    If cTipOper = "CAP" Or cTipOper = "COL" Then
        cTipOper = "IB"
    End If
    If cTipOper = "ACA" Or cTipOper = "ACO" Then
        cTipOper = "AIB"
    End If
    
    If proTipo = "DIA" Then
        If Mid$(cTipOper, 1, 1) = "A" And bAnulado Then
            Res = ImprimeAnulacionPapeleta(RutCartera, NumOper, Mid$(cTipOper, 2))
        Else
            Res = ImprimePapeleta(RutCartera, NumOper, IIf(cTipOper = "AIC", "AC", cTipOper), "N")
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
   .Cols = 8:   .Rows = 2
   .Row = 0: .Col = 0: .Text = "Numero"
   .Row = 0: .Col = 1: .Text = "Tipo"
   .Row = 0: .Col = 2: .Text = "Instrumento"
   .Row = 0: .Col = 3: .Text = "Contraparte"
   .Row = 0: .Col = 4: .Text = "Valor Nominal"
   .Row = 0: .Col = 5: .Text = "Tir"
   .Row = 0: .Col = 6: .Text = "Valor Presente"
   .Row = 0: .Col = 7: .Text = "Tipo de cartera"
   .Row = 0: .Col = 8: .Text = "Indicador"

   .RowHeight(0) = 350
   .ColWidth(0) = 800
   .ColWidth(1) = 500
   .ColWidth(2) = 950
   .ColWidth(3) = 3200
   .ColWidth(4) = 1800
   .ColWidth(5) = 1000
   .ColWidth(6) = 1600
   .ColWidth(7) = 1600
   .ColWidth(8) = 1600

   .BackColorFixed = &H808000
   .ForeColorFixed = &HFFFFFF
End With


End Sub
Private Sub Form_Activate()
    Call Nombres
      
    Call BacCargaGrilla(0)
    
    If Grd.Rows = 1 Then
        Unload Me
        Exit Sub
    End If
        
    If proTipo = "HIS" Then
        Me.Caption = "Reimpresión papeletas del día : " & Mid$(Me.proFecha, 7, 2) & "/" & Mid$(Me.proFecha, 5, 2) & "/" & Mid$(Me.proFecha, 1, 4)
    End If
End Sub

Private Sub Form_Load()
    
    Me.Left = 0
    Me.Top = 0
    cmbopcion.ListIndex = 0
    
End Sub

Private Sub GrdOper_Fetch(Row As Long, Col As Integer, Value As String)
    Grd.Row = Row
    Grd.Col = Col
End Sub


Private Sub GrdOper_FetchAttributes(Status As Integer, Split As Integer, Row As Long, Col As Integer, FgColor As Long, BgColor As Long, FontStyle As Integer)
'    Grd.Row = Row
'    Grd.Col = 8
'     If Row = GrdOper.RowIndex Then  'Col = GrdOper.ColumnIndex And
'        FgColor = BacToolTip.Color_Dest.ForeColor
'        BgColor = BacToolTip.Color_Dest.BackColor
'     Else
'        If Val(Grd.Text) = 1 Then
'            FgColor = BacToolTip.Color_Normal.ForeColor
'            BgColor = BacToolTip.Color_Normal.BackColor
'        Else
'            FgColor = BacToolTip.Color_Bloqueado.ForeColor
'            BgColor = BacToolTip.Color_Bloqueado.BackColor
'        End If
'    End If
End Sub


Sub Marcar()
   
   
   Dim F, C, R, v As Integer
   With Grd
      F = .RowSel
      If .CellForeColor <> vbRed Then
      
      End If
      .FocusRect = flexFocusHeavy
      .Redraw = False
    For R = 1 To .Rows - 1
         
        For C = 0 To .Cols - 1
               .Row = R
               .Col = C
               ''If R = Val(Trim(Mid(EnRojo, R, 3))) Then
               ''NUEVO
               If InStr(EnRojo, Format(R, "000")) <> 0 Then
                  '''.BackColorSel = &HC0C0C0
                  '''.BackColorFixed = &H808000
                  '''.ForeColorFixed = &H80000005
                  '''.CellBackColor = vbRed    ''&HC0C0C0
                  '''.CellForeColor = vbWhite
                  ''
                  If R <> F Then
                     .BackColorSel = &HC0C0C0
                     .BackColorFixed = &H808000
                     .ForeColorFixed = &H80000005
                     .CellBackColor = &HC0C0C0
                     .CellForeColor = vbRed
                  End If
                  ''''
               Else 'Es Azul
               
                  If R <> F Then
                     .BackColorSel = &HC0C0C0
                     .BackColorFixed = &H808000
                     .ForeColorFixed = &H80000005
                     .CellBackColor = &HC0C0C0
                     .CellForeColor = vbBlue
                  End If
                  
               End If
               '' NUEVO
                If F = R Then
                     .BackColorSel = &H800000
                     .BackColorFixed = &H808000
                     .ForeColorFixed = &H80000005
                     .CellBackColor = vbBlue    ''vbRed
                     .CellForeColor = vbWhite
                End If
               '' FIN NUEVO
        Next C
    Next R
      .Row = F
      .Col = 0
      .FocusRect = flexFocusLight
      .Redraw = True
   End With
End Sub

Private Sub Grd_Click()
Grd.Tag = Grd.RowSel
Call Marcar
End Sub

Private Sub Grd_LostFocus()
'Grd.Tag = Grd.RowSel
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case UCase(Button.Description)
Case "IMPRIMIR"
  Dim Sql        As String
  Dim RutCartera As String
  Dim NumOper    As String
  Dim cTipOper   As String
  Dim Res        As String
  Dim bAnulado   As Boolean

  On Error GoTo ErrPrinter

    Screen.MousePointer = 11
    If Grd.CellForeColor = vbRed Then
      MsgBox "Operación anulada, no es posible imprimir papeleta", vbInformation, "BacTrader Full"
      Screen.MousePointer = 0
      Exit Sub
    End If
    
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
    
    If proTipo = "DIA" Then
        If Mid$(cTipOper, 1, 1) = "A" And bAnulado Then
            Res = ImprimeAnulacionPapeleta(RutCartera, NumOper, Mid$(cTipOper, 2))
        Else
            Res = ImprimePapeleta(RutCartera, NumOper, IIf(cTipOper = "AIC", "AC", cTipOper), "N")
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
    Grd.SetFocus
    Grd.Row = Val(Grd.Tag)
    Grd.Col = 0
    Grd.SetFocus
    
    Exit Sub
ErrPrinter:
    MsgBox "Problemas en impresión de papeletas: " & err.Description & ". Verifique. ", vbExclamation, "BAC Trader"
    Exit Sub
Case "SALIR"
        Unload Me
End Select
End Sub
