VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{989C9190-EDF5-45A8-AB6C-98E6EF0384D7}#1.0#0"; "Bac_Controles_Pas.ocx"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form FRM_MANTENEDOR_INSTRUMENTOS 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantenedor de Instrumentos"
   ClientHeight    =   6255
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   9855
   Icon            =   "FRM_MANTENEDOR_INSTRUMENTOS.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   6255
   ScaleWidth      =   9855
   Begin Threed.SSFrame SSFrame1 
      Height          =   5745
      Left            =   -15
      TabIndex        =   3
      Top             =   510
      Width           =   9690
      _Version        =   65536
      _ExtentX        =   17092
      _ExtentY        =   10134
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
      Begin Threed.SSFrame SSFrame2 
         Height          =   765
         Left            =   60
         TabIndex        =   4
         Top             =   120
         Width           =   9465
         _Version        =   65536
         _ExtentX        =   16695
         _ExtentY        =   1349
         _StockProps     =   14
         Caption         =   "Producto"
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Begin VB.ComboBox Cmb_Producto 
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   330
            Left            =   1980
            Style           =   2  'Dropdown List
            TabIndex        =   0
            Top             =   270
            Width           =   4005
         End
      End
      Begin Threed.SSFrame SSFrame3 
         Height          =   4785
         Left            =   60
         TabIndex        =   5
         Top             =   900
         Width           =   9465
         _Version        =   65536
         _ExtentX        =   16695
         _ExtentY        =   8440
         _StockProps     =   14
         Caption         =   "Instrumentos Asociados"
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Begin BACControles.TXTNumero TxtGrilla 
            Height          =   255
            Left            =   3240
            TabIndex        =   7
            TabStop         =   0   'False
            Top             =   2490
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
         Begin VB.TextBox TxtTexto 
            Appearance      =   0  'Flat
            BackColor       =   &H00800000&
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000E&
            Height          =   285
            Left            =   3060
            TabIndex        =   6
            Top             =   1740
            Visible         =   0   'False
            Width           =   1635
         End
         Begin MSFlexGridLib.MSFlexGrid Grd_Instrumentos 
            Height          =   4515
            Left            =   30
            TabIndex        =   1
            Top             =   225
            Width           =   9405
            _ExtentX        =   16589
            _ExtentY        =   7964
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
            FocusRect       =   0
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
   End
   Begin MSComctlLib.Toolbar Tlb_Mant_Instrumento 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   2
      Top             =   0
      Width           =   9855
      _ExtentX        =   17383
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
            Description     =   "Limpiar"
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Grabar"
            Description     =   "Grabar"
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.Visible         =   0   'False
            Key             =   "Eliminar"
            Description     =   "Eliminar"
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Buscar"
            Description     =   "Buscar"
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Description     =   "Salir"
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
               Picture         =   "FRM_MANTENEDOR_INSTRUMENTOS.frx":2EFA
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MANTENEDOR_INSTRUMENTOS.frx":3361
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MANTENEDOR_INSTRUMENTOS.frx":3857
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MANTENEDOR_INSTRUMENTOS.frx":3CEA
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MANTENEDOR_INSTRUMENTOS.frx":41D2
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MANTENEDOR_INSTRUMENTOS.frx":46E5
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MANTENEDOR_INSTRUMENTOS.frx":4C22
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MANTENEDOR_INSTRUMENTOS.frx":5064
               Key             =   ""
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MANTENEDOR_INSTRUMENTOS.frx":551E
               Key             =   ""
            EndProperty
            BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MANTENEDOR_INSTRUMENTOS.frx":59F1
               Key             =   ""
            EndProperty
            BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MANTENEDOR_INSTRUMENTOS.frx":5E35
               Key             =   ""
            EndProperty
            BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MANTENEDOR_INSTRUMENTOS.frx":639C
               Key             =   ""
            EndProperty
            BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MANTENEDOR_INSTRUMENTOS.frx":686B
               Key             =   ""
            EndProperty
            BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MANTENEDOR_INSTRUMENTOS.frx":6C8A
               Key             =   ""
            EndProperty
            BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MANTENEDOR_INSTRUMENTOS.frx":7182
               Key             =   ""
            EndProperty
            BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MANTENEDOR_INSTRUMENTOS.frx":757B
               Key             =   ""
            EndProperty
            BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MANTENEDOR_INSTRUMENTOS.frx":79FE
               Key             =   ""
            EndProperty
            BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MANTENEDOR_INSTRUMENTOS.frx":7EC4
               Key             =   ""
            EndProperty
            BeginProperty ListImage19 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MANTENEDOR_INSTRUMENTOS.frx":83BB
               Key             =   ""
            EndProperty
            BeginProperty ListImage20 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MANTENEDOR_INSTRUMENTOS.frx":8871
               Key             =   ""
            EndProperty
            BeginProperty ListImage21 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MANTENEDOR_INSTRUMENTOS.frx":8C36
               Key             =   ""
            EndProperty
            BeginProperty ListImage22 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MANTENEDOR_INSTRUMENTOS.frx":902C
               Key             =   ""
            EndProperty
            BeginProperty ListImage23 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MANTENEDOR_INSTRUMENTOS.frx":9423
               Key             =   ""
            EndProperty
            BeginProperty ListImage24 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MANTENEDOR_INSTRUMENTOS.frx":982C
               Key             =   ""
            EndProperty
            BeginProperty ListImage25 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_MANTENEDOR_INSTRUMENTOS.frx":9CEA
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
End
Attribute VB_Name = "FRM_MANTENEDOR_INSTRUMENTOS"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim cOptLocal     As String
Dim nCantidad     As Integer

