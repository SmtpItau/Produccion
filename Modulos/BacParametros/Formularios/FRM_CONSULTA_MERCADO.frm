VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "Comdlg32.ocx"
Begin VB.Form FRM_CONSULTA_MERCADO 
   Caption         =   "Consulta de Operaciones"
   ClientHeight    =   6030
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   9750
   LinkTopic       =   "Form2"
   MDIChild        =   -1  'True
   ScaleHeight     =   6030
   ScaleWidth      =   9750
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   660
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   9750
      _ExtentX        =   17198
      _ExtentY        =   1164
      ButtonWidth     =   1667
      ButtonHeight    =   1111
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   10
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Buscar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Caption         =   "Vista Previa"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Caption         =   "Impresora"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Caption         =   "Excell"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Cerrar"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button8 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Caption         =   "Modifica"
            ImageIndex      =   6
            Style           =   5
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   2
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
                  Text            =   "Oficina Cambio"
               EndProperty
               BeginProperty ButtonMenu2 {66833FEE-8583-11D1-B16A-00C0F0283628} 
                  Text            =   "Comex"
               EndProperty
            EndProperty
         EndProperty
         BeginProperty Button9 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Caption         =   "Interfaz"
            ImageIndex      =   7
         EndProperty
         BeginProperty Button10 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Enviar"
            ImageIndex      =   8
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComDlg.CommonDialog Commando 
         Left            =   9150
         Top             =   75
         _ExtentX        =   847
         _ExtentY        =   847
         _Version        =   393216
      End
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   8415
         Top             =   30
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   8
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_CONSULTA_MERCADO.frx":0000
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_CONSULTA_MERCADO.frx":0EDA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_CONSULTA_MERCADO.frx":1DB4
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_CONSULTA_MERCADO.frx":2C8E
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_CONSULTA_MERCADO.frx":3B68
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_CONSULTA_MERCADO.frx":3E82
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_CONSULTA_MERCADO.frx":4D5C
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_CONSULTA_MERCADO.frx":5C36
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame MarcoFiltro 
      Height          =   750
      Left            =   30
      TabIndex        =   1
      Top             =   585
      Width           =   9720
      Begin VB.CheckBox chkMark 
         Caption         =   "SELECIONA TODOS"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Left            =   105
         TabIndex        =   11
         Top             =   465
         Width           =   1995
      End
      Begin BACControles.TXTFecha FechaDesde 
         Height          =   300
         Left            =   4785
         TabIndex        =   8
         Top             =   375
         Width           =   1515
         _ExtentX        =   2672
         _ExtentY        =   529
         Enabled         =   -1  'True
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "14/06/2007"
      End
      Begin VB.OptionButton OptOpciones 
         Caption         =   "Ambas"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Index           =   2
         Left            =   2910
         TabIndex        =   5
         Top             =   195
         Width           =   945
      End
      Begin VB.OptionButton OptOpciones 
         Caption         =   "Confirmadas"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Index           =   1
         Left            =   1440
         TabIndex        =   4
         Top             =   195
         Width           =   1395
      End
      Begin VB.OptionButton OptOpciones 
         Caption         =   "Pendientes"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Index           =   0
         Left            =   105
         TabIndex        =   3
         Top             =   195
         Width           =   1260
      End
      Begin BACControles.TXTFecha FechaHasta 
         Height          =   300
         Left            =   6345
         TabIndex        =   9
         Top             =   360
         Width           =   1440
         _ExtentX        =   2540
         _ExtentY        =   529
         Enabled         =   -1  'True
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "14/06/2007"
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Fecha Hasta"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   1
         Left            =   6345
         TabIndex        =   7
         Top             =   165
         Width           =   1035
      End
      Begin VB.Label Etiquetas 
         AutoSize        =   -1  'True
         Caption         =   "Fecha Desde"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Index           =   0
         Left            =   4785
         TabIndex        =   6
         Top             =   180
         Width           =   1065
      End
   End
   Begin VB.Frame MarcoOperaciones 
      Height          =   4770
      Left            =   30
      TabIndex        =   2
      Top             =   1260
      Width           =   9720
      Begin MSComctlLib.ListView Listado 
         Height          =   4590
         Left            =   30
         TabIndex        =   10
         Top             =   135
         Width           =   9630
         _ExtentX        =   16986
         _ExtentY        =   8096
         View            =   3
         LabelEdit       =   1
         LabelWrap       =   0   'False
         HideSelection   =   0   'False
         Checkboxes      =   -1  'True
         FullRowSelect   =   -1  'True
         _Version        =   393217
         ForeColor       =   -2147483640
         BackColor       =   -2147483643
         BorderStyle     =   1
         Appearance      =   1
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         NumItems        =   0
      End
   End
