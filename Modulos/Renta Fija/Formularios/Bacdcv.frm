VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form BacDCV 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Actualizacion Custodia en DCV"
   ClientHeight    =   4530
   ClientLeft      =   1650
   ClientTop       =   2025
   ClientWidth     =   8340
   FillStyle       =   0  'Solid
   ForeColor       =   &H00C0C0C0&
   Icon            =   "Bacdcv.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4530
   ScaleWidth      =   8340
   Begin VB.TextBox TxtGrilla 
      BackColor       =   &H00FFFFFF&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00404040&
      Height          =   315
      Left            =   720
      TabIndex        =   10
      Top             =   3030
      Visible         =   0   'False
      Width           =   1590
   End
   Begin VB.TextBox Text1 
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
      Height          =   315
      Left            =   1560
      MouseIcon       =   "Bacdcv.frx":030A
      MousePointer    =   99  'Custom
      TabIndex        =   5
      Top             =   630
      Width           =   1455
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   4245
      Top             =   60
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
            Picture         =   "Bacdcv.frx":0614
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacdcv.frx":0A66
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacdcv.frx":0D80
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Bacdcv.frx":109A
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Height          =   510
      Left            =   0
      TabIndex        =   4
      Top             =   0
      Width           =   8370
      _ExtentX        =   14764
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdActualizar"
            Description     =   "Actualizar"
            Object.ToolTipText     =   "Actualizar Datos"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Cmdlimpiar"
            Description     =   "Limpiar"
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Description     =   "Buscar"
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdSalir"
            Description     =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin VB.ComboBox cboCustodia 
      BackColor       =   &H00FFFFFF&
      DataSource      =   "Data1"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00404040&
      Height          =   315
      IntegralHeight  =   0   'False
      ItemData        =   "Bacdcv.frx":14EC
      Left            =   6360
      List            =   "Bacdcv.frx":14F9
      Style           =   2  'Dropdown List
      TabIndex        =   3
      TabStop         =   0   'False
      Top             =   1320
      Visible         =   0   'False
      Width           =   1455
   End
   Begin VB.TextBox TxtBusDoc 
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
      Height          =   315
      Left            =   4785
      MaxLength       =   10
      MouseIcon       =   "Bacdcv.frx":1510
      MousePointer    =   99  'Custom
      TabIndex        =   0
      Top             =   630
      Visible         =   0   'False
      Width           =   1455
   End
   Begin VB.Data Data1 
      Caption         =   "Data1"
      Connect         =   "Access"
      DatabaseName    =   ""
      DefaultCursorType=   0  'DefaultCursor
      DefaultType     =   2  'UseODBC
      Exclusive       =   0   'False
      Height          =   375
      Left            =   3120
      Options         =   0
      ReadOnly        =   0   'False
      RecordsetType   =   1  'Dynaset
      RecordSource    =   ""
      Top             =   6120
      Visible         =   0   'False
      Width           =   1575
   End
   Begin Threed.SSCommand cmSalir 
      Height          =   450
      Left            =   1665
      TabIndex        =   2
      Top             =   5235
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
   Begin Threed.SSCommand cmActual 
      Height          =   450
      Left            =   465
      TabIndex        =   1
      Top             =   5235
      Width           =   1200
      _Version        =   65536
      _ExtentX        =   2117
      _ExtentY        =   794
      _StockProps     =   78
      Caption         =   "&Actualizar"
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
   Begin MSFlexGridLib.MSFlexGrid GRD_Dcv 
      Height          =   3285
      Left            =   105
      TabIndex        =   6
      Top             =   1200
      Width           =   8160
      _ExtentX        =   14393
      _ExtentY        =   5794
      _Version        =   393216
      RowHeightMin    =   315
      FocusRect       =   0
   End
   Begin Threed.SSFrame SSFrame1 
      Height          =   585
      Left            =   30
      TabIndex        =   7
      Top             =   465
      Width           =   8295
      _Version        =   65536
      _ExtentX        =   14631
      _ExtentY        =   1032
      _StockProps     =   14
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ShadowStyle     =   1
      Begin VB.Label Label2 
         Caption         =   "Nemotécnico"
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
         Height          =   255
         Left            =   3480
         TabIndex        =   11
         Top             =   195
         Visible         =   0   'False
         Width           =   1200
      End
      Begin VB.Label Label1 
         Caption         =   "Instrumento"
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
         Height          =   255
         Left            =   135
         TabIndex        =   8
         Top             =   210
         Width           =   1365
      End
   End
   Begin Threed.SSFrame SSFrame2 
      Height          =   3510
      Left            =   30
      TabIndex        =   9
      Top             =   1005
      Width           =   8280
      _Version        =   65536
      _ExtentX        =   14605
      _ExtentY        =   6191
      _StockProps     =   14
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
End
Attribute VB_Name = "BacDCV"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim Fila                As Integer
Dim Columna             As Integer
Dim Sql                 As String
Dim Datos()
Dim colpress, rowpress  As Integer


