VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{989C9190-EDF5-45A8-AB6C-98E6EF0384D7}#1.0#0"; "Bac_Controles_Pas.ocx"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form FRM_MAN_TABLA_DESARROLLO 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantención Tabla de Desarrollo"
   ClientHeight    =   6690
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   10620
   Icon            =   "FRM_MAN_TABLA_DESARROLLO.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   6690
   ScaleWidth      =   10620
   Begin BACControles.TXTNumero TXT_Texto 
      Height          =   330
      Left            =   2310
      TabIndex        =   7
      Top             =   4260
      Visible         =   0   'False
      Width           =   2010
      _ExtentX        =   3545
      _ExtentY        =   582
      BackColor       =   8388608
      ForeColor       =   -2147483634
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
      BackStyle       =   1
      BorderStyle     =   0
      Text            =   "0"
      Text            =   "0"
      Min             =   "1"
      Max             =   "999999999"
      Separator       =   -1  'True
   End
   Begin Threed.SSFrame Frame 
      Height          =   975
      Index           =   0
      Left            =   0
      TabIndex        =   0
      Top             =   525
      Width           =   10620
      _Version        =   65536
      _ExtentX        =   18732
      _ExtentY        =   1720
      _StockProps     =   14
      Caption         =   " Datos Serie "
      ForeColor       =   -2147483641
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   3
      Begin VB.TextBox txt_Mascara 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   150
         MaxLength       =   12
         MousePointer    =   14  'Arrow and Question
         TabIndex        =   1
         Top             =   510
         Width           =   1335
      End
      Begin BACControles.TXTNumero itbNumDecimales 
         Height          =   315
         Left            =   1665
         TabIndex        =   4
         Top             =   510
         Width           =   975
         _ExtentX        =   1720
         _ExtentY        =   556
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
         Min             =   "0"
         Max             =   "9"
      End
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Nº Decimales"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   210
         Index           =   15
         Left            =   1680
         TabIndex        =   5
         Top             =   315
         Width           =   1065
      End
      Begin VB.Label Label 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         Caption         =   "Máscara"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   210
         Index           =   1
         Left            =   180
         TabIndex        =   2
         Top             =   315
         Width           =   690
      End
   End
   Begin MSComctlLib.Toolbar Barra_Menu 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   3
      Top             =   0
      Width           =   10620
      _ExtentX        =   18733
      _ExtentY        =   794
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Style           =   1
      ImageList       =   "Img_opciones"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Limpiar"
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Grabar"
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Procesar"
            Object.ToolTipText     =   "Procesar"
            ImageIndex      =   14
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Eliminar"
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      Begin MSComctlLib.ImageList Img_opciones 
         Left            =   6600
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
               Picture         =   "FRM_MAN_TABLA_DESARROLLO.frx":2EFA
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_TABLA_DESARROLLO.frx":3361
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_TABLA_DESARROLLO.frx":3857
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_TABLA_DESARROLLO.frx":3CEA
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_TABLA_DESARROLLO.frx":41D2
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_TABLA_DESARROLLO.frx":46E5
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_TABLA_DESARROLLO.frx":4C22
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_TABLA_DESARROLLO.frx":5064
               Key             =   ""
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_TABLA_DESARROLLO.frx":551E
               Key             =   ""
            EndProperty
            BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_TABLA_DESARROLLO.frx":59F1
               Key             =   ""
            EndProperty
            BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_TABLA_DESARROLLO.frx":5E35
               Key             =   ""
            EndProperty
            BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_TABLA_DESARROLLO.frx":639C
               Key             =   ""
            EndProperty
            BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_TABLA_DESARROLLO.frx":686B
               Key             =   ""
            EndProperty
            BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_TABLA_DESARROLLO.frx":6C8A
               Key             =   ""
            EndProperty
            BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_TABLA_DESARROLLO.frx":7182
               Key             =   ""
            EndProperty
            BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_TABLA_DESARROLLO.frx":757B
               Key             =   ""
            EndProperty
            BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_TABLA_DESARROLLO.frx":79FE
               Key             =   ""
            EndProperty
            BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_TABLA_DESARROLLO.frx":7EC4
               Key             =   ""
            EndProperty
            BeginProperty ListImage19 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_TABLA_DESARROLLO.frx":83BB
               Key             =   ""
            EndProperty
            BeginProperty ListImage20 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_TABLA_DESARROLLO.frx":8871
               Key             =   ""
            EndProperty
            BeginProperty ListImage21 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_TABLA_DESARROLLO.frx":8C36
               Key             =   ""
            EndProperty
            BeginProperty ListImage22 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_TABLA_DESARROLLO.frx":902C
               Key             =   ""
            EndProperty
            BeginProperty ListImage23 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_TABLA_DESARROLLO.frx":9423
               Key             =   ""
            EndProperty
            BeginProperty ListImage24 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_TABLA_DESARROLLO.frx":982C
               Key             =   ""
            EndProperty
            BeginProperty ListImage25 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_TABLA_DESARROLLO.frx":9CEA
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin MSFlexGridLib.MSFlexGrid GRD_Tdesarrollo 
      Height          =   5145
      Left            =   -15
      TabIndex        =   6
      Top             =   1530
      Width           =   10635
      _ExtentX        =   18759
      _ExtentY        =   9075
      _Version        =   393216
      Rows            =   3
      FixedRows       =   2
      RowHeightMin    =   345
      BackColor       =   -2147483644
      ForeColor       =   8388608
      BackColorFixed  =   8421376
      ForeColorFixed  =   16777215
      BackColorBkg    =   -2147483644
      GridColor       =   0
      WordWrap        =   -1  'True
      GridLinesFixed  =   0
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
Attribute VB_Name = "FRM_MAN_TABLA_DESARROLLO"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public proOrigense         As String   ' SE ->series  CT ->crear Tabla
Public cTasaVariable       As String

