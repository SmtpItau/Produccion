VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "threed32.ocx"
Begin VB.Form frm_man_serie_fondos_mutuos 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Serie Fondos Mutuos "
   ClientHeight    =   3360
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   7125
   Icon            =   "frm_man_serie_fondos_mutuos.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   3360
   ScaleWidth      =   7125
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   8
      Top             =   0
      Width           =   7125
      _ExtentX        =   12568
      _ExtentY        =   847
      ButtonWidth     =   820
      ButtonHeight    =   794
      Appearance      =   1
      Style           =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Limpiar"
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Grabar"
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Eliminar"
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Buscar"
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   5
         EndProperty
      EndProperty
      BorderStyle     =   1
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   6420
         Top             =   -30
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   24
         ImageHeight     =   24
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   5
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_man_serie_fondos_mutuos.frx":030A
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_man_serie_fondos_mutuos.frx":11E4
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_man_serie_fondos_mutuos.frx":20BE
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_man_serie_fondos_mutuos.frx":2F98
               Key             =   ""
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "frm_man_serie_fondos_mutuos.frx":3E72
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin Threed.SSFrame Frame 
      Height          =   2250
      Index           =   0
      Left            =   0
      TabIndex        =   9
      Top             =   480
      Width           =   7005
      _Version        =   65536
      _ExtentX        =   12356
      _ExtentY        =   3969
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
      Begin VB.TextBox txtDescripcion 
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
         Left            =   1560
         MaxLength       =   70
         TabIndex        =   1
         Top             =   480
         Width           =   5325
      End
      Begin VB.TextBox txtSerie 
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
         Left            =   1560
         MaxLength       =   12
         MouseIcon       =   "frm_man_serie_fondos_mutuos.frx":418C
         MousePointer    =   99  'Custom
         TabIndex        =   0
         Top             =   120
         Width           =   1560
      End
      Begin VB.TextBox txtGlosaMoneda 
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   300
         Left            =   2295
         MaxLength       =   30
         TabIndex        =   7
         Top             =   1800
         Width           =   4575
      End
      Begin VB.TextBox txtCodigo 
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
         Left            =   1560
         MaxLength       =   3
         MouseIcon       =   "frm_man_serie_fondos_mutuos.frx":4496
         MousePointer    =   99  'Custom
         TabIndex        =   6
         Top             =   1800
         Width           =   615
      End
      Begin VB.TextBox txtcodcli 
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
         Left            =   5790
         MaxLength       =   5
         MouseIcon       =   "frm_man_serie_fondos_mutuos.frx":47A0
         MultiLine       =   -1  'True
         TabIndex        =   4
         Top             =   960
         Width           =   1095
      End
      Begin VB.TextBox txtRut 
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
         Left            =   1560
         MaxLength       =   9
         MouseIcon       =   "frm_man_serie_fondos_mutuos.frx":4AAA
         MousePointer    =   99  'Custom
         MultiLine       =   -1  'True
         TabIndex        =   2
         Top             =   975
         Width           =   1140
      End
      Begin VB.TextBox txtDigito 
         Enabled         =   0   'False
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
         Left            =   2850
         MaxLength       =   1
         TabIndex        =   3
         Top             =   975
         Width           =   255
      End
      Begin VB.TextBox TxtNombre 
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
         Left            =   1560
         MaxLength       =   40
         TabIndex        =   5
         Top             =   1305
         Width           =   5325
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         BackColor       =   &H00FFFFFF&
         BackStyle       =   0  'Transparent
         Caption         =   "Descripción"
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
         Index           =   5
         Left            =   60
         TabIndex        =   15
         Top             =   525
         Width           =   975
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         BackColor       =   &H00FFFFFF&
         BackStyle       =   0  'Transparent
         Caption         =   "Serie"
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
         Left            =   60
         TabIndex        =   14
         Top             =   180
         Width           =   435
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         Caption         =   "Código Moneda "
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
         Left            =   60
         TabIndex        =   13
         Top             =   1830
         Width           =   1335
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         BackColor       =   &H00FFFFFF&
         BackStyle       =   0  'Transparent
         Caption         =   "Código Cliente"
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
         Left            =   4500
         TabIndex        =   12
         Top             =   1005
         Width           =   1215
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         BackColor       =   &H00FFFFFF&
         BackStyle       =   0  'Transparent
         Caption         =   "Rut Cliente"
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
         Left            =   60
         TabIndex        =   11
         Top             =   1020
         Width           =   900
      End
      Begin VB.Label Label 
         AutoSize        =   -1  'True
         BackColor       =   &H00FFFFFF&
         BackStyle       =   0  'Transparent
         Caption         =   "Nombre"
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
         Left            =   60
         TabIndex        =   10
         Top             =   1350
         Width           =   660
      End
      Begin VB.Line Line1 
         X1              =   2745
         X2              =   2805
         Y1              =   1095
         Y2              =   1095
      End
   End
