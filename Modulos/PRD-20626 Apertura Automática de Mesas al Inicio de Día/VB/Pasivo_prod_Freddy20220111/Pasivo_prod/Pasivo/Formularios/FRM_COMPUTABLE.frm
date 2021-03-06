VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "threed32.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "Mscomctl.ocx"
Object = "{989C9190-EDF5-45A8-AB6C-98E6EF0384D7}#1.0#0"; "Bac_Controles_Pas.ocx"
Begin VB.Form FRM_RPT_COMPUTABLE 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Reportes Computables"
   ClientHeight    =   3510
   ClientLeft      =   2235
   ClientTop       =   2835
   ClientWidth     =   3975
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   3510
   ScaleWidth      =   3975
   Begin Threed.SSPanel SSPanel1 
      Height          =   3000
      Left            =   0
      TabIndex        =   14
      Top             =   510
      Width           =   3960
      _Version        =   65536
      _ExtentX        =   6985
      _ExtentY        =   5292
      _StockProps     =   15
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin VB.Frame Frame1 
         Caption         =   "Listados  Computables"
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
         Height          =   1845
         Left            =   60
         TabIndex        =   19
         Top             =   1110
         Width           =   3870
         Begin VB.PictureBox ConCheck 
            BorderStyle     =   0  'None
            Height          =   330
            Index           =   3
            Left            =   3120
            Picture         =   "FRM_COMPUTABLE.frx":0000
            ScaleHeight     =   330
            ScaleWidth      =   330
            TabIndex        =   13
            Top             =   1410
            Visible         =   0   'False
            Width           =   330
         End
         Begin VB.PictureBox SinCheck 
            BorderStyle     =   0  'None
            Height          =   330
            Index           =   3
            Left            =   700
            Picture         =   "FRM_COMPUTABLE.frx":015A
            ScaleHeight     =   330
            ScaleWidth      =   375
            TabIndex        =   11
            Top             =   1440
            Width           =   375
         End
         Begin VB.PictureBox ConCheck 
            BorderStyle     =   0  'None
            Height          =   330
            Index           =   2
            Left            =   3150
            Picture         =   "FRM_COMPUTABLE.frx":02B4
            ScaleHeight     =   330
            ScaleWidth      =   330
            TabIndex        =   10
            Top             =   1020
            Visible         =   0   'False
            Width           =   330
         End
         Begin VB.PictureBox ConCheck 
            BorderStyle     =   0  'None
            Height          =   330
            Index           =   1
            Left            =   3150
            Picture         =   "FRM_COMPUTABLE.frx":040E
            ScaleHeight     =   330
            ScaleWidth      =   330
            TabIndex        =   7
            Top             =   690
            Visible         =   0   'False
            Width           =   330
         End
         Begin VB.PictureBox SinCheck 
            BorderStyle     =   0  'None
            Height          =   330
            Index           =   2
            Left            =   700
            Picture         =   "FRM_COMPUTABLE.frx":0568
            ScaleHeight     =   330
            ScaleWidth      =   375
            TabIndex        =   8
            Top             =   1080
            Width           =   375
         End
         Begin VB.PictureBox SinCheck 
            BorderStyle     =   0  'None
            Height          =   330
            Index           =   1
            Left            =   700
            Picture         =   "FRM_COMPUTABLE.frx":06C2
            ScaleHeight     =   330
            ScaleWidth      =   375
            TabIndex        =   5
            Top             =   690
            Width           =   375
         End
         Begin VB.PictureBox ConCheck 
            BorderStyle     =   0  'None
            Height          =   330
            Index           =   0
            Left            =   3150
            Picture         =   "FRM_COMPUTABLE.frx":081C
            ScaleHeight     =   330
            ScaleWidth      =   330
            TabIndex        =   4
            Top             =   360
            Visible         =   0   'False
            Width           =   330
         End
         Begin VB.PictureBox SinCheck 
            BorderStyle     =   0  'None
            Height          =   330
            Index           =   0
            Left            =   700
            Picture         =   "FRM_COMPUTABLE.frx":0976
            ScaleHeight     =   330
            ScaleWidth      =   375
            TabIndex        =   2
            Top             =   360
            Width           =   375
         End
         Begin VB.Label Etiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Intereses Devengados"
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
            Index           =   3
            Left            =   1170
            TabIndex        =   12
            Top             =   1485
            Width           =   1875
         End
         Begin VB.Label Etiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Montos No Computables"
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
            Index           =   2
            Left            =   1200
            TabIndex        =   9
            Top             =   1125
            Width           =   2040
         End
         Begin VB.Label Etiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Montos Computables"
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
            Left            =   1200
            TabIndex        =   6
            Top             =   765
            Width           =   1785
         End
         Begin VB.Label Etiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Bonos Subordinados"
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
            Index           =   0
            Left            =   1200
            TabIndex        =   3
            Top             =   405
            Width           =   1725
         End
      End
      Begin Threed.SSFrame SSFrame2 
         Height          =   990
         Left            =   30
         TabIndex        =   15
         Top             =   90
         Width           =   3885
         _Version        =   65536
         _ExtentX        =   6853
         _ExtentY        =   1746
         _StockProps     =   14
         Caption         =   " Ingreso "
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
         Begin BACControles.TXTNumero IntAnnIng 
            Height          =   315
            Left            =   2250
            TabIndex        =   1
            Top             =   570
            Width           =   1095
            _ExtentX        =   1931
            _ExtentY        =   556
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
            Text            =   "0"
            Text            =   "0"
            Min             =   "1980"
            Max             =   "2050"
            MarcaTexto      =   -1  'True
         End
         Begin VB.ComboBox CmbMes 
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
            Left            =   345
            Style           =   2  'Dropdown List
            TabIndex        =   0
            Top             =   570
            Width           =   1425
         End
         Begin VB.Label Label5 
            AutoSize        =   -1  'True
            Caption         =   "Mes a Generar"
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
            Left            =   360
            TabIndex        =   17
            Top             =   360
            Width           =   1215
         End
         Begin VB.Label Label6 
            AutoSize        =   -1  'True
            Caption         =   "A?o"
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
            Left            =   2280
            TabIndex        =   16
            Top             =   360
            Width           =   330
         End
      End
   End
   Begin MSComctlLib.Toolbar Tlb_Computable 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   18
      Top             =   0
      Width           =   3975
      _ExtentX        =   7011
      _ExtentY        =   847
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Imprimir"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Vista Previa"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   4860
         Top             =   -30
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   24
         ImageHeight     =   24
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   3
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_COMPUTABLE.frx":0AD0
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_COMPUTABLE.frx":19AA
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_COMPUTABLE.frx":2884
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
End
Attribute VB_Name = "FRM_RPT_COMPUTABLE"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim Sql As String
Dim Datos()
Dim TCartera As String
Dim tipo As String
Dim cOptLocal As String
Const ForeSeleccion = &H8000000E
Const BackSeleccion = &H8000000D
Const ForeNormal = &H80000007
Const BackNormal = &H8000000F

