VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.2#0"; "mscomctl.ocx"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Begin VB.Form FRM_CONSULTA_OPERACIONES 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Consulta de Operaciones"
   ClientHeight    =   6075
   ClientLeft      =   315
   ClientTop       =   1770
   ClientWidth     =   9270
   Icon            =   "FRM_CONSULTA_OPERACIONES.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   6075
   ScaleWidth      =   9270
   Begin VB.TextBox txt_Cadena_Ejecutable 
      Enabled         =   0   'False
      Height          =   285
      Left            =   1380
      TabIndex        =   8
      Top             =   6210
      Visible         =   0   'False
      Width           =   7155
   End
   Begin VB.CheckBox Chk_Todos 
      Caption         =   "Todas"
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   225
      Left            =   11445
      TabIndex        =   5
      Top             =   225
      Width           =   525
   End
   Begin MSComctlLib.Toolbar Tlb_Consulta 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   7
      Top             =   0
      Width           =   9270
      _ExtentX        =   16351
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
            Key             =   "Filtrar"
            Description     =   "Filtrar"
            Object.ToolTipText     =   "Filtrar Operaciones"
            ImageIndex      =   13
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Key             =   "Anular"
            Description     =   "Anular"
            Object.ToolTipText     =   "Anular Operación"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Enabled         =   0   'False
            Key             =   "Consultar"
            Description     =   "Consultar"
            Object.ToolTipText     =   "Consultar Operación"
            ImageIndex      =   25
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Description     =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Modificar"
            Description     =   "Modificar"
            Object.ToolTipText     =   "Modificar"
            ImageIndex      =   16
         EndProperty
      EndProperty
      Begin MSComctlLib.ImageList Img_opciones 
         Left            =   6480
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
               Picture         =   "FRM_CONSULTA_OPERACIONES.frx":030A
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_CONSULTA_OPERACIONES.frx":0771
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_CONSULTA_OPERACIONES.frx":0C67
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_CONSULTA_OPERACIONES.frx":10FA
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_CONSULTA_OPERACIONES.frx":15E2
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_CONSULTA_OPERACIONES.frx":1AF5
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_CONSULTA_OPERACIONES.frx":2032
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_CONSULTA_OPERACIONES.frx":2474
               Key             =   ""
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_CONSULTA_OPERACIONES.frx":292E
               Key             =   ""
            EndProperty
            BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_CONSULTA_OPERACIONES.frx":2E01
               Key             =   ""
            EndProperty
            BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_CONSULTA_OPERACIONES.frx":3245
               Key             =   ""
            EndProperty
            BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_CONSULTA_OPERACIONES.frx":37AC
               Key             =   ""
            EndProperty
            BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_CONSULTA_OPERACIONES.frx":3C7B
               Key             =   ""
            EndProperty
            BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_CONSULTA_OPERACIONES.frx":409A
               Key             =   ""
            EndProperty
            BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_CONSULTA_OPERACIONES.frx":4592
               Key             =   ""
            EndProperty
            BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_CONSULTA_OPERACIONES.frx":498B
               Key             =   ""
            EndProperty
            BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_CONSULTA_OPERACIONES.frx":4E0E
               Key             =   ""
            EndProperty
            BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_CONSULTA_OPERACIONES.frx":52D4
               Key             =   ""
            EndProperty
            BeginProperty ListImage19 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_CONSULTA_OPERACIONES.frx":57CB
               Key             =   ""
            EndProperty
            BeginProperty ListImage20 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_CONSULTA_OPERACIONES.frx":5C81
               Key             =   ""
            EndProperty
            BeginProperty ListImage21 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_CONSULTA_OPERACIONES.frx":6046
               Key             =   ""
            EndProperty
            BeginProperty ListImage22 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_CONSULTA_OPERACIONES.frx":643C
               Key             =   ""
            EndProperty
            BeginProperty ListImage23 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_CONSULTA_OPERACIONES.frx":6833
               Key             =   ""
            EndProperty
            BeginProperty ListImage24 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_CONSULTA_OPERACIONES.frx":6C3C
               Key             =   ""
            EndProperty
            BeginProperty ListImage25 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_CONSULTA_OPERACIONES.frx":70FA
               Key             =   ""
            EndProperty
         EndProperty
      End
      Begin VB.Timer Tmr_Consulta 
         Interval        =   100
         Left            =   8160
         Top             =   60
      End
   End
   Begin Threed.SSFrame Frame 
      Height          =   2175
      Index           =   3
      Left            =   480
      TabIndex        =   0
      Top             =   10200
      Visible         =   0   'False
      Width           =   3450
      _Version        =   65536
      _ExtentX        =   6085
      _ExtentY        =   3836
      _StockProps     =   14
      ShadowStyle     =   1
      Begin VB.Label lblLabel 
         Caption         =   "lblLabel(1)"
         Height          =   345
         Index           =   1
         Left            =   1800
         TabIndex        =   2
         Top             =   240
         Width           =   1305
      End
      Begin VB.Label lblLabel 
         BackColor       =   &H00800000&
         Caption         =   "lblLabel(0)"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   345
         Index           =   0
         Left            =   315
         TabIndex        =   1
         Top             =   240
         Width           =   1305
      End
   End
   Begin Threed.SSFrame Frame 
      Height          =   5625
      Index           =   1
      Left            =   0
      TabIndex        =   3
      Top             =   450
      Width           =   9255
      _Version        =   65536
      _ExtentX        =   16325
      _ExtentY        =   9922
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
      Begin MSFlexGridLib.MSFlexGrid Grd_Consulta 
         Height          =   5115
         Left            =   30
         TabIndex        =   6
         Top             =   480
         Width           =   9150
         _ExtentX        =   16140
         _ExtentY        =   9022
         _Version        =   393216
         Rows            =   3
         Cols            =   19
         FixedRows       =   2
         FixedCols       =   0
         BackColor       =   -2147483644
         ForeColor       =   8388608
         BackColorFixed  =   8421376
         ForeColorFixed  =   16777215
         BackColorBkg    =   -2147483644
         FocusRect       =   0
         GridLines       =   2
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
      Begin VB.Label Etiqueta_Consulta 
         Alignment       =   2  'Center
         BackColor       =   &H00800000&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "CONSULTA DE OPERACIONES"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   330
         Left            =   60
         TabIndex        =   4
         Top             =   105
         Width           =   9135
      End
   End
End
Attribute VB_Name = "FRM_CONSULTA_OPERACIONES"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim cOptLocal As String
Sub PROC_DIBUJA_GRILLA_DIARIAS()
   
   Dim nContador_1 As Integer
   Dim nContador_2 As Integer
   
   With Grd_Consulta

      .Cols = 22
      .Rows = .FixedRows
      .RowHeight(0) = 250

      For nContador_1 = 0 To .FixedRows - 1
      
         For nContador_2 = 0 To .Cols - 1
         
            .TextMatrix(nContador_1, nContador_2) = ""
            .ColWidth(nContador_2 - 1) = 0
            
         Next nContador_2
         
      Next nContador_1

      .TextMatrix(0, 0) = "Marcado"
      .TextMatrix(0, 1) = "Producto"
      .TextMatrix(0, 2) = "Número":             .TextMatrix(1, 2) = "Operación"
      .TextMatrix(0, 3) = "Nombre":             .TextMatrix(1, 3) = "Cliente"
      .TextMatrix(0, 4) = "Fecha":              .TextMatrix(1, 4) = "Colocación"
      .TextMatrix(0, 5) = "Monto":              .TextMatrix(1, 7) = "Original"
      .TextMatrix(0, 6) = "Moneda":             .TextMatrix(1, 9) = "Oper."

      .ColAlignment(0) = 0
      .ColAlignment(1) = 1
      .ColAlignment(2) = 7
      .ColAlignment(3) = 1
      .ColAlignment(4) = 1
      .ColAlignment(5) = 7
      .ColAlignment(6) = 1

      .ColWidth(1) = 1000
      .ColWidth(2) = 1000
      .ColWidth(3) = 3050
      .ColWidth(4) = 1200
      .ColWidth(5) = 2000
      .ColWidth(6) = 800
      
      .Col = 0
      .ColSel = 0

      .Enabled = False
   
   End With

End Sub
Private Sub PROC_ANULAR_OPERACION()
   
   Dim X             As Long
   Dim nOperacion    As Long
   Dim nCont         As Integer
   Dim nFila         As Long
   Dim UltimaFila    As Long
   Dim rstMensaje    As ADODB.Recordset
   Dim Datos()
   
