VERSION 5.00
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "COMCTL32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Begin VB.Form Contabilizacion_Automatica 
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Contabilización Automática"
   ClientHeight    =   1230
   ClientLeft      =   1875
   ClientTop       =   3015
   ClientWidth     =   5100
   Icon            =   "Con_auto.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   1230
   ScaleWidth      =   5100
   Begin VB.CommandButton btnErrores 
      Caption         =   "Errores"
      Height          =   555
      Left            =   3030
      Picture         =   "Con_auto.frx":000C
      Style           =   1  'Graphical
      TabIndex        =   3
      Top             =   105
      Width           =   840
   End
   Begin Threed.SSPanel SSPanel5 
      Height          =   1215
      Left            =   15
      TabIndex        =   0
      Top             =   0
      Width           =   5100
      _Version        =   65536
      _ExtentX        =   8996
      _ExtentY        =   2143
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
      BevelInner      =   2
      Begin ComctlLib.Toolbar Toolbar1 
         Height          =   480
         Left            =   150
         TabIndex        =   2
         Top             =   75
         Width           =   1440
         _ExtentX        =   2540
         _ExtentY        =   847
         ButtonWidth     =   767
         ButtonHeight    =   741
         AllowCustomize  =   0   'False
         Wrappable       =   0   'False
         ImageList       =   "ImageList1"
         _Version        =   327682
         BeginProperty Buttons {0713E452-850A-101B-AFC0-4210102A8DA7} 
            NumButtons      =   3
            BeginProperty Button1 {0713F354-850A-101B-AFC0-4210102A8DA7} 
               Key             =   "Contabiliza"
               Object.ToolTipText     =   "Contabilizar"
               Object.Tag             =   ""
               ImageIndex      =   1
            EndProperty
            BeginProperty Button2 {0713F354-850A-101B-AFC0-4210102A8DA7} 
               Key             =   "Cancela"
               Object.ToolTipText     =   "Cancelar Proceso Contable"
               Object.Tag             =   ""
               ImageIndex      =   2
            EndProperty
            BeginProperty Button3 {0713F354-850A-101B-AFC0-4210102A8DA7} 
               Key             =   "Cerrar"
               Object.ToolTipText     =   "Cerrar"
               Object.Tag             =   ""
               ImageIndex      =   3
            EndProperty
         EndProperty
      End
      Begin ComctlLib.ImageList ImageList1 
         Left            =   4290
         Top             =   0
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         _Version        =   327682
         BeginProperty Images {0713E8C2-850A-101B-AFC0-4210102A8DA7} 
            NumListImages   =   6
            BeginProperty ListImage1 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
               Picture         =   "Con_auto.frx":044E
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
               Picture         =   "Con_auto.frx":0768
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
               Picture         =   "Con_auto.frx":0A82
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
               Picture         =   "Con_auto.frx":0D9C
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
               Picture         =   "Con_auto.frx":10B6
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
               Picture         =   "Con_auto.frx":13D0
               Key             =   ""
            EndProperty
         EndProperty
      End
      Begin VB.Label Lbl_Msg 
         Alignment       =   2  'Center
         BackColor       =   &H00800000&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H0000FFFF&
         Height          =   375
         Left            =   135
         TabIndex        =   1
         Top             =   720
         Width           =   4890
      End
   End
   Begin Threed.SSCommand Cmd_Aceptar 
      Height          =   870
      Left            =   3765
      TabIndex        =   4
      Top             =   3795
      Width           =   1320
      _Version        =   65536
      _ExtentX        =   2328
      _ExtentY        =   1535
      _StockProps     =   78
      Caption         =   "&Contabilizar"
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
      Font3D          =   3
      Picture         =   "Con_auto.frx":16EA
   End
   Begin Threed.SSCommand Cmd_Cancelar 
      Height          =   390
      Left            =   2430
      TabIndex        =   5
      Top             =   4260
      Width           =   1320
      _Version        =   65536
      _ExtentX        =   2328
      _ExtentY        =   688
      _StockProps     =   78
      Caption         =   "C&ancelar"
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
      Font3D          =   3
   End
