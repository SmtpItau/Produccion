VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form Bac_Procesos 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Estado de Procesos"
   ClientHeight    =   5100
   ClientLeft      =   2850
   ClientTop       =   1350
   ClientWidth     =   6255
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5100
   ScaleWidth      =   6255
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   660
      Left            =   0
      TabIndex        =   6
      Top             =   0
      Width           =   6255
      _ExtentX        =   11033
      _ExtentY        =   1164
      ButtonWidth     =   1032
      ButtonHeight    =   1005
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Imprimir Reporte en Pantalla"
            ImageIndex      =   14
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Imprimir"
            ImageIndex      =   10
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "salir"
            ImageIndex      =   12
         EndProperty
      EndProperty
   End
   Begin VB.Frame Frm_procesos 
      Caption         =   "Procesos Realizados"
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000D&
      Height          =   4305
      Left            =   30
      TabIndex        =   0
      Top             =   735
      Width           =   6195
      Begin VB.CheckBox ch_Ctb 
         Caption         =   "Proceso de Contabilidad"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000080&
         Height          =   375
         Left            =   180
         TabIndex        =   16
         Top             =   2250
         Width           =   2805
      End
      Begin VB.CheckBox ch_pd 
         Caption         =   "Inicio de Día"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000080&
         Height          =   375
         Left            =   180
         TabIndex        =   1
         Top             =   795
         Width           =   2205
      End
      Begin VB.CheckBox ch_tm 
         Caption         =   "Tasas de Mercado"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000080&
         Height          =   375
         Left            =   195
         TabIndex        =   4
         Top             =   2730
         Width           =   2550
      End
      Begin VB.CheckBox ch_dv 
         Caption         =   "Proceso de Devengamiento"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000080&
         Height          =   375
         Left            =   195
         TabIndex        =   3
         Top             =   1770
         Width           =   2805
      End
      Begin VB.CheckBox ch_mesa 
         Caption         =   "Bloqueo de Mesa"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000080&
         Height          =   375
         Left            =   195
         TabIndex        =   2
         Top             =   1305
         Width           =   2565
      End
      Begin VB.CheckBox ch_fd 
         Caption         =   "Fin De Día"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000080&
         Height          =   375
         Left            =   195
         TabIndex        =   5
         Top             =   3225
         Width           =   2235
      End
      Begin VB.Label lbl_ctb 
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
         Height          =   240
         Left            =   3090
         TabIndex        =   17
         Top             =   2325
         Width           =   3030
      End
      Begin VB.Label Label3 
         Caption         =   "Fecha y Hora"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   255
         Left            =   3105
         TabIndex        =   15
         Top             =   300
         Width           =   2475
      End
      Begin VB.Label Label1 
         Caption         =   "Procesos"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   255
         Left            =   180
         TabIndex        =   14
         Top             =   300
         Width           =   2475
      End
      Begin VB.Label lbl_fecproc 
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
         ForeColor       =   &H00404040&
         Height          =   300
         Left            =   195
         TabIndex        =   13
         Top             =   3795
         Width           =   4680
      End
      Begin VB.Label lbl_fd 
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
         Height          =   240
         Left            =   3105
         TabIndex        =   12
         Top             =   3315
         Width           =   3030
      End
      Begin VB.Label lbl_tm 
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
         Height          =   240
         Left            =   3105
         TabIndex        =   11
         Top             =   2820
         Width           =   3030
      End
      Begin VB.Label lbl_dv 
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
         Height          =   240
         Left            =   3105
         TabIndex        =   10
         Top             =   1815
         Width           =   3030
      End
      Begin VB.Label lbl_mesa 
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
         Height          =   240
         Left            =   3105
         TabIndex        =   9
         Top             =   1335
         Width           =   3030
      End
      Begin VB.Label lbl_id 
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
         Height          =   240
         Left            =   3105
         TabIndex        =   7
         Top             =   855
         Width           =   3030
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   7875
      Top             =   2775
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   32
      ImageHeight     =   32
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   18
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_procesos.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_procesos.frx":031A
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_procesos.frx":076C
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_procesos.frx":0BBE
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_procesos.frx":0ED8
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_procesos.frx":11F2
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_procesos.frx":1644
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_procesos.frx":179E
            Key             =   ""
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_procesos.frx":1BF0
            Key             =   ""
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_procesos.frx":2042
            Key             =   ""
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_procesos.frx":235C
            Key             =   ""
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_procesos.frx":2676
            Key             =   ""
         EndProperty
         BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_procesos.frx":27D0
            Key             =   ""
         EndProperty
         BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_procesos.frx":2C22
            Key             =   ""
         EndProperty
         BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_procesos.frx":3074
            Key             =   ""
         EndProperty
         BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_procesos.frx":338E
            Key             =   ""
         EndProperty
         BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_procesos.frx":36A8
            Key             =   ""
         EndProperty
         BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "bac_procesos.frx":39C2
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.Label Label2 
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
      Height          =   240
      Left            =   0
      TabIndex        =   8
      Top             =   0
      Width           =   1770
   End
