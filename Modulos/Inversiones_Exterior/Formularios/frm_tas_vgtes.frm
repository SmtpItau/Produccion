VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.2#0"; "mscomctl.ocx"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Begin VB.Form Bac_Valorizacion_Mercado 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Tasas De Mercado"
   ClientHeight    =   6000
   ClientLeft      =   210
   ClientTop       =   1995
   ClientWidth     =   11085
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   Icon            =   "frm_tas_vgtes.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   6000
   ScaleWidth      =   11085
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   660
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   11085
      _ExtentX        =   19553
      _ExtentY        =   1164
      ButtonWidth     =   1032
      ButtonHeight    =   1005
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   7
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   9
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   11
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.ToolTipText     =   "Exporta"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.ToolTipText     =   "Imprime"
            ImageIndex      =   10
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Object.ToolTipText     =   "Importa"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   12
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin MSComDlg.CommonDialog Dig_Tasa 
      Left            =   660
      Top             =   6000
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin VB.Frame frm_datos 
      Caption         =   "Descripcion"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00C00000&
      Height          =   4245
      Left            =   0
      TabIndex        =   3
      Top             =   1755
      Width           =   11100
      Begin BACControles.TXTNumero txt_numero 
         Height          =   240
         Left            =   1200
         TabIndex        =   5
         Top             =   1440
         Visible         =   0   'False
         Width           =   3855
         _ExtentX        =   6800
         _ExtentY        =   423
         BackColor       =   12632256
         ForeColor       =   16711680
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BorderStyle     =   0
         Text            =   "0,0000000"
         Text            =   "0,0000000"
         CantidadDecimales=   "7"
         SelStart        =   4
      End
      Begin MSFlexGridLib.MSFlexGrid grilla 
         Height          =   3930
         Left            =   90
         TabIndex        =   4
         Top             =   210
         Width           =   10920
         _ExtentX        =   19262
         _ExtentY        =   6932
         _Version        =   393216
         Rows            =   1
         Cols            =   14
         FixedCols       =   4
         BackColor       =   -2147483644
         ForeColor       =   16711680
         BackColorFixed  =   8421376
         ForeColorFixed  =   -2147483643
         BackColorSel    =   8388608
         ForeColorSel    =   12632256
         BackColorBkg    =   8421376
         GridColor       =   64
         HighLight       =   2
         GridLines       =   2
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   9
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MouseIcon       =   "frm_tas_vgtes.frx":030A
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   0
      Top             =   6000
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   32
      ImageHeight     =   32
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   18
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_tas_vgtes.frx":075C
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_tas_vgtes.frx":0A76
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_tas_vgtes.frx":0EC8
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_tas_vgtes.frx":131A
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_tas_vgtes.frx":1634
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_tas_vgtes.frx":194E
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_tas_vgtes.frx":1DA0
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_tas_vgtes.frx":1EFA
            Key             =   ""
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_tas_vgtes.frx":234C
            Key             =   ""
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_tas_vgtes.frx":279E
            Key             =   ""
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_tas_vgtes.frx":2AB8
            Key             =   ""
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_tas_vgtes.frx":2DD2
            Key             =   ""
         EndProperty
         BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_tas_vgtes.frx":2F2C
            Key             =   ""
         EndProperty
         BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_tas_vgtes.frx":337E
            Key             =   ""
         EndProperty
         BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_tas_vgtes.frx":37D0
            Key             =   ""
         EndProperty
         BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_tas_vgtes.frx":3AEA
            Key             =   ""
         EndProperty
         BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_tas_vgtes.frx":3E04
            Key             =   ""
         EndProperty
         BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "frm_tas_vgtes.frx":411E
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.Frame frm_fecha 
      BackColor       =   &H80000004&
      Caption         =   "Fecha De Proceso"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00C00000&
      Height          =   990
      Left            =   -15
      TabIndex        =   2
      Top             =   720
      Width           =   11115
      Begin VB.CommandButton cmdValorizar 
         Height          =   465
         Left            =   1740
         Picture         =   "frm_tas_vgtes.frx":4570
         Style           =   1  'Graphical
         TabIndex        =   6
         Top             =   300
         Width           =   555
      End
      Begin BACControles.TXTFecha txt_fecha 
         Height          =   255
         Left            =   180
         TabIndex        =   1
         Top             =   390
         Width           =   1350
         _ExtentX        =   2381
         _ExtentY        =   450
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
         Text            =   "26/10/2001"
      End
   End
End
Attribute VB_Name = "Bac_Valorizacion_Mercado"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim FILAS As Double
Dim conte As Double
Dim c1, c2, r1, r2 As Integer
Dim Sw_Tir
Dim Sw_Pvp

'CONSTANTES DE BOTONES DE TOOLBAR
Const nbtnGrabar = 1
Const nbtnBuscar = 2
Const nbtnLimpiar = 3
Const nbtnExportar = 4
Const nbtnImprimir = 5
Const nbtnImportar = 6
Const nbtnSalir = 7

'CONSTANTES DE COLUMNAS DE GRILLA
Const ncolFamilia = 0
Const ncolInstrum = 1
Const ncolVcto = 2
Const ncolDocu = 3
Const ncolNominal = 4
Const ncolVP = 5
Const ncolRut = 6
Const ncolTir = 7
Const ncolVC = 8
Const ncolTirMerc = 9
Const ncolVCMerc = 10
Const ncolVpTm = 11
Const ncolOculta1 = 12
Const ncolDifMerc = 13
Const ncolOculta2 = 14
Const ncolIdent = 15
'+++COLTES, jcamposd 20171218
Const nColtes = 16
'---COLTES, jcamposd 20171218


