VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.2#0"; "mscomctl.ocx"
Begin VB.Form FRM_PRO_DEVENGO 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Form1"
   ClientHeight    =   5280
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   5370
   Icon            =   "FRM_PRO_DEVENGO.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5280
   ScaleWidth      =   5370
   Begin Threed.SSFrame SSF_Fechas 
      Height          =   1290
      Left            =   30
      TabIndex        =   7
      Top             =   510
      Width           =   5340
      _Version        =   65536
      _ExtentX        =   9419
      _ExtentY        =   2275
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
      Begin VB.TextBox TXT_Fecha_FinMes 
         Alignment       =   1  'Right Justify
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
         Left            =   2445
         TabIndex        =   13
         Top             =   900
         Width           =   1695
      End
      Begin VB.TextBox TXT_Fecha_Proximo 
         Alignment       =   1  'Right Justify
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
         Left            =   2445
         TabIndex        =   11
         Top             =   555
         Width           =   1695
      End
      Begin VB.TextBox TXT_Fecha_Proceso 
         Alignment       =   1  'Right Justify
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
         Left            =   2445
         TabIndex        =   9
         Top             =   210
         Width           =   1695
      End
      Begin VB.Label LBL_Fecha_Fmes 
         Caption         =   "Fecha Cierre de Mes"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   240
         Left            =   165
         TabIndex        =   12
         Top             =   960
         Width           =   2145
      End
      Begin VB.Label LBL_Fecha_Hasta 
         Caption         =   "Fecha Proximo proceso"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   240
         Left            =   180
         TabIndex        =   10
         Top             =   600
         Width           =   2055
      End
      Begin VB.Label LBL_Fecha_Desde 
         Caption         =   "Fecha Proceso"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   240
         Left            =   180
         TabIndex        =   8
         Top             =   225
         Width           =   1980
      End
   End
   Begin Threed.SSFrame SSF_Opciones 
      Height          =   1020
      Left            =   0
      TabIndex        =   3
      Top             =   1800
      Width           =   5355
      _Version        =   65536
      _ExtentX        =   9446
      _ExtentY        =   1799
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
      Begin Threed.SSCheck SCK_Local 
         Height          =   240
         Left            =   105
         TabIndex        =   6
         Top             =   645
         Width           =   2415
         _Version        =   65536
         _ExtentX        =   4260
         _ExtentY        =   423
         _StockProps     =   78
         Caption         =   "Crédito Locales"
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.24
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin Threed.SSCheck SCK_Corfo 
         Height          =   270
         Left            =   2925
         TabIndex        =   5
         Top             =   240
         Width           =   1905
         _Version        =   65536
         _ExtentX        =   3360
         _ExtentY        =   476
         _StockProps     =   78
         Caption         =   "Crédito Corfo"
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
      Begin Threed.SSCheck SCK_Bonos 
         Height          =   285
         Left            =   105
         TabIndex        =   4
         Top             =   240
         Width           =   2430
         _Version        =   65536
         _ExtentX        =   4286
         _ExtentY        =   503
         _StockProps     =   78
         Caption         =   "Bonos de Propia Emisión"
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
      Begin Threed.SSCheck SCK_Extra 
         Height          =   270
         Left            =   2925
         TabIndex        =   14
         Top             =   600
         Width           =   1905
         _Version        =   65536
         _ExtentX        =   3360
         _ExtentY        =   476
         _StockProps     =   78
         Caption         =   "Crédito Extra"
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
   Begin MSComctlLib.Toolbar TLB_Menu 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   5370
      _ExtentX        =   9472
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
            Key             =   "Procesar"
            Object.ToolTipText     =   "Procesar"
            ImageIndex      =   14
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      Begin MSComctlLib.ImageList Img_opciones 
         Left            =   3840
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
               Picture         =   "FRM_PRO_DEVENGO.frx":000C
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRO_DEVENGO.frx":0473
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRO_DEVENGO.frx":0969
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRO_DEVENGO.frx":0DFC
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRO_DEVENGO.frx":12E4
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRO_DEVENGO.frx":17F7
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRO_DEVENGO.frx":1D34
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRO_DEVENGO.frx":2176
               Key             =   ""
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRO_DEVENGO.frx":2630
               Key             =   ""
            EndProperty
            BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRO_DEVENGO.frx":2B03
               Key             =   ""
            EndProperty
            BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRO_DEVENGO.frx":2F47
               Key             =   ""
            EndProperty
            BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRO_DEVENGO.frx":34AE
               Key             =   ""
            EndProperty
            BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRO_DEVENGO.frx":397D
               Key             =   ""
            EndProperty
            BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRO_DEVENGO.frx":3D9C
               Key             =   ""
            EndProperty
            BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRO_DEVENGO.frx":4294
               Key             =   ""
            EndProperty
            BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRO_DEVENGO.frx":468D
               Key             =   ""
            EndProperty
            BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRO_DEVENGO.frx":4B10
               Key             =   ""
            EndProperty
            BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRO_DEVENGO.frx":4FD6
               Key             =   ""
            EndProperty
            BeginProperty ListImage19 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRO_DEVENGO.frx":54CD
               Key             =   ""
            EndProperty
            BeginProperty ListImage20 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRO_DEVENGO.frx":5983
               Key             =   ""
            EndProperty
            BeginProperty ListImage21 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRO_DEVENGO.frx":5D48
               Key             =   ""
            EndProperty
            BeginProperty ListImage22 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRO_DEVENGO.frx":613E
               Key             =   ""
            EndProperty
            BeginProperty ListImage23 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRO_DEVENGO.frx":6535
               Key             =   ""
            EndProperty
            BeginProperty ListImage24 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRO_DEVENGO.frx":693E
               Key             =   ""
            EndProperty
            BeginProperty ListImage25 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_PRO_DEVENGO.frx":6DFC
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin Threed.SSFrame SSF_frame 
      Height          =   2445
      Left            =   0
      TabIndex        =   1
      Top             =   2820
      Width           =   5355
      _Version        =   65536
      _ExtentX        =   9446
      _ExtentY        =   4313
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
      Begin VB.ListBox LST_PROCESO 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   2160
         Left            =   90
         TabIndex        =   2
         Top             =   195
         Width           =   5175
      End
   End
