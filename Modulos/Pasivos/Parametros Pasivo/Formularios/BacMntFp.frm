VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Begin VB.Form BacMntFormaPago 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantenedor de Formas de Pago"
   ClientHeight    =   3615
   ClientLeft      =   3750
   ClientTop       =   3570
   ClientWidth     =   6330
   BeginProperty Font 
      Name            =   "Arial"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "BacMntFp.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form3"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   3615
   ScaleWidth      =   6330
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   16
      Top             =   0
      Width           =   6330
      _ExtentX        =   11165
      _ExtentY        =   794
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Style           =   1
      ImageList       =   "Img_opciones"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      Begin MSComctlLib.ImageList Img_opciones 
         Left            =   5610
         Top             =   -30
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   24
         ImageHeight     =   24
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   10
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntFp.frx":2EFA
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntFp.frx":3361
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntFp.frx":3857
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntFp.frx":3CEA
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntFp.frx":41D2
               Key             =   ""
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntFp.frx":46E5
               Key             =   ""
            EndProperty
            BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntFp.frx":4BB8
               Key             =   ""
            EndProperty
            BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntFp.frx":507E
               Key             =   ""
            EndProperty
            BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntFp.frx":5575
               Key             =   ""
            EndProperty
            BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "BacMntFp.frx":596E
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin Threed.SSPanel SSPanel1 
      Height          =   3090
      Left            =   0
      TabIndex        =   0
      Top             =   480
      Width           =   6315
      _Version        =   65536
      _ExtentX        =   11139
      _ExtentY        =   5450
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
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   555
         Left            =   60
         TabIndex        =   13
         Top             =   15
         Width           =   6195
         Begin VB.TextBox txtPerfil 
            Height          =   315
            Left            =   3645
            MaxLength       =   9
            TabIndex        =   2
            Top             =   150
            Width           =   2445
         End
         Begin VB.TextBox txtCodigo 
            Alignment       =   1  'Right Justify
            Height          =   315
            Left            =   1395
            MaxLength       =   2
            MouseIcon       =   "BacMntFp.frx":5D64
            MousePointer    =   99  'Custom
            TabIndex        =   1
            Top             =   165
            Width           =   1140
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "Cód. Perfil"
            ForeColor       =   &H80000007&
            Height          =   210
            Index           =   10
            Left            =   2730
            TabIndex        =   15
            Top             =   225
            Width           =   855
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "Código"
            ForeColor       =   &H80000007&
            Height          =   210
            Index           =   8
            Left            =   120
            TabIndex        =   14
            Top             =   225
            Width           =   585
         End
      End
      Begin VB.Frame Frame2 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   2475
         Left            =   60
         TabIndex        =   7
         Top             =   480
         Width           =   6195
         Begin VB.CheckBox chk_Contable 
            Alignment       =   1  'Right Justify
            Caption         =   "Contable"
            Height          =   270
            Left            =   2730
            TabIndex        =   30
            Top             =   1725
            Value           =   1  'Checked
            Width           =   1140
         End
         Begin VB.ComboBox Cmb_Tipo_Cuenta 
            Height          =   330
            Left            =   1365
            Style           =   2  'Dropdown List
            TabIndex        =   27
            Top             =   915
            Width           =   2550
         End
         Begin VB.ComboBox Cmb_Forma_Pago 
            Height          =   330
            Left            =   1350
            Style           =   2  'Dropdown List
            TabIndex        =   26
            Top             =   2010
            Width           =   2550
         End
         Begin VB.Frame Frame3 
            Caption         =   "Exige"
            Height          =   1560
            Left            =   3945
            TabIndex        =   18
            Top             =   825
            Width           =   2205
            Begin VB.CheckBox FormaBC 
               Height          =   255
               Left            =   1455
               TabIndex        =   29
               Top             =   1215
               Width           =   645
            End
            Begin VB.ComboBox cmbExige 
               Height          =   330
               Left            =   1455
               Style           =   2  'Dropdown List
               TabIndex        =   21
               Top             =   135
               Width           =   675
            End
            Begin VB.ComboBox cmb2756 
               Height          =   330
               Left            =   1455
               Style           =   2  'Dropdown List
               TabIndex        =   20
               Top             =   810
               Width           =   675
            End
            Begin VB.ComboBox cmbExigeCh 
               Height          =   330
               Left            =   1455
               Style           =   2  'Dropdown List
               TabIndex        =   19
               Top             =   480
               Width           =   675
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Banco Central"
               ForeColor       =   &H80000007&
               Height          =   210
               Index           =   3
               Left            =   90
               TabIndex        =   28
               Top             =   1230
               Width           =   1140
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Cuenta Cte."
               ForeColor       =   &H80000007&
               Height          =   210
               Index           =   0
               Left            =   75
               TabIndex        =   24
               Top             =   210
               Width           =   960
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Corresponsal"
               ForeColor       =   &H80000007&
               Height          =   210
               Index           =   2
               Left            =   90
               TabIndex        =   23
               Top             =   870
               Width           =   1140
            End
            Begin VB.Label Label 
               AutoSize        =   -1  'True
               Caption         =   "Cheque"
               ForeColor       =   &H80000007&
               Height          =   210
               Index           =   4
               Left            =   75
               TabIndex        =   22
               Top             =   540
               Width           =   645
            End
         End
         Begin VB.CheckBox chk_Settlement 
            Alignment       =   1  'Right Justify
            Caption         =   "Settlement"
            Height          =   270
            Left            =   45
            TabIndex        =   17
            Top             =   1725
            Width           =   1515
         End
         Begin VB.ComboBox cmbAfecta 
            Height          =   330
            Left            =   1365
            Style           =   2  'Dropdown List
            TabIndex        =   6
            Top             =   1320
            Width           =   795
         End
         Begin VB.TextBox TxtDiasvalor 
            Alignment       =   1  'Right Justify
            Height          =   315
            Left            =   5430
            MaxLength       =   3
            TabIndex        =   5
            Text            =   "0"
            Top             =   525
            Width           =   675
         End
         Begin VB.TextBox TxtGlosa2 
            Height          =   315
            Left            =   1365
            MaxLength       =   8
            TabIndex        =   4
            Top             =   525
            Width           =   2535
         End
         Begin VB.TextBox txtGlosa 
            Height          =   315
            Left            =   1380
            MaxLength       =   30
            TabIndex        =   3
            Top             =   180
            Width           =   4725
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "Rel. BCCH"
            ForeColor       =   &H80000007&
            Height          =   210
            Index           =   1
            Left            =   75
            TabIndex        =   25
            Top             =   2070
            Width           =   795
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "Glosa"
            ForeColor       =   &H80000007&
            Height          =   210
            Left            =   75
            TabIndex        =   12
            Top             =   225
            Width           =   465
         End
         Begin VB.Label Label2 
            AutoSize        =   -1  'True
            Caption         =   "Afecto a Lineas"
            ForeColor       =   &H80000007&
            Height          =   210
            Left            =   60
            TabIndex        =   11
            Top             =   1365
            Width           =   1275
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "Tipo Cuenta "
            ForeColor       =   &H80000007&
            Height          =   210
            Index           =   12
            Left            =   75
            TabIndex        =   10
            Top             =   960
            Width           =   1035
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "Días Valor"
            ForeColor       =   &H80000007&
            Height          =   210
            Index           =   11
            Left            =   4035
            TabIndex        =   9
            Top             =   570
            Width           =   825
         End
         Begin VB.Label Label 
            AutoSize        =   -1  'True
            Caption         =   "Glosa Breve"
            ForeColor       =   &H80000007&
            Height          =   210
            Index           =   9
            Left            =   75
            TabIndex        =   8
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

