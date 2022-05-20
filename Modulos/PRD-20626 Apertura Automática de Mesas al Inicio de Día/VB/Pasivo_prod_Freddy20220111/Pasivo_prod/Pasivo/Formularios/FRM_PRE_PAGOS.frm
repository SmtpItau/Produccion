VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "threed32.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{989C9190-EDF5-45A8-AB6C-98E6EF0384D7}#1.0#0"; "Bac_Controles_Pas.ocx"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form FRM_PRE_PAGOS 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Pre - Pagos"
   ClientHeight    =   5835
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   10335
   Icon            =   "FRM_PRE_PAGOS.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5835
   ScaleWidth      =   10335
   Begin Threed.SSFrame Frm_Renovacion_Vigente 
      Height          =   4485
      Left            =   30
      TabIndex        =   3
      Top             =   1320
      Width           =   10275
      _Version        =   65536
      _ExtentX        =   18124
      _ExtentY        =   7911
      _StockProps     =   14
      Caption         =   "Operaciones para Pre-Pagos"
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin MSFlexGridLib.MSFlexGrid Grd_Prepagos 
         Height          =   4185
         Left            =   30
         TabIndex        =   0
         Top             =   240
         Width           =   10215
         _ExtentX        =   18018
         _ExtentY        =   7382
         _Version        =   393216
         Rows            =   3
         FixedRows       =   2
         FixedCols       =   0
         RowHeightMin    =   345
         BackColor       =   -2147483644
         ForeColor       =   8388608
         BackColorFixed  =   8421376
         ForeColorFixed  =   16777215
         BackColorBkg    =   -2147483644
         GridColor       =   0
         WordWrap        =   -1  'True
         FocusRect       =   0
         GridLinesFixed  =   0
         SelectionMode   =   1
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
   End
   Begin Threed.SSFrame Frm_Renovacion_Original 
      Height          =   795
      Left            =   0
      TabIndex        =   4
      Top             =   510
      Width           =   10305
      _Version        =   65536
      _ExtentX        =   18177
      _ExtentY        =   1402
      _StockProps     =   14
      Caption         =   "Datos de Pre-Pago"
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin Threed.SSCheck Opt_Todos 
         Height          =   255
         Left            =   930
         TabIndex        =   1
         Top             =   330
         Width           =   1365
         _Version        =   65536
         _ExtentX        =   2408
         _ExtentY        =   450
         _StockProps     =   78
         Caption         =   "Todos"
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin BACControles.TXTNumero Txt_Numero 
         Height          =   345
         Left            =   7320
         TabIndex        =   5
         Top             =   270
         Width           =   1635
         _ExtentX        =   2884
         _ExtentY        =   609
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "0"
         Text            =   "0"
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTFecha Txt_Fecha 
         Height          =   345
         Left            =   3480
         TabIndex        =   2
         Top             =   270
         Width           =   1335
         _ExtentX        =   2355
         _ExtentY        =   609
         Enabled         =   -1  'True
         Enabled         =   -1  'True
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "22/04/2003"
      End
      Begin VB.Label Etiqurta_Fecha 
         Caption         =   "Fecha"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   2790
         TabIndex        =   7
         Top             =   330
         Width           =   645
      End
      Begin VB.Label Etiqueta_Numero 
         Caption         =   "Número"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Left            =   6510
         TabIndex        =   6
         Top             =   330
         Width           =   675
      End
   End
   Begin MSComctlLib.Toolbar Tlb_Prepago 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   8
      Top             =   0
      Width           =   10335
      _ExtentX        =   18230
      _ExtentY        =   794
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Style           =   1
      ImageList       =   "Img_opciones"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   2
         EndProperty
      EndProperty
      Begin MSComctlLib.ImageList Img_opciones 
         Left            =   6120
         Top             =   0
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   24
         ImageHeight     =   24
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   25
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRE_PAGOS.frx":2EFA
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRE_PAGOS.frx":3361
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRE_PAGOS.frx":3857
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRE_PAGOS.frx":3CEA
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRE_PAGOS.frx":41D2
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRE_PAGOS.frx":46E5
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRE_PAGOS.frx":4C22
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRE_PAGOS.frx":5064
               Key             =   ""
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRE_PAGOS.frx":551E
               Key             =   ""
            EndProperty
            BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRE_PAGOS.frx":59F1
               Key             =   ""
            EndProperty
            BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRE_PAGOS.frx":5E35
               Key             =   ""
            EndProperty
            BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRE_PAGOS.frx":639C
               Key             =   ""
            EndProperty
            BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRE_PAGOS.frx":686B
               Key             =   ""
            EndProperty
            BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRE_PAGOS.frx":6C8A
               Key             =   ""
            EndProperty
            BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRE_PAGOS.frx":7182
               Key             =   ""
            EndProperty
            BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRE_PAGOS.frx":757B
               Key             =   ""
            EndProperty
            BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRE_PAGOS.frx":79FE
               Key             =   ""
            EndProperty
            BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRE_PAGOS.frx":7EC4
               Key             =   ""
            EndProperty
            BeginProperty ListImage19 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRE_PAGOS.frx":83BB
               Key             =   ""
            EndProperty
            BeginProperty ListImage20 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRE_PAGOS.frx":8871
               Key             =   ""
            EndProperty
            BeginProperty ListImage21 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRE_PAGOS.frx":8C36
               Key             =   ""
            EndProperty
            BeginProperty ListImage22 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRE_PAGOS.frx":902C
               Key             =   ""
            EndProperty
            BeginProperty ListImage23 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRE_PAGOS.frx":9423
               Key             =   ""
            EndProperty
            BeginProperty ListImage24 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRE_PAGOS.frx":982C
               Key             =   ""
            EndProperty
            BeginProperty ListImage25 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRE_PAGOS.frx":9CEA
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
End
Attribute VB_Name = "FRM_PRE_PAGOS"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim cOptLocal As String

