VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{989C9190-EDF5-45A8-AB6C-98E6EF0384D7}#1.0#0"; "Bac_Controles_Pas.ocx"
Begin VB.Form FRM_INTERFACES_SIGIR 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Interfaces Sigir"
   ClientHeight    =   4485
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4200
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   4485
   ScaleWidth      =   4200
   Begin VB.ListBox Lst_Interfaces 
      BackColor       =   &H8000000F&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00C00000&
      Height          =   1230
      Left            =   30
      TabIndex        =   18
      Top             =   3210
      Width           =   4125
   End
   Begin VB.Frame frame_interfaces_sigir 
      Caption         =   "Interfaces Sigir"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000007&
      Height          =   1935
      Left            =   0
      TabIndex        =   4
      Top             =   1230
      Width           =   4185
      Begin VB.PictureBox ConCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   3
         Left            =   3495
         Picture         =   "FRM_INTERFACES_SIGIR.frx":0000
         ScaleHeight     =   330
         ScaleWidth      =   330
         TabIndex        =   17
         Top             =   1440
         Visible         =   0   'False
         Width           =   330
      End
      Begin VB.PictureBox SinCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   3
         Left            =   240
         Picture         =   "FRM_INTERFACES_SIGIR.frx":0386
         ScaleHeight     =   330
         ScaleWidth      =   375
         TabIndex        =   15
         Top             =   1440
         Width           =   375
      End
      Begin VB.PictureBox ConCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   2
         Left            =   3495
         Picture         =   "FRM_INTERFACES_SIGIR.frx":06EE
         ScaleHeight     =   330
         ScaleWidth      =   330
         TabIndex        =   14
         Top             =   1080
         Visible         =   0   'False
         Width           =   330
      End
      Begin VB.PictureBox SinCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   2
         Left            =   240
         Picture         =   "FRM_INTERFACES_SIGIR.frx":0A74
         ScaleHeight     =   330
         ScaleWidth      =   375
         TabIndex        =   12
         Top             =   1080
         Width           =   375
      End
      Begin VB.PictureBox ConCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   1
         Left            =   3495
         Picture         =   "FRM_INTERFACES_SIGIR.frx":0DDC
         ScaleHeight     =   330
         ScaleWidth      =   330
         TabIndex        =   8
         Top             =   720
         Visible         =   0   'False
         Width           =   330
      End
      Begin VB.PictureBox SinCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   1
         Left            =   240
         Picture         =   "FRM_INTERFACES_SIGIR.frx":1162
         ScaleHeight     =   330
         ScaleWidth      =   375
         TabIndex        =   7
         Top             =   720
         Width           =   375
      End
      Begin VB.PictureBox ConCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   0
         Left            =   3495
         Picture         =   "FRM_INTERFACES_SIGIR.frx":14CA
         ScaleHeight     =   330
         ScaleWidth      =   330
         TabIndex        =   6
         Top             =   360
         Visible         =   0   'False
         Width           =   330
      End
      Begin VB.PictureBox SinCheck 
         BorderStyle     =   0  'None
         Height          =   330
         Index           =   0
         Left            =   240
         Picture         =   "FRM_INTERFACES_SIGIR.frx":1850
         ScaleHeight     =   330
         ScaleWidth      =   375
         TabIndex        =   5
         Top             =   360
         Width           =   375
      End
      Begin VB.Label Etiqueta 
         AutoSize        =   -1  'True
         Caption         =   "Interfaz Cliente"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   210
         Index           =   3
         Left            =   720
         TabIndex        =   16
         Top             =   1470
         Width           =   1260
      End
      Begin VB.Label Etiqueta 
         AutoSize        =   -1  'True
         Caption         =   "Interfaz Flujos"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   210
         Index           =   2
         Left            =   720
         TabIndex        =   13
         Top             =   1080
         Width           =   1170
      End
      Begin VB.Label Etiqueta 
         AutoSize        =   -1  'True
         Caption         =   "Interfaz Balance"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   210
         Index           =   1
         Left            =   720
         TabIndex        =   10
         Top             =   765
         Width           =   1305
      End
      Begin VB.Label Etiqueta 
         AutoSize        =   -1  'True
         Caption         =   "Interfaz Operaciones"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   210
         Index           =   0
         Left            =   720
         TabIndex        =   9
         Top             =   405
         Width           =   1725
      End
   End
   Begin VB.Frame frame_fecha_proceso 
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   780
      Left            =   0
      TabIndex        =   0
      Top             =   450
      Width           =   4200
      Begin VB.Frame Frame2 
         BorderStyle     =   0  'None
         Height          =   660
         Index           =   1
         Left            =   75
         TabIndex        =   1
         Top             =   1515
         Width           =   3825
      End
      Begin BACControles.TXTFecha TXTFecha1 
         Height          =   315
         Left            =   1560
         TabIndex        =   2
         Top             =   210
         Width           =   1215
         _ExtentX        =   2143
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
         Text            =   "18/06/2001"
      End
      Begin VB.Label lblEtiqueta 
         AutoSize        =   -1  'True
         Caption         =   "Fecha Interfaz"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000007&
         Height          =   210
         Index           =   0
         Left            =   240
         TabIndex        =   3
         Top             =   225
         Width           =   1155
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   11
      Top             =   0
      Width           =   4200
      _ExtentX        =   7408
      _ExtentY        =   794
      ButtonWidth     =   820
      ButtonHeight    =   794
      Style           =   1
      ImageList       =   "Img_opciones"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "interfaz"
            Description     =   "INTERFAZ"
            Object.ToolTipText     =   "Genera interfaz descalce"
            ImageIndex      =   14
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "cmbsalir"
            Description     =   "SALIR"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      Begin MSComctlLib.ImageList Img_opciones 
         Left            =   3240
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
               Picture         =   "FRM_INTERFACES_SIGIR.frx":1BB8
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_INTERFACES_SIGIR.frx":201F
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_INTERFACES_SIGIR.frx":2515
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_INTERFACES_SIGIR.frx":29A8
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_INTERFACES_SIGIR.frx":2E90
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_INTERFACES_SIGIR.frx":33A3
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_INTERFACES_SIGIR.frx":38E0
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_INTERFACES_SIGIR.frx":3D22
               Key             =   ""
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_INTERFACES_SIGIR.frx":41DC
               Key             =   ""
            EndProperty
            BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_INTERFACES_SIGIR.frx":46AF
               Key             =   ""
            EndProperty
            BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_INTERFACES_SIGIR.frx":4AF3
               Key             =   ""
            EndProperty
            BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_INTERFACES_SIGIR.frx":505A
               Key             =   ""
            EndProperty
            BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_INTERFACES_SIGIR.frx":5529
               Key             =   ""
            EndProperty
            BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_INTERFACES_SIGIR.frx":5948
               Key             =   ""
            EndProperty
            BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_INTERFACES_SIGIR.frx":5E40
               Key             =   ""
            EndProperty
            BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_INTERFACES_SIGIR.frx":6239
               Key             =   ""
            EndProperty
            BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_INTERFACES_SIGIR.frx":66BC
               Key             =   ""
            EndProperty
            BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_INTERFACES_SIGIR.frx":6B82
               Key             =   ""
            EndProperty
            BeginProperty ListImage19 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_INTERFACES_SIGIR.frx":7079
               Key             =   ""
            EndProperty
            BeginProperty ListImage20 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_INTERFACES_SIGIR.frx":752F
               Key             =   ""
            EndProperty
            BeginProperty ListImage21 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_INTERFACES_SIGIR.frx":78F4
               Key             =   ""
            EndProperty
            BeginProperty ListImage22 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_INTERFACES_SIGIR.frx":7CEA
               Key             =   ""
            EndProperty
            BeginProperty ListImage23 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_INTERFACES_SIGIR.frx":80E1
               Key             =   ""
            EndProperty
            BeginProperty ListImage24 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_INTERFACES_SIGIR.frx":84EA
               Key             =   ""
            EndProperty
            BeginProperty ListImage25 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FRM_INTERFACES_SIGIR.frx":89A8
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
End
Attribute VB_Name = "FRM_INTERFACES_SIGIR"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub ConCheck_Click(Index As Integer)

   SinCheck.Item(Index).Visible = Not SinCheck.Item(Index).Visible
   ConCheck.Item(Index).Visible = Not ConCheck.Item(Index).Visible
   DoEvents
   SinCheck.Item(Index).SetFocus
   