Public ctdmascara          As String
Public ctdfecven           As String
Public ntdinteres          As Double
Public ntdcupon            As Double
Public ntdamort            As Double
Public ntdPeriodo          As Double
Public ntdDecimales        As Double
Public ntdDiaPago          As Double
Public cFormat_Decimal     As String
Public cInstrumento        As Integer
Public dFechaVen           As Date
Public dFechaCorte         As Date

Const nCupon = 1
Const dFecVcto = 2
Const nAmortiza = 3
Const nInteres = 4
Const nFlujo = 5
Const nSaldos = 6

Dim Instrum As Integer
Private Sub Barra_Menu_ButtonClick(ByVal Button As MSComctlLib.Button)
   
   Select Case Trim(UCase(Button.Key))
      
      Case "SALIR"
         Unload Me
      
      Case "PROCESAR"
         If txt_Mascara.Text <> "" Then
            Call FUNC_BUSCAR_MASCARA
         End If
         
      Case "LIMPIAR"
         
            Call LIMPIAR_PANTALLA
         
      Case "GRABAR"
         If FUNC_EXECUTA_COMANDO_SQL("BEGIN TRANSACTION") Then
         
         End If
         If PROC_GRABAR_TABLA_DESARROLLO Then
         
         End If

      Case "ELIMINAR"
         If FUNC_EXECUTA_COMANDO_SQL("BEGIN TRANSACTION") Then
         
         End If
         If PROC_ELIMINAR_TDESARROLLO Then
         
         End If
   
   End Select

End Sub

Private Sub Form_Activate()
   PROC_CARGA_AYUDA Me
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)

   Dim Opcion As Integer
   
   If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) Then
      Opcion = 0
      Select Case KeyCode
         Case vbKeyLimpiar
            Opcion = 1

         Case vbKeyGrabar
            Opcion = 2
         Case VbKeyProcesar
            Opcion = 3
         Case vbKeyEliminar
            Opcion = 4
         Case vbKeySalir
            If Me.ActiveControl.Name <> "TXT_Texto" Then
               Opcion = 5
            End If
      End Select
   
      If Opcion <> 0 Then
         If Barra_Menu.Buttons(Opcion).Enabled Then
            Call Barra_Menu_ButtonClick(Barra_Menu.Buttons(Opcion))
         End If
      End If
   End If

End Sub