Private Function Func_Leer_Celda(objSheet As Object, sCelda As String) As Variant  'Double

   Dim nColumna      As Integer
   Dim nFila         As Integer

   nColumna = Asc(Mid$(UCase(sCelda), 1, 1)) - 64
   nFila = Val(Trim(Mid$(sCelda, 2, 5)))
 
   'If nColumna = 1 Or nColumna = 3 Or nColumna = 13 Then
   If nColumna = 1 Or nColumna = 3 Or nColumna = 13 Or nColumna = 2 Then
        Func_Leer_Celda = objSheet.Cells(nFila, nColumna)
   Else
     Select Case nColumna
       Case 10
         If VarType(objSheet.Cells(nFila, nColumna)) = vbString Then
            Func_Leer_Celda = 0
         Else
            Func_Leer_Celda = CDbl(objSheet.Cells(nFila, nColumna))
         End If
       Case Else
         Func_Leer_Celda = CDbl(objSheet.Cells(nFila, nColumna))
     End Select
   End If

End Function
Sub Exp_excel(frm As Form, titulo As String, grilla As MSFlexGrid)
    
    Dim Fila As Integer
    Dim ws As Object
    Dim Col As Long
    Dim row As Long
    Dim colum As Long
    Dim SomeArray() As Variant

    On Error GoTo Error
   
    ReDim SomeArray(grilla.Rows, grilla.Cols - 1)
    ' Copia grilla a un arreglo ******************************************
    Screen.MousePointer = vbHourglass
    
    With grilla
       For row = 0 To .Rows - 1
         colum = 0
         For Col = 0 To .Cols - 1
           If .ColWidth(Col) > 0 And Trim(.TextMatrix(0, Col)) <> "" Then
             SomeArray(row, colum) = .TextMatrix(row, Col)
             colum = colum + 1
           End If
         Next
       Next
    End With
    
    Set ws = CreateObject("Excel.Application")
    ws.Workbooks.Add
    'Pega los datos en Excel *********************************************
    ws.Range(ws.Cells(1, 1), ws.Cells(Fila + grilla.Rows, colum)).Value = SomeArray
    Call FormatExcelTasaMercado(ws)
    Screen.MousePointer = vbDefault
    Exit Sub
    Resume
   
Error:
   Beep
   Screen.MousePointer = vbDefault
   MsgBox "Imposible Realizar Exportación", vbCritical, App.ProductName
   Exit Sub
End Sub
Sub FormatExcelTasaMercado(ws As Object)
  With ws
    .Range("A1:L1").Select
    .Selection.Font.Bold = True
    With .Selection
        HorizontalAlignment = xlCenter
        VerticalAlignment = xlBottom
        WrapText = False
        Orientation = 0
        ShrinkToFit = False
        MergeCells = False
    End With
    With .Selection.Interior
        .ColorIndex = 15
        .Pattern = xlSolid
    End With
    .Columns("A:A").ColumnWidth = 11.71
    .Columns("B:B").ColumnWidth = 11.29
    .Columns("C:C").ColumnWidth = 15.71
    .Columns("C:C").ColumnWidth = 14.14
    .Columns("C:D").Select
    .Selection.ColumnWidth = 13.14
    .Columns("E:E").Select
    .Selection.ColumnWidth = 15.43
    .Columns("E:F").Select
    .Selection.ColumnWidth = 19.29
    .ActiveWindow.SmallScroll ToRight:=4
    .Columns("G:I").Select
    .Selection.ColumnWidth = 17.29
    .Selection.ColumnWidth = 17.86
    .ActiveWindow.SmallScroll ToRight:=2
    .Columns("K:K").Select
    .Selection.ColumnWidth = 18.14
    .Selection.ColumnWidth = 18.86
    .Range("K4").Select
    .ActiveWindow.ScrollColumn = 1
    
    .Columns("L:L").ColumnWidth = 18.43
    .Range("A1:L1").Select
    .Range("L1").Activate
    With .Selection.Interior
        .ColorIndex = 15
        .Pattern = xlSolid
    End With
    
    .Columns("M:M").Select
    .Selection.Cut
    .ActiveWindow.LargeScroll ToRight:=-2
    .Columns("A:A").Select
    .Selection.Insert Shift:=xlToRight
    .Range("A1").Select
    .Selection.Font.Bold = True
    With .Selection
        HorizontalAlignment = xlCenter
        VerticalAlignment = xlBottom
        WrapText = False
        Orientation = 0
        ShrinkToFit = False
        MergeCells = False
    End With
    .Columns("A:A").ColumnWidth = 12.43
    .Columns("A:A").ColumnWidth = 13.14
    
    .Range("A2").Select
    .Visible = True
    
   End With
   
End Sub
Function actualizar_sw_tasas_mercado()
    Dim Datos()
    envia = Array()
    AddParam envia, 1
    If Bac_Sql_Execute("SVA_MER_ACT_SWT", envia) Then
        Do While Bac_SQL_Fetch(Datos)
        Loop
    End If
    
End Function



Function buscar_datos(Fecha)
    
    Dim C, R As Double
    Dim Datos()
    Dim i
    Dim lrow As Integer
   
    If txt_fecha.Text = "  /  /    " Then
        Exit Function
    End If
   
    Screen.MousePointer = vbHourglass

    Call dibuja_grilla

    envia = Array()
    AddParam envia, Fecha
    
    If Bac_Sql_Execute("SVC_MER_BUS_CAR ", envia) Then 'new
        i = 1
        
        grilla.Redraw = False
        
        Do While Bac_SQL_Fetch(Datos)
        
            If grilla.Rows = i Then
                grilla.Rows = grilla.Rows + 1
            End If

