VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Begin VB.Form BacMntFormaPago 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantenedor de Formas de Pago"
   ClientHeight    =   3165
   ClientLeft      =   120
   ClientTop       =   315
   ClientWidth     =   6330
   Icon            =   "BacMntFp.frx":0000
   LinkTopic       =   "Form3"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   3165
   ScaleWidth      =   6330
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   4950
      Top             =   0
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   22
      ImageHeight     =   22
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   4
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntFp.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntFp.frx":075C
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntFp.frx":0BAE
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "BacMntFp.frx":0EC8
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   510
      Left            =   0
      TabIndex        =   23
      Top             =   0
      Width           =   6330
      _ExtentX        =   11165
      _ExtentY        =   900
      ButtonWidth     =   767
      ButtonHeight    =   741
      AllowCustomize  =   0   'False
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   4
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin Threed.SSPanel SSPanel1 
      Height          =   2640
      Left            =   0
      TabIndex        =   0
      Top             =   510
      Width           =   6315
      _Version        =   65536
      _ExtentX        =   11139
      _ExtentY        =   4657
      _StockProps     =   15
      BackColor       =   -2147483644
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin VB.Frame Frame1 
         Height          =   555
         Left            =   60
         TabIndex        =   18
         Top             =   30
         Width           =   6195
         Begin VB.TextBox txtPerfil 
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000006&
            Height          =   315
            Left            =   3210
            MaxLength       =   9
            TabIndex        =   20
            Top             =   150
            Width           =   2892
         End
         Begin VB.TextBox txtCodigo 
            Alignment       =   1  'Right Justify
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H80000006&
            Height          =   315
            Left            =   1290
            MaxLength       =   3
            MouseIcon       =   "BacMntFp.frx":11E2
            MousePointer    =   99  'Custom
            TabIndex        =   19
            Top             =   165
            Width           =   1140
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            BackColor       =   &H00C0C0C0&
            BackStyle       =   0  'Transparent
            Caption         =   "Perfil"
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
            Index           =   10
            Left            =   2640
            TabIndex        =   22
            Top             =   225
            Width           =   435
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            BackColor       =   &H00C0C0C0&
            BackStyle       =   0  'Transparent
            Caption         =   "Código"
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
            Index           =   8
            Left            =   75
            TabIndex        =   21
            Top             =   225
            Width           =   585
         End
      End
      Begin VB.Frame Frame2 
         Height          =   2100
         Left            =   60
         TabIndex        =   1
         Top             =   495
         Width           =   6195
         Begin VB.ComboBox CodigosBolsa 
            Height          =   315
            Left            =   1260
            Style           =   2  'Dropdown List
            TabIndex        =   27
            Top             =   1590
            Width           =   2715
         End
         Begin VB.TextBox txtDiasLineas 
            Alignment       =   1  'Right Justify
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   315
            Left            =   5445
            MaxLength       =   3
            TabIndex        =   25
            Text            =   "0"
            Top             =   1560
            Width           =   675
         End
         Begin VB.ComboBox cmbExigeCh 
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   330
            Left            =   5445
            Style           =   2  'Dropdown List
            TabIndex        =   9
            Top             =   1215
            Width           =   675
         End
         Begin VB.ComboBox cmbAfecta 
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   330
            Left            =   3075
            Style           =   2  'Dropdown List
            TabIndex        =   8
            Top             =   1215
            Width           =   795
         End
         Begin VB.ComboBox cmb2756 
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   330
            Left            =   1275
            Style           =   2  'Dropdown List
            TabIndex        =   7
            Top             =   1215
            Width           =   675
         End
         Begin VB.ComboBox cmbExige 
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   330
            Left            =   5445
            Style           =   2  'Dropdown List
            TabIndex        =   6
            Top             =   870
            Width           =   675
         End
         Begin VB.TextBox txtcodgen 
            Alignment       =   1  'Right Justify
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   315
            Left            =   1275
            MaxLength       =   3
            TabIndex        =   5
            Top             =   870
            Width           =   2610
         End
         Begin VB.TextBox TxtDiasvalor 
            Alignment       =   1  'Right Justify
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   315
            Left            =   5430
            MaxLength       =   3
            TabIndex        =   4
            Text            =   "0"
            Top             =   525
            Width           =   675
         End
         Begin VB.TextBox TxtGlosa2 
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   315
            Left            =   1275
            MaxLength       =   8
            TabIndex        =   3
            Top             =   525
            Width           =   2625
         End
         Begin VB.TextBox txtGlosa 
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   315
            Left            =   1290
            MaxLength       =   30
            TabIndex        =   2
            Top             =   180
            Width           =   4830
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            BackColor       =   &H00C0C0C0&
            BackStyle       =   0  'Transparent
            Caption         =   "Código Bolsa"
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
            Left            =   90
            TabIndex        =   26
            Top             =   1650
            Width           =   1080
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            BackColor       =   &H00C0C0C0&
            BackStyle       =   0  'Transparent
            Caption         =   "Dias para Lineas"
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
            Left            =   4035
            TabIndex        =   24
            Top             =   1605
            Width           =   1350
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            BackStyle       =   0  'Transparent
            Caption         =   "Glosa"
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
            Left            =   75
            TabIndex        =   17
            Top             =   225
            Width           =   465
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            BackColor       =   &H00C0C0C0&
            BackStyle       =   0  'Transparent
            Caption         =   "Exige Cheque"
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
            Index           =   4
            Left            =   4035
            TabIndex        =   16
            Top             =   1260
            Width           =   1125
         End
         Begin VB.Label Label2 
            AutoSize        =   -1  'True
            BackColor       =   &H00C0C0C0&
            BackStyle       =   0  'Transparent
            Caption         =   "Afecta Cor."
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
            Left            =   2085
            TabIndex        =   15
            Top             =   1260
            Width           =   915
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            BackColor       =   &H00C0C0C0&
            BackStyle       =   0  'Transparent
            Caption         =   "CC2756"
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
            Left            =   75
            TabIndex        =   14
            Top             =   1260
            Width           =   600
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            BackColor       =   &H00C0C0C0&
            BackStyle       =   0  'Transparent
            Caption         =   "Exige Cuenta"
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
            Left            =   4035
            TabIndex        =   13
            Top             =   915
            Width           =   1065
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            BackColor       =   &H00C0C0C0&
            BackStyle       =   0  'Transparent
            Caption         =   "Cód.Contable"
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
            Index           =   12
            Left            =   75
            TabIndex        =   12
            Top             =   915
            Width           =   1110
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            BackColor       =   &H00C0C0C0&
            BackStyle       =   0  'Transparent
            Caption         =   "Días Valor"
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
            Index           =   11
            Left            =   4035
            TabIndex        =   11
            Top             =   570
            Width           =   825
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            BackColor       =   &H00C0C0C0&
            BackStyle       =   0  'Transparent
            Caption         =   "Glosa Breve"
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
            Index           =   9
            Left            =   75
            TabIndex        =   10
            Top             =   570
            Width           =   990
         End
      End
   End
