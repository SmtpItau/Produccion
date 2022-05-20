VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{989C9190-EDF5-45A8-AB6C-98E6EF0384D7}#1.0#0"; "Bac_Controles_Pas.ocx"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form FRM_PORCENTAJE_COMPUTABLE 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Porcentaje Computable"
   ClientHeight    =   3780
   ClientLeft      =   5265
   ClientTop       =   3465
   ClientWidth     =   4770
   BeginProperty Font 
      Name            =   "Arial"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "FRM_PORCENTAJE_COMPUTABLE.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   3780
   ScaleWidth      =   4770
   Begin VB.Frame FMR_DETALLE 
      Height          =   3270
      Left            =   30
      TabIndex        =   2
      Top             =   525
      Width           =   4755
      Begin BACControles.TXTNumero Txt_Numero 
         Height          =   315
         Left            =   1200
         TabIndex        =   3
         TabStop         =   0   'False
         Top             =   1680
         Visible         =   0   'False
         Width           =   1095
         _ExtentX        =   1931
         _ExtentY        =   556
         BackColor       =   -2147483635
         ForeColor       =   16777215
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
         BorderStyle     =   0
         Text            =   "0,0000"
         Text            =   "0,0000"
         Min             =   "1"
         Max             =   "999999999999"
         CantidadDecimales=   "4"
         Separator       =   -1  'True
         SelStart        =   1
      End
      Begin MSFlexGridLib.MSFlexGrid Grd_Detalle_Porcentaje 
         Height          =   3045
         Left            =   15
         TabIndex        =   0
         Top             =   165
         Width           =   4695
         _ExtentX        =   8281
         _ExtentY        =   5371
         _Version        =   393216
         Cols            =   3
         FixedCols       =   0
         RowHeightMin    =   315
         BackColor       =   -2147483644
         ForeColor       =   8388608
         BackColorFixed  =   8421376
         ForeColorFixed  =   16777215
         BackColorBkg    =   -2147483644
         GridColor       =   0
         WordWrap        =   -1  'True
         GridLines       =   2
         GridLinesFixed  =   0
         PictureType     =   1
      End
   End
   Begin MSComctlLib.Toolbar tlb_Barra_Herramienta 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   1
      Top             =   0
      Width           =   4770
      _ExtentX        =   8414
      _ExtentY        =   794
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Style           =   1
      ImageList       =   "Img_opciones"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "NUEVO"
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "GRABAR"
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "SALIR"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      Begin MSComctlLib.ImageList Img_opciones 
         Left            =   3480
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
               Picture         =   "FRM_PORCENTAJE_COMPUTABLE.frx":2EFA
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PORCENTAJE_COMPUTABLE.frx":3361
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PORCENTAJE_COMPUTABLE.frx":3857
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PORCENTAJE_COMPUTABLE.frx":3CEA
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PORCENTAJE_COMPUTABLE.frx":41D2
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PORCENTAJE_COMPUTABLE.frx":46E5
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PORCENTAJE_COMPUTABLE.frx":4C22
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PORCENTAJE_COMPUTABLE.frx":5064
               Key             =   ""
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PORCENTAJE_COMPUTABLE.frx":551E
               Key             =   ""
            EndProperty
            BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PORCENTAJE_COMPUTABLE.frx":59F1
               Key             =   ""
            EndProperty
            BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PORCENTAJE_COMPUTABLE.frx":5E35
               Key             =   ""
            EndProperty
            BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PORCENTAJE_COMPUTABLE.frx":639C
               Key             =   ""
            EndProperty
            BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PORCENTAJE_COMPUTABLE.frx":686B
               Key             =   ""
            EndProperty
            BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PORCENTAJE_COMPUTABLE.frx":6C8A
               Key             =   ""
            EndProperty
            BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PORCENTAJE_COMPUTABLE.frx":7182
               Key             =   ""
            EndProperty
            BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PORCENTAJE_COMPUTABLE.frx":757B
               Key             =   ""
            EndProperty
            BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PORCENTAJE_COMPUTABLE.frx":79FE
               Key             =   ""
            EndProperty
            BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PORCENTAJE_COMPUTABLE.frx":7EC4
               Key             =   ""
            EndProperty
            BeginProperty ListImage19 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PORCENTAJE_COMPUTABLE.frx":83BB
               Key             =   ""
            EndProperty
            BeginProperty ListImage20 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PORCENTAJE_COMPUTABLE.frx":8871
               Key             =   ""
            EndProperty
            BeginProperty ListImage21 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PORCENTAJE_COMPUTABLE.frx":8C36
               Key             =   ""
            EndProperty
            BeginProperty ListImage22 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PORCENTAJE_COMPUTABLE.frx":902C
               Key             =   ""
            EndProperty
            BeginProperty ListImage23 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PORCENTAJE_COMPUTABLE.frx":9423
               Key             =   ""
            EndProperty
            BeginProperty ListImage24 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PORCENTAJE_COMPUTABLE.frx":982C
               Key             =   ""
            EndProperty
            BeginProperty ListImage25 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PORCENTAJE_COMPUTABLE.frx":9CEA
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
End
Attribute VB_Name = "FRM_PORCENTAJE_COMPUTABLE"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim cOptLocal As String