Private Sub Form_Activate()
   Call PROC_CARGA_AYUDA(Me)
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
   Dim nOpcion        As Integer

   On Error GoTo Errores
   nOpcion = 0

   If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) Then
      Select Case KeyCode
         Case vbKeyLimpiar
            nOpcion = 1
         Case vbKeyGrabar:
            nOpcion = 2
         Case vbKeyEliminar:
            nOpcion = 3
         Case vbKeyBuscar:
            nOpcion = 4
         Case vbKeySalir:
            If Me.ActiveControl.Name <> "TxtTexto" And Me.ActiveControl.Name <> "TxtGrilla" Then
               nOpcion = 5
            End If
      End Select

      If nOpcion <> 0 Then
         If Tlb_Mant_Instrumento.Buttons(nOpcion).Enabled Then
            Call Tlb_Mant_Instrumento_ButtonClick(Tlb_Mant_Instrumento.Buttons(nOpcion))
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

   Me.Icon = FRM_MDI_PASIVO.Icon
   cOptLocal = GLB_Opcion_Menu
   
   Call PROC_LOG_AUDITORIA("07", cOptLocal, Me.Caption, "", "")

   On Error GoTo BacErrorHandler

   Me.top = 0
   Me.left = 0
   
   Call FUNC_FORMATO_GRILLA(Grd_Instrumentos)

   Call PROC_TITULOS_GRILLA

   Call PROC_LLENAR_COMBO_PRODUCTO
   
   nCantidad = 0
   
   Grd_Instrumentos.Enabled = False
   Tlb_Mant_Instrumento.Buttons(2).Enabled = False
   Tlb_Mant_Instrumento.Buttons(3).Enabled = False

BacErrorHandler:

End Sub