End
Attribute VB_Name = "FRM_PRO_DEVENGO"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim Fecha_Cierre_Mes
Dim Fecha_Proximo_Dev As Date
Private Function FUNC_TASAS_PROMEDIO(dFecha_Proceso As Date, dfecha_Anterior)
Dim nDias As Integer
Dim nContador As Integer
Dim Fecha_Busqueda As Date
Dim vDatos_Retorno()
Dim cMensaje As String
Dim cTipoOperacion As String

FUNC_TASAS_PROMEDIO = False

nDias = DateDiff("D", dfecha_Anterior, dFecha_Proceso)
nContador = 1
Fecha_Busqueda = dFecha_Proceso
cTipoOperacion = "N"

If nDias > 1 Then
    Fecha_Busqueda = DateAdd("D", 1, dfecha_Anterior)
    cTipoOperacion = "S"
End If

Do While nContador < nDias - 1 Or nDias - 1 = nContador Or nContador = 1
    If nDias = nContador Then
        cTipoOperacion = "N"
    End If
    
    GLB_Envia = Array()
    PROC_AGREGA_PARAMETRO GLB_Envia, Format(Fecha_Busqueda, "YYYYMMDD")
    PROC_AGREGA_PARAMETRO GLB_Envia, cTipoOperacion
    
    If Not FUNC_EXECUTA_COMANDO_SQL("SP_PRO_TASA_PROMEDIO", GLB_Envia) Then
        Call PROC_Mensaje(".........Problemas al Generar Tasas Promedio")
    Else
        If FUNC_LEE_RETORNO_SQL(vDatos_Retorno()) Then
            If vDatos_Retorno(1) = -1 Then
                cMensaje = vDatos_Retorno(2)
                Call PROC_Mensaje(cMensaje)
            Else
                Call PROC_Mensaje(".........Término exitoso de Tasas promedio")
            End If
        End If
    End If

Fecha_Busqueda = Fecha_Busqueda + 1
nContador = nContador + 1
Loop
FUNC_TASAS_PROMEDIO = True
End Function