Private objTipoCliente  As Object
Private objCliente      As Object
Private objFPago        As New clsForPago

Dim OptLocal            As String
Dim Sql                 As String
Dim Datos()
Private Function FUNC_TIPO_CUENTA()
Dim Datos()

If Not BAC_SQL_EXECUTE("SP_CON_TIPO_CUENTA") Then Exit Function

Cmb_Tipo_Cuenta.Clear
Do While BAC_SQL_FETCH(Datos())

 Cmb_Tipo_Cuenta.AddItem Datos(2) & Space(100) & Datos(1)

Loop

End Function
Private Function FUNC_TRAER_RELACION_BANCO()
Dim Datos()

If Not BAC_SQL_EXECUTE("SP_CON_RELACION_FORMA_PAGO") Then Exit Function

Cmb_Forma_Pago.Clear
Do While BAC_SQL_FETCH(Datos())

 Cmb_Forma_Pago.AddItem Datos(2) & Space(100) & Datos(1)

Loop

End Function
Private Function FUNC_Valida() As Boolean

   Dim sCadena          As String

   FUNC_Valida = False

   If CDbl(txtCodigo) = 0 Then
      sCadena = sCadena & "- Debe ingresar Código moneda." & vbCrLf

   End If

   If Trim$(txtGlosa) = "" Then
      sCadena = sCadena & "- Debe ingresar Glosa." & vbCrLf

   End If

   If (TxtGlosa2) = "" Then
      sCadena = sCadena & "- Debe ingresar Glosa Breve." & vbCrLf

   End If

   If (txtPerfil) = "" Then
      sCadena = sCadena & "- Debe ingresar Código Perfil." & vbCrLf

   End If

   If TxtDiasvalor.Text = "" Then
      sCadena = sCadena & "- Debe ingresar Días valor." & vbCrLf

   End If

   If sCadena <> "" Then
      sCadena = "FALTAN INGRESAR ALGUNOS DATOS" & vbCrLf & vbCrLf & sCadena
      MsgBox sCadena, vbExclamation
      Exit Function

   End If

   FUNC_Valida = True

