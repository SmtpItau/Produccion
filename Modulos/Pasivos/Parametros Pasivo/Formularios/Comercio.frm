VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "threed32.ocx"
Begin VB.Form BacMntComercioConcepto 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Mantención de Códigos de Comercio y Conceptos"
   ClientHeight    =   3090
   ClientLeft      =   3195
   ClientTop       =   3075
   ClientWidth     =   6810
   FillStyle       =   0  'Solid
   Icon            =   "Comercio.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   3090
   ScaleWidth      =   6810
   ShowInTaskbar   =   0   'False
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   450
      Left            =   0
      TabIndex        =   6
      Top             =   0
      Width           =   6810
      _ExtentX        =   12012
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
            Key             =   "Limpiar"
            Object.ToolTipText     =   "Limpiar"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Grabar"
            Object.ToolTipText     =   "Grabar"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Eliminar"
            Object.ToolTipText     =   "Eliminar"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Buscar"
            Object.ToolTipText     =   "Buscar"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "Salir"
            Object.ToolTipText     =   "Salir"
            ImageIndex      =   2
         EndProperty
      EndProperty
   End
   Begin Threed.SSFrame fraComercioConcepto 
      Height          =   2640
      Left            =   0
      TabIndex        =   7
      Top             =   450
      Width           =   6810
      _Version        =   65536
      _ExtentX        =   12012
      _ExtentY        =   4657
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
      Begin VB.ComboBox cmbCodigoOMA 
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
         Left            =   2055
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   3
         Top             =   1440
         Width           =   4605
      End
      Begin VB.ComboBox cmbDocumento 
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
         Left            =   2055
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   2
         Top             =   1110
         Width           =   3330
      End
      Begin VB.ListBox lstLista 
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   540
         Left            =   -15
         TabIndex        =   8
         Top             =   4440
         Width           =   6885
      End
      Begin VB.TextBox txtGlosa 
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
         Left            =   2055
         MaxLength       =   60
         TabIndex        =   1
         Top             =   480
         Width           =   4600
      End
      Begin VB.TextBox txtComercio 
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
         Height          =   330
         Left            =   2055
         MaxLength       =   6
         MouseIcon       =   "Comercio.frx":2EFA
         MousePointer    =   99  'Custom
         TabIndex        =   0
         Top             =   135
         Width           =   1215
      End
      Begin VB.Frame Frame1 
         Height          =   90
         Left            =   2115
         TabIndex        =   9
         Top             =   870
         Width           =   4650
      End
      Begin VB.TextBox TxtCodValidacion 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   345
         Left            =   2055
         MaxLength       =   100
         TabIndex        =   5
         Top             =   2130
         Width           =   4590
      End
      Begin VB.TextBox TxtTipReg 
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
         Left            =   2055
         MaxLength       =   3
         TabIndex        =   4
         Top             =   1785
         Width           =   1170
      End
      Begin VB.Label Label 
         Caption         =   " Codigo OMA"
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
         Index           =   4
         Left            =   45
         TabIndex        =   16
         Top             =   1470
         Width           =   1995
      End
      Begin VB.Label Label1 
         Caption         =   "Relacionada con ..."
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
         Height          =   330
         Left            =   120
         TabIndex        =   15
         Top             =   825
         Width           =   1695
      End
      Begin VB.Label Label 
         Caption         =   " Tipo de Documento"
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
         Index           =   3
         Left            =   30
         TabIndex        =   14
         Top             =   1170
         Width           =   1995
      End
      Begin VB.Label Label 
         Caption         =   " Descripción"
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
         Index           =   2
         Left            =   60
         TabIndex        =   13
         Top             =   510
         Width           =   1995
      End
      Begin VB.Label Label 
         Caption         =   " Código de Comercio "
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
         Index           =   0
         Left            =   60
         TabIndex        =   12
         Top             =   180
         Width           =   1995
      End
      Begin VB.Label Label3 
         Caption         =   "Tipo Registro"
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
         Height          =   300
         Left            =   105
         TabIndex        =   11
         Top             =   1845
         Width           =   1830
      End
      Begin VB.Label Label4 
         Caption         =   "Codigo Validacion"
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
         Height          =   300
         Left            =   105
         TabIndex        =   10
         Top             =   2205
         Width           =   1830
      End
   End
   Begin MSComctlLib.ImageList Img_opciones 
      Left            =   0
      Top             =   0
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
            Picture         =   "Comercio.frx":3204
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Comercio.frx":366B
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Comercio.frx":3B61
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Comercio.frx":3FF4
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Comercio.frx":44DC
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Comercio.frx":49EF
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Comercio.frx":4EC2
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Comercio.frx":5388
            Key             =   ""
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Comercio.frx":587F
            Key             =   ""
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Comercio.frx":5C78
            Key             =   ""
         EndProperty
      EndProperty
   End
