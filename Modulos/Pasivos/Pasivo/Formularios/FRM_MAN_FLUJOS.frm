VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{989C9190-EDF5-45A8-AB6C-98E6EF0384D7}#1.0#0"; "BACControles.ocx"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form FRM_MAN_FLUJOS 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Cálculo de Flujos"
   ClientHeight    =   5370
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   10680
   Icon            =   "FRM_MAN_FLUJOS.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   5370
   ScaleWidth      =   10680
   Begin BACControles.TXTFecha TXT_Fecha 
      Height          =   330
      Left            =   2925
      TabIndex        =   4
      Top             =   3930
      Visible         =   0   'False
      Width           =   1815
      _ExtentX        =   3201
      _ExtentY        =   582
      BackColor       =   8388608
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
      ForeColor       =   16777215
      MaxDate         =   2958465
      MinDate         =   -328716
      Text            =   "23/04/2003"
   End
   Begin BACControles.TXTNumero TXT_Texto 
      Height          =   300
      Left            =   1785
      TabIndex        =   3
      Top             =   3255
      Visible         =   0   'False
      Width           =   2010
      _ExtentX        =   3545
      _ExtentY        =   529
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
      Max             =   "9999"
      Separator       =   -1  'True
   End
   Begin MSComctlLib.Toolbar TLB_MENU 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   10680
      _ExtentX        =   18838
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
            Key             =   "Aceptar"
            Object.ToolTipText     =   "Aceptar"
            ImageIndex      =   6
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   10
         EndProperty
      EndProperty
      Begin MSComctlLib.ImageList Img_opciones 
         Left            =   7800
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
               Picture         =   "FRM_MAN_FLUJOS.frx":2EFA
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_FLUJOS.frx":3361
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_FLUJOS.frx":3857
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_FLUJOS.frx":3CEA
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_FLUJOS.frx":41D2
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_FLUJOS.frx":46E5
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_FLUJOS.frx":4C22
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_FLUJOS.frx":5064
               Key             =   ""
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_FLUJOS.frx":551E
               Key             =   ""
            EndProperty
            BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_FLUJOS.frx":59F1
               Key             =   ""
            EndProperty
            BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_FLUJOS.frx":5E35
               Key             =   ""
            EndProperty
            BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_FLUJOS.frx":639C
               Key             =   ""
            EndProperty
            BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_FLUJOS.frx":686B
               Key             =   ""
            EndProperty
            BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_FLUJOS.frx":6C8A
               Key             =   ""
            EndProperty
            BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_FLUJOS.frx":7182
               Key             =   ""
            EndProperty
            BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_FLUJOS.frx":757B
               Key             =   ""
            EndProperty
            BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_FLUJOS.frx":79FE
               Key             =   ""
            EndProperty
            BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_FLUJOS.frx":7EC4
               Key             =   ""
            EndProperty
            BeginProperty ListImage19 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_FLUJOS.frx":83BB
               Key             =   ""
            EndProperty
            BeginProperty ListImage20 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_FLUJOS.frx":8871
               Key             =   ""
            EndProperty
            BeginProperty ListImage21 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_FLUJOS.frx":8C36
               Key             =   ""
            EndProperty
            BeginProperty ListImage22 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_FLUJOS.frx":902C
               Key             =   ""
            EndProperty
            BeginProperty ListImage23 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_FLUJOS.frx":9423
               Key             =   ""
            EndProperty
            BeginProperty ListImage24 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_FLUJOS.frx":982C
               Key             =   ""
            EndProperty
            BeginProperty ListImage25 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MAN_FLUJOS.frx":9CEA
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin BACControles.TXTNumero TXT_Grilla 
      Height          =   255
      Left            =   3195
      TabIndex        =   1
      TabStop         =   0   'False
      Top             =   2820
      Visible         =   0   'False
      Width           =   1095
      _ExtentX        =   1931
      _ExtentY        =   450
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
      Appearance      =   0
      Text            =   "0"
      Text            =   "0"
      Min             =   "1"
      Max             =   "99999"
      Separator       =   -1  'True
   End
   Begin MSFlexGridLib.MSFlexGrid GRD_Flujos 
      Height          =   4845
      Left            =   -15
      TabIndex        =   2
      Top             =   540
      Width           =   10680
      _ExtentX        =   18838
      _ExtentY        =   8546
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
Attribute VB_Name = "FRM_MAN_FLUJOS"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim cVentana As Form
Dim cFormat_Decimal As String
Dim cCapitaliza As String
Dim cEstado_ok As String
Dim nSaldo As Variant

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
Dim nOpcion        As Integer

   On Error GoTo Errores
   nOpcion = 0
   
   If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) Then
      
      Select Case KeyCode
      
      Case VbkeyAceptar
         nOpcion = 1

      Case vbKeySalir:
         If Me.ActiveControl.Name <> "TXT_Texto" Then
            If Me.ActiveControl.Name <> "TXT_Fecha" Then
                nOpcion = 2
            End If
         End If

      End Select

      If nOpcion <> 0 Then
         If TLB_Menu.Buttons(nOpcion).Enabled Then
            Call TLB_Menu_ButtonClick(TLB_Menu.Buttons(nOpcion))
         End If
         KeyCode = 0
      End If

   End If

   On Error GoTo 0
   Exit Sub