End
Attribute VB_Name = "FRM_CONSULTA_MERCADO"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim oEstado       As String
Dim Origen        As Integer
Public iConfirma  As Boolean

Const OF_CAMBIO = 1
Const COMEX = 2

Const nEstado = 1
Const nOperacion = 2
Const nTipOper = 3
Const nTipMerc = 4
Const nMoneda = 5
Const nMontoMx = 6
Const nMontoLiq = 7
Const nTCCambio = 8
Const nParidad = 9
Const nOperador = 10
Const nIngreso = 11
Const nConfirma = 12
Const MercadoReal = 13

Private Enum TipoCaracter
    [Numerico] = 0
    [Caracter] = 1
    [AlfaNumerico] = 2
    [Fecha] = 3
End Enum

Private Sub Nombres()
   Listado.ColumnHeaders.Clear
   Listado.ColumnHeaders.Add nEstado, "A", "Estado", 1500
   Listado.ColumnHeaders.Add nOperacion, "B", "N° Operación", 1600
   Listado.ColumnHeaders.Add nTipOper, "C", "Tipo Operación", 1600
   Listado.ColumnHeaders.Add nTipMerc, "D", "Mercado", 1200
   Listado.ColumnHeaders.Add nMoneda, "E", "Moneda", 800
   Listado.ColumnHeaders.Add nMontoMx, "F", "Monto MX", 1600
   Listado.ColumnHeaders.Add nMontoLiq, "G", "Monto Liquidado", 1700
   Listado.ColumnHeaders.Add nTCCambio, "H", "Tipo Cambio", 1000
   Listado.ColumnHeaders.Add nParidad, "I", "Paridad", 1000
   Listado.ColumnHeaders.Add nOperador, "J", "Usuario", 1300
   Listado.ColumnHeaders.Add nIngreso, "K", "Fecha Ingreso", 1200
   Listado.ColumnHeaders.Add nConfirma, "L", "Fecha Confirmación", 1200
   Listado.ColumnHeaders.Add MercadoReal, "M", "Mercado SPOT", 1200
End Sub

Private Sub chkMark_Click()
   Dim iContador  As Long

   If chkMark.Value = 1 Then
      chkMark.Caption = "DESMARCAR TODOS"
   Else
      chkMark.Caption = "MARCAR TODOS"
   End If

   For iContador = 1 To Listado.ListItems.Count
      Let Listado.ListItems.Item(iContador).Checked = IIf(chkMark.Value = 1, True, False)
   Next iContador

End Sub

Private Sub Form_Load()
   Me.Icon = BACSwapParametros.Icon
   
   FechaDesde.Text = gsbac_fecp
   FechaHasta.Text = gsbac_fecp
   
   oEstado = ""
   Call Nombres
End Sub

Private Sub Form_Resize()
   On Error Resume Next
   Let MarcoFiltro.Width = Me.Width - 150
   Let MarcoOperaciones.Width = MarcoFiltro.Width
   Let MarcoOperaciones.Height = Me.Height - (MarcoFiltro.Height + 950)
   Let Listado.Width = MarcoOperaciones.Width - 100
   Let Listado.Height = MarcoOperaciones.Height - 250
   On Error GoTo 0
End Sub