Sub PROC_TITULOS_GRILLA()

   Grd_Instrumentos.Cols = 7
   Grd_Instrumentos.Rows = 2
   
   Grd_Instrumentos.ColWidth(0) = 0
   Grd_Instrumentos.ColWidth(1) = 1300
   Grd_Instrumentos.ColWidth(2) = 1500
   Grd_Instrumentos.ColWidth(3) = 4500
   Grd_Instrumentos.ColWidth(4) = 0
   Grd_Instrumentos.ColWidth(5) = 0
   Grd_Instrumentos.ColWidth(6) = 1500
   
   Grd_Instrumentos.TextMatrix(0, 1) = "Codigo"
   Grd_Instrumentos.TextMatrix(1, 1) = "Instrumento"
   
   Grd_Instrumentos.TextMatrix(0, 2) = "Glosa"
   Grd_Instrumentos.TextMatrix(1, 2) = "Instrumento"
   
   Grd_Instrumentos.TextMatrix(0, 3) = "Nombre"
   Grd_Instrumentos.TextMatrix(1, 3) = "Instrumento"
   
   Grd_Instrumentos.TextMatrix(0, 6) = "Codigo"
   Grd_Instrumentos.TextMatrix(1, 6) = "Contable"

   Grd_Instrumentos.ColAlignment(2) = flexAlignRightCenter
   Grd_Instrumentos.ColAlignment(2) = flexAlignLeftCenter
   Grd_Instrumentos.ColAlignment(3) = flexAlignLeftCenter
   Grd_Instrumentos.ColAlignment(6) = flexAlignLeftCenter

   Grd_Instrumentos.FocusRect = flexFocusLight
   
End Sub

Function FUNC_CODIGO_INSTRUMENTO() As Integer
   Dim vDatos_Retorno()

   If Not FUNC_EXECUTA_COMANDO_SQL("SP_CON_COD_INST_MAX") Then
      Exit Function
   End If
   
   Do While FUNC_LEE_RETORNO_SQL(vDatos_Retorno())
      FUNC_CODIGO_INSTRUMENTO = vDatos_Retorno(1) + 1
   Loop
   
End Function

Sub PROC_LLENAR_COMBO_PRODUCTO()
   Dim vDatos_Retorno()
   
   If Not FUNC_EXECUTA_COMANDO_SQL("SP_CON_PRODUCTO_INSTRUMENTO") Then
      Exit Sub
   End If
   
   Cmb_Producto.Clear
   
   Do While FUNC_LEE_RETORNO_SQL(vDatos_Retorno())
      If vDatos_Retorno(2) <> "BONOS" Then
         Cmb_Producto.AddItem (vDatos_Retorno(1) & Space(100) & vDatos_Retorno(2))
      End If
   Loop
      
   Cmb_Producto.ListIndex = -1
End Sub

Private Sub Form_Unload(Cancel As Integer)
   Call PROC_LOG_AUDITORIA("08", cOptLocal, Me.Caption, "", "")
End Sub

Private Sub Grd_Instrumentos_DblClick()
   Grd_Instrumentos_KeyPress (13)
End Sub

