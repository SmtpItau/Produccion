VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "threed32.ocx"
Object = "{989C9190-EDF5-45A8-AB6C-98E6EF0384D7}#1.0#0"; "Bac_Controles_Pas.ocx"
Begin VB.Form Crea_Tipos_Usuarios 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Tipos de Usuarios"
   ClientHeight    =   2580
   ClientLeft      =   3795
   ClientTop       =   2340
   ClientWidth     =   6495
   ForeColor       =   &H00C0C0C0&
   Icon            =   "Crea_Tipos_Usuarios.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   2580
   ScaleWidth      =   6495
   Begin MSComctlLib.ImageList Img_opciones 
      Left            =   4920
      Top             =   150
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
            Picture         =   "Crea_Tipos_Usuarios.frx":2EFA
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Crea_Tipos_Usuarios.frx":3361
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Crea_Tipos_Usuarios.frx":3857
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Crea_Tipos_Usuarios.frx":3CEA
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Crea_Tipos_Usuarios.frx":41D2
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Tool_opciones 
      Align           =   1  'Align Top
      Height          =   480
      Left            =   0
      TabIndex        =   6
      Top             =   0
      Width           =   6495
      _ExtentX        =   11456
      _ExtentY        =   847
      ButtonWidth     =   820
      ButtonHeight    =   794
      AllowCustomize  =   0   'False
      Appearance      =   1
      Style           =   1
      ImageList       =   "Img_opciones"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   5
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Limpia"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Graba"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Elimina"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Buscar"
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
      BorderStyle     =   1
   End
   Begin VB.Frame Frm_tipo_usuario 
      Height          =   765
      Left            =   30
      TabIndex        =   5
      Top             =   465
      Width           =   6405
      Begin VB.ComboBox Cmb_tipo_usuario 
         Appearance      =   0  'Flat
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
         Left            =   1575
         TabIndex        =   0
         Text            =   "Cmb_tipo_usuario"
         Top             =   255
         Width           =   2415
      End
      Begin VB.Label Label1 
         Caption         =   "Tipo Usuario"
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
         Height          =   240
         Left            =   375
         TabIndex        =   7
         Top             =   285
         Width           =   1260
      End
   End
   Begin VB.Frame Frm_detalle 
      Height          =   1365
      Left            =   30
      TabIndex        =   8
      Top             =   1155
      Width           =   6405
      Begin BACControles.TXTNumero TxtLargoClave 
         Height          =   330
         Left            =   1560
         TabIndex        =   3
         Top             =   930
         Width           =   720
         _ExtentX        =   1270
         _ExtentY        =   582
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
         Text            =   "0"
         Text            =   "0"
         Min             =   "0"
         Max             =   "9"
      End
      Begin BACControles.TXTNumero TxtDiasExpiracion 
         Height          =   315
         Left            =   5580
         TabIndex        =   4
         Top             =   945
         Width           =   735
         _ExtentX        =   1296
         _ExtentY        =   556
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
         Text            =   "0"
         Text            =   "0"
         Max             =   "99999"
         Separator       =   -1  'True
      End
      Begin VB.ComboBox CmbTipoClave 
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
         Left            =   1560
         Style           =   2  'Dropdown List
         TabIndex        =   2
         Top             =   600
         Width           =   2340
      End
      Begin VB.TextBox Txt_descripcion 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   310
         Left            =   1575
         TabIndex        =   1
         Top             =   270
         Width           =   4755
      End
      Begin VB.Label Label6 
         Caption         =   "Tipo de Clave"
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
         Height          =   225
         Left            =   255
         TabIndex        =   13
         Top             =   645
         Width           =   1320
      End
      Begin VB.Label Label4 
         Caption         =   "Largo Clave"
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
         Height          =   240
         Left            =   390
         TabIndex        =   12
         Top             =   960
         Width           =   2145
      End
      Begin VB.Label Label3 
         Caption         =   "Dias de Expiración"
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
         Height          =   315
         Left            =   3945
         TabIndex        =   11
         Top             =   990
         Width           =   1620
      End
      Begin VB.Label Label2 
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
         Height          =   240
         Left            =   420
         TabIndex        =   9
         Top             =   315
         Width           =   1050
      End
   End
   Begin Threed.SSPanel SSPanel1 
      Height          =   2085
      Left            =   0
      TabIndex        =   14
      Top             =   480
      Width           =   6495
      _Version        =   65536
      _ExtentX        =   11456
      _ExtentY        =   3678
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
      BevelOuter      =   1
   End
   Begin VB.Label Label5 
      AutoSize        =   -1  'True
      Caption         =   "Fecha Expiración"
      Height          =   195
      Left            =   0
      TabIndex        =   10
      Top             =   0
      Width           =   1230
   End
End
Attribute VB_Name = "Crea_Tipos_Usuarios"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim OptLocal As String
Dim existen_usuarios As Boolean

