VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.2#0"; "mscomctl.ocx"
Object = "{989C9190-EDF5-45A8-AB6C-98E6EF0384D7}#1.0#0"; "Bac_Controles_Pas.ocx"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "Msflxgrd.ocx"
Begin VB.Form FRM_INICIODIA 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Inicio de Día Centralizado"
   ClientHeight    =   5565
   ClientLeft      =   3150
   ClientTop       =   2925
   ClientWidth     =   6735
   Icon            =   "FRM_INICIODIA.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5565
   ScaleMode       =   0  'User
   ScaleWidth      =   9692.355
   ShowInTaskbar   =   0   'False
   Begin VB.Frame Frame2 
      Enabled         =   0   'False
      Height          =   1065
      Left            =   0
      TabIndex        =   2
      Top             =   480
      Width           =   6660
      Begin BACControles.TXTFecha txtFechaProximoProceso 
         Height          =   315
         Left            =   120
         TabIndex        =   3
         Top             =   600
         Width           =   1290
         _ExtentX        =   2275
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
         Text            =   "07/11/2000"
      End
      Begin BACControles.TXTFecha txtFechaProceso 
         Height          =   315
         Left            =   120
         TabIndex        =   4
         Top             =   240
         Width           =   1290
         _ExtentX        =   2275
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
         Text            =   "07/11/2000"
      End
      Begin VB.Label Lbl_FecPro 
         BackColor       =   &H00FFFFFF&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   315
         Left            =   1545
         TabIndex        =   6
         Top             =   255
         Width           =   5010
      End
      Begin VB.Label Lbl_FecPrx 
         BackColor       =   &H00FFFFFF&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   315
         Left            =   1545
         TabIndex        =   5
         Top             =   615
         Width           =   5010
      End
   End
   Begin VB.Frame Frame1 
      Height          =   3975
      Left            =   30
      TabIndex        =   0
      Top             =   1560
      Width           =   6660
      Begin MSFlexGridLib.MSFlexGrid GRD_ValoresMoneda 
         Height          =   3570
         Left            =   120
         TabIndex        =   1
         Top             =   240
         Width           =   6435
         _ExtentX        =   11351
         _ExtentY        =   6297
         _Version        =   393216
         Cols            =   5
         FixedCols       =   0
         RowHeightMin    =   260
         BackColor       =   -2147483644
         ForeColor       =   8388608
         BackColorFixed  =   8421376
         ForeColorFixed  =   16777215
         BackColorSel    =   8388608
         ForeColorSel    =   16777215
         BackColorBkg    =   -2147483644
         GridColor       =   255
         FillStyle       =   1
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
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   7
      Top             =   0
      Width           =   6735
      _ExtentX        =   11880
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
            Description     =   "Procesar"
            Object.ToolTipText     =   "Procesar Inicio de Dia"
            ImageIndex      =   14
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Description     =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      Begin MSComctlLib.ImageList Img_opciones 
         Left            =   5040
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
               Picture         =   "FRM_INICIODIA.frx":2EFA
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_INICIODIA.frx":3361
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_INICIODIA.frx":3857
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_INICIODIA.frx":3CEA
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_INICIODIA.frx":41D2
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_INICIODIA.frx":46E5
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_INICIODIA.frx":4C22
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_INICIODIA.frx":5064
               Key             =   ""
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_INICIODIA.frx":551E
               Key             =   ""
            EndProperty
            BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_INICIODIA.frx":59F1
               Key             =   ""
            EndProperty
            BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_INICIODIA.frx":5E35
               Key             =   ""
            EndProperty
            BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_INICIODIA.frx":639C
               Key             =   ""
            EndProperty
            BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_INICIODIA.frx":686B
               Key             =   ""
            EndProperty
            BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_INICIODIA.frx":6C8A
               Key             =   ""
            EndProperty
            BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_INICIODIA.frx":7182
               Key             =   ""
            EndProperty
            BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_INICIODIA.frx":757B
               Key             =   ""
            EndProperty
            BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_INICIODIA.frx":79FE
               Key             =   ""
            EndProperty
            BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_INICIODIA.frx":7EC4
               Key             =   ""
            EndProperty
            BeginProperty ListImage19 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_INICIODIA.frx":83BB
               Key             =   ""
            EndProperty
            BeginProperty ListImage20 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_INICIODIA.frx":8871
               Key             =   ""
            EndProperty
            BeginProperty ListImage21 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_INICIODIA.frx":8C36
               Key             =   ""
            EndProperty
            BeginProperty ListImage22 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_INICIODIA.frx":902C
               Key             =   ""
            EndProperty
            BeginProperty ListImage23 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_INICIODIA.frx":9423
               Key             =   ""
            EndProperty
            BeginProperty ListImage24 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_INICIODIA.frx":982C
               Key             =   ""
            EndProperty
            BeginProperty ListImage25 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_INICIODIA.frx":9CEA
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
End
Attribute VB_Name = "FRM_INICIODIA"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'*********************************JuanLizama******************************************
Option Explicit