' MAP 20160606 Eliminado programacion en duro.
'            If Val(Datos(3)) = 2000 Then
'                grilla.TextMatrix(i, 0) = "BONEX"
'
'            ElseIf Val(Datos(3)) = 2001 Then
'                grilla.TextMatrix(i, 0) = "CD"
'
'            ElseIf Val(Datos(3)) = 2002 Then
'                grilla.TextMatrix(i, 0) = "NOTEX"
'
'            ElseIf Val(Datos(3)) = 2004 Then
'                grilla.TextMatrix(i, 0) = "DEPEX"
'
'            End If
            
            grilla.TextMatrix(i, 0) = Datos(27)

            grilla.TextMatrix(i, ncolInstrum) = Datos(4)
            grilla.TextMatrix(i, ncolVcto) = Datos(5)
            grilla.TextMatrix(i, ncolDocu) = Datos(2)
            grilla.TextMatrix(i, ncolNominal) = Format(CDbl(Datos(6)), "###,###,###,#0.0000")
            grilla.TextMatrix(i, ncolVP) = Format(CDbl(Datos(7)), "###,###,###,#0.0000")
            grilla.TextMatrix(i, ncolRut) = Format(CDbl(Datos(8)), "###,###,###,#0.0000")
            grilla.TextMatrix(i, ncolTir) = Format(CDbl(Datos(9)), "###,###,###,#0.0000000")
            grilla.TextMatrix(i, ncolVC) = Format(CDbl(Datos(10)), "###,###,###,#0.0000")
            grilla.TextMatrix(i, ncolTirMerc) = Format(CDbl(Datos(11)), "###,###,###,#0.0000")
            grilla.TextMatrix(i, ncolVCMerc) = Format(CDbl(Datos(12)), "###,###,###,#0.000000000000") 'MAP 20171218
            grilla.TextMatrix(i, ncolVpTm) = Format(CDbl(Datos(13)), "###,###,###,#0.0000")
            grilla.TextMatrix(i, 12) = CDbl(Datos(15))
            grilla.TextMatrix(i, ncolDifMerc) = Format(CDbl(Datos(13)) - CDbl(Datos(7)), "###,###,###,#0.0000")
            '+++COLTES, jcamposd 20171218
            grilla.TextMatrix(i, nColtes) = Datos(31)
            '---COLTES, jcamposd 20171218
            
            If CDbl(Datos(11)) <> 0 Then
               grilla.TextMatrix(i, 14) = 2
               
            ElseIf CDbl(Datos(12)) <> 0 Then
               grilla.TextMatrix(i, 14) = 1
               
            Else
               grilla.TextMatrix(i, 14) = ""
               
            End If
            '----------------------------
            
            If Datos(15) <> "0" Then
            
                FilaSeleccionada = grilla.RowSel
                lrow = grilla.TopRow
                
                r1 = i
                r2 = i
                c1 = Datos(15)
                
                grilla.ForeColorFixed = vbWhite
               
                With grilla
                    f = .RowSel
                    .FocusRect = flexFocusHeavy
                    
                    For C = 4 To .Cols - 1
                        .row = r2
                        .Col = C
                        .BackColorSel = &HC0C0C0
                        .BackColorFixed = &H808000
                        .ForeColorFixed = &H80000005
                        .CellBackColor = &HC0C0C0
                        .CellForeColor = vbBlue
                    Next C
                    
                    .row = r1
                    .Col = c1
                    .BackColorSel = &H800000:
                    .BackColorFixed = &H808000
                    .ForeColorFixed = &H80000005
                    .CellBackColor = vbBlue    ''vbRed
                    .CellForeColor = vbWhite
                    .FocusRect = flexFocusLight
                
                End With
                
                If lrow > 1 Then
                    grilla.TopRow = lrow
                End If
                
            End If
                    
            If Datos(16) <> "" Then
               grilla.TextMatrix(i, ncolIdent) = "ISIN " & Datos(16)
               
            ElseIf Datos(17) <> "" Then
               grilla.TextMatrix(i, ncolIdent) = "Cusip " & Datos(17)
               
            ElseIf Datos(18) <> "" Then
               grilla.TextMatrix(i, ncolIdent) = "BB Number " & Datos(18)
               
            Else
               grilla.TextMatrix(i, ncolIdent) = "Sin Ident."
               
            End If
            
            grilla.RowHeight(i) = 350
            i = i + 1
        Loop
        
        grilla.Redraw = True
        
        With Toolbar1
            .Buttons(nbtnGrabar).Enabled = True
            .Buttons(nbtnBuscar).Enabled = False
            .Buttons(nbtnLimpiar).Enabled = True
            .Buttons(nbtnExportar).Enabled = True
            .Buttons(nbtnImprimir).Enabled = True
            .Buttons(nbtnImportar).Enabled = True
        End With
         
        txt_fecha.Enabled = False
        cmdValorizar.Enabled = True
    End If
    
    Screen.MousePointer = vbDefault
    
End Function