Private Sub Form_Activate()

   PROC_CARGA_AYUDA Me
   
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)

Dim nOpcion As Integer
   
   nOpcion = 0
   
   On Error Resume Next
   
    If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) Then
   
      Select Case KeyCode
      
         Case vbKeyLimpiar:
         
                           nOpcion = 1
                           
         Case vbKeyGrabar:
         
                           nOpcion = 2
                           
         Case vbKeySalir:
         
                     If UCase(Me.ActiveControl.Name) <> UCase("Txt_Numero") Then
                     
                           nOpcion = 3
                     
                     End If
      End Select
      
      If nOpcion <> 0 Then
      
         KeyCode = 0
         
         If tlb_Barra_Herramienta.Buttons(nOpcion).Enabled Then
         
            Call tlb_Barra_Herramienta_ButtonClick(tlb_Barra_Herramienta.Buttons(nOpcion))
            
         End If
      
      End If
      
   End If

End Sub

Private Sub Form_Load()

   Me.top = 0
   Me.left = 0

   Me.Icon = FRM_MDI_PASIVO.Icon
   cOptLocal = GLB_Opcion_Menu
   Grd_Detalle_Porcentaje.RowHeight(0) = 500
   Call FUNC_FORMATO_GRILLA(Grd_Detalle_Porcentaje)
   tlb_Barra_Herramienta.Buttons(2).Enabled = False
   tlb_Barra_Herramienta.Buttons(3).Enabled = False
   PROC_LIMPIA_GRILLA 1
   
   
   Call PROC_LOG_AUDITORIA("07", cOptLocal, Me.Caption, "", "")
   
End Sub

Private Sub Form_Unload(Cancel As Integer)

   Call PROC_LOG_AUDITORIA("08", cOptLocal, Me.Caption, "", "")

End Sub

Private Sub Grd_Detalle_Porcentaje_DblClick()
   
   Grd_Detalle_Porcentaje_KeyPress (13)

End Sub
Private Sub Grd_Detalle_Porcentaje_KeyDown(KeyCode As Integer, Shift As Integer)

