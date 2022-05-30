VERSION 5.00
Object = "{316A9483-A459-11D4-9073-005004A524B9}#1.0#0"; "BACCONTROLES.OCX"
Begin VB.Form BacInformes 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Informe de Movimientos"
   ClientHeight    =   2595
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   3855
   Icon            =   "BacInformes.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   2595
   ScaleWidth      =   3855
   ShowInTaskbar   =   0   'False
   Begin VB.CommandButton btnPantalla 
      Caption         =   "&Pantalla"
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   780
      Left            =   180
      Picture         =   "BacInformes.frx":0442
      Style           =   1  'Graphical
      TabIndex        =   0
      ToolTipText     =   "Informe vista previa en Pantalla"
      Top             =   1755
      Width           =   1185
   End
   Begin VB.CommandButton btnSalir 
      Caption         =   "&Salir"
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   780
      Left            =   2610
      Picture         =   "BacInformes.frx":0884
      Style           =   1  'Graphical
      TabIndex        =   2
      ToolTipText     =   "Salir Pantalla"
      Top             =   1755
      Width           =   1185
   End
   Begin VB.CommandButton btnInforme 
      Caption         =   "&Informe"
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   780
      Left            =   1395
      Picture         =   "BacInformes.frx":0B8E
      Style           =   1  'Graphical
      TabIndex        =   1
      ToolTipText     =   "Informe directo a Impresora"
      Top             =   1755
      Width           =   1185
   End
   Begin VB.Frame Frame1 
      Height          =   1725
      Left            =   0
      TabIndex        =   3
      Top             =   -45
      Width           =   3840
      Begin VB.Frame Frame2 
         Height          =   1005
         Left            =   540
         TabIndex        =   4
         Top             =   585
         Width           =   2805
         Begin BacControles.txtFecha txtFecha 
            Height          =   375
            Left            =   1080
            TabIndex        =   8
            Top             =   480
            Width           =   1215
            _ExtentX        =   2143
            _ExtentY        =   661
            Text            =   "25/10/2000"
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   8388608
            MinDate         =   -328716
            MaxDate         =   2958465
            BackColor       =   12632256
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "Fecha"
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
            Index           =   0
            Left            =   315
            TabIndex        =   6
            Top             =   450
            Width           =   480
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "Día no Hábil"
            BeginProperty Font 
               Name            =   "Times New Roman"
               Size            =   9
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00000080&
            Height          =   225
            Index           =   1
            Left            =   1125
            TabIndex        =   5
            Top             =   180
            Visible         =   0   'False
            Width           =   915
         End
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "tipo swap"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   11.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   255
         Index           =   2
         Left            =   855
         TabIndex        =   7
         Top             =   270
         Width           =   915
      End
      Begin VB.Image Image1 
         Height          =   480
         Left            =   135
         Picture         =   "BacInformes.frx":0E98
         Top             =   135
         Width           =   480
      End
   End
End
Attribute VB_Name = "BacInformes"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Function GeneraInforme(Donde)

On Error GoTo Control

Dim num As Integer
Dim Origen As Integer
Dim Fecha As Date
Dim tipo As Integer


If CDate(txtFecha.Text) > CDate(gsBAC_Fecp) Then
    MsgBox "Fecha no puede ser mayor a fecha de proceso!", vbInformation, Msj
    txtFecha.SetFocus
    Exit Function
End If


If CDate(txtFecha.Text) = CDate(gsBAC_Fecp) Then
    'Buscara datos en movimiento diario
    Origen = 1
    Fecha = CDate(gsBAC_Fecp)
    
Else
    'Buscara datos en movimiento historico
    Origen = 2
    Fecha = CDate(txtFecha.Text)
    
End If


Call BacLimpiaParamCrw


With BACSwap.Crystal

    If Donde = "Impresora" Then
        .Destination = crptToPrinter                                  'Informe directo a Impresora
    Else
        .Destination = crptToWindow
    End If


    If BacInformes.Tag = "TASAS" Then
        .ReportFileName = gsRPT_Path & "movimientodiario.rpt"
        tipo = 1
    Else
        .ReportFileName = gsRPT_Path & "BacMovimDiarioMoneda.rpt"
        tipo = 2
    End If

    .WindowTitle = "Informe de Movimientos"

    .StoredProcParam(0) = tipo                                      'tipo de swap - Tasa - Moneda
    .StoredProcParam(1) = giSQL_DatabaseCommon ' base comun parametros
    .StoredProcParam(2) = Format(Fecha, "YYYYMMDD")
    .StoredProcParam(3) = Time                                 'Hora para reporte
    .StoredProcParam(4) = Origen                              'Tabla origen de datos

    .Connect = swConeccion

.Action = 1 'Envio

End With

Exit Function

Control:
    
    Select Case BACSwap.Crystal.LastErrorNumber
        Case 20527
            MsgBox "No Existen datos para generar informe solicitado", vbInformation, Msj
        Case Else
            MsgBox BACSwap.Crystal.LastErrorString, vbCritical, Msj
    
    End Select
    
End Function

Private Sub btnPapeleta_Click()

End Sub

Private Sub btnInforme_Click()

    If Label1(1).Visible = True Then
        MsgBox "Fecha Seleccionada para consulta no es Hábil!", vbInformation, Msj
        txtFecha.SetFocus
    Else
       Call GeneraInforme("Impresora")
    
    End If

End Sub

Private Sub btnPantalla_Click()
    
    If Label1(1).Visible = True Then
        MsgBox "Fecha Seleccionada para consulta no es Hábil!", vbInformation, Msj
        txtFecha.SetFocus
    Else
       Call GeneraInforme("Pantalla")
    
    End If
    
End Sub

Private Sub btnSalir_Click()

    Unload BacInformes

End Sub

Private Sub Form_Activate()

    If BacInformes.Tag = "TASAS" Then
        Label1(2).Caption = "Swap de Tasas"
    Else
        Label1(2).Caption = "Swap de Monedas"
    End If

End Sub

Private Sub Form_Load()

    'Tope máx. de fecha solicitada
    txtFecha.MaxDate = gsBAC_Fecp
    txtFecha.Text = gsBAC_Fecp
    Label1(1).Caption = ""

End Sub


Function ValidaFecha()


    If Not BacEsHabil(txtFecha.Text) Then
        txtFecha.ForeColor = &HC0&
        Label1(1).Visible = True
    Else
        Label1(1).Visible = False
        txtFecha.ForeColor = &HC00000
    End If
    
End Function

Private Sub txtFecha_Change()

    Call ValidaFecha

End Sub

Private Sub txtFecha_KeyPress(KeyAscii As Integer)

    If KeyAscii = 13 Then
        
    End If

End Sub

Private Sub txtFecha_LostFocus()

    Call ValidaFecha
    
    If txtFecha.Text > gsBAC_Fecp Then
        MsgBox "Fecha no puede ser mayor a fecha de proceso!", vbInformation, Msj
         txtFecha.Text = gsBAC_Fecp
        txtFecha.SetFocus
    End If

End Sub

