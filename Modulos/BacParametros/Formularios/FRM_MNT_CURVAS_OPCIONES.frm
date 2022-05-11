VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form FRM_MNT_CURVAS_OPCIONES 
   Caption         =   "Smile"
   ClientHeight    =   5940
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   5400
   LinkTopic       =   "Form2"
   MDIChild        =   -1  'True
   ScaleHeight     =   5940
   ScaleWidth      =   5400
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   16
      Top             =   0
      Width           =   5400
      _ExtentX        =   9525
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   2
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   1800
      Top             =   120
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
            Picture         =   "FRM_MNT_CURVAS_OPCIONES.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_MNT_CURVAS_OPCIONES.frx":0EDA
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin Threed.SSPanel Flood 
      Align           =   2  'Align Bottom
      Height          =   315
      Left            =   0
      TabIndex        =   10
      Top             =   5625
      Width           =   5400
      _Version        =   65536
      _ExtentX        =   9525
      _ExtentY        =   556
      _StockProps     =   15
      ForeColor       =   -2147483634
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BorderWidth     =   1
      BevelInner      =   1
      FloodType       =   1
      FloodColor      =   -2147483635
   End
   Begin VB.Frame CuadroFecha 
      Height          =   1845
      Left            =   0
      TabIndex        =   0
      Top             =   435
      Width           =   5400
      Begin VB.ComboBox CmbDelta 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         ItemData        =   "FRM_MNT_CURVAS_OPCIONES.frx":11F4
         Left            =   1560
         List            =   "FRM_MNT_CURVAS_OPCIONES.frx":1201
         Style           =   2  'Dropdown List
         TabIndex        =   13
         TabStop         =   0   'False
         Top             =   1440
         Width           =   3345
      End
      Begin VB.ComboBox CmbEstructura 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   1560
         Style           =   2  'Dropdown List
         TabIndex        =   12
         TabStop         =   0   'False
         Top             =   1080
         Width           =   3345
      End
      Begin MSComctlLib.Toolbar Toolbar2 
         Height          =   270
         Left            =   4950
         TabIndex        =   9
         Top             =   390
         Width           =   300
         _ExtentX        =   529
         _ExtentY        =   476
         ButtonWidth     =   609
         ButtonHeight    =   582
         AllowCustomize  =   0   'False
         Style           =   1
         _Version        =   393216
         BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
            NumButtons      =   1
            BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
               Object.ToolTipText     =   "REFRESCAR"
               ImageIndex      =   1
            EndProperty
         EndProperty
      End
      Begin VB.ComboBox CmbParMda 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   1560
         Style           =   2  'Dropdown List
         TabIndex        =   4
         TabStop         =   0   'False
         Top             =   735
         Width           =   3345
      End
      Begin BACControles.TXTFecha Fecha 
         Height          =   315
         Left            =   1560
         TabIndex        =   2
         TabStop         =   0   'False
         Top             =   255
         Width           =   1320
         _ExtentX        =   2328
         _ExtentY        =   556
         Enabled         =   -1  'True
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "25/01/2007"
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Delta"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   3
         Left            =   120
         TabIndex        =   15
         Top             =   1485
         Width           =   375
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Estructura"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   2
         Left            =   120
         TabIndex        =   14
         Top             =   1125
         Width           =   750
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Par de Monedas"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   1
         Left            =   120
         TabIndex        =   3
         Top             =   750
         Width           =   1155
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Fecha"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   0
         Left            =   120
         TabIndex        =   1
         Top             =   270
         Width           =   435
      End
   End
   Begin VB.Frame CuadroDetalle 
      Enabled         =   0   'False
      Height          =   3390
      Left            =   0
      TabIndex        =   5
      Top             =   2205
      Width           =   5400
      Begin VB.ComboBox oComboBox 
         BackColor       =   &H8000000D&
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000E&
         Height          =   330
         Left            =   2925
         Style           =   2  'Dropdown List
         TabIndex        =   11
         Top             =   750
         Visible         =   0   'False
         Width           =   915
      End
      Begin BACControles.TXTNumero NumeroGrid 
         Height          =   270
         Left            =   2055
         TabIndex        =   8
         Top             =   765
         Visible         =   0   'False
         Width           =   885
         _ExtentX        =   1561
         _ExtentY        =   476
         BackColor       =   -2147483635
         ForeColor       =   -2147483634
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0"
         Text            =   "0"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin MSFlexGridLib.MSFlexGrid Grid 
         Height          =   2910
         Left            =   30
         TabIndex        =   7
         Top             =   435
         Width           =   5340
         _ExtentX        =   9419
         _ExtentY        =   5133
         _Version        =   393216
         Cols            =   3
         FixedCols       =   0
         BackColor       =   -2147483633
         ForeColor       =   -2147483641
         BackColorFixed  =   -2147483646
         ForeColorFixed  =   -2147483639
         BackColorBkg    =   -2147483636
         Enabled         =   -1  'True
         FocusRect       =   0
         GridLines       =   2
         GridLinesFixed  =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin VB.Label Descripcion 
         Alignment       =   2  'Center
         BackColor       =   &H80000002&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "Nombre Curva"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000009&
         Height          =   300
         Left            =   45
         TabIndex        =   6
         Top             =   135
         Width           =   5280
      End
   End
