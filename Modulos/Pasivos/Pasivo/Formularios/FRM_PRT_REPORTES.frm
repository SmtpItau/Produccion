VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{989C9190-EDF5-45A8-AB6C-98E6EF0384D7}#1.0#0"; "Bac_Controles_Pas.ocx"
Begin VB.Form FRM_RPT_REPORTES 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Form1"
   ClientHeight    =   1425
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   6135
   Icon            =   "FRM_PRT_REPORTES.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   1425
   ScaleWidth      =   6135
   Begin VB.Frame Frame3 
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   930
      Left            =   0
      TabIndex        =   1
      Top             =   510
      Width           =   6150
      Begin VB.Frame Frame2 
         BorderStyle     =   0  'None
         Height          =   660
         Index           =   0
         Left            =   75
         TabIndex        =   2
         Top             =   1515
         Width           =   3825
      End
      Begin BACControles.TXTFecha TxtFecProc 
         Height          =   315
         Left            =   1605
         TabIndex        =   3
         Top             =   300
         Visible         =   0   'False
         Width           =   1425
         _ExtentX        =   2514
         _ExtentY        =   556
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
         MaxDate         =   402133
         MinDate         =   18264
         Text            =   "18/06/2001"
      End
      Begin BACControles.TXTFecha TXTFechaHasta 
         Height          =   315
         Left            =   4590
         TabIndex        =   5
         Top             =   285
         Visible         =   0   'False
         Width           =   1425
         _ExtentX        =   2514
         _ExtentY        =   556
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
         MaxDate         =   402133
         MinDate         =   18264
         Text            =   "18/06/2001"
      End
      Begin VB.Label lblEtiqueta 
         AutoSize        =   -1  'True
         Caption         =   "Fecha Hasta"
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
         Left            =   3330
         TabIndex        =   6
         Top             =   345
         Visible         =   0   'False
         Width           =   975
      End
      Begin VB.Label lblEtiqueta 
         AutoSize        =   -1  'True
         Caption         =   "Fecha Desde"
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
         Left            =   210
         TabIndex        =   4
         Top             =   345
         Visible         =   0   'False
         Width           =   1050
      End
   End
   Begin MSComctlLib.Toolbar Tlb_Menu 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   6135
      _ExtentX        =   10821
      _ExtentY        =   794
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Style           =   1
      ImageList       =   "Img_opciones"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Imprimir"
            ImageIndex      =   17
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Vista Previa"
            ImageIndex      =   18
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      Begin MSComctlLib.ImageList Img_opciones 
         Left            =   4920
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
               Picture         =   "FRM_PRT_REPORTES.frx":2EFA
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRT_REPORTES.frx":3361
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRT_REPORTES.frx":3857
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRT_REPORTES.frx":3CEA
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRT_REPORTES.frx":41D2
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRT_REPORTES.frx":46E5
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRT_REPORTES.frx":4C22
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRT_REPORTES.frx":5064
               Key             =   ""
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRT_REPORTES.frx":551E
               Key             =   ""
            EndProperty
            BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRT_REPORTES.frx":59F1
               Key             =   ""
            EndProperty
            BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRT_REPORTES.frx":5E35
               Key             =   ""
            EndProperty
            BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRT_REPORTES.frx":639C
               Key             =   ""
            EndProperty
            BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRT_REPORTES.frx":686B
               Key             =   ""
            EndProperty
            BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRT_REPORTES.frx":6C8A
               Key             =   ""
            EndProperty
            BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRT_REPORTES.frx":7182
               Key             =   ""
            EndProperty
            BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRT_REPORTES.frx":757B
               Key             =   ""
            EndProperty
            BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRT_REPORTES.frx":79FE
               Key             =   ""
            EndProperty
            BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRT_REPORTES.frx":7EC4
               Key             =   ""
            EndProperty
            BeginProperty ListImage19 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRT_REPORTES.frx":83BB
               Key             =   ""
            EndProperty
            BeginProperty ListImage20 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRT_REPORTES.frx":8871
               Key             =   ""
            EndProperty
            BeginProperty ListImage21 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRT_REPORTES.frx":8C36
               Key             =   ""
            EndProperty
            BeginProperty ListImage22 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRT_REPORTES.frx":902C
               Key             =   ""
            EndProperty
            BeginProperty ListImage23 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRT_REPORTES.frx":9423
               Key             =   ""
            EndProperty
            BeginProperty ListImage24 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRT_REPORTES.frx":982C
               Key             =   ""
            EndProperty
            BeginProperty ListImage25 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRT_REPORTES.frx":9CEA
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
End
Attribute VB_Name = "FRM_RPT_REPORTES"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim cOptLocal As String

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
            
            If TLB_Menu.Buttons(nOpcion).Enabled Then
                
                TLB_Menu_ButtonClick TLB_Menu.Buttons(nOpcion)
            
            End If
        
        End If
    
    End If