End
Attribute VB_Name = "BacMntFormaPago"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private objTipoCliente    As Object
Private objCliente        As Object
Private objFPago          As New clsForPago
Dim SQL                   As String
Dim Datos()

Public Function Valida() As Boolean
Dim i As Integer

   Valida = False
   
   If CDbl(TxtCodigo) = 0 Then
      MsgBox " ERROR : Codigo  Vacio   ", 16, TITSISTEMA
      TxtCodigo.SetFocus
   ElseIf Trim$(txtGlosa) = "" Then
      MsgBox " ERROR : Glosa   Vacia   ", 16, TITSISTEMA
      txtGlosa.SetFocus
   ElseIf (TxtGlosa2) = "" Then
      MsgBox " ERROR : Glosa Breve Vacia   ", 16, TITSISTEMA
      TxtGlosa2.SetFocus
   ElseIf (txtPerfil) = "" Then
      MsgBox "  ERROR : Perfil  Vacio   ", 16, TITSISTEMA
      txtPerfil.SetFocus
   ElseIf (TxtDiasvalor) = "" Then
      MsgBox "  ERROR : Dias Vacio  ", 16, TITSISTEMA
      txtPerfil.SetFocus
   ElseIf (txtcodgen) = "" Then
      MsgBox "  ERROR :Codigo Contable Vacio    ", 16, TITSISTEMA
      txtcodgen.SetFocus
    ElseIf CodigosBolsa.ListCount <= -1 Then
        '
        '   Codigo bolsa por defecto 933
        '
        For i = 0 To CodigosBolsa.ListCount - 1
            If CodigosBolsa.ItemData(i) = 993 Then
                CodigosBolsa.ListIndex = i
                Exit For
            End If
        Next i
        
        If CodigosBolsa.ListIndex = -1 Then
            MsgBox "  ERROR :Código bolsa defecto no asignado. no se encontro.", 16, TITSISTEMA
            txtcodgen.SetFocus
        End If

   Else
      Valida = True
   End If