End
Attribute VB_Name = "FRM_MNT_CURVAS_OPCIONES"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim grilla()
Dim oMensaje   As String

Private Sub NombresGrilla()
   Let Grid.Rows = 2:         Let Grid.FixedRows = 1
   Let Grid.Cols = 8:         Let Grid.FixedCols = 0

   Let Grid.Font.Name = "Tahoma"
   Let Grid.Font.Size = 8
   Let Grid.RowHeightMin = 315

   Let Grid.TextMatrix(0, 0) = "Dias":        Let Grid.ColWidth(0) = 1000: Let Grid.ColAlignment(0) = flexAlignRightCenter
   Let Grid.TextMatrix(0, 1) = "Valor BID":   Let Grid.ColWidth(1) = 1000: Let Grid.ColAlignment(1) = flexAlignRightCenter
   Let Grid.TextMatrix(0, 2) = "Valor ASK":   Let Grid.ColWidth(2) = 1000: Let Grid.ColAlignment(2) = flexAlignRightCenter
   Let Grid.TextMatrix(0, 3) = "Mid":         Let Grid.ColWidth(3) = 800:  Let Grid.ColAlignment(3) = flexAlignRightCenter
   Let Grid.TextMatrix(0, 4) = "Fecha":       Let Grid.ColWidth(4) = 0:    Let Grid.ColAlignment(4) = flexAlignRightCenter
   Let Grid.TextMatrix(0, 5) = "Estructura":  Let Grid.ColWidth(5) = 0:    Let Grid.ColAlignment(5) = flexAlignRightCenter
   Let Grid.TextMatrix(0, 6) = "Delta":       Let Grid.ColWidth(6) = 0:    Let Grid.ColAlignment(6) = flexAlignRightCenter
   Let Grid.TextMatrix(0, 7) = "ParParidad":  Let Grid.ColWidth(7) = 0:    Let Grid.ColAlignment(7) = flexAlignRightCenter

   Let Grid.Rows = 1
End Sub

Private Sub CmbParMda_Click()
   Let Descripcion.Caption = ""
   Let CuadroDetalle.Enabled = True
   
   If CmbParMda.ListIndex = -1 Then
      Exit Sub
   End If
   
   Let Descripcion.Caption = CmbParMda.Text
   Let CuadroDetalle.Enabled = True
End Sub

Private Sub Form_Load()
   Let Me.Icon = BACSwapParametros.Icon
   Let Me.Top = 0:       Let Me.Left = 0
   Let Me.Height = 5550: Let Me.Width = 5520

   Let Descripcion.Caption = "<< Sin Selección >>"
   Let Fecha.Text = Format(gsbac_fecp, "dd/mm/yyyy")

   Call NombresGrilla
   Call CargaCombos
   
   Let Flood.FloodPercent = 0
End Sub