Private Sub CargaPantalla()
   
   Screen.MousePointer = vbHourglass
   
   Call Bac_Sql_Execute("dbo.SP_OPERACIONES_MERCADO_CAMBIARIO")
   
   Toolbar1.Buttons.Item(3).Enabled = False
   Toolbar1.Buttons.Item(4).Enabled = False
   Toolbar1.Buttons.Item(5).Enabled = False
   Toolbar1.Buttons.Item(8).Enabled = False
   Toolbar1.Buttons.Item(9).Enabled = False
   
   Envia = Array()
   AddParam Envia, CDbl(1)
   AddParam Envia, Format(FechaDesde.Text, "YYYYMMDD")
   AddParam Envia, Format(FechaHasta.Text, "YYYYMMDD")
   AddParam Envia, IIf(oEstado = "C", "E", oEstado)
   If Not Bac_Sql_Execute("dbo.SP_CONSULTA_MERCADOCAMBIARIO", Envia) Then
      Exit Sub
   End If
   Listado.ListItems.Clear
   Do While Bac_SQL_Fetch(Datos())
      Listado.ListItems.Add , , Datos(nEstado)
      Listado.ListItems.Item(Listado.ListItems.Count).ListSubItems.Add , , Datos(nOperacion)
      Listado.ListItems.Item(Listado.ListItems.Count).ListSubItems.Add , , Datos(nTipOper)
      Listado.ListItems.Item(Listado.ListItems.Count).ListSubItems.Add , , Datos(nTipMerc)
      Listado.ListItems.Item(Listado.ListItems.Count).ListSubItems.Add , , Datos(nMoneda)
      Listado.ListItems.Item(Listado.ListItems.Count).ListSubItems.Add , , Format(Datos(nMontoMx), FDecimal)
      Listado.ListItems.Item(Listado.ListItems.Count).ListSubItems.Add , , Format(Datos(nMontoLiq), FDecimal)
      Listado.ListItems.Item(Listado.ListItems.Count).ListSubItems.Add , , Format(Datos(nTCCambio), FDecimal)
      Listado.ListItems.Item(Listado.ListItems.Count).ListSubItems.Add , , Format(Datos(nParidad), FDecimal)
      Listado.ListItems.Item(Listado.ListItems.Count).ListSubItems.Add , , Datos(nOperador)
      Listado.ListItems.Item(Listado.ListItems.Count).ListSubItems.Add , , Datos(nIngreso)
      Listado.ListItems.Item(Listado.ListItems.Count).ListSubItems.Add , , Datos(nConfirma)
      Listado.ListItems.Item(Listado.ListItems.Count).ListSubItems.Add , , Datos(MercadoReal)
   Loop
   If Listado.ListItems.Count > 0 Then
      Toolbar1.Buttons.Item(3).Enabled = True
      Toolbar1.Buttons.Item(4).Enabled = True
      Toolbar1.Buttons.Item(5).Enabled = True
      Toolbar1.Buttons.Item(8).Enabled = True
      Toolbar1.Buttons.Item(9).Enabled = True
   End If
   Screen.MousePointer = vbDefault
End Sub

Private Sub Listado_ColumnClick(ByVal ColumnHeader As MSComctlLib.ColumnHeader)
   Dim iContador  As Long
   
   If ColumnHeader = "Estado" Then
      Static iCheck As Integer
      If iCheck = 0 Then
         iCheck = 1
      Else
         iCheck = 0
      End If
      
      For iContador = 1 To Listado.ListItems.Count - 1
         Listado.ListItems.Item(iContador).Checked = IIf(iCheck = 0, False, True)
      Next iContador
   End If
End Sub

Private Sub OptOpciones_Click(Index As Integer)
   oEstado = Left(OptOpciones.Item(Index).Caption, 1)
   oEstado = IIf(oEstado = "A", "", oEstado)
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 2
         Call CargaPantalla
      Case 3
         Call GeneraInforme(crptToWindow)
      Case 4
         Call GeneraInforme(crptToPrinter)
      Case 5
         Call GeneraExcell
      Case 6
         Unload Me
      Case 9
         Call Interfaz
      Case 10
         Call EnviarOperaciones
   End Select
End Sub

Private Sub GeneraInforme(xDestino As DestinationConstants)
   On Error GoTo errorimpresion
   Dim dFechaDesde   As String
   Dim dFechaHasta   As String
   Dim oEstado       As String
   Dim iContador     As Integer
   
   Let dFechaDesde = FechaDesde.Text
   Let dFechaHasta = FechaHasta.Text
   
   Let oEstado = ""
   If OptOpciones.Item(0).Value = True Then
      Let oEstado = Left(OptOpciones.Item(0).Caption, 1)
   ElseIf OptOpciones.Item(1).Value = True Then
      Let oEstado = Left(OptOpciones.Item(1).Caption, 1)
   End If

   Call limpiar_cristal
   BACSwapParametros.BACParam.ReportFileName = gsRPT_Path & "Informe_Op_Confirmadas.rpt"
   BACSwapParametros.BACParam.StoredProcParam(0) = Format(dFechaDesde, "yyyy-mm-dd 00:00:00.000")
   BACSwapParametros.BACParam.StoredProcParam(1) = Format(dFechaHasta, "yyyy-mm-dd 00:00:00.000")
   BACSwapParametros.BACParam.StoredProcParam(2) = oEstado
   BACSwapParametros.BACParam.StoredProcParam(3) = gsbac_fecp
   BACSwapParametros.BACParam.Destination = xDestino
   BACSwapParametros.BACParam.Connect = SwConeccion
   BACSwapParametros.BACParam.WindowState = crptMaximized
   BACSwapParametros.BACParam.Action = 1
   
   On Error GoTo 0
   