Errores:
   Resume Next
   On Error GoTo 0

End Sub

Private Sub Form_Load()
On Error GoTo ErrDbf

Me.Icon = FRM_MDI_PASIVO.Icon
Me.top = 1150
Me.left = 30


If GLB_cOptLocal = "Opcion_Menu_3201" Then
    Set cVentana = FRM_ING_CORFO
ElseIf GLB_cOptLocal = "Opcion_Menu_3202" Then
    Set cVentana = FRM_ING_BANCO_LOCAL
ElseIf GLB_cOptLocal = "Opcion_Menu_3203" Then
    Set cVentana = FRM_ING_BANCO_EXT
End If


GLB_cOptLocal = "Mantenedor de Flujos"
cFormat_Decimal = FUNC_FORMATO_DECIMALES(GLB_Cantidad_Decimal)
Call FUNC_FORMATO_GRILLA(GRD_Flujos)
Call PROC_TITULOS_GRILLA

Call PROC_LOG_AUDITORIA("07", GLB_cOptLocal, Me.Caption, "", "")

   If Val(cVentana.Txt_Numero_Operacion.Text) = 0 Then
      Call PROC_CALCULAR_FLUJOS
   Else
      Call PROC_CARGA_FLUJOS
   End If
Exit Sub
ErrDbf:
  If Err.Number = 3051 Then
     MsgBox "No se puede conectar a tabla de desarrollo", vbOKOnly + vbExclamation
     Unload Me
     Exit Sub
  Else
     MsgBox "Error : " & Err.Description, vbOKOnly + vbCritical
     Unload Me
     Exit Sub
   End If

End Sub

Sub PROC_TITULOS_GRILLA()

With GRD_Flujos
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
   .TextMatrix(1, 1) = "Flujo"
   
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
End Sub

Sub PROC_CALCULAR_FLUJOS()
On Error GoTo Err_Cons
Dim cDatos_Retorno()
Dim nIndice As Integer

