VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{0351DCBC-A7AB-11D5-B8F3-000102BF8447}#1.0#0"; "BACCONTROLES.OCX"
Begin VB.Form Rpt_Utilidad_Diferida 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Informe de Lineas Ocupadas Forward"
   ClientHeight    =   2040
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   7950
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   2040
   ScaleWidth      =   7950
   Begin Threed.SSFrame Frame 
      Height          =   1500
      Index           =   2
      Left            =   0
      TabIndex        =   0
      Top             =   510
      Width           =   7920
      _Version        =   65536
      _ExtentX        =   13970
      _ExtentY        =   2646
      _StockProps     =   14
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin VB.CheckBox Ch_Clientes 
         Caption         =   "Todos los Clientes"
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
         Height          =   405
         Left            =   3960
         TabIndex        =   9
         Top             =   210
         Value           =   1  'Checked
         Width           =   2265
      End
      Begin BACControles.TXTFecha DateText2 
         Height          =   315
         Left            =   1800
         TabIndex        =   1
         Top             =   300
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
         MaxDate         =   2958465
         MinDate         =   -328716
         Text            =   "04/11/2004"
      End
      Begin BACControles.TXTNumero TxtRut 
         Height          =   315
         Left            =   870
         TabIndex        =   5
         Top             =   780
         Width           =   1695
         _ExtentX        =   2990
         _ExtentY        =   556
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
         Text            =   "0"
         Text            =   "0"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin BACControles.TXTNumero TxtCodCli2 
         Height          =   315
         Left            =   2610
         TabIndex        =   6
         Top             =   780
         Width           =   495
         _ExtentX        =   873
         _ExtentY        =   556
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
         Text            =   "0"
         Text            =   "0"
         Separator       =   -1  'True
         MarcaTexto      =   -1  'True
      End
      Begin VB.Label LabNombre 
         BackColor       =   &H00E0E0E0&
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
         ForeColor       =   &H00800000&
         Height          =   315
         Left            =   3180
         TabIndex        =   8
         Top             =   780
         Width           =   4515
      End
      Begin VB.Label Label4 
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
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   150
         TabIndex        =   7
         Top             =   855
         Width           =   1155
      End
      Begin VB.Label Label 
         Alignment       =   2  'Center
         BackColor       =   &H00808000&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "Fecha Consulta"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   315
         Index           =   1
         Left            =   150
         TabIndex        =   3
         Top             =   300
         Width           =   1620
      End
      Begin VB.Label lblFecha 
         Caption         =   "Martes"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00008000&
         Height          =   315
         Index           =   1
         Left            =   3075
         TabIndex        =   2
         Top             =   300
         Width           =   1260
      End
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   4170
      Top             =   0
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
            Picture         =   "Rpt_Utilidad_Diferida.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Rpt_Utilidad_Diferida.frx":0452
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   4
      Top             =   0
      Width           =   7950
      _ExtentX        =   14023
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   2
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Buscar"
            Object.ToolTipText     =   "Buscar Fechas"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
End
Attribute VB_Name = "Rpt_Utilidad_Diferida"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub Ch_Clientes_Click()
If Ch_Clientes.Value = 1 Then
    TxtRut.Text = 0
    TxtRut.Enabled = False
    TxtCodCli2.Text = 0
    TxtCodCli2.Enabled = False
    LabNombre.Caption = ""
Else
    TxtRut.Enabled = True
    TxtCodCli2.Enabled = True
End If
End Sub

Private Sub DateText2_Click()
    Call DiaSemanaDos(DateText2.Text, lblFecha(1))
End Sub

Private Sub DateText2_DblClick()
Call DiaSemanaDos(DateText2.Text, lblFecha(1))
End Sub

Private Sub DateText2_GotFocus()
Call DiaSemanaDos(DateText2.Text, lblFecha(1))
End Sub

Private Sub DateText2_KeyPress(KeyAscii As Integer)
Call DiaSemanaDos(DateText2.Text, lblFecha(1))
End Sub

Private Sub DateText2_LostFocus()
Call DiaSemanaDos(DateText2.Text, lblFecha(1))
End Sub

