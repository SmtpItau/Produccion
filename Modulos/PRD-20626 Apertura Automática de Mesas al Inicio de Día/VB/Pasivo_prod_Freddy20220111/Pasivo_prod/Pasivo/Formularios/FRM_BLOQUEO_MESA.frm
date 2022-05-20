VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form FRM_BLOQUEO_MESA 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Bloqueo de Mesa"
   ClientHeight    =   2025
   ClientLeft      =   3255
   ClientTop       =   3270
   ClientWidth     =   2760
   Icon            =   "FRM_BLOQUEO_MESA.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   2025
   ScaleWidth      =   2760
   ShowInTaskbar   =   0   'False
   Begin VB.PictureBox Icono_Boton 
      Height          =   165
      Left            =   1020
      ScaleHeight     =   105
      ScaleWidth      =   375
      TabIndex        =   3
      Top             =   2190
      Visible         =   0   'False
      Width           =   435
   End
   Begin Threed.SSFrame SSFrame1 
      Height          =   1515
      Left            =   0
      TabIndex        =   1
      Top             =   480
      Width           =   2745
      _Version        =   65536
      _ExtentX        =   4842
      _ExtentY        =   2672
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
      Begin VB.CommandButton Cmd_Bloqueo 
         Caption         =   "Mesa Desbloqueada"
         DownPicture     =   "FRM_BLOQUEO_MESA.frx":2EFA
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   975
         Left            =   360
         Picture         =   "FRM_BLOQUEO_MESA.frx":33A4
         Style           =   1  'Graphical
         TabIndex        =   2
         Top             =   240
         Width           =   1965
      End
   End
   Begin MSComctlLib.ImageList ImageList2 
      Left            =   2010
      Top             =   -30
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   24
      ImageHeight     =   24
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   2
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_BLOQUEO_MESA.frx":3834
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "FRM_BLOQUEO_MESA.frx":3CEE
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   2760
      _ExtentX        =   4868
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
            Key             =   "cmdActualizar"
            Description     =   "Actualizar"
            Object.ToolTipText     =   "Actualizar Estados"
            ImageIndex      =   19
            BeginProperty ButtonMenus {66833FEC-8583-11D1-B16A-00C0F0283628} 
               NumButtonMenus  =   1
               BeginProperty ButtonMenu1 {66833FEE-8583-11D1-B16A-00C0F0283628} 
               EndProperty
            EndProperty
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdSalir"
            Description     =   "Salir"
            Object.ToolTipText     =   "Salir del Proceso"
            ImageIndex      =   2
         EndProperty
      EndProperty
      Begin MSComctlLib.ImageList Img_opciones 
         Left            =   1320
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
               Picture         =   "FRM_BLOQUEO_MESA.frx":418E
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_BLOQUEO_MESA.frx":45F5
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_BLOQUEO_MESA.frx":4AEB
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_BLOQUEO_MESA.frx":4F7E
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_BLOQUEO_MESA.frx":5466
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_BLOQUEO_MESA.frx":5979
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_BLOQUEO_MESA.frx":5EB6
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_BLOQUEO_MESA.frx":62F8
               Key             =   ""
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_BLOQUEO_MESA.frx":67B2
               Key             =   ""
            EndProperty
            BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_BLOQUEO_MESA.frx":6C85
               Key             =   ""
            EndProperty
            BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_BLOQUEO_MESA.frx":70C9
               Key             =   ""
            EndProperty
            BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_BLOQUEO_MESA.frx":7630
               Key             =   ""
            EndProperty
            BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_BLOQUEO_MESA.frx":7AFF
               Key             =   ""
            EndProperty
            BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_BLOQUEO_MESA.frx":7F1E
               Key             =   ""
            EndProperty
            BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_BLOQUEO_MESA.frx":8416
               Key             =   ""
            EndProperty
            BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_BLOQUEO_MESA.frx":880F
               Key             =   ""
            EndProperty
            BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_BLOQUEO_MESA.frx":8C92
               Key             =   ""
            EndProperty
            BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_BLOQUEO_MESA.frx":9158
               Key             =   ""
            EndProperty
            BeginProperty ListImage19 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_BLOQUEO_MESA.frx":964F
               Key             =   ""
            EndProperty
            BeginProperty ListImage20 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_BLOQUEO_MESA.frx":9B05
               Key             =   ""
            EndProperty
            BeginProperty ListImage21 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_BLOQUEO_MESA.frx":9ECA
               Key             =   ""
            EndProperty
            BeginProperty ListImage22 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_BLOQUEO_MESA.frx":A2C0
               Key             =   ""
            EndProperty
            BeginProperty ListImage23 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_BLOQUEO_MESA.frx":A6B7
               Key             =   ""
            EndProperty
            BeginProperty ListImage24 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_BLOQUEO_MESA.frx":AAC0
               Key             =   ""
            EndProperty
            BeginProperty ListImage25 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_BLOQUEO_MESA.frx":AF7E
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
End
Attribute VB_Name = "FRM_BLOQUEO_MESA"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim Actualiza As Boolean
Dim cOpt_Local As String