End
Attribute VB_Name = "Bac_Procesos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim Pd As Double
Dim Mesa As Double
Dim Dv As Double
Dim Tm As Double
Dim Fd As Double
Dim modi As Double
Dim Ctb As Double

Function Busca_procesos()
    Dim Datos()
    If Bac_Sql_Execute("SVC_PRC_CTR_EST") Then
        Do While Bac_SQL_Fetch(Datos)
            Pd = Datos(1)
            Mesa = Datos(2)
            Dv = Datos(3)
            Tm = Datos(4)
            Fd = Datos(5)
            Ctb = Datos(6)
        Loop
    End If

    envia = Array()
    AddParam envia, "in"
    AddParam envia, gsBac_Fecp
    If Bac_Sql_Execute("SVC_PRC_LEE_HOR", envia) Then
        Do While Bac_SQL_Fetch(Datos)
            lbl_id.Caption = Format(Datos(1), "DD/MM/YYYY HH:MM:SS")
            If Format(Datos(1), "DD/MM/YYYY") = Format(gsBac_Fecp, "DD/MM/YYYY") Then
                lbl_id.ForeColor = vbBlue
            Else
                lbl_id.ForeColor = vbBlack
            End If
        Loop
    End If
'---------------------------------------------------------------------------------------------------------------
    envia = Array()
    AddParam envia, "me"
    AddParam envia, gsBac_Fecp
    If Bac_Sql_Execute("SVC_PRC_LEE_HOR", envia) Then
        Do While Bac_SQL_Fetch(DATOS)
            lbl_mesa.Caption = Format(DATOS(1), "DD/MM/YYYY HH:MM:SS")
            If Format(DATOS(1), "DD/MM/YYYY") = Format(gsBac_Fecp, "DD/MM/YYYY") Then
                lbl_mesa.ForeColor = vbBlue
            Else
                lbl_mesa.ForeColor = vbBlack
            End If
        Loop
    End If
'---------------------------------------------------------------------------------------------------------------
    envia = Array()
    AddParam envia, "dv"
    AddParam envia, gsBac_Fecp
    If Bac_Sql_Execute("SVC_PRC_LEE_HOR", envia) Then
        Do While Bac_SQL_Fetch(DATOS)
            lbl_dv.Caption = Format(DATOS(1), "DD/MM/YYYY HH:MM:SS")
            If Format(DATOS(1), "DD/MM/YYYY") = Format(gsBac_Fecp, "DD/MM/YYYY") Then
                lbl_dv.ForeColor = vbBlue
            Else
                lbl_dv.ForeColor = vbBlack
            End If
        Loop
    End If