Dim nContador As Integer
   
   If KeyCode = vbKeyInsert Then
                     
      tlb_Barra_Herramienta.Buttons(2).Enabled = True
      
      For nContador = 1 To Grd_Detalle_Porcentaje.Rows - 1
      
         
         If CDbl(Grd_Detalle_Porcentaje.TextMatrix(nContador, 1)) = 0 Then
         
            MsgBox "Falta Plazo Menor en Fila Nº" & nContador, vbInformation
            DoEvents
            Grd_Detalle_Porcentaje.SetFocus
            Exit Sub
            
         End If
         
         If CDbl(Grd_Detalle_Porcentaje.TextMatrix(nContador, 2)) = 0 And nContador > 1 Then
         
            MsgBox "Falta Porcentaje en Fila Nº" & nContador, vbInformation
            DoEvents
            Grd_Detalle_Porcentaje.SetFocus
            Exit Sub
            
         End If
         
         If CDbl(Grd_Detalle_Porcentaje.TextMatrix(nContador, 1)) <= CDbl(Grd_Detalle_Porcentaje.TextMatrix(nContador, 0)) Then
         
            MsgBox "Plazo Menor o Igual Debe ser Mayor a (Plazo Mayor Que)", vbExclamation
            DoEvents
            Grd_Detalle_Porcentaje.SetFocus
            Exit Sub
            
         End If
         
         If Grd_Detalle_Porcentaje.Col = 0 And nContador > 1 Then
         
            If CDbl(Grd_Detalle_Porcentaje.TextMatrix(nContador, 0)) < CDbl(Grd_Detalle_Porcentaje.TextMatrix(nContador - 1, 1)) Then
            
               MsgBox "Plazo Debe ser Mayor o Igual a (Plazo Menor o Igual) Anterior", vbExclamation
               DoEvents
               Grd_Detalle_Porcentaje.SetFocus
               Exit Sub
               
            End If
            
         End If
         
      Next
   
      Grd_Detalle_Porcentaje.Rows = Grd_Detalle_Porcentaje.Rows + 1
      Grd_Detalle_Porcentaje.TextMatrix(Grd_Detalle_Porcentaje.Rows - 1, 0) = Grd_Detalle_Porcentaje.TextMatrix(Grd_Detalle_Porcentaje.Rows - 2, 1)
      Grd_Detalle_Porcentaje.TextMatrix(Grd_Detalle_Porcentaje.Rows - 1, 1) = Format(0, GLB_Formato_Entero)
      Grd_Detalle_Porcentaje.TextMatrix(Grd_Detalle_Porcentaje.Rows - 1, 2) = Format(0, GLB_Formato_Decimal)
      Grd_Detalle_Porcentaje.Row = Grd_Detalle_Porcentaje.Rows - 1
      Grd_Detalle_Porcentaje.Col = 0
      DoEvents
      Grd_Detalle_Porcentaje.SetFocus
   
   End If
   
   If KeyCode = vbKeyDelete Then
   
      tlb_Barra_Herramienta.Buttons(2).Enabled = True
   
      If Grd_Detalle_Porcentaje.Rows = 2 Then
      
         Grd_Detalle_Porcentaje.TextMatrix(1, 0) = Format(0, GLB_Formato_Entero)
         Grd_Detalle_Porcentaje.TextMatrix(1, 1) = Format(1, GLB_Formato_Entero)
         Grd_Detalle_Porcentaje.TextMatrix(1, 2) = Format(0, GLB_Formato_Decimal)
         DoEvents
         Grd_Detalle_Porcentaje.SetFocus
         Exit Sub
         
      End If
      
      If Grd_Detalle_Porcentaje.Row = Grd_Detalle_Porcentaje.Rows - 1 Then
      
         Grd_Detalle_Porcentaje.RemoveItem (Grd_Detalle_Porcentaje.Row)
         
      End If
      
      DoEvents
      Grd_Detalle_Porcentaje.SetFocus
      
   End If
   
End Sub
Private Sub Grd_Detalle_Porcentaje_KeyPress(KeyAscii As Integer)

   If KeyAscii = 13 Or (KeyAscii > 47 And KeyAscii < 58) Then
      
      If Grd_Detalle_Porcentaje.Col = 0 Or Grd_Detalle_Porcentaje.Col = 1 Then
      
         Txt_Numero.CantidadDecimales = 0
         Txt_Numero.Max = "99999"
         Txt_Numero.Min = 0
         
       Else
       
         Txt_Numero.CantidadDecimales = 4
         Txt_Numero.Max = "999"
         Txt_Numero.Min = "0"
         
       End If
   
       If Grd_Detalle_Porcentaje.Col > 0 Then
       
         Txt_Numero.top = Grd_Detalle_Porcentaje.CellTop + Grd_Detalle_Porcentaje.top + 20
         Txt_Numero.left = Grd_Detalle_Porcentaje.CellLeft + Grd_Detalle_Porcentaje.left + 30
         Txt_Numero.Width = Grd_Detalle_Porcentaje.CellWidth - 20
         Txt_Numero.Height = Grd_Detalle_Porcentaje.CellHeight - 20
         Txt_Numero.Visible = True
         
         If KeyAscii = 13 Then
         
            Txt_Numero.Text = Grd_Detalle_Porcentaje.TextMatrix(Grd_Detalle_Porcentaje.Row, Grd_Detalle_Porcentaje.Col)
            
         Else
         
            Txt_Numero.Text = Chr(KeyAscii)
            
         End If
                
         Txt_Numero.SetFocus
         
       End If
       
   End If
   
End Sub
Private Sub Grd_Detalle_Porcentaje_Scroll()

   Txt_Numero.Visible = False
   