End Sub

Private Sub Form_Load()
Me.top = 0
Me.Icon = FRM_MDI_PASIVO.Icon
Me.left = 0
cOptLocal = GLB_Opcion_Menu
Me.TxtFecProc.Text = GLB_Fecha_Proceso
Me.TXTFechaHasta.Text = GLB_Fecha_Proceso
Me.Caption = "Informe de Tasas Promedios"
    If cOptLocal = "Opcion_Menu_4351" Or cOptLocal = "Opcion_Menu_4352" Or cOptLocal = "Opcion_Menu_4353" Then
        Me.Caption = "Contabilidad Diaria"
        Frame3.Visible = True
        lblEtiqueta(1).Visible = True
        TxtFecProc.Visible = True
        TXTFechaHasta.Visible = False
        Me.Width = 4000
        Me.Height = 1830
    Else
        Me.Width = 6255
        Me.Height = 1830
    End If

End Sub

Private Sub TLB_Menu_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index

   Case 1
        If cOptLocal = "Opcion_Menu_4351" Or cOptLocal = "Opcion_Menu_4352" Or cOptLocal = "Opcion_Menu_4353" Then
            Call Generar_Listado_2("Impresora")
        Else
            Call Generar_Listado("Impresora")
        End If
   Case 2
        If cOptLocal = "Opcion_Menu_4351" Or cOptLocal = "Opcion_Menu_4352" Or cOptLocal = "Opcion_Menu_4353" Then
            Call Generar_Listado_2("Pantalla")
        Else
            Call Generar_Listado("Pantalla")
        End If
   Case 3
      Unload Me

   End Select

End Sub
Private Sub Generar_Listado(cTipo_Salida As String)
Dim cFecha_Desde     As String
Dim cFecha_Hasta     As String

On Error GoTo Control:

GLB_Envia = Array()
PROC_AGREGA_PARAMETRO GLB_Envia, Format(GLB_Fecha_Proceso, "yyyymmdd")
PROC_AGREGA_PARAMETRO GLB_Envia, "N"

If Not FUNC_EXECUTA_COMANDO_SQL("SP_PRO_TASA_PROMEDIO", GLB_Envia) Then
   MsgBox "No se pudo realizar cálculo de tasas promedio", vbExclamation
   Screen.MousePointer = 0
   Exit Sub
End If


TxtFecProc.Text = GLB_Fecha_Proceso
TXTFechaHasta.Text = GLB_Fecha_Proceso


If CDate(TxtFecProc.Text) > CDate(GLB_Fecha_Proceso) Or CDate(TxtFecProc.Text) > CDate(TXTFechaHasta.Text) Then
    MsgBox ("Fecha Desde debe ser menor a Fecha de Proceso o Fecha Hasta"), vbInformation + vbOKOnly
    TxtFecProc.Text = GLB_Fecha_Proceso
    TxtFecProc.SetFocus
    Exit Sub
End If
If CDate(TXTFechaHasta.Text) < CDate(GLB_Fecha_Proceso) Or CDate(TXTFechaHasta.Text) < CDate(TxtFecProc.Text) Then
    MsgBox ("Fecha Hasta debe ser mayor a Fecha de Proceso y mayor a Fecha Desde"), vbInformation + vbOKOnly
    TXTFechaHasta.Text = GLB_Fecha_Proceso
    TXTFechaHasta.SetFocus
    Exit Sub