Private Sub Grd_Instrumentos_KeyDown(KeyCode As Integer, Shift As Integer)
    Dim nContador As Integer
    Dim vDatos_Retorno()
    
    If KeyCode = vbKeyInsert Then
    ' Tecla Enter
    
        For nContador = 2 To Grd_Instrumentos.Rows - 1
           If CDbl(Grd_Instrumentos.TextMatrix(nContador, 1)) = 0 Then
              MsgBox "Falta código instrumento en fila Nº" & nContador - 1, vbInformation
              DoEvents
              Grd_Instrumentos.SetFocus
              Exit Sub
           End If
           If Trim(Grd_Instrumentos.TextMatrix(nContador, 2)) = "" Then
              MsgBox "Falta glosa instrumento en fila Nº" & nContador - 1, vbInformation
              DoEvents
              Grd_Instrumentos.SetFocus
              Exit Sub
           End If
           If Trim(Grd_Instrumentos.TextMatrix(nContador, 3)) = "" Then
              MsgBox "Falta nombre instrumento en fila Nº" & nContador - 1, vbInformation
              DoEvents
              Grd_Instrumentos.SetFocus
              Exit Sub
           End If
           If Trim(Grd_Instrumentos.TextMatrix(nContador, 6)) = "" Then
              MsgBox "Falta Codigo Contable en fila Nº" & nContador - 1, vbInformation
              DoEvents
              Grd_Instrumentos.SetFocus
              Exit Sub
           End If

        Next
    
        Grd_Instrumentos.Rows = Grd_Instrumentos.Rows + 1
        Grd_Instrumentos.Row = Grd_Instrumentos.Rows - 1
        Grd_Instrumentos.Col = 1
       
        If Grd_Instrumentos.Rows = 3 Then
           Grd_Instrumentos.TextMatrix(2, 1) = FUNC_CODIGO_INSTRUMENTO
        Else
           If CDbl(Grd_Instrumentos.TextMatrix(Grd_Instrumentos.Row - 1, 1)) < FUNC_CODIGO_INSTRUMENTO Then
              Grd_Instrumentos.TextMatrix(Grd_Instrumentos.Row, 1) = FUNC_CODIGO_INSTRUMENTO
           Else
              Grd_Instrumentos.TextMatrix(Grd_Instrumentos.Row, 1) = CDbl(Grd_Instrumentos.TextMatrix(Grd_Instrumentos.Row - 1, 1)) + 1
           End If
        End If
        
        Grd_Instrumentos.TextMatrix(Grd_Instrumentos.Row, 4) = Grd_Instrumentos.TextMatrix(Grd_Instrumentos.Row, 1)
        DoEvents
        Grd_Instrumentos.SetFocus
        
    End If
    
    
    If KeyCode = vbKeyDelete Then
    '  Tecla Delete
    
        GLB_Envia = Array()
        PROC_AGREGA_PARAMETRO GLB_Envia, CDbl(Trim(Grd_Instrumentos.TextMatrix(Grd_Instrumentos.Row, 1)))
        PROC_AGREGA_PARAMETRO GLB_Envia, 0
        PROC_AGREGA_PARAMETRO GLB_Envia, 1
        
        If Not FUNC_EXECUTA_COMANDO_SQL("SP_CON_RELACION_INSTRUMENTO", GLB_Envia) Then
           Exit Sub
        End If
        
        Do While FUNC_LEE_RETORNO_SQL(vDatos_Retorno())
           If vDatos_Retorno(1) > 0 Then
              MsgBox "No puede eliminar instrumento por estar relacionado", vbInformation
              DoEvents
              Grd_Instrumentos.SetFocus
              Exit Sub
           End If
           
           
           If vDatos_Retorno(1) = -1 Then
           
                If Grd_Instrumentos.Rows = 3 Then
                    Grd_Instrumentos.TextMatrix(2, 0) = ""
                    Grd_Instrumentos.TextMatrix(2, 1) = FUNC_CODIGO_INSTRUMENTO
                    Grd_Instrumentos.TextMatrix(2, 2) = ""
                    Grd_Instrumentos.TextMatrix(2, 3) = ""
                    Grd_Instrumentos.TextMatrix(2, 4) = FUNC_CODIGO_INSTRUMENTO
                    DoEvents
                    Grd_Instrumentos.SetFocus
                    Exit Sub
                 End If
                 
                 Grd_Instrumentos.RemoveItem (Grd_Instrumentos.Row)
                
                 DoEvents
                 Grd_Instrumentos.SetFocus
                 Exit Sub
           End If

        Loop
       
       
       If PROC_ELIMINAR_INSTRUMENTO = True Then
    
            If Grd_Instrumentos.Rows = 3 Then
                Grd_Instrumentos.TextMatrix(2, 0) = ""
                Grd_Instrumentos.TextMatrix(2, 1) = FUNC_CODIGO_INSTRUMENTO
                Grd_Instrumentos.TextMatrix(2, 2) = ""
                Grd_Instrumentos.TextMatrix(2, 3) = ""
                Grd_Instrumentos.TextMatrix(2, 4) = FUNC_CODIGO_INSTRUMENTO
                DoEvents
                Grd_Instrumentos.SetFocus
                Exit Sub
             End If
             
             Grd_Instrumentos.RemoveItem (Grd_Instrumentos.Row)
            
             DoEvents
             
         End If
         
         Grd_Instrumentos.SetFocus
    
    End If

End Sub