Function calulo_mercado(fec1, fec2)
    Dim Datos()
    envia = Array()
    AddParam envia, Format(fec1, "DD/MM/YYYY")
    AddParam envia, Format(fec2, "DD/MM/YYYY")
    If Bac_Sql_Execute("SVA_MER_VLZ_CAR", envia) Then
        Do While Bac_SQL_Fetch(Datos)
            If Datos(1) = "SI" Then
                MsgBox Datos(2), vbInformation, gsBac_Version
                
                
            End If
        Loop
    End If
    If Datos(1) = "SI" Then
        'Call actualizar_sw_tasas_mercado
    '    Call guardar_hora_proceso("tm", Time, cFecpro)
    '    Call Clear_Objetos
'        Call Buscar_Datos(txt_fecha)
        Toolbar1.Buttons(1).Enabled = True
        Toolbar1.Buttons(2).Enabled = False
        Toolbar1.Buttons(3).Enabled = False
        Toolbar1.Buttons(4).Enabled = False
        Toolbar1.Buttons(5).Enabled = False
    End If
End Function

Function Clear_Objetos()
    grilla.Rows = 1
    
    txt_fecha.Text = Format(gsBac_Fecp, "DD/MM/YYYY")
    txt_fecha.Enabled = True
    Toolbar1.Buttons(1).Enabled = False
    Toolbar1.Buttons(2).Enabled = True
    Toolbar1.Buttons(6).Enabled = True
    Toolbar1.Buttons(4).Enabled = False
    Toolbar1.Buttons(5).Enabled = False
    Toolbar1.Buttons(6).Enabled = False
    Me.cmdValorizar.Enabled = False
    txt_fecha.SetFocus
    End Function

Function Cuenta_datos(Fecha)
    Cuenta_datos = False
    If txt_fecha.Text = "  /  /    " Then
        Cuenta_datos = True
        Exit Function
    End If
    Dim Datos()
    envia = Array()
    AddParam envia, Fecha
    If Bac_Sql_Execute("SVC_MER_VER_DAT", envia) Then
        Do While Bac_SQL_Fetch(Datos)
            If Val(Datos(1)) = 0 Then
                Cuenta_datos = False
                Exit Function
            Else
                FILAS = Val(Datos(1))
            End If
        Loop
    End If
    Cuenta_datos = True
End Function

Function dibuja_grilla()

    With grilla
        .Cols = 17 '16
        .RowHeight(0) = 400
        
        .TextMatrix(0, ncolFamilia) = "Familia"
        .TextMatrix(0, ncolInstrum) = "Instrumento"
        .TextMatrix(0, ncolVcto) = "Vcto"
        .TextMatrix(0, ncolDocu) = "N. Docu."
        .TextMatrix(0, ncolNominal) = "Nominal"
        .TextMatrix(0, ncolVP) = "Valor Presente"
        .TextMatrix(0, ncolRut) = "Rut Cartera"
        .TextMatrix(0, ncolTir) = "TIR "
        .TextMatrix(0, ncolVC) = "%VC"
        .TextMatrix(0, ncolTirMerc) = "TIR Merc."
        .TextMatrix(0, ncolVCMerc) = "%VC Merc."
        .TextMatrix(0, ncolVpTm) = "Valor Mercado"
        .TextMatrix(0, ncolOculta1) = ""
        .TextMatrix(0, ncolDifMerc) = "Diferencia Mercado"
        .TextMatrix(0, ncolOculta2) = ""
        .TextMatrix(0, ncolIdent) = "Identificación"
        .TextMatrix(0, nColtes) = "MarcaColtes"
        
        
        .ColWidth(ncolFamilia) = 1000
        .ColWidth(ncolInstrum) = 2050
        .ColWidth(ncolVcto) = 1100
        .ColWidth(ncolDocu) = 1000
        .ColWidth(ncolNominal) = 2050
        .ColWidth(ncolVP) = 2050
        .ColWidth(ncolRut) = 0
        .ColWidth(ncolTir) = 1350
        .ColWidth(ncolVC) = 1350
        .ColWidth(ncolTirMerc) = 1350
        .ColWidth(ncolVCMerc) = 1850 '1350 'MAP 20171218
        .ColWidth(ncolVpTm) = 2050
        .ColWidth(ncolOculta1) = 0
        .ColWidth(ncolDifMerc) = 2050
        .ColWidth(ncolOculta2) = 0
        .ColWidth(ncolIdent) = 2000
        .ColWidth(nColtes) = 0
        
        
        .FixedAlignment(ncolVcto) = flexAlignCenterCenter
        .FixedAlignment(ncolNominal) = flexAlignRightCenter
        .FixedAlignment(ncolVP) = flexAlignRightCenter
        .FixedAlignment(ncolTir) = flexAlignRightCenter
        .FixedAlignment(ncolVC) = flexAlignRightCenter
        .FixedAlignment(ncolTirMerc) = flexAlignRightCenter
        .FixedAlignment(ncolVCMerc) = flexAlignRightCenter
        .FixedAlignment(ncolVpTm) = flexAlignRightCenter
        .FixedAlignment(ncolDifMerc) = flexAlignRightCenter
        
      End With

End Function
Function grabar_datos(Fecha)
    Dim Datos()
    Dim i As Double

    For i = 1 To grilla.Rows - 1
        envia = Array()
        AddParam envia, Fecha
        AddParam envia, CDbl(grilla.TextMatrix(i, 3))
        AddParam envia, CDbl(grilla.TextMatrix(i, 9))
        AddParam envia, CDbl(grilla.TextMatrix(i, 10))
        AddParam envia, CDbl(grilla.TextMatrix(i, 11))
        AddParam envia, CDbl(grilla.TextMatrix(i, 12))
         AddParam envia, CDbl(grilla.TextMatrix(i, 7))
        If Bac_Sql_Execute("SVA_MER_GRB_DAT", envia) Then
            Do While Bac_SQL_Fetch(Datos)
            Loop
        Else
            Exit Function
        End If
    Next

    MsgBox "Datos Grabados Con Exito", vbInformation, gsBac_Version
    Call Clear_Objetos
    Call guardar_hora_proceso("tm", Time, gsBac_Fecp)
    Call actualizar_sw_tasas_mercado
   