Private Sub CargaCombos()
   Dim Datos()

   Envia = Array()
   AddParam Envia, CDbl(0)
   If Not Bac_Sql_Execute("SP_MNT_CURVAS_OPCIONES", Envia) Then
      Exit Sub
   End If
   Call CmbParMda.Clear
   Do While Bac_SQL_Fetch(Datos())
      Call CmbParMda.AddItem(Trim(Datos(1)) & String(80 - Len(Trim(Datos(1))), " "))
   Loop
      
   Envia = Array()
   AddParam Envia, CDbl(1)
   If Not Bac_Sql_Execute("SP_MNT_CURVAS_OPCIONES", Envia) Then
      Exit Sub
   End If
   Call CmbEstructura.Clear
   Do While Bac_SQL_Fetch(Datos())
      Call CmbEstructura.AddItem(Trim(Datos(2)) & Space(80) & Datos(1))
   Loop
   
  CmbParMda.ListIndex = 0
  CmbEstructura.ListIndex = 0
  CmbDelta.ListIndex = 0
   
   Call ConsultaCurvasOpciones

End Sub


Private Sub Form_Resize()
   On Error Resume Next
   Let CuadroFecha.Width = Me.Width - 150
   Let CuadroDetalle.Width = CuadroFecha.Width
   Let Grid.Width = CuadroDetalle.Width - 130
   Let Descripcion.Width = Grid.Width - 25
   Let CuadroDetalle.Height = Me.Height - 3000
   Let Grid.Height = CuadroDetalle.Height - 500
   On Error GoTo 0
End Sub



Public Sub ConsultaCurvasOpciones()
   Dim cParMda     As String
   Dim cEstructura As String
   Dim nDelta      As Long
   Dim dFecha      As Date
   Dim Datos()
   
   Let dFecha = CDate(Fecha.Text)
   Let cParMda = Trim(Mid(CmbParMda.Text, 1, 50))
   Let cEstructura = Trim(Right(CmbEstructura, 10)) ''Trim(Mid(CmbEstructura.Text, 1, 100))
   Let nDelta = Val(Trim(CmbDelta.Text))
   
   Envia = Array()
   AddParam Envia, CDbl(2)
   AddParam Envia, Format(dFecha, "yyyymmdd")
   AddParam Envia, cParMda
   AddParam Envia, cEstructura
   AddParam Envia, nDelta
   If Not Bac_Sql_Execute("SP_MNT_CURVAS_OPCIONES", Envia) Then
      Call MsgBox("Acción Error." & vbCrLf & vbCrLf & "Error en la consulta de valores a la fecha.", vbExclamation, App.Title)
      Exit Sub
   End If
   Let Grid.Rows = Grid.FixedRows
   Do While Bac_SQL_Fetch(Datos())
        Let Grid.Rows = Grid.Rows + 1
        Let Grid.TextMatrix(Grid.Rows - 1, 0) = Format(Datos(1), FEntero)  '--> Dias
        Let Grid.TextMatrix(Grid.Rows - 1, 1) = Format(Datos(2), FDecimal) '--> Bid
        Let Grid.TextMatrix(Grid.Rows - 1, 2) = Format(Datos(3), FDecimal) '--> Ask
        Let Grid.TextMatrix(Grid.Rows - 1, 3) = Datos(4)                   '--> Curva
   Loop
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index
      Case 1
        If VerififcaSistemaOpciones = True Then
           Call ConsultaCurvasOpciones
        Else
           Call MsgBox("No existe información en Módulo Opciones." & vbCrLf & vbCrLf & "Módulo no se encuentra Operativo.", vbInformation, TITSISTEMA)
        End If
      Case 2
         Unload Me

End Select

End Sub


Public Sub CargarCurvasOpciones(Cont As Long)
'20090421 - Ingreso de Curvas para Opciones
'--
Dim cParMda          As String
Dim cEstructura      As String
Dim iDelta           As Long
Dim iPeriodo         As Double
Dim iBid             As Double
Dim iAsk             As Double
Dim iMid             As Double
Dim cMensaje         As String


  If Cont >= Grid.Rows Then
     Exit Sub
  End If

      Let iPeriodo = Grid.TextMatrix(Cont, 0)
      Let iBid = CDbl(Grid.TextMatrix(Cont, 1))
      Let iAsk = CDbl(Grid.TextMatrix(Cont, 2))
      Let iMid = CDbl(Grid.TextMatrix(Cont, 3))
      Let cEstructura = Trim(Right(Grid.TextMatrix(Cont, 5), 10))
      Let iDelta = CDbl(Grid.TextMatrix(Cont, 6))
      Let cParMda = Trim(Mid(Grid.TextMatrix(Cont, 7), 1, 7)) ''Grid.TextMatrix(iContador, 3)
      
      If ExistenciaPardeMoneda(cParMda, cMensaje) = True Then
         
         If CargaExcell(cParMda, cEstructura, iDelta, iPeriodo, iBid, iAsk, iMid) = False Then
            Let Me.MousePointer = vbDefault
            Let Screen.MousePointer = vbDefault
            Let Toolbar1.Enabled = True
            Let Grid.Rows = 1
            Let Grid.Redraw = True
            Let Flood.Visible = False
            Call MsgBox("E - Error en la Validación de Tipo y Origen." & vbCrLf & vbCrLf & oMensaje, vbExclamation, App.Title)
            Exit Sub
         End If
         
      End If