Private Sub Func_Actualizar()
Dim x                As Integer
Dim nNumdocu#
Dim nCorrela#
Dim cDcv$
Dim cEstado$
Dim nOpcion%
Dim cCusto$
Dim cClaveDCV$
Dim nSw%

    Screen.MousePointer = 11

    nOpcion% = 1
    nSw = 0

    With GRD_Dcv
        If .Rows <= 1 Then
            Exit Sub
        End If

        For x = 1 To .Rows - 1
            nNumdocu = .TextMatrix(x, 0)
            nCorrela = .TextMatrix(x, 1)
            cDcv = .TextMatrix(x, 4)
            cEstado = .TextMatrix(x, 5)
'            cClaveDCV = .TextMatrix(x, 6)
            
            If RTrim$(cDcv$) <> RTrim$(cEstado$) Then
                cCusto$ = Mid$(Trim$(cDcv$), 1, 1)

'            Sql = "SP_ACTUALDCV " & Chr$(10)
'            Sql = Sql & nOpcion% & "," & Chr$(10)
'            Sql = Sql & nNumdocu# & "," & Chr$(10)
'            Sql = Sql & ncorrela# & "," & Chr$(10)
'            Sql = Sql & "'" & cCusto$ & "'" & Chr$(10)

                Envia = Array(nOpcion, _
                        nNumdocu, _
                        nCorrela, _
                        cCusto)
'                        cClaveDCV)
            
                If Not Bac_Sql_Execute("SP_ACTUALDCV", Envia) Then
                    nSw% = 1
                    Exit For
                End If

            End If

        Next x

    End With

    Screen.MousePointer = 0

    If nSw% = 1 Then
        MsgBox "ERROR: En la Actualización Custodia DCV"
    Else
        MsgBox "Actualización Custodia DCV Terminada Correctamente"
    End If

End Sub

Private Sub cboCustodia_Click()
'On Error Resume Next

   GRD_Dcv.Text = cboCustodia.Text
   If GRD_Dcv.Text <> "DCV" Then
   
      GRD_Dcv.TextMatrix(GRD_Dcv.Row, 6) = "" 'Trim(GRD_Dcv.TextMatrix(GRD_Dcv.Row, 6))
   
   Else
      
      GRD_Dcv.TextMatrix(GRD_Dcv.Row, 6) = GRD_Dcv.Tag 'GRD_Dcv.TextMatrix(GRD_Dcv.Row, 5) 'Trim(GRD_Dcv.TextMatrix(GRD_Dcv.Row, 6))
   
   End If
   
   cboCustodia.Visible = False
   GRD_Dcv.SetFocus

End Sub




