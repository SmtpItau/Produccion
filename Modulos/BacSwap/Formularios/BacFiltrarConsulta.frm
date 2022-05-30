VERSION 5.00
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "comctl32.ocx"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacFiltrarConsulta 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Filtro Consulta "
   ClientHeight    =   5340
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   8955
   Icon            =   "BacFiltrarConsulta.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5340
   ScaleWidth      =   8955
   ShowInTaskbar   =   0   'False
   Begin ComctlLib.Toolbar Toolbar1 
      Height          =   480
      Left            =   0
      TabIndex        =   35
      Top             =   0
      Width           =   8955
      _ExtentX        =   15796
      _ExtentY        =   847
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   327682
      BeginProperty Buttons {0713E452-850A-101B-AFC0-4210102A8DA7} 
         NumButtons      =   2
         BeginProperty Button1 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   ""
            Object.ToolTipText     =   "Aceptar"
            Object.Tag             =   ""
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   ""
            Object.ToolTipText     =   "Cancelar"
            Object.Tag             =   ""
            ImageIndex      =   2
         EndProperty
      EndProperty
   End
   Begin VB.CommandButton btnCancelar 
      Caption         =   "&Cancelar"
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   780
      Left            =   7650
      Picture         =   "BacFiltrarConsulta.frx":0442
      Style           =   1  'Graphical
      TabIndex        =   20
      Top             =   6945
      Visible         =   0   'False
      Width           =   1230
   End
   Begin VB.CommandButton btnAceptar 
      Caption         =   "&Aceptar"
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   780
      Left            =   6390
      Picture         =   "BacFiltrarConsulta.frx":0884
      Style           =   1  'Graphical
      TabIndex        =   0
      Top             =   6930
      Visible         =   0   'False
      Width           =   1230
   End
   Begin VB.Frame Frame1 
      Caption         =   " Consulta de...  "
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
      Height          =   2385
      Index           =   3
      Left            =   6165
      TabIndex        =   23
      Top             =   2895
      Width           =   2715
      Begin VB.OptionButton optPosicionVctos 
         Caption         =   "Posición por Vencimientos"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00808000&
         Height          =   225
         Left            =   135
         TabIndex        =   30
         Top             =   2160
         Visible         =   0   'False
         Width           =   2445
      End
      Begin VB.OptionButton optOpVencidas 
         Caption         =   "Operaciones Vencidas"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00808000&
         Height          =   225
         Left            =   225
         TabIndex        =   19
         Top             =   1800
         Width           =   2445
      End
      Begin VB.OptionButton optOpVigente 
         Caption         =   "Operaciones Vigentes"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00808000&
         Height          =   225
         Left            =   225
         TabIndex        =   18
         Top             =   1335
         Width           =   2445
      End
      Begin VB.OptionButton optOpHistorica 
         Caption         =   "Operaciones Historicas"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00808000&
         Height          =   225
         Left            =   225
         TabIndex        =   17
         Top             =   870
         Width           =   2445
      End
      Begin VB.OptionButton optOpDia 
         Caption         =   "Operaciones del Día"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00808000&
         Height          =   225
         Left            =   225
         TabIndex        =   16
         Top             =   405
         Width           =   2445
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   " Ordenado Por...  "
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
      Height          =   2355
      Index           =   2
      Left            =   6165
      TabIndex        =   22
      Top             =   495
      Width           =   2715
      Begin VB.OptionButton optCliente 
         Caption         =   "Cliente"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00808000&
         Height          =   225
         Left            =   225
         TabIndex        =   12
         ToolTipText     =   "Nombre"
         Top             =   465
         Width           =   1860
      End
      Begin VB.OptionButton optMoneda 
         Caption         =   "Moneda"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00808000&
         Height          =   225
         Left            =   225
         TabIndex        =   13
         Top             =   930
         Width           =   2220
      End
      Begin VB.OptionButton optFechaOper 
         Caption         =   "Fecha Operación"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00808000&
         Height          =   225
         Left            =   225
         TabIndex        =   14
         ToolTipText     =   "Fecha de Cierre Operación"
         Top             =   1395
         Width           =   2220
      End
      Begin VB.OptionButton optFechaVcto 
         Caption         =   "Fecha Vencimiento"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00808000&
         Height          =   225
         Left            =   225
         TabIndex        =   15
         ToolTipText     =   "Fecha Término Operación"
         Top             =   1860
         Width           =   2220
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "  Filtros  "
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
      Height          =   4785
      Index           =   0
      Left            =   30
      TabIndex        =   21
      Top             =   510
      Width           =   6045
      Begin VB.Frame Frame1 
         Height          =   1170
         Index           =   6
         Left            =   180
         TabIndex        =   26
         Top             =   3540
         Width           =   5685
         Begin BACControles.TXTFecha fecHasta 
            Height          =   255
            Left            =   3645
            TabIndex        =   34
            Top             =   360
            Width           =   1440
            _ExtentX        =   2540
            _ExtentY        =   450
            Enabled         =   -1  'True
            Enabled         =   -1  'True
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            MaxDate         =   2958465
            MinDate         =   -328716
            Text            =   "25/10/2000"
         End
         Begin BACControles.TXTFecha fecDesde 
            Height          =   255
            Left            =   1920
            TabIndex        =   33
            Top             =   360
            Width           =   1410
            _ExtentX        =   2487
            _ExtentY        =   450
            Enabled         =   -1  'True
            Enabled         =   -1  'True
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            MaxDate         =   2958465
            MinDate         =   -328716
            Text            =   "25/10/2000"
         End
         Begin VB.OptionButton optFecVenc 
            Caption         =   "Fecha Vencimiento"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00808000&
            Height          =   225
            Left            =   3630
            TabIndex        =   11
            Top             =   810
            Width           =   1965
         End
         Begin VB.OptionButton optFechaProc 
            Caption         =   "Fecha Proceso"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00808000&
            Height          =   195
            Left            =   1920
            TabIndex        =   10
            Top             =   810
            Width           =   2445
         End
         Begin VB.CheckBox chkEntreFec 
            Caption         =   "Entre Fechas "
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00808000&
            Height          =   420
            Left            =   270
            TabIndex        =   9
            Top             =   270
            Width           =   1365
         End
      End
      Begin VB.Frame Frame1 
         Height          =   1860
         Index           =   5
         Left            =   180
         TabIndex        =   25
         Top             =   1680
         Width           =   5685
         Begin BACControles.TXTFecha fecFechaVcto 
            Height          =   255
            Left            =   1920
            TabIndex        =   32
            Top             =   1440
            Width           =   1410
            _ExtentX        =   2487
            _ExtentY        =   450
            Enabled         =   -1  'True
            Enabled         =   -1  'True
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            MaxDate         =   2958465
            MinDate         =   -328716
            Text            =   "25/10/2000"
         End
         Begin BACControles.TXTFecha fecFechaProceso 
            Height          =   255
            Left            =   1920
            TabIndex        =   31
            Top             =   1080
            Width           =   1410
            _ExtentX        =   2487
            _ExtentY        =   450
            Enabled         =   -1  'True
            Enabled         =   -1  'True
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            MaxDate         =   2958465
            MinDate         =   -328716
            Text            =   "25/10/2000"
         End
         Begin VB.TextBox txtCliente 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   330
            Left            =   1935
            TabIndex        =   4
            Top             =   225
            Width           =   3480
         End
         Begin VB.ComboBox cmbMonedas 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   315
            Left            =   1935
            Style           =   2  'Dropdown List
            TabIndex        =   6
            Top             =   630
            Width           =   3480
         End
         Begin VB.CheckBox chkMoneda 
            Caption         =   "Moneda"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00808000&
            Height          =   240
            Left            =   270
            TabIndex        =   5
            Top             =   675
            Width           =   1050
         End
         Begin VB.CheckBox chkFechaProc 
            Caption         =   "Fecha Proceso"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00808000&
            Height          =   375
            Left            =   270
            TabIndex        =   7
            Top             =   990
            Width           =   1680
         End
         Begin VB.CheckBox chkFechaVecto 
            Caption         =   "Fecha Vcto."
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00808000&
            Height          =   420
            Left            =   270
            TabIndex        =   8
            Top             =   1350
            Width           =   1365
         End
         Begin VB.CheckBox chkCliente 
            Caption         =   "Cliente"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00808000&
            Height          =   240
            Left            =   270
            TabIndex        =   3
            Top             =   270
            Width           =   1050
         End
      End
      Begin VB.Frame Frame1 
         Height          =   1410
         Index           =   4
         Left            =   180
         TabIndex        =   24
         Top             =   270
         Width           =   5685
         Begin VB.CheckBox chkTodos 
            Caption         =   "Todas"
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
            Height          =   240
            Left            =   1935
            TabIndex        =   2
            Top             =   705
            Width           =   1050
         End
         Begin VB.ComboBox cmbPosicion 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   315
            Left            =   1935
            Style           =   2  'Dropdown List
            TabIndex        =   1
            Top             =   300
            Width           =   3480
         End
         Begin VB.ComboBox cmbEntidad 
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   315
            Left            =   1935
            Style           =   2  'Dropdown List
            TabIndex        =   29
            Top             =   975
            Visible         =   0   'False
            Width           =   3480
         End
         Begin VB.Label Etiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Posición"
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
            Height          =   240
            Index           =   1
            Left            =   270
            TabIndex        =   28
            Top             =   390
            Width           =   915
         End
         Begin VB.Label Etiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Entidad"
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
            Height          =   240
            Index           =   0
            Left            =   270
            TabIndex        =   27
            Top             =   930
            Visible         =   0   'False
            Width           =   810
         End
      End
   End
   Begin ComctlLib.ImageList ImageList1 
      Left            =   2250
      Top             =   6030
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   327682
      BeginProperty Images {0713E8C2-850A-101B-AFC0-4210102A8DA7} 
         NumListImages   =   2
         BeginProperty ListImage1 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "BacFiltrarConsulta.frx":0CC6
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "BacFiltrarConsulta.frx":0FE0
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "BacFiltrarConsulta"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim colFechas As New Collection
Dim colOrdenado As New Collection
Dim colConsulta As New Collection
Dim colFechasChk As New Collection