Private Sub Form_Activate()
   
   PROC_CARGA_AYUDA Me

   If Grd_Prepagos.Enabled = True Then
      Grd_Prepagos.SetFocus
   End If
   
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)

Dim nOpcion As Integer

If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) Then

nOpcion = 0
   
   Select Case KeyCode

         Case vbKeyBuscar
         
               nOpcion = 1

         Case vbKeySalir
         
               nOpcion = 2
              
   End Select

   If nOpcion <> 0 Then
      
      If Tlb_Prepago.Buttons(nOpcion).Enabled Then
         
         Call Tlb_Prepago_ButtonClick(Tlb_Prepago.Buttons(nOpcion))
      
      End If
   
   End If

End If

End Sub

Private Sub Form_Load()

   cOptLocal = GLB_cOptLocal
   Me.top = 0
   Me.left = 0
   Me.Icon = FRM_MDI_PASIVO.Icon

   Call FUNC_FORMATO_GRILLA(Grd_Prepagos)

   PROC_TITULOS_GRILLA

   Call PROC_LOG_AUDITORIA("07", cOptLocal, Me.Caption, "", "")

   Txt_Fecha.Text = GLB_Fecha_Proceso
   
   PROC_BUSCA_PREPAGO (0)
   
   DoEvents
   
End Sub

Private Sub Form_Unload(Cancel As Integer)

   Call PROC_LOG_AUDITORIA("08", cOptLocal, Me.Caption, "", "")

End Sub

Sub PROC_TITULOS_GRILLA()

   Grd_Prepagos.Cols = 7
   Grd_Prepagos.Rows = 2
   
   Grd_Prepagos.ColWidth(0) = 1000
   Grd_Prepagos.ColWidth(1) = 1000
   Grd_Prepagos.ColWidth(2) = 950
   Grd_Prepagos.ColWidth(3) = 2000
   Grd_Prepagos.ColWidth(4) = 950
   Grd_Prepagos.ColWidth(5) = 4200
   Grd_Prepagos.ColWidth(6) = 0
   
   Grd_Prepagos.TextMatrix(0, 0) = "Numero"
   Grd_Prepagos.TextMatrix(1, 0) = "Acuerdo"
   Grd_Prepagos.TextMatrix(0, 1) = "Fecha"
   Grd_Prepagos.TextMatrix(1, 1) = "Otorg."
   Grd_Prepagos.TextMatrix(0, 2) = "Moneda"
   Grd_Prepagos.TextMatrix(1, 2) = "Operacion"
   Grd_Prepagos.TextMatrix(0, 3) = "Monto"
   Grd_Prepagos.TextMatrix(1, 3) = "Operacion"
   Grd_Prepagos.TextMatrix(0, 4) = "Tasa"
   Grd_Prepagos.TextMatrix(1, 4) = "Interes"
   Grd_Prepagos.TextMatrix(0, 5) = "Nombre"
   Grd_Prepagos.TextMatrix(1, 5) = "Cliente"
   
   Grd_Prepagos.ColAlignment(0) = flexAlignRightCenter
   Grd_Prepagos.ColAlignment(1) = flexAlignLeftCenter
   Grd_Prepagos.ColAlignment(2) = flexAlignLeftCenter
   Grd_Prepagos.ColAlignment(3) = flexAlignRightCenter
   Grd_Prepagos.ColAlignment(4) = flexAlignRightCenter
   Grd_Prepagos.ColAlignment(5) = flexAlignLeftCenter

 
End Sub

Private Sub Grd_Prepagos_Click()

   Txt_Numero.Text = CDbl(Grd_Prepagos.TextMatrix(Grd_Prepagos.Row, 6))

End Sub

Private Sub Grd_Prepagos_DblClick()