End Function
Function grabar_datos_temp(sw1, sw2)
    grilla.TextMatrix(grilla.row, 12) = CDbl(grilla.Col)
End Function

Function Marcar()
If grilla.Col = 9 Or grilla.Col = 10 Then
    
   Dim f, C, R, v As Integer

   Dim lrow As Integer

   FilaSeleccionada = grilla.RowSel
   
   lrow = grilla.TopRow
    r1 = grilla.row
    r2 = grilla.row
    c1 = grilla.Col

    grilla.ForeColorFixed = vbWhite
    
   With grilla
   
      f = .RowSel
      

      .FocusRect = flexFocusHeavy
      .Redraw = False

        For C = 4 To .Cols - 1
               .row = r2
               .Col = C
                .BackColorSel = &HC0C0C0
                .BackColorFixed = &H808000
                .ForeColorFixed = &H80000005
                .CellBackColor = &HC0C0C0
                .CellForeColor = vbBlue
        Next C

    grilla.row = r1
    grilla.Col = c1
    .BackColorSel = &H800000
    .BackColorFixed = &H808000
    .ForeColorFixed = &H80000005
    .CellBackColor = vbBlue    ''vbRed
    .CellForeColor = vbWhite
    .FocusRect = flexFocusLight
    .Redraw = True
   End With
    If lrow > 1 Then
        grilla.TopRow = lrow
    End If
Else
    Exit Function
End If
End Function

Sub sub_ImptasaMercado()
  Dim Nombre_Rpt      As String: Nombre_Rpt = ""
Dim TipRep          As String
Dim Fecha           As String
Dim AuxTit          As String
Dim CDolar          As String
Dim Datos()

On Error GoTo Control:

    SQL = "SVC_MER_BUS_CAR"
    SQL = SQL & "'" & Format(txt_fecha.Text, "yyyymmdd") & "'"
    
    If Not Bac_Sql_Execute(SQL) Then
        MsgBox "SQL no responde ", 16
        Exit Sub
    End If
    
    Fecha = Format(txt_fecha.Text, feFECHA)

    Screen.MousePointer = vbHourglass
  
    TipRpt = "VALORIZACION DE MERCADO "

    BAC_INVERSIONES.BacRpt.ReportFileName = RptList_Path & "Valormercado.RPT"
    BAC_INVERSIONES.BacRpt.WindowTitle = "Tasas de Mercado"
    Call PROC_ESTABLECE_UBICACION(BAC_INVERSIONES.BacRpt.RetrieveDataFiles, BAC_INVERSIONES.BacRpt)
    BAC_INVERSIONES.BacRpt.StoredProcParam(0) = Fecha
    BAC_INVERSIONES.BacRpt.Connect = CONECCION
    BAC_INVERSIONES.BacRpt.Action = 1

Screen.MousePointer = 0
Exit Sub
Resume
Control:
    MsgBox "Problemas al generar Listado de Cartera. " & err.Description & ", " & err.Number, vbCritical, "BACTRADER"
    Screen.MousePointer = 0
End Sub

Function PROC_ESTABLECE_UBICACION(Cantidad_Bases As Integer, ObjetoCristal As Object)
On Error GoTo Error_OnError
Dim Posicion_1 As Integer
Dim i
Dim Nueva_DataFile As String

If Cantidad_Bases = 0 Then Exit Function
With ObjetoCristal
    For i = 0 To Cantidad_Bases - 1
            Posicion_1 = InStr(.DataFiles(i), ".")
            Nueva_DataFile = gsSQL_Database & Mid(.DataFiles(i), Posicion_1, ((Len(.DataFiles(i)) - Posicion_1) + 1))
            .DataFiles(i) = Nueva_DataFile
    Next
End With

    Exit Function
Error_OnError:
    MsgBox "Error número: " & err.Number & ", Descripción: " & err.Description, vbCritical
    Screen.MousePointer = 0
End Function
Function Valirozar(Tipo_cal)
    Dim Datos()
    envia = Array()
    AddParam envia, Format(txt_fecha.Text, "YYYYMMDD")
    AddParam envia, CDbl(grilla.TextMatrix(grilla.row, 3))
    AddParam envia, CDbl(grilla.TextMatrix(grilla.row, 9))
    AddParam envia, CDbl(grilla.TextMatrix(grilla.row, 10))
    AddParam envia, Tipo_cal
    If Bac_Sql_Execute("SVA_MER_VLZ_INS", envia) Then
        Do While Bac_SQL_Fetch(Datos)
            grilla.TextMatrix(grilla.row, 9) = Format(CDbl(Datos(3)), "###,##0.0000")
            grilla.TextMatrix(grilla.row, 10) = Format(CDbl(Datos(4)), "###,##0.0000")
            grilla.TextMatrix(grilla.row, 11) = Format(CDbl(Datos(2)), "###,###,###,##0.0000")
            grilla.TextMatrix(grilla.row, 13) = Format(CDbl(Datos(2)) - CDbl(grilla.TextMatrix(grilla.row, 5)), "###,###,###,##0.0000")
        Loop
    End If
End Function

