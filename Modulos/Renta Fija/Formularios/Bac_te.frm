VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Begin VB.Form Bac_Te 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Devengamiento"
   ClientHeight    =   6030
   ClientLeft      =   1125
   ClientTop       =   1500
   ClientWidth     =   8490
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   6030
   ScaleWidth      =   8490
   ShowInTaskbar   =   0   'False
   Begin VB.ListBox lstStatus 
      BeginProperty Font 
         Name            =   "Courier New"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   2790
      Left            =   120
      TabIndex        =   22
      Top             =   3210
      Width           =   8295
   End
   Begin Threed.SSFrame SSFrame1 
      Height          =   3060
      Left            =   5040
      TabIndex        =   0
      Top             =   120
      Width           =   3375
      _Version        =   65536
      _ExtentX        =   5953
      _ExtentY        =   5397
      _StockProps     =   14
      Caption         =   "Devengamiento"
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   4
      Begin Threed.SSCommand cmdSalir 
         Height          =   495
         Left            =   1755
         TabIndex        =   13
         Top             =   2490
         Width           =   1215
         _Version        =   65536
         _ExtentX        =   2143
         _ExtentY        =   873
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
      End
      Begin Threed.SSCommand cmdDevengar 
         Height          =   495
         Left            =   540
         TabIndex        =   12
         Top             =   2490
         Width           =   1215
         _Version        =   65536
         _ExtentX        =   2143
         _ExtentY        =   873
         _StockProps     =   78
         Caption         =   "&Procesar"
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
      End
      Begin Threed.SSCheck chkInterbancarios 
         Height          =   315
         Left            =   120
         TabIndex        =   4
         Top             =   1200
         Width           =   3075
         _Version        =   65536
         _ExtentX        =   5424
         _ExtentY        =   556
         _StockProps     =   78
         Caption         =   "Interbancarios"
         ForeColor       =   8388608
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin Threed.SSCheck chkVentasConPacto 
         Height          =   315
         Left            =   120
         TabIndex        =   3
         Top             =   945
         Width           =   3075
         _Version        =   65536
         _ExtentX        =   5424
         _ExtentY        =   556
         _StockProps     =   78
         Caption         =   "Ventas con Pacto"
         ForeColor       =   8388608
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin Threed.SSCheck chkComprasConPacto 
         Height          =   315
         Left            =   120
         TabIndex        =   2
         Top             =   690
         Width           =   3075
         _Version        =   65536
         _ExtentX        =   5424
         _ExtentY        =   556
         _StockProps     =   78
         Caption         =   "Compras con Pacto"
         ForeColor       =   8388608
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin Threed.SSCheck chkCarteraInversiones 
         Height          =   315
         Left            =   120
         TabIndex        =   1
         Top             =   420
         Width           =   3075
         _Version        =   65536
         _ExtentX        =   5424
         _ExtentY        =   556
         _StockProps     =   78
         Caption         =   "Cartera de Inversiones"
         ForeColor       =   8388608
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin Threed.SSCheck ChkCarteraPasivos 
         Height          =   360
         Left            =   120
         TabIndex        =   21
         Top             =   1425
         Visible         =   0   'False
         Width           =   3075
         _Version        =   65536
         _ExtentX        =   5424
         _ExtentY        =   635
         _StockProps     =   78
         Caption         =   "Pasivos"
         ForeColor       =   8388608
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin Threed.SSCheck chkGarantias 
         Height          =   360
         Left            =   120
         TabIndex        =   23
         Top             =   1695
         Width           =   3075
         _Version        =   65536
         _ExtentX        =   5424
         _ExtentY        =   635
         _StockProps     =   78
         Caption         =   "Garantias Recepcionadas"
         ForeColor       =   8388608
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
   End
   Begin Threed.SSFrame SSFrame2 
      Height          =   1515
      Left            =   120
      TabIndex        =   5
      Top             =   120
      Width           =   4815
      _Version        =   65536
      _ExtentX        =   8493
      _ExtentY        =   2672
      _StockProps     =   14
      Caption         =   "Datos Devengamiento"
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Font3D          =   4
      Begin VB.TextBox txtTasaEstimadaPCDUSD 
         Height          =   315
         Left            =   3240
         TabIndex        =   11
         Top             =   1080
         Width           =   1455
      End
      Begin VB.TextBox txtTasaEstimadaPCDUF 
         Height          =   315
         Left            =   3240
         TabIndex        =   10
         Top             =   720
         Width           =   1455
      End
      Begin VB.TextBox txtTasaEstimadaPTF 
         BackColor       =   &H00FFFFFF&
         Height          =   315
         Left            =   3240
         TabIndex        =   9
         Top             =   360
         Width           =   1455
      End
      Begin VB.Label lblTasaEstimadaPTF 
         Caption         =   "Tasa Estimada PCD US$"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   315
         Left            =   150
         TabIndex        =   8
         Top             =   1110
         Width           =   2775
      End
      Begin VB.Label lblTasaEstimadaPCDUF 
         Caption         =   "Tasa Estimada PCD UF"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   315
         Left            =   150
         TabIndex        =   7
         Top             =   765
         Width           =   2775
      End
      Begin VB.Label lblTasaEstimadaPCDUSD 
         Caption         =   "Tasa Estimada PTF"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   315
         Left            =   150
         TabIndex        =   6
         Top             =   420
         Width           =   2775
      End
   End
   Begin Threed.SSFrame SSFrame3 
      Height          =   1545
      Left            =   120
      TabIndex        =   14
      Top             =   1635
      Width           =   4815
      _Version        =   65536
      _ExtentX        =   8493
      _ExtentY        =   2725
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
      Enabled         =   0   'False
      Begin VB.TextBox txtFechaProceso 
         Height          =   315
         Left            =   3270
         TabIndex        =   17
         Top             =   240
         Width           =   1455
      End
      Begin VB.TextBox txtFechaProximoProceso 
         Height          =   315
         Left            =   3270
         TabIndex        =   16
         Top             =   585
         Width           =   1455
      End
      Begin VB.TextBox txtFechaCierreMes 
         Height          =   315
         Left            =   3270
         TabIndex        =   15
         Top             =   945
         Width           =   1455
      End
      Begin VB.Label lblFechaProceso 
         Caption         =   "Fecha Proceso"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   315
         Left            =   180
         TabIndex        =   20
         Top             =   255
         Width           =   2775
      End
      Begin VB.Label lblFechaProximoProceso 
         Caption         =   "Fecha Proximo Proceso"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   315
         Left            =   180
         TabIndex        =   19
         Top             =   600
         Width           =   2775
      End
      Begin VB.Label lblFechaCierreMes 
         Caption         =   "Fecha Cierre Mes"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   315
         Left            =   180
         TabIndex        =   18
         Top             =   960
         Width           =   2775
      End
   End
