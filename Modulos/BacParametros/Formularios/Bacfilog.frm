VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form BacFiltrosConsul 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Filtro Consulta de Loggers"
   ClientHeight    =   4740
   ClientLeft      =   1530
   ClientTop       =   2520
   ClientWidth     =   9120
   FillStyle       =   0  'Solid
   Icon            =   "Bacfilog.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4740
   ScaleWidth      =   9120
   ShowInTaskbar   =   0   'False
   Begin Threed.SSFrame Ffiltros 
      Height          =   1230
      Index           =   0
      Left            =   6420
      TabIndex        =   12
      Top             =   540
      Width           =   2595
      _Version        =   65536
      _ExtentX        =   4577
      _ExtentY        =   2170
      _StockProps     =   14
      Caption         =   "Filtros de fecha"
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin VB.PictureBox txtFecDesde 
         Height          =   315
         Left            =   1155
         ScaleHeight     =   255
         ScaleWidth      =   1140
         TabIndex        =   9
         Top             =   345
         Width           =   1200
      End
      Begin VB.PictureBox txtFecHasta 
         Height          =   315
         Left            =   1170
         ScaleHeight     =   255
         ScaleWidth      =   1140
         TabIndex        =   10
         Top             =   735
         Width           =   1200
      End
      Begin VB.Label Label1 
         Caption         =   "Desde"
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
         Height          =   270
         Left            =   225
         TabIndex        =   15
         Top             =   375
         Width           =   570
      End
      Begin VB.Label Label2 
         Caption         =   "Hasta"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   240
         Left            =   240
         TabIndex        =   14
         Top             =   750
         Width           =   525
      End
   End
   Begin Threed.SSFrame Fordenado 
      Height          =   1260
      Index           =   1
      Left            =   3825
      TabIndex        =   1
      Top             =   510
      Width           =   2520
      _Version        =   65536
      _ExtentX        =   4445
      _ExtentY        =   2223
      _StockProps     =   14
      Caption         =   "Ordenado por"
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin Threed.SSOption optOrdena 
         Height          =   315
         Index           =   2
         Left            =   1320
         TabIndex        =   8
         Top             =   345
         Width           =   945
         _Version        =   65536
         _ExtentX        =   1667
         _ExtentY        =   556
         _StockProps     =   78
         Caption         =   "Fecha "
         ForeColor       =   8421376
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Font3D          =   4
      End
      Begin Threed.SSOption optOrdena 
         Height          =   315
         Index           =   3
         Left            =   1305
         TabIndex        =   11
         Top             =   720
         Width           =   1065
         _Version        =   65536
         _ExtentX        =   1879
         _ExtentY        =   556
         _StockProps     =   78
         Caption         =   "Pantalla"
         ForeColor       =   8421376
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Font3D          =   4
      End
      Begin Threed.SSOption optOrdena 
         Height          =   315
         Index           =   1
         Left            =   120
         TabIndex        =   7
         Top             =   705
         Width           =   1005
         _Version        =   65536
         _ExtentX        =   1773
         _ExtentY        =   556
         _StockProps     =   78
         Caption         =   "Evento"
         ForeColor       =   8421376
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Font3D          =   4
      End
      Begin Threed.SSOption optOrdena 
         Height          =   315
         Index           =   0
         Left            =   120
         TabIndex        =   6
         Top             =   330
         Width           =   1020
         _Version        =   65536
         _ExtentX        =   1799
         _ExtentY        =   556
         _StockProps     =   78
         Caption         =   "Usuario"
         ForeColor       =   128
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Value           =   -1  'True
         Font3D          =   4
      End
   End
   Begin Threed.SSFrame Fconsulta 
      Height          =   1305
      Index           =   2
      Left            =   105
      TabIndex        =   0
      Top             =   465
      Width           =   3570
      _Version        =   65536
      _ExtentX        =   6297
      _ExtentY        =   2302
      _StockProps     =   14
      Caption         =   "Consulta por"
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin VB.TextBox txtrut 
         Alignment       =   1  'Right Justify
         Height          =   315
         Left            =   105
         MaxLength       =   20
         MouseIcon       =   "Bacfilog.frx":030A
         MousePointer    =   99  'Custom
         TabIndex        =   5
         Top             =   810
         Width           =   3360
      End
      Begin Threed.SSOption optConsulta 
         Height          =   315
         Index           =   2
         Left            =   2505
         TabIndex        =   4
         Top             =   345
         Width           =   915
         _Version        =   65536
         _ExtentX        =   1614
         _ExtentY        =   556
         _StockProps     =   78
         Caption         =   "Fecha "
         ForeColor       =   8421376
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Font3D          =   4
      End
      Begin Threed.SSOption optConsulta 
         Height          =   315
         Index           =   1
         Left            =   1365
         TabIndex        =   3
         Top             =   345
         Width           =   1005
         _Version        =   65536
         _ExtentX        =   1773
         _ExtentY        =   556
         _StockProps     =   78
         Caption         =   "Evento"
         ForeColor       =   8421376
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Font3D          =   4
      End
      Begin Threed.SSOption optConsulta 
         Height          =   315
         Index           =   0
         Left            =   165
         TabIndex        =   2
         Top             =   345
         Width           =   1050
         _Version        =   65536
         _ExtentX        =   1852
         _ExtentY        =   556
         _StockProps     =   78
         Caption         =   "Usuario"
         ForeColor       =   128
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Value           =   -1  'True
         Font3D          =   4
      End
   End
   Begin Threed.SSFrame Fgrid 
      Height          =   2850
      Index           =   4
      Left            =   90
      TabIndex        =   13
      Top             =   1860
      Width           =   8940
      _Version        =   65536
      _ExtentX        =   15769
      _ExtentY        =   5027
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
   Begin Threed.SSCommand cmdAceptar 
      Height          =   450
      Left            =   15
      TabIndex        =   18
      Top             =   0
      Width           =   1200
      _Version        =   65536
      _ExtentX        =   2117
      _ExtentY        =   794
      _StockProps     =   78
      Caption         =   "&Aceptar"
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
      Left            =   2415
      TabIndex        =   17
      Top             =   0
      Width           =   1200
      _Version        =   65536
      _ExtentX        =   2117
      _ExtentY        =   794
      _StockProps     =   78
      Caption         =   "&Retornar"
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
   Begin Threed.SSCommand cmdLimpiar 
      Height          =   450
      Left            =   1215
      TabIndex        =   16
      Tag             =   "C"
      Top             =   0
      Width           =   1200
      _Version        =   65536
      _ExtentX        =   2117
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
End
Attribute VB_Name = "BacFiltrosConsul"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit
Dim Sql$, Datos(), nPos%, i%
Dim optC, optO, optFi, optFd, optFt As String