Private ObjConsulta As Object

Dim TipoSwap As Integer
Dim TipOper As Integer
Dim Cond As Integer
Dim Ord As Integer
Dim codcli As Double
Dim RutCli As Double
Dim CodMon As Integer
Dim OpcFec As Integer
Dim FechaD As String 'Date
Dim FechaH As String 'Date

Dim Frase As String

Function Inicializar()

    TipoSwap = 0
    TipOper = 0
    Cond = 0
    Ord = 0
    codcli = 0
    CodMon = 0
    OpcFec = 0
    FechaD = fecFechaProceso.Text 'As Date
    FechaH = fecFechaProceso.Text  'As Date

End Function

Function ValidaDatos() As Boolean
Dim MiObjeto
Dim pos As Integer
'Validacion de datos y traspaso de estos a Variables

    Call Inicializar    'Limpia variables
    
    ValidaDatos = False
    
    If chkCliente.Value = 1 And txtCliente = "" Then
        MsgBox "Debe ingresar Cliente", vbCritical, Msj
        txtCliente.SetFocus
        Exit Function
    End If
    If txtCliente.Tag <> "" Then
       codcli = txtCliente.Tag
    End If
    If optCliente.Tag <> "" Then
       RutCli = optCliente.Tag
    End If
    
    
    If cmbPosicion.ListIndex <> -1 And chkTodos.Value = 0 Then
        TipoSwap = cmbPosicion.ItemData(cmbPosicion.ListIndex)
    End If
    
    If chkMoneda.Value = 1 And cmbMonedas.ListIndex <> -1 Then
        CodMon = cmbMonedas.ItemData(cmbMonedas.ListIndex)
    End If
    
    pos = 1
    For Each MiObjeto In colConsulta
        If MiObjeto.Value = True Then
            TipOper = pos
            Exit For
        End If
        pos = pos + 1
    Next MiObjeto
    
    Select Case pos
        Case 1
            Frase = "Consulta Operaciones del Día"
        Case 2
            Frase = "Consulta Operaciones Históricas"
        Case 3
            Frase = "Consulta Operaciones Vigentes"
        Case 4
            Frase = "Consulta Operaciones Vencidas"
    End Select
    
    
    pos = 1
    For Each MiObjeto In colOrdenado
        If MiObjeto.Value = True Then
            Ord = pos
            Exit For
        End If
        pos = pos + 1
    Next MiObjeto
    
    Select Case pos
        Case 1
            Frase = Frase & " Ordenado por Cliente"
        Case 2
            Frase = Frase & " Ordenado por Moneda"
        Case 3
            Frase = Frase & " Ordenado por Fecha de Operación"
        Case 4
            Frase = Frase & " Ordenado por Fecha Vencimiento"
    End Select
    
    If chkFechaProc.Value = 1 Then
        OpcFec = 1
        FechaD = fecFechaProceso.Text
    End If
    If chkFechaVecto.Value = 1 Then
        OpcFec = 2
        FechaH = fecFechaVcto.Text
    End If
    
    If chkEntreFec.Value = 1 Then
        If optFechaProc.Value = True Then
            OpcFec = 3
        ElseIf optFecVenc.Value = True Then
            OpcFec = 4
        End If
        FechaD = fecDesde.Text
        FechaH = fecHasta.Text
    End If
    
    ValidaDatos = True

