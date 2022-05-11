VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form Pago_captaciones 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Captaciones pendientes de pago"
   ClientHeight    =   4860
   ClientLeft      =   330
   ClientTop       =   1485
   ClientWidth     =   8700
   Icon            =   "Captaven.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4860
   ScaleWidth      =   8700
   Begin MSFlexGridLib.MSFlexGrid Grilla 
      Height          =   3015
      Left            =   120
      TabIndex        =   7
      Top             =   1320
      Width           =   8295
      _ExtentX        =   14631
      _ExtentY        =   5318
      _Version        =   393216
      Rows            =   13
      Cols            =   15
      FixedCols       =   0
      BackColor       =   12632256
      ForeColor       =   8388608
      BackColorFixed  =   8421376
      ForeColorFixed  =   16777215
      BackColorSel    =   8388608
      ForeColorSel    =   16744576
      GridColor       =   255
      GridColorFixed  =   8421504
      FocusRect       =   0
      GridLines       =   2
      SelectionMode   =   1
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin VB.TextBox Txt_rut 
      Height          =   300
      Left            =   90
      MaxLength       =   9
      TabIndex        =   4
      Top             =   900
      Width           =   1185
   End
   Begin VB.TextBox Txt_Codigo_rut 
      Height          =   300
      Left            =   1290
      MaxLength       =   9
      TabIndex        =   5
      Top             =   900
      Width           =   615
   End
   Begin Threed.SSCommand Cmd_Marcar 
      Height          =   345
      Left            =   240
      TabIndex        =   8
      Top             =   4440
      Width           =   1950
      _Version        =   65536
      _ExtentX        =   3440
      _ExtentY        =   609
      _StockProps     =   78
      Caption         =   "&Marcar/Desmarcar"
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
   Begin Threed.SSCommand SSC_Pago 
      Height          =   450
      Left            =   1185
      TabIndex        =   1
      Top             =   0
      Width           =   1200
      _Version        =   65536
      _ExtentX        =   2117
      _ExtentY        =   794
      _StockProps     =   78
      Caption         =   "&Pago"
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
   Begin Threed.SSCommand SSC_Limpiar 
      Height          =   450
      Left            =   2390
      TabIndex        =   2
      Top             =   0
      Width           =   1215
      _Version        =   65536
      _ExtentX        =   2134
      _ExtentY        =   794
      _StockProps     =   78
      Caption         =   "&Limpiar"
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
   Begin Threed.SSCommand SSC_Buscar 
      Height          =   450
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   1200
      _Version        =   65536
      _ExtentX        =   2117
      _ExtentY        =   794
      _StockProps     =   78
      Caption         =   "&Buscar"
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
   Begin Threed.SSCommand cmdSalir 
      Height          =   450
      Left            =   3600
      TabIndex        =   3
      Top             =   0
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
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      Caption         =   "R.U.T."
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
      Index           =   0
      Left            =   135
      TabIndex        =   10
      Top             =   660
      Width           =   585
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      Caption         =   "Código"
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
      Index           =   1
      Left            =   1290
      TabIndex        =   9
      Top             =   660
      Width           =   600
   End
   Begin VB.Label Lbl_Nombre 
      BorderStyle     =   1  'Fixed Single
      Height          =   300
      Left            =   2040
      TabIndex        =   6
      Top             =   885
      Width           =   6345
   End
End
Attribute VB_Name = "Pago_captaciones"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit

Function funcValidCliente() As Boolean
Dim nCant As Integer
Dim varssql As String
Dim varvData()

On Error GoTo ErrCliente

    funcValidCliente = False
    
    nCant = 0
    
    varssql = ""
    varssql = "EXECUTE sp_clleerrut1 "
    varssql = varssql & Txt_rut.Text & ", "
    varssql = varssql & CDbl(Txt_Codigo_rut.Text)
    
    If miSQL.SQL_Execute(varssql) = 0 Then
    
        Do While miSQL.SQL_Fetch(varvData()) = 0
            If IsNull(varvData(1)) = True Or CDbl(varvData(1)) = 0 Then
                Exit Function
            End If
            
            Lbl_Nombre.Caption = varvData(4)
            nCant = 1

        Loop
        
    End If
    
    If nCant = 0 Then
        MsgBox "cliente ingresado no existe, verifique información ingresada.", vbInformation, "BAC Trader"
        Exit Function
    End If
    
    funcValidCliente = True
    Exit Function
    