'--

End Sub
Public Function ExistenSmile() As Boolean
   Dim Datos()
   
   ExistenSmile = False
   
   Envia = Array()
   AddParam Envia, CDbl(3)
   AddParam Envia, Format(gsbac_fecp, "yyyymmdd")
       If Not Bac_Sql_Execute("SP_MNT_CURVAS_OPCIONES", Envia) Then
      Exit Function
   End If
   If Bac_SQL_Fetch(Datos()) Then
      If Datos(1) < 0 Then
         If MsgBox("Carga de Curvas ." & vbCrLf & vbCrLf & Datos(2) & vbCrLf & vbCrLf & "¿ Desea volver a cargar ?", vbQuestion + vbYesNo, TITSISTEMA) = vbNo Then
            Let ExistenSmile = True
         End If
      End If
   End If
End Function
Public Function ExistenciaPardeMoneda(cParMda As String, ByRef Mensaje As String) As Boolean
   Dim Datos()
   
   Let ExistenciaPardeMoneda = False
   
   Envia = Array()
   AddParam Envia, CDbl(4)
   AddParam Envia, Format(gsbac_fecp, "yyyymmdd")
   AddParam Envia, cParMda
   If Not Bac_Sql_Execute("SP_MNT_CURVAS_OPCIONES", Envia) Then
      Exit Function
   End If
   If Bac_SQL_Fetch(Datos()) Then
      If Datos(1) < 0 Then
         If InStr(1, Mensaje, cCurva) = 0 Then
            Let Mensaje = Mensaje & Datos(2) & vbCrLf
         End If
         Exit Function
      End If
   End If
   
   Let ExistenciaPardeMoneda = True
End Function

Public Function CargaExcell(ParMda As String, Estruc As String, Delta As Long, Plazo As Double, vBid As Double, vAsk As Double, vMid As Double) As Boolean
   Dim Datos()
   
   Let CargaExcell = False
   Let oMensaje = ""

      
   Envia = Array()
   AddParam Envia, CDbl(5)
   AddParam Envia, Format(Fecha.Text, "yyyymmdd")
   AddParam Envia, ParMda
   AddParam Envia, Estruc
   AddParam Envia, Delta
   AddParam Envia, CDbl(Plazo)
   AddParam Envia, CDbl(vBid)
   AddParam Envia, CDbl(vAsk)
   AddParam Envia, CDbl(vMid)
   If Not Bac_Sql_Execute("SP_MNT_CURVAS_OPCIONES", Envia) Then
      Exit Function
   End If
   
   Let CargaExcell = True
End Function

Public Sub EliminaCurvasOpciones(Fecha As Date)

''''   If MsgBox("Esperando Confirmación ..." & vbCrLf & vbCrLf & "¿ Esta seguro de Querer Eliminar en Forma Permanente la Curva ?", vbQuestion + vbYesNo, TITSISTEMA) = vbNo Then
''''      Exit Sub
''''   End If

   Envia = Array()
   AddParam Envia, CDbl(6)
   AddParam Envia, Format(Fecha, "yyyymmdd")
   If Not Bac_Sql_Execute("SP_MNT_CURVAS_OPCIONES", Envia) Then
      MsgBox "Error." & vbCrLf & vbCrLf & "... Error en la Eliminación de Par de Moneda.", vbExclamation, TITSISTEMA
      Exit Sub
   End If

''''   Call MsgBox("Tarea Finalizada." & vbCrLf & vbCrLf & "Par de Monedas para fecha proceso ha sido Eliminado ...", vbInformation, App.Title)
   Let CmbParMda.ListIndex = -1
   Let Grid.Rows = 1
End Sub