Exit Sub
errorimpresion:
   MsgBox "Problemas en la impresión " & vbCrLf & vbcrl & BACSwapParametros.BACParam.LastErrorString, vbExclamation, TITSISTEMA
   On Error GoTo 0
End Sub

Private Sub Toolbar1_ButtonMenuClick(ByVal ButtonMenu As MSComctlLib.ButtonMenu)
   Dim iContador  As Long

   Select Case ButtonMenu.Index
      Case 1:  Let Origen = OF_CAMBIO
      Case 2:  Let Origen = COMEX
   End Select

   For iContador = 1 To Listado.ListItems.Count
      If Listado.ListItems.Item(iContador).Checked = True Then
         Envia = Array()
         AddParam Envia, CDbl(3)
         AddParam Envia, Format(FechaDesde.Text, "YYYYMMDD")
         AddParam Envia, Format(FechaHasta.Text, "YYYYMMDD")
         AddParam Envia, oEstado
         AddParam Envia, CDbl(Listado.ListItems(iContador).ListSubItems(1).Text)
         AddParam Envia, Origen
         If Not Bac_Sql_Execute("dbo.SP_CONSULTA_MERCADOCAMBIARIO", Envia) Then
            MsgBox "Problemas al asignar Mercado Cambiario.", vbExclamation, TITSISTEMA
         End If
         Let Listado.ListItems(iContador).ListSubItems(nTipMerc - 1).Text = IIf(Origen = 1, "OF. CAMBIO", "COMEX")
      End If
   Next iContador

   chkMark.Value = 0
   chkMark.Caption = "MARCAR TODOS"
End Sub

Private Function ValidaMercado() As Boolean
   Dim iContador  As Long
   Dim oDesmarca  As Boolean
   Dim Mensaje    As String
   Dim oRespuesta As Integer
   Dim Datos()
   
   Let oDesmarca = False
   Let Mensaje = ""
   
   Let ValidaMercado = False
   
Desmarca:
   For iContador = 1 To Listado.ListItems.Count
      If Listado.ListItems.Item(iContador).Checked = True Then
         
         Envia = Array()
         AddParam Envia, Format(gsbac_fecp, "yyyymmdd")
         AddParam Envia, CDbl(Listado.ListItems(iContador).ListSubItems(nOperacion - 1).Text)
         AddParam Envia, "V"
         If Bac_Sql_Execute("dbo.SP_SERVICIO_POSCAM", Envia) Then
            If Bac_SQL_Fetch(Datos()) Then
               If Datos(1) < 0 And oDesmarca = False Then
                  Mensaje = Mensaje & "- Operación : " & CDbl(Listado.ListItems(iContador).ListSubItems(nOperacion - 1).Text)
               End If
               If Datos(1) < 0 And oDesmarca = True Then
                  Listado.ListItems.Item(iContador).Checked = False
               End If
            End If
         End If
         
      End If
   Next iContador


   If Len(Mensaje) > 0 Then
      Let oRespuesta = MsgBox("¡ Existen Operaciones Seleccionadas Sin Mercado Definido !" & vbcrl & vbCrLf & "¿ Desea Enviar Estas Operaciones. ?", vbQuestion + vbYesNo, TITSISTEMA)

      If oRespuesta = vbYes Then
         Let ValidaMercado = True
         Exit Function
      End If

      If oRespuesta = vbCancel Then
         Let ValidaMercado = False
         Exit Function
      End If

      If oRespuesta = vbNo Then
         Let ValidaMercado = False
         Exit Function
      End If
   Else
      Let ValidaMercado = True
   End If

End Function