'---------------------------------------------------------------------------------------------------------------
    envia = Array()
    AddParam envia, "tm"
    AddParam envia, gsBac_Fecp
    If Bac_Sql_Execute("SVC_PRC_LEE_HOR", envia) Then
        Do While Bac_SQL_Fetch(DATOS)
            lbl_tm.Caption = Format(DATOS(1), "DD/MM/YYYY HH:MM:SS")
            If Format(DATOS(1), "DD/MM/YYYY") = Format(gsBac_Fecp, "DD/MM/YYYY") Then
                lbl_tm.ForeColor = vbBlue
            Else
                lbl_tm.ForeColor = vbBlack
            End If
        Loop
    End If
'---------------------------------------------------------------------------------------------------------------
    envia = Array()
    AddParam envia, "fd"
    AddParam envia, gsBac_Fecp
    If Bac_Sql_Execute("SVC_PRC_LEE_HOR", envia) Then
        Do While Bac_SQL_Fetch(DATOS)
            lbl_fd.Caption = Format(DATOS(1), "DD/MM/YYYY HH:MM:SS")
            If Format(DATOS(1), "DD/MM/YYYY") = Format(gsBac_Fecp, "DD/MM/YYYY") Then
                lbl_fd.ForeColor = vbBlue
            Else
                lbl_fd.ForeColor = vbBlack
            End If
        Loop
    End If
'---------------------------------------------------------------------------------------------------------------
    envia = Array()
    AddParam envia, "CTB"
    AddParam envia, gsBac_Fecp
    If Bac_Sql_Execute("SVC_PRC_LEE_HOR", envia) Then
        Do While Bac_SQL_Fetch(DATOS)
            lbl_ctb.Caption = Format(DATOS(1), "DD/MM/YYYY HH:MM:SS")
            If Format(DATOS(1), "DD/MM/YYYY") = Format(gsBac_Fecp, "DD/MM/YYYY") Then
                lbl_ctb.ForeColor = vbBlue
            Else
                lbl_ctb.ForeColor = vbBlack
            End If
        Loop
    End If
    
End Function

Function imprimit_reporte(modi)
    BAC_INVERSIONES.BacRpt.ReportFileName = RptList_Path & "Informe_De_Estado_Procesos.rpt"
    BAC_INVERSIONES.BacRpt.WindowTitle = "INFORME DE ESTADO DE PROCESOS"
    If modi = 1 Then
        BAC_INVERSIONES.BacRpt.Destination = crptToWindow
    Else
        BAC_INVERSIONES.BacRpt.Destination = crptToPrinter
    End If
    BAC_INVERSIONES.BacRpt.Connect = CONECCION
    BAC_INVERSIONES.BacRpt.Action = 1
    Call limpiar_cristal
End Function

Private Sub Form_Load()
    Me.Icon = BAC_INVERSIONES.Icon
    Move 0, 0
    Call Busca_procesos
    If Pd = 1 Then
        ch_pd.Value = 1
    Else
        ch_pd.Value = 0
    End If
    If Mesa = 1 Then
        ch_mesa.Value = 1
    Else
        ch_mesa.Value = 0
    End If
    If Dv = 1 Then
        ch_dv.Value = 1
    Else
        ch_dv.Value = 0
    End If
    If Tm = 1 Then
        ch_tm.Value = 1
    Else
        ch_tm.Value = 0
    End If
    If Fd = 1 Then
        ch_fd.Value = 1
    Else
        ch_fd.Value = 0
    End If
    If Ctb = 1 Then
        ch_Ctb.Value = 1
    Else
        ch_Ctb.Value = 0
    End If
    
    If ch_fd.Value = 1 Then
        ch_pd.Value = 1
        ch_mesa.Value = 1
        ch_dv.Value = 1
        ch_tm.Value = 1
        ch_Ctb.Value = 1
    End If
    
    lbl_fecproc.Caption = "Fecha De Proceso :  " & Format(gsBac_Fecp, "DD/MM/YYYY")
    
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
    Select Case Button.Index
        Case 1
            Screen.MousePointer = 11
            Call imprimit_reporte(1)
            Screen.MousePointer = 0
        Case 2
            Screen.MousePointer = 11
            Call imprimit_reporte(2)
            Screen.MousePointer = 0
        Case 3
            Unload Me
    End Select
End Sub