End Function

Public Function CargaPanel(Valor As Boolean)
   Toolbar1.Buttons(1).Enabled = Valor
   Toolbar1.Buttons(2).Enabled = Valor
 End Function

Public Function ActivaBoton(Valor As Boolean)
   TxtCodigo.Enabled = Not Valor
   txtGlosa.Enabled = Valor
   TxtGlosa2.Enabled = Valor
   txtPerfil.Enabled = Valor
   txtcodgen.Enabled = Valor
   TxtDiasvalor.Enabled = Valor
   cmb2756.Enabled = Valor
   cmbAfecta.Enabled = Valor
   cmbExige.Enabled = Valor
   cmbExigeCh.Enabled = Valor
   txtDiasLineas.Enabled = Valor
   
   Toolbar1.Buttons(1).Enabled = Valor
   Toolbar1.Buttons(2).Enabled = Valor
   Toolbar1.Buttons(3).Enabled = Valor
End Function

Private Sub cmb2756_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 And Trim(cmb2756) <> "" Then
      SendKeys "{tab}"
   Else
      If KeyAscii <> 78 And KeyAscii <> 110 And KeyAscii <> 83 And KeyAscii <> 115 Then
         KeyAscii = 0
      End If
   End If
End Sub

Private Sub cmb2756_LostFocus()
   If Trim(cmb2756) = "" Then
      cmb2756.SetFocus
   End If
End Sub

Private Sub cmbAfecta_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 And Trim(cmbAfecta) <> "" Then
      SendKeys "{tab}"
   Else
      If KeyAscii <> 78 And KeyAscii <> 110 And KeyAscii <> 83 And KeyAscii <> 115 Then
         KeyAscii = 0
      End If
   End If
End Sub

Private Sub cmbAfecta_LostFocus()
   If Trim(cmbAfecta) = "" Then
      cmbAfecta.SetFocus
   End If
End Sub

Private Sub cmbExige_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 And Trim(cmbExige) <> "" Then
      SendKeys "{tab}"
   Else
      If KeyAscii <> 78 And KeyAscii <> 110 And KeyAscii <> 83 And KeyAscii <> 115 Then
         KeyAscii = 0
      End If
   End If
End Sub

Private Sub cmbExigeCh_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 And Trim(cmbExigeCh) <> "" Then
      Toolbar1.Buttons(1).Enabled = True
   Else
      If KeyAscii <> 78 And KeyAscii <> 110 And KeyAscii <> 83 And KeyAscii <> 115 Then
         KeyAscii = 0
      End If
   End If
End Sub

Private Sub cmbExigeCh_LostFocus()
   If Trim(cmbExigeCh) = "" Then
      cmbExige.SetFocus
   Else
      Toolbar1.Buttons(1).Enabled = True
   End If
End Sub

Private Sub cmdEliminar_Click()
   If Trim(TxtCodigo.Text) = "" Then
      Exit Sub
   End If
   If MsgBox("Esta Seguro de Eliminar el Registro", vbYesNo + vbQuestion, TITSISTEMA) <> vbYes Then
      Exit Sub
   End If
   If objFPago.Eliminar(CDbl(TxtCodigo.Text)) Then
      cmdlimpiar_Click
   End If
End Sub