End Function

Private Function FUNC_ActivaBoton(Valor As Boolean)

   txtCodigo.Enabled = Not Valor
   Toolbar1.Buttons(4).Enabled = Not Valor
   txtGlosa.Enabled = Valor
   TxtGlosa2.Enabled = Valor
   txtPerfil.Enabled = Valor
   Cmb_Tipo_Cuenta.Enabled = Valor
   TxtDiasvalor.Enabled = Valor
   cmb2756.Enabled = Valor
   cmbAfecta.Enabled = Valor
   cmbExige.Enabled = Valor
   cmbExigeCh.Enabled = Valor
   chk_Settlement.Enabled = Valor
   Cmb_Forma_Pago.Enabled = Valor
   Toolbar1.Buttons(2).Enabled = Valor
   Toolbar1.Buttons(3).Enabled = Valor
   chk_Contable.Enabled = Valor

End Function

Private Sub cmb2756_KeyPress(KeyAscii As Integer)

   If KeyAscii = vbKeyReturn Then
      Bac_SendKey (vbKeyTab)

   ElseIf KeyAscii <> 78 And KeyAscii <> 110 And KeyAscii <> 83 And KeyAscii <> 115 Then
      KeyAscii = 0

   End If

End Sub

Private Sub cmb2756_LostFocus()

   If Trim(cmb2756) = "" Then
      cmb2756.SetFocus

   End If

End Sub

Private Sub cmbAfecta_KeyPress(KeyAscii As Integer)

   If KeyAscii = vbKeyReturn Then
      Bac_SendKey (vbKeyTab)

   ElseIf KeyAscii <> 78 And KeyAscii <> 110 And KeyAscii <> 83 And KeyAscii <> 115 Then
      KeyAscii = 0

   End If

End Sub

Private Sub cmbAfecta_LostFocus()

   If Trim(cmbAfecta) = "" Then
      cmbAfecta.SetFocus

   End If

End Sub

Private Sub cmbExige_KeyPress(KeyAscii As Integer)

   If KeyAscii = vbKeyReturn Then
      Bac_SendKey (vbKeyTab)

   ElseIf KeyAscii <> 78 And KeyAscii <> 110 And KeyAscii <> 83 And KeyAscii <> 115 Then
      KeyAscii = 0

   End If

End Sub

Private Sub cmbExigeCh_KeyPress(KeyAscii As Integer)

   If KeyAscii = vbKeyReturn Then
      Toolbar1.Buttons(4).Enabled = True
      Bac_SendKey (vbKeyTab)

   ElseIf KeyAscii <> 78 And KeyAscii <> 110 And KeyAscii <> 83 And KeyAscii <> 115 Then
      KeyAscii = 0

   End If

End Sub