Private Sub Generar_Listado(cTipo_Salida As String)
   
   Dim nContador        As Integer
   Dim cFecha_Desde     As String
   Dim cFecha_Hasta     As String
   Dim Titulo                             As String
   Dim bExisten_Marcados                  As Boolean

On Error GoTo Control:

   If Trim(CmbMes.Text) = "" Then
      MsgBox "Debe seleccionar un mes"
      Exit Sub
   End If

   If IntAnnIng.Text = 0 Then
      MsgBox "Debe seleccionar un a?o"
      Exit Sub
   End If

   Call objCentralizacion.Chequeo_Estado(GLB_Sistema, cOptLocal, False)
   
   If Not objCentralizacion.Estado And (objCentralizacion.Error = 0 Or objCentralizacion.Error = 300) Then
   
            Screen.MousePointer = 11
            bExisten_Marcados = False
            
            If cTipo_Salida = "Impresora" Then
            
                FRM_MDI_PASIVO.Pasivo_Rpt.Destination = 1
                cTipo_Salida = "P"
            
            Else
                
                FRM_MDI_PASIVO.Pasivo_Rpt.Destination = 0
                cTipo_Salida = "V"
            
            End If
         
          
            For nContador = 0 To 3
            
               If ConCheck.Item(nContador).Visible = True Then
                  
                  bExisten_Marcados = True
               
               End If
            
            Next nContador
             
            If bExisten_Marcados = False Then
            
               MsgBox "Debe Seleccionar Tipo de Listado ", vbInformation
               Screen.MousePointer = vbDefault
               Exit Sub
            
            End If
         
          
             
         If ConCheck.Item(0).Visible Then
               
               Call PROC_LIMPIAR_CRISTAL
               
               FRM_MDI_PASIVO.Pasivo_Rpt.ReportFileName = GLB_Ubicacion_Reporte & "RPT_CAPITAL_COMPUTABLE.RPT"
               PROC_ESTABLECE_UBICACION FRM_MDI_PASIVO.Pasivo_Rpt.RetrieveDataFiles, FRM_MDI_PASIVO.Pasivo_Rpt
               FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(0) = CmbMes.ItemData(CmbMes.ListIndex)
               FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(1) = CmbMes.Text
               FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(2) = CDbl(IntAnnIng.Text)
               FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(3) = "V"
               FRM_MDI_PASIVO.Pasivo_Rpt.Formulas(0) = "Usuario='" & GLB_Usuario & "'"
               FRM_MDI_PASIVO.Pasivo_Rpt.Connect = CONECCION
               FRM_MDI_PASIVO.Pasivo_Rpt.Action = 1
               
               
               Call PROC_LOG_AUDITORIA("10", cOptLocal, Me.Caption & " Informe de Vencimientos de Bonos Subordinados: ", "", "")
         
         End If
         
        
         If ConCheck.Item(1).Visible Then
               
               Call PROC_LIMPIAR_CRISTAL
               
               FRM_MDI_PASIVO.Pasivo_Rpt.ReportFileName = GLB_Ubicacion_Reporte & "RPT_TOTAL_COMPUTABLE.RPT"
               PROC_ESTABLECE_UBICACION FRM_MDI_PASIVO.Pasivo_Rpt.RetrieveDataFiles, FRM_MDI_PASIVO.Pasivo_Rpt
               FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(0) = CmbMes.ItemData(CmbMes.ListIndex)
               FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(1) = CmbMes.Text
               FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(2) = CDbl(IntAnnIng.Text)
               FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(3) = "C"
               FRM_MDI_PASIVO.Pasivo_Rpt.Formulas(0) = "Usuario='" & GLB_Usuario & "'"
               FRM_MDI_PASIVO.Pasivo_Rpt.Connect = CONECCION
               FRM_MDI_PASIVO.Pasivo_Rpt.Action = 1
               
               
               Call PROC_LOG_AUDITORIA("10", cOptLocal, Me.Caption & " Informe de Vencimientos de Bonos Subordinados: ", "", "")
         
         End If
        
         If ConCheck.Item(2).Visible Then
               
               Call PROC_LIMPIAR_CRISTAL
               
               FRM_MDI_PASIVO.Pasivo_Rpt.ReportFileName = GLB_Ubicacion_Reporte & "RPT_TOTAL_NOCOMPUTABLE.RPT"
               PROC_ESTABLECE_UBICACION FRM_MDI_PASIVO.Pasivo_Rpt.RetrieveDataFiles, FRM_MDI_PASIVO.Pasivo_Rpt
               FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(0) = CmbMes.ItemData(CmbMes.ListIndex)
               FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(1) = CmbMes.Text
               FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(2) = CDbl(IntAnnIng.Text)
               FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(3) = "C"
               FRM_MDI_PASIVO.Pasivo_Rpt.Formulas(0) = "Usuario='" & GLB_Usuario & "'"
               FRM_MDI_PASIVO.Pasivo_Rpt.Connect = CONECCION
               FRM_MDI_PASIVO.Pasivo_Rpt.Action = 1
               
               
               Call PROC_LOG_AUDITORIA("10", cOptLocal, Me.Caption & " Informe de Vencimientos de Bonos Subordinados: ", "", "")
         
      End If
         
      If ConCheck.Item(3).Visible Then
            
            Call PROC_LIMPIAR_CRISTAL
            
            FRM_MDI_PASIVO.Pasivo_Rpt.ReportFileName = GLB_Ubicacion_Reporte & "RPT_TOTAL_COMPUTABLE_I.RPT"
            PROC_ESTABLECE_UBICACION FRM_MDI_PASIVO.Pasivo_Rpt.RetrieveDataFiles, FRM_MDI_PASIVO.Pasivo_Rpt
            FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(0) = CmbMes.ItemData(CmbMes.ListIndex)
            FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(1) = CmbMes.Text
            FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(2) = CDbl(IntAnnIng.Text)
            FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(3) = "I"
            FRM_MDI_PASIVO.Pasivo_Rpt.Formulas(0) = "Usuario='" & GLB_Usuario & "'"
            FRM_MDI_PASIVO.Pasivo_Rpt.Connect = CONECCION
            FRM_MDI_PASIVO.Pasivo_Rpt.Action = 1
            
            
            Call PROC_LOG_AUDITORIA("10", cOptLocal, Me.Caption & " Informe de Vencimientos de Bonos Subordinados: ", "", "")
      
      End If
            
         Call objCentralizacion.Grabar_Estado(GLB_Sistema, cOptLocal, 1, False)
   
         If Not objCentralizacion.Estado Or objCentralizacion.Error <> 0 Then
                  
            MsgBox objCentralizacion.Mensaje, vbExclamation
               
         End If
               
         Screen.MousePointer = 0
   
   
   Else
         MsgBox objCentralizacion.Mensaje, vbExclamation
   
   End If