End Function

Private Sub btnAceptar_Click()

    If ValidaDatos() Then
        Call Filtrar
        btnCancelar_Click
    End If

End Sub

Function Filtrar()

Dim ConsultaDatos As New clsConsultasSwaps
Dim Filas   As Long
Dim Max     As Long
Dim m, j As Long
Dim NumPaso As Double

BacConsultaOper.grdConsulta.Cols = 21
Call BacLimpiaGrilla(BacConsultaOper.grdConsulta)

BacConsultaOper.grdConsulta.Tag = "NO" 'Grilla no tiene datos
swModTipoOpe = 0    'para discriminar la tabla
With ConsultaDatos
    .Operacion = TipOper    ' tabla
    .TipOp = TipoSwap       ' tipo de swap
    .Condicion = Cond
    .Orden = Ord
    .CodCliente = codcli
    .RutCliente = RutCli
    .CodMoneda = CodMon
    .OpcFecha = OpcFec
    .Fecha1 = FechaD
    .Fecha2 = FechaH

    If Not .ConsultaDatos Then
        Set ConsultaDatos = Nothing
        MsgBox "No existen datos con Parámetros seleccionados", vbExclamation, Msj
        Exit Function
        
    End If
    
   Max = .coleccion.Count
   swModTipoOpe = TipOper                  'Tabla de donde saca datos
    
   NumPaso = 0
   Filas = 1
   For m = 1 To Max
        If NumPaso <> (.coleccion(m).NumOperacion) Then
            BacConsultaOper.grdConsulta.TextMatrix(Filas, 0) = (.coleccion(m).TipProd)
            BacConsultaOper.grdConsulta.TextMatrix(Filas, 1) = (.coleccion(m).NumOperacion)
            BacConsultaOper.grdConsulta.TextMatrix(Filas, 2) = (.coleccion(m).TipoOperacion)
            BacConsultaOper.grdConsulta.TextMatrix(Filas, 3) = (.coleccion(m).Cliente)
            BacConsultaOper.grdConsulta.TextMatrix(Filas, 4) = (.coleccion(m).FechaInicio)
            BacConsultaOper.grdConsulta.TextMatrix(Filas, 5) = (.coleccion(m).FechaVenc)
            BacConsultaOper.grdConsulta.TextMatrix(Filas, 6) = (.coleccion(m).MonedaOp)
            BacConsultaOper.grdConsulta.TextMatrix(Filas, 7) = Format((.coleccion(m).MontoOp), "###,###,###,##0.#0")
            BacConsultaOper.grdConsulta.TextMatrix(Filas, 8) = (.coleccion(m).TasaBase)
            BacConsultaOper.grdConsulta.TextMatrix(Filas, 9) = Format((.coleccion(m).MontoConv), "###,###,###,##0.#0")
            BacConsultaOper.grdConsulta.TextMatrix(Filas, 10) = (.coleccion(m).TasaConv)
            BacConsultaOper.grdConsulta.TextMatrix(Filas, 11) = (.coleccion(m).Modalidad)
        '    BacConsultaOper.grdConsulta.TextMatrix(Filas, 12) = (.coleccion(Filas).FechaCierre)
            BacConsultaOper.grdConsulta.TextMatrix(Filas, 15) = (.coleccion(m).Area_Responsable)
            BacConsultaOper.grdConsulta.TextMatrix(Filas, 16) = (.coleccion(m).Cartera_Normativa)
            BacConsultaOper.grdConsulta.TextMatrix(Filas, 17) = (.coleccion(m).SubCartera_Normativa)
            BacConsultaOper.grdConsulta.TextMatrix(Filas, 18) = (.coleccion(m).Libro)
            BacConsultaOper.grdConsulta.TextMatrix(Filas, 19) = RutSinDV((.coleccion(m).RutCliente))    'PROD-10967
            BacConsultaOper.grdConsulta.TextMatrix(Filas, 20) = (.coleccion(m).CodigoCliente)           'PROD-10967
        
              If Filas > 13 Then
                      BacConsultaOper.grdConsulta.Rows = BacConsultaOper.grdConsulta.Rows + 1
              End If
              
            BacConsultaOper.grdConsulta.Tag = "SI"      'Grilla tiene datos
            
            NumPaso = (.coleccion(m).NumOperacion)
            Filas = Filas + 1
        End If
   Next m
   
   
  ' Select Case TipOper
  ' Case 1
        BacConsultaOper.Label1.Caption = Frase ' "Consulta de Operaciones del Día"
  ' Case 2
  '      BacConsultaOper.Label1.Caption = "Consulta de Operaciones Históricas"
  ' Case 3
  '      BacConsultaOper.Label1.Caption = "Consulta de Operaciones Vigentes"
  ' Case 4
  '      BacConsultaOper.Label1.Caption = "Consulta de Operaciones Vencidas"
  ' End Select
    