Private Sub cmbExigeCh_LostFocus()

   If Trim(cmbExigeCh) = "" Then
      cmbExige.SetFocus

   Else
      Toolbar1.Buttons(4).Enabled = True

   End If

End Sub

Private Sub PROC_LIMPIAR()

   Screen.MousePointer = 11

   objFPago.Limpiar

   txtCodigo = ""
   txtGlosa = ""
   TxtGlosa2 = ""
   txtPerfil = ""
   TxtDiasvalor = 0
   cmb2756.ListIndex = 0
   cmbAfecta.Text = "SI"
   chk_Contable.Value = 1
   If cmbExige.ListCount > 0 Then cmbExige.ListIndex = 0
   If cmbExigeCh.ListCount > 0 Then cmbExigeCh.ListIndex = 0
   If Cmb_Forma_Pago.ListCount > 0 Then Cmb_Forma_Pago.ListIndex = 0
   If Cmb_Tipo_Cuenta.ListCount > 0 Then Cmb_Tipo_Cuenta.ListIndex = 0
   FormaBC.Value = 0
   Call FUNC_ActivaBoton(False)

   If Me.Visible Then
      txtCodigo.SetFocus

   End If

   Screen.MousePointer = 0

End Sub

Private Sub Form_Activate()
   PROC_CARGA_AYUDA Me, " "
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)

   Dim iOpcion          As Integer

   On Error GoTo Errores

   iOpcion = 0

   If KeyCode = vbKeyReturn Then
      KeyCode = 0
      Bac_SendKey vbKeyTab
      Exit Sub

   End If

   If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) Then
      Select Case KeyCode
      Case vbKeyLimpiar
         iOpcion = 1

      Case vbKeyGrabar
         iOpcion = 2

      Case vbKeyEliminar
         iOpcion = 3

      Case vbKeyBuscar
         iOpcion = 4

      Case vbKeySalir
         iOpcion = 5

      End Select

      If iOpcion <> 0 Then
         If Toolbar1.Buttons(iOpcion).Enabled Then
            Call Toolbar1_ButtonClick(Toolbar1.Buttons(iOpcion))

         End If

         KeyCode = 0

      End If


   End If

   On Error GoTo 0

   Exit Sub

Errores:
   Resume Next
   On Error GoTo 0

End Sub

Private Sub Form_Load()

   OptLocal = Opt
   Me.top = 0
   Me.left = 0

   If WindowState = 0 Then
      top = 1
      left = 15

   End If

   cmb2756.AddItem "NO"
   cmb2756.AddItem "SI"

   cmbAfecta.AddItem "NO"
   cmbAfecta.AddItem "SI"

   cmbExige.AddItem "NO"
   cmbExige.AddItem "SI"

   cmbExigeCh.AddItem "NO"
   cmbExigeCh.AddItem "SI"
   Call FUNC_TRAER_RELACION_BANCO
   Call FUNC_TIPO_CUENTA
   Call PROC_LIMPIAR

   Call LogAuditoria("07", OptLocal, Me.Caption, "", "")

End Sub

Private Sub Form_Unload(Cancel As Integer)

   Call LogAuditoria("08", OptLocal, Me.Caption, "", "")

End Sub

Private Sub Frame1_Click()

   Bac_SendKey (vbKeyTab)

End Sub

Private Sub Frame2_Click()

   Bac_SendKey (vbKeyTab)

End Sub