End
Attribute VB_Name = "Bac_Te"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim Status_Dev             As String         'Estado del devengamiento
                                             '  0: Proceso OK
                                             '  1: Problemas en la ejecución y
                                             '  2:Problema en el devengamiento
Dim Mensaje_Dev            As String         'Mensaje devengamiento
Dim Retorno_Dev            As String         'Retorno del procedimiento del devengamiento
Dim swDevengo              As String         'Flag que identifica si esta devengado
Dim Fecha_Proceso_Dev      As String         'Fecha Proceso del devengo
Dim Fecha_Proximo_Dev      As String         'Fecha Proximo Proceso del devengo
Dim Fecha_Cierre_Mes       As String         'Cierre de Mes
Dim Fecha_Proceso          As String         'Fecha Proceso
Dim Fecha_Proximo_Proceso  As String         'Fecha Proximo Proceso
Dim valPCDUSD              As Double
Dim valPCDUF               As Double
Dim valPTF                 As Double
Dim Sql                    As String
Dim bHabilitagarantias      As Boolean

Dim Datos()

Private Function FuncHabilitaGarantias() As Boolean
    Dim cSql        As String
    Dim cSqlDatos()
    
    Let FuncHabilitaGarantias = False
    
    Let cSql = " SELECT 'Estado' = BacTraderSuda.dbo.Fx_Sw_Garantias (4)"
    If Not Bac_Sql_Execute(cSql) Then
        Exit Function
    End If
    If Bac_SQL_Fetch(cSqlDatos()) Then
        Let FuncHabilitaGarantias = IIf(cSqlDatos(1) = 1, True, False)
    End If
    
End Function


Private Function Func_Mensaje(sMensaje As String, sStatus As String, sMensaje2 As String)
   lstStatus.AddItem sMensaje
   If sStatus <> "0" Then
      lstStatus.AddItem sMensaje2
   End If
   lstStatus.Refresh
   lstStatus.ListIndex = lstStatus.ListCount - 1