Dim mvarFechaProximoProceso As Date
Dim mvarFechaAnterior       As Date
Dim mvarFechaProceso        As Date
Dim cOptLocal As String
Sub PROC_Setea_Grilla()

   With GRD_ValoresMoneda
      .ColWidth(0) = 2930
      .ColWidth(1) = 1700
      .ColWidth(2) = 1700
      .ColWidth(3) = 0
      .ColWidth(4) = 0

      .RowHeight(0) = 350
      .CellFontWidth = 4
      .Row = 0

      .Col = 0
      .FixedAlignment(0) = 4
      .CellFontBold = True
      .Text = " Moneda/Tasa "
      .ColAlignment(0) = 2

      .Col = 1
      .FixedAlignment(1) = 4
      .CellFontBold = True
      .Text = " Proceso "
      .ColAlignment(1) = 8

      .Col = 2
      .FixedAlignment(2) = 4
      .CellFontBold = True
      .Text = " Proximo Proceso "
      .ColAlignment(2) = 8

   End With

End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)

   Select Case KeyAscii
   Case VbKeyProcesar
      If Toolbar1.Buttons(1).Enabled Then
         Call Toolbar1_ButtonClick(Toolbar1.Buttons(1))

      End If

   Case vbKeySalir
      Unload Me

   End Select

End Sub
Private Sub Form_Load()

   PROC_Setea_Grilla
   
   cOptLocal = GLB_Opcion_Menu
   Me.Icon = FRM_MDI_PASIVO.Icon
   Me.left = 0
   Me.top = 0

   
      Call Carga_ParametrosInicio
      Call Iniciar_Dia

      txtFechaProceso.Text = mvarFechaProceso 'GLB_Fecha_Proceso
      txtFechaProximoProceso.Text = mvarFechaProximoProceso 'GLB_Fecha_Proxima
      Lbl_FecPro.Caption = FUNC_Format_Fecha(txtFechaProceso.Text, "DDDD", "MMMM", "AAAA")
      Lbl_FecPrx.Caption = FUNC_Format_Fecha(txtFechaProximoProceso.Text, "DDDD", "MMMM", "AAAA")
  
      Call CargarDatos_Grilla(GRD_ValoresMoneda, mvarFechaProceso, mvarFechaProximoProceso)
      
      Call PROC_LOG_AUDITORIA("07", cOptLocal, Me.Caption & " Fecha : " & GLB_Fecha_Proceso, "", "")

End Sub