Private Sub cmdGrabar_Click()
   
   Me.MousePointer = vbHourglass
   
   If Not Valida Then
      Me.MousePointer = vbDefault
      Exit Sub
   End If
  
   objFPago.Codigo = CDbl(TxtCodigo.Text)
   objFPago.Glosa = txtGlosa.Text
   objFPago.Perfil = txtPerfil.Text
   objFPago.CodGen = txtcodgen.Text
   objFPago.Glosa2 = TxtGlosa2.Text
   objFPago.cc2756 = Left(cmb2756, 1)
   objFPago.AfectaCorr = Left(cmbAfecta, 1)
   objFPago.DiasValor = CDbl(TxtDiasvalor.Text)
   objFPago.NumCheque = Left(cmbExigeCh, 1)
   objFPago.CtaCte = Left(cmbExige, 1)
   objFPago.iDiasLineas = CDbl(txtDiasLineas.Text)
   If objFPago.Grabar = True Then
      Me.MousePointer = 0
      MsgBox " Grabación  fue  Exitosa  ", 64, TITSISTEMA
      Call cmdlimpiar_Click
   End If
   Me.MousePointer = vbDefault
End Sub

Private Sub cmdlimpiar_Click()
   Screen.MousePointer = vbHourglass
   
   Call objFPago.Limpiar
   
   TxtCodigo = ""
   txtGlosa = ""
   TxtGlosa2 = ""
   txtPerfil = ""
   txtcodgen = ""
   TxtDiasvalor = 0
   cmb2756.ListIndex = 0
   cmbAfecta.ListIndex = 0
   cmbExige.ListIndex = 0
   cmbExigeCh.ListIndex = 0
   txtDiasLineas.Text = 0
   Call ActivaBoton(False)
   If Me.Visible Then
      TxtCodigo.SetFocus
   End If
   Screen.MousePointer = vbDefault
End Sub

Private Sub cmdSalir_Click()
   Unload Me
End Sub


Private Sub CodigosBolsa_Click()
    If CodigosBolsa.ListIndex > -1 Then
        CodigosBolsa.ToolTipText = "Cód.: " & CodigosBolsa.ItemData(CodigosBolsa.ListIndex)
    End If
End Sub

Private Sub Form_Load()
    Me.Icon = BACSwapParametros.Icon
    Me.Top = 0: Me.Left = 0
    
    Call Grabar_Log_AUDITORIA(giBAC_Entidad, gsbac_fecp, gsBac_IP, gsBAC_User, "PCA", "OPC_41", "07", "INGRESO A OPCION MENU", " ", " ", " ")
    
    cmb2756.AddItem "NO"
    cmb2756.AddItem "SI"
    
    cmbAfecta.AddItem "NO"
    cmbAfecta.AddItem "SI"
    
    cmbExige.AddItem "NO"
    cmbExige.AddItem "SI"
    
    cmbExigeCh.AddItem "NO"
    cmbExigeCh.AddItem "SI"
    
    Call cmdlimpiar_Click
    
    CargaCodigosBolsa
    
End Sub

Sub CargaCodigosBolsa()
    Dim i As Integer
    
    Envia = Array()
    AddParam Envia, 2740
    If Not Bac_Sql_Execute("dbo.SP_LEETABLA", Envia) Then
        Exit Sub
    End If
    
    CodigosBolsa.Clear
    Do While Bac_SQL_Fetch(Datos())
        CodigosBolsa.AddItem Datos(5)
        CodigosBolsa.ItemData(CodigosBolsa.ListCount - 1) = Datos(4)
    
    Loop
    '
    '   Codigo bolsa por defecto 933
    '
    For i = 0 To CodigosBolsa.ListCount - 1
        If CodigosBolsa.ItemData(i) = 993 Then
            CodigosBolsa.ListIndex = i
            Exit For
        End If
    Next i

   
End Sub

