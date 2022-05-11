VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "threed32.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form Contabilizacion_Automatica 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Contabilización Automática"
   ClientHeight    =   2775
   ClientLeft      =   1875
   ClientTop       =   3015
   ClientWidth     =   5700
   Icon            =   "Con_auto.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   2775
   ScaleWidth      =   5700
   ShowInTaskbar   =   0   'False
   Begin MSComctlLib.ListView Lista_Res_Cont 
      Height          =   1695
      Left            =   0
      TabIndex        =   5
      Top             =   1080
      Width           =   5655
      _ExtentX        =   9975
      _ExtentY        =   2990
      View            =   3
      LabelEdit       =   1
      LabelWrap       =   -1  'True
      HideSelection   =   -1  'True
      FullRowSelect   =   -1  'True
      _Version        =   393217
      ForeColor       =   -2147483646
      BackColor       =   -2147483643
      BorderStyle     =   1
      Appearance      =   1
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      NumItems        =   0
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   1
      Top             =   0
      Width           =   5700
      _ExtentX        =   10054
      _ExtentY        =   794
      ButtonWidth     =   820
      ButtonHeight    =   794
      Style           =   1
      ImageList       =   "Img_opciones"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbcontab"
            Description     =   "CONTABILIZAR"
            Object.ToolTipText     =   "Contabilizar"
            ImageIndex      =   11
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Description     =   "ERRORES"
            Object.ToolTipText     =   "Errores"
            ImageIndex      =   18
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbsalir"
            Description     =   "SALIR"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      Begin MSComctlLib.ImageList Img_opciones 
         Left            =   3960
         Top             =   -90
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
               Picture         =   "Con_auto.frx":74F2
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Con_auto.frx":7959
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Con_auto.frx":7E4F
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Con_auto.frx":82E2
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Con_auto.frx":87CA
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Con_auto.frx":8CDD
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Con_auto.frx":921A
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Con_auto.frx":965C
               Key             =   ""
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Con_auto.frx":9B16
               Key             =   ""
            EndProperty
            BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Con_auto.frx":9FE9
               Key             =   ""
            EndProperty
            BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Con_auto.frx":A42D
               Key             =   ""
            EndProperty
            BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Con_auto.frx":A994
               Key             =   ""
            EndProperty
            BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Con_auto.frx":AE63
               Key             =   ""
            EndProperty
            BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Con_auto.frx":B282
               Key             =   ""
            EndProperty
            BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Con_auto.frx":B77A
               Key             =   ""
            EndProperty
            BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Con_auto.frx":BB73
               Key             =   ""
            EndProperty
            BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Con_auto.frx":BFF6
               Key             =   ""
            EndProperty
            BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Con_auto.frx":C4BC
               Key             =   ""
            EndProperty
            BeginProperty ListImage19 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Con_auto.frx":C9B3
               Key             =   ""
            EndProperty
            BeginProperty ListImage20 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Con_auto.frx":CE69
               Key             =   ""
            EndProperty
            BeginProperty ListImage21 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Con_auto.frx":D22E
               Key             =   ""
            EndProperty
            BeginProperty ListImage22 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Con_auto.frx":D624
               Key             =   ""
            EndProperty
            BeginProperty ListImage23 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Con_auto.frx":DA1B
               Key             =   ""
            EndProperty
            BeginProperty ListImage24 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Con_auto.frx":DE24
               Key             =   ""
            EndProperty
            BeginProperty ListImage25 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Con_auto.frx":E2E2
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin Threed.SSPanel SSPanel5 
      Height          =   555
      Left            =   0
      TabIndex        =   0
      Top             =   480
      Width           =   5655
      _Version        =   65536
      _ExtentX        =   9975
      _ExtentY        =   979
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
      BevelOuter      =   0
      Begin MSComctlLib.ProgressBar Barra 
         DragMode        =   1  'Automatic
         Height          =   360
         Left            =   0
         TabIndex        =   4
         Top             =   120
         Width           =   5655
         _ExtentX        =   9975
         _ExtentY        =   635
         _Version        =   393216
         Appearance      =   1
         Min             =   1
         Max             =   1000
         Scrolling       =   1
      End
   End
   Begin Threed.SSCommand Cmd_Aceptar 
      Height          =   450
      Left            =   60
      TabIndex        =   2
      Top             =   2805
      Width           =   1200
      _Version        =   65536
      _ExtentX        =   2117
      _ExtentY        =   794
      _StockProps     =   78
      Caption         =   "&Contabilizar"
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   3
   End
   Begin Threed.SSCommand Cmd_Cancelar 
      Height          =   450
      Left            =   1290
      TabIndex        =   3
      Top             =   2805
      Width           =   1200
      _Version        =   65536
      _ExtentX        =   2117
      _ExtentY        =   794
      _StockProps     =   78
      Caption         =   "&Salir"
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   3
   End