Private Sub Form_Unload(Cancel As Integer)
   FRM_MDI_PASIVO.Tmr_Mensaje.Enabled = True
   Call PROC_LOG_AUDITORIA("08", cOptLocal, Me.Caption & " Fecha : " & GLB_Fecha_Proceso, "", "")
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

   Dim sMensaje         As String

   Select Case UCase(Button.Description)
   Case "PROCESAR"
   
   Dim Datos()
   GLB_Envia = Array("PSV")
        
     If FUNC_EXECUTA_COMANDO_SQL("SP_CON_ESTADO_SWITCH", GLB_Envia) Then
        Do While FUNC_LEE_RETORNO_SQL(Datos())
    
            If Datos(5) = 0 And Datos(6) = "INICIO" Then
            
                If FUNC_INICIO_PSV Then
                   Call FUNC_GRABAR_VALORES
                   Call Carga_Parametros
                   txtFechaProceso.Text = mvarFechaProceso
                   txtFechaProximoProceso.Text = mvarFechaProximoProceso
                   Call PROC_LOG_AUDITORIA("19", cOptLocal, Me.Caption & " (Proceso realizado) Fecha : " & GLB_Fecha_Proceso, "", "")
                End If
                Exit Sub
                
               ElseIf (Datos(5) = 1 And Datos(6) = "INICIO") Then
                MsgBox "Inicio dia ya realizado", vbExclamation
                Call PROC_LOG_AUDITORIA("19", cOptLocal, Me.Caption & " (Proceso no realizado) Fecha : " & GLB_Fecha_Proceso, "", "")
                Exit Sub

           End If

        Loop
     Else
       Call PROC_LOG_AUDITORIA("19", cOptLocal, Me.Caption & " (Proceso no  realizado) Fecha : " & GLB_Fecha_Proceso, "", "")
    End If

   '**********

   Case "SALIR"
      Unload Me

   End Select

End Sub
'****************************************************************
'*************************JUANLIZAMA*****************************
Public Sub CargarDatos_Grilla(objControl As Object, sFechaProceso As Date, sFechaProximo As Date)

   Dim Datos()

   On Error GoTo Label1

   GLB_Envia = Array(sFechaProceso, sFechaProximo)

   If Not FUNC_EXECUTA_COMANDO_SQL("SP_CON_CARGA_VALORES_INICIO_DIA", GLB_Envia) Then
      
      Exit Sub
   
   End If

   With objControl

      .Rows = 1

      Do While FUNC_LEE_RETORNO_SQL(Datos())

         .Rows = .Rows + 1

         .TextMatrix(.Rows - 1, 0) = Datos(2)
         .TextMatrix(.Rows - 1, 1) = Format(CDbl(Datos(3)), GLB_Formato_Decimal)
         .TextMatrix(.Rows - 1, 2) = Format(CDbl(Datos(4)), GLB_Formato_Decimal)
         .TextMatrix(.Rows - 1, 3) = Datos(1)
         .TextMatrix(.Rows - 1, 4) = Datos(5)

      Loop

      If .Rows > 1 Then
         
         .Enabled = True
         
         .RowSel = 1
         .Col = 0
         .ColSel = 0

      End If

    End With
    
    On Error GoTo 0

    Exit Sub

Label1:
    On Error GoTo 0

End Sub
'****************************************************************
'********************JuanLizama**********************************
Private Function FUNC_INICIO_PSV() As Boolean

    FUNC_INICIO_PSV = False

    GLB_Envia = Array()

    GLB_Envia = Array()
    PROC_AGREGA_PARAMETRO GLB_Envia, Format(GLB_Fecha_Proceso, "YYYYMMDD")
    
    'mvarFechaCierreMesAnterior = DateAdd("D", DatePart("D", GLB_Fecha_Proceso) * -1, GLB_Fecha_Proceso)
    mvarFechaCierreMesAnterior = DateAdd("D", DatePart("D", GLB_Fecha_Proxima) * -1, GLB_Fecha_Proxima)
    mvarFechaCierreMesNuevo = DateAdd("M", 1, GLB_Fecha_Proxima)