End
Attribute VB_Name = "frm_man_serie_fondos_mutuos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private objCliente            As Object
Private Objrutcli             As Object
Dim OptLocal                  As String

Private Sub Form_Load()
    Set objCliente = New clsCliente
    Set Objrutcli = New clsCliente
    Call PROC_APHabilitarControlesCliente(False)
    Call PROC_APHabilitarControlesMoneda(False)
    Call PROC_APHabilitarControles(False)
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
    Select Case Trim(UCase(Button.Key))
        Case Is = "BUSCAR"
        If Trim$(txtSerie.Text) = "" Then
            MsgBox "Falta Información Para la Busqueda", vbInformation, "Serie Fondos Mutuos"
            On Error GoTo 0
            Exit Sub
        Else
            Call FUNC_BuscaSerieFFMM
        End If
        Case Is = "SALIR"
            Unload Me
        Case Is = "GRABAR"
            If FUNC_VerificaBlancosMSG = True Then
                If Not FUNC_GRABA_SerieFFMM() Then Exit Sub
            End If
        Case Is = "LIMPIAR"
            Call PROC_APLIMIPIAR
        Case Is = "ELIMINAR"
            If Not FUNC_ELIMINA_SerieFFMM() Then Exit Sub
     End Select
End Sub





Private Sub TxtDescripcion_KeyPress(KeyAscii As Integer)
     BacToUCase KeyAscii
    If KeyAscii = vbKeyReturn Then
        If Trim$(txtSerie) <> "" And Trim$(txtDescripcion) <> "" Then
                txtRut.Enabled = True
                txtRut.SetFocus
        End If
    End If
End Sub



Private Sub TxtDescripcion_LostFocus()
    If FUNC_VerificaBlancos = True Then
        Call PROC_APHabilitarControles(True)
    End If
End Sub



Private Sub TxtNombre_LostFocus()
    TxtNombre.Enabled = False
End Sub

Private Sub txtSerie_DblClick()
    auxilio = 100
    Call CodigoFFMM
End Sub

Private Sub txtSerie_KeyPress(KeyAscii As Integer)
    BacToUCase KeyAscii
    If KeyAscii = vbKeyReturn And Trim$(txtSerie) <> "" Then
        Call FUNC_BuscaSerieFFMM
    End If
End Sub
Private Sub txtSerie_LostFocus()
    If FUNC_VerificaBlancos = True Then
        Call PROC_APHabilitarControles(True)
        
    End If
        
        Call FUNC_BuscaSerieFFMM
        txtSerie.Enabled = False
        
        Call PROC_APHabilitarControlesCliente(True)
        Call PROC_APHabilitarControlesMoneda(True)
    If TxtNombre.Text <> "" Then
        TxtNombre.Enabled = False
    End If
    
    If txtDescripcion.Text <> "" Then
        txtDescripcion.Enabled = False
    End If
    
    If txtGlosaMoneda.Text <> "" Then
        txtGlosaMoneda.Enabled = False
    End If
    
End Sub
Private Sub txtcodcli_DblClick()

   Call txtRut_DblClick

End Sub

Private Sub txtcodcli_KeyDown(KeyCode As Integer, Shift As Integer)
        
   If KeyCode = vbKeyAyuda Then
      Call txtRut_DblClick
   End If

End Sub
Private Sub txtcodcli_LostFocus()

    If FUNC_VerificaBlancos = True Then
        Call PROC_APHabilitarControles(True)
    End If
    
    'Call txtRut_DblClick
    
    If TxtNombre.Text <> "" Then
        TxtNombre.Enabled = False
    Else
        TxtNombre.Enabled = True
    End If
    