End With

End Function

Private Function RutSinDV(ByVal recRut As String) As String
'PROD-10967
Dim p As Integer
Dim l As Integer
Dim I As Integer
Dim xRut As String
RutSinDV = ""
xRut = Trim(recRut)
l = Len(xRut)
p = 0
For I = l To 1 Step -1
    If Mid$(xRut, I, 1) = "-" Then
        p = I
        Exit For
    End If
Next
If p = 0 Then
    RutSinDV = xRut
Else
    RutSinDV = Mid$(xRut, 1, p - 1)
End If
End Function


Private Sub btnCancelar_Click()

    Unload BacFiltrarConsulta

End Sub

Private Sub chkEntreFec_Click()

    If chkEntreFec.Value = 1 Then
        chkFechaProc.Value = 0
        chkFechaVecto.Value = 0
        optFechaProc.Value = True
    End If

End Sub

Private Sub chkFechaProc_Click()

    If chkFechaProc.Value = 1 Then
        chkFechaVecto.Value = 0
        chkEntreFec.Value = 0
        optFechaProc.Value = False
        optFecVenc.Value = False
        optFecVenc.ForeColor = &H808000
        optFechaProc.ForeColor = &H808000
    End If
   


End Sub

Private Sub chkFechaVecto_Click()

    If chkFechaVecto.Value = 1 Then
        chkFechaProc.Value = 0
        chkEntreFec.Value = 0
        optFechaProc.Value = False
        optFecVenc.Value = False
        optFecVenc.ForeColor = &H808000
        optFechaProc.ForeColor = &H808000
    End If