Private Sub PROC_CIERRE_MESA()

'   Dim iContador        As Integer
'   Dim sSistema         As String
'   Dim sOpcion          As String
'   Dim sEstado          As String
'   Dim sMensaje         As String
'
'      sSistema = "PSV"
'      sOpcion = "BLOQUEO"
'      If Trim(Cmd_Bloqueo.Caption) = "Mesa Desbloqueada" Then
'         sEstado = "0"
'      Else
'         sEstado = "1"
'      End If
'
'      PROC_LOG_AUDITORIA "19", cOpt_Local, Me.Caption, " ", " "
'
'      Call objCentralizacion.Grabar_Estado(sSistema, sOpcion, sEstado, True)

    Dim iContador        As Integer
'   Dim sSistema         As String
    Dim sOpcion          As String
    Dim sEstado          As String
    Dim sMensaje         As String
    Dim Datos()
    Dim Envia()
    Dim Fecha_Cierre_Mes

'      sSistema = "PSV"
       sOpcion = "MESA"
       If Trim(Cmd_Bloqueo.Caption) = "Mesa Desbloqueada" Then
          sEstado = "0"
          sMensaje = "Mesa Desbloqueada"
       Else
          sEstado = "1"
          sMensaje = "Mesa Bloqueada"
       End If
'
'      PROC_LOG_AUDITORIA "19", cOpt_Local, Me.Caption, " ", " "
'
      Call Grabar_Estado("PSV", sOpcion, sEstado, True)
      MsgBox sMensaje, vbExclamation
      
    If mvarFinMesEspecial = True And sEstado = "0" Then
        Fecha_Cierre_Mes = Format(GLB_Fecha_Proceso, "yyyymmdd")
        Envia = Array()
        AddParam Envia, Fecha_Cierre_Mes 'Fecha_proc.Text
        AddParam Envia, sOpcion
        
        If Not FUNC_EXECUTA_COMANDO_SQL("SP_RECUPERA_DATOS_CARTERA_HISTORICA", Envia) Then
           MsgBox "Error al recuperar datos de cartera_historica", vbCritical
           Exit Sub
        End If

       If FUNC_LEE_RETORNO_SQL(Datos()) Then
           MsgBox Datos(2), vbExclamation
       End If

      End If

     If sEstado = 0 Then
        PROC_LOG_AUDITORIA "15", cOpt_Local, Me.Caption & "  (Desbloqueo) Fecha : " & GLB_Fecha_Proceso, "", ""
        
    Else
        PROC_LOG_AUDITORIA "16", cOpt_Local, Me.Caption & "  (Bloqueo) Fecha : " & GLB_Fecha_Proceso, "", ""
    End If
    
End Sub

Private Sub Cmd_Bloqueo_Click()

   Icono_Boton.Picture = Cmd_Bloqueo.Picture

   Cmd_Bloqueo.Picture = Cmd_Bloqueo.DownPicture
   Cmd_Bloqueo.DownPicture = Icono_Boton.Picture
   
   If Trim(Cmd_Bloqueo.Caption) = "Mesa Desbloqueada" Then
   
      Cmd_Bloqueo.Caption = "Mesa Bloqueada"
      
   Else
   
      Cmd_Bloqueo.Caption = "Mesa Desbloqueada"
      
   End If