'************JUANLIZAMA********************

  Dim datosAUX()
   GLB_Envia = Array("PSV")
   
       If FUNC_EXECUTA_COMANDO_SQL("SP_CON_ESTADO_SWITCH", GLB_Envia) Then
        Do While FUNC_LEE_RETORNO_SQL(datosAUX())
    
            If datosAUX(5) = 1 And datosAUX(6) = "MESA" Then

                  MsgBox "Mesa esta bloqueada", vbExclamation
                  Grd_Consulta.SetFocus
                  Exit Sub
   
            Else
                  If Grd_Consulta.Rows = Grd_Consulta.FixedRows Then
                    
                    MsgBox "No existen operaciones para anular", vbExclamation
                    Grd_Consulta.SetFocus
                    Exit Sub
                
                  End If
                  
                  nCont = 0
                  
                  For nFila = 2 To Grd_Consulta.Rows - 1
                    If Grd_Consulta.TextMatrix(nFila, 20) = "X" Then
                
                        nCont = nCont + 1

                    End If

                  Next
                  
                 If nCont = 0 Then Exit Sub
                    
                    If MsgBox("¿ Está seguro de anular las Operaciones ?", vbQuestion + vbYesNo) = vbYes Then
                        Grd_Consulta.SetFocus
                    Else
                        Exit Sub
                    End If
                 
              If Grd_Consulta.Enabled Then

                 Grd_Consulta.SetFocus

             End If
            
            nCont = 0

            With Grd_Consulta
                
                UltimaFila = .Rows - 1
                nFila = .FixedRows
                .Redraw = False

                Do While nFila <= UltimaFila

                    If .TextMatrix(nFila, 20) = "X" Then
                        nCont = nCont + 1
                        nOperacion = Grd_Consulta.TextMatrix(nFila, 2)
                        
                   If Not Anular_Operacion(rstMensaje, GLB_Usuario_Bac, , (nOperacion)) Then

                        .Redraw = True
                         Exit Sub

                   End If

                  If .Rows > .FixedRows + 1 Then

                        .RemoveItem nFila
    
                  Else

                        .Rows = .FixedRows
                        .FocusRect = flexFocusLight
                        .Col = 0
                
                 End If

                        UltimaFila = UltimaFila - 1
                        nFila = nFila - 1

            End If
 
          nFila = nFila + 1
 
       Loop

       .Redraw = True

       If nCont = 0 Then

          MsgBox "Seleccione una operación.", vbInformation
          .SetFocus
          Exit Sub
 
      Else

         Call PROC_LOG_AUDITORIA("04", cOptLocal, Me.Caption, "", "")

        End If
 
    End With
 
    If Grd_Consulta.Enabled Then

       Grd_Consulta.SetFocus
 
    End If
   
           End If
        Exit Sub
        Loop
    End If
    Exit Sub


'***************************************
   
   
   
'   If (objCentralizacion.Chequeo_Estado(GLB_Sistema, "bloqueo", False) And objCentralizacion.Error = 0) Then

'      MsgBox objCentralizacion.Mensaje, vbExclamation
'      Grd_Consulta.SetFocus
'      Exit Sub
'
'   End If
'
'   If Grd_Consulta.Rows = Grd_Consulta.FixedRows Then
'
'      MsgBox "No existen operaciones para anular", vbExclamation
'      Grd_Consulta.SetFocus
'      Exit Sub
'
'   End If
'
'   nCont = 0
'
'   For nFila = 2 To Grd_Consulta.Rows - 1
'
'      If Grd_Consulta.TextMatrix(nFila, 20) = "X" Then
'
'         nCont = nCont + 1
'
'      End If
'
'   Next
'
'   If nCont = 0 Then Exit Sub
'
'   If MsgBox("¿ Está seguro de anular las Operaciones ?", vbQuestion + vbYesNo) = vbNo Then
'
'      Grd_Consulta.SetFocus
'      Exit Sub
'
'   End If
'
'   Call objCentralizacion.Chequeo_Estado(GLB_Sistema, "Bloqueo", False)
'   If Not objCentralizacion.Estado And objCentralizacion.Error <> 0 Then
'
'      MsgBox objCentralizacion.Mensaje, vbExclamation
'
'      If Grd_Consulta.Enabled Then
'
'         Grd_Consulta.SetFocus
'
'      End If
'
'      Exit Sub
'
'   End If
'
'   nCont = 0
'
'   With Grd_Consulta
'
'      UltimaFila = .Rows - 1
'      nFila = .FixedRows
'
'      .Redraw = False
'
'      Do While nFila <= UltimaFila
'
'         If .TextMatrix(nFila, 20) = "X" Then
'
'            nCont = nCont + 1
'
'            nOperacion = Grd_Consulta.TextMatrix(nFila, 2)
'
'
''            If GLB_Lineas = "S" Then
''
''                GLB_objControl.Lineas_Anular "PSV", nOperacion
''                Exit Sub
''
''            End If
'
'            If Not GLB_objGrabar.Anular_Operacion(rstMensaje, GLB_Usuario_Bac, , (nOperacion)) Then
'
'               .Redraw = True
'               MsgBox GLB_objGrabar.FUNC_RETORNA_MENSAJE(rstMensaje), vbCritical
'               Exit Sub
'
'            End If
'
'            If .Rows > .FixedRows + 1 Then
'
'               .RemoveItem nFila
'
'            Else
'
'               .Rows = .FixedRows
'               .FocusRect = flexFocusLight
'               .Col = 0
'
'
'            End If
'
'            UltimaFila = UltimaFila - 1
'            nFila = nFila - 1
'
'         End If
'
'         nFila = nFila + 1
'
'      Loop
'
'      .Redraw = True
'
'      If nCont = 0 Then
'
'         MsgBox "Seleccione una operación.", vbInformation
'         .SetFocus
'         Exit Sub
'
'      Else
'
'         Call PROC_LOG_AUDITORIA("04", cOptLocal, Me.Caption, "", "")
'
'      End If
'
'   End With
'
'   If Grd_Consulta.Enabled Then
'
'      Grd_Consulta.SetFocus
'
'   End If
'
End Sub

Private Sub PROC_FILTRAR()

   txt_Cadena_Ejecutable.Text = ""
   
   FRM_MDI_PASIVO.Tmr_Mensaje.Enabled = False
   FRM_FILTRO_CONSULTA.Show vbModal
   FRM_MDI_PASIVO.Tmr_Mensaje.Enabled = True
   
   Screen.MousePointer = 11

   If GLB_Oopcion_Tlb = 1 Then

     Etiqueta_Consulta.Caption = GLB_Titulo_Consulta
         
      DoEvents
      
      Grd_Consulta.Redraw = False
      
      Call PROC_CARGA_DATOS(txt_Cadena_Ejecutable.Text)
      
      Grd_Consulta.Redraw = True

      If Grd_Consulta.Enabled Then
         
         Grd_Consulta.SetFocus
      
      End If

   End If

   Screen.MousePointer = 0

End Sub

Private Sub Form_Activate()

   PROC_CARGA_AYUDA Me
   
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
Dim Opcion As Integer

   Opcion = 0

   If KeyCode = vbKeyReturn Then
      
      KeyCode = 0
      FUNC_ENVIA_TECLA vbKeyTab
      Exit Sub
   
   End If

    If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) Then

      Select Case KeyCode

         Case vbKeyFiltrar:
                           
                           Opcion = 1

         Case VbKeyAnular:
                           
                           Opcion = 2

         Case VbKeyDetalle:
                           
                           Opcion = 3

         Case vbKeySalir:
                           
                           Opcion = 4

      End Select

      If Opcion <> 0 Then
         
         If Tlb_Consulta.Buttons(Opcion).Enabled Then
            
            Call Tlb_Consulta_ButtonClick(Tlb_Consulta.Buttons(Opcion))
         
         End If

      End If

   End If

End Sub

Private Sub Form_Load()
   
   Dim nColumn          As Integer
   
   Me.Icon = FRM_MDI_PASIVO.Icon
   Me.top = 0
   Me.left = 0
   cOptLocal = GLB_Opcion_Menu

   PROC_DIBUJA_GRILLA_DIARIAS

   Call PROC_CARGA_DATOS("")

   Etiqueta_Consulta.Caption = "CONSULTA OPERACIONES DEL DIA  |  (Ordenado por Cliente)"
 
   Call PROC_LOG_AUDITORIA("07", cOptLocal, Me.Caption, "", "")

   Me.MousePointer = vbNormal

End Sub

Private Sub Form_Unload(Cancel As Integer)

   Call PROC_LOG_AUDITORIA("08", cOptLocal, Me.Caption, "", "")

End Sub

Private Sub Grd_Consulta_DblClick()

   If Grd_Consulta.TextMatrix(Grd_Consulta.Row, 20) = "X" Then

      Call Grd_Consulta_KeyDown(vbKeyD, 0)

   Else

      Call Grd_Consulta_KeyDown(vbKeyM, 0)

   End If

End Sub

Private Sub Tlb_Consulta_ButtonClick(ByVal Button As MSComctlLib.Button)


   Select Case Button.Key

       Case "Filtrar": Call PROC_FILTRAR

       Case "Anular": Call PROC_ANULAR_OPERACION

       Case "Consultar": Call PROC_CONSULTA_OPERACIONES
           
       Case "Modificar": Call PROC_MODIFICAR_OPERACIONES
       
       Case "Salir": Unload Me: Exit Sub

   End Select


   Call FUNC_CONTAR_MARCADOS

