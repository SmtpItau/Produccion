VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form Consulta_Anticipos 
   Appearance      =   0  'Flat
   Caption         =   "Consulta de operaciones"
   ClientHeight    =   5835
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   14115
   BeginProperty Font 
      Name            =   "Times New Roman"
      Size            =   8.25
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "Consulta_Anticipos.frx":0000
   LinkTopic       =   "Form1"
   MDIChild        =   -1  'True
   ScaleHeight     =   5835
   ScaleWidth      =   14115
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   2
      Top             =   0
      Width           =   14115
      _ExtentX        =   24897
      _ExtentY        =   794
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList2"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Filtarar Operaciones"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Anticipar Operaciones"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Cerrar Ventana"
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList2 
         Left            =   3750
         Top             =   0
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   3
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Consulta_Anticipos.frx":0442
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Consulta_Anticipos.frx":131C
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Consulta_Anticipos.frx":21F6
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Frame Frame1 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   4950
      Index           =   0
      Left            =   30
      TabIndex        =   0
      Top             =   840
      Width           =   14085
      Begin MSFlexGridLib.MSFlexGrid grdConsulta 
         Height          =   4650
         Left            =   30
         TabIndex        =   1
         Top             =   150
         Width           =   13980
         _ExtentX        =   24659
         _ExtentY        =   8202
         _Version        =   393216
         Cols            =   19
         FixedCols       =   0
         BackColor       =   -2147483633
         BackColorFixed  =   -2147483646
         ForeColorFixed  =   -2147483639
         BackColorBkg    =   -2147483636
         GridColor       =   -2147483641
         GridColorFixed  =   -2147483640
         FocusRect       =   0
         GridLines       =   2
         GridLinesFixed  =   0
         SelectionMode   =   1
         AllowUserResizing=   1
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
   End
   Begin VB.Label EtiquetaTitulo 
      Alignment       =   2  'Center
      BackColor       =   &H80000002&
      BorderStyle     =   1  'Fixed Single
      Caption         =   "Consulta"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000009&
      Height          =   345
      Left            =   30
      TabIndex        =   3
      Top             =   480
      Width           =   14010
   End
End
Attribute VB_Name = "Consulta_Anticipos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Const TipProd = 0
Const NumOper = 1
Const TipOper = 2
Const NomClie = 3
Const FecInic = 4
Const FecVenc = 5
Const MonOper = 6
Const MtoOper = 7
Const TirBase = 8
Const MtoConv = 9
Const TirConv = 10
Const ModPago = 11
Const AreResp = 12
Const CarNorm = 13
Const SubNorm = 14
Const CodLibr = 15

Dim NoEntrar                    As Boolean
Dim FilaAnt                     As Integer
Dim ColAct                      As Integer
Public SQLConsulta              As String

Private Function LoadOperaciones()
   Dim DATOS()

   Let NumPaso = 0
   Let Filas = 1
   Let Consulta_Anticipos.grdConsulta.Rows = 1

   If Not Bac_Sql_Execute(SQLConsulta) Then
      Exit Function
   End If
   Do While Bac_SQL_Fetch(DATOS())
      Consulta_Anticipos.grdConsulta.Rows = Consulta_Anticipos.grdConsulta.Rows + 1

      Consulta_Anticipos.grdConsulta.TextMatrix(Filas, TipProd) = DATOS(1)
      Consulta_Anticipos.grdConsulta.TextMatrix(Filas, NumOper) = Val(DATOS(2))
      Consulta_Anticipos.grdConsulta.TextMatrix(Filas, TipOper) = DATOS(6)
      Consulta_Anticipos.grdConsulta.TextMatrix(Filas, NomClie) = DATOS(4)
      Consulta_Anticipos.grdConsulta.TextMatrix(Filas, FecInic) = DATOS(7)
      Consulta_Anticipos.grdConsulta.TextMatrix(Filas, FecVenc) = DATOS(8)
      Consulta_Anticipos.grdConsulta.TextMatrix(Filas, MonOper) = DATOS(10)
      Consulta_Anticipos.grdConsulta.TextMatrix(Filas, MtoOper) = Format(BacStrTran((DATOS(11)), ".", gsc_PuntoDecim), "###,###,###,##0.#0")
      Consulta_Anticipos.grdConsulta.TextMatrix(Filas, 8) = Val(DATOS(12))
      Consulta_Anticipos.grdConsulta.TextMatrix(Filas, 9) = Format(BacStrTran((DATOS(13)), ".", gsc_PuntoDecim), "###,###,###,##0.#0")
      Consulta_Anticipos.grdConsulta.TextMatrix(Filas, 10) = BacStrTran((DATOS(14)), ".", gsc_PuntoDecim)
      Consulta_Anticipos.grdConsulta.TextMatrix(Filas, 11) = DATOS(15)

      Consulta_Anticipos.grdConsulta.TextMatrix(Filas, 15) = Trim(DATOS(17))
      Consulta_Anticipos.grdConsulta.TextMatrix(Filas, 16) = Trim(DATOS(18))
      Consulta_Anticipos.grdConsulta.TextMatrix(Filas, 17) = Trim(DATOS(19))
      Consulta_Anticipos.grdConsulta.TextMatrix(Filas, 18) = Trim(DATOS(20))
      Consulta_Anticipos.grdConsulta.Tag = "SI"
      
      Filas = Filas + 1
   Loop