End Sub

Private Sub Form_Activate()

'      PROC_CARGA_AYUDA Me
'
'   Call objCentralizacion.Chequeo_Estado(GLB_Sistema, "Bloqueo", False)
'
'   If Not objCentralizacion.Estado Then
'
'      Cmd_Bloqueo.Caption = "Mesa Desbloqueada"
'
'   Else
'
'      Cmd_Bloqueo.Caption = "Mesa Bloqueada"
'      Icono_Boton.Picture = Cmd_Bloqueo.Picture
'      Cmd_Bloqueo.Picture = Cmd_Bloqueo.DownPicture
'      Cmd_Bloqueo.DownPicture = Icono_Boton.Picture
      
    'PROC_CARGA_AYUDA Me
      
   'Call Chequeo_Estado(GLB_Sistema, "MESA", False)
   Dim Datos()
   GLB_Envia = Array("PSV")
    
     If FUNC_EXECUTA_COMANDO_SQL("SP_CON_ESTADO_SWITCH", GLB_Envia) Then
        Do While FUNC_LEE_RETORNO_SQL(Datos())

            If Datos(5) = 0 And Datos(6) = "MESA" Then
                Cmd_Bloqueo.Caption = "Mesa Desbloqueada"
                Exit Sub
'            Else
'                Cmd_Bloqueo.Caption = "Mesa Bloqueada"
'                Icono_Boton.Picture = Cmd_Bloqueo.Picture
'                Cmd_Bloqueo.Picture = Cmd_Bloqueo.DownPicture
'                Cmd_Bloqueo.DownPicture = Icono_Boton.Picture
'                Exit Sub
           End If
        Loop
        Cmd_Bloqueo.Caption = "Mesa Bloqueada"
        Icono_Boton.Picture = Cmd_Bloqueo.Picture
        Cmd_Bloqueo.Picture = Cmd_Bloqueo.DownPicture
        Cmd_Bloqueo.DownPicture = Icono_Boton.Picture
    End If
End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)

   Select Case KeyAscii
   
      Case vbKeyGrabar
         
         If Toolbar1.Buttons(1).Enabled Then
         
            Call Toolbar1_ButtonClick(Toolbar1.Buttons(1))

         End If

      Case vbKeySalir
      
         Unload Me

   End Select

End Sub

Private Sub Form_Load()

   Me.Icon = FRM_MDI_PASIVO.Icon
   Me.left = 0
   Me.top = 0

   cOpt_Local = GLB_Opcion_Menu
   
   PROC_LOG_AUDITORIA "07", cOpt_Local, Me.Caption, " ", " "
   
End Sub

Private Sub Form_Unload(Cancel As Integer)

 PROC_LOG_AUDITORIA "08", cOpt_Local, Me.Caption, " ", " "
 
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

'   Dim sMensaje         As String
'
'   Select Case UCase(Button.Description)
'
'   Case "ACTUALIZAR"
'
'      Call objCentralizacion.Chequeo_Estado("PSV", "CONTABILIDAD", False, sMensaje)
'
'      If objCentralizacion.Estado Then
'
'         MsgBox objCentralizacion.Mensaje, vbExclamation
'         Exit Sub
'
'      End If
'
'      Call PROC_CIERRE_MESA
'
'   Case "SALIR"
'
'      Unload Me
'
'   End Select


   Dim sMensaje         As String

   Select Case UCase(Button.Description)
   
   Case "ACTUALIZAR"
   
            Dim Datos()
            GLB_Envia = Array("PSV")

            If FUNC_EXECUTA_COMANDO_SQL("SP_CON_ESTADO_SWITCH", GLB_Envia) Then
                Do While FUNC_LEE_RETORNO_SQL(Datos())
                    If Datos(5) = 1 And Datos(6) = "FIN" Then
                        MsgBox "Fin de día realizado", vbExclamation
                        Screen.MousePointer = 0
                        Exit Sub
                    End If
                Loop
            End If

         Call PROC_CIERRE_MESA

   Case "SALIR"
   
      Unload Me

   End Select
   
End Sub
