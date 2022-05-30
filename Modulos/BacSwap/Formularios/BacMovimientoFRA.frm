VERSION 5.00
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "COMCTL32.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BACCONTROLES.OCX"
Begin VB.Form BacMovimientoFRA 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Informe de Movimientos"
   ClientHeight    =   2820
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   3855
   Icon            =   "BacMovimientoFRA.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   2820
   ScaleWidth      =   3855
   ShowInTaskbar   =   0   'False
   Begin ComctlLib.Toolbar Toolbar1 
      Height          =   480
      Left            =   0
      TabIndex        =   6
      Top             =   0
      Width           =   3975
      _ExtentX        =   7011
      _ExtentY        =   847
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   327682
      BeginProperty Buttons {0713E452-850A-101B-AFC0-4210102A8DA7} 
         NumButtons      =   3
         BeginProperty Button1 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   ""
            Object.ToolTipText     =   "Pantalla"
            Object.Tag             =   ""
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   ""
            Object.ToolTipText     =   "Impresora"
            Object.Tag             =   ""
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {0713F354-850A-101B-AFC0-4210102A8DA7} 
            Key             =   ""
            Object.ToolTipText     =   "Salir"
            Object.Tag             =   ""
            ImageIndex      =   3
         EndProperty
      EndProperty
   End
   Begin VB.Frame Frame1 
      Height          =   2235
      Left            =   30
      TabIndex        =   0
      Top             =   525
      Width           =   3840
      Begin VB.Frame Frame3 
         Caption         =   "Tipo de Cartera"
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
         Height          =   675
         Left            =   570
         TabIndex        =   7
         Top             =   510
         Width           =   3045
         Begin VB.ComboBox Cmb_Cartera 
            Height          =   315
            Left            =   90
            Style           =   2  'Dropdown List
            TabIndex        =   8
            Top             =   210
            Width           =   2865
         End
      End
      Begin VB.Frame Frame2 
         Height          =   1005
         Left            =   270
         TabIndex        =   1
         Top             =   1170
         Width           =   3345
         Begin BACControles.TXTFecha txtFecha 
            Height          =   330
            Left            =   1770
            TabIndex        =   5
            Top             =   405
            Width           =   1410
            _ExtentX        =   2487
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
            Text            =   "15/06/2001"
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "Fecha de Proceso"
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
            Height          =   195
            Index           =   0
            Left            =   180
            TabIndex        =   3
            Top             =   465
            Width           =   1560
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "Día no Hábil"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00000080&
            Height          =   195
            Index           =   1
            Left            =   1125
            TabIndex        =   2
            Top             =   180
            Visible         =   0   'False
            Width           =   1095
         End
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Forward Rate Agreements"
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
         Index           =   2
         Left            =   855
         TabIndex        =   4
         Top             =   180
         Width           =   2715
      End
      Begin VB.Image Image1 
         Height          =   480
         Left            =   75
         Picture         =   "BacMovimientoFRA.frx":0442
         Top             =   135
         Width           =   480
      End
   End
   Begin ComctlLib.ImageList ImageList1 
      Left            =   3360
      Top             =   1920
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   327682
      BeginProperty Images {0713E8C2-850A-101B-AFC0-4210102A8DA7} 
         NumListImages   =   3
         BeginProperty ListImage1 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "BacMovimientoFRA.frx":0884
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "BacMovimientoFRA.frx":0B9E
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "BacMovimientoFRA.frx":0EB8
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "BacMovimientoFRA"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub btnInforme_Click(Index As Integer)
Dim Origen%
Dim sError$
Dim Fecha As Date

Call BacLimpiaParamCrw

    If Label1(1).Visible = True Then
        sError = "Fecha Seleccionada para consulta no es Hábil!"
    ElseIf CDate(TXTFecha.Text) > CDate(gsBAC_Fecp) Then
        sError = "Fecha no puede ser mayor a fecha de proceso!"
    End If
    
    If Len(sError) > 0 Then
        MsgBox sError, vbInformation + vbOKOnly, Msj
        TXTFecha.SetFocus
        Exit Sub
    End If
    
    '------------------ Imprimiendo
    On Error GoTo Control

    Fecha = TXTFecha.Text
    
    Origen = IIf(TXTFecha.Text = gsBAC_Fecp, 1, 2)
    
    With BACSwap.Crystal
    
        If Index = 1 Then
            .Destination = crptToWindow
        Else
            .Destination = crptToPrinter
        End If
        'SP_MOVIMIENTOFRA
        .ReportFileName = gsRPT_Path & "bacMovimientoFRA.rpt"
    
        .WindowTitle = "Informe de Movimientos"
        
        .StoredProcParam(0) = Cmb_Cartera.ItemData(Cmb_Cartera.ListIndex)
        .Connect = swConeccion
        
        .Action = 1             ' Envio
    
    End With
    
    Exit Sub

Control:
    
    Select Case BACSwap.Crystal.LastErrorNumber
    Case 20504
        MsgBox "No Existe File-Report para generar Informe" & vbCrLf & gsRPT_Path, vbInformation, Msj
        
    Case 20527
        MsgBox "No Existen datos para generar informe solicitado", vbInformation, Msj
        
    Case Else
        MsgBox BACSwap.Crystal.LastErrorString, vbCritical, Msj
    
    End Select
    
End Sub
Private Sub btnSalir_Click()

    Unload Me

End Sub
Private Sub Form_Load()

    If WindowState = 0 Then
        Top = 1
        Left = 15
    End If

    'Tope máx. de fecha solicitada
    TXTFecha.MaxDate = gsBAC_Fecp
    TXTFecha.Text = gsBAC_Fecp
    TXTFecha.Enabled = False
    Label1(1).Caption = ""
    Func_Cartera Cmb_Cartera, "PCS"

End Sub

Function ValidaFecha()
    
    If Not BacEsHabil(TXTFecha.Text) Then
        TXTFecha.ForeColor = &HC0&
        Label1(1).Visible = True
    Else
        Label1(1).Visible = False
        TXTFecha.ForeColor = &HC00000
    End If
    
End Function

Private Sub Toolbar1_ButtonClick(ByVal Button As ComctlLib.Button)
Select Case Button.Index
   Case 1
      Call btnInforme_Click(1)
   Case 2
      'Call BacLimpiaParamCrw
      Call btnInforme_Click(2)
   Case 3
      Unload BacMovimientoFRA
End Select

End Sub

Private Sub txtFecha_Change()

    Call ValidaFecha

End Sub

Private Sub txtFecha_LostFocus()

    Call ValidaFecha
    
    If CDate(TXTFecha.Text) > CDate(gsBAC_Fecp) Then
        MsgBox "Fecha no puede ser mayor a fecha de proceso!", vbInformation, Msj
         TXTFecha.Text = gsBAC_Fecp
        TXTFecha.SetFocus
    End If

End Sub

