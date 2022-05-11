VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacReproceso 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Reproceso de Inicio de Día"
   ClientHeight    =   3900
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4410
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   3900
   ScaleWidth      =   4410
   ShowInTaskbar   =   0   'False
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   510
      Top             =   4455
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   25
      ImageHeight     =   25
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   2
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacReproceso.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacReproceso.frx":0452
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   495
      Left            =   0
      TabIndex        =   11
      Top             =   0
      Width           =   4410
      _ExtentX        =   7779
      _ExtentY        =   873
      ButtonWidth     =   847
      ButtonHeight    =   820
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdProceso"
            Description     =   "Proceso"
            Object.ToolTipText     =   "Realizar Proceso"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmdSalir"
            Description     =   "Salir"
            Object.ToolTipText     =   "Salir de la ventana"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin VB.Frame Frame1 
      Enabled         =   0   'False
      Height          =   2115
      Left            =   100
      TabIndex        =   0
      Top             =   1650
      Width           =   4200
      Begin Threed.SSCheck ChkReCompra 
         Height          =   315
         Left            =   105
         TabIndex        =   1
         Top             =   930
         Width           =   2370
         _Version        =   65536
         _ExtentX        =   4180
         _ExtentY        =   556
         _StockProps     =   78
         Caption         =   "Recompras Automáticas"
         ForeColor       =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Font3D          =   1
      End
      Begin Threed.SSCheck ChkVencimientoCaptaciones 
         Height          =   315
         Left            =   105
         TabIndex        =   2
         Top             =   1575
         Width           =   2670
         _Version        =   65536
         _ExtentX        =   4710
         _ExtentY        =   556
         _StockProps     =   78
         Caption         =   "Vencimiento de Captaciones "
         ForeColor       =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Font3D          =   1
      End
      Begin Threed.SSCheck ChkReVenta 
         Height          =   315
         Left            =   105
         TabIndex        =   3
         Top             =   1245
         Width           =   2370
         _Version        =   65536
         _ExtentX        =   4180
         _ExtentY        =   556
         _StockProps     =   78
         Caption         =   "Reventas Automáticas"
         ForeColor       =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Font3D          =   1
      End
      Begin Threed.SSCheck ChkActualizarCartera 
         Height          =   315
         Left            =   105
         TabIndex        =   4
         Top             =   600
         Width           =   2370
         _Version        =   65536
         _ExtentX        =   4180
         _ExtentY        =   556
         _StockProps     =   78
         Caption         =   "Actualiza Cartera"
         ForeColor       =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Font3D          =   1
      End
      Begin Threed.SSCheck chkDevengamientoDolares 
         Height          =   315
         Left            =   105
         TabIndex        =   5
         Top             =   270
         Width           =   2370
         _Version        =   65536
         _ExtentX        =   4180
         _ExtentY        =   556
         _StockProps     =   78
         Caption         =   "Devengamiento Dolares"
         ForeColor       =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Font3D          =   1
      End
      Begin VB.Label lblCaptaciones 
         Alignment       =   2  'Center
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   315
         Left            =   2910
         TabIndex        =   14
         Top             =   1575
         Width           =   1125
      End
      Begin VB.Label lblReventas 
         Alignment       =   2  'Center
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   315
         Left            =   2910
         TabIndex        =   13
         Top             =   1245
         Width           =   1125
      End
      Begin VB.Label lblReCompras 
         Alignment       =   2  'Center
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   315
         Left            =   2910
         TabIndex        =   12
         Top             =   930
         Width           =   1125
      End
   End
   Begin Threed.SSFrame FrmFechas 
      Height          =   1095
      Left            =   105
      TabIndex        =   6
      Top             =   555
      Width           =   4185
      _Version        =   65536
      _ExtentX        =   7382
      _ExtentY        =   1931
      _StockProps     =   14
      Caption         =   " Fechas de Proceso "
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
      Begin BACControles.TXTFecha TxtFecProx 
         Height          =   315
         Left            =   2340
         TabIndex        =   7
         Top             =   330
         Width           =   1245
         _ExtentX        =   2196
         _ExtentY        =   556
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "07/11/2000"
      End
      Begin BACControles.TXTFecha TxtFecPro 
         Height          =   315
         Left            =   675
         TabIndex        =   8
         Top             =   330
         Width           =   1245
         _ExtentX        =   2196
         _ExtentY        =   556
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "07/11/2000"
      End
      Begin VB.Label Lbl_FecPro 
         Alignment       =   2  'Center
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   300
         Left            =   675
         TabIndex        =   10
         Top             =   690
         Width           =   1245
      End
      Begin VB.Label Lbl_FecPrx 
         Alignment       =   2  'Center
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   300
         Left            =   2340
         TabIndex        =   9
         Top             =   690
         Width           =   1245
      End
   End