Private Sub Form_Load()

' txtFecDesde.Separator = Asc(gsc_FechaSeparador)
' txtFecHasta.Separator = Asc(gsc_FechaSeparador)
' txtFecDesde.Text = Format$(gsBAC_Fecp, gsc_FechaDMA)
' txtFecHasta.Text = Format$(gsBAC_Fecp, gsc_FechaDMA)
 'Table1.Enabled = False
 'Table1.ColumnVisible(1) = False
 Me.Left = 100
 Me.Top = 100
End Sub
'
'Private Sub table1_Validate(Row As Long, Col As Integer, Value As String, Cancel As Integer)
' If Table1.ColumnIndex = 6 Then
'   Cancel = False
'   Value = Table1.ColumnText(6)
' End If
'End Sub

Private Sub txtFecDesde_KeyPress(KeyAscii As Integer)
 If KeyAscii = 13 Then SendKeys "{tab}"
End Sub

'Private Sub txtFecDesde_LostFocus()
'  optFi = Format(txtFecDesde.Text, "YYYYMMDD")
'  optFd = Format(txtFecHasta.Text, "YYYYMMDD")
'  optFt = "1"
'End Sub

Private Sub txtFecHasta_KeyPress(KeyAscii As Integer)
 If KeyAscii = 13 Then SendKeys "{tab}"
End Sub

'Private Sub txtFecHasta_LostFocus()
'  optFi = Format(txtFecDesde.Text, "YYYYMMDD")
'  optFd = Format(txtFecHasta.Text, "YYYYMMDD")
'  optFt = "1"
'End Sub

Private Sub TxthoraFin_KeyPress(KeyAscii As Integer)
 If KeyAscii = 13 Then SendKeys "{tab}"
End Sub

Private Sub TxthoraIni_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then SendKeys "{tab}"
End Sub

 Private Sub txtRut_DblClick()
   BacControlWindows 100
   BacAyuda.Tag = "MDLOG"
   BacAyuda.Show 1
 If giAceptar% = True Then
   Txtrut.Text = Trim(gsNombre)
   Txtrut.Tag = gsCodigo
   optOrdena(0).SetFocus
 End If
End Sub

Private Sub txtRut_KeyDown(KeyCode As Integer, Shift As Integer)
 If KeyCode = vbKeyF3 Then Call txtRut_DblClick