End Sub
Private Sub txtcodcli_KeyPress(KeyAscii As Integer)

   BacSoloNumeros KeyAscii

   If KeyAscii = vbKeyReturn And Trim$(txtcodcli.Text) <> "" Then
      KeyAscii = 0
      Call FUNC_BuscarClientes
       If txtCodigo.Enabled Then
        txtCodigo.SetFocus
        Bac_SendKey vbKeyHome
        Exit Sub
       End If
    End If

End Sub

Private Sub txtDigito_KeyPress(KeyAscii As Integer)

   If KeyAscii% = vbKeyReturn And Trim$(txtDigito.Text) <> "" Then
      Exit Sub

   End If

   If InStr("0123456789K", UCase(Chr(KeyAscii))) = 0 Then
      KeyAscii = 0

   End If

End Sub

Private Sub txtDigito_LostFocus()

   If PROC_ControlRUT(txtRut, txtDigito) = True Then
      objCliente.clrut = txtRut.Text
      objCliente.cldv = txtDigito.Text

   Else
      MsgBox "Error : Rut Incorrecto", 16
      Call PROC_APLIMIPIAR
      Call PROC_APHabilitarControlesCliente(False)
      txtRut.SetFocus
      Exit Sub

   End If

End Sub

Private Sub TxtNombre_DblClick()

   Call txtRut_DblClick
    TxtNombre.Enabled = False
End Sub