Private Sub Form_Load()
Me.Icon = Acceso_Usuario.Icon
DateText2.Text = Format(gsBAC_Fecp, "DD/MM/YYYY")
Call DiaSemanaDos(DateText2.Text, lblFecha(1))
Ch_Clientes_Click
End Sub
Function BacRptUtilidadDiferida(cFechaDesde As String)
   
   On Error GoTo Err_Print
   
   If Ch_Clientes.Value = 0 Then
    If TxtRut.Text = 0 Or Me.TxtCodCli2.Text = 0 Or Trim(LabNombre.Caption) = "" Then
        MsgBox "Debe Seleccionar un Cliente", vbExclamation, TITSISTEMA
        Exit Function
    End If
   End If
   

   Call Limpiar_Cristal
   
   BacControlFinanciero.CryFinanciero.ReportFileName = gsRPT_Path & "Rpt_UtilidadBco.rpt"
   BacControlFinanciero.CryFinanciero.Destination = crptToWindow
   
   BacControlFinanciero.CryFinanciero.StoredProcParam(0) = Format$(cFechaDesde, "YYYYMMDD")
   BacControlFinanciero.CryFinanciero.StoredProcParam(1) = IIf(Ch_Clientes.Value = 0, Format(TxtRut.Text, "#"), 0)
   BacControlFinanciero.CryFinanciero.StoredProcParam(2) = IIf(Ch_Clientes.Value = 0, Me.TxtCodCli2.Text, 0)
   BacControlFinanciero.CryFinanciero.StoredProcParam(3) = "BFW" '' MAP 20090112 Ejecutando para Forward
   BacControlFinanciero.CryFinanciero.Connect = swConeccion
   BacControlFinanciero.CryFinanciero.WindowState = crptMaximized
   BacControlFinanciero.CryFinanciero.WindowTitle = "LINEAS OCUPADAS FORWARD"
   BacControlFinanciero.CryFinanciero.Action = 1

   BacControlFinanciero.CryFinanciero.StoredProcParam(0) = Format$(cFechaDesde, "YYYYMMDD")
   BacControlFinanciero.CryFinanciero.StoredProcParam(1) = IIf(Ch_Clientes.Value = 0, Format(txtRut.Text, "#"), 0)
   BacControlFinanciero.CryFinanciero.StoredProcParam(2) = IIf(Ch_Clientes.Value = 0, Me.TxtCodCli2.Text, 0)
   BacControlFinanciero.CryFinanciero.StoredProcParam(3) = "PCS" '' MAP 20090112 Ejecutando para Swap
   BacControlFinanciero.CryFinanciero.Connect = swConeccion
   BacControlFinanciero.CryFinanciero.WindowState = crptMaximized
   BacControlFinanciero.CryFinanciero.WindowTitle = "LINEAS OCUPADAS SWAP"
   BacControlFinanciero.CryFinanciero.Action = 1
   
'-- Se agrega elsiguiente bloque para mostrar Lineas Ocupadas de Modulo de Opciones.

   BacControlFinanciero.CryFinanciero.StoredProcParam(0) = Format$(cFechaDesde, "YYYYMMDD")
   BacControlFinanciero.CryFinanciero.StoredProcParam(1) = IIf(Ch_Clientes.Value = 0, Format(txtRut.Text, "#"), 0)
   BacControlFinanciero.CryFinanciero.StoredProcParam(2) = IIf(Ch_Clientes.Value = 0, Me.TxtCodCli2.Text, 0)
   BacControlFinanciero.CryFinanciero.StoredProcParam(3) = "OPT"
   BacControlFinanciero.CryFinanciero.Connect = swConeccion
   BacControlFinanciero.CryFinanciero.WindowState = crptMaximized
   BacControlFinanciero.CryFinanciero.WindowTitle = "LINEAS OCUPADAS OPCIONES"
   BacControlFinanciero.CryFinanciero.Action = 1

   
   'PROD-10967
   Call Limpiar_Cristal   
   BacControlFinanciero.CryFinanciero.ReportFileName = gsRPT_Path & "Rpt_General_Rec.rpt"
   BacControlFinanciero.CryFinanciero.Destination = crptToWindow
   BacControlFinanciero.CryFinanciero.Connect = swConeccion
   BacControlFinanciero.CryFinanciero.WindowState = crptMaximized
   BacControlFinanciero.CryFinanciero.WindowTitle = "LINEAS OCUPADAS DRV"
   BacControlFinanciero.CryFinanciero.Action = 1
   'PROD-10967   
   

   Exit Function

Err_Print:
   
   MsgBox BacControlFinanciero.CryFinanciero.ReportFileName & ", " & Err.Description, vbInformation, TITSISTEMA

End Function

Private Sub Toolbar_ButtonClick(ByVal Button As MSComctlLib.Button)

Select Case Button.Index
Case 1:
        BacRptUtilidadDiferida DateText2.Text
Case 2:
        Unload Me
End Select

End Sub

Private Sub TXTFecha1_Click()
Call DiaSemanaDos(TXTFecha1.Text, lblFecha(0))
End Sub

Private Sub TXTFecha1_DblClick()
Call DiaSemanaDos(TXTFecha1.Text, lblFecha(0))
End Sub

Private Sub TXTFecha1_GotFocus()
Call DiaSemanaDos(TXTFecha1.Text, lblFecha(0))
End Sub

Private Sub TXTFecha1_KeyPress(KeyAscii As Integer)
Call DiaSemanaDos(TXTFecha1.Text, lblFecha(0))
End Sub

Private Sub TXTFecha1_LostFocus()
Call DiaSemanaDos(TXTFecha1.Text, lblFecha(0))
End Sub

Private Sub TxtRut_DblClick()
   ' BacAyuda.Tag = "Cliente" -->Original
   ' BacAyuda.Show 1
   BacAyudaCliente.Tag = "Cliente" 'Arm llama formulario ayuda cliente
   BacAyudaCliente.Show 1
    
    If giAceptar = True Then
        
        TxtRut.Text = RetornoAyuda
        TxtCodCli2.Text = RetornoAyuda2
        LabNombre.Caption = RetornoAyuda3
        
'        Call Busca
        
    End If


'    If swexiste = 0 Then
'        Grid.Enabled = True
'        Toolbar1.Buttons(1).Enabled = True
'        Key = 0
'
'    End If

End Sub