End Sub

Private Sub txtRut_KeyPress(KeyAscii As Integer)
 If Trim(Txtrut.Text) <> "" And KeyAscii% = vbKeyReturn Then
    Sql = IIf(optConsulta(0).Value, "1", IIf(optConsulta(1).Value, "2", "3"))
    Sql = "sp_busua '" & IIf(optConsulta(0).Value, Txtrut.Tag, Txtrut.Text) & "', '" & Sql & "' "
  If MISQL.SQL_Execute(Sql) <> 0 Then

    Exit Sub
  End If
  If MISQL.SQL_Fetch(Datos()) <> 0 Then
    MsgBox IIf(optConsulta(0).Value, "Usuario err?neo", IIf(optConsulta(1).Value, "Evento erroneo", "Fecha erronea ")), 16, " Bac-Cambio "
    Exit Sub
  Else
   optOrdena(0).SetFocus
  End If
 Else
  Call BacToUCase(KeyAscii)
 End If
End Sub

Private Sub CmdAceptar_Click()
If Trim(Txtrut.Text) = "" Then
 MsgBox "Selecci?n no corresponde, Repita", 16, " Bac-Cambio "
 Txtrut.SetFocus
 Exit Sub
 End If
 If optConsulta(0).Value Then
    optC = "1" + IIf(Trim(Txtrut.Tag) = "", gsBAC_User, Txtrut.Tag)
 ElseIf optConsulta(1).Value Then
  optC = IIf(Trim(Txtrut.Text) = "", "1" + gsBAC_User, "2" + Txtrut.Text)
 ElseIf optConsulta(2).Value Then
  optC = "3" + IIf(Trim(Txtrut.Text) = "", Format(Date, "YYYYMMDD"), Format(gsbac_fecp, "YYYYMMDD"))
 End If
 
  optO = "user1"
 If optOrdena(1).Value Then
  optO = "evento"
 ElseIf optOrdena(2).Value Then
  optO = "fechapro"
 ElseIf optOrdena(3).Value Then
  optO = "pantalla"
 End If
 If optFt <> "1" Then optFi = ""
     Sql = "sp_bclog '" & optC & "' ,'" & optO & "' ,'" & optFi & "','" & optFd & "'"
  If MISQL.SQL_Execute(Sql) <> 0 Then
 
    Exit Sub
  End If
    'BacControlWindows 100
 Do While MISQL.SQL_Fetch(Datos()) = 0
  i = 0

 Loop
  If i <> 0 Then
   MsgBox "No se encontraron datos con la selecci?n deseada", 16, " Bac-Cambio "
'   txtFecDesde.Text = Format$(gsBAC_Fecp, gsc_FechaDMA)
'   txtFecHasta.Text = Format$(gsBAC_Fecp, gsc_FechaDMA)
   optFi = ""
   Exit Sub
  End If
 
  Txtrut.Visible = False
  Fconsulta(2).Visible = False
  Fordenado(1).Visible = False
  Ffiltros(0).Visible = False
  Fgrid(4).Top = 30
  Fgrid(4).Left = 90
  Fgrid(4).Height = 4080
  
 End Sub

Private Sub CmdLimpiar_Click()
  Txtrut = " "
'  txtFecDesde.Text = Format$(gsBAC_Fecp, gsc_FechaDMA)
'  txtFecHasta.Text = Format$(gsBAC_Fecp, gsc_FechaDMA)
  Fconsulta(2).Visible = True
  Fordenado(1).Visible = True
  Ffiltros(0).Visible = True
  Txtrut.Visible = True
  Txtrut.Enabled = True
  Txtrut.SetFocus
  Fconsulta(2).Visible = True
  Fordenado(1).Visible = True
  Ffiltros(0).Visible = True
  nPos = 0

  Fgrid(4).Top = 1305
  Fgrid(4).Height = 2850

End Sub

Private Sub cmdSalir_Click()
 Unload Me
End Sub

Private Sub optConsulta_Click(Index As Integer, Value As Integer)
 If optConsulta(0).Value Then
  Txtrut.Enabled = True
  Txtrut.SetFocus
  Ffiltros(0).Enabled = True
 ElseIf optConsulta(1).Value Then
  Ffiltros(0).Enabled = True
  Txtrut.Enabled = True
  Txtrut.SetFocus
 ElseIf optConsulta(2).Value Then
  Ffiltros(0).Enabled = False
  Txtrut.Enabled = True
  Txtrut.SetFocus
 End If
End Sub

