VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{05BDEB52-1755-11D5-9109-000102BF881D}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacInfValeVista 
   Caption         =   "Informes de Vale Vistas y Ctas.Ctes."
   ClientHeight    =   3735
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4740
   ControlBox      =   0   'False
   Icon            =   "InformeValeVista.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Picture         =   "InformeValeVista.frx":030A
   ScaleHeight     =   3735
   ScaleWidth      =   4740
   StartUpPosition =   3  'Windows Default
   Begin VB.Frame Frame1 
      Height          =   3270
      Left            =   0
      TabIndex        =   3
      Top             =   495
      Width           =   4755
      Begin Threed.SSPanel SSPanel1 
         Height          =   3090
         Left            =   45
         TabIndex        =   4
         Top             =   120
         Width           =   4620
         _Version        =   65536
         _ExtentX        =   8149
         _ExtentY        =   5450
         _StockProps     =   15
         BackColor       =   12632256
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Begin VB.Frame Frame3 
            Caption         =   "Fecha Final"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   600
            Left            =   2325
            TabIndex        =   26
            Top             =   0
            Width           =   2235
            Begin BacControles.txtFecha txtFecha2 
               Height          =   255
               Left            =   465
               TabIndex        =   2
               Top             =   225
               Width           =   1455
               _ExtentX        =   2566
               _ExtentY        =   450
               Text            =   "11/05/2001"
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               MinDate         =   -328716
               MaxDate         =   2958465
            End
         End
         Begin VB.Frame Frame2 
            Caption         =   "Fecha Inicio"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   600
            Left            =   30
            TabIndex        =   25
            Top             =   0
            Width           =   2310
            Begin BacControles.txtFecha txtFecha1 
               Height          =   255
               Left            =   465
               TabIndex        =   1
               Top             =   225
               Width           =   1485
               _ExtentX        =   2619
               _ExtentY        =   450
               Text            =   "11/05/2001"
               BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
                  Name            =   "MS Sans Serif"
                  Size            =   8.25
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               MinDate         =   -328716
               MaxDate         =   2958465
            End
         End
         Begin VB.Frame Frame6 
            Caption         =   "Listados"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H8000000D&
            Height          =   2370
            Left            =   30
            TabIndex        =   5
            Top             =   630
            Width           =   4500
            Begin VB.PictureBox ConCheck 
               BorderStyle     =   0  'None
               Height          =   330
               Index           =   1
               Left            =   3555
               Picture         =   "InformeValeVista.frx":229B4C
               ScaleHeight     =   330
               ScaleWidth      =   330
               TabIndex        =   24
               Top             =   705
               Visible         =   0   'False
               Width           =   330
            End
            Begin VB.PictureBox ConCheck 
               BorderStyle     =   0  'None
               Height          =   330
               Index           =   0
               Left            =   2985
               Picture         =   "InformeValeVista.frx":229CA6
               ScaleHeight     =   330
               ScaleWidth      =   330
               TabIndex        =   23
               Top             =   720
               Visible         =   0   'False
               Width           =   330
            End
            Begin VB.PictureBox SinCheck 
               BorderStyle     =   0  'None
               Height          =   330
               Index           =   1
               Left            =   3585
               Picture         =   "InformeValeVista.frx":229E00
               ScaleHeight     =   330
               ScaleWidth      =   375
               TabIndex        =   22
               Top             =   375
               Visible         =   0   'False
               Width           =   375
            End
            Begin VB.PictureBox SinCheck 
               BorderStyle     =   0  'None
               Height          =   330
               Index           =   0
               Left            =   2970
               Picture         =   "InformeValeVista.frx":229F5A
               ScaleHeight     =   330
               ScaleWidth      =   375
               TabIndex        =   21
               Top             =   345
               Visible         =   0   'False
               Width           =   375
            End
            Begin VB.PictureBox ConCheck 
               BorderStyle     =   0  'None
               Height          =   330
               Index           =   6
               Left            =   345
               Picture         =   "InformeValeVista.frx":22A0B4
               ScaleHeight     =   330
               ScaleWidth      =   330
               TabIndex        =   20
               Top             =   1860
               Visible         =   0   'False
               Width           =   330
            End
            Begin VB.PictureBox ConCheck 
               BorderStyle     =   0  'None
               Height          =   330
               Index           =   5
               Left            =   345
               Picture         =   "InformeValeVista.frx":22A20E
               ScaleHeight     =   330
               ScaleWidth      =   330
               TabIndex        =   19
               Top             =   1500
               Visible         =   0   'False
               Width           =   330
            End
            Begin VB.PictureBox ConCheck 
               BorderStyle     =   0  'None
               Height          =   330
               Index           =   4
               Left            =   345
               Picture         =   "InformeValeVista.frx":22A368
               ScaleHeight     =   330
               ScaleWidth      =   330
               TabIndex        =   18
               Top             =   1080
               Visible         =   0   'False
               Width           =   330
            End
            Begin VB.PictureBox ConCheck 
               BorderStyle     =   0  'None
               Height          =   330
               Index           =   3
               Left            =   345
               Picture         =   "InformeValeVista.frx":22A4C2
               ScaleHeight     =   330
               ScaleWidth      =   330
               TabIndex        =   17
               Top             =   705
               Visible         =   0   'False
               Width           =   330
            End
            Begin VB.PictureBox ConCheck 
               BorderStyle     =   0  'None
               Height          =   330
               Index           =   2
               Left            =   345
               Picture         =   "InformeValeVista.frx":22A61C
               ScaleHeight     =   330
               ScaleWidth      =   330
               TabIndex        =   16
               Top             =   345
               Visible         =   0   'False
               Width           =   330
            End
            Begin VB.PictureBox SinCheck 
               BorderStyle     =   0  'None
               Height          =   330
               Index           =   6
               Left            =   345
               Picture         =   "InformeValeVista.frx":22A776
               ScaleHeight     =   330
               ScaleWidth      =   375
               TabIndex        =   15
               Top             =   1875
               Width           =   375
            End
            Begin VB.PictureBox SinCheck 
               BorderStyle     =   0  'None
               Height          =   330
               Index           =   5
               Left            =   345
               Picture         =   "InformeValeVista.frx":22A8D0
               ScaleHeight     =   330
               ScaleWidth      =   375
               TabIndex        =   14
               Top             =   1500
               Width           =   375
            End
            Begin VB.PictureBox SinCheck 
               BorderStyle     =   0  'None
               Height          =   330
               Index           =   4
               Left            =   345
               Picture         =   "InformeValeVista.frx":22AA2A
               ScaleHeight     =   330
               ScaleWidth      =   375
               TabIndex        =   13
               Top             =   1095
               Width           =   375
            End
            Begin VB.PictureBox SinCheck 
               BorderStyle     =   0  'None
               Height          =   330
               Index           =   3
               Left            =   345
               Picture         =   "InformeValeVista.frx":22AB84
               ScaleHeight     =   330
               ScaleWidth      =   375
               TabIndex        =   12
               Top             =   675
               Width           =   375
            End
            Begin VB.PictureBox SinCheck 
               BorderStyle     =   0  'None
               Height          =   330
               Index           =   2
               Left            =   345
               Picture         =   "InformeValeVista.frx":22ACDE
               ScaleHeight     =   330
               ScaleWidth      =   375
               TabIndex        =   11
               Top             =   345
               Width           =   375
            End
            Begin VB.Label Label7 
               Caption         =   "Abonos o Cargos en Cta.Cte.Nulos"
               ForeColor       =   &H8000000D&
               Height          =   330
               Left            =   1035
               TabIndex        =   10
               Top             =   1920
               Width           =   2805
            End
            Begin VB.Label Label6 
               Caption         =   "Abonos o Cargos en Cta.Cte Emitidos"
               ForeColor       =   &H8000000D&
               Height          =   285
               Left            =   1035
               TabIndex        =   9
               Top             =   1575
               Width           =   3030
            End
            Begin VB.Label Label5 
               Caption         =   "Vale Vistas Emitidos por Sistemas"
               ForeColor       =   &H8000000D&
               Height          =   345
               Left            =   1035
               TabIndex        =   8
               Top             =   1185
               Width           =   2700
            End
            Begin VB.Label Label4 
               Caption         =   "Vale Vistas Nulos"
               ForeColor       =   &H8000000D&
               Height          =   270
               Left            =   1035
               TabIndex        =   7
               Top             =   795
               Width           =   2295
            End
            Begin VB.Label Label3 
               Caption         =   "Vale Vistas Emitidos"
               ForeColor       =   &H8000000D&
               Height          =   270
               Left            =   1035
               TabIndex        =   6
               Top             =   405
               Width           =   2235
            End
         End
      End
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   4740
      _ExtentX        =   8361
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Imprimir"
            Object.Tag             =   "1"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            Object.Tag             =   "2"
            ImageIndex      =   2
         EndProperty
      EndProperty
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   2445
         Top             =   105
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   22
         ImageHeight     =   22
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   2
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "InformeValeVista.frx":22AE38
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "InformeValeVista.frx":22B152
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
End
Attribute VB_Name = "BacInfValeVista"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Cmd_Generar()
Dim Nombre_Rpt      As String: Nombre_Rpt = ""
Dim TipRep          As String
Dim FechaInicio     As String
Dim fechaFinal      As String
Dim AuxTit          As String
Const Azul = &H8000000D
Const Negro = &H0&
Const Blanco = &HFFFFFF
Const Gris = &H808080
On Error GoTo Control:

FechaInicio = Format(txtFecha1.Text, "yyyy-mm-dd 00:00:00.000")
fechaFinal = Format(txtFecha2.Text, "yyyy-mm-dd 00:00:00.000")
Screen.MousePointer = 11

'Opciones de Cartera
Dim Inf%, X%
       
    
    
    
For I = 0 To ConCheck.Count - 1
    
    Call limpiar_cristal
    
    If ConCheck.Item(I).Visible = True Then
        Select Case I
        
               Case 0:
               Case 1:
                                    
               ' Vale Vistas Emitidos
               Case 2:
                    TitRpt = "VALE VISTAS EMITIDOS"
                    BacTrader.bacrpt.ReportFileName = RptList_Path & "InfValeVista.RPT"
                    BacTrader.bacrpt.StoredProcParam(0) = "E"
                    BacTrader.bacrpt.StoredProcParam(1) = 2
                    BacTrader.bacrpt.StoredProcParam(2) = FechaInicio
                    BacTrader.bacrpt.StoredProcParam(3) = fechaFinal
                    BacTrader.bacrpt.Formulas(0) = "Titulo='" & TitRpt & "'"
                    BacTrader.bacrpt.Formulas(1) = "Usuario='" & gsBac_User & "'"
                    BacTrader.bacrpt.Connect = CONECCION
                    BacTrader.bacrpt.Action = 1
                    
               
               ' Vale Vistas Nulo
               Case 3:
                    TitRpt = "VALE VISTAS NULOS"
                    BacTrader.bacrpt.ReportFileName = RptList_Path & "InfValeVista.RPT"
                    BacTrader.bacrpt.StoredProcParam(0) = "A"
                    BacTrader.bacrpt.StoredProcParam(1) = 2
                    BacTrader.bacrpt.StoredProcParam(2) = FechaInicio
                    BacTrader.bacrpt.StoredProcParam(3) = fechaFinal
                    BacTrader.bacrpt.Formulas(0) = "Titulo='" & TitRpt & "'"
                    BacTrader.bacrpt.Formulas(1) = "Usuario='" & gsBac_User & "'"
                    BacTrader.bacrpt.Connect = CONECCION
                    BacTrader.bacrpt.Action = 1
                    
                
               'Vale Vista Emitidos por Sistema
               Case 4
                    TitRpt = "VALE VISTAS POR SISTEMA"
                    BacTrader.bacrpt.ReportFileName = RptList_Path & "InfValeVistaSist.RPT"
                    BacTrader.bacrpt.StoredProcParam(0) = "E"
                    BacTrader.bacrpt.StoredProcParam(1) = 2
                    BacTrader.bacrpt.StoredProcParam(2) = FechaInicio
                    BacTrader.bacrpt.StoredProcParam(3) = fechaFinal
                    BacTrader.bacrpt.Formulas(0) = "Titulo='" & TitRpt & "'"
                    BacTrader.bacrpt.Formulas(1) = "Usuario='" & gsBac_User & "'"
                    BacTrader.bacrpt.Connect = CONECCION
                    BacTrader.bacrpt.Action = 1
                    
               'Abonos o Cargos en Cuenta Corriente emitidos
               Case 5
                    TitRpt = "CUENTAS CORRIENTES EMITIDAS"
                    BacTrader.bacrpt.ReportFileName = RptList_Path & "InfCtaCte.RPT"
                    BacTrader.bacrpt.StoredProcParam(0) = "E"
                    BacTrader.bacrpt.StoredProcParam(1) = 11
                    BacTrader.bacrpt.StoredProcParam(2) = FechaInicio
                    BacTrader.bacrpt.StoredProcParam(3) = fechaFinal
                    BacTrader.bacrpt.Formulas(0) = "Titulo='" & TitRpt & "'"
                    BacTrader.bacrpt.Formulas(1) = "Usuario='" & gsBac_User & "'"
                    BacTrader.bacrpt.Connect = CONECCION
                    BacTrader.bacrpt.Action = 1
                    
                'Abonos o Cargos en Cuenta Corriente nulos
                Case 6
                    TitRpt = "CUENTAS CORRIENTES NULAS"
                    BacTrader.bacrpt.ReportFileName = RptList_Path & "InfCtaCte.RPT"
                    BacTrader.bacrpt.StoredProcParam(0) = "A"
                    BacTrader.bacrpt.StoredProcParam(1) = 11
                    BacTrader.bacrpt.StoredProcParam(2) = FechaInicio
                    BacTrader.bacrpt.StoredProcParam(3) = fechaFinal
                    BacTrader.bacrpt.Formulas(0) = "Titulo='" & TitRpt & "'"
                    BacTrader.bacrpt.Formulas(1) = "Usuario='" & gsBac_User & "'"
                    BacTrader.bacrpt.Connect = CONECCION
                    BacTrader.bacrpt.Action = 1
                    
                
                
        End Select
    End If