With cVentana

    GLB_Envia = Array()
    PROC_AGREGA_PARAMETRO GLB_Envia, ""
    PROC_AGREGA_PARAMETRO GLB_Envia, CDbl(.TXT_Familia.Text)
    PROC_AGREGA_PARAMETRO GLB_Envia, CDbl(.FTB_Monto.Text)
    PROC_AGREGA_PARAMETRO GLB_Envia, IIf(.CMB_Tipo_Tasa.ItemData(.CMB_Tipo_Tasa.ListIndex) = 333, CDbl(.FTB_Tasa.Text) + CDbl(.FTB_Spread.Text), CDbl(.FTB_Tasa.Text) + CDbl(.FTB_Spread.Text))
    PROC_AGREGA_PARAMETRO GLB_Envia, CDbl(.CMB_Base.ItemData(.CMB_Base.ListIndex))
    PROC_AGREGA_PARAMETRO GLB_Envia, Format(.TXT_Fecha_Otor.Text, "YYYYMMDD")
    PROC_AGREGA_PARAMETRO GLB_Envia, Format(.TXT_Fecha_Ven.Text, "YYYYMMDD")
    PROC_AGREGA_PARAMETRO GLB_Envia, Format(.TXT_Fecha_Cuota.Text, "YYYYMMDD")
    PROC_AGREGA_PARAMETRO GLB_Envia, CDbl(.FTB_Cuotas.Text)
    PROC_AGREGA_PARAMETRO GLB_Envia, CDbl(.FTB_Gracia.Text)
    PROC_AGREGA_PARAMETRO GLB_Envia, IIf(.SCHK_Capitaliza.Value = True, "S", "N")
    PROC_AGREGA_PARAMETRO GLB_Envia, Format(.TXT_Fecha_Capitaliza.Text, "YYYYMMDD")
    PROC_AGREGA_PARAMETRO GLB_Envia, CDbl(.FTB_Decimales.Text)
    PROC_AGREGA_PARAMETRO GLB_Envia, CDbl(.CMB_Periodo.ItemData(.CMB_Periodo.ListIndex))
                
    If Not FUNC_EXECUTA_COMANDO_SQL("SP_PRO_GENERA_FLUJOS", GLB_Envia) Then
        MsgBox "Error al generar flujos", vbInformation
        Exit Sub
    End If
         
    GLB_Envia = Array()
    If Not FUNC_EXECUTA_COMANDO_SQL("SP_CON_LEER_TABLA_ING", GLB_Envia) Then
        MsgBox "Error al leer Tabla", vbInformation
        Exit Sub
    End If
    
         With GRD_Flujos
         .Rows = 2
         
         Do While FUNC_LEE_RETORNO_SQL(cDatos_Retorno())
         
             .Rows = .Rows + 1
             nIndice = .Rows - 1
            .TextMatrix(nIndice, 1) = cDatos_Retorno(1)
            .TextMatrix(nIndice, 2) = cDatos_Retorno(2)
            .TextMatrix(nIndice, 3) = Format(cDatos_Retorno(3), cFormat_Decimal)
            .TextMatrix(nIndice, 4) = Format(cDatos_Retorno(4), cFormat_Decimal)
            .TextMatrix(nIndice, 5) = Format(cDatos_Retorno(5), cFormat_Decimal)
            .TextMatrix(nIndice, 6) = Format(cDatos_Retorno(6), cFormat_Decimal)
            
         Loop
        End With

cCapitaliza = "N"
If cVentana.SCHK_Capitaliza.Value = True Then
    cCapitaliza = "S"
End If
End With
Exit Sub
Err_Cons:
   MsgBox Err.Description

End Sub

Private Sub GRD_Flujos_KeyPress(KeyAscii As Integer)
Dim vDatos_Retorno()

    If cVentana.Txt_Numero_Operacion.Text <> 0 Then
      Exit Sub
    End If

   TXT_Texto.CantidadDecimales = 4
   TXT_Texto.Min = 0
   TXT_Texto.Max = 99999999999#
   
   If GRD_Flujos.Col = 3 And cCapitaliza = "N" Then
      TXT_Texto.top = GRD_Flujos.CellTop + GRD_Flujos.top + 20
      TXT_Texto.left = GRD_Flujos.CellLeft + GRD_Flujos.left + 30
      TXT_Texto.Width = GRD_Flujos.CellWidth - 20
      TXT_Texto.Height = GRD_Flujos.CellHeight
      TXT_Texto.Visible = True
   End If
   
   If KeyAscii = 13 Then
      If GRD_Flujos.Col = 3 And cCapitaliza = "N" Then
         TXT_Texto.Text = Format(GRD_Flujos.TextMatrix(GRD_Flujos.Row, GRD_Flujos.Col), cFormat_Decimal)
      End If
   Else
      If GRD_Flujos.Col = 3 And cCapitaliza = "N" Then
         TXT_Texto.Text = Chr(KeyAscii)
      End If
   End If
   
   If GRD_Flujos.Col = 3 And cCapitaliza = "N" Then
      TXT_Texto.SetFocus
   End If


   If GRD_Flujos.Col = 2 And cCapitaliza = "N" Then
      Txt_Fecha.top = GRD_Flujos.CellTop + GRD_Flujos.top + 20
      Txt_Fecha.left = GRD_Flujos.CellLeft + GRD_Flujos.left + 30
      Txt_Fecha.Width = GRD_Flujos.CellWidth - 20
      Txt_Fecha.Height = GRD_Flujos.CellHeight
      
      Txt_Fecha.Visible = True
   End If
   
   If KeyAscii = 13 Then
      If GRD_Flujos.Col = 2 And cCapitaliza = "N" Then
         Txt_Fecha.Text = Format(GRD_Flujos.TextMatrix(GRD_Flujos.Row, GRD_Flujos.Col), "DD/MM/YYYY")
      End If
   Else
      If GRD_Flujos.Col = 2 And cCapitaliza = "N" Then
         Txt_Fecha.Text = Chr(KeyAscii)
      End If
   End If
   
   If GRD_Flujos.Col = 2 And cCapitaliza = "N" Then
      Txt_Fecha.SetFocus
   End If