Function FUNC_BORRA_TIPO_USUARIO() As Boolean

   FUNC_BORRA_TIPO_USUARIO = False
   Envia = Array("E", Cmb_tipo_usuario.Text, "", "", 0, 0)
   
   If Not BAC_SQL_EXECUTE("SP_GRABA_TIPOS_USUARIO ", Envia) Then
      Call LogAuditoria("03", OptLocal, Me.Caption & " Error al Eliminar- Tipo Usuario: " & Cmb_tipo_usuario.Text & " Descripcion: " & Txt_descripcion.Text & " Tipo de Clave: " & left(CmbTipoClave.Text, 1), "", "")
      Exit Function
   End If
   
   Call LogAuditoria("03", OptLocal, Me.Caption, "Tipo Usuario: " & Cmb_tipo_usuario.Text & " Descripcion: " & Txt_descripcion.Text & " Tipo de Clave: " & left(CmbTipoClave.Text, 1), "")
   FUNC_BORRA_TIPO_USUARIO = True

End Function

Function FUNC_GRABA_TIPO_USUARIO() As Boolean

   FUNC_GRABA_TIPO_USUARIO = False
   Envia = Array("G", Cmb_tipo_usuario.Text, Txt_descripcion.Text, left(CmbTipoClave.Text, 1), _
               TxtLargoClave.Text, CDbl(TxtDiasExpiracion.Text))
   
   If Not BAC_SQL_EXECUTE("SP_GRABA_TIPOS_USUARIO ", Envia) Then
      Call LogAuditoria("01", OptLocal, Me.Caption & " Error al grabar- Tipo Usuario: " & Cmb_tipo_usuario.Text & " Descripcion: " & Txt_descripcion.Text & " Tipo de Clave: " & left(CmbTipoClave.Text, 1), "", "")
      Exit Function
   End If
   
   Call LogAuditoria("01", OptLocal, Me.Caption, "", "Tipo Usuario: " & Cmb_tipo_usuario.Text & " Descripcion: " & Txt_descripcion.Text & " Tipo de Clave: " & left(CmbTipoClave.Text, 1))
   
   FUNC_GRABA_TIPO_USUARIO = True

End Function

Private Function PROC_BUSCA_TIPO_USUARIO() As Boolean
Dim Datos()
   PROC_BUSCA_TIPO_USUARIO = True
   Envia = Array("B", Cmb_tipo_usuario.Text, "", "", 0, 0)
   
   If Not BAC_SQL_EXECUTE("SP_GRABA_TIPOS_USUARIO ", Envia) Then Exit Function
   
   If BAC_SQL_FETCH(Datos) Then
      If Datos(1) = "NO ACTIVO" Then
         MsgBox Datos(2), vbInformation
         PROC_BUSCA_TIPO_USUARIO = False
         Exit Function
      End If
      
      Txt_descripcion.Text = Datos(1)
      existen_usuarios = IIf(Datos(2) = "S", True, False)
      
      Select Case Datos(3)
      
         Case "A"
      
               CmbTipoClave.Text = "ALFANUMERICO"
      
         Case "C"
         
               CmbTipoClave.Text = "CARACTER"
         
         Case "N"
      
               CmbTipoClave.Text = "NUMERICO"
      
      End Select
      
      TxtLargoClave.Text = Datos(4)
      TxtDiasExpiracion.Text = Datos(5)
      
      Tool_opciones.Buttons(3).Enabled = True
   
   End If

End Function

Sub PROC_LIMPIA()

existen_usuarios = False

PROC_CARGA_TIPO_USUARIO Cmb_tipo_usuario

Txt_descripcion.Text = ""

Frm_tipo_usuario.Enabled = True
frm_detalle.Enabled = False
Tool_opciones.Buttons(2).Enabled = False
Tool_opciones.Buttons(3).Enabled = False
Tool_opciones.Buttons(4).Enabled = True
CmbTipoClave.ListIndex = -1
TxtLargoClave.Text = ""
TxtDiasExpiracion.Text = ""

End Sub

Private Sub Cmb_tipo_usuario_KeyDown(KeyCode As Integer, Shift As Integer)
'If KeyCode = 13 Then
'   If Trim(Cmb_tipo_usuario.Text) <> "" Then Cmb_tipo_usuario_KeyPress 13
'End If
End Sub


Private Sub Cmb_tipo_usuario_KeyPress(KeyAscii As Integer)

KeyAscii = LETRA_UPPER(KeyAscii)

If Len(Cmb_tipo_usuario.Text) > 14 Then
   If KeyAscii <> 8 And KeyAscii <> 13 Then KeyAscii = 0
End If