End
Attribute VB_Name = "BacReproceso"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim Fecha_Proceso_Dev      As String         'Fecha Proceso del devengo
Dim Fecha_Proximo_Dev      As String         'Fecha Proximo Proceso del devengo
Dim valPCDUSD              As Double
Dim valPCDUF               As Double
Dim valPTF                 As Double

Dim Sql              As String
Dim Datos()

'Devengamiento en Dolares
Private Function Func_Devengamiento_Dolares() As Boolean

   Func_Devengamiento_Dolares = False

   If Not Func_Cartera_Inversiones() Then
      Exit Function

   End If

   If Not Func_Compras_Con_Pacto() Then
      Exit Function

   End If

   Func_Devengamiento_Dolares = True

End Function

Private Function Func_Actualizar_Cartera() As Boolean

    Func_Actualizar_Cartera = False

   ' ACTUALIZACION DE CARTERA
'    Sql = "SP_ACTUALIZA_CARTERA"

    If Bac_Sql_Execute("SP_ACTUALIZA_CARTERA") Then
        Do While Bac_SQL_Fetch(Datos())
            If Datos(1) <> "SI" Then
                Screen.MousePointer = vbDefault
                MsgBox Datos(2), vbCritical, gsBac_Version
                Exit Function
            End If
        Loop
    End If

    Func_Actualizar_Cartera = True

End Function

Private Function Func_ReCompra() As Boolean

    Func_ReCompra = False

'    Sql = "SP_RECOMPRA_AUTOMATICA " & "'" & gsBac_User & "','" & gsBac_Term & "'"

    Screen.MousePointer = vbHourglass
   
    Envia = Array(gsBac_User, gsBac_Term)
    
    If Not Bac_Sql_Execute("SP_RECOMPRA_AUTOMATICA", Envia) Then
        Screen.MousePointer = vbDefault
        Exit Function
    End If

    If Bac_SQL_Fetch(Datos()) Then
        MsgBox "Problemas con respuesta de proceso " & Sql, vbCritical, gsBac_Version
        Exit Function
    End If

    If Datos(1) = "NO" Then
        Screen.MousePointer = vbDefault
        MsgBox Datos(2), vbCritical, gsBac_Version
        Exit Function
    End If

    Screen.MousePointer = vbDefault

    Func_ReCompra = True

End Function

Private Function Func_ReVenta() As Boolean

    Func_ReVenta = False

'   Sql = "SP_REVENTA_AUTOMATICA " & "'" & gsBac_User & "','" & gsBac_Term & "'"

    Screen.MousePointer = vbHourglass
   
    Envia = Array(gsBac_User, gsBac_Term)
   
    If Not Bac_Sql_Execute("SP_REVENTA_AUTOMATICA", Envia) Then
        Screen.MousePointer = vbDefault
        Exit Function
    End If

    If Bac_SQL_Fetch(Datos()) Then
        MsgBox "Problemas con respuesta de proceso " & Sql, vbCritical, gsBac_Version
        Exit Function
    End If

    If Datos(1) = "NO" Then
        Screen.MousePointer = vbDefault
        MsgBox Datos(2), vbCritical, gsBac_Version
        Exit Function
    Else
        Lbl_FecPro.Caption = Lbl_FecPro.Caption & " " & Left(Datos(2), 11)
    End If

    Screen.MousePointer = vbDefault

    Func_ReVenta = True

End Function

Private Function Func_Vencimiento_Captaciones() As Boolean

    Func_Vencimiento_Captaciones = False