Private Sub Grd_Instrumentos_KeyPress(KeyAscii As Integer)
   Dim vDatos_Retorno()

   If Grd_Instrumentos.Col = 1 Then
   '  Primera Columna
      
      GLB_Envia = Array()
      PROC_AGREGA_PARAMETRO GLB_Envia, CDbl(Grd_Instrumentos.TextMatrix(Grd_Instrumentos.Row, 1))
      PROC_AGREGA_PARAMETRO GLB_Envia, 0
      PROC_AGREGA_PARAMETRO GLB_Envia, 1
      If Not FUNC_EXECUTA_COMANDO_SQL("SP_CON_RELACION_INSTRUMENTO", GLB_Envia) Then
         Exit Sub
      End If
      
      Do While FUNC_LEE_RETORNO_SQL(vDatos_Retorno())
         If vDatos_Retorno(1) > 0 Then
            MsgBox "No puede modificar codigo instrumento por estar relacionado", vbInformation
            DoEvents
            Grd_Instrumentos.SetFocus
            Exit Sub
         End If
      Loop
   End If


   If Grd_Instrumentos.Col = 2 Then
      TxtTexto.MaxLength = 8
   ElseIf Grd_Instrumentos.Col = 3 Then
      TxtTexto.MaxLength = 30
   ElseIf Grd_Instrumentos.Col = 6 Then
      TxtTexto.MaxLength = 8
   End If


   If Grd_Instrumentos.Col = 2 Or Grd_Instrumentos.Col = 3 Or Grd_Instrumentos.Col = 6 Then
      Call PROC_POSI_TEXTO(Me.TxtTexto, Me.Grd_Instrumentos)
      TxtTexto.Visible = True
   Else
      TxtGrilla.top = Grd_Instrumentos.CellTop + Grd_Instrumentos.top + 20
      TxtGrilla.left = Grd_Instrumentos.CellLeft + Grd_Instrumentos.left + 30
      TxtGrilla.Width = Grd_Instrumentos.CellWidth - 20
      TxtGrilla.Height = Grd_Instrumentos.CellHeight
      TxtGrilla.Visible = True
   End If
   
   If KeyAscii = 13 Then
      If Grd_Instrumentos.Col = 2 Or Grd_Instrumentos.Col = 3 Or Grd_Instrumentos.Col = 6 Then
         TxtTexto.Text = Grd_Instrumentos.TextMatrix(Grd_Instrumentos.Row, Grd_Instrumentos.Col)
      Else
         TxtGrilla.Text = CDbl(Grd_Instrumentos.TextMatrix(Grd_Instrumentos.Row, Grd_Instrumentos.Col))
      End If
   Else
      If Grd_Instrumentos.Col = 2 Or Grd_Instrumentos.Col = 3 Or Grd_Instrumentos.Col = 6 Then
         TxtTexto.Text = UCase(Chr(KeyAscii))
      Else
         TxtGrilla.Text = UCase(Chr(KeyAscii))
      End If
   End If
   
   If Grd_Instrumentos.Col = 2 Or Grd_Instrumentos.Col = 3 Or Grd_Instrumentos.Col = 6 Then
      TxtTexto.SetFocus
   Else
      TxtGrilla.SetFocus
   End If
   
End Sub

Private Sub Grd_Instrumentos_Scroll()

   TxtTexto.Visible = False
   TxtGrilla.Visible = False

End Sub

Private Sub Tlb_Mant_Instrumento_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 1
         Call PROC_LIMPIAR_INSTRUMENTOS
      Case 2
         Call PROC_GRABAR_INSTRUMENTOS
      Case 3