End Sub

Private Sub Grd_Consulta_KeyDown(KeyCode As Integer, Shift As Integer)

   Dim RowSaved As Long
   Dim ColSaved As Long

   Dim Datos()
   GLB_Envia = Array("PSV")

   If Shift <> 2 And KeyCode <> vbKeySalir Then
        
     If FUNC_EXECUTA_COMANDO_SQL("SP_CON_ESTADO_SWITCH", GLB_Envia) Then
        Do While FUNC_LEE_RETORNO_SQL(Datos())
            If Datos(5) = 1 And Datos(6) = "FIN" Then
               MsgBox "Fin de día realizado, debe realizar inicio de día", vbExclamation
               Exit Sub
            End If
        Loop
        cOpt = "Opcion_Menu_3100"
        Screen.MousePointer = 11
        Grd_Consulta.SetFocus
        Screen.MousePointer = 0
     End If

   End If

   With Grd_Consulta

      RowSaved = .Row
      ColSaved = .Col

      If KeyCode = vbKeyM And Trim(.TextMatrix(.Row, 20)) = "" Then

         .FocusRect = flexFocusLight
         Call PROC_MARCA_OPERACIONES(Grd_Consulta, .Row, GLB_Azul, GLB_Blanco)
         .FocusRect = flexFocusNone
         .Row = RowSaved
         .Col = ColSaved
         .TextMatrix(.Row, 20) = "X"

      ElseIf KeyCode = vbKeyD And .TextMatrix(.Row, 20) = "X" Then

         Select Case .TextMatrix(.Row, 19)

               Case "RECHAZADA":  Call PROC_MARCA_OPERACIONES(Grd_Consulta, .Row, GLB_Rojo, GLB_Blanco)
               Case "PENDIENTE":  Call PROC_MARCA_OPERACIONES(Grd_Consulta, .Row, GLB_Negro, GLB_Celeste)
               Case "CALZADA":    Call PROC_MARCA_OPERACIONES(Grd_Consulta, .Row, GLB_Celeste, GLB_Azul)
               Case "VIGENTE":    Call PROC_MARCA_OPERACIONES(Grd_Consulta, .Row, GLB_Gris, GLB_AzulOsc)
               Case "":           Call PROC_MARCA_OPERACIONES(Grd_Consulta, .Row, GLB_Gris, GLB_AzulOsc)

         End Select

         .Row = RowSaved
         .Col = ColSaved
         .TextMatrix(.Row, 20) = " "

      ElseIf KeyCode = vbKeySpace Then

          If .TextMatrix(.Row, 20) = "X" Then

            Select Case .TextMatrix(.Row, 19)

                  Case "RECHAZADA":  Call PROC_MARCA_OPERACIONES(Grd_Consulta, .Row, GLB_Rojo, GLB_Blanco)
                  Case "PENDIENTE":  Call PROC_MARCA_OPERACIONES(Grd_Consulta, .Row, GLB_Negro, GLB_Celeste)
                  Case "CALZADA":    Call PROC_MARCA_OPERACIONES(Grd_Consulta, .Row, GLB_Celeste, GLB_Azul)
                  Case "VIGENTE":    Call PROC_MARCA_OPERACIONES(Grd_Consulta, .Row, GLB_Gris, GLB_AzulOsc)
                  Case "":           Call PROC_MARCA_OPERACIONES(Grd_Consulta, .Row, GLB_Gris, GLB_AzulOsc)

            End Select

            .Row = RowSaved
            .Col = ColSaved
            .TextMatrix(.Row, 20) = " "

         Else

            .FocusRect = flexFocusLight

            Call PROC_MARCA_OPERACIONES(Grd_Consulta, .Row, GLB_Azul, GLB_Blanco)

            .FocusRect = flexFocusNone

            .Row = RowSaved
            .Col = ColSaved
            .TextMatrix(.Row, 20) = "X"

         End If

      End If

      If KeyCode = vbKeyM Or KeyCode = vbKeyD Or KeyCode = vbKeySpace Then

         Call FUNC_CONTAR_MARCADOS

      End If

   End With
   
End Sub
Private Function FUNC_CONTAR_MARCADOS() As Long

   Dim nContador As Long
   Dim bAnula   As Boolean


   bAnula = True

   FUNC_CONTAR_MARCADOS = 0
   
   For nContador = Grd_Consulta.FixedRows To Grd_Consulta.Rows - 1
      
      If Grd_Consulta.TextMatrix(nContador, 20) = "X" Then
         
         FUNC_CONTAR_MARCADOS = FUNC_CONTAR_MARCADOS + 1
      
      End If

   Next nContador

End Function
Sub PROC_CARGA_DATOS(cCadena_Ejecutable As String)

Dim vDatos_Retorno()
Dim nIndice          As Integer
Dim Format_Decimal As String

   With Grd_Consulta
      
      Grd_Consulta.Rows = 2
      
      If Trim(cCadena_Ejecutable) = "" Then
         If Not FUNC_EXECUTA_COMANDO_SQL("SP_CON_OPERACIONES") Then
      
            MsgBox "No fue posible leer información", vbOKOnly + vbCritical
            Exit Sub
         
         Else
      
            .Rows = 2
         
            Do While FUNC_LEE_RETORNO_SQL(vDatos_Retorno())
                .Rows = .Rows + 1
                nIndice = .Rows - 1
                
                'EBQ - 20041105
                '**************
                If Val(vDatos_Retorno(7)) = 0 Then
                    Format_Decimal = "#,##0"
                Else
                    Format_Decimal = "#,##0." & String(vDatos_Retorno(7), "0")
                End If
                
               .TextMatrix(nIndice, 1) = vDatos_Retorno(1)
               .TextMatrix(nIndice, 2) = vDatos_Retorno(2)
               .TextMatrix(nIndice, 3) = vDatos_Retorno(3)
               .TextMatrix(nIndice, 4) = vDatos_Retorno(4)
               .TextMatrix(nIndice, 5) = Format(vDatos_Retorno(5), Format_Decimal)
               .TextMatrix(nIndice, 6) = vDatos_Retorno(6)
            Loop
        
         End If
      Else
         
         If Not FUNC_EXECUTA_COMANDO_SQL(cCadena_Ejecutable) Then
      
            MsgBox "No fue posible leer información", vbOKOnly + vbCritical
            Exit Sub
         
         Else
      
            .Rows = 2
         
            Do While FUNC_LEE_RETORNO_SQL(vDatos_Retorno())
         
                .Rows = .Rows + 1
                nIndice = .Rows - 1
               
                'EBQ - 20041105
                '**************
                If Val(vDatos_Retorno(9)) = 0 Then
                    Format_Decimal = "#,##0"
                Else
                    Format_Decimal = "#,##0." & String(vDatos_Retorno(9), "0")
                End If
                              
               .TextMatrix(nIndice, 1) = vDatos_Retorno(1)
               .TextMatrix(nIndice, 2) = vDatos_Retorno(2)
               .TextMatrix(nIndice, 3) = vDatos_Retorno(3)
               .TextMatrix(nIndice, 4) = vDatos_Retorno(4)
               .TextMatrix(nIndice, 5) = Format(vDatos_Retorno(5), Format_Decimal)
               .TextMatrix(nIndice, 6) = vDatos_Retorno(6)
               
            Loop
        
         End If
      
      End If
      
   End With

   If Grd_Consulta.Rows > 2 Then

      Grd_Consulta.Enabled = True
      Tlb_Consulta.Buttons(2).Enabled = True

      
   End If
   
End Sub
Private Sub Tmr_Consulta_Timer()

Dim nCont As Integer
Dim nFila As Integer

   nCont = 0

   For nFila = 2 To Grd_Consulta.Rows - 1

      If Grd_Consulta.TextMatrix(nFila, 20) = "X" Then

         nCont = nCont + 1

      End If

   Next

   If nCont = 0 Then
      Tlb_Consulta.Buttons(2).Enabled = False
   Else
      Tlb_Consulta.Buttons(2).Enabled = True
   End If


   If nCont <> 1 Then
      Tlb_Consulta.Buttons(3).Enabled = False

   Else
      Tlb_Consulta.Buttons(3).Enabled = True


   End If

End Sub
Sub PROC_CONSULTA_OPERACIONES()

Dim nNumero_Operacion   As Double
Dim cTipo_Instrumento   As String
Dim cTipo_Producto      As String
Dim vDatos_Retorno()
Dim nFila               As Integer
Dim nContador           As Integer
Dim nIndice          As Integer
Dim Total_op        As Double
Dim Valor_Estimado_1   As Double
Dim Valor_Estimado_2   As Double
Dim Valor_Estimado_3   As Double
Dim Valor_Estimado_4   As Double
Dim nMoneda            As Integer