'    mvarFechaCierreMesNuevo = DateAdd("D", DatePart("D", mvarFechaCierreMesNuevo) * -1, mvarFechaCierreMesNuevo)
    mvarFechaCierreMesNuevo = DateAdd("d", -1, DateValue("01-" & CStr(DatePart("m", DateAdd("m", 1, GLB_Fecha_Proceso))) & "-" & CStr(DatePart("yyyy", DateAdd("m", 1, GLB_Fecha_Proceso)))))

    GLB_Fecha_FinMes = mvarFechaCierreMesNuevo
    
    
    If mvarFinMesEspecial Then
        ' Parametros para realizar inicio de día con fin de mes especial
        GLB_Envia = Array()
        PROC_AGREGA_PARAMETRO GLB_Envia, Format(mvarFechaCierreMesAnterior, "yyyymmdd")
        PROC_AGREGA_PARAMETRO GLB_Envia, Format(mvarFechaProceso, "yyyymmdd")
    Else
    
        ' Respaldo en día normales, ya que en fin de mes especial, se respalda en el devengo
        If Not FUNC_EXECUTA_COMANDO_SQL("SP_RESPALDO_PASIVO", GLB_Envia) Then
            MsgBox "Problemas al realizar respaldo de cartera", vbCritical
            Exit Function
        End If

        ' Parametros para realizar inicio de día de manera normal
        GLB_Envia = Array()
        PROC_AGREGA_PARAMETRO GLB_Envia, Format(mvarFechaAnterior, "yyyymmdd")
        PROC_AGREGA_PARAMETRO GLB_Envia, Format(mvarFechaProceso, "yyyymmdd")
        
    End If
    
    
'    If Month(mvarFechaProceso) <> Month(mvarFechaCierreMesAnterior) Then
'        GLB_Envia = Array()
'        PROC_AGREGA_PARAMETRO GLB_Envia, Format(mvarFechaCierreMesNuevo, "YYYYMMDD")
'    End If
'
'    If Not FUNC_EXECUTA_COMANDO_SQL("SP_RESPALDO_PASIVO", GLB_Envia) Then
'        MsgBox "Problemas al realizar respaldo de cartera", vbCritical
'        Exit Function
'    End If
    
'    If Month(mvarFechaProceso) <> Month(mvarFechaCierreMesNuevo) Then
'        GLB_Envia = Array()
'        PROC_AGREGA_PARAMETRO GLB_Envia, Format(mvarFechaCierreMesNuevo, "yyyymmdd")
'        PROC_AGREGA_PARAMETRO GLB_Envia, Format(mvarFechaProceso, "yyyymmdd")
'    Else
'        GLB_Envia = Array()
'        PROC_AGREGA_PARAMETRO GLB_Envia, Format(mvarFechaAnterior, "yyyymmdd")
'        PROC_AGREGA_PARAMETRO GLB_Envia, Format(mvarFechaProceso, "yyyymmdd")
'    End If

    If Not FUNC_EXECUTA_COMANDO_SQL("SP_ACT_INICIO_DIA_PSV", GLB_Envia) Then

       
       MsgBox "Problemas al Inicio Día", vbCritical
       Exit Function

    End If

    MsgBox "Proceso de Inicio de Día éxitoso", vbInformation
   
    If Not Grabar_Estado("PSV", "INICIO", "1", False) Then
       Exit Function
    End If
    If Not Grabar_Estado("PSV", "CONTABILIDAD", "0", False) Then
       Exit Function
    End If
    If Not Grabar_Estado("PSV", "DEVENGAMIENTO", "0", False) Then
       Exit Function
    End If
    If Not Grabar_Estado("PSV", "FIN", "0", False) Then
       Exit Function
    End If
    If Not Grabar_Estado("PSV", "MESA", "0", False) Then
       Exit Function
    End If



    FUNC_INICIO_PSV = True