End Function

'Proceso que ejecuta el devengamiento
Private Sub Func_Devengar()

    MousePointer = 11

    Call Func_Mensaje("<<<< Devengando desde " & Fecha_Proceso_Dev & " hasta al " & Fecha_Proximo_Dev & " >>>>", "0", "")

    If chkCarteraInversiones.Value = 0 Then
        Call Func_Cartera_Inversiones
        Call Func_Mensaje(Mensaje_Dev, Status_Dev, Retorno_Dev)
        chkCarteraInversiones.Value = (Status_Dev = "0")
        chkCarteraInversiones.Refresh
    End If

    If chkComprasConPacto.Value = 0 Then
        Call Func_Compras_Con_Pacto
        Call Func_Mensaje(Mensaje_Dev, Status_Dev, Retorno_Dev)
        chkComprasConPacto.Value = (Status_Dev = "0")
        chkComprasConPacto.Refresh
    End If

    If chkVentasConPacto.Value = 0 Then
        Call Func_Ventas_Con_Pacto
        Call Func_Mensaje(Mensaje_Dev, Status_Dev, Retorno_Dev)
        chkVentasConPacto.Value = (Status_Dev = "0")
        chkVentasConPacto.Refresh
    End If

    If chkInterbancarios.Value = 0 Then
        Call Func_Interbancarios
        Call Func_Mensaje(Mensaje_Dev, Status_Dev, Retorno_Dev)
        chkInterbancarios.Value = (Status_Dev = "0")
        chkInterbancarios.Refresh
    End If

    If chkGarantias.Value = 0 Then
        Call Func_Garantias(False)
        Call Func_Mensaje(Mensaje_Dev, Status_Dev, Retorno_Dev)
        chkGarantias.Value = (Status_Dev = "0")
        chkGarantias.Refresh
    End If

'' '  If ChkCarteraPasivos.Value = 0 Then
'' '     Call Func_Cartera_Pasivos
''
'' '     Call Func_Mensaje(Mensaje_Dev, Status_Dev, Retorno_Dev)
''
'' '     ChkCarteraPasivos.Value = (Status_Dev = "0")
'' '     ChkCarteraPasivos.Refresh
''
'' '  End If

    MousePointer = 0
End Sub


Private Sub Func_DevengarDolar()
    MousePointer = 11
    Call Func_Mensaje("<<<< Devengando Dolares desde " & Fecha_Proceso & " hasta al " & Fecha_Proximo_Dev & " >>>>", "0", "")
   
    If chkCarteraInversiones.Value = 0 Then
        Call Func_Cartera_InversionesDolar
        Call Func_Mensaje(Mensaje_Dev, Status_Dev, Retorno_Dev)
        chkCarteraInversiones.Value = (Status_Dev = "0")
        chkCarteraInversiones.Refresh
    End If
    If chkComprasConPacto.Value = 0 Then
        Call Func_Compras_Con_PactoDolar
        Call Func_Mensaje(Mensaje_Dev, Status_Dev, Retorno_Dev)
        chkComprasConPacto.Value = (Status_Dev = "0")
        chkComprasConPacto.Refresh
    End If
    If chkVentasConPacto.Value = 0 Then
        Call Func_Ventas_Con_PactoDolar
        Call Func_Mensaje(Mensaje_Dev, Status_Dev, Retorno_Dev)
        chkVentasConPacto.Value = (Status_Dev = "0")
        chkVentasConPacto.Refresh
    End If
    If chkInterbancarios.Value = 0 Then
        Call Func_InterbancariosDolar
        Call Func_Mensaje(Mensaje_Dev, Status_Dev, Retorno_Dev)
        chkInterbancarios.Value = (Status_Dev = "0")
        chkInterbancarios.Refresh
    End If
    
    If chkGarantias.Value = 0 Then
        Call Func_Garantias(True)
        Call Func_Mensaje(Mensaje_Dev, Status_Dev, Retorno_Dev)
        chkGarantias.Value = (Status_Dev = "0")
        chkGarantias.Refresh
    End If
    
    MousePointer = 0
End Sub

