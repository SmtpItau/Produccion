VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BacControles.ocx"
Begin VB.Form BacRentabilidad 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Rentabilidad"
   ClientHeight    =   5175
   ClientLeft      =   3015
   ClientTop       =   1335
   ClientWidth     =   4320
   Icon            =   "BacRentabilidad.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   ScaleHeight     =   5175
   ScaleWidth      =   4320
   Begin Threed.SSPanel SSPanel1 
      Height          =   4455
      Left            =   30
      TabIndex        =   1
      Top             =   600
      Width           =   4215
      _Version        =   65536
      _ExtentX        =   7435
      _ExtentY        =   7858
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
      Begin VB.Frame Frame2 
         Height          =   855
         Left            =   120
         TabIndex        =   23
         Top             =   120
         Width           =   3615
         Begin BACControles.TXTFecha TxtFecha 
            Height          =   255
            Left            =   960
            TabIndex        =   25
            Top             =   360
            Width           =   1335
            _ExtentX        =   2355
            _ExtentY        =   450
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
            Text            =   "23/11/2001"
         End
         Begin VB.Label Label1 
            Caption         =   "Fecha"
            ForeColor       =   &H8000000D&
            Height          =   255
            Left            =   240
            TabIndex        =   24
            Top             =   360
            Width           =   615
         End
      End
      Begin VB.Frame Frame3 
         Caption         =   "Consulta"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   12
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   1410
         Left            =   0
         TabIndex        =   7
         Top             =   4680
         Visible         =   0   'False
         Width           =   3615
         Begin VB.ComboBox txtMes 
            Height          =   315
            ItemData        =   "BacRentabilidad.frx":030A
            Left            =   1200
            List            =   "BacRentabilidad.frx":0332
            Style           =   2  'Dropdown List
            TabIndex        =   22
            Top             =   360
            Width           =   825
         End
         Begin VB.TextBox txtAño 
            Alignment       =   1  'Right Justify
            Height          =   330
            Left            =   2640
            MaxLength       =   4
            TabIndex        =   13
            Top             =   360
            Width           =   615
         End
         Begin VB.ComboBox cmbUsuario 
            ForeColor       =   &H00000000&
            Height          =   315
            ItemData        =   "BacRentabilidad.frx":035D
            Left            =   840
            List            =   "BacRentabilidad.frx":0364
            Style           =   2  'Dropdown List
            TabIndex        =   8
            Top             =   840
            Width           =   2415
         End
         Begin VB.Label lblEtiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Año"
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   3
            Left            =   2280
            TabIndex        =   12
            Top             =   480
            Width           =   285
         End
         Begin VB.Label lblEtiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Mes"
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   2
            Left            =   840
            TabIndex        =   11
            Top             =   480
            Width           =   300
         End
         Begin VB.Label lblEtiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Fecha"
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   0
            Left            =   120
            TabIndex        =   10
            Top             =   480
            Width           =   450
         End
         Begin VB.Label lblEtiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Usuario"
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   1
            Left            =   120
            TabIndex        =   9
            Top             =   840
            Width           =   540
         End
      End
      Begin VB.Frame Frame1 
         Caption         =   "Listados  de Cartera "
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   12
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   -1  'True
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   3195
         Left            =   120
         TabIndex        =   2
         Top             =   1080
         Width           =   3855
         Begin VB.PictureBox SinCheck 
            BorderStyle     =   0  'None
            Height          =   330
            Index           =   5
            Left            =   240
            Picture         =   "BacRentabilidad.frx":036F
            ScaleHeight     =   330
            ScaleWidth      =   390
            TabIndex        =   30
            Top             =   2640
            Width           =   390
         End
         Begin VB.PictureBox ConCheck 
            BorderStyle     =   0  'None
            Height          =   330
            Index           =   5
            Left            =   3390
            Picture         =   "BacRentabilidad.frx":04C9
            ScaleHeight     =   330
            ScaleWidth      =   330
            TabIndex        =   29
            Top             =   2640
            Width           =   330
         End
         Begin VB.PictureBox ConCheck 
            BorderStyle     =   0  'None
            Height          =   330
            Index           =   4
            Left            =   3390
            Picture         =   "BacRentabilidad.frx":0623
            ScaleHeight     =   330
            ScaleWidth      =   330
            TabIndex        =   27
            Top             =   2160
            Width           =   330
         End
         Begin VB.PictureBox SinCheck 
            BorderStyle     =   0  'None
            Height          =   330
            Index           =   4
            Left            =   240
            Picture         =   "BacRentabilidad.frx":077D
            ScaleHeight     =   330
            ScaleWidth      =   390
            TabIndex        =   26
            Top             =   2160
            Width           =   390
         End
         Begin VB.PictureBox SinCheck 
            BorderStyle     =   0  'None
            Height          =   330
            Index           =   0
            Left            =   240
            Picture         =   "BacRentabilidad.frx":08D7
            ScaleHeight     =   330
            ScaleWidth      =   375
            TabIndex        =   21
            Top             =   360
            Width           =   375
         End
         Begin VB.PictureBox ConCheck 
            BorderStyle     =   0  'None
            Height          =   330
            Index           =   0
            Left            =   3390
            Picture         =   "BacRentabilidad.frx":0A31
            ScaleHeight     =   330
            ScaleWidth      =   330
            TabIndex        =   20
            Top             =   360
            Visible         =   0   'False
            Width           =   330
         End
         Begin VB.PictureBox SinCheck 
            BorderStyle     =   0  'None
            Height          =   330
            Index           =   1
            Left            =   240
            Picture         =   "BacRentabilidad.frx":0B8B
            ScaleHeight     =   330
            ScaleWidth      =   375
            TabIndex        =   19
            Top             =   765
            Width           =   375
         End
         Begin VB.PictureBox SinCheck 
            BorderStyle     =   0  'None
            Height          =   330
            Index           =   3
            Left            =   240
            Picture         =   "BacRentabilidad.frx":0CE5
            ScaleHeight     =   330
            ScaleWidth      =   390
            TabIndex        =   18
            Top             =   1680
            Width           =   390
         End
         Begin VB.PictureBox SinCheck 
            BorderStyle     =   0  'None
            Height          =   330
            Index           =   2
            Left            =   240
            Picture         =   "BacRentabilidad.frx":0E3F
            ScaleHeight     =   330
            ScaleWidth      =   375
            TabIndex        =   17
            Top             =   1170
            Width           =   375
         End
         Begin VB.PictureBox ConCheck 
            BorderStyle     =   0  'None
            Height          =   330
            Index           =   1
            Left            =   3390
            Picture         =   "BacRentabilidad.frx":0F99
            ScaleHeight     =   330
            ScaleWidth      =   330
            TabIndex        =   16
            Top             =   765
            Width           =   330
         End
         Begin VB.PictureBox ConCheck 
            BorderStyle     =   0  'None
            Height          =   330
            Index           =   2
            Left            =   3390
            Picture         =   "BacRentabilidad.frx":10F3
            ScaleHeight     =   330
            ScaleWidth      =   330
            TabIndex        =   15
            Top             =   1200
            Width           =   330
         End
         Begin VB.PictureBox ConCheck 
            BorderStyle     =   0  'None
            Height          =   330
            Index           =   3
            Left            =   3390
            Picture         =   "BacRentabilidad.frx":124D
            ScaleHeight     =   330
            ScaleWidth      =   330
            TabIndex        =   14
            Top             =   1680
            Width           =   330
         End
         Begin VB.Label Etiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Rentabilidad Ventas con Pactos"
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   5
            Left            =   720
            TabIndex        =   31
            Top             =   2640
            Width           =   2280
         End
         Begin VB.Label Etiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Rentabilidad Compras con Pactos"
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   4
            Left            =   720
            TabIndex        =   28
            Top             =   2160
            Width           =   2400
         End
         Begin VB.Label Etiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Rentabilidad Interbancarios"
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   2
            Left            =   720
            TabIndex        =   6
            Top             =   1215
            Width           =   1935
         End
         Begin VB.Label Etiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Rentabilidad Cartera"
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   1
            Left            =   720
            TabIndex        =   5
            Top             =   810
            Width           =   1440
         End
         Begin VB.Label Etiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Resumen Rentabilidad "
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   0
            Left            =   720
            TabIndex        =   4
            Top             =   405
            Width           =   1650
         End
         Begin VB.Label Etiqueta 
            AutoSize        =   -1  'True
            Caption         =   "Rentabilidad Ventas Definitivas"
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   3
            Left            =   720
            TabIndex        =   3
            Top             =   1680
            Width           =   2205
         End
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   3360
      Top             =   0
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   3
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacRentabilidad.frx":13A7
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacRentabilidad.frx":16C1
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacRentabilidad.frx":1B15
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Height          =   510
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   4635
      _ExtentX        =   8176
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   3
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Generar Informe a Pantalla"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Imprimir Informe"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Cerrar Ventana"
            ImageIndex      =   3
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
End
Attribute VB_Name = "BacRentabilidad"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim intDestino As Integer