End Function

Function VerificaDia()

   Tool_Menu.Buttons(3).Enabled = False

   If grdConsulta.Row <> 0 Then
      If grdConsulta.TextMatrix(grdConsulta.Row, 4) <> "" Then
         If CDate((grdConsulta.TextMatrix(grdConsulta.Row, 4))) = CDate((gsBAC_Fecp)) Then
            Tool_Menu.Buttons.Item(2).Enabled = True
         Else
            Tool_Menu.Buttons.Item(2).Enabled = False
         End If
         If CDate(grdConsulta.TextMatrix(grdConsulta.Row, 4)) = CDate(gsBAC_Fecp) Then
            Tool_Menu.Buttons(3).Enabled = True
         End If
      End If
   End If

End Function

Function InicializaGrilla()
   Dim nContador As Integer

   grdConsulta.Cols = 19
   grdConsulta.Rows = 1

   grdConsulta.RowHeight(0) = 500

   grdConsulta.TextMatrix(0, TipProd) = "Producto":                  grdConsulta.ColWidth(TipProd) = 1500:     grdConsulta.ColAlignment(TipProd) = flexAlignLeftCenter  ' flexAlignCenterCenter
   grdConsulta.TextMatrix(0, NumOper) = "N° Contrato":               grdConsulta.ColWidth(NumOper) = 1200:     grdConsulta.ColAlignment(NumOper) = flexAlignLeftCenter  ' flexAlignCenterCenter
   grdConsulta.TextMatrix(0, TipOper) = "Tip Oper":                  grdConsulta.ColWidth(TipOper) = 0:        grdConsulta.ColAlignment(TipOper) = flexAlignLeftCenter  ' flexAlignCenterCenter
   grdConsulta.TextMatrix(0, NomClie) = "Cliente":                   grdConsulta.ColWidth(NomClie) = 3800:     grdConsulta.ColAlignment(NomClie) = flexAlignLeftCenter  ' flexAlignCenterCenter
   grdConsulta.TextMatrix(0, FecInic) = "Fecha Inicio":              grdConsulta.ColWidth(FecInic) = 1250:     grdConsulta.ColAlignment(FecInic) = flexAlignRightCenter  ' flexAlignCenterCenter
   grdConsulta.TextMatrix(0, FecVenc) = "Fecha Vcto":                grdConsulta.ColWidth(FecVenc) = 1250:     grdConsulta.ColAlignment(FecVenc) = flexAlignRightCenter  ' flexAlignCenterCenter
   grdConsulta.TextMatrix(0, MonOper) = "Moneda OP.":                grdConsulta.ColWidth(MonOper) = 2200:     grdConsulta.ColAlignment(MonOper) = flexAlignLeftCenter  ' flexAlignCenterCenter
   grdConsulta.TextMatrix(0, MtoOper) = "Monto Operación":           grdConsulta.ColWidth(MtoOper) = 2500:     grdConsulta.ColAlignment(MtoOper) = flexAlignRightCenter ' flexAlignCenterCenter
   grdConsulta.TextMatrix(0, TirBase) = "Tasa Base":                 grdConsulta.ColWidth(TirBase) = 1000:     grdConsulta.ColAlignment(TirBase) = flexAlignRightCenter ' flexAlignCenterCenter
   grdConsulta.TextMatrix(0, MtoConv) = "Monto Conversion":          grdConsulta.ColWidth(MtoConv) = 2500:     grdConsulta.ColAlignment(MtoConv) = flexAlignRightCenter ' flexAlignCenterCenter
   grdConsulta.TextMatrix(0, TirConv) = "Tasa Conv.":                grdConsulta.ColWidth(TirConv) = 1000:     grdConsulta.ColAlignment(TirConv) = flexAlignRightCenter ' flexAlignCenterCenter
   grdConsulta.TextMatrix(0, ModPago) = "Modalidad":                 grdConsulta.ColWidth(ModPago) = 1500:     grdConsulta.ColAlignment(ModPago) = flexAlignLeftCenter  ' flexAlignCenterCenter
   grdConsulta.TextMatrix(0, AreResp) = "Area Responsable":          grdConsulta.ColWidth(AreResp) = 0:        grdConsulta.ColAlignment(AreResp) = flexAlignLeftCenter  ' flexAlignCenterCenter
   grdConsulta.TextMatrix(0, CarNorm) = "Cartera Normativa":         grdConsulta.ColWidth(CarNorm) = 0:        grdConsulta.ColAlignment(CarNorm) = flexAlignLeftCenter  ' flexAlignCenterCenter
   grdConsulta.TextMatrix(0, SubNorm) = "SubCartera Normativa":      grdConsulta.ColWidth(SubNorm) = 0:        grdConsulta.ColAlignment(SubNorm) = flexAlignLeftCenter  ' flexAlignCenterCenter
   grdConsulta.TextMatrix(0, CodLibr) = "Libro":                     grdConsulta.ColWidth(CodLibr) = 0:        grdConsulta.ColAlignment(CodLibr) = flexAlignLeftCenter  ' flexAlignCenterCenter
   
   grdConsulta.ColWidth(16) = 0
   grdConsulta.ColWidth(17) = 0
   grdConsulta.ColWidth(18) = 0
   
   grdConsulta.Row = 0

   grdConsulta.Tag = "NO"  '--> Grilla no tiene datos