End Sub

Private Sub Form_Load()

    Me.Icon = FRM_MDI_PASIVO.Icon
    TXTFecha1.Text = GLB_Fecha_Proceso

    If Not funcRevisaProceso Then

        Me.Toolbar1.Buttons(2).Enabled = False
        Me.frame_interfaces_sigir.Enabled = False
        Me.frame_fecha_proceso.Enabled = False
    End If
End Sub



Function funcRevisaProceso() As Boolean
Dim Datos()

    funcRevisaProceso = False
    
    GLB_Envia = Array("PSV")
    
    If FUNC_EXECUTA_COMANDO_SQL("SP_CON_ESTADO_SWITCH", GLB_Envia) Then
        Do While FUNC_LEE_RETORNO_SQL(Datos())
        
            If (Datos(5) = 0 And Datos(6) = "DEVENGAMIENTO") And (Datos(5) = 0 And Datos(6) = "CONTABILIDAD") And (Datos(5) = 0 And Datos(6) = "MESA") Then
                MsgBox "Debe realizar Devengamiento, Contabilidad y Cierre de Mesa", vbExclamation
                Exit Function
            ElseIf Datos(5) = 0 And Datos(6) = "DEVENGAMIENTO" Then
                MsgBox "Para realizar las interfaces debe realizar primero el Devengamiento", vbExclamation
                Exit Function
            ElseIf Datos(5) = 0 And Datos(6) = "CONTABILIDAD" Then
                MsgBox "Para realizar las interfaces debe realizar primero el Contabilidad", vbExclamation
                Exit Function
            ElseIf Datos(5) = 0 And Datos(6) = "MESA" Then
                MsgBox "Para realizar las interfaces debe realizar primero el Cierre de Mesa", vbExclamation
                Exit Function
            ElseIf Datos(5) = 1 And Datos(6) = "FIN" Then
                MsgBox "Fin de día ya se ha realizado ", vbExclamation
                Exit Function
            End If
        Loop
    End If
    funcRevisaProceso = True