End Sub

Private Sub GRD_Flujos_Scroll()
    TXT_Grilla.Visible = False
    Txt_Fecha.Visible = False
    TXT_Texto.Visible = False
End Sub

Private Sub TLB_Menu_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Trim(UCase(Button.Key))
Case "ACEPTAR"
    Cancel = True
    Me.Hide
    GLB_Confirmar = True

Case "SALIR"
    Unload Me
    GLB_Confirmar = False
End Select

End Sub

Private Sub TXT_Fecha_KeyPress(KeyAscii As Integer)
Dim nContador As Integer
Dim vDatos_Retorno()
cEstado_ok = "N"
   
   PROC_TO_CASE KeyAscii

   If KeyAscii = 13 Then
   
   

'      If ((GRD_Flujos.Rows - 1) = GRD_Flujos.Row) Or GRD_Flujos.Row = 2 Then
'        TXT_Fecha.Visible = False
'        Exit Sub
'      End If
      
      
      If GRD_Flujos.Row - 1 > 1 Then
        If CDate(Txt_Fecha.Text) <= CDate(GRD_Flujos.TextMatrix(GRD_Flujos.Row - 1, 2)) Then
          Txt_Fecha.Visible = False
          Exit Sub
        End If
      End If
      If GRD_Flujos.Row + 1 < GRD_Flujos.Rows Then
            If CDate(Txt_Fecha.Text) >= CDate(GRD_Flujos.TextMatrix(GRD_Flujos.Row + 1, 2)) Then
              Txt_Fecha.Visible = False
              Exit Sub
            End If
      End If
            If CDate(GRD_Flujos.TextMatrix(GRD_Flujos.Row, GRD_Flujos.Col)) <> CDate(Txt_Fecha.Text) Then
            
            GRD_Flujos.TextMatrix(GRD_Flujos.Row, GRD_Flujos.Col) = Format(Txt_Fecha.Text, "DD/MM/YYYY")
            Txt_Fecha.Visible = False
            DoEvents
            
              If GRD_Flujos.Enabled = True Then
                   GRD_Flujos.SetFocus
              End If
              cEstado_ok = "S"
              Call PROC_RECALCULAR_FLUJOS
            Else
              Txt_Fecha.Visible = False
            End If
            
      
        
      
   End If
   
   If KeyAscii = 27 Then
      Txt_Fecha.Visible = False
      DoEvents
      GRD_Flujos.SetFocus
   End If

End Sub

Private Sub TXT_FECHA_LostFocus()
If cEstado_ok = "S" Then
   Txt_Fecha.Visible = False
   Call PROC_RECALCULAR_FLUJOS
End If

End Sub

Private Sub Txt_Texto_GotFocus()
   TXT_Texto.SelStart = 1
End Sub

Private Sub Txt_Texto_KeyPress(KeyAscii As Integer)
On Error GoTo ErrTexto

