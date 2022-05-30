VERSION 5.00
Object = "{62D4B10A-EF7E-11D3-8E55-0008C7599BA7}#1.0#0"; "BAC_CONTROLESANT.OCX"
Begin VB.Form BacFiltroConsulta 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Filtro Consulta "
   ClientHeight    =   5115
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   8745
   Icon            =   "BacFiltroConsulta.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   5115
   ScaleWidth      =   8745
   StartUpPosition =   2  'CenterScreen
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
      Left            =   7380
      Picture         =   "BacFiltroConsulta.frx":0442
      Style           =   1  'Graphical
      TabIndex        =   33
      Top             =   4275
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
      Left            =   6120
      Picture         =   "BacFiltroConsulta.frx":0884
      Style           =   1  'Graphical
      TabIndex        =   32
      Top             =   4275
      Width           =   1230
   End
   Begin VB.Frame Frame1 
      Caption         =   " Consulta de...  "
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   2085
      Index           =   3
      Left            =   6075
      TabIndex        =   2
      Top             =   2070
      Width           =   2625
      Begin VB.OptionButton optPosicionVctos 
         Caption         =   "Posición por Vencimientos"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00808000&
         Height          =   225
         Left            =   135
         TabIndex        =   31
         Top             =   2160
         Visible         =   0   'False
         Width           =   2445
      End
      Begin VB.OptionButton optOpVencidas 
         Caption         =   "Operaciones Vencidas"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9
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
         Top             =   1575
         Width           =   2445
      End
      Begin VB.OptionButton optOpVigente 
         Caption         =   "Operaciones Vigentes"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00808000&
         Height          =   225
         Left            =   135
         TabIndex        =   29
         Top             =   1170
         Width           =   2445
      End
      Begin VB.OptionButton optOpHistorica 
         Caption         =   "Operaciones Historicas"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00808000&
         Height          =   225
         Left            =   135
         TabIndex        =   28
         Top             =   765
         Width           =   2445
      End
      Begin VB.OptionButton optOpDia 
         Caption         =   "Operaciones del Día"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00808000&
         Height          =   225
         Left            =   135
         TabIndex        =   27
         Top             =   405
         Width           =   2445
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   " Ordenado Por...  "
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   2085
      Index           =   2
      Left            =   6075
      TabIndex        =   1
      Top             =   0
      Width           =   2625
      Begin VB.OptionButton optCliente 
         Caption         =   "Cliente"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00808000&
         Height          =   225
         Left            =   135
         TabIndex        =   26
         Top             =   450
         Width           =   1860
      End
      Begin VB.OptionButton optMoneda 
         Caption         =   "Moneda"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00808000&
         Height          =   225
         Left            =   135
         TabIndex        =   25
         Top             =   810
         Width           =   2220
      End
      Begin VB.OptionButton optFechaOper 
         Caption         =   "Fecha Operación"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00808000&
         Height          =   225
         Left            =   135
         TabIndex        =   24
         Top             =   1215
         Width           =   2220
      End
      Begin VB.OptionButton optFechaVcto 
         Caption         =   "Fecha Vencimiento"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   9
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00808000&
         Height          =   225
         Left            =   135
         TabIndex        =   23
         Top             =   1620
         Width           =   2220
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "  Filtros  "
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   5055
      Index           =   0
      Left            =   45
      TabIndex        =   0
      Top             =   0
      Width           =   5955
      Begin VB.Frame Frame1 
         Height          =   1590
         Index           =   6
         Left            =   135
         TabIndex        =   5
         Top             =   3330
         Width           =   5685
         Begin VB.OptionButton optFecVenc 
            Caption         =   "Fecha Vencimiento"
            BeginProperty Font 
               Name            =   "Times New Roman"
               Size            =   9
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00808000&
            Height          =   195
            Left            =   1935
            TabIndex        =   22
            Top             =   1170
            Width           =   2445
         End
         Begin VB.OptionButton optFechaProc 
            Caption         =   "Fecha Proceso"
            BeginProperty Font 
               Name            =   "Times New Roman"
               Size            =   9
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00808000&
            Height          =   195
            Left            =   1935
            TabIndex        =   21
            Top             =   810
            Width           =   2445
         End
         Begin VB.CheckBox chkEntreFec 
            Caption         =   "Entre Fechas "
            BeginProperty Font 
               Name            =   "Times New Roman"
               Size            =   9.75
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00808000&
            Height          =   420
            Left            =   270
            TabIndex        =   18
            Top             =   270
            Width           =   1365
         End
         Begin BAC_Controles.UserControl_Fecha fecDesde 
            Height          =   300
            Left            =   1935
            TabIndex        =   19
            Top             =   315
            Width           =   1185
            _ExtentX        =   2090
            _ExtentY        =   529
            Enabled         =   -1  'True
            Enabled         =   -1  'True
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
            Text            =   "23-05-2000"
         End
         Begin BAC_Controles.UserControl_Fecha fecHasta 
            Height          =   300
            Left            =   3330
            TabIndex        =   20
            Top             =   315
            Width           =   1185
            _ExtentX        =   2090
            _ExtentY        =   529
            Enabled         =   -1  'True
            Enabled         =   -1  'True
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
            Text            =   "23-05-2000"
         End
      End
      Begin VB.Frame Frame1 
         Height          =   1860
         Index           =   5
         Left            =   135
         TabIndex        =   4
         Top             =   1485
         Width           =   5685
         Begin BAC_Controles.UserControl_Fecha fecFechaProceso 
            Height          =   330
            Left            =   1935
            TabIndex        =   16
            Top             =   1035
            Width           =   1185
            _ExtentX        =   2090
            _ExtentY        =   582
            Enabled         =   -1  'True
            Enabled         =   -1  'True
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
            Text            =   "23-05-2000"
         End
         Begin VB.TextBox txtCliente 
            BeginProperty Font 
               Name            =   "Times New Roman"
               Size            =   9
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   330
            Left            =   1935
            TabIndex        =   15
            Top             =   225
            Width           =   3480
         End
         Begin VB.ComboBox cmbMonedas 
            BeginProperty Font 
               Name            =   "Times New Roman"
               Size            =   9
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   345
            Left            =   1935
            Style           =   2  'Dropdown List
            TabIndex        =   14
            Top             =   630
            Width           =   3480
         End
         Begin VB.CheckBox chkMoneda 
            Caption         =   "Moneda"
            BeginProperty Font 
               Name            =   "Times New Roman"
               Size            =   9.75
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00808000&
            Height          =   240
            Left            =   270
            TabIndex        =   13
            Top             =   675
            Width           =   1050
         End
         Begin VB.CheckBox chkFechaProc 
            Caption         =   "Fecha Proceso"
            BeginProperty Font 
               Name            =   "Times New Roman"
               Size            =   9.75
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00808000&
            Height          =   375
            Left            =   270
            TabIndex        =   12
            Top             =   990
            Width           =   1680
         End
         Begin VB.CheckBox chkFechaVecto 
            Caption         =   "Fecha Vcto."
            BeginProperty Font 
               Name            =   "Times New Roman"
               Size            =   9.75
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00808000&
            Height          =   420
            Left            =   270
            TabIndex        =   11
            Top             =   1350
            Width           =   1365
         End
         Begin VB.CheckBox chkCliente 
            Caption         =   "Cliente"
            BeginProperty Font 
               Name            =   "Times New Roman"
               Size            =   9.75
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00808000&
            Height          =   240
            Left            =   270
            TabIndex        =   10
            Top             =   270
            Width           =   1050
         End
         Begin BAC_Controles.UserControl_Fecha fecFechaVcto 
            Height          =   330
            Left            =   1935
            TabIndex        =   17
            Top             =   1395
            Width           =   1185
            _ExtentX        =   2090
            _ExtentY        =   582
            Enabled         =   -1  'True
            Enabled         =   -1  'True
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
            Text            =   "23-05-2000"
         End
      End
      Begin VB.Frame Frame1 
         Height          =   1230
         Index           =   4
         Left            =   135
         TabIndex        =   3
         Top             =   270
         Width           =   5685
         Begin VB.CheckBox chkTodos 
            Caption         =   "Todas"
            BeginProperty Font 
               Name            =   "Times New Roman"
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
            TabIndex        =   34
            Top             =   855
            Width           =   1050
         End
         Begin VB.ComboBox cmbPosicion 
            BeginProperty Font 
               Name            =   "Times New Roman"
               Size            =   9
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   345
            Left            =   1935
            Style           =   2  'Dropdown List
            TabIndex        =   9
            Top             =   450
            Width           =   3480
         End
         Begin VB.ComboBox cmbEntidad 
            BeginProperty Font 
               Name            =   "Times New Roman"
               Size            =   9
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   345
            Left            =   1935
            Style           =   2  'Dropdown List
            TabIndex        =   8
            Top             =   1125
            Visible         =   0   'False
            Width           =   3480
         End
         Begin VB.Label Etiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Posición"
            BeginProperty Font 
               Name            =   "Times New Roman"
               Size            =   9.75
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   225
            Index           =   1
            Left            =   270
            TabIndex        =   7
            Top             =   540
            Width           =   705
         End
         Begin VB.Label Etiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Entidad"
            BeginProperty Font 
               Name            =   "Times New Roman"
               Size            =   9.75
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00800000&
            Height          =   225
            Index           =   0
            Left            =   270
            TabIndex        =   6
            Top             =   1080
            Visible         =   0   'False
            Width           =   615
         End
      End
   End