End Sub

Private Sub chkMoneda_Click()

    If chkMoneda.Value = 1 Then
        cmbMonedas.ListIndex = 0
    Else
        cmbMonedas.ListIndex = -1
    End If

End Sub

Private Sub chkTodos_Click()

    'If chkTodos.Value = 1 Then
    '    cmbPosicion.ListIndex = 0
    'Else
    '    cmbPosicion.ListIndex = -1
    'End If


End Sub

Private Sub cmbPosicion_Click()

    'chkTodos.Value = 0

End Sub

Private Sub Form_Load()
   Me.Icon = BACSwap.Icon
   
    'Para opcion Entre Fechas
    colFechas.Add Item:=optFechaProc, Key:=CStr(1)
    colFechas.Add Item:=optFecVenc, Key:=CStr(2)
    
    'Para opcion Ordenado Por...
    colOrdenado.Add Item:=optCliente, Key:=CStr(1)
    colOrdenado.Add Item:=optMoneda, Key:=CStr(2)
    colOrdenado.Add Item:=optFechaOper, Key:=CStr(3)
    colOrdenado.Add Item:=optFechaVcto, Key:=CStr(4)
    
    
    'Para opcion Consulta De ...
    colConsulta.Add Item:=optOpDia, Key:=CStr(1)
    colConsulta.Add Item:=optOpHistorica, Key:=CStr(2)
    colConsulta.Add Item:=optOpVigente, Key:=CStr(3)
    colConsulta.Add Item:=optOpVencidas, Key:=CStr(4)
    colConsulta.Add Item:=optPosicionVctos, Key:=CStr(5)

    'Para habilitar fechas
    colFechasChk.Add Item:=chkFechaProc, Key:=CStr(1)
    colFechasChk.Add Item:=chkFechaVecto, Key:=CStr(2)
    colFechasChk.Add Item:=chkEntreFec, Key:=CStr(3)
    
    
    
    fecFechaProceso.Text = Format(gsBAC_Fecp, gsc_FechaDMA)
    fecFechaVcto.Text = Format(gsBAC_Fecp, gsc_FechaDMA)
    fecDesde.Text = Format(gsBAC_Fecp, gsc_FechaDMA)
    fecHasta.Text = Format(gsBAC_Fecp, gsc_FechaDMA)
    
    
     '------------- Monedas
    Call LlenaComboCodGeneral(cmbMonedas, 0, Sistema, 2)
    
     '------------- Tipo de Swaps
    Call LlenaComboCodGeneral(cmbPosicion, MDTC_TIPOSWAP, Sistema, 1)
    
    If cmbMonedas.ListCount = 0 Then
        chkMoneda.Enabled = False
        cmbMonedas.Enabled = False
    End If
    If cmbPosicion.ListCount = 0 Then
        cmbPosicion.Enabled = False
    End If
    
    optOpDia.Value = True
    
