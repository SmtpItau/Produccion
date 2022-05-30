VERSION 5.00
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "comctl32.ocx"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form frmInfValorizacion 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Form2"
   ClientHeight    =   2205
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   3945
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   2205
   ScaleWidth      =   3945
   ShowInTaskbar   =   0   'False
   Begin ComctlLib.Toolbar Toolbar1 
      Height          =   480
      Left            =   0
      TabIndex        =   0
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
      Caption         =   "Valorización"
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
      Height          =   1635
      Left            =   0
      TabIndex        =   1
      Top             =   570
      Width           =   3915
      Begin VB.Frame Frame2 
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
         Height          =   705
         Left            =   900
         TabIndex        =   2
         Top             =   330
         Width           =   2325
         Begin BACControles.TXTFecha txtFecProc 
            Height          =   285
            Left            =   390
            TabIndex        =   3
            Top             =   270
            Width           =   1365
            _ExtentX        =   2408
            _ExtentY        =   503
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
            Text            =   "26/07/2005"
         End
      End
      Begin VB.Image Image1 
         Height          =   480
         Left            =   360
         Picture         =   "frmInfValorizacion.frx":0000
         Top             =   360
         Width           =   480
      End
   End
   Begin ComctlLib.ImageList ImageList1 
      Left            =   0
      Top             =   0
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
            Picture         =   "frmInfValorizacion.frx":0442
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "frmInfValorizacion.frx":075C
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "frmInfValorizacion.frx":0A76
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "frmInfValorizacion"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Public TipoReporte As String
Dim RptName As String

Private Sub Form_Load()
Me.Icon = BACSwap.Icon
Me.Caption = "Informe de Valorización"
Me.Left = 10
Me.Top = 10
Me.txtFecProc.Text = gsBAC_Fecp
Me.txtFecProc.MaxDate = gsBAC_Fecp


Select Case TipoReporte
    Case "Flu": Frame1.Caption = "Informe Valorización por flujo"
                RptName = "rptMtmTasMonFlu.rpt"
    Case "Ope": Frame1.Caption = "Informe Valorización por Operación"
                RptName = "rptMtmTasMonOpe.rpt"
End Select


End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As ComctlLib.Button)

    With BACSwap.Crystal
    
        Call BacLimpiaParamCrw

        Select Case Button.Index
            Case 1: .Destination = crptToWindow
            Case 2: .Destination = crptToPrinter
            Case 3: Unload Me: Exit Sub
        End Select
        
        .ReportFileName = gsRPT_Path & RptName
        .StoredProcParam(0) = Format(txtFecProc.Text, "YYYYMMDD")
        .StoredProcParam(1) = GLB_LIBRO
        .StoredProcParam(2) = GLB_CARTERA_NORMATIVA
        .StoredProcParam(3) = GLB_SUB_CARTERA_NORMATIVA
        .StoredProcParam(4) = GLB_CARTERA
        .StoredProcParam(5) = GLB_AREA_RESPONSABLE
        
        .WindowTitle = Frame1.Caption
        .Connect = swConeccion
        .Action = 1 'Envio
            
    End With
    
End Sub