Private Sub Grabar()
   Me.MousePointer = vbHourglass
  
   If Not Valida Then
      Me.MousePointer = vbDefault
      Exit Sub
   End If
  
   objFPago.Codigo = CDbl(TxtCodigo.Text)
   objFPago.Glosa = txtGlosa.Text
   objFPago.Perfil = txtPerfil.Text
   objFPago.CodGen = txtcodgen.Text
   objFPago.Glosa2 = TxtGlosa2.Text
   objFPago.cc2756 = Left(cmb2756, 1)
   objFPago.AfectaCorr = Left(cmbAfecta, 1)
   objFPago.DiasValor = CDbl(TxtDiasvalor.Text)
   objFPago.NumCheque = Left(cmbExigeCh, 1)
   objFPago.CtaCte = Left(cmbExige, 1)
   objFPago.iDiasLineas = CDbl(txtDiasLineas.Text)
   objFPago.CodigoBolsa = CodigosBolsa.ItemData(CodigosBolsa.ListIndex) ' CInt(txtBolsa.Text)
   
   If objFPago.Grabar = True Then
      Me.MousePointer = vbDefault
      Call Grabar_Log_AUDITORIA(giBAC_Entidad, gsbac_fecp, gsBac_IP, gsBAC_User, "PCA", "OPC_41 ", "01", "Grabar formas de pagoso ", " ", " ", "GRABADA FORMA DE PAGO : " & txtGlosa.Text)
      Call cmdlimpiar_Click
   End If
   Me.MousePointer = vbDefault
End Sub

Private Sub Eliminar()
   If Trim(TxtCodigo.Text) = "" Then
      Exit Sub
   End If
   If MsgBox("Esta Seguro de Eliminar Forma de Pago :" & Chr(13) & txtGlosa.Text, vbYesNo + vbQuestion, TITSISTEMA) <> vbYes Then
      Exit Sub
   End If
   Call Grabar_Log_AUDITORIA(giBAC_Entidad, gsbac_fecp, gsBac_IP, gsBAC_User, "PCA", "OPC_41 ", "03", "Eliminar formas de pagos", " ", " ", "ELIMINADA FORMA DE PAGO : " & txtGlosa.Text)
   If objFPago.Eliminar(CDbl(TxtCodigo.Text)) Then
      cmdlimpiar_Click
   End If
End Sub

Private Sub Limpiar()
    Dim i As Integer
    
   Screen.MousePointer = vbHourglass
   
   Call objFPago.Limpiar
   
   TxtCodigo = ""
   txtGlosa = ""
   TxtGlosa2 = ""
   txtPerfil = ""
   txtcodgen = ""
   TxtDiasvalor = 0
   cmb2756.ListIndex = 0
   cmbAfecta.ListIndex = 0
   cmbExige.ListIndex = 0
   cmbExigeCh.ListIndex = 0
   txtDiasLineas.Text = 0
         '
         '   Codigo bolsa por defecto 933
         '
         CodigosBolsa.ListIndex = -1
         For i = 0 To CodigosBolsa.ListCount - 1
             If CodigosBolsa.ItemData(i) = 993 Then
                 CodigosBolsa.ListIndex = i
                 Exit For
             End If
         Next i
        
   Call ActivaBoton(False)
   
   If Me.Visible Then
      TxtCodigo.SetFocus
   End If
   Screen.MousePointer = vbDefault
   
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
   Select Case Button.Index
      Case 1
         Call Grabar
      Case 2
         Call Eliminar
      Case 3
         Call Limpiar
      Case 4
         Call Grabar_Log_AUDITORIA(giBAC_Entidad, gsbac_fecp, gsBac_IP, gsBAC_User, "PCA", "OPC_41 ", "08", "SALIDA DE OPCION", " ", " ", "ELIMINADA FORMA DE PAGO : " & txtGlosa.Text)
         Unload Me
   End Select
End Sub

Private Sub txtBolsa_KeyPress(KeyAscii As Integer)
    If Not ((KeyAscii >= 48 And KeyAscii <= 57) Or KeyAscii = vbKeyBack) Then
        KeyAscii = 0
    End If
End Sub

Private Sub txtcodgen_KeyPress(KeyAscii As Integer)
   If KeyAscii% = 39 Or KeyAscii% = 34 Or Chr(KeyAscii) = "." Or Chr(KeyAscii) = "," Then
      KeyAscii% = 0
   End If
 
   If KeyAscii = 13 And Trim(txtcodgen) <> "" Then
      SendKeys "{tab}"
   Else
      If (KeyAscii <= 47 Or KeyAscii >= 58) And KeyAscii <> 8 Then
         KeyAscii = 0
      End If
   End If
   If txtcodgen.Text = "0" Then
      txtcodgen.Text = ""
   End If