Private Sub Form_Activate()
PROC_CARGA_AYUDA Me
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
Dim nOpcion As Integer
  
   nOpcion = 0
  
    If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) Then
   
      Select Case KeyCode
      
         Case VbKeyProcesar:
                           nOpcion = 1
         Case vbKeySalir:
                           nOpcion = 2
      
      End Select
      
      If nOpcion <> 0 Then
         KeyCode = 0
         If TLB_Menu.Buttons(nOpcion).Enabled Then
            Call TLB_Menu_ButtonClick(TLB_Menu.Buttons(nOpcion))
         End If
      End If
   
   End If
End Sub

Private Sub Form_Load()
Me.top = 1150
Me.left = 30
Me.Caption = "Devengamiento"
Me.Icon = FRM_MDI_PASIVO.Icon

SCK_Bonos.Value = True
SCK_Corfo.Value = True
SCK_Local.Value = True
SCK_Extra.Value = True

Me.TXT_Fecha_Proceso.Text = GLB_Fecha_Proceso
Me.TXT_Fecha_Proximo.Text = GLB_Fecha_Proxima
Me.TXT_Fecha_FinMes.Text = GLB_Fecha_FinMes

Me.TXT_Fecha_Proceso.Enabled = False
Me.TXT_Fecha_Proximo.Enabled = False
Me.TXT_Fecha_FinMes.Enabled = False

Call PROC_LOG_AUDITORIA("07", "Opcion_Menu_6300", Me.Caption & " Fecha : " & GLB_Fecha_Proceso, "", "")
End Sub


Private Sub Form_Unload(Cancel As Integer)
Call PROC_LOG_AUDITORIA("08", "Opcion_Menu_6300", Me.Caption & " Fecha : " & GLB_Fecha_Proceso, "", "")
End Sub

Private Sub TLB_Menu_ButtonClick(ByVal Button As MSComctlLib.Button)
      
      Select Case Button.Index
         Case 1:
            Dim Datos()
            GLB_Envia = Array("PSV")

            If FUNC_EXECUTA_COMANDO_SQL("SP_CON_ESTADO_SWITCH", GLB_Envia) Then
                Do While FUNC_LEE_RETORNO_SQL(Datos())
                    If Datos(5) = 0 And Datos(6) = "MESA" Then
                        MsgBox "Mesa esta desbloqueada", vbExclamation
                        Screen.MousePointer = 0
                        Exit Sub
                    End If

                    If mvarFinMesEspecial = False Then
                        If Datos(5) = 0 And Datos(6) = "CONTABILIDAD" Then
                            MsgBox "Proceso contable no ha sido realizado", vbExclamation
                            Screen.MousePointer = 0
                            Exit Sub
                        End If
                    End If
                   
                Loop

                If Not FUNC_DEVENGAR Then
                   MsgBox ("Problemas al realizar devengamiento"), vbCritical + vbInformation
                   Call Grabar_Estado("PSV", "DEVENGAMIENTO", 0, True)
                   Call PROC_LOG_AUDITORIA("19", "Opcion_Menu_6300", Me.Caption & " (proceso no realizado) Fecha : " & GLB_Fecha_Proceso, "", "")
                Else
                   MsgBox ("Devengamiento realizado con éxito"), vbInformation
                   Call Grabar_Estado("PSV", "DEVENGAMIENTO", 1, True)
                   Call PROC_LOG_AUDITORIA("19", "Opcion_Menu_6300", Me.Caption & " (proceso realizado) Fecha : " & GLB_Fecha_Proceso, "", "")
                End If
                Screen.MousePointer = 0
                Exit Sub
            End If
         Case 2:
               Unload Me
               
      End Select

End Sub

Private Sub PROC_Mensaje(sMensaje As String)

   LST_PROCESO.AddItem sMensaje

End Sub

Private Function FUNC_DEVENGAR()
Dim cMensaje As String
Dim vDatos_Retorno()
On Error GoTo Error_dev
Dim cMensaje_Estado As String

FUNC_DEVENGAR = False
LST_PROCESO.Clear

Screen.MousePointer = 11

If Not FUNC_EXECUTA_COMANDO_SQL("BEGIN TRANSACTION") Then
           Exit Function
End If

If mvarFinMesEspecial = True Then
   Fecha_Proximo_Dev = TXT_Fecha_FinMes.Text
Else
   Fecha_Proximo_Dev = TXT_Fecha_Proximo.Text
End If