Private Sub Form_Load()
   Me.top = 0: Me.left = 0
   Me.Icon = FRM_MDI_PASIVO.Icon

   GLB_cOptLocal = cOpt

   On Error GoTo ErrDbf

   Call FUNC_FORMATO_GRILLA(GRD_Tdesarrollo)
   Call FUNC_TITULO_GRILLA(GRD_Tdesarrollo)

   cFormat_Decimal = FUNC_FORMATO_DECIMALES(ntdDecimales)
   
   Call PROC_LIMPIA_GRILLA

   Barra_Menu.Buttons(2).Enabled = False
   Barra_Menu.Buttons(4).Enabled = False

   Call PROC_LOG_AUDITORIA("07", GLB_cOptLocal, Me.Caption, "", "")
      
Exit Sub
ErrDbf:
   If Err.Number = 3051 Then
      MsgBox "No se puede conectar a tabla de desarrollo", vbOKOnly + vbExclamation
      Unload Me
   Else
      MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical
      Unload Me
   End If
End Sub


Private Function LIMPIAR_PANTALLA()
txt_Mascara.Enabled = True
txt_Mascara.Text = ""
Me.itbNumDecimales.Text = ""
Call PROC_LIMPIA_GRILLA
End Function


Private Sub PROC_LIMPIA_GRILLA()
   GRD_Tdesarrollo.Rows = 3
   GRD_Tdesarrollo.Rows = 2
End Sub


Private Function FUNC_CALCULA_TD()
   Dim vDatos_Retorno()
   
   FUNC_CALCULA_TD = False
   
   'cFormat_Decimal = FUNC_FORMATO_DECIMALES(ntdDecimales)
   cFormat_Decimal = FUNC_FORMATO_DECIMALES(itbNumDecimales.Text)
   GLB_Envia = Array()
   PROC_AGREGA_PARAMETRO GLB_Envia, ctdmascara                          'Máscara
   PROC_AGREGA_PARAMETRO GLB_Envia, ctdfecven                           'Fecha Vencimiento
   PROC_AGREGA_PARAMETRO GLB_Envia, ntdinteres                          'tera
   PROC_AGREGA_PARAMETRO GLB_Envia, ntdcupon                            'Cupones
   PROC_AGREGA_PARAMETRO GLB_Envia, ntdamort                            'Amortización
   PROC_AGREGA_PARAMETRO GLB_Envia, ntdPeriodo                          'Periodo Vcto Cupón
   PROC_AGREGA_PARAMETRO GLB_Envia, ntdDecimales                        'Nº de Decimales
   PROC_AGREGA_PARAMETRO GLB_Envia, IIf(Len(LTrim(Str(ntdDiaPago))) = 1, "0" + LTrim(Str(ntdDiaPago)), LTrim(Str(ntdDiaPago)))
   PROC_AGREGA_PARAMETRO GLB_Envia, Format(dFechaVen, "YYYYMMDD")
   PROC_AGREGA_PARAMETRO GLB_Envia, Format(dFechaCorte, "YYYYMMDD")
   If Not FUNC_EXECUTA_COMANDO_SQL("SP_ACT_GENERA_TD", GLB_Envia) Then
      Exit Function
   End If
   With GRD_Tdesarrollo
      Call PROC_LIMPIA_GRILLA
      Do While FUNC_LEE_RETORNO_SQL(vDatos_Retorno())
         If vDatos_Retorno(1) = "NO" Then
            MsgBox vDatos_Retorno(2), vbCritical + vbInformation
            Exit Function
         End If
         .Rows = .Rows + 1
         .Row = .Rows - 1
         .TextMatrix(.Row, nCupon) = CDbl(vDatos_Retorno(3))     'cupon
         .TextMatrix(.Row, dFecVcto) = Format(vDatos_Retorno(2), "DD/MM/YYYY") 'fecha venci
         .TextMatrix(.Row, nInteres) = Format(CDbl(vDatos_Retorno(4)), cFormat_Decimal)   'interes
         .TextMatrix(.Row, nAmortiza) = Format(CDbl(vDatos_Retorno(5)), cFormat_Decimal)  'amortizacion
         .TextMatrix(.Row, nFlujo) = Format(CDbl(vDatos_Retorno(6)), cFormat_Decimal)     'flujo
         .TextMatrix(.Row, nSaldos) = Format(CDbl(vDatos_Retorno(7)), cFormat_Decimal)    'saldo
      Loop
   End With
   GRD_Tdesarrollo.Enabled = True
   Barra_Menu.Buttons(1).Enabled = True
   FUNC_CALCULA_TD = True