End
Attribute VB_Name = "Contabilizacion_Automatica"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim gsBac_FM             As Date
Dim cOptLocal As String

Sub PROC_CONTABILIZA()
Dim Datos()
Dim Comando$
Dim Resultado As String

Screen.MousePointer = 11
Resultado = ""

Lista_Res_Cont.ListItems.Clear
Lista_Res_Cont.ColumnHeaders.Clear
Lista_Res_Cont.ColumnHeaders.Add 1, , "Eventos Proceso Contable", 5000
Lista_Res_Cont.Sorted = False
Lista_Res_Cont.AllowColumnReorder = False
Lista_Res_Cont.ListItems.Add , , "Inicio Proceso Contable..."

Barra.Visible = True

Barra = 100
''Lbl_Msg.Caption = "Contabilizando..."
'Lbl_Msg.Refresh

Envia = Array(Format(GLB_Fecha_Proceso, "yyyymmdd"))

If Procesa_Contabilidad() Then
   If Not FUNC_EXECUTA_COMANDO_SQL("Sp_Contabilizacion", Envia) Then
      Lista_Res_Cont.ListItems.Add , , "Proceso Contable NO Realizado"
      Screen.MousePointer = 0
      Call PROC_LOG_AUDITORIA("19", "Opcion_Menu_6500", Me.Caption & "(Proceso no realizado) &  Fecha : " & GLB_Fecha_Proceso, "", "")
      Exit Sub
   End If

   Barra = 700
   
   Do While FUNC_LEE_RETORNO_SQL(Datos())
      If Datos(1) <> "SI" Then
         Resultado = "NO"
         Screen.MousePointer = 0
      End If
   Loop

   If Resultado = "NO" Then
      Me.Toolbar1.Buttons(3).Enabled = True
      Lista_Res_Cont.ListItems.Add , , "Proceso Contable NO Realizado"
      Envia = Array(Format(gsBac_Fecp, "yyyymmdd"))

      If Not FUNC_EXECUTA_COMANDO_SQL("sp_cons_error_contable") Then
         Lista_Res_Cont.ListItems.Add , , "Error de Parametria"
         Screen.MousePointer = 0
         Exit Sub
      End If

      Do While FUNC_LEE_RETORNO_SQL(Datos())
         Lista_Res_Cont.ListItems.Add , , Datos(3)
      Loop
      
      Lista_Res_Cont.ListItems.Add , , "Favor de Imprimir Reporte de Errores"
      
     Call PROC_LOG_AUDITORIA("19", "Opcion_Menu_6500", Me.Caption & "(Proceso no realizado) &  Fecha : " & GLB_Fecha_Proceso, "", "")
   Else
      Lista_Res_Cont.ListItems.Add , , "Proceso Contable Terminado Correctamente."
      Call Grabar_Estado("PSV", "CONTABILIDAD", 1, True)
      Call PROC_LOG_AUDITORIA("19", "Opcion_Menu_6500", Me.Caption & "(Proceso realizado) &  Fecha : " & GLB_Fecha_Proceso, "", "")
   End If

   Valor_antiguo = " "
   Valor_antiguo = "Fecha de Contabilización =" & gsBac_Fecp
    
   'Call GRABA_LOG_AUDITORIA(1, gsBac_Fecp, gsBac_Term, gsBac_User, _
   '"BTR", "Opc_40100", "01", "Contabilidad", "bac_cnt_contabiliza", Valor_antiguo, " ")

Else
    Lista_Res_Cont.ListItems.Add , , "Proceso Contable NO Realizado"
    Call PROC_LOG_AUDITORIA("19", "Opcion_Menu_6500", Me.Caption & "(Proceso no realizado) &  Fecha : " & GLB_Fecha_Proceso, "", "")
End If


Screen.MousePointer = 0
   

End Sub

Private Sub Cmd_Aceptar_Click()

'If MsgBox("Seguro de Contabilizar ?", 36, gsBac_Version) <> 6 Then Exit Sub
'
'PROC_CONTABILIZA

End Sub


Private Sub Cmd_Cancelar_Click()

'Unload Me

End Sub
Sub Trampa()
Dim I%, ii%, iii%

   Screen.MousePointer = 11
   Lbl_Msg.Caption = "Contabilizando..."
   'BacControlWindows 100
   Lbl_Msg.Refresh
   Barra.Visible = True
   For I% = 1 To 10000
      For ii% = 1 To 1000
         If I = 7000 Then
            For iii% = 0 To 10000
               
            Next iii%
            'i% = 9000
         End If
      Next ii%
   Barra.Value = I
   Next I

   Lbl_Msg.Caption = "Perfil contable no definidos" & Chr(10) _
   & "Contabilización no Terminada..."
   Barra.Visible = False
   Screen.MousePointer = 0