If SCK_Corfo.Value = True Then
    GLB_Envia = Array()
    PROC_AGREGA_PARAMETRO GLB_Envia, Format(GLB_Fecha_Proceso, "YYYYMMDD")
    PROC_AGREGA_PARAMETRO GLB_Envia, Format(Fecha_Proximo_Dev, "YYYYMMDD")
    PROC_AGREGA_PARAMETRO GLB_Envia, "CORFO"
    PROC_AGREGA_PARAMETRO GLB_Envia, "N"
    
    If Not FUNC_EXECUTA_COMANDO_SQL("SP_DEVENGO_CREDITOS", GLB_Envia) Then
        Call PROC_Mensaje(".........Problemas al devengar Créditos Corfo, ERROR.")
        GoTo Error_dev
    Else
    
        GLB_Envia = Array()
        If Not FUNC_EXECUTA_COMANDO_SQL("SP_CON_LEER_TABLA_DEV", GLB_Envia) Then
            Call PROC_Mensaje(".........Problemas al devengar Créditos Corfo, ERROR.")
            GoTo Error_dev
        End If
        
        If FUNC_LEE_RETORNO_SQL(vDatos_Retorno()) Then
            If vDatos_Retorno(1) = "NO" Then
                cMensaje = vDatos_Retorno(2)
                Call PROC_Mensaje(cMensaje)
                GoTo Error_dev
            Else
                Call PROC_Mensaje(".........Término de Devengo de Créditos Corfo, OK.")
            End If
        End If
    End If
    
    
    GLB_Envia = Array()
    PROC_AGREGA_PARAMETRO GLB_Envia, Format(GLB_Fecha_Proceso, "YYYYMMDD")
    PROC_AGREGA_PARAMETRO GLB_Envia, Format(Fecha_Proximo_Dev, "YYYYMMDD")
    PROC_AGREGA_PARAMETRO GLB_Envia, "CORFO"
    PROC_AGREGA_PARAMETRO GLB_Envia, "S"
    
    If Not FUNC_EXECUTA_COMANDO_SQL("SP_DEVENGO_CREDITOS", GLB_Envia) Then
        Call PROC_Mensaje(".........Problemas al devengar Créditos Corfo en MX, ERROR.")
        GoTo Error_dev
    Else
    
        GLB_Envia = Array()
        If Not FUNC_EXECUTA_COMANDO_SQL("SP_CON_LEER_TABLA_DEV", GLB_Envia) Then
            Call PROC_Mensaje(".........Problemas al devengar Créditos Corfo en MX, ERROR.")
            GoTo Error_dev
        End If
        
        If FUNC_LEE_RETORNO_SQL(vDatos_Retorno()) Then
            If vDatos_Retorno(1) = "NO" Then
                cMensaje = vDatos_Retorno(2)
                Call PROC_Mensaje(cMensaje)
                GoTo Error_dev
            Else
                Call PROC_Mensaje(".........Término de Devengo de Créditos Corfo en MX, OK.")
            End If
        End If
    End If
    
    
    
End If