End If


            Screen.MousePointer = 11
            
            If cTipo_Salida = "Impresora" Then
            
                FRM_MDI_PASIVO.Pasivo_Rpt.Destination = 1
                cTipo_Salida = "P"
            
            Else
                
                FRM_MDI_PASIVO.Pasivo_Rpt.Destination = 0
                cTipo_Salida = "V"
            
            End If
         
               Call PROC_LIMPIAR_CRISTAL
               cFecha_Desde = Format(TxtFecProc.Text, "yyyymmdd")
               cFecha_Hasta = Format(TXTFechaHasta.Text, "yyyymmdd")
               
               FRM_MDI_PASIVO.Pasivo_Rpt.ReportFileName = GLB_Ubicacion_Reporte & "RPT_TASAS_PROMEDIO.rpt"
               PROC_ESTABLECE_UBICACION FRM_MDI_PASIVO.Pasivo_Rpt.RetrieveDataFiles, FRM_MDI_PASIVO.Pasivo_Rpt
               FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(0) = cFecha_Desde
               FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(1) = cFecha_Hasta
               FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(2) = "S"   'SUCURSAL
               FRM_MDI_PASIVO.Pasivo_Rpt.Formulas(0) = "xUsuario='" & GLB_Usuario & "'"
               FRM_MDI_PASIVO.Pasivo_Rpt.Connect = GLB_CONECCION
               FRM_MDI_PASIVO.Pasivo_Rpt.Action = 1
              
              
'               Call PROC_LIMPIAR_CRISTAL
'               cFecha_Desde = Format(TxtFecProc.Text, "yyyymmdd")
'
'               FRM_MDI_PASIVO.Pasivo_Rpt.ReportFileName = GLB_Ubicacion_Reporte & "RPT_TASAS_PROMEDIO.rpt"
'               PROC_ESTABLECE_UBICACION FRM_MDI_PASIVO.Pasivo_Rpt.RetrieveDataFiles, FRM_MDI_PASIVO.Pasivo_Rpt
'               FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(0) = cFecha_Desde
'               FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(1) = cFecha_Hasta
'               FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(2) = "B"   'BANCO
'               FRM_MDI_PASIVO.Pasivo_Rpt.Formulas(0) = "xUsuario='" & GLB_Usuario & "'"
'               FRM_MDI_PASIVO.Pasivo_Rpt.Connect = GLB_CONECCION
'               FRM_MDI_PASIVO.Pasivo_Rpt.Action = 1
             
              
              Screen.MousePointer = 0
Exit Sub

Control:
   Call PROC_LOG_AUDITORIA("10", cOptLocal, Me.Caption & " Error al emitir reporte- Informe de Listado de Movimientos- Fecha Proceso: " & TxtFecProc.Text, "", "")
   MsgBox "Problemas al generar Listado de Movimientos. " & Err.Description, vbCritical

   Screen.MousePointer = 0
End Sub

Private Sub TXTFechaHasta_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then Call FUNC_ENVIA_TECLA(vbKeyTab)
End Sub

Private Sub TXTFechaHasta_LostFocus()
If CDate(TXTFechaHasta.Text) < CDate(GLB_Fecha_Proceso) Or CDate(TXTFechaHasta.Text) < CDate(TxtFecProc.Text) Then
    MsgBox ("Fecha Hasta debe ser mayor a Fecha de Proceso y mayor a Fecha Desde"), vbInformation + vbOKOnly
    TXTFechaHasta.Text = GLB_Fecha_Proceso
    TXTFechaHasta.SetFocus
End If

End Sub

Private Sub TxtFecProc_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then Call FUNC_ENVIA_TECLA(vbKeyTab)
End Sub