End Sub

Private Sub Form_Activate()
Dim Datos()

Me.Icon = FRM_MDI_PASIVO.Icon

'    gsBac_FM = CDate("01/" + Str(Month(gsBac_Fecp)) + "/" + Str(Year(gsBac_Fecp)))
    gsBac_FM = CDate("01/" + Str(Month(GLB_Fecha_Proceso)) + "/" + Str(Year(GLB_Fecha_Proceso)))
    gsBac_FM = DateAdd("m", 1, gsBac_FM)
    gsBac_FM = DateAdd("d", -1, gsBac_FM)
    

If mvarFinMesEspecial = True Then
   GLB_Envia = Array("PSV")
    If FUNC_EXECUTA_COMANDO_SQL("SP_CON_ESTADO_SWITCH", GLB_Envia) Then
        Do While FUNC_LEE_RETORNO_SQL(Datos())
           If Datos(5) = 0 And Datos(6) = "DEVENGAMIENTO" Then
              'MsgBox "Fin de mes Especial Debe devengar antes de Contabilizar", vbCritical
              MsgBox "Fin de mes Especial recuerde devengar y Contabilizar nuevamente", vbExclamation
          End If
        Loop
    End If
End If
'If gsBac_Fecp <> gsBac_FM And gsBac_Fecx > gsBac_FM Then
'
' If FUNC_EXECUTA_COMANDO_SQL("sp_chkfechasdevengamiento") Then
'        Do While FUNC_LEE_RETORNO_SQL(Datos())
'            swDevengo = Datos(7)
'            'If Datos(7) <> "1" Or Datos(8) <> "1" Or Datos(9) <> "1" Or Datos(10) <> "1" Then
'            If Datos(1) <> Datos(3) Then  'Or Datos(10) <> "1"
'                MsgBox "Fin de mes Especial Debe devengar antes de Contabilizar", vbCritical
'                Unload Me
'            End If
'        Loop
' End If
'End If

End Sub

Private Sub Form_Load()
    cOptLocal = GLB_Opcion_Menu
    Call PROC_LOG_AUDITORIA("07", "Opcion_Menu_6500", Me.Caption & " Fecha : " & GLB_Fecha_Proceso, "", "")
    Me.Toolbar1.Buttons(3).Enabled = False
End Sub

Private Sub Form_Unload(Cancel As Integer)
Call PROC_LOG_AUDITORIA("08", cOptLocal, Me.Caption & " Fecha : " & GLB_Fecha_Proceso, "", "")
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

Select Case UCase(Button.Description)
    Case "CONTABILIZAR"
        If MsgBox("Seguro de Contabilizar ?", 36, gsBac_Version) <> 6 Then Exit Sub
        Me.Toolbar1.Buttons(3).Enabled = False
        Call PROC_CONTABILIZA
        
        Lista_Res_Cont.ListItems.Add , , "Se Generara Interfaz Contable"
        Barra = 800
        Call Interfaz_PSV
        Barra = 1000
        Lista_Res_Cont.ListItems.Add , , "Interfaz Contable Generada"
        Call PROC_LOG_AUDITORIA("18", "Opcion_Menu_6500", Me.Caption & "(Interfaz Contable Generada) &  Fecha : " & GLB_Fecha_Proceso, "", "")
        '/* Genera proceso automatico de Autobalance
        '------------------------------------------- */
        'Frm_Gatilla_Crstckt_Autobalance.lProcesa_Automatico = True
        'Frm_Gatilla_Crstckt_Autobalance.Show
    Case "ERRORES"
               FRM_MDI_PASIVO.Pasivo_Rpt.Destination = 0
               Call PROC_LIMPIAR_CRISTAL
               FRM_MDI_PASIVO.Pasivo_Rpt.ReportFileName = GLB_Ubicacion_Reporte & "Rpt_consulta_error_CNT.rpt"
               PROC_ESTABLECE_UBICACION FRM_MDI_PASIVO.Pasivo_Rpt.RetrieveDataFiles, FRM_MDI_PASIVO.Pasivo_Rpt
               FRM_MDI_PASIVO.Pasivo_Rpt.Connect = GLB_CONECCION
               FRM_MDI_PASIVO.Pasivo_Rpt.Action = 1
            
    Case "SALIR"
        Unload Me
End Select
End Sub