End Function

Private Function PROC_GRABAR_TABLA_DESARROLLO()
   Dim f%, c%
   Dim vDatos_Retorno()
   On Error GoTo ErrGrabar

   PROC_GRABAR_TABLA_DESARROLLO = False

   With GRD_Tdesarrollo
      .Redraw = False
      
      For f% = 2 To .Rows - 1
         .Row = f%
         GLB_Envia = Array()
         PROC_AGREGA_PARAMETRO GLB_Envia, cInstrumento
         PROC_AGREGA_PARAMETRO GLB_Envia, txt_Mascara.Text
         PROC_AGREGA_PARAMETRO GLB_Envia, Val(.TextMatrix(.Row, nCupon))
         PROC_AGREGA_PARAMETRO GLB_Envia, Format(.TextMatrix(.Row, dFecVcto), "YYYYMMDD")
         PROC_AGREGA_PARAMETRO GLB_Envia, CDbl(.TextMatrix(.Row, nInteres))
         PROC_AGREGA_PARAMETRO GLB_Envia, CDbl(.TextMatrix(.Row, nAmortiza))
         PROC_AGREGA_PARAMETRO GLB_Envia, CDbl(.TextMatrix(.Row, nFlujo))
         PROC_AGREGA_PARAMETRO GLB_Envia, CDbl(.TextMatrix(.Row, nSaldos))
         
         If FUNC_EXECUTA_COMANDO_SQL("SP_ACT_GRABAR_TDESARROLLO", GLB_Envia) Then
         
            Do While FUNC_LEE_RETORNO_SQL(vDatos_Retorno())
               If vDatos_Retorno(1) = "NO" Then
                  If FUNC_EXECUTA_COMANDO_SQL("ROLLBACK TRANSACTION") Then
                     MsgBox ("Problemas al grabar, verifique que Tabla no este creada"), vbCritical
                  End If
                  Exit Function
               End If
            Loop
         Else
            If FUNC_EXECUTA_COMANDO_SQL("ROLLBACK TRANSACTION") Then
               MsgBox ("Problemas al grabar, verifique que Tabla no este creada"), vbCritical
               Exit Function
            End If
         End If
      Next f%
      .Redraw = True
   End With

         GLB_Envia = Array()
         
         PROC_AGREGA_PARAMETRO GLB_Envia, txt_Mascara.Text
         PROC_AGREGA_PARAMETRO GLB_Envia, Format(GLB_Fecha_Proceso, "YYYYMMDD")
         
         If FUNC_EXECUTA_COMANDO_SQL("SP_DEVENGA_EMISION", GLB_Envia) Then
         End If

   If FUNC_EXECUTA_COMANDO_SQL("COMMIT TRANSACTION") Then
      MsgBox ("Tabla de desarrollo grabada existosamente"), vbInformation
      Call PROC_LIMPIA_GRILLA
      Barra_Menu.Buttons(2).Enabled = False
      Barra_Menu.Buttons(4).Enabled = False
      itbNumDecimales.Text = ""
      txt_Mascara.Enabled = True
      txt_Mascara.Text = ""
      
   End If
   
   PROC_GRABAR_TABLA_DESARROLLO = True

Exit Function
ErrGrabar:
   MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical
   If FUNC_EXECUTA_COMANDO_SQL("ROLLBACK TRANSACTION") Then
   
   End If
End Function