Exit Sub

Control:

   Call PROC_LOG_AUDITORIA("10", cOptLocal, Me.Caption & " Error al emitir reporte- Informe de Listado de Movimientos- Fecha Proceso: ", "", "")
   MsgBox "Problemas al generar Listado de Movimientos. " & Err.Description, vbCritical

   Screen.MousePointer = 0
   
End Sub

Private Sub CmbMes_KeyPress(KeyAscii As Integer)
   
   If KeyAscii = 13 Then
    
      FUNC_ENVIA_TECLA (vbKeyTab)
   
   End If

End Sub

Private Sub Form_Activate()

   PROC_CARGA_AYUDA Me

End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)

Dim nOpcion As Integer

    If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) Then

        Select Case KeyCode
            
            Case VbKeyImprimir 'Imprimir
                
                nOpcion = 1
            
            Case vbKeyVistaPrevia 'Vista Previa
                
                nOpcion = 2
            
            Case vbKeySalir 'Salir
                
                nOpcion = 3
        
        End Select
        
        If nOpcion > 0 Then
            
            If Tlb_Computable.Buttons(nOpcion).Enabled Then
                
                Tlb_Computable_ButtonClick Tlb_Computable.Buttons(nOpcion)
            
            End If
        
        End If
    
    End If

End Sub