Private Sub TxtFecProc_LostFocus()
If CDate(TxtFecProc.Text) > CDate(GLB_Fecha_Proceso) Or CDate(TxtFecProc.Text) > CDate(TXTFechaHasta.Text) Then
    MsgBox ("Fecha Desde debe ser menor a Fecha de Proceso o Fecha Hasta"), vbInformation + vbOKOnly
    TxtFecProc.Text = GLB_Fecha_Proceso
    TxtFecProc.SetFocus
End If

End Sub
Private Sub Generar_Listado_2(cTipo_Salida As String)
Dim cFecha_Desde     As String
Dim cFecha_Hasta     As String

On Error GoTo Control:

            Screen.MousePointer = 11
            
            If cTipo_Salida = "Impresora" Then
            
                FRM_MDI_PASIVO.Pasivo_Rpt.Destination = 1
                cTipo_Salida = "P"
            
            Else
                
                FRM_MDI_PASIVO.Pasivo_Rpt.Destination = 0
                cTipo_Salida = "V"
            
            End If
         
               Call PROC_LIMPIAR_CRISTAL
               cFecha_Desde = Format(TxtFecProc.Text, "yyyymmdd")

            If cOptLocal = "Opcion_Menu_4351" Then
               FRM_MDI_PASIVO.Pasivo_Rpt.ReportFileName = GLB_Ubicacion_Reporte & "RPT_CONTABILIDAD.rpt"
               PROC_ESTABLECE_UBICACION FRM_MDI_PASIVO.Pasivo_Rpt.RetrieveDataFiles, FRM_MDI_PASIVO.Pasivo_Rpt
               FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(0) = cFecha_Desde
               'FRM_MDI_PASIVO.Pasivo_Rpt.Formulas(0) = "xUsuario='" & GLB_Usuario & "'"
               FRM_MDI_PASIVO.Pasivo_Rpt.Connect = GLB_CONECCION
               FRM_MDI_PASIVO.Pasivo_Rpt.Action = 1
            ElseIf cOptLocal = "Opcion_Menu_4352" Then
               FRM_MDI_PASIVO.Pasivo_Rpt.ReportFileName = GLB_Ubicacion_Reporte & "RPT_CONTABILIDAD_TIPO.rpt"
               PROC_ESTABLECE_UBICACION FRM_MDI_PASIVO.Pasivo_Rpt.RetrieveDataFiles, FRM_MDI_PASIVO.Pasivo_Rpt
               FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(0) = cFecha_Desde
               'FRM_MDI_PASIVO.Pasivo_Rpt.Formulas(0) = "xUsuario='" & GLB_Usuario & "'"
               FRM_MDI_PASIVO.Pasivo_Rpt.Connect = GLB_CONECCION
               FRM_MDI_PASIVO.Pasivo_Rpt.Action = 1
            ElseIf cOptLocal = "Opcion_Menu_4353" Then
               FRM_MDI_PASIVO.Pasivo_Rpt.ReportFileName = GLB_Ubicacion_Reporte & "RPT_INFORME_CONTABILIDAD.rpt"
               PROC_ESTABLECE_UBICACION FRM_MDI_PASIVO.Pasivo_Rpt.RetrieveDataFiles, FRM_MDI_PASIVO.Pasivo_Rpt
               FRM_MDI_PASIVO.Pasivo_Rpt.StoredProcParam(0) = cFecha_Desde
               'FRM_MDI_PASIVO.Pasivo_Rpt.Formulas(0) = "xUsuario='" & GLB_Usuario & "'"
               FRM_MDI_PASIVO.Pasivo_Rpt.Connect = GLB_CONECCION
               FRM_MDI_PASIVO.Pasivo_Rpt.Action = 1
            
            End If
             
              Screen.MousePointer = 0
Exit Sub

Control:
   Call PROC_LOG_AUDITORIA("10", cOptLocal, Me.Caption & " Error al emitir reporte- Informe de Listado de Movimientos- Fecha Proceso: " & TxtFecProc.Text, "", "")
   MsgBox "Problemas al generar Listado de Movimientos. " & Err.Description, vbCritical

   Screen.MousePointer = 0
End Sub