Private Function PROC_ELIMINAR_TDESARROLLO()
   Dim vDatos_Retorno()
   
   On Error GoTo ErrEliminar
   PROC_ELIMINAR_TDESARROLLO = False

   GLB_Envia = Array()
            
   PROC_AGREGA_PARAMETRO GLB_Envia, CDbl(cInstrumento)
   PROC_AGREGA_PARAMETRO GLB_Envia, txt_Mascara.Text
   If FUNC_EXECUTA_COMANDO_SQL("SP_ELI_TDESARROLLO", GLB_Envia) Then
      Do While FUNC_LEE_RETORNO_SQL(vDatos_Retorno())
         If vDatos_Retorno(1) = "NO" Then
            If FUNC_EXECUTA_COMANDO_SQL("ROLLBACK TRANSACTION") Then
               MsgBox ("Problemas al Eliminar, verifique que Tabla este creada"), vbCritical
            End If
            Exit Function
         End If
      Loop
   End If
   
   If FUNC_EXECUTA_COMANDO_SQL("COMMIT TRANSACTION") Then
      MsgBox ("Tabla de desarrollo eliminada existosamente"), vbInformation
      Call PROC_LIMPIA_GRILLA
      Barra_Menu.Buttons(2).Enabled = False
      Barra_Menu.Buttons(4).Enabled = False
      itbNumDecimales.Text = ""
      txt_Mascara.Enabled = True
      txt_Mascara.Text = ""
   End If
    
   PROC_ELIMINAR_TDESARROLLO = True

Exit Function
ErrEliminar:
   MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical
   If FUNC_EXECUTA_COMANDO_SQL("ROLLBACK TRANSACTION") Then
   
   End If
End Function


Private Sub Grd_TDesarrollo_AfterEdit(ByVal Row As Long, ByVal Col As Long)
   On Error GoTo MAL
   Dim nInteres      As Double
   Dim nAmortizacion As Double
   Dim nFactor       As Double
   Dim nsaldoa       As Double
   Dim nValorInteres As Double

   With GRD_Tdesarrollo
      'cFormat_Decimal = FUNC_FORMATO_DECIMALES(ntdDecimales)
       cFormat_Decimal = FUNC_FORMATO_DECIMALES(itbNumDecimales.Text)
      Select Case .Col
         Case 3, 4
            If .Col = 4 Then     ' << Interes >>
               .TextMatrix(.Row, nInteres) = Format(GRD_Tdesarrollo.TextMatrix(.Row, .Col), cFormat_Decimal)
            End If
            If .Col = 3 Then     ' << Amortización >>
               .TextMatrix(.Row, nAmortiza) = Format(GRD_Tdesarrollo.TextMatrix(.Row, .Col), cFormat_Decimal)
            End If
            
            'Suma el Flujo
            ' flujo = nInteres + nAmortizacion
            .TextMatrix(.Row, nFlujo) = CDbl(.TextMatrix(.Row, 4)) + CDbl(.TextMatrix(.Row, nAmortiza))
            .TextMatrix(.Row, nFlujo) = Format(CDbl(.TextMatrix(.Row, nFlujo)), cFormat_Decimal)
                       
            'Saldo

            If .Row = 2 Then
               nFactor = 100
            Else
               nFactor = CDbl(.TextMatrix(.Row - 1, nSaldos))
            End If
            
            .TextMatrix(.Row, nSaldos) = CDbl(nFactor - CDbl(.TextMatrix(.Row, nAmortiza)))
            .TextMatrix(.Row, nSaldos) = Format(CDbl(.TextMatrix(.Row, nSaldos)), cFormat_Decimal)
      End Select
      
      .Enabled = True
      .SetFocus
        
      Call PROC_SUMA_GRILLA
      GRD_Tdesarrollo.Refresh
   
      If KeyAscii = vbKeyEscape Then
         .Enabled = True
         .SetFocus
      End If

   End With

Exit Sub
MAL:
   MsgBox ("Dato mal ingresado"), vbCritical
End Sub