Function ValirozarTodos()
    Dim Datos()
    
    Dim cMensaje  As String
    Dim cContador As Integer
    Dim existeCurva As Integer
    
    cMensaje = ""
    existeCurva = 0
    
    For cContador = 1 To grilla.Rows - 1
        '+++COLTES, jcamposd si es un bono coltes debe validar existencia de curva
        If grilla.TextMatrix(cContador, nColtes) = 1 Then
            envia = Array()
            AddParam envia, Format(txt_fecha.Text, "YYYYMMDD")
            AddParam envia, "Curva_Coltes"
            If Bac_Sql_Execute("SP_EXITE_CURVA_FECHA_PROCESO", envia) Then
                Do While Bac_SQL_Fetch(Datos)
                    existeCurva = Val(Datos(1))
                Loop
            End If
            If existeCurva = 0 Then
                cMensaje = "- N° Documento: " & grilla.TextMatrix(cContador, 3) & ", No existe curva CURVA_COLTES ingresada." & vbCrLf
                MsgBox "Falta Información. " & vbCrLf & vbCrLf & cMensaje, vbExclamation, TITSISTEMA
                Exit Function
            End If
            
        End If
        '---COLTES, jcamposd si es un bono coltes debe validar existencia de curva
        If CDbl(grilla.TextMatrix(cContador, 9)) = 0# Then
            '+++COLTES, jcamposd si es coltes llevara tir en cero
            If grilla.TextMatrix(cContador, nColtes) <> 1 Then
                cMensaje = "- N° Documento: " & grilla.TextMatrix(cContador, 3) & " Con Tasa en Cero." & vbCrLf
            End If
        End If
        '+++COLTES, jcamposd si es coltes el precio no puede ser cero
        If CDbl(grilla.TextMatrix(cContador, 10)) = 0# And grilla.TextMatrix(cContador, nColtes) = 1 Then
            cMensaje = "- N° Documento: " & grilla.TextMatrix(cContador, 3) & " Curva no cálculo precio." & vbCrLf
        End If
        '+++COLTES, jcamposd si es coltes el precio no puede ser cero
    Next cContador
   If cMensaje <> "" Then
      MsgBox "Falta Información. " & vbCrLf & vbCrLf & cMensaje, vbExclamation, TITSISTEMA
      Exit Function
   End If
    
    Me.MousePointer = vbHourglass
        
        For i = 1 To grilla.Rows - 1
            If Trim(grilla.TextMatrix(i, 14)) <> "" Then
                
                envia = Array()
                AddParam envia, Format(txt_fecha.Text, "YYYYMMDD")
                AddParam envia, CDbl(grilla.TextMatrix(i, 3))
                AddParam envia, CDbl(grilla.TextMatrix(i, 9))
                AddParam envia, CDbl(grilla.TextMatrix(i, 10))
                AddParam envia, CDbl(grilla.TextMatrix(i, 14))
                    
                If Bac_Sql_Execute("SVA_MER_VLZ_INS", envia) Then
                    Do While Bac_SQL_Fetch(Datos)
                        grilla.TextMatrix(i, 9) = Format(CDbl(Datos(3)), "###,###,###,##0.0000")
                        
                        If IsNull(Datos(4)) Then
                            grilla.TextMatrix(i, 10) = "0.000000000000"
                        Else
                            grilla.TextMatrix(i, 10) = Format(CDbl(Datos(4)), "###,###,###,##0.0000")
                        End If
                         
                        If IsNull(Datos(2)) Then
                            grilla.TextMatrix(i, 11) = "0.0000"
                            Datos(2) = 0
                        Else
                            grilla.TextMatrix(i, 11) = Format(CDbl(Datos(2)), "###,###,###,##0.0000")
                        End If
                       
                        grilla.TextMatrix(i, 13) = Format(CDbl(Datos(2)) - CDbl(grilla.TextMatrix(i, 5)), "###,###,###,##0.0000")
                    Loop
                End If
                
                   
                If Format(txt_fecha.Text, "YYYYMMDD") = Format(gsBac_Fecp, "yyyymmdd") Then
                
                     AddParam envia, "LT"
                     
                     If Not Bac_Sql_Execute("SVA_MER_VLZ_INS", envia) Then
                         Screen.MousePointer = vbDefault
                         MsgBox "Ha ocurrido un error al intentar valorizar la cartera libre de trading.", vbCritical
                         Exit Function
                     End If
                     
                     envia = Array()
                     AddParam envia, Format(gsBac_Feca, "YYYYMMDD")
                     AddParam envia, CDbl(grilla.TextMatrix(i, 3))
                     AddParam envia, CDbl(grilla.TextMatrix(i, 9))
                     AddParam envia, CDbl(grilla.TextMatrix(i, 10))
                     AddParam envia, CDbl(grilla.TextMatrix(i, 14))
                     AddParam envia, "BT"
                     
                     If Not Bac_Sql_Execute("SVA_MER_VLZ_INS", envia) Then
                         Screen.MousePointer = vbDefault
                         MsgBox "Ha ocurrido un error al intentar valorizar la cartera libre de trading.", vbCritical
                         Exit Function
                     End If
                End If
                                    
            '    Call Marcar
            End If
        Next
    
    Me.MousePointer = vbDefault
    
    MsgBox "Valorización a Mercado a Finalizado", vbInformation, gsBac_Version
    
End Function


Private Sub Command1_Click()

End Sub

Private Sub cmdValorizar_Click()

   If Chequea_ControlProcesos("TM") = True Then
      Call ValirozarTodos
   End If

End Sub