Next

Screen.MousePointer = 0

Exit Sub

Control:

    MsgBox "Problemas al generar Listado de Cartera. " & err.Description & ", " & err.Number, vbCritical, "BACTRADER"
    Screen.MousePointer = 0
End Sub

Sub verificar_fecha(fech As Date)
Dim dateaux As String
'procedimiento que comprueba las fechas, tomando en cuenta la fecha actual
   dateaux = Date
   If (fech > dateaux) Then
      'error
      MsgBox "Fecha fuera de rango ", vbOKCancel, "Error de Fecha"
      ok = 0
   Else
      ok = 1
   End If
End Sub

Sub verificar_fecha1(fech As Date, fech1 As Date)
Dim dateaux As String
'procedimiento que comprueba las fechas, tomando en cuenta la fecha actual
   dateaux = Date
If (fech > dateaux) Then
   'error
    MsgBox "Fecha fuera de rango ", vbOKCancel, "Error de Fecha"
    ok = 0
Else
    If (fech < fech1) Then
        MsgBox "Fecha Inferior a la Fecha de Inicioo ", vbOKCancel, "Error de Fecha"
        ok = 0
    Else
        ok = 1
    End If
End If
End Sub

Private Sub txtFecha1_KeyDown(KEYCODE As Integer, Shift As Integer)
Dim fechaux1 As Date
Dim fechaux2 As Date
   If KEYCODE = 13 Then
      fechaux1 = txtFecha1.Text
      Call verificar_fecha(fechaux1)
      If ok = 1 Then
        txtFecha2.SetFocus
      Else
        txtFecha1.Text = Format(Date, "dd/mm/yyyy")
        txtFecha1.SetFocus
      End If
   End If