End
Attribute VB_Name = "BacFiltroconsulta"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim colFechas As New Collection
Dim colOrdenado As New Collection
Dim colConsulta As New Collection
Function ValidaDatos() As Boolean

    ValidaDatos = False
    If chkCliente.Value = 1 And txtCliente = "" Then
        MsgBox "Debe ingresar Cliente", vbCritical, Msj
        txtCliente.SetFocus
        Exit Function
    End If

    ValidaDatos = True

End Function

Private Sub btnAceptar_Click()

    If ValidaDatos() Then
        Call Filtrar
    End If

End Sub

Function Filtrar()


End Function

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

     '------------- Monedas
    Call LlenaComboCodGeneral(cmbMonedas, 42, Sistema, 2)
    
     '------------- Tipo de Swaps
    Call LlenaComboCodGeneral(cmbPosicion, 13, Sistema, 1)
    
    If cmbMonedas.ListCount = 0 Then
        chkMoneda.Enabled = False
        cmbMonedas.Enabled = False
    End If
    If cmbPosicion.ListCount = 0 Then
        cmbPosicion.Enabled = False
    End If
    
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

Private Sub Text1_Change()

End Sub

Private Sub txtCliente_DblClick()
'Solicita Ayuda
Dim carac As String
Dim AyudaCli As New clsCliente

    
    With AyudaCli
    If .leepornombre("*") Then
        BacAyudaSwap.Tag = "Cliente"
        
        BacAyudaSwap.Show 1
    Else
        MsgBox "No Existen Datos para ayuda solicitada", vbExclamation, Msj
        Exit Sub
    End If
    End With
    
    'txtRut = Format(gsCodigo, "###,###,###") & "-" & gsDigito
    txtCliente = gsnombre
    txtCliente.Tag = gscodcli
    
    AyudaCli.limpiar
    
    Set AyudaCli = Nothing

End Sub