End Sub

Private Sub Form_Unload(Cancel As Integer)

Set colFechas = Nothing
Set colOrdenado = Nothing
Set colConsulta = Nothing
Set colFechasChk = Nothing


End Sub

Private Sub optCliente_Click()

    Call ColorOptionButton(colOrdenado, optCliente)

End Sub

Private Sub optFechaOper_Click()

    Call ColorOptionButton(colOrdenado, optFechaOper)
    
End Sub

Private Sub optFechaProc_Click()

    Call ColorOptionButton(colFechas, optFechaProc)

End Sub

Private Sub optFechaVcto_Click()

    Call ColorOptionButton(colOrdenado, optFechaVcto)
  
End Sub

Private Sub optFecVenc_Click()

    Call ColorOptionButton(colFechas, optFecVenc)

End Sub

Private Sub optMoneda_Click()

    Call ColorOptionButton(colOrdenado, optMoneda)

End Sub

Private Sub optOpDia_Click()

    Call ColorOptionButton(colConsulta, optOpDia)
  
End Sub

Private Sub optOpHistorica_Click()

    Call ColorOptionButton(colConsulta, optOpHistorica)
  
End Sub

Private Sub optOpVencidas_Click()

    Call ColorOptionButton(colConsulta, optOpVencidas)
    
End Sub

Private Sub optOpVigente_Click()

    Call ColorOptionButton(colConsulta, optOpVigente)
  
End Sub

Private Sub optPosicionVctos_Click()

    Call ColorOptionButton(colConsulta, optPosicionVctos)

End Sub



Private Sub Toolbar1_ButtonClick(ByVal Button As ComctlLib.Button)
Select Case Button.Index
   Case 1
      Call btnAceptar_Click
   Case 2
      Call btnCancelar_Click
End Select
End Sub

Private Sub txtCliente_DblClick()
Dim Cliente As New clsCliente

    If Not Cliente.Ayuda("") Then
        MsgBox "No Existen Datos para ayuda solicitada", vbExclamation, Msj
        Exit Sub
    End If
    
    BacAyudaSwap.Tag = "Cliente"
    BacAyudaSwap.Show 1
    
    If giAceptar Then
        If Cliente.LeerxRut(CDbl(gsCodigo), CDbl(gsCodCli)) Then
        'If Cliente.LeerxRut(Cliente.clrut, Cliente.clcodigo) Then
            'txtRut = Format(gsCodigo, "###,###,###") & "-" & gsDigito
            txtCliente = Cliente.clnombre
            txtCliente.Tag = Cliente.clcodigo
            optCliente.Tag = Cliente.clrut
        Else
            MsgBox "No se encontro información de Cliente solicitado", vbCritical, Msj
        End If
    End If
    
    Set Cliente = Nothing

End Sub