Private Sub Func_Cartera_Inversiones()
    Dim Sw_Devengo_Ok    As String
    Dim Msg_Devengo      As String

    MousePointer = 11

    Envia = Array(Format(Fecha_Proceso_Dev, "yyyymmdd"), _
            Format(Fecha_Proximo_Dev, "yyyymmdd"), _
            CDbl(valPCDUSD), _
            CDbl(valPCDUF), _
            CDbl(valPTF), _
            "N")

    Status_Dev = "0"
    
    If Bac_Sql_Execute("SP_DEVPROPIAINTER", Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            If Datos(1) <> "SI" Then
                Status_Dev = "2"
            End If
            Retorno_Dev = Datos(2)
        Loop
        
        If Status_Dev = "0" Then
            Mensaje_Dev = "El proceso del Devengamiento de la CARTERA DE INVERSIONES termino OK"
        Else
            Mensaje_Dev = "El proceso del Devengamiento de la CARTERA DE INVERSIONES a fallado"
        End If
    Else
        'Problema en la ejecución del procedimiento
        Status_Dev = "1"
        Mensaje_Dev = "El proceso del devengamiento de la CARTERA DE INVERSIONES a fallado"
        Retorno_Dev = ""
    End If

    Valor_antiguo = " "
    Valor_antiguo = "Fecha Proceso Devengo:" & Fecha_Proceso_Dev & ";Fecha Próximo Proceso:" & Fecha_Proximo_Dev & ";Mensaje=" & Mensaje_Dev

    Call GRABA_LOG_AUDITORIA(1, gsBac_Fecp, gsBac_IP, gsBac_User, "BTR", "Opc_40200", "01", "Devengo Cart Inv.", "mdrs", Valor_antiguo, " ")
End Sub

Private Sub Func_Cartera_Pasivos()
    Dim Sw_Devengo_Ok    As String
    Dim Msg_Devengo      As String
    
    MousePointer = 11
    
    Envia = Array(Format(Fecha_Proceso_Dev, "yyyymmdd"), _
            Format(Fecha_Proximo_Dev, "yyyymmdd"), _
            CDbl(valPCDUSD), _
            CDbl(valPCDUF), _
            CDbl(valPTF), _
            "N")

    Status_Dev = "0"
    
    If Bac_Sql_Execute("SP_DEVENGOPASIVO", Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            If Datos(1) <> "SI" Then
                Status_Dev = "2"
            End If
            Retorno_Dev = Datos(2)
        Loop

        If Status_Dev = "0" Then
            Mensaje_Dev = "El proceso del Devengamiento de la CARTERA DE PASIVOS termino OK"
        Else
            Mensaje_Dev = "El proceso del Devengamiento de la CARTERA DE PASIVOS a fallado"
        End If
    Else
        Status_Dev = "1"
        Mensaje_Dev = "El proceso del devengamiento de la CARTERA DE PASIVOS a fallado"
        Retorno_Dev = ""
    End If

    Valor_antiguo = " "
    Valor_antiguo = "Fecha Proceso Devengo:" & Fecha_Proceso_Dev & ";Fecha Próximo Proceso:" & Fecha_Proximo_Dev & ";Mensaje=" & Mensaje_Dev

    Call GRABA_LOG_AUDITORIA(1, gsBac_Fecp, gsBac_IP, gsBac_User, "BTR", "Opc_40200", "01", "Devengo Cart Pas.", "mdrs", Valor_antiguo, " ")
End Sub

Private Sub Func_Cartera_InversionesDolar()
    Dim Sw_Devengo_Ok    As String
    Dim Msg_Devengo      As String

    MousePointer = 11

    Envia = Array(Format(Fecha_Proceso_Dev, "dd/mm/yyyy"), _
            Format(Fecha_Proximo_Dev, "dd/mm/yyyy"), _
            CDbl(valPCDUSD), _
            CDbl(valPCDUF), _
            CDbl(valPTF), _
            "S")

    Status_Dev = "0"

    If Bac_Sql_Execute("SP_DEVPROPIAINTER", Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            If Datos(1) <> "SI" Then
                Status_Dev = "2"
            End If
            Retorno_Dev = Datos(2)
        Loop

        If Status_Dev = "0" Then
            Mensaje_Dev = "Devengamiento de la CARTERA DE INVERSIONES DOLARES termino OK"
        Else
            Mensaje_Dev = "Devengamiento de la CARTERA DE INVERSIONES DOLARES ha fallado"
        End If
    Else
        Status_Dev = "1"
        Mensaje_Dev = "Devengamiento de la CARTERA DE INVERSIONES DOLARES ha fallado"
        Retorno_Dev = ""
    End If

    Valor_antiguo = " "
    Valor_antiguo = "Fecha Proceso Devengo:" & Fecha_Proceso_Dev & ";Fecha Próximo Proceso:" & Fecha_Proximo_Dev & ";Mensaje=" & Mensaje_Dev

    Call GRABA_LOG_AUDITORIA(1, gsBac_Fecp, gsBac_IP, gsBac_User, "BTR", "Opc_40200", "01", "Devengo Cart Inv. Dolar", "mdrs", Valor_antiguo, " ")
End Sub

Private Sub Func_Garantias(ByVal Dolares As Boolean)
    Dim Sw_Devengo_Ok       As String
    Dim Msg_Devengo         As String
    
    Let Me.MousePointer = vbHourglass
    
    Let Mensaje_Dev = "El Proceso del Devengamiento de GARANTIAS RECEPCIONADAS" & IIf(Dolares = True, " EN DOLARES", "") & ","
    Let Status_Dev = "0"
    
    Envia = Array()

    Call AddParam(Envia, Format(Fecha_Proceso_Dev, "yyyymmdd"))
    Call AddParam(Envia, Format(Fecha_Proximo_Dev, "yyyymmdd"))
    Call AddParam(Envia, CDbl(valPCDUSD))
    Call AddParam(Envia, CDbl(valPCDUF))
    Call AddParam(Envia, CDbl(valPTF))
    Call AddParam(Envia, IIf(Dolares = False, "N", "S"))

    If Bac_Sql_Execute("dbo.SP_DEVENGO_INSTRUEMNTOS_RECEPCIONADOS", Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            If Datos(1) <> "OK" Then
                Let Status_Dev = "2"
            End If
            Let Retorno_Dev = Datos(2)
        Loop

        If Status_Dev = "0" Then
            Let Mensaje_Dev = Mensaje_Dev & " Termino Ok."
        Else
            Let Mensaje_Dev = Mensaje_Dev & " A Fallado."
        End If
    Else
        Let Status_Dev = "1"
        Let Mensaje_Dev = Mensaje_Dev & " a fallado"
        Let Retorno_Dev = ""
    End If

    Let Valor_antiguo = " "
    Let Valor_antiguo = "Fecha Proceso:" & Fecha_Proceso_Dev & ";Fecha Proximo Proceso=" & Fecha_Proximo_Dev & ";Mensaje=" & Mensaje_Dev

    Call GRABA_LOG_AUDITORIA(1, gsBac_Fecp, gsBac_IP, gsBac_User, "BTR", "Opc_40200", "01", "Devengo de Garantias Recepcionadas", "mdrs", Valor_antiguo, " ")
End Sub


Private Sub Func_Compras_Con_Pacto()
    Dim Sw_Devengo_Ok       As String
    Dim Msg_Devengo         As String
    
    MousePointer = 11

    Envia = Array(Format(Fecha_Proceso_Dev, "yyyymmdd"), _
            Format(Fecha_Proximo_Dev, "yyyymmdd"), _
            CDbl(valPCDUSD), _
            CDbl(valPCDUF), _
            CDbl(valPTF), _
            "N", CDbl("0"))

    Status_Dev = "0"

    If Bac_Sql_Execute("SP_DEVENGO_COMPRAS_CON_PACTO", Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            If Datos(1) <> "OK" Then
                Status_Dev = "2"
            End If
            Retorno_Dev = Datos(2)
        Loop

        If Status_Dev = "0" Then
            Mensaje_Dev = "El proceso del Devengamiento de las COMPRAS CON PACTO termino OK"
        Else
            Mensaje_Dev = "El proceso del Devengamiento de las COMPRAS CON PACTO a fallado"
        End If
    Else
        Status_Dev = "1"
        Mensaje_Dev = "El proceso del devengamiento de las COMPRAS CON PACTO a fallado"
        Retorno_Dev = ""
    End If
     
    Valor_antiguo = " "
    Valor_antiguo = "Fecha Proceso:" & Fecha_Proceso_Dev & ";Fecha Proximo Proceso=" & Fecha_Proximo_Dev & ";Mensaje=" & Mensaje_Dev

    Call GRABA_LOG_AUDITORIA(1, gsBac_Fecp, gsBac_IP, gsBac_User, "BTR", "Opc_40200", "01", "Devengo Compras con Pacto", "mdrs", Valor_antiguo, " ")
End Sub

Private Sub Func_Compras_Con_PactoDolar()
    Dim Sw_Devengo_Ok    As String
    Dim Msg_Devengo      As String

    MousePointer = 11
    
    Envia = Array(Format(Fecha_Proceso_Dev, "dd/mm/yyyy"), _
            Format(Fecha_Proximo_Dev, "dd/mm/yyyy"), _
            CDbl(valPCDUSD), _
            CDbl(valPCDUF), _
            CDbl(valPTF), _
            "S", CDbl("0"))

    Status_Dev = "0"

    If Bac_Sql_Execute("SP_DEVENGO_COMPRAS_CON_PACTO", Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            If Datos(1) <> "OK" Then
                Status_Dev = "2"
            End If
            Retorno_Dev = Datos(2)
        Loop

        If Status_Dev = "0" Then
            Mensaje_Dev = "Devengamiento de las COMPRAS CON PACTO DOLARES termino OK"
        Else
            Mensaje_Dev = "Devengamiento de las COMPRAS CON PACTO DOLARES ha fallado"
        End If
    Else
        Status_Dev = "1"
        Mensaje_Dev = "Devengamiento de las COMPRAS CON PACTO DOLARES ha fallado"
        Retorno_Dev = ""
    End If
    Valor_antiguo = " "
    Valor_antiguo = "Fecha Proceso:" & Fecha_Proceso_Dev & ";Fecha Proximo Proceso=" & Fecha_Proximo_Dev & ";Mensaje=" & Mensaje_Dev

    Call GRABA_LOG_AUDITORIA(1, gsBac_Fecp, gsBac_IP, gsBac_User, "BTR", "Opc_40200", "01", "Devengo Compras con Pacto Dolar", "mdrs", Valor_antiguo, " ")
End Sub

Private Sub Func_Ventas_Con_Pacto()
    Dim Sw_Devengo_Ok    As String
    Dim Msg_Devengo      As String

    MousePointer = 11
    
    Envia = Array(Format(Fecha_Proceso_Dev, "yyyymmdd"), _
            Format(Fecha_Proximo_Dev, "yyyymmdd"), _
            "N")
    
    Status_Dev = "0"

    If Bac_Sql_Execute("SP_DEVENGO_VENTAS_CON_PACTO", Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            If Datos(1) <> "OK" Then
                Status_Dev = "2"
            End If
            Retorno_Dev = Datos(2)
        Loop
        If Status_Dev = "0" Then
            Mensaje_Dev = "El proceso del Devengamiento de las VENTAS CON PACTO termino OK"
        Else
            Mensaje_Dev = "El proceso del Devengamiento de las VENTAS CON PACTO a fallado"
        End If
    Else
        Status_Dev = "1"
        Mensaje_Dev = "El proceso del devengamiento de las VENTAS CON PACTO a fallado"
        Retorno_Dev = ""
    End If
     
    Valor_antiguo = " "
    Valor_antiguo = "Fecha Proceso = " & Fecha_Proceso_Dev & ";Fecha Proximo Devengo=" & Fecha_Proximo_Dev & ";Mensaje=" & Mensaje_Dev

    Call GRABA_LOG_AUDITORIA(1, gsBac_Fecp, gsBac_IP, gsBac_User, "BTR", "Opc_40200", "01", "Devengo Ventas con Pacto", "mdrs", Valor_antiguo, " ")
End Sub

Private Sub Func_Ventas_Con_PactoDolar()
    Dim Sw_Devengo_Ok    As String
    Dim Msg_Devengo      As String

    MousePointer = 11
    
    Envia = Array(Format(Fecha_Proceso_Dev, "dd/mm/yyyy"), _
            Format(Fecha_Proximo_Dev, "dd/mm/yyyy"), _
            "S")
    
    Status_Dev = "0"

    If Bac_Sql_Execute("SP_DEVENGO_VENTAS_CON_PACTO", Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            If Datos(1) <> "OK" Then
                Status_Dev = "2"
            End If
            Retorno_Dev = Datos(2)
        Loop
        If Status_Dev = "0" Then
            Mensaje_Dev = "Devengamiento de las VENTAS CON PACTO DOLAR termino OK"
        Else
            Mensaje_Dev = "Devengamiento de las VENTAS CON PACTO DOLAR ha fallado"
        End If
    Else
        Status_Dev = "1"
        Mensaje_Dev = "Devengamiento de las VENTAS CON PACTO DOLAR ha fallado"
        Retorno_Dev = ""
    End If
     
    Valor_antiguo = " "
    Valor_antiguo = "Fecha Proceso = " & Fecha_Proceso_Dev & ";Fecha Proximo Devengo=" & Fecha_Proximo_Dev & ";Mensaje=" & Mensaje_Dev

    Call GRABA_LOG_AUDITORIA(1, gsBac_Fecp, gsBac_IP, gsBac_User, "BTR", "Opc_40200", "01", "Devengo Ventas con Pacto Dolar", "mdrs", Valor_antiguo, " ")
End Sub

Private Sub Func_Interbancarios()
    Dim Sw_Devengo_Ok    As String
    Dim Msg_Devengo      As String

    MousePointer = 11
    
    Envia = Array(Format(Fecha_Proceso_Dev, "yyyymmdd"), _
                Format(Fecha_Proximo_Dev, "yyyymmdd"), _
                "N")

    Status_Dev = "0"
    
    If Bac_Sql_Execute("SP_DEVENGO_INTERBANCARIOS", Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            If Datos(1) <> "OK" Then
                Status_Dev = "2"
            End If
            Retorno_Dev = Datos(2)
        Loop
        If Status_Dev = "0" Then
            Mensaje_Dev = "El proceso del Devengamiento de los INTERBANCARIO termino OK"
        Else
            Mensaje_Dev = "El proceso del Devengamiento de los INTERBANCARIO a fallado"
        End If
    Else
        Status_Dev = "1"
        Mensaje_Dev = "El proceso del devengamiento de los INTERBANCARIO a fallado"
        Retorno_Dev = ""
    End If

    Valor_antiguo = " "
    Valor_antiguo = "Fecha Proceso:" & Fecha_Proceso_Dev & ";Fecha Proximo Proceso:" & Fecha_Proximo_Dev & ";Mensaje=" & Mensaje_Dev

    Call GRABA_LOG_AUDITORIA(1, gsBac_Fecp, gsBac_IP, gsBac_User, "BTR", "Opc_40200", "01", "Devengo Interbancarios ", "mdrs", Valor_antiguo, " ")
End Sub

Private Sub Func_InterbancariosDolar()
    Dim Sw_Devengo_Ok    As String
    Dim Msg_Devengo      As String

    MousePointer = 11

    Envia = Array(Format(Fecha_Proceso_Dev, "DD/MM/YYYY"), _
                Format(Fecha_Proximo_Dev, "DD/MM/YYYY"), _
                "S")

    Status_Dev = "0"
    
    If Bac_Sql_Execute("SP_DEVENGO_INTERBANCARIOS", Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            If Datos(1) <> "OK" Then
                Status_Dev = "2"
            End If
            Retorno_Dev = Datos(2)
        Loop
        If Status_Dev = "0" Then
            Mensaje_Dev = "Devengamiento de los INTERBANCARIO DOLARES termino OK"
        Else
            Mensaje_Dev = "Devengamiento de los INTERBANCARIO DOLARES ha fallado"
        End If
    Else
        Status_Dev = "1"
        Mensaje_Dev = "Devengamiento de los INTERBANCARIO DOLARES ha fallado"
        Retorno_Dev = ""
    End If

    Valor_antiguo = " "
    Valor_antiguo = "Fecha Proceso:" & Fecha_Proceso_Dev & ";Fecha Proximo Proceso:" & Fecha_Proximo_Dev & ";Mensaje=" & Mensaje_Dev
    
    Call GRABA_LOG_AUDITORIA(1, gsBac_Fecp, gsBac_IP, gsBac_User, "BTR", "Opc_40200", "01", "Devengo Interbancarios Dolar", "mdrs", Valor_antiguo, " ")
End Sub

Private Sub cmdDevengar_Click()
    Dim gsBac_FM As Date
    Dim iSwDev As Integer
    Dim Datos()
    
    Dim dev_CarteraInversiones  As Integer
    Dim dev_ComprasConPacto     As Integer
    Dim dev_Interbancarios      As Integer
    Dim dev_VentasConPacto      As Integer
    Dim dev_CarteraPasivos      As Integer
    Dim dev_Garantias           As Integer


    If Not Bac_Sql_Execute("SP_BUSCA_OPERACIONES_FLI") Then
        Exit Sub
    End If
    If Bac_SQL_Fetch(Datos()) Then
        If Datos(1) <> 0 Then
            MsgBox Datos(2), vbCritical
            Exit Sub
        End If
    End If

    iSwDev = 0

    gsBac_FM = CDate("01/" + Str(Month(gsBac_Fecp)) + "/" + Str(Year(gsBac_Fecp)))
    gsBac_FM = DateAdd("m", 1, gsBac_FM)
    gsBac_FM = DateAdd("d", -1, gsBac_FM)

    Fecha_Proceso_Dev = Fecha_Proceso
    Fecha_Proximo_Dev = Fecha_Cierre_Mes

    lstStatus.Clear

    If Fecha_Proceso_Dev = Fecha_Proximo_Dev Then
        iSwDev = 1
        Fecha_Proximo_Dev = Fecha_Proximo_Proceso
    End If

    valPCDUSD = Val(txtTasaEstimadaPCDUSD.text)
    valPCDUF = Val(txtTasaEstimadaPCDUF.text)
    valPTF = Val(txtTasaEstimadaPTF.text)

     dev_CarteraInversiones = chkCarteraInversiones.Value
        dev_ComprasConPacto = chkComprasConPacto.Value
         dev_Interbancarios = chkInterbancarios.Value
         dev_VentasConPacto = chkVentasConPacto.Value
         dev_CarteraPasivos = ChkCarteraPasivos.Value
              dev_Garantias = chkGarantias.Value

    Call Func_Devengar

    If gsBac_Fecp <> gsBac_FM And gsBac_Fecx > gsBac_FM Then
        chkCarteraInversiones.Value = dev_CarteraInversiones
           chkComprasConPacto.Value = dev_ComprasConPacto
            chkInterbancarios.Value = dev_Interbancarios
            chkVentasConPacto.Value = dev_VentasConPacto
                 chkGarantias.Value = dev_Garantias

        Call Func_DevengarDolar
    End If

    If Fecha_Cierre_Mes <> Fecha_Proximo_Proceso And iSwDev = 0 Then
        chkCarteraInversiones.Value = dev_CarteraInversiones
           chkComprasConPacto.Value = dev_ComprasConPacto
            chkInterbancarios.Value = dev_Interbancarios
            chkVentasConPacto.Value = dev_VentasConPacto
            ChkCarteraPasivos.Value = dev_CarteraPasivos
                 chkGarantias.Value = dev_Garantias

                  Fecha_Proceso_Dev = Fecha_Cierre_Mes
                  Fecha_Proximo_Dev = Fecha_Proximo_Proceso
        lstStatus.AddItem ""
        lstStatus.Refresh

        Call Func_Devengar
    End If

End Sub

Private Sub cmdSalir_Click()
    Unload Me
End Sub

Private Sub Form_Load()
    Me.Icon = BacTrader.Icon
    Me.Top = 0:     Me.Left = 0

    If Bac_Sql_Execute("SP_CHKFECHASDEVENGAMIENTO") Then
        Do While Bac_SQL_Fetch(Datos())
            Fecha_Proceso = Datos(1)
            Fecha_Proximo_Proceso = Datos(2)
            Fecha_Cierre_Mes = Datos(3)
            txtTasaEstimadaPCDUSD.text = Val(Datos(4))
            txtTasaEstimadaPCDUF.text = Val(Datos(5))
            txtTasaEstimadaPTF.text = Val(Datos(6))
            swDevengo = Datos(7)
            chkCarteraInversiones.Value = (Datos(7) = "1")
            chkComprasConPacto.Value = (Datos(8) = "1")
            chkVentasConPacto.Value = (Datos(9) = "1")
            chkInterbancarios.Value = (Datos(10) = "1")

            Let chkGarantias.Value = (Datos(12) = "1") '- Sw de Devengo de Garantias

            txtFechaProceso.text = Fecha_Proceso
            txtFechaProximoProceso.text = Fecha_Proximo_Proceso
            txtFechaCierreMes.text = Fecha_Cierre_Mes
        Loop
        lblFechaCierreMes.Enabled = (txtFechaProceso.text <> txtFechaCierreMes.text)
    End If
    
    Let chkGarantias.Visible = FuncHabilitaGarantias
    If chkGarantias.Visible = False Then
        chkGarantias.Value = True
    End If
    
End Sub