Dim nContador As Integer
Dim vDatos_Retorno()
cEstado_ok = "N"

   PROC_TO_CASE KeyAscii

   If KeyAscii = 13 Then
    
      If ((GRD_Flujos.Rows - 1) = GRD_Flujos.Row) Then
        TXT_Texto.Visible = False
        Exit Sub
      End If

      
            
      If CDbl(TXT_Texto.Text) >= CDbl(cVentana.FTB_Monto.Text) Then
        MsgBox ("A ingresado un monto mayor o igual al emitido"), vbOKOnly + vbInformation
        TXT_Texto.Visible = False
      Else
      
        nSaldo = CDbl(cVentana.FTB_Monto.Text) - CDbl(TXT_Texto.Text)
      
      
        If GRD_Flujos.Row > 2 Then
            
            If CDbl(TXT_Texto.Text) > CDbl(GRD_Flujos.TextMatrix((GRD_Flujos.Row - 1), 6)) Then
                MsgBox ("Ha Ingresado un monto que ha superado el saldo"), vbOKOnly + vbInformation
                TXT_Texto.Visible = False
                Exit Sub
            End If
            
            
            If CDbl(TXT_Texto.Text) = CDbl(GRD_Flujos.TextMatrix((GRD_Flujos.Row - 1), 6)) And GRD_Flujos.Rows <> GRD_Flujos.Row Then
                MsgBox ("El monto ingresado no coincide en número de cuotas y el saldo"), vbOKOnly + vbInformation
                TXT_Texto.Visible = False
                Exit Sub
            End If
            nSaldo = CDbl(GRD_Flujos.TextMatrix((GRD_Flujos.Row - 1), 6)) - CDbl(TXT_Texto.Text)
        End If
        
        
        GRD_Flujos.TextMatrix(GRD_Flujos.Row, GRD_Flujos.Col) = Format(TXT_Texto.Text, cFormat_Decimal)
        Call PROC_RECALCULAR_FLUJOS
        TXT_Texto.Visible = False
        cEstado_ok = "S"
        DoEvents
        
      End If
      
      If GRD_Flujos.Enabled = True Then
         GRD_Flujos.SetFocus
      End If
      
   End If
   
   If KeyAscii = 27 Then
      TXT_Texto.Visible = False
      DoEvents
      GRD_Flujos.SetFocus
   End If

ErrTexto:

End Sub
Private Sub Txt_Texto_LostFocus()
   If cEstado_ok = "S" Then
        TXT_Texto.Visible = False
        Call PROC_RECALCULAR_FLUJOS
   End If
End Sub

Sub PROC_RECALCULAR_FLUJOS()
On Error GoTo ErrCal

Dim nContador  As Integer
Dim nMonto_original As Variant
Dim dFecha_Desde As Variant
Dim dFecha_Hasta As Variant
Dim vDatos_Retorno()
Dim ntotal_cuotas As Variant
Dim nValor_posicion As Integer
Dim Posicion As Integer

nValor_posicion = GRD_Flujos.Row

nMonto_original = CDbl(cVentana.FTB_Monto.Text)
With GRD_Flujos

If (.Row = .Rows - 1) Or .Rows = 3 Then
    ntotal_cuotas = 0
    '.TextMatrix(.Row, 3) = Format(CDbl(nMonto_original), cFormat_Decimal)
    Exit Sub