End Function

Private Sub SinCheck_Click(Index As Integer)
    ConCheck.Item(Index).left = SinCheck.Item(Index).left
    SinCheck.Item(Index).Visible = Not SinCheck.Item(Index).Visible
    ConCheck.Item(Index).Visible = Not ConCheck.Item(Index).Visible
    DoEvents
    ConCheck.Item(Index).SetFocus
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Dim bExisten_Marcados As Boolean
Dim nContador As Integer

    Select Case UCase(Button.Description)
        Case "INTERFAZ"
            For nContador = 0 To 3
                If ConCheck.Item(nContador).Visible = True Then
                    bExisten_Marcados = True
                End If
            Next nContador
            
            If bExisten_Marcados = False Then
                MsgBox "Debe seleccionar alguna interfaz ", vbInformation
                Screen.MousePointer = vbDefault
                Exit Sub
            End If
            
            Me.Lst_Interfaces.Clear
            If ConCheck.Item(0).Visible Then
                Call InterfazOperaciones(GLB_Ruta_Int_Operaciones, TXTFecha1.Text)
            End If
            
            If ConCheck.Item(1).Visible Then
                Call InterfazBalanceXOperacion(GLB_Ruta_Int_Balance, TXTFecha1.Text)
            End If
            
            If ConCheck.Item(2).Visible Then
                Call InterfazFlujoXOperacion(GLB_Ruta_Int_Flujos, TXTFecha1.Text)
            End If
            
            If ConCheck.Item(3).Visible Then
                Call InterfazClienteOperacion(GLB_Ruta_Int_ClienteOperacion, TXTFecha1.Text)
            End If
            
        Case "SALIR"
            Unload Me
    End Select
End Sub

Private Sub TXTFecha1_Change()
FRM_INTERFACES_SIGIR.Lst_Interfaces.Clear
End Sub