End Function

Private Sub btnModificar_Click()

   If grdConsulta.TextMatrix(grdConsulta.Row, NumOper) = "" Or grdConsulta.Row = 0 Then
      Exit Sub
   End If

   swModNumOpe = grdConsulta.TextMatrix(grdConsulta.Row, NumOper)

   Select Case swModTipoOpe
      Case 1:  swOperSwap = "Modificacion"
      Case 3:  swOperSwap = "ModificacionCartera"
   End Select

   BacConsultaOper.Hide 'Ocultar Formulario de consulta

   If UCase((grdConsulta.TextMatrix(grdConsulta.Row, 0))) = "TASA" Then
      FRM_SWAP_OP.SwapModificacion = swModNumOpe
      FRM_SWAP_OP.Show

   ElseIf UCase((grdConsulta.TextMatrix(grdConsulta.Row, 0))) = "MONEDA" Then
      FRM_SWAP_OP.SwapModificacion = swModNumOpe
      FRM_SWAP_OP.Show

   ElseIf (grdConsulta.TextMatrix(grdConsulta.Row, 0)) = "FRA" Then
      FRM_SWAP_OP_FRA.SwapModificacion = swModNumOpe
      FRM_SWAP_OP_FRA.Show

   ElseIf (grdConsulta.TextMatrix(grdConsulta.Row, 0)) = "PROMEDIO CAMARA" Then
      FRM_SWAP_OP.SwapModificacion = swModNumOpe
      FRM_SWAP_OP.Show

   End If

End Sub

Function EstadoBtn(estado)
End Function

Function EstadoToolBar(estado)
   Tool_Menu.Buttons.Item(2).Enabled = estado
   Tool_Menu.Buttons.Item(3).Enabled = estado
   Tool_Menu.Buttons.Item(4).Enabled = estado
End Function