End Sub

Private Sub tlb_Barra_Herramienta_ButtonClick(ByVal Button As MSComctlLib.Button)

   Select Case UCase(Button.Key)
           
           Case "NUEVO"
               
               PROC_LIMPIA_GRILLA 2
               tlb_Barra_Herramienta.Buttons(2).Enabled = False
               tlb_Barra_Herramienta.Buttons(3).Enabled = True
           
           Case "GRABAR"
               
               If Grd_Detalle_Porcentaje.Rows = 2 And Grd_Detalle_Porcentaje.TextMatrix(1, 0) <> "" And Grd_Detalle_Porcentaje.TextMatrix(1, 1) <> "" And Grd_Detalle_Porcentaje.TextMatrix(1, 2) <> "" Then
                  
                  tlb_Barra_Herramienta.Buttons(2).Enabled = True
               
               End If
               
               PROC_GRABA_GRILLA
           
           Case "SALIR"
           
               Unload Me
               
   End Select

End Sub

Private Sub PROC_LLENA_GRILLA()
   
   Dim vDatos_Retorno()

   
   If Not FUNC_EXECUTA_COMANDO_SQL("SP_CON_PORCENTAJE") Then
      MsgBox "Problemas al cargar porcentaje computable", vbCritical
      Exit Sub
   End If
   
   Grd_Detalle_Porcentaje.Rows = 1
   
   Do While FUNC_LEE_RETORNO_SQL(vDatos_Retorno())
   
        Grd_Detalle_Porcentaje.Rows = Grd_Detalle_Porcentaje.Rows + 1
        Grd_Detalle_Porcentaje.Row = Grd_Detalle_Porcentaje.Rows - 1
        Grd_Detalle_Porcentaje.TextMatrix(Grd_Detalle_Porcentaje.Row, 0) = Format(vDatos_Retorno(2), GLB_Formato_Entero)
        Grd_Detalle_Porcentaje.TextMatrix(Grd_Detalle_Porcentaje.Row, 1) = Format(vDatos_Retorno(3), GLB_Formato_Entero)
        Grd_Detalle_Porcentaje.TextMatrix(Grd_Detalle_Porcentaje.Row, 2) = Format(vDatos_Retorno(4), GLB_Formato_Decimal)
        Grd_Detalle_Porcentaje.Row = 1
        
   Loop

   If Grd_Detalle_Porcentaje.Rows > 2 Then
      
      tlb_Barra_Herramienta.Buttons(2).Enabled = True
      tlb_Barra_Herramienta.Buttons(3).Enabled = True
   
   ElseIf Grd_Detalle_Porcentaje.Rows = 1 Then
      
      Grd_Detalle_Porcentaje.Rows = 2
      Grd_Detalle_Porcentaje.TextMatrix(1, 0) = Format(0, GLB_Formato_Entero)
      Grd_Detalle_Porcentaje.TextMatrix(1, 1) = Format(1, GLB_Formato_Entero)
      Grd_Detalle_Porcentaje.TextMatrix(1, 2) = Format(0, GLB_Formato_Decimal)
      tlb_Barra_Herramienta.Buttons(2).Enabled = True
      tlb_Barra_Herramienta.Buttons(3).Enabled = False
      Grd_Detalle_Porcentaje.Row = 1
   
   ElseIf Grd_Detalle_Porcentaje.Rows = 2 And Grd_Detalle_Porcentaje.TextMatrix(1, 0) <> "" Then
      
      tlb_Barra_Herramienta.Buttons(2).Enabled = True
      tlb_Barra_Herramienta.Buttons(3).Enabled = True
   
   End If
   
   DoEvents
   Grd_Detalle_Porcentaje.Enabled = True
      
End Sub