Private Sub cboCustodia_KeyDown(KeyCode As Integer, Shift As Integer)

   If KeyCode = 27 Then
      'cboCustodia_LostFocus

   End If

   If KeyCode = 13 Then
      GRD_Dcv.TextMatrix(Fila, Columna) = cboCustodia.Text
      cboCustodia.Visible = False

   End If

End Sub

Private Sub cboCustodia_LostFocus()

   cboCustodia.Visible = False

End Sub

Private Sub Form_Activate()

   Screen.MousePointer = 0
   TxtBusDoc.Enabled = False

'''''''''   If Data1.Recordset.EOF And Data1.Recordset.BOF Then
'''''''''      MsgBox "No existen instrumentos en custodia", vbExclamation, gsBac_Version
'''''''''      Unload Me
'''''''''
'''''''''   End If

End Sub

Private Sub Form_Load()
Dim nCont As Integer

   Me.Top = 0
   Me.Left = 0
Call Formato_Grilla(GRD_Dcv)
   With GRD_Dcv
'      .AllowBigSelection = True
'      '.ScrollBars = flexScrollBarVertical
'      '.BackColor = &HC0C0C0               'Color de la grilla
'      '.BackColorFixed = &H808000          'Fondo de los titulos
'      '.ForeColorFixed = &H80000009
'      .GridLines = flexGridInset
'      '.ForeColor = &HFF0000
'      .BackColorSel = vbBlue
'       '.Font.bold = False
      .Rows = 2
      .cols = 7
      
      .FixedRows = 1
      .FixedCols = 0
      .RowHeight(0) = 500
      .ColWidth(0) = 1400
      .ColWidth(1) = 1250
      .ColWidth(2) = 1650
      .ColWidth(3) = 985
      .ColWidth(4) = 1350 '1290
      .ColWidth(5) = 0  ' Poner a cero o invisible esta columna
      .ColWidth(6) = 1350

      For nCont = 0 To .cols - 1
         .FixedAlignment(nCont) = 4
      Next nCont

     ' For ncont = 0 To Data1.Recordset.Fields.Count - 1
         .TextMatrix(0, 0) = "NºDOCUMENTO"
         .TextMatrix(0, 1) = "CORRELATIVO"
         .TextMatrix(0, 2) = "NEMOTECNICO"
         .TextMatrix(0, 3) = "TIR%"
         .TextMatrix(0, 4) = "CUSTODIA"
         .TextMatrix(0, 5) = "" 'ESTADO
         .TextMatrix(0, 6) = "CLAVE DCV"
         .Col = 5
         .Rows = 1

      'Next

      .Enabled = False

  End With
  
''''''''On Error GoTo ErrDcv
''''''''Dim i       As Double
''''''''Dim dCero   As Double
''''''''
''''''''    Data1.DatabaseName = gsMDB_Path & gsMDB_Database
''''''''    Data1.RecordSource = "MDDCV"
''''''''    Data1.Refresh
''''''''
''''''''    Me.Top = 0
''''''''    Me.Left = 0
''''''''
''''''''    Screen.MousePointer = 11
''''''''
''''''''    i = 1
''''''''    dCero = 0
''''''''
'''''''''   Sql = "SP_ACTUALDCV 0,0,0,'N'"
''''''''
''''''''    Envia = Array(dCero, dCero, dCero, "N")
''''''''
''''''''    db.Execute "DELETE FROM MDDCV"
''''''''
''''''''    If Bac_Sql_Execute("SP_ACTUALDCV", Envia) Then
''''''''        Do While Bac_SQL_Fetch(DATOS())
''''''''
''''''''            Sql = "INSERT INTO MDDCV VALUES ( " & Chr(10)
''''''''            Sql = Sql & DATOS(1) & "," & Chr(10)
''''''''            Sql = Sql & DATOS(2) & "," & Chr(10)
''''''''            Sql = Sql & "'" & DATOS(3) & "'," & Chr(10)
''''''''            Sql = Sql & DATOS(4) & "," & Chr(10)
''''''''
''''''''            If DATOS(5) = "P" Then
''''''''                Sql = Sql & "'PROPIA'," & Chr(10)
''''''''                Sql = Sql & "'PROPIA'," & Chr(10)
''''''''
''''''''            ElseIf DATOS(5) = "C" Then
''''''''                Sql = Sql & "'CLIENTE'," & Chr(10)
''''''''                Sql = Sql & "'CLIENTE'," & Chr(10)
''''''''
''''''''            Else
''''''''                Sql = Sql & "'DCV'," & Chr(10)
''''''''                Sql = Sql & "'DCV'," & Chr(10)
''''''''
''''''''            End If
''''''''
''''''''            Sql = Sql & Str(i) & ")"
''''''''
''''''''            i = i + 1
''''''''
''''''''            db.Execute Sql
''''''''
''''''''        Loop
''''''''
''''''''    Else
''''''''        MsgBox "Servidor Sql No Responde", 16
''''''''    End If
''''''''
''''''''    Data1.Refresh
''''''''    LlenarGrilla
''''''''    Screen.MousePointer = 0
''''''''    On Error GoTo 0
''''''''    Exit Sub
''''''''
''''''''ErrDcv:
''''''''    On Error GoTo 0
''''''''    MsgBox "Problemas en la carga de instrumentos en DCV: " & Err.Description & ". Comunique al administrador.", vbCritical, gsBac_Version