Function Procesa_Contabilidad(Optional nTipo As Integer) As Boolean

   Dim Datos()
   Dim I          As Integer
   Dim X          As Integer
   Dim Sw         As Integer
   Dim sMensaje   As String
   Dim Sistema_Padre As String
   
   If FUNC_EXECUTA_COMANDO_SQL("sp_chkfechasdevengamiento") Then
      Do While FUNC_LEE_RETORNO_SQL(Datos())
         Fecha_Proceso = Datos(1)
         Fecha_Proximo_Proceso = Datos(2)
         Fecha_Cierre_Mes = Datos(3)
         valPCDUSD = Datos(4)
         valPCDUF = Datos(5)
         valPTF = Datos(6)
         Fecha_Anterior = Datos(8)
        
      Loop

   End If

   'If Fecha_Cierre_Mes > Fecha_proc.Text And Fecha_Cierre_Mes < Fecha_Proximo_Proceso Then
   'If Fecha_Cierre_Mes > Fecha_Proceso And Fecha_Cierre_Mes < Fecha_Proximo_Proceso Then
   If mvarFinMesEspecial = True Then
      Fecha_Cierre_Mes = Fecha_Cierre_Mes 'Fecha_Proceso
   Else
      Fecha_Cierre_Mes = Fecha_Proceso 'Fecha_Anterior
   End If

   Procesa_Contabilidad = False
'   If nTipo = 0 Then
'        ProcesandoContabilidad.Max = LST_Productos.ListCount - 1
'   Else
'        Procesando_Saldos.Max = LST_Productos.ListCount - 1
'   End If
   Sw = 1

'   For I = 0 To LST_Productos.ListCount - 1
'      LST_Productos.ListIndex = I
'
'      For X = 1 To TreeProcesos.Nodes.Count
'         If Trim(TreeProcesos.Nodes.Item(X).Key) = "" Then
'            Sistema_Padre = TreeProcesos.Nodes.Item(X).Parent.Key
'         Else
'            Sistema_Padre = TreeProcesos.Nodes.Item(X).Key
'         End If
'         If Trim(TreeProcesos.Nodes.Item(X).Text) = Trim(Trim(Mid(LST_Productos.Text, 50, 50))) And _
'            TreeProcesos.Nodes.Item(X).Checked = True And _
'            Trim(right(LST_Productos.Text, 3)) = Sistema_Padre Then
            
'            If nTipo = 0 Then

        If mvarFinMesEspecial = True Then
                Envia = Array()
                AddParam Envia, Fecha_Cierre_Mes 'Fecha_proc.Text
                AddParam Envia, GLB_Fecha_Anterior
                AddParam Envia, IIf(Month(Fecha_Proceso) <> Month(Fecha_Proximo_Proceso), Fecha_Cierre_Mes, Fecha_Proceso)
                AddParam Envia, "'PSV'" ' Trim(right(LST_Productos.Text, 50))
                AddParam Envia, "''" ' Trim(left(LST_Productos.Text, 5))
                AddParam Envia, Sw
        
        Else
                Envia = Array()
                AddParam Envia, GLB_Fecha_Proceso 'Fecha_proc.Text
                AddParam Envia, GLB_Fecha_Anterior
                AddParam Envia, IIf(Month(Fecha_Proceso) <> Month(Fecha_Proximo_Proceso), Fecha_Cierre_Mes, Fecha_Proceso)
                AddParam Envia, "'PSV'" ' Trim(right(LST_Productos.Text, 50))
                AddParam Envia, "''" ' Trim(left(LST_Productos.Text, 5))
                AddParam Envia, Sw
        End If
    
        If Not FUNC_EXECUTA_COMANDO_SQL("Sp_Llena_Contabiliza", Envia) Then
                Exit Function
        Else
            Lista_Res_Cont.ListItems.Add , , "Llenado Datos Procesado "
            Barra = 300
       
        End If
    

   Procesa_Contabilidad = True

End Function


Function Interfaz_PSV()
Dim Texto As String
Dim Datos()
Dim Ejecuta As String
Dim Largo As Integer
Dim Archivo As String
Dim Archivo1 As String
Dim cDia    As String

On Error GoTo Error_Interfaz
   
cDia = Format(GLB_Fecha_Proceso, "yymmdd")

Archivo = LTrim(RTrim(GLB_Ruta_Int_Contable)) + "GL50" + cDia + ".Dat"

If Dir(Archivo) <> "" Then
   Kill (Archivo)
End If

 Ejecuta = "Sp_interfaz_Contable_PSV " & Format(GLB_Fecha_Proceso, "YYYYMMDD")


Open Archivo For Binary Access Write As #1
   
If FUNC_EXECUTA_COMANDO_SQL(Ejecuta) Then
    Do While FUNC_LEE_RETORNO_SQL(Datos())
        Texto = Trim(Datos(1)) & Chr(13) & Chr(10)
        Put #1, , Texto
        
    Loop
End If

Close #1
Exit Function

Error_Interfaz:
MsgBox "Problemas en generaciòn de interfaz"

End Function