Private Function EnviarOperaciones() As Boolean
   Dim oNumero    As Double
   Dim iContador  As Long
   Dim POSCAM     As New PosicionCambio
   Dim oMensaje   As String
   Dim oMsgBox    As String
   Dim oOperacin  As String
   Dim oEstado    As String
   Dim Datos()
   
   If ValidaMercado = False Then
      Exit Function
   End If
   
   Let oMsgBox = ""
   Let oOperacin = ""
   
   For iContador = 1 To Listado.ListItems.Count

      Let oMensaje = ""
      If Listado.ListItems.Item(iContador).Checked = True Then
         
         Let oNumero = CDbl(Listado.ListItems(iContador).ListSubItems(nOperacion - 1).Text)
         Let oOperacin = oOperacin & "- " & oNumero & vbCrLf

         Envia = Array()
         AddParam Envia, Format(gsbac_fecp, "yyyymmdd")
         AddParam Envia, oNumero
         If Bac_Sql_Execute("dbo.SP_SERVICIO_POSCAM", Envia) Then
            If Bac_SQL_Fetch(Datos()) Then
               Let oEstado = Datos(22)
               If POSCAM.Llenar_Clase(Datos()) = True Then
                  If POSCAM.Enviar_Mensaje(oEstado) = True Then
                     If CambiarEstadoEnvio(CDbl(Listado.ListItems(iContador).ListSubItems(nOperacion - 1).Text)) = False Then
                        GoSub ErroCambioEstado
                     End If
                  Else
                     GoSub ErrorEnvio
                  End If 'Enviar
               Else
                  GoSub ErrorLlenar
               End If 'Llenar

            Else
               GoSub NoInformacion
            End If 'Fetch

         Else
            GoSub NoInformacion
         End If 'Execute

      End If 'Checked = True

      If Len(oMensaje) > 0 Then
         Let oMsgBox = oMsgBox & oMensaje & vbCrLf & vbCrLf
      End If
   Next iContador

   If Len(oMsgBox) > 0 Then
      MsgBox "Emisión de Mensajes Finalizada con Errores" & vbCrLf & vbCrLf & oMsgBox, vbExclamation, TITSISTEMA
   Else
      MsgBox "Emisión de Mensajes Finalizada" & vbCrLf & vbCrLf & "Se Han Enviado Las Sgtes Operaciones." & vbCrLf & oOperacin, vbInformation, TITSISTEMA
   End If

   Call CargaPantalla

Exit Function
NoInformacion:
   Let oMensaje = oMensaje & " - A - Advertencia." & vbTab & " No se encontro información para la Op. " & oNumero & vbCrLf
   Return
   
ErrorLlenar:
   Let oMensaje = oMensaje & " - E - Error." & vbTab & " No se pudo cargar información al servicio de envío para Op. " & oNumero & vbCrLf
   Return
   
ErrorEnvio:
   Let oMensaje = oMensaje & " - E - Error." & vbTab & " No se pudo enviar Op. " & oNumero & vbCrLf
   Return

ErroCambioEstado:
   Let oMensaje = oMensaje & " - A - Advertencia." & vbTab & " No se pudo cambiar el estado a la Op. " & oNumero & vbCrLf
   Return
End Function


Private Function CambiarEstadoEnvio(ByVal Numero_ As Long) As Boolean

   CambiarEstadoEnvio = True

   Envia = Array()
   AddParam Envia, Format(gsbac_fecp, "yyyymmdd")
   AddParam Envia, Numero_
   AddParam Envia, "S"
   If Not Bac_Sql_Execute("dbo.SP_SERVICIO_POSCAM", Envia) Then
      CambiarEstadoEnvio = False
   End If

End Function