Private Sub ConCheck_Click(Index As Integer)
SinCheck.Item(Index).Visible = Not SinCheck.Item(Index).Visible
ConCheck.Item(Index).Visible = Not ConCheck.Item(Index).Visible

End Sub

Private Sub Form_Load()

    Me.Top = 0
    Me.Left = 0
    Me.Icon = BacTrader.Icon

    Call Llena_Usuarios
    
    ConCheck(0).Visible = False
    ConCheck(1).Visible = False
    ConCheck(2).Visible = False
    ConCheck(3).Visible = False
    ConCheck(4).Visible = False
    ConCheck(5).Visible = False
    
    TxtFecha.Text = gsBac_Fecp
    
End Sub

Private Sub SinCheck_Click(Index As Integer)
    ConCheck.Item(Index).Left = SinCheck.Item(Index).Left
    
    SinCheck.Item(Index).Visible = Not SinCheck.Item(Index).Visible
    ConCheck.Item(Index).Visible = Not ConCheck.Item(Index).Visible
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

Select Case Button.Index
    Case 1
        intDestino = 1 'Impresora
        Call Imprime_RPT
    Case 2
        intDestino = 0 'Pantalla
        Call Imprime_RPT
        
    Case 3
        Unload Me
End Select

End Sub

Function Imprime_RPT()