End Sub

Private Sub cboCustodia_GotFocus()

   Fila = GRD_Dcv.Row
   Columna = GRD_Dcv.Col

End Sub


Private Sub GRD_Dcv_RowColChange()
      
      GRD_Dcv.Tag = GRD_Dcv.TextMatrix(GRD_Dcv.Row, 6)
      cboCustodia_LostFocus
'      TxtGrilla_LostFocus

      If GRD_Dcv.ColSel = 6 Then
         
         'GRD_Dcv_Click
      
      End If
   
   
      If GRD_Dcv.ColSel = 4 Then
         
         GRD_Dcv_Click
         
      End If
   

End Sub

Private Sub GRD_Dcv_Scroll()

   If cboCustodia.Visible = True Then
'      cboCustodia_LostFocus

   End If

End Sub


Private Sub GRD_Dcv_Click()

   Dim x                As Integer
   Dim Y                As Integer

   With GRD_Dcv
      
      If .Col = 4 Then
         
         PROC_POSI_TEXTO GRD_Dcv, cboCustodia
         
         cboCustodia.Left = cboCustodia.Left - 10
         cboCustodia.Top = cboCustodia.Top - 15
         
         On Error GoTo EndError:
         
         cboCustodia.Text = GRD_Dcv.Text
         cboCustodia.Visible = True
         

      End If