Private Sub Form_Load()
    dibuja_grilla
    txt_fecha.Text = Format(gsBac_Fecp, "DD/MM/YYYY")
    cmdValorizar.Enabled = False
    Move 0, 0
End Sub

Private Sub grilla_Click()
    
   ' Call Marcar
End Sub

Private Sub grilla_KeyPress(KeyAscii As Integer)

     If KeyAscii > 47 Or KeyAscii = 13 Or KeyAscii = 45 Then
        txt_numero.Top = grilla.CellTop + grilla.Top
        txt_numero.Left = grilla.CellLeft + grilla.Left
        txt_numero.Height = grilla.CellHeight + 20
        txt_numero.Width = grilla.CellWidth
        
        If grilla.Col = 9 And KeyAscii > 44 And KeyAscii < 58 Then
         '     conte = grilla.TextMatrix(grilla.Row, 9)
            txt_numero.Visible = True
            If KeyAscii <> 13 Then
                    txt_numero.Text = Val(UCase(Chr(KeyAscii)))
                    txt_numero.SelStart = 1
            End If
            txt_numero.SetFocus
        End If
        If grilla.Col = 10 And KeyAscii > 46 And KeyAscii < 58 Then
            '+++COLTES, jcamposd 20171219, para los bonos coltes no puede modificar el precio
            If grilla.TextMatrix(grilla.row, nColtes) = 1 Then
                Exit Sub
            Else
            '---COLTES, jcamposd 20171219, para los bonos coltes no puede modificar el precio
                txt_numero.Text = 0
                conte = grilla.TextMatrix(grilla.row, 10)
                txt_numero.Visible = True
                If KeyAscii <> 13 Then
                    txt_numero.Text = Val(UCase(Chr(KeyAscii)))
                      txt_numero.SelStart = 1
                End If
            End If
            txt_numero.SetFocus
        End If
    End If

End Sub


Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)


    Screen.MousePointer = vbHourglass

    Select Case Button.Index
        
        Case nbtnGrabar
            If Chequea_ControlProcesos("TM") = True Then
               Call grabar_datos(txt_fecha.Text)
            End If
        Case nbtnBuscar
            If Me.txt_fecha.Text = "  /  /    " Then
                MsgBox "No ha Ingresado Fecha De Proceso", vbExclamation, gsBac_Version
                txt_fecha.SetFocus
                Exit Sub
            Else
                If IsDate(txt_fecha.Text) Then
                    If Cuenta_datos(txt_fecha.Text) Then
                        Call buscar_datos(txt_fecha.Text)
                    Else
                        MsgBox "No Se Registran Datos En Cartera Para La Fecha " & txt_fecha.Text, vbExclamation, gsBac_Version
                        Call Clear_Objetos
                    End If
                Else
                    txt_fecha.Text = "  /  /    "
                    txt_fecha.SetFocus
                End If
            End If
            
    '         Call txt_fecha_LostFocus
        Case nbtnLimpiar
             Call Clear_Objetos
        
        Case nbtnExportar
             Call Exp_excel(Me, "Valorizacion", grilla)

        Case nbtnImprimir
             Call sub_ImptasaMercado

        Case nbtnImportar
            If Chequea_ControlProcesos("TM") = True Then
               Call sub_ImportTasaMercado
            End If
        Case nbtnSalir
            Unload Me
            
    End Select
    
    Screen.MousePointer = vbDefault
    
End Sub

Sub sub_ImportTasaMercado()
 Dim sNombre$
 Dim xlApp      As EXCEL.Application
 Dim xlBook     As EXCEL.Workbook
 Dim xlSheet    As EXCEL.Worksheet
 Dim SWtext As Integer
 Dim i As Long
 
 Dim iRow   As Integer
 Dim xRow   As Integer
 
 Dim sIden  As String
 Dim sFami  As String
 Dim sIntr  As String
 Dim sVcto  As String
 Dim sNdoc  As String
 Dim sNomi  As String
 Dim sVpre  As String
 Dim sTir   As String
 Dim sPovc  As String
 Dim sTmer  As String
 Dim sMerc  As String
 Dim sVmer  As String
 Dim sDifm  As String
 Dim sRetorno As String
 
      
   Dig_Tasa.FileName = ""
   Dig_Tasa.DialogTitle = "Archivo Tasa de Mercado"
   Dig_Tasa.Filter = "Excel (*.xls)|*.xls"
   Dig_Tasa.ShowOpen
   sNombre$ = Dig_Tasa.FileName
       
   If Dig_Tasa.FileName = "" Then Exit Sub
   
 
   Me.MousePointer = vbHourglass
   On Error GoTo Importar_Excel

   If Not Dir(sNombre$) <> "" Then
      MsgBox "Archivo Excel No existe, debe generarlo  ", vbCritical '
      MousePointer = 0
      Exit Sub
   End If
   
   Set xlApp = CreateObject("Excel.Application")
   Set xlBook = xlApp.Workbooks.Open(sNombre$)
   Set xlSheet = xlBook.Worksheets(1)
   

  
        For xRow = 1 To xlSheet.Columns.End(xlDown).row
            sIden = Func_Leer_Celda(xlSheet, "A" & LTrim(Str(1 + xRow)))
            sFami = Func_Leer_Celda(xlSheet, "B" & LTrim(Str(1 + xRow)))
            sIntr = Func_Leer_Celda(xlSheet, "C" & LTrim(Str(1 + xRow)))
            sVcto = Func_Leer_Celda(xlSheet, "D" & LTrim(Str(1 + xRow)))
            sNdoc = Func_Leer_Celda(xlSheet, "E" & LTrim(Str(1 + xRow)))
            sNomi = Func_Leer_Celda(xlSheet, "F" & LTrim(Str(1 + xRow)))
            sVpre = Func_Leer_Celda(xlSheet, "G" & LTrim(Str(1 + xRow)))
            sTir = Func_Leer_Celda(xlSheet, "H" & LTrim(Str(1 + xRow)))
            sPovc = Func_Leer_Celda(xlSheet, "I" & LTrim(Str(1 + xRow)))
            sTmer = Func_Leer_Celda(xlSheet, "J" & LTrim(Str(1 + xRow)))
            sMerc = Func_Leer_Celda(xlSheet, "K" & LTrim(Str(1 + xRow)))
            sVmer = Func_Leer_Celda(xlSheet, "L" & LTrim(Str(1 + xRow)))
            sDifm = Func_Leer_Celda(xlSheet, "M" & LTrim(Str(1 + xRow)))
            sRetorno = Func_Leer_Celda(xlSheet, "J" & LTrim(Str(1 + xRow)))
                   
            'Compara los valores de tasas retornados y remplaza por los existentes,
            'para luego almacenarlos en la tabla.
            With grilla
             For iRow = 1 To .Rows - 1
                If .TextMatrix(iRow, 15) = sIden And .TextMatrix(iRow, 0) = sFami And sNdoc = .TextMatrix(iRow, 3) Then
                   .TextMatrix(iRow, 9) = Format(Func_Leer_Celda(xlSheet, "J" & LTrim(Str(1 + xRow))), "#,##0.0000")
                   Exit For
                End If
             Next iRow
           End With
        Next xRow
   
   xlBook.Close
   xlApp.Visible = False
   xlApp.Quit

   Set xlApp = Nothing
   Set xlBook = Nothing
   Set xlSheet = Nothing

   Me.MousePointer = vbDefault
   MsgBox "Proceso terminado", vbInformation, Me.Caption

  Exit Sub