'        Call PROC_ELIMINAR_INSTRUMENTO
      Case 4
         
         If Cmb_Producto.ListIndex <> -1 Then
            Call PROC_CARGA_INSTRUMENTOS
         Else
            MsgBox "Debe seleccionar un producto ", vbInformation
            Exit Sub
         End If
               
         If Grd_Instrumentos.Rows > 2 Then
            Grd_Instrumentos.Enabled = True
            Tlb_Mant_Instrumento.Buttons(2).Enabled = True
            Tlb_Mant_Instrumento.Buttons(3).Enabled = True
            Tlb_Mant_Instrumento.Buttons(4).Enabled = False
            Grd_Instrumentos.Enabled = True
            Grd_Instrumentos.SetFocus
            Cmb_Producto.Enabled = False
            Grd_Instrumentos.FocusRect = flexFocusNone
         Else
            Tlb_Mant_Instrumento.Buttons(2).Enabled = True
            Tlb_Mant_Instrumento.Buttons(3).Enabled = True
            Tlb_Mant_Instrumento.Buttons(4).Enabled = False
            Grd_Instrumentos.Enabled = True
            Grd_Instrumentos.Rows = 3
            Grd_Instrumentos.TextMatrix(2, 0) = ""
            Grd_Instrumentos.TextMatrix(2, 1) = FUNC_CODIGO_INSTRUMENTO
            Grd_Instrumentos.TextMatrix(2, 2) = ""
            Grd_Instrumentos.TextMatrix(2, 3) = ""
            Grd_Instrumentos.TextMatrix(2, 4) = FUNC_CODIGO_INSTRUMENTO
            Grd_Instrumentos.SetFocus
            Cmb_Producto.Enabled = False
            Grd_Instrumentos.FocusRect = flexFocusNone
         End If
      
      Case 5
         Unload Me
      End Select
      
End Sub

Sub PROC_CARGA_INSTRUMENTOS()
   Dim vDatos_Retorno()
   Dim nIndice          As Integer

   With Grd_Instrumentos
      GLB_Envia = Array()
      PROC_AGREGA_PARAMETRO GLB_Envia, Trim(right(Cmb_Producto.Text, 5))
      If Not FUNC_EXECUTA_COMANDO_SQL("SP_CON_INSTRUMENTO_PRODUCTO", GLB_Envia) Then
         MsgBox "No fue posible leer información", vbOKOnly + vbCritical
         Exit Sub
      Else
         .Rows = 2
         Do While FUNC_LEE_RETORNO_SQL(vDatos_Retorno())
             .Rows = .Rows + 1
             nIndice = .Rows - 1
            .TextMatrix(nIndice, 0) = vDatos_Retorno(1)
            .TextMatrix(nIndice, 1) = vDatos_Retorno(2)
            .TextMatrix(nIndice, 2) = vDatos_Retorno(3)
            .TextMatrix(nIndice, 3) = vDatos_Retorno(4)
            .TextMatrix(nIndice, 4) = vDatos_Retorno(2)
            .TextMatrix(nIndice, 5) = vDatos_Retorno(3)
            .TextMatrix(nIndice, 6) = vDatos_Retorno(5)
         Loop
      End If
   End With
End Sub

Private Sub TxtGrilla_GotFocus()

   TxtGrilla.SelStart = 1

End Sub

Private Sub TxtGrilla_KeyPress(KeyAscii As Integer)
   Dim nContador As Integer
   Dim vDatos_Retorno()

   PROC_TO_CASE KeyAscii

   If KeyAscii = 13 Then
      
      If Grd_Instrumentos.Col = 1 And CDbl(Grd_Instrumentos.TextMatrix(Grd_Instrumentos.Row, 4)) <> TxtGrilla.Text Then
      '  Primera Columna
      
         GLB_Envia = Array()
         PROC_AGREGA_PARAMETRO GLB_Envia, CDbl(TxtGrilla.Text)
         If FUNC_EXECUTA_COMANDO_SQL("SP_CON_CODIGO_INSTRUMENTO", GLB_Envia) Then
            Do While FUNC_LEE_RETORNO_SQL(vDatos_Retorno())
               If Val(vDatos_Retorno(1)) = 1 Then
                  MsgBox "Codigo instrumento ya existé", vbInformation
                  TxtGrilla.Visible = False
                  DoEvents
                  Grd_Instrumentos.SetFocus
                  Exit Sub
               End If
            Loop
         End If
         
         For nContador = 2 To Grd_Instrumentos.Rows - 1
            If CDbl(Grd_Instrumentos.TextMatrix(nContador, 1)) = CDbl(TxtGrilla.Text) And nContador <> Grd_Instrumentos.Row Then
               MsgBox "Codigo instrumento ya existé", vbInformation
               TxtGrilla.Visible = False
               DoEvents
               Grd_Instrumentos.SetFocus
               Exit Sub
            End If
         Next
      End If
      
      Grd_Instrumentos.TextMatrix(Grd_Instrumentos.Row, Grd_Instrumentos.Col) = TxtGrilla.Text
      TxtGrilla.Visible = False
      DoEvents
      
      If Grd_Instrumentos.Enabled = True Then
         Grd_Instrumentos.SetFocus
      End If
      
   End If
   
   If KeyAscii = 27 Then
      TxtGrilla.Visible = False
      DoEvents
      Grd_Instrumentos.SetFocus
   End If