Private Sub PROC_SUMA_GRILLA()
   On Error GoTo Label1
   Dim f%
   Dim nMax       As Long
   Dim nPos       As Integer
   Dim nSaldo     As Double
 
   nSaldo = 100#

   With GRD_Tdesarrollo
      Pos = .Row
      
      For f% = 2 To .Rows - 1
         If Trim$(.TextMatrix(f%, nCupon)) <> "" Then
            nSaldo = nSaldo - CDbl(.TextMatrix(f%, nAmortiza)) 'AMORTIZACION
            .TextMatrix(f%, nSaldos) = nSaldo
            If .Rows - 1 = f% Then
               .TextMatrix(f%, nAmortiza) = Format(.TextMatrix((f - 1), nSaldos), cFormat_Decimal) ' FDECIMAL
               .TextMatrix(f%, nSaldos) = 0
            End If
            
            If Mid(.TextMatrix(f%, nSaldos), 1, 1) = "-" Then
               .TextMatrix(f%, nSaldos) = Format(Mid(nSaldo, 2, Len(nSaldo)), cFormat_Decimal)
               .TextMatrix(f%, nSaldos) = "-" + .TextMatrix(f%, nSaldos)
            Else
               .TextMatrix(f%, nSaldos) = Format(.TextMatrix(f%, nSaldos), cFormat_Decimal) ' FDECIMAL
               .TextMatrix(f%, nFlujo) = Format(CDbl(.TextMatrix(f%, nAmortiza)) + CDbl(.TextMatrix(f%, nInteres)), cFormat_Decimal) ' FDECIMAL
            End If
         End If
      Next f%
      .Row = Pos
      .SetFocus
   End With

Exit Sub
Label1:
   MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical
   Exit Sub
End Sub


Private Sub Grd_TDesarrollo_KeyPress(KeyAscii As Integer)
With GRD_Tdesarrollo

'If .Rows = 3 Then Exit Sub

'    cFormat_Decimal = FUNC_FORMATO_DECIMALES(ntdDecimales)
    TXT_Texto.CantidadDecimales = itbNumDecimales.Text
    TXT_Texto.Min = 0
    TXT_Texto.Max = 99999999999#
   


   If .Col = 3 Or .Col = 4 Then
      TXT_Texto.top = .CellTop + .top + 20
      TXT_Texto.left = .CellLeft + .left + 30
      TXT_Texto.Width = .CellWidth - 20
      TXT_Texto.Height = .CellHeight
      TXT_Texto.Visible = True
   End If
   
   If KeyAscii = 13 Then
      If .Col = 3 Or .Col = 4 Then
         TXT_Texto.Text = Format(.TextMatrix(.Row, .Col), cFormat_Decimal)
      End If
   Else
      If .Col = 3 Or .Col = 4 Then
         TXT_Texto.Text = Chr(KeyAscii)
      End If
   End If
   
   If .Col = 3 Or .Col = 4 Then
      TXT_Texto.SetFocus
   End If

    
End With

End Sub

Public Function FUNC_TITULO_GRILLA(Grillas As Object)

With Grillas
          
   .Cols = 7
   .Rows = 2
   
   .ColWidth(0) = 0
   .ColWidth(1) = 1000
   .ColWidth(2) = 1500
   .ColWidth(3) = 2000
   .ColWidth(4) = 2000
   .ColWidth(5) = 2000
   .ColWidth(6) = 2000
   
   .TextMatrix(0, 1) = "Número"
   .TextMatrix(1, 1) = "Cupón"
   
   .TextMatrix(0, 2) = "Fecha "
   .TextMatrix(1, 2) = "Vencimiento"
   
   .TextMatrix(0, 3) = "Monto"
   .TextMatrix(1, 3) = "Amortización"
   
   .TextMatrix(0, 4) = "Monto"
   .TextMatrix(1, 4) = "Interes"
   
   .TextMatrix(0, 5) = "Monto"
   .TextMatrix(1, 5) = "Flujo"
   
   .TextMatrix(0, 6) = "Monto"
   .TextMatrix(1, 6) = "Saldo"
   
   .ColAlignment(1) = flexAlignRightCenter
   .ColAlignment(2) = flexAlignLeftCenter
   .ColAlignment(3) = flexAlignRightCenter
   .ColAlignment(4) = flexAlignRightCenter
   .ColAlignment(5) = flexAlignRightCenter
   .ColAlignment(6) = flexAlignRightCenter
   
         
End With

End Function

Private Sub GRD_Tdesarrollo_Scroll()
TXT_Texto.Visible = False
End Sub

Private Sub txt_Mascara_DblClick()
   Call PROC_CON_SERIES