Private Sub GeneraExcell()
   On Error GoTo ErrorGeneracion
   Dim iContador        As Long
   Dim Archivo          As String
   Dim Estado           As String
   Dim Datos()
   
   Dim MiExcell         As New Excel.Application
   Dim MiLibro          As New Excel.Workbook
   Dim MiHoja           As New Excel.Worksheet
   Dim MiSheet          As Object
   
   Commando.CancelError = True
   Commando.ShowSave
   
   Set MiExcell = CreateObject("Excel.Application")
   Set MiLibro = MiExcell.Application.Workbooks.Add
   Set MiHoja = MiLibro.Sheets.Add
   Set MiSheet = MiExcell.ActiveSheet
   
   If Dir(Commando.FileName & ".XLS") <> "" Then
      Call Kill(Commando.FileName & ".XLS")
   End If
   
   MiSheet.Name = "Operaciones."

   Let Estado = ""
   If OptOpciones.Item(0).Value = True Then
      Let Estado = Left(OptOpciones.Item(0).Caption, 1)
   ElseIf OptOpciones.Item(1).Value = True Then
      Let Estado = Left(OptOpciones.Item(1).Caption, 1)
   End If
   
   Envia = Array()
   AddParam Envia, Format(FechaDesde.Text, "YYYYMMDD")
   AddParam Envia, Format(FechaHasta.Text, "YYYYMMDD")
   AddParam Envia, Estado
   AddParam Envia, gsBAC_User
   If Not Bac_Sql_Execute("dbo.SP_INFORME_OPMERCAMBIARIO", Envia) Then
      Exit Sub
   End If
   Let iContador = 0
   Do While Bac_SQL_Fetch(Datos())
      iContador = iContador + 1
      MiHoja.Cells(iContador, "A") = Format(Datos(1), "dd-mm-yyyy")                             '--> Fecha
      MiHoja.Cells(iContador, "B") = Format(CDbl(Datos(2)), FEntero)                            '--> NumOperacion
      MiHoja.Cells(iContador, "C") = Datos(3)                                                   '--> TipoOperacion
      MiHoja.Cells(iContador, "D") = LTrim(Datos(4))                                            '--> RutCliente
      MiHoja.Cells(iContador, "E") = Datos(7)                                                   '--> Moneda Mx
      MiHoja.Cells(iContador, "F") = Format(Datos(8), FDecimal)                                 '--> Monto Moneda Mx
      MiHoja.Cells(iContador, "G") = LTrim(Datos(9))                                            '--> Moneda Cnv
      MiHoja.Cells(iContador, "H") = Format(Datos(10), FDecimal)                                '--> Monto Moneda Cnv
      MiHoja.Cells(iContador, "I") = Format(Datos(11), FDecimal)                                '--> Tipo Cambio
      MiHoja.Cells(iContador, "J") = Format(Datos(12), FDecimal)                                '--> Paridad
      MiHoja.Cells(iContador, "K") = IIf(Datos(13) = "--", 0, IIf(Datos(13) = "COMEX", 2, 1))   '--> Tipomercado
      MiHoja.Cells(iContador, "K") = Val(MiHoja.Cells(iContador, "K"))
      MiHoja.Cells(iContador, "L") = Datos(15)                                                  '--> Forma de Pago
      MiHoja.Cells(iContador, "M") = "P"                                                        '--> Estado
      MiHoja.Cells(iContador, "N") = Datos(17)                                                  '--> Usuario
   Loop
   
   MiHoja.SaveAs (Commando.FileName & ".XLS")
   MiHoja.Application.Workbooks.Close
   MiExcell.Application.Workbooks.Close
   
   Set MiExcell = Nothing
   Set MiLibro = Nothing
   Set MiHoja = Nothing

   On Error GoTo 0
Exit Sub
ErrorGeneracion:
   If Err.Number = 32755 Then
      Exit Sub
   Else
      MsgBox "Error en generación de planilla" & vbCrLf & vbCrLf & Err.Description, vbExclamation, TITSISTEMA
   End If
End Sub