End
Attribute VB_Name = "Contabilizacion_Automatica"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub btnErrores_Click()

On Error GoTo Control
    Call BacLimpiaParamCrw
    With BACSwap.Crystal
        
        .Destination = 0 'crptToPrinter
            
        .ReportFileName = gsRPT_Path & "BacListaErrorConta.rpt"
        .WindowTitle = "Listado Errores Contables"
        .Connect = swConeccion
        .Action = 1 'Envio
    
    End With
    
Exit Sub

Control:
    
    MsgBox BACSwap.Crystal.LastErrorString, vbCritical, Msj

End Sub

Private Sub Cmd_Aceptar_Click()
Dim Datos()
Dim SQL As String
Dim sError$
Dim cruta As String

cruta = gsBac_DIRCONTA

    If MsgBox("Seguro de Contabilizar ?", 36, Msj) <> 6 Then
        Exit Sub
    End If
    
Contabiliza:
    '---- Contabiliza
    Screen.MousePointer = 11
    
    Lbl_Msg.Height = 360
    Lbl_Msg.Caption = "Contabilizando..."
    Lbl_Msg.Refresh
    
    SQL = "SP_CONTABILIZACION '" & Format(gsBAC_Fecp, "yyyymmdd") & "'"
    
    Envia = Array()
    AddParam Envia, Format(gsBAC_Fecp, "yyyymmdd")

    If Not Bac_Sql_Execute("SP_CONTABILIZACION", Envia) Then
        Screen.MousePointer = 0
        Lbl_Msg.Caption = "¡ Proceso NO Realizado !"
        If MsgBox("Problemas al realizar Contabilización Automática", vbRetryCancel + vbCritical, TITSISTEMA) = vbRetry Then
             GoTo Contabiliza
        End If
        GoTo Fin
    End If
       

    If Bac_SQL_Fetch(Datos()) Then
        If Datos(1) <> "0" Then
               btnErrores.Visible = True
               Call gsc_Parametros.CambiaFlags(2, 0)
          Else
               Call gsc_Parametros.CambiaFlags(2, 1)
         End If
    End If
    
   If Not btnErrores.Visible = True Then
      Let Lbl_Msg.Caption = "Generando Interfaz.": Call BacControlWindows(1)
    Call BacInterfazContable(cruta, 1)
      Let Lbl_Msg.Caption = "Proceso Finalizado.": Call BacControlWindows(1)
   End If
    
    Lbl_Msg.Caption = " Contabilidad Terminada " & sError
    
Fin:
    Screen.MousePointer = 0

End Sub
Private Sub Cmd_cancelar_Click()
Unload Me

End Sub

Private Sub cmdError_Click()

On Error GoTo Control

With BACSwap.Crystal

Call BacLimpiaParamCrw

.Destination = 0
.ReportFileName = gsRPT_Path & "baclistaerrores.rpt"
.WindowTitle = "Listado Errores Contables"
.Connect = swConeccion
.Action = 1 'Envio

End With

Exit Sub

Control:
    
    Select Case BACSwap.Crystal.LastErrorNumber
        Case 20527
            MsgBox "No Existen datos para generar informe solicitado", vbInformation, Msj
        Case Else
            MsgBox BACSwap.Crystal.LastErrorString, vbCritical, Msj
    End Select


End Sub

Private Sub Form_Load()

Me.Icon = BACSwap.Icon
Me.Toolbar1.Buttons(2).Visible = False
btnErrores.Visible = False


End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As ComctlLib.Button)
Select Case UCase(Button.Key)
   Case Is = UCase("Contabiliza")
      Cmd_Aceptar_Click
   Case Is = UCase("Cancela")
      Cmd_cancelar_Click
   Case Is = UCase("Cerrar")
      Unload Me
End Select
End Sub