Private Sub TxtNombre_KeyDown(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyAyuda Then
      Call txtRut_DblClick
        TxtNombre.Enabled = False
   End If

End Sub

Private Sub txtRut_DblClick()

   BacControlWindows 100

   MiTag = "MDCL_FFMM"
   BacAyuda.Show 1

   If giAceptar% Then
      txtRut.Text = Val(gsrut$)
      txtcodcli.Text = gsCodCli

      Call FUNC_BuscarClientes

      txtCodigo.Enabled = True
      txtCodigo.SetFocus
      TxtNombre.Enabled = False
   End If

End Sub

Private Sub txtRut_KeyDown(KeyCode As Integer, Shift As Integer)
   
   If KeyCode = vbKeyF3 Then
      Call txtRut_DblClick

   End If

End Sub

Private Sub txtRut_KeyPress(KeyAscii As Integer)

   BacSoloNumeros KeyAscii

   If KeyAscii% = vbKeyReturn And Val(Trim$(txtRut.Text)) > 0 Then
      KeyAscii% = 0
      txtDigito = FUNC_DevuelveDig(txtRut.Text)
      Bac_SendKey vbKeyTab

   End If

   If Not ((KeyAscii > 47 And KeyAscii < 58) Or KeyAscii = 8) Then
      KeyAscii = 0

   End If

End Sub

Private Sub txtRut_LostFocus()
    If FUNC_VerificaBlancos = True Then
        Call PROC_APHabilitarControles(True)
        TxtNombre.Enabled = False
    End If
End Sub

Private Sub TxtCodigo_DblClick()

   auxilio = 100
   Call PROC_CodigoMoneda

   If txtCodigo.Enabled = True Then
      txtCodigo.SetFocus

   End If

End Sub
Private Sub TxtCodigo_KeyDown(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyF3 Then
      Call PROC_CodigoMoneda
      If txtGlosaMoneda.Enabled Then txtGlosaMoneda.SetFocus
      Exit Sub

   End If

   If KeyCode = vbKeyReturn Then
      KeyCode = 0
      Call TxtCodigo_LostFocus

      If txtGlosaMoneda.Enabled = True Then
         txtGlosaMoneda.SetFocus

      End If

   End If

End Sub


Private Sub txtCodigo_KeyPress(KeyAscii As Integer)

   If Not IsNumeric(Chr(KeyAscii)) And KeyAscii <> 8 Then
      KeyAscii = 0

   End If

End Sub

Private Sub TxtCodigo_LostFocus()

   MousePointer = 11

   If txtCodigo.Text = "" Then
      MousePointer = 0
      On Error GoTo 0
      Exit Sub
   End If

   If CDbl(txtCodigo.Text) = 0 Then
      MousePointer = 0
      On Error GoTo 0
      Exit Sub
   End If

   Call FUNC_LeerPorCodigo(txtCodigo.Text)
   MousePointer = 0

    If FUNC_VerificaBlancos = True Then
        Call PROC_APHabilitarControles(True)
        
    End If
        
    If txtGlosaMoneda.Text <> "" Then
        txtGlosaMoneda.Enabled = False
    Else
        txtGlosaMoneda.Enabled = True
        txtCodigo.Text = ""
    End If
        
        
End Sub
Private Sub PROC_APLIMIPIAR()
    txtSerie.Text = ""
    txtRut.Text = ""
    txtDigito.Text = ""
    TxtNombre.Text = ""
    txtcodcli.Text = ""
    txtDescripcion.Text = ""
    
    txtSerie.Enabled = True
    txtRut.Enabled = True
    txtcodcli.Enabled = True
    
    txtCodigo.Text = ""
    txtGlosaMoneda.Text = ""
    txtCodigo.Enabled = True
   

    Call PROC_APHabilitarControlesCliente(False)
    Call PROC_APHabilitarControlesMoneda(False)
    Call PROC_APHabilitarControles(False)

   txtSerie.SetFocus

End Sub
Private Sub PROC_CodigoMoneda()

   On Error GoTo Errores

   MousePointer = 11


   MiTag = "MDMN"
   BacAyuda.Show 1

   If giAceptar% = True Then
      txtCodigo.Text = gsCodigo$
      TxtCodigo_LostFocus

   End If

   MousePointer = 0
   txtGlosaMoneda.SetFocus

   On Error GoTo 0

   Exit Sub

Errores:
   On Error GoTo 0

End Sub
Private Function FUNC_LeerPorCodigo(CodMon As Long) As Boolean

   
   FUNC_LeerPorCodigo = False

   Envia = Array()
   AddParam Envia, CodMon

   If Not BAC_SQL_EXECUTE("SP_MNLEER ", Envia) Then
      Exit Function

   End If

   If BAC_SQL_FETCH(Datos()) Then
      If Val(Datos(1)) < 0 Then
            MsgBox Datos(2), vbExclamation, gsBac_Version
            txtCodigo.Text = ""
            Exit Function
      Else
          txtGlosaMoneda.Text = Datos(4)
      End If
   Else
      txtGlosaMoneda.Text = ""
   End If

   FUNC_LeerPorCodigo = True

End Function

Private Function FUNC_BuscarClientes()

   Dim idRut         As String
   Dim IdDig         As String
   Dim lValor        As Boolean

   idRut = txtRut.Text
   IdDig = txtDigito.Text
   lValor = True

   If txtRut.Text = "" Then
      Exit Function

   End If

   txtDigito.Text = FUNC_DevuelveDig(txtRut.Text)
   Screen.MousePointer = 11

   If PROC_ControlRUT(txtRut, txtDigito) = True Then
      objCliente.clrut = CDbl(txtRut.Text)
      objCliente.cldv = txtDigito.Text
      objCliente.clcodigo = Val(txtcodcli.Text)

      If objCliente.LeerxRut(objCliente.clrut, objCliente.clcodigo) Then
         If objCliente.clrut <> 0 Then
            TxtNombre.Text = objCliente.clnombre
            TxtNombre.Tag = TxtNombre.Text
            txtcodcli.Text = objCliente.clcodigo

         Else
            MsgBox "Error : No existe , El Rut o el Codigo del cliente ", vbInformation
            lValor = False
            
         End If

      Else
         Screen.MousePointer = 0
         MsgBox "Error : En Carga de Datos", 16
         lValor = False
         Exit Function

      End If

   Else
      MsgBox "Error : Rut Incorrecto", vbInformation
      lValor = False

   End If

   If Not (lValor) Then  ' ES FALSO
      txtRut.Text = ""
      txtDigito.Text = ""
      txtcodcli.Text = ""
      TxtNombre.Text = ""
      txtRut.SetFocus
      Screen.MousePointer = 0
      Exit Function

   Else
      Call PROC_APHabilitarControlesCliente(True)
      

   End If

   idRut = txtRut.Text
   Screen.MousePointer = 0

End Function
Private Sub PROC_APHabilitarControlesCliente(Valor As Boolean)

   txtRut.Enabled = Valor
   txtcodcli.Enabled = Valor
   TxtNombre.Enabled = Valor
   
   
End Sub

Private Sub PROC_APHabilitarControlesMoneda(Valor As Boolean)

   txtCodigo.Enabled = Valor
   txtGlosaMoneda.Enabled = Valor
End Sub
Private Sub PROC_APHabilitarControles(Valor As Boolean)
    Toolbar1.Buttons(1).Enabled = True
    Toolbar1.Buttons(2).Enabled = Valor
    Toolbar1.Buttons(3).Enabled = Valor
End Sub
   
Private Function PROC_ControlRUT(tex As String, tex1 As String)

   Dim Valida     As Integer
   Dim idRut      As String
   Dim IdDig      As String

   idRut = tex
   IdDig = tex1

   Valida = True

   If Trim$(idRut$) = "" Or Trim$(IdDig$) = "" Or (Trim$(idRut$) = "0" And Trim$(IdDig$) = "0") Then
      Valida = False

   End If

   If BacValidaRut(tex, tex1) = False Then
      Valida = False

   End If

   PROC_ControlRUT = Valida

End Function


Private Function FUNC_DevuelveDig(Rut As String) As String

   Dim i          As Integer
   Dim D          As Integer
   Dim Divi       As Long
   Dim Suma       As Long
   Dim Digito     As String
   Dim Multi      As Double

   FUNC_DevuelveDig = ""

   Rut = Format(Rut, "00000000")
   D = 2

   For i = 8 To 1 Step -1
      Multi = Val(Mid$(Rut, i, 1)) * D
      Suma = Suma + Multi
      D = D + 1

      If D = 8 Then
         D = 2

      End If

   Next i

   Divi = (Suma \ 11)
   Multi = Divi * 11
   Digito = Trim$(Str$(11 - (Suma - Multi)))

   If Digito = "10" Then
      Digito = "K"

   End If

   If Digito = "11" Then
      Digito = "0"

   End If

   FUNC_DevuelveDig = UCase(Digito)

End Function




Private Function FUNC_VerificaBlancos() As Boolean

    If Trim$(txtSerie) = "" Then
        GoTo SALIR
    End If
    If Trim$(txtDescripcion) = "" Then
        GoTo SALIR
    End If
    
    If Trim$(txtRut) = "" Then
        GoTo SALIR
    End If
    If Trim$(txtcodcli) = "" Then
        GoTo SALIR
    End If
    If Trim$(txtCodigo) = "" Then
        GoTo SALIR
    End If
FUNC_VerificaBlancos = True
    Exit Function
SALIR:
    FUNC_VerificaBlancos = False
End Function

Private Function FUNC_VerificaBlancosMSG() As Boolean

    If Trim$(txtSerie) = "" Then
        MsgBox "Debe Ingresar la serie", vbInformation
        txtSerie.SetFocus
        GoTo SALIR
    End If
    If Trim$(txtRut) = "" Then
        MsgBox "Debe Ingresar el rut de Cliente", vbInformation, "Serie Fondos Mutuos"
        txtRut.SetFocus
        GoTo SALIR
    End If
    If Trim$(txtcodcli) = "" Then
        MsgBox "Debe Ingresar el código de Cliente", vbInformation, "Serie Fondos Mutuos"
        txtcodcli.SetFocus
        GoTo SALIR
    End If
    If Trim$(txtCodigo) = "" Then
        MsgBox "Debe Ingresar el código de Moneda", vbInformation, "Serie Fondos Mutuos"
        txtCodigo.SetFocus
        GoTo SALIR
    End If
FUNC_VerificaBlancosMSG = True
    Exit Function
SALIR:
    FUNC_VerificaBlancosMSG = False
End Function

Private Function FUNC_GRABA_SerieFFMM()
    Envia = Array()
    AddParam Envia, txtSerie.Text
    AddParam Envia, txtRut.Text
    AddParam Envia, txtcodcli.Text
    AddParam Envia, txtCodigo.Text
    AddParam Envia, txtDescripcion.Text
    
    If Not BAC_SQL_EXECUTE("SP_ACT_SERIE_FONDOS_MUTUOS", Envia) Then
       MsgBox "Error al Grabar el Serie Fondos Mutuos", vbExclamation
       Call LogAuditoria("01", OptLocal, Me.Caption + " Error al grabar Fondos Mutuos  Serie:", "", txtSerie.Text)
       Me.MousePointer = Default
       On Error GoTo 0
       Exit Function
    
    End If

    If BAC_SQL_FETCH(Datos()) Then
        If Datos(1) = "OK" Then
            MsgBox "Grabación se realizó correctamente", vbInformation
            Call LogAuditoria("01", OptLocal, Me.Caption + " Grabación Exitosa   Serie:", "", txtSerie.Text)
        ElseIf Datos(1) = "NOK" Then
            MsgBox "Registro no fue actualizado" & vbCr & "Ya existe un Nemotecnico asiciado a este emisor", vbInformation
        
        Else
           MsgBox "Registro no fue actualizado", vbInformation
        End If
    End If
    
    Me.MousePointer = 0
    Call PROC_APLIMIPIAR
    PROC_APHabilitarControlesCliente False
    Toolbar1.Buttons(3).Enabled = False
    txtSerie.SetFocus
    
End Function
Private Function FUNC_BuscaSerieFFMM() As Boolean
   
   Screen.MousePointer = 11

   FUNC_BuscaSerieFFMM = False

   Envia = Array()

   AddParam Envia, txtSerie
   
   If Not BAC_SQL_EXECUTE("SP_CON_SERIE_FONDOS_MUTUOS", Envia) Then
      MsgBox "Consulta en BacParametros Ha Fallado. Servidor SQL No Responde", vbCritical
      Exit Function
   End If

   If BAC_SQL_FETCH(Datos()) Then
        txtRut.Text = Val(Datos(1))
        txtDigito.Text = Datos(2)
        TxtNombre.Text = Datos(3)
        txtcodcli.Text = Val(Datos(4))
        txtCodigo.Text = Val(Datos(5))
        txtGlosaMoneda.Text = Datos(6)
        txtDescripcion.Text = Datos(7)
        Call PROC_APHabilitarControlesCliente(True)
        Call PROC_APHabilitarControlesMoneda(False)
        Call PROC_APHabilitarControles(True)
        txtSerie.Enabled = False
   Else
    
        txtRut.Text = ""
        txtDigito.Text = ""
        TxtNombre.Text = ""
        txtcodcli.Text = ""
        txtCodigo.Text = ""
        txtGlosaMoneda.Text = ""
        txtDescripcion.Text = ""

'        txtDescripcion.SetFocus
        
        Call PROC_APHabilitarControlesCliente(True)
        Call PROC_APHabilitarControlesMoneda(True)
        Call PROC_APHabilitarControles(True)
   End If


   Screen.MousePointer = 0

   DoEvents

End Function


Private Function FUNC_ELIMINA_SerieFFMM()
    
    
    If MsgBox("Esta Seguro de Eliminar la serie", vbQuestion + vbYesNo + vbDefaultButton2) = vbYes Then
        Envia = Array()
        AddParam Envia, txtSerie.Text
        If Not BAC_SQL_EXECUTE("SP_ELI_SERIE_FONDOS_MUTUOS", Envia) Then
           MsgBox "Error: No eliminó la Serie ", vbInformation, "Serie Fondos Mutuos"
           'Call LogAuditoria("03", OptLocal, Me.Caption + " Error al Eliminar Serie Fondos Mutuos Serie: " & txtSerie)
           On Error GoTo 0
           Exit Function
        End If

        If BAC_SQL_FETCH(Datos()) = True Then
           If Datos(1) = 2 Then
              MsgBox Datos(2), vbInformation
           End If
        Else
           MsgBox "Eliminación se realizó correctamente", vbInformation
           'Call LogAuditoria("03", OptLocal, Me.Caption, "Serie Fondos Mutuos Serie: " & txtSerie)
        End If
        
        Call PROC_APLIMIPIAR
        PROC_APHabilitarControlesCliente False
        txtSerie.SetFocus
         
      Else
         MsgBox "Los datos no han sido eliminados", vbCritical
      End If

    MousePointer = 0
    
    
End Function

Sub CodigoFFMM()
On Error GoTo Label1
    txtSerie.Text = ""
    MiTag = "FFMM"
    BacAyuda.Show 1
    If giAceptar% = True Then
       txtSerie.Text = gsNemo$
       txtSerie_KeyPress 13
        TxtNombre.Enabled = False
    End If
    
    Exit Sub

Label1:
    MousePointer = 0
    MsgBox "Error : " & err.Description, vbOKOnly + vbCritical
    Exit Sub
End Sub