End Sub

Private Sub txtFecha2_Keydown(KEYCODE As Integer, Shift As Integer)
Dim fechaux1 As Date
Dim fechaux2 As Date
Dim fechaux
   If KEYCODE = 13 Then
      fechaux1 = txtFecha1.Text
      fechaux2 = txtFecha2.Text
      Call verificar_fecha1(fechaux2, fechaux1)
      If ok = 1 Then
        txtTipo.SetFocus
      Else
        txtFecha2.Text = Format(Date, "dd/mm/yyyy")
        txtFecha2.SetFocus
      End If
   End If

End Sub

Private Sub ConCheck_Click(Index As Integer)

    SinCheck.Item(Index).Visible = Not SinCheck.Item(Index).Visible
    ConCheck.Item(Index).Visible = Not ConCheck.Item(Index).Visible

End Sub

Private Sub SinCheck_Click(Index As Integer)
    ConCheck.Item(Index).Left = SinCheck.Item(Index).Left
    SinCheck.Item(Index).Visible = Not SinCheck.Item(Index).Visible
    ConCheck.Item(Index).Visible = Not ConCheck.Item(Index).Visible
End Sub

Private Sub Form_Load()
Dim X As Integer
    Me.Icon = BacTrader.Icon
    Me.Top = 0
    Me.Left = 0
    Screen.MousePointer = 11
    giAceptar% = False
    txtFecha2.Enabled = False
  
    For X = 1 To ConCheck.Count - 1
        ConCheck.Item(I).Visible = False
    Next



    Screen.MousePointer = 0

    Me.Top = 1150
    Me.Left = 50
  
End Sub



Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
Select Case Button.Index

Case 1
    'Genera Informes
    Call Cmd_Generar
Case 2
    Unload Me
    
End Select

End Sub

Private Sub txtFecha1_GotFocus()
    txtFecha1.BackColor = Azul
    txtFecha1.ForeColor = Blanco
End Sub

Private Sub txtFecha1_LostFocus()
    txtFecha1.BackColor = Blanco
    txtFecha1.ForeColor = Negro
End Sub

Private Sub txtFecha2_GotFocus()
    txtFecha2.BackColor = Azul
    txtFecha2.ForeColor = Blanco
End Sub

Private Sub txtFecha2_LostFocus()
    txtFecha2.BackColor = Blanco
    txtFecha2.ForeColor = Negro
End Sub