''''      If .Col = 6 And .TextMatrix(.Row, 4) = "DCV" Then
''''
''''         PROC_POSI_TEXTO GRD_Dcv, TxtGrilla
''''
''''         TxtGrilla.Left = TxtGrilla.Left - 10
''''         TxtGrilla.Top = TxtGrilla.Top - 15
''''
''''         On Error GoTo EndError:
''''         TxtGrilla.Visible = True
''''         TxtGrilla.Text = Trim(GRD_Dcv.Text)
''''         TxtGrilla.SetFocus
''''
''''      End If


   End With
EndError:
End Sub


Private Sub LlenarGrilla()

   Dim nCont            As Integer
   Dim x                As Integer

   cboCustodia.Clear
   cboCustodia.AddItem "PROPIA"
   cboCustodia.AddItem "DCV"
   cboCustodia.AddItem "CLIENTE"

   With GRD_Dcv
   
      .Redraw = False
      
      .AllowBigSelection = False
      .ScrollBars = flexScrollBarVertical
      '.BackColor = &HC0C0C0               'Color de la grilla
      '.BackColorFixed = &H808000          'Fondo de los titulos
      '.ForeColorFixed = &H80000009
      .Gridlines = flexGridInset
      '.ForeColor = &HFF0000
       '.Font.bold = False
      .Rows = 2
      .cols = 7
      .FixedRows = 1
      .FixedCols = 0
      .RowHeight(0) = 500
      .ColWidth(0) = 1400
      .ColWidth(1) = 1250
      .ColWidth(2) = 1650
      .ColWidth(3) = 985
      .ColWidth(4) = 1350 '1290
      .ColWidth(5) = 0  ' Poner a cero o invisible esta columna
      .ColWidth(6) = 1350

      For nCont = 0 To .cols - 1
         .FixedAlignment(nCont) = 4

      Next nCont

      For nCont = 0 To Data1.Recordset.Fields.Count - 1
         .TextMatrix(0, 0) = "Nº DOCUMENTO"
         .TextMatrix(0, 1) = "CORRELATIVO"
         .TextMatrix(0, 2) = "NEMOTECNICO"
         .TextMatrix(0, 3) = "TIR%"
         .TextMatrix(0, 4) = "CUSTODIA"
         .TextMatrix(0, 5) = "" 'ESTADO
         .TextMatrix(0, 6) = "CLAVE DCV"
      
      Next

      If Not (Data1.Recordset.EOF And Data1.Recordset.BOF) Then
         Data1.Recordset.MoveFirst

      End If

      .Row = 1

      Do While Not Data1.Recordset.EOF
         .Font.bold = False
         .TextMatrix(.Row, 0) = Data1.Recordset.Fields(0).Value
         .TextMatrix(.Row, 1) = Data1.Recordset.Fields(1).Value
         .TextMatrix(.Row, 2) = Data1.Recordset.Fields(2).Value
         .TextMatrix(.Row, 3) = BacStrTran(CStr(Data1.Recordset.Fields(3).Value), ",", ".")
         .TextMatrix(.Row, 4) = Data1.Recordset.Fields(4).Value
         .TextMatrix(.Row, 5) = Data1.Recordset.Fields(5).Value

         Data1.Recordset.MoveNext

         .Rows = .Rows + 1
         .Row = .Row + 1
         .RowHeight(.Row - 1) = 305

      Loop

      .Rows = .Rows - 1
      .Row = 1
      .Col = 0

      .Enabled = True
      .Redraw = True
      
   End With

End Sub

Private Sub GRD_Dcv_KeyPress(KeyAscii As Integer)

   With GRD_Dcv
      .ColSel = .Col

       GRD_Dcv_Click


   End With

EndError:

End Sub

Private Sub Text1_DblClick()

    Me.Tag = ""
    BacAyuda.Tag = "INSTRU_CAR"
    BacAyuda.Show 1
    
    If giAceptar = True Then
      
      Text1.Text = Trim(Mid(Me.Tag, 5, 15))
      Text1.Tag = Left(Me.Tag, 5)
      TxtBusDoc.Enabled = True
      TxtBusDoc.Text = ""
      TxtBusDoc.Tag = ""
      Trae_Valores
      'TxtBusDoc.SetFocus
          
    End If

End Sub

Private Sub Text1_KeyDown(KeyCode As Integer, Shift As Integer)

   Select Case KeyCode
   
      Case vbKeyF3
      
            Text1_DblClick
      
      Case 13
      
            
            TxtBusDoc.Text = ""
            TxtBusDoc.Tag = ""
            Text1.Tag = ""
            GRD_Dcv.Rows = 1
            GRD_Dcv.Col = 5
            
            If Trae_Valores2("", Text1.Text) Then
               
               Trae_Valores
               TxtBusDoc.Enabled = True
'               TxtBusDoc.SetFocus
               
            Else
            
               Text1.Text = ""
               Text1.SetFocus
               
            End If
               
            
   End Select

End Sub

Private Sub Trae_Valores()

On Error GoTo ErrDcv
Dim I       As Double
Dim dCero   As Double

If Text1.Text <> "" Then

    Data1.DatabaseName = gsMDB_Path & gsMDB_Database
    Data1.RecordSource = "MDDCV"
    Data1.Refresh

   
    Screen.MousePointer = 11

    I = 1
    dCero = 0

'   Sql = "SP_ACTUALDCV 0,0,0,'N'"

    Envia = Array()
    AddParam Envia, CDbl(Trim(Text1.Tag))
    AddParam Envia, TxtBusDoc.Text

    db.Execute "DELETE FROM MDDCV"

    If Bac_Sql_Execute("SP_BACDCV_ACTUALDCV", Envia) Then
        Do While Bac_SQL_Fetch(Datos())

        If Datos(1) <> "NO" Then

            Sql = "INSERT INTO MDDCV VALUES ( " & Chr(10)
            Sql = Sql & Datos(1) & "," & Chr(10)
            Sql = Sql & Datos(2) & "," & Chr(10)
            Sql = Sql & "'" & Datos(3) & "'," & Chr(10)
            Sql = Sql & Datos(4) & "," & Chr(10)

            If Datos(5) = "P" Then
                Sql = Sql & "'PROPIA'," & Chr(10)
                'Sql = Sql & "'PROPIA'," & Chr(10)

            ElseIf Datos(5) = "C" Then
                Sql = Sql & "'CLIENTE'," & Chr(10)
                'Sql = Sql & "'CLIENTE'," & Chr(10)

            Else
                Sql = Sql & "'DCV'," & Chr(10)
               ' Sql = Sql & "'DCV'," & Chr(10)

            End If
            Sql = Sql & "' ',"
            Sql = Sql & Str(I) & ")"

            I = I + 1

            db.Execute Sql

         Else
         
            GRD_Dcv.Rows = 1
            Screen.MousePointer = 0
            GRD_Dcv.cols = 7
            GRD_Dcv.ColWidth(5) = 0
            GRD_Dcv.Col = 5
            GRD_Dcv.Row = 0
            Exit Sub

         End If
         
        Loop

    Else
        MsgBox "Servidor Sql No Responde", 16
    End If

    Data1.Refresh
    LlenarGrilla
    BuscaClaveDcv
    Screen.MousePointer = 0
    On Error GoTo 0

End If

Exit Sub

ErrDcv:
    On Error GoTo 0
    MsgBox "Problemas en la carga de instrumentos en DCV: " & err.Description & ". Comunique al administrador.", vbCritical, gsBac_Version
   Screen.MousePointer = 0

End Sub

Private Sub Text1_KeyPress(KeyAscii As Integer)
    BacToUCase KeyAscii
    If KeyAscii >= 48 And KeyAscii <= 57 Then
       KeyAscii = 0
    End If
    
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

   Select Case UCase(Button.Description)
   Case "ACTUALIZAR"
      Call Func_Actualizar
      Screen.MousePointer = 0

   Case "LIMPIAR"
   
      Text1.Text = ""
      TxtBusDoc.Text = ""
      GRD_Dcv.Rows = 1
      GRD_Dcv.Refresh
      
   Case "BUSCAR"

      Trae_Valores

   Case "SALIR"
      Unload Me

   End Select

End Sub

Private Sub TxtBusDoc_DblClick()
    
    Me.Tag = ""
    BacAyuda.Tag = "NEMOTEC"
    Me.Tag = Text1.Tag
    
    BacAyuda.Show 1
    
    If giAceptar = True Then
      
      
      TxtBusDoc.Text = Trim(Mid(Me.Tag, 6, 30))
      TxtBusDoc.Tag = Trim(Mid(Me.Tag, 1, 5))
      'Call Trae_Valores
       
    End If

End Sub

Private Sub TxtBusDoc_KeyDown(KeyCode As Integer, Shift As Integer)
   
   Select Case KeyCode
   
      Case vbKeyF3
      
            TxtBusDoc_DblClick
      
      Case 13
      
            If Trae_Valores2(TxtBusDoc.Text, "") Then
               
               Trae_Valores
               
            Else
            
               GRD_Dcv.Rows = 1
               GRD_Dcv.Col = 5
               TxtBusDoc.Text = ""
                  
            End If
   
   End Select

End Sub

Private Sub TxtBusDoc_KeyPress(KeyAscii As Integer)

   BacToUCase KeyAscii

   If KeyAscii = 13 Then
      GRD_Dcv.SetFocus

   End If



End Sub

Private Sub TxtBusDoc_LostFocus()

          'Trae_Valores
         

'''''''   Dim MyDB             As Database
'''''''   Dim MyTable          As Recordset
'''''''   Dim aux              As Integer
'''''''   Dim i
'''''''   Dim nPos#
'''''''
'''''''   Set MyDB = Workspaces(0).OpenDatabase(gsMDB_Path + gsMDB_Database)
'''''''   Set MyTable = MyDB.OpenRecordset("MDDCV", dbOpenTable)
'''''''
'''''''   aux = 0
'''''''
'''''''   If TxtBusDoc.Text <> "" Then
'''''''      With GRD_Dcv
'''''''         .Col = 2
'''''''
'''''''         For i = 1 To .Rows - 1
'''''''            If .TextMatrix(i, 2) = TxtBusDoc.Text Then
'''''''               GRD_Dcv.Row = i
'''''''               GRD_Dcv.Col = 4
'''''''               Exit For
'''''''
'''''''            Else
'''''''               aux = aux + 1
'''''''
'''''''            End If
'''''''
'''''''         Next i
'''''''
'''''''         If aux = .Rows - 1 Then
'''''''            MsgBox "No existe Nemotécnico", 16
'''''''
'''''''         End If
'''''''
'''''''      End With
'''''''
'''''''   End If
'''''''
'''''''   MyDB.Close

End Sub


Sub BuscaClaveDcv()
Dim I As Integer

   
   With GRD_Dcv

      For I = 1 To .Rows - 1
      
         If Bac_Sql_Execute("SP_BACDCV_BUSCACLAVEDCV") Then
      
            While Bac_SQL_Fetch(Datos())
      
               If .TextMatrix(I, 0) = Datos(1) And .TextMatrix(I, 1) = Datos(2) Then
            
                  .TextMatrix(I, 6) = Datos(3)
               
               End If
               
            Wend
            
         Else
         
            Exit Sub
            
         End If
      
      Next I

   End With

End Sub


Function Trae_Valores2(xSerie, xInstrumento As Variant) As Boolean
   
   Envia = Array()
   AddParam Envia, xSerie
   AddParam Envia, xInstrumento
   
   Trae_Valores2 = True
   


   If Bac_Sql_Execute("SP_BACDCV_BUSCA_SERIEINSTRUMENTO", Envia) Then

      If Bac_SQL_Fetch(Datos()) Then

         If Datos(1) <> "NO" Then

            If xSerie <> "" Then
            
               TxtBusDoc.Tag = Datos(1)
            
            Else
            
               Text1.Tag = Datos(1)
            
            End If

        Else
         
            Trae_Valores2 = False

        End If

      End If
   
   End If

End Function

Private Sub TxtGrilla_KeyPress(KeyAscii As Integer)

   Select Case KeyAscii
   
      Case 27
      
         TxtGrilla.Visible = False
         GRD_Dcv.SetFocus
      
      Case 13
      
         GRD_Dcv.Text = Trim(TxtGrilla.Text)
         TxtGrilla.Visible = False
         GRD_Dcv.Refresh
         GRD_Dcv.SetFocus
      
      
   End Select

   BacToUCase KeyAscii

End Sub

Private Sub TxtGrilla_LostFocus()

      TxtGrilla.Visible = False

End Sub