'    Sql = "SP_PROCESAVENCIMIENTOS " & "'" & gsBac_User & "','" & gsBac_Term & "'"

    Screen.MousePointer = vbHourglass
   
    Envia = Array(gsBac_User, gsBac_Term)
    
    If Not Bac_Sql_Execute("SP_PROCESAVENCIMIENTOS", Envia) Then
        Screen.MousePointer = vbDefault
        Exit Function
    End If

    If Bac_SQL_Fetch(Datos()) Then
        MsgBox "Problemas con respuesta de proceso " & Sql, vbCritical, gsBac_Version
        Exit Function
    End If

    If Datos(1) = "NO" Then
        Screen.MousePointer = vbDefault
        MsgBox Datos(2), vbCritical, gsBac_Version
        Exit Function
    Else
      'Label3.Caption = Label3.Caption & " " & Left(Datos(2), 11)
        lblCaptaciones.Caption = lblCaptaciones.Caption & " " & Left(Datos(2), 11)
    End If

    Screen.MousePointer = vbDefault

    Func_Vencimiento_Captaciones = True

End Function

Private Function Func_Cartera_Inversiones() As Boolean

    Func_Cartera_Inversiones = False
   
'   Sql = "SP_DEVPROPIAINTER "
'   Sql = Sql & "'" & Format(Fecha_Proceso_Dev, "dd/mm/yyyy") & "',"
'   Sql = Sql & "'" & Format(Fecha_Proximo_Dev, "dd/mm/yyyy") & "',"
'   Sql = Sql & BacFormatoSQL(valPCDUSD) & ", "
'   Sql = Sql & BacFormatoSQL(valPCDUF) & ", "
'   Sql = Sql & BacFormatoSQL(valPTF) & ", 'S'"

    Envia = Array(Format(Fecha_Proceso_Dev, "dd/mm/yyyy"), _
            Format(Fecha_Proximo_Dev, "dd/mm/yyyy"), _
            CDbl(valPCDUSD), _
            CDbl(valPCDUF), _
            CDbl(valPTF), _
            "S")

    If Bac_Sql_Execute("SP_DEVPROPIAINTER", Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            If Datos(1) <> "SI" Then
                MsgBox "El proceso del devengamiento de la CARTERA DE INVERSIONES a fallado", vbExclamation, Me.Caption
                Exit Function
            End If
        Loop
    Else
      'Problema en la ejecución del procedimiento
        MsgBox "El proceso del devengamiento de la CARTERA DE INVERSIONES a fallado", vbExclamation, Me.Caption
        Exit Function
    End If

    MsgBox "El proceso del devengamiento de la CARTERA DE INVERSIONES termino OK", vbInformation, Me.Caption

    Func_Cartera_Inversiones = True

End Function

Private Function Func_Compras_Con_Pacto() As Boolean

   Func_Compras_Con_Pacto = False

   'Ejecución del proceso de devengamiento de las compras con pacto
'   Sql = "SP_DEVENGO_COMPRAS_CON_PACTO "
'   Sql = Sql & "'" & Format(Fecha_Proceso_Dev, "dd/mm/yyyy") & "',"
'   Sql = Sql & "'" & Format(Fecha_Proximo_Dev, "dd/mm/yyyy") & "',"
'   Sql = Sql & BacFormatoSQL(valPCDUSD) & ", "
'   Sql = Sql & BacFormatoSQL(valPCDUF) & ", "
'   Sql = Sql & BacFormatoSQL(valPTF) & ", 'S'"

    Envia = Array(Format(Fecha_Proceso_Dev, "dd/mm/yyyy"), _
            Format(Fecha_Proximo_Dev, "dd/mm/yyyy"), _
            CDbl(valPCDUSD), _
            CDbl(valPCDUF), _
            CDbl(valPTF), _
            "S")
   
    If Bac_Sql_Execute("SP_DEVENGO_COMPRAS_CON_PACTO", Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            If Datos(1) <> "OK" Then
                MsgBox "El proceso del devengamiento de las COMPRAS CON PACTO a fallado", vbExclamation, Me.Caption
                Exit Function
            End If
            lblReCompras = Datos(2)
         'Retorno_Dev = Datos(2)
        Loop
    Else
      'Problema en la ejecución del procedimiento
        MsgBox "El proceso del devengamiento de las COMPRAS CON PACTO a fallado", vbExclamation, Me.Caption
        Exit Function
    End If

    MsgBox "El proceso del devengamiento de las COMPRAS CON PACTO termino OK", vbInformation, Me.Caption

End Function

Private Function Func_ChequeaCaptaciones() As Boolean

    Func_ChequeaCaptaciones = False

'   Sql = "SP_CHKCAPTACIONES"

    If Bac_Sql_Execute("SP_CHKCAPTACIONES") Then
        Do While Bac_SQL_Fetch(Datos())
            If Datos(1) = 0 Then
                Exit Function
            End If
        Loop
    End If
            
    Func_ChequeaCaptaciones = True

End Function

Function Func_TotalOperaciones(sTipOper) As String

    Func_TotalOperaciones = "Reg. : 0"

'   Sql = "SP_CHKCANTIDADOPERACIONES '" & sTipOper & "'"

    Envia = Array(sTipOper)

    If Bac_Sql_Execute("SP_CHKCANTIDADOPERACIONES", Envia) Then
        Do While Bac_SQL_Fetch(Datos())
            Func_TotalOperaciones = "Reg. : " & Datos(1)
        Loop
    End If

End Function

Private Sub Form_Load()
Dim sSwReCompra            As String
Dim sSwReVenta             As String

    Me.Icon = BacTrader.Icon
    Me.Top = 0
    Me.Left = 0
    
    TxtFecPro.Text = gsBac_Fecp
    TxtFecProx.Text = gsBac_Fecx

    Lbl_FecPro.Caption = BacDiaSem(TxtFecPro.Text)
    Lbl_FecPrx.Caption = BacDiaSem(TxtFecProx.Text)

'    Sql = "SP_CHKFECHASDEVENGAMIENTO"

    If Bac_Sql_Execute("SP_CHKFECHASDEVENGAMIENTO") Then
        Do While Bac_SQL_Fetch(Datos())
            Fecha_Proceso_Dev = Datos(1)
            Fecha_Proximo_Dev = Datos(2)
            valPCDUSD = Val(Datos(4))
            valPCDUF = Val(Datos(5))
            valPTF = Val(Datos(6))
        Loop
    End If

'    Sql = "SP_SW_PARAMETROS"

    If Bac_Sql_Execute("SP_SW_PARAMETROS") Then
        Do While Bac_SQL_Fetch(Datos())
            sSwReCompra = Datos(2)
            sSwReVenta = Datos(3)
        Loop
    End If

    If sSwReCompra = "1" Then
        lblReCompras.Caption = Func_TotalOperaciones("RC")
        chkDevengamientoDolares.Value = True
        ChkActualizarCartera.Value = True
        ChkReCompra.Value = True
    End If

    If sSwReVenta = "1" Then
        lblReventas.Caption = Func_TotalOperaciones("RV")
        chkDevengamientoDolares.Value = True
        ChkActualizarCartera.Value = True
        ChkReVenta.Value = True
    End If

    If Not Func_ChequeaCaptaciones() Then
        ChkVencimientoCaptaciones.Value = True
        lblCaptaciones.Caption = Func_TotalOperaciones("IC")
    End If

    If ChkReCompra.Value And ChkReVenta.Value And ChkVencimientoCaptaciones.Value Then
        Toolbar1.Buttons(2).Enabled = False
    Else
        Toolbar1.Buttons(2).Enabled = True
    End If

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

   Dim bSigue              As Boolean

   Select Case UCase(Button.Description)
   Case "PROCESAR"
      bSigue = True
      If Not chkDevengamientoDolares.Value Then
         bSigue = Func_Devengamiento_Dolares

      End If

      If Not ChkActualizarCartera.Value And bSigue Then
         bSigue = Func_Actualizar_Cartera

      End If

      If Not ChkReCompra.Value Then
         bSigue = Func_ReCompra
         lblReCompras.Caption = Func_TotalOperaciones("RC")

      End If

      If Not ChkReVenta.Value Then
         bSigue = Func_ReVenta
         lblReventas.Caption = Func_TotalOperaciones("RV")

      End If

      If Not ChkVencimientoCaptaciones.Value Then
         bSigue = Func_Vencimiento_Captaciones
         lblCaptaciones.Caption = Func_TotalOperaciones("IC")

      End If

   Case "SALIR"
      Unload Me

   End Select

End Sub