If SCK_Local.Value = True Then
    GLB_Envia = Array()
    PROC_AGREGA_PARAMETRO GLB_Envia, Format(GLB_Fecha_Proceso, "YYYYMMDD")
    PROC_AGREGA_PARAMETRO GLB_Envia, Format(Fecha_Proximo_Dev, "YYYYMMDD")
    PROC_AGREGA_PARAMETRO GLB_Envia, "LOCAL"
    PROC_AGREGA_PARAMETRO GLB_Envia, "N"

    If Not FUNC_EXECUTA_COMANDO_SQL("SP_DEVENGO_CREDITOS", GLB_Envia) Then
        Call PROC_Mensaje(".........Problemas al devengar Créditos Locales, ERROR.")
        GoTo Error_dev
    Else
    
        GLB_Envia = Array()
        If Not FUNC_EXECUTA_COMANDO_SQL("SP_CON_LEER_TABLA_DEV", GLB_Envia) Then
            Call PROC_Mensaje(".........Problemas al devengar Créditos Corfo, ERROR.")
            GoTo Error_dev
        End If
        
        If FUNC_LEE_RETORNO_SQL(vDatos_Retorno()) Then
            If vDatos_Retorno(1) = "NO" Then
                cMensaje = vDatos_Retorno(2)
                Call PROC_Mensaje(cMensaje)
                GoTo Error_dev
            Else
                Call PROC_Mensaje(".........Término de Devengo de Créditos Locales, OK.")
            End If
        End If
    End If
    
    GLB_Envia = Array()
    PROC_AGREGA_PARAMETRO GLB_Envia, Format(GLB_Fecha_Proceso, "YYYYMMDD")
    PROC_AGREGA_PARAMETRO GLB_Envia, Format(Fecha_Proximo_Dev, "YYYYMMDD")
    PROC_AGREGA_PARAMETRO GLB_Envia, "LOCAL"
    PROC_AGREGA_PARAMETRO GLB_Envia, "S"

    If Not FUNC_EXECUTA_COMANDO_SQL("SP_DEVENGO_CREDITOS", GLB_Envia) Then
        Call PROC_Mensaje(".........Problemas al devengar Créditos Locales dolar, ERROR.")
        GoTo Error_dev
    Else
    
        GLB_Envia = Array()
        If Not FUNC_EXECUTA_COMANDO_SQL("SP_CON_LEER_TABLA_DEV", GLB_Envia) Then
            Call PROC_Mensaje(".........Problemas al devengar Créditos Corfo dolar, ERROR.")
            GoTo Error_dev
        End If
        
        If FUNC_LEE_RETORNO_SQL(vDatos_Retorno()) Then
            If vDatos_Retorno(1) = "NO" Then
                cMensaje = vDatos_Retorno(2)
                Call PROC_Mensaje(cMensaje)
                GoTo Error_dev
            Else
                Call PROC_Mensaje(".........Término de Devengo de Créditos Locales en MX, OK.")
            End If
        End If
    End If
    
End If

If SCK_Extra.Value = True Then
    GLB_Envia = Array()
    PROC_AGREGA_PARAMETRO GLB_Envia, Format(GLB_Fecha_Proceso, "YYYYMMDD")
    PROC_AGREGA_PARAMETRO GLB_Envia, Format(Fecha_Proximo_Dev, "YYYYMMDD")
    PROC_AGREGA_PARAMETRO GLB_Envia, "EXTRA"
    PROC_AGREGA_PARAMETRO GLB_Envia, "N"

    If Not FUNC_EXECUTA_COMANDO_SQL("SP_DEVENGO_CREDITOS", GLB_Envia) Then
        Call PROC_Mensaje(".........Problemas al devengar Créditos Extranjeros, ERROR.")
        GoTo Error_dev
    Else

        GLB_Envia = Array()
        If Not FUNC_EXECUTA_COMANDO_SQL("SP_CON_LEER_TABLA_DEV", GLB_Envia) Then
            Call PROC_Mensaje(".........Problemas al devengar Créditos Extranjeros, ERROR.")
            GoTo Error_dev
        End If

        If FUNC_LEE_RETORNO_SQL(vDatos_Retorno()) Then
            If vDatos_Retorno(1) = "NO" Then
                cMensaje = vDatos_Retorno(2)
                Call PROC_Mensaje(cMensaje)
                GoTo Error_dev
            Else
                Call PROC_Mensaje(".........Término de Devengo de Créditos Extranjeros, OK.")
            End If
        End If
    End If
    GLB_Envia = Array()
    PROC_AGREGA_PARAMETRO GLB_Envia, Format(GLB_Fecha_Proceso, "YYYYMMDD")
    PROC_AGREGA_PARAMETRO GLB_Envia, Format(Fecha_Proximo_Dev, "YYYYMMDD")
    PROC_AGREGA_PARAMETRO GLB_Envia, "EXTRA"
    PROC_AGREGA_PARAMETRO GLB_Envia, "S"

    If Not FUNC_EXECUTA_COMANDO_SQL("SP_DEVENGO_CREDITOS", GLB_Envia) Then
        Call PROC_Mensaje(".........Problemas al devengar Créditos Extranjeros MX, ERROR.")
        GoTo Error_dev
    Else

        GLB_Envia = Array()
        If Not FUNC_EXECUTA_COMANDO_SQL("SP_CON_LEER_TABLA_DEV", GLB_Envia) Then
            Call PROC_Mensaje(".........Problemas al devengar Créditos Extranjeros MX, ERROR.")
            GoTo Error_dev
        End If

        If FUNC_LEE_RETORNO_SQL(vDatos_Retorno()) Then
            If vDatos_Retorno(1) = "NO" Then
                cMensaje = vDatos_Retorno(2)
                Call PROC_Mensaje(cMensaje)
                GoTo Error_dev
            Else
                Call PROC_Mensaje(".........Término de Devengo de Créditos Extranjeros en MX, OK.")
            End If
        End If
    End If