GLB_Tipo_llamado = "G"

Total_op = 0
   For nFila = 2 To Grd_Consulta.Rows - 1
   
      If Grd_Consulta.TextMatrix(nFila, 20) = "X" Then

         nNumero_Operacion = CDbl(Grd_Consulta.TextMatrix(nFila, 2))
         cTipo_Instrumento = Trim(Grd_Consulta.TextMatrix(nFila, 1))
      End If
      
   Next

    GLB_Envia = Array()
    PROC_AGREGA_PARAMETRO GLB_Envia, cTipo_Instrumento

   If Not FUNC_EXECUTA_COMANDO_SQL("SP_CON_CODIGO_PRODUCTO", GLB_Envia) Then
   
      
      MsgBox "No fue posible leer información", vbOKOnly + vbCritical
      Exit Sub
         
   Else
            
      Do While FUNC_LEE_RETORNO_SQL(vDatos_Retorno())
         cTipo_Producto = vDatos_Retorno(1)
      Loop
        
   End If

   If Trim(cTipo_Producto) = "BONOS" Or Trim(cTipo_Producto) = "LETRA" Then
   
    Valor_Estimado_1 = 0
    Valor_Estimado_2 = 0
    Valor_Estimado_3 = 0
    Valor_Estimado_4 = 0
    
      Me.Hide
      GLB_Tipo_llamado = "M"
      FRM_ING_BONOS.Show
      FRM_ING_BONOS.txt_Numero_Operacion.Text = nNumero_Operacion
                  
            With FRM_ING_BONOS.Grd_Compra_Bonos
         
               GLB_Envia = Array()
               PROC_AGREGA_PARAMETRO GLB_Envia, nNumero_Operacion
               PROC_AGREGA_PARAMETRO GLB_Envia, 1
               
               If Not FUNC_EXECUTA_COMANDO_SQL("SP_CON_BONOS", GLB_Envia) Then
               
                  MsgBox "No fue posible leer información", vbOKOnly + vbCritical
                  Exit Sub
                  
               Else
               
                  .Rows = 1
                  
                  Do While FUNC_LEE_RETORNO_SQL(vDatos_Retorno())
                  
                      .Rows = .Rows + 1
                      nIndice = .Rows - 1
                     .TextMatrix(nIndice, 0) = Trim(vDatos_Retorno(1))
                     .TextMatrix(nIndice, 1) = Format(vDatos_Retorno(2), GLB_Formato_Decimal)
                     .TextMatrix(nIndice, 2) = Format(vDatos_Retorno(3), GLB_Formato_Decimal)
                     .TextMatrix(nIndice, 3) = Format(vDatos_Retorno(4), GLB_Formato_Entero)
                     .TextMatrix(nIndice, 4) = Format(vDatos_Retorno(5), GLB_Formato_Decimal)
                     .TextMatrix(nIndice, 5) = Format(vDatos_Retorno(6), GLB_Formato_Entero)
                     .TextMatrix(nIndice, 9) = CDate(vDatos_Retorno(7))
                     Valor_Estimado_1 = Valor_Estimado_1 + Format(vDatos_Retorno(8), IIf(vDatos_Retorno(14) <> 999 Or vDatos_Retorno(14) <> 998 Or vDatos_Retorno(14) <> 994, GLB_Formato_Dec_USD, GLB_Formato_Entero))
                     .TextMatrix(nIndice, 15) = Format(vDatos_Retorno(8), IIf(vDatos_Retorno(14) <> 999 Or vDatos_Retorno(14) <> 998 Or vDatos_Retorno(14) <> 994, GLB_Formato_Dec_USD, GLB_Formato_Entero))
                     Valor_Estimado_2 = Valor_Estimado_2 + Format(vDatos_Retorno(9), IIf(vDatos_Retorno(14) <> 999 Or vDatos_Retorno(14) <> 998 Or vDatos_Retorno(14) <> 994, GLB_Formato_Dec_USD, GLB_Formato_Entero))
                     .TextMatrix(nIndice, 16) = Format(vDatos_Retorno(9), IIf(vDatos_Retorno(14) <> 999 Or vDatos_Retorno(14) <> 998 Or vDatos_Retorno(14) <> 994, GLB_Formato_Dec_USD, GLB_Formato_Entero))
                     Valor_Estimado_3 = Valor_Estimado_3 + Format(vDatos_Retorno(10), IIf(vDatos_Retorno(14) <> 999 Or vDatos_Retorno(14) <> 998 Or vDatos_Retorno(14) <> 994, GLB_Formato_Dec_USD, GLB_Formato_Entero))
                     .TextMatrix(nIndice, 17) = Format(vDatos_Retorno(10), IIf(vDatos_Retorno(14) <> 999 Or vDatos_Retorno(14) <> 998 Or vDatos_Retorno(14) <> 994, GLB_Formato_Dec_USD, GLB_Formato_Entero))
                     Valor_Estimado_4 = Valor_Estimado_4 + Format(vDatos_Retorno(11), IIf(vDatos_Retorno(14) <> 999 Or vDatos_Retorno(14) <> 998 Or vDatos_Retorno(14) <> 994, GLB_Formato_Dec_USD, GLB_Formato_Entero))
                     .TextMatrix(nIndice, 18) = Format(vDatos_Retorno(11), IIf(vDatos_Retorno(14) <> 999 Or vDatos_Retorno(14) <> 998 Or vDatos_Retorno(14) <> 994, GLB_Formato_Dec_USD, GLB_Formato_Entero))
                     Total_op = Total_op + Format(vDatos_Retorno(6), IIf(vDatos_Retorno(14) <> 999 Or vDatos_Retorno(14) <> 998 Or vDatos_Retorno(14) <> 994, GLB_Formato_Dec_USD, GLB_Formato_Entero))
                     nMoneda = Format(CInt(vDatos_Retorno(14)), GLB_Formato_Entero)
                     .TextMatrix(nIndice, 19) = Format(CInt(vDatos_Retorno(13)), GLB_Formato_Entero)
                     .TextMatrix(nIndice, 20) = Format(CInt(vDatos_Retorno(12)), GLB_Formato_Entero)
                  Loop
                 
              End If
            
            End With
   
      
      FRM_ING_BONOS.Tlb_Menu.Buttons(1).Enabled = False
      FRM_ING_BONOS.Tlb_Menu.Buttons(2).Enabled = True
      FRM_ING_BONOS.Tlb_Menu.Buttons(3).Enabled = True
      FRM_ING_BONOS.Grd_Compra_Bonos.Enabled = True
      FRM_ING_BONOS.FTB_VALOR_ESTIMADO1.CantidadDecimales = IIf(nMoneda <> 999 Or nMoneda <> 998 Or nMoneda <> 994, 2, 0)
      FRM_ING_BONOS.FTB_VALOR_ESTIMADO2.CantidadDecimales = IIf(nMoneda <> 999 Or nMoneda <> 998 Or nMoneda <> 994, 2, 0)
      FRM_ING_BONOS.FTB_VALOR_ESTIMADO3.CantidadDecimales = IIf(nMoneda <> 999 Or nMoneda <> 998 Or nMoneda <> 994, 2, 0)
      FRM_ING_BONOS.FTB_VALOR_ESTIMADO4.CantidadDecimales = IIf(nMoneda <> 999 Or nMoneda <> 998 Or nMoneda <> 994, 2, 0)
      FRM_ING_BONOS.Txt_Total_Operación = Format(Total_op, IIf(nMoneda = 13, GLB_Formato_Dec_USD, GLB_Formato_Entero))
      FRM_ING_BONOS.FTB_VALOR_ESTIMADO1.Text = Format(Valor_Estimado_1, IIf(nMoneda <> 999 Or nMoneda <> 998 Or nMoneda <> 994, GLB_Formato_Dec_USD, GLB_Formato_Entero))
      FRM_ING_BONOS.FTB_VALOR_ESTIMADO2.Text = Format(Valor_Estimado_2, IIf(nMoneda <> 999 Or nMoneda <> 998 Or nMoneda <> 994, GLB_Formato_Dec_USD, GLB_Formato_Entero))
      FRM_ING_BONOS.FTB_VALOR_ESTIMADO3.Text = Format(Valor_Estimado_3, IIf(nMoneda <> 999 Or nMoneda <> 998 Or nMoneda <> 994, GLB_Formato_Dec_USD, GLB_Formato_Entero))
      FRM_ING_BONOS.FTB_VALOR_ESTIMADO4.Text = Format(Valor_Estimado_4, IIf(nMoneda <> 999 Or nMoneda <> 998 Or nMoneda <> 994, GLB_Formato_Dec_USD, GLB_Formato_Entero))
      FRM_ING_BONOS.FRM_VALOR_ESTIMADO.Enabled = False
      
      
   ElseIf Trim(cTipo_Producto) = "CORFO" Then
   
      Me.Hide
      FRM_ING_CORFO.Show
      FRM_ING_CORFO.txt_Numero_Operacion.Text = nNumero_Operacion

      With FRM_ING_CORFO
      
            GLB_Envia = Array()
             PROC_AGREGA_PARAMETRO GLB_Envia, Val(nNumero_Operacion)
            
            If Not FUNC_EXECUTA_COMANDO_SQL("SP_CON_RENOVACION_OPERACION", GLB_Envia) Then
            
               MsgBox "No fue posible leer información", vbOKOnly + vbCritical
               Exit Sub
               
            Else
            
              
               Do While FUNC_LEE_RETORNO_SQL(vDatos_Retorno())
               
                  .TXT_Instrumento.Text = Trim(vDatos_Retorno(3))
                  .TXT_Familia.Text = vDatos_Retorno(4)
                  .FTB_Rut.Text = vDatos_Retorno(5)
                  .TXT_Digito.Text = vDatos_Retorno(6)
                  .TXT_Nombre.Text = vDatos_Retorno(7)
                     
                  For nContador = 0 To .CMB_Moneda.ListCount - 1
                  
                     .CMB_Moneda.ListIndex = nContador
                     
                     If CDbl(.CMB_Moneda.ItemData(.CMB_Moneda.ListIndex)) = CDbl(vDatos_Retorno(8)) Then
                        
                        Exit For
                     
                     End If
                        
                  Next
                     
                  .FTB_Monto.Text = vDatos_Retorno(19)
                  .FTB_Tasa.Text = vDatos_Retorno(10)
                  .FTB_Spread.Text = vDatos_Retorno(11)
                  
                  For nContador = 0 To .CMB_Base.ListCount - 1
                  
                     .CMB_Base.ListIndex = nContador
                     
                     If CDbl(.CMB_Base.ItemData(.CMB_Base.ListIndex)) = CDbl(vDatos_Retorno(12)) Then
                        
                        Exit For
                     
                     End If
                        
                  Next
                  
                  For nContador = 0 To .CMB_Tipo_Tasa.ListCount - 1
                  
                     .CMB_Tipo_Tasa.ListIndex = nContador
                     
                     If CDbl(.CMB_Tipo_Tasa.ItemData(.CMB_Tipo_Tasa.ListIndex)) = CDbl(vDatos_Retorno(13)) Then
                        
                        Exit For
                     
                     End If
                        
                  Next
                  
                  .TXT_Fecha_Otor.Text = vDatos_Retorno(14)
                  .FTB_Total_Tasa.Text = CDbl(.FTB_Tasa.Text) + CDbl(.FTB_Spread.Text)
                  
                  For nContador = 0 To .CMB_Periodo.ListCount - 1
                  
                     .CMB_Periodo.ListIndex = nContador
                     
                     If CDbl(.CMB_Periodo.ItemData(.CMB_Periodo.ListIndex)) = CDbl(vDatos_Retorno(16)) Then
                        
                        Exit For
                     
                     End If
                        
                  Next
                  
                  .FTB_Cuotas.Text = vDatos_Retorno(17)
                  .TXT_Fecha_Ven.Text = vDatos_Retorno(15)
                  .TXT_Fecha_Cuota.Text = vDatos_Retorno(18)
                  .FTB_Gracia.Text = vDatos_Retorno(34)
                  .FTB_Decimales.Text = vDatos_Retorno(33)
                  .FTB_Acuerdo.Text = vDatos_Retorno(2)
                  
                  'EBQ - 20041028
                  '**************
                  .FRM_FECHAS.Enabled = False
                  .SCHK_Capitaliza.Value = vDatos_Retorno(36)
                  DoEvents
                  .TXT_Fecha_Capitaliza.Text = vDatos_Retorno(35)
                  DoEvents
                  '**************
                  
                  .FRM_Instrumento.Enabled = False
                  .FRM_Cliente.Enabled = False
                  .FRM_MONEDA.Enabled = False
                  .FRM_ACUERDO.Enabled = False
                  .FRM_CAPITALIZACION.Enabled = False
                  .TBL_MENU.Buttons(1).Enabled = False
                  .TBL_MENU.Buttons(2).Enabled = False
                  .TBL_MENU.Buttons(3).Enabled = True
                  
                  
                  GLB_cOptLocal = "Opcion_Menu_3201"
               Loop
        
         End If
      
      End With

   ElseIf Trim(cTipo_Producto) = "LOCAL" Then
   
      Me.Hide
      FRM_ING_BANCO_LOCAL.Show
      FRM_ING_BANCO_LOCAL.txt_Numero_Operacion.Text = nNumero_Operacion
   
      With FRM_ING_BANCO_LOCAL
      
            GLB_Envia = Array()
            PROC_AGREGA_PARAMETRO GLB_Envia, .txt_Numero_Operacion.Text
            
            If Not FUNC_EXECUTA_COMANDO_SQL("SP_CON_RENOVACION_OPERACION", GLB_Envia) Then
            
               MsgBox "No fue posible leer información", vbOKOnly + vbCritical
               Exit Sub
               
            Else
            
              
               Do While FUNC_LEE_RETORNO_SQL(vDatos_Retorno())
               
                  .TXT_Instrumento.Text = Trim(vDatos_Retorno(3))
                  .TXT_Familia.Text = vDatos_Retorno(4)
                  
                  For nContador = 0 To .CMB_Moneda.ListCount - 1
                  
                     .CMB_Moneda.ListIndex = nContador
                     
                     If CDbl(.CMB_Moneda.ItemData(.CMB_Moneda.ListIndex)) = CDbl(vDatos_Retorno(8)) Then
                        
                        Exit For
                     
                     End If
                        
                  Next
                     
                  .FTB_Monto.Text = vDatos_Retorno(19)
                  .FTB_Tasa.Text = vDatos_Retorno(10)
                  .FTB_Spread.Text = vDatos_Retorno(11)
                  
                  For nContador = 0 To .CMB_Base.ListCount - 1
                  
                     .CMB_Base.ListIndex = nContador
                     
                     If CDbl(.CMB_Base.ItemData(.CMB_Base.ListIndex)) = CDbl(vDatos_Retorno(12)) Then
                        
                        Exit For
                     
                     End If
                        
                  Next
                  
                  For nContador = 0 To .CMB_Tipo_Tasa.ListCount - 1
                  
                     .CMB_Tipo_Tasa.ListIndex = nContador
                     
                     If CDbl(.CMB_Tipo_Tasa.ItemData(.CMB_Tipo_Tasa.ListIndex)) = CDbl(vDatos_Retorno(13)) Then
                        
                        Exit For
                     
                     End If
                        
                  Next
                  
                  .TXT_Fecha_Otor.Text = vDatos_Retorno(14)
                  
                  For nContador = 0 To .CMB_Periodo.ListCount - 1
                  
                     .CMB_Periodo.ListIndex = nContador
                     
                     If CDbl(.CMB_Periodo.ItemData(.CMB_Periodo.ListIndex)) = CDbl(vDatos_Retorno(16)) Then
                        
                        Exit For
                     
                     End If
                        
                  Next
                  
                  .FTB_Cuotas.Text = vDatos_Retorno(17)
                  .TXT_Fecha_Ven.Text = vDatos_Retorno(15)
                  .FTB_Total_Tasa.Text = CDbl(.FTB_Tasa.Text) + CDbl(.FTB_Spread.Text)
                  
                  .TXT_Fecha_Cuota.Text = vDatos_Retorno(18)
                  .FTB_Decimales.Text = vDatos_Retorno(33)
                  .FTB_Gracia.Text = vDatos_Retorno(34)
                  .SCHK_Capitaliza.Value = 0
                  
                  'EBQ - 20041028
                  '**************
                  .FRM_FECHAS.Enabled = False
                  .SCHK_Capitaliza.Value = vDatos_Retorno(36)
                  DoEvents
                  .TXT_Fecha_Capitaliza.Text = vDatos_Retorno(35)
                  DoEvents
                  '**************
                  
                  .FRM_Instrumento.Enabled = False
                  .FRM_MONEDA.Enabled = False
                  .FRM_CAPITALIZACION.Enabled = False
                  .TBL_MENU.Buttons(1).Enabled = False
                  .TBL_MENU.Buttons(2).Enabled = False
                  .TBL_MENU.Buttons(3).Enabled = True
                  GLB_cOptLocal = "Opcion_Menu_3202"
               Loop
        
         End If
      
      End With
   
   ElseIf Trim(cTipo_Producto) = "EXTRA" Then
   
      Me.Hide
      FRM_ING_BANCO_EXT.Show
      FRM_ING_BANCO_EXT.txt_Numero_Operacion.Text = nNumero_Operacion
   
      With FRM_ING_BANCO_EXT
      
            GLB_Envia = Array()
            PROC_AGREGA_PARAMETRO GLB_Envia, .txt_Numero_Operacion.Text
            
            If Not FUNC_EXECUTA_COMANDO_SQL("SP_CON_RENOVACION_OPERACION", GLB_Envia) Then
            
               MsgBox "No fue posible leer información", vbOKOnly + vbCritical
               Exit Sub
               
            Else
            
              
               Do While FUNC_LEE_RETORNO_SQL(vDatos_Retorno())
               
                  .TXT_Instrumento.Text = Trim(vDatos_Retorno(3))
                  .TXT_Familia.Text = vDatos_Retorno(4)
                  
                  For nContador = 0 To .CMB_Moneda.ListCount - 1
                  
                     .CMB_Moneda.ListIndex = nContador
                     
                     If CDbl(.CMB_Moneda.ItemData(.CMB_Moneda.ListIndex)) = CDbl(vDatos_Retorno(8)) Then
                        
                        Exit For
                     
                     End If
                        
                  Next
                     
                  .FTB_Monto.Text = vDatos_Retorno(19)
                  .FTB_Tasa.Text = vDatos_Retorno(10)
                  .FTB_Spread.Text = vDatos_Retorno(11)
                  
                  For nContador = 0 To .CMB_Base.ListCount - 1
                  
                     .CMB_Base.ListIndex = nContador
                     
                     If CDbl(.CMB_Base.ItemData(.CMB_Base.ListIndex)) = CDbl(vDatos_Retorno(12)) Then
                        
                        Exit For
                     
                     End If
                        
                  Next
                  
                  For nContador = 0 To .CMB_Tipo_Tasa.ListCount - 1
                  
                     .CMB_Tipo_Tasa.ListIndex = nContador
                     
                     If CDbl(.CMB_Tipo_Tasa.ItemData(.CMB_Tipo_Tasa.ListIndex)) = CDbl(vDatos_Retorno(13)) Then
                        
                        Exit For
                     
                     End If
                        
                  Next
                  
                  .TXT_Fecha_Otor.Text = vDatos_Retorno(14)
                  
                  For nContador = 0 To .CMB_Periodo.ListCount - 1
                  
                     .CMB_Periodo.ListIndex = nContador
                     
                     If CDbl(.CMB_Periodo.ItemData(.CMB_Periodo.ListIndex)) = CDbl(vDatos_Retorno(16)) Then
                        
                        Exit For
                     
                     End If
                        
                  Next
                  
                  .FTB_Cuotas.Text = vDatos_Retorno(17)
                  .TXT_Fecha_Ven.Text = vDatos_Retorno(15)
                  .FTB_Total_Tasa.Text = CDbl(.FTB_Tasa.Text) + CDbl(.FTB_Spread.Text)
                  .TXT_Fecha_Cuota.Text = vDatos_Retorno(18)
                  .FTB_Decimales.Text = vDatos_Retorno(33)
                  
                  .FRM_Instrumento.Enabled = False
                  .FRM_MONEDA.Enabled = False
                  .FRM_FECHAS.Enabled = False
                        'EBQ - 20041028
                  '**************
                  .SCHK_Capitaliza.Value = vDatos_Retorno(36)
                   DoEvents
                  .TXT_Fecha_Capitaliza.Text = vDatos_Retorno(35)
                   DoEvents
                  '**************
                  
                  .FRM_CAPITALIZACION.Enabled = False
                  
                  .TBL_MENU.Buttons(1).Enabled = False
                  .TBL_MENU.Buttons(2).Enabled = False
                  .TBL_MENU.Buttons(3).Enabled = True
                  GLB_cOptLocal = "Opcion_Menu_3203"
               Loop
            
         End If
      
      End With
   
   End If