Private Sub Interfaz()
   On Error GoTo ErrorGeneracion
   Dim iContador        As Long
   Dim Archivo          As String
   Dim Estado           As String
   Dim iFileHost        As String
   Dim oCadena          As String
   Dim Datos()

   Commando.CancelError = True
   Commando.FileName = "MERCADO_" & Format(gsbac_fecp, "YYYYMMDD")
   Commando.Filter = "*.Txt"
   
   Commando.ShowSave
   If Dir(Commando.FileName & ".TXT") <> "" Then
      Call Kill(Commando.FileName & ".TXT")
   End If

   iFileHost = FreeFile
   Open (Commando.FileName & ".TXT") For Output As iFileHost

   Let Estado = ""
   If OptOpciones.Item(0).Value = True Then
      Let Estado = Left(OptOpciones.Item(0).Caption, 1)
   ElseIf OptOpciones.Item(1).Value = True Then
      Let Estado = Left(OptOpciones.Item(1).Caption, 1)
   End If

   Envia = Array()
   AddParam Envia, Format(FechaDesde.Text, "YYYYMMDD")
   AddParam Envia, Format(FechaHasta.Text, "YYYYMMDD")
   AddParam Envia, Estado
   AddParam Envia, gsBAC_User
   If Not Bac_Sql_Execute("dbo.SP_INFORME_OPMERCAMBIARIO", Envia) Then
      Exit Sub
   End If
   Let iContador = 0
   Let oCadena = ""
   Do While Bac_SQL_Fetch(Datos())
      iContador = iContador + 1
      oCadena = ""
      oCadena = oCadena & fCampoInterfaz(Fecha, Datos(1), 8, 0)
      oCadena = oCadena & fCampoInterfaz(Numerico, Datos(2), 6, 0)
      oCadena = oCadena & fCampoInterfaz(Caracter, Datos(3), 6, 0)
      oCadena = oCadena & fCampoInterfaz(Numerico, Datos(4), 10, 0)
      oCadena = oCadena & fCampoInterfaz(Caracter, Datos(7), 3, 0)
      oCadena = oCadena & fCampoInterfaz(Numerico, CDbl(Datos(8)), 17, 4)
      oCadena = oCadena & fCampoInterfaz(Caracter, Datos(9), 3, 0)
      oCadena = oCadena & fCampoInterfaz(Numerico, CDbl(Datos(10)), 17, 4)
      oCadena = oCadena & fCampoInterfaz(Numerico, CDbl(Datos(11)), 15, 4)
      oCadena = oCadena & fCampoInterfaz(Numerico, CDbl(Datos(12)), 15, 4)
      oCadena = oCadena & IIf(Datos(13) = "--", 0, IIf(Datos(13) = "COMEX", 2, 1))
      oCadena = oCadena & fCampoInterfaz(Caracter, Datos(15), 30, 0)
      oCadena = oCadena & fCampoInterfaz(Caracter, "P", 1, 0)
      oCadena = oCadena & fCampoInterfaz(Caracter, Datos(17), 15, 0)

      Print #iFileHost, oCadena
   Loop
   Close #iFileHost

   On Error GoTo 0
   
   MsgBox "Aviso de generación" & vbCrLf & vbCrLf & "Los datos han sido bajados a un archivo plano a la ruta: " & vbCrLf & Commando.FileName, vbInformation, TITSISTEMA
   
Exit Sub
ErrorGeneracion:
   If Err.Number = 32755 Then
      On Error GoTo 0
      Exit Sub
   Else
      MsgBox "Error en generación de planilla" & vbCrLf & vbCrLf & Err.Description, vbExclamation, TITSISTEMA
   End If
   On Error GoTo 0
End Sub

Private Function fCampoInterfaz(Formato As TipoCaracter, oCampo As Variant, largo As Integer, oCantidadDecimales As Variant) As Variant
   On Error GoTo ErrorXXX
   Dim oRetorno        As Variant
   Dim oDecimales      As Variant
   Dim oEntero         As Variant
   Dim oValorNumerico  As Double

   If Formato = Caracter Then
      If Len(oCampo) > largo Then
         oCampo = Mid(oCampo, 1, largo)
      End If
      oRetorno = oCampo & String(largo - Len(oCampo), " ")
   End If

   If Formato = Numerico Then
      If oCantidadDecimales > 0 Then
         If InStr(1, oCampo, ",") > 0 Then
            oRetorno = Replace(oCampo, ",", ".")
         End If
         If InStr(1, oCampo, ".") = 0 Then
            oCampo = Trim(Str(oCampo)) & ".0"
         End If
         oCampo = String(largo - (InStr(1, oCampo, ".") - 1), "0") & Mid(oCampo, 1, (InStr(1, oCampo, ".") - 1)) & Mid(oCampo, InStr(1, oCampo, ".") + 1) & String(4 - Len(Mid(oCampo, InStr(1, oCampo, ".") + 1)), "0")
         oRetorno = oCampo
      Else
         oRetorno = String(largo - Len(Mid(oCampo, 1, largo)), "0") & Mid(oCampo, 1, largo)
      End If
   End If

   If Formato = Fecha Then
      oRetorno = Format(CDate(oCampo), "yyyymmdd")
   End If

   fCampoInterfaz = oRetorno
   On Error GoTo 0
   
Exit Function
ErrorXXX:
   On Error GoTo 0
End Function