Private Sub SSPanel1_Click()

   Bac_SendKey (vbKeyTab)

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

   Select Case Button.Index
   Case 4
      txtCodigo_KeyPress (13)

   Case 1
      Screen.MousePointer = 11

      objFPago.Limpiar

      txtCodigo = ""
      txtGlosa = ""
      TxtGlosa2 = ""
      txtPerfil = ""
      TxtDiasvalor = 0
      cmb2756.ListIndex = 0
      cmbAfecta.ListIndex = 0
      cmbExige.ListIndex = 0
      cmbExigeCh.ListIndex = 0
      chk_Settlement.Value = 0
      chk_Contable = 1
      Cmb_Tipo_Cuenta.ListIndex = 0
      FormaBC.Value = 0
      Call FUNC_ActivaBoton(False)

      If Me.Visible Then
         txtCodigo.SetFocus

      End If

      Screen.MousePointer = 0

   Case 2
      Me.MousePointer = 11

      If Not FUNC_Valida Then
         Me.MousePointer = 0
         Exit Sub

      End If

      If Val(Trim(txtCodigo.Text)) = 0 Or Trim(txtGlosa.Text) = "" Or Trim(txtPerfil.Text) = "" Or Trim(TxtGlosa2.Text) = "" Then ' Val(TxtDiasvalor.Text) = 0 Or
         MsgBox "Falta Informacion Para Grabar", vbInformation
         Me.MousePointer = vbDefault
         Exit Sub
      End If

      objFPago.codigo = CDbl(txtCodigo.Text)
      objFPago.glosa = txtGlosa.Text
      objFPago.Perfil = txtPerfil.Text
      objFPago.CodGen = Val(right(Me.Cmb_Tipo_Cuenta.Text, 1))
      objFPago.Glosa2 = TxtGlosa2.Text
      objFPago.cc2756 = left(cmb2756, 1)
      objFPago.AfectaCorr = left(cmbAfecta, 1)
      objFPago.DiasValor = CDbl(TxtDiasvalor.Text)
      objFPago.NumCheque = left(cmbExigeCh, 1)
      objFPago.CtaCte = left(cmbExige, 1)
      objFPago.Settlement = chk_Settlement.Value
      objFPago.iRelacion_Bcch = Val(right(Me.Cmb_Forma_Pago.Text, 5))
      If FormaBC.Value = 1 Then
         objFPago.FPBancoC = "S"
      Else
         objFPago.FPBancoC = "N"
      End If
      
      If chk_Contable.Value = 1 Then
          objFPago.Contable = "S"
      Else
          objFPago.Contable = "N"
      End If
      
      
      If objFPago.GRABAR = True Then
         Me.MousePointer = 0
         MsgBox " Grabación  fue  Exitosa  ", 64

         Call LogAuditoria("01", OptLocal, Me.Caption, "", "Codigo: " & txtCodigo.Text & " Perfil: " & txtPerfil.Text & " Glosa: " & txtGlosa.Text & " Dias Valor: " & TxtDiasvalor.Text & " Afecto a lineas: " & cmbAfecta.Text)
         PROC_LIMPIAR
         Exit Sub

      End If

      Call LogAuditoria("01", OptLocal, Me.Caption & " Error al grabar- Codigo: " & txtCodigo.Text & " Perfil: " & txtPerfil.Text & " Glosa: " & txtGlosa.Text & " Dias Valor: " & TxtDiasvalor.Text & " Afecto a lineas: " & cmbAfecta.Text, "", "")
      Me.MousePointer = 0

   Case 3
      If Val(Trim(txtCodigo.Text)) = 0 Then
         Exit Sub

      End If

      If MsgBox("Esta Seguro de Eliminar Forma de pago :" & vbCrLf & txtGlosa.Text, vbYesNo + vbQuestion) <> vbYes Then
         Exit Sub

      End If

      If objFPago.Eliminar(CDbl(txtCodigo.Text)) Then
         Call LogAuditoria("03", OptLocal, Me.Caption, "Codigo: " & txtCodigo.Text & " Perfil: " & txtPerfil.Text & " Glosa: " & txtGlosa.Text & " Dias Valor: " & TxtDiasvalor.Text & " Afecto a lineas: " & cmbAfecta.Text, "")
         PROC_LIMPIAR
         Exit Sub

      End If

      Call LogAuditoria("03", OptLocal, Me.Caption & " Error al grabar- Codigo: " & txtCodigo.Text & " Perfil: " & txtPerfil.Text & " Glosa: " & txtGlosa.Text & " Dias Valor: " & TxtDiasvalor.Text & " Afecto a lineas: " & cmbAfecta.Text, "", "")

   Case 5
      Unload Me

   End Select

End Sub


Private Sub txtCodigo_DblClick()

   BacControlWindows 100

   MiTag = "MDFP_U"
  BacAyuda.Show 1

   If giAceptar% Then
      txtCodigo.Text = gsCodigo
      txtGlosa.Text = gsGlosa
      txtCodigo.SetFocus
      Bac_SendKey (vbKeyReturn)
   End If