End Sub

Private Sub TxtGrilla_LostFocus()

   TxtGrilla.Visible = False

End Sub

Private Sub TxtTexto_GotFocus()

   TxtTexto.SelStart = 1

End Sub

Private Sub TxtTexto_KeyPress(KeyAscii As Integer)
   Dim nContador As Integer
   Dim vDatos_Retorno()

   PROC_TO_CASE KeyAscii

   If KeyAscii = 13 Then
      
      If Grd_Instrumentos.Col = 2 And Trim(Grd_Instrumentos.TextMatrix(Grd_Instrumentos.Row, 5)) <> TxtTexto.Text Then
         GLB_Envia = Array()
         PROC_AGREGA_PARAMETRO GLB_Envia, Trim(TxtTexto.Text)
         If FUNC_EXECUTA_COMANDO_SQL("SP_CON_GLOSA_INSTRUMENTO", GLB_Envia) Then
           Do While FUNC_LEE_RETORNO_SQL(vDatos_Retorno())
               If Val(vDatos_Retorno(1)) = 1 Then
                  MsgBox "Glosa instrumento ya existé", vbInformation
                  TxtTexto.Visible = False
                  DoEvents
                  Grd_Instrumentos.SetFocus
                  Exit Sub
               End If
           Loop
         End If
      End If
      
      For nContador = 2 To Grd_Instrumentos.Rows - 1
         If Trim(Grd_Instrumentos.TextMatrix(nContador, 2)) = Trim(TxtTexto.Text) And nContador <> Grd_Instrumentos.Row Then
            MsgBox "Glosa instrumento ya existé", vbInformation
            TxtTexto.Visible = False
            DoEvents
            Grd_Instrumentos.SetFocus
            Exit Sub
         End If
      Next
      
      Grd_Instrumentos.TextMatrix(Grd_Instrumentos.Row, Grd_Instrumentos.Col) = TxtTexto.Text
      TxtTexto.Visible = False
      DoEvents
      
      If Grd_Instrumentos.Enabled = True Then
         Grd_Instrumentos.SetFocus
      End If
      
   End If
   
   If KeyAscii = 27 Then
      TxtTexto.Visible = False
      DoEvents
      Grd_Instrumentos.SetFocus
   End If

End Sub

Private Sub TxtTexto_LostFocus()
   TxtTexto.Visible = False
End Sub

Function PROC_ELIMINAR_INSTRUMENTO() As Boolean

    PROC_ELIMINAR_INSTRUMENTO = False

    Dim vDatos_Retorno()
    
    If MsgBox("¿Esta seguro de eliminar la información, Se eliminaran Formulas Relacionadas?", vbQuestion + vbYesNo) = vbNo Then
        Exit Function
    End If
   
    GLB_Envia = Array()
    PROC_AGREGA_PARAMETRO GLB_Envia, Trim(right(Cmb_Producto.Text, 5))
    PROC_AGREGA_PARAMETRO GLB_Envia, CDbl(Grd_Instrumentos.TextMatrix(Grd_Instrumentos.Row, 1))
    
    If Not FUNC_EXECUTA_COMANDO_SQL("SP_ELI_INSTRUMENTO", GLB_Envia) Then
       MsgBox "Problemas al Eliminar información", vbCritical
       DoEvents
       Grd_Instrumentos.SetFocus
       Exit Function
    End If
    
    Do While FUNC_LEE_RETORNO_SQL(vDatos_Retorno())
        If vDatos_Retorno(1) = "*" Then
             MsgBox "Instrumento no puede ser borrado, ya que esta relacionado", vbInformation
        Else
             MsgBox "Eliminación de información ha finalizado en forma correcta", vbInformation
             PROC_ELIMINAR_INSTRUMENTO = True
        End If
    Loop
    
    