End Function
'****************************************************************
'********************JuanLizama**********************************
Public Function Carga_ParametrosInicio() As Boolean

   Dim Datos()
   Dim cSql       As String

   Carga_ParametrosInicio = True

   If FUNC_EXECUTA_COMANDO_SQL("sp_parametros_sistema") Then
      If FUNC_LEE_RETORNO_SQL(Datos()) Then
          mvarFechaProceso = Datos(1)
         'mvarNombreCliente = Datos(2)
          mvarFechaProximoProceso = Datos(3)
         'mvarRutCliente = Datos(4)
         'mvarDigitoCliente = Datos(5)
         'mvarRutComi = Datos(6)
         'mvarPrComi = Datos(7)
         'mvarIva = Datos(8)
         'mvarUFdia = Datos(12)
         'mvarDolarObservadoDia = Datos(13)
         'mvarRutCartera = Datos(9)
         'mvarDigitoCartera = Datos(10)
         'mvarNombreCartera = Datos(11)
         mvarFechaAnterior = Datos(16)
         'mvarPuerto_UDP = CSng(Datos(17))

         'mvarDiasPactadoNoBCCH = Datos(14)
         'mvarMontoPatrimonioEfectivo = Datos(15)

         mvarFechaCierreMesAnterior = DateAdd("D", DatePart("D", mvarFechaProceso) * -1, mvarFechaProceso)
         mvarFechaCierreMesNuevo = DateAdd("M", 1, mvarFechaProceso)
'         mvarFechaCierreMesNuevo = DateAdd("D", DatePart("D", mvarFechaCierreMesNuevo) * -1, mvarFechaCierreMesNuevo)
         mvarFechaCierreMesNuevo = DateAdd("d", -1, DateValue("01-" & CStr(DatePart("m", DateAdd("m", 1, GLB_Fecha_Proceso))) & "-" & CStr(DatePart("yyyy", DateAdd("m", 1, GLB_Fecha_Proceso)))))

         GLB_Fecha_FinMes = mvarFechaCierreMesNuevo
'         GLB_Fecha_FinMes = Datos(23)
         
         If mvarFechaProceso < mvarFechaCierreMesNuevo And mvarFechaProximoProceso > mvarFechaCierreMesNuevo Then
            mvarFinMesEspecial = True

         Else
            mvarFinMesEspecial = False

         End If

      End If

   Else
      Carga_ParametrosInicio = False
      Exit Function

   End If

End Function
'****************************************************************
'********************JuanLizama**********************************
Public Sub Iniciar_Dia()
Dim Datos()

   mvarFechaAnterior = GLB_Fecha_Proceso
   mvarFechaProceso = GLB_Fecha_Proxima
   
    GLB_Envia = Array(1, 22, mvarFechaProceso, 2)
    If Not FUNC_EXECUTA_COMANDO_SQL("SP_CON_FECHA_FERIADO ", GLB_Envia) Then
        MsgBox "No se pudo determinar feriado", vbCritical, "PASIVOS"
        Exit Sub
    End If
  
    If FUNC_LEE_RETORNO_SQL(Datos()) Then
         mvarFechaProximoProceso = Datos(1)
    End If
  
   'mvarFechaCierreMesAnterior = DateAdd("D", DatePart("D", mvarFechaProceso) * -1, mvarFechaProceso)
   'mvarFechaCierreMesNuevo = DateAdd("M", 1, mvarFechaProceso)
   'mvarFechaCierreMesNuevo = DateAdd("D", DatePart("D", mvarFechaCierreMesNuevo) * -1, mvarFechaCierreMesNuevo)

   'If mvarFechaProceso < mvarFechaCierreMesNuevo And mvarFechaProximoProceso > mvarFechaCierreMesNuevo Then
   '   mvarFinMesEspecial = True

   'Else
   '   mvarFinMesEspecial = False

   'End If

End Sub
'****************************************************************
Public Function FUNC_GRABAR_VALORES() As Boolean

   FUNC_GRABAR_VALORES = False

   GLB_Envia = Array(Format(mvarFechaProceso, "YYYYMMDD"), Format(mvarFechaProximoProceso, "YYYYMMDD"))


   If Not FUNC_EXECUTA_COMANDO_SQL("SP_GRA_INICIO_DIA", GLB_Envia) Then
       MsgBox "Problemas al grabar", vbInformation
      Exit Function

   End If

   FUNC_GRABAR_VALORES = True

End Function