ErrCliente:
    MsgBox "Problemas en validación de datos del cliente: " & Err.Description & ". Comunique al Administrador.", vbCritical, "BAC-Trader"
    Exit Function
End Function
    
Function Carga_grilla(nRutcli As Double, nCodcli As Double) As Boolean

Dim cSql As String
Dim datos()
Dim bIngreso  As Boolean

On Error GoTo ErrCarga

     Carga_grilla = False

With Grilla

     bIngreso = False
     .Rows = 2
     Call F_BacLimpiaGrilla(Grilla)
    
    cSql = " EXECUTE sp_buscacaptavencidas " & CStr(nRutcli) & "," & CStr(nCodcli)
    
    If miSQL.SQL_Execute(cSql) = 0 Then
        
      Do While miSQL.SQL_Fetch(datos()) = 0
            
       If datos(1) = "NO" Then Exit Function

        .Row = .Rows - 1
             
                .Col = 0:          .Text = Val(datos(1))
                .Col = 1:          .Text = datos(2)
                .Col = 2:
                '.Text = CDbl(Datos(3))
                .TextMatrix(.Row, .Col) = Format(Val(datos(3)), "###,###,###0.###0")
                .Col = 3:
                '.Text = CDbl(Datos(4))
                 .TextMatrix(.Row, .Col) = Format(Val(datos(4)), "###,###,###0.###0")
                .Col = 4:          .Text = datos(5)
                .Col = 5:          .Text = Format(datos(6), "dd/mm/yyyy")
                .Col = 6:
                '.Text = CDbl(Datos(7))
                .TextMatrix(.Row, .Col) = Format(Val(datos(7)), "###,###,###0.###0")
                .Col = 7:
                '.Text = CDbl(Datos(8))
                 .TextMatrix(.Row, .Col) = Format(Val(datos(8)), "###,###,###0.###0")
                .Col = 8:
                '.Text = CDbl(Datos(9))
                 .TextMatrix(.Row, .Col) = Format(Val(datos(9)), "###,###,###0.###0")
                .Col = 9:
                '.Text = CDbl(Datos(10))
                 .TextMatrix(.Row, .Col) = Format(Val(datos(10)), "###,###,###0.###0")
                .Col = 10:         .Text = datos(11)
                .Col = 13:         .Text = Val(datos(12)) 'Correlativo
         
        .Rows = .Rows + 1
            
        bIngreso = True
     Loop
        
        Call BacAgrandaGrilla(Grilla, 40)
        
        .SelectionMode = 1
        .FocusRect = 0
        
        If bIngreso = True Then
            .Enabled = True
            SSC_Pago.Enabled = True
        Else
            .Enabled = False
            MsgBox "No se encontro información  de captaciones pendientes", vbExclamation, gsBac_Version
        End If
        
    End If
    
    SSC_Buscar.Enabled = False
    Carga_grilla = True
    
End With
    Exit Function

ErrCarga:
    MsgBox "Problemas en carga de información: " & Err.Description & ". Comunique al Administrador.", vbCritical, gsBac_Version
    Exit Function
End Function

Sub subPagoCaptaciones()

Dim nCant   As Integer
Dim cSql    As String
Dim nPos    As Integer
Dim ncorrela As Double
Dim nNumoper As Double
Dim datos()

On Error GoTo ErrPagoCapta

With Grilla

For nCant = 1 To .Rows - 1
         
         .Row = nCant
         .Col = 11
        
      ' Son las operaciones que se han marcado para realizar el pago de la misma
        
        If .Text = "PAGO" Then
            
            cSql = ""
            
            .Col = 0
            nNumoper = Val(.Text)
            .Col = 13
            ncorrela = Val(.Text)

            cSql = "EXECUTE sp_pagocaptacion " & nNumoper & "," & ncorrela
            
            If miSQL.SQL_Execute(cSql) = 0 Then
                Do While miSQL.SQL_Fetch(datos()) = 0
                    If datos(1) = "NO" Then
                        MsgBox datos(2), vbCritical, gsBac_Version
                        Exit Sub
                    Else
                        .Col = 11
                        .Text = "PAGOX"
                    End If
                Loop
            End If
     
        End If
        
    Next nCant


    nCant = 1
    
    Do While nCant <= .Rows - 1
        
        .Row = nCant
        
        If .Rows > 2 Then
            .Col = 11
            
            If .Text = "PAGOX" Then
                If .Rows = 2 Then
                 For nPos = 0 To 11
                     .Col = nPos
                     .Text = ""
                 Next nPos
                Else
                
                .RemoveItem nCant
                End If
                nCant = 0
            End If
            
        End If
        nCant = nCant + 1
    Loop
    
    .Rows = .Rows - 1
    
    Exit Sub
