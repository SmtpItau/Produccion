VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Begin VB.Form BACFLUCAJ 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Flujo de Caja"
   ClientHeight    =   4410
   ClientLeft      =   3165
   ClientTop       =   2100
   ClientWidth     =   10020
   Icon            =   "Bacfluca.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4410
   ScaleWidth      =   10020
   Begin Threed.SSFrame SSFrame1 
      Height          =   3840
      Index           =   1
      Left            =   60
      TabIndex        =   0
      Top             =   525
      Width           =   4155
      _Version        =   65536
      _ExtentX        =   7329
      _ExtentY        =   6773
      _StockProps     =   14
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   3
      Begin MSFlexGridLib.MSFlexGrid Table1 
         Height          =   2655
         Left            =   240
         TabIndex        =   8
         Top             =   960
         Width           =   3735
         _ExtentX        =   6588
         _ExtentY        =   4683
         _Version        =   393216
         FixedCols       =   0
      End
      Begin VB.ComboBox Cmb_Base 
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
         Left            =   3150
         Style           =   2  'Dropdown List
         TabIndex        =   7
         Top             =   390
         Visible         =   0   'False
         Width           =   420
      End
      Begin VB.ComboBox Cmb_Moneda 
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
         Left            =   1035
         Style           =   2  'Dropdown List
         TabIndex        =   6
         Top             =   375
         Width           =   2055
      End
      Begin VB.Label Label1 
         Caption         =   "Moneda"
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
         Height          =   285
         Left            =   255
         TabIndex        =   5
         Top             =   405
         Width           =   750
      End
   End
   Begin Threed.SSCommand cmdImprimir 
      Height          =   450
      Left            =   1170
      TabIndex        =   4
      Top             =   0
      Width           =   1200
      _Version        =   65536
      _ExtentX        =   2117
      _ExtentY        =   794
      _StockProps     =   78
      Caption         =   "Imprimir"
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
      Enabled         =   0   'False
      Font3D          =   3
   End
   Begin Threed.SSCommand cmdProcesar 
      Height          =   450
      Left            =   0
      TabIndex        =   3
      Top             =   0
      Width           =   1200
      _Version        =   65536
      _ExtentX        =   2117
      _ExtentY        =   794
      _StockProps     =   78
      Caption         =   "Buscar"
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
   Begin MSGrid.Grid Grid2 
      Height          =   3465
      Left            =   7200
      TabIndex        =   2
      Top             =   360
      Width           =   2415
      _Version        =   65536
      _ExtentX        =   4260
      _ExtentY        =   6112
      _StockProps     =   77
      BackColor       =   16777215
      Cols            =   9
      MouseIcon       =   "Bacfluca.frx":030A
   End
   Begin MSGrid.Grid Grid1 
      Height          =   3525
      Left            =   4440
      TabIndex        =   1
      Top             =   360
      Width           =   2295
      _Version        =   65536
      _ExtentX        =   4048
      _ExtentY        =   6218
      _StockProps     =   77
      BackColor       =   16777215
      Cols            =   9
      MouseIcon       =   "Bacfluca.frx":0326
   End
End
Attribute VB_Name = "BACFLUCAJ"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Dim Hay  As Integer
Dim Hay1 As Integer
Dim Cargos As Double
Dim Abonos As Double


Private Function IMP_FLUJO_CAJA() As Boolean
Dim SQL As String
IMP_FLUJO_CAJA = False

If Hay = 1 Then
IMP_FLUJO_CAJA = True

    SQL = "DELETE FROM FLUCAJ;"

    db.Execute SQL
    SQL = ""
    
    
    For i = 1 To Grid1.Rows - 1
        Grid1.Row = i
        Grid1.Col = 1
        SQL = "INSERT INTO FLUCAJ VALUES ( "
                   SQL = SQL & "'" & Trim(Grid1.Text) & "', "
                      Grid1.Col = 2
                   SQL = SQL & "'" & Trim(Grid1.Text) & "', "
                      Grid1.Col = 3
                   SQL = SQL & "'" & Trim(Grid1.Text) & "', "
                      Grid1.Col = 4
                   SQL = SQL & Val(Grid1.Text) & ", "
                      Grid1.Col = 5
                   SQL = SQL & "'" & Grid1.Text & "', "
                      Grid1.Col = 6
                   SQL = SQL & "'" & Trim(Grid1.Text) & "', "
                      Grid1.Col = 7
                   SQL = SQL & CDbl(Grid1.Text) & ", "
                   SQL = SQL & "'PESOS' ,"
                   SQL = SQL & CDbl(lblSaldoP.Caption) & ", "
                   SQL = SQL & "'" & txtFechaP.Text & "'" & ")"
      db.Execute SQL
  Next i