End
Attribute VB_Name = "BacMntComercioConcepto"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim OptLocal      As String
Dim nEstado       As Integer
Dim cEstado       As String
Dim xLine         As String
Dim xStr          As String
Dim i             As Integer
Dim Sql           As String
Dim Datos()

Private Function FUNC_Validacion() As Boolean

   Dim sCadena          As String

   sCadena = ""

   If left(cmbDocumento, 1) = "" Then
      sCadena = sCadena & "- Falta seleccionar el código del documento." & vbCrLf

   End If

   If left(cmbCodigoOMA, 3) = "" Then
      sCadena = sCadena & "- Falta seleccionar el código OMA." & vbCrLf

   End If

   If TxtGlosa.Text = "" Then
      sCadena = sCadena & "- Falta ingresar la glosa." & vbCrLf

   End If

   FUNC_Validacion = (sCadena = "")

   If Not FUNC_Validacion Then
      sCadena = "FALTAN INGRESAR LOS SIGUIENTES DATOS" & vbCrLf & vbCrLf & sCadena
      MsgBox sCadena, vbExclamation, Me.Caption

   End If

End Function

Private Sub PROC_Carga()

   i = Me.MousePointer
   Me.MousePointer = 11

   Envia = Array()
   AddParam Envia, ""

   If Not BAC_SQL_EXECUTE("sp_leer_codigos_comercio", Envia) Then
      Me.MousePointer = i
      Exit Sub

   End If

   lstLista.Clear

   Do While BAC_SQL_FETCH(Datos())
      xStr = Datos(1): xLine = BacPad(xStr, 6)
      xStr = Datos(2): xLine = xLine & " / " & BacPad(xStr, 3)
      xLine = xLine & " " & Datos(4)
      lstLista.AddItem xLine

   Loop

   lstLista.AddItem "<< Agregar >>"

   Me.MousePointer = i

End Sub

Private Sub cmbCodigoOMA_KeyPress(KeyAscii As Integer)

   If KeyAscii = vbKeyReturn Then
      TxtTipReg.SetFocus

   End If

End Sub

Private Sub cmbDocumento_Click()

   Call Carga_Listas(left(cmbDocumento, 1) & "OPERACIONESXDOCUMENTO", cmbCodigoOMA)

End Sub

Private Sub cmbDocumento_KeyPress(KeyAscii As Integer)

   If KeyAscii = vbKeyReturn Then
      cmbCodigoOMA.SetFocus

   End If

End Sub

Private Sub Form_Activate()
   PROC_CARGA_AYUDA Me, " "
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
   Dim iOpcion          As Integer

   If KeyCode <> vbKeyControl And (Shift = 2 Or (Shift = 0 And (KeyCode = vbKeyReturn Or KeyCode = vbKeyEscape Or (KeyCode >= vbKeyF1 And KeyCode <= vbKeyF12)))) Then
      iOpcion = 0

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

      End If

   End If

End Sub

Private Sub Form_Load()

   OptLocal = Opt
   Me.top = 0
   Me.left = 0

   top = 1
   left = 15
   txtComercio.Text = ""
   TxtGlosa.Text = ""
   txtComercio.Enabled = True
   TxtGlosa.Enabled = Not txtComercio.Enabled
   cmbDocumento.Enabled = Not txtComercio.Enabled
   cmbCodigoOMA.Enabled = Not txtComercio.Enabled
   Me.TxtCodValidacion.Enabled = Not txtComercio.Enabled
   Me.TxtTipReg.Enabled = Not txtComercio.Enabled

   Call Carga_Listas("TIPODOCUMENTO", cmbDocumento)

   If cmbDocumento.ListCount - 1 >= 0 Then
      Call Carga_Listas(left(cmbDocumento, 1) & "OPERACIONESXDOCUMENTO", cmbCodigoOMA)

   Else
      Call Carga_Listas("CODIGOSOMA", cmbCodigoOMA)

   End If

   Toolbar1.Buttons(2).Enabled = False
   Toolbar1.Buttons(3).Enabled = False
   Toolbar1.Buttons(4).Enabled = False

   Call LogAuditoria("07", OptLocal, Me.Caption, "", "")

   Call PROC_LIMPIAR

End Sub

Private Sub Form_Unload(Cancel As Integer)

   Call LogAuditoria("08", OptLocal, Me.Caption, "", "")

End Sub