Resume
Importar_Excel:
   MsgBox "(" & err.Number & ") " & err.Description, vbExclamation, Me.Caption
   Me.MousePointer = 0
   Exit Sub
End Sub


Private Sub txt_fecha_KeyPress(KeyAscii As Integer)
    If keyscii = 13 Then
        SendKeys "{TAB}"
    End If
End Sub

Private Sub txt_Numero_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
        grilla.SetFocus
        If grilla.Col = 10 Then
            txt_numero.Visible = False
            grilla.TextMatrix(grilla.row, 10) = txt_numero.Text
            grilla.TextMatrix(grilla.row, 10) = Format(grilla.TextMatrix(grilla.row, 10), "###,##0.000000000000") 'MAP 20171218
            Sw_Tir = 0
            Sw_Pvp = 1
            Call grabar_datos_temp(Sw_Tir, Sw_Pvp)
            Screen.MousePointer = 11
            'Call Valirozar(1)
             grilla.TextMatrix(grilla.row, 14) = 1
            Screen.MousePointer = 0
            Toolbar1.Buttons(1).Enabled = True
            Toolbar1.Buttons(3).Enabled = True
            
            'Marcar
        End If
        If grilla.Col = 9 Then
            txt_numero.Visible = False
            '+++COLTES, jcamposd 20171219 si es bono colombiano no debe ingresar tir de mercado esta se extrae desde curva
            If grilla.TextMatrix(grilla.row, nColtes) = 1 Then
                Exit Sub
            End If
            '---COLTES, jcamposd 20171219 si es bono colombiano no debe ingresar tir de mercado esta se extrae desde curva
            
            grilla.TextMatrix(grilla.row, 9) = txt_numero.Text
            grilla.TextMatrix(grilla.row, 9) = Format(grilla.TextMatrix(grilla.row, 9), "###,##0.0000")
            Sw_Tir = 1
            Sw_Pvp = 0
            Call grabar_datos_temp(Sw_Tir, Sw_Pvp)
            Screen.MousePointer = 11
            'Call Valirozar(2)
             grilla.TextMatrix(grilla.row, 14) = 2
            Screen.MousePointer = 0
            Toolbar1.Buttons(1).Enabled = True
            Toolbar1.Buttons(3).Enabled = True
            
            'Marcar
        End If
    End If
    If KeyAscii = 13 Then
            If grilla.Col = 10 Then
                txt_numero.Visible = False
                txt_numero.Text = 0
                conte = 0
            End If
            If grilla.Col = 9 Then
                txt_numero.Visible = False
                txt_numero.Text = 0
                conte = 0
            End If
    End If
    If KeyAscii = 27 Then
            If grilla.Col = 10 Then
                txt_numero.Visible = False
                grilla.TextMatrix(grilla.row, 10) = conte
                txt_numero.Text = 0
                conte = 0
            End If
            If grilla.Col = 9 Then
                txt_numero.Visible = False
                grilla.TextMatrix(grilla.row, 9) = conte
                txt_numero.Text = 0
                conte = 0
            End If
    End If

End Sub

Private Sub txt_Numero_LostFocus()
    txt_numero.Text = 0
    txt_numero.Visible = False
    Dim i
    i = i + 1
    For i = 1 To grilla.Rows - 1
        grilla.TextMatrix(i, 9) = Format(grilla.TextMatrix(i, 9), "###,##0.0000")
        grilla.TextMatrix(i, 10) = Format(grilla.TextMatrix(i, 10), "###,##0.000000000000") 'MAP 20171218
    Next
End Sub