End Sub

Private Sub txt_Mascara_KeyPress(KeyAscii As Integer)
   PROC_TO_CASE KeyAscii
   If KeyAscii = 13 Then
      Call PROC_BUSCA_TABLA_DESARROLLO
   End If
End Sub

Private Sub txt_Mascara_LostFocus()
   If txt_Mascara.Text <> Empty Then
        Call PROC_BUSCA_TABLA_DESARROLLO
   End If
End Sub

Private Sub Txt_Texto_KeyPress(KeyAscii As Integer)
On Error GoTo ErrTexto

Dim nContador As Integer
Dim vDatos_Retorno()
cEstado_ok = "N"

   PROC_TO_CASE KeyAscii

   If KeyAscii = 13 Then
    
      'If ((GRD_Tdesarrollo.Rows - 1) = GRD_Tdesarrollo.Row) Then
      '  TXT_Texto.Visible = False
      '  Exit Sub
      'End If

        
        GRD_Tdesarrollo.TextMatrix(GRD_Tdesarrollo.Row, GRD_Tdesarrollo.Col) = Format(TXT_Texto.Text, cFormat_Decimal)
        TXT_Texto.Visible = False
        cEstado_ok = "S"
        DoEvents
        
     
      If GRD_Tdesarrollo.Enabled = True Then
         GRD_Tdesarrollo.SetFocus
      End If
      
   End If
   
   If KeyAscii = 27 Then
      TXT_Texto.Visible = False
      DoEvents
      GRD_Tdesarrollo.SetFocus
   End If


ErrTexto:


End Sub

Private Sub Txt_Texto_LostFocus()
Call PROC_SUMA_GRILLA
End Sub


Private Function FUNC_BUSCAR_MASCARA()
FUNC_BUSCAR_MASCARA = False
Dim cDatos_Retorno()

    GLB_Envia = Array()
    PROC_AGREGA_PARAMETRO GLB_Envia, 0
    PROC_AGREGA_PARAMETRO GLB_Envia, txt_Mascara.Text
                
    If Not FUNC_EXECUTA_COMANDO_SQL("SP_CON_SERIES", GLB_Envia) Then
        MsgBox "Error al buscar flujos", vbInformation
        Exit Function
    End If
         
         
      If FUNC_LEE_RETORNO_SQL(cDatos_Retorno()) Then
         txt_Mascara.Text = txt_Mascara.Text
         itbNumDecimales.Text = cDatos_Retorno(18)
         ctdfecven = cDatos_Retorno(14)
         
       ' ntdinteres = cDatos_Retorno(4) 'cDatos_Retorno(7)
       
        ' VB+- 22/11/2010 Se Cambia calculo
        ' -----------------------------------------------------
          ntdinteres = cDatos_Retorno(7)
        ' -----------------------------------------------------
        ' VB ---->  Fin Cambio  PRD+7722
      
         ntdcupon = cDatos_Retorno(12)
         ntdamort = cDatos_Retorno(9)
         ntdPeriodo = cDatos_Retorno(8)
         ntdDecimales = cDatos_Retorno(18)
         ntdDiaPago = cDatos_Retorno(11) '1
         cInstrumento = cDatos_Retorno(1)
         dFechaVen = cDatos_Retorno(13)
         dFechaCorte = cDatos_Retorno(17)
         
          
         If Not FUNC_CALCULA_TD Then
            Barra_Menu.Buttons(2).Enabled = False
            Barra_Menu.Buttons(3).Enabled = False
            Barra_Menu.Buttons(4).Enabled = False
            GRD_Tdesarrollo.Enabled = False

         Else
            Barra_Menu.Buttons(2).Enabled = True
            Barra_Menu.Buttons(3).Enabled = True
            Barra_Menu.Buttons(4).Enabled = True
            GRD_Tdesarrollo.Enabled = True
            Barra_Menu.Buttons(2).Enabled = True
            Barra_Menu.Buttons(4).Enabled = True
            Me.txt_Mascara.Enabled = False
         End If
      Else
            MsgBox ("Serie no ha sido encontrada"), vbOKOnly + vbInformation
            txt_Mascara.Enabled = True
            Exit Function
      End If
      
      