End If

If SCK_Bonos.Value = True Then
    GLB_Envia = Array()
    PROC_AGREGA_PARAMETRO GLB_Envia, Format(GLB_Fecha_Proceso, "YYYYMMDD")
    PROC_AGREGA_PARAMETRO GLB_Envia, Format(Fecha_Proximo_Dev, "YYYYMMDD")
    PROC_AGREGA_PARAMETRO GLB_Envia, "N"
  
    If Not FUNC_EXECUTA_COMANDO_SQL("SP_DEVENGO_BONOS", GLB_Envia) Then
        Call PROC_Mensaje(".........Problemas al devengar Bonos")
        GoTo Error_dev
    Else
    
     
        
        If FUNC_LEE_RETORNO_SQL(vDatos_Retorno()) Then
            If vDatos_Retorno(1) = "NO" Then
                cMensaje = vDatos_Retorno(2)
                Call PROC_Mensaje(cMensaje)
                GoTo Error_dev
            Else
                Call PROC_Mensaje(".........Término de Devengo de Bonos, OK.")
            End If
        End If
    End If
End If
   
    
'--------------- FIN DE MES ESPECIAL ------------------
If mvarFinMesEspecial = True Then
    '***************************************************
    ' RESPALDO DE OPERACIONES FIN DE MES ESPECIAL
    '***************************************************
    
    'Respalda el día de hoy
    GLB_Envia = Array()
    PROC_AGREGA_PARAMETRO GLB_Envia, Format(GLB_Fecha_Proceso, "YYYYMMDD")
    
    If Not FUNC_EXECUTA_COMANDO_SQL("SP_RESPALDO_PASIVO", GLB_Envia) Then
        Call PROC_Mensaje(".........Término de Respaldo de cartera, ERROR.")
        GoTo Error_dev
    Else
        Call PROC_Mensaje(".........Término de Respaldo de cartera de fecha de proceso, OK.")
    End If

    '***************************************************
    ' INICIO DE DÍA POR FIN DE MES ESPECIAL
    '***************************************************
    GLB_Envia = Array()
    PROC_AGREGA_PARAMETRO GLB_Envia, Format(GLB_Fecha_Proceso, "YYYYMMDD")
    PROC_AGREGA_PARAMETRO GLB_Envia, Format(Fecha_Proximo_Dev, "YYYYMMDD")
    
    If Not FUNC_EXECUTA_COMANDO_SQL("SP_ACT_INICIO_DIA_PSV", GLB_Envia) Then
        Call PROC_Mensaje(".........Término de Respaldo de cartera, ERROR.")
        GoTo Error_dev
    Else
        Call PROC_Mensaje(".........Término de Respaldo de cartera, OK.")
    End If

    'Respalda el día de cierre de mes inhábil
    GLB_Envia = Array()
    PROC_AGREGA_PARAMETRO GLB_Envia, Format(Fecha_Proximo_Dev, "YYYYMMDD")
    
    If Not FUNC_EXECUTA_COMANDO_SQL("SP_RESPALDO_PASIVO", GLB_Envia) Then
        Call PROC_Mensaje(".........Término de Respaldo de cartera, ERROR.")
        GoTo Error_dev
    Else
        Call PROC_Mensaje(".........Término de Respaldo de cartera de fecha de proceso, OK.")
    End If
    
    
    
    '***************************************************
    ' DEVENGO DE FIN DE MES A FECHA PROXIMA
    '***************************************************
    If SCK_Corfo.Value = True Then
        GLB_Envia = Array()
        PROC_AGREGA_PARAMETRO GLB_Envia, Format(Fecha_Proximo_Dev, "YYYYMMDD")
        PROC_AGREGA_PARAMETRO GLB_Envia, Format(GLB_Fecha_Proxima, "YYYYMMDD")
        PROC_AGREGA_PARAMETRO GLB_Envia, "CORFO"
        PROC_AGREGA_PARAMETRO GLB_Envia, "N"
        
        If Not FUNC_EXECUTA_COMANDO_SQL("SP_DEVENGO_CREDITOS", GLB_Envia) Then
            Call PROC_Mensaje(".........Problemas al devengar Créditos Corfo, ERROR.")
            GoTo Error_dev
        Else
            If FUNC_LEE_RETORNO_SQL(vDatos_Retorno()) Then
                If vDatos_Retorno(1) = "NO" Then
                    cMensaje = vDatos_Retorno(2)
                    Call PROC_Mensaje(cMensaje)
                    GoTo Error_dev
                Else
                    Call PROC_Mensaje(".........Término de Devengo de Créditos Corfo, OK.")
                End If
            End If
        End If
        
        GLB_Envia = Array()
        PROC_AGREGA_PARAMETRO GLB_Envia, Format(Fecha_Proximo_Dev, "YYYYMMDD")
        PROC_AGREGA_PARAMETRO GLB_Envia, Format(GLB_Fecha_Proxima, "YYYYMMDD")
        PROC_AGREGA_PARAMETRO GLB_Envia, "CORFO"
        PROC_AGREGA_PARAMETRO GLB_Envia, "S"
        
        If Not FUNC_EXECUTA_COMANDO_SQL("SP_DEVENGO_CREDITOS", GLB_Envia) Then
            Call PROC_Mensaje(".........Problemas al devengar Créditos Corfo MX, ERROR.")
            GoTo Error_dev
        Else
            If FUNC_LEE_RETORNO_SQL(vDatos_Retorno()) Then
                If vDatos_Retorno(1) = "NO" Then
                    cMensaje = vDatos_Retorno(2)
                    Call PROC_Mensaje(cMensaje)
                    GoTo Error_dev
                Else
                    Call PROC_Mensaje(".........Término de Devengo de Créditos Corfo Dolar, OK.")
                End If
            End If
        End If
        
    End If
    
    If SCK_Local.Value = True Then
        GLB_Envia = Array()
        PROC_AGREGA_PARAMETRO GLB_Envia, Format(Fecha_Proximo_Dev, "YYYYMMDD")
        PROC_AGREGA_PARAMETRO GLB_Envia, Format(GLB_Fecha_Proxima, "YYYYMMDD")
        PROC_AGREGA_PARAMETRO GLB_Envia, "LOCAL"
        PROC_AGREGA_PARAMETRO GLB_Envia, "N"
    
        If Not FUNC_EXECUTA_COMANDO_SQL("SP_DEVENGO_CREDITOS", GLB_Envia) Then
            Call PROC_Mensaje(".........Problemas al devengar Créditos Locales, ERROR.")
            GoTo Error_dev
        Else
            If FUNC_LEE_RETORNO_SQL(vDatos_Retorno()) Then
                If vDatos_Retorno(1) = "NO" Then
                    cMensaje = vDatos_Retorno(2)
                    Call PROC_Mensaje(cMensaje)
                    GoTo Error_dev
                Else
                    Call PROC_Mensaje(".........Término de Devengo de Créditos Locales, OK.")
                End If
            End If
        End If
        
        GLB_Envia = Array()
        PROC_AGREGA_PARAMETRO GLB_Envia, Format(Fecha_Proximo_Dev, "YYYYMMDD")
        PROC_AGREGA_PARAMETRO GLB_Envia, Format(GLB_Fecha_Proxima, "YYYYMMDD")
        PROC_AGREGA_PARAMETRO GLB_Envia, "LOCAL"
        PROC_AGREGA_PARAMETRO GLB_Envia, "S"
    
        If Not FUNC_EXECUTA_COMANDO_SQL("SP_DEVENGO_CREDITOS", GLB_Envia) Then
            Call PROC_Mensaje(".........Problemas al devengar Créditos Locales MX , ERROR.")
            GoTo Error_dev
        Else
            If FUNC_LEE_RETORNO_SQL(vDatos_Retorno()) Then
                If vDatos_Retorno(1) = "NO" Then
                    cMensaje = vDatos_Retorno(2)
                    Call PROC_Mensaje(cMensaje)
                    GoTo Error_dev
                Else
                    Call PROC_Mensaje(".........Término de Devengo de Créditos Locales MX , OK.")
                End If
            End If
        End If
        
    End If
   
    If SCK_Extra.Value = True Then
        GLB_Envia = Array()
        PROC_AGREGA_PARAMETRO GLB_Envia, Format(Fecha_Proximo_Dev, "YYYYMMDD")
        PROC_AGREGA_PARAMETRO GLB_Envia, Format(GLB_Fecha_Proxima, "YYYYMMDD")
        PROC_AGREGA_PARAMETRO GLB_Envia, "EXTRA"
        PROC_AGREGA_PARAMETRO GLB_Envia, "N"
    
        If Not FUNC_EXECUTA_COMANDO_SQL("SP_DEVENGO_CREDITOS", GLB_Envia) Then
            Call PROC_Mensaje(".........Problemas al devengar Créditos Locales, ERROR.")
            GoTo Error_dev
        Else
            If FUNC_LEE_RETORNO_SQL(vDatos_Retorno()) Then
                If vDatos_Retorno(1) = "NO" Then
                    cMensaje = vDatos_Retorno(2)
                    Call PROC_Mensaje(cMensaje)
                    GoTo Error_dev
                Else
                    Call PROC_Mensaje(".........Término de Devengo de Créditos Locales, OK.")
                End If
            End If
        End If
        
        GLB_Envia = Array()
        PROC_AGREGA_PARAMETRO GLB_Envia, Format(Fecha_Proximo_Dev, "YYYYMMDD")
        PROC_AGREGA_PARAMETRO GLB_Envia, Format(GLB_Fecha_Proxima, "YYYYMMDD")
        PROC_AGREGA_PARAMETRO GLB_Envia, "EXTRA"
        PROC_AGREGA_PARAMETRO GLB_Envia, "S"
    
        If Not FUNC_EXECUTA_COMANDO_SQL("SP_DEVENGO_CREDITOS", GLB_Envia) Then
            Call PROC_Mensaje(".........Problemas al devengar Créditos Locales MX, ERROR.")
            GoTo Error_dev
        Else
            If FUNC_LEE_RETORNO_SQL(vDatos_Retorno()) Then
                If vDatos_Retorno(1) = "NO" Then
                    cMensaje = vDatos_Retorno(2)
                    Call PROC_Mensaje(cMensaje)
                    GoTo Error_dev
                Else
                    Call PROC_Mensaje(".........Término de Devengo de Créditos Locales MX, OK.")
                End If
            End If
        End If
        
    End If
   
    If SCK_Bonos.Value = True Then
        GLB_Envia = Array()
        PROC_AGREGA_PARAMETRO GLB_Envia, Format(Fecha_Proximo_Dev, "YYYYMMDD")
        PROC_AGREGA_PARAMETRO GLB_Envia, Format(GLB_Fecha_Proxima, "YYYYMMDD")
        PROC_AGREGA_PARAMETRO GLB_Envia, "N"
      
        If Not FUNC_EXECUTA_COMANDO_SQL("SP_DEVENGO_BONOS", GLB_Envia) Then
            Call PROC_Mensaje(".........Problemas al devengar Bonos")
            GoTo Error_dev
        Else
            If FUNC_LEE_RETORNO_SQL(vDatos_Retorno()) Then
                If vDatos_Retorno(1) = "NO" Then
                    cMensaje = vDatos_Retorno(2)
                    Call PROC_Mensaje(cMensaje)
                    GoTo Error_dev
                Else
                    Call PROC_Mensaje(".........Término de Devengo de Bonos, OK.")
                End If
            End If
        End If
    End If

    ' Para poder exigir contabilización fin mes especial
    ' antes del cierre de día
    Call Grabar_Estado("PSV", "CONTABILIDAD", 0, True)

End If
    
     Call Grabar_Estado(GLB_Sistema, "Opcion_Menu_6100", 1, False)
    
    If Not FUNC_EXECUTA_COMANDO_SQL("COMMIT TRANSACTION") Then
        GoTo Error_dev
    End If

    FUNC_DEVENGAR = True
    
Exit Function

Error_dev:
    If Not FUNC_EXECUTA_COMANDO_SQL("ROLLBACK TRANSACTION") Then
        'MsgBox ("Problemas...."), vbCritical + vbInformation
    End If
    
End Function