Private Sub lstLista_DblClick()

   If lstLista.ListIndex < 0 Then
      Exit Sub

   End If

   Toolbar1.Buttons(3).Enabled = True

   If left(lstLista.List(lstLista.ListIndex), 2) = "<<" Then
      Call Toolbar1_ButtonClick(Toolbar1.Buttons(1))
      Toolbar1.Buttons(3).Enabled = True

   Else
      xLine = lstLista.List(lstLista.ListIndex)
      txtComercio.Text = left(xLine, 6)
      TxtGlosa.Text = Trim(Mid(xLine, 14, 70))
      Toolbar1.Buttons(1).Enabled = True

   End If

   txtComercio.Enabled = Toolbar1.Buttons(3).Enabled
   TxtGlosa.Enabled = Toolbar1.Buttons(3).Enabled

   If txtComercio.Enabled = True Then
      txtComercio.SetFocus

   End If

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)

   Select Case Trim(UCase(Button.Key))
   Case "LIMPIAR"
      Call PROC_LIMPIAR
      Me.txtComercio.SetFocus

   Case "GRABAR"
      If Not FUNC_Validacion() Then
         Exit Sub

      End If

      Envia = Array()
      AddParam Envia, txtComercio
      AddParam Envia, TxtGlosa.Text
      AddParam Envia, CDbl(left(cmbDocumento, 1))
      AddParam Envia, CDbl(left(cmbCodigoOMA, 3))
      AddParam Envia, TxtTipReg.Text
      AddParam Envia, TxtCodValidacion.Text

      If BAC_SQL_EXECUTE("sp_Graba_Codigo_Comercio", Envia) Then
         MsgBox "Información Grabada", vbInformation
         Call LogAuditoria("01", OptLocal, Me.Caption, "", "Codigo Comercio: " & txtComercio.Text & " Tipo Documento: " & cmbDocumento.Text & " Codigo OMA: " & cmbCodigoOMA.Text & " Tipo Registro: " & TxtTipReg.Text)
         Call PROC_Carga
         Call PROC_LIMPIAR
         Me.txtComercio.SetFocus

      Else
         MsgBox "No se Puede Grabar", vbCritical
         Call LogAuditoria("01", OptLocal, Me.Caption & " Error al grabar- Codigo Comercio: " & txtComercio.Text & " Tipo Documento: " & cmbDocumento.Text & " Codigo OMA: " & cmbCodigoOMA.Text & " Tipo Registro: " & TxtTipReg.Text, "", "")

      End If

   Case "ELIMINAR"
      If MsgBox("¿ Seguro de Eliminar ?", vbQuestion + vbYesNo) Then
         nEstado = -1
         cEstado = "No se puede Eliminar este Código de Comercio y Concepto"

         Envia = Array()
         AddParam Envia, txtComercio
         AddParam Envia, "N"

         If BAC_SQL_EXECUTE("sp_Borrar_Codigo_Comercio ", Envia) Then
            nEstado = 0

         End If

         If BAC_SQL_FETCH(Datos()) Then
            nEstado = Datos(1)
            cEstado = Datos(2)

         End If

         If nEstado = -1 Then
            MsgBox Datos(2), vbExclamation
         
         Else
            MsgBox "Eliminación realizada con éxito", vbOKOnly + vbInformation

         End If


         Call LogAuditoria("03", OptLocal, Me.Caption, "", "Codigo Comercio: " & txtComercio.Text & " Tipo Documento: " & cmbDocumento.Text & " Codigo OMA: " & cmbCodigoOMA.Text & " Tipo Registro: " & TxtTipReg.Text)

         txtComercio.Text = ""
         TxtGlosa.Text = ""
         TxtCodValidacion.Text = ""
         TxtTipReg.Text = ""
         txtComercio.Enabled = True
         TxtGlosa.Enabled = Not txtComercio.Enabled
         cmbDocumento.Enabled = Not txtComercio.Enabled
         cmbCodigoOMA.Enabled = Not txtComercio.Enabled
         Me.TxtCodValidacion.Enabled = Not txtComercio.Enabled
         Me.TxtTipReg.Enabled = Not txtComercio.Enabled

         Call Carga_Listas("TIPODOCUMENTO", cmbDocumento)

         Toolbar1.Buttons(3).Enabled = False
         Call PROC_LIMPIAR
         Me.txtComercio.SetFocus

      End If

   Case "BUSCAR"
      txtComercio_LostFocus

   Case "SALIR"
      Unload Me

   End Select

End Sub

Private Sub TxtCodigoPlanilla_KeyPress(KeyAscii As Integer)

   If KeyAscii = vbKeyReturn Then
      Me.TxtTipReg.SetFocus

   End If

End Sub

Private Sub TxtCodValidacion_KeyPress(KeyAscii As Integer)

   If KeyAscii = vbKeyReturn Then
      Me.TxtGlosa.SetFocus

   Else
      KeyAscii = Caracter(KeyAscii)
      Call BacToUCase(KeyAscii)

   End If