Function EstadoBtns()
   Select Case swModTipoOpe 'TipoOperacion
      Case 0
         Call EstadoBtn(False)
      Case 1
         Call EstadoBtn(True)
      Case 2
         Tool_Menu.Buttons.Item(2).Enabled = False
         Tool_Menu.Buttons.Item(3).Enabled = False
      Case 3
         Tool_Menu.Buttons.Item(2).Enabled = False
         Tool_Menu.Buttons.Item(3).Enabled = True
      Case 4
         Tool_Menu.Buttons.Item(2).Enabled = False
         Tool_Menu.Buttons.Item(3).Enabled = False
   End Select
End Function

Function EstadoToolBars()

   Select Case swModTipoOpe
      Case 0
         Call EstadoToolBar(False)
      Case 1
         Call EstadoToolBar(True)
      Case 2
         Tool_Menu.Buttons.Item(2).Enabled = False
         Tool_Menu.Buttons.Item(3).Enabled = False
      Case 3
         Tool_Menu.Buttons.Item(2).Enabled = True
         Tool_Menu.Buttons.Item(3).Enabled = True
         Tool_Menu.Buttons.Item(4).Enabled = True
      Case 4
         Tool_Menu.Buttons.Item(2).Enabled = False
         Tool_Menu.Buttons.Item(3).Enabled = False
   End Select
End Function

Private Sub Form_GotFocus()
   Call InicializaGrilla
End Sub

Private Sub Form_Load()
   Me.Icon = BACSwap.Icon
   'PRD-5149, jbh, 12-01-2010, para evitar que el formulario "pasee" por la pantalla
   Me.Top = 0
   Me.Left = 0

   Let EtiquetaTitulo.Caption = "CONSULTA DE OPERACIONES"
   Call InicializaGrilla
End Sub

Private Sub Form_Resize()
   On Error Resume Next
   
   EtiquetaTitulo.Width = Me.Width - 200
   Frame1(0).Width = EtiquetaTitulo.Width
   grdConsulta.Width = Me.Frame1(0).Width - 150
   
   Frame1(0).Top = (EtiquetaTitulo.Top + EtiquetaTitulo.Height)
   grdConsulta.Top = 150
   
   Frame1(0).Height = (Me.Height - 1400)
   grdConsulta.Height = Frame1(0).Height - 200
   
   On Error GoTo 0
   
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
    Dim IntRow          As Integer

    Select Case Button.Index
      Case 2
         
         grdConsulta.Rows = 1
         Call FiltrarConsulta_Anticipo.Show

      Case 3
          'prd19111 inicio
                Envia = Array()
                AddParam Envia, grdConsulta.TextMatrix(grdConsulta.Row, NumOper)
                AddParam Envia, "PCS"
                If Not Bac_Sql_Execute("BDBOMESA.DBO.COMDER_EstadoOperacion", Envia) Then
                    MsgBox ("Error busca estado operacion")
                End If
                
                If Bac_SQL_Fetch(Datos()) Then
                    EstadoOperComder = Datos(3)
                End If
                If UCase(Datos(3)) = "NO" Then
                       MsgBox ("La Operación es Comder no es Posible Realizar Anticipo ")
                   Exit Sub
                
                End If
                '--> Valida si es operacion Comder
                'If EstadoOperComder > 0 Then
                '   MsgBox ("La Operación es Comder no permite anticipar")
                '   Exit Sub
                'End If
          
          'prd19111 fin

        If grdConsulta.TextMatrix(grdConsulta.Row, NumOper) = "" Or grdConsulta.Row = 0 Then
            Exit Sub
        End If

        Let IntRow = grdConsulta.Row

        Let GlbEstadoAnticipo = False
        Let GlbNumeroAnticipo = grdConsulta.TextMatrix(grdConsulta.Row, NumOper)

       'Call Anticipo_Operaciones.Show(vbModal)
 
         Let FRM_ANTICIPO_OP.nNumeroOperacion = grdConsulta.TextMatrix(grdConsulta.Row, NumOper)
        Call FRM_ANTICIPO_OP.Show(vbModal)
       
        Call LoadOperaciones

      Case 4
         Call Unload(Me)
   End Select
End Sub