On Error GoTo errores
      
'If txtAño.Text = Empty Then
    
'    MsgBox "Debe Ingresar el Mes y el Año para la consulta", vbInformation, TITSISTEMA
       
'Else
        
      LimpiarRPT
      
    '  RptList_Path = "\\BACNTDESA7\BANCO SUDAMERICANO\RENTA FIJA\VBP\REPORTES\"
    
    If ConCheck(0).Visible = True Then
        Screen.MousePointer = vbHourglass
        BacTrader.bacrpt.Destination = intDestino
        BacTrader.bacrpt.ReportFileName = RptList_Path & "rentab_resumen.rpt"
        BacTrader.bacrpt.WindowTitle = "Resumen de Rentabilidad"
        BacTrader.bacrpt.StoredProcParam(0) = Format(TxtFecha.Text, "yyyymmdd")
        BacTrader.bacrpt.Connect = CONECCION
        BacTrader.bacrpt.Action = 1
     End If
     
     LimpiarRPT
     
     If ConCheck(1).Visible = True Then
        BacTrader.bacrpt.Destination = intDestino
        BacTrader.bacrpt.ReportFileName = RptList_Path & "rentab_cartera.rpt"
        BacTrader.bacrpt.StoredProcParam(0) = Format(TxtFecha.Text, "yyyymmdd")
        BacTrader.bacrpt.WindowTitle = "Rentabilidad de Carteras"
        BacTrader.bacrpt.Connect = CONECCION
        BacTrader.bacrpt.Action = 1
     End If

     LimpiarRPT
     
     If ConCheck(2).Visible = True Then
        BacTrader.bacrpt.Destination = intDestino
        BacTrader.bacrpt.ReportFileName = RptList_Path & "rentab_ib.rpt"
        BacTrader.bacrpt.StoredProcParam(0) = Format(TxtFecha.Text, "yyyymmdd")
        BacTrader.bacrpt.WindowTitle = "Rentabilidad Interbancarios"
        BacTrader.bacrpt.Connect = CONECCION
        BacTrader.bacrpt.Action = 1
     End If
     
     LimpiarRPT
     
     If ConCheck(3).Visible = True Then
        BacTrader.bacrpt.Destination = intDestino
        BacTrader.bacrpt.ReportFileName = RptList_Path & "rentab_ventas.rpt"
        BacTrader.bacrpt.StoredProcParam(0) = Format(TxtFecha.Text, "yyyymmdd")
        BacTrader.bacrpt.WindowTitle = "Rentabilidad de Ventas Definitivas"
        BacTrader.bacrpt.Connect = CONECCION
        BacTrader.bacrpt.Action = 1
     End If
     
     LimpiarRPT
     
     If ConCheck(4).Visible = True Then
        BacTrader.bacrpt.Destination = intDestino
        BacTrader.bacrpt.ReportFileName = RptList_Path & "rentab_pacto.rpt"
        BacTrader.bacrpt.StoredProcParam(0) = Format(TxtFecha.Text, "yyyymmdd")
        BacTrader.bacrpt.StoredProcParam(1) = "CI"
        BacTrader.bacrpt.StoredProcParam(2) = "RV"
        BacTrader.bacrpt.WindowTitle = "Rentabilidad Compras con Pactos"
        BacTrader.bacrpt.Connect = CONECCION
        BacTrader.bacrpt.Action = 1
     End If
               
     LimpiarRPT
     
     If ConCheck(5).Visible = True Then
        BacTrader.bacrpt.Destination = intDestino
        BacTrader.bacrpt.ReportFileName = RptList_Path & "rentab_pacto.rpt"
        BacTrader.bacrpt.StoredProcParam(0) = Format(TxtFecha.Text, "yyyymmdd")
        BacTrader.bacrpt.StoredProcParam(1) = "VI"
        BacTrader.bacrpt.StoredProcParam(2) = "RC"
        BacTrader.bacrpt.WindowTitle = "Rentabilidad Ventas con Pactos"
        BacTrader.bacrpt.Connect = CONECCION
        BacTrader.bacrpt.Action = 1
     End If
     
     Screen.MousePointer = vbDefault
    

   
   
   
   
  '' If ConCheck(1).Visible = True Then
   
   '     If cmbUsuario.Text = Empty Then
   '         MsgBox "Para el Informe de Rentabilidad Interbancaria, debe seleccionar un Usuario.", vbInformation, TITSISTEMA
   '     Else
                       
   '         Screen.MousePointer = vbHourglass
   '         BacTrader.bacrpt.Destination = intDestino
   '         BacTrader.bacrpt.ReportFileName = RptList_Path & "inforentinter.rpt"
   '         BacTrader.bacrpt.WindowTitle = "Informe Rentabilidad de Interbancarios"
   '         BacTrader.bacrpt.StoredProcParam(0) = txtMes.Text
   '         BacTrader.bacrpt.StoredProcParam(1) = txtAño.Text
   '         BacTrader.bacrpt.StoredProcParam(2) = cmbUsuario.Text
   '         BacTrader.bacrpt.Connect = CONECCION
   '         BacTrader.bacrpt.Action = 1
   '         Screen.MousePointer = vbDefault
   '     End If
    
   ' End If

    'LimpiarRPT

   'If ConCheck(2).Visible = True Then
   '     Screen.MousePointer = vbHourglass
   '     BacTrader.bacrpt.Destination = intDestino
   '     BacTrader.bacrpt.ReportFileName = RptList_Path & "infrentventas.rpt"
   '     BacTrader.bacrpt.WindowTitle = ""
  '      BacTrader.bacrpt.StoredProcParam(0) = txtMes.Text
  '      BacTrader.bacrpt.StoredProcParam(1) = txtAño.Text
  '      BacTrader.bacrpt.Connect = CONECCION
  '      BacTrader.bacrpt.Action = 1
  '      Screen.MousePointer = vbDefault
  '  End If
    
   ' LimpiarRPT

   'If ConCheck(3).Visible = True Then
        
   '     If cmbUsuario.Text = Empty Then
    '        MsgBox "Para el Informe de Rentabilidad Interbancaria, debe seleccionar un Usuario.", vbInformation, TITSISTEMA
    '    Else
              
     '       Screen.MousePointer = vbHourglass
     '       BacTrader.bacrpt.Destination = intDestino
     '       BacTrader.bacrpt.ReportFileName = RptList_Path & "infrentpactos.rpt"
     '       BacTrader.bacrpt.WindowTitle = ""
     '       BacTrader.bacrpt.StoredProcParam(0) = txtMes.Text
     '       BacTrader.bacrpt.StoredProcParam(1) = txtAño.Text
     '       BacTrader.bacrpt.StoredProcParam(2) = cmbUsuario.Text
     '       BacTrader.bacrpt.Connect = CONECCION
     '       BacTrader.bacrpt.Action = 1
     '       Screen.MousePointer = vbDefault
     '   End If
    'End If

 'End If 'vaida año vacio