End Sub

Private Sub txtComercio_Change()

   Toolbar1.Buttons(4).Enabled = (txtComercio.Text <> "")

   If Len(Trim(txtComercio.Text)) > 0 Then
      TxtGlosa.Enabled = True

   Else
      TxtGlosa.Enabled = False

   End If

   cmbDocumento.Enabled = TxtGlosa.Enabled
   cmbCodigoOMA.Enabled = TxtGlosa.Enabled
   TxtCodValidacion.Enabled = TxtGlosa.Enabled
   TxtTipReg.Enabled = TxtGlosa.Enabled

End Sub

Private Sub txtComercio_DblClick()

   BacControlWindows 100
   MiTag = "tbCodigosComercio"
   BacAyuda.Show 1

   If giAceptar% = True Then
      txtComercio.Text = gsCodigo$
      TxtGlosa.Text = gsGlosa$
      bacBuscarCombo cmbDocumento, Val(gsValor)
      TxtGlosa.SetFocus

   End If

End Sub

Private Sub txtComercio_KeyDown(KeyCode As Integer, Shift As Integer)

   If KeyCode = vbKeyF3 Then
      txtComercio_DblClick

   End If

End Sub

Private Sub txtComercio_KeyPress(KeyAscii As Integer)

   If KeyAscii = 8 Then
      Exit Sub
   
   End If

   If KeyAscii = vbKeyReturn And txtComercio.Text <> "" Then
      txtComercio_LostFocus
      Txtglosa_KeyPress (KeyAscii)
      TxtGlosa.SetFocus

      If Me.TxtGlosa.Text <> "" Then
         Me.Toolbar1.Buttons(4).Enabled = True

      End If

   ElseIf InStr("0123456789Kk", Chr(KeyAscii)) = 0 Then
      KeyAscii = 0

   ElseIf KeyAscii <> 8 Then
      KeyAscii = Asc(UCase(Chr(KeyAscii)))

   End If

End Sub

Private Sub txtComercio_LostFocus()

   If Trim(txtComercio.Text) = "" Then
      Exit Sub

   End If

   Envia = Array()
   AddParam Envia, txtComercio

   If Not BAC_SQL_EXECUTE("sp_leer_codigos_comercio", Envia) Then
      txtComercio.Text = BacPad(Trim(txtComercio.Text), 6, "L")

   End If

   If BAC_SQL_FETCH(Datos()) Then
      TxtGlosa = Datos(2)
      bacBuscarCombo cmbDocumento, Datos(3)
      bacBuscarCombo cmbCodigoOMA, Datos(4)
      TxtTipReg = Datos(5)
      TxtCodValidacion = Datos(6)
      TxtGlosa.SetFocus
      Toolbar1.Buttons(2).Enabled = True
      Toolbar1.Buttons(3).Enabled = True

   Else
      Toolbar1.Buttons(2).Enabled = True
      Toolbar1.Buttons(3).Enabled = False
      'txtGlosa.SetFocus

   End If

   txtComercio.Enabled = False
   Toolbar1.Buttons(4).Enabled = False

End Sub

Private Sub Txtglosa_KeyPress(KeyAscii As Integer)

   If KeyAscii = vbKeyReturn Then
      cmbDocumento.SetFocus

   ElseIf KeyAscii <> 8 Then
      KeyAscii = Caracter(KeyAscii)
      Call BacToUCase(KeyAscii)

   End If

End Sub

Private Sub PROC_LIMPIAR()

   txtComercio.Text = ""
   TxtGlosa.Text = ""
   TxtCodValidacion = ""
   TxtTipReg = ""
   txtComercio.Enabled = True
   TxtGlosa.Enabled = Not txtComercio.Enabled
   cmbDocumento.Enabled = Not txtComercio.Enabled
   cmbCodigoOMA.Enabled = Not txtComercio.Enabled
   Me.TxtCodValidacion.Enabled = Not txtComercio.Enabled
   Me.TxtTipReg.Enabled = Not txtComercio.Enabled
   txtComercio.Enabled = True

   Call Carga_Listas("TIPODOCUMENTO", cmbDocumento)

   cmbDocumento.ListIndex = -1
   cmbCodigoOMA.ListIndex = -1

   Toolbar1.Buttons(3).Enabled = False
   Toolbar1.Buttons(2).Enabled = False

End Sub

Private Sub TxtTipReg_KeyPress(KeyAscii As Integer)

   KeyAscii = Caracter(KeyAscii)
   Call BacToUCase(KeyAscii)

   If KeyAscii = vbKeyReturn Then
      Me.TxtCodValidacion.SetFocus

   End If

End Sub