End With
    
ErrPagoCapta:
    MsgBox "Proceso de pago de captaciones no se pudo procesar: " & Err.Description & ". Comunique al Administrador.", vbCritical, gsBac_Version
    Exit Sub



''    For nCant = 1 To Grid1.Rows - 1
''        Grid1.Row = nCant
''        Grid1.Col = 12
''
''      ' Son las operaciones que se han marcado para realizar el pago de la misma
''        If Grid1.Text = "PAGO" Then
''
''            cSql = ""
''
''            Grid1.Col = 1
''            nnumoper = Val(Grid1.Text)
''            Grid1.Col = 14
''            ncorrela = Val(Grid1.Text)
''
''            cSql = "EXECUTE sp_pagocaptacion " & nnumoper & "," & ncorrela
''
''            If misql.SQL_Execute(cSql) = 0 Then
''                Do While misql.SQL_Fetch(Datos()) = 0
''                    If Datos(1) = "NO" Then
''                        MsgBox Datos(2), vbCritical, gsBac_Version
''                        Exit Sub
''                    Else
''                        Grid1.Col = 12
''                        Grid1.Text = "PAGOX"
''                    End If
''                Loop
''            End If
''
''        End If
''
''    Next nCant
''
''
''    nCant = 1
''    Do While nCant <= Grid1.Rows - 1
''
''        Grid1.Row = nCant
''
''        If Grid1.Rows > 2 Then
''            Grid1.Col = 12
''
''            If Grid1.Text = "PAGOX" Then
''                If Grid1.Rows = 2 Then
''                 For nPos = 1 To 12
''                    Grid1.Col = nPos
''                    Grid1.Text = ""
''                 Next nPos
''                Else
''
''                Grid1.RemoveItem nCant
''                End If
''                nCant = 0
''            End If
''
''        End If
''        nCant = nCant + 1
''    Loop
''
''    Table1.Rows = Grid1.Rows - 1
''    Table1.Refresh
''
''    Exit Sub
''
''ErrPagoCapta:
''    MsgBox "Proceso de pago de captaciones no se pudo procesar: " & Err.Description & ". Comunique al Administrador.", vbCritical, gsBac_Version
''    Exit Sub
End Sub

Private Sub Cmd_Marcar_Click()

Dim c%

With Grilla

        If .Enabled = True And .TextMatrix(.Row, 0) <> "" Then
             If .TextMatrix(.Row, 11) = "PAGO" Then
                .TextMatrix(.Row, 11) = ""
                 For c = 0 To .Cols - 1
                    .Col = c
                    .CellBackColor = &HC0C0C0
                    .CellForeColor = &H800000
                Next c
             Else
              .TextMatrix(.Row, 11) = "PAGO"
                For c = 0 To .Cols - 1
                    .Col = c
                    .CellBackColor = &HC0C0C0   'Gris
                    .CellForeColor = &HFFC0FF     'Negro
                Next c
          End If
       End If

End With

End Sub

Private Sub cmdSalir_Click()
  Unload Me
End Sub

Private Sub Form_Activate()

    Call CargarParam(Grilla)

End Sub

Private Sub Form_Load()

   '' Table1.ColumnCellAttrs(1) = True
   '' Table1.ColumnCellAttrs(2) = True
   '' Table1.ColumnCellAttrs(3) = True
   '' Table1.ColumnCellAttrs(4) = True
   '' Table1.ColumnCellAttrs(5) = True
  ''  Table1.ColumnCellAttrs(6) = True
  ''  Table1.ColumnCellAttrs(7) = True
  ''  Table1.ColumnCellAttrs(8) = True
  ''  Table1.ColumnCellAttrs(9) = True
  ''  Table1.ColumnCellAttrs(10) = True
  ''  Table1.ColumnCellAttrs(11) = True
    
  ''  Table1.Enabled = False
  
  Grilla.Enabled = False
  