Private Sub Form_Load()

Dim x As Integer

    Me.Icon = FRM_MDI_PASIVO.Icon
    Me.Top = 0
    Me.Left = 0
  
    Screen.MousePointer = 11
    giAceptar% = False
    
    Screen.MousePointer = 0
    cOptLocal = GLB_Opcion_Menu
    DoEvents
    
    Call PROC_LLENA_MESES(CmbMes)
    CmbMes.ListIndex = 0
    IntAnnIng.Text = Trim(Year(GLB_Fecha_Proceso))
    
    Call PROC_LOG_AUDITORIA("07", cOptLocal, Me.Caption, "", "")

End Sub

Private Sub Form_Unload(Cancel As Integer)

   Call PROC_LOG_AUDITORIA("08", cOptLocal, Me.Caption, "", "")
   
End Sub

Private Sub IntAnnIng_KeyPress(KeyAscii As Integer)
   
   If KeyAscii = 13 Then
    
      FUNC_ENVIA_TECLA (vbKeyTab)
   
   End If

End Sub

Private Sub Tlb_Computable_ButtonClick(ByVal Button As MSComctlLib.Button)

   Select Case Button.Index

   Case 1
      
      Call Generar_Listado("Impresora")

   Case 2
      
      Call Generar_Listado("Pantalla")

   Case 3
   
      Unload Me

   End Select

End Sub

Private Sub SinCheck_Click(Index As Integer)
    
    ConCheck.Item(Index).Left = SinCheck.Item(Index).Left
    SinCheck.Item(Index).Visible = Not SinCheck.Item(Index).Visible
    ConCheck.Item(Index).Visible = Not ConCheck.Item(Index).Visible
    DoEvents
    ConCheck.Item(Index).SetFocus

End Sub
Private Sub SinCheck_GotFocus(Index As Integer)
      
      Etiqueta(Index).BackColor = BackSeleccion
      Etiqueta(Index).ForeColor = ForeSeleccion

End Sub

Private Sub SinCheck_KeyPress(Index As Integer, KeyAscii As Integer)
    
    If KeyAscii = 109 Or KeyAscii = 32 Then
        
        SinCheck_Click (Index)
    
    End If
    
    If KeyAscii = 13 Then
        
        FUNC_ENVIA_TECLA (vbKeyTab)
    
    End If

End Sub

Private Sub SinCheck_LostFocus(Index As Integer)

      Etiqueta(Index).BackColor = BackNormal
      Etiqueta(Index).ForeColor = ForeNormal

End Sub

Private Sub ConCheck_Click(Index As Integer)

   SinCheck.Item(Index).Visible = Not SinCheck.Item(Index).Visible
   ConCheck.Item(Index).Visible = Not ConCheck.Item(Index).Visible
   DoEvents
   SinCheck.Item(Index).SetFocus
   
End Sub

Private Sub ConCheck_GotFocus(Index As Integer)

      Etiqueta(Index).BackColor = BackSeleccion
      Etiqueta(Index).ForeColor = ForeSeleccion

End Sub

Private Sub ConCheck_KeyPress(Index As Integer, KeyAscii As Integer)
    
    If KeyAscii = 109 Or KeyAscii = 32 Then
        
        ConCheck_Click (Index)
    
    End If
    
    If KeyAscii = 13 Then
        
        FUNC_ENVIA_TECLA (vbKeyTab)
    
    End If

End Sub

Private Sub ConCheck_LostFocus(Index As Integer)

      Etiqueta(Index).BackColor = BackNormal
      Etiqueta(Index).ForeColor = ForeNormal

End Sub