errores:
     If err.Description <> Empty Then
        MsgBox err.Description
        Screen.MousePointer = vbDefault
        
     End If
     

End Function

Sub LimpiarRPT()
Dim I As Integer
    For I = 0 To 3
        BacTrader.bacrpt.StoredProcParam(I) = ""
        
    Next I

End Sub

Function Llena_Usuarios()
Dim Usuarios()
If Not Bac_Sql_Execute("SP_TRAE_USUARIO") Then
    MsgBox "Problemas al Ejecutar Consulta SQL", vbInformation, TITSISTEMA
Else
    
    Do While Bac_SQL_Fetch(Usuarios())
       
       cmbUsuario.AddItem Usuarios(1)
       
    Loop
End If
End Function
Private Sub txtAño_KeyPress(KeyAscii As Integer)
   If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      
   ElseIf Not ((KeyAscii > 47 And KeyAscii < 58) Or KeyAscii = 8) Then
      KeyAscii = 0
   End If

End Sub

Private Sub txtMes_KeyPress(KeyAscii As Integer)
   If KeyAscii% = vbKeyReturn Then
      KeyAscii% = 0
      txtAño.SetFocus
   ElseIf Not ((KeyAscii > 47 And KeyAscii < 58) Or KeyAscii = 8) Then
      KeyAscii = 0
   End If

End Sub