End Sub

Private Sub Text1_Change()

End Sub


Private Sub grilla_Click()

'With Grilla
'
'  If .Enabled = True Then
'     For i = 0 To .Cols - 1
'         .Col = i
'         .CellBackColor = &HC0C0C0   'Gris
'         .CellForeColor = &H80000008  'Negro
'     Next i
'  End If
'
'End With

'If .Row <> 0 Then
'    For i = .Col To .Col
'        If .CellBackColor = &H800000 Then Exit For
'        .CellBackColor = &H800000    'Azul
'        .CellForeColor = &HFFFFFF   'Blanco
'        If .Col < .Cols - 1 Then
'            .Col = .Col + 1
'        Else
'            .Col = 0
'        End If
'        Exit For
'    Next i










End Sub

Private Sub SSC_Buscar_Click()

Dim nRut As Double
Dim nCod As Double
    
    
    If Trim(Txt_rut.Text) <> "" And Trim(Txt_Codigo_rut.Text) <> "" Then
        
        If Not funcValidCliente() Then
            Exit Sub
          End If
     Else
        Grilla.Enabled = False
        Exit Sub
    End If
    

    nRut = Val(Txt_rut.Text)
    nCod = Val(Txt_Codigo_rut.Text)
    
     If Not Carga_grilla(nRut, nCod) Then
         Call BacAgrandaGrilla(Grilla, 40)
        MsgBox "No se registraron operaciones en periodo de vencimiento ", vbInformation, gsBac_Version
        Exit Sub
    End If
    
End Sub

Private Sub SSC_Limpiar_Click()

    Txt_rut.Text = ""
    Txt_Codigo_rut.Text = ""
    Lbl_Nombre.Caption = ""
    
 With Grilla
  
     .Rows = 2
    Call F_BacLimpiaGrilla(Grilla)
    Call BacAgrandaGrilla(Grilla, 40)
    
     .SelectionMode = 1
     .FocusRect = 0
     .Enabled = False
     Call Color
       
    SSC_Buscar.Enabled = True
    SSC_Pago.Enabled = False
    Txt_rut.SetFocus
    
 End With

End Sub

Sub Clean_Table()

End Sub

Private Sub SSC_Pago_Click()
Dim varnRespuesta As Integer

    varnRespuesta = MsgBox("¿ Esta seguro de realizar el pago de las captaciones marcadas ?", vbYesNo + vbDefaultButton2, gsBac_Version)
    If varnRespuesta = vbYes Then
        subPagoCaptaciones
    End If
    
End Sub

Private Sub Table1_DblClick()
''
''    Grid1.Row = Table1.RowIndex
''    Grid1.Col = 12
''
''    If Grid1.Text = "PAGO" Then
''        Grid1.Text = ""
''    Else
''        Grid1.Text = "PAGO"
''    End If
''
''    Table1.Rows = Grid1.Rows - 1
''    Table1.Refresh
''

End Sub

Private Sub Txt_Codigo_Rut_KeyPress(KeyAscii As Integer)
    
    If Not IsNumeric(Chr(KeyAscii)) And (KeyAscii <> 8 And KeyAscii <> 9) Then
        KeyAscii = 0
    End If
    
    If KeyAscii = 13 Then
        SendKeys "{TAB}"
    End If
    
End Sub

Private Sub Txt_Rut_Change()

    Lbl_Nombre.Caption = ""
    
End Sub


Private Sub Txt_Rut_DblClick()

    BacAyuda.Tag = "MDCL"
    BacAyuda.Show 1
    BacControlWindows 12
    
    If giAceptar% = True Then
        Txt_rut.Text = gsrut$
        Txt_Codigo_rut.Text = gscodigo$
        Lbl_Nombre.Caption = gsDescripcion$
    End If

    

End Sub


Private Sub Txt_Rut_KeyPress(KeyAscii As Integer)

    If Not IsNumeric(Chr(KeyAscii)) And (KeyAscii <> 8 And KeyAscii <> 13 And KeyAscii <> 9) Then
        KeyAscii = 0
    End If
    
    If KeyAscii = 13 Then Txt_Codigo_rut.SetFocus
    
       
    