End Sub
Public Function Anular_Operacion(ByRef rst_Mensajes As ADODB.Recordset, cUsuario_Anula As String, Optional nDeskmngr_KeyID As Single, Optional nNumero_Operacion_Bac_Trader As Single) As Boolean
Dim Datos(), Envia()

On Error GoTo ERRANULAROPERACION

Anular_Operacion = False

Envia = Array()
AddParam Envia, nNumero_Operacion_Bac_Trader

AddParam Envia, cUsuario_Anula

If Not FUNC_EXECUTA_COMANDO_SQL("SP_ELI_OPERACION_PASIVO", Envia) Then
        GoTo ERRANULAROPERACION
End If
If FUNC_LEE_RETORNO_SQL(Datos()) Then
   If Datos(1) = -1 Then
    MsgBox "Falla en anulación de operación", vbCritical
      GoTo ERRANULAROPERACION
   ElseIf Datos(1) = 2 Then
         MsgBox "No se pueden anular operaciones de días anteriores ", vbCritical
         GoTo ERRANULAROPERACION
   Else
        MsgBox "Operación N° " & Format(nNumero_Operacion_Bac_Trader, GLB_Formato_Entero) & " fue anulada correctamente ", vbExclamation
        
   End If
End If

Anular_Operacion = True

Exit Function