Private Sub PROC_LIMPIA_GRILLA(nLlamada As Integer)

   Grd_Detalle_Porcentaje.Rows = 2
   Grd_Detalle_Porcentaje.TextMatrix(0, 0) = "Plazo Mayor Que"
   Grd_Detalle_Porcentaje.TextMatrix(0, 1) = "Plazo Menor o Igual"
   Grd_Detalle_Porcentaje.TextMatrix(0, 2) = "Porcentaje"
   Grd_Detalle_Porcentaje.ColWidth(0) = 1500
   Grd_Detalle_Porcentaje.ColWidth(1) = 1700
   Grd_Detalle_Porcentaje.ColWidth(2) = 1400
   Grd_Detalle_Porcentaje.ColAlignment(0) = flexAlignRightCenter
   Grd_Detalle_Porcentaje.ColAlignment(1) = flexAlignRightCenter
   Grd_Detalle_Porcentaje.ColAlignment(2) = flexAlignRightCenter
   Grd_Detalle_Porcentaje.TextMatrix(1, 0) = Format(0, GLB_Formato_Entero)
   Grd_Detalle_Porcentaje.TextMatrix(1, 1) = Format(1, GLB_Formato_Entero)
   Grd_Detalle_Porcentaje.TextMatrix(1, 2) = Format(0, GLB_Formato_Decimal)
   Grd_Detalle_Porcentaje.Enabled = False
   tlb_Barra_Herramienta.Buttons(2).Enabled = False
   tlb_Barra_Herramienta.Buttons(3).Enabled = True
   
   PROC_LLENA_GRILLA
   
End Sub

Private Sub PROC_GRABA_GRILLA()

Dim Datos()
Dim nContador As Integer
Dim nEstado As Integer

   For nContador = 1 To Grd_Detalle_Porcentaje.Rows - 1
   
         
         If CDbl(Grd_Detalle_Porcentaje.TextMatrix(nContador, 1)) = 0 Then
         
            MsgBox "Falta Plazo Menor en Fila Nº" & nContador, vbInformation
            DoEvents
            Grd_Detalle_Porcentaje.SetFocus
            Exit Sub
            
         End If
         
         If CDbl(Grd_Detalle_Porcentaje.TextMatrix(nContador, 2)) = 0 And nContador > 1 Then
         
            MsgBox "Falta Porcentaje en Fila Nº" & nContador, vbInformation
            DoEvents
            Grd_Detalle_Porcentaje.SetFocus
            Exit Sub
            
         End If
         
         If CDbl(Grd_Detalle_Porcentaje.TextMatrix(nContador, 1)) <= CDbl(Grd_Detalle_Porcentaje.TextMatrix(nContador, 0)) Then
         
            MsgBox "Plazo Menor o Igual Debe ser Mayor a (Plazo Mayor Que)", vbExclamation
            DoEvents
            Grd_Detalle_Porcentaje.SetFocus
            Exit Sub
            
         End If
         
         If Grd_Detalle_Porcentaje.Col = 0 And nContador > 1 Then
         
            If CDbl(Grd_Detalle_Porcentaje.TextMatrix(nContador, 0)) < CDbl(Grd_Detalle_Porcentaje.TextMatrix(nContador - 1, 1)) Then
            
               MsgBox "Plazo Debe ser Mayor o Igual a (Plazo Menor o Igual) Anterior", vbExclamation
               DoEvents
               Grd_Detalle_Porcentaje.SetFocus
               Exit Sub
               
            End If
            
         End If
         
   Next

   If Not FUNC_EXECUTA_COMANDO_SQL("SP_ELI_PORCENTAJE") Then
   
      MsgBox "Problemas al grabar porcentaje conputable", vbCritical
      Exit Sub
   
   Else
      
      Do While FUNC_LEE_RETORNO_SQL(Datos())
         
         If Val(Datos(1)) = 1 Then
            
            nEstado = 0
         
         Else
            
            nEstado = 1
         
         End If
      
      Loop
   
   End If

   For nContador = 1 To Grd_Detalle_Porcentaje.Rows - 1
   
         Grd_Envia = Array()
         
         PROC_AGREGA_PARAMETRO Grd_Envia, nContador
         PROC_AGREGA_PARAMETRO Grd_Envia, CSng(Format(Grd_Detalle_Porcentaje.TextMatrix(nContador, 0), GLB_Formato_Entero))
         PROC_AGREGA_PARAMETRO Grd_Envia, CSng(Format(Grd_Detalle_Porcentaje.TextMatrix(nContador, 1), GLB_Formato_Entero))
         PROC_AGREGA_PARAMETRO Grd_Envia, CDbl(Format(Grd_Detalle_Porcentaje.TextMatrix(nContador, 2), GLB_Formato_Decimal))
         
         If Not FUNC_EXECUTA_COMANDO_SQL("SP_ACT_PORCENTAJE ", Grd_Envia) Then
         
            MsgBox "Problemas al grabar información", vbCritical
            Exit Sub
            
         End If
   Next
         
    If nEstado = 1 Then
    
       MsgBox "Grabación realizada con éxito", vbInformation
       
    Else
    
       MsgBox "Grabación realizada con éxito", vbInformation
       
    End If