End Sub

Private Sub TxtCodigo_KeyDown(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyF3 Then
      Call txtCodigo_DblClick

   End If

End Sub

Private Sub txtCodigo_KeyPress(KeyAscii As Integer)
Dim i As Integer
   BacSoloNumeros KeyAscii

   If KeyAscii = vbKeyReturn Then
      If Val(txtCodigo.Text) > 0 Then
         Call FUNC_ActivaBoton(True)

         If Not objFPago.LeerxCodigo(txtCodigo) Then
            objFPago.Limpiar
         End If

         Toolbar1.Buttons(3).Enabled = (objFPago.codigo <> 0)

         txtGlosa.Text = objFPago.glosa
         txtPerfil.Text = objFPago.Perfil
         TxtGlosa2.Text = objFPago.Glosa2
         cmb2756.ListIndex = IIf(objFPago.cc2756 = left(cmb2756.List(0), 1), 0, 1)
         cmbAfecta.ListIndex = IIf(objFPago.AfectaCorr = left(cmbAfecta.List(0), 1), 0, 1)
         TxtDiasvalor.Text = objFPago.DiasValor
         cmbExige.ListIndex = IIf(objFPago.CtaCte = left(cmbExige.List(0), 1), 0, 1)
         cmbExigeCh.ListIndex = IIf(objFPago.NumCheque = left(cmbExigeCh.List(0), 1), 0, 1)
         chk_Settlement.Value = IIf(objFPago.Settlement = "", 0, objFPago.Settlement)
         If objFPago.FPBancoC = "S" Then
            FormaBC.Value = 1
         Else
            FormaBC.Value = 0
         End If
         
         If objFPago.Contable = "S" Then
            chk_Contable.Value = 1
         Else
            chk_Contable.Value = 0
         End If
         
         For i = 0 To Cmb_Tipo_Cuenta.ListCount - 1
            Cmb_Tipo_Cuenta.ListIndex = i
            If objFPago.CodGen = Val(right(Me.Cmb_Tipo_Cuenta.Text, 5)) Then
                Exit For
            End If
         Next i
         
         For i = 0 To Cmb_Forma_Pago.ListCount - 1
            Cmb_Forma_Pago.ListIndex = i
            If objFPago.iRelacion_Bcch = Val(right(Me.Cmb_Forma_Pago.Text, 5)) Then
                Exit For
            End If
         Next i
         
         
         BacControlWindows 1000
         txtPerfil.SetFocus

      Else
         Call FUNC_ActivaBoton(False)

      End If

   End If

End Sub

Private Sub TxtDiasvalor_KeyPress(KeyAscii As Integer)

   If KeyAscii = vbKeyReturn And Trim(TxtDiasvalor) <> "" Then
      Bac_SendKey (vbKeyTab)

   ElseIf TxtDiasvalor.Text = "0" Then
      TxtDiasvalor = ""

   End If

   If (KeyAscii <= 47 Or KeyAscii >= 58) And KeyAscii <> 8 Then
      KeyAscii = 0

   End If

End Sub

Private Sub Txtglosa_KeyPress(KeyAscii As Integer)

   Call BacToUCase(KeyAscii)

   If KeyAscii = 39 Or KeyAscii = 34 Or Chr(KeyAscii) = "." Or Chr(KeyAscii) = "," Then
      KeyAscii = 0

   End If

   If KeyAscii = vbKeyReturn Then
      Bac_SendKey (vbKeyTab)

   End If

End Sub

Private Sub TxtGLOSA2_KeyPress(KeyAscii As Integer)

   Call BacToUCase(KeyAscii)

   If KeyAscii = 39 Or KeyAscii = 34 Or Chr(KeyAscii) = "." Or Chr(KeyAscii) = "," Then
      KeyAscii = 0

   End If

   If KeyAscii = vbKeyReturn Then
      Bac_SendKey (vbKeyTab)

   End If

End Sub

Private Sub txtPerfil_KeyPress(KeyAscii As Integer)

   Call BacToUCase(KeyAscii)

   If KeyAscii = 39 Or KeyAscii = 34 Or Chr(KeyAscii) = "." Or Chr(KeyAscii) = "," Then
      KeyAscii = 0

   End If

End Sub