'   If (objCentralizacion.Chequeo_Estado(GLB_Sistema, "bloqueo", False) And objCentralizacion.Error = 0) Then
'
'      MsgBox objCentralizacion.Mensaje, vbExclamation
'      Grd_Consulta.SetFocus
'      Exit Sub
'
'   End If

Dim Datos()
GLB_Envia = Array("PSV")

      If FUNC_EXECUTA_COMANDO_SQL("SP_CON_ESTADO_SWITCH", GLB_Envia) Then
         Do While FUNC_LEE_RETORNO_SQL(Datos())
 
             If Datos(5) = 1 And Datos(6) = "MESA" Then
 
                MsgBox "Mesa esta bloqueada", vbExclamation
                Grd_Consulta.SetFocus
                Exit Sub
 
            End If
      
         Loop
     End If
     
     Txt_Numero.Text = CDbl(Grd_Prepagos.TextMatrix(Grd_Prepagos.Row, 6))

   Me.Hide
   FRM_ING_PRE_PAGO.Show

End Sub

Private Sub Grd_Prepagos_KeyPress(KeyAscii As Integer)

   If KeyAscii = 13 Then
      Call Grd_Prepagos_DblClick
   End If

End Sub

Private Sub Grd_Prepagos_RowColChange()

   Txt_Numero.Text = CDbl(Grd_Prepagos.TextMatrix(Grd_Prepagos.Row, 6))

End Sub

Private Sub Opt_Todos_Click(Value As Integer)

   If Value = 0 Then
   
      Txt_Fecha.Enabled = True
   
   Else
   
      Txt_Fecha.Enabled = False
   
   End If

End Sub

Private Sub Tlb_Prepago_ButtonClick(ByVal Button As MSComctlLib.Button)

      Select Case Button.Index
      
         Case 1
         
            Grd_Prepagos.Clear
            PROC_TITULOS_GRILLA
            Txt_Numero.Text = 0
         
'            If Opt_Todos.Value = 0 Then
'
'               PROC_BUSCA_PREPAGO (1)
'
'            Else

               PROC_BUSCA_PREPAGO (0)
'
'            End If
          
         Case 2
         
            Unload Me
   
      End Select

End Sub

Sub PROC_BUSCA_PREPAGO(nOpcion As Integer)

Dim vDatos_Retorno()
Dim nIndice          As Integer

   With Grd_Prepagos

      GLB_Envia = Array()
      PROC_AGREGA_PARAMETRO GLB_Envia, nOpcion
      PROC_AGREGA_PARAMETRO GLB_Envia, Format(Txt_Fecha.Text, GLB_FORMATO_FECHA_REGIONAL)
      
      If Not FUNC_EXECUTA_COMANDO_SQL("SP_CON_PRE_PAGOS", GLB_Envia) Then
      
         MsgBox "No fue posible leer información", vbOKOnly + vbCritical
         Exit Sub
         
      Else
      
         .Rows = 2
         
         Do While FUNC_LEE_RETORNO_SQL(vDatos_Retorno())
         
             .Rows = .Rows + 1
             nIndice = .Rows - 1
            .TextMatrix(nIndice, 0) = Format(vDatos_Retorno(1), GLB_Formato_Entero)
            .TextMatrix(nIndice, 1) = vDatos_Retorno(2)
            .TextMatrix(nIndice, 2) = vDatos_Retorno(3)
            .TextMatrix(nIndice, 3) = Format(vDatos_Retorno(4), GLB_Formato_Entero)
            .TextMatrix(nIndice, 4) = Format(vDatos_Retorno(5), GLB_Formato_Decimal)
            .TextMatrix(nIndice, 5) = vDatos_Retorno(6)
            .TextMatrix(nIndice, 6) = vDatos_Retorno(7)
            
         Loop
        
     End If
   
   End With
   
   DoEvents
   
   If Grd_Prepagos.Rows = 2 Then
   
      Grd_Prepagos.FocusRect = flexFocusLight
      Grd_Prepagos.Enabled = False
   
   Else
   
      Grd_Prepagos.FocusRect = flexFocusNone
      Grd_Prepagos.Enabled = True
      Grd_Prepagos.Col = 0
   End If
   
End Sub

Private Sub Txt_Fecha_Click()
If CDate(Txt_Fecha.Text) > GLB_Fecha_Proceso Then
   MsgBox "Fecha no puede ser mayor a Fecha Proceso"
   Txt_Fecha.Text = CStr(GLB_Fecha_Proceso)
   Exit Sub
End If

End Sub


Private Sub Txt_Fecha_Change()
If CDate(Txt_Fecha.Text) > GLB_Fecha_Proceso Then
   MsgBox "Fecha no puede ser mayor a Fecha Proceso"
   Txt_Fecha.Text = CStr(GLB_Fecha_Proceso)
   Exit Sub
End If

End Sub