Else
ntotal_cuotas = Format(((CDbl(cVentana.FTB_Monto.Text) - CDbl(TXT_Texto.Text)) / ((CDbl(cVentana.FTB_Cuotas.Text) - CDbl(cVentana.FTB_Gracia.Text)))), cFormat_Decimal)
'ntotal_cuotas = Format((nSaldo / ((GRD_Flujos.Rows - 1) - GRD_Flujos.Row)), cFormat_Decimal)
End If
    For nContador = 2 To GRD_Flujos.Rows - 1
        
        If nContador = 2 Then
            nMonto_original = CDbl(cVentana.FTB_Monto.Text)
            dFecha_Desde = Format(cVentana.TXT_Fecha_Otor.Text, "YYYYMMDD")
        Else
            nMonto_original = CDbl(GRD_Flujos.TextMatrix(nContador - 1, 6))
            dFecha_Desde = Format(GRD_Flujos.TextMatrix(nContador - 1, 2), "YYYYMMDD")
        End If
    
        If nContador > nValor_posicion Then
            .TextMatrix(nContador, 3) = Format(ntotal_cuotas, cFormat_Decimal)
        End If
        If nContador = .Rows - 1 Then
            .TextMatrix(nContador, 3) = .TextMatrix(nContador - 1, 6)
        Else
            If nContador = 2 Then
                .TextMatrix(nContador, 6) = Format(nMonto_original - .TextMatrix(nContador, 3), cFormat_Decimal)
            Else
                .TextMatrix(nContador, 6) = Format(.TextMatrix(nContador - 1, 6) - .TextMatrix(nContador, 3), cFormat_Decimal)
            End If
        End If
    
        GLB_Envia = Array()
        PROC_AGREGA_PARAMETRO GLB_Envia, CDbl(cVentana.TXT_Familia.Text)
        PROC_AGREGA_PARAMETRO GLB_Envia, nMonto_original
        PROC_AGREGA_PARAMETRO GLB_Envia, CDbl(cVentana.FTB_Tasa.Text)
        PROC_AGREGA_PARAMETRO GLB_Envia, CDbl(cVentana.CMB_Base.ItemData(cVentana.CMB_Base.ListIndex))
        PROC_AGREGA_PARAMETRO GLB_Envia, dFecha_Desde
        PROC_AGREGA_PARAMETRO GLB_Envia, Format(.TextMatrix(nContador, 2), "YYYYMMDD")
  
        If Not FUNC_EXECUTA_COMANDO_SQL("SP_PRO_INTERES_FLUJO", GLB_Envia) Then
            MsgBox "Error al generar flujos", vbInformation
            Exit Sub
        End If
        If Not FUNC_EXECUTA_COMANDO_SQL("SP_CON_LEER_TABLA") Then
            MsgBox "Error al generar flujos", vbInformation
            Exit Sub
        End If
        
        For Posicion = 2 To nContador
              If FUNC_LEE_RETORNO_SQL(vDatos_Retorno()) Then
                  If Posicion = nContador Then
                    .TextMatrix(nContador, 4) = Format(vDatos_Retorno(4), cFormat_Decimal)
                    .TextMatrix(nContador, 5) = Format(CDbl((.TextMatrix(nContador, 3)) + CDbl(.TextMatrix(nContador, 4))), cFormat_Decimal)
                    .TextMatrix(nContador, 6) = Format(nMonto_original - CDbl(.TextMatrix(nContador, 3)), cFormat_Decimal)
                  End If
              End If
        Next Posicion
        
    'End If
    
    Next nContador
End With

ErrCal:

End Sub

Sub PROC_CARGA_FLUJOS()
Dim cDatos_Retorno()
Dim nIndice As Integer

    GLB_Envia = Array()
    PROC_AGREGA_PARAMETRO GLB_Envia, CDbl(cVentana.Txt_Numero_Operacion.Text)
                
    If Not FUNC_EXECUTA_COMANDO_SQL("SP_CON_FLUJOS", GLB_Envia) Then
        MsgBox "Error al buscar flujos", vbInformation
        Exit Sub
    End If
         
         With GRD_Flujos
            .Rows = 2
            
            Do While FUNC_LEE_RETORNO_SQL(cDatos_Retorno())
            
                .Rows = .Rows + 1
                nIndice = .Rows - 1
               .TextMatrix(nIndice, 1) = cDatos_Retorno(1)
               .TextMatrix(nIndice, 2) = cDatos_Retorno(2)
               .TextMatrix(nIndice, 3) = Format(cDatos_Retorno(3), cFormat_Decimal)
               .TextMatrix(nIndice, 4) = Format(cDatos_Retorno(4), cFormat_Decimal)
               .TextMatrix(nIndice, 5) = Format(cDatos_Retorno(5), cFormat_Decimal)
               .TextMatrix(nIndice, 6) = Format(cDatos_Retorno(6), cFormat_Decimal)
               
            Loop
        End With

End Sub