End If
  
If Hay1 = 1 Then
IMP_FLUJO_CAJA = True
  
  SQL = ""
  For i = 1 To Grid2.Rows - 1
      Grid2.Row = i
      Grid2.Col = 1
       SQL = "INSERT INTO FLUCAJ VALUES ( "
                   SQL = SQL & "'" & Trim(Grid2.Text) & "', "
                      Grid2.Col = 2
                   SQL = SQL & "'" & Trim(Grid2.Text) & "', "
                      Grid2.Col = 3
                   SQL = SQL & "'" & Trim(Grid2.Text) & "', "
                      Grid2.Col = 4
                   SQL = SQL & Val(Grid2.Text) & ", "
                      Grid2.Col = 5
                   SQL = SQL & "'" & Grid2.Text & "', "
                      Grid2.Col = 6
                   SQL = SQL & "'" & Trim(Grid2.Text) & "',"
                      Grid2.Col = 7
                   SQL = SQL & CDbl(Grid2.Text) & ", "
                   SQL = SQL & "'DOLAR AMERICANO' ,"
                   SQL = SQL & CDbl(lblSaldoD.Caption) & ", "
                   SQL = SQL & "'" & txtFechaP.Text & "'" & ")"
      db.Execute SQL
  Next i
End If
End Function



Private Sub cmdImprimir_Click()
If Not Llenar_Parametros("BACTRADER") Then Exit Sub
If IMP_FLUJO_CAJA Then
       BacTrader.BacRpt.Destination = 0
       BacTrader.BacRpt.ReportFileName = RptList_Path & "FLUCAJA.RPT"
       BacTrader.BacRpt.WindowParentHandle = BacTrader.hWnd
       BacTrader.BacRpt.Action = 1
    End If

End Sub


Private Sub cmdProcesar_Click()
Dim Datos()
Dim SQL As String
Dim Hay As Boolean

Hay = False
Screen.MousePointer = 11

Hay = 0

SQL = "SP_FLUJO_CAJA '" & Format(gsBac_Fecp, "yyyymmdd") & "','" & Trim(Cmb_Moneda.Text) & "'"
If SQL_Execute(SQL) <> 0 Then
   MsgBox "Error : Cargando flujo caja", vbOKOnly + vbCritical
   Screen.MousePointer = 0
   Exit Sub
End If

Do While SQL_Fetch(Datos()) = 0
 Hay = True
Loop


If Not Hay Then
   MsgBox "No hay información", vbOKOnly + vbExclamation
End If
Screen.MousePointer = 0

Table1.Rows = Grid1.Rows - 1
Table1.Row = Grid1.Rows - 1
Table1.Refresh


End Sub

Private Sub Form_Load()
Me.Left = 0
Me.Top = 0

If funcFindMonVal(Cmb_Moneda, Cmb_Base, "FC") Then
   Cmb_Moneda.ListIndex = 0
End If

'Table1.ColumnCellAttrs(1) = True
'Table1.ColumnCellAttrs(2) = True

End Sub


Private Sub Table1_Fetch(Row As Long, Col As Integer, Value As String)
With Grid1
   .Col = Col
   .Row = Row
    Value = .Text
End With
End Sub



Private Sub Table1_FetchAttributes(Status As Integer, Split As Integer, Row As Long, Col As Integer, FgColor As Long, BgColor As Long, FontStyle As Integer)
     
    Grid1.Col = Col
    
    Grid1.Row = Row
    If Col = Table1.ColumnIndex And Row = Table1.RowIndex Then
        FgColor = BacToolTip.Color_Dest.ForeColor
        BgColor = BacToolTip.Color_Dest.BackColor
    Else
        Grid1.Col = 3
        If Mid$(Grid1.Text, 1, 5) = "VENTA" Then
            FgColor = BacToolTip.Color_Bloqueado.ForeColor
            BgColor = BacToolTip.Color_Bloqueado.BackColor
        Else
            FgColor = BacToolTip.Color_Normal.ForeColor
            BgColor = BacToolTip.Color_Normal.BackColor
        End If
    End If
    

End Sub