FUNC_BUSCAR_MASCARA = True
End Function



Sub PROC_CON_SERIES()
On Error GoTo Error_series

      
        Pbl_cCodigo_Serie = "BONOS"
        cMiTag = "MDSE"
        FRM_AYUDA.Show 1
        If GLB_Aceptar% = True Then
        txt_Mascara.Text = GLB_codigo$
        Instrum = GLB_Instrumento$
        Call PROC_BUSCA_TABLA_DESARROLLO
        End If

Exit Sub
Error_series:
      MousePointer = 0
      MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical
      Exit Sub
      
End Sub

Private Sub PROC_BUSCA_TABLA_DESARROLLO()
   On Error GoTo Error_busca_tabla

   Dim vDatos_Retorno()

   If Me.txt_Mascara.Text = Empty Then
       MsgBox ("Debe ingresar Máscara para realizar búsqueda"), vbInformation
       txt_Mascara.SetFocus
       Exit Sub
   End If

   GLB_Envia = Array()
   PROC_AGREGA_PARAMETRO GLB_Envia, 0
   PROC_AGREGA_PARAMETRO GLB_Envia, txt_Mascara.Text
                
   If Not FUNC_EXECUTA_COMANDO_SQL("SP_CON_SERIES", GLB_Envia) Then
      MsgBox "Error al buscar flujos", vbInformation
   End If
         
   If FUNC_LEE_RETORNO_SQL(vDatos_Retorno()) Then
      txt_Mascara.Text = txt_Mascara.Text
      itbNumDecimales.Text = vDatos_Retorno(18)
   End If
     cFormat_Decimal = FUNC_FORMATO_DECIMALES(itbNumDecimales.Text)
   
   cInstrumento = Instrum
   GLB_Envia = Array()
   PROC_AGREGA_PARAMETRO GLB_Envia, 15
   PROC_AGREGA_PARAMETRO GLB_Envia, txt_Mascara.Text
    
       If Not FUNC_EXECUTA_COMANDO_SQL("SP_CON_TABLA_DESARROLLO", GLB_Envia) Then
         Screen.MousePointer = 0
         MsgBox ("Problemas al realizar búsqueda"), vbCritical
         Call PROC_LOG_AUDITORIA("01", GLB_cOptLocal, Me.Caption & " No se pudo completar la consulta ", "", "")
         Exit Sub
    Else
      With GRD_Tdesarrollo
         Call PROC_LIMPIA_GRILLA
         Do While FUNC_LEE_RETORNO_SQL(vDatos_Retorno())
            If vDatos_Retorno(1) = "NO" Then
               Exit Sub
            End If
            .Rows = .Rows + 1
            .Row = .Rows - 1
            .TextMatrix(.Row, nCupon) = CDbl(vDatos_Retorno(3))     'cupon
            .TextMatrix(.Row, dFecVcto) = Format(vDatos_Retorno(4), "DD/MM/YYYY") 'fecha venci
            .TextMatrix(.Row, nInteres) = Format(CDbl(vDatos_Retorno(5)), cFormat_Decimal)   'interes
            .TextMatrix(.Row, nAmortiza) = Format(CDbl(vDatos_Retorno(6)), cFormat_Decimal)  'amortizacion
            .TextMatrix(.Row, nFlujo) = Format(CDbl(vDatos_Retorno(7)), cFormat_Decimal)     'flujo
            .TextMatrix(.Row, nSaldos) = Format(CDbl(vDatos_Retorno(8)), cFormat_Decimal)    'saldo
         Loop
      End With

      Barra_Menu.Buttons(2).Enabled = True
      Barra_Menu.Buttons(3).Enabled = True
      Barra_Menu.Buttons(4).Enabled = True
      GRD_Tdesarrollo.Enabled = True
      Barra_Menu.Buttons(2).Enabled = True
      Barra_Menu.Buttons(4).Enabled = True
      Me.txt_Mascara.Enabled = False
   End If
Exit Sub
    
Error_busca_tabla:
        MsgBox ("Problemas en búsqueda"), vbInformation
End Sub