'   Call PROC_LIMPIAR_INSTRUMENTOS
    
End Function

Sub PROC_GRABAR_INSTRUMENTOS()
   Dim nContador As Integer

   For nContador = 2 To Grd_Instrumentos.Rows - 1
      If CDbl(Grd_Instrumentos.TextMatrix(nContador, 1)) = 0 Then
         MsgBox "Falta código instrumento en fila Nº" & nContador - 1, vbInformation
         DoEvents
         Grd_Instrumentos.SetFocus
         Exit Sub
      End If
      If Trim(Grd_Instrumentos.TextMatrix(nContador, 2)) = "" Then
         MsgBox "Falta glosa instrumento en fila Nº" & nContador - 1, vbInformation
         DoEvents
         Grd_Instrumentos.SetFocus
         Exit Sub
      End If
      If Trim(Grd_Instrumentos.TextMatrix(nContador, 3)) = "" Then
         MsgBox "Falta nombre instrumento en fila Nº" & nContador - 1, vbInformation
         DoEvents
         Grd_Instrumentos.SetFocus
         Exit Sub
      End If
   Next

'   GLB_Envia = Array()
'   PROC_AGREGA_PARAMETRO GLB_Envia, Trim(Right(Cmb_Producto.Text, 5))
'   If Not FUNC_EXECUTA_COMANDO_SQL("SP_ELI_INSTRUMENTO", GLB_Envia) Then
'      MsgBox "Problemas al grabar información", vbCritical
'      DoEvents
'      Grd_Instrumentos.SetFocus
'      Exit Sub
'   End If


   For nContador = 2 To Grd_Instrumentos.Rows - 1
      GLB_Envia = Array()
      
      PROC_AGREGA_PARAMETRO GLB_Envia, Trim(right(Cmb_Producto.Text, 5))
      PROC_AGREGA_PARAMETRO GLB_Envia, CDbl(Grd_Instrumentos.TextMatrix(nContador, 1))
      PROC_AGREGA_PARAMETRO GLB_Envia, Trim(Grd_Instrumentos.TextMatrix(nContador, 2))
      PROC_AGREGA_PARAMETRO GLB_Envia, Trim(Grd_Instrumentos.TextMatrix(nContador, 3))
      PROC_AGREGA_PARAMETRO GLB_Envia, Trim(Grd_Instrumentos.TextMatrix(nContador, 6))
      
      If Not FUNC_EXECUTA_COMANDO_SQL("SP_ACT_INSTRUMENTO", GLB_Envia) Then
         MsgBox "Problemas al grabar información", vbCritical
         DoEvents
         Grd_Instrumentos.SetFocus
         Exit Sub
      End If
      
   Next
   
   MsgBox "Grabación realizada con éxito", vbInformation

   Call Tlb_Mant_Instrumento_ButtonClick(Tlb_Mant_Instrumento.Buttons(1))
            
   
End Sub

Sub PROC_LIMPIAR_INSTRUMENTOS()
   nCantidad = 0
   Tlb_Mant_Instrumento.Buttons(2).Enabled = False
   Tlb_Mant_Instrumento.Buttons(3).Enabled = False
   Tlb_Mant_Instrumento.Buttons(4).Enabled = True
   Cmb_Producto.Enabled = True
   Cmb_Producto.ListIndex = -1
   Grd_Instrumentos.Rows = 2
   Grd_Instrumentos.Enabled = False
   Cmb_Producto.SetFocus
   Grd_Instrumentos.FocusRect = flexFocusLight
End Sub