End Sub

Private Sub Txt_Numero_GotFocus()
   
   Txt_Numero.SelStart = 1

End Sub

Private Sub Txt_Numero_KeyPress(KeyAscii As Integer)

Dim nContador As Integer

   If KeyAscii = 13 Then
   
      tlb_Barra_Herramienta.Buttons(2).Enabled = True
   
      If Grd_Detalle_Porcentaje.Col = 1 Then
      
         If CDbl(Txt_Numero.Text) <= CDbl(Grd_Detalle_Porcentaje.TextMatrix(Grd_Detalle_Porcentaje.Row, 0)) Then
         
            MsgBox "Plazo Debe ser Mayor a (Plazo Mayor Que)", vbExclamation
            DoEvents
            Grd_Detalle_Porcentaje.SetFocus
            Exit Sub
            
         End If
         
      End If
      
      If Grd_Detalle_Porcentaje.Col = 0 And Grd_Detalle_Porcentaje.Row > 1 Then
      
         If CDbl(Txt_Numero.Text) < CDbl(Grd_Detalle_Porcentaje.TextMatrix(Grd_Detalle_Porcentaje.Row - 1, 1)) Then
         
            MsgBox "Plazo Debe ser Mayor o Igual a (Plazo Menor o Igual) Anterior", vbExclamation
            DoEvents
            Grd_Detalle_Porcentaje.SetFocus
            Exit Sub
            
         End If
         
      End If
      
      Grd_Detalle_Porcentaje.TextMatrix(Grd_Detalle_Porcentaje.Row, Grd_Detalle_Porcentaje.Col) = (Txt_Numero.Text)
      Txt_Numero.Visible = False
      DoEvents
      
      If Grd_Detalle_Porcentaje.Enabled = True Then
      
         Grd_Detalle_Porcentaje.SetFocus
      
      End If
      
      If Grd_Detalle_Porcentaje.Col = 1 Then
         
         If Grd_Detalle_Porcentaje.Rows > 2 And Grd_Detalle_Porcentaje.Row < Grd_Detalle_Porcentaje.Rows - 1 Then
            
            For nContador = Grd_Detalle_Porcentaje.Row + 1 To Grd_Detalle_Porcentaje.Rows - 1
               
               If CDbl(Grd_Detalle_Porcentaje.TextMatrix(nContador - 1, 1)) >= 100000 Then
                  
                  MsgBox "Plazo no debe ser mayor a " & Format(100000, GLB_Formato_Entero), vbExclamation
                  DoEvents
                  Grd_Detalle_Porcentaje.SetFocus
                  Exit Sub
               
               End If
               
               Grd_Detalle_Porcentaje.TextMatrix(nContador, 0) = Format(Grd_Detalle_Porcentaje.TextMatrix(nContador - 1, 1), GLB_Formato_Entero)
               
               If CDbl(Grd_Detalle_Porcentaje.TextMatrix(nContador, 0)) >= CDbl(Grd_Detalle_Porcentaje.TextMatrix(nContador, 1)) Then
                  
                  If CDbl(Grd_Detalle_Porcentaje.TextMatrix(nContador, 0) + 1) >= 100000 Then
                     
                     MsgBox "Plazo no debe ser mayor a " & Format(100000, GLB_Formato_Entero), vbExclamation
                     DoEvents
                     Grd_Detalle_Porcentaje.SetFocus
                     Exit Sub
                  
                  End If
                  
                  Grd_Detalle_Porcentaje.TextMatrix(nContador, 1) = Format(Grd_Detalle_Porcentaje.TextMatrix(nContador, 0) + 1, GLB_Formato_Entero)
               
               End If
            
            Next
         
         End If
         
      End If
      
   End If
   
   If KeyAscii = 27 Then
   
      Txt_Numero.Visible = False
      DoEvents
      Grd_Detalle_Porcentaje.SetFocus
      
   End If

End Sub
Private Sub Txt_Numero_LostFocus()

   Txt_Numero.Visible = False
   
End Sub