End Sub

Private Sub txtCodigo_DblClick()
   Call BacControlWindows(100)

   BacAyuda.Tag = "MDFP_U"
   BacAyuda.Show 1

   If giAceptar% Then
      TxtCodigo.Text = gsCodigo
      txtGlosa.Text = gsGlosa
      TxtCodigo.SetFocus
      SendKeys "{ENTER}"
   End If
End Sub

Private Sub txtCodigo_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode = vbKeyF3 Then
      Call txtCodigo_DblClick
   End If
End Sub

Private Sub txtCodigo_KeyPress(KeyAscii As Integer)
   Dim i As Integer
   Call BacSoloNumeros(KeyAscii)
   
   If KeyAscii% = vbKeyReturn Then
      If Val(TxtCodigo.Text) > 0 Then
         Call ActivaBoton(True)
         If Not objFPago.LeerxCodigo(TxtCodigo) Then
            Call objFPago.Limpiar
         End If
         txtGlosa.Text = objFPago.Glosa
         txtPerfil.Text = objFPago.Perfil
         txtcodgen.Text = objFPago.CodGen
         TxtGlosa2.Text = objFPago.Glosa2
         cmb2756.ListIndex = IIf(objFPago.cc2756 = Left(cmb2756.List(0), 1), 0, 1)
         cmbAfecta.ListIndex = IIf(objFPago.AfectaCorr = Left(cmbAfecta.List(0), 1), 0, 1)
         TxtDiasvalor.Text = objFPago.DiasValor
         cmbExige.ListIndex = IIf(objFPago.CtaCte = Left(cmbExige.List(0), 1), 0, 1)
         cmbExigeCh.ListIndex = IIf(objFPago.NumCheque = Left(cmbExigeCh.List(0), 1), 0, 1)
         txtDiasLineas.Text = objFPago.iDiasLineas
            '
            '   Ubica Codigo bolsa asignado
            '
            For i = 0 To CodigosBolsa.ListCount - 1
                If CodigosBolsa.ItemData(i) = objFPago.CodigoBolsa Then
                    CodigosBolsa.ListIndex = i
                    Exit For
                End If
            Next i
          
      Else
         Call ActivaBoton(False)
      End If
      txtPerfil.Enabled = True
      txtPerfil.SetFocus
   End If
End Sub

Private Sub TxtDiasvalor_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 And Trim(TxtDiasvalor) <> "" Then
      SendKeys "{tab}"
   Else
      If TxtDiasvalor.Text = "0" Then
         TxtDiasvalor = ""
      End If
      If (KeyAscii <= 47 Or KeyAscii >= 58) And KeyAscii <> 8 Then
         KeyAscii = 0
      End If
   End If
End Sub

Private Sub txtGlosa_KeyPress(KeyAscii As Integer)
   Call BacToUCase(KeyAscii)
 
   If KeyAscii% = 39 Or KeyAscii% = 34 Or Chr(KeyAscii) = "." Or Chr(KeyAscii) = "," Then
      KeyAscii% = 0
   End If
   If KeyAscii = 13 And Trim(txtGlosa) <> "" Then
      SendKeys "{tab}"
   End If
  
End Sub

Private Sub TxtGLOSA2_KeyPress(KeyAscii As Integer)
   Call BacToUCase(KeyAscii)
   If KeyAscii% = 39 Or KeyAscii% = 34 Or Chr(KeyAscii) = "." Or Chr(KeyAscii) = "," Then
      KeyAscii% = 0
   End If
   If KeyAscii = 13 And Trim(TxtGlosa2) <> "" Then
      SendKeys "{tab}"
   End If
End Sub

Private Sub txtPerfil_KeyPress(KeyAscii As Integer)
   Call BacToUCase(KeyAscii)
 
   If KeyAscii% = 39 Or KeyAscii% = 34 Or Chr(KeyAscii) = "." Or Chr(KeyAscii) = "," Then
      KeyAscii% = 0
   End If
   If KeyAscii = 13 And Trim(txtPerfil) <> "" Then
      SendKeys "{tab}"
   End If
End Sub