ERRANULAROPERACION:

End Function

'*************************************

Sub PROC_MODIFICAR_OPERACIONES()

Dim nNumero_Operacion   As Double
Dim cTipo_Instrumento   As String
Dim cTipo_Producto      As String
Dim vDatos_Retorno()
Dim nFila               As Integer
Dim nContador           As Integer
Dim nIndice          As Integer
Dim Total_op        As Double
Dim Valor_Estimado_1   As Double
Dim Valor_Estimado_2   As Double
Dim Valor_Estimado_3   As Double
Dim Valor_Estimado_4   As Double
Dim nMoneda            As Integer

GLB_Tipo_llamado = "G"

Total_op = 0
   For nFila = 2 To Grd_Consulta.Rows - 1
   
      If Grd_Consulta.TextMatrix(nFila, 20) = "X" Then

         nNumero_Operacion = CDbl(Grd_Consulta.TextMatrix(nFila, 2))
         cTipo_Instrumento = Trim(Grd_Consulta.TextMatrix(nFila, 1))
      End If
      
   Next

    GLB_Envia = Array()
    PROC_AGREGA_PARAMETRO GLB_Envia, cTipo_Instrumento

   If Not FUNC_EXECUTA_COMANDO_SQL("SP_CON_CODIGO_PRODUCTO", GLB_Envia) Then
   
      
      MsgBox "No fue posible leer información", vbOKOnly + vbCritical
      Exit Sub
         
   Else
            
      Do While FUNC_LEE_RETORNO_SQL(vDatos_Retorno())
         cTipo_Producto = vDatos_Retorno(1)
      Loop
        
   End If

   If Trim(cTipo_Producto) = "BONOS" Or Trim(cTipo_Producto) = "LETRA" Then
   
    Valor_Estimado_1 = 0
    Valor_Estimado_2 = 0
    Valor_Estimado_3 = 0
    Valor_Estimado_4 = 0
    
      Me.Hide
      GLB_Tipo_llamado = "M"
      FRM_ACT_BONOS.Show
      FRM_ACT_BONOS.txt_Numero_Operacion.Text = nNumero_Operacion
                  
            With FRM_ACT_BONOS.Grd_Compra_Bonos
         
               GLB_Envia = Array()
               PROC_AGREGA_PARAMETRO GLB_Envia, nNumero_Operacion
               PROC_AGREGA_PARAMETRO GLB_Envia, 1
               
               If Not FUNC_EXECUTA_COMANDO_SQL("SP_CON_BONOS", GLB_Envia) Then
               
                  MsgBox "No fue posible leer información", vbOKOnly + vbCritical
                  Exit Sub
                  
               Else
               
                  .Rows = 1
                  
                  Do While FUNC_LEE_RETORNO_SQL(vDatos_Retorno())
                  
                      .Rows = .Rows + 1
                      nIndice = .Rows - 1
                     .TextMatrix(nIndice, 0) = Trim(vDatos_Retorno(1))
                     .TextMatrix(nIndice, 1) = Format(vDatos_Retorno(2), GLB_Formato_Decimal)
                     .TextMatrix(nIndice, 2) = Format(vDatos_Retorno(3), GLB_Formato_Decimal)
                     .TextMatrix(nIndice, 3) = Format(vDatos_Retorno(4), GLB_Formato_Entero)
                     .TextMatrix(nIndice, 4) = Format(vDatos_Retorno(5), GLB_Formato_Decimal)
                     .TextMatrix(nIndice, 5) = Format(vDatos_Retorno(6), GLB_Formato_Entero)
                     .TextMatrix(nIndice, 9) = CDate(vDatos_Retorno(7))
                     Valor_Estimado_1 = Valor_Estimado_1 + Format(vDatos_Retorno(8), IIf(vDatos_Retorno(14) <> 999 Or vDatos_Retorno(14) <> 998 Or vDatos_Retorno(14) <> 994, GLB_Formato_Dec_USD, GLB_Formato_Entero))
                     .TextMatrix(nIndice, 15) = Format(vDatos_Retorno(8), IIf(vDatos_Retorno(14) <> 999 Or vDatos_Retorno(14) <> 998 Or vDatos_Retorno(14) <> 994, GLB_Formato_Dec_USD, GLB_Formato_Entero))
                     Valor_Estimado_2 = Valor_Estimado_2 + Format(vDatos_Retorno(9), IIf(vDatos_Retorno(14) <> 999 Or vDatos_Retorno(14) <> 998 Or vDatos_Retorno(14) <> 994, GLB_Formato_Dec_USD, GLB_Formato_Entero))
                     .TextMatrix(nIndice, 16) = Format(vDatos_Retorno(9), IIf(vDatos_Retorno(14) <> 999 Or vDatos_Retorno(14) <> 998 Or vDatos_Retorno(14) <> 994, GLB_Formato_Dec_USD, GLB_Formato_Entero))
                     Valor_Estimado_3 = Valor_Estimado_3 + Format(vDatos_Retorno(10), IIf(vDatos_Retorno(14) <> 999 Or vDatos_Retorno(14) <> 998 Or vDatos_Retorno(14) <> 994, GLB_Formato_Dec_USD, GLB_Formato_Entero))
                     .TextMatrix(nIndice, 17) = Format(vDatos_Retorno(10), IIf(vDatos_Retorno(14) <> 999 Or vDatos_Retorno(14) <> 998 Or vDatos_Retorno(14) <> 994, GLB_Formato_Dec_USD, GLB_Formato_Entero))
                     Valor_Estimado_4 = Valor_Estimado_4 + Format(vDatos_Retorno(11), IIf(vDatos_Retorno(14) <> 999 Or vDatos_Retorno(14) <> 998 Or vDatos_Retorno(14) <> 994, GLB_Formato_Dec_USD, GLB_Formato_Entero))
                     .TextMatrix(nIndice, 18) = Format(vDatos_Retorno(11), IIf(vDatos_Retorno(14) <> 999 Or vDatos_Retorno(14) <> 998 Or vDatos_Retorno(14) <> 994, GLB_Formato_Dec_USD, GLB_Formato_Entero))
                     Total_op = Total_op + Format(vDatos_Retorno(6), IIf(vDatos_Retorno(14) <> 999 Or vDatos_Retorno(14) <> 998 Or vDatos_Retorno(14) <> 994, GLB_Formato_Dec_USD, GLB_Formato_Entero))
                     nMoneda = Format(CInt(vDatos_Retorno(14)), GLB_Formato_Entero)
                     .TextMatrix(nIndice, 19) = Format(CInt(vDatos_Retorno(13)), GLB_Formato_Entero)
                     .TextMatrix(nIndice, 20) = Format(CInt(vDatos_Retorno(12)), GLB_Formato_Entero)
                  Loop
                 
              End If
            
            End With
   
      
      FRM_ACT_BONOS.Tlb_Menu.Buttons(1).Enabled = False
      FRM_ACT_BONOS.Tlb_Menu.Buttons(2).Enabled = True
      FRM_ACT_BONOS.Tlb_Menu.Buttons(3).Enabled = True
      FRM_ACT_BONOS.Grd_Compra_Bonos.Enabled = True
      FRM_ACT_BONOS.FTB_VALOR_ESTIMADO1.CantidadDecimales = 4 'IIf(nMoneda <> 999 Or nMoneda <> 998 Or nMoneda <> 994, 2, 0)
      FRM_ACT_BONOS.FTB_VALOR_ESTIMADO2.CantidadDecimales = 0 'IIf(nMoneda <> 999 Or nMoneda <> 998 Or nMoneda <> 994, 2, 0)
      FRM_ACT_BONOS.FTB_VALOR_ESTIMADO3.CantidadDecimales = 4 'IIf(nMoneda <> 999 Or nMoneda <> 998 Or nMoneda <> 994, 2, 0)
      FRM_ACT_BONOS.FTB_VALOR_ESTIMADO4.CantidadDecimales = 0 'IIf(nMoneda <> 999 Or nMoneda <> 998 Or nMoneda <> 994, 2, 0)
      FRM_ACT_BONOS.Txt_Total_Operación = Format(Total_op, IIf(nMoneda = 13, GLB_Formato_Dec_USD, GLB_Formato_Entero))
      FRM_ACT_BONOS.FTB_VALOR_ESTIMADO1.Text = Format(Valor_Estimado_1, IIf(nMoneda <> 999 Or nMoneda <> 998 Or nMoneda <> 994, GLB_Formato_Dec_USD, GLB_Formato_Entero))
      FRM_ACT_BONOS.FTB_VALOR_ESTIMADO2.Text = Format(Valor_Estimado_2, IIf(nMoneda <> 999 Or nMoneda <> 998 Or nMoneda <> 994, GLB_Formato_Dec_USD, GLB_Formato_Entero))
      FRM_ACT_BONOS.FTB_VALOR_ESTIMADO3.Text = Format(Valor_Estimado_3, IIf(nMoneda <> 999 Or nMoneda <> 998 Or nMoneda <> 994, GLB_Formato_Dec_USD, GLB_Formato_Entero))
      FRM_ACT_BONOS.FTB_VALOR_ESTIMADO4.Text = Format(Valor_Estimado_4, IIf(nMoneda <> 999 Or nMoneda <> 998 Or nMoneda <> 994, GLB_Formato_Dec_USD, GLB_Formato_Entero))
      FRM_ACT_BONOS.FRM_VALOR_ESTIMADO.Enabled = True
      
      
   ElseIf Trim(cTipo_Producto) = "CORFO" Then
   
      Me.Hide
      FRM_ING_CORFO.Show
      FRM_ING_CORFO.txt_Numero_Operacion.Text = nNumero_Operacion

      With FRM_ING_CORFO
      
            GLB_Envia = Array()
             PROC_AGREGA_PARAMETRO GLB_Envia, Val(nNumero_Operacion)
            
            If Not FUNC_EXECUTA_COMANDO_SQL("SP_CON_RENOVACION_OPERACION", GLB_Envia) Then
            
               MsgBox "No fue posible leer información", vbOKOnly + vbCritical
               Exit Sub
               
            Else
            
              
               Do While FUNC_LEE_RETORNO_SQL(vDatos_Retorno())
               
                  .TXT_Instrumento.Text = Trim(vDatos_Retorno(3))
                  .TXT_Familia.Text = vDatos_Retorno(4)
                  .FTB_Rut.Text = vDatos_Retorno(5)
                  .TXT_Digito.Text = vDatos_Retorno(6)
                  .TXT_Nombre.Text = vDatos_Retorno(7)
                     
                  For nContador = 0 To .CMB_Moneda.ListCount - 1
                  
                     .CMB_Moneda.ListIndex = nContador
                     
                     If CDbl(.CMB_Moneda.ItemData(.CMB_Moneda.ListIndex)) = CDbl(vDatos_Retorno(8)) Then
                        
                        Exit For
                     
                     End If
                        
                  Next
                     
                  .FTB_Monto.Text = vDatos_Retorno(19)
                  .FTB_Tasa.Text = vDatos_Retorno(10)
                  .FTB_Spread.Text = vDatos_Retorno(11)
                  
                  For nContador = 0 To .CMB_Base.ListCount - 1
                  
                     .CMB_Base.ListIndex = nContador
                     
                     If CDbl(.CMB_Base.ItemData(.CMB_Base.ListIndex)) = CDbl(vDatos_Retorno(12)) Then
                        
                        Exit For
                     
                     End If
                        
                  Next
                  
                  For nContador = 0 To .CMB_Tipo_Tasa.ListCount - 1
                  
                     .CMB_Tipo_Tasa.ListIndex = nContador
                     
                     If CDbl(.CMB_Tipo_Tasa.ItemData(.CMB_Tipo_Tasa.ListIndex)) = CDbl(vDatos_Retorno(13)) Then
                        
                        Exit For
                     
                     End If
                        
                  Next
                  
                  .TXT_Fecha_Otor.Text = vDatos_Retorno(14)
                  .FTB_Total_Tasa.Text = CDbl(.FTB_Tasa.Text) + CDbl(.FTB_Spread.Text)
                  
                  For nContador = 0 To .CMB_Periodo.ListCount - 1
                  
                     .CMB_Periodo.ListIndex = nContador
                     
                     If CDbl(.CMB_Periodo.ItemData(.CMB_Periodo.ListIndex)) = CDbl(vDatos_Retorno(16)) Then
                        
                        Exit For
                     
                     End If
                        
                  Next
                  
                  .FTB_Cuotas.Text = vDatos_Retorno(17)
                  .TXT_Fecha_Ven.Text = vDatos_Retorno(15)
                  .TXT_Fecha_Cuota.Text = vDatos_Retorno(18)
                  .FTB_Gracia.Text = vDatos_Retorno(34)
                  .FTB_Decimales.Text = vDatos_Retorno(33)
                  .FTB_Acuerdo.Text = vDatos_Retorno(2)
                  
                  'EBQ - 20041028
                  '**************
                  .FRM_FECHAS.Enabled = False
                  .SCHK_Capitaliza.Value = vDatos_Retorno(36)
                  DoEvents
                  .TXT_Fecha_Capitaliza.Text = vDatos_Retorno(35)
                  DoEvents
                  '**************
                  
                  .FRM_Instrumento.Enabled = False
                  .FRM_Cliente.Enabled = False
                  .FRM_MONEDA.Enabled = False
                  .FRM_ACUERDO.Enabled = False
                  .FRM_CAPITALIZACION.Enabled = False
                  .TBL_MENU.Buttons(1).Enabled = False
                  .TBL_MENU.Buttons(2).Enabled = False
                  .TBL_MENU.Buttons(3).Enabled = True
                  
                  
                  GLB_cOptLocal = "Opcion_Menu_3201"
               Loop
        
         End If
      
      End With

   ElseIf Trim(cTipo_Producto) = "LOCAL" Then
   
      Me.Hide
      FRM_ING_BANCO_LOCAL.Show
      FRM_ING_BANCO_LOCAL.txt_Numero_Operacion.Text = nNumero_Operacion
   
      With FRM_ING_BANCO_LOCAL
      
            GLB_Envia = Array()
            PROC_AGREGA_PARAMETRO GLB_Envia, .txt_Numero_Operacion.Text
            
            If Not FUNC_EXECUTA_COMANDO_SQL("SP_CON_RENOVACION_OPERACION", GLB_Envia) Then
            
               MsgBox "No fue posible leer información", vbOKOnly + vbCritical
               Exit Sub
               
            Else
            
              
               Do While FUNC_LEE_RETORNO_SQL(vDatos_Retorno())
               
                  .TXT_Instrumento.Text = Trim(vDatos_Retorno(3))
                  .TXT_Familia.Text = vDatos_Retorno(4)
                  
                  For nContador = 0 To .CMB_Moneda.ListCount - 1
                  
                     .CMB_Moneda.ListIndex = nContador
                     
                     If CDbl(.CMB_Moneda.ItemData(.CMB_Moneda.ListIndex)) = CDbl(vDatos_Retorno(8)) Then
                        
                        Exit For
                     
                     End If
                        
                  Next
                     
                  .FTB_Monto.Text = vDatos_Retorno(19)
                  .FTB_Tasa.Text = vDatos_Retorno(10)
                  .FTB_Spread.Text = vDatos_Retorno(11)
                  
                  For nContador = 0 To .CMB_Base.ListCount - 1
                  
                     .CMB_Base.ListIndex = nContador
                     
                     If CDbl(.CMB_Base.ItemData(.CMB_Base.ListIndex)) = CDbl(vDatos_Retorno(12)) Then
                        
                        Exit For
                     
                     End If
                        
                  Next
                  
                  For nContador = 0 To .CMB_Tipo_Tasa.ListCount - 1
                  
                     .CMB_Tipo_Tasa.ListIndex = nContador
                     
                     If CDbl(.CMB_Tipo_Tasa.ItemData(.CMB_Tipo_Tasa.ListIndex)) = CDbl(vDatos_Retorno(13)) Then
                        
                        Exit For
                     
                     End If
                        
                  Next
                  
                  .TXT_Fecha_Otor.Text = vDatos_Retorno(14)
                  
                  For nContador = 0 To .CMB_Periodo.ListCount - 1
                  
                     .CMB_Periodo.ListIndex = nContador
                     
                     If CDbl(.CMB_Periodo.ItemData(.CMB_Periodo.ListIndex)) = CDbl(vDatos_Retorno(16)) Then
                        
                        Exit For
                     
                     End If
                        
                  Next
                  
                  .FTB_Cuotas.Text = vDatos_Retorno(17)
                  .TXT_Fecha_Ven.Text = vDatos_Retorno(15)
                  .FTB_Total_Tasa.Text = CDbl(.FTB_Tasa.Text) + CDbl(.FTB_Spread.Text)
                  
                  .TXT_Fecha_Cuota.Text = vDatos_Retorno(18)
                  .FTB_Decimales.Text = vDatos_Retorno(33)
                  .FTB_Gracia.Text = vDatos_Retorno(34)
                  .SCHK_Capitaliza.Value = 0
                  
                  'EBQ - 20041028
                  '**************
                  .FRM_FECHAS.Enabled = False
                  .SCHK_Capitaliza.Value = vDatos_Retorno(36)
                  DoEvents
                  .TXT_Fecha_Capitaliza.Text = vDatos_Retorno(35)
                  DoEvents
                  '**************
                  
                  .FRM_Instrumento.Enabled = False
                  .FRM_MONEDA.Enabled = False
                  .FRM_CAPITALIZACION.Enabled = False
                  .TBL_MENU.Buttons(1).Enabled = False
                  .TBL_MENU.Buttons(2).Enabled = False
                  .TBL_MENU.Buttons(3).Enabled = True
                  GLB_cOptLocal = "Opcion_Menu_3202"
               Loop
        
         End If
      
      End With
   
   ElseIf Trim(cTipo_Producto) = "EXTRA" Then
   
      Me.Hide
      FRM_ING_BANCO_EXT.Show
      FRM_ING_BANCO_EXT.txt_Numero_Operacion.Text = nNumero_Operacion
   
      With FRM_ING_BANCO_EXT
      
            GLB_Envia = Array()
            PROC_AGREGA_PARAMETRO GLB_Envia, .txt_Numero_Operacion.Text
            
            If Not FUNC_EXECUTA_COMANDO_SQL("SP_CON_RENOVACION_OPERACION", GLB_Envia) Then
            
               MsgBox "No fue posible leer información", vbOKOnly + vbCritical
               Exit Sub
               
            Else
            
              
               Do While FUNC_LEE_RETORNO_SQL(vDatos_Retorno())
               
                  .TXT_Instrumento.Text = Trim(vDatos_Retorno(3))
                  .TXT_Familia.Text = vDatos_Retorno(4)
                  
                  For nContador = 0 To .CMB_Moneda.ListCount - 1
                  
                     .CMB_Moneda.ListIndex = nContador
                     
                     If CDbl(.CMB_Moneda.ItemData(.CMB_Moneda.ListIndex)) = CDbl(vDatos_Retorno(8)) Then
                        
                        Exit For
                     
                     End If
                        
                  Next
                     
                  .FTB_Monto.Text = vDatos_Retorno(19)
                  .FTB_Tasa.Text = vDatos_Retorno(10)
                  .FTB_Spread.Text = vDatos_Retorno(11)
                  
                  For nContador = 0 To .CMB_Base.ListCount - 1
                  
                     .CMB_Base.ListIndex = nContador
                     
                     If CDbl(.CMB_Base.ItemData(.CMB_Base.ListIndex)) = CDbl(vDatos_Retorno(12)) Then
                        
                        Exit For
                     
                     End If
                        
                  Next
                  
                  For nContador = 0 To .CMB_Tipo_Tasa.ListCount - 1
                  
                     .CMB_Tipo_Tasa.ListIndex = nContador
                     
                     If CDbl(.CMB_Tipo_Tasa.ItemData(.CMB_Tipo_Tasa.ListIndex)) = CDbl(vDatos_Retorno(13)) Then
                        
                        Exit For
                     
                     End If
                        
                  Next
                  
                  .TXT_Fecha_Otor.Text = vDatos_Retorno(14)
                  
                  For nContador = 0 To .CMB_Periodo.ListCount - 1
                  
                     .CMB_Periodo.ListIndex = nContador
                     
                     If CDbl(.CMB_Periodo.ItemData(.CMB_Periodo.ListIndex)) = CDbl(vDatos_Retorno(16)) Then
                        
                        Exit For
                     
                     End If
                        
                  Next
                  
                  .FTB_Cuotas.Text = vDatos_Retorno(17)
                  .TXT_Fecha_Ven.Text = vDatos_Retorno(15)
                  .FTB_Total_Tasa.Text = CDbl(.FTB_Tasa.Text) + CDbl(.FTB_Spread.Text)
                  .TXT_Fecha_Cuota.Text = vDatos_Retorno(18)
                  .FTB_Decimales.Text = vDatos_Retorno(33)
                  
                  .FRM_Instrumento.Enabled = False
                  .FRM_MONEDA.Enabled = False
                  .FRM_FECHAS.Enabled = False
                        'EBQ - 20041028
                  '**************
                  .SCHK_Capitaliza.Value = vDatos_Retorno(36)
                   DoEvents
                  .TXT_Fecha_Capitaliza.Text = vDatos_Retorno(35)
                   DoEvents
                  '**************
                  
                  .FRM_CAPITALIZACION.Enabled = False
                  
                  .TBL_MENU.Buttons(1).Enabled = False
                  .TBL_MENU.Buttons(2).Enabled = False
                  .TBL_MENU.Buttons(3).Enabled = True
                  GLB_cOptLocal = "Opcion_Menu_3203"
               Loop
            
         End If
      
      End With
   
   End If

End Sub