If KeyAscii = 13 And Trim(Cmb_tipo_usuario.Text) <> "" Then

   If Not PROC_BUSCA_TIPO_USUARIO Then
      Me.Cmb_tipo_usuario.Text = ""
      Me.Cmb_tipo_usuario.SetFocus
      Exit Sub
   End If

   
   Frm_tipo_usuario.Enabled = False
   frm_detalle.Enabled = True
   Tool_opciones.Buttons(2).Enabled = True
   Tool_opciones.Buttons(4).Enabled = False
      
   Txt_descripcion.SetFocus

End If

End Sub


Private Sub Cmb_tipo_usuario_LostFocus()
   Cmb_tipo_usuario_KeyPress vbKeyReturn
End Sub


Private Sub CmbTipoClave_KeyPress(KeyAscii As Integer)

   Select Case KeyAscii
   
      Case 13
      
            TxtLargoClave.SetFocus
      
   End Select

End Sub

Private Sub Form_Activate()
   PROC_CARGA_AYUDA Me, ""
End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)

   Select Case KeyAscii
   Case vbKeyLimpiar
      If Tool_opciones.Buttons(1).Enabled Then
         Call Tool_opciones_ButtonClick(Tool_opciones.Buttons(1))

      End If

   Case vbKeyGrabar
      If Tool_opciones.Buttons(2).Enabled Then
         Call Tool_opciones_ButtonClick(Tool_opciones.Buttons(2))

      End If

   Case vbKeyEliminar
      If Tool_opciones.Buttons(3).Enabled Then
         Call Tool_opciones_ButtonClick(Tool_opciones.Buttons(3))

      End If
   
   Case vbKeyBuscar
      If Tool_opciones.Buttons(4).Enabled Then
         Call Tool_opciones_ButtonClick(Tool_opciones.Buttons(4))

      End If


   Case vbKeySalir
      Unload Me

   End Select

End Sub

Private Sub Form_Load()
OptLocal = Opt
Me.top = 0
Me.left = 0
CmbTipoClave.AddItem "ALFANUMERICO"
CmbTipoClave.AddItem "CARACTER"
CmbTipoClave.AddItem "NUMERICO"
PROC_LIMPIA

Me.Caption = Crea_Tipos_Usuarios.Caption
Call LogAuditoria("07", OptLocal, Me.Caption, "", "")
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Call LogAuditoria("08", OptLocal, Me.Caption, "", "")
End Sub

Private Sub Tool_opciones_ButtonClick(ByVal Button As MSComctlLib.Button)

If Button.Index = 2 Then
   If MsgBox("Seguro de Grabar ?", 36) <> vbYes Then Exit Sub

   If Not FUNC_GRABA_TIPO_USUARIO() Then
   
      MsgBox "Problemas al Grabar", vbExclamation
      Exit Sub
      
   End If

   MsgBox "Grabación Completada con Exito", vbInformation
End If

If Button.Index = 3 Then

   If existen_usuarios Then
      MsgBox "NO Puede Borrar el Tipo de Usuario, ya que tiene Usuarios Relacionados.", vbExclamation
      Exit Sub
   End If

   If MsgBox("Seguro de Borrar ?", vbYesNo + vbInformation) <> vbYes Then Exit Sub

   If Not FUNC_BORRA_TIPO_USUARIO() Then
   
      MsgBox "Problemas Al Eliminar", vbExclamation
      Exit Sub
      
   End If
   
   MsgBox "Eliminación Completada con Exito", vbInformation

End If

If Button.Index = 4 Then
    
   Cmb_tipo_usuario_KeyPress vbKeyReturn
   Exit Sub
   
End If

If Button.Index = 5 Then
    Unload Me
    Exit Sub
End If

PROC_LIMPIA
   
Cmb_tipo_usuario.SetFocus

End Sub

Private Sub Txt_descripcion_KeyPress(KeyAscii As Integer)

Txt_descripcion.MaxLength = 40

KeyAscii = LETRA_UPPER(KeyAscii)

   If KeyAscii = 13 Then
   
      CmbTipoClave.SetFocus
   
   End If

End Sub

Private Sub TxtDiasExpiracion_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = 13 Then
   Me.Txt_descripcion.SetFocus
End If
End Sub

Private Sub TxtDiasExpiracion_KeyPress(KeyAscii As Integer)


'   Select Case KeyAscii
'
'      Case 13
'
'            If MsgBox("Seguro de Grabar ?", 36) <> vbYes Then Exit Sub
'
'            If Not FUNC_GRABA_TIPO_USUARIO() Then
'
'               MsgBox "Problemas al Grabar", vbExclamation
'               Exit Sub
'
'            End If
'
'            MsgBox "Grabación Realizada con Exito", vbInformation
'
'            PROC_LIMPIA
'
'            Cmb_tipo_usuario.SetFocus
'
'   End Select

End Sub

Private Sub TxtLargoClave_KeyPress(KeyAscii As Integer)

   Select Case KeyAscii

      Case 13
      
            TxtDiasExpiracion.SetFocus

   End Select

End Sub