End Sub


Public Function CargarParam(Grillas As Object)

With Grillas

        .RowHeight(0) = 350
        .CellFontWidth = 4
         .Row = 0
         
         .Col = 0: .FixedAlignment(0) = 4
         .CellFontBold = True
         .TextMatrix(.Row, 0) = "   N° Captación   "
         .ColWidth(0) = TextWidth(.TextMatrix(.Row, 0)) + 100
         .ColAlignment(0) = 4   'CENTRO
        
         .Col = 1: .FixedAlignment(1) = 4
         .CellFontBold = True
         .TextMatrix(.Row, 1) = "              Cliente               "
         .ColWidth(1) = TextWidth(.TextMatrix(.Row, 1)) + 300
         .ColAlignment(1) = 2     ' IZQUIERDA abajo
    
         .Col = 2: .FixedAlignment(2) = 4
         .CellFontBold = True
         .TextMatrix(.Row, 2) = " Monto Captación U.M. "
         .ColWidth(2) = TextWidth(.TextMatrix(.Row, 2)) + 300
         .ColAlignment(2) = 8     ' derecha abajo
    
         .Col = 3: .FixedAlignment(3) = 4
         .CellFontBold = True
         .TextMatrix(.Row, 3) = "     Tasa      "
         .ColWidth(3) = TextWidth(.TextMatrix(.Row, 3)) + 300
         .ColAlignment(3) = 8     ' derecha abajo
    
         .Col = 4: .FixedAlignment(4) = 4
         .CellFontBold = True
         .TextMatrix(.Row, 4) = "  U.M.  "
         .ColWidth(4) = TextWidth(.TextMatrix(.Row, 4)) + 300
         .ColAlignment(4) = 4     ' CENTRO
    
         .Col = 5: .FixedAlignment(5) = 4
         .CellFontBold = True
         .TextMatrix(.Row, 5) = "  Fecha Vencimiento "
         .ColWidth(5) = TextWidth(.TextMatrix(.Row, 5)) + 300
         .ColAlignment(5) = 4     ' CENTRO
    
         .Col = 6: .FixedAlignment(6) = 4
         .CellFontBold = True
         .TextMatrix(.Row, 6) = " Monto Final U.M. "
         .ColWidth(6) = TextWidth(.TextMatrix(.Row, 6)) + 300
         .ColAlignment(6) = 8     ' derecha abajo
    
         .Col = 7: .FixedAlignment(7) = 4
         .CellFontBold = True
         .TextMatrix(.Row, 7) = " Valor Presente "
         .ColWidth(7) = TextWidth(.TextMatrix(.Row, 7)) + 300
         .ColAlignment(7) = 8     ' derecha abajo

         .Col = 8: .FixedAlignment(8) = 4
         .CellFontBold = True
         .TextMatrix(.Row, 8) = " Intereses Devengados "
         .ColWidth(8) = TextWidth(.TextMatrix(.Row, 8)) + 300
         .ColAlignment(8) = 8     ' derecha abajo
         
         .Col = 9: .FixedAlignment(9) = 4
         .CellFontBold = True
         .TextMatrix(.Row, 9) = " Reajutes Devengados "
         .ColWidth(9) = TextWidth(.TextMatrix(.Row, 9)) + 300
         .ColAlignment(9) = 8     ' derecha abajo
    
         .Col = 10: .FixedAlignment(10) = 4
         .CellFontBold = True
         .TextMatrix(.Row, 10) = "     Custodia     "
         .ColWidth(10) = TextWidth(.TextMatrix(.Row, 10)) + 300
         .ColAlignment(10) = 4    ' CENTRO
        
       .ColWidth(11) = 1
       .ColWidth(12) = 1
       .ColWidth(13) = 1
       .ColWidth(14) = 1
        
        
    End With

End Function
Public Sub Color()
 
Dim f, c As Integer
 
 With Grilla
 
    For f = 1 To .Rows - 1
           .Row = f
                For c = 0 To .Cols - 1
                    .Col = c
                    .CellBackColor = &HC0C0C0
                    .CellForeColor = &H800000
                Next c
    Next f
    
 End With

End Sub
